Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 325D5CCF9FE
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 10:54:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEmlR-0003yD-3Q; Fri, 31 Oct 2025 06:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmlJ-0003gj-20; Fri, 31 Oct 2025 06:53:42 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmlE-0002wB-3U; Fri, 31 Oct 2025 06:53:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E0qojKM2LYM32No/iCoTGzMei4YVriOatxAXNQCY7wiSAs7a8uD9eEiNROBnSzDRL2q35/tAdkv6sME3FVdgeDiNbBQKPDV6S4++D4RKyx82EO94kyfotqKcHeTMrY61bfHspPC1NERVlWlPNUPdD2GnT/EFg/KYU8kd4j+RQkbuRiDNZqQwv9U5qmyhViFxWDw9UTeOZbr/06NpIK9gTaQtNrHTMKC2JtvPzqvgWyltFC9nQiQuG71v11nr1TaKMNdUe80yqa63LiswV+PiOa0hsGplnvErP5Dt9Tu5+wnG52oXU1kaWOGSgHlN+t3YWCIrA+pxZcP4AZwJ5z9LjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lxow5QtR7bNSCwuDfC+nol8YZsHsPfzG0o52XW2VBB4=;
 b=obGBGrtXRXNRq/1PQhL5+PU0OM+7hH0zw+N4m+Ozskz2WaGLsaGnmu1XaqIold5RMJ2boHMb76TqX10fQEOUo3eFQUzBOUupttlRh8T4u3cD08RqkgyTsg7OFLBg4y3lINjSaQSMrVkdCg7Bkr5YVUf2N5cieRKnD8s0W3Q5o2oB0egxihWoujm3Z5QvgQO4MxL/uTONLMcnSATzcASuc+jkGQ4LkuTMWdr+xBEBYqecT1i03j0RQHRXjNSNOeaPl3OX9QDHD6nw0YT2r5VSstbl6oXQCZIHUGgJiTiqNwmxzUAOgCOXBjD7Oe0SVYaGeWR3JyJSybhOrHxBSIilVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lxow5QtR7bNSCwuDfC+nol8YZsHsPfzG0o52XW2VBB4=;
 b=Nng9WVi/KEUf1mhPOlO062RFjwJw9ibFiL6LGMqLGWLXElKDFZ1JqigwLTvf4rga0ChMuk2Ai/VxoTFKiQsmRMtlVCfdV8+nSbjGewApa8Iuwcd/6d64rwEVvgQWX0Jx1wKLeVc0VRfmz6+CbX+9TNArD/6xKBP5fjEIXH4SIUUJm5SsM4eD4cjSzXxV7jiLWcAs+dzazq8K+HCE0ipufG3pmRTQARa80tknBcyJVU3EcBOruwyxPl6Xn74Mg4Z4niWLpgcmUGtY9JeVbDPS2qzrDjU6gBOMjSPwE7nGKGmwoRViIf5m6QwpQ+mOTNQ8CY5rIsF+r/nCJMlKcPT2Rw==
Received: from BY5PR03CA0001.namprd03.prod.outlook.com (2603:10b6:a03:1e0::11)
 by DS7PR12MB6213.namprd12.prod.outlook.com (2603:10b6:8:97::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 10:53:20 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::bf) by BY5PR03CA0001.outlook.office365.com
 (2603:10b6:a03:1e0::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 10:53:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 10:53:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 31 Oct
 2025 03:53:08 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 03:53:04 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v5 07/32] hw/pci/pci: Move pci_init_bus_master() after adding
 device to bus
Date: Fri, 31 Oct 2025 10:49:40 +0000
Message-ID: <20251031105005.24618-8-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031105005.24618-1-skolothumtho@nvidia.com>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|DS7PR12MB6213:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ec5d7de-0f4b-4710-ef3d-08de186bb43d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|7416014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DwPwjPHjoiwkhuQg5t6mLf3CoXjKze9MAqdbH0ZGn0RSaGMqhIlR560aGDOT?=
 =?us-ascii?Q?J5InWe+TIPVLUee4DfTSV2auAMOsYjFv35pNDYWwhLMWhmApIOoX87ufHFTu?=
 =?us-ascii?Q?6HNoHsG9hCSrIx0ywjRBcO5+dBoAXzHvJYJoY8dMFhfAGXX3WojOPk8hEOMi?=
 =?us-ascii?Q?5K7Dd4GuAEpw6lv9b0thO9r74xPhU5rnMWdnkTZvnc7mrdayxgBNuRrmIyQ3?=
 =?us-ascii?Q?iJGQ0BDLzm/vs7oeOYo6Zo1zJ6wZg5EJOV21bWH+9HGAgRGdUbMbrhiY3M7N?=
 =?us-ascii?Q?a36QUD2HWui0rohQs2WlRf+TYaOAlFoYNXSN0ry1tElZpWgWsNbjcmkOI5eD?=
 =?us-ascii?Q?5YNtsApAZL/avknirV8Nhh+6KbdTUSoCDnTIMK7shEEuDznU7nAgIqS21WVP?=
 =?us-ascii?Q?QNMbHjG1znIiSJDmPSJnGckFhfWIVD7hGwsI/vSos4/LswLSI2RIdVvKZum8?=
 =?us-ascii?Q?qeOtFPmfS5zMqsLLIc5rP3lmPolpZIy9C1sqZ0hD+YAY4LX0r+gp2Q+PhhCV?=
 =?us-ascii?Q?2Sq0X4KiG/LdUv8XHGb3M2LMZhObcUli43DlWYh/pCv+LiVps/PGG22IxsGE?=
 =?us-ascii?Q?SECzT6Tb2sszZVghI9vSRhMcVCsb2wWXXfKsmTdAT54ZrP7jrShei+I0dO5+?=
 =?us-ascii?Q?dHO88nLoJByRq6qxw8Dq0+lohv7li0ex0XS9YzaWiiSdtpXMf5+hxChruNtX?=
 =?us-ascii?Q?LFg4CBwRIDxMrTsq5stZX5MVQytoTiWO/2eHgmijDKBmonGRdC49HuhBoUz2?=
 =?us-ascii?Q?pUuATNGApbQhj2smUuxw8ttexs7n8RTDr6CUoWryaDbP9QuS8Qlgj5isPxXN?=
 =?us-ascii?Q?g7lJme/d5tTMDLdOEhfASxIIwmuqSI2Smz91Ja2iwmIYFync33GJZPlyKJdy?=
 =?us-ascii?Q?3YeMxWWIcNr/IogrUgPuVw9FDwNKS7YXqpsBmhlXAeqynTneFv1TLM51iivH?=
 =?us-ascii?Q?2FG5qG+Jm3kSQDpg6XB25K3geOWZSSOGkWbCUpMpiJWYbcxdDLkCHmatNPB3?=
 =?us-ascii?Q?rXyq4rK4Tji4mWo8HHSwt2UtTIUmLTGLzDYZq8449P5yOdP/ENmtN7xrOaO5?=
 =?us-ascii?Q?UJyU+VfhqwZukAjbYeq663I+a760NtD/Iqd0rHOrHyGNFJqKVcvtJG0RzOmZ?=
 =?us-ascii?Q?mZWwrLFeDR819+0AGx5bNHCihFq5+h1nelwrvad/LzYLJGdHQ7Tkdx1ZWADh?=
 =?us-ascii?Q?4F/RRCcYMn684TrOCUzOdfEELdf4R3UcRSel+XXVR2i7rfpgL8w0aZqtEFJj?=
 =?us-ascii?Q?KjVeyL6GJSPZ+xWt97F35BEYkzYUTaOb/sWMKF779Un+hWVmcin5kkkf1GIb?=
 =?us-ascii?Q?tK/pC3R2hPB4XN4PgQHu9Tm6IW9RiGqC/D79HzC0x1eypWmOusfYdS/C9Pvq?=
 =?us-ascii?Q?k+7WnpOacRk6c+7Ya/DrPIYj46bKY6MIsNWS3UvHOeJVq955JRjmVwR80ccN?=
 =?us-ascii?Q?KaGQIhIhfLXwicwkVW5wTC3J/Hg8CPkClJpMgTh55VzwM+nGTEQMRQ5aGWJJ?=
 =?us-ascii?Q?IVa3ypRcXStbWCWDjLuj9kQHvWZtttdFn8GKeioXf/I46tsm9eNG/M3CN/Lc?=
 =?us-ascii?Q?OmvOMC62ir7k65HYv6o=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 10:53:19.6339 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ec5d7de-0f4b-4710-ef3d-08de186bb43d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6213
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

During PCI hotplug, in do_pci_register_device(), pci_init_bus_master()
is called before storing the pci_dev pointer in bus->devices[devfn].

This causes a problem if pci_init_bus_master() (via its
get_address_space() callback) attempts to retrieve the device using
pci_find_device(), since the PCI device is not yet visible on the bus.

Fix this by moving the pci_init_bus_master() call to after the device
has been added to bus->devices[devfn].

This prepares for a subsequent patch where the accel SMMUv3
get_address_space() callback retrieves the pci_dev to identify the
attached device type.

No functional change intended.

Cc: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/pci/pci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index c9932c87e3..9693d7f10c 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1370,9 +1370,6 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
     pci_dev->bus_master_as.max_bounce_buffer_size =
         pci_dev->max_bounce_buffer_size;
 
-    if (phase_check(PHASE_MACHINE_READY)) {
-        pci_init_bus_master(pci_dev);
-    }
     pci_dev->irq_state = 0;
     pci_config_alloc(pci_dev);
 
@@ -1416,6 +1413,9 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
     pci_dev->config_write = config_write;
     bus->devices[devfn] = pci_dev;
     pci_dev->version_id = 2; /* Current pci device vmstate version */
+    if (phase_check(PHASE_MACHINE_READY)) {
+        pci_init_bus_master(pci_dev);
+    }
     return pci_dev;
 }
 
-- 
2.43.0


