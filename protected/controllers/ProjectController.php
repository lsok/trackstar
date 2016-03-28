<?php

class ProjectController extends Controller
{
	/**
	 * @var string the default layout for the views. Defaults to '//layouts/column2', meaning
	 * using two-column layout. See 'protected/views/layouts/column2.php'.
	 */
	public $layout='//layouts/column2';

	/**
	 * @return array action filters
	 */
	public function filters()
	{
		return array(
			'accessControl', // perform access control for CRUD operations
			'postOnly + delete', // we only allow deletion via POST request
			array(
				//对 view 项目详情页使用页面缓存
				'COutputCache + view',
				'duration'=>120,
				'varyByParam'=>array('id'),
				),
		);
	}

	/**
	 * Specifies the access control rules.
	 * This method is used by the 'accessControl' filter.
	 * @return array access control rules
	 */
	public function accessRules()
	{
		return array(
			array('allow',  // allow all users to perform 'index' and 'view' actions
				'actions'=>array('index','view','adduser'),
				'users'=>array('@'),
			),
			array('allow', // allow authenticated user to perform 'create' and 'update' actions
				'actions'=>array('create','update'),
				'users'=>array('@'),
			),
			array('allow', // allow admin user to perform 'admin' and 'delete' actions
				'actions'=>array('admin','delete'),
				'users'=>array('admin'),
			),
			array('deny',  // deny all users
				'users'=>array('*'),
			),
		);
	}

	/**
	 * Displays a particular model.
	 * @param integer $id the ID of the model to be displayed
	 */
	public function actionView()
	{
		$id=$_GET['id'];
		
		$issueDataProvider=new CActiveDataProvider('Issue', array(
			'criteria'=>array(
				'condition'=>'project_id=:projectId',
				'params'=>array(':projectId'=>$this->loadModel($id)->id),
			),
			'pagination'=>array('pageSize'=>3),
		));
		
		// 在视图文件 <head> 区域添加评论的rss代码(在某些浏览器地址栏中会显示RSS图标)
		Yii::app()->clientScript->registerLinkTag('alternate', 'application/rss+xml', $this->createUrl('comment/feed', array('pid'=>$this->loadModel($id)->id)));
		
		$this->render('view',array(
			'model'=>$this->loadModel($id),
			'issueDataProvider'=>$issueDataProvider,
		));
	}

	/**
	 * Creates a new model.
	 * If creation is successful, the browser will be redirected to the 'view' page.
	 */
	public function actionCreate()
	{
		$model=new Project;

		// Uncomment the following line if AJAX validation is needed
		// $this->performAjaxValidation($model);

		if(isset($_POST['Project']))
		{
			$model->attributes=$_POST['Project'];
			if($model->save())
				$this->redirect(array('view','id'=>$model->id));
		}

		$this->render('create',array(
			'model'=>$model,
		));
	}

	/**
	 * Updates a particular model.
	 * If update is successful, the browser will be redirected to the 'view' page.
	 * @param integer $id the ID of the model to be updated
	 */
	public function actionUpdate($id)
	{
		$model=$this->loadModel($id);

		// Uncomment the following line if AJAX validation is needed
		// $this->performAjaxValidation($model);

		if(isset($_POST['Project']))
		{
			$model->attributes=$_POST['Project'];
			if($model->save())
				$this->redirect(array('view','id'=>$model->id));
		}

		$this->render('update',array(
			'model'=>$model,
		));
	}

	/**
	 * Deletes a particular model.
	 * If deletion is successful, the browser will be redirected to the 'admin' page.
	 * @param integer $id the ID of the model to be deleted
	 */
	public function actionDelete($id)
	{
		$this->loadModel($id)->delete();

		// if AJAX request (triggered by deletion via admin grid view), we should not redirect the browser
		if(!isset($_GET['ajax']))
			$this->redirect(isset($_POST['returnUrl']) ? $_POST['returnUrl'] : array('admin'));
	}

	/**
	 * Lists all models.
	 */
	public function actionIndex()
	{
		$dataProvider=new CActiveDataProvider('Project');
		
		// 在视图文件 <head> 区域添加评论的rss代码(在某些浏览器地址栏中会显示RSS图标)
		Yii::app()->clientScript->registerLinkTag('alternate', 'application/rss+xml', $this->createUrl('comment/feed'));
		
		//根据 update_time 列检索最新系统消息
		$sysMessage = SysMessage::getLatest();
		
		if($sysMessage != null)
			$message = $sysMessage->message;
		else
			$message = null;
		
		
		// 设置页面元标签
		$this->pageTitle_cn='这是项目列表页的中文title';
		$this->pageTitle_en='This is english title of the project index page';

		$this->render('index',array(
			'dataProvider'=>$dataProvider,
			'sysMessage'=>$message,
		));
	}

	/**
	 * Manages all models.
	 */
	public function actionAdmin()
	{
		$model=new Project('search');
		$model->unsetAttributes();  // clear any default values
		if(isset($_GET['Project']))
			$model->attributes=$_GET['Project'];

		$this->render('admin',array(
			'model'=>$model,
		));
	}

	/**
	 * Returns the data model based on the primary key given in the GET variable.
	 * If the data model is not found, an HTTP exception will be raised.
	 * @param integer $id the ID of the model to be loaded
	 * @return Project the loaded model
	 * @throws CHttpException
	 */
	public function loadModel($id)
	{
		$model=Project::model()->findByPk($id);
		if($model===null)
			throw new CHttpException(404, 'The requested page does not exist.');
		return $model;
	}

	/**
	 * Performs the AJAX validation.
	 * @param Project $model the model to be validated
	 */
	protected function performAjaxValidation($model)
	{
		if(isset($_POST['ajax']) && $_POST['ajax']==='project-form')
		{
			echo CActiveForm::validate($model);
			Yii::app()->end();
		}
	}
	
	public function actionAdduser($id)
	{
		$form=new ProjectUserForm;
		$project = $this->loadModel($id);
		
		// collect user input data
		if(isset($_POST['ProjectUserForm']))
		{
			$form->attributes=$_POST['ProjectUserForm'];
			$form->project = $project;
		
			// validate user input and set a successfull flash message if valid
			if($form->validate())
			{
				Yii::app()->user->setFlash('success', $form->username . " has been added to the project.");
				$form=new ProjectUserForm;
			}
		}
		
		// display the add user form
		$users = User::model()->findAll();
		$usernames=array();
		foreach($users as $user)
		{
			$usernames[]=$user->username;
		}
		
		$form->project = $project;
		
		$this->render('adduser', array('model'=>$form, 'usernames'=>$usernames));
	}
}
