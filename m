Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F919606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=fGaVq+/H
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXD5-0001Lf-8x; Wed, 21 Oct 2026 10:22:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXD1-0001Bn-49
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:28 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXCy-00027T-KP
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:26 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c40447e25e6so87624766b.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592543; x=1793197343; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g810h8tWv4wLbUjQZBwqzSKJ8HJd5SmLr70DNaJU9uc=;
 b=fGaVq+/HTBCbSWiv20k4qtxBGxcL5jVO5ydW72i0NPvDMpeCMk5hEa8N7w+loAk174
 aTqKOzoPowV3V0ZrQzs8aJjUDgfGuOM7lq6BbvX1r38Fl7w+AtK42ez1RDetKqhoYedq
 ijz38mAfCvGFrps4s35Ij+tAo9stz9NjG3q6NbOzh0sngENcVs244zskF0YMT9ok5oIo
 K4oxslBFh+dPyNQWKTlu+kjyqSJOiqRD2NAeGyTzbTUX66dcxyObT8C8XpZqC+utEdns
 g32SSRZRLAsa7wXMrMjoayCaNHLRsWbhFTWYa15//tMMrmZ3ZwHNBwiQIdRvCCrWWi/0
 MnjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592543; x=1793197343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=g810h8tWv4wLbUjQZBwqzSKJ8HJd5SmLr70DNaJU9uc=;
 b=wzMB4q65Bn4+Gv9gYSzphmNSoGxNGDDRbT5yOUWFzjiqc5s4VfpSpuCiPSgO0Wy9JF
 hZF43JytXs0xrrTQSgwKA7/Qs+zy+qwD8gY/1MOADQq64crXk4qqLWk+obLjNBUnmKex
 5D6OlpGxQtuXEj9tUIIrGGsPpo9NVZqgIrdz6+ZIPn6zSdGg3o9VHfShPzLpLdPoL9CN
 wdTX8Zap5SeGVvUXTCTi6TnovOSf+CsWRDJKHT0J1zFxofhoFoRcV8CQOzs9rJcwkaJ5
 63zq2ycAsA3rFfN9Lr6XDYxqz8ImWM62eFBpe36QZIExG0vPgCJEKSItqqoGvJ1yHCff
 P0Kg==
X-Gm-Message-State: AFq9FYKJDOxldL1peMjsUHZsLLVcmnclSBUYt2cxbl40pzgfcXFl98ZQ
 jX1bquMuAVZ9TEkHdHcOdFMhrAPbf3TulePIhIlJjzE3MCVpFW8PYGs6oxHG1Lv63x6iIEhKQpi
 rUYfq69w=
X-Gm-Gg: AYBFou3c6FhRxruUqQngwCMXQcQRyAV9ezBXVWK7pANvBn+bIW6N1Z62XEZ5MkNlNrf
 M1mTxnbSA8fyjraHqi0jsCtKM6mNLOS5fzeL+P4tGDfmIJod7NGtVUwwJSiv6HTXZtiehdm+zOa
 K18k4D8Vr8DaI+k6K6pbTjgeKEvWl9cK0NUQU4jzHdbA5yVRCz5DXoPlg98AWiZu5ch3ycWAOoh
 81/f2M01tn5Q68iGqL4JG6Kgivb0j+YSvKkB/C7y/r3ioFlO7E8ADDKBUzapl6eV+0c4/5SVSVs
 jVh7iuOtT6j7Uxq0gEc/KxFI/dMLdp1cTdRzaHUwoNTbs4+fUGYd1FX4zngNUT2tBRKjdZ0Z9Sg
 xRXm2y9lkFzGGSrWO+63u//Qn7MJyzakzcYWA/gdt42qAOJuIev3ewUcE5VxjGUb28JYRJJJvkA
 nm5RRisQPtN693nm2uhDZ0v4dIX9VW4Mv2FyJCRcIXeacY5tGgwMNVJ86q9dt+UEKCUSGGKViiT
 VtmL6BglvtZyLAaK7xRCEdRovQq1TGto+2kirNfZN6r58h/nGfrxW2jL4gnikMio1ZwU8RmEMAc
 qUgdcrM3tTY7RT31wcRPPpIMsW4=
X-Received: by 2002:a17:907:720e:b0:c29:4490:50d6 with SMTP id
 a640c23a62f3a-c4679a172f8mr207260866b.47.1792592542481; 
 Wed, 21 Oct 2026 07:22:22 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828e72sm5393603f8f.26.2026.10.21.07.22.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:22:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 044/100] tcg: Generic expansion of tcg_gen_setcondi_*
Date: Wed, 21 Oct 2026 16:15:56 +0200
Message-ID: <20261021141652.363109-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x636.google.com
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


