Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 115ECC44506
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 18:04:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vicXE-0005KF-3R; Wed, 21 Jan 2026 13:02:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicTi-0000Xn-A9; Wed, 21 Jan 2026 12:58:59 -0500
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicTd-0002DZ-Dj; Wed, 21 Jan 2026 12:58:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v66/c9JKu5PJFpx1nK0F0bfiRpWeOi7yd4xP0676oSp18KiNamv+c6nJulnaS46aX3ttISHfVpE9QNZOkz1sr4oJB2bbuYVrouszYJ7kN1KYc78b5q1GRUDSmlVWGKvh+94y3h03qYIIt2M1GjjV2EBs0CQVH08iKQQCDMZUGNE2K/RziowYlWSoGQHkVtN3csoxJRmM3fj2fhjD1JM31ARhltSf0hhrJmaCjYW6Ua2aX29IP2bDFmlBhTESx2/PJrnIsyMzBNekRd4nAWN9rpDBOy/pe4juYeCH+d/rvNkkqH92/z8tJsxjGlLPZBSayoQvDe632mu+pjU2yIwUNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8yL6j07OD7LW7ujL5iH8wDlz5VP6M5D9aJ6r8EizqeE=;
 b=RuPXETQk9COHc7B6qw75c8r5JRTKdQIk4o1ThEk5yC+40kfpqaaAWddA2Rk64MVr8cxqf+pNG4TKZs5VUprbNW/jFvAk1NeqKgRGiPJzBSlTQyKDMBexCgiqUHZXFr0lYT6cy09Fld/8jqMGXXm9/LcxGvn8QCwRS9gW4iMVA3agHt8cRMfjOB3QLFbQDrwkry52c82MBCFD6om1+9uusndSc3yJTofBq9g2nbAxQhdfOp2Sz1PT5Ghi+U7XxFQ2fy337oFg9JoJaznbKI/kwnXbl3EGepT0Up7DADvP+qDK8ApbHQubAhVWJGupctppYkxkMjGdMHTO5vKyx1+XGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8yL6j07OD7LW7ujL5iH8wDlz5VP6M5D9aJ6r8EizqeE=;
 b=XCpsPy0FZlGNIZ+oeENoodN7on4vmJ2KmMChAexOgq4/KBNIwaZ5hKP5FB0TS8ffuJRm5gzs4j31aPLGOTXyfE+M78d/HCFFFMnQD4HyWMBqvWCQlHc3qwXB6BYW6UX5B4g40bhR+8ZfuBEGrSB/pfeHDVEjkGBB64HnDi6xp1ZQVtkjMMdk3AkP4EBMSHrtgb6pKHplBjaxW3ikUDY+ueTqAI9Y58f2n4/5/dJHtlj+c6k+hpcIqucmEfC5lbUL+Ygq0wrExhtYcJpok5NROaL0e3jLAYdO/kGJUbtWORxqj5aRPmDppjw1/rAr/T4wGyga+LtvX0/0hkmfJ1AfLQ==
Received: from BL1PR13CA0162.namprd13.prod.outlook.com (2603:10b6:208:2bd::17)
 by DS5PPF78FC67EBA.namprd12.prod.outlook.com (2603:10b6:f:fc00::655)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Wed, 21 Jan
 2026 17:58:24 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:208:2bd:cafe::c4) by BL1PR13CA0162.outlook.office365.com
 (2603:10b6:208:2bd::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 17:58:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 17:58:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:58:00 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:57:55 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v8 33/37] backends/iommufd: Add get_pasid_info() callback
Date: Wed, 21 Jan 2026 17:52:38 +0000
Message-ID: <20260121175248.87649-34-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260121175248.87649-1-skolothumtho@nvidia.com>
References: <20260121175248.87649-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|DS5PPF78FC67EBA:EE_
X-MS-Office365-Filtering-Correlation-Id: 25d3eaff-7416-4036-19b9-08de5916ac3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?X9k6PoP+HOTr4X5t9NLTyMIRQ9f01xKyc9N0J4HbbTR97K/RuitVnOgWPDg6?=
 =?us-ascii?Q?DFLF6ROtytIAqVSzVtbnlPFgd7wDz/heY26gDI1f6c2Uy0urUmuW7It3s8kb?=
 =?us-ascii?Q?Oun08SQsCIX+nZ6cRd3T5z0/9pZd5/zHq2ZfGSuN/038G3WyF5MHNpvbsCHR?=
 =?us-ascii?Q?DaE7/9bTZOi4Fz05RjaN4WJVDCv19VL5jhMRqI6mo+/xBaxPvB3oBNh5iFCw?=
 =?us-ascii?Q?Cu1Gete10ADlrvkuAvCJ52pqbAHUAHTy+DqxXQTzHAc8nQzbOyPsO52tSGLX?=
 =?us-ascii?Q?YqRqhxtVLbMKHfyxvvyFA3sjIrdVoz6Ui/v4LImA85yg0Bw1I3fWIBJEkp5r?=
 =?us-ascii?Q?UPk9ZWZiertojgsWZMU9/+Kwvkm3clyCVWoL0E234wW4b7cIyv8hMtVg1+s5?=
 =?us-ascii?Q?+f3xTzQWgv4sMp+8SxflW5MBNveMIFt2hI1uimNx7I/Z/hazsJ5RUH6jruuI?=
 =?us-ascii?Q?DZ0uCPE+a4uAqxVGLOR48hLfn9/eTBvLDlWb3wk05MtPqV/xOpYrxDNqImjc?=
 =?us-ascii?Q?LlRcVgocvA6rWZ4p2Kb+fpE4i1begG1remXrq7Y7Mpw7AkYzH5WDxhxs21qd?=
 =?us-ascii?Q?Aam2jIjyMaIpyUEOBL/tY1KU3r3hjH/BzP/9cFJPTWn+/QWtYICWynti5RbR?=
 =?us-ascii?Q?UNyayUWtwtghadzwxBHlZI7cwELHbYVZb6DrTNysyfha+5jAvNnsw6vXGP6x?=
 =?us-ascii?Q?2BPgGFlb82vDm4w+TnnRaWq69g/mGMiR/EnOFbroMzkWQDaCuKXxHbcydueI?=
 =?us-ascii?Q?wfBgAOHJAPCfalx1GIBA4BwZWEU3FoJpc3kv9eT0iWp/08o09Jz3+0f0BHt7?=
 =?us-ascii?Q?frCTyOjCIC7uKaxjh/FQ+NjzY8c870cFhlTPp1MIr1uqOdqTeItpoQzn3J5H?=
 =?us-ascii?Q?T8HKCP5dsZDMdOOGwuAJ6Z4qq+KjvhWcXdPZoSsCzqjeiXUxRbFBcahjMUSG?=
 =?us-ascii?Q?Tw1xhThF2gBrHQUknejdLKDsimgOWqXPwOrRLrHlj8bYYxFj7r9Xg0Mwk4Df?=
 =?us-ascii?Q?s5R9gZd+1EEodozKv/aEmsvslZVjuZQLCZ1kXy9A4PnGW3OYvvqm+lRhr/OD?=
 =?us-ascii?Q?0MRpsGHsD/21b7KWsQ//1DYOEhaoX7wKbs6WwgT9v+p2FH96otw/j55SRymj?=
 =?us-ascii?Q?uSxN62qavGVUY3pfl3KdXxDn7jPtHHHarCqU5IOwp5PGYF/QUQ3ZC/qUJ+FU?=
 =?us-ascii?Q?JrLEBepKJjDI1nLmT6tKSSjkWb83pM0gP1Lg6JIvf/ohtKROZrL3pyVVC5+H?=
 =?us-ascii?Q?P+lJOmWxEaYouuf4ti9ujfalNY1zeAeezmtAOas0gvu0UJBPkMJL6QvU6op6?=
 =?us-ascii?Q?IcVEOxrx4DaYKquQTA9tvHPIeQSgplrb0fZJ8Yo5wYgqZKHKHT3mjNWh8tli?=
 =?us-ascii?Q?Fuf3j/OJm3PHnLoSBekhelBUhld3XBJ02SJealPn7+rH4rrYX7iQseFZSDwq?=
 =?us-ascii?Q?kT+BXtooEeeeEfJfiHtDk7lOwGzSjUpPVHYk/kqpBpACRdFHi2sO6uuvMN7b?=
 =?us-ascii?Q?4tsdHUOxhuv2zijXfD3poY3JMTQZtJwVqLMnGL1qtCcvdbMlaOAdhyyhZenQ?=
 =?us-ascii?Q?4iRCAKQ88CyiVLzzo8MQWOhtVCPMxTEpeyBAEaxh+KwI4l0RRA5xo+Qote+d?=
 =?us-ascii?Q?jgee45nm+nq6HCWfkZZEyfUjjT/TiiiYTRWHjWveHOlAP4e4kShIeQFc1g/B?=
 =?us-ascii?Q?vzmajQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 17:58:24.5172 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d3eaff-7416-4036-19b9-08de5916ac3e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF78FC67EBA
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

The get_pasid_info callback retrieves PASID capability information
when the HostIOMMUDevice backend supports it. Currently, only the
Linux IOMMUFD backend provides this information.

This will be used by a subsequent patch to synthesize a PASID
capability for vfio-pci devices behind a vIOMMU that supports PASID.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 backends/iommufd.c                 | 17 +++++++++++++++++
 include/system/host_iommu_device.h | 17 +++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index 9b63d74083..13822df82f 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -539,11 +539,28 @@ static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
     }
 }
 
+static bool hiod_iommufd_get_pasid_info(HostIOMMUDevice *hiod,
+                                        PasidInfo *pasid_info)
+{
+    HostIOMMUDeviceCaps *caps = &hiod->caps;
+
+    if (!caps->max_pasid_log2) {
+        return false;
+    }
+
+    g_assert(pasid_info);
+    pasid_info->exec_perm = (caps->hw_caps & IOMMU_HW_CAP_PCI_PASID_EXEC);
+    pasid_info->priv_mod = (caps->hw_caps & IOMMU_HW_CAP_PCI_PASID_PRIV);
+    pasid_info->max_pasid_log2 = caps->max_pasid_log2;
+    return true;
+}
+
 static void hiod_iommufd_class_init(ObjectClass *oc, const void *data)
 {
     HostIOMMUDeviceClass *hioc = HOST_IOMMU_DEVICE_CLASS(oc);
 
     hioc->get_cap = hiod_iommufd_get_cap;
+    hioc->get_pasid_info = hiod_iommufd_get_pasid_info;
 };
 
 static const TypeInfo types[] = {
diff --git a/include/system/host_iommu_device.h b/include/system/host_iommu_device.h
index bfb2b60478..f000301583 100644
--- a/include/system/host_iommu_device.h
+++ b/include/system/host_iommu_device.h
@@ -59,6 +59,12 @@ struct HostIOMMUDevice {
 #endif
 };
 
+typedef struct PasidInfo {
+    bool exec_perm;
+    bool priv_mod;
+    uint8_t max_pasid_log2;
+} PasidInfo;
+
 /**
  * struct HostIOMMUDeviceClass - The base class for all host IOMMU devices.
  *
@@ -116,6 +122,17 @@ struct HostIOMMUDeviceClass {
      * @hiod: handle to the host IOMMU device
      */
     uint64_t (*get_page_size_mask)(HostIOMMUDevice *hiod);
+    /**
+     * @get_pasid_info: Return the PASID information associated with the
+     * @hiod Host IOMMU device.
+     *
+     * @hiod: handle to the host IOMMU device
+     *
+     * @pasid_info: If success, returns the PASID related information.
+     *
+     * Returns: true on success, false on failure.
+     */
+    bool (*get_pasid_info)(HostIOMMUDevice *hiod, PasidInfo *pasid_info);
 };
 
 /*
-- 
2.43.0


