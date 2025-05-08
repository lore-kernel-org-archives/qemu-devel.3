Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E057C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 15:14:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD2qx-00010R-7g; Thu, 08 May 2025 11:08:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uD2qk-0008LH-IP
 for qemu-devel@nongnu.org; Thu, 08 May 2025 11:07:50 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uD2qg-0007ca-E1
 for qemu-devel@nongnu.org; Thu, 08 May 2025 11:07:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746716866; x=1778252866;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8Sytcbe51Jr1Rfoh9/l3eww/oXXV/6gn0LTn37b+jC8=;
 b=bZ9OImfDNDFgibt9kllZbx5+Fu3UzQE9eu1kFek6GGBqTRhO8/9iov17
 vbmliLwJipY3OtlPLiAFqRX94+6XyPslUjTluNrpkOqQq+zqrmWqAnSsE
 CB2vhkeJlQj8I9lhxWIsEaH1cWTthdDWwfYfy9Xn+sL32EibxMB0rVUSe
 lQ7WUqO+C4A65GDuH61ZicjNsSL2znlieshHrdo6h8D886dRGsP7KB8Qs
 /rkspTd36lbZa0bD6dfomoZr8QGNqbadElCGAv2IojgmlFH8nbRN5GS38
 eTpi8Mx8860OOEJPMuifzvmWhTFXQ1EQtY4cj2cWN8Q9DqCThP+Ldstte w==;
X-CSE-ConnectionGUID: FRDrZJbgTcWwdPumw0tQMA==
X-CSE-MsgGUID: f0gA/8ByRqqL/EZj2MICPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="58716589"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; d="scan'208";a="58716589"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 08:07:45 -0700
X-CSE-ConnectionGUID: qoX4RgmGTiSwG8M5yTvtaw==
X-CSE-MsgGUID: WPd0NhotQSy4rUtB8MKJqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; d="scan'208";a="141440598"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa005.jf.intel.com with ESMTP; 08 May 2025 08:07:42 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH v9 55/55] docs: Add TDX documentation
Date: Thu,  8 May 2025 11:00:01 -0400
Message-ID: <20250508150002.689633-56-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250508150002.689633-1-xiaoyao.li@intel.com>
References: <20250508150002.689633-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.11; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add docs/system/i386/tdx.rst for TDX support, and add tdx in
confidential-guest-support.rst

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
Changes in v6:
 - Add more information of "Feature configuration"
 - Mark TD Attestation as future work because KVM now drops the support
   of it.

Changes in v5:
 - Add TD attestation section and update the QEMU parameter;

Changes since v1:
 - Add prerequisite of private gmem;
 - update example command to launch TD;

Changes since RFC v4:
 - add the restriction that kernel-irqchip must be split
---
 docs/system/confidential-guest-support.rst |   1 +
 docs/system/i386/tdx.rst                   | 161 +++++++++++++++++++++
 docs/system/target-i386.rst                |   1 +
 3 files changed, 163 insertions(+)
 create mode 100644 docs/system/i386/tdx.rst

diff --git a/docs/system/confidential-guest-support.rst b/docs/system/confidential-guest-support.rst
index 0c490dbda2b7..66129fbab64c 100644
--- a/docs/system/confidential-guest-support.rst
+++ b/docs/system/confidential-guest-support.rst
@@ -38,6 +38,7 @@ Supported mechanisms
 Currently supported confidential guest mechanisms are:
 
 * AMD Secure Encrypted Virtualization (SEV) (see :doc:`i386/amd-memory-encryption`)
+* Intel Trust Domain Extension (TDX) (see :doc:`i386/tdx`)
 * POWER Protected Execution Facility (PEF) (see :ref:`power-papr-protected-execution-facility-pef`)
 * s390x Protected Virtualization (PV) (see :doc:`s390x/protvirt`)
 
diff --git a/docs/system/i386/tdx.rst b/docs/system/i386/tdx.rst
new file mode 100644
index 000000000000..8131750b64b3
--- /dev/null
+++ b/docs/system/i386/tdx.rst
@@ -0,0 +1,161 @@
+Intel Trusted Domain eXtension (TDX)
+====================================
+
+Intel Trusted Domain eXtensions (TDX) refers to an Intel technology that extends
+Virtual Machine Extensions (VMX) and Multi-Key Total Memory Encryption (MKTME)
+with a new kind of virtual machine guest called a Trust Domain (TD). A TD runs
+in a CPU mode that is designed to protect the confidentiality of its memory
+contents and its CPU state from any other software, including the hosting
+Virtual Machine Monitor (VMM), unless explicitly shared by the TD itself.
+
+Prerequisites
+-------------
+
+To run TD, the physical machine needs to have TDX module loaded and initialized
+while KVM hypervisor has TDX support and has TDX enabled. If those requirements
+are met, the ``KVM_CAP_VM_TYPES`` will report the support of ``KVM_X86_TDX_VM``.
+
+Trust Domain Virtual Firmware (TDVF)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Trust Domain Virtual Firmware (TDVF) is required to provide TD services to boot
+TD Guest OS. TDVF needs to be copied to guest private memory and measured before
+the TD boots.
+
+KVM vcpu ioctl ``KVM_TDX_INIT_MEM_REGION`` can be used to populate the TDVF
+content into its private memory.
+
+Since TDX doesn't support readonly memslot, TDVF cannot be mapped as pflash
+device and it actually works as RAM. "-bios" option is chosen to load TDVF.
+
+OVMF is the opensource firmware that implements the TDVF support. Thus the
+command line to specify and load TDVF is ``-bios OVMF.fd``
+
+Feature Configuration
+---------------------
+
+Unlike non-TDX VM, the CPU features (enumerated by CPU or MSR) of a TD are not
+under full control of VMM. VMM can only configure part of features of a TD on
+``KVM_TDX_INIT_VM`` command of VM scope ``MEMORY_ENCRYPT_OP`` ioctl.
+
+The configurable features have three types:
+
+- Attributes:
+  - PKS (bit 30) controls whether Supervisor Protection Keys is exposed to TD,
+  which determines related CPUID bit and CR4 bit;
+  - PERFMON (bit 63) controls whether PMU is exposed to TD.
+
+- XSAVE related features (XFAM):
+  XFAM is a 64b mask, which has the same format as XCR0 or IA32_XSS MSR. It
+  determines the set of extended features available for use by the guest TD.
+
+- CPUID features:
+  Only some bits of some CPUID leaves are directly configurable by VMM.
+
+What features can be configured is reported via TDX capabilities.
+
+TDX capabilities
+~~~~~~~~~~~~~~~~
+
+The VM scope ``MEMORY_ENCRYPT_OP`` ioctl provides command ``KVM_TDX_CAPABILITIES``
+to get the TDX capabilities from KVM. It returns a data structure of
+``struct kvm_tdx_capabilities``, which tells the supported configuration of
+attributes, XFAM and CPUIDs.
+
+TD attributes
+~~~~~~~~~~~~~
+
+QEMU supports configuring raw 64-bit TD attributes directly via "attributes"
+property of "tdx-guest" object. Note, it's users' responsibility to provide a
+valid value because some bits may not supported by current QEMU or KVM yet.
+
+QEMU also supports the configuration of individual attribute bits that are
+supported by it, via properties of "tdx-guest" object.
+E.g., "sept-ve-disable" (bit 28).
+
+MSR based features
+~~~~~~~~~~~~~~~~~~
+
+Current KVM doesn't support MSR based feature (e.g., MSR_IA32_ARCH_CAPABILITIES)
+configuration for TDX, and it's a future work to enable it in QEMU when KVM adds
+support of it.
+
+Feature check
+~~~~~~~~~~~~~
+
+QEMU checks if the final (CPU) features, determined by given cpu model and
+explicit feature adjustment of "+featureA/-featureB", can be supported or not.
+It can produce feature not supported warning like
+
+  "warning: host doesn't support requested feature: CPUID.07H:EBX.intel-pt [bit 25]"
+
+It can also produce warning like
+
+  "warning: TDX forcibly sets the feature: CPUID.80000007H:EDX.invtsc [bit 8]"
+
+if the fixed-1 feature is requested to be disabled explicitly. This is newly
+added to QEMU for TDX because TDX has fixed-1 features that are forcibly enabled
+by TDX module and VMM cannot disable them.
+
+Launching a TD (TDX VM)
+-----------------------
+
+To launch a TD, the necessary command line options are tdx-guest object and
+split kernel-irqchip, as below:
+
+.. parsed-literal::
+
+    |qemu_system_x86| \\
+        -accel kvm \\
+        -cpu host \\
+        -object tdx-guest,id=tdx0 \\
+        -machine ...,confidential-guest-support=tdx0 \\
+        -bios OVMF.fd \\
+
+Restrictions
+------------
+
+ - kernel-irqchip must be split;
+
+   This is set by default for TDX guest if kernel-irqchip is left on its default
+   'auto' setting.
+
+ - No readonly support for private memory;
+
+ - No SMM support: SMM support requires manipulating the guest register states
+   which is not allowed;
+
+Debugging
+---------
+
+Bit 0 of TD attributes, is DEBUG bit, which decides if the TD runs in off-TD
+debug mode. When in off-TD debug mode, TD's VCPU state and private memory are
+accessible via given SEAMCALLs. This requires KVM to expose APIs to invoke those
+SEAMCALLs and corresonponding QEMU change.
+
+It's targeted as future work.
+
+TD attestation
+--------------
+
+In TD guest, the attestation process is used to verify the TDX guest
+trustworthiness to other entities before provisioning secrets to the guest.
+
+TD attestation is initiated first by calling TDG.MR.REPORT inside TD to get the
+REPORT. Then the REPORT data needs to be converted into a remotely verifiable
+Quote by SGX Quoting Enclave (QE).
+
+It's a future work in QEMU to add support of TD attestation since it lacks
+support in current KVM.
+
+Live Migration
+--------------
+
+Future work.
+
+References
+----------
+
+- `TDX Homepage <https://www.intel.com/content/www/us/en/developer/articles/technical/intel-trust-domain-extensions.html>`__
+
+- `SGX QE <https://github.com/intel/SGXDataCenterAttestationPrimitives/tree/master/QuoteGeneration>`__
diff --git a/docs/system/target-i386.rst b/docs/system/target-i386.rst
index ab7af1a75d6e..43b09c79d6be 100644
--- a/docs/system/target-i386.rst
+++ b/docs/system/target-i386.rst
@@ -31,6 +31,7 @@ Architectural features
    i386/kvm-pv
    i386/sgx
    i386/amd-memory-encryption
+   i386/tdx
 
 OS requirements
 ~~~~~~~~~~~~~~~
-- 
2.43.0


