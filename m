Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5436CEC1112
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 17:05:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuZKQ-0001bR-Ha; Mon, 23 Feb 2026 12:02:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKO-0001Ws-OV
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:36 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKM-00008c-GX
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:36 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4806f3fc50bso52094655e9.0
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 09:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771866153; x=1772470953; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rI8w6+BLR7AIEMKcPcd3cXRfHRMFTz+JQnWzwQz4nis=;
 b=vxugCIrntowNVHB6OHyqNmBAMPlxTghbaah7svHNaDLK/JhYW6Jl0LFZ1mHe7yZ4ck
 ZXUUv+XZIB2lMa1xPWe+a7qV+NVK8gpgkqMkzjajnYqox+ILgheL068XNrRyhWd5Yfus
 ca+0DhBaO6RI02CdMg8DmNA+4Wrpz1R/wjl2yq51llX/03SA+VyXZjvAu3msC0+o5T23
 sYIDrR9/thRlBm+g5TI2P/i3Q4DhB1hLMjwchb7a2SMsOdetRBfzU7WluZ2SAVEqONQ/
 MQP13oP/oTXahL05x77iEtHGcLaNBO/2JP99Xt4yHxbuyL/VvUEYF5qFdtKrExh6t8MQ
 LEgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771866153; x=1772470953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rI8w6+BLR7AIEMKcPcd3cXRfHRMFTz+JQnWzwQz4nis=;
 b=Eshgxsidvx22nsL52ZC/RZiIixl4xJHtWtCZ7PRTQJi/LqMw9y794oqa2NaCKd3o+T
 sYv+R4JCjUIqD2zRLvae6sf8t0q8IbGG9+qVRTHi4eQdEEMnX7S/yy5vjf/WbE/zUQiw
 wKhtQdTXu+3mOYlbofZv9jKT6LB9U/bzA6l3wHVkCBdFdqZ0ZjEg5ow+a8a//7exdMwG
 hQ8JowOMLXxu6n1GTF4Wc6mXEWw2DyX1FGlTmbTvG4XLgUvJcYpliyWPtphxdLSprGNE
 yrd5nmM6DDCQsIIyAZys5pKqte0umxgBh3QKdtj8pES1mvwRu5TGTgK1oNzZ82iQaDCW
 jUGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4bGhW7TGpKBNn1D7o3Rh7zkSf8bsixYQltnKRybGoX7J/3w7QNoFky/IhpEd2uMftRtTaUjHt43OE@nongnu.org
X-Gm-Message-State: AOJu0YyXtXWcDZctIZ0+TddFOnmY687rXRi3GML4I9LmOHNe5s6mP6K+
 cVG2eXugtYvyv63XsBnmwF67l8tPBEBBx3eyT18LcHaWiB5Q6ynM6HlPkyKf5BYTNYI=
X-Gm-Gg: AZuq6aJtJTca6YTzSxr1ga1cxbnE62RLZwCiUlDpmrgbBciCDrlLFb8c5eOtyn8oBx6
 n8Wbh6lkB69ZfokfvdpcrQbdENUUKb8hZOsHOFcUzG1r+6jy+gh4hb44008xZE7nS0xZ9abqrEZ
 m1TCivgqVT15+p7u+R/eEX7Ol0Y/bf9PXrzd+1e4bOqveVkUOncIFd6k0WbcKDD3NKMjef5IGOZ
 JStHu1vkmgJiaAMV3waCKbd3wjkjjE3L+wVOOBMl+n2PNZibd/kddo1M/7zC7GZA0L8invOZWlw
 OtlCbtYClISGRsir+1VkQfGKN0XH9wyAlazaOweBtBUj19SRkI6rK6xAxqq8s8QkfDZheyNT4xp
 1AKchLrhjJkghupGBp3CW53QjbyeZfQyHm3/yJiz70d6ipgkVEq5B9dU8HTn0fVhte/deGgZnhB
 693O8mdZ4GLIDjG3iI4/4ViRz8SRFNMLzFe8v6TmxnAsvSz/td+TZ06O1sGvKAdTtQJTH0B4ov7
 l54I06Hsci6Bny4vbVi5akd2KhT+6Y=
X-Received: by 2002:a05:600c:4744:b0:482:f564:d613 with SMTP id
 5b1f17b1804b1-483a960892bmr163968095e9.15.1771866152838; 
 Mon, 23 Feb 2026 09:02:32 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a9b21ceasm200155625e9.0.2026.02.23.09.02.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 09:02:31 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 15/65] hw/intc/arm_gicv5: Implement IRS_IST_{BASER, STATUSR,
 CFGR}
Date: Mon, 23 Feb 2026 17:01:22 +0000
Message-ID: <20260223170212.441276-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223170212.441276-1-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Implement the three registers that handle configuration of the
interrupt status table for physical LPIs:

 * IRS_IST_BASER holds the base address of the table, and
   has the VALID bit that tells the IRS to start using the config
 * IRS_IST_CFGR has all the other config data for the table
 * IRS_IST_STATUSR has the IDLE bit that tells software when
   updates to IRS_IST_BASER have taken effect

Implement these registers.  Note that neither BASER nor CFGR can be
written when VALID == 1, except to clear the VALID bit.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv5.c                | 71 ++++++++++++++++++++++++++++++
 hw/intc/arm_gicv5_common.c         |  4 ++
 include/hw/intc/arm_gicv5_common.h |  3 ++
 3 files changed, 78 insertions(+)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index f34bb81966..f5933197ea 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -265,6 +265,24 @@ REG64(IRS_SWERR_SYNDROMER0, 0x3c8)
 REG64(IRS_SWERR_SYNDROMER1, 0x3d0)
     FIELD(IRS_SWERR_SYNDROMER2, ADDR, 3, 53)
 
+static void irs_ist_baser_write(GICv5 *s, GICv5Domain domain, uint64_t value)
+{
+    GICv5Common *cs = ARM_GICV5_COMMON(s);
+
+    if (FIELD_EX64(cs->irs_ist_baser[domain], IRS_IST_BASER, VALID)) {
+        /* If VALID is set, ADDR is RO and we can only update VALID */
+        bool valid = FIELD_EX64(value, IRS_IST_BASER, VALID);
+        if (valid) {
+            /* Ignore 1->1 transition */
+            return;
+        }
+        cs->irs_ist_baser[domain] = FIELD_DP64(cs->irs_ist_baser[domain],
+                                               IRS_IST_BASER, VALID, valid);
+        return;
+    }
+    cs->irs_ist_baser[domain] = value;
+}
+
 static bool config_readl(GICv5 *s, GICv5Domain domain, hwaddr offset,
                          uint64_t *data, MemTxAttrs attrs)
 {
@@ -323,6 +341,26 @@ static bool config_readl(GICv5 *s, GICv5Domain domain, hwaddr offset,
     case A_IRS_AIDR:
         *data = cs->irs_aidr;
         return true;
+
+    case A_IRS_IST_BASER:
+        *data = extract64(cs->irs_ist_baser[domain], 0, 32);
+        return true;
+
+    case A_IRS_IST_BASER + 4:
+        *data = extract64(cs->irs_ist_baser[domain], 32, 32);
+        return true;
+
+    case A_IRS_IST_STATUSR:
+        /*
+         * For QEMU writes to IRS_IST_BASER and IRS_MAP_L2_ISTR take effect
+         * instantaneously, and the guest can never see the IDLE bit as 0.
+         */
+        *data = R_IRS_IST_STATUSR_IDLE_MASK;
+        return true;
+
+    case A_IRS_IST_CFGR:
+        *data = cs->irs_ist_cfgr[domain];
+        return true;
     }
     return false;
 }
@@ -330,18 +368,51 @@ static bool config_readl(GICv5 *s, GICv5Domain domain, hwaddr offset,
 static bool config_writel(GICv5 *s, GICv5Domain domain, hwaddr offset,
                           uint64_t data, MemTxAttrs attrs)
 {
+    GICv5Common *cs = ARM_GICV5_COMMON(s);
+
+    switch (offset) {
+    case A_IRS_IST_BASER:
+        irs_ist_baser_write(s, domain,
+                            deposit64(cs->irs_ist_baser[domain], 0, 32, data));
+        return true;
+    case A_IRS_IST_BASER + 4:
+        irs_ist_baser_write(s, domain,
+                            deposit64(cs->irs_ist_baser[domain], 32, 32, data));
+        return true;
+    case A_IRS_IST_CFGR:
+        if (FIELD_EX64(cs->irs_ist_baser[domain], IRS_IST_BASER, VALID)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "guest tried to write IRS_IST_CFGR for %s config frame "
+                          "while IST_BASER.VALID set\n", domain_name[domain]);
+        } else {
+            cs->irs_ist_cfgr[domain] = data;
+        }
+        return true;
+    }
     return false;
 }
 
 static bool config_readll(GICv5 *s, GICv5Domain domain, hwaddr offset,
                           uint64_t *data, MemTxAttrs attrs)
 {
+    GICv5Common *cs = ARM_GICV5_COMMON(s);
+
+    switch (offset) {
+    case A_IRS_IST_BASER:
+        *data = cs->irs_ist_baser[domain];
+        return true;
+    }
     return false;
 }
 
 static bool config_writell(GICv5 *s, GICv5Domain domain, hwaddr offset,
                            uint64_t data, MemTxAttrs attrs)
 {
+    switch (offset) {
+    case A_IRS_IST_BASER:
+        irs_ist_baser_write(s, domain, data);
+        return true;
+    }
     return false;
 }
 
diff --git a/hw/intc/arm_gicv5_common.c b/hw/intc/arm_gicv5_common.c
index 046dcdf5a3..751df2001c 100644
--- a/hw/intc/arm_gicv5_common.c
+++ b/hw/intc/arm_gicv5_common.c
@@ -62,6 +62,10 @@ void gicv5_common_init_irqs_and_mmio(GICv5Common *cs,
 
 static void gicv5_common_reset_hold(Object *obj, ResetType type)
 {
+    GICv5Common *cs = ARM_GICV5_COMMON(obj);
+
+    memset(cs->irs_ist_baser, 0, sizeof(cs->irs_ist_baser));
+    memset(cs->irs_ist_cfgr, 0, sizeof(cs->irs_ist_cfgr));
 }
 
 static void gicv5_common_init(Object *obj)
diff --git a/include/hw/intc/arm_gicv5_common.h b/include/hw/intc/arm_gicv5_common.h
index 7db2c87ddc..2a49d58679 100644
--- a/include/hw/intc/arm_gicv5_common.h
+++ b/include/hw/intc/arm_gicv5_common.h
@@ -62,6 +62,9 @@ struct GICv5Common {
 
     MemoryRegion iomem[NUM_GICV5_DOMAINS];
 
+    uint64_t irs_ist_baser[NUM_GICV5_DOMAINS];
+    uint32_t irs_ist_cfgr[NUM_GICV5_DOMAINS];
+
     /* Bits here are set for each physical interrupt domain implemented */
     uint8_t implemented_domains;
 
-- 
2.43.0


