<?php
/* @var $this ProjectController */
/* @var $dataProvider CActiveDataProvider */

$this->pageTitle=$this->pageTitle_cn;

$this->breadcrumbs=array(
	'项目',
);

$this->menu=array(
	array('label'=>'创建项目', 'url'=>array('create')),
	array('label'=>'管理项目', 'url'=>array('admin')),
);
?>

<h1>项目列表</h1>

<?php $this->widget('zii.widgets.CListView', array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>

<?php 
$this->beginWidget('zii.widgets.CPortlet', array(
	'title'=>'Recent Comments',
	));
	$this->widget('RecentComments');
	$this->endWidget();
?>
