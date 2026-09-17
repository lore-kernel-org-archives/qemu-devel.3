Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D7EC88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:37:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73qw-0003kG-1O; Thu, 17 Sep 2026 00:36:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73qr-0003Vl-VM
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:36:02 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73qq-0007wA-5l
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:36:01 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccd5cf02so265866a91.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619758; x=1790224558; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=W+JgBN35vqPMsZk+u76UTaj7IIgPbC7+hvkUk9eqOfc=;
 b=u9bVbbFC4fI7N51wA1j5XVGbN/9bLrb+xT2LSvgfWvhstvxd2q2uQOPi15RKh8beKe
 xah2/4y+k7YBqvhi/M161n9L++SWCy9OK2uWxd2LpDX/nJnyzAvxdJCqxMIcItFcO+Mp
 elgGN3FXbwcflqGJQoYkVaId57zYchSGsbRsdHtNeK0n95Q85u5+sLjV+v2TzPN19T07
 KC4NNvtsiHwXEguZAjztcFAv4jZI9AGqYvhGyinP1Hcq/jbZoiQy4ARo6JVb/eu/qP6G
 vSOjW6G1fRTZbWqGefsDy0y96GB9tchY0W+miXc/lLBjAh08HXtczVTLUh9J+nLIPjJI
 7MjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619758; x=1790224558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=W+JgBN35vqPMsZk+u76UTaj7IIgPbC7+hvkUk9eqOfc=;
 b=t8UjZaIWTNOCwjV4sQZlkz0syT1Z7I3JMiz+FGWfzhvJ8DWIW7SdCDf3i3nHs4kvxH
 co25YOKgUfwcdSx03/xJQhRYMLFuPtC8aKrjiCLgXGbG/HJTAT7jaecaH8NxNQhQOcJj
 lotjzTD183AJrGP9KzywG7/cpvog+I99nz8lM2nNhamfHIPMwG7y6xsABZ7AryABEW77
 dvf5tdm09eEKD1akqueWXekZ7VSgLaWwxzhkBXPrMs99+VVQMFSlt3t62YzW0qdScUzC
 lzPVnVrOOVNsK/18PuvVV+71MxMpOEH8Tjb+7MbwvdKcp7Qp4Eq1WDey6VGRnB3E8LEP
 G7Nw==
X-Gm-Message-State: AFuF++lgeNJeBy/oQEJhzDsj805A0aSsaHM7iSecDOi3M6zDngeT6WZk
 0Jz00IqEQ6wM4PkYiXnUP03l6nDPdtobWsJCltHCrt0Y5aCwsH569k3368p9iWtBtuQ4LNPlSZy
 3qLfgUnU=
X-Gm-Gg: AYBFou0W6EDRcHSbCU7X3FUumefVgNUb0h18rlJ9g8GNKiZQ4v8U9Pzdrkn6lczUr+r
 NyFEWEXsmzWdTuiB9R7yvM+RZvo+m9CiOoyHzeA0rNKBi1v1nllWsD6DclgZUzwW9twtwQUmBwu
 ZQ3VTnTN9oHb50X5E9hcyimdhDX3pZsETw3kpE5BgEBFWhsS9a4dGqekqighYczKUjG142+aN/V
 +1uzGcLnwJcnkVl6SrJCeXsbFX0gPT7HsXaTUcoDsO4i/fY6VYB0iILwFF83aq/ajtW5YeqfaHa
 qV1EOXy/iVIsXmht7ZT4Cj92WiRwXzbZ9OQYHi2fG1A3feC2JgVA+IfhBxI5mb7FrGr4KO0M+tu
 ku2LdsYeeCUCxu0+xQIFmj6GsZh3Nlgh0tFKVmBXL5s0vIsnCrMrNr/+YP5fYgyG5HfFIWqXhkD
 95cgq5XF1NMBLQKNQXPusLYUbP6tGq6M8prlj2vL66SBLf5Y1Fj2PGPX+ApbDkdRJbvCDFuA3WC
 ZW0N7s=
X-Received: by 2002:a17:90b:384c:b0:39d:8794:5564 with SMTP id
 98e67ed59e1d1-39e1e48a48dmr11179797a91.12.1789619758041; 
 Wed, 16 Sep 2026 21:35:58 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13ee7sm10764267c88.8.2026.09.16.21.35.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:35:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 087/101] tcg: Use unsigned for flags for bswap and revbit
 operations
Date: Wed, 16 Sep 2026 18:28:09 -1000
Message-ID: <20260917042823.542588-88-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
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
index d58d1c81c4b..fcdee7be963 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1415,7 +1415,7 @@ static void gen_bitswap_i64(TCGv_i64 ret, TCGv_i64 arg, uint64_t mask)
  * With TCG_BSWAP_IZ, x == zero, else undefined.
  * With TCG_BSWAP_OZ, y == zero, with TCG_BSWAP_OS y == sign, else undefined.
  */
-void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags)
+void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, unsigned flags)
 {
     /* Only one extension flag may be present. */
     tcg_debug_assert(!(flags & TCG_BSWAP_OS) || !(flags & TCG_BSWAP_OZ));
@@ -1616,7 +1616,7 @@ void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg)
  * With TCG_BSWAP_IZ, x == zero, else undefined.
  * With TCG_BSWAP_OZ, y == zero, with TCG_BSWAP_OS y == sign, else undefined.
  */
-void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
+void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags)
 {
     /* Only one extension flag may be present. */
     tcg_debug_assert(!(flags & TCG_BSWAP_OS) || !(flags & TCG_BSWAP_OZ));
@@ -1659,7 +1659,7 @@ void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
  * With TCG_BSWAP_IZ, x == zero, else undefined.
  * With TCG_BSWAP_OZ, y == zero, with TCG_BSWAP_OS y == sign, else undefined.
  */
-void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
+void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags)
 {
     /* Only one extension flag may be present. */
     tcg_debug_assert(!(flags & TCG_BSWAP_OS) || !(flags & TCG_BSWAP_OZ));
@@ -1726,7 +1726,7 @@ void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg)
     tcg_gen_rotli_i64(ret, arg, 32);
 }
 
-void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
+void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags)
 {
     /* Only one extension flag may be present. */
     tcg_debug_assert(!(flags & TCG_BSWAP_OS) || !(flags & TCG_BSWAP_OZ));
-- 
2.53.0


