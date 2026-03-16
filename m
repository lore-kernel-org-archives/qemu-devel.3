Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F9B0F30295
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 02:52:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1y2d-00026t-IR; Sun, 15 Mar 2026 22:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w1y2c-000265-8E
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 22:50:50 -0400
Received: from mail-dy1-x1330.google.com ([2607:f8b0:4864:20::1330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w1y2a-0000VK-ER
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 22:50:49 -0400
Received: by mail-dy1-x1330.google.com with SMTP id
 5a478bee46e88-2ba9c484e5eso4807428eec.1
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2026 19:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773629447; x=1774234247; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sMIe4BH1dC23aKjJXdUIHsVXt5i12Nl20FH16xA6kBU=;
 b=cSLUTL2Lq+XMApG3xJ9Kd1NNVdyQ2Dd94yl524bJqAw5S9pc4kUa2G3HaHklYwo1bw
 7NiX0BBGX5zoZqnA1TcbeyqR2b+AYENzM3NcMf9T16ut5A/wvtkYfjiLtuc300i6ceY6
 RTne/yCupjwCC3um8gKroVeiuFXpW4yLFGulFZ4jvl3H01Vj/tEmOwyjGFVWLXYf2d4j
 XOBsp2pSBBrxmUOT5QsDFeJZzrTuWbADkit3Ed5kgTsKIxG06SJIHHmdBHPfM5TSpFrC
 1d0AsvSTzrbLTiWkI8ON23v7Br5XvDgyDuxoD8yesJ6IJZ/X3UkUK6alBpULKQAiKeFh
 6K7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773629447; x=1774234247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sMIe4BH1dC23aKjJXdUIHsVXt5i12Nl20FH16xA6kBU=;
 b=bZ7zBYnHDOhgYFRIdo8mHLrDln1fTjG+S1fdwd7lEWAPmI6dgxVL2RYypI+jmqgBRO
 ck+cL1omMWit/wzmt8QESQQD5nHwE8BErpyRpD91dU0W5YdOYb6IZMKOe6WzFVxW3wsn
 W9dN1XULA5n10IUk/d31sTEV5pVcmyg082/9t3rXVCb15PFlXL29pktO8l4hGWsrON8u
 D5Pro49ZlNmo3V/waVLYtU6ZdUmIPs3oPLXuzFT8BqPFflAW5Uuvf+aM07k7sqw7f4So
 J1Ml6OvWcD5VZa5gV97ss76MxDUSkr2DbF9fJfzVhvVNeEi6fVC1HbvwrNXB2R/ZNfNA
 jWCg==
X-Gm-Message-State: AOJu0Yw0xSfsr/zr08mYIZQMQU3SMGg5oHuMVDJ7oaH5GnR7DMPPzUQw
 rhr0cgO0v+ga6sCWCPb3e3dRHLEQKmKs4c1xm2+gHKR3eR1V6L/xaEGWarMTIQMW
X-Gm-Gg: ATEYQzyNTL4Y09GaUWtm7L7ecx0HQJ6bHdgnBog2r6jNkpEAOcAuAT7VCZCXsyRy2LI
 MpIaLIqvaJOHZupMkYErRbgBEU80/UdxVIAiSTlC+6jIO3rRd/g6zT0dgKgOW3ro4lRDqtHMtdk
 DcB2kUJFmHmTwRPyQ359fEmzDBAh1gCZm1cQ4yXU+XFwV+Qw5GBQtVU9re2/TPn8+YRUO+v0S5c
 jXOAiWnjUPdNWSShVltio6uIFOiQTN+o7shmkoJjBVVcJSvTIC+DiTQJK5TkIqq3FJv8FqbY43B
 Vgv3Ff4J5dPe4P0InXCcO6JZk05eWy+D3L9IKDoVqJ72/SMYLB/i4fxaHmb9Mkb10pDHKuHl5ZL
 kJHU9jCixkPE8tLO1Vho7jLlJUWiXUch2kYjzBWU5Zfq6o12vNpUDeYA7e0ejpuNqBL2IZqHUsJ
 7+RlIGjGID/2OC5IQvAbsHk2B97pVsKnxsvL7JHE8=
X-Received: by 2002:a05:7301:d0f:b0:2be:ca4:e10b with SMTP id
 5a478bee46e88-2bea55915eemr5065970eec.35.1773629446448; 
 Sun, 15 Mar 2026 19:50:46 -0700 (PDT)
Received: from 192.168.7.2 ([189.6.247.75]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2beab3a12e2sm13138973eec.2.2026.03.15.19.50.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 15 Mar 2026 19:50:46 -0700 (PDT)
From: Lucas Amaral <lucaaamaral@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org,
 mohamed@unpredictable.fr, Lucas Amaral <lucaaamaral@gmail.com>
Subject: [PATCH v4 2/6] target/arm/emulate: add load/store register offset
Date: Sun, 15 Mar 2026 23:50:30 -0300
Message-ID: <20260316025034.85611-3-lucaaamaral@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260316025034.85611-1-lucaaamaral@gmail.com>
References: <20260315034123.41921-1-lucaaamaral@gmail.com>
 <20260316025034.85611-1-lucaaamaral@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1330;
 envelope-from=lucaaamaral@gmail.com; helo=mail-dy1-x1330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_BARE_IP_2=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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


