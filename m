Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 953F2112583A
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 15:26:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0LBq-0001cD-7n; Wed, 11 Mar 2026 11:09:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0LAO-00057Y-OU; Wed, 11 Mar 2026 11:08:09 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0LAM-0005YN-G3; Wed, 11 Mar 2026 11:08:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773241482; bh=Ro8UnxtJVJpfd1sf5NQVHGQMRXpvO6vhRa0rTywA/k4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=lxp9jAXqPtCsHGxy98a6rFkLTY8WkDQ3purhuJdEgGHM1xjTGZoSPxiEDS0A7diTA
 C2Z4gAnJ/XqBe/20JHarMZRD5agtkZ6DRN5Jl7qj55Hu/JJwXvsUmikfklptfpFo4w
 bkvLIB6YmMTeflutAC9BWJcoAtXtKCC8hHW0as2N+KxUFUCInJat5k1okZAhQQa3ik
 heXDghXilDubeSMOPj4aOAWHBj8tyywl8Kcnj82tesQCHPLWraOkSe/y7we7f5mkJs
 qYMhM+1D89eYCt0NBgcgInwsmdGxuRJWsLDeQx8687GdbsCrmpmAyegY8hZ+kmT7Hu
 5SMG5iWd3D2mw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 19BE7191E93;
 Wed, 11 Mar 2026 18:04:42 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0820B37C2D4;
 Wed, 11 Mar 2026 18:05:20 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.5 16/46] virtio-snd: remove TODO comments
Date: Wed, 11 Mar 2026 18:02:52 +0300
Message-ID: <20260311150327.1084669-16-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.5-20260311180252@cover.tls.msk.ru>
References: <qemu-stable-10.1.5-20260311180252@cover.tls.msk.ru>
MIME-Version: 1.0
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

Replying with a VIRTIO_SND_S_BAD_MSG error does not warrant a device
reset. Instead, a device reset happens when the driver requests it from the
transport.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260220-virtio-snd-series-v1-2-207c4f7200a2@linaro.org>
(cherry picked from commit 34238f078a04f24b91199249b83846ab082b4e05)
(Mjt: pick this one up so the next commit applies cleanly)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index eca3319e59..47e95e56e4 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -168,9 +168,6 @@ static void virtio_snd_handle_pcm_info(VirtIOSound *s,
                                sizeof(virtio_snd_query_info));
 
     if (msg_sz != sizeof(virtio_snd_query_info)) {
-        /*
-         * TODO: do we need to set DEVICE_NEEDS_RESET?
-         */
         qemu_log_mask(LOG_GUEST_ERROR,
                 "%s: virtio-snd command size incorrect %zu vs \
                 %zu\n", __func__, msg_sz, sizeof(virtio_snd_query_info));
@@ -184,9 +181,6 @@ static void virtio_snd_handle_pcm_info(VirtIOSound *s,
 
     if (iov_size(cmd->elem->in_sg, cmd->elem->in_num) <
         sizeof(virtio_snd_hdr) + size * count) {
-        /*
-         * TODO: do we need to set DEVICE_NEEDS_RESET?
-         */
         error_report("pcm info: buffer too small, got: %zu, needed: %zu",
                 iov_size(cmd->elem->in_sg, cmd->elem->in_num),
                 sizeof(virtio_snd_pcm_info));
@@ -244,9 +238,6 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
     virtio_snd_pcm_set_params *st_params;
 
     if (stream_id >= s->snd_conf.streams || s->pcm->pcm_params == NULL) {
-        /*
-         * TODO: do we need to set DEVICE_NEEDS_RESET?
-         */
         virtio_error(VIRTIO_DEVICE(s), "Streams have not been initialized.\n");
         return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
     }
@@ -297,9 +288,6 @@ static void virtio_snd_handle_pcm_set_params(VirtIOSound *s,
                                sizeof(virtio_snd_pcm_set_params));
 
     if (msg_sz != sizeof(virtio_snd_pcm_set_params)) {
-        /*
-         * TODO: do we need to set DEVICE_NEEDS_RESET?
-         */
         qemu_log_mask(LOG_GUEST_ERROR,
                 "%s: virtio-snd command size incorrect %zu vs \
                 %zu\n", __func__, msg_sz, sizeof(virtio_snd_pcm_set_params));
@@ -609,9 +597,6 @@ static void virtio_snd_handle_pcm_release(VirtIOSound *s,
                                sizeof(stream_id));
 
     if (msg_sz != sizeof(stream_id)) {
-        /*
-         * TODO: do we need to set DEVICE_NEEDS_RESET?
-         */
         qemu_log_mask(LOG_GUEST_ERROR,
                 "%s: virtio-snd command size incorrect %zu vs \
                 %zu\n", __func__, msg_sz, sizeof(stream_id));
@@ -623,9 +608,6 @@ static void virtio_snd_handle_pcm_release(VirtIOSound *s,
     trace_virtio_snd_handle_pcm_release(stream_id);
     stream = virtio_snd_pcm_get_stream(s, stream_id);
     if (stream == NULL) {
-        /*
-         * TODO: do we need to set DEVICE_NEEDS_RESET?
-         */
         error_report("already released stream %"PRIu32, stream_id);
         virtio_error(VIRTIO_DEVICE(s),
                      "already released stream %"PRIu32,
@@ -668,9 +650,6 @@ process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd)
                                sizeof(virtio_snd_hdr));
 
     if (msg_sz != sizeof(virtio_snd_hdr)) {
-        /*
-         * TODO: do we need to set DEVICE_NEEDS_RESET?
-         */
         qemu_log_mask(LOG_GUEST_ERROR,
                 "%s: virtio-snd command size incorrect %zu vs \
                 %zu\n", __func__, msg_sz, sizeof(virtio_snd_hdr));
-- 
2.47.3


