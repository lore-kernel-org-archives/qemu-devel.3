Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 266B2C982C9
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 18:47:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6uey-0001aV-Gp; Wed, 16 Sep 2026 14:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhonap@nvidia.com>)
 id 1x6ueA-0000jp-Nu; Wed, 16 Sep 2026 14:46:31 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhonap@nvidia.com>)
 id 1x6ue6-00044S-LH; Wed, 16 Sep 2026 14:46:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UOfhKu9nvB0McAYHqhmDEhf5bsYEAyNjXYP53JNNQiFnqC4h5YIxOD31fKEq2xhUTBlfF06kfk0v3c49EwnMnf03e7b5ja+ZX7xNyxPgYfUP+RajK51vptRD1JM2jGKpT18rz8rFP3y3XHzOaOqHGnmTALBDFUJnW2v4O2nQszpDzHDpFZj01tvxtIePWH+RramCDmdDkUyn104u2s3BG1RDFlah2bvlTON6Irfovb5Aro0Fe8WSh+7MCOtfSC3oI+nE3Y6litCU1IuQnjk/Cmdm2GpZ7f4OqDQXnXv12SSJ4EmkBj6A5YXZWL/dDH2dChJWTHUs2IlFVruIUFLJAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kI6ImuoqGgl0eyt/uE4OvZjxqGI4nPXFEtMYTaz3LRE=;
 b=wvZLPSJMBdrj/ZUxMrtnJYa7gG8ioNg16Y+sEmliHr7NHuumazAKsbQHciw4SN8YvnBMusO/hHQrsVx5HLl9ILL7CI+zFupy0MUA5O/dzj6kOoC7DJVT6Y7KNF3Y0Yuty+duC1fF8+AdmDVFl8Mi9jCGCkf2DKIeTL3rmHDU5opmNO/ESLZ0ISvcmRSutbuw368gk7yAg/nywYcJBCmpyJ0ptkAM/ylM3JnFz6Jmp8H2ZvgdI4AqYbAtW6dJAmQw09ZX25RRK2vg0jZHSmZK2P7rE5hc8zhsJTX0OtHmZEtHxikEdYfPWY19hBa6Jhd2nc3KkYlUb65hhsLZp2sJYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kI6ImuoqGgl0eyt/uE4OvZjxqGI4nPXFEtMYTaz3LRE=;
 b=PsBfSy3vhrJzBNl+6cg6nH+loqJ4xZvP9gi9ucBmh1cF43LKo884fYpso62p9z9o23I/o1SgXVvm0t+wl8QxsaAb+H7s6tEf3V0+9JVqwGtgsn0ZO7hO/h4wGGHpCtQ0P5uP6qsrzlqF6IpB/t05V+JmB1zOS16ajUqw7BzXa9Z0HBnfosoMrYVKA88szsDP/aSQuCfsYdCPKEoqNfdoIOgPA7X3F06xmf6BrEjaxQ6xUGfk9KmZvq6JEawrugtdQ1uhmutizFyDllPH6FhFKTf3BmNA6bi2jVZhIlpyMnXb4A/Nofm9rZXAhOIzCmsdrtSBffXAl0Bgq3xXTrepuw==
Received: from SJ0PR05CA0003.namprd05.prod.outlook.com (2603:10b6:a03:33b::8)
 by IA1PR12MB6233.namprd12.prod.outlook.com (2603:10b6:208:3e7::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Wed, 16 Sep
 2026 18:45:58 +0000
Received: from SJ1PEPF00002311.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::90) by SJ0PR05CA0003.outlook.office365.com
 (2603:10b6:a03:33b::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.8 via Frontend Transport; Wed, 16
 Sep 2026 18:45:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002311.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 18:45:58 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 11:45:29 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.231.37) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 11:45:22 -0700
From: <mhonap@nvidia.com>
To: <alex@shazbot.org>, <ankita@nvidia.com>, <jic23@kernel.org>,
 <dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
 <smadhavan@nvidia.com>, <pierrick.bouvier@oss.qualcomm.com>,
 <mst@redhat.com>, <imammedo@redhat.com>, <anisinha@redhat.com>,
 <pbonzini@redhat.com>, <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <richard.henderson@linaro.org>, <clg@redhat.com>, <cohuck@redhat.com>
CC: <kjaju@nvidia.com>, <vsethi@nvidia.com>, <zhiw@nvidia.com>,
 <mhonap@nvidia.com>, <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>,
 <linux-cxl@vger.kernel.org>
Subject: [PATCH v2 08/10] docs/cxl: Document CXL Type-2 device passthrough
Date: Thu, 17 Sep 2026 00:14:10 +0530
Message-ID: <20260916184412.3825713-9-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260916184412.3825713-1-mhonap@nvidia.com>
References: <20260916184412.3825713-1-mhonap@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail202.nvidia.com (10.129.68.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002311:EE_|IA1PR12MB6233:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bb67a06-35ae-4693-9d17-08df1422bf5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|82310400026|36860700016|1800799024|23010399003|11063799006|56012099006|3023799007|6133799003|921020|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: yj+BqduYrfadSOKr8+SdOGHJyYFFU0neVYnaI28L+Ye8Oyt9mV1NKbh+7wvwgOSjXDOBieuajbQY6tuL5XzOWhZwCGWBXj400Ab6PGc4qwV9fBGQo2bPNAfdoDckPxg12vZ0GIIpTdSOTlGiZWjz6nVWkUTgVb09Afm0MFi6kyL25tDzPjA7fu+BZ91kuNq9rOM+PQCwyxbQjr/RikRazQqdnY893MBh3aOIsXxrTmPC47DzXm68Tk7LVQnDv45MmUvvMOLjxuL8TK7+Go7jL0Ut4nsDif3/Dq55d7nzU1CmGIsnUJdL/xREA80kPJQ6Mr11qfe6E0jguPCOhyfMaQBO1aN9h/um3hmYNMdzHPsxBPQ1BRFu8VE40do1oU/5wM9b4orwVYcJTjS4Q2rXeOoq/2w6FB8qrZSiyl+5rjwkE6U+bygvwGrFZCX1RPltZar/6uinWVHGExU7/yUXHyFTlCtm4Tta/nWCgJhkG6eK7H1nnbVudH+RGAWJ+PvtT0tc6l/2VZMXnfx14Ye7Nu3VJFgJkpB6P7xR5slHdYwCXxETFiluXoZqw2OZ4a22aL2aOnBVe4ZuHXWt+s2ytcgZR3LvSbRzuDCQ4Q4jVZdAWIdGQjOwcpr+wEiidEb2lf4vZCXoxvEXXw15RHVF6EDG6j8AiVAh9HNjW7dhDyf8OioUe+q0RQl8229N4wIA1XmueHxF6r5fg5GSeLL4n8GlykxBLxqCuR2W9GooMIEWt8fbd+3oRSvfrfrYWRxO
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(11063799006)(56012099006)(3023799007)(6133799003)(921020)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: p/wzTbsmDy2LrTBU51J3zWd4ZpcYYKrrk4wrp9V+rB8oXVNuAKC0fvR45V9jF9CDJL290Ppt1pKGBUm1/7xRKsXjQ87oJN/Y84k4dHdVtUcdxMMCwNTHY+8Qog9S95EDwHPto206zWcViw9g54FoFhrE/VD7hs4Fp3fjta3DsxbLacL5P1LfLAkLjk5Gd0jO2QEdf06vNPVkYsuRDEwywcVBpqapVWHxLGQFPyD+iWy01ryIO0O4Nok6usIVDJEYCQlw6DOtsZfIpCN+EwH/U/h0NO6f2a+R+qo9jaenxK0BhWhUz6Z97J29EwRgwSXZH4F/MYw63wiEHMzXYSHw0PeG1bZBteoxiOM5KiS3mP+A83dRpP8SJkik0d4qjQ2f9IWfrWXYuh8S4KY6KxLrP4pNHHpDvZHmjhwfxGoO3e1jofLyzMo5C22rw6vwxwyX
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 18:45:58.0557 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bb67a06-35ae-4693-9d17-08df1422bf5d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002311.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6233
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=mhonap@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
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

From: Manish Honap <mhonap@nvidia.com>

Describe the supported single-endpoint passthrough topology, the command
line, and the kernel dependency, and note that a guest CXL reset is
handled by the host kernel rather than QEMU.

AI-used-for: docs
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 docs/system/devices/cxl.rst | 45 +++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
index 6bee339cea..3cdd320457 100644
--- a/docs/system/devices/cxl.rst
+++ b/docs/system/devices/cxl.rst
@@ -423,6 +423,51 @@ Volatile Memory device::
   -device cxl-type3,bus=root_port13,volatile-memdev=vmem0,id=cxl-vmem0 \
   -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G
 
+Type 2 device passthrough
+-------------------------
+
+A CXL Type 2 device (an accelerator with host-managed device memory) can be
+assigned to a guest with vfio-pci, so the guest reaches the device memory
+through its own CXL stack. This pairs with the kernel vfio-cxl series: the
+host kernel fixes the device memory at a host physical range before the guest
+sees the device, and QEMU maps that range at the guest physical address the
+guest programs into its endpoint HDM decoder.
+
+The device memory reaches the guest as a CXL fixed memory window (``cxl-fmw``),
+advertised through CEDT, exactly like a Type 3 window; there is no separate
+device memory-map slot. Only the endpoint decoder is programmed, by the guest,
+so the host bridge must stay in HDM passthrough mode: a single ``cxl-rp`` under
+the ``pxb-cxl`` and no ``hdm_for_passthrough``. Switch-attached and interleaved
+topologies are rejected.
+
+Example command line::
+
+  -machine q35,cxl=on
+  -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1
+  -device cxl-rp,port=0,bus=cxl.1,id=rp0,chassis=0,slot=2
+  -device vfio-pci,host=<BDF>,bus=rp0,id=cxl-ep0
+  -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=<device-mem-size>
+
+The window must be a single-target ``cxl-fmw`` that targets the device's
+``pxb-cxl`` and is at least the size of the device memory. The guest triggers a
+CXL reset by writing the CXL Device DVSEC; the host kernel runs that sequence,
+so QEMU has no reset handling of its own.
+
+On arm64, pass ``accel=on`` to the ``arm-smmuv3`` when passing a Type 2 device
+through. The accelerated SMMUv3 describes the device MSI doorbell to the guest
+through an IORT Reserved Memory Range (RMR) node, which reserves a fixed guest
+IOVA, so OSPM must preserve the firmware PCI resource assignments rather than
+re-enumerate them. QEMU requests that through PCI Firmware ``_DSM`` function 5
+(preserve firmware PCI configuration), which on arm64 is emitted for the CXL
+host bridge only when the machine requests preserved configuration, that is,
+the accelerated SMMUv3 path. This ``_DSM`` is not about the CXL decoder:
+vfio-pci keeps the host BAR fixed, and QEMU's trapped component-register block
+is a subregion of the guest BAR MemoryRegion, so it follows any guest-visible
+BAR relocation on its own. x86 does not use the accelerated SMMU, so it does
+not advertise or implement preserve-configuration function 5; the CXL host
+bridge still emits the ``_DSM`` method, but its function 0 returns an empty
+support mask.
+
 Deprecations
 ------------
 
-- 
2.25.1


