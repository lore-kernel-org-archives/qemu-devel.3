Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A87D3515C
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 09:50:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7sC2-0008DB-5q; Wed, 01 Apr 2026 05:48:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7sC1-0008CO-1A
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:48:57 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7sBz-0000M0-9s
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:48:56 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48374014a77so79623365e9.3
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 02:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775036934; x=1775641734; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Vo0Efkf+YcZGXah/Y2zvFCSLiebUyzsrMT4TVvGFS2Q=;
 b=HWDJiXn6EpNHl1Dwtz2uD7fFySTyVhi/TfZKQFVczbqfcHaeb1ytjO3tZDdXMaDGUp
 km22LW2QCXvnsKqchUeDT1vufNL0zzITrHlCYfTIZoYbb2l8Xtt3NSlu0tUAskGn0xxc
 hYhlKj/Yiep2tW0J7PJ/Wiarl3dZ2/SFCUCGan68YufBnvmdbIqRahQuFz3EzsM1iJsO
 nb/e4wUlk4bPTHlV84Phc6qDmBoTN+n70F6vgR2gGMzxXHcIt15QI8vSD/5brIGn+RXN
 rJLQw8ugL/9sHwgmW75zSOe6w/I7d6d05im7nLwXwIVWHNGbyBWZN60FfuLXh4CYFlX/
 X5NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775036934; x=1775641734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Vo0Efkf+YcZGXah/Y2zvFCSLiebUyzsrMT4TVvGFS2Q=;
 b=Tb2Zb+hlE0srNsHxH+xkcDR4+En2rBrvpTDehX2qmbxqemLLe+ZD6J9QmU1J1m/8q6
 zWvIwzaUqAxCMM4snQAJ3+MOXMLeORu8mmUNN1v3mkNMGIqjrrg0bGm0PaRyE2lz+0PA
 JVzQAUKt0Muu3I++mZuHsYxeKAIGBx76bhG+shMoVCvNQKve5zB038bx4m+SViZEP6J1
 R9+pwcKABxc6J0yA5KZ6HCS2YaV+/FJDWmnUpdxH9uBmuKiDvtDinK3GzmTmkrmC1SbA
 wte2980t6C4uv8RMRO5s25RiW9X4c2tTomhM6hSsBCXSYgjOYgDKQS/m8cro34SenqzR
 wDMg==
X-Gm-Message-State: AOJu0YxWADabyzOloRIWkP/8jT2CJbVd7yuXqhHK721VQ04yjlVkctqZ
 mgUXMZqgYwyN/IBTNOcHYTYPGwPXRSFvrFrs/ky7Gt2aR1yx+7iD94PSlnjXis40AorbikjbHEb
 m4dHEXcM=
X-Gm-Gg: ATEYQzyXdXS5GqZV8IuDiMqc11IW40x7vdDSTmGHRt5zxapWuXcUlgnW3q3jOpGOln5
 oAzzWbYN2S4YDU+qYp/dAFuxx8QozH4qpn+P1XaAP/ByKL0kd2NJk32S4wv7EnjPJG5LA1ZZtpI
 eDTe5ojCiw1DuueYRH07XIZuSIyeAAkCWfG5ezflVkWcVah0TnjmJ5L4CS25XaPWBCvj7cyNAAp
 r7tJcNrFjrmyhRCXYwI0QrOuLx/AMm1xRqCL6MPjs8IGssPH1a9ZL4fsMB//VPg+fjS0hZqIR/e
 nSAUYhuF8L26z8Q2zDfoCC4MiGOznEmOKznaNCgrobkr/3F0XIg2p5uDXm/5nNeGHwwdDnkBxvM
 cfL+uUnlbuxWhqj2XnmxR6lDS4bDnycPuEKxDlxfq0+bf5Qnc9/I3D3Js5C+qvavAJGIXs89RPw
 obKATXI+112Luw0U6JHWBwtxCE4Mg/aGUAoA5ET4BG6LhWbkuU1FKVzXxVJGK98dgRKZJZFLbw9
 P9MF3RcfF4mkZtSV4vVSEO9CljvZuI=
X-Received: by 2002:a05:600c:3f07:b0:486:ff92:63e5 with SMTP id
 5b1f17b1804b1-4888355df4emr50657825e9.6.1775036933753; 
 Wed, 01 Apr 2026 02:48:53 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887eb5aff3sm146945685e9.15.2026.04.01.02.48.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 02:48:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 4/6] linux-user: update select timeout writeback
Date: Wed,  1 Apr 2026 10:48:46 +0100
Message-ID: <20260401094848.2661985-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260401094848.2661985-1-peter.maydell@linaro.org>
References: <20260401094848.2661985-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Sun Haoyu <shyliuli@aosc.io>

The Linux kernel writes back the remaining timeout for select-family
syscalls in poll_select_finish(). If that writeback fails, it keeps
the original return value.

However, QEMU only writes back the timeout on success. If the writeback
fails, QEMU returns -TARGET_EFAULT. This can lose the remaining
timeout and change the return value.

Update do_select(), do_pselect6(), and do_ppoll() to always write back
the timeout to match the Linux kernel's behavior. If the timeout
writeback fails, keep the original return value.

Tested with the issue reproducer.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3343
Signed-off-by: Sun Haoyu <shyliuli@aosc.io>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260320111647.138984-1-shyliuli@aosc.io
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/syscall.c | 45 +++++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 3cb00c643e..bb95b96f29 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1384,14 +1384,15 @@ static abi_long do_select(int n,
             return -TARGET_EFAULT;
         if (efd_addr && copy_to_user_fdset(efd_addr, &efds, n))
             return -TARGET_EFAULT;
-
-        if (target_tv_addr) {
-            tv.tv_sec = ts.tv_sec;
-            tv.tv_usec = ts.tv_nsec / 1000;
-            if (copy_to_user_timeval(target_tv_addr, &tv)) {
-                return -TARGET_EFAULT;
-            }
-        }
+    }
+    if (target_tv_addr) {
+        tv.tv_sec = ts.tv_sec;
+        tv.tv_usec = ts.tv_nsec / 1000;
+        /*
+         * Like the kernel, we deliberately ignore possible
+         * failures writing back to the timeout struct.
+         */
+        copy_to_user_timeval(target_tv_addr, &tv);
     }
 
     return ret;
@@ -1519,14 +1520,16 @@ static abi_long do_pselect6(abi_long arg1, abi_long arg2, abi_long arg3,
         if (efd_addr && copy_to_user_fdset(efd_addr, &efds, n)) {
             return -TARGET_EFAULT;
         }
+    }
+    if (ts_addr) {
+        /*
+         * Like the kernel, we deliberately ignore possible
+         * failures writing back to the timeout struct.
+         */
         if (time64) {
-            if (ts_addr && host_to_target_timespec64(ts_addr, &ts)) {
-                return -TARGET_EFAULT;
-            }
+            host_to_target_timespec64(ts_addr, &ts);
         } else {
-            if (ts_addr && host_to_target_timespec(ts_addr, &ts)) {
-                return -TARGET_EFAULT;
-            }
+            host_to_target_timespec(ts_addr, &ts);
         }
     }
     return ret;
@@ -1596,15 +1599,15 @@ static abi_long do_ppoll(abi_long arg1, abi_long arg2, abi_long arg3,
         if (set) {
             finish_sigsuspend_mask(ret);
         }
-        if (!is_error(ret) && arg3) {
+        if (arg3) {
+            /*
+             * Like the kernel, we deliberately ignore possible
+             * failures writing back to the timeout struct.
+             */
             if (time64) {
-                if (host_to_target_timespec64(arg3, timeout_ts)) {
-                    return -TARGET_EFAULT;
-                }
+                host_to_target_timespec64(arg3, timeout_ts);
             } else {
-                if (host_to_target_timespec(arg3, timeout_ts)) {
-                    return -TARGET_EFAULT;
-                }
+                host_to_target_timespec(arg3, timeout_ts);
             }
         }
     } else {
-- 
2.43.0


