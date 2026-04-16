Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCDEFF8E489
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 22:38:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDVLR-0007gk-AI; Thu, 16 Apr 2026 18:37:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wDRPG-0001H0-7q
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 14:25:38 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wDRPC-0004rr-T7
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 14:25:37 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-7a469383e0bso66574797b3.2
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 11:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776363932; x=1776968732; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tsmzOeoP7uNAK2BdhTFC+4QKbukVOAW6xDOyhAheOzs=;
 b=mrrPaxQxf0zlusfGc8OwZf8bKXtuerUs+XyLPtlH+q4VgbpbmMVL5x55Ip3S1blpdh
 SRLHrlbubSqdDxIhxWn4u65lQaMWGJ1uyoPtxwlk1QMiIabluXXtKqhO1+8d9pdcSkif
 CV+R+RNO76RJ60qeRR6Z+BrPkKl+udZNe8qwqRKiqIDFVgO4Utpqw0y5VLuqARWHxzAL
 X4aZlBeppuvAFkqTJOYrDnsihXK9FszhpG6izSnSM5i62cAjM8i67vnP23K6UzEIe8eN
 PGIjKTQhG4jzX2XgO8HL7fc8F9zNGbmLiTuYRMlq2KruQzIQyuGQhFB6cV7ZPVTXTLdt
 SaWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776363932; x=1776968732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tsmzOeoP7uNAK2BdhTFC+4QKbukVOAW6xDOyhAheOzs=;
 b=sGzMe6vZh8VH+W5uKx2xSfRQL8hgQjHC0aw4cGMGnBtBrSbBTh/i5wbfPfKHRpfw9s
 JODEEEwCIG6n0BLsZeSaS6iLxYN3hAs+W+nn3tta14wCzOnnGfOvNprOUv7IQq7XppyA
 uw4zO4RsZs+uJigYo7tMSGP77jee1lVwFUXWotWQPcchouL/Fz43RAA/GDiRHcE22IAF
 8GyczaN0qPIE7WrVT0HDjr9tiUmEDGbRiF7WHTSk6TM0oDrxKQV+Fsj8zrSGGOgzAdte
 Z6SQ4HDYFo1TfaM6QYCqENgyfyNItjJonBcmcqon5WwTpTRCRnHXs3NRs7hWtb7/f7ie
 wgsw==
X-Gm-Message-State: AOJu0YyQDEpWm6KEjjQv3zigxe8xsHw/mdfsX+uSqJoKVzBIqJ7TovfV
 RpqpeLodMAY3lJRZ9Y+pRDi4FjiAJE4LrpJkHFc1GL4XQjz1dOoq5ags
X-Gm-Gg: AeBDievYIimxooyWqzsDB/BfLdxO+mp8PEinFSPoMXuLyAHWGU9qsNsfAKb6AhuHoAU
 k1v6rwnvRCORBYkcIJzSMP38vlpaqjTzcWG3xjY9b+vRvag9osM1mUy6Fc08fb+EOAJ/TxWCggw
 QrL9NneXVUF3BWlC9Zgns7Qy3sPO3b8qHfm1l3flyUGnMiD1e3iPdILkyeb2vWTxZkYOga+JoR3
 bNcn0n9Z8qKvZSA0I8jBySDAvDjqthNSpFguaWF2GehUmisgldLuimsdLMMcv8Sg9JWtAsiPkQv
 +reL8SF8ICI7Ch1OGZE3yu196DA0oADLqD/eq4MTb8Al4XlfFivWRs4IQtgEoWgtyCuqsTps2Pp
 Qzl9KSjxONUHYDo9Bzh733FoIj+4NnN0ik1IZd6U0LGfVo7th/22U0b5sQaRCzDxWqi7R/1z9Rh
 9TwFtnnFfXD5xvcHqCWZjLD+zuEmuxhtQTTuIRU8/1paXBnYa2SXz7sFhMiSeghFqrFiDTrS5fx
 DDsgwjOxKtjtg==
X-Received: by 2002:a05:690c:660c:b0:7b8:b3:58fa with SMTP id
 00721157ae682-7b9e3084368mr2202967b3.31.1776363932360; 
 Thu, 16 Apr 2026 11:25:32 -0700 (PDT)
Received: from localhost (107-220-129-194.lightspeed.chrlnc.sbcglobal.net.
 [107.220.129.194]) by smtp.gmail.com with UTF8SMTPSA id
 00721157ae682-7b7667f96f5sm26500827b3.18.2026.04.16.11.25.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 11:25:31 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Matt Turner <mattst88@gmail.com>
Subject: [PATCH] linux-user/ppc: Fix ppc64 rt_sigframe stack offset
Date: Thu, 16 Apr 2026 14:25:27 -0400
Message-ID: <20260416182527.3862296-1-mattst88@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260414025335.2847358-1-mattst88@gmail.com>
References: <20260414025335.2847358-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=mattst88@gmail.com; helo=mail-yw1-x112d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 16 Apr 2026 18:37:49 -0400
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

The kernel's 64-bit signal delivery (signal_64.c) uses:

    newsp = frame - __SIGNAL_FRAMESIZE

while the 32-bit path (signal_32.c) uses:

    newsp = frame - (__SIGNAL_FRAMESIZE + 16)

The extra 16 bytes in the 32-bit case is to place siginfo and ucontext
at the same offsets as older kernels (see the comment in signal_32.c).
The 64-bit rt_sigframe starts with ucontext directly and does not need
this adjustment.

QEMU's setup_rt_frame() unconditionally used (SIGNAL_FRAMESIZE + 16)
for both 32-bit and 64-bit, placing the handler's SP 16 bytes too low
on ppc64. Signal delivery and return still worked because do_rt_sigreturn
had the matching wrong offset, but the vDSO DWARF unwind info encodes
the correct kernel offset. This caused any DWARF unwinder (libunwind,
libgcc, etc.) to compute a CFA that is 16 bytes off, reading garbage
register values from the signal frame.

Define RT_SIGFRAME_ADJUST (0 on ppc64, 16 on ppc32) and use it in both
setup_rt_frame and do_rt_sigreturn to match the kernel.

This was verified by A/B testing with libunwind's test suite:

  ppc64le: Gtest-bt, Ltest-bt, Gtest-concurrent, Ltest-concurrent,
           and Ltest-sig-context all change from FAIL to PASS.
  ppc64be: Gtest-bt, Ltest-bt, and Ltest-sig-context all change
           from FAIL to PASS.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 linux-user/ppc/signal.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git ./linux-user/ppc/signal.c ./linux-user/ppc/signal.c
index 24e5a02a78..a9c10e0987 100644
--- ./linux-user/ppc/signal.c
+++ ./linux-user/ppc/signal.c
@@ -210,6 +210,18 @@ QEMU_BUILD_BUG_ON(offsetof(struct target_rt_sigframe, uc.tuc_mcontext)
 
 #endif
 
+#ifdef TARGET_PPC64
+#define RT_SIGFRAME_ADJUST 0
+#else
+/*
+ * For 32-bit rt sigframes we have an extra 16 bytes of gap
+ * on top of __SIGNAL_FRAMESIZE; this is to get the siginfo
+ * and ucontext in the same positions as in older kernels.
+ * See Linux's arch/powerpc/kernel/signal_32.c.
+ */
+#define RT_SIGFRAME_ADJUST 16
+#endif
+
 #if defined(TARGET_PPC64)
 
 struct target_func_ptr {
@@ -525,7 +537,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     env->fpscr = 0;
 
     /* Create a stack frame for the caller of the handler.  */
-    newsp = rt_sf_addr - (SIGNAL_FRAMESIZE + 16);
+    newsp = rt_sf_addr - (SIGNAL_FRAMESIZE + RT_SIGFRAME_ADJUST);
     err |= put_user(env->gpr[1], newsp, target_ulong);
 
     if (err)
@@ -641,7 +653,7 @@ long do_rt_sigreturn(CPUPPCState *env)
     struct target_rt_sigframe *rt_sf = NULL;
     target_ulong rt_sf_addr;
 
-    rt_sf_addr = env->gpr[1] + SIGNAL_FRAMESIZE + 16;
+    rt_sf_addr = env->gpr[1] + SIGNAL_FRAMESIZE + RT_SIGFRAME_ADJUST;
     if (!lock_user_struct(VERIFY_READ, rt_sf, rt_sf_addr, 1))
         goto sigsegv;
 
-- 
2.52.0


