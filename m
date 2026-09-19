Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D48C982CC
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2026 08:56:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7qr0-0005Cn-EK; Sat, 19 Sep 2026 04:55:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1x7qqx-0005B7-2O
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 04:55:23 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1x7qqv-0007ID-6p
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 04:55:22 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49d097b4939so7230955e9.0
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 01:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789808119; x=1790412919; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jC5ApYaM6D7JDXls9hD8kZ6TLH9GMRvv40+wb09BZ3s=;
 b=beAAuYdh8Ji7kUpQ6MjGfYPkKpmiZsj4LbqSEfFnsNxeUlE8/TcXhiwb2KUnhiMwKr
 unZ7DqgJebq1FIWNX/eKEhtf+AaKuZi8WMhGlTeFsUne6rlIA7lXM1F8PGo+XQZfUyfC
 IA2FdhmYV6/rcRlaWhIIk6Ul0ZM/rJRqrBIeNoBvha4dcDMnOPvPNKlk5L9eZE8Bpy02
 qsDWNJONRssM+g9TmZRrT0oeTsYSDcgE2ZutbPNz3iSVO/RoJ9iCDNFNGa0B34AWJzwg
 ejGTHdKRHWqNnyirvW0dduuid3ZBw+PfXecx/gXvV1rZvA1Bh6TG5juMiAhiR2ZrYox/
 xG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789808119; x=1790412919;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jC5ApYaM6D7JDXls9hD8kZ6TLH9GMRvv40+wb09BZ3s=;
 b=0o+OXdp5oXJC1XfmOWUobbhasHDeuE50Ub9wTAo98dGYJ+OYomlXHo4Y3cDeeszKZA
 60Id7mXteQJQUYfpQ6aFFvxfV/4XDDj3jQQ47mxWZyi335ClcHPlBo46747owr4sG+Wd
 K0k92iwbr75c4rPgx5S+NgfvSD1Fr6j15LmFq7wOE5EleXFhtIrAtj88Z5YsKOUjqzt2
 1PL6kR4DsYEHarQU+CU3ppu3N0teCx67yTyvWbLTcw/WIAaxizZhThzM2evKO0NJs49V
 IF4OFM/Fncpi9tbR42L8wTFeL1pX6Sr/ihJ5ru4xT66DItKi9f0lu1abt9e1liGgbqSz
 Cuxg==
X-Gm-Message-State: AFuF++kDiA5egfLFgCnWDAxnoWB/dgR2fD8aiBRwzZfD8DDOlcQ1K69x
 IcHbgWQtQZGuv6TL9cLASw2EZauIxhFjUzIkJ1ZcTPChATD0zrxSxohHEa23bvjzK40LKdiuypp
 lOaODmVA=
X-Gm-Gg: AYBFou3F4c5hdTB9Wcbyw4AJBHmuKh/3IKt8+w1gpI/9Bw07aNoJWvnH753De9yGT80
 sWHeeUnUBn4Dn+B+aJ6MmpcHQmfETGkRWHC9y12/ApK4NkQJjYTAVhOTUGZV9syKlbB19D3W1Ud
 OqUi5DsZjagGcnjxvxMZB43bHZr8xNT5B8Dj5Thv5DMduHMeIcdh8vjBbXHCmnSE1fqeXT69TuD
 oIjNO8YFgiW0If6n/HWYRzknZmWBS5BrFbENQz97+vjH4kaeRWgyQHbpoAe40fDMoXboV7Wnm8w
 XGv73wU5bC03SHgJSFFtPrP2HwjEVDjzVowAAC8SsnQ6CbZ9QlITaLgsMtUOJcRoZ1YKWWB7Jn7
 t3wKg1u68ga0eSlQ374pk181RPKiLAPIVwpdhxaAT5nJeH0At6RAOs3I/LPkeHNUo/m6gasHOYP
 9yYIIvR3H+Jw5E4J149paqKtEJ5duymvnYX6GBjpUfJXihSSccv1QmhFumasi3Ps0v4mDxV+ORN
 Lpyf5ked/Rw19XEzzkuIggmq1NzA810uagSo9VreP0ad85vFaeFAs52QvFOUgMErT6sUJApRVMC
 9WXwgC3o0k3Cnr7B7Gen5rSVaf7pko3p+04Qb2tyygd7p+LrWfnO8YQfzbmSaGHlZyMoDhX0E7S
 MhqxNB42N+bYR4Zibe9m9k5cvElLEGg/ptQ==
X-Received: by 2002:a05:600c:19cb:b0:49e:8184:f619 with SMTP id
 5b1f17b1804b1-49fc57410f2mr67152235e9.22.1789808119554; 
 Sat, 19 Sep 2026 01:55:19 -0700 (PDT)
Received: from localhost.localdomain (athedsl-116222.home.otenet.gr.
 [85.75.29.157]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc58ce1ddsm82736875e9.3.2026.09.19.01.55.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 01:55:19 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL v2 08/10] hw/audio/virtio-sound: introduce virtio_snd_pcm_open()
Date: Sat, 19 Sep 2026 11:54:55 +0300
Message-ID: <20260919085510.3388454-9-manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260919085510.3388454-1-manos.pitsidianakis@linaro.org>
References: <20260919085510.3388454-1-manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm2-x10.google.com
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
Message-ID: <20260803081159.91981-9-alexander@mihalicyn.com>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/audio/virtio-snd.c | 58 ++++++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 26 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 1c218569cf..7944d2b3b9 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -430,6 +430,37 @@ static void virtio_snd_get_qemu_audsettings(audsettings *as,
 }
 
 /*
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
+/*
  * Close a stream and free all its resources.
  *
  * @stream: VirtIOSoundPCMStream *stream
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
γαῖα πυρί μιχθήτω


