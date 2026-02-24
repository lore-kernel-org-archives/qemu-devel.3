Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77AF9EEC2B7
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 01:30:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuhFV-0006sr-VR; Mon, 23 Feb 2026 20:30:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vuhFN-0006sH-33; Mon, 23 Feb 2026 20:29:57 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vuhFF-0007Lx-4l; Mon, 23 Feb 2026 20:29:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gHyx/vKtA2xRMX3cXpSv5fOCCWE/J4ZgLjcQXlGks7gTe0u8farUPT9Rwr8IquBCdPMJXwwr9LHJ6W9VqikA1GgpRH6Pyzmaz11G+0BmaUBBrB53Uyh9lcucnU1OHElcikfwDgxmS8N/J52PXeAOeMtWAvkHq3o1hGkHysNypyCHNLsVsccpq4zyRWV4ekaFItghBCGequLXTpkpxVH9hWaSzZxKbJblHuBj/TdCEsvTs/wxnKerEw4nXYutj+imWDs/ZQhNlJbfyXgFpLakwbygz3c26L5sXQEBDSERPhde2Vm+3JyYRmJpeDc2aPD2+huCB92ULdSKYwGpqvFZVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DSfaoyOboJ451RSKtNN9+n+flEr8Gz6PuP08BIqWAdg=;
 b=v7pZEig8gwe2wMOKAVTnGsu88xCGG41VYKeNV77/VzXt3P3lPckmi+TTRuKwuRswizkvU56liUsdyIiHne4NdvvZiBCfGmGKMHp3GlM8VVZnMQVXMlGIMfmutbkoLy+gUBrTTHaeoG7mGEn4V7SUUuZ378f0jRwXwoZgISb2AoQXNKJuuJitADO7yUJd4bpcKUMOSIJi0ceM0Y/0PmLNgSOjScRZ6jWLmDt6ahLUvPFIr+G055j9yUr3E2arDn/RyukPMUcOUH9FXGG3syJlRvgrb9NTx4ixRHXNn9xhfbSkS1tinBIbgCZicsXuFzI8Wl03zSaaRm+7xLtVsQBhuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSfaoyOboJ451RSKtNN9+n+flEr8Gz6PuP08BIqWAdg=;
 b=Jo0HjVGng2T8RCGR5o+tSkq7NWNb9AbN9TuTTIo+Xw0I58FgQa5k7toRAb3bhursSMvZ0ICvrKsFNSoyQ9BbM9EAtdN7s4q/mlqzl5aRSKi13zC4yrR+ljYdfDOA3zsSmMLSpT3og1xR/QCpnc1UXxRAMhpnS7SZGeIAJ/PRF4daIXy6gRePSYiUustFgp0JXzLUyTqzeJPqE0WVAvafYZ9P95t2euuNHzeE2XsFdIGyATCxdn0zX4yAdEwNGihV27v1PXbo+FpSpnU5dvGHud0I9vSDUH/OKXFnayHUmueo7RwguXE86JchjK5l2yjEkxTf7Qmp1FAbE0MnxCz8Xg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SE2PPF390B12459.apcprd06.prod.outlook.com (2603:1096:108:1::7cc)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.20; Tue, 24 Feb
 2026 01:29:37 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 01:29:36 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>, "open list:ARM TCG CPUs"
 <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>, "komlodi@google.com"
 <komlodi@google.com>
Subject: RE: [PATCH v5 00/21] i3c: aspeed: Add I3C support
Thread-Topic: [PATCH v5 00/21] i3c: aspeed: Add I3C support
Thread-Index: AQHcmm0UcQRs4EPMvkyppE8BhlWZ87WAmiyAgBCI2OA=
Date: Tue, 24 Feb 2026 01:29:35 +0000
Message-ID: <TYPPR06MB82061ECF268DE4C88A7641B4FC74A@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260210091018.1553489-1-jamin_lin@aspeedtech.com>
 <b6ad55df-e6ef-443b-a075-ab6959cefd46@kaod.org>
In-Reply-To: <b6ad55df-e6ef-443b-a075-ab6959cefd46@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SE2PPF390B12459:EE_
x-ms-office365-filtering-correlation-id: 7c6fd8c1-ce22-44f6-99ef-08de73442b93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|921020|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?d0hoam1SN0FadEhzMkJpbVBiSXB2STJHREowWVNxMDVWRzRaNE1oaEJBQlFl?=
 =?utf-8?B?RSs1a29aWG1tQVpoUmliMm9JRm9GdlpBK1ptYjlGTnFCWkd1QWYzMW5KS2Jp?=
 =?utf-8?B?c0ZwaWtHOW9vWjkvVDhvRGRnd3MxbGRiV0ZqczdBWXpFV3VwSDgrVlZHcHpT?=
 =?utf-8?B?dWtvZThCa3JZZXJpM0F3T2Rsc2padXBGZVUzdnpPNlB2RGlKK25ZcjNDUkVh?=
 =?utf-8?B?clRJSlYvVVhhL2oyMU1mWDhhcm1ranF3NGdWd1dHTUxjdGlkTjdFc092MmtI?=
 =?utf-8?B?RHhkYzJlSHN2MStVeU5RUWk3ZVlOYTZseDdlYW5ERUtxY0hRYnpHblF0d2J1?=
 =?utf-8?B?VjFsMmR2c1dyQ0pucTZoaDJCdllyakNyM0tHUm9TR1dmRkV4K0lKMGJRVFVH?=
 =?utf-8?B?TitrcGV0ZTRQc2RSQzBFdVprc3QrV0I0VWdnc1g2anVBV3dxTmRLbjBBbkxE?=
 =?utf-8?B?ZDZaWEVjMzlrSmxzMklBTEZEWmJram84aVY3MkdMZGkxc2Y3VFZWZE1PZWpy?=
 =?utf-8?B?NnVKdzNlSnNnZ2VLeU1oN0VYK2pjN1ZORXkwYUJlc2c4S1pJVXJuN2NnNXBh?=
 =?utf-8?B?TlB2Y2ZjMDNKOHdBWVQxM0pBNlBacXlZYllzNGZyaTJ5RVJJVjdTa1F2NmpL?=
 =?utf-8?B?dWxGSDJORHpQL3V1RmhnWmF6Wms3UENaeFU5ZjJNZjU4djBLcmNUUmRwT2pN?=
 =?utf-8?B?MnN6TlIrR1NYMUZjVFU0aEp4QWt6bWQ4Nms3azNNdEQ4UmdibTY4Qk1QV2ZV?=
 =?utf-8?B?c1FCV0ExOFBUdU9qakhUNlVldjFsaWQ1bzY1VWRzRU9rTlo2VnVhVEg4NUFW?=
 =?utf-8?B?a0Y2YUR4d0JkNWpqR0NBK2NrM2tsai8vdHY5QjgrZDRCNnVNTmFUVjhpQkVD?=
 =?utf-8?B?bTJwM0ZSeDk2Z3pNRWs3Y1FZNGJNdWZyeWl2VjcvRGtaWEJ1VkdsdUw4Q3RW?=
 =?utf-8?B?VTZSSUlTdEJtU3cwWSs2RHVyeVBkRi9ldWQ5a0hCWjJ4UlVwR3Y1a2RWVzNr?=
 =?utf-8?B?QVdMZ1Z0OWtxOWVaWWREMHBGaER0TFZ6WWNCQXZ5anZKT1JKb1lFNEJWakhO?=
 =?utf-8?B?Yis1a0tBWE10RUpwbDc0MnVDNng3Y2E2Y2NwUXA2QlJ3WVZhUDVWcWNScU12?=
 =?utf-8?B?TDVjN2dvbTBqcmZERE14NWZ3UU5JNCtEVG03bjRnY1VyK2x2bVRvd3JhNGt5?=
 =?utf-8?B?blAwbTMwOUxjcnBIb2ZtRkluejVEMkZ6QndaK1JObTVqSGdTdURJUkxWUDNH?=
 =?utf-8?B?KzBBUzRVU3JPT3JlaStlVjVMYjVuRWNNQnNSTDFTS1MzWkltR2dCeHJrc3d3?=
 =?utf-8?B?TkZYQkp0aEJQdHRKR2JDS1ZWZHNYdldEeUt4R0x5Ymw3dERyWk9xdFE1NW5s?=
 =?utf-8?B?Z0hKUHd0SVp4RWltQVVvZi9kREltQXBKcERXbHdBU0dMQ2NTbWhUVXJnSDMz?=
 =?utf-8?B?THkzTm83UWtkR3ExOTlyUTREZnlBbXNsZ01PcVJOOGFVVTg1YjNWbW50ZWVV?=
 =?utf-8?B?dExJZ0JJUWlhdUNBYWpjcmIrL0xUOVU2N2dJOUtSKy8zcjUyMi96dmpoUEhp?=
 =?utf-8?B?bVZnbm1uN1Q1eElWUVhFMXRneWxMVWV4YXNLc0lTZ010UC9yQThjUmtiT3JF?=
 =?utf-8?B?dndtT3d3OU92QmJpUVBjNThQMTRZRlNHaGN4QlJ1ak9TOUlWa0xKWjZLM2JV?=
 =?utf-8?B?TEZjcTNDa3RqVE81VkxCRTIxTE42SDloenZ5OFkrcW9jKzdla1NheEV2UHdz?=
 =?utf-8?B?RkxHT0prdlhGU1M2VE5ESStETGxiZWU3SE1ESXNtWHAvdjhBQ0pxYlF0c0JO?=
 =?utf-8?B?TnJ6VDZncTBicC9KZE03bk9ZNGNTWnJpaSt6eUNCRGMybXIzR0hndlBvY2FM?=
 =?utf-8?B?WkdtK3VkWldiMk14cXNPQUNlcGpUQUNHQTlqcFhkQkNoYzZrd1BhSXE2cTk0?=
 =?utf-8?B?WnJFNFgySmJJeFhOV3Ficm12c05JS1VhYVQxbng3YU45a1ViSndGTGhnRjRH?=
 =?utf-8?B?N3o0akc3c3FHakJ0TkhOQ3dvcG8vWXpkSll2cVgwSnRxb0VNMGhKQTc4RHp3?=
 =?utf-8?B?eXc4MmRrdGk4RDlTaVpkNzhsVUsxZnp3V1BwMklsZm9ERlZWV2NFcnVxZk1W?=
 =?utf-8?B?eGlkeUp2bzhYdFJjMi9XZjAwancxTW5zTlQzTGhhcnR3WVFnZVcvTmNEWHpT?=
 =?utf-8?Q?seK3DyBcn9Hm8qR6NXCquzg4RB5C/+Z8WA65k2UHDqDZ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SUM0b01PSG9ydU52a2VQSXNYV0lMTDdsTDk0Q2Fvd0srbTc0OFI1WEk1UHFR?=
 =?utf-8?B?dmwwd3RoRU5PZ25xZllVT3ZkcE9JS1RRREZsWmV2K2pVTVdrZ2UvTWNlZklE?=
 =?utf-8?B?TzVud3N0emp3QzVzTk1keHRqNnNlbWtvK1RNMDVXRkIvTmkwU2Yrb0VOaVV0?=
 =?utf-8?B?d25DOTJTaDNjVkNTTzVOU3Rpdy81NlhIeU5uZmFVYlVIVUxMcXVTU3B5R2la?=
 =?utf-8?B?U3FSZEN4WUE4dGpJK2I4RmxLTmJ2YjlLWUhSV29ld2hqSUx2Z0Z5ZHpxVC91?=
 =?utf-8?B?dVNBVDdTOHovZmZ0ZVlUTGh3VlJ4cEF4STVIR3VoVnNJMTBtZ2Q5V0p2STJ0?=
 =?utf-8?B?MkpkazIvazg2andiWENnYStQblNmL3BLKzBJUXUzMk82bis5dkg5ODd2bnFQ?=
 =?utf-8?B?amdvZTl3RXRaY3hNdkt6VG9pN0g0VTNnR0Z5OFNiWlhwRWNKWTBoRWM1WHg1?=
 =?utf-8?B?SHl0RDB0Z1FyTnF0OFlJYlBFWmRWMEYyZUx5bGs4RmI0RHM0b2V5Y3FrcGwx?=
 =?utf-8?B?VnJ3K0dIbUdxbTk0RWxyRWoyTGpOZnlEMkdWa2JpSW9yQWk5MTN5aFFScTNT?=
 =?utf-8?B?QUgvMGNWNkh2UXpJVVo3QmJlMk1xck9sWnJ4eGEwaUVwR0dkZHA3UWZVbGZ3?=
 =?utf-8?B?RVk0Y2V4elVhVURNbDFEUUgvWTh4UW1mRVBqaU5UWDRTUjFzMnNTOWtaRTVH?=
 =?utf-8?B?d1huclZGTWtBUGprWFZ3SVM2amRFQm0xUVdodytKR2I5R3RUNmtYam5BbExP?=
 =?utf-8?B?cHJ1aUtUZWtQZ3VvRzNHZ3pSMUJuYmpCaStZa1ExSERoazlCRm8rVkorUTZJ?=
 =?utf-8?B?TkFOZ1Y2NnAxc09wQlNLNHB6Rk9Jb1NMNVNTSmlzaFdaeHBWYzA4VDdzS1RO?=
 =?utf-8?B?L3BIWUdMbStaUkZqMUxKT0l4T2lkbXJ4VEtmdmtxZ3NsQ2ZBbzZUSUVvVWVM?=
 =?utf-8?B?eGtmdWloanF3TnRKM3gxWjRaWVUxYnNSQUpXU08zYjl2KzRkQ2pIQytGM0VV?=
 =?utf-8?B?UjFoWEU3Nk56QUM0YWF0VUw0bFdhY2hjUkxiQjJwMHVQZnp5blNuMUVYaTk4?=
 =?utf-8?B?dkovYUVNNENDYUhQSDUzWGNURjBsWEpLUGJVZTJTTy9NOTR5YldEQXcyODVF?=
 =?utf-8?B?TEVPRmVtbm8ydm1lM05NL0R2R1N6VU5Cam42a01DK2JFekZHVE53cUd2M1lt?=
 =?utf-8?B?YTRjdlN1SUN5ZVBUT1NFME5XeUJtN2UzdDFHTkRUYmJMbktKSnhmOGFTMGoy?=
 =?utf-8?B?OStPQ0dvNVVSVGtQcVlKWGx4UC9obURmTE91K1EzY29pdnI1bXF0MXdLeXE0?=
 =?utf-8?B?ZmhNT2xuY1BNNTI0U29QeDgxT00xa2hyQU1BNEF4TFhRVWRTWHlQTDZUMTRa?=
 =?utf-8?B?ZktWWUZ0NXhyU3UxdDRXd2lBRXd0Ry9SR2x3RWxKVGhlZEJQWnhLK1hOdk0r?=
 =?utf-8?B?VXBmQUFRbm94WlRFTnV3N1JMNzFtN1Y4OEhPb3MwVWtBOCt4bFBmTEg2MEtp?=
 =?utf-8?B?b0VYbE1JM3NBRTRPaEROYzUzQ0xxRTFBZXhTcnFweW1Vc08yVXdNZzhmM3lW?=
 =?utf-8?B?QzI1YWVUYnVBNWNwcjVEaTNERnNDZzdrMURZU1F0ckZZWXhJSDUzdTBCZ1JD?=
 =?utf-8?B?UXh6cTNzUmpBL1JRQlFkSjVVaTlUNTN0VUhKcE4yL3E5d2F1UDkza0xpSHlQ?=
 =?utf-8?B?a2U0NjluYlU5U1psU25xejJ5QTRSUHF5QzgvMHZ3cVZtR1lkcGRLRHEraEJn?=
 =?utf-8?B?MnhRNDBRTjVJRUg2dzg1SEdCN2cyY21KUWM1Vk5TK1JQSTdDRDZSY1lTS1dm?=
 =?utf-8?B?OTZxckJIOERvN0lNUEZjTEwvMWZ4SnBrNTJBQmRqMWFvZTF4d2ZTaGtkWER3?=
 =?utf-8?B?aHBmRTNzU1JzaE5iN3lEcTRjSGsySENVK0NJaFBQSXlCWWVER3YzLzVXZDJC?=
 =?utf-8?B?YjdBOWpsZnpMbkhKSk1EemQ2bGhZUUVQK3NNN1FrY211eUdCZkVLeFAvdmlU?=
 =?utf-8?B?aUV6RTY5em13RXZuU0tkQ01BS2gzQ1ZnOXpSV2JtbjgxU2tVbER5WDZQcFZo?=
 =?utf-8?B?cGVmaTdvbVZFQTcxUzRZOXFqN0dZNG1Oak9tUWduY0JjRS96dHJDWEcyMEIw?=
 =?utf-8?B?eVRwSXBzOWtEVUYxVzdqcVFjQmZVQTdIZVpXc3lCNVIxZTh6ZUVTYTUwbDBC?=
 =?utf-8?B?aUZEd2szRDlnMjZnUUYwQi94TUJiMlY2Ujc0TmtBK3NOZnd5RVlwZXZCZWhQ?=
 =?utf-8?B?SXhVTG5xZmwxR0pET3R4cWlCWjI0UUpBcTZ5RlFldmt5R0hQeDhONzV3UlRy?=
 =?utf-8?B?TnpEV1B0RlRoQU05NlltaUJiYlZyRjdhWnY0bVJNdFcrQTB1TXh6dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c6fd8c1-ce22-44f6-99ef-08de73442b93
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 01:29:35.8980 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i0rC+cslNUxSeB9wGISXxF2nKHrDEEmaJHiwayF0ClV6sziglu7unoJRmiTItNlhCnto6GRpNl0Dh3nNvuuMfSfpieAA8io+24AXNujN0mo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPF390B12459
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMDAvMjFdIGkzYzogYXNwZWVk
OiBBZGQgSTNDIHN1cHBvcnQNCj4gDQo+IE9uIDIvMTAvMjYgMTA6MTAsIEphbWluIExpbiB3cm90
ZToNCj4gPiB2MToNCj4gPiAgICBUaGUgaW5pdGlhbCBwYXRjaCBzZXJpZXMgd2FzIGJhc2VkIG9u
IHdvcmsgYnkgSm9lIEtvbWxvZGkNCj4gPGtvbWxvZGlAZ29vZ2xlLmNvbT4uDQo+ID4NCj4gPiAg
ICBUaGlzIHNlcmllcyBhZGRzIEkzQyBidXMgc3VwcG9ydCB0byBRRU1VIGFuZCBhZGRzIG1vcmUg
ZnVuY3Rpb25hbGl0eSB0bw0KPiB0aGUNCj4gPiAgICBBc3BlZWQgSTNDIGNvbnRyb2xsZXIuDQo+
ID4NCj4gPiAgICBUaGlzIGltcGxlbWVudGF0aW9uIGlzIGEgYmFzaWMgaW1wbGVtZW50YXRpb24g
dGhhdCBpbnRyb2R1Y2VzIElCSXMNCj4gPiAgICAoaW5jbHVkaW5nIGhvdC1qb2luKSwgQ0NDcywg
YW5kIFNEUiBkYXRhIHRyYW5zZmVyLiBBcy1pcywgaXQgZG9lc24ndCBzdXBwb3J0DQo+ID4gICAg
bXVsdGktY29udHJvbGxlciBidXNlcyBvciBIRFIgdHJhbnNmZXJzLg0KPiA+DQo+ID4gICAgRmly
c3Qgd2UgYWRkIHRoZSBJM0MgYnVzIGFuZCBjb250cm9sbGVyIG1vZGVsLiBXaXRoIHRoYXQgYWRk
ZWQgd2UNCj4gZXh0ZW5kDQo+ID4gICAgdGhlIGZ1bmN0aW9uYWxpdHkgb2YgdGhlIEFzcGVlZCBJ
M0MgY29udHJvbGxlciBzbyBpdCBjYW4gZG8gdHJhbnNmZXJzDQo+ID4gICAgYW5kIGhhbmRsZSBJ
QklzLg0KPiA+DQo+ID4gICAgTmV4dCwgd2UgYWRkIGEgbW9jayBJM0MgdGFyZ2V0LiBJdCdzIGlu
dGVuZGVkIHRvIGJlIGEgdmVyeSBzaW1wbGUgdGFyZ2V0DQo+ID4gICAganVzdCB0byB2ZXJpZnkg
dGhhdCBJM0MgaXMgd29ya2luZyBvbiB0aGUgZ3Vlc3QuIEludGVybmFsbHksIHdlJ3ZlIHVzZWQg
aXQNCj4gPiAgICBvbiBMaW51eCB0byB2ZXJpZnkgdGhhdCBpM0MgZGV2aWNlcyBjYW4gYmUgcHJv
YmVkIGFuZCBjYW4gc2VuZC9yZWNlaXZlDQo+IGRhdGENCj4gPiAgICBhbmQgSUJJcy4NCj4gPiAg
ICBUaGlzIHRhcmdldCBpcyBzb3J0IG9mIGxpa2UgYW4gRUVQUk9NLCBhbmQgaXQgY2FuIGFsc28g
c2VuZCBJQklzIHVwb24NCj4gPiAgICByZWNlcHRpb24gb2YgYSB1c2VyLWRlZmluZWQgbWFnaWMg
bnVtYmVyLg0KPiA+DQo+ID4gICAgTGFzdGx5IHdlIGFkZCAgaG90cGx1Z2dpbmcgc3VwcG9ydC4g
VGhlIGhvdHBsdWdnaW5nIGRvZXNuJ3QgZG8NCj4gYW55dGhpbmcgdG9vDQo+ID4gICAgY29tcGxp
Y2F0ZWQsIGl0IGp1c3QgYWRkcyB0aGUgZGV2aWNlIGF0dGVtcHRpbmcgdG8gaG90cGx1ZyB0byB0
aGUgYnVzLiBJdA0KPiA+ICAgIGlzIHRoZSBkZXZpY2UncyByZXNwb25zaWJpbGl0eSB0byBob3Qt
am9pbiBhbmQgZ28gdGhyb3VnaCB0aGUgREFBIHByb2Nlc3MNCj4gPiAgICB0byBwYXJ0aWNpcGF0
ZSBvbiB0aGUgYnVzLg0KPiA+DQo+ID4gdjI6DQo+ID4gICAgSmFtaW4gTGluIDxqYW1pbl9saW5A
YXNwZWVkdGVjaC5jb20+IGhhcyB0YWtlbiBvd25lcnNoaXAgb2YgdGhlIEkzQw0KPiBwYXRjaA0K
PiA+ICAgIHNlcmllcyBmb3IgdXBzdHJlYW0gc3VibWlzc2lvbi4NCj4gPg0KPiA+ICAgIENoYW5n
ZXMgaW4gdGhpcyB2ZXJzaW9uIGluY2x1ZGU6DQo+ID4NCj4gPiAgICAxLiBBZGRlZCBJM0MgZnVu
Y3Rpb25hbCB0ZXN0cy4NCj4gPiAgICAyLiBVcGRhdGVkIHBhdGNoIDQgdG8gcmVmaW5lIHJlZ2lz
dGVyIGZpZWxkIGRlZmluaXRpb25zLg0KPiA+ICAgIDMuIFVwZGF0ZWQgcGF0Y2ggNyB0byBjb3Jy
ZWN0IHJlYWQtb25seSByZWdpc3RlciBmaWVsZCBtYXNrcy4NCj4gPg0KPiA+IHYzOg0KPiA+ICAg
IDEuIEFkZCBTaWduZWQtb2ZmLWJ5OiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNv
bT4NCj4gPiAgICAyLiBGaXggYSB0eXBvDQo+ID4gICAgMy4gRml4IEFTUEVFRCBtYWlsIHNlcnZl
ciBpc3N1ZQ0KPiA+DQo+ID4gdjQ6DQo+ID4gICAgMS4gQWRkIFNpZ25lZC1vZmYtYnk6IEphbWlu
IExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPiBhdCB0aGUgZW5kDQo+IG9mIGVhY2ggcGF0
Y2guDQo+ID4NCj4gPiB2NToNCj4gPiAgICAxLiBBZGRyZXNzIHJldmlldyBmZWVkYmFjayBieSB1
cGRhdGluZyB0aGUgSTNDIGJ1cyBhbmQgZGV2aWNlIHRvIHVzZSB0aGUNCj4gPiAgICAgREVGSU5F
X1RZUEVTKCkgbWFjcm8gaW5zdGVhZCBvZiBhbiBleHBsaWNpdCB0eXBlIHJlZ2lzdHJhdGlvbiBm
dW5jdGlvbi4NCj4gPiAgICAyLiBSZW5hbWUgdmFyaWFibGVzIHRvIGBwYXJlbnRfb2JqYCBmb3Ig
dGhlIHBhcmVudCBvYmplY3QgYW5kDQo+IGBwYXJlbnRfY2xhc3NgDQo+ID4gICAgIGZvciB0aGUg
cGFyZW50IGNsYXNzIHRvIGNvbXBseSB3aXRoIFFFTVUgUU9NIGNvZGluZyBzdHlsZQ0KPiBndWlk
ZWxpbmVzLg0KPiA+DQo+ID4gSmFtaW4gTGluICgyKToNCj4gPiAgICBody9pM2MvYXNwZWVkX2kz
YzogU3dpdGNoIHRvIERFRklORV9UWVBFUygpIGFuZCBhbGlnbiBwYXJlbnRfb2JqDQo+ID4gICAg
ICBuYW1pbmcNCj4gPiAgICB0ZXN0cy9mdW5jdGlvbmFsL2FybS90ZXN0X2FzcGVlZF9hc3QyNjAw
X3NkazogQWRkIGkzYyBmdW5jdGlvbmFsIHRlc3QNCj4gPg0KPiA+IEpvZSBLb21sb2RpICgxOSk6
DQo+ID4gICAgaHcvbWlzYy9hc3BlZWRfaTNjOiBNb3ZlIHRvIGkzYyBkaXJlY3RvcnkNCj4gPiAg
ICBody9pM2M6IEFkZCBidXMgc3VwcG9ydA0KPiA+ICAgIGh3L2kzYzogU3BsaXQgRGVzaWduV2Fy
ZSBJM0Mgb3V0IG9mIEFzcGVlZCBJM0MNCj4gPiAgICBody9pM2MvZHctaTNjOiBBZGQgbW9yZSBy
ZWdpc3RlciBmaWVsZHMNCj4gPiAgICBody9pM2MvYXNwZWVkX2kzYzogQWRkIG1vcmUgcmVnaXN0
ZXIgZmllbGRzDQo+ID4gICAgaHcvaTNjL2R3LWkzYzogQWRkIG1vcmUgcmVzZXQgdmFsdWVzDQo+
ID4gICAgaHcvaTNjL2FzcGVlZF9pM2M6IEFkZCByZWdpc3RlciBSTyBmaWVsZCBtYXNrcw0KPiA+
ICAgIGh3L2kzYy9kdy1pM2M6IEFkZCByZWdpc3RlciBSTyBmaWVsZCBtYXNrcw0KPiA+ICAgIGh3
L2kzYy9kdy1pM2M6IFRyZWF0IG1vcmUgcmVnaXN0ZXJzIGFzIHJlYWQtYXMtemVybw0KPiA+ICAg
IGh3L2kzYy9kdy1pM2M6IFVzZSAzMiBiaXRzIG9uIE1NSU8gd3JpdGVzDQo+ID4gICAgaHcvaTNj
L2R3LWkzYzogQWRkIElSUSBNTUlPIGJlaGF2aW9yDQo+ID4gICAgaHcvaTNjL2R3LWkzYzogQWRk
IGRhdGEgVFggYW5kIFJYDQo+ID4gICAgaHcvaTNjL2R3LWkzYzogQWRkIElCSSBoYW5kbGluZw0K
PiA+ICAgIGh3L2kzYy9kdy1pM2M6IEFkZCBjdHJsIE1NSU8gaGFuZGxpbmcNCj4gPiAgICBody9p
M2MvZHctaTNjOiBBZGQgY29udHJvbGxlciByZXNldHMNCj4gPiAgICBody9pM2MvYXNwZWVkOiBB
ZGQgSTNDIGJ1cyBnZXQgZnVuY3Rpb24NCj4gPiAgICBody9pM2M6IEFkZCBNb2NrIHRhcmdldA0K
PiA+ICAgIGh3L2FybS9hc3BlZWQ6IEJ1aWxkIHdpdGggSTNDX0RFVklDRVMNCj4gPiAgICBody9p
M2M6IEFkZCBob3RwbHVnIHN1cHBvcnQNCj4gPg0KPiA+ICAgbWVzb24uYnVpbGQgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgMSArDQo+ID4gICBody9pM2MvdHJhY2UuaCAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAyICsNCj4gPiAgIGluY2x1ZGUvaHcv
YXJtL2FzcGVlZF9zb2MuaCAgICAgICAgICAgICAgICAgICB8ICAgIDIgKy0NCj4gPiAgIGluY2x1
ZGUvaHcve21pc2MgPT4gaTNjfS9hc3BlZWRfaTNjLmggICAgICAgICB8ICAgMzEgKy0NCj4gPiAg
IGluY2x1ZGUvaHcvaTNjL2R3LWkzYy5oICAgICAgICAgICAgICAgICAgICAgICB8ICAxOTkgKysN
Cj4gPiAgIGluY2x1ZGUvaHcvaTNjL2kzYy5oICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAy
NzcgKysrDQo+ID4gICBpbmNsdWRlL2h3L2kzYy9tb2NrLWkzYy10YXJnZXQuaCAgICAgICAgICAg
ICAgfCAgIDUyICsNCj4gPiAgIGh3L2kzYy9hc3BlZWRfaTNjLmMgICAgICAgICAgICAgICAgICAg
ICAgICAgICB8ICAyNTggKysrDQo+ID4gICBody9pM2MvY29yZS5jICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAgNjY0ICsrKysrKw0KPiA+ICAgaHcvaTNjL2R3LWkzYy5jICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHwgMTg2Mg0KPiArKysrKysrKysrKysrKysrKw0KPiA+
ICAgaHcvaTNjL21vY2staTNjLXRhcmdldC5jICAgICAgICAgICAgICAgICAgICAgIHwgIDI5OCAr
KysNCj4gPiAgIGh3L21pc2MvYXNwZWVkX2kzYy5jICAgICAgICAgICAgICAgICAgICAgICAgICB8
ICAzODMgLS0tLQ0KPiA+ICAgaHcvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgICAgMSArDQo+ID4gICBody9hcm0vS2NvbmZpZyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfCAgICAzICsNCj4gPiAgIGh3L2kzYy9LY29uZmlnICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB8ICAgMTUgKw0KPiA+ICAgaHcvaTNjL21lc29uLmJ1aWxkICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgICAgNiArDQo+ID4gICBody9pM2MvdHJhY2UtZXZlbnRz
ICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDQ4ICsNCj4gPiAgIGh3L21lc29uLmJ1aWxk
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgIDEgKw0KPiA+ICAgaHcvbWlzYy9t
ZXNvbi5idWlsZCAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgMSAtDQo+ID4gICBody9t
aXNjL3RyYWNlLWV2ZW50cyAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICA2IC0NCj4gPiAg
IC4uLi9mdW5jdGlvbmFsL2FybS90ZXN0X2FzcGVlZF9hc3QyNjAwX3Nkay5weSB8ICAgMTIgKw0K
PiA+ICAgMjEgZmlsZXMgY2hhbmdlZCwgMzcxMCBpbnNlcnRpb25zKCspLCA0MTIgZGVsZXRpb25z
KC0pDQo+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQgaHcvaTNjL3RyYWNlLmgNCj4gPiAgIHJlbmFt
ZSBpbmNsdWRlL2h3L3ttaXNjID0+IGkzY30vYXNwZWVkX2kzYy5oICg1MyUpDQo+ID4gICBjcmVh
dGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9ody9pM2MvZHctaTNjLmgNCj4gPiAgIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBpbmNsdWRlL2h3L2kzYy9pM2MuaA0KPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGlu
Y2x1ZGUvaHcvaTNjL21vY2staTNjLXRhcmdldC5oDQo+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQg
aHcvaTNjL2FzcGVlZF9pM2MuYw0KPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGh3L2kzYy9jb3Jl
LmMNCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBody9pM2MvZHctaTNjLmMNCj4gPiAgIGNyZWF0
ZSBtb2RlIDEwMDY0NCBody9pM2MvbW9jay1pM2MtdGFyZ2V0LmMNCj4gPiAgIGRlbGV0ZSBtb2Rl
IDEwMDY0NCBody9taXNjL2FzcGVlZF9pM2MuYw0KPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGh3
L2kzYy9LY29uZmlnDQo+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQgaHcvaTNjL21lc29uLmJ1aWxk
DQo+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQgaHcvaTNjL3RyYWNlLWV2ZW50cw0KPiANCj4gDQo+
IFdobyB3aWxsIGJlIHRoZSBtYWludGFpbmVycyBhbmQgcmV2aWV3ZXJzID8NCj4gDQoNCkkgd2ls
bCBhZGQgbXlzZWxmIChKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4pIGFuZCBK
b2UgS29tbG9kaSAoPGtvbWxvZGlAZ29vZ2xlLmNvbT4pIGFzIE1haW50YWluZXJzIGFuZA0KTmFi
aWggRXN0ZWZhbiA8bmFiaWhlc3RlZmFuQGdvb2dsZS5jb20+IGFzIGEgUmV2aWV3ZXIgZm9yIEkz
QyBpbiB0aGUgTUFJTlRBSU5FUlMgZmlsZSBpbiB2Ni4NCldvdWxkIGFueW9uZSBmcm9tIHRoZSBR
RU1VIGNvbW11bml0eSBiZSB3aWxsaW5nIHRvIHNlcnZlIGFzIGEgTWFpbnRhaW5lciBvciBSZXZp
ZXdlciBmb3IgSTNDPw0KDQpUaGFua3MsDQpKYW1pbg0KDQo+IFRoYW5rcywNCj4gDQo+IEMuDQo=

