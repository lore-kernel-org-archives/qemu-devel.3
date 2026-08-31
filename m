Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06A53C61DE2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 08:21:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0xG1-00068i-0p; Mon, 31 Aug 2026 04:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1x0xG0-00068P-8S
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 04:20:44 -0400
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1x0xFx-0007Ha-To
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 04:20:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c8qG4E65xb4DObb7dJcsFh9Vd0yH2Y+JrkDgQmvOORIxM29ITnpFTKvc6iealQmcG+4dv1PBvQMuvsL9sTEH8rcXOaI5v3ana1Ponetz6rzZZCkGURjvTW+z4MEM369DpbtaC8j3udXELVyuBHxHUx19XoadTFfLvrE4U4AoK7wds9FtKxNkEVh4YN+67+YVCz/IZKHjCs+65UMnyTYXHHZ61vQ6nZWSMsZ1vmYetkQpMSuPPVnunuMuC3XAPG/l6X5n2CxgM3BUnVfe2B++LiyNcEGyFILjw0fDO/YKGt9IHUxopDWd2ggkG7457SGY8ybN9GuTqBjqbs2X7Wyqnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PUspbzI8RTBIhtFinY06poyyBxD3pwxPtE7nLTtZRI8=;
 b=PAWxDr1PExP3Exdgh4ac9uz4dZYCVS4mlMyX8Rf1mshAenrcCtYhipMATN2N0MZ1ZZclMwlWnEk75pynQCduppRCkTr6+FnTCv02W/8KORTb9v4EFfLFuP+qX5q1ZycqNIVwHyRlw28sySaMZ1b8VyqJgO+2LcSxzN9TZ7oy9vS2C6eOIi0eA/DpU//iiViAOYJ4QwFLY//16NQYaMJNLGyCSWEjjqc8V4j5yDknOZooywFeddFs1rt7o0HYSqCPt7FjQ0xx47a5GnG8XZM7/xRxuLyMselaj2X/Ve3MP2LeFmy5EmBKWtIhzFzeK4635iTQ2D9ZDCwYVzM4XPnM0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUspbzI8RTBIhtFinY06poyyBxD3pwxPtE7nLTtZRI8=;
 b=KgteT4n0L7z0jSoWbid5YI36tyxtSv5OzWeat/76pwRdce+P+1oiqfYnFfPSuAGizT0KYAMJsSkvErzIYQ19gikm7yiO9fLx+SRC4QJmv32o38vleTUqLanLQGupocTcjcMWd61LSI2NWCHNYubsHcXL7bhQO3v6vgZ1+bsjl2A=
Received: from BL1PR13CA0011.namprd13.prod.outlook.com (2603:10b6:208:256::16)
 by PH7PR12MB7426.namprd12.prod.outlook.com (2603:10b6:510:201::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 08:20:34 +0000
Received: from BN3PEPF0000B069.namprd21.prod.outlook.com
 (2603:10b6:208:256:cafe::82) by BL1PR13CA0011.outlook.office365.com
 (2603:10b6:208:256::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Mon,
 31 Aug 2026 08:20:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B069.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.0 via Frontend Transport; Mon, 31 Aug 2026 08:20:32 +0000
Received: from [10.85.43.97] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 03:20:30 -0500
Message-ID: <a4b0e620-727e-40b5-85a0-b028fd43f435@amd.com>
Date: Mon, 31 Aug 2026 13:50:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <sarunkod@amd.com>, <alejandro.j.jimenez@oracle.com>,
 <pbonzini@redhat.com>, <richard.henderson@linaro.org>, <mst@redhat.com>,
 <joe.jin@oracle.com>
Subject: Re: [PATCH v2 3/5] amd_iommu: Define MMIO register masks
Content-Language: en-US
To: Dongli Zhang <dongli.zhang@oracle.com>, <qemu-devel@nongnu.org>
References: <20260724223216.108667-1-dongli.zhang@oracle.com>
 <20260724223216.108667-4-dongli.zhang@oracle.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20260724223216.108667-4-dongli.zhang@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B069:EE_|PH7PR12MB7426:EE_
X-MS-Office365-Filtering-Correlation-Id: fec0c8e4-286a-4338-12a8-08df0738b9f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|10067099003|4143699003|11063799006|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: zuZd6zmEH7xUWNOjKibLDm3Sh+vmPWydiM+C6LuJ9/iwYM0HJwqMGg2dMMSWrQzqdswAW0VrcV510+DEET7DcxXMoEOAaHKw19z43r/TugqtuCNiRuuRQl0OTjcI4IOuURUSAgU/wILZ+vh4lT+zLhf1DtqhBWWG81EujoHAdc0AO4YbUDGT5xDZq3Ak09cBVkUhpvsuKXB3G1hKLRRI4m8t0Q6/KjitPEi5/S9WUZCF2QHqVgKO9xAbFg+rcgod9bB9wXBSpE40WYiOhZCi1bojXM7sa9g0dujzUaFqkUXZQkhq5uE9S1ynwHsAuyLPWd3P/JL9zXxASTw3zUhXaN01SXwAYhUqAY36fj3mDG9vyX88mkFi4w43EJ9o8u5tHS3+L0PIuoO3E9eIOo/Zyhd6ZLG/f9bMAeJnD2x3MJO3oqAF8qof1aEAelpNFF+aUcBEZ6D6dfu76m10+ppszsACv0HT6Me5O8c7kk+ZnEYnc76V4a2+DUhV4p0Di+rj5dgWqDUvSJrSIO+GEawDqR1/sYUA8dGTnkMAtg7zDK4QEPkIx7R/QD40MavVd1DhR6gd19La1Dc+w4kTfepW/cBH0sCGGMgx99fhi2GWQhQBV3/Hbz0ZiHu40OKve+jHRd+0AxR8EWP6YXWlEcd/etKaBvfI1V7oRqu40cHMic0jm8/MXxhjxjEmywruIPFIlJ5gIfPZsLPkKqMYhRf2dA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(10067099003)(4143699003)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3m2TSLFLEyGIU6sBzJI/XQ9Hwp0pcFbN1j7Is26UwMWwey6HKYCrkb22tGRAjh6uO5pL4AOS30X2ouKowa3S9unMQljKwV21ynyEHJMctEFjv573IfR9HX3hsUg8BwHFW6jSFxbq0RsP/CpeqvMtkO6s2oM8ArtwRnXbEWUwO/9axdfLF9/SQySPqePMLhmCRf9OUaYpMs+yvAAV5tL8cyQD+33F7IHyz+GxT0MNoikMdb8rztsWpJvnrnJAymVNIUtyltosVIW+7G9pf6TrdQFIOHoQT7cRwUaNPn4jJaQWZPoNuh9NxbxdM07h2foY7zVq25xxcgFuGNRs1NT2PrA88nHSevhqnsj69nM7iY+6BmHcfihxYfYeP7+QHIQUnZjXLROk+h/1082E+bTWT8AAwP08Nn8oSK1wUx3RF/2X7ATfVOWWaIL70Hvmgr0s
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 08:20:32.9083 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fec0c8e4-286a-4338-12a8-08df0738b9f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B069.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7426
Received-SPF: permerror client-ip=2a01:111:f403:c110::3;
 envelope-from=Sairaj.K@amd.com;
 helo=BN8PR05CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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



On 7/25/2026 4:01 AM, Dongli Zhang wrote:
> The MMIO read-only and write-1-to-clear masks used by amdvi_init() are
> currently hardcoded. The hardcoded values look ambiguous.
> 
> Define named masks for the AMD-Vi MMIO registers to make the code easier
> to read and understand. Use status bit names that match the Linux AMD
> IOMMU driver definitions.
> 
> This is a cleanup.

Instead of "This is a cleanup", we usually use "No functional change is
intended"

> 
> Suggested-by: Sairaj Kodilkar <sarunkod@amd.com>
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>  hw/i386/amd_iommu.c |  5 +++--
>  hw/i386/amd_iommu.h | 24 ++++++++++++++++++++----
>  2 files changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 2fd680c4ff..7ca6d33abb 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -2563,8 +2563,9 @@ static void amdvi_init(AMDVIState *s)
>      memset(s->mmior, 0, AMDVI_MMIO_SIZE);
>      amdvi_set_quad(s, AMDVI_MMIO_EXT_FEATURES,
>                     amdvi_extended_feature_register(s),
> -                   0xffffffffffffffef, 0);
> -    amdvi_set_quad(s, AMDVI_MMIO_STATUS, 0, 0x98, 0x67);
> +                   AMDVI_MMIO_EXT_FEATURE_RO_MASK, 0);
> +    amdvi_set_quad(s, AMDVI_MMIO_STATUS, 0, AMDVI_MMIO_STATUS_RO_MASK,
> +                   AMDVI_MMIO_STATUS_W1C_MASK);
>  }
>  
>  static void amdvi_pci_realize(PCIDevice *pdev, Error **errp)
> diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
> index 687691ec1c..f86e37fe93 100644
> --- a/hw/i386/amd_iommu.h
> +++ b/hw/i386/amd_iommu.h
> @@ -107,11 +107,25 @@
>  #define AMDVI_MMIO_CONTROL_INTCAPXTEN     (1ULL << 51)
>  
>  /* MMIO status register bits */
> -#define AMDVI_MMIO_STATUS_CMDBUF_RUN  (1 << 4)
> -#define AMDVI_MMIO_STATUS_EVT_RUN     (1 << 3)
> -#define AMDVI_MMIO_STATUS_COMP_INT    (1 << 2)
> -#define AMDVI_MMIO_STATUS_EVENT_INT   (1 << 1)
>  #define AMDVI_MMIO_STATUS_EVT_OVF     (1 << 0)
> +#define AMDVI_MMIO_STATUS_EVENT_INT   (1 << 1)
> +#define AMDVI_MMIO_STATUS_COMP_INT    (1 << 2)
> +#define AMDVI_MMIO_STATUS_EVT_RUN     (1 << 3)
> +#define AMDVI_MMIO_STATUS_CMDBUF_RUN  (1 << 4)
> +#define AMDVI_MMIO_STATUS_PPR_OVF     (1 << 5)
> +#define AMDVI_MMIO_STATUS_PPR_INT     (1 << 6)
> +#define AMDVI_MMIO_STATUS_PPR_RUN     (1 << 7)
> +#define AMDVI_MMIO_STATUS_GALOG_RUN   (1 << 8)
> +#define AMDVI_MMIO_STATUS_GALOG_OVF   (1 << 9)
> +#define AMDVI_MMIO_STATUS_GALOG_INT   (1 << 10)
> +

Please make macro names consistent, here you are defining event and ppr
log related macros without "LOG" suffix but using "GALOG" for ga log.
Either one is fine but make sure that it is consistent.

Other that this,

Reviewed-by: Sairaj Kodilkar <sarunkod@amd.com>

> +#define AMDVI_MMIO_STATUS_RO_MASK \
> +    (AMDVI_MMIO_STATUS_EVT_RUN | AMDVI_MMIO_STATUS_CMDBUF_RUN | \
> +     AMDVI_MMIO_STATUS_PPR_RUN)

> +#define AMDVI_MMIO_STATUS_W1C_MASK \
> +    (AMDVI_MMIO_STATUS_EVT_OVF | AMDVI_MMIO_STATUS_EVENT_INT | \
> +     AMDVI_MMIO_STATUS_COMP_INT | AMDVI_MMIO_STATUS_PPR_OVF | \
> +     AMDVI_MMIO_STATUS_PPR_INT)
>  

>  #define AMDVI_CMDBUF_ID_BYTE              0x07
>  #define AMDVI_CMDBUF_ID_RSHIFT            4
> @@ -227,6 +241,8 @@
>          AMDVI_FEATURE_IA | AMDVI_FEATURE_GT | AMDVI_FEATURE_HE | \
>          AMDVI_GATS_MODE | AMDVI_HATS_MODE | AMDVI_FEATURE_GA)
>  
> +#define AMDVI_MMIO_EXT_FEATURE_RO_MASK 0xffffffffffffffefULL
> +
>  /* capabilities header */
>  #define AMDVI_CAPAB_FEATURES (AMDVI_CAPAB_FLAT_EXT | \
>          AMDVI_CAPAB_FLAG_NPCACHE | AMDVI_CAPAB_FLAG_IOTLBSUP \


