Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 519F7C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 06:06:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEjlx-0006yI-H9; Wed, 05 Jun 2024 02:05:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sEjlt-0006xq-Vn
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 02:05:19 -0400
Received: from mail-southeastasiaazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c401::3] helo=SINPR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sEjlp-0007tF-1A
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 02:05:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LKxN1kOFgTuaV509a3DrNgycfVvQDBCxAyYVqHWXvG3Zv6wsVDpP8zHZNFB5ASNmHaCxco5JZuwssQG+dw7dojrLx4ziIILdIrFiJuFl74fpSv8KuKriVMy417s653g+mHLLLUWQKTab+o3UqE0L8SiQJwSBRPGhHhbABpcccZ2jRp+ZuI9M83Iee0c8xbn3emJ8PdsI03ACAUnhMEmconJrNzsDTfiAAMtOlW+VYmnl/Ybda7nmtR1Vx+199cLDMaVyN3OCiJ7VORqQ+lZLCm89qRWixBeTEW7s3LGrTByApwRf7geQsix2HGFE3xgjCiPidSqhpbddC9vRX7FHWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6N5qDlbkCQBLRYJ7V/bPNngJy3eeqNDoG5aRY9wHaSE=;
 b=SgwTJYRJ+ObRsd92P4Nnzhh6gPCbvGmaaZKUZ0mdruk4XYuANMn5iah3Ol1IYbTBi2bwfg6MknPS+gNfHZaTgJUbbuIOs1KnsmI9p1J/8CThl9PDiK5vWAqKUntG8z9Yuv1SiyubmvyugPea9CdFVgF+PxLRdvwuA8S8nQbSsx1aS1f9RYSh1IuQpN5NQVIfhfV3Hp368o/hKEDWY2m59m9yP8oizPqxcoyc9jlFxAwEU8fmUG/fml4Djz/7jkw4/9ij5/gbUGOF9/mH81IOWYGC3nUpJqhi3RUxh5kT60c79RfKp+bdJXKKq6C1p1JULKrj/Z9b6TV8whHDLFtnEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6N5qDlbkCQBLRYJ7V/bPNngJy3eeqNDoG5aRY9wHaSE=;
 b=BX/jLhLPpfHJmUKAKgzcu5TUiV8XhQRtIQ3rK6ictBr9xQf00YHhvy+dYHAyzWLrVs1lbSUrRgDvI8U8tgGuWVdgMNu68R20m6aGKuglumR49lZX6/UmyG6raFxGoIXTAzqpiFW+FFxNuSaaJmwh/9qYv4r0dkt2wWMCX30uUJ/JFb2nyS+cW8RzPAxbsQys+Z5OHvBLxE9sd3QEOW32NR7DTCPhiM5TnL69gICiV64oFU95FvavQ+z9aAafGQXyv9T7Caiyi/g4cc9GqmBD5zYpAJHpVJjOb23DyiKbsBG+iOQYMTLYLJryOYe6gCpAtC/BxKNH3qltgo+XJikxiw==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SEZPR06MB5590.apcprd06.prod.outlook.com (2603:1096:101:c8::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.31; Wed, 5 Jun 2024 06:05:04 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 06:05:03 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Thomas Huth
 <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH] MAINTAINERS: Add maintainers for ASPEED BMCs
Thread-Topic: [PATCH] MAINTAINERS: Add maintainers for ASPEED BMCs
Thread-Index: AQHatvqolU4XAGhvT0SQQvglvydWi7G4rJiAgAAANqA=
Date: Wed, 5 Jun 2024 06:05:03 +0000
Message-ID: <SI2PR06MB5041FFC3EB4A9FF5224064D2FCF92@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240605034413.1064845-1-jamin_lin@aspeedtech.com>
 <f766e1a8-38d5-4e99-a148-235bf00fce69@redhat.com>
In-Reply-To: <f766e1a8-38d5-4e99-a148-235bf00fce69@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SEZPR06MB5590:EE_
x-ms-office365-filtering-correlation-id: 473dd225-4759-4100-c26d-08dc85257133
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?ajhWOWdiTEhicnI1T2daMVZSSWtuOXFtYlF3TXBiM0Q2d2s3SE5sRnJDQjF0?=
 =?utf-8?B?RVVpV0hZMVA3K0ZJWmpzQWh1dERjajdlUHdTVFhFVjA0NWZlNjV1UjNIaE5Y?=
 =?utf-8?B?eHBvZTA4N2c0Qzg2U0IyTDVMUGZGWmExS2VjWEdoZjYzMndnTnJZeXRPRGZm?=
 =?utf-8?B?eHhXL293ZFhBZHhSM0Jydm1rT1pKRXVSb2hNL1NVSzdkeUVZVStDZTRTcE5l?=
 =?utf-8?B?S2ZTYjdTL2Z0eTkrREtIaGQ1YTBzdWtrWUhKa1R6TFM4bHhXUU5HUEM1NFpL?=
 =?utf-8?B?cmxBbmdnS1Nsa0gyYlh5dEZDZUp5aGpsSHl5MElCaDh4b2tZdXhSTFJNQTFi?=
 =?utf-8?B?NTBNRWlibXp6ck41TkxXMHFFaFI1OGJnREltTitOZEhNazBBME9JRXJ3VWRM?=
 =?utf-8?B?cUUxZzZtT2VaWi90Y3RlOGp2ZWFPYjZGcVlIc3d6TktFNzkwWXZPenNjZFo1?=
 =?utf-8?B?Slo1NS8yVXl3RnVvL3lyVkVDcGp4Z0R4WmV0WUk4ZjFDdzVuS1R2UDJIL1dP?=
 =?utf-8?B?dExPOWxJd1AxM2VYQjArbHB3Z3QxTjZZb1hKWmZXa3lGdTJQSVh5aGJsaUUw?=
 =?utf-8?B?MFRqNlkvWXNjR29HOEZIdGVqeEJkcVo4L21sZGhJY1EvcndGMXZmVVkzR1Zh?=
 =?utf-8?B?dkFRajN1aWJLaXJtcmpYTHpuOTVhN0NHRFJZM3IrL0QxUFBKSUREUk9iMEQ2?=
 =?utf-8?B?QjNxTnM1Y3FGZURiUHY4QkJGRGJ6QlBCSmc1bUtNcGlaajVqbnhVTUtpSmZm?=
 =?utf-8?B?cFJzL3BmWkt3N21IQmROQmlZb25UcG0xOStETEVvV0NmNGgvNnlWNmxPekdG?=
 =?utf-8?B?NU9vMFhLRkVrOWVsMVZmZXppd0tQYW9vVXRJUmp4aENSU2wzbjRLZVZHbTBG?=
 =?utf-8?B?bmZDNllmaWFVWWRkUXVkR3NEM09YYkxCeUdGZGkzWTI5dVZXTU1BeE9YaHpQ?=
 =?utf-8?B?aW4yeG1wTlRDczJkUlljUzF3cjdaa1BLM01HSlZyUE51SitSWTJkTU5RRU1Z?=
 =?utf-8?B?MEFtQkV1VFEvUG9kK0p1VzFrMEJsMFUwNDdydHlHWFF0VzhobzQrUlQvM2FM?=
 =?utf-8?B?MHE2aVZkRXo3SUljRTc0N2xVTUhUa2phUHVHeE8wQjJ5S2FRcVVtc0lUMDN0?=
 =?utf-8?B?YjlTaUZjSGRkcm11UlVMOFJGYkY0V2pZdVFpUFJMb05ENW8wVEZnLzQ3d2py?=
 =?utf-8?B?UThHZVpuM0xsem5rUVdyUGs5NWhVazVvZnd1eVV2dnhmY0hDTkg2dkk4MUJL?=
 =?utf-8?B?MDFiUWRxNDRQaGp0T3FnN01JMjhGdHJDR0JYbDV0VTh1eXduL3NXRm00dTM5?=
 =?utf-8?B?Y2RjZzliL1VSZTk4Z2dNRVVSZ0ZmWXhBcGlQRTNKeElia2VPZUl0cG0yUHAr?=
 =?utf-8?B?cXlZL3B0czAweXBGV0RobXgzcWd6WHBsemxRaXloVXlkUE05eUdrRGo4T2ll?=
 =?utf-8?B?dDZKcVlvV2ZBemlXa25FSGFkVTBhZlkxNERqSldWMFpCeXVVQ2YzcTVaZnBs?=
 =?utf-8?B?VE5UTmRUWWVvNnFnQUc1QXV4UkFWOXZ1ODl6ZUFFY2FFdXgyc1VXaWMvdlVM?=
 =?utf-8?B?Yldaa0wwREE5cG1YUThKSkNmNWY1azlFWWc1eFU1a25naTVLSXExR2RUYVpI?=
 =?utf-8?B?U2VkUUIzcnJNVU5nWURVZzBVK1M3Tjd6VmJwNzlyOFF5N1ptTWp3UmNaNDVk?=
 =?utf-8?B?cTJ6a0JzS01zdm1VUFpOYUQ5L0ltVEVTZmFwaFRWdTJPMG1MSFUwTDU5RDQz?=
 =?utf-8?Q?8aooKdUGrtTGDI7wO+ndcfxf+UNWSuR8NGnpIjp?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VU4rU1BSMFZSRzJyTEJyeC9xTlN5ZkZsUCs1RTJ5NVl1TTJ6alAvNUs5cVcx?=
 =?utf-8?B?QnFGOWpCQTZxMC9OOG5FRUhOUDdJL3IydGJOTFExdUxXcGRkN3J1aStmSlM5?=
 =?utf-8?B?S0QyeWoxa1lmQWI2OVJZRmNtaTMvK0NzbmlEZy8zK2NmWjRUU21GTXNkMDF5?=
 =?utf-8?B?ejY5WndTNDVVS3JrdEZVUGo1UzA2QmM4emR4NDY5UU9zc0RRVzFJUmRDSnVI?=
 =?utf-8?B?a2UyWkFQRmRVdExGWEZoN2p0RVNVYnF6TG9FdnEzTWovZ3dIczR3R3ROb2dN?=
 =?utf-8?B?ZEpMTnhTb01oejgxdnRJZW84NUQ2RE1HTVdoemJYVms3djl3eThSbGwrdW9z?=
 =?utf-8?B?dkdFR1pYVDhHeStjMURwWlJEdnhEQTBwWSt1UmtWMk5BeGlwaXhuNzJseXg0?=
 =?utf-8?B?cHpZaFZXM3E2SHRWUkI0N3ZibTNXalZCM3lLZ2JiNUtIb0JFQ2lyR0dLU2h1?=
 =?utf-8?B?VEpDYjFWeGhWOFlzb1VDTEdaR3FXTW1WVDhQSmtoaUpaUjZWaCtKamNFTkwv?=
 =?utf-8?B?NjRqT2FHc0VSdmUwWDdKZUpZVmVac0dqNVBXTkxRNUxubVNoY1JGd1hnYS9z?=
 =?utf-8?B?MVMyMDRmcDg0cGliVWYxN2VkT1I2cG04bXFkVnpEN0JZQzE3eld2aE1mWmdY?=
 =?utf-8?B?RlpZMDNjUmpnV2Z1ZWhkdXBoMDhRK2VGcEpuaWNUTU5LVUZSSUNXMWlGYllO?=
 =?utf-8?B?ZjdhRUl1N3dMa091L1Eyb2tlMUUza3dHRWJucmkrbVZhQ2ppVjI1UHErbjJN?=
 =?utf-8?B?S0JVeXNOOSs5dDNkSVJPK3luRU5jdDE2cUVsU095bkljT0lwREJHY1U1WEpt?=
 =?utf-8?B?MGpEWkYwNkxVWXFyQUhjck53Z3Q4ZXFjL2g3ek4xb0FiODRRN0xJTkxFc3Mx?=
 =?utf-8?B?VDRHaGdDc1ZieVE3ZXlmcGU0T1A2L2dBb1R3NmtlZXFzbGVQS1ZMc3p1UDFL?=
 =?utf-8?B?U1VXRHp6cjVKQk8xSTgxUDQrV2I2UXl3UXNkSHlRV2UxNGlSTW9hblhXYnpG?=
 =?utf-8?B?YjdqcTMwQ21uSU41M3kxY0lBMDRpSkc5a3RHbFpOVGtMOGJwbE5ERk8zeS9a?=
 =?utf-8?B?Qk9pcFE2MS95cE4rUXhzM2F1SkdrQXZLMjdIMXJCdlE1UCtCeU5yVUN0NXJB?=
 =?utf-8?B?UzZ5NTlDUkVnNWdNN3lpUHd3bW90U0RLVTQxbXh6REsxVEFxb1ZCenpVM08v?=
 =?utf-8?B?YkxqeHhoUitNR2MrQmcraCtuRGxIU1FEZDhIZzhWUUtDRUNhUVpqS3BkL3Vx?=
 =?utf-8?B?STZGWHFkUzNwK00vK0ZNZDV5U2luZldrMnpadVJKeWszUG9mN2FrVm03Nnhj?=
 =?utf-8?B?Q3lWWFdhT1NzU0xqWWFoeUdWV3l4TVE0R2FlV2pKaVl1Mm5zNTBqSTRsNGRC?=
 =?utf-8?B?Uy9VWWF1MUVtck9BZXZwS3N4VTVMTEdzaXArTjRDOVZQQzc4VU5xSmgzc0E1?=
 =?utf-8?B?WTFhNG90b3FnZTFMdWJ0dFU1WDJGMUJKSnErb2pTU1RTUFVCa2ZLUXh4ODQr?=
 =?utf-8?B?am90M2RqSFRYZTU1OFFFU09GWlYwNUNRTFRXamc5emxveHRERnRWOHplZW5a?=
 =?utf-8?B?dDZMdlFrOW1ObURVNVlCRGlUTjl2ZHk4Y1BwWGRTUXRNbkRvRk9ucTZsTUNm?=
 =?utf-8?B?WnlsbmdlQ1FET1hzczdhbUNkTGlmZmFRajVBOHVWOEJ2bzIvZ29yK2phRFZ2?=
 =?utf-8?B?TW5yNXNYNGNEUWIzYTBCY2NxNVFSL0kySGhka0g0T1ZQSW9mRWV1MW1NUUl0?=
 =?utf-8?B?eXFVSWxRUzl2VkxrdXZDMzlFNXg1Sm9wc2ljWDlXZXpiRzNsRi80UWRrOTgx?=
 =?utf-8?B?Rkd5aEc5bjJNdnYvL1FqeSs4eUw2K2VETExMZmdlTTArdGx3WmxrVE9MREc3?=
 =?utf-8?B?NXpxaC9LUE1GWng2RUpwRzdYSktQWlFLeVVCRnpidmxrOFUxL2tKbnFmbFIv?=
 =?utf-8?B?ZTZGRDVEaEFKVG9YbS9PYkh6MEIrM3VOYm8xaUxSaVhoTkI0ZS9aYzl0VGx1?=
 =?utf-8?B?a2RFcHY3elRKcUNGNUI2TmFpRk5YUytCUVpUbUQwR1QyaHkzVFRPTXV4R0lj?=
 =?utf-8?B?SGdqYnEzRmErMVhQSit0SXVpb1lPamJod29BN3J4bE95S01lR3E4UjBMSTNl?=
 =?utf-8?Q?wqOAPOFMYK/l5Q+0eGj1w3ff/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 473dd225-4759-4100-c26d-08dc85257133
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 06:05:03.9169 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2FLPs75u8TZSJ2TGhmbXCPzjTqD6JWIDps5SdHur7M8tT1tRaQvoewoya7mPFVjM3goILSNgnMOsM9VVgylCgJCBRK+Xf7c8Ahkl9RHqw0s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5590
Received-SPF: pass client-ip=2a01:111:f403:c401::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SINPR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

SGkgQ2VkcmljLA0KPiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+DQo+
IFNlbnQ6IFdlZG5lc2RheSwgSnVuZSA1LCAyMDI0IDE6NTggUE0NCj4gVG86IEphbWluIExpbiA8
amFtaW5fbGluQGFzcGVlZHRlY2guY29tPjsgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kNCj4gPHBo
aWxtZEBsaW5hcm8ub3JnPjsgVGhvbWFzIEh1dGggPHRodXRoQHJlZGhhdC5jb20+OyBNaWNoYWVs
IFMuIFRzaXJraW4NCj4gPG1zdEByZWRoYXQuY29tPjsgUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5
ZGVsbEBsaW5hcm8ub3JnPjsgb3BlbiBsaXN0OkFsbA0KPiBwYXRjaGVzIENDIGhlcmUgPHFlbXUt
ZGV2ZWxAbm9uZ251Lm9yZz4NCj4gQ2M6IFN0ZXZlbiBMZWUgPHN0ZXZlbl9sZWVAYXNwZWVkdGVj
aC5jb20+OyBUcm95IExlZQ0KPiA8dHJveV9sZWVAYXNwZWVkdGVjaC5jb20+DQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0hdIE1BSU5UQUlORVJTOiBBZGQgbWFpbnRhaW5lcnMgZm9yIEFTUEVFRCBCTUNz
DQo+IA0KPiBPbiA2LzUvMjQgMDU6NDQsIEphbWluIExpbiB3cm90ZToNCj4gPiBBZGQgQVNQRUVE
IG1lbWJlcnMgIlN0ZXZlbiBMZWUiLCAiVHJveSBMZWUiIGFuZCAiSmFtaW4gTGluIg0KPiA+IHRv
IGJlIG1haW50YWluZXJzIG9mIEFTUEVFRCBCTUNzLg0KPiANCj4gTGV0J3Mgc3RhcnQgd2l0aCBS
ZXZpZXdlcnMuIHBsZWFzZSByZXNlbmQuDQo+IA0KR290IGl0LiByZXNlbmQgDQpUaGFua3MtSmFt
aW4NCg0KPiBodHRwczovL3FlbXUucmVhZHRoZWRvY3MuaW8vZW4vdjkuMC4wL2RldmVsL21haW50
YWluZXJzLmh0bWwNCj4gDQo+IFRoYW5rcywNCj4gDQo+IEMuDQo+IA0KPiANCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IFRyb3kgTGVlIDx0cm95X2xlZUBhc3BlZWR0ZWNoLmNvbT4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBTdGV2ZW4gTGVlIDxzdGV2ZW5fbGVlQGFzcGVlZHRlY2guY29tPg0KPiA+IC0t
LQ0KPiA+ICAgTUFJTlRBSU5FUlMgfCAzICsrKw0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5z
ZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5F
UlMgaW5kZXggOTUxNTU2MjI0YS4uMzk2NTFiZTQ2Nw0KPiA+IDEwMDY0NA0KPiA+IC0tLSBhL01B
SU5UQUlORVJTDQo+ID4gKysrIGIvTUFJTlRBSU5FUlMNCj4gPiBAQCAtMTE1OCw2ICsxMTU4LDkg
QEAgRjogZG9jcy9zeXN0ZW0vYXJtL2VtY3JhZnQtc2YyLnJzdA0KPiA+ICAgQVNQRUVEIEJNQ3MN
Cj4gPiAgIE06IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAa2FvZC5vcmc+DQo+ID4gICBNOiBQZXRl
ciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+DQo+ID4gK006IFN0ZXZlbiBMZWUg
PHN0ZXZlbl9sZWVAYXNwZWVkdGVjaC5jb20+DQo+ID4gK006IFRyb3kgTGVlIDxsZWV0cm95QGdt
YWlsLmNvbT4NCj4gPiArTTogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+DQo+
ID4gICBSOiBBbmRyZXcgSmVmZmVyeSA8YW5kcmV3QGNvZGVjb25zdHJ1Y3QuY29tLmF1Pg0KPiA+
ICAgUjogSm9lbCBTdGFubGV5IDxqb2VsQGptcy5pZC5hdT4NCj4gPiAgIEw6IHFlbXUtYXJtQG5v
bmdudS5vcmcNCg0K

