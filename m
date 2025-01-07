Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D62C8E77198
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:09:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4Xj-0001Ll-Ox; Tue, 07 Jan 2025 03:02:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4X6-0000KR-2N
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:49 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4X2-0002yL-9y
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:45 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2164b662090so194871245ad.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736236902; x=1736841702; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RqajPiEMeewZ/ExVhfmIDevyFwt0jBlpqC4kux+VJ8g=;
 b=vsh8ZLggchr/g1nBGZSmiGu6iVaKqQV2AGMpTccG5bdgajlz4UjLskAsZ3pbCN4EDh
 kO4eiHjiWC9xkib90U2czaP9go4xgMax1nbbdnMZ3Xc5LiCw8LGLWv2osaEqlib3emhA
 1HXD2oB1/v1WoP/p9W0wqjECRscBBDfTz2ZG/SaTyZiWK1Mys2GLOgsp3u0eYzVj5IW+
 QbAbT6hzXttsj7wdGClvDYs9PyKN5sVbROibZpppn1AW14EH/CXf8szr2ae/EzjVLZnQ
 JP+8/yeiwpSP2ORfn6eaY6yM94M006eRmwGb5sOAq4D2RAE/uUf9AkHTUhNkV9pn35mc
 gMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736236902; x=1736841702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RqajPiEMeewZ/ExVhfmIDevyFwt0jBlpqC4kux+VJ8g=;
 b=AaD7t4wQa2s74SDKscW7MnXeON+sewsdPFgInwUVShe6PmTz4eNL9JCO3Rd/iIw6Qf
 JQUwbp9ShZIqBb7n3aVGCqNVhkk3H0K5xiBZcMtbv6xXKFbuLm90IrDKygXzKeoZl8OS
 GDc1k5Fx614KRx+mMG0fFNBLidY4Ic0n3aSoUKQ5Gf2gK8XN7f2aiL8tb83ryL6303ss
 hrR5ihx2AgWCjPhQbdd203A+qMATtyOQ12wOO5RCEUQir6wcbcjk26fio/VdU8O/IS81
 mHCZq2n7s651K9CeS8hkMinfi+NvPj/5mVcXQoXpfrslAadIfzHWkRwV11Iiw8xZrBE2
 16UQ==
X-Gm-Message-State: AOJu0Yz9adlQxdFf0ADEnBLb7C9yzGgk7mrSjqFB9V9jBb7hqbZ5HjlN
 kzNlIoxK1a2RnsYv7S03CPzSbQFv3LhImEXYUbWf4NIsWjc6lOP5ypWlKdoUrKJ6qEuzmZn/P7F
 L
X-Gm-Gg: ASbGnctSSvCmcH+a6gdoS1X1CqpOoMtvo9eII77Fgp7m4TCi2kVO2YqFFnJlULq2uPL
 CdyTHKDLFVpxG2JM1exv1K5Z/LnQTbSmSpXcKamqJKAHfV3mmsDwzhvt1qZ+bbHlGngO9aKk8Bf
 aTGfHnwAXlw704iXImce/u+Etbk3U/lPaiU3GR0ULmpDMh5t+EmEx6YZukmljZZRAFq7w91JDBE
 noTu8ZnXCumwLIdc4I2eai8NGAnrFtXUn9+3Kt3v6BcDT1G4wXZZDj6fxK+HuP82adfBtLNPSGA
 W7kjt9b+ZaWxZeAizQ==
X-Google-Smtp-Source: AGHT+IF3cpB7jLw6q2LksJnUvVX1iz65CFOf/0Sf+BnfnN6BNsFwLxJess8C0+PRKPfo0tt+GQV6fA==
X-Received: by 2002:a17:903:24e:b0:216:7761:cc49 with SMTP id
 d9443c01a7336-219e6f26251mr892534115ad.47.1736236902482; 
 Tue, 07 Jan 2025 00:01:42 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc96eb12sm306765995ad.87.2025.01.07.00.01.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:01:42 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 27/81] tcg: Pass type and flags to tcg_target_op_def
Date: Tue,  7 Jan 2025 00:00:18 -0800
Message-ID: <20250107080112.1175095-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Allow the backend to make constraint choices based on more parameters.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c                        | 4 ++--
 tcg/aarch64/tcg-target.c.inc     | 3 ++-
 tcg/arm/tcg-target.c.inc         | 3 ++-
 tcg/i386/tcg-target.c.inc        | 3 ++-
 tcg/loongarch64/tcg-target.c.inc | 3 ++-
 tcg/mips/tcg-target.c.inc        | 3 ++-
 tcg/ppc/tcg-target.c.inc         | 3 ++-
 tcg/riscv/tcg-target.c.inc       | 3 ++-
 tcg/s390x/tcg-target.c.inc       | 3 ++-
 tcg/sparc64/tcg-target.c.inc     | 3 ++-
 tcg/tci/tcg-target.c.inc         | 3 ++-
 11 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index cf6d881945..b971909c3f 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -866,7 +866,7 @@ typedef enum {
 #include "tcg-target-con-set.h"
 } TCGConstraintSetIndex;
 
-static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode);
+static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode, TCGType, unsigned);
 
 #undef C_O0_I1
 #undef C_O0_I2
@@ -3375,7 +3375,7 @@ static const TCGArgConstraint *opcode_args_ct(const TCGOp *op)
         return empty_cts;
     }
 
-    con_set = tcg_target_op_def(op->opc);
+    con_set = tcg_target_op_def(op->opc, TCGOP_TYPE(op), TCGOP_FLAGS(op));
     tcg_debug_assert(con_set >= 0 && con_set < ARRAY_SIZE(constraint_sets));
 
     /* The constraint arguments must match TCGOpcode arguments. */
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index d1e08def60..9116f85667 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2962,7 +2962,8 @@ void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
     }
 }
 
-static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
+static TCGConstraintSetIndex
+tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
     case INDEX_op_goto_ptr:
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index b4cd36a9b8..182cac1a8a 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -2124,7 +2124,8 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
     }
 }
 
-static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
+static TCGConstraintSetIndex
+tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
     case INDEX_op_goto_ptr:
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 813c12ca0e..64826c7419 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -3627,7 +3627,8 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     }
 }
 
-static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
+static TCGConstraintSetIndex
+tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
     case INDEX_op_goto_ptr:
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 686b94ccda..2f0d4d01ff 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -2191,7 +2191,8 @@ void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
     g_assert_not_reached();
 }
 
-static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
+static TCGConstraintSetIndex
+tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
     case INDEX_op_goto_ptr:
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 199bd97c0e..b89b279a0e 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -2151,7 +2151,8 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
     }
 }
 
-static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
+static TCGConstraintSetIndex
+tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
     case INDEX_op_goto_ptr:
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 3ce4fa1db6..1e7b8a204c 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -4140,7 +4140,8 @@ void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
     va_end(va);
 }
 
-static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
+static TCGConstraintSetIndex
+tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
     case INDEX_op_goto_ptr:
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 51cd7e7586..432a2fe26f 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2583,7 +2583,8 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     }
 }
 
-static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
+static TCGConstraintSetIndex
+tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
     case INDEX_op_goto_ptr:
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 98925b1d5d..e09a726ecf 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -3207,7 +3207,8 @@ void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
     va_end(va);
 }
 
-static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
+static TCGConstraintSetIndex
+tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
     case INDEX_op_goto_ptr:
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 1201607722..48de490120 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1532,7 +1532,8 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
     }
 }
 
-static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
+static TCGConstraintSetIndex
+tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
     case INDEX_op_goto_ptr:
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 74b649c902..662acbdcb6 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -36,7 +36,8 @@
 #endif
 #define TCG_TARGET_CALL_RET_I128        TCG_CALL_RET_NORMAL
 
-static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
+static TCGConstraintSetIndex
+tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
     case INDEX_op_goto_ptr:
-- 
2.43.0


