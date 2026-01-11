Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC81DD2502D
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 20:02:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vf1aV-0002wl-10; Sun, 11 Jan 2026 14:59:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1a2-0002da-FC; Sun, 11 Jan 2026 14:58:33 -0500
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1a0-0004CL-Ft; Sun, 11 Jan 2026 14:58:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kQ7e5rprNfgkWrRbt4qX3LxrJQYOVbmFzEqPcC4vNZo2sQ2uQJU8xsgTZx3/+rPzjqCuXTshNn5jF5iFr03C357S3wyRQVZXmdsz6Z32oiKsspeEvgTKHNHghdroasd4C1Pi2AN8gFg/ZzXbnwMguZ6fqR4tiHQxi7eSYjym+b4IVlqQggzObHutYL1HOgp92yZVfYUutgDXMJb40I6u+yNPSiCAPUrM9YolPHBYJ+uQxDWUz2PAxfrvYe7sGUx+NqnprLi/Ao53cc+PT2OkOS4M/FtgTbIj9DscsU3dsH1rcjmtwLkMg0P3NYBMjTU0TFiI5yj0kWcBoz7CdXm2JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XXshay5UFH9gRIH75ilulVw+i734oQznY6F8pukll04=;
 b=P9eQqKdscQ7WAe6biurVKrQvx7ahV2BoXx1UMu/X+82zRrRIiXS7fUePpLLmKDxJ53QT3AxLiqGP0OeGEy3VqXZljZlO90TrFxFn3gXbcQsIuTdtYUS0r3J0UW/SnlXKzP1yg0xT/eksb97v1XL2nk9yDxX/xNSYQb6FlQgTSGwJ7fNksT8D7kzrMdeJeoaiUwcdIf63Jr+hVcR70fuGa5uioF9mjrEoIARoWZ9UOhKKnQEChmprbmoqyoJKl4jVQRM8USRGmGIJxRPBzGvSnEy22jFboTGaqMlpFBnpgixbmMwZS3H0CNAZBWhNKA0wJ07R1RXP8uZmi35DLYJjDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXshay5UFH9gRIH75ilulVw+i734oQznY6F8pukll04=;
 b=f0HFm3N4bSFEu5namrOxq7hrh0FrXfekfms3jqwk/OHcHb1rc5QeN/yilCCHpN9nIR+o+lWqaJq+LKZcBQrLkYGWWUf50Bs3ifQLNpw2u3SuyByj80cghaorlUOl5RPvg6e4kk+2vpMEh/ljwrGW/iVNqda3IcyDf+8FUdXg0hcnfpjMlnJ6M+STw9AZQj3V8IoT9fbBeURVoSBurGnBKzLNp51xsPqYHhRi9c+dZ8pATfE1ECDCikaw8yVCUVD0Oz8RTh8F7NhN75XrF4G2LHlg/g+8j4mKzRQn9QSnNI3RNTY6wgNezn0ow7a1fdbdmrAjuqZWJThyvInAj9gimA==
Received: from SA9P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::29)
 by DM4PR12MB5914.namprd12.prod.outlook.com (2603:10b6:8:67::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Sun, 11 Jan
 2026 19:58:21 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:25:cafe::64) by SA9P221CA0024.outlook.office365.com
 (2603:10b6:806:25::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Sun,
 11 Jan 2026 19:58:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Sun, 11 Jan 2026 19:58:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:58:14 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:58:10 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>
Subject: [PATCH v7 28/36] hw/arm/smmuv3-accel: Add a property to specify RIL
 support
Date: Sun, 11 Jan 2026 19:53:14 +0000
Message-ID: <20260111195508.106943-29-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260111195508.106943-1-skolothumtho@nvidia.com>
References: <20260111195508.106943-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|DM4PR12MB5914:EE_
X-MS-Office365-Filtering-Correlation-Id: d9dc31db-4e58-4b59-ed77-08de514bc5bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|7416014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZmtMdG5tM1UrUzdtZ1pSQ1NUYmhKU1ZucjAxd0RvR25BNHhrUWVaQWdyUDJl?=
 =?utf-8?B?VUE5K2g3Qnp6ekYrK1lSNElTRFVYUW5acktSQkFRYmlyT1E2MUtLUkxraks5?=
 =?utf-8?B?RmtBQld0aHVJWStUd1pqS3JHR1VwYklNTUhiZEkybXZxa0VXQ1JlTmhiMHlG?=
 =?utf-8?B?aWVmMzRzU0pReE1CK1lQSjliZTRRbDQzOGJwRnZFQW92NUVmVjVZWCtsWUds?=
 =?utf-8?B?YjYrK0dUS0hmQytsaCtzcUh0TXFYdnBEaitLTG4yL1l5ZFY5bnhsT0lnOUhX?=
 =?utf-8?B?TWMycDUzeGtuMHNZYWZSVlFGTThFMy9BenhSaWZiTm8yZ0NNT2E4K1JDWVh5?=
 =?utf-8?B?N1VrTzZXMXRGZ0EzTzBzUDJyV1J1b3E3U0dyVVhPWDJvNlB4RGh3V3FNUDdX?=
 =?utf-8?B?eTl6Q2NJMjdoa1p0NjdlM3lzK1FxeHpwOVp6Q3NqNi93RXMxdkJQcHptSkk1?=
 =?utf-8?B?cTZQN1VJOWhtV3VuNnhqNmF4WitTU2l3KzE1WEduOXBFZDZ0elBwNWx4cXRx?=
 =?utf-8?B?LytOakswRU9HeUFzTzVvZnlzdEJqRjg0RjRhWm04TXg5Z25nWVNPcEovUjBD?=
 =?utf-8?B?bmQ3Z0NBYlhmcDRsZVpqa1hzMUdCSkJsTXJ0blRjNHFTRmlZSUtBZ3FRL2hn?=
 =?utf-8?B?MkZtcy9sc09QK2RHSWhsS3RDalZaUk9EMHZrWDd4WWtUdncyTlE0R3dQZXJ3?=
 =?utf-8?B?blBvL2F5Unc2WWpwWDVXbmJOc3AwcGt5cnlGVVR3bGhVS3JSVXZBbnpEYlFs?=
 =?utf-8?B?Yk1IU2tIOHBuWFNJSGdEbFlWTkNlYmlMeUovaGpUOWdEMVdjQUdhQ0lPZWY2?=
 =?utf-8?B?S0RCMWRsVXFsN202RFhxY0dGSURnODlPVkZVNDJINitMaGhxeUl3S25HM0dR?=
 =?utf-8?B?Qi9nLy9PRjF0emljbHdjQUllN0RGYTkveXFNdXJpaC94aGFrUHZMQ0lCQ3RT?=
 =?utf-8?B?Unl3OU5GellwTlc0UHhpNVhuaW5oeGNOOE1uemx0MUIza1A1OU8vWVZLaHkx?=
 =?utf-8?B?bmx2NlBEdmtpYWhTaTFFMVhNWm5qaVdKbGxSV1dEMTN3eGU3amwxOFRDQ3ZC?=
 =?utf-8?B?WkJoUFFlM2Y2SkNVc3JLNiswQktKUXR1K0dnWnJxanlCMGRhOFNaWStnd1o0?=
 =?utf-8?B?QnRqL1dCaTIxNDJKYjB1em96THFKWm16YTU5WkxURzI4M3NveWxjTys1Z0d4?=
 =?utf-8?B?b0JKbXVwSm5qTFNOQVFLbGJCOVVSZVpNL00rWWJXR0ZFempLL0E4L1IvUlFX?=
 =?utf-8?B?K0cwdGFjVEgvZDh4eitpUHVWL21wODRLRWx1UXZJMlFZMVNzNXRtMENISDZN?=
 =?utf-8?B?TXhLRnV2Zk5iYkViMkZOd1BMNGk1NnhDRVRqKzAxa2JmWENJSzBLa0dFcmds?=
 =?utf-8?B?WktrSXdSdkFQQnRGK3RDQ2FZdFhoc2s0RzJnVjluUGg2eEFPcEh1dGJleGlW?=
 =?utf-8?B?TkdSaTFwOHYxREVINTlabTNoK25lWUhVeWF5VEo2QUdtVXpMRkpRVkN6czZC?=
 =?utf-8?B?SExQUmFuR0lrdmw3OVcrRXJKalBMNHhRYlBIb3QvdGdSOW1JZWtWTVJLYUxM?=
 =?utf-8?B?enkrWkhUVjFUMzMwekgycmc1Z2pvRTR3c3IvMGErQWM4MFJQYllyUFFVSmpo?=
 =?utf-8?B?S1RrZEIrRFlxRDZFUDdZang2eUdIWnRxNmNPYkJFU1daYmlBQThyZ3pvdHlu?=
 =?utf-8?B?dENnUVB0elhGWVZqTEdMOE4xRkcxVDZYV2RNVFl0VktZVE9GYUpuWFYwSGxD?=
 =?utf-8?B?YktMeTcvaHlBbHVGK1JUM29Ga2VFZnpqb1MzajU2TDVYZmdpUDdKbWcrZFh2?=
 =?utf-8?B?dk1sSGdCcmJoSzJFekZCZ2JOUTBJVGZxMmc3L3lXSVZGWG5KT3VQTnpUTlNi?=
 =?utf-8?B?djg3N0tkL05vUXk0YkpRcHpEcGkwbEF5WVh0VTdpWEN2K2FFM29sUjFycE9N?=
 =?utf-8?B?RG1XeHlIWmpQMEVZZkxHcU8yVFJROWdmZFB2eWFIcFF4ZENsM1dia0pQaWxU?=
 =?utf-8?B?cEtZZEVKL3hxYUl0MFlWYXNXZ0VGb3VDeDV3VzFndTU4UEJEejQrT01tMWhv?=
 =?utf-8?B?Z3hjQ1BqOU9XbDNENjFibUcxaG9hRXBvN2tJWVpkSmR1Q0FUS0M3L1l6RGF5?=
 =?utf-8?Q?RLYQ=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 19:58:21.3551 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9dc31db-4e58-4b59-ed77-08de514bc5bd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5914
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Currently QEMU SMMUv3 has RIL support by default. But if accelerated mode
is enabled, RIL has to be compatible with host SMMUv3 support.

Add a property so that the user can specify this.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c   | 14 ++++++++++++--
 hw/arm/smmuv3-accel.h   |  4 ++++
 hw/arm/smmuv3.c         |  9 +++++++++
 include/hw/arm/smmuv3.h |  1 +
 4 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 33011962e3..df82f1e32a 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -68,8 +68,8 @@ smmuv3_accel_check_hw_compatible(SMMUv3State *s,
         return false;
     }
 
-    /* QEMU SMMUv3 supports Range Invalidation by default */
-    if (FIELD_EX32(info->idr[3], IDR3, RIL) !=
+    /* User can disable QEMU SMMUv3 Range Invalidation support */
+    if (FIELD_EX32(info->idr[3], IDR3, RIL) <
                 FIELD_EX32(s->idr[3], IDR3, RIL)) {
         error_setg(errp, "Host SMMUv3 doesn't support Range Invalidation");
         return false;
@@ -646,6 +646,16 @@ static const PCIIOMMUOps smmuv3_accel_ops = {
     .get_msi_direct_gpa = smmuv3_accel_get_msi_gpa,
 };
 
+void smmuv3_accel_idr_override(SMMUv3State *s)
+{
+    if (!s->accel) {
+        return;
+    }
+
+    /* By default QEMU SMMUv3 has RIL. Update IDR3 if user has disabled it */
+    s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, s->ril);
+}
+
 /* Based on SMUUv3 GPBA.ABORT configuration, attach a corresponding HWPT */
 bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp)
 {
diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index 41b37e3122..a8a64802ec 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -49,6 +49,7 @@ bool smmuv3_accel_install_ste_range(SMMUv3State *s, SMMUSIDRange *range,
 bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp);
 bool smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
                                 Error **errp);
+void smmuv3_accel_idr_override(SMMUv3State *s);
 void smmuv3_accel_reset(SMMUv3State *s);
 #else
 static inline void smmuv3_accel_init(SMMUv3State *s)
@@ -76,6 +77,9 @@ smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
 {
     return true;
 }
+static inline void smmuv3_accel_idr_override(SMMUv3State *s)
+{
+}
 static inline void smmuv3_accel_reset(SMMUv3State *s)
 {
 }
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 8ca1d4ad35..cb619f19df 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -305,6 +305,7 @@ static void smmuv3_init_id_regs(SMMUv3State *s)
     s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN16K, 1);
     s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN64K, 1);
     s->aidr = 0x1;
+    smmuv3_accel_idr_override(s);
 }
 
 static void smmuv3_reset(SMMUv3State *s)
@@ -1926,6 +1927,10 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
 #endif
 
     if (!s->accel) {
+        if (!s->ril) {
+            error_setg(errp, "ril can only be disabled if accel=on");
+            return false;
+        }
         return true;
     }
 
@@ -2059,6 +2064,8 @@ static const Property smmuv3_properties[] = {
     DEFINE_PROP_BOOL("accel", SMMUv3State, accel, false),
     /* GPA of MSI doorbell, for SMMUv3 accel use. */
     DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
+    /* RIL can be turned off for accel cases */
+    DEFINE_PROP_BOOL("ril", SMMUv3State, ril, true),
 };
 
 static void smmuv3_instance_init(Object *obj)
@@ -2084,6 +2091,8 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
     object_class_property_set_description(klass, "accel",
         "Enable SMMUv3 accelerator support. Allows host SMMUv3 to be "
         "configured in nested mode for vfio-pci dev assignment");
+    object_class_property_set_description(klass, "ril",
+        "Disable range invalidation support (for accel=on)");
 }
 
 static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index 9c39acd5ca..533a2182e8 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -69,6 +69,7 @@ struct SMMUv3State {
     struct SMMUv3AccelState *s_accel;
     uint64_t msi_gpa;
     Error *migration_blocker;
+    bool ril;
 };
 
 typedef enum {
-- 
2.43.0


