Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEFE6E68975
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 10:57:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6Ss1-0001Lm-VQ; Thu, 31 Oct 2024 06:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6Srz-0001LU-RJ
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 06:57:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6Srx-0001No-M6
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 06:57:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730372244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=55aIQM9gddbzKrHVJTgsiKQ+ceS0PS+n9CtI5XDZTTs=;
 b=aMRYjoXf4wU0Q9bqNXM4AngErzNAN9kLsZVGQ9e6fZVVQnAkS1xNlagpBVfE+yrUoQjU2n
 GWNqmzos/5cvGShRPtN14IheUJ/zfI0R7SE/5swiSPKCEBVRztPD8io+L0OZvH4f0lm1B6
 FsZKSiQq/+e1zpXS0bgYBHBZJ1QMk4c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-eVnvSpcKPsaMv-bPHIt1iw-1; Thu, 31 Oct 2024 06:57:22 -0400
X-MC-Unique: eVnvSpcKPsaMv-bPHIt1iw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4315dd8fe7fso6623375e9.3
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 03:57:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730372241; x=1730977041;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=55aIQM9gddbzKrHVJTgsiKQ+ceS0PS+n9CtI5XDZTTs=;
 b=LWfq41blbVB6HR1+Zh0+3U4pD5cjyKE/SujD1DrItaTqp+OOGxeIWgU7qom6Vk33jS
 3czPOxSdpFBeZew5f9Lfllh3XFMPJzsWDbKIaRmGTqqegCt+tSMn98eYahHHm9T/KPFE
 YjLMBo09w9qDINk1d+iyVRr5x4fz519Dm2kInX6bCseaTkEUi1vyEWJ3MuMMiLg8c5lU
 7ULePLr1LbRurY2zmHItR3Jbwor/CMXCTlKoyWtQkr4TVWBGeUse8YqvRF44s1Ffri1E
 kOpnxZIgL73w6zxJ+BcXAu+IjglWRc85bArew65crDCq0WrUAgvj6GKP1ZKalaBhfyQR
 G4ew==
X-Gm-Message-State: AOJu0YyNsMhTSDR8OLQX/1blO+qWQ1y0O4eGukj5qNJU88NZcFPzNqR4
 iijx3hWuqnT9ZZYbqmfIr83q7G2xVR1MHSJKJKShYXPiYH2Bc4D+NvS3R4t1FDSGDFwGq6+42Rv
 MwZyd9RQCKvWF73P2DCM2cGrakU78x8ipbJkvqumvcO0ZE1HpxcwowT0UwTIlYnkAh/M+xf3uRP
 eBhAdqCFCPbQIqj+WFcXClWH0CwG/rA396JdyuTGM=
X-Received: by 2002:a05:600c:5249:b0:426:6e9a:7a1e with SMTP id
 5b1f17b1804b1-4319ad293bfmr175279995e9.35.1730372241274; 
 Thu, 31 Oct 2024 03:57:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIPiGI+ECz3zbycnXZli+niRupzRGEIKl1E6lbJD6rxlLNYNkbqwCwn/98hpNYG4xXFcCsxw==
X-Received: by 2002:a05:600c:5249:b0:426:6e9a:7a1e with SMTP id
 5b1f17b1804b1-4319ad293bfmr175279685e9.35.1730372240780; 
 Thu, 31 Oct 2024 03:57:20 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c116b0dasm1794894f8f.102.2024.10.31.03.57.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 03:57:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <lists@philjordan.eu>
Subject: [PATCH] target/i386/hvf: fix handling of XSAVE-related CPUID bits
Date: Thu, 31 Oct 2024 11:57:18 +0100
Message-ID: <20241031105718.110080-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

The call to xgetbv() is passing the ecx value for cpuid function 0xD,
index 0. The xgetbv call thus returns false (OSXSAVE is bit 27, which is
well out of the range of CPUID[0xD,0].ECX) and eax is not modified. While
fixing it, cache the whole computation of supported XCR0 bits since it
will be used for more than just CPUID leaf 0xD.

Furthermore, unsupported subleafs of CPUID 0xD (including all those
corresponding to zero bits in host's XCR0) must be hidden; if OSXSAVE
is not set at all, the whole of CPUID leaf 0xD plus the XSAVE bit must
be hidden.

Finally, unconditionally drop XSTATE_BNDREGS_MASK and XSTATE_BNDCSR_MASK;
real hardware will only show them if the MPX bit is set in CPUID;
this is never the case for hvf_get_supported_cpuid() because QEMU's
Hypervisor.framework support does not handle the VMX fields related to
MPX (even in the unlikely possibility that the host has MPX enabled).
So hide those bits in the new cache_host_xcr0().

Supersedes: <20241029130401.525297-1-pbonzini@redhat.com>
Cc: Phil Dennis-Jordan <lists@philjordan.eu>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 host/include/i386/host/cpuinfo.h |  1 +
 target/i386/hvf/x86_cpuid.c      | 56 +++++++++++++++++++-------------
 util/cpuinfo-i386.c              |  1 +
 3 files changed, 35 insertions(+), 23 deletions(-)

diff --git a/host/include/i386/host/cpuinfo.h b/host/include/i386/host/cpuinfo.h
index 81771733eaa..9541a64da61 100644
--- a/host/include/i386/host/cpuinfo.h
+++ b/host/include/i386/host/cpuinfo.h
@@ -9,6 +9,7 @@
 /* Digested version of <cpuid.h> */
 
 #define CPUINFO_ALWAYS          (1u << 0)  /* so cpuinfo is nonzero */
+#define CPUINFO_OSXSAVE         (1u << 1)
 #define CPUINFO_MOVBE           (1u << 2)
 #define CPUINFO_LZCNT           (1u << 3)
 #define CPUINFO_POPCNT          (1u << 4)
diff --git a/target/i386/hvf/x86_cpuid.c b/target/i386/hvf/x86_cpuid.c
index e56cd8411ba..3a116548a3d 100644
--- a/target/i386/hvf/x86_cpuid.c
+++ b/target/i386/hvf/x86_cpuid.c
@@ -21,28 +21,38 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/cpuid.h"
+#include "host/cpuinfo.h"
 #include "cpu.h"
 #include "x86.h"
 #include "vmx.h"
 #include "sysemu/hvf.h"
 #include "hvf-i386.h"
 
-static bool xgetbv(uint32_t cpuid_ecx, uint32_t idx, uint64_t *xcr)
+static bool cached_xcr0;
+static uint64_t supported_xcr0;
+
+static void cache_host_xcr0()
 {
-    uint32_t xcrl, xcrh;
-
-    if (cpuid_ecx & CPUID_EXT_OSXSAVE) {
-        /*
-         * The xgetbv instruction is not available to older versions of
-         * the assembler, so we encode the instruction manually.
-         */
-        asm(".byte 0x0f, 0x01, 0xd0" : "=a" (xcrl), "=d" (xcrh) : "c" (idx));
-
-        *xcr = (((uint64_t)xcrh) << 32) | xcrl;
-        return true;
+    if (cached_xcr0) {
+        return;
     }
 
-    return false;
+    if (cpuinfo & CPUINFO_OSXSAVE) {
+        uint64_t host_xcr0 = xgetbv_low(0);
+
+        /* Only show xcr0 bits corresponding to usable features.  */
+        supported_xcr0 = host_xcr0 & (XSTATE_FP_MASK |
+                                      XSTATE_SSE_MASK | XSTATE_YMM_MASK |
+                                      XSTATE_OPMASK_MASK | XSTATE_ZMM_Hi256_MASK |
+                                      XSTATE_Hi16_ZMM_MASK);
+        if ((supported_xcr0 & (XSTATE_FP_MASK | XSTATE_SSE_MASK)) !=
+            (XSTATE_FP_MASK | XSTATE_SSE_MASK)) {
+            supported_xcr0 = 0;
+        }
+    }
+
+    cached_xcr0 = true;
 }
 
 uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t idx,
@@ -51,6 +61,7 @@ uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t idx,
     uint64_t cap;
     uint32_t eax, ebx, ecx, edx;
 
+    cache_host_xcr0();
     host_cpuid(func, idx, &eax, &ebx, &ecx, &edx);
 
     switch (func) {
@@ -66,7 +77,8 @@ uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t idx,
         ecx &= CPUID_EXT_SSE3 | CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSSE3 |
              CPUID_EXT_FMA | CPUID_EXT_CX16 | CPUID_EXT_PCID |
              CPUID_EXT_SSE41 | CPUID_EXT_SSE42 | CPUID_EXT_MOVBE |
-             CPUID_EXT_POPCNT | CPUID_EXT_AES | CPUID_EXT_XSAVE |
+             CPUID_EXT_POPCNT | CPUID_EXT_AES |
+             (supported_xcr0 ? CPUID_EXT_XSAVE : 0) |
              CPUID_EXT_AVX | CPUID_EXT_F16C | CPUID_EXT_RDRAND;
         ecx |= CPUID_EXT_HYPERVISOR;
         break;
@@ -107,16 +119,14 @@ uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t idx,
         eax = 0;
         break;
     case 0xD:
+        if (!supported_xcr0 ||
+            (idx > 1 && !(supported_xcr0 & (1 << idx)))) {
+            eax = ebx = ecx = edx = 0;
+            break;
+        }
+
         if (idx == 0) {
-            uint64_t host_xcr0;
-            if (xgetbv(ecx, 0, &host_xcr0)) {
-                uint64_t supp_xcr0 = host_xcr0 & (XSTATE_FP_MASK |
-                                  XSTATE_SSE_MASK | XSTATE_YMM_MASK |
-                                  XSTATE_BNDREGS_MASK | XSTATE_BNDCSR_MASK |
-                                  XSTATE_OPMASK_MASK | XSTATE_ZMM_Hi256_MASK |
-                                  XSTATE_Hi16_ZMM_MASK);
-                eax &= supp_xcr0;
-            }
+            eax = supported_xcr0;
         } else if (idx == 1) {
             hv_vmx_read_capability(HV_VMX_CAP_PROCBASED2, &cap);
             eax &= CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XGETBV1;
diff --git a/util/cpuinfo-i386.c b/util/cpuinfo-i386.c
index 90f92a42dc8..c8c8a1b3705 100644
--- a/util/cpuinfo-i386.c
+++ b/util/cpuinfo-i386.c
@@ -35,6 +35,7 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
         __cpuid(1, a, b, c, d);
 
         info |= (d & bit_SSE2 ? CPUINFO_SSE2 : 0);
+        info |= (c & bit_OSXSAVE ? CPUINFO_OSXSAVE : 0);
         info |= (c & bit_MOVBE ? CPUINFO_MOVBE : 0);
         info |= (c & bit_POPCNT ? CPUINFO_POPCNT : 0);
         info |= (c & bit_PCLMUL ? CPUINFO_PCLMUL : 0);
-- 
2.47.0


