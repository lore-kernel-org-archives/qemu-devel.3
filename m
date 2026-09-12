Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94682C88E53
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:36:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L57-0000jU-5g; Sat, 12 Sep 2026 06:35:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L50-0000Ia-RR
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:31 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L4w-0008OZ-Lb
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:30 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 d9443c01a7336-2d8fe517774so9448775ad.0
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209325; x=1789814125; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PShwmw0taxsRaEPyF7uJxLPTKm1fJqNHr1RM9auVA9c=;
 b=EFwxED+eVVCS3WbrA1mt3tR0F2MkpcPf5Fcl7T8gKlVEeCpQMXy/jmUspEFiyQW3pb
 FdftzhobB0zeSli2t+705ZHHpuLKQn2Z/5DjXXqcKYPbDAF2QVUjL2Ws3zPWZQQ93YVR
 eeNCjOhE2qKF7NYfXXpFLiKu4VPdSlSdVOdfHo8A87I5O8qjpnhbCu4Ww67ODXLCFtyW
 jG9rJg09ntFYPBRaxVeg7JwS6fyvd6HSOoOnF5EIHIflg3BCfw2T7I0vPvHbygHfth3X
 X8MXmuWqtoWvtOt/j6FLZ2xUAtLLjv2n7LLHgepNITsFGKiDfXGFpVwwikOkH2zgoUry
 sopA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209325; x=1789814125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=PShwmw0taxsRaEPyF7uJxLPTKm1fJqNHr1RM9auVA9c=;
 b=LpC5sMvC9QBJNgafFAKUpKOqQfk1+Uj3pEOrm5gNovnDGT49jJRJHcgq+QoriEBAkd
 O/T1ZGmP0bCEbQv6XAI/sZTfwSvskW8FC+k076v/8PU3huWJIfo5nZh8tW4NJ5mLS9l3
 gr9u/VmjLqcpig1VCAC5HvU7c5qR/81SsB97PWAmISsyGEdOIl6YRWfDYTPz9jbmL0Dx
 LHX9XnAjjtO0KXTdgrKfPaqIJZq4jPZpwRIK5K0j0tTKNuOm8AMtapEhun/zspukk+s9
 3TqMChDO9GYijPy7vQ1Z6ZJCIqc1qZDS4Ds+wJnUrmYE90XSaIB//pVOFtUQskv0pOSw
 6f1w==
X-Gm-Message-State: AFuF++kQ11CCOQ3jFqaPtNTBIHG4GJVz2/yzaSNg+hgvenCchs19oHlV
 MciuhMkIOYEmKqCFz4COskFcaYEF0AxaBsS0zaTBNOqYTaRyzcV4aTidoss4wne3k2vta32bDNO
 UYqw1Jyc=
X-Gm-Gg: AYBFou2FFjIgnb+WWaSTyjuswbSkHA601iBPO3BOzkHAqbSzCnesw/Y/MHih1X0ApNf
 51eqlV9IH7a2OCNaqzEAelzJ1ZkUJ/JYR85g7CW8T/U+J1p/sOp8N2TAP5X6NzzGcNyVHbaqJzr
 LjmOVXFJIcU539bskoPsgBreXyLZB5ntRTQ1R2JJNG/IyFn+LVW4LloU3gukOALUDxpBN17bi7Y
 r/1ZzxIGFsaS+tFzY/TVii4ye8c6RCG4nQoPKf4nUiJIE+B8jWZvrVLt0pXbYB5JcLMqrHOyiN3
 yt+kTDRdFq+gKvAdUDPSPgUKL8EPTp72naBYmI0dP5StiI2WnJ4pKPZxp1fFO1B0x+yTRofNXBl
 IbU0O22oYmqIke6/Vk+1eery/7U9ul7Tzo//0KZF9L8eV3RdC68OyZjh6a4hapgJPUOAL7kXSAR
 cM5UpJinwqj0LNCPi2bRBNYIzIyXfXDPR5NN25CD1eg9xqVT4I6hOsY6C1zLZsWqLVIY+F7k/Hj
 Ja1tas=
X-Received: by 2002:a17:903:2443:b0:2d6:fd55:3a9d with SMTP id
 d9443c01a7336-2dd2a1ce17cmr141651275ad.3.1789209325154; 
 Sat, 12 Sep 2026 03:35:25 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4f55735sm13673674eec.24.2026.09.12.03.35.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:35:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 58/82] tcg: Generic expansion of tcg_gen_rotli_*
Date: Sat, 12 Sep 2026 00:31:02 -1000
Message-ID: <20260912103126.598030-59-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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
 include/tcg/tcg-op-common.h   |  2 --
 include/tcg/tcg-op-def2.h.inc |  1 +
 tcg/tcg-op.c                  | 39 ++++++++++++++---------------------
 3 files changed, 16 insertions(+), 26 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 265582c5a27..df7999e92cf 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -142,7 +142,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
                          unsigned int ofs, unsigned int len);
 void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
@@ -194,7 +193,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
                          unsigned int ofs, unsigned int len);
 void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index 76263510228..dd66a2ecd8d 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -21,6 +21,7 @@ DEF_RRI(clzi)
 DEF_RRI(ctzi)
 DEF_RRI(muli)
 DEF_RRI(ori)
+DEF_RRI(rotli)
 DEF_RRI(rotri)
 DEF_RRI(sari)
 DEF_RRI(shli)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index f7531d321ca..8add0836952 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -827,6 +827,21 @@ static void gen_rotl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+static void gen_rotli(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    int width = tcg_type_size(type) * 8;
+
+    tcg_debug_assert(src2 >= 0 && src2 < width);
+    if (src2 == 0) {
+        gen_mov(type, dst, src1);
+    } else if (tcg_op_supported(INDEX_op_rotl, type, 0)) {
+        gen_op_ttt(INDEX_op_rotl, type, dst, src1,
+                   tcg_constant_internal(type, src2));
+    } else {
+        gen_rotri(type, dst, src1, -src2 & (width - 1));
+    }
+}
+
 static void gen_rotr(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     if (tcg_op_supported(INDEX_op_rotr, type, 0)) {
@@ -1033,18 +1048,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    tcg_debug_assert(arg2 >= 0 && arg2 < 32);
-    if (arg2 == 0) {
-        tcg_gen_mov_i32(ret, arg1);
-    } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_rotl, ret, arg1, tcg_constant_i32(arg2));
-    } else {
-        tcg_gen_rotri_i32(ret, arg1, -arg2 & 31);
-    }
-}
-
 void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
                          unsigned int ofs, unsigned int len)
 {
@@ -1807,18 +1810,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-    if (arg2 == 0) {
-        tcg_gen_mov_i64(ret, arg1);
-    } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_rotl, ret, arg1, tcg_constant_i64(arg2));
-    } else {
-        tcg_gen_rotri_i64(ret, arg1, -arg2 & 63);
-    }
-}
-
 void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
                          unsigned int ofs, unsigned int len)
 {
-- 
2.53.0


