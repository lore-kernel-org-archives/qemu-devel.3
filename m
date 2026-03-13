Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4326E106FD7E
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 05:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0uwz-0005uj-HK; Fri, 13 Mar 2026 01:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1w0uwx-0005u2-BI
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 01:20:39 -0400
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1w0uwu-0005dy-5p
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 01:20:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jy0dk+upERwpRHaToKRAXzWPSbMdbRrBblJKy+YtLSmQgbWig3sffkGVYjxNubvCddbEjP12oaAOZ0WqvKWy92RYN47awa3G7aIvc4sAxvF/WdHSjF34gs+X05RLpnh2Go/8qGs8AubtGzwqdUK279ytRZOSOSJk1zIeW4NMUPrxN+/pq6eoYSxWd3u2DnaHv/O5l0bGd6utGzSXWUTyy9VEbDD414rtIFnvwpsNphSvrXYlBXtg/bfdojlzP8j4hklofGOjEEwW6glxlhqY1dIgm58OkZq6thpGCwRQasAoVe6e6tkJMic4chS+iNq9ziKDDiWOLRXWJ6htKLvaJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LiNc+BAHWugkBxlFeOoG/nBRNYCKtrC8ed+LtS6WP9M=;
 b=ocMXG5jos9sDvFvoOwmYlPckvXuBBvDZbRpJkE3af3tB6/BGpHuRMQWclwJTIjD2Ls2tq4RZ8oMZs1LwqYRQnH2U7SX7OEi7glQSVYydMuiAd0d/0p7EJ+tjPaeAWkncQee3yQxJdvrD83L4egZnzlw2rJS2O8TjgXHHJ7fbRmyojWOtkjdmNASYOpcAnwJGWttm3vsIvYY1BqLxpdD0wJSlGlq6QwW+CUbvaCvjGaq8BPk53qqNachzxv+TNxYfi9cIdNvyI+lIfcJrTIbwvjCR/Rg6zhvQySN2E/S/BnfrFLx38I1nCajPtZrnKL8Qfiwm0U75yVjuhzB46PUBLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LiNc+BAHWugkBxlFeOoG/nBRNYCKtrC8ed+LtS6WP9M=;
 b=LiVqdjO/cezML5cMj+3NaCeCn/lJakXmudEm1WQpVd6GEXJ/0RUl/ExVFF+Z3sxF6Rh/9yyM6mGcTJlsorU03iKsfWsVyymkfAi9+7swSoMuit6u45zvScQzJMoUiMme+kNKZjc4Ih9QjV1YbwNxizqCcpxzLPF3mIus4nPaqiY=
Received: from SJ0PR03CA0213.namprd03.prod.outlook.com (2603:10b6:a03:39f::8)
 by IA0PPFD78AA37BB.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::be6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Fri, 13 Mar
 2026 05:20:29 +0000
Received: from CO1PEPF000066EB.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::1b) by SJ0PR03CA0213.outlook.office365.com
 (2603:10b6:a03:39f::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.28 via Frontend Transport; Fri,
 13 Mar 2026 05:20:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066EB.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 13 Mar 2026 05:20:28 +0000
Received: from [10.143.201.178] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 13 Mar
 2026 00:20:25 -0500
Message-ID: <a5fb1eef-2602-4333-ad9a-cd82f90c4d71@amd.com>
Date: Fri, 13 Mar 2026 10:50:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <sarunkod@amd.com>, <pbonzini@redhat.com>, <richard.henderson@linaro.org>, 
 <eduardo@habkost.net>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <clement.mathieu--drif@eviden.com>
Subject: Re: [PATCH v3 3/3] amd_iommu: Generate XT interrupts when xt support
 is enabled
Content-Language: en-US
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, Vasant Hegde
 <vasant.hegde@amd.com>, <qemu-devel@nongnu.org>
References: <20260302115130.5903-1-sarunkod@amd.com>
 <20260302115130.5903-4-sarunkod@amd.com>
 <2c022a3c-f0e0-42be-a946-760a6e938de5@amd.com>
 <6bb7196c-3f0e-4164-ae3b-fd780c40c933@amd.com>
 <a04f4989-20b9-4bf0-b69d-350bd5982394@oracle.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <a04f4989-20b9-4bf0-b69d-350bd5982394@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EB:EE_|IA0PPFD78AA37BB:EE_
X-MS-Office365-Filtering-Correlation-Id: e2f4e0d3-e475-4ebf-af0b-08de80c03d46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|18002099003|22082099003|56012099003|7053199007;
X-Microsoft-Antispam-Message-Info: 7mR0EaZepn6WF+eXynduUW+GHG9tHYI891pcVpNfMJ7yfbsTxKiL0E+OexInOkL30nYIrjoyK2+Db9wvd9zXbBv55wV/8PFnizYNE8yOUpjjdBhRMy9COzqBVMWHihSTwrEoqdWKog4uy+SQ3mTuKJ2cX8Vs2WHnUgaQxldTyMxnxr1qqIvNvgdJB3AtwlO5GFGQXYkkuU99Dj2ICJbcEBh6AObpyDnnoiTKApGbG6t+9elTIqEXBQeIqvtecxSAAbGfAOO25Dp9HmpR7u7Z/NGoS7tjSdsqZdcEpAilPz7tj/6tn51xxkB5UaAReA6FRIFPCQHw8Ab7NkI2G2I0o/u86D0E39Wcl3/u0eSxOWtH0mUK7cYZOzf/PEKTHj10/seY4TAJp5u12g+D5KEf6PLbt17jYd+vecEPUPf8dTMHOlcmRAxzWWq2avq4IWJv0fQMi+QXP/j1Kg31Fze9bN8mWX/9QIZjEi39+PDPQPQly8jm2yGr1G/vAd0bmfgQDm1ohVCt7Rs8A+O+OKkW3fdLp9GkSUPLPqkY0qisnWkizEGTYrxmcLDgx2pxs1jIorFj8EDhF55bSg69nLchdaol/TltyZENQIMQfZYtxyjbQ1KZ7YAmtsAkaAKXn2uXell/MnHbZiYwMAtb2wgOOyYMaIUKmuakOPXifqflIURdalWTFxaIBbYjU37EO8+8IyCUYi1ykbCsEvW1XeVVTC9vzr2n//UAe9hOF/BQ9Sza493OEWHBl96eY3NsziJMy7c9G046XpplgNc4sQB6Rt2OFvqPRuySnVusUKXouq0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(22082099003)(56012099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: h0OQwZ+RuhbZMCJ7EWFTcEsJUzdsBY9nkjnnUAYamkwM9MW6eqEc+ZYtEMkZpZweFKeo/UG4xG6YCZLIRZ1hTPbDWyIu8VE/xMhHqUh7xejATTBjRmx81+xKDi0eH7fgd8SWk4azuyfvBGXTQ4PK+lgL4LduESXusurZ2PgoMzqWMFKGNORedF7VzcYZdY6kighKCbLnLQX4v4XEkBeZ0OnPVoyRgrimh8+e+6ocY+5tHzFfU1KdsP9A0db12yAXb25ydoiZDoH+FUwrVmIMG7lOs+sUL3MwG/UdDA+NALYbVCX6jXWWsBl0pMKIRE/CdIowfWGrIxVlyW14kG7nTpMpxbjCU/BdGdB2LF6j6x15VXTntMDaT1ANKU3E90JVk4Djz72s2w2jxQS1GH3bpVRVzXy0U6+64uKIWUA7dgAUeJM2W0urAh8Il4qI7Hmo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 05:20:28.2415 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2f4e0d3-e475-4ebf-af0b-08de80c03d46
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFD78AA37BB
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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



On 3/13/2026 5:46 AM, Alejandro Jimenez wrote:
>
> On 3/3/26 4:55 AM, Sairaj Kodilkar wrote:
>>
>> On 3/3/2026 3:17 PM, Vasant Hegde wrote:
>>> On 3/2/2026 5:21 PM, Sairaj Kodilkar wrote:
>>>> When MMIO 0x18[IntCapXTEn]=1, interrupts originating from the IOMMU
>>>> itself are
>>>> sent based on the programming in XT IOMMU Interrupt Control Registers in
>>>> MMIO
>>>> 0x170-0x180 instead of the programming in the IOMMU's MSI capability
>>>> registers.
>>>> The guest programs these registers with appropriate vector and destination
>>>> ID instead of writing to PCI MSI capability.
>>>>
>>>> Current AMD vIOMMU is capable of generating interrupts only through PCI
>>>> MSI capability and does not care about xt mode. Because of this AMD
>>>> vIOMMU cannot generate event log interrupts when the guest has enabled
>>>> xt mode.
>>>>
>>>> Introduce a new flag "intcapxten" which is set when guest writes control
>>>> register [IntCapXTEn] (bit 51) and use vector and destination field in
>>>> the XT MMIO register (0x170) to support XT mode.
>>>>
>>>> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
>>>> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
>>>> Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
>>>> ---
>>>>    hw/i386/amd_iommu.c  | 47 ++++++++++++++++++++++++++++++++++++++------
>>>>    hw/i386/amd_iommu.h  | 17 ++++++++++++++++
>>>>    hw/i386/trace-events |  1 +
>>>>    3 files changed, 59 insertions(+), 6 deletions(-)
>>>>
>>> .../...
>>>
>>>>          /* update the flags depending on the control register */
>>>>        if (s->cmdbuf_enabled) {
>>>> @@ -1732,6 +1762,9 @@ static void amdvi_mmio_write(void *opaque, hwaddr
>>>> addr, uint64_t val,
>>>>        case AMDVI_MMIO_STATUS:
>>>>            amdvi_mmio_reg_write(s, size, val, addr);
>>>>            break;
>>>> +    case AMDVI_MMIO_XT_GEN_INTR:
>>>> +        amdvi_mmio_reg_write(s, size, val, addr);
>>>> +        break;
>>>>        }
>>>>    }
>>>>    @@ -2382,6 +2415,7 @@ static void amdvi_init(AMDVIState *s)
>>>>        s->enabled = false;
>>>>        s->cmdbuf_enabled = false;
>>>>        s->xten = false;
>>>> +    s->intcapxten = false;
>>>>          /* reset MMIO */
>>>>        memset(s->mmior, 0, AMDVI_MMIO_SIZE);
>>>> @@ -2452,6 +2486,7 @@ static const VMStateDescription vmstate_xt = {
>>>>           .minimum_version_id = 1,
>>>>           .fields = (VMStateField[]) {
>>>>               VMSTATE_BOOL(xten, AMDVIState),
>>>> +           VMSTATE_BOOL(intcapxten, AMDVIState),
>>> Do we need to increase the version no?
>> No, because we have introduced a separate subsection, the older and newer
>> qemu are compatible.
>>
> I thought that was the case because the changes will still be part of the
> same "release". I don't believe we guarantee migration compatibility
> between random/intermediate commits, but...
>
> If we are going to follow the guidelines strictly then I think Vasant's
> observation is correct. The patch changes the layout of the subsection so
> we are in the same scenario that lead us to include a subsection to begin with.
>
> Because the two new values are still part of the same xt support domain, I
> think it makes sense to keep them in the same subsection and the simplest
> way is to do:
>
>   static const VMStateDescription vmstate_xt = {
>       .name = "amd-iommu-xt",
> -    .version_id = 1,
> +    .version_id = 2,
>       .minimum_version_id = 1,
>       .fields = (VMStateField[]) {
>           VMSTATE_BOOL(xten, AMDVIState),
> -        VMSTATE_BOOL(intcapxten, AMDVIState),
> +        VMSTATE_BOOL_V(intcapxten, AMDVIState, 2),
>           VMSTATE_END_OF_LIST()
>       }
>   };
>
> That change is on top of your current patch. There seems to be precedent
> for this based on my search in the git log. If you are ok with this
> approach let me know and I'll apply it, no need to send a new revision.

I am not sure if it is really useful here. Because without this patch
xt-support will not work and migrating from vm which only has first two
patches to the vm which has all three patches does not make sense to me.
I think we should treat three patches as a single unit, let me know what
do you think about this ?

Or we can do something like [1], which introduces new subsections
for each capbility.
https://lore.kernel.org/qemu-devel/20180119050005.29392-1-sjitindarsingh@gmail.com/

But this makes sense only when you can use each capability separately.

Thanks
Sairaj
>
> Thank you,
> Alejandro
>
>
>> Thanks
>> Sairaj


