Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3899FC982CC
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2026 08:57:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7qr1-0005Cq-0k; Sat, 19 Sep 2026 04:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1x7qqx-0005BH-Uh
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 04:55:23 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1x7qqv-0007I5-6n
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 04:55:23 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49cc9f581c4so5680815e9.0
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 01:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789808117; x=1790412917; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0xxlWberjV/um7rJumsSX31jfpCd1ioF9db9gWnV3gk=;
 b=zU8qHjv1lYp1repsAxXs9QLY6m1ktcG+z5RPr5lAba49RW4cAtS/q00o0PuhYuRPuh
 t1mYRwDZDQLnDYS9f21Nr6siE613c9zwgoA+WUHEN8IPqJiqKidWGZk+kUgkhIC0RCaS
 FX2GQgsv2rgZn3D/nKIX8qH/5I4nyIAdwvtDLrGvtflgbU1HIglsIg32cIa35VUF+K0z
 hXGWkzOb6jsCcYJ0WDri5Ro7/ZaRKb9teiIWzo9Iqc8x58sHGaq6wnca/uS6EhQnOCYB
 YwRoD48m9ImXHLsfsE0vfMqnBOJRT49tPawBJbjlQ1yLiK2TXX5qqpsu6UlzekD4ojVj
 1DvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789808117; x=1790412917;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0xxlWberjV/um7rJumsSX31jfpCd1ioF9db9gWnV3gk=;
 b=pyd1qj9S/Ed8YskRl4LGPIBrDzbKak6ON44ZI6RKG6cQI8K8p8IBghL+XNR+7AOs/s
 UFDHZH8id9szMn2Ed7qyzc1zYvvEHf2zp3AzCZXa6+6MtrTgmlT4Rgjn7nYGw/Hajy/Z
 p3X7kczQxkSEUd7LhXDVecqmHigl5ufe+TGGe+1/owMsGh16H+YYycjqrIYsS1l8D3t0
 /tmJvkoNNW8k3bAqYqNQ8zFDkBWc6Ly3Z1KWfckc7mUqz2zId/UD3K6Qyd42hok579jU
 lPggHlZTv7zuznb8NawDqsCyV+RYKZQLw56c+G0gKCWi2HYR4Z3nr9iXDJFgP3pm/Wrh
 36NA==
X-Gm-Message-State: AFuF++mwTR2M/cyUSWB6vOGdpUxgEu3gcsnXnYVHu5bqDxMj1cqPkWW3
 6ktDCf6vwfH7kdCage8ifg6tOsHoNPLz7H1eUbH5otKOi/zmEDNPC7qhQgZS6g4A3q19GDrIRh6
 wWZxIEJ0=
X-Gm-Gg: AYBFou13nigVjvCMFtvF3Ge53pSC5/7rtn7+wL0Vj07pbN4//11Mq4yU+x4QBnoER4Y
 cerGHRJteKbpo6Jtp4d0KJYlPfE/5fNWpUtrzZn4Gbik9MT5bzYBGEXmjWkgyC3v5Cb1CXsZi7k
 uofnWSGHJ5fbpZ2gv5aBvXANytwTInjb9sLEn5haWl9yPpRH9/mhKnlwO1THb0xwxGXZg2Zecrd
 NyKLuIOL3fJcQjaTT5sYuZGO6M3m9yKGID/IIsK//83D7tpW6yNaJPkhezJhdTCG+v0yhYSsz2p
 suITPuBJK9pk9zOpjl6iPH9Bqtv90tZUrpelZxFYNsTHIQQVDZvMYAA2/k0bpHvpgsfUZ57fv5p
 h/8R59X+enQ3YOliuiZbiGaDdQsyd+Iai4cOEc/xLBUwb77cs7suGUv53ePurTB56kbX6HmX0Va
 nxUwIJVjpQW/jtF+62oK85oxaWZoFYX3ikF8ogk1DjVOCTQHKqiiuY1hXAQJzfCvQkKGMaUFvzu
 2iOzcIr2IgSdJJtbWbWEvK2KFE9MMaOdAN48wiXjRI6joDcr31wSTqdSBa+uRfJlnzkqjvEPi+B
 O54UL3aLrle5viyw7cXAeY8CZN3dGapgAT/mn5zBdtnolk0rdjqgriQ/RvHwctyP+lKKEumcfGK
 ZFgzKibqzHLGRyPdSlsi4MskLA5S7AwPRkA==
X-Received: by 2002:a05:600c:37c3:b0:49c:e37e:4389 with SMTP id
 5b1f17b1804b1-49fc4f8528cmr73293965e9.4.1789808117475; 
 Sat, 19 Sep 2026 01:55:17 -0700 (PDT)
Received: from localhost.localdomain (athedsl-116222.home.otenet.gr.
 [85.75.29.157]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc58ce1ddsm82736875e9.3.2026.09.19.01.55.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 01:55:17 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL v2 06/10] hw/audio/virtio-sound: split out
 virtio_snd_pcm_start_stop()
Date: Sat, 19 Sep 2026 11:54:53 +0300
Message-ID: <20260919085510.3388454-7-manos.pitsidianakis@linaro.org>
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

Split out virtio_snd_pcm_start_stop(). This is a preparation
for the next patch so that it doesn't become too big.

[AM: there were too many conflicts, I did `git checkout --ours -- <.>`
     and then reimplemented the patch idea
/AM]

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260803081159.91981-7-alexander@mihalicyn.com>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/audio/virtio-snd.c | 58 ++++++++++++++++++++++++++++---------------
 1 file changed, 38 insertions(+), 20 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index f9822fc609..46026b8cff 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -520,7 +520,43 @@ static void virtio_snd_handle_pcm_prepare(VirtIOSound *s,
 }
 
 /*
- * Handles VIRTIO_SND_R_PCM_START.
+ * Starts/Stops a VirtIOSound card stream.
+ * Returns the response status code. (VIRTIO_SND_S_*).
+ *
+ * @s: VirtIOSound device
+ * @stream_id: stream id
+ * @start: whether to start or stop the stream
+ */
+static uint32_t virtio_snd_pcm_start_stop(VirtIOSound *s,
+                                          uint32_t stream_id,
+                                          bool start)
+{
+    VirtIOSoundPCMStream *stream;
+
+    trace_virtio_snd_handle_pcm_start_stop(start ? "VIRTIO_SND_R_PCM_START" :
+                                                   "VIRTIO_SND_R_PCM_STOP",
+                                           stream_id);
+
+    stream = virtio_snd_pcm_get_stream(s, stream_id);
+    if (!stream) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Invalid stream id: %"PRIu32 "\n",
+                      __func__, stream_id);
+        return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
+    }
+
+    stream->active = start;
+    if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
+        audio_be_set_active_out(s->audio_be, stream->voice.out, start);
+    } else {
+        audio_be_set_active_in(s->audio_be, stream->voice.in, start);
+    }
+
+    return cpu_to_le32(VIRTIO_SND_S_OK);
+}
+
+/*
+ * Handles VIRTIO_SND_R_PCM_START and VIRTIO_SND_R_PCM_STOP.
  *
  * @s: VirtIOSound device
  * @cmd: The request command queue element from VirtIOSound cmdq field
@@ -530,7 +566,6 @@ static void virtio_snd_handle_pcm_start_stop(VirtIOSound *s,
                                              virtio_snd_ctrl_command *cmd,
                                              bool start)
 {
-    VirtIOSoundPCMStream *stream;
     virtio_snd_pcm_hdr req;
     uint32_t stream_id;
     size_t msg_sz = iov_to_buf(cmd->elem->out_sg,
@@ -548,24 +583,7 @@ static void virtio_snd_handle_pcm_start_stop(VirtIOSound *s,
     }
 
     stream_id = le32_to_cpu(req.stream_id);
-    cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_OK);
-    trace_virtio_snd_handle_pcm_start_stop(start ? "VIRTIO_SND_R_PCM_START" :
-            "VIRTIO_SND_R_PCM_STOP", stream_id);
-
-    stream = virtio_snd_pcm_get_stream(s, stream_id);
-    if (stream) {
-        stream->active = start;
-        if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
-            audio_be_set_active_out(s->audio_be, stream->voice.out, start);
-        } else {
-            audio_be_set_active_in(s->audio_be, stream->voice.in, start);
-        }
-    } else {
-        error_report("Invalid stream id: %"PRIu32, stream_id);
-        cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
-        return;
-    }
-    stream->active = start;
+    cmd->resp.code = virtio_snd_pcm_start_stop(s, stream_id, start);
 }
 
 /*
-- 
γαῖα πυρί μιχθήτω


