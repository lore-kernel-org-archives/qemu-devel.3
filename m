Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E57606A322
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 06:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=LP8at/C5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK9BS-0002y6-Lb; Fri, 23 Oct 2026 02:55:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1xK9BQ-0002xU-UK
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 02:55:20 -0400
Received: from mail-centralusazon11011048.outbound.protection.outlook.com
 ([52.101.62.48] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1xK9BO-00061I-Gq
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 02:55:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wBek2niy1GAM9DPeCyyIcGgJiMTRm/eYhIDbn/jfWfHjX7OWvFFtzvyfNbzReGY/A4rJ8/lcxmTzr4RkYBXt8e9Bg5pD/Nk6rJITn4AhTolgtQ3sHwoHytyUNIITPxB22EbGcDZEZTGnkGpAXayi0aWRsqwoTZS+SW4PacsfWx7x+2m6A8cn/MSAAqgjx4CYuOqyX5D66XLGyWJJMzivc9I9XOJiWp+CmhkQEpVmp/JaqY1+taYw/Oc8SW5nFqYsYPfSnw6bE83YsK8Pwv+3/ACGupWXdaKylYfiJ/20nUEnG8NQBNFOzgot2kJgpRqFXi2k2koqjEQl5CW/+l/Zmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UXZ6iJQDmLQcVWVPiM8rc+AztvYq/7niwhT25CJgjHk=;
 b=W8haGhsJ8yP7spkbSd7hUBk6N9U6zhwMVYw6EqVbEt4gGxK1B7b3tGF+oXurfeuUjVX+nf0D89h01BPM7Wq7thGr/y9LRV+8kzXCG7G2zdGaXhiFxD93nZ3RI/mGxRu/ITJOb+1hmjMDzZFOT0t7h+mNqOHa0N9nmdmFf6yBe57EjYlJgx6b54kopdgHqxRqqQe4FYNNKw0zU6OH4tmBa8lSm711AP5VR5MN1cclMq2FDpvUgJKBRvGgim/FAR5GH3mqQ25/halfzPYT6VO39u/SBYQKdJ4wLpziYps0PldMxzs+ERQjMvsMgosBuKcJEFKn/W5pGlTqUK1goq9jJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UXZ6iJQDmLQcVWVPiM8rc+AztvYq/7niwhT25CJgjHk=;
 b=LP8at/C5z48FUnb0snJbBMSExDG/uurigszROTmhZC+i/2VQcizQ9d0xXKRDPhJ66c8Mp2/iMHVWAlxFcsvd60jAwxkaJA/7x1sVe6OWONAOY/v8kwQRiY/Pa6fyjfRcdw28lYvStehhf2mDpolsvFMxFTWdSukVWFcXvHBMAzQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5254.namprd12.prod.outlook.com (2603:10b6:208:31e::21)
 by SJ5PPF000ACABD1.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::984) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Fri, 23 Oct
 2026 06:50:13 +0000
Received: from BL1PR12MB5254.namprd12.prod.outlook.com
 ([fe80::5a65:263:c1fd:cd59]) by BL1PR12MB5254.namprd12.prod.outlook.com
 ([fe80::5a65:263:c1fd:cd59%5]) with mapi id 15.21.0546.016; Fri, 23 Oct 2026
 06:50:13 +0000
Date: Fri, 23 Oct 2026 08:50:08 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Matyas Bobek <matyas.bobek@gmail.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>, Vikram Garhwal <vgarhw@gmail.com>,
 Jason Wang <jasowangio@gmail.com>
Subject: Re: [PATCH] hw/net/can/flexcan: Fix FLEXCAN_CRCR_MBCRC definition
Message-ID: <atsDoMzNdhZq26Po@xse-figlesia-l2.amd.com>
References: <20261022195924.672606-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261022195924.672606-1-peter.maydell@linaro.org>
X-ClientProxiedBy: GV3PEPF0001DC07.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::269) To BL1PR12MB5254.namprd12.prod.outlook.com
 (2603:10b6:208:31e::21)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5254:EE_|SJ5PPF000ACABD1:EE_
X-MS-Office365-Filtering-Correlation-Id: adc455c8-e5b3-4738-d4f9-08df30d1e356
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|261021123027099003|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: mtTQBxiDhQsHASMA4Jkk9ui5n4VCGG7VT/Sc23iNpT0RxbLAkW7eoW2Is1vP+ChoBbFRAExXW2ASa/Pr+XNFr5CCGracAt8iOaN3drfcdIfrXXxHGQ+QJuAQN3HtOS1BLghr9NVzG0BSlxSMvqwxzv/HfHMffwuhqXobV9zDrq6+iJyyVtIoDuyfxfRbgZ6pvK8pXYiFLYPwKMnPGD81Iv/pAAKKNcPviDiv6i0g4+oFsYS7RU0eEVWtUD6j8AB1skp+5FCHB+jtABAUFjVBuUEgUemKx71WoFr1oV1Pbd21YibVBWbILv6yK3uwZRziEhlgfs0Ozp7VG79C8XCKIQo+umpJ+p2SddqOiwbIrkA7Isymi5Igph/OTKRuFTrkkVboPeXfLadHLKetbEdU6IEIKm5y7edybjnqJYEGCeLPQHGbSF/PYu1z3ZvajKoFHILXStb9h7ia4nf9pKzA0eSN1zZ9p/Vs66SHYPCKlRZWP/fV1q0v/rGbRnE/LC0phK1J6xxTY/2GIecqUUST4MsVAt4V3amvAHdfAxE9NliH1CP5S2DleVU2cDjpf6YSTZv0ma9ftdmhu7tq1G3VFoUt0xuzSMWRbd46STOn/2o9N3ZX1fqat8lD6/84Nc3jBT5VI0TjfKpVK+18l+HUQNu8OpBATadSVFEofdsL8n0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5254.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(261021123027099003)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFdtRllPWG9nN2ZJblFXYTJHZGgyeVVybzc0TDNyRGpmMjNubGhndnNzY3hs?=
 =?utf-8?B?dkdRMmwzdTZ4NWV2WkhCUFNDOTBqVE5MejVUeWcrWnNic1hLOEJScjlZdW1a?=
 =?utf-8?B?RUVvSERlbXN1MjN3OVNrT3R4Y2JTTlhrMVpIMU1GTjh5eURhVmJ6RmN2U3Ry?=
 =?utf-8?B?aXlsVjluKzkvZFhSb1FCNTU2NkRDeWhabEk4ejd2aVRXQkIwSmtwN2VEbzA0?=
 =?utf-8?B?UGJFc2NrQkJVd3lBSHlqV2cyUlQxM3g5K0srckVHTk0wemtweC9aOHBkUkUy?=
 =?utf-8?B?SU93Y3U0ZlVxSVZZM3lZVnFYNC8wc3lyUkV3bVg0WE9zLzN2b2JDbVNmb1dS?=
 =?utf-8?B?N0ZyZ2FYRUhxeVRuSHNCazQvNDAvekJPZlZvOE1pVk5GRDNtMTV3dm5HNjZC?=
 =?utf-8?B?TkhIT2s0VFNFU2l0cnd5d1hyYzZRbTdLK2tGd1RrUDFjK0dOczZ2K0VBQ3ly?=
 =?utf-8?B?bXUrb0NNYnFOdnZFeUkwZ1NhNXN6NkFuQjBVMHdjdnovRVZsUXlvbnpHRkhk?=
 =?utf-8?B?NVd2Z2o5Vm1HUG5yNkh3K2hFY0pnQ2pTakRSOHI2VWF3TGdKS0ZPUXpZcjRs?=
 =?utf-8?B?b3QxQmt0d1BpSjJ3QnNVUXZOWUJxR2JhS3BkamZNczhROTZra0pwNVlPNHR1?=
 =?utf-8?B?ZUpmaFdKamdPZXhxMVk2SFE4VnZGT01wQmlUcEMvbjMvQ3U4VjNSR1JyOHRQ?=
 =?utf-8?B?TnlIVlZ0NzI1UDFRejdNbmV1U014dkhSY3dlVjV3VXJFSGc0R3lpNFN6VWg2?=
 =?utf-8?B?UzVwalJTelYyM3NpdncyaHJKWDJ5b0lvM3FIMVU5ZVRRdjkxWGdReTgrUUxI?=
 =?utf-8?B?RGl2TlFCS1BKNjJEaVVGQWdxMHVSa3NFQjBZNmM2a2NRdVJoV2pzczh5SHNy?=
 =?utf-8?B?UStqSnJuckNpczMwMEZ1UlJhQXJ4T0hYME9lWUUvQlh1d3dsVjlaQzFPWjN1?=
 =?utf-8?B?Mk5mMEgzVG45RElaUTdaWFpvSVdGeFEvK1dVQjRSNzJMaDl4SmNqWm5DNXc0?=
 =?utf-8?B?UzZFcFRLZzJLREQ3RzIxRE5sR2l6ZC9rTUhHbGFoRHAyQVlGcjZwRVdmcGZn?=
 =?utf-8?B?ak5ldFhKQlhsS0JMa1J0STkzeld3MHVnaHhKa2pndm1UdHdSeGNodnJVREY1?=
 =?utf-8?B?STBUa1VvczlGN1B5QXpOT2FsVjRLSW1ObXRrOXdObmdVTVdCL1M4Q1M5eFFO?=
 =?utf-8?B?cHJZTzRvOXpYQTZaR0U4ZG1aQ2owWjkvNU1IMER4Smp6TGFtYzc5OHo5TUkr?=
 =?utf-8?B?MGhDb0VxdG1tU1RxMS9GczdMKyszRCtEbjhXY1E1aXBwQjBub3RFdW5yK1hu?=
 =?utf-8?B?NDlGeVdnQi93dHhNRFYySmFUb3VzWmVEaCszQjY5NTFoSWM2VGdzaitJUHV0?=
 =?utf-8?B?ajlGN0tieGR4NGIrUEFVUWlWK3NSeEtjdmdJL1lod2F6WDE2TysyUlRQdWpU?=
 =?utf-8?B?eGZBem01TnlmdkdwNHZ0YThOQnJHcW5SVlZ1Yi95eDd3UGVMOWJVNk12ajR6?=
 =?utf-8?B?TDZwdms3bjZ0UytlaUV2TG0wRHlvRDMvdElvbkVVbHlBM2Y5aVdPTnFvM2N3?=
 =?utf-8?B?U0s2M1hPWjNPWEp6akxIODhNRFJyVnNjc05DRVkycXFLVGdzSitrUkdZY21E?=
 =?utf-8?B?SXFEUVdhbVhBcmMxN01DYkoxWVAzUVdlKzgzUVZIamxyTmdmVUJhVFQ3RnJ6?=
 =?utf-8?B?bHFhdUR3RTZ5YnZweGwzVXNqbk96dG03VWdlQjVLU1ZnOEZmYjE5R3IzNWpq?=
 =?utf-8?B?OStNT2FHSDYyYWx6a1BRL2FkRnY3Uk02UkN4WFU1V3puNlhiT2VCaVp6d1Bv?=
 =?utf-8?B?R2l6MmRteUsxNTFMVkRWclpNdGJRbVNlb2xOampxZjJZRWwxTTR6bjk1cmRm?=
 =?utf-8?B?VTZ1MTc4SW9UOGl1ZDNNUTl3MHlDVkZRT014Yk92REtaaEFKUHFXQlowd1VZ?=
 =?utf-8?B?S2crV2xlK0FJSXpMY2oxRTV2ak1YN2swcmZ3NFdxRUpyNlh4amlDTGVlVmNV?=
 =?utf-8?B?aUU3bERPZzQxZmFjeFkrVnBJMVNYTjlFajluMDVvRE00S1hhZHpveTZZTWta?=
 =?utf-8?B?bUVQNW9RY2sxTExnSjNNcER1cGJab1gzSjRUcitZMDVDa0Z6RDVRaDlUWHVR?=
 =?utf-8?B?eTYwdENrcWpzZ0EybG1pZHgxUCtOOUw2aFNJcWJJNTV1UTlRcGNKcTg1UWdL?=
 =?utf-8?B?QnVtQ0R6UjBYOGpzSnJuU3ZkQnBnUUNXYU9VWFhGREVLN1F0WmJ5MGtnai84?=
 =?utf-8?B?QUFvb1ovRWZicWdqMm5hTnFpSlVHVGp4U2Q0bUdzanFvcXlGdlVmcXA2UFp3?=
 =?utf-8?Q?3XbONNuulDIst5yIBp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adc455c8-e5b3-4738-d4f9-08df30d1e356
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 06:50:13.1877 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R5i8KqzgGYEhMzM+QBr18uPmd9QAAEOlAQOqQJNQdpiSRfYyHEa8bnq7+X31qRTXHP45yYE0suT9oCh1nlsXgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF000ACABD1
Received-SPF: permerror client-ip=52.101.62.48;
 envelope-from=francisco.iglesias@amd.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22, 2026 at 08:59:24PM +0100, Peter Maydell wrote:
> FLEXCAN_CRC_MBCRC is defined as
>   (((x) & FLEXCAN_CRCR_MBCRC_MASK) << 16)
> but FLEXCAN_CRCRC_MBCRC_MASK is (like the other _MASK values
> in this header) defined to be an in-place mask
>  FLEXCAN_GENMASK(22, 16)
> (a value with bits set from 16 to 22).  The mask and shift operations
> are done in the wrong order, and so the result of the macro can only
> ever be zero.
> 
> Fix the macro to shift first and mask second.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 3c4e23cbb597 ("hw/net/can/flexcan: NXP FlexCAN core emulation")
> Resolves: Coverity CID 1662973
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>


> ---
>  hw/net/can/flexcan_regs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/net/can/flexcan_regs.h b/hw/net/can/flexcan_regs.h
> index c18bc4736e5..7923bf836ff 100644
> --- a/hw/net/can/flexcan_regs.h
> +++ b/hw/net/can/flexcan_regs.h
> @@ -150,7 +150,7 @@
>  
>  /* FLEXCAN CRC Register (CRCR) bits */
>  #define FLEXCAN_CRCR_MBCRC_MASK         FLEXCAN_GENMASK(22, 16)
> -#define FLEXCAN_CRCR_MBCRC(x)           (((x) & FLEXCAN_CRCR_MBCRC_MASK) << 16)
> +#define FLEXCAN_CRCR_MBCRC(x)           (((x) << 16) & FLEXCAN_CRCR_MBCRC_MASK)
>  #define FLEXCAN_CRCR_TXCRC_MASK         FLEXCAN_GENMASK(14, 0)
>  #define FLEXCAN_CRCR_TXCRC(x)           ((x) & FLEXCAN_CRCR_TXCRC_MASK)
>  
> -- 
> 2.43.0
> 

