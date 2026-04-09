Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA9DF364C5
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 22:07:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAxWE-00088G-Ft; Thu, 09 Apr 2026 18:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1wAxWD-00087l-4A
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 18:06:33 -0400
Received: from mail-dy1-x1332.google.com ([2607:f8b0:4864:20::1332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1wAxWB-0000bI-BE
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 18:06:32 -0400
Received: by mail-dy1-x1332.google.com with SMTP id
 5a478bee46e88-2bd9a485bd6so2862787eec.1
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 15:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775772390; x=1776377190; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WsQoO7k2uaSfcDFMikzprY7q7WWInbI4W7i2YiYJ+go=;
 b=YmC3QJvj2HtbSv3ZacHuXgqXUkqwLaXNcVOjIpW0gDoEPLdFDKCHX+qk8oDcGpxquE
 FdBBugBNR4aCDDTSwCoFdQ5zYM4tdDxZdg/e9OnPpkUoBu84/y9b17S/LxekHPlcM72B
 iCettOWlYdOT00unPI4cP7VAjR//pm5D+BIuHmzbp02b6irhKN24T5J+GB4OeHxHvklo
 BeXTRIrQ2sCjYWgot4LJiYS16z4hta8dx8NIX0YueFM/gVNg5/ZDgQyvJ+2qZZv7JUuu
 2tNcReSBZkWgqWo+arXh8GWGPJ7mGCtEac3BNzPO4CyosJx2gQ5yiqreX48bDnKm29Nq
 8Aaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775772390; x=1776377190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WsQoO7k2uaSfcDFMikzprY7q7WWInbI4W7i2YiYJ+go=;
 b=k0yzX0NW0GKYBDekYwSDkapbua9Fb+ZRhXZa8JIZBdnKPxeVa/NOGGX8ZdYUSE3dr9
 I7KyBdZNs2aSpGcuDPCrW9Ff1HYz8O/9ID+F+IaBVWfy5Vdokt6BkTXug8ibPbSOpl5T
 ss+Go23nhJB/JuFTiVtndqfo1Bws7QJV8BrDT+TLav3spHAupyuF9JJJk6gJmz5Hu+bK
 Rzsbbo2ldTGHFS6QojK8Lp/7f9hmBaLuc6El7rLrV0Uzpq70IFkiO8mVBBksv7TMXlWK
 3+z3JX0ODOtZfCClkF45V/XyhfM11nzc3Cc8GUEIGv5AoPea6pyYJikqD7vqrzCc+786
 MFVA==
X-Gm-Message-State: AOJu0YxS/FHWriaaiVVRnUC8gFc5QPcEiwOXfo81usiq8k58aU+/to7u
 6cXLuyvbpx6AWTzYFB3wdBuzcqLBYO++L/ryRnWnFOu35mbW1Ku+LcR9HgX8CQ6Q
X-Gm-Gg: AeBDietPDnhlXJlt+ORdmd4RzbbuQCgPHJlH5UzppupeIS+YL4xEM0yn4nPv0eO8Pj7
 n8olJf4sl7imD0vGmnwvw2Cem4DIGQ6GqN5z3BRvjWIrqd0pVs8zfaczP4GffXLNBnBUhL6RBV6
 MuTL3fZtRNg4YSGCtRUbCjZ/W72wNs2xAEAUnJU/Wyi0Ihg3CfCLt7TTEQMpc0q2wbS7UuNaFeF
 W01SuDNVoU0dxNfSqsp+7WThmLZIwgfp0vEmxe9N5WTGqbALlnUHjgoLYotq4rDBGSqjyzEkxDK
 N9kIihrxr6a/nxa9htxiraR30/FiTy1f8IxmwthxCkJed7P1HZth9gYld+Yfl6Rv61cgUFl9iJ3
 xE0BIsGvYq7kHP44eBa7L9Lq3dAglrRRYL/4Uf9yQ2fMaPfBSaTq/TvXmaJnxLDtbvTwy0lGxvu
 fv0FTGOf9oAaAcVq+VNViKAVc8GsnvNJJ9nq3qKoQZfYzz7iYl8vNaW8MEza3Zew==
X-Received: by 2002:a05:7300:cb0a:b0:2d3:dff7:13b1 with SMTP id
 5a478bee46e88-2d589463ba1mr515379eec.15.1775772389525; 
 Thu, 09 Apr 2026 15:06:29 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f4:c030:bb40:195d:78fd:ecba:d45])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2d561bde68bsm1534567eec.17.2026.04.09.15.06.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Apr 2026 15:06:29 -0700 (PDT)
From: Lucas Amaral <lucaaamaral@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org,
 mohamed@unpredictable.fr, alex.bennee@linaro.org,
 richard.henderson@linaro.org, Lucas Amaral <lucaaamaral@gmail.com>
Subject: [PATCH v6 2/6] target/arm/emulate: add load/store register offset
Date: Thu,  9 Apr 2026 19:06:10 -0300
Message-ID: <20260409220614.65558-3-lucaaamaral@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260409220614.65558-1-lucaaamaral@gmail.com>
References: <20260409220614.65558-1-lucaaamaral@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1332;
 envelope-from=lucaaamaral@gmail.com; helo=mail-dy1-x1332.google.com
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
 target/arm/emulate/arm_emulate.c   | 106 +++++++++++++++++++++++++++++
 2 files changed, 135 insertions(+)

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
index bedbdb3e..79f42d44 100644
--- a/target/arm/emulate/arm_emulate.c
+++ b/target/arm/emulate/arm_emulate.c
@@ -263,6 +263,112 @@ static bool trans_LDR_v_i(DisasContext *ctx, arg_ldst_imm *a)
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
+    uint8_t buf[16];
+    uint64_t val = gpr_read(ctx, a->rt);
+    mem_st(ctx, buf, esize, val);
+    mem_write(ctx, va, buf, esize);
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
+    uint8_t buf[16];
+
+    if (mem_read(ctx, va, buf, esize) != 0) {
+        return true;
+    }
+
+    uint64_t val = mem_ld(ctx, buf, esize);
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


