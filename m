Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1E95C3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 01:35:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEI4B-0002om-DQ; Sun, 11 May 2025 21:34:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uEI47-0002nm-PR; Sun, 11 May 2025 21:34:48 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uEI43-0006nq-ES; Sun, 11 May 2025 21:34:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jLwYah1qx3CjG/dqLv7AdUdgJro17F4IWLT6EsWElisH758GMulYggEeg42rTHYkwpyxUQRO3qYsCAzgA7o3MpK7KakA3C0OS6qt3gXKhcwKoWAgRWaSy5s+XI6pgyNIl77xSSk0Z9+7nn0mog3P3kciYwyzCy8j+aeHcVGborGnM4h9NK1CcXsSOHRLiu/fqT4Z2SLs3KVS0G0dPYf1zneusVgsCLjn9yjoAi1mtyfYTGOqM0mVgmvcu7Y4HimVrSGPVD38RRSasXV+G+arFWaTXm/pmQGKRXapPHYdbmukfam0/t+KI30rd4CJW7ry7sRMWTWU7AOeN0CvobkEbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=San3JnE8w8OQy8fnjahsghbnY7NgnoAleT0d+YkriMg=;
 b=w5HN6lqNeNSDsz0o3InzWVQg/Gtbjijdf30PuyUt3Dm9OLxyKKDjsq1vvH+PYUyKq5NP/7WOa9Yo/J2op829SZ67LBqEn7MnZ/t/Sym/Hb2hWXi5DGTZNHbG51mSe1Cg4iDjEIzMSQkuHF47tjuf+DRZu3XdNEoGyikZkt7IDL9OO+ZjHBAVzIEmxzg12tTP5GnPC4hjmoBinE+2JhUovtAHTd55do7yXbtCh5Zl+CSznOd+NpjoVCip1aBV3PxQ4jygInEMpdJWyPNi0WGru1PO3P/fmUVPuJS+n9rjSZREwSouxtjz5fBp1AszHRXPX8CdE2VWrmZRjD+3ePyShQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=San3JnE8w8OQy8fnjahsghbnY7NgnoAleT0d+YkriMg=;
 b=oDcauyrAjpzueqQ5ufacnOE7ogNTa0xrl80hD2/GUS6aKz0RXVxCZRixjWvRT71TcijHAMnok2rLNDNeMA5rvgmp7EZl3AjS+Gui7+uIuV6fGT+TgsTNihHZiIA9jOdU7Fs8q58wDq9dzjBvBIqnQgYkzPTgGTAOb6LEy4nbEArWmohxgjnmwkf/nTlgBYwZCqvLWF3XVAqedXrTtEV0P1p3BykTOpvyzeCdxYCNaAL28SDCKBA38RGgN6UCDXNRr8Uzd2vyIgnWkLHp87YM93LcM5+0sZzb8QY8EcV5Zyb0XaifUq+OxgBt3F1hE57HlFC4Y/WTm9qQhAhcknvJJQ==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TYUPR06MB6272.apcprd06.prod.outlook.com (2603:1096:400:35c::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.26; Mon, 12 May 2025 01:34:31 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 01:34:30 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1 11/22] hw/misc/aspeed_hace: Add trace-events for better
 debugging
Thread-Topic: [PATCH v1 11/22] hw/misc/aspeed_hace: Add trace-events for
 better debugging
Thread-Index: AQHbmkNYdSUgEHjFjk+X3L4eGeiNhrOQFeeAgD5xKqA=
Date: Mon, 12 May 2025 01:34:30 +0000
Message-ID: <SI2PR06MB50411C07E76F96D54DB993BCFC97A@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250321092623.2097234-1-jamin_lin@aspeedtech.com>
 <20250321092623.2097234-12-jamin_lin@aspeedtech.com>
 <fb147a8a-c072-4404-8adf-a0c1d5e39305@kaod.org>
In-Reply-To: <fb147a8a-c072-4404-8adf-a0c1d5e39305@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TYUPR06MB6272:EE_
x-ms-office365-filtering-correlation-id: a9ee57a9-e45c-4536-4d66-08dd90f52452
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|921020|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?SVdzVnAraWtNQWI5cDJVRVNNZ2RjQmFSazczak83SDI2cnhZWXFJNUs0SU5m?=
 =?utf-8?B?RE5lQkdPQXQraVVtMzJpN2I4ZEhaWGV6alVteFpUVUpxOVA3K1NRcnZnL0Q5?=
 =?utf-8?B?TzRpdUZuRElwNjVwM3lEY3lRNHdnZEdpQ2ZIak9Qc3RpL2YvQXN4VjFvUjVk?=
 =?utf-8?B?M1VHOG85b3ZiOERWdlA3Q29NVDJrcUh4cnpDbnQzUGNRZ2FFZ3NBUVI1Si9Q?=
 =?utf-8?B?VTU2cEFrUlZpWnM0RkhPRkJMb080RlJ5UEl4U3ArakhkZDgzeTJnTE9HK0xj?=
 =?utf-8?B?UzVheUVSSitrV2ZEb1p4UWExYUFFazZTSzJ4S1YvZGNQajBEK0diWjAzVGVF?=
 =?utf-8?B?VHlzKy8wZ20rRUFmeHhQQ3R4dzdPVVplY0NXUzZXcWFPSk5aL0JlSVFXU0Vt?=
 =?utf-8?B?UU1qSmE0b2ZKWksrTUljc0Z3dlFTcmRQOFg2YUQvVUhzUjQ0KzNlYWRjOGxT?=
 =?utf-8?B?WnBGV0dCRWJwbTU5UjlDMGc1ejUzWENobjVZKzAzVzZWUzF2TnhUazlPWnl6?=
 =?utf-8?B?U3Ftdi9zcWRNZzFoWENkY1pIY2ttbDhwYWJhY1NFbmVyZ1QyYWhzeXRFRnNW?=
 =?utf-8?B?SysrWTlSYjZxMi9rVFpoQzkvb0ZDQkZVbERydFJhbjNIaHZTUkxkZHFyWExH?=
 =?utf-8?B?NzlVUWpLSUFyMWlWM2pjZEJqSW5qZzNLVlBjcnpoYzFSV01PVDhiY3F3Zm1y?=
 =?utf-8?B?RTR0Y1EyemFPaVJ1Y1Q3OGp5ZTVkbmpxbEpuTmtLOFhZeWMyaUNpT3gzZ1Er?=
 =?utf-8?B?dDFxY09SNGtaVjNER2pJc3U1ZzJWMTZ6S05YT0I5Q09xY3B3OFpSWHZsTlpy?=
 =?utf-8?B?QU1nNUdlS2lVc0RYR1hQQk9mbVppU2lmVWY2eGkyb1FOMGk2M1dmL1I4WEVW?=
 =?utf-8?B?K3JXRDZnUU1ENkp4cFpxOEhIdUp4Z0J0U2FlRTBJN2l5blFCRHVkUHc0cFU2?=
 =?utf-8?B?eGVtZ0FKU3FjNk5yOThxYkZTUjFVSEVxRGhjU2ozNDRwSnlwZkEyY1hGakJj?=
 =?utf-8?B?U0xJSHhvM25MU0VFSHkwV3NhdjI0SGh2aTVOR2VvK2hVNUpGSEtnNEtXanB3?=
 =?utf-8?B?STFINUVSWThRMVpQOGhUbkw2ZGJRTmhTdWUwRUxDeEE4b2dlYm1PS0NTME1Z?=
 =?utf-8?B?bkxJMXpvRGgreGJMOFhhQVN4Ym5aMjZVVU9tT3NDalhUSmUrVzh1N1BHZmM2?=
 =?utf-8?B?aWhiWkhyWWo4NUJJVzNXRjRGNld1MzFVRFUzK0xFa09OaDcwdUxjVUp5R0xP?=
 =?utf-8?B?cWE5b2NTYnV2Tm5KY25PUVFPcC9wRG15UUJnOGw4emhZK1ArV20vRDUvMTZz?=
 =?utf-8?B?R0pzclN5dHZVS1RVaGdRVEU3TlQzN09KU2lxbml6MlVuc1lQMThwWVhPbUM3?=
 =?utf-8?B?Y1RpYzQxUGlxVTRZSzg3VlhGRTFXdUJCdU9hNXJxcU5JYm4vM3AzeEFSTGk4?=
 =?utf-8?B?Z1M0dlMzNmYyckZNSjV5SHhHRk94UDhhakk5QStVRzJjcUM2OTZ1STBFTHNJ?=
 =?utf-8?B?dEZVZ1pLSm5vVUxab201UHcrSnJVVGlkMFpldkwzNjJxRmE4ZHd3bGZqdTlG?=
 =?utf-8?B?TzIwUUoreWFXQ1l3czVIdGE5ckVJUnpnNWJWMHNLWVhzdGVoV0lyRS9HazVN?=
 =?utf-8?B?cS9RVDlDanoxQWhGai9iUldkTmZTa2drUzVlT1N1VEdHZzVDcmhEQ05ncEdv?=
 =?utf-8?B?QWRkclVXV1hQcGp2dGlrNmQ1Um1KVjhjQng2RlBqQ2Z4emRyd1YrNXJ5ODdp?=
 =?utf-8?B?RmI4Mkd6dFlLQ2svWmJMRW5aOWdYdkJMWDUyV0F5OFhldkhab2szMytTd0pp?=
 =?utf-8?B?ZkRjNklVZEdXSEhaSURqcG9ZMHg3NTFIRVFlYkVxWW41T01XSFdjcTZPQ0xF?=
 =?utf-8?B?REt2WHdHVml5Zm5vZUhUWnpIaDUyaEdaeHYxeFhFbGlXcTIwL2Z1Rm5GWEpX?=
 =?utf-8?B?RDE2N0tGaWdYblNJVEt1WnZzZWlqdHo4VndaTHFOcTFmbUtrRXBUZWZSMk5Q?=
 =?utf-8?Q?f12gD1p9S868GLSEH0aRL5lnKPkLPM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a1J6SFNCczNsdlFUNUZkcGEwWDkvZnR4SEpGYmJuMUpiV2QxVEFzNlVxUGdk?=
 =?utf-8?B?cS9BTFRUQ080K3BoMWJtQUh6bzIwMEpHOHpqRUpaZS9oQklCemdsNXFqYVNo?=
 =?utf-8?B?cVRQTEpNQlpUWkZmV1RsZ2lZR0dDR2dDRzNPMDdnNEJyZ3Jwc3FvT2o1aWlK?=
 =?utf-8?B?SXg0eXpjS0RvZXFhaE9VR1ZldDNxZnBzYlNYTHNKd1lmZlVucHNhVmZ2bXRP?=
 =?utf-8?B?eElIZ0dla2tSTlJtVXpjUWdISnM4YjdJNWNRZTdtaWNZL3pyTEZPOEIyT3dO?=
 =?utf-8?B?VldiM3IwWmRvOGxvcmRmaUkxaHNrQVYva0l2TjJra2c4bWxUQmpnUWh2U3BI?=
 =?utf-8?B?Nm5LYTdMWnVncXJpbHV2OFNQQ0tFKzBVSmlRT3JFVGJxNGx3NHNUV09iUzNC?=
 =?utf-8?B?SVFJaWtxYnk3aFE2Qy9UTWNob0MxeGRGUDdQNEJxT3ZsaUJWU3F4S2FnaDVM?=
 =?utf-8?B?Yk1HRXhicW1xak83c3BSbXJ6cXE2WlFrRVFhOFIreC8yYU95akdseWpzdkhz?=
 =?utf-8?B?bzdCTFhVajk4ei94c3VrUE5XUTk4R1Zudm9qd1V1VWcwdE5tUkZtcWpNZklt?=
 =?utf-8?B?THhNeU10Tnl2WjlnejJLRUttb3UyZ0dXTTdHNnhyOHp3dDY0UzFDeG9BT3NO?=
 =?utf-8?B?b3hXS2YrK1h1SDU1OVNlMzgwZXp3VmszYjVDdUdPaVdUZk1KMk9rd29NQWIv?=
 =?utf-8?B?akNnd2h2TXFPczlwSlQzck9zZG5USFBxOWJUWXptRzdMaW84K1RkN1BhS2FX?=
 =?utf-8?B?NEs2NGorbFllSVRNeW9tbFBlRUpnc2x1N29mQ3l2cUJYT2lkQjVtZ3RMZ0Ro?=
 =?utf-8?B?Q1d2Q2k5clpSU09lRE5zUzBOdDBhN1BicXRGUC9JRzlua24wVHN2V0FodytX?=
 =?utf-8?B?S3VsVVkwK0xRejNnUi9aOUw3REM4ekY4WXpFSTZFaU9GM2N1cUJsOU1wQ3ZP?=
 =?utf-8?B?NnBlemFlNXVGNHNIUHR3bEZUWGFMOVZyaTZqeVhMakNoRitQWEMyaUsrc2NG?=
 =?utf-8?B?QTMxTEM1SWF5RDMvL3J1UkFSQkJoclVpeS9wZytJT2xmOVF3TGcvZlZjaHVi?=
 =?utf-8?B?d3ZxNkVQWTl5dG54M0FVRDZORGg3aEdWYmptU0NnK1NJYXJmLzBTR25FWXdh?=
 =?utf-8?B?VHBSN3JDZkJFM1ArMzJmK1prcmgwR203ZDNpSXBSUEtQTy9Gb25rRUpWcUQz?=
 =?utf-8?B?WjJYTVREQU5PeGI0d1kxdXpLeFg2ZVdqVnIrYTVtdE54RWZCVW5aaG1WN2dz?=
 =?utf-8?B?TTBBNzFwbTRCM1J2eFpxNm5ZUXNXNXhJV2lwZG54bFovZENsRk1zQlBRZkM0?=
 =?utf-8?B?UmNiYW9Qa1hIUEJyamEzM29KSTViT3Qrd01XU1NoM05HcThNWThRbHlnR0lI?=
 =?utf-8?B?NElFRUJWcDcybzk0aTJ0OCtjdFhCUlBLUmdkVFk5eDFzbnYzU0NLUUx5c21n?=
 =?utf-8?B?YW4vSVA3b3lxQ3I2S2pIUDBNeEgyeTNIcXkzbXB4OVBCT1RMZUg4QVYyU1kx?=
 =?utf-8?B?RlEwU3ozY1loSXdJY2VQa1MrbG5ZUFVTMm9vTXhtMGRUdVUyMzdjdUdmcDJR?=
 =?utf-8?B?Unl1QnRIZTVxeUhBZW5kQlZHQlJrU0JLY01CN0RtR0JuMTBkWnd5R3VFOWpY?=
 =?utf-8?B?UXY3V1RJelpuWnBYdDZzUjV1MkNFNWtUTDNySldxYUxzeklmZU8xdFZqaCtR?=
 =?utf-8?B?aFV3U1VLdlBxYVYyeFJ2ZjFNTkJzSSswN2piaDNmeEhTWlRnN29FRENBLyty?=
 =?utf-8?B?Wk94bVB3eGtBbnZxWmlZTzFEWnJSTU0xWnQzNDVHMlQ2Z0s1S1FLMUR4ZmJs?=
 =?utf-8?B?WWYvbkw3c2JPZXY0YytpMXV0dEQ1Nk1rTDRLTzY5K1U1dHl1RHE3clRqNkpT?=
 =?utf-8?B?a0VGNU42bWxBaFNSVWJQcTBGZmNBQUkvbmNxWk5kTWdqek5mM2xZVVNUQzRi?=
 =?utf-8?B?eWRhb2VYamRFdXVZQjJUSXo4QnJaNW14dEloaXM3ZW5SekcvYnJSUkx1ODRS?=
 =?utf-8?B?eW43Sjc1Q0hLVHRldFJqTm02MHQ5UTROV0M5ZFJPV3h1MU92cUlQajFhdGF3?=
 =?utf-8?B?RGlZMU1wNGF5cy9PanJ3WFBDRUJIcVk2a21pQkpTNU1LMVF3QzAyZ0dCOVBl?=
 =?utf-8?Q?cv7ahXuUU1vpopWNsbhvOvUbC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9ee57a9-e45c-4536-4d66-08dd90f52452
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2025 01:34:30.6606 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bzPfSem23HluxQc0J9QOtgTXPzqhgFyzGjXWiqvHYmqrf/I4uaU0PEtvGpaOFGJwOsk8klcdQEIuUG0bKZkYn+O7PfA3k9IRbuoa9Puxb08=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6272
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

SGkgQ8OpZHJpYw0KDQo+IEZyb206IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAa2FvZC5vcmc+DQo+
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMTEvMjJdIGh3L21pc2MvYXNwZWVkX2hhY2U6IEFk
ZCB0cmFjZS1ldmVudHMgZm9yDQo+IGJldHRlciBkZWJ1Z2dpbmcNCj4gDQo+IE9uIDMvMjEvMjUg
MTA6MjYsIEphbWluIExpbiB3cm90ZToNCj4gPiBJbnRyb2R1Y2VkICJ0cmFjZV9hc3BlZWRfaGFj
ZV9hZGRyIiwgInRyYWNlX2FzcGVlZF9oYWNlX3NnIiwNCj4gPiAidHJhY2VfYXNwZWVkX2hhY2Vf
cmVhZCIsIGFuZCAidHJhY2VfYXNwZWVkX2hhY2Vfd3JpdGUiIHRyYWNlIGV2ZW50cy4NCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPg0K
PiA+IC0tLQ0KPiA+ICAgaHcvbWlzYy9hc3BlZWRfaGFjZS5jIHwgOCArKysrKysrKw0KPiA+ICAg
aHcvbWlzYy90cmFjZS1ldmVudHMgIHwgNiArKysrKysNCj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwg
MTQgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2h3L21pc2MvYXNwZWVkX2hh
Y2UuYyBiL2h3L21pc2MvYXNwZWVkX2hhY2UuYyBpbmRleA0KPiA+IDUzYjNiMzkwZTMuLmI4ZTQ3
M2VlM2YgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvbWlzYy9hc3BlZWRfaGFjZS5jDQo+ID4gKysrIGIv
aHcvbWlzYy9hc3BlZWRfaGFjZS5jDQo+ID4gQEAgLTE4LDYgKzE4LDcgQEANCj4gPiAgICNpbmNs
dWRlICJjcnlwdG8vaGFzaC5oIg0KPiA+ICAgI2luY2x1ZGUgImh3L3FkZXYtcHJvcGVydGllcy5o
Ig0KPiA+ICAgI2luY2x1ZGUgImh3L2lycS5oIg0KPiA+ICsjaW5jbHVkZSAidHJhY2UuaCINCj4g
Pg0KPiA+ICAgI2RlZmluZSBSX0NSWVBUX0NNRCAgICAgKDB4MTAgLyA0KQ0KPiA+DQo+ID4gQEAg
LTE4Niw2ICsxODcsNyBAQCBzdGF0aWMgdm9pZCBkb19oYXNoX29wZXJhdGlvbihBc3BlZWRIQUNF
U3RhdGUgKnMsDQo+IGludCBhbGdvLCBib29sIHNnX21vZGUsDQo+ID4gICAgICAgICAgICAgICBp
ZiAoYWhjLT5oYXNfZG1hNjQpIHsNCj4gPiAgICAgICAgICAgICAgICAgICBzcmMgPSBkZXBvc2l0
NjQoc3JjLCAzMiwgMzIsIHMtPnJlZ3NbUl9IQVNIX1NSQ19ISV0pOw0KPiA+ICAgICAgICAgICAg
ICAgfQ0KPiA+ICsgICAgICAgICAgICB0cmFjZV9hc3BlZWRfaGFjZV9hZGRyKCJzcmMiLCBzcmMp
Ow0KPiA+ICAgICAgICAgICAgICAgc3JjICs9IGkgKiBTR19MSVNUX0VOVFJZX1NJWkU7DQo+ID4N
Cj4gPiAgICAgICAgICAgICAgIGxlbiA9IGFkZHJlc3Nfc3BhY2VfbGRsX2xlKCZzLT5kcmFtX2Fz
LCBzcmMsIEBAIC0xOTQsNg0KPiA+ICsxOTYsNyBAQCBzdGF0aWMgdm9pZCBkb19oYXNoX29wZXJh
dGlvbihBc3BlZWRIQUNFU3RhdGUgKnMsIGludCBhbGdvLA0KPiBib29sIHNnX21vZGUsDQo+ID4g
ICAgICAgICAgICAgICBzZ19hZGRyID0gYWRkcmVzc19zcGFjZV9sZGxfbGUoJnMtPmRyYW1fYXMs
IHNyYyArDQo+IFNHX0xJU1RfTEVOX1NJWkUsDQo+ID4NCj4gTUVNVFhBVFRSU19VTlNQRUNJRklF
RCwgTlVMTCk7DQo+ID4gICAgICAgICAgICAgICBzZ19hZGRyICY9IFNHX0xJU1RfQUREUl9NQVNL
Ow0KPiA+ICsgICAgICAgICAgICB0cmFjZV9hc3BlZWRfaGFjZV9zZyhpLCBzZ19hZGRyLCBsZW4p
Ow0KPiA+ICAgICAgICAgICAgICAgLyoNCj4gPiAgICAgICAgICAgICAgICAqIElkZWFsbHksIHNn
X2FkZHIgc2hvdWxkIGJlIDY0LWJpdCBmb3IgdGhlIEFTVDI3MDAsIHVzaW5nDQo+IHRoZQ0KPiA+
ICAgICAgICAgICAgICAgICogZm9sbG93aW5nIHByb2dyYW0gdG8gb2J0YWluIHRoZSA2NC1iaXQg
c2dfYWRkciBhbmQNCj4gPiBjb252ZXJ0IGl0IEBAIC0yMzcsNiArMjQwLDcgQEAgc3RhdGljIHZv
aWQNCj4gZG9faGFzaF9vcGVyYXRpb24oQXNwZWVkSEFDRVN0YXRlICpzLCBpbnQgYWxnbywgYm9v
bCBzZ19tb2RlLA0KPiA+ICAgICAgIH0gZWxzZSB7DQo+ID4gICAgICAgICAgIHBsZW4gPSBzLT5y
ZWdzW1JfSEFTSF9TUkNfTEVOXTsNCj4gPiAgICAgICAgICAgc3JjID0gZGVwb3NpdDY0KHNyYywg
MCwgMzIsIHMtPnJlZ3NbUl9IQVNIX1NSQ10pOw0KPiA+ICsgICAgICAgIHRyYWNlX2FzcGVlZF9o
YWNlX2FkZHIoInNyYyIsIHNyYyk7DQo+ID4gICAgICAgICAgIGlmIChhaGMtPmhhc19kbWE2NCkg
ew0KPiA+ICAgICAgICAgICAgICAgc3JjID0gZGVwb3NpdDY0KHNyYywgMzIsIDMyLCBzLT5yZWdz
W1JfSEFTSF9TUkNfSEldKTsNCj4gPiAgICAgICAgICAgfQ0KPiA+IEBAIC0yOTksNiArMzAzLDcg
QEAgc3RhdGljIHZvaWQgZG9faGFzaF9vcGVyYXRpb24oQXNwZWVkSEFDRVN0YXRlICpzLA0KPiBp
bnQgYWxnbywgYm9vbCBzZ19tb2RlLA0KPiA+ICAgICAgIGlmIChhaGMtPmhhc19kbWE2NCkgew0K
PiA+ICAgICAgICAgICBkaWdlc3RfYWRkciA9IGRlcG9zaXQ2NChkaWdlc3RfYWRkciwgMzIsIDMy
LA0KPiBzLT5yZWdzW1JfSEFTSF9ERVNUX0hJXSk7DQo+ID4gICAgICAgfQ0KPiA+ICsgICAgdHJh
Y2VfYXNwZWVkX2hhY2VfYWRkcigiZGlnZXN0IiwgZGlnZXN0X2FkZHIpOw0KPiA+ICAgICAgIGlm
IChhZGRyZXNzX3NwYWNlX3dyaXRlKCZzLT5kcmFtX2FzLCBkaWdlc3RfYWRkciwNCj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBNRU1UWEFUVFJTX1VOU1BFQ0lGSUVELA0KPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRpZ2VzdF9idWYsIGRpZ2VzdF9sZW4pKSB7DQo+
IA0KPiBJIHdvdWxkIHVzZSB0aGUgcHJlZml4ICd0cmFjZV9hc3BlZWRfaGFjZV9oYXNoX2FkZHIn
IHNpbmNlIHRoZSB0cmFjZSBldmVudHMNCj4gYXJlIGNhbGxlZCBmcm9tIGRvX2hhc2hfb3BlcmF0
aW9uKCkNCj4gDQo+IA0KV2lsbCBhZGQgImFzcGVlZF9oYWNlX2hhc2giIHByZWZpeCB0byBtYWtl
IHVzZXIga25vdyB0cmFjZSBldmVudCBmb3IgaGFzaCBjb21tYW5kLg0KVGhhbmtzLUphbWluDQo+
IFRoYW5rcywNCj4gDQo+IEMuDQo+IA0KPiANCj4gDQo+ID4gQEAgLTMyNiw2ICszMzEsNyBAQCBz
dGF0aWMgdWludDY0X3QgYXNwZWVkX2hhY2VfcmVhZCh2b2lkICpvcGFxdWUsDQo+IGh3YWRkciBh
ZGRyLCB1bnNpZ25lZCBpbnQgc2l6ZSkNCj4gPiAgICAgICAgICAgcmV0dXJuIDA7DQo+ID4gICAg
ICAgfQ0KPiA+DQo+ID4gKyAgICB0cmFjZV9hc3BlZWRfaGFjZV9yZWFkKGFkZHIgPDwgMiwgcy0+
cmVnc1thZGRyXSk7DQo+ID4gICAgICAgcmV0dXJuIHMtPnJlZ3NbYWRkcl07DQo+ID4gICB9DQo+
ID4NCj4gPiBAQCAtMzQ0LDYgKzM1MCw4IEBAIHN0YXRpYyB2b2lkIGFzcGVlZF9oYWNlX3dyaXRl
KHZvaWQgKm9wYXF1ZSwNCj4gaHdhZGRyIGFkZHIsIHVpbnQ2NF90IGRhdGEsDQo+ID4gICAgICAg
ICAgIHJldHVybjsNCj4gPiAgICAgICB9DQo+ID4NCj4gPiArICAgIHRyYWNlX2FzcGVlZF9oYWNl
X3dyaXRlKGFkZHIgPDwgMiwgZGF0YSk7DQo+ID4gKw0KPiA+ICAgICAgIHN3aXRjaCAoYWRkcikg
ew0KPiA+ICAgICAgIGNhc2UgUl9TVEFUVVM6DQo+ID4gICAgICAgICAgIGlmIChkYXRhICYgSEFT
SF9JUlEpIHsNCj4gPiBkaWZmIC0tZ2l0IGEvaHcvbWlzYy90cmFjZS1ldmVudHMgYi9ody9taXNj
L3RyYWNlLWV2ZW50cyBpbmRleA0KPiA+IDQzODM4MDhkN2EuLmNmOTZlNjhjZmEgMTAwNjQ0DQo+
ID4gLS0tIGEvaHcvbWlzYy90cmFjZS1ldmVudHMNCj4gPiArKysgYi9ody9taXNjL3RyYWNlLWV2
ZW50cw0KPiA+IEBAIC0zMDIsNiArMzAyLDEyIEBAIGFzcGVlZF9wZWNpX3JlYWQodWludDY0X3Qg
b2Zmc2V0LCB1aW50NjRfdCBkYXRhKQ0KPiAib2Zmc2V0IDB4JSIgUFJJeDY0ICIgZGF0YSAweCUi
DQo+ID4gICBhc3BlZWRfcGVjaV93cml0ZSh1aW50NjRfdCBvZmZzZXQsIHVpbnQ2NF90IGRhdGEp
ICJvZmZzZXQgMHglIiBQUkl4NjQgIg0KPiBkYXRhIDB4JSIgUFJJeDY0DQo+ID4gICBhc3BlZWRf
cGVjaV9yYWlzZV9pbnRlcnJ1cHQodWludDMyX3QgY3RybCwgdWludDMyX3Qgc3RhdHVzKSAiY3Ry
bA0KPiA+IDB4JSIgUFJJeDMyICIgc3RhdHVzIDB4JSIgUFJJeDMyDQo+ID4NCj4gPiArIyBhc3Bl
ZWRfaGFjZS5jDQo+ID4gK2FzcGVlZF9oYWNlX3JlYWQodWludDY0X3Qgb2Zmc2V0LCB1aW50NjRf
dCBkYXRhKSAib2Zmc2V0IDB4JSIgUFJJeDY0DQo+ID4gKyIgZGF0YSAweCUiIFBSSXg2NCBhc3Bl
ZWRfaGFjZV93cml0ZSh1aW50NjRfdCBvZmZzZXQsIHVpbnQ2NF90IGRhdGEpDQo+ID4gKyJvZmZz
ZXQgMHglIiBQUkl4NjQgIiBkYXRhIDB4JSIgUFJJeDY0IGFzcGVlZF9oYWNlX3NnKGludCBpbmRl
eCwNCj4gPiArdWludDY0X3QgYWRkciwgdWludDMyX3QgbGVuKSAiJWQ6IGFkZHIgMHglIiBQUkl4
NjQgIiBsZW4gMHglIiBQUkl4MzINCj4gPiArYXNwZWVkX2hhY2VfYWRkcihjb25zdCBjaGFyICpz
LCB1aW50NjRfdCBhZGRyKSAiJXM6IDB4JSIgUFJJeDY0DQo+ID4gKw0KPiA+ICAgIyBiY20yODM1
X3Byb3BlcnR5LmMNCj4gPiAgIGJjbTI4MzVfbWJveF9wcm9wZXJ0eSh1aW50MzJfdCB0YWcsIHVp
bnQzMl90IGJ1ZnNpemUsIHNpemVfdCByZXNwbGVuKQ0KPiAibWJveCBwcm9wZXJ0eSB0YWc6MHgl
MDh4IGluX3N6OiV1IG91dF9zejolenUiDQo+ID4NCg0K

