Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3551FC021B2
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 02:24:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlIhQ-0002FP-LY; Thu, 20 Feb 2025 21:23:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tlIhO-0002F7-FB; Thu, 20 Feb 2025 21:23:30 -0500
Received: from mail-tyzapc01on2072d.outbound.protection.outlook.com
 ([2a01:111:f403:2011::72d]
 helo=APC01-TYZ-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tlIhL-0006rD-GY; Thu, 20 Feb 2025 21:23:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wr+k748QBOv5I5WptjAYDjZ+QHab7xknpNIM4n38bIzLEA5fthurDLMF5FGurXBgjBovvgmAhikZhI2on+6ilvrx3TbhXpDW2fgTqNrFpFYejt0CvWxqm5tx475Zscd1i+UtOj1DUNqpMuySIjGf1biea0YCRHx5Qln35RXZymcal3n7HQ2xwc9khCHDG1v3rwpiVHmtQZb7NS53O6jNmBlCR6MtTCx738d74vWgSAxIX92MVhx2G34hZQrSDpJq6AJ4ePIOUTsXWWUV/ScGCKu8ddWcwMQ1SzjUl9I/sxG/glJjLhGhRafmipSSLljLTRueRoF6kyrNA80YUlr/fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rxhxOWPrbcQ5uM5fOvRMBqWfbFz3OcnCRW3nOXSHKrk=;
 b=d5UVm+71K8qih2dV3wH5ntL7ha3adVrcWQ343SELOzP0rrxCtrqCi//Tn5+Zrf/0AW8xCqcS63wO9alwRB1pTByu0W8SmZiTdy/7vrt13msJpLjq7v1aC3nbhwyqU6dPUTQY7ffByCmHEryAIaWE4V2MivE4XzFQhii3dNCFhb2nBrVnrBuQPyvr5Yej7N7D9/7o/F/M1rdJwb2dEGFe8QFlGE8zA83aT5/Xlq7UH8BVuY17j1gRr3NvAEDBCDQLBsaMD1CFfwOOKMk+G/SOQWjC2AzW9kWV2QVwGc93RVoCoF0ZE+FCL7uevGvR8OB/MnFtH7SYDD0ERsszX7r79g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxhxOWPrbcQ5uM5fOvRMBqWfbFz3OcnCRW3nOXSHKrk=;
 b=RvWpqiFooiycbp8CjOjW73Gx3zkUykycn41AhGPV1/3hKuAyko2Nk6mUR2FlzA9Ek8i5F7ud79ooYtwmITFUuLmZEfrqm7bz8zxMKefqtSFdLkoSF/pDoGzCT0H7N4V7jejNG3skrHsCrJ56bD+oNdnZLBWARFro8nkDVU674LTByLhEfl487yNLown0xPctgoJ/LhfLvqq7+o67lvaCePBcfG5kWSSa6eRpoAC7tajngVDvyiHcw3NqyZWxofopSC/P40iSu8R+2+SFo5zphdB17Rt1E9JsLhFlES8FEv59b9hegzfVixlsnazofyCf5NqwN7zksYnFot4qjOmCow==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 KL1PR0601MB5861.apcprd06.prod.outlook.com (2603:1096:820:bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 02:23:13 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 02:23:13 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v3 04/28] hw/arm/aspeed: Rename IRQ table and machine name
 for AST2700 A0
Thread-Topic: [PATCH v3 04/28] hw/arm/aspeed: Rename IRQ table and machine
 name for AST2700 A0
Thread-Index: AQHbfchcRH9q/wqGwkek4B3r6e9587NMlagAgAR8H2A=
Date: Fri, 21 Feb 2025 02:23:13 +0000
Message-ID: <SI2PR06MB50418E5359B59E7902B84A05FCC72@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250213033531.3367697-1-jamin_lin@aspeedtech.com>
 <20250213033531.3367697-5-jamin_lin@aspeedtech.com>
 <f3dd3423-8f6d-48ce-80f2-3381550948b7@kaod.org>
In-Reply-To: <f3dd3423-8f6d-48ce-80f2-3381550948b7@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|KL1PR0601MB5861:EE_
x-ms-office365-filtering-correlation-id: 712bf8f1-06a7-40b1-4b25-08dd521eb18c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RXBKNW9uT2xQN1YwejBZeFFkS0QwSG9QaW1nQWJLcU10bWdKajBwSmpPaGIx?=
 =?utf-8?B?UERQRGl5bFJONkcyaCs2N2lHRzdwd1hZTEczZ0VRTTVPOGtTVXN4Z3VEVlhR?=
 =?utf-8?B?TUpTT0ZPM1lUVUhyTHFIMjJhVzFVeEU0emlHakhWOXVBeUlQaTZBc2hhQ0RT?=
 =?utf-8?B?WHhvVldYWkptaHE1cW9Ha25nZGcvYnJKMFRhSVB3N29vTmhad1BkaXBJcWpW?=
 =?utf-8?B?c2JPczlvbHNiT1F4WmVJbVVidnhabkdMby9aWjFhUG54bTBoUW5xMjdHYUVy?=
 =?utf-8?B?Wko5R1ZqSVkyNU5WUVV6aVRubmpRTlhIaTg5UTBHTXQybzZDNTR6VHdoTnVs?=
 =?utf-8?B?WXExVXRRc3FsSldCempHRVlyNk9sT05ZMmNUdzNkODYrb3NaR2p1QUxxL3Z0?=
 =?utf-8?B?bWVzSWhiZ2xGajc5cGJneHdYMGVGZTlzOWtxZjRXV0xHNnVpQnVIZWJ6VEc5?=
 =?utf-8?B?SDU3MStEUndJZDFiYTZWM09aYW55U0xuR3pwc2ZxR3lsMEFpUGZoN2Uvc2Rv?=
 =?utf-8?B?YU9lWlJ5bHFLck52djU1U1ZSajdKb3VtWklrbGJEMHF3bVdkQUVxS3JhbkRm?=
 =?utf-8?B?K1JocyszZzZ0L2l1UGRQZ3lZRVpKakQzQ3hWVVVpWmpWdEpISWtXR3BSZlVo?=
 =?utf-8?B?UDZjVGM0TlIvU0xvOENDYTR2OWZzbWZzcmxLTkh2V0NBWXpRbWlsUDlJdllo?=
 =?utf-8?B?WjRHWGZPOWtlNlFJYkp4RkFndDY4MUtUaW92YXBOU09MNGFCZEFhNXRXaUVE?=
 =?utf-8?B?NUdxWWdUcEZZZHl1VmVQMDNjUC9QcjcvSmZ5RHlMbkZ3NHhVNFFtQmNZb01U?=
 =?utf-8?B?amp5R2JWUThNQ2FvRitBa2ZpUk56V2RUY2hyMURvL2kwaWd2L3VwdzlKenNC?=
 =?utf-8?B?bkJvVFBNMHZWUEprRDk5a2ZRaGNWMVFFSTFBVjF4bU1lNFpMaUNRdFNVcWlW?=
 =?utf-8?B?dDA5dGorSE9oOGpScW1DV0pacUd3aDVCVzZxY1JXUjYrVnpuM3dMU1lNZ2dq?=
 =?utf-8?B?TzlvRkpNaXBZcFViNzIyeXVlOXRrOFNCdUNOYk9PbFQxQVlkZjJBYXZxNC80?=
 =?utf-8?B?U2pqZC92Y1lIeGxJd0d5Sm5VYjI3b09NOUhTZXN2Ny9zUGVnR09qcnB6L0Mw?=
 =?utf-8?B?MktwSHF2RUdmNzdVV1I4Q1c5Ui9IQTVzMW1uS1hDR1U2ckhVaGMrVkt4dzJs?=
 =?utf-8?B?WE9JS0R4SUE2a1I3OFoxRGNVbmVCVTVFVG5UV3VpNUx2Y1FXRGpOTE1nVmxD?=
 =?utf-8?B?dFJzNlBudnllbFQzRUdpZTIxZ2doMVA4V3pvek5UcXVIT21BdzRQeXNJd1pa?=
 =?utf-8?B?ZDQ5MmlVbkdBMTNkUFZLNVhmUWVxK1NFZ3B3V0YzcmMweU9UZkVjVmxNVXZM?=
 =?utf-8?B?VVpQdDZmaElaTU40WG1MTUtPUDE0Mk1RaklMVDFvOTRPUUJjUDdobWJBQlhJ?=
 =?utf-8?B?OCtGQjNySlRNQTBWaGVJNHMrOEFKNFZObkVlZUIzTzdpN3JlZTZudnIyR1Qy?=
 =?utf-8?B?bndrcHRrengyV1djLzd0SDg3TFFwVStqSzZRQkJIclNoVVRZVjd4NXo1UGdC?=
 =?utf-8?B?RDQvNG1XMGlKSlRpREw2N0xGVkVDeWJ3WHRIZkxiOW40Yk1FT25IRVJMd1NC?=
 =?utf-8?B?LzMwYlZ6V1ZHUXZtVkhqK1ZtUW4xbno2dk9kcUxNTVNUcHV4Q2gyZmNNOHQr?=
 =?utf-8?B?eDNwY3M1OHVKbXRKL1pLTGo3cjBmU255Z0E5OGR1K2JLaWo5elZtQytGVjIx?=
 =?utf-8?B?b0NHZkFxeklNTTUzRDlNTWZ5SytkSjVEQXZ6bXJSUWltVnVYNEtFSlNiZTZv?=
 =?utf-8?B?U2JyNFREREpaVTg1NUhOd0pYYnJWbzEvS3hiN0dRR2c5aUJNYnFLZUIzdkQ3?=
 =?utf-8?Q?mXU3OmGAJH5EE?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RVFBWEQ2SUduU1NLZjloajRTT1pxVXNsVG5hN2dubEZ2dkFJdm43NVNYRkE1?=
 =?utf-8?B?OHpVNWtKbmdXWmE3RC9OTG1NRGgvZnZrYkR3TFIxK0JYd3BQTUlLbmRWQmZt?=
 =?utf-8?B?dUU3bzdvMU1nTjdPWHlueXlBS1lBT1Zad0hNTE5BWHdzNWIyajJHamVIV2Ru?=
 =?utf-8?B?VkNXTW1TZUUwbzJnWk52UEd3dVc3Q1N1UDNZQk8zWkN1b1FmRURIakhDQk5S?=
 =?utf-8?B?dzNqQXRpWTdIM3NVMDlJaUdpdHY2Zk0wZ2hVYkdYeDRMS0VjbnRyNWRNaVZs?=
 =?utf-8?B?ZUtOeWYzTmMzQzBKQUVXZkoyUGtTQ2RDcS9sam5qQWdmMmdoaThYK1JKRXl5?=
 =?utf-8?B?eW8zbC9HdXVoNDh5blRnemgyVG5XcG94STQ5dXd3SnlJSnpXbGc5NXN5c1Ra?=
 =?utf-8?B?R3NDTnJxK3RPSFR0UmRnSmhseVNCUUVWSThEZ01TY2R6R2IzeVVFV3IyY2Zs?=
 =?utf-8?B?V1ZQUDdTRGdzOFpNbnNvOHZyRTRRQTVSK3RUblo4bVlRSlh4ME45M3k0QXll?=
 =?utf-8?B?TGhsd29VTXBjSnZhS3BvWXJGVWRCUm54alRGQ2N0RnRqZTBuUEtFdVAvcDRF?=
 =?utf-8?B?L2V5NlB6TnhZT09KdHMrblVNdXhOaUNjU2ExRnJlUWhLQmRrM1Q2NXF5UDhx?=
 =?utf-8?B?eFFtSmozNUM2MHNzYTFaRkxabmtjUUZEcDUzT0pXbFdXMXpLQ0RRU3NCOHp4?=
 =?utf-8?B?eHVQMVU5WFRleWY0RGw4LytHZUt6WHdDbi9CSDFoM3J5MlBtVE82VkRFeXh0?=
 =?utf-8?B?VVQ4eGRqbVFxSU1USEdjZTE0dC9RNCthT3hBMm1WdCs1c3lTNGM4ZU5YY24r?=
 =?utf-8?B?SmNQdS9tVnZUcVVHd3o0K3BoUGNON0M2ampUYUVHQUdsTlJ0QVpMSmtwTmZi?=
 =?utf-8?B?OXFpRnlEY2YrNnIzNEhFRmVmYnp3YmMzYkZub3d2WUNITGV2UW1sdmc2SVpu?=
 =?utf-8?B?QU5tUzMvQVJRZXdHSXc3aUNLVzRrWU8xakpIN1VwdDltUjZjakNDSnVTT2hZ?=
 =?utf-8?B?TW5HWHE0WGhZdVdNc25uMnJMeXFHdHhUbkR3T1YxZlZUM056WG1HdnYyRm16?=
 =?utf-8?B?dXR0NU1XcmYzbUxpa2UvVCtEMGlBTVBZc2x0UUpkRTRRSDc2d3c1bWJLT1Rm?=
 =?utf-8?B?TzJOY2N6aVB5V2l0bE4vUU9tZDc5VHgwTmYzckhuUklodGxXNFZEd2R4N1F0?=
 =?utf-8?B?U2VPZ1lNQ2pRbTVtcVpiVk5DWENSTDRFaFV6NkdodUlNZmljS3JlakJ2b1hj?=
 =?utf-8?B?dVpmaC9ocll3UXJPQXNST3VrVlZEWHpsM1dyYjhiNGJkamtLQXJPZmJWTndx?=
 =?utf-8?B?NncwRHVIWkFhWGFYNHloYWhEcWEwR0hvSnNUTU1YRnpubUNsS1FjUE42dGg5?=
 =?utf-8?B?bHJWd1cvd0lMNjVOVGk5V3UzVDdKMUtINGJpbU5RbjdzZU5QWStTSFRpMjdY?=
 =?utf-8?B?ZjZ4TFpnQUNVRmI4b2ZDOC9Gb3RsR1hFdm9KQjZWblVPckc0WlY5cG1XSUp6?=
 =?utf-8?B?MlpxMmxCZlJ6aU9lNVJLaU9qZ3l3YmN0WWJvMjBycWhudWhzamZkeEc5V09H?=
 =?utf-8?B?Vm02V3J3aElFb1pTcUNnc0dKREM0M1pxQUZvRGV0ejFOdDA0dW9wemFXZTlQ?=
 =?utf-8?B?M1pzdFpmZ2F4bTVaVWFuU0VuZS9xdkJXUXd4Rm1wdDlUTjVzRSt1T2t1dmdP?=
 =?utf-8?B?WDJnUGxMeU9vRnNnNjAycThJNzd2OVh5cFBmSkZQNElmQUlWUk9Jc3IvVklW?=
 =?utf-8?B?Z0NaaXFwWEFaU1E0eDRCWkoyZWdWS0ZQQzYrdHVlR1pUYTdmc0xIOWlNRkN4?=
 =?utf-8?B?aTVqQURBWjVsYVdUNE9wZG9RQUIxY0QvdU8rcG56MXluR1hvelVYNGFXUlVi?=
 =?utf-8?B?SzRYWGYweTZBQ0hlWU52Wk0rT0NJK1BpM01VRk5KN1JSM2FWZmRGRlBWMXpz?=
 =?utf-8?B?bVFpdzAxd2VzbHd2MnhlR01ranpyUjJLTU9sS1dicnRRdVNsSGl6Zk91K1I5?=
 =?utf-8?B?MlV1ZzJGS0kzOEppaVlUcHFGYkl5QUU2aWJUVjh1dDhVNlZjcXlTamxQeDhv?=
 =?utf-8?B?RlIybFE1R1NnenJ1cnlQUmhsTkFsV2JhMXBDbzNhNWttd1FyUVJiWVlMYk9s?=
 =?utf-8?Q?IsPft20Z+GtYuH5KJK9eth+KE?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 712bf8f1-06a7-40b1-4b25-08dd521eb18c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 02:23:13.7549 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cJMiiXSv0GVRm4Fa369Xj4u4ELWrqfospHPKEGZS9MFrQVB3U0cOMcfmi+KX1pudPgBKNbc1hg8Kp1qG2ywQ/Q3y2YxxdWA+5OoJrSgyh4s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5861
Received-SPF: pass client-ip=2a01:111:f403:2011::72d;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-TYZ-obe.outbound.protection.outlook.com
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

SGkgQ2VkcmljLA0KDQo+IENjOiBUcm95IExlZSA8dHJveV9sZWVAYXNwZWVkdGVjaC5jb20+DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMDQvMjhdIGh3L2FybS9hc3BlZWQ6IFJlbmFtZSBJUlEg
dGFibGUgYW5kIG1hY2hpbmUNCj4gbmFtZSBmb3IgQVNUMjcwMCBBMA0KPiANCj4gT24gMi8xMy8y
NSAwNDozNSwgSmFtaW4gTGluIHdyb3RlOg0KPiA+IEN1cnJlbnRseSwgQVNUMjcwMCBTb0Mgb25s
eSBzdXBwb3J0cyBBMC4gVG8gc3VwcG9ydCBBU1QyNzAwIEExLCByZW5hbWUNCj4gPiBpdHMgSVJR
IHRhYmxlIGFuZCBtYWNoaW5lIG5hbWUuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYW1pbiBM
aW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGh3L2FybS9hc3Bl
ZWQuYyAgICAgICAgIHwgOCArKysrLS0tLQ0KPiA+ICAgaHcvYXJtL2FzcGVlZF9hc3QyN3gwLmMg
fCA4ICsrKystLS0tDQo+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgOCBk
ZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9ody9hcm0vYXNwZWVkLmMgYi9ody9h
cm0vYXNwZWVkLmMgaW5kZXgNCj4gPiBkOTQxOGUyYjlmLi42ZGRmZGJkZWJhIDEwMDY0NA0KPiA+
IC0tLSBhL2h3L2FybS9hc3BlZWQuYw0KPiA+ICsrKyBiL2h3L2FybS9hc3BlZWQuYw0KPiA+IEBA
IC0xNjU0LDEyICsxNjU0LDEyIEBAIHN0YXRpYyB2b2lkDQo+IGFzdDI3MDBfZXZiX2kyY19pbml0
KEFzcGVlZE1hY2hpbmVTdGF0ZSAqYm1jKQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIFRZUEVfVE1QMTA1LCAweDRkKTsNCj4gPiAgIH0NCj4gPg0KPiA+IC1zdGF0aWMgdm9pZCBh
c3BlZWRfbWFjaGluZV9hc3QyNzAwX2V2Yl9jbGFzc19pbml0KE9iamVjdENsYXNzICpvYywNCj4g
PiB2b2lkICpkYXRhKQ0KPiA+ICtzdGF0aWMgdm9pZCBhc3BlZWRfbWFjaGluZV9hc3QyNzAwYTBf
ZXZiX2NsYXNzX2luaXQoT2JqZWN0Q2xhc3MgKm9jLA0KPiA+ICt2b2lkICpkYXRhKQ0KPiA+ICAg
ew0KPiA+ICAgICAgIE1hY2hpbmVDbGFzcyAqbWMgPSBNQUNISU5FX0NMQVNTKG9jKTsNCj4gPiAg
ICAgICBBc3BlZWRNYWNoaW5lQ2xhc3MgKmFtYyA9IEFTUEVFRF9NQUNISU5FX0NMQVNTKG9jKTsN
Cj4gPg0KPiA+IC0gICAgbWMtPmRlc2MgPSAiQXNwZWVkIEFTVDI3MDAgRVZCIChDb3J0ZXgtQTM1
KSI7DQo+ID4gKyAgICBtYy0+ZGVzYyA9ICJBc3BlZWQgQVNUMjcwMCBBMCBFVkIgKENvcnRleC1B
MzUpIjsNCj4gPiAgICAgICBhbWMtPnNvY19uYW1lICA9ICJhc3QyNzAwLWEwIjsNCj4gPiAgICAg
ICBhbWMtPmh3X3N0cmFwMSA9IEFTVDI3MDBfRVZCX0hXX1NUUkFQMTsNCj4gPiAgICAgICBhbWMt
Pmh3X3N0cmFwMiA9IEFTVDI3MDBfRVZCX0hXX1NUUkFQMjsgQEAgLTE3OTUsOSArMTc5NSw5DQo+
IEBADQo+ID4gc3RhdGljIGNvbnN0IFR5cGVJbmZvIGFzcGVlZF9tYWNoaW5lX3R5cGVzW10gPSB7
DQo+ID4gICAgICAgICAgIC5jbGFzc19pbml0ICAgICA9DQo+IGFzcGVlZF9taW5pYm1jX21hY2hp
bmVfYXN0MTAzMF9ldmJfY2xhc3NfaW5pdCwNCj4gPiAgICNpZmRlZiBUQVJHRVRfQUFSQ0g2NA0K
PiA+ICAgICAgIH0sIHsNCj4gPiAtICAgICAgICAubmFtZSAgICAgICAgICA9IE1BQ0hJTkVfVFlQ
RV9OQU1FKCJhc3QyNzAwLWV2YiIpLA0KPiA+ICsgICAgICAgIC5uYW1lICAgICAgICAgID0gTUFD
SElORV9UWVBFX05BTUUoImFzdDI3MDBhMC1ldmIiKSwNCj4gDQo+IG1hY2hpbmUgImFzdDI3MDAt
ZXZiIiBoYXMgbm93IGRpc2FwcGVhcmVkIGZyb20gUUVNVS4gWW91IG5lZWQgdG8gYWRkIGFuDQo+
IGFsaWFzIHdpdGggIm1jLT5hbGlhcyIgdG8gcmVzdG9yZSB0aGUgaW5pdGlhbCBtYWNoaW5lIG5h
bWUsIG9yIGZvbGxvdyB0aGUNCg0KDQpXaWxsIGFkZA0KDQo+IGRlcHJlY2F0aW9uIHByb2Nlc3Mg
Og0KPiANCj4gICAgaHR0cHM6Ly9xZW11LnJlYWR0aGVkb2NzLmlvL2VuL3Y5LjIuMC9hYm91dC9k
ZXByZWNhdGVkLmh0bWwNCj4gDQpUaGFua3MgZm9yIGxldHRpbmcgbWUga25vdyBhYm91dCB0aGUg
bWFjaGluZSBkZXByZWNhdGlvbiBydWxlcy4NCkkgdW5kZXJzdGFuZCB3aHkgeW91IHN1Z2dlc3Qg
YWxpYXNpbmcgdGhlIGluaXRpYWwgbWFjaGluZSAiYXN0MjcwMC1ldmIiIHRvICJhc3QyNzAwYTAt
ZXZiLiINCg0KVG8gZm9sbG93IHRoZSBtYWNoaW5lIGRlcHJlY2F0aW9uIHJ1bGUsIHRoZSBpbml0
aWFsIG1hY2hpbmUgImFzdDI3MDAtZXZiIiBpcyBhbGlhc2VkIHRvICJhc3QyNzAwYTAtZXZiLiIN
CkluIHRoZSBmdXR1cmUsIHdlIHdpbGwgYWxpYXMgImFzdDI3MDAtZXZiIiB0byBuZXcgU29Dcywg
c3VjaCBhcyAiYXN0MjcwMGExLWV2Yi4iDQpEb2VzIHRoaXMgcHJvZ3Jlc3MgbWVldCB5b3VyIGV4
cGVjdGF0aW9ucz8NCg0KVGhhbmtzLUphbWluDQoNCj4gVGhhbmtzLA0KPiANCj4gQy4NCj4gDQo+
IA0KPiANCj4gPiAgICAgICAgICAgLnBhcmVudCAgICAgICAgPSBUWVBFX0FTUEVFRF9NQUNISU5F
LA0KPiA+IC0gICAgICAgIC5jbGFzc19pbml0ICAgID0gYXNwZWVkX21hY2hpbmVfYXN0MjcwMF9l
dmJfY2xhc3NfaW5pdCwNCj4gPiArICAgICAgICAuY2xhc3NfaW5pdCAgICA9IGFzcGVlZF9tYWNo
aW5lX2FzdDI3MDBhMF9ldmJfY2xhc3NfaW5pdCwNCj4gPiAgICNlbmRpZg0KPiA+ICAgICAgIH0s
IHsNCj4gPiAgICAgICAgICAgLm5hbWUgICAgICAgICAgPSBUWVBFX0FTUEVFRF9NQUNISU5FLA0K
PiA+IGRpZmYgLS1naXQgYS9ody9hcm0vYXNwZWVkX2FzdDI3eDAuYyBiL2h3L2FybS9hc3BlZWRf
YXN0Mjd4MC5jIGluZGV4DQo+ID4gMmQwYzk5ZjE1OS4uNmUzMzc1ZjVkMyAxMDA2NDQNCj4gPiAt
LS0gYS9ody9hcm0vYXNwZWVkX2FzdDI3eDAuYw0KPiA+ICsrKyBiL2h3L2FybS9hc3BlZWRfYXN0
Mjd4MC5jDQo+ID4gQEAgLTcyLDcgKzcyLDcgQEAgc3RhdGljIGNvbnN0IGh3YWRkciBhc3BlZWRf
c29jX2FzdDI3MDBfbWVtbWFwW10gPQ0KPiB7DQo+ID4gICAjZGVmaW5lIEFTVDI3MDBfTUFYX0lS
USAyNTYNCj4gPg0KPiA+ICAgLyogU2hhcmVkIFBlcmlwaGVyYWwgSW50ZXJydXB0IHZhbHVlcyBi
ZWxvdyBhcmUgb2Zmc2V0IGJ5IC0zMiBmcm9tDQo+ID4gZGF0YXNoZWV0ICovIC1zdGF0aWMgY29u
c3QgaW50IGFzcGVlZF9zb2NfYXN0MjcwMF9pcnFtYXBbXSA9IHsNCj4gPiArc3RhdGljIGNvbnN0
IGludCBhc3BlZWRfc29jX2FzdDI3MDBhMF9pcnFtYXBbXSA9IHsNCj4gPiAgICAgICBbQVNQRUVE
X0RFVl9VQVJUMF0gICAgID0gMTMyLA0KPiA+ICAgICAgIFtBU1BFRURfREVWX1VBUlQxXSAgICAg
PSAxMzIsDQo+ID4gICAgICAgW0FTUEVFRF9ERVZfVUFSVDJdICAgICA9IDEzMiwNCj4gPiBAQCAt
NzQwLDcgKzc0MCw3IEBAIHN0YXRpYyB2b2lkIGFzcGVlZF9zb2NfYXN0MjcwMF9yZWFsaXplKERl
dmljZVN0YXRlDQo+ICpkZXYsIEVycm9yICoqZXJycCkNCj4gPiAgICAgICBjcmVhdGVfdW5pbXBs
ZW1lbnRlZF9kZXZpY2UoImFzdDI3MDAuaW8iLCAweDAsIDB4NDAwMDAwMCk7DQo+ID4gICB9DQo+
ID4NCj4gPiAtc3RhdGljIHZvaWQgYXNwZWVkX3NvY19hc3QyNzAwX2NsYXNzX2luaXQoT2JqZWN0
Q2xhc3MgKm9jLCB2b2lkDQo+ID4gKmRhdGEpDQo+ID4gK3N0YXRpYyB2b2lkIGFzcGVlZF9zb2Nf
YXN0MjcwMGEwX2NsYXNzX2luaXQoT2JqZWN0Q2xhc3MgKm9jLCB2b2lkDQo+ID4gKypkYXRhKQ0K
PiA+ICAgew0KPiA+ICAgICAgIHN0YXRpYyBjb25zdCBjaGFyICogY29uc3QgdmFsaWRfY3B1X3R5
cGVzW10gPSB7DQo+ID4gICAgICAgICAgIEFSTV9DUFVfVFlQRV9OQU1FKCJjb3J0ZXgtYTM1Iiks
IEBAIC03NjMsNyArNzYzLDcgQEANCj4gc3RhdGljDQo+ID4gdm9pZCBhc3BlZWRfc29jX2FzdDI3
MDBfY2xhc3NfaW5pdChPYmplY3RDbGFzcyAqb2MsIHZvaWQgKmRhdGEpDQo+ID4gICAgICAgc2Mt
PnVhcnRzX251bSAgICA9IDEzOw0KPiA+ICAgICAgIHNjLT5udW1fY3B1cyAgICAgPSA0Ow0KPiA+
ICAgICAgIHNjLT51YXJ0c19iYXNlICAgPSBBU1BFRURfREVWX1VBUlQwOw0KPiA+IC0gICAgc2Mt
PmlycW1hcCAgICAgICA9IGFzcGVlZF9zb2NfYXN0MjcwMF9pcnFtYXA7DQo+ID4gKyAgICBzYy0+
aXJxbWFwICAgICAgID0gYXNwZWVkX3NvY19hc3QyNzAwYTBfaXJxbWFwOw0KPiA+ICAgICAgIHNj
LT5tZW1tYXAgICAgICAgPSBhc3BlZWRfc29jX2FzdDI3MDBfbWVtbWFwOw0KPiA+ICAgICAgIHNj
LT5nZXRfaXJxICAgICAgPSBhc3BlZWRfc29jX2FzdDI3MDBfZ2V0X2lycTsNCj4gPiAgIH0NCj4g
PiBAQCAtNzc4LDcgKzc3OCw3IEBAIHN0YXRpYyBjb25zdCBUeXBlSW5mbyBhc3BlZWRfc29jX2Fz
dDI3eDBfdHlwZXNbXSA9IHsNCj4gPiAgICAgICAgICAgLm5hbWUgICAgICAgICAgID0gImFzdDI3
MDAtYTAiLA0KPiA+ICAgICAgICAgICAucGFyZW50ICAgICAgICAgPSBUWVBFX0FTUEVFRDI3WDBf
U09DLA0KPiA+ICAgICAgICAgICAuaW5zdGFuY2VfaW5pdCAgPSBhc3BlZWRfc29jX2FzdDI3MDBf
aW5pdCwNCj4gPiAtICAgICAgICAuY2xhc3NfaW5pdCAgICAgPSBhc3BlZWRfc29jX2FzdDI3MDBf
Y2xhc3NfaW5pdCwNCj4gPiArICAgICAgICAuY2xhc3NfaW5pdCAgICAgPSBhc3BlZWRfc29jX2Fz
dDI3MDBhMF9jbGFzc19pbml0LA0KPiA+ICAgICAgIH0sDQo+ID4gICB9Ow0KPiA+DQoNCg==

