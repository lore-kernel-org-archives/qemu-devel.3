Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8443B606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 08:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KKGOP8a4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPFNV-00038M-6Y; Fri, 06 Nov 2026 03:32:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1xPFNJ-00037U-0j
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 03:32:42 -0500
Received: from mail-westusazon11012071.outbound.protection.outlook.com
 ([52.101.43.71] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1xPFNG-0008Rx-L9
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 03:32:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GMXgOobI96TCkTGSzXFAOi9J+YTmCTI/ZJPUdW0Zrt+w0YPFZYEd+JuX1LPE5VVow4A0NqvPJt3w3gnCC+Dbc8dAbM1bHwNlk+XmWBRessZJ086u/h+VdwoKR+QqbWMGVA0xIUQ8JEsXWCEUt+wP3JD+/OYtSad3D9+ZbFNLhLu6ugTFWLicyBGYitukKyu4dHWCRQkvtJORdLaByAmg+DwHqheWnFLECwkc2R9RC1L6tv6jfwvIvN+J1KYjEwi3dHAUsBkaGfXXtAGO4eTKjLnqxRC7CI+xmT7y5+OX1m3yEHZxBH1vFEKDFxKLLFxXaAskjHU8/1TT/OjMebcnjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKFVHn4PQOhXKjxP4cl0lt8tN8PnCOmvoOI5xf5BONk=;
 b=IpdGPsH9XVc6QzN+SygATdH5cJSysa5YNGFUtb+8ftupto/N9zBORc91vTOzUWJbMFXHmvMSS9i53aNTRH+m6Np3eKNoGCckWk0ol8lXLQNuFSs4Etco96dhR+Hl2bjhFSWXnk4m9fNSPwZGOT4Qi8b/iMQuPl9fxo9I3l5KzM38dhPJHoXwOSoCYtq/Fm1/+yBkTb4/0mwS1GPWe3EANMYytfQ26Tj4pKJSh79HGfnTaqwrsKYdDlDNJ1moe9zosAscO7XNcHg+1kioKEyJxXVrO4Qd0lXGUtTgaCxWgllJx/6S7ZgAmK9DQEIGBngb9JAE/f6+AllO3JxZJt8HVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKFVHn4PQOhXKjxP4cl0lt8tN8PnCOmvoOI5xf5BONk=;
 b=KKGOP8a4jp/uNXmO5tS54nUHCSPPl+BL90MOTE2BVYPu44VaMCvKDYpTdQblq3LtgfNgrNOni+Sd8N6ahJuIKbGi9Ny2oFeEoBIdeFlHCfJCJkKZxMp1HkvoVXsY7OQJ7G2PwjxFHH4G+V1pc0kBrgWrPCJ4Soxqr7uG6eyJ2q4=
Received: from SJ2P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5da::13)
 by CY5PR12MB6081.namprd12.prod.outlook.com (2603:10b6:930:2b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Fri, 6 Nov
 2026 08:27:29 +0000
Received: from SJ1PEPF000037A5.namprd04.prod.outlook.com
 (2603:10b6:a03:5da:cafe::59) by SJ2P220CA0007.outlook.office365.com
 (2603:10b6:a03:5da::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 08:27:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037A5.mail.protection.outlook.com (10.167.244.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 08:27:28 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 6 Nov
 2026 02:27:26 -0600
From: Honglei Huang <honghuan@amd.com>
To: <alex.bennee@linaro.org>, <dmitry.osipenko@collabora.com>,
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, <Ray.Huang@amd.com>
CC: <mst@redhat.com>, <cohuck@redhat.com>, <pbonzini@redhat.com>,
 <qemu-devel@nongnu.org>, <honghuan@amd.com>
Subject: [RFC PATCH v7 0/5] virtio-gpu: Add userptr support and ROCm capability
Date: Fri, 6 Nov 2026 16:27:06 +0800
Message-ID: <20261106082711.813336-1-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A5:EE_|CY5PR12MB6081:EE_
X-MS-Office365-Filtering-Correlation-Id: b5f6c875-dcaf-4fbd-c3be-08df3bdfcbaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|6133799003|10067099003|18002099003|13003099007|56012099006|261009223027099003|261022075727099003|261021123027099003|261102123227099003|261021121427099003|261026121527099003|261022113327099003|261022105027099003|11063799006|261026140227099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: wf7ZZL4sM32t/JkRlZfplOqpJ1uuEIU3CDO7l3+tNsxoV3ogp0fn2Hxjh5JToqP2EKIYtPLxd/f4yw86c/bJLPJqneGDGnCEaMbkii3afrCA90nUBlzQIVy2qiAL+xjjJEvJYDwjmeWKqmsST4x3ffFOftIQV9L58WlY71EA1eNBMHe92EJPTbDnLM+oOKIyDooCuyfL+YpQ91hH4tcXMN0Jry1I981l+RW7kXAZvHUmRXGhYw9x13Y+fqX2O9/TJjQmzPuYtAhIKF4yS/ubwg44xrTo3nwj1xmWsqWNTuVfPU2pj+2A8DuwLRzfx9bXMLIvymGBjnRLlDZO1bk+K3R45wSKZE57oajtodh+jUKwcNbU0C1NXRx9cCmwQ57aFeUn0kwcOxXZUA9QwPOimv3lG2uQSioV7Y/WxGslpGJV2K/7d5XgSMarMdZoVaqhWdV/5I389He+Sb2ENFVspW7Sg8tl+p2rEJTHQUeVisPGuie6ZPKKMHlV7MorBG3GtwI7lynE8cvtKI6+mOxZz1B+Br0VTovwwfxnuXfyVrlTGsy7fm3coFYsKL1Ta5cQOkO+4GYCLyAVB06a58Zm1YblXINtSPPEgUv/qTu2nEFTeACYFOgn/KbBohr2/fbvsWKPgcZCpRevJzgP6Rx6pg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(6133799003)(10067099003)(18002099003)(13003099007)(56012099006)(261009223027099003)(261022075727099003)(261021123027099003)(261102123227099003)(261021121427099003)(261026121527099003)(261022113327099003)(261022105027099003)(11063799006)(261026140227099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CtSOUmUeDMN7MHce1x6QfSe6E8Rr4UF9qzCpqB8EkdMVVWPiHMwwUhX3KTPXTtIeo+uxbUOkHv6SVtufiZwXIY0Fx5FORxnLYf+FJVNBQrH4KurBJ9hHOpI5ORBeVelMafPr7gcpHtQs5u06M7LlyDAaKYldn11JQl3vMx2sE+yYfPdowDDfolf9Pxjvx/IQTnAQYIAtztT7HK/1rmXDD6X5kebV7WVMmiYPDaPZijUGmAvdAaREA5J+x65S7cNqudkLmEGCFrltfQ+BI9MebWh8UFjDz3GDxkFc6p+nmbv4qLqJ+lbx5OU7NkcKhUZRcMcqjKgWVNWMqlBlWzqutO7OG4n6Mh2/LysGUAoe7aD/MOtPtsYcx0k8FxTcvWOVRRqVZ1ZNB8KOSYZPaLiIzpUF+/21Oc6Rr6XxCqXAp/bXTs2qsAqlwfmWo84nrogb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 08:27:28.9323 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5f6c875-dcaf-4fbd-c3be-08df3bdfcbaa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037A5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6081
Received-SPF: permerror client-ip=52.101.43.71;
 envelope-from=Honglei1.Huang@amd.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This patch series introduces enhancements to virtio-gpu to improve
memory management and GPU virtualization capabilities for ROCm (Radeon Open Compute) 
workloads.

Usage example:
  -device virtio-gpu-gl,rocm=on

The series includes:

1. Add ROCm capset ID 10 to the imported Linux headers.

2. Enable ROCm native contexts through the "rocm=on" device property.

3. Remove the only qemu side 16384 entry limit for blob backing entries.

4. Add VIRTIO_GPU_F_BLOB_READONLY and VIRTIO_GPU_BLOB_FLAG_USE_READONLY
  to the imported Linux headers.

5. Advertise readonly blob support for ROCm devices with blobs enabled.

See overall detail in virglrenderer pr [1].

Changes in v7:
- Replace the obsolete USE_USERPTR=0x8 / USERPTR_RDONLY=0x10 header
  definitions with negotiated BLOB_READONLY feature bit 6 and
  USE_READONLY=0x8.
- Use ROCm capset ID 10 rather than 8.
- Add readonly advertisement for the paired ROCm blob backend.

Changes in v6:
- Changed to RFC status
- Removed VIRTIO_GPU_F_RESOURCE_USERPTR feature flag from patch 1
- Added VIRTIO_GPU_BLOB_FLAG_USERPTR_RDONLY flag to patch 1

Changes in v5:
- Split userptr header updates into dedicated patch (patch 1/4)
- Extracted nr_entries limit removal into standalone commit (patch 2/4)
- Split ROCm header updates into dedicated patch (patch 3/4)
- Removed VIRTIO_GPU_F_RESOURCE_USERPTR feature detection
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

[1]: https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1708

Honglei Huang (5):
  virtio-gpu: Update Linux headers to add ROCm capability set
  virtio-gpu: Add ROCm capability support
  virtio-gpu: remove the artificial IOV mapping limit
  virtio-gpu: add readonly blob definitions to Linux headers
  virtio-gpu: advertise readonly blobs for ROCm

 hw/display/virtio-gpu-base.c                |  4 ++++
 hw/display/virtio-gpu-gl.c                  |  2 ++
 hw/display/virtio-gpu-virgl.c               | 20 ++++++++++++++++++++
 hw/display/virtio-gpu.c                     |  7 -------
 include/hw/virtio/virtio-gpu.h              |  6 ++++++
 include/standard-headers/linux/virtio_gpu.h |  3 +++
 6 files changed, 35 insertions(+), 7 deletions(-)


base-commit: 73294d096cc591e122fde9e63db4739de6d84f2b
-- 
2.34.1


