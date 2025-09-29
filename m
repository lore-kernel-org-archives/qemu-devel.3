Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5FA6CAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 13:45:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3E8c-0003h2-7D; Mon, 29 Sep 2025 09:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v3E7e-0002og-MD; Mon, 29 Sep 2025 09:41:02 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v3E7K-0003h8-V8; Mon, 29 Sep 2025 09:40:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qO5ZJKL3MsExX3Ac6sKMCVXC5ddOL+4BIobPyMi9dG6TgIALaZdgkDutVEYl94dRI2HoZTeJgzXG9YHg1soOjyKicOfpod8kpOFy01uulgdcSj70LO2G+UOuXI4KCzYpE98p7O5sC8I++d0B0yRx/l+3PYY0yHdYKzOG8fumyv/7Sk5e1tChtm8CQ7tD7ILjWDttcaUHMuyS5dgVk4NDXLaf2YVJLNNE6XKkPC3NpCarf1NekAmzf+qn+xJDAM/zC65RtlB1RrnPOdmOMAEUF9VIBef8QqiETEYKPGFkhMvgQ9AQWolyCQtOs+gfD/66k7qJjApOorURgw3wkaCaiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Uzooq7lh1KSGWi5C8h1mytLPjlX62Y50i+zZcNZPkQ=;
 b=BumI0dh6Lpf8yZpyP3EFmGBimjRuPhaZLKgUVYyCyzv00bBUJXqou3KBnJvpAIIlDz7+CEL8YBcRgZ/T7UwzS/r0llL9bV/1o0pJxVQtjWRMOS1OrIdW1PDeTqEnmKH4moT8FXn+OUaw45b26MOIR0aCZTbO1KG98KzJKa6TuNnFqB2Drl4GgPDgs2afQ8xxVdObbtRkh9FDqhMg8irkaK8YMfmfmH5iTZM4VNN3+qVb6vOknwijO++ufYbe6jHxUud5s3ggu7B3OxQ4FuR0PwOgqKyzlVp0TPazghDucvP11+OHez7/nqWuAgXPukhEn8oPUptT8uKMOwKljjl45A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Uzooq7lh1KSGWi5C8h1mytLPjlX62Y50i+zZcNZPkQ=;
 b=JpChE1+EgF4qrevIWt1fAjaPKVB0c94R6KPlQF14qQ9gIUPwWFvEyupdXvVwZ3Xlz9RlEo+TtSYy81hReAHm3Ll460hyn+YlmxoacpB33nQhzpnnpKHhbzoK5WRX7pXj69/FbGZB68cmbrAGJxULFJYwwMTIr3l7ZEqFsZ7cz1cRmYPXwVcOUe4AvchHpqZIMqkV21btMbQO2JGTEHllYYwfgmc9kwXq4qw0FGMtx4Uk/KIi4rO9PCyGvWZuXDt40T3fKJ7ZDNkRIoSpWaFIWzAxUBAG0E4gnRf+zMMlDzbANCy6ABowxFKeRtBCflrnfKLfTvxKvSkIWGDOsZwT3w==
Received: from CH2PR08CA0025.namprd08.prod.outlook.com (2603:10b6:610:5a::35)
 by MN0PR12MB6368.namprd12.prod.outlook.com (2603:10b6:208:3d2::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 13:40:17 +0000
Received: from CH1PEPF0000AD82.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::f8) by CH2PR08CA0025.outlook.office365.com
 (2603:10b6:610:5a::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.15 via Frontend Transport; Mon,
 29 Sep 2025 13:40:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD82.mail.protection.outlook.com (10.167.244.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Mon, 29 Sep 2025 13:40:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 29 Sep
 2025 06:40:03 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Sep
 2025 06:39:59 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <shameerkolothum@gmail.com>
Subject: [PATCH v4 14/27] hw/arm/smmuv3-accel: Get host SMMUv3 hw info and
 validate
Date: Mon, 29 Sep 2025 14:36:30 +0100
Message-ID: <20250929133643.38961-15-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250929133643.38961-1-skolothumtho@nvidia.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD82:EE_|MN0PR12MB6368:EE_
X-MS-Office365-Filtering-Correlation-Id: ae631c98-7384-445c-b756-08ddff5dba32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?z0nv09b+14zY6YLh/8Kkkx7cA8C5hzsmXjyYGuqrJ4QFxfu9NC/Sm/L6tg0M?=
 =?us-ascii?Q?lKu8whlUfNXAfxRHf62naZnl1Xl/m752cHB/VPW97/6tYxnegJULPJoKVw+m?=
 =?us-ascii?Q?5gDu5ayuFT2uAzLa/VcZqbu3E/yPLdQj3CuGWx6guNvqil9DFJWmAgbXSJwj?=
 =?us-ascii?Q?yRb0Lp9QW8A4YA0mnvbSJj5VuqlbyTsLTcURIfjO7G22lBpw4wslmVMCo1/A?=
 =?us-ascii?Q?BfJp/J6dHHaO10uOK7yzQcTV10nIsnPiqOjbchAJZMRAH6XF88KTkyCEgKWG?=
 =?us-ascii?Q?AyRs/ludcZfXB07lOKtC5+lJnnbNaYQcFFx1SWSOqhpXayq/5ALd/N0THO+r?=
 =?us-ascii?Q?pcKsyn1V6C6E+k0V5a29f3cS8WdrcYMnNEYNEInozmOI4qVSQU148bczDCa3?=
 =?us-ascii?Q?VMeUHKQ2Z0F6NkzAJpERFXLYigVMI4rdor04WMGMQt1Is9UkOdwxXSogJeg5?=
 =?us-ascii?Q?rK3o5YJX6EdkTzzSP7XFa1e6FE7gKmV2RbJaUdZ47hm2WK7sIT6DiwAXwyfU?=
 =?us-ascii?Q?w+Dps0+ZGPHykqT1raSgMQT29SXR535dit5szqqutlh9tKvVMTplmP2S0U+Q?=
 =?us-ascii?Q?7slR4HW74Jyk+oxO388YE9jDNNYPbdQAwy8M6k4UDFRq89uHuTyfM6mMJnP0?=
 =?us-ascii?Q?bWUt5k7ISEuCjBzoK4ioaHayqjDXJS1Ik8CNZZg+27Ovcr9Z0AUpz3TCkL1a?=
 =?us-ascii?Q?aX+6oh8z8ic4XnxupWDzfZEwoq4KTgUhigJSUoHzkPacO8ijweUieTS83PMM?=
 =?us-ascii?Q?fzIU1eVyUJPU3QTuHdRZIwx6j8a4ejK8LsSzmg92NoOf3vQjPgaqddogM8dR?=
 =?us-ascii?Q?LrNfe50/ehz/sH1Fm4KR2UMnSMlOkvnY2rYr/7PmK6fyfpsS8ZdJwSaIC3Uk?=
 =?us-ascii?Q?s5JoVbAPaSq6qGQuvDBcUIjVLSol1GARYLyeGkIMdQCbrFjhQi8q8jWLJXsh?=
 =?us-ascii?Q?5XWbJwXUyyNSA8tOyNHmRAAKuG00Q87IgBWJxdEl9Uen1AD09nWux3miZZAw?=
 =?us-ascii?Q?KkiM5qP/MYs3U5s6t2vRlM9I4UCMfvXFxZH6/aNiFhHa5TxgZ42ZcAvFcTyh?=
 =?us-ascii?Q?DMd4/kOpQQOuausMANZwvqrwmXvgtSBjjSJ3ktHKycfMDej3ah6kBvlhnWKl?=
 =?us-ascii?Q?d/XpYO5spZOYKxx6A845lKpKsreOqw2mI+gdEaIk2WlF1VOp1Aqjtmz2X2m8?=
 =?us-ascii?Q?Kv2d2DENzySxzere/eyLLuMz8QTqS7JCA0glNZFSreD22yhBTcwAuU6XXRi0?=
 =?us-ascii?Q?Uh0LbPYb1EKyTPo0sG/nPw3rKQoAVc4ebXwpFk0UPVg5dd7LfPWs65M+GEgu?=
 =?us-ascii?Q?ltHvmyWJClmV+RY3qr6Ga1HFuIHtESJo54+JUHvNgkF9Wbl8tsnF4maLk2EC?=
 =?us-ascii?Q?X//mdOCQ/N99LzvlK4H7GLLxTx53SSl+yEIhJXzeY5/A6bj/ZwzYv69fx+9L?=
 =?us-ascii?Q?LdkiKCLIz3vowxlejMPQXpb9dfB5bNCkA96pE9liz670en0HYTsMOIStZTLZ?=
 =?us-ascii?Q?Znl7ouVdZUEXX1m6Cfpps1vqIhDY6LLqObciKugSVPR0yg8bznRI0ALFG2Uf?=
 =?us-ascii?Q?KXP8kf47xZJ+qvVVPNk=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 13:40:17.5946 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae631c98-7384-445c-b756-08ddff5dba32
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD82.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6368
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_NONE=0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Just before the device gets attached to the SMMUv3, make sure QEMU SMMUv3
features are compatible with the host SMMUv3.

Not all fields in the host SMMUv3 IDR registers are meaningful for userspace.
Only the following fields can be used:

  - IDR0: ST_LEVEL, TERM_MODEL, STALL_MODEL, TTENDIAN, CD2L, ASID16, TTF
  - IDR1: SIDSIZE, SSIDSIZE
  - IDR3: BBML, RIL
  - IDR5: VAX, GRAN64K, GRAN16K, GRAN4K

For now, the check is to make sure the features are in sync to enable
basic accelerated SMMUv3 support.

One other related change is, move the smmuv3_init_regs() to smmu_realize()
so that we do have that early enough for the check mentioned above.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c | 98 +++++++++++++++++++++++++++++++++++++++++++
 hw/arm/smmuv3.c       |  4 +-
 2 files changed, 100 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 9ad8595ce2..defeddbd8c 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -39,6 +39,96 @@
 #define STE1_MASK     (STE1_ETS | STE1_S1STALLD | STE1_S1CSH | STE1_S1COR | \
                        STE1_S1CIR | STE1_S1DSS)
 
+static bool
+smmuv3_accel_check_hw_compatible(SMMUv3State *s,
+                                 struct iommu_hw_info_arm_smmuv3 *info,
+                                 Error **errp)
+{
+    uint32_t val;
+
+    /*
+     * QEMU SMMUv3 supports both linear and 2-level stream tables.
+     */
+    val = FIELD_EX32(info->idr[0], IDR0, STLEVEL);
+    if (val != FIELD_EX32(s->idr[0], IDR0, STLEVEL)) {
+        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, STLEVEL, val);
+        error_setg(errp, "Host SUMMUv3 differs in Stream Table format");
+        return false;
+    }
+
+    /* QEMU SMMUv3 supports only little-endian translation table walks */
+    val = FIELD_EX32(info->idr[0], IDR0, TTENDIAN);
+    if (!val && val > FIELD_EX32(s->idr[0], IDR0, TTENDIAN)) {
+        error_setg(errp, "Host SUMMUv3 doesn't support Little-endian "
+                   "translation table");
+        return false;
+    }
+
+    /* QEMU SMMUv3 supports only AArch64 translation table format */
+    val = FIELD_EX32(info->idr[0], IDR0, TTF);
+    if (val < FIELD_EX32(s->idr[0], IDR0, TTF)) {
+        error_setg(errp, "Host SUMMUv3 deosn't support Arch64 Translation "
+                   "table format");
+        return false;
+    }
+
+    /* QEMU SMMUv3 supports SIDSIZE 16 */
+    val = FIELD_EX32(info->idr[1], IDR1, SIDSIZE);
+    if (val < FIELD_EX32(s->idr[1], IDR1, SIDSIZE)) {
+        error_setg(errp, "Host SUMMUv3 SIDSIZE not compatible");
+        return false;
+    }
+
+    /* QEMU SMMUv3 supports Range Invalidation by default */
+    val = FIELD_EX32(info->idr[3], IDR3, RIL);
+    if (val != FIELD_EX32(s->idr[3], IDR3, RIL)) {
+        error_setg(errp, "Host SUMMUv3 deosn't support Range Invalidation");
+        return false;
+    }
+
+    val = FIELD_EX32(info->idr[5], IDR5, GRAN4K);
+    if (val != FIELD_EX32(s->idr[5], IDR5, GRAN4K)) {
+        error_setg(errp, "Host SMMUv3 doesn't support 64K translation granule");
+        return false;
+    }
+    val = FIELD_EX32(info->idr[5], IDR5, GRAN16K);
+    if (val != FIELD_EX32(s->idr[5], IDR5, GRAN16K)) {
+        error_setg(errp, "Host SMMUv3 doesn't support 16K translation granule");
+        return false;
+    }
+    val = FIELD_EX32(info->idr[5], IDR5, GRAN64K);
+    if (val != FIELD_EX32(s->idr[5], IDR5, GRAN64K)) {
+        error_setg(errp, "Host SMMUv3 doesn't support 16K translation granule");
+        return false;
+    }
+    return true;
+}
+
+static bool
+smmuv3_accel_hw_compatible(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
+                           Error **errp)
+{
+    struct iommu_hw_info_arm_smmuv3 info;
+    uint32_t data_type;
+    uint64_t caps;
+
+    if (!iommufd_backend_get_device_info(idev->iommufd, idev->devid, &data_type,
+                                         &info, sizeof(info), &caps, errp)) {
+        return false;
+    }
+
+    if (data_type != IOMMU_HW_INFO_TYPE_ARM_SMMUV3) {
+        error_setg(errp, "Wrong data type (%d) for Host SMMUv3 device info",
+                     data_type);
+        return false;
+    }
+
+    if (!smmuv3_accel_check_hw_compatible(s, &info, errp)) {
+        return false;
+    }
+    return true;
+}
+
 static bool
 smmuv3_accel_alloc_vdev(SMMUv3AccelDevice *accel_dev, int sid, Error **errp)
 {
@@ -363,6 +453,14 @@ static bool smmuv3_accel_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
         return true;
     }
 
+    /*
+     * Check the host SMMUv3 associated with the dev is compatible with the
+     * QEMU SMMUv3 accel.
+     */
+    if (!smmuv3_accel_hw_compatible(s, idev, errp)) {
+        return false;
+    }
+
     if (!smmuv3_accel_dev_alloc_viommu(accel_dev, idev, errp)) {
         error_setg(errp, "Device 0x%x: Unable to alloc viommu", sid);
         return false;
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 3963bdc87f..5830cf5a03 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1913,8 +1913,6 @@ static void smmu_reset_exit(Object *obj, ResetType type)
     if (c->parent_phases.exit) {
         c->parent_phases.exit(obj, type);
     }
-
-    smmuv3_init_regs(s);
 }
 
 static void smmu_realize(DeviceState *d, Error **errp)
@@ -1945,6 +1943,8 @@ static void smmu_realize(DeviceState *d, Error **errp)
     sysbus_init_mmio(dev, &sys->iomem);
 
     smmu_init_irq(s, dev);
+
+    smmuv3_init_regs(s);
 }
 
 static const VMStateDescription vmstate_smmuv3_queue = {
-- 
2.43.0


