Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B8DCCD11BF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 18:15:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnjNm-0000UH-RH; Fri, 22 Mar 2024 14:12:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rnjNi-0000M4-QG
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:12:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rnjNh-000796-2z
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:12:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711131160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KmCdsSRMD8UsbN0vCplFK29pEP5Ym5BBRFpUvABtUQ0=;
 b=UKuSFw473OkBAG7Aju5vpVF/xPOiJamoQy7c3Ic9EAUui/3A6GDGefSMz6ehsJ8u4m9sW3
 9+SQFeQsS6Vn5qs3Bccp7k8D+dXdkdK6LKNeYA0eoNinhRcttsbxJwwhK2FUsrSke/VvKl
 fgJPWtd5z3Xp7LMRQbWRF7/SSqcx7BA=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-XlZwX2DZOVe_6uF2eUkuww-1; Fri, 22 Mar 2024 14:12:38 -0400
X-MC-Unique: XlZwX2DZOVe_6uF2eUkuww-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5158c3ed189so1880727e87.3
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 11:12:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711131156; x=1711735956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KmCdsSRMD8UsbN0vCplFK29pEP5Ym5BBRFpUvABtUQ0=;
 b=FOnhcY6Rctik4OqmP1s/K9IOqsw3i5hRY2CpPgEyPGkdF5bHWZKHHPwoRyYdWiRFvi
 f5XSSyqpVXv8LffU3kRQy2F87a4fRGMWDmKCgfyEUrgz+eZBlSVpDVQ+Wq1gDf/IsWV/
 3kZqCsyssmptwmVxEHXYey9H+C0qe2fL2pkHVp6D6CeCBovUKUETPnnPzWs/9cZ0i13y
 LWkwpmik8mAJkFHCDfZ4d40wvnBSirSXuhAf4MIcXtk+ArnF/oLQMaRrB8nb9vvG2XyU
 hj+fB3pTXNS2q03dmrteZ+r5eRfhvv2IvFzJlr5nCpacQyME7sCrsweSZPuSTS7/vIKp
 BB7w==
X-Gm-Message-State: AOJu0Yzp1B0iInlR8LeKlbOtA3cIcPZZRASwP0UMWTx8zmHZTGpnDBSK
 5Au1Aq+Pi9KfBvo+YmIkDgr0esiiAKOuHnzmDV8EBF+tDO1zvowcXSh5o/NZ5aT1Qf/bGxx75N2
 IHzo/Ff1rMYq5OnzTL73NdztH14hnv8z7Q/lwXrUAfjMtlGYuKtBu9NoHuHESTPuAeGAvhlqrcd
 +MEG8Nsx6ojYMS68+WusGpiXtWuexIFflWBDO9
X-Received: by 2002:a19:4348:0:b0:513:dae2:dd7e with SMTP id
 m8-20020a194348000000b00513dae2dd7emr151040lfj.32.1711131156203; 
 Fri, 22 Mar 2024 11:12:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEi+S69JQO8nOqFNgBAS0LuGJkkYcSWFr8BY1U4HSONSWDJUpWWUFDvw8AN7NDYaUZesIjb/g==
X-Received: by 2002:a19:4348:0:b0:513:dae2:dd7e with SMTP id
 m8-20020a194348000000b00513dae2dd7emr151023lfj.32.1711131155762; 
 Fri, 22 Mar 2024 11:12:35 -0700 (PDT)
Received: from [192.168.10.118] ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 m19-20020a1709060d9300b00a45c9945251sm68635eji.192.2024.03.22.11.12.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 11:12:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: xiaoyao.li@intel.com,
	michael.roth@amd.com,
	david@redhat.com
Subject: [PATCH 25/26] kvm: handle KVM_EXIT_MEMORY_FAULT
Date: Fri, 22 Mar 2024 19:11:15 +0100
Message-ID: <20240322181116.1228416-26-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322181116.1228416-1-pbonzini@redhat.com>
References: <20240322181116.1228416-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.222,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Chao Peng <chao.p.peng@linux.intel.com>

When geeting KVM_EXIT_MEMORY_FAULT exit, it indicates userspace needs to
do the memory conversion on the RAMBlock to turn the memory into desired
attribute, i.e., private/shared.

Currently only KVM_MEMORY_EXIT_FLAG_PRIVATE in flags is valid when
KVM_EXIT_MEMORY_FAULT happens.

Note, KVM_EXIT_MEMORY_FAULT makes sense only when the RAMBlock has
guest_memfd memory backend.

Note, KVM_EXIT_MEMORY_FAULT returns with -EFAULT, so special handling is
added.

When page is converted from shared to private, the original shared
memory can be discarded via ram_block_discard_range(). Note, shared
memory can be discarded only when it's not back'ed by hugetlb because
hugetlb is supposed to be pre-allocated and no need for discarding.

Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
Co-developed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>

Message-ID: <20240320083945.991426-13-michael.roth@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/sysemu/kvm.h   |  2 +
 accel/kvm/kvm-all.c    | 99 +++++++++++++++++++++++++++++++++++++-----
 accel/kvm/trace-events |  2 +
 3 files changed, 93 insertions(+), 10 deletions(-)

diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 2cb31925091..698f1640fe2 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -541,4 +541,6 @@ int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp);
 
 int kvm_set_memory_attributes_private(hwaddr start, hwaddr size);
 int kvm_set_memory_attributes_shared(hwaddr start, hwaddr size);
+
+int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private);
 #endif
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 56b17cbd8aa..afd7f992e39 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2893,6 +2893,70 @@ static void kvm_eat_signals(CPUState *cpu)
     } while (sigismember(&chkset, SIG_IPI));
 }
 
+int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
+{
+    MemoryRegionSection section;
+    ram_addr_t offset;
+    MemoryRegion *mr;
+    RAMBlock *rb;
+    void *addr;
+    int ret = -1;
+
+    trace_kvm_convert_memory(start, size, to_private ? "shared_to_private" : "private_to_shared");
+
+    if (!QEMU_PTR_IS_ALIGNED(start, qemu_real_host_page_size()) ||
+        !QEMU_PTR_IS_ALIGNED(size, qemu_real_host_page_size())) {
+        return -1;
+    }
+
+    if (!size) {
+        return -1;
+    }
+
+    section = memory_region_find(get_system_memory(), start, size);
+    mr = section.mr;
+    if (!mr) {
+        return -1;
+    }
+
+    if (!memory_region_has_guest_memfd(mr)) {
+        error_report("Converting non guest_memfd backed memory region "
+                     "(0x%"HWADDR_PRIx" ,+ 0x%"HWADDR_PRIx") to %s",
+                     start, size, to_private ? "private" : "shared");
+        ret = -1;
+        goto out_unref;
+    }
+
+    if (to_private) {
+        ret = kvm_set_memory_attributes_private(start, size);
+    } else {
+        ret = kvm_set_memory_attributes_shared(start, size);
+    }
+    if (ret) {
+        goto out_unref;
+    }
+
+    addr = memory_region_get_ram_ptr(mr) + section.offset_within_region;
+    rb = qemu_ram_block_from_host(addr, false, &offset);
+
+    if (to_private) {
+        if (rb->page_size == qemu_real_host_page_size()) {
+            /*
+            * shared memory is back'ed by  hugetlb, which is supposed to be
+            * pre-allocated and doesn't need to be discarded
+            */
+            goto out_unref;
+        }
+        ret = ram_block_discard_range(rb, offset, size);
+    } else {
+        ret = ram_block_discard_guest_memfd_range(rb, offset, size);
+    }
+
+out_unref:
+    memory_region_unref(section.mr);
+    return ret;
+}
+
 int kvm_cpu_exec(CPUState *cpu)
 {
     struct kvm_run *run = cpu->kvm_run;
@@ -2960,18 +3024,20 @@ int kvm_cpu_exec(CPUState *cpu)
                 ret = EXCP_INTERRUPT;
                 break;
             }
-            fprintf(stderr, "error: kvm run failed %s\n",
-                    strerror(-run_ret));
+            if (!(run_ret == -EFAULT && run->exit_reason == KVM_EXIT_MEMORY_FAULT)) {
+                fprintf(stderr, "error: kvm run failed %s\n",
+                        strerror(-run_ret));
 #ifdef TARGET_PPC
-            if (run_ret == -EBUSY) {
-                fprintf(stderr,
-                        "This is probably because your SMT is enabled.\n"
-                        "VCPU can only run on primary threads with all "
-                        "secondary threads offline.\n");
-            }
+                if (run_ret == -EBUSY) {
+                    fprintf(stderr,
+                            "This is probably because your SMT is enabled.\n"
+                            "VCPU can only run on primary threads with all "
+                            "secondary threads offline.\n");
+                }
 #endif
-            ret = -1;
-            break;
+                ret = -1;
+                break;
+            }
         }
 
         trace_kvm_run_exit(cpu->cpu_index, run->exit_reason);
@@ -3054,6 +3120,19 @@ int kvm_cpu_exec(CPUState *cpu)
                 break;
             }
             break;
+        case KVM_EXIT_MEMORY_FAULT:
+            trace_kvm_memory_fault(run->memory_fault.gpa,
+                                   run->memory_fault.size,
+                                   run->memory_fault.flags);
+            if (run->memory_fault.flags & ~KVM_MEMORY_EXIT_FLAG_PRIVATE) {
+                error_report("KVM_EXIT_MEMORY_FAULT: Unknown flag 0x%" PRIx64,
+                             (uint64_t)run->memory_fault.flags);
+                ret = -1;
+                break;
+            }
+            ret = kvm_convert_memory(run->memory_fault.gpa, run->memory_fault.size,
+                                     run->memory_fault.flags & KVM_MEMORY_EXIT_FLAG_PRIVATE);
+            break;
         default:
             ret = kvm_arch_handle_exit(cpu, run);
             break;
diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
index e8c52cb9e7a..681ccb667d6 100644
--- a/accel/kvm/trace-events
+++ b/accel/kvm/trace-events
@@ -31,3 +31,5 @@ kvm_cpu_exec(void) ""
 kvm_interrupt_exit_request(void) ""
 kvm_io_window_exit(void) ""
 kvm_run_exit_system_event(int cpu_index, uint32_t event_type) "cpu_index %d, system_even_type %"PRIu32
+kvm_convert_memory(uint64_t start, uint64_t size, const char *msg) "start 0x%" PRIx64 " size 0x%" PRIx64 " %s"
+kvm_memory_fault(uint64_t start, uint64_t size, uint64_t flags) "start 0x%" PRIx64 " size 0x%" PRIx64 " flags 0x%" PRIx64
-- 
2.44.0


