Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A60F8808E
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 07:04:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDGlX-0002Tg-Et; Thu, 16 Apr 2026 03:03:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1wDGlU-0002T6-W3; Thu, 16 Apr 2026 03:03:53 -0400
Received: from mail-japanwestazolkn190120001.outbound.protection.outlook.com
 ([2a01:111:f403:d406::1] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1wDGlT-0003xE-CP; Thu, 16 Apr 2026 03:03:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cWhi7RiEIpKcnCnw8jXZH7Ykj5BhbjVdaJte8eYRkCy6lmqQ5ljcJB2uKRXGn1eiLmd2xA2OBbD8daspUnCmXPSdIC/CiWPZdbvE91zUV+gph7KwZt9CHIIi/GEnKxZP5MIpyEFTWYMjdA4kJVKMm1dao9S5pp2GN2WrAGJDvbw2WVSwGl/5Hc2BVchhczatBShDtdGocS0kO4hfAMuURzoG9AwQYQf2gNkkuYnKsWHuvsbzDM7MIiLd+Ny/H759QiL9oMKtysaYtjcl/+99x8ZNr0MrG0A8pbV5e1vuGdINnhA/6lsKC1uMdKRj1Y0USx6MvfiKZaC5T3CToh/QUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4efgixHKHtBw6+uxCB+AkF/y01/i/X3OdlMO8a3NsrI=;
 b=sIJlaw4zkTXMuHm8q37o2HZS2tdMHuokEAKLabOY5Lwb7IpcMLh/BdD5m07cLUfbF0ConRyvjwBxlQjV9/ecxoAHG2E/y0Ng3ZTcS1Kxu/GgW/ZrODUoyQMMTyjpOCAjl1od14TJhEmmtL0Ii6YKSjOh8VPDz88cPwFchGP177JgaTp6hDL+ZBbaRbDr9boX3HEmLPLJyNZB7DXktcRaINPeio4OewoQQyaGnjz4X49cgSh1nRn7yWo8PoDlxhdkvRFm3ggs9irreUcWK0XIVuPSpHTJKfuLgZgXDYre3cq3kbN7LE+cy5kPt0E3UVD6Wx9ATxSjw/XOb4KzUQQQRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4efgixHKHtBw6+uxCB+AkF/y01/i/X3OdlMO8a3NsrI=;
 b=d9YtM5S7ygKz3YbBcDwQazElxMXCpCTLy0Ypi1FF7YMEaoULiwXfFVSj4L9xQTKgkq18enM6rvREZRpyKs3awKjp18KNsNSd+cBUCuXODn/z+JUKH4H+sqV8mvXMe3bbShMvg9ZYanotxfPpPh44lhiCr81/vIxOvFVLaDixJtfIY5usQeKbY+P9rA6kSDApEoAKORlJvAIvA5Mk0mQia7L8ht3eBTSzWf2z0VnYLn0zIdlsoe4UI1WgeLFUYk6HCHHg5GzwbD2GlmS2E468W9s44ldkNo56l1zm0SKXLX5y9XfAIyw1t2PehA8X15F8HDqKdP7dHaPU35VtOa/U2g==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by SE1PPFD1DAE8B78.apcprd04.prod.outlook.com (2603:1096:108:1::52d)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 16 Apr
 2026 07:03:44 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%6]) with mapi id 15.20.9769.046; Thu, 16 Apr 2026
 07:03:43 +0000
Message-ID: <SE3PR04MB8922999F7BCE95938EE2153DF3232@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Thu, 16 Apr 2026 15:03:35 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] target/riscv: Don't OR mip.SEIP when mvien is one
To: alistair23@gmail.com, palmer@dabbelt.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>, qemu-stable@nongnu.org
References: <20260415233740.3027321-1-alistair.francis@wdc.com>
 <20260415233740.3027321-4-alistair.francis@wdc.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260415233740.3027321-4-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0019.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::10) To SE3PR04MB8922.apcprd04.prod.outlook.com
 (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID: <8976077e-c18f-41bb-8e13-8a7e17296616@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|SE1PPFD1DAE8B78:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b2f754c-d74e-4bb7-b434-08de9b864ba6
X-MS-Exchange-SLBlob-MailProps: +b2+gf+2pHQ90snLuOcNFdRaYlWw68RdMvQBehz3CVZefaOvZs1jZUSAIfWAS3xqNvFex5yewwrT2pV+nG+7Jk63AE/HzzMrEmfBW4x4HN7oFyvMyCI13m/c0+nVF40oYJWKeBeeGblg721kDQew1Ckz04+K6Elu25ghoAUAmf8980TX2mHjrNl7483WuON6RK4HeQGHaBe7XJVEkVMan5W3QmjSMock+0xAashPzNyeygdin1LAJ5AVcpbWj+Haln8hTBKavdFtCRqGpI8S4f/RLDRIjF9SC+d2xgHBl0bdUmH2dZ1WvURvYaAPHQNp3rzFGh8Hmq81E6FkZfkMf35zQjpReTeDdVDyr8mO4BT2SP3dmfZlci7uLK9MZGJp1v351shEda6yoiOzdsePiGba/25K4SqYriP5jE+ElY3eLjNAy95UgZ/tPK9Df2QWH/u8mtODlrBXsm2wfsk24WJ7WHurZXH//E+VVs9cBj2fktYrRV+rpY1/1rzJZHhU+4kmXieFa2MqaT8O9PdgNxWJa/Z9+k8s08+nNFNjRZi3QSNBLwAX1bWAOneg798DetLIce9HIhLohPHy2dyz9g0umUQMDDTwgu8hrxmYEjEYx7CKm1h6TNJKI/17BD+uhWJR0/7ygi5/WaMjPdbkBK8JsI5cTTPJKqmFzBFV/NVuMKg1x9+9oqMCE+6Bmx5DnW+AZNZBBGCvVQs4H8nNtkMfXGSrPOjlUMOzzURkqVTP3KPAsjar4zomLvV/mDnVGP+JQcLHXmpspAEUXYPM8/18jPKgMswPbnf+t6zUkJwCqdvy0XTS85HZWV9Yj0KInd57h+OdNHQImotR73GFMN94mJihPeV+F3iA6s1mDBL4iTtrsb7Whg==
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|15080799012|51005399006|19110799012|6090799003|461199028|5072599009|8060799015|23021999003|10035399007|440099028|3412199025|4302099013|40105399003|1602099012;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T292Q0FncFluWkxlWGhrdUlhV1RrdncwUnJrdFRhS3BsWWFCMmhvM2NoVFRY?=
 =?utf-8?B?ZFFjV2lPWG1saGpNTUc5c2QyMXB0YzdNTk9Kc1k4V3o0ODF6dW9kR1QyTWNV?=
 =?utf-8?B?WW9ORllXTVU2cVozRnZQY3dOOVoxemUxWDBmYTd2VFFmTEdTMWVDcGxRT3A3?=
 =?utf-8?B?Y2lpWEM3UXBpK0k4cHJyYnVlbmE3Y05sK3ZoRFh0OFAwd0txdFlDczNyU2Uz?=
 =?utf-8?B?YUQ3NTQyZlpRUitVeVg3REZ2OFVGZFJhcjlXSGQwenppQThMajlKWTlaQ3lp?=
 =?utf-8?B?Q0tGY2hrdWY3SUNpalpGUTF0VW5mY0x5RVFrelpRRGZMNFRTRWk3RXJrdi84?=
 =?utf-8?B?OTFoY2tqSkE2RHJRcXdYSmoxT2pPZUhwTTRVa3BodDhkNi8vRmhvZ0prcHY3?=
 =?utf-8?B?anpTUzJiRkZKekpzdnZoNnd5L3NhSDI4UXBYcHVmbU9MRkVyNFRMYzZKNDBv?=
 =?utf-8?B?UVlpZUUxSWtJSi8zUjQ5VU1VTUEvS2ZQTlFmMDUwTzgxNW01dzl6NFNYdity?=
 =?utf-8?B?SnIrTDVjZUFtWDNlU1krWk5pb2tvbnkwaEU5N2l0QXQwZWJoNVRWbkdKSFNt?=
 =?utf-8?B?SEVMQlRBYzZQZGRGTW4wK1YrdmlyQmVqbDZVYmo1NGdDTmN2aUJVQkhPeFdt?=
 =?utf-8?B?d1A5S1lKeWFOd0FadE1xQ0prd2VycTJCSHAwaHVKUXBBNVFocHBKcTFvZjg5?=
 =?utf-8?B?eHBXVSs0WEtYMjUrajVzWmtVVUVGMndlaVlkOVpZTlJKalluUHVPenNoa0dW?=
 =?utf-8?B?N29OYi9QdENTemhoTlJNemZXMkFvYklLRVArTks3czlwNEdoUHdoTE9KbGFk?=
 =?utf-8?B?RWY5UTU4Q0dTK3ZQT2Nna1hHckUvRFpjaWVGOW0xc1pyRmx2QUlTOEc0NVhn?=
 =?utf-8?B?NGp4eHRJZGE2NXd3QndMQkRzNTZFSWxBUVhNd1k3bWEzSE9NbzZvc0w4WlhY?=
 =?utf-8?B?MlZwNU8ya1psMkplRnRXY0pSU1VmdlBlNHdZVDRGdm9Jc3Z5NkNMZjY0UWxo?=
 =?utf-8?B?YWRUTy9aOUFpVGNmNFRyK3JYWnNoeTQ5OTllNjg0WmhnMmgzWEQ3OUkyd3ZY?=
 =?utf-8?B?b3hrM1ErVVQ0U09OaEF4ZVNlaEw2TmJaUVdSQU5TMS9KV29zQXNzalZDYU5o?=
 =?utf-8?B?azI2OHBXOVJ3c1VQZldPSlU2U25zN0k4UFZHc1lPQTZieTlpRWpyeHN3Vzdm?=
 =?utf-8?B?b0hxaVpqVFhneUVyT3VDeUNPODc3VXZLSk40ei8yVVM5MFRmSlN5UkwzNEd0?=
 =?utf-8?B?UzNqN0d3dDVRTlNkL0p5ak0zVHZRUVdNM2FpaFlUUjI3bTgwZ3J1OGs5cDZx?=
 =?utf-8?B?UzdESjN4akN0b0F3bDk0Z29MSTJ6dTJLZnRIYklIRHYrdHcwazVDVEs2em9l?=
 =?utf-8?B?NlBxbS9yalhPMVc1cGFVOTJ3S3Uxa1diNzRDeUxZVnhTQjlNSE9vSEFDWGNG?=
 =?utf-8?Q?i/zqZA0W?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGJWZnFoVVo2MDVES0lCY3VKVnNjbFNVU2s2NjNFNzJFNVY4b1Fzejd0UVBE?=
 =?utf-8?B?NDcrU3FrZ05qRFpIeWtpekxGUU5UU2FzUGNpck41TGhmY0JrQVAxS2JpaHZM?=
 =?utf-8?B?YzFDZThQVC9yVFo4a0tsSm1LdXQyQnZ3enFMdGVnOGNPZ0VtMnRDSi8zNFlO?=
 =?utf-8?B?T1lHb2o1UGVTZFM0SzIvaTBGZHRzcHd5UURKYUJSWlpIZFIxeklGaFh3OU1I?=
 =?utf-8?B?ZndOdjBsQlVBRktnbFpJQjhWK0hMNm1SZlhMc0hacnk3UEVEb2NkUDJGZkFC?=
 =?utf-8?B?emw0U0lYaHBFREZwQUIxaHhoRVdTOFlPOFJMQ25GdVZ0dXBueXhoQ2kwZHh3?=
 =?utf-8?B?ZTVobDVtNDlEd0ZiVUVPcW5HMWNXMEJ0VVVIdmdDU0Z5Tk85MnJ1d2ZnbnFy?=
 =?utf-8?B?YXZGVDJvVGF5WmlpVjJheG5FMFhBTGxVT240cTFnVFdmVGhFN1Y1bVl6aDB5?=
 =?utf-8?B?M0dobUlRbExyQ3FKSmtjWnVjUEFSTXpnakV6MFlyOWhkYkFicmJaN2xLZGlm?=
 =?utf-8?B?QXFRMDA2RmovVEs3eDZVMWNPSTRVQkNOc3RwcHBXWVdSaVZpRGd2VXZVRnRB?=
 =?utf-8?B?WEMvenBQTWcwWmZ1a3l2SmNpY0tsVDV0cDBwRFAyTkhDSGJaTkQ4RmJYak91?=
 =?utf-8?B?OGdyYi9OSktzdlNqWEFJZXNYcVJZOENxNkVIdGhsQWNZRVlmOHozdXBDa0dF?=
 =?utf-8?B?ZVQzNzY0ODhsNWg5NENBTDNTYTVaRmRYbjVyY3VCYkUrTHM2VHF0WXpFUS9O?=
 =?utf-8?B?TUFHTStTTHA1VXphUW8yT1ZTaVR1Tk9jMkV3aUl3V2hLNFREWWx6a2xKeGJ1?=
 =?utf-8?B?Y1EyeHdBd2l3Sjd6eHhQOUFSbHlPMFNWUkkvdmRaVnV3elNNKzFHSXVOMklR?=
 =?utf-8?B?RVJ3RzJWaTVPVUUxZXFybFNpelNzV0hKaEZNb0JRZzFpVWF4UjVaTGxrL3Rp?=
 =?utf-8?B?NHhDZEpqRmVPT2FhY0gvVkJ4RE15OUFiRzhlcVVZb1A4bmxNT2FBdU4yWVJo?=
 =?utf-8?B?Y3hYMVZoc2tMWHBjdGc0ZmhLMlpmd3Jub2pVRHI5ak1IYWlocWVvS1FmU1dJ?=
 =?utf-8?B?OWJkaU9YS09BZW10dVRyVnJ1aW52aHhFdnRtR0pqRXRHS2p5TVRYam9nUnBK?=
 =?utf-8?B?OC9URFRTVzVISiszeWp6bklrT0NRRlVwbFM4SjdyZ0dYY0tJNnBsRFdpQlli?=
 =?utf-8?B?K1c1clpoRnJiY294YTFUUEl6cWlhUHRsNEM0MHRTNWVoMTE3dy9JVWdwRVpW?=
 =?utf-8?B?eXF6bzlnUDg3NmVkZ2llcWlUcCtwUGVHMWZGMml1cUVFeVBhYVN1d0g0cXZ0?=
 =?utf-8?B?U2JSSTNrOUdPSVBld2RvZnc0YytSdzJwT2hFWWhBZVcyQTdHVFAwRDVKMldO?=
 =?utf-8?B?VWRlQTFpS3NKcElCdDBlVHczcWpVT0QzY2ZRcmRqU1phVWxTRzBJU1dCclor?=
 =?utf-8?B?eTFiaSt6czhWMnJGNmp1V1B0T1BpT0RBWUw1dEhObm5NNXpCU21wTDlhZTZ4?=
 =?utf-8?B?ejhpTm5pTVUxSzZqNlZxV0FWMGVtam1kUW0zMHAveGd6WDVqeXVmWEhmSUdy?=
 =?utf-8?B?VmtFcEhNODZ4QmVuWlhnMmdFVVQyV2xzczB1RFRwK2t2YTROR0JkUFIzNWZM?=
 =?utf-8?B?Y285TjA2L2F0d0l5Rm5ST1AxSUJRQ1NOTnpHdEJDTktBOEI0TFdoam9GVThw?=
 =?utf-8?B?MFEwRDMxL09iU0paZVplajhEZ3VIMmdNTU4rWCtVNWdnMHcvb29tSnNrZ054?=
 =?utf-8?B?bVBYMm9UR3ZZRmcxT2NlZ2Rhdk1TSTlqMG1EaEk1OTBHMEZIT2dpRTV1bTBK?=
 =?utf-8?B?SlBvcHhjRitVWCtyZjdoWnVtaWpIeWd5Q1h2VFhxQ3RZZElscDhVS1RjeDZM?=
 =?utf-8?Q?5bK3J36Y7MRd8?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b2f754c-d74e-4bb7-b434-08de9b864ba6
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 07:03:43.4454 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1PPFD1DAE8B78
Received-SPF: pass client-ip=2a01:111:f403:d406::1;
 envelope-from=nutty.liu@hotmail.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> The RISC-V spec states that
>
> """
> But when bit 9 of mvien is one, bit SEIP in mip is read-only and does
> not include the value of bit 9 of mvip. Rather, the value of mip.SEIP
> is simply the supervisor external interrupt signal from the hart’s
> external interrupt controller (APLIC or IMSIC).
> """
>
> As such let's mark the mip.SEIP in rmw_mip64().
>
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2828
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
> v2:
>   - Move the changes to rmw_mip64() instead
>
>   target/riscv/csr.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index a75281539b..29dd596ae4 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -3671,6 +3671,14 @@ static RISCVException rmw_mip64(CPURISCVState *env, int csrno,
>       uint64_t old_mip, mask = wr_mask & delegable_ints;
>       uint32_t gin;
>   
> +    /*
> +     * When mvien[9]=1, mip.SEIP is read-only and reflects only
> +     * the external interrupt signal from the interrupt controller.
> +     */
> +    if (env->mvien & MIP_SEIP) {
> +        mask &= ~MIP_SEIP;
> +    }
> +
>       if (mask & MIP_SEIP) {
>           env->software_seip = new_val & MIP_SEIP;
>           new_val |= env->external_seip * MIP_SEIP;

