Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B7BCC3DA70
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 23:59:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8IY-00042n-Af; Thu, 25 Jul 2024 19:55:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8IW-0003vl-BR; Thu, 25 Jul 2024 19:55:00 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8IU-0000aW-KI; Thu, 25 Jul 2024 19:55:00 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-70d2e68f5a8so337710b3a.3; 
 Thu, 25 Jul 2024 16:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951696; x=1722556496; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zbylTCKtEz0fZhsc8131n5s5SygNd8gxPxzcYetS3m0=;
 b=hVlDijA62WnUDtqAA4o55si8mB7BGebnBVqoVvI4AvBpUtiZbHXwy4sQGSw0ubShn4
 h6UnHxopUgRt2zrl6wWB4N77CFPqUu5VS1oYWQB91dQg5gvbqv9gaXYVjxUopXTjui9g
 hc2qALSUvXicVqfxstPlFumU/KpHvcopKa4oFiqjdNtFywIv6RAZUv2SD149i6SqTsv1
 5waVQeXuDLa1rormgp7ZPdAgqwpnNNuAawjp8qbdGsWacG2FgfmQdcDZL/FPbLfzq/1d
 iO/ZFzCfJPj+bHtfEUK9WmpT8LDAa7S8AUHDfN2cPpAzAHTToeNExwnsjDNeWzBeIRhk
 f12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951696; x=1722556496;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zbylTCKtEz0fZhsc8131n5s5SygNd8gxPxzcYetS3m0=;
 b=WL1jsT46Hooknqgg30DHyki1vSMwnFA/A5Xybg7UV+DqTwE9tVolyflq/TPmzn7+bE
 FM6QC7bW1eoD0hwrMPzONuGyuIdvLmuvsBln6pA8llc3wMFQqbarKe99TGxvgM6ABFjf
 nLdpzb9h2YmNoWExleAB9eAGH69RJA6ikUvmude7ZDHSCQqb1qIEx26A2zQrHVzxhOa7
 aAr5XABBYgLTy71dIi+CKWj0tHJmcz1Kk2R206zYsBDlQXVgmOlckiZfIwa0iH4O0Eij
 qlRhfm8sKIRYQa3kitslzHMZ9X0uFPsuv6nt2Aaqk3pApEPDZl51F8xAK1PrNIvy5bFd
 sRhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIGt9is1R8KWgL2PSybpdpUkQ2XQUZW/8I5tkBS00Z7pfpXBbWHvV1zfazWntgM37oQnJnzcQVFJYnfd3vyOa7/9y+
X-Gm-Message-State: AOJu0Ywrzguzw1eIxuh6pRDjMYRLojv6MmOZ/1AeJuc4UBKBJEd8izr4
 /FM/sere4Q4IrBZW2gc1qNujaHHsg3VpHE/t5zd/LmPoeGMfmsBbndS//g==
X-Google-Smtp-Source: AGHT+IFbR2//Ftm9MMKLp9dGcgFDW9l0yfsnBxrPqLgr/FQxVOX7WMc54xQ9FPgou0gaeArzNIz6Cw==
X-Received: by 2002:a05:6a21:3987:b0:1af:66aa:7fc7 with SMTP id
 adf61e73a8af0-1c47b167d0emr4669600637.3.1721951696456; 
 Thu, 25 Jul 2024 16:54:56 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.54.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:54:55 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>,
 Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: [PULL 07/96] target/ppc: handle vcpu hotplug failure gracefully
Date: Fri, 26 Jul 2024 09:52:40 +1000
Message-ID: <20240725235410.451624-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Harsh Prateek Bora <harshpb@linux.ibm.com>

On ppc64, the PowerVM hypervisor runs with limited memory and a VCPU
creation during hotplug may fail during kvm_ioctl for KVM_CREATE_VCPU,
leading to termination of guest since errp is set to &error_fatal while
calling kvm_init_vcpu. This unexpected behaviour can be avoided by
pre-creating and parking vcpu on success or return error otherwise.
This enables graceful error delivery for any vcpu hotplug failures while
the guest can keep running.

Also introducing KVM AccelCPUClass to init cpu_target_realize for kvm.

Tested OK by repeatedly doing a hotplug/unplug of vcpus as below:

 #virsh setvcpus hotplug 40
 #virsh setvcpus hotplug 70
error: internal error: unable to execute QEMU command 'device_add':
kvmppc_cpu_realize: vcpu hotplug failed with -12

Signed-off by: Harsh Prateek Bora <harshpb@linux.ibm.com>

Reported-by: Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
Suggested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
Tested-by: Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/kvm.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 2c3932200b..907dba60d1 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -48,6 +48,8 @@
 #include "qemu/mmap-alloc.h"
 #include "elf.h"
 #include "sysemu/kvm_int.h"
+#include "sysemu/kvm.h"
+#include "hw/core/accel-cpu.h"
 
 #include CONFIG_DEVICES
 
@@ -2346,6 +2348,30 @@ static void alter_insns(uint64_t *word, uint64_t flags, bool on)
     }
 }
 
+static bool kvmppc_cpu_realize(CPUState *cs, Error **errp)
+{
+    int ret;
+    const char *vcpu_str = (cs->parent_obj.hotplugged == true) ?
+                           "hotplug" : "create";
+    cs->cpu_index = cpu_get_free_index();
+
+    POWERPC_CPU(cs)->vcpu_id = cs->cpu_index;
+
+    /* create and park to fail gracefully in case vcpu hotplug fails */
+    ret = kvm_create_and_park_vcpu(cs);
+    if (ret) {
+        /*
+         * This causes QEMU to terminate if initial CPU creation
+         * fails, and only CPU hotplug failure if the error happens
+         * there.
+         */
+        error_setg(errp, "%s: vcpu %s failed with %d",
+                         __func__, vcpu_str, ret);
+        return false;
+    }
+    return true;
+}
+
 static void kvmppc_host_cpu_class_init(ObjectClass *oc, void *data)
 {
     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
@@ -2966,3 +2992,23 @@ void kvmppc_set_reg_tb_offset(PowerPCCPU *cpu, int64_t tb_offset)
 void kvm_arch_accel_class_init(ObjectClass *oc)
 {
 }
+
+static void kvm_cpu_accel_class_init(ObjectClass *oc, void *data)
+{
+    AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
+
+    acc->cpu_target_realize = kvmppc_cpu_realize;
+}
+
+static const TypeInfo kvm_cpu_accel_type_info = {
+    .name = ACCEL_CPU_NAME("kvm"),
+
+    .parent = TYPE_ACCEL_CPU,
+    .class_init = kvm_cpu_accel_class_init,
+    .abstract = true,
+};
+static void kvm_cpu_accel_register_types(void)
+{
+    type_register_static(&kvm_cpu_accel_type_info);
+}
+type_init(kvm_cpu_accel_register_types);
-- 
2.45.2


