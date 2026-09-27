Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7621AC98324
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:01:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAkkJ-0002Sh-2p; Sun, 27 Sep 2026 05:00:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkkD-0002Q7-KX
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:28 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkkB-0007PH-Vz
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:25 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2dfa54c8ccfso6165815ad.0
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499622; x=1791104422; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5nSUdvxykPOFbqE6Asna+l95QbCbv3T9sDSXoohfncA=;
 b=XN6ViiLVIeXwY7oHM8lz0/Q32bNyxzpFzOAFlr0K8uqEs2pcHaVBmoIMwB7K1vjxkl
 DD9VvK/rEUmvaucIjI4BGLYnAYMwYvHKkVx3VLLDcsi7en+7xNSrbHWoyt4tznQq2ry6
 mBMJdWTZ0t50aZokd92xCrUrIGuAUs9jz5YYqO8t1/NbyGkFymgxzMzEBXDePAsi5DBN
 mI1ANnSNLvWQUe+sJo2zy4CN2l8x1Uki+2xRdsmRr4m5hs8AJySwYrSqiMbZndkmUfF7
 aZcsTO81z/NX5ch85f+hxQ+h+okiV3WGm509NT/AHNQjq/Qm51Mpr1U6cWA6j/OVeE3B
 hqXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499622; x=1791104422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5nSUdvxykPOFbqE6Asna+l95QbCbv3T9sDSXoohfncA=;
 b=jqiXO1MLuKbsKYH3zxBhqYbMS5L+UDh281sOD2PzukhHR8664sStwbxWV5VI4F+JSe
 5Duc0JVJ0WTQ31QxisK3W8zC1pxzI6ZaTfV3u/k/4Uou1/hDeyj5bpiVUJK7pW3ZzCDO
 xPVHvXDE9mIqsARM7CaPMAWU81fJ/FhQsrpsFV01xx4X1Jwm42Z2r+dGQK8AWxDNBglH
 IpY3jx0KSN9l9G9VPGl0TwRr+ZAacVofyEuDl66EuvreYXSuozvZSNaWMDD1gg8en/UW
 ZJ+KtRIZgcn4yz2mxj+88WYRqfOPBPGeudlGzabsWwc08UVepRIq1zADtP4HgNgnjW3G
 vhqw==
X-Gm-Message-State: AFq9FYI2oiblCi5LyM3bqmMGMVLFhImvxLxQVf6hpOap6cRk19bF3xnE
 kqQV+GWNwkiMclSskQCPEYw3wXnmI6VHlPCjh7fQkxl77oYlQ3ZXV/ZrsQH8wOr1B1jVwqp+k1K
 2g9o+
X-Gm-Gg: AYBFou0ZaLuwmaOuHDx3xqwByt/g3S3wdCEYRi/Qir3E3CJi0zaFHZ2NEW7zXIs+Y7O
 xaR1c/LvmaJNelx/Fts6o+nmefjcuyVdjswiDAJ/h4qZlrocZS+aRx4X25KdJtutaUq9r2hGknZ
 NH0c+5TrJwt80Nzh3q5urRfIsWfiQcN1w3gMRkfR1ZQiwyrxw9AsTkeSKiatwfjCTmA3Y5UIco/
 iBJwMxai/7FFqYkUVuosIzin+M4gjqhiKnFCeE3+adGw5e2EVqY4Atj+dFa+yRQj0qkDxvTJLn6
 z+F9p3K2OJQ05jwQlhq5+XQBe05UwkgUZhDkn1RUeyfMcJR5Q7E3ByU6X5ykt3Yl1Tj02GkFkub
 Vtm5B5xL9qIEf1SU04++Gbaj/qR7eoV6UZnXD+6AeorU8joq72c2hOcY7sUYMbWdx9iAYOEE6K3
 OFTEi9yGCvxH3rYZ1YJ0nOOO2r9/3ddx08ZH2uaHUUQKEsiljONBy4SJVwUFQEpj26m554j97K+
 8bGqy/oj3yFI0s/brqj06zOokxg+g==
X-Received: by 2002:a17:90b:4e8e:b0:39e:39a0:b5b3 with SMTP id
 98e67ed59e1d1-3a09860fe10mr6692918a91.1.1790499622341; 
 Sun, 27 Sep 2026 02:00:22 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0b8efaeb3sm14014181a91.2.2026.09.27.02.00.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:00:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 010/101] tcg: Generic expansion of tcg_gen_movi_*
Date: Sun, 27 Sep 2026 01:58:40 -0700
Message-ID: <20260927090011.10724-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index eba3ad4f93c..55571653c7b 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -117,7 +117,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_movi_i32(TCGv_i32 ret, int32_t arg);
 void tcg_gen_addi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2);
 void tcg_gen_subi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
@@ -224,7 +223,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* 64 bit ops */
 
-void tcg_gen_movi_i64(TCGv_i64 ret, int64_t arg);
 void tcg_gen_addi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2);
 void tcg_gen_subi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index c76e83396ae..e55a9f99939 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -2,3 +2,4 @@
 /* Templated TCGv_i32 and TCGv_i64 operations */
 
 DEF2(mov, TCGV, TCGV)
+DEF2(movi, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 77ed34fcb8f..b2fa509cd1f 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -370,6 +370,11 @@ void tcg_gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
     }
 }
 
+void tcg_gen_movi(TCGType type, TCGTemp *dst, int64_t src)
+{
+    tcg_gen_op_tt(INDEX_op_mov, type, dst, tcg_constant_internal(type, src));
+}
+
 /* 32 bit ops */
 
 void tcg_gen_discard_i32(TCGv_i32 arg)
@@ -377,11 +382,6 @@ void tcg_gen_discard_i32(TCGv_i32 arg)
     tcg_gen_op1_i32(INDEX_op_discard, TCG_TYPE_I32, arg);
 }
 
-void tcg_gen_movi_i32(TCGv_i32 ret, int32_t arg)
-{
-    tcg_gen_mov_i32(ret, tcg_constant_i32(arg));
-}
-
 void tcg_gen_add_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     tcg_gen_op3_i32(INDEX_op_add, ret, arg1, arg2);
@@ -1444,11 +1444,6 @@ void tcg_gen_discard_i64(TCGv_i64 arg)
     tcg_gen_op1_i64(INDEX_op_discard, TCG_TYPE_I64, arg);
 }
 
-void tcg_gen_movi_i64(TCGv_i64 ret, int64_t arg)
-{
-    tcg_gen_mov_i64(ret, tcg_constant_i64(arg));
-}
-
 void tcg_gen_ld8u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i64(INDEX_op_ld8u, ret, arg2, offset);
-- 
2.53.0


