Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1695606A322
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 16:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=r2r4A2cK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJCIr-0000jx-GE; Tue, 20 Oct 2026 12:03:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <takano32@gmail.com>)
 id 1xJB4b-0001j6-HJ
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 10:44:17 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <takano32@gmail.com>)
 id 1xJB4W-0002CN-8Z
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 10:44:16 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2e9d1114320so17935145ad.3
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 07:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792507449; x=1793112249; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=WBvSHQCpkwhScUzVRurv8qSM38o96lgMwhMXnuYj2Vc=;
 b=r2r4A2cKzWdz4zWNYBzfrMCwuItfEaL/Mxi1jytlhO/s9iW79jmOPDeIzhQ4C9eepj
 w/O22zUkGylrwUrMwZ0QDIkuLH/ALbhpGtreY38NHmAKLU6qJ7IIthK9muZ1W0bdZszD
 LU4n5ZlVZ/CkVcpSkq/AkITuFH3LTOBfmud2KJdqjSqmii4oIZoh4su1fAeb2rDIl1fg
 hSarjZ+jdeww2RvstX32NhRhAVBr/xOasnM5JrQp0ygUtYHeN5bTPTeeomGfpy3i2u+i
 TQKm/wdUca0VyTVc90KbwOfhmtLAFBjoYYn03lKrPwdLPH960JoS55rvsRUspRBNJnyH
 /uVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792507449; x=1793112249;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WBvSHQCpkwhScUzVRurv8qSM38o96lgMwhMXnuYj2Vc=;
 b=gnWyo4OmwiU9goWK2OoNIjyO5jR2o6ENlozSpJAEwlvVmkiqmwlAVG2dg8/2CKu6t7
 nPux4hFrfczsO/Fpfd7iev1Nryz9cVDiVGJeekOIJNwA6S7rRMOnZQGT96ot2pA4+gd7
 BWTdIznkwn7b2W9hj6iKOy8xrWUgI/2t6RN6e0Uj9iNLZeMweodTRCmm+8cq76LdMnv4
 CCcMWYmCk1Cr50BpO3F3ucgg9Ry8uwr1z5IUNVXSYOdc5KEDe+p927FriomhdU+AOC9P
 JlnQDmhPks4pisSUwI+kx/gY0Rtl+05NL3fmaN6Anll/nnuDo75R6sgCq33O9jbPxr1K
 5aLg==
X-Gm-Message-State: AFq9FYIn8PjmLGmN78zT0qYvwQXRBw2GlK3L6zALFfY1DBE5ss35IXES
 g0OyC8ZwD6cIppjfPymSfV7hqhlWW59tBEhnFY4QDu5TZXRX5tP9ugI6YRSUig==
X-Gm-Gg: AYBFou32lC31qbHocJ5951qFbBU7A0EnYMjDw6ss3pta/+bhCfT8XtZG6vxzDjQDHmS
 gP8dSlCv3xUeTRCL0zTZaOtefqG9p775GEojuUmzSMX90NbIlBc8n4FZXoD2jHJmIFWRozBDYqL
 GPmpzn/nt2CY3TwyNGnRnH1UIiB0pyz74dhZObv+n9DOHcN4iDNkerVDNnVnBZ3ikts/4xo/SpA
 kP+fIlWEElm36/j32HhxYoq7W57EHPzHLqf2j4JbHHGUtSHeiqBXvaCvrG50lw1Aj8Qg/FO6IoU
 c+Jrj9H+wYFSdI0nj/1KhsIJylzXXm0UjPqI663hEcFuGYo2Ent6YJLi2UPQIql4oklYPC0sPIC
 7suVMfH6NZzXiownqgkhhT/8lnR2UL4HrfL7vJJPPiGajjX5aJoKmVuDoEem+b/v2PoxNhMWxZ5
 QfksIVB4Fousvhu42ZGihMdE2ElNo+/ZNEQAXYCv15dgjtGwhysHsF9It8AA4AlA==
X-Received: by 2002:a17:902:ef50:b0:2e2:c3a2:9b15 with SMTP id
 d9443c01a7336-2e9a6833d93mr86310975ad.6.1792507449148; 
 Tue, 20 Oct 2026 07:44:09 -0700 (PDT)
Received: from a1-free ([161.33.196.121]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ea151840c4sm12978845ad.67.2026.10.20.07.44.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 07:44:08 -0700 (PDT)
From: takano32 <takano32@gmail.com>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, deller@gmx.de, pierrick.bouvier@oss.qualcomm.com,
 takano32 <takano32@gmail.com>
Subject: [PATCH] linux-user/i386: reject bad CS/SS selectors on rt_sigreturn
Date: Tue, 20 Oct 2026 14:44:06 +0000
Message-ID: <20261020144406.2542302-1-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=takano32@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 20 Oct 2026 12:01:57 -0400
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

restore_sigcontext() handed cs/ss straight to cpu_x86_load_seg(). In
protected mode that ends in helper_load_seg(), which raises #GP for an
invalid selector and calls cpu_loop_exit_restore() -- a longjmp out of
the syscall handler. Landing in cpu_exec() that way trips

    g_assert(cpu == current_cpu)

in cpu_exec_longjmp_cleanup() and aborts the whole emulator.

A guest that builds its own signal frame and executes rt_sigreturn
(SROP) leaves cs/ss zeroed, so this is easy to hit:

    $ qemu-x86_64 ./hello_srop < payload     # frame with cs=0, ss=0
    ERROR:accel/tcg/cpu-exec.c:515:cpu_exec_longjmp_cleanup:
      assertion failed: (cpu == current_cpu)
    Aborted

x86 Linux does not validate the selectors either: restore_sigcontext()
only does

    regs->cs = sc.cs | 0x03;
    regs->ss = sc.ss | 0x03;

and a bogus value matters only on the way back to user mode, where it
costs the task and not the kernel.  QEMU cannot be that casual, because
the selector goes through cpu_x86_load_seg() while the syscall handler
is still running.  So take the existing badframe path instead: accept
the selectors the CPU is already running with and return false for
anything else, which makes do_rt_sigreturn() raise SIGSEGV in the guest.

Tested with an x86_64 guest on an aarch64 host, against qemu master plus
this patch: a frame with cs=0x33, ss=0x2b restores and exits with the
requested code; a frame with cs=0, ss=0 now raises SIGSEGV in the guest
instead of aborting qemu (unpatched qemu 10.2.1 aborts with the
assertion above).

Signed-off-by: takano32 <takano32@gmail.com>
---
 linux-user/i386/signal.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/linux-user/i386/signal.c b/linux-user/i386/signal.c
index 9650fac940..01d54be310 100644
--- a/linux-user/i386/signal.c
+++ b/linux-user/i386/signal.c
@@ -775,8 +775,32 @@ static bool restore_sigcontext(CPUX86State *env, struct target_sigcontext *sc)
     env->eip = tswapl(sc->rip);
 #endif
 
-    cpu_x86_load_seg(env, R_CS, lduw_le_p(&sc->cs) | 3);
-    cpu_x86_load_seg(env, R_SS, lduw_le_p(&sc->ss) | 3);
+    /*
+     * Validate the selectors before loading them.
+     *
+     * In protected mode cpu_x86_load_seg() ends up in helper_load_seg(),
+     * which raises #GP for a bad selector and calls cpu_loop_exit_restore().
+     * That longjmps out of the syscall handler while cpu_exec_longjmp_cleanup()
+     * still expects the CPU it started with, so
+     *
+     *     g_assert(cpu == current_cpu)
+     *
+     * fires and the whole emulator aborts.  A guest that builds its own
+     * signal frame and executes rt_sigreturn (SROP) leaves cs/ss zeroed,
+     * so this is trivial to hit.  Linux treats such a frame as a bad frame
+     * and delivers SIGSEGV, so do the same and take the badframe path.
+     */
+    {
+        uint16_t cs = lduw_le_p(&sc->cs) | 3;
+        uint16_t ss = lduw_le_p(&sc->ss) | 3;
+
+        if (cs != (env->segs[R_CS].selector | 3) ||
+            ss != (env->segs[R_SS].selector | 3)) {
+            return false;
+        }
+        cpu_x86_load_seg(env, R_CS, cs);
+        cpu_x86_load_seg(env, R_SS, ss);
+    }
 
     tmpflags = tswapl(sc->eflags);
     env->eflags = (env->eflags & ~0x40DD5) | (tmpflags & 0x40DD5);
-- 
2.53.0


