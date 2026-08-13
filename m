Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C32C5CFEB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 13:08:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuVAU-0006Rq-Hw; Thu, 13 Aug 2026 09:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhonap@nvidia.com>)
 id 1wuVAO-0006QW-5S; Thu, 13 Aug 2026 09:08:17 -0400
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhonap@nvidia.com>)
 id 1wuVAK-0005QS-Tg; Thu, 13 Aug 2026 09:08:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bQ49K/pwSjLXXKrrhrAhl0Z8JpI14qqPNQbftGfsSErsM1y5EuwYQFyYpGDhKa68DGYElxPLD5oQ/1gAXDPzqV44Cg/r2XSzuY8EZ0WDla155C5FGkP05Quu5fTvoV8I5Z3PrnQ0cJFTqBN9CShMm1JTS2S/k0eiuqvX4Ck0BqqngHTsEyhoRt77PqQVMZ7LdWFxJQ6ma6K2YleXgTmNbDn23KXZVP9C8Cn1w30nKgNb4wYdtfg3knPbjeEf4U8E9vduN2FDY8MS/0+VXAi94uHeF4C+B6zE467sPCDjZdaXX+8a+qxmcl0JfD2ui3hkWwmGJG9oY5Rt9VZFszF6KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2J2YZMAYXfJ/rDsdKVkHuV+TkuLcuxaUM7xiofvGgf8=;
 b=c8LaHL61EijcVp6ZDqMylG/goTGc/bD1tbEwMdNjEcP5BLRoIDPcM4W2f4x3UuEYvU+n2C5kU1gVfGJoBgCbiKa0EgVy++2aJ6iDFwb3UHy6TYq0f6y3ZkHgcXEBcGp8ogmolMT46siplpkj6+gipSzi8m/XGPceirt/aPUWS3c+iajXPvlzINeuQ4DDsRivwAYXx3HBLitDVzRX47jVzZ5WNkpF8DYfK5gj1Omye8+yN3gWAkzYutnXgM95D4KoBz9b7doLOKb71t2iD60a35+Wa/OWJoYTd+RlB8e33HJxHFqnBGBDpuMTeJ5tlLgW/UwPODqH+yuJ+uwG7gYHYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2J2YZMAYXfJ/rDsdKVkHuV+TkuLcuxaUM7xiofvGgf8=;
 b=pj8U5xHj16fjdaNIR653hFgDaB9NJJKEQCOsnzLFtk5GPV6RHKDLAExr7sfzYJ29XSsvX/R4ikISCjMukeC+Oxai+uxu7r1YMQD6xYoUqc4uJQ+xvigk56eMrbXrHV3CzF35rOhnJup9G61O07Da0xecCv/0HavilxkVaMs/JbpgWbG0Wu/09xO4HP9SufkTkbqJjB1Y1TH1MA6jqp9jOreNvFBbnr+R3DqVAaE9jpu0/xNDkozbWdWDsus1tmV/zqPuI5s2Z4mIhuWpdDceJXsOV/PsWfc3lv14vPy/n2E3ra0rEU5JwQaeGK74p/GRstUUMda9olV8bdpKwMUA5g==
Received: from SJ0PR12MB6784.namprd12.prod.outlook.com (2603:10b6:a03:44f::20)
 by SJ2PR12MB8689.namprd12.prod.outlook.com (2603:10b6:a03:53d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 13:08:03 +0000
Received: from SJ0PR03CA0077.namprd03.prod.outlook.com (2603:10b6:a03:331::22)
 by SJ0PR12MB6784.namprd12.prod.outlook.com (2603:10b6:a03:44f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Thu, 13 Aug
 2026 13:08:01 +0000
Received: from CO1PEPF00012E7D.namprd03.prod.outlook.com
 (2603:10b6:a03:331:cafe::a2) by SJ0PR03CA0077.outlook.office365.com
 (2603:10b6:a03:331::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.12 via Frontend Transport; Thu,
 13 Aug 2026 13:07:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF00012E7D.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 13:07:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 13 Aug
 2026 06:07:33 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 13 Aug 2026 06:07:27 -0700
From: <mhonap@nvidia.com>
To: <alex@shazbot.org>, <ankita@nvidia.com>, <jic23@kernel.org>,
 <dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
 <smadhavan@nvidia.com>, <pierrick.bouvier@oss.qualcomm.com>,
 <mst@redhat.com>, <imammedo@redhat.com>, <anisinha@redhat.com>,
 <pbonzini@redhat.com>, <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <richard.henderson@linaro.org>, <clg@redhat.com>, <cohuck@redhat.com>
CC: <kjaju@nvidia.com>, <vsethi@nvidia.com>, <zhiw@nvidia.com>,
 <mhonap@nvidia.com>, <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
Subject: [PATCH 08/10] docs/cxl: Document CXL Type-2 device passthrough
Date: Thu, 13 Aug 2026 18:36:21 +0530
Message-ID: <20260813130623.2499506-9-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260813130623.2499506-1-mhonap@nvidia.com>
References: <20260813130623.2499506-1-mhonap@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E7D:EE_|SJ0PR12MB6784:EE_|SJ2PR12MB8689:EE_
X-MS-Office365-Filtering-Correlation-Id: d689f1b9-ca49-41a9-0e30-08def93be5cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|82310400026|23010399003|1800799024|36860700016|921020|6133799003|22082099003|18002099003|56012099006|3023799007|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: CBJ2DZbWoOn5v75hb0vc1zjfX1oBfj78rU32FSJArWRX9tx6NVKH9ODys0CUKXkDIbHemFkCxOyl3N44zXeMoPHZr5x6JhOc9gRP0bdyjo5JqyhqLvthoQOu/UD5SN9pAEvpf5GGXb1mY2NEQdpg3kt1BCyRxMjSiaRhMrndMOZW7okwC7DIjcZYfYtk9fY17AK39JknopZTsdsKGSSaqPABcCG/ajRPjFp0YswhfRB+Ab8gHQzH71yJ8hYMyeZKEUoScgETF10142w6srZibrZ5KQL7bT0+KNhiVLavIVp6G3TOQUtfLXQFC2U8WmnAK/2MmMZFoc+3U90gp4mQPp/VJLrXvIQBo2LsCYsfjeJ1FboQnQvv5kENDW3jgXTILQEG8HotWCMrZlo3vt7Mm1kbMGtn7LNdtgFXqsJFbUODlsx8oyOSI4o1FvRQS4l2bRwzOYQmJyNfLegnQXowfi1lmQGZY3NyEZcynwpYLbS5Zo8/oqrGTB3YS8gH0XCHIUQueMKWKJ02xfI/OsSGhCDb0PK8dof20iWqXxSVp4YCO9/TpUpk/n8bIhTHzv2Xhmzbzca7BPOkjQ2hwK85u2qsBB0kxaO/uxVzOlFciX80725KL7KUMwjep8vtOAAk/J1dObh6w8PkBbVyzftwVNDZ99duiCLLOYk7haLY321hBZMHVZlMa/v7UYGyc8sboZEc/M3Wme+K3H40/sFdtYdN6dFX0EIZjPd/x2ntYlOXfx1HlSC6GCiP62ZxMQIR
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(82310400026)(23010399003)(1800799024)(36860700016)(921020)(6133799003)(22082099003)(18002099003)(56012099006)(3023799007)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Cbtdta/uqyp/WwgqA5RrguDAqIjQgmouT0N64IQImVjoJGLOppJF73Ud+BciIQQTuMR1y5MxztlVDl9w+NT++BY44y6wx9eJDw3FCwarUkAKuh6eB4l86YAJFkQugOrXyu4Y5GP2L4euDxKgbe6gBda++oNUQNBOrjMGCmzlrASAnqIhKp1H9zdEr8vkzjGdFuWJYeEO5pTTHF8XRVc7p81MRWqU9FkxES4GSOJsSCHMURddmU3pqmy3eOtFKyxQuKJubxLvaX2KHEceCZ6CBHajyxfUgKipoC13aGHMlLsPZXPhPekU2SUF+cNDdq9LBM1kyqJVKH3Wv64XBS8RmO13x24wIlWTY+dRO4JmF0/8uJYdV7KPqt+YuZxY/h8+iS89whjI9ckOIcPAl7GJP2O5rofO/aITq0/TAk6JnQmYWDPdLauy+eUHq7sL38Oh
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 13:07:58.5849 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d689f1b9-ca49-41a9-0e30-08def93be5cf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E7D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8689
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=mhonap@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.759,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

From: Manish Honap <mhonap@nvidia.com>

Describe the supported single-endpoint passthrough topology, the command
line, and the kernel dependency, and note that a guest CXL reset is
handled by the host kernel rather than QEMU.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 docs/system/devices/cxl.rst | 46 +++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
index 9d0771cdfd..33a9fb169b 100644
--- a/docs/system/devices/cxl.rst
+++ b/docs/system/devices/cxl.rst
@@ -418,6 +418,52 @@ Volatile Memory device::
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
+guest programs into its endpoint HDM decoder. The guest chooses only the GPA;
+the host physical placement is never reprogrammed by the guest.
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


