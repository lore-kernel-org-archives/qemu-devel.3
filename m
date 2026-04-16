Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B3F0F8808E
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 07:04:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDGki-0002Mq-VA; Thu, 16 Apr 2026 03:03:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1wDGkg-0002MC-Jq; Thu, 16 Apr 2026 03:03:02 -0400
Received: from mail-koreacentralazolkn190130003.outbound.protection.outlook.com
 ([2a01:111:f403:d40f::3] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1wDGke-00033C-Pn; Thu, 16 Apr 2026 03:03:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xuqLbimnx5Kg7DXpGVcPTdF5FXF0F7c207iBPQmgU0x7LNbmHqsfbVZ211CEVgeBCJxkhqiRhtnWoGCGG/EX1UZIF8OHvkxdzy4oL3vzK5YIBhv9C3TYYvVV8IbLgc1C0q+v12+qhqULfTjkvtiDk7vNkor9U7tpJ2hUKf1CL5sd6L4SjYIYQRUlOv2RiprdgNOA2m8PxpHHWY/jixyfeKO7SHcb/2rWqOIoKhhrzPaSQrqBtWK8HZP04ZpYae3hd6/Ppz7z9cUf0KsP+e0JshbbtliUiw3q9yEBIzMCzxbHMlSdnplLuWJdGHlgcuYKpctrJ+jh8uirud0bWUKFxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qm/H2H31i1XknV2mM/bWF0xBNJ/MJc5I2nzyBZ4HtHI=;
 b=eqc8i9vEMD2808zo1f1uY6oIR4D48Av2m5X9nIWB/z6A9RqgndVRf5yL8D0xzdkR7RBRFYc3b1C16r4kxbx8RDW09R2FwXZMJwt4eMtpfRSUBbQFknh7gZIbnUCJOvuMpkMQCoLp47xm1pK3hSm8MJfyg2u0wkr5mICB1Lu13yxNljOYHdcKsLFVEhSpDc4ITifjXOA4FtZMJAWADR3O/oJNgDvobK2ErjeLGqHhaU4482mmpMKXhOK5Ho+fb4RLVZdY4CJ68MYxBBCtY2izeuHYldjB4J88e+K+psbL7rsIxs9UUFISOqeK+KqbQYPEQykFJWfNuHEI14C2tOMr3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qm/H2H31i1XknV2mM/bWF0xBNJ/MJc5I2nzyBZ4HtHI=;
 b=OTJgUe3BFyIB5U8MvB8VeEFzwtABIBMU3XL9Ybl9Gj+Hjak4ENPkSYfq9bMORQV9Xhdeeg1nMIYWGk7Knfhc4RndhLzo5D2uZhdlicXIIroMIUS5W9x6g4JwIZqThvw6Z6tx18OY1DV/cLB/mdXUUZ9H0PDNh1r3EtoNyt+RXds9kE8AHTOax+tmXplsHcBBcufvHF87MGpnGKukZm91QVGAipvR1l3ZjYJoiaZ9TG/C4DFtmrCbeEdDoGybcZuxFPallGVOyk6lLQKkoQt1qL+ZzgkZ0dfgnU2VA7jMKQqFQeokt62qslVVr4QDe5R2AS+OvdM996zVp/gUd/nrHA==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by SE1PPFD1DAE8B78.apcprd04.prod.outlook.com (2603:1096:108:1::52d)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 16 Apr
 2026 07:02:47 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%6]) with mapi id 15.20.9769.046; Thu, 16 Apr 2026
 07:02:47 +0000
Message-ID: <SE3PR04MB8922F4F93B35076CF01F87A8F3232@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Thu, 16 Apr 2026 15:02:39 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] linux-user/strace: Use pointer type for read and
 write values
To: alistair23@gmail.com, palmer@dabbelt.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>, qemu-stable@nongnu.org
References: <20260415233740.3027321-1-alistair.francis@wdc.com>
 <20260415233740.3027321-3-alistair.francis@wdc.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260415233740.3027321-3-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0028.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::9)
 To SE3PR04MB8922.apcprd04.prod.outlook.com
 (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID: <147b0b45-a45a-4201-b1a0-1d155f325ecb@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|SE1PPFD1DAE8B78:EE_
X-MS-Office365-Filtering-Correlation-Id: 1144db51-4994-439d-3822-08de9b8629f6
X-MS-Exchange-SLBlob-MailProps: Om8TgR6f4EAEdu9ieeuz9D5SeZesE0h2xYLU3lxtGSzaz5FU41IcYUSBEbOTJf27btbttCHHePbtJsWrHKR+CwPSZhIWzrwUeEAQMAcHxHohuESWeQb5Mk/FWzAYTo+0fxmplZiNwMBdYOpf9wmWpPl4RGsApdKeUWBgrdbj2z3LG5UiqHehB6j4QzVprmbOjsg5qD7gRRqzIsDJ8nsuF0lycynY41H8trgd37fzgnrW9bUnvbda2rgMpTeqiqw93MixA9QWy2KAn+Mt22qM/Os2ZiMsQ3avSHu5A+x6UpPrVN5jhVhjXjfCAiH4HrGnVDUzy2Ks3ftyUz8Fr8yd0rfY5ZnZRGepn1Hj12XevkpBiHXcyRRLqst6rG3zVtEYM/mKljCEWSG/hkG4jMsfidOzkBoEW6xmhxnKoEU84PF97pWB1PWZaAPocHU3pafPGJjwGMCrAlaVznHXjIGZdrWCmGSU6Xe7dBehNkKI9ZMJy1jwtbmvXbvCbFDQSkrmmzDNxp2YO0oeTzGvtsLojOhp5zTVS2Cb11kv/X757eGx4acqBPpi5vhukJgnIrNlq+bBYTbSjvrYTg/dkMlH7lg4yUovvnmqx/qcDoa+veyjkls3/jRAmTpdpNZrYyN0KpAjcWM9SqfIRMKVO5d/0n7AWjZ1BgeWnsKrYELdUxgDUmlrxbz33qcy18gAomWaix3qaIxzpI3Zt3O7XZjmcq768eufmGJrCvaVqad7xr35DMi/qGATI1lp1ukyhxkz6axrsh5rxdl7ITRrY2FQvstvj7RlLdNolr5Uz35hwO262FeGm3dVMGpRTyEbEe5LiWqjfjh2zf66M2IwZiJ+LwhdEPwLsyyP
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|15080799012|51005399006|19110799012|6090799003|461199028|5072599009|8060799015|23021999003|10035399007|440099028|3412199025|4302099013|40105399003|1602099012;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SENIU3RxWFVRcEN0c2grcFJ6NWVRUlB6bVJVb2tzakpMMDBnWXZJRSt2ZDBP?=
 =?utf-8?B?NWxBSExabmU0QkJic1dlS2FjZmRpMk9jV0NpdXhDaXVxL3hSUHE0dk1pSTBV?=
 =?utf-8?B?blpRSWVDU1ZSNGtsUmVFVjk0ZDZJbVJ3ZlpXQ2MwTGUzaFVOMDRrT1RaczE5?=
 =?utf-8?B?blBhbjBvZzRNZ3NxR3VVU1hBRk1sb0FTSUE1N3BDckV6UmU0OHN0bUd5YUZR?=
 =?utf-8?B?Q2pzUWM4azUybnQ0WFhpT0ZtcG16c3NncmQzYlovVGErdHJadGpTd2ZlMVVT?=
 =?utf-8?B?ZGdjS0p5MmNRUGdaOXlRU3JyYnhqc1VFV3hsTklQMXJFeER0bUhTL000NWNE?=
 =?utf-8?B?UVZYVWxWWUZEK2Rpb2lSaUVHclB6ZEJCVnZJQkhidXRGaFNZUXViTjRzTGls?=
 =?utf-8?B?anUrL3ppcG41OGY2RWN4L25VWnQvdHBEYUxWRkpSRWpYcVZsdDJPTjZBUktX?=
 =?utf-8?B?RzNIRDVtQ1h3a0xEanowbVhDNjBKam9UaXBYUHpvSzg3SUNyWC94WXpvdlNw?=
 =?utf-8?B?MmVUazFONi85U3ErRFJvWlFzb3JzQjR5c1gwRHNHdDIwMlVyeGRGL1pPV1B2?=
 =?utf-8?B?a1ZSWHpGOUoyV2dnR0k2U1NLYTl2UDJGbjh5QXhxOFo4ZEpwRUJsQkVTVHhB?=
 =?utf-8?B?UitIZVYxUVdRaElTbThRaEpPcnZqRzhBMkQyZ1hQK1diUWdaN1JrTlVLQzFV?=
 =?utf-8?B?cTNZSXQwOU1pV0JmaXhvd0UwMXFHa1dja21IVGFrY0Z0eHVpUmFla1ZIYkl3?=
 =?utf-8?B?MkFOV3I2QlUwOUtHQTN0R1IxUFN2K3VIUExrV1hpSG83SmdabWNrSFRsWVlQ?=
 =?utf-8?B?NDhUVVg5RXZKUGw3TGVDWG9nY2lETmNLcmRHRXJwUEo1eHh6Z05DQXhrUnNG?=
 =?utf-8?B?SGc0eHBBbjJzV3dHN05mNmFlOENxQSsweGdSNlV0OUhjbUgvZXNaaFYvZ0lz?=
 =?utf-8?B?eU1JbGpkU00wNGJZeHMxeDk1d0svaEZjVk9wampldi9GYllyYUlPUFF0UWh3?=
 =?utf-8?B?dGROS1YrT2FYeGNQQklYU2VjalZxTTVVKzBMY0QwZXdxQms0MzhXeVVZOVB4?=
 =?utf-8?B?N3lqRElqb2hodXRXNGY3Uy9CMTlPbWF3V1B4L2g2U1RIUm5zTWl1RXRmWWh1?=
 =?utf-8?B?UDQ0RVVLRXdQaUJ2VklKbVh2MFdlZms4dU96QmE2Z040bW4rY2xNdGFQMFVa?=
 =?utf-8?B?T0czanJkZWRoZ3JZeCtJYmpuK3pSRWRJb2RtZFlqYnk4SkViWXA1dmQwbjNJ?=
 =?utf-8?B?QXpKRkExcUowSEgyNnM3eEIxZFhRWjlNSCs4QVRkRFNzVEhFa0ZyZFM3dGE5?=
 =?utf-8?B?UFVYNW5MMHpyKytaQVpROEg3OVNlNGFBdUdIUmVEclFNc2ozNDliU2I0TFp3?=
 =?utf-8?B?Y3pQRWZuMXdSRFlHYkd6TERvVFZReXFlRGVPR1FHMVRiYmdsemtUL1dPSXdV?=
 =?utf-8?Q?hPyUv73X?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlZWZnFuNExwYkJaQTlpOVZkMkRhUjBING5zTXVNbHVoQUxvS3VMMk5DaVYw?=
 =?utf-8?B?MXAyTzk3WEVxWW85aDV1R3JPemNheldycHI4NXRvR3lpdU4xc3FzaUkyaVdz?=
 =?utf-8?B?RDVGNnZ6OTgyMEVzc2E0cVJFbFBvTDYrZXRYR3FFdklIUU9pcTgzeEFPSGU4?=
 =?utf-8?B?eFJYdXQrajBQZjdOS1RaaVk5ZlQzUUx2SWVnczVUM0ovRGhLVmFNeVNvQ2l4?=
 =?utf-8?B?NU4vV1EvZHY3TU5oNVdBQ1U2QUdaSXlZRGxDMTFOek5nM2pnYXpwTFBNbzlV?=
 =?utf-8?B?NDlHUUdWS21QcVdod2FHN0FlNUVEbnZ6UDNCUnA5VFZYSlBCMFRwdVdOTXZ2?=
 =?utf-8?B?NEpYMU1DdlRuMEdjcXNQTmpKcWlTd3VRazhhTWlvWFdEU2wrTkd3anI1aHZk?=
 =?utf-8?B?MDlUUUlkcFljR01DZnNhYTE0R2krUW8rRVB6ZFJnUUJNTzVNdTNxOUE5NkRi?=
 =?utf-8?B?M1ZSRTl0d0dDVTVCODZvZlBMUEg2S0o3NDc5UGxiOHZyQTBQRXhPemhmUFB4?=
 =?utf-8?B?WFJMYzQxZHdyV3VsbnQvUmxMU0c4UDJpTEk0SFFTbHpYclR6RVFPdWhPNkJy?=
 =?utf-8?B?QlR6N2JjNVlrOWxVVUpyWm43Uk11ZGpGa1dYcWdFSGNDQWJSSXRySDEra05K?=
 =?utf-8?B?dkhBaEtkT0k0b3doam1LMWhpeitwc3RoR3A1a2RKUUpTUklGVXBvbTVSL0p0?=
 =?utf-8?B?blVpUkwyT2JFQU1vR0wzRGxjdDIxYkRQWFh1bnh4ZXczY2NVWUNjRzd6SWdY?=
 =?utf-8?B?R3BybHBQU3Y0bTRNRk51dVIrTTU2NWN3Wko2VW1hWGFSQ2ZFaWRSTldJN2hS?=
 =?utf-8?B?VGxEbnBTR245Z21WWTkySkpQTUtJOUI2Rmt6YzdvMnA4WWVHUEVlSWROaWZJ?=
 =?utf-8?B?bS9DNVlDZ3B4V2tUcWgzMW5mZUd2aU0rcVdjVXNkWjRtMmZRYUozb1JQRGYr?=
 =?utf-8?B?UUlPakhselpNeVJ4MlpRNDlOTjBSYmFkQUNkZnh3dEtPbXdKWUtKZXR0REEx?=
 =?utf-8?B?YjB6cFlFZ0tjRnZENlBDazEvTzBuRzVSZFBNT3BibCt3TDFoOE45VmJ3YWlC?=
 =?utf-8?B?eWFGVmdaeUxjbE4xR0oyQ205YjVEZjJMVVMrczhQUlRXeUE4WUlCdzlrb2Ux?=
 =?utf-8?B?ek5oVjJiWkxNWFphdDR5VGxPbnkrY3lndUpaQm95MjhheWVXWklRWTJIbkw3?=
 =?utf-8?B?cVJVcTFzeEllcVhwTGpnWUJiVGxLdHd4WnQ5a3pta05yV3hvMi8razE0TnVU?=
 =?utf-8?B?M3k2dVNsWFloTm42NGN4RFJIVFZ4ZnJoNXpnMGN0RHdVclh1TWpaSzRKRFZt?=
 =?utf-8?B?SkxsMHZYTGE2UGVUSUloYlJ5UEk2MDE1K3dVcFQ5NzlJdTV1bStrZVk1UFBN?=
 =?utf-8?B?K0svOU90RTJLeHI1MmtUTHJFejh1cGNRcU5jaUlmejFhV2cyQldiK1Jaa1Rn?=
 =?utf-8?B?MWZyMWd0QW5xZkpFdWhreFVVNnlmelNtQklOYWo3QWVOQmpTeHlLeEgwbTdH?=
 =?utf-8?B?YkdsYXBMdnE5OWdHWlhLV2tmNFR2UWM5NVk5ZWhmL1FjUlFkYk1KVDVJWlh2?=
 =?utf-8?B?RHBiUkVsd282Ymc2S1BXM1ZzdDZrRTdBcnQxZnpXTnc3Y2xNNU1URmZLeEYz?=
 =?utf-8?B?cDVlMEVjbTcyN1hqUVcwbThMbGt2Uit5ZUhIQ2QrcExCaTVyRDkzRE4zd0Jv?=
 =?utf-8?B?ck1BMk1TOG5rSVVwWVIwTkR2alZ6Tm9KWGlsRS9saDFHbytaRkg5bEgvRnk1?=
 =?utf-8?B?UUpFa0Y1R1lyVXZ4eUdhUmJuL3FzaDZubDVuVXQ4dThjY2NmWFpOaTdtWVFE?=
 =?utf-8?B?ZVhXREhYd05MRDdvZ1RpbWVzWHhwV0I4NmhBM1YzYzB4WDIydUZYWFA1ZkVx?=
 =?utf-8?Q?5cxLF8a1Ec0mQ?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1144db51-4994-439d-3822-08de9b8629f6
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 07:02:47.1479 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1PPFD1DAE8B78
Received-SPF: pass client-ip=2a01:111:f403:d40f::3;
 envelope-from=nutty.liu@hotmail.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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


On 4/16/2026 7:37 AM, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
>
> The stack pointer is being truncated as 32-bits for qemu-riscv64, so
> let's use %p to print the syscall pointer argument.
>
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3238
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
> v2:
>   - Remove the custom read/write print functions and use %p instead
>
>   linux-user/strace.list | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/linux-user/strace.list b/linux-user/strace.list
> index 35f001fecd..6162a407f9 100644
> --- a/linux-user/strace.list
> +++ b/linux-user/strace.list
> @@ -1114,7 +1114,7 @@
>   { TARGET_NR_quotactl, "quotactl" , NULL, NULL, NULL },
>   #endif
>   #ifdef TARGET_NR_read
> -{ TARGET_NR_read, "read" , "%s(%d,%#x,%d)", NULL, NULL },
> +{ TARGET_NR_read, "read" , "%s(%d,%p,%d)", NULL, NULL },
>   #endif
>   #ifdef TARGET_NR_readahead
>   { TARGET_NR_readahead, "readahead" , NULL, NULL, NULL },
> @@ -1674,7 +1674,7 @@
>                        print_syscall_ret_waitpid },
>   #endif
>   #ifdef TARGET_NR_write
> -{ TARGET_NR_write, "write" , "%s(%d,%#x,%d)", NULL, NULL },
> +{ TARGET_NR_write, "write" , "%s(%d,%p,%d)", NULL, NULL },
>   #endif
>   #ifdef TARGET_NR_writev
>   { TARGET_NR_writev, "writev" , "%s(%d,%p,%#x)", NULL, NULL },

