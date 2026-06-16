Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D5DFCD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 09:14:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZPre-0005DC-IK; Tue, 16 Jun 2026 05:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wZPrc-0005Cn-Mj
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 05:13:45 -0400
Received: from mail-eastusazon11011029.outbound.protection.outlook.com
 ([52.101.52.29] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wZPra-0005c2-LU
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 05:13:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nqizmy9aNinp7o6mopw9AHtWgIBUwgntQLbzxrx4FJ6/imkAN4w3257DhT0zfXofmsBbEXIqA6zWSzLpjypfyIJdGYoocWgpHKOqmkJFnPl/hZvH5B7bzn2rdBzhGeuAxQqeBWSxXmCXzB2oGOhOrFjyYYaWBF1QBRJl27MHYTWHlxEz1q4oqvq41cJeL0gURf23ptq+sTapowyDsEztYEqaN3/zfl/J982EH3v1Vuey3toZc0hYX/9Djhajp/+BV4iSk0n6RCgUeMyOI9AX5R4QV5Q/cFRPXOMXF6YVr6oFZWaUtKhWITgB8c+QtCGmUNMEr2Ozr1jEAmLWs1maUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9p1k70Uoh7ytL4i8GgLWMuIxCHI/3vYD1IcAWdBIOw=;
 b=o+o/VUKapS0dO0N4NpqTSR/FcbAtv/8/Nhyww6bKteCpeogjeGJIRCdstAZnN+Zj+oJ9YBqfT9QMUB4ETgbVeVEka53tjuotbDX0isfTOfs2V4ze/35AbH3RLHSfXmbmysEa906Qc4l5skShGhu2Mp+HTIC0XtTdrgmPxUw7QvWOoLwjTCdpbjaT029+ywIoa9fD3gtisMHUt+Q6EI+NAWxUpcswZnQGt3YaVFGNXbecJcRcLZ1qjNs9Nu7lq2mEGijzGVMbe2d8eNKVBJubydgRFyn2flGfpzXf2p3pmTfst3QhUjgrfFKKdIgnkNmcsCgiqWiMHSCiCpKpaoWRmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9p1k70Uoh7ytL4i8GgLWMuIxCHI/3vYD1IcAWdBIOw=;
 b=iZ7gD4r5kCO0AkWR+/bUZuDblsBKOdfi8XlM9nKSLJ0/EmSi9/DUrw7HjOoz6P4gZaHw5gHQqMkZM0kkcFw+eyzch7Dvo1lbHfsIE8ZCUq09GDOJIwtfLyBRiHaBW3ct1LC04eNC+/9t/05nbJDbdtI5iQRGT19mvtTV/5gpVrY=
Received: from DS7P220CA0050.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:224::20) by
 PH7PR12MB7115.namprd12.prod.outlook.com (2603:10b6:510:1ee::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Tue, 16 Jun
 2026 09:08:32 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:8:224:cafe::3e) by DS7P220CA0050.outlook.office365.com
 (2603:10b6:8:224::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 09:08:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 09:08:32 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 16 Jun
 2026 04:08:32 -0500
Received: from k-Super-Server.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 16 Jun
 2026 02:08:29 -0700
From: fanhuang <FangSheng.Huang@amd.com>
To: <qemu-devel@nongnu.org>, <david@kernel.org>, <imammedo@redhat.com>,
 <gourry@gourry.net>, <philmd@mailo.com>
CC: <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>, fanhuang
 <FangSheng.Huang@amd.com>
Subject: [PATCH v12 0/4] hw/mem: add sp-mem device for Specific Purpose Memory
Date: Tue, 16 Jun 2026 17:08:04 +0800
Message-ID: <20260616090808.3047939-1-FangSheng.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|PH7PR12MB7115:EE_
X-MS-Office365-Filtering-Correlation-Id: e8a26cba-e85e-4628-ad7d-08decb86d6e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|36860700016|376014|11063799006|56012099006|18002099003|13003099007|43062017;
X-Microsoft-Antispam-Message-Info: eRte900CmRj2/U4gRIiro6nOCChco6UOTocuo0Jy1I3iWQjjq1EnpStcnXyfIFaV7exFW70Qb4FjLsIXvc5wpBzYjMXha0Apd/+a1eZnJfN4kL/zMwJLn42SlJ3PSB7YLXFtyLCEMfkYYfB+DcT8VQRj3XiDve7Hg1Nwi3OEtyfNFTP015vbU7Qwyv/fSaloA9SsUpjCBkemP/0tAEkiZAfXGlxak8N3gUMFLq+06Xw9pvKPdbYos9muMKZVy/ZlSt07C9SUX+eIWfBs+xh2cnBgNSdCSdMPk48q3jrqlDqxZ6cRQPIR4BiA8Zs0ybRwl3kzrjZr8x1v7OCVMmAiFxKugazuDezAg2XnN8EOuVLriAbLlviisEC0X9RQCodwtqsMI6eh8Gzlr7tdL4Mzu+F+9d3zuIQlU4luKpe4aZUmmbT367TcbsgkJhLIKjL/SOccAA0qUb3Nim+p6FHfxnHSXstFQK8ZoN9GU/iz3DQQ193DgjXQl2STohUCJyLQZ9cCr6SVejlOhwVbwtcFyrKYPCRjz8nC2IDoa3gQiFv3rn/T6jy1ttkoZVh8GkOjSsKWchBBQGoJ7z8enViStnT+LBVhIa8xahwlkk/WRMo8RSw60S/bT4xCgj1MSBHidn05boxu1La2y3cbOUSthLgQUQovGD4hjw3fn1n4Q+IGMo3dC+h+WQ+dVgFWHuiVJZZ4ByL4QDehiu38PH9vdOmRUr3rf5LQB6Uho/2SgFv11Bx2mIhCmIuBSlRdL9bGkv9g7kt/3VPKnuUvoE4zCq/w7SlBt3eN++DA0SLAMsY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(376014)(11063799006)(56012099006)(18002099003)(13003099007)(43062017);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: egMLz0x/kmSwmvpHdUuMrbR82gheOdZplRUhxUmHIS4znJO36QZtq8nOWVCDBq3GoC8upBu8Yv/w4OO0uN48Jj1Z6BNajumdbRY23J6fbnJKbkUmT+RQCQwD99UG5aIXjJ4e7N1UTMqdHioHM+Ck1hztwC6BC63UJMoiYkRQObtNdqWEHR2BhpjocqCCMggALVv4rSArHF24uaYZvP4Qw9kOGPCBL+sSd6ek4X5iYHX2IDzmJQ8zfROklaZXZmfBf0ff/n+LLhjn6CauGFHwn4BufDuPj3VVpxu9GzF/1xJh3MhUsrlRGxCHEJ2oGwWlgMqhbAxpLmoC0V7wi3ez5kLB8yn8iIKxbIQ1Tl+H8IhfuAtppzDIFG/MxuwTXkgek3ujjHXcrUdMfARxd/ua3CAYMw5RddY+qy8n88/yda2TSMpTwYqFqRAPCUsW9OMD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 09:08:32.3919 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8a26cba-e85e-4628-ad7d-08decb86d6e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7115
Received-SPF: permerror client-ip=52.101.52.29;
 envelope-from=FangSheng.Huang@amd.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This series adds a TYPE_MEMORY_DEVICE subclass `sp-mem` for boot-time
SOFT_RESERVED guest memory, following the direction from the v7
thread [1] and the v8 / v9 / v10 / v11 reviews [2][3][4][5].

Background
----------

This series targets coherent CPU + accelerator shared-address-space
systems, where the accelerator's HBM is not a device-private
framebuffer behind a PCIe BAR but a tier of host system memory:
visible to the CPU in the platform physical address space, shared
coherently with the accelerator over the platform fabric, and bound
to a NUMA proximity domain set by platform firmware at boot fabric
training.

For such a region to function correctly in the guest, two things
must hold simultaneously: the CPU memory subsystem has to see it in
the system memory map (so the CPU side can address it), and it has
to be reserved exclusively for the accelerator's driver (so the
kernel's general allocator does not hand SPM pages to unrelated
workloads). The SOFT_RESERVED memory type in E820 plus a matching
SRAT memory-affinity entry is the mechanism that delivers both: a
firmware-produced topology that the CPU memory subsystem honors and
the accelerator's driver consumes for its own range.

Approach
--------

The series introduces a new TYPE_MEMORY_DEVICE subclass `sp-mem`.
Each instance binds one host memory backend to a single NUMA
proximity domain and is boot-time only; placement, mapped-state
enforcement, and QMP introspection come from the existing
memory-device framework.

Testing
-------

Verified end-to-end on q35 + KVM, with both SeaBIOS and OVMF, for:

- single sp-mem instance
- two sp-mem instances on different NUMA nodes

Guest observations: /proc/iomem shows one SOFT_RESERVED entry per
sp-mem device, dmesg SRAT parsing reports the matching
memory_affinity entries with correct PXM, and the umbrella
HOTPLUGGABLE entry covers the remaining hotplug-memory window
without overlapping the sp-mem ranges.

Changes since v11
-----------------

  - Drop the unneeded memory-device.h and system/hostmem.h includes
    from sp-mem.h (HostMemoryBackend is forward-declared).
  - Use SP_MEM_MEMDEV_PROP in sp_mem_get_memory_region()'s error
    message, matching realize().
  - Move the .unmigratable comment next to the field it documents.

All v11 patch-1 review comments from Philippe; patches 2-4 unchanged.
Patch 4 (MAINTAINERS) retains the Acked-by from Igor and David.

Previous versions
-----------------

  v1: https://lore.kernel.org/qemu-devel/20250924103324.2074819-1-FangSheng.Huang@amd.com/
  v2: https://lore.kernel.org/qemu-devel/20251020090701.4036748-1-FangSheng.Huang@amd.com/
  v3: https://lore.kernel.org/qemu-devel/20251208105137.2058928-1-FangSheng.Huang@amd.com/
  v4: https://lore.kernel.org/qemu-devel/20251209093841.2250527-1-FangSheng.Huang@amd.com/
  v5: https://lore.kernel.org/qemu-devel/20260123024312.1601732-1-FangSheng.Huang@amd.com/
  v6: https://lore.kernel.org/qemu-devel/20260226105023.256568-1-FangSheng.Huang@amd.com/
  v7: https://lore.kernel.org/qemu-devel/20260306082735.1106690-1-FangSheng.Huang@amd.com/
  v8: https://lore.kernel.org/qemu-devel/20260527074215.229119-1-FangSheng.Huang@amd.com/
  v9: https://lore.kernel.org/qemu-devel/20260602084447.1100554-1-FangSheng.Huang@amd.com/
  v10: https://lore.kernel.org/qemu-devel/20260605104609.1739911-1-FangSheng.Huang@amd.com/
  v11: https://lore.kernel.org/qemu-devel/20260611100637.2460507-1-FangSheng.Huang@amd.com/

  [1] v7 thread closeout:
      https://lore.kernel.org/qemu-devel/666a7ba1-5d3a-4732-b872-0d9fb2fe8461@amd.com/
  [2] v8 review:
      https://lore.kernel.org/qemu-devel/20260601105057.2d764e55@imammedo/
  [3] v9 review:
      https://lore.kernel.org/qemu-devel/20260602084447.1100554-1-FangSheng.Huang@amd.com/T/
  [4] v10 review:
      https://lore.kernel.org/qemu-devel/20260605104609.1739911-1-FangSheng.Huang@amd.com/T/
  [5] v11 review:
      https://lore.kernel.org/qemu-devel/20260611100637.2460507-1-FangSheng.Huang@amd.com/T/

fanhuang (4):
  hw/mem: add sp-mem device for Specific Purpose Memory
  i386/acpi-build: partition device_memory SRAT umbrella for sp-mem
  hw/i386: hook sp-mem into the pc machine plug path
  MAINTAINERS: cover sp-mem under Memory devices, add R: tag

 MAINTAINERS                  |   3 +
 qapi/machine.json            |  43 ++++++++++-
 hw/i386/e820_memory_layout.h |  11 +--
 include/hw/mem/sp-mem.h      |  33 +++++++++
 hw/core/machine-hmp-cmds.c   |  11 +++
 hw/i386/acpi-build.c         |  96 +++++++++++++++++++++++--
 hw/i386/pc.c                 |  36 ++++++++++
 hw/mem/sp-mem.c              | 136 +++++++++++++++++++++++++++++++++++
 hw/i386/Kconfig              |   2 +
 hw/mem/Kconfig               |   4 ++
 hw/mem/meson.build           |   1 +
 11 files changed, 365 insertions(+), 11 deletions(-)
 create mode 100644 include/hw/mem/sp-mem.h
 create mode 100644 hw/mem/sp-mem.c


base-commit: 2f28d34ea0aead9830478cd1d3d0dd9d9191d82e
--
2.34.1


