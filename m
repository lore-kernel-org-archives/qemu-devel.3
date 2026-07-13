Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E9DC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 08:43:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjCG0-0004Qd-1v; Mon, 13 Jul 2026 04:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wjCFy-0004QQ-PB
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 04:43:18 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wjCFw-0003C4-UM
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 04:43:18 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-493bf73ec2aso20078395e9.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 01:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1783932195; x=1784536995; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/nTAnPlce3PEAulqjgSLun7hRTB1dh5U84U7OuA1BCs=;
 b=LjJzDlnxQuB7GT6enTQlGzvxvzBvCNgLBlgvxPEqR/soqZAWnh7QhmfrC6MYiIbCyA
 rhBN2MRi4arU7Rcr/2wpkYmhYY0//8tBsVs1cjxqaI2gFNbdronA9Cb6w0CcxTdi1+Ij
 cAcATNCPdPfS85IcY54IrUnQOEc42sDyoqf3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783932195; x=1784536995;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/nTAnPlce3PEAulqjgSLun7hRTB1dh5U84U7OuA1BCs=;
 b=Ps4S3jZpTHiUaAKF9sAWldWLQJTQ1t5Z6KjEBF75bkbCMS7c/r+2olvSRpKhyc4KM3
 sY434gj8KE13meS5IOkjBHeH7ltFAzrJLTrWEUmXzhjsymg63nZiuKb9bSReH1vYwyKt
 FxvCD7HX497Pto8Qx7GTyFAZcXMqyUpRN7rCOlsWB1v7H0orvKNHe85l48zEtmvE/x5R
 EqmuQwtUgbcK7Gd5fgAZG8prC6sgJOeMp8vN3ncn5K39xXxRh05gAEPKOP/pnypbdsZS
 e1Wy0v654dU9A0cKK/U1zjk5pSMim7Sp0OZfCti3xPSYE4vNEl4cOB/vNU+y/876mfxO
 VoKw==
X-Gm-Message-State: AOJu0YzokERA1lYRRIg5+/mfbNBPhjcRdp1mXIU2LWhooNph0Bpdr8B9
 +Y1QQAxUaQAVSKYcBVplaRfhIOR3GJ+i4vC+RTM0BHdTW4quvL9l9FTZ3U7TLXA4f2p3PdQ073p
 Nvygvcn0EUA==
X-Gm-Gg: AfdE7clCWp9t8n4lsZHOtTfM3TF6KFSPmeW51VFGYdNkKtdKySSHOcWJShPg8wxmWao
 EJEPimkmSeFLKUrrVGx68nvqI5q2pG0C/PdSAxT8xTISpF3Bgj2QJFb+AbmFdWDh0QTE7ZEbXe+
 k3HLidXCnfdvv5AO4urqzspIZZxbeg5Y3kFjFPYYGphbJCm1vA/apoi8Wc+nGxwekaBqGuOKx+I
 /ZMvXCKGEJA1QU9cYPTtWLr9F46qi4Kw7iL8WdAnrytrFyeX4t8TCufA8EGdiOoyrzwI4iFfbX0
 OYTvm59NOWVaSckBcO3A9jmJiUbdF8t/JXKut0dmz2BNPm1zLDyI8blVo/W83DpxtV4Xhl/+uPD
 iXdgl3MuVInjYe2IwQjhz6D3XKUBch8/aVr//nV2KFIXLCLH6blvpsc6EgKq5ZBL4Wc+ObLp2rP
 qajfH5mDTsIsHr9+dT38DEJt2OL1KLd4MKYbidR4NzADhzDifdTeahRoodRVjCaLxf1Xvs1Cxhe
 J16bHkzjFjk
X-Received: by 2002:a05:600c:1f91:b0:493:e79e:daa6 with SMTP id
 5b1f17b1804b1-493f8826e69mr78408575e9.33.1783932195013; 
 Mon, 13 Jul 2026 01:43:15 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf574a7200912ca59176a42017.dip0.t-ipconnect.de.
 [2003:cf:574a:7200:912c:a591:76a4:2017])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f2d97527sm287254815e9.2.2026.07.13.01.43.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 01:43:14 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v4 06/10] hw/audio/virtio-sound: split out
 virtio_snd_pcm_start_stop()
Date: Mon, 13 Jul 2026 10:43:03 +0200
Message-ID: <20260713084307.79593-7-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260713084307.79593-1-alexander@mihalicyn.com>
References: <20260713084307.79593-1-alexander@mihalicyn.com>
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

Split out virtio_snd_pcm_start_stop(). This is a preparation
for the next patch so that it doesn't become too big.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
[AM: there were too many conflicts, I did `git checkout --ours -- <.>`
     and then reimplemented the patch idea
/AM]
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
v4:
	- minor formatting change in qemu_log_mask()
	- moved the trace_*() calls at the start of the function
	  (as suggested by Manos Pitsidianakis)
v3:
	- resurrected error_report(..) as suggested by Marc-André Lureau
---
 hw/audio/virtio-snd.c | 58 ++++++++++++++++++++++++++++---------------
 1 file changed, 38 insertions(+), 20 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index d51fc386593..d3fc4c30877 100644
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
2.47.3


