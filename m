Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1EFCC5DF6E
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 13:17:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvaiC-0001fd-L9; Sun, 16 Aug 2026 09:15:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wvai6-0001Zx-2U; Sun, 16 Aug 2026 09:15:34 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wvai3-0005TH-Lp; Sun, 16 Aug 2026 09:15:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gr0HLjApxlB9NqSEIvCtDNnt48W9w8zQlM2AQ7eoxTPgWZYm6R+oG149S8ZhtC2zXWYiVlHWC/ZqzWX+/rB51oI4IM1mOfbOutUNIGB/8NhEFfwt+5/ZkMTExNhk08AvSksnJNGHmltzGkqvWsQT4uwvlxqXF6dBC517dUXM6DQEIQLib6uR2q1N9Og7H85TYJ0AQLUeTglYGC5z9KqfCjFEKNqyQIlFFmlcIs8PW+16VSu+xxCPwCcJH4k+URENzrtnrH5AZeEQWrkkT3q8aerSQAT5F9E3enYzXO0MXtmDMSuR7oINQxAHSpJ5C/QiBwKuslD+jiWEdUNWqxK8gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxIoqz0a5dDuzaAXElMV8ixjgwnb6nY8ToWV74DyrBo=;
 b=suY5AYd8657EvmdNp8Ay1yx8k6aWnUQ6A/UapBRuEEiymAWArx3/FgwACC45Fxec7xC6zCDkKUivCF+pn6Rec7nt+QYwYuchspnOKdO4QkDf9D6q1ShhOMrQCv8pnk0blLSYvNAuhFOZLj6MgA3gzhh05KjRkrZl/ryTvcNcM74/v18yuGJpimOhvhpxq0o4eRQ6NKREVbahGkxCENx+ZIRbxthWJuHI9Dkn8eAf7nbqE06tJ/HkWQ0qjfjyYAqPpUfYbhEZ+AK4z4VN32hRfjQCjfsrY6V/UAXR4MJxCURgroSIdvIic8f0t9cOO+LeXPvMYla6UXXw1vBLBPvnWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxIoqz0a5dDuzaAXElMV8ixjgwnb6nY8ToWV74DyrBo=;
 b=Vulqb1orw13kC6Y5XzQYN4JPs/LCM2rWP1U0VzNGywIgOtc90D27BnK4lymp8swh7vjcwBQ14CdBGnhRaNIMoaIhPFqnF/QLOPmZdvXfJfpkV0hZ5yfEDS8ouocNnWO84T9YU7EJ4XkdOhAg9nG/5ew+hWrBOLElewGDhOCCu1n+7Ll5dShVUa7tEUVi3Pu2Wn+1L5Btr6kqTHy4s5RuOU+t4+kudfcyEHW3azTi8wjvxHr7UnCnqeSksZTPUptv0iaUK6PoZNzL8E4HLgvcGM5CbWrkhxK3i6R2x6Ci3qXpzHJ/clzmAcUtBmD2Z3C4r6YpVjbpMJA1w2YTh1AxjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by KUXPR02MB9310.apcprd02.prod.outlook.com (2603:1096:d10:9f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 13:15:24 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 13:15:24 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Subject: [PATCH v2 09/20] hw/arm: integratorcp: Store boot info in the machine
 state
Date: Sun, 16 Aug 2026 21:12:39 +0800
Message-ID: <20260816131300.51799-10-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: 643cff96-cfb0-4032-abd2-08defb986e79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 3SYHqUJKsHJbajibUFJRci01TU856Vy0CeH5eAudtDG/kaeiivF30qimnqBx4DXiM2URedLfWLbxTCJqg+2tRuXbJRhJs12y8/n/F5gdeglS5RbYnammW6nDzZlSCvXszebwo8EblFb3LlpvRO0orI5RC3OF1B0NCvw3p+yBMPGzvlLyDQkVdBGNH194f+nQqYT5NfcWtWdvAlQS5vc08Vi1wqrdZ+3nh/X1lp9G1gHOJtLkQ/3u3Tq9j2lcBacO469khC88mhjB4ROKublU04/F8ApojeqWgYJMilcq8N+X0hEIvPXzwhRn/Di3ZFONPnssz46xXbOWQeBS8YmSc/RZjqdhFe2VfPqfR49pEFGZXkzacJ/Ajlc/rOflbz/RH0CCJifzp+tJqWC1Eip+47r0Dno+yuCO1lKutZFmyZ0SVkKi1wQzjQJ4cZzLiRaMmnZspsVMOFWp4QOdDK6lqG3NAm0iOezssNKtq+tY0SdA28L8R6Te80EcUWuMhLJygpGnrGj0++uBjV8fOIP6HLgmCLPcOLrHC+xsXXsRKGbzR5CN3L8S3cTYZfFVA8toiIYXYhN4QrKmwylbn3kgP4FXlmvs6DCKyMiZvfpufdOuqX/n4xCyG5Ntlx6Jg3M90D8etoRhiFJNR0a40WflAUVwuxZBPoSNCNAHUYl02V8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YjWEAbUUvvdFPTsLx4oluIyfEtEZwQ1YHG626Vo9yGGck+Dyk0ysu8aGO3W0?=
 =?us-ascii?Q?Sva924+/t9irjSue3o3IqxUyiThuK7qUA6XWdKLXYxeiUmrfPh/wPU1cWimO?=
 =?us-ascii?Q?D9qHWQqM1iTMkcoV0aGAYff0ehvIfTwj/khOTtADj0pjEkIKzrFo2eMJzW+j?=
 =?us-ascii?Q?qk/Ca3bPKaRyckKgq6xm7z6mbGvJ2mM9V0SUcbNgNi2K4E6tNd0LPJq/b7Av?=
 =?us-ascii?Q?JUo0rRC6ttD2P1Hfizk/Lq8XEPqTt/7sBY2dVfW4wwE8YCtE5JubOJUaeM4k?=
 =?us-ascii?Q?/K0h+G3A4ZSLLtLQX8QZG8us0/WIkG4CbpaN8p5IVkMmYNtAbkSwCr0hKo3r?=
 =?us-ascii?Q?lZRtJYXU6d86fWOlhK/uMFAtN0d06DqLJyICPA/xMrU9ixLwIRXWyxtt3wU6?=
 =?us-ascii?Q?6yg/lSBARpb5aTBXOlnYM7qzoHQCVeJVDZERW0QTwVHcYf6aGDW6xepm5YIs?=
 =?us-ascii?Q?qCx8RrcVdt0QdXMdb/PZuH+aR6vKyETiliES9GouIhx0QxrxgiE+iSbco4Xp?=
 =?us-ascii?Q?grjyxc6LY0blDLI2ja9LsvZLq8jVrFJcvn/z0jFYM7WLnLabJI3Y7qiGmoOh?=
 =?us-ascii?Q?tFXcAC3+gLDns7JiYr32StTBENADmTD1YgfPaN0nkMaxQ4qIqx+r8T+rClOo?=
 =?us-ascii?Q?DujUvvwmSS0vI6vR1svM/Gph0t4uxp8KhygJ/V48HR1hOCfzhnyahUbMChLB?=
 =?us-ascii?Q?LKGbsEoyV7ZaeMh1rqNMK2X2veEAqYCBIBEMTZX4p8EKcV+5S377pwwRwZ3e?=
 =?us-ascii?Q?y2ocM4iUYJ5FizRox/XAXetaOS/SzZHs24hrZGJEZATHFqJgmM8c6h+CYQ01?=
 =?us-ascii?Q?Ig0CKcj310nDvZBWxXldgA9jM3Sx/bG9MPesjG7E24EpWk6EqJjFiHhU7arj?=
 =?us-ascii?Q?BAvPk3Nyvxd4lP0LU3nxOZrygmSwKJF80N5HqmLro7V79prboE8fZ6OSbxEw?=
 =?us-ascii?Q?ZhsPwVhVD2+kpwTvEMuUjzG1TtDWpKhqEtDwP833LepEzBjhfB1GEdEtcIyn?=
 =?us-ascii?Q?RelGL6+Y0XVuYmd2+NZcjzPYOnNCXQvnxU647CpDYIADPnRariM++rVuEnXG?=
 =?us-ascii?Q?x04UCCulVULSGl6DKJd2bS3gaA99dfEDFcVDyNQV18g4uuNKeSuASAk/hZPt?=
 =?us-ascii?Q?8rP0RWPY/TfLofTlVUA4oiPSvWYplsKKcTOCJt9RpR7X6or19lKgQtaOgI0B?=
 =?us-ascii?Q?zObsEGvyOxGC4I6nVAQC+qMnbxK7FAzo+iGuQ2PKzpDms7P7aE0SsOctoaX/?=
 =?us-ascii?Q?CvBuA61USRExBycM3MNhi/qPijFRILm4tDEaKJC76b0MNW03xLfKrtXHY0cR?=
 =?us-ascii?Q?wiPBf0dVjXXyyxaySfDSGPi2Az3NGKGj0vJjDnrkw4eHvktNMte+oIRA3BEe?=
 =?us-ascii?Q?dQbjCsLgL+2gAXAGvqdGQ6CMbpYNCtA+a0+978xJKfTaQDbfaoM8ssNMUuHr?=
 =?us-ascii?Q?/vNjKEacU/8gX14xUSkfFG3lox6hZzTiweSjRPgOc7JgaUZX5XZJc8jOVmbe?=
 =?us-ascii?Q?J7CkwWcMNvH0xR/6pPb0WiF3ie+rRMw0HW9n0nPF5CdSaBe2wCiJK6bBiTxf?=
 =?us-ascii?Q?BGkDYs9Qsyqy8p+VS9Dd684CJrywtKf0J1EKRmvfklkYa4GJCRrrRq4Vke6h?=
 =?us-ascii?Q?Np54Naw7AsV5d8TrFIhsxs9ouquV00fTQXDzPXRnn/3iXw9X78pWYifi0NEm?=
 =?us-ascii?Q?NvarVHYGYc18bceCl4OATlz4TYCwwPvUojjSReOHmRXs/V7FqisfI2pvtHvn?=
 =?us-ascii?Q?lj1Dnh/YyALK8XZCPN+Vg/qDCg9xMAI=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 643cff96-cfb0-4032-abd2-08defb986e79
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 13:15:24.1998 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EIptUOLsERc71sp0ShfvitMPJztaVQT/JyU3FXTNcya+f/Jl4R2Ih8+o9bBrXozXAQkfuJH9vR9z1kpkySveWhOmdegXzX30N5/QdiaZQ6Y=
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
rather than to a file scoped static object.

Move it into a new IntegratorcpMachineState and register the machine
type explicitly instead of through the DEFINE_MACHINE_ARM macro.

As in the xlnx-zcu102 and raspi machines, the boot info belongs to
the machine rather than to a static object:

4d1ac883a7 ("hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102")
0f15c6e338 ("hw/arm/raspi: Move arm_boot_info structure to RaspiMachineState")

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/arm/integratorcp.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index c25bbf3c82..f8bcf42c61 100644
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
@@ -680,8 +686,10 @@ static void integratorcp_init(MachineState *machine)
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0xc0000000);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[22]);
 
-    integrator_binfo.ram_size = ram_size;
-    arm_load_kernel(cpu, machine, &integrator_binfo);
+    icms->bootinfo.loader_start = 0x0;
+    icms->bootinfo.board_id = 0x113;
+    icms->bootinfo.ram_size = ram_size;
+    arm_load_kernel(cpu, machine, &icms->bootinfo);
 }
 
 static void integratorcp_machine_init(MachineClass *mc)
@@ -696,7 +704,9 @@ static void integratorcp_machine_init(MachineClass *mc)
     machine_add_audiodev_property(mc);
 }
 
-DEFINE_MACHINE_ARM("integratorcp", integratorcp_machine_init)
+DEFINE_MACHINE_EXTENDED("integratorcp", MACHINE, IntegratorcpMachineState,
+                        integratorcp_machine_init, false,
+                        arm_machine_interfaces)
 
 static const Property core_properties[] = {
     DEFINE_PROP_UINT32("memsz", IntegratorCMState, memsz, 0),
-- 
2.53.0


