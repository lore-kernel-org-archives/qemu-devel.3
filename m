Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B0CC43602
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 08:33:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfZKU-0002fC-NC; Fri, 03 Jul 2026 04:32:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1wfZKN-0002eH-GT
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 04:32:52 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1wfZKL-0001qP-Hy
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 04:32:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sqgewsIbQ3fO3Zy9Zd65EtOsLg0ClKdqbCnDPGx4ftrtDdfk5vZBr9wZV0M/3RKDXDEKQzJhRcrlm6HVtOffCFlZBSN0LnSRjf8kKACQQvBx2qFGm8svDGqWFTUgjbHOFdUI5PRsY6RJU9ogFxbkaWYxt5G4CbWc5IC3bMe3uVbYnOb1OimncwCkO+eT3m945jzSYdMt7dmwr+iZ4x1cfZ0fw/1xYiYHO6wa+3KPweEZcMWZtoQl90qA4RJ2sfumh9w/DahKprQ2QWOVWyPCT9y7VpatkbY+T+HxhjFobl5pH9sdJtRaUJO7zBEUzcOApPla/airvekXWYMsbGxybw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8HExA54w/nrt5YSz7e4dCiwLcBGXJvZaIdV46T01NN4=;
 b=j9Y4rKRm/fFmMHVKxkafVN9VMyhuYyK1iL97u8NGv+wu5sPAdFEYTHFDFyyvGykDivOcKoffzhvbgCI7FuV2VBq29TvkMQVgOZwkvEs3K6INngDVltTh8wPWAH2WeHOSZ0Hb7Sc6+w3wtWhEp9c+/Z4ou/Tqgppx+cmJxHMyEkXxcVZOtTldiA9H56aPsXyLpXFbOpyf0jWWfTe36GOnK/CHza1b/+upMglWOXIeaDJHQb5H2x4Rkj298OZf5GAdzdAHIp9yy60WrkPqUx/rD0Rax0YySA/iMWCrOQNyO2Q9A9OhuWfKWQD9NzXYqPKwvvkpm1kj+O/sIvkbDSYm7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HExA54w/nrt5YSz7e4dCiwLcBGXJvZaIdV46T01NN4=;
 b=bokv7qoJ3VQ3Ft0g9GMsmQituoQAvoIP69QlgGA7zR1eFz7RmWU/VVtPisDIcaM5/+yfwWFnlYyBgcMRKh24xhfz+h7hjYF2XQp0CPVhKf8DE30U6qO6m8YTw6sHCTH0H/udQYLQ7eLfRaL38tVJ1GxeNIdmv/YILBNmRFUolsw=
Received: from MN0P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::14)
 by BY5PR12MB4164.namprd12.prod.outlook.com (2603:10b6:a03:207::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 08:32:45 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:208:52e:cafe::35) by MN0P220CA0019.outlook.office365.com
 (2603:10b6:208:52e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.11 via Frontend Transport; Fri, 3
 Jul 2026 08:32:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 3 Jul 2026 08:32:44 +0000
Received: from [172.31.37.251] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 3 Jul
 2026 03:32:37 -0500
Message-ID: <d926cf31-0ae0-49ca-bf10-a194634fd93a@amd.com>
Date: Fri, 3 Jul 2026 14:02:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <sarunkod@amd.com>, <alejandro.j.jimenez@oracle.com>,
 <pbonzini@redhat.com>, <richard.henderson@linaro.org>, <mst@redhat.com>
Subject: Re: [PATCH 2/4] amd_iommu: Use full BDF when reporting page faults
Content-Language: en-US
To: Dongli Zhang <dongli.zhang@oracle.com>, <qemu-devel@nongnu.org>
References: <20260609204403.323149-1-dongli.zhang@oracle.com>
 <20260609204403.323149-3-dongli.zhang@oracle.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20260609204403.323149-3-dongli.zhang@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|BY5PR12MB4164:EE_
X-MS-Office365-Filtering-Correlation-Id: 07f1291d-ad31-47e3-0276-08ded8dda796
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|23010399003|1800799024|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: dfgVrLb89rYv7LTGT0gU6KLKj/b9dk3sFLUlX/aKl12vhA6gZzntoo1wsvq6QVgkisxVp6TIw+oCmVd4dyf+zBHszBrfxymhLv11JNo2IeQeKIXr/kmz5ce1zNrSnnnft6x18NC/038MQfxsOispPjVU7q2wlXhzSqKjqOnLS5onepjsyO+kdLwYGhzD0mjGbi9Ebk8rwTupjhWrzdn5VdA1m1BrykPYsJXcJk8lpMcdfG4niokmYPO9duWNnBKH8/OD+KHzOywgyKNsP+vtrgJfvWgHJR5uDxbekkLa8LWA9dQ8fhE7LOzIClYtiF5oAZ0Ng0JsFY8isbjHIt6xAE5xlPgGBrM63nXD40DuX8p8TjdNOS2reg60kF0ANkd+Gm2XEQHehgh4ltVOHhO/mTIGEhESTPpKWqyFbIwCO7BrOIdZWLVzMB6X+tRb1E91nyNhzgufkzpb9H706FUDc2RMkx7Uf4yZy8TxgD/vOfT/tDUwRZzL6ptatlkSCXEWT+RYb6htjvsMx95WHZYwTFUnOlMRumCruVxv3819eww1RxOXGFzgA0oPQZsbhPViyPq6b6z2eHpACBHB0eKzm+wnVb/7XDOMHM6GH/9hRFDV3JCT1E4cb5XCl8AtLTxroaBh8rCb9DPnPWixOHSTdayqrZcqaIiZiDNM2YVabe4b+UkNfkQ/lTZqR//Se14Ke4T/A37V9jdgntlMfqRUMw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(23010399003)(1800799024)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PHe4JvhRt0FHxbyc+chTn8euE9XBxEVnB0jCyfLWhXlMXRxvFK9VnYF4TBuXbK+OMXGmnkDR4+Z+303iOceByN3Dv/bAFREltdZ7UwVNHIIpccuQv9xcQA0iuoPDWYSoG/cQwoiKZLo+tQciwFEYo0eFtIVBCD37tHr3xVHZPUE2jSdeuIm69pe6lkDUi/S5fRtvsA8fTPqqPQCwAuaYJWEbJ/W4+ze4HePUPeqxpmKlcM25Sdc6cxqkt5jQP13yfdTFxgwYdfGJK8P8fWizEexf2GjAClEkIqmHFXQa9PyY/8C3mUxzsikDPB6hGoHmJjDsU60Q7KTAUGMl9/u7DlkhLyPNEe7H1OksqWMmbWqiJqiRv/8mw/xmfVJZWmLlF59bqd7CkSSWfvzK3CB8IkO7uSyGr1fmf/UVVLbycVsFZBoGyCBFpqQF1V0FdqHs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 08:32:44.3750 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f1291d-ad31-47e3-0276-08ded8dda796
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4164
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=Sairaj.K@amd.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 6/10/2026 2:13 AM, Dongli Zhang wrote:
> AMDVIAddressSpace->devfn only contains the PCI device/function number.
> AMD-Vi event log entries require the full DeviceID, including the PCI
> bus number.
>
> When reporting IO page faults for devices behind a pcie-root-port, QEMU
> logs the fault against the wrong requester. For example, a fault from
> 01:00.0 is reported as 00:00.0 because only devfn is passed to
> amdvi_page_fault().
>
> [root@vm ~]# lspci
> ... ...
> 01:00.0 Ethernet controller: Red Hat, Inc. Virtio 1.0 network device (rev 01)
>
> [   58.154050] pci 0000:00:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0xc0000000 flags=0x000a]
> [   58.156968] pci 0000:00:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0xc0000000 flags=0x000a]
>
> Use the full BDF consistently for AMD-Vi address spaces and pass it to
> page fault and page-table access error reporting.
>
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>   hw/i386/amd_iommu.c | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 997d02eab5..ca9d79bb51 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -87,6 +87,11 @@ typedef struct AMDVIIOTLBEntry {
>       uint64_t page_mask;         /* physical page size  */
>   } AMDVIIOTLBEntry;
>   
> +static uint16_t amdvi_as_devid(AMDVIAddressSpace *as)
> +{
> +    return PCI_BUILD_BDF(pci_bus_num(as->bus), as->devfn);
> +}
> +

A better function name can be 'amdvi_get_as_devid'

>   /*
>    * These 'fault' reasons have an overloaded meaning since they are not only
>    * intended for describing reasons that generate an IO_PAGE_FAULT as per the AMD
> @@ -613,7 +618,7 @@ static inline uint64_t amdvi_get_pte_entry(AMDVIState *s, uint64_t pte_addr,
>   
>   static int amdvi_as_to_dte(AMDVIAddressSpace *as, uint64_t *dte)
>   {
> -    uint16_t devid = PCI_BUILD_BDF(pci_bus_num(as->bus), as->devfn);
> +    uint16_t devid = amdvi_as_devid(as);
>       AMDVIState *s = as->iommu_state;
>   
>       if (!amdvi_get_dte(s, devid, dte)) {
> @@ -664,6 +669,7 @@ static uint64_t fetch_pte(AMDVIAddressSpace *as, hwaddr address, uint64_t dte,
>   {
>       IOMMUAccessFlags perms = amdvi_get_perms(dte);
>   
> +    uint16_t devid = amdvi_as_devid(as);
>       uint8_t level, mode;
>       uint64_t pte_addr;
>   
> @@ -719,7 +725,7 @@ static uint64_t fetch_pte(AMDVIAddressSpace *as, hwaddr address, uint64_t dte,
>            * and walk down to the lower level.
>            */
>           pte_addr = NEXT_PTE_ADDR(*pte, level, address);
> -        *pte = amdvi_get_pte_entry(as->iommu_state, pte_addr, as->devfn);
> +        *pte = amdvi_get_pte_entry(as->iommu_state, pte_addr, devid);
>   
>           if (*pte == (uint64_t)-1) {
>               /*
> @@ -1763,6 +1769,7 @@ static void amdvi_page_walk(AMDVIAddressSpace *as, uint64_t *dte,
>       uint8_t mode;
>       uint64_t pte;
>       int fetch_ret;
> +    uint16_t devid = amdvi_as_devid(as);
>   
>       /* make sure the DTE has TV = 1 */
>       if (!(dte[0] & AMDVI_DEV_TRANSLATION_VALID)) {
> @@ -1796,7 +1803,7 @@ static void amdvi_page_walk(AMDVIAddressSpace *as, uint64_t *dte,
>       if (fetch_ret < 0 || !IOMMU_PTE_PRESENT(pte) ||
>           perms != (perms & amdvi_get_perms(pte))) {
>   
> -        amdvi_page_fault(as->iommu_state, as->devfn, addr, perms);
> +        amdvi_page_fault(as->iommu_state, devid, addr, perms);
>           trace_amdvi_page_fault(addr);
>           return;
>       }
> @@ -1823,7 +1830,7 @@ static void amdvi_do_translate(AMDVIAddressSpace *as, hwaddr addr,
>                                  bool is_write, IOMMUTLBEntry *ret)
>   {
>       AMDVIState *s = as->iommu_state;
> -    uint16_t devid = PCI_BUILD_BDF(pci_bus_num(as->bus), as->devfn);
> +    uint16_t devid = amdvi_as_devid(as);
>       AMDVIIOTLBEntry *iotlb_entry = amdvi_iotlb_lookup(s, addr, devid);
>       uint64_t entry[4];
>       int dte_ret;

Update the function amdvi_find_as_by_devid as well to use 
amdvi_as_devid. Thanks Sairaj

