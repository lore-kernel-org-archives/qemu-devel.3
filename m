Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A9AFE98E11
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 09:55:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuScI-0006Bp-PD; Mon, 23 Feb 2026 04:52:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuSao-0003Xi-6F
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 04:51:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuSam-0007QK-BC
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 04:51:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771840263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/DiwelkNN1JYmnmGdofPnD6WuDrkgpfcki7utGg1rLc=;
 b=PrEFOT+SB3VXfFBo1sKTatGdtxoONLq00zzZ0T/p5lMmOlMZt6HYhHKOK2B65lX4FLlIhr
 2/oKhVTDc9ZpBJgP5pi0IBfwkGgl6dPGy1DTJzIc4vvykp6fIHwNmK7EQm5qhUR6ud4i1Q
 olcMsIK6LB4+HoaZQ418kzo0hTyQ6xo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-Woun5poKN-OQ1HAnAFp_lg-1; Mon,
 23 Feb 2026 04:50:59 -0500
X-MC-Unique: Woun5poKN-OQ1HAnAFp_lg-1
X-Mimecast-MFC-AGG-ID: Woun5poKN-OQ1HAnAFp_lg_1771840257
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6A4CB1955F44; Mon, 23 Feb 2026 09:50:57 +0000 (UTC)
Received: from localhost (unknown [10.45.242.25])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 91F181800674; Mon, 23 Feb 2026 09:50:56 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Thomas Huth <huth@tuxfamily.org>, Alexandre Ratchov <alex@caoua.org>
Subject: [PULL v2 84/85] audio: remove AudioMixengBackendClass.name
Date: Mon, 23 Feb 2026 10:46:42 +0100
Message-ID: <20260223094649.2005118-85-marcandre.lureau@redhat.com>
In-Reply-To: <20260223094649.2005118-1-marcandre.lureau@redhat.com>
References: <20260223094649.2005118-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Simply use the class name instead.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 audio/audio_int.h      |  1 -
 audio/audio_template.h | 15 ++++++++-------
 audio/alsaaudio.c      |  1 -
 audio/dbusaudio.c      |  1 -
 audio/dsoundaudio.c    |  1 -
 audio/jackaudio.c      |  1 -
 audio/noaudio.c        |  1 -
 audio/ossaudio.c       |  1 -
 audio/paaudio.c        |  1 -
 audio/pwaudio.c        |  1 -
 audio/sdlaudio.c       |  1 -
 audio/sndioaudio.c     |  1 -
 audio/spiceaudio.c     |  1 -
 audio/wavaudio.c       |  1 -
 audio/coreaudio.m      |  1 -
 15 files changed, 8 insertions(+), 21 deletions(-)

diff --git a/audio/audio_int.h b/audio/audio_int.h
index 3fc4b516878..06f79ade6b0 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -173,7 +173,6 @@ struct SWVoiceCap {
 struct AudioMixengBackendClass {
     AudioBackendClass parent_class;
 
-    const char *name;
     int max_voices_out;
     int max_voices_in;
     size_t voice_size_out;
diff --git a/audio/audio_template.h b/audio/audio_template.h
index 85a128e2f47..228369cf9a1 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -40,6 +40,7 @@ static void glue(audio_init_nb_voices_, TYPE)(AudioMixengBackend *s,
                                               AudioMixengBackendClass *k,
                                               int min_voices)
 {
+    const char *be_name = object_class_get_name(OBJECT_CLASS(k));
     int max_voices = glue(k->max_voices_, TYPE);
     size_t voice_size = glue(k->voice_size_, TYPE);
 
@@ -47,11 +48,11 @@ static void glue(audio_init_nb_voices_, TYPE)(AudioMixengBackend *s,
     if (glue(s->nb_hw_voices_, TYPE) > max_voices) {
         if (!max_voices) {
 #ifdef DAC
-            warn_report("audio: Driver '%s' does not support " NAME, k->name);
+            warn_report("audio: '%s' backend does not support " NAME, be_name);
 #endif
         } else {
-            warn_report("audio: Driver '%s' does not support %d " NAME " voices, max %d",
-                        k->name, glue(s->nb_hw_voices_, TYPE), max_voices);
+            warn_report("audio: '%s' backend does not support %d " NAME " voices, max %d",
+                        be_name, glue(s->nb_hw_voices_, TYPE), max_voices);
         }
         glue(s->nb_hw_voices_, TYPE) = max_voices;
     }
@@ -63,14 +64,14 @@ static void glue(audio_init_nb_voices_, TYPE)(AudioMixengBackend *s,
     }
 
     if (!voice_size && max_voices) {
-        audio_bug("drv=`%s' voice_size=0 max_voices=%d",
-                  k->name, max_voices);
+        audio_bug("backend=`%s' voice_size=0 max_voices=%d",
+                  be_name, max_voices);
         glue(s->nb_hw_voices_, TYPE) = 0;
     }
 
     if (voice_size && !max_voices) {
-        audio_bug("drv=`%s' voice_size=%zu max_voices=0",
-                  k->name, voice_size);
+        audio_bug("backend=`%s' voice_size=%zu max_voices=0",
+                  be_name, voice_size);
     }
 }
 
diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index e2290ea814a..dc99ccb44fa 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -895,7 +895,6 @@ static void audio_alsa_class_init(ObjectClass *klass, const void *data)
     audio_alsa_parent_class = AUDIO_BACKEND_CLASS(object_class_get_parent(klass));
 
     b->realize = audio_alsa_realize;
-    k->name = "alsa";
     k->max_voices_out = INT_MAX;
     k->max_voices_in = INT_MAX;
     k->voice_size_out = sizeof(ALSAVoiceOut);
diff --git a/audio/dbusaudio.c b/audio/dbusaudio.c
index b212b3d6022..e9bdf6adb5b 100644
--- a/audio/dbusaudio.c
+++ b/audio/dbusaudio.c
@@ -699,7 +699,6 @@ static void audio_dbus_class_init(ObjectClass *klass, const void *data)
 
     b->realize = audio_dbus_realize;
     b->set_dbus_server = dbus_audio_set_server;
-    k->name = "dbus";
     k->max_voices_out = INT_MAX;
     k->max_voices_in = INT_MAX;
     k->voice_size_out = sizeof(DBusVoiceOut);
diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
index 704bc3da73b..338ee49c2fe 100644
--- a/audio/dsoundaudio.c
+++ b/audio/dsoundaudio.c
@@ -649,7 +649,6 @@ static void audio_dsound_class_init(ObjectClass *klass, const void *data)
     audio_dsound_parent_class = AUDIO_BACKEND_CLASS(object_class_get_parent(klass));
 
     b->realize = audio_dsound_realize;
-    k->name = "dsound";
     k->max_voices_out = INT_MAX;
     k->max_voices_in = 1;
     k->voice_size_out = sizeof(DSoundVoiceOut);
diff --git a/audio/jackaudio.c b/audio/jackaudio.c
index d9ae8edc0e0..f49fd82c45c 100644
--- a/audio/jackaudio.c
+++ b/audio/jackaudio.c
@@ -663,7 +663,6 @@ static void audio_jack_class_init(ObjectClass *klass, const void *data)
 {
     AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
 
-    k->name = "jack";
     k->max_voices_out = INT_MAX;
     k->max_voices_in = INT_MAX;
     k->voice_size_out = sizeof(QJackOut);
diff --git a/audio/noaudio.c b/audio/noaudio.c
index 70316c572ec..ea6a78c7055 100644
--- a/audio/noaudio.c
+++ b/audio/noaudio.c
@@ -113,7 +113,6 @@ static void audio_none_class_init(ObjectClass *klass, const void *data)
 {
     AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
 
-    k->name = "none";
     k->max_voices_out = INT_MAX;
     k->max_voices_in = INT_MAX;
     k->voice_size_out = sizeof(NoVoiceOut);
diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index 157979e84b4..63c6e0a291f 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -739,7 +739,6 @@ static void audio_oss_class_init(ObjectClass *klass, const void *data)
     audio_oss_parent_class = AUDIO_BACKEND_CLASS(object_class_get_parent(klass));
 
     b->realize = audio_oss_realize;
-    k->name = "oss";
     k->max_voices_out = INT_MAX;
     k->max_voices_in = INT_MAX;
     k->voice_size_out = sizeof(OSSVoiceOut);
diff --git a/audio/paaudio.c b/audio/paaudio.c
index c9957105543..23e8767a46b 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -920,7 +920,6 @@ static void audio_pa_class_init(ObjectClass *klass, const void *data)
     audio_pa_parent_class = AUDIO_BACKEND_CLASS(object_class_get_parent(klass));
 
     b->realize = audio_pa_realize;
-    k->name = "pa";
     k->max_voices_out = INT_MAX;
     k->max_voices_in = INT_MAX;
     k->voice_size_out = sizeof(PAVoiceOut);
diff --git a/audio/pwaudio.c b/audio/pwaudio.c
index b70bf0c1353..a59c22e60b8 100644
--- a/audio/pwaudio.c
+++ b/audio/pwaudio.c
@@ -829,7 +829,6 @@ static void audio_pw_class_init(ObjectClass *klass, const void *data)
     audio_pw_parent_class = AUDIO_BACKEND_CLASS(object_class_get_parent(klass));
 
     b->realize = audio_pw_realize;
-    k->name = "pipewire";
     k->max_voices_out = INT_MAX;
     k->max_voices_in = INT_MAX;
     k->voice_size_out = sizeof(PWVoiceOut);
diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
index 936a3ed076d..bd6a46e2af1 100644
--- a/audio/sdlaudio.c
+++ b/audio/sdlaudio.c
@@ -458,7 +458,6 @@ static void audio_sdl_class_init(ObjectClass *klass, const void *data)
     audio_sdl_parent_class = AUDIO_BACKEND_CLASS(object_class_get_parent(klass));
 
     b->realize = audio_sdl_realize;
-    k->name = "sdl";
     k->max_voices_out = INT_MAX;
     k->max_voices_in = INT_MAX;
     k->voice_size_out = sizeof(SDLVoiceOut);
diff --git a/audio/sndioaudio.c b/audio/sndioaudio.c
index 761f23f8273..2e05ef7ea74 100644
--- a/audio/sndioaudio.c
+++ b/audio/sndioaudio.c
@@ -531,7 +531,6 @@ static void audio_sndio_class_init(ObjectClass *klass, const void *data)
 {
     AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
 
-    k->name = "sndio";
     k->max_voices_out = INT_MAX;
     k->max_voices_in = INT_MAX;
     k->voice_size_out = sizeof(SndioVoice);
diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
index f903ef77e72..70a0b60dd83 100644
--- a/audio/spiceaudio.c
+++ b/audio/spiceaudio.c
@@ -303,7 +303,6 @@ static void audio_spice_class_init(ObjectClass *klass, const void *data)
     audio_spice_parent_class = AUDIO_BACKEND_CLASS(object_class_get_parent(klass));
 
     b->realize = spice_audio_realize;
-    k->name = "spice";
     k->max_voices_out = 1;
     k->max_voices_in = 1;
     k->voice_size_out = sizeof(SpiceVoiceOut);
diff --git a/audio/wavaudio.c b/audio/wavaudio.c
index 55d12d6cdfd..d247dd3ffe6 100644
--- a/audio/wavaudio.c
+++ b/audio/wavaudio.c
@@ -188,7 +188,6 @@ static void audio_wav_class_init(ObjectClass *klass, const void *data)
 {
     AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
 
-    k->name = "wav";
     k->max_voices_out = 1;
     k->max_voices_in = 0;
     k->voice_size_out = sizeof(WAVVoiceOut);
diff --git a/audio/coreaudio.m b/audio/coreaudio.m
index 1f4b3d9d467..a28fa77d73f 100644
--- a/audio/coreaudio.m
+++ b/audio/coreaudio.m
@@ -646,7 +646,6 @@ static void audio_coreaudio_class_init(ObjectClass *klass, const void *data)
 {
     AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
 
-    k->name = "coreaudio";
     k->max_voices_out = 1;
     k->max_voices_in = 0;
     k->voice_size_out = sizeof(coreaudioVoiceOut);
-- 
2.53.0


