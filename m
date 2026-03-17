Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E305FED9F6
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 17:52:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2YX6-0003Uk-C9; Tue, 17 Mar 2026 13:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w2YWq-0003PR-IS
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 13:48:29 -0400
Received: from mail-dy1-x1329.google.com ([2607:f8b0:4864:20::1329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w2YWj-00070c-IG
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 13:48:24 -0400
Received: by mail-dy1-x1329.google.com with SMTP id
 5a478bee46e88-2bea8a1c040so3966085eec.0
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 10:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773769696; x=1774374496; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1mi5fHub76Brx7fYisPysAjGTUbFqaDrmY/Z5I6JcUc=;
 b=gOmi9kTF15pZVM3n93Msob56bca5J9fXCdwkYmACznNlIsgVy361pGYz/uysSxegeO
 1KEUXGv3tuhA/CCrPlk6XNdNjsn+TXn/3qlKhCeJvJCQ16+ETJSCi4OtoHTNQdqP++hC
 j2Qm5SEpkD2jzai3sVELFBScRTPM6PGFORv09Odqjqz6Hz8obkm8CatHj5/MgoWya9pm
 zgwP/X2pKBB2YJiXmUiEqBucce69L9pnjWPVU/2acFmy4YNAN3PIYbRrqJWeq9wftBkx
 5QdJqPoNJT88Ol7QTQ4w86NY8nrHoroG4IFEetJGvQMZLswgt5E08T2GTZiDK8lpZE2V
 Ghzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773769696; x=1774374496;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1mi5fHub76Brx7fYisPysAjGTUbFqaDrmY/Z5I6JcUc=;
 b=kZ7wfL+sSy9du4r2O8afW8UP9tajyf6zYSSfisKjJAgSDJjt7tnZ6atY1TW6Old7p4
 WU96cCmBybUhH0uXUi6s43+PKfKApGs4tbiLQdWj0jPZxDmJO4Ab2z/ulchzNE5NWweV
 Oiv3uMiJotFZ+3/Lu/EEI1XUEb7u6V2ST2fBo0tsOVrtHXiLC+0XLuhmAGecu7JRiXS0
 JPhwMnh1URCjq0CUj7NsObfjgSgi92oZIWA/lCYH9ju/eOYWmdg06LyuFkeTI5UEH6Rm
 IS3Ul+umcWeSPVEOJjrSwzM6l0bPLij3vD9XGBvJ/BTZm8+YfB9jvxVnWYhJJXswnx+q
 tVJQ==
X-Gm-Message-State: AOJu0YwlCFWSv8ujfVg0MWag9fG1GvrOaTijwhjFYDS61UuJwfCEYjDP
 bPxPPIce/iJcenWH4Dj33qxQf8e5rJiEEoFzchDmV4IY5zx4WYsZALg4Votg0Hif
X-Gm-Gg: ATEYQzzwDVeSnbKXM3Y8UIwjCi6Vo8WtZxS5TSNH9QULeE5OAFbbVXvCwWvR/Ej2U5l
 ZbYJHkWq/QGdxBeVFd5QMji0Ifa2KMgRG58J7iJa4tP2KeH6ORMdFdzJyY/ANxJ8QsQZu7JbCOr
 cG/o17skZtfvbpqTy+ow1AeTHM5EwF6R9VSdObD4spLCmcFlfc+K2IBCj38sXUTI1nM4jHS4MzW
 mWpBofGmFOSChCo8FS6HoQgxaKmfJ3zTcdj4sAorXsoGa75LT+4YxXFiiQdQ70kPZueqnkR+mu3
 veR6Bz/6cf/tOlF4x3oca5LqFktD/X527jBHji4OhLJMUJs+VnHgf8IUCLNK6BNnpH0EukXoyx9
 CxZby6OtG7bURgt9h0s5SltBWl7GINiJMCOi189rA7JXi9vIabKlrBsiGrQS6anvqR+ugO6L75I
 KGS27M85AC7Nwq/2rqFjCCaZ7mGq3voBdafLZjJ8/NtIhdGJ4q3bGG
X-Received: by 2002:a05:7022:6993:b0:128:d202:87b with SMTP id
 a92af1059eb24-129a719e498mr179552c88.40.1773769695633; 
 Tue, 17 Mar 2026 10:48:15 -0700 (PDT)
Received: from localhost.localdomain ([143.54.78.51])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-129b4147522sm281844c88.15.2026.03.17.10.48.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 17 Mar 2026 10:48:15 -0700 (PDT)
From: Lucas Amaral <lucaaamaral@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org,
 mohamed@unpredictable.fr, alex.bennee@linaro.org,
 Lucas Amaral <lucaaamaral@gmail.com>
Subject: [PATCH v5 5/6] target/arm/emulate: add atomic, compare-and-swap,
 and PAC load
Date: Tue, 17 Mar 2026 14:47:39 -0300
Message-ID: <20260317174740.31674-6-lucaaamaral@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260317174740.31674-1-lucaaamaral@gmail.com>
References: <20260317174740.31674-1-lucaaamaral@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1329;
 envelope-from=lucaaamaral@gmail.com; helo=mail-dy1-x1329.google.com
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

Decodetree differences from TCG:
  - %ldra_imm extracts the raw S:imm9 field; the handler scales by
    << 3.  TCG applies !function=times_8 in the formatter.
  - @ldra uses wildcards for fixed opcode bits that TCG locks down
    (bits 31:30, bit 20, bit 11); the fixed bits are matched by the
    instruction pattern instead.
  - @cas is an explicit format template; TCG uses inline field
    extraction.

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


