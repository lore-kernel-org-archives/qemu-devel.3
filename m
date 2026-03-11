Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA361125845
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 15:14:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0LBw-0001y6-2h; Wed, 11 Mar 2026 11:09:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0LAk-0006Xr-Kj; Wed, 11 Mar 2026 11:08:30 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0LAj-0005Yi-1s; Wed, 11 Mar 2026 11:08:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773241482; bh=XjtU8PzwkUDwywIBXQiUHl139CIGqa2zBETUbCIwQrs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=uPAywV9MUtJIrKN6+ur44VB1ZGmRSTspjfEIIzCYj8PLMdd6KYQwoGrkeCPo64CRI
 4hCHhHrlEAdjRKsmM8Pvl/pUpjRBndNhX1AV1ZAyrDfVb6aGf+VxhKRBOnTbWBDVvN
 WhT+sohABevzHKh074EmE6drknO3UauXQwz8B8OdCEc0kvIQ5amSNR2X1m5d3ZqB6s
 0S6EmoJAsxdkjgd2AGHB/5IJe6VZKXzPNjO9fj6ITF8wH++oPeTlovHdOuMpO14oTw
 kQkbNYfwauYWAviqJz0s7LYf2h+KJLV3CTf4XzHUi5jbbb7U0pg5c4m7g4JsgofJLR
 50NAYqPf9pgAQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2AECB191E94;
 Wed, 11 Mar 2026 18:04:42 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1851437C2D5;
 Wed, 11 Mar 2026 18:05:20 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?=E7=BD=97=E9=93=AD=E6=BA=90?= <myluo24@m.fudan.edu.cn>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.5 17/46] virtio-snd: handle 5.14.6.2 for PCM_INFO
 properly
Date: Wed, 11 Mar 2026 18:02:53 +0300
Message-ID: <20260311150327.1084669-17-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.5-20260311180252@cover.tls.msk.ru>
References: <qemu-stable-10.1.5-20260311180252@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

The section 5.14.6.2 of the VIRTIO spec says:

  5.14.6.2 Driver Requirements: Item Information Request

  - The driver MUST NOT set start_id and count such that start_id +
    count is greater than the total number of particular items that is
    indicated in the device configuration space.

  - The driver MUST provide a buffer of sizeof(struct virtio_snd_hdr) +
    count * size bytes for the response.

While we performed some check for the second requirement, it failed to
check for integer overflow.

Add also a check for the first requirement, which should limit exposure
to any overflow, since realistically the number of streams will be low
enough in value such that overflow is improbable.

Cc: qemu-stable@nongnu.org
Reported-by: 罗铭源 <myluo24@m.fudan.edu.cn>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260220-virtio-snd-series-v1-3-207c4f7200a2@linaro.org>
(cherry picked from commit 61679d7dcfa2dffc8fb115aa19b09e0e7cf5ea5c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 47e95e56e4..38d9a9712c 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -156,7 +156,7 @@ static virtio_snd_pcm_set_params *virtio_snd_pcm_get_params(VirtIOSound *s,
 static void virtio_snd_handle_pcm_info(VirtIOSound *s,
                                        virtio_snd_ctrl_command *cmd)
 {
-    uint32_t stream_id, start_id, count, size;
+    uint32_t stream_id, start_id, count, size, tmp;
     virtio_snd_pcm_info val;
     virtio_snd_query_info req;
     VirtIOSoundPCMStream *stream = NULL;
@@ -179,11 +179,34 @@ static void virtio_snd_handle_pcm_info(VirtIOSound *s,
     count = le32_to_cpu(req.count);
     size = le32_to_cpu(req.size);
 
-    if (iov_size(cmd->elem->in_sg, cmd->elem->in_num) <
-        sizeof(virtio_snd_hdr) + size * count) {
+    /*
+     * 5.14.6.2 Driver Requirements: Item Information Request
+     * "The driver MUST NOT set start_id and count such that start_id + count
+     * is greater than the total number of particular items that is indicated
+     * in the device configuration space."
+     */
+    if (start_id > s->snd_conf.streams
+        || !g_uint_checked_add(&tmp, start_id, count)
+        || start_id + count > s->snd_conf.streams) {
+        error_report("pcm info: start_id + count is greater than the total "
+                     "number of streams, got: start_id = %u, count = %u",
+                     start_id, count);
+        cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
+        return;
+    }
+
+    /*
+     * 5.14.6.2 Driver Requirements: Item Information Request
+     * "The driver MUST provide a buffer of sizeof(struct virtio_snd_hdr) +
+     * count * size bytes for the response."
+     */
+    if (!g_uint_checked_mul(&tmp, size, count)
+        || !g_uint_checked_add(&tmp, tmp, sizeof(virtio_snd_hdr))
+        || iov_size(cmd->elem->in_sg, cmd->elem->in_num) <
+           sizeof(virtio_snd_hdr) + size * count) {
         error_report("pcm info: buffer too small, got: %zu, needed: %zu",
                 iov_size(cmd->elem->in_sg, cmd->elem->in_num),
-                sizeof(virtio_snd_pcm_info));
+                sizeof(virtio_snd_pcm_info) * count);
         cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
         return;
     }
-- 
2.47.3


