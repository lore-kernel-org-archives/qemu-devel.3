Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4913FCD3439
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:52:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL11M-0003VJ-C5; Thu, 07 May 2026 11:52:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11K-0003UN-6K
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:14 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11I-0003pv-8z
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:13 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488e1a8ac40so10270865e9.2
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169131; x=1778773931; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Cx6UY6cjzbWmySFBTXHxdQbyXCke8Db8bSXKc5mfifE=;
 b=yjpfGEdr4ji+tOZ0xsu7AN8R1/X30k27oFXlPAu0T4+xn/82tTwI7VAchpAxcg9X9C
 JVOQQvGvahNt66VxKG5XgJfiD50BcKu597M8O8XkBYOJOlaEkiGzOrGCqf5ItvCZIsUg
 LTKg+7VFVdSxHd4fDXujbsU5VTT9heMHPGUB46L8YNt8xqvZUrnnGRV5AYNGJaAkGaQ8
 qTEH6x0ZPn3udGJeqJ+rwxeYqGxyG7EPWpRk+WQfuwYTgMPeLTvDJqrqUyl17A5KznKh
 UF5J/CgluJY9gCcLPIjeUaDLvjdejSsu10lg3ZH8pectFul0rOfZ6nvhsz1b5PE4G1WU
 TxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169131; x=1778773931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Cx6UY6cjzbWmySFBTXHxdQbyXCke8Db8bSXKc5mfifE=;
 b=A2xDGkLOW7sgJ0xicYDHuKwrMlcXEyBpB5rzLO43DQJTyqIByRA4DPwzzt6w26M1HR
 Fl6VwENZjox7KKmQTzRb6zuLzmmVasYwWi2wmATWy7q7kD/PgEN8XOdaMS0bvCi5V+Qu
 94QF5DeSrMKy7UMLMFuCel+TAM6F4sP6eQLWiBmr0fb6REqG39K3TS+x/pjdwEG0Xlzp
 FDZyhx89rpPIExELnTyuks48E09Z50R2S2K/hAbFnj52fzIX9gkcM5+NvJOp2mR04ISt
 zdIphEGDGGshJVJOUBnMkuqleQexGhLKyDY4L53u0CLJWZEZiSMF301XE4Cw7csAv/nt
 UV1Q==
X-Gm-Message-State: AOJu0YzjcOqXX6/xzMGQOdEg6urAHKHB6FAa8IFuD6sxE6pIjYbu2Fek
 Vf8122O/ps8sUNRSi3rVjYkSkejfn/Nku0vnRbFfvHQ2EH7ccbFXZR+nvGz3b9HTgt5hUKhvliI
 S1Fuh
X-Gm-Gg: AeBDietaxZhHGeExbtGiqDMW9T3V1npCa7xQ8zB4/ph9gFYscbH+Q7/XFFhcZMJw4B7
 8DD+QFU6jpG3nDXwEWy9EjlsAh1jstpt2Tj4EvQO/J6GK7Cfputr0eSzWDNwrqyqXzcnL6+so3H
 YpqHp9UjHDtSZalqEsK8iVcDqwtDQWFS5I3sDA9LfFLG+xE9fCqMbem6aEBGdsQ3qGMYM6aVU83
 T4JZ8xxk+s4tfbS0ukV93MSEvPnX0QoYLO9fLQzZ7+gmX6bC2Pqs0xE5hS7gjBf6Q8dd0euDdsz
 E00pFNAHsULPQkyHla7dGDC881hw06+Hghff+uztqCkMRvu0SxuhiYRIqGOZXZ+g3GuwSrFsyy2
 ZDI0HiDvExiejnnmQ1NSc0MTxf6fpC6NNuzyhJpy8hHJbS9qGlF853MazXyJN4BhBylJHJ8ev82
 oAMRh4HkF7ujek2c5OBo3cGBSS2ABUnAHd08g+I+sN10rFTdKhWP/4CgPrxr0pUFHJgM8MrO/m6
 /l7FrvG6vk5OkW84VhUte2SmpswGuI=
X-Received: by 2002:a05:600c:83c5:b0:488:c683:be89 with SMTP id
 5b1f17b1804b1-48e51f2a759mr124213765e9.9.1778169130669; 
 Thu, 07 May 2026 08:52:10 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm41552195e9.18.2026.05.07.08.52.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:52:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/67] hw/intc/arm_gicv5: Implement IRS_IST_{BASER, STATUSR,
 CFGR}
Date: Thu,  7 May 2026 16:51:03 +0100
Message-ID: <20260507155154.1886557-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507155154.1886557-1-peter.maydell@linaro.org>
References: <20260507155154.1886557-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Message-id: 20260327111700.795099-17-peter.maydell@linaro.org
---
 hw/intc/arm_gicv5.c                | 74 ++++++++++++++++++++++++++++++
 hw/intc/arm_gicv5_common.c         |  4 ++
 include/hw/intc/arm_gicv5_common.h |  3 ++
 3 files changed, 81 insertions(+)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 250925f004..cbb35c0270 100644
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
@@ -325,6 +343,26 @@ static bool config_readl(GICv5 *s, GICv5Domain domain, hwaddr offset,
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
@@ -333,18 +371,54 @@ static bool config_readl(GICv5 *s, GICv5Domain domain, hwaddr offset,
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
+
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
+
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
+
     return false;
 }
 
diff --git a/hw/intc/arm_gicv5_common.c b/hw/intc/arm_gicv5_common.c
index 98a432af33..21b40c35a5 100644
--- a/hw/intc/arm_gicv5_common.c
+++ b/hw/intc/arm_gicv5_common.c
@@ -60,6 +60,10 @@ void gicv5_common_init_irqs_and_mmio(GICv5Common *cs,
 
 static void gicv5_common_reset_hold(Object *obj, ResetType type)
 {
+    GICv5Common *cs = ARM_GICV5_COMMON(obj);
+
+    memset(cs->irs_ist_baser, 0, sizeof(cs->irs_ist_baser));
+    memset(cs->irs_ist_cfgr, 0, sizeof(cs->irs_ist_cfgr));
 }
 
 static void gicv5_common_init(Object *obj)
diff --git a/include/hw/intc/arm_gicv5_common.h b/include/hw/intc/arm_gicv5_common.h
index e7220b9dc7..19e1af8ceb 100644
--- a/include/hw/intc/arm_gicv5_common.h
+++ b/include/hw/intc/arm_gicv5_common.h
@@ -64,6 +64,9 @@ struct GICv5Common {
 
     MemoryRegion iomem[NUM_GICV5_DOMAINS];
 
+    uint64_t irs_ist_baser[NUM_GICV5_DOMAINS];
+    uint32_t irs_ist_cfgr[NUM_GICV5_DOMAINS];
+
     /* Bits here are set for each physical interrupt domain implemented */
     uint8_t implemented_domains;
 
-- 
2.43.0


