Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C30C3A59D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 22:01:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsrcC-0005tP-7S; Fri, 05 Apr 2024 18:00:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsrc3-0005rL-9j
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 18:00:43 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsrc1-0002TN-Fq
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 18:00:43 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6ecf1bb7f38so1880814b3a.0
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 15:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712354439; x=1712959239; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=xtbJ/p7JEFHTppWK8T4w7KJEZi+x0bHxbuO/ApHynWI=;
 b=RAKOM067L3kxKcc7Ohzh/tCl3s6ci/XN2B48a8w2MS0Kh1sLrPOUf4whBWFBerzCpI
 e5qX/dq8u4FBz0v1wObZp6epnQ076yvUSNkte1jiWoBlccPu5RUL/MTX7OLKF6r8pPPt
 F2xhMofBuJ+d5F/eJR/t8u6Vom3O48AQ4PoTxMIC5hQnCXmgBmjxNOP7NAZF+kbFeL1D
 rwTrpHH43kfkv4Di528Eth8yIDY410jD2TXjoA5MxGDQSOywUpwB86DjzhdhV0/NCzwE
 BPxak+Etmb4EUbVZp5mtuqPG8jt4fw7isAIxiR3rFvfcJRgyIi0C7Nnmr/7bziz3gN9j
 DZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712354439; x=1712959239;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xtbJ/p7JEFHTppWK8T4w7KJEZi+x0bHxbuO/ApHynWI=;
 b=iyEtcbOKtXEHSFITay/kZ0fBb0lcFYBEPl8n/nhPQbZeIgGU6l0AAQRuQmftlWtNM3
 RBzhd/at9celCVhjMg4HkYKKF40OktUBNE0DUd9qAcIysyev/GRMbvpus8i5NyQKODqx
 V8Fsx+PeOW4s9ZzjKfQWKuM+uQfND0/n/j4P1xIxY+68rBv1tqN3GD7OtIXRMwxPiXY4
 6fVS+3Y6YYcFwpB2ccR3l6lrIY8NwtNEg5DGakPT/KV8LV2LEkq6WHYimPBHsINlhxBp
 sbCzdrsy5NXbwCQPNHxI4LZ31l0EJjxVJ+FLZngedCgLPwqCfNlVfyhRjw90KwPVjaIX
 HbFA==
X-Gm-Message-State: AOJu0YyfoLzEgmjI12O+WEXDRyTb6P6ce9ZWQ5vyerlJuiXyO6gvtOKj
 Q80/y1OmaEqp0swtTQuKiEfUZ1cBhgP5lO8W8gztXkdCNByeyDRxyMPiIGVeFv3a7Xi+KHHsICA
 m
X-Google-Smtp-Source: AGHT+IHZ7Br/xiCW0R56MksNzgZLX3aF6eXbLCBC9mEd748eDQ4Gxwb61xP0xogHx2zYLWq+zs5b9w==
X-Received: by 2002:a05:6a21:4987:b0:1a3:c604:8486 with SMTP id
 ax7-20020a056a21498700b001a3c6048486mr2435130pzc.34.1712354438811; 
 Fri, 05 Apr 2024 15:00:38 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 z11-20020aa785cb000000b006ece85910edsm1988831pfn.152.2024.04.05.15.00.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 15:00:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-9.0] linux-user: Fix waitid return of siginfo_t and rusage
Date: Fri,  5 Apr 2024 12:00:34 -1000
Message-Id: <20240405220034.5128-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

The copy back to siginfo_t should be conditional only on arg3,
not the specific values that might have been written.
The copy back to rusage was missing entirely.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2262
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index e12d969c2e..3df2b94d9a 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -9272,14 +9272,24 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_waitid
     case TARGET_NR_waitid:
         {
+            struct rusage ru;
             siginfo_t info;
-            info.si_pid = 0;
-            ret = get_errno(safe_waitid(arg1, arg2, &info, arg4, NULL));
-            if (!is_error(ret) && arg3 && info.si_pid != 0) {
-                if (!(p = lock_user(VERIFY_WRITE, arg3, sizeof(target_siginfo_t), 0)))
+
+            ret = get_errno(safe_waitid(arg1, arg2, (arg3 ? &info : NULL),
+                                        arg4, (arg5 ? &ru : NULL)));
+            if (!is_error(ret)) {
+                if (arg3) {
+                    p = lock_user(VERIFY_WRITE, arg3,
+                                  sizeof(target_siginfo_t), 0);
+                    if (!p) {
+                        return -TARGET_EFAULT;
+                    }
+                    host_to_target_siginfo(p, &info);
+                    unlock_user(p, arg3, sizeof(target_siginfo_t));
+                }
+                if (arg5 && host_to_target_rusage(arg5, &ru)) {
                     return -TARGET_EFAULT;
-                host_to_target_siginfo(p, &info);
-                unlock_user(p, arg3, sizeof(target_siginfo_t));
+                }
             }
         }
         return ret;
-- 
2.34.1


