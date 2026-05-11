Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9176CD484C
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 14:04:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMRE1-0005Mg-3W; Mon, 11 May 2026 10:03:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1wMRDo-0005I8-9Q
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:03:03 -0400
Received: from mail-qk1-x72c.google.com ([2607:f8b0:4864:20::72c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1wMRDm-0006Vx-G3
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:02:59 -0400
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-8f231f3b130so323184585a.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 07:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778508177; x=1779112977; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Z0It7ZRSCTmVvD9ADLP48nXZfmNmQA+tr9NQ0jfyGKw=;
 b=o2tTHkfgAYwHIVIfM09K1zno74ald0u0VTcd9cDAvjr5OTgfwGHUJ9+5mNXRgvfClF
 yyNZhAYfcc2qEqcJZ5pEHqmbxxGt1FjUqXhYczP2LF+KIxwGl81O6NQy+8VtYoZIv24e
 QIrSpbu/tIdXRHmFZ2IM0g0KhglGETKsr2EjLE/ODHTdXC/owHAucLzvEuvB0HlmrUuf
 kC36aMeXn6RRXYhpv0A9NBIVqIbmW/bHriwxdylib8XMX2vxkT/jIw7i58GWXFys/2Jr
 7rJEGngsu19cKai3bJ+izt4i8jjqADkEEuw2XSYsM68dFlBSSMWbDga8aozSlQlAAPWw
 NOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778508177; x=1779112977;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Z0It7ZRSCTmVvD9ADLP48nXZfmNmQA+tr9NQ0jfyGKw=;
 b=OuyCSUHGCXeGuJJWRHfngEFZaG0wjlSz20ekYEKtDx8E0+YDrzp/hV+tYfJcw2bikG
 0k0nWwNqII285xA71WS+pGXXz0JuhTKogizSPq7LnKi1fvCi2Gsy6rANBsqZn8kaS75A
 btnlAVv/++xcAd9XRYOaIPhrOZaWVwDfHyhVM1OnIk23TwAcqIghiWUKDfzCxSHacNFZ
 eJshFv86JVs+VqhHz/RG/+ET/fB5JpQ6DHaDbGCB5Lq181POhqrmAYm0SjTGa9AUpndQ
 /RTTWYJ++6Q/rs2OmADT96YE/2Dp+ZllEBFLIbWbLXxV4FDJqPkz7xopeUE4KVaJjhdH
 qD7w==
X-Gm-Message-State: AOJu0YxMRPMsm33d+kMNBlGTQnwnOraHQOUkO74O7hVmKwmb7x/nuW1B
 Ub4zWrHFJlR0GvrwiwQRqm5Jo3Y2dC40QaByztyuBapMYOk/XkXnVEaN
X-Gm-Gg: Acq92OFvH0dsPvLm+bdfZ8iV1ZU4i3wNMj643Wm5sZh7o3INFu6/NHw49sifUdkTfXK
 UUjugkI7manXBkT4M4AN/EjLl3J7fhS/3EA1maQdx2ftezHZ7iuOdPCjGhmsBRtEBu1bra/5XAn
 BibifkBHyii/aoRfi7fKIv938U5RDiuFQMRwiBMz1Q/r8qjPWiNtWxTVdm7VwI1Ez0Abu1NZz6w
 LhU43Z1/X3HOUMd8FholJUuY7pglURNL3NJHPNKb5LQWrfmW9XPLAJrKM4lBEA2yRBVgwfqsHUa
 4qJIQyPKGEQNLGxJP+YSsB9wunvQnOPAZbilxLgJ3mkoj0VAZj62eLE609tVVvtL7EvrohG+RXu
 ax6xfeeiTh4AkrQZmT5VTiIGv0++vzJ8PbeLidPzZKAtXsIB5owStcSEuTssPQswV6/K4MBoa0Z
 E8F+n7nrrmSoFiLPyArUxvakIArw1TVMebVBaAeUjbWsv/b5iCQBg=
X-Received: by 2002:a05:6214:2b06:b0:8ae:655f:28a4 with SMTP id
 6a1803df08f44-8bc45c270ffmr360030436d6.40.1778508086545; 
 Mon, 11 May 2026 07:01:26 -0700 (PDT)
Received: from [192.168.1.160] ([2600:4041:54f3:a400:c013:3550:ed5f:a59a])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8bf39c7dd09sm94773756d6.31.2026.05.11.07.01.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 07:01:25 -0700 (PDT)
From: Gabriel Brookman <brookmangabriel@gmail.com>
Date: Mon, 11 May 2026 10:01:10 -0400
Subject: [PATCH v6 12/15] target/arm: tag is not a part of PAuth with MTX
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-feat-mte4-v6-12-8557cc1313b9@gmail.com>
References: <20260511-feat-mte4-v6-0-8557cc1313b9@gmail.com>
In-Reply-To: <20260511-feat-mte4-v6-0-8557cc1313b9@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, 
 Gabriel Brookman <brookmangabriel@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778508062; l=3172;
 i=brookmangabriel@gmail.com; s=20251009; h=from:subject:message-id;
 bh=RY4Y7584EbsvGKO7XdM6s/BdRq7/FYp1wZOaWE4e+g8=;
 b=wDdxEc5bBmuhLGAaiwwac1GCFN6HDD+2N0iVSfXtEx38PtsXzaLwpyewr7ePbIzKf/t+cp+ky
 u6OCE78UDb4Dvd1OGp0hTttbVthDOT4WUdcz2DKnwN1mu+GHkHFuI/Q
X-Developer-Key: i=brookmangabriel@gmail.com; a=ed25519;
 pk=m9TtPDal6WzoHNnQiHHKf8dTrv3DUCPUUTujuo8vNrw=
Received-SPF: pass client-ip=2607:f8b0:4864:20::72c;
 envelope-from=brookmangabriel@gmail.com; helo=mail-qk1-x72c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

As described in the section on MTX, tag bits should not be used to store
or compute the PAC when MTX is set. See also Authenticate(),
InsertPAC(), and Strip().

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h        | 12 +++++++++++-
 target/arm/tcg/pauth_helper.c | 18 +++++++++++++++++-
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index d313d36603..31b7e1c85e 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1809,7 +1809,17 @@ static inline uint64_t pauth_ptr_mask(ARMVAParameters param)
     int bot_pac_bit = 64 - param.tsz;
     int top_pac_bit = 64 - 8 * param.tbi;
 
-    return MAKE_64BIT_MASK(bot_pac_bit, top_pac_bit - bot_pac_bit);
+    uint64_t mask = MAKE_64BIT_MASK(bot_pac_bit, top_pac_bit - bot_pac_bit);
+
+    /*
+     * If mtx is enabled, second nibble is not part of PAC. See
+     * InsertPAC().
+     */
+    if (param.mtx) {
+        mask &= ~MAKE_64BIT_MASK(56, 4);
+    }
+
+    return mask;
 }
 
 /* Add the cpreg definitions for debug related system registers */
diff --git a/target/arm/tcg/pauth_helper.c b/target/arm/tcg/pauth_helper.c
index 67c0d59d9e..3d83ca4c3c 100644
--- a/target/arm/tcg/pauth_helper.c
+++ b/target/arm/tcg/pauth_helper.c
@@ -342,9 +342,16 @@ static uint64_t pauth_addpac(CPUARMState *env, uint64_t ptr, uint64_t modifier,
     }
 
     /* Build a pointer with known good extension bits.  */
-    top_bit = 64 - 8 * param.tbi;
+    top_bit = 64 - 8 * (param.tbi || param.mtx);
     bot_bit = 64 - param.tsz;
     ext_ptr = deposit64(ptr, bot_bit, top_bit - bot_bit, ext);
+    /*
+     * If mtx is active but not tbi, then the top 4 bits are replaced with the
+     * ext bit, while leaving bits 56-59 alone. See InsertPAC().
+     */
+    if (param.mtx && !param.tbi) {
+        ext_ptr = deposit64(ext_ptr, 60, 4, ext);
+    }
 
     pac = pauth_computepac(env, ext_ptr, modifier, *key);
 
@@ -377,6 +384,11 @@ static uint64_t pauth_addpac(CPUARMState *env, uint64_t ptr, uint64_t modifier,
     if (param.tbi) {
         ptr &= ~MAKE_64BIT_MASK(bot_bit, 55 - bot_bit + 1);
         pac &= MAKE_64BIT_MASK(bot_bit, 54 - bot_bit + 1);
+    } else if (param.mtx) {
+        ptr &= ~(MAKE_64BIT_MASK(60, 4) |
+                 MAKE_64BIT_MASK(bot_bit, 55 - bot_bit + 1));
+        pac &= MAKE_64BIT_MASK(60, 4) |
+               MAKE_64BIT_MASK(bot_bit, 54 - bot_bit + 1);
     } else {
         ptr &= MAKE_64BIT_MASK(0, bot_bit);
         pac &= ~(MAKE_64BIT_MASK(55, 1) | MAKE_64BIT_MASK(0, bot_bit));
@@ -424,6 +436,10 @@ static uint64_t pauth_auth(CPUARMState *env, uint64_t ptr, uint64_t modifier,
     cmp_mask = MAKE_64BIT_MASK(bot_bit, top_bit - bot_bit);
     cmp_mask &= ~MAKE_64BIT_MASK(55, 1);
 
+    if (param.mtx) {
+        cmp_mask &= ~MAKE_64BIT_MASK(56, 4);
+    }
+
     if (pauth_feature >= PauthFeat_2) {
         ARMPauthFeature fault_feature =
             is_combined ? PauthFeat_FPACCOMBINED : PauthFeat_FPAC;

-- 
2.54.0


