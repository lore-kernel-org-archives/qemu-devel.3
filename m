Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31640FED9EF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 17:50:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2YWv-0003Qj-Pr; Tue, 17 Mar 2026 13:48:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w2YWj-0003OI-RJ
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 13:48:26 -0400
Received: from mail-dl1-x122e.google.com ([2607:f8b0:4864:20::122e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w2YWg-00070L-6i
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 13:48:20 -0400
Received: by mail-dl1-x122e.google.com with SMTP id
 a92af1059eb24-128ebee22caso3924492c88.0
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 10:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773769692; x=1774374492; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iqLIpVr4djLYDOqzYTbrP//evleS3LXj53m2D/JbGEc=;
 b=i36YEYmBseg2VWEpegZE40L8Ra4cxlyf/VZX3soMx5EO0bcHmo+A6YgCsbhm6xmMux
 OcRjfIvqDPyX+SFWTKhLiL7CEs3NbL/5URhhqKZ1jXYx8NhAQ80mcgul/JSDoJn6vmeG
 o1979NZZd0JpPrcJqFrTuuRH8xSN0Nqr3NFgFoqMKLmQrDjmEPWZrMGkv8pFY5yc5hGl
 s05e1qIcvVVn73zhTiYZB9FDeGEpI2Ih3JsSe+6/eLikEKOEQsZ1G+Bhk8blZ7EBm9sq
 OAPSqsSw2QXyaRIZIzWAoi4rqSQENt+3H+vi8AxdfI9udYEUpNw3cvNnb3UkLSEimVvB
 /+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773769692; x=1774374492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iqLIpVr4djLYDOqzYTbrP//evleS3LXj53m2D/JbGEc=;
 b=Bq2CniZyQsPYtbMJtyEHin28gEGR1jeBzSBQ2BCPAEXB1jkR81Ue4TjX6eKPqanwPx
 2htAiX12uvpwNwnSSlArHZEv5VrNtHINyuv9Oqc+VxFA1uABxmMwSrcaO+WVRxhbB1OL
 cacVXUz4yHpuHKfj/WNMFw4uBw8FkYCJEaaX6CBHW7nHr/LusZH2Flda+agMOOoI53Nk
 dFpeguE0D7ZL4iUFTPzYULeWEnmg+OeAHB+PCZvbABBHgjwD1NUa5LXDPsUW85lahlq8
 nc1zcWLzOmATlfmRZYh0l5DTSy+N0O4M0sXU7kpfVSc/YJMfAKoZkDYPa0/n1sC23Dpt
 sLfQ==
X-Gm-Message-State: AOJu0Ywy6tazuEC9fZ6C4UUiVbVwwKfm+ExNpiBM9P2pulRKLqQc9Hze
 otkjE6cFXgyvBQhSMaByCruzmzjF4SmQ98X7fNYt2MWH4TX3lF1BWcQyGyzPnwnH
X-Gm-Gg: ATEYQzyETHHX6awbVnttFWxTxfzwX6mPlDJMGdho06DmAbrSLzLji62M58cfbIhgusw
 v6Iy0mFqEoacl5AuWbKzCKfm9czCVOmMDBWwIzR/bkBmmUferuujfpT+j0FprarqiVz6nGr65IJ
 /WwrMerjjLZGGg1CV0JZKEGLPcmcfCLGy12U+IxRqkm/rOMopxM0j2xt2AxYHhvIb3sM3RKVUl3
 o05PmqXsstyIMNfZKl0z9D7rtINAB0JB5CjnJJBj/hLUwIeBTv4L3/gvG+vipKddPaJ1+/MV9+3
 G3Q6lCmzEWHQtxdnqP8pHfi8KU/NhYxowbtGRKk+wrmc4TJc9hrM2rwHW7+UwaZXI/7joSyGF36
 eOKewiiIqhRLb2kWLZDjGu/IWypI6lHVPbZPej3xdbNH18sMa+H10NYSMxc5S5LEqFOr2JxT9Nj
 heKBsnRNhczDBav5VPoOiinyRgErax8uYC2wYHBLr6bOiHj6CqkQOK
X-Received: by 2002:a05:7022:6720:b0:128:d5f1:d594 with SMTP id
 a92af1059eb24-129a70dfcb2mr214386c88.10.1773769692327; 
 Tue, 17 Mar 2026 10:48:12 -0700 (PDT)
Received: from localhost.localdomain ([143.54.78.51])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-129b4147522sm281844c88.15.2026.03.17.10.48.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 17 Mar 2026 10:48:12 -0700 (PDT)
From: Lucas Amaral <lucaaamaral@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org,
 mohamed@unpredictable.fr, alex.bennee@linaro.org,
 Lucas Amaral <lucaaamaral@gmail.com>
Subject: [PATCH v5 4/6] target/arm/emulate: add load/store exclusive
Date: Tue, 17 Mar 2026 14:47:38 -0300
Message-ID: <20260317174740.31674-5-lucaaamaral@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260317174740.31674-1-lucaaamaral@gmail.com>
References: <20260317174740.31674-1-lucaaamaral@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122e;
 envelope-from=lucaaamaral@gmail.com; helo=mail-dl1-x122e.google.com
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
 target/arm/emulate/a64-ldst.decode | 22 +++++++++
 target/arm/emulate/arm_emulate.c   | 74 ++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+)

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
index 6c63a0d0..52e41703 100644
--- a/target/arm/emulate/arm_emulate.c
+++ b/target/arm/emulate/arm_emulate.c
@@ -425,6 +425,80 @@ static bool trans_LDR_v(DisasContext *ctx, arg_ldst *a)
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
+    uint64_t val = gpr_read(ctx, a->rt);
+
+    if (mem_write(ctx, va, &val, esize) != 0) {
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
+    uint64_t val = 0;
+
+    if (mem_read(ctx, va, &val, esize) != 0) {
+        return true;
+    }
+
+    gpr_write(ctx, a->rt, val);
+    return true;
+}
+
+static bool trans_STXP(DisasContext *ctx, arg_stxr *a)
+{
+    int esize = 1 << a->sz;                   /* sz=2->4, sz=3->8 */
+    uint64_t va = base_read(ctx, a->rn);
+    uint8_t buf[16];
+
+    uint64_t v1 = gpr_read(ctx, a->rt);
+    uint64_t v2 = gpr_read(ctx, a->rt2);
+    memcpy(buf, &v1, esize);
+    memcpy(buf + esize, &v2, esize);
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
+    uint64_t v1 = 0, v2 = 0;
+
+    if (mem_read(ctx, va, buf, 2 * esize) != 0) {
+        return true;
+    }
+
+    memcpy(&v1, buf, esize);
+    memcpy(&v2, buf + esize, esize);
+    gpr_write(ctx, a->rt, v1);
+    gpr_write(ctx, a->rt2, v2);
+    return true;
+}
+
 /* PRFM, DC cache maintenance -- treated as NOP */
 static bool trans_NOP(DisasContext *ctx, arg_NOP *a)
 {
-- 
2.52.0


