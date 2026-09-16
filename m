Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96216C982C3
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:14:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pQn-0007Ee-Ms; Wed, 16 Sep 2026 09:12:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pQi-0006bC-9Z
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:12:04 -0400
Received: from mail-oi2-x11.google.com ([2607:f8b0:4864:32::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pQg-0001zt-9t
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:12:04 -0400
Received: by mail-oi2-x11.google.com with SMTP id
 5614622812f47-4c0776592e3so544317b6e.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789564321; x=1790169121; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=glLv504VFhTMhB7phZn1cRYPE+fD+DDkgUDC3CT2ZDo=;
 b=yoecbLljwjqjufLEJ5X1dxIaY12f6q70qsGKGN/N2K3uoemi1tzTMLeXFOK0nTttqN
 pL2VFCunbWPfjTTLrdmzFbWhxHmzgP4lRfX/lNds8wa37ccW86arLocfdREX1dPOOC1n
 tA9wwvKWhl/2RBAMLJYS9lWbPECTmp/nY/HwOjw7xiwWymWP2iyffDiL0FvsN1vFd2/H
 sF01zmErA+HXRvmHNWGK2GKz2i4E8igTdk+02eCt1sqZkVSrpH4sE49bN4UdC3k5GPc+
 PdyaUPm9PPt5e1Sh/vuHsqF3n4SXU8rVzvuQpGyTwxdE1tR5bXcwMmYvnKGf+Ec8BjG+
 eH9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564321; x=1790169121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=glLv504VFhTMhB7phZn1cRYPE+fD+DDkgUDC3CT2ZDo=;
 b=XK02iTQTS4Gy5w9HQpjFgPV6gP8FAqWNMGILqRuBS+Z//RiApacPdODTusXEHTySx/
 qBq1U00CDTlPBtCspypG4GtP1191oTsrHllZ4AOPEUyer1cLg/tja/YacjmFYvpMT4PE
 ehdIK3jLeihJzZz/kzzqgpXOwFkSxpBpuYlaMqYEWFRNJwxaHfTay32bzkxnJ6JAQvAY
 BKXCZUdCWT7v3/UzjCSuSp0B9+ymbvjQmsxVBwkk81MRbeKoLPP6XrCubz+IgZtj1p5/
 st5bF1SaN3ee5VBsROKEr+KakOaJ24DLtPyD+u5Zhi1Tpb8E6EOYUhtOLsDbfWzPEYn6
 alNw==
X-Gm-Message-State: AFuF++n1+PsQNwitWHNmozYvMsFHNMhtZPyzIBhba/09V2Kaoz9sVo4r
 gepScuKv7RkiSA0ZiwSRN7+FPRIrNhHe/xh2N8LonvAPZ6VXAQdi5Qw+LiDamANIdNJI+zFibHD
 JeufaZJs=
X-Gm-Gg: AYBFou26sq+zeXQI9ZTLxPSzbiSvMnMgpaB/6dKInbZJ7fpgVQCTv26lYoNoTD2qGUZ
 o5GtbsvGRwfNoPnJL0RDqi5/Yh0glyNdfVvmURxZq/JpwVW4EyyexlMoVKxCKjm1hbXSXsRA8Gi
 cybaPlx99XhliqVanOtJZIUvvtkL6I/NlyxJXVCFmNaLISxYyWF9+2HY9NhTkBea8TdOX1EMyYx
 Qn6JBEIZM/HbkW0cARQIkDKBvtyAMeC1n/lmNwg8gjOk6eVWuw46ecf22HeMW/CG4Pi84U+UMaC
 4U2MOaeKNp3ExTz7HFFlNDfl4CfCbKfYyoTv8E9J/onmM+E+LRT0IYAqNGohGpU4cfluIz2wEL5
 I9z0ge4HSo/jGE6Wv0E94hwaclp7ZBCcSQIhBtbJTg6wDRmipDGCxNbhxcjvb6vDRKMstTE3jaJ
 2iixSf6tAqGVPEe3zHB7M9kJ+EC/bhKWgHrMowVM7JOmcGgoD6YTpAjYOeg28yx+CHW1prQwqt3
 RKDdW0=
X-Received: by 2002:a05:6820:f006:b0:6b7:8415:d794 with SMTP id
 006d021491bc7-6c7d39fa918mr2238924eaf.63.1789564321031; 
 Wed, 16 Sep 2026 06:12:01 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5b22b74sm7873110eec.30.2026.09.16.06.12.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:12:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 85/92] tcg: Use unsigned for flags for bswap and revbit
 operations
Date: Wed, 16 Sep 2026 03:04:00 -1000
Message-ID: <20260916130409.3382710-86-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:32::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
 include/tcg/tcg-op-common.h | 8 ++++----
 tcg/tcg-op.c                | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index b0ce35df411..9d83d70a798 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -133,7 +133,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 /* 32 bit ops */
 
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
-void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
+void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, unsigned flags);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_revbit8_i32(TCGv_i32 ret, TCGv_i32 arg);
@@ -158,13 +158,13 @@ void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
-void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
+void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags);
+void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags);
 void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_revbit8_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
+void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags);
 void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg);
 
 /* Replicate a value of size @vece from @in to all the lanes in @out */
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 27fd7469545..bc61a4ee3f8 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1454,7 +1454,7 @@ static void gen_bitswap_i64(TCGv_i64 ret, TCGv_i64 arg, uint64_t mask)
  * With TCG_BSWAP_IZ, x == zero, else undefined.
  * With TCG_BSWAP_OZ, y == zero, with TCG_BSWAP_OS y == sign, else undefined.
  */
-void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags)
+void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, unsigned flags)
 {
     /* Only one extension flag may be present. */
     tcg_debug_assert(!(flags & TCG_BSWAP_OS) || !(flags & TCG_BSWAP_OZ));
@@ -1655,7 +1655,7 @@ void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg)
  * With TCG_BSWAP_IZ, x == zero, else undefined.
  * With TCG_BSWAP_OZ, y == zero, with TCG_BSWAP_OS y == sign, else undefined.
  */
-void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
+void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags)
 {
     /* Only one extension flag may be present. */
     tcg_debug_assert(!(flags & TCG_BSWAP_OS) || !(flags & TCG_BSWAP_OZ));
@@ -1698,7 +1698,7 @@ void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
  * With TCG_BSWAP_IZ, x == zero, else undefined.
  * With TCG_BSWAP_OZ, y == zero, with TCG_BSWAP_OS y == sign, else undefined.
  */
-void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
+void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags)
 {
     /* Only one extension flag may be present. */
     tcg_debug_assert(!(flags & TCG_BSWAP_OS) || !(flags & TCG_BSWAP_OZ));
@@ -1765,7 +1765,7 @@ void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg)
     tcg_gen_rotli_i64(ret, arg, 32);
 }
 
-void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
+void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags)
 {
     /* Only one extension flag may be present. */
     tcg_debug_assert(!(flags & TCG_BSWAP_OS) || !(flags & TCG_BSWAP_OZ));
-- 
2.53.0


