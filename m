Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D85CCA46C
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 00:58:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHskg-0001L7-V5; Fri, 16 Oct 2026 20:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xHskf-0001Kk-Mz
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 20:58:21 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xHske-00010m-7i
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 20:58:21 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-6798d4ab549so572019d50.0
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 17:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792198699; x=1792803499; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DkIunV21cUzVdGY+O6vqW5yMBXiu3QheTjcP4l9v15c=;
 b=e0tUeZlxPy83AOhAqtz9n+iyqwDSVp2mWsadC5E+j9PMTiuQvKtCnVtSX8u7cB4Gah
 q1lXp0WgJYSkD3kRgsz+eZIVdNA7PRnPdBAfJ3PX49trCGS6hY2Xz3nkXuqgsisE7kOf
 8wN9/1k6MPismFfGSa0tXYzMEQMKVEu9urgOjXrNvCBHAp8xiSrDLj0+GL1ljGcDLJSt
 JyU16aZot2XACupWlueENnrTa4kzPYMFhTMEVBHlv6IzcdmFz5by2r+te6ctDtwHquYQ
 bD3KxedjShea9wKMcbpP+rXnJAphP/YS0rAir0BCs7Rh87G0W8AHJPB3RxgO7ODVRvT0
 hCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792198699; x=1792803499;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DkIunV21cUzVdGY+O6vqW5yMBXiu3QheTjcP4l9v15c=;
 b=UY4NdQj5TAHGD3GiIbm6vnjiLDMHWf6YCFO8as4xRZoi27J1bpSKRUw+dE04Wv3P/L
 qaFYgOgsxzk7qqEDnnEZsVhHd8AsKXlZJ0cdVbu/sn8RHgoSOOAnY5rePzZQ3btp9SmY
 WJ6sFLrQl3H3Q+tPbhX3kYjJvedn9Ruq2gqRN88Ayxd5pOEfvyVGSDcahOGBQTEwuYK4
 lTikM+5iTsgBrqhlxCyz9ySa83wNBPrPaUItSr9uSq8xrRpfvBbC5X7EnXvkwcUhK+Tk
 1STWkgPDjUb6JszIcxYtSBns+EONzLyL9A6KqNffLN5vgjOUULGMfuKRv2thPEdFPuQV
 mgjw==
X-Gm-Message-State: AFq9FYIFJQ2i32uICeRtytd2FhR1T8XcE1yrT8BFksce+2cU/VRTgDKV
 1G89xx/2hRphHa2ywaWlmslhgtdUNlHk64JWwWwLroka5KsICeP/cB5haqnTdQ==
X-Gm-Gg: AYBFou1a7lni15L34+tZdEV9sfj3eUMsGB0ECWdL75//0NMPU5Qde0/mHhTsijiJ8K5
 JZryBq/nHp7YW088RkHUwaWhQkuPB7mXNkMRj5upbYnrwkf3MRuukv+XCSxhTuGLn7D12nxXL/U
 nx0QCS7K3g0AGvz7AWu3AU//fbmgliqq1GDy9/fgiWFpP3zT8zN1bgKVSxSyrpsjUBOBNs7D8tF
 SYpyMdcrVVvdZpSILgEHjZs1tWJqgdMOc3gRf4ME1RooZ4vgKnnBOwV+SBuEb2mt9oQdpQHx2eW
 qTqZ/Q9YRVrsndvfrid284wFkvWGzpARTtWMqjDnyVYe1ljooipldgRTqbiIHnG7sfJnLBRZaFW
 POnMFW+CrXpZGPW1xkbPuxkzGWrdO3JPeDhzDshetGn0wxLjULU1OdcECbhVlv76tviywCoe4mQ
 j1oQcBLo/+Oa8u2bqLk8ofIPnTM8GnFRB117av38NTYRCcJuUF6S5/KcXdnzogHUMK2H3PI05Jz
 fz+6KJPtN/G0UD862tEcADbnva/zNGGhCTT6DNlT2WvOdn9/C+oaevxv5UywAUDHcIBejUSRjAU
 rwkZGyBPaPHShQi2bDr1qnXg6pPFU9JptsSbGdnf
X-Received: by 2002:a05:690e:191c:b0:679:a6c1:d70f with SMTP id
 956f58d0204a3-679ca4c92f9mr385349d50.2.1792198698578; 
 Fri, 16 Oct 2026 17:58:18 -0700 (PDT)
Received: from localhost (108-93-236-139.lightspeed.chtnsc.sbcglobal.net.
 [108.93.236.139]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-679b1f0784bsm1720484d50.19.2026.10.16.17.58.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 17:58:17 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Date: Fri, 16 Oct 2026 20:58:02 -0400
Subject: [PATCH v2 1/2] target/alpha: Record masked exceptions in FPCR for
 /S insns
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-alpha-fpcr-status-s-v2-1-4719bec02b3b@gmail.com>
References: <20261016-alpha-fpcr-status-s-v2-0-4719bec02b3b@gmail.com>
In-Reply-To: <20261016-alpha-fpcr-status-s-v2-0-4719bec02b3b@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 Helge Deller <deller@gmx.de>, Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2160; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=0pkxiGBvdw6UTe1mcPDHBrjEdVtSijf+h4dRRHjaC3M=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLIunZCapn/S/WKMCEfOkdANSyY+nHRK7rBOzfslrmF/O
 hRrax9M6PjIwiDGxTBTTJElbr0iy6y2HUt9Tkv/gpnDygQyRFqkgQEIWBj4chPzSo10jPRMtQ31
 DIEMHaN4iJweg0ZmcXFpapFuWkGRQ15+SWJJZn5esV5+QWpeQXqBXlpmWklGRn5RcSrQCL281BJ
 TV0c3I0MDE0tHCzMnC0dTE2dnJ0MnN0dHZ1cnI0tzEwNnS0cTV0tzBi5OAZhrdtxlZHj3SSbt79
 2mxK+y3//bbHSaOZn1k3M/+5rjnlO28x/OmveE4Z/Zhx8l967PiC58NC/rcJSOUtJ9Z59aCa7PC
 +0fvpOQ5+cCAA==
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=mattst88@gmail.com; helo=mail-yx1-xb130.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

The trap qualifiers (/U, /V, /I) control whether an exception traps,
but EV6 still records every exception in the FPCR status bits.  Commit
471d493047 ("target-alpha: Set fpcr_exc_status even for disabled
exceptions") made helper_fp_exc_raise follow this, but in
helper_fp_exc_raise_s it only added a second "exc &= ~ignore" and left
the mask in the initializer, so for insns with software completion the
masked exceptions still never reached env->fpcr.

The most visible effect is on inexact: the IEEE-mode code generated by
gcc -mieee (e.g. ADDT/SU, DIVT/SUD) has no /I qualifier, so FE_INEXACT
was never set.  Many of glibc's math tests fail because of that, and
the narrowing functions such as f32addf64 return results 1ulp off
because their round-to-odd step depends on inexact.

Record all exceptions first and only then apply the ignore mask, as
helper_fp_exc_raise does.  Which exceptions trap is unchanged.

Fixes: 471d493047 ("target-alpha: Set fpcr_exc_status even for disabled exceptions")
Signed-off-by: Matt Turner <mattst88@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/fpu_helper.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/alpha/fpu_helper.c b/target/alpha/fpu_helper.c
index 529eadca9f..643ce641e8 100644
--- a/target/alpha/fpu_helper.c
+++ b/target/alpha/fpu_helper.c
@@ -86,9 +86,17 @@ void helper_fp_exc_raise(CPUAlphaState *env, uint32_t ignore, uint32_t regno)
 /* Raise exceptions for ieee fp insns with software completion.  */
 void helper_fp_exc_raise_s(CPUAlphaState *env, uint32_t ignore, uint32_t regno)
 {
-    uint32_t exc = env->error_code & ~ignore;
+    uint32_t exc = env->error_code;
     if (exc) {
+        /*
+         * The qualifiers can suppress the raising of exceptions,
+         * but real hardware still records that they occurred.
+         */
         env->fpcr |= exc;
+        exc &= ~ignore;
+        if (!exc) {
+            return;
+        }
         exc &= env->fpcr_exc_enable;
         /*
          * In system mode, the software handler gets invoked

-- 
2.55.0


