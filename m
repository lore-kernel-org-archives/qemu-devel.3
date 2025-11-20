Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB38CCF8855
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 13:28:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM4ei-0007Kn-FU; Thu, 20 Nov 2025 08:25:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4ed-000741-8s; Thu, 20 Nov 2025 08:24:55 -0500
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4eb-0002MO-Ja; Thu, 20 Nov 2025 08:24:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ewDgN0pi9fg4Fq5GimUVeduZEeHVc6SBnWlvbBhB+R4OwTNQvFB13SJPadwf/mxl9JHqI55SOuw1BnDOiefUgSz3IetZnrsAhOYVMaUMrv7pjQ2k4itU71FE3uJzs9vv5FjAd6q2Ua8u3f52oY4/BdvHOWYxtUaq8sGE03VhgKXuYp1/0VO34RCwZKnH/JFqhRqyjO2QwnyZYaD9IOWRBn16MaUoQ7u4vGnsyCGrRAbzE3jVyd9CwhEXmXiY1YMeOhF+LVwiNA/nl+eTylqnw0KAj6LqpYhHQT3X4vDWWQqakCjGWH/mid7jKo7+hOxM07/SEtYUHpy4I6LL+vW5sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QaCVTadTFzrw40agL01hJSklDU3dNr7bmS5mcflUS4U=;
 b=fafkABhbYTCO3YJqX4G4BJb7o9wy0JIZKkKztrkuNwwIs9v4ll+4ZhC/SPE8em+PjJjvu3DGb8zmRJqHwRnkVDiG+z5VmeZd0HHNeUqqPa+LFGEJWdeORI7Z3Ddl8OizGXOXmDrIQwOSws1Ff601MohUcdG9pikqpZwdZ3px+pJqt2ELr1GIwNzjuuExkUU+rYYmuMh7Wjk3hU6CklgcIFaZMyDSLvCQfHhCtzS09sG1QOB/nEKWE7uqXvndo2Zq4+qvucwePqIb2Tb0aVtSljytuj+NbMfltl2+489WHW1z+B2GsLDMLUIsi1dyPX9WYDxyllxfnA4AmuyB0UHCVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QaCVTadTFzrw40agL01hJSklDU3dNr7bmS5mcflUS4U=;
 b=UTeQFBc+nEkLv3P+ZA98+yFJTGMf+zwsng21dYJQI3TD51MQ5Fw3HfkDmrRFyINcfXWD79PHMfRuh44KcZnlUwzNo0crQwB+XKoPj/Xa24f7IUQKD0ETzp6w3lVfUPuCkak/5Pz+8LAPR58x4opO2BjzuZkCh+DSeCZKdwXuXDCaoFW6ijFVf09Ll6ezdgOEVBHOKqRfnX5UAU8nGlrPBrkO3NqsR5yts0VBwGjkKz4SjT3GJF54Qz//hWWg1ToY7yQ/cfPB02X5WAiIIxS0n51KFnxmesfn59OnrLW6ebTTxZv58Ts3X02geAVcDk6oLFbLfOOvW/qP98H2lbqvcQ==
Received: from CH3P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::28)
 by DS4PR12MB9611.namprd12.prod.outlook.com (2603:10b6:8:277::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 13:24:48 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:1e8:cafe::f3) by CH3P220CA0004.outlook.office365.com
 (2603:10b6:610:1e8::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 13:24:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 13:24:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:24:34 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:24:31 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v6 18/33] hw/arm/smmuv3-accel: Add support to issue
 invalidation cmd to host
Date: Thu, 20 Nov 2025 13:21:58 +0000
Message-ID: <20251120132213.56581-19-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120132213.56581-1-skolothumtho@nvidia.com>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|DS4PR12MB9611:EE_
X-MS-Office365-Filtering-Correlation-Id: 89b9b8ee-643f-4a61-b510-08de28382dc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VU80dlUzc3dVejFUUmdWZzBuWGZRR1pYR005c3orR2NRSUZzaURvTEtHclNJ?=
 =?utf-8?B?Zkl0YmR5alVPOG5xNEVCVEIvU2lzQjBZUUVMa1FrL1V5QUh4amNKZklBemNZ?=
 =?utf-8?B?M0tuenZ4WHlIc0lZb05VVGJla1IxS3RPSW5Rbmk5N1ZDVlBRUTArTWJDRm5D?=
 =?utf-8?B?YVM1aEtiWUhwMWNZNW1QVkliWVRkcDVPc0t0dGU5aWtPcTQxZmJwZHplNTl1?=
 =?utf-8?B?YVVBdVpuT3JaVjc4VEFxcW9sZEZYRHZGWHg5WDBRZmppNHZmR2JZL2JnZk0r?=
 =?utf-8?B?SjVGQVpMdWhzdGZyeFhOelVub0JWSVloMEdVMUJuRTd5V09Falg1WXJkSDlr?=
 =?utf-8?B?Ky83Y3UzUDJJSTBGaWRSVEtHNG5XS1BCd3hDWlpBemVjQUgxTVFuRWZlYVdD?=
 =?utf-8?B?WWpJanlaSllWd3VFcERqdWJ0bkhhdzZ3U3plRHNFMlBCNEtJcG0wZEVqSXk5?=
 =?utf-8?B?dms5MXloZjVUMXVuZlVSUi8rdVVaL1plZmQzMXM1aWcyZitqUHZ6M0xyOXZm?=
 =?utf-8?B?bXh6ZmNLVWY3Wk0rd1dnTDRSQW1HUUZGUUdyRUZqUThMeXgreWNlU0tHOVl1?=
 =?utf-8?B?RDZIamhUbXlXTEhMRVZvT1FrNHRxbFdRVVl4RVFuTE1rekh3YkNUS1R6NFYy?=
 =?utf-8?B?UkdLVHBvU2JkZzhFbzAwY0ZGejlTTnllVG4xdDlOZXBaWFl3UlRLd1krdytr?=
 =?utf-8?B?UlI4TnVFYXFEQ3FFaEtzRnZKRjgrRHBDM2NqaFpxWHk2eEk5eGhCUTZXeTYr?=
 =?utf-8?B?TnM1WkdUZ09PcDg0M1A3dHdOZFIrWGFWcXl4WURYUTBsYVBIMmtsc3VRTjdt?=
 =?utf-8?B?Ym05RG5lckplcmdQdjlSbmFwdDNZcEczUnhuMW5lODVZZ0dQRVRxQkNocTl5?=
 =?utf-8?B?SVpaWklLNmhDRVYyaVR1UTNIY3M0ZVBjYTQ0Q0E4SFVzVWRzanRqN1ZycG5J?=
 =?utf-8?B?MEtMNzJiWko1RGdjUFF3VTRLd3ZObUZ3VXR1cDEyVE0yZzl6aUxDR0pMUEZu?=
 =?utf-8?B?UngzeWtpSzRoTnB2WVYwZ0ttM080cWdHTUUvb2ZScXNiSURYajF4MXNNc0ls?=
 =?utf-8?B?NDdHQ3R6UU1NS3JTRHJpVGtoWVcvTE54OXUyS0RBbUpUSkFJR0NpbGFrMzF3?=
 =?utf-8?B?N0xYY0RuOG9UcXhGQzJCSmNWWEhqQ04rbUNMaUM2WWUySml1anV3UDFWemtO?=
 =?utf-8?B?V1JNM1pvSGxKc2ErMVVONHExelN1WGZRdHVYRWJPWHNjV0VrUkg4QjUzQVAr?=
 =?utf-8?B?UDlyRGg1Z2NSeFVISkMyRjdZMnc5Yk9idHY0bnZ1dGVGMlE1YmQ1U0RGNmNS?=
 =?utf-8?B?bm12c1hrWm1HdFMydnA0YkJBWVVlUHp1d1gwcm4wWHhaZXV3aElndG1Kb3pN?=
 =?utf-8?B?eUZTWVdGUUJVQUc1bit6c2NYWFFzc2w1TDlOSkRGbnlnMm94QVlYQ1VOdE4z?=
 =?utf-8?B?Q0swNVg0NlRNL3pYMmJBY29DU09TdGw4dE5LTFBDSGY2T3V0c092SGtqZ3R3?=
 =?utf-8?B?NVMvVkFsQVV6dDFkVm9wVXJ0d0F2ekE5S1o2QzFHTUozMUluZ29YOFVVNmFr?=
 =?utf-8?B?MXBmdm5OYW1xcTJNK3ZwY1JPc21EYllzU2xiMHZFUmY3ZVBhNXB2T2ppd3dR?=
 =?utf-8?B?TmJMWTNuaDdZbC85aHdCZDVwd3dlRENuLzBqd010MHBjMjFXN05rakpIQUNC?=
 =?utf-8?B?aitFODVsVFUwbC9XOENtNVl4RmF5amtCanAvRmRNS0tvdm1TazY3Rk9PRlpK?=
 =?utf-8?B?Zzc1V2pmVU5sdFN2YnNnRVRSQ2tZdGRjNFVuYzEzUUZRdUN5c3BPeFVRekQy?=
 =?utf-8?B?ZFhoVEJ4UDgrZnFRWCtGMHExM3lqbmE2cDcyZng0akRlMjZuYzdkdktrMUxr?=
 =?utf-8?B?RUQ4bnNkSytId3g1cjd5WThLMm9BSEZ1aHJrQnlsYm9MUTVQd0dRbHpIOHdx?=
 =?utf-8?B?c1REZVVaZTZKcTVpVXJvQUZabGphdFJ4bWROVll1T3pvdDNsSzNtQ1pTclND?=
 =?utf-8?B?ODlsV3VHNXNWcW9ZaFgwbEd3cFdFMm5ld0N0VGgzN0x4d1doZ3BSRkE2cmVV?=
 =?utf-8?B?Q3NUdi9lQnBQUGxLaFBoL0hwcnhYQzNQc2FzRzdMSk9NWXhydkpldkZrdmV5?=
 =?utf-8?Q?YajM=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 13:24:48.2852 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89b9b8ee-643f-4a61-b510-08de28382dc5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9611
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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

Provide a helper and use that to issue the invalidation cmd to host SMMUv3.
We only issue one cmd at a time for now.

Support for batching of commands will be added later after analysing the
impact.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c | 36 ++++++++++++++++++++++++++++++++++++
 hw/arm/smmuv3-accel.h |  8 ++++++++
 hw/arm/smmuv3.c       | 16 ++++++++++++++++
 3 files changed, 60 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 8f7c0cda05..a7291e75f1 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -233,6 +233,42 @@ bool smmuv3_accel_install_ste_range(SMMUv3State *s, SMMUSIDRange *range,
     return all_ok;
 }
 
+/*
+ * This issues the invalidation cmd to the host SMMUv3.
+ *
+ * sdev is non-NULL for SID based invalidations (e.g. CFGI_CD), and NULL for
+ * non SID invalidations such as SMMU_CMD_TLBI_NH_ASID and SMMU_CMD_TLBI_NH_VA.
+ */
+bool smmuv3_accel_issue_inv_cmd(SMMUv3State *bs, void *cmd, SMMUDevice *sdev,
+                                Error **errp)
+{
+    SMMUv3State *s = ARM_SMMUV3(bs);
+    SMMUv3AccelState *accel = s->s_accel;
+    uint32_t entry_num = 1;
+
+    /*
+     * No SMMUv3AccelState means no VFIO/IOMMUFD devices, nothing to
+     * invalidate.
+     */
+    if (!accel) {
+        return true;
+    }
+
+    /*
+     * SID based invalidations (e.g. CFGI_CD) apply only to vfio-pci endpoints
+     * with a valid vIOMMU vdev.
+     */
+    if (sdev && !container_of(sdev, SMMUv3AccelDevice, sdev)->vdev) {
+        return true;
+    }
+
+    /* Single command (entry_num = 1); no need to check returned entry_num */
+    return iommufd_backend_invalidate_cache(
+                   accel->viommu.iommufd, accel->viommu.viommu_id,
+                   IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3,
+                   sizeof(Cmd), &entry_num, cmd, errp);
+}
+
 static bool
 smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
                           Error **errp)
diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index 2d2d005658..7186817264 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -45,6 +45,8 @@ bool smmuv3_accel_install_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
 bool smmuv3_accel_install_ste_range(SMMUv3State *s, SMMUSIDRange *range,
                                     Error **errp);
 bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp);
+bool smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
+                                Error **errp);
 void smmuv3_accel_reset(SMMUv3State *s);
 #else
 static inline void smmuv3_accel_init(SMMUv3State *s)
@@ -66,6 +68,12 @@ static inline bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp)
 {
     return true;
 }
+static inline bool
+smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
+                           Error **errp)
+{
+    return true;
+}
 static inline void smmuv3_accel_reset(SMMUv3State *s)
 {
 }
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index f02e3ee46c..513da966a4 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1388,6 +1388,10 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
 
             trace_smmuv3_cmdq_cfgi_cd(sid);
             smmuv3_flush_config(sdev);
+            if (!smmuv3_accel_issue_inv_cmd(s, &cmd, sdev, errp)) {
+                cmd_error = SMMU_CERROR_ILL;
+                break;
+            }
             break;
         }
         case SMMU_CMD_TLBI_NH_ASID:
@@ -1411,6 +1415,10 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
             trace_smmuv3_cmdq_tlbi_nh_asid(asid);
             smmu_inv_notifiers_all(&s->smmu_state);
             smmu_iotlb_inv_asid_vmid(bs, asid, vmid);
+            if (!smmuv3_accel_issue_inv_cmd(s, &cmd, NULL, errp)) {
+                cmd_error = SMMU_CERROR_ILL;
+                break;
+            }
             break;
         }
         case SMMU_CMD_TLBI_NH_ALL:
@@ -1438,6 +1446,10 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
             trace_smmuv3_cmdq_tlbi_nsnh();
             smmu_inv_notifiers_all(&s->smmu_state);
             smmu_iotlb_inv_all(bs);
+            if (!smmuv3_accel_issue_inv_cmd(s, &cmd, NULL, errp)) {
+                cmd_error = SMMU_CERROR_ILL;
+                break;
+            }
             break;
         case SMMU_CMD_TLBI_NH_VAA:
         case SMMU_CMD_TLBI_NH_VA:
@@ -1446,6 +1458,10 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
                 break;
             }
             smmuv3_range_inval(bs, &cmd, SMMU_STAGE_1);
+            if (!smmuv3_accel_issue_inv_cmd(s, &cmd, NULL, errp)) {
+                cmd_error = SMMU_CERROR_ILL;
+                break;
+            }
             break;
         case SMMU_CMD_TLBI_S12_VMALL:
         {
-- 
2.43.0


