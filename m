Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB8F606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 14:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=skiw/fPc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUPf5-0005KZ-6K; Fri, 20 Nov 2026 09:32:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xUPet-0005IZ-Lm
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 09:32:11 -0500
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xUPeq-00038w-K0
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 09:32:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mdrdPFtWKoGR6pcnrUVWkd3ychC/0pIt2dGF8AAfeIWTnCH8w5LsV7Z6hWafa09xFi9nvwGdsZfI6nUSBtBksvuAkBi7laGaeNfjIjV+jVd2QSU1zpP86ltS/spJ3mOSQaDZqTEHNIzh83wdXg7as7uerNMuWMezyvRI/d34waaS1irl0Zyx/uXWaU8Y+pmVys8sP9OXLKDCS5oZBMU5Y/DEikzWjm6Kee+yr/3z5ZIVbwJkTe3M5uDo0B1qysAPQRFMb+uT3YaFHZ4ySBUkytJhw0HoWrbKhKBneXKp0kCFbxZoYtKtge9SFbL9LYjJSjyRpqBmYz6WGcizsrMBdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+9/fxLZQJpkgDnIdZcyJqx5wFBA5I5AiSMSCgOMYXQ=;
 b=Zgk+SttKnOYe4u0ntItSSutmqLcndl9rjndh83QEAUlqRNGqyUSabWfzFd0yWuf6KgodoMIrUWL2m0Rf7EcHOMLq5VSBqwSxtj7q8zKe9rTQ+IvfYFXfyCGxj6u2PU0FsD4vwsHhmPQei8K6P9VdKJPhv3S+qYTEnbcU9ZdPeiZBuZ03nbqmIjjleN6n6hinZKPV8o7l7q/cIt4df5CzU5UIj9nlhzqXuZnpmBNobDm9dwAWN3/O5n1UAmQo+3yYvYvJ2tJ18USD9S9tLjffyUbt+erpGgNk6QVmqkC7nQCi7LzvABHeW0PpazMAePlPxgzwiQv5EmSSsiO4upQBWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+9/fxLZQJpkgDnIdZcyJqx5wFBA5I5AiSMSCgOMYXQ=;
 b=skiw/fPcCGNTE6lD4KMnwiHnh8Yb/CH9hBjQJaz5ojVFrHSoSqJPY1W9SMp/lzCXrAvNx5s1HxmbCqA8IKfJgGMbgERIqfDrEqueNtW4owmPYZyUm6bVpXax3F050mhm+DAh5WvSkXtITTpmm/oJ6g6FRUSeZUDZKp9YNoCYgW0=
Received: from PH7P223CA0004.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::12)
 by PH7PR12MB7914.namprd12.prod.outlook.com (2603:10b6:510:27d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 14:24:27 +0000
Received: from PH3PEPF0005961A.namprd05.prod.outlook.com
 (2603:10b6:510:338:cafe::30) by PH7P223CA0004.outlook.office365.com
 (2603:10b6:510:338::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.12 via Frontend Transport; Fri,
 20 Nov 2026 14:24:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH3PEPF0005961A.mail.protection.outlook.com (10.167.243.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Fri, 20 Nov 2026 14:24:24 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 20 Nov
 2026 08:24:23 -0600
Date: Fri, 20 Nov 2026 08:23:26 -0600
To: <qemu-devel@nongnu.org>
CC: <richard.henderson@linaro.org>
Subject: [ANNOUNCE] QEMU 11.2.0-rc1 is now available
Message-ID: <ilzgcyfxmgfqdcna72nc7cseoff24i7qlzwabs6elf2cdkozts@j42mj62bgp2t>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PEPF0005961A:EE_|PH7PR12MB7914:EE_
X-MS-Office365-Filtering-Correlation-Id: a8717070-8466-472a-b1cc-08df4711fa0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|6133799003|261009223027099003|18002099003|3023799007|13003099007|11063799006|260925021311599003|260925022911599003|260925021911599003|56012099006|261102123227099003|261022105027099003|261022075727099003|261021135927099003|261028144727099003|261026140227099003|261026121527099003|261021123027099003|261021121427099003|261022115727099003|10067099003;
X-Microsoft-Antispam-Message-Info: QTME1a6cbDfIGAlRPMvMXbQtqC48+lNtiFzQWesnmPeB614JpMTjI57RyKx3DaWteI3qEZzBdyonddk1z+WmkEaco9jgtAej2B4bXECg7UwRLjhq6OBiSvMilV09eqaJXzqSlqVABxTrh2/2QNQ9OeHu6E7nVYoBwHdMNdRlpvvRd2UvuiihXX8ue0Jat1v6nGxEa2MwPzWIPTtMbemr5Ocfvq97i5bQD5XTFm1tEtYRsCEnxfjRBtUrovRMWPdDkk0YjmhGTyOwPsQ3sWjnbBta+6uXUT+DeVICAIQedqYlfUyqIXtY9TB5UOJecGG+AGEyz7z2tQ4lU0Tnzi/hTKn+g/dixbY6ZvOEOGpB1oHXBseF9WmpOngPDfXv26jLI2E/AvGojMm9CIH1n4L6X2BqGpXmTZ3vuNHUC8LqQ5WMUpJpsIUtbNq4JA8ZM1tSe4+iCcFE1Zd+CinXERQ5uIAMq3o2pK0dzbbdeaRRDkkuy//ieEJdZ83JpIGEpzge6i9hzB14POFQFssHcVO2VjaEk6wBzCBlLwJPvLQKp6iuf8cKhIb3bZ7+JgRU0UFeLH4JlDQSMpLanzF2I9loeuz3ILrVWbEIK7OUUAMJphDz2sqsw2mHlAtP7ZbkCFZZ6BYTckq6D6Yiligvw5F7yw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(6133799003)(261009223027099003)(18002099003)(3023799007)(13003099007)(11063799006)(260925021311599003)(260925022911599003)(260925021911599003)(56012099006)(261102123227099003)(261022105027099003)(261022075727099003)(261021135927099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021123027099003)(261021121427099003)(261022115727099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5GRPqm3+eJ5lNRSnT1EFmUWnn5uYV3E7oagXy86nFwH7gJ9vZZSA3xkPECH4z2PJY004ph+uX9sOgMFrciE2iLLa5KQlpxt3e9MWbNh6ppfY7/VluoP8m0CVr6fWpPyaDaj/r53Fu58od1O34JjZPw5y1F2KpbUphXr7jA056+Du5lh3Ap7rEQy/EWZIuyszeWRbphCqfKszZOMThTkbMmcChMBwayAGGt+u+9IFxOwwTeet0o0Ef0EtqUGE23STBAvp25CAe7ZiHKf4pIEN/z2+sFYK7bQ2TjjLCYQzTy43bLrYm3ee9L5RchHtu4+t1Y3pHhfYI7xWzIVOlGsCtqQAgb0AwGU67eheqxBh6AVO1pVishhgyU9FNnBBl6v57TZFFm8MSQldq6uxYbaEoGgK8WH+GcZeakJfVGkoFZHUQCniI1ZdprIYHVgdnZlg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 14:24:24.3851 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8717070-8466-472a-b1cc-08df4711fa0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH3PEPF0005961A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7914
Received-SPF: pass client-ip=2a01:111:f403:c001::2;
 envelope-from=Michael.Roth@amd.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Michael Roth <michael.roth@amd.com>
From:  Michael Roth via qemu development <qemu-devel@nongnu.org>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello,

On behalf of the QEMU Team, I'd like to announce the availability of the
second release candidate for the QEMU 11.2 release. This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu.org/qemu-11.2.0-rc1.tar.xz
  http://download.qemu.org/qemu-11.2.0-rc1.tar.xz.sig

You can help improve the quality of the QEMU 11.2 release by testing this
release and reporting bugs using our GitLab issue tracker:

  https://gitlab.com/qemu-project/qemu/-/milestones/20

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/11.2

Please add entries to the ChangeLog for the 11.2 release below:

  http://wiki.qemu.org/ChangeLog/11.2

Thank you to everyone involved!

Changes since rc0:

08c9bbb825: Update version for v11.2.0-rc1 release (Richard Henderson)
2b5920edfa: build: Add "-d keeprsp" to Ninja flags (John Snow)
bc10d84ed1: rust/common: rename IntegerExt::bit() to single_bit() (Samuel Tardieu)
40a6c128be: target/i386/tcg: treat ENTER's size operand as unsigned (Zixin Wang)
522b2d9b3f: target/i386/tcg: remove unused operand sizes (Paolo Bonzini)
9f919c5bce: target/i386/tcg: remove unused argument of decode_ops (Paolo Bonzini)
933ba4d7e2: target/i386/tcg: all scalar instructions should be LIG (Paolo Bonzini)
48eee6181d: target/i386/tcg: Fix 64-bit RSP truncation on far call through a call gate (NickSampanis)
29da93aae9: target/i386/tcg: Fix 64-bit RSP truncation on far call in 64-bit mode (NickSampanis)
f01645dab1: target/i386/tcg: Fix 64-bit RSP truncation on retf in 64-bit mode (NickSampanis)
75b2b67e6a: tests/tcg: fix load/restore for test-avx and test-mmx (Paolo Bonzini)
12b2682224: target/i386/tcg: fix lea address calculation for CS register (Mark Cave-Ayland)
b8619010fc: target/i386/kvm: set VM ioctl KVM_SET_TSC_KHZ to maintain TSC synchronization (Dongli Zhang)
d348cc1e52: target/i386/kvm: fix latched INIT lost in kvm_put_vcpu_events() (Denis V. Lunev)
66f2933c8a: target/i386/tcg: fix SETCC(zu) optimization (Paolo Bonzini)
0f9a4145bf: target/i386/tcg: reject VEX encodings of PBLENDVB, BLENDVPS and BLENDVPD (Paolo Bonzini)
dfc64f2809: target/i386/tcg: fix CPUID checks for TZCNT and LZCNT (Paolo Bonzini)
305a62d849: target/loongarch: Discard vmstate_tlb field (Bibo Mao)
56d81acd2b: Revert "target/loongarch: Remove TLB entry in vmstate" (Bibo Mao)
0bf35a66b6: block: notify only the replaced child in bdrv_replace_child_bs() (Denis V. Lunev)
e07d2e16a2: block: add bdrv_child_notify_resize() to notify a single parent (Denis V. Lunev)
be17bbca92: block: read the old child length after draining in bdrv_replace_child_bs() (Denis V. Lunev)
2a4384b4ef: block/vhdx: Add alignment checks for region tables (Thomas Huth)
5a0fc8f8cf: iotests: fix false positive on running-outside-venv warning (John Snow)
95c27a042a: block/vhdx-log: Improve sanity checks to avoid OOB accesses with bad images (Thomas Huth)
cf2f97574c: tests/docker/dockerfiles/release: use full registry name for image (Pierrick Bouvier)
1138de1de1: tests/tcg: detect redundant exe_name/test_name (Pierrick Bouvier)
ced866d1ec: tests/tcg/riscv64/system: remove exe_name as it's already the default one (Pierrick Bouvier)
81641446c0: tests/functional/x86_64: Add test for ccid-card-emulated (Peter Maydell)
8226ab2b9a: migration/block-dirty-bitmap: don't hold the load lock across stream reads (Denis V. Lunev)
9d513a4b3b: migration: free migration blocker error in migrate_del_blocker() stub (niming)
17262bf41f: migration/cpr: document the BQL as the cpr fd table lock (Denis V. Lunev)
c3af4e0af1: hw/i386/amd_iommu: Mask address when calculating large PTE page size (Peter Maydell)
e777dac725: block/bochs: validate bitmap size and compute extent_blocks after validation (malike)
5c33a72bde: target/arm: Fix barrier polarity of A32 LDA load-acquire (LIU Zhiwei)
9567b4d2c3: target/arm: Fix RCsc ordering of store-release instructions (LIU Zhiwei)
1f19e0dea1: target/riscv: Fix RCsc ordering of Zalasr store-release (LIU Zhiwei)
a1c20b516f: target/arm: Get HVC UNDEF cases for Secure mode right (Peter Maydell)
aa0d2a4006: Revert "include: introduce qemu/version.h" (Peter Maydell)
b72d23197b: Revert "meson: rewrite scripts/qemu-version.sh directly in meson.build" (Peter Maydell)
f445ebd9d7: hw/virtio/virtio-iommu: Fix IOVA address lookup (Eric Auger)
8c40d4495d: hw/xen: Mark legacy Xen backends as hotpluggable (Peng Fan)
81ce8c16ee: hw/block/m25p80: fix write enable latch after WRSR2 (Chao Liu)
fe2a7966db: hw/usb/dev-mtp: Stop processing SendObjectInfo after an error (Tommaso Califano)
69aedf407d: hw/usb/dev-mtp: Check length of class control request (Tommaso Califano)
224899c3d3: hw/usb/dev-mtp: Fix recursive delete of directories (Tommaso Califano)
fbdddccab1: hw/usb/u2f: Use QemuSemaphore rather than QemuCond (Philippe Mathieu-Daudé)
7f5c789db1: hw/usb/ccid-card: Use QemuSemaphore rather than QemuCond (Peter Maydell)
09f671d804: hw/usb/u2f: validate ring buffer indices on migration load (Bin Guo)
996f3dce54: hw/i386: move bios functions into x86-bios.c (John Snow)
721566eb7d: pvg: disable by default (Mohamed Mediouni)
8a70cea4da: build: update CONFIG_PVPANIC (John Snow)
21be087238: build: remove vestigial CONFIG_SGA (John Snow)
7bb3c04b93: qga: fix uname() return value check in guest-get-osinfo (Brad Smith)
a2613ee714: qga: fix build on illumos (Roman Bogorodskiy)
83328c803c: meson.build: fix getifaddrs() detection on illumos (Roman Bogorodskiy)
16e9879ed2: tests/tcg/aarch64: Add vector immediate regression tests (Philippe Mathieu-Daudé)
d472efd0f1: tcg/riscv64: Fix logical vector immediate matching and emission (Philippe Mathieu-Daudé)
22e4439a20: tcg/riscv64: Fix constant handling in vector comparisons and selects (Philippe Mathieu-Daudé)
6d09dfabf5: tcg/riscv64: Extract elements for vector arithmetic immediates (Philippe Mathieu-Daudé)
78239bddd9: tcg/riscv64: Use a uimm5 encoder for vector shift immediates (Philippe Mathieu-Daudé)
66c946705d: tcg/riscv64: Factor encode_vi_raw() out of encode_vi() (Philippe Mathieu-Daudé)
c0080f5603: hw/nvme: fix broadcast fdp events handling (Klaus Jensen)
f7d61b4064: hw/nvme: fix fdp reclaim unit accounting (Klaus Jensen)
e095e8baaa: hw/nvme: reject fdp.runs smaller than the lba data size (Klaus Jensen)
0b9935a847: hw/nvme: verify source and destination lba size for copy (Klaus Jensen)
ada720d1e8: hw/nvme: clear interrupts on controller reset (Markku Ahvenjärvi)
c5d75e36cd: hw/nvme: fix missed CQ updates (Markku Ahvenjärvi)
e019b94a0b: hw/nvme: prevent cq_pending underflow (Markku Ahvenjärvi)
277f11f3e4: hw/i386: mark vmmouse / vmport as secure (Daniel P. Berrangé)
7ed695951a: hw/input: mark PS/2 and PC Keyboard devices as secure (Daniel P. Berrangé)
690ee34385: hw: device AMD, Intel and ARM IOMMUs as secure (Daniel P. Berrangé)
cb3717eae7: hw: mark KVM clock and RTC devices as secure (Daniel P. Berrangé)
acc28b58d8: hw/acpi: mark erst, vmclock and vmgenid devices as secure (Daniel P. Berrangé)
304e184eb3: hw/uefi: mark the EFI vars service as secure (Daniel P. Berrangé)
d0b940a873: hw/mem: mark nvdimm, pc-dimm & spapr-nvdimm devices as secure (Daniel P. Berrangé)
cdecccb503: hw/char: mark common serial / console devices as secure (Daniel P. Berrangé)
78be975139: hw/audio: mark Intel HDA devices & codecs as secure (Daniel P. Berrangé)
236cf00308: hw/misc: mark pvpanic, vmcoreinfo as secure (Daniel P. Berrangé)
86cef89c7d: hw/tpm: mark all TPM implementations as secure (Daniel P. Berrangé)
1779f7c359: hw/display: mark bochs, ramfb and VGA as secure (Daniel P. Berrangé)
29adccbf7b: hw/pci-host: mark common x86, ppc, arm and s390 PCI hosts as secure (Daniel P. Berrangé)
f826d8fd04: hw: define most common PCI types as secure (Daniel P. Berrangé)
397707620c: hw/ide: mark ICH9 and ide-hd/ide-cd as secure (Daniel P. Berrangé)
657d79f50b: hw/scsi: mark SCSI disk endpoint devices as secure (Daniel P. Berrangé)
dd90104815: hw/scsi: mark spapr SCSI controller as secure (Daniel P. Berrangé)
d2aa1afbab: hw/watchdog: mark some watchdog devices as secure (Daniel P. Berrangé)
75cad51ead: hw/usb: mark commonly used USB devices/hosts as secure (Daniel P. Berrangé)
b1e9f08695: hw/net: mark e1000, e1000e, rtl8139 & sPAPR VLAN as secure (Daniel P. Berrangé)
46b1d31d76: hw/xen: mark all Xen related object types as being secure (Daniel P. Berrangé)
7261bf4cfc: hw/vfio: mark all VFIO object classes as secure (Daniel P. Berrangé)
0baaf7ea07: hw: mark most remaining virtio object types as secure (Daniel P. Berrangé)
4a6202b037: hw: mark all vhost devices a secure (Daniel P. Berrangé)
222d06558b: hw: mark all virtio CCW devices as secure (Daniel P. Berrangé)
37e46d8bfa: hw: mark most virtio PCI devices as secure (Daniel P. Berrangé)
8ff6cd65b6: python/utils: fix accelerator detection with annotated -accel help (Marc-André Lureau)
7a0867e617: python: add support for Python3.15 (John Snow)
7d8fc59308: hw/arm/virt-acpi-build: test vms->acpi_dev before building HEST (Ren Yanyi)
da79d1a328: hw/net: cadence: Honor subword lanes in the GEM registers (Bin Meng)
807af9d880: docs/about/deprecated: Fix heading level for AF_ALG heading (Peter Maydell)
64593b5ca1: docs/about/deprecated: Add missing "since" marker for OABI/NWFPE (Peter Maydell)
aa6541b79a: Revert ".dir-locals: include QEMU code in PYTHONPATH" (Alex Bennée)
e11bc69ae0: hw/arm: Deprecate Nuvoton quanta-gsj board model (Peter Maydell)
e17590ca62: hw/net/eepro100: fix use-after-free on reset after hot-unplug (Stefan Weil)
14fc71522a: net: Remove padding code from net backends (Peter Maydell)
57bae3bdbf: target/riscv/tcg: clear itrigger_enabled during trigger_reset_hold() (Daniel Henrique Barboza)
e9f4308d84: hw/riscv/server_platform_ref: Fix mtimer frequency (Sunil V L)
dc78319021: hw/intc/riscv_aplic: Check config value bounds in realize (Peter Maydell)
1407356927: hw/riscv: Select SSI for IBEX (Tan Chi)
8b7eaae999: hw/riscv: Pass socket topology to KVM AIA (Tan Chi)
bdd634cf5d: hw/riscv: Move platform bus FDT creation to machine code (Tan Chi)
53ae381b10: hw/riscv: Build device-common only for its users (Tan Chi)
e6f5ca127c: hw/riscv: Build AIA glue only with APLIC and IMSIC (Tan Chi)
f448e6d9cf: net: Pad short packets consistently regardless of backend (Peter Maydell)
f996ee991c: tests/qtest: Make netfilter tests accept padded ethernet packets (Peter Maydell)
e4236a7e87: hw/net/net_rx_pkt: Check for overflow in _net_rx_pkt_calc_l4_csum() (Peter Maydell)
fda35a236c: hw/net/net_tx_pkt: Sanity check L2+L3 header len in net_tx_pkt_parse_headers() (Peter Maydell)
d95e10195a: hw/net/net_tx_pkt: Sanity check virt hdr len in net_tx_tcp_fragment_init (Peter Maydell)
bd649f019f: hw/net/net_tx_pkt: Sanity check GSO headers in net_tx_pkt_build_vheader() (Peter Maydell)
5251fee208: include/net/eth.h: Make eth_get_l2_hdr_length_iov() check protocol (Peter Maydell)
2dd4094cfb: net/eth.c: Tighten size checks in eth_get_l3_proto() (Peter Maydell)
b5e0b450fc: net/eth.c: Harden _eth_tcp_has_data() against short lengths (Peter Maydell)
34bca63769: net/eth.c: Move the Routing Header Hdr Ext Len check (Akihiko Odaki)
4828fff27b: net/eth.c: In eth_parse_ipv6_hdr(), fix check of input size (Akihiko Odaki)
a80bcdb2ad: net/eth.c: In eth_get_protocols(), don't report SCTP header off end of packet (Peter Maydell)
c27a586b8b: net/eth.c: In eth_get_protocols(), don't report TCP data offset off end of packet (Akihiko Odaki)
987f5bc647: net/eth.c: Check for undersized IPv4 headers in eth_get_protocols() (Peter Maydell)
ba4bf52024: net/eth.c: Check for undersized L2 headers in eth_get_protocols() (Akihiko Odaki)
7149c66149: hw/net/net_rx_pkt: Handle bogus l4hdr_off when validating SCTP checksum (Peter Maydell)
cfe0636ad1: include/hw/core/ptimer.h: Fix 'version' argument of VMSTATE_PTIMER (Peter Maydell)
02794143a3: hw/watchdog/wdt_imx2: Set vmstate minimum_version_id to 1 (Peter Maydell)
fc8bb17e47: hw/core/qdev-properties-system.c: Don't leak str in set_drive_helper() (Peter Maydell)
a378b4701c: hw/intc/arm_gicv5: Use correct type for value in lpi_cache_get_hppi() (Peter Maydell)
891113abc4: target/arm: Only allow GICv5 on CPUs without AArch32 at EL1..3 (Peter Maydell)
496e57bf7b: hw/intc/arm_gicv5: Free memory in finalize (Peter Maydell)
24728fa1ed: hw/intc/arm_gicv5: Use cached IRS_IST_BASER.VALID state (Peter Maydell)
bcfc9c3967: hw/arm/bcm2838: Route SPI0 interrupt to GIC (Hanyu)
df6cdfb3c3: hw/ssi/stm32f2xx_spi: avoid transferring data on DR reads (Manuele Conti)
e682c0e570: iotests: Add another nbd-robustness test (Eric Blake)
325b8b75d5: nbd/server: Reject rather than assert on non-compliant NBD_OPT_SET_META_CONTEXT (Eric Blake)
3e6759157e: iotests: Add new nbd-robustness test (Eric Blake)
3ec7bb1935: nbd/server: Reject rather than assert on non-compliant BLOCK_STATUS (Eric Blake)
9bc9e737a3: iotests: Refactor python NBD server setup (Eric Blake)
fd2cee4c2e: docs: Mention security considerations for NBD (Eric Blake)
84d6ea1499: hw/audio/intel-hda: Belatedly update comment for removal of -soundhw (Markus Armbruster)
a308817bf3: MAINTAINERS: fix typo in Gerd's name (Alex Bennée)
7412a6a275: docs: fix a few typos (Filip Hejsek)
ba58329c5e: hw/audio/fmopl.c: Convert malloc, free to g_malloc0, g_new and g_free (Lucas Cardoso)
e5f54bcd1e: io: avoid potential double close of qio_channel_file's fd (Filip Hejsek)
fcc504b770: target/i386/mshv: add MshvPutState for vcpu writes (Magnus Kulke)
faf92218ec: accel/mshv: freeze time during TSC MSR write (Magnus Kulke)
cc47cd339a: target/i386/mshv: fix vCPU run result contract (Magnus Kulke)
3b9e70ba6c: accel/mshv: skip double unmap of mem regions (Magnus Kulke)
9a0f03f815: virtio-snd: period_bytes divides buffer_bytes (Manos Pitsidianakis)
259b58e68e: virtio-snd: cap maximum buffer_bytes to half a GiB (Manos Pitsidianakis)
0d9843799c: virtio-snd: don't allocate pcm_info zero-count buf (Manos Pitsidianakis)
c50c39370c: virtio-snd: reject invalid feats in set_pcm_params (Manos Pitsidianakis)
3d9c8c41d0: virtio-snd: add pcm_state_to_str() (Manos Pitsidianakis)
21f87695e6: virtio-snd: convert virtio_error to error_report (Manos Pitsidianakis)


