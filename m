Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22918E98E11
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 09:49:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuSZ9-0007uW-3X; Mon, 23 Feb 2026 04:49:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuSYf-0007Jv-1h
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 04:48:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuSYa-00071G-SX
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 04:48:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771840128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HvNBDmel9ARMwegRd/YmMEMKg6Yt+JvTX8PNo8lp3vE=;
 b=hjYstse30Iv8zL8UTW5JwZ/GJjwxZMkEIylQclNczPlpie2HMn+4qPjwXnFbKkiKSrSD+v
 sqFzV922HDpJHRq5Y9x+TN+JiLD9Ssq1vIw+EBGwB1RleJpKpaDA5jDYDlFRMdM6G1Jdkp
 AGRMG79LNnIwV57dxJzwCWfBAC8rRiM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-523-q6s1Lx3lMPKointhRCyFRQ-1; Mon,
 23 Feb 2026 04:48:43 -0500
X-MC-Unique: q6s1Lx3lMPKointhRCyFRQ-1
X-Mimecast-MFC-AGG-ID: q6s1Lx3lMPKointhRCyFRQ_1771840122
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 883D71956095; Mon, 23 Feb 2026 09:48:42 +0000 (UTC)
Received: from localhost (unknown [10.45.242.25])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7635B3003D93; Mon, 23 Feb 2026 09:48:40 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 qemu-arm@nongnu.org (open list:Xilinx ZynqMP and...)
Subject: [PULL v2 37/85] audio: AUD_ -> audio_be_
Date: Mon, 23 Feb 2026 10:45:55 +0100
Message-ID: <20260223094649.2005118-38-marcandre.lureau@redhat.com>
In-Reply-To: <20260223094649.2005118-1-marcandre.lureau@redhat.com>
References: <20260223094649.2005118-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=no autolearn_force=no
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

Use the associate AudioBackend prefix for readability.

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/audio_template.h       |   4 +-
 include/qemu/audio-capture.h |   4 +-
 include/qemu/audio.h         |  43 +++++++------
 audio/audio-be.c             |  32 +++++-----
 audio/wavcapture.c           |   4 +-
 hw/audio/ac97.c              |  42 ++++++-------
 hw/audio/adlib.c             |  10 +--
 hw/audio/asc.c               |  20 +++---
 hw/audio/cs4231a.c           |  18 +++---
 hw/audio/es1370.c            |  26 ++++----
 hw/audio/gus.c               |  10 +--
 hw/audio/hda-codec.c         |  40 ++++++------
 hw/audio/lm4549.c            |  20 +++---
 hw/audio/pcspk.c             |   8 +--
 hw/audio/sb16.c              |  22 +++----
 hw/audio/via-ac97.c          |  20 +++---
 hw/audio/virtio-snd.c        |  34 +++++-----
 hw/audio/wm8750.c            |  43 ++++++-------
 hw/display/xlnx_dp.c         |  16 ++---
 hw/usb/dev-audio.c           |  18 +++---
 tests/audio/test-audio.c     | 116 +++++++++++++++++------------------
 ui/vnc.c                     |   4 +-
 22 files changed, 278 insertions(+), 276 deletions(-)

diff --git a/audio/audio_template.h b/audio/audio_template.h
index a7733f9e1d9..77a70d6e56a 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -527,7 +527,7 @@ static SW *glue(audio_mixeng_backend_open_, TYPE) (
     }
 
     if (!pdo->fixed_settings && sw) {
-        glue(AUD_close_, TYPE)(be, sw);
+        glue(audio_be_close_, TYPE)(be, sw);
         sw = NULL;
     }
 
@@ -564,7 +564,7 @@ static SW *glue(audio_mixeng_backend_open_, TYPE) (
     return sw;
 
  fail:
-    glue(AUD_close_, TYPE)(be, sw);
+    glue(audio_be_close_, TYPE)(be, sw);
     return NULL;
 }
 
diff --git a/include/qemu/audio-capture.h b/include/qemu/audio-capture.h
index 5bfbdd02985..d7998232243 100644
--- a/include/qemu/audio-capture.h
+++ b/include/qemu/audio-capture.h
@@ -19,13 +19,13 @@ typedef struct CaptureState {
     QLIST_ENTRY(CaptureState) entries;
 } CaptureState;
 
-CaptureVoiceOut *AUD_add_capture(
+CaptureVoiceOut *audio_be_add_capture(
     AudioBackend *be,
     struct audsettings *as,
     struct audio_capture_ops *ops,
     void *opaque);
 
-void AUD_del_capture(
+void audio_be_del_capture(
     AudioBackend *be,
     CaptureVoiceOut *cap,
     void *cb_opaque);
diff --git a/include/qemu/audio.h b/include/qemu/audio.h
index 9f85c6316a8..42f97f732a6 100644
--- a/include/qemu/audio.h
+++ b/include/qemu/audio.h
@@ -109,11 +109,11 @@ typedef struct AudioBackendClass {
 #endif
 } AudioBackendClass;
 
-bool AUD_backend_check(AudioBackend **be, Error **errp);
+bool audio_be_check(AudioBackend **be, Error **errp);
 
 AudioBackend *audio_be_new(Audiodev *dev, Error **errp);
 
-SWVoiceOut *AUD_open_out(
+SWVoiceOut *audio_be_open_out(
     AudioBackend *be,
     SWVoiceOut *sw,
     const char *name,
@@ -121,34 +121,33 @@ SWVoiceOut *AUD_open_out(
     audio_callback_fn callback_fn,
     const struct audsettings *settings);
 
-void AUD_close_out(AudioBackend *be, SWVoiceOut *sw);
-size_t AUD_write(AudioBackend *be, SWVoiceOut *sw, void *pcm_buf, size_t size);
-int  AUD_get_buffer_size_out(AudioBackend *be, SWVoiceOut *sw);
-void AUD_set_active_out(AudioBackend *be, SWVoiceOut *sw, bool on);
-bool AUD_is_active_out(AudioBackend *be, SWVoiceOut *sw);
+void audio_be_close_out(AudioBackend *be, SWVoiceOut *sw);
+size_t audio_be_write(AudioBackend *be, SWVoiceOut *sw, void *pcm_buf, size_t size);
+int  audio_be_get_buffer_size_out(AudioBackend *be, SWVoiceOut *sw);
+void audio_be_set_active_out(AudioBackend *be, SWVoiceOut *sw, bool on);
+bool audio_be_is_active_out(AudioBackend *be, SWVoiceOut *sw);
 
-void AUD_set_volume_out(AudioBackend *be, SWVoiceOut *sw, Volume *vol);
-void AUD_set_volume_in(AudioBackend *be, SWVoiceIn *sw, Volume *vol);
+
+void audio_be_set_volume_out(AudioBackend *be, SWVoiceOut *sw, Volume *vol);
+void audio_be_set_volume_in(AudioBackend *be, SWVoiceIn *sw, Volume *vol);
 
 static inline void
-AUD_set_volume_out_lr(AudioBackend *be, SWVoiceOut *sw,
-                      bool mut, uint8_t lvol, uint8_t rvol)
-{
-    AUD_set_volume_out(be, sw, &(Volume) {
+audio_be_set_volume_out_lr(AudioBackend *be, SWVoiceOut *sw,
+                           bool mut, uint8_t lvol, uint8_t rvol) {
+    audio_be_set_volume_out(be, sw, &(Volume) {
         .mute = mut, .channels = 2, .vol = { lvol, rvol }
     });
 }
 
 static inline void
-AUD_set_volume_in_lr(AudioBackend *be, SWVoiceIn *sw,
-                     bool mut, uint8_t lvol, uint8_t rvol)
-{
-    AUD_set_volume_in(be, sw, &(Volume) {
+audio_be_set_volume_in_lr(AudioBackend *be, SWVoiceIn *sw,
+                          bool mut, uint8_t lvol, uint8_t rvol) {
+    audio_be_set_volume_in(be, sw, &(Volume) {
         .mute = mut, .channels = 2, .vol = { lvol, rvol }
     });
 }
 
-SWVoiceIn *AUD_open_in(
+SWVoiceIn *audio_be_open_in(
     AudioBackend *be,
     SWVoiceIn *sw,
     const char *name,
@@ -157,10 +156,10 @@ SWVoiceIn *AUD_open_in(
     const struct audsettings *settings
     );
 
-void AUD_close_in(AudioBackend *be, SWVoiceIn *sw);
-size_t AUD_read(AudioBackend *be, SWVoiceIn *sw, void *pcm_buf, size_t size);
-void AUD_set_active_in(AudioBackend *be, SWVoiceIn *sw, bool on);
-bool AUD_is_active_in(AudioBackend *be, SWVoiceIn *sw);
+void audio_be_close_in(AudioBackend *be, SWVoiceIn *sw);
+size_t audio_be_read(AudioBackend *be, SWVoiceIn *sw, void *pcm_buf, size_t size);
+void audio_be_set_active_in(AudioBackend *be, SWVoiceIn *sw, bool on);
+bool audio_be_is_active_in(AudioBackend *be, SWVoiceIn *sw);
 
 void audio_cleanup(void);
 
diff --git a/audio/audio-be.c b/audio/audio-be.c
index 51fb124026a..4d3b1e2bafd 100644
--- a/audio/audio-be.c
+++ b/audio/audio-be.c
@@ -5,7 +5,7 @@
 #include "qemu/audio-capture.h"
 #include "qapi/error.h"
 
-bool AUD_backend_check(AudioBackend **be, Error **errp)
+bool audio_be_check(AudioBackend **be, Error **errp)
 {
     assert(be != NULL);
 
@@ -19,7 +19,7 @@ bool AUD_backend_check(AudioBackend **be, Error **errp)
     return true;
 }
 
-SWVoiceIn *AUD_open_in(
+SWVoiceIn *audio_be_open_in(
     AudioBackend *be,
     SWVoiceIn *sw,
     const char *name,
@@ -32,7 +32,7 @@ SWVoiceIn *AUD_open_in(
     return klass->open_in(be, sw, name, callback_opaque, callback_fn, as);
 }
 
-SWVoiceOut *AUD_open_out(
+SWVoiceOut *audio_be_open_out(
     AudioBackend *be,
     SWVoiceOut *sw,
     const char *name,
@@ -45,84 +45,84 @@ SWVoiceOut *AUD_open_out(
     return klass->open_out(be, sw, name, callback_opaque, callback_fn, as);
 }
 
-void AUD_close_out(AudioBackend *be, SWVoiceOut *sw)
+void audio_be_close_out(AudioBackend *be, SWVoiceOut *sw)
 {
     AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
 
     return klass->close_out(be, sw);
 }
 
-void AUD_close_in(AudioBackend *be, SWVoiceIn *sw)
+void audio_be_close_in(AudioBackend *be, SWVoiceIn *sw)
 {
     AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
 
     return klass->close_in(be, sw);
 }
 
-bool AUD_is_active_out(AudioBackend *be, SWVoiceOut *sw)
+bool audio_be_is_active_out(AudioBackend *be, SWVoiceOut *sw)
 {
     AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
 
     return klass->is_active_out(be, sw);
 }
 
-bool AUD_is_active_in(AudioBackend *be, SWVoiceIn *sw)
+bool audio_be_is_active_in(AudioBackend *be, SWVoiceIn *sw)
 {
     AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
 
     return klass->is_active_in(be, sw);
 }
 
-size_t AUD_write(AudioBackend *be, SWVoiceOut *sw, void *buf, size_t size)
+size_t audio_be_write(AudioBackend *be, SWVoiceOut *sw, void *buf, size_t size)
 {
     AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
 
     return klass->write(be, sw, buf, size);
 }
 
-size_t AUD_read(AudioBackend *be, SWVoiceIn *sw, void *buf, size_t size)
+size_t audio_be_read(AudioBackend *be, SWVoiceIn *sw, void *buf, size_t size)
 {
     AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
 
     return klass->read(be, sw, buf, size);
 }
 
-int AUD_get_buffer_size_out(AudioBackend *be, SWVoiceOut *sw)
+int audio_be_get_buffer_size_out(AudioBackend *be, SWVoiceOut *sw)
 {
     AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
 
     return klass->get_buffer_size_out(be, sw);
 }
 
-void AUD_set_active_out(AudioBackend *be, SWVoiceOut *sw, bool on)
+void audio_be_set_active_out(AudioBackend *be, SWVoiceOut *sw, bool on)
 {
     AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
 
     return klass->set_active_out(be, sw, on);
 }
 
-void AUD_set_active_in(AudioBackend *be, SWVoiceIn *sw, bool on)
+void audio_be_set_active_in(AudioBackend *be, SWVoiceIn *sw, bool on)
 {
     AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
 
     return klass->set_active_in(be, sw, on);
 }
 
-void AUD_set_volume_out(AudioBackend *be, SWVoiceOut *sw, Volume *vol)
+void audio_be_set_volume_out(AudioBackend *be, SWVoiceOut *sw, Volume *vol)
 {
     AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
 
     klass->set_volume_out(be, sw, vol);
 }
 
-void AUD_set_volume_in(AudioBackend *be, SWVoiceIn *sw, Volume *vol)
+void audio_be_set_volume_in(AudioBackend *be, SWVoiceIn *sw, Volume *vol)
 {
     AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
 
     klass->set_volume_in(be, sw, vol);
 }
 
-CaptureVoiceOut *AUD_add_capture(
+CaptureVoiceOut *audio_be_add_capture(
     AudioBackend *be,
     struct audsettings *as,
     struct audio_capture_ops *ops,
@@ -133,7 +133,7 @@ CaptureVoiceOut *AUD_add_capture(
     return klass->add_capture(be, as, ops, cb_opaque);
 }
 
-void AUD_del_capture(AudioBackend *be, CaptureVoiceOut *cap, void *cb_opaque)
+void audio_be_del_capture(AudioBackend *be, CaptureVoiceOut *cap, void *cb_opaque)
 {
     AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
 
diff --git a/audio/wavcapture.c b/audio/wavcapture.c
index 2950ceaf242..69aa91e35f6 100644
--- a/audio/wavcapture.c
+++ b/audio/wavcapture.c
@@ -86,7 +86,7 @@ static void wav_capture_destroy (void *opaque)
 {
     WAVState *wav = opaque;
 
-    AUD_del_capture(wav->audio_be, wav->cap, wav);
+    audio_be_del_capture(wav->audio_be, wav->cap, wav);
     g_free (wav);
 }
 
@@ -172,7 +172,7 @@ int wav_start_capture(AudioBackend *state, CaptureState *s, const char *path,
         goto error_free;
     }
 
-    cap = AUD_add_capture(wav->audio_be, &as, &ops, wav);
+    cap = audio_be_add_capture(wav->audio_be, &as, &ops, wav);
     if (!cap) {
         error_report("Failed to add audio capture");
         goto error_free;
diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
index 65a4141b8af..5d442b7e067 100644
--- a/hw/audio/ac97.c
+++ b/hw/audio/ac97.c
@@ -246,15 +246,15 @@ static void voice_set_active(AC97LinkState *s, int bm_index, int on)
 {
     switch (bm_index) {
     case PI_INDEX:
-        AUD_set_active_in(s->audio_be, s->voice_pi, on);
+        audio_be_set_active_in(s->audio_be, s->voice_pi, on);
         break;
 
     case PO_INDEX:
-        AUD_set_active_out(s->audio_be, s->voice_po, on);
+        audio_be_set_active_out(s->audio_be, s->voice_po, on);
         break;
 
     case MC_INDEX:
-        AUD_set_active_in(s->audio_be, s->voice_mc, on);
+        audio_be_set_active_in(s->audio_be, s->voice_mc, on);
         break;
 
     default:
@@ -319,7 +319,7 @@ static void open_voice(AC97LinkState *s, int index, int freq)
         s->invalid_freq[index] = 0;
         switch (index) {
         case PI_INDEX:
-            s->voice_pi = AUD_open_in(
+            s->voice_pi = audio_be_open_in(
                 s->audio_be,
                 s->voice_pi,
                 "ac97.pi",
@@ -330,7 +330,7 @@ static void open_voice(AC97LinkState *s, int index, int freq)
             break;
 
         case PO_INDEX:
-            s->voice_po = AUD_open_out(
+            s->voice_po = audio_be_open_out(
                 s->audio_be,
                 s->voice_po,
                 "ac97.po",
@@ -341,7 +341,7 @@ static void open_voice(AC97LinkState *s, int index, int freq)
             break;
 
         case MC_INDEX:
-            s->voice_mc = AUD_open_in(
+            s->voice_mc = audio_be_open_in(
                 s->audio_be,
                 s->voice_mc,
                 "ac97.mc",
@@ -355,17 +355,17 @@ static void open_voice(AC97LinkState *s, int index, int freq)
         s->invalid_freq[index] = freq;
         switch (index) {
         case PI_INDEX:
-            AUD_close_in(s->audio_be, s->voice_pi);
+            audio_be_close_in(s->audio_be, s->voice_pi);
             s->voice_pi = NULL;
             break;
 
         case PO_INDEX:
-            AUD_close_out(s->audio_be, s->voice_po);
+            audio_be_close_out(s->audio_be, s->voice_po);
             s->voice_po = NULL;
             break;
 
         case MC_INDEX:
-            AUD_close_in(s->audio_be, s->voice_mc);
+            audio_be_close_in(s->audio_be, s->voice_mc);
             s->voice_mc = NULL;
             break;
         }
@@ -378,15 +378,15 @@ static void reset_voices(AC97LinkState *s, uint8_t active[LAST_INDEX])
 
     freq = mixer_load(s, AC97_PCM_LR_ADC_Rate);
     open_voice(s, PI_INDEX, freq);
-    AUD_set_active_in(s->audio_be, s->voice_pi, active[PI_INDEX]);
+    audio_be_set_active_in(s->audio_be, s->voice_pi, active[PI_INDEX]);
 
     freq = mixer_load(s, AC97_PCM_Front_DAC_Rate);
     open_voice(s, PO_INDEX, freq);
-    AUD_set_active_out(s->audio_be, s->voice_po, active[PO_INDEX]);
+    audio_be_set_active_out(s->audio_be, s->voice_po, active[PO_INDEX]);
 
     freq = mixer_load(s, AC97_MIC_ADC_Rate);
     open_voice(s, MC_INDEX, freq);
-    AUD_set_active_in(s->audio_be, s->voice_mc, active[MC_INDEX]);
+    audio_be_set_active_in(s->audio_be, s->voice_mc, active[MC_INDEX]);
 }
 
 static void get_volume(uint16_t vol, uint16_t mask, int inverse,
@@ -416,7 +416,7 @@ static void update_combined_volume_out(AC97LinkState *s)
     lvol = (lvol * plvol) / 255;
     rvol = (rvol * prvol) / 255;
 
-    AUD_set_volume_out_lr(s->audio_be, s->voice_po, mute, lvol, rvol);
+    audio_be_set_volume_out_lr(s->audio_be, s->voice_po, mute, lvol, rvol);
 }
 
 static void update_volume_in(AC97LinkState *s)
@@ -427,7 +427,7 @@ static void update_volume_in(AC97LinkState *s)
     get_volume(mixer_load(s, AC97_Record_Gain_Mute), 0x0f, 0,
                &mute, &lvol, &rvol);
 
-    AUD_set_volume_in_lr(s->audio_be, s->voice_pi, mute, lvol, rvol);
+    audio_be_set_volume_in_lr(s->audio_be, s->voice_pi, mute, lvol, rvol);
 }
 
 static void set_volume(AC97LinkState *s, int index, uint32_t val)
@@ -904,7 +904,7 @@ static int write_audio(AC97LinkState *s, AC97BusMasterRegs *r,
         int copied;
         to_copy = MIN(temp, sizeof(tmpbuf));
         pci_dma_read(&s->dev, addr, tmpbuf, to_copy);
-        copied = AUD_write(s->audio_be, s->voice_po, tmpbuf, to_copy);
+        copied = audio_be_write(s->audio_be, s->voice_po, tmpbuf, to_copy);
         dolog("write_audio max=%x to_copy=%x copied=%x",
               max, to_copy, copied);
         if (!copied) {
@@ -948,7 +948,7 @@ static void write_bup(AC97LinkState *s, int elapsed)
     while (elapsed) {
         int temp = MIN(elapsed, sizeof(s->silence));
         while (temp) {
-            int copied = AUD_write(s->audio_be, s->voice_po, s->silence, temp);
+            int copied = audio_be_write(s->audio_be, s->voice_po, s->silence, temp);
             if (!copied) {
                 return;
             }
@@ -978,7 +978,7 @@ static int read_audio(AC97LinkState *s, AC97BusMasterRegs *r,
     while (temp) {
         int acquired;
         to_copy = MIN(temp, sizeof(tmpbuf));
-        acquired = AUD_read(s->audio_be, voice, tmpbuf, to_copy);
+        acquired = audio_be_read(s->audio_be, voice, tmpbuf, to_copy);
         if (!acquired) {
             *stop = 1;
             break;
@@ -1275,7 +1275,7 @@ static void ac97_realize(PCIDevice *dev, Error **errp)
     AC97LinkState *s = AC97(dev);
     uint8_t *c = s->dev.config;
 
-    if (!AUD_backend_check(&s->audio_be, errp)) {
+    if (!audio_be_check(&s->audio_be, errp)) {
         return;
     }
 
@@ -1301,9 +1301,9 @@ static void ac97_exit(PCIDevice *dev)
 {
     AC97LinkState *s = AC97(dev);
 
-    AUD_close_in(s->audio_be, s->voice_pi);
-    AUD_close_out(s->audio_be, s->voice_po);
-    AUD_close_in(s->audio_be, s->voice_mc);
+    audio_be_close_in(s->audio_be, s->voice_pi);
+    audio_be_close_out(s->audio_be, s->voice_po);
+    audio_be_close_in(s->audio_be, s->voice_mc);
 }
 
 static const Property ac97_properties[] = {
diff --git a/hw/audio/adlib.c b/hw/audio/adlib.c
index dd5d9cf6772..ce17e21d5fd 100644
--- a/hw/audio/adlib.c
+++ b/hw/audio/adlib.c
@@ -95,7 +95,7 @@ static void adlib_write(void *opaque, uint32_t nport, uint32_t val)
     int a = nport & 3;
 
     s->active = 1;
-    AUD_set_active_out(s->audio_be, s->voice, 1);
+    audio_be_set_active_out(s->audio_be, s->voice, 1);
 
     adlib_kill_timers (s);
 
@@ -143,7 +143,7 @@ static int write_audio (AdlibState *s, int samples)
         int nbytes, wbytes, wsampl;
 
         nbytes = samples << SHIFT;
-        wbytes = AUD_write(
+        wbytes = audio_be_write(
             s->audio_be,
             s->voice,
             s->mixbuf + (pos << (SHIFT - 1)),
@@ -237,7 +237,7 @@ static void adlib_realizefn (DeviceState *dev, Error **errp)
     AdlibState *s = ADLIB(dev);
     struct audsettings as;
 
-    if (!AUD_backend_check(&s->audio_be, errp)) {
+    if (!audio_be_check(&s->audio_be, errp)) {
         return;
     }
 
@@ -256,7 +256,7 @@ static void adlib_realizefn (DeviceState *dev, Error **errp)
     as.fmt = AUDIO_FORMAT_S16;
     as.endianness = HOST_BIG_ENDIAN;
 
-    s->voice = AUD_open_out(
+    s->voice = audio_be_open_out(
         s->audio_be,
         s->voice,
         "adlib",
@@ -270,7 +270,7 @@ static void adlib_realizefn (DeviceState *dev, Error **errp)
         return;
     }
 
-    s->samples = AUD_get_buffer_size_out(s->audio_be, s->voice) >> SHIFT;
+    s->samples = audio_be_get_buffer_size_out(s->audio_be, s->voice) >> SHIFT;
     s->mixbuf = g_malloc0 (s->samples << SHIFT);
 
     adlib_portio_list[0].offset = s->port;
diff --git a/hw/audio/asc.c b/hw/audio/asc.c
index 43cd51939a3..35c7b5750d6 100644
--- a/hw/audio/asc.c
+++ b/hw/audio/asc.c
@@ -355,12 +355,12 @@ static void asc_out_cb(void *opaque, int free_b)
              * loop because the FIFO has run out of data, and the driver
              * reuses the stale content in its circular audio buffer.
              */
-            AUD_write(s->audio_be, s->voice, s->silentbuf, samples << s->shift);
+            audio_be_write(s->audio_be, s->voice, s->silentbuf, samples << s->shift);
         }
         return;
     }
 
-    AUD_write(s->audio_be, s->voice, s->mixbuf, generated << s->shift);
+    audio_be_write(s->audio_be, s->voice, s->mixbuf, generated << s->shift);
 }
 
 static uint64_t asc_fifo_read(void *opaque, hwaddr addr,
@@ -470,9 +470,9 @@ static void asc_write(void *opaque, hwaddr addr, uint64_t value,
             asc_fifo_reset(&s->fifos[1]);
             asc_lower_irq(s);
             if (value != 0) {
-                AUD_set_active_out(s->audio_be, s->voice, 1);
+                audio_be_set_active_out(s->audio_be, s->voice, 1);
             } else {
-                AUD_set_active_out(s->audio_be, s->voice, 0);
+                audio_be_set_active_out(s->audio_be, s->voice, 0);
             }
         }
         break;
@@ -489,7 +489,7 @@ static void asc_write(void *opaque, hwaddr addr, uint64_t value,
         {
             int vol = (value & 0xe0);
 
-            AUD_set_volume_out_lr(s->audio_be, s->voice, 0, vol, vol);
+            audio_be_set_volume_out_lr(s->audio_be, s->voice, 0, vol, vol);
             break;
         }
     }
@@ -545,7 +545,7 @@ static int asc_post_load(void *opaque, int version)
     ASCState *s = ASC(opaque);
 
     if (s->regs[ASC_MODE] != 0) {
-        AUD_set_active_out(s->audio_be, s->voice, 1);
+        audio_be_set_active_out(s->audio_be, s->voice, 1);
     }
 
     return 0;
@@ -614,7 +614,7 @@ static void asc_reset_hold(Object *obj, ResetType type)
 {
     ASCState *s = ASC(obj);
 
-    AUD_set_active_out(s->audio_be, s->voice, 0);
+    audio_be_set_active_out(s->audio_be, s->voice, 0);
 
     memset(s->regs, 0, sizeof(s->regs));
     asc_fifo_reset(&s->fifos[0]);
@@ -641,7 +641,7 @@ static void asc_realize(DeviceState *dev, Error **errp)
     ASCState *s = ASC(dev);
     struct audsettings as;
 
-    if (!AUD_backend_check(&s->audio_be, errp)) {
+    if (!audio_be_check(&s->audio_be, errp)) {
         return;
     }
 
@@ -650,7 +650,7 @@ static void asc_realize(DeviceState *dev, Error **errp)
     as.fmt = AUDIO_FORMAT_U8;
     as.endianness = HOST_BIG_ENDIAN;
 
-    s->voice = AUD_open_out(s->audio_be, s->voice, "asc.out", s, asc_out_cb,
+    s->voice = audio_be_open_out(s->audio_be, s->voice, "asc.out", s, asc_out_cb,
                             &as);
     if (!s->voice) {
         error_setg(errp, "Initializing audio stream failed");
@@ -658,7 +658,7 @@ static void asc_realize(DeviceState *dev, Error **errp)
     }
 
     s->shift = 1;
-    s->samples = AUD_get_buffer_size_out(s->audio_be, s->voice) >> s->shift;
+    s->samples = audio_be_get_buffer_size_out(s->audio_be, s->voice) >> s->shift;
     s->mixbuf = g_malloc0(s->samples << s->shift);
 
     s->silentbuf = g_malloc(s->samples << s->shift);
diff --git a/hw/audio/cs4231a.c b/hw/audio/cs4231a.c
index 3b8ed092fe4..e6cae9c988e 100644
--- a/hw/audio/cs4231a.c
+++ b/hw/audio/cs4231a.c
@@ -327,7 +327,7 @@ static void cs_reset_voices (CSState *s, uint32_t val)
         goto error;
     }
 
-    s->voice = AUD_open_out(
+    s->voice = audio_be_open_out(
         s->audio_be,
         s->voice,
         "cs4231a",
@@ -339,7 +339,7 @@ static void cs_reset_voices (CSState *s, uint32_t val)
     if (s->dregs[Interface_Configuration] & PEN) {
         if (!s->dma_running) {
             k->hold_DREQ(s->isa_dma, s->dma);
-            AUD_set_active_out(s->audio_be, s->voice, 1);
+            audio_be_set_active_out(s->audio_be, s->voice, 1);
             s->transferred = 0;
         }
         s->dma_running = 1;
@@ -347,7 +347,7 @@ static void cs_reset_voices (CSState *s, uint32_t val)
     else {
         if (s->dma_running) {
             k->release_DREQ(s->isa_dma, s->dma);
-            AUD_set_active_out(s->audio_be, s->voice, 0);
+            audio_be_set_active_out(s->audio_be, s->voice, 0);
         }
         s->dma_running = 0;
     }
@@ -356,7 +356,7 @@ static void cs_reset_voices (CSState *s, uint32_t val)
  error:
     if (s->dma_running) {
         k->release_DREQ(s->isa_dma, s->dma);
-        AUD_set_active_out(s->audio_be, s->voice, 0);
+        audio_be_set_active_out(s->audio_be, s->voice, 0);
     }
 }
 
@@ -465,7 +465,7 @@ static void cs_write (void *opaque, hwaddr addr,
                 if (s->dma_running) {
                     IsaDmaClass *k = ISADMA_GET_CLASS(s->isa_dma);
                     k->release_DREQ(s->isa_dma, s->dma);
-                    AUD_set_active_out(s->audio_be, s->voice, 0);
+                    audio_be_set_active_out(s->audio_be, s->voice, 0);
                     s->dma_running = 0;
                 }
             }
@@ -551,11 +551,11 @@ static int cs_write_audio (CSState *s, int nchan, int dma_pos,
 
             for (i = 0; i < copied; ++i)
                 linbuf[i] = s->tab[tmpbuf[i]];
-            copied = AUD_write(s->audio_be, s->voice, linbuf, copied << 1);
+            copied = audio_be_write(s->audio_be, s->voice, linbuf, copied << 1);
             copied >>= 1;
         }
         else {
-            copied = AUD_write(s->audio_be, s->voice, tmpbuf, copied);
+            copied = audio_be_write(s->audio_be, s->voice, tmpbuf, copied);
         }
 
         temp -= copied;
@@ -614,7 +614,7 @@ static int cs4231a_pre_load (void *opaque)
     if (s->dma_running) {
         IsaDmaClass *k = ISADMA_GET_CLASS(s->isa_dma);
         k->release_DREQ(s->isa_dma, s->dma);
-        AUD_set_active_out(s->audio_be, s->voice, 0);
+        audio_be_set_active_out(s->audio_be, s->voice, 0);
     }
     s->dma_running = 0;
     return 0;
@@ -678,7 +678,7 @@ static void cs4231a_realizefn (DeviceState *dev, Error **errp)
         return;
     }
 
-    if (!AUD_backend_check(&s->audio_be, errp)) {
+    if (!audio_be_check(&s->audio_be, errp)) {
         return;
     }
 
diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
index 44b204730b5..e1658393c6a 100644
--- a/hw/audio/es1370.c
+++ b/hw/audio/es1370.c
@@ -330,10 +330,10 @@ static void es1370_reset (ES1370State *s)
         d->scount = 0;
         d->leftover = 0;
         if (i == ADC_CHANNEL) {
-            AUD_close_in(s->audio_be, s->adc_voice);
+            audio_be_close_in(s->audio_be, s->adc_voice);
             s->adc_voice = NULL;
         } else {
-            AUD_close_out(s->audio_be, s->dac_voice[i]);
+            audio_be_close_out(s->audio_be, s->dac_voice[i]);
             s->dac_voice[i] = NULL;
         }
     }
@@ -411,7 +411,7 @@ static void es1370_update_voices (ES1370State *s, uint32_t ctl, uint32_t sctl)
 
                 if (i == ADC_CHANNEL) {
                     s->adc_voice =
-                        AUD_open_in(
+                        audio_be_open_in(
                             s->audio_be,
                             s->adc_voice,
                             "es1370.adc",
@@ -421,7 +421,7 @@ static void es1370_update_voices (ES1370State *s, uint32_t ctl, uint32_t sctl)
                             );
                 } else {
                     s->dac_voice[i] =
-                        AUD_open_out(
+                        audio_be_open_out(
                             s->audio_be,
                             s->dac_voice[i],
                             i ? "es1370.dac2" : "es1370.dac1",
@@ -438,9 +438,9 @@ static void es1370_update_voices (ES1370State *s, uint32_t ctl, uint32_t sctl)
             int on = (ctl & b->ctl_en) && !(sctl & b->sctl_pause);
 
             if (i == ADC_CHANNEL) {
-                AUD_set_active_in(s->audio_be, s->adc_voice, on);
+                audio_be_set_active_in(s->audio_be, s->adc_voice, on);
             } else {
-                AUD_set_active_out(s->audio_be, s->dac_voice[i], on);
+                audio_be_set_active_out(s->audio_be, s->dac_voice[i], on);
             }
         }
     }
@@ -627,7 +627,7 @@ static void es1370_transfer_audio (ES1370State *s, struct chan *d, int loop_sel,
             int acquired, to_copy;
 
             to_copy = MIN(to_transfer, sizeof(tmpbuf));
-            acquired = AUD_read(s->audio_be, s->adc_voice, tmpbuf, to_copy);
+            acquired = audio_be_read(s->audio_be, s->adc_voice, tmpbuf, to_copy);
             if (!acquired) {
                 break;
             }
@@ -646,7 +646,7 @@ static void es1370_transfer_audio (ES1370State *s, struct chan *d, int loop_sel,
 
             to_copy = MIN(to_transfer, sizeof(tmpbuf));
             pci_dma_read (&s->dev, addr, tmpbuf, to_copy);
-            copied = AUD_write(s->audio_be, voice, tmpbuf, to_copy);
+            copied = audio_be_write(s->audio_be, voice, tmpbuf, to_copy);
             if (!copied) {
                 break;
             }
@@ -784,12 +784,12 @@ static int es1370_post_load (void *opaque, int version_id)
     for (i = 0; i < NB_CHANNELS; ++i) {
         if (i == ADC_CHANNEL) {
             if (s->adc_voice) {
-                AUD_close_in(s->audio_be, s->adc_voice);
+                audio_be_close_in(s->audio_be, s->adc_voice);
                 s->adc_voice = NULL;
             }
         } else {
             if (s->dac_voice[i]) {
-                AUD_close_out(s->audio_be, s->dac_voice[i]);
+                audio_be_close_out(s->audio_be, s->dac_voice[i]);
                 s->dac_voice[i] = NULL;
             }
         }
@@ -833,7 +833,7 @@ static void es1370_realize(PCIDevice *dev, Error **errp)
     ES1370State *s = ES1370(dev);
     uint8_t *c = s->dev.config;
 
-    if (!AUD_backend_check(&s->audio_be, errp)) {
+    if (!audio_be_check(&s->audio_be, errp)) {
         return;
     }
 
@@ -861,10 +861,10 @@ static void es1370_exit(PCIDevice *dev)
     int i;
 
     for (i = 0; i < 2; ++i) {
-        AUD_close_out(s->audio_be, s->dac_voice[i]);
+        audio_be_close_out(s->audio_be, s->dac_voice[i]);
     }
 
-    AUD_close_in(s->audio_be, s->adc_voice);
+    audio_be_close_in(s->audio_be, s->adc_voice);
 }
 
 static const Property es1370_properties[] = {
diff --git a/hw/audio/gus.c b/hw/audio/gus.c
index 1ede1c4a51d..5c2a34c09d2 100644
--- a/hw/audio/gus.c
+++ b/hw/audio/gus.c
@@ -87,7 +87,7 @@ static int write_audio (GUSState *s, int samples)
         int nbytes, wbytes, wsampl;
 
         nbytes = samples << s->shift;
-        wbytes = AUD_write(
+        wbytes = audio_be_write(
             s->audio_be,
             s->voice,
             s->mixbuf + (pos << (s->shift - 1)),
@@ -243,7 +243,7 @@ static void gus_realizefn (DeviceState *dev, Error **errp)
     IsaDmaClass *k;
     struct audsettings as;
 
-    if (!AUD_backend_check(&s->audio_be, errp)) {
+    if (!audio_be_check(&s->audio_be, errp)) {
         return;
     }
 
@@ -258,7 +258,7 @@ static void gus_realizefn (DeviceState *dev, Error **errp)
     as.fmt = AUDIO_FORMAT_S16;
     as.endianness = HOST_BIG_ENDIAN;
 
-    s->voice = AUD_open_out(
+    s->voice = audio_be_open_out(
         s->audio_be,
         NULL,
         "gus",
@@ -273,7 +273,7 @@ static void gus_realizefn (DeviceState *dev, Error **errp)
     }
 
     s->shift = 2;
-    s->samples = AUD_get_buffer_size_out(s->audio_be, s->voice) >> s->shift;
+    s->samples = audio_be_get_buffer_size_out(s->audio_be, s->voice) >> s->shift;
     s->mixbuf = g_malloc0 (s->samples << s->shift);
 
     isa_register_portio_list(d, &s->portio_list1, s->port,
@@ -288,7 +288,7 @@ static void gus_realizefn (DeviceState *dev, Error **errp)
     s->emu.opaque = s;
     s->pic = isa_bus_get_irq(bus, s->emu.gusirq);
 
-    AUD_set_active_out(s->audio_be, s->voice, 1);
+    audio_be_set_active_out(s->audio_be, s->voice, 1);
 }
 
 static const Property gus_properties[] = {
diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index 0373d2f7271..984029a8db1 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -275,8 +275,8 @@ static void hda_audio_input_cb(void *opaque, int avail)
     while (to_transfer) {
         uint32_t start = (uint32_t) (wpos & B_MASK);
         uint32_t chunk = (uint32_t) MIN(B_SIZE - start, to_transfer);
-        uint32_t read = AUD_read(st->state->audio_be, st->voice.in,
-                                 st->buf + start, chunk);
+        uint32_t read = audio_be_read(st->state->audio_be, st->voice.in,
+                                      st->buf + start, chunk);
         wpos += read;
         to_transfer -= read;
         st->wpos += read;
@@ -355,8 +355,8 @@ static void hda_audio_output_cb(void *opaque, int avail)
     while (to_transfer) {
         uint32_t start = (uint32_t) (rpos & B_MASK);
         uint32_t chunk = (uint32_t) MIN(B_SIZE - start, to_transfer);
-        uint32_t written = AUD_write(st->state->audio_be, st->voice.out,
-                                     st->buf + start, chunk);
+        uint32_t written = audio_be_write(st->state->audio_be, st->voice.out,
+                                          st->buf + start, chunk);
         rpos += written;
         to_transfer -= written;
         st->rpos += written;
@@ -377,9 +377,9 @@ static void hda_audio_compat_input_cb(void *opaque, int avail)
 
     while (avail - recv >= sizeof(st->compat_buf)) {
         if (st->compat_bpos != sizeof(st->compat_buf)) {
-            len = AUD_read(st->state->audio_be, st->voice.in,
-                           st->compat_buf + st->compat_bpos,
-                           sizeof(st->compat_buf) - st->compat_bpos);
+            len = audio_be_read(st->state->audio_be, st->voice.in,
+                                st->compat_buf + st->compat_bpos,
+                                sizeof(st->compat_buf) - st->compat_bpos);
             st->compat_bpos += len;
             recv += len;
             if (st->compat_bpos != sizeof(st->compat_buf)) {
@@ -411,9 +411,9 @@ static void hda_audio_compat_output_cb(void *opaque, int avail)
             }
             st->compat_bpos = 0;
         }
-        len = AUD_write(st->state->audio_be, st->voice.out,
-                        st->compat_buf + st->compat_bpos,
-                        sizeof(st->compat_buf) - st->compat_bpos);
+        len = audio_be_write(st->state->audio_be, st->voice.out,
+                             st->compat_buf + st->compat_bpos,
+                             sizeof(st->compat_buf) - st->compat_bpos);
         st->compat_bpos += len;
         sent += len;
         if (st->compat_bpos != sizeof(st->compat_buf)) {
@@ -444,9 +444,9 @@ static void hda_audio_set_running(HDAAudioStream *st, bool running)
         }
     }
     if (st->output) {
-        AUD_set_active_out(st->state->audio_be, st->voice.out, st->running);
+        audio_be_set_active_out(st->state->audio_be, st->voice.out, st->running);
     } else {
-        AUD_set_active_in(st->state->audio_be, st->voice.in, st->running);
+        audio_be_set_active_in(st->state->audio_be, st->voice.in, st->running);
     }
 }
 
@@ -470,9 +470,11 @@ static void hda_audio_set_amp(HDAAudioStream *st)
         return;
     }
     if (st->output) {
-        AUD_set_volume_out_lr(st->state->audio_be, st->voice.out, muted, left, right);
+        audio_be_set_volume_out_lr(st->state->audio_be, st->voice.out,
+                                   muted, left, right);
     } else {
-        AUD_set_volume_in_lr(st->state->audio_be, st->voice.in, muted, left, right);
+        audio_be_set_volume_in_lr(st->state->audio_be, st->voice.in,
+                                  muted, left, right);
     }
 }
 
@@ -495,7 +497,7 @@ static void hda_audio_setup(HDAAudioStream *st)
         } else {
             cb = hda_audio_compat_output_cb;
         }
-        st->voice.out = AUD_open_out(st->state->audio_be, st->voice.out,
+        st->voice.out = audio_be_open_out(st->state->audio_be, st->voice.out,
                                      st->node->name, st, cb, &st->as);
     } else {
         if (use_timer) {
@@ -504,7 +506,7 @@ static void hda_audio_setup(HDAAudioStream *st)
         } else {
             cb = hda_audio_compat_input_cb;
         }
-        st->voice.in = AUD_open_in(st->state->audio_be, st->voice.in,
+        st->voice.in = audio_be_open_in(st->state->audio_be, st->voice.in,
                                    st->node->name, st, cb, &st->as);
     }
 }
@@ -700,7 +702,7 @@ static void hda_audio_init(HDACodecDevice *hda,
     const desc_param *param;
     uint32_t i, type;
 
-    if (!AUD_backend_check(&a->audio_be, errp)) {
+    if (!audio_be_check(&a->audio_be, errp)) {
         return;
     }
 
@@ -758,9 +760,9 @@ static void hda_audio_exit(HDACodecDevice *hda)
         }
         timer_free(st->buft);
         if (st->output) {
-            AUD_close_out(a->audio_be, st->voice.out);
+            audio_be_close_out(a->audio_be, st->voice.out);
         } else {
-            AUD_close_in(a->audio_be, st->voice.in);
+            audio_be_close_in(a->audio_be, st->voice.in);
         }
     }
 }
diff --git a/hw/audio/lm4549.c b/hw/audio/lm4549.c
index b875e83d454..14e15a844ba 100644
--- a/hw/audio/lm4549.c
+++ b/hw/audio/lm4549.c
@@ -101,11 +101,11 @@ static void lm4549_audio_transfer(lm4549_state *s)
     uint32_t i;
 
     /* Activate the voice */
-    AUD_set_active_out(s->audio_be, s->voice, 1);
+    audio_be_set_active_out(s->audio_be, s->voice, 1);
     s->voice_is_active = 1;
 
     /* Try to write the buffer content */
-    written_bytes = AUD_write(s->audio_be, s->voice, s->buffer,
+    written_bytes = audio_be_write(s->audio_be, s->voice, s->buffer,
                               s->buffer_level * sizeof(uint16_t));
     written_samples = written_bytes >> 1;
 
@@ -129,14 +129,14 @@ static void lm4549_audio_out_callback(void *opaque, int free)
     static uint32_t prev_buffer_level;
 
 #ifdef LM4549_DEBUG
-    int size = AUD_get_buffer_size_out(s->audio_be, s->voice);
+    int size = audio_be_get_buffer_size_out(s->audio_be, s->voice);
     DPRINTF("audio_out_callback size = %i free = %i\n", size, free);
 #endif
 
     /* Detect that no data are consumed
        => disable the voice */
     if (s->buffer_level == prev_buffer_level) {
-        AUD_set_active_out(s->audio_be, s->voice, 0);
+        audio_be_set_active_out(s->audio_be, s->voice, 0);
         s->voice_is_active = 0;
     }
     prev_buffer_level = s->buffer_level;
@@ -204,7 +204,7 @@ void lm4549_write(lm4549_state *s,
         as.fmt = AUDIO_FORMAT_S16;
         as.endianness = 0;
 
-        s->voice = AUD_open_out(
+        s->voice = audio_be_open_out(
             s->audio_be,
             s->voice,
             "lm4549.out",
@@ -274,7 +274,7 @@ static int lm4549_post_load(void *opaque, int version_id)
     as.fmt = AUDIO_FORMAT_S16;
     as.endianness = 0;
 
-    s->voice = AUD_open_out(
+    s->voice = audio_be_open_out(
         s->audio_be,
         s->voice,
         "lm4549.out",
@@ -285,7 +285,7 @@ static int lm4549_post_load(void *opaque, int version_id)
 
     /* Request data */
     if (s->voice_is_active == 1) {
-        lm4549_audio_out_callback(s, AUD_get_buffer_size_out(s->audio_be, s->voice));
+        lm4549_audio_out_callback(s, audio_be_get_buffer_size_out(s->audio_be, s->voice));
     }
 
     return 0;
@@ -297,7 +297,7 @@ void lm4549_init(lm4549_state *s, lm4549_callback data_req_cb, void* opaque,
     struct audsettings as;
 
     /* Register an audio card */
-    if (!AUD_backend_check(&s->audio_be, errp)) {
+    if (!audio_be_check(&s->audio_be, errp)) {
         return;
     }
 
@@ -314,7 +314,7 @@ void lm4549_init(lm4549_state *s, lm4549_callback data_req_cb, void* opaque,
     as.fmt = AUDIO_FORMAT_S16;
     as.endianness = 0;
 
-    s->voice = AUD_open_out(
+    s->voice = audio_be_open_out(
         s->audio_be,
         s->voice,
         "lm4549.out",
@@ -323,7 +323,7 @@ void lm4549_init(lm4549_state *s, lm4549_callback data_req_cb, void* opaque,
         &as
     );
 
-    AUD_set_volume_out_lr(s->audio_be, s->voice, 0, 255, 255);
+    audio_be_set_volume_out_lr(s->audio_be, s->voice, 0, 255, 255);
 
     s->voice_is_active = 0;
 
diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
index 07ebfcfccf6..6b826507ce3 100644
--- a/hw/audio/pcspk.c
+++ b/hw/audio/pcspk.c
@@ -105,7 +105,7 @@ static void pcspk_callback(void *opaque, int free)
 
     while (free > 0) {
         n = MIN(s->samples - s->play_pos, (unsigned int)free);
-        n = AUD_write(s->audio_be, s->voice, &s->sample_buf[s->play_pos], n);
+        n = audio_be_write(s->audio_be, s->voice, &s->sample_buf[s->play_pos], n);
         if (!n)
             break;
         s->play_pos = (s->play_pos + n) % s->samples;
@@ -122,7 +122,7 @@ static int pcspk_audio_init(PCSpkState *s)
         return 0;
     }
 
-    s->voice = AUD_open_out(s->audio_be, s->voice, s_spk, s, pcspk_callback, &as);
+    s->voice = audio_be_open_out(s->audio_be, s->voice, s_spk, s, pcspk_callback, &as);
     if (!s->voice) {
         error_report("pcspk: Could not open voice");
         return -1;
@@ -163,7 +163,7 @@ static void pcspk_io_write(void *opaque, hwaddr addr, uint64_t val,
     if (s->voice) {
         if (gate) /* restart */
             s->play_pos = 0;
-        AUD_set_active_out(s->audio_be, s->voice, gate & s->data_on);
+        audio_be_set_active_out(s->audio_be, s->voice, gate & s->data_on);
     }
 }
 
@@ -195,7 +195,7 @@ static void pcspk_realizefn(DeviceState *dev, Error **errp)
 
     isa_register_ioport(isadev, &s->ioport, s->iobase);
 
-    if (s->audio_be && AUD_backend_check(&s->audio_be, errp)) {
+    if (s->audio_be && audio_be_check(&s->audio_be, errp)) {
         pcspk_audio_init(s);
         return;
     }
diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
index da0c33ea41b..c8fc7df8b44 100644
--- a/hw/audio/sb16.c
+++ b/hw/audio/sb16.c
@@ -171,7 +171,7 @@ static void log_dsp (SB16State *dsp)
 static void speaker (SB16State *s, int on)
 {
     s->speaker = on;
-    /* AUD_enable (s->voice, on); */
+    /* audio_be_enable (s->voice, on); */
 }
 
 static void control (SB16State *s, int hold)
@@ -185,11 +185,11 @@ static void control (SB16State *s, int hold)
 
     if (hold) {
         k->hold_DREQ(isa_dma, dma);
-        AUD_set_active_out(s->audio_be, s->voice, 1);
+        audio_be_set_active_out(s->audio_be, s->voice, 1);
     }
     else {
         k->release_DREQ(isa_dma, dma);
-        AUD_set_active_out(s->audio_be, s->voice, 0);
+        audio_be_set_active_out(s->audio_be, s->voice, 0);
     }
 }
 
@@ -215,7 +215,7 @@ static void continue_dma8 (SB16State *s)
         as.fmt = s->fmt;
         as.endianness = 0;
 
-        s->voice = AUD_open_out(
+        s->voice = audio_be_open_out(
             s->audio_be,
             s->voice,
             "sb16",
@@ -378,7 +378,7 @@ static void dma_cmd (SB16State *s, uint8_t cmd, uint8_t d0, int dma_len)
         as.fmt = s->fmt;
         as.endianness = 0;
 
-        s->voice = AUD_open_out(
+        s->voice = audio_be_open_out(
             s->audio_be,
             s->voice,
             "sb16",
@@ -879,7 +879,7 @@ static void legacy_reset (SB16State *s)
     as.fmt = AUDIO_FORMAT_U8;
     as.endianness = 0;
 
-    s->voice = AUD_open_out(
+    s->voice = audio_be_open_out(
         s->audio_be,
         s->voice,
         "sb16",
@@ -889,7 +889,7 @@ static void legacy_reset (SB16State *s)
         );
 
     /* Not sure about that... */
-    /* AUD_set_active_out (s->voice, 1); */
+    /* audio_be_set_active_out (s->voice, 1); */
 }
 
 static void reset (SB16State *s)
@@ -1196,7 +1196,7 @@ static int write_audio (SB16State *s, int nchan, int dma_pos,
         }
 
         copied = k->read_memory(isa_dma, nchan, tmpbuf, dma_pos, to_copy);
-        copied = AUD_write(s->audio_be, s->voice, tmpbuf, copied);
+        copied = audio_be_write(s->audio_be, s->voice, tmpbuf, copied);
 
         temp -= copied;
         dma_pos = (dma_pos + copied) % dma_len;
@@ -1287,7 +1287,7 @@ static int sb16_post_load (void *opaque, int version_id)
     SB16State *s = opaque;
 
     if (s->voice) {
-        AUD_close_out(s->audio_be, s->voice);
+        audio_be_close_out(s->audio_be, s->voice);
         s->voice = NULL;
     }
 
@@ -1302,7 +1302,7 @@ static int sb16_post_load (void *opaque, int version_id)
             as.fmt = s->fmt;
             as.endianness = 0;
 
-            s->voice = AUD_open_out(
+            s->voice = audio_be_open_out(
                 s->audio_be,
                 s->voice,
                 "sb16",
@@ -1401,7 +1401,7 @@ static void sb16_realizefn (DeviceState *dev, Error **errp)
     SB16State *s = SB16 (dev);
     IsaDmaClass *k;
 
-    if (!AUD_backend_check(&s->audio_be, errp)) {
+    if (!audio_be_check(&s->audio_be, errp)) {
         return;
     }
 
diff --git a/hw/audio/via-ac97.c b/hw/audio/via-ac97.c
index 5b344d7a0fc..84d137b41a3 100644
--- a/hw/audio/via-ac97.c
+++ b/hw/audio/via-ac97.c
@@ -53,7 +53,7 @@ static void codec_volume_set_out(ViaAC97State *s)
     rvol /= 255;
     mute = CODEC_REG(s, AC97_Master_Volume_Mute) >> MUTE_SHIFT;
     mute |= CODEC_REG(s, AC97_PCM_Out_Volume_Mute) >> MUTE_SHIFT;
-    AUD_set_volume_out_lr(s->audio_be, s->vo, mute, lvol, rvol);
+    audio_be_set_volume_out_lr(s->audio_be, s->vo, mute, lvol, rvol);
 }
 
 static void codec_reset(ViaAC97State *s)
@@ -189,7 +189,7 @@ static void out_cb(void *opaque, int avail)
         while (temp) {
             to_copy = MIN(temp, sizeof(tmpbuf));
             pci_dma_read(&s->dev, c->addr, tmpbuf, to_copy);
-            copied = AUD_write(s->audio_be, s->vo, tmpbuf, to_copy);
+            copied = audio_be_write(s->audio_be, s->vo, tmpbuf, to_copy);
             if (!copied) {
                 stop = true;
                 break;
@@ -208,7 +208,7 @@ static void out_cb(void *opaque, int avail)
                     c->stat |= STAT_PAUSED;
                 } else {
                     c->stat &= ~STAT_ACTIVE;
-                    AUD_set_active_out(s->audio_be, s->vo, 0);
+                    audio_be_set_active_out(s->audio_be, s->vo, 0);
                 }
                 if (c->type & STAT_EOL) {
                     via_isa_set_irq(&s->dev, 0, 1);
@@ -239,7 +239,7 @@ static void open_voice_out(ViaAC97State *s)
         .fmt = s->aur.type & BIT(5) ? AUDIO_FORMAT_S16 : AUDIO_FORMAT_S8,
         .endianness = 0,
     };
-    s->vo = AUD_open_out(s->audio_be, s->vo, "via-ac97.out", s, out_cb, &as);
+    s->vo = audio_be_open_out(s->audio_be, s->vo, "via-ac97.out", s, out_cb, &as);
 }
 
 static uint64_t sgd_read(void *opaque, hwaddr addr, unsigned size)
@@ -317,20 +317,20 @@ static void sgd_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
         break;
     case 1:
         if (val & CNTL_START) {
-            AUD_set_active_out(s->audio_be, s->vo, 1);
+            audio_be_set_active_out(s->audio_be, s->vo, 1);
             s->aur.stat = STAT_ACTIVE;
         }
         if (val & CNTL_TERM) {
-            AUD_set_active_out(s->audio_be, s->vo, 0);
+            audio_be_set_active_out(s->audio_be, s->vo, 0);
             s->aur.stat &= ~(STAT_ACTIVE | STAT_PAUSED);
             s->aur.clen = 0;
         }
         if (val & CNTL_PAUSE) {
-            AUD_set_active_out(s->audio_be, s->vo, 0);
+            audio_be_set_active_out(s->audio_be, s->vo, 0);
             s->aur.stat &= ~STAT_ACTIVE;
             s->aur.stat |= STAT_PAUSED;
         } else if (!(val & CNTL_PAUSE) && (s->aur.stat & STAT_PAUSED)) {
-            AUD_set_active_out(s->audio_be, s->vo, 1);
+            audio_be_set_active_out(s->audio_be, s->vo, 1);
             s->aur.stat |= STAT_ACTIVE;
             s->aur.stat &= ~STAT_PAUSED;
         }
@@ -426,7 +426,7 @@ static void via_ac97_realize(PCIDevice *pci_dev, Error **errp)
     ViaAC97State *s = VIA_AC97(pci_dev);
     Object *o = OBJECT(s);
 
-    if (!AUD_backend_check(&s->audio_be, errp)) {
+    if (!audio_be_check(&s->audio_be, errp)) {
         return;
     }
 
@@ -455,7 +455,7 @@ static void via_ac97_exit(PCIDevice *dev)
 {
     ViaAC97State *s = VIA_AC97(dev);
 
-    AUD_close_out(s->audio_be, s->vo);
+    audio_be_close_out(s->audio_be, s->vo);
 }
 
 static const Property via_ac97_properties[] = {
diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 47fef61af88..89e24c0a8e0 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -391,10 +391,10 @@ static void virtio_snd_pcm_close(VirtIOSoundPCMStream *stream)
     if (stream) {
         virtio_snd_pcm_flush(stream);
         if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
-            AUD_close_out(stream->pcm->snd->audio_be, stream->voice.out);
+            audio_be_close_out(stream->pcm->snd->audio_be, stream->voice.out);
             stream->voice.out = NULL;
         } else if (stream->info.direction == VIRTIO_SND_D_INPUT) {
-            AUD_close_in(stream->pcm->snd->audio_be, stream->voice.in);
+            audio_be_close_in(stream->pcm->snd->audio_be, stream->voice.in);
             stream->voice.in = NULL;
         }
     }
@@ -457,21 +457,21 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
     stream->as = as;
 
     if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
-        stream->voice.out = AUD_open_out(s->audio_be,
+        stream->voice.out = audio_be_open_out(s->audio_be,
                                          stream->voice.out,
                                          "virtio-sound.out",
                                          stream,
                                          virtio_snd_pcm_out_cb,
                                          &as);
-        AUD_set_volume_out_lr(s->audio_be, stream->voice.out, 0, 255, 255);
+        audio_be_set_volume_out_lr(s->audio_be, stream->voice.out, 0, 255, 255);
     } else {
-        stream->voice.in = AUD_open_in(s->audio_be,
+        stream->voice.in = audio_be_open_in(s->audio_be,
                                         stream->voice.in,
                                         "virtio-sound.in",
                                         stream,
                                         virtio_snd_pcm_in_cb,
                                         &as);
-        AUD_set_volume_in_lr(s->audio_be, stream->voice.in, 0, 255, 255);
+        audio_be_set_volume_in_lr(s->audio_be, stream->voice.in, 0, 255, 255);
     }
 
     return cpu_to_le32(VIRTIO_SND_S_OK);
@@ -561,9 +561,9 @@ static void virtio_snd_handle_pcm_start_stop(VirtIOSound *s,
             stream->active = start;
         }
         if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
-            AUD_set_active_out(s->audio_be, stream->voice.out, start);
+            audio_be_set_active_out(s->audio_be, stream->voice.out, start);
         } else {
-            AUD_set_active_in(s->audio_be, stream->voice.in, start);
+            audio_be_set_active_in(s->audio_be, stream->voice.in, start);
         }
     } else {
         error_report("Invalid stream id: %"PRIu32, stream_id);
@@ -1053,7 +1053,7 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    if (!AUD_backend_check(&vsnd->audio_be, errp)) {
+    if (!audio_be_check(&vsnd->audio_be, errp)) {
         return;
     }
 
@@ -1135,10 +1135,10 @@ static inline void return_tx_buffer(VirtIOSoundPCMStream *stream,
 }
 
 /*
- * AUD_* output callback.
+ * audio_be_* output callback.
  *
  * @data: VirtIOSoundPCMStream stream
- * @available: number of bytes that can be written with AUD_write()
+ * @available: number of bytes that can be written with audio_be_write()
  */
 static void virtio_snd_pcm_out_cb(void *data, int available)
 {
@@ -1153,7 +1153,7 @@ static void virtio_snd_pcm_out_cb(void *data, int available)
                 return;
             }
             if (!stream->active) {
-                /* Stream has stopped, so do not perform AUD_write. */
+                /* Stream has stopped, so do not perform audio_be_write. */
                 return_tx_buffer(stream, buffer);
                 continue;
             }
@@ -1166,7 +1166,7 @@ static void virtio_snd_pcm_out_cb(void *data, int available)
                 buffer->populated = true;
             }
             for (;;) {
-                size = AUD_write(stream->s->audio_be,
+                size = audio_be_write(stream->s->audio_be,
                                  stream->voice.out,
                                  buffer->data + buffer->offset,
                                  MIN(buffer->size, available));
@@ -1230,10 +1230,10 @@ static inline void return_rx_buffer(VirtIOSoundPCMStream *stream,
 
 
 /*
- * AUD_* input callback.
+ * audio_be_* input callback.
  *
  * @data: VirtIOSoundPCMStream stream
- * @available: number of bytes that can be read with AUD_read()
+ * @available: number of bytes that can be read with audio_be_read()
  */
 static void virtio_snd_pcm_in_cb(void *data, int available)
 {
@@ -1248,7 +1248,7 @@ static void virtio_snd_pcm_in_cb(void *data, int available)
                 return;
             }
             if (!stream->active) {
-                /* Stream has stopped, so do not perform AUD_read. */
+                /* Stream has stopped, so do not perform audio_be_read. */
                 return_rx_buffer(stream, buffer);
                 continue;
             }
@@ -1259,7 +1259,7 @@ static void virtio_snd_pcm_in_cb(void *data, int available)
                     return_rx_buffer(stream, buffer);
                     break;
                 }
-                size = AUD_read(stream->s->audio_be,
+                size = audio_be_read(stream->s->audio_be,
                         stream->voice.in,
                         buffer->data + buffer->size,
                         MIN(available, (stream->params.period_bytes -
diff --git a/hw/audio/wm8750.c b/hw/audio/wm8750.c
index bc347fe5376..2a286515b14 100644
--- a/hw/audio/wm8750.c
+++ b/hw/audio/wm8750.c
@@ -72,7 +72,7 @@ static inline void wm8750_in_load(WM8750State *s)
     if (s->idx_in + s->req_in <= sizeof(s->data_in))
         return;
     s->idx_in = MAX(0, (int) sizeof(s->data_in) - s->req_in);
-    AUD_read(s->audio_be, *s->in[0], s->data_in + s->idx_in,
+    audio_be_read(s->audio_be, *s->in[0], s->data_in + s->idx_in,
              sizeof(s->data_in) - s->idx_in);
 }
 
@@ -80,7 +80,8 @@ static inline void wm8750_out_flush(WM8750State *s)
 {
     int sent = 0;
     while (sent < s->idx_out)
-        sent += AUD_write(s->audio_be, *s->out[0], s->data_out + sent, s->idx_out - sent)
+        sent += audio_be_write(s->audio_be, *s->out[0],
+                               s->data_out + sent, s->idx_out - sent)
                 ?: s->idx_out;
     s->idx_out = 0;
 }
@@ -145,30 +146,30 @@ static void wm8750_vol_update(WM8750State *s)
 {
     /* FIXME: multiply all volumes by s->invol[2], s->invol[3] */
 
-    AUD_set_volume_in_lr(s->audio_be, s->adc_voice[0], s->mute,
+    audio_be_set_volume_in_lr(s->audio_be, s->adc_voice[0], s->mute,
                     s->inmute[0] ? 0 : WM8750_INVOL_TRANSFORM(s->invol[0]),
                     s->inmute[1] ? 0 : WM8750_INVOL_TRANSFORM(s->invol[1]));
-    AUD_set_volume_in_lr(s->audio_be, s->adc_voice[1], s->mute,
+    audio_be_set_volume_in_lr(s->audio_be, s->adc_voice[1], s->mute,
                     s->inmute[0] ? 0 : WM8750_INVOL_TRANSFORM(s->invol[0]),
                     s->inmute[1] ? 0 : WM8750_INVOL_TRANSFORM(s->invol[1]));
-    AUD_set_volume_in_lr(s->audio_be, s->adc_voice[2], s->mute,
+    audio_be_set_volume_in_lr(s->audio_be, s->adc_voice[2], s->mute,
                     s->inmute[0] ? 0 : WM8750_INVOL_TRANSFORM(s->invol[0]),
                     s->inmute[1] ? 0 : WM8750_INVOL_TRANSFORM(s->invol[1]));
 
     /* FIXME: multiply all volumes by s->outvol[0], s->outvol[1] */
 
     /* Speaker: LOUT2VOL ROUT2VOL */
-    AUD_set_volume_out_lr(s->audio_be, s->dac_voice[0], s->mute,
+    audio_be_set_volume_out_lr(s->audio_be, s->dac_voice[0], s->mute,
                     s->outmute[0] ? 0 : WM8750_OUTVOL_TRANSFORM(s->outvol[4]),
                     s->outmute[1] ? 0 : WM8750_OUTVOL_TRANSFORM(s->outvol[5]));
 
     /* Headphone: LOUT1VOL ROUT1VOL */
-    AUD_set_volume_out_lr(s->audio_be, s->dac_voice[1], s->mute,
+    audio_be_set_volume_out_lr(s->audio_be, s->dac_voice[1], s->mute,
                     s->outmute[0] ? 0 : WM8750_OUTVOL_TRANSFORM(s->outvol[2]),
                     s->outmute[1] ? 0 : WM8750_OUTVOL_TRANSFORM(s->outvol[3]));
 
     /* MONOOUT: MONOVOL MONOVOL */
-    AUD_set_volume_out_lr(s->audio_be, s->dac_voice[2], s->mute,
+    audio_be_set_volume_out_lr(s->audio_be, s->dac_voice[2], s->mute,
                     s->outmute[0] ? 0 : WM8750_OUTVOL_TRANSFORM(s->outvol[6]),
                     s->outmute[1] ? 0 : WM8750_OUTVOL_TRANSFORM(s->outvol[6]));
 }
@@ -182,18 +183,18 @@ static void wm8750_set_format(WM8750State *s)
     wm8750_out_flush(s);
 
     if (s->in[0] && *s->in[0])
-        AUD_set_active_in(s->audio_be, *s->in[0], 0);
+        audio_be_set_active_in(s->audio_be, *s->in[0], 0);
     if (s->out[0] && *s->out[0])
-        AUD_set_active_out(s->audio_be, *s->out[0], 0);
+        audio_be_set_active_out(s->audio_be, *s->out[0], 0);
 
     for (i = 0; i < IN_PORT_N; i ++)
         if (s->adc_voice[i]) {
-            AUD_close_in(s->audio_be, s->adc_voice[i]);
+            audio_be_close_in(s->audio_be, s->adc_voice[i]);
             s->adc_voice[i] = NULL;
         }
     for (i = 0; i < OUT_PORT_N; i ++)
         if (s->dac_voice[i]) {
-            AUD_close_out(s->audio_be, s->dac_voice[i]);
+            audio_be_close_out(s->audio_be, s->dac_voice[i]);
             s->dac_voice[i] = NULL;
         }
 
@@ -206,11 +207,11 @@ static void wm8750_set_format(WM8750State *s)
     in_fmt.freq = s->adc_hz;
     in_fmt.fmt = AUDIO_FORMAT_S16;
 
-    s->adc_voice[0] = AUD_open_in(s->audio_be, s->adc_voice[0],
+    s->adc_voice[0] = audio_be_open_in(s->audio_be, s->adc_voice[0],
                     CODEC ".input1", s, wm8750_audio_in_cb, &in_fmt);
-    s->adc_voice[1] = AUD_open_in(s->audio_be, s->adc_voice[1],
+    s->adc_voice[1] = audio_be_open_in(s->audio_be, s->adc_voice[1],
                     CODEC ".input2", s, wm8750_audio_in_cb, &in_fmt);
-    s->adc_voice[2] = AUD_open_in(s->audio_be, s->adc_voice[2],
+    s->adc_voice[2] = audio_be_open_in(s->audio_be, s->adc_voice[2],
                     CODEC ".input3", s, wm8750_audio_in_cb, &in_fmt);
 
     /* Setup output */
@@ -219,12 +220,12 @@ static void wm8750_set_format(WM8750State *s)
     out_fmt.freq = s->dac_hz;
     out_fmt.fmt = AUDIO_FORMAT_S16;
 
-    s->dac_voice[0] = AUD_open_out(s->audio_be, s->dac_voice[0],
+    s->dac_voice[0] = audio_be_open_out(s->audio_be, s->dac_voice[0],
                     CODEC ".speaker", s, wm8750_audio_out_cb, &out_fmt);
-    s->dac_voice[1] = AUD_open_out(s->audio_be, s->dac_voice[1],
+    s->dac_voice[1] = audio_be_open_out(s->audio_be, s->dac_voice[1],
                     CODEC ".headphone", s, wm8750_audio_out_cb, &out_fmt);
     /* MONOMIX is also in stereo for simplicity */
-    s->dac_voice[2] = AUD_open_out(s->audio_be, s->dac_voice[2],
+    s->dac_voice[2] = audio_be_open_out(s->audio_be, s->dac_voice[2],
                     CODEC ".monomix", s, wm8750_audio_out_cb, &out_fmt);
     /* no sense emulating OUT3 which is a mix of other outputs */
 
@@ -235,9 +236,9 @@ static void wm8750_set_format(WM8750State *s)
      * for mixing or combining paths to different ports, so we
      * connect both channels to where the left channel is routed.  */
     if (s->in[0] && *s->in[0])
-        AUD_set_active_in(s->audio_be, *s->in[0], 1);
+        audio_be_set_active_in(s->audio_be, *s->in[0], 1);
     if (s->out[0] && *s->out[0])
-        AUD_set_active_out(s->audio_be, *s->out[0], 1);
+        audio_be_set_active_out(s->audio_be, *s->out[0], 1);
 }
 
 static void wm8750_clk_update(WM8750State *s, int ext)
@@ -624,7 +625,7 @@ static void wm8750_realize(DeviceState *dev, Error **errp)
 {
     WM8750State *s = WM8750(dev);
 
-    if (!AUD_backend_check(&s->audio_be, errp)) {
+    if (!audio_be_check(&s->audio_be, errp)) {
         return;
     }
 
diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index deda7efe15d..9aa4709b411 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -331,7 +331,7 @@ static inline void xlnx_dp_audio_activate(XlnxDPState *s)
 {
     bool activated = ((s->core_registers[DP_TX_AUDIO_CONTROL]
                    & DP_TX_AUD_CTRL) != 0);
-    AUD_set_active_out(s->audio_be, s->amixer_output_stream, activated);
+    audio_be_set_active_out(s->audio_be, s->amixer_output_stream, activated);
     xlnx_dpdma_set_host_data_location(s->dpdma, DP_AUDIO_DMA_CHANNEL(0),
                                       &s->audio_buffer_0);
     xlnx_dpdma_set_host_data_location(s->dpdma, DP_AUDIO_DMA_CHANNEL(1),
@@ -401,7 +401,7 @@ static void xlnx_dp_audio_callback(void *opaque, int avail)
     /* Send the buffer through the audio. */
     if (s->byte_left <= MAX_QEMU_BUFFER_SIZE) {
         if (s->byte_left != 0) {
-            written = AUD_write(s->audio_be, s->amixer_output_stream,
+            written = audio_be_write(s->audio_be, s->amixer_output_stream,
                                 &s->out_buffer[s->data_ptr], s->byte_left);
         } else {
              int len_to_copy;
@@ -413,12 +413,12 @@ static void xlnx_dp_audio_callback(void *opaque, int avail)
             while (avail) {
                 len_to_copy = MIN(AUD_CHBUF_MAX_DEPTH, avail);
                 memset(s->out_buffer, 0, len_to_copy);
-                avail -= AUD_write(s->audio_be, s->amixer_output_stream, s->out_buffer,
-                                   len_to_copy);
+                avail -= audio_be_write(s->audio_be, s->amixer_output_stream,
+                                        s->out_buffer, len_to_copy);
             }
         }
     } else {
-        written = AUD_write(s->audio_be, s->amixer_output_stream,
+        written = audio_be_write(s->audio_be, s->amixer_output_stream,
                             &s->out_buffer[s->data_ptr], MAX_QEMU_BUFFER_SIZE);
     }
     s->byte_left -= written;
@@ -1373,7 +1373,7 @@ static void xlnx_dp_realize(DeviceState *dev, Error **errp)
     DisplaySurface *surface;
     struct audsettings as;
 
-    if (!AUD_backend_check(&s->audio_be, errp)) {
+    if (!audio_be_check(&s->audio_be, errp)) {
         return;
     }
 
@@ -1395,13 +1395,13 @@ static void xlnx_dp_realize(DeviceState *dev, Error **errp)
     as.fmt = AUDIO_FORMAT_S16;
     as.endianness = 0;
 
-    s->amixer_output_stream = AUD_open_out(s->audio_be,
+    s->amixer_output_stream = audio_be_open_out(s->audio_be,
                                            s->amixer_output_stream,
                                            "xlnx_dp.audio.out",
                                            s,
                                            xlnx_dp_audio_callback,
                                            &as);
-    AUD_set_volume_out_lr(s->audio_be, s->amixer_output_stream, 0, 255, 255);
+    audio_be_set_volume_out_lr(s->audio_be, s->amixer_output_stream, 0, 255, 255);
     xlnx_dp_audio_activate(s);
     s->vblank = ptimer_init(vblank_hit, s, DP_VBLANK_PTIMER_POLICY);
     ptimer_transaction_begin(s->vblank);
diff --git a/hw/usb/dev-audio.c b/hw/usb/dev-audio.c
index 0f36587fc6f..7b758718c12 100644
--- a/hw/usb/dev-audio.c
+++ b/hw/usb/dev-audio.c
@@ -669,7 +669,7 @@ static void output_callback(void *opaque, int avail)
             return;
         }
 
-        written = AUD_write(s->audio_be, s->out.voice, data, len);
+        written = audio_be_write(s->audio_be, s->out.voice, data, len);
         avail -= written;
         s->out.buf.cons += written;
 
@@ -683,7 +683,7 @@ static int usb_audio_set_output_altset(USBAudioState *s, int altset)
 {
     switch (altset) {
     case ALTSET_OFF:
-        AUD_set_active_out(s->audio_be, s->out.voice, false);
+        audio_be_set_active_out(s->audio_be, s->out.voice, false);
         break;
     case ALTSET_STEREO:
     case ALTSET_51:
@@ -692,7 +692,7 @@ static int usb_audio_set_output_altset(USBAudioState *s, int altset)
             usb_audio_reinit(USB_DEVICE(s), altset_channels[altset]);
         }
         streambuf_init(&s->out.buf, s->buffer, s->out.channels);
-        AUD_set_active_out(s->audio_be, s->out.voice, true);
+        audio_be_set_active_out(s->audio_be, s->out.voice, true);
         break;
     default:
         return -1;
@@ -805,7 +805,7 @@ static int usb_audio_set_control(USBAudioState *s, uint8_t attrib,
             }
             fprintf(stderr, "\n");
         }
-        AUD_set_volume_out(s->audio_be, s->out.voice, &s->out.vol);
+        audio_be_set_volume_out(s->audio_be, s->out.voice, &s->out.vol);
     }
 
     return ret;
@@ -931,7 +931,7 @@ static void usb_audio_unrealize(USBDevice *dev)
     }
 
     usb_audio_set_output_altset(s, ALTSET_OFF);
-    AUD_close_out(s->audio_be, s->out.voice);
+    audio_be_close_out(s->audio_be, s->out.voice);
 
     streambuf_fini(&s->out.buf);
 }
@@ -941,7 +941,7 @@ static void usb_audio_realize(USBDevice *dev, Error **errp)
     USBAudioState *s = USB_AUDIO(dev);
     int i;
 
-    if (!AUD_backend_check(&s->audio_be, errp)) {
+    if (!audio_be_check(&s->audio_be, errp)) {
         return;
     }
 
@@ -978,10 +978,10 @@ static void usb_audio_reinit(USBDevice *dev, unsigned channels)
     s->out.as.endianness = 0;
     streambuf_init(&s->out.buf, s->buffer, s->out.channels);
 
-    s->out.voice = AUD_open_out(s->audio_be, s->out.voice, TYPE_USB_AUDIO,
+    s->out.voice = audio_be_open_out(s->audio_be, s->out.voice, TYPE_USB_AUDIO,
                                 s, output_callback, &s->out.as);
-    AUD_set_volume_out(s->audio_be, s->out.voice, &s->out.vol);
-    AUD_set_active_out(s->audio_be, s->out.voice, 0);
+    audio_be_set_volume_out(s->audio_be, s->out.voice, &s->out.vol);
+    audio_be_set_active_out(s->audio_be, s->out.voice, 0);
 }
 
 static const VMStateDescription vmstate_usb_audio = {
diff --git a/tests/audio/test-audio.c b/tests/audio/test-audio.c
index 6c182ee7c60..1827c084ac8 100644
--- a/tests/audio/test-audio.c
+++ b/tests/audio/test-audio.c
@@ -94,7 +94,7 @@ static SWVoiceOut *open_test_voice_out(AudioBackend *be, const char *name,
     struct audsettings as = default_test_settings;
     SWVoiceOut *voice;
 
-    voice = AUD_open_out(be, NULL, name, opaque, cb, &as);
+    voice = audio_be_open_out(be, NULL, name, opaque, cb, &as);
     g_assert_nonnull(voice);
     return voice;
 }
@@ -104,7 +104,7 @@ static SWVoiceIn *open_test_voice_in(AudioBackend *be, const char *name,
 {
     struct audsettings as = default_test_settings;
 
-    return AUD_open_in(be, NULL, name, opaque, cb, &as);
+    return audio_be_open_in(be, NULL, name, opaque, cb, &as);
 }
 
 /*
@@ -142,8 +142,8 @@ static void test_sine_callback(void *opaque, int avail)
 
     generate_sine_samples(buffer, frames_to_write, s->frames_written);
 
-    bytes_written = AUD_write(s->be, s->voice, buffer,
-                              frames_to_write * sizeof(int16_t) * CHANNELS);
+    bytes_written = audio_be_write(s->be, s->voice, buffer,
+                                   frames_to_write * sizeof(int16_t) * CHANNELS);
     s->frames_written += bytes_written / (sizeof(int16_t) * CHANNELS);
 }
 
@@ -163,7 +163,7 @@ static void test_audio_out_sine_wave(void)
                                       &state, test_sine_callback);
 
     g_test_message("Playing 440Hz sine wave for %d seconds...", DURATION_SECS);
-    AUD_set_active_out(state.be, state.voice, true);
+    audio_be_set_active_out(state.be, state.voice, true);
 
     /*
      * Run the audio subsystem until all frames are written or timeout.
@@ -188,8 +188,8 @@ static void test_audio_out_sine_wave(void)
 
     g_assert_cmpint(state.frames_written, ==, state.total_frames);
 
-    AUD_set_active_out(state.be, state.voice, false);
-    AUD_close_out(state.be, state.voice);
+    audio_be_set_active_out(state.be, state.voice, false);
+    audio_be_close_out(state.be, state.voice);
 }
 
 static void test_audio_prio_list(void)
@@ -224,15 +224,15 @@ static void test_audio_out_active_state(void)
     be = get_test_audio_backend();
     voice = open_test_voice_out(be, "test-active", NULL, dummy_audio_callback);
 
-    g_assert_false(AUD_is_active_out(be, voice));
+    g_assert_false(audio_be_is_active_out(be, voice));
 
-    AUD_set_active_out(be, voice, true);
-    g_assert_true(AUD_is_active_out(be, voice));
+    audio_be_set_active_out(be, voice, true);
+    g_assert_true(audio_be_is_active_out(be, voice));
 
-    AUD_set_active_out(be, voice, false);
-    g_assert_false(AUD_is_active_out(be, voice));
+    audio_be_set_active_out(be, voice, false);
+    g_assert_false(audio_be_is_active_out(be, voice));
 
-    AUD_close_out(be, voice);
+    audio_be_close_out(be, voice);
 }
 
 static void test_audio_out_buffer_size(void)
@@ -244,13 +244,13 @@ static void test_audio_out_buffer_size(void)
     be = get_test_audio_backend();
     voice = open_test_voice_out(be, "test-buffer", NULL, dummy_audio_callback);
 
-    buffer_size = AUD_get_buffer_size_out(be, voice);
+    buffer_size = audio_be_get_buffer_size_out(be, voice);
     g_test_message("Buffer size: %d bytes", buffer_size);
     g_assert_cmpint(buffer_size, >, 0);
 
-    AUD_close_out(be, voice);
+    audio_be_close_out(be, voice);
 
-    g_assert_cmpint(AUD_get_buffer_size_out(NULL, NULL), ==, 0);
+    g_assert_cmpint(audio_be_get_buffer_size_out(be, NULL), ==, 0);
 }
 
 static void test_audio_out_volume(void)
@@ -263,15 +263,15 @@ static void test_audio_out_volume(void)
     voice = open_test_voice_out(be, "test-volume", NULL, dummy_audio_callback);
 
     vol = (Volume){ .mute = false, .channels = 2, .vol = {255, 255} };
-    AUD_set_volume_out(be, voice, &vol);
+    audio_be_set_volume_out(be, voice, &vol);
 
     vol = (Volume){ .mute = true, .channels = 2, .vol = {255, 255} };
-    AUD_set_volume_out(be, voice, &vol);
+    audio_be_set_volume_out(be, voice, &vol);
 
     vol = (Volume){ .mute = false, .channels = 2, .vol = {128, 128} };
-    AUD_set_volume_out(be, voice, &vol);
+    audio_be_set_volume_out(be, voice, &vol);
 
-    AUD_close_out(be, voice);
+    audio_be_close_out(be, voice);
 }
 
 static void test_audio_in_active_state(void)
@@ -286,15 +286,15 @@ static void test_audio_in_active_state(void)
         return;
     }
 
-    g_assert_false(AUD_is_active_in(be, voice));
+    g_assert_false(audio_be_is_active_in(be, voice));
 
-    AUD_set_active_in(be, voice, true);
-    g_assert_true(AUD_is_active_in(be, voice));
+    audio_be_set_active_in(be, voice, true);
+    g_assert_true(audio_be_is_active_in(be, voice));
 
-    AUD_set_active_in(be, voice, false);
-    g_assert_false(AUD_is_active_in(be, voice));
+    audio_be_set_active_in(be, voice, false);
+    g_assert_false(audio_be_is_active_in(be, voice));
 
-    AUD_close_in(be, voice);
+    audio_be_close_in(be, voice);
 }
 
 static void test_audio_in_volume(void)
@@ -311,12 +311,12 @@ static void test_audio_in_volume(void)
     }
 
     vol = (Volume){ .mute = false, .channels = 2, .vol = {255, 255} };
-    AUD_set_volume_in(be, voice, &vol);
+    audio_be_set_volume_in(be, voice, &vol);
 
     vol = (Volume){ .mute = true, .channels = 2, .vol = {255, 255} };
-    AUD_set_volume_in(be, voice, &vol);
+    audio_be_set_volume_in(be, voice, &vol);
 
-    AUD_close_in(be, voice);
+    audio_be_close_in(be, voice);
 }
 
 
@@ -416,7 +416,7 @@ static void test_audio_capture(void)
     state.captured_bytes = 0;
     state.capture_buffer_size = CAPTURE_BUFFER_SIZE;
 
-    cap = AUD_add_capture(be, &as, &ops, &state);
+    cap = audio_be_add_capture(be, &as, &ops, &state);
     g_assert_nonnull(cap);
 
     sine_state.be = be;
@@ -427,7 +427,7 @@ static void test_audio_capture(void)
                                 &sine_state, test_sine_callback);
     sine_state.voice = voice;
 
-    AUD_set_active_out(be, voice, true);
+    audio_be_set_active_out(be, voice, true);
 
     start_time = g_get_monotonic_time();
     while (sine_state.frames_written < sine_state.total_frames ||
@@ -472,10 +472,10 @@ static void test_audio_capture(void)
         g_assert_cmpfloat(match_ratio, >=, 0.9);
     }
 
-    AUD_set_active_out(be, voice, false);
-    AUD_close_out(be, voice);
+    audio_be_set_active_out(be, voice, false);
+    audio_be_close_out(be, voice);
 
-    AUD_del_capture(be, cap, &state);
+    audio_be_del_capture(be, cap, &state);
     g_assert_true(state.destroy_called);
 
     g_free(state.captured_samples);
@@ -486,24 +486,24 @@ static void test_audio_null_handling(void)
     AudioBackend *be = get_test_audio_backend();
     uint8_t buffer[64];
 
-    /* AUD_is_active_out/in(NULL) should return false */
-    g_assert_false(AUD_is_active_out(be, NULL));
-    g_assert_false(AUD_is_active_in(be, NULL));
+    /* audio_be_is_active_out/in(NULL) should return false */
+    g_assert_false(audio_be_is_active_out(be, NULL));
+    g_assert_false(audio_be_is_active_in(be, NULL));
 
-    /* AUD_get_buffer_size_out(NULL) should return 0 */
-    g_assert_cmpint(AUD_get_buffer_size_out(be, NULL), ==, 0);
+    /* audio_be_get_buffer_size_out(NULL) should return 0 */
+    g_assert_cmpint(audio_be_get_buffer_size_out(be, NULL), ==, 0);
 
-    /* AUD_write/read(NULL, ...) should return size (no-op) */
-    g_assert_cmpuint(AUD_write(be, NULL, buffer, sizeof(buffer)), ==,
+    /* audio_be_write/read(NULL, ...) should return size (no-op) */
+    g_assert_cmpuint(audio_be_write(be, NULL, buffer, sizeof(buffer)), ==,
                      sizeof(buffer));
-    g_assert_cmpuint(AUD_read(be, NULL, buffer, sizeof(buffer)), ==,
+    g_assert_cmpuint(audio_be_read(be, NULL, buffer, sizeof(buffer)), ==,
                      sizeof(buffer));
 
     /* These should not crash */
-    AUD_set_active_out(be, NULL, true);
-    AUD_set_active_out(be, NULL, false);
-    AUD_set_active_in(be, NULL, true);
-    AUD_set_active_in(be, NULL, false);
+    audio_be_set_active_out(be, NULL, true);
+    audio_be_set_active_out(be, NULL, false);
+    audio_be_set_active_in(be, NULL, true);
+    audio_be_set_active_in(be, NULL, false);
 }
 
 static void test_audio_multiple_voices(void)
@@ -517,23 +517,23 @@ static void test_audio_multiple_voices(void)
     out2 = open_test_voice_out(be, "test-multi-out2", NULL, dummy_audio_callback);
     in1 = open_test_voice_in(be, "test-multi-in1", NULL, dummy_audio_callback);
 
-    AUD_set_active_out(be, out1, true);
-    AUD_set_active_out(be, out2, true);
-    AUD_set_active_in(be, in1, true);
+    audio_be_set_active_out(be, out1, true);
+    audio_be_set_active_out(be, out2, true);
+    audio_be_set_active_in(be, in1, true);
 
-    g_assert_true(AUD_is_active_out(be, out1));
-    g_assert_true(AUD_is_active_out(be, out2));
+    g_assert_true(audio_be_is_active_out(be, out1));
+    g_assert_true(audio_be_is_active_out(be, out2));
     if (in1) {
-        g_assert_true(AUD_is_active_in(be, in1));
+        g_assert_true(audio_be_is_active_in(be, in1));
     }
 
-    AUD_set_active_out(be, out1, false);
-    AUD_set_active_out(be, out2, false);
-    AUD_set_active_in(be, in1, false);
+    audio_be_set_active_out(be, out1, false);
+    audio_be_set_active_out(be, out2, false);
+    audio_be_set_active_in(be, in1, false);
 
-    AUD_close_in(be, in1);
-    AUD_close_out(be, out2);
-    AUD_close_out(be, out1);
+    audio_be_close_in(be, in1);
+    audio_be_close_out(be, out2);
+    audio_be_close_out(be, out1);
 }
 
 int main(int argc, char **argv)
diff --git a/ui/vnc.c b/ui/vnc.c
index c142d9fc7c0..d56fe2c180e 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1280,7 +1280,7 @@ static void audio_add(VncState *vs)
     ops.destroy = audio_capture_destroy;
     ops.capture = audio_capture;
 
-    vs->audio_cap = AUD_add_capture(vs->vd->audio_be, &vs->as, &ops, vs);
+    vs->audio_cap = audio_be_add_capture(vs->vd->audio_be, &vs->as, &ops, vs);
     if (!vs->audio_cap) {
         error_report("Failed to add audio capture");
     }
@@ -1289,7 +1289,7 @@ static void audio_add(VncState *vs)
 static void audio_del(VncState *vs)
 {
     if (vs->audio_cap) {
-        AUD_del_capture(vs->vd->audio_be, vs->audio_cap, vs);
+        audio_be_del_capture(vs->vd->audio_be, vs->audio_cap, vs);
         vs->audio_cap = NULL;
     }
 }
-- 
2.53.0


