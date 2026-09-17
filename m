Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C29FAC982D2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 08:19:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x77JW-0002ic-KQ; Thu, 17 Sep 2026 04:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x77JM-0002gt-GO
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 04:17:40 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x77JI-0001wD-KD
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 04:17:38 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-39647aa9d52so473218a91.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 01:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789633055; x=1790237855; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1reDOt4Ue25bUW6XWAKTeS4BRx5x9LuLs9+NuAuYaAM=;
 b=yHzyE62N9c17jsEwJIn9G8+TAuk5kMIfNtBZTcgQoJgDvhdWOwtJzr54zbovtoeCJc
 dhdeeD/bMWkZg1mXm28OvK4TB4W42zAzhpdmYYztmMcJPouUDTyBsJXHHuxsunvN3lHi
 Kb4TScjFqc/+sKErX4congvuK0lUSKNOII+fOxnKPBtpE+cV3zSJZSMoRAvg6x0wmlOx
 oYw5aiQPeIziVIwMYkmuVAqAqpt5w1DPRLZcP9fP/mlKpq15CoFgdF78++tuGibn1pu2
 aiAVHh/MaFrCZ0tABKxJaJ1FoQyok4yVz/2vfmg+TgZu0oIi/ivtEbQFbldiQrshuEd9
 o3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789633055; x=1790237855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1reDOt4Ue25bUW6XWAKTeS4BRx5x9LuLs9+NuAuYaAM=;
 b=sOd73/ZWLoiSLwGPkIrQuipMh+0TxtFQDvWLVt3Rqe4QN4MQ2gbqTBCyh4wRKvpPdw
 gfkyFhS+OREswbzlIjlxPt0LgQQxRsWtS2qdWtWozA6rkIEBnN1vO40F68C7lAfM+mXy
 lhMKCN3Pkuv5UU3GMX5OFBXcnf//CZ6aHE1+KZ9J+J+iu3ocB+itXZUS1srJzBLx1gCx
 ScOIJVptLwe/e/fLQdUow9oxdfCzUm/QUR/hrFibmTKXu/C51MBUB1tnMg4svVDjm0rv
 yRCQBo1plYnOfANrwtG840UNo4lrbslgyLb6WsWNdc7Rj4oVxypbeFX3aTva2OGd/1YE
 Ph3Q==
X-Gm-Message-State: AFuF++lUSxiDGycEtsjM5a81bizK46fKhxQA0UHa+p3DrX7YvTcivisg
 nMx7wwjaNs5M3bqFHH8crWA3Xpi/I0KXM2yov4dEZafJ/UTwyrt3KDoqC4runSeRoXtYRMPjjuy
 Xuyv20rc=
X-Gm-Gg: AYBFou2uu5tA1WoaqjNGmkBnAHIfhtokcgCtziFdYQCURgrRGC+IELbMZoH57Khy69h
 1ljaVSYRKmgKC9OrmzZuX+80X3m9cd9stmvpvviPaZ6CJCBFQAM8zVkG8qr0D7lD3Kothr2L/a+
 uhrMocwJxCPuk4/QsfXZEnqWjfsE7mYykmUMP+KnVBP3BNMlgnncE8EMh+LDMmf3SVT1/TmF8ew
 KbPIthASOwYoy6L6dg0vXTqRPKrRe3PtUWqEV6e7GBZvsMrFIED8Om2lfQWgg63CruTexPKqjCp
 UBdbkn3uXPMeR1wBem5VYheFBEwqebdn0lagKZFPohk59rSvvopQg8+o2xDa6BqQeR92SXdD9ly
 Qy14iNqWwAsqqw655amtzRFy1T6pCJrh5Rb+u7ZFT+6GhwnfSVz+gJxljvHp1hQdAc7uVQN1WpG
 8u6pg3H/5F36t2sNTFB0BcJGNnd7T5nTEqBHWwReAs7gfqIBg8t7JfN7QUV+0nRJB7Ag/iuAn+s
 YPKdKI=
X-Received: by 2002:a17:90b:384f:b0:39e:455f:36fc with SMTP id
 98e67ed59e1d1-39e455f3d97mr443157a91.28.1789633054527; 
 Thu, 17 Sep 2026 01:17:34 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c1943f4bcsm127638eec.21.2026.09.17.01.17.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 01:17:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PATCH v2 14/16] tcg/aarch64: Implement INDEX_op_lea
Date: Wed, 16 Sep 2026 22:17:14 -1000
Message-ID: <20260917081716.946668-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917081716.946668-1-richard.henderson@linaro.org>
References: <20260917081716.946668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

Reviewed-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target-has.h | 4 ++--
 tcg/aarch64/tcg-target.c.inc | 9 ++++++++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/tcg/aarch64/tcg-target-has.h b/tcg/aarch64/tcg-target-has.h
index 86672b2eab4..9420a7bc73c 100644
--- a/tcg/aarch64/tcg-target-has.h
+++ b/tcg/aarch64/tcg-target-has.h
@@ -57,7 +57,7 @@
 #define TCG_TARGET_sextract_valid(type, ofs, len)  1
 #define TCG_TARGET_deposit_valid(type, ofs, len)   1
 
-#define TCG_TARGET_lea_sh_valid(type, sh)          0
-#define TCG_TARGET_lea_imm_valid(type, imm)        0
+#define TCG_TARGET_lea_sh_valid(type, sh)      ((sh) < tcg_type_size(type) * 8)
+#define TCG_TARGET_lea_imm_valid(type, imm)    ((imm) == 0)
 
 #endif
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 76adb2256f9..6836c0dd94f 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -3081,8 +3081,15 @@ static const TCGOutOpStore outop_st = {
     .out_r = tcg_out_st,
 };
 
+static void tgen_lea(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
+                     TCGReg a2, unsigned sh, tcg_target_long imm)
+{
+    tcg_out_insn(s, addsub_realshift, ADD_LSL, type, a0, a1, a2, sh);
+}
+
 static const TCGOutOpLea outop_lea = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out = tgen_lea,
 };
 
 static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
-- 
2.53.0


