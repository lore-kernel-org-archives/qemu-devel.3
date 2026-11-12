Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA0D606A336
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 18:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=kOQvpupI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRZnl-00063u-Mr; Thu, 12 Nov 2026 13:45:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xRZnc-0005uR-2o; Thu, 12 Nov 2026 13:45:29 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xRZnY-0003OP-GW; Thu, 12 Nov 2026 13:45:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794509113; bh=yNqxXwYUKbIOOLryjs5ryABf3e0HEegWe9ILVI/IM4Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=kOQvpupIy6JMKe871sjkblQotKztRFsWePv6zIhFj9P3ZpuAILij1ZTSDdEfIWw8q
 dVCR/YUDL5HZjWIpUnMAUmg01H9l97j6dQsbM50TqXSQhGJAH+2k6CZOkAAOr+z9mO
 P9UzBAMkqLPpDDsTe4gT1HMKMGW9zmkkpirv+HMWEhmewOHN6a6g12ClLKh7dher5Y
 B+txWrejH/QlXh6QrCf6u0T0CisKatag45/WvumvqFD/DiBHplxLa00eiPVuRtBhnZ
 BpBUGeJ6CU0Y1MVOaJcBOWSujIOcwfD6prqN8RWpHeSNi6SO71J8kEoF928hh1tJko
 btkZcBUYwHj3A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 84E6C1E5D1E;
 Thu, 12 Nov 2026 21:45:13 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 769F445AAD8;
 Thu, 12 Nov 2026 21:45:13 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 536CEB7C52; Thu, 12 Nov 2026 21:45:13 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Filip Hejsek <filip.hejsek@gmail.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 3/6] docs: fix a few typos
Date: Thu, 12 Nov 2026 21:45:06 +0300
Message-ID: <20261112184513.2324634-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261112184513.2324634-1-mjt@tls.msk.ru>
References: <20261112184513.2324634-1-mjt@tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Filip Hejsek <filip.hejsek@gmail.com>

Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 docs/devel/clocks.rst                 | 2 +-
 docs/devel/control-flow-integrity.rst | 2 +-
 docs/devel/docs.rst                   | 2 +-
 docs/devel/ebpf_rss.rst               | 2 +-
 docs/devel/multi-process.rst          | 6 +++---
 docs/devel/submitting-a-patch.rst     | 2 +-
 docs/interop/vfio-user.rst            | 2 +-
 docs/specs/ppc-spapr-hcalls.rst       | 2 +-
 docs/specs/ppc-spapr-xive.rst         | 2 +-
 docs/system/security.rst              | 2 +-
 docs/user/main.rst                    | 2 +-
 11 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/docs/devel/clocks.rst b/docs/devel/clocks.rst
index 16de32147b9..997b09c6a4e 100644
--- a/docs/devel/clocks.rst
+++ b/docs/devel/clocks.rst
@@ -280,7 +280,7 @@ so you can use this to model clock controller devices which
 have guest-programmable frequency multipliers or dividers.
 
 Similarly to ``clock_set()``, ``clock_set_mul_div()`` returns ``true`` if
-the clock state was modified; that is, if the multiplier or the diviser
+the clock state was modified; that is, if the multiplier or the divisor
 or both were changed by the call.
 
 Note that ``clock_set_mul_div()`` does not automatically call
diff --git a/docs/devel/control-flow-integrity.rst b/docs/devel/control-flow-integrity.rst
index 3d5702fa4cc..466888bdf16 100644
--- a/docs/devel/control-flow-integrity.rst
+++ b/docs/devel/control-flow-integrity.rst
@@ -39,7 +39,7 @@ are planning to also enable fuzzing, then Clang 11+ is needed (more on this
 later).
 
 Given the use of LTO, a version of AR that supports LLVM IR is required.
-The easies way of doing this is by selecting the AR provided by LLVM::
+The easiest way of doing this is by selecting the AR provided by LLVM::
 
  AR=llvm-ar-9 CC=clang-9 CXX=clang++-9 /path/to/configure --enable-cfi
 
diff --git a/docs/devel/docs.rst b/docs/devel/docs.rst
index a7768b53117..7fe7e44429f 100644
--- a/docs/devel/docs.rst
+++ b/docs/devel/docs.rst
@@ -5,7 +5,7 @@ QEMU Documentation
 
 QEMU's documentation is written in reStructuredText format and
 built using the Sphinx documentation generator. We generate both
-the HTML manual and the manpages from the some documentation sources.
+the HTML manual and the manpages from the same documentation sources.
 
 hxtool and .hx files
 --------------------
diff --git a/docs/devel/ebpf_rss.rst b/docs/devel/ebpf_rss.rst
index ed5d33767bd..85ef5476232 100644
--- a/docs/devel/ebpf_rss.rst
+++ b/docs/devel/ebpf_rss.rst
@@ -31,7 +31,7 @@ Not for all packets, the hash can/should be calculated.
 
 Note: currently, eBPF RSS does not support hash reporting.
 
-eBPF RSS turned on by different combinations of vhost-net, vitrio-net and tap configurations:
+eBPF RSS turned on by different combinations of vhost-net, virtio-net and tap configurations:
 
 - eBPF is used:
 
diff --git a/docs/devel/multi-process.rst b/docs/devel/multi-process.rst
index 4ef539c0b0b..cafe2aaba78 100644
--- a/docs/devel/multi-process.rst
+++ b/docs/devel/multi-process.rst
@@ -158,7 +158,7 @@ IOMMUs introduce another level of complexity, since the address given to
 the guest virtio device to DMA to or from is not a guest physical
 address. This case is handled by having vhost code within QEMU register
 as a listener for IOMMU mapping changes. The vhost application maintains
-a cache of IOMMMU translations: sending translation requests back to
+a cache of IOMMU translations: sending translation requests back to
 QEMU on cache misses, and in turn receiving flush requests from QEMU
 when mappings are purged.
 
@@ -573,7 +573,7 @@ live migration
 When a remote process receives a live migration indication from QEMU, it
 will set up a channel using the received file descriptor with
 ``qio_channel_socket_new_fd()``. This channel will be used to create a
-*QEMUfile* that can be passed to ``qemu_save_device_state()`` to send
+*QEMUFile* that can be passed to ``qemu_save_device_state()`` to send
 the process's device state back to QEMU. This method will be reversed on
 restore - the channel will be passed to ``qemu_loadvm_state()`` to
 restore the device state.
@@ -853,7 +853,7 @@ intx irq descriptor
 
 The irq descriptors are created by the proxy object
 ``using event_notifier_init()`` to create the irq and re-sampling
-*eventds*, and ``kvm_vm_ioctl(KVM_IRQFD)`` to bind them to an interrupt.
+*eventfds*, and ``kvm_vm_ioctl(KVM_IRQFD)`` to bind them to an interrupt.
 The interrupt route can be found with
 ``pci_device_route_intx_to_irq()``.
 
diff --git a/docs/devel/submitting-a-patch.rst b/docs/devel/submitting-a-patch.rst
index 5ccd09a3978..cd08881dfb3 100644
--- a/docs/devel/submitting-a-patch.rst
+++ b/docs/devel/submitting-a-patch.rst
@@ -241,7 +241,7 @@ Use B4
 ~~~~~~
 
 The `b4`_ tool, used for Linux kernel development, can also be used for QEMU
-development. It is packaged in most distros and PyPi. The QEMU source tree
+development. It is packaged in most distros and PyPI. The QEMU source tree
 includes a ``b4`` project configuration file at the root: ``.b4-config``.
 
 Example workflow to prepare a patch series:
diff --git a/docs/interop/vfio-user.rst b/docs/interop/vfio-user.rst
index b49781a7550..bdd73f41f41 100644
--- a/docs/interop/vfio-user.rst
+++ b/docs/interop/vfio-user.rst
@@ -1583,7 +1583,7 @@ Neither the request or reply have a payload.
 --------------------------------
 
 This message can be used to coalesce multiple device write operations
-into a single messgage.  It is only used as an optimization when the
+into a single message.  It is only used as an optimization when the
 outgoing message queue is relatively full.
 
 Request
diff --git a/docs/specs/ppc-spapr-hcalls.rst b/docs/specs/ppc-spapr-hcalls.rst
index 6cdcef20265..550026ea550 100644
--- a/docs/specs/ppc-spapr-hcalls.rst
+++ b/docs/specs/ppc-spapr-hcalls.rst
@@ -20,7 +20,7 @@ to an implementation specific range in PAPR.
 ``H_RTAS (0xf000)``
 ===================
 
-RTAS stands for Run-Time Abstraction Sercies and is a set of runtime services
+RTAS stands for Run-Time Abstraction Services and is a set of runtime services
 generally provided by the firmware inside the guest to the operating system. It
 predates the existence of hypervisors (it was originally an extension to Open
 Firmware) and is still used by PAPR and LoPAR to provide various services that
diff --git a/docs/specs/ppc-spapr-xive.rst b/docs/specs/ppc-spapr-xive.rst
index f47f739e019..8b83942a290 100644
--- a/docs/specs/ppc-spapr-xive.rst
+++ b/docs/specs/ppc-spapr-xive.rst
@@ -171,7 +171,7 @@ native exploitation mode* is selected should contain:
 - ``reg``
 
   contains the base address and size of the thread interrupt
-  managnement areas (TIMA), for the User level and for the Guest OS
+  management areas (TIMA), for the User level and for the Guest OS
   level. Only the Guest OS level is taken into account today.
 
 - ``ibm,xive-eq-sizes``
diff --git a/docs/system/security.rst b/docs/system/security.rst
index e211fdd2344..92a5d87503e 100644
--- a/docs/system/security.rst
+++ b/docs/system/security.rst
@@ -107,7 +107,7 @@ an issue as a normal bug.
   possibility of large memory peaks and apply countermeasures to
   provide continuity of host operations. It is typical for the Linux
   OOM killer to reap the process triggering host memory overcommit
-  in the case of exccessive usage, offering a degree of protection.
+  in the case of excessive usage, offering a degree of protection.
   As such, bugs which can lead to excessive/unbounded memory allocations
   will usually not be classified as security flaws, but should be
   fixed as hardening bugs.
diff --git a/docs/user/main.rst b/docs/user/main.rst
index a8ddf914249..aef33bfd9aa 100644
--- a/docs/user/main.rst
+++ b/docs/user/main.rst
@@ -23,7 +23,7 @@ System call translation
 System calls are the principle interface between user-space and the
 kernel. Generally the same system calls exist on all versions of the
 kernel so QEMU includes a generic system call translator. The
-translator takes care of adjusting endianess, 32/64 bit parameter size
+translator takes care of adjusting endianness, 32/64 bit parameter size
 and then calling the equivalent host system call.
 
 QEMU can also adjust device specific ``ioctl()`` calls in a similar
-- 
2.47.3


