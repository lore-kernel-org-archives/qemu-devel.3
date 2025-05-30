Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E992C3ABB2
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:25:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKu1n-0002lC-CL; Fri, 30 May 2025 03:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKty2-0004cv-Jv
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:15:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKty0-0007Gt-Aj
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:15:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T+58v5yeKIvS9DOOa9Ophn6m91xL4/YTcGnIZp0dgwM=;
 b=FZebUYHUb5Z1w2qHvaZKhQHIUrbPUgz4NOSxaiFBKLG2CMRgIQNcm8iPT9FRcZY9Kx7eLC
 z0dmFIJ+RcWZiGafPMBl62TNDzh2CDthQbv1xX3CGKXr1MqfyNCb/+MDdej1quu8fO2R+m
 wL6fRpykS6yNm8EQJyr41L8FyFusnxM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-RS-Q8nSmPqGfyqNi-pWhzQ-1; Fri, 30 May 2025 03:15:46 -0400
X-MC-Unique: RS-Q8nSmPqGfyqNi-pWhzQ-1
X-Mimecast-MFC-AGG-ID: RS-Q8nSmPqGfyqNi-pWhzQ_1748589345
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ad5697c4537so184536066b.0
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:15:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589344; x=1749194144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T+58v5yeKIvS9DOOa9Ophn6m91xL4/YTcGnIZp0dgwM=;
 b=l+2un2PnBxbzktYIdk3WNPJorXc2R0PCplvmZs3A8VJP9RT0Nbc9y/JvIRTtZlQhZC
 PpN2mhC3VSfj/B+I9J1Bmys0AsBkWU3XWW4YFxYTZ2lxzcwC3G+6Ia5nlKC63AeabuJH
 yJMg/4mUCE8VTr2D2GvIvlzCQRL0q4R3uNqggruZc7SlFQTxm/ujHzdUg3kARSUEMIH0
 8547ALou018Qte6qTwDzWaqMC8ifFnuI+32Uue8JJ2ZJB/N6fnoTVpgVZwJQ/5Cl+exo
 tyaL1E6PnnYSmyIDOqPy7zY88uFq1s3yJnDdaNy/LlWSmlJKSkRaLo4Jd3p3qPFTLwq8
 d90A==
X-Gm-Message-State: AOJu0YwxTs0hyP4+b4ciINzVD4p9o5qe0lK+DdFWuogtis1jo/3mAiRG
 70O8pYJujjeuHWF+YlddyeoxWxnBsDn6MoPvnmv4A4v20lo+IWaJcuOMsomUPQSRKtPqAI5lSfI
 Q5jjukF+tVwGlr1BjgQg0CZx+zr/2gBbFQ8UI2UM8zKA2kOb1gu8XEjOUK/OeRQDN9AA3bUxeL+
 WmN6nv2MT5qMH6meik3nL3tNGb+m585pzi0iT2Yar8
X-Gm-Gg: ASbGncv60yOMKGOzGzeLgPB7LfTQpoUGdjDXMLUH+qS621qxmvtjOB9TLwZbp83Rcqp
 VWVXlLeoeSRMCL/lGYUxAEtid0LAUuCi2wVkoxxIZi8cl3e+PReHDNZwlAHfg5nrzTBNNV758A5
 MmqIgkZDNETxSkqWgtj/8cNBRNOyL/ZQGJDQ/Z2jYgnk6lqrQB+/+yn8JlpxriH1ep/xmL15QF/
 Dbriwv+IVsfWbK+qEVCu6N2JIDh6sVXrMn0wpvp+XVv5kzEOVLzGvZs0kadPrGRgMbaQqW5e+L2
 lxk3EA/6wwrwJA==
X-Received: by 2002:a17:907:72cc:b0:ad8:93f6:6637 with SMTP id
 a640c23a62f3a-ad8b0e37746mr574210166b.21.1748589343873; 
 Fri, 30 May 2025 00:15:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5y/uz1bU92SGk7KGL+JAM2tWuHF1USFgidXrgTHb43xRVAs99zvDlopI0/3z8aqrk8R6VqA==
X-Received: by 2002:a17:907:72cc:b0:ad8:93f6:6637 with SMTP id
 a640c23a62f3a-ad8b0e37746mr574207666b.21.1748589343278; 
 Fri, 30 May 2025 00:15:43 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5d7fef66sm274232766b.29.2025.05.30.00.15.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:15:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 69/77] docs: Add TDX documentation
Date: Fri, 30 May 2025 09:12:39 +0200
Message-ID: <20250530071250.2050910-70-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530071250.2050910-1-pbonzini@redhat.com>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

Add docs/system/i386/tdx.rst for TDX support, and add tdx in
confidential-guest-support.rst

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/r/20250508150002.689633-56-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/system/confidential-guest-support.rst |   1 +
 docs/system/i386/tdx.rst                   | 161 +++++++++++++++++++++
 docs/system/target-i386.rst                |   1 +
 3 files changed, 163 insertions(+)
 create mode 100644 docs/system/i386/tdx.rst

diff --git a/docs/system/confidential-guest-support.rst b/docs/system/confidential-guest-support.rst
index 0c490dbda2b..66129fbab64 100644
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
index 00000000000..8131750b64b
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
index ab7af1a75d6..43b09c79d6b 100644
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
2.49.0


