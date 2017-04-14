$(document).ready(function(){

	$('.link').on('click', function(e){
		var target = $(e.target).parent().siblings().last()
		var num = parseInt(target.text()) + 1
		//target.text is the click counter number
		target.text(num)
	})

	$('form').submit(function(event){
		event.preventDefault();
		//to prevent it form going to sever to find normal routes
		$.ajax({
			url: '/urls',
			method: 'post',
			data: $(this).serialize(), //to pass the input text bos to ajax, to pass the form
			dataType: 'json', //what is the datatype am i getting back, to get back as a json format, ruby hash in js is called json from static.rb
			//callbacks	
			beforeSend: function(){
				$('form input').val('Loading..');
				//$('form input').attr('Loading..'); ==> jQuerydisable button
				//loading.io
				//display block to display hidden in CSS
			},
			// success
			complete: function(){
				$('form input').val('DONE!');
			},

			success: function(data){
				$('tr:first-child').after('<tr> <td> <a href=' + data.short_url + '>'+ data.short_url +'</a> </td> <td>' + data.long_url +'</td> <td>' + data.click_count + '</td> </tr>')
				//alert('yayyyy');
				//console.log(data)
			},

			error: function(data){
				alert('OPPS ERROR! Invalid url or url existed');
				//$('#flash').html(data.responseText);
			}
		})
	})



})