Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A6BE9A04F
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 09:03:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vszvM-00053h-CV; Thu, 19 Feb 2026 04:02:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vszux-0004yd-Vm; Thu, 19 Feb 2026 04:01:53 -0500
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vszuw-0002P4-F3; Thu, 19 Feb 2026 04:01:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xm6pxphQ4G2CtKpqR/v1q7xNfj3CDtUSie+PTz4JvkFBZFWp98QIKQODr1sx9/CKnisthxv3KvvZM9yelvLFnENTnf2u8w+v+FhpayQaIK9NQ6UC75gcYRq5/9ixs+swke64AA6MmplEgT5awZvRsT4GLY8+b9zuD9p+fAKoXPqgq9rHVzU5QiSAPGPXS3szk/v4M/GL+tqHpCg46OUqvxs+RRZg0wWleR/ynLokLbnl0n8vyte+xqBBMlrvPHU9KG6Qp5mAT9cSVSXfZOEeyeOMiLcOHUEug8rV4S4ZYd18GfoEQkAr25y2NNKL6I1WkxQfme3VHF6cEQSIzkyRQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I++GdzoMRdoVF0CkOr1iwtrbk2Vg4uga402LIVodDww=;
 b=JfCMbWqFftHletML5/DWMep1Io+aZitZ3Z32v4XrfhuiXnlihXRqBnxlN3x8NQBtCoe19ojbImPqnJFoSflRDucercKEIuPs7gy26SSIHMUPbUIRQQ5fG439wuN5nGydQMhWUaIfwR3ertD431Hx8+MTn8ssxy0+8aeoU5ADis1uqM7+r555FytiQnZiw4jcskFZzCkASjqsOVrJzFqAJSPFmu2yq73yZHJjA8en7r+YmjufBOpJOQFwAR9/oRLCU2+NyiOyzOsI9J5kcKuaDRsCYUgfyOsVt0w8EErrsLJMds+6hqS1OBKzfC9nbb2oRUPPgmK8+KulghH8cuXeYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I++GdzoMRdoVF0CkOr1iwtrbk2Vg4uga402LIVodDww=;
 b=kpKUjSlLUAOwqDlkf62elp2bRLkD89w8yXdz1gGtuO2h2iBe77bNDdT12GmKi+oSM2WcsVpuMIcI0jhM5qsQIL0q4B0sabZoWgpSzLePjs+iXmoW5MYxoV1CntyY82shuksgWKO61QKIXpVx1py7cCu8Gt0Par/uw8yF1QjACusLSer4B45yZEYZRT2JGOqhJ9bX1SAse8LhIZgTFvBxJ+17EzVHWraUsn25rKJ2nIsbds8LP5ULboD2dFBtlh0BnQ6eCjrOps37YeXxEK0dZeH4M2NqTjhq0pgs67tlZP0Pj0Zz8+zcbXXmE01bZVWQ0/mQLdyoI6v1cf1FuoyctA==
Received: from BYAPR02CA0038.namprd02.prod.outlook.com (2603:10b6:a03:54::15)
 by DM4PR12MB6063.namprd12.prod.outlook.com (2603:10b6:8:b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 09:01:42 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:54:cafe::cf) by BYAPR02CA0038.outlook.office365.com
 (2603:10b6:a03:54::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.15 via Frontend Transport; Thu,
 19 Feb 2026 09:01:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 19 Feb 2026 09:01:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Feb
 2026 01:01:26 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Feb
 2026 01:01:23 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jan@nvidia.com>, <jgg@nvidia.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v7 0/5] vEVENTQ support for accelerated SMMUv3 devices
Date: Thu, 19 Feb 2026 09:00:58 +0000
Message-ID: <20260219090103.33697-1-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|DM4PR12MB6063:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c374356-6a1a-44d2-6a66-08de6f957f96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0iioxpO6CCD1jNpLXuByWSaZflDAa4EY4zRJi4VhU4EnS9YoXZjE7Ye+HgN6?=
 =?us-ascii?Q?KoWxH8w9OZcZPCWh+UtZp6fkyY+qQd9hSshc1mR3lpL1nTVuqi8CoD5r6qR5?=
 =?us-ascii?Q?2OMXizPw1XgvQ/Qj4TuE9wNtI/sH5ZX/xYi60Av+uZ4UoB/Y4J9OyxwZSuN4?=
 =?us-ascii?Q?XPr7nnMSSyUAj1bg3x8hwR6a4/5I0wxnNYc8W94GL2SP1RDAY5nOgMt4dozl?=
 =?us-ascii?Q?3sSQjOW/uWA/+opaI6eJK3h7abcpieOTGF0xTymc2XENOxJ/nb/t9J8pSeB5?=
 =?us-ascii?Q?RhQvkJETDDTVuULqRUguLX6sZROWvjc3Y95Cf0n41RPUB7euJL49uMrfExrq?=
 =?us-ascii?Q?5Ku1fTqKicMnLeXwPapqxJDdR02+yL1G4FUseUtd1bw2JUkFMLX4YvGH5Q68?=
 =?us-ascii?Q?Q8rpQtbpH+VUpzve1Ip8Vd/vyEBNOc2hcrV/EJKsN8bEjunP0PHP0M5KR5ej?=
 =?us-ascii?Q?xEV9wCa4tJWTAP1FLKLHpHKt9yuMI53Hw5UpcfLBKy1qE3mL8wDRnhn517J1?=
 =?us-ascii?Q?fb0+eVZ3im4oU+M1Opvb32GECuu10g8+cHTV9anq+Fs2AtsVe6LDst9PIt7T?=
 =?us-ascii?Q?poygWp7YoQy0F8kWnHaOw+uf55937jlTy8sak0lR9Z9/Pz3LiYRAzT+dBnFQ?=
 =?us-ascii?Q?F/vEzzzbLOvGBQyNajIW/YuD8H7lsuKC9pvHonXUxaCD5ttVexez4RZrgTEV?=
 =?us-ascii?Q?1+F5vkORISUMZTYDksl2EeTIQoYEuhwSPKOegMdJ8OIbxUtZ3VjjTAgQevLR?=
 =?us-ascii?Q?fLM9wVUjWr3ChU02xZvh1AbmDW/cHpCWVazI3hv0emJbmkKLczwBoMtQW9fE?=
 =?us-ascii?Q?7lPbbeyUd4D/dtnsb+Aib5V6s0WeOQsbdC8MnuuvlO5Uo+vZCVIL/ZhPneZ0?=
 =?us-ascii?Q?cf/hk9Y5lgWbegHNOEqWUR/UTSq7Gh+GKMMzloJRiwJkHmtiwVhffHkdGIXO?=
 =?us-ascii?Q?8ng1PIkCy9Ni9sHmJsEPyqbm9p/s7xKf171LTa8a2doy3oqbE0z4kwZmVikg?=
 =?us-ascii?Q?C2/dqSue54RTP1J4ogl2NJUwqyDG27o+IyP9KQjVPONwyc8ooLDXscyGe/X9?=
 =?us-ascii?Q?RSSAtXpWQtEhfY/jWXdZa3VIximcmhQ1gHzr22nPC5x7OTuflWQK73e3s3tj?=
 =?us-ascii?Q?HFTmIql9i4Cs5u3oGuEvascKMaZlHrtFZbmotNzX9R52WR+AHrm+1Nwxiezz?=
 =?us-ascii?Q?WSd25VsbXa1aZQ7ggCYLdCnbLoNJvzKHBH0vkziENLnh5+2McDfHQLpa5S4z?=
 =?us-ascii?Q?9yZ9y6FL4OYVeH9J6SR8BS6swKn+aa5e7yLf7FY48SDSve+ATXe7jheG4nkW?=
 =?us-ascii?Q?9xEJNVxqsq9A8vNyPC8krUJDMLSklcc5setLSgucIEs6HurieB0HCvI0FHDx?=
 =?us-ascii?Q?2oxtZwvNxhw5en7mzFdanLUR1RwQ3KEfB+UH7p1DwxJwSZXznrjNsPf0KP34?=
 =?us-ascii?Q?MUVEgQJ6f18Wr48T0SiJKhLq7JZw4ojCH+f+NX0T/BZ8OQI/yKCC+kS+S0OS?=
 =?us-ascii?Q?+x8qwegzWiu4XNgygWhzuZ0ZrDk3Wq6IGjN9HgiFxVHA0PSwM1r3UEpgy4vg?=
 =?us-ascii?Q?/0XBlhUQ4sF21EzL4RAsOC3uBp2wczjrlfG5RLDPgo49rIL3BaXIsi28Uk8M?=
 =?us-ascii?Q?+xj9puNGJ6ZnU8iGdftc4NdaiBsYnA+orSE4ww3e4eMem1coGc0lzztAr735?=
 =?us-ascii?Q?kHjg3Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CDKkPjqqYhk7Yf5y2/jlgUanpzTzoXpSe64vakc8sLlNxUiM5XNdYedG1/pOHTbccfDJRZ0/HHoMzKPprVXFUEBcMjXRdGrnnmn8B76pV/1oCxlPqlUja5EAYLjZrooWv4i2DBDVnEAkjS+IWq2hfwNzvaqTz2wbEpKEOR34pQHGTuR82/VWTiHEeAGaQZMP99F3cKROXMNNWfAendxiRWkR7jEFmc4C9Q3AjXGXykh8vA9vIrS5/nF90DPPvTpwWzNI9zFFOMKcZ1vviBZ1AT5wxhLeuujm/sTBhI0iwrVF93EbIdTpdx4oKLwEwYdz6jIIkvbyjxaY6+sgyCblnagVuSsyrdTaNiHVCmjFBsjnSX+IQz59MtN+egTh8439LlE3etN1WcrB1gNQqUAAtYavpeItXDMUvkAxbKHfK/JlarHIwZaIAFn+sSE+uBow
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 09:01:41.3418 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c374356-6a1a-44d2-6a66-08de6f957f96
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6063
Received-SPF: softfail client-ip=2a01:111:f403:c111::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
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

Hi,

Changes from v6:
 https://lore.kernel.org/qemu-devel/20260213103942.142823-1-skolothumtho@nvidia.com/
 
 -Addressed feedback and picked up R-by/T-by tags. Thanks!
 -Updated error report (patch #3)

Please take a look and let me know.

Thanks,
Shameer

---
Background(From v2):

When accel=on is enabled for an SMMUv3 instance, the host hardware SMMUv3
may generate Stage-1 (S1) event notifications that are intended for the
vIOMMU instance in userspace.

This series adds QEMU support for receiving such host events through the
vEVENTQ interface and propagating them to the guest. The implementation
uses the vEVENTQ support provided by the IOMMUFD subsystem in the kernel.

I have tested this on a Grace platform using some hacks to generate
events. Further testing and feedback are welcome.
---


Nicolin Chen (2):
  backends/iommufd: Introduce iommufd_backend_alloc_veventq
  hw/arm/smmuv3-accel: Allocate vEVENTQ for accelerated SMMUv3 devices

Shameer Kolothum (3):
  hw/arm/smmuv3-accel: Add viommu free helper
  hw/arm/smmuv3: Introduce a helper function for event propagation
  hw/arm/smmuv3-accel: Read and propagate host vIOMMU events

 hw/arm/smmuv3-accel.h    |   6 ++
 hw/arm/smmuv3-internal.h |   4 ++
 include/system/iommufd.h |  14 ++++
 backends/iommufd.c       |  31 +++++++++
 hw/arm/smmuv3-accel.c    | 146 ++++++++++++++++++++++++++++++++++++---
 hw/arm/smmuv3.c          |  26 +++++--
 backends/trace-events    |   1 +
 hw/arm/trace-events      |   2 +-
 8 files changed, 215 insertions(+), 15 deletions(-)

-- 
2.43.0


