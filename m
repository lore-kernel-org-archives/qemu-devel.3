Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7832C88E45
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:30:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x53Bp-0008AD-LT; Fri, 11 Sep 2026 11:29:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1x53Bn-00088Q-8x; Fri, 11 Sep 2026 11:29:19 -0400
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1x53Bl-0007DT-6U; Fri, 11 Sep 2026 11:29:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CdAm19Mo7rdd66rHN9rNv0340HOAxpCZwzOlhOVMJT6ZouyLRxbn8WlcUxWbJW+ENsxxbyZ483+/pplI76g3vdjp+fSwZEQYLJyTDjrpRRWZLMQtgU9KxmvZGRegj3WZKF68TnBFIbkNmstoqSBLbJ3SPUBq11cfnWO1S5Qi7l31U0tm6xrkKgO3MxsrDS0WQ5wP4vIGLmq+NPhy18vfsNITCpvZBbq/B/Pw4PFBAiyaJBLZc6rED24McEmS9fvsxRXSZKLR5tScTilNLcyXAuJ2HbqfX+x/pgqc+EKz4BE9grkmbTmyein2s4fOfgly0LsmcLTv30NQHwsoP3ycRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b2T9xPbL2h+87eF3boX4RyzBF7jSGp4/cu3caiMPlQE=;
 b=yuEmHmBQtPmOd0EXuqjoPx9jQSfVGANASc2i2LB4bQxUM39EsKr9m+sMiQZ7GEZOUZGu+ej+wUHnzaJXijEttu949og7lX2EbS2BFgDX8suHw+GAg7aPH5uw6SvbEwqx8d5L+IFG1ShSIvyFfe7hWCwc7rPN5pXOj0sjhPOz2VYOZH6g9HcyedQBLub4+RXqikg1APJK+/CZL9YpIQRIXmD1nxMbJt01qdoNLDNLSQXos3XkexHNQmlx1DJIHuAbHCkp3O28Mw/cEGp+dIzYYSEYxyJ2Vi+fE1NrWoVQ6fOKl3hiHapA3sJzIYHVzy9YzfQ+9vGJ4eqAlWteeR2Twg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2T9xPbL2h+87eF3boX4RyzBF7jSGp4/cu3caiMPlQE=;
 b=EBidszgj2IRqbJlWSUIvJSSpW49adCtxxN2KhPVJhpVjVsFZcoFQYQYPuXiQEX66c33Q9Y5Q+ndIAajaRUSl3LYqNLWirdb1vjEzkkP7dcpbwGfy6ZMrnuJHPdSFkIayjgmmg+z5vUio3gP5G+Rb6arEiVOPbiLehYFIQOWbQ1r9hVKwQ3bQzvbcaQROJUgfx9eAvOMK26yfLtZLD9028pVM8B+ITbLBRLcuhbGbtpGwL6wKefMXOkFba2XV+hwBfdNEKSCU33DzSZN+z/3TRtXwFwH+v0yL6nh5cn6bV9b7HBQlbjFVgcNOjQdlBvl39YxkvP2moHiR2A/7rxg79w==
Received: from SA9PR11CA0017.namprd11.prod.outlook.com (2603:10b6:806:6e::22)
 by PH7PR12MB7188.namprd12.prod.outlook.com (2603:10b6:510:204::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 15:29:05 +0000
Received: from SA2PEPF00003F68.namprd04.prod.outlook.com
 (2603:10b6:806:6e:cafe::61) by SA9PR11CA0017.outlook.office365.com
 (2603:10b6:806:6e::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Fri, 11
 Sep 2026 15:29:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F68.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 15:29:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 11 Sep
 2026 08:28:35 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 11 Sep
 2026 08:28:32 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <cohuck@redhat.com>, <sebott@redhat.com>,
 <berrange@redhat.com>, <peter.maydell@linaro.org>,
 <khushit.shah@nutanix.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jan@nvidia.com>, <wangzhou1@hisilicon.com>, <maz@kernel.org>,
 <oliver.upton@linux.dev>, <skolothumtho@nvidia.com>
Subject: [RFC PATCH v2 0/5] hw/arm/virt: Add support for Target Implementation
 CPUs
Date: Fri, 11 Sep 2026 16:27:49 +0100
Message-ID: <20260911152754.706518-1-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F68:EE_|PH7PR12MB7188:EE_
X-MS-Office365-Filtering-Correlation-Id: bfad0514-c61d-4bd0-5cf4-08df101969ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|23010399003|376014|82310400026|36860700016|1800799024|6133799003|18002099003|56012099006|11063799006|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info: EQisE9XmvQF6+7E33VF7reE65HcjSrpEKZNg5wmbHZ8/gA/mukvxweXnop0ph4WNAimA4dDaL9foa1gRkkWKWreRt/WdLlj2rSYAGUZGbpDxyiH+H/BXxVFHMSxXTY7WKzelKl56WCjTajXivFEoj/p3t9BX1T5bu10ffhKvnLL20Wz8KUTCo+nmSxiPQxtlSPYLwvRdy1BDbxPHkupQhNU3ded2TGcfqJZNS1Zw9NU75nac+7LNeOt5XsQisElDeWQJeW56hSW8ppAL86HEuRCqLhZohqzhE9evt1WsYtA+/5Lik4W8ie+x1QCYLfKrWS1dpzJc03D1DVm6W8Y9F1WhZ7SWaZaArgcNBJkHyFO0oHAmwlA6G2p0j+haJMXCXKw9T1R4h3Mpb8+QYlcTt5m/SL5cchvLH2stKlhMudQ6XNVDpzve9ftXt0k4CqpeP6hLHKSnBWEhQC2uqsGxpu4gKvnt1rFXHBz/VwD3usqzOkFGC9zh8vZRuOTNwbUf7PDBMUGugjEiElWakbGIM3PNl010yV9yiyf+GS9NDqQDGLsuTOhJDZd3EOAny091WWY2RJGfcCvCnlXBv/HaG2jixJjuoeuqjzJ0bNLLJH+zP2hLVPPuDTu16l0aI/PR6nETyw5RmlKVvgSDCHKk59mywDe+bTcnYnrPdn+2oTIpb8zqiwNxeB++kS6nsFmONoY6+YiWywtkuER+SNX0nw==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(23010399003)(376014)(82310400026)(36860700016)(1800799024)(6133799003)(18002099003)(56012099006)(11063799006)(10067099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ikYkcbvopHrnXwSG6fa0YF3GqybPlRI5XxxrhTrAvDCTfppxN8mO8PD7sdE4Z8/BPG2E1rrCqMGdKFOnSxdDM6keLgXclYA86DMAiTG9Az1mi8gVYh/fojrl2wOQ/kEsflhy5MmZzuzHJpPXxIbcYCcK+Q8VhPQ2JjF8mlmLy/8coI24CB9znFVt5aeAW1g6Mjaz6e4mzLrJ+41IZSP8BEOh+yl2K7tQxxO2IkPX/K7jQL9jWeRIYLe3me/+rzXJ99XegySQUBkg1ynkNLDnTu+p2IlMbqwHkbxHI6GIDvE1qik+E0r97liuKCEkAmCTng7JrNKlsuUJGzF5P6gi3DwQVSlTOGzx2zeRN9ZUyFLp8xx8zKw9kA6fNrdJHpR0xwhoWlN3mnsrpIRp7k6IowTtmot3SM7stwoWoCiSwqcqYIVz3MfjhwgXMvvJ7DWF
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 15:29:04.5640 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfad0514-c61d-4bd0-5cf4-08df101969ea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F68.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7188
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Hi,

Changes from RFC v1:
https://lore.kernel.org/qemu-devel/20250801074730.28329-1-shameerkolothum@gmail.com/

 -Rebased on top of Connie/Eric's "customizable aarch64 KVM host" series v8[0]
 -Addressed feedback on v1.

One item from v1 is still open: What should actually set the
implementation ID registers(Sebastian raised this on v1).

As it stands, this series enables KVM_CAP_ARM_WRITABLE_IMP_ID_REGS
but never writes MIDR/REVIDR/AIDR. impl-cpu feeds the hypercall only,
so a guest that reads MIDR_EL1 directly still sees the host value, while
DISCOVER_IMPL_CPUS reports the configured list. Sebastian suggested
using target_impl_cpus[0].*, which would make the guest-visible CPU
identity a configuration value rather than an artefact of whichever host
the VM first booted on.

Please take a look and let me know.

Thanks,
Shameer

[0] https://lore.kernel.org/qemu-devel/20260826093747.1670077-1-eric.auger@redhat.com/

From v1:

On ARM64 platforms, many errata workarounds are based on CPU identification
registers, particularly MIDR_EL1 and REVIDR_EL1. Some of these errata
require corresponding fixes in the guest kernel as well. This becomes a
challenge during guest migration between hosts with different MIDR/REVIDR
values, even when the VMM provides a common baseline feature set using
the recently introduced writable ID register support.

To address this, the Linux kernel now provides:

 -A mechanism to expose implementation CPU data to guests via KVM
  hypercalls:

  ARM_SMCCC_VENDOR_HYP_KVM_DISCOVER_IMPL_VER_FUNC_ID
  ARM_SMCCC_VENDOR_HYP_KVM_DISCOVER_IMPL_CPUS_FUNC_ID

 -A way to override implementation ID registers (MIDR, REVIDR, AIDR),
  which were previously treated as invariant.

What this RFC does:

This RFC enables the virt machine to specify Target Implementation CPUs
via QEMU command-line, exposing them to the guest via KVM hypercalls.

Example use case (hosts with differing MIDRs):

./qemu-system-aarch64 -machine virt,gic-version=3 \
  -enable-kvm \
  -bios QEMU_EFI.fd \
  -m 1G -smp cpus=4,maxcpus=4 \
  -cpu host \
  -M impl-cpu.0.midr=0x481fd010,impl-cpu.0.revidr=0,impl-cpu.0.aidr=0x551,\
   impl-cpu.1.midr=0x481fd011,impl-cpu.1.revidr=0,impl-cpu.1.aidr=0x551 \
  -kernel Image-6.16-rc2 \
  -initrd rootfs-iperf.cpio \
  -append "rdinit=init console=ttyAMA0 root=/dev/vda rw earlycon=pl011,0x9000000 kpti=off" \
  -net none \
  -nographic

Shameer Kolothum (5):
  target/arm/kvm-consts.h: Add SMCCC vendor hypercall definitions
  target/arm/kvm: Introduce helper to check target impl CPU support
  target/arm/kvm: Add QAPI struct ArmTargetImplCPU
  target/arm/kvm: Handle KVM Target Imp CPU hypercalls
  hw/arm/virt: Add Target Implementation CPU support

 docs/system/arm/virt.rst |  22 +++++
 qapi/misc-arm.json       |  36 ++++++++
 include/hw/arm/virt.h    |   2 +
 target/arm/kvm-consts.h  |  48 ++++++++++
 target/arm/kvm_arm.h     |  18 ++++
 hw/arm/virt.c            |  48 ++++++++++
 target/arm/kvm-stub.c    |  10 ++
 target/arm/kvm.c         | 194 +++++++++++++++++++++++++++++++++++++++
 8 files changed, 378 insertions(+)

-- 
2.43.0


