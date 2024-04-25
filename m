Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB793C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 10:46:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzwWY-00023d-Dn; Thu, 25 Apr 2024 06:40:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWS-00020a-Bg
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:12 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWQ-0007Bx-Gz
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:11 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-41b2119da94so6928775e9.0
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 03:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714041609; x=1714646409; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DvQe61721AEsWn6GQQEObJc/efW7ULaM2R9N/D/TYJk=;
 b=vYbMW6Qiu5095ujh2HZjvXFN0w2Lz/ybTZ0NWl+J2YghxNep/T+dwOm/VU/Fgr0I+5
 cBtiVPckTagSnlF5fGQgSTnlCylj9ndvnmYl7sunutPCF0oLSEmwjN3UOTCTFoSHMOPE
 PBmkN//AOjrhdPU3V2mQmttfxGVBmDXZmvWyYJa5+LexUFB9q8lxxxE9BLwkBShpZejt
 GMI8XRbt2sa1NaQtP4VqYihHCH7b8mb8P5XLC4eyoSUCIignK0deegn4qW3eiZ/rH06C
 lxCYN0MipKUwalTGr0WzdU57UVTq7X1BzPOkqfa2WHOwZax/ff4ZvceUAXzBp5saY4KG
 uNbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714041609; x=1714646409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DvQe61721AEsWn6GQQEObJc/efW7ULaM2R9N/D/TYJk=;
 b=DzXBENPToZx3tndvM7zZWNNPXhSivRvb0xa0Kdkhwk9chIhhMl62+x8EoNyWAVQxq0
 5++mi8pcpAsY5KoOj+k/yHTK6XvcsQMi9IavSR7rOeXKGSe6Wab6sygnEv4xYH/ZPEgj
 ve1G+aIh0S0W/7W1x5Rf3evi3WykK+Tx/D9JPTtjtBcZ04NUdj2KXbXVGqzJsU/GuNP0
 0BAlSJP3Sdrx4b/XSPwLUyb2bGl6+zkeKTPOn8PgqK08MeVZLqJpP5Tn4olwAS8OBcWv
 7w2vkTeEeXZHaaA8Ypo/v9fm1CYt8Qvv4hD9vvHHe0NvgdiU66MTDA5CMNjusLQ4vBIQ
 Bc7g==
X-Gm-Message-State: AOJu0YwOZ9HlXbVtxUPVHmlT9GcODwvnli9muLJT9Vj2IqBO6WTV5cC5
 L5dlaKnZ9TSfzhOaCQ1bRtxuKlfnAHPsR2KtG+JZ1fLhxA/CJ83tRWLoMBUioGshY6AOgH2xuXb
 b
X-Google-Smtp-Source: AGHT+IH5HQANwqW9fekI1HIEGcO7jOSObUrwEDo5M+6S3eM//Pve6m7YkrTHkn3ScTpjW2ZHSwrVtw==
X-Received: by 2002:a05:600c:4f53:b0:418:c2af:ab83 with SMTP id
 m19-20020a05600c4f5300b00418c2afab83mr4660298wmq.36.1714041608817; 
 Thu, 25 Apr 2024 03:40:08 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 h15-20020a056000000f00b003434c764f01sm19485768wrx.107.2024.04.25.03.40.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Apr 2024 03:40:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/37] hw/intc/arm_gicv3_redist: Implement GICR_INMIR0
Date: Thu, 25 Apr 2024 11:39:37 +0100
Message-Id: <20240425103958.3237225-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425103958.3237225-1-peter.maydell@linaro.org>
References: <20240425103958.3237225-1-peter.maydell@linaro.org>
MIME-Version: 1.0
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

From: Jinjie Ruan <ruanjinjie@huawei.com>

Add GICR_INMIR0 register and support access GICR_INMIR0.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240407081733.3231820-17-ruanjinjie@huawei.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/gicv3_internal.h   |  1 +
 hw/intc/arm_gicv3_redist.c | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/hw/intc/gicv3_internal.h b/hw/intc/gicv3_internal.h
index 8f4ebed2f42..21697ecf391 100644
--- a/hw/intc/gicv3_internal.h
+++ b/hw/intc/gicv3_internal.h
@@ -110,6 +110,7 @@
 #define GICR_ICFGR1           (GICR_SGI_OFFSET + 0x0C04)
 #define GICR_IGRPMODR0        (GICR_SGI_OFFSET + 0x0D00)
 #define GICR_NSACR            (GICR_SGI_OFFSET + 0x0E00)
+#define GICR_INMIR0           (GICR_SGI_OFFSET + 0x0F80)
 
 /* VLPI redistributor registers, offsets from VLPI_base */
 #define GICR_VPROPBASER       (GICR_VLPI_OFFSET + 0x70)
diff --git a/hw/intc/arm_gicv3_redist.c b/hw/intc/arm_gicv3_redist.c
index 8153525849a..ed1f9d1e444 100644
--- a/hw/intc/arm_gicv3_redist.c
+++ b/hw/intc/arm_gicv3_redist.c
@@ -35,6 +35,15 @@ static int gicr_ns_access(GICv3CPUState *cs, int irq)
     return extract32(cs->gicr_nsacr, irq * 2, 2);
 }
 
+static void gicr_write_bitmap_reg(GICv3CPUState *cs, MemTxAttrs attrs,
+                                  uint32_t *reg, uint32_t val)
+{
+    /* Helper routine to implement writing to a "set" register */
+    val &= mask_group(cs, attrs);
+    *reg = val;
+    gicv3_redist_update(cs);
+}
+
 static void gicr_write_set_bitmap_reg(GICv3CPUState *cs, MemTxAttrs attrs,
                                       uint32_t *reg, uint32_t val)
 {
@@ -406,6 +415,10 @@ static MemTxResult gicr_readl(GICv3CPUState *cs, hwaddr offset,
         *data = value;
         return MEMTX_OK;
     }
+    case GICR_INMIR0:
+        *data = cs->gic->nmi_support ?
+                gicr_read_bitmap_reg(cs, attrs, cs->gicr_inmir0) : 0;
+        return MEMTX_OK;
     case GICR_ICFGR0:
     case GICR_ICFGR1:
     {
@@ -555,6 +568,12 @@ static MemTxResult gicr_writel(GICv3CPUState *cs, hwaddr offset,
         gicv3_redist_update(cs);
         return MEMTX_OK;
     }
+    case GICR_INMIR0:
+        if (cs->gic->nmi_support) {
+            gicr_write_bitmap_reg(cs, attrs, &cs->gicr_inmir0, value);
+        }
+        return MEMTX_OK;
+
     case GICR_ICFGR0:
         /* Register is all RAZ/WI or RAO/WI bits */
         return MEMTX_OK;
-- 
2.34.1


