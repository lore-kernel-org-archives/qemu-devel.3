Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE569C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 05:07:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugz2G-0000Fg-PE; Wed, 30 Jul 2025 01:07:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ugz2E-0008TR-UZ
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 01:07:26 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ugz2C-0007ZG-T9
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 01:07:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aIDczbnyPbrpVMtti0RiQQDQal1sE1eU0PX2/4O1HWwiFa5UeiVk5nz9QbW4OTSoKPl9XGMwJyfj18VMPdwQI42IW8lOrO5XOGjD3N6zo+mEzQ/iyiAtMBPKiAGc6iCcxeyvncU+qAAnJ58Dnam6Vtiow4Uetw1TVhyXIqpHS3PFz9C3vruwKOBtPg+smo2mir+lYSFlhoreJmBYiGP9CDIQ62K9ZUCbuuWLlCfiUdO0ZvEX/WG2jpb2Qha7KvqH2hHTJX0m8JLPcWFOtcZvuiYDcMxyBj1ZhHxUERMMHg0k7EbAUYTo0Lp3c3bpyeMKDZVMpns7DmoC3djrYayxCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oNDJ9+mDOcXHcg8rl1hCu5fZeJYKt8ALjjjmb8fufS4=;
 b=EJ33c2OoN8XO8s35IDuvv281SjWc5UuW4ZcyTEapCCYQthbGgmC/FQdj2TGULC1bc7L1lp0y2GB+Bl3/RAnmIfcqOO8/fNFP8L5SCoJWCDMkpS3a8DRt4H+xz5wbIKpKSW3YvqQ3eIFWHe2oIunl870+KH0r0NRx04jrzCa3EvhQJTIm7u1ad2OXq6Thmg59DoxFigeqGZuffjUr/RgVVe7NXAc5onMTidWX/+TZSk6AVWHNvD6Uf5RUHqK9+8DWCQMsQt7dtWCSJ91ohZKM8LCT+AZO4V6EXMQ5/PzgrwJV53b1rWod+kapaZJRqt/GFc3h6+FqlIIxTuDpeLitNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNDJ9+mDOcXHcg8rl1hCu5fZeJYKt8ALjjjmb8fufS4=;
 b=X3dm7lhdV18vRIVpHp2cD7k+HZXVZx5kCgeODo47t5LDodZmc7QRyBoUzr+6nTyi5oyXfDhzYTgN1rwl56qsbk02reKGetkeql48IFdg/EOe1aRUxNSKypd53J7JjIPoiuQcmXkWk4/Mt5WRehHYfXj76kXNYC3ne7SglBHC2i0nvdF7maYYk8pOWy81f7ZTiNTrYB+4g4zfX0Fd/Chg2rVzwARLep7TQLormlA8pMMkOPgC8RkRt9FaleiYh1UMsJqy+Gqpg6F9kDZEVULAFyupYualHFS0pE2TSdUAROwVpIAK0Qr2eG1paAm0sjU0DeKrqpTH57YBxUSrlYeeIg==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SEZPR06MB6087.apcprd06.prod.outlook.com (2603:1096:101:e7::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.11; Wed, 30 Jul 2025 05:07:19 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%7]) with mapi id 15.20.8964.025; Wed, 30 Jul 2025
 05:07:19 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Michael
 Tokarev <mjt@tls.msk.ru>, Peter Maydell <peter.maydell@linaro.org>, Hao Wu
 <wuhaotsh@google.com>
Subject: RE: [PATCH v3 2/3] roms/Makefile: build ast27x0_bootrom
Thread-Topic: [PATCH v3 2/3] roms/Makefile: build ast27x0_bootrom
Thread-Index: AQHcAQ6c/fFK1EalvkqqxBeDiQZBvbRKHXOw
Date: Wed, 30 Jul 2025 05:07:18 +0000
Message-ID: <SI2PR06MB5041631D8DE901D72AEFB926FC24A@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250730045813.822132-1-clg@redhat.com>
 <20250730045813.822132-3-clg@redhat.com>
In-Reply-To: <20250730045813.822132-3-clg@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SEZPR06MB6087:EE_
x-ms-office365-filtering-correlation-id: e8c065c4-3fae-4a03-bfd5-08ddcf26f579
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RXN3dHJ4Q0pPMGU5UGhQbWZwc2hrTm45U2owUThHMWhPQm13cGwyZDZkemVt?=
 =?utf-8?B?OTdVWDZrUi80T08zN2JtZHB4Q3FjbFplSm53dkhxdGVYNnV1VUlnWG1ra1ky?=
 =?utf-8?B?UWtnaHBZNmRTQ1RDWVVFZ3Z1ZFBSNWdIenBESG9YTnRTQXRyaUliSWVhYm1H?=
 =?utf-8?B?bURtMDllK0hUR1dQdmZxWUViU1prbE1LUTFrbTkxRzFKcE1VVlNjVFVxZ20x?=
 =?utf-8?B?SlFEZndheWEvUEQ1aDZUVlVjY2ErSFRuWlZwOTJTY3cvVlMxdFg5SWd4bTRk?=
 =?utf-8?B?OEE5WVZ2YnpaTmNJRTJRTHhKZnNCTHprWDN5enNZQ1JBOGVxRG5DZ1VVNklO?=
 =?utf-8?B?cWphSWFDVERpbGkyNjVoTUpGbElsVEdaWmIzb0pURTFSeVd4ZHc4eHJDOXEz?=
 =?utf-8?B?Q2tZSG8vUmhRY1ozdm1oN3FoWGg0MUpNaitqOS91ditJUWREb29kckJJSTZC?=
 =?utf-8?B?SHlhUWVRSk8xZ3drb1lHMnBoQS9FVDhSRmRZbFpIS0tCYk9tWmhEM3NJSE8v?=
 =?utf-8?B?VkZrZjJMZGUwOGtSZjhuTko3bE1YSHlkTmx2bkFYb01xY1NBMjRPb013dWda?=
 =?utf-8?B?cFhLcS9Ea0RGS2svTXZHS1Bnd1hlNFVKU1pFT3c0VkdFQ0hRTDFRb0ZGdzJz?=
 =?utf-8?B?YnRKaXcxTXdzTnpOYlVnL1pGVXFvVWEwaFRGOEhBQ0FaRk9wOGlaOFdWNTJI?=
 =?utf-8?B?eGl0N2s1QS9QOXlLMkx5UW9DSnlTVWh1ZERSTi9HN3AzdkxOcUYwcy9oVldG?=
 =?utf-8?B?TGNPQ25kNlNvV3lsMWZXanB6Z1loY0pGMUN2YkZhMlFMeUdWR3p0ODNyZmdV?=
 =?utf-8?B?dFQwMzkyQUZFUEVHNVFOaW1MZ2QyK2lDemo2Z29YZDBKTVdvR2llb05sdnVZ?=
 =?utf-8?B?TGlyaHJ1NUxKRFNFYWtCZGx0VDc3dWtWK1hJU2Y2eWtuMXMwVFdBSUtQU2cr?=
 =?utf-8?B?TmZMTDBXemQ1eUVVU3o5RExmemsxR2g1U1pSRzlhVFpRK2pDNitIQnc5aTZz?=
 =?utf-8?B?U2xuOElGUytweWRoWmhkeVFPcEJyemRCeGdWL05SVDhFdGc4cGdTc0hRbnBw?=
 =?utf-8?B?RXoxL3c4SDhnQTZxYjkvNU9FNkFEZzVyVnZETGl3VDR3WDFiSG5BeEFFYVZt?=
 =?utf-8?B?NldQSEFGOSsvb1pzTzR2N0ZqeUtOSDhlZTZHbmQ3eXdwUktzaHFzSG5lNjNv?=
 =?utf-8?B?eVgvSEJsY1duRWhZNXZSaHVTcHk0MmdUaVJEN0lCbzRjTVZlaFcwTzdCUmdU?=
 =?utf-8?B?UUdMOVNzVW9IRmlueDhXaXFheVJxZXJlTkEwVFFpT1ZJdU5ZTXFvSnFNMlJq?=
 =?utf-8?B?SjZxWnZaeTAyQ3hCLzgzVkNsSk02dkY3clRPck9lZTE5WWRtczFQdjdScHVQ?=
 =?utf-8?B?MUxnRWdPbUpMOS8rejZuVTZRaFRCa2IxVWtpejJlbGlQTlJmcFdBcGRweVVF?=
 =?utf-8?B?c1dBdzhadTFCTm9FcUpJdVB0QlJHS3A4VGNJSzdwT3BjLzNIOGQwYVlEVlB6?=
 =?utf-8?B?ZFA3b2NRSWxUK3NCbGNlNjNhSTZlc0ExY2FPSThrMFNidTNtNVIzTGx6Z0lF?=
 =?utf-8?B?VFRDcDYxaFhOemlrdmdSY1A3UTJSOUFHRnJqdzVJR2w4WDBGaXlTWldaRUJE?=
 =?utf-8?B?RUw5S0xRam9TVnJSdWp0QmlxcUM1eDh4TjQ5V1V1bFhyNXVmdDRORlBuSERX?=
 =?utf-8?B?aXZseXRtdlhYU2V6NzNVRWZIcUhWQ1pEWjVrM0hMaVdFNkdTSVpHZW1mWEQw?=
 =?utf-8?B?TlhmZ2dScWNIN3lRcTVqeUtueW04Tm1ZdElTckdkSk9jakRSN2g3cmNTeEFE?=
 =?utf-8?B?Q3NSOUM3QXBPc3R3RForRVRnWXhaVnBXUGIvQ3ZRSCtqeC9uMC9rNWR0bmg0?=
 =?utf-8?B?WDVsSmdmKzBTUjRqOVRZeGc4Qm1LZzZWclBia0srMHl2OCtMdjJ1UVFIM2U4?=
 =?utf-8?B?aS9nOGhQRk9XaVlUK2p5d2l6T3BPRG1GRW1uYXlZWFZqcWtYZkZ2SFZZVXZ1?=
 =?utf-8?B?MFZVc09Jb3hnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGZuakYwd3ZrWFJLK1ZEQlpvYU9lU1ZZOW5CREE2Qm5wb0F1TGtkaHlSVjBK?=
 =?utf-8?B?cko4QUIweTlpa1gySUxRcFc2b2JpM05EUG11OG52Ulp5VlZsbGN6MXV0ZS9k?=
 =?utf-8?B?N1N6R3dweG43ZDhkb3RrRjhoaXJZN0l0ZWExcFRjbW9SKzVHOWxsVFRuQkNr?=
 =?utf-8?B?cStNa0pmUmloNFkyb1E1RlROTjNDVk9rRlJPSUF4MnJUYlpJRFVFOS9Da0J6?=
 =?utf-8?B?bW9XYlN6WU5tblVjMHhYUHkxVDB0cEtURVBSUVBqWjNVNFRJdGV3VnRheEp2?=
 =?utf-8?B?WG9PbHZZa1hrYTh5Zmg1MVR5QTJYcDY5am9sY3dMUGVzS3Y0NkV1YVJ4cVFS?=
 =?utf-8?B?N2wrcmhkb3ZiZWdxeCtIdFZRbGZRYlhYRlhmY1BVVEVkWGpzWlpzVHE3cHF2?=
 =?utf-8?B?NnhvbnU4N3hMbi9JSVR1S2FDaitaOEZsaDhpQ2RvZzlQeXJhb09NRTRjRjF3?=
 =?utf-8?B?QnptMC9BbjdlSkF0MUVNazNzcytRRUpwL25VMERONEhCbjBVMW1tZVZ0dVRV?=
 =?utf-8?B?Ym9CcHpCSU96SzQ3UDV5SnNsSG9sR3V5Qm9FODhFWFVFZ2MyVUhmZlN5bG5k?=
 =?utf-8?B?TkEwZWZISjJDRXZ2YjVxeEFaR1NQRHc3Z1lleUFkVUhaSWQrbEMzSnZ4bTAy?=
 =?utf-8?B?RjlhemovMVBIRWNGT00rc3J6MStQL0RZYmlTM1V4bXplc3ZuM1dtRVhKVGNZ?=
 =?utf-8?B?VmppeENmaFhkR2wyT1ZnK2trclBTMlcvaEYxell1ckJ1cnVLR2dBaWpJQ2VB?=
 =?utf-8?B?dG5lWStLS0lsWGJTWm45YUlnK0E5SXVvRDEveVRmVlVPRHRsa21YT3VlWnkz?=
 =?utf-8?B?M1A2UHo0Vkt2WHUyZUpiNFhpWHdaQUlERDlTRVp3bmZFT21aaEE0b29HMGlk?=
 =?utf-8?B?RnhxclpjREkrQjdKbk5TNGlLY01zaWVnWnk2T3hlRjdqQ0g3UDdvT0FzOTBj?=
 =?utf-8?B?a3NFWGpTcWtNUkg2a1NjWk4wbm0ybEw3QjNYdEtIUEhiSHBtNDczbFFSMkVu?=
 =?utf-8?B?TEJBVjExekczUlM4aDJxaldVOVVUQ09SQUdnOU5kV0ZnS2RQdy9vZVFxTnI2?=
 =?utf-8?B?UlFWZ09BMGQwWk5iR3VXVXNCTG4rQkNkMFVib1VReG91Yy9LSlg4TnpTZlRw?=
 =?utf-8?B?SDExcytmTTU4Vm1NODliS2hBRHNXUS81ODBHaDJSNmhhVVk0Z1BVelZnSEdv?=
 =?utf-8?B?L1gzeW54Rnl2UkwwNkR1ODR6NnFZU1RaWUhLRnhYUUhNRDJJRTdoVlBkODRD?=
 =?utf-8?B?ZExqSkdESHZzQkNrTnFrVk5mM25GTnBLb0Y3TUd3WWl1VW5SV1pGTUtRZGtk?=
 =?utf-8?B?K0FaL0x0L05nRkdYbTBNTHZPOUpORy9ZSlhZVXhxcVVzclpGQTJxakFhajZo?=
 =?utf-8?B?bkV0alZ6NTdlZmt1eld3YnhNa0FaZjVnZTk4YUd1RUwzT040cE5BQ3NXTlJR?=
 =?utf-8?B?SVJsYnZyTHpWVU1YOWNLUkhaajg0eWFIaEJwNlJTVEllVGpHN1IzakFIRVM0?=
 =?utf-8?B?d3ZvTU1TOGtkdlFTQkJDNVhKMDIxTFY5TzZIejRiZjhOYmdIWjQvOERONEZr?=
 =?utf-8?B?eEluTTNFeVBwSkRINFZzM0t4Q1VIZ2NaNmV0TEtuQTZOUXVpNHZFUHdiYkgz?=
 =?utf-8?B?U3VuRXl1QmtsV1dMRHE1bEhMZHhJTVcyaHFxWXlPaHN2WE54ekZkWWh5U0dQ?=
 =?utf-8?B?NCtDcW9lU0dweXpiN0JIL2xTT1IwYUppdXgrcW1EYkhxcmd5LzBoTG9XRmtu?=
 =?utf-8?B?NldTTGFCRVJUelJ0Q1dsc1lWYzBvMTM3blRFYWdMakhGeEw1UlU1b2xYdjFo?=
 =?utf-8?B?akxnbGh5R2daNGZTTEFtTW9sUGRKU1kyMmFjdzZOb2FsTU5uQzR4eTMzdnNp?=
 =?utf-8?B?MjJKekR5YUtDbHFpR2ZOdXRCbFZzQnRKMHJFSzZDQ25ROGZ3YUxLdVluZHVF?=
 =?utf-8?B?aDAwcS8yK1RDMmZGNnltVWYyeC9TNHlEdmdGMUlZUE5vbyt3Sjhwb3RYYi9h?=
 =?utf-8?B?UEV6WGpGQ0hQUC9Rckg0SW1jZXYzOUs3UFBFRE8yZ25QZzFiZGVsSUlqOXZP?=
 =?utf-8?B?NzFtbTRQM0lXUVVzWjhxU3c0cGRXelMvTmttSStLKzB3K1pnendKZVFQR3Fx?=
 =?utf-8?Q?7i9Y6NXEgX620uzJKl3whmuHY?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8c065c4-3fae-4a03-bfd5-08ddcf26f579
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2025 05:07:19.0093 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d3Qsbal7G6QiDHwx2knYhUrS/P10c97H2VJVai53rSe5HLe7kJ+fA8ZlaKHY8SzmQGkSwW8xNQvP1IqBMbuWWjy2+Y9KAyFHerysGL9qUI0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6087
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

PiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFdlZG5l
c2RheSwgSnVseSAzMCwgMjAyNSAxMjo1OCBQTQ0KPiBUbzogcWVtdS1kZXZlbEBub25nbnUub3Jn
DQo+IENjOiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+OyBNaWNo
YWVsIFRva2FyZXYNCj4gPG1qdEB0bHMubXNrLnJ1PjsgUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5
ZGVsbEBsaW5hcm8ub3JnPjsgSGFvIFd1DQo+IDx3dWhhb3RzaEBnb29nbGUuY29tPjsgSmFtaW4g
TGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+OyBDw6lkcmljIExlDQo+IEdvYXRlciA8Y2xn
QHJlZGhhdC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCB2MyAyLzNdIHJvbXMvTWFrZWZpbGU6IGJ1
aWxkIGFzdDI3eDBfYm9vdHJvbQ0KPiANCj4gRnJvbTogTWljaGFlbCBUb2thcmV2IDxtanRAdGxz
Lm1zay5ydT4NCj4gDQo+IFJlc29sdmVzOiBodHRwczovL2dpdGxhYi5jb20vcWVtdS1wcm9qZWN0
L3FlbXUvLS9pc3N1ZXMvMzA1Mg0KPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIFRva2FyZXYgPG1q
dEB0bHMubXNrLnJ1Pg0KPiBSZXZpZXdlZC1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBo
aWxtZEBsaW5hcm8ub3JnPg0KPiBUZXN0ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxw
aGlsbWRAbGluYXJvLm9yZz4NCj4gTGluazoNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVt
dS1kZXZlbC82MDdhOTQzYTU4NzI0OGZiZTBmZjA4OTdkZTgwYWVlOThhMDkNCj4gM2NhYS4xNzUz
NjU0NTE1LmdpdC5tanRAdGxzLm1zay5ydQ0KPiBbIGNsZzogUmVtb3ZlZCBtYWtlIENDPSB3b3Jr
YXJvdW5kIF0NCj4gU2lnbmVkLW9mZi1ieTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQu
Y29tPg0KPiAtLS0NCj4gIHJvbXMvTWFrZWZpbGUgfCA1ICsrKysrDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgNSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvcm9tcy9NYWtlZmlsZSBiL3Jv
bXMvTWFrZWZpbGUgaW5kZXgNCj4gNmFmNjhhOTIyZjMwLi40Yzg3OTNjNWJkNDUgMTAwNjQ0DQo+
IC0tLSBhL3JvbXMvTWFrZWZpbGUNCj4gKysrIGIvcm9tcy9NYWtlZmlsZQ0KPiBAQCAtNjgsNiAr
NjgsNyBAQCBkZWZhdWx0IGhlbHA6DQo+ICAJQGVjaG8gIiAgdS1ib290LnNhbTQ2MCAgICAgIC0t
IHVwZGF0ZSB1LWJvb3Quc2FtNDYwIg0KPiAgCUBlY2hvICIgIG5wY203eHhfYm9vdHJvbSAgICAt
LSB1cGRhdGUgdmJvb3Ryb20gZm9yIG5wY203eHgiDQo+ICAJQGVjaG8gIiAgbnBjbTh4eF9ib290
cm9tICAgIC0tIHVwZGF0ZSB2Ym9vdHJvbSBmb3IgbnBjbTh4eCINCj4gKwlAZWNobyAiICBhc3Qy
N3gwX2Jvb3Ryb20gICAgLS0gdXBkYXRlIHZib290cm9tIGZvciBhc3QyN3gwIg0KPiAgCUBlY2hv
ICIgIGVmaSAgICAgICAgICAgICAgICAtLSB1cGRhdGUgVUVGSSAoZWRrMikgcGxhdGZvcm0NCj4g
ZmlybXdhcmUiDQo+ICAJQGVjaG8gIiAgb3BlbnNiaTMyLWdlbmVyaWMgIC0tIHVwZGF0ZSBPcGVu
U0JJIGZvciAzMi1iaXQgZ2VuZXJpYw0KPiBtYWNoaW5lIg0KPiAgCUBlY2hvICIgIG9wZW5zYmk2
NC1nZW5lcmljICAtLSB1cGRhdGUgT3BlblNCSSBmb3IgNjQtYml0IGdlbmVyaWMNCj4gbWFjaGlu
ZSINCj4gQEAgLTIwMCw2ICsyMDEsMTAgQEAgbnBjbTh4eF9ib290cm9tOg0KPiAgCSQoTUFLRSkg
LUMgdmJvb3Ryb20vbnBjbTh4eA0KPiBDUk9TU19DT01QSUxFPSQoYWFyY2g2NF9jcm9zc19wcmVm
aXgpDQo+ICAJY3ANCj4gdmJvb3Ryb20vbnBjbTh4eC9ucGNtOHh4X2Jvb3Ryb20uYmluIC4uL3Bj
LWJpb3MvbnBjbTh4eF9ib290cm9tLmJpbg0KPiANCj4gK2FzdDI3eDBfYm9vdHJvbToNCj4gKwkk
KE1BS0UpIC1DIHZib290cm9tL2FzdDI3eDAgQ1JPU1NfQ09NUElMRT0kKGFhcmNoNjRfY3Jvc3Nf
cHJlZml4KQ0KPiArCWNwDQo+IHZib290cm9tL2FzdDI3eDAvYXN0Mjd4MF9ib290cm9tLmJpbiAu
Li9wYy1iaW9zL2FzdDI3eDBfYm9vdHJvbS5iaW4NCj4gKw0KPiAgaHBwYS1maXJtd2FyZToNCj4g
IAkkKE1BS0UpIC1DIHNlYWJpb3MtaHBwYSBwYXJpc2MNCj4gIAljcCBzZWFiaW9zLWhwcGEvb3V0
L2hwcGEtZmlybXdhcmUuaW1nICAgICAgLi4vcGMtYmlvcy8NCj4gLS0NCj4gMi41MC4xDQoNClJl
dmlld2VkLWJ5OiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4NClRoYW5rcw0K

