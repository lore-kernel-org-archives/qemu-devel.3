Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA27C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 08:33:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjxYm-0002zB-0z; Tue, 12 Mar 2024 04:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiongyining1480@phytium.com.cn>)
 id 1rjxYf-0002xr-2D; Tue, 12 Mar 2024 04:32:25 -0400
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xiongyining1480@phytium.com.cn>)
 id 1rjxYc-0002kd-UZ; Tue, 12 Mar 2024 04:32:24 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwDHzEQPE_Bl4iXhDA--.32666S2;
 Tue, 12 Mar 2024 16:32:15 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwCXjPAEE_BlkXMAAA--.584S5;
 Tue, 12 Mar 2024 16:32:08 +0800 (CST)
From: Xiong Yining <xiongyining1480@phytium.com.cn>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: rad@semihalf.com, peter.maydell@linaro.org, quic_llindhol@quicinc.com,
 marcin.juszkiewicz@linaro.org, chenbaozi@phytium.com.cn,
 xiongyining1480 <xiongyining1480@phytium.com.cn>
Subject: [PATCH v2 2/2] hw/arm/sbsa-ref: Add cpu-map to device tree
Date: Tue, 12 Mar 2024 08:30:49 +0000
Message-Id: <20240312083049.3412522-3-xiongyining1480@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312083049.3412522-1-xiongyining1480@phytium.com.cn>
References: <20240312083049.3412522-1-xiongyining1480@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwCXjPAEE_BlkXMAAA--.584S5
X-CM-SenderInfo: x0lr0wp1lqx0bjrumio6sk53xlxphulrpou0/1tbiAQACBmXvXPYDKwAAsN
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=xiongyinin
 g1480@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7AF13Cr1kAw1xJFWDWFy7GFg_yoW8Cw15pw
 4UGFn8WrW5CrnFvayfWa42gFyFgw1rXw47Xw47KayFyw17G34fXF1IyF9Yk34UGry2gFya
 krsxCFyFg34UJr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=xiongyining1480@phytium.com.cn;
 helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: xiongyining1480 <xiongyining1480@phytium.com.cn>

Support CPU topology description through device tree.

Signed-off-by: Xiong Yining <xiongyining1480@phytium.com.cn>
Signed-off-by: Chen Baozi <chenbaozi@phytium.com.cn>
Reviewed-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
---
 hw/arm/sbsa-ref.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index fde7dd528f..5b2c32515d 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -264,9 +264,43 @@ static void create_fdt(SBSAMachineState *sms)
                 ms->possible_cpus->cpus[cs->cpu_index].props.node_id);
         }
 
+        qemu_fdt_setprop_cell(sms->fdt, nodename, "phandle",
+                        qemu_fdt_alloc_phandle(sms->fdt));
+
         g_free(nodename);
     }
 
+    /*
+     * Add vCPU topology description through fdt node cpu-map.
+     * See fdt_add_cpu_nodes() on hw/arm/virt.c for longer description.
+     */
+    qemu_fdt_add_subnode(sms->fdt, "/cpus/cpu-map");
+
+    for (cpu = sms->smp_cpus - 1; cpu >= 0; cpu--) {
+        char *cpu_path = g_strdup_printf("/cpus/cpu@%d", cpu);
+        char *map_path;
+
+        if (ms->smp.threads > 1) {
+            map_path = g_strdup_printf(
+                "/cpus/cpu-map/socket%d/cluster%d/core%d/thread%d",
+                cpu / (ms->smp.clusters * ms->smp.cores * ms->smp.threads),
+                (cpu / (ms->smp.cores * ms->smp.threads)) % ms->smp.clusters,
+                (cpu / ms->smp.threads) % ms->smp.cores,
+                cpu % ms->smp.threads);
+        } else {
+            map_path = g_strdup_printf(
+                "/cpus/cpu-map/socket%d/cluster%d/core%d",
+                cpu / (ms->smp.clusters * ms->smp.cores),
+                (cpu / ms->smp.cores) % ms->smp.clusters,
+                cpu % ms->smp.cores);
+        }
+        qemu_fdt_add_path(sms->fdt, map_path);
+        qemu_fdt_setprop_phandle(sms->fdt, map_path, "cpu", cpu_path);
+
+        g_free(map_path);
+        g_free(cpu_path);
+    }
+
     sbsa_fdt_add_gic_node(sms);
 }
 
-- 
2.34.1


