Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53509F3029A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 02:51:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1y31-0002Ag-Mu; Sun, 15 Mar 2026 22:51:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w1y2l-00028k-K3
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 22:51:00 -0400
Received: from mail-dy1-x1335.google.com ([2607:f8b0:4864:20::1335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w1y2j-0000XZ-MW
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 22:50:59 -0400
Received: by mail-dy1-x1335.google.com with SMTP id
 5a478bee46e88-2b4520f6b32so5826108eec.0
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2026 19:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773629456; x=1774234256; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XUL3MdtW+tx35/EnWaKqwdzi9rS198ej4aXzJufMgC4=;
 b=dwcj5lurtvg7pZIyRb8yoWGWyVnPlScmVZKu00xIU0R/ODUsQKK4ixlCtulAO5uCWi
 g1eaYFEWufjLEXxE6fh8cJXzdmEZAc0GJYdHPbpHg+zci7stcbF1qPK/GMpjFUZNCjLP
 flvA99IkQUmrZG6cCVxufs0lwINvNaxi9yiQsaaaK/JFG7v3/+eOB1BYfs5R0Yk7P2JO
 lIWFaHR2sEJBRCz/Pq8ShB4lnuRlJ4tPkH35PVCqYEX9roXCPMwWgKM9h9o7L8QTLknp
 TDqnmjnAhsDm4oUxVv30/Jjf6eXN11X3XXzySOeFMOqs59uP95YVNpUtLQHcAlNywF2L
 vbNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773629456; x=1774234256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XUL3MdtW+tx35/EnWaKqwdzi9rS198ej4aXzJufMgC4=;
 b=f8Q0Pl/PJl1EgljoiWvuvHt4LvNw0JCCNrqGDHhKoVwPN0qIZKLTAxuAbAVfkBj1We
 Nz9Dew0pIoZ0Wo4t7gN6EPY+Cxlcrewespj1XiATmfsyKhpVHab6MMu3spN4gw3nEjzT
 OMNXokMJ/cgftdA43tbRssau06m+0GBDg/s16ZQ1vZvDh47ueAF7/usnOiBICIwqyKw7
 cA8pDA++C1LRfSq8rn1By5mnCsbgtCkSduj972LIasfJgLvzFYMTuIzeUkEJdEEKAURI
 wgnyGjp8Ny82OUfCugKsrnua1pfIa60pCielLwhA7ZGXoeP4JxQI3NVDQ+s/S1lysB2A
 0NTQ==
X-Gm-Message-State: AOJu0YzIcSig7zovEwr+83Q8qZt+OGGsYUbF1RlJmbffEuEs2R8xy0Vy
 EqFT1nUCzsxAGkaFpl9dKtDEjKEgTw+VukDLQeNatCkFzfSGuTsl/zsfrVRFMIM9
X-Gm-Gg: ATEYQzxDvdwimHcuHlTFnWrJh8LyH3ISQoA9HVKb0i3sZqYSktdn0MjItc1upc2GCnY
 Wqaz/rCFo0V8l3d9z/aJ9N6Dwmuqc4y5JHDKBg1AlVdDZAT+J99pzZCx2bCwmBX0Ta5fljryMGb
 i+bINLe7TZ20wtewR1cMVgNEFuLoByLxeIjWm+GfM4nMKaeiDBpeGl/DwAOBRjFGu/HJ8qKobh4
 xNm6lsg5n0NLoDpNqYq0MZAQUWxmzfMqNn7IGhnujFA2hdMOKI9MjtmYnqtvqTmfBV4HkIMVd3M
 ejbfGh0cHwXIZQz1+xDkD0TCY+h8uALne7qPtaUmlzSc8VdEEd3TqAn7CO38g0oUgiAAP9O8Vwo
 GdGSufbtDS0J5mGI6FrDZar8viv0wKDFrIhEkUc0DyjZ73NDH5gIn4ejLCJ0v7cuzASYbWjbLvH
 gQr3UabKiT1049Cj6TEc4mxU2o3XIheyMGKoTftJ8=
X-Received: by 2002:a05:7300:f194:b0:2bd:e892:b075 with SMTP id
 5a478bee46e88-2bea547ccd6mr4942131eec.9.1773629455725; 
 Sun, 15 Mar 2026 19:50:55 -0700 (PDT)
Received: from 192.168.7.2 ([189.6.247.75]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2beab3a12e2sm13138973eec.2.2026.03.15.19.50.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 15 Mar 2026 19:50:55 -0700 (PDT)
From: Lucas Amaral <lucaaamaral@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org,
 mohamed@unpredictable.fr, Lucas Amaral <lucaaamaral@gmail.com>
Subject: [PATCH v4 5/6] target/arm/emulate: add atomic, compare-and-swap,
 and PAC load
Date: Sun, 15 Mar 2026 23:50:33 -0300
Message-ID: <20260316025034.85611-6-lucaaamaral@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260316025034.85611-1-lucaaamaral@gmail.com>
References: <20260315034123.41921-1-lucaaamaral@gmail.com>
 <20260316025034.85611-1-lucaaamaral@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1335;
 envelope-from=lucaaamaral@gmail.com; helo=mail-dy1-x1335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_BARE_IP_2=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Add emulation for remaining ISV=0 load/store instruction classes.

Atomic memory operations (DDI 0487 C3.3.2):
  - LDADD, LDCLR, LDEOR, LDSET: arithmetic/logic atomics
  - LDSMAX, LDSMIN, LDUMAX, LDUMIN: signed/unsigned min/max
  - SWP: atomic swap
  Non-atomic read-modify-write, sufficient for MMIO where concurrent
  access is not a concern.  Acquire/release semantics are ignored.

Compare-and-swap (DDI 0487 C3.3.1):
  - CAS/CASA/CASAL/CASL: single-register compare-and-swap
  - CASP/CASPA/CASPAL/CASPL: register-pair compare-and-swap
  CASP validates even register pairs; odd or r31 returns UNHANDLED.

Load with PAC (DDI 0487 C6.2.121):
  - LDRAA/LDRAB: pointer-authenticated load, offset/pre-indexed
  Pointer authentication is not emulated (equivalent to auth always
  succeeding), which is correct for MMIO since PAC is a software
  security mechanism, not a memory access semantic.

CASP uses two explicit decode patterns for the 32/64-bit size
variants.  LDRA's offset immediate is stored raw in the decode;
the handler scales by << 3.

Signed-off-by: Lucas Amaral <lucaaamaral@gmail.com>
---
 target/arm/emulate/a64-ldst.decode |  45 ++++++
 target/arm/emulate/arm_emulate.c   | 233 +++++++++++++++++++++++++++++
 2 files changed, 278 insertions(+)

diff --git a/target/arm/emulate/a64-ldst.decode b/target/arm/emulate/a64-ldst.decode
index fadf6fd2..9292bfdf 100644
--- a/target/arm/emulate/a64-ldst.decode
+++ b/target/arm/emulate/a64-ldst.decode
@@ -16,6 +16,16 @@
 # Load/store pair (GPR and SIMD/FP)
 &ldstpair       rt2 rt rn imm sz sign w p
 
+# Atomic memory operations
+&atomic         rs rn rt a r sz
+
+# Compare-and-swap
+&cas            rs rn rt sz a r
+
+# Load with PAC (LDRAA/LDRAB, FEAT_PAuth)
+%ldra_imm       22:s1 12:9
+&ldra           rt rn imm m w
+
 # Load/store register offset
 &ldst           rm rn rt sign ext sz opt s
 
@@ -36,6 +46,15 @@
 # Load/store pair: imm7 is signed, scaled by element size in handler
 @ldstpair       .. ... . ... . imm:s7 rt2:5 rn:5 rt:5          &ldstpair
 
+# Atomics
+@atomic         sz:2 ... . .. a:1 r:1 . rs:5 . ... .. rn:5 rt:5   &atomic
+
+# Compare-and-swap: sz extracted by pattern (CAS) or set constant (CASP)
+@cas            .. ...... . a:1 . rs:5 r:1 ..... rn:5 rt:5        &cas
+
+# Load with PAC
+@ldra           .. ... . .. m:1 . . ......... w:1 . rn:5 rt:5     &ldra imm=%ldra_imm
+
 # Load/store register offset
 @ldst           .. ... . .. .. . rm:5 opt:3 s:1 .. rn:5 rt:5   &ldst
 
@@ -241,6 +260,32 @@ STR_v           00 111 1 00 10 1 ..... ... . 10 ..... .....    @ldst sign=0 ext=
 LDR_v           sz:2 111 1 00 01 1 ..... ... . 10 ..... .....  @ldst sign=0 ext=0
 LDR_v           00 111 1 00 11 1 ..... ... . 10 ..... .....    @ldst sign=0 ext=0 sz=4
 
+### Compare-and-swap
+
+# CAS / CASA / CASAL / CASL
+CAS             sz:2 001000 1 . 1 ..... . 11111 ..... .....     @cas
+
+# CASP / CASPA / CASPAL / CASPL (pair: Rt,Rt+1 and Rs,Rs+1)
+CASP            00 001000 0 . 1 ..... . 11111 ..... .....       @cas sz=2
+CASP            01 001000 0 . 1 ..... . 11111 ..... .....       @cas sz=3
+
+### Atomic memory operations
+
+LDADD           .. 111 0 00 . . 1 ..... 0000 00 ..... .....    @atomic
+LDCLR           .. 111 0 00 . . 1 ..... 0001 00 ..... .....    @atomic
+LDEOR           .. 111 0 00 . . 1 ..... 0010 00 ..... .....    @atomic
+LDSET           .. 111 0 00 . . 1 ..... 0011 00 ..... .....    @atomic
+LDSMAX          .. 111 0 00 . . 1 ..... 0100 00 ..... .....    @atomic
+LDSMIN          .. 111 0 00 . . 1 ..... 0101 00 ..... .....    @atomic
+LDUMAX          .. 111 0 00 . . 1 ..... 0110 00 ..... .....    @atomic
+LDUMIN          .. 111 0 00 . . 1 ..... 0111 00 ..... .....    @atomic
+SWP             .. 111 0 00 . . 1 ..... 1000 00 ..... .....    @atomic
+
+### Load with PAC (FEAT_PAuth)
+
+# LDRAA (M=0) / LDRAB (M=1), offset (W=0) / pre-indexed (W=1)
+LDRA            11 111 0 00 . . 1 ......... . 1 ..... .....  @ldra
+
 ### System instructions — DC cache maintenance
 
 # SYS with CRn=C7 covers all data cache operations (DC CIVAC, CVAC, etc.).
diff --git a/target/arm/emulate/arm_emulate.c b/target/arm/emulate/arm_emulate.c
index 52e41703..44a559ad 100644
--- a/target/arm/emulate/arm_emulate.c
+++ b/target/arm/emulate/arm_emulate.c
@@ -499,6 +499,239 @@ static bool trans_LDXP(DisasContext *ctx, arg_stxr *a)
     return true;
 }
 
+/*
+ * Atomic memory operations (DDI 0487 C3.3.2)
+ *
+ * Non-atomic read-modify-write; sufficient for MMIO.
+ * Acquire/release semantics ignored (sequentially consistent by design).
+ */
+
+typedef uint64_t (*atomic_op_fn)(uint64_t old, uint64_t operand, int bits);
+
+static uint64_t atomic_add(uint64_t old, uint64_t op, int bits)
+{
+    (void)bits;
+    return old + op;
+}
+
+static uint64_t atomic_clr(uint64_t old, uint64_t op, int bits)
+{
+    (void)bits;
+    return old & ~op;
+}
+
+static uint64_t atomic_eor(uint64_t old, uint64_t op, int bits)
+{
+    (void)bits;
+    return old ^ op;
+}
+
+static uint64_t atomic_set(uint64_t old, uint64_t op, int bits)
+{
+    (void)bits;
+    return old | op;
+}
+
+static uint64_t atomic_smax(uint64_t old, uint64_t op, int bits)
+{
+    int64_t a = sign_extend(old, bits);
+    int64_t b = sign_extend(op, bits);
+    return (a >= b) ? old : op;
+}
+
+static uint64_t atomic_smin(uint64_t old, uint64_t op, int bits)
+{
+    int64_t a = sign_extend(old, bits);
+    int64_t b = sign_extend(op, bits);
+    return (a <= b) ? old : op;
+}
+
+static uint64_t atomic_umax(uint64_t old, uint64_t op, int bits)
+{
+    uint64_t mask = (bits == 64) ? UINT64_MAX : (1ULL << bits) - 1;
+    return ((old & mask) >= (op & mask)) ? old : op;
+}
+
+static uint64_t atomic_umin(uint64_t old, uint64_t op, int bits)
+{
+    uint64_t mask = (bits == 64) ? UINT64_MAX : (1ULL << bits) - 1;
+    return ((old & mask) <= (op & mask)) ? old : op;
+}
+
+static bool do_atomic(DisasContext *ctx, arg_atomic *a, atomic_op_fn fn)
+{
+    int esize = 1 << a->sz;
+    int bits = 8 * esize;
+    uint64_t va = base_read(ctx, a->rn);
+    uint64_t old = 0;
+
+    if (mem_read(ctx, va, &old, esize) != 0) {
+        return true;
+    }
+
+    uint64_t operand = gpr_read(ctx, a->rs);
+    uint64_t result = fn(old, operand, bits);
+
+    if (mem_write(ctx, va, &result, esize) != 0) {
+        return true;
+    }
+
+    /* Rt receives the old value (before modification) */
+    gpr_write(ctx, a->rt, old);
+    return true;
+}
+
+static bool trans_LDADD(DisasContext *ctx, arg_atomic *a)
+{
+    return do_atomic(ctx, a, atomic_add);
+}
+
+static bool trans_LDCLR(DisasContext *ctx, arg_atomic *a)
+{
+    return do_atomic(ctx, a, atomic_clr);
+}
+
+static bool trans_LDEOR(DisasContext *ctx, arg_atomic *a)
+{
+    return do_atomic(ctx, a, atomic_eor);
+}
+
+static bool trans_LDSET(DisasContext *ctx, arg_atomic *a)
+{
+    return do_atomic(ctx, a, atomic_set);
+}
+
+static bool trans_LDSMAX(DisasContext *ctx, arg_atomic *a)
+{
+    return do_atomic(ctx, a, atomic_smax);
+}
+
+static bool trans_LDSMIN(DisasContext *ctx, arg_atomic *a)
+{
+    return do_atomic(ctx, a, atomic_smin);
+}
+
+static bool trans_LDUMAX(DisasContext *ctx, arg_atomic *a)
+{
+    return do_atomic(ctx, a, atomic_umax);
+}
+
+static bool trans_LDUMIN(DisasContext *ctx, arg_atomic *a)
+{
+    return do_atomic(ctx, a, atomic_umin);
+}
+
+static bool trans_SWP(DisasContext *ctx, arg_atomic *a)
+{
+    int esize = 1 << a->sz;
+    uint64_t va = base_read(ctx, a->rn);
+    uint64_t old = 0;
+
+    if (mem_read(ctx, va, &old, esize) != 0) {
+        return true;
+    }
+
+    uint64_t newval = gpr_read(ctx, a->rs);
+    if (mem_write(ctx, va, &newval, esize) != 0) {
+        return true;
+    }
+
+    gpr_write(ctx, a->rt, old);
+    return true;
+}
+
+/* Compare-and-swap: CAS, CASP (DDI 0487 C3.3.1) */
+
+static bool trans_CAS(DisasContext *ctx, arg_cas *a)
+{
+    int esize = 1 << a->sz;
+    uint64_t va = base_read(ctx, a->rn);
+    uint64_t current = 0;
+
+    if (mem_read(ctx, va, &current, esize) != 0) {
+        return true;
+    }
+
+    uint64_t mask = (esize == 8) ? UINT64_MAX : (1ULL << (8 * esize)) - 1;
+    uint64_t compare = gpr_read(ctx, a->rs) & mask;
+
+    if ((current & mask) == compare) {
+        uint64_t newval = gpr_read(ctx, a->rt) & mask;
+        if (mem_write(ctx, va, &newval, esize) != 0) {
+            return true;
+        }
+    }
+
+    /* Rs receives the old memory value (whether or not swap occurred) */
+    gpr_write(ctx, a->rs, current);
+    return true;
+}
+
+/* CASP: compare-and-swap pair (Rs,Rs+1 compared; Rt,Rt+1 stored) */
+static bool trans_CASP(DisasContext *ctx, arg_cas *a)
+{
+    /* CASP requires even register pairs; odd or r31 is UNPREDICTABLE */
+    if ((a->rs & 1) || a->rs >= 31 || (a->rt & 1) || a->rt >= 31) {
+        return false;
+    }
+
+    int esize = 1 << a->sz;                   /* per-register size */
+    uint64_t va = base_read(ctx, a->rn);
+    uint8_t buf[16];
+    uint64_t cur1 = 0, cur2 = 0;
+
+    if (mem_read(ctx, va, buf, 2 * esize) != 0) {
+        return true;
+    }
+    memcpy(&cur1, buf, esize);
+    memcpy(&cur2, buf + esize, esize);
+
+    uint64_t mask = (esize == 8) ? UINT64_MAX : (1ULL << (8 * esize)) - 1;
+    uint64_t cmp1 = gpr_read(ctx, a->rs) & mask;
+    uint64_t cmp2 = gpr_read(ctx, a->rs + 1) & mask;
+
+    if ((cur1 & mask) == cmp1 && (cur2 & mask) == cmp2) {
+        uint64_t new1 = gpr_read(ctx, a->rt) & mask;
+        uint64_t new2 = gpr_read(ctx, a->rt + 1) & mask;
+        memcpy(buf, &new1, esize);
+        memcpy(buf + esize, &new2, esize);
+        if (mem_write(ctx, va, buf, 2 * esize) != 0) {
+            return true;
+        }
+    }
+
+    gpr_write(ctx, a->rs, cur1);
+    gpr_write(ctx, a->rs + 1, cur2);
+    return true;
+}
+
+/*
+ * Load with PAC: LDRAA / LDRAB (FEAT_PAuth)
+ * (DDI 0487 C6.2.121)
+ *
+ * Pointer authentication is not emulated -- the base register is used
+ * directly (equivalent to auth always succeeding).
+ */
+
+static bool trans_LDRA(DisasContext *ctx, arg_ldra *a)
+{
+    int64_t offset = (int64_t)a->imm << 3;  /* S:imm9, scaled by 8 */
+    uint64_t base = base_read(ctx, a->rn);
+    uint64_t va = base + offset;  /* auth not emulated */
+    uint64_t val = 0;
+
+    if (mem_read(ctx, va, &val, 8) != 0) {
+        return true;
+    }
+
+    gpr_write(ctx, a->rt, val);
+
+    if (a->w) {
+        base_write(ctx, a->rn, va);
+    }
+    return true;
+}
+
 /* PRFM, DC cache maintenance -- treated as NOP */
 static bool trans_NOP(DisasContext *ctx, arg_NOP *a)
 {
-- 
2.52.0


