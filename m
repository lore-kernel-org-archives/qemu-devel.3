Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5621606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 22:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=WvaRvAPA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVcGD-0005Vu-8f; Mon, 23 Nov 2026 17:11:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1xVcG5-0005VB-AF; Mon, 23 Nov 2026 17:11:35 -0500
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1xVcG3-0007D7-25; Mon, 23 Nov 2026 17:11:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oAVGn1PTxCdJf3ec+ekIH1em+p0aisemZQg1a+GzMt+7tpuGU9puqs36AIBh3Nuz2zxepsVmIikuGec+9UBafDmxucDT2l3vyup8IPaSAV9C8ocShYb1JHLUpCEQlvn0cPiC3ZwzqXFSQ6B8+QL3Me8Kcvz5JSh0mcVUS6rF3ASjh1s4qPiITGv7VbebiaQ6ZkX+B5b+Fqndc/8XoqEi6z9X0VIjOzHlGm/3cWQscwSo31cuFrBouLpzrEup/4QIUrc56ZrnSF4K1WJ72xQmirWZ5kykR3Jd5cSRD21uOTobIXAGhIr0kme0sd20fq76wjd+kBalq0Xa5lfTiSfa0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lMT4H47jXsWfUCw2aOtai1z9rRFXcGhWXQ43O5xgRwE=;
 b=O1D2M3/PXYapOp04WbabAB8tALMUL8dJ4G6Y/3JjxluGaDMEQuzWQrEEPkityGqCNlMGtMTljyXkrExxwTDzzaokRLsLgPRme7wF4b0BTHr32jM1Moj5r1KGvxA3/JivIE4YEfG2IP1n0VO/ZzjMBBvy/ZeiLQUp/uIwdVcUpBkiQ5uD+uYsVBgEYt+2j2JpLCOK3UPSr8Sx0xsiqj0hSFTbBwKHGwc+hqAZ6+QBOiFWapoxmojdd5CzBMPyTTx+xHMMH3dagyKUQvqFMYppJebTSv7/05oKA22hQU/aeZZ/ANgRG36S9FY9RKx9PEG6V8efPONXQBC20y1p7y/1Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lMT4H47jXsWfUCw2aOtai1z9rRFXcGhWXQ43O5xgRwE=;
 b=WvaRvAPA3ZWoTaeylaBdl1yE1Y0APlHeADyBs4stK+cvbQUYaYeh7osvqR08ngz2PnBu0bmXMMqLpH0QNfbv7cGsGjReV4NRCwe3oS1g6mPFF61p+KFnp98VPkA77si6iF3B1YVK2BQHLi1jSDNduyt2Q9tsHTvAc6/IEg3HMYrSVXQnWJoh+GsNKFuBaqYwOFA29i+N9qiFgca/qE2Ns8kjnRzaMP9W7kohmdQ8Hmv645vE++evPCM/4UBbq/Ebs4pFjARNHhXuwot6WZOkNt9y923QH//3Hq4hGC9X4Ks9dg4BCni0CzQHAHBnKfnSN1HtZyqQ4fuKnj4/V79keQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17) by CY5PR12MB6551.namprd12.prod.outlook.com
 (2603:10b6:930:41::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Mon, 23 Nov
 2026 22:11:22 +0000
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1]) by IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1%5]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 22:11:21 +0000
From: Tushar Dave <tdave@nvidia.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 marcel@redhat.com, devel@edk2.groups.io, alwilliamson@nvidia.com,
 jgg@nvidia.com, skolothumtho@nvidia.com, ardb@kernel.org,
 kraxel@redhat.com, clg@redhat.com, tdave@nvidia.com
Subject: [PATCH v3 0/5] hw/pci, hw/arm/virt: fixed PCI BAR placement
Date: Mon, 23 Nov 2026 16:11:00 -0600
Message-Id: <20261123221105.37029-1-tdave@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0151.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::6) To IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR12MB923065:EE_|CY5PR12MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: 5af18826-c06b-49f9-df4d-08df49aeb4e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|261026121527099003|261026140227099003|10067099003|11063799006|260925021911599003|261102123227099003|260925022911599003|261022105027099003|56012099006|260925021311599003|261028144727099003|261021123027099003|261022075727099003|261021121427099003|261021135927099003|5023799004|261009223027099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: Kz1jy4Mrq+3XkGBkemjc2NTQnLZPP1rfXMavRYhXsAbBRsFE+w2DIM0+7v1x5wMUwAktYF8URjXAjEuJmwYfXrgkzsTuYYi2XGlxA5QzPmaHUnuCqeMVCcWPR2R01u94j9eLuSbeMIXVj5RKZtQFAxh3NcWE1qkLn3JgAQz/BroQMspGTKv8KVnXZTwwLswS2vWgfXIqLwlitH2dfsV7eCif3cFYxlkTMZ/4Z5ZRb+fZrmsMNVM/n/P0HrcoFzC6dl9E99J5VLxHopIDmpl4wU1pQKVF/u/7iklqAuwh5MLfzfzBbWZz7njqLxFXITXz0ggSOFIykF5WaYe43vTkB0RSMYGe9tvEuddaK9VGM0yyCAHngg/Jkl4E7u8np9sUwxAAzVx5tum16T0NzutOguf/hY6HS7KVBYSR+wOpyqvyt75Xb4YjvNhD6PuRb1j9IrD2ZQ9im1Sh34MKEOBVxks1s92bQ6HghMB/uCO5vCj0Iatg4OKufQUSwE4k6Cpnwv6kc4mZ/PiIBx/OfO6IxigxrCfvCwOiDBLufPeyc60SRLoWSgCxbJogWG3ffwsnnoNpFL8HAgQudMlD/JXXklwUffEeWeeDpYsPp3zLs3rdBUlC2YDwpkOnDrlv3MKCRTKmAyP9aHm+FbuUFZ9htaN7H72JrWlWrKOlVHR2puU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR12MB923065.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(261026121527099003)(261026140227099003)(10067099003)(11063799006)(260925021911599003)(261102123227099003)(260925022911599003)(261022105027099003)(56012099006)(260925021311599003)(261028144727099003)(261021123027099003)(261022075727099003)(261021121427099003)(261021135927099003)(5023799004)(261009223027099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XmbEorJ27eAII61UtE+RjlFRVc957vqEiJwUHKl4yaY3xwvgT4uJ0r5FF2Ri?=
 =?us-ascii?Q?wg0/04xwssmgbVdpmmz7QLfS7YWvwDbSEQrpvACb0s1q1dSkE98hEuuoB0Vo?=
 =?us-ascii?Q?8TXCPZ989dlOhJvEoief/yRgdsLsCGl4J9mtJRzVZQ+zBHVzFaPchHV5CmF2?=
 =?us-ascii?Q?8rOkurt/n8LzZ7Lox5cqcjkXwnAPy57aF6JPnWc0vfJVm7f6wO4kT69RWViv?=
 =?us-ascii?Q?0Y8c/31/MjsrmNboDl3eDk+DY2CdtehUPvF2fQcIab3SW4pnJjKPH9YHkDcB?=
 =?us-ascii?Q?Vf6dnTiYVDz+3Y6KILLGDI9LOrCFsu5By+0O5FMyMMeA4qLvHW5ki0bJgIY0?=
 =?us-ascii?Q?+5gZcz1Y16bIjZKXZnKvigOYonh+TvKhdDJROXDQA7E5P/jBfXGPkB3A57/S?=
 =?us-ascii?Q?L5gYG57DOtiI8UdmrFog3eeYMie16cnE1PIxVPI9v4AaesmBTGSbjD12uLac?=
 =?us-ascii?Q?IioTlrxEs1KS6AgA/LT9aMaGGnzXftq0g+AtkY10KY80haLFwYV4aiH05pjz?=
 =?us-ascii?Q?vpo+ogKqLbz8BcrGRe63bYnIFLxBuHyG6u8xzJuGqFJIVHJq52KGfyiw4ayt?=
 =?us-ascii?Q?n4YBz7nsJ+1B8aDzxK9PjKr+n7l2mRfUcOQZipKNITs/ehtb7Pb3qVvO9VAK?=
 =?us-ascii?Q?w8tHfbirT86WzRlzA2i/EEBk//q7W6EF5fQ+OlSeb1J+gHvxgjXHnBvCK6tK?=
 =?us-ascii?Q?4XbRaMjJN9seVCamLH9/lHiEcLazeGfhDyNewqRXWJFpbzhBv5IkvrOIxQ5T?=
 =?us-ascii?Q?2eYWDGVELV/yp5CfV3ysO5Kq9LoOmkXqva/lHoZZ7O9CqMUy6g2h+aHZR6WR?=
 =?us-ascii?Q?T6yruWP9YsqQQGalq3l59JrQROlYIAZZ07s7BnlkYx7yc3oS12gisMGPWdXF?=
 =?us-ascii?Q?Ps/XlG+4h14Yblbbag9jzTNg1u2y8yrXO6m+UlGqm9zr7mWr+D6HnC4nwfae?=
 =?us-ascii?Q?DTAzP1DADH2yc1UBC/i7rJSEtq2ESqXYlUYgV+NdHA7pGycTF88t0MtKrpLi?=
 =?us-ascii?Q?355lvHSH/Becgt/iBCQGXYCgwfpOCfXiYlToIpxDA9I2TP0qywcnLjBR+FE6?=
 =?us-ascii?Q?ZUaiwSqIfMu4NidgtcaDcBTh9QzOIY/9v2VNF8jAQl2rOJd2+dFJ5aubzUyg?=
 =?us-ascii?Q?zz4ysutSg10UmkAoci5SPbaItKe1K2zr5sEPhaeERPbVDuV3c+UqXbi2IgKk?=
 =?us-ascii?Q?EE7RESM7kucSOYh0OVLXGmFh+BggwBrsFyEzeRsosMNeWHZiLU9NH2MKpeJG?=
 =?us-ascii?Q?gDjCwohztJKKv8Ve2/YKRE7mrgfAegVMjgwDQyI79tBjHEoj/tP7o+32/Dc8?=
 =?us-ascii?Q?fHMso1u9BWUUWVSJ9WsEKGXTnYC0RMfXvDyrsrn4Xyy52K0M/zcbvMlHk+9a?=
 =?us-ascii?Q?x1Hnpvoc3xMWkrd9m0JiIVR53lpFmgO1GBDy8uYRSjVw+VG2gEUg+iMLp4tz?=
 =?us-ascii?Q?CUjFEnbXZBC7j0tCSkr6GNSOH+6hpGXNQm29bZZbbnJFY5cTzpluvuNBvAYW?=
 =?us-ascii?Q?9fMlXDE9VWWf7dgFqes5JVVVZkN1xiED4KNDo0nXFMSzmxinr1x5huipWrLe?=
 =?us-ascii?Q?dsmZJrKwgBaD4HFMsRzqZmpfSgI4iwDlGPCLEAMIHl9xBQO4tf02dGH/9557?=
 =?us-ascii?Q?2Vu25SDDH1W5Tv5AWgEYWRRe6mDtSxP+nx8hcwatJU7+HSKCbF4w6Z8lldXa?=
 =?us-ascii?Q?XBPO6gTws9m1232CPiWCFzpP72lKIAEihP024eGlxF8wW1dt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af18826-c06b-49f9-df4d-08df49aeb4e3
X-MS-Exchange-CrossTenant-AuthSource: IA3PR12MB923065.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 22:11:21.8727 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1UiTRUMb4wS8r66GZOshMQL8RAF7iFUQtTJ0sffISjcgZlPCS1OxzucrBFhBAbZaQIxpWY7bBPEpp0dh133OxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6551
Received-SPF: pass client-ip=2a01:111:f403:c105::7;
 envelope-from=tdave@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
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
failure. QEMU performs neither PCI enumeration nor BAR allocation. The
validated addresses reach firmware and the guest through the standard PCI
Enhanced Allocation (EA) capability: a device with fixed-bar-N properties gets
an EA capability with one entry for each fixed BAR, holding its address and
size.

EA is a conventional capability, so it has to fit in the first 256 bytes of the
configuration space. A device that has no room, or that already has an EA
capability, is rejected with an error.

The fixed-bar-N property and its validation are generic and apply to any PCI
device. A machine type opts in by setting the new pci_fixed_bar_supported
MachineClass flag. Machine types that leave it unset reject fixed-bar-N. This
series enables it on the virt machine only, by setting the flag and calling the
validation once the devices are realized.

On the firmware side nothing new is needed. Firmware that supports EA reads
the addresses from the capability, and EDK2 has had that support since
PR 13186 (merged 2026-10-27, see link below). The Linux kernel reads EA for
endpoint devices and reports each BAR as "from Enhanced Allocation".

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

Changes since v2:

* Describe fixed BARs using an Enhanced Allocation (EA) capability in the
  device configuration space instead of the etc/fixed-bars fw_cfg blob. This
  replaces patch 3 and removes the blob, its format documentation, and the
  corresponding EDK2 change to IncompatiblePciDeviceSupportDxe, since EDK2
  already handles EA capabilities natively.
* Update patches 4 and 5 accordingly: patch 4 now performs validation instead
  of writing the fw_cfg blob, and patch 5 is adjusted to the updated
  object_class_property_add() API in current master.
* Patches 1 and 2 are unchanged.

A git branch with this series applied is available at:
https://github.com/tdavenvidia/upstream-qemu/tree/Upstream-fixed-bar-v3-EA-nov-20

EDK2 EA support, used by this series:
https://github.com/tianocore/edk2/pull/13186

v2:
https://lore.kernel.org/qemu-arm/20261102181241.3077981-1-tdave@nvidia.com/

v1:
https://lore.kernel.org/qemu-arm/20260916185554.917526-1-tdave@nvidia.com/

Tushar Dave (5):
  hw/pci: introduce PCI fixed BAR properties
  hw/pci: add validation for fixed BAR configuration
  hw/pci: describe fixed BARs with an Enhanced Allocation capability
  hw/arm/virt: validate fixed BARs and preserve the PCI configuration
  hw/arm/virt: add highmem-mmio-base property

 docs/system/arm/virt.rst        |   4 +
 hw/arm/virt.c                   |  82 ++++++-
 hw/pci/meson.build              |   1 +
 hw/pci/pci-fixed-bar-validate.c | 405 ++++++++++++++++++++++++++++++++
 hw/pci/pci-fixed-bar-validate.h |  22 ++
 hw/pci/pci.c                    | 219 ++++++++++++++++-
 hw/vfio/pci.c                   |  58 ++++-
 include/hw/core/boards.h        |   3 +
 include/hw/pci/pci-fixed-bar.h  |  28 +++
 include/hw/pci/pci.h            |   2 +
 include/hw/pci/pci_device.h     |   7 +
 11 files changed, 827 insertions(+), 4 deletions(-)
 create mode 100644 hw/pci/pci-fixed-bar-validate.c
 create mode 100644 hw/pci/pci-fixed-bar-validate.h
 create mode 100644 include/hw/pci/pci-fixed-bar.h

-- 
2.34.1


