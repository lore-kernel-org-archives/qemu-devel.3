Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E4D606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 13:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hOCTUhna
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKc26-0006dU-5s; Sat, 24 Oct 2026 09:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <takano32@gmail.com>)
 id 1xKbzy-0005es-OT
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 09:41:29 -0400
Received: from mail-dy1-x1329.google.com ([2607:f8b0:4864:20::1329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <takano32@gmail.com>)
 id 1xKbzw-0003Qj-Iy
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 09:41:26 -0400
Received: by mail-dy1-x1329.google.com with SMTP id
 5a478bee46e88-35b2c599f43so435052eec.0
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 06:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792849281; x=1793454081; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=blhomSpfPK8kqKyGECxZoB0Gv7ZYX4L8jmL10Mx6wEM=;
 b=hOCTUhnaHvAkvkRYVLm1xAYPAEPq+SSyVcnMtEwc2MfcWOrQU15BRbhaed5Xg1eGMf
 hBb0vxmPUwjnqEffevk0RnNRWup4pHn1DoKpg6SywMMvqsbQ6tgrNA5ewgqaqxTSAETu
 rbIi6YYyqLhhM/4actLEpVslXdyRTWWuabFk9lsCVFAcYbd07RuWTm7q7+bLNbu7AM33
 oceky0F9x7hz+3U2iH2pdg2RsTl4zSYZ9htgRoYRCrejdoMd/goXBd6dx6CRhEtDpROI
 0/PLdGloTtZUo0wKFISvtAkigmz2Xwn28M2vhkSyv4+ChBC5ct7ZRSqxh+ndMBC9VFPd
 Qbhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792849281; x=1793454081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=blhomSpfPK8kqKyGECxZoB0Gv7ZYX4L8jmL10Mx6wEM=;
 b=Crwh/B8GOFxvVXB+mw6uERaA6QAYbiYgUrcppJx4Rq+G4vteL2AwiQSA3pnX1hh05F
 W96G2gCtmBZlitVtlfL2hgPJS9qLSCmGh5fGORt6Ll5aJ3V+OMITFVy43TemblhsG2DK
 a2psbrPQec6DkG0atQuSgunTxxUk4hyPqutYEDaNGeYStjdCso/9oHjbAaViO2TtZovi
 LhsurHNJuE1ixjaLF1Z8KtJUDBYIslUBm8U7AzpmRDyaZBmmPfFCZOdjzLDysRjJHxme
 aZZiFJ+k0rGiU75VP3zqsAQq2fkpO+WeZJ92g2JXUvHhVNY6HUGDHsabZn1Id8I6K8Nf
 Fa0g==
X-Gm-Message-State: AFq9FYKtytSX4zItcc1LdEzPdpNuYlVLt9uCFHhtTTIamsYodThKkfJo
 TE0b4R49ypQeZEWu9gPEslI8FHByWoqtiYl7BpJ88JRg0knnX54V3qH/qZX/Qw==
X-Gm-Gg: AYBFou1A1cI53a/yQzZOSyGsmEJ2pYt/KXA0/vujrrGGv9Qifac2V27c6rjtlg49fFW
 KuVT2HPKdCrTW8N4nMNT3WKtWVL2VR9Yd6UVo185/Q1tQdObuOjeV1o1vOK4Rn521jXhKvr2S0K
 +Pe9jE7aL1qefp87lpZJBF8h56LlgZfvDwAqFVVPun3E3sYrR2WuzBLa86MaAhYeKToRgDxypMZ
 ggXvz3zjiRO59jZe0bON40o/oMx+lvS9HLC1KMNHoMWl930I5S1UgJYYv8Nx24DGZytC2z4nzZw
 +dHvTnVpm+NC80xKBFMW8oJW5FLz/i1AA80tssFrOBiccnQQ1sOoqtgl3Qxv0p1nnmbghcBgUuO
 O+3oksJ0B0b7sv51I3e9WtArtSy6Nzw1g0irsuSSfWTgMfEk6W3u+1b4aXBxKI2iap6v24WlhYb
 p2B8TT//UWlz7uScp2vOr81lJ0jX/PkcnUbeeW6aSFVXz/GhujpILnreXH++Pn+rku6TwbsS9sN
 ujMo530stGsL2WaoYtZw37b+q+NQ5rqFRCpYzbwpvC8TCA=
X-Received: by 2002:a05:693c:8816:10b0:366:fabf:6273 with SMTP id
 5a478bee46e88-369e8483c1bmr3183605eec.22.1792849280977; 
 Sat, 24 Oct 2026 06:41:20 -0700 (PDT)
Received: from a1-free ([161.33.196.121]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369e8ec9276sm13385569eec.25.2026.10.24.06.41.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 06:41:20 -0700 (PDT)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 TAKANO Mitsuhiro <takano32@gmail.com>
Subject: [PATCH v2] linux-user/i386: reject bad CS/SS selectors on rt_sigreturn
Date: Sat, 24 Oct 2026 13:41:18 +0000
Message-ID: <20261024134118.474313-1-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <c054bf9c-6cff-4532-83b3-c4fadce541ea@gmx.de>
References: <c054bf9c-6cff-4532-83b3-c4fadce541ea@gmx.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1329;
 envelope-from=takano32@gmail.com; helo=mail-dy1-x1329.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
v2:
 - author and Signed-off-by now carry my real name (TAKANO Mitsuhiro)
 - changelog: x86 Linux does not validate the selectors either, it only
   restores them into the return frame; describe the QEMU-side longjmp
   instead of claiming that the kernel rejects the frame
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


