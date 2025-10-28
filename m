Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D610CCF9F2
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 17:36:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDnas-0005vg-VP; Tue, 28 Oct 2025 13:34:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vDnar-0005ur-HH
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 13:34:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vDnan-0004Pb-2X
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 13:34:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761672881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3onFURp8gSnJA1IzSb1OXc8cgixtZr60o4/zT5ecEXc=;
 b=RGs9r4zBTh8UHrcWQBk1Ns2k5z/A4wPXa2Q4KiW+/nIC3Q0BqR2XAQe362yYV5vhjkIiQM
 KTOdoupgttvQP70nsY0C2VEXk7hNvo6rJtnp/8V8/GBL2YHwQ4kD02OXknd1Jl0Ge5qlSh
 pOiF3ATX5FTIH2tt4MH+vKvYg1riGjE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-s-cUmNSQPNSyBCGvNZkJVg-1; Tue, 28 Oct 2025 13:34:40 -0400
X-MC-Unique: s-cUmNSQPNSyBCGvNZkJVg-1
X-Mimecast-MFC-AGG-ID: s-cUmNSQPNSyBCGvNZkJVg_1761672879
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3ee888281c3so4445447f8f.3
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 10:34:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761672878; x=1762277678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3onFURp8gSnJA1IzSb1OXc8cgixtZr60o4/zT5ecEXc=;
 b=jjnzrXNwNRk1IQsgye9U8QgAqAQeuExKTlvnePUnDP57NG6N+jO7zDqHihh9M8UoRc
 8tRCPwSxIFTygbcioRWuNDIYKLnD4npwPtssu2Tfs3vHYnrZhXExRdjTiGWNE+X1wkbI
 m3/9kgp7+jj7YHlFoKGOSPxYTqDaoEfRdbDm26Zdxk4+o8bJvsnsbjOgv+0mQwZpifRt
 UZ450+TlZMkiNVFIoW+n61XJg1HVJ+QmmBu9RO/Hs63/KzZ5LemCzYbEdT+FRkCpgndC
 aQsg5MZof+Xv5/XC1N5GLlKTe4G+WubsP35Oqe27Utk5FqKM2q+wmPC1HKuDT/4d7W4f
 HRTw==
X-Gm-Message-State: AOJu0Yz8QsqHzotOiiG4VnVXlLG86sNr0Rx4fgLQaJeZLun0UUIabAFy
 p69NinrPuJKKPYnCevz9XPfSsS3fiZtPz26OIhG6AUfSWjWUKYPE2S9f/UXOGA57PJBAiiuwKFU
 7zBaxjBSr2gFoRAkvCoCFFz7q6X9A7cC83HH3P6qC2T560JOT9HP+gkfkaI56Qp59q+7JKveikP
 58GwChwYUxW6HB5iKAQt7nx6YMIXorg+wWpywTX8xe
X-Gm-Gg: ASbGncuv2+bhcn38H8D1rhFEsANTDlXCIaqqwwCQNt84mFK+95cJFG2d5Qz+Dflu5cr
 /vmGZYRQwv+9OQEDyHL7/WEnAreUnD+hu4Sib5N0ZK7GIrnxtY/Peow8PaHurgsT4UhnvKGbAyM
 1Fw3wJcnZlfezqlaUtUoRBEPGUgAxW4tWC63AZusWpDH9eSwv8kDMRJMtOaY/aqX1A6ap37ayLP
 6YTXJPp9JAjUd3n56ntrRj5wfn5gtsFxtreoMhCInIyVJ/YxNBIQtKZDSBi1hBAdFAEkza3O3IF
 Byxrz8GuScsnM40N6pwVzBBwffSV9/1QuXjh1gdWuzhyz2hF9Sz4kKXdPjGW6mrNNIjtiADIxXD
 a3LHjSBixSjLdxn7GbRHd+vweK6DtFphdBj/e2jRrJjhcL8VU189ALdm7qTEnm2cDUo/jHjuuhe
 I49Xw=
X-Received: by 2002:a05:6000:1ac9:b0:3ee:1461:1654 with SMTP id
 ffacd0b85a97d-429a7e7af17mr3756169f8f.50.1761672877961; 
 Tue, 28 Oct 2025 10:34:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMaUu3w0pqlA8IPbJqpVfoEM3VJluCkJl+PzEZnkD8Re1Dj5vXOhYbmU8XmF5XoKZaVudURw==
X-Received: by 2002:a05:6000:1ac9:b0:3ee:1461:1654 with SMTP id
 ffacd0b85a97d-429a7e7af17mr3756145f8f.50.1761672877508; 
 Tue, 28 Oct 2025 10:34:37 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.110.222])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952e2e06sm21606936f8f.46.2025.10.28.10.34.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 10:34:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 02/18] i386/kvm/cpu: Init SMM cpu address space for hotplugged
 CPUs
Date: Tue, 28 Oct 2025 18:34:14 +0100
Message-ID: <20251028173430.2180057-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251028173430.2180057-1-pbonzini@redhat.com>
References: <20251028173430.2180057-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The SMM cpu address space is initialized in a machine_init_done
notifier. It only runs once when QEMU starts up, which leads to the
issue that for any hotplugged CPU after the machine is ready, SMM
cpu address space doesn't get initialized.

Fix the issue by initializing the SMM cpu address space in x86_cpu_plug()
when the cpu is hotplugged.

Fixes: 591f817d819f ("target/i386: Define enum X86ASIdx for x86's address spaces")
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Closes: https://lore.kernel.org/qemu-devel/CAFEAcA_3kkZ+a5rTZGmK8W5K6J7qpYD31HkvjBnxWr-fGT2h_A@mail.gmail.com/
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/r/20251014094216.164306-2-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm_i386.h |  1 +
 hw/i386/x86-common.c       | 11 +++++++++++
 target/i386/kvm/kvm.c      |  6 ++++++
 3 files changed, 18 insertions(+)

diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index 5c908fdd6a5..2b653442f4d 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -74,6 +74,7 @@ uint32_t kvm_x86_build_cpuid(CPUX86State *env, struct kvm_cpuid_entry2 *entries,
                              uint32_t cpuid_i);
 #endif /* CONFIG_KVM */
 
+void kvm_smm_cpu_address_space_init(X86CPU *cpu);
 void kvm_pc_setup_irq_routing(bool pci_enabled);
 
 #endif
diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index 7512be64d67..5716191fff1 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -183,6 +183,17 @@ void x86_cpu_plug(HotplugHandler *hotplug_dev,
         fw_cfg_modify_i16(x86ms->fw_cfg, FW_CFG_NB_CPUS, x86ms->boot_cpus);
     }
 
+    /*
+     * Non-hotplugged CPUs get their SMM cpu address space initialized in
+     * machine init done notifier: register_smram_listener().
+     *
+     * We need initialize the SMM cpu address space for the hotplugged CPU
+     * specifically.
+     */
+    if (kvm_enabled() && dev->hotplugged && x86_machine_is_smm_enabled(x86ms)) {
+        kvm_smm_cpu_address_space_init(cpu);
+    }
+
     found_cpu = x86_find_cpu_slot(MACHINE(x86ms), cpu->apic_id, NULL);
     found_cpu->cpu = CPU(dev);
 out:
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index f7a6ef650af..4dea1ed8f0f 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2748,6 +2748,12 @@ static void register_smram_listener(Notifier *n, void *unused)
     }
 }
 
+/* It should only be called in cpu's hotplug callback */
+void kvm_smm_cpu_address_space_init(X86CPU *cpu)
+{
+    cpu_address_space_init(CPU(cpu), X86ASIdx_SMM, "cpu-smm", &smram_as_root);
+}
+
 static void *kvm_msr_energy_thread(void *data)
 {
     KVMState *s = data;
-- 
2.51.1


