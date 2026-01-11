Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E600DD2502E
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 22:00:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vf3Sd-0005Rp-FT; Sun, 11 Jan 2026 16:58:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vf3Sb-0005RE-R6
 for qemu-devel@nongnu.org; Sun, 11 Jan 2026 16:58:57 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vf3Sa-0003u2-9o
 for qemu-devel@nongnu.org; Sun, 11 Jan 2026 16:58:57 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2a09757004cso54072925ad.3
 for <qemu-devel@nongnu.org>; Sun, 11 Jan 2026 13:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768168735; x=1768773535; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O3EB7qIEaNPc7salkmu1WZ3Rl3gRT11tXN+JnGgXxZw=;
 b=fmR0dgWwdgeOKX3YoA2ze+KUXbJ4NpIPVtB+aK7EnLcGF4t2l4R765v87YFPGbv0iM
 4+D8dCdDFVeQ+X0vXJjrVru9iPSDqdYtzvt81LYkuN5XZ+0pmX+2l1jwEvyaeq2nSDAP
 AEJ5g0T5Pk1l+3eqFW2WALwrbSqfSZrkW6tumN0oAd/GCyQRW9/519QLEJkTK82jsXuH
 bZq225lK8kIGN76vp//5sDEoVx1bSx/x162n8FtQvRNUacfuBEArEmDlSOiuQnJL4J+n
 Gabbq1TmkzubDfXlwr7XZ5Q7sUv7U0t+zLNhdjAG/G4a6p0ZN/EUcsdMfLdqCEuzr9l+
 I9RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768168735; x=1768773535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O3EB7qIEaNPc7salkmu1WZ3Rl3gRT11tXN+JnGgXxZw=;
 b=BtHynotDyHwJoFIZRDrdGBwFnOncW/oa9svXFBWR31bm+w6jrkfwH0zrCSPlKslndi
 vxSXE/e0nGw78nPjp8jdX3FE1k7+//BzmXzCtxeduE9SbmY4OL37TKBLK6FfM2uAMyrC
 1CUTFw6rzxMPBZZRz/y0bXj1K0j1fxYATIIZNnLdOSsEpyYJBSMmaa3T2QDcM2oVX4sS
 QKCgpYHN8co4Nr83pnchv1dunt3WMEEWsq57r5CSutcyteS7EyRa+CzbiDmOSv9fQphK
 uRn01LRzIcLjA7kHrtgKuavUlXDVSt+36CWV+wAH3E9dTFPWmvhpymvUNKn2+zkdSvuT
 Q4Ow==
X-Gm-Message-State: AOJu0YzCZYKZvyIR794itAtkPSGCswVaqvF7dqAy1j3K+dJ6FE0eC411
 PSpgQSJccBwp5ZNGwGbaeRNLWJNiFj/AeuxsXAYQKW41FxhIPOrCbrkg5sAisjY5IGs/gzOY2Ix
 8zgZkFYY=
X-Gm-Gg: AY/fxX4cojQHlGApo8TvDXB3hQPExnURdDrR1bKFGdFuDbcQENHEdVcNoDKkwQJL5CR
 HGUVa61fBqO4Fk2toSZla538a8vJn5d5wnLnGSGzfMcmTCFfadruLnUdr0NmiX98PpxgKL2PXTc
 4A8fuS8tnJKXJuLciTcz2JdFQPSqLuBDOCC2uRVd3KNb+W2MiZ4ty60lQ5+e+VdV3kJ7yy4Pf8K
 WWTxNqrkGLHuLZauIDOhQcx7eAWT02RlrAfvwpAm/EMB7Z4yZ7ziF0+rXKqrdApIY18OCWDptq0
 X4+ONfkCf4WLacvlnGGktRFaWmqBGN+Y7n8RtmYokYork7rg7hBeAeFtb3EulHRMl/3l0WkRX/x
 WUC4TNUh28yYWU/5hZtsPfO/0oxxtdUe43XVcdmZqYe0hWOkNaAifnjh7mxpsqDZ8DQ8hn+vcNZ
 Gfd0bophTTAJL8oc0=
X-Google-Smtp-Source: AGHT+IGmgF0edlPjiaIYeeWovDxcsPMEpvj1lEuLwKNpSAWJ/3/BcGq4YbZC/RS3eFKpS0Kl03wz/Q==
X-Received: by 2002:a17:903:1a6b:b0:2a0:de4f:ca7 with SMTP id
 d9443c01a7336-2a3ee41516dmr158599705ad.1.1768168734799; 
 Sun, 11 Jan 2026 13:58:54 -0800 (PST)
Received: from stoup.. ([202.86.209.61]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c3a31dsm155272365ad.9.2026.01.11.13.58.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jan 2026 13:58:54 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 11/13] linux-user: cleanup epoll_pwait ifdeff'ery
Date: Mon, 12 Jan 2026 08:58:16 +1100
Message-ID: <20260111215819.569209-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260111215819.569209-1-richard.henderson@linaro.org>
References: <20260111215819.569209-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

From: Michael Tokarev <mjt@tls.msk.ru>

All linux targets these days have epoll_pwait system call
(while some miss epoll_wait, which is less generic).  And
all linux targets definitely has one or another epoll_*wait*
system call - so whole code block dealing with this system
call should always be present.

Remove the now-unneeded ifdef'fery.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260109090937.599881-2-mjt@tls.msk.ru>
---
 linux-user/syscall.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index ee7c34027e..2c7e1eb5b2 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -13619,13 +13619,10 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
     }
 #endif
 
-#if defined(TARGET_NR_epoll_wait) || defined(TARGET_NR_epoll_pwait)
 #if defined(TARGET_NR_epoll_wait)
     case TARGET_NR_epoll_wait:
 #endif
-#if defined(TARGET_NR_epoll_pwait)
     case TARGET_NR_epoll_pwait:
-#endif
     {
         struct target_epoll_event *target_ep;
         struct epoll_event *ep;
@@ -13650,7 +13647,6 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
         }
 
         switch (num) {
-#if defined(TARGET_NR_epoll_pwait)
         case TARGET_NR_epoll_pwait:
         {
             sigset_t *set = NULL;
@@ -13670,7 +13666,6 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
             }
             break;
         }
-#endif
 #if defined(TARGET_NR_epoll_wait)
         case TARGET_NR_epoll_wait:
             ret = get_errno(safe_epoll_pwait(epfd, ep, maxevents, timeout,
@@ -13694,8 +13689,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
         g_free(ep);
         return ret;
     }
-#endif
-#endif
+#endif /* CONFIG_EPOLL */
 #ifdef TARGET_NR_prlimit64
     case TARGET_NR_prlimit64:
     {
-- 
2.43.0


