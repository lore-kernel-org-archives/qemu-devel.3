Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E33D2FEDA
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:36:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkntD-00043g-VV; Tue, 27 Jan 2026 13:34:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vknpO-0005jr-Dy
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:30:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vknpK-00049W-8F
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:30:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769538609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J24encwNomACtWWbe3QlWc3Pud9f3qITiL4ZBBr21B0=;
 b=PVqfMhQDEgwbBnQGx9+gD12ZagG5CaMxop80TloAXc9DRKN8HQZ1XB9pHqMMuI8KwA8i5P
 EyLHKJAiw7FwvHd0Kx6xgrQtZ7kX7ph7aA4OytDBfqUFOY+MZnLPA08nEdj7cKu0HYeilV
 goz5hZE4TVHmbqu+pFKzKqWuR/qvlWk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-340-w2BbGwwePLqNzyJ5atpF5Q-1; Tue,
 27 Jan 2026 13:30:04 -0500
X-MC-Unique: w2BbGwwePLqNzyJ5atpF5Q-1
X-Mimecast-MFC-AGG-ID: w2BbGwwePLqNzyJ5atpF5Q_1769538602
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 12F8219E5767; Tue, 27 Jan 2026 18:29:41 +0000 (UTC)
Received: from localhost (unknown [10.45.242.23])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2321B19560B4; Tue, 27 Jan 2026 18:29:38 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Thomas Huth <huth@tuxfamily.org>, Alexandre Ratchov <alex@caoua.org>
Subject: [PATCH 43/43] audio: remove AudioMixengBackendClass.name
Date: Tue, 27 Jan 2026 22:25:10 +0400
Message-ID: <20260127182516.289834-44-marcandre.lureau@redhat.com>
In-Reply-To: <20260127182516.289834-1-marcandre.lureau@redhat.com>
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index a606ce0d4cd..7acbc4d9831 100644
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
index 72d6194033b..5fc85ae8f5e 100644
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
index 2f17ab49730..ece7b4acf9c 100644
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
index 58b9d2f04e2..ae04acf04fc 100644
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
index 20208c71069..f636ab09b08 100644
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
index 0f1c097a666..7e992cee1c6 100644
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
index 2a745ae38f9..0f17df38da1 100644
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
index 66ca1231541..9bae4eaecc8 100644
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
index b404adbc1e9..07b2b2ecf6d 100644
--- a/audio/sdlaudio.c
+++ b/audio/sdlaudio.c
@@ -469,7 +469,6 @@ static void audio_sdl_class_init(ObjectClass *klass, const void *data)
     audio_sdl_parent_class = AUDIO_BACKEND_CLASS(object_class_get_parent(klass));
 
     b->realize = audio_sdl_realize;
-    k->name = "sdl";
     k->max_voices_out = INT_MAX;
     k->max_voices_in = INT_MAX;
     k->voice_size_out = sizeof(SDLVoiceOut);
diff --git a/audio/sndioaudio.c b/audio/sndioaudio.c
index 69fa9d8ba54..7c4875247dc 100644
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
index 1b67fe2a540..9ce2a612ed5 100644
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
index 217fb9937f8..afe09e27c78 100644
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
index 08bab353831..145c0da1b71 100644
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
2.52.0


