Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE35BC79FA1
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 05:17:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4tck-0000FI-1T; Fri, 11 Sep 2026 01:16:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x4tc0-00008C-8O; Fri, 11 Sep 2026 01:15:44 -0400
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x4tby-0005iY-C5; Fri, 11 Sep 2026 01:15:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a9UgnO0wWaA+m8CEeriAfsdtcKn9Jz8i56wMdqkPGDZYaQbBw88dC06jWThFL5RxFiAtmEJML7hpvoXB5N3pvuZjuU/BaunyKw0alBNVo8l00uodTDx6K9fmBf6qOTi3zYws4oby/Fh4t/9dwjT8kfNCqsVPfxfEJ7kAaENMeXQfsgZSvbBL17WjoqYWf9gh3JCHmO2c74xsEjwFjnQs1QK7N1RkGsXAwowKStQFHQAuPtYo38R+ew3sk9iJucH4F07iqjbc1r86yIP9mPkW9aTVXvnCWrlco5tYR8UiYJp13ViiHTBq4p+RmgPYM/mff7neo+MK5KygXzjTeAiLnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1XHDLr2lCk/6Qr2x9Y8T5yZojzHQNkfXzh9bZlTCyA=;
 b=QZgN5OwdUIt9QDUopQzLLlnqYLdXSBabulCVpkOUcjzG5MlnjWSPShvkFetytm2BkpW+8akyo08vLL8tAc9QZDrCKm+KXoSjDCUDtKOpkIQjU9yQJj2WDclJPNsbGUx7mJu4nuS66eM4DciGPiNvDc3BTQei6ZBzNAau/KurUOl9yYPSkSPG4KSzdebMM2sLj3DonfFPc6xUTzwYH3u6zA9KvjbvVj5S5a/OYxEekYdDeQHV4P81DRdQ92OwGzCxGeB6pAWYVMlLrsK/x7Bt++wbYiM8FiAlfXoBwWkSQExzRGbILuO73Dyl/butY9pMhfo5qLMF5azxW9sdf1Q/YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1XHDLr2lCk/6Qr2x9Y8T5yZojzHQNkfXzh9bZlTCyA=;
 b=nVgcU9emR1tcPIZ+BqVXX/GuhEsOTynEC2fmQDfenaWcpetFbX6g15jAvr8O1LkwQ7kmbFuLnoc9jIluxhWxZYzA8uSChnTt6mxQZNEUefXviInxDzVHuN2Xhq73rioj+E+RHlhlB20UbNNaXqRllaQPD79RAno53rUlJQx4wvqlpvF+VlJIYJ10o0vrAJfthKJiLS/+eLBr+grZ0X4DPgM/aDptJ14qU1aAkZMmVpIJXbVeljL3ipbZGZjbMZXdo352o7OUHyumTk71nFarjzMRvmLAq6kgHDCIu5XlAvNbjTz//EwH1tsS4kKzHT8+CZJCv6ESehOzdSwo6aAyCQ==
Received: from MW4PR03CA0046.namprd03.prod.outlook.com (2603:10b6:303:8e::21)
 by IA6PR18MB927500.namprd18.prod.outlook.com (2603:10b6:208:5de::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 05:15:36 +0000
Received: from CO1PEPF00012E7F.namprd03.prod.outlook.com
 (2603:10b6:303:8e:cafe::4d) by MW4PR03CA0046.outlook.office365.com
 (2603:10b6:303:8e::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 05:15:36 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 CO1PEPF00012E7F.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Fri, 11 Sep 2026 05:15:36 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 531C540BFE12;
 Thu, 10 Sep 2026 22:15:35 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: mark.caveayland@nutanix.com, philmd@oss.qualcomm.com,
 163wangjack@gmail.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v7 08/13] hw/arm/ax3000-boards: Remove redundant pointer from
 struct
Date: Thu, 10 Sep 2026 22:15:27 -0700
Message-Id: <20260911051532.2378501-9-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260911051532.2378501-1-kchiu@axiado.com>
References: <20260911051532.2378501-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E7F:EE_|IA6PR18MB927500:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9a0a29ee-d8f9-4fca-3651-08df0fc3b666
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: baWAURiJF6Y9368kgotsXoGQTwCa4DTockORM59N1AJ1EBaOMZj0PWNEzEW7CUQtOcvyOmuw2WHW2hmPFwlMH+Gu1eHfSnpfSrOCXpojqrtonvQGQCt4daGx2HeuexZQ4ZesJHhUez+GYhc8dgxS/bAhn9WaYlXSglLZtfzGqckMG5gMBTqNJmk21afyDAOQE73zj1A2RMAN4lAY3d4b3mclKNinBNmUpg5ZyzOW7P9bEnsvRvXjBjXl0j6I2zJtzAqfMYXilX+TArsP0HpudOT8OHhSDt/8WRKDIxXsrUskK4yprsK5ATaFfFdXiY5mbpcdBD6pU117cyCgM9wWMqAt/iUF21116Ie2gJ10dAYoUtsjlrzcNx3MqnzputPQng/KsryRWhJv1Mpimq2BLHkXYop6n3ScIVoKOiR/Ui7yap3mXdfRnpjH1F12EsAPv5W/fhh3Q+sCm5TbZWQGBpA+a1kkttILFc//lgkF/w9iWiFwL4FVC7X8HmMww3sFVh+AizyinWhsM6HNpRhDcG8XhDqKmA5iMH/0r/HR8u1EAOb50neUoVlO+/1KNEz1h+qtJF1fagsp/hpvLwlGa7tkhG/hlKsMGxh+Tq5x6myAtApyT1KP+LfTmCwBm4sYvO5+p7NCm8kvJZTXFnkFT++Qi1zQzmdMU/777RG7w4PNfVJnV2chKQQ8Mis5SPSXpvGG/yl1LvUCzkQyABjBvw==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: o3r4s3EEywSAeiQrtS7txZyigxMvw/t+Acz8rGkiTUZufpzeN1eyORT2aA2ZxfBSWkhNVFhGe1Mm0KY7/f1Q6WV8IJbu2T6cfhR+1N27VG1a+Z+F2SLhPyfATC+3KIPN7gQ3x03RSfg6Y0ZBiaFRGuYbHOYjfpNFqLclbWKULs0Vwn0prKxmGYdHuNIxMY4UG+BacUBajRv9edsutibj0fLA4u2reH4SmKDgCtfAMBCPITCxUUHUtSeo94crLHMAup5PynqeIcHuiGBQnX1mRDGKsiXaYZGSK+3+2TyyRkUG3h1rwBWC0MnQP+amCOHAYPfr/TU+W1ePcNgiSsZ8+s88YbbcKeUTzx1iqqaybcxrMtDUJkOYv9/BC3EDXPixJIYTJ4dpmK9aD1xsCkvZGLL45pkse1dFuQqB8/Xr/iI/1kJImCidiQHyQ59h4U1d
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 05:15:36.2214 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a0a29ee-d8f9-4fca-3651-08df0fc3b666
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E7F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA6PR18MB927500
Received-SPF: pass client-ip=2a01:111:f403:c112::7;
 envelope-from=kchiu@axiado.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
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

Since ax3000-boards is bound with Ax3000 SoC, we don't need to have a
pointer in struct for SoC type

This patch remove pointer soc from Ax3000MachineState and create instance
in init() directly

Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
---
 hw/arm/ax3000-boards.c         | 10 +++++-----
 include/hw/arm/axiado-boards.h |  1 -
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/arm/ax3000-boards.c b/hw/arm/ax3000-boards.c
index 75e0aedb4d..3ca4a6f93a 100644
--- a/hw/arm/ax3000-boards.c
+++ b/hw/arm/ax3000-boards.c
@@ -68,7 +68,7 @@ static struct arm_boot_info ax3000_binfo = {
 
 static void ax3000_machine_init(MachineState *machine)
 {
-    Ax3000MachineState *ams = AX3000_MACHINE(machine);
+    Ax3000SoCState *s;
 
     if (machine->ram_size != AX3000_DRAM_SIZE) {
         g_autofree char *size_str = size_to_str(AX3000_DRAM_SIZE);
@@ -77,12 +77,12 @@ static void ax3000_machine_init(MachineState *machine)
         exit(1);
     }
 
-    ams->soc = AX3000_SOC(object_new(TYPE_AX3000_SOC));
-    object_property_add_child(OBJECT(machine), "soc", OBJECT(ams->soc));
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(ams->soc), &error_fatal);
+    s = AX3000_SOC(object_new_with_props(TYPE_AX3000_SOC, OBJECT(machine),
+                                         "soc", &error_fatal, NULL));
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(s), &error_fatal);
 
     ax3000_binfo.ram_size = machine->ram_size;
-    arm_load_kernel(&ams->soc->cpu[0], machine, &ax3000_binfo);
+    arm_load_kernel(&s->cpu[0], machine, &ax3000_binfo);
 }
 
 static void ax3000_machine_class_init(ObjectClass *oc, const void *data)
diff --git a/include/hw/arm/axiado-boards.h b/include/hw/arm/axiado-boards.h
index 4a632661e1..566f22cd96 100644
--- a/include/hw/arm/axiado-boards.h
+++ b/include/hw/arm/axiado-boards.h
@@ -18,7 +18,6 @@ OBJECT_DECLARE_TYPE(Ax3000MachineState, Ax3000MachineClass, AX3000_MACHINE)
 typedef struct Ax3000MachineState {
     MachineState parent;
 
-    Ax3000SoCState *soc;
 } Ax3000MachineState;
 
 typedef struct Ax3000MachineClass {
-- 
2.34.1


