Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C3BF364C8
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 22:07:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAxWJ-00089l-Hz; Thu, 09 Apr 2026 18:06:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1wAxWH-00088p-UB
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 18:06:37 -0400
Received: from mail-dy1-x1334.google.com ([2607:f8b0:4864:20::1334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1wAxWF-0000bj-Nu
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 18:06:37 -0400
Received: by mail-dy1-x1334.google.com with SMTP id
 5a478bee46e88-2c54c68db4dso2370619eec.0
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 15:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775772394; x=1776377194; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9hYjt5TP5fiILetOflamrBDH1HToT8NoGi40uxHb3Qw=;
 b=Ox19hzQ6s0TCJJohcsgjIjPdiHFgZl9O0iQ1GTLCTwTjdcqgHdAxGeiIqBbwJhln4v
 qZ1tkExiIJL27D0WrTIL/rCM+SmL+VDgbMQOMTdfEEf8Q4WlYw6+66HF1yte4LEDRsi7
 eqrcGYvCKQFn7jyf21PNvMASFgKYb+CnYGsKyaD5K+l3Lx2XxXi2b7Jk8xQjvIC4SPG2
 u1tg9u+Z0ECGrn1/UpErPTDQW/3rmW7hywntDrV6xS6atJSxqqfzp1XbQcr6KZMIhtES
 ZcYZmD4GKT7BC5Iw9YxJkJDEy9K6+ioni2Fiojxj+l1PAsUviLaR1YMnHSl3hiAhhBbR
 pxug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775772394; x=1776377194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9hYjt5TP5fiILetOflamrBDH1HToT8NoGi40uxHb3Qw=;
 b=owqPE4+dlzDWqHphqfymQPVHV1b+PE9/b1nhzQ/nR2rJBXy+ByuNpR/WQ4ehb73q+j
 ipooU2TG2Wwh8Dj4dpcGeHcQ4rys9LQhJOlYMXvZoZ9mEkfoA+Ef3rSZh9zcuiEhvlu1
 44gtJxxR/kzAo7WgX31Nl90R/XB8X54wcrBPEBNha5tDd6SeSPriWMS3B65WBga8i5A6
 pMph2JXt1sB1X8XSjZM7J2GsMRiO8dI10jf0u++4MJxSOYwe8e7KWyV+BavhHfXcuZvR
 R5M65vXR33YKtqAtmhnZRMs0X2RtporWPeP2R+ytTDh6LoJZU9bDqrwn6M7vC5/CRSvk
 MOpg==
X-Gm-Message-State: AOJu0YxcWZgySBzqCxsBrkzGBPnQ1e/z+zi9j6T9AWKLEF7aqqK/NgNE
 GI1sfVSCHOg3Rqt7Icul+q2HTP3o8AtFkfoFsBinAKxAiZQTGBR7EMLG3VK1b+8V
X-Gm-Gg: AeBDies4pVxfUZ2WvAb0+JS8eervdvk+MPExEdMr4icph+rjb2LLgRUpzWa64MyB7Nn
 vkypaZaAXHdBjYz06Z0I2r/l8m79cfF/8Kx8dxr7Y52tEJcYjoFOpNwnwI/jQu6wrlDt15KA24N
 GbW8Txs7s/mcqbaF8sIS+800957JM8iY89pkDklMisEI3/Ajgoh2elSjOARR5ntG/E7qLod4a7b
 zxy9Y/sUMEGwfSEw4vX/qpXokK7qFQGE8k5GmXjAsmjI6sBQDASU9Clah3pRHdnJdsXl9mpx9YT
 tGNb07gwH3yyuDeZAkQglUN9XcWOhGyLcYmOGL7DTB3PbTHE2sRtkkul5F/QPR5eTX1/DZSR7na
 MeJPXAjl5kBz7Dd4tLj/v9vTvS/7IHTjLrYCtF9duQH0E64JerfZeSTg9E6OZs/4R9NlRnXZs+R
 t0qWeBPx0rJ6IJaXk03t3QcgJ/PSKuuOH0MSgeSUvrAIC/Yf8GrwxYphogOhuymIOwfdhmjoX0
X-Received: by 2002:a05:7300:6da8:b0:2c4:a862:2368 with SMTP id
 5a478bee46e88-2d5871bcb93mr529162eec.2.1775772393713; 
 Thu, 09 Apr 2026 15:06:33 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f4:c030:bb40:195d:78fd:ecba:d45])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2d561bde68bsm1534567eec.17.2026.04.09.15.06.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Apr 2026 15:06:33 -0700 (PDT)
From: Lucas Amaral <lucaaamaral@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org,
 mohamed@unpredictable.fr, alex.bennee@linaro.org,
 richard.henderson@linaro.org, Lucas Amaral <lucaaamaral@gmail.com>
Subject: [PATCH v6 3/6] target/arm/emulate: add load/store pair
Date: Thu,  9 Apr 2026 19:06:11 -0300
Message-ID: <20260409220614.65558-4-lucaaamaral@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260409220614.65558-1-lucaaamaral@gmail.com>
References: <20260409220614.65558-1-lucaaamaral@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1334;
 envelope-from=lucaaamaral@gmail.com; helo=mail-dy1-x1334.google.com
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

Add emulation for load/store pair instructions (DDI 0487 C3.3.14 --
C3.3.16).  All addressing modes are covered: non-temporal (STNP/LDNP),
post-indexed, signed offset, and pre-indexed.

Instruction coverage:
  - STP/LDP (GPR): 32/64-bit pairs, all addressing modes
  - STP/LDP (SIMD/FP): 32/64/128-bit pairs, all addressing modes
  - LDPSW: sign-extending 32-bit pair load
  - STGP: store allocation tag pair (tag operation is NOP for MMIO)

Signed-off-by: Lucas Amaral <lucaaamaral@gmail.com>
---
 target/arm/emulate/a64-ldst.decode |  68 ++++++++++++++++++
 target/arm/emulate/arm_emulate.c   | 108 +++++++++++++++++++++++++++++
 2 files changed, 176 insertions(+)

diff --git a/target/arm/emulate/a64-ldst.decode b/target/arm/emulate/a64-ldst.decode
index af6babe1..f3de3f86 100644
--- a/target/arm/emulate/a64-ldst.decode
+++ b/target/arm/emulate/a64-ldst.decode
@@ -10,6 +10,9 @@
 # 'u' flag: 0 = 9-bit signed immediate (byte offset), 1 = 12-bit unsigned (needs << sz)
 &ldst_imm       rt rn imm sz sign w p unpriv ext u
 
+# Load/store pair (GPR and SIMD/FP)
+&ldstpair       rt2 rt rn imm sz sign w p
+
 # Load/store register offset
 &ldst           rm rn rt sign ext sz opt s
 
@@ -24,6 +27,9 @@
 # Load/store unsigned offset (12-bit, handler scales by << sz)
 @ldst_uimm      .. ... . .. .. imm:12 rn:5 rt:5        &ldst_imm u=1 unpriv=0 p=0 w=0
 
+# Load/store pair: imm7 is signed, scaled by element size in handler
+@ldstpair       .. ... . ... . imm:s7 rt2:5 rn:5 rt:5          &ldstpair
+
 # Load/store register offset
 @ldst           .. ... . .. .. . rm:5 opt:3 s:1 .. rn:5 rt:5   &ldst
 
@@ -128,6 +134,68 @@ STR_v_i         00 111 1 01 10 ............ ..... .....         @ldst_uimm sign=
 LDR_v_i         sz:2 111 1 01 01 ............ ..... .....       @ldst_uimm sign=0 ext=0
 LDR_v_i         00 111 1 01 11 ............ ..... .....         @ldst_uimm sign=0 ext=0 sz=4
 
+### Load/store pair — non-temporal (STNP/LDNP)
+
+# STNP/LDNP: offset only, no writeback.  Non-temporal hint ignored.
+STP             00 101 0 000 0 ....... ..... ..... .....        @ldstpair sz=2 sign=0 p=0 w=0
+LDP             00 101 0 000 1 ....... ..... ..... .....        @ldstpair sz=2 sign=0 p=0 w=0
+STP             10 101 0 000 0 ....... ..... ..... .....        @ldstpair sz=3 sign=0 p=0 w=0
+LDP             10 101 0 000 1 ....... ..... ..... .....        @ldstpair sz=3 sign=0 p=0 w=0
+STP_v           00 101 1 000 0 ....... ..... ..... .....        @ldstpair sz=2 sign=0 p=0 w=0
+LDP_v           00 101 1 000 1 ....... ..... ..... .....        @ldstpair sz=2 sign=0 p=0 w=0
+STP_v           01 101 1 000 0 ....... ..... ..... .....        @ldstpair sz=3 sign=0 p=0 w=0
+LDP_v           01 101 1 000 1 ....... ..... ..... .....        @ldstpair sz=3 sign=0 p=0 w=0
+STP_v           10 101 1 000 0 ....... ..... ..... .....        @ldstpair sz=4 sign=0 p=0 w=0
+LDP_v           10 101 1 000 1 ....... ..... ..... .....        @ldstpair sz=4 sign=0 p=0 w=0
+
+### Load/store pair — post-indexed
+
+STP             00 101 0 001 0 ....... ..... ..... .....        @ldstpair sz=2 sign=0 p=1 w=1
+LDP             00 101 0 001 1 ....... ..... ..... .....        @ldstpair sz=2 sign=0 p=1 w=1
+LDP             01 101 0 001 1 ....... ..... ..... .....        @ldstpair sz=2 sign=1 p=1 w=1
+STP             10 101 0 001 0 ....... ..... ..... .....        @ldstpair sz=3 sign=0 p=1 w=1
+LDP             10 101 0 001 1 ....... ..... ..... .....        @ldstpair sz=3 sign=0 p=1 w=1
+STP_v           00 101 1 001 0 ....... ..... ..... .....        @ldstpair sz=2 sign=0 p=1 w=1
+LDP_v           00 101 1 001 1 ....... ..... ..... .....        @ldstpair sz=2 sign=0 p=1 w=1
+STP_v           01 101 1 001 0 ....... ..... ..... .....        @ldstpair sz=3 sign=0 p=1 w=1
+LDP_v           01 101 1 001 1 ....... ..... ..... .....        @ldstpair sz=3 sign=0 p=1 w=1
+STP_v           10 101 1 001 0 ....... ..... ..... .....        @ldstpair sz=4 sign=0 p=1 w=1
+LDP_v           10 101 1 001 1 ....... ..... ..... .....        @ldstpair sz=4 sign=0 p=1 w=1
+
+### Load/store pair — signed offset
+
+STP             00 101 0 010 0 ....... ..... ..... .....        @ldstpair sz=2 sign=0 p=0 w=0
+LDP             00 101 0 010 1 ....... ..... ..... .....        @ldstpair sz=2 sign=0 p=0 w=0
+LDP             01 101 0 010 1 ....... ..... ..... .....        @ldstpair sz=2 sign=1 p=0 w=0
+STP             10 101 0 010 0 ....... ..... ..... .....        @ldstpair sz=3 sign=0 p=0 w=0
+LDP             10 101 0 010 1 ....... ..... ..... .....        @ldstpair sz=3 sign=0 p=0 w=0
+STP_v           00 101 1 010 0 ....... ..... ..... .....        @ldstpair sz=2 sign=0 p=0 w=0
+LDP_v           00 101 1 010 1 ....... ..... ..... .....        @ldstpair sz=2 sign=0 p=0 w=0
+STP_v           01 101 1 010 0 ....... ..... ..... .....        @ldstpair sz=3 sign=0 p=0 w=0
+LDP_v           01 101 1 010 1 ....... ..... ..... .....        @ldstpair sz=3 sign=0 p=0 w=0
+STP_v           10 101 1 010 0 ....... ..... ..... .....        @ldstpair sz=4 sign=0 p=0 w=0
+LDP_v           10 101 1 010 1 ....... ..... ..... .....        @ldstpair sz=4 sign=0 p=0 w=0
+
+### Load/store pair — pre-indexed
+
+STP             00 101 0 011 0 ....... ..... ..... .....        @ldstpair sz=2 sign=0 p=0 w=1
+LDP             00 101 0 011 1 ....... ..... ..... .....        @ldstpair sz=2 sign=0 p=0 w=1
+LDP             01 101 0 011 1 ....... ..... ..... .....        @ldstpair sz=2 sign=1 p=0 w=1
+STP             10 101 0 011 0 ....... ..... ..... .....        @ldstpair sz=3 sign=0 p=0 w=1
+LDP             10 101 0 011 1 ....... ..... ..... .....        @ldstpair sz=3 sign=0 p=0 w=1
+STP_v           00 101 1 011 0 ....... ..... ..... .....        @ldstpair sz=2 sign=0 p=0 w=1
+LDP_v           00 101 1 011 1 ....... ..... ..... .....        @ldstpair sz=2 sign=0 p=0 w=1
+STP_v           01 101 1 011 0 ....... ..... ..... .....        @ldstpair sz=3 sign=0 p=0 w=1
+LDP_v           01 101 1 011 1 ....... ..... ..... .....        @ldstpair sz=3 sign=0 p=0 w=1
+STP_v           10 101 1 011 0 ....... ..... ..... .....        @ldstpair sz=4 sign=0 p=0 w=1
+LDP_v           10 101 1 011 1 ....... ..... ..... .....        @ldstpair sz=4 sign=0 p=0 w=1
+
+### Load/store pair — STGP (store allocation tag + pair)
+
+STGP            01 101 0 001 0 ....... ..... ..... .....        @ldstpair sz=3 sign=0 p=1 w=1
+STGP            01 101 0 010 0 ....... ..... ..... .....        @ldstpair sz=3 sign=0 p=0 w=0
+STGP            01 101 0 011 0 ....... ..... ..... .....        @ldstpair sz=3 sign=0 p=0 w=1
+
 ### Load/store register — register offset
 
 # GPR
diff --git a/target/arm/emulate/arm_emulate.c b/target/arm/emulate/arm_emulate.c
index 79f42d44..2d86b90f 100644
--- a/target/arm/emulate/arm_emulate.c
+++ b/target/arm/emulate/arm_emulate.c
@@ -171,6 +171,114 @@ static uint64_t load_extend(uint64_t val, int sz, int sign, int ext)
     return val;
 }
 
+/*
+ * Load/store pair: STP, LDP, STNP, LDNP, STGP, LDPSW
+ * (DDI 0487 C3.3.14 -- C3.3.16)
+ */
+
+static bool trans_STP(DisasContext *ctx, arg_ldstpair *a)
+{
+    int esize = 1 << a->sz;                   /* 4 or 8 bytes */
+    int64_t offset = (int64_t)a->imm << a->sz;
+    uint64_t base = base_read(ctx, a->rn);
+    uint64_t va = a->p ? base : base + offset; /* post-index: unmodified base */
+    uint8_t buf[16];                           /* max 2 x 8 bytes */
+
+    mem_st(ctx, buf, esize, gpr_read(ctx, a->rt));
+    mem_st(ctx, buf + esize, esize, gpr_read(ctx, a->rt2));
+
+    if (mem_write(ctx, va, buf, 2 * esize) != 0) {
+        return true;
+    }
+
+    if (a->w) {
+        base_write(ctx, a->rn, base + offset);
+    }
+    return true;
+}
+
+static bool trans_LDP(DisasContext *ctx, arg_ldstpair *a)
+{
+    int esize = 1 << a->sz;
+    int64_t offset = (int64_t)a->imm << a->sz;
+    uint64_t base = base_read(ctx, a->rn);
+    uint64_t va = a->p ? base : base + offset;
+    uint8_t buf[16];
+
+    if (mem_read(ctx, va, buf, 2 * esize) != 0) {
+        return true;
+    }
+    uint64_t v1 = mem_ld(ctx, buf, esize);
+    uint64_t v2 = mem_ld(ctx, buf + esize, esize);
+
+    /* LDPSW: sign-extend 32-bit values to 64-bit (sign=1, sz=2) */
+    if (a->sign) {
+        v1 = sextract64(v1, 0, 8 * esize);
+        v2 = sextract64(v2, 0, 8 * esize);
+    }
+
+    gpr_write(ctx, a->rt, v1);
+    gpr_write(ctx, a->rt2, v2);
+
+    if (a->w) {
+        base_write(ctx, a->rn, base + offset);
+    }
+    return true;
+}
+
+/* STGP: tag operation is a NOP for emulation; data stored via STP */
+static bool trans_STGP(DisasContext *ctx, arg_ldstpair *a)
+{
+    return trans_STP(ctx, a);
+}
+
+/*
+ * SIMD/FP load/store pair: STP_v, LDP_v
+ * (DDI 0487 C3.3.14 -- C3.3.16)
+ */
+
+static bool trans_STP_v(DisasContext *ctx, arg_ldstpair *a)
+{
+    int esize = 1 << a->sz;                   /* 4, 8, or 16 bytes */
+    int64_t offset = (int64_t)a->imm << a->sz;
+    uint64_t base = base_read(ctx, a->rn);
+    uint64_t va = a->p ? base : base + offset;
+    uint8_t buf[32];                           /* max 2 x 16 bytes */
+
+    fpreg_read(ctx, a->rt, buf, esize);
+    fpreg_read(ctx, a->rt2, buf + esize, esize);
+
+    if (mem_write(ctx, va, buf, 2 * esize) != 0) {
+        return true;
+    }
+
+    if (a->w) {
+        base_write(ctx, a->rn, base + offset);
+    }
+    return true;
+}
+
+static bool trans_LDP_v(DisasContext *ctx, arg_ldstpair *a)
+{
+    int esize = 1 << a->sz;
+    int64_t offset = (int64_t)a->imm << a->sz;
+    uint64_t base = base_read(ctx, a->rn);
+    uint64_t va = a->p ? base : base + offset;
+    uint8_t buf[32];
+
+    if (mem_read(ctx, va, buf, 2 * esize) != 0) {
+        return true;
+    }
+
+    fpreg_write(ctx, a->rt, buf, esize);
+    fpreg_write(ctx, a->rt2, buf + esize, esize);
+
+    if (a->w) {
+        base_write(ctx, a->rn, base + offset);
+    }
+    return true;
+}
+
 /* Load/store single -- immediate (GPR) (DDI 0487 C3.3.8 -- C3.3.13) */
 
 static bool trans_STR_i(DisasContext *ctx, arg_ldst_imm *a)
-- 
2.52.0


