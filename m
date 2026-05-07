Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC783CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:52:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL11z-0005Xe-Da; Thu, 07 May 2026 11:52:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11x-0005RH-WB
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:54 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11w-00041x-6U
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:53 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-488d2079582so11441885e9.2
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169171; x=1778773971; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=z/cwKccCO6TzDm0KBf/XNX1ldLGoAizL2obuZ6Hd33w=;
 b=hZ4YWo+DmvFZutzEIUgjw0WhNUUtRlICBjMH/1hzOmyl3QBIl15fMobn3f6DZanSw+
 xEboAJJ/F94zl5QgGiQNicJB9J5CJmoTZKEg08CoqtrXy/ISIgyKX18sOaNNkwV1l5jt
 Urnqo9oR4dCmwFus4ZE1Icm7xj/FWw1Cg5lu65MLAyhRz0vWnnQsrmHkjX5vEUCj8Fdv
 C59awN/VlhTcJLdvgyOW3vilCTmHjP9+lHa6NySvuRwi85RecyG1/tQEtvmg8nO3C5t/
 FzZg5wjdbyzae9TZtz/btOzBJgf1BwUOMIlsQShWeWyucV6L2bBrGaSwjHyeTllzq27e
 Rp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169171; x=1778773971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=z/cwKccCO6TzDm0KBf/XNX1ldLGoAizL2obuZ6Hd33w=;
 b=IvE4/owJU8J26iCkHAtpqAu9dpf2tN39/m9E64jqotwxsBBX0WF81RT94CzurVS+VI
 hH+Ipce1uwQPqU3Qy4ID00v52v9/bI02G2Bm43HI0FWkWcinoQrH71MD7Xw1Oeto6fMz
 6LMNqlKTvqXv98x0MV/R4hQ48c9IQw0YCWf+QpO9t/ZerldMs0moTqdj32A38FDqv+JB
 /4Xiw8kZ9Inx7e9JALfDTNoxvVD3UFfToUb7hl6BKw6Je3VZmBscr6ZFvjDDXT16yA4J
 4JbGXH5rEQm3mjwtqLzdgAA1sU3iPuouU+RqgsjAIuKNlQS8opduuFzbVfUCWRo2ZKMr
 pVTg==
X-Gm-Message-State: AOJu0YzZg9GC6Ui1wXTKRZg1woq+vBx3rkOW5rfB2TG4pBHl2AC80ian
 mkzl069ycJfn3aDPxvEMczWsKG9D6CgAN6LsGAfpquRizRJNY3zxAxYlbCKJgRx5EyQ70E41umT
 9xPx1
X-Gm-Gg: AeBDieu53PaslDPfbLsok+Zut8wt9I4QM+wuSd8lKfkH0wQ2ceXWvqPAYkPQOXn8UIC
 x2+1GCgCbo9RhhoElOygaKqrkOnswc3lVJbsnZwqkqwTh/bNuBij6RzyKh5p735cYLB8V6wZ6Xt
 Ujy1R9mBKZZFGz3/2qrCi8fAQJaKNxSjJoPjA9nnM3nj3c3jC94v/gapNXHKX0fzgz5RwiKKVQe
 0gqLJGhm03Z0+WeFGV3FY6DP9+JVvXN2+aZEl4IOOf7gZeZRdrQ7gRk//iMpw9w9VzTEj7xaNAf
 Kc3vpqQaH6MsNzfrG1zuYkSXD3X9apNx1MZFPuF05gwXMhLUKODnCH19sRGxux1juDnlGLr1EO4
 jGCKi4h/wQmifigKE7oo3moPS85nklogWT1B7nwLVExlEg+GVqyOkbgK8wPLptelEnJq1XDZs6q
 +liDft/kMc+Y1OO3PAZsEJNgHcdnj5+l39+IFZJp9wJmxkNxQYOgA6pZhjWxuR7PVZ9yOQcPI9g
 hGNIR9IL7dhzKnQP4qnywXSe3m9qwA=
X-Received: by 2002:a05:600c:8011:b0:48a:80cb:1bb4 with SMTP id
 5b1f17b1804b1-48e51f3b00emr133225655e9.22.1778169170501; 
 Thu, 07 May 2026 08:52:50 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm41552195e9.18.2026.05.07.08.52.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:52:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 56/67] hw/arm/virt: Remember CPU phandles rather than looking
 them up by name
Date: Thu,  7 May 2026 16:51:43 +0100
Message-ID: <20260507155154.1886557-57-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507155154.1886557-1-peter.maydell@linaro.org>
References: <20260507155154.1886557-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

In fdt_add_cpu_nodes(), we currently add phandles for each CPU node
if we are going to add a topology description, and when we do, we
re-look-up the phandle by node name when creating the topology
description.

For GICv5 we will also want to refer to the CPU phandles; so always
add a phandle, and keep track of those phandles in the
VirtMachineState so we don't have to look them up by name in the dtb
every time.

The phandle property is extra data in the final DTB, but only a tiny
amount, so it's not worth trying to carefully track the conditions
when we're going to need them so we only emit them when required.

(We need to change the smp_cpus variable to unsigned because
otherwise gcc thinks that we might be passing a negative number to
g_new0() and produces an error:

/usr/include/glib-2.0/glib/gmem.h:270:19: error: argument 1 range [18446744071562067968, 18446744073709551615] exceeds maximum object size 9223372036854775807 [-Werror=alloc-size-larger-than=]
  270 |             __p = g_##func##_n (__n, __s);                      \
      |                   ^~~~~~~~~~~~~~~~~~~~~~~
/usr/include/glib-2.0/glib/gmem.h:332:57: note: in expansion of macro ‘_G_NEW’
  332 | #define g_new0(struct_type, n_structs)                  _G_NEW (struct_type, n_structs, malloc0)
      |                                                         ^~~~~~
../../hw/arm/virt.c:469:25: note: in expansion of macro ‘g_new0’
  469 |     vms->cpu_phandles = g_new0(uint32_t, smp_cpus);
      |                         ^~~~~~

)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Message-id: 20260327111700.795099-57-peter.maydell@linaro.org
---
 hw/arm/virt.c         | 19 ++++++++++---------
 include/hw/arm/virt.h |  1 +
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index fe19030886..58e05acb8c 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -595,14 +595,14 @@ static bool partial_cache_description(const MachineState *ms, int num_caches)
     return false;
 }
 
-static void fdt_add_cpu_nodes(const VirtMachineState *vms)
+static void fdt_add_cpu_nodes(VirtMachineState *vms)
 {
     int cpu;
     int addr_cells = 1;
     const MachineState *ms = MACHINE(vms);
     const MachineClass *mc = MACHINE_GET_CLASS(ms);
     const VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
-    int smp_cpus = ms->smp.cpus;
+    unsigned int smp_cpus = ms->smp.cpus;
     int socket_id, cluster_id, core_id;
     uint32_t next_level = 0;
     uint32_t socket_offset = 0;
@@ -656,6 +656,8 @@ static void fdt_add_cpu_nodes(const VirtMachineState *vms)
     qemu_fdt_setprop_cell(ms->fdt, "/cpus", "#address-cells", addr_cells);
     qemu_fdt_setprop_cell(ms->fdt, "/cpus", "#size-cells", 0x0);
 
+    vms->cpu_phandles = g_new0(uint32_t, smp_cpus);
+
     for (cpu = smp_cpus - 1; cpu >= 0; cpu--) {
         socket_id = cpu / (ms->smp.clusters * ms->smp.cores * ms->smp.threads);
         cluster_id = cpu / (ms->smp.cores * ms->smp.threads) % ms->smp.clusters;
@@ -665,6 +667,7 @@ static void fdt_add_cpu_nodes(const VirtMachineState *vms)
         ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(cpu));
         CPUState *cs = CPU(armcpu);
         const char *prefix = NULL;
+        uint32_t phandle;
 
         qemu_fdt_add_subnode(ms->fdt, nodename);
         qemu_fdt_setprop_string(ms->fdt, nodename, "device_type", "cpu");
@@ -689,10 +692,9 @@ static void fdt_add_cpu_nodes(const VirtMachineState *vms)
                 ms->possible_cpus->cpus[cs->cpu_index].props.node_id);
         }
 
-        if (!vmc->no_cpu_topology) {
-            qemu_fdt_setprop_cell(ms->fdt, nodename, "phandle",
-                                  qemu_fdt_alloc_phandle(ms->fdt));
-        }
+        phandle = qemu_fdt_alloc_phandle(ms->fdt);
+        qemu_fdt_setprop_cell(ms->fdt, nodename, "phandle", phandle);
+        vms->cpu_phandles[cpu] = phandle;
 
         if (!vmc->no_cpu_topology && num_cache) {
             for (uint8_t i = 0; i < num_cache; i++) {
@@ -847,7 +849,6 @@ static void fdt_add_cpu_nodes(const VirtMachineState *vms)
         qemu_fdt_add_subnode(ms->fdt, "/cpus/cpu-map");
 
         for (cpu = smp_cpus - 1; cpu >= 0; cpu--) {
-            char *cpu_path = g_strdup_printf("/cpus/cpu@%d", cpu);
             char *map_path;
 
             if (ms->smp.threads > 1) {
@@ -865,10 +866,10 @@ static void fdt_add_cpu_nodes(const VirtMachineState *vms)
                     cpu % ms->smp.cores);
             }
             qemu_fdt_add_path(ms->fdt, map_path);
-            qemu_fdt_setprop_phandle(ms->fdt, map_path, "cpu", cpu_path);
+            qemu_fdt_setprop_cell(ms->fdt, map_path, "cpu",
+                                  vms->cpu_phandles[cpu]);
 
             g_free(map_path);
-            g_free(cpu_path);
         }
     }
 }
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 13e135a460..b74ffada7e 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -176,6 +176,7 @@ struct VirtMachineState {
     uint32_t gic_phandle;
     uint32_t msi_phandle;
     uint32_t iommu_phandle;
+    uint32_t *cpu_phandles;
     int psci_conduit;
     uint8_t virtio_transports;
     hwaddr highest_gpa;
-- 
2.43.0


