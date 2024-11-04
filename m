Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A5A1D11199
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 01:18:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7liQ-0005q8-Ll; Sun, 03 Nov 2024 20:17:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1t7liO-0005pi-L7; Sun, 03 Nov 2024 20:17:08 -0500
Received: from mail-psaapc01on20706.outbound.protection.outlook.com
 ([2a01:111:f403:200e::706]
 helo=APC01-PSA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1t7liM-0000FI-T9; Sun, 03 Nov 2024 20:17:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fMg9neJI58G8bcG+llGeCjMIcdXHLKkwSN//OJNxEXYBNZu7GUORBu/U2AWAj1JjB253mR0G/arrymWvZRDOA9v1jrjsiW1TUjWhztK/q/xMI+w+ci4p62Rq/ashJwL9tOZPfKoF57OpwZMXQSKoXgQuprqHSxpERwNAw+sna1icCpBqDC6DWHhbFFRT+zgWR4Nq6VRDA4s5AgfXdJn9UBpE6zfpmOSO1fPx6YEV2KVE3WBbrxMIeoTh88rlKGNutocL8bCD4+JnrRiMjGeazaviR8rBYPd+py3yrdn9ZWsLqqrlwxAyJCEK0hvFJENgI84qzbr1tDcqRLTxhMLsPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5QKiRLKTT/hpSqINKZl+8TrlLejobwNeHHYz5nHPQU=;
 b=T7MG9Jnqh7fWfUC4Gi08HwUCMdbB6QhFDTjZ25WZ86L/Zsf7ztnVyrZrs3rIGcR12HTR4rLG/BAximN6lHJcEElXoXwi9/IHgvAYrshTAx7/qU5LZjKlaYEAMM6Kjv4d8KQC/TmTvJYB9wjmmA5Y75QXDU16Zjh97y05J/z2Cmgyha7SwRU5bMuq1Eg/jP9evDjsBWUa2cjNm1iNsOe4YxW3+CDTydwBCV9FdG4Beqe6WIR40kROG0lEkWqQBwLlXFpIh598NnhIVSfkMuZFhTwFvNBeDyV+3EgjvM4pL6dno91ILz9xPAATZQAiUtn6YJVQudqZZxTfSBbIIrqQ2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g5QKiRLKTT/hpSqINKZl+8TrlLejobwNeHHYz5nHPQU=;
 b=bZ73oBGJdxvkIndqevRVZlTx7UPaeEL31l12AYaD3toF6uoVSgUmFrnMUYGDzwvEjZVsu+2wxCaDwBr6ST4TG+P2rhgBiDGne8MKxQKss/neF2R1G9GoTXEW0FvcTgYwAYn0IRYgUgFqWWNWIneq18Gg/APddlG12teD1WYmjAut6hm6xPrA23oRV8XcbfwPvqqR3tBdFas+J52t2OXKGaY3lfdqg1vFhIQD7SiNhGkXvbUDktlNGK5Hz/sS0sNSDhOgaDNI6wHSy0GWJDOOq2UfUTjfq/A4NOirWBw7NYzb+nUBWXzEknfgfighwI76Gq5lEjKhI9osVLd2Nm/50A==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 PUZPR06MB6267.apcprd06.prod.outlook.com (2603:1096:301:115::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.17; Mon, 4 Nov
 2024 01:16:53 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.8137.011; Mon, 4 Nov 2024
 01:16:53 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, Bin Meng <bmeng.cn@gmail.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:SD (Secure Card)" <qemu-block@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [SPAM] [PATCH v1 0/8] Support RTC for AST2700
Thread-Topic: [SPAM] [PATCH v1 0/8] Support RTC for AST2700
Thread-Index: AQHbKeNklA36gRpU7kmIXYVXJiMgQ7KkHO4AgAI9ajA=
Date: Mon, 4 Nov 2024 01:16:53 +0000
Message-ID: <SI2PR06MB50412B856A25FAEB19FD10ABFC512@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20241029091729.3317512-1-jamin_lin@aspeedtech.com>
 <9cf62dd0-2e88-4692-8a16-544b75665b6c@kaod.org>
In-Reply-To: <9cf62dd0-2e88-4692-8a16-544b75665b6c@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|PUZPR06MB6267:EE_
x-ms-office365-filtering-correlation-id: fb069bbe-562c-4a8c-8452-08dcfc6e5e32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700018|921020|217643003; 
x-microsoft-antispam-message-info: =?utf-8?B?OW1QdzYxRmFESzFSbjN5amZNMDhKOTBOcnVUYjVqSEkxQzN3bzZrcGowSDhL?=
 =?utf-8?B?Qm9mVE9SM096a0VpZ2RqdnFvMXlNT3I3Z2hmRSt5QXg3RFBEZGdBczlQbzZR?=
 =?utf-8?B?NGovOFpkdVFMRFZ5S3duUGhxUkNhSXRJNTVSKzBOTGI2VkxNbllPY1JwUUZO?=
 =?utf-8?B?V0FtM21JbENmMTM5Y2czelVHU1VuN3FCWkZ2LzFGcTh1M0hVdWV6Unc0anEz?=
 =?utf-8?B?ZXNLVHRUVk9kWE01MjFCK2pzNWFqNDFQYmVVOFFBT0V4UDdVTzIxT3EyakMz?=
 =?utf-8?B?d2lucXI5RDZBRTRKMDlJZkFvRnBnVW5BV3MrWUZna1QwYnZra3NRYWxPUm9m?=
 =?utf-8?B?ZWQ3d0lvZjNpRTBZTkJJL1hzbGhueWFDcWxudy9FM3djKzZxY1RCMnZ0dWNL?=
 =?utf-8?B?NDgxOTNRMVppeHVFb0hEdkFiZ3ZrZDRsY092RlhZeUVWNFA3dW1JdExLdHVz?=
 =?utf-8?B?WktteUVZSDM4SThNcmdTRVNkeDVVdExueDh6ZXNpU0RjMFNmVWdrSE0wR25H?=
 =?utf-8?B?Zng0WHh3Tk1QOEMvNmdwcURid1VZd0ZJVzhkVE5TWThNSENDVzlnM25aRURZ?=
 =?utf-8?B?YXh0czJydjRnOGdxell3MzFSY3IyMWpPamhpb0cvRXlYd1JUYUxmZFhySGN3?=
 =?utf-8?B?L2ZnWW5TdEYvQVNLeHRSTlF2NE5tTzRodFl5RHRncHFUZU5lWUVYdjQ2bVo3?=
 =?utf-8?B?TXp0NU15NEYvSE1DWTFONndHNE10b2dVZ1V2OElVd3FHTEF1MmYzaGg0VkJL?=
 =?utf-8?B?bUlxcWY0bzBieXRLRTlmRGpLVWhVZ3R0V1RkQjZza2VZOGxSTElRblc1TEpN?=
 =?utf-8?B?N0d3V0QweVl1c2oxQjl1WlQra2ZpMDd3dHoxYk05YXJhRGROYnhWVnBVTE9S?=
 =?utf-8?B?OGg3eFluYmtJU1ZveVAwM1EyT3dxbHp1a2xvdmRkY2RuQitZUjhOUjR2ZDFo?=
 =?utf-8?B?SVA0ekI0NVRncUQ5NGdVejdXSVVPWkp3U3JDUGVZRzQ3L2ZOUEY3UFI3ejJV?=
 =?utf-8?B?ZkY3RWJDVkJYSVJwTHFLVGFpT090bzdxT25QUVZGNnNJRXJkckhiUWNLTFF3?=
 =?utf-8?B?WUdBQ0Zvdm1IS3lKKzFTc1hDajBiWFF5QVVUUi9NOHN3WVlVRmIrL0VjYWc3?=
 =?utf-8?B?UFhTaXl2dUVML2YycVBNQ0FVNTl4a3M3TG1WSnlETThJdDU0TXVqbUlsY2Jq?=
 =?utf-8?B?UUdVS3JuOGdrL2cxemU5c2pnRHp2Wk9aNExmV2N1aXFCZE1aTjJBOVlIVjcv?=
 =?utf-8?B?eGpEQUFabWxrL2wva0l0YWVucm54SWoyL201ZjZkaitPN3UrWFdhbXF0N2N3?=
 =?utf-8?B?dkpTTkdIUmFQNmRsNEZ4cFdBQmx1bElZdW5ZMDdLQVMrSVlBbWxZQnM1blJ5?=
 =?utf-8?B?UUcyUEVQU1lhYmRBZS9xNzUzODlWaHV1aFZQRkFWREZKazM3ZUFIcjFCUTEw?=
 =?utf-8?B?R3Q0U3dTZDM0WFM2RGRJRWI2M0pQV3hkbHZsdUZnRFVtc05XZEtjaHdKcnIz?=
 =?utf-8?B?ZUtpQUdVazRtVzZPK2RQQTl4aUFuMVRqTmdPQm9Nb0d1ZDJXdWFvRHErNHVB?=
 =?utf-8?B?QUgxTi8zaWFkN3l1cnZqMWtMeUxMWTdDQlNob0dDY3gxUDRqTThoakxJcjdX?=
 =?utf-8?B?Vyt4WDJQWTQyVVhjSVpjaklCTWRsOVNYM1lEUUdydXJZalJaeXYrT3BFNnNL?=
 =?utf-8?B?RTVESjdlck1xZ1JFSG5BbkhRVTJQRGhHbWNhZHdkYk5TV0lVTHk2aFdwMDVE?=
 =?utf-8?B?MEw2Nk5jN0RXa3FCa0wzc0Noa2Y2d2Z5Q1FXVlVJN1EzdXRPTGJQUDdFeU9J?=
 =?utf-8?B?VytyVEg3MWt0WFFlOFdrS0VsQlVvR1JSRlExMmk4SnpHSlFZbmE4RVUyWWtO?=
 =?utf-8?B?WS9mNGF2MkRYbTd5WlhicUQ1N1RmdVl2OC9VMjJMeXVUNXc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018)(921020)(217643003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2s2Nkc1QWRXb3JRbXFvQitBdGlSQjJWbjlhWExkWC9YQWxPcWNHOHZYNnpV?=
 =?utf-8?B?bDZXejhaV0V6VDRyU0VOYlIzUXR0aDlZb0srYzR1bEdkMmFIdEx1anhtUlBZ?=
 =?utf-8?B?NjBqSXV4cmZyVDQrWnBpdFpndGVGSnVoMDlhYUpiSXh1bTBUZ0VSU24zZGdB?=
 =?utf-8?B?ckNXcUxaWFRHVDgyQlZ0SmVuZFgyRUt1VGNIZlA4YzFHUVJzRUhqUlA5b1pF?=
 =?utf-8?B?RUN2WHlrY3V4ZmU5dzZmNExxZk5tbHJvL3c3R3YrM2c2RWgwNGZWSGtpeERx?=
 =?utf-8?B?TkxkMHEyRWtmNGJiQUh4dHFKMytHbHBacWdMTVZvZ0plUDc5dm1tazRoelU3?=
 =?utf-8?B?Nk5KcmZKK3UydHl4cUd1S2MxenhOSDhMalRjTFJmYVRML2oyVzZuZHpjamNa?=
 =?utf-8?B?WFFQWDhybDk5UytVWWZVbi8zd2tlRkc1V2lERkkxSjNxN0l5MmFtY3VHZExk?=
 =?utf-8?B?QVdhRVIxZ2Q5cTNYVGpSUGtvRXkza0NqNEdUdjlReExObzdWR0IyaVduZ1JP?=
 =?utf-8?B?V3BWR2Z5ajgzamovMFI3T2pwTVY1TEE2NnhReFFDTExBaWZmUGJlUE5UNkVi?=
 =?utf-8?B?d1VpOWlvd3dYRFRpTjBxcnRSUEdTaEVZUFBKZTRucDh0WlluZWUyWkxVY3dU?=
 =?utf-8?B?d2hCc3pkWEppTE9qTGNBd2p1M0NENUZ5T1EvZmoyeTg4dkQvK3h2VHVuYXo1?=
 =?utf-8?B?VjNZcmFQejhiU3F2WlBpK3A3ZTRXc1RHOTRYVkFaYmZuSWI1eWNudXMvV0d6?=
 =?utf-8?B?YXFzUWN6eHcvNFVjRjVCcXhFRDZtSkMzZTlBUXFHcWZwSmVCWlFrcUw3Ymtv?=
 =?utf-8?B?MHlzQXZ3SWJaSmtqOWgvVzdRcWN6UWFndkZJaXdzbDdKU0FpVGF0MFlyaWxl?=
 =?utf-8?B?R1VlY2lpVEJnQ2drOVN1Sm5mRmFkYW1vK2xhcUVGN0JRMEtRZFU4bjlyMnFj?=
 =?utf-8?B?M3NIRlVDSWIycm1XUFFCVy83QVVQYjQzQzArSnN4Q09vRTBoZ0ZGWTN6dGVC?=
 =?utf-8?B?UWM1RjJDTzBvYVFkL081ZnVZQlJONHhBVExqMUgrMWc3RmxQd1VzaDRnY3Nv?=
 =?utf-8?B?b0czdzZhcWhXb3NHWnBjUVFhNElQdCsyQUV1bGp1aHYwVVdKZE1XNXh6dEFP?=
 =?utf-8?B?QkZiNUV4aDZucUYxZGtLRks5eElVNi9EU2VXWnBDUVFQeUNxOWpkRTBYbytI?=
 =?utf-8?B?TjdxaWJPU1k3bUNXd01KWENrbFZNeVNjeFBMdUpaa0xtTUdpdExzdlZ1YmV2?=
 =?utf-8?B?eTEwZmY1MTJyRVlHQU1TcEUxRFQ3aEZIMm80QXFrdDh3SG5nRlBUNFpEZVpB?=
 =?utf-8?B?dWw1dldINXJLMDZ6VFRVWmxJZUN1VVg1aFNhV0JnVG9KLzBGZjdZZkxKaXZp?=
 =?utf-8?B?TVN6L1dIVGcwcXZWQjhZMHZFUzdsRjNVeWFlYVRnWnFoNHFKSjlyb2NDSXJD?=
 =?utf-8?B?MkxIVFQyVDlYZkpIbGQ4WWp4ZVgyQ1czZ25VQ0NIcm83WlV0bFdET1lVOXF5?=
 =?utf-8?B?R21pMTZ1aWdERGZVcGVONGpGL2s3dk0yYnQ1WHhuaFBHU3d3clBwRGgxRWIx?=
 =?utf-8?B?My9sbTlWSVc1ZGNxMXBtMS9RUTVOY2NlSDMwOGQvMDdWUkZ4dGQ5VGlPcVQ4?=
 =?utf-8?B?RWV2RUxXa1JzRzlUb1Z2U2twZDdPY1B1OStiNENzSDJ3Q0NzRFZ6RXNHZ3Rm?=
 =?utf-8?B?dkFqLzJOcFo1V25MMVZmV2dDNjQvOE1UaWs1L3JrZjhjQ0l1YWU4U2xkNlFZ?=
 =?utf-8?B?dGw5ZExLdm53T25vOEZNL1pjVk1CS3VKdFQzRkZHNnpHQUVPVGtzOWhhbnBp?=
 =?utf-8?B?ekVCL05vWW1NenIrbTJoVFd3RVF2RktBaTNZNVJvU1EzcEpjcXpIWkI3d2lx?=
 =?utf-8?B?Wjdrck9aZkdHeEU4amZ6WHlKVnV6SFlBSkM5d3NVd2owSWJOT3lwdjZBRTB1?=
 =?utf-8?B?OTlhSUQ0MkFERVZrcCtROGlTUDFpeXBxTHB4N0dVV1pDWU9Ma3dOQUIyd05t?=
 =?utf-8?B?b3Vra3dhYW9wY2R4ejVmcTdEckhjbEhmTmUzalJCM2EyT2FmdDJnQXBDeXdC?=
 =?utf-8?B?anBKMUVnZ1phUUNSNzdtWTJUVHVWdXJPdFA2dTlkc0dheVZ5dUdYUXljbHMy?=
 =?utf-8?Q?RYL1/Ja63FLa3oDzYrN2DbWdc?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb069bbe-562c-4a8c-8452-08dcfc6e5e32
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2024 01:16:53.6703 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iSxWO9wD5EoiSL9xt86nf60ZoJ0ZCugWz/KqvqksUNhyQuyBP4DO0HPqg9FDTw+FuxhzGSK0FMtwjmeKUJgKh3fe6wVSZAbDOzvFNtmFmJU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6267
Received-SPF: pass client-ip=2a01:111:f403:200e::706;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-PSA-obe.outbound.protection.outlook.com
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

SGkgQ2VkcmljLA0KDQo+IFN1YmplY3Q6IFJlOiBbU1BBTV0gW1BBVENIIHYxIDAvOF0gU3VwcG9y
dCBSVEMgZm9yIEFTVDI3MDANCj4gDQo+IE9uIDEwLzI5LzI0IDEwOjE3LCBKYW1pbiBMaW4gd3Jv
dGU6DQo+ID4gY2hhbmdlIGZyb20gdjE6DQo+ID4gMS4gU3VwcG9ydCBSVEMgZm9yIEFTVDI3MDAu
DQo+ID4gMi4gU3VwcG9ydCBTREhDSSB3cml0ZSBwcm90ZWN0ZWQgcGluIGludmVydGVkIGZvciBB
U1QyNTAwIGFuZCBBU1QyNjAwLg0KPiA+IDMuIEludHJvZHVjZSBDYXBhYmlsaXRpZXMgUmVnaXN0
ZXIgMiBmb3IgU0Qgc2xvdCAwIGFuZCAxLg0KPiA+IDQuIFN1cHBvcnQgY3JlYXRlIGZsYXNoIGRl
dmljZXMgdmlhIGNvbW1hbmQgbGluZSBmb3IgQVNUMTAzMC4NCj4gPg0KPiA+IEphbWluIExpbiAo
OCk6DQo+ID4gICAgYXNwZWVkL3NvYzogU3VwcG9ydCBSVEMgZm9yIEFTVDI3MDANCj4gPiAgICBo
dy90aW1lci9hc3BlZWQ6IEZpeCBjb2Rpbmcgc3R5bGUNCj4gPiAgICBody90aW1lci9hc3BlZWQ6
IEZpeCBpbnRlcnJ1cHQgc3RhdHVzIGRvZXMgbm90IGJlIGNsZWFyZWQgZm9yIEFTVDI2MDANCj4g
PiAgICBody9zZC9zZGhjaTogRml4IGNvZGluZyBzdHlsZQ0KPiA+ICAgIGh3L3NkL3NkaGNpOiBJ
bnRyb2R1Y2UgYSBuZXcgV3JpdGUgUHJvdGVjdGVkIHBpbiBpbnZlcnRlZCBwcm9wZXJ0eQ0KPiA+
ICAgIGh3L3NkL2FzcGVlZF9zZGhjaTogSW50cm9kdWNlIENhcGFiaWxpdGllcyBSZWdpc3RlciAy
IGZvciBTRCBzbG90IDANCj4gPiAgICAgIGFuZCAxDQo+ID4gICAgaHcvYXJtL2FzcGVlZDogSW52
ZXJ0IHNkaGNpIHdyaXRlIHByb3RlY3RlZCBwaW4gZm9yIEFTVDI2MDAgYW5kDQo+ID4gICAgICBB
U1QyNTAwIEVWQnMNCj4gPiAgICBhc3BlZWQ6IFN1cHBvcnQgY3JlYXRlIGZsYXNoIGRldmljZXMg
dmlhIGNvbW1hbmQgbGluZSBmb3IgQVNUMTAzMA0KPiA+DQo+ID4gICBody9hcm0vYXNwZWVkLmMg
ICAgICAgICB8IDMwICsrKysrKysrKysrKy0tLS0tLQ0KPiA+ICAgaHcvYXJtL2FzcGVlZF9hc3Qy
N3gwLmMgfCAxMSArKysrKysrDQo+ID4gICBody9zZC9hc3BlZWRfc2RoY2kuYyAgICB8IDQwICsr
KysrKysrKysrKysrKystLS0tLS0tDQo+ID4gICBody9zZC9zZGhjaS5jICAgICAgICAgICB8IDcw
DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tDQo+ID4gICBody90
aW1lci9hc3BlZWRfdGltZXIuYyB8IDE1ICsrKysrLS0tLQ0KPiA+ICAgaW5jbHVkZS9ody9hcm0v
YXNwZWVkLmggfCAgMSArDQo+ID4gICBpbmNsdWRlL2h3L3NkL3NkaGNpLmggICB8ICA1ICsrKw0K
PiA+ICAgNyBmaWxlcyBjaGFuZ2VkLCAxMjMgaW5zZXJ0aW9ucygrKSwgNDkgZGVsZXRpb25zKC0p
DQo+ID4NCj4gDQo+IEFwcGxpZWQgMSwyLDMsNiw4IHRvIGFzcGVlZC1uZXh0Lg0KPiANCg0KVGhh
bmtzIGZvciB5b3VyIGhlbHAuDQpXaWxsIHJlc2VuZCA0LDUgYW5kIDcgcGF0Y2hlcyBpbiB2Mi4N
ClRoYW5rcy1KYW1pbg0KPiBUaGFua3MsDQo+IA0KPiBDLg0KPiANCg0K

