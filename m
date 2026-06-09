Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F9FCCD8CBD
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 11:29:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWudF-0007aY-Ce; Tue, 09 Jun 2026 07:28:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWuci-0006eH-Th; Tue, 09 Jun 2026 07:28:02 -0400
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWucd-00031s-Gf; Tue, 09 Jun 2026 07:27:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r4QrEKm/xnDOhUezXQY8x6mfLTBKytafBA81yGZtza/wm9nNh/5UatVzwKrcWrc94YDhAO1Hv8SZt/QplJbhWl5WtrUjaUeygoGaeWxhI1G/fzw+gOual0Zdd3GP69jH72yEb9uPh4nTgxaSg015FG5dO+WQ4cVw++xqnxw8UOvQzP3kejQFAQoUkI0iDex2fmVs6aSmIqhWPF3G2HAvrFXP9KmlQl0FF6VbBgqG4CW2Fi+dSWf7ntUCvni+DdNs16QbOb9RATQsx1bFNwvWyncSan0dreMtwrU67XNNLhQ7f4tdrCeJ7W+R4ZLcfJsv1CdlDwpjg8u1oT+fdbTFkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a1/9638cUCwB3XKUK4Uxt2dROh8uiZfvCir66r/gde4=;
 b=uGQV4KrYsdPVeZSvigebIEyFHATxmv4uQTEnFwrb2shh1HPK90I5hQbD4dM6bcq1i62sheB3yO/i4WFz/PwsrFD3fgFVamEJ2VI0LG8EXCmW4cvb3dGOnUs2KQpLci8yFLF68TdFe2U9FmolxSg24FNuvJNqA7p3YECVt7/e4XqBTQAJRIWqrKnxSVnWyjgf4YvCSHdFoaXn2/6+GnSUy9GjtvNHr3xaDw8b2YzQIbZlI/tolpxcP2qFqtyHXn7Jnp6hjbE4qmuBuxP9KuBkCZi8+eD6ROZ+wyaxC/y6VWafdyA3XaVSI/qM8lIKZhx8oBKa5cvnnWQ/6Af/cO2o2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a1/9638cUCwB3XKUK4Uxt2dROh8uiZfvCir66r/gde4=;
 b=rld98mnuY1INKWKfjANPqhXJcuqSInRnsopphzCax+QiE6Mc3KacK5m70ncDbKGVg1LtOLKtPoiW1RomwYvHaukVHe6w+UvLB1v5pnCDro9fzp7Qr9EnC5RwbxHBI1glU62+1hAW0KzttT9nOkaLBCubmLM9iCXSbeT+1wTSF4yLbl0rfeXc4ZlkBaUCZup7lK9eTanzBDZJAdA3Sw5uLiuF5qjLJ4N+VdqwsFpZ0La2VAKqZtM659Q1A0VcFHcjyHmwYfboCh2opB+pzH4anbwvNeKRhDmExqvEsQpSJZKoMjevkXgp9VsWDJM7NI0MsWuCv8DONiEu53ohNnldYQ==
Received: from BY1P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::16)
 by DS0PR12MB8342.namprd12.prod.outlook.com (2603:10b6:8:f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 11:27:45 +0000
Received: from MWH0EPF000C6189.namprd02.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::94) by BY1P220CA0021.outlook.office365.com
 (2603:10b6:a03:5c3::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Tue, 9
 Jun 2026 11:27:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000C6189.mail.protection.outlook.com (10.167.249.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 11:27:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 04:27:28 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 04:27:24 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v7 12/31] hw/arm/virt: Link SMMUv3 CMDQV resources to platform
 bus
Date: Tue, 9 Jun 2026 12:25:33 +0100
Message-ID: <20260609112552.378999-13-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609112552.378999-1-skolothumtho@nvidia.com>
References: <20260609112552.378999-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6189:EE_|DS0PR12MB8342:EE_
X-MS-Office365-Filtering-Correlation-Id: ae16c059-9b87-4406-55ff-08dec61a2084
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: NcXnvO5nsQy6gPT0c2YY3ie0MfTEMaiZOWedHiPlHrqc/hE+EbH5VCNWExB4S6mVdiuERnhp/DeArh3PZzvqxOV+gfV0Ii8PrbgGzaexKDRDVWMC7eyhMMIZBzQSgUnnWeESkictXB9Vx56SvcPx8syAVusxGMDEovRiH4G7UsGBeQKRHdUT5roT30ZH0HNINYmfdA+H1pkWGzUISP3Cf/bslAmPzWfcLoHvMWu5A9Jn+k5zS34z8MDUZK186Q5OWtWwmxGDM+2EQ7vwtM3wyDj3F9I2ANOiGIBTnKoBcLtsJ/EY2FNiDsptTV1MeAbdSZbvORk6VDmriYMGElrBCN7s5tDE1Yf0VPwSoAJiwtzaNUA8rlDn67yqw5SYU2srajxhUOc3HDlaNxCHPJDQi7HKCaodLyUYn487EBMrEoscu3SozigGXgA8y/smPS++AD+mNJ4m6GyjZ0ioQ09PISoveB0xFdo6U3GamH6RFWD2oRcfhfJScNqU56Qk8l7UirffKHxGdju53JaPnLLLsRRWPvEV1NZIiRwl0fDG2NRuA+vd3ukuZvqwpjAKnDLSQoEDYYCCunLDy4o16ARrH7aX+MOddniHrh1qn8chUJkp8ihiX073sRa+MJ7zDITeSbEk7wS3y0DkPLfCPA8KmnH/z/1SPy6GiRmVv2jwBALWedcF1U80R69ibd/2/7G4ZyboztYwqJ78T0DDPk+IfmXPBj9nPfsrZcYHBQ5lFQ8=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SUZM1XgAjUHnDJkwywdFL2z87Pj0m89QE+cG8iZ4IyXwKSe3kTDR20DtX3nCq4s+vfYbGl1/+3Hbl1uB88OMFlWRl5SPqyaWI6rQjNaA45ppu9bL/Obq082KTNIVRRU0lmvCAap3HESDyt8P0RevGg4YartZnvluc+UomgEqTqxeSknVGyloZ6RFkNP4YNyj3eBrS65M9wBKnpDN3wMxhU6rNhQuX5Wc/bo/9D0StLtse4M3vnf4zQkADDsyGRKdpgBxhMVzW8QYWRhpRgfiEJ3ihKNoTUYt8L/YpQBR0TsK6hDM8WV/8hb11UEMEIEX149WR4So6Rf/Sg7cy9VwER9m74WmiAbqsGbFc/rQsJp01SSxf1ui86V2EpXdHW643lmW85g3t2Ji1PgDRkc7Ag9Hxuc2ahopNRp31Mx99+3HkO+p+DtpB/zAvZTUjSAC
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 11:27:44.8588 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae16c059-9b87-4406-55ff-08dec61a2084
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6189.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8342
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

SMMUv3 devices with acceleration may enable CMDQV extensions
after device realize. In that case, additional MMIO regions and
IRQ lines may be registered but not yet mapped to the platform bus.

Ensure SMMUv3 device resources are linked to the platform bus
during machine_done().

This is safe to do unconditionally since the platform bus helpers
skip resources that are already mapped.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/virt.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index ac0606fe87..2add7401a1 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2361,6 +2361,25 @@ static void virt_build_smbios(VirtMachineState *vms)
     }
 }
 
+/*
+ * SMMUv3 devices with acceleration may enable CMDQV extensions
+ * after device realize. In that case, additional MMIO regions and
+ * IRQ lines may be registered but not yet mapped to the platform bus.
+ *
+ * Ensure all resources are linked to the platform bus before final
+ * machine setup.
+ */
+
+static void virt_smmuv3_dev_link_cmdqv(VirtMachineState *vms)
+{
+    for (int i = 0; i < vms->smmuv3_devices->len; i++) {
+        DeviceState *dev = g_ptr_array_index(vms->smmuv3_devices, i);
+
+        platform_bus_link_device(PLATFORM_BUS_DEVICE(vms->platform_bus_dev),
+                                 SYS_BUS_DEVICE(dev));
+    }
+}
+
 static
 void virt_machine_done(Notifier *notifier, void *data)
 {
@@ -2377,6 +2396,9 @@ void virt_machine_done(Notifier *notifier, void *data)
     if (vms->cxl_devices_state.is_enabled) {
         cxl_fmws_link_targets(&error_fatal);
     }
+
+    virt_smmuv3_dev_link_cmdqv(vms);
+
     /*
      * If the user provided a dtb, we assume the dynamic sysbus nodes
      * already are integrated there. This corresponds to a use case where
-- 
2.43.0


