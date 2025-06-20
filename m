Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F15C5C7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 16:43:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSeos-0007p2-4C; Fri, 20 Jun 2025 12:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uSeoa-0007Aw-6c
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 12:42:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uSeoY-0000NU-ME
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 12:42:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750437725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bPyEsEyR+eeawbg8Mgoqk136AaGHZYCr52XL3CFj5p0=;
 b=ij/bELWj6L/urAMxxV73tsrdV4S6aXb333vrBp9ivz10ZevARosoVl6MmgRozmLaiyq35V
 PuM0W+F8HVKH2oA80PO78u45XlC60rqEc+z/8O8ZGByP9734FM19Bk2vWrsGF4xDQrx6c+
 +yWTe+wVF16ia+CHO9nXNva/qlvw0Tc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-0wsDLc3ePbW9x2OKeL9xwQ-1; Fri, 20 Jun 2025 12:42:04 -0400
X-MC-Unique: 0wsDLc3ePbW9x2OKeL9xwQ-1
X-Mimecast-MFC-AGG-ID: 0wsDLc3ePbW9x2OKeL9xwQ_1750437723
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-607c91a207dso1833170a12.2
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 09:42:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750437722; x=1751042522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bPyEsEyR+eeawbg8Mgoqk136AaGHZYCr52XL3CFj5p0=;
 b=wqB4mkPAVnjA1rsr6dBuR4XYPphxEVpRVs3IHLkmszL1tGu3LP0GvbmKZ720glugNN
 MH29keW1rkk7Ll3Xp+ewP4EKRLqrzKQHyCvZUCYsQ+Mq7ZPSgNlpH/6p1/9Pwo4oM9XL
 fMKICQSJcJZPkUeyNZZJsdO0zFFi2njskWGitDZA+0z+P4PnizisUX9pk6F7nlLrPiru
 Oy4MMcaHMWB//wngbxulYjUe5D7YdjnfY2Z1pVTXhNVyCA98sZhIttqBF4eOtE8OrF5Q
 NxfiScIPpeEdUZ0CkS58GZ82YD4x5sfnOs4VFHDpOA4PxoXL66Re7Of6j1zHHnHciw6q
 p0mg==
X-Gm-Message-State: AOJu0Yw7AuZYXMCfk+kft4exJkbiqnNg+fagPXshzaG91EcCRTEhHcUy
 vIlFNXGGErCIY+HDBNOoEIQ2yeGOZ/XR8QcZ/EZjRnN0TD3NqvVcr4XPIGbRzzAlhLDlyfId29P
 kb3AiktlZl8ixoftJABqmX9NLaS9vPc3dM8mnGoUAttxa7ozhYMPjBXlqTA0DvTuk6+LJVpvyoG
 EQi1uuW/D2ocM+noo495rN/V9iNu/rJS20sL27lXiL
X-Gm-Gg: ASbGncuyeVRH9U3lzEaB24tRxhpw7Z5HTYCe8qnaY/PZNF8wFxKSvAsbH6is+w2L0DR
 kB/7UyhV/yE8FANxjRvka2wGPW0x8+irdEpcFh1AlZ4qfTmqrKjEjeOwCczbnu1ofnuP/baSyQQ
 y4szw4YqJFAsgKi2pM94RYy3j/tjBPm4+A21WLDo9MjR+14BFHUWw0Htw5PGlI5NtaLeWONfgU1
 WeeOfqEmxM7awhG4O21Ihb/k1FQT7Bupjh+klgontYTwR6ProUrHAI7jgnq1+VJwVUJBhiMqQwP
 INa53uR52fTm2+lsEts9TpoGaw==
X-Received: by 2002:a05:6402:50c9:b0:604:bbd2:7c6c with SMTP id
 4fb4d7f45d1cf-60a1d19192amr3403845a12.27.1750437722639; 
 Fri, 20 Jun 2025 09:42:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlz6BoAxCUEJjgcQa1ACErmLeWI4wLoFzZZK2Fthe2g3GPIjgK2aifLaLOGdbU1tSyl9icQg==
X-Received: by 2002:a05:6402:50c9:b0:604:bbd2:7c6c with SMTP id
 4fb4d7f45d1cf-60a1d19192amr3403816a12.27.1750437722107; 
 Fri, 20 Jun 2025 09:42:02 -0700 (PDT)
Received: from [192.168.122.1] ([151.62.200.93])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60a18d0e561sm1645327a12.81.2025.06.20.09.41.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 09:42:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Binbin Wu <binbin.wu@linux.intel.com>
Subject: [PULL 23/24] i386/tdx: handle TDG.VP.VMCALL<GetTdVmCallInfo>
Date: Fri, 20 Jun 2025 18:40:51 +0200
Message-ID: <20250620164053.579416-24-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620164053.579416-1-pbonzini@redhat.com>
References: <20250620164053.579416-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Binbin Wu <binbin.wu@linux.intel.com>

Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/tdx.h      |  9 +++++++++
 target/i386/kvm/kvm.c      | 12 ++++++++++++
 target/i386/kvm/tdx-stub.c |  4 ++++
 target/i386/kvm/tdx.c      | 12 ++++++++++++
 4 files changed, 37 insertions(+)

diff --git a/target/i386/kvm/tdx.h b/target/i386/kvm/tdx.h
index 8dd66e90149..0dd41d5811a 100644
--- a/target/i386/kvm/tdx.h
+++ b/target/i386/kvm/tdx.h
@@ -21,6 +21,14 @@ typedef struct TdxGuestClass {
 /* TDX requires bus frequency 25MHz */
 #define TDX_APIC_BUS_CYCLES_NS 40
 
+#define TDVMCALL_GET_TD_VM_CALL_INFO    0x10000
+
+#define TDG_VP_VMCALL_SUCCESS           0x0000000000000000ULL
+#define TDG_VP_VMCALL_RETRY             0x0000000000000001ULL
+#define TDG_VP_VMCALL_INVALID_OPERAND   0x8000000000000000ULL
+#define TDG_VP_VMCALL_GPA_INUSE         0x8000000000000001ULL
+#define TDG_VP_VMCALL_ALIGN_ERROR       0x8000000000000002ULL
+
 enum TdxRamType {
     TDX_RAM_UNACCEPTED,
     TDX_RAM_ADDED,
@@ -61,5 +69,6 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **errp);
 void tdx_set_tdvf_region(MemoryRegion *tdvf_mr);
 int tdx_parse_tdvf(void *flash_ptr, int size);
 int tdx_handle_report_fatal_error(X86CPU *cpu, struct kvm_run *run);
+void tdx_handle_get_tdvmcall_info(X86CPU *cpu, struct kvm_run *run);
 
 #endif /* QEMU_I386_TDX_H */
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 56a6b9b6381..8ef29fc1fb1 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -6170,6 +6170,18 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
             break;
         }
         break;
+    case KVM_EXIT_TDX:
+        /*
+         * run->tdx is already set up for the case where userspace
+         * does not handle the TDVMCALL.
+         */
+        switch (run->tdx.nr) {
+        case TDVMCALL_GET_TD_VM_CALL_INFO:
+            tdx_handle_get_tdvmcall_info(cpu, run);
+            break;
+        }
+        ret = 0;
+        break;
     default:
         fprintf(stderr, "KVM: unknown exit reason %d\n", run->exit_reason);
         ret = -1;
diff --git a/target/i386/kvm/tdx-stub.c b/target/i386/kvm/tdx-stub.c
index 720a4ff046e..62a12a06775 100644
--- a/target/i386/kvm/tdx-stub.c
+++ b/target/i386/kvm/tdx-stub.c
@@ -18,3 +18,7 @@ int tdx_handle_report_fatal_error(X86CPU *cpu, struct kvm_run *run)
 {
     return -EINVAL;
 }
+
+void tdx_handle_get_tdvmcall_info(X86CPU *cpu, struct kvm_run *run)
+{
+}
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 2284167141a..ef10a193474 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -1120,6 +1120,18 @@ int tdx_parse_tdvf(void *flash_ptr, int size)
     return tdvf_parse_metadata(&tdx_guest->tdvf, flash_ptr, size);
 }
 
+void tdx_handle_get_tdvmcall_info(X86CPU *cpu, struct kvm_run *run)
+{
+    if (run->tdx.get_tdvmcall_info.leaf != 1) {
+	return;
+    }
+
+    run->tdx.get_tdvmcall_info.r11 = 0;
+    run->tdx.get_tdvmcall_info.r12 = 0;
+    run->tdx.get_tdvmcall_info.r13 = 0;
+    run->tdx.get_tdvmcall_info.r14 = 0;
+}
+
 static void tdx_panicked_on_fatal_error(X86CPU *cpu, uint64_t error_code,
                                         char *message, uint64_t gpa)
 {
-- 
2.49.0


