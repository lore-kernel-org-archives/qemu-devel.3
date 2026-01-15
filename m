Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2896D33A00
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 08:28:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgIiD-0006BN-09; Thu, 15 Jan 2026 03:28:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vgIiB-0006Aj-A7
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 03:28:11 -0500
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vgIi9-0001YD-Jv
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 03:28:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PV8VQRwwP7u7RV7IkFnNiYtpKEKqS0DFLm8BIsG4FHlsuH71SgBr0MsFVNjegAfoqX+cwoTXn/ThRQcpk2vzmMjUkALyKt8H/4s1wmbOmS+sNaFVP5cIVWlEVBzfbabAwsGyqcZYtnD6LTLCTFtxXbS+U8Prfo3Ovmp3cWHlmvqYIlXhVCsACSO7fYc3+60F8TSQZByorZpDhoehW7uf+pBJfIKaGkwGOYRY0MpAG/gUqDLaLw+srovvy4cdZT47RtVgIVQ9uiY0EEVVXIkO7T/ROeyHuUzf01pP9Qjb17qwWKTxy85ubDvPe81ubD5ef2oKcLx/RpXD/KzaDaDE+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mna2o9dGInxBEJT11ydazxr1A5FWuSsgYWd+HvV4Dss=;
 b=WDCSIuopYPMs8TtCaNS6Q8M6/z34g/90IcnqBQSDYaXotd6k70qeYV6jJIaf5SSy0KHeuvo/qG782JeMq6aqdM8ekOvzHE2MEAiUp95LTibqTAZQ+JfDFrNbOx3nvIpITaZ9HvbXrAFBMfujh5LbY1zP5ODC/rQQKIO3lAZSsrmB1MmDctPr+D3shbtwEu4NbqA5JlmiYNdEiihErJBi8RN7AovcWvvWra8O/gAU5SX1ouXPD3zJE/27s3017oLNOcqx9bDMoc7RjiBvyA3CKOaOP8pR2Myuk39hvOkwzqAcKRTppmCEYS5E3HoeYG3ciZigwH7qltWt0/aW0Od9tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mna2o9dGInxBEJT11ydazxr1A5FWuSsgYWd+HvV4Dss=;
 b=RgkL3TIH0G01hsNKios8tFDa0h4yPh9TLWPqiUS0lybx6R9jxcHoSPPm6rq+wf22BIKcJV1DHi1mXIT0p3jgo/GXOFrNkgBvXhLfYNnbCbKJAivw44Abo110BdQKtW6Bi063M6wXIXmZZDwkgJQHHDA+PIrM3+tqrCaLGbjvbaE=
Received: from BN9PR03CA0099.namprd03.prod.outlook.com (2603:10b6:408:fd::14)
 by SJ2PR12MB8009.namprd12.prod.outlook.com (2603:10b6:a03:4c7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 08:28:03 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:408:fd:cafe::20) by BN9PR03CA0099.outlook.office365.com
 (2603:10b6:408:fd::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Thu,
 15 Jan 2026 08:28:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 15 Jan 2026 08:28:03 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 15 Jan
 2026 02:28:00 -0600
From: Honglei Huang <honghuan@amd.com>
To: <alex.bennee@linaro.org>, <dmitry.osipenko@collabora.com>,
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, <Ray.Huang@amd.com>
CC: <mst@redhat.com>, <cohuck@redhat.com>, <pbonzini@redhat.com>,
 <qemu-devel@nongnu.org>, <honghuan@amd.com>
Subject: [PATCH v5 3/4] virtio-gpu: Update Linux headers to add ROCM
 capability set
Date: Thu, 15 Jan 2026 16:27:38 +0800
Message-ID: <20260115082739.174224-4-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260115082739.174224-1-honghuan@amd.com>
References: <20260115082739.174224-1-honghuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|SJ2PR12MB8009:EE_
X-MS-Office365-Filtering-Correlation-Id: 65cf2439-5513-490a-c2ea-08de5410003a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eMAwYxFYYiV66mNuyO3eTHRHFiu6xAX0j8SvaCaOGipy0HHjYQo3d6R8w5sk?=
 =?us-ascii?Q?grXXnksUvM41FH4XCXrGex1bjmgASTOzCkNhlgWBpEFUL9LHq70fcBJuuvTG?=
 =?us-ascii?Q?2AK5dcQXWEWxUBxOmWEuYA6NXRRzcHXWROqp99T+e+Z0kGBc+QOorYcOExlR?=
 =?us-ascii?Q?H3HmaS+8JLSojbF9n431GmCYyvKjWvohYdkT++7yr8Qw6SrAq3+/X9dJpmcU?=
 =?us-ascii?Q?GHQXKukVOTEXVzbFbQ9tcXZ0D38h/C946Jnx2/+8pkVXayfHkwUSK0x9EIwu?=
 =?us-ascii?Q?P1LoWZz8u4x6hKPGLrrhch+7mKQ0aB/vgrHBISnPpS9wMfjOghjtUrmVBTlD?=
 =?us-ascii?Q?4R2bWB2PjBNXoNTAOCDGRGUi4bP9tPkirfm5i8J2eBM8AAAFQ3s82Es2zyom?=
 =?us-ascii?Q?letXfN0pHTxMVI1mUAKGP9UGIBdOf+cO2IK+IITfTEQOCr4b3jAjH3LO7sdb?=
 =?us-ascii?Q?weem/rgaKkh8Nt+0TKc65xfjPT+bnb2CUR1v9HG0QBvkcR3YCUemW737oNix?=
 =?us-ascii?Q?/WdSq1B13lSBPz30/HTgWRbFWfmEbttvkZtH3l4G7KX1+SCALajB9g4WD5S5?=
 =?us-ascii?Q?1vnAwKC3FZpyaThMFddTEpM5JllnhwksrJ32L0RLCBYC67hf5UnbiHnEtFIC?=
 =?us-ascii?Q?3d4cTC4mFM9kG3/P0X+ZQvqDlwbFWdMU1TVs1WsATTM57cKgtWvgrFc5/BtV?=
 =?us-ascii?Q?ZthUoH5kqtDdCEifVVQ154FmbqVsVl2msjgNXZthipO6gkj69F56J/0nE4Py?=
 =?us-ascii?Q?P0PFnypI4XV+T7PXrLqt4PQqOyZM7cddskL2rFpcCuPWB0SOKuq6Xo+pZHQ/?=
 =?us-ascii?Q?SNaVCVRaqPpB2LUMF9EOsvwXvr/neuFI7ZQpqaTfToFQwkrWaNeQFOThN4vG?=
 =?us-ascii?Q?b9WnvoLdcA6VpLzhZWet58wQgcvUqWjqmKf3/ZXcM+3r4dZv1/iRhaX6Pyc2?=
 =?us-ascii?Q?wH9jRvYdZN4/mlorGQOF0sy3osn5MRx81rHQ0AIlDKXjeFfgGE3P3mt3xOhR?=
 =?us-ascii?Q?XXxx4onen5AgTGZkdgkD3BjgScpv/3BcBKCIi2GKtQtymOb6ZDmyW1LQgg62?=
 =?us-ascii?Q?q7hDChNHRlMMLoMMvY2PJ6R/RB6IC6WshDbWlYPq/ZJoo8oHDk99Xn6WVh4s?=
 =?us-ascii?Q?mVlabzoyMlrMz+M/9ti+82Gr7uPzslUc79q+A4uHtT+rxXI6louYhAoVmi12?=
 =?us-ascii?Q?DngyC9tjfB1VIGH3oAO92FA/M8xgUB/mSOe61CCkVQayqi5hmHg745xGsA5z?=
 =?us-ascii?Q?JO3KBH/tYp1fGQCVApNhFH/WveMrne1xOndCd8JRyMbmQRrPmPOy1fRWWqlr?=
 =?us-ascii?Q?BtldYQ3WZ+eSw+hw45sqU+ZsSTPF1IUdHc01PhXqbHikFLr+bLJCKaDHF1NS?=
 =?us-ascii?Q?jdVaeYIIm8VPAQhlgPN3WXqG+tLfYTdf95G4XtKTMXkLd8yrEkHzvoAjHCG6?=
 =?us-ascii?Q?ecgmC4elj/fGM5w1x8aNQfG3ojDiNY7lyBjzzVtYZuD45dWrymVl7qekm7EB?=
 =?us-ascii?Q?cnsO5nvj97mkeGmLmE3ymQ18ElMP043/61HcKDwGw3MUbtLMxR6ARaQ44zaG?=
 =?us-ascii?Q?iyc8wTTvMwBso3E0/7g1IEXxtq1zVI7hDXYBXEfta2QMM7JGp/MsdwJcqQfd?=
 =?us-ascii?Q?XamABhT2q8JF1RnVrw3noUvudBjBciKsmZtF871xjZfW0YTCKSfdDifYS+7j?=
 =?us-ascii?Q?MMbbeQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 08:28:03.2805 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65cf2439-5513-490a-c2ea-08de5410003a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8009
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=Honglei1.Huang@amd.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Update linux header same with the related linux patches.
kernel headers, which introduces:
- VIRTIO_GPU_CAPSET_ROCM capability set definition

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 include/standard-headers/linux/virtio_gpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/standard-headers/linux/virtio_gpu.h b/include/standard-headers/linux/virtio_gpu.h
index b562f5d6a0..1cc6744782 100644
--- a/include/standard-headers/linux/virtio_gpu.h
+++ b/include/standard-headers/linux/virtio_gpu.h
@@ -317,6 +317,7 @@ struct virtio_gpu_cmd_submit {
 #define VIRTIO_GPU_CAPSET_VENUS 4
 #define VIRTIO_GPU_CAPSET_CROSS_DOMAIN 5
 #define VIRTIO_GPU_CAPSET_DRM 6
+#define VIRTIO_GPU_CAPSET_ROCM 8
 
 /* VIRTIO_GPU_CMD_GET_CAPSET_INFO */
 struct virtio_gpu_get_capset_info {
-- 
2.34.1


