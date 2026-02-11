Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B416DEB597C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 08:36:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq5hA-0006TX-GX; Wed, 11 Feb 2026 03:35:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vq5h6-0006SI-8J; Wed, 11 Feb 2026 03:35:32 -0500
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vq5h4-0002lO-L6; Wed, 11 Feb 2026 03:35:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hi6zLFmThWvNl0xq2kKe6aRIsLetOiyVMROnIMX2x6PYz0pMQJdDT69+ZZ5q9HnYrwwt5CC/tkVxCb148248/HMq0vrTLORCBOf0VoXIMkoSHOPxY7b2ZLe1/8e9PFAG73x0d9wUr4Z3PJz+aQ/1So+uwn2w9KvoYFnTNLI9KuSqFbq8NZZf9HFMyAsL3sUc3nt1A4k27PfS5NcYBCHc3bAr6wI945XT+xVq0VotW3/GeWpctkDxcMKkp4E9xlllc6nbfijlJYltU71AYf9uAWYD4U4DDhtOf182XiQuioMVpyZ4ee/XoEaF7+RjJtW159MV7BZMEzgQDg1o7VdtVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FOsMj8wk5JeKKPi2aU01Lhh4S0Uf2VOAllAPUWpbf0Q=;
 b=mMJg1YoQvQXC9CsK6WPXaPOYFAuvWeW1/qw0Pr8gMUA66nOlsfJ+fJefNRJRMrF5IdqVLNFqlIUlQtg159jpURxKCqGL8EXvyuEu+CGnrHdvwfwR0iiiCDuFdHgulEgoO50fcSBHlALqGDeTK7jKuJ7WCC/rS1s9G6G8SiQpWRXzC2hlSoydXP/SpZjzpMC2+OpcbVK/OFqvZWpy/Lp01VDyusVu3xRgBCD4wOaLWBHCQ2rxVbFlDcqC604FdzVNKFT6068sOL79lmKppXSmlA+k29p78HJ50fXc4bmEc3GmNR/tEeahiLoBVdS24zc95KNiKuROMRWwb4fqTHlTjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FOsMj8wk5JeKKPi2aU01Lhh4S0Uf2VOAllAPUWpbf0Q=;
 b=BEvDoR4zcvkIwiC6yy8PKt3shy6Nm79ROwFLRlNxT009+3nKFz+1DYkO1kjx7etLLT2kSU1+h3z3a4wqLnTnaUagZxkfY4bpGiGpi+JsLn+an824Lm9L6b8pNZUSfNXNEVfwMhQP6kotX5YVpWMcl1Blb1N4xAitJl1clGPq4SpHi4hHPUeOe/9TVMTMF0CtIb4ZaRfQBguEhH/0WJC9A7uI+R+3r9x/GDYTASmHM+PqMRFiblmAt59TZZr4DBzov8bfFOBozYp0A/0UXeNYMjlYv1Knh9zEB0iVCRdFElQHtWmXk6kE2mOjlraSsDWHdg2MaeghMIdGsQUKnzUWiw==
Received: from SA1P222CA0071.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::18)
 by PH0PR12MB7837.namprd12.prod.outlook.com (2603:10b6:510:282::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 08:35:25 +0000
Received: from SA2PEPF00003AE7.namprd02.prod.outlook.com
 (2603:10b6:806:2c1:cafe::84) by SA1P222CA0071.outlook.office365.com
 (2603:10b6:806:2c1::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.10 via Frontend Transport; Wed,
 11 Feb 2026 08:35:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003AE7.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Wed, 11 Feb 2026 08:35:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Feb
 2026 00:35:10 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Feb
 2026 00:35:07 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jan@nvidia.com>, <jgg@nvidia.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v5 2/5] hw/arm/smmuv3-accel: Add viommu free helper
Date: Wed, 11 Feb 2026 08:34:12 +0000
Message-ID: <20260211083415.133534-3-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260211083415.133534-1-skolothumtho@nvidia.com>
References: <20260211083415.133534-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE7:EE_|PH0PR12MB7837:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b1c9c09-90d7-4f52-0854-08de694880b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PMpGb6V0Gt+ZCc8upf0hVwBzuhcK+ilzemXHzUo8+b3qbGFB0GPhmAuSip3D?=
 =?us-ascii?Q?I7BdmTk2a+UFWPi0pUq6rHQuOLbtg7IBkS7wI/9WITxnV4rcuZI7d7YbXkgj?=
 =?us-ascii?Q?qPhyzaxRSrQq6WQzLbtJs5L+QL0jTwn05TAUmCbpam8ve1Vuhm/5SSwVZRCb?=
 =?us-ascii?Q?Ymlztaymkm2lfy5KBNXoS9aoocahmR/7HjBgDQjcdTMzdGqsjggWvfCPlfuT?=
 =?us-ascii?Q?OogIFZ2NV7QObCYAwUWh6tqNFZQljiol2DfK9vTcN3rJZVT3GJE8iC8tMQng?=
 =?us-ascii?Q?Zz44HOKJ0EIdcgNB7gFOm3RkckpZgLDB+J/zUIvJVmpVBsaNFJBVpv6i4o+Y?=
 =?us-ascii?Q?tLFQ/ONHC7MjgXimA/cMT/4S5m1YfFdID5ne3FAZsmjJGrYjqy3dhYa7VVxG?=
 =?us-ascii?Q?FudaVzTrVoZJ0Ka1dxEhd4K5NeRdkeQsdslfm1JgK362VTj0TLvXYsiqH+zT?=
 =?us-ascii?Q?wUg+jAY+1+MCLgmrEyoKuP8mqdsdA4y+3qDDVqeq+xX8CJxcO4u6iEwDKY4A?=
 =?us-ascii?Q?C7MUDhWcfIPIAal328UVLG731FvCUUR1pmhlTqtq25F1DsEVtNhoGVymYp/t?=
 =?us-ascii?Q?V9NJzfWzZiftPVtbNvjXt7rA+R+NDp8zUccBwXEuEeeeF3oqcuNBp+XU9taF?=
 =?us-ascii?Q?/6W9HD2MIqfRByrghri1mfNbEleYHFUXBo2T0d4Y5HeXPmLJ8pHPv6N3OF7v?=
 =?us-ascii?Q?A3EQDxxKapnHadj4y0DPFMO+ATgqKR4kMmtjhLR5cCENZOaqNwJbDb3zWd7F?=
 =?us-ascii?Q?THdHp/gHHRJ6Ro44kYLADbtVKxnqQPCdtAVX29IYE3bgbHxfFzfblCPyMcrl?=
 =?us-ascii?Q?XX6XzW7ckq7R7YRRLFpIkDvdV+Q7j7/pu4HRP33g1++irDC+8fdS5m+fpl6m?=
 =?us-ascii?Q?sk8BujpZtt4HPDeLa4ePMx256r7kCOEEIkk/3sB7QNl25rDR0nuEk9ldbBZe?=
 =?us-ascii?Q?Vw2iCtVwBq55ImyNMfGhSVnkfqGvZf5buXNV6gR4nkpJUfCiwjwkadRWTuJi?=
 =?us-ascii?Q?Mi6iyrYmjITa7oT6Rge7zgvZ2Abvl45c2qQ30KewOTZlJVQ7hRaNojKiwbK+?=
 =?us-ascii?Q?c9A8NT1EH/iBfqz+wE6DewADtcMc8Mx1FE4LBEhubeD8olk6XcSbGtlhKmcV?=
 =?us-ascii?Q?rU1yzMSUWnQEs7xQJNXAYb03AHlqLJWVwFewBFD6zMameWXi/rK5ieHusK1N?=
 =?us-ascii?Q?Ysqe1AOVd1JMnkXa6FbyrRO8daiT0It5ZoC+DfO3cAnfJqElsYoidVTGjrBw?=
 =?us-ascii?Q?C66FA8MoMyg8Feb3lkdytYVDKpmg7fe+S7/hHipCJOE7s6JRJVyyphOcSmeB?=
 =?us-ascii?Q?wEicYCgGgiD0fnbaTX3Ry8Bki3x+bhYGt8MDREmQ3QxoDQ4ZzJn0qieg6g4w?=
 =?us-ascii?Q?Eor40TvyYweOC8KsmOMkYCfOZJg2iykNPglhe++IEprS0vMMJvVZ4iYNF21J?=
 =?us-ascii?Q?4ub/8+9NYRBxc+66xXlyJ9oOvXmIe9ARoG8teqmT0D/8fXEvm6KEplRKku0P?=
 =?us-ascii?Q?x2C2AxcV27wmDo7TRd5Xh3153CpFTPnWdi0OvNqwK7f4qjZ93LHVco/f95rO?=
 =?us-ascii?Q?s+G2fPR4jIhuqR3CZHAicLWtlAZ7kR/IA40W9/ZYaBVeSDu79bBGKU7PnvYw?=
 =?us-ascii?Q?gWjizgFdBHtIjqRmlbNgz+rxBr+FsB4xnO4FvUdYT+8c5sIcIH5NSvRXX4PQ?=
 =?us-ascii?Q?dgq3oQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3qsKQVnM1vOlIC/BqsovxRLKJ2nTYghMS/ct5TEDar/1q8Jfq3ovFiTjNgLxDjVVrJByis267DsmoqxUDA4EN4H3TyibWdwo5RMeHXGcaJdFNKWCMvrIqIf7Q397tEwFZDsw4GPtAHHuRkDKMXjPEh4VCF/RurPa57oJ/1Wtk2NT/ZQz6aXy1Lhk2ewlnRcX65FQPyRbixJSVl1PDY8TI1s8Q8Er0VFUt6glsLRnlm2zV5NiqgejG55GQUbX/J4MDRpAO2xgOF8mUeck/rKya+OmcAGJYfN62TubDn64zndtaYvN3ovHRudELSeQZB95Vc+GFkZkQJmUrAQmb205+x5S9mXqDjO/oEmNivz7pEsx5DOCicqB4llJG0uXMMTK8B2eJ1BZb5PSHZXMaBXocH9vN6OhjESk0wht/WS9THjKQKNomEYc90d81/TaHCrW
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 08:35:24.9360 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b1c9c09-90d7-4f52-0854-08de694880b2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7837
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
last device removal path. No functional change.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
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


