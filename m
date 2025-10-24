Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB13CCD1A5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 08:47:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCDRs-0007bN-NO; Fri, 24 Oct 2025 04:47:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vCDRW-0006tk-S8; Fri, 24 Oct 2025 04:46:44 -0400
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vCDRT-0006pt-Sy; Fri, 24 Oct 2025 04:46:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s+BdsvlGhbIz1BofAfTapqGJfucwjXa7LV8frbR2dyRKRws6ESErc1Z7lv97uQTe4zJxwtE1w68SijZlPOJU5o6UXDTWvxm7SLuqM9xzpDwpMrCe7LwRXpn4NtIcnI3fwFdj5b6MUHORX65XIZ0GuqTK1LGU4t8fFkVoSR/splNCjTIVWtRko2c+YGv/uosDkRfhYkyKf7sHG9Y5gkTNAAYp2yTpapP7OD1/5YCKBhZrQTgXId0CmRN1qc7+hV3loWw0683WwnqnJtnWGJmHHBRbCRJChnlUHOThImPg3us/HfNO4OMaqIhijuTvlev84KWmmqbI2T7iRwoSSH43JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TAITzpvevrTbO6jaKcE0muCh/s09+Nbx6Ga9bQSYroM=;
 b=P/RZfG9W/GuXmD/X8NMPjzLostKExMPqC9whNzByTFRZV6Zr/NnMN/mFJF60u46OJ0UGAs30fqbaYI45QQr6n3IeD6O/b7TKGgnEwqsPBzAcE0RoJybXgmLuRhjIn8HbetqFq2OcQNyizd++ONSKZIqSp9FzVMihsFEZ8/m/Xe0C85pxJmjJZDppV9PS7iQMYmYGy8lPTjnt3pdc57RIHr5Ggx4InotIBbvqPxyAxeQOe1YlUb1FtWRdlbXvYC7bgn0AjQMRlbcVSOmG4KJ78SmCG/C8//yxe3ezOIVizrWgE4VxTvsuFQBojsVLomgwa+edEpFP6kGXrfVTev7yyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAITzpvevrTbO6jaKcE0muCh/s09+Nbx6Ga9bQSYroM=;
 b=EWDDFSj87qUxjwqxiJ/oSoYB6rAUanzRIX2IojQP04UtxBn7p+qI0efHcmQaovdcyaOsE08k4/7YBdraLBkdLkIN7xUKujJqXMQwK91hotH80dJ0VtqUIIh0fPXe8T7hql6Q8vkY7WoJYs5BSWei4l17MFKg8VxhqJRsLih9t1h8bbvqXHkRef/sH4ekhVHddagkcRin0MVm+hMzJfAQvP6/1AjTeyf8bFf7pkg7TqJgWAscvodjWe6OGEnomIUzuvCL6ZTgxGKhr7dWYXNejQrHXJ80Eo7LI6mtmEmF20LGGjh6lTyrFRZfFqOj1UAwBmOhbVfJ2xi+v9RYu+pWpQ==
Received: from MN0P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::20)
 by IA1PR12MB9064.namprd12.prod.outlook.com (2603:10b6:208:3a8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Fri, 24 Oct
 2025 08:46:26 +0000
Received: from BL02EPF0002992B.namprd02.prod.outlook.com
 (2603:10b6:208:52e:cafe::34) by MN0P220CA0010.outlook.office365.com
 (2603:10b6:208:52e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Fri,
 24 Oct 2025 08:46:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0002992B.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 24 Oct 2025 08:46:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Fri, 24 Oct
 2025 01:46:10 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Oct
 2025 01:46:07 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jonathan.cameron@huawei.com>
Subject: [PATCH v2] docs/system/arm/virt: Document user-creatable SMMUv3
Date: Fri, 24 Oct 2025 09:43:43 +0100
Message-ID: <20251024084350.252702-1-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992B:EE_|IA1PR12MB9064:EE_
X-MS-Office365-Filtering-Correlation-Id: f3f36a74-7b0a-423f-49ac-08de12d9d18b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bFhzMzVmQTQ4WTNhd09hTUxRRVVjcXNONHhvYzZOVUFNb0ZDYWxXVTV2VzdW?=
 =?utf-8?B?WDFpTnhhbHhqMmxiK2h0VWhPeUpCTDFiaVNDZW9jVnBQMDMxTXdQQW5EZDdR?=
 =?utf-8?B?ZTRVS2l3WGhscnRSUWRObC9MMGpuZ2tqOE1abHU5UVJpM0x3UTJxL0Vva3M5?=
 =?utf-8?B?Q1NvOGxQNWVBUGFpZ2xFUDV3NUNJazNVMDBYZWJiSmczNTBHR2JIbFlCTXlD?=
 =?utf-8?B?eGpKUDFqbCtLL203UWM1bHNCRWRXdFVrRVRMSmRsMkR4dTZVRUZpRFN6MllD?=
 =?utf-8?B?eEhYc1Z1aFZzb2FreEtPTkdpTVVDR0JyK2tOM2ZuT3UzQnl4d0lpeWVZbDBG?=
 =?utf-8?B?R2Rmc3o0YTgxZk5pazNDWEZKZVhJb2dxWmxMNGs3UWdBWlZVRk5MNEk2bTl2?=
 =?utf-8?B?Vy8vemFwWHllNDBubEc0L3BBL1JMYWxkNTMzK241K2k2UmppUTJTL25saEpJ?=
 =?utf-8?B?aEhnSkJkK0IrdVd3S0lJRVFTbndJbTQzTzREclpsYWRLdzNiMExyWjdsV01M?=
 =?utf-8?B?OTNKNVJVdlhzRFRraFBwV01PYUYveEk4MnNwbkxxZGJ1VWdqcXAvM1l6K09Y?=
 =?utf-8?B?a1lXWndVZXZOQS9qbzdJc0wzYk9JajR0UGRsSUhWSlhHNTZIM1c2WUpHcHNF?=
 =?utf-8?B?V0FxWDNZV2l1RDhTME03cjZJREl3NXpvM00xeDNIZktnL3BRREZEUWx1dmVp?=
 =?utf-8?B?ZDE3bmhScytJdG5LNThVRjg1cFJUemIzR1hDejFaNS9Db2tQUC9GclJtTUI3?=
 =?utf-8?B?QVJwNXhhY2tucnBtTkhpYUxVTjR6eXhhc2lFbkhwc2Y2WUJncUdzTWpOVEY2?=
 =?utf-8?B?SFVZRjhwallvbFZEVXJ1RXZaR2wweFJUblFTdENmd2JDMUxNZkVTa2JVU28z?=
 =?utf-8?B?a0dKRUZHemp6akFEbWxkZ3RJUmxWQ25sbTRzZzhkTDBjdzZIMVcwT2NBMkU4?=
 =?utf-8?B?UXd3dkwvaTBTVmxJNTA0c2RhZWpXckQ0SmlHZG5Ma3hndXNWdkRVZTlMUVR4?=
 =?utf-8?B?ejI0NjhOdU5ZL3dGclZzTDgxcmpqNFlBOENUUVVOU2UvcERWK3RRaFlVM09w?=
 =?utf-8?B?aG00c3l6SGFNZ1RQRjE3cFhBbThsVUprMGh4dVNDZFVVRUQydEthY1lrcFYy?=
 =?utf-8?B?OWxUVHJkajF5VFNCbGI0SHJjb2ZhNGhJc1RHTU5nSWRYaHJXSnJieVB4bHBU?=
 =?utf-8?B?VDBvVDNmZm4zV0xLZy9KRXA3MWpkQXpMTDZTcDlNSjU2QjhVdlF0ZnB6MGhs?=
 =?utf-8?B?TWd0UzNwNm5ZM1dCNUVjem01YXNJVUJOckJMblpneHgyMFVra1lzOG5aRjJq?=
 =?utf-8?B?MlFteHF0NXo4blFiQ1pIdGZqekU1cHRMZ3ovQnZrTWNkTHRyYzZpS3dQaXNB?=
 =?utf-8?B?UGNLMlo0Z3R4Z1B1Y3VUSXEvUzA1ekpsTmxJT1JUU25qbGZWajFodmZxbCtT?=
 =?utf-8?B?UlBGMTk0TEFZaUZ6UFoyNVB4Smc1Mzc0OExWbzdzU21Fb0tzZjhQbFNVbFV0?=
 =?utf-8?B?YUJXR2pXaWh0S3JkVVFiSk1UWUVhaGNvMVR1dUtQeGxLT0NaRTlUN3liWkg3?=
 =?utf-8?B?cm1Na3d3RzN1ZXBRRVd0MktYSFlheHF1UEZ4dGx4Qk5nNDAwM2pvQzE4NTEz?=
 =?utf-8?B?S1JYK0NyNHlxbmFqYkF5SmwwVW9tSHlwaG16L0xZRnIwdkY5dlBvTGtwWkpq?=
 =?utf-8?B?TTNBd21xTUNjVVJGRG9xRTdSZytBd2hxaTlQdmhTZ213bml0SmpCM2IxS09a?=
 =?utf-8?B?Tm5PNjNhaVFka0duc0xRWkNYeFE4YWhncWhhb2tjeW9hOW80OVMwalllbVVJ?=
 =?utf-8?B?eGl6R1dOQmhVSGJuQzJoQUhOdnZlcGowQk13MytVRGFiT2wwbnVpZlhLNXZD?=
 =?utf-8?B?d2E2a2kvSGh1ZWpMaWErbmRqRlkxbEtwQW9FZ2ZZUjd3ZG9RNzJXN0RJRWFp?=
 =?utf-8?B?dHh0aks4dDlGUHFpalpXV0hZTUJ1QVFGeWJoU2lWUUNoUGVSaEdOQzNjWmU3?=
 =?utf-8?B?MFlZRFNwUEIzcWQxb3dmTGJRbnhhSGMzdUEzeks4MjN1UDdmakdJRnVYNWsr?=
 =?utf-8?B?MXVGTGVlcUpqMlpSN3NzWitNT0xWaGZHeWVzQ3c2VDFVTkxXdDNsUTUwNG4w?=
 =?utf-8?Q?D0kI=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 08:46:26.4166 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3f36a74-7b0a-423f-49ac-08de12d9d18b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9064
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001, SPF_NONE=0.001,
 WEIRD_QUOTING=0.001 autolearn=no autolearn_force=no
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

The virt machine now supports creating multiple SMMUv3 instances, each
associated with a separate PCIe root complex.

Update the documentation with an example.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 Addressed feedback from v1.(Thanks!).
 https://lore.kernel.org/qemu-devel/20251006182900.100580-1-skolothumtho@nvidia.com/
---
 docs/system/arm/virt.rst | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index 10cbffc8a7..339aa99ae1 100644
--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -37,7 +37,8 @@ The virt board supports:
 - An RTC
 - The fw_cfg device that allows a guest to obtain data from QEMU
 - A PL061 GPIO controller
-- An optional SMMUv3 IOMMU
+- An optional machine-wide SMMUv3 IOMMU
+- User-creatable SMMUv3 devices (see below for example)
 - hotpluggable DIMMs
 - hotpluggable NVDIMMs
 - An MSI controller (GICv2M or ITS). GICv2M is selected by default along
@@ -176,7 +177,7 @@ iommu
   ``none``
     Don't create an IOMMU (the default)
   ``smmuv3``
-    Create an SMMUv3
+    Create a machine-wide SMMUv3.
 
 default-bus-bypass-iommu
   Set ``on``/``off`` to enable/disable `bypass_iommu
@@ -219,6 +220,35 @@ x-oem-table-id
   Set string (up to 8 bytes) to override the default value of field OEM Table ID
   in ACPI table header.
 
+SMMU configuration
+""""""""""""""""""
+
+Machine-wide SMMUv3 IOMMU
+  See the machine-specific ``iommu`` option above. This allows specifying
+  a single, machine-wide SMMUv3 instance that applies to all devices in
+  the PCIe topology.
+
+  For information about selectively bypassing devices, refer to
+  ``docs/bypass-iommu.txt``.
+
+User-creatable SMMUv3 devices
+  Allows creating multiple user-defined SMMUv3 devices, each associated
+  with a separate PCIe root complex. This is only permitted if the
+  machine-wide SMMUv3 (``iommu=smmuv3``) option is not used.
+
+  This model is useful when you want to mirror a host configuration where
+  each NUMA node typically has its own SMMU, allowing the VM topology to
+  align more closely with the host’s hardware layout. Supporting multiple
+  SMMUv3 instances is also a prerequisite for future accelerated SMMUv3
+  support.
+
+  Example::
+
+      -device arm-smmuv3,primary-bus=pcie.0,id=smmuv3.0
+      ...
+      -device pxb-pcie,id=pcie.1,numa_node=1
+      -device arm-smmuv3,primary-bus=pcie.1,id=smmuv3.1
+
 Linux guest kernel configuration
 """"""""""""""""""""""""""""""""
 
-- 
2.43.0


