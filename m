Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7FDDD66BA5
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 01:15:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tG6cr-0005h3-3N; Tue, 26 Nov 2024 20:13:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tG6cm-0005gd-EW; Tue, 26 Nov 2024 20:13:48 -0500
Received: from mail-eastasiaazlp170100000.outbound.protection.outlook.com
 ([2a01:111:f403:c400::] helo=HK2PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tG6cf-00019f-Ba; Tue, 26 Nov 2024 20:13:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WTf8OGF/UtNwBMfZX8Rwpjmk1fCfwVVyqXhxUgZNiO+WLQZOnI5e2wAdoAZE5UPlvtSCIAjOSQ9WPLwTxF+enEv5aTEB/m2Ub1BOSE4H17M6qNWU2jvaexkj02eHMJYlXnmxdNkfmNYdlacHTZH4nKhtpOL/+nrjWWHCAD1FG6t41opLG6B/50RXwWz+ToGay0kyqXKxFjHY+tf4anfLFeC5TPlAm0yU0qeZZvFqY1jFzQPMiXdUjA1dSSYlnOM8DOfzyn4te+Zz4sdbxd0+tkRQoNLretFdDbjAboDcxYsk5/CixxdUDjjY4x+r2dl7XyRo+uNMPldojvfyeQxDAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wk64e20sD02J0H0zfDcvTuBpFf+GFw5rqZuWCX2mzT0=;
 b=xl+K2Ji+4PQzGpYe8afVCqLv9wfoykX5bMhnWJVFZkVf9+QyzgrutjK8vG4Jy/x+5RNGv5Ur4FbttOlly43yEIxFIR6ghuofPT+JrlaOHhgDdHje5fjN/KjIY4EF98t3jRKBdClAye2L5dmb8HIwVJvPDPI6eoLRCl5ye1UjV9ybYcA2y0GLIzqa6BZ25GmulBKcsdi5l9J/o+iwJI5prlidGb11a/Cv1kPYO4bdxrOedJXyU0exyzRz5uLoKauyaYUihJ5dUIxch8SPeeW35rjEz0eHP8viy+UX07S5ftSWyDOMyWHKNzYLlONYv+qXXI2pu1KSZoXjf1IsikvdDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wk64e20sD02J0H0zfDcvTuBpFf+GFw5rqZuWCX2mzT0=;
 b=ZaGwU0IFdkAqRNxYHDNEaVM5x1qfB2HkTFDRja9SzzDM2dSFHRX0B3zVSIaz6QnYBPz+Zt7lC/TjEGuSN2xY3G6FzlUmty7eiHBMwanFrEDMoWHUYwuD1l+Jf7kzULU7nTIWD/C7wAw/pYNCE19v1I/a8EW8AaZSbPMBUM3pjfhnzeEQi9g5aTKdNUa300tp6uHySyD3HpwdqJ89QnqoGmj86gzu64yJUQNn1Q9cCXIt8FVz6i6lixw4Hp8mgdxnobQWkw6He2twr0tHI5cAJrGKF0fTVebnP/5P8yUJ+rnabzzybaqfNhktmbwJBKPAgbAVtdcBfWVTTjvXrT2puQ==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TYZPR06MB7095.apcprd06.prod.outlook.com (2603:1096:405:b6::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.13; Wed, 27 Nov 2024 01:13:26 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 01:13:26 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>, Kevin
 Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>, "open list:Block layer
 core" <qemu-block@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v2 07/18] aspeed: Fix hardcode attach flash model of spi
 controllers
Thread-Topic: [PATCH v2 07/18] aspeed: Fix hardcode attach flash model of spi
 controllers
Thread-Index: AQHbJGacdxuY7+0jikCm0QDc7o2fGbKSlxWAgAA4TACAANANsIA2Wy8AgACPAiA=
Date: Wed, 27 Nov 2024 01:13:26 +0000
Message-ID: <SI2PR06MB504134DC910AFD6DADB8CDA5FC282@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20241022094110.1574011-1-jamin_lin@aspeedtech.com>
 <20241022094110.1574011-8-jamin_lin@aspeedtech.com>
 <e1803cd1-f4fd-4d1a-a8e9-5a5ed86c59e7@kaod.org>
 <6118d5bd-342e-41d3-aaf5-4ce9715a9ea1@kaod.org>
 <SI2PR06MB5041D0605EA1EC813A09F48BFC4D2@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <40c40ef6-cae5-474d-a35d-13cf45207f96@kaod.org>
In-Reply-To: <40c40ef6-cae5-474d-a35d-13cf45207f96@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TYZPR06MB7095:EE_
x-ms-office365-filtering-correlation-id: 911bd1e5-6487-4eae-1b33-08dd0e80b20d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|921020|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?TVcrZ1ZuSUlpQ3pCRUFRWTIrbDNkRlAvZWJCdDBxOXh4SFBYT3lNb1J5ZHlM?=
 =?utf-8?B?NXdjUlVBVEJxZFpDNkMxK2hMK28yTU05SzFjTWxlRmdQb2k4eFIwL08xZHZR?=
 =?utf-8?B?ZThaWndPR05hTXFheGZ2WGh1SHJFTXBiYi9LQlppZXc1NEEweEppOGRLMTJG?=
 =?utf-8?B?Y2Y3SHI1TVNBVTNEOTEwYnc3NUdWK2hyZ2ZuT3I4ZUtpRXVJSXBrNXlDR1hY?=
 =?utf-8?B?aXoxOEdJT2NWUEdyZmUzZ2JIOTIrWnhoanpQUnV4ZENCVTc5MzgxcHhKUkRy?=
 =?utf-8?B?WmY2VmZ1SDMvVzVDZk5HbjVBajBnc05zbVZIVjRJYjFGZGxBakhyVFE1SWww?=
 =?utf-8?B?aUpFK1l3eFhkK3hZTnFKY2I0S0kzSTEwZFhHa3AzSGF0YUpEa2MzajZOblBS?=
 =?utf-8?B?L1p5ZXdXTnNDbVVNQ0lUcVIxUFg5UFdJUWpGWWlURU1UNjBHOHhoUkl3WlZn?=
 =?utf-8?B?K2phdkJPaU1VWTBjakJYOHM5WGV0YjJPaWpLVVhvSzFyOXRlU01BVkFPMFVp?=
 =?utf-8?B?M2pSZGZud3dpdkJReENnZjNid3pDeFJya2c4Ny9qMm5OdFhLSVhFNDJERHBi?=
 =?utf-8?B?eHcySEF4aUJoWE5PMjFJUDRHWEFnYTFKQUZtSDhTUTVOWXdJWE9PeThhdDBz?=
 =?utf-8?B?UnphQ3hGVDUzTStmczk2akJLZ28xZGtFSkxnNGxOLzJvSmdOOVEvVWZvU0xy?=
 =?utf-8?B?empiQ1VFdmJ4OEU4dDNaRDliZ3MwVDVWUXQyVTRWcTVBL0wxcnZJNHh0T0V1?=
 =?utf-8?B?NmNMQ0Foa3FMVUE0M0VPNWlwVCtwWU10empuV0NBMDhscTVLQzQrZ1lHNElh?=
 =?utf-8?B?ckc5ZGthVUVDOExmanpBN3BjSHhkZTdXS1lTRm9PeWN3RkdCeWx2V1p6VVlS?=
 =?utf-8?B?NUQ5TGJ5MlNKQituY0NrdllvRE1kQWxMNlVVdWNyR1h3K3p2OWl1M2RWN3RR?=
 =?utf-8?B?cU9SSld0aEM4ZXVnbmRjd282cU9rejcveDJUNWxJdWN6Yk9KenFJNFE4OUFj?=
 =?utf-8?B?eHBOQ2hEUldHblhxUS9ZVmRFZS9QNGExUjFLaExpZW4yWHNqQ2pUNnBvb1I1?=
 =?utf-8?B?czM0UEZ5V0pBRHNKKzZSQmpsYyswODBUSVhCM1hvbHNaeHk0L2lzVVJJMEhG?=
 =?utf-8?B?a2xLL2VEekhkeVlFbTNwWXZ2d2JQTlllNFlNMFp1OENWN2VhaVRIZ09wNzlJ?=
 =?utf-8?B?azJWdWszd0R1Wm04TURDWmtDNTJMaWN4MC9Ud2k5VENZbnZ5U2kwZWtHSkcz?=
 =?utf-8?B?RElsOE9WelJQRjE5eXA5c2dWL1NLeVZqbGNMeDRuS3N3Z2JrVjBBYXl5eHc1?=
 =?utf-8?B?Ukd5WUFLZ0IrNEZGc0VnQmg1bFFzOEkyYWVZR3RNRVBtK29GbmFHcGNXWHVY?=
 =?utf-8?B?SzBaUnlwVTJtTm1tL3NxMUs1VzVKUDFBdy9CcnJydDR0VjN1Wk5leC9TRDI3?=
 =?utf-8?B?SUVBUzhqTEovRG4xNU1MSEJWRmhKTkc4NE1pNklQdzZXTzFEbDZXMHM4ejZy?=
 =?utf-8?B?Q09EV0NZdzlySmNzTFJTOENwRFFCcU5JZi9peS8veGJzRlpDVWYyZjUzSHBu?=
 =?utf-8?B?bGlJYVVQZHcyMzRncGsxRnkvMGJML2c3d1R2NklKSEJzaCtJUC8wOGFDYlNs?=
 =?utf-8?B?VHNWVWFJeklpdjJPeHdYdU1OZ2puMTkvZFFBeXYzcHJmSzVBSit1eTVMZnlS?=
 =?utf-8?B?bkJ1VHB4cjhwOHVBY29kWWVmNmp1WXk0RVZqMG9ucXJTUTl6U2pTOUNnM21v?=
 =?utf-8?B?dWVJRGEwaStYbU1JeG1vUHVyTWNDb0VXUnBzRXFYYmhjbU1PaTF0N2ZYNjEy?=
 =?utf-8?B?NkNwZkk5anRtelpHV0FvbHB5Z0xISlBQd3RYaTczRXJpVldsUGorVGR0Um9F?=
 =?utf-8?Q?G1nmL0rdFpQTl?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDQ2dnVnMEZHQXZtWmFuSFdsZGhKenhlQk91U3lra25HVUlZTkxaWXNKZjdt?=
 =?utf-8?B?d3dUNmVQRmNOTWIyQ2QzVjRBUmN1OS9QYUtFTG1GVEFuVkVhc1pZdmNHdmoz?=
 =?utf-8?B?ckdqV3p4T3hMNjZYQkVJdDNLejY0bmkzQWhLQUp1RVRTd09zSWlYNmVEQ2VB?=
 =?utf-8?B?NGFCU1gyL1R1K0VsSldIQXVJLzZJL2ZucFpLQ3pGRXhtdG03aDNPUmFFa1dK?=
 =?utf-8?B?RHZ5VkVKTkJ6VnFtTitkTVc1RFAzditmREU5NWVqcm00c1ZvYmNkd0VYMHh4?=
 =?utf-8?B?dkZPN2F0eXlNaWprMUZFeEZDcWRpM2hnSGl4dEppdy9ERkNnZmFjZ2ZzT3dy?=
 =?utf-8?B?a29NenZnOTdzMnhYZ002blI5anFkMUthcFMzaXN4MVNVMGpWMkM2TFZnbk5E?=
 =?utf-8?B?UWF5Zk9FZFprdy9tR0ZodXczbGtMWkJrbHhvWENFSlRhMVkxN0lUK0FtMkZO?=
 =?utf-8?B?WlFiTFlzNGhFU2RndWh5S3hSSVNpeU81MTRHOTBVaW0yMGVhNlhOM256Vi9q?=
 =?utf-8?B?YmtIUWd3S04zL2VESXhPWEVDWVJvMTF3VmZOd3dBRlBlcGhlZ3QxNmNmZ1FS?=
 =?utf-8?B?eE42Y08weGt4ZloxM3FIeXBLUlhYZnBpSDJ6bnRGMnI1bzd6V0kvYTU3VFFE?=
 =?utf-8?B?V2Qya2tBQ3NMcEFYUlVnL2lob2JXRFRndzgwNWVGZ1VZNU0rQVA2ZjJFSFFP?=
 =?utf-8?B?Mm9rU3dFREtOck5LUGE5K2wxK3p1SlpaY05kY1gyMlJ0VXU3cDcwZS9Lc2ZU?=
 =?utf-8?B?My80VEVCRzJYaFl3WUMrMjRtZzRCaktqa29ROU8rYXdhQk4wME1BbU5oTzgw?=
 =?utf-8?B?cm9LSFVWMFE0d1pCd1FXNjhIZWVGaTJRRlRHNk9YQjdHeXcyeVJkaFRtQ1Zn?=
 =?utf-8?B?RjZuUnNkcWhiZGcvay8weFk4cUx1dk5qY1pvcGxrMEdNdHR2WERQQnlxYWRi?=
 =?utf-8?B?aFJ1WjNtTE9weFhVcTJmczlGSW83SytXZzEwRWJnenRQcVgyeXlOclY1R00v?=
 =?utf-8?B?K1dsUGIydVl3WlV6QmlPc0ZnOTNGZ3FQWGxwVnZxMnNGRFZOOXRZLzg1LzY4?=
 =?utf-8?B?TmwzQk16THJpdGtZWXFiQ0tLRWlOb0JFemR1SkZRWjM5M0pnaUZKclJZREth?=
 =?utf-8?B?LzYrbWg3cjZrQjBHbnlKSUhYQjR0OUVKaG8zeVJhRS8rUzB0b09wdExOblV3?=
 =?utf-8?B?eFZURFFCcFF6T0hNTVU2YmRySEpLUFdUMXp4YWNwQlAzeWVFQ0JacXNNZFZE?=
 =?utf-8?B?VXdWbXNJdTRmVVJ5T3V2MHkvaXViUHJEcHN1a3lmYTNXVldtVFZmS25vdTJC?=
 =?utf-8?B?SHNicjdvTDRScEp6VW8wZGRsdDZvYmNEKzBvRzdCeXVmbGlTYllrQzVEVXRM?=
 =?utf-8?B?K1JTMURxaUEzY09scXlGNTBCQTJka0gyMHB4eUZTU3ZYcllDRDU4dElLd2k4?=
 =?utf-8?B?cmVyZDdML2RsWW5kY2d6ajhYbHdPWklVcTN4L1NDT2VWR2Z0QTNTOGROa2JN?=
 =?utf-8?B?dVh0aXQvTUZwUjAyMVdKVE1kRjY1U3RIai9LK0pYeUZnUk8xckJCZnBrM2lo?=
 =?utf-8?B?L2NJNUVNNEdGa0JmRkRiSytzT1UyVzJpeGh0cVk0OVdWd2Rld3krSFowQXFO?=
 =?utf-8?B?ZmNlSm0wd1VZMEZ5MjBTYko3dEZOZ3BpZHZ4M296bDhER3EzdnhhNHorRktw?=
 =?utf-8?B?MlRJUitxSmgxelBCYjRGZEM3UFFyckRCeDAvbFROMW1GVlppVUprTE41T0Fu?=
 =?utf-8?B?TEVqRHNoMW5wTlJuaXMzQkhla3pLQnk5ZXZmS0w0TWU3Qk5hZituUG9zMUJl?=
 =?utf-8?B?STlScXpsRE84TlJkQnZnT29BdVdXcmpKWGY1dk1FSzVrZTJoN3M2RGpObzZq?=
 =?utf-8?B?eW5EaXFsV1VlSXNxc1NkVG02cDAxaUtQb1dmV04rRmtxN2pweWE4YzN3NXND?=
 =?utf-8?B?WURwMVQ1ZkM5ZVA1NkRoNUswTEVyVjZCZVJYYloyVGhFNytUTWJsZ2lyd1pa?=
 =?utf-8?B?cWc0ZDV2SUdYMnF6Vi9WL1RpRW80V0VVYnpoR3V5VmplSmVBNGQ0V3d0NlRX?=
 =?utf-8?B?dkZFVDFkcEd0TnZxMEFtMUxxaEx3NTI3alBLZVE2TkhkQTB6diszdTVHY1ZQ?=
 =?utf-8?Q?cKU+fx9yJLwGjBGg1CKXgp08Z?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 911bd1e5-6487-4eae-1b33-08dd0e80b20d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2024 01:13:26.1906 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8o5/BRN9XOJ7U+vAfQHY6PAe4gJ2RDuw+SE336wBJ01fYBs2xcmVSbuyogbC9TrW3i+ugCzDKBISqWpJGcdgUj85cA9N5LZmikS1ZHyk8ME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7095
Received-SPF: pass client-ip=2a01:111:f403:c400::;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=HK2PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

SGkgQ2VkcmljLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMDcvMThdIGFzcGVlZDogRml4
IGhhcmRjb2RlIGF0dGFjaCBmbGFzaCBtb2RlbCBvZiBzcGkNCj4gY29udHJvbGxlcnMNCj4gDQo+
IEhlbGxvIEphbWluLA0KPiANCj4gU29ycnkgZm9yIHRoZSBsYXRlciBhbnN3ZXIuIEkgdGhpbmsg
SSBtaXNzZWQgdGhlIHF1ZXN0aW9uIGJlbG93Lg0KPiANCj4gT24gMTAvMjMvMjQgMDQ6NDYsIEph
bWluIExpbiB3cm90ZToNCj4gPiBIaSBDZWRyaWMsDQo+ID4NCj4gPj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2MiAwNy8xOF0gYXNwZWVkOiBGaXggaGFyZGNvZGUgYXR0YWNoIGZsYXNoIG1vZGVsDQo+
ID4+IG9mIHNwaSBjb250cm9sbGVycw0KPiA+Pg0KPiA+PiBvb3BzLiBSLWIgc2VudCBvbiB0aGUg
d3JvbmcgcGF0Y2guDQo+ID4+DQo+ID4+IE9uIDEwLzIyLzI0IDEyOjQ4LCBDw6lkcmljIExlIEdv
YXRlciB3cm90ZToNCj4gPj4+IE9uIDEwLzIyLzI0IDExOjQwLCBKYW1pbiBMaW4gd3JvdGU6DQo+
ID4+Pj4gSXQgb25seSBhdHRhY2hlZCBmbGFzaCBtb2RlbCBvZiBmbWMgYW5kIHNwaVswXSBpbg0K
PiA+Pj4+IGFzcGVlZF9tYWNoaW5lX2luaXQNCj4gPj4gZnVuY3Rpb24uDQo+ID4+Pj4gSG93ZXZl
ciwgQVNUMjUwMCBhbmQgQVNUMjYwMCBoYXZlIG9uZSBmbWMgYW5kIHR3byBzcGkoc3BpMSBhbmQN
Cj4gPj4+PiBzcGkyKSBjb250cm9sbGVyczsgQVNUMjcwMCBoYXZlIG9uZSBmbWMgYW5kIDMgc3Bp
KHNwaTAsIHNwaTEgYW5kIHNwaTIpDQo+IGNvbnRyb2xsZXJzLg0KPiA+Pj4+DQo+ID4+Pj4gQmVz
aWRlcywgaXQgdXNlZCBoYXJkY29kZSB0byBhdHRhY2ggZmxhc2ggbW9kZWwgb2YgZm1jLCBzcGlb
MF0gYW5kDQo+ID4+Pj4gc3BpWzFdIGluIGFzcGVlZF9taW5pYm1jX21hY2hpbmVfaW5pdCBmb3Ig
QVNUMTAzMC4NCj4gPj4+Pg0KPiA+Pj4+IFRvIG1ha2UgYm90aCBmdW5jdGlvbnMgbW9yZSBmbGV4
aWJsZSBhbmQgc3VwcG9ydCBhbGwgQVNQRUVEIFNPQ3MNCj4gPj4+PiBzcGkgY29udHJvbGxlcnMs
IGFkZHMgYSBmb3IgbG9vcCB3aXRoIHNjLT5zcGlzX251bSB0byBhdHRhY2ggZmxhc2gNCj4gPj4+
PiBtb2RlbCBvZiBhbGwgc3VwcG9ydGVkIHNwaSBjb250cm9sbGVycy4gVGhlIHNjLT5zcGlzX251
bSBpcyBmcm9tDQo+IEFzcGVlZFNvQ0NsYXNzLg0KPiA+Pg0KPiA+PiBUbyBiZSBob25lc3QsIEkg
YW0gbm90IGEgYmlnIGZhbiBvZiB0aGUgYXNwZWVkX2JvYXJkX2luaXRfZmxhc2hlcygpIHJvdXRp
bmUuDQo+ID4+IFNlZSBjb21taXQgMjdhMmM2NmM5MmVjIGZvciB0aGUgcmVhc29uLg0KPiA+Pg0K
PiA+PiBJIHByZWZlciB0aGUgbW9yZSBmbGV4aWJsZSBhcHByb2FjaCA6DQo+ID4+DQo+ID4+ICQg
cWVtdS1zeXN0ZW0tYXJtIC1NIGFzdDI2MDAtZXZiIFwNCj4gPj4gICAgICAgICAtYmxvY2tkZXYN
Cj4gbm9kZS1uYW1lPWZtYzAsZHJpdmVyPWZpbGUsZmlsZW5hbWU9L3BhdGgvdG8vZm1jMC5pbWcg
XA0KPiA+PiAgICAgICAgIC1kZXZpY2UgbXg2NnU1MTIzNWYsYnVzPXNzaS4wLGNzPTB4MCxkcml2
ZT1mbWMwIFwNCj4gPj4gICAgICAgICAtYmxvY2tkZXYNCj4gbm9kZS1uYW1lPWZtYzEsZHJpdmVy
PWZpbGUsZmlsZW5hbWU9L3BhdGgvdG8vZm1jMS5pbWcgXA0KPiA+PiAgICAgICAgIC1kZXZpY2Ug
bXg2NnU1MTIzNWYsYnVzPXNzaS4wLGNzPTB4MSxkcml2ZT1mbWMxIFwNCj4gPj4gICAgICAgICAt
YmxvY2tkZXYNCj4gbm9kZS1uYW1lPXNwaTEsZHJpdmVyPWZpbGUsZmlsZW5hbWU9L3BhdGgvdG8v
c3BpMS5pbWcgXA0KPiA+PiAgICAgICAgIC1kZXZpY2UgbXg2NnU1MTIzNWYsY3M9MHgwLGJ1cz1z
c2kuMSxkcml2ZT1zcGkxIFwNCj4gPj4gICAgICAgICAtbm9ncmFwaGljIC1ub2RlZmF1bHRzDQo+
ID4+DQo+ID4gVGhhbmtzIGZvciBub3RpZnkgbWUgdGhpcyBzb2x1dGlvbi4NCj4gPiBJIGNhbiBz
dWNjZXNzZnVsbHkgYXR0YWNoIHRoZSBkZWZhdWx0IGltYWdlIHRvIHN1cHBvcnRlZCBTUEkgY29u
dHJvbGxlcnMgd2l0aA0KPiBkaWZmZXJlbnQgZmxhc2ggbW9kZWwuDQo+ID4gSXQgc2VlbXMgd2Ug
bmVlZCB0byBhZGQgImRlZmF1bHRzX2VuYWJsZWQoKSIgaWYtc3RhdGVtZW50IGluDQo+ID4gYXNw
ZWVkX21pbmlibWNfbWFjaGluZV9pbml0IHRvIHN1cHBvcnQgdGhpcyBzb2x1dGlvbiBmb3IgQVNU
MTAzMC4NCj4gT3RoZXJ3aXNlLCBJIHdpbGwgZ2V0IHRoaXMgZXJyb3IuDQo+ID4NCj4gPiBxZW11
LXN5c3RlbS1hcm06IC1kZXZpY2UgdzI1cTgwYmwsYnVzPXNzaS4wLGNzPTB4MCxkcml2ZT1mbWMw
OiBDUw0KPiA+IGluZGV4ICcweDAnIGluIHVzZSBieSBhIHcyNXE4MGJsIGRldmljZQ0KPiA+DQo+
ID4gaHR0cHM6Ly9naXRodWIuY29tL3FlbXUvcWVtdS9ibG9iL21hc3Rlci9ody9hcm0vYXNwZWVk
LmMNCj4gPiAgIGlmIChkZWZhdWx0c19lbmFibGVkKCkpIHsNCj4gPiAgICBhc3BlZWRfYm9hcmRf
aW5pdF9mbGFzaGVzKCZibWMtPnNvYy0+Zm1jLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBibWMtPmZtY19tb2RlbCA/IGJtYy0+Zm1jX21vZGVsIDoNCj4gYW1jLT5mbWNfbW9k
ZWwsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFtYy0+bnVtX2NzLA0KPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAwKTsNCj4gPg0KPiA+ICAgIGFzcGVlZF9i
b2FyZF9pbml0X2ZsYXNoZXMoJmJtYy0+c29jLT5zcGlbMF0sDQo+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGJtYy0+c3BpX21vZGVsID8gYm1jLT5zcGlfbW9kZWwgOg0KPiBhbWMt
PnNwaV9tb2RlbCwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYW1jLT5udW1f
Y3MsIGFtYy0+bnVtX2NzKTsNCj4gPg0KPiA+ICAgICAgYXNwZWVkX2JvYXJkX2luaXRfZmxhc2hl
cygmYm1jLT5zb2MtPnNwaVsxXSwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
Ym1jLT5zcGlfbW9kZWwgPyBibWMtPnNwaV9tb2RlbCA6DQo+IGFtYy0+c3BpX21vZGVsLA0KPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhbWMtPm51bV9jcywgKGFtYy0+bnVtX2Nz
ICogMikpOw0KPiA+ICAgIH0NCj4gPg0KPiA+IERvIEkgbmVlZCB0byBzZW5kIHRoaXMgcGF0Y2gg
aW4gdjMgcGF0Y2ggc2VyaWVzPw0KPiA+IE9yIGluZGl2aWR1YWxseSBzZW5kIHRoaXMgcGF0Y2gg
aW4gdGhlIG5ldyBwYXRjaCBzZXJpZXM/DQo+IA0KPiANCj4gZGVmYXVsdHNfZW5hYmxlZCgpIHNo
b3VsZCBiZSB1c2VkIHRvIGF2b2lkIGNyZWF0aW5nIHRoZSBkZXZpY2VzIGluZGVlZC4NCj4gUGxl
YXNlIHNlbmQgYSBwYXRjaCBmb3IgaXQuIE9yIGRpZCB5b3UgYWxyZWFkeSA/DQo+IA0KIA0KVGhp
cyBwYXRjaCBoYWQgYmVlbiBhcHBsaWVkLA0KaHR0cHM6Ly9naXRodWIuY29tL3FlbXUvcWVtdS9j
b21taXQvMjJiM2M1NTdmZmQ0ZmI5YzZjMDM0YTgzOWIzZTViODJkMTMxMTIzYSANCg0KVGhhbmtz
LUphbWluDQoNCj4gVGhhbmtzLA0KPiANCj4gQy4NCj4gDQo+IA0KPiANCj4gPg0KPiA+IEFTVDEw
MzA6DQo+ID4gLWJsb2NrZGV2IG5vZGUtbmFtZT1mbWMwLGRyaXZlcj1maWxlLGZpbGVuYW1lPS4v
Zm1jX2NzMF9pbWcgXCAtZGV2aWNlDQo+ID4gdzI1cTgwYmwsYnVzPXNzaS4wLGNzPTB4MCxkcml2
ZT1mbWMwIFwgLWJsb2NrZGV2DQo+ID4gbm9kZS1uYW1lPWZtYzEsZHJpdmVyPWZpbGUsZmlsZW5h
bWU9Li9mbWNfY3MxX2ltZyBcIC1kZXZpY2UNCj4gPiB3MjVxODBibCxidXM9c3NpLjAsY3M9MHgx
LGRyaXZlPWZtYzEgXCAtYmxvY2tkZXYNCj4gPiBub2RlLW5hbWU9c3BpMWMwLGRyaXZlcj1maWxl
LGZpbGVuYW1lPS4vc3BpMV9jczBfaW1nIFwgLWRldmljZQ0KPiA+IHcyNXEyNTYsYnVzPXNzaS4x
LGNzPTB4MCxkcml2ZT1zcGkxYzAgXCAtYmxvY2tkZXYNCj4gPiBub2RlLW5hbWU9c3BpMWMxLGRy
aXZlcj1maWxlLGZpbGVuYW1lPS4vc3BpMV9jczFfaW1nIFwgLWRldmljZQ0KPiA+IHcyNXEyNTYs
YnVzPXNzaS4xLGNzPTB4MSxkcml2ZT1zcGkxYzEgXCAtYmxvY2tkZXYNCj4gPiBub2RlLW5hbWU9
c3BpMmMwLGRyaXZlcj1maWxlLGZpbGVuYW1lPS4vc3BpMl9jczBfaW1nIFwgLWRldmljZQ0KPiA+
IHcyNXEyNTYsYnVzPXNzaS4yLGNzPTB4MCxkcml2ZT1zcGkyYzAgXCAtYmxvY2tkZXYNCj4gPiBu
b2RlLW5hbWU9c3BpMmMxLGRyaXZlcj1maWxlLGZpbGVuYW1lPS4vc3BpMl9jczFfaW1nIFwgLWRl
dmljZQ0KPiA+IHcyNXEyNTYsYnVzPXNzaS4yLGNzPTB4MSxkcml2ZT1zcGkyYzEgXCAtbm9kZWZh
dWx0cw0KPiA+DQo+ID4gQVNUMjYwMDoNCj4gPiAtYmxvY2tkZXYgbm9kZS1uYW1lPWZtYzAsZHJp
dmVyPWZpbGUsZmlsZW5hbWU9JDEgXCAtZGV2aWNlDQo+ID4gbXg2NnU1MTIzNWYsY3M9MHgwLGJ1
cz1zc2kuMCxkcml2ZT1mbWMwIFwgLWJsb2NrZGV2DQo+ID4gbm9kZS1uYW1lPWZtYzEsZHJpdmVy
PWZpbGUsZmlsZW5hbWU9Li9mbWNfY3MxX2ltZyBcIC1kZXZpY2UNCj4gPiBteDY2dTUxMjM1Zixj
cz0weDEsYnVzPXNzaS4wLGRyaXZlPWZtYzEgXCAtYmxvY2tkZXYNCj4gPiBub2RlLW5hbWU9c3Bp
MSxkcml2ZXI9ZmlsZSxmaWxlbmFtZT0uL3NwaTFfY3MwX2ltZyBcIC1kZXZpY2UNCj4gPiBteDY2
dTUxMjM1Zixjcz0weDAsYnVzPXNzaS4xLGRyaXZlPXNwaTEgXCAtYmxvY2tkZXYNCj4gPiBub2Rl
LW5hbWU9c3BpMixkcml2ZXI9ZmlsZSxmaWxlbmFtZT0uL3NwaTJfY3MwX2ltZyBcIC1kZXZpY2UN
Cj4gPiBteDY2dTUxMjM1Zixjcz0weDAsYnVzPXNzaS4yLGRyaXZlPXNwaTIgXCAtbm9kZWZhdWx0
cw0KPiA+DQo+ID4+IHdoaWNoIGRvZXNuJ3QgdXNlIHRoZSBkcml2ZV9nZXQoKSBpbnRlcmZhY2Ug
YW5kIHNvLCBkb2Vzbid0IG1ha2UNCj4gPj4gYXNzdW1wdGlvbiBvbiB0aGUgb3JkZXIgb2YgdGhl
IGRyaXZlcyBkZWZpbmVkIG9uIHRoZSBRRU1VIGNvbW1hbmQgbGluZS4NCj4gPj4NCj4gPj4gQWxz
bywgdGhlIG51bWJlciBvZiBhdmFpbGFiZSBmbGFzaCBkZXZpY2VzIGlzIGEgbWFjaGluZSBkZWZp
bml0aW9uLA0KPiA+PiBub3QgYSBTb0MgZGVmaW5pdGlvbi4gTm90IGFsbCBDUyBhcmUgd2lyZWQu
DQo+ID4+DQo+ID4+IEkgd2lsbCBkcm9wIHRoYXQgcGF0Y2ggZm9yIG5vdy4NCj4gPj4NCj4gPiBV
bmRlcnN0YW5kIGFuZCB0aGFua3MgZm9yIHN1Z2dlc3Rpb24uDQo+ID4gSmFtaW4NCj4gPj4NCj4g
Pj4gVGhhbmtzLA0KPiA+Pg0KPiA+PiBDLg0KPiA+Pg0KPiA+Pg0KPiA+Pg0KPiA+Pj4+IC0tLQ0K
PiA+Pj4+ICDCoCBody9hcm0vYXNwZWVkLmMgfCAyMSArKysrKysrKysrKystLS0tLS0tLS0NCj4g
Pj4+PiAgwqAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0p
DQo+ID4+Pj4NCj4gPj4+PiBkaWZmIC0tZ2l0IGEvaHcvYXJtL2FzcGVlZC5jIGIvaHcvYXJtL2Fz
cGVlZC5jIGluZGV4DQo+ID4+Pj4gYjRiMWNlOWVmYi4uN2FjMDFhMzU2MiAxMDA2NDQNCj4gPj4+
PiAtLS0gYS9ody9hcm0vYXNwZWVkLmMNCj4gPj4+PiArKysgYi9ody9hcm0vYXNwZWVkLmMNCj4g
Pj4+PiBAQCAtNDE5LDkgKzQxOSwxMSBAQCBzdGF0aWMgdm9pZCBhc3BlZWRfbWFjaGluZV9pbml0
KE1hY2hpbmVTdGF0ZQ0KPiA+Pj4+ICptYWNoaW5lKQ0KPiA+Pj4+ICDCoMKgwqDCoMKgwqDCoMKg
wqAgYXNwZWVkX2JvYXJkX2luaXRfZmxhc2hlcygmYm1jLT5zb2MtPmZtYywNCj4gPj4+PiAgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgYm1jLT5mbWNfbW9kZWwgPw0KPiA+PiBibWMtPmZtY19tb2RlbCA6DQo+ID4+Pj4gYW1jLT5m
bWNfbW9kZWwsDQo+ID4+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFtYy0+bnVtX2NzLCAwKTsNCj4gPj4+PiAtwqDCoMKg
wqDCoMKgwqAgYXNwZWVkX2JvYXJkX2luaXRfZmxhc2hlcygmYm1jLT5zb2MtPnNwaVswXSwNCj4g
Pj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBibWMtPnNwaV9tb2RlbCA/DQo+ID4+IGJtYy0+c3BpX21vZGVsIDoNCj4gPj4+PiBh
bWMtPnNwaV9tb2RlbCwNCj4gPj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAxLCBhbWMtPm51bV9jcyk7DQo+ID4+Pj4gK8KgwqDC
oMKgwqDCoMKgIGZvciAoaSA9IDA7IGkgPCBzYy0+c3Bpc19udW07IGkrKykgew0KPiA+Pj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFzcGVlZF9ib2FyZF9pbml0X2ZsYXNoZXMoJmJtYy0+c29j
LT5zcGlbaV0sDQo+ID4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBibWMtPnNwaV9tb2RlbCA/DQo+ID4+IGJtYy0+c3BpX21vZGVsIDoN
Cj4gPj4+PiArYW1jLT5zcGlfbW9kZWwsDQo+ID4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhbWMtPm51bV9jcywgYW1jLT5udW1fY3MN
Cj4gKw0KPiA+PiAoYW1jLT5udW1fY3MNCj4gPj4+PiArKiBpKSk7DQo+ID4+Pj4gK8KgwqDCoMKg
wqDCoMKgIH0NCj4gPj4+PiAgwqDCoMKgwqDCoCB9DQo+ID4+Pj4gIMKgwqDCoMKgwqAgaWYgKG1h
Y2hpbmUtPmtlcm5lbF9maWxlbmFtZSAmJiBzYy0+bnVtX2NwdXMgPiAxKSB7IEBADQo+ID4+IC0x
NTc5LDcNCj4gPj4+PiArMTU4MSw5IEBAIHN0YXRpYyB2b2lkIGFzcGVlZF9taW5pYm1jX21hY2hp
bmVfaW5pdChNYWNoaW5lU3RhdGUNCj4gPj4+PiAqbWFjaGluZSkNCj4gPj4+PiAgwqAgew0KPiA+
Pj4+ICDCoMKgwqDCoMKgIEFzcGVlZE1hY2hpbmVTdGF0ZSAqYm1jID0gQVNQRUVEX01BQ0hJTkUo
bWFjaGluZSk7DQo+ID4+Pj4gIMKgwqDCoMKgwqAgQXNwZWVkTWFjaGluZUNsYXNzICphbWMgPQ0K
PiA+PiBBU1BFRURfTUFDSElORV9HRVRfQ0xBU1MobWFjaGluZSk7DQo+ID4+Pj4gK8KgwqDCoCBB
c3BlZWRTb0NDbGFzcyAqc2M7DQo+ID4+Pj4gIMKgwqDCoMKgwqAgQ2xvY2sgKnN5c2NsazsNCj4g
Pj4+PiArwqDCoMKgIGludCBpOw0KPiA+Pj4+ICDCoMKgwqDCoMKgIHN5c2NsayA9IGNsb2NrX25l
dyhPQkpFQ1QobWFjaGluZSksICJTWVNDTEsiKTsNCj4gPj4+PiAgwqDCoMKgwqDCoCBjbG9ja19z
ZXRfaHooc3lzY2xrLCBTWVNDTEtfRlJRKTsgQEAgLTE1ODcsNiArMTU5MSw3IEBADQo+ID4+IHN0
YXRpYw0KPiA+Pj4+IHZvaWQgYXNwZWVkX21pbmlibWNfbWFjaGluZV9pbml0KE1hY2hpbmVTdGF0
ZSAqbWFjaGluZSkNCj4gPj4+PiAgwqDCoMKgwqDCoCBibWMtPnNvYyA9IEFTUEVFRF9TT0Mob2Jq
ZWN0X25ldyhhbWMtPnNvY19uYW1lKSk7DQo+ID4+Pj4gIMKgwqDCoMKgwqAgb2JqZWN0X3Byb3Bl
cnR5X2FkZF9jaGlsZChPQkpFQ1QobWFjaGluZSksICJzb2MiLA0KPiA+Pj4+IE9CSkVDVChibWMt
PnNvYykpOw0KPiA+Pj4+ICDCoMKgwqDCoMKgIG9iamVjdF91bnJlZihPQkpFQ1QoYm1jLT5zb2Mp
KTsNCj4gPj4+PiArwqDCoMKgIHNjID0gQVNQRUVEX1NPQ19HRVRfQ0xBU1MoYm1jLT5zb2MpOw0K
PiA+Pj4+ICDCoMKgwqDCoMKgIHFkZXZfY29ubmVjdF9jbG9ja19pbihERVZJQ0UoYm1jLT5zb2Mp
LCAic3lzY2xrIiwgc3lzY2xrKTsNCj4gPj4+PiAgwqDCoMKgwqDCoCBvYmplY3RfcHJvcGVydHlf
c2V0X2xpbmsoT0JKRUNUKGJtYy0+c29jKSwgIm1lbW9yeSIsIEBADQo+ID4+Pj4gLTE1OTksMTMg
KzE2MDQsMTEgQEAgc3RhdGljIHZvaWQNCj4gPj4+PiBhc3BlZWRfbWluaWJtY19tYWNoaW5lX2lu
aXQoTWFjaGluZVN0YXRlICptYWNoaW5lKQ0KPiA+Pj4+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhbWMtPm51bV9jcywNCj4g
Pj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgMCk7DQo+ID4+Pj4gLcKgwqDCoCBhc3BlZWRfYm9hcmRfaW5pdF9mbGFzaGVz
KCZibWMtPnNvYy0+c3BpWzBdLA0KPiA+Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJtYy0+c3BpX21vZGVsID8NCj4gPj4gYm1j
LT5zcGlfbW9kZWwgOg0KPiA+Pj4+IGFtYy0+c3BpX21vZGVsLA0KPiA+Pj4+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFtYy0+bnVt
X2NzLA0KPiA+PiBhbWMtPm51bV9jcyk7DQo+ID4+Pj4gLQ0KPiA+Pj4+IC3CoMKgwqAgYXNwZWVk
X2JvYXJkX2luaXRfZmxhc2hlcygmYm1jLT5zb2MtPnNwaVsxXSwNCj4gPj4+PiArwqDCoMKgIGZv
ciAoaSA9IDA7IGkgPCBzYy0+c3Bpc19udW07IGkrKykgew0KPiA+Pj4+ICvCoMKgwqDCoMKgwqDC
oCBhc3BlZWRfYm9hcmRfaW5pdF9mbGFzaGVzKCZibWMtPnNvYy0+c3BpW2ldLA0KPiA+Pj4+ICDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBibWMtPnNwaV9tb2RlbCA/DQo+ID4+IGJtYy0+c3BpX21vZGVsIDoNCj4gPj4+PiBhbWMt
PnNwaV9tb2RlbCwNCj4gPj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhbWMtPm51bV9jcywNCj4gPj4gKGFtYy0+bnVtX2NzICog
MikpOw0KPiA+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGFtYy0+bnVtX2NzLA0KPiA+PiBhbWMtPm51bV9jcyArDQo+ID4+Pj4g
KyhhbWMtPm51bV9jcyAqIGkpKTsNCj4gPj4+PiArwqDCoMKgIH0NCj4gPj4+PiAgwqDCoMKgwqDC
oCBpZiAoYW1jLT5pMmNfaW5pdCkgew0KPiA+Pj4+ICDCoMKgwqDCoMKgwqDCoMKgwqAgYW1jLT5p
MmNfaW5pdChibWMpOw0KPiA+Pj4NCj4gPg0KDQo=

