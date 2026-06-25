Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58F54CDB47F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 08:10:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcf9K-0001hR-N3; Thu, 25 Jun 2026 04:09:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wcf9E-0001eD-F6
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 04:09:20 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wcf9C-0007tZ-Kc
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 04:09:20 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-490cdae130cso10798155e9.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 01:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1782374957; x=1782979757; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d/H9uvczVpJc8OvqtpTYZitKsAwfCq5q6IkCevVlJBc=;
 b=bOnhxUBfcYEB+jZT9XtrpnkBJ+KHEF9UF+knh1Mr6wnlfnMswGo+p/nRggrOnjGf2w
 4k6LIjgxxYz1g7xYNeGN947Qoqkv0fZ0HP2eokLb0zu/rJSCNmgolgDzcqmAOfTGKi+u
 8PqehWZTOijcuTCwlPwNuLkMABZ2BKYSGPFxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782374957; x=1782979757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d/H9uvczVpJc8OvqtpTYZitKsAwfCq5q6IkCevVlJBc=;
 b=iwvwY2DUF8qL1mcCPRrLXELIKLZXt3IKwyIy7Y6gG4XytW4cuEozZ5l5vm7rzFBgDf
 t4j9CeNb5J/Nqi4C7PjxUUAFcGgIS9wRWQWUfsh5TWzE1hY4koJb72hMaTqudf3TGRXK
 +54gqJMCzwrq+tc6jIIbjx+R5rJNVe+UEUHyOm00W5RDYGmYP+lm94ekkN3N//5NI84I
 AuuJ/RNLyRvJVUYZySjca8LsIxAOtwJzWct4ii+zdleXHAsAJVNYPWL3luDC4c5aqxhf
 GJTRBPUswDM9SDhEk3daC5FDJKnlsDoI32aG4I37pIowkucoFbG/7/m9fj0QyfGrQ6kI
 Y3Aw==
X-Gm-Message-State: AOJu0YxA6uyqtsOIzcw9gTM8gNLR6BIQTS8xUrAtFMzlzS8yeUTNSO1F
 wPVyBnALzC++7vbO1/0+kNB8uQJyTvcNHV2vYuE9WinfT6u745t9M/XtsNwus1XPVuFu2x8DTR6
 7BU8qXBAlOw==
X-Gm-Gg: AfdE7clv/fGlWfFqd4/O+gObV6xtcJ3PmVXqSIXeRrkZNtLZe13n5X5xZuQAGGpHwz8
 etnorpqDgTaM4kxKu2/mGWM7qZliU5K24BM2PqbI8d+AL2af0uwNDxY3YNXmWZnjivTklO6Et09
 +F+vih1W5BhEOTaKuBfrsFsAmBrhdmeTIfZEIe/cn9OcuDn1AoCaCV6mW7w6zQ0AnE93te1Y/rC
 iE2ZeGITtDV4ZKsykMHSi5uvg6WbE//suORID87YPpeP/zgSK7Rbm4KrWzUi1rnqyt8tqLVyXaL
 bsN49hmpAS3nJBWM4cUbH1eQZPKXNUZR5+zVN7j/iknWB9JMFRdXy7LJoDCcHbDaU2FHzs/i4X9
 nSFTokB0oW+f8ymjf+dI6t3FkVp8VvkMz9TNFRpSgF5PkN823kh/jkRu4kScLgL6EUUzsiGd0Bw
 LpCj1NK7Ja6q0Cyt2Abjxje5AUtLDmz3F46QY14QIcLv2SA2bpa8yfrwC3FG/Fi74W+UqCL5oJC
 /N81MVgaP4w
X-Received: by 2002:a05:600c:6215:b0:492:348:ba08 with SMTP id
 5b1f17b1804b1-4926686259cmr17287135e9.16.1782374956756; 
 Thu, 25 Jun 2026 01:09:16 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf574a720090e98b0d86cf6583.dip0.t-ipconnect.de.
 [2003:cf:574a:7200:90e9:8b0d:86cf:6583])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46dcbac0c9dsm3086950f8f.19.2026.06.25.01.09.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 01:09:16 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH 4/9] hw/audio/virtio-sound: split out
 virtio_snd_pcm_start_stop()
Date: Thu, 25 Jun 2026 10:09:05 +0200
Message-ID: <20260625080910.30569-5-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625080910.30569-1-alexander@mihalicyn.com>
References: <20260625080910.30569-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alexander@mihalicyn.com; helo=mail-wm1-x331.google.com
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
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
---
 hw/audio/trace-events |  3 ++-
 hw/audio/virtio-snd.c | 57 ++++++++++++++++++++++++++++---------------
 2 files changed, 39 insertions(+), 21 deletions(-)

diff --git a/hw/audio/trace-events b/hw/audio/trace-events
index 30f59215453..75d1fb37bd9 100644
--- a/hw/audio/trace-events
+++ b/hw/audio/trace-events
@@ -53,7 +53,8 @@ virtio_snd_unrealize(void *snd) "snd %p: unrealize"
 virtio_snd_handle_pcm_set_params(uint32_t stream) "VIRTIO_SND_PCM_SET_PARAMS called for stream %"PRIu32
 virtio_snd_handle_ctrl(void *vdev, void *vq) "snd %p: handle ctrl event for queue %p"
 virtio_snd_handle_pcm_info(uint32_t stream) "VIRTIO_SND_R_PCM_INFO called for stream %"PRIu32
-virtio_snd_handle_pcm_start_stop(const char *code, uint32_t stream) "%s called for stream %"PRIu32
+virtio_snd_handle_pcm_start(uint32_t stream) "VIRTIO_SND_R_PCM_START called for stream %"PRIu32
+virtio_snd_handle_pcm_stop(uint32_t stream) "VIRTIO_SND_R_PCM_STOP called for stream %"PRIu32
 virtio_snd_handle_pcm_release(uint32_t stream) "VIRTIO_SND_PCM_RELEASE called for stream %"PRIu32
 virtio_snd_handle_code(uint32_t val, const char *code) "ctrl code msg val = %"PRIu32" == %s"
 virtio_snd_handle_chmap_info(void) "VIRTIO_SND_CHMAP_INFO called"
diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 7687261192d..80dc13318af 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -521,7 +521,42 @@ static void virtio_snd_handle_pcm_prepare(VirtIOSound *s,
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
+    stream = virtio_snd_pcm_get_stream(s, stream_id);
+    if (!stream) {
+        return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
+    }
+
+    if (start) {
+        trace_virtio_snd_handle_pcm_start(stream_id);
+    } else {
+        trace_virtio_snd_handle_pcm_stop(stream_id);
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
@@ -531,7 +566,6 @@ static void virtio_snd_handle_pcm_start_stop(VirtIOSound *s,
                                              virtio_snd_ctrl_command *cmd,
                                              bool start)
 {
-    VirtIOSoundPCMStream *stream;
     virtio_snd_pcm_hdr req;
     uint32_t stream_id;
     size_t msg_sz = iov_to_buf(cmd->elem->out_sg,
@@ -549,24 +583,7 @@ static void virtio_snd_handle_pcm_start_stop(VirtIOSound *s,
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


