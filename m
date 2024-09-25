Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E613CF9C71
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 02:56:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stIBC-0006G4-Ez; Tue, 24 Sep 2024 22:55:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1stIBA-0006EU-Ex; Tue, 24 Sep 2024 22:55:00 -0400
Received: from mail-tyzapc01on20703.outbound.protection.outlook.com
 ([2a01:111:f403:2011::703]
 helo=APC01-TYZ-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1stIB6-0003Ss-Q7; Tue, 24 Sep 2024 22:55:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L0ysqPd2LX7XR1tbtvRHrnLZc0uDjhACujCA0uz/x/SCWRSJ2R0rwGSBMIEqXAcdTUr0pMmgriAPuCNo8SQecUCuEWrasJp75/rBgfe9cnoo05D5hhsPj9DojqO5zkyUqkdkdHJ81YmsLd+i7s8sBpD5vvCE9y3uHEQctHOlFe36nJyvVuYN9xpfnPwGxMWKrkeVzL0JYLQYLkqlvj+6hCbwIPI19uCb/cus7udpvx0g79wyDU4wdw9WUX2rgZpiHGgC1yY0TLlT4kSEAAE0kKmSP+JigZpLPxOPewOg2S2wG1IuoYn92EjEMFeOMvU4IB6DpU/V/Z8WDAZq9SYhaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wuJw1Scg1qsEx2pkkd+zjnAuxm7KTqmk+CLk3FDj7dY=;
 b=mcA4410NHvZDyhtfRneAHxR+Y3rmd6CzBmPXEsmmz6iQ4CDb9iULxiIK+YD1+p6rs43cqJnck//dcF/KekTCT8BAUP7OOMtDIsfJuTQbs4QSM7Y8d1VpdZgB10ygq5ek48zW6LuhC6nePLn1D7/odecBX6RbgdplGW2Of9dkScepjEE1ns6Q5x5+nKlPhvRBdYdiPr8uN9YPrj1mJPxeIugSR1hosk4kB62ANE4ESFyu/Iiw6MA3Kpcfo5CdyTinRiMSdFPRCmlSZKXNWTyLV6VxN3YKQ1RcKB19+C2ml7i0d3SP2cMXGNYEOhIhhhUNIAQ019yzIdthpdexZ+MAsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wuJw1Scg1qsEx2pkkd+zjnAuxm7KTqmk+CLk3FDj7dY=;
 b=PwAOc3PcJWumplVK8KYa0HAV4wgXTy+HWRGgKP4sM4QlPAU+F6qXT/D91FGFBgeErwoCguCRmeT0xewNVGfKlNFtFwELOozI4poZx7RrGlQBZ7Ce9w3Ze2lzAf+owtHqjMaW3SesP1vR6d3llP5PtW2A68+hAqyxV2Jo/eHOpLCDR14zc5fIpcL9Tc+R2Vu4jTOLSzh3e5c2yMLjyDAL7NdPI/eCYpmuUhM6HmZ4aT4370ITQpCrHlw6aUHu5Xrdd122ZwCE7YpLzR9hjysC/664lSVysiivBf6mO7YMJh8nB3TuhOr3A3ylWQ8QDWjLd0ShEiuOAD1LsgYJjOEYag==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SI2PR06MB5218.apcprd06.prod.outlook.com (2603:1096:4:1e1::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.27; Wed, 25 Sep 2024 02:54:45 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 02:54:45 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH 4/5] hw/gpio/aspeed: Add AST2700 support
Thread-Topic: [PATCH 4/5] hw/gpio/aspeed: Add AST2700 support
Thread-Index: AQHbDZzixYX779jCY06UyzfEbXKCm7JmIjCAgAAanMCAAEFxsIABIm4AgAAwVUA=
Date: Wed, 25 Sep 2024 02:54:45 +0000
Message-ID: <SI2PR06MB5041D81EEED89142E1D60E66FC692@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240923094206.1455783-1-jamin_lin@aspeedtech.com>
 <20240923094206.1455783-5-jamin_lin@aspeedtech.com>
 <e5d149765b338d4754054691cb83eacdf3e2642f.camel@codeconstruct.com.au>
 <SI2PR06MB50413C10FCB429361E467246FC682@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <SI2PR06MB504195FD5CE33E041514C46BFC682@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <622300963fae35522af6d90248bb93a6a4d91121.camel@codeconstruct.com.au>
In-Reply-To: <622300963fae35522af6d90248bb93a6a4d91121.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SI2PR06MB5218:EE_
x-ms-office365-filtering-correlation-id: c1416cca-f4df-4984-9463-08dcdd0d6956
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WG9SVjJnR01DQ0gzTDhCOEVDNk9IREJ4elRLREh5V09KRS9SeVMrV2lhSnpa?=
 =?utf-8?B?aUdDSlpIV2ltMTljb2JOQllGczJhL3U2U1FyR0VCMHlIK2MyM0lHeHFQWndY?=
 =?utf-8?B?Q1pZdGJXRVhMeHFRcEpYcHd5ZlM5ekxCWno0UnpJZFJiOVdkaXNtMm9ER25W?=
 =?utf-8?B?ODIvTVJtQnBYWUZUampqMWVzS2JPUjN6djF5OXIxSWZIZTZEcWVGc2hyM1hD?=
 =?utf-8?B?aGVHZUh2U3BDSGVxSWVTVkMwSzVxd3lSN1pmL1N2ZTA2RTFPV0tXN0lKclNl?=
 =?utf-8?B?OXVsSXp6Y29UQlQrT0l0MjdJVWZwemF6Nk5ia1MvY3huWU83YXVZMzBRWktk?=
 =?utf-8?B?UXhUVElUTysrc25KYldML0h1MHg5MFdSZWxvZkVSbXlJMkJVZ3BMRVdBdDFl?=
 =?utf-8?B?WjFUNFJ3Q3c3b2l3MmJySlpYSFJvMVEra21IeURqMnBKeHZhN1VNTHZTU0VF?=
 =?utf-8?B?aDk3K3VvblMzbWtiTDlDdDUwMExFZ1diaHFra0JhSzBqSnhETHBKclRsWVZX?=
 =?utf-8?B?aDVwRHczU0EwREpVV0dRNWxLT1kwRlpoblRHRndWSFg0TWNUN0ROSzF4QjJ1?=
 =?utf-8?B?ZTF2Qmxkb0VQNjl5QS9paWlqNDZ0dWN6NFJkVDdRbHpPZEQvZVdLOUNveUlB?=
 =?utf-8?B?SWtkamZaNmIzN0hVQnBaYlBYMVJLYTBlcUlPZFNTeEY2Ly84aHRURkRDclkx?=
 =?utf-8?B?QWY2NGJZdnErVUhjWGwrZTk2WUJjV0hac3NLYklRaENtak8vTlBHZURGdTJp?=
 =?utf-8?B?ZEszcGs1QlFVYmtjUVFDRytqaUtWa1dieDV0UXJHaEJxNmV0cGRHbnYvd1Q0?=
 =?utf-8?B?WmJWTmdjUkRyNXU3a1ZvOFRnaUdvbGdheVAvdkxQaStsMitQelY1MitFNFQ3?=
 =?utf-8?B?QW0xWUNya2N6NWNaemRiQzY5QVNtZ1ljTkFyVm9zdTZrOFY2UERDUFR3bkps?=
 =?utf-8?B?UTZPanlLa1AzVUlvdlFyeURCWjhCRWV2NjNRclA0S3djaW54VmRJOGlrMXow?=
 =?utf-8?B?UnNXLzFyYVlteXNxQW1hSDQ2TkJQdFhJQk5kYW1kSjc4ZWUvTmhGYWlmOVlC?=
 =?utf-8?B?THZHVTVIS05xYndqU21yWWRTRGlldmxhQmhlTkF6eW42azdPa01ueVpFY0F1?=
 =?utf-8?B?OTdlQXhJL0JxS0kxcDVSU082dG03SmhlcG1ld2pCbU9XM3p4TXh4akpOYlJh?=
 =?utf-8?B?UlNKRHYwV092M1dYUDIvRDdFVXM2dGxWbG95Nk5wWCtKUzk2dVhBUGxVZ00z?=
 =?utf-8?B?d2IwYzdtY3IzaXJRUDN3QkZHczBuVFJvWjVVaXptei96SFFOZDJjRWdyUHRN?=
 =?utf-8?B?Q0pNLzdvNDlBQzQvNUlyZ0RnWk9mMnhCSWk3ekx2YVhYUUNNL3Vod1VOYi9m?=
 =?utf-8?B?YkJMUXBoZGU1YXRick5TdjhjWE9Ma0J4NXAzajRXZmNMVkI1WDR3U0xiNlYx?=
 =?utf-8?B?T0JiOGYxVWtnZ0k0U3F2U2ZjUFk3OGQrRGc4ZWNyMjIxd2oveWlmMm55TDZ4?=
 =?utf-8?B?TkVlKzN0VDFZbkNVTHJDaWdUcmVKSXJZdHRpQVg1KzJ4c1dhekNJbFU4ZjFi?=
 =?utf-8?B?bms4c1dleGg5WTcyTC9lRDNYU1kyblRuU2IzRGtlSUc4WmJDOFoxcmFiSFhH?=
 =?utf-8?B?cGFhc0czT1Q5RE1JSFFRbDNOWVNnS2R5Qmw5Vy9uYUJMcjcxU2FWS29UMnFR?=
 =?utf-8?B?MmRqd1I5RDRRQ2pHZkFRUlRhT2RMZCt3eHVoNkJFVkdlUnBpM0dWYzhvS3Jt?=
 =?utf-8?B?T3pMMkpOM0x1a1o0eE81a1hYRU1TcFprQWgwSTA2MEN2MHhKa2dUek91T2pN?=
 =?utf-8?B?TFRDZmNCS1NUME1pVU9zN3RXSTVuOWdacXFDNlBiRWV6a3RFSHdDZFVNaElP?=
 =?utf-8?B?Q2NLeStTWkVob3RIb0V1ejVBcGJBcUpqV25DTkFHOWMzSlE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MldCWlRtWGxxZG5jMGxWNHRYYXdWK1N3TWJVZ1N2ZEhGbUUvdjRTT0lVRzJY?=
 =?utf-8?B?YlBBdjQ4V2hBZXhQVmRVU0VCektFU1d5Z2RVaUJoTFErU1RzaGRmRHZXQ0wr?=
 =?utf-8?B?QzFnSHlFOFRKcHFsY3lGNmdOSTZRdEUwQ1pjYi9acC9XNTFjaXJZZnE5dytW?=
 =?utf-8?B?RjhWVkdPaHBnSmloYkVKL214anQrNjIycGtRSHkzYzZTcHdsNEhrMDd1Q1R2?=
 =?utf-8?B?bWl0NVg4YlVqRjJwZm5SbW9qOEhZVDY2dGwwSG1xaFlMaThEdFRQazhrNGtj?=
 =?utf-8?B?VTZSMTNLMnhMaWdqV285dy85ZkNKMXkwQ2lhbW9Gdm1BOW5YWThxTUhQU3lI?=
 =?utf-8?B?bXhVbTJndDZRYktKbVc3aDJZUSs0MXZBZnYvdXhMZjBKaWJHVDFxS1NXZ0ZK?=
 =?utf-8?B?VGZWeTRRb3hEdXowZW94N0tESEJBMUUxL1hITkc5TGZOTjRnVkRGUmlrS3M5?=
 =?utf-8?B?NURvaWNzaGlLb3Y0QWZESGNSSWtSNGRqcFcxWHVHS29yWGtQSll0V0dNemNM?=
 =?utf-8?B?THFjamM0UUtGd2YzVnlUTzZkaDVXUGR1UmhhdGdmbmJJcmozWFdxU0Yzbnda?=
 =?utf-8?B?dVhkMEZwOU9HdHZWU05BWjhubnQxS2dQejVKZ1JlOExGT3dsN3V3SnBQTWhM?=
 =?utf-8?B?TEhhWUNXL3dXSG9weGZnVGEwWWc3NDE5MUpXUWdxM3ZiSzR4M3pvb3JBOHpZ?=
 =?utf-8?B?RDRJdHUxV0lrcjJkSngxUTVmMEFmK1A2d2VrMjZkeUdBakdxSFNTQXg4UWdq?=
 =?utf-8?B?dFdIT1EzaTNZL1NUOUNVaUg3NDd5TmY3aUwydmJFbHMxOU15b0dHWHllSnpj?=
 =?utf-8?B?RENTWWwwVlFSaC9pbE9oQVJ6TVFEQ1pINytSU1pJMXo0RXBDYWhKcllibmV5?=
 =?utf-8?B?RnBUR3lLSXZkOXg3R0kxbGI3K2JlVGR2ZW5QUGVLVEZkK0lhL3JycFA5b045?=
 =?utf-8?B?MzdoNnY1SnJMeTRSUlJMc3NaZ0NpaFNiSWFqbUwrUjNnc0tMUnNlQ1U0a3c3?=
 =?utf-8?B?WDUrc1ozSmxmRXgxSWxvckRQejJjbE9waEV3ZFV4aU9rSUoyNTEzL2hDeFR2?=
 =?utf-8?B?ZUN0QUlnOWVvZnFpQkNEWTZDNENwMTZwUUlLUW1EU0R3NUhsSnJJZGpiOC85?=
 =?utf-8?B?cU1SYzhoS3pOVXkwMy9UcnhvL2tZakRodTYyZGhUTGt4eE90WGMzcDJsd090?=
 =?utf-8?B?UDVXN3IrcjhzeVNKM0V1N2gyOWs1eFNrU0M1aDg5VHF6U0Z4aUgrc1pha3JV?=
 =?utf-8?B?c0Fkd3RacmRJWnVDeElHVW1JWDYwSFV2M0VXNXhtNEZhb3dPTCt6dXZUenFq?=
 =?utf-8?B?Qjc4eCthRFRnS0c0TE51bUJMbmJhZWNjRlE4VjQzNUZ3MnFHRm1EdlBiejAz?=
 =?utf-8?B?TjcyWjNPM0tqWkhHT25LYTRLNm85VVpKNXRpTEhwMlBYWmU3WVhMdEQ0cy9v?=
 =?utf-8?B?TkhaaWRBdHFmS1BUa240ckdvWGNFR2dMOHJEQkhsRlBoQXdOc2FjTEVYTFpQ?=
 =?utf-8?B?YnVhNUdENURNSVdQNDAwcXJJbWM4TWg5SUs1ZU9nTWgxcUNoYWRqV0wxZEJv?=
 =?utf-8?B?cUIrOVZBK3lyYkJaRDJrOUJmdTEyM0dVOWpDRzNveS92WGtGaDhpUHQzQ2I0?=
 =?utf-8?B?aVJRMDBSbUFBRjgydDVKRVA0N015ZnpJbEJncnNBZUR5b2V6RndNUFR6WFBs?=
 =?utf-8?B?MGxuNVJkUll4clNBTkVQUnBKMWZKb2lmV3NDVWtHcDdaVlZyRnlRQmFNUjN6?=
 =?utf-8?B?dmtJSzk4eldOaldDNTVkNVVHRVIvT1hVcXo3NldWUkY1NzN0N2lPTXB5ejVT?=
 =?utf-8?B?RVZ1TjJIVWFSRkVvRU1DeC9laU1vZ1JKU3EzMTZBanhQSHRqNTN3RU03aitU?=
 =?utf-8?B?UWNHUWYycUk3Z2s3dWFHbXg4akZjeW9LL3l3eTd1SWtETVM2UlVaQWNYVXAr?=
 =?utf-8?B?Sm1OMXJseWl1LzhoUG9VaERwZlh5eVpBTGlzdzJEYXB1QnkrenJJa3lpSGpV?=
 =?utf-8?B?ellPTFpSc04yZjBGMm9KNEhLV0ZKOUdUZ1AvQTFUSE9rVGZtak1iUEF4SDZZ?=
 =?utf-8?B?NmR4bGhTY2xKRExTMnBRMGUzQWl5OUZvOUFKV0NEYTQ1dXpGQVZjM3htVjNk?=
 =?utf-8?Q?tMlPOi+ODq7fEf9uEEjhWIcZR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1416cca-f4df-4984-9463-08dcdd0d6956
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 02:54:45.1308 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SeVS0snuNzyVQ4OpxJk/JZ8ZxPnPyj8ksNqbB+8MIjks/feGG5/SdmXMdQGAsc+Dh2cgzqzRnmtUWEm9sZEYVEsKNqd6tkc6zBQBmdzFHdI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5218
Received-SPF: pass client-ip=2a01:111:f403:2011::703;
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

SGkgQW5kcmV3LA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggNC81XSBody9ncGlvL2FzcGVlZDog
QWRkIEFTVDI3MDAgc3VwcG9ydA0KPiANCj4gT24gVHVlLCAyMDI0LTA5LTI0IGF0IDA2OjQ4ICsw
MDAwLCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4gSGkgQW5kcmV3LA0KPiA+DQo+ID4gPiBTdWJqZWN0
OiBSRTogW1BBVENIIDQvNV0gaHcvZ3Bpby9hc3BlZWQ6IEFkZCBBU1QyNzAwIHN1cHBvcnQNCj4g
PiA+DQo+ID4gPiBIaSBBbmRyZXcsDQo+ID4gPg0KPiA+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENI
IDQvNV0gaHcvZ3Bpby9hc3BlZWQ6IEFkZCBBU1QyNzAwIHN1cHBvcnQNCj4gPiA+ID4NCj4gPiA+
ID4gSGkgSmFtaW4sDQo+ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+ID4gKyAgICB9DQo+ID4gPiA+
ID4gKyAgICBzZXQtPmludF9zdGF0dXMgJj0gfmdyb3VwX3ZhbHVlOw0KPiA+ID4gPg0KPiA+ID4g
PiBUaGlzIGZlZWxzIGxpa2UgaXQgbWlzYmVoYXZlcyBpbiB0aGUgZmFjZSBvZiBtdWx0aXBsZSBw
ZW5kaW5nIGludGVycnVwdHMuDQo+ID4gPiA+DQo+ID4gPiA+IEZvciBleGFtcGxlLCBzYXkgd2Ug
aGF2ZSBhbiBpbnRlcnJ1cHQgcGVuZGluZyBmb3IgR1BJT0EwLCB3aGVyZQ0KPiA+ID4gPiB0aGUg
Zm9sbG93aW5nIHN0YXRlbWVudHMgYXJlIHRydWU6DQo+ID4gPiA+DQo+ID4gPiA+ICAgIHNldC0+
aW50X3N0YXR1cyA9PSAwYjAxDQo+ID4gPiA+ICAgIHMtPnBlbmRpbmcgPT0gMQ0KPiA+ID4gPg0K
PiA+ID4gPiBCZWZvcmUgaXQgaXMgYWNrbm93bGVkZ2VkLCBhbiBpbnRlcnJ1cHQgYmVjb21lcyBw
ZW5kaW5nIGZvciBHUElPQTE6DQo+ID4gPiA+DQo+ID4gPiA+ICAgIHNldC0+aW50X3N0YXR1cyA9
PSAwYjExDQo+ID4gPiA+ICAgIHMtPnBlbmRpbmcgPT0gMg0KPiA+ID4gPg0KPiA+ID4gPiBBIHdy
aXRlIGlzIGlzc3VlZCB0byBhY2tub3dsZWRnZSB0aGUgaW50ZXJydXB0IGZvciBHUElPQTAuIFRo
aXMNCj4gPiA+ID4gY2F1c2VzIHRoZSBmb2xsb3dpbmcgc2VxdWVuY2U6DQo+ID4gPiA+DQo+ID4g
PiA+ICAgIGdyb3VwX3ZhbHVlID09IDBiMTENCj4gPiA+ID4gICAgY2xlYXJlZCA9PSAyDQo+ID4g
PiA+ICAgIHMtPnBlbmRpbmcgPSAwDQo+ID4gPiA+ICAgIHNldC0+aW50X3N0YXR1cyA9PSAwYjAw
DQo+ID4gPiA+DQo+ID4gPiA+IEl0IHNlZW1zIHRoZSBwZW5kaW5nIGludGVycnVwdCBmb3IgR1BJ
T0ExIGlzIGxvc3Q/DQo+ID4gPiA+DQo+ID4gPiBUaGFua3MgZm9yIHJldmlldyBhbmQgaW5wdXQu
DQo+ID4gPiBJIHNob3VsZCBjaGVjayAiaW50X3N0YXR1cyIgYml0IG9mIHdyaXRlIGRhdGEgaW4g
d3JpdGUgY2FsbGJhY2sNCj4gPiA+IGZ1bmN0aW9uLiBJZiAxIGNsZWFyIHN0YXR1cyBmbGFnKGdy
b3VwIHZhbHVlKSwgZWxzZSBzaG91bGQgbm90IGNoYW5nZSBncm91cA0KPiB2YWx1ZS4NCj4gPiA+
IEkgYW0gY2hlY2tpbmcgYW5kIHRlc3RpbmcgdGhpcyBpc3N1ZSBhbmQgd2lsbCB1cGRhdGUgdG8g
eW91IG9yDQo+ID4gPiBkaXJlY3RseSByZXNlbmQgdGhlIG5ldyBwYXRjaCBzZXJpZXMuDQo+ID4N
Cj4gPiBJIGFwcHJlY2lhdGUgeW91ciByZXZpZXcgYW5kIGZpbmRpbmcgdGhpcyBpc3N1ZS4NCj4g
PiBNeSBjaGFuZ2VzIGFzIGZvbGxvd2luZy4NCj4gPiBJZiB5b3UgYWdyZWUsIEkgd2lsbCBhZGQg
dGhlbSBpbiB2MiBwYXRjaC4NCj4gPiBUaGFua3MtSmFtaW4NCj4gPg0KPiA+IHN0YXRpYyB2b2lk
IGFzcGVlZF9ncGlvXzI3MDBfd3JpdGVfY29udHJvbF9yZWcoQXNwZWVkR1BJT1N0YXRlICpzLA0K
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgcGluLCB1aW50MzJf
dCB0eXBlLCB1aW50NjRfdA0KPiA+IGRhdGEpIHsNCj4gPiAtLS0NCj4gPiAgICAgLyogaW50ZXJy
dXB0IHN0YXR1cyAqLw0KPiA+ICAgICBpZiAoU0hBUkVEX0ZJRUxEX0VYMzIoZGF0YSwgR1BJT19D
T05UUk9MX0lOVF9TVEFUVVMpKSB7DQo+ID4gICAgICAgICBjbGVhcmVkID0gZXh0cmFjdDMyKHNl
dC0+aW50X3N0YXR1cywgcGluX2lkeCwgMSk7DQo+ID4gICAgICAgICBpZiAoY2xlYXJlZCkgew0K
PiA+ICAgICAgICAgICAgIGlmIChzLT5wZW5kaW5nKSB7DQo+ID4gICAgICAgICAgICAgICAgIGFz
c2VydChzLT5wZW5kaW5nID49IGNsZWFyZWQpOw0KPiA+ICAgICAgICAgICAgICAgICBzLT5wZW5k
aW5nIC09IGNsZWFyZWQ7DQo+ID4gICAgICAgICAgICAgfQ0KPiA+ICAgICAgICAgICAgIHNldC0+
aW50X3N0YXR1cyA9IGRlcG9zaXQzMihzZXQtPmludF9zdGF0dXMsIHBpbl9pZHgsIDEsIDApOw0K
PiA+ICAgICAgICAgfQ0KPiA+ICAgICB9DQo+ID4gLS0tLQ0KPiA+IH0NCj4gDQo+IFRoZSBsb2dp
YyBpcyBlYXNpZXIgdG8gZm9sbG93LiBOb3Qgc3VyZSBhYm91dCBjYWxsaW5nIHRoZSB2YWx1ZSBl
eHRyYWN0ZWQgZnJvbQ0KPiBzZXQtPmludF9zdGF0dXMgJ2NsZWFyZWQnIHRob3VnaCwgc2VlbXMg
Y29uZnVzaW5nIG9uIGZpcnN0IHBhc3MuIEl0IHdvdWxkIGZlZWwNCj4gbW9yZSBhcHByb3ByaWF0
ZSBpZiBpdCB3ZXJlIGNhbGxlZCAncGVuZGluZycuDQo+IEkgdGhpbmsgJ2NsZWFyZWQnIGlzIGRl
cml2ZWQgZnJvbSBgU0hBUkVEX0ZJRUxEX0VYMzIoZGF0YSwNCj4gR1BJT19DT05UUk9MX0lOVF9T
VEFUVVMpYC4gQW55d2F5LCB0aGF0J3MganVzdCBzb21lIHF1aWJibGluZyBvdmVyDQo+IG5hbWVz
Lg0KDQpHb3QgaXQuIFdpbGwgdXBkYXRlIGl0Lg0KVGhhbmtzIGZvciBzdWdnZXN0aW9uIGFuZCBy
ZXZpZXcuDQoNCj4gDQo+ID4NCj4gPiBCeSB0aGUgd2F5LCBJIGZvdW5kIHRoZSBzYW1lIGlzc3Vl
IGluICJhc3BlZWRfZ3Bpb193cml0ZV9pbmRleF9tb2RlIiBhbmQNCj4gbXkgY2hhbmdlcyBhcyBm
b2xsb3dpbmcuDQo+ID4gSWYgeW91IGFncmVlIHRoaXMgY2hhbmdlLCBJIHdpbGwgY3JlYXRlIGEg
bmV3IHBhdGNoIGluIHYyIHBhdGNoIHNlcmllcy4NCj4gPg0KPiA+IHN0YXRpYyB2b2lkIGFzcGVl
ZF9ncGlvX3dyaXRlX2luZGV4X21vZGUodm9pZCAqb3BhcXVlLCBod2FkZHIgb2Zmc2V0LA0KPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQ2NF90
IGRhdGEsDQo+ID4gdWludDMyX3Qgc2l6ZSkgew0KPiA+IC0tLQ0KPiA+ICAgICBjYXNlIGdwaW9f
cmVnX2lkeF9pbnRlcnJ1cHQ6DQo+ID4gICAgICAgICBpZiAoRklFTERfRVgzMihkYXRhLCBHUElP
X0lOREVYX1JFRywgSU5UX1NUQVRVUykpIHsNCj4gPiAgICAgICAgICAgICBjbGVhcmVkID0gZXh0
cmFjdDMyKHNldC0+aW50X3N0YXR1cywgcGluX2lkeCwgMSk7DQo+ID4gICAgICAgICAgICAgaWYg
KGNsZWFyZWQpIHsNCj4gPiAgICAgICAgICAgICAgICAgaWYgKHMtPnBlbmRpbmcpIHsNCj4gPiAg
ICAgICAgICAgICAgICAgICAgIGFzc2VydChzLT5wZW5kaW5nID49IGNsZWFyZWQpOw0KPiA+ICAg
ICAgICAgICAgICAgICAgICAgcy0+cGVuZGluZyAtPSBjbGVhcmVkOw0KPiA+ICAgICAgICAgICAg
ICAgICB9DQo+ID4gICAgICAgICAgICAgICAgIHNldC0+aW50X3N0YXR1cyA9IGRlcG9zaXQzMihz
ZXQtPmludF9zdGF0dXMsIHBpbl9pZHgsIDEsDQo+IDApOw0KPiA+ICAgICAgICAgICAgIH0NCj4g
PiAgICAgICAgIH0NCj4gPiAgICAgICAgIGJyZWFrOw0KPiA+IC0tLQ0KPiA+IH0NCj4gDQo+IEkn
bGwgdGFrZSBhIGxvb2sgaW4gdjIuDQo+IA0KPiBDaGVlcnMsDQo+IA0KPiBBbmRyZXcNCg0K

