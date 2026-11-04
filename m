Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B6D606D83E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 05:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=jTEFfROv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOTpW-00070Y-Ts; Wed, 04 Nov 2026 00:46:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1xOTpA-0006rq-0y; Wed, 04 Nov 2026 00:46:16 -0500
Received: from mail-japanwestazolkn190120001.outbound.protection.outlook.com
 ([2a01:111:f403:d406::1] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1xOTp8-0005i5-Ho; Wed, 04 Nov 2026 00:46:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TW1P2D2CdOsHSDXyIbeouqOZzQmQQirmPdR1BRryMZ/5ox1P2e3z1E5NFuNXgJ8Tvvg/fzQnRyWm7odAXkVsaX7C9KVFwB7KmZunsiQAPlqjb7HxSI46CJl9LXr+X2NP6zKJYqsrA6yh1tgE8FLiGW+hQ9lxbZzrhHlPi/VNj1OOfZSgKe+USykqs/yMCqEskzSjK+MLSU65mskbLXqjXJ0PKEZBj39We3peV1vTMgteHwrSkChQ9MabZ3upWKwpydAr1njYxEnPQDCJEhulx6jsbSvSnktCLGMLIsGyL9NyTMuJlgdu2HA5uBmxb5bnejYnmz9W5OQyiaEbQ/q3Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2KMc/81PxqmqiFm1yLs2DsT6IZjXZKy+vGwoapyT5Po=;
 b=jG9pDn/ze0XFJnltPLWOIXpqzRTa5CQQD+04VWh/xBMczhRcE/KNMQL8C34UgbKWhNnmw9pGOSuOq7fBnb5CaephwHbLBnWOdJx430Rk34CScpb/nzLgaloIWO4Is9JcH0F3AnK2+oInfWabmip6zpXNDPcyU7niMjONuolZhlBLz78cQJXvzoISUvAroyESEhl2GJG9qo8M+QCY96kRrsZLLrSklzBdezR/aBOMGtZDTYRROzOVForkJQiBmPstrfmXdEuMuHUulXg94FgRnLUTeJsbGyofdIMYyaPOZUaVvpfzCxE03dvFnOq874R2x/EkBO98HbAn5JNHIXsfYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2KMc/81PxqmqiFm1yLs2DsT6IZjXZKy+vGwoapyT5Po=;
 b=jTEFfROvF97VO87izMt781F3i+AWPp5umcQLODhq3aFlndErjI8bdi6gIBKIxbDkptjFeF41x20qoxNTU8JoET7BuEWBBrSorn8USm7HXzf+fgCICpf5MgEgyvNyLeTbVFiyKhkfU3rEYDSroqC+3Qbr1pZvk70+E0PwHczz8VcNrqnzGXeM2ZAn6AJzOovFOSavnWLiiIT2MgxlQJ+MdwM2J42LBpG0Erbk5KZU61Dll66dE0SavAqpQBC4VN4it+luwvnd/d5Ko6/4dF9RXwY2rPjw+jsNYxw8GYJA9GXBNnccBR69OAwbSLehJqDkn8YNJiwMvF/Lk+odmvTD1g==
Received: from TYZPR04MB7491.apcprd04.prod.outlook.com (2603:1096:405:40::7)
 by SEZPR04MB6353.apcprd04.prod.outlook.com (2603:1096:101:cd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 05:46:01 +0000
Received: from TYZPR04MB7491.apcprd04.prod.outlook.com
 ([fe80::a450:2576:3b21:6230]) by TYZPR04MB7491.apcprd04.prod.outlook.com
 ([fe80::a450:2576:3b21:6230%3]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 05:46:00 +0000
Message-ID: <TYZPR04MB749138D338B5192F7E092ECBF3682@TYZPR04MB7491.apcprd04.prod.outlook.com>
Date: Wed, 4 Nov 2026 13:45:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] hw/riscv: Select SSI for IBEX
To: Tan Chi <tanchi25@mails.ucas.ac.cn>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, pbonzini@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com
References: <20261101031547.125591-1-tanchi25@mails.ucas.ac.cn>
 <20261101031547.125591-6-tanchi25@mails.ucas.ac.cn>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20261101031547.125591-6-tanchi25@mails.ucas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY6P301CA0003.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3be::9) To TYZPR04MB7491.apcprd04.prod.outlook.com
 (2603:1096:405:40::7)
X-Microsoft-Original-Message-ID: <54171755-08d6-449b-903f-1ff351017f67@hotmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR04MB7491:EE_|SEZPR04MB6353:EE_
X-MS-Office365-Filtering-Correlation-Id: a4be6f4f-86ad-4429-ffc6-08df3a36e808
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|8060799015|4140399003|25010399006|12121999013|19110799012|22091999003|6090799003|15080799012|5072599009|24121999003|23021999003|55001999006|19101099003|51005399006|40105399003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NjRlYWlIN1RQYnVmSThHa0FVZ1FHWDVMNmp6bVZJbW1nY0E5ajRiNEhrNW8r?=
 =?utf-8?B?cFdQUlNBOVBRanlsVUVjQzhGcldRUkpSRXZ6NUd0WnVWYk1haDQvckRmaXFv?=
 =?utf-8?B?eWs3NFhPb2trV3VYUDBEb2s1azJoT3hYOTF2SVBVdzdnUzkrVEtXTGxpU0xm?=
 =?utf-8?B?NDVYSkpOcW83aVZMa1Y3ZHZwbG1SQ0ZKWU4zQVQ2c3h5dlA3Mm5TekpNUDZm?=
 =?utf-8?B?cU5xZlZUYzNBcVdQMFkvNmt5dzJETHB4amJmK3VpVmtndlFaY2xlV0JPVUYv?=
 =?utf-8?B?cThvY1J5REEyakpKWUZ6S1VFOVNnNXhETXBWYnFTRTdUWTFzWVhUM2czZzU2?=
 =?utf-8?B?Njg5Ym1EM05zVDEyWGI3N1hCMi8wODVzTlRTS3dRaTFlZmFVTnB5UVplOG9k?=
 =?utf-8?B?RXdDZmlYYUcvVVdYZVlWRDlEd0RjZ1JUcFFMNlpzNC9ZWGZ1azVnbFo4ZGJZ?=
 =?utf-8?B?N1U3Ykg2dDBUaDI4SVdaWk5iazlpNjE1QmlKRGVTbFRFZTg0bTZnVjUzNXAx?=
 =?utf-8?B?VlJxQkU0U0F1NUZFSEJPR0ZaVTNndDV6Sy9zUW1Uc2pYT0Ivb0hCY3JxVUsz?=
 =?utf-8?B?Vm5IT29yNjZ5OFVFY3dSOUdlS3pMZG9rTlV4UzdxTkx1bUdkTmVvVXU3WHFq?=
 =?utf-8?B?dkViTXJOUzFUSUNweEo2UDdVM0V3Ry94dThFa0J4dzRNUkVkUFpUL0NjMnM4?=
 =?utf-8?B?bEdsK1FWYTQzemthZWtCV0hVaDByT21kSU5tY1hQRHJXQmpBQUdlV2o3dHlt?=
 =?utf-8?B?WTh2TlRXR0E5MUM2c2V3UlZPczRZTTNNbGRicDhTMGJzYWNmL1lNL2FHekRV?=
 =?utf-8?B?elRqUE5sVW5VbkducWNERjUvSStXZHRUR0dvNVpseDVHbUFzdjBhSUhmZE82?=
 =?utf-8?B?dWROcmFFcXpnVmdnWDNPMC9CaEJQTW9BKzV0clBhL0hxV2FEOEtpbG9rcDN2?=
 =?utf-8?B?VWRkTTh3T1ZyeUw0YnowYUp6L2p5aWpSQ1VqVlVzV1llall3ek9INlRkMGxV?=
 =?utf-8?B?WGNsRWJYU2ZTQysyWnlGOWJDLzloVC9qYi8vWW1JVnlUODYraTN6czAxbEIr?=
 =?utf-8?B?elJnRHhMTHVPeDIxcWtqTzJoOVpCTFpsck8xZDl0UTEwcGVOZXVhZ3FnRXh2?=
 =?utf-8?B?b2k4V0hhOXdNcndIU3M0bWFNcGlseHVsa0dsZHVMRStGNTVqL1ZGSko3c0g3?=
 =?utf-8?B?YktnUXJDVFNpNGVHUXAvVi9kZUhTWkZSMXUxM1dXMHJnVUVsa1RUL0hQVlJs?=
 =?utf-8?B?akhSV3ArNzlzVDVaK00yVm43eE5VQzBnSWtsenBsZGJTQ25qdEgxUHZLRW1M?=
 =?utf-8?B?cmFCRkFnWE80SnB4TkwwRHFjaTBHbWRKd1VUS0VvSlRUVWxtc2RKMHFkU0Zp?=
 =?utf-8?B?OTB4Yng4QjRpbnZ1NUcwb01FVzlrRnB5M2x5K2tyL0xONHF2dVJhbkZhbkln?=
 =?utf-8?B?ODVUcFRNc1ZhK3lKT0MzSFhRSW4rcmNpS3dPbG1RPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1VNYUdISHROam1nUThsbTgxbGdQMUlBL2Fhd01VVmhtMVdjNGlpQVVGeEZw?=
 =?utf-8?B?VDhISjI0WUlWVGFZd0djOXUvZkNpOVdOVWl3Q0xiWmphUXcrdVFSQUJ1TEdX?=
 =?utf-8?B?SEtzcE5YWVppZU5xdWJLcEJJMGhxeVlOSkplc0ZaQnNINHVWMDZJU0lTSVdm?=
 =?utf-8?B?Y1JJRnRmMFUzaHJucWFid0hFMFduV0Q5ekdHL1BobVdMU3VHakhzTjExZGd0?=
 =?utf-8?B?VWlDQUdhVHJsdTV6VWVIR0w5UlRuZU51NWtzNFZad205Njloa2MyZnB5Qnlk?=
 =?utf-8?B?ODlSWVJSdlhXclA3QzZ6OGNkWjYxenk4T2ZUV3JkMWs1SVE5aXhnY2huanBp?=
 =?utf-8?B?VjUrSFIwMWRKN2IvU1dNSEpXa2tkN2xXaVF0b1ZXQlNjWWN4Z01rTDhmWkRY?=
 =?utf-8?B?dlA3K0hOcyt4SWJqcVowWVM3QXA3ZkdsQnhXanJyWTFKUEVkRWlqeC83Ym1R?=
 =?utf-8?B?MzByZU1TOEZmdTUrUVkzSFFZbCtsSEpIRzlnaEl3SW1uWUxWckJvcmptalBv?=
 =?utf-8?B?NUZCdmhRR0g1c2ZicUZmeVY0dVhJZWdBWExQNXQ0TFBZMG5CUG44MkZxa1Ew?=
 =?utf-8?B?QnFicWFSV3RwaFJlVHIyb0lBc1JhUmc2bG52ZDZDcldvWXkwSEJsZEtkSHNM?=
 =?utf-8?B?dC93ckZZOEY4NkUya09KWkN1TmdYUWpFYXZxQWhxNUczQ01lVlRpSXgzL25o?=
 =?utf-8?B?dUNtTWJ3LzJyVlBZZmVFZzgzclhHVHh2YlJHT0FNZ1lqbVh3KzlsWlN6anMx?=
 =?utf-8?B?bG1oYjZ2ZDNPbUNYNWV6K25WSkM3SzNEUDEyTWM1NU5CSC9LS1EzUzBTcVhj?=
 =?utf-8?B?U3ErbDZKb0x4dVRIUkErUFEvR09IZVN5OCszS21IM2hXUzE1ZS9yaEhaVGlv?=
 =?utf-8?B?VjhwMmd4ZitrVW1tY0dxdnVTbGJ1SVAva3VYRXFwcks2WUhsZ1FkRkFzRVBV?=
 =?utf-8?B?Z1ZXQzVaZHNaOG1oUTd4aUFoTDZQYWc5QmF5VU1IRjd4N1AzTTVBcGdTWklV?=
 =?utf-8?B?V1VzR1Vma0NuMlI4U25HbHBRMzI0MzNFSkhqTDZGQUhpQ0tKTVBsMDhoUU51?=
 =?utf-8?B?YlJ5eXNCTWhteVZHMTJVTlJtYk4zTzV4SnJ2OFh1VEhRNWpHbGJNY1FUVksw?=
 =?utf-8?B?NURCQ3NnZ04zWi9SUnpXQVY3cVoxVmVQaTM0NzM4K3dSOEJZYkdUNytHKzR1?=
 =?utf-8?B?dzlaR1ROdWM0RFlCd1d5N3dnUHYrRDRjbDRiaU1aNnlkeml1bC80OTY0QzFo?=
 =?utf-8?B?aklSeFlzakJtNkxtNEVMMmI0Z09qYzEwWmhWTmNFbWlhUTBBSVhTMEdKMnZq?=
 =?utf-8?B?Y1pEd3duQkdJVGxvU3JTdCtCVW9kTUVIMEE4c0w1TzMydkJNL3ZWNHBnZDg5?=
 =?utf-8?B?ZkQ1OHVweDVKRDFadWpUUTNZcFFUSlFnRHdyMEtwaC81R2wxNkt4dVp5V0pp?=
 =?utf-8?B?S3B1cThzMS9XM1ZiazZ3em5oQWNzeXUvZ1lHQ2t4cHhSWkEyTzVkRWpxbTVR?=
 =?utf-8?B?ekI0eTlYVVBMbC9BcmYyVnl5aEpBWG9Mdnc0aEJBNDhZQUdNRGRHKzBrdlhs?=
 =?utf-8?B?Q2dsVWRkRnlPNExlOVMwclR3bnlXcVVEdGFiZmVXdys3c0ZFamRyYnRxQ1hL?=
 =?utf-8?B?RlM5MkRNMjMzeWhGblNSSzM3RzNWU2hqYTI0anZEZGFienE2dFBSMkdvWWg2?=
 =?utf-8?B?SkIvejRhNmY1WmU2WnpXMk1rWnZmNFV3aGZsbVRpZDNrUW40SG85L0NNbDVU?=
 =?utf-8?B?RXRCWmdNMTlSQ2xwTldRdU9kbHBuNnpEV0h2RXF0eHFuK1NmaFF0cE5uY09n?=
 =?utf-8?B?Z3BJTkN5SXd4OWNQK2Y4WlN3bGg5S3NISFhPY2RrLzFaUlhNRnlscjRLN00v?=
 =?utf-8?Q?y2qinrW+6nWIh?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a4be6f4f-86ad-4429-ffc6-08df3a36e808
X-MS-Exchange-CrossTenant-AuthSource: TYZPR04MB7491.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 05:46:00.7807 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB6353
Received-SPF: pass client-ip=2a01:111:f403:d406::1;
 envelope-from=nutty.liu@hotmail.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/1/2026 11:15 AM, Tan Chi wrote:
> The Ibex SPI host controller uses the SSI bus infrastructure,
> but CONFIG_IBEX does not select CONFIG_SSI.
>
> This causes undefined references to SSI functions, including
> ssi_transfer(), when building a minimal RV32 OpenTitan target
> without default devices.
>
> Select SSI from IBEX to ensure that the required bus
> implementation is built.
>
> Signed-off-by: Tan Chi <tanchi25@mails.ucas.ac.cn>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   hw/riscv/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index 27f03b687c..d99fee0fd7 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -6,6 +6,7 @@ config RISCV_NUMA
>   
>   config IBEX
>       bool
> +    select SSI
>   
>   config RISCV_DEVICE_COMMON
>       bool

