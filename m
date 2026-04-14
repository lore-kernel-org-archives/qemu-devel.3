Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EA07F9D0EB
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 17:27:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wChXc-0002oQ-HY; Tue, 14 Apr 2026 13:27:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wCTuN-0004Sa-Dd
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 22:53:47 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wCTuM-0004aP-0Q
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 22:53:47 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-78fc4425b6bso47267667b3.1
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 19:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776135224; x=1776740024; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YBdiT7AseZaWPAh14FHjZWZ6g6o27t+1V3jw9kY798M=;
 b=RBWjV6B6F+C+3qAP+AHxkhYjJWVtVRY6sFJuVt27+bA1JsomxR/v1dd/KHO0fgISGx
 hJ9kfjOYw+8pn2dgsmG4WFU1EPtoNUgpRfgKPbWJ8ryaeR3M51ymHM0lq8TCbxBVaZiF
 aYHHlnzIDwQw90MtP8tK8xEgwH2LIpX5R9KG5vcQ/5bPcZq4JLgTEPHIu0VItXihV0QH
 IEDHuTnIVYLwOZaQfR7UzY6lE77IfT7/NDzCFqCYyMxiXq4vTEiLBrpDmWNK3wJZPFBt
 zQZiofxgbQyUTtKpixq3SudKsxI6jt2ADTPFKABYdmVL0Bb/4IrWX/M06LTTqmEfm0He
 aTeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776135224; x=1776740024;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YBdiT7AseZaWPAh14FHjZWZ6g6o27t+1V3jw9kY798M=;
 b=PmQb6NIVgcrzRgbczLcAf4FRSEdYQ60lgnfEiAzJLH7DhD4IiOkG7DOBCDzDb38hm+
 75S1SSEyDaf8BqriunwhDiBCYDJ90TxcAZoHiVVl/dot9wXmelPnr4Ar3b71HVrYU3KA
 6jIUUWV8A4X89DjORDeISeT6W+bjr1XwYPtxaha888p7DG0nSbYQS5ea8gbJMxBsd6GZ
 96sJJN8vcMBdplDG3c2bHQ9HIHIeksAIaVnEBgJxGLdmD9PYUOqgWzaIvu8vzSlU0lO6
 fby0lzX2nM06teBOjquL5gdTIiQAS2kkKF0bb4J+nepNrgL/tdMCML5zNZqYiin6Mxf0
 I0IQ==
X-Gm-Message-State: AOJu0YwW2Ns+/pcA6+Rraz+XO/s+MRyp2NTpUhQOtp1f1F/5aqkbjAoL
 rAD6rbPiEWg4TveY1PuPpxr5ffBSi76XuFqd7ZaoOYE0eAaEv38IE9jn
X-Gm-Gg: AeBDiesHJlBwidlecnRkj670gb5iuArI6zTDYfwbAFfcdRVnNY64r6VDBn+5zs+dCzc
 nysi4FzWgeg521ps3Bv+HmRLu6yHrz+vOp3Pt3fblxLav2k5fVG0Km2r3N/3zSuRtgMZcRLvEok
 cR5tR5Jvhywa1OgbzeOItNAt00tsDOFj4dBkhrr8z6Es/F4V/YR3nxWZR2XjbpIUNroNpxFxLCI
 HPjgFd0E8qfumMIBzIiEFZDzufzVP0D9q78ZNXMeJoBugxPk64YsGsNnfGO9TdTDaF1kqDTQp6N
 3pqd37a6sAX3Fr8Fgr3H/DpyemoBWKu3tMhYhf42Yd4pns9DGesnw4RdkoKcGuc9DBWmzdAaDIs
 xBRJrFCwxH1JmE8Kqm0Gxt2SugO5iV+cK+HEnuK9An1Z7DrHimMy2QjrbZ1AyZZKGs0KRbU8Y/R
 g+Tp7kOAYHCIugBg6I2V4=
X-Received: by 2002:a05:690c:101:b0:7a1:6e8:d8fb with SMTP id
 00721157ae682-7af6f03b254mr178694397b3.3.1776135224077; 
 Mon, 13 Apr 2026 19:53:44 -0700 (PDT)
Received: from localhost ([76.195.202.134])
 by smtp.gmail.com with UTF8SMTPSA id
 00721157ae682-7b414d0faf4sm14305387b3.22.2026.04.13.19.53.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 19:53:43 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org,
	Matt Turner <mattst88@gmail.com>
Subject: [PATCH] linux-user/ppc: Fix ppc64 rt_sigframe stack offset
Date: Mon, 13 Apr 2026 22:53:35 -0400
Message-ID: <20260414025335.2847358-1-mattst88@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=mattst88@gmail.com; helo=mail-yw1-x1130.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 14 Apr 2026 13:27:11 -0400
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

Guard the +16 with #if !defined(TARGET_PPC64) in both setup_rt_frame
and do_rt_sigreturn to match the kernel.

This was verified by A/B testing with libunwind's test suite:

  ppc64le: Gtest-bt, Ltest-bt, Gtest-concurrent, Ltest-concurrent,
           and Ltest-sig-context all change from FAIL to PASS.
  ppc64be: Gtest-bt, Ltest-bt, and Ltest-sig-context all change
           from FAIL to PASS.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 linux-user/ppc/signal.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git ./linux-user/ppc/signal.c ./linux-user/ppc/signal.c
index 24e5a02a78..b21aa2430e 100644
--- ./linux-user/ppc/signal.c
+++ ./linux-user/ppc/signal.c
@@ -525,7 +525,15 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     env->fpscr = 0;
 
     /* Create a stack frame for the caller of the handler.  */
+#if defined(TARGET_PPC64)
+    newsp = rt_sf_addr - SIGNAL_FRAMESIZE;
+#else
+    /*
+     * The +16 is to get the siginfo and ucontext in the same positions
+     * as in older kernels. See Linux's arch/powerpc/kernel/signal_32.c.
+     */
     newsp = rt_sf_addr - (SIGNAL_FRAMESIZE + 16);
+#endif
     err |= put_user(env->gpr[1], newsp, target_ulong);
 
     if (err)
@@ -641,7 +649,11 @@ long do_rt_sigreturn(CPUPPCState *env)
     struct target_rt_sigframe *rt_sf = NULL;
     target_ulong rt_sf_addr;
 
+#if defined(TARGET_PPC64)
+    rt_sf_addr = env->gpr[1] + SIGNAL_FRAMESIZE;
+#else
     rt_sf_addr = env->gpr[1] + SIGNAL_FRAMESIZE + 16;
+#endif
     if (!lock_user_struct(VERIFY_READ, rt_sf, rt_sf_addr, 1))
         goto sigsegv;
 
-- 
2.52.0


