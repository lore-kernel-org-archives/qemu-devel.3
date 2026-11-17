Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7262F606A323
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 13:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hV6n4a5F
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTJ3c-0006Rg-Bv; Tue, 17 Nov 2026 08:17:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neurosaki987@gmail.com>)
 id 1xTIhO-0001gv-TC
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 07:54:10 -0500
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neurosaki987@gmail.com>)
 id 1xTIhM-0003pr-Ve
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 07:54:10 -0500
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-5364648ae07so49494491cf.1
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 04:54:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794920047; cv=none;
 d=google.com; s=arc-20260327;
 b=bCLQ9DNJxSYkJc9LO1XACD5IFVLx+47WeODFWO+nASF/b3+mwdWr+6I9wdal+0NlrJ
 AVUlK0YjFtJTpD79vVE7giNJzlG6xKiNZOhhVKhCqL24J9n5PVSR06TH8Cr9uF7UmbRV
 k5SXP6M1WR1ukwqSu5B24yyMFqPjH3Fwn7icJ0hnNM4vKXYEinMHdp1PIb9xLJXGOmhz
 3kmDQAintPu3mhnNnqk2hyJFdL0cuy95THhFSoR08uP/Ih4lPKgQJK3SGaZnvhohC2Mj
 YgBWalVm3njIuT1873jm2FcPNjD/yAShazVaczdTYPMXq0HWacdQHuYZG+/CwBEgR7mU
 uYtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=itrwXlme012LlbeBOdUSWsdGweyWg4xTiZYhtL9tbNA=;
 fh=qUOFTwWG+G+YmxTz+HxoQUPJX6AFWbaPYrnquSe1BBk=;
 b=jXosl72+7Rm0DPwaBr2hqGvQhzas4shbUkAMo2FnAa8/Kb4ii1rAkC5l3pa5up4DED
 Qy8JtYNWmVesuwIWkKfw5z10fH17+8hPjR9L1Zsy+5KcYxt6zad0JUdBb/7FmDeMzXGC
 S3IPDMIftPAg8ldAbqJtPRGfPpNfoBG5WChdaTnXq3vlNeN4sHqObCZXFGe9REXJyFqk
 XGvSvkBFY9HxU6j/cTplD9O/ZhkxtGBG97s6ugy3m7kJ7AXc82+p7TV8SVW/Q+2jw3cU
 cBEOh4DmmyK3HRhIVcU9JObIY7SrR1k7kOsFuo80TSeajhbCg9IBO4VwGwqsC8/XBBks
 wL1g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794920047; x=1795524847; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=itrwXlme012LlbeBOdUSWsdGweyWg4xTiZYhtL9tbNA=;
 b=hV6n4a5F9WiKl6xJeyRvArE+erqBFXSQEyzywU7/yZP/INL/A4kSOpK3ARjxJT2gl9
 XQe0euRevweLsIFqkX1ynlGqSFDmxrjpQr7KkpcFiv2m+8tNMVJsbm0lzBaNocbgyDiG
 xeoS/5TdMV6qBkGsXC8k9xxKV6aCB4W/zopaeMABoZc41bq5W8qn4PfE1g4l8xVtRN/K
 KVZoYq1uBH+xb5SBNtf5sqXFoy7sYA5fEK16nQLo9Y5SIV90TncY0rtCnzO7m+RXoNjs
 q5K8uU1do5aJ1/zeDbLC3D0KLtqU0f2bu2lJIbqZRPpK4Uj+RDYem37hAr4XCMN3+c90
 wm2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794920047; x=1795524847;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=itrwXlme012LlbeBOdUSWsdGweyWg4xTiZYhtL9tbNA=;
 b=lr4wqiIFExRabkZsLdU5WaiO0cyKHaVkYQh+fksG/Mur9/HuLSaNOQSIbvd6Uzb5Vu
 50C03Uqt95QJ+u62DZmUM9Z1k6C1JwCsFB99tIWLc4JQlNcMKKsIgGpjPw3H+7p9haUs
 GOSwrd+P/KrZukYbIhege015gLpwxajwONfX1/ymxmZoaBIFQ1vRgjqKK2RrDAB3ZMVc
 z0NyTCV8PudvvvWUlzKsU9W8K5xXWS6BanOfLATuYt30gNFG7TqD15MaxUWpyYoUCAS6
 7LB4slMCNNTIBC1pdHWWQmae9L4mi4Kd1fgLF1bCFec4JkouIADtOEc8PLctGkevGArn
 evoA==
X-Gm-Message-State: APuU4Z/KtJ/fooyD3SxShUV0PScYdzvS3PRkQO2rPiiM9g4x4IcJdELq
 99CN23aY7g7oYw1fy0FAVyXQsM08DeeX5nnYM1ce4BlYWDZ97PHO2v+RibFc+Wej7uMQQ860kQZ
 IumsHoQFlfLn9CJOeIZ/gFkjV6GoLJNoc9On5BDM=
X-Gm-Gg: AYBFou3e+bYGaffhghvIoHFSENdvfXUxryUZyRqUoWA8xXlE/33zkmU0/3loHV1KWcB
 X4Duq+CP6urqiKrBqE+mlRUy5126k+ex66AOFeKNVgrzF65e51gDSt14GO3QL6WEWzeoly0aN1l
 u6mpkzJcpuZt7fZlwmKCrl7GepmFqRSHdLDRRfwWBgSGzjqzZbMSfyGPZqI6X03IQj335/s+Xvo
 fkBwpxf0LJJ5Emj/nJQzmULXiRybTzOP0a+uWpCpmOyrOj0QtzAlDXe8tbGx0j3FVUSG51dUAFT
 l8GGDdHa0QInxdQWlvUJ2O8Qh9wLvYyHowqF8Pcts0r3OPvfYtecrzCcefNdwsB2ImqNwt96lHd
 s5rDADAmBB7Yune1KGouzxRJfBNteWecEBHg=
X-Received: by 2002:a05:622a:4d9b:b0:55d:330f:e2d6 with SMTP id
 d75a77b69052e-55d330fe776mr127711891cf.26.1794920046960; Tue, 17 Nov 2026
 04:54:06 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Tue, 17 Nov 2026 04:54:06 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Neuro <neurosaki987@gmail.com>
Date: Tue, 17 Nov 2026 04:54:06 -0800
X-Gm-Features: AclHuK_PVNZ7HirBgSkc0wa86PC-BBGpil8Ot4TCscUGypvFhGhgay0_4RHAymY
Message-ID: <CA+6vzYSxSR-B+a1friO6oDDXXpt2DZ6C1jEKiUFLJPPR2BuntA@mail.gmail.com>
Subject: [PATCH] target/i386/tcg: validate MOV CR0 writes
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::835;
 envelope-from=neurosaki987@gmail.com; helo=mail-qt1-x835.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 17 Nov 2026 08:17:07 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Guest MOV CR0 under x86 TCG can complete without the architecturally
required #GP(0) for three invalid writes:

1. Setting any bit in CR0[63:32] from 64-bit code. The operand reaches
   cpu_x86_update_cr0() through a uint32_t parameter, silently discarding
   these bits.
2. Writing CR0.PG=1 with CR0.PE=0.
3. Clearing CR0.PG while executing in 64-bit code (CS.L=1).

This patch addresses a specific CR0 subset of the broader CR0/CR4
validation problem reported in:
https://gitlab.com/qemu-project/qemu/-/issues/3294

That issue already identifies the lack of input validation in
cpu_x86_update_cr0() and cpu_x86_update_cr4(), explicitly including
the invalid PG=1 with PE=0 case handled here.

Implementation:

Adds nine lines in target/i386/tcg/system/misc_helper.c, inside the
CR0 case of HELPER(write_crN).

Three checks reject non-zero CR0[63:32], PG=1 with PE=0, and clearing
PG in 64-bit code. They trigger #GP(0) after the existing SVM selective
intercept and before the actual CR0 update.

- The high-half check is compiled only for TARGET_X86_64.
- Uses HF_CS64_MASK for the paging-clear condition. Checking LMA alone
  would incorrectly reject a legitimate compatibility-mode exit from
  long mode.
- Raises EXCP0D_GPF with error code zero and GETPC() before updating
  architectural state, ensuring atomicity.

For example, MOV CR0, RAX that clears PG from 64-bit code now faults at
that instruction, leaving CR0/CR3/CR4/EFER and the source RAX unchanged.
Switching to compatibility mode before clearing PG still succeeds.

Architectural reference:

Intel 64 and IA-32 Architectures Software Developer's Manual, combined
volumes, 325462-093US, September 2026:
- MOV control-register instruction: combined-PDF pages 1321 and 1323.
- Volume 3A, section 5.1.2: combined-PDF page 3263.

Validation:

Base: 97c88c61d45dee6e1f9bc160a338048189846d28 (11.1.90)
Tested commit: 01ffa5267193c62e1100091e8f9c83b237303fa3
Host/build: native Windows, x86_64-softmmu TCG, MSYS2 UCRT64 toolchain.

- Invalid-write differential (102 cases): across max/Haswell configs
  with 4/5-level paging, 102/102 probes now correctly raise #GP(0);
  the baseline missed all 102. ROM SHA256 was compared to verify
  identical inputs. Targets include a noncanonical-access #GP(0)
  positive control, no-op CR0 writes and legal WP toggles, checking
  error code zero, exact fault RIP, retained source RAX and unchanged
  CR0/CR3/CR4/EFER.
- Legal-behavior differential (6 VM runs): all passed, covering
  compatibility-mode MOV CR0,EAX with nonzero RAX[63:32], WP toggles,
  legal compatibility-mode PG clear, legal PE clear after PG=0, and
  normal long-mode entry/exit. Guest output and exit status matched.
- Project tests: 180 passed, 4 skipped, 1 failed. checkpatch.pl reported
  zero errors and zero warnings. git diff --check passed.
  The single Meson failure is netdev-socket (Broken pipe in the Unix
  stream reconnect subtest), reproduced identically on the unmodified
  baseline and on a clean separate checkout. It uses -M none -accel
  qtest without guest CPU execution and is unrelated to this CR0 change.

Review boundaries:

Please review the fault conditions, compatibility-mode operand width,
fault atomicity and intercept ordering. Standalone i386-softmmu, nested
SVM, physical hardware/KVM and other invalid CR0 combinations remain
unverified.

Signed-off-by: NeuroSaki987 <neurosaki987@gmail.com>
---
 target/i386/tcg/system/misc_helper.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/i386/tcg/system/misc_helper.c
b/target/i386/tcg/system/misc_helper.c
index a77da59..eebc4b3 100644
--- a/target/i386/tcg/system/misc_helper.c
+++ b/target/i386/tcg/system/misc_helper.c
@@ -87,6 +87,15 @@ void HELPER(write_crN)(CPUX86State *env, int reg,
target_ulong t0)
             ((env->cr[0] ^ t0) & ~(CR0_TS_MASK | CR0_MP_MASK))) {
             cpu_vmexit(env, SVM_EXIT_CR0_SEL_WRITE, 0, GETPC());
         }
+#ifdef TARGET_X86_64
+        if (t0 & ~0xffffffffULL) {
+            raise_exception_err_ra(env, EXCP0D_GPF, 0, GETPC());
+        }
+#endif
+        if (((t0 & CR0_PG_MASK) && !(t0 & CR0_PE_MASK)) ||
+            ((env->hflags & HF_CS64_MASK) && !(t0 & CR0_PG_MASK))) {
+            raise_exception_err_ra(env, EXCP0D_GPF, 0, GETPC());
+        }
         cpu_x86_update_cr0(env, t0);
         break;
     case 3:
--
2.39.2

