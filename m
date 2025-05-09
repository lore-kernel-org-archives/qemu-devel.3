Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4922C3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 06:50:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDHYX-0000LZ-4C; Fri, 09 May 2025 02:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uDHYS-0000KS-QE; Fri, 09 May 2025 02:49:56 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uDHYO-0008LW-3A; Fri, 09 May 2025 02:49:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=am5SzyBow/oJgjmeDLI5yo7il8GTycz/VJPNKC6fe1aUW5U/BdT1E7a7+wRZ3BvYSZ3I/x0n8HZ16Lu8vV8XxJHrNe7Mn5zX2KUMtiZDo3gCfhwaqs8FJ7Li261fQQAUEyKyQZwF989+uOsg0Iup2auiP8xyhX+VsODizCpcYcwdKJ3s8Zm/TQaleguIcbItSuwUH69nk9txmvRpLyDwoN6ip1TstOQ9Y5U5z0PXm8OFZYr1jt3dTMk37ezAqBh+uumtuJcPBqJymmCMJ+wuNW8YBgF6qs1/v1LPAEq4uISNNr9qkPwev3YzM9Bb4yGa95b9JX7+MsVc5yj3YVb79A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HedjMp6O1MdgYWuce8/LckKjgqg92x8sKr1+PTFnyt8=;
 b=ZZkzcvStw4pB4QhLWFRThcDI069UHaWVjHeYmqrzyPvLeVRIvGmETFxa+N3+K78w0Mvz7PAJMmesyLIsMLvmeyzcpXzlfNpChwA2vOJcKwMwKsOTnpuLNYqa0w/CG7sTRlgtPNWblhX7a3a0uS01OVp7H8wY7VPFATTnTuEAkbcD9W9FcHBSHErglcH8bxPB9y3J1sP6EmGpSKnCFkPn/BbOST/rJUocrG0wTanc4eeO+nBMlKPKbsxsCSdIkYqJ4/f5J8o5tIDb444tjYHqTTWwEPi0PZi0W7kqM9gHKTF7GUK7WuTCVlizmWXRFv2lL1f3tVoRHm5r8itzEa8nfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HedjMp6O1MdgYWuce8/LckKjgqg92x8sKr1+PTFnyt8=;
 b=ohx2F+rUQtDgTmkVgziumNGVMlaUPOlOQf5alBpH+3P/AQ92yKSY6oiAwvMGYwzWtohPJFaWOj4GqBonc3K1CIu3EDA8K0ISnGbjvxJ2O22R57ZN1MmoxmBhhpwHtvU0YORlSEMOVQKeLWh9G5HDE2NH7ObzEe7cLGEugEyn1cAqCgTizTCA30HoJG4cc1vGMDTL7zxSsvt6PmaEm3Gg2O+Z1anMuKzND6u0NWrSFc3lao10LlcK1uJmTwQFFkwcFofUfMUrNemO5/cgf5ZPAJADvXnWJIxRq97qKMDszl1hF+FcYgv+GCAhWriYoH0Pl0wIC1g5jfS+NEnTWjkerA==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SE1PPFA7A817EB8.apcprd06.prod.outlook.com (2603:1096:108:1::424) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 9 May
 2025 06:49:42 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.8722.020; Fri, 9 May 2025
 06:49:41 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1 04/22] hw/misc/aspeed_hace: Update hash source address
 handling to 64-bit for AST2700
Thread-Topic: [PATCH v1 04/22] hw/misc/aspeed_hace: Update hash source address
 handling to 64-bit for AST2700
Thread-Index: AQHbmkNUsqayQma1L060bzfBJMBRWrOO5g4AgDs8pzA=
Date: Fri, 9 May 2025 06:49:41 +0000
Message-ID: <SI2PR06MB5041CE30FA872B5909DAC24EFC8AA@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250321092623.2097234-1-jamin_lin@aspeedtech.com>
 <20250321092623.2097234-5-jamin_lin@aspeedtech.com>
 <0cfb7e37-8347-47f5-8cbf-d8b88fc7312e@kaod.org>
In-Reply-To: <0cfb7e37-8347-47f5-8cbf-d8b88fc7312e@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SE1PPFA7A817EB8:EE_
x-ms-office365-filtering-correlation-id: 34c26a8f-2823-46d4-6bbd-08dd8ec5acff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700018|921020; 
x-microsoft-antispam-message-info: =?utf-8?B?Wkp6bUZQOEFqb0FhV1N4c25tbGlSTSsrMkxvdnpOVjRSbEJiMitIbFU0T0lO?=
 =?utf-8?B?cXBQSUtrMndWRysxQi80NHJoSHlzTVBtN2VsK0FkMkdPWmZzZWNaODQ4ZFV1?=
 =?utf-8?B?MmN4VDk3REMxZGF3eVRUUFlZN3c1N08zOHVVU0tFVzZqV1hzOXl4UGIzMFU2?=
 =?utf-8?B?UWdJRWJrQ1dnR1V2VGFQSUU5QU15TkNDUzNNL3Z2YmUxZ2RTSkplZ0Vod0JP?=
 =?utf-8?B?UFMrY1N2czkrZU4xNEhldFoyK1ZCV3dGS29aRGx2NEtYUHFDM2Fnd3A1YVFo?=
 =?utf-8?B?YjNJdkZUZGxmczF1ZFRxdDlVajlFYlFJWE1BOXlEd1dFWjZLRHBBOTBYNWMv?=
 =?utf-8?B?K09BL2NNaVNVWWR1K041cVJPTmRnRXRuc0MzUy9XUUVBMjhoT0FNbW1obEJQ?=
 =?utf-8?B?OUZSdWtsSVlrV0Z0RTNaWGxZNEdyZ3lsa09NQzJ2RG93aEU0bU1wQmJ2THpN?=
 =?utf-8?B?VVk0YjJJSjhJRjNGemlSRWdkSmdTUC9NRXQ0VlcwWU1ZMS9DbWlpek9heGQy?=
 =?utf-8?B?Ni9kRVdncjFZdS9jSjhyR0V3angrWDVkS0lwMmt6ZWFNeGlyRERab3Y4Smp1?=
 =?utf-8?B?UGxLOXhMRFBBNWhGQzkvbXl4b0ZHV0dCWngyM1NYRWpyVmVXMEE0MUdJUEd0?=
 =?utf-8?B?VlhlV0FZU2t5c3FjV0MwTElHcEduTGtDdUVsa1Bvd3RJeE1LaW1XTTdqSVhX?=
 =?utf-8?B?RnFWRjZ5T1RQenRvbHJ5WStBVFYvZ0tacjhQRktaYVNUZFdXUktuSnRJb29k?=
 =?utf-8?B?cFFYM3hCOTdFRFg5ZTJubzk1NmpROWxPV3hzU2UwQU5kNEp2VEhreDkvazJl?=
 =?utf-8?B?aGdWZ3lYNzlzd0EvZGN0ajZwYm8vblV0Z1pKSy9lUThoNS9TQ3dnV0QyaXBI?=
 =?utf-8?B?YVFzT2Ywb2hBTDBqajVuT0pBcmZtRGMxOG1TemI4eHNWUTB6bEpzUTUzS1F2?=
 =?utf-8?B?NzZlcS95RlRqYkJpK05xMmNhREZnTFZLa3lzS05lRDIvaFk0M0RGU3ZwVmcy?=
 =?utf-8?B?bzZBWTNDUEZFZU5zZ0VTUTFIc3AwVjFzYmFJd0Z2VWJhK3lhQm1vU21TVWty?=
 =?utf-8?B?bnlzMXNoR05nczVOSUpwSEd1em1UY2ErWmhTNWQxdmduMDhiVkREUmZWeFh3?=
 =?utf-8?B?V2lwWVlDM1hpNDR0WHk0akRtRWlhV3VwL2N5RjAwR0QwVWtnVDNlL2RjTVZW?=
 =?utf-8?B?d1FPVVkvWnNYWjhPblU1emRzdU9NbXdyYVkvL05WRm5PK0plUk5uZDZNVXR4?=
 =?utf-8?B?dUtvNkU4T3ZkdHM0OTZ5RjhScVRHblIzYXRabnhneVJwSmZxLzlSWmp1bW5l?=
 =?utf-8?B?VFhPdzVROUxYYmNtbllXbURBZUI4MkxaaDlzRm5WOFMvMXdlU0Rpck9YdktL?=
 =?utf-8?B?UGFla3Q0Q1NiV3p5T2Jsd0cwUittVVFOanBqYUhrcXlqNXR3UW80ZWpxaEVC?=
 =?utf-8?B?VlVGKzN1ZXZ6RngyaGhCOTRiTmlsSlhsVTBiZkFNdjdrM3AyRGRpcSsweFFw?=
 =?utf-8?B?eVB3cEVUbTBVaWJtS3h4L2RTV3Q3Z2J1Q0dYaVJQdkhxd3plTHMyMUFZdEpj?=
 =?utf-8?B?T2VoMTVHOVovWGMvVk1wTitQc1orYzd1SXBLYzNmZ3VNcUJ2RHBkeFYyejFl?=
 =?utf-8?B?TkRUcEZqM3hSNDJVTmJCY0ZEcWhMTGhFMzgydmJIWHFJV256MytRMldocFJ6?=
 =?utf-8?B?WGh3Wk56N0VKVnhabkF3RldTcHFSVTZ2MG41WVk5NTVpNzFEQkVkaSthUmhK?=
 =?utf-8?B?Kys1SWFIdlVjeDNwK2N5SU4yeDNaSkVhRlhtUzdGcHM5YmdLSFlIcVdzbVZJ?=
 =?utf-8?B?bFlwSEdHY3BjQUk2Wk9oQ2N6dXhCWkwrSHFhY2swVWszaDY4WnU4Y2t0TXZi?=
 =?utf-8?B?a05id05BcHQxc3JialpTZnNHMDA1R2lUUVhJLzBEblVvVnY5ZllpcjR1Wk44?=
 =?utf-8?B?VWIyVmRLb0J3OHZoRldrSHowQ1R4UHVyREhTQnZxZTluNUN4UFkydkRmTTVv?=
 =?utf-8?B?VS9YVlorei9RPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SzJDeTNqQk5LdDROUkxaMUhIZnNsYitXc251N2EraFkxWFprdThuREVjTEJt?=
 =?utf-8?B?aHlCMjBUYUVWTndVWHFodTMvVDZ2dlNSWHlLeVJVbEFVYVQzK3hvK25VMGtE?=
 =?utf-8?B?MkdVemI2UUJGMWxIQmpyd29BVVdpWDNrSWNKWlJaaVhXcmdoNU90TG15TGRi?=
 =?utf-8?B?OEo2dmVEa0gyR1hwV1plS2xFVkd4VnU5NUlmYWdVYXV1Yk1URTRtNVNSYk1z?=
 =?utf-8?B?azhZSzVua1hVMjVJc2RLNVhLYVpDdFhRaVgvWWx0alRTbEVjRFJqMmZXVEZR?=
 =?utf-8?B?MnBua3FRSmhoYTB5Q2Vyd0ViSDVzSXhVb28zd0VUdVJVK2tNdXpHNHZTTEFQ?=
 =?utf-8?B?aTFGU1dua0JDaTQvc1JoUkVMWVU0N2YvKzEzWklyQUpYRjZrazVMZFdBZ2Jo?=
 =?utf-8?B?SDRvOXNxNlp5cmtraVFEWkcwdkJKUTdYSzBxb2VMRDd5UUVSNmdET2krcDlO?=
 =?utf-8?B?UnM4eFFQK3ljQ0lrQnh3bWQxdHIyd001K0Ewb1V4QmNneGIxeTZwVVVvdFJp?=
 =?utf-8?B?eWtnaVRVOXFDYkJGVStWV3U1bVZCVDFOYmQzS3Z1bk91SWZqVFFEM2pFOVRJ?=
 =?utf-8?B?R29NbGNkZFhYTlNncURDdy9hSldzcVRibDBYZ2ZOV2p0aTVlUnkzMHBydWJC?=
 =?utf-8?B?ZFZxNVhFYm1nS1g4MzN6VXN6a1FMaDNWZ2ZhK1pydXRQR3ZKaE5mcU85N2pI?=
 =?utf-8?B?bm5BVVNiMGlmMTRjTFkwRVdWVS9WYTZmNDErRTJkaDF6dGhnZlV4Q0RDVExy?=
 =?utf-8?B?V3FkcXE4N3M2SHJIRjJTaDNKemlWdUJMWCs3d1Z3TlVaQmVuR1BsQ1gxWTRW?=
 =?utf-8?B?ZkV2YlhkcnJzK3FIcXdKaTN4ekV0TGgzYXh6TjhOTWE0c01RbnpMRVo0eCt1?=
 =?utf-8?B?Z25FNUEwd2o2Q01QZmF2eUl4Y2Y0QWtHQ3dQdDkwa3V5WXBMdTlOanZtSTRP?=
 =?utf-8?B?VUk0bnVQVll0UGFIY0t4WVhxYmJRZU8yTGFITnBZT2V6bXJhVkRqNWovbEZn?=
 =?utf-8?B?bTBVTEtPUVh1TVRQNmtocklGdmYxRlRZR3N6Y3dIdnBWNk0zelVSZzNJK0lp?=
 =?utf-8?B?RWNWUUNFeCtlaXFxOUJYZHFtK0ovdmNsaUd0RFUwTEtUK1pRMHp0K3Zlem0v?=
 =?utf-8?B?RWszcVIrR05lL2R3SVl1UmNXWHNqTU56eFF0MklPTWxkTEZnQkUzRHlZTWhP?=
 =?utf-8?B?ZHJ5c0p1TVR0ZmR2QjFQV2FqUTRXSnVjbDV4SExMOWp0STIrSFh6RGE4U012?=
 =?utf-8?B?WGZ4VHZuWWVEUytCM1J0N1BRSUNlRk9wMUVIVGQzL3Q3eTVLVkdrNHR3a2xZ?=
 =?utf-8?B?NlpudjlhU0hEZ0cweUlIZTR4SW5mWTlyRkxGVnpDaVd1Z3FoUjlmUldOZDNF?=
 =?utf-8?B?VTlydEJwSzZaV0ZscjJvNVQyMjF5OVNlTkhiZUtHd2JqU01hb3RDQmgvWE4x?=
 =?utf-8?B?YTNMcHZGd2FxSU00UjVFYnNOQU8rRTJkQW9wRzA5dllaTTc1cVp5UlNkcGZ2?=
 =?utf-8?B?ekhiT0pGRGUwZjNhZW5aU2QvbEFSTnlPZHVTTno3UmFZcGUrcUdIZjVHd1ZG?=
 =?utf-8?B?TDRnOVQxM0FzUjFkZzA0VVhyQTB4ZUtpZ2NYajhmNXZrWFdtdkU1TDhuWmwz?=
 =?utf-8?B?ZlhpTEhTM1YwTE9SMENpWnlLQk5lU0I3UnkyaDN1VzdFalEybVVzeHJjU0pl?=
 =?utf-8?B?Ti9aQnBCYWVoVmVzTmxWeUhIcVJWdzNSWlpHSU1GT1B2UEVlSnpKQU1URTgw?=
 =?utf-8?B?L3ZNMFlBNnhmK1ByOUVwcE9MVTJ1cnhMWmZUSGdPbEQwZVorWTkrdE90NG5r?=
 =?utf-8?B?MDdSamMvTFIvOWNLRjROZG4yK1BmNk1pbDEvdVN4NGI1ZDVnOVBiVEw0UnJj?=
 =?utf-8?B?SnlucHFJRWNBckhKU2pmMGtVUHRkaHhqb0ZkWVFJZWx3VXd4Tzg0V0JHOFNo?=
 =?utf-8?B?ZE1MR0tvSDN3MnIrOEhCcFI1aUxVM1RyQXBQTVFZVDZWNENHWm4vZzRMU3NL?=
 =?utf-8?B?MnlCOVZnK0RlRGxzVUtESzZGejdob3ZGc3YvS1N6TktOc3JuR0VzU3N2eEJG?=
 =?utf-8?B?TFlJaU5xVVg4TUV5MHBKOVlVWkIxWEVHRXVxU2o5OG83MktUbFpVYlRvUzZJ?=
 =?utf-8?Q?OYbvy/yPx2c3f08eDyAydyBEa?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34c26a8f-2823-46d4-6bbd-08dd8ec5acff
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2025 06:49:41.8573 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cDfY0Zo5z8G/3Y1tLhc9rMCcoqkdef+Ovuk2qD+oECWBcu1hDIbFrKCTTnOo1N+NMMqhfXd+LrZmq0fOAL9AbR7Hw4pG8ngLfbQGuBHcetY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1PPFA7A817EB8
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMDQvMjJdIGh3L21pc2MvYXNw
ZWVkX2hhY2U6IFVwZGF0ZSBoYXNoIHNvdXJjZQ0KPiBhZGRyZXNzIGhhbmRsaW5nIHRvIDY0LWJp
dCBmb3IgQVNUMjcwMA0KPiANCj4gT24gMy8yMS8yNSAxMDoyNiwgSmFtaW4gTGluIHdyb3RlOg0K
PiA+IFRoZSBBU1QyNzAwIENQVSwgYmFzZWQgb24gdGhlIENvcnRleC1BMzUsIGlzIGEgNjQtYml0
IHByb2Nlc3NvciwgYW5kDQo+ID4gaXRzIERSQU0gYWRkcmVzcyBzcGFjZSBpcyBhbHNvIDY0LWJp
dC4gVG8gc3VwcG9ydCBmdXR1cmUgQVNUMjcwMA0KPiA+IHVwZGF0ZXMsIHRoZSBzb3VyY2UgaGFz
aCBidWZmZXIgYWRkcmVzcyBkYXRhIHR5cGUgaXMgYmVpbmcgdXBkYXRlZCB0byA2NC1iaXQuDQo+
ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNv
bT4NCj4gPiAtLS0NCj4gPiAgIGh3L21pc2MvYXNwZWVkX2hhY2UuYyB8IDggKysrKystLS0NCj4g
PiAgIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvaHcvbWlzYy9hc3BlZWRfaGFjZS5jIGIvaHcvbWlzYy9hc3BlZWRf
aGFjZS5jIGluZGV4DQo+ID4gNGJjZjZlZDA3NC4uOTc3MWQ2ZTQ5MCAxMDA2NDQNCj4gPiAtLS0g
YS9ody9taXNjL2FzcGVlZF9oYWNlLmMNCj4gPiArKysgYi9ody9taXNjL2FzcGVlZF9oYWNlLmMN
Cj4gPiBAQCAtMTU0LDcgKzE1NCw3IEBAIHN0YXRpYyB2b2lkIGRvX2hhc2hfb3BlcmF0aW9uKEFz
cGVlZEhBQ0VTdGF0ZSAqcywNCj4gaW50IGFsZ28sIGJvb2wgc2dfbW9kZSwNCj4gPiAgICAgICB1
aW50MzJfdCBzZ19hZGRyID0gMDsNCj4gPiAgICAgICB1aW50MzJfdCBwYWRfb2Zmc2V0Ow0KPiA+
ICAgICAgIHVpbnQzMl90IGxlbiA9IDA7DQo+ID4gLSAgICB1aW50MzJfdCBzcmMgPSAwOw0KPiA+
ICsgICAgdWludDY0X3Qgc3JjID0gMDsNCj4gPiAgICAgICB2b2lkICpoYWRkcjsNCj4gPiAgICAg
ICBod2FkZHIgcGxlbjsNCj4gPiAgICAgICBpbnQgaTsNCj4gPiBAQCAtMTc3LDcgKzE3Nyw4IEBA
IHN0YXRpYyB2b2lkIGRvX2hhc2hfb3BlcmF0aW9uKEFzcGVlZEhBQ0VTdGF0ZSAqcywNCj4gaW50
IGFsZ28sIGJvb2wgc2dfbW9kZSwNCj4gPiAgICAgICAgICAgICAgICAgICBicmVhazsNCj4gPiAg
ICAgICAgICAgICAgIH0NCj4gPg0KPiA+IC0gICAgICAgICAgICBzcmMgPSBzLT5yZWdzW1JfSEFT
SF9TUkNdICsgKGkgKiBTR19MSVNUX0VOVFJZX1NJWkUpOw0KPiA+ICsgICAgICAgICAgICBzcmMg
PSBkZXBvc2l0NjQoc3JjLCAwLCAzMiwgcy0+cmVnc1tSX0hBU0hfU1JDXSk7DQo+IA0KPiBJIHdv
dWxkIGludHJvZHVjZSBhbiBoZWxwZXIgcm91dGluZSB0byByZXR1cm4gdGhlIGhhc2ggJ3NyYycg
YWRkcmVzcy4NCj4gTW9yZSBjaGFuZ2VzIGFyZSBleHBlY3RlZCBpbiB0aGUgZm9sbG93aW5nIHBh
dGNoZXMuDQo+IA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcgYW5kIHN1Z2dlc3Rpb24uDQpJIHdp
bGwgYWRkICJoYXNoX2dldF9zb3VyY2VfYWRkciIgaGVscGVyIGZ1bmN0aW9uIHRvIGdldCB0aGUg
c291cmNlIGFkZHJlc3MuDQoNCj4gV2h5IGlzIHRoZSBpbml0aWFsIGhhc2ggJ3NyYycgYWRkcmVz
cyBhc3NpZ25lZCBpbiB0aGUgbG9vcCA/IFRoaXMgY291bGQgZG9uZQ0KPiBiZWZvcmUgbG9vcGlu
ZyBvbiB0aGUgc2NhdHRlci1nYXRoZXIgbGlzdCBlbGVtZW50cy4NCg0KWWVzLCBpdCBjYW4gYmUg
bW92ZWQgYmVmb3JlIHRoZSAiZm9yIGxvb3AiIGFuZCBvbmx5IG5lZWQgdG8gYXNzaWduIG9uZSB0
aW1lLg0KDQo+IA0KPiBBbHNvIHNob3VsZCB0aGlzIGFkZHJlc3MgYmUgYWxpZ25lZCB0byBzb21l
IHNpemUgPw0KVGhlIEhBQ0UgaGFzaCBlbmdpbmUgc3VwcG9ydHMgdHdvIG1vZGVzIGZvciB0aGUg
c291cmNlIGJ1ZmZlcjoNCg0KMS4gRGlyZWN0IE1vZGUNCkJ5dGUtYWxpZ25lZCBzb3VyY2UgZGF0
YQ0KQml0IDMxOiBSZXNlcnZlZA0KQml0IDMwOjAgQmFzZSBhZGRyZXNzIG9mIHRoZSBoYXNoIHNv
dXJjZSBkYXRhIGJ1ZmZlcg0KDQpUbyBlbnN1cmUgYnl0ZSBhbGlnbm1lbnQsIHRoZSAic3JjX21h
c2siIGlzIHNldCB0byAweDdGRkZGRkZGDQoNClJlZmVyZW5jZToNCmh0dHBzOi8vZ2l0aHViLmNv
bS9xZW11L3FlbXUvYmxvYi9tYXN0ZXIvaHcvbWlzYy9hc3BlZWRfaGFjZS5jI0w1ODMgDQphaGMt
PnNyY19tYXNrID0gMHg3RkZGRkZGRjsNCg0KaHR0cHM6Ly9naXRodWIuY29tL3FlbXUvcWVtdS9i
bG9iL21hc3Rlci9ody9taXNjL2FzcGVlZF9oYWNlLmMjTDM2Mg0KY2FzZSBSX0hBU0hfU1JDOg0K
ICAgICAgICBkYXRhICY9IGFoYy0+c3JjX21hc2s7DQoNCjIuIFNjYXR0ZXItR2F0aGVyIChTRykg
TW9kZQ0KQml0IDMxOiBSZXNlcnZlZA0KQml0IDMwOjMgQmFzZSBhZGRyZXNzIG9mIHRoZSBTRyBs
aXN0IChtdXN0IGJlIDgtYnl0ZSBhbGlnbmVkKQ0KQml0IDI6MCBSZXNlcnZlZA0KIA0KSW4gU0cg
bW9kZToNCg0KVGhlIFJfSEFTSF9TUkMgdmFsdWUgaXMgZmlyc3QgbWFza2VkIHVzaW5nIGFoYy0+
c3JjX21hc2sgYXMgaW4gRGlyZWN0IE1vZGUuDQpUaGVuLCB3aGlsZSBwYXJzaW5nIFNHIGVudHJp
ZXMsIGVhY2ggU0cgbGlzdCBlbnRyeSdzIGFkZHJlc3MgaXMgYWRkaXRpb25hbGx5IG1hc2tlZCB1
c2luZyBTR19MSVNUX0FERFJfTUFTSy4gDQoNCmh0dHBzOi8vZ2l0aHViLmNvbS9xZW11L3FlbXUv
YmxvYi9tYXN0ZXIvaHcvbWlzYy9hc3BlZWRfaGFjZS5jI0wyMDcNCg0KYGBgDQpzcmMgPSBzLT5y
ZWdzW1JfSEFTSF9TUkNdICsgKGkgKiBTR19MSVNUX0VOVFJZX1NJWkUpOw0KDQogICAgICAgICAg
ICBsZW4gPSBhZGRyZXNzX3NwYWNlX2xkbF9sZSgmcy0+ZHJhbV9hcywgc3JjLA0KICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTUVNVFhBVFRSU19VTlNQRUNJRklFRCwgTlVM
TCk7DQoNCiAgICAgICAgICAgIGFkZHIgPSBhZGRyZXNzX3NwYWNlX2xkbF9sZSgmcy0+ZHJhbV9h
cywgc3JjICsgU0dfTElTVF9MRU5fU0laRSwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBNRU1UWEFUVFJTX1VOU1BFQ0lGSUVELCBOVUxMKTsNCiAgICAgICAgICAgIGFk
ZHIgJj0gU0dfTElTVF9BRERSX01BU0s7DQpgYGANCg0KSG93ZXZlciwgdGhlIHZhbHVlIG9mIFNH
X0xJU1RfQUREUl9NQVNLIGlzIGluY29ycmVjdC4NCkl0IHNob3VsZCBiZSB1cGRhdGVkIHRvICIw
eDdGRkZGRkY4IiB0byBjb3JyZWN0bHkgZW5mb3JjZSB0aGUgOC1ieXRlIGFsaWdubWVudCByZXF1
aXJlbWVudC4NClBsZWFzZSByZWZlciB0byB0aGUgSEFDRSBhbmQgQ1JZUFRPIGNoYXB0ZXJzIGlu
IHRoZSBkYXRhc2hlZXQgZm9yIG1vcmUgZGV0YWlscy4NCg0KVGhlIFNHIG1vZGUgYWRkcmVzcyBm
b3JtYXQgKEhBQ0UyNCkgaXMgaWRlbnRpY2FsIGJldHdlZW4gdGhlIEFTVDI2MDAgYW5kIEFTVDI3
MDAuDQpUaGFua3MtSmFtaW4NCg0KPiANCj4gDQo+IFRoYW5rcywNCj4gDQo+IEMuDQo+IA0KPiAN
Cj4gDQo+IA0KPiA+ICsgICAgICAgICAgICBzcmMgKz0gaSAqIFNHX0xJU1RfRU5UUllfU0laRTsN
Cj4gPg0KPiA+ICAgICAgICAgICAgICAgbGVuID0gYWRkcmVzc19zcGFjZV9sZGxfbGUoJnMtPmRy
YW1fYXMsIHNyYywNCj4gPg0KPiBNRU1UWEFUVFJTX1VOU1BFQ0lGSUVELA0KPiA+IE5VTEwpOyBA
QCAtMjEyLDggKzIxMyw5IEBAIHN0YXRpYyB2b2lkDQo+IGRvX2hhc2hfb3BlcmF0aW9uKEFzcGVl
ZEhBQ0VTdGF0ZSAqcywgaW50IGFsZ28sIGJvb2wgc2dfbW9kZSwNCj4gPiAgICAgICAgICAgfQ0K
PiA+ICAgICAgIH0gZWxzZSB7DQo+ID4gICAgICAgICAgIHBsZW4gPSBzLT5yZWdzW1JfSEFTSF9T
UkNfTEVOXTsNCj4gPiArICAgICAgICBzcmMgPSBkZXBvc2l0NjQoc3JjLCAwLCAzMiwgcy0+cmVn
c1tSX0hBU0hfU1JDXSk7DQo+ID4NCj4gPiAtICAgICAgICBoYWRkciA9IGFkZHJlc3Nfc3BhY2Vf
bWFwKCZzLT5kcmFtX2FzLCBzLT5yZWdzW1JfSEFTSF9TUkNdLA0KPiA+ICsgICAgICAgIGhhZGRy
ID0gYWRkcmVzc19zcGFjZV9tYXAoJnMtPmRyYW1fYXMsIHNyYywNCj4gPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAmcGxlbiwgZmFsc2UsDQo+IE1FTVRYQVRUUlNfVU5TUEVD
SUZJRUQpOw0KPiA+ICAgICAgICAgICBpZiAoaGFkZHIgPT0gTlVMTCkgew0KPiA+ICAgICAgICAg
ICAgICAgcWVtdV9sb2dfbWFzayhMT0dfR1VFU1RfRVJST1IsICIlczogcWNyeXB0bw0KPiBmYWls
ZWRcbiIsDQo+ID4gX19mdW5jX18pOw0KDQo=

