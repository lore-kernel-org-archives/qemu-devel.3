Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F60CD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 07:58:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNnRG-0005Lv-Mn; Fri, 15 May 2026 03:58:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wNnRB-0005Lj-Ma
 for qemu-devel@nongnu.org; Fri, 15 May 2026 03:58:26 -0400
Received: from mail-eastusazon11011067.outbound.protection.outlook.com
 ([52.101.52.67] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wNnR8-0008D4-WC
 for qemu-devel@nongnu.org; Fri, 15 May 2026 03:58:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=loRE3+ng/1Ug+Z3cL1RkU3OeFT4yPeBpVJg4/54FaKB7gX7td0ZnhAlRQjyi/IdSjoBqz1DNmRkh06ERpD2WoTnxjrMqa4js0tEpsaORokucf3rWGWascSoyKdksw/4HCUihjiygrhpMm1N2e7ttbsQ+5bz0Qj/mqWRjvO6ZADzGv4DQ0jCuHSSbUk6uLTeyNUrYY6VUiPhEYq1n6GfIceDvaffo2oQ8s1q6H3BlQODVYgaL/wbdGyxT9HlnQnUzmWNix3wyNa/Z5XVlHkN9UcreXczPfVEfMUp4MvGakX/2+FvhiIO97MbA3QcsqhO0qfl1mfDwY3O3Te1/nwmK7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tyCnVT03mgxlCoEQ6DUm+g6FYBhyynL5tXzFP4YmR6E=;
 b=Cd5fPwOVr6w9pfF4Lfp+szaDCu1zWweGYRsuBuyisuXWnP5R3jyN8z1y4KuVnAKyPDkMGZpnnk6cAMeilIqrcEnz86UuI8GuBhVBVmTZH9RwC5QPQ9q1m45RnzrfoTwnEL42OuMcNKPdajIoPID+X+8dKXRzWRkPunNT8bOy2pTtwxiNvWFVoPTbNOGkY6SA0B86RN+dWPl6xuruY1aLbaEQtgAVSxbLoqG0yRsZO1MhEhCD8SXpx0NiaiZCBfriPWBcNRzGKsA6iphS5RzvLFq+to1zaY+/MqaNlqu+9IscwDVp0dzF3TjBDePN9MS3AQWwQ4Kws7IJYIRvMk165A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tyCnVT03mgxlCoEQ6DUm+g6FYBhyynL5tXzFP4YmR6E=;
 b=Anzg11ti3x2e9M8IbG1+JDddU2M+NAxANQxPJg89Q0eI9fTpeTELaB14P3FlaW+p9lpkH2X3uj/+HEQo2Uqp8xS33ypDQSVI7xyv1W8oQGnr0uC9pFTIghGxaabGfopb2enbBPeT333/IZdrFBZ1jA83DvxBBlyxW1RIpi7sC+w=
Received: from BYAPR21CA0012.namprd21.prod.outlook.com (2603:10b6:a03:114::22)
 by BY5PR12MB4273.namprd12.prod.outlook.com (2603:10b6:a03:212::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Fri, 15 May
 2026 07:53:12 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::9) by BYAPR21CA0012.outlook.office365.com
 (2603:10b6:a03:114::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.10 via Frontend Transport; Fri, 15
 May 2026 07:53:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Fri, 15 May 2026 07:53:12 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Fri, 15 May
 2026 02:53:10 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 15 May
 2026 02:53:10 -0500
Received: from [10.65.99.36] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 15 May 2026 02:53:07 -0500
Message-ID: <d26cfb4b-d70e-415c-8747-904d94f8ccb2@amd.com>
Date: Fri, 15 May 2026 15:53:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/1] numa: add 'memmap-type' option for memory type
 configuration
To: Igor Mammedov <imammedo@redhat.com>
CC: <qemu-devel@nongnu.org>, <david@redhat.com>, <gourry@gourry.net>,
 <jonathan.cameron@huawei.com>, <apopple@nvidia.com>,
 <dan.j.williams@intel.com>, <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>,
 David Hildenbrand <david@kernel.org>
References: <20260306082735.1106690-1-FangSheng.Huang@amd.com>
 <20260306082735.1106690-2-FangSheng.Huang@amd.com>
 <20260514150559.3148f9dc@imammedo>
From: "Huang, FangSheng (Jerry)" <FangSheng.Huang@amd.com>
In-Reply-To: <20260514150559.3148f9dc@imammedo>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB04.amd.com: FangSheng.Huang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|BY5PR12MB4273:EE_
X-MS-Office365-Filtering-Correlation-Id: d6c40f5a-521b-4705-ad46-08deb25703cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|13003099007|4143699003|11063799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 63BUjk/xOUQ+ply1AzdauGHzswKb6fqveH/0poPNwz8oxZrLSGXAlp+MsdLor6LBJ42Uz9KxsDnqqHxQtagMGbeF7wx/ZEpLF1q9Til07NpPSBGPMa49T0UOQ0mF4aVVwDIKiawGo4107zyjnm6VclgnBQKZdEHGYc4NFCBh2VaSMbtCoIZNLIbu6dIwpXP6jfBRw9kKgSBBQ/HYIBQLkUvDIN7DsR/vZ1rNnS2G4ypU6AIjZ2rmXkJZFjudjlCXXcXc/YJoAh8sSlb+ITh+Z7M7F77eSpaFVsbMrfI2unZs9KJIxmpJF7jonrSxGrv0cblhufeTfPzcQ+ToEKQGY4d+m4Pg5eep140htDZbPlStV3P73KxEvtJi14Wpr2S4AfBV+TDNCSZ+y/K92eG1nhKkHl6DFzP47bPPdnTe/bJqkQxRFJu4GP1mElwNnuo5BVK3hQeL2LMFtdvwc3egIA6yt5fIbeMrod27fepY9tCfaix9hF1TJ3JZXEfa1H3YAHKJBUHCWlX7O+yYEjhDyuvdrTBb3wjB1TtHll3m9/P2gW9ZKru9T+QOXswTMUcAjTIyswQ02Cnu/itT7bWFyea5AWd8VPdGr9SQwmudU3dk99mANGRmlHSmRgc2AzveEPDj8jvXQjFgGiRg7VjZxa42R5UwrvDk3ACR/6Bgj5+32lptqjObmQJgZUGezwiVAOcjbwR+QUBx+Cyesr+wnYq2HpEH4XD3DgMFomaF0/4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(13003099007)(4143699003)(11063799003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HGGlvBxLcQjJdkJNDQ6MmTPljUzIeIkYAxBZ4vod0F5qFH/LM6lGbc2yWUh5ZcYMwrBijeDh98ClHxMTgjIeQCfW5+XG7fLH54Hvp6nSV4bfx6J/mootjxEF6aDMhbj4y/C0hzscZF4tnBYAB24+SeknE8eLS7rZHTyeSiwxiOLgPB93OgGdB4SohE7yIb9XgdalW1xhDzHBvFmJT/XtqHAeKPcoxfkRk8fsas0oTZNP+g74PKS/Pl2bDKFfeOP8bKhNnF0I3mpLCoSqh8U7VwmoWIG2uHFYiXP+G1/WMCcTPrsdzSJASYNFp50HX3qSWQZFK6pftUn8bc3tOjA40HpgBGk6x3r8SkXa3tZvI8sK3GjyDdLbW8XmakIB6Ly4/V66SrffD/zGrtrGAZN9AojVuojlKBl64sGCRvX3/ImVhMD8gIGXL3H7lPt21/4w
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 07:53:12.7704 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6c40f5a-521b-4705-ad46-08deb25703cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4273
Received-SPF: permerror client-ip=52.101.52.67;
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



On 5/14/2026 9:05 PM, Igor Mammedov wrote:
> [You don't often get email from imammedo@redhat.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> On Fri, 6 Mar 2026 16:27:35 +0800
> fanhuang <FangSheng.Huang@amd.com> wrote:
> 
>> Add a 'memmap-type' option to NUMA node configuration that allows
>> specifying the memory type for a NUMA node.
>>
>> Supported values:
>>    - normal:   Regular system RAM (E820 type 1, default)
>>    - spm:      Specific Purpose Memory (E820 type 0xEFFFFFFF)
>>    - reserved: Reserved memory (E820 type 2)
>>
>> The 'spm' type indicates Specific Purpose Memory - a hint to the guest
>> that this memory might be managed by device drivers based on guest policy.
>> The 'reserved' type marks memory as not usable as RAM.
>>
>> Note: This option is only supported on x86 platforms.
>>
>> Usage:
>>    -numa node,nodeid=1,memdev=m1,memmap-type=spm
> 
> in short:
>    don't do it this way
>    I'm against merging it as is, till you convince me otherwise.
> 
> more detailed answer:
> 
> * mandatory bashing chapter:
> 
> the more i look at it, the hackier this approach looks to me,
> and what even worse that nonsense propagates to firmware.
> 
> Judging by commit message, the goal is to expose some RAM as
> E820 SPM, to guest (that's it).
> 
> You however picked -numa node as a way to achieve that,
> and then hack the numa code not to generate numa data for it (SRAT)
> and massage e820 to exclude SPM from  RAM entries.
> 
> But at this stage I don't really see a good justification for hack(s)
> this patch introduces (it's definitely is not in commit message not cover letter).
> 
> And until alternative approach is not explored and proved to be worse,
> I'm against merging this patch.
> 
> * suggestion chapter:
> 
> I don't recall but I likely asked before
> why not use device memory instead for it (aka DIMM device or some device derived
> from device memory object and then add e820 entry for it).
> 
> It would be a way more simpler approach and impl. without need to resplit
> anything in e820.
> And no need for messing with firmware (SeaBIOS: RamSizeOver4G patch) nor EDK2.
> 
>

Hi Igor,

Thanks for taking the time to review this -- and for the candor in
the bashing chapter.  Before going into the bigger picture, let me
re-establish one factual point that v7 didn't carry forward from
the v6 cover letter.

On SRAT generation:

v7 only suppresses SRAT for memmap-type=reserved.  memmap-type=spm
nodes get a normal SRAT Memory Affinity entry.  This was shown
explicitly in the v6 cover letter, which v7 didn't carry forward
since v7 is a single-patch series.  For the spm case:

     [    0.042582] ACPI: SRAT: Node 1 PXM 1 [mem 0x280000000-0x47fffffff]

Full transcript with all three memmap-type variants side by side:
https://lore.kernel.org/qemu-devel/20260226105023.256568-1-FangSheng.Huang@amd.com/

The bigger picture -- real-world context that drove the design:

The use case is GPU/accelerator HBM exposed to the OS as SPM.  On
bare metal, the platform firmware:

   - emits E820 type 0xEFFFFFFF (SOFT_RESERVED) for the HBM region;
   - emits ACPI SRAT memory affinity entries that bind HBM to a
     dedicated proximity domain (NUMA node);
   - tags the accelerator's PCI device with _PXM matching that node.

That gives the device driver a stable lookup chain at runtime:

     dev -> pci_dev_to_node(dev) -> SRAT walk -> HBM GPA range

NUMA node here is not incidental -- it is the OS-exposed
intermediary ID that the device driver uses to find its own HBM.
This is the in-tree path used by accelerator drivers today.

The "-numa node + memmap-type=spm + E820 SOFT_RESERVED" combo in
v7 is a direct 1:1 model of this BM topology.  The E820 retyping
in the patch is exactly what makes the guest-visible E820 match
what BM firmware emits for the same kind of region.

On the DIMM / device-memory alternative:

David pointed this out in the v6 thread, and Gregory's reply in
this thread reinforces the same point -- DIMM / NVDIMM ranges are
described in E820 only as the hotplug area.  SPM needs to be in
the boot E820 from the start so the OS classifies it as SP and
treats it accordingly.  Going via DIMM would also detach the
memory from the NUMA topology (no SRAT entry tied to the device's
_PXM), which breaks the dev -> node -> SRAT -> HBM lookup the
driver relies on.

Happy to dig into any of this further, or to reshape parts you
still see as too hacky.

Best regards,
FangSheng Huang (Jerry)
> 


