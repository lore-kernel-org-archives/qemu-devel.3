Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED5610AB807
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 19:34:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5qT9-0006cl-MI; Thu, 26 Mar 2026 15:34:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w5qT4-0006cF-7u
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 15:34:11 -0400
Received: from ci-2007k-snip4-3.eps.apple.com ([57.103.88.106]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w5qT1-0001bq-H7
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 15:34:09 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-10-percent-2 (Postfix) with ESMTPS id
 932341800230; Thu, 26 Mar 2026 19:34:04 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774553646; x=1777145646;
 bh=Z2GXF6JkWnG4bNH3Npk9vxvt+C3D4CCl9HJXD6T5u1s=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=SJUT9OXjtj88EB+3FSh7uvsREo5TbNxmHITGhawGEGnYK0LJo0+2Pmoh2B1tnWdSZM+79w1r86cfM57PMOrDl4I/nmlj34cQI0SUIM4P9OUiUbNVAm1YWO8t6fj4KkaWO/pQfclSd9lfsBTTDiBm144fPu4+49aESk4ST7fs0WEoUibnyIngo4TiRW9xHGkyQ8dkhmXg171HV1KBmRBodAzn1i3v3WDYGsCbbktmdDmgrVExq5C1R9q0xU4bZh4hY7g+XLJevBXYpf+knK6vlD8Ip+dLaaez+yeOyEuzv0EtRt7+CSMteIyznD5N1Uklf26okqfMnqdfywZ8Zy9Mug==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-10-percent-2 (Postfix) with ESMTPSA id
 92EA81800096; Thu, 26 Mar 2026 19:34:02 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v4 1/3] docs: add WHPX section with initial info
Date: Thu, 26 Mar 2026 20:33:56 +0100
Message-ID: <20260326193358.97858-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260326193358.97858-1-mohamed@unpredictable.fr>
References: <20260326193358.97858-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ghvpxl_OnPsMTqCONNn9A6CvirZFyJ0D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDE0MCBTYWx0ZWRfX4Z1C4G2B77V6
 P8zueCADY8ePk6Sz/1Fvz6i0u7ptvRUPMKBmxvImXeisxfeve0yeGx7Xn+RYZZXHyV1T8MN7zj+
 nfB7g+uEH52WIsFGKZaVVeOmcv4eLOUnC0NPKn1qYcjHFWjvIngyKeQ6r64Uy071WpRb3rcJLYU
 cgqssULRlnIl6vuV5olY0EJP73Em2i1BECU/cuYDp7HRQ+rDu2+9WEiOs1ULbunD82c65hM0Ivm
 41STp4BCcN8Uu6Wvi1eLD8m77LZP83PHLB/xRlqtsrIKkIBrcMIhlAYMRUOOdUT1CtE/CeuCn4e
 hPogpMSp8gibsiL/Jh6/1usvnbAuyd9ijQBToidyb4QN8PwEqEV8yBvBb17kkE=
X-Authority-Info-Out: v=2.4 cv=Y671cxeN c=1 sm=1 tr=0 ts=69c58a2d
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yMhMjlubAAAA:8 a=WaZvilOYPjjn8e_oVx0A:9
X-Proofpoint-GUID: ghvpxl_OnPsMTqCONNn9A6CvirZFyJ0D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 spamscore=0 phishscore=0 mlxscore=0 clxscore=1030 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603260140
Received-SPF: pass client-ip=57.103.88.106;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 docs/system/whpx.rst  | 144 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 146 insertions(+)
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
index 0000000000..16065c4f6c
--- /dev/null
+++ b/docs/system/whpx.rst
@@ -0,0 +1,144 @@
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
+Some tracing options
+--------------------
+
+x86_64
+^^^^^^
+
+`-trace whpx_unsupported_msr_access` can be used to log accesses
+to undocumented MSRs.
+
+`-d guest_errors` allows to trace accesses to unmapped
+GPAs.
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


