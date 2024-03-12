Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D76C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 14:44:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk3I1-0003ea-3u; Tue, 12 Mar 2024 10:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk3He-0003YL-G4
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:39:15 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk3HS-0007ky-5P
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:39:14 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6e6afd8da93so313825b3a.3
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 07:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710254340; x=1710859140; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mWv/lYl0jTYk+QCDeO6yVFPWdK9NhQ8DhGo71nIOR9Q=;
 b=SKXP0RjEW3X6J8L8iBO9cvi0aAzb8sf7CTwQGud6W/cALW30dLTaFV/g3Rf4+CoBu7
 Ij6h3ARH21SOvxVBbWZEWDa6WAFgrFC2bDWomysK8OSXTw6mqqGFjYrkI0gkM2MyryEs
 QgS0bMKmcrYhmHI/PymbqBAHCaWi7BB78hmPoUeOpJQJkBgyvxXMIuVqbM5NEvCieYZj
 YwG/cgY9GG27K3KK2/FNYqzzrbo3BE/ToChP0mUCuC1U90RXpKq8DCEjjTubn4+pfRVN
 hO/FKAAkcMoTwn3HhzOSJ0V1xl0yyabTtj59P0fS3Pxz1Np6/HbgZeJ0CO3NAsAOufHR
 KD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710254340; x=1710859140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mWv/lYl0jTYk+QCDeO6yVFPWdK9NhQ8DhGo71nIOR9Q=;
 b=pz4uba6dG/CVntpaOKIlcrRCbiz4rQ4HDOVh6Ayl87cx7fIACFFfoXrI11awcon+Z9
 6nD0DHgC7lSMp8oSr2l8wq+y5IwSAn22Vr4jPCd9nZeuOwqW/JuJDh5C1upWqWg0n4OP
 YvLiveLvsLXXB7bnvjMyfZ4eqwAnKjibIlfZ/mdBh+MLxT0coBpw4f7R25wnNhKdJhxb
 TldErNs9Ahfy1ehwb6lo37rGowBlhjiwdjfd5eFEz89+0qSjsLpP4iq+H0BKi+Q9Lp73
 gmv0LHUpMxq09K4NvACP2s7/cBtr/2S9zN4NXvf57q8LBF5mDOnp22GxB1UzrutKNRAw
 H1BQ==
X-Gm-Message-State: AOJu0YyjwS4d+icwtKZsYZDFdBMrafW82nSs0S4DQlq2GxxgP1sE0nd7
 PDGoC7TWvtzLitZmqKgCHapAyYskd5S2neRe2F8+16LU3hMpYocGmNGiKyaDEwYtUmqHCo8P24s
 v
X-Google-Smtp-Source: AGHT+IG5Kh/wMHgAgjwIxFniYarzVPsqIYLlp94Zuou/gew7RNdw9xj+8oDcnjcqXIvz4CAZFZVapA==
X-Received: by 2002:a05:6a20:840f:b0:1a1:4757:927e with SMTP id
 c15-20020a056a20840f00b001a14757927emr8384179pzd.33.1710254339917; 
 Tue, 12 Mar 2024 07:38:59 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 jx15-20020a17090b46cf00b0029baa0b1a6csm7492214pjb.24.2024.03.12.07.38.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 07:38:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/15] tcg/riscv: Do not accept zero operands for logicals,
 multiply or divide
Date: Tue, 12 Mar 2024 04:38:36 -1000
Message-Id: <20240312143839.136408-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312143839.136408-1-richard.henderson@linaro.org>
References: <20240312143839.136408-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Trust that the optimizer has folded all of these away.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target-con-set.h | 1 -
 tcg/riscv/tcg-target.c.inc     | 4 +---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/tcg/riscv/tcg-target-con-set.h b/tcg/riscv/tcg-target-con-set.h
index 13a383aeb1..527d2fd4d9 100644
--- a/tcg/riscv/tcg-target-con-set.h
+++ b/tcg/riscv/tcg-target-con-set.h
@@ -16,7 +16,6 @@ C_O1_I1(r, r)
 C_O1_I2(r, r, r)
 C_O1_I2(r, r, ri)
 C_O1_I2(r, r, rI)
-C_O1_I2(r, rZ, rZ)
 C_N1_I2(r, r, rM)
 C_O1_I4(r, r, rI, rM, rM)
 C_O2_I4(r, r, rZ, rZ, rM, rM)
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 6b28f2f85d..0dc1b2d8f7 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -1929,8 +1929,6 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
 
     case INDEX_op_sub_i32:
     case INDEX_op_sub_i64:
-        return C_O1_I2(r, r, r);
-
     case INDEX_op_andc_i32:
     case INDEX_op_andc_i64:
     case INDEX_op_orc_i32:
@@ -1951,7 +1949,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_divu_i64:
     case INDEX_op_rem_i64:
     case INDEX_op_remu_i64:
-        return C_O1_I2(r, rZ, rZ);
+        return C_O1_I2(r, r, r);
 
     case INDEX_op_shl_i32:
     case INDEX_op_shr_i32:
-- 
2.34.1


