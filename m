Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D34A5CF6BF2
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 07:51:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdOJw-00050U-OC; Wed, 07 Jan 2026 02:51:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vdOJk-0004nt-1Z
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 02:50:56 -0500
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vdOJi-0003Ge-Bg
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 02:50:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I6TGtj4lTlcs4kbJ+z02v6jAr2kugh7MD9uUh0C3jTbdMZDReDaSgVubsVbGwYKRmStMKEMs7pQx7a4CDE4b/WIGzo6LtwOHNUx1d9xk7EFICUOC97mqZM811gjITLnLNcSyIoZlm91CbjOobvt8nwrHgck6ZBjbQvz1soAf6GkuadK4tiAR30X1jZwBhPCTSJ4PzGcTmHBp8TMqfuY/CpLnmfxaRb8ppZHex+1QaL+6500rVci2lCcoc753ZwN1dDb5zjG8Qx4Oz8lFdFZ49jeSmgcClWf2lj1VbtSG8+hxpdbbYqJwlgAR9lrtNJaOufyhVE9R323gygVdQQsXoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=plcG1Zgk8gZcgXqp0Uf8sV7mQnm9tsaogalN4N03Mb8=;
 b=klzQT8zd7SEZGtUPedxsEA2GaSTBAzmHWDRMr290FQ5xKblUMFJbTEpm49x+RbvgdI/ST22Vld5GTyxeqkDVFOSaHK+qL9M2sQe9MTkEjaAfbAgQtUc6ZIOSGao/TI6YPHQjMZmGKhJrJAUO2kzAvCVaKh5L6zCblGoWy9IumSj6dPkxHKP4+uqdzN6Z2970eEvRybV59nnaHb3HgfZVkujdutzq2k+PcpZDBVQKzpxsu9K2wzCdNaSdvf4/8EOdSV7vSClrmnLLy5UgzbYibg8g8U1MMVmC6zrZBi4B5YBTiu4C9xPLtGYW+zm9gwsy28QTkWDkNao19YIod/HAJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plcG1Zgk8gZcgXqp0Uf8sV7mQnm9tsaogalN4N03Mb8=;
 b=ynmkhDkhIYUQ/f86MZkRF0Mq9k6lSgsrBQoRHXohqXKjLhHrWftOPX+xWuae1UWrV9I8yCVpyc18cySRs8VJeqhrHn5DlKEXy90FdG6YJKtRZ39OwUrzZXlb4UCEjWpnLOAdb5VGnCKn0wHQ9Fvb140TUQFIuaZQRsVapFu97Nk=
Received: from SJ0P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::35)
 by DM3PR12MB9436.namprd12.prod.outlook.com (2603:10b6:8:1af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 07:50:49 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::73) by SJ0P220CA0019.outlook.office365.com
 (2603:10b6:a03:41b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Wed, 7
 Jan 2026 07:50:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Wed, 7 Jan 2026 07:50:49 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 01:50:46 -0600
From: Honglei Huang <honghuan@amd.com>
To: <alex.bennee@linaro.org>, <dmitry.osipenko@collabora.com>,
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, <Ray.Huang@amd.com>
CC: <mst@redhat.com>, <cohuck@redhat.com>, <pbonzini@redhat.com>,
 <qemu-devel@nongnu.org>, <honghuan@amd.com>
Subject: [PATCH RFC v4 1/3] virtio-gpu: Add support for
 VIRTIO_GPU_BLOB_FLAG_USE_USERPTR flag
Date: Wed, 7 Jan 2026 15:50:28 +0800
Message-ID: <20260107075030.3453924-2-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260107075030.3453924-1-honghuan@amd.com>
References: <20260107075030.3453924-1-honghuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|DM3PR12MB9436:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b79f0a2-073f-4486-37bf-08de4dc1797a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kWjNgzzn+4JeJAu0lyllpdtjnnlT+Yn1715GDgWa0QU6hRMoubF7wIdmRWgE?=
 =?us-ascii?Q?w6SJBvA9O7VMabRXtZbb0dPWRkP2SvoFpc7TKv0l2pzXSIkQRiy+PINdY5oW?=
 =?us-ascii?Q?2iAKfRWK8al/r0rRXX1i+djJ/t1Y6yDIJkOZWakMN24K19VtGglr9j5Fg7qj?=
 =?us-ascii?Q?4OYKFu53XNfURAH1r2GgCqWJ8fitgqlJDSFexwSBmEWurXc1HGJY3rP6tLtD?=
 =?us-ascii?Q?75Mbz5n1n2ZD/Qcix5OOgsgWIPzOzOmMN35LnyIe9iXB88nDNE+AAXBzsxZ5?=
 =?us-ascii?Q?nVYGLobhRGdgMX84KOUOoJNB/Z85vr0DzwEJefYp3mnh3IljyLFnwyNOpdgj?=
 =?us-ascii?Q?QKPTGoc8OxLhE3bqqJfK00EYJDjFnw5kDwZDnkxV/GrAR1fqEit6//C2mrSm?=
 =?us-ascii?Q?q+WTMRecTO4bC5oOzsLiSCI9T0bVY77VdpNfode1YmpyMWDN6vJoRYb2mZ5q?=
 =?us-ascii?Q?y5sg1qnO+VAJJGm8C2SAC2C7LsEFnlXkTdnAuB9ntALnWZnQ7ARn6rXnZzB8?=
 =?us-ascii?Q?t6AEM231NKS9HnHz1+agKHX3Jt+Ec91xBSUcrZk4QPl2Ln9MjiOCFZnv/b0w?=
 =?us-ascii?Q?IRxjidhFZProzQTrdwuWXNpn7+SXG2tf1szmhoWnb3nexNhpRfcKbJ1gOZMF?=
 =?us-ascii?Q?3i+CtAbeLtL5IAWl10iZlhxHrg/K478cN0jl5J9vsbKFo8KxcrAg+UlyTgQK?=
 =?us-ascii?Q?nRkY1RAC2yF1eqYbxUohbl2nV6GIdt9+1A4NSJQ8bwjos2QNSH2x23N8I2m3?=
 =?us-ascii?Q?OpJTUEvouMKY9ILhd7qRpugjIklrDYZ44BC2HX6xaOARFy75f3hcsYE65I0L?=
 =?us-ascii?Q?KMWVYG/+gsUL3DKZlvUL57F6CbRvD7XHn4Odq7Bh7udfC/WDTU/bDRZouK96?=
 =?us-ascii?Q?dkl9OKXytCRV8YahjrSQtUwSvnG9ibwA+qG+oZuZVfoMS6c/W0A5EfxzqG0B?=
 =?us-ascii?Q?xsb8oK2uJE7Mzwz3XwTc02J7UgZI5f/sL/hezmseIOE6Mzb+Hv77nXCSjWCu?=
 =?us-ascii?Q?aLeSn0deT+cTT2YXXtNDZ5Dfc8hUiyOKJ4VlYm20myU2m+u1vQ5+FNzsKc5L?=
 =?us-ascii?Q?dNyJk3wuXAaRpNo4TF4oMj8MXyUX6Nhv4CSsMX9C4CSgyPyFT6tyTpM/NH6v?=
 =?us-ascii?Q?D1M3jA2K6FlKXmHdLJX0aXi1TTRIbRoRUnr5E4ADIPb8qstj/CTw6Lz4pdHt?=
 =?us-ascii?Q?OhpVWnCBvxbbbI9H99X68A5smno8zUPudUxSEFEZlsi0WDtkclG/6VRoXIMa?=
 =?us-ascii?Q?Z/SjF3MFRGzJICR1nyOcjX1M8vq7Lce6grNguzFDh31788SkwAw1nMMHQ5zA?=
 =?us-ascii?Q?jvJB9tNwioJ+/uLVp3+kYMWp6SvvQzYh4YtzAZTmeA9jflCyzCPyv9Q3HOD/?=
 =?us-ascii?Q?3GDHG0aVgyXyREGcZ/66XDCtYRk5hc1aRoX7ZhkWJvctwteT5Ar+G/LB+Fkq?=
 =?us-ascii?Q?dXyO8lsb6NtQ7TKGPvR4gKHuJxTaSaty1rED41yf4ceAfRbxYiSiVXUhWgw7?=
 =?us-ascii?Q?B7hw+r0P/NKTz0v5svtEKBvB1sktcjzPNhjjOI7XV7DucHp7u2T7M9Jz9kaf?=
 =?us-ascii?Q?hPCj5qiPxrbEcZopgxU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 07:50:49.3910 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b79f0a2-073f-4486-37bf-08de4dc1797a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9436
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=Honglei1.Huang@amd.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
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

Add support for the USE_USERPTR blob flag in virtio-gpu to enable
user pointer mapping for blob resources. This allows guest applications
to use user-allocated memory for GPU resources more efficiently.

Changes include:
- Add VIRTIO_GPU_BLOB_FLAG_USE_USERPTR flag definition
- Enhance blob resource creation to handle userptr flag properly
- Remove arbitrary nr_entries limit (16384) in mapping creation
- Add conditional handling for userptr vs regular blob mapping
- Support guest_blob_mapped parameter for virgl renderer
- Fix value check issue in virtio-gpu

This enables more flexible memory management between guest and host
for GPU virtualization scenarios.

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 hw/display/virtio-gpu.c                     | 7 -------
 include/standard-headers/linux/virtio_gpu.h | 1 +
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 643e91ca2a..17df148920 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -808,13 +808,6 @@ int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
     size_t esize, s;
     int e, v;
 
-    if (nr_entries > 16384) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "%s: nr_entries is too big (%d > 16384)\n",
-                      __func__, nr_entries);
-        return -1;
-    }
-
     esize = sizeof(*ents) * nr_entries;
     ents = g_malloc(esize);
     s = iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
diff --git a/include/standard-headers/linux/virtio_gpu.h b/include/standard-headers/linux/virtio_gpu.h
index 00cd3f04af..b85e781a2d 100644
--- a/include/standard-headers/linux/virtio_gpu.h
+++ b/include/standard-headers/linux/virtio_gpu.h
@@ -405,6 +405,7 @@ struct virtio_gpu_resource_create_blob {
 #define VIRTIO_GPU_BLOB_FLAG_USE_MAPPABLE     0x0001
 #define VIRTIO_GPU_BLOB_FLAG_USE_SHAREABLE    0x0002
 #define VIRTIO_GPU_BLOB_FLAG_USE_CROSS_DEVICE 0x0004
+#define VIRTIO_GPU_BLOB_FLAG_USE_USERPTR      0x0008
 	/* zero is invalid blob mem */
 	uint32_t blob_mem;
 	uint32_t blob_flags;
-- 
2.34.1


