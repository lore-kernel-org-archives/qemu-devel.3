Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B08CF65DB
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 10:51:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkKBE-0002j7-8K; Mon, 26 Jan 2026 05:50:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkKAR-0001X6-41; Mon, 26 Jan 2026 05:50:00 -0500
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkKAK-0005uc-O9; Mon, 26 Jan 2026 05:49:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QI04JdoCXE0wtwzSqa4dKkAaw5X3qNuGtqQXSSBlJKax3vj0pIC2/wQ6Hmqh0bP7n97xBWUGk06A3vy+kPiKmiuzcThzx+libwH94KlLmFlCw5dNM1by2+GF8dl9W1OMPo/4FZJKrUYDQ1/84+4uNCbOlwXJOSjGi/f/xO6a3+phc2/R1rGSISOkkHMXGjNuIemJRhPl7lKEHpNuHbl3SBh+4g7IWGAn8oTMKKRfLdTXnwMSQu1085OT8/guWaFkpYCyQGs0P0Nis/d4ys+IZdewtgAKc5Ewn7M5GQLXw8Wi0hmibuu0Bgp3ZGHnQw2MPVngEn3+XylWnUeTK6T6yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m52r4TxU6csU1hkdxng+K9140zOy6CU4VRXrtdoxDgs=;
 b=xPZxqUNpHQF1V6C6dmfWAtveBFAd4yjefagE/qtrqnOCiiRlDkw3w7qctJRZqB8YjAi0YiE2A2EIGv+GIWDe+ZcQibLjS8/DFTrbxLK4vf/sRtzVJXVZVxl44wft/N1a8i65x3EUwesyg1v1t/bJijjukNcExl1xwKyG21OoEAMy+s5bXtAxQJF7hE8Izb0/5vIr6PSwoHxQvw7MDBiEeZwsvWh4tx8N0cAcfGqsobWBwkYCik21uw6nscZC6PBC7r07zEYYJHoABaFrUR9WhzgpMN0c9l1cOfk0dk9nMbx2373hFR0j3F/nwoqp7Gxpz+Rzg+5G6cfmqeVL8EmT1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m52r4TxU6csU1hkdxng+K9140zOy6CU4VRXrtdoxDgs=;
 b=DTpnGZqXZ6QMB3q8EIZEyFyUg3B87Q4+D1WQyXLHGF1aY7auA5VHvvn/emVbREQ4UZ6oSAqVb2y9JeJIUOzpvm8hXVA2uWa6MGJMUG7ZdsTmwmtie9xczUhWSkDN54IQloaV5b+gKe2wg6iAw7OcJsr6fdE2TtDluYgBradcSlx+LHWi0LhgB7hakMXSO+thQy5gMQaL4Wnz3F+Ztgx4AmxVfI+Z6HUnku2y5IQJXH3AH8waAIVp4mGnTLCEcR5Y9ZgqP//Vj7ZY5dXw9Y2LFZDgILffaM1rFzIvsahZGAGhMvI7zOM+TR1tZWjwYnDO+vTmDOACKMDJn4LtmzVGvg==
Received: from CH2PR16CA0011.namprd16.prod.outlook.com (2603:10b6:610:50::21)
 by MN2PR12MB4080.namprd12.prod.outlook.com (2603:10b6:208:1d9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.12; Mon, 26 Jan
 2026 10:49:44 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:50:cafe::39) by CH2PR16CA0011.outlook.office365.com
 (2603:10b6:610:50::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Mon,
 26 Jan 2026 10:49:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 10:49:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:49:34 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:47:00 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v9 31/37] hw/arm/smmuv3-accel: Add property to specify OAS bits
Date: Mon, 26 Jan 2026 10:43:28 +0000
Message-ID: <20260126104342.253965-32-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126104342.253965-1-skolothumtho@nvidia.com>
References: <20260126104342.253965-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|MN2PR12MB4080:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f1013f1-5f7f-4914-299b-08de5cc89dd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|7416014|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VkNXeUova2R0alFwOENuTkc1V0lKVDgxaUE4OTlJQjBCZWo0aFVkYlFpaWVQ?=
 =?utf-8?B?Zm9ScHBXTVJnUDIwT0E1WHBWZ21jMVZ0OTRDU3ZiUDJkVWlkR2dXaEJlc3lw?=
 =?utf-8?B?ay81Mk10RzBRWUZoQVR3bmFRYmR2Q0NtRFE1U0hpbGRka3NraTFMZnkzdFd5?=
 =?utf-8?B?VFVPb25zZitkL25wUk9HcGxqYTAxTHdBY21qUk81R05OZFluaE1jUmNNZjF3?=
 =?utf-8?B?aU5XUDUveWtzSjFMazhXWmdHWHhPNFpBNFUvcU5Ga1NsaXo1U0ZGdWlzTWpJ?=
 =?utf-8?B?eGs1THRpMEF0bUNQSjZMWHpUSjFmZGVHWElyOE9XVXJlaURKWkJrVzlibC82?=
 =?utf-8?B?RXVTSlFBT0Jid0dDTzZYT2YwUGJlWHI2ci9yQWFsTU9peXl5TThmRVRmc3VM?=
 =?utf-8?B?bitQaE5ONEF0UmszNlczeXdMaFB1ZzNtZTFGS3BHTjEwcStIL3F4eXFXYTNY?=
 =?utf-8?B?Qk9QazkxWllDMjg4MzBMKy9vWEVJYzFVWjJsTzVPNjlpUFJKZTNSYmVTelYr?=
 =?utf-8?B?RExFTUVJNzRYSVRBQkt5VmFudXZobHJ3SlZhZGdONTNMRjcweFFPaC9tN0Ru?=
 =?utf-8?B?dlpnc1ZOend3RE1iS3prYThLZWFTa2NxRHVYdGZWZzJESmVrZC9qR1BCdGJF?=
 =?utf-8?B?WDJCY2ZTUlgyWlNESnpwdHhkenREUWUwNHNoOHlRVkkwa0lURXdOT3dnYlpV?=
 =?utf-8?B?VUZ1SmNSd24zbHVFdENlMlBWY2o0dDR2VCs3dmhlMnJYSXFrY09OWEl5UC9P?=
 =?utf-8?B?RmtReXl1OUE0dnVUU1B3dWt2T2NvNGlnckJBN1VVWUlha3h1em5LMDU0L1Zy?=
 =?utf-8?B?SDRHQ3RSbWZKSUUrR1BReFhLREpJNW5rMXZnUVdGNXdZRnptNEIyREQvbFRX?=
 =?utf-8?B?TGVZRmdXOWdpbEdyYzRSZ0ZOWGJWSlRSWjY3Wk0zSm1MTWlZYjNId2tqdHVp?=
 =?utf-8?B?NmJhRGVtUTNGQjRVVVNpLzNmZk5ZUEJKS0tUWXAxdkJZY1hxd0FyTnJIV09p?=
 =?utf-8?B?V2lWbUd0K2xNdnJ5Q29KWnBidFphT2tLbWJ2eHBvV01UVEY2NkFOdHBEbjBT?=
 =?utf-8?B?aHN0aWpqTkNDRDlMQ041UDQ2TXorWFR2SE5Wb2tDSVhDTDdwYjNFUWMzTUtJ?=
 =?utf-8?B?U2Z1cm5hNjZyMmVGODZ4Z01DOEEvbU1wcXdCU3JQYWRYTFVtWkVSRWVBQnhh?=
 =?utf-8?B?R3h3dXRpU0xMdk14emFhd0p0bTNJaXhXL2JiRlZmeHFseWliaFJIaDUyK29t?=
 =?utf-8?B?TGhJTUdTSzB3TWlhbTlpUStVMDJGN3VzM09aZ1cxOXB2bjkvUEVOK1k1dGxv?=
 =?utf-8?B?cGZTN3Vmc0ZBTjVBNVhZYTNBM0Y2VEN1VktCNW02bEl2OWZpTFA0N0tOZXd4?=
 =?utf-8?B?bDlHZmdRVFhnM3NaU3dCRW1SYVNpSTNSemMyNkxzN3YzYlJGa3JSbU93TGJM?=
 =?utf-8?B?anFTZVNSeXQwalhISmhnVFNGWDJ5MC9iUDc0NTRLWkYrckVEZWdEeGxYMFVy?=
 =?utf-8?B?Ly9aVXdiN21RSlJQQk5zTTQ5UDhSc09KcFRjWjhqZ1ZESTNiQ1hTQkpSWjZu?=
 =?utf-8?B?K1Q0aE93SXU2d0xpSjNKTXlaRytBekYzaGROVGt3SVhYMXE2RUxzdm1tRndn?=
 =?utf-8?B?ejIwY3dXcG15U3N5eXVhYlpvMmtqeGc4YVhzNXlyTFQ0Mno4VytTalh5Tis1?=
 =?utf-8?B?TmlJNVEwNEZ3c3pOdlF1SFA2S3FmU0NCdjRoNWx4V3hNRm5ia0dQbUxHYmFy?=
 =?utf-8?B?M1RsYUgwNTNMSHpYeVNVOFVWS2lZcWYzV2w1TWx3TFRGekxsa3JLUWVJZXNE?=
 =?utf-8?B?N3lkdG9HNW9LMlJpdDlOcmVDN0xRZmJlT3EyTUQvWWROSVREOGUzeVJmU0xS?=
 =?utf-8?B?NW5BdkdRbEEwRmFXQjk5V2V0d2s4QkRMemxNaTNoWldSNEVISWhzczgzVzBI?=
 =?utf-8?B?WEhJYUtaMGI3UDZXQVpZSlBqMC9xVk1CL2FTSW9ueDhNYXI0UjZKa0VyMVpj?=
 =?utf-8?B?dzNtayt3NTJvL1RLSVlyNWhjVlplTEtoYnU5eFNnQ2kyWlNMQ05PM0ZoR1Nx?=
 =?utf-8?B?WXR5WVJNYXh3cFQxMmM5Mk5Sd0QxbkxPcEEvTjkvYmI1WjExSTNNZ21MdUdx?=
 =?utf-8?B?NTZoL3c4cTZPVXJPK0NBNWgycVM4Tmx1bmtGQm5hTXR2STZJWXJra3JVRGtt?=
 =?utf-8?B?dnJ2RndOelRRZkcrZVpvdElPSmpOZTZJbEd6Vi95Z0ozQU5zb0tFSlhYMkhJ?=
 =?utf-8?B?VThTZlIvMVV6TUdONmRVa0UxcjlBPT0=?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 10:49:44.2491 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f1013f1-5f7f-4914-299b-08de5cc89dd1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4080
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=0.587, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

QEMU SMMUv3 currently sets the output address size (OAS) to 44 bits.
With accelerator mode enabled, a device may use SVA, where CPU page tables
are shared with the SMMU, requiring an OAS at least as large as the
CPU’s output address size. A user option is added to configure this.

However, the OAS value advertised by the virtual SMMU must remain
compatible with the capabilities of the host SMMUv3. In accelerated
mode, the host SMMU performs stage-2 translation and must be able to
consume the intermediate physical addresses (IPA) produced by stage-1.

The OAS exposed by the virtual SMMU defines the maximum IPA width that
stage-1 translations may generate. For AArch64 implementations, the
maximum usable IPA size on the host SMMU is determined by its own OAS.
Check that the configured OAS does not exceed what the host SMMU
can safely support.

Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c          | 22 ++++++++++++++++++++++
 hw/arm/smmuv3.c                | 16 +++++++++++++++-
 include/hw/arm/smmuv3-common.h |  5 ++++-
 include/hw/arm/smmuv3.h        |  1 +
 4 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index a97abc1f79..ea420afeb7 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -27,6 +27,14 @@
 static MemoryRegion root, sysmem;
 static AddressSpace *shared_as_sysmem;
 
+static int smmuv3_oas_bits(uint32_t oas)
+{
+    static const int map[] = { 32, 36, 40, 42, 44, 48, 52, 56 };
+
+    g_assert(oas < ARRAY_SIZE(map));
+    return map[oas];
+}
+
 static bool
 smmuv3_accel_check_hw_compatible(SMMUv3State *s,
                                  struct iommu_hw_info_arm_smmuv3 *info,
@@ -74,6 +82,15 @@ smmuv3_accel_check_hw_compatible(SMMUv3State *s,
         error_setg(errp, "Host SMMUv3 doesn't support Range Invalidation");
         return false;
     }
+    /* Check OAS value opted is compatible with Host SMMUv3 IPA */
+    if (FIELD_EX32(info->idr[5], IDR5, OAS) <
+                FIELD_EX32(s->idr[5], IDR5, OAS)) {
+        error_setg(errp, "Host SMMUv3 supports only %d-bit IPA, but the vSMMU "
+                   "OAS implies %d-bit IPA",
+                   smmuv3_oas_bits(FIELD_EX32(info->idr[5], IDR5, OAS)),
+                   smmuv3_oas_bits(FIELD_EX32(s->idr[5], IDR5, OAS)));
+        return false;
+    }
 
     /* QEMU SMMUv3 supports GRAN4K/GRAN16K/GRAN64K translation granules */
     if (FIELD_EX32(info->idr[5], IDR5, GRAN4K) !=
@@ -657,6 +674,11 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
 
     /* QEMU SMMUv3 has no ATS. Advertise ATS if opt-in by property */
     s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS, s->ats);
+
+    /* Advertise 48-bit OAS in IDR5 when requested (default is 44 bits). */
+    if (s->oas == SMMU_OAS_48BIT) {
+        s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, SMMU_IDR5_OAS_48);
+    }
 }
 
 /* Based on SMUUv3 GPBA.ABORT configuration, attach a corresponding HWPT */
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index ca086ba00a..cb02184d2d 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -299,7 +299,8 @@ static void smmuv3_init_id_regs(SMMUv3State *s)
     s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, 1);
     s->idr[3] = FIELD_DP32(s->idr[3], IDR3, BBML, 2);
 
-    s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, SMMU_IDR5_OAS); /* 44 bits */
+    /* OAS: 44 bits */
+    s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, SMMU_IDR5_OAS_44);
     /* 4K, 16K and 64K granule support */
     s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN4K, 1);
     s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN16K, 1);
@@ -1949,6 +1950,10 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
             error_setg(errp, "ats can only be enabled if accel=on");
             return false;
         }
+        if (s->oas != SMMU_OAS_44BIT) {
+            error_setg(errp, "OAS must be 44 bits when accel=off");
+            return false;
+        }
         return true;
     }
 
@@ -1959,6 +1964,11 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
         return false;
     }
 
+    if (s->oas != SMMU_OAS_44BIT && s->oas != SMMU_OAS_48BIT) {
+        error_setg(errp, "OAS can only be set to 44 or 48 bits");
+        return false;
+    }
+
     return true;
 }
 
@@ -2085,6 +2095,7 @@ static const Property smmuv3_properties[] = {
     /* RIL can be turned off for accel cases */
     DEFINE_PROP_BOOL("ril", SMMUv3State, ril, true),
     DEFINE_PROP_BOOL("ats", SMMUv3State, ats, false),
+    DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
 };
 
 static void smmuv3_instance_init(Object *obj)
@@ -2115,6 +2126,9 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
     object_class_property_set_description(klass, "ats",
         "Enable/disable ATS support (for accel=on). Please ensure host "
         "platform has ATS support before enabling this");
+    object_class_property_set_description(klass, "oas",
+        "Specify Output Address Size (for accel=on). Supported values "
+        "are 44 or 48 bits. Defaults to 44 bits");
 }
 
 static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
diff --git a/include/hw/arm/smmuv3-common.h b/include/hw/arm/smmuv3-common.h
index 415b7ccde5..abe3565357 100644
--- a/include/hw/arm/smmuv3-common.h
+++ b/include/hw/arm/smmuv3-common.h
@@ -342,7 +342,10 @@ REG32(IDR5,                0x14)
      FIELD(IDR5, VAX,        10, 2);
      FIELD(IDR5, STALL_MAX,  16, 16);
 
-#define SMMU_IDR5_OAS 4
+#define SMMU_OAS_44BIT 44
+#define SMMU_OAS_48BIT 48
+#define SMMU_IDR5_OAS_44 4
+#define SMMU_IDR5_OAS_48 5
 
 REG32(IIDR,                0x18)
 REG32(AIDR,                0x1c)
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index 242d6429ed..d488a39cd0 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -71,6 +71,7 @@ struct SMMUv3State {
     Error *migration_blocker;
     bool ril;
     bool ats;
+    uint8_t oas;
 };
 
 typedef enum {
-- 
2.43.0


