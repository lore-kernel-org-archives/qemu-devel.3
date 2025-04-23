Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9708C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 10:46:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Xbe-0000dP-9p; Wed, 23 Apr 2025 06:45:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1u7Xbc-0000cK-I6
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 06:45:28 -0400
Received: from mail-bn8nam12on20631.outbound.protection.outlook.com
 ([2a01:111:f403:2418::631]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1u7XbZ-0006yF-DA
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 06:45:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CNLZH+0SV/mY0VGHhpp/sTBrQ1YcYyxqzMsVxxQl+GVpkG8g8HODS2pgHLsPgreZfrsfNqv85WJy/ZwcLD8va9kbr5HgD9xqDlfEb0hWv8RDyELhXgVfJS5F699TIPP1XAv78unFLOtrjx8T1H4K7PfbOCSCKjpvWjHc13l3qO5sX0Frd8bAY/6mLjTFri8pqs/mvVXmCOf/YFlynHa/73ekFodbWMdG8zG2klX/GL2GctEZc+W2HQSojcYi+W4sPaoT0pGkRMzqwg9D1I8JC7nlmMmebwa2MFixiCV/MmWh9Lug2hazY2CBnW6xSJfvTawXzFVzOkSon/4oL1Udng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTtBN0gt9bUPCEhNrvWOQ8RzxQFmtLk8JPR+T0flhpE=;
 b=ovhwHg8QIpkVa/tSOqvSnZ1oKn1y7plq80YuViZW7xYtgKNOJZUdbGhv8ZhkBU9Qz3dMkdMtJ86GFRxMWMelszJzFMR5fstpIckDM2yzs4JR7wskuPrTULf8NxiiLRJIW11pzMYdvvOWkJu97rwcQWzO6oRu3Im7fmANAfEX09hRz08kqqjDMSayM82a98aAP1mLotD+Af7kseLdn6coBKbXgNzemZU2iN5exINNYtdKgHshcSQevyWjWKNN5VJCrGGC6B7h4umb6paP2GCpSERbeKobeVjg9bDgUgX73NkZuh8TiV7DpEYJ3TWOry/fNLFn7FEvrBD8b4MnSm90cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTtBN0gt9bUPCEhNrvWOQ8RzxQFmtLk8JPR+T0flhpE=;
 b=SJUnOLpD4Z1LyR9MoHDs36MfwIpmhb63yi8fPgU+MUSJXI01os3/H4qsid7UJNMkIy2g90W/OTvh0nFJR9iUzgssf9nT2XinCsdUkpYqe4eYOFAmnlyyN4E53KLagW4SsU2OfGbqA3ouygtDCptZukKyz9g/XeOSvX0yHUqA3ZA=
Received: from MW4PR04CA0385.namprd04.prod.outlook.com (2603:10b6:303:81::30)
 by CY1PR12MB9626.namprd12.prod.outlook.com (2603:10b6:930:106::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Wed, 23 Apr
 2025 10:45:20 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:303:81:cafe::31) by MW4PR04CA0385.outlook.office365.com
 (2603:10b6:303:81::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Wed,
 23 Apr 2025 10:45:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Wed, 23 Apr 2025 10:45:19 +0000
Received: from [10.85.41.53] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Apr
 2025 05:45:13 -0500
Message-ID: <cf8587fa-f6e7-44c0-a33f-fa118e0d806d@amd.com>
Date: Wed, 23 Apr 2025 16:15:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/18] AMD vIOMMU: DMA remapping support for VFIO devices
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <richard.henderson@linaro.org>,
 <eduardo@habkost.net>, <peterx@redhat.com>, <david@redhat.com>,
 <philmd@linaro.org>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <alex.williamson@redhat.com>, <vasant.hegde@amd.com>,
 <suravee.suthikulpanit@amd.com>, <santosh.shukla@amd.com>,
 <Wei.Huang2@amd.com>, <joao.m.martins@oracle.com>,
 <boris.ostrovsky@oracle.com>
References: <20250414020253.443831-1-alejandro.j.jimenez@oracle.com>
Content-Language: en-US
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20250414020253.443831-1-alejandro.j.jimenez@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|CY1PR12MB9626:EE_
X-MS-Office365-Filtering-Correlation-Id: 930029ae-837d-416f-22d4-08dd8253f11d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|7416014|376014|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WUQvdmxxVlIzSVVqandXdFMwcWdCQkwzQ3hvZzFta1h0TlVveFQ1MjZhd0x2?=
 =?utf-8?B?dWtBem0rYXFYbXJLY1dkRlNtdUtjYnRTcGlURXNOT3JldEVidE1tY2JuVVNs?=
 =?utf-8?B?MEtsQjdObHFkQ3BrV1gvVEUzZ1NGbWhyU2x3WXFLK205NUNjbVZxY1dWaDdS?=
 =?utf-8?B?allGaytuZURqSWtNYWdzaWdzNyt1Y25NNW1RSjVIU0tMV05HK0huZFVUMTUy?=
 =?utf-8?B?MEx3Qld1MFZtZG5pTGRmU3JPN2dMVmdkamk4ZnBmc3ZvOVF1NG9tYkF3UWly?=
 =?utf-8?B?azFWWHRlUW9KN2Z3VDZKV25qa1BGNU54L3JSS3JSVEZsOU5xUWdtbTF4QWVh?=
 =?utf-8?B?RElkMkE2aTk2ZFNGOGlMZ1FJb2t0QjVNZWFESlZLMk1YMm5MbktEM0Q3N1Qz?=
 =?utf-8?B?c2RZeDBlOVNkeVcrQmJFUmlTZTFoZGhuRUZiLzhGSGR5dTE4bXJMVFk3VXB2?=
 =?utf-8?B?cWlIQkIvZzNBTEg4VmRYTkEzckdsZHQ2SEpycE5YNG9DMHpqOXdLNEtrRzYv?=
 =?utf-8?B?UVhRckJSNE5tamxIdjNudnJja2hzY3ZJcEJWRzc4RFZhWGdaVGNCL2tCQzNK?=
 =?utf-8?B?bTA5NlVZTnYrREROdS8ybExkZy8rdUJZdkpSU1RpWm40YXRtK0paTXRvbFox?=
 =?utf-8?B?cWs2bmNiV2VoNE1ad0NMaUx3UmFiTE9qaG1MYnZMaDBGL2YzRW01K1MvYkxB?=
 =?utf-8?B?a2s0eWRsWkxGbVB3TkNYbml1T2p1d3FnTkdnb1JOL0wvWGlkR00xRnhEc1d5?=
 =?utf-8?B?NkJlMGJPUU5TajVnbFlDSnBaS2JyZ0RubTBEZnVZVVJwenROSWJEaWxzaHFp?=
 =?utf-8?B?WVJ1Q3lQT050QlV4WnJEVjg3SEFlNHl5VElBT2ZrRUFENlNyd1M5WUZzOXNv?=
 =?utf-8?B?YkNGK3g2SlZJSGhHRWsxa1JCTkY3c0dZZTFrN3RFRHlna1hXc05vQXF4eVNJ?=
 =?utf-8?B?SGp3UEpxR1EwVEZzWGZnbGcyV2R6MFdCeUZVRFBjQVVGYXJoekJaN1FGejN3?=
 =?utf-8?B?VkFtMXJ1K25VR2ZYdm9pcjlFWGExb0lWWUt3U3NpLzZpdmFmOFBFc2ZSWHNR?=
 =?utf-8?B?ckdzK1owWmM1NkordVFnK2hTSzFWQndLZ2tSdjQxS2p5UERubWo5MzRwZXh6?=
 =?utf-8?B?MXN1NXpqNS80R3pad2FMOE1mbEFiRFU0MHZLVzVlY2ZJc2xOWW9iQzREN1Vm?=
 =?utf-8?B?UFc5WnJwcXgvaXpkQTJBRUJTYnM3QjQvdmE2RDlERzMvRENpNUdNdnpBM2c3?=
 =?utf-8?B?TnJjMzJvYkJDS3lOeElRTnFTeDVCVlVMNWFIQjdSeDhaN0pVbmZkN1ZQK0lI?=
 =?utf-8?B?OWxiQ0pDUUt4SjRtOTBUS1hiVkJoWnF0L2dRSHdaalFRR0liTXdlRUpxNWRG?=
 =?utf-8?B?eEw1L2RWcmplSFpqWHJLbVB1VEY0c21hbzFUU3oxYm9HQ0REdWZHalpWVXds?=
 =?utf-8?B?bUo1dlV3bENuakpoZ2VZaHdKbGs5TzRIQ1lKc1Y0Qmd0WFVXaVZhdlBqc1RP?=
 =?utf-8?B?TG84eG4vd2llMVBOandibk5sdWtGUmpIcElKUUJWNGFtWTNOTHdGSTlUVGpH?=
 =?utf-8?B?YkVOVTBMM1B2N2I2MGZ2ZFE0cFQra1hhRFpDdjNNVHNheFBEeFdUdmlEeWpa?=
 =?utf-8?B?Uk1DZlhnSi9tQmhKOFJmanhGS3UycGFXcGtKVXFteDB4TlBab1VyWklUT2Nj?=
 =?utf-8?B?NHNKRVk3SjU5eWtKYmxmNE9YQzN5andVcDJNQU5UY212VTBrek1Ka1FtQ0hI?=
 =?utf-8?B?bXlCZkYrQ0hDcG9lRWN0azhJdG5ETm0xS2xGN09zTWpIcEliemgyeFZkVjlz?=
 =?utf-8?B?eXI3Q3NFT1Q1dCtZR0hzY1lseng3a1hHYjBxRXFWZGRpUnJEaUlJNld1bVdP?=
 =?utf-8?B?amtXVkhMMWZTMmZ5cWo3YUdzR0xmUEtWZWlwa1pENXBoQ3pBOGxGNFduWU9U?=
 =?utf-8?B?WnVwelZtWDh4ZUt5N3M1bFBGUDJ6WkRPNGs2S2V4TDFXVDFLOW4wbnBUejd1?=
 =?utf-8?B?RUNuTks2c2lwTE12WGV3d3k4M0g1clZmcmQ2U1NsdTJKYUxId2MxeldPY0hU?=
 =?utf-8?Q?67g9yJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 10:45:19.4187 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 930029ae-837d-416f-22d4-08dd8253f11d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9626
Received-SPF: permerror client-ip=2a01:111:f403:2418::631;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
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



On 4/14/2025 7:32 AM, Alejandro Jimenez wrote:
> This series adds support for guests using the AMD vIOMMU to enable DMA
> remapping for VFIO devices. In addition to the currently supported
> passthrough (PT) mode, guest kernels are now able to to provide DMA
> address translation and access permission checking to VFs attached to
> paging domains, using the AMD v1 I/O page table format.
> 
> These changes provide the essential emulation required to boot and
> support regular operation for a Linux guest enabling DMA remapping e.g.
> via kernel parameters "iommu=nopt" or "iommu.passthrough=0".
> 
> A new amd-iommu device property "dma-remap" (default: off) is introduced
> to control whether the feature is available. See below for a full
> example of QEMU cmdline parameters used in testing.
> 
> The patchset has been tested on an AMD EPYC Genoa host, with Linux 6.14
> host and guest kernels, launching guests with up to 256 vCPUs, 512G
> memory, and 16 CX6 VFs. Testing with IOMMU x2apic support enabled (i.e.
> xtsup=on) requires fix:
> https://lore.kernel.org/all/20250410064447.29583-3-sarunkod@amd.com/
> 
> Although there is more work to do, I am sending this series as a patch
> and not an RFC since it provides a working implementation of the
> feature. With this basic infrastructure in place it becomes easier to
> add/verify enhancements and new functionality. Here are some items I am
> working to address in follow up patches:
> 
> - Page Fault and error reporting
> - Add QEMU tracing and tests
> - Provide control over VA Size advertised to guests
> - Support hotplug/unplug of devices and other advanced features
>    (suggestions welcomed)
> 
> Thank you,
> Alejandro
> 
> ---
> Example QEMU command line:
> 
> $QEMU \
> -nodefaults \
> -snapshot \
> -no-user-config \
> -display none \
> -serial mon:stdio -nographic \
> -machine q35,accel=kvm,kernel_irqchip=split \
> -cpu host,+topoext,+x2apic,-svm,-vmx,-kvm-msi-ext-dest-id \
> -smp 32 \
> -m 128G \
> -kernel $KERNEL \
> -initrd $INITRD \
> -append "console=tty0 console=ttyS0 root=/dev/mapper/ol-root ro rd.lvm.lv=ol/root rd.lvm.lv=ol/swap iommu.passthrough=0" \
> -device amd-iommu,intremap=on,xtsup=on,dma-remap=on \
> -blockdev node-name=drive0,driver=qcow2,file.driver=file,file.filename=./OracleLinux-uefi-x86_64.qcow2 \
> -device virtio-blk-pci,drive=drive0,id=virtio-disk0 \
> -drive if=pflash,format=raw,unit=0,file=/usr/share/edk2/ovmf/OVMF_CODE.fd,readonly=on \
> -drive if=pflash,format=raw,unit=1,file=./OVMF_VARS.fd \
> -device vfio-pci,host=0000:a1:00.1,id=net0
> ---
> 
> Alejandro Jimenez (18):
>    memory: Adjust event ranges to fit within notifier boundaries
>    amd_iommu: Add helper function to extract the DTE
>    amd_iommu: Add support for IOMMU notifier
>    amd_iommu: Unmap all address spaces under the AMD IOMMU on reset
>    amd_iommu: Toggle memory regions based on address translation mode
>    amd_iommu: Set all address spaces to default translation mode on reset
>    amd_iommu: Return an error when unable to read PTE from guest memory
>    amd_iommu: Helper to decode size of page invalidation command
>    amd_iommu: Add helpers to walk AMD v1 Page Table format
>    amd_iommu: Add a page walker to sync shadow page tables on
>      invalidation
>    amd_iommu: Sync shadow page tables on page invalidation
>    amd_iommu: Add replay callback
>    amd_iommu: Invalidate address translations on INVALIDATE_IOMMU_ALL
>    amd_iommu: Toggle address translation on device table entry
>      invalidation
>    amd_iommu: Use iova_tree records to determine large page size on UNMAP
>    amd_iommu: Do not assume passthrough translation when DTE[TV]=0
>    amd_iommu: Refactor amdvi_page_walk() to use common code for page walk
>    amd_iommu: Do not emit I/O page fault events during replay()
> 
>   hw/i386/amd_iommu.c | 856 ++++++++++++++++++++++++++++++++++++++++----
>   hw/i386/amd_iommu.h |  52 +++
>   system/memory.c     |  10 +-
>   3 files changed, 843 insertions(+), 75 deletions(-)
> 
> 
> base-commit: 56c6e249b6988c1b6edc2dd34ebb0f1e570a1365

Hi Alejandro,
I tested the patches with FIO and VFIO (using guest's /dev/vfio/vfio)
tests inside the guest. Everything looks good to me.

I also compared the fio performance with following parameters on a
passthrough nvme inside the guest with 16 vcpus.

[FIO PARAMETERS]
NVMEs     = 1
JOBS/NVME = 16
MODE      = RANDREAD
IOENGINE  = LIBAIO
IODEPTH   = 32
BLOCKSIZE = 4K
SIZE      = 100%

        RESULTS
=====================
Guest
IOMMU          IOPS
mode          (kilo)
=====================
nopt           13.7
pt           1191.0
--------------------

I see that nopt (emulate IOMMU) has a huge performance.
I wonder if the DMA remapping is really useful with such performance
penalty.

Regards
Sairaj Kodilkar


