Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36543CD1299
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 19:38:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruHGP-0000XX-8c; Tue, 09 Apr 2024 15:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ruHGN-0000Wn-Sr
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 15:36:11 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ruHGM-0004cn-59
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 15:36:11 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1e419d203bdso17890705ad.1
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 12:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712691369; x=1713296169; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WEK6zSUurL5c5k/x0P2XhXs6AUgqTg+iWS/4jd0p2Dg=;
 b=Z8qCRVXM4cOfMlTJalO+eP7UjsmthD+Uf33jk4cfqo6BX73sA8IY95nlulHTpqqVsT
 W5f8iLmtOomkFt7Or+aDNGZB6gctUX028Bf2Km7py5E9MxPoEZXx+ymcDrtfPCo/Uwmt
 jAK4iUQf0qG7zAJwtpsLkFpNhcTnM+bX5vqSp6y+Ck4Aew47OzWM0lxlTaBGGt14HP1x
 Q2ay9wJFqRJZDqPbNncH49IWYAyTGC6lrrFDnGOjTB8PjBbkd3OwH4WOhJ1IjBAcHwEU
 mZlnrv9hOQsa/35+VyPqrtJREpqeDbecKcd2xHKKrkAbhUlE4s66W/povDyeFK7GCD34
 nsbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712691369; x=1713296169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WEK6zSUurL5c5k/x0P2XhXs6AUgqTg+iWS/4jd0p2Dg=;
 b=lppAkZSkxXCeg9yWBRv5FLbG1n65NW9wQBAsC+paVoGTwVgmJmeQEBzN+joDtZFTCh
 hqc96KhaHiWSj/x7UEZhgID5yKJqGXcQjQaJUTitOL79AkRqE3+fe084BXx9uAZpdb1b
 HV8yzcNxtyL9aDmbaK5TVIw+PDHNoT9C1MeG6aE6c7vpXrRIxFrvqE8nTAD3OWbSdBnj
 5NKYWDPj+gicNt7x9/uGpb9YVjvwmrWrZWmTTjOu/CmWyFcbgLJZ2po+ws2Cn43reurz
 kQkKws6VtJE4GCuO7WOS2+mRjyS2clDlhrYgvNBJptiMwz8U8XrEz/Tw4DRKBKFMiL4v
 sIaQ==
X-Gm-Message-State: AOJu0Yw+80XoCBTBGMaHmI17kLbhYCCUOLUVz9m/8Uc3QJebEAwqmRK8
 kqiVr4Rf87wEg/J6zIp7lR46TdwCg1yAeMupZ3SR1egc5Y5r8gw9RfrYL/DmUsp+6GtkoJ2bmY7
 a
X-Google-Smtp-Source: AGHT+IFEplnRbGJvD2WUEIIE//yGm2A/93PXhxONYKf3QUdzTJIdc9VSzBDxzgaFrV1MJeKZ9UNYDA==
X-Received: by 2002:a17:902:c405:b0:1e2:7015:6a1d with SMTP id
 k5-20020a170902c40500b001e270156a1dmr887279plk.60.1712691368681; 
 Tue, 09 Apr 2024 12:36:08 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 c17-20020a170902d49100b001e1071cf0bbsm6065843plg.302.2024.04.09.12.36.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 12:36:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alex Fan <alex.fan.q@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 02/20] linux-user: Fix waitid return of siginfo_t and rusage
Date: Tue,  9 Apr 2024 09:35:45 -1000
Message-Id: <20240409193603.1703216-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409193603.1703216-1-richard.henderson@linaro.org>
References: <20240409193603.1703216-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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
Tested-by: Alex Fan <alex.fan.q@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


