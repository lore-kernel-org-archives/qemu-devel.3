Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF743C3ABB2
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:28:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKtxI-0003EL-JG; Fri, 30 May 2025 03:15:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtwt-0002VW-45
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:14:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtwr-0006zI-8s
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:14:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y8JL4a/QH+idHUyhD5rOXKxxtpM2ciU8EHs2uhh+XJs=;
 b=W/fMXh/cR/4FykXd59vENlcE6raU+MvItlS4I4JeIWw6bwhOk+a/tOM4jIqZ78/HN9RAG3
 j9syQ/Io8ayOx6mvL7+uAJHHNimBz0+lTrTlVR7IhtfIa3TlK5xQ+8urAMozBp09iBYdmO
 rElvV63g7uJwgFaIBInbeJzY1jthw3E=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-s9Znqwq6OnWQK2yL5Gaf-g-1; Fri, 30 May 2025 03:14:34 -0400
X-MC-Unique: s9Znqwq6OnWQK2yL5Gaf-g-1
X-Mimecast-MFC-AGG-ID: s9Znqwq6OnWQK2yL5Gaf-g_1748589273
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-604bc87037fso2083150a12.2
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:14:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589273; x=1749194073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y8JL4a/QH+idHUyhD5rOXKxxtpM2ciU8EHs2uhh+XJs=;
 b=MtbDdg635UUNeLGM7uAqUxAqwujuAObSksq0/WFMrfan7cToq1hjGEPvNkwxiKeUau
 N9bAPtC1Hi/U7HJvv1UXA+J2mzk8aoDbka5V3dSnSyo91O4d7FyF3JlIhfWE3pqYMvtY
 QgLUMsgcBkmW/uaoBRAMPT533rRKQRMtXy6WTXexYThchUO9pxdHLG8BRTxtLms7R+b0
 e3g7FezJiq3pz4Ao7p9swLAlAE+Gn+JqciVuhc7ba5K34oQSpj/6cra91YYb11IBUszP
 sQznEh0PySUgzfxlIl1MPOdUFT3I7H9aztm7cBNpzv83GXvRtuBb90xbPrc+akpJhQ1i
 D01w==
X-Gm-Message-State: AOJu0YyFFbbP6jiJxKB7XAvXYmRbkiMMNCamtxSl5TEDm/GxU6agQRSn
 N0OkmiMhmDCZRvq69y2C7bMVozb7UeC1MSsvIS4alTjQE47mxt7XVwwARJf9UNsthz2TuJuzczc
 yzpwkwpTznh/Kit1KNTCCHZH2Q4tau873fVQ6k2kTYL6CZrQTEE9Dr8ES/B5iyvURFAHP5WnJES
 RIknK0V1hhwzZ60avop/CewP4Cr21/Gshhfp+6XetV
X-Gm-Gg: ASbGncsHGIRpKl/7K6sMOJUW7pXw9qW4/TCzJX1T3qeGYSE7sMTsVvbXpiiKFwlFTpm
 hmp+9iZnOUc/4L1PvaRwVMhRXFiRV0p0Mvpl/XyArjDzXSbVkcfO7BvxO9536zYR61QT8Mlq/u7
 VPfJbwOFKduwCGuJpr8eCFCs9ijbxZbGVjb1WGLEVKGnFKlcwc2l4srKHJWn90Oy7Nvk2Cyd4Ha
 FUxwZvdrTnXghjeHVZ05wPjeKpodAVW3Q7iYOkK6VroBGlUe+jSyDeOjGY6T4zoEKSnxU30hFfC
 DpOjI3zgwNcnIg==
X-Received: by 2002:a05:6402:2113:b0:605:3251:a503 with SMTP id
 4fb4d7f45d1cf-6057c60464amr1024212a12.20.1748589272689; 
 Fri, 30 May 2025 00:14:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZFexz0DQgTq1g0nLJbgUH+NXblh+XnxqhMfCCOVZatMiKfHu+Jai0H9TnfHYo+a0Od7LQIQ==
X-Received: by 2002:a05:6402:2113:b0:605:3251:a503 with SMTP id
 4fb4d7f45d1cf-6057c60464amr1024198a12.20.1748589272212; 
 Fri, 30 May 2025 00:14:32 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60566c74edcsm1191057a12.39.2025.05.30.00.14.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:14:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 40/77] i386/tdx: Handle KVM_SYSTEM_EVENT_TDX_FATAL
Date: Fri, 30 May 2025 09:12:10 +0200
Message-ID: <20250530071250.2050910-41-pbonzini@redhat.com>
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

TD guest can use TDG.VP.VMCALL<REPORT_FATAL_ERROR> to request
termination. KVM translates such request into KVM_EXIT_SYSTEM_EVENT with
type of KVM_SYSTEM_EVENT_TDX_FATAL.

Add hanlder for such exit. Parse and print the error message, and
terminate the TD guest in the handler.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250508150002.689633-29-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/tdx.h      |  2 ++
 target/i386/kvm/kvm.c      | 10 +++++++++
 target/i386/kvm/tdx-stub.c |  5 +++++
 target/i386/kvm/tdx.c      | 46 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 63 insertions(+)

diff --git a/target/i386/kvm/tdx.h b/target/i386/kvm/tdx.h
index 36a7400e748..04b5afe199f 100644
--- a/target/i386/kvm/tdx.h
+++ b/target/i386/kvm/tdx.h
@@ -8,6 +8,7 @@
 #endif
 
 #include "confidential-guest.h"
+#include "cpu.h"
 #include "hw/i386/tdvf.h"
 
 #define TYPE_TDX_GUEST "tdx-guest"
@@ -59,5 +60,6 @@ bool is_tdx_vm(void);
 int tdx_pre_create_vcpu(CPUState *cpu, Error **errp);
 void tdx_set_tdvf_region(MemoryRegion *tdvf_mr);
 int tdx_parse_tdvf(void *flash_ptr, int size);
+int tdx_handle_report_fatal_error(X86CPU *cpu, struct kvm_run *run);
 
 #endif /* QEMU_I386_TDX_H */
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index fd1817fc5ea..c5c692a0345 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -6129,6 +6129,16 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
     case KVM_EXIT_HYPERCALL:
         ret = kvm_handle_hypercall(run);
         break;
+    case KVM_EXIT_SYSTEM_EVENT:
+        switch (run->system_event.type) {
+        case KVM_SYSTEM_EVENT_TDX_FATAL:
+            ret = tdx_handle_report_fatal_error(cpu, run);
+            break;
+        default:
+            ret = -1;
+            break;
+        }
+        break;
     default:
         fprintf(stderr, "KVM: unknown exit reason %d\n", run->exit_reason);
         ret = -1;
diff --git a/target/i386/kvm/tdx-stub.c b/target/i386/kvm/tdx-stub.c
index 7748b6d0a44..720a4ff046e 100644
--- a/target/i386/kvm/tdx-stub.c
+++ b/target/i386/kvm/tdx-stub.c
@@ -13,3 +13,8 @@ int tdx_parse_tdvf(void *flash_ptr, int size)
 {
     return -EINVAL;
 }
+
+int tdx_handle_report_fatal_error(X86CPU *cpu, struct kvm_run *run)
+{
+    return -EINVAL;
+}
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 971f4becfa4..16ad1af3c5a 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -615,6 +615,52 @@ int tdx_parse_tdvf(void *flash_ptr, int size)
     return tdvf_parse_metadata(&tdx_guest->tdvf, flash_ptr, size);
 }
 
+/*
+ * Only 8 registers can contain valid ASCII byte stream to form the fatal
+ * message, and their sequence is: R14, R15, RBX, RDI, RSI, R8, R9, RDX
+ */
+#define TDX_FATAL_MESSAGE_MAX        64
+
+int tdx_handle_report_fatal_error(X86CPU *cpu, struct kvm_run *run)
+{
+    uint64_t error_code = run->system_event.data[R_R12];
+    uint64_t reg_mask = run->system_event.data[R_ECX];
+    char *message = NULL;
+    uint64_t *tmp;
+
+    if (error_code & 0xffff) {
+        error_report("TDX: REPORT_FATAL_ERROR: invalid error code: 0x%lx",
+                     error_code);
+        return -1;
+    }
+
+    if (reg_mask) {
+        message = g_malloc0(TDX_FATAL_MESSAGE_MAX + 1);
+        tmp = (uint64_t *)message;
+
+#define COPY_REG(REG)                               \
+    do {                                            \
+        if (reg_mask & BIT_ULL(REG)) {              \
+            *(tmp++) = run->system_event.data[REG]; \
+        }                                           \
+    } while (0)
+
+        COPY_REG(R_R14);
+        COPY_REG(R_R15);
+        COPY_REG(R_EBX);
+        COPY_REG(R_EDI);
+        COPY_REG(R_ESI);
+        COPY_REG(R_R8);
+        COPY_REG(R_R9);
+        COPY_REG(R_EDX);
+        *((char *)tmp) = '\0';
+    }
+#undef COPY_REG
+
+    error_report("TD guest reports fatal error. %s", message ? : "");
+    return -1;
+}
+
 static bool tdx_guest_get_sept_ve_disable(Object *obj, Error **errp)
 {
     TdxGuest *tdx = TDX_GUEST(obj);
-- 
2.49.0


