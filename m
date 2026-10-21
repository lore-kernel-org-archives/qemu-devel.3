Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58062606A31D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Y9p5qXt+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXIN-0008M7-To; Wed, 21 Oct 2026 10:28:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXGe-0006QF-8j
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:26:12 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXGc-0002YF-I4
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:26:12 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a1dfd49525so6402265e9.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592769; x=1793197569; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=utCWtGaCa7Crb+3fJqlq30doC39JECSlDJLqs2Ua9z0=;
 b=Y9p5qXt+MqY1slQJNGK+pQF7vqcbcbFCKyYYCDxWjK1DkHjHxnjt10GC0VVVesXJoc
 j6Yxt+lotgIWzJPjeu9A8eOKP6RB4CgYTPFM48wuaDZ/9AQMRXSutASULYChhkcwe50e
 8DNHKAy0/D2Hq8UBwhHFfX5CPehTU6VFPvbQ61B2E+wWu5bl0jX/k3N7I5ZYjDY0B6RF
 jNlcS2byMdZI/umzPmQoTKrCnBq27GypvcyDrnxBRHuPlIRg8fTpdh//ilSJHCWGZ5NT
 Lbji+4DZ4IA2zqeuj2Clfv5wtRzbLRA7HRlft8oEJLRxmEty/1OV2Hk0+K9Zzl5f19wV
 597w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592769; x=1793197569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=utCWtGaCa7Crb+3fJqlq30doC39JECSlDJLqs2Ua9z0=;
 b=ig/qbRzDTZ6e1K3DB94hEriVuoVA4Zjwdx01gEo3ImuoVlX2RIlgzXG3ctPDQKSuZ3
 /Zpo3BJ3EBRESlbMPC0WlJG6SKRz86IWAyHViG8JS++RLq8rM85t60809oRCt2ckQQKz
 vIDnQC75Mpy5Tuo9u7ohqQOK5m7PmeALiTx7Gj8jEipqxUqSsaacnN0mt0zVmGZgBiO/
 1DVJS+Eyx82yvOj1+CmEV1WR+eqBrKpELg3voRgGlG9bRwnCH0PwwJ8MSrBjXgA1QBid
 RmwuJx7hYbjjSmIOyTJz5hpnJ0LbyoKxvKyWxJNaif+3mU1PwoNlDsnttLNhhMk2dA/s
 RsvA==
X-Gm-Message-State: AFq9FYKdbXhne9xLuBElMNpaKq3DVNAMku991GoZPfJ55d8bus9SUid7
 JmEpmFdCk9zdWt1oEihhcUNuD2vYw1RykXp0BRZntMZlJregdtDekVDcb7PtmX02YKRcWZDVz62
 wjkwAMrg=
X-Gm-Gg: AYBFou0/V1t3pHDV2uqRB4RmcswdbFkuu2ixxHWLNaPctNnCGVQZc6IVzH5YXiOXAkj
 8gnukomYDjP52wxzTXvFKbO4KJRrHizw8/JyeX5DO1C7KPYE3ZGl6LLwwtyEKXOcbOVHb1O4ath
 WThPk9U9pqAPivcygGZaxYzml/gCgUHNS4Ds6NcPCZZmG3tLgSkbOhxv8vw5DNir4Xxlm0obKCN
 8GuEbs7WW6ZdGCyaDr3Pvm/+1ZOFqjm6LzKInQm6wQvRxBAy7nXbYWGGiFh4fkO5JUvVIgj8e1I
 beNNge0/zGgKB7TnJuX6wOQKjJ5MBe+3UDCozyxhixGYZB9DWEVBrMt/fJ7YHxSFYA5+KY1+NU1
 1f3lQjBo9Bt8U4UDCRGenhaZfZp3sxdxF7HB6p4ow7YZMSGbEnJGe0/cYASj561SwtSlnWkG8gG
 Ds8NRkSe9WfXlFpw+RjIhzrRyUXgf0ReuZxQDFAFCbJePrYgEme2Kck8yEzXMdK3TildheDGXDY
 TA6pcY3MddSyJRUoVz7XLx0u/QwL8NQM7GzA6gyFSC2u1SS80Q1uFKVCXBehzbAsH4Jfqa3f2dD
 Q5bZdJgGe+WRWx5EQq0yb3rxc2M=
X-Received: by 2002:a05:600c:3f0c:b0:49f:c199:e1e2 with SMTP id
 5b1f17b1804b1-4a1fdd39fbamr47350645e9.28.1792592769005; 
 Wed, 21 Oct 2026 07:26:09 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828cd1sm5710878f8f.22.2026.10.21.07.26.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:26:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 088/100] tcg: Generic expansion of tcg_gen_ld8s_*
Date: Wed, 21 Oct 2026 16:16:40 +0200
Message-ID: <20261021141652.363109-89-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32a.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 16 ++++++----------
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 697de0e1f0..32128ad997 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -141,7 +141,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_dup_i32(unsigned vece, TCGv_i32 out, TCGv_i32 in);
 
 void tcg_gen_ld8u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_ld8s_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16s_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
 
@@ -170,7 +169,6 @@ void tcg_gen_st16_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 void tcg_gen_ld8u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_ld8s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 6284358a13..a110e64510 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -32,6 +32,7 @@ DEF4(extract, TCGV, TCGV, unsigned, unsigned)
 DEF4(extract2, TCGV, TCGV, TCGV, unsigned)
 DEF3(eqv, TCGV, TCGV, TCGV)
 DEF3(ld, TCGV, TCGv_ptr, tcg_target_long)
+DEF3(ld8s, TCGV, TCGv_ptr, tcg_target_long)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF6(movcond, TCGCond, TCGV, TCGV, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index a329ed79a6..749e0d5f06 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -774,6 +774,12 @@ void tcg_gen_ld(TCGType type, TCGTemp *dst, TCGTemp *base, tcg_target_long ofs)
     tcg_gen_op_tti(INDEX_op_ld, type, dst, base, ofs);
 }
 
+void tcg_gen_ld8s(TCGType type, TCGTemp *dst,
+                  TCGTemp *base, tcg_target_long ofs)
+{
+    tcg_gen_op_tti(INDEX_op_ld8s, type, dst, base, ofs);
+}
+
 void tcg_gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (src != dst) {
@@ -1383,11 +1389,6 @@ void tcg_gen_ld8u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i32(INDEX_op_ld8u, ret, arg2, offset);
 }
 
-void tcg_gen_ld8s_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i32(INDEX_op_ld8s, ret, arg2, offset);
-}
-
 void tcg_gen_ld16u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i32(INDEX_op_ld16u, ret, arg2, offset);
@@ -1421,11 +1422,6 @@ void tcg_gen_ld8u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_ld8u, ret, arg2, offset);
 }
 
-void tcg_gen_ld8s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i64(INDEX_op_ld8s, ret, arg2, offset);
-}
-
 void tcg_gen_ld16u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i64(INDEX_op_ld16u, ret, arg2, offset);
-- 
2.53.0


