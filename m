Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50535C982D2
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 07:36:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7T7x-0005fy-UA; Fri, 18 Sep 2026 03:35:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1x7T7u-0005ev-K5
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 03:35:19 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1x7T7s-0007Dl-SP
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 03:35:18 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49cd38e0f79so2415085e9.3
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 00:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789716915; x=1790321715; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jC5ApYaM6D7JDXls9hD8kZ6TLH9GMRvv40+wb09BZ3s=;
 b=QREXjFTNam/QiYlHyodDTfsg7OOvb0dPsdzLjmTWKRn/Pf46YRi2fA847IhNsZqVoJ
 Rw7x+BHdh5GOC1DN8XiD2hLQQK7HrrNpL1WYNCyohIgDm9H7CXHZP6toMHKxpCGYNtjC
 x+od0HelAiXtk9d4szR1E+ZM1VJHUG7PBh9mgR9KM+SJlZhE+gJ+MJpBVt7w+ZuK+zOx
 W40KVZMr1+pRrX4ujstSeoWGZu7b2C3st/K9HQ9sJjz59FImyAcdwmnwdNmbVU/GmWKi
 hWVwifs2FtRWLMFMfcdloBQd0JZmx/Hx6keEeVGGo/uy3Z3HIYUI2Bqi82ZUs26QB19S
 huCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789716915; x=1790321715;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jC5ApYaM6D7JDXls9hD8kZ6TLH9GMRvv40+wb09BZ3s=;
 b=0tF8CkmVyFyVlDNGi2bA5HZ1MK8zJUQNtzmHXrmkRYlqbwQ1cy9aYSDSLGrQ18asYl
 sAgnPkSoQqzxji+XhEBmTEzAjubg7oH9jTNUIK/+Bw/0U4G3ixabQK55hOgdVbiG6tx0
 +KrOEnx5O/l+62fP0rCqwuol3EOm7BP9gEnVYKoJzKzr+bRcTo+U2x6DFoATzVxo/8/+
 z+pQLlEsvwbhTe3F44Ng1L9oLlqxla3x+B6gIjtBFx5YOUQvOekwztEKqHEe4CFId2JM
 /GOMRB827ziSV6V9WHdww74Sc7V4g7XAl6A+dHQNych0E9IHVWUNMYtg1dCa6cCOfJjx
 8yug==
X-Gm-Message-State: AFuF++lzJNC/rS6yU6aLmtFEAZdxcehjzf/vIlCqBfmaTCKptQKPqoWT
 tAK1osbbX1XPxMABiuA6Wnn6rlAxGlXECNzDm/aOj2NVQ5EDmGvyLPrFRxOYIpC8O/wbjGmmH9p
 YiRJaFlg=
X-Gm-Gg: AYBFou3ipYmI0bmXUXZdvjJTI6zRh+icFBwAEDo4t9LQvwWZe+XiknfPlvaO/BEkkRo
 xhwOMvPIkHmpW/VqnBISjtDVPfKmDlSxWWCjdj8SodU/NnmCyPxOC9lSNjvLFrI/cRVIghRfrte
 H0CD/4ZUNzYiFmzHL9tzQTB/qc6w9R5VftxJOOk3Jd2FC2cksIcvldO8vcBNhfeV/CZHP30WqFN
 kOqb9X6l/tt1EPsbr/u6XxnohsdO300/p7+6X3EBRRL5dj/p9pmWPDVLBCqGBb+i63Pdd5eOVrB
 UPPOL1an7KdJZ+OwEL6kvC6eQs9euoHd5uHXe9lsd6DbLRGy7qd8UGGegUtOxMdGSC7S/dgt020
 Zjq3on5jSyIRvhm9vdV8IQWxWiEzQWv+cmaOqe5dQOVe7QK0iY8W+DluukCq624SyJBz4dQoQbc
 jUBIm58K5+LWPNzW6j3Hk9H1yyERxkizFASSO6r9bO7pv7/jjN4ekd9m1E6bVDgEhf6AZANnk7G
 b8Y9blF5h8b9vuD+KGhqOyYjSWkvJ/07LCX+9sQUylOgFN7QgceTZXEcNyoqg7EhA7OrAPrjEQb
 AGYjd4++8/zLT4hnZhLYvknN5LCsIWrIAM5qF/X9r3uxa9DTkNpyg4Ze95DDxssjUcfekF7wWcP
 Itx1trSRatdRSUuFsrgCc1Uxs0IzNqHnRDQ==
X-Received: by 2002:a05:600c:34c7:b0:49c:ff8d:b548 with SMTP id
 5b1f17b1804b1-49fc5726cfcmr40504025e9.11.1789716914879; 
 Fri, 18 Sep 2026 00:35:14 -0700 (PDT)
Received: from localhost.localdomain (athedsl-116222.home.otenet.gr.
 [85.75.29.157]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc471b9a2sm23879825e9.0.2026.09.18.00.35.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 00:35:13 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 08/10] hw/audio/virtio-sound: introduce virtio_snd_pcm_open()
Date: Fri, 18 Sep 2026 10:34:51 +0300
Message-ID: <20260918073502.3265143-9-manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918073502.3265143-1-manos.pitsidianakis@linaro.org>
References: <20260918073502.3265143-1-manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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


