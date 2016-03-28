<?php foreach($this->getRecentComments() as $comment): ?>
<div class="author">
<?php echo $comment->author->username; ?> added a comment.
</div>
<div class="issue">
<?php echo CHtml::link(CHtml::encode($comment->issue->name),
array('issue/view', 'id'=>$comment->issue->id)); ?>
<br>
<?php echo CHtml::encode($comment->content); ?>
</div>
<?php endforeach; ?>