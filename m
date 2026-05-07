Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59160CD3439
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:54:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL11b-0003yN-Sa; Thu, 07 May 2026 11:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11a-0003x3-U2
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:30 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11Z-0003vF-6H
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:30 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so9002465e9.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169148; x=1778773948; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zXdu13PwmRztjQL5k37gA2iPoUui6l6kZDs+nlsW5EI=;
 b=RiH8v/zKFtRGrIBFEsail2t7srFJflpX9jc3Auf6VTG/TnBcsy8zouEKa68MrB5fox
 LSOO9JJwqa24Hwdvafg/PeaVGeOkWH4Zbl4iCEOJvzE7Hw7lCjDdf1gDLSPZgyu7ZgEI
 5ufXERXAOKyItRBNqYzcVP2kA80E28yQnZOmydvMip+8Qk+ou1r6kygQ6ldZWjw1by90
 aE4tu6unVpfMgF4yQt5uCfeDoh4GhQ/cQUrxr1+T3WeYJQxiz1NnaEeJ0PMhXyUyWj/4
 zG8plPFDXzqv9/wGAQ6376Vv4h3y/EDbaA2vV9oRuN2PWWeZsLbFNGloJzoDtM53Nt5+
 6arA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169148; x=1778773948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zXdu13PwmRztjQL5k37gA2iPoUui6l6kZDs+nlsW5EI=;
 b=hsFyQkvBTlAqWVzUNegh15dUcf8zZt4/M2TpjgV/FHQS3U+FnJsUX36viIuTnpJDvv
 LQWWwvjg1cdyR+RMjPHgoF0lcfYj2qFgsvCcHVAY52+K9zAgQBX2xu/aichxw5SU8wOR
 3R01v/RqsRUHc7UDXg24+n7FCb4J0nVQzERpztMFvj4PwVcvpWEaKbvHO377U7iD7KhQ
 TNSbQK6mLbubRZUT7RtFZ9akI8K2wMf5Q8f2f0eS8tgki8ynLB4t+0JYUGW37oic0R+G
 rbj06wZJGt1MW9lp/0e7JLEGGRSbQi9b1j+DN2gI9xD/8ZJ6urS9iUSNKM25UFAxe1Ln
 p1Lw==
X-Gm-Message-State: AOJu0YzxzrWqpTdub3KBoXemy62YHcVUgovANBnNJBaV+QuzBd1pl3J9
 8QROD7Kd/NjnVBzSquebo7pU6deE8xzyK86PmyuXMZz+hzph4GpT51Z3NXh8mRFe/GzZDP2eanJ
 RDAlH
X-Gm-Gg: AeBDieupvjZx2Q/9Ygee5DalMS4dm1YaSA2wtNYVOjrb9ShHXEKj+wOoAnR4yP4VXkR
 VNtP6UyFjjS1xIyl3dTn1oIH7IoTIqt/qicSWLgl7w+JKqLWwOBOSMU9WPlXm+nsspcN3c0xX31
 p7UIWJjUxRGn1Y/2nOV0xA92lsiVKhqmG9EgjUEQf+Mpqq6Or9wuT7v5ZXH8okDsLnvd97FIIvk
 1bemeegXRbKwwlz7dley55eoMiwWViSLEPp6IpFgY2g4DLNvVqZ8fOMNSEo6TjmqzIBJXNNB66k
 BP+Oa2F4Egjpog0TRpWjxkhNAAPKlXzT1AIybHPWtZ7ppIj1t6KP6iokUR11uUnxH3FRa1ZISIj
 tH1R4aouiy+VBabBe5zImoauJLX5G6askPqzI9Zx++SPDFhglGLA/9fwXzG3vtgx/RVMc3WDq3p
 qXK7LkwY6hECB2XzbxbsJM8BVRWdOPnpR2KrarmG1ZRR4Lp0CdXo9BfZ6CZUOfqG5VQLKn4ltx5
 pFuW/4AMp/f3/2cbIr06pZU97ZDCiY=
X-Received: by 2002:a05:600c:3548:b0:485:3abe:ab86 with SMTP id
 5b1f17b1804b1-48e51e0a6a2mr133838205e9.4.1778169147708; 
 Thu, 07 May 2026 08:52:27 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm41552195e9.18.2026.05.07.08.52.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:52:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/67] hw/intc/arm_gicv5: Implement CoreSight ID registers
Date: Thu,  7 May 2026 16:51:19 +0100
Message-ID: <20260507155154.1886557-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507155154.1886557-1-peter.maydell@linaro.org>
References: <20260507155154.1886557-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

The GICv5 register blocks all implement the usual Arm CoreSight ID
registers; implement these for the IRS.  Although we only have one
callsite at the moment, the ITS config frame uses the same ID
register values, so we abstract this out into a function we can reuse
later.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260327111700.795099-33-peter.maydell@linaro.org
---
 hw/intc/arm_gicv5.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index a95a9dc16b..866c1333c3 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -285,6 +285,9 @@ REG64(IRS_SWERR_SYNDROMER0, 0x3c8)
 REG64(IRS_SWERR_SYNDROMER1, 0x3d0)
     FIELD(IRS_SWERR_SYNDROMER2, ADDR, 3, 53)
 
+REG32(IRS_IDREGS, 0xffd0)
+REG32(IRS_DEVARCH, 0xffbc)
+
 FIELD(L1_ISTE, VALID, 0, 1)
 FIELD(L1_ISTE, L2_ADDR, 12, 44)
 
@@ -310,6 +313,31 @@ FIELD(ICSR, HM, 5, 1)
 FIELD(ICSR, PRIORITY, 11, 5)
 FIELD(ICSR, IAFFID, 32, 16)
 
+#define IRS_DEVARCH_VALUE ((0x23b << 31) | (0x1 << 20) | 0x5a19)
+
+static uint32_t gicv5_idreg(int regoffset)
+{
+    /*
+     * As with the main IRS_IIDR, we don't identify as a specific
+     * hardware GICv5 implementation. Arm suggests that the
+     * Implementer, Product, etc in IRS_IIDR should also be reported
+     * here, so we do that.
+     */
+    static const uint8_t gic_ids[] = {
+        QEMU_GICV5_IMPLEMENTER >> 8, 0x00, 0x00, 0x00, /* PIDR4..PIDR7 */
+        QEMU_GICV5_PRODUCTID & 0xff, /* PIDR0 */
+        ((QEMU_GICV5_PRODUCTID >> 8) |
+         ((QEMU_GICV5_IMPLEMENTER & 0xf) << 4)), /* PIDR1 */
+        ((QEMU_GICV5_REVISION << 4) | (1 << 3) |
+         ((QEMU_GICV5_IMPLEMENTER & 0x70) >> 4)), /* PIDR2 */
+        QEMU_GICV5_VARIANT << 4, /* PIDR3 */
+        0x0D, 0xF0, 0x05, 0xB1, /* CIDR0..CIDR3 */
+    };
+
+    regoffset /= 4;
+    return gic_ids[regoffset];
+}
+
 static GICv5SPIState *spi_for_selr(GICv5Common *cs, GICv5Domain domain)
 {
     /*
@@ -1124,6 +1152,13 @@ static bool config_readl(GICv5 *s, GICv5Domain domain, hwaddr offset,
         }
         *data = v;
         return true;
+    case A_IRS_DEVARCH:
+        *data = IRS_DEVARCH_VALUE;
+        return true;
+    case A_IRS_IDREGS ... A_IRS_IDREGS + 0x2f:
+        /* CoreSight ID registers */
+        *data = gicv5_idreg(offset - A_IRS_IDREGS);
+        return true;
     }
 
     return false;
-- 
2.43.0


