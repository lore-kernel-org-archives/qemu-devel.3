Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE0A5E83EE4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 07:18:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnX8q-0005x1-VA; Wed, 04 Feb 2026 02:17:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnWZM-0004fi-PH; Wed, 04 Feb 2026 01:40:56 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnWZL-0004IG-5f; Wed, 04 Feb 2026 01:40:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gHuPc2ZiydfJdFpso245K9LfOhMFbnIzNbhJhXsaiWJHOeP2Ux84keWBUoepElwvRuZRvHw+x9XIV+EojWN7hkZWju/pWm5zDDs2arKGtiIK+HsLW0eWsz/gZL9/QvRUXKL4Pr9KMo1puRp4hoN21PqHw2zD/t/O4D//j2+d+Vqm0dnK+P1SwsHBkSpHpUytQFwoPfQliVaqxxUgTsa68UoEBgWWDUSCegtUk49c5KRtV24kyh+GhsGNKRQ6b0oMDDXpETYZoe0xWOMBTlNrVCjJK9KscQ4EhOdc1prsaqbzcdNuTR/M82hvRg1DPL8NotDC9RcHdWIwHBDo5P70iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFdBLNt0fYL6y+Qd+QghzSutCIdujTAiQoQsEUf3D88=;
 b=cd/aKhuX218efm0m2K6IeT/50sSYh1UX2P08JurXmfgD2jSnQeeitq4RB+QAMY1lApqOT27+JT6bUT3XwxM24jRkO4Toj+SOWtl/AZkJsW7M9FalzdSyJLtOVg3o0pkW80INkT/48IgyPOaVsgKjAdf0+vdZEpHNxdqAv6me2cDWk05EIRxUra+PaabhWJikaj/RxkPfFZWgULTkazoagHPe4YPGcSzg5eD8ofeTHMAkUd9DDsBOfZLo/eDNC7ctroIInOCRcFHz+LMgx1jwRaBmgFhaokxz30GVu7uK4V6f8caLR5W0FKv6WA8r3bjCD2NIPO0wZLLd8C9vTP1S8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFdBLNt0fYL6y+Qd+QghzSutCIdujTAiQoQsEUf3D88=;
 b=r91b0u3Ws+0trvpxXsq675osL66OrAQQikAZzE4tLZ3qSo5cFeT68NokaYFOgkZDs87pVZmEBQ/8Zkejv6DK7iGva/Umirs4LcZctjnHY5KlC2gGDjJh16UJS3+JNCXKj7Pou3EPhM5wMRYg5pab5yg6FojqB70Pu6QkPWz52tDYBo1Ni+8c0qAWLFiWdWMg3rpTVcEKDfitOhuDRLjBHiibA1BReDHNjY+RQzVDq71HUxi4LwGKxZqqXGI4DolkJ2qRvXApJwYHwGRDc/IZcyAYP/CK1uUZexuLVkmN4PrBCUgwmO++sw1TWDAPP4NRIQJhG5XC7dxUGv2XJgLgIA==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by PUZPR06MB5901.apcprd06.prod.outlook.com (2603:1096:301:110::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Wed, 4 Feb
 2026 06:40:41 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 06:40:39 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, Nabih Estefan
 <nabihestefan@google.com>
Subject: [PATCH v6 16/22] hw/arm/aspeed: Attach PWM device to AST1700 model
Thread-Topic: [PATCH v6 16/22] hw/arm/aspeed: Attach PWM device to AST1700
 model
Thread-Index: AQHclaEttevTeFSVqkSi9Jc8rp19TQ==
Date: Wed, 4 Feb 2026 06:40:39 +0000
Message-ID: <20260204064016.3515639-17-kane_chen@aspeedtech.com>
References: <20260204064016.3515639-1-kane_chen@aspeedtech.com>
In-Reply-To: <20260204064016.3515639-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|PUZPR06MB5901:EE_
x-ms-office365-filtering-correlation-id: 34bf6984-4433-4069-ab94-08de63b84fae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?VFBhRndaTVFJVFZyL2RRSHJpWFBsUkpGd1g5dHViVzcyWGZ2dG9GWXliWXJ5?=
 =?utf-8?B?ZlQwOVAvc3M4OGxIeG1MTlR4RzF4aVMyQzlGeXlKRG5BRE8zejgxcG9DUHpq?=
 =?utf-8?B?Z2VRTHRzM0FRbUdHYzVJci9lNzFJNnJTdG1iay9XTGw2aFRVWFJDeVd1M2Ir?=
 =?utf-8?B?czJtaHQvV0lrYko2YmFWQlBiWWczL2Z0QUlBUFpTQlVDUzU1WVdYUGdOajly?=
 =?utf-8?B?UmFPSmpzeVZtdis4bXhsVDdKVy9TbmlrN244Y2VSSFJLY2xmenM3R0ZyWlQr?=
 =?utf-8?B?aUlvUXpaK1RCMGV2emJ3MFdQUEV2M1lQNWtxRzB2eG1yZGVRQlljQ3B0OUs5?=
 =?utf-8?B?QlBsTXVaZFJ1eGF3OWNvMGh5eTBhelZXVjloSndPdjdDa1c1bkRBam80WUQ2?=
 =?utf-8?B?cklTMzhIbzVWcFZzMTVOdVdPSVNVT0VENGk0TDM3MTQydkZEZC9QVUVnWHZo?=
 =?utf-8?B?WWJ6UHR6N1hiTDlrdDZ4RmNUOWVLTkRpVWkvKzUvbVpIZWtVblE3bzZ2d2lQ?=
 =?utf-8?B?MDBsM0ZuMEJkWTl6NlpmT0hLUC9pR3FPYzZBTW9wS0RneVJPeTNMV3dGQVRR?=
 =?utf-8?B?Q1J3T3pLN2o0RjFiblpsM1NlZEN0Um5zQ3RvZ0psNG9NbVdhbGZGaGp2L2I2?=
 =?utf-8?B?eVduSXlMOXBISmRwWmMxb0Y1dWV2SXUyUlRNaEJrVHBzRnA4cWtmUFFEM0N1?=
 =?utf-8?B?U1pZdDZyY3lKYThRZlBxSVhDVWY5b29KWnpFclFRYTQrai9NOHRKdFg0NjdX?=
 =?utf-8?B?VHlUTEJNVWFmVVN0bS83WkIxVDBCMjFRNnVhaTNjZWxWV1hHQ25XVDFQaUdM?=
 =?utf-8?B?VExITHlheU4wMlRsZFAzQzNDbS8vNi8zd0RSaEZNOCtxMzNMTEhQV0NSQ0ZH?=
 =?utf-8?B?QjVIYXNHZW41bUx4bERDek1KVmNYVnVHZHpLZm5Kb1JuK3BETEdTR3Bpb1Zs?=
 =?utf-8?B?UkJHT0RBWXV2eWpMNDZjSjhDSG1xZjl6OXc5aFY2WUQ1cWZqS2M0a3J3M3Iz?=
 =?utf-8?B?Q2VNT1RKd1pDWkdhN25HbFVOUlVxOGs1Yng4VnlvYXRuSEwzdlFrOENRRU52?=
 =?utf-8?B?SDBUeFZ2U0R0Q3lnanV2Y0dIc1lQZlJsbjJ0cEdRQjZnWHl0eno1SXJjZEFl?=
 =?utf-8?B?VjNGazlwMi9GSEdrSGJKcHlHR1NKRDhISE5ldTN4OFVqSlRrbUV5Tnd4azY1?=
 =?utf-8?B?aitRaVZudmJudldIKzFBL0JmQ0loMVpuMzN3TWsvMXM0WTFjT05waE5hbjZv?=
 =?utf-8?B?RmFlSVZEQkVGdkF3clJ0U2lvbU14akd4UnJ5UkNlVVRiQXJMS0Z6RW96Y0gx?=
 =?utf-8?B?L0VaNjdDbUZTTFFxZ1ZRTDJDTUtUUGp1N2hFTDRZQzNZYnlEL3ZUc29XbTBN?=
 =?utf-8?B?bVJrKytBL01LYW9hb1JwTVIwRFZuak80Z3c1a2RhTGV5cUhKeVIvWFh6Nzhz?=
 =?utf-8?B?WFJTc243M0Q2YmZ0VVNicnFIRXRjT2FwU1F4MlpJUTY1Nnp0U1NlVGVKaER0?=
 =?utf-8?B?ejhiTWwwaEo5b0VTQjBMOW1hbFJuWnNtNC96enV6NkcwTWZSdkM1N0NmTTJK?=
 =?utf-8?B?ZnVZZHkzVjFuaVZaWWMxNlMzT2ROMngxRVRSV1hXTEZ2T011LyticmEzVGhQ?=
 =?utf-8?B?OHZIMlA5c1F2d3BRMk1BU0Z5TzNEdkd5dW1vcDNWNzlvRjVJZzEraWVabTRp?=
 =?utf-8?B?Q2E3M3h3VkhmSkNwNVFzaXRvQ01veGNocWo1SS9oZFRYdGRqbzZsVnc1U1Np?=
 =?utf-8?B?Y2VlSjZwWUpuTzFEZFg1cjd0RXFtSVRpWktTZkhSa05VTWF1eDlOQmNYOGFO?=
 =?utf-8?B?TGlSWnRvL3VwV2FQT1RlVUtrbXY5Q2Yrb3pUOGdlSVJoMkQ3SlI0azRMbklp?=
 =?utf-8?B?eHNaWGh2V1RwV3FMcEtMVlVSUHdNWnJ5WktxdU1TdkswRmZTM1c0UlB0R0o0?=
 =?utf-8?B?Tm51NGM3c0FjZUkvZVpOVXFBTFlTQjhxRlVybk5PN2FMTDUvWWVzY0NwM3ZS?=
 =?utf-8?B?cGJSS1h1MkJXY0dPa0RDMGROaGJHM3psVlRwSXpuaWd4cnJDb2lveUplbEM5?=
 =?utf-8?B?TFJsL1lXWVV5WjZEejIyUzJCZDRzcDVJTVBLV0FidTdGL3lNWkM3K3p1Q1ht?=
 =?utf-8?B?ZUFyTUxtV0N4aXNicllaWUgxOURjeUxJSjlSa1lnODVkRzVJRzQ3SjZlbXpJ?=
 =?utf-8?Q?NoCXMfYgm4wdrmomGfvibeQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDk3TjVaNHdpR3N2RTV0MzhIQ3BQYlg5bDBhcXoybFNuWkJQMno1Mk0wZU44?=
 =?utf-8?B?aFJEU2h3ckU3VTg1RUFNWmtxZnIvYVVHWTlkY0RNTWtzRWZGRUg1VEpjclUr?=
 =?utf-8?B?eE5sMmZIdm1sNmJVREJFcTl5TkZJWUI0WHJYdzRCWmFoV3UrUGNKOGNtY3B2?=
 =?utf-8?B?MjFHYWtTMloyWSs2cFlkeGhGcXY3U1RZT2RxQTEydXpCOHdzc2o2Z2toUTM3?=
 =?utf-8?B?Rkl1dVZ6YVF6R3BXMjYzZzcyZ1NPTlJSck5UNnVvRjdkcXpFeU9ua0IwOWs5?=
 =?utf-8?B?Vm5RaHh6Sk9ra2V4SUM3SURBU05YREZaRDVleVJmOHlWYU9wcC9CV1JVZWlQ?=
 =?utf-8?B?dVVjSDBwYnNTdGVKeVc1SW5BWFB6NlFQR0RaQVpoU0ZsdHh6a0FHODd2TlNw?=
 =?utf-8?B?dEg1TDlwOVliandyV2o4d0xFK3NmZEhmazBFeHE2OFd6dnRxN0pyWTZzUDBt?=
 =?utf-8?B?NU9naWFTOXZndXZvcGUzWWZqQUpPSVZEcUhEa1N4WUNVYVF5TU1NMWtpU01B?=
 =?utf-8?B?WEVqRkc5NEYrN3lycnhkS1Y3MkhPMmwxMDV4ZkFrejZrY1R4UHNaNUNQblph?=
 =?utf-8?B?WkVScTFDTlhQSitQaGNZUnJqalhXcExyZ2k0T285eEx2ZDNKeUt0YjcvTWEx?=
 =?utf-8?B?eSt2K3l6dmhHSVY4L0V4ZmplVHo3R0tNUmo2NWM0SjV5NW1wd0lqallqZUZt?=
 =?utf-8?B?VExIRHordnNSdksrV3hReW9CSzEvVnBwc2JTMWg3alljWHBDTUMrdzltdWR4?=
 =?utf-8?B?dWEzcFFwcWRsOXpqRVBkNGdtOUgwTmdycUhnSEZXOHY2SnI0QWQvWEM2Mllw?=
 =?utf-8?B?SzE3TGlaZFJtMTRYcng2Yk5qWk5zZlYxMkhSOVV3WDkxcnRZM0FGeGVEaUor?=
 =?utf-8?B?ejZLL09meTNvNUtYMG9qUE9RSFlzQ2ZXdEU1Q0pwTk9OeDMra01KMVc1ZGxs?=
 =?utf-8?B?anlwdkRrcHJ5YllpU0NCeWorZkdNNjZqUVpvWGNXcGF1V0UwUk1VSS90Ky9o?=
 =?utf-8?B?MHU0NVJURXFENGpKN3NzelhCRWFYdjd4ZzJtQ1hta2Q2cHlnbWI4WjdVZXRR?=
 =?utf-8?B?K0UxTHJQTUpNZW9URjUyOXBKRk1PK2ExS1FIbnJmYStDRWdma3ZqQTFOUEV6?=
 =?utf-8?B?TFVZa2V5Um84MWZQb0VrVDJNTXRNa1B2andKNEFmTlpYcVBNeHpHaGg1UDk0?=
 =?utf-8?B?WUVPd1lNOHFzL2kvUWdERzZlNlB5TEhod0FHZy9HK1J5eHU5aTYvczBIUytr?=
 =?utf-8?B?REtIdDg1WTUzVWY1ZDNIZUxFNURhZUF4MFRXUTFaK1BYNVR4ZllFSzlXZHlj?=
 =?utf-8?B?bTFNMWh0dXFKLzBUbGtYU1M4TTMwb0pyU0ZjQjF3cDF5dTdUSEZUSGd4REJx?=
 =?utf-8?B?czBEaWVQZGh1bit6OWhlK3ZKazJHQ1IzRmxETENSZXhYbjZFM0tkNlZHbGgv?=
 =?utf-8?B?cEJxK1NWei95SDdYdjFDUzhJaTMrS0oxQ3huT01kTkpmTmFWRnlrTCt4bTVH?=
 =?utf-8?B?UWU4REpnZ2pSOFJFNGxnbXJZRUFtT3dUa1FhOGRMSnFTaWF5OGJNMjYvVk5G?=
 =?utf-8?B?eHZFOTlrWXAxTXR4dHo0ZThDZy9VZysvOUJaWVpRUnh1eGtkQnBNd1VwL0pw?=
 =?utf-8?B?eDlIRjFvRjVrQTdkY21lRm5pVGFKeGxhZ1FMdGNYVTJWaXN4Q0NMdmNMNUhJ?=
 =?utf-8?B?N2hyRlU5NzN4YlJnUi9oTXhsM2YzMnUwSW5hT0IwNlh2MGdMUHJ4UWUwZmdY?=
 =?utf-8?B?TXZWSUY1NEwyNS8wZTNvcGlubGduTElMdmtHY2FlTENhWWx1cWtyK0JZSHlu?=
 =?utf-8?B?QXk5aE45dE9KV0lMNm1wUklsTG1KK3VHSVNNVUlEZ001OVVRRzh3Ylh5U0xv?=
 =?utf-8?B?Nk9KajVndGc0Z3l3UUZoVVZ1VWxNVXBvSzNMOG9yMXNNQjY3N0QrTExaakNR?=
 =?utf-8?B?ZitiRXVPeU5HOVNTS3FOcjFyaVFORXJtQXN0NUcxdHBOZVRVNWdSTTJkZG95?=
 =?utf-8?B?d2owaDVXMkt2V05GRzhrMWdyUmM0b2c5Q05abWpOVVUwckNDMFJoVHNlbDcv?=
 =?utf-8?B?N2lDbG9pTjlKYmFpRzA2MHFPMlRILzJucy9ZNmZyNytVdDdqNTdKbWUyVTBi?=
 =?utf-8?B?UUZ3cU1pN3FnZEdBclhYNVAvMkJJRVQvT3hQaThpalk2cDYvMWN4SXFhVHFy?=
 =?utf-8?B?V2JVaG1mcXFZT0luTUxUdWVCKzRhalN0N2dwZHRyNUE1MGhGSDVqaWNVUjA0?=
 =?utf-8?B?OGtTWHQ0bHFPcVd2VjByZ2FZTU9IdTVIcGVUVnhoZlE3S3dVekNvTVBPaGJJ?=
 =?utf-8?B?L2w4U1NXQ2J4NUhXRStaeWpMRDRiL1JtNXFKbWsrdkcwa1RBOU9XUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34bf6984-4433-4069-ab94-08de63b84fae
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 06:40:39.5141 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vd8L2IKkigr4SL2nSF8BglAKu9sTm7bVFlw6y/6eZYdP/lMmwzQ+s3FksWS/zLp55h6GYF7g1+ssJxWbI0caf8ilU5hQrWzfspMF8SSSdVY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5901
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=kane_chen@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 04 Feb 2026 02:17:22 -0500
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

Q29ubmVjdCB0aGUgUFdNIGRldmljZSB0byBBU1QxNzAwIG1vZGVsLgoKU2lnbmVkLW9mZi1ieTog
S2FuZS1DaGVuLUFTIDxrYW5lX2NoZW5AYXNwZWVkdGVjaC5jb20+ClJldmlld2VkLWJ5OiBD77+9
ZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPgpSZXZpZXdlZC1ieTogTmFiaWggRXN0ZWZh
biA8bmFiaWhlc3RlZmFuQGdvb2dsZS5jb20+ClRlc3RlZC1ieTogTmFiaWggRXN0ZWZhbiA8bmFi
aWhlc3RlZmFuQGdvb2dsZS5jb20+Ci0tLQogaW5jbHVkZS9ody9hcm0vYXNwZWVkX2FzdDE3MDAu
aCB8ICAyICsrCiBody9hcm0vYXNwZWVkX2FzdDE3MDAuYyAgICAgICAgIHwgMTMgKysrKysrKysr
KysrKwogMiBmaWxlcyBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvaW5j
bHVkZS9ody9hcm0vYXNwZWVkX2FzdDE3MDAuaCBiL2luY2x1ZGUvaHcvYXJtL2FzcGVlZF9hc3Qx
NzAwLmgKaW5kZXggZWUwYzQ3ZDE3My4uOGRiNTEzYTM4YyAxMDA2NDQKLS0tIGEvaW5jbHVkZS9o
dy9hcm0vYXNwZWVkX2FzdDE3MDAuaAorKysgYi9pbmNsdWRlL2h3L2FybS9hc3BlZWRfYXN0MTcw
MC5oCkBAIC0xNCw2ICsxNCw3IEBACiAjaW5jbHVkZSAiaHcvZ3Bpby9hc3BlZWRfZ3Bpby5oIgog
I2luY2x1ZGUgImh3L2kyYy9hc3BlZWRfaTJjLmgiCiAjaW5jbHVkZSAiaHcvbWlzYy9hc3BlZWRf
bHRwaS5oIgorI2luY2x1ZGUgImh3L21pc2MvYXNwZWVkX3B3bS5oIgogI2luY2x1ZGUgImh3L3Nz
aS9hc3BlZWRfc21jLmgiCiAjaW5jbHVkZSAiaHcvd2F0Y2hkb2cvd2R0X2FzcGVlZC5oIgogI2lu
Y2x1ZGUgImh3L2NoYXIvc2VyaWFsLW1tLmgiCkBAIC00MCw2ICs0MSw3IEBAIHN0cnVjdCBBc3Bl
ZWRBU1QxNzAwU29DU3RhdGUgewogICAgIEFzcGVlZFNDVVN0YXRlIHNjdTsKICAgICBBc3BlZWRH
UElPU3RhdGUgZ3BpbzsKICAgICBBc3BlZWRJMkNTdGF0ZSBpMmM7CisgICAgQXNwZWVkUFdNU3Rh
dGUgcHdtOwogICAgIEFzcGVlZFdEVFN0YXRlIHdkdFtBU1QxNzAwX1dEVF9OVU1dOwogfTsKIApk
aWZmIC0tZ2l0IGEvaHcvYXJtL2FzcGVlZF9hc3QxNzAwLmMgYi9ody9hcm0vYXNwZWVkX2FzdDE3
MDAuYwppbmRleCA1OTk1NGVjYTk5Li5jMGIyODhhMGZjIDEwMDY0NAotLS0gYS9ody9hcm0vYXNw
ZWVkX2FzdDE3MDAuYworKysgYi9ody9hcm0vYXNwZWVkX2FzdDE3MDAuYwpAQCAtMTgsNiArMTgs
NyBAQAogCiBlbnVtIHsKICAgICBBU1BFRURfQVNUMTcwMF9ERVZfU1BJMCwKKyAgICBBU1BFRURf
QVNUMTcwMF9ERVZfUFdNLAogICAgIEFTUEVFRF9BU1QxNzAwX0RFVl9TUkFNLAogICAgIEFTUEVF
RF9BU1QxNzAwX0RFVl9BREMsCiAgICAgQVNQRUVEX0FTVDE3MDBfREVWX1NDVSwKQEAgLTMxLDYg
KzMyLDcgQEAgZW51bSB7CiAKIHN0YXRpYyBjb25zdCBod2FkZHIgYXNwZWVkX2FzdDE3MDBfaW9f
bWVtbWFwW10gPSB7CiAgICAgW0FTUEVFRF9BU1QxNzAwX0RFVl9TUEkwXSAgICAgID0gIDB4MDAw
MzAwMDAsCisgICAgW0FTUEVFRF9BU1QxNzAwX0RFVl9QV01dICAgICAgID0gIDB4MDAwQzAwMDAs
CiAgICAgW0FTUEVFRF9BU1QxNzAwX0RFVl9TUkFNXSAgICAgID0gIDB4MDBCQzAwMDAsCiAgICAg
W0FTUEVFRF9BU1QxNzAwX0RFVl9BRENdICAgICAgID0gIDB4MDBDMDAwMDAsCiAgICAgW0FTUEVF
RF9BU1QxNzAwX0RFVl9TQ1VdICAgICAgID0gIDB4MDBDMDIwMDAsCkBAIC0xMzAsNiArMTMyLDE0
IEBAIHN0YXRpYyB2b2lkIGFzcGVlZF9hc3QxNzAwX3JlYWxpemUoRGV2aWNlU3RhdGUgKmRldiwg
RXJyb3IgKiplcnJwKQogICAgICAgICAgICAgICAgICAgICAgICAgYXNwZWVkX2FzdDE3MDBfaW9f
bWVtbWFwW0FTUEVFRF9BU1QxNzAwX0RFVl9JMkNdLAogICAgICAgICAgICAgICAgICAgICAgICAg
c3lzYnVzX21taW9fZ2V0X3JlZ2lvbihTWVNfQlVTX0RFVklDRSgmcy0+aTJjKSwgMCkpOwogCisg
ICAgLyogUFdNICovCisgICAgaWYgKCFzeXNidXNfcmVhbGl6ZShTWVNfQlVTX0RFVklDRSgmcy0+
cHdtKSwgZXJycCkpIHsKKyAgICAgICAgcmV0dXJuOworICAgIH0KKyAgICBtZW1vcnlfcmVnaW9u
X2FkZF9zdWJyZWdpb24oJnMtPmlvbWVtLAorICAgICAgICAgICAgICAgICAgICAgICAgYXNwZWVk
X2FzdDE3MDBfaW9fbWVtbWFwW0FTUEVFRF9BU1QxNzAwX0RFVl9QV01dLAorICAgICAgICAgICAg
ICAgICAgICAgICAgc3lzYnVzX21taW9fZ2V0X3JlZ2lvbihTWVNfQlVTX0RFVklDRSgmcy0+cHdt
KSwgMCkpOworCiAgICAgLyogTFRQSSBjb250cm9sbGVyICovCiAgICAgaWYgKCFzeXNidXNfcmVh
bGl6ZShTWVNfQlVTX0RFVklDRSgmcy0+bHRwaSksIGVycnApKSB7CiAgICAgICAgIHJldHVybjsK
QEAgLTE4Myw2ICsxOTMsOSBAQCBzdGF0aWMgdm9pZCBhc3BlZWRfYXN0MTcwMF9pbnN0YW5jZV9p
bml0KE9iamVjdCAqb2JqKQogICAgIG9iamVjdF9pbml0aWFsaXplX2NoaWxkKG9iaiwgImlvZXhw
LWkyYyIsICZzLT5pMmMsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgImFzcGVlZC5pMmMt
YXN0MjcwMCIpOwogCisgICAgLyogUFdNICovCisgICAgb2JqZWN0X2luaXRpYWxpemVfY2hpbGQo
b2JqLCAicHdtIiwgJnMtPnB3bSwgVFlQRV9BU1BFRURfUFdNKTsKKwogICAgIC8qIExUUEkgY29u
dHJvbGxlciAqLwogICAgIG9iamVjdF9pbml0aWFsaXplX2NoaWxkKG9iaiwgImx0cGktY3RybCIs
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJnMtPmx0cGksIFRZUEVfQVNQRUVEX0xUUEkp
OwotLSAKMi40My4wCg==

