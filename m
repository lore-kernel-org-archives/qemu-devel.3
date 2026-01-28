Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 662E2D3F069
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 14:12:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl69c-0004tp-8k; Wed, 28 Jan 2026 09:04:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1vkxHb-0005GT-Dx; Tue, 27 Jan 2026 23:35:59 -0500
Received: from mail-japaneastazolkn190130003.outbound.protection.outlook.com
 ([2a01:111:f403:d405::3] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1vkxHZ-00008l-F4; Tue, 27 Jan 2026 23:35:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eaPblamaj7y0YHoZ3nGdVjbwMZyITARROh7khd6IwVyObiw2SDLg2jbaSuNPJpK0334SAaeRaEWv+PwOXEwt6+J71Zx5vWLMVvqIFEeX5JK+C26VxqZF+DfKACQC/ZzeNs9pcY57P0ZD7MMp9NEx8ZazzT2ZzZgWTWzaLVUM7jOUpw2ouLOL+4doIXnrWbl6jDPR0vI9zaxdA9e3eIwizrESawc5xC4eSwwHzm+/8fBb2qAb/8CNEvtLfSuaAxq1pGlI1lY7wK/27P9pG8bZ4JEg/hG0r+sf9AKIRYKawnFI/Ui9X4HSUxS8wvK9HzH7WiUB3U/royGpYjWFNBvQpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nkXl5BhteRLVakUwqLfoGnIf/Yl5Mkr7ggqdPuzRZt8=;
 b=awZbmAmxlZO9ybrPtCCMLrHP5tasUGhakcYsuFXcU4Bgls+cysSEYkjwKmUr8QdGtC9hsQlNxjWaMzSTDFRDUgUkMAPQPRKiji1PqvMd9FRPFGftzm5HzTpcRWeC1xE9dtGhqOH4ifxW9S93EXEid6fXJgQNCqlBSL1prVof/oXOI1Zm4ETyCaz6GxlLPVTtePACQC0f/tS3OpinUKRgQuZXWRCfEVxbFMt/Ak6oqKZ3VQROumgpqxjjt8UezXfEXuTd/qlCNc25Bf7rKEnnOcgREunXiV7MN7Z3jmtP5M83HULFLAKUAOTWr6M2hQXoeLbefs8hegm5cNJFvpRaPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkXl5BhteRLVakUwqLfoGnIf/Yl5Mkr7ggqdPuzRZt8=;
 b=el2WVytXe1uMvAW7+tGYfYvelTL0i/5cjpqfiATb7M9HOs6R4nbZ1X695tFvVVHokdmssEGXYvXCXyFsHCXxMCRpqYwqDsI6YGF2HSYPZyVHqc9Tk3aGM99JPib1FzG4ndldZUoXEleL1IafV9nhPswZNJW8L7IoXsEwV7YKsASEXqkcKNA11XnP5/+44wPmt+U/PBEdwU3CtjWqQPnYC76c9xeRkO0WLU9ybg1GGH5EfEzB+n6V/rTjGtopclabHfPFbFEq79ygKsDhECnVQzm2B8o51R6wCs6ztGjfPBqjXX/lXHdyADAqfVxKU17tEctK8YcbHFptk1tnkG/dWA==
Received: from KUZPR04MB9265.apcprd04.prod.outlook.com (2603:1096:d10:5a::6)
 by SEYPR04MB8998.apcprd04.prod.outlook.com (2603:1096:101:2da::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 04:35:49 +0000
Received: from KUZPR04MB9265.apcprd04.prod.outlook.com
 ([fe80::3c38:c065:daf4:cbfa]) by KUZPR04MB9265.apcprd04.prod.outlook.com
 ([fe80::3c38:c065:daf4:cbfa%5]) with mapi id 15.20.9542.010; Wed, 28 Jan 2026
 04:35:49 +0000
Message-ID: <KUZPR04MB9265651CB41E7D2CD7CD30C8F391A@KUZPR04MB9265.apcprd04.prod.outlook.com>
Date: Wed, 28 Jan 2026 12:35:39 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/riscv/aia: Provide number of irq sources
To: Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Sunil V L <sunilvl@ventanamicro.com>, qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Michael Ellerman <mpe@oss.tenstorrent.com>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Nick Piggin <npiggin@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org
References: <20260114012846.981884-1-joel@jms.id.au>
 <20260114012846.981884-3-joel@jms.id.au>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260114012846.981884-3-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:54::13) To KUZPR04MB9265.apcprd04.prod.outlook.com
 (2603:1096:d10:5a::6)
X-Microsoft-Original-Message-ID: <8dc49af2-624b-47aa-8c62-52c7d70e7fbb@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KUZPR04MB9265:EE_|SEYPR04MB8998:EE_
X-MS-Office365-Filtering-Correlation-Id: a213a2a8-f8ca-49df-d0b9-08de5e26b658
X-MS-Exchange-SLBlob-MailProps: qdrM8TqeFBv5zL3Pq3ogIg0sNnRYStpo7lruchUQvmronrmP+J2wCLC+WYFuiuHaoIifJ8ianaVced2XH5B6L/av0J7vK7ZO4Jm9OPIrFsLLpwuJBNrqOKUqBRL7WoNh9Y8WELat5zT8mKxReBnujMseQyVh261X6xn+f2aMWgd0VuoUcpW1CyoWlNWI3cIfWUuVCkvGzjqhqgkYKf4Mf86Qygvy58XG7PCBqYVcSuLAnajs5p2pO4XvaG5h3887EmMy3Zmz9WHTBFmFxTnhmJW/FYwR8HH/X4QlPUThGhxopB9j/8QnpnfmRkDeaXjDBXVIG3wuVhW8Pn+zwJ2bKkiwYDKIfHbfBwI0tpiVIaPEXrQfQvg7hqq6iU7ecrUpJLvDq9Q4P517GSzHqqNZswlMTzEDfMaOD4YmrQ8FLuJQfvntXSqfcLaY7GRbg0LEFIvyBMj178w9tYUjtUMg0tXQILCdnYfWnmsQ/ufJKmsjgDi9HNK+U2j9NghFx5GemPyd6sjzMWTC5RXRB9THYYrBn2daw4asN2PBSTI6QGr//QmDr2BQU98RCg182577n8PNLs1GsoxVqMovhjDUYuUJ6mH+PtFjyKQEZ4jBiqN97DsitvXX2dqVT3G6weuEl6Okv0urIgyKrPtmyY21TdPDNSDD2RetFB1T9eeI2ZDFVnVZ5lOYLY/pwkG+viG58qCV2oOqLGGZIAywMqfCF53xkDQerR2TjEG1sOxCPDGkmf/0DPY9f/AHUKKE7Hw4gRAiIb6T+VsjjpIJmoyF8aq0Lr1di4rJ
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|7042599007|23021999003|19110799012|461199028|51005399006|15080799012|6090799003|12121999013|5072599009|8060799015|3412199025|440099028|40105399003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VzFWeWxFYlJGOElsd0NlWkJuSnJzNjhwVkRkNUU4cXFQVFpnaE45b3RmVUxB?=
 =?utf-8?B?MXlVNVZLS3BOMmpWdnUweHdraHhOZURxNStCQ01hdFhLMVpJbTZxVXc1ampJ?=
 =?utf-8?B?d2RoajViWjJhd25OMjlGRlR5dXBFcExDdGo1RnlNeXFmek5ucmVxak8yRUNl?=
 =?utf-8?B?WkFEMSs4QTdlVjY0cTlNRFhVRUlORi95RE9yaEFGY2lHR0YyWDlvdTNva0J2?=
 =?utf-8?B?dE5yUGlJc2NuS1Q0UUlXQTdFcFRzazU3ckg4UHFCNG9Ydi9VY0taM1ErVVJk?=
 =?utf-8?B?blJyRERqMVFscnEzZG1Sd2oyV3M1OVNxbzBGYmhmNTFucW82Ui9HQm9TbmFF?=
 =?utf-8?B?ZGVSNGRrOFNiQnVGdkR3WEx5QnplVlg1UUxHbW51YUJPS09nUWpseDN2QnlM?=
 =?utf-8?B?emVVWTRuejJkb29sMGw2Yzd6TGJJQWhGaXBwa29VOFhhVTdvYzluQ2ZkWFpE?=
 =?utf-8?B?aFVZYkFKemtqazVTWmVLc0NpUm5BQWNsWEYyK05na1pucW9LWDhUcXB0RkJW?=
 =?utf-8?B?YW5va3BTNUdRbU1hdytkdDZWOG9GakhvcTROWUFQTGw4eHBQb3MxdHorV3lv?=
 =?utf-8?B?Q1dJNE5MTkN3TUJuZTl4ckhWWWVGYytZaEhQN2owRGtVZncwcHVBYVZIR1hu?=
 =?utf-8?B?T0FuZVhwU2FMd2Z1UDlaMXQycXhCV01vcS9vZUQvTjVXY3A1TTgya0VtaE40?=
 =?utf-8?B?UGtYWkdvaTduWGdxK0pnRCtFMVFJSWxBakJBLzUvTWcwalcydVNZdk9MNmZL?=
 =?utf-8?B?MzhRSm10dEdLSWM2bHJHbzRta05BczFJTU9GbzZlT3lvMk9Jb2dsNjNMTnJ5?=
 =?utf-8?B?SWxyUVBQdHlzcEtYZDZ2WmpwS3dyb3pmdjU1MnR0QlZWWUhmQkFYenhuOEN2?=
 =?utf-8?B?WWJrSjRoNm1GWFpiUnFKL3c0bERmOTh3Y2ZFSzNPTmxGWFNraEQvNDRQWVVt?=
 =?utf-8?B?WjVOOUxOWlk1YUllK3h6bVQ0NDdUZ3NOTlBvMnJiUmtKM2tBWG5UYmQ2ZlpS?=
 =?utf-8?B?Si8yQkZVNXRPN1BQUFNVUFRRQ0t3RnN4THI0TTg1ZktEN2U2aXlBckt3dHhI?=
 =?utf-8?B?YlRjcGtZN2pwa08zZlNqaDIyRmJBM0JsUUNMbEZzQkZOcWVXZHhWL3NZRXM5?=
 =?utf-8?B?M1BjVzkxRnJKeWJXalJkcjErZkVSNHA0Y3lFWVZGS0ZFc2h4TUR1RGVEbXYv?=
 =?utf-8?B?S0FDRUNKdzFXa2lVdGY3UFVEaVlBeXFiTTMrOUZ0MVRBT05Hbm51K3Q4ZEVB?=
 =?utf-8?B?V0hIM0UyZHFOZ0pCaUk5U0tRRnFEaVlaT2JzcUxjVE52dGJDeHVzd2Vaejg4?=
 =?utf-8?B?Z2R4V245QllUaWoxUC9UNXZXZUY3Q1loRW1DRlU2VUlCWkNKRFZkU2NYK2Zz?=
 =?utf-8?B?cGc5ZDIwU1dvVExMbCtKRVZWZDdIQ0toOFlqOU9vaG9kcWxoeDRUSnc1WmRz?=
 =?utf-8?B?RHV2SVFSZkhvcFg5cTFDU1ZxSlhwN3p6SVRadGYvSkNrL3ZxZk55dHp3MEg4?=
 =?utf-8?B?MXJCSHJEU0ozNEtYdmwybklWaWNiTlRQZWNqY1ZOdThyWUJPSW9KMTBoU25F?=
 =?utf-8?B?K2tBZG1oYlN0bFJnSzRBa001OVczVTh1c0YrR1dKek5tbnF3bitvVTF1ZTQx?=
 =?utf-8?B?V2ZSSWhhd3JXSEJhZE9xOWRXZVc2TDlRdHBzVnFNU1ZqRnBiZFVuQVgzWWVU?=
 =?utf-8?B?N3FKQXA0ZDlUWjUxMTh1eTRmSWZSSHl6Q1FJR1hscThWM3JrL1JIcGVnPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SW5uNUlsVnZKV2NBR2dOVUZNY0wvR0dJS0JsOHdHNmZCZFBTd0RQenZpbjF4?=
 =?utf-8?B?cnpONW5mWjhETE9ucEQydVdpL0lYdGs0NTlvelhQajdxL1UyMkVneksvdHlI?=
 =?utf-8?B?MHRMMFZYU2xDUy9jUTRYaExZTTc1dnRtRXorbmQ5QkxnUk5RVXRDZnk2SWI4?=
 =?utf-8?B?UEsyYi9lUGtZMldvUGp5bEhhS3ZSc1Y5K25CUjhBQnFKNUlvWTR6bkdTQ1Uy?=
 =?utf-8?B?dVNtSVdzZVZVcHJod0d3bU1VQUcyZWl3SUxOS3VuM1ZrVms1R3U1ZGtvMUl1?=
 =?utf-8?B?QUlqNUNhTER1M2szeHN5VzJyRFJMVVo2YjJCcERVbGxmZ3JuaVk3REZjZDRv?=
 =?utf-8?B?TzNPMkZ4WFFGRFk2ZUhpK0YxdVEvS09XK0tYRmJaV1hoL2Y5bjl2cVgxby9i?=
 =?utf-8?B?OUhrQ214N00xMTJoelVmQXNPc2t3OWNvb0lCYUZtZFdKZFNFL0lLS3hxOWRs?=
 =?utf-8?B?U08rNTVxQ2F5bSt4WWdsMzM1WlR2U24vNm15bjFKSy8rYWF6U0NzR29iUkp6?=
 =?utf-8?B?TzB3MU5LNStZNzhDaG5ldkU5dS8yMHMvT0NWSlFoS2hvY1pZcU1PeklyOXQr?=
 =?utf-8?B?WEFkT3BMUW5LTGg0VVVBd0tEM3RzOURRMVVScERqVFNSd1dPSjE0SFVNbU9Z?=
 =?utf-8?B?bHp3ZjFFS0FrVG0xQjh3dzdrRDJpdW90UkJkbTB0MTFmb2dWV2VDRmZCSDNN?=
 =?utf-8?B?YXBQbFJQLzBCVE02NE41ZzNiMVYxYmZ6QmNUVVBIUk50MkQ5VHpLck1PRm5v?=
 =?utf-8?B?d0dHTEJ6eVNEMG9RbVg4alczLzhET2FRZkxETUdETDI2YUN6YXRtN2FrMHVp?=
 =?utf-8?B?aEMvYVhsekVEbWNoKzIzbmdKNE5TTFZrbjVwcXErdDdaR05vSzBOaUFWaXdS?=
 =?utf-8?B?TU9Lak51QlAybjljaWNDUDFkRi9ya0VlN0Z3cnZMRlN6eVNZR2htZ0tXMmdh?=
 =?utf-8?B?d3B4Nmd0UDFjZGVuK1RiZnk1S0U4VGYrRFMza1dSaDBhVC9kOGxvT294UjFU?=
 =?utf-8?B?b3YyVm1OeS8xck8wL2JKWWhJUTA2RVYzSC9QMHpGQVpMU2tnai85SkJHRXVo?=
 =?utf-8?B?ejVZZTRsNUVOdXhUVXA3Y0g4RllZcEhCVEZ5ZlNTSEV1L1A2MDV1TVJuaHNr?=
 =?utf-8?B?ZFBpVjZPRzN4MnNCYkI0WmgyVzlEZTQ2UXhPWHdNcUJoQTVkVzExUmlBUHhx?=
 =?utf-8?B?UXo0TnFmNWR0bE1qY2FuZ1p6S3NUWDFsZkpTVTliQTYxZ2Y3Rm9VOEw4NGwy?=
 =?utf-8?B?MkVJTVFsdDJySEJpWUtkaHhJcVVPZGQ0aDBRN0IzTjVPL0tHa0lZVVJlVXdB?=
 =?utf-8?B?dHdlN3Y4MFZEalQ5NG1FQS9nNDNjSmJlc0UzWTVBQkpTemVXbHh1aDJOc2Vn?=
 =?utf-8?B?MFZvWk8yZHFxaGFUd2RxaURqV25sSnkvQlFTTmRoeFdPNjNTKzNOS2dHOHV3?=
 =?utf-8?B?cHB5ZFRVT2p2Y01QSU95THRPUnhWbXBjVGNJSUpManVSY1pRUysvUERheFRS?=
 =?utf-8?B?amFBRExVMU44c3pBTTR4Y3A1TTM5ai9UOGJ5SXVSMzBEd2UwcTBoMTBXeCty?=
 =?utf-8?B?UXlQcWhYM1o1eFVQYUZZWXBVa01pT2RMaVJ6MFpkLzg4ZjlkLzE4STl4R29H?=
 =?utf-8?B?aG5UTXJaMlVaYVl1RkEwZzVFMkJINHo5SUFOcHd1ZTViSVFiSjNHWTkvdW94?=
 =?utf-8?B?SzNCZG43Z2p2eXM2eDQvNHdKb1Z1M0sxV0xlVExzV0pnNUxrZk1yRXpHblFF?=
 =?utf-8?B?d3ZWTnpBc1U3R2Q0TzVpeERqaCtVSk1peENBMHI2MFRHbkFHMFZudnBKSWc0?=
 =?utf-8?B?OVJLUExDM2Q4eHJaa2NMRzFtaDR1U0VZbU5aZko1aUhacm4zM3lFWXNKSDZy?=
 =?utf-8?Q?Dnii1EDf5gduh?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-515b2.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a213a2a8-f8ca-49df-d0b9-08de5e26b658
X-MS-Exchange-CrossTenant-AuthSource: KUZPR04MB9265.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 04:35:49.6283 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB8998
Received-SPF: pass client-ip=2a01:111:f403:d405::3;
 envelope-from=nutty.liu@hotmail.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 28 Jan 2026 09:04:18 -0500
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


On 1/14/2026 9:28 AM, Joel Stanley wrote:
> Instead of hard coding the number of IRQ sources used by the APLIC pass
> it in as a parameter. This allows other machines to configure this as
> required.
>
> The maximum number of sources is 1023.
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> v2: Add assert for the number of irq sources
> ---
>   hw/riscv/aia.h             |  1 +
>   include/hw/riscv/virt.h    |  1 +
>   hw/riscv/aia.c             |  8 ++++++--
>   hw/riscv/virt-acpi-build.c | 25 ++++++++++++++++---------
>   hw/riscv/virt.c            |  2 ++
>   5 files changed, 26 insertions(+), 11 deletions(-)
>
> diff --git a/hw/riscv/aia.h b/hw/riscv/aia.h
> index 50c48ea4d79c..a63a1ab293fe 100644
> --- a/hw/riscv/aia.h
> +++ b/hw/riscv/aia.h
> @@ -48,6 +48,7 @@
>   uint32_t imsic_num_bits(uint32_t count);
>   
>   DeviceState *riscv_create_aia(bool msimode, int aia_guests,
> +                             uint16_t num_sources,
>                                const MemMapEntry *aplic_m,
>                                const MemMapEntry *aplic_s,
>                                const MemMapEntry *imsic_m,
> diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
> index 25ec5c665780..fa7fe8d4f648 100644
> --- a/include/hw/riscv/virt.h
> +++ b/include/hw/riscv/virt.h
> @@ -64,6 +64,7 @@ struct RISCVVirtState {
>       struct GPEXHost *gpex_host;
>       OnOffAuto iommu_sys;
>       uint16_t pci_iommu_bdf;
> +    uint16_t num_sources;
>   };
>   
>   enum {
> diff --git a/hw/riscv/aia.c b/hw/riscv/aia.c
> index 0a89d7b49b7b..a9130896fba2 100644
> --- a/hw/riscv/aia.c
> +++ b/hw/riscv/aia.c
> @@ -25,6 +25,7 @@ uint32_t imsic_num_bits(uint32_t count)
>   }
>   
>   DeviceState *riscv_create_aia(bool msimode, int aia_guests,
> +                             uint16_t num_sources,
>                                const MemMapEntry *aplic_m,
>                                const MemMapEntry *aplic_s,
>                                const MemMapEntry *imsic_m,
> @@ -37,6 +38,9 @@ DeviceState *riscv_create_aia(bool msimode, int aia_guests,
>       DeviceState *aplic_s_dev = NULL;
>       DeviceState *aplic_m_dev = NULL;
>   
> +    /* The RISC-V Advanced Interrupt Architecture, Chapter 1.2. Limits */
> +    g_assert(num_sources <= 1023);
> +
How about the below check ?

     g_assert(num_sources <= VIRT_IRQCHIP_NUM_SOURCES);

And modify VIRT_IRQCHIP_NUM_SOURCES in "aia.h" as below ?

     #define VIRT_IRQCHIP_NUM_SOURCES 1023

Otherwise,
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
>       if (msimode) {
>           if (!kvm_enabled()) {
>               /* Per-socket M-level IMSICs */
> @@ -65,7 +69,7 @@ DeviceState *riscv_create_aia(bool msimode, int aia_guests,
>                                        aplic_m->size,
>                                        (msimode) ? 0 : base_hartid,
>                                        (msimode) ? 0 : hart_count,
> -                                     VIRT_IRQCHIP_NUM_SOURCES,
> +                                     num_sources,
>                                        VIRT_IRQCHIP_NUM_PRIO_BITS,
>                                        msimode, true, NULL);
>       }
> @@ -76,7 +80,7 @@ DeviceState *riscv_create_aia(bool msimode, int aia_guests,
>                                    aplic_s->size,
>                                    (msimode) ? 0 : base_hartid,
>                                    (msimode) ? 0 : hart_count,
> -                                 VIRT_IRQCHIP_NUM_SOURCES,
> +                                 num_sources,
>                                    VIRT_IRQCHIP_NUM_PRIO_BITS,
>                                    msimode, false, aplic_m_dev);
>   
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index b091a9df9e0f..350912903174 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -144,6 +144,7 @@ static void acpi_dsdt_add_cpus(Aml *scope, RISCVVirtState *s)
>   }
>   
>   static void acpi_dsdt_add_plic_aplic(Aml *scope, uint8_t socket_count,
> +                                     uint16_t num_sources,
>                                        uint64_t mmio_base, uint64_t mmio_size,
>                                        const char *hid)
>   {
> @@ -151,9 +152,12 @@ static void acpi_dsdt_add_plic_aplic(Aml *scope, uint8_t socket_count,
>       uint32_t gsi_base;
>       uint8_t  socket;
>   
> +    /* The RISC-V Advanced Interrupt Architecture, Chapter 1.2. Limits */
> +    g_assert(num_sources <= 1023);
> +
>       for (socket = 0; socket < socket_count; socket++) {
>           plic_aplic_addr = mmio_base + mmio_size * socket;
> -        gsi_base = VIRT_IRQCHIP_NUM_SOURCES * socket;
> +        gsi_base = num_sources * socket;
>           Aml *dev = aml_device("IC%.02X", socket);
>           aml_append(dev, aml_name_decl("_HID", aml_string("%s", hid)));
>           aml_append(dev, aml_name_decl("_UID", aml_int(socket)));
> @@ -469,10 +473,13 @@ static void build_dsdt(GArray *table_data,
>       socket_count = riscv_socket_count(ms);
>   
>       if (s->aia_type == VIRT_AIA_TYPE_NONE) {
> -        acpi_dsdt_add_plic_aplic(scope, socket_count, memmap[VIRT_PLIC].base,
> -                                 memmap[VIRT_PLIC].size, "RSCV0001");
> +        acpi_dsdt_add_plic_aplic(scope, socket_count, s->num_sources,
> +                                 memmap[VIRT_PLIC].base,
> +                                 memmap[VIRT_PLIC].size,
> +                                 "RSCV0001");
>       } else {
> -        acpi_dsdt_add_plic_aplic(scope, socket_count, memmap[VIRT_APLIC_S].base,
> +        acpi_dsdt_add_plic_aplic(scope, socket_count, s->num_sources,
> +                                 memmap[VIRT_APLIC_S].base,
>                                    memmap[VIRT_APLIC_S].size, "RSCV0002");
>       }
>   
> @@ -489,15 +496,15 @@ static void build_dsdt(GArray *table_data,
>       } else if (socket_count == 2) {
>           virtio_acpi_dsdt_add(scope, memmap[VIRT_VIRTIO].base,
>                                memmap[VIRT_VIRTIO].size,
> -                             VIRTIO_IRQ + VIRT_IRQCHIP_NUM_SOURCES, 0,
> +                             VIRTIO_IRQ + s->num_sources, 0,
>                                VIRTIO_COUNT);
> -        acpi_dsdt_add_gpex_host(scope, PCIE_IRQ + VIRT_IRQCHIP_NUM_SOURCES);
> +        acpi_dsdt_add_gpex_host(scope, PCIE_IRQ + s->num_sources);
>       } else {
>           virtio_acpi_dsdt_add(scope, memmap[VIRT_VIRTIO].base,
>                                memmap[VIRT_VIRTIO].size,
> -                             VIRTIO_IRQ + VIRT_IRQCHIP_NUM_SOURCES, 0,
> +                             VIRTIO_IRQ + s->num_sources, 0,
>                                VIRTIO_COUNT);
> -        acpi_dsdt_add_gpex_host(scope, PCIE_IRQ + VIRT_IRQCHIP_NUM_SOURCES * 2);
> +        acpi_dsdt_add_gpex_host(scope, PCIE_IRQ + s->num_sources * 2);
>       }
>   
>       aml_append(dsdt, scope);
> @@ -576,7 +583,7 @@ static void build_madt(GArray *table_data,
>           for (socket = 0; socket < riscv_socket_count(ms); socket++) {
>               aplic_addr = s->memmap[VIRT_APLIC_S].base +
>                                s->memmap[VIRT_APLIC_S].size * socket;
> -            gsi_base = VIRT_IRQCHIP_NUM_SOURCES * socket;
> +            gsi_base = s->num_sources * socket;
>               build_append_int_noprefix(table_data, 0x1A, 1);    /* Type */
>               build_append_int_noprefix(table_data, 36, 1);      /* Length */
>               build_append_int_noprefix(table_data, 1, 1);       /* Version */
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 01115a0fb946..e5df5a5d4638 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -1556,6 +1556,7 @@ static void virt_machine_init(MachineState *machine)
>           } else {
>               s->irqchip[i] = riscv_create_aia(s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC,
>                                                s->aia_guests,
> +                                             s->num_sources,
>                                                &s->memmap[VIRT_APLIC_M],
>                                                &s->memmap[VIRT_APLIC_S],
>                                                &s->memmap[VIRT_IMSIC_M],
> @@ -1690,6 +1691,7 @@ static void virt_machine_instance_init(Object *obj)
>       s->oem_table_id = g_strndup(ACPI_BUILD_APPNAME8, 8);
>       s->acpi = ON_OFF_AUTO_AUTO;
>       s->iommu_sys = ON_OFF_AUTO_AUTO;
> +    s->num_sources = VIRT_IRQCHIP_NUM_SOURCES;
>   }
>   
>   static char *virt_get_aia_guests(Object *obj, Error **errp)

