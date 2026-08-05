Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E44DC56203
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 15:33:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrdZg-0005rL-Ij; Wed, 05 Aug 2026 11:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <simonxhy0404@gmail.com>)
 id 1wrdZV-0005o9-VG
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 11:30:23 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <simonxhy0404@gmail.com>)
 id 1wrdZR-0007do-OF
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 11:30:20 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-495b27007d0so727899b6e.1
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 08:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785943816; x=1786548616; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k9yZcr4UWJCAebKRS40Pd2Dm5YZ9z3Ekl/CFHK6Os1I=;
 b=QrlwnLafuaqnM55PR5Sjk7qN5KVbc7Cc7/eX89eEd0CUzPxX9W02emAJKbIt6O05l7
 ldSuGtu12QKd2oCukkaFiwVIEFsgB8WrI8stJ+qb5D6T1nkS4TH6fiwiL85pwCH2rckd
 sK+WnoF2JR55LUq1Glekd26OpwE5TfyaQtIHJ0q/c2zA82sNycTxUNRKQzGAGYgQbcyA
 rGhhnwWespxqmqqMHNwf85xpjnR7u2U5CLvD+TM9LaKxXmaALfmw1sGaXlZxSYmmybF1
 Qu4i43xMdI4HQotYJ0X449OyDa4ijK8SzDeNmJgkIQn1WUV6sMQHCOqEAi4sLIYuawbU
 JZ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785943816; x=1786548616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=k9yZcr4UWJCAebKRS40Pd2Dm5YZ9z3Ekl/CFHK6Os1I=;
 b=AdHPpX1hQcTjA0rbc24qglrvWDRT32BWvLiWwnDKqI5oIxsIA3NXi/dBAWWzPDHEoF
 aeknEdc+nsuyfGXWPh7/pp987RUsPc5SxCw9MeVykclF8x9DxxiVkecGB/FPHHBvhU/D
 34Kzx1n5ouWY8bZ5M8eRi/CNyu7ZP+cRRJALRMTWaUx5CLoi0ryaj1kMfeRaiKFblDG0
 +MvTilko8WOHRMxJw2aGAhLYtglFwjfJ+Yq2zMRCwrmUj1DS1AJNm9tAkwPB7DQR/V75
 uK+jEDzhOlYf41HbpuSajht9UtrDFtO2kxu34OvOzNXhBv8xHAsNWENpw2K1h8MmIfgt
 w71w==
X-Gm-Message-State: AOJu0Yw3ukZFwPFobLJNC4Jpjb+TX2HAl9f7okoeI3U1/Pn+EOmW3p6U
 Ez/gpO4kr4Ad5k5MZyoSvxi7eh2QhyN6ihlbB1/lVBgooY3jXSrJ/zG6/bcGo8Iy
X-Gm-Gg: AR+sD13nK1xJggbeCUlXZmfg4rLRZVJn5Dk2XR9qiwtvuOFYh114PL2x6okgQUIOwIs
 9Uy7vPxFQY1GaW1/rNi3o4ATaqhTiwE54QMFydRBIyLu0xeaaKGe+EU4dtLvWC3rZr7jYvaHMxJ
 qJ+V5fsj1xD3Kl6HtPZ9RfGnAtQWJaXRhns6HC7O3VUkgJZeS/8fNohkhBTwZngc+KAx0URG51y
 4Pp9irmjuEiYu8eoJK08z7NgsqPG/OE2hxfHQ5v2rTR3BqE1xDMUkUk05UCmd44ZRjn2vtLjC4G
 RoNYWkB8cJ3i+tTwrbn6ZL0NUEArXMjyFhuM4PmkB5FO95YeUC1wZ955Wib6OLlCgapBt//HYhu
 wYG2gq42O03a6w2sIlKZLCZq3c041zS5GL9esiM+EWa3+lSwd2/47kS++mceB1/RbXYIJjW9syg
 QML9Vg/mf5QJKVwmFvAzXq5tucZgnMexgY9ITLfLcK8j7SGOg0w+uRdZBIYXuu2QjjNlEhX6DwZ
 Z/+Hcr/b4QE
X-Received: by 2002:a05:6808:3985:b0:494:18ad:8a5b with SMTP id
 5614622812f47-4afae0171a6mr4579392b6e.17.1785943815737; 
 Wed, 05 Aug 2026 08:30:15 -0700 (PDT)
Received: from HPE-2MQ6131DV6.ams.hpecorp.net ([170.85.99.9])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4afae75ce1bsm2185614b6e.15.2026.08.05.08.30.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 08:30:15 -0700 (PDT)
From: Simon Xu <simonxhy0404@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Owen Giles <owen.giles@hpe.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Robert Elliott <elliott@hpe.com>, Simon Xu <simonxhy0404@gmail.com>
Subject: [PATCH v2 6/9] hw/misc/iotkit-secctl.c: use GNU C case ranges
Date: Wed,  5 Aug 2026 10:30:02 -0500
Message-ID: <20260805153005.9989-7-simonxhy0404@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805153005.9989-1-simonxhy0404@gmail.com>
References: <20260805153005.9989-1-simonxhy0404@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=simonxhy0404@gmail.com; helo=mail-oi1-x231.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Replace case fall throughs with case ranges when register addresses
are continous.

Reviewed-by: Owen Giles <owen.giles@hpe.com>
Reviewed-by: Robert Elliott <elliott@hpe.com>
Signed-off-by: Simon Xu <simonxhy0404@gmail.com>
---
v1 -> v2
	Make long case statemens consistent with other iotkit files
---
 hw/misc/iotkit-secctl.c | 112 ++++++----------------------------------
 1 file changed, 16 insertions(+), 96 deletions(-)

diff --git a/hw/misc/iotkit-secctl.c b/hw/misc/iotkit-secctl.c
index 9f6fb81088..2d06d6f80f 100644
--- a/hw/misc/iotkit-secctl.c
+++ b/hw/misc/iotkit-secctl.c
@@ -187,36 +187,24 @@ static MemTxResult iotkit_secctl_s_read(void *opaque, hwaddr addr,
     case A_BRGINTEN:
         r = s->brginten;
         break;
-    case A_AHBNSPPCEXP0:
-    case A_AHBNSPPCEXP1:
-    case A_AHBNSPPCEXP2:
-    case A_AHBNSPPCEXP3:
+    case A_AHBNSPPCEXP0 ... A_AHBNSPPCEXP3:
         r = s->ahbexp[offset_to_ppc_idx(offset)].ns;
         break;
     case A_APBNSPPC0:
     case A_APBNSPPC1:
         r = s->apb[offset_to_ppc_idx(offset)].ns;
         break;
-    case A_APBNSPPCEXP0:
-    case A_APBNSPPCEXP1:
-    case A_APBNSPPCEXP2:
-    case A_APBNSPPCEXP3:
+    case A_APBNSPPCEXP0 ... A_APBNSPPCEXP3:
         r = s->apbexp[offset_to_ppc_idx(offset)].ns;
         break;
-    case A_AHBSPPPCEXP0:
-    case A_AHBSPPPCEXP1:
-    case A_AHBSPPPCEXP2:
-    case A_AHBSPPPCEXP3:
+    case A_AHBSPPPCEXP0 ... A_AHBSPPPCEXP3:
         r = s->ahbexp[offset_to_ppc_idx(offset)].sp;
         break;
     case A_APBSPPPC0:
     case A_APBSPPPC1:
         r = s->apb[offset_to_ppc_idx(offset)].sp;
         break;
-    case A_APBSPPPCEXP0:
-    case A_APBSPPPCEXP1:
-    case A_APBSPPPCEXP2:
-    case A_APBSPPPCEXP3:
+    case A_APBSPPPCEXP0 ... A_APBSPPPCEXP3:
         r = s->apbexp[offset_to_ppc_idx(offset)].sp;
         break;
     case A_SECMSCINTSTAT:
@@ -228,18 +216,7 @@ static MemTxResult iotkit_secctl_s_read(void *opaque, hwaddr addr,
     case A_NSMSCEXP:
         r = s->nsmscexp;
         break;
-    case A_PID4:
-    case A_PID5:
-    case A_PID6:
-    case A_PID7:
-    case A_PID0:
-    case A_PID1:
-    case A_PID2:
-    case A_PID3:
-    case A_CID0:
-    case A_CID1:
-    case A_CID2:
-    case A_CID3:
+    case A_PID4 ... A_CID3:
         switch (s->sse_version) {
         case ARMSSE_SSE300:
             r = iotkit_secctl_s_sse300_idregs[(offset - A_PID4) / 4];
@@ -389,10 +366,7 @@ static MemTxResult iotkit_secctl_s_write(void *opaque, hwaddr addr,
     case A_BRGINTEN:
         s->brginten = value & 0xffff0000;
         break;
-    case A_AHBNSPPCEXP0:
-    case A_AHBNSPPCEXP1:
-    case A_AHBNSPPCEXP2:
-    case A_AHBNSPPCEXP3:
+    case A_AHBNSPPCEXP0 ... A_AHBNSPPCEXP3:
         ppc = &s->ahbexp[offset_to_ppc_idx(offset)];
         iotkit_secctl_ppc_ns_write(ppc, value);
         break;
@@ -401,17 +375,11 @@ static MemTxResult iotkit_secctl_s_write(void *opaque, hwaddr addr,
         ppc = &s->apb[offset_to_ppc_idx(offset)];
         iotkit_secctl_ppc_ns_write(ppc, value);
         break;
-    case A_APBNSPPCEXP0:
-    case A_APBNSPPCEXP1:
-    case A_APBNSPPCEXP2:
-    case A_APBNSPPCEXP3:
+    case A_APBNSPPCEXP0 ... A_APBNSPPCEXP3:
         ppc = &s->apbexp[offset_to_ppc_idx(offset)];
         iotkit_secctl_ppc_ns_write(ppc, value);
         break;
-    case A_AHBSPPPCEXP0:
-    case A_AHBSPPPCEXP1:
-    case A_AHBSPPPCEXP2:
-    case A_AHBSPPPCEXP3:
+    case A_AHBSPPPCEXP0 ... A_AHBSPPPCEXP3:
         ppc = &s->ahbexp[offset_to_ppc_idx(offset)];
         iotkit_secctl_ppc_sp_write(ppc, value);
         break;
@@ -420,10 +388,7 @@ static MemTxResult iotkit_secctl_s_write(void *opaque, hwaddr addr,
         ppc = &s->apb[offset_to_ppc_idx(offset)];
         iotkit_secctl_ppc_sp_write(ppc, value);
         break;
-    case A_APBSPPPCEXP0:
-    case A_APBSPPPCEXP1:
-    case A_APBSPPPCEXP2:
-    case A_APBSPPPCEXP3:
+    case A_APBSPPPCEXP0 ... A_APBSPPPCEXP3:
         ppc = &s->apbexp[offset_to_ppc_idx(offset)];
         iotkit_secctl_ppc_sp_write(ppc, value);
         break;
@@ -444,18 +409,7 @@ static MemTxResult iotkit_secctl_s_write(void *opaque, hwaddr addr,
     case A_BRGINTSTAT:
     case A_AHBNSPPC0:
     case A_AHBSPPPC0:
-    case A_PID4:
-    case A_PID5:
-    case A_PID6:
-    case A_PID7:
-    case A_PID0:
-    case A_PID1:
-    case A_PID2:
-    case A_PID3:
-    case A_CID0:
-    case A_CID1:
-    case A_CID2:
-    case A_CID3:
+    case A_PID4 ... A_CID3:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "IoTKit SecCtl S block write: "
                       "read-only offset 0x%x\n", offset);
@@ -482,34 +436,17 @@ static MemTxResult iotkit_secctl_ns_read(void *opaque, hwaddr addr,
     case A_AHBNSPPPC0:
         r = 0;
         break;
-    case A_AHBNSPPPCEXP0:
-    case A_AHBNSPPPCEXP1:
-    case A_AHBNSPPPCEXP2:
-    case A_AHBNSPPPCEXP3:
+    case A_AHBNSPPPCEXP0 ... A_AHBNSPPPCEXP3:
         r = s->ahbexp[offset_to_ppc_idx(offset)].nsp;
         break;
     case A_APBNSPPPC0:
     case A_APBNSPPPC1:
         r = s->apb[offset_to_ppc_idx(offset)].nsp;
         break;
-    case A_APBNSPPPCEXP0:
-    case A_APBNSPPPCEXP1:
-    case A_APBNSPPPCEXP2:
-    case A_APBNSPPPCEXP3:
+    case A_APBNSPPPCEXP0 ... A_APBNSPPPCEXP3:
         r = s->apbexp[offset_to_ppc_idx(offset)].nsp;
         break;
-    case A_PID4:
-    case A_PID5:
-    case A_PID6:
-    case A_PID7:
-    case A_PID0:
-    case A_PID1:
-    case A_PID2:
-    case A_PID3:
-    case A_CID0:
-    case A_CID1:
-    case A_CID2:
-    case A_CID3:
+    case A_PID4 ... A_CID3:
         switch (s->sse_version) {
         case ARMSSE_SSE300:
             r = iotkit_secctl_ns_sse300_idregs[(offset - A_PID4) / 4];
@@ -560,10 +497,7 @@ static MemTxResult iotkit_secctl_ns_write(void *opaque, hwaddr addr,
     }
 
     switch (offset) {
-    case A_AHBNSPPPCEXP0:
-    case A_AHBNSPPPCEXP1:
-    case A_AHBNSPPPCEXP2:
-    case A_AHBNSPPPCEXP3:
+    case A_AHBNSPPPCEXP0 ... A_AHBNSPPPCEXP3:
         ppc = &s->ahbexp[offset_to_ppc_idx(offset)];
         iotkit_secctl_ppc_nsp_write(ppc, value);
         break;
@@ -572,26 +506,12 @@ static MemTxResult iotkit_secctl_ns_write(void *opaque, hwaddr addr,
         ppc = &s->apb[offset_to_ppc_idx(offset)];
         iotkit_secctl_ppc_nsp_write(ppc, value);
         break;
-    case A_APBNSPPPCEXP0:
-    case A_APBNSPPPCEXP1:
-    case A_APBNSPPPCEXP2:
-    case A_APBNSPPPCEXP3:
+    case A_APBNSPPPCEXP0 ... A_APBNSPPPCEXP3:
         ppc = &s->apbexp[offset_to_ppc_idx(offset)];
         iotkit_secctl_ppc_nsp_write(ppc, value);
         break;
     case A_AHBNSPPPC0:
-    case A_PID4:
-    case A_PID5:
-    case A_PID6:
-    case A_PID7:
-    case A_PID0:
-    case A_PID1:
-    case A_PID2:
-    case A_PID3:
-    case A_CID0:
-    case A_CID1:
-    case A_CID2:
-    case A_CID3:
+    case A_PID4 ... A_CID3:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "IoTKit SecCtl NS block write: "
                       "read-only offset 0x%x\n", offset);
-- 
2.53.0


