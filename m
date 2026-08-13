Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37880C5CFCF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 15:54:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuXhi-0008Ky-D2; Thu, 13 Aug 2026 11:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wuXhh-0008Kj-9k; Thu, 13 Aug 2026 11:50:49 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wuXhf-0001rl-Kb; Thu, 13 Aug 2026 11:50:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pnmfBdgam1mdNBp07ulrPLqfO1/7g9ZVsPt0U44qoEw87a9LUZ4gsGON4kl0bFzGPVCA6Rb2t8EmvkHjuZdAwIdyLq8G9UjpOdZuUiy7vaMSxrweSNbAtUVq3csPKkDmUu2+rPO3QvdEwvwv1FsR+SWh6hh2H2zWGbIaqgwk5Nn27thdSI46bttFiXRORwMt7sFVdm3+ZIPjWGVaRy3luPE8sVPvjw8jPV//4A7qno2pRVqzxQXiVpzu7y1ks3bO0YvgO92nE06R8pHOV21eUeIdVmVuCLbJcjrtfgDwoWmTGBt25b50FfXc18UdmD26zHyvtyzYImLB/0uWye8mnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9AnkeOF3L6Rg6CVhDaC21I1ZEqPFtabg7M83rK5r9E=;
 b=XPgaPACGXSj+RM67I7XPdP0jjxB/W10beZhk80CNJyqzhiFuwWs7Hul8aqv8RvFwIiQqXSgr/55dJajHhNHcsLSV0vt6iYjhO9UZw9KmTISZFcjWTG/D6clJAmVjnmh4fynsox4gtrOW2Ff1dHAp42EMhr8w0CRcLRtxXm1TllnetDox9Hhkwj0ClHbrjKOezC6zY1oZRhS2zrySoak9zx8fu2Mxu+gvA4A324xoHZThA2srtvPVV9C8PwUpuz0HtSLR7mBUsnE8RpEIGiRocQ+arW+/U/f/SgwARg/I8abutDWcSzJQvGquwlzi1j2VueBbnIJhM0fmevcrxFvrYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9AnkeOF3L6Rg6CVhDaC21I1ZEqPFtabg7M83rK5r9E=;
 b=KjrDp20d1awSl2kO79hb138jEkDw/SlmL6itHCQrr79ox3NTbUKwYF+YJKafWDwtmkdSrLlfw4wbNIfzF37KlZCw1+VJGkpLZU4EwWPteyqL6sx5r7l65vFlOg5hFrILfgQCAf42mXK1VL+pb/TTn61MmtTTs9nedMsbL7xlzcbTv9QD8WsOkjRu9x7Y/NSDer6Uj5WEQPfoP+zIkazrWTg0f5CPq9sEe/pEZd++gn+s9XpuytlctNN/x79MaxunlryNL9T9YC14qK/ToWZPQRhABmi3fYY32PyMoF+M63bKG9mp5xifPAkH6uScfdGEQzKUrU/z5nPVqoDNONWC8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by SI2PR02MB5490.apcprd02.prod.outlook.com (2603:1096:4:1a1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Thu, 13 Aug
 2026 15:50:41 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 15:50:41 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Subject: [PATCH 11/20] hw/arm: mcimx7d-sabre: Store boot info in the machine
 state
Date: Thu, 13 Aug 2026 23:48:59 +0800
Message-ID: <20260813154918.996812-12-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: 06462bee-da60-4b59-8a3d-08def952a0d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: o41CFFt0OpbUuf9qv+eH5FpgOzMb76mltCc7eNP5AsKxjqFK0rHGNGZN1tDx2GieRNotJN4ImOav9QApGblNDWWjJ6C9DDw7BaWADvhbtHnesyoAyk7iP80ujHbeUD8ICUEpVGqjG8u56JoVxHKWPylEn2ZEk9xnOw8FuhUNwVs3h3ddie0Oz641x0DAToLhlf/PNQYSobq+Ismr5/4KUyZX44fxHAAsVYEij3ghO20otWYMmopeAAKQbp3a62O7UZ1urKhMdc7ixdbaqRCrct0IJb3uxnUfPWOkufqHMYkjuHSUw75tmKYq7yvL3fQGqv+dUQq7lmGZDYQDXbvVzSlMFXSn1VNeYDSboQpkqVn1yAf/sN0ZmawdR6ZtqGi/6OhhOgemrUNwKTTBas62vXb8QRBfT1+V8+SteQOlF4yzUsOOIkQV3t+8TToVezF5FwI7MFQLMzz440SXggHeeEyqNex19kIR5VKWJ2ggRnMfnVi9LcD18Dn7smd67e5ZAqCom+k9cRWndL5J+CazFgcEDWLelaa1jnwiUTWwtFtGVQeubN9sggTqPjSWOpMnGxDZlPeV1Vk1L1AHAuwUFdVNB6D8aJCtT5gnfOYnw0BiNcYv+eOCfBBNgvIdbrg/i18qyx6ejGlYp8CMMBFMpd9zupHXQrvo57Uw36CGlO0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hdvz3aDBqjR8qP6VTrxVr67bej1aQh+mKS9bR89jkOkmAReYx/JlrK/w/3aC?=
 =?us-ascii?Q?Wm8/yRLgg7NTeBvi8qKx12o9tn3j0gMeeNRHfUiXLaQWdmxYigBjWMXa9MPy?=
 =?us-ascii?Q?f5Q9RsocBJOtw8/klQMcrdsa2ohSQGedvMB1MHCVSkX86LgK8hI1V42g+gPy?=
 =?us-ascii?Q?Yx49F50pdKKIVWRkbdAsecE/c89A8YDQRKubeTJpb+gu5zqvLka4iUqTS7ZH?=
 =?us-ascii?Q?V8Nn0ynGd7yKwk4rJxz+0MyPuL5oQA+XgU/iVxbN5UyAq1r0fzT+g90oylTh?=
 =?us-ascii?Q?Lt7u6HME0UJ96GdOnePjykNG30Vp+0C8Ub0ovfUUlhy2yTwZ8YxC8lga4nSc?=
 =?us-ascii?Q?zsxQn4uoMIosTVRuSKXZyczd2sgq4cE5NrezP91DlVVSW/gTtObr0c++5gc5?=
 =?us-ascii?Q?EUTuM7tM7z+Mzws9iEde+HetnJZzQ1wpf4JNwbXYePmu/ZRptAxBfg4WtluL?=
 =?us-ascii?Q?e48fiazl3Vgv3qu2GLl83+GpBGz3WJKDZ1NF1+5eHabiQ0f1ydzX9cITez/2?=
 =?us-ascii?Q?qRxclmyB5+2DuOx59FZufd50PpgC3XP7aoDKwEL7nBLnHRpcsBKJHuydqLdC?=
 =?us-ascii?Q?pRX5ZrlaBGcYSMXo2h5haIzh/Yds/GMuxvRWdY8Xh31Dqkmo90h1vqW2BvYr?=
 =?us-ascii?Q?pTFiZf0kXGW4WoPA8YqOXCMoB5hJyWd4mSvAi/H3ArY45cZQqHlnn7abkoF6?=
 =?us-ascii?Q?+OT5Uv4VEPVktZ22w1LWtsvHgovUIy/YzXdtOe0qV2bGpDJWCoCZ3bHuC4fH?=
 =?us-ascii?Q?UdTnKlWhcbz06opjgmVqyROM7+fnSN+mtuJzhA2G9UdHlkD3wLtJHtldw9LT?=
 =?us-ascii?Q?bQQkdSON525jWJzKv2idwkPhQdxDMU4Gf6WLdflnE37r5c5BediC6D5KOoGS?=
 =?us-ascii?Q?LNOT3INQKvsbLaYrFtcoywMH0reBNTPMyPo/xd1CZM03oOZOOzMkRRpBADrF?=
 =?us-ascii?Q?AwxTyYQ+tJSEWiaT6A6AF2mIFZKZr3vTZT3y5daP3/m8i+7b6ZtCjAg0dD4q?=
 =?us-ascii?Q?d+gIY1uICyMaLbF6UlCUm79/JgQSac+gRuWSycPwzPXuNr3TJXDzTvFFEXkQ?=
 =?us-ascii?Q?0F+atVA4IDWeQwiLCpENRs89xUkWajP75KZTj3B5oF1qU5mSIoymBtDlFVpz?=
 =?us-ascii?Q?ryE3zu2JYgfwaP5IswLJ0nY6IY8An6Tv3uFRj0skUdWgFi0ESMwrjGOO+EvD?=
 =?us-ascii?Q?dDFFxcd+LwNlJqzVmWyIBxspAFWVqpv2Sfm+NlLUYQc+3rNH22F9IodeBwl+?=
 =?us-ascii?Q?ehmDxOFXzjtAXFsROczYDEf4w7fd0TWQHLrl1mTvgACnpUy/u1SVh86/MspS?=
 =?us-ascii?Q?QB6ZxlciDRhhMAUxR+Y8XovAVlz7oGzZhL0YQNrkVWfYZtscN1wHNU518D3r?=
 =?us-ascii?Q?Z9sD1xvWn6+bEAE0C+yzmv+NvOZq1pSql+aklPA890CtWcW/COM8nvRNQ2an?=
 =?us-ascii?Q?WJjnFtxRxTk6/3z2ccYrjViUDhSQMAK4FWzzD5Kf5kcOemVM1tPfgEZ0SXSA?=
 =?us-ascii?Q?Y4rZijVybz8ZmhcKsc7CEJkPKYMAR9uB0e0LClsVPRBrikxiFgQqZqp4hiGL?=
 =?us-ascii?Q?fgX4lXxODqLsXtA6sziKDi3UbHNHnIAtXZO9oBZkEaUMQBF4Qs/2OjDQfLIP?=
 =?us-ascii?Q?JIL60SxipqTQDYHN19YZfJAfI+5Ah3xb1sRW6W7jdBGyDy/48/y/WDAtN/Py?=
 =?us-ascii?Q?sH121zQhIzG7bicGVEG3HIvuB3GkhfnrKU1/KHVT+bJ9YLjuiOUZ79HwwmKs?=
 =?us-ascii?Q?7J9iC1hqZCEgXiBMOaDOOrtR/1+bF3c=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06462bee-da60-4b59-8a3d-08def952a0d4
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 15:50:41.5130 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2+72z/tQwbu7xqnjDWVowuraqf00ezjx6BDRNfMxh2S/nNJ67Z5kV6m6XDNNg2NwJUMyyTmPH3KAJfJ5KHDuBORi+xqYFZ3sDdsPs4krru4=
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
rather than to a function scoped static object.

Move it into a new Mcimx7dSabreMachineState and register the machine
type explicitly instead of through the DEFINE_MACHINE_ARM macro.

As in the xlnx-zcu102 and raspi machines, the boot info belongs to
the machine rather than to a static object:

4d1ac883a7 ("hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102")
0f15c6e338 ("hw/arm/raspi: Move arm_boot_info structure to RaspiMachineState")

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/arm/mcimx7d-sabre.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
index a0ac647c3d..43d7916b08 100644
--- a/hw/arm/mcimx7d-sabre.c
+++ b/hw/arm/mcimx7d-sabre.c
@@ -22,9 +22,19 @@
 #include "qemu/error-report.h"
 #include "system/qtest.h"
 
+#define TYPE_MCIMX7D_SABRE_MACHINE MACHINE_TYPE_NAME("mcimx7d-sabre")
+OBJECT_DECLARE_SIMPLE_TYPE(Mcimx7dSabreMachineState,
+                           MCIMX7D_SABRE_MACHINE)
+
+struct Mcimx7dSabreMachineState {
+    MachineState parent;
+
+    struct arm_boot_info bootinfo;
+};
+
 static void mcimx7d_sabre_init(MachineState *machine)
 {
-    static struct arm_boot_info boot_info;
+    Mcimx7dSabreMachineState *msms = MCIMX7D_SABRE_MACHINE(machine);
     FslIMX7State *s;
     int i;
 
@@ -34,7 +44,7 @@ static void mcimx7d_sabre_init(MachineState *machine)
         exit(1);
     }
 
-    boot_info = (struct arm_boot_info) {
+    msms->bootinfo = (struct arm_boot_info) {
         .loader_start = FSL_IMX7_MMDC_ADDR,
         .board_id = -1,
         .ram_size = machine->ram_size,
@@ -65,12 +75,15 @@ static void mcimx7d_sabre_init(MachineState *machine)
     }
 
     if (!qtest_enabled()) {
-        arm_load_kernel(&s->cpu[0], machine, &boot_info);
+        arm_load_kernel(&s->cpu[0], machine, &msms->bootinfo);
     }
 }
 
-static void mcimx7d_sabre_machine_init(MachineClass *mc)
+static void mcimx7d_sabre_machine_class_init(ObjectClass *oc,
+                                             const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "Freescale i.MX7 DUAL SABRE (Cortex-A7)";
     mc->init = mcimx7d_sabre_init;
     mc->max_cpus = FSL_IMX7_NUM_CPUS;
@@ -78,4 +91,17 @@ static void mcimx7d_sabre_machine_init(MachineClass *mc)
     mc->auto_create_sdcard = true;
 }
 
-DEFINE_MACHINE_ARM("mcimx7d-sabre", mcimx7d_sabre_machine_init)
+static const TypeInfo mcimx7d_sabre_machine_typeinfo = {
+    .name = TYPE_MCIMX7D_SABRE_MACHINE,
+    .parent = TYPE_MACHINE,
+    .class_init = mcimx7d_sabre_machine_class_init,
+    .instance_size = sizeof(Mcimx7dSabreMachineState),
+    .interfaces = arm_machine_interfaces,
+};
+
+static void mcimx7d_sabre_machine_register_types(void)
+{
+    type_register_static(&mcimx7d_sabre_machine_typeinfo);
+}
+
+type_init(mcimx7d_sabre_machine_register_types)
-- 
2.53.0


