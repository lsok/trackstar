<?php

class AdminModule extends CWebModule
{
	public function init()
	{
		// this method is called when the module is being created
		// you may place code here to customize the module or the application

		// import the module-level models and components
		$this->setImport(array(
			'admin.models.*',
			'admin.components.*',
		));			
	}

	public function beforeControllerAction($controller, $action)
	{	
		//为模块使用自己的布局文件(即使用模块自身文件夹内的layout)
		$controller->layout='column2';
		
		if(parent::beforeControllerAction($controller, $action))
		{
			// this method is called before any module controller action is performed
			// you may place customized code here
			if(!Yii::app()->authManager->checkAccess("admin", Yii::app()->user->id))
			{
				throw new CHttpException(403, 'you are not authorized to perform this action.');
			}
			else
			{
				return true;
			}
		}
		else
			return false;
	}
}
