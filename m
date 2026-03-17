Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B4DEFED9EF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 17:50:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2YX7-0003VM-HE; Tue, 17 Mar 2026 13:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w2YWa-0003Ne-3G
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 13:48:23 -0400
Received: from mail-dl1-x122f.google.com ([2607:f8b0:4864:20::122f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w2YWV-0006zP-O3
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 13:48:10 -0400
Received: by mail-dl1-x122f.google.com with SMTP id
 a92af1059eb24-128d2e3082eso503135c88.0
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 10:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773769686; x=1774374486; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sMIe4BH1dC23aKjJXdUIHsVXt5i12Nl20FH16xA6kBU=;
 b=gy5vc7i+dX01o5EmThHVeMQ0foW3M9hb8vZf6KPkNHm0oJU7Xjtqn6Jf3nnHacdqqT
 zcDzoVte/RSBRHppxgeIAQN8LMHwXYC9i7jkwAUiVC2huxSr24RUpRPkr55xsKTwcT5d
 6vYFMOLrrr9VzTn38mi7+lTsMtKY4VAGBVvo1lFEUWMbdDldCz90UiikjkpF9jky8N4r
 6GN1UwBTtFppIeaRXiydLZ8FWNBpsTG5FG0e8Fr/STNBxBI+5bf+pV7q/3rsC1vrLzoM
 odUPIyIFeCUkqpJ5d8hUEqnKnm9vrL7NVf60ALT6xITQuvi0l3PpoBkHv/9wWg6MjaAQ
 HfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773769686; x=1774374486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sMIe4BH1dC23aKjJXdUIHsVXt5i12Nl20FH16xA6kBU=;
 b=kBYvZbe4BC/w8/o9b3y+DAiizQHcJTSDQM2zEkBQ3EIqPlmZhxezGxAzEQMFBu/bo8
 VimEHjrEYbSr3ponvMiZ29KnycmTHBlbSM2gqJm6tXnf95KfQKmLT+/qB/OrPbajoq1L
 PkYU4thUJJ+TLILVV8oMmga0W9qm2T+Lpu/6b3srnT5jfKyAhQ+tgcL2Shz4D3CVV9ii
 AaMmItZk3NUmyXJIJeyG+LyfQ8zVomrnlO/eMTbftq+tUzaOcdJYgrD/G50Y5docrq4/
 CxPv5RkXopaib8GbxVwnL8iJ46enzuSLAaHJcRXS5aFhENB2kr6FAeGv8YVMdc6QtIQa
 Rk2w==
X-Gm-Message-State: AOJu0YyUf/dYgiXgOi7kzjTOh3n+VQ+z8ezrKZ+utkoKVebCVhWWiO8A
 re/qOMUzuSY7PYUCM2vDp03XcR+uZ/2fSe2CU58QM5VsXre5mTc1Zwz9pnQrdYaR
X-Gm-Gg: ATEYQzzraIXm+GQ8wPCSj9UaLzUMEZBHBnBbm0Ep4XT1Td2siGe22wcrubZmH+jpTOo
 UH1b6mrlzkdJf+bDfn0vlV0dlq9+huXp0FD13wi2BCSq1xmY0FwUTMbFgoiOa6oiDLKY8nAW2oQ
 usAFMZZCaXoWod9czfWpcn6ieUnoEWxsyUweAwZzE/aubGiL6zz1ke8yT9pFJ0F5OQ79CYvcba8
 sb34Sql5M6UKJLfcaQYRiDlvanSyJrozVfSkTrlgzkgtkhm6Aba+D7Jx3uX78PXHPpsc4DmMrGr
 enLk2r08EXHOL19hd//igdVMeMPb1r/abkKRdINMcIiaZ6dw8WmiKJxa4z9cJ2xepLGXehf2CUk
 f7DJxJuu2jxN+1I7GOWQuuD7vWwbOfw0iMv1wtSEmF6Mcul4aAaHVna88Zk3am78Ot6hMJ0+F7L
 zjRLaFZD9QUEVziwSKNLy6yIwuf+pkVjz6+P5k+UTurx0D7BbdzaG8
X-Received: by 2002:a05:7022:6085:b0:128:d202:883 with SMTP id
 a92af1059eb24-1299ba11ebdmr242073c88.3.1773769685544; 
 Tue, 17 Mar 2026 10:48:05 -0700 (PDT)
Received: from localhost.localdomain ([143.54.78.51])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-129b4147522sm281844c88.15.2026.03.17.10.47.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 17 Mar 2026 10:48:05 -0700 (PDT)
From: Lucas Amaral <lucaaamaral@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org,
 mohamed@unpredictable.fr, alex.bennee@linaro.org,
 Lucas Amaral <lucaaamaral@gmail.com>
Subject: [PATCH v5 2/6] target/arm/emulate: add load/store register offset
Date: Tue, 17 Mar 2026 14:47:36 -0300
Message-ID: <20260317174740.31674-3-lucaaamaral@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260317174740.31674-1-lucaaamaral@gmail.com>
References: <20260317174740.31674-1-lucaaamaral@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122f;
 envelope-from=lucaaamaral@gmail.com; helo=mail-dl1-x122f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Add emulation for load/store register offset addressing mode
(DDI 0487 C3.3.9).  The offset register value is extended via
UXTB/UXTH/UXTW/UXTX/SXTB/SXTH/SXTW/SXTX and optionally
shifted by the element size.

Instruction coverage:
  - STR/LDR (GPR): register offset with extend, all sizes
  - STR/LDR (SIMD/FP): register offset with extend, 8-128 bit
  - PRFM register offset: NOP

Signed-off-by: Lucas Amaral <lucaaamaral@gmail.com>
---
 target/arm/emulate/a64-ldst.decode |  29 ++++++++
 target/arm/emulate/arm_emulate.c   | 103 +++++++++++++++++++++++++++++
 2 files changed, 132 insertions(+)

diff --git a/target/arm/emulate/a64-ldst.decode b/target/arm/emulate/a64-ldst.decode
index c887dcba..af6babe1 100644
--- a/target/arm/emulate/a64-ldst.decode
+++ b/target/arm/emulate/a64-ldst.decode
@@ -10,6 +10,9 @@
 # 'u' flag: 0 = 9-bit signed immediate (byte offset), 1 = 12-bit unsigned (needs << sz)
 &ldst_imm       rt rn imm sz sign w p unpriv ext u
 
+# Load/store register offset
+&ldst           rm rn rt sign ext sz opt s
+
 ### Format templates
 
 # Load/store immediate (9-bit signed)
@@ -21,6 +24,9 @@
 # Load/store unsigned offset (12-bit, handler scales by << sz)
 @ldst_uimm      .. ... . .. .. imm:12 rn:5 rt:5        &ldst_imm u=1 unpriv=0 p=0 w=0
 
+# Load/store register offset
+@ldst           .. ... . .. .. . rm:5 opt:3 s:1 .. rn:5 rt:5   &ldst
+
 ### Load/store register — unscaled immediate (LDUR/STUR)
 
 # GPR
@@ -122,6 +128,29 @@ STR_v_i         00 111 1 01 10 ............ ..... .....         @ldst_uimm sign=
 LDR_v_i         sz:2 111 1 01 01 ............ ..... .....       @ldst_uimm sign=0 ext=0
 LDR_v_i         00 111 1 01 11 ............ ..... .....         @ldst_uimm sign=0 ext=0 sz=4
 
+### Load/store register — register offset
+
+# GPR
+STR             sz:2 111 0 00 00 1 ..... ... . 10 ..... .....  @ldst sign=0 ext=0
+LDR             00 111 0 00 01 1 ..... ... . 10 ..... .....    @ldst sign=0 ext=1 sz=0
+LDR             01 111 0 00 01 1 ..... ... . 10 ..... .....    @ldst sign=0 ext=1 sz=1
+LDR             10 111 0 00 01 1 ..... ... . 10 ..... .....    @ldst sign=0 ext=1 sz=2
+LDR             11 111 0 00 01 1 ..... ... . 10 ..... .....    @ldst sign=0 ext=0 sz=3
+LDR             00 111 0 00 10 1 ..... ... . 10 ..... .....    @ldst sign=1 ext=0 sz=0
+LDR             01 111 0 00 10 1 ..... ... . 10 ..... .....    @ldst sign=1 ext=0 sz=1
+LDR             10 111 0 00 10 1 ..... ... . 10 ..... .....    @ldst sign=1 ext=0 sz=2
+LDR             00 111 0 00 11 1 ..... ... . 10 ..... .....    @ldst sign=1 ext=1 sz=0
+LDR             01 111 0 00 11 1 ..... ... . 10 ..... .....    @ldst sign=1 ext=1 sz=1
+
+# PRFM — register offset
+NOP             11 111 0 00 10 1 ----- -1- - 10 ----- -----
+
+# SIMD/FP
+STR_v           sz:2 111 1 00 00 1 ..... ... . 10 ..... .....  @ldst sign=0 ext=0
+STR_v           00 111 1 00 10 1 ..... ... . 10 ..... .....    @ldst sign=0 ext=0 sz=4
+LDR_v           sz:2 111 1 00 01 1 ..... ... . 10 ..... .....  @ldst sign=0 ext=0
+LDR_v           00 111 1 00 11 1 ..... ... . 10 ..... .....    @ldst sign=0 ext=0 sz=4
+
 ### System instructions — DC cache maintenance
 
 # SYS with CRn=C7 covers all data cache operations (DC CIVAC, CVAC, etc.).
diff --git a/target/arm/emulate/arm_emulate.c b/target/arm/emulate/arm_emulate.c
index 02fefc30..bf09e2a6 100644
--- a/target/arm/emulate/arm_emulate.c
+++ b/target/arm/emulate/arm_emulate.c
@@ -211,6 +211,109 @@ static bool trans_LDR_v_i(DisasContext *ctx, arg_ldst_imm *a)
     return true;
 }
 
+/* Register offset extension (DDI 0487 C6.2.131) */
+
+static uint64_t extend_reg(uint64_t val, int option, int shift)
+{
+    switch (option) {
+    case 0: /* UXTB */
+        val = (uint8_t)val;
+        break;
+    case 1: /* UXTH */
+        val = (uint16_t)val;
+        break;
+    case 2: /* UXTW */
+        val = (uint32_t)val;
+        break;
+    case 3: /* UXTX / LSL */
+        break;
+    case 4: /* SXTB */
+        val = (int64_t)(int8_t)val;
+        break;
+    case 5: /* SXTH */
+        val = (int64_t)(int16_t)val;
+        break;
+    case 6: /* SXTW */
+        val = (int64_t)(int32_t)val;
+        break;
+    case 7: /* SXTX */
+        break;
+    }
+    return val << shift;
+}
+
+/*
+ * Load/store single -- register offset (GPR)
+ * STR / LDR (DDI 0487 C3.3.9)
+ */
+
+static bool trans_STR(DisasContext *ctx, arg_ldst *a)
+{
+    int esize = (a->sz <= 3) ? (1 << a->sz) : 16;
+    int shift = a->s ? a->sz : 0;
+    uint64_t rm_val = gpr_read(ctx, a->rm);
+    uint64_t offset = extend_reg(rm_val, a->opt, shift);
+    uint64_t va = base_read(ctx, a->rn) + offset;
+
+    uint64_t val = gpr_read(ctx, a->rt);
+    mem_write(ctx, va, &val, esize);
+    return true;
+}
+
+static bool trans_LDR(DisasContext *ctx, arg_ldst *a)
+{
+    int esize = (a->sz <= 3) ? (1 << a->sz) : 16;
+    int shift = a->s ? a->sz : 0;
+    uint64_t rm_val = gpr_read(ctx, a->rm);
+    uint64_t offset = extend_reg(rm_val, a->opt, shift);
+    uint64_t va = base_read(ctx, a->rn) + offset;
+    uint64_t val = 0;
+
+    if (mem_read(ctx, va, &val, esize) != 0) {
+        return true;
+    }
+
+    val = load_extend(val, a->sz, a->sign, a->ext);
+    gpr_write(ctx, a->rt, val);
+    return true;
+}
+
+/*
+ * Load/store single -- register offset (SIMD/FP)
+ * STR_v / LDR_v (DDI 0487 C3.3.10)
+ */
+
+static bool trans_STR_v(DisasContext *ctx, arg_ldst *a)
+{
+    int esize = (a->sz <= 3) ? (1 << a->sz) : 16;
+    int shift = a->s ? a->sz : 0;
+    uint64_t rm_val = gpr_read(ctx, a->rm);
+    uint64_t offset = extend_reg(rm_val, a->opt, shift);
+    uint64_t va = base_read(ctx, a->rn) + offset;
+    uint8_t buf[16];
+
+    fpreg_read(ctx, a->rt, buf, esize);
+    mem_write(ctx, va, buf, esize);
+    return true;
+}
+
+static bool trans_LDR_v(DisasContext *ctx, arg_ldst *a)
+{
+    int esize = (a->sz <= 3) ? (1 << a->sz) : 16;
+    int shift = a->s ? a->sz : 0;
+    uint64_t rm_val = gpr_read(ctx, a->rm);
+    uint64_t offset = extend_reg(rm_val, a->opt, shift);
+    uint64_t va = base_read(ctx, a->rn) + offset;
+    uint8_t buf[16];
+
+    if (mem_read(ctx, va, buf, esize) != 0) {
+        return true;
+    }
+
+    fpreg_write(ctx, a->rt, buf, esize);
+    return true;
+}
+
 /* PRFM, DC cache maintenance -- treated as NOP */
 static bool trans_NOP(DisasContext *ctx, arg_NOP *a)
 {
-- 
2.52.0


