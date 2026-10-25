Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3904606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=KGR3V8Dd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsZv-0006n0-Rt; Sun, 25 Oct 2026 03:23:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZS-0006GD-9m
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:10 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZP-000448-5K
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:10 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a5720b0a57so618805e9.0
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792912986; x=1793517786; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WWrJb9P8S/mh8ZnT0iDxEX9HbjL2yh6lmkCBSdUC9jA=;
 b=KGR3V8Dd0UKBxdMD8pnDeVBQ0qC9rigjVMk2kH96J1vFuByy7gUbaLihIY7Am8tNEk
 z4hfIGdzKN9FFU77zk4ogBdiVvn9BFlyr9vUy1q6LwCxYhre/P+/0a6BTnVek/fcoLar
 IlyRiA0r+u6x7QNSlANUy9Sr8yh/wHa1fPPXHcMyO6KMfbV66fHHTmPPx8YG+TmtdhVx
 tmR3MLIFX/72Hq3rCuBeaupISVyGXLmHLN1LdaPc1YCrimJNt3J079IqxRsDriHF3Frv
 kjbSaJ1f/9tYMuJW3B5ULQ0Q+8vX5LFgpp9oqobBLkKRjExmNG932U58vmGPkCJPC3nZ
 hZ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792912986; x=1793517786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WWrJb9P8S/mh8ZnT0iDxEX9HbjL2yh6lmkCBSdUC9jA=;
 b=mg4GS0GGJqHPJcIOXUWVTVteN+y+mucp8WoloF052kDR76PXM1qfCPeurCTKXNqKxH
 yIOol4cpQfoPMMwO3bX8P30v6AjdTAI1fydglLvGL2j2SUjPlgGcjtqYaeKuUtlv77vE
 6QORe1HCLKq9OpSTAGncdNa5Yzk3aw8C4bqa2ZEmKbNfbJ20KtgIuckeiHP+T1YrCJTq
 ZFWrOFnvW4jwMVFYSA2S/hCj9uqUsH2alUSpU45wIAaS9CnebIjklsfM//u90IJPzZUV
 NMOKD34Fbd9Lge4IiVEon4+U0riQK+a8X7j21t6tyB03JKdcq+vhRE0lI9t3lS7EdfgP
 r0UA==
X-Gm-Message-State: AFq9FYLJlDPBfn7FgqfMuYrrh5iPvtoyUT02aQvekW39/82Yoj5Hz2VA
 qbSo1ntCuv68HssY/2MKtWB6IFV6OZ7irDoh3bQ/EyLzG4Aqz56vYlhImZL3qrU0Vak0fckoNyy
 WHT22UJY=
X-Gm-Gg: AYBFou1aN1ROCf7QzTLsk3DPAIHjr/Ttw3yP7lhqHdz/lSPddT3Za8hGKJg3CbWuC+x
 0H0bi6xYnNBxWlSuUD6VcE8vefI5ZIGfVjxUYANqqoBLcFaR/fWOb/yJ4NYOAo3pHN5FUfr2s8O
 jvp3piOlmOVS1JaPkYau5RBzN/j3IMejAlEwfwbBi3q8iwcointOfu2DonOoAE8VmW8jNtChGDo
 /HSBaE4jPNKpy1kTmIODTjSJm/MME0k57XxXBQCatXBUcLWSwDRcLjwNdEK1YcmtgG4/V+NRXql
 fqGSkLImBknENX+XJ87HlShDcUOFSn0SUZEkxIvnkLffLZ0+QkinHVCYO6By1IqgJb0DkLbyIMX
 fub4kiCTx9lzNGS3GyEi0f4qHKKLJ0hc3Mic0Ergg/gORvPZWufEu+DjIO91k+aU7VhRN9KWJl9
 gswrOhBfPnbUgy0sUMGwof0iiL+y0YaFgo76lYRIK+dZHFUpv7WL1iPsoxXBmhOSIFIGXdWufWr
 buGGgZgC3XW2zzzZnYvbPBTy5DXcu2uk/Nf9/wN4bUtj2id+ztW5/mVx9ZGiG8VV3S7VMg7ddRA
 +Mru
X-Received: by 2002:a05:600c:190c:b0:4a2:10f9:37db with SMTP id
 5b1f17b1804b1-4a35ae86fa3mr63094115e9.7.1792912985705; 
 Sun, 25 Oct 2026 00:23:05 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a09434esm103085895e9.0.2026.10.25.00.23.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:23:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 044/100] tcg: Generic expansion of tcg_gen_setcondi_*
Date: Sun, 25 Oct 2026 08:18:19 +0100
Message-ID: <20261025071915.1123867-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x336.google.com
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

Reviewed-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  4 ----
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 18 ++++++------------
 3 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 117d66ef59..c7ca7a493d 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -146,8 +146,6 @@ void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
                           unsigned int ofs);
-void tcg_gen_setcondi_i32(TCGCond cond, TCGv_i32 ret,
-                          TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_negsetcond_i32(TCGCond cond, TCGv_i32 ret,
                             TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
@@ -215,8 +213,6 @@ void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
                           unsigned int ofs);
-void tcg_gen_setcondi_i64(TCGCond cond, TCGv_i64 ret,
-                          TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
                             TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_negsetcondi_i64(TCGCond cond, TCGv_i64 ret,
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 4934f117bb..92a35e83f8 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -28,6 +28,7 @@ DEF3(remu, TCGV, TCGV, TCGV)
 DEF3(sar, TCGV, TCGV, TCGV)
 DEF3(sari, TCGV, TCGV, TINT)
 DEF4(setcond, TCGCond, TCGV, TCGV, TCGV)
+DEF4(setcondi, TCGCond, TCGV, TCGV, TINT)
 DEF3(shl, TCGV, TCGV, TCGV)
 DEF3(shli, TCGV, TCGV, TINT)
 DEF3(shr, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index a45244e64c..94451fcfd9 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -633,6 +633,12 @@ void tcg_gen_setcond(TCGType type, TCGCond cond, TCGTemp *dst,
     }
 }
 
+void tcg_gen_setcondi(TCGType type, TCGCond cond, TCGTemp *dst,
+                      TCGTemp *src1, int64_t src2)
+{
+    tcg_gen_setcond(type, cond, dst, src1, tcg_constant_internal(type, src2));
+}
+
 void tcg_gen_shl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_shl, type, dst, src1, src2);
@@ -701,12 +707,6 @@ void tcg_gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_setcondi_i32(TCGCond cond, TCGv_i32 ret,
-                          TCGv_i32 arg1, int32_t arg2)
-{
-    tcg_gen_setcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
-}
-
 void tcg_gen_negsetcond_i32(TCGCond cond, TCGv_i32 ret,
                             TCGv_i32 arg1, TCGv_i32 arg2)
 {
@@ -1479,12 +1479,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_setcondi_i64(TCGCond cond, TCGv_i64 ret,
-                          TCGv_i64 arg1, int64_t arg2)
-{
-    tcg_gen_setcond_i64(cond, ret, arg1, tcg_constant_i64(arg2));
-}
-
 void tcg_gen_negsetcondi_i64(TCGCond cond, TCGv_i64 ret,
                              TCGv_i64 arg1, int64_t arg2)
 {
-- 
2.53.0


