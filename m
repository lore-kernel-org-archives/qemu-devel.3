Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71806E98FD0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 06:41:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAj4T-0007tT-Qf; Thu, 09 Apr 2026 02:40:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangruikang@iscas.ac.cn>)
 id 1wAj4N-0007qq-PB; Thu, 09 Apr 2026 02:40:52 -0400
Received: from smtp81.cstnet.cn ([159.226.251.81] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wangruikang@iscas.ac.cn>)
 id 1wAj4H-0004PT-EA; Thu, 09 Apr 2026 02:40:49 -0400
Received: from [127.0.0.2] (unknown [36.110.52.2])
 by APP-03 (Coremail) with SMTP id rQCowABnht3aSddpeI91DQ--.34096S3;
 Thu, 09 Apr 2026 14:40:27 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Date: Thu, 09 Apr 2026 14:40:11 +0800
Subject: [PATCH 1/5] hw/arm: Fix unit addresses of FDT CPU nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-fix-unit-address-v1-1-946840930af2@iscas.ac.cn>
References: <20260409-fix-unit-address-v1-0-946840930af2@iscas.ac.cn>
In-Reply-To: <20260409-fix-unit-address-v1-0-946840930af2@iscas.ac.cn>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>, qemu-arm@nongnu.org, 
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paul Burton <paulburton@kernel.org>, 
 Aleksandar Rikalo <arikalo@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Jia Liu <proljc@gmail.com>, Stafford Horne <shorne@gmail.com>, 
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-riscv@nongnu.org, 
 Vivian Wang <wangruikang@iscas.ac.cn>
X-Mailer: b4 0.15.1
X-CM-TRANSID: rQCowABnht3aSddpeI91DQ--.34096S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAw4xAw17Kw13ArWkur1rJFb_yoW5Gr1rpr
 Z2kFyDtrWIkF45G3ySqFyjk3WrGF15W3y7K39Fk393CFyDuryxWF40yayrKry8Gw1kKFW5
 ZFsYqF97Xas2grJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUQYb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
 8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF
 64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcV
 CY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv
 6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c
 02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE
 4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4
 IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48J
 MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
 AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
 0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
 v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
 xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8Q_-DUUUUU==
X-Originating-IP: [36.110.52.2]
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/
Received-SPF: pass client-ip=159.226.251.81;
 envelope-from=wangruikang@iscas.ac.cn; helo=cstnet.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The node unit addresses should be based on the reg value (which is in
turn based on MPIDR), rather than some arbitrary number [1]. Also, they
should have been in hex, not decimal, as per de facto convention [2].
Fix them.

Link: https://github.com/devicetree-org/devicetree-specification/blob/v0.4/source/chapter2-devicetree-basics.rst#devicetree-structure-and-conventions # [1]
Link: https://lore.kernel.org/devicetree-spec/CAL_JsqJFv3+UJ-bjLGk0i7Wc+spsowCrqQZ_s3P4gN8r1W-Q-w@mail.gmail.com/ # [2]
Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
---
 hw/arm/sbsa-ref.c | 4 ++--
 hw/arm/virt.c     | 7 +++++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 52c35e10c2..7fd631bff5 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -259,10 +259,10 @@ static void create_fdt(SBSAMachineState *sms)
     qemu_fdt_setprop_cell(sms->fdt, "/cpus", "#size-cells", 0x0);
 
     for (cpu = sms->smp_cpus - 1; cpu >= 0; cpu--) {
-        char *nodename = g_strdup_printf("/cpus/cpu@%d", cpu);
+        uint64_t mpidr = sbsa_ref_cpu_mp_affinity(sms, cpu);
+        char *nodename = g_strdup_printf("/cpus/cpu@%" PRIx64, mpidr);
         ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(cpu));
         CPUState *cs = CPU(armcpu);
-        uint64_t mpidr = sbsa_ref_cpu_mp_affinity(sms, cpu);
 
         qemu_fdt_add_subnode(sms->fdt, nodename);
         qemu_fdt_setprop_u64(sms->fdt, nodename, "reg", mpidr);
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index ec0d8475ca..20d62cc311 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -466,8 +466,9 @@ static void fdt_add_cpu_nodes(const VirtMachineState *vms)
     qemu_fdt_setprop_cell(ms->fdt, "/cpus", "#size-cells", 0x0);
 
     for (cpu = smp_cpus - 1; cpu >= 0; cpu--) {
-        char *nodename = g_strdup_printf("/cpus/cpu@%d", cpu);
         ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(cpu));
+        char *nodename = g_strdup_printf("/cpus/cpu@%" PRIx64,
+                                         arm_cpu_mp_affinity(armcpu));
         CPUState *cs = CPU(armcpu);
 
         qemu_fdt_add_subnode(ms->fdt, nodename);
@@ -521,7 +522,9 @@ static void fdt_add_cpu_nodes(const VirtMachineState *vms)
         qemu_fdt_add_subnode(ms->fdt, "/cpus/cpu-map");
 
         for (cpu = smp_cpus - 1; cpu >= 0; cpu--) {
-            char *cpu_path = g_strdup_printf("/cpus/cpu@%d", cpu);
+            ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(cpu));
+            char *cpu_path = g_strdup_printf("/cpus/cpu@%" PRIx64,
+                                             arm_cpu_mp_affinity(armcpu));
             char *map_path;
 
             if (ms->smp.threads > 1) {

-- 
2.53.0


