Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF44AC5CFCF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 15:54:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuXhA-0008BN-OM; Thu, 13 Aug 2026 11:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wuXh8-0008Ad-SC; Thu, 13 Aug 2026 11:50:14 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wuXh7-0001nZ-5C; Thu, 13 Aug 2026 11:50:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iOYQMZHsdwwiptIhRn+BD2zL3khIKFMTMSsMr1fwBqZLwNpseY4pRLktEKscJG7QYqOTC27xJoiJ5YUNWBlVBwnLbHxbPc2lxONa639qckTnF8ejS48sOC8vDqMcKaMr8Va2jSgRl9G8ngnNOSO4g9QC6oa0d0Rl4rs9H7MzIgZpQkVyL+PtBPUh935i5XzuDNxh1ZQjlXrRPCfTLTPi5ENhtS8Yom0pkWI2uko4TT9MK6nx9CFdZoGL/KDh/mMxddt/O/Re94VE56ygeki6Z5vY41DWferFF8G95afhEoEDUmLuyP+qt5LXDESK7zvACWAkr2xCU6Y/fsawTum3fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NmlEv9nl1xY0eIcRl4LqtEwxfCVmFK4/Oq+FFSCYM2o=;
 b=GrghIMYH6KZDMxw4/8FPEBmfsdDRnwFGAUi5XUfYWSAXngsKzTz8kG32EcqJYQX6pJpkPdI1I4nocjkV85lPPGqayKOcFy5obrEXc3hwD6Hi7XpIOrotcsbyzOWZrnKLTKUXG765gLh3/PugJ1uD19X9yq1LRZHzBTckuhW+DvUpa0dpNXUdJ8BEkIVfqwNJDzBJNPbdetkf+eTdTDiM2pohx1fcOXEN2t8EYxhgZdVIWoekF8juCPPCFgFwMxjvpE69zoPqjtIop1/ZzeySR6zbac+PLZJiUwjTbYjkAgZUUQEk5V1R98vErXUWlJVnwu3+9f6IM1dZl5zl8bqoLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmlEv9nl1xY0eIcRl4LqtEwxfCVmFK4/Oq+FFSCYM2o=;
 b=OhdgIaDagPaqLj/6bOlCD6MzMpfyVOx86ClQcNi15Nzd2qCBfB14Zwm3bObI4x4We3k6G/oe/bIGVf3PRNzaQhZbGLXANH7jhyU1Dpe2KgL9LiBjeBjSFK9RghgMz5p+ZmPQ63lWRhom107ZT5uL5iDoYleZLifvOTh88R1oS2w+aPU/X9uWRVpEEBkm/DcxofgxdVW1RBpcViyv86Diz1T1CMPkFePxwy72ZNBb1SXd3VSEN3lWKQ2f5lUwcesDetTyPFa8Msbi8T7Qb4G8n59E/X2t6kTuAsBLGhvZ1iPp20LVvGEszS20EaDWWS3zetL7QXyQIhm2c7WRwFe5BA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by SI2PR02MB5490.apcprd02.prod.outlook.com (2603:1096:4:1a1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Thu, 13 Aug
 2026 15:50:07 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 15:50:07 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 qemu-arm@nongnu.org
Subject: [PATCH 02/20] hw/arm: aspeed_ast27x0-fc: Store boot info in the
 machine state
Date: Thu, 13 Aug 2026 23:48:50 +0800
Message-ID: <20260813154918.996812-3-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: bb4ecc2b-be8d-4530-219c-08def9528c84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|7416014|376014|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: QwBfc62PRZ35X9OqJ6/BMuWZt1ofUUx75svMuGlMq1p9aonWFeZ0MBydOrbmVmSrvI8kx/pJ9MHfOJzfIDL7hHTzrOi/WRRHetPlReQwpmo/bOaUbZZHh1ppgh2BmpKMBIFj5l4OieWBdXJCHrhAMCHOJSmio0/4sz/VCcsceiYkUdxj7i9bCnzRGNofbHRDpVSriBhH95b9nH97bkuPtKYf4FiPe5PrDg+0i9TdzuVZio5bNxGpIBQgPsmqaFf3zJZl3GIUcBvLMwUjoR+QIRKrq+hL9rw/8teODkyTIWhYMiUpN/HY7yVHST+rX82avLL7ZTRWj/hG/EEURYKobOpvSSmU4zczzBsNs/vrL8g5Vh8lJ+4XTohivO9IO1N4DG6Hu7uwdpMZn1zZB9y2ui5a826aDmIFVtvR1YKDvSGw+xzynKu1Zh8Z3xCc7CcscLW22Sj/aH8hzaQgV87nTVFmX6suSFuyuWLyo79jajUbtUQA/xiIqrvV8a9PDn7bxWo2Rsr7JY6V4t6x2Xt3D0W0ahtLbPoBPRT0rq2DZyjVU2w4ZQ6cfK13Jajz6hIuJK9jIrN8XAfkStNkg11VJ6eomhSPZo1CKcwxkRpNZDpQAba/bpUXKXfrA6+pmpFjG/uevcbGL37ANPEdqbBwjusrOUmToGWX5t1RHMUU6WM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RbREh3NanjbsP9O9vi/abMPg6J9q9dQNd8hhoxTuXyCEy2W5lfFndVP3h8ZZ?=
 =?us-ascii?Q?RwpwpuyJ+PzdewuqHuExdqswzTySxnuYWneDvGO9ayTF5m8dtPIKv6KOxvMC?=
 =?us-ascii?Q?HitC7kbJBkklhIWkh2O+/NlwAV4ZUCp1R1AWUSIytpkS1YsxdCR+Aqesg0+6?=
 =?us-ascii?Q?p9bvvG9mtdy8mo3zWY/pAcQqQA2ECwrcc7PqHI/2DRY8qJVtEdo+zHsP6VAP?=
 =?us-ascii?Q?7cbYpfsa3bcSmXM0FNA8vcNzCyb0M74S6lz3lvStlOYB6ya8d5tNIFWocMkP?=
 =?us-ascii?Q?PKTFEPSTUN+Dmmwbc2G6DPykl0Lc4F63IwE9erkbbe52MMUVscyqekYLktOe?=
 =?us-ascii?Q?xDL36/Az7RD598yQE7n1f9r85XyN/YEnMufS7z9/UBxbTL0i30eSmWmp0RJy?=
 =?us-ascii?Q?FmCSvYPQl1Wk7X6wwFTbOWKYZUiHN6drAx3vhJsdYMF7POsNUkVuBOM9GY2U?=
 =?us-ascii?Q?/Kifiq3O3k4zUakgbTY0NUkZ9cYrh/J1nJ37MoHcldJIH72pbyi6rAXJfy0t?=
 =?us-ascii?Q?VA0IlmaFCWUCX9DOA/zH83p3Oe8W0CRKoTQap9TZHIh0fvaGwOI1se56dMjJ?=
 =?us-ascii?Q?lPRiBHyyo37fcVNfsEUHuKEu5qRn4vN3deaBoFk4z2ZFLrFjZcwGxqrP09GV?=
 =?us-ascii?Q?RFGy1SED/9A4yD9I2SFbHpXmr+xrdtREnkvPjqs4K1vknzPUHS7rsmlwZl74?=
 =?us-ascii?Q?7e4gpQo+1k8JFrdJtAj3t2wNMAnR7WHFDLH/84gqXOJdF/iaE+r/uFoPC7xI?=
 =?us-ascii?Q?vfr9j4w3RLSVTwGf2GskvNbi6xgvs5XhJxO3Ycix5C/AQmxfy7nL8tr9XkpH?=
 =?us-ascii?Q?OU7xzA8zUHrhkGTqw+E6ZxFPSxeVzrvr+sVvPF+iHAkLWyyV/LfMhpcLVHkG?=
 =?us-ascii?Q?E8u+xkndDWrr8JpV3fNBqZwofLXQOV5AWai9x8Z3acAlxNQIf7keLm+gLkq6?=
 =?us-ascii?Q?o8bA1RXoae+lGh2xCG1x4G+NwzgEYtYH9yaXpq9lZibT/6CE1aIKbD0yNnyx?=
 =?us-ascii?Q?5rFsfW2wjLlDZePEYOh5WB00cibOCbmZJ9pvpWjN8hKi0MOeuX34qB/ytgCu?=
 =?us-ascii?Q?tuf0Tq4S9ky8r73p/T/BqMHnVW2X9ayetlY51KKOThT/AOE+405pb0nvYIcs?=
 =?us-ascii?Q?Ck89XK7hnchdsCsF56D4/EuD5QAbh3vp5g/Y1v9HI0Eyo6qGXVBwBXShcfZA?=
 =?us-ascii?Q?j3cSeeQlWMNTOF6QVZ1pAYbHZcQIr84Z5zJTlggPR2Vjs5FpmrEorcEebR7w?=
 =?us-ascii?Q?gBj0wLDwfyuo6/YarDjfqVU8K/P1fIoYcl5wJXcF+JkEfpgATddn4q2C3WU6?=
 =?us-ascii?Q?wtWfDeU2En0YbocHdw3p/BR5tuh8UobzKYkB4IWSAv8DXI62ssLqlW7DtHJ6?=
 =?us-ascii?Q?baOl99z4xysHPZTaox1hnZqOCsLmKVaHbPVgCJnLctgKhTVPJIxVTRYj9vq4?=
 =?us-ascii?Q?fR5xmiPDC6x9+9/M1DAFxe0ipTskkLdGvdewGbTeQwr5nzlY3PHPqAPliu4u?=
 =?us-ascii?Q?2DDIspQbwDEWEFRiVKhsmKLOS9A3NT8FzgjaduhgO/ur5MVphxvwxT207MsL?=
 =?us-ascii?Q?oIfr6XH2gmf9e5awg2zfi0Fs7TTwOYLveFenLB7QW5HRT+2+jcue2YyoROiw?=
 =?us-ascii?Q?pdFIsv5C1dOpfpzTI+zVu17Y1v6tp+pkMBcUDOo0ZUithXAMyoQuMsPBrobc?=
 =?us-ascii?Q?9Nnryf+wC4cFp+3vS5LSwT9jpTmItarjjBLs97zn+E4M8K4QmnM4fJDlRsOP?=
 =?us-ascii?Q?ieR8NqYgUArQjClH5Vc7xZkGO+Jpj/U=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb4ecc2b-be8d-4530-219c-08def9528c84
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 15:50:07.4298 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gi01hXvmUabRTe7BX6lq0bCBpLS1IH4wL8cGhOLjFYgOubhpqtipusjmSGjtuXIkyzoLQYcztQ8GtO4nQiN9BIcWP87paiHWtm2QmoNpOKk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR02MB5490
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

Move the boot info into the existing Ast2700FCState.

As in the xlnx-zcu102 and raspi machines, the boot info belongs to
the machine rather than to a static object:

4d1ac883a7 ("hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102")
0f15c6e338 ("hw/arm/raspi: Move arm_boot_info structure to RaspiMachineState")

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/arm/aspeed_ast27x0-fc.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
index 058cea42ed..ceeae336df 100644
--- a/hw/arm/aspeed_ast27x0-fc.c
+++ b/hw/arm/aspeed_ast27x0-fc.c
@@ -27,10 +27,6 @@
 #define TYPE_AST2700FC MACHINE_TYPE_NAME("ast2700fc")
 OBJECT_DECLARE_SIMPLE_TYPE(Ast2700FCState, AST2700FC);
 
-static struct arm_boot_info ast2700fc_board_info = {
-    .board_id = -1, /* device-tree-only board */
-};
-
 struct Ast2700FCState {
     MachineState parent_obj;
 
@@ -46,6 +42,8 @@ struct Ast2700FCState {
     Aspeed27x0SoCState ca35;
     Aspeed27x0CoprocessorState ssp;
     Aspeed27x0CoprocessorState tsp;
+
+    struct arm_boot_info bootinfo;
 };
 
 #define AST2700FC_BMC_RAM_SIZE (2 * GiB)
@@ -114,8 +112,9 @@ static bool ast2700fc_ca35_init(MachineState *machine, Error **errp)
     aspeed_board_init_flashes(&soc->fmc, AST2700FC_FMC_MODEL, 2, 0);
     aspeed_board_init_flashes(&soc->spi[0], AST2700FC_SPI_MODEL, 1, 2);
 
-    ast2700fc_board_info.ram_size = machine->ram_size;
-    ast2700fc_board_info.loader_start = sc->memmap[ASPEED_DEV_SDRAM];
+    s->bootinfo.ram_size = machine->ram_size;
+    s->bootinfo.loader_start = sc->memmap[ASPEED_DEV_SDRAM];
+    s->bootinfo.board_id = -1; /* device-tree-only board */
 
     dev = ssi_get_cs(soc->fmc.spi, 0);
     fmc0 = dev ? m25p80_get_blk(dev) : NULL;
@@ -129,7 +128,7 @@ static bool ast2700fc_ca35_init(MachineState *machine, Error **errp)
     bios_name = machine->firmware ?: VBOOTROM_FILE_NAME;
     aspeed_load_vbootrom(soc, bios_name, errp);
 
-    arm_load_kernel(ARM_CPU(first_cpu), machine, &ast2700fc_board_info);
+    arm_load_kernel(ARM_CPU(first_cpu), machine, &s->bootinfo);
 
     return true;
 }
-- 
2.53.0


