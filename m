Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DFDAC5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 13:16:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvaiB-0001f5-Jo; Sun, 16 Aug 2026 09:15:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wvahz-0001Vz-9r; Sun, 16 Aug 2026 09:15:27 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wvahx-0005Tk-JW; Sun, 16 Aug 2026 09:15:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xBYO+KvUZ2lh+vxu8memweisBtqfoo5FfiFEFYZAwnI9sSpyA5Xq8scdzf7y6U+ly9pH2WRQdTCBam3YfZnqjQF49v2WiT60LlRXaZNt/JGbt1hlbkUsOaWSgnc4RfNZKhnkxsybqEJ9+TI26d6hphPeQa9tXoT8+1H/jCiZ0gT/euCDXFUG5EH7yQFZHNX+M/SWvwMi6qNzznjQYXkvRo87PczZd13wIkCnAO6GjKhX1WZjKeytPcYbIrZewllZqmhRCjk91wyIGFzWvGrx7uYWnVJ0wICukycKtU7lgCnwfZebkf3uPoHi8tadPsznD4e0k14h/UyjMjg6xedBdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSeMWuLGpprHcg/4obJGVunhkLSSJpSAdUlWtTR6Q5g=;
 b=aGGEJKtJK2dvMPoJQFsYzVdCS1pSgdUB0LRNCrnTvHCuIKNG3xTBYessLkHaG3dgNPcEd+vbrJ3Xpa/8VAwh5+wjg3bTqJgAslX4Ujw0Zc1vufivg33/MXjGfgqgL4YeATbONbKobzm2Z59P1WXhYV58ZKuWSnl6fVxwSI6QmJS30wnTrroeRoEeBSMuwZ6P+E+DTd7ow+NnmLzTAYNsRPmlD2fj1A47IdfcZEhskPpgQSKadtsptsF6IF609NziL2ardpG8fXFLElCCqF+RfmIexfwHJ0AYQqDi6yzdo75qQmGa+/apfV84Y2q6RvFrWnOMnDIg/1AgIwPVpWKrJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSeMWuLGpprHcg/4obJGVunhkLSSJpSAdUlWtTR6Q5g=;
 b=PIgZmBLc9vPizQ624LZPGut2Rg4yxZHX3zRmDiv3mBx1hnnPP3yVMzY/D99xm3ifDEei1RRbw6KI8qw2LhnG+Ue8MYmICX/buJAXaLxaDcs+ABMf9A+sqezFxCIjCnkidfmuaKhhzjV3P1NjLFD8YWoUnoh/Xl/2HzgsopQ0XMcORYNxznWMUmEq/RXXLxzmL1gs99HsvB3i5uNEN4PjToCH8XIsJFDySlagOf/3wQbLf+CF/zxgA1LlcvOZM+hkZJ8X6TFqKu3+VIOu1N+1Me9evi9Ulddg5C38gqulrvPsNQ+57NrXeDvMrCq9mZMYdb3+8ax9UVXfodW7yIGZZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by KUXPR02MB9310.apcprd02.prod.outlook.com (2603:1096:d10:9f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 13:15:15 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 13:15:15 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Subject: [PATCH v2 04/20] hw/arm: collie: Store boot info in the machine state
Date: Sun, 16 Aug 2026 21:12:34 +0800
Message-ID: <20260816131300.51799-5-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: e779e2af-e444-47a0-8d81-08defb986919
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 470WqyEwMv3+jMtIqwhWsCKpFIBxLTRfxh7riOqIRrG/3kkDW1lyvoCchoGTO498RB5VF2mHpGCBbwMuHC5KOzN4IhYqPu+FAKhKHuPGbDj4J9luNvyDAgto2ZNvNz6SlW/M5YgMP3Mf0H+3BdN5ii7lZG2OcPD1pY9RpOHiDy4NuVFJCdE48iLnocLzVHS7MLecatyWj4bsm6w/5ufbUFurAbTyuFyn9eTSFgOzQg75u3N7vVXi+V2VGMUXG/i+y1G++ahqGX6Q4T4atQB+Tqpduxq1QQQ+3F1DX5JrT3ZQUaoC6Q6ToOvEDUKslvk78tpa1/RD8vtfrH+eV1LDqmxZkBD9jLDdpkYhCV/paSBV6pZafyMm+W0H8e0YYz4IWNGsI3bOlEXaiDZBrYaq9v0LIbCl2QfuuSYOPuZWqUxngRbkP/joGqIIghRZ/IS/lg6Fw8t/kgqvAAeFVfPXiwT4tLJrhT1nYxAa1AdMOOe9Ybc5t1ThKa64w0ttqDe0pSssYqlVtVRa9rQyP1GX9AIPTdAA9EGwOPB2t6ccwQg+7ZfL3QB90Zz0L40hys6/SC3VLEQIJwpvdkAg3FW0JLVfUKhqMKqISx9JXRfu4m/4Dwbnt13IGNN3qKDWNGJ9iCs3up0KwgOh4IGr9igCui4145UaOR/nn6KXhY4jr44=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X4dmqe/NEIPBN2dKDvTKmeU1prBYUbKFpa9UhcGLSGO5xl4b/h0Iqi815qhd?=
 =?us-ascii?Q?ypLZX2vjzG15QM1wXHxb1zJIeN1eqS2h7n23saiOUM9EYORrJpXxhcesbzRt?=
 =?us-ascii?Q?c/hsmV3VSJGKVJcuYIU3V1S5JHCcr1C+4LiD62DKHP12pkbWFzjuYtVCLnmj?=
 =?us-ascii?Q?BRcecLIFNHm4+cwtPvf9NBqj9K5voR4npbu949/ySyeuq8cS7DipDjJ6mhdt?=
 =?us-ascii?Q?GV6Ui93tbzg5q83cw5MqKYB/bpjIj2MOoYtvucrT1pI4z1TIDUOu2a1xVJJ3?=
 =?us-ascii?Q?26mlTBWzS0z1v9Y6U0WjybtK5MjPchWJr0H/tmy3I8OlFNxEAE/2cPwnnPur?=
 =?us-ascii?Q?C0Uvw+v0usvFF5zN2OBn45rpj2C5WPLlTAxAcczOwKZIptU1PDNEjwgwrPpx?=
 =?us-ascii?Q?7OOiTfiPyHyaGti/QOObnw/jNG0jssIiEY8tomqddxGBBn6LuJz9Fb6KsBR3?=
 =?us-ascii?Q?DUfiqYPlHSGodwzjM+EuUl4M9kof5bXImVOaonHonItZ8OA3lJ+1640M/giI?=
 =?us-ascii?Q?f9Xydknyf0lat+N+8UMq1fIURLH18OEKSS9n7YTVpdShKnaStRViEuvSqpQk?=
 =?us-ascii?Q?DuCosXJQB08Bhu3pG/EYUJbZMLw5wITcJfRtjY7421LV0AB4/i3X0mB78h/n?=
 =?us-ascii?Q?lnzIpCHNEaBW4OjdjM1NEHrChJfn/CFb5ELZu7TfmMK7hjxcE+w42Xg/2PsI?=
 =?us-ascii?Q?UuIxwbv+qa2M72wSNgq8eFLKCWHRPssWS+4VaVmXlSicylWqIYLrCLPCf3tQ?=
 =?us-ascii?Q?J+vwCx7Fddt0J1bYfL5LMQRWd8M9d1EaBJiliisIlpvDHZch0Ofi29WcNrle?=
 =?us-ascii?Q?2XVoy/rBP8aASWtq3AKozpNzwgf4sY/7mmG0TYhPknlCdv/kndkAb260lxWZ?=
 =?us-ascii?Q?esD4QtLqlZmvZhNNqyqlfeJVcmjfnPeVSgXDo7VV9SAj9neCpFt4o8+/W6Gn?=
 =?us-ascii?Q?bA9Y8ambbW9n3HDaoYrj7ysNcoNnj0n1X6Wca5AbAwxEtx+hkCo+0l6zpa50?=
 =?us-ascii?Q?rJCxKFqqdShzIBmAiFLPrkq3UO/gJxDej71ZM7Hg2cIH2gFJxhAUXUvyQHa4?=
 =?us-ascii?Q?NMvGCc+y+Ve42E2Bj2Qrv/GsqIFXVAw6I/RTEEqjH5yz0z0IhqkTe0Q731QW?=
 =?us-ascii?Q?HuOFE0Zp5eQMYY3bdVPEeFqp0JSg1YVsXXNrH6SHbvSBF9P2nfKkpa8QGJy/?=
 =?us-ascii?Q?0Bky6hgdb+GY4xDQa/nshqcDEM3IuzgNYLq+tehluoKoNIJNzFa77UxkTS9l?=
 =?us-ascii?Q?cD3GJ1XxpvRd5/DNkF0COIzHQy/W8k9+f8SPc6HB8R8ozCkQRISEsFgCQmrj?=
 =?us-ascii?Q?nQV3MFNE1vfRp+XJpCpvcQ1x6q6FKB7pX5tiW2PHXSXtRdhAbf/Ili280sUL?=
 =?us-ascii?Q?afGS4YUoliDOwr/ApeazR2h/kgyRiwteKZb4e2ciJrbm7d4jOzcTtaQ6fO9R?=
 =?us-ascii?Q?0ff/vI6JH9d89TcQXH/mhb7Gl58bjXXNPnqJOBvvd6iiSQIphpOqfWhruR6o?=
 =?us-ascii?Q?eeXs9YB8pRdIKRU5yJgBpXuZZzwc93fyof0ZSbYkxUFBLaFbW+7BOrX7VOwk?=
 =?us-ascii?Q?AeYkljn9RZWKjeuOzuAYHAltGfRyIJTjnjXftWdrxaqG0nG9/f/VxUJ80lEf?=
 =?us-ascii?Q?7VJDK0FA1V83d2KAU/1UbEabI2FrYytGXj8YTfnCjCIcIKpN+RRhXnlaByEF?=
 =?us-ascii?Q?3WJvvSwkfBv+QdUwrqfiLDV1+TE21wq78N1wHx/Fgx2oQ3wru5r/KphZv5Gw?=
 =?us-ascii?Q?htVyB7U8ZVpjfdDo+5BFSKlKYZ9UDfk=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e779e2af-e444-47a0-8d81-08defb986919
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 13:15:15.1656 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tOZX3P+Ebru92wEelO1EQNnC5qT+SvGISXK1XdKZHFwi6FJAml5EDzRUd9nxedEIyw72x75Y/riQqGiq0e2nyaUjMwdWiuhZGf7+I+flCDU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR02MB9310
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

Move the boot info into the existing CollieMachineState.

As in the xlnx-zcu102 and raspi machines, the boot info belongs to
the machine rather than to a static object:

4d1ac883a7 ("hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102")
0f15c6e338 ("hw/arm/raspi: Move arm_boot_info structure to RaspiMachineState")

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/arm/collie.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/hw/arm/collie.c b/hw/arm/collie.c
index 91f0a94b6f..01d74ad38c 100644
--- a/hw/arm/collie.c
+++ b/hw/arm/collie.c
@@ -30,16 +30,12 @@ struct CollieMachineState {
     MachineState parent;
 
     StrongARMState *sa1110;
+    struct arm_boot_info bootinfo;
 };
 
 #define TYPE_COLLIE_MACHINE MACHINE_TYPE_NAME("collie")
 OBJECT_DECLARE_SIMPLE_TYPE(CollieMachineState, COLLIE_MACHINE)
 
-static struct arm_boot_info collie_binfo = {
-    .loader_start = SA_SDCS0,
-    .ram_size = RAM_SIZE,
-};
-
 static void collie_init(MachineState *machine)
 {
     MachineClass *mc = MACHINE_GET_CLASS(machine);
@@ -66,8 +62,10 @@ static void collie_init(MachineState *machine)
 
     sysbus_create_simple("scoop", 0x40800000, NULL);
 
-    collie_binfo.board_id = 0x208;
-    arm_load_kernel(cms->sa1110->cpu, machine, &collie_binfo);
+    cms->bootinfo.loader_start = SA_SDCS0;
+    cms->bootinfo.ram_size = RAM_SIZE;
+    cms->bootinfo.board_id = 0x208;
+    arm_load_kernel(cms->sa1110->cpu, machine, &cms->bootinfo);
 }
 
 static void collie_machine_class_init(ObjectClass *oc, const void *data)
-- 
2.53.0


