Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A69CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 07:37:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPbTZ-00061B-Rm; Wed, 20 May 2026 03:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>)
 id 1wPbSW-0005wl-VO; Wed, 20 May 2026 03:35:24 -0400
Received: from fhigh-a5-smtp.messagingengine.com ([103.168.172.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>)
 id 1wPbSU-0006aY-Br; Wed, 20 May 2026 03:35:16 -0400
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 39B881400090;
 Wed, 20 May 2026 03:35:10 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Wed, 20 May 2026 03:35:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defmacro.it; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm3; t=1779262510; x=1779348910; bh=JK
 eN5BOGrJZ/X526a+zMxWSbWG+S2L/h2Tw1iPeeYZI=; b=GI4hNdGdnAYLsEYQR+
 xnLL8NK/v9ziBZbZBY7yClFU8O0uMljoK9so2ioCwrYh01hO/ZCAefRV4TlUwqs4
 ikltl0etAVa3447dOri5bAreUo5jUGC4oRtQ6Jyhxp+7xrwwakGtS/1I7UZQGAxu
 Q4RXl/OYNAHzOdRAn87jrqeHRcjHIZaB8KInYjeCxK9uLBsjEhnl6khgxI5yY+GI
 bmzvfY4FQaJbnw5V/Mrz/rGwsUy24RXrLf1Y80l9ARhIguWppmBfQ7eQZzXiyCaR
 AZpDJPA7EWrWbF65iEu9r7+I983X0CTf7a1VXET7hBjDBGx4dsAcDNCsmOPtcuvc
 D1Og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1779262510; x=1779348910; bh=JKeN5BOGrJZ/X526a+zMxWSbWG+S
 2L/h2Tw1iPeeYZI=; b=kkKRrReHJIE3OEqQLfby4uQ/vW5vfn3a2TJv7oeWQu8n
 WPz7JjZFmpJHWbXNDUKhxxP67XgEtiRY2rbClCHEkYI+IXuIWtVv9eUaDoTjNAMV
 hqX/74oPfGWjq/29GQ9acoi1btuVwaEvquRTBxg6wsK/eQeFJ/Z1evdygH5Xdgxl
 MlWGDo7ByYbX9Nq0P2jqZHtH/9cojChdsN/qUx9/BhrN0rH5j8QQ8sdn/eqprAt6
 JoaY2oQmK907p8nop+A4f9wbPYdxJbS/hVfvuVNbRfLmtNCZPCK0IU3/jvob46Jg
 qG3MzUdIwK4NLzOiBFhcokZpLGBiDwcA10CwiK97YQ==
X-ME-Sender: <xms:LGQNav4rqDx8AA1JH8aNV5Y8pD_RntEVxDStqlB5spbwQsNLW2vNiA>
 <xme:LGQNav0NeUzRqk88qlAgmXU_3JSjNw5QMm5TntsiBfDZMMY0OOwWPJkwPuYgOsX3a
 kFnC4KxK9GMH3v-vyUK8bRjFD_J023UCJdzsPjfReug-8LbvPNQag4>
X-ME-Received: <xmr:LGQNale5YKs_eLgoMtxYYwvdQ0gCgofyRPnPXMnjeWQ1V_nkUcB1Lnpc1KeR4AytvgMEaLS-RUlG2wzMKuqb_xpUilAkYawbNC3-lR10>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeegtdegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephfffufggtgfgkffvvefosehtjeertdertdejnecuhfhrohhmpeflvghsphgvrhcu
 ffgvvhgrnhhtihgvrhcuoehfohhsshesuggvfhhmrggtrhhordhitheqnecuggftrfgrth
 htvghrnhepieeuheevgfekleetleeghffhveeiheejgefffeeggefffeejgeeivedvveej
 ueevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfh
 hoshhsseguvghfmhgrtghrohdrihhtpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
 thhpohhuthdprhgtphhtthhopehfohhsshesuggvfhhmrggtrhhordhithdprhgtphhtth
 hopehjrdguvghvrghnthhivghrsehsrghmshhunhhgrdgtohhmpdhrtghpthhtohepihht
 shesihhrrhgvlhgvvhgrnhhtrdgukhdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnh
 honhhgnhhurdhorhhgpdhrtghpthhtohepfhhinhesshhplhdrthgvrghmpdhrtghpthht
 ohepqhgvmhhuqdgslhhotghksehnohhnghhnuhdrohhrghdprhgtphhtthhopehksghush
 gthheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:LGQNalcYtStcwfuSXyD8qIueksbFeTqcBg_RjrA4qEMSKsJaZZmJlA>
 <xmx:LGQNagxjcR3p_imhLCZ_G3BuubPV06KutdMegHEzANrRJqXjaV8Jng>
 <xmx:LGQNak9iA66Ai_rdNN6JFCrJd8p2zM7oNbNg5wVPtAu0EYdDLfbADA>
 <xmx:LGQNagiqTIx8wV8ivnxpEklw25KlFTxLm_FZywnXIWtJ5_0iin4DMw>
 <xmx:LmQNatKwvKNbLKg1VZa8J6DQ8TL46MQtLSdzL0Nipnm96SX7pvvD_2e3>
Feedback-ID: ic0014905:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 May 2026 03:35:07 -0400 (EDT)
From: Jesper Devantier <foss@defmacro.it>
Date: Wed, 20 May 2026 09:35:02 +0200
Subject: [PATCH] hw/nvme: FDP set FDP events - fixes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-patch-review-20260518131523-654-v1-1-ea64f249177c@samsung.com>
X-B4-Tracking: v=1; b=H4sIACVkDWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDU0NL3YLEkuQMXZDS1HJdqKiFobGhqZGxrpmpia6ZuaVlkpmxoWWaRao
 S0JSCotS0zAqwDdGxtbUAf3Ycp3EAAAA=
X-Change-ID: 20260519-patch-review-20260518131523-654-6799b6319f8e
To: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 jaeyeong <fin@spl.team>, qemu-block@nongnu.org
Cc: Jesper Wendel Devantier <j.devantier@samsung.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=103.168.172.156; envelope-from=foss@defmacro.it;
 helo=fhigh-a5-smtp.messagingengine.com
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

Reported-by: jaeyeong <fin@spl.team>
Signed-off-by: Jesper Wendel Devantier <foss@defmacro.it>
---
Adresses issues raised by Jaeyeong (thanks!) regarding the
handling of the user-supplied list of event types to track.

As reported, the event mask is much too small to cover the legal
range of 256 values (0-255) and would fail even for event types
0x80 and 0x81 which caused shifts of 32 and 33 places - beyond
the limit of the u8 event mask.

Secondarily, the report also pointed out that unsupported event
types would cause a lookup in the bit-shift table to return 0,
meaning unsupported events would effectively toggle the
tracking of the event type 0x0 (RU not fully written).

This patch skips processing of unsupported event types,
increases the event filter mask size to accommodate currently
supported event types and documents behavior in the lookup
table.

Signed-off-by: Jesper Wendel Devantier <j.devantier@samsung.com>
---
 hw/nvme/ctrl.c | 22 ++++++++++++++++------
 hw/nvme/nvme.h |  9 ++++++++-
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 815f39173c..d60a680dbc 100644
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
index 5ef3ebee29..9de9f347c5 100644
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

---
base-commit: 91190a4303223c7971856f6b37f221cc91c62689
change-id: 20260519-patch-review-20260518131523-654-6799b6319f8e

Best regards,
-- 
Jesper Wendel Devantier <j.devantier@samsung.com>


