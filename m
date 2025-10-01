Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0582DCAC5B8
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 01:05:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3lFB-0005HP-15; Tue, 30 Sep 2025 21:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1v3lF4-0005G2-5J
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 21:02:50 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1v3lEi-0007z1-H0
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 21:02:49 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3ee12a63af1so4309916f8f.1
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 18:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=opnsrc.net; s=google; t=1759280542; x=1759885342; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QPR0o41Frny4pKRUCSDDT4xsBtm8U/Vvvxat3jE//sc=;
 b=fNCmZjCUnFz6y3kzsHHWxdQbZKSu9QztjTz22lbtSPDzb/2evDsaI2ktTq7b7IvgC6
 EXgNnfR+uj6N+NDd9xKGSUYQpIeR0MDMAOYHw7avHbKdHgeb+ZTMNAs53WvhcLRaURFK
 SjWrPnwe2UZW9jWPl/zcc02PgEkQNVZFTclN/lcbDTi08DiUmiHwBOSK29vY6THqgkzf
 bXSRSh8wiQjvYUzWvdyYkOxVOiuBppVHJ5fGAO71PpdgC9+l+9As4a60DpCGH7S5WuEH
 yicl3cfIWVYKz2SUMMgTmo0/WKSkUtk+iegvLw8stTGAOJ6JwYvA0zcyrVWGW/UOcPg5
 D8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759280542; x=1759885342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QPR0o41Frny4pKRUCSDDT4xsBtm8U/Vvvxat3jE//sc=;
 b=o/U210N55/4bPwgWDCYNn52KOa6GS0E+aqLCtg4Y2myxo8fmjuTzGPGbAiu2KqSjSH
 LyvVYlYtHpjsS3OMK4RPj7yNO95W3UkH0hT8dfBJa+WmPEiJpOVmDECwMBLwgCVySz/U
 KMuJM8kGk7DTN/qSfgMqXnVH6Jm5FsDVIcyUTfkma8ZOcgY5QUAs5o/Yz2VlatbTqZAE
 sSNaUbPB//qGTazdLs5kdTUmF6wWIXoo5M2zjw4J+LkLRHg/W9a9Rspkhx+Bhss8PynH
 tT4WaaXdg9LeSPqlQpVRWt2y/6r7hHHYlQRYzZoG2GG5VoF753m2iuxzW6n+9UoXTTJx
 lAwQ==
X-Gm-Message-State: AOJu0YwlPhr17wtoQ3Gv3PrrNAB8Y96AFwzVmNt52Z6MWxq5fgi3xNMJ
 cBHHrUh3CckuhMRhb1yQ3aixmqavgHHJPdW0ImPYoiqtV7ajUrXYb7iBgmSw7SfwsPGBNJZVqBb
 z7odALvJ6xg==
X-Gm-Gg: ASbGncsrhzu5KL+4dyMob/WaSWxeCMzneajDI6hpFJ/28YYjL2Rkmno9JQHrLc/yVIU
 bSbIlRjmnRPncPtFlqKsFhjht0oT2NTts+DsjLuTeym+LOaSXytMkMGacn2507tGYUqP4EKA7hy
 Mv2NBK7jHSKVdMNUDgCWHLYFLlvm6EBwEAFaYKl+kOLqEJBJ8111yPXmVTPGSgr2rdOH5Yj74mW
 ClXPXauFfY5xPOrNFvfTpMgebRmGNK4Lbsj/ecQQD/kSDtO3HxXfQqXcv2lSlQajGPrR5vKSnIP
 rd5MjuaZ914IZ5Qz5rWfzs7pSkZtKL1rUud5ABQm0xG/jrZ9wBpsKfi39808yhnt9frs+aD/FkY
 A1pWCPVVbuzto3L1K7tFfvv6BOGsEAJc/FNbC5ONf/X/XISPnV/yf5vn+/y/CTqbl2o+afDZGpL
 EO8ItknLTBK7YtAN5vt4Xr9gTKjyG5Rr+JPIf8psCvaYY=
X-Google-Smtp-Source: AGHT+IFxPFV6XUQCP6z9xEmOSgO6v2OxujqbtZ00dj4mQUoUNgabVHt8FI7+jtrdo434dqGyKzIQ/w==
X-Received: by 2002:a05:6000:26c7:b0:3f1:5bdd:190a with SMTP id
 ffacd0b85a97d-425577ee92bmr1209557f8f.3.1759280542024; 
 Tue, 30 Sep 2025 18:02:22 -0700 (PDT)
Received: from localhost.localdomain ([90.209.204.182])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb985e080sm24587426f8f.24.2025.09.30.18.02.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 18:02:21 -0700 (PDT)
From: salil.mehta@opnsrc.net
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	mst@redhat.com
Cc: salil.mehta@huawei.com, maz@kernel.org, jean-philippe@linaro.org,
 jonathan.cameron@huawei.com, lpieralisi@kernel.org,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 imammedo@redhat.com, armbru@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com,
 will@kernel.org, ardb@kernel.org, oliver.upton@linux.dev,
 pbonzini@redhat.com, gshan@redhat.com, rafael@kernel.org,
 borntraeger@linux.ibm.com, alex.bennee@linaro.org,
 gustavo.romero@linaro.org, npiggin@gmail.com, harshpb@linux.ibm.com,
 linux@armlinux.org.uk, darren@os.amperecomputing.com,
 ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com,
 gankulkarni@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net, zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, wangzhou1@hisilicon.com,
 linuxarm@huawei.com, jiakernel2@gmail.com, maobibo@loongson.cn,
 lixianglai@loongson.cn, shahuang@redhat.com, zhao1.liu@intel.com
Subject: [PATCH RFC V6 04/24] arm/virt, target/arm: Add new ARMCPU {socket,
 cluster, core, thread}-id property
Date: Wed,  1 Oct 2025 01:01:07 +0000
Message-Id: <20251001010127.3092631-5-salil.mehta@opnsrc.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
References: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=salil.mehta@opnsrc.net; helo=mail-wr1-x431.google.com
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

From: Salil Mehta <salil.mehta@huawei.com>

Store the user-specified topology (socket/cluster/core/thread) and derive a
unique 'vcpu-id'. The 'vcpu-id' is used as the slot index in the possible vCPUs
list when administratively enabling or disabling a vCPU.

Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Reviewed-by: Miguel Luis <miguel.luis@oracle.com>
---
 hw/arm/virt.c         | 10 ++++++++++
 include/hw/arm/virt.h | 36 ++++++++++++++++++++++++++++++++++++
 target/arm/cpu.c      |  4 ++++
 target/arm/cpu.h      |  4 ++++
 4 files changed, 54 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 76f21bd56a..4ded19dc69 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2334,6 +2334,14 @@ static void machvirt_init(MachineState *machine)
                           &error_fatal);
 
         aarch64 &= object_property_get_bool(cpuobj, "aarch64", NULL);
+        object_property_set_int(cpuobj, "socket-id", virt_get_socket_id(n),
+                                NULL);
+        object_property_set_int(cpuobj, "cluster-id", virt_get_cluster_id(n),
+                                NULL);
+        object_property_set_int(cpuobj, "core-id", virt_get_core_id(n),
+                                NULL);
+        object_property_set_int(cpuobj, "thread-id", virt_get_thread_id(n),
+                                NULL);
 
         if (!vms->secure) {
             object_property_set_bool(cpuobj, "has_el3", false, NULL);
@@ -2902,6 +2910,7 @@ static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
 {
     int n;
     unsigned int max_cpus = ms->smp.max_cpus;
+    unsigned int smp_threads = ms->smp.threads;
     VirtMachineState *vms = VIRT_MACHINE(ms);
     MachineClass *mc = MACHINE_GET_CLASS(vms);
 
@@ -2915,6 +2924,7 @@ static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
     ms->possible_cpus->len = max_cpus;
     for (n = 0; n < ms->possible_cpus->len; n++) {
         ms->possible_cpus->cpus[n].type = ms->cpu_type;
+        ms->possible_cpus->cpus[n].vcpus_count = smp_threads;
         ms->possible_cpus->cpus[n].arch_id =
             virt_cpu_mp_affinity(vms, n);
 
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 365a28b082..683e4b965a 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -213,4 +213,40 @@ static inline int virt_gicv3_redist_region_count(VirtMachineState *vms)
             vms->highmem_redists) ? 2 : 1;
 }
 
+static inline int virt_get_socket_id(int cpu_index)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+
+    assert(cpu_index >= 0 && cpu_index < ms->possible_cpus->len);
+
+    return ms->possible_cpus->cpus[cpu_index].props.socket_id;
+}
+
+static inline int virt_get_cluster_id(int cpu_index)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+
+    assert(cpu_index >= 0 && cpu_index < ms->possible_cpus->len);
+
+    return ms->possible_cpus->cpus[cpu_index].props.cluster_id;
+}
+
+static inline int virt_get_core_id(int cpu_index)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+
+    assert(cpu_index >= 0 && cpu_index < ms->possible_cpus->len);
+
+    return ms->possible_cpus->cpus[cpu_index].props.core_id;
+}
+
+static inline int virt_get_thread_id(int cpu_index)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+
+    assert(cpu_index >= 0 && cpu_index < ms->possible_cpus->len);
+
+    return ms->possible_cpus->cpus[cpu_index].props.thread_id;
+}
+
 #endif /* QEMU_ARM_VIRT_H */
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 0c9a2e7ea4..7e0d5b2ed8 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2607,6 +2607,10 @@ static const Property arm_cpu_properties[] = {
     DEFINE_PROP_UINT64("mp-affinity", ARMCPU,
                         mp_affinity, ARM64_AFFINITY_INVALID),
     DEFINE_PROP_INT32("node-id", ARMCPU, node_id, CPU_UNSET_NUMA_NODE_ID),
+    DEFINE_PROP_INT32("socket-id", ARMCPU, socket_id, 0),
+    DEFINE_PROP_INT32("cluster-id", ARMCPU, cluster_id, 0),
+    DEFINE_PROP_INT32("core-id", ARMCPU, core_id, 0),
+    DEFINE_PROP_INT32("thread-id", ARMCPU, thread_id, 0),
     DEFINE_PROP_INT32("core-count", ARMCPU, core_count, -1),
     /* True to default to the backward-compat old CNTFRQ rather than 1Ghz */
     DEFINE_PROP_BOOL("backcompat-cntfrq", ARMCPU, backcompat_cntfrq, false),
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index dc9b6dce4c..cd5982d362 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1126,6 +1126,10 @@ struct ArchCPU {
     QLIST_HEAD(, ARMELChangeHook) el_change_hooks;
 
     int32_t node_id; /* NUMA node this CPU belongs to */
+    int32_t socket_id;
+    int32_t cluster_id;
+    int32_t core_id;
+    int32_t thread_id;
 
     /* Used to synchronize KVM and QEMU in-kernel device levels */
     uint8_t device_irq_level;
-- 
2.34.1


