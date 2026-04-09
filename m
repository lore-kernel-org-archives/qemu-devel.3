Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F38F364C8
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 22:07:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAxWM-0008AE-D9; Thu, 09 Apr 2026 18:06:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1wAxWL-00089y-Gx
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 18:06:41 -0400
Received: from mail-dy1-x1329.google.com ([2607:f8b0:4864:20::1329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1wAxWJ-0000c2-Ow
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 18:06:41 -0400
Received: by mail-dy1-x1329.google.com with SMTP id
 5a478bee46e88-2cf1646bd11so2355487eec.1
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 15:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775772398; x=1776377198; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8eMPJQLlf+3OGRaso7a3nCpBSTalIXEmmU/N+0pBWN0=;
 b=EJqH9Or3fWjvw3NNz7EYHYV9Momvz4Cfu8UtsvZPmwwVzIqpjY5OyD0AG4nlgbgTZm
 zIxooWKxMLunOp0TLGB0WhWrvI4CvA0ONM6iNQKiYmLyG8Uw68XbRtW04jyMJq22wnMi
 xNHDHhimgDqGWx2Xe77ES5M2kbRqGWMniGQaaaecBMv0zZS3pMZsTLyG2iEFTFbWbNjr
 jq0IOMQH7THX2BwZH4Blu4Y/v5hY0E3GCt6Tks2xmIkmUGypng2eqzO2deRC1+lmnupE
 LCGH7mamXLN6LmD8uGDV02m73RUxVwM7GcAh+zekcNt1XXlwDhWn/BS9qPRJ68t5jb0E
 DucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775772398; x=1776377198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8eMPJQLlf+3OGRaso7a3nCpBSTalIXEmmU/N+0pBWN0=;
 b=PYijqx4t5jWvT7cVgifHfmVAoNItRZQ0Wnj4PR8r9wMQ54gQA53hcGHgv2EU44k04a
 zZbzS2EhNlVZ0Wnry6Qi5prH5OsViW5n4K9DRlQyyunheoGfNDiSKxuObdZg/SQvrj0B
 9kZ9LtU6NIfgCyrwPd03rrMWqj1GiPUkx2RNZZ80BsSkIxKjem6VqPNAgkAoBmkJkm/Q
 EIJV/pW3zLdKwheaXcd/PKmPdOUJ7N0yLwLd+9YiHBF+pwi17+q1Th4aDri47BhoH/yW
 NopGGz+p0patIAv/oyaZ22Z9Mg5LkRGHAn6pQ84TIbmsHeH9Rlfnkrxk7kyLErioXkgq
 NoAA==
X-Gm-Message-State: AOJu0YzJAMd9GopKbGmjzG+bYXP9A9C4U2DWSnpNLhQ7LggfDxV3Fwdn
 s8oyXwdAwlwhqsneIqE8UTvT0+gmjek+qmpR4iFuZisTHphnRKMZKrs2cIds/V0E
X-Gm-Gg: AeBDies+E+BY/rpRrvDcj/hkWrQjTbNlDRhgcv0EIw1FGn1nqhNtSfiu0f+eAx4gJ4X
 mCPEn0iAB1aJE9rmUA5enTjGxbRjnpJpIJzgTKT3fJFY0SPggtz2K2BadaJQY/86ApIs8VB5O4D
 2dRoTxRriragcbpa8gYRRrWo29RA+RchsMayAYU7VI1AN70muvG1cE0XZ5Blw7tnk7swYSqsDNo
 Ei8puwW9VZwnKzQr4DvIlrUnLdBh9WmsSKoIkTBPiBA4r5kB25LXGrbWgN0xwTtQP0YPQf5yQOI
 z61xywF0l0wR0E2cJypCLB1DBXAjiBmbH5dAy72DN7cYPA589f+PFplwmPMX/MqEgJ0+f9G4eQs
 w84hdnx0Bw0llXSWwppbTYfzVdaiS8/tdD8w6qpylsWljdd3qiV01+Yq6tsc/xxNSefeo/8YT93
 e+oFUEApu8oAlA/npyn3IglVGPPwIWm3WWvu8qjyvd9Tw2Fv2K1lQCnyoueYFVcA==
X-Received: by 2002:a05:7301:6788:b0:2c0:cc90:a71 with SMTP id
 5a478bee46e88-2d5873b3c6amr536067eec.8.1775772397860; 
 Thu, 09 Apr 2026 15:06:37 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f4:c030:bb40:195d:78fd:ecba:d45])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2d561bde68bsm1534567eec.17.2026.04.09.15.06.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Apr 2026 15:06:37 -0700 (PDT)
From: Lucas Amaral <lucaaamaral@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org,
 mohamed@unpredictable.fr, alex.bennee@linaro.org,
 richard.henderson@linaro.org, Lucas Amaral <lucaaamaral@gmail.com>
Subject: [PATCH v6 4/6] target/arm/emulate: add load/store exclusive
Date: Thu,  9 Apr 2026 19:06:12 -0300
Message-ID: <20260409220614.65558-5-lucaaamaral@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260409220614.65558-1-lucaaamaral@gmail.com>
References: <20260409220614.65558-1-lucaaamaral@gmail.com>
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

Add emulation for load/store exclusive instructions (DDI 0487 C3.3.6).
Exclusive monitors have no meaning on emulated MMIO accesses, so STXR
always reports success (Rs=0) and LDXR does not set a monitor.

Instruction coverage:
  - STXR/STLXR: exclusive store, 8/16/32/64-bit
  - LDXR/LDAXR: exclusive load, 8/16/32/64-bit
  - STXP/STLXP: exclusive store pair, 32/64-bit
  - LDXP/LDAXP: exclusive load pair, 32/64-bit

STXP/LDXP use two explicit decode patterns (sz=2, sz=3) for the
32/64-bit size variants.

Signed-off-by: Lucas Amaral <lucaaamaral@gmail.com>
---
 target/arm/emulate/a64-ldst.decode | 22 ++++++++++
 target/arm/emulate/arm_emulate.c   | 70 ++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+)

diff --git a/target/arm/emulate/a64-ldst.decode b/target/arm/emulate/a64-ldst.decode
index f3de3f86..fadf6fd2 100644
--- a/target/arm/emulate/a64-ldst.decode
+++ b/target/arm/emulate/a64-ldst.decode
@@ -10,6 +10,9 @@
 # 'u' flag: 0 = 9-bit signed immediate (byte offset), 1 = 12-bit unsigned (needs << sz)
 &ldst_imm       rt rn imm sz sign w p unpriv ext u
 
+# Load/store exclusive
+&stxr           rn rt rt2 rs sz lasr
+
 # Load/store pair (GPR and SIMD/FP)
 &ldstpair       rt2 rt rn imm sz sign w p
 
@@ -18,6 +21,9 @@
 
 ### Format templates
 
+# Exclusives
+@stxr           sz:2 ...... ... rs:5 lasr:1 rt2:5 rn:5 rt:5   &stxr
+
 # Load/store immediate (9-bit signed)
 @ldst_imm       .. ... . .. .. . imm:s9 .. rn:5 rt:5   &ldst_imm u=0 unpriv=0 p=0 w=0
 @ldst_imm_pre   .. ... . .. .. . imm:s9 .. rn:5 rt:5   &ldst_imm u=0 unpriv=0 p=0 w=1
@@ -134,6 +140,22 @@ STR_v_i         00 111 1 01 10 ............ ..... .....         @ldst_uimm sign=
 LDR_v_i         sz:2 111 1 01 01 ............ ..... .....       @ldst_uimm sign=0 ext=0
 LDR_v_i         00 111 1 01 11 ............ ..... .....         @ldst_uimm sign=0 ext=0 sz=4
 
+### Load/store exclusive
+
+# STXR / STLXR  (sz encodes 8/16/32/64-bit)
+STXR            .. 001000 000 ..... . ..... ..... .....         @stxr
+
+# LDXR / LDAXR
+LDXR            .. 001000 010 ..... . ..... ..... .....         @stxr
+
+# STXP / STLXP  (bit[31]=1, bit[30]=sf → sz=2 for 32-bit, sz=3 for 64-bit)
+STXP            10 001000 001 rs:5 lasr:1 rt2:5 rn:5 rt:5      &stxr sz=2
+STXP            11 001000 001 rs:5 lasr:1 rt2:5 rn:5 rt:5      &stxr sz=3
+
+# LDXP / LDAXP
+LDXP            10 001000 011 rs:5 lasr:1 rt2:5 rn:5 rt:5      &stxr sz=2
+LDXP            11 001000 011 rs:5 lasr:1 rt2:5 rn:5 rt:5      &stxr sz=3
+
 ### Load/store pair — non-temporal (STNP/LDNP)
 
 # STNP/LDNP: offset only, no writeback.  Non-temporal hint ignored.
diff --git a/target/arm/emulate/arm_emulate.c b/target/arm/emulate/arm_emulate.c
index 2d86b90f..7f876355 100644
--- a/target/arm/emulate/arm_emulate.c
+++ b/target/arm/emulate/arm_emulate.c
@@ -477,6 +477,76 @@ static bool trans_LDR_v(DisasContext *ctx, arg_ldst *a)
     return true;
 }
 
+/*
+ * Load/store exclusive: STXR, LDXR, STXP, LDXP
+ * (DDI 0487 C3.3.6)
+ *
+ * Exclusive monitors have no meaning on MMIO.  STXR always reports
+ * success (Rs=0) and LDXR does not set an exclusive monitor.
+ */
+
+static bool trans_STXR(DisasContext *ctx, arg_stxr *a)
+{
+    int esize = 1 << a->sz;
+    uint64_t va = base_read(ctx, a->rn);
+    uint8_t buf[8];
+
+    mem_st(ctx, buf, esize, gpr_read(ctx, a->rt));
+    if (mem_write(ctx, va, buf, esize) != 0) {
+        return true;
+    }
+
+    /* Report success -- no exclusive monitor on emulated access */
+    gpr_write(ctx, a->rs, 0);
+    return true;
+}
+
+static bool trans_LDXR(DisasContext *ctx, arg_stxr *a)
+{
+    int esize = 1 << a->sz;
+    uint64_t va = base_read(ctx, a->rn);
+    uint8_t buf[8];
+
+    if (mem_read(ctx, va, buf, esize) != 0) {
+        return true;
+    }
+
+    gpr_write(ctx, a->rt, mem_ld(ctx, buf, esize));
+    return true;
+}
+
+static bool trans_STXP(DisasContext *ctx, arg_stxr *a)
+{
+    int esize = 1 << a->sz;                   /* sz=2->4, sz=3->8 */
+    uint64_t va = base_read(ctx, a->rn);
+    uint8_t buf[16];
+
+    mem_st(ctx, buf, esize, gpr_read(ctx, a->rt));
+    mem_st(ctx, buf + esize, esize, gpr_read(ctx, a->rt2));
+
+    if (mem_write(ctx, va, buf, 2 * esize) != 0) {
+        return true;
+    }
+
+    gpr_write(ctx, a->rs, 0);  /* success */
+    return true;
+}
+
+static bool trans_LDXP(DisasContext *ctx, arg_stxr *a)
+{
+    int esize = 1 << a->sz;
+    uint64_t va = base_read(ctx, a->rn);
+    uint8_t buf[16];
+
+    if (mem_read(ctx, va, buf, 2 * esize) != 0) {
+        return true;
+    }
+
+    gpr_write(ctx, a->rt, mem_ld(ctx, buf, esize));
+    gpr_write(ctx, a->rt2, mem_ld(ctx, buf + esize, esize));
+    return true;
+}
+
 /* PRFM, DC cache maintenance -- treated as NOP */
 static bool trans_NOP(DisasContext *ctx, arg_NOP *a)
 {
-- 
2.52.0


