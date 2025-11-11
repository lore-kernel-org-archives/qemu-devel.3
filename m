Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA562CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 01:28:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIdAp-00088E-Ro; Mon, 10 Nov 2025 20:27:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vIdAm-00085j-O1; Mon, 10 Nov 2025 20:27:53 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vIdAa-0005zG-Jd; Mon, 10 Nov 2025 20:27:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r+bGI5Uhh74dkNcKhz0YuZk7waZRhfw8V31KZWXewmVLBZQGcOMmhvPG5xXpJJod1si2oH2mXj5ML9626ZlE+fyVbGkcbslODUhcFGC23bw2xDzh5zYovRTf1SW55HQb3niu0cSLeeAEQkM2DXJ4BpBC8OP+InXzwUALkZimC2YRq0IpqrbAemAI7cKKeW9SctNg3+6ptEr5jF90d0UBOMt+CWvYbApdbEvxOimx/hAX48XAZK/oYTDdWlfuOjEgKrhvnh5cQu7As58d2TyEfBN5h10WW+vI/6kJK5aOcrjZAsaBDJnhwK5HvepLh95aycuDO5RrBnaFSob/XPVb2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WRjVxAV+0W948wytzpjsCuVAbe6fQQjsSMaB7R22yBQ=;
 b=CVsVYzWGDUXW009LN3q6wHQlg2rjxOvl5XndQy1G+ar+nvvAm4nWg9zN6QNGkWEbfnhCaXG7gAjbo8QDxP4AbUEzKuDz1t7owxzQS/yRnmfL9qECOYwisdLPyhbMtL5RFKAcIOD6bsiuYQ+Z9tM/wv5np8lrHBRYug1EdzYCwUUgm24/Wm3D1YPEHu50mHfEUNW4gtUYYflvu8aTdkTk2Ta9pMjfki08EejOwu/GXnUAVOi1N7aoWZzgd8NkUvjhgK11/VVFMslZyGTzKkArwSAjm13aAB6P03vuTQrvZfHA51svnFgA9ofZBB+Sxy9DToRvmXt6SrYPZrQK/dTZlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRjVxAV+0W948wytzpjsCuVAbe6fQQjsSMaB7R22yBQ=;
 b=rspFVL8MG9YXr/qL6cX7Ku9kCy+BeSgpGD7KAcuecn/VhNDRt/AtNgXb1fwelR1cA9wa5Btys9w5G3JQvBedrH5pbCILqA+Um2qy3V3aps80JH93aFpE1o2hBmVPmDJGx2tl2YpqQw9UQizfHIPt9+O2wrhf8xuRGU4vT3TUqS+K90gV0OqVxWfJlPKD4GtjEfBUAn3T7FYlroeDM+4fyOEg+yzhANeMCmAYQdcj1IdIfWJDYZs3n04a5NX2wFASE/PDkTVGa1UthhHfhCPdtr1tqP1zoxV/VVBVDNYQGn76iRYUvzgYz/pZxoqf/NSX9VQQsdWpJuZAUMwM2DAtrQ==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by KL1PR06MB6492.apcprd06.prod.outlook.com (2603:1096:820:fd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 01:27:31 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca%6]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 01:27:31 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v2 17/17] hw/arm/aspeed: Model AST1700 PWM block as
 unimplemented device
Thread-Topic: [PATCH v2 17/17] hw/arm/aspeed: Model AST1700 PWM block as
 unimplemented device
Thread-Index: AQHcTgiSuvck46BSdkSiIl+eyEfJm7TsHsAAgACYGjA=
Date: Tue, 11 Nov 2025 01:27:31 +0000
Message-ID: <SI6PR06MB763120D5E34126593C213DB1F7CFA@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20251105035859.3709907-1-kane_chen@aspeedtech.com>
 <20251105035859.3709907-18-kane_chen@aspeedtech.com>
 <3eff381c-a36b-48bd-89d3-4dcc4be5c39c@kaod.org>
In-Reply-To: <3eff381c-a36b-48bd-89d3-4dcc4be5c39c@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|KL1PR06MB6492:EE_
x-ms-office365-filtering-correlation-id: 212cac80-9c1b-474b-df53-08de20c17bdb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?VUNuMzZIa2d6dStrK2JsSmJrMjFERzlMV2ZxM0luTm1ncm85WEplVEF2b2lk?=
 =?utf-8?B?bE5HYUljVDFNeHBCOEVoeFFDQ2NLS2hHSldES3dyUy8zbzBZRHBGUHIzTmxL?=
 =?utf-8?B?NEhCSHd0d1daaU9TYnlOR0pSbk15cG1nUFp1bGQ3ZGVwa3RmZ1BpZkIzVDVY?=
 =?utf-8?B?cjRHbzVVREFENjd2V0N1K1BjQkpXQkhoNXc0OE1sUmEzQ2NlM1F0YjFFUURN?=
 =?utf-8?B?THFxMWNsOSs0dnJqMEdTbTF1ZWRlT1NuZlVGZVlFWVpNQzdUMlAzbzlkMVhD?=
 =?utf-8?B?dHVHWGcrV1FHcWNaVmtxbFF4ZGZ4MGpBcHZITFVOU2lFMWZjQWxHMG51Qm5P?=
 =?utf-8?B?OWhwUUdlOHVyU0RvU0o1aVkzaHlwdEpOR3hmYWxTczdUME1pMDlmbjZLemhP?=
 =?utf-8?B?RXIyOHpPNVhKVXNhajh2RHRqZVBEQlJQdHRYeEhyNnY0WFdNb2dBR0Q5ZFJT?=
 =?utf-8?B?cE1Pa1I1em9FYUFNZU5GVDZhR1dnVUNLellSNHA1bnZEQ0tIVW9yS2liTHJy?=
 =?utf-8?B?d25maEhnajRBdzhORGYyc0tIZE1BUFloMkFzb3FTc2RPc0ZOMFFwdXI1UjhT?=
 =?utf-8?B?VzFQdDlNWXlVdDRRZlJIZmRYL3lJUjgvVWVZUmxwOWM1aVVoREJpd1V4ZUJi?=
 =?utf-8?B?VUVkRnNyRkxGbjEwVWFkTTM3ZGpmdk9zMlE3ckY5ZzJXSUZNUElxVVZmZjlY?=
 =?utf-8?B?ZXlYQjdBa2Y1SGdNZDRJZGhaTEltWEZGMVA5SzBFd2h5V2N2ZmF3Und0K3J1?=
 =?utf-8?B?a2xya2piZCtwaVdxaDFXMmc3V2pscTBTcXhkVG5BYlBNMXdIalczTnFNaTdk?=
 =?utf-8?B?RE1FZExUVDZONG5nOC95eTVRQ1VqZno0TjAwLzRTbjdHSytiM0swWGt0VUdj?=
 =?utf-8?B?YUpicWljeDRHQ2ttekF3ak90b202NUk2ZW1meTZidVJjTDdObmlRQ2NxSUV1?=
 =?utf-8?B?RWExKzE5NmpyajBwT3FlaVVWS0toSTZobFBIVHhJUXlxZnh3UDZPUUlOdkVW?=
 =?utf-8?B?MWYxNTNwb3M1Rm1sL0R2ZmFXelZvOHd0V29HcEk0dnkwNHN2eVJvaGpZTHFW?=
 =?utf-8?B?Y1d6UDJydzFJRXd0VFVmUTd3UUZTRG1zdmxYMU02Rms5Z1RvMEU2emV0WHo3?=
 =?utf-8?B?WTl4K0xQT1hQVWEyTVkrVzdjYkxIQktPOU8rY2Y5WHpVc213eThoNDJoNjh3?=
 =?utf-8?B?aU1aTFp4L0wxZENUOHBldEZwZmpRUkVRU2p2bUxlNHFZTWJCVVM5M09YTjNR?=
 =?utf-8?B?T2pSbFZYTlZaMDAyOVpBdnFxcVZXekg3Vm52RmdjczRNZnpzdEJncE1zV0Ru?=
 =?utf-8?B?TVN4emY0dVg2S21QS0lyaXhTNTQ0ODF3UHkvaHlNYzExMFMvVElXUkI3NzJo?=
 =?utf-8?B?UHB0VmkwN01zTW1aOUZLelA4YXJNTVo2OWg1SXVtYUV2eFZDZFZsQWNWV0h5?=
 =?utf-8?B?bXlwTExBcFY2SzRzVmw3c3AzV0lsU2k0bVB2U2xzTTNYa2VkSG1ldlJUWW9q?=
 =?utf-8?B?Wnl6NFpTZU5kVGdlWEViNWt2V2oycUZNN2x4bjFEN0tYR0lvanJ1a3g5Wm1m?=
 =?utf-8?B?ZStKRnV5TE9lR05ESE1YMUg1U00rdXhaVFk0ekg4U2NUNjdIYW9mMGY1UkFo?=
 =?utf-8?B?MGZFRHhFMTdoTDJ6YjJMNTJSTm5FU3pnRW5YMUJlbFhrRzNPYjhYYXQxRVBr?=
 =?utf-8?B?eTN3alpvSnZyMmk5Zk10amJYSnJwTE9nZzV5blZmdHYzRmVlcythYzVyRWd6?=
 =?utf-8?B?SVJRY01iMlhLQXc3MkxDZXQyUTBhOXZ5dTRsU1FtWUUvYXd3L0tiZG5YS0xp?=
 =?utf-8?B?SzA0cUpCeElLNUI4SjgrczNVYm12UUtPRzFBc2Nhb044V2JyNWxXV3lVbFJj?=
 =?utf-8?B?U3g2L3Z3RWFOMEJVeDVjN0J2ZU82K3lQbTVHNUJLQWpGNFpmVXJBMGU1QXQz?=
 =?utf-8?B?aXlJUzUybjNRb29NM1hwN2Z6L2tIWmdwZVJjeGYyZktPUFhSRXl6RVhzaGxm?=
 =?utf-8?B?WTlrd3BzcFpIcnFUVytVTzNscFNUS1dxR2M2MnkzZmdQQjRSWHo2WlJHMWtz?=
 =?utf-8?Q?puXaJp?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dzlaczR6aVU4bUJRcDE5WkYreEtQUkhSb3V1Z2hFWGhacGtxc0szSFBqcTZo?=
 =?utf-8?B?dWVTSHVnQjR5Z3FJaStObWF2c3JsdDRRZDBCS3h4N09XNmUxU24yNXdmeXpH?=
 =?utf-8?B?WUlobjRyUWJJcklPT1I5MW10ZG9jTXcvZzA3WTJhM0JtU2pON25aemQvRjB6?=
 =?utf-8?B?UFoxWnNPNW5Jc0xueHRpcFNuRzNnbHdsY0Z1RGZmZ3BaNEZBQWxnMW5LYkRB?=
 =?utf-8?B?WUlDUGlKLzFYU25vNVBUdnNtM2lBL09EUnVnSWxaeUp3NTgyRmdTVVE2TXo5?=
 =?utf-8?B?dWNwOXdHQzdvSHY1bWVFWnFiSXlkbHIwVjIzTUdhRmozTmVnbXlWaHd2eWN0?=
 =?utf-8?B?U3Y5c0RkMit4d3d5NTg4WGRSM2o0eXVKRXk2NFFlQWJzbDZ4dXk4enlkM2Ja?=
 =?utf-8?B?Unh1TmlEVFZLMUFwMFc0YWZjZURDZUVPUitKVVYyNjRHb3d0M0h1YTdrdHBO?=
 =?utf-8?B?eVhJTGZLMVBsT0NTZ3A0ZW92RmI0T0c0RjFkaFJnZXozejZwN2U1UTlaZGp5?=
 =?utf-8?B?RkpEWDlvMTB5RkdKRHdSZXFEQmdRK3lsc1RGaHhydDJJcUVFWSs4d3l5bTJR?=
 =?utf-8?B?UmkwSjRJeWdXYTFxcmxsWGx6RnE2RlZFMDFVcGgyOFl0R1VJUWhERDhQNVBZ?=
 =?utf-8?B?SzdVRnI5Y3c0UUlLcmwrTGU4Qk9kVVFuVTk0WjBheUc1cWYyQnlLMnhoUHJM?=
 =?utf-8?B?bmxUelBJcWdZRk5wSnA5c1lIMlVCYVQvZnczMzd6Sm1qbHFrUzJJU0wrdWt5?=
 =?utf-8?B?akx4TTJBVHNMUjl5NTl5UXNSTGVKSmFsaEVQKzJKNTFyaks4Sk5ocUU2RDRQ?=
 =?utf-8?B?WlhiZEdGMmtyZHB3dms0ZXBleDZJdG1ud0U0Q1l0bEpFdTVrbXF4QzZmdUlJ?=
 =?utf-8?B?THYwZXVTeGdENXozeVRoOHdUQnNWSmVpQU02clZjUUFxTlAyWWZpVFFhdDJu?=
 =?utf-8?B?YzVBUjlNdzhXOFYyMENPSXVvTGhNcy9UY2h6NlNVMkZOazM2Nm0wYW9mTkpL?=
 =?utf-8?B?RmpqampvMGtlaXJUN2wyNFNVb0JIcmUxRXhsRWpya05TcndXQ0RMS25IL2JP?=
 =?utf-8?B?cGdrU2xkNHVlZVFqZjVzOVE0bkVOUVBmVWdwUGRGek9JQmhEWEJvdzdkVWdR?=
 =?utf-8?B?VmcyT0J0WWZXaTVUdEdTTDV4UmpzaklTTzRqSlQwYXdRV0Z1UUJNWm4yMkhS?=
 =?utf-8?B?Rk9pZmRKaHNxMEZRS2hNNkJVM0l3a2I4M3VNMEJ5empxbTZxTXpXc3ZOWlpN?=
 =?utf-8?B?SitES2hDNzcxY21jNVFmWlF5bklLNFhrMUQ1SUNBVFRraW84YUhJeTBzaC94?=
 =?utf-8?B?ckZKNXlLdDZ6cUpHeTNoN1BoYk1raUhrMnFyUndWVVVtV1Baa3c3d3hyYUZE?=
 =?utf-8?B?bkpJN0lGSTE1bzFoNzM5SUtEVnZVRkJGWFFVMXFScWtzMCtRNUZQSTB2U2Yw?=
 =?utf-8?B?YmNFZ2NpOFloMHRMQVA4bjFKTmg1b25td3NHSjBZUFBWVTFCZHFEMDRrZnBh?=
 =?utf-8?B?K2xrSDN2NmU4WWRDYkN2MTZGSExYYlpyN3hXYVJpK1lFbFhTb2sxblpzVHc0?=
 =?utf-8?B?b3BIVVhHTjFlYTdmNEZVMGRxQ1p3eGtyK241YlhWK0VUdUZCK2pWWXZSNlJX?=
 =?utf-8?B?VnhLbFd2WktQd0VWMHNuYVhUMmpEYktxd3hQRzFZNGFia2M4YmlTTGMzTXZh?=
 =?utf-8?B?bW9lbldkeWZQWDNQTDBBU0tVdkt2SnhEV0VZUXk0M3N2b2R2bVM2V2xwNXFL?=
 =?utf-8?B?dG13OC9wd3RuMm53MjVveUpMcGFaZFRKRUw1VE9BYzdEWWVkdkJ5QkRIc0FT?=
 =?utf-8?B?cFl1ODZoSGJQdkdXTklqbWxteVIweWFveUIwMENUTHFtTE9YNjNZRitoTlkw?=
 =?utf-8?B?eCtEN21SY0FvandSQS9mR3dWMUZNbXdCK3hSYkxKeHpHbjRPZGNwdEtiUDdP?=
 =?utf-8?B?aUJQakJIeW9odVpyaEF2SEl0KzZYaEpxYlUrTEg4RGgyOHB1SXZKcmZIOGE5?=
 =?utf-8?B?RWt6QjRCS3lXcVN4QnNPaWw3eEhvNTd1NGw2Tk40ZUllblpObFhjVldhTTRZ?=
 =?utf-8?B?MHhKMi9kY2JqWStCdUJkQzc2Z1pDandEbmdxMnNkRjUyWjRrU0dwUWRRKzVO?=
 =?utf-8?Q?Uk0JWXluShQwbw10Cd3rxCjbV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 212cac80-9c1b-474b-df53-08de20c17bdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 01:27:31.1843 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1PVJykddlExPJ+YDsJK7LtK/JLkF9hbvD+kSZzcaC4yuuEAGuXhKka8FSs5fsvQnzO2h0fcRTuJRMNS6xKFA7N21JPo3DdhdtMrLqDbtBTc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6492
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=kane_chen@aspeedtech.com;
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

SGkgQ8OpZHJpYywNCg0KVGhhbmtzIGZvciB0aGUgaW5mb3JtYXRpb24uIEknbGwgdHJ5IGludGVn
cmF0aW5nIHRoaXMgUFdNIG1vZGVsLg0KDQpCZXN0IFJlZ2FyZHMsDQpLYW5lDQo+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAa2FvZC5v
cmc+DQo+IFNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDExLCAyMDI1IDEyOjE3IEFNDQo+IFRvOiBL
YW5lIENoZW4gPGthbmVfY2hlbkBhc3BlZWR0ZWNoLmNvbT47IFBldGVyIE1heWRlbGwNCj4gPHBl
dGVyLm1heWRlbGxAbGluYXJvLm9yZz47IFN0ZXZlbiBMZWUgPHN0ZXZlbl9sZWVAYXNwZWVkdGVj
aC5jb20+OyBUcm95DQo+IExlZSA8bGVldHJveUBnbWFpbC5jb20+OyBKYW1pbiBMaW4gPGphbWlu
X2xpbkBhc3BlZWR0ZWNoLmNvbT47IEFuZHJldw0KPiBKZWZmZXJ5IDxhbmRyZXdAY29kZWNvbnN0
cnVjdC5jb20uYXU+OyBKb2VsIFN0YW5sZXkgPGpvZWxAam1zLmlkLmF1PjsNCj4gb3BlbiBsaXN0
OkFTUEVFRCBCTUNzIDxxZW11LWFybUBub25nbnUub3JnPjsgb3BlbiBsaXN0OkFsbCBwYXRjaGVz
IENDDQo+IGhlcmUgPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4NCj4gQ2M6IFRyb3kgTGVlIDx0cm95
X2xlZUBhc3BlZWR0ZWNoLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAxNy8xN10gaHcv
YXJtL2FzcGVlZDogTW9kZWwgQVNUMTcwMCBQV00gYmxvY2sgYXMNCj4gdW5pbXBsZW1lbnRlZCBk
ZXZpY2UNCj4gDQo+IE9uIDExLzUvMjUgMDQ6NTgsIEthbmUgQ2hlbiB3cm90ZToNCj4gPiBGcm9t
OiBLYW5lLUNoZW4tQVMgPGthbmVfY2hlbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPg0KPiA+IEFTVDE3
MDAgaW5jbHVkZXMgYW4gUFdNIGJsb2NrLCBidXQgUUVNVSBoYXMgbm8gZnVuY3Rpb25hbCBtb2Rl
bCBmb3INCj4gPiBhc3BlZWQgcHJvZHVjdCB5ZXQuDQo+IA0KPiBXZSBjb3VsZCBzdGFydCB3aXRo
IGEgZHVtbXkgUFdNIG1vZGVsIDoNCj4gDQo+IA0KPiBodHRwczovL2dpdGh1Yi5jb20vbGVnb2F0
ZXIvcWVtdS9jb21taXQvOWQ3N2M4NGIwNGMyZDlhZTU2ODViM2NjYjVjNA0KPiAzNDg3MzY2NmNh
NzgNCj4gDQo+IEZlZWwgZnJlZSB0byBhZGQgdG8geW91ciBzZXJpZXMuDQo+IA0KPiBUaGFua3Ms
DQo+IA0KPiBDLg0KPiANCj4gDQo+IA0KPiBFeHBvc2UgaXQgYXMgYW4gdW5pbXBsZW1lbnRlZCBk
ZXZpY2Ugc28gdGhlDQo+ID4gYWRkcmVzcyBzcGFjZSBpcyByZXNlcnZlZCBhbmQgdGhlIG1pc3Np
bmcgZnVuY3Rpb25hbGl0eSBpcyBleHBsaWNpdCB0bw0KPiA+IHVzZXJzL2d1ZXN0cy4NCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IEthbmUtQ2hlbi1BUyA8a2FuZV9jaGVuQGFzcGVlZHRlY2guY29t
Pg0KPiA+IC0tLQ0KPiA+ICAgaW5jbHVkZS9ody9taXNjL2FzcGVlZF9hc3QxNzAwLmggfCAgMSAr
DQo+ID4gICBody9taXNjL2FzcGVlZF9hc3QxNzAwLmMgICAgICAgICB8IDE2ICsrKysrKysrKysr
KysrKysNCj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4g
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvbWlzYy9hc3BlZWRfYXN0MTcwMC5oDQo+ID4gYi9pbmNs
dWRlL2h3L21pc2MvYXNwZWVkX2FzdDE3MDAuaA0KPiA+IGluZGV4IDhhZGEzYTc3NzUuLjlkNDMy
YTdkYjAgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9ody9taXNjL2FzcGVlZF9hc3QxNzAwLmgN
Cj4gPiArKysgYi9pbmNsdWRlL2h3L21pc2MvYXNwZWVkX2FzdDE3MDAuaA0KPiA+IEBAIC00NSw2
ICs0NSw3IEBAIHN0cnVjdCBBc3BlZWRBU1QxNzAwU29DU3RhdGUgew0KPiA+DQo+ID4gICAgICAg
VW5pbXBsZW1lbnRlZERldmljZVN0YXRlIGkzYzsNCj4gPiAgICAgICBVbmltcGxlbWVudGVkRGV2
aWNlU3RhdGUgc2dwaW9tOw0KPiA+ICsgICAgVW5pbXBsZW1lbnRlZERldmljZVN0YXRlIHB3bTsN
Cj4gPiAgIH07DQo+ID4NCj4gPiAgICNlbmRpZiAvKiBBU1BFRURfQVNUMTcwMF9IICovDQo+ID4g
ZGlmZiAtLWdpdCBhL2h3L21pc2MvYXNwZWVkX2FzdDE3MDAuYyBiL2h3L21pc2MvYXNwZWVkX2Fz
dDE3MDAuYyBpbmRleA0KPiA+IDY2YTVmMjFkMjcuLjNkOWE5MjBhN2EgMTAwNjQ0DQo+ID4gLS0t
IGEvaHcvbWlzYy9hc3BlZWRfYXN0MTcwMC5jDQo+ID4gKysrIGIvaHcvbWlzYy9hc3BlZWRfYXN0
MTcwMC5jDQo+ID4gQEAgLTIwLDkgKzIwLDExIEBADQo+ID4gICAjZGVmaW5lIEFTVDE3MDBfU09D
X1NSQU1fU0laRSAgICAgICAgMHgwMDA0MDAwMA0KPiA+ICAgI2RlZmluZSBBU1QxNzAwX1NPQ19J
M0NfU0laRSAgICAgICAgIDB4MDAwMTAwMDANCj4gPiAgICNkZWZpbmUgQVNUMTcwMF9TT0NfU0dQ
SU9NX1NJWkUgICAgICAweDAwMDAyMDAwDQo+ID4gKyNkZWZpbmUgQVNUMTcwMF9TT0NfUFdNX1NJ
WkUgICAgICAgICAweDAwMDAwMjAwDQo+ID4NCj4gPiAgIGVudW0gew0KPiA+ICAgICAgIEFTUEVF
RF9BU1QxNzAwX0RFVl9TUEkwLA0KPiA+ICsgICAgQVNQRUVEX0FTVDE3MDBfREVWX1BXTSwNCj4g
PiAgICAgICBBU1BFRURfQVNUMTcwMF9ERVZfU1JBTSwNCj4gPiAgICAgICBBU1BFRURfQVNUMTcw
MF9ERVZfQURDLA0KPiA+ICAgICAgIEFTUEVFRF9BU1QxNzAwX0RFVl9TQ1UsDQo+ID4gQEAgLTM4
LDYgKzQwLDcgQEAgZW51bSB7DQo+ID4NCj4gPiAgIHN0YXRpYyBjb25zdCBod2FkZHIgYXNwZWVk
X2FzdDE3MDBfaW9fbWVtbWFwW10gPSB7DQo+ID4gICAgICAgW0FTUEVFRF9BU1QxNzAwX0RFVl9T
UEkwXSAgICAgID0gIDB4MDAwMzAwMDAsDQo+ID4gKyAgICBbQVNQRUVEX0FTVDE3MDBfREVWX1BX
TV0gICAgICAgPSAgMHgwMDBDMDAwMCwNCj4gPiAgICAgICBbQVNQRUVEX0FTVDE3MDBfREVWX1NS
QU1dICAgICAgPSAgMHgwMEJDMDAwMCwNCj4gPiAgICAgICBbQVNQRUVEX0FTVDE3MDBfREVWX0FE
Q10gICAgICAgPSAgMHgwMEMwMDAwMCwNCj4gPiAgICAgICBbQVNQRUVEX0FTVDE3MDBfREVWX1ND
VV0gICAgICAgPSAgMHgwMEMwMjAwMCwNCj4gPiBAQCAtMTc0LDYgKzE3NywxNSBAQCBzdGF0aWMg
dm9pZCBhc3BlZWRfYXN0MTcwMF9yZWFsaXplKERldmljZVN0YXRlDQo+ICpkZXYsIEVycm9yICoq
ZXJycCkNCj4gPg0KPiBzeXNidXNfbW1pb19nZXRfcmVnaW9uKFNZU19CVVNfREVWSUNFKCZzLT5z
Z3Bpb20pLCAwKSwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgIC0xMDAwKTsNCj4gPg0K
PiA+ICsgICAgLyogUFdNICovDQo+ID4gKyAgICBxZGV2X3Byb3Bfc2V0X3N0cmluZyhERVZJQ0Uo
JnMtPnB3bSksICJuYW1lIiwgImlvZXhwLXB3bSIpOw0KPiA+ICsgICAgcWRldl9wcm9wX3NldF91
aW50NjQoREVWSUNFKCZzLT5wd20pLCAic2l6ZSIsDQo+IEFTVDE3MDBfU09DX1BXTV9TSVpFKTsN
Cj4gPiArICAgIHN5c2J1c19yZWFsaXplKFNZU19CVVNfREVWSUNFKCZzLT5wd20pLCBlcnJwKTsN
Cj4gPiArICAgIG1lbW9yeV9yZWdpb25fYWRkX3N1YnJlZ2lvbl9vdmVybGFwKCZzLT5pb21lbSwN
Cj4gPiArDQo+IGFzcGVlZF9hc3QxNzAwX2lvX21lbW1hcFtBU1BFRURfQVNUMTcwMF9ERVZfUFdN
XSwNCj4gPiArDQo+IHN5c2J1c19tbWlvX2dldF9yZWdpb24oU1lTX0JVU19ERVZJQ0UoJnMtPnB3
bSksIDApLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAtMTAwMCk7DQo+ID4gKw0KPiA+
ICAgICAgIC8qIFdEVCAqLw0KPiA+ICAgICAgIGZvciAoaSA9IDA7IGkgPCBBU1QxNzAwX1dEVF9O
VU07IGkrKykgew0KPiA+ICAgICAgICAgICBBc3BlZWRXRFRDbGFzcyAqYXdjID0NCj4gQVNQRUVE
X1dEVF9HRVRfQ0xBU1MoJnMtPndkdFtpXSk7IEBADQo+ID4gLTI0MSw2ICsyNTMsMTAgQEAgc3Rh
dGljIHZvaWQgYXNwZWVkX2FzdDE3MDBfaW5zdGFuY2VfaW5pdChPYmplY3QgKm9iaikNCj4gPiAg
ICAgICBvYmplY3RfaW5pdGlhbGl6ZV9jaGlsZChvYmosICJpb2V4cC1zZ3Bpb21bKl0iLCAmcy0+
c2dwaW9tLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFRZUEVfVU5JTVBMRU1F
TlRFRF9ERVZJQ0UpOw0KPiA+DQo+ID4gKyAgICAvKiBQV00gKi8NCj4gPiArICAgIG9iamVjdF9p
bml0aWFsaXplX2NoaWxkKG9iaiwgImlvZXhwLXB3bSIsICZzLT5wd20sDQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBUWVBFX1VOSU1QTEVNRU5URURfREVWSUNFKTsNCj4gPiArDQo+
ID4gICAgICAgLyogV0RUICovDQo+ID4gICAgICAgZm9yIChpID0gMDsgaSA8IEFTVDE3MDBfV0RU
X05VTTsgaSsrKSB7DQo+ID4gICAgICAgICAgIHNucHJpbnRmKHR5cGVuYW1lLCBzaXplb2YodHlw
ZW5hbWUpLCAiYXNwZWVkLndkdC0lcyIsDQo+ID4gc29jbmFtZSk7DQoNCg==

