Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F9D60A260C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=axiado.com header.i=@axiado.com header.a=rsa-sha256 header.s=selector1 header.b=ckgzZ949
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTwM2-0003Eb-T1; Thu, 19 Nov 2026 02:14:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1xTwLX-00030V-AA; Thu, 19 Nov 2026 02:14:16 -0500
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1xTwLS-0004Kb-2A; Thu, 19 Nov 2026 02:14:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F4iy7lGtCbKMklMnl1hDtFMcboxhT1XhUfb0BsiW/zkVzdv6WikgL2k28eO0FfJPza4wnp+2CVZdkZmQ6OkIzAX1UZXgRxId8VooTgm9o/v2JUT5/d+iunpgucrWSSzl2MStVDEeFQekk0LUdDIbUfD5E9n0SfvJ5uFpSMZQMqfU2rm5/kWCA/mbp4Civni0earou0+gh5CzFFHEsWCwcb9jBl0sv4JetfmFErk2TJbR/aJCTjkS9ZuX/TDYJ8VMAao27ELO1HgRC94KmcnjxyVSm3tf4JdhFiuvje37cRxK09gCyZ8mhXxS+ddcP7MW4/Qqylj++BqEWu/zrcAZjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qp4FsZQldTPJ56k2UKg7NuqJserkWdPewaNA4ZdY1dk=;
 b=OhaLNsUFXgi3K4jVEWmB4Cf51u43A7iajr0EtgwlJLQdTKCY5c4zPxNZikKPtmjLIhrWxWIhSVuwalSDyeTj+3YOcku1XCsuCVr63uCNaaMX8LLWUhV5hehFMa4atn5XBnbYtmyW5PZdYduEaeD1thU95XqNJa6wm/MSfb9sPBIDr7PPxFUJF33wAYsgNrBNhei/KunfNZiLl1/4e84oypC/7LId0HpiXC8ijSSjaokHh8mKald03OjicpeZidHzCcAMNoCUvuyHh2/TMXCGuiYG83tXiICfHwhkR/m2rZstfb8jC8diIxaF4hybyRUmjkO6WYOsNZdSOY/eG9G14w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qp4FsZQldTPJ56k2UKg7NuqJserkWdPewaNA4ZdY1dk=;
 b=ckgzZ949Ijs62W88OzXijwr7CjRoNo7timue0gNAwdF2ZUYlMydITXOO87s8safLv2BgkXDgPdCL6dnSltY9uq/cla/Kb196ACiatgjHgiUjtZdXSVwT/Pb256chHzqvV5oRDU+OO4nb860yRQy3qIQSsEcxDxekL8Vmg4pWe3PT8IvyXTZ8DjgKsur8mWfS/gkKIvWY5u4uAfHF3W6XlGpBGb0T1SCJJg0s5dMxSbH4uCgHCyWHcjMRfiPbvG4jFrIv3uhWrN2ZrShqeVVG7ww1Z/cBfoxAJyphS3UYI7FhHSRvEU6JzTi0GMxuzZjnvXTM1N/PEQgLWk3v6zh2oA==
Received: from PH8P222CA0022.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:2d7::33)
 by CHAPR18MB927685.namprd18.prod.outlook.com (2603:10b6:610:2f3::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 07:14:02 +0000
Received: from CY8PEPF0000005C.namprd21.prod.outlook.com
 (2603:10b6:510:2d7:cafe::15) by PH8P222CA0022.outlook.office365.com
 (2603:10b6:510:2d7::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Thu,
 19 Nov 2026 07:14:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 CY8PEPF0000005C.mail.protection.outlook.com (10.167.247.26) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.0
 via Frontend Transport; Thu, 19 Nov 2026 07:14:01 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 65CC140BFE10;
 Wed, 18 Nov 2026 23:13:59 -0800 (PST)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: 
Cc: Kuan-Jui Chiu <kchiu@axiado.com>, mark.caveayland@nutanix.com,
 philmd@oss.qualcomm.com, 163wangjack@gmail.com, peter.maydell@linaro.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v8 06/13] hw/arm/ax3000-boards: Add memory guard
Date: Wed, 18 Nov 2026 23:13:46 -0800
Message-Id: <20261119071355.3520249-7-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261119071355.3520249-1-kchiu@axiado.com>
References: <20261119071355.3520249-1-kchiu@axiado.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PEPF0000005C:EE_|CHAPR18MB927685:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 211e3026-7666-4dcd-5450-08df460cafd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|22082099003|18002099003|261009223027099003|56012099006|261026121527099003|261102123227099003|10067099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: Kmz8RWbBg8ymdB/lFOagd4evwBH/p/lbN8ppnVpuMokrAcZTl11Tz5mFnoey4WDlGetkCwRryXMNmnlmbmvAMAcP+mzmLTC1MvalGB8KbxKL+2GkGztpFEANbKAdAYRDw2prBbh+ZRY0k4kVXLJG3vfbLhLAeA7YYJidEnCQChAgiOCIq5uDQGbqadKDufzqhT7csJrHSPw9wx+pIpBtN+ZKgCTu1/uVVzWi/XR/a6iEq1BZ6/IQ6oT5IRmSkoOh/zag5zanNUMagbZdkSXZp8THAtwMrz0IkTDFcUQaMvRZakWOdvO26OccM3VDS+evJjFgmkyufZF5htygOJFyJJNiMO5HKUflKjzhQLBWyi04LEx2fGzNnZOtGHHztIrGpHS0+EVcTOCvkwZev/0XF7/zYcGbskndwTeaV9EM9qWCv3vCHx/yqgyRr8PyNsmosOUKPBxv0CLIhwhPTpt1D3M5Ed9fNxK82w6dpqLdG9HqMVD2QWqIQpMvZQMNYKJ/GG+UtFQqbG+jaYRrXv2AzsSgETC3BTyTcdv4XV95oeMexsaRIjAkfw3g/TC+94Rj+N7bX2MsoCgbGbPQMOkatzl/B28SxZIso6P0jptDg6CSeraEWNIBrFAvVqtRfzA0Vj5XjAlxB019gAbf4P7Phtw0BdebxCkpuX+qhR9qHUyIcjG7UpaTV943tr1UEdDQBw8tCSpJzUvl95ZfycaK3A==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(261009223027099003)(56012099006)(261026121527099003)(261102123227099003)(10067099003)(261021121427099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VCCu81GavEM8VWKnOAKYa6LSdKfKkZ7ZbWzMxZWBoNNrOzRpM1NKiI/YzwPB++1oZPoXEXmYU97hw/88NZ8HOU1B6JFdhHHzfjjqYjWOApnDQKU3HaeDQCfZG6QNNg4Ey+jAoDcy85wTgapH0AyDnavK3WN27ZpfsHxpyr6Us5bKM/8E2xXcDTE35l6EetukNyyUS9Lvb9O720oA8JD8Ee9iO6dWBHPnnAt8gdqO2k+VpepB9ZNWe+9mqIvVG3JxevqPtSU0KFYU9tWXUAqpobBPZG0/4TOu3mHVZsoKpTmGGt5Gu8AGgoBMFJRhUusaauucc9Q79aofXB6lbNPT8gJWIGAQ2yoMgzWNFR8wYCCywpeENrWvEPCvlv4ykMeahj4R8f3xXvlTNIlsQKEAUELH5e7PwEovIkyjjUllw1y2Eh6CR4dnqEESaMLxUh9p
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 07:14:01.1816 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 211e3026-7666-4dcd-5450-08df460cafd9
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: CY8PEPF0000005C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR18MB927685
Received-SPF: pass client-ip=2a01:111:f403:c10c::1;
 envelope-from=kchiu@axiado.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Ax3000 SoC reserves 3136 MiB memory for access totally
QEMU allows -m option to set the ram_size which would cause the
inconsistent size issue while running in QMP

This patch adds a guard to check if ram_size is different from RAM size
of SoC and setup the default_ram_size

Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
---
 hw/arm/ax3000-boards.c      | 9 +++++++++
 include/hw/arm/ax3000-soc.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/hw/arm/ax3000-boards.c b/hw/arm/ax3000-boards.c
index b3ee6c4a69..bc1f818d74 100644
--- a/hw/arm/ax3000-boards.c
+++ b/hw/arm/ax3000-boards.c
@@ -9,6 +9,7 @@
 #include "qemu/osdep.h"
 #include "hw/arm/axiado-boards.h"
 #include "hw/arm/boot.h"
+#include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "qom/object.h"
 
@@ -21,6 +22,13 @@ static void ax3000_machine_init(MachineState *machine)
 {
     Ax3000MachineState *ams = AX3000_MACHINE(machine);
 
+    if (machine->ram_size != AX3000_DRAM_SIZE) {
+        g_autofree char *size_str = size_to_str(AX3000_DRAM_SIZE);
+
+        error_report("Invalid RAM size, should be %s", size_str);
+        exit(1);
+    }
+
     ams->soc = AX3000_SOC(object_new(TYPE_AX3000_SOC));
     object_property_add_child(OBJECT(machine), "soc", OBJECT(ams->soc));
     sysbus_realize_and_unref(SYS_BUS_DEVICE(ams->soc), &error_fatal);
@@ -38,6 +46,7 @@ static void ax3000_machine_class_init(ObjectClass *oc, const void *data)
     mc->min_cpus = AX3000_NUM_CPUS;
     mc->max_cpus = AX3000_NUM_CPUS;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a53");
+    mc->default_ram_size = AX3000_DRAM_SIZE;
 }
 
 static const TypeInfo ax3000_machine_types[] = {
diff --git a/include/hw/arm/ax3000-soc.h b/include/hw/arm/ax3000-soc.h
index 344fcb6f3c..4987ee3834 100644
--- a/include/hw/arm/ax3000-soc.h
+++ b/include/hw/arm/ax3000-soc.h
@@ -25,6 +25,7 @@ OBJECT_DECLARE_TYPE(Ax3000SoCState, Ax3000SoCClass, AX3000_SOC)
 #define AX3000_DRAM0_SIZE       (1088 * MiB)
 #define AX3000_DRAM1_BASE       0x400000000
 #define AX3000_DRAM1_SIZE       (2 * GiB)
+#define AX3000_DRAM_SIZE        (AX3000_DRAM0_SIZE + AX3000_DRAM1_SIZE)
 
 #define AX3000_GIC_DIST_BASE    0x80300000
 #define AX3000_GIC_DIST_SIZE    (64 * KiB)
-- 
2.34.1


