Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9FFCC36005
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 07:55:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9JKX-0000S7-ND; Mon, 28 Apr 2025 03:55:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u9JKV-0000Qb-J5; Mon, 28 Apr 2025 03:55:07 -0400
Received: from mail-koreacentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::7] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u9JKS-0003rQ-Ag; Mon, 28 Apr 2025 03:55:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yZ+g5KkijV9juS+UbXo93kZNWJk7A8zMTcmxIRABtSIwwxVmMNwC+s8u9KcrR2NQC6RtEMQlV2m5WVcU23wy8SB1Z3LrseosgEcTLH/lKGTynZZK/R+fEnKS4biPm5gngK9yT81u2uK1Cwoht8irzrsu2/F+cymSyUSmungp6IKGkFXCofjz00DQhy+b2WKzfUSB3hooljYDI7JGef9YIWit6EuNboZsNQZDKIDydcR22CLM+AhKLwaaxqaYrAlu4Upc7oUbgXC1/ajHty7MJEPSC2WdtTtvNGU9pmzvu0whkSc+GFiIvnNKHkbxOKHgNh8ycq0JLgDYaPzkqc0H2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ey3xUgKsIJU89yFBPEtUwkI9hCeYWhhbNT7UHQnAIlc=;
 b=R43PXr9ZlQL5AcRez1G/txnmY9mX6n6UGfT2UtlgIkMeh9FitO1YiH7uTybptTWB6cKgVMoUCN0vOvX5Te9i8/BOkRwVVbPC3Q3bARbXLVwMZT6OZBfTP0Toa3dIwJ343iz0HQvGQnpSoW2hQDbHl4sNGcP7gJ2mS+OTPUBVr8eSzJXLzSUVFWOsO4778mtRCjuMyHGlv7F8fxEaAeeP2YvIj9J80YneGGFUJblUj1b0ljyILgJDgvEQmxC5HCTUDuyfWRmsSwqzpyUz2RjBafKbQVMO5r8ke5cbCnQfxie+ahKw4lJYBWrNu2vAGb0CRco+LNa7z1XyX5KC44s5yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ey3xUgKsIJU89yFBPEtUwkI9hCeYWhhbNT7UHQnAIlc=;
 b=YGO9sGUukN2y6VI2+yWKK4UlmmioJKpgzWXE192nPPHk8OKbRx9zq6eYId42HbA+fL8aG0slT+Pq414RM4jnCUMZzDJgwd6fkEJ8zbVjFVYU+kAluS2c36UmWU59fDHSpDmBteEJCSvSkh5SNdcDEecC09Gw6DNHt4FfTTRo9QtrT9X8LIc+USvcgRJ0RxP+ze1nVyf0zhTRCGR0T7A6sN9YgmuiLbPdq9brxNEUqox7YiHKLByxaosy4GIbnkiy9KWSZJJtG8IO1VQwoJJMegues8o4s7ex3aywV9rbt0hueanijmIh+alq7E5UY1nhqCLjyPOsYFBsvbdJBArPZQ==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SEZPR06MB6612.apcprd06.prod.outlook.com (2603:1096:101:187::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 28 Apr
 2025 07:54:49 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 07:54:49 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>
Subject: RE: [PATCH v4 06/10] hw/arm/aspeed: Add support for loading vbootrom
 image via "-bios"
Thread-Topic: [PATCH v4 06/10] hw/arm/aspeed: Add support for loading vbootrom
 image via "-bios"
Thread-Index: AQHbr0arWgH+5S4p6UW9XfH4aQxehLOuolcAgABZe1CAAPNLAIAA6amQgAfrtgCAAABHYA==
Date: Mon, 28 Apr 2025 07:54:49 +0000
Message-ID: <SI2PR06MB504102422034DBB6EA8CFFE4FC812@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250417031209.2647703-1-jamin_lin@aspeedtech.com>
 <20250417031209.2647703-7-jamin_lin@aspeedtech.com>
 <85a2947e-6909-4311-8b58-f9eb8045e76c@kaod.org>
 <SI2PR06MB5041D4AD25381C7D1D6A5C1CFCBB2@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <a4c178b6-7048-42d1-9e90-58ed87baf9b5@kaod.org>
 <SI2PR06MB5041756942DE834177DFF573FCBA2@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <53e66299-ba7f-404e-87c8-2952fb4d857b@kaod.org>
In-Reply-To: <53e66299-ba7f-404e-87c8-2952fb4d857b@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SEZPR06MB6612:EE_
x-ms-office365-filtering-correlation-id: 4a914ea4-b5ad-4537-861a-08dd8629f35d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RVdMQVZaLy8vMXJQaTVXMytaQjdQQlh2SlRKaE5VUC8xbHpGZFllVzBsYmlq?=
 =?utf-8?B?ZjF2eGY3aGNzcGhoV3FnS0VmVURzdWtPdG5IT0c5dmllMExYVkxMckt5d0ZU?=
 =?utf-8?B?WU13VnkvazkyRkQ1TjJ2UFJWNVMyWGI3YmJhUHM4blJGcENIZjZhaWFteWdr?=
 =?utf-8?B?WnNaKzh0MHhRMXV4Vm5waWRhQStGZDl6N3FlakFVYk1wcmN3MkZGa1NpbGxW?=
 =?utf-8?B?UEN4bGwwOSsrZmxvclJFaUVPTmxYRTR3L0JnUi9Pc3JmMGhHazVtRGQwNlY5?=
 =?utf-8?B?bW90WDVOYS84SEw3cHQrOERvblhXUjJhTmNEbkZFbm96Y0xvTW1RTHFPMU4w?=
 =?utf-8?B?eUxDSnRqamxKZk51YkZWbm5qbkoyL29aQW1WbStHWjl2NHpFMzVOU1ZwYVVD?=
 =?utf-8?B?TVQ2WkJtaHlkbkQ5ZXl4RWxtMUhqRmZGZ25WbHBINnE2UTNycFZDak5tcytm?=
 =?utf-8?B?OVJRZTAvNXZyR3Y0VVFHek9IcWZBZkI1QnNPajRyRG1JYVVvMEpJMVR3TDZx?=
 =?utf-8?B?d21UWWxtbE5kYTAzWGdsdVlwdFhnY24wSHFvZ2RKWStRL2RMaWFWZjl6NnpS?=
 =?utf-8?B?amxmSi9VQTNEVmRocnJWeExIY2FyN3QzUEl6VnlvMnUyVWYyZUE0bm5xbmdr?=
 =?utf-8?B?TUFqMi9NanRxcWJScVBVRWw3YnozVHRsbEZKVjlSdEpmLzY3WTNFbU90aU5N?=
 =?utf-8?B?ck4xOUF1eS9mUkJkam93T0VzazloSW1CUHViYkthUElkVG1tTXJrSSsxNk12?=
 =?utf-8?B?VDNvTTNLdmhmYndiblV1b0p2Ri9Za1ZNWUZWamZCMSt3NUthVDBiVnV4dnNp?=
 =?utf-8?B?RUYvRkp4ZG9pMTlPanl3Y0dZdGFRN2QydmRHRVBZUUJzTGdnQ1BvNGJmSlYx?=
 =?utf-8?B?d0kzMHVuWVpnNmpsWnN6eWdrQ1A3LzhYK0ErUjdON1g4bExMRCtYZ2EranFv?=
 =?utf-8?B?d2txYkQwU2lUY3ptUHNKKzFmTVNPdHZleklybjIzQi9hN1ZJMjRPVTBQeFcv?=
 =?utf-8?B?TENxSVk3OU9qaUZBU0txQkhxQy9HNWM5a0JteUF3THhwUEU2bGNETlhNcjJR?=
 =?utf-8?B?MmRUbFM4WlVZMm93ZXo3UDNaMGNXdUJJWjY4c1JoUm9WZUlWZk56S0hBZHRR?=
 =?utf-8?B?Z2NSL01IQW5KZlhjQVdEeWNBcHJBb1U0TEtKWlZqSlVaMDhxaGdwNHBqamEw?=
 =?utf-8?B?RDFNajRGUE53R0IrRTNDL2J1UDNHQzE5aG9wckJDNTZ5UjVpRG1OV3Y3a3Fp?=
 =?utf-8?B?TmFoK2FvNHhVNE05UnU1dGE2UnVQdTIxd1BDaFUrUWRTYzJrbGxUZlVUV0x6?=
 =?utf-8?B?SHF0QXFqb3p3MmdjM2xDTDdPcHhvbmY2RU1iTGcvR2xGM0JFZi9PM1Q4dWZW?=
 =?utf-8?B?RXlVdXp4ZDJubUpkczFyWXV0eUM2OTlma3phVVZROFJSRVEyOHJlN1dwNStL?=
 =?utf-8?B?N0M2MXFBQTdqSXgycUFWNVRaYUxHV1Jnc3djamJ0RTVVc2lxNzBDWUhGZEVy?=
 =?utf-8?B?NnYzNlhZV3ptb2o3ZDRpZ1k2ZDJtVFVvZ3hTVE5ZWHIxR3hPaVZocmhIa25S?=
 =?utf-8?B?LzJiTFdFT3JpOURENWFZS0dCek9DMnR4VEJxQnZDTGsrcGlUcXBweDBCcFh5?=
 =?utf-8?B?c1MwY1RXL3YxVkR3V0dhdWxnVFRFSkM2ZmY2dHJQWVZIWVNIWlNIWTlFSi9O?=
 =?utf-8?B?VUJ1cE5sUEd2VzdFWTRMVVh2MnJickk4Rzg5VCtydXp5bnlwb0lLcmdoY09l?=
 =?utf-8?B?Q2t6cm96cjBBc0tURXRuV09SK2xaVWgzMnJSVWJLSit1dzEreHQxVTZuajhv?=
 =?utf-8?B?OUQzZEpNZk9CZ3lEYlpwcE9icEZKa0p5Zmt2RDhPZ3prSFVCemtvVEwzSUs0?=
 =?utf-8?B?L2Nocm9yUDl6c1Fza3BEdzkyai9OVnI1MEg4Z0hYMHZJSEJWQWV4TzBKRDdi?=
 =?utf-8?B?QXFQZ0x1SnVESEYzUEtJckpkU2d6TGk2TzY4Rk9odDRJdjhPYUFvS29taDk4?=
 =?utf-8?B?Qmt1ZTVDcW5RPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWljaXlmbFRFNUFMSHkvYm5sQkxGTVcxbnFTN3JTVUJuWTJWM3FlZ3A3RUor?=
 =?utf-8?B?ZFA5eVFNTXIwb2ZtbkZyNjFERFRKOS9BM043enBuUDZnakkwWWY5dEova1hL?=
 =?utf-8?B?OElTZnNZY1FYVU5jbGp0TmZRdXl1Zm1lV2Q4Q0pVallCcjdNSXA5bFRkaVBy?=
 =?utf-8?B?bTlHbVBzOHdaSysxdmpGUmVLc1dHcVBNdTZqVnBzaHZJUnNyVDRISHY5bjdW?=
 =?utf-8?B?YXEwM0g5Z01rRlg0cjFwVmJ5cXZXMGllT2t2UmdxY3ltRXlpbHgwV2ZxYW9w?=
 =?utf-8?B?SjdRUU5maCtLSjhqUDIxeVRmSU9xYXFSajFCUHFLVmlsQm9CWDVpS0ovbWZW?=
 =?utf-8?B?R0N0d1RzcUxuWk5zQ1hrMGhBbEQrTVFBOHc0N2ZiZW9na2p1NEtBK2t6NXZV?=
 =?utf-8?B?ZENXdFVKQklxd0gzSGhSVkJkRXZoSjZyY1dKcTRydHhKTHVkeVRYSXYrNHdK?=
 =?utf-8?B?UnE2VVRGZktnR05uNm9qSnJ5Y1QzemVSVTQ2ZDhRNXUvOS8wMmJPaGRHQ25P?=
 =?utf-8?B?MVdRWHhJdWx1anFDbjk3TDBYV3c4ZnFZbDIxMENkUmJVMXN1cElDemRJVEo0?=
 =?utf-8?B?b3dNMFBlcG1rRzFTTytTQlEvbzdPa0RLQ0M2WFFVY3dKN2VHT2ZVaGVGRkdZ?=
 =?utf-8?B?QTFvcjdwZExvYUdvUUFnc2xpTG54NE9KYVExZTZTUU1QT1BYeDBpMjVZQzJ5?=
 =?utf-8?B?WDdHQlZncFhyS29zb29FUEh1NTBVa0lDWS94aXV3Z2o2YW54M01BYjVZaHc5?=
 =?utf-8?B?VCt5ZlZIeW9iQ3UwQkxaSXRLSFBhS3d4c3dIWk9wbG1SMWhxQm5kNUNPaFVa?=
 =?utf-8?B?YkgyRXNIb1JtaVBHNGRuNmZYMVU1QlFiZGNjWjQ4bTZVQTZnaU9ZOW5FaWpO?=
 =?utf-8?B?ZVVUTExWNVMwUDM2Y2wxcWR6VjRPOFdKQmxXSExSQjlXM0NIdkhEdkJ0anR2?=
 =?utf-8?B?ZGRYb0J4MFRsMmxoTCt0VE5yVFhMVXRVSWtOMVJNOFYyOGp3VWNNWW9TWSs1?=
 =?utf-8?B?N2hFZmlPTFY5TkJHOUx4Y0FiY0VaNXRoT0NBTnZBU2Y4SEc4N3NQV00rNzNZ?=
 =?utf-8?B?T25weWpQT1lnbUJjVWU1cEh4dVQycll1R0xhSnBSUWNsVGhtWDRGdDFrUGll?=
 =?utf-8?B?eHRPZloyRVBYWFRNZjFEdkhUMmtuVEpueXJ1ajlVY0VsSlVUeVpuam90WnFQ?=
 =?utf-8?B?L2d4NVMrd2JRbWVoZlJVUVQ5WHlnaGZnbzh2QlF0YUZVMlJVSXI5MGp1RFVX?=
 =?utf-8?B?M3ltcG9xQ0pEUjVuTktFWlBuS0gzNWpMN0pUa3IzM2FLOE5lbHlQckdFMGxx?=
 =?utf-8?B?VCs5TzVXMnZqeWZjdHd2YlpKMGVPRzBuUEhZMHdMREtHR3RxSTZTeVZGdGQ1?=
 =?utf-8?B?VzFOOGpmRndRUlNHZEs3K3ptUlcyWjE1UUtmK0V4bXcyY3RjWnJYOVNVSDlT?=
 =?utf-8?B?SmNSY3pXRUNzTDFpWWQ1QjJja1YxSlNURjluU3pRUnZVdkIvNnFkeVJTV2lJ?=
 =?utf-8?B?V3JRNld0MVhseTVTS25QQ09xU082bGh4U2hqWFJyVjQrT1VaeFZwNVhaTVll?=
 =?utf-8?B?ME0ydHloemJNbzBQTnlncllNZVdUOTRWQnJLNDdTcmdhZVRlZWpNbTd5SFlh?=
 =?utf-8?B?NElqTGJoVlplcUJWcnN0L0RlNkZUUUo3SkRWL3BrZDFjNkV1ZHBLM3g4cTBS?=
 =?utf-8?B?UnI1N1JydkF6aWwwbWZlQmVPUGVsbzMxcnc1MWc0NHVILzhFVktQNjc5VTN4?=
 =?utf-8?B?Mk4ydnZYQjY5NU83alBuSUUrSUx5ZEhYdGlIVmNUK1haemxWZWl3ZnA3bGtz?=
 =?utf-8?B?aGlpM3l3bEI4S0RUemVhOS9aVE4zQTBzcUZ4UmwrVnZaZi81cThhbE0yOVhU?=
 =?utf-8?B?VjhTemdvdklCRlhzZHFONk94QjhNblg1L1QyNzZ1VEZxU0VuZ3lHRjQ4dVhG?=
 =?utf-8?B?QTB3eS9raVRseEk5amk2RzNrNGR2dHRXRGxhbXV0TWZlLzZqMUdBM3VOc04z?=
 =?utf-8?B?MEVudkNqcWJNanhDNXhVZmdzb3h6dUlrWXRTbS9Gb0xaRHBqRkdGQmxOaE12?=
 =?utf-8?B?OHllRVVDc1FJTkdNMUJPakl0RzJQdE5uRGxVRTRMdUdMSkt3QWlaNk56SGdm?=
 =?utf-8?Q?2GZdG6go/MhKgo+XvbKO3Maq6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a914ea4-b5ad-4537-861a-08dd8629f35d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2025 07:54:49.0931 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YEJ4jgevaA28bAoyk4DmLQmB+eCDXwK4cY75RdaCnW2eVga/CDL+q/AVuwi4I6Uu0gLDxi6ODTaAWQXdAC+L2ffwaFL4U7GU40YcYJ0SXzg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6612
Received-SPF: pass client-ip=2a01:111:f403:c40f::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

SGkgQ2VkcmljLCANCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDA2LzEwXSBody9hcm0vYXNw
ZWVkOiBBZGQgc3VwcG9ydCBmb3IgbG9hZGluZw0KPiB2Ym9vdHJvbSBpbWFnZSB2aWEgIi1iaW9z
Ig0KPiANCj4gSGVsbG8gSmFtaW4sDQo+IA0KPiArIFBoaWwuDQo+IA0KPiBPbiA0LzIzLzI1IDA5
OjAyLCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4gSGkgQ2VkcmljLA0KPiA+DQo+ID4+IENjOiBUcm95
IExlZSA8dHJveV9sZWVAYXNwZWVkdGVjaC5jb20+OyBuYWJpaGVzdGVmYW5AZ29vZ2xlLmNvbQ0K
PiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDA2LzEwXSBody9hcm0vYXNwZWVkOiBBZGQgc3Vw
cG9ydCBmb3IgbG9hZGluZw0KPiA+PiB2Ym9vdHJvbSBpbWFnZSB2aWEgIi1iaW9zIg0KPiA+Pg0K
PiA+PiBIZWxsbyBKYW1pbiwNCj4gPj4NCj4gPj4+IEJhc2VkIG9uIHRoZSBkZXNpZ24gb2YgYXNw
ZWVkX2luc3RhbGxfYm9vdF9yb20sIHVzZXJzIGNhbiBwbGFjZQ0KPiA+Pj4gdGhlaXIgUk9NIGNv
ZGUgYXQgdGhlIHRvcCBvZiB0aGUgaW1hZ2UtYm1jLCBhbmQgdGhpcyBmdW5jdGlvbiB3aWxsDQo+
ID4+PiBpbnN0YWxsIGltYWdlLWJtYyB3aGljaCBpbmNsdWRlZCB0aGUgdXNlcidzIFJPTSBJTUFH
RSBhdCB0aGUNCj4gPj4+IEFTUEVFRF9ERVZfU1BJX0JPT1QgYWRkcmVzcy4gIEZvciBBU1QyNjAw
LCB1c2VycyB0eXBpY2FsbHkgc2V0IHRoZQ0KPiA+Pj4gYm9vdCBhZGRyZXNzIHRvIDB4MCBhbmQg
Ym9vdCBkaXJlY3RseSBmcm9tIHRoZXJlLg0KPiA+Pj4NCj4gPj4+IEZvciBBU1QyNzAwLCB3ZSBp
bnRyb2R1Y2VkIGEgdmJvb3Ryb20gdG8gc2ltdWxhdGUgdGhlIFJPTSBjb2RlIGFuZA0KPiA+Pj4g
dGhlIEJPT1RNQ1UgU1BMIChSSVNDLVYpLg0KPiA+Pg0KPiA+PiBTaWRlIHF1ZXN0aW9uLCBpcyBh
bnlvbmUgd29ya2luZyBvbiB0aGUgQk9PVE1DVSBTUEwgKFJJU0MtVikgbW9kZWxzID8NCj4gPj4g
aGV0ZXJvZ2VuZW91cyBtYWNoaW5lcyBzaG91bGQgYmUgc3VwcG9ydGVkIG9uZSBkYXkuDQo+ID4+
DQo+ID4NCj4gPiBUcm95IGRldmVsb3BlZCBhbiBpbml0aWFsIGltcGxlbWVudGF0aW9uLCBidXQg
dGVzdGluZyBoYXMgbm90IHlldCBiZWVuDQo+ID4gcGVyZm9ybWVkIGR1ZSB0byB1bmNlcnRhaW50
eSBhcm91bmQgImhvdyB0byBzaGFyZSBEUkFNIG1lbW9yeSBhbmQNCj4gY29udHJvbGxlcnMgcmVn
aXN0ZXJzIiBiZXR3ZWVuIHRoZSBSSVNDLVYgYW5kIHRoZSBDb3J0ZXgtQTM1IGNvcmVzLg0KPiA+
IEZ1cnRoZXJtb3JlLCBSSVNDLVYgaW50ZXJydXB0IHN1cHBvcnQgaXMgY3VycmVudGx5IG5vdCBp
bXBsZW1lbnRlZC4NCj4gQ291bGQgeW91IGV4cGxhaW4gYSBiaXQgbW9yZSB0aGUgaXNzdWVzIHlv
dSBhcmUgZmFjaW5nID8gU2luZ2xlIFFFTVUgYmluYXJ5IGlzDQo+IGV4cGVjdGVkIHRvIGJlY29t
ZSBhIHJlYWxpdHkgaW4gdGhlIG5lYXIgZnV0dXJlIGFuZCB0aGUNCj4gYXN0MjcwMCBtb2RlbHMg
Y291bGQgYmVuZWZpdCBmcm9tIGl0Lg0KPiANClRoZXJlIGlzIGEgQm9vdE1DVSB3aGljaCBpcyBh
IDMyLWJpdCBSSVNDLVYgQ1BVLCBhbmQgaXRzIERSQU0gc3RhcnQgYWRkcmVzcyBpcyAweDgwMDAw
MDAwICgzMi1iaXQgYWRkcmVzcyBzcGFjZSkuDQpUaGUgcHJpbWFyeSBDUFUgaXMgYSBDb3J0ZXgt
QTM1LCBhbmQgaXRzIERSQU0gc3RhcnQgYWRkcmVzcyBpcyAweDQwMDAwMDAwMCAoNjQtYml0IGFk
ZHJlc3Mgc3BhY2UpLg0KDQpJZiB0aGUgQm9vdE1DVSB3cml0ZXMgMHgxMjM0NTY3OCB0byBhZGRy
ZXNzIDB4ODAwMDAwMDAsIHRoZSBDb3J0ZXgtQTM1IHNob3VsZCBiZSBhYmxlIHRvIHJlYWQgMHgx
MjM0NTY3OCBmcm9tIGFkZHJlc3MgMHg0MDAwMDAwMDAuDQpTaW1pbGFybHksIGlmIHRoZSBDb3J0
ZXgtQTM1IHdyaXRlcyAweDAwQUJDREVGIHRvIGFkZHJlc3MgMHg0MDAwMDAwMDAsIHRoZSBCb290
TUNVIHNob3VsZCBiZSBhYmxlIHRvIHJlYWQgMHgwMEFCQ0RFRiBmcm9tIGFkZHJlc3MgMHg4MDAw
MDAwMC4NCg0KVGhhbmtzLUphbWluDQoNCj4gDQo+IFRoYW5rcywNCj4gDQo+IEMuDQo+IA0KPiAN
Cg0K

