abstract class SocialState{}

class SocialInitialState extends SocialState{}

class SocialGetUserLoadingState extends SocialState{}

class SocialGetUserSuccessState extends SocialState{}

class SocialGetUserErrorState extends SocialState{}

class SocialChangeBottomState extends SocialState{}

class SocialNewPostState extends SocialState{}

class SocialProfileImagePickerSuccessState extends SocialState{}

class SocialProfileImagePickerErrorState extends SocialState{}

class SocialCoverImagePickerSuccessState extends SocialState{}

class SocialCoverImagePickerErrorState extends SocialState{}

class SocialUploadProfileImageSuccessState extends SocialState{}

class SocialUploadProfileImageErrorState extends SocialState{}

class SocialUploadCoverImageSuccessState extends SocialState{}

class SocialUploadCoverImageErrorState extends SocialState{}

class SocialUdateUserErrorState extends SocialState{}

class SocialUdateUserLoadingState extends SocialState{}
///// picker image post //////

class SocialPostImagePickerSuccessState extends SocialState{}

class SocialPostImagePickerErrorState extends SocialState{}

//////////create post///////////
class SocialCreatePostLoadingState extends SocialState{}

class SocialCreatePostSuccessState extends SocialState{}

class SocialCreatePostErrorState extends SocialState{}

class SocialRemovePostImageState extends SocialState{}

/////////Get Posts////////////
class SocialGetPostsLoadingState extends SocialState{}

class SocialGetPostsSuccessState extends SocialState{}

class SocialGetPostsErrorState extends SocialState{}

//////// Likes ////////
class SocialLikesPostSuccessState extends SocialState{}

class SocialLikesPostErrorState extends SocialState{}

////////// get all users //////

class SocialGetAllUsersSuccessState extends SocialState{}

class SocialGetAllUsersErrorState extends SocialState{}
