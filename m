Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CD5F10A88D2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 15:27:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5mbd-0002NZ-RZ; Thu, 26 Mar 2026 11:26:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w5mbP-0002Kb-Uc
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 11:26:33 -0400
Received: from p-east2-cluster4-host9-snip4-6.eps.apple.com ([57.103.78.217]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w5mbN-0005fj-G7
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 11:26:31 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-20-percent-2 (Postfix) with ESMTPS id
 6F9D2180041D; Thu, 26 Mar 2026 15:26:26 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774538787; x=1777130787;
 bh=w/urdvCZrd52R9D39ZIMQHtGZ2DYgsZO2e5sV+akbV4=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=JH+5v6wVCI1gbZML1SjZFdV4TaWULDfY8fhU599OZa4ft8FDt/l8xLcXggLJCrqrsiV/LUo3vC4u/mUm2JSsvI4pw+NgAwZiCLqdtxbiVWvHaEhV03wafJSNEPU5emV1NxcsfnebZhBLy7Kn2ckOztxPqBvciYKPvGhNpTDgIY/XV2VKafmSfGaIh++9wx1STjwY3XUWzgRtlZyzZZ7KfSuqR4EIDhnUPhliFHHtmF7/e9iJCTh+BZ9FemsG+Wyj/kfITqUmjD6ylEzGCvkc308cQ5mZrmdOVMo0aFB8XHMTyPl5n5wOaUQK+RoMu05H1qm8ze6M8JcuX2b4bZ+kXw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-20-percent-2 (Postfix) with ESMTPSA id
 42A851800403; Thu, 26 Mar 2026 15:26:25 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v2] docs: add WHPX section with initial info
Date: Thu, 26 Mar 2026 16:26:22 +0100
Message-ID: <20260326152622.92334-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: YQZi4RJ_j0ZYRtyKKliqfJssYrnZqTpN
X-Authority-Info-Out: v=2.4 cv=M8dA6iws c=1 sm=1 tr=0 ts=69c55022
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yMhMjlubAAAA:8 a=WaZvilOYPjjn8e_oVx0A:9
X-Proofpoint-ORIG-GUID: YQZi4RJ_j0ZYRtyKKliqfJssYrnZqTpN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDEwOSBTYWx0ZWRfX3BwOkq+fGCDR
 z+4ZFZ4GSjbjobs6xKuZLJCyWZoqN5rO0hvAKgzUzg3FP7gOYBbqX+IILEUQreyuv41eAN1Odyj
 vskBdbgjbUQR392ju1LEieZslObqeg9hJRxoqhe/VVyreJPjJiZHA71ETHhdJJ2h0p8X6tGeOuv
 r/SL86IsS/LkeMjca4s7lu4gpP5fH5XdmnGoQMEyrIToDSW9bdMulCjrsigoh042Ma/NHPCQv7P
 BhzcrNpiLaf4SAYBatPsygZOIyVZ4gQvq61r/nBFd5/+k5G5ipwpSiZ8VyTZ1CO6xEc7Lk1LtVh
 4dGtbPCcBoiJ21npIzYB+SkG/5Sh6FfrIqyh1aqlWUoQserDuveE4xjRGeZY/c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 clxscore=1030 phishscore=0
 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603260109
Received-SPF: pass client-ip=57.103.78.217;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 MAINTAINERS           |   1 +
 docs/system/index.rst |   1 +
 docs/system/whpx.rst  | 136 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 138 insertions(+)
 create mode 100644 docs/system/whpx.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index cd8ba14450..eb7132e39d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -582,6 +582,7 @@ F: include/system/whpx.h
 F: include/system/whpx-accel-ops.h
 F: include/system/whpx-common.h
 F: include/system/whpx-internal.h
+F: docs/system/whpx.rst
 
 MSHV
 M: Magnus Kulke <magnuskulke@linux.microsoft.com>
diff --git a/docs/system/index.rst b/docs/system/index.rst
index bb948e2993..4509630fa4 100644
--- a/docs/system/index.rst
+++ b/docs/system/index.rst
@@ -40,6 +40,7 @@ or Hypervisor.Framework.
    confidential-guest-support
    igvm
    nitro
+   whpx
    vm-templating
    sriov
    qemu-colo
diff --git a/docs/system/whpx.rst b/docs/system/whpx.rst
new file mode 100644
index 0000000000..15360ebca9
--- /dev/null
+++ b/docs/system/whpx.rst
@@ -0,0 +1,136 @@
+Windows Hypervisor Platform
+===========================
+
+Windows Hypervisor Platform is the Windows API for use of
+third-party virtual machine monitors with hardware acceleration
+on Hyper-V.
+
+It's implemented on top of `Vid`, which is itself implemented
+on the same set of hypercalls as the `mshv` driver on Linux.
+
+WHPX is the name of the Windows Hypervisor Platform accelerator
+backend in QEMU. It enables using QEMU with hardware acceleration
+on both x86_64 and arm64 Windows machines.
+
+Prerequisites
+-------------
+
+WHPX requires the Windows Hypervisor Platform feature to be installed.
+
+Installation
+^^^^^^^^^^^^
+On client editions of Windows, that means installation through
+Windows Features (`optionalfeatures.exe`). On server editions,
+feature-based installation in Server Manager can be used.
+
+Alternatively, command line installation is also possible through:
+`DISM /online /Enable-Feature /FeatureName:HypervisorPlatform /All`
+
+Minimum OS version
+^^^^^^^^^^^^^^^^^^
+
+On x86_64, QEMU's Windows Hypervisor Platform backend is tested 
+starting from Windows 10 version 2004. Earlier Windows 10 releases
+*might* work but are not tested.
+
+On arm64, Windows 11 24H2 with the April 2025 optional updates
+or May 2025 security updates is the minimum required release. 
+
+Prior releases of Windows 11 version 24H2 on ARM64 shipped 
+with a pre-release version of the Windows Hypervisor Platform
+API, which is not supported in QEMU.
+
+Quick Start
+-----------
+
+Launching a virtual machine on x86_64 with WHPX acceleration::
+
+    $ qemu-system-x86_64.exe -accel whpx -M pc \
+        -smp cores=2 -m 2G -device ich9-usb-ehci1 \
+        -device usb-tablet -hda OS.qcow2
+
+Launching a virtual machine on arm64 with WHPX acceleration::
+
+    $ qemu-system-aarch64.exe -accel whpx -M virt \
+        -cpu host -smp cores=2 -m 2G \
+        -bios edk2-aarch64-code.fd \
+        -device ramfb -device nec-usb-xhci \
+        -device usb-kbd -device usb-tablet \
+        -hda OS.qcow2
+
+On arm64, for non-Windows guests, `-device virtio-gpu-pci` provides
+additional fuctionality compared to `-device ramfb`, but is
+incompatible with Windows's UEFI GOP implementation, which
+expects a linear framebuffer to be available.
+
+Known issues on x86_64
+----------------------
+
+Guests using legacy VGA modes
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+In guests using VGA modes that QEMU doesn't pass through framebuffer
+memory for, performance will be quite suboptimal.
+
+Workaround: for affected guests, use a more modern graphics mode.
+Alternatively, use TCG to run those guests.
+
+Guests using MMX, SSE or AVX instructions for MMIO
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Currently, `target/i386/emulate` does not support guests that use
+MMX, SSE or AVX instructions for access to MMIO memory ranges.
+
+Attempts to run such guests will result in an `Unimplemented handler`
+warning for MMX and a failure to decode for newer instructions.
+
+`-M isapc`
+^^^^^^^^^^
+
+`-M isapc` doesn't disable the Hyper-V LAPIC on its own yet. To
+be able to use that machine, use `-accel whpx,hyperv=off,kernel-irqchip=off`.
+
+However, in QEMU 11.0, the guest will still be a 64-bit x86
+ISA machine with all the corresponding CPUID leaves exposed.
+
+gdbstub
+^^^^^^^
+
+As save/restore of xsave state is not currently present, state
+exposed through GDB will be incomplete.
+
+The same also applies to `info registers`.
+
+-cpu `type` ignored
+^^^^^^^^^^^^^^^^^^^
+
+In this release, -cpu is an ignored argument. 
+
+PIC interrupts on Windows 10
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+QEMU's Windows Hypervisor Platform backend is tested starting from
+Windows 10 version 2004. Earlier Windows 10 releases *might* work
+but are not tested.
+
+On Windows 10, a legacy PIC interrupt injected does not wake the guest
+from an HLT when using the Hyper-V provided interrupt controller.
+
+This has been addressed in QEMU 11.0 on Windows 11 platforms but
+functionality to make it available on Windows 10 isn't present.
+
+Workaround: for affected use cases, use `-M kernel-irqchip=off`.
+
+Known issues on Windows 11
+^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Nested virtualisation-specific Hyper-V enlightenments are not
+currently exposed.
+
+arm64
+-----
+
+ISA feature support
+^^^^^^^^^^^^^^^^^^^
+
+SVE and SME are not currently supported.
-- 
2.50.1 (Apple Git-155)


