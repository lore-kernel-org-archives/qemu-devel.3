Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71813C79FB6
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:36:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L4t-0008CW-Bd; Sat, 12 Sep 2026 06:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L4l-0007mp-KL
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:15 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L4g-00086v-CZ
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:12 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc4c08393dfso294011a12.3
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209309; x=1789814109; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pDmdp1Vy1jjY2F/bZkRp08PH7q+ZwhXns/0KRVef1tc=;
 b=uxbbrbGe9gFfupfKdfBD9Lv6PMc8RZ9QSvlxu9lIk25TQOeDL3eXRjsrR9beF1zee+
 Z/dcmMLGqfj7tmdlj6sPkBcLDoBvd051NI86QQVrZO2WG8WWDQgVjYb4ToWOU1Nvb+CN
 8ADZ+41wSvpCj5EntRBbGAomwjxEumswMlbQ8dgAYqw5Xw02r4vZUgYwb8Tr9VUrVgf3
 550IOBbVmpfBPBQNvBuJE786vzVyVN/J6IDK5674CV0nqxNADRDmGVOYczq653jfpaq4
 NNFSOQCf14A3UbRsGvunVmoflvrR8RH6PW93vXLqcdepCLpAI6tCfPfszFTU2u6v6IGl
 kDSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209309; x=1789814109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=pDmdp1Vy1jjY2F/bZkRp08PH7q+ZwhXns/0KRVef1tc=;
 b=KNsm6Kl+496dpd5XcDWsXkSoS8dYIlkkGLbnyksd023/w19wmTXEFxLomOwIWpvLza
 UhZCdUawvVs1gE950HO1j3Lx0miyq3GI4URAwTHNY+3mftAZ4R1DIoB4II2VIQ2L8zch
 STTT7+JZCGp07kGHKHvXi3oQaItLxavFHzx4aWA8R6y4JSm2pzXrXamI63h8q7PcHcHj
 zAGVF8lJA+c78hcp/Ap0NGSsRtV+1Ne0pIOUUuWnTzsbPA0/AYcK1XreTuPgmDaoPQVb
 tn+tX5jRg8d6V1pr5X7xy+A2J2Ou9KbfLKT7pXZ/QT4Ot1SSHrleqS+Yx0amPkUIMPWE
 1YRw==
X-Gm-Message-State: AFuF++n7pPL2e3luXx2EWCnFSbbv5tfZU7O90aAcZRVllfme0g7LD4pw
 POZvSKIYFiTEHCjDAWYG7XN9fZzbVl2s9qCaREGqpsoT24TUDIuUf+ezp52XbHJ8fKP78aOunoO
 v9Ja4RVQ=
X-Gm-Gg: AYBFou2vVpYMtQ8l9X/96+ElPxB1w8n5FXGQ0Zu6kmJRDQMsh6aZrXJLq/sR9YPay9O
 QZNQhlJ/Ie+BX5eqGkhAT3ZKSiZ9R9vWVZTUl9NtB6+EQ1ua62XMj3CttSBZeyUJS9gtOeJgvLK
 GvAYMihmytjQoT15gy0VMYTbOMGPdN56ivLqm/ehRuoN7woNFy9gaiwTvtL8dx3+4eskmu1jgYl
 diGFgST5Vk1f71j8rRKX8PK0ootDjWOKq2YjSBTEhJFsgBGFZByJVdC7hjiWAz7qXfQ5/qOb2MR
 HiZWa3BsUQepMKImtqftHIZwM7RVdOVCPK97B51nxG9zg+W3GDrgG4jqVmHm24oNoMbgyncVQ8z
 jXuREHrXSnOhcP8of/WdPcvVzoWlgDbgyKZiIjjLVfQ8QiBZHkAEA2Hnb41zCnWaKQSdh8Y6dHt
 y3l5LHA5Fnkopa72K1xugogFzYpxx0uWRIGhfYl0+SuLYCBFTnWPe9OLDcWPXKhhZeawf6mfR57
 ZtFqaw=
X-Received: by 2002:a17:90b:4b44:b0:396:65dd:4093 with SMTP id
 98e67ed59e1d1-39dbc6a5083mr3657090a91.14.1789209308764; 
 Sat, 12 Sep 2026 03:35:08 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4f55735sm13673674eec.24.2026.09.12.03.35.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:35:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 41/82] tcg: Generic expansion of tcg_gen_negsetcond_*
Date: Sat, 12 Sep 2026 00:30:45 -1000
Message-ID: <20260912103126.598030-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h   |  4 ----
 include/tcg/tcg-op-def2.h.inc |  1 +
 tcg/tcg-op.c                  | 36 ++++++++++++-----------------------
 3 files changed, 13 insertions(+), 28 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 02272bc7e20..59f0f9ee0de 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -157,8 +157,6 @@ void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
                           unsigned int ofs);
-void tcg_gen_negsetcond_i32(TCGCond cond, TCGv_i32 ret,
-                            TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
                              TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_movcond_i32(TCGCond cond, TCGv_i32 ret, TCGv_i32 c1,
@@ -224,8 +222,6 @@ void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
                           unsigned int ofs);
-void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
-                            TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_negsetcondi_i64(TCGCond cond, TCGv_i64 ret,
                              TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_movcond_i64(TCGCond cond, TCGv_i64 ret, TCGv_i64 c1,
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index 030c59bcd47..5343b99f622 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -3,6 +3,7 @@
 DEF_CRIL(brcondi)
 DEF_CRRI(setcondi)
 DEF_CRRL(brcond)
+DEF_CRRR(negsetcond)
 DEF_CRRR(setcond)
 DEF_R(discard)
 DEF_RI(movi)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 1b4cb935bb9..a04a55c186a 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -538,6 +538,18 @@ static void gen_neg(TCGType type, TCGTemp *dst, TCGTemp *src)
     gen_op_tt(INDEX_op_neg, type, dst, src);
 }
 
+static void gen_negsetcond(TCGType type, TCGCond cond, TCGTemp *dst,
+                           TCGTemp *src1, TCGTemp *src2)
+{
+    if (cond == TCG_COND_ALWAYS) {
+        gen_movi(type, dst, -1);
+    } else if (cond == TCG_COND_NEVER) {
+        gen_movi(type, dst, 0);
+    } else {
+        gen_op_ttti(INDEX_op_negsetcond, type, dst, src1, src2, cond);
+    }
+}
+
 static void gen_not(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (tcg_op_supported(INDEX_op_not, type, 0)) {
@@ -790,18 +802,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_negsetcond_i32(TCGCond cond, TCGv_i32 ret,
-                            TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (cond == TCG_COND_ALWAYS) {
-        tcg_gen_movi_i32(ret, -1);
-    } else if (cond == TCG_COND_NEVER) {
-        tcg_gen_movi_i32(ret, 0);
-    } else {
-        tcg_gen_op4i_i32(INDEX_op_negsetcond, ret, arg1, arg2, cond);
-    }
-}
-
 void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
                              TCGv_i32 arg1, int32_t arg2)
 {
@@ -1568,18 +1568,6 @@ void tcg_gen_negsetcondi_i64(TCGCond cond, TCGv_i64 ret,
     tcg_gen_negsetcond_i64(cond, ret, arg1, tcg_constant_i64(arg2));
 }
 
-void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
-                            TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (cond == TCG_COND_ALWAYS) {
-        tcg_gen_movi_i64(ret, -1);
-    } else if (cond == TCG_COND_NEVER) {
-        tcg_gen_movi_i64(ret, 0);
-    } else {
-        tcg_gen_op4i_i64(INDEX_op_negsetcond, ret, arg1, arg2, cond);
-    }
-}
-
 void tcg_gen_ext8s_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     tcg_gen_sextract_i64(ret, arg, 0, 8);
-- 
2.53.0


