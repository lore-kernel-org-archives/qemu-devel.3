Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FEACC36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 07:34:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1gzl-00060F-Bl; Mon, 07 Apr 2025 03:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1u1gzH-0005wr-LS; Mon, 07 Apr 2025 03:33:47 -0400
Received: from mail-eastasiaazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c400::3] helo=HK3PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1u1gzD-0001E1-2k; Mon, 07 Apr 2025 03:33:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KtygQ1xoCanKO07kGGgMpeIMwa5YMFF5Upxxy7gHOzX300gON+VMbPgObtTFP2Z9ghyRGJXNEX7u9csgGSkjuaLBsK/FyfwDhD/vszyBTDUDntWMTAzN3ISheJvqJ1WEA8LDFVwmKTCNoeQHmJ/2WieHrS92zyU0yKb93DZdBnb86cLc55mCe/0sqPBHH2UDxKAdcvTdZkJf1KsmY+I0CNpLET8ki5LLOhDrmt8CIpqUyPAlGrve+mVtXkmjoNqAusI0sUdtvM9XNvUSQf8ElZcs3XRGWyxRBnVdEj9vcYRvwtR3t201mkF/U0VHpAl0GiPRVWVLkwgshXdrXBqckg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XheqA9iZviVjSnIAxdYczyNjiroRPEFOjUuQsg5xIvI=;
 b=K35gCh8+X0eSaTP8M6mxJVw4+tamwHe1llPwbTC6C0GTkqKF8YHexpJiDUpA+N4b2JZZKyCu4NzA78TWjaqttrG3BdVCic56G4Kxo7PAeKYc89n5owSSiX0vqPRVDnbwGa3jjVz38pF4mtnYMv9tu9i0giyUdXZ0zWMCtc1pe3Snpb2bZP9kginRMiX9ZR0wWmdtvoa4FNrfifdrcxUhU0PvO+pSte//nlTHTbkW5QyqOZ9GrNW7EtDEFPuaWWja7NFjBCHgxfwQbQhWB0Tg71K1D6wHPsfJP7mkaTeObOAiYmctKIbd4lyX0sJitIn5fsM2h4M9iHWHPa6MJg3wWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XheqA9iZviVjSnIAxdYczyNjiroRPEFOjUuQsg5xIvI=;
 b=qnNryqCPVMKy+fMLKXmhZl7Dfihlw1FmNJ6H6Do8yz7VHmhEGPcPynZrzpXSJ4r0hR5RqnNE78YvEL7gx8nbgJh1gKELlH3hhhMLK1sLp5cJlt2rgJXxKf2ryhgNhZ7awu39pWewAiiTiAQn6mu8rcSKViOKFvASgdOH/iW6WtLC4wNK1DayfzBOwx8pwwy0GZbde1vk1fYYYad8afyHgEerJvkMuFzkOm+r8OG84DJoAOdA6jbianddjiP204qW5e8XdtYR5N95j8H3OdS69+yByp6Ko4/Q/2colF33jZD5yjX1S4vOx34TM7DNt2tH7McXhH9XHwcvgUeDL+32lQ==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by KL1PR06MB6988.apcprd06.prod.outlook.com (2603:1096:820:11b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Mon, 7 Apr
 2025 07:33:13 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca%7]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 07:33:13 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Peter
 Maydell <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew
 Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1 0/1] hw/misc/aspeed_sbc: Implement OTP memory and
 controller
Thread-Topic: [PATCH v1 0/1] hw/misc/aspeed_sbc: Implement OTP memory and
 controller
Thread-Index: AQHbo7CJ3Qx2+9F4VkaV+DsjErCcNbOTbJ+AgAAO/4CAAA7lAIAD8/eg
Date: Mon, 7 Apr 2025 07:33:12 +0000
Message-ID: <SI6PR06MB7631DDEA18B197B4C343386DF7AA2@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20250402091447.3381734-1-kane_chen@aspeedtech.com>
 <9171629d-a386-4971-802b-cd26cc42e194@kaod.org>
 <99497c16-cee4-4098-9971-f61ef7174412@linaro.org>
 <c193e64d-6ce7-4e5c-bb2a-3e1d3f4f143e@kaod.org>
In-Reply-To: <c193e64d-6ce7-4e5c-bb2a-3e1d3f4f143e@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|KL1PR06MB6988:EE_
x-ms-office365-filtering-correlation-id: 1ede7f18-48c2-4992-2194-08dd75a6743e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|921020|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?ZUV3WkNpZy9Ia0xKSEVha1RSbTZJSTBQR2pmeWhIbllEZGhheTczVWxUUzBI?=
 =?utf-8?B?V1pBRHFlQjFsMk1vVU5Ncmlwd09ZNFhiQnFqem5qZkhObFlneFpsNVB4RzBD?=
 =?utf-8?B?TTBJNDkzZXQxcGxjZ2xhdHRudS9CcjRhT084Z3VHMU5ad2RBbFVVc1MyVGZi?=
 =?utf-8?B?eGEyaE1MKzVRWWZvbDN1a3liRFczQVBCUjdNUzkxbE9WMllBVkJlRVpCdUsv?=
 =?utf-8?B?d1ZqU3hmbng2R1ZFVjIwWlVLRDdPQmFhYWFXNm5yUVlVSVdndEkwNnU2cmc1?=
 =?utf-8?B?WVFzVTFGeDlQNnRTdjhLT3RZUXRZZVZ2dWs0VkJxK25pVjhrN1cxSk55cjlJ?=
 =?utf-8?B?MUFIYWtLRUhGaGlVaXBHVldOSGNmb3U5TlhmaEszZjNvQldFcHQzSzcxcWJV?=
 =?utf-8?B?d0F0bW1rQmcvMlRpcS9vKzdWcUFydWpsRjZ6Y015clJEN0x4U0lwU3hJRnJk?=
 =?utf-8?B?QVRjcDRvUDNlemxodldrdnNkaFltYW9uR2VHY2JPUnVmVW1vYk1GY1c4VG5l?=
 =?utf-8?B?NWhSWUl3cExmSkFFVnRINE1yOGV2RkN2dmJ1OXU2dWczRzhJSHladDg4NlFm?=
 =?utf-8?B?MTBsTWVDbTBpcm9OY2loZ2o2QXd4V1dIeGJzdFFUUjJ1QzBwYXZ0UklDa3BP?=
 =?utf-8?B?cExpQUNqSG9wamMyNmxjRU1oc2pCWFUwMFRvQTJzR0YrT2h1TUJvVGpYRkZU?=
 =?utf-8?B?aFg5VnY5MFN0Q20yMjlqbE55eExuQnlpakF3Ti9zV2g2aFIxbE1vc3VmNVVk?=
 =?utf-8?B?d1JOWm40NTdGdHAvcXZjRFdrUHRyNUdrWEFhVDhVTWxBeUErTTBVZU8wRnNk?=
 =?utf-8?B?bVhZc09ESlU2cUFLdmM2MmFIUStDRlh5NkpON09zNnBKbVV3d3ZvUm9UeEw0?=
 =?utf-8?B?Y2trdG1BQUVyK3pjV3l2cGZjeTlseEVOV05EVzFoMTRqZUg0SExJdzBQaDQx?=
 =?utf-8?B?bkUxcDZUNmkrVFRLRjRIa0NHZFJQVUdsbGZCWGphSjlEQ3VSOEo1VHBCeFF5?=
 =?utf-8?B?M0RNUXpTS0UyQVFIdk1HR2tXQTRNWElHV05MVWF3VGdkMGVkNWgyREQvVTBq?=
 =?utf-8?B?MDhwdFBvTXpybXJzTExPa0Q4VCt4bTBXVVBET3F4YTlnMCtKclJ3SjJMTHVU?=
 =?utf-8?B?T0ozNEh5VVpRbTJGeHBLbjJLdWZ4Zk1WaGNKbUZrSXY4ckxFR1ZIMUVOTlZP?=
 =?utf-8?B?ZjlVbGUvRWlrbk9ucDhJNVh5VXUvY1I2V216aEZMTFEvTUtaUDlEcnRDOTIy?=
 =?utf-8?B?YUpabkJuTTFZZElYZzdaRlFwTHRyVXB3SEVkZ0tvQ3dNZytKMmxtT200Ym1Z?=
 =?utf-8?B?M3A2cElKMGRwN2VORTdqTlhhUEpSc2lnRThHSGFYM01TZ1Z3RW5oWGphajY0?=
 =?utf-8?B?UTdob0F5VGgxVUhMa0hpNEJobTVvSDdNMWVmRG9MVk5yTjRESFozWUlqS01R?=
 =?utf-8?B?dkFxZmlGNEZ6bi9JUnJRL2lTZHFZNU5kVms4K016ZWRjYjNhc1ZVVjdRZGli?=
 =?utf-8?B?Sy9uVnYxY0FhcUZsVnhhL2FLRzNaZjVrNmdMcXZoYnJCejBYa09GQTVBdDNM?=
 =?utf-8?B?cDlsczlYakhpem9OVktTWVEvSmg4OTZZVVVGSE91QWRDbEd0WXRTMVJ4WG5P?=
 =?utf-8?B?bFNMak5nRjlMMlpidFNTanhFWEdxdk5lU0pVMjg5M2puVnczbExUQ0tWbmF0?=
 =?utf-8?B?ZUNZM2RNbWFrZklQTDI3V0tJVFppaU42SzAxd3NmN1NmRkNpV3prcEVvSGox?=
 =?utf-8?B?QnFpd20zUnZ0Tkdxanh4TncrcmNaNWhaRFNmMi9jR01VT2R4aTJocWptQlMx?=
 =?utf-8?B?MVNqUHRjSFo0UkZPakVlSGd5eGFGeklkQnkwejRFRUVOaHltcUhnMDMrbk1Q?=
 =?utf-8?B?Q244bUJLZTlZaW5MdGJlQk5STnE0cm1MdVZmakdZS3ZrNlh1OHBmTUZycEs2?=
 =?utf-8?B?MEhyd3dBcjhYcFhxVlRSUEh1NmFvQTI0OVZGYkh0TUQvWFVoSm5MUUpwYnRE?=
 =?utf-8?Q?MmQMdBJtOvl2+b9MzlYIFkMyx6lSqY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(921020)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3QrRWY3TTUvNVZncUkxeVYra1BUR1hlTm85b2NNbDlNZDdKT0pMRGpvZWJD?=
 =?utf-8?B?dnZvZUVhZVRKZG9EeitQQ0I4RjYvSXNyaWlHeUVDMHR4Z05WczJHS0tWQi81?=
 =?utf-8?B?VWQwVmlSNlJ1VkpyejhuL2RncXVzZ1pBQ29TdHppajB1VGFBSEVRelhHQ3M3?=
 =?utf-8?B?dC9rVmRtWmI2MWhUanVXdDJta2c2L243L1hWdFE4ckhvZ0hBSDVYN0RhWHg1?=
 =?utf-8?B?cVlrUUVNeWNOUEMwS09wNUlVYVNQSS9rQUtJeVliVzdKNFdkOEpJYTltM054?=
 =?utf-8?B?U3VBclREYkJTdmtaTmpMWUV4WWlrRVFtaTEwaCtyaXdJUnlWcDJBclVaNGlG?=
 =?utf-8?B?aGpxbHZ5K2xGSUJsdGNFWDZTM2VVMGlDbDJEbEhpR3dNOFdOTFpPLzl2dkpy?=
 =?utf-8?B?Q3hydEFwY1k5K2pXWjU4L2ExZXROVDNiWkJ1dDVySnRMdTBTbzNSYms3cmVq?=
 =?utf-8?B?YklnVnJwczIyRFpnTWZmOThCbUpnS3RsRGZycXhTSGkxT2pTM1dBeXVUYlhx?=
 =?utf-8?B?RDdkdmVPM3FxbDVFck8vcFdUanJLV2ZLcFZxaHRlNFlYVmNFWXhENENEK3pr?=
 =?utf-8?B?NVBtQ3RrOHZyM3FjWmhXM1NqcHVDTXBVMVNSSmZ3M0VnRGFRRXZMZG45OFEr?=
 =?utf-8?B?bXhBd0pFWU5YMXpBV0FQZWJBSEYwRWIrQmJqQTBxNk51WnhvbG5HV1BrWUI0?=
 =?utf-8?B?bnBhRXVuTmlnc0NjeGpqOUdadUd2MG9vaUN6WWVpOVJNejkwRklES3cweUR3?=
 =?utf-8?B?dzZUQTRUL3UwcWRqQkJFMVk2Y21hS2JHdk9jUHoxejAwd2laRlZoV0hwcVlU?=
 =?utf-8?B?N2l2N05ZTllTemdURUw4UkhFank3SW41TGEwT1Izdllqd3JYUmVSWlBjMlpi?=
 =?utf-8?B?ZEhiQytqclFIc0h4VGsxbEdZTVZMSzM3SFJLYWxFSWJ5cjN5d3cwbVA3NWwr?=
 =?utf-8?B?ejMzRE1pWk9pTWZWZmVRVjVGSFZ4OEJ0RVh3VHREcytDSDAveklSOGxGTHdP?=
 =?utf-8?B?N3NhZG5ubnNJdW1mbkJ2RTArOVFVcVhMclNhSTFReWNnS1pWNlM3Ny9veGZT?=
 =?utf-8?B?Yy9Td3ZCSlIza0NiMGt5b09OaEhuRGJGNWFSVGhUaEVrWkV1S0dzQVNlcnNu?=
 =?utf-8?B?KzBQeERoYm5mdURLczdacnR6dWpBOCt1NXJKcVNMc1A5ejh1TktmZ0lmYWpP?=
 =?utf-8?B?a1ZIVjdmM1ViU2JseTlPUXp3SFVBZFptRVduWHFVenVYaGl6eFMvSDc5SFhP?=
 =?utf-8?B?VHhZWkFxblRCMCswdUUzN3pmLzNlWVhGKzduUzdtbjBqcEJtTDFLQWlZSVcz?=
 =?utf-8?B?dXlDbHFsM3lqaDlFSmZTcGp3QVhWdUwwaFMzdkVaWDJncHJhWTJ3UzRuNWtM?=
 =?utf-8?B?bDRGbWsrdElmelpSSm9qNUpMUWlxSE5IcGVWNlFSUFJReFdnL1k1RVNJUmNn?=
 =?utf-8?B?NjBqZUV3UG1xV2t4SnN3cW9OYnZhU3l3aGRVVzV1UmJKdmw1MzFyUzdIWHhp?=
 =?utf-8?B?YWsxd0VMYXB2d1dKd2tmV3BDOVU1M3Z6dTQxQjE5VE8yV2NwRXZpY0RHUm01?=
 =?utf-8?B?L2N2VGRyOXczSVk5bXphalhTcnZlcVg3N0wzWkFvS0ttVEpvU3N1WXVzSlpB?=
 =?utf-8?B?M2U4UldIcFBReFo1UEdxV0RHRy84M3E5RTFid3dEaktnZkM0cmY3VXdnR29a?=
 =?utf-8?B?OHIzUFFtVmlPRTFPb2RZRC94c3BSbkZXV2lhbVBNd2tsK3JDQXFwTDhKelFP?=
 =?utf-8?B?QXlSdXpaSkdSOFBaQ0pldGRrWTVSWThqTXMvTHZhNGhaaTNVdFV4bnZMYUtz?=
 =?utf-8?B?cGRhOUpSbnRWSGNyTmxsaDVSUHVFZkxqMExEbkhYVDRHS2d3S00vRXIvVjls?=
 =?utf-8?B?M2QyL3lSYStIVlJJeTdQUEoyYUpjaFFPUnB1bUlIVlVPNlFrWXQrRUJZNGlT?=
 =?utf-8?B?NVpjQ3lmcUxxWUtReENHbjFDeXNZN0dTZ0Q0b3pnczNPWkwvM1YyZXRMYlpF?=
 =?utf-8?B?TVdVTC9wMks3ZHVKc1lpMS9lSG13TGdvYktCcXRSNTlJSHdDNmg5d05RRjZm?=
 =?utf-8?B?MVRtNnI1a0VDRWl3QVZHUDA1TjFGNTdSVERteUdLb3ZmVDNsaStJZURYVzJW?=
 =?utf-8?Q?iAyebiWvvXbOv0szPumwx+Qey?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ede7f18-48c2-4992-2194-08dd75a6743e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2025 07:33:13.1145 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1U8avqXG2QKKhh9OW3DmbnZILhl9+WEI4zezTRhj5FIx0FmldEAppae21v5gVHyGZ3TquqeW3hIVje6Y089fD/J4Z+4+a71Sd5i5tDzE8sU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6988
Received-SPF: pass client-ip=2a01:111:f403:c400::3;
 envelope-from=kane_chen@aspeedtech.com;
 helo=HK3PR03CU002.outbound.protection.outlook.com
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

SGkgQ8OpZHJpYy9QaGlsaXBwZSwNCg0KT1RQIChPbmUtVGltZSBQcm9ncmFtbWFibGUpIG1lbW9y
eSBpcyBhIHR5cGUgb2Ygbm9uLXZvbGF0aWxlIG1lbW9yeQ0KaW4gd2hpY2ggZWFjaCBiaXQgY2Fu
IGJlIHByb2dyYW1tZWQgb25seSBvbmNlLiBJdCBpcyB0eXBpY2FsbHkgdXNlZA0KdG8gc3RvcmUg
Y3JpdGljYWwgYW5kIHBlcm1hbmVudCBpbmZvcm1hdGlvbiwgc3VjaCBhcyB0aGUgY2hpcCBJRCBh
bmQNCnNlY3VyZSBib290IGtleXMuIFRoZSBzdHJ1Y3R1cmUgYW5kIGJlaGF2aW9yIG9mIE9UUCBt
ZW1vcnkgYXJlDQpjb25zaXN0ZW50IGFjcm9zcyBib3RoIHRoZSBBU1QxMDMwIGFuZCBBU1QyNjAw
IHBsYXRmb3Jtcy4NCg0KQXMgUGhpbGlwcGUgcG9pbnRlZCBvdXQsIHRoaXMgcHJvcG9zYWwgbW9k
ZWxzIHRoZSBPVFAgbWVtb3J5IGFzIGENCmZsYXNoIGRldmljZSBhbmQgdXRpbGl6ZXMgYSBibG9j
ayBiYWNrZW5kIGZvciBwZXJzaXN0ZW50IHN0b3JhZ2UuIEluDQpjb250cmFzdCwgZXhpc3Rpbmcg
aW1wbGVtZW50YXRpb25zIHN1Y2ggYXMgTlBDTTd4eE9UUFN0YXRlLA0KQkNNMjgzNU9UUFN0YXRl
LCBhbmQgU2lGaXZlVU9UUFN0YXRlIGV4cG9zZSBPVFAgbWVtb3J5IHZpYSBNTUlPIGFuZA0KYWx3
YXlzIGluaXRpYWxpemUgaXQgaW4gYSBibGFuayBzdGF0ZS4gVGhlIGdvYWwgb2YgdGhpcyBkZXNp
Z24gaXMgdG8NCmFsbG93IHRoZSBndWVzdCBzeXN0ZW0gdG8gYm9vdCB3aXRoIGEgcHJlLWNvbmZp
Z3VyZWQgT1RQIG1lbW9yeQ0Kc3RhdGUuIFRvIHN1cHBvcnQgdGhpcywgdGhlIE9UUCBtZW1vcnkg
aXMgYmFja2VkIGJ5IGEgZmlsZSwNCnNpbXVsYXRpbmcgcGVyc2lzdGVudCBmbGFzaCBiZWhhdmlv
ci4NCg0KVGhlIE9UUCBtZW1vcnkgYWNjZXNzIGZsb3cgaXMgYXMgZm9sbG93czoNCjEuIFRoZSBn
dWVzdCBpc3N1ZXMgYSByZWFkIG9yIHdyaXRlIE9UUCBjb21tYW5kIHRvIHRoZSBTZWN1cmUgQm9v
dA0KICAgQ29udHJvbGxlciAoU0JDKQ0KMi4gVGhlIFNCQyB0cmlnZ2VycyB0aGUgY29ycmVzcG9u
ZGluZyBvcGVyYXRpb24gaW4gdGhlIE9UUCBjb250cm9sbGVyDQozLiBUaGUgU0JDIHJldHVybnMg
dGhlIHJlc3VsdCB0byB0aGUgZ3Vlc3QNCg0KU2luY2UgdGhlIGd1ZXN0IGludGVyYWN0cyB3aXRo
IE9UUCBtZW1vcnkgZXhjbHVzaXZlbHkgdGhyb3VnaCB0aGUNClNCQywgdGhlIE9UUCBsb2dpYyBp
cyBpbXBsZW1lbnRlZCB3aXRoaW4gYXNwZWVkX3NiYy5jLg0KDQpJZiB0aGVyZSBhcmUgZXhpc3Rp
bmcgYXJjaGl0ZWN0dXJhbCBndWlkZWxpbmVzIG9yIGRlc2lnbiBwYXR0ZXJucw0KdGhhdCBzaG91
bGQgYmUgZm9sbG93ZWQgZm9yIG1vZGVsaW5nIE9UUCBkZXZpY2VzLCBJIHdvdWxkIGdyZWF0bHkN
CmFwcHJlY2lhdGUgeW91ciBmZWVkYmFjay4gSSBhbSBoYXBweSB0byByZXZpc2UgdGhlIGltcGxl
bWVudGF0aW9uDQphY2NvcmRpbmdseSBhbmQgc3VibWl0IHVwZGF0ZWQgcGF0Y2hlcyBmb3IgZnVy
dGhlciByZXZpZXcuDQoNClRoYW5rcyBmb3IgeW91ciBjb21tZW50cyBhbmQgcmV2aWV3Lg0KDQpC
ZXN0IFJlZ2FyZHMsDQpLYW5lDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJv
bTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0BrYW9kLm9yZz4NCj4gU2VudDogRnJpZGF5LCBBcHJp
bCA0LCAyMDI1IDk6NTQgUE0NCj4gVG86IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRA
bGluYXJvLm9yZz47IEthbmUgQ2hlbg0KPiA8a2FuZV9jaGVuQGFzcGVlZHRlY2guY29tPjsgUGV0
ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPjsNCj4gU3RldmVuIExlZSA8c3Rl
dmVuX2xlZUBhc3BlZWR0ZWNoLmNvbT47IFRyb3kgTGVlIDxsZWV0cm95QGdtYWlsLmNvbT47DQo+
IEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPjsgQW5kcmV3IEplZmZlcnkNCj4g
PGFuZHJld0Bjb2RlY29uc3RydWN0LmNvbS5hdT47IEpvZWwgU3RhbmxleSA8am9lbEBqbXMuaWQu
YXU+OyBvcGVuDQo+IGxpc3Q6QVNQRUVEIEJNQ3MgPHFlbXUtYXJtQG5vbmdudS5vcmc+OyBvcGVu
IGxpc3Q6QWxsIHBhdGNoZXMgQ0MgaGVyZQ0KPiA8cWVtdS1kZXZlbEBub25nbnUub3JnPjsgcWVt
dS1ibG9jayA8cWVtdS1ibG9ja0Bub25nbnUub3JnPg0KPiBDYzogVHJveSBMZWUgPHRyb3lfbGVl
QGFzcGVlZHRlY2guY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDAvMV0gaHcvbWlzYy9h
c3BlZWRfc2JjOiBJbXBsZW1lbnQgT1RQIG1lbW9yeSBhbmQNCj4gY29udHJvbGxlcg0KPiANCj4g
T24gNC80LzI1IDE1OjAwLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gPiArcWVt
dS1ibG9ja0ANCj4gPg0KPiA+IE9uIDQvNC8yNSAxNDowNiwgQ8OpZHJpYyBMZSBHb2F0ZXIgd3Jv
dGU6DQo+ID4+IEhlbGxvLA0KPiA+Pg0KPiA+PiBPbiA0LzIvMjUgMTE6MTQsIEthbmUtQ2hlbi1B
UyB3cm90ZToNCj4gPj4+IFRoaXMgcGF0Y2ggaW50cm9kdWNlcyBwYXJ0IG9mIHRoZSBTZWN1cmUg
Qm9vdCBDb250cm9sbGVyIGRldmljZSwNCj4gPj4+IHdoaWNoIGNvbnNpc3RzIG9mIHNldmVyYWwg
c3ViLWNvbXBvbmVudHMsIGluY2x1ZGluZyBhbiBPVFAgbWVtb3J5LA0KPiA+Pj4gT1RQIGNvbnRy
b2xsZXIsIGNyeXB0b2dyYXBoaWMgZW5naW5lLCBhbmQgYm9vdCBjb250cm9sbGVyLg0KPiA+Pj4N
Cj4gPj4+IEluIHRoaXMgdmVyc2lvbiwgdGhlIGltcGxlbWVudGF0aW9uIGluY2x1ZGVzIHRoZSBP
VFAgbWVtb3J5IGFuZCBpdHMNCj4gPj4+IGNvbnRyb2xsZXIuIFRoZSBPVFAgbWVtb3J5IGNhbiBi
ZSBwcm9ncmFtbWVkIGZyb20gd2l0aGluIHRoZSBndWVzdA0KPiA+Pj4gT1MgdmlhIGEgc29mdHdh
cmUgdXRpbGl0eS4NCj4gPj4NCj4gPj4NCj4gPj4gV2hhdCBpcyB0aGUgT1RQIG1lbW9yeSA/IEFu
IGV4dGVybmFsIGZsYXNoIGRldmljZSBvciBidWlsdC1pbiBTUkFNID8NCj4gPj4gSWYgdGhlIGxh
dHRlciwgSSBzdWdnZXN0IHVzaW5nIGFuIGFsbG9jYXRlZCBidWZmZXIgdW5kZXIgdGhlIFNCQw0K
PiA+PiBtb2RlbCBhbmQgYXZvaWQgdGhlIGNvbXBsZXhpdHkgb2YgdGhlIEJsb2NrQmFja2VuZCBp
bXBsZW1lbnRhdGlvbiBhbmQNCj4gPj4gdGhlIGRlZmluaXRpb24gb2YgYSBkcml2ZSBvbiB0aGUg
Y29tbWFuZCBsaW5lIGZvciBpdC4gVGhlIHByb3Bvc2FsIGlzDQo+ID4+IGJ5cGFzc2luZyBhIGxv
dCBvZiBRRU1VIGxheWVycyBmb3IgdGhpcyBwdXJwb3NlLg0KPiA+DQo+ID4gTW9yZSBvZiB0aGUg
Zm9ybWVyLCBhIGJ1aWx0LWluIGVGdXNlIGJlaGF2aW5nIG1vcmUgbGlrZSBmbGFzaC4gU28NCj4g
PiB1c2luZyBibG9jayBiYWNrZW5kIGZvciB0aGUgc3RvcmFnZSBzZWVtcyBjb3JyZWN0IHRvIG1l
Lg0KPiANCj4gSG93IHdvdWxkIHlvdSBkZWZpbmUgdGhlIGRyaXZlIGJhY2tlbmQgb24gdGhlIGNv
bW1hbmQgbGluZSA/DQo+IA0KPiA+IEhvd2V2ZXIgSSBkb24ndCB0aGluaw0KPiA+IHRoZSBpbXBs
ZW1lbnRhdGlvbiBiZWxvbmdzIHRvIGh3L21pc2MvYXNwZWVkX3NiYzsgaWRlYWxseSB3ZSdkIGhh
dmUNCj4gPiBzb21lIGFic3RyYWN0IChvciBpbnRlcmZhY2UpIGltcGxlbWVudGF0aW9uIGluIGh3
L2Jsb2NrL290cC5jIC0tIHdpdGgNCj4gPiBtZXRob2RzIHN1Y2ggcHJvZ3JhbV9vdHBfZGF0YSgp
IC0tLCBjb21wbGV0ZWQgYnkgaHcvYmxvY2svYXNwZWVkX290Yy5jLg0KPiANCj4gSSB3YXMgaW1h
Z2luaW5nIG1vcmUgc29tZXRoaW5nIGxpa2UgTlBDTTd4eE9UUFN0YXRlIG9yIEJDTTI4MzVPVFBT
dGF0ZQ0KPiBhbmQgbm90IFNpRml2ZVVPVFBTdGF0ZS4NCj4gDQo+ID4gQ3VycmVudCBwYXRjaCBt
aWdodCBiZSBnb29kIGVub3VnaCB0byBzdGFydCB3aXRoIElNSE8uDQo+IA0KPiBIYXZlIHlvdSBs
b29rZWQgYXQgdGhlIG5leHQgcGF0Y2ggYW5kIGhvdyB0aGUgYmFja2VuZCBpcyBoYW5kbGVkID8N
Cj4gSSB3aWxsIGxldCB0aGUgYmxvY2sgcGVvcGxlIEFjayB0aGlzIHBhdGNoIGluIHRoYXQgY2Fz
ZS4gSXQncyBiZXlvbmQgbXkgc2tpbGxzLg0KPiANCj4gVGhhbmtzLA0KPiANCj4gQy4NCj4gDQoN
Cg==

