Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1712C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:13:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubH7P-0008Ei-9P; Mon, 14 Jul 2025 07:13:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubGzQ-0000js-RN
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:04:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubGzO-0001bY-6u
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:04:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eGWtRvpv874ViWc5Pm3mZOHws7lFktTmKEM+SKQfshM=;
 b=AvN4T1sZozpFYhcyVZiWixAM14HVKTasKfC2A2EHBTu0hohn6/Jlx9EPlQcFlBdtXYxZKZ
 I9ruibtjIYRMFZAAuGvbb0x5W6uO3Plz/5OAW8BmK3VK7lRur0BEJCAGZERymJKPsfsIDr
 hl0WW+jwt0pAUzEGoy6Qf60RqlYF2JY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-UhQfqynSMwqQf5kMZJQ5_w-1; Mon, 14 Jul 2025 07:04:52 -0400
X-MC-Unique: UhQfqynSMwqQf5kMZJQ5_w-1
X-Mimecast-MFC-AGG-ID: UhQfqynSMwqQf5kMZJQ5_w_1752491091
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4538f375e86so32944975e9.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:04:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491090; x=1753095890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eGWtRvpv874ViWc5Pm3mZOHws7lFktTmKEM+SKQfshM=;
 b=xId8j8HostJl/1uxeQhTsPkFUmMxJqlv4jZGcZ1tmvn0cD5firLZGwi+aELpvLcGkL
 PYizwmoycvdSXkiGwHPRZkpzhT5p/OUHPHGdRgoibskHllcR+4Aa/MRlcq5xMqrdUw5r
 qIchwT41xW3Ah0NZzEvAPkAyXHLAvZp7ZZvVuRLEbQmz5WEV/xD3RBn4cHl5x+q9EfdB
 McQ9rAi3+TNmX17TzexJNhJRt1Rj50xAwud7PCdi2lEZteQvkDIm/0IlJfNlVm/nXLvP
 FzIWl3OwmjuxJ192VJ+h+HVNzMu7142jvnA9gHK+MgfA8tdKFiFPqAkl7N5eOqOy0iAP
 d0+g==
X-Gm-Message-State: AOJu0Yw+4hRKtpG90uXkUJ3y7tdJsLdhFFWGBfVUYKyi/5NZnMtA2V6t
 2hZvRDSAKhKCl3fWBl0hN++QMxXRtNilRbkIObUb7wjEQtpdCu0QBaJnTr6x5yYOo/CIVLiIigc
 ksiXzKr9BuvNZ6KOMP6vNmQyVBQnlVzqNBa9vmYhMX7i9HCYkcgasgA+V1dQUi3czn1IuKWMZaH
 rdfNC0BHppPQq6DJ1UHxfALPoMvH43yNfCbk9LgptV
X-Gm-Gg: ASbGncviV0UGNiMHigtHT2NKNM/I5+YaRllVF+HpPnNBTM8Ur9lKD1ryCpqQGjzeWsJ
 3bAB9cOnWQHtz7rWxpKLK3BHWpVejUsc9fcwB9zvow/2Yq9LARc09MlGkTtMfIIxtYx/Ql8Ivog
 xjbiQPrjF8ioYsbFwJ/KNZgCAI+u622bnzG5/6xnWVwTrJkJiIXVXsrKALxWwu3A2mI58Sj29zQ
 4kY6R696vDoPfBnY8eWB22726eECB1QNlbJuzuReRh6LZEveo8ohSgySonOevmrnWUy2IKFcAH2
 cJxVmMaHwvT/LZBmnH8pY1jwqSXCxg2SuX0sPHp5I0o=
X-Received: by 2002:a05:600c:6287:b0:43c:ec0a:ddfd with SMTP id
 5b1f17b1804b1-454ec13399cmr126953895e9.6.1752491090021; 
 Mon, 14 Jul 2025 04:04:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJstCtnalZW33ajjrVUMQ8Oh8lPSDXJXXyqx652Mvv4s0WW9gOiZI2VRAM4rbxay8xwi+iqQ==
X-Received: by 2002:a05:600c:6287:b0:43c:ec0a:ddfd with SMTP id
 5b1f17b1804b1-454ec13399cmr126953535e9.6.1752491089444; 
 Mon, 14 Jul 2025 04:04:49 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d5037fa0sm168013585e9.7.2025.07.14.04.04.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:04:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 15/77] i386/tdx: handle TDVMCALL_SETUP_EVENT_NOTIFY_INTERRUPT
Date: Mon, 14 Jul 2025 13:03:04 +0200
Message-ID: <20250714110406.117772-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714110406.117772-1-pbonzini@redhat.com>
References: <20250714110406.117772-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Record the interrupt vector and the apic id of the vcpu that calls
TDVMCALL_SETUP_EVENT_NOTIFY_INTERRUPT.

Inject the interrupt to TD guest to notify the completion of <GetQuote>
when notify interrupt vector is valid.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/r/20250703024021.3559286-5-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/tdx.h      |  7 ++++++
 target/i386/kvm/kvm.c      |  3 +++
 target/i386/kvm/tdx-stub.c |  4 ++++
 target/i386/kvm/tdx.c      | 48 +++++++++++++++++++++++++++++++++++++-
 4 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/target/i386/kvm/tdx.h b/target/i386/kvm/tdx.h
index d439078a876..1c38faf9834 100644
--- a/target/i386/kvm/tdx.h
+++ b/target/i386/kvm/tdx.h
@@ -25,6 +25,7 @@ typedef struct TdxGuestClass {
 
 #define TDVMCALL_GET_TD_VM_CALL_INFO    0x10000
 #define TDVMCALL_GET_QUOTE		 0x10002
+#define TDVMCALL_SETUP_EVENT_NOTIFY_INTERRUPT   0x10004
 
 #define TDG_VP_VMCALL_SUCCESS           0x0000000000000000ULL
 #define TDG_VP_VMCALL_RETRY             0x0000000000000001ULL
@@ -32,6 +33,8 @@ typedef struct TdxGuestClass {
 #define TDG_VP_VMCALL_GPA_INUSE         0x8000000000000001ULL
 #define TDG_VP_VMCALL_ALIGN_ERROR       0x8000000000000002ULL
 
+#define TDG_VP_VMCALL_SUBFUNC_SET_EVENT_NOTIFY_INTERRUPT BIT_ULL(1)
+
 enum TdxRamType {
     TDX_RAM_UNACCEPTED,
     TDX_RAM_ADDED,
@@ -64,6 +67,9 @@ typedef struct TdxGuest {
     /* GetQuote */
     SocketAddress *qg_sock_addr;
     int num;
+
+    uint32_t event_notify_vector;
+    uint32_t event_notify_apicid;
 } TdxGuest;
 
 #ifdef CONFIG_TDX
@@ -78,5 +84,6 @@ int tdx_parse_tdvf(void *flash_ptr, int size);
 int tdx_handle_report_fatal_error(X86CPU *cpu, struct kvm_run *run);
 void tdx_handle_get_quote(X86CPU *cpu, struct kvm_run *run);
 void tdx_handle_get_tdvmcall_info(X86CPU *cpu, struct kvm_run *run);
+void tdx_handle_setup_event_notify_interrupt(X86CPU *cpu, struct kvm_run *run);
 
 #endif /* QEMU_I386_TDX_H */
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 234878c613f..fc58a23b30d 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -6182,6 +6182,9 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
         case TDVMCALL_GET_TD_VM_CALL_INFO:
             tdx_handle_get_tdvmcall_info(cpu, run);
             break;
+        case TDVMCALL_SETUP_EVENT_NOTIFY_INTERRUPT:
+            tdx_handle_setup_event_notify_interrupt(cpu, run);
+            break;
         }
         ret = 0;
         break;
diff --git a/target/i386/kvm/tdx-stub.c b/target/i386/kvm/tdx-stub.c
index 76fee49eff0..1f0e108a69e 100644
--- a/target/i386/kvm/tdx-stub.c
+++ b/target/i386/kvm/tdx-stub.c
@@ -26,3 +26,7 @@ void tdx_handle_get_quote(X86CPU *cpu, struct kvm_run *run)
 void tdx_handle_get_tdvmcall_info(X86CPU *cpu, struct kvm_run *run)
 {
 }
+
+void tdx_handle_setup_event_notify_interrupt(X86CPU *cpu, struct kvm_run *run)
+{
+}
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 10dfb80d22e..fb31071dd81 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -28,10 +28,13 @@
 #include "cpu.h"
 #include "cpu-internal.h"
 #include "host-cpu.h"
+#include "hw/i386/apic_internal.h"
+#include "hw/i386/apic-msidef.h"
 #include "hw/i386/e820_memory_layout.h"
 #include "hw/i386/tdvf.h"
 #include "hw/i386/x86.h"
 #include "hw/i386/tdvf-hob.h"
+#include "hw/pci/msi.h"
 #include "kvm_i386.h"
 #include "tdx.h"
 #include "tdx-quote-generator.h"
@@ -1123,6 +1126,28 @@ int tdx_parse_tdvf(void *flash_ptr, int size)
     return tdvf_parse_metadata(&tdx_guest->tdvf, flash_ptr, size);
 }
 
+static void tdx_inject_interrupt(uint32_t apicid, uint32_t vector)
+{
+    int ret;
+
+    if (vector < 32 || vector > 255) {
+        return;
+    }
+
+    MSIMessage msg = {
+        .address = ((apicid & 0xff) << MSI_ADDR_DEST_ID_SHIFT) |
+                   (((uint64_t)apicid & 0xffffff00) << 32),
+        .data = vector | (APIC_DM_FIXED << MSI_DATA_DELIVERY_MODE_SHIFT),
+    };
+
+    ret = kvm_irqchip_send_msi(kvm_state, msg);
+    if (ret < 0) {
+        /* In this case, no better way to tell it to guest. Log it. */
+        error_report("TDX: injection interrupt %d failed, interrupt lost (%s).",
+                     vector, strerror(-ret));
+    }
+}
+
 static void tdx_get_quote_completion(TdxGenerateQuoteTask *task)
 {
     TdxGuest *tdx = task->opaque;
@@ -1154,6 +1179,9 @@ static void tdx_get_quote_completion(TdxGenerateQuoteTask *task)
         error_report("TDX: get-quote: failed to update GetQuote header.");
     }
 
+    tdx_inject_interrupt(tdx_guest->event_notify_apicid,
+                         tdx_guest->event_notify_vector);
+
     g_free(task->send_data);
     g_free(task->receive_buf);
     g_free(task);
@@ -1256,7 +1284,7 @@ out_free:
     g_free(task);
 }
 
-#define SUPPORTED_TDVMCALLINFO_1_R11    (0)
+#define SUPPORTED_TDVMCALLINFO_1_R11    (TDG_VP_VMCALL_SUBFUNC_SET_EVENT_NOTIFY_INTERRUPT)
 #define SUPPORTED_TDVMCALLINFO_1_R12    (0)
 
 void tdx_handle_get_tdvmcall_info(X86CPU *cpu, struct kvm_run *run)
@@ -1277,6 +1305,21 @@ void tdx_handle_get_tdvmcall_info(X86CPU *cpu, struct kvm_run *run)
     run->tdx.get_tdvmcall_info.ret = TDG_VP_VMCALL_SUCCESS;
 }
 
+void tdx_handle_setup_event_notify_interrupt(X86CPU *cpu, struct kvm_run *run)
+{
+    uint64_t vector = run->tdx.setup_event_notify.vector;
+
+    if (vector >= 32 && vector < 256) {
+        qemu_mutex_lock(&tdx_guest->lock);
+        tdx_guest->event_notify_vector = vector;
+        tdx_guest->event_notify_apicid = cpu->apic_id;
+        qemu_mutex_unlock(&tdx_guest->lock);
+        run->tdx.setup_event_notify.ret = TDG_VP_VMCALL_SUCCESS;
+    } else {
+        run->tdx.setup_event_notify.ret = TDG_VP_VMCALL_INVALID_OPERAND;
+    }
+}
+
 static void tdx_panicked_on_fatal_error(X86CPU *cpu, uint64_t error_code,
                                         char *message, uint64_t gpa)
 {
@@ -1477,6 +1520,9 @@ static void tdx_guest_init(Object *obj)
                             NULL, NULL);
 
     qemu_mutex_init(&tdx->lock);
+
+    tdx->event_notify_vector = -1;
+    tdx->event_notify_apicid = -1;
 }
 
 static void tdx_guest_finalize(Object *obj)
-- 
2.50.0


