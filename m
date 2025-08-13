Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C7BCA0EE4
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 17:38:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umbtd-0007FX-Ln; Thu, 14 Aug 2025 13:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1umbtY-0007El-9u
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 13:37:44 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1umbtS-0006lD-Nd
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 13:37:43 -0400
DKIM-Signature: a=rsa-sha256; bh=UjjLCmp4BjuXMfxENaXoTrdjjyVEDurmJ0hse4taSU8=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:In-Reply-To:To:Cc; q=dns/txt; s=20240113;
 t=1755193052; v=1;
 b=UkmdFJ5VfcE8I1k3wLjpOKZ86oa7U6fo4VnASC5efddx+M5s0n+/9oqF7zIPFas4kr7M31Cl
 Yd4U4eJTBCnGr9COcy4rdrV02oOwhk+kj54TVsqaKzF4cTYOMNom7KW9tXc42iNBVlGt8N6E2zv
 qgcwdgBGuTNLkyJEdyhka19iSqFUeN9g0e9UwSC5hY6JDD2UEtRee6LI3tVDeK2yE2Yb+dT/lOK
 Bky+ytEVuB25jCV72qJza0BUmK9LMhmIXauZH0VvD7/8ikGz4gIxP3dd/09GErrwh994uJzf1MO
 YsiAZLWwrV2eUNgLN2qNqtCuzwheUzGPGIxpySRSVvTQg==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id E031822FB6;
 Thu, 14 Aug 2025 17:37:32 +0000 (UTC)
From: ~myrslint <myrslint@git.sr.ht>
Date: Wed, 13 Aug 2025 17:53:59 +0000
Subject: [PATCH qemu v3 1/1] Default disable ignore guest PAT quirk (second
 revision)
MIME-Version: 1.0
Message-ID: <175519305258.21579.8228319741764786681-1@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <175519305258.21579.8228319741764786681-0@git.sr.ht>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_INVALID=0.1, DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: ~myrslint <myrskylintu@proton.me>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: myrslint <qemu.haziness801@passinbox.com>

Most Intel CPUs in current use have self-snoop. The few added lines of
code also check for availability of the quirk disablement option so if
some CPU does not have this feature no change of behavior will occur.

Signed-off-by: Myrsky Lintu <qemu.haziness801@passinbox.com>

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2943
---
Thanks to Alex Benn=C3=A9e <alex.bennee@linaro.org> for the kind code review
and helpful guidance.

 target/i386/kvm/kvm.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 369626f8c8..124818bf94 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -16,6 +16,7 @@
 #include "qapi/qapi-events-run-state.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
+#include <asm-x86/kvm.h>
 #include <math.h>
 #include <sys/ioctl.h>
 #include <sys/utsname.h>
@@ -3367,6 +3368,24 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         }
     }
=20
+/* if kernel version does not have it there is no point compiling this in */
+#ifdef KVM_X86_QUIRK_IGNORE_GUEST_PAT
+    /* rationale: most x86 cpus in current use have self-snoop so honoring
+     * guest pat is preferrable. as well, the bochs video driver bug which
+     * motivated making this a default enabled quirk in kvm was fixed long a=
go
+     * */
+    /* check if disabling this quirk is feasible and allowed */
+    ret =3D kvm_check_extension(s, KVM_CAP_DISABLE_QUIRKS2);
+    if (ret & KVM_X86_QUIRK_IGNORE_GUEST_PAT) {
+        ret =3D kvm_vm_enable_cap(s, KVM_CAP_DISABLE_QUIRKS2, 0, \
+                                KVM_X86_QUIRK_IGNORE_GUEST_PAT);
+        if (ret < 0) {
+            error_report("KVM_X86_QUIRK_IGNORE_GUEST_PAT available and "
+                         "modifiable but we failed to disable it\n");
+        }
+    }
+#endif
+
     return 0;
 }
=20
--=20
2.49.1

