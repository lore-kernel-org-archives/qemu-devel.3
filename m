Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49637CF9C64
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2024 12:08:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssLHp-00027X-KD; Sun, 22 Sep 2024 08:01:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ssLHP-0000x2-S5
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 08:01:37 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ssLHL-0002OQ-ES
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 08:01:30 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a8d2b4a5bf1so492585066b.2
 for <qemu-devel@nongnu.org>; Sun, 22 Sep 2024 05:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727006484; x=1727611284; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DUOSVdnU/ITJXIqpoZvSdwJoVXsC/VkcYgnTu23PytA=;
 b=snSbC7MCkQ1ctdY1CV3XaCjdPcF8G/RjzeaLox7pn+n9HSfzuJm1d2d8rX9SY+nxDf
 LlB5tZ4UcbaVEh85Prd+hP2R3Nh00/dd70lEWIpsyMX2nSR4B3OKMR2CL/sq+m9oBiul
 mHDv4YHhyPLVmv6TXbcxcqyugu35ynqt5ddTUbIpLqWKfHcY2oC+QqVXtWeq9aL7jsAs
 MMm/zCGf3k98++gtOUnhVWpDcKmojM6NhsEQTV1xWc75lpA8tG2wZzS5nDtHr4T69ODd
 lgs83F3ODgrCILxiRCNhq6JnyhBUG3zfA1DCX114gbhyiW34nBC0oIJa9R/w3JOOlw7O
 awuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727006484; x=1727611284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DUOSVdnU/ITJXIqpoZvSdwJoVXsC/VkcYgnTu23PytA=;
 b=QPwX27OoTQzzzTT31cEpWH0jIzmGXJNvg1ub/W/0ugfCglZETLLSprYabvmZzD8MLJ
 XvbPrAIpjlXpCkXYzmGvrxX1lxQ6Omw7tge1clrkUoqI5m/E7G5SS/T81RuVvmbOHjkR
 NrnqhCaJJRixLjRc6MV94tB6emf1n69D3LhV5S+dTakYCN0H/IHfNj47jAF3T3pRyxmI
 JW3un+zcO0Ml9i/ovVgtgq6gXeYXI3SXdMxxQfxgQ27seqc/CbAoOOGItzJ9K+z/iHY8
 NPAZPk/cZoWcFQFIXE/E236oRCzgkP711RkOPX3xwzxPCuUWyeA0qw/RuW0kNaMdL1PD
 ZV5Q==
X-Gm-Message-State: AOJu0Ywf7CDeEH7MNEX+CrDEB6UWD5p8+IWXuvOb8JcX8J0HCuZT87p0
 85/AHjCWb4pmOa7RKYfBy7r/wdynNHkXhLZNgWrreNjlQo353DsCwOmplCVeuU+MnKaqW5NN/Nw
 a0C0=
X-Google-Smtp-Source: AGHT+IEZC7aF4Abaw9QbDv+Rq0ygo9ktysNMzm1ti3/Rd9Hfs2BuUUdox8mB+9wtWZYLQbOERqo4Jw==
X-Received: by 2002:a17:907:1c0b:b0:a83:94bd:d913 with SMTP id
 a640c23a62f3a-a90d4fdea0bmr888466866b.10.1727006484545; 
 Sun, 22 Sep 2024 05:01:24 -0700 (PDT)
Received: from stoup.. (90-181-218-29.rco.o2.cz. [90.181.218.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612df525sm1067909966b.159.2024.09.22.05.01.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Sep 2024 05:01:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL 18/31] tcg/ppc: Implement cmpsel_vec
Date: Sun, 22 Sep 2024 14:00:59 +0200
Message-ID: <20240922120112.5067-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240922120112.5067-1-richard.henderson@linaro.org>
References: <20240922120112.5067-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x632.google.com
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

Do not allow cmpsel_vec to be expanded early, so that we can
make the correct decision wrt the sense of the comparison.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target-con-set.h |  1 +
 tcg/ppc/tcg-target.h         |  2 +-
 tcg/ppc/tcg-target.c.inc     | 60 +++++++++++++++++++++++++++++++-----
 3 files changed, 54 insertions(+), 9 deletions(-)

diff --git a/tcg/ppc/tcg-target-con-set.h b/tcg/ppc/tcg-target-con-set.h
index 9f99bde505..e7ba00c248 100644
--- a/tcg/ppc/tcg-target-con-set.h
+++ b/tcg/ppc/tcg-target-con-set.h
@@ -33,6 +33,7 @@ C_O1_I2(r, r, rU)
 C_O1_I2(r, r, rZW)
 C_O1_I2(v, v, v)
 C_O1_I3(v, v, v, v)
+C_O1_I4(v, v, v, v, v)
 C_O1_I4(r, r, rC, rZ, rZ)
 C_O1_I4(r, r, r, ri, ri)
 C_O2_I1(r, r, r)
diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index e154fb14df..0b2171d38c 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -172,7 +172,7 @@ typedef enum {
 #define TCG_TARGET_HAS_sat_vec          1
 #define TCG_TARGET_HAS_minmax_vec       1
 #define TCG_TARGET_HAS_bitsel_vec       have_vsx
-#define TCG_TARGET_HAS_cmpsel_vec       0
+#define TCG_TARGET_HAS_cmpsel_vec       1
 #define TCG_TARGET_HAS_tst_vec          0
 
 #define TCG_TARGET_DEFAULT_MO (0)
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 497e130581..9d07b4d8e6 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3573,6 +3573,7 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_rotli_vec:
         return vece <= MO_32 || have_isa_2_07 ? -1 : 0;
     case INDEX_op_cmp_vec:
+    case INDEX_op_cmpsel_vec:
         return vece <= MO_32 || have_isa_2_07 ? 1 : 0;
     case INDEX_op_neg_vec:
         return vece >= MO_32 && have_isa_3_00;
@@ -3719,6 +3720,33 @@ static void tcg_out_not_vec(TCGContext *s, TCGReg a0, TCGReg a1)
     tcg_out32(s, VNOR | VRT(a0) | VRA(a1) | VRB(a1));
 }
 
+static void tcg_out_or_vec(TCGContext *s, TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out32(s, VOR | VRT(a0) | VRA(a1) | VRB(a2));
+}
+
+static void tcg_out_and_vec(TCGContext *s, TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out32(s, VAND | VRT(a0) | VRA(a1) | VRB(a2));
+}
+
+static void tcg_out_andc_vec(TCGContext *s, TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out32(s, VANDC | VRT(a0) | VRA(a1) | VRB(a2));
+}
+
+static void tcg_out_bitsel_vec(TCGContext *s, TCGReg d,
+                               TCGReg c, TCGReg t, TCGReg f)
+{
+    if (TCG_TARGET_HAS_bitsel_vec) {
+        tcg_out32(s, XXSEL | VRT(d) | VRC(c) | VRB(t) | VRA(f));
+    } else {
+        tcg_out_and_vec(s, TCG_VEC_TMP2, t, c);
+        tcg_out_andc_vec(s, d, f, c);
+        tcg_out_or_vec(s, d, d, TCG_VEC_TMP2);
+    }
+}
+
 static bool tcg_out_cmp_vec_noinv(TCGContext *s, unsigned vece, TCGReg a0,
                                   TCGReg a1, TCGReg a2, TCGCond cond)
 {
@@ -3798,6 +3826,18 @@ static void tcg_out_cmp_vec(TCGContext *s, unsigned vece, TCGReg a0,
     }
 }
 
+static void tcg_out_cmpsel_vec(TCGContext *s, unsigned vece, TCGReg a0,
+                               TCGReg c1, TCGReg c2, TCGReg v3, TCGReg v4,
+                               TCGCond cond)
+{
+    if (tcg_out_cmp_vec_noinv(s, vece, TCG_VEC_TMP1, c1, c2, cond)) {
+        TCGReg swap = v3;
+        v3 = v4;
+        v4 = swap;
+    }
+    tcg_out_bitsel_vec(s, a0, TCG_VEC_TMP1, v3, v4);
+}
+
 static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
                            unsigned vecl, unsigned vece,
                            const TCGArg args[TCG_MAX_OP_ARGS],
@@ -3889,17 +3929,17 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         insn = sarv_op[vece];
         break;
     case INDEX_op_and_vec:
-        insn = VAND;
-        break;
+        tcg_out_and_vec(s, a0, a1, a2);
+        return;
     case INDEX_op_or_vec:
-        insn = VOR;
-        break;
+        tcg_out_or_vec(s, a0, a1, a2);
+        return;
     case INDEX_op_xor_vec:
         insn = VXOR;
         break;
     case INDEX_op_andc_vec:
-        insn = VANDC;
-        break;
+        tcg_out_andc_vec(s, a0, a1, a2);
+        return;
     case INDEX_op_not_vec:
         tcg_out_not_vec(s, a0, a1);
         return;
@@ -3919,9 +3959,11 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_cmp_vec:
         tcg_out_cmp_vec(s, vece, a0, a1, a2, args[3]);
         return;
-
+    case INDEX_op_cmpsel_vec:
+        tcg_out_cmpsel_vec(s, vece, a0, a1, a2, args[3], args[4], args[5]);
+        return;
     case INDEX_op_bitsel_vec:
-        tcg_out32(s, XXSEL | VRT(a0) | VRC(a1) | VRB(a2) | VRA(args[3]));
+        tcg_out_bitsel_vec(s, a0, a1, a2, args[3]);
         return;
 
     case INDEX_op_dup2_vec:
@@ -4287,6 +4329,8 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_bitsel_vec:
     case INDEX_op_ppc_msum_vec:
         return C_O1_I3(v, v, v, v);
+    case INDEX_op_cmpsel_vec:
+        return C_O1_I4(v, v, v, v, v);
 
     default:
         g_assert_not_reached();
-- 
2.43.0


