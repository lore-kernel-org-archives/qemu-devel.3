Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98EB606A31B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 04:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=2GbBQT2W
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPBbV-0004pV-4K; Thu, 05 Nov 2026 23:31:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1xPBbI-0004og-7S
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 23:30:55 -0500
Received: from mail-westus3azon11010068.outbound.protection.outlook.com
 ([52.101.201.68] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1xPBbF-0007E5-VQ
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 23:30:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G50CKd89iTx4D6qRgBucvJheeOSCWl8QKKjYuCi2BJVlC6tER8qtnjwk8g62yDRqHyP7TfT8dVCtw4IjZl/fxzTx/O7ed2G4NtjYQeZo0wRaJU7BIkUOWtJxyusSfip/Axhq9BaCa18lddQAHgVyLgShpxPV5ADdzBQTpiadL2nREh33+UTQAWHBFuf4L+4bUhffx2eo1SqV4uWgv5sHhRrtvcB5py8xw6iS7xP2CJKGmtGGaSoxKhWoZseE/q/F/IKlIbG5HInMNzazUVT4NWi/+L0pwfUBG3IXRxr5pEIjl/MjLz5SBnwBCotw5IQk1O6QKNI5lDF/you/HdbGOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g2b031jz941KroPbJ888rP8D02HKzlSZNnQa96lo0fE=;
 b=xI8BFzdtVkioFFkUbMCal+zakbiz+8bu677r5beeQjF4DbTw7eggnSyhVhcLx7FO01LfZK6ExAN/eFUrmH+TreiE1UAhuJ/E5yIbb9Pn5pYROyrQCBimEqOMmj8l0PFCyvHBarAJFvgQskijmq+JqVHbJNUQKMlQxP+lCqufwnTLarARDcoQ57g644iIKolHcNSxjQtkMlnf40HD6HvBYCDzbMH9f9G8wvryk6FDVoaDgjYgfrtlNDPhRbwGiNe1P/XecfVEB40y7pPrcyJBcypfmvkvS223NZ1wMzHDVtvnLOZLKC5J1xbE8Bqer0ti664PQdbSUlsGIWEk0XVTRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2b031jz941KroPbJ888rP8D02HKzlSZNnQa96lo0fE=;
 b=2GbBQT2WiZCoX75ozT8mob9SIHQs+76ZgcDbWROZ6dZLOw9+AOjq+DTj2sWnR8ydn35PFfufXv0O3GIooY6GyFKqJKr9KRr2zjkTDwEAvXqwbldv5tRvRqSIhDzuNEQf4y2jiXB4o9uV6HsvOB7+oh9fPQzEcPAyvSX8R6BuT3c=
Received: from CH0PR03CA0234.namprd03.prod.outlook.com (2603:10b6:610:e7::29)
 by SAEPR12MB328963.namprd12.prod.outlook.com (2603:10b6:802:204::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 04:25:41 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:610:e7:cafe::23) by CH0PR03CA0234.outlook.office365.com
 (2603:10b6:610:e7::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 04:25:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.2 via Frontend Transport; Fri, 6 Nov 2026 04:25:40 +0000
Received: from [192.168.1.5] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 5 Nov
 2026 22:25:38 -0600
Message-ID: <9b9f1a9f-6db7-4d1f-9bb4-f46990a276f5@amd.com>
Date: Fri, 6 Nov 2026 09:55:34 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <sarunkod@amd.com>, Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] hw/i386/amd_iommu: Mask address when calculating large
 PTE page size
To: Peter Maydell <peter.maydell@linaro.org>, <qemu-devel@nongnu.org>
References: <20261105105816.3012283-1-peter.maydell@linaro.org>
From: Sairaj Kodilkar <sarunkod@amd.com>
Content-Language: en-US
In-Reply-To: <20261105105816.3012283-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|SAEPR12MB328963:EE_
X-MS-Office365-Filtering-Correlation-Id: 0338ba0b-b037-4863-c6ae-08df3bbe03f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|261026140227099003|11063799006|56012099006|261009223027099003|261022105027099003|261021121427099003|261021123027099003|261102123227099003|261026121527099003|261028144727099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: vgCeLPjXiCNSzNADbs9EnWuqj8QEzZAtv7IXHrK/e5/20BCH7Omu4Fi52LQpaxD61EbCx/aDuLPT5iPDbQovWAtEVZoelG34pp/n/3xlT1HD9yuvDFlIZ0PUXB6ll1c2zRWPwx3/OFpok550XMh+bgqlfsdWif6c/ctVfhMRwdSOriLJJHjai+l0sJ/imfDbBwtH0YBWef5V0x3x7bShxrXKhZxrBvohIiGKxh2f5BxaFI/5PWDqGIUkiwYkTFW1zlhTEDaqMRxL6k8UrC/8YKDBAcz9m6GgGXYDlFjHocC1KQpP3OHj9OA3CrqAjiSp4fO1JtTBmsjkiaYlHB50GW1YE19QAWWXCxHxIc2IWEBgyCwLOgKApo5VrlZy16TTP6WCcljtx/yy/HVylpXIrQus7g1ALz7Ar5RkMViOn2r96Ts/ICLyc3lnIwGYFjxLWF2oiiCj+yE6ZKco/iK8vZPMdmN/iF4evJeCQB3g6OHxY/fORZkA4O79Ee4Oeok8e9ahVd5gOpcf2Nm1GsUjLwsh++qXkPlKUOMNsPmaemTKY9Q6oFqvocl0ZxeslJgedDHS6Av1s9eWD4EBUu72DpS7RhRK44YM+0ZH18Bw0bygcmtQTclDMxDJH95yyizmwE/QM+U0lqBCyQ50cq0Vz0w7erVGs85tZGelNfAEKVR0OtDgKpqNI4Y7iHr3klByQdZJDh5ShY2Jc1Jw+LJ84A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(261026140227099003)(11063799006)(56012099006)(261009223027099003)(261022105027099003)(261021121427099003)(261021123027099003)(261102123227099003)(261026121527099003)(261028144727099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LWcynivvQbwdsGuQDmrVjviXiv8e5QDuPOyOgSddNaQwI+00DEeonCjnhzfme9nmGDWBWxNWISquvQ2cSErTZvvFCRSAZd7DBsZW+JC05eHNHxvvFvVqHmNvPI/VMApEdQxYR6++4Fgym7afBp8ZCuBocX7bJ0jq9sD0P9YyWWBeIGTU2cUKDvMro7F6r9Lf31yn5Ek0iUCr6vlKA7VZQLSyFTDIaF2nNe7ilMCFMp4b4lxtF7RI9NNtyAH42UiS2yRGWfO5/8KhaoYJgROtc76MZtHcuIgka93lJQiXXRz6yXYNaPpqVEieE5kgvai4yFpTzMINwEYTrDqZ0t/e//Hds7z7T9LUhvxFXnGwRj1lpvot3l1gTe8wqNzAIUO9762AsksJqHAwREcP4DIxR50qLOsddQlFBD7zIchfyVsYyKg7TpKvn2Zg0ya942mN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 04:25:40.5803 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0338ba0b-b037-4863-c6ae-08df3bbe03f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAEPR12MB328963
Received-SPF: permerror client-ip=52.101.201.68; envelope-from=Sairaj.K@amd.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/5/2026 4:28 PM, Peter Maydell wrote:
> The amd_iommu handling of the "large PTE page size" (where Next Level
> bits are 0b111) case is not correct.  We calculate the page size
> using the address in the descriptor (as per table 14 of the spec),
> but we don't explicitly pick out the Page Address field, instead
> passing the whole PTE word to cto64().  This means that a PTE which
> incorrectly sets all the reserved high bits can cause cto64() to
> return 63 or 64, and we will try to shift by an out of range amount,
> which is undefined behaviour.
> 
> Mask the PTE with AMDVI_DEV_PT_ROOT_MASK to get the page address
> (matching how we do it to get the address for the next page table
> level in NEXT_PTE_ADDR).
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3618
> Reported-by: huntr bubble <https://gitlab.com/bubblehuntr>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Side note: we don't seem to enforce the spec's requirement that
> the page size must be larger than the default for the level
> and smaller than the default for the next level up, but that's
> a different bug.
> ---
>  hw/i386/amd_iommu.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
> index 948d8611b15..008e882724c 100644
> --- a/hw/i386/amd_iommu.h
> +++ b/hw/i386/amd_iommu.h
> @@ -216,7 +216,8 @@
>  /*
>   * Take a PTE value with mode=0x07 and return the page size it encodes.
>   */
> -#define PTE_LARGE_PAGE_SIZE(pte)    (1ULL << (1 + cto64(((pte) | 0xfffULL))))
> +#define PTE_LARGE_PAGE_SIZE(pte) \
> +    (1ULL << (1 + cto64((((pte) & AMDVI_DEV_PT_ROOT_MASK) | 0xfffULL))))
>  
>  /* Return number of PTEs to use for a given page size (expected power of 2) */
>  #define PAGE_SIZE_PTE_COUNT(pgsz)       (1ULL << ((ctz64(pgsz) - 12) % 9))

Reviewed-by: Sairaj kodilkar <sarunkod@amd.com>

Thanks
Sairaj

