Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5662CDB466
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2026 04:25:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wb9i2-0003vS-Hq; Sun, 21 Jun 2026 00:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9hi-0003Ez-4g
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:22:42 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9hg-0005R9-O6
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:22:41 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-69ed219d3ecso2366389eaf.2
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2026 21:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1782015759; x=1782620559;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RvOtNE9D705DF6qe5L1DaLnOftJE4cjWn/xE0Uo76dU=;
 b=SN8FZWODsn3p5xH1ssxXahHOv/lCVSNcU2oB6bvpOPebNdOiWvjFCZK9IKWGV+5Lt4
 uXS9qYyacKVlSf3GUNihb5mLljSdX4jDV6rFzoK/2Ql8wRP8gCcCGmbPT6OZAff6HyrV
 FtZkpfZS0iJbctN6UzMmtMzlbmVlfwdFGQLcIUm8dK6ez/kBzGIlxcgDvl7Re0dXfbaY
 7WWPKcQwOuXRdGnHUYStEPDOky9pHH9+N3X4YSiyUYJSSLoszlXc6Ve9NlUw7+MOvZ0n
 DhKIb7NxYu3TKd82PBEeDIs9vZDC+FYWvT64RyWiqBFrs2VO3Aa1aRwPs8gJepIhU/Sp
 VQWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782015759; x=1782620559;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RvOtNE9D705DF6qe5L1DaLnOftJE4cjWn/xE0Uo76dU=;
 b=XAVl4/YgI9YgYRV5N43ZHdTnc91OmGM4x36iW475KbYkVNJh5gyqF5d6TEJDMHOM4b
 Vn7ryZWHPzw5Cb/je/l5547Sqxzz8Wjbrc5rkZvKDShKXN5vgdgw9nPtxQl4VFEYWUrR
 pTm+xeAOyAlanlDIwUlEzSq9AW683zV/MTujcEwAclNy1MlEHX8ASFveU7+DiY6Tb/Xp
 jRWpoMcJ5zkXH1bNnF3bXJPMeohSy29W1rxly+VRGjge9JynWRF8DmtzqNts0rAGN0xO
 nenGeo2ktr+M6MOQObWS87rtgDBLgKY1F/iM4CGtaZvAcN4or86H8aDlk2oCJxh/v9YS
 yDUQ==
X-Gm-Message-State: AOJu0YxypPSU6nHLY6y+60IOGXaQW1+etnwnn6wRY/j73bU4nWy+Hd9A
 qw4aHKHjRkn81h8Pjc4v8gghcqNIvbu8VZbBZCJxBNQB4NG5gkiOWD217X++KsqJhRjjoL7DdZj
 VpMFOVxp4Mg==
X-Gm-Gg: AfdE7cl2V3dyXE8h6A4pqpnhJIfVna2YkF0oEX6hLHto8TezDkoEEvNeGWssf77qKgN
 WJAGgdcJh2IyjHMamDuIF79ok5gZnFcoHd3plePsBHJWSFwWBZxM9nZobwCF7xzf9Z8pvGkK5Sd
 JbNfCV7b4gsd/WPPLE92HfiVqv91S05vuO9NLKXmowQP6HJul1vXbxLX00kr3mjsOFBUaHXSkrj
 sm5kytBMNDq4J0V3SII+2B1FtzEfRv75566pMb2P/9rppAALJrhoFE0a1x02WfpKOufIA2yNOsB
 qc3WW5ys44NDrybWRNE16YJpXh+ZCWeBqdlxf3QI+/M4Ku2BJZ4Vq1KJbuDFw1gWSwesI/qx2kc
 u5UBmlGL+VxLpfe48Bl/xkbTjnbLOtHVHMCgUYT+a6akuG/s6GpoqlwSr88hNMDq6Y7tX3faws2
 o=
X-Received: by 2002:a05:6820:3415:20b0:6a0:e740:2497 with SMTP id
 006d021491bc7-6a0e7405d12mr3334846eaf.7.1782015759614; 
 Sat, 20 Jun 2026 21:22:39 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a0e9f698ccsm2828648eaf.4.2026.06.20.21.22.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2026 21:22:38 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 20 Jun 2026 22:20:27 -0600
Subject: [PATCH v3 40/40] bsd-user Update random_seed on thread creation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260620-misc-2026q2-v3-40-f6ce23ad8dda@bsdimp.com>
References: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
In-Reply-To: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1477; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=oLnkr1J1KnuwjBFmklS6zLgiFsxxXkqkrfGUH2CGy14=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqN2aBFj01DOcIn7HEQPUzqiL3vqKa719lSwBAm
 RmOAWkUsVWJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCajdmgQAKCRBsHNEofbAR
 AMfKEAC5HzxYHaLr9R03jmGFYzSDTaGetLYjGL3lNC6ZoXHkSl8U2p+1MN/70de/9s/gPFsXaWV
 S/wq/G+Iy1L16r3g41sd+m1WI1W3QK9up/ij09LLn1Jp022NJqB1OK2FaKsWhHcCwMWxiKmQTW8
 Akbn/iyy/jhEnv5pVIpSbYbQxsf1dua/AB3BS4qBzXFKsDMLVkDDgN3jvtLmZj4Cpy4vgeIff0a
 NxEVUntT/Vojdr8UQb0wnZM1iXzhcDLj7RUqtf+JRn1QzR/aOXIGdTBwbQkGJ2Xmi7DI/EJRlks
 EzkbsS2ME7RQ6+NBRX+dHgEB/mVzvR7FVDnpPL3vzu3deznBiUrCqXf1NI41n19izDjZS1xN5da
 26OwxIsTg+md2qBREFDTPJjyDyp7iw5PMrnLApsaeP3Sh54kB3NxoVDVXuzREJaVFjvVCApbaG7
 t43Gbzics1m/eiQqOzbU3/jz7E9gAyRba8JbPxVQ4xNV8IM1fxszf4Z09v9/+sQ5sTjPdgFea3l
 kKloRXTm8SvSpTscv+Re+5UcC+MVnQrwxNNP3gAc+e69DZNZVrjeJLqzDUcMDebjeEiXMg6LSdF
 HIo34E/Xm9ZuI6Wf6VO9h2QLFKsZoisQVa/vLOViTslCZ8wPUxXbtKjps4kaLLL5EE1MXa16kit
 EgnxEIiS7oVUYCA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::c30;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc30.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Initialize / update cpu->random_seed in similar locations to the
linux-user code. Set it just before we create the thread, and update it
in the thread startup code.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-thread.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/bsd-user/freebsd/os-thread.c b/bsd-user/freebsd/os-thread.c
index 63c17e10d0..15872f03fd 100644
--- a/bsd-user/freebsd/os-thread.c
+++ b/bsd-user/freebsd/os-thread.c
@@ -14,6 +14,7 @@
 #include "signal-common.h"
 #include "target_arch_cpu.h"
 #include "target_arch_thread.h"
+#include "qemu/guest-random.h"
 #include "tcg/startup.h"
 #include "exec/tb-flush.h"
 
@@ -142,7 +143,7 @@ void *new_freebsd_thread_start(void *arg)
     target_thread_set_upcall(env, info->param.start_func, info->param.arg,
         info->param.stack_base, info->param.stack_size);
     target_cpu_set_tls(env, info->param.tls_base);
-
+    qemu_guest_random_seed_thread_part2(cpu->random_seed);
     /* Enable signals */
     sigprocmask(SIG_SETMASK, &info->sigmask, NULL);
     /* Signal to the parent that we're ready. */
@@ -1657,6 +1658,7 @@ abi_long do_freebsd_thr_new(CPUArchState *env,
      */
     sigfillset(&sigmask);
     sigprocmask(SIG_BLOCK, &sigmask, &info.sigmask);
+    cpu->random_seed = qemu_guest_random_seed_thread_part1();
 
     ret = pthread_create(&info.thread, &attr, new_freebsd_thread_start, &info);
 

-- 
2.52.0


