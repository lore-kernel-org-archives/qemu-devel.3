Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 718EAE9A04B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 01:53:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsWkw-0000a2-Lu; Tue, 17 Feb 2026 20:53:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=502105d20=graf@amazon.de>)
 id 1vsWkv-0000YJ-Cg; Tue, 17 Feb 2026 20:53:33 -0500
Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([35.83.148.184])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=502105d20=graf@amazon.de>)
 id 1vsWkt-0005hY-BT; Tue, 17 Feb 2026 20:53:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1771379611; x=1802915611;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3hLOH/1PH9KgMpnJK/l9v0L+U9NxjDuT0ZDVOs230+4=;
 b=b8pikC+6cFajKK4rpfUDa5OfTGHbW/BzeDSBQXrQUhHaHpcjiIDw0HdZ
 887aGuywIwItqBJf3uCGmzXkQ1Dp/neIEQ+ucnUtawM15aPm2Mt2ta+rG
 fcZA3ifgct6WwLzQyTuVbZjcUHo1abGl5Ps/mbZ4paQrqKlkTClsUpUUJ
 C9iVWOGCyzvZOKJtazYXjfWXEOaueo2dF3p+WdD94S3mIRbD2H7VJImmQ
 vgULR9iu3eclXudxpWx1yMX6OF0R4yDy3rBSpXu0u107xsyCMukx8Bl7B
 tXyMJnPciAUAscyqffPb0gSzO5e61hI2qG4shxqSvWpppfckrZctMc9Lb A==;
X-CSE-ConnectionGUID: ziCxB2d/SJaHTzwBHvIBww==
X-CSE-MsgGUID: 9r57eOH5Rtqe9eS9qu958w==
X-IronPort-AV: E=Sophos;i="6.21,297,1763424000"; d="scan'208";a="13037692"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
 by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 01:53:26 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:7051]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.41:2525]
 with esmtp (Farcaster)
 id 38446c7a-17e8-442f-be23-a47edb0fb50d; Wed, 18 Feb 2026 01:53:26 +0000 (UTC)
X-Farcaster-Flow-ID: 38446c7a-17e8-442f-be23-a47edb0fb50d
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Wed, 18 Feb 2026 01:53:26 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Wed, 18 Feb 2026 01:53:23 +0000
From: Alexander Graf <graf@amazon.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, "Thomas
 Huth" <thuth@redhat.com>, <alex.bennee@linaro.org>, <philmd@linaro.org>,
 <berrange@redhat.com>, <marcandre.lureau@redhat.com>, Cornelia Huck
 <cohuck@redhat.com>, <mst@redhat.com>, Dorjoy Chowdhury
 <dorjoychy111@gmail.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Tyler Fanelli <tfanelli@redhat.com>,
 <mknaust@amazon.com>, <nh-open-source@amazon.com>
Subject: [PATCH 10/10] docs: Add Nitro Enclaves documentation
Date: Wed, 18 Feb 2026 01:51:50 +0000
Message-ID: <20260218015151.4052-11-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260218015151.4052-1-graf@amazon.com>
References: <20260218015151.4052-1-graf@amazon.com>
MIME-Version: 1.0
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D032UWA004.ant.amazon.com (10.13.139.56) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=35.83.148.184;
 envelope-from=prvs=502105d20=graf@amazon.de;
 helo=pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Now that all pieces are in place to spawn Nitro Enclaves using
a special purpose accelerator and machine model, document how
to use it.

Signed-off-by: Alexander Graf <graf@amazon.com>
---
 MAINTAINERS                                |   1 +
 docs/system/confidential-guest-support.rst |   1 +
 docs/system/index.rst                      |   1 +
 docs/system/nitro.rst                      | 128 +++++++++++++++++++++
 4 files changed, 131 insertions(+)
 create mode 100644 docs/system/nitro.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 53ce075e9a..5e9e429530 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3027,6 +3027,7 @@ M: Alexander Graf <graf@amazon.com>
 S: Maintained
 F: hw/nitro/
 F: include/hw/nitro/
+F: docs/system/nitro.rst
 
 Subsystems
 ----------
diff --git a/docs/system/confidential-guest-support.rst b/docs/system/confidential-guest-support.rst
index 66129fbab6..562a7c3c28 100644
--- a/docs/system/confidential-guest-support.rst
+++ b/docs/system/confidential-guest-support.rst
@@ -41,5 +41,6 @@ Currently supported confidential guest mechanisms are:
 * Intel Trust Domain Extension (TDX) (see :doc:`i386/tdx`)
 * POWER Protected Execution Facility (PEF) (see :ref:`power-papr-protected-execution-facility-pef`)
 * s390x Protected Virtualization (PV) (see :doc:`s390x/protvirt`)
+* AWS Nitro Enclaves (see :doc:`nitro`)
 
 Other mechanisms may be supported in future.
diff --git a/docs/system/index.rst b/docs/system/index.rst
index 427b020483..d297a95282 100644
--- a/docs/system/index.rst
+++ b/docs/system/index.rst
@@ -39,5 +39,6 @@ or Hypervisor.Framework.
    multi-process
    confidential-guest-support
    igvm
+   nitro
    vm-templating
    sriov
diff --git a/docs/system/nitro.rst b/docs/system/nitro.rst
new file mode 100644
index 0000000000..ebf118a108
--- /dev/null
+++ b/docs/system/nitro.rst
@@ -0,0 +1,128 @@
+AWS Nitro Enclaves
+==================
+
+`AWS Nitro Enclaves <https://aws.amazon.com/ec2/nitro/nitro-enclaves/>`_
+are isolated compute environments that run alongside EC2 instances.
+They are created by partitioning CPU and memory resources from a parent
+instance and launching a signed Enclave Image Format (EIF) file inside
+a confidential VM managed by the Nitro Hypervisor.
+
+QEMU supports launching Nitro Enclaves on EC2 instances that have
+enclave support enabled, using the ``nitro`` accelerator and the
+``nitro`` machine type.
+
+Prerequisites
+-------------
+
+* An EC2 instance with Nitro Enclaves enabled
+* The ``nitro_enclaves`` kernel module loaded (provides ``/dev/nitro_enclaves``)
+* CPU cores allocated to the Nitro Enclaves pool via ``nitro-enclaves-allocator``
+* Huge pages allocated for Nitro Enclaves via ``nitro-enclaves-allocator``
+
+Quick Start
+-----------
+
+Launch a Nitro Enclave from a pre-built EIF file::
+
+    $ qemu-system-x86_64 -accel nitro,debug-mode=on -M nitro -nographic \
+        -smp 2 -m 512M -kernel enclave.eif
+
+Launch an enclave from individual kernel and initrd files::
+
+    $ qemu-system-x86_64 -accel nitro,debug-mode=on -M nitro -nographic \
+        -smp 2 -m 512M -kernel vmlinuz -initrd initrd.cpio \
+        -append "console=ttyS0"
+
+The same commands work with ``qemu-system-aarch64`` on Graviton based EC2
+instances.
+
+Accelerator
+-----------
+
+The ``nitro`` accelerator (``-accel nitro``) drives the
+``/dev/nitro_enclaves`` device to create and manage a Nitro Enclave.
+It handles:
+
+* Creating the enclave VM slot
+* Donating memory regions (must be huge page backed)
+* Adding vCPUs (must be full physical cores)
+* Starting the enclave
+* Forwarding the enclave CID to devices that need it
+
+Accelerator options:
+
+``debug-mode=on|off``
+    Enable debug mode. When enabled, the Nitro Hypervisor exposes the
+    enclave's serial console output via a vsock port that the machine
+    model automatically connects to. In debug mode, PCR values are zero.
+    Default is ``off``.
+
+Machine
+-------
+
+The ``nitro`` machine (``-M nitro``) is a minimal, architecture-independent
+machine that provides only what a Nitro Enclave needs:
+
+* RAM (huge page backed via memfd)
+* vCPUs (defaults to ``host`` CPU type)
+* A heartbeat device (vsock server on port 9000)
+* A serial console bridge (vsock client, debug mode only)
+
+Communication to the Nitro Enclave is limited to virtio-vsock. The Enclave
+is allocated a CID at launch at which it is reachable. The CID is available
+as QOM property in the accelerator and as a trace event.
+
+EIF Image Format
+^^^^^^^^^^^^^^^^
+
+Nitro Enclaves boot from EIF (Enclave Image Format) files. When
+``-kernel`` points to an EIF file (detected by the ``.eif`` magic
+bytes), it is loaded directly into guest memory.
+
+When ``-kernel`` points to a regular kernel image (e.g. a bzImage or
+Image), the machine automatically assembles a minimal EIF on the fly
+from ``-kernel``, ``-initrd``, and ``-append``. This allows standard
+direct kernel boot without external EIF tooling.
+
+CPU Requirements
+^^^^^^^^^^^^^^^^
+
+Nitro Enclaves require full physical CPU cores. On hyperthreaded
+systems, this means ``-smp`` must be a multiple of the threads per
+core (typically 2).
+
+Nitro Enclaves can only consume cores that are donated to the Nitro Enclave
+CPU pool. You can configure the CPU pool using the ``nitro-enclaves-allocator``
+tool or manually by writing to the nitro_enclaves cpu pool parameter. To
+allocate vCPUs 1, 2 and 3, you can call::
+
+  $ echo 1,2,3 | sudo tee /sys/module/nitro_enclaves/parameters/ne_cpus
+
+Beware that on x86-64 systems, hyperthread siblings are not consecutive
+and must be added in pairs to the pool. Consult tools like ``lstopo``
+or ``lscpu`` for details about your instance's CPU topology.
+
+Memory Requirements
+^^^^^^^^^^^^^^^^^^^
+
+Enclave memory must be huge page backed. The machine automatically
+creates a memfd memory backend with huge pages enabled. To make the
+huge page allocation work, ensure that huge pages are reserved in
+the system. To reserve 1 GiB of memory on a 4 KiB PAGE_SIZE system,
+you can call::
+
+    $ echo 512 | sudo tee /proc/sys/vm/nr_hugepages
+
+Emulated Nitro Enclaves
+-----------------------
+
+In addition to the native Nitro Enclaves invocation, you can also use
+the emulated nitro-enclave machine target (see :doc:`i386/nitro-enclave`)
+which implements the x86 Nitro Enclave device model. While -M nitro
+delegates virtual machine device emulation to the Nitro Hypervisor, -M
+nitro-enclave implements all devices itself, which means it also works
+on non-EC2 instances.
+
+If you require NSM based attestation backed by valid AWS certificates,
+you must use -M nitro. The -M nitro-enclave model does not provide
+you with an AWS signed attestation document.
-- 
2.47.1




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


