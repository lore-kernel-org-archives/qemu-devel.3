Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FEB3C5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 13:16:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvaiC-0001ft-Rq; Sun, 16 Aug 2026 09:15:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wvai8-0001d3-PB; Sun, 16 Aug 2026 09:15:36 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wvai7-0005TH-32; Sun, 16 Aug 2026 09:15:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mV1bBjQcFdWvCbahAzfZOBc+p3DukXddI+XOx0s4ja+NIhcNlD+214IvY7d6uFD+JKGCDVlAP8JE7YDbz9owxjmeDIOiGY7g+zb8FQSqZA5STpjDYSZxcsvvNH0ikpdnoqicAWDyNTHd50SOsBjbPSW4dIQt0Fc5+Z1IkYJ5OQcERVErA1y23v40dOjX42UT0yDhIMs/m/Xk4NPg0fW8FD4bV4ppCJ/GCAhccqrr+vhizj9KidMooWrHn69NpN8CzWHRp4z6UiG6Ukx0+396X3ZBf1BHnSGVxEwOB39sCI7x/fubzl9vhVyCvCpFZFQ2qqrL01Tms1Dw+o2b45EKxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oTP3QW1qCoAMzAjzeP8saVbM0tCpjDte81vQlN5O7uw=;
 b=YZLUqQAnK9bD5U7GIcAxllYhWw9ThET4s8F6wVv4FxtrJhFASlLrG2Ohu+uw6iJBMWgNNuwE4f+qnat528pzhWQsZN8WZHCgsgPVFOnjTxRW+1h8aqEbLpd9RN9SuyNfES3zjqJtZDJlhP7/GAPxDiQpGklPX/xOph0oczWHlwkv8TvlQE81A32NMhpXYkmlLlZ2ydp7RudL/vygA1RMl1fjUkueWmJShPFQkY4zQ+iXXXXXHuh+cHva877caYCpmToZXFrxSoPRY48w+OA4mf2LfULw9t0W7sAjQfNSUHab8BpyE3Trnmui9ecCR8O53O5V0v1A5LL/51FUwS6ofQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTP3QW1qCoAMzAjzeP8saVbM0tCpjDte81vQlN5O7uw=;
 b=FOYhEWucOHEQ7ETvf0MXNtPqEudiMjravAA7298+EsC55hvu609xbX6XuiUFub+tXXZiW6vwvxknIs+jynNKqvxTBRwvcMbzttIZULW+q3MWqiQ+t2l5qR5w3TCfalzO+V569q+Zi67e1Ov2QFVT2tb00F1uShmg8TO0QRMpfF7HCXKhv+flVeOg333RQQd11d0KcwAtMPNYsqCP7SEGo+6deMkDyPX5ZgwEMDpk13hZgMMCWlU9c96UcAKELr5RtZLC1KgzeXbXpnfu44XmDAUhfDioU7nR4VoDWYvBWXIWVxbrxmSI++CsXD4WMh01l3hpCwdNY3LZtZMqi/K/cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by KUXPR02MB9310.apcprd02.prod.outlook.com (2603:1096:d10:9f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 13:15:27 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 13:15:27 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Subject: [PATCH v2 11/20] hw/arm: mcimx7d-sabre: Store boot info in the
 machine state
Date: Sun, 16 Aug 2026 21:12:41 +0800
Message-ID: <20260816131300.51799-12-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816131300.51799-1-bin.meng@processmission.com>
References: <20260816131300.51799-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6P301CA0004.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3be::8) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|KUXPR02MB9310:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dcd6e7a-1ad4-4d28-80f4-08defb98708b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 5aBQXAXToYc3wIn2hXXBEkAe9h2JleKWQ9YC2xp71rGRFKpj1osit5QXKYCYNYPIT0Cvur5JplKu+DePN0Aw3Hw4eCpucRBzHIe28Ss1QZYqqmcEaENm7jfJk/uLpBXUn66D/a47MRUO/EdqzA3AyWQtWzLrgrhfwsh3GGBDoA59TOQHdcVUF9jCBqGr27Rl8j8F69kqfGsz0cg6u8JUOu9MqaoTZ1ADku8V/oQiFL5vrtHvjcLDio/tupct51PxiybootpIyvkRKiu1zXAhAvKlNKYh7gZlExBpCWyeLovwPdRehJ9QbQ8kyKVveC60pQwA5AGHXLCLZYYjGfqgeFcuQtNwxwyNuxaPbNRB2hnasQy9WDNxQupontt4vZ3JEh+CnBR2HDLQAM409UcNRSL2FjBVUGJLLLyO5sWni9g6l6N+dvm1Tp6xxv4p/NpV/wW5gliJHpUgXk18itaneMLT0YpkVI1RLZwqNw9ty3zYzq+vGRrge8ZRb8XTkdMiXl6/FJVaf2F06nhIq4Ib0gnJgVcOCN+WGFMqiwXX1wqi4yYSrMV15FwtiMSsR8lC+JCHR4dGgfBBnhzghM0PtoS8sDqu059rZS/qxLLFvUp3cqFbGAg4lE7prsnul4GKuI2r7DKlZ5aH70ldPRmI5jdLgEq18UHL0SNdgNm9bWk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tRLwmSGeoef+NBEAFIGWN8BzTg1GVF0A/ClDFqUGTfwimaxdwpxVzcJ09fEM?=
 =?us-ascii?Q?fpmmGn5WY7vOlc4jMyO6/ALYpqbNcRw0ilWchaTyi7onh74xwTvhsnOzJgQF?=
 =?us-ascii?Q?BOTmEo7941yxUPiOfiXfXpJNBCnB1jCXfWGpNhdjYmaAXyK6x5OWpagQ6ytP?=
 =?us-ascii?Q?jTF8G2erF7AoYytm+T6cFbJxTcnAf7sDIBx0yPr6nKaeQflnrJxKaZYyFr/L?=
 =?us-ascii?Q?iF0tsLbl6MvwSb4Ns/kaPx9Z7W3I6O8rbg5t3+AWKMxec/JpmCHX10rvrngO?=
 =?us-ascii?Q?ycTJiZVPROFAvIJClznQPwmneXOXj3ICzU28mx0v7XYZS9axFtus/hWyb1sH?=
 =?us-ascii?Q?1Vzt6mP4LJUZG/AU+GCHYwgVpT/CdFS9BIi/ZSanHcwCk3lz0V9lIAjtrTI6?=
 =?us-ascii?Q?haEtIRWx4EqloXuXqvRmAncXUfyr32NGx90xVgtXrb58oFssjjcYGYx7fXgk?=
 =?us-ascii?Q?jhDmBD6sjiO4CRqs5vovV9suCTx3lwL7A2UOVnvJ5xLn7T2Wfv1DVBGjVOLL?=
 =?us-ascii?Q?Hv7jsiqu+r/Cst2AvSNoynWFSG4nP/Nz3FJzl/Gq2jWgMiLMSvDruRVPS14T?=
 =?us-ascii?Q?rey44Y2VfaVi31ToJTPk7Y2kVQWgmAarzSV4GpmfaFABGiUXZG1q1wjB2kwM?=
 =?us-ascii?Q?NL0Z0Db9iKUCImPf7YfxaFOUwesAQ7CizIMDs+IpmfNEFKutEtDEJtSIkm3W?=
 =?us-ascii?Q?fJTw6d4VjdrXUhcXIQEeWVUNxWHxK5XFJzetO9wV2PunHJnuQXrMDMMUl8kD?=
 =?us-ascii?Q?KJX/e86EGCfbWpTyEypcmn2u86iAYUl+OOeVw9RG7uhiYFsqt5Ss4qrpbm3k?=
 =?us-ascii?Q?CVkBcDekBZGL92ReZPLwdwaviXjfPG3Fy/HmvDDfmFcecJj/YtDqs1OYZUCX?=
 =?us-ascii?Q?SIdAxL+LYmwHF/rxnHHEfvQC1V/uQ4+jxNN0gXXHuq9VigBQVM8yT21RebAk?=
 =?us-ascii?Q?ilbNCmZsJT8N/rCStiLMSRocqOexTgiGmhwA7w3KLlTRQJk66M58GQ6MfLOo?=
 =?us-ascii?Q?CfY3c6NmjcJHqqFJqQjXZ+oegW+XtQkM/HGgchASwKc+xdjdyq2BWjXusnoi?=
 =?us-ascii?Q?fTuvGCenZKr+ES2ZDnfyLAmqaMvl4BeKeShH5cZlCYrAN2CpL+xclsx3Kfoe?=
 =?us-ascii?Q?29OxkMz1GLEJMKcb4LCp7iqKDUxq7SFogmpWT2pVCXVPsikSytiTrIxKd2+8?=
 =?us-ascii?Q?jesucwcoFJRkTEwasgPM6KFoXW3gs3NEKzM1TR/1B9SZWN+ZD8vEpQd7ULt2?=
 =?us-ascii?Q?VbVMLb9iFBbbiY4vsxD9XV0n11LV1B7rw2G+zS+zGfXjmNE5UAqDpP88jkTo?=
 =?us-ascii?Q?5HPU21NIUFTEPYReCWQdLJ3NoqB0C/xyq8UIdtrVZetcPhmO/vUOnTWrXbzS?=
 =?us-ascii?Q?YSMkvOFxc2JQNVeQixBUVhtMZD46eO/FabLNi33QG0NC/AQUXipmgfTqc8zh?=
 =?us-ascii?Q?r2idtBznoVsAxgpZnphMJyh+NRIeeVFcs1t/XA0zUDVlp/UehHeYrmDX+MwC?=
 =?us-ascii?Q?ntxMTa+2pX8kw7sIxnfrNPHstT0lNfRWNjz69qNUuD005wvrpxbbSmKiAp7o?=
 =?us-ascii?Q?RMtrz/uEEf1kJi58zleeO6nFFOdtW7KdentVzXkR9KFswJXk0QMXdb5cjKC+?=
 =?us-ascii?Q?xhiUZuvqhIf/bNP/Dozc4pkVcJaMHZWQot2GOQuzPVzlWfgOSmaDDCMe01J7?=
 =?us-ascii?Q?Xx78qUA5h3inCcVfOqP1rg5wtPVxP1NIxsIxMDIanGpzb+sq5etBHKb0Kt36?=
 =?us-ascii?Q?X9kLKd2hhERFfczJ9uwbZFK3yY8VSMw=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dcd6e7a-1ad4-4d28-80f4-08defb98708b
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 13:15:27.6270 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AwxKBnFYioWrOIQzZfOI9jKxcDbZFicznfE6L3YWx4Kz4VJ3sFZSIwcwpq1ljTl02WGXreO/LQRhZkNtbsIczV/HpXVtsAU21iX7mBT7Wt8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR02MB9310
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=bin.meng@processmission.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

 hw/arm/mcimx7d-sabre.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
index a0ac647c3d..22fe1fa932 100644
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
 
@@ -34,12 +44,10 @@ static void mcimx7d_sabre_init(MachineState *machine)
         exit(1);
     }
 
-    boot_info = (struct arm_boot_info) {
-        .loader_start = FSL_IMX7_MMDC_ADDR,
-        .board_id = -1,
-        .ram_size = machine->ram_size,
-        .psci_conduit = QEMU_PSCI_CONDUIT_SMC,
-    };
+    msms->bootinfo.loader_start = FSL_IMX7_MMDC_ADDR;
+    msms->bootinfo.board_id = -1;
+    msms->bootinfo.ram_size = machine->ram_size;
+    msms->bootinfo.psci_conduit = QEMU_PSCI_CONDUIT_SMC;
 
     s = FSL_IMX7(object_new(TYPE_FSL_IMX7));
     object_property_add_child(OBJECT(machine), "soc", OBJECT(s));
@@ -65,7 +73,7 @@ static void mcimx7d_sabre_init(MachineState *machine)
     }
 
     if (!qtest_enabled()) {
-        arm_load_kernel(&s->cpu[0], machine, &boot_info);
+        arm_load_kernel(&s->cpu[0], machine, &msms->bootinfo);
     }
 }
 
@@ -78,4 +86,6 @@ static void mcimx7d_sabre_machine_init(MachineClass *mc)
     mc->auto_create_sdcard = true;
 }
 
-DEFINE_MACHINE_ARM("mcimx7d-sabre", mcimx7d_sabre_machine_init)
+DEFINE_MACHINE_EXTENDED("mcimx7d-sabre", MACHINE, Mcimx7dSabreMachineState,
+                        mcimx7d_sabre_machine_init, false,
+                        arm_machine_interfaces)
-- 
2.53.0


