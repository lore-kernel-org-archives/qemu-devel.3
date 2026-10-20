Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB5A60A2604
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 10:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=LRpzp6HA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ7MB-0007Nj-D0; Tue, 20 Oct 2026 06:46:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xJ7K0-0004V0-3N
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 06:43:56 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xJ7Jg-0004Rl-Eo
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 06:43:55 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a1ec92f655so6282515e9.0
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 03:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792493015; x=1793097815; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QZXTDRJaUlEs/ov0FqhQ2FdMdX9BrJqzlb9mQF9yfxI=;
 b=LRpzp6HA50Ut63IU7a449SgV7z1jBxqsCxFDswflSC3v5yDS+AnDll/6JkVmUPsQ8a
 juM8Hpj5Wu+Q08Op6lhrseKMLYcaRLZY/322HH2OtIF0U4IGI/yRv9LoWuHTooJqNzIy
 EzpAFuetgaU58CdFNqwChZndD9fmZWuT1o/N0qpH7sZrYTETV7Z4GnB/Q43dqwTxRiZr
 +Z3PAJN0UbPvYOljSAbdjJttu0ecw/NDYE3krvXcMZGY94m0RDCWkUQl0BH6oamo7HP6
 rJzGhK84p/q/7Epyg+fax5WRjHQZ8jfBmKUj5jdqyMLZ3lFWxkWin3mfCaHziJH2GVlq
 mEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792493015; x=1793097815;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QZXTDRJaUlEs/ov0FqhQ2FdMdX9BrJqzlb9mQF9yfxI=;
 b=130y7E+nslBBpW2PhLgOw7gSg2o4KB+JC7A74pKI1kmTWIBj3JXJsgtQM8BtReoUWC
 4c8u8LECZb/kBHlNAg0/Y5ZEq/2opNGOkasO2yOOuUAKIcVL82zkVSSc0bUryW8/GxRf
 4OYQjiMtFfnlU0fCXel/qrUnxMQCO7QZU1Nano4EobqaJ4hoo+UqS2fpGXUmFSp1NKC1
 71cltVYHsOe/K+gx1vKCt0tjlFs9iJzHq3ZqpETrJSNvL/h0vAOTwNHrMcJqlpwPG9sz
 ErRAaXoP3sEToaUPVG0nL5XwqsEH2kAHEeDDgWDJFIYwT1Koq3J+CfJHbwRs+0hzuReW
 arAA==
X-Gm-Message-State: AFq9FYIPrXB6e1bZg8PCRunUtIwbRHrF3vDZxBRqhCbnoOHIcuxFmu+Q
 pv/oqdUKBjZ/YDe8lILQtmCerytxChxfc4ocAvllm7ftsoRgoa6KM9UUnyWKAY0WKZY=
X-Gm-Gg: AYBFou0b7A5jHmpjH/na6NAW98aCuqzU6E+5TE2zK0OEPcbYH4J44UD4bFGgeAJbD0Z
 C3oV8OuNAmxUDtPk6gIfWqz9oh8ik5QhC/B9LTutNE1JT9qhhuHfjO7NScrFm8C/nTvT16aXyjk
 okbKKNXucPxiebpR27qK00YDPrpCOr8nxL9i2FIeoC8lU3P6tyasRlA29Ueg9KO/05voaXD9yuw
 6sXe2W87ta/xq0GXadf5+5u/KWbPRWhrUqbdrdWl2uP/VkCYUnvKGHsuC3fkrx2WcXLHIrkBQ1o
 epmYe3bTGPc5Ghw6SLufe1i+w9UOHhR0+2X0KeANixmLidAUYoTPPcEoQg3vIFnC5Z24FjetpRB
 nGiWULpV8dovomu7g8cZDiUVh1RMhyHH/0Elr4l9Q6fkLwhYJ39ulNsGP9UtFhxUGYSm6XxT0pP
 IkYf0yoNiIhrFgEqkS22wxjaEHC77sHw0hbmo9xaaBfczTsJ0avYXRiDJJ1rDRcrNu1P/fcA==
X-Received: by 2002:a7b:cd99:0:b0:4a1:877b:d4e0 with SMTP id
 5b1f17b1804b1-4a1f53bf67emr24825285e9.12.1792493014628; 
 Tue, 20 Oct 2026 03:43:34 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d6db78csm5378092f8f.2.2026.10.20.03.43.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 03:43:27 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 41F505FD57;
 Tue, 20 Oct 2026 11:43:23 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Song Gao <17746591750@163.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, Bernhard Beschow <shentey@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Bj=C3=B6rn=20Walk?= <bwalk@linux.ibm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-s390x@nongnu.org,
 David Woodhouse <dwmw2@infradead.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-ppc@nongnu.org,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org, linux-edac@vger.kernel.org,
 Glenn Miles <milesg@linux.ibm.com>, Chao Liu <chao.liu@processmission.com>,
 Cornelia Huck <cohuck@redhat.com>, Gautam Menghani <gautam@linux.ibm.com>,
 Xianglai Li <lixianglai@loongson.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>, Zhao Liu <zhao1.liu@intel.com>,
 Weiwei Li <liwei1518@gmail.com>, Peter Maydell <peter.maydell@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, qemu-riscv@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 16/23] accel/kvm: port kvm_arch_vpcu_id to KVMCPUOps
Date: Tue, 20 Oct 2026 11:43:10 +0100
Message-ID: <20261020104320.3686723-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261020104320.3686723-1-alex.bennee@linaro.org>
References: <20261020104320.3686723-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is probably one of the messier conversions so far because it's a
number that is used both by the generic KVM code but also the various
target specific interrupt controllers where the direct linking is
marginally beneficial.

A bunch of the targets just treat cpu->cpu_index directly at the vcpu
id so we take advantage of that default implementation with a common
helper.

**Q** is it worth in-lining the helper or indeed just finding to stash
the value in CPUState?

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/accel/kvm/cpu-ops.h |  6 ++++++
 include/system/kvm.h        |  2 +-
 target/i386/kvm/kvm_i386.h  |  1 +
 accel/kvm/kvm-all.c         | 28 +++++++++++++++++++---------
 hw/i386/kvm/xen_evtchn.c    |  6 +++---
 hw/intc/openpic_kvm.c       |  4 ++--
 hw/intc/spapr_xive_kvm.c    | 10 +++++-----
 hw/intc/xics_kvm.c          |  6 +++---
 target/arm/kvm.c            |  5 -----
 target/i386/kvm/kvm-cpu.c   |  1 +
 target/i386/kvm/kvm.c       |  4 ++--
 target/loongarch/kvm/kvm.c  |  5 -----
 target/ppc/kvm.c            |  3 ++-
 target/riscv/kvm/kvm-cpu.c  |  7 +------
 target/s390x/kvm/kvm.c      |  5 -----
 15 files changed, 46 insertions(+), 47 deletions(-)

diff --git a/include/accel/kvm/cpu-ops.h b/include/accel/kvm/cpu-ops.h
index 171568e08cb..be4031d9011 100644
--- a/include/accel/kvm/cpu-ops.h
+++ b/include/accel/kvm/cpu-ops.h
@@ -33,6 +33,11 @@ struct kvm_run;
  *                state change handlers).
  *                May be NULL if no architecture-specific cleanup is required.
  *                Returns 0 on success, or a negative errno on failure.
+ * @vcpu_id: Optional callback returning the architecture-specific KVM vCPU ID
+ *           to be passed to KVM_CREATE_VCPU and associated ioctls (such as
+ *           the APIC ID on x86 or the PPC vcpu_id).
+ *           May be NULL if the target uses cpu->cpu_index directly as the
+ *           vCPU ID.
  * @get_registers: Mandatory callback to synchronize architecture-specific
  *                 vCPU register state from KVM into QEMU's CPUState.
  *                 Returns 0 on success, or a negative errno on failure.
@@ -71,6 +76,7 @@ typedef struct KVMCPUOps {
     int (*pre_create_vcpu)(CPUState *cpu, Error **errp);
     int (*init_vcpu)(CPUState *cpu);
     int (*destroy_vcpu)(CPUState *cpu);
+    unsigned long (*vcpu_id)(CPUState *cpu);
     int (*get_registers)(CPUState *cpu, Error **errp);
     int (*put_registers)(CPUState *cpu, KvmPutState level, Error **errp);
     void (*pre_run)(CPUState *cpu, struct kvm_run *run);
diff --git a/include/system/kvm.h b/include/system/kvm.h
index a66344cc70c..2ecae10cdff 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -357,7 +357,7 @@ static inline void kvm_arch_reset_parked_vcpu(unsigned long vcpu_id, int kvm_fd)
 bool kvm_vcpu_id_is_valid(int vcpu_id);
 
 /* Returns VCPU ID to be used on KVM_CREATE_VCPU ioctl() */
-unsigned long kvm_arch_vcpu_id(CPUState *cpu);
+unsigned long kvm_vcpu_id(CPUState *cpu);
 
 void kvm_arch_on_sigbus_vcpu(CPUState *cpu, int code, void *addr);
 
diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index c7ffed75c1d..f189bb92bb9 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -36,6 +36,7 @@ void kvm_arch_reset_vcpu(X86CPU *cs);
 int x86_kvm_pre_create_vcpu(CPUState *cpu, Error **errp);
 int x86_kvm_init_vcpu(CPUState *cs);
 int x86_kvm_destroy_vcpu(CPUState *cs);
+unsigned long x86_kvm_vcpu_id(CPUState *cs);
 int x86_kvm_get_registers(CPUState *cs, Error **errp);
 int x86_kvm_put_registers(CPUState *cpu, KvmPutState level, Error **errp);
 void x86_kvm_pre_run(CPUState *cpu, struct kvm_run *run);
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 69117271fa3..f10d93a98df 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -452,6 +452,16 @@ static void kvm_create_vcpu_internal(CPUState *cpu, KVMState *s, int kvm_fd)
     return;
 }
 
+unsigned long kvm_vcpu_id(CPUState *cpu)
+{
+    const KVMCPUOps *ops = kvm_get_cpu_ops(cpu);
+
+    if (ops && ops->vcpu_id) {
+        return ops->vcpu_id(cpu);
+    }
+    return cpu->cpu_index;
+}
+
 static int kvm_rebind_vcpus(Error **errp)
 {
     CPUState *cpu;
@@ -462,7 +472,7 @@ static int kvm_rebind_vcpus(Error **errp)
     CPU_FOREACH(cpu) {
         const KVMCPUOps *ops = kvm_get_cpu_ops(cpu);
 
-        vcpu_id = kvm_arch_vcpu_id(cpu);
+        vcpu_id = kvm_vcpu_id(cpu);
 
         if (cpu->kvm_fd) {
             close(cpu->kvm_fd);
@@ -533,10 +543,10 @@ static void kvm_park_vcpu(CPUState *cpu)
 {
     struct KVMParkedVcpu *vcpu;
 
-    trace_kvm_park_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
+    trace_kvm_park_vcpu(cpu->cpu_index, kvm_vcpu_id(cpu));
 
     vcpu = g_malloc0(sizeof(*vcpu));
-    vcpu->vcpu_id = kvm_arch_vcpu_id(cpu);
+    vcpu->vcpu_id = kvm_vcpu_id(cpu);
     vcpu->kvm_fd = cpu->kvm_fd;
     QLIST_INSERT_HEAD(&kvm_state->kvm_parked_vcpus, vcpu, node);
 }
@@ -577,7 +587,7 @@ static void kvm_reset_parked_vcpus(KVMState *s)
  */
 static int kvm_create_vcpu(CPUState *cpu)
 {
-    unsigned long vcpu_id = kvm_arch_vcpu_id(cpu);
+    unsigned long vcpu_id = kvm_vcpu_id(cpu);
     KVMState *s = kvm_state;
     int kvm_fd;
 
@@ -653,7 +663,7 @@ static int do_kvm_destroy_vcpu(CPUState *cpu)
     KVMState *s = kvm_state;
     int ret = 0;
 
-    trace_kvm_destroy_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
+    trace_kvm_destroy_vcpu(cpu->cpu_index, kvm_vcpu_id(cpu));
 
     if (ops->destroy_vcpu) {
         ret = ops->destroy_vcpu(cpu);
@@ -702,7 +712,7 @@ static int map_kvm_run(KVMState *s, CPUState *cpu, Error **errp)
         ret = -errno;
         error_setg_errno(errp, ret,
                          "kvm_init_vcpu: mmap'ing vcpu state failed (%lu)",
-                         kvm_arch_vcpu_id(cpu));
+                         kvm_vcpu_id(cpu));
         goto err;
     }
 
@@ -736,7 +746,7 @@ int kvm_init_vcpu(CPUState *cpu, Error **errp)
     KVMState *s = kvm_state;
     int ret;
 
-    trace_kvm_init_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
+    trace_kvm_init_vcpu(cpu->cpu_index, kvm_vcpu_id(cpu));
 
     if (ops->pre_create_vcpu) {
         ret = ops->pre_create_vcpu(cpu, errp);
@@ -749,7 +759,7 @@ int kvm_init_vcpu(CPUState *cpu, Error **errp)
     if (ret < 0) {
         error_setg_errno(errp, -ret,
                          "kvm_init_vcpu: kvm_create_vcpu failed (%lu)",
-                         kvm_arch_vcpu_id(cpu));
+                         kvm_vcpu_id(cpu));
         goto err;
     }
 
@@ -769,7 +779,7 @@ int kvm_init_vcpu(CPUState *cpu, Error **errp)
     if (ret < 0) {
         error_setg_errno(errp, -ret,
                          "kvm_init_vcpu: init_vcpu failed (%lu)",
-                         kvm_arch_vcpu_id(cpu));
+                         kvm_vcpu_id(cpu));
     }
     cpu->kvm_vcpu_stats_fd = kvm_vcpu_ioctl(cpu, KVM_GET_STATS_FD, NULL);
 
diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
index 9379383e532..98630563b6b 100644
--- a/hw/i386/kvm/xen_evtchn.c
+++ b/hw/i386/kvm/xen_evtchn.c
@@ -575,7 +575,7 @@ static int assign_kernel_port(uint16_t type, evtchn_port_t port,
     ha.u.evtchn.type = type;
     ha.u.evtchn.flags = 0;
     ha.u.evtchn.deliver.port.port = port;
-    ha.u.evtchn.deliver.port.vcpu = kvm_arch_vcpu_id(cpu);
+    ha.u.evtchn.deliver.port.vcpu = kvm_vcpu_id(cpu);
     ha.u.evtchn.deliver.port.priority = KVM_IRQ_ROUTING_XEN_EVTCHN_PRIO_2LEVEL;
 
     return kvm_vm_ioctl(kvm_state, KVM_XEN_HVM_SET_ATTR, &ha);
@@ -937,7 +937,7 @@ static int set_port_pending(XenEvtchnState *s, evtchn_port_t port)
         }
 
         evt.port = port;
-        evt.vcpu = kvm_arch_vcpu_id(cpu);
+        evt.vcpu = kvm_vcpu_id(cpu);
         evt.priority = KVM_IRQ_ROUTING_XEN_EVTCHN_PRIO_2LEVEL;
 
         return kvm_vm_ioctl(kvm_state, KVM_XEN_HVM_EVTCHN_SEND, &evt);
@@ -1815,7 +1815,7 @@ int xen_evtchn_translate_pirq_msi(struct kvm_irq_routing_entry *route,
 
     route->type = KVM_IRQ_ROUTING_XEN_EVTCHN;
     route->u.xen_evtchn.port = port;
-    route->u.xen_evtchn.vcpu = kvm_arch_vcpu_id(cpu);
+    route->u.xen_evtchn.vcpu = kvm_vcpu_id(cpu);
     route->u.xen_evtchn.priority = KVM_IRQ_ROUTING_XEN_EVTCHN_PRIO_2LEVEL;
 
     return 0; /* Handled */
diff --git a/hw/intc/openpic_kvm.c b/hw/intc/openpic_kvm.c
index b099da20eb9..4131292b02b 100644
--- a/hw/intc/openpic_kvm.c
+++ b/hw/intc/openpic_kvm.c
@@ -188,7 +188,7 @@ static int kvm_openpic_handle_vmfd_change(NotifierWithReturn *notifier,
 
     CPU_FOREACH(cs) {
         ret = kvm_vcpu_enable_cap(cs, KVM_CAP_IRQ_MPIC, 0, opp->fd,
-                                   kvm_arch_vcpu_id(cs));
+                                   kvm_vcpu_id(cs));
         if (ret < 0) {
             return ret;
         }
@@ -322,7 +322,7 @@ int kvm_openpic_connect_vcpu(DeviceState *d, CPUState *cs)
     KVMOpenPICState *opp = KVM_OPENPIC(d);
 
     return kvm_vcpu_enable_cap(cs, KVM_CAP_IRQ_MPIC, 0, opp->fd,
-                               kvm_arch_vcpu_id(cs));
+                               kvm_vcpu_id(cs));
 }
 
 static const Property kvm_openpic_properties[] = {
diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index 26d30b41c15..9cbe536cc7c 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -40,7 +40,7 @@ static QLIST_HEAD(, KVMEnabledCPU)
 static bool kvm_cpu_is_enabled(CPUState *cs)
 {
     KVMEnabledCPU *enabled_cpu;
-    unsigned long vcpu_id = kvm_arch_vcpu_id(cs);
+    unsigned long vcpu_id = kvm_vcpu_id(cs);
 
     QLIST_FOREACH(enabled_cpu, &kvm_enabled_cpus, node) {
         if (enabled_cpu->vcpu_id == vcpu_id) {
@@ -53,7 +53,7 @@ static bool kvm_cpu_is_enabled(CPUState *cs)
 static void kvm_cpu_enable(CPUState *cs)
 {
     KVMEnabledCPU *enabled_cpu;
-    unsigned long vcpu_id = kvm_arch_vcpu_id(cs);
+    unsigned long vcpu_id = kvm_vcpu_id(cs);
 
     enabled_cpu = g_malloc(sizeof(*enabled_cpu));
     enabled_cpu->vcpu_id = vcpu_id;
@@ -89,7 +89,7 @@ int kvmppc_xive_cpu_set_state(XiveTCTX *tctx, Error **errp)
     if (ret != 0) {
         error_setg_errno(errp, -ret,
                          "XIVE: could not restore KVM state of CPU %ld",
-                         kvm_arch_vcpu_id(tctx->cs));
+                         kvm_vcpu_id(tctx->cs));
         return ret;
     }
 
@@ -108,7 +108,7 @@ int kvmppc_xive_cpu_get_state(XiveTCTX *tctx, Error **errp)
     if (ret != 0) {
         error_setg_errno(errp, -ret,
                          "XIVE: could not capture KVM state of CPU %ld",
-                         kvm_arch_vcpu_id(tctx->cs));
+                         kvm_vcpu_id(tctx->cs));
         return ret;
     }
 
@@ -162,7 +162,7 @@ int kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp)
         return 0;
     }
 
-    vcpu_id = kvm_arch_vcpu_id(tctx->cs);
+    vcpu_id = kvm_vcpu_id(tctx->cs);
 
     trace_kvm_xive_cpu_connect(vcpu_id);
 
diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 61f66d1019d..fb16f628eca 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -80,7 +80,7 @@ void icp_get_kvm_state(ICPState *icp)
     ret = kvm_get_one_reg(icp->cs, KVM_REG_PPC_ICP_STATE, &state);
     if (ret != 0) {
         error_report("Unable to retrieve KVM interrupt controller state"
-                " for CPU %ld: %s", kvm_arch_vcpu_id(icp->cs), strerror(errno));
+                " for CPU %ld: %s", kvm_vcpu_id(icp->cs), strerror(errno));
         exit(1);
     }
 
@@ -127,7 +127,7 @@ int icp_set_kvm_state(ICPState *icp, Error **errp)
         error_setg_errno(errp, -ret,
                          "Unable to restore KVM interrupt controller state (0x%"
                          PRIx64 ") for CPU %ld", state,
-                         kvm_arch_vcpu_id(icp->cs));
+                         kvm_vcpu_id(icp->cs));
         return ret;
     }
 
@@ -148,7 +148,7 @@ void icp_kvm_realize(DeviceState *dev, Error **errp)
     }
 
     cs = icp->cs;
-    vcpu_id = kvm_arch_vcpu_id(cs);
+    vcpu_id = kvm_vcpu_id(cs);
 
     /*
      * If we are reusing a parked vCPU fd corresponding to the CPU
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 042a075e612..ad8166e0b41 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -708,11 +708,6 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     return 0;
 }
 
-unsigned long kvm_arch_vcpu_id(CPUState *cpu)
-{
-    return cpu->cpu_index;
-}
-
 /* We track all the KVM devices which need their memory addresses
  * passing to the kernel in a list of these structures.
  * When board init is complete we run through the list and
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index 8d250b3a847..6990cd8d5c4 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -238,6 +238,7 @@ static const KVMCPUOps x86_kvm_cpu_ops = {
     .pre_create_vcpu = x86_kvm_pre_create_vcpu,
     .init_vcpu = x86_kvm_init_vcpu,
     .destroy_vcpu = x86_kvm_destroy_vcpu,
+    .vcpu_id = x86_kvm_vcpu_id,
     .get_registers = x86_kvm_get_registers,
     .put_registers = x86_kvm_put_registers,
     .pre_run = x86_kvm_pre_run,
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index a8109004e43..a3076d43b45 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -862,7 +862,7 @@ static void cpu_update_state(void *opaque, bool running, RunState state)
     }
 }
 
-unsigned long kvm_arch_vcpu_id(CPUState *cs)
+unsigned long x86_kvm_vcpu_id(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
     return cpu->apic_id;
@@ -3046,7 +3046,7 @@ static void *kvm_msr_energy_thread(void *data)
                     thd_stat[i].is_vcpu = true;
                     thd_stat[i].vcpu_id = cpu->cpu_index;
                     pkg_stat[thd_stat[i].pkg_id].nb_vcpu++;
-                    thd_stat[i].acpi_id = kvm_arch_vcpu_id(cpu);
+                    thd_stat[i].acpi_id = kvm_vcpu_id(cpu);
                     break;
                 }
             }
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 6705e6698bd..97b6b448edf 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -1445,11 +1445,6 @@ static int loongarch_kvm_destroy_vcpu(CPUState *cs)
     return 0;
 }
 
-unsigned long kvm_arch_vcpu_id(CPUState *cs)
-{
-    return cs->cpu_index;
-}
-
 int kvm_arch_release_virq_post(int virq)
 {
     return 0;
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index cb461963713..ffc7a33bf17 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -443,7 +443,7 @@ void kvm_check_mmu(PowerPCCPU *cpu, Error **errp)
 }
 #endif /* !defined (TARGET_PPC64) */
 
-unsigned long kvm_arch_vcpu_id(CPUState *cpu)
+static unsigned long ppc_kvm_vcpu_id(CPUState *cpu)
 {
     return POWERPC_CPU(cpu)->vcpu_id;
 }
@@ -3064,6 +3064,7 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
 
 static const KVMCPUOps ppc_kvm_cpu_ops = {
     .init_vcpu = ppc_kvm_init_vcpu,
+    .vcpu_id = ppc_kvm_vcpu_id,
     .get_registers = ppc_kvm_get_registers,
     .put_registers = ppc_kvm_put_registers,
     .handle_exit = ppc_kvm_handle_exit,
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 4247cbec3d9..d9984828048 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1512,11 +1512,6 @@ int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
     return 0;
 }
 
-unsigned long kvm_arch_vcpu_id(CPUState *cpu)
-{
-    return cpu->cpu_index;
-}
-
 static void kvm_riscv_vm_state_change(void *opaque, bool running,
                                       RunState state)
 {
@@ -1806,7 +1801,7 @@ void kvm_riscv_reset_vcpu(RISCVCPU *cpu)
         env->gpr[i] = 0;
     }
     env->pc = cpu->env.kernel_addr;
-    env->gpr[10] = kvm_arch_vcpu_id(CPU(cpu)); /* a0 */
+    env->gpr[10] = kvm_vcpu_id(CPU(cpu)); /* a0 */
     env->gpr[11] = cpu->env.fdt_addr;          /* a1 */
 
     kvm_riscv_reset_regs_csr(env);
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 0dcd198afe3..7400fe41f87 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -395,11 +395,6 @@ int kvm_arch_irqchip_create(KVMState *s)
     return 0;
 }
 
-unsigned long kvm_arch_vcpu_id(CPUState *cpu)
-{
-    return cpu->cpu_index;
-}
-
 static int s390x_kvm_init_vcpu(CPUState *cs)
 {
     unsigned int max_cpus = MACHINE(qdev_get_machine())->smp.max_cpus;
-- 
2.47.3


