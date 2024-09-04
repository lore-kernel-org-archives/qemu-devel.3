Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46814CD37BA
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 00:58:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sleLe-0005Zp-Jm; Tue, 03 Sep 2024 20:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sleLb-0005Yk-6s; Tue, 03 Sep 2024 20:58:12 -0400
Received: from mail-sgaapc01on2070c.outbound.protection.outlook.com
 ([2a01:111:f400:feab::70c]
 helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sleLZ-0001al-7W; Tue, 03 Sep 2024 20:58:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dUvwqC2kr/TCF/KoKZf0O3O4FkVRcMhzeuz3P7F1cJwHGABHiQwkK96xdAe3v8nPuKLDTPgwL3HAmVubi3KFqbrzejRmei1VAue+qexv830YoxXqfJdAFiZoCsWAnMpUYySGwxED+9hESHm9LBc3yvSHMjwYgvb7+SXpzUqaruvtXZsdt2yNaVv9TvPp7SMJIBcLqVeQwtyE6slGsdhxzby1WOepLfU+TMEIHb0naFWDU1vyIz3fl4zrO/zMD8KLytZiaGD8MIN8jSsTZa8XtJ4IMBPy0iMezFULleWoM1HBcF4W4UowmHXGmaY2/3NJaIC25iW9bra7qoMhtGTyWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KbttaEI59AUyP9Tl9D0NEK2iqJQw70v3MrPmzkXGEJQ=;
 b=TmWIKkc7c/zTHHutoeygrQNVylTvZnM6q8T4PAkEIo/FJw8ms0dwzc16DAmx5G10IzXSAs81EoXcEcD/RJzK8AdEhOlW+18WUReHZ3WlzoEdEXYt9alMjtztXosa3DDy73Alai+uSKN1s0oSReKKEyQV88/hgiD8h3i7m9iftuqMPWqO51VTSzYG0ZENaxcdrq2UNisnFjbv4ryyYiiWOWfGIc9YIcPZPBDXHI7rwac0eSdWgW9oiZ2iJ7oaT1PT2dZ9ERxcQ+GYQg8jadUIwH8cxDML9PudTWKQpAB1XUsHbscy9XpQJ/KAr1lptCn++3mh4Fc+PiqcudNt/AiQgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbttaEI59AUyP9Tl9D0NEK2iqJQw70v3MrPmzkXGEJQ=;
 b=NgSVAlzQptxYotxm20JySejQl6d0bH2Mv0GhqjXyaZYqwBYpSCsOr1epWg2hnTSllcGmQACDfz3osR8h4IrqQYXJn1ZcZXw5JKsXHj8eiNBumu/eWyumMSTHMZz4aD+FWrFdf0pcG5jbaTFbM9FRNIVv67b2ySLOKVbCZn7o+Fp3R2urqFk5P/OiwAv507Ti/5JU0DXRZV3/AVoYQW0B+58kXuiNGXCR8ECuyTOJp6jZrEI+NkDpKEDzhBVhGVAy7AMyhNob+1AW480FoEriXK+MIXf/7cDMzdTpBPS9aQosN2b1naxvngCid5vjed1MmGpDhr5OGmSljL5GeDXUTQ==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 PUZPR06MB6032.apcprd06.prod.outlook.com (2603:1096:301:116::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 00:57:56 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.7918.020; Wed, 4 Sep 2024
 00:57:56 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Cleber Rosa <crosa@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Wainer dos
 Santos Moschetta <wainersm@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [SPAM] [PATCH v3 00/11] support I2C for AST2700
Thread-Topic: [SPAM] [PATCH v3 00/11] support I2C for AST2700
Thread-Index: AQHa/dxA7Q2YMqG9Y0mc3Ke+FSE3BLJGGq4AgACzhRA=
Date: Wed, 4 Sep 2024 00:57:55 +0000
Message-ID: <SI2PR06MB50418DD956AC152E4E0911CDFC9C2@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240903083528.2182190-1-jamin_lin@aspeedtech.com>
 <00aac81e-ff43-4526-960c-782e27ae043f@kaod.org>
In-Reply-To: <00aac81e-ff43-4526-960c-782e27ae043f@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|PUZPR06MB6032:EE_
x-ms-office365-filtering-correlation-id: d38daeae-b585-4300-4454-08dccc7c9cdc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|366016|38070700018|921020|217643003; 
x-microsoft-antispam-message-info: =?utf-8?B?L3FLVXhGbU9pVEYrRUprNnc1UW9Uekd2d0NCc0VkVkFmbHo5NzRvQkE1UGsz?=
 =?utf-8?B?UWZhU2VKc21uSTc4bWF2Zm1kNkQyVmhURllXTG1QL0p1bGVkMzRBUTRhQ1Rx?=
 =?utf-8?B?dG52Z3BnOWV1S3lJUFZ4NGJtajdyUTVpWmkrS0NzRXlXRWhkUXovdnFJWWxE?=
 =?utf-8?B?aldrTmtIRldBbXVxRmNPK3pEMUdJc21wck00QVZIOWlUczV6TURUQUtSR1hj?=
 =?utf-8?B?TzA3NGxRbTl4ZjJLTkR1Q3J3Nk10ekhab1lJUzVVZ1RGR29NcW9rMzczdFB6?=
 =?utf-8?B?L1RPYVVyT005L3N4djFWdGhvVmsvdG50NUdBazlZNTRGQ0NvYjBvWDd1QU5u?=
 =?utf-8?B?Q0tFV0pTdUNWNmVKZG5EOVJtZFFVQVo2RzR1Rjg0cm9LUVJCNGJvZEZtWFE0?=
 =?utf-8?B?VjFqODJyOWZzYUlrb3RNaU9LSnZyemh4eWJndElCZDBCQjJYVFlXaVdwWUNq?=
 =?utf-8?B?d3VON2E1TW1rZktJZ1NiZzNySDJxdDd3djMvVW50M0xLZ0VVQ1VITWd4SnNJ?=
 =?utf-8?B?SWdKcWFSVDBjODZwS2pTMllQbTBjN0V6UU9MUWNiOEhkdHRqUldSbGxtV2k0?=
 =?utf-8?B?eHlZdlpTbmh6R25Hc3N0UU5renEzUkNBYTFGazFqRWcyTHpTUyszT2V5Z3V6?=
 =?utf-8?B?VEwwSm8xQlRUTVNsU0JmT29oaHFReXFDQVEvc0V0QU1nMVNCNnFRMkxwZzB5?=
 =?utf-8?B?dlRlNk9qTmY2dnhFRE95NjZBenJBSW9ackp3ZWtNaHhITmQ3RlhBSmtMYVN6?=
 =?utf-8?B?ZlRIMW1VdUx3ZDUxejNBK2JjaXM3OWgxVEpsdlRBRzVYdzRuUDgvS2NKd3lZ?=
 =?utf-8?B?Skh2YmtsRVVPN1RIVjhCaGFtaGU1MlpzVHVwbGtOY0dnLzFNZ0FScE1GNE9Y?=
 =?utf-8?B?N0IrbEUzMjdmVDd0VHM2Q012NzltVjd6M09PWmFmN3NicFBJRG1oKzB6WmNN?=
 =?utf-8?B?bTZPWWJiM3AvYjVzK3k4aEN0TU80TkpvQXhITXFrUWx4eFdsQzFwY01jRERs?=
 =?utf-8?B?TE9YRFpHMDJSbVZzRGsxcFZlM0Q5T2ttbzhkY3Nib2h0VmluTGFsSmlMUmll?=
 =?utf-8?B?TVlNMjNoMWxPaGo4L3lNaG9tQVRKbGV5cHlBelowamozMlhlMmF4T3BieDNw?=
 =?utf-8?B?UVpBTUFsUTR3Z1JDR01EMzU4OS9TZE9xcVZrdkhKeFZ5NGZLZWEyV2g1TWNH?=
 =?utf-8?B?M3dobjEyVTlseXdYRERPQ05wKzhsY0cyZEZ2N0RTcDBjT2lJeE1KTTgrSitj?=
 =?utf-8?B?UnRZS3NrVHJUV3A1S2ozMHZiMmFvdmhuUk1CbXZhdDJ6VEc2cnBuZk9Dd1Q1?=
 =?utf-8?B?OStjYml6Mk9Nb2J0SmdMUkpqUDl4ZU5JQ2pTaVlZa3JQSGd1eUVnT2U5TjQ4?=
 =?utf-8?B?aEtRQzNtR2g0UzdIalVVUEd4QlBPNmszc3lDczdEbVJ4NlA2ODlhZkd4Zi9S?=
 =?utf-8?B?OGN0cjNFamFnZTFCL204SE5wQ0t1RXFhaTFaZ3N2NEFEL1d4RURoR3NSUXpF?=
 =?utf-8?B?aEM1OStDM0ZWZHFxMksvblVYUTl6Q3pISGtHSkNjeVNBSno2VVlabjU5eGN1?=
 =?utf-8?B?UWxDQTJmVFZYNFRoa0htRGF0cGtETFJvZEU1MEwyNHQ3L1hoY25SZXhaUFV6?=
 =?utf-8?B?NUlQMlBITUpSVXVRZG1rSERqbE5RM2RHNVJ5V2pIMCtCZ2toeW96RCtjYWZN?=
 =?utf-8?B?c0drbEJpNGtkeTRQRW92M1VZOUVwVjlZVUN2eFVkbWRmbkpvZFFCR2dkclNl?=
 =?utf-8?B?N2h1MkR6b3RGbFVpNTFtMXorU1MycmtVU3VJREVLb0IzbllwclQzdkQ2Z1hh?=
 =?utf-8?B?NXo5SW82MjQxeFo2NTZ1MnRndnFibkdFalhjTVhsUk96UDFaQ2VieGNhd2V5?=
 =?utf-8?B?bndiMWhhREdTV3dCUUxWb2w0b21PL2ozdzN1aXE2bU90OTNsTjRxSXJKSlRZ?=
 =?utf-8?Q?7oHxyQRMTJLnqcZ7X+4/NpnnoChx75FY?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018)(921020)(217643003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0E1aDNMbjVsdGFwYkFERXJLc0VydXBNUnBrMTRwcGxyUFkzSEZUcWNrMyts?=
 =?utf-8?B?SUl1YnJhZmhNWm9vTTdQOGZIaUlLWkVicVBKMG9jeEM4Wm1OdnkxT0xxSlVk?=
 =?utf-8?B?QkdCWXhTV0Q0Y05KcGRCK0FTdHVDZHIyY25iamRJRVBBZjJCMWw0UGFVbzEx?=
 =?utf-8?B?bVI1Um9tcGdaZHBoTGV6RlVrQS9kS1R2RGhWK2dZbUZXcjRiYXZRdnJYMkRT?=
 =?utf-8?B?dmNUakxwejR5V1JDa3laa1dOUEZwYitkcmNpSytScVRFcU5ocFJxaWlPanZ1?=
 =?utf-8?B?RTNxREpZQjQydWJoN1R4Z0RjRW5ySVM5UUFoQ2JZMUFyR0lrbi92Sjc2dE9P?=
 =?utf-8?B?ZkVTdGM3WVJyOURwTUp6VndEZkRnODF4V1l0OEM0eXZmVkpUQXQxYm5UcytD?=
 =?utf-8?B?M0c5b3ZHYnpSVExvcVpQZjIyN3ZGNW95ZWFsalRudmhTNzNKWGlBUlk1Rmhk?=
 =?utf-8?B?RVUwd1JsaFIxL3J0ZjNUcEk2SWkvanNtU3ZGYVExVTZoM0F6WUI4QlJSSzJF?=
 =?utf-8?B?a0tJK0x6dlJnMnA4c1dpQm5lOFYvRFlBMGYxakJFem5JSHNycllXenhUYVk5?=
 =?utf-8?B?eDZvWkVNcE9CaHdpb0NnR1VZZnA5R3NsWlRURCt6OXFBbWdEVFJrMHFlWVpO?=
 =?utf-8?B?Y0pmOXFaN3V0OVRtV0xOQ0dVMVA4d2lVZy9odjJOZThzY0paTlZRaCs4QnU1?=
 =?utf-8?B?MEl0ZUl0T2cwSHloN05WSUcxK3Z2aUdkaS9QeUM4VzJNamNpT1hhbG9jVERF?=
 =?utf-8?B?eXFzV1FtQjFIK3FHa1BoWG5ieFYraERCUzM0aVFORHNud2RaR08zYW9PTDRP?=
 =?utf-8?B?N1JtakRlSmtla3hoNjNRcm5PKy90MENLSXhzdXdkdjZpM1g1bEl6SEkreGts?=
 =?utf-8?B?TGxFMTQ2Q0VlOVBXMWE2N3pZUi9ZR2N5WUxuU3Y0MjhyZ1lLTng1ZnR5cWty?=
 =?utf-8?B?dUc4L3NTNlpZZklZTEJKSjN4OVBWSFBYTi8vZWhHb2ZVTlA3V2s5Uy81NWVw?=
 =?utf-8?B?WTM3QXJwSTZ4bDczamZjSElRSW05Y2hTbng0cG1UUVNBQlBkVFgrMjBINTRw?=
 =?utf-8?B?dFpFNHZjTXdReUVkQVVPWktHQ2FXTnpsMFE4MnJYS0NSaTErRHJ2TC9PZi9H?=
 =?utf-8?B?NWdlaldNVlZBNlFTSlMxR0drb0F4RVVSalhrM0hCYXFIQy9KSVJtdG9IaXFv?=
 =?utf-8?B?SWgvZ0xpZHRnMmZ1QitWRXNIZ2xZalpMaWZpNm80bW80SXR4NEcyRU52NWRa?=
 =?utf-8?B?TFprN0h5K3NOemJDTjVhZ3piT1c2UmRRQXN4aE9EYU9ucXY3a3diSFVSMEpr?=
 =?utf-8?B?TlJNb2JoVWhweUx2WnJadzBNQzd0OVllQU9UY2RQdGdzb1JyTUo3SUE3eUhz?=
 =?utf-8?B?WGM2UjRQUUhSeVk1eE00b0h0RElObnUxRFFpdVdvem81WllGZ25mZENwR2dG?=
 =?utf-8?B?Q2ptNktRSjd5RXlIeVBiTU1tVFMzT0tqc2E2dDQ2QWFyWVJBSEVuNmpGbHdM?=
 =?utf-8?B?ejY4Y0lYRmtCTXFmcDRDbHZzdWJkalIweTg0K2FvSG1yZ2JVOHNTd3VtNkdH?=
 =?utf-8?B?YndQS2xwNzZTVmdGWjJzU1FBZGhVRlQ2cHc5MFZsQmpiZFBRc1dNOU1CQ3Rl?=
 =?utf-8?B?blIvQzkzbXh0eTBmRy8yY2MzWHRpRW84SkN3U3RieGYzeHVDajdDaVErUTZ4?=
 =?utf-8?B?NFgzVlRHcGpmQmV2SmlaN0JZZVl1cVlFdkVsQzAwby94M0VPN2FnOVNkTFZ6?=
 =?utf-8?B?YjJ2N01mdHArYkZRbXdsNENVUUNUM3UxdDkzRE1rNFRyTW8vZWNBTmkxTEpj?=
 =?utf-8?B?UDZvM1YxRis0U0FwSmxMbXhsbEZPNUpmUXoxeUloL3RYZldRckVqYkYyRHF3?=
 =?utf-8?B?U0R0QkdXMTVsdSt1Q253SjVmekZzVmZOeXBDL3RhM0ZhamFkeXZGcWwrT2Yx?=
 =?utf-8?B?UHd3SWprVkZCVkZyTmg1WVBPNVNNNDR6RUVSa08wWGxZNHR3VDdvMUZUZGNU?=
 =?utf-8?B?SlNiWjV2U2JBOHc2azVBdjFBR1c2SnlhT0t1bmw0ZkdQQmFlaXcwY2UwZ004?=
 =?utf-8?B?RHAzRHN2QVhHNy9MNjFRTDBBWncxSlV0TXJPelhMUW9LeE9vVXdyUjRIaFN5?=
 =?utf-8?Q?H5jtBeIf2e8Bys6XE5sWpDavW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d38daeae-b585-4300-4454-08dccc7c9cdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2024 00:57:55.9336 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GOe/Q595Dg8bUTG+asy8tdjEE+GD6XyLbMcGGCTPaKuwKZbgW0eX/i+mu6A/oraW/Z8Gvs93N1tVfx3ob2VWg21dF/5TJLO229KNGiousvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6032
Received-SPF: pass client-ip=2a01:111:f400:feab::70c;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-SG2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

SGkgQ2VkcmljLA0KDQo+IFN1YmplY3Q6IFJlOiBbU1BBTV0gW1BBVENIIHYzIDAwLzExXSBzdXBw
b3J0IEkyQyBmb3IgQVNUMjcwMA0KPiANCj4gT24gOS8zLzI0IDEwOjM1LCBKYW1pbiBMaW4gd3Jv
dGU6DQo+ID4gdjE6DQo+ID4gLSBzdXBwb3J0IEkyQyBmb3IgQVNUMjcwMA0KPiA+DQo+ID4gdjI6
DQo+ID4gLSBmaXggcmV2aWV3IGlzc3VlcyBhbmQgYWRkIHJldmlld2VyIHN1Z2dlc3Rpb24NCj4g
PiAtIHVwZGF0ZSBhdm9jYWRvIHRlc3QgY2FzZSBmb3IgQVNUMjcwMCBJMkMNCj4gPiAtIHN1cHBv
cnQgaTJjIGJ1cyBwb29sDQo+ID4NCj4gPiB2MzoNCj4gPiAtIHVwZGF0ZSBjb21taXQgbWVzc2Fn
ZXMgYW5kIGNvbW1pdCB0aXRsZQ0KPiA+IC0gdXBkYXRlIEFQSSB0byBnZXQgdGhlIGRldmljZSBp
cnENCj4gPg0KPiA+IEphbWluIExpbiAoMTEpOg0KPiA+ICAgIGh3L2kyYy9hc3BlZWQ6IFN1cHBv
cnQgZGlzY29udGludW91cyByZWdpc3RlciBtZW1vcnkgcmVnaW9uIG9mIEkyQyBidXMNCj4gPiAg
ICBody9pMmMvYXNwZWVkOiBJbnRyb2R1Y2UgYSBuZXcgYnVzIHBvb2wgYnVmZmVyIGF0dHJpYnV0
ZSBpbg0KPiA+ICAgICAgQXNwZWVkSTJDYnVzDQo+ID4gICAgaHcvaTJjL2FzcGVlZDogU3VwcG9y
dCBkaXNjb250aW51b3VzIHBvbGwgYnVmZmVyIG1lbW9yeSByZWdpb24gb2YgSTJDDQo+ID4gICAg
ICBidXMNCj4gPiAgICBody9pMmMvYXNwZWVkOiBJbnRyb2R1Y2UgYSBuZXcgZG1hX2RyYW1fb2Zm
c2V0IGF0dHJpYnV0ZSBpbg0KPiA+ICAgICAgQXNwZWVkSTJDYnVzDQo+ID4gICAgaHcvaTJjL2Fz
cGVlZDogQWRkIEFTVDI3MDAgc3VwcG9ydA0KPiA+ICAgIGh3L2kyYy9hc3BlZWQ6IEFkZCBzdXBw
b3J0IGZvciBUeC9SeCBidWZmZXIgNjQgYml0IGFkZHJlc3Nlcw0KPiA+ICAgIGh3L2kyYy9hc3Bl
ZWQ6IEFkZCBzdXBwb3J0IGZvciA2NCBiaXQgYWRkcmVzc2VzDQo+ID4gICAgYXNwZWVkL3NvYzog
SW50cm9kdWNlIGEgbmV3IEFQSSB0byBnZXQgdGhlIGRldmljZSBpcnENCj4gPiAgICBhc3BlZWQv
c29jOiBTdXBwb3J0IEkyQyBmb3IgQVNUMjcwMA0KPiA+ICAgIGFzcGVlZDogQWRkIHRtcDEwNSBp
biBpMmMgYnVzIDAgZm9yIEFTVDI3MDANCj4gPiAgICBtYWNoaW5lX2FzcGVlZC5weTogVXBkYXRl
IHRvIHRlc3QgSTJDIGZvciBBU1QyNzAwDQo+ID4NCj4gPiAgIGh3L2FybS9hc3BlZWQuYyAgICAg
ICAgICAgICAgICAgfCAgMTAgKysNCj4gPiAgIGh3L2FybS9hc3BlZWRfYXN0Mjd4MC5jICAgICAg
ICAgfCAgNDUgKysrKysNCj4gPiAgIGh3L2kyYy9hc3BlZWRfaTJjLmMgICAgICAgICAgICAgfCAz
MTANCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0NCj4gPiAgIGluY2x1ZGUvaHcv
aTJjL2FzcGVlZF9pMmMuaCAgICAgfCAgMjggKystDQo+ID4gICB0ZXN0cy9hdm9jYWRvL21hY2hp
bmVfYXNwZWVkLnB5IHwgIDE2ICsrDQo+ID4gICA1IGZpbGVzIGNoYW5nZWQsIDM2MiBpbnNlcnRp
b25zKCspLCA0NyBkZWxldGlvbnMoLSkNCj4gPg0KPiANCj4gDQo+IA0KPiBBcHBsaWVkIHRvIGFz
cGVlZC1uZXh0Lg0KPiANCj4gVGhhbmtzLA0KPiANCg0KVGhhbmtzIGZvciB5b3VyIGtpbmRseSBz
dXBwb3J0Lg0KSnVzdCB3YW50IHlvdSB0byBrbm93IHRoYXQgSSBhbmQgVHJveSBhcmUgd29ya2lu
ZyBvbiB0aGUgZm9sbG93aW5nIHRhc2tzIGZvciBBU1QyNzAwLg0KMS4gU3VwcG9ydCBib290IGZy
b20gYm9vdG1jdShyaXNjdjMyKSBpbnN0ZWFkIG9mIHUtYm9vdChDb3J0ZXgtQTM1KQ0KMi4gU3Vw
cG9ydCBHUElPLg0KDQpBZnRlciB3ZSBmaW5pc2ggYWJvdmUgdGFza3MsIHdlIHdpbGwgdXBzdHJl
YW0gUUVNVSBhbmQgc2VuZCBvdXIgcGF0Y2hlcy4NClRoYW5rcy1KYW1pbg0KDQo+IEMuDQo+IA0K
DQo=

