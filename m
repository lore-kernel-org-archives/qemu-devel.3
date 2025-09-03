Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF9ACA1007
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 01:50:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utcda-00034U-Ia; Tue, 02 Sep 2025 21:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1utcdX-00032c-I0; Tue, 02 Sep 2025 21:50:11 -0400
Received: from mail-koreacentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::7] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1utcdT-0005oq-TK; Tue, 02 Sep 2025 21:50:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HljXDoL4KOspvl2D86X3E//7R0H3VMxtVOJ1mfMmrzGgfKynwJx8xbhSA8dzz9SKh1SMf7bIT84LPy/ILQmlxr63+YiZVECIj4HAEFQx1lQX4alsMY2AWsqpbZDuX0sFfOwLee0OQR8ypho/8PAumRx/kTc1OS610D6nalVgE4DNG9CFzhA/m9mjysgokuhWMnA+9/C0jdbQcMWJxtLi2Y5pEX7RCv1j4oorbDZ5ttJQtczzySB5Es1GSbNrsluO+qYqmNA+DTm9smCsR3ZneOhs+VPtSK36yy2460MnpEL5qj/aGNfHtPg4Q1PZmqIgXDFS8WdW7LYrbzhTDSK4vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JraftHHGvUe+hzTtAqn4QioQam/jxCx7mxvyB7Dm560=;
 b=WYVwvDBxdIvC1BUoD8xGV5shOEIU9Sa4iHZLqalulrqyFvlh7nD+zam876HgZCDjj24aKpn6gow0te9KJMUbqIG2i5yJXGT39PQOIQQkv8J1y9D0gS/uQSeQYX8vr9ZLF/G6ao/sdxvBgbLnO8UxmVe53JaIBKJ/q/mu0fzF60O3Iel6x3I6/l6/yZHIhdWsmUimubiFu5Lx4kbu6WuJn7Eo4BAdHJ9P6VoGOP8NqazZIYY16aej0bSN2UU3S1qcoGnsOUgLO1MLzKXGLXDKrqF6uV9fOD6HiAQ4Z2ZL5Zz41OJyQWeV8EkGdox3HMzDnSoqh664yrTth/9XHAGwoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JraftHHGvUe+hzTtAqn4QioQam/jxCx7mxvyB7Dm560=;
 b=DablidSCGYECATWFh4CC95XbTBT9Zx7lKFWl9OQQtWAqM2aSetrwZTawfcMS6w09livrGu/wsHpN02+GL6W6WuipLbOfO6rfHgoTxm8TYEotu+MeHkMuri+HQN4sZ2avGPlqzpgWe1WX7O6g2GBwyKM1qz1GrPCGfFyIb1zwlL9jZYmCUDHp4crgdy1kxcQPO9F6sl4CI/S2kyTcI3NQvvt65fgPod0w69oyekFOsVwFhD7pFi6uUxsG8Ira3se0hcgDfDWnuxrn7x80DwFevDICFf8JcNM+H3Vtk5Z/uSSMjN7I0l+UcIGZ252m3oTnwdC73F+B3pDNvY3A2OCnnA==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 KL1PR0601MB5776.apcprd06.prod.outlook.com (2603:1096:820:b4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 01:50:01 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%3]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 01:50:01 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [SPAM] [PATCH v1 10/21] hw/arm/ast27x0: Move DRAM and SDMC
 initialization earlier to support memory aliasing
Thread-Topic: [SPAM] [PATCH v1 10/21] hw/arm/ast27x0: Move DRAM and SDMC
 initialization earlier to support memory aliasing
Thread-Index: AQHb9symDY7x9jMIm0eqDfhdBuYobrR/zyeAgAEtCwA=
Date: Wed, 3 Sep 2025 01:50:01 +0000
Message-ID: <SI2PR06MB5041DE5F7B9310214C0DFEB6FC01A@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250717034054.1903991-1-jamin_lin@aspeedtech.com>
 <20250717034054.1903991-11-jamin_lin@aspeedtech.com>
 <7d70dea7-8522-45a2-9958-b56d38879ba2@kaod.org>
In-Reply-To: <7d70dea7-8522-45a2-9958-b56d38879ba2@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|KL1PR0601MB5776:EE_
x-ms-office365-filtering-correlation-id: 32472fe5-983f-435e-d6e4-08ddea8c325f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|217643003; 
x-microsoft-antispam-message-info: =?utf-8?B?V01qM2VBNTVxL1JXMDBJU2p2TWttME1TcnJ1OGZmM0V2bmtYdlZPM2prTUhs?=
 =?utf-8?B?M0tNOENrZkNSbTBOdEV6SEF4cFFiSTBOdlk2TU1uTWxIRlVRR1RkOCtjNTYy?=
 =?utf-8?B?WnNyd2UwL0F3dkRsL05kaDZFWVZyYkVzaGhhNkJHbnRmV0c5MXAveGd0N2dR?=
 =?utf-8?B?QWpLRFhHaVltMTdrSDQ5U2M2MEhFMmsxbFZiS0N4aFNYT2RsR3ljZEFhZmFC?=
 =?utf-8?B?ck95MkRDaXUycUpCMS9qdGRvcjNPU2xtVTFhbmZJeFpsQTFQMDFFWUk0NFRk?=
 =?utf-8?B?cEIzY1lpQ2xmU0xwM0RJT0s3WjdqRGJkaS90cVVXK0huM1R1ZnhhRXBKVU1i?=
 =?utf-8?B?cWFwZFhRazJOcmFjMTFmVEN4MHdIRllVaVZHK01nMitRU1h5RFc3ME5tQ3RX?=
 =?utf-8?B?a044SGdQZXgvMnFNamJuR3V4anQvaUpXN1pJNlIvZ1o3S3dvL1BaTjhxUzUz?=
 =?utf-8?B?akpQQUJyanV6Y1RnaXNTbU1kcWs4MzBFazdYMDFSa1c4Zk94elcvUU0zckc0?=
 =?utf-8?B?MVhicCtQVzNndmZ1MmF1MXRGaFlWK0xzbzU5U3NkNEJnRVY5NEZPMis4V1dM?=
 =?utf-8?B?TUUvbGRSek96eE1PN1FEdFFCaXBTeFZ4Sy9pRjBQV1g3UlAxNGtyb2MrZE11?=
 =?utf-8?B?QVYvR0lGcUJOZkg0TlZSZzlZZ3dCdklxRFpkVmdoRElkYnF6U0ViZzlRSlMz?=
 =?utf-8?B?UDRnWGxjMFRXOHdZNlVsR0VTU1VWRnBoUEp2OEN3Rmk4cmp4OE1BbGNqUHpo?=
 =?utf-8?B?bll1dDNIb3lNVm1LNENtRkd5L2JkT1BkTzBjRXp4Z0pqWWVCVlR2Q2szcjB2?=
 =?utf-8?B?Q1lTWW9rWW5BWFZsSVhPM1ZJcmRhaUY4bHdKYXJFQmp4SGsrUE9RSDZVU3lJ?=
 =?utf-8?B?NXE1UDhJai9rQTJzSzNJUDNtSHU2bE5qZ0RydU8xUExXNDJIVnVrcDcwYytK?=
 =?utf-8?B?Z1h0Sm5WeGhyV0F2cUViTGVFcFVHOVhZbjRudVM1bUVFaXJrdTVuQ3JUZEdP?=
 =?utf-8?B?MnoxYTl1VkhrZ3JPNE5kZElkdDdiTFBCSWhQMVQxMWlwM1prQitRR3IwN3I5?=
 =?utf-8?B?K1JmVFY1ME1NT3g2Tit3RmJWeG54ZmxESmpRZklnZm05OVhrQnJPYjVyaXph?=
 =?utf-8?B?UXZUbTBjUlZoYTlUZ0JuaExPRHFSOUx5Y09tMldxMXNuNVk5T2JDZmhsa2tB?=
 =?utf-8?B?cDVBeXNFVlFzSXB6UjF1dDRXSHlIYmg2Q3RHdEVoMitGQ1AyUkFzNU94YXZJ?=
 =?utf-8?B?YUEyRmRsaVJUYmY3d0VFUzJVZCsycStNZWNHbGVtTnVPU0x5cGZEUGFpcXJU?=
 =?utf-8?B?NVg0M1FCbDJPQ0NsdnBabklaL3lFVGg0cUxUWXNMWmFDYjNCK0s4ckhCYkRM?=
 =?utf-8?B?RHQxMStvZzZMOTFEYTdUVWpidlNIdGNZditDRmt4M0tvajhsV1pNdEJ5dUhJ?=
 =?utf-8?B?alVSckdoaG5pK1NpQ3VvVXZSNmRCSnd0U2VZSHdiVUFVWEMvSUcwTmhoK3Vq?=
 =?utf-8?B?bWxPY09Jb1ZHczRFTUFWUko5QXpkZ0daSUx5N0lrUzk4UzI1Y05JakNSODBk?=
 =?utf-8?B?MGQ1VWVxUjJJUWN5dzhmdUJVR01sMGFSeEZQZWZYalFWeEZWNkNqNWh3Rlpo?=
 =?utf-8?B?eFI1a1FOcmpxYWlOL0VTYUwyTkVnazZjQ0FzSEYvWm03eGoyWS8zYXFOZ1Y2?=
 =?utf-8?B?NU5MRmczU3RtV2hrMExNRjQvZmlMbmxhdmd4Q1FHZGZVQlU1RHdnME91OEFT?=
 =?utf-8?B?emNaZjZIeitGcHBzOEFmTFVPdEpjZjU4M20rM2hKS29hUjgyVzV3T1dxVC94?=
 =?utf-8?B?VmVNMENkMEhIclpSYXd5RVM4SVhTcTQxM21pOFJqK09zNDBOWVlSa09ITTBZ?=
 =?utf-8?B?QS9EWnhMTmtrQ21oL2JxRkd3bjl0QzMvUE03WlR1OGZLdno3SHpwWURKQzR2?=
 =?utf-8?B?bkRlMTIvTWhlUmxvZ3FRTTJmRXByMm4zRzNVR25TbE5Udk54RFUvamJwTHJ1?=
 =?utf-8?B?QWJRNkk3bE5udStXSTFnNFg4MEp2V0RrdzJRVGJiNEhKQnNEMGR3cEt4R3hD?=
 =?utf-8?Q?dxrKAs?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(217643003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0w0OHJOZlpjeEtaU1AzRERQN2NiVmFiSk5HZEp4S3V1emMrbzR0VUxHSWJn?=
 =?utf-8?B?T0w1cnFHbFZHZ1NtdVZqT1dGV0pvbUk1NzJxTEovMXlBR2U2TGI5RCtlZlI5?=
 =?utf-8?B?TEN5YmxZYTVXeHI5dDV0WDVGeDJibllDa2JUQUdaTCtXSy9idnIrTnhOTVBZ?=
 =?utf-8?B?dDVpbFY4SkhtUTJ6bkpYUmNrU0RuNVpxTERtNTBmdHdQSXUzQjJQVWZVS2pm?=
 =?utf-8?B?dStNTGJQMmRKTVdYU2VPdENUeDRsdDYxSmdrR2hhbWVSNmxVbkIyWHNEQWs1?=
 =?utf-8?B?UVJwTnRQY2YyRklKdlVHZHpjcTNXOFhCYUNlL3JIRWNqL2MvZitvMy9pN001?=
 =?utf-8?B?U0hkalg0VUpZVm5qQ1RoVjJXOFJqMVl4MUVYYmg5WTh3QSs4Qkc0Zm5yRHZM?=
 =?utf-8?B?dG9SWUdXSTE2M296Vmk4dThZV2U3RTJDZTROVC9zUXFlMmp2VnhZVEo5MUxt?=
 =?utf-8?B?QXdVc2pKMHpWVHFBUnYvL0prckg4QmtERnZHR3N0QlM3OWZYOHF6QW5PMDF5?=
 =?utf-8?B?b0o3OFE5RG9vaHpyMk1WNFBlUFVxNjB0b2FBWlJrUjNQcS9kY3U1c1RCNGxr?=
 =?utf-8?B?c2NJdEFZWVBwOThGaTMrcFkzK0sxOVdRV3M5cUdSZnMzclFtZTFQaVN6c2Yr?=
 =?utf-8?B?bGFRR25NTUUwU3J1RWUxUGdyL3lRK2NaNVRRZk1IbHRYaFlJQmZkeElvZmNV?=
 =?utf-8?B?VjFhVnR2N0ovZXNjbVl2MW5adUdVbHJpYVVGbDVPMG52YmFBN3dXRmc3TmhU?=
 =?utf-8?B?alk0Sjl6UEtBZDhOVTZvNkJhUWZpNEtYQzlJTkc4dmdtbk9xWUF6NEc1K0tF?=
 =?utf-8?B?cXpSeVlzMm1laTRmdkdBdmw5ODZpRlNxbzlXRzdkRmVvdFcycTlxN3JmK1VD?=
 =?utf-8?B?RWthNWd3S0F4TGRuMER4UVZveTluemJwWGkvd1E0WC8wM0hDL09Kbk9KenVH?=
 =?utf-8?B?VzRQTU1scnNFbzZ3Tlo2RWxBQlR5ckVlUnVHazd4NE8wazdxbTNwa21xYnpW?=
 =?utf-8?B?YTVxLytXbGh4VkxVdjMvK0M1aW4zelVId0VxSXdGSEV0N2I3YVN1UkdoRGkz?=
 =?utf-8?B?Vk5lanU4QXpYdXh0Q1BBcm4rVWg1NjZSUWtXMzI1VW5FTDRmbUNjUFFwckh5?=
 =?utf-8?B?TDR3ZE9ORDUvOE1SM3djMGZTQ0IyZy85eGEvZ2ViZytVczE0RnlaQ2kxWWp6?=
 =?utf-8?B?czZUS1BzWkpZTmNHY1NWVTE4MXJLS24zQTZnK1ZpeDhyd2VERjkzMUJHaEFu?=
 =?utf-8?B?SlZsYkdLZDd1THlYdm1yeFV3eFFUWVBLYlZtb2F0Z2N4K1RJV05EbEVqUnZI?=
 =?utf-8?B?by9jODlWcWJVOWxOVmZtUFcrZDdPRnJSQXB2cTNOWVRkdmpYa0VWdWtJSXZz?=
 =?utf-8?B?UkpmYkh5d05WNjIvYmdMRWJPUVByM3RiRUsraFBkalFtL2Vwekl1M01kSUdZ?=
 =?utf-8?B?Rk9XRHpnSlhVT3lnNjdyekRkcStNSTF4SUV4blhCeVpwUjMxQ3ZSb2xVMnUz?=
 =?utf-8?B?VjY3THp2cUVENTdrczhSMVhhSkVFY0txSXcrcDlwOHJ5Sk0yemx4VmpDdWdN?=
 =?utf-8?B?Wkh4ZlpUQVNGZ0ZWY3FOc0xtejZHKzlOK1dDckdiU0lBN2tQRUtocGZySlJx?=
 =?utf-8?B?bkZQeU42R2JKMlMva21hYlpjVEFLNCtOUFB1ZlIxSFFxWFVvNXpTSkd5NG9m?=
 =?utf-8?B?SmpBeHZWUG01MHlpd1FxeVplWStIYUtvYjQ2clFYQVhRVVhjVkhycXlEd0Vm?=
 =?utf-8?B?V01RTDNJclZzZ1g0QVE5Smo2Ri9lcUttZVdvWUczTzVnRm1iVmhlM0F6eHFu?=
 =?utf-8?B?QWk5T0JwZ1o1SUIzZm1GUlU0S3R1RHp3bWtNaHJES1dTNDUxOFhtajdXeWt6?=
 =?utf-8?B?T2ZQa3JlR1E0b2ZwcmpVbU93ZXJOU3dNYmxKS2xycSs0b2xtU3BoQnVDV2FM?=
 =?utf-8?B?b2ZZRU1UWG9IQytoSStFMWRjV1Q5YjV6NTBUUTM3Zkg4WHFjZm9GNHRVeEFG?=
 =?utf-8?B?T1FJZFBtUmt3bjg0MXFtcEpjbEhDemRhVmd3a0Rmbk5ZY1NjbUJKZDVUeGpS?=
 =?utf-8?B?V3ZHMXpLelZhclByajlUWm5mNWhpNUsrSloxZlJnWXpmcnk5OENFRHd0WWNs?=
 =?utf-8?Q?jzjqIXj1NWZ5zSCsiBf5Rn2Ny?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32472fe5-983f-435e-d6e4-08ddea8c325f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2025 01:50:01.7393 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LpSOMovKDj0bhqMTIVg0kFFXmb0jR1BzU+Tznf3Hil0c4nEVX/cTZaHlCAaSRppb4KykCCjLo8j5iQHDIWrxgMu1If6lki90+Lv1X+Ubb5g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5776
Received-SPF: pass client-ip=2a01:111:f403:c40f::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbU1BBTV0gW1BBVENIIHYxIDEwLzIxXSBody9h
cm0vYXN0Mjd4MDogTW92ZSBEUkFNIGFuZA0KPiBTRE1DIGluaXRpYWxpemF0aW9uIGVhcmxpZXIg
dG8gc3VwcG9ydCBtZW1vcnkgYWxpYXNpbmcNCj4gDQo+IE9uIDcvMTcvMjUgMDU6NDAsIEphbWlu
IExpbiB3cm90ZToNCj4gPiBUbyBzdXBwb3J0IERSQU0gYWxpYXNpbmcgZm9yIGNvcHJvY2Vzc29y
cyAoU1NQL1RTUCksIHRoaXMgY29tbWl0IG1vdmVzDQo+ID4gdGhlIGluaXRpYWxpemF0aW9uIG9m
IHRoZSBTRE1DIChTRFJBTSBjb250cm9sbGVyKSBhbmQgRFJBTSBtb2RlbHMNCj4gPiBlYXJsaWVy
IGluIHRoZSBkZXZpY2UgcmVhbGl6YXRpb24gb3JkZXIuDQo+ID4NCj4gPiBJbiB0aGUgdXBjb21p
bmcgY2hhbmdlcywgdGhlIFBTUCB3aWxsIGV4cG9zZSBhIHBvcnRpb24gb2YgaXRzIERSQU0gYXMN
Cj4gPiBzaGFyZWQgbWVtb3J5IGJ5IGNyZWF0aW5nIGEgbWVtb3J5IHJlZ2lvbiBhbGlhcyBhdCBh
IHNwZWNpZmljIG9mZnNldC4NCj4gPiBUaGlzIGFsaWFzIGlzIG1hcHBlZCBpbnRvIHRoZSBjb3By
b2Nlc3NvcidzIFNEUkFNIGFkZHJlc3Mgc3BhY2UsDQo+ID4gYWxsb3dpbmcgYm90aCBQU1AgYW5k
IHRoZSBjb3Byb2Nlc3NvciAoU1NQL1RTUCkgdG8gYWNjZXNzIHRoZSBzYW1lDQo+ID4gcGh5c2lj
YWwgbWVtb3J5IHRocm91Z2ggdGhlaXIgcmVzcGVjdGl2ZSB2aWV3cyDigJQgUFNQIHZpYSBpdHMg
RFJBTSwgYW5kIHRoZQ0KPiBjb3Byb2Nlc3NvciB2aWEgaXRzIFNEUkFNLg0KPiA+DQo+ID4gVGhl
IHJlbWFwcGluZyBpcyBjb25maWd1cmVkIHRocm91Z2ggU0NVIHJlZ2lzdGVycyBhbmQgZW5hYmxl
cyBzaGFyZWQNCj4gPiBtZW1vcnkgY29tbXVuaWNhdGlvbiBiZXR3ZWVuIFBTUCBhbmQgdGhlIGNv
cHJvY2Vzc29ycy4NCj4gPg0KPiA+IFRoZXJlZm9yZSwgdGhlIERSQU0gYW5kIFNETUMgZGV2aWNl
cyBtdXN0IGJlIHJlYWxpemVkIGJlZm9yZToNCj4gPiAgICAtIHRoZSBTQ1UsIHdoaWNoIGNvbmZp
Z3VyZXMgdGhlIGFsaWFzIG9mZnNldCBhbmQgc2l6ZQ0KPiA+ICAgIC0gdGhlIGNvcHJvY2Vzc29y
cywgd2hpY2ggYWNjZXNzIHRoZSBhbGlhcyB0aHJvdWdoIHRoZWlyIFNEUkFNDQo+ID4gd2luZG93
DQo+ID4NCj4gPiBObyBmdW5jdGlvbmFsIGNoYW5nZS4NCj4gDQo+IFBsZWFzZSBtb3ZlIHRoaXMg
cGF0Y2ggYXQgdGhlIGJlZ2lubmluZyBvZiB0aGUgc2VyaWVzLiBJdCBjYW4gYmUgbWVyZ2VkIGVh
cmx5Lg0KPiANCldpbGwgZG8NCg0KVGhhbmtzIGZvciB5b3VyIHJldmlldyBhbmQgc3VnZ2VzdGlv
bi4NCkphbWluDQoNCj4gDQo+IFRoYW5rcywNCj4gDQo+IEMuDQo+IA0KPiANCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPg0KPiA+IC0t
LQ0KPiA+ICAgaHcvYXJtL2FzcGVlZF9hc3QyN3gwLmMgfCA0MCArKysrKysrKysrKysrKysrKysr
Ky0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMjAgaW5zZXJ0aW9u
cygrKSwgMjAgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaHcvYXJtL2FzcGVl
ZF9hc3QyN3gwLmMgYi9ody9hcm0vYXNwZWVkX2FzdDI3eDAuYyBpbmRleA0KPiA+IDJkMjdlYjFk
ZWIuLjlkNjdjNWY2MzEgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvYXJtL2FzcGVlZF9hc3QyN3gwLmMN
Cj4gPiArKysgYi9ody9hcm0vYXNwZWVkX2FzdDI3eDAuYw0KPiA+IEBAIC03NjUsNiArNzY1LDI2
IEBAIHN0YXRpYyB2b2lkDQo+IGFzcGVlZF9zb2NfYXN0MjcwMF9yZWFsaXplKERldmljZVN0YXRl
ICpkZXYsIEVycm9yICoqZXJycCkNCj4gPg0KPiBxZGV2X2dldF9ncGlvX2luKERFVklDRSgmYS0+
aW50Y1swXS5vcmdhdGVzWzBdKSwgaSkpOw0KPiA+ICAgICAgIH0NCj4gPg0KPiA+ICsgICAgLyoN
Cj4gPiArICAgICAqIFNETUMgLSBTRFJBTSBNZW1vcnkgQ29udHJvbGxlcg0KPiA+ICsgICAgICog
VGhlIFNETUMgY29udHJvbGxlciBpcyB1bmxvY2tlZCBhdCBTUEwgc3RhZ2UuDQo+ID4gKyAgICAg
KiBBdCBwcmVzZW50LCBvbmx5IHN1cHBvcnRzIHRvIGVtdWxhdGUgYm9vdGluZw0KPiA+ICsgICAg
ICogc3RhcnQgZnJvbSB1LWJvb3Qgc3RhZ2UuIFNldCBTRE1DIGNvbnRyb2xsZXINCj4gPiArICAg
ICAqIHVubG9ja2VkIGJ5IGRlZmF1bHQuIEl0IGlzIGEgdGVtcG9yYXJpbHkgc29sdXRpb24uDQo+
ID4gKyAgICAgKi8NCj4gPiArICAgIG9iamVjdF9wcm9wZXJ0eV9zZXRfYm9vbChPQkpFQ1QoJnMt
PnNkbWMpLCAidW5sb2NrZWQiLCB0cnVlLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAmZXJyb3JfYWJvcnQpOw0KPiA+ICsgICAgaWYgKCFzeXNidXNfcmVhbGl6ZShTWVNf
QlVTX0RFVklDRSgmcy0+c2RtYyksIGVycnApKSB7DQo+ID4gKyAgICAgICAgcmV0dXJuOw0KPiA+
ICsgICAgfQ0KPiA+ICsgICAgYXNwZWVkX21taW9fbWFwKHMsIFNZU19CVVNfREVWSUNFKCZzLT5z
ZG1jKSwgMCwNCj4gPiArICAgICAgICAgICAgICAgICAgICBzYy0+bWVtbWFwW0FTUEVFRF9ERVZf
U0RNQ10pOw0KPiA+ICsNCj4gPiArICAgIC8qIFJBTSAqLw0KPiA+ICsgICAgaWYgKCFhc3BlZWRf
c29jX2FzdDI3MDBfZHJhbV9pbml0KGRldiwgZXJycCkpIHsNCj4gPiArICAgICAgICByZXR1cm47
DQo+ID4gKyAgICB9DQo+ID4gKw0KPiA+ICAgICAgIC8qIFNSQU0gKi8NCj4gPiAgICAgICBuYW1l
ID0gZ19zdHJkdXBfcHJpbnRmKCJhc3BlZWQuc3JhbS4lZCIsDQo+IENQVSgmYS0+Y3B1WzBdKS0+
Y3B1X2luZGV4KTsNCj4gPiAgICAgICBpZiAoIW1lbW9yeV9yZWdpb25faW5pdF9yYW0oJnMtPnNy
YW0sIE9CSkVDVChzKSwgbmFtZSwNCj4gPiBzYy0+c3JhbV9zaXplLCBAQCAtODcyLDI2ICs4OTIs
NiBAQCBzdGF0aWMgdm9pZA0KPiBhc3BlZWRfc29jX2FzdDI3MDBfcmVhbGl6ZShEZXZpY2VTdGF0
ZSAqZGV2LCBFcnJvciAqKmVycnApDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICBh
c3BlZWRfc29jX2dldF9pcnEocywNCj4gQVNQRUVEX0RFVl9FSENJMSArIGkpKTsNCj4gPiAgICAg
ICB9DQo+ID4NCj4gPiAtICAgIC8qDQo+ID4gLSAgICAgKiBTRE1DIC0gU0RSQU0gTWVtb3J5IENv
bnRyb2xsZXINCj4gPiAtICAgICAqIFRoZSBTRE1DIGNvbnRyb2xsZXIgaXMgdW5sb2NrZWQgYXQg
U1BMIHN0YWdlLg0KPiA+IC0gICAgICogQXQgcHJlc2VudCwgb25seSBzdXBwb3J0cyB0byBlbXVs
YXRlIGJvb3RpbmcNCj4gPiAtICAgICAqIHN0YXJ0IGZyb20gdS1ib290IHN0YWdlLiBTZXQgU0RN
QyBjb250cm9sbGVyDQo+ID4gLSAgICAgKiB1bmxvY2tlZCBieSBkZWZhdWx0LiBJdCBpcyBhIHRl
bXBvcmFyaWx5IHNvbHV0aW9uLg0KPiA+IC0gICAgICovDQo+ID4gLSAgICBvYmplY3RfcHJvcGVy
dHlfc2V0X2Jvb2woT0JKRUNUKCZzLT5zZG1jKSwgInVubG9ja2VkIiwgdHJ1ZSwNCj4gPiAtICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJmVycm9yX2Fib3J0KTsNCj4gPiAtICAgIGlm
ICghc3lzYnVzX3JlYWxpemUoU1lTX0JVU19ERVZJQ0UoJnMtPnNkbWMpLCBlcnJwKSkgew0KPiA+
IC0gICAgICAgIHJldHVybjsNCj4gPiAtICAgIH0NCj4gPiAtICAgIGFzcGVlZF9tbWlvX21hcChz
LCBTWVNfQlVTX0RFVklDRSgmcy0+c2RtYyksIDAsDQo+ID4gLSAgICAgICAgICAgICAgICAgICAg
c2MtPm1lbW1hcFtBU1BFRURfREVWX1NETUNdKTsNCj4gPiAtDQo+ID4gLSAgICAvKiBSQU0gKi8N
Cj4gPiAtICAgIGlmICghYXNwZWVkX3NvY19hc3QyNzAwX2RyYW1faW5pdChkZXYsIGVycnApKSB7
DQo+ID4gLSAgICAgICAgcmV0dXJuOw0KPiA+IC0gICAgfQ0KPiA+IC0NCj4gPiAgICAgICAvKiBO
ZXQgKi8NCj4gPiAgICAgICBmb3IgKGkgPSAwOyBpIDwgc2MtPm1hY3NfbnVtOyBpKyspIHsNCj4g
PiAgICAgICAgICAgb2JqZWN0X3Byb3BlcnR5X3NldF9ib29sKE9CSkVDVCgmcy0+ZnRnbWFjMTAw
W2ldKSwgImFzcGVlZCIsDQo+ID4gdHJ1ZSwNCg0K

