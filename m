Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0428BD2E008
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 01:42:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3QNo-0005cU-3v; Tue, 22 Oct 2024 21:41:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1t3QNk-0005bX-Fr; Tue, 22 Oct 2024 21:41:52 -0400
Received: from mail-psaapc01on20719.outbound.protection.outlook.com
 ([2a01:111:f403:200e::719]
 helo=APC01-PSA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1t3QNj-00055t-0G; Tue, 22 Oct 2024 21:41:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=byBo3f2hvlJf23CGSwtYpGIMiISnWwGVYK33v1ZVANcQV+vm7dMzQL0fvuYj4/RiahHLTRJ+xZyPYUzi1euZT5SFQM0bjGvKzgm5iGmiz9g/57SPJW+idxzKUeXew6vcl6wFKQ/uXKadEpEXPcqOiW+3iW1MwAmORjemiyki0xMQ3CFf/ADSEGvZvjI50ih8pujTy8U8UqCYIVJfYjZ0ty+zvtPOyQU1eLniA8gEdaFH1tK6Splwb4cxRYfxExu4Hq7hU9NUmsj7eQ7UhUYNQjDDNigvWbJcAg5RoP4+8zCj0akR7S9/t8L6fhtd9cmBF1ZHkT72ASmhv+iBEVeTQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Asq7pykmDJh56+RnkIEzlQQh+aLKYPk2K91ReRCxYX0=;
 b=bv41Ug+M0qnorwufio+jlZkqz9KSsfj9o3sF06LoLIz/9Ew8/5AJu8QUSkelxQ38I6AT3WBMxfF3V3wmO4bb3r2goGf+AZdZ7wB3inxyJHXGCuydJk4lySXaDG1hE9lPPwXKLZ48i6O/GvjMRoNOpAxPKosk/jVs6kY2KWZmBt4iB3FFH+dT9MhvZc/wc8joLfl+RSzOylPZx8iiVmgPBcsigFuNeO21WZ2YjTeI/Ak12W7Y6i1BtzmmGAKul1nrZMQHyJTL8Qpk60f6KSzuhwmarPGOcZTl55XSK2QIlX8O9Ixql90CjBOqccUakCNUbEhX+4ZpEZXBCohEf9XV1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Asq7pykmDJh56+RnkIEzlQQh+aLKYPk2K91ReRCxYX0=;
 b=biQkcipNrNB5udbMefdQnVovxKhMZTdD9F1rX3MOKTLg4a2N4xJmQ2FEr1W9Gs78+DdKA9ReWqXCkXiCvI3dbejPR2Fu+fgWzR5TFEkyhdNA2tY7XzPdRJ7mYiY6eOpPEwqEiS0Ot0H5GnTk+1j+IsHyIukeHgfGqQIi30HPbY194mTyxBdDDCVSF4esMaqJTo2+lhhubkSUpEFasS0cZ/tzv8rwnSz7S98xpCumLEGj+xJthJv2DKk/0WMdW9J9cd9usKbuBFUTdbUHHdd1HnYVTSTfNRB+W3PEDUfmmJy9xa7LNRrdGoex9qS589PyCxi1hvxfSXaM2PRTfFCEQQ==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SEZPR06MB6158.apcprd06.prod.outlook.com (2603:1096:101:ea::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.15; Wed, 23 Oct 2024 01:41:43 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 01:41:43 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Kevin Wolf
 <kwolf@redhat.com>
CC: Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Hanna Reitz <hreitz@redhat.com>, Thomas
 Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>, "open list:Block layer
 core" <qemu-block@nongnu.org>, Troy Lee <troy_lee@aspeedtech.com>, Yunlin
 Tang <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v2 01/18] aspeed/smc: Fix write incorrect data into flash
 in user mode
Thread-Topic: [PATCH v2 01/18] aspeed/smc: Fix write incorrect data into flash
 in user mode
Thread-Index: AQHbJGaQqVeJs78eUE+lO1Zxp6mvM7KSl3eAgAAvqQCAAMlPcA==
Date: Wed, 23 Oct 2024 01:41:43 +0000
Message-ID: <SI2PR06MB50417FE5ACE6C21AFA0E31D8FC4D2@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20241022094110.1574011-1-jamin_lin@aspeedtech.com>
 <20241022094110.1574011-2-jamin_lin@aspeedtech.com>
 <ZxeDVTBwLZsOEDvE@redhat.com> <b682dc55-f5e8-4fec-82f7-333dbaba240e@kaod.org>
In-Reply-To: <b682dc55-f5e8-4fec-82f7-333dbaba240e@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SEZPR06MB6158:EE_
x-ms-office365-filtering-correlation-id: 3d57960c-7ce7-402d-9a81-08dcf303d96f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?RDJFWTQ3ckVkMVJLQmZrTVBGSkZTaXVIVFB0NXlwVVNMQ1psaGpkbU9VbDhP?=
 =?utf-8?B?Q2E4UkFFQytlZWpVUnpvREpmSitUTzlXa1dYRFdxcndBY1NhUVdMODkwcTVh?=
 =?utf-8?B?Qy9rSmZKQW5YUzhubEsxdkFaZkJndGxUaTF3QkJvVVNtSGR6WTNaSnlOKzFN?=
 =?utf-8?B?NEVPUTVZek9wdlBJSi9NbHVJSkg5UTNZNk9ieGpqMEFCVTJQZ3g5dnJEbkw3?=
 =?utf-8?B?TzM2VDh0am5YL0x1bkNwTUdIMDhXaGFLWGp5c2dHMXAzNXBYTmtqWXl6Nlpj?=
 =?utf-8?B?cFJtT1hpdnFZQUxqK3pmcDZFcHhQOFIyMk1iZy9pYzVtTmUwK1NyNS9sWmw1?=
 =?utf-8?B?bGpPTzlyYlJIdUtURXpwcGRkL1I2Uko1dUxrcGZyTmhHUXR6bkZ5VTJadjRP?=
 =?utf-8?B?OFRKK0tVTE8waGpuNkpmOVlXWkFobDBwcFU2bUY1eThwUTM1VGltbUxNcnNK?=
 =?utf-8?B?NTQzWjdVb0c0SjJORitVb1hqZXppYTBOajgyVElLSkpIUDltSGdjTE81Y3RW?=
 =?utf-8?B?TWpiSXpHV0pMcXRDN0F0d2ZsYWxGblZLWTN0MmRqQkdOYjRnbzZVaWpNZ3Jh?=
 =?utf-8?B?L2Yvb3dqOVFJc3lmNm9oNkcxQTEzbVNkdHRobm1ldUx4Y3FzbzYxL2JxRlA1?=
 =?utf-8?B?bTM2NVRWNU5DRTZJd0pnTG5WMzFKTU5JajNoUXFsMWM1NHdaYytPdEw2OGln?=
 =?utf-8?B?QkdNVFRSMkdtcEt3dUlubVVOZVE1bHJlcG1YZHo2NGZzdkxLaWhRa2lYTDNa?=
 =?utf-8?B?R3lyWDVkQUoyMmNyQ1lnTWYzMjM3R1JtTE5OMytrVGlQTTdOVytxQ091dTUr?=
 =?utf-8?B?STFhclVUVW5jdVlLQ2w3T0VGV3NpbmJNL0w3Q2F4TDF2MW1taGpJNkxMSmQ1?=
 =?utf-8?B?STJFRGVJbEdLSnRHVWRaSHQ1dHRLNDE0ODZLa0RQUlRtOGxpODZndkJNVjFw?=
 =?utf-8?B?ejh1dHAyQnplWE9ma0lKd1RVMWdNNEhUWTRuZXZSUEsyUG5nYm5sZk5jVlMx?=
 =?utf-8?B?WDQyNzlaTkJtQW1rNWtqYTd6dlN5Vk1PNm5kbnkySmtPNndoR0c4c2RtUFRQ?=
 =?utf-8?B?dXo3ZTg4Qm9kNUJ0WXlER2QvUUJ0V3h1cWJOTTJlSHhzWGdDeElhSWN1TEtr?=
 =?utf-8?B?eG5NMGRhLzFKNHp0MFJ0emNSZ3RTNnZmeTB6WW5tMWhaVzNaUW5CZVRMM2xM?=
 =?utf-8?B?SmFzMm13dVk0TS9KTkh2aitwVWUwTy95a2c1QkpCTFNsUkREYnFVU21xc1M0?=
 =?utf-8?B?SmNaWTJ0d2ZFVGZyRG5VL3d6QXVUZDlqZE01UXRzU1BlckZtb3E5bEhPUGw1?=
 =?utf-8?B?cUlJRXgyYjY0eDZCZmpQSk5nVENyTVNldnoycnJLV2swdTMwNFcyb1RNblE0?=
 =?utf-8?B?U3E5UTlXRnFaSnpSZUczZ1RPRFVXcG1MelQxRzVGMko4Y1Z6c1JlRDJ1bGNi?=
 =?utf-8?B?UUYrQlVWTFptaEN6Y1cyNEdjYU82WlpxRnRPSUdma3VGMS9VWUlheHJGNjlF?=
 =?utf-8?B?VWlPUCtZRFhneU02cEdFSk9saHNVeFMzMHRhemtJdmJGdVRCR3Z1N0tjSE01?=
 =?utf-8?B?UjZlbDFjUEtlaE5NVHg0ekUzSE5IMDJzbmJjY0ptL200SStDS0R2VW5mRlF4?=
 =?utf-8?B?UXIvOWhxa0V0NUhPM0liemxZSWdKelpaVnRUQ0JZY1cvT1l4TmJHNFRacUpy?=
 =?utf-8?B?bGFMcUVONkM5QnRFWlJHL0poRVQweDFGL0FHaTdva0pOemtrY0VOZnZyYUpm?=
 =?utf-8?B?R2UvbVc1TE05N2JSUTkreTUyUFJvaUZrQVZXNjd0QThKbklhQXVXUkxvdUJD?=
 =?utf-8?Q?sGCMQ5Kr1jUaMw1O1/1Gh2wNLRUZen94FGkoA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkR6WTRzNGVyRWlQZ3VGUFlKUm5iOGUzZkN2cEVNYTg0bEJQajRwYTQwbWdx?=
 =?utf-8?B?MTB1aEFIclRoR3JrT1FuVHRSL0hObFJrYTA1amx0QUtIQ0h5WVJVb3ZJTDlN?=
 =?utf-8?B?bFhkbWVtS3RsZXdoL3diNFQvaEJibzU5VjJqSmRyZDc3VUxXT25za3Q5YlNY?=
 =?utf-8?B?MENmVWRHZk5ZaE11YVd2WU1JSUlmSWNSc2F5bXpuSnNtQjgvNGV2SkxIaG1i?=
 =?utf-8?B?RjJnTlJWTXVyOUk2N1FITXpnZ0FraVNRV3F1OWxabUdlOGFxbDM3OW1xOUEy?=
 =?utf-8?B?ZWlmL1pPaERpZnVYZ0IvL2JqZWZ6bGxWZHJwQzV4cEIxeHpvSW9zU2ptUFlk?=
 =?utf-8?B?Rm83aFdZaGVaNlEweEJwbmNiOXJrejh5K2pOS3VXYmdzTDhSalZxZ2tSZ2JU?=
 =?utf-8?B?NzcyajFVRjRPM3poajZyeUg1VHdaUEZuUTFGQWcwMWlYT3V6UzlGM2RBbG8w?=
 =?utf-8?B?WjEvZ25xZmQ0Qmh3d0kwbkorNnJCcGp2a2ZNdFcwNTczS25rTGRlQldSQWIy?=
 =?utf-8?B?UmdVSWYzeDZiMEdISTdDV1NxY1dKWTJrdGFKWjRzeFF5d3JqcWVXSkVJY0Yv?=
 =?utf-8?B?b25EeVoyUTIrS0ZybGJickg0VnVlS0p1M1ovcFBVdk9ic3FuNzR0OXZPT1A3?=
 =?utf-8?B?S3F3eHhxVnJwMGJ1OEc2N1N3UVRtbUtVUUF6cnpOb3BvT2dXWjlJL01jeG0z?=
 =?utf-8?B?bTBmNkxtTXZvRWN5Tm9BcFIvMDViYmtaYkpwQjNJdndRcGlwcERia09RVDNR?=
 =?utf-8?B?SlRSY0pSd0VUdkxJYnptUlhEZ2RpQnl6OUc0OVFsUFBKQ2JVL3dyb2dqY25C?=
 =?utf-8?B?QUNhblg3dkVuL0F0MG1nYkJZZGsveUd1SDc4QkxuWDluSTBhWUozQk14WDhL?=
 =?utf-8?B?c0haQWNVRjk1a2VQZVJ1MjRLTEp4QUlTOUNIdng2SDJzeFVjR01vT1dyL0NY?=
 =?utf-8?B?TDI4bm1QL0JaMFppbGR4b21sYUtSRUNuZjR2NXlJWGlBYjVsV0hmQkZsU1ZS?=
 =?utf-8?B?OTRJVldLRHlsZUc3WTZUTXQ0KzRZR1V5WTdGQTgyekFvNWZKd1ZRTFVJM0dF?=
 =?utf-8?B?NEdkaGFWci90anZHQm1VWUZuWkhUcG01Wk1CVm1CQmI1WkxaRXRVU0hSR1Rk?=
 =?utf-8?B?Ykk5d3g4bzhZbDN4MGZUaTIrTW4vbnRacE9uSUhJM09rNU54SW0yS0RBUHFv?=
 =?utf-8?B?bHg2alp0djRGeDBzWC83ZTI0VXUvQ1RzWnczcnhGNEtwTUwwaldNb3ExcTRX?=
 =?utf-8?B?YTh6eEhvam9sNFpDb3pSNGc4VUFuN2pXQWM3UzJ4R2wxa1FMaHdGaXFZMUpn?=
 =?utf-8?B?anRlVDJ6eUlsL0pBZnhhV24wakxVV2ZpeDhpWDhZWG5RMXpuRXp3YjVNbDhL?=
 =?utf-8?B?ak9IN1VQakNiakg0emtwUVh6ZVJNQVFoOHpjTmQ1UHl3dk5BeE9DM1c2dFAz?=
 =?utf-8?B?c01xeGwvZFd3d2JMSUVwZDh4bnRleW5vUVdCeVZyTmRCNU5mWnRSRG9PQk94?=
 =?utf-8?B?WFFSblRrZnlXdkZFdVgrODVOZlF5NFlxNHNJNkI1VHRyWHlWNGwwNnhKbURN?=
 =?utf-8?B?aTAyc2V5VHIyRjFIRitRejYyMFZNVHlHQjUvYUtUTDEreGd5WERsRW5GRlZT?=
 =?utf-8?B?a2llSDJabnRtbXU1cUFRaENlNUQrWll5cFRPK3VHWU5ZRE9QaGQ2REZCY2NC?=
 =?utf-8?B?c3kwQUN1aWU3ZDFkc2pteVAzVUdLeTJ5aEo5cVRMalRvU3Jrb3FIaHMrRjVW?=
 =?utf-8?B?aXZBeUhkMlg2bURrc1NydDdhK3VoYXVDQmdsYy9uVU9XQW8rSHpLc0NmK29p?=
 =?utf-8?B?T054YWtlVTEyR0dZcmRZNFMxRURRUGxMTWZnUDNtaytrU0VVU3FhdXNubStE?=
 =?utf-8?B?Q0d0dWExbHVJRmFNdlNTNzhIM3Z1KytiOVBuRVozTFVTU2x1SmR5TWFKUmNj?=
 =?utf-8?B?L3cySThaYzRUZDJlYlJBWERDZ2d6UXk3T2RRL2RRQ2wxcWNQOGdBdS96MC9S?=
 =?utf-8?B?blE2SkhMY2p6UWQyclFIWEptOTFVQWZYQW1FRWM1SXljT1RZVVJ4anZIQTZX?=
 =?utf-8?B?MDBGNk9kY0xaejc5Y0pQZVRaT0RlOTgzdHo2dnRkZDMvUSt1cnViUFIvTlR1?=
 =?utf-8?Q?31ZX9NCqlXxIDti9qEZ+iDsQa?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d57960c-7ce7-402d-9a81-08dcf303d96f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 01:41:43.7742 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wfe1QT5yklSQB26KF0K4c/6XWu0wdByh1Jw2rylQ8Cn6rjbUz3QyzmYXV+twjQsdPFSL+u91NNcjA7ZluT+fsiqQLWVyRF2dppx/zgp1jmo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6158
Received-SPF: pass client-ip=2a01:111:f403:200e::719;
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

SGkgQ2VkcmljLCANCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDAxLzE4XSBhc3BlZWQvc21j
OiBGaXggd3JpdGUgaW5jb3JyZWN0IGRhdGEgaW50byBmbGFzaCBpbg0KPiB1c2VyIG1vZGUNCj4g
DQo+ID4+DQo+ID4+ICAgc3RhdGljIGNvbnN0IFZNU3RhdGVEZXNjcmlwdGlvbiB2bXN0YXRlX2Fz
cGVlZF9zbWMgPSB7DQo+ID4+ICAgICAgIC5uYW1lID0gImFzcGVlZC5zbWMiLA0KPiA+PiAtICAg
IC52ZXJzaW9uX2lkID0gMiwNCj4gPj4gKyAgICAudmVyc2lvbl9pZCA9IDMsDQo+ID4+ICAgICAg
IC5taW5pbXVtX3ZlcnNpb25faWQgPSAyLA0KPiA+PiAgICAgICAuZmllbGRzID0gKGNvbnN0IFZN
U3RhdGVGaWVsZFtdKSB7DQo+ID4+ICAgICAgICAgICBWTVNUQVRFX1VJTlQzMl9BUlJBWShyZWdz
LCBBc3BlZWRTTUNTdGF0ZSwNCj4gQVNQRUVEX1NNQ19SX01BWCksDQo+ID4+ICAgICAgICAgICBW
TVNUQVRFX1VJTlQ4KHNub29wX2luZGV4LCBBc3BlZWRTTUNTdGF0ZSksDQo+ID4+ICAgICAgICAg
ICBWTVNUQVRFX1VJTlQ4KHNub29wX2R1bW1pZXMsIEFzcGVlZFNNQ1N0YXRlKSwNCj4gPj4gKyAg
ICAgICAgVk1TVEFURV9CT09MKHVuc2VsZWN0LCBBc3BlZWRTTUNTdGF0ZSksDQo+ID4+ICAgICAg
ICAgICBWTVNUQVRFX0VORF9PRl9MSVNUKCkNCj4gPj4gICAgICAgfQ0KPiA+PiAgIH07DQo+ID4N
Cj4gPiBJIHRoaW5rIHRoaXMgd2lsbCBicmVhayBtaWdyYXRpb24gY29tcGF0aWJpbGl0eS4gSW4g
b3JkZXIgdG8gZW5hYmxlIGF0DQo+ID4gbGVhc3QgZm9yd2FyZCBtaWdyYXRpb24sIGl0IHNob3Vs
ZCBiZToNCj4gPg0KPiA+ICAgICAgVk1TVEFURV9CT09MX1YodW5zZWxlY3QsIEFzcGVlZFNNQ1N0
YXRlLCAzKSwNCj4gDQo+IFRoaXMgaXMgY29ycmVjdC4gSSB3aWxsIGZpeCB0aGUgcGF0Y2guDQo+
IA0KSWYgSSBuZWVkIHRvIHJlLXNlbmQgdjMgcGF0Y2gsIEkgd2lsbCBmaXggaXQuDQpUaGFua3Mg
Zm9yIGhlbHAuDQpKYW1pbg0KDQo+IFNvbWUgYmFja2dyb3VuZCwNCj4gDQo+IFRoZSBhc3BlZWQg
bWFjaGluZXMgYXJlIGZ1bGx5IGVtdWxhdGVkIGFuZCB0aGUgQXNwZWVkIFNvQyBtb2RlbHMgYXJl
IG5vdA0KPiBwYXJ0IG9mIGFueSB2aXJ0KiBtYWNoaW5lcyAoeWV0KS4gU28gbWlncmF0aW9uIHN1
cHBvcnQgaXMgYSBiaXQgb2YgYSB0aGVvcnkuIFdlDQo+IGhhdmUgZG9uZSBvdXIgYmVzdCB0byBt
YWludGFpbiBzb21lIHN1cHBvcnQsIGNvbXBhdGliaWxpdHkgbm90IGJlaW5nIGENCj4gcHJpb3Jp
dHkuIElPVywgaXQncyBub3QgcGVyZmVjdGx5IHR1bmVkIGFzIG9uIHZpcnQgbWFjaGluZXMuDQo+
IA0KPiBBbHNvLCBvbiBBUk0sIG1pZ3JhdGlvbiBvZiB0aGUgQ1BVIHNlY3VyZSBtb2RlIChJIHRo
aW5rIHRoaXMgaXMgdGhlIHJlYXNvbiwNCj4gUGV0ZXIgcGxlYXNlIGNvcnJlY3QgbWUgISkgaXMg
bm90IHN1cHBvcnRlZCBhbmQgaWYgbWlncmF0aW9uIGlzIGluaXRpYXRlZCBhZnRlcg0KPiBMaW51
eCBoYXMgc3RhcnRlZCwgdGhlIG1hY2hpbmUgd2lsbCBoYW5nLg0KPiANCj4gSG93ZXZlciwgaWYg
b25lIGRheSwgYW4gYXNwZWVkIG1vZGVsIGJlY29tZXMgcGFydCBvZiBhIHZpcnQgbWFjaGluZSwg
d2UNCj4gc2hvdWxkIGJlIG1vcmUgY2FyZWZ1bC4gSSB3b3VsZCBzdGFydCBieSByZXNldHRpbmcg
YWxsIHZtc3RhdGUgdmVyc2lvbnMgdG8gMSENCj4gDQo+IFRoYW5rcywNCj4gDQo+IEMuDQo+IA0K
PiANCj4gDQo+ID4NCj4gPiBGb3IgYWxsb3dpbmcgYmFja3dhcmRzIG1pZ3JhdGlvbiwgdG9vLCB3
ZSBzaG91bGQgY29uc2lkZXIgbWFraW5nIGl0IGENCj4gPiBzdWJzZWN0aW9uIGluc3RlYWQgdGhh
dCBhbGxvd3MgbWlncmF0aW9uIGluIHRoZSBkZWZhdWx0IGNhc2Ugb2YgYW4NCj4gPiBpZGxlIGRl
dmljZS4NCj4gPg0KPiA+IEtldmluDQo+ID4NCg0K

