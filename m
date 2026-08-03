Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52936C55184
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 08:13:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqnmT-0001ek-FD; Mon, 03 Aug 2026 04:12:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wqnmP-0001d0-K8
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 04:12:13 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wqnmN-0003fy-MR
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 04:12:13 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-49545ba3d4eso7497855e9.3
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 01:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1785744730; x=1786349530; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3r2H3SFIP78dGg+cFa1xx0QpDLzPKisuuGstXTSGwhc=;
 b=WUA0SMDgG5k8RYsRH+/t2qvZE4dp2Eb86mGfHabM8ZWjHo2/ini0FSW11wct+usht7
 fSy9w4msS9jgntZQByTd3xth+Z6b+eHu1V98xjqIFViZ2k2b0YzRazf0GMAQqY8jjYJ4
 PcVoxEAniYY2wXa65vsBs7UT1GVsAer4wMeas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785744730; x=1786349530;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3r2H3SFIP78dGg+cFa1xx0QpDLzPKisuuGstXTSGwhc=;
 b=UXunupKEx/AB271Ob2GxeS2mEC9ZiFr5GsRAYBS18nQ9THsPhFbDc+YzQKuSpWEVnu
 zx50qx70oipT/Tot/s7f9CDLSqlBT2ALcQJTvOtqr6P5XIAgqPoZf4YTgDvXUyOHnRsO
 guwhudHSaxXvUWp3m36PvUOv9Bly1gGhW51VQ+0fNFiTF+0KCtKRdrUPDZLZjus5SAEO
 jiJ2rqxc7+X2tWT/WfnGATMqn947qN9BpgXsmxj0UmUKdxwmYmdY2jR8gM8u2CkV7I72
 VLYbEK3fneFVhNsN2ThhwmGOGHhsDEpR83hveSk1LVEJDjAVuWG14saLfJO4qhvGLFHz
 R7lg==
X-Gm-Message-State: AOJu0Yw8gWr6AkYtlNEZx7yohBJYJfDJcKL+Y7c+ODjh6Kt6MnGiAVO0
 hzjJFxmtvkqhIYM8Qyh8d6aZW6Ej+B6Ui2Z4yYFh/tbp3A4/9xCs8ISBW6B6gtHGuXDTimi+tl9
 eT+Xy
X-Gm-Gg: AR+sD10s5OIrZwkUvRyJ1e6b+gMXUm99SYyn46tL65cAneLStEEy2yip7rd3lmgsQ7e
 cg9/t7FXsV1jHM56ISPt40Xm4xsBFtuohAIeYdRvADnjZMF0gghSfFwLTLQoAB23F2x8dJyRY3I
 LN57aO0lxdJEfzDstX4igHljfKjVrjMs8VLOUBO2/VhxsGLslah/LAqQjsP9Pu1DEx+eBoodN4o
 iZ2k9c88gcYwXBqTc//GPP2kq/0JlwnJQzDE71eYqfp0ONvXv++66qr/rLHPDQ4/tMfRMD/M05m
 Tv5wrk/gZsNGajOOyIwrjuHxKTi7amOoWwjIIxTdlvS1HtP+vbO0WFmpH0kirV5AhTULvsgF9eQ
 YmW4WzwGDRGa+R5XjqK4JCQrV96Xndy8hYJvUzAL/2rIZJCCn2LNEYuQx26fXOVKwCIzNr08Kz+
 wFqZIilpsgehZ+bFAPyrYeoLUqpBSNtKSPqzLn84a8mkNDm+iLgrUxGBZU+ea2mp+ZwTKAwJNEe
 hPMsHGIbUxksipymHtiRQzKCgzPyT7PiKDHyhIYpZSU0dSOvWWKpdaz23I8
X-Received: by 2002:a05:600c:3045:b0:495:7a5a:d96c with SMTP id
 5b1f17b1804b1-4980c696b4amr118814185e9.18.1785744730379; 
 Mon, 03 Aug 2026 01:12:10 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf574a7200803110ea947f174a.dip0.t-ipconnect.de.
 [2003:cf:574a:7200:8031:10ea:947f:174a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49807b98284sm209358435e9.12.2026.08.03.01.12.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 01:12:09 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v5 08/10] hw/audio/virtio-sound: introduce
 virtio_snd_pcm_open()
Date: Mon,  3 Aug 2026 10:11:57 +0200
Message-ID: <20260803081159.91981-9-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260803081159.91981-1-alexander@mihalicyn.com>
References: <20260803081159.91981-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alexander@mihalicyn.com; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Volker Rümelin <vr_qemu@t-online.de>

Split out the function virtio_snd_pcm_open() from
virtio_snd_pcm_prepare(). A later patch also needs
the new function. There is no functional change.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
[AM: trivial rebase changes]
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/audio/virtio-snd.c | 58 ++++++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 26 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 1c218569cfd..7944d2b3b95 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -429,6 +429,37 @@ static void virtio_snd_get_qemu_audsettings(audsettings *as,
     as->big_endian = false; /* Conforming to VIRTIO 1.0: always little endian. */
 }
 
+/*
+ * Open a stream.
+ *
+ * @stream: VirtIOSoundPCMStream *stream
+ */
+static void virtio_snd_pcm_open(VirtIOSoundPCMStream *stream)
+{
+    virtio_snd_get_qemu_audsettings(&stream->as, &stream->params);
+    stream->info.channels_max = stream->as.nchannels;
+
+    if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
+        stream->voice.out = audio_be_open_out(stream->s->audio_be,
+                                         stream->voice.out,
+                                         "virtio-sound.out",
+                                         stream,
+                                         virtio_snd_pcm_out_cb,
+                                         &stream->as);
+        audio_be_set_volume_out_lr(stream->s->audio_be,
+                                   stream->voice.out, 0, 255, 255);
+    } else {
+        stream->voice.in = audio_be_open_in(stream->s->audio_be,
+                                        stream->voice.in,
+                                        "virtio-sound.in",
+                                        stream,
+                                        virtio_snd_pcm_in_cb,
+                                        &stream->as);
+        audio_be_set_volume_in_lr(stream->s->audio_be,
+                                  stream->voice.in, 0, 255, 255);
+    }
+}
+
 /*
  * Close a stream and free all its resources.
  *
@@ -454,8 +485,6 @@ static void virtio_snd_pcm_close(VirtIOSoundPCMStream *stream)
  */
 static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
 {
-    audsettings as;
-    virtio_snd_pcm_set_params *params;
     VirtIOSoundPCMStream *stream;
 
     stream = virtio_snd_pcm_get_stream(s, stream_id);
@@ -474,30 +503,7 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
         return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
     }
 
-    params = virtio_snd_pcm_get_params(s, stream_id);
-
-    virtio_snd_get_qemu_audsettings(&as, params);
-    stream->info.channels_max = as.nchannels;
-
-    stream->as = as;
-
-    if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
-        stream->voice.out = audio_be_open_out(s->audio_be,
-                                         stream->voice.out,
-                                         "virtio-sound.out",
-                                         stream,
-                                         virtio_snd_pcm_out_cb,
-                                         &as);
-        audio_be_set_volume_out_lr(s->audio_be, stream->voice.out, 0, 255, 255);
-    } else {
-        stream->voice.in = audio_be_open_in(s->audio_be,
-                                        stream->voice.in,
-                                        "virtio-sound.in",
-                                        stream,
-                                        virtio_snd_pcm_in_cb,
-                                        &as);
-        audio_be_set_volume_in_lr(s->audio_be, stream->voice.in, 0, 255, 255);
-    }
+    virtio_snd_pcm_open(stream);
 
     stream->state = VIRTIO_SND_PCM_STATE_PREPARED;
 
-- 
2.47.3


