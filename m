Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C28F8CD3439
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:56:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL11S-0003bO-Cm; Thu, 07 May 2026 11:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11Q-0003a2-A0
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:20 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11N-0003ra-S8
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:19 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso11859345e9.3
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169136; x=1778773936; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wa/zQWHYmfpo2HdFtvc+xrKDx1KnPTTV/Qg03fMEQMw=;
 b=kGvJzMz9a3mZEkN98Mo8hw/BASfD9Qo/6zcMoFBslCPEeDDjkbdp/EdQ0NG8JivVM9
 apq2O87nWtghomn/TtApBg8VZh8fv0EP3ak9/Mxy2eqtSM/f5OFvhHTCsJQ1rTT2N/Hm
 v342ESv3IXGNkOqK2eH9h2o1PitjvdGl89H201zMNCKSPtacpXIL3qog+OGn1JvySTFX
 p3UXF+FN4JNSCuBeccYag+WYoTQOhggWWvlrLabZ8jrMpnpS2P9uRUI5bEkv4X/b4Ex0
 H03bI1C1o0YRu5LIpKBBGIS+rK7XcxT8DC4G1i8D+X+iym0rDi3N2MgVOQ/mqcs3Uj6a
 Vuzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169136; x=1778773936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wa/zQWHYmfpo2HdFtvc+xrKDx1KnPTTV/Qg03fMEQMw=;
 b=DismiKZwgiq/uJK06AbaIS66UtVI5NBTewCLPJyiHiz2GD55U4EPKKqk1YR9A0IrTX
 57r9Ugh8VW0eR81Z9qsxdR2TcueShQTZtKKWHILmBj/+dSethu5iwsb3QTnW9zGF888K
 skteI2nErF8FzR9mTVw3Gg+hXycV4mkGj0GVsWr6hpySrFSTpRX/kzIywdGRy7pP4nKI
 f3p+ARFrZwdliuWAGUW+vME3zBDXZNCOdUYMzR3NmJrOBpEkWUYMStK99ehlE5eNvBxK
 Yk05oTr8hW93kP6hxtZN4fZicQtxOVXJtCxet3vGkUrWoVHKBgt4+2ZITG40E7X8qnYS
 /iag==
X-Gm-Message-State: AOJu0YyKT9WZ9vvbEvJ4bzoMF3O1aekkFq3h5D42rCBvDRZ9DJo3CW4m
 W7yx/eJ2DapOncxti92OhJe02Lr81n+dKjwNz6se0CmVw546iYlQoZTdor8RAfo6m0B8fGdu/WD
 kp5+O
X-Gm-Gg: AeBDiet3cmPBQLIsWnhULDN+1CNGpr8ICTH9XWu9OizMhjzkYStv9pmwYDk43abQAiZ
 xy62wsH/uzVTDM8vpe6kiA3/8IVGpAObTOLbyBtGRWXoe9JuVqKcjPNOY+qw1fdfJ6s5DUR5VQd
 IMvfN2NyzYChEoCuaqpxaXuEblAUimaEAWQ02kpEu4XInDtQUQxwYvB0yhfm49jSichgjjJRj8L
 NeCH1bYXG1gLQI4jY9foFqvAdTXsmCTO3WQWA0gp6lytEwBIZWqArwFMrPNm7m4QVePFN4RnTh/
 yhG0HHAhyHX8dcupDqCnJS0LUqLKLRifH7JoaMUAYd7/QeM8duT4mNJ9FSSprpfMW8z+oXPeNVo
 cTZbBabO+iVy+T1kpnhqQ0A4blUzAXWNR0q+MP+TIEoyPtpgOVguw7/YoPN6hUQLwUCJI8bBzfV
 6T0o4KSttUrfsR60HjYlhVFcIQFlcWYuWRvR9Kx177gpxyOE1+oQrivgTFphtcUqYDuLeUz1G2w
 QbMMj++dy3akoXkm+q2BdgkJX54nKMHWm4AvAtoxA==
X-Received: by 2002:a05:600c:a30d:b0:488:a2ac:a334 with SMTP id
 5b1f17b1804b1-48e51e08228mr99027265e9.3.1778169136373; 
 Thu, 07 May 2026 08:52:16 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm41552195e9.18.2026.05.07.08.52.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:52:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/67] hw/intc/arm_gicv5: Implement IRS_MAP_L2_ISTR
Date: Thu,  7 May 2026 16:51:07 +0100
Message-ID: <20260507155154.1886557-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507155154.1886557-1-peter.maydell@linaro.org>
References: <20260507155154.1886557-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

The IRS register IRS_MAP_L2_ISTR is used by software to tell the IRS
that it has updated the address in an L1 IST entry to point to an
L2 IST. The sequence of events here is:
 * software writes to L1_ISTE.L2_ADDR for some L1 ISTE which is
   not valid (i.e. where L1_ISTE.VALID is 0); it leaves VALID at 0
 * software writes to IRS_MAP_L2_ISTR with some INTID that is inside
   the range for this L1 ISTE
 * the IRS sets IRS_IST_STATUSR.IDLE to 0
 * the IRS takes note of this information
 * the IRS writes to the L1_ISTE to set VALID=1
 * the IRS sets IRS_IST_STATUSR.IDLE to 1 to indicate that the
   update is complete

For QEMU, we're strictly synchronous, so (as with IRS_IST_BASER
updates) we don't need to model the IDLE transitions and can have
IRS_IST_STATUSR always return IDLE=1.  We also don't currently cache
anything for ISTE lookups, so we don't need to invalidate or update
anything when software makes the L2 valid.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Message-id: 20260327111700.795099-21-peter.maydell@linaro.org
---
 hw/intc/arm_gicv5.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 3588f3323f..7d654a91e6 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -497,6 +497,43 @@ void gicv5_set_priority(GICv5Common *cs, uint32_t id, uint8_t priority,
     }
 }
 
+static void irs_map_l2_istr_write(GICv5 *s, GICv5Domain domain, uint64_t value)
+{
+    GICv5Common *cs = ARM_GICV5_COMMON(s);
+    GICv5ISTConfig *cfg = &s->phys_lpi_config[domain];
+    uint32_t intid = FIELD_EX32(value, IRS_MAP_L2_ISTR, ID);
+    hwaddr l1_addr;
+    uint64_t l1_iste;
+    MemTxResult res;
+
+    if (!FIELD_EX64(cs->irs_ist_baser[domain], IRS_IST_BASER, VALID) ||
+        !cfg->structure) {
+        /* WI if no IST set up or it is not 2-level */
+        return;
+    }
+
+    /* Find the relevant L1 ISTE and set its VALID bit */
+    l1_addr = l1_iste_addr(cs, cfg, intid);
+
+    l1_iste = address_space_ldq_le(&cs->dma_as, l1_addr, cfg->txattrs, &res);
+    if (res != MEMTX_OK) {
+        goto txfail;
+    }
+
+    l1_iste = FIELD_DP64(l1_iste, L1_ISTE, VALID, 1);
+
+    address_space_stq_le(&cs->dma_as, l1_addr, l1_iste, cfg->txattrs, &res);
+    if (res != MEMTX_OK) {
+        goto txfail;
+    }
+    return;
+
+txfail:
+    /* Reportable with EC=0x0 if sw error reporting implemented */
+    qemu_log_mask(LOG_GUEST_ERROR, "L1 ISTE update failed for ID 0x%x at "
+                  "physical address 0x" HWADDR_FMT_plx "\n", intid, l1_addr);
+}
+
 static void irs_ist_baser_write(GICv5 *s, GICv5Domain domain, uint64_t value)
 {
     GICv5Common *cs = ARM_GICV5_COMMON(s);
@@ -683,6 +720,9 @@ static bool config_writel(GICv5 *s, GICv5Domain domain, hwaddr offset,
             cs->irs_ist_cfgr[domain] = data;
         }
         return true;
+    case A_IRS_MAP_L2_ISTR:
+        irs_map_l2_istr_write(s, domain, data);
+        return true;
     }
 
     return false;
-- 
2.43.0


