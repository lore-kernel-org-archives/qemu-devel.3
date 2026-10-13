Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00050CA9EDE
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 03:15:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGSyF-00007S-Pk; Mon, 12 Oct 2026 23:14:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xGSyD-00007H-IX
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 23:14:29 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xGSyB-0003Ul-R6
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 23:14:29 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-677d35fd1d2so2268538d50.1
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 20:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791861266; x=1792466066; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=68hSqH7Obq3adXkxpWVwEtldVIGLDOHAUecZc7LjqTI=;
 b=KUsCHfRhSGK0n3LwTrYofyTihCQBWbWjpxmmxv7cibKD41z9QODWAbkcKi1Rd49Wa2
 ciS+iEAw9TtS3M9jGWwnwvt2b12L2xD0nHcnji6HCDuoxKHg7Mf+ITqwAWlqrSXyqdTC
 Mn0jbGmS3LAoMqVo3mLW28AMbiZa9F5SUMq+7sj3reYBKUwEmUZTR7bRPOBU8yu7sR/9
 orMlfRt3PdqAT+GEunFCdlAXSekNqXxYnZWf/6GCybBi+YGcXNj1rVpHnIc7vI+45nuv
 QqZGkzb1fDFYpAUQtGh8GnMhMIW6Gj+ztIgaSqStEtao10Wrglh2gpPP18OQT77avBvo
 gsxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791861266; x=1792466066;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=68hSqH7Obq3adXkxpWVwEtldVIGLDOHAUecZc7LjqTI=;
 b=BJk4g8x6Njr8ZoZMN/yNX5vugP4/E/DA88RED0LOZNJtWCk8SDd9SgBwOSiBG1SqtJ
 wgH6suHcDpy5/irEcAgQ8y/tqHDUn6sibE4eC2Jyv2mAgCK0tvoYVBAZrpUx+6bjbwYH
 l3tyXlweskDvktHJM3/Sg3KRijTTW+MEC0Mv6Riod/trJkBzbf+DFgsN6p/eX+9ZmK4z
 aaN4smfebNDWCxV6BKSdBbpPshZ4GOZk3qll42qKubjT98Txk/6ri1ESRVVVwsghbkrU
 Ne3OVyXD61Y6ugXIdNfD6WXZm/sV4+N12vZZ2hjgFEWe74EhdmqCwvChDmaKmLTIkhRG
 w5YA==
X-Gm-Message-State: AFq9FYIL30Afn8zelMk69fH9P1XCmdq0qaOWmS/8jC7NUPCpciZG/IIo
 ReHkPULnohMhytHDqs1JfTtSLZdZTwkjktb42q131tk//eew73vBrSYf4os9Fw==
X-Gm-Gg: AYBFou1WWVmaeJQMQ3w3yTF7uD80qonNwDv4bL5vlyEHTyp33nNGTMAFkIHRxFESiPx
 UNbDDCftkjLxbL35bzmtoEhcIsQmjVws29LGy3rvF248LpDxL840RjoQ9WVpc2BVpI1PbtfUNxQ
 9fI4KphGhk/QD0YYjXVRXTpQKubXT+jD01e+ySWFaKp63iy4+9bc2AMKZfdcv16QazGDIpJqDv7
 k+L44q67DJZJK+zbHfBfcvpECheMrxCtNoRCaUGwOUnm/ObgsIol8MkTLqSmMfRA3G4uLhR183/
 HA02eaGX3PLbApSxEtvWJECRVlUnlxsoF6VtqC9P8sVcvXTiN9zsVHRggwpMG/WUFelO30cRr8f
 MTp2G4rGPIYYTtStcHX/17arZiUrp1qJJH/0SEhPlNIl5/8fueqZaxrNVm8P5H38hflZ4RlzYT0
 f1FjfvUxn2WK+RMMeU+V+iBRABEC+bI5HUmgF5HtYRG6zY5LN2eJ5XWjS8j8jnBsE6NyQfKsqXH
 KAhNin4v64v2w/t50O2Q8wvCfWqPAs5v8UWYDp7qud9yaHWzaIErlyq
X-Received: by 2002:a05:690e:1513:b0:66d:e3d:59c6 with SMTP id
 956f58d0204a3-6793600cd0dmr2982346d50.22.1791861266128; 
 Mon, 12 Oct 2026 20:14:26 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-679354e2c11sm4253965d50.3.2026.10.12.20.14.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 20:14:25 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Date: Mon, 12 Oct 2026 23:14:22 -0400
Subject: [PATCH 1/2] target/alpha: Record masked exceptions in FPCR for /S
 insns
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-alpha-fpcr-status-s-v1-1-bc7efa6d5609@gmail.com>
References: <20261012-alpha-fpcr-status-s-v1-0-bc7efa6d5609@gmail.com>
In-Reply-To: <20261012-alpha-fpcr-status-s-v1-0-bc7efa6d5609@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 Helge Deller <deller@gmx.de>, Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2097; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=4yaCMwkIG1VyvG/pVD4tFhFkyK89eVVf1KQZhpRKJgg=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLLOLuI90Ln036MZP8xDV7s86Xm47F/okxUGNQ/E9+rFM
 Mt/d+sU6/jIwiDGxTBTTJElbr0iy6y2HUt9Tkv/gpnDygQyRFqkgQEIWBj4chPzSo10jPRMtQ31
 DIEMHaN4iJweg0ZmcXFpapFuWkGRQ15+SWJJZn5esV5+QWpeQXqBXlpmWklGRn5RcSrQCL281BJ
 TV0c3I0MDE0tHCzMnC0dTE2dnJ0MnN0dHZ1cnI0tzEwNnS0cTV0tzBi5OAZhr0mcxMmx+kJ996+
 vUpac0nx93/Oc3lU1q45utweqT396cv0t3XRgPw19xr6zrRS/ajJ/1xAdXyF07GN+yY0ojm8EOj
 ecbns5OX84FAA==
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=mattst88@gmail.com; helo=mail-yx1-xb134.google.com
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


