Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4790AC369DC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 01:25:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBkaG-0004wW-TX; Sun, 04 May 2025 21:25:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1uBkaE-0004w2-UR; Sun, 04 May 2025 21:25:26 -0400
Received: from mail-eastasiaazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c400::3] helo=HK3PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1uBkaC-0007tQ-B7; Sun, 04 May 2025 21:25:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wEmmbaPv9bBAlpZYjP0r47TNztJJURInXf2vW0n0iE7mJGhFfa7ZXYTvG6Zp8JLxAlLEKJz1Hc5HN1EMQC652YEP49wGjMIlu6TuI4qS+87LQ6hD53tLPUlR4quShEcUgP0miPblyJoHy9znnpcBuM5fCNcnyIO2PzefgESzn0v2AcLPuG1K05Uqhv+Gkwpmbaf3QFtkzYCHMQS7csi6l3BysLtTMHoCBMwk65ej/9m2Y1KM/Zebv8HYCvWP73LfoiJWdzirzAJDo09b5FjmhcXdaXx/vjtpRQIsl/U+1hk62E1DZnn0Rj+F9sql6XcEdns4lYwsk3Zudr+3kuY3mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=upLodImKp6I1pcPWfmlCwKRpUbJB16mF/BQJBWUqH40=;
 b=U70raOmxzA0/nEbHtXsKlq6aYBdfMq/akVS3ZpACmM90jYMUWuYTtjWBWnYR2B2Zsq22V/clBoSlM+cXPfTErF81axY4378Xdq+5u1uATernuCtOTuC3NQKxoZKCJ50rx5ngVquFKPCQe4hovRgDjmrM3wZczJYdcaw6CObUPssaW25umkaHtRqwei7MF/scbuTNnRrb9Okfi7ZdUWQJtIfEneJuMGGghHQSuFGdUSzwMeO2cyvveQluGVo9lYus/yZ3DpI/LUstI2vfdylYDzR8AE+BiLxvLCX8DQhXJP+DQwJaVDNH8/UpU5n8X0M6xURdjsXzhTnLSFGTFP6tyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=upLodImKp6I1pcPWfmlCwKRpUbJB16mF/BQJBWUqH40=;
 b=VNL25WCxCcX/OJ7Mw748YJxrGE4XKgBd6kgzvRTD6acvI6YI5pRLHo4/0zxS1G0e3kRD6M5SkSOetKmft04eENsxBno3rDLw90gdboAOxFm8yLoslBxQrFXO0lz1wgJyeGGFqZZPj1CwoZlEu7hgbPy5ON3Uxier0UIMJuDCQwU6JVp4rqMARIy7PdfueVD0oF5BdkJiwSlOc433jOEVc9Z7d1fWGaTIc+B7mEHIDb4JDh+b2Rh9LNnXKSF+YzW38QfruzKy0ILldRVPs3dEhIZ8UkdWb7ORfZp+WsSxraPHg2SdqVkM8oXo7eSdvV1sJUClax6r9rQARtxS+30/mA==
Received: from KL1PR0601MB4180.apcprd06.prod.outlook.com
 (2603:1096:820:29::12) by SEZPR06MB7138.apcprd06.prod.outlook.com
 (2603:1096:101:225::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Mon, 5 May
 2025 01:25:11 +0000
Received: from KL1PR0601MB4180.apcprd06.prod.outlook.com
 ([fe80::6fe5:1995:96a2:552a]) by KL1PR0601MB4180.apcprd06.prod.outlook.com
 ([fe80::6fe5:1995:96a2:552a%6]) with mapi id 15.20.8699.026; Mon, 5 May 2025
 01:25:10 +0000
From: Steven Lee <steven_lee@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "longzl2@lenovo.com"
 <longzl2@lenovo.com>, Yunlin Tang <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v4 0/9] Introduce AST27x0 multi-SoC machine
Thread-Topic: [PATCH v4 0/9] Introduce AST27x0 multi-SoC machine
Thread-Index: AQHbu03Y4Kb6W+7FsU+KCst2flQewrO/Or8AgAQEuVA=
Date: Mon, 5 May 2025 01:25:09 +0000
Message-ID: <KL1PR0601MB4180851C9FBBBA988E32940D858E2@KL1PR0601MB4180.apcprd06.prod.outlook.com>
References: <20250502103449.3091642-1-steven_lee@aspeedtech.com>
 <23ebea3e-7a71-4730-a838-b817d9844d15@kaod.org>
In-Reply-To: <23ebea3e-7a71-4730-a838-b817d9844d15@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB4180:EE_|SEZPR06MB7138:EE_
x-ms-office365-filtering-correlation-id: 3da3a39d-848a-402b-d9f4-08dd8b73ad26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RGVjMDF6UXppTmdDN0FwNUJrZW9oOTRUZU9lZ1BRT2tVQnBiaDdTbkJvYU9i?=
 =?utf-8?B?bXBEL0o5c1BPbVNCNFRCOGJmK3JMdnBmclh2QkY4Zkp3U1hINzk4bXg4TlBk?=
 =?utf-8?B?cms1bS9vMmphMWdHRWtFWUtZcnBoTDVNYmcrQURpVlY1NUppL0RNb29MZFNC?=
 =?utf-8?B?ZHVZWDJLenIyYTlsMzVBcENiOUhBbFVWSk1OdnA3M2JHQjBYUzl4ZHg3Q24v?=
 =?utf-8?B?ejdvdmdaOFNva0ZEWG1pemhkOVkwaXEya24wSXJXTG83SGx0bHEzQXVkdmha?=
 =?utf-8?B?eEJpcTJweUJWT0puTHovR3dlNlF5YmZXWXBuUmhYR1c3TUUwdWJUQytCckhD?=
 =?utf-8?B?aHU2NU54M1d4Qi9xS0VHQytFR2RHSk1MaVJISVV3SXN5ZThRQkswb01tZjBO?=
 =?utf-8?B?VVB3Smx5S1ZzbG4vRjBmenBMRXZvZkJZZEpYaWpveG15NjkwTWRONU1SWUZO?=
 =?utf-8?B?TTNpeU8zUUdkUUhwWURIUVNuMENmQ2lBSWlqZlM3c0h3N0NUWVkrNjJva0VS?=
 =?utf-8?B?VW45eFZXNzB1dDFvSmJ4aHdmeHZWSTgvUUhHNldyRlR4QmF6eGdiRDhFaXRP?=
 =?utf-8?B?K1Fwd3Boak9LK0tvZERmU2h6RXE1Z2pJNENZZnBVRlp3WUJ1L3ZEN0FzN1Ju?=
 =?utf-8?B?WkRpaGhLRnpBSG1PM3FnQzRSaUtXKzVOZ3Q3UmdrdjVXUEE4YVNwbU5tbkJQ?=
 =?utf-8?B?YWowYTBRQSt6WXg1amI4ZUV3QTNIc0FzM2VjK2FRV2YraG5WZFZPRy82T0Na?=
 =?utf-8?B?VGIxcXZMdi9Ma3c5YitQVkpaRGp6RHYwSTB1bHRycHh1czR1KzJWd001RjlO?=
 =?utf-8?B?LzhFZDU1blNDa3BzTnFNUUVMajFZNmc0UnFqRndoUXBKNlZHeUN3ZGtjYUJa?=
 =?utf-8?B?MXpYVUpBeTNKeE5KUStuVzZ3Q2lkOHlULzlwU3kwWTZqTS9Tci9YY0VqTFE0?=
 =?utf-8?B?NjlQUlBzQlpnbmxzUHF0ZDY1N3JmbGVhR3l3YjBlMm1kMHdjV2VidS81ekJ1?=
 =?utf-8?B?eW9KL0xBTCtoLzFVak4vb1Q4RXl5OHlHUlg2Ti9ZZHJGRCtwUWJWODFaQWM5?=
 =?utf-8?B?OURIZUpRdWpoZndKcnphenkzQ1E2OHMzbE1WMWRYT3Z2MUk2OG9vSnlIc082?=
 =?utf-8?B?dVAwT0t1aXhNZmttV0FuSWphSEs4aGFoeG91YnZXY1haK0VEZ0E5OUlvalQr?=
 =?utf-8?B?dmY5R051MFh3UWRKaGxxNkJhdDU1WExRNExGclMyUTBXbGx0dkMwTXp4TXRz?=
 =?utf-8?B?ak9YZ0tXeFEvVlVXWkFLakpEMG4ySW9TQm9MTFJuZ25MM3JwZnhNSTFwMmZO?=
 =?utf-8?B?bndPTFdkR3o2cGMvZVN3aUp5ZHdnV3lVN25WK05CcFNxN2JnL2hHd2xJdzNh?=
 =?utf-8?B?ZTNZWDRLa1ROWmdXaldlZUxEVDR5YXhGQUJQcGZ2cHBXSmcrTlY3WFNlcVNL?=
 =?utf-8?B?Uk5FVG5Ud1BRbGEzMjBYRW1ZdUxEYUthWlFSajZqbGtKbkdiWlFSdVRBejRY?=
 =?utf-8?B?WHJnWndoZU54U3FFRVBFOWpsaExERWN2OG9VbGJUalNqK053ZHlVMlorQlhQ?=
 =?utf-8?B?SllxS2R6cVFvR2YzdldPZU1wSXdyWXlUSitaVS92R2kvR2QrRmhIdGZHOXdY?=
 =?utf-8?B?aFdZK1FWdWVabjkvNk4wT2RKSUJCcC9iSEI0cmxoTjg2bWxsbmtpT1JSRkxM?=
 =?utf-8?B?TDBYdk9tdGYybk83V0VvOG5QVFhvWnd2Zmw1WnNDVDJoQWkwb3hiMGRlTlpk?=
 =?utf-8?B?ck9ZYlB3OVJLVUdzUUwvL3I0cGQvZTlhRllLc2xXTkhzc256N1h4Q0MzMFV6?=
 =?utf-8?B?SVBWdm1WeUJoSFEwMndTWDlhK2JMMVczdUN1SmdrRDB3dDNkT24vTlZaMHgr?=
 =?utf-8?B?R055L1JGVy9DVUFKb05IajBZalBEblRQQlpSWVViN3hhRWFaY2I2WkRSZER4?=
 =?utf-8?B?Q2NmRXNDaHFZUGozSHVWaTFhdmFZNklPVTdDSHl5Q0dWWVM1djJwcWdJTER6?=
 =?utf-8?B?SXB4Ykppb25RPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:KL1PR0601MB4180.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVQvQTYybkxoNSt4U01qaGdoOVF2aDRPc3o2UzBObkE1eGt2dFc4MURvNFgz?=
 =?utf-8?B?SnBzK3E2c0N0eEcyZng0Nk1IWXVNVW93R2ZiTEY5TzR0ckIzWmM4VDBERnlG?=
 =?utf-8?B?NUxtMTZ2N2RoVnpYZmRmQWlQczZZQzRwQjVjYy9IVkpxS2dJYkJaemJRcGZt?=
 =?utf-8?B?b1hxNlFnV0R1emNiRnFqQzg4WWhuZkpHdzEyUm52Wk5IcWwrRmx2VVNBNFht?=
 =?utf-8?B?bUZmdE5HeDZHUEhUZlBQbFpqV040Q25rbTh1clBmTG45V3hxUDc5eURqV0dv?=
 =?utf-8?B?UkdiVXhKU2hZeEtza1l6bmJnYm80ZVdVQVYwWkRTenllaEdFd0FCVHBGUmJ4?=
 =?utf-8?B?VXVUQ3hoMFV4VUFFWTZYNGVqZ2x0aU9qN3ZKcStYYnY0VWEweDVtZGcrSGxh?=
 =?utf-8?B?YmJuOFY3UGhzOFgvNG0wMUN0SE4zV29LSzNkdllvVUozUEZObEZDeGMrQjhH?=
 =?utf-8?B?Tmg1Z0tzTFR6c3dCU3BjYU5XNTNVM3JRclhKNWdsRTZJTU5WZWJqVVM2UE91?=
 =?utf-8?B?VGxHMTdhc2lGYkUwVVpaNUJCS21XdGc3RURvdllnSHFVR2hLdEVRNnkxMkJ4?=
 =?utf-8?B?eXRyYTg5K0JQZDBlNFdwdWF4QmJDdFc4cXlRWHVycTZ5dFFCRTY4MFljOFo3?=
 =?utf-8?B?T2ZaMzlEWGtUMDd4dVVWV1pzdjN0U2N5YTZmbTBOMjlYMWtqQklreTg0Z1hD?=
 =?utf-8?B?U24ydlZGVkhNV0pCL1BrRlkwMEdiY3oyalVuM2hZSDRLRGxVRzlFT1pWZHFa?=
 =?utf-8?B?WXRHN2xGdzlVK0t3T253TWJoV2kvS1krSHlBL3grQVoxWnVycXk4N25DRDk0?=
 =?utf-8?B?cWpYWU03bEhnZzhwS0tvbWt2TmRQR3ZVMTdzYW42enJSOGVabHY0Qkp2aTBq?=
 =?utf-8?B?ZzlSUFVDWXdFelNWcXBDRHpuNjlOL0FuYTE0dWpwTWdnQThmNzY5SmlqMHFn?=
 =?utf-8?B?SktZRGF0dEcrT2F1WlF6aytYTUtkN2wreXY1OG9TMDNGRE0xdGs3NjBxeSs2?=
 =?utf-8?B?WHlnRmhCN1dZVUlWZDZGNWI5akVlVm5RRmVWM3hlL1B2WXFSK0dQYzlvMm1a?=
 =?utf-8?B?RGJ1K0xUNXVsQmJEaEhZK04yOXAvU1RYZnNEbFhyYWJhVWh0cDJXVGtXZC9R?=
 =?utf-8?B?RkR5VEl6dUh6dEFtUDBvbGpDeHpzSE56WXN5eUY3QkNhYmJwZkwxZW9aMWRM?=
 =?utf-8?B?Y2hHV0NCOXVmdGp3ZmlNdW16MGkwQU5WT3MzaTgxTGdXVituZWpIY1ZDUmlT?=
 =?utf-8?B?VkRuOXd2TXBKOEVLZ3plYmZGcUY4NHRBWm5QSitNOUVLK1hjM2YvUGJ2WmZH?=
 =?utf-8?B?bm83L0ZHak1MeU5zc0ZnTFg0OGhpWE5CdzdoYXp1cFQ4UVBMd3ZFQ1REeDdr?=
 =?utf-8?B?eDF5Z3Vid3MrUUVQQnBmNjNjb2FwcmVydGI5aEJhZ2ZFWFIxS29pQ0Z3dnds?=
 =?utf-8?B?Z3AxaUhlMnNzelh3a3RUUVZWWnQxVVIyNjhvRllCcXVWZkI2NlNhRmxhTTRE?=
 =?utf-8?B?d1hTaDV4WVQwWkZDdC8zVUJMa1BpVlV3K3FxcjVVQkdNZFA2bDRiYVJuTE5W?=
 =?utf-8?B?Z2ZlekFETXZ0aUF4SGVhNSs4UU5KbDZCak9DcGNLLzYwOHRtK1luamVqOXdx?=
 =?utf-8?B?czF6MFkzUVVzU3NrREljbDRObGdKQnVRM3VwZGpxbklFTGg5ZENIMmtiR2hl?=
 =?utf-8?B?TUpXN0tBemNkc2Q0bXBaWTF6bmpLbU9TL0I1MEhtK3dKbTdlMTdEeEdaVFRB?=
 =?utf-8?B?K1J4R3hISlZ0bjZmYU9jMHRCbVNPWFFoVytkWUQ4NEx1V0RxamlZclhFNURr?=
 =?utf-8?B?TE0reGFSK0owc21jaU4rYzJpVGVxSjdGekRvNmRYcUNEamsyYlFuTE1WOHdq?=
 =?utf-8?B?ZThVN2JRUERMRTFqYmZQd0NYb3lxTXAxbTdYcUZaTXUrakhlVW1wMkZibTVO?=
 =?utf-8?B?TWU0OGp3bU04enhoZklVVlhwTWhYQ1dIbnFXcTdockFrQVBFR3JCN3Y4MUR3?=
 =?utf-8?B?RHNRaHdBclA5VklPWjBWNDhhdzV1NkE4UjVtMm9jYWJUZmNqaytmdEVFc3dh?=
 =?utf-8?B?MmcrVUxZck5wM3pqUlNTbHp6TXRqSTRZYkJVajhybzI1UXN6YktBWkd6OEhC?=
 =?utf-8?Q?XNVQdQryeJsg038kz09+384Lg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4180.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3da3a39d-848a-402b-d9f4-08dd8b73ad26
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2025 01:25:09.8787 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hav8a89To7cLSlFD1emGNAMcz/T9mM9XULNAcdQeuHIZhunAZLy5lr/eiiMVrTnDRBiMBIZiJiCUskWcfPDtfD3smswO1mlkFylD1kQHb78=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7138
Received-SPF: pass client-ip=2a01:111:f403:c400::3;
 envelope-from=steven_lee@aspeedtech.com;
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

SGkgQ8OpZHJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lk
cmljIExlIEdvYXRlciA8Y2xnQGthb2Qub3JnPg0KPiBTZW50OiBGcmlkYXksIE1heSAyLCAyMDI1
IDc6NTIgUE0NCj4gVG86IFN0ZXZlbiBMZWUgPHN0ZXZlbl9sZWVAYXNwZWVkdGVjaC5jb20+OyBQ
ZXRlciBNYXlkZWxsDQo+IDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+OyBUcm95IExlZSA8bGVl
dHJveUBnbWFpbC5jb20+OyBKYW1pbiBMaW4NCj4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT47
IEFuZHJldyBKZWZmZXJ5DQo+IDxhbmRyZXdAY29kZWNvbnN0cnVjdC5jb20uYXU+OyBKb2VsIFN0
YW5sZXkgPGpvZWxAam1zLmlkLmF1Pjsgb3Blbg0KPiBsaXN0OkFTUEVFRCBCTUNzIDxxZW11LWFy
bUBub25nbnUub3JnPjsgb3BlbiBsaXN0OkFsbCBwYXRjaGVzIENDIGhlcmUNCj4gPHFlbXUtZGV2
ZWxAbm9uZ251Lm9yZz4NCj4gQ2M6IFRyb3kgTGVlIDx0cm95X2xlZUBhc3BlZWR0ZWNoLmNvbT47
IGxvbmd6bDJAbGVub3ZvLmNvbTsgWXVubGluIFRhbmcNCj4gPHl1bmxpbi50YW5nQGFzcGVlZHRl
Y2guY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDAvOV0gSW50cm9kdWNlIEFTVDI3eDAg
bXVsdGktU29DIG1hY2hpbmUNCj4gDQo+IE9uIDUvMi8yNSAxMjozNCwgU3RldmVuIExlZSB3cm90
ZToNCj4gPiBUaGlzIHBhdGNoIHNlcmllcyBpbnRyb2R1Y2VzIGZ1bGwgY29yZSBzdXBwb3J0IGZv
ciB0aGUgQVNUMjd4MCBTb0MsIGFsb25nIHdpdGgNCj4gbmVjZXNzYXJ5IHVwZGF0ZXMgdG8gdGhl
IEFTUEVFRCBBU1QyN3gwIFNPQy4NCj4gPiBUaGUgQVNUMjd4MCBTb0MgaXMgYSBuZXcgZmFtaWx5
IG9mIEFTUEVFRCBTb0NzIGZlYXR1cmluZyA0IENvcnRleC1BMzUNCj4gY29yZXMgYW5kIDIgQ29y
dGV4LU00IGNvcmVzLg0KPiA+DQo+ID4gdjE6DQo+ID4gICAgLSBNYXAgdW5pbXBsZW1lbnRlZCBk
ZXZpY2VzIGluIFNvQyBtZW1vcnkNCj4gPiAgICAtIEludHJ1ZHVjZSBBU1QyNzAwIENNNCBTb0MN
Cj4gPiAgICAtIEludHJvZHVjZSBBU1QyN3gwRkMgTWFjaGluZQ0KPiA+DQo+ID4gdjI6DQo+ID4g
ICAgLSBSZW1vdmUgdW51c2VkIGZ1bmN0aW9ucw0KPiA+ICAgIC0gQ29ycmVjdCBoZXggbm90YXRp
b24gZm9yIGRldmljZSBhZGRyZXNzZXMgaW4gQVNUMjd4MCBTb0MNCj4gPiAgICAtIEFkZCBBU1Qy
NzAwIFNTUCBJTlRDIGFuZCBBU1QyNzAwIFRTUCBJTlRDDQo+ID4gICAgLSBTcGxpdCBBU1QyN3gw
IENNNCBTb0MgdG8gQVNUMjd4MCBTU1AgU29DIGFuZCBBU1QyN3gwIFRTUCBTb0MNCj4gPiAgICAt
IEFkZCBBU1QyN3gwIEEwIFNTUCBTb0MgYW5kIEFTVDI3eDAgQTEgU1NQIFNvQw0KPiA+ICAgIC0g
QWRkIEFTVDI3eDAgQTAgVFNQIFNvQyBhbmQgQVNUMjd4MCBBMSBUU1AgU29DDQo+ID4gICAgLSBB
ZGQgZnVuY3Rpb25hbCB0ZXN0cyBmb3IgQVNUMjcwMEZDIEEwIGFuZCBBU1QyNzAwRkMgQTENCj4g
PiAgICAtIEFkZCBEb2N1bWVudGF0aW9uIGZvciBBU1QyNzAwRkMNCj4gPg0KPiA+IHYzOg0KPiA+
ICAgIC0gUmVtb3ZlIEEwIFNvQyBzdXBwb3J0DQo+ID4NCj4gPiB2NDoNCj4gPiAgICAtIFJlYmFz
ZSBvbiB1cHN0cmVhbSBRRU1VLg0KPiA+ICAgIC0gUmVtb3ZlIHRoZSByZWR1bmRhbnQgYWJzdHJh
Y3QgY2xhc3MuDQo+ID4gICAgLSBTaW1wbGlmeSB0aGUgZnVuY3Rpb25hbCB0ZXN0IGZvciBBU1Qy
NzAwRkMuDQo+IA0KPiBJIGRpZG4ndCBzZWUgYW55IGNoYW5nZS4NCj4gDQo+IEFsc28sIHRoZSB0
ZXN0IHRha2VzIHF1aXRlIHNvbWUgdGltZSBvbiBteSBkZXYgc2VydmVyLCBtb3JlIHRoYW4gMjAw
cy4NCj4gV291bGQgeW91IHBsZWFzZSBpbnRyb2R1Y2UgYSBuZXcgdGVzdCBmaWxlIGZvciB0aGUg
YXN0MjcwMGZjIG1hY2hpbmUgOg0KPiANCj4gICAgdGVzdHMvZnVuY3Rpb25hbC90ZXN0X2FhcmNo
NjRfYXNwZWVkX2FzdDI3MDBmYy5weQ0KPiANCj4gYW5kIHJlbmFtZSA6DQo+IA0KPiAgICB0ZXN0
cy9mdW5jdGlvbmFsL3Rlc3RfYWFyY2g2NF9hc3BlZWQucHkNCj4gDQo+IHRvIDoNCj4gDQo+ICAg
IHRlc3RzL2Z1bmN0aW9uYWwvdGVzdF9hYXJjaDY0X2FzcGVlZF9hc3QyNzAwLnB5DQo+IA0KPiBU
aGlzIHNob3VsZCBoZWxwIHBhcmFsbGVsaXplIHRoZSBydW4uDQo+IA0KPiBKdXN0IHJlc2VuZCBw
YXRjaCA4Lg0KPiANCj4gDQoNCkdvdCBpdCEgSSdsbCByZXNlbmQgcGF0Y2ggOCBzZXBhcmF0ZWx5
IHRvIHNwbGl0IHVwIHRoZSBmdW5jdGlvbmFsIHRlc3QgYW5kIHJlbmFtZSB0aGUgb3JpZ2luYWwg
b25lIGFzIHlvdSBzdWdnZXN0ZWQsIGdpdmVuIGl0J3MgY3VycmVudGx5IHRha2luZyBhYm91dCA1
IG1pbnV0ZXMgdG8gZmluaXNoIHRoZXNlIDQgdGVzdCBjYXNlcy4NCg0KUmVnYXJkcywNClN0ZXZl
bg0KDQo+ID4gICAgLSBGaXggdGhlIGRvY21lbnQgZm9ybWF0dGluZyBpc3N1ZS4NCj4gPg0KPiA+
IFN0ZXZlbiBMZWUgKDkpOg0KPiA+ICAgIGFzcGVlZDogYXN0Mjd4MDogTWFwIHVuaW1wbGVtZW50
ZWQgZGV2aWNlcyBpbiBTb0MgbWVtb3J5DQo+ID4gICAgYXNwZWVkOiBhc3QyN3gwOiBDb3JyZWN0
IGhleCBub3RhdGlvbiBmb3IgZGV2aWNlIGFkZHJlc3Nlcw0KPiA+ICAgIGh3L2ludGMvYXNwZWVk
OiBBZGQgc3VwcG9ydCBmb3IgQVNUMjcwMCBTU1AgSU5UQw0KPiA+ICAgIGh3L2ludGMvYXNwZWVk
OiBBZGQgc3VwcG9ydCBmb3IgQVNUMjcwMCBUU1AgSU5UQw0KPiA+ICAgIGh3L2FybS9hc3BlZWRf
YXN0Mjd4MC1zc3A6IEludHJvZHVjZSBBU1QyN3gwIEExIFNTUCBTb0MNCj4gPiAgICBody9hcm0v
YXNwZWVkX2FzdDI3eDAtdHNwOiBJbnRyb2R1Y2UgQVNUMjd4MCBBMSBUU1AgU29DDQo+ID4gICAg
aHcvYXJtOiBJbnRyb2R1Y2UgQVNQRUVEIEFTVDI3MDAgQTEgZnVsbCBjb3JlIG1hY2hpbmUNCj4g
PiAgICB0ZXN0cy9mdW5jdGlvbi9hc3BlZWQ6IEFkZCBmdW5jdGlvbmFsIHRlc3QgZm9yIEFTVDI3
MDBGQw0KPiA+ICAgIGRvY3M6IEFkZCBzdXBwb3J0IGZvciBhc3QyNzAwZmMgbWFjaGluZQ0KPiA+
DQo+ID4gICBkb2NzL3N5c3RlbS9hcm0vYXNwZWVkLnJzdCAgICAgICAgICAgICAgfCAgNjkgKysr
LQ0KPiA+ICAgaW5jbHVkZS9ody9hcm0vYXNwZWVkX3NvYy5oICAgICAgICAgICAgIHwgIDMyICsr
DQo+ID4gICBpbmNsdWRlL2h3L2ludGMvYXNwZWVkX2ludGMuaCAgICAgICAgICAgfCAgIDUgKw0K
PiA+ICAgaHcvYXJtL2FzcGVlZF9hc3QyN3gwLWZjLmMgICAgICAgICAgICAgIHwgMTkyICsrKysr
KysrKysrDQo+ID4gICBody9hcm0vYXNwZWVkX2FzdDI3eDAtc3NwLmMgICAgICAgICAgICAgfCAy
OTUgKysrKysrKysrKysrKysrKysNCj4gPiAgIGh3L2FybS9hc3BlZWRfYXN0Mjd4MC10c3AuYyAg
ICAgICAgICAgICB8IDI5NSArKysrKysrKysrKysrKysrKw0KPiA+ICAgaHcvYXJtL2FzcGVlZF9h
c3QyN3gwLmMgICAgICAgICAgICAgICAgIHwgIDgwICsrKy0tDQo+ID4gICBody9pbnRjL2FzcGVl
ZF9pbnRjLmMgICAgICAgICAgICAgICAgICAgfCA0MTYNCj4gKysrKysrKysrKysrKysrKysrKysr
KysrDQo+ID4gICBody9hcm0vbWVzb24uYnVpbGQgICAgICAgICAgICAgICAgICAgICAgfCAgIDYg
Ky0NCj4gPiAgIHRlc3RzL2Z1bmN0aW9uYWwvdGVzdF9hYXJjaDY0X2FzcGVlZC5weSB8ICA4MyAr
KysrKw0KPiA+ICAgMTAgZmlsZXMgY2hhbmdlZCwgMTQ0OCBpbnNlcnRpb25zKCspLCAyNSBkZWxl
dGlvbnMoLSkNCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBody9hcm0vYXNwZWVkX2FzdDI3eDAt
ZmMuYw0KPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGh3L2FybS9hc3BlZWRfYXN0Mjd4MC1zc3Au
Yw0KPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGh3L2FybS9hc3BlZWRfYXN0Mjd4MC10c3AuYw0K
PiA+DQo+IEFwcGxpZWQgdG8gYXNwZWVkLW5leHQuDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBDLg0K
DQo=

