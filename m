Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D54ECF3189
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 01:05:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svnn9-0007hi-Bb; Tue, 01 Oct 2024 21:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1svnmc-0006z5-AJ
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 21:04:07 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1svnma-0002pM-Ah
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 21:04:02 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-20b7259be6fso34155435ad.0
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 18:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1727831039; x=1728435839; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/3poKE/9C9XgFE59tMY0QZWKf4rB7frGZ2ed/FANpzo=;
 b=c/zPpsWLLPxon3IQLx9A0gMuY/iSR5HQXMTO1IiUpBmDER8SA6AOKJ/yz82xZX9S+l
 TEtDmCXA7F8fROFmCPyxOvaqL0/n6uhq4j4UvvT4QUkYecjUqBzbPWvGMqbqbo5C/N4h
 l07XDxzz+N35AdGkUA5Nhb+9JG3foZCRmkVxRw9njzCdC5YnKFD9SVqqjdMtifiZIuMA
 BuQX9w37XGN9aiKFp5YtOcc4XtM3PfmvQqCJZqMr7QWX+379dQW8tEGZJl5j0N/8z+5a
 aPvlWsyg8596ujHKAMCUjqeYiu/60qIk9vWSRAbm/QtnJxl5KYktjfwWApZIZTdZL3ZC
 C+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727831039; x=1728435839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/3poKE/9C9XgFE59tMY0QZWKf4rB7frGZ2ed/FANpzo=;
 b=E/vHDxuvXPc8lUSKcDAhORmVcLMc90o4XPl8UBGTHFIeLlcJHypbzbjEYaWvXZNT9a
 Ph2nG80pHzsdkEwQQFycWn7e+PWa9Prl0WvPL/bNE6LIRONQPesk4nfKnvTaNU3RbJdL
 vQL4Lq80VjdQnX2gFc5DY4MyEtsFAUa0fYgc7M+ptXnyeRIVihEkqMNNo/qGUjfhCMes
 ExKFlCuK6cgaCqlUX2rHJi93IL+juqQn2jx6fw82K4pVHhzEQ8p8jNlWGGwX0fYWICGP
 MK6hz24c/nKC1wrHOG/O3Xed+2bi7uKCIgdLD7ouWwwlZUN9m2tPZ1M+HmFzjbKy/SQP
 Gd+Q==
X-Gm-Message-State: AOJu0YzlIgpEglO+4xBmFOeM5nhcdzWvKn1I3gLQmdKE22mti0LRYDDN
 10SN1Yk4F9HYeuOSnunhfKpKOZtyNYIi5nwjDiZXCnC6jqeEGyD26GuTKisvVlwliQeFuhqXBQs
 R
X-Google-Smtp-Source: AGHT+IGuVwjPVKQPScxS3ndNemjG5BxXmUTrS8MSxdanO/z+bBGfGcRQodUWEm7c4FxsuP5qzbZDGQ==
X-Received: by 2002:a17:902:d50d:b0:20b:a9b2:b560 with SMTP id
 d9443c01a7336-20bc59ae51emr22044465ad.6.1727831038740; 
 Tue, 01 Oct 2024 18:03:58 -0700 (PDT)
Received: from grind.. (200-206-229-93.dsl.telesp.net.br. [200.206.229.93])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20b37d63971sm76061295ad.4.2024.10.01.18.03.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 18:03:58 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 peter.maydell@linaro.org, Tomasz Jeznach <tjeznach@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v8 10/12] hw/riscv/riscv-iommu: add DBG support
Date: Tue,  1 Oct 2024 22:03:05 -0300
Message-ID: <20241002010314.1928515-11-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241002010314.1928515-1-dbarboza@ventanamicro.com>
References: <20241002010314.1928515-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62f.google.com
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

From: Tomasz Jeznach <tjeznach@rivosinc.com>

DBG support adds three additional registers: tr_req_iova, tr_req_ctl and
tr_response.

The DBG cap is always enabled. No on/off toggle is provided for it.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu-bits.h | 17 +++++++++++
 hw/riscv/riscv-iommu.c      | 59 +++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)

diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
index 96a994b9aa..6359ae0353 100644
--- a/hw/riscv/riscv-iommu-bits.h
+++ b/hw/riscv/riscv-iommu-bits.h
@@ -82,6 +82,7 @@ struct riscv_iommu_pq_record {
 #define RISCV_IOMMU_CAP_ATS             BIT_ULL(25)
 #define RISCV_IOMMU_CAP_T2GPA           BIT_ULL(26)
 #define RISCV_IOMMU_CAP_IGS             GENMASK_ULL(29, 28)
+#define RISCV_IOMMU_CAP_DBG             BIT_ULL(31)
 #define RISCV_IOMMU_CAP_PAS             GENMASK_ULL(37, 32)
 #define RISCV_IOMMU_CAP_PD8             BIT_ULL(38)
 #define RISCV_IOMMU_CAP_PD17            BIT_ULL(39)
@@ -184,6 +185,22 @@ enum {
     RISCV_IOMMU_INTR_COUNT
 };
 
+/* 5.24 Translation request IOVA (64bits) */
+#define RISCV_IOMMU_REG_TR_REQ_IOVA     0x0258
+
+/* 5.25 Translation request control (64bits) */
+#define RISCV_IOMMU_REG_TR_REQ_CTL      0x0260
+#define RISCV_IOMMU_TR_REQ_CTL_GO_BUSY  BIT_ULL(0)
+#define RISCV_IOMMU_TR_REQ_CTL_NW       BIT_ULL(3)
+#define RISCV_IOMMU_TR_REQ_CTL_PID      GENMASK_ULL(31, 12)
+#define RISCV_IOMMU_TR_REQ_CTL_DID      GENMASK_ULL(63, 40)
+
+/* 5.26 Translation request response (64bits) */
+#define RISCV_IOMMU_REG_TR_RESPONSE     0x0268
+#define RISCV_IOMMU_TR_RESPONSE_FAULT   BIT_ULL(0)
+#define RISCV_IOMMU_TR_RESPONSE_S       BIT_ULL(9)
+#define RISCV_IOMMU_TR_RESPONSE_PPN     RISCV_IOMMU_PPN_FIELD
+
 /* 5.27 Interrupt cause to vector (64bits) */
 #define RISCV_IOMMU_REG_ICVEC           0x02F8
 #define RISCV_IOMMU_ICVEC_CIV           GENMASK_ULL(3, 0)
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 6bb7ab6c53..c719aa5bc9 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -1761,6 +1761,50 @@ static void riscv_iommu_process_pq_control(RISCVIOMMUState *s)
     riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_PQCSR, ctrl_set, ctrl_clr);
 }
 
+static void riscv_iommu_process_dbg(RISCVIOMMUState *s)
+{
+    uint64_t iova = riscv_iommu_reg_get64(s, RISCV_IOMMU_REG_TR_REQ_IOVA);
+    uint64_t ctrl = riscv_iommu_reg_get64(s, RISCV_IOMMU_REG_TR_REQ_CTL);
+    unsigned devid = get_field(ctrl, RISCV_IOMMU_TR_REQ_CTL_DID);
+    unsigned pid = get_field(ctrl, RISCV_IOMMU_TR_REQ_CTL_PID);
+    RISCVIOMMUContext *ctx;
+    void *ref;
+
+    if (!(ctrl & RISCV_IOMMU_TR_REQ_CTL_GO_BUSY)) {
+        return;
+    }
+
+    ctx = riscv_iommu_ctx(s, devid, pid, &ref);
+    if (ctx == NULL) {
+        riscv_iommu_reg_set64(s, RISCV_IOMMU_REG_TR_RESPONSE,
+                                 RISCV_IOMMU_TR_RESPONSE_FAULT |
+                                 (RISCV_IOMMU_FQ_CAUSE_DMA_DISABLED << 10));
+    } else {
+        IOMMUTLBEntry iotlb = {
+            .iova = iova,
+            .perm = ctrl & RISCV_IOMMU_TR_REQ_CTL_NW ? IOMMU_RO : IOMMU_RW,
+            .addr_mask = ~0,
+            .target_as = NULL,
+        };
+        int fault = riscv_iommu_translate(s, ctx, &iotlb, false);
+        if (fault) {
+            iova = RISCV_IOMMU_TR_RESPONSE_FAULT | (((uint64_t) fault) << 10);
+        } else {
+            iova = iotlb.translated_addr & ~iotlb.addr_mask;
+            iova >>= TARGET_PAGE_BITS;
+            iova &= RISCV_IOMMU_TR_RESPONSE_PPN;
+
+            /* We do not support superpages (> 4kbs) for now */
+            iova &= ~RISCV_IOMMU_TR_RESPONSE_S;
+        }
+        riscv_iommu_reg_set64(s, RISCV_IOMMU_REG_TR_RESPONSE, iova);
+    }
+
+    riscv_iommu_reg_mod64(s, RISCV_IOMMU_REG_TR_REQ_CTL, 0,
+        RISCV_IOMMU_TR_REQ_CTL_GO_BUSY);
+    riscv_iommu_ctx_put(s, ref);
+}
+
 typedef void riscv_iommu_process_fn(RISCVIOMMUState *s);
 
 static void riscv_iommu_update_icvec(RISCVIOMMUState *s, uint64_t data)
@@ -1925,6 +1969,12 @@ static MemTxResult riscv_iommu_mmio_write(void *opaque, hwaddr addr,
 
         return MEMTX_OK;
 
+    case RISCV_IOMMU_REG_TR_REQ_CTL:
+        process_fn = riscv_iommu_process_dbg;
+        regb = RISCV_IOMMU_REG_TR_REQ_CTL;
+        busy = RISCV_IOMMU_TR_REQ_CTL_GO_BUSY;
+        break;
+
     default:
         break;
     }
@@ -2062,6 +2112,9 @@ static void riscv_iommu_realize(DeviceState *dev, Error **errp)
         s->cap |= RISCV_IOMMU_CAP_SV32X4 | RISCV_IOMMU_CAP_SV39X4 |
                   RISCV_IOMMU_CAP_SV48X4 | RISCV_IOMMU_CAP_SV57X4;
     }
+    /* Enable translation debug interface */
+    s->cap |= RISCV_IOMMU_CAP_DBG;
+
     /* Report QEMU target physical address space limits */
     s->cap = set_field(s->cap, RISCV_IOMMU_CAP_PAS,
                        TARGET_PHYS_ADDR_SPACE_BITS);
@@ -2118,6 +2171,12 @@ static void riscv_iommu_realize(DeviceState *dev, Error **errp)
     stl_le_p(&s->regs_wc[RISCV_IOMMU_REG_IPSR], ~0);
     stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_ICVEC], 0);
     stq_le_p(&s->regs_rw[RISCV_IOMMU_REG_DDTP], s->ddtp);
+    /* If debug registers enabled. */
+    if (s->cap & RISCV_IOMMU_CAP_DBG) {
+        stq_le_p(&s->regs_ro[RISCV_IOMMU_REG_TR_REQ_IOVA], 0);
+        stq_le_p(&s->regs_ro[RISCV_IOMMU_REG_TR_REQ_CTL],
+            RISCV_IOMMU_TR_REQ_CTL_GO_BUSY);
+    }
 
     /* Memory region for downstream access, if specified. */
     if (s->target_mr) {
-- 
2.45.2


