Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA453C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 11:29:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x25ak-0005v1-1l; Thu, 03 Sep 2026 07:26:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x25ai-0005sy-4P; Thu, 03 Sep 2026 07:26:48 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x25ag-0006k3-Eu; Thu, 03 Sep 2026 07:26:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dmfau5uNnqnuAt4LuV4YKdOQBSTx4D80im1h+Bk8mlwlow8f4SjHW+2QMjeKxE0fhIlH3UTkS5fIjxU7Rokv9tSNYqh2um7kptFOYfqhO+1vYKS2E/fPASTLF8FwsVan6Nad99i27emCA8S7au9o9+poTJrAHYclCgQ71p67eVT/zsokQVI1k8jhHHwnPgQcfKxNrC7QXNxivbC8dlIM2zepe4MLicLb8GcTETqP3QoOUNSaydYAWz1EfdNj0gODfbiT1s4DRM4lNlwJRPBO2byG1BkecEFfNd3wPRw+zkfVe9FRaj3pQfa1y7EP6zRXLk1SsXZwhGS5Jxy8v2Z96w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+BWRr8/BMEdFv9/nfkQdIJ+g+4900nM5vSHsTZvT4UU=;
 b=Rqwoy5SVja2o01nN8EVT2pUV8j/NsF0Lz/4wDZtSP2ZN+jWmhvGu1I6fGxoLFIzKbQK4PfZesqgSc4yqsJu2RNQGwOgdxWnrNPL5ICCADHooFOcnwGI6I7cpW1CaTO7A3bTnwFS+uPRQbRUO5I7Wju5kTjCPNeO979GWqlcNN2VDBff2WO80N50ZSgfu0KH/IJ53V0S6Et8M1e7+F/+GFCcxbifAAXLNp9/ay6z73Stw3xTghH0Toy3Pk5/bDohjzOgOSnwx3n1AV9QxAzDhxSoxafx88Gegm/s8c3b5p+6g2vyqWCX/N3A3wPmAfss/N5zxSe5Qxm8+WxqchILjlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+BWRr8/BMEdFv9/nfkQdIJ+g+4900nM5vSHsTZvT4UU=;
 b=pUPg63VdLiHdQhRf2eoPsLpLGPpafX4ypuXoGYf45FzfystKp3MpdP5pW9S+KA90mukvF7k0Uj4OYqVQS8TPElmK/f16N7CxAS9LHVyEcLD6Y+XIK+/Hw+5oSfsQ8RdfBbHPjebd54mDmml17ysNYqutKOVOH5dHh+fI/ei1Pjks7Y/G8AcRUqfWmKaYqevJiKYpVJaEvYbJrGNMN5TvLlhkLuRQMxeyyt0dlSc+SxKJObMavHfMu+19nb/HYDDNhpJQX3+nlwn/spjp3Zh6kQrDjemaoRwqz4Qt0OdG8/qbGTGmZ4P2TQ3aHiyPVzEOeJWs8JxIXjYPeo1WOjRwCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by OSNPR02MB8962.apcprd02.prod.outlook.com (2603:1096:604:45b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 11:26:37 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 11:26:37 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Subject: [PATCH 24/33] hw/arm: phytium: Support Phytium E2000 direct Linux boot
Date: Thu,  3 Sep 2026 19:25:04 +0800
Message-ID: <20260903112532.3276678-25-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903112532.3276678-1-bin.meng@processmission.com>
References: <20260903112532.3276678-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0026.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::11) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|OSNPR02MB8962:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cb23e8e-6625-44e2-93c5-08df09ae3784
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10067099003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: nxwdZO6JnJFDlTMkvBqYqgaKMrUFXaAmHb/inh/XZZvUw+UbX9x4tH0N6cinUWpuoqQ5bly+TzT2oTBO2lzUUUSo21//yp2aizT4JI5fDhx106esMJhpdJgc4+eNyJvb3RQWHSKl7XqzSUDN2pnHGaDtqThDiCpWMV6U8tQJ8VL9xjAQemqtwA4G11gEHIgFgubfK8Mt3Vj2qBK6v8LdTLSR3ZzdjJfxdPL+KSZsboZV2ZD5eNeTXIgTVa8MYYjn8OMyrFLwmYI3sW9W9KJjQ7eHryV/046gZrtcZRi8VBvWP7UXHXxYF7+PCcg+BRhyLNwRo5mx9vDgPATETUSZfKSAk06UsDP0kuRbe+g6rDgnUNuoCoyfX1VWumcaL63OQ2IjTfpomKzbvgIHwxn+7GCL4+D+RxH4HmEPhUsUuBjrrRN+bGXXbAZamOpkAHKFyOUI9dJN8WtR8IUnsiTz/lnTMRw4PfNMtESj73vaRf4YhdinrJKQETceKYPUHR3gz/SUkZ/kj5qWCQ3T3vEgEwDrLBVFwFNt1LD3Q7OoCSrjfuPGUqo/4UAXahRMoQ5tL3BVdnL7054MKPymQa7aR8G0yaJBgjrH55WKX8sJ0rcfRVKjGTnoPCN37boDKKc3vvKMhcRY+VG6dQrdWMeWHpondAOqrX84CtuxKW8/jqs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mdhlGT4DJB5J+wQOsd/Vlx63MeI9PFXKy6SlmtWJmcMxdwRLVeddIoKF7VN7?=
 =?us-ascii?Q?O3Ct6piQ1ztd6FC3j1RNqS1Sn34hAjDDym4GrjuZB6gmOJi025GKaV7DZ4/A?=
 =?us-ascii?Q?1uHvDdNPtMim8+25taAUKcOwq6enQHAwcNnqCPegRYji/JEL6AKpriTafNEu?=
 =?us-ascii?Q?XKvQ+TGG3J5gaUQHPDgOsl2AqPqEt0FvPTOoTtAWMTJVNfyw5khDJdHixApD?=
 =?us-ascii?Q?zKouK6KXRk2MhUICdE+ZCY8myOzf1N2ecFStLwr45tErMAxS+kH+7jIPF908?=
 =?us-ascii?Q?4vW/Z3+DVXzxiT+/e1rwnhUExeQ3Xj0gVFdUmxzeRJH1qyVdj1mftgCwVkWt?=
 =?us-ascii?Q?0RMCCG6/XCYJBudUivnGMJlc2yPWMs2TdLxruJPqKbmf5vvguWTuoatKs3Cr?=
 =?us-ascii?Q?0GszCwD/ZC+mqCwEuMt0Wb2t0nAhnb1jxDS5Gq8PTapzdyTlnDrXdjW7WmDb?=
 =?us-ascii?Q?d3xLVphQx69RVzKUaCF0A6i5QwL5k6EkgxxoIpO7iKRXbg0CxPmIbr0q99MA?=
 =?us-ascii?Q?bQXbOGnzFfO6UEJ9ekX1qw8FFuSacDD0qlOawwGVfygV1kC44vmZhECS+XNr?=
 =?us-ascii?Q?E+y9EPOxOwWkfecC4+LybU9Znf+XG0CGAf90iaBj+IflDZDJRnWrYbHBUADF?=
 =?us-ascii?Q?EZYu7jVyywm9WpoEBkzv8L/k4j3LHPvs/K9YRj/jpuU46itm6GMdfnfvR7Ox?=
 =?us-ascii?Q?Vz/TQslTPUo8b3qjPWC9lyEis1xj7ealAG78zt/ha8xyi2ipi9z6hGQUkupR?=
 =?us-ascii?Q?TYfxwTZ9pBBxNcu/q/CrOvdh7S2BURT4Il4ayt3bSn8Kt1YHoSkycVrclYw8?=
 =?us-ascii?Q?I8sAyZO1CGWFNFuiycdTvN56EoUm4+czf2M/mcJEnNO7z7nbKRFcWTMPKeoq?=
 =?us-ascii?Q?pFK2eCFKPMa6OxQNuEl4S75DyUmFcdXZ02i0fydQtXR1NXUNahDKxM6JmorH?=
 =?us-ascii?Q?gKkljdpK/illN3JloPdcPce0e4nvx83BLUqgYX8UicjcB3TfK4OVo067hN+V?=
 =?us-ascii?Q?y7ydJBlgGVAf5hMLKRcfMACMCKxbGCwwBoIGezPhfajrufBE2X5WhGMWiGfl?=
 =?us-ascii?Q?XwAf72hjCDX+jKOHRTv8Te3DSEFjGHzg59tqjwazVn54ofdctgDOeA21zNqx?=
 =?us-ascii?Q?k0WTse3+6Di6bbJbBu8pRCpDVrbI8uGX3lkoK+ut2sP1NwdS6VXHlm8phH8Z?=
 =?us-ascii?Q?aPBqS56dP4cmsA9BgQp9AShyVsj4T/O3v9foPARXRSm5hoye9/Zn3P9PJGZT?=
 =?us-ascii?Q?kANf72Ne0vOqlvesHf8PyXT9/w7fRVJtdUbhcnCSD8OmgBEfQ6dgcFsi+JBh?=
 =?us-ascii?Q?T+CRdPGm2WRnQME3wSV+7LiKNLPjk/TxcLQNgJFqUKRtOxFHAlaGSL+hye1Q?=
 =?us-ascii?Q?zCZ40C/zbMciPspUvsrKD4UwCJ2iMOmqAzTWYf+ndlyrrj3DtYPDjFOx44fX?=
 =?us-ascii?Q?hFLN51hujLgQ70thVb5zBmiFR1hwyHl/CWqMQXWVD8KTinB3uudp2gkVEck+?=
 =?us-ascii?Q?pmRN2V1AuonAUXOHkG1QMlkLLweVCJvzaar9Yh1B1KZGhV6W9g/hesQ1/yzd?=
 =?us-ascii?Q?XQvzdmQUUcow6Pl5S3mQS9VZtccQCTHzV6QrTemh8BB8hmXUjPTzOXTXWpYm?=
 =?us-ascii?Q?WQCOWI7qjwZOFiU8V5x7hWEB84UVjA+cUGYfvsINVtndgqkGEw9EfgfDs8vI?=
 =?us-ascii?Q?kv6bFcVSdcNoOZrMbEdolb0t/+reb2k5vG5FkQQ+PjCpAIWCv7lxP8PuFOuO?=
 =?us-ascii?Q?Loc1rx6Zk6P8Qs0njR1EkPJcXOUj/uE=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cb23e8e-6625-44e2-93c5-08df09ae3784
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 11:26:37.1778 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 528fhCKqQbEy0loizWXbCrq4cotpiirUCtTmY6B1oYX7NYP3oSx4mJ5K1pSV9GbFvwcIRkVcja+D+i96mxV6nFhjYXQDz8Y3qqbezuztptw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR02MB8962
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=bin.meng@processmission.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Allow the Phytium Pi machine to boot a Linux Image directly through
the generic Arm loader. Require the matching SDK phytiumpi_firefly.dtb
whenever -kernel is used.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/arm/phytium_e2000.c | 65 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/hw/arm/phytium_e2000.c b/hw/arm/phytium_e2000.c
index 5dd91f662b..5d1e528cc1 100644
--- a/hw/arm/phytium_e2000.c
+++ b/hw/arm/phytium_e2000.c
@@ -15,6 +15,7 @@
 #include "qapi/error.h"
 #include "exec/cpu-common.h"
 #include "system/address-spaces.h"
+#include "system/device_tree.h"
 #include "system/kvm.h"
 #include "system/system.h"
 #include "exec/hwaddr.h"
@@ -129,6 +130,7 @@ struct PhytiumE2000MachineClass {
     MachineClass parent_class;
 
     const char *machine_name;
+    const char *direct_boot_dtb;
     const char *pbr_boot_mode;
 };
 
@@ -771,6 +773,61 @@ static void phytium_e2000_create_ram(PhytiumE2000State *s)
         phytium_e2000_memmap[PHYTIUM_E2000_RAM_HIGH].base, &s->ram_high);
 }
 
+static void phytium_e2000_add_memory_node(void *fdt, hwaddr base,
+                                          uint64_t size)
+{
+    uint32_t acells;
+    uint32_t scells;
+    g_autofree char *name = g_strdup_printf("/memory@%" HWADDR_PRIx, base);
+
+    acells = qemu_fdt_getprop_cell(fdt, "/", "#address-cells",
+                                   NULL, &error_fatal);
+    scells = qemu_fdt_getprop_cell(fdt, "/", "#size-cells",
+                                   NULL, &error_fatal);
+
+    qemu_fdt_add_subnode(fdt, name);
+    qemu_fdt_setprop_string(fdt, name, "device_type", "memory");
+    qemu_fdt_setprop_sized_cells(fdt, name, "reg",
+                                 acells, base, scells, size);
+}
+
+static void phytium_e2000_modify_dtb(const struct arm_boot_info *info,
+                                     void *fdt)
+{
+    uint64_t low_size =
+        MIN(info->ram_size, phytium_e2000_memmap[PHYTIUM_E2000_RAM].size);
+    uint64_t high_size = info->ram_size - low_size;
+    g_auto(GStrv) memory_nodes = NULL;
+    Error *err = NULL;
+    int i;
+
+    if (!high_size) {
+        return;
+    }
+
+    /*
+     * arm_load_dtb() normally describes RAM as one range beginning at
+     * loader_start. E2000 RAM above 2 GiB is instead mapped at 0x2000000000,
+     * beyond the PCIe aperture. Replace the generic range so Linux never
+     * treats the intervening address-space hole as RAM.
+     */
+    memory_nodes = qemu_fdt_node_unit_path(fdt, "memory", &err);
+    if (err) {
+        error_report_err(err);
+        exit(1);
+    }
+    for (i = 0; memory_nodes[i]; i++) {
+        if (g_str_has_prefix(memory_nodes[i], "/memory")) {
+            qemu_fdt_nop_node(fdt, memory_nodes[i]);
+        }
+    }
+
+    phytium_e2000_add_memory_node(
+        fdt, phytium_e2000_memmap[PHYTIUM_E2000_RAM].base, low_size);
+    phytium_e2000_add_memory_node(
+        fdt, phytium_e2000_memmap[PHYTIUM_E2000_RAM_HIGH].base, high_size);
+}
+
 static void phytium_e2000_create_cpus(PhytiumE2000State *s,
                                       bool firmware_loaded)
 {
@@ -830,6 +887,12 @@ static void phytium_e2000_init(MachineState *ms)
         exit(1);
     }
 
+    if (ms->kernel_filename && !ms->dtb) {
+        error_report("%s: direct Linux boot requires the SDK %s via -dtb",
+                     pemc->machine_name, pemc->direct_boot_dtb);
+        exit(1);
+    }
+
     if (ms->smp.cpus > PHYTIUM_E2000_NUM_CPUS) {
         error_report("%s supports at most %d CPUs", pemc->machine_name,
                      PHYTIUM_E2000_NUM_CPUS);
@@ -880,6 +943,7 @@ static void phytium_e2000_init(MachineState *ms)
     s->bootinfo.loader_start = phytium_e2000_memmap[PHYTIUM_E2000_RAM].base;
     s->bootinfo.psci_conduit = QEMU_PSCI_CONDUIT_SMC;
     s->bootinfo.firmware_loaded = firmware_loaded;
+    s->bootinfo.modify_dtb = phytium_e2000_modify_dtb;
     arm_load_kernel(ARM_CPU(first_cpu), ms, &s->bootinfo);
 }
 
@@ -945,6 +1009,7 @@ static void phytium_pi_class_init(ObjectClass *oc, const void *data)
     mc->desc = "Phytium Pi board (Phytium E2000Q)";
     mc->block_default_type = IF_SD;
     pemc->machine_name = "phytium-pi";
+    pemc->direct_boot_dtb = "phytiumpi_firefly.dtb";
     pemc->pbr_boot_mode = PHYTIUM_E2000_PBR_BOOT_MODE_SD0;
 }
 
-- 
2.53.0


