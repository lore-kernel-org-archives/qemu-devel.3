Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC24FC590F
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 08:47:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvX0c-0004vy-O4; Thu, 26 Feb 2026 03:46:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvX0W-0004uE-Or; Thu, 26 Feb 2026 03:46:06 -0500
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvX0T-00053e-IB; Thu, 26 Feb 2026 03:46:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oF1S3em3hbYg2uFuYWd0Vi1QdSs/LhgE+PUcH7dAFHYznz9gZXduTBmdviFkQ/onBhvYzxFdXjHnVchq660SUJr5s0bFZ7gLK6nRVHFBBfk44f4tGF49yjxaxRQAduYy/J8lMiwuM82rCAafj5BtzuclL7MVZ1GKN3inBFK2/PngbSPD3lQkH/7w9f8tQvfJe23tUfM/IOkJ6dBxDfCEmtx9rneNhDzB47CCaAsG8JFn89aiZMtD/bwzD14Ve5h41Nzh/PkKHZ2GCzNojzp2+YPGIhd1Uq2MMb1+cljsQODOMLU0gvN0qjb5oonXDHt/hWF5/uuMsRKJzTtBg49XvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EhJXzZI7/JCX/ctmvpYpnffs61jPn2hnuuQKLCEMmCA=;
 b=GyJzXupdzxSGQvmlQpv/W/sYQ7cnhTATBwLpnGaZcgsNwcb5neOJZeTndf+VkuQdoGhp1nhR6TpWMALGWCVUqORY2K/f4W7+AvNim4U1c018MRWiVJACKqtZ3uAR8gShMTF5mR0KR1Dva4WoLz+FYJ38S96houvu0S8+cWi78aN4FytBya7ZOxWSQEsuopRjPim68zwvmQbUWLKzvLijqSypLnQ2G3OL+fdIsfPV2Rh5fWVosdkWkvIRxAPGY7lHaUQWek+zEfhyhJOZQH0m36ABxWySLGkCRhAZ2U6jxPSrzL4v0rIGTV1vXNGeBILQ3IUWBjcoyx6YfSS0+HVlnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhJXzZI7/JCX/ctmvpYpnffs61jPn2hnuuQKLCEMmCA=;
 b=Bvatnvgjfykinr8EpNar0W4VgYs3IbLaW9MAd2uD/4RlBjy06ZR+vT1sgSKHIbXsEFiUnZWkYuY5uDh2haXf12TBe+bWchditp6OAWSfREzBvfna05DtVaxl/8Trm+oRle5gPqlu44MtDWkhvTz/V/yLPaveTk4ecTNxMaV6HwKPgfvZtK/B6bSOrFmwwjfsQbTMm8z06cJ5BHDUHA0FMZXlNfUZL9Bw/wKHWsiVEvwnmJV8pQ/rOREfZvFa74tXy4iBd6mrJfqJZqrsluvqr2BUpS0DtKRyvyDVYRGsvaeRa4dM4dSWzRbGqj5/ChcX4N6VCj4r6t3gz3W1FJEMwg==
Received: from SJ0PR13CA0099.namprd13.prod.outlook.com (2603:10b6:a03:2c5::14)
 by SN7PR12MB6959.namprd12.prod.outlook.com (2603:10b6:806:261::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Thu, 26 Feb
 2026 08:45:54 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::ec) by SJ0PR13CA0099.outlook.office365.com
 (2603:10b6:a03:2c5::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Thu,
 26 Feb 2026 08:45:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 08:45:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 00:45:27 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 00:45:24 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jan@nvidia.com>, <jgg@nvidia.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <philmd@linaro.org>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v8 2/5] hw/arm/smmuv3-accel: Add viommu free helper
Date: Thu, 26 Feb 2026 08:44:53 +0000
Message-ID: <20260226084456.112142-3-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226084456.112142-1-skolothumtho@nvidia.com>
References: <20260226084456.112142-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|SN7PR12MB6959:EE_
X-MS-Office365-Filtering-Correlation-Id: 8745271b-11a4-4312-a99b-08de75137354
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: ROzRpZpdQeWJDpl6YBs0PPWQ/7hPHCS/Iqe6UUno5RlTB/qkVhL6gv9UZ5BMHdbtK6DbsjK/14sIAZjH6nLBtERwGm7x7nVVD+K82CQoV81yswSXA+hcqi6ZLEk9DyAuQ0o4HAf7XYCEtVcmh+Rh21JMIubLzMT/OYBKblKRUGcnA6LiP/g/5YUeafoLi4UT8mxeLaK9p+9Pfof3CdG6E/sCCTwK+2oupuBDrawx4z6+XdXsrYLMcd4aXVH7QqXDMYCvmpD9nQUODRvAvwDN2cZS+g0IdG0ALNvRmK52NBEPKk9+CBARZOR+pObge24L/pnLgQjT0eNcygM9JyCazfbxSrhaZ3rMFWLX+jZNUuF85/IZmvm9apAEFJmddRxiHBNUJRrYaI68RQfMKS1y1MJe920mCQjdNiOHU62XGgMi7jHYYN3J9O2HMjSSaqUsvcPYlJF+2vcXFkDa+0vIWh2qwfQl5PmoERJgCpNLFiAWUwQCszzhvEHkiFFPNXy6T0aegnrORr4YGPl6xibEHT0VisCf83kTJNRIEC7ZgH09FEHqRCN/OPZy/zsy8r64rMpLp/K35YyIn98qWjH8VXEWXV71LPjMZ/C28wqIuP4guVAj8wxjl9CYi2tz7xRWvnXjwZyPHb9fNC0kzl3p2eg3ICls0uA8kregG7/yLHbE7rBIzq1cHpxXNQ7vccZemy9lCIPz0wwa5Xg3+p8RlZiFUCD88aumd6MSKINlYgTxocz00Cx8sm0JBHaC+wIWEx0QMK1iyG1IVwG3FFEn9LqqsvOTTcKf+tRpYT2LCGZf+04UFoeVf14CBwt84d7smGwcoaZZqiffzHu5m2oUIw==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bAwN0SP0NpT2bayxD8uL46ipZe1BpQdPiujLD2unToMg+qgLgRH0NL0gp2z04N1tx4/6N7tUa6mMlorFPe+oyyWrqofp696qiNXVGfzFyjesZS3pR9btyHSF9HCy/HDVsBgvyD+Z6cGTaJSgJQyaTWFUaMVYeOIfX+REqroEyIhlHpL9NN7bUuo/+BE9LHCiDEDmtX2I1/M6/C4rqqUI/V1l9RbQPztkiT10ZefbRhD+TkxDjmDnDqNFUQXd+0uwHBjnjT3qo2JpTh9iRcW5XuWdbyFZEmD7ITxeT51NF8NkPBkX2eTAMnyTqEuiIRBtGLc4Zxou7H2bOhGD32lQNWg5lcdgHwArzR6+8SE2OHWpIp/I4+mhEUdE/D2niUrTiO5LOttVdLOtqXBciAJgZ8w9DUBcb5jG6b3wgdKlNgUrdm+qoht8LZDn8P3j60mW
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 08:45:53.1891 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8745271b-11a4-4312-a99b-08de75137354
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6959
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
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

Move viommu teardown into a helper function and use it from the
last device removal path.

This groups related cleanup logic in one place and improves readability.
It also makes it easier to extend the teardown in future, for example
when freeing related objects such as vEVENTQ.

No functional change.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index f5cd4df336..c19c526fca 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -390,6 +390,20 @@ bool smmuv3_accel_issue_inv_cmd(SMMUv3State *bs, void *cmd, SMMUDevice *sdev,
                    sizeof(Cmd), &entry_num, cmd, errp);
 }
 
+static void smmuv3_accel_free_viommu(SMMUv3AccelState *accel)
+{
+    IOMMUFDViommu *viommu = accel->viommu;
+
+    if (!viommu) {
+        return;
+    }
+    iommufd_backend_free_id(viommu->iommufd, accel->bypass_hwpt_id);
+    iommufd_backend_free_id(viommu->iommufd, accel->abort_hwpt_id);
+    iommufd_backend_free_id(viommu->iommufd, accel->viommu->viommu_id);
+    g_free(viommu);
+    accel->viommu = NULL;
+}
+
 static bool
 smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
                           Error **errp)
@@ -549,12 +563,7 @@ static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
     trace_smmuv3_accel_unset_iommu_device(devfn, idev->devid);
 
     if (QLIST_EMPTY(&accel->device_list)) {
-        iommufd_backend_free_id(accel->viommu->iommufd, accel->bypass_hwpt_id);
-        iommufd_backend_free_id(accel->viommu->iommufd, accel->abort_hwpt_id);
-        iommufd_backend_free_id(accel->viommu->iommufd,
-                                accel->viommu->viommu_id);
-        g_free(accel->viommu);
-        accel->viommu = NULL;
+        smmuv3_accel_free_viommu(accel);
     }
 }
 
-- 
2.43.0


