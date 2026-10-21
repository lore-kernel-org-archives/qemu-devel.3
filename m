Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94732606A335
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=MLs6ZuS3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJX8H-00038y-SS; Wed, 21 Oct 2026 10:17:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX8A-00036I-QY
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:17:27 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX89-0001WI-5O
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:17:26 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-48bbb06e746so462391f8f.3
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592243; x=1793197043; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5St8upeJVvqfNTMUi1WcdIz4CXDfgcmGXTZzXz2+1H8=;
 b=MLs6ZuS3jKOft8Mopxj4Ou3/+Uamzp2bKEzkr5B+Q/fy0/C9LawkjrLc10Rn6R3gIS
 hfWVbr8cRjQOeDFmpWRWQ9T6pxtMs9ruP8MEcPWC3Ba5sPvRGfMCRCRJOAFbxRMep+YI
 DA6TgTQva/TJGyhO9kmfjSoEZA8BMeRlKBqojNBkYEpSwe6mA/9A4xsTkKCpJPttl4iO
 xtMsgP51EwKvRpvfw2+tle2yorSiGMIABBoCYoiZp6R/Q/TDn2PCk32LD4eYHFjPlk+I
 pRm3G73No/g26t7Dq9OXC9cKtkex5rBdxT45SlIs1ttUSmVQ/4m/kXPZwvf0W5tB+zQ7
 2f9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592243; x=1793197043;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5St8upeJVvqfNTMUi1WcdIz4CXDfgcmGXTZzXz2+1H8=;
 b=aMLBdrjKVrmu+1HhdW9UJsxiQDz8agDcwAJ94fe/dXKEb0GV+nusB2Ac0XyDFlepIM
 /ylFDauW9TzBg68BCRAN9vONxotNwlM/7M8XWuYMaMY/Hz6Qfh8TJGMbD6MmImqmUweA
 UeWdG5iOw+RmIJRIm/moeJw2iKZuMZziQ17FpCslv2Ng8M5ky1lB7RpIG56YDETPHsSI
 p+QOVLxffQHQXgG30OkXj8kJU73/OycWzummx2ZYxunCWhwgFFaz6cJcgaiBmOBFkERe
 X9gAOTNVNWNpnP81T0rr/PmUisMgJyzUfU+Zor8J/rSbgXc8F/77OH2N7Rm8CwMpxLGb
 Lz9A==
X-Gm-Message-State: AFq9FYLW31bmWhqGHfQTu+H/4k1DdeFCwsINnveV09j/mfE6LvsNCmdE
 6Lqm7w7Rb/Xc64TsrbjEEQS1298iNkNoDotke+rLk5f8iK7uYlxIRWjgepeLntw3ZLzS+U+csDC
 a7eFphP4=
X-Gm-Gg: AYBFou2XVesdqYkeK6CPcGDgTSnAgX/LEHPy0xB4VvDiZthsFuerOPRRQzp6Q04/HND
 LtEMbgMEQC0P+Nf2y/JaKmRuHz4R1oUfTEVp6MBH7PKumBsbB4moZmdH1lc8qoI4AA7Is2bwcOH
 Gwr9xqYCUeLLH+MQEx9BSWFqgF1nsj8M2MZ8ThwS2b3jCqguUiynkGXi15d78JmFaxf4t+qYbF+
 9N3q41Mb2oVo/LQFCFbzXUvF6PtAUD8fspBWZkfPJSf+/5vdt+shXFKaB9LnT55qDJ5DhrhN0Rj
 0e1wiOgANFvhSHhN0R2iAADpQgM2lc2u9GRoZ2J2wCZdaoIkpzbmM3+N7bdBQ69Xmd9djD73Ai0
 2ghtYAhyjLxx+cmI9A5gNaseej+H4iOfNGsqj3Hzf4DOH2GTYdjq+a5ybo4DVh+vdszOaqbisZz
 fZmuSxU91KR2VqtHJSm4xPIxQXhnQ3kg06CclDppWx+Jai3GbGBeytvOrrj/v/sTzYHwtV7RH3/
 q2m+vSuHXyr60UfbmfM+rupG/X2PvLKrFPmFHxNN+4JjXfcTaKP3MIGM+TpUOeGd4iUAkFFz6f4
 dWtp0skCv7qp0orSM2J3R2BtPBs=
X-Received: by 2002:a05:600c:19ca:b0:4a1:fb23:68f0 with SMTP id
 5b1f17b1804b1-4a1fd89dd3dmr44341565e9.3.1792592243527; 
 Wed, 21 Oct 2026 07:17:23 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2c242dcsm147113845e9.0.2026.10.21.07.17.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:17:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v6 013/100] tcg: Generic expansion of tcg_gen_subi_*
Date: Wed, 21 Oct 2026 16:15:25 +0200
Message-ID: <20261021141652.363109-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42b.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index e2e8c66d01..372be70504 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -124,7 +124,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 /* 32 bit ops */
 
 void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2);
-void tcg_gen_subi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
@@ -225,7 +224,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 /* 64 bit ops */
 
 void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2);
-void tcg_gen_subi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 51d5ec6e06..55249c4dd6 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -7,3 +7,4 @@ DEF1(discard, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF3(sub, TCGV, TCGV, TCGV)
+DEF3(subi, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 563c3bb038..4239219279 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -399,6 +399,11 @@ void tcg_gen_sub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     tcg_gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
 }
 
+void tcg_gen_subi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    tcg_gen_addi(type, dst, src1, -src2);
+}
+
 /* 32 bit ops */
 
 void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2)
@@ -410,11 +415,6 @@ void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2)
     }
 }
 
-void tcg_gen_subi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    tcg_gen_addi_i32(ret, arg1, -arg2);
-}
-
 void tcg_gen_neg_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
     tcg_gen_op2_i32(INDEX_op_neg, ret, arg);
@@ -1537,11 +1537,6 @@ void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2)
     }
 }
 
-void tcg_gen_subi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    tcg_gen_addi_i64(ret, arg1, -arg2);
-}
-
 void tcg_gen_neg_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     tcg_gen_op2_i64(INDEX_op_neg, ret, arg);
-- 
2.53.0


