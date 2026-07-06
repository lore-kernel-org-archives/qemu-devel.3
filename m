Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48BE5C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:45:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgs3Y-0001sG-Vj; Mon, 06 Jul 2026 18:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wgs3W-0001j5-59; Mon, 06 Jul 2026 18:44:50 -0400
Received: from fhigh-b8-smtp.messagingengine.com ([202.12.124.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wgs3U-0000wF-6t; Mon, 06 Jul 2026 18:44:49 -0400
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id B13677A01DD;
 Mon,  6 Jul 2026 18:44:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Mon, 06 Jul 2026 18:44:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1783377886; x=
 1783464286; bh=01r+ZCPo4PvZmuDTdlJehJjsdM0SEGXP4aeZBzGR2Kg=; b=U
 2D3KqnapzskqeZXUm4neikSg/UeWfF2fV8XSg2bMPGAMj7wM0Kv/cjuOhpKHLiKx
 UQpL1PNWKKb5BkIR+YH16guMcbia5MhAFjsRDbLVyi7qcra7qLhjaN+iXgNe1xXJ
 gHEb/NZj7kJkBrNPf5M3asGmwZmQfMrRHMd2EsE0Zib0qsNwPcwwWUvD6RzsmQlD
 BlFeP9aY4zfyBF5KoT+ykv2TyAXUh+/YOKXkuhNgQaoVnyyId+ialN/+x/WpbeTy
 Lgs9jJGRria1AquLOuWIbKyRrV5n7WKIsY7reZWqbPtkRQOg65ohWkUt41lb36ud
 g0lVzxeVvf0s+ZrDgveDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1783377886; x=1783464286; bh=0
 1r+ZCPo4PvZmuDTdlJehJjsdM0SEGXP4aeZBzGR2Kg=; b=aSCjByYr12qhp0zWB
 q+erJLd9SDJNwjRCFrl5KctFxdq6jx9uBKLad7AgX8uYUVMn1o4vnF1EZJlUAbww
 XTnYq7+milgLgtdYfYwzHmwoXJVbQeTq582ULQ9/T3yf79nZljtnbAeAV6ONJc7P
 o60gbUpnzKMnTdf4b/E+CT3prTJIgQvoV6jMbpbXv7Op6Sbwo9BTZ18oNsNO8Os6
 yvgqne9G/A1iyRs3jloQ9z5YXz1mzlS1I4zReCtZrYYvn8qIzyqk0xBQqM0s6LqW
 ToewyP0eShW4K83+ghQAlH0kn4JhVbjdmK/mhfaGJz1tE0j3VTOUkiQdJbm6tn11
 uVbxg==
X-ME-Sender: <xms:3i9MaglAoE5I7Vv9WVPzU8CDYXe1Ku1JJfPja-ZkXpRrXIudmoM6AA>
 <xme:3i9MagQQsVv5b2yEYqmmzugWN0vrSKZoPkOZkW4PU22tDEw_vTGIEw05PMtEGpyBC
 kxnigixWc6RI36FpmVNw9WL-OnifxGtJ9FqmTwQPqYaYStXUMcgP1Y6>
X-ME-Received: <xmr:3i9MavVlfiNy05RPXCQFlYZub8R8prkjmm43L7tR5IAfhxd5Gce_T5n9LpVmTQ0x0lXfi-wo0W2zxnd76lisIuc-yug5OvjWsHYVkJMqesyUJdNoG6AhHDmkrg>
X-ME-Proxy-Cause: dmFkZTE7v849ilEkFjUpDUSaiq1uMOu/R/xvF5klO3DvrAI67IkU8xQbZDLRCZPCZZpXDZ
 8IVKKHf3bURWtK1H7DUwaXYv3vqf6fJmJiV7VYlGtvWMpLfpKXnnn/Wu6+a2NLJxfuIdFs
 s5jMRUhwn8Ox0g3k8pgQSZHfcNR/ft2gFinCk8awAzyiaa6sO81d1EQpyql7nyXV6WnUvO
 P/B/f2HNVaOTGbrzdG02lmCkzzrC6VhvavK+aYDnZ9M4MM2GWaUjxSC2Qy7esF9vrsEzeP
 OGYzuX8S63Q0tuMS0LImlTPNY6W7TfP5vYgULcx+rZyG1i5W71Tve2PJJ3/RGeJ9RMSzjy
 4VIubdX05dsIqSc29Z72Q8fIqSr2F1LzY0xzPN5I4jbeB5K/sMnK70J9RwP91I1R21B//o
 nG3apUA723RhGHEpmSM+uUx8Pz9mS4laodNOUSFMCpt1PZtmCwShfk5VneZpPirIx+MifI
 CXWRipLom3xj53BNrMFWu1plg/t0K2gOOHDsyV1qp232/3GGMIH2Y5AJP5NrGt5v2gkae9
 wtuhFcJxAaaitm/lXjefRpSgrIXHiItDC90DZEyhmi5y8sK5SrzmBle2ix9azde5UEmqBP
 39ih2bq+6yeEL9wvi9mWm5oJpUgPZGqmYH41wnANTwdwOwhnbMxXAg6wVqnQ
X-ME-Proxy: <xmx:3i9MakJuE5jISvQr2AOaW8wga_ojjd43qNk435TJPsTRU7iZsMpaTQ>
 <xmx:3i9Mav1204ltgAgUAsTTdLcudCc1rlEtm0dFGRNh_Bo8h5MjTixDcg>
 <xmx:3i9MahL5ofNYFVl1fX3GEjcFtoGR7Y_3qOlMaapuzC1oeS9ThoYKTw>
 <xmx:3i9MaqgQc9ZKDNtZ0dIgh-Qtzw_kzGAxN3yIxVAeMl_MV6anosyyYg>
 <xmx:3i9Masv_Xl344yeyBsWmqO9miLeItzQmx-kV0Sv-m6-nTGlLl3WR1o1k>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 18:44:44 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jesper Wendel Devantier <j.devantier@samsung.com>, qemu-stable@nongnu.org,
 jaeyeong <fin@spl.team>, Jesper Wendel Devantier <foss@defmacro.it>,
 Klaus Jensen <k.jensen@samsung.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
Subject: [PULL 01/11] hw/nvme: fix FDP set FDP events
Date: Tue,  7 Jul 2026 00:44:13 +0200
Message-ID: <20260706224426.14156-2-its@irrelevant.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706224426.14156-1-its@irrelevant.dk>
References: <20260706224426.14156-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.159; envelope-from=its@irrelevant.dk;
 helo=fhigh-b8-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

From: Jesper Wendel Devantier <j.devantier@samsung.com>

Addresses an issue reported whereby user-provided event type values
could trigger two issues:

 1. if provided event_type == 0xff -> out-of-bounds access

 2. if provided event_type > 7 -> generate a value too large for the
    u8 event mask.

This patch fixes (1) by correctly adjusting the length of the look-up
array to be 256 values.
This patch fixes (2) by:
  a. changing the event_type mask to 64bit, matching
     NvmeRuHandle.event_filter
  b. Matching the behavior of Get Feature - FDP Events by skipping
     event type values which we do not support.
     5.2.26.1.21 of the 2.3 Base specification does not explicitly
     tell us to reject unsupported event type values.
  c. Documenting in the event type lookup table, that supporting
     event types greater than 63 requires refactoring the masking
     code.

Cc: qemu-stable@nongnu.org
Reported-by: jaeyeong <fin@spl.team>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3631
Signed-off-by: Jesper Wendel Devantier <foss@defmacro.it>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 22 ++++++++++++++++------
 hw/nvme/nvme.h |  9 ++++++++-
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 815f39173c8a..d60a680dbc15 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -6244,10 +6244,6 @@ static uint16_t nvme_get_feature_fdp_events(NvmeCtrl *n, NvmeNamespace *ns,
     for (uint8_t event_type = 0; event_type < FDP_EVT_MAX; event_type++) {
         uint8_t shift = nvme_fdp_evf_shifts[event_type];
         if (!shift && event_type) {
-            /*
-             * only first entry (event_type == 0) has a shift value of 0
-             * other entries are simply unpopulated.
-             */
             continue;
         }
 
@@ -6492,9 +6488,9 @@ static uint16_t nvme_set_feature_fdp_events(NvmeCtrl *n, NvmeNamespace *ns,
     uint8_t noet = (cdw11 >> 16) & 0xff;
     uint16_t ret, ruhid;
     uint8_t enable = le32_to_cpu(cmd->cdw12) & 0x1;
-    uint8_t event_mask = 0;
+    uint64_t event_mask = 0;
     unsigned int i;
-    g_autofree uint8_t *events = g_malloc0(noet);
+    g_autofree uint8_t *events = NULL;
     NvmeRuHandle *ruh = NULL;
 
     assert(ns);
@@ -6507,15 +6503,29 @@ static uint16_t nvme_set_feature_fdp_events(NvmeCtrl *n, NvmeNamespace *ns,
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
+    if (unlikely(noet == 0)) {
+        return NVME_SUCCESS;
+    }
+
     ruhid = ns->fdp.phs[ph];
     ruh = &n->subsys->endgrp.fdp.ruhs[ruhid];
 
+    events = g_malloc0(noet);
+
     ret = nvme_h2c(n, events, noet, req);
     if (ret) {
         return ret;
     }
 
     for (i = 0; i < noet; i++) {
+        /*
+         * We ignore requests to enable tracking of unsupported FDP event types
+         */
+        uint8_t event_type = events[i];
+        uint8_t shift = nvme_fdp_evf_shifts[event_type];
+        if (!shift && event_type) {
+            continue;
+        }
         event_mask |= (1 << nvme_fdp_evf_shifts[events[i]]);
     }
 
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index 5ef3ebee29e5..9de9f347c542 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -160,7 +160,14 @@ typedef struct NvmeZone {
 #define NVME_FDP_MAX_NS_RUHS 32u
 #define FDPVSS 0
 
-static const uint8_t nvme_fdp_evf_shifts[FDP_EVT_MAX] = {
+/*
+ * NOTE: Apart from event type 0, any event type with a shift value of 0 is
+ * considered unsupported and thus skipped in get/set features calls.
+ *
+ * NOTE: NvmeRuHandle uses a 64bit event mask - refactor to support event types
+ *       of 63 or greater.
+ */
+static const uint8_t nvme_fdp_evf_shifts[FDP_EVT_MAX + 1] = {
     /* Host events */
     [FDP_EVT_RU_NOT_FULLY_WRITTEN]      = 0,
     [FDP_EVT_RU_ATL_EXCEEDED]           = 1,
-- 
2.53.0


