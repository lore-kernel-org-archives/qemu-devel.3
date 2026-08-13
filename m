Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00396C5CFCF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 15:52:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuXhd-0008J3-Ki; Thu, 13 Aug 2026 11:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wuXhc-0008Ip-3j; Thu, 13 Aug 2026 11:50:44 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wuXha-0001rl-HG; Thu, 13 Aug 2026 11:50:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U4XY88uNJNh8AESENKSxR0kovT4GDeZJ0O5uabZp6UVfT58NaMUWN+0+cJBAuW8DW70Q+7JX7pqQrsn3C+KRap1g0LlVn4Jm2xzL/JPvkYulwTVXfArrXn+toh7BdLZ/Sp2M6tNVsCkxsylKuXN4XDisefjIRG0rLquOpwKjYBpVcFOen0mTJec6pZANKQtS94S4U1oCF+3dK3z/cPN8D/MXiIRpojUol02ECqeDqarbdlXbAPMSizQPAhHi31BnmROUdt5XbqJ7c1+rYynxwF2C98Soie+6PfH7czeVmT+1c7Ys4WUy2SgPFWTtnlnjJPuvM/JE6UR632ZsTL3QBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/aaOpDiRsntS0GvAL9E0vjd87BK6XN42uDQnweXkCk=;
 b=qeOgJr5ZS4VAYzqO2v/GGPrJmGI5YXy47dv14XpoyUZ8OnG4UOtVmykXB5lFJG248/AJkyFYKQqgleZe0muzdn1bppVNu2eayR7VSZkzH9VsRN14Uhv3hJ7ihng5L8RpR3AuCx/Lo7xqFj/VxKLTMyc3khtKZQh8PkCxyhp0kWDOHipBT5u7MIuCs6UjvDuSYFfMWkVQJWrdYysSwsDr0vuGA+AY485J0QZAKPEH7pu+lQmJF2EMte9sDX7YRGzVhOaK3KTTBkNggSWNZAOaVFqEonJl1TApJJOmSIT4O9tgHGuljIUHWkOS08e0gUcvlU5Gy9Y2kfx8sFUnMiyOaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/aaOpDiRsntS0GvAL9E0vjd87BK6XN42uDQnweXkCk=;
 b=U8NC6ciDqLHn+j6w3nB54EcdBXdSXgOltghBS9/0sqHQVSCm6AaeVgBJbkY6CwVhRyZwNUC8YUAjs0VWOSWd71JXrUMGhI7dZ7FJeGnGdtOA/C5hjxdjTJW1DcB2LqjeCLnvNchWp2MLF/hZAQ8n513eXZQMaNBWaNPFPQSYtwjZabSL69nWpYx82Cvp8YDbmGe/mm+bnehHTQyHuy2dEO+BFozdmBvMQ3iMwYngpyg9DyrKDSh3p4vV0g0unNBzeetn/Rk/2OYB9vnsLp7NJqwclBRzsDwrF8ErQjslgl8SET2+RYJm6vJd5XZnnqvdOIfKdc556saKRROus8Ldlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by SI2PR02MB5490.apcprd02.prod.outlook.com (2603:1096:4:1a1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Thu, 13 Aug
 2026 15:50:34 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 15:50:34 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Subject: [PATCH 09/20] hw/arm: integratorcp: Store boot info in the machine
 state
Date: Thu, 13 Aug 2026 23:48:57 +0800
Message-ID: <20260813154918.996812-10-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813154918.996812-1-bin.meng@processmission.com>
References: <20260813154918.996812-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DU6P191CA0001.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::11) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|SI2PR02MB5490:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bc5d363-5f9a-4b22-8b9c-08def9529c94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: e349CF5Y28pE2HB8fYk9XF1Q7gJqzr9oARX6JPEgz5YnU+Bvk9WvESB6pNISYd2ZVm4dHB+2WCVr8tgyTiJSZpIbXT7/Yci0MhswMj80MX5THogqsdXwOsjaiJnOuVxeQJU/1cO8VXazqaRfCaNuU/DlUBqookUpk7jGeBWp/VuzEmrl5ef6t5d+Hv2kdZObzLbDzh9afn4Xr8VYap77qaw4akgWNPDtvWeel6kflbD209mIEdkHtKU8FOVnrowJNooGvHUe7lzG+gcVc4lNs405CNIlFpKvc8P/F0ft/L1Zv50H7p6g7vgfGmgWhKzY0AdB8BMk2sqsP/+1ckarLnESpx4YjanA8QYElssCf/HZup8VL4d6JtWRguVlBKDfZwtnk3XJlmo00K1Gk+EY+0Qx/uF/fLezwATHS0GF3MxUGfYD64cPFjoT3cwQZwCV1RAOq5gt+lLGYO8ur6Re37/a/SNp7ppfYaXSm+l3QbryEjhb6sj5CjSSSB02k4fNwtM2S3dKHMYTIPhzXXsTU5AY3LISwG28FgaSY9vTuP8PHOqGvfjYT9xcpbL9X+eoIugYaJlI9OYHcEbuNQ51jdCddzQupZ4ff7eXHspBoF6UQeClN99xkTCPr57QIIJKZqhBdUqwvahl8L3ff4vthJcDGJrgSYAAPWICTwLoFIc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E8dXlJBNiKoyulPdf0Nyy+yie1VCh93A0i6r59lbmzN/hThI3PugaiKm7fzE?=
 =?us-ascii?Q?edrRHI8aQyzMEG+WrJEXupvLZVyLD2fxSKAkasTFVY3rpdRFi5lr9HwUpnpG?=
 =?us-ascii?Q?NyALemwtt4R8Wyo8jBw7m8q4nQoGWDk9agh3wE1h/IfC5EvlQkGegLEteUMh?=
 =?us-ascii?Q?blN+q9MlPQOgOjl724XaL04gX4hhqTg7/jGZGg+KHE5I4271FiWuWlOy583Z?=
 =?us-ascii?Q?0BRzAnVqRmyE/AofF4LQdu9TB/evxKyxfLCt5XbnLa2UEHzS4h3MfmM6Pcc2?=
 =?us-ascii?Q?LQ55Zaxkkh2OP8063+hYvEEkEu47SnLLQKmVXCKGFGpQZE8sKNgbbF+bM2wd?=
 =?us-ascii?Q?krzypjnKBRY4Bxi5Xg7kJBDvXS/GC+HBen2QX6TsS+0bV6D0yOYnvQRSrXS5?=
 =?us-ascii?Q?C93hdgwD4d/9OtRWO9yanv1JHhA8q52+WRCAx8Y8UkDDRc94L4YLr6C2nYbc?=
 =?us-ascii?Q?48ceQCUngfYrxRfM8L3f8/FgC9wa0Wj6KPKnS5VhoL8dfCD/kqv4697ObZyq?=
 =?us-ascii?Q?aeppHbYeTVzLxhF7DqEh/Dk+pwChBOCvwgrQnWnSxSzQ1+XuLewGAhUtCgmu?=
 =?us-ascii?Q?VA7h9N7bcOQgko/MPRsoC+iVFgwG8R2H9AF2ZvrR+IBxAu8SjHvuRwT8DZk2?=
 =?us-ascii?Q?hmrXDGAK5yrtjOG4h8dvdPBMbphlkJFbXb/as3klOggMFKjtEeTZakVSCpF4?=
 =?us-ascii?Q?ES1iqhERlfA3dbtfrVgFm4dD7Xqr/kNdFen4Ccz7OiamHx3uoNmib4PRfiiM?=
 =?us-ascii?Q?O5DkmRI0ImMTXZ99egAjszGLVXJT/G9kJfsILuqXjsNPDB50e9cqr8I09uZ4?=
 =?us-ascii?Q?Fl/Hb6rb0T+U41zL2eXNqR2bMbKDhJ4pbt0WVX4rFB+CNtkUBJJdxrA28PQR?=
 =?us-ascii?Q?c7nEAMa6ChcOfKyR8f1yDCEkUn3VeZjJF+2gQjV54ICX/czzdd+noEt6BP+N?=
 =?us-ascii?Q?dcuJp9CL3kU/3Job/HzAnpP3hUQA79Iibhx7LzydcjTdKJp2OpXNi6j2V8Oz?=
 =?us-ascii?Q?n6lQ1CbzzC7R5D9x8+HXjR0Sw5LdaXKHb1bYuwGQvFb1hwIsqXSAYs5xF5b3?=
 =?us-ascii?Q?9cI3TDGBKOFVW41+F+sRRA7njHScMvTx0LMZBBd9+DZtsm0Pr1Y5NsAvbw4e?=
 =?us-ascii?Q?JLWc34uFCzhm5KBnLWwPHRyS+LyIZ3hltQFAt8o2s9qHuwgpl4Km6yIO78iX?=
 =?us-ascii?Q?foZINuMxtFQLmo/Dahggic1vFvmCTS+/1/i/Vcux/GvZMZDbOH4ThzL4eEdS?=
 =?us-ascii?Q?r9OjcD0t+q9e2cy0OyII23wbsRmdS9VBTqE88UN2qD9hVwfpUMzi4EkLwlb0?=
 =?us-ascii?Q?AKE8ytn8FKzxeOKIEfY8ueX7y7PJ92WZh7TETxp3YQuAreuR6SUD2/qv/vn9?=
 =?us-ascii?Q?rU8gbBcpgR7Z/BTbrRiGtaloVhmPe2jlEd7mut7lyPIxkTqFAXvIWjB4zRj1?=
 =?us-ascii?Q?LjyUydYbiv0CmynUcyikZv3tET/k++8KUfa9QwDVNAHzvtrAE6EGF21hFNRf?=
 =?us-ascii?Q?Y2oSdTJ77NMtR90G/11kBV4ezwQ4h/i7yT/l+bEgQK4hZTnUTICe7OJ4YcJ5?=
 =?us-ascii?Q?OnlL/JtyaYjy8OjHQw5OVFz+sM2VSyA2BF0jdbvAVboYm+Ue9B3JbpDgoQQ5?=
 =?us-ascii?Q?yWwWz0J1OB2GnTqDEnO9l5lQHdsiCieJnSVNDtvLAnTosKoLP5tq/GwVvhFP?=
 =?us-ascii?Q?aowMzTYFkWmgyNncnx0x5uuw/d7rSI5XKAnAXA1IaW2icUL8+N5mIUIZb1qu?=
 =?us-ascii?Q?t+BQao56H0e3tLUKEDG/+i/J51fSqo4=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc5d363-5f9a-4b22-8b9c-08def9529c94
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 15:50:34.3865 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4+i8H4zuGo12CaN0+1hinuxAsPrXwPZrw/9VC7vaZTK9qzPAH9aKCJipFAbLra0i764WXjhRazj43r+p36b4mA4FmWZD0NNP1W1vYgze2qA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR02MB5490
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=bin.meng@processmission.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

arm_load_kernel() keeps a pointer to the boot info struct for the
lifetime of the VM, so the struct logically belongs to the machine
rather than to a file scoped static object.

Move it into a new IntegratorcpMachineState and register the machine
type explicitly instead of through the DEFINE_MACHINE_ARM macro.

As in the xlnx-zcu102 and raspi machines, the boot info belongs to
the machine rather than to a static object:

4d1ac883a7 ("hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102")
0f15c6e338 ("hw/arm/raspi: Move arm_boot_info structure to RaspiMachineState")

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/arm/integratorcp.c | 40 +++++++++++++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 7 deletions(-)

diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index c25bbf3c82..5097a95b87 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -581,13 +581,19 @@ static void icp_control_init(Object *obj)
 
 /* Board init.  */
 
-static struct arm_boot_info integrator_binfo = {
-    .loader_start = 0x0,
-    .board_id = 0x113,
+#define TYPE_INTEGRATORCP_MACHINE MACHINE_TYPE_NAME("integratorcp")
+OBJECT_DECLARE_SIMPLE_TYPE(IntegratorcpMachineState,
+                           INTEGRATORCP_MACHINE)
+
+struct IntegratorcpMachineState {
+    MachineState parent;
+
+    struct arm_boot_info bootinfo;
 };
 
 static void integratorcp_init(MachineState *machine)
 {
+    IntegratorcpMachineState *icms = INTEGRATORCP_MACHINE(machine);
     ram_addr_t ram_size = machine->ram_size;
     Object *cpuobj;
     ARMCPU *cpu;
@@ -680,12 +686,19 @@ static void integratorcp_init(MachineState *machine)
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0xc0000000);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[22]);
 
-    integrator_binfo.ram_size = ram_size;
-    arm_load_kernel(cpu, machine, &integrator_binfo);
+    icms->bootinfo = (struct arm_boot_info) {
+        .loader_start = 0x0,
+        .board_id = 0x113,
+        .ram_size = ram_size,
+    };
+    arm_load_kernel(cpu, machine, &icms->bootinfo);
 }
 
-static void integratorcp_machine_init(MachineClass *mc)
+static void integratorcp_machine_class_init(ObjectClass *oc,
+                                             const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "ARM Integrator/CP (ARM926EJ-S)";
     mc->init = integratorcp_init;
     mc->ignore_memory_transaction_failures = true;
@@ -696,7 +709,20 @@ static void integratorcp_machine_init(MachineClass *mc)
     machine_add_audiodev_property(mc);
 }
 
-DEFINE_MACHINE_ARM("integratorcp", integratorcp_machine_init)
+static const TypeInfo integratorcp_machine_typeinfo = {
+    .name = TYPE_INTEGRATORCP_MACHINE,
+    .parent = TYPE_MACHINE,
+    .class_init = integratorcp_machine_class_init,
+    .instance_size = sizeof(IntegratorcpMachineState),
+    .interfaces = arm_machine_interfaces,
+};
+
+static void integratorcp_machine_register_types(void)
+{
+    type_register_static(&integratorcp_machine_typeinfo);
+}
+
+type_init(integratorcp_machine_register_types)
 
 static const Property core_properties[] = {
     DEFINE_PROP_UINT32("memsz", IntegratorCMState, memsz, 0),
-- 
2.53.0


