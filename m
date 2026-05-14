Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80634CD4F25
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 16:56:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNZLw-0006rF-35; Thu, 14 May 2026 12:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wNZLo-0006pE-9a
 for qemu-devel@nongnu.org; Thu, 14 May 2026 12:55:56 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wNZLj-0007A9-4y
 for qemu-devel@nongnu.org; Thu, 14 May 2026 12:55:56 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-65c37eafcbeso10244760d50.1
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 09:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778777748; x=1779382548; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sjSLJTkFHNOAPOEOvR11DUKHINUVl5grZiB9q86+Ti4=;
 b=cTs+8dYB7kYXBD9ScSfRdZE7okZjtU7Y90qV5eS//6XFnUsO0SxVHE3ffHomjCTRCt
 zbDcqq/1NdT4sjTvbw1IfC3idpyDm1Ije7EgIYASiDWQDSjAMO0kiN8EpCcpgGe+guWQ
 /pnRTFgbPU/WKuU0h8fv6RiWug5x73C/oip9SlqapSdwD4smA1o7d41ph1ICLKE5oND8
 z611QadWqmssEyHc1ap1njqQ8hy7Z3zp3fk0kOLNTI+XnmTs/zDkOY7SByAbU+O+PZHF
 4zESoMnhrQJL5iKQEkJdqsLwVihS3iL4bq3sMg+MNPW1LrOSkZtPPLCW51N5AyMSydgm
 YvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778777748; x=1779382548;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sjSLJTkFHNOAPOEOvR11DUKHINUVl5grZiB9q86+Ti4=;
 b=lq1bFH6Mm0bEw/yVgtMgOFn2SGoV+XhXwRj6jT/d8fNFY8fSvBz5qX6SnQ7F8qrEa5
 STuXCG90dViVNX47xhbs7HE8uADWlDebACsW91S6Bm/NoaaWDPb02xCVKypVP/GA8dVB
 /hqu+IVYmokXGcLgd6OXUXADEocbBabbAwWj9J3LvQHeaJwUgP7HAOHifH6AtYrhbFCa
 4o7La/48PE8vq/1oldff6GVcpndJxXEiFZq5bqLUaX65vzUi8dNlrX4mnj0jYro4Dkjs
 poUfROVgYdXv2cJWcxR2cCP5iJ8MiYb72iPfqTU+vsjFFJMp+EXUqo8o7X2eN63xsm90
 XXkg==
X-Gm-Message-State: AOJu0YwP7saJ2FFLcN5jPxo9wy7tyleAulaMnSp3lin814crgNo/xa/c
 B0pwJUiwgpsX4cQFwvvdqa1qnpC3TFMcHvH06B08nLEqtKq/nMS+4XA2UDNyRSWT
X-Gm-Gg: Acq92OGt7etBxgqK9LSmfzKFWQ2HGLOwogYHvKtEVy+S3BRqhvLtYYNPHCSAR+aDfMu
 icdfmxzU8ueIyA8zCrw4UBe8JBqsButTpABbLsfRjTwBDl+CUD0UoU/a/0+Ju4vs3ASiK1RC5Mg
 NCEN1E+LR5gAJYVr+loA07pME4/obcoEvLnAY5laMgVzosrysYwnH2lJeJfq/qk9BoLRajNzhKw
 2UfdOBdqe4sQrE3PugpbfsSMVD75RAktKcUHOkRfoUambzEMCtwdB/OvX252hh1OUKSNqWY38gf
 ubREF37lbCo2SE2MMJoRGRQKBr5SqS5yyD0DbgPVWvnjYWw4YegiNFeiT0x5ftksP0mFvFvJPzq
 j25z24g4TrjWlC3GCEb23fpQEAlFdruMT71x10M3F5aRVrf6dah4PEnkOV2udDyySVIpYtzJwfg
 npRG+C0MwYtOisuWaGt2b+rJYFDWqgxi1EVtyIyoAGiSppJwBMweigHYQj+N4gvILFsMnO5M2ks
 ipO5AHY6bibCA==
X-Received: by 2002:a05:690c:10d:b0:7c0:deb6:ce36 with SMTP id
 00721157ae682-7c95ae4b645mr1141277b3.22.1778777747977; 
 Thu, 14 May 2026 09:55:47 -0700 (PDT)
Received: from localhost (107-220-129-194.lightspeed.chrlnc.sbcglobal.net.
 [107.220.129.194]) by smtp.gmail.com with UTF8SMTPSA id
 00721157ae682-7c7f54c29ddsm16448717b3.34.2026.05.14.09.55.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 09:55:47 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matt Turner <mattst88@gmail.com>, qemu-stable@nongnu.org
Subject: [PATCH 1/2] linux-user/sh4: Fix target_ucontext tuc_link field type
Date: Thu, 14 May 2026 12:55:25 -0400
Message-ID: <20260514165526.1530386-1-mattst88@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=mattst88@gmail.com; helo=mail-yx1-xb132.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

tuc_link is declared as 'struct target_ucontext *', which is a HOST
pointer.  On a 64-bit host running a 32-bit SH4 target, this is 8 bytes
instead of the 4 bytes the target expects, padding pushes tuc_mcontext
8 bytes past its correct offset.

When a signal handler receives ucontext_t *, every field accessed through
uc_mcontext (gregs[], pc, pr, ...) is read from the wrong address.  In
particular the saved PC comes back as a garbage stack value, which breaks
any code that initialises a libunwind cursor from the signal context.

Fix it by using abi_ulong, which is always sized to the target ABI (4
bytes for SH4), matching the layout the kernel and glibc agree on.  This
is the same pattern used by arm/signal.c.

Also remove the (unsigned long *) cast from the __put_user that zeros
tuc_link.  The cast was harmless when tuc_link was pointer-sized (8
bytes matching unsigned long on a 64-bit host), but after the type
change __put_user's sizeof dispatch would select stq_le_p (8-byte write)
for a now-4-byte field, silently overwriting the start of tuc_stack.

Neither this fix nor the companion setup_sigtramp fix is independently
sufficient: this fix corrects register values read from the signal context
but libunwind still cannot detect the frame without the correct trampoline
pattern; that fix makes the frame detectable but register reads remain
garbage without the correct ucontext layout.  Together they fix the
following libunwind tests on a 64-bit host:
  Gtest-sig-context, Gtest-trace, Ltest-init-local-signal,
  Ltest-sig-context, Ltest-trace

Signed-off-by: Matt Turner <mattst88@gmail.com>
Cc: qemu-stable@nongnu.org
---
 linux-user/sh4/signal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git ./linux-user/sh4/signal.c ./linux-user/sh4/signal.c
index 9ecc026fae..20d2bc8b2c 100644
--- ./linux-user/sh4/signal.c
+++ ./linux-user/sh4/signal.c
@@ -57,7 +57,7 @@ struct target_sigframe
 
 struct target_ucontext {
     target_ulong tuc_flags;
-    struct target_ucontext *tuc_link;
+    abi_ulong tuc_link;
     target_stack_t tuc_stack;
     struct target_sigcontext tuc_mcontext;
     target_sigset_t tuc_sigmask;        /* mask last for extensibility */
@@ -237,7 +237,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
 
     /* Create the ucontext.  */
     __put_user(0, &frame->uc.tuc_flags);
-    __put_user(0, (unsigned long *)&frame->uc.tuc_link);
+    __put_user(0, &frame->uc.tuc_link);
     target_save_altstack(&frame->uc.tuc_stack, regs);
     setup_sigcontext(&frame->uc.tuc_mcontext,
                      regs, set->sig[0]);
-- 
2.52.0


