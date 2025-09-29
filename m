Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8427CCAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 13:46:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3E92-00043f-7K; Mon, 29 Sep 2025 09:42:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v3E8T-0003W6-Sk; Mon, 29 Sep 2025 09:41:51 -0400
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v3E8K-0003wy-Sz; Mon, 29 Sep 2025 09:41:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M85r9O0vqjk6jG7x+kRtrjRdaoE+sqqe6TtrCTAhEHN+lz+Ectw3EuYnDR05P2/uF1rR54XQBJnj/8cyXHn+D6EkwsemEOt7FGW8+y19tcf9tFSvRLKTt+Wa1YS5+KRRm2V6IsN2h+nMK/ohEZ1R6YRXZDDp2o3JqdjSYu3hcB4cTD2jBVIAXJ2PTEVRXYL49bIj+xJpauQCyK2HOuu65omZqZu5T462tedCOBjkTw9kxLanRQzQcFeZys++GXvA7cOrRFXwjNMlfcTkdr20U9IafQNdcQGWxN56XZLz3wLktHWpUvOanyv4XBMnTA2UqRJYKfQ40b625pkOKrTmPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2fYwpxXQtGQhPvydt+Zj5MthHz5hGuoxsAprreRbJp0=;
 b=UxWsh52Uw/mbOSqb9/0CEoY9bQZ66bhB9sbnCXAA/JiEmwx20tj6O1tIb95d4XJ+IFiFo7J6BL+s/TfUXO/yyLg/LLcFe29otR2bhd/T+atWY+V7B9GzSXF5E6fKE6p67AjnInZ07n/noDUFMnqnM9kUj36XcqJwBIP079KHELAT4DYDZMbuoB/iWmgED1AXzw5gcIpWts8dwUYM47OAOsTcNY9/N3eWisNXIjpGZb7+xRvnXltE0YCRkb0Lo267ThJ7WITm/JC+3QbJjH/WLj3NTbryCdky0c2NYkRk15De6+1kwM1NhLp0w0IO8pSd5eAdOhAxmwpHbTNnb+AzIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fYwpxXQtGQhPvydt+Zj5MthHz5hGuoxsAprreRbJp0=;
 b=Bvlj0G7ggZgJuS+MQISAYpDDGmNWz8F9zEi1ZuMxjhu2QjFSahdVaV2u+hkkurJ9UiZw/dQOVyZ95CbgmeWG+z/ZlqFLySknuSgSuyNgVLinlce+25tyjjPGq1oPh7iHbCzEK4YbHdmuxcS0ZBVFiiyOqKcAX/ciMs8edY79iCANljhpSYGEpkGnPd2f5uMnCECu4XEUw6unb/YDPnJEQulB2o8XULuWh4qlPERJ6SmOdHDPC03kKsun/NKdQIQyPIp7A7QFMzhoyV9evtx6TJOmUWytcS6LHUSyAIDWPTfCfoCDewGZ1U/dHC7hPdma1H9m1QDTiO+wXw6E+MCZmQ==
Received: from CH0PR03CA0441.namprd03.prod.outlook.com (2603:10b6:610:10e::34)
 by BL3PR12MB6476.namprd12.prod.outlook.com (2603:10b6:208:3bc::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 29 Sep
 2025 13:41:06 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::37) by CH0PR03CA0441.outlook.office365.com
 (2603:10b6:610:10e::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.16 via Frontend Transport; Mon,
 29 Sep 2025 13:41:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Mon, 29 Sep 2025 13:41:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 29 Sep
 2025 06:40:49 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Sep
 2025 06:40:45 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <shameerkolothum@gmail.com>
Subject: [PATCH v4 25/27] =?UTF-8?q?backends/iommufd:=20Add=20a=20callback?=
 =?UTF-8?q?=20helper=20to=20retrieve=C2=A0PASID=20support?=
Date: Mon, 29 Sep 2025 14:36:41 +0100
Message-ID: <20250929133643.38961-26-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250929133643.38961-1-skolothumtho@nvidia.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|BL3PR12MB6476:EE_
X-MS-Office365-Filtering-Correlation-Id: fe9365fa-a083-4dc0-2f43-08ddff5dd718
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?KzZ0QWNacUtNbzlHSEc2MkZIQ2Vmcm1SNU52TGZUT01oVWY0aUVHanNaNGlN?=
 =?utf-8?B?alplcDRnWkJJK2lSNnYvcFZVZThTZ0paNThla2QwTldnbzN6TmVKZjhvMTVN?=
 =?utf-8?B?dXVnQUtxeGRpU3BiWVVya3dSZ2o5NTZSL1ZtOVV1cDRDODREMHRhNFMvY09m?=
 =?utf-8?B?ZEhxUHVITlFhUVdJT0JwMkJDT2wzK0dRVzlSMW5neklIS1Y3RW11Y2UzWVpV?=
 =?utf-8?B?RHBvMjdsYTQ3R0dLbVU1ek0zMCtwS1VRR2g1UUpVdEJ3amFDN1pHMGVicThm?=
 =?utf-8?B?WWRQc1gvMjVRbFpXNHh0NERtMGdpVnh2cTFac096QURZanpEdUVRRG5zdGlP?=
 =?utf-8?B?Y0VHNUdyTVZWN0NYbUJNRS9rd29TTUVMb2JvU2dyRWZpM1ZmUWphZVV5ak5M?=
 =?utf-8?B?Qms3Z2QzYkVITzBxMEQ1OVkrOFZtZUhza1RYWGpJSW9Fa1FZdjk4STNXUzNp?=
 =?utf-8?B?ejNodWRSV3VJa2xHR04wZkhKcWY0Y3VMa2JvUHh4N0dxZ2VrdWdLQUNRWi9J?=
 =?utf-8?B?R2hHanlLS2grWVRYYWlIUXdES0JiaHRPMXB1dG1QQVRhV0NGb0RTcWlQdTgz?=
 =?utf-8?B?SHQyODU4T3p6aFk2cHpEekxOd3A3VkN3ejF1SnRxeWk1MW9wMkZBcnpCdFJD?=
 =?utf-8?B?L0pCcXZSWXlGWkxpUi82eEVIbHBldUFoWStOOVBmSmNqMktHc1NIcThpb2dt?=
 =?utf-8?B?SXF5YTJ3MFBJd2pJTHZNTHpsWlhHOGtxRlZKTm03UXU5a2llSEtmTW5pOGl4?=
 =?utf-8?B?NkFoTUxGN1hnckhPTXNvcU93SXV3RUJPM0w3b0V0WXpSeEo4KzZ0ejFiUmJw?=
 =?utf-8?B?UERPRSsxMWlSTm5vb0hiSFpvcFp4VGFiQml5UlZUOEZzOXZNZlJDeGdKRWF1?=
 =?utf-8?B?a3o5c25OK3d1cW1KOXorTWhpamFqb1FUUjAvTXB2MXE4aUI4SWpzZWxqUjJW?=
 =?utf-8?B?R04zazFJem96aUJGRHY2QUdNalY3bjhETlozWm1GUkN5YTdrN1N1WDZ5RUVN?=
 =?utf-8?B?bE5XeFJ6cElza0J6K0pjMk9EWlJJT3JTTlhTN3NqM2tocmp1bWdKMThrVVFB?=
 =?utf-8?B?S0VLNzVGc2lkQjlONEdKZW8xa2doRHpReWtHSmxtZzN0K1IwdTBnZzZab1Vl?=
 =?utf-8?B?NDV0Ti9UOTAyVzRxb3NCcU0xbUFvUEdCS1lpQm9udDVCeFRuT0xoK1BkR1dO?=
 =?utf-8?B?OXovRnpHK04wb3ZkNkRoMjNXdDU3Ky9yUFF2cDZTYTFUbjB3T21OSXRTcHFQ?=
 =?utf-8?B?QkdPN3d1NzVWRmtrOVlZdWZhT25YNjN4Wlh1YmdITmtRNDZZa2FJU0Zoa1g4?=
 =?utf-8?B?VXIwL2pNdXM4c1RCUWR3MU95R2JNMlFjMGk3T2dqNC9PT2pYckRwVUlsR2Qr?=
 =?utf-8?B?UC94MHl1RkV6WUFENnpsSTNLTnRreHMxWGhUZVlFaCtRMWx2YkJZS1ExNnBs?=
 =?utf-8?B?b2RDSktnNHhxeG1hSlh2UTFxcVhoMGt5Vml0Z2ZOMHlMckF3R2grN2RRSWVE?=
 =?utf-8?B?MTJ1MnZ5Q3d3Zk9GMmMxWUNodUN3aVZGNkozbVpxWWxWdEFVYVJIemdERjR0?=
 =?utf-8?B?R0FGVytCV1E3R1huRDQ3cTMzZVNUcTZoUm5WYkJzMkhhZTQ3TTVOL0VlaFVC?=
 =?utf-8?B?R1lpNmdHTDNybCt2TU9PWnZkWXlQemFsalJNTnNVelBQcGtJcXdFb3VDYm9Z?=
 =?utf-8?B?d1lFZUVTOXFUK3RWRGY5bWI2MUhxN2lMaDY3dHA2QURCM1RFdmZOdm50MGs2?=
 =?utf-8?B?clpSaWgxU0drVU1YZEQwQ3ZtMzBJZE90aGozS0kyakt4WnRqYWhzME1jZ0RU?=
 =?utf-8?B?RzJGZnVhV2IzMENQcGZkT2Yzb3Rob24zeGhsWllmUllyZlFwUmxJZVdzOWs2?=
 =?utf-8?B?a1Y3czJLelBGTE94OFhsaURva2FXN0dZZzJkb0lZbVEwb3d6SzUzVWtRZEJK?=
 =?utf-8?B?VWNwbDBNMW5iUk9iSjdIQ0FXdUdKMjI0cUdSeTdaaU9KZDJqUk12ODdvd1BG?=
 =?utf-8?B?cEZQZnk1dlJQMGN6RlZkeUo0OHM5bFZuU0RtWFc3blNxZDlrY0JYRkJXd2ZH?=
 =?utf-8?B?U2ZlZWJnYlJwUjB2SEFtR0RFTGs4cFgyNk12QlROVzgzbFcvWE1iQUl0Z1JI?=
 =?utf-8?Q?b/OI=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 13:41:06.0632 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe9365fa-a083-4dc0-2f43-08ddff5dd718
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6476
Received-SPF: permerror client-ip=2a01:111:f403:c007::2;
 envelope-from=skolothumtho@nvidia.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, KHOP_HELO_FCRDNS=0.4, SPF_HELO_NONE=0.001,
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

Subsequent patch will make use of this to add a PASID CAP for assigned devices.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 backends/iommufd.c                 |  9 +++++++++
 include/system/host_iommu_device.h | 12 ++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index 023e67bc46..0ff46a5747 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -523,6 +523,14 @@ bool host_iommu_device_iommufd_detach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
     return idevc->detach_hwpt(idev, errp);
 }
 
+static uint8_t hiod_iommufd_get_pasid(HostIOMMUDevice *hiod, uint64_t *hw_caps)
+{
+    HostIOMMUDeviceCaps *caps = &hiod->caps;
+
+    *hw_caps = caps->hw_caps;
+    return caps->max_pasid_log2;
+}
+
 static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
 {
     HostIOMMUDeviceCaps *caps = &hiod->caps;
@@ -543,6 +551,7 @@ static void hiod_iommufd_class_init(ObjectClass *oc, const void *data)
     HostIOMMUDeviceClass *hioc = HOST_IOMMU_DEVICE_CLASS(oc);
 
     hioc->get_cap = hiod_iommufd_get_cap;
+    hioc->get_pasid = hiod_iommufd_get_pasid;
 };
 
 static const TypeInfo types[] = {
diff --git a/include/system/host_iommu_device.h b/include/system/host_iommu_device.h
index c6a2a3899a..3773c54977 100644
--- a/include/system/host_iommu_device.h
+++ b/include/system/host_iommu_device.h
@@ -115,6 +115,18 @@ struct HostIOMMUDeviceClass {
      * @hiod: handle to the host IOMMU device
      */
     uint64_t (*get_page_size_mask)(HostIOMMUDevice *hiod);
+    /**
+     * @get_pasid: Get PASID support information along this
+     *             @hiod Host IOMMU device
+     * Optional callback. If not implemented, PASID not supported
+     *
+     * @hiod: handle to the host IOMMU device
+     *
+     * @out_hw_caps: Output the generic iommu capability info which includes
+     *               device PASID CAP info
+     * Returns the width of PASIDs. Zero means no PASID support
+     */
+     uint8_t (*get_pasid)(HostIOMMUDevice *hiod, uint64_t *out_hw_caps);
 };
 
 /*
-- 
2.43.0


