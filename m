Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33420606A329
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 18:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=gZOw+owe
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNwby-0007XO-0v; Mon, 02 Nov 2026 13:18:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1xNwbm-0007Vw-HG; Mon, 02 Nov 2026 13:18:21 -0500
Received: from mail-southcentralusazon11012028.outbound.protection.outlook.com
 ([40.93.195.28] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1xNwbj-000405-H9; Mon, 02 Nov 2026 13:18:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RD9DBNku0n+xGE7z/vUMpJ5mqXYA6wYJ+5qTHHdwuU5AfHI3d1y4rKdpZ3B1hI8wRdjvoZrCwSkxQBHOwFw3LYK1/caB/1CbNyNLLY6xsyse2zArfDT9uD37rPxgBSCbQMM+2Za4VIVJXfaSRhie2b6AuhKyx7HE0MouQRBeHLEsvX9NuZh9VTR6EIhgjpr9aHwMmBH7OU6GfIgQ6VclNQ38f92CUw6fEVw4IFL8Ifrw4L01Rhmb2ZhXvndoTO2OP5CDpTBKC+ONkglMKZHqUKTLdV4dY6Vo0tjX5g77kGVgzRuFP3KfoA/vpwKX3uMu7uhKzATR27T3RE07hyUv8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5YobTLa8ZIxH3YFbs0e3offuBDcXP/oDpmgpCICMoI=;
 b=KvJvs7wIHg+STAoANVZlD6wqk3xOlsUdp50wvgt4bQMccuAQP39T43yCKf6vTsNnE2q5sIMF0YA7aNN9YuhpV7EKalNgZ2eashdZv0Z5UlRaWlUnn5tFqD5TEkfj4UKDNqcQjB6v417ufe5pnJcaiUoahhKDIbJdCA2MWiCu6yqu4zjrKr1dxYlkGLLlg1wJoLwgsEkrIL75rtNGJuW2ipXMnWyiMuFg/C43MY2LtQgrn9pWTlaW4tQbs3ILwVePv3EHMDfqwc9FQfCew2lGYgwtHivXnE71ZrR2hj0rrNEt3LLbJxZVfP6V+OA2tiqFS6OiiLMwLwmruNxdZ9z9cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5YobTLa8ZIxH3YFbs0e3offuBDcXP/oDpmgpCICMoI=;
 b=gZOw+owe7xD2TS8cFu8vwnP6Ez4iSvttfxekUtFXBKVwA0GlH0V4zIp3AA+pZLnMCZeqry2wMN2nuyoSpQ1D0T61As2U7I+8+j385TT0RBMQefy+zeQ4ADGz2091WAB+o8ck3qykiIy6OByShJ9c7PjuIjyw9kZXrxBFtJM1qcWqpmAxXz9kvh4m8Xkx4KMS1vRVvol/n5hdHOHI389Wb5W72wgRQvObQ11NrVx32aTqcwXXKtqR/D4L0RMbpOEmu6PGa0gz9n0R6VkL6v4fzANoypfEG3jqI8jgthXVhIML3yxvJsxNugN/87wvvckhH1Ly9brkdRZfAG59DD7z6A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17) by BL1PR12MB5993.namprd12.prod.outlook.com
 (2603:10b6:208:399::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 18:12:57 +0000
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1]) by IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 18:12:57 +0000
From: Tushar Dave <tdave@nvidia.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 marcel@redhat.com, devel@edk2.groups.io, alwilliamson@nvidia.com,
 jgg@nvidia.com, skolothumtho@nvidia.com, ardb@kernel.org,
 kraxel@redhat.com, tdave@nvidia.com
Subject: [PATCH v2 0/5] hw/pci, hw/arm/virt: fixed PCI BAR placement
Date: Mon,  2 Nov 2026 12:12:36 -0600
Message-Id: <20261102181241.3077981-1-tdave@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR04CA0054.namprd04.prod.outlook.com
 (2603:10b6:610:77::29) To IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR12MB923065:EE_|BL1PR12MB5993:EE_
X-MS-Office365-Filtering-Correlation-Id: b25989b0-1f12-483a-5392-08df390cec3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|261021123027099003|260925021311599003|260925021911599003|260925022911599003|5023799004|11063799006|56012099006|261021135927099003|261009223027099003|261028144727099003|261021121427099003|261026140227099003|261022075727099003|261026121527099003|261022105027099003|10067099003|18002099003|261102123227099003|6133799003|261102130727099003;
X-Microsoft-Antispam-Message-Info: 3KGx8kvKKFdRcJaR7uKusBNNwCDClL8WdiWeXqNjLXOVv2u3L/A9jlK2U8s/WNU2plbIlzeuRAoFHfzqVgXtNS3XG3Iq7UDYVSTgA/WPcQZNg2jrvm+x4Ye4zT50ON7f3//Fg5EOtsoumRdqIPc28kSX5xMaClsyjTRmPp27rXZYP2BXcXlMu/eWh/O7hCWAH0XFr/1uFIeysqGbipSSBWkuBi6XSuaXfsRCx59/lX2ANK/ikk25sSnwpFpch3PWKVhwJBNji1JeOUke0nc2QhlB/gs8ZqGoluzc89SxGH0T18gaVfFssmX62KG/34+5WHw7Z0Bm1G2Iz2UCiFJOJr9Rl5sq4GevsmLP26SSAhBslt+xTJEv03o1Fl5QuqGJrdrWcSFpCAWrcD/MkDdmINSG0xg1ErX+AvY/fkG3ooNY0rhq0DAkV4eDJPdf0yW5BCf30Wlwyi11YF/YqaRwRQiri0i+OajVwYrQBcXXRUryqf/KmcgMEm+2FWQhZGxBZReDaB1CF2Lqd53fCboj6lmBvMutRk+pH2ohZYA3EiKworikntH2Ku6Qzk7D53L/w9fhITVHjzYE/4ZpKKQErO07U+Ff2TmN5nD7NZPloZgezhH7+eWf1PsaVlV0vIZXITiU4nkHi3YaOVZz4sJ9I11eUR6QLzYqCiV9aY4LCQE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR12MB923065.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(261021123027099003)(260925021311599003)(260925021911599003)(260925022911599003)(5023799004)(11063799006)(56012099006)(261021135927099003)(261009223027099003)(261028144727099003)(261021121427099003)(261026140227099003)(261022075727099003)(261026121527099003)(261022105027099003)(10067099003)(18002099003)(261102123227099003)(6133799003)(261102130727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tp4WdEDr42BoiQblO4mCpQ3lUCDf2/7YuKw3WxDzE0AK/XRuuVTs2f8j8JAt?=
 =?us-ascii?Q?BI3vgwEMGD7nklsnocreOHnvuFzDgFjFA5phQUeU9t7tWCkRHHqYAaz9qcqn?=
 =?us-ascii?Q?LtZB3jmL957Le8VTqvNRnl56G4wcrJuEyskjHNpsaLe8D9d3q2+CYYl7CJYf?=
 =?us-ascii?Q?Ew+dOzGpTf05wFAGJEYWcCFzn3jfTUSrdo/IHUTkJ2aNEu3UzYFCIxQwwt62?=
 =?us-ascii?Q?DgppsKyoe5gFNotM6tpDi/nKIdEMgS4Bw7qpvlw+lhPemacVcmVo9maarcH4?=
 =?us-ascii?Q?YkuL5HmYT9++yfiAViQUy2nYW4sV2pGKwXAkjTXqZ4RdEXSnB+Ws7AxmlXd5?=
 =?us-ascii?Q?WbTIe8bygSroswJUMK81GmKX9Oyy+jLixpHp8gj+tcU0pB1IxFdereEqXjx+?=
 =?us-ascii?Q?dGzkJCU/BJljX+0KmKI4GDN9gqk5YUm0lIFLetPSjao1un6IMjGlOWr5+p/q?=
 =?us-ascii?Q?vPiLdTOeV3xOZePc4xO/5aNnm8zEG47oi25bBYygEMlM4Q/GDBHajtAKuSr+?=
 =?us-ascii?Q?4BcUr0kN31NVW+dkatBRs3NPQqqjcfz5jWYIU0Krytc/HGYXrjIbK/3dHnlp?=
 =?us-ascii?Q?cJakCqj31f0b0sDCh8SvU0COFm9xzkdFzl7uqjP/a8YWp7v+SqAqohcr593h?=
 =?us-ascii?Q?3/O21Yu6Janr1x0snHZW3cH0RQLy4atnGOPXOk6bWKRVdGe4iIndA4/VlTMo?=
 =?us-ascii?Q?RwMBBElPcxAkAlAwH9200TOjnj0D3aYtLL2UUkUwUeGfRS0Lym4KnBoconwT?=
 =?us-ascii?Q?0D99jeniNJsNM+I+CpNxrnWJREZT4V1KKlYPpNALsEtdTy07jJh3u6Rk0ry5?=
 =?us-ascii?Q?RZFuWXG7Bzfdy1/0LiwoTQI3cRkbHgcR4Rc71IjXmSxGJPc1ZI4IQb1EAnsP?=
 =?us-ascii?Q?iNC0jrksDY+p2zac5Hv/ifn2cl6eLxTrXLkThLDZdgFfXN6JmvpW1Kjo4WY4?=
 =?us-ascii?Q?ata0j/9RTCpMlowCxWVJY9qOQVsLZCdFWxvAy+wgjDclraCdsAv3s/geQb3H?=
 =?us-ascii?Q?cYijATkE94sVSq2wY5bkp2kIQcoeghpf/x7CHzYmBq1jIcnDDvlc37kTp2cp?=
 =?us-ascii?Q?MhvR2WPZjq7AjqBP21n8vhJ9l53wPSnbCN3VqJFRz3icUJu51PWD2chJAgxb?=
 =?us-ascii?Q?R+PI1eCFokL+eQDzZ7UcHn9/qfOpxHMq86fqQ0vYk2plUxcWp22QyqFE0vzE?=
 =?us-ascii?Q?eksphKHB91ChU5SFAfVrgg76MyUQNF33U3do9hy3H4u2DEZ23NwXyNAakyVL?=
 =?us-ascii?Q?LSixQhsQdEbMXmHcTp0REROZxZ4wICNBe4cFzlJeWcgxfwyFK8aykjnTfGkT?=
 =?us-ascii?Q?tcZdLIRr21euQ31OlhJrCq5BeKYBqhQPFUWTPWwsP4CV6H1+p30RwhL4RotY?=
 =?us-ascii?Q?hEzbOIwCHFBeO1HGfL+nOZLy7GXuRAkVoRyrcYvwYIMq2Vbh/Xk6gAaRhgfr?=
 =?us-ascii?Q?J0kF9g0ZDARSDUCEp++Igf+MOIS76aeXCtqOV1lj72XsjEUEm4E0Gs3Xl7oL?=
 =?us-ascii?Q?8j5L4nNRmsG4n6WIP5XMY+JLC4FIKzWXeHzsjZKxI7j0cX52xFsLTsz5WZgl?=
 =?us-ascii?Q?/JZWG0VuDHIRzlphViBt116dDJHla6LbXc0WauijrJU1UkxU3J8FdAs9o4Nv?=
 =?us-ascii?Q?L3wr9ySpfVoCAejRDjprjmJHz+ARYa1SmgIkilbE8k7Q0WX3q/PvNjVZoI3w?=
 =?us-ascii?Q?WL0jlwN2smvOBP+SeBsxav/pFn28fQ3bHxEQmyhE4fW9bnOI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b25989b0-1f12-483a-5392-08df390cec3f
X-MS-Exchange-CrossTenant-AuthSource: IA3PR12MB923065.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 18:12:57.6503 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 08G066n4Se8V6Aol5AEGJxHvy55h/lk0+WbetUuHDnGnE7ewGr4IW0/K02pjLgHNMrOr4sljLEnXYrPUrbxmbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5993
Received-SPF: permerror client-ip=40.93.195.28; envelope-from=tdave@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This patch series introduces a mechanism to specify Guest Physical Addresses
(GPAs) for PCI BARs, allowing explicit placement of guest MMIO BAR addresses
to match host physical addresses for assigned devices.

On some platforms, P2P DMA between devices in the same IOMMU group is required
for the desired data path and performance. The PCI fabric ACS is configured
to permit direct P2P without routing traffic through the host bridge.

To support this multi-device IOMMU group P2P scenario in virtualization, the
VM may need to preserve the host PCI BAR addresses in the guest.

A new fixed-bar-N property on a PCI endpoint device specifies the required
guest address for BAR N (N = 0 through 5):

    -device some-device,fixed-bar-0=<addr>[,fixed-bar-1=<addr>]...

Once any fixed-bar-N property is set on a device, every memory BAR on that
device must have a fixed address. Under a PCIe root port, fixed BAR placement
is all-or-nothing within that root port's subtree. If one endpoint below the
root port has a fixed BAR, every other endpoint with a memory BAR below that
same root port must also have all of its memory BARs fixed.

QEMU validates the configuration when the machine is done initializing. Each
address must be aligned to its BAR size, fall within the appropriate PCIe MMIO
aperture, and not overlap any other fixed BAR. QEMU aborts on any validation
failure. QEMU performs neither PCI enumeration nor BAR allocation; the
validated configuration is exported to firmware through the "etc/fixed-bars"
fw_cfg blob, which carries each PCI function's vendor/device identification,
firmware device path, and, for fixed devices, the configured address, size,
and type of each BAR. The blob format is documented in
docs/specs/pci-fixed-bars.rst.

The fixed-bar-N property and its validation are generic and apply to any PCI
device. A machine type opts in by setting the new pci_fixed_bar_supported
MachineClass flag. Machine types that leave it unset reject fixed-bar-N. This
series enables it on the virt machine only, by setting the flag and wiring up
the fw_cfg export. Other machine types would need equivalent wiring to expose
the same mechanism to firmware.

On the firmware side, the existing IncompatiblePciDeviceSupportDxe driver is
extended to consume this blob. During device discovery, its CheckDevice()
implementation returns ACPI address descriptors with _MIF|_MAF set for the
fixed BARs found in the blob. PciBusDxe's resource allocator already supports
fixed BARs, including sizing and pinning the bridge windows above them. It now
treats a BAR as fixed when the descriptor carries _MIF|_MAF, and programs the
fixed address into the BAR register.

Fixed BAR placement requires the guest to preserve the PCI resource
configuration established by firmware. This is requested through the PCI boot
configuration preservation mechanism using ACPI _DSM function 5. Fixed BAR
configuration is rejected when firmware is not loaded or ACPI is disabled.

Example 1: VFIO passthrough device with fixed BARs and the PCIe MMIO
aperture adjusted to accommodate the fixed addresses.

    -machine virt,...,highmem-mmio-base=4T,highmem-mmio-size=4T
    -device pcie-root-port,id=pcie.port1,bus=pcie.1,chassis=1,io-reserve=0
    -device x3130-upstream,id=upstream1,bus=pcie.port1
    -device xio3130-downstream,id=downstream1_1,bus=upstream1,chassis=1,slot=2
    -device vfio-pci-nohotplug,host=0018:06:00.0,bus=downstream1_1,id=dev0,\
            fixed-bar-0=0x48000000000,fixed-bar-2=0x50000000000,fixed-bar-4=0x58000000000

Example 2: VFIO and emulated devices under the same root port with fixed BARs
and the PCIe MMIO aperture adjusted using highmem-mmio-base.

    -machine virt,...,highmem-mmio-base=64T,highmem-mmio-size=64T
    -device pxb-pcie,id=pcie.1,bus_nr=1,bus=pcie.0
    -device pcie-root-port,id=pcie.port1,bus=pcie.1,chassis=1,io-reserve=0
    -device x3130-upstream,id=upstream1,bus=pcie.port1
    -device xio3130-downstream,id=downstream1_1,bus=upstream1,chassis=1,slot=1
    -device vfio-pci-nohotplug,host=0018:06:00.0,bus=downstream1_1,rombar=0,id=dev0,iommufd=iommufd0,\
            fixed-bar-0=0x6b4000000000,fixed-bar-2=0x6b8000000000,fixed-bar-4=0x6c0000000000
    -device xio3130-downstream,id=downstream1_2,bus=upstream1,chassis=1,slot=2
    -device vfio-pci,host=0012:03:00.1,bus=downstream1_2,id=nic1,iommufd=iommufd0,fixed-bar-0=0x6c8000000000
    -device xio3130-downstream,id=downstream1_3,bus=upstream1,chassis=1,slot=3
    -device e1000,netdev=net0,bus=downstream1_3,id=nic_emu,fixed-bar-0=0x20000000

Limitations:

* I/O BARs and the expansion ROM BAR are not covered by fixed-bar-N.
* SR-IOV VF BARs are not covered.

Testing:

The series was tested on the AArch64 virt machine with a range of PCIe
configurations, including emulated and VFIO passthrough devices, PCIe
switches, single and multiple fixed-BAR endpoints behind a shared root port,
devices attached directly to the host bridge, and endpoints behind nested
bridges. All rejection paths were also exercised, with the corresponding
error messages verified. These included unsupported machine types,
hot-plugged devices, non-existent BARs, I/O BARs, unaligned, overlapping, or
out-of-aperture BARs, incomplete BAR configurations, highmem-mmio=off,
missing firmware, and highmem-mmio-base values that cause address-space
overflow.

Changes since v1:

* Add a pci_fixed_bar_supported MachineClass flag; fixed-bar-N is rejected
  on machine types that do not set it. virt sets it.
* Keep the fixed BAR claims in FixedBarsInfo instead of a static array, and
  report validation failures through Error ** to the machine code instead of
  calling exit(1).
* Allow a 64-bit non-prefetchable BAR in either aperture when the device is
  attached to the host bridge; behind a PCI bridge it must lie below 4 GiB.
  A 64-bit prefetchable BAR must still lie in the 64-bit aperture.
* Treat the high PCIe MMIO aperture as absent with highmem-mmio=off, and
  reject fixed BAR configuration unless firmware is loaded and ACPI is
  enabled.
* Check highmem-mmio-base + highmem-mmio-size against the PA space without
  overflow, and document highmem-mmio-base in docs/system/arm/virt.rst.
* Document the etc/fixed-bars format in docs/specs/pci-fixed-bars.rst, and
  note that the firmware device path is carried for future matching.
* Move pci-fixed-bar.h to include/hw/pci/.

v1:
https://lore.kernel.org/qemu-arm/20260916185554.917526-1-tdave@nvidia.com/

A git branch with this series applied is available at:
https://github.com/tdavenvidia/upstream-qemu/tree/Upstream-fixed-bar-Oct-29-V2

The related EDK2 change is available at:
https://github.com/tianocore/edk2/pull/13183

Tushar Dave (5):
  hw/pci: introduce PCI fixed BAR properties
  hw/pci: add validation for fixed BAR configuration
  hw/pci: add fixed BAR fw_cfg blob export
  hw/arm/virt: export fixed BAR metadata via fw_cfg
  hw/arm/virt: add highmem-mmio-base property

 docs/specs/index.rst            |   1 +
 docs/specs/pci-fixed-bars.rst   |  75 +++++++
 docs/system/arm/virt.rst        |   4 +
 hw/arm/virt.c                   |  82 ++++++-
 hw/pci/meson.build              |   2 +
 hw/pci/pci-fixed-bar-blob.c     | 308 +++++++++++++++++++++++++++
 hw/pci/pci-fixed-bar-validate.c | 365 ++++++++++++++++++++++++++++++++
 hw/pci/pci-fixed-bar-validate.h |  22 ++
 hw/pci/pci.c                    |  71 +++++++
 include/hw/core/boards.h        |   3 +
 include/hw/pci/pci-fixed-bar.h  |  63 ++++++
 include/hw/pci/pci_device.h     |   7 +
 12 files changed, 1002 insertions(+), 1 deletion(-)
 create mode 100644 docs/specs/pci-fixed-bars.rst
 create mode 100644 hw/pci/pci-fixed-bar-blob.c
 create mode 100644 hw/pci/pci-fixed-bar-validate.c
 create mode 100644 hw/pci/pci-fixed-bar-validate.h
 create mode 100644 include/hw/pci/pci-fixed-bar.h

-- 
2.34.1


