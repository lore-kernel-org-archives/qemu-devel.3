Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9682F606A31D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=VYSbbCA2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXGT-00063a-Fp; Wed, 21 Oct 2026 10:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXDU-0001ea-3D
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:56 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXDP-0002Bq-T7
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:55 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-48e0d1c095dso506581f8f.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592570; x=1793197370; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KArhMg/HVSVW/NJg9FFsjag5rrbCKAerpLCbJNEB4Ek=;
 b=VYSbbCA2+6HOcrjsD90X9tW6El7NOCkJ1OIKQbvfhWtCDoSp701/39KOmmexmRbrBf
 wiW+1fdqVuEU/3kIwaiRPqX2E9ewcJE82hxcPyDB+gRi2WGCIRAE6uMEXn/lK7VLEuSs
 b8o2OUwzggIybkNOqkTjc0Bz9yD/pNdDQAMXV8gAhRQxrWsnNRpj2S0IyQe/MsCooOBh
 o1LmB8vN3M5GJPlpdquhy7Np+ARdbqNGbgavGDAfsXTjbTw+LYNlhCBQlakJHHegX5C8
 3BjSF2cz1Spv/7nAlUZe5HiKKk0WGvtENZSJTZ44rIYU/uhB2BSUcAoIIjaS7qpnxYGH
 KFRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592570; x=1793197370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KArhMg/HVSVW/NJg9FFsjag5rrbCKAerpLCbJNEB4Ek=;
 b=k1hkefENTEK9vvy7JNNjlwyxsQAAyT+Roxx0gyJG3+6ZxgTtq+3j7yT0Ubp3KxEJQ5
 F8LfYVMCsRU3vgfzd2CwfbkHgbA/1vPlSSfnxzbbD9iLlL+5abPnb/cZkreoQIetHd6K
 7LFlDTFPv0TIRe23qw1wLHMMzADHyp9zotekBVGv9nWTnyGq4wRBZJ3eOagUmIb245Bs
 Ug5juK0dTKOCVwbIzV9IiGQc+kI89EkWPtmo9O3My/aNi7K0Cm/Gz5SvmAPxpA1vGOCx
 SDCbIdvJIRgbMwh1/OINU7e3xiCBWAgR/Or10mv/xr9KqQzGzKhLqVyj2MfwKsjJOP05
 czVA==
X-Gm-Message-State: AFq9FYJIHrb5cb0oDLdyB2BjG3iUYnU4acrsomM2NnvG6wWUNeN7sYle
 PLi1qkg1ZF4dOzexPZHPPkvDKRdg8pHJ9heNhRLKMqqCckVO0wZ7B3v1BCCBFAnGOPuM6gCJ/P9
 ydd30Bpo=
X-Gm-Gg: AYBFou3rtMPk4T+w/82w5gFp9/d2M99uSigTsfOMJN17W50mbqK35Agqs0yVXoTfjZX
 UKmO37cvQcbgq/3ppgL159Yl/jv5I1gq9nR1fxnmdum38WK4f2fLQNpFXtEWX+Kkr3ZjBo9u0LZ
 4YRfM5nSVo55hM8WdN0JJrTN0ek3VFRUCNuD3/qxyA7Cxnp7+7/QggTrIlx5nQwJHm9Z5nM3TAH
 2bg5gGRT+541kmLRBgHmRoLmJn85ekmj38LkgyF6KhUumgsEoJu5xGXlaQq5jtBkt8aUHE0+MBr
 0f24mYgnCYChnacmGMZyqPjheswHOBCeb5X6Rvjre0gZ+9zvqjPAUDJUucQr1s10RO3t3HAhCfk
 OU1t+9k+uKkLpf+eEL0w7JNxsEZ9wQ18MFlxloYb/M6EVVbBw6ut3j9VBPBm4drtKmh0FNS1moo
 y/lAP3/QjwO62KN4JwMXpOrUEjQkOMqLAol76w72Sq7FBbj0t+uyQvybxxtwrnTbUqRj+MLQs3P
 v4sjOVyiJjutW4O4SKL8g79ZAqK8fOX9LWSwXCCOPGKF2eKOBHjTSiIA984rzJPIwaZn6g56Hyc
 orm/G24GY5ZBbrCYbb0oJnv15y0S
X-Received: by 2002:a5d:5f41:0:b0:48d:f39b:83de with SMTP id
 ffacd0b85a97d-48e2642d367mr4887993f8f.3.1792592569761; 
 Wed, 21 Oct 2026 07:22:49 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828e72sm5393603f8f.26.2026.10.21.07.22.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:22:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 071/100] tcg: Generic expansion of tcg_gen_smax_*
Date: Wed, 21 Oct 2026 16:16:23 +0200
Message-ID: <20261021141652.363109-72-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x430.google.com
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
 tcg/tcg-op.c                 | 27 +++++++++------------------
 3 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 54ad54b0da..7214846b81 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -146,7 +146,6 @@ void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
-void tcg_gen_smax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_umin_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_umax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_ussub_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -188,7 +187,6 @@ void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
 void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_smax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_umin_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_umax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ussub_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 1486066728..de3feeabdb 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -55,6 +55,7 @@ DEF3(shl, TCGV, TCGV, TCGV)
 DEF3(shli, TCGV, TCGV, TINT)
 DEF3(shr, TCGV, TCGV, TCGV)
 DEF3(shri, TCGV, TCGV, TINT)
+DEF3(smax, TCGV, TCGV, TCGV)
 DEF3(smin, TCGV, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 24e7d6da50..c97b0ad64a 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1013,6 +1013,15 @@ void tcg_gen_shri(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+void tcg_gen_smax(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_smax, type, 0)) {
+        tcg_gen_op_ttt(INDEX_op_smax, type, dst, src1, src2);
+    } else {
+        tcg_gen_movcond(type, TCG_COND_GT, dst, src1, src2, src1, src2);
+    }
+}
+
 void tcg_gen_smin(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     if (tcg_op_supported(INDEX_op_smin, type, 0)) {
@@ -1347,15 +1356,6 @@ void tcg_gen_umin_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
     }
 }
 
-void tcg_gen_smax_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
-{
-    if (tcg_op_supported(INDEX_op_smax, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_smax, ret, a, b);
-    } else {
-        tcg_gen_movcond_i32(TCG_COND_LT, ret, a, b, b, a);
-    }
-}
-
 void tcg_gen_umax_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
 {
     if (tcg_op_supported(INDEX_op_umax, TCG_TYPE_I32, 0)) {
@@ -1878,15 +1878,6 @@ void tcg_gen_umin_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
     }
 }
 
-void tcg_gen_smax_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
-{
-    if (tcg_op_supported(INDEX_op_smax, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_smax, ret, a, b);
-    } else {
-        tcg_gen_movcond_i64(TCG_COND_LT, ret, a, b, b, a);
-    }
-}
-
 void tcg_gen_umax_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
 {
     if (tcg_op_supported(INDEX_op_umax, TCG_TYPE_I64, 0)) {
-- 
2.53.0


