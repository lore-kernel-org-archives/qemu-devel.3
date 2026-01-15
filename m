Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA05CD33A0B
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 08:33:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgImz-0000nr-SJ; Thu, 15 Jan 2026 03:33:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vgImt-0000eD-Qd
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 03:33:03 -0500
Received: from mail-centralusazon11010032.outbound.protection.outlook.com
 ([52.101.61.32] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vgImr-0002l3-Op
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 03:33:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dHXz6G1YWkOWReUS53LyHfrcuspXb5SRF1+PmcYVXd6uRCtIwIwFTJrHl6IizoPnDKZSX33i0h3bfPh/omgbVycdQDI3BSRniq6x/hRSHizHDx1m3hdZvxrOaIHg8AJ10Ext+qsnMY8l5yBHdwqc4eeZ7q/CSpI+phJ0STZyxJ3pZjOxXyF3HHoPIupSB1eXm9DqYELDrp08odesU4JPWz0hO045HkMApvwg0L/2QNjsh0pKwEPofxAvph8NYqKj8vqjeeXoYOOLNbxGgYUXedzVBDyNoh97zt8pkS09Z0b8lLB6504/MS++dqxN+4KAH1XeQS3mvENMBqXO3Kb5dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wkyqXMXeRZTC/CUqrVHZw1dPYLfWVEv48aAxLfVwCCI=;
 b=f6iovKxSqeJeMOKgJaouKK/okwfSQhelMrMK4dNsHMKIKKck5JxhkzQFYmRINLsNt4eohdE1BCbhJjK8EKhFV/nr5XEQ4jIxBLmf3bA+nn7zkT2qSUGy9k7uXfL/4AFaTl/IWzYgyxcqz/QwjlNakrTuHRqoJAtdSh/kbEoVZys5vKmd8BpHofwJ1XZ2+JikyEOywQ/Z7hIR/7Qvg00pIsSMVH/6oEVu4jYuYM6Ddk5XJHAVawD1G74vHtI6zOwwpDv/B3OYsM8Se6SfPjCjr5t2mE/E7WV4/tV8gm/KwtDrF6HHndRaBQ9P8TN0KMvg6K60emOLSh6NeEchjU7PBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkyqXMXeRZTC/CUqrVHZw1dPYLfWVEv48aAxLfVwCCI=;
 b=etN2G5GQrb/xDSaOB3LY5hoqLicxDE+rZCVdim5b4Sm3sothlFGwtVgAwAk9mxOw0KKQh9+M80u5de7n7CApIYRSngNRNYoivnnbazXzTy+wFrdWzxcRf2gTP732rvBzGSq1W3wOv/BlKVYzP0NPQO8sSuj8pryq8fqvbadmC2g=
Received: from BN9PR03CA0051.namprd03.prod.outlook.com (2603:10b6:408:fb::26)
 by LV2PR12MB999095.namprd12.prod.outlook.com (2603:10b6:408:353::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 08:27:55 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:408:fb:cafe::8b) by BN9PR03CA0051.outlook.office365.com
 (2603:10b6:408:fb::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Thu,
 15 Jan 2026 08:27:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Thu, 15 Jan 2026 08:27:55 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 15 Jan
 2026 02:27:52 -0600
From: Honglei Huang <honghuan@amd.com>
To: <alex.bennee@linaro.org>, <dmitry.osipenko@collabora.com>,
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, <Ray.Huang@amd.com>
CC: <mst@redhat.com>, <cohuck@redhat.com>, <pbonzini@redhat.com>,
 <qemu-devel@nongnu.org>, <honghuan@amd.com>
Subject: [PATCH v5 0/4] virtio-gpu: Add userptr support and ROCm capability
 enhancements
Date: Thu, 15 Jan 2026 16:27:35 +0800
Message-ID: <20260115082739.174224-1-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|LV2PR12MB999095:EE_
X-MS-Office365-Filtering-Correlation-Id: a35ef947-048b-4bdd-8304-08de540ffb88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jmLgliw/jGjJh9gCmFwEmbNHDY80rbJ2+h0B5MoHF/SXpqF21OqC4MY9w7uT?=
 =?us-ascii?Q?c3efwEo0ZsSgMgjxmlp+i5fXsHK0ddTOoeeaER8gz6/+iN4mgXW9S57VhUwF?=
 =?us-ascii?Q?Y3yYv6pr/8me6weUEch3TYEPCOguSfshIzEJSnX5TcKAIfpobUrTlgXh5v+N?=
 =?us-ascii?Q?Eeh4yVts3JiwSYCSgr7wZ5Vl1Iwvfrb3Z0DN7+8fg0cbdkULirEjitSoWXzj?=
 =?us-ascii?Q?zJMqRX198mPsLlcfUsnE1xMkUFIPbK43ZkJZjTridlGed+MFEON74jemLLIC?=
 =?us-ascii?Q?qmsNB2bg4kl/QmSoJpa85d8NPwMIdAdUksJ8owm9Jw6IChFckiY+mcYZlTsB?=
 =?us-ascii?Q?cCPyRFay6EB7gCZ4ENHsmwKZxvTItnO/teQ3J2RAZTHuhPZ1bk0rwsErel0H?=
 =?us-ascii?Q?uqzg68BTsduFCDYkIC29kGv+VeY8zCt+IZKIvq1h2Fv7+Pdl2cpFe9m5lnON?=
 =?us-ascii?Q?iD9Xw6zEPmkC7DoJN5oHyQGrbFNNALiYAIIxvILUkN+uGdSo2O7Y/jqT4je4?=
 =?us-ascii?Q?yLwf+3+7DQEWdQX6Os7C96gLRNQh2SthnMcc7ET0UhLiukS/3GXr/w8GzR4m?=
 =?us-ascii?Q?2ysaSoUB7M+FOcYXF821HSiHfpzt2Q2e0WpFdwcl2TGKaccLSWLRw03CpzuX?=
 =?us-ascii?Q?d3Zk6ccPOK1PFVoHtyLnXkweYn5Mvb+gUb/WwXhucev9UVlVc3yKH60sGeC7?=
 =?us-ascii?Q?j/ykRB8RHiyRjIE5UBDjeFjex5VqdaSUXbPd3fnGfOA404iYyyC39gKXkit0?=
 =?us-ascii?Q?RcDxjkutJ5GRuTYwWZSfLvvzmI22XHB+ziNL2bfuu/LwLhO1quQYOPr5q6he?=
 =?us-ascii?Q?eBzKJL4KobjykNo0JrgEJpLUCfEPcrb2luGKhu3VLdj8cgWs1BMOxZzuqWuh?=
 =?us-ascii?Q?jZvS06QHB24BdgtpF9Nz7mldQbmbI2CqthwpykonUFuIWyZOevh6rMrS0fbu?=
 =?us-ascii?Q?6wgJfI5Fp73g8Eq5zSi0HO5cGznsWXlcipXEpuleJ+EWeof7Wtt+KcT5WBfv?=
 =?us-ascii?Q?F67B1+1RWaCUXwIyIRywgqF87EkcyRHcSf4ZJpMoBIA5UJ/yYLfM3JLMDLzQ?=
 =?us-ascii?Q?VkAaf8B9fDDs4UVFRtO7jNjsxjD5JaMjOI5rJqOKstpF7dx3E6njO+/nbVMs?=
 =?us-ascii?Q?RFAZbNK/rxVk/aF+p/ry1R2Ey4fdhcbbXKt2WloMH0kf31IQPQWnN0T3ijLN?=
 =?us-ascii?Q?YjUL4stEb2CSb1lqQmZpGYXalehu/uOHQNvmitcuumoz8WaRwsaB3L500axC?=
 =?us-ascii?Q?AE8sAzFn4Jts0f56eX+jWwNrQjYlnh5Z/l3bJx7SB+o3ai8NdIIX0Vm431uM?=
 =?us-ascii?Q?xhbPQWs/QAqyOz6xONkNGeY9c76z+fM2ibxcneTcYtM9LSHgNGRCWKQPlcSV?=
 =?us-ascii?Q?z40ilbo7hv3eOJRw4Plsql28alMRPO6c7iOgkYoVAZFjDOc5H0IJY04fRI2G?=
 =?us-ascii?Q?rGy/3pnzUcwWRmyXmDxijB7fOcCkZBLTbYC5x9wVOUrGH8tfWkGkI33TDKHb?=
 =?us-ascii?Q?D9MK8wI5cLe+uRlWNj0CGmoS8cxkXit8my3KHD5KvkXbXcj9SJ6/o5D3twLr?=
 =?us-ascii?Q?tWgKx2qVhlt/MGjlehitK5ITFGQbylSylJUfXgm3PXjWPW/v819+4XmK47Oe?=
 =?us-ascii?Q?VCec9RI3Lg8sGpsyx7hHh6Q=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 08:27:55.4013 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a35ef947-048b-4bdd-8304-08de540ffb88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999095
Received-SPF: permerror client-ip=52.101.61.32;
 envelope-from=Honglei1.Huang@amd.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This patch series introduces enhancements to virtio-gpu to improve
memory management and GPU virtualization capabilities for ROCm (Radeon Open Compute) 
workloads.

Usage example:
  -device virtio-gpu-gl,rocm=on

The series includes:

1. Linux header updates for userptr support: Synchronizes virtio-gpu headers
   with upstream kernel changes, adding VIRTIO_GPU_F_RESOURCE_USERPTR feature
   flag and VIRTIO_GPU_BLOB_FLAG_USE_USERPTR blob flag support. This enables
   user pointer mapping for blob resources, allowing guest applications to use
   user-allocated memory for GPU resources more efficiently.

2. Removal of nr_entries limit: Removes the artificial 16384 entry limit in
   virtio_gpu_create_mapping_iov() to align with kernel driver behavior and
   support legitimate large scatter-gather operations.

3. Linux header updates for ROCm capability: Synchronizes headers to add
   VIRTIO_GPU_CAPSET_ROCM capability set definition.

4. ROCm capability support: Adds native support for AMD's ROCm (Radeon Open
   Compute) platform through a new "rocm=on" device property and capability.
   This enables GPU compute workloads using the ROCm stack through virtio-gpu.

Changes in v5:
- Split userptr header updates into dedicated patch (patch 1/4)
- Extracted nr_entries limit removal into standalone commit (patch 2/4)
- Split ROCm header updates into dedicated patch (patch 3/4)
- Removed VIRTIO_GPU_F_RESOURCE_USERPTR feature decectiontion
- Keep ROCm capability support with "rocm=on" device property (patch 4/4)
- Change corresponding commit messages, change corresponding cover letter content
- Remove RFC label

Changes in v4:
- Change this series to RFC
- Renamed HSAKMT-related functionality to ROCm for better clarity and
  alignment with the ROCm ecosystem terminology
- Changed device property from "hsakmt=on" to "rocm=on"
- Changed flag from VIRTIO_GPU_FLAG_HSAKMT_ENABLED to
  VIRTIO_GPU_FLAG_ROCM_ENABLED
- Changed renderer flag from VIRGL_RENDER_USE_HSAKMT to
  VIRGL_RENDERER_USE_ROCM
- Updated capset handling to use VIRTIO_GPU_CAPSET_ROCM (8) instead of
  VIRTIO_GPU_CAPSET_HSAKMT (8)
- Removed the error handling fix from patch 1 (virtio-gpu-virgl.c) into
  another thread

Changes in v3:
- Renamed HSAKMT-related functionality to ROCm for better clarity and
  alignment with the ROCm ecosystem terminology
- Changed device property from "hsakmt=on" to "rocm=on"
- Changed flag from VIRTIO_GPU_FLAG_HSAKMT_ENABLED to
  VIRTIO_GPU_FLAG_ROCM_ENABLED
- Changed renderer flag from VIRGL_RENDER_USE_HSAKMT to
  VIRGL_RENDERER_USE_ROCM
- Updated capset handling to use VIRTIO_GPU_CAPSET_ROCM (8) instead of
  VIRTIO_GPU_CAPSET_HSAKMT (8)
- Removed the error handling fix from patch 1 (virtio-gpu-virgl.c) into
  another thread

Changes in v2:
- Fixed error handling bug in virtio-gpu-virgl.c where the return
  value check was inverted (changed from "if (!ret)" to "if (ret != 0)")
- Added VIRGL_RENDER_USE_HSAKMT flag initialization in virtio_gpu_virgl_init()
  when HSAKMT support is enabled
- Simplified blob resource creation logic by removing complex conditional
  branching for userptr vs regular blob handling
- Updated commit messages to reflect bug fixes and improvements
- Added references to related patches in Linux kernel, virglrenderer, and
  ROCm Runtime components for complete feature implementation tracking

Related patches in other components:
- Linux kernel virtio-gpu support:
  https://lore.kernel.org/lkml/20251112072910.3716944-1-honglei1.huang@amd.com/
- Virglrenderer support:
  https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1568
- ROCm Runtime support (merged):
  https://github.com/ROCm/ROCR-Runtime/commit/48d3719dba6ca91f597a8179d8b341387ce155e8

Honglei Huang (4):
  virtio-gpu: Update Linux headers to add virtio-gpu userptr support
  virtio-gpu: Remove nr_entries limit check in create_mapping_iov
  virtio-gpu: Update Linux headers to add ROCM capability set
  virtio-gpu: Add ROCm capability support

 hw/display/virtio-gpu-gl.c                  |  2 ++
 hw/display/virtio-gpu-virgl.c               | 12 ++++++++++++
 hw/display/virtio-gpu.c                     |  7 -------
 include/hw/virtio/virtio-gpu.h              |  3 +++
 include/standard-headers/linux/virtio_gpu.h |  6 ++++++
 5 files changed, 23 insertions(+), 7 deletions(-)

-- 
2.34.1


