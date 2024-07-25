Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C56FAC3DA7F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:11:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8L4-000253-EU; Thu, 25 Jul 2024 19:57:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Kv-0001Vz-9J; Thu, 25 Jul 2024 19:57:30 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Ks-0001Oc-Ti; Thu, 25 Jul 2024 19:57:28 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-7163489149eso336034a12.1; 
 Thu, 25 Jul 2024 16:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951845; x=1722556645; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dhji2tzCt7V0bCKi9OaRajRAvFKebIz+tSdljnjixRU=;
 b=jLiyRsLduOdXP3dJjt0zF8vNdw629j+PHpJUHEmu4FrtMCjTny/DBIDlgIUOosV41k
 WG67WnI2XqG3szsBjhI/itFaMOWvRkQYNgS2cpEGs+y+/QpDOJJjiIRt/KAg/xye518C
 vP+hQiqbydTz1FJLzlAxdDxQbZyDsRgz7CmaR3u9ZiROmgv+Wimw2eyp1Kxz87drlA3z
 AaxnGdKULyHcxzfLfjwHsOMZngbcgYghttD44puM8TaP/T1u7K/gP1BesSul4LVBeLUx
 UDEoondmwPyyoryeB7PqCAqAeWZqRnqF930Al1xCb7m7tm3nBgqldTGVYX7zBeOzRv/U
 xTMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951845; x=1722556645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dhji2tzCt7V0bCKi9OaRajRAvFKebIz+tSdljnjixRU=;
 b=JzOguyCcNAqhYZbNU691ESPOnrn5zGD71IrRba7/T40HhhzAZtLnOLMuQItQuBHMvR
 b9u138qkK2DkemEqctT4M73bocxk8PdbACKd6tJRbVkIq9wvXRwfuu45jBGY4xXSGY/x
 KUyD26l8qbZlCGKz2hP6SNeTTY7+Wpge5UmfZrKFU6+RVNp2P1hwI4TS/39GlTgF9USU
 nXglVohmjKqkj80E6qICCx8+RHK49NQojX9ixueWnWWp6vjQeBPeCl4GHbATAAlio3wJ
 GFJrWmhBU5JvQTZ+C3wxhyE1C32B/feW6EMvLU/5cG8OhcqpkMBJ9c3DX8Uu4FhUs8yT
 H2Lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeqdJtxqPHPsNqTfEhC9tcgNfQJNSKdKEbrs7Td/eTCMrtX+I46XkTf1SIhAU4lcRePuwteEZ6Jz3NdEBabrW5u73v
X-Gm-Message-State: AOJu0YzKwQg3EgttDSGlIw+j6MCn4j4xirVfDgKNK315LIwtZJ3ryHeM
 FQJJVmXebHj3ReyoK4oWfNIsa+1V2mewMOOw5IEWl3h+izU45Nq48Ok44Q==
X-Google-Smtp-Source: AGHT+IExY5WcUiBmtdbK40DSFUFaomZ5d9Kwz63bcUdSLW1s6pt2v4c0YeC4cONdYnrSfTunCNHOHw==
X-Received: by 2002:a17:90a:b704:b0:2cb:4f14:2a70 with SMTP id
 98e67ed59e1d1-2cf2eb6b180mr3763254a91.30.1721951844440; 
 Thu, 25 Jul 2024 16:57:24 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.57.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:57:23 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Frederic Barrat <fbarrat@linux.ibm.com>,
 Michael Kowal <kowal@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 50/96] pnv/xive2: Move xive2_nvp_pic_print_info() to xive2.c
Date: Fri, 26 Jul 2024 09:53:23 +1000
Message-ID: <20240725235410.451624-51-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Frederic Barrat <fbarrat@linux.ibm.com>

Moving xive2_nvp_pic_print_info() to align with the other "pic_print_info"
functions.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.vnet.ibm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/pnv_xive2.c         | 27 ---------------------------
 hw/intc/xive2.c             | 26 ++++++++++++++++++++++++++
 include/hw/ppc/xive2_regs.h |  2 ++
 3 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index 9fbd44f974..78609105a8 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -2436,33 +2436,6 @@ static void pnv_xive2_register_types(void)
 
 type_init(pnv_xive2_register_types)
 
-static void xive2_nvp_pic_print_info(Xive2Nvp *nvp, uint32_t nvp_idx,
-                                     GString *buf)
-{
-    uint8_t  eq_blk = xive_get_field32(NVP2_W5_VP_END_BLOCK, nvp->w5);
-    uint32_t eq_idx = xive_get_field32(NVP2_W5_VP_END_INDEX, nvp->w5);
-
-    if (!xive2_nvp_is_valid(nvp)) {
-        return;
-    }
-
-    g_string_append_printf(buf, "  %08x end:%02x/%04x IPB:%02x",
-                           nvp_idx, eq_blk, eq_idx,
-                           xive_get_field32(NVP2_W2_IPB, nvp->w2));
-    /*
-     * When the NVP is HW controlled, more fields are updated
-     */
-    if (xive2_nvp_is_hw(nvp)) {
-        g_string_append_printf(buf, " CPPR:%02x",
-                               xive_get_field32(NVP2_W2_CPPR, nvp->w2));
-        if (xive2_nvp_is_co(nvp)) {
-            g_string_append_printf(buf, " CO:%04x",
-                                   xive_get_field32(NVP2_W1_CO_THRID, nvp->w1));
-        }
-    }
-    g_string_append_c(buf, '\n');
-}
-
 /*
  * If the table is direct, we can compute the number of PQ entries
  * provisioned by FW.
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 3e7238c663..ac914b3d1c 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -137,6 +137,32 @@ void xive2_end_eas_pic_print_info(Xive2End *end, uint32_t end_idx,
                            (uint32_t) xive_get_field64(EAS2_END_DATA, eas->w));
 }
 
+void xive2_nvp_pic_print_info(Xive2Nvp *nvp, uint32_t nvp_idx, GString *buf)
+{
+    uint8_t  eq_blk = xive_get_field32(NVP2_W5_VP_END_BLOCK, nvp->w5);
+    uint32_t eq_idx = xive_get_field32(NVP2_W5_VP_END_INDEX, nvp->w5);
+
+    if (!xive2_nvp_is_valid(nvp)) {
+        return;
+    }
+
+    g_string_append_printf(buf, "  %08x end:%02x/%04x IPB:%02x",
+                           nvp_idx, eq_blk, eq_idx,
+                           xive_get_field32(NVP2_W2_IPB, nvp->w2));
+    /*
+     * When the NVP is HW controlled, more fields are updated
+     */
+    if (xive2_nvp_is_hw(nvp)) {
+        g_string_append_printf(buf, " CPPR:%02x",
+                               xive_get_field32(NVP2_W2_CPPR, nvp->w2));
+        if (xive2_nvp_is_co(nvp)) {
+            g_string_append_printf(buf, " CO:%04x",
+                                   xive_get_field32(NVP2_W1_CO_THRID, nvp->w1));
+        }
+    }
+    g_string_append_c(buf, '\n');
+}
+
 static void xive2_end_enqueue(Xive2End *end, uint32_t data)
 {
     uint64_t qaddr_base = xive2_end_qaddr(end);
diff --git a/include/hw/ppc/xive2_regs.h b/include/hw/ppc/xive2_regs.h
index 4e5e17cd89..ec5d6ec2d6 100644
--- a/include/hw/ppc/xive2_regs.h
+++ b/include/hw/ppc/xive2_regs.h
@@ -194,6 +194,8 @@ static inline uint32_t xive2_nvp_blk(uint32_t cam_line)
     return (cam_line >> XIVE2_NVP_SHIFT) & 0xf;
 }
 
+void xive2_nvp_pic_print_info(Xive2Nvp *nvp, uint32_t nvp_idx, GString *buf);
+
 /*
  * Notification Virtual Group or Crowd (NVG/NVC)
  */
-- 
2.45.2


