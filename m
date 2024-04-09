Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF6ACD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 05:06:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru3dx-0003Ek-MP; Tue, 09 Apr 2024 01:03:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ru3dw-0003EP-K6
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 01:03:36 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ru3dv-0005NZ-2v
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 01:03:36 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5aa3af24775so1068085eaf.0
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 22:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712639014; x=1713243814; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zQJasuYfr/HR9syiI0F0T/STtVHqGadJh9IMsrqhsDI=;
 b=YKdF3UI/MEvOTVvCXN+VHDR6YMs3bLADwxFH1WL5wVVaypER7gR2eZV7L9eJLyTVD3
 LvUSy9IXLLSyCV33TQMe+fyG9+7iZDRPyyiexa/HzctE+N7OWkZoLzj78ebbDVtns/mY
 DKUZKVz0HWuvIDPDnxvomryQqbRwQ5qFxqfMxmbVoV4nRJuhyoBtlxZO1/1DANbx4aqC
 Vpjm9vc9brmw6gXJ7vRQloJJKex7oa/4dRPsIFZLh0i/xXDsCVPJbE9yNrVXrTACW2iH
 CyBSyf+0YUqrTDrkQBz7oQVkTTWIbNOgthWwAjsnQM4cQjYPt+QGS6zwdRbn9zTaOdUJ
 y0Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712639014; x=1713243814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zQJasuYfr/HR9syiI0F0T/STtVHqGadJh9IMsrqhsDI=;
 b=smYSDeULV0LHmSNqZjw05CTORim/XCyXSZ4RQIA7PbcPAe5IpTy7E47Hpgh6+yl6rB
 HxmbpgKVHcVw3SLFBbdVZ5MIx+nxIdg5LQkAIOJAbR0dZPUyHVnnK4/uexwIY//+DgxC
 +kfvZWEoWEOuUo/P8EmxSIer07v42m/fj1/h1Q1Kxx53gpaIe6uVS1EXqjRZn/RP3Saf
 hEua1U8SUuispE2bo2h2q5VpLihigk1ks0T908cR5VPr3dQAvlsIUfli4WEi5Gi0UTvO
 2+1BoTw6u2Tytl1n6GR98L1kL1skfksN/00mBNPgbuQyzg1i6FZDFa2pxIxGSDBZkQ3k
 x7yQ==
X-Gm-Message-State: AOJu0YxsMkEOsfXa9cYk9i0wEHkj+Sc2e4V+Gt2CHwPw+IW5gX83klvl
 xtt0txWALLpH09t0qBIOxwSCabzt8BLZHGZRPWh10mKzxQlj6A6IsYPuxkFftH41BC7IBvhHtTk
 E
X-Google-Smtp-Source: AGHT+IEE7v8J93cvbpDav9KkXNaZvyxL/rwxb1rIAKkdOCvcbtx1R8lz55isSc2/vn15/8BF2vrpXg==
X-Received: by 2002:a05:6870:5ba0:b0:22e:c6b2:84aa with SMTP id
 em32-20020a0568705ba000b0022ec6b284aamr11776863oab.27.1712639014014; 
 Mon, 08 Apr 2024 22:03:34 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 z26-20020aa785da000000b006e64ddfa71asm7654894pfn.170.2024.04.08.22.03.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 22:03:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 23/28] target/i386: Honor xfeatures in xrstor_sigcontext
Date: Mon,  8 Apr 2024 19:02:57 -1000
Message-Id: <20240409050302.1523277-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409050302.1523277-1-richard.henderson@linaro.org>
References: <20240409050302.1523277-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc32.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/i386/signal.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/linux-user/i386/signal.c b/linux-user/i386/signal.c
index d015fe520a..fd09c973d4 100644
--- a/linux-user/i386/signal.c
+++ b/linux-user/i386/signal.c
@@ -612,6 +612,7 @@ static bool xrstor_sigcontext(CPUX86State *env, FPStateKind fpkind,
     struct target_fpx_sw_bytes *sw = (void *)&fxstate->sw_reserved;
     uint32_t magic1, magic2;
     uint32_t extended_size, xstate_size, min_size, max_size;
+    uint64_t xfeatures;
 
     switch (fpkind) {
     case FPSTATE_XSAVE:
@@ -628,10 +629,25 @@ static bool xrstor_sigcontext(CPUX86State *env, FPStateKind fpkind,
             xstate_size > extended_size) {
             break;
         }
+
+        /*
+         * Restore the features indicated in the frame, masked by
+         * those currently enabled.  Re-check the frame size.
+         * ??? It is not clear where the kernel does this, but it
+         * is not in check_xstate_in_sigframe, and so (probably)
+         * does not fall back to fxrstor.
+         */
+        xfeatures = tswap64(sw->xfeatures) & env->xcr0;
+        min_size = xsave_area_size(xfeatures, false);
+        if (xstate_size < min_size) {
+            return false;
+        }
+
         if (!access_ok(env_cpu(env), VERIFY_READ, fxstate_addr,
                        xstate_size + TARGET_FP_XSTATE_MAGIC2_SIZE)) {
             return false;
         }
+
         /*
          * Check for the presence of second magic word at the end of memory
          * layout. This detects the case where the user just copied the legacy
@@ -644,7 +660,8 @@ static bool xrstor_sigcontext(CPUX86State *env, FPStateKind fpkind,
         if (magic2 != FP_XSTATE_MAGIC2) {
             break;
         }
-        cpu_x86_xrstor(env, fxstate_addr, -1);
+
+        cpu_x86_xrstor(env, fxstate_addr, xfeatures);
         return true;
 
     default:
-- 
2.34.1


