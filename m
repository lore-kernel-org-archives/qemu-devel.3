Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB88CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 05:05:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru3do-0003BK-1G; Tue, 09 Apr 2024 01:03:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ru3dn-0003BA-9y
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 01:03:27 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ru3dl-0005J1-Nc
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 01:03:27 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6ed20fb620fso1747930b3a.2
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 22:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712639004; x=1713243804; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6eUFt2PWahbI/Q/BaP9MYWhwnfohtu4MmJvBHxZyZEg=;
 b=rsZ02lZZmNmC6hZQ53L05GcpCHmXoK5xrN2CrOPrhqR0DCKdnhUsg0SVGFGrRaxe/m
 JUF8Kh5PUd6yYZ4WgVRgFFYGocPMevD0Dqc5/m8zlWIdE78OcOVTuZ6QdzSEydE0jTS2
 n0sX/cgSVoJjC97k4Cq1BdAoOxCmZ5zGRy5H+GDXuXjlTV8HKW40kYyg/JGNfCik+9Fa
 wh8mcbpJwLdDbqkTXskuY069t9B77W69zh3RJI6E97rLt0aU6Ez/sfHHVaQgY9LAfAER
 3I6RworKQ3zCUyJGVgkqrXnUqivgqVvhD/OmiQ0XMT3u9SCN/tlWNIk38ACS85e6/emP
 SU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712639004; x=1713243804;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6eUFt2PWahbI/Q/BaP9MYWhwnfohtu4MmJvBHxZyZEg=;
 b=XsyB7ph31jfMWugUuqTkAWkX+MXjNP2oG+sLDMZgmEgCsksyDVmXZU2wWgB7EdAWD1
 Y0yU13sEu/0rTj/1CsHyMpyP493enPNnT63WULC6fVOQQU9c51gQuxTz9yp41IltWIK/
 Xe2ko41AYL9BX5rg3nmxfCNQQH8H1OcNY2d29vGOBuS91NKmcZHoiEPn1XgGPDLZKpcW
 oEVocs7lj+ySP+JDnLgWHuDM4sqh0bp4b30LgJkkXnQI9swIGKzswQgL3La6RI5wOZov
 klHWdTjm8oLgKDJUOtP2FhPDXmWsiLY2LSAx+xfgD9n1/wuY5TpFoj2pXkUAvo9S34Fk
 8dBA==
X-Gm-Message-State: AOJu0YxOGzgkxZWYYUyCtUPPXSHvmoOEYdI1SfPmRXZ5uKCMmXwoPrlo
 TTjq1oX518WY6rmqwU+hoQ/FxSn44uaD4wqq0wLYaFi2rGxaaEHpvQJRkIJ2FkMOhifTFLkLN6G
 A
X-Google-Smtp-Source: AGHT+IGzEnXyKXM7crOSOAu+LTrTajrQSLtLsCbJyM8v55oyJ4PEQIZM+wmvPzxjK4cNzm+86127HA==
X-Received: by 2002:a05:6a00:c86:b0:6ea:b9a1:63d7 with SMTP id
 a6-20020a056a000c8600b006eab9a163d7mr12510999pfv.10.1712639004231; 
 Mon, 08 Apr 2024 22:03:24 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 z26-20020aa785da000000b006e64ddfa71asm7654894pfn.170.2024.04.08.22.03.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 22:03:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 15/28] linux-user/i386: Drop xfeatures_size from sigcontext
 arithmetic
Date: Mon,  8 Apr 2024 19:02:49 -1000
Message-Id: <20240409050302.1523277-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409050302.1523277-1-richard.henderson@linaro.org>
References: <20240409050302.1523277-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This is subtracting sizeof(target_fpstate_fxsave) in
TARGET_FXSAVE_SIZE, then adding it again via &fxsave->xfeatures.
Perform the same computation using xstate_size alone.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/i386/signal.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/linux-user/i386/signal.c b/linux-user/i386/signal.c
index 68659fa1db..547c7cc685 100644
--- a/linux-user/i386/signal.c
+++ b/linux-user/i386/signal.c
@@ -252,7 +252,6 @@ static void xsave_sigcontext(CPUX86State *env, struct target_fpstate_fxsave *fxs
         __put_user(0, &fxsave->sw_reserved.magic1);
     } else {
         uint32_t xstate_size = xsave_area_size(env->xcr0, false);
-        uint32_t xfeatures_size = xstate_size - TARGET_FXSAVE_SIZE;
 
         /*
          * extended_size is the offset from fpstate_addr to right after the end
@@ -272,7 +271,8 @@ static void xsave_sigcontext(CPUX86State *env, struct target_fpstate_fxsave *fxs
         __put_user(extended_size, &fxsave->sw_reserved.extended_size);
         __put_user(env->xcr0, &fxsave->sw_reserved.xfeatures);
         __put_user(xstate_size, &fxsave->sw_reserved.xstate_size);
-        __put_user(TARGET_FP_XSTATE_MAGIC2, (uint32_t *) &fxsave->xfeatures[xfeatures_size]);
+        __put_user(TARGET_FP_XSTATE_MAGIC2,
+                   (uint32_t *)((void *)fxsave + xstate_size));
     }
 }
 
@@ -558,7 +558,6 @@ static int xrstor_sigcontext(CPUX86State *env, struct target_fpstate_fxsave *fxs
     if (env->features[FEAT_1_ECX] & CPUID_EXT_XSAVE) {
         uint32_t extended_size = tswapl(fxsave->sw_reserved.extended_size);
         uint32_t xstate_size = tswapl(fxsave->sw_reserved.xstate_size);
-        uint32_t xfeatures_size = xstate_size - TARGET_FXSAVE_SIZE;
 
         /* Linux checks MAGIC2 using xstate_size, not extended_size.  */
         if (tswapl(fxsave->sw_reserved.magic1) == TARGET_FP_XSTATE_MAGIC1 &&
@@ -567,7 +566,7 @@ static int xrstor_sigcontext(CPUX86State *env, struct target_fpstate_fxsave *fxs
                            extended_size - TARGET_FPSTATE_FXSAVE_OFFSET)) {
                 return 1;
             }
-            if (tswapl(*(uint32_t *) &fxsave->xfeatures[xfeatures_size]) == TARGET_FP_XSTATE_MAGIC2) {
+            if (tswapl(*(uint32_t *)((void *)fxsave + xstate_size)) == TARGET_FP_XSTATE_MAGIC2) {
                 cpu_x86_xrstor(env, fxsave_addr, -1);
                 return 0;
             }
-- 
2.34.1


