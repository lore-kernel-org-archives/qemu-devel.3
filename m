Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 089C9C5B574
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 07:33:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtgz8-0004qx-Vm; Tue, 11 Aug 2026 03:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtgz7-0004qS-AS; Tue, 11 Aug 2026 03:33:17 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtgz5-00063u-13; Tue, 11 Aug 2026 03:33:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G3ODrSvvudVPU9Hx02tj+kDdZz3naPGEqHAkA1920K8uD3AzUpymIgGyfUgLUOmUjrjSJu7WJI+9AFGoNRon+2AqTtmXwTNnReBmgeUbQy6q+0WOPSwNPICU6dQ2/TlmNWtKTj5lA1lF4seM5oqQgIyeBQRP4NH4H1UhDLbA71NUQ41YZfa6ftjKvTxtODxex8XAiOJuAwQAb1cet+sHurr7eSyDo8pjBqBAurFDy3lKfLS0Gu5mOshuBmSbAGg5WpXw9hn0PGz30MOUZRMauRw+uKdVXM0xFGUxvHfIdNu/m/N7YZMzxnbdLADKzSf4Q37Xgq7lb38NPrlPuyUo7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XDHAFbCiCSZCEUSAlzc3mUalpC6ZzEOATIvkepLR50M=;
 b=BMMTo/loGBQ40XK0+50xgr3G86/e4X4Z2VsaC9lheoAzHFn/5vKx6dvcuxCBgJGk6bkEn7LUuLXm0+4UxfNSj55kZsnPJdOkPBCNBhMrfTYp3H/BJHKfl/FzdNJaLX+MWjdseZLRu4pR00Q7aaxt2NRSJZMtqBkBo2Uw6Tj//Q0xWCzECcTgaFms8xh4ZlB0UBKH3NpqeWBNy7tHG5+U9a2Yg+cxg4+8ddRhiMaqXdOPW9IjAUvO5RXC2HcZrELNKz8j1pQeoMuq9+IV4IUNThLhfCQ3HvXHK+uDdF4lc9TQS5uzHrVS5SLcUr3B9IMSUOcyBG5nA6AvskLfNXZe/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XDHAFbCiCSZCEUSAlzc3mUalpC6ZzEOATIvkepLR50M=;
 b=YAWppIC9xx8WdO0VslowU+7E0hJBKTc++FGPwbrb9eaeA+UPDnOemtWeTDw5s0kjsq/+xcVAIVdI532GveIb98YtmHrjA2Xd5JonfPvYdxKSxhcKejykaG+nwkPcn07Ny/G2O1TNJglZmxawyAYRn3v7eYAxzhRTnb2Alf/6cdJYJaiI3Lgdt0NX63qeKZvY4Z9Lfo9GlAIFP7fNnKZvhNV7LF2Q9u7X2bTGEvasglFtjvgRpqXbb7cVcoHR2vucDYIya2k1DT7fVdRT9FmOiB65zdAwvsktkvt37AUO6ymsd1lB0PRn7PlC0LNqSfr37+g0xobX44X/tncBIsWl3Q==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KU4PR06MB8364.apcprd06.prod.outlook.com (2603:1096:d10:7b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Tue, 11 Aug
 2026 07:33:05 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 07:33:05 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Mikail Sadic
 <mikail.sadic@ibm.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "ninad@linux.ibm.com"
 <ninad@linux.ibm.com>, "titusr@google.com" <titusr@google.com>,
 "jeuk20.kim@samsung.com" <jeuk20.kim@samsung.com>, "philmd@mailo.com"
 <philmd@mailo.com>, Steven Lee <steven_lee@aspeedtech.com>,
 "leetroy@gmail.com" <leetroy@gmail.com>, Kane Chen
 <kane_chen@aspeedtech.com>, "andrew@codeconstruct.com.au"
 <andrew@codeconstruct.com.au>, "joel@jms.id.au" <joel@jms.id.au>,
 "calebs@linux.ibm.com" <calebs@linux.ibm.com>, "milesg@linux.ibm.com"
 <milesg@linux.ibm.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH v3 4/8] i2c/aspeed: Fix DMA receive first-byte handling
 for block reads
Thread-Topic: [PATCH v3 4/8] i2c/aspeed: Fix DMA receive first-byte handling
 for block reads
Thread-Index: AQHdKPorKO2w75X7Hk2hEDT6Tbcn6LaYQlSAgAAsvvA=
Date: Tue, 11 Aug 2026 07:33:04 +0000
Message-ID: <TYZPR06MB49809554770467FE75ECEAA9FCDD2@TYZPR06MB4980.apcprd06.prod.outlook.com>
References: <20260810185748.1253-1-mikail.sadic@ibm.com>
 <20260810185748.1253-5-mikail.sadic@ibm.com>
 <9311015c-69a5-482a-99ed-93548a9f493d@kaod.org>
In-Reply-To: <9311015c-69a5-482a-99ed-93548a9f493d@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|KU4PR06MB8364:EE_
x-ms-office365-filtering-correlation-id: 8a14ece2-ea09-4a9f-681d-08def77ac831
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|23010399003|366016|56012099006|10067099003|10063799003|3023799007|18002099003|22082099003|4143699003|38070700021;
x-microsoft-antispam-message-info: 8WBp6PU8zjIOaQbhqX5scokCX9te0uoTQVAZu5CGVaUuTomDDZDGIOc/tSehoypjGpzKIhGjAhv1ivXwt7B9XXEjOUcLn+GVqQ/2Jwah+kgV82hRcUoBLirCeSKuZ6deQnBecwDMp0LJlfM3IuMGXBqjyGOK2sybZ1/N9G7Yr0cbOMMLK6I5KJ0NdBcDFsMWtecnrab09xaIAN47n0FZ33v8icyoxYHK2dOJphkXcqbhcqyd9f9bkb3hUy2fEQ9K6aUzwz7hyjV7Jb1gN4AqV/YMyX8RwHmRNvk/A18tUbqZY/lOjf5DeZ2DqZt4q5wuM5Ge5ObX0pp2j+5MYOEoiC2GEiQkAFBaig+YWUoDti0A1CN5ZMITId4EuYmy9/rhuSIHSdgpUqOeJjlckSNWCh0xcHSRMyEoixI6j5Q2ZBAfgVBL9zqNDowL/Ytebhadefe3ib4Cyf4p8WZ5Z3+BxLfFMZZ/5a2kG3CPItMlNYJIxjyoznqe0SXONXka9DG1AlhaKXTBetGhLz0zZgzbLhsasb5DqpLfTjwJ5jDKDedqIyheecvSGll2dv4wgUhJDjuPvZZji5b3b8qu3z0ZdXdBABkUz32/sdUcPlzXazOHpXzqLRjYrN48/CbtMaefQnOHX6lS45Vykcea6sJcKz/5Osy/o8kAfoWUINp5dvVeG2Dt4lFZX8a8yRA9HlmRNH6I2Qlf8G4rUbhx9OiUM4tBdxgRKCNvIXcKYvvZwR0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(23010399003)(366016)(56012099006)(10067099003)(10063799003)(3023799007)(18002099003)(22082099003)(4143699003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cnJQZnlqM1B3b1U2RnpkQUNQekVXeTlaaXFnTzRRUURQZjd0MHVEdVJOQTNU?=
 =?utf-8?B?OFpFWHJiMUFtMHZNQzMyREREb0ZEUUhtM2xBbkFqTjhXUThHaWNwVC9LZGkz?=
 =?utf-8?B?WFJ6M1dNNGN6R0xQdURkK2RSK3kzSitpMnJQUm1tM0YvVkFqMDRsdGt4emZ0?=
 =?utf-8?B?WWYxL2R1SUhiNXE0NTlOYk05Rkd5NDRnZW5pYzVBanlwUXlwa2tYb3grZVhs?=
 =?utf-8?B?aDgzbmVUTGN5NFowSXdnMEhlVFN0bGFjSmd6V2ZMeDZ4cDNLbm5hNEV2bmRK?=
 =?utf-8?B?WThqZXBvZHE4ZnkrRy9zSFFRVVpTdFB0OVhNQ0Rla1FRY2llVjJIVStLYUZK?=
 =?utf-8?B?SU9IaklpUVlMTVlOTVdWNXR2RXhHZTROMXNndUlIbU05cjBlelo0RGpsc0tp?=
 =?utf-8?B?SHo5YjBKeHI5Nk9zK1pZc25EMHp3elk4ZGk3NjQxN244aUw2WFBnbytUdlhR?=
 =?utf-8?B?eFExK3JtQXErVU1xNDZjRHEzWUZKTXgwNURyenRzMFRmYTN3b0FNWnRacXgr?=
 =?utf-8?B?K1Y2eUNGQXdVOTEzaFRtanVqS05IU1lBc1JYY0Vza01rK2dMdVZQSVhPa3JQ?=
 =?utf-8?B?K1RvLzByY3NNaFB3R295a3BYbDJRK0NmZmxNbTFTUHIyUWg0RVVkYzFUNDZH?=
 =?utf-8?B?alQwMVh3VCtGRi9NS2FXbXh4cWROR2g5WjUvT1k0WmFzVVZWelp1WDNLalVL?=
 =?utf-8?B?aUw1SDJIa3QwTE1lcEpRUFQxNHc3alRIS2VqbGtyWXNMazFydUhHYWtkZzgv?=
 =?utf-8?B?czhmajB5S0JHaXRYMGhjeFZ3YTRvWVU5RWhyMEtvVWpOQUZsVS9SUVByWi9X?=
 =?utf-8?B?eXgzYWtTZGhhRTZFTFJxWGpDeDBNa2V3ZFZPMFVSUXR6UlJ0OFA2aEpPU1RG?=
 =?utf-8?B?NVF5QUdXQUJoMnpna1JsY0NvMk9NaDQrU2haOXUxUmtxZUgrczRTWXFEdFpZ?=
 =?utf-8?B?TUluNDZtaXUvd0xHTWtoV29qcFhKb1c5djJzZ0JUL0hFb3drMWhIU2l4THJv?=
 =?utf-8?B?dzFsRzlsZnNkakZnalQrWlJVM0YxSVhyQTlqWEhUUlFKZFk2RCtvaStHZlpP?=
 =?utf-8?B?eDRkdm9rT2tIWEV6VjY2QjM1T0RoOHg0akNnb2U4MlhQVVJrMFpsY2ptOWNI?=
 =?utf-8?B?Z0ZUUWNDRDQ1RUNCVXFzT0RNKzA4d2VuRm1WS0craU9CUXBtQjM1eHR2eEdC?=
 =?utf-8?B?OEVZV04xa2pXVHgydXFSNVZMNnorVi9yUXJ2eEExOUlTbG5OaS90K1FNeXV5?=
 =?utf-8?B?TGtNdmg3TmF5VHZXRktFL0grazdqSmxLenpRSHpkTmk4S2RSbkFpcGVvcEJY?=
 =?utf-8?B?c3R0OVZ4MlBJdjJLQStPOE1OUXFObXJDbDI2SytzWVM5aFNEMy9TK1d5SzRp?=
 =?utf-8?B?L2h0Q1dDN0Vadzl0WGoyVW92V2pwTm5xdzlwZG1GMXJSZmhsdFMyVkwrMEUz?=
 =?utf-8?B?ZGdQLzdrVWMyWVlVSFg3MTVVWEFybDkvV09ITXpDRTZPazRGenFEZUNEYlJJ?=
 =?utf-8?B?QmUzWVRQZUlOSzVUNjhZZU41TEkyMitUYWtNQUdBUFd2TjVvTnRIYWkzR3Ni?=
 =?utf-8?B?UlNEd3hZb3FvMWI0NXYxTTl0LzVMTGpFTTRDZE4rYXdEbENzaGhsZUN6SExn?=
 =?utf-8?B?dHBkOWdRNmtybnVWMWRJWG05Vi9zTkpzeC9EMlIwSlR2NWp4a2plOVpHK2Uz?=
 =?utf-8?B?dmtQR2lmejhCOXoxVHJnME5vVDhxRWRZMTZGYytjNG8wUytrd1lMTnZMZmEv?=
 =?utf-8?B?K2tLQ2wxY1VobGhPS1hTTStCMWlLdzFsTS9aL0ZPOUp0bmxZUTFYYUdvS2ph?=
 =?utf-8?B?TDVycS96RFNxWnJNV0dhS1NFYU1PMmJ6SDAxM29kSit6cmt6VWxGS3NnZTZq?=
 =?utf-8?B?b0RMNHNCd2xKdTFWYUhkWmlOTHlMZHJFTDErSGVXcjlsQVJzQzRuVFVscXdR?=
 =?utf-8?B?dFh0NnYrNTlsekxxenVDU1lWN0czRXNnL1grNkFra0dpV0ZMNFJGS01nY0k3?=
 =?utf-8?B?Q21DdHJBcHAwUVI4R0JGZVhidHJnMlpnT2szclo3N3pndjUzSnVRcGZZNGFl?=
 =?utf-8?B?WXFWbWZXNXFOWnMyNURSOTZNeEVQelhXQzh1UFEya0xicEQwbXRnTHgyNUFK?=
 =?utf-8?B?U1NQR1EzRlErYnR6RlJaS2hrYU80YzJudXdsMGVTZkxteW8zSUZnUnVsekw1?=
 =?utf-8?B?Q3Z0MnJHOFJjTDdGQkdCdHpwcWE2Q2dPY3VCVUlqWE5idXNGZmg0SFJkSE8x?=
 =?utf-8?B?M1Q1bXB3cC9SeFhKSzBFdCtaczY4eXdudmxxOWNiUy84T2ZhV3dGUitESmQ5?=
 =?utf-8?B?cUF5NjgwZEJoRG9Ick45NDV5V21LVmtJYithVlVxL3UwUzBBYkJ2dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jo4UQBaik+lnQ/ZY01ccgrIJznVj+oeDlEub38RZZUhrG2MPtCUrdtHlXJQEnCTmJjAz5oTTrUSwka9/FY6W4QHFi+Jv4dhxeyjAuDdQbeNyNgj1rv6YIioB0YJs5uqyADcrAp6uSar9znEe+82BtsACByr6eOoWtI+RiBloza7AoeLy78X3LrVzJpRJPxcQqDok6Ae1F4UIKHHWN5tK9Mc7I5dNQkpPAEcm1FHzlLfPPAA5X3XdEIFWxYa6/11eSzllsCbO8A7QanbLDqz396oY9uzUlBdrlxQmajgB/epeAhGu/k4OlO1U2LOsxgwpmUH1yuu/lKgTr4sXkTJ45g==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a14ece2-ea09-4a9f-681d-08def77ac831
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 07:33:04.9166 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aDAPWOLL9VzFNwtrgWqq02rzXqFvLn9Da1uSYTZz7ai9XCUsHHXj15kkubuFPuv6mjmKcY0tC9yI5T2iUndSjWL+VAQmwim8/URCcv5u0uk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU4PR06MB8364
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SGkgTWlrYWlsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEPDqWRy
aWMgTGUgR29hdGVyIDxjbGdAa2FvZC5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIEF1Z3VzdCAxMSwg
MjAyNiAxMjozMSBQTQ0KPiBUbzogTWlrYWlsIFNhZGljIDxtaWthaWwuc2FkaWNAaWJtLmNvbT47
IHBldGVyLm1heWRlbGxAbGluYXJvLm9yZw0KPiBDYzogcGJvbnppbmlAcmVkaGF0LmNvbTsgbmlu
YWRAbGludXguaWJtLmNvbTsgdGl0dXNyQGdvb2dsZS5jb207DQo+IGpldWsyMC5raW1Ac2Ftc3Vu
Zy5jb207IHBoaWxtZEBtYWlsby5jb207IFN0ZXZlbiBMZWUNCj4gPHN0ZXZlbl9sZWVAYXNwZWVk
dGVjaC5jb20+OyBsZWV0cm95QGdtYWlsLmNvbTsgSmFtaW4gTGluDQo+IDxqYW1pbl9saW5AYXNw
ZWVkdGVjaC5jb20+OyBLYW5lIENoZW4gPGthbmVfY2hlbkBhc3BlZWR0ZWNoLmNvbT47DQo+IGFu
ZHJld0Bjb2RlY29uc3RydWN0LmNvbS5hdTsgam9lbEBqbXMuaWQuYXU7IGNhbGVic0BsaW51eC5p
Ym0uY29tOw0KPiBtaWxlc2dAbGludXguaWJtLmNvbTsgcWVtdS1hcm1Abm9uZ251Lm9yZzsgcWVt
dS1kZXZlbEBub25nbnUub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgNC84XSBpMmMvYXNw
ZWVkOiBGaXggRE1BIHJlY2VpdmUgZmlyc3QtYnl0ZSBoYW5kbGluZyBmb3INCj4gYmxvY2sgcmVh
ZHMNCj4gDQo+IEphbWluLA0KPiANCj4gSSB3b3VsZCBhcHByZWNpYXRlIGEgZmVlZGJhY2sgZnJv
bSB5b3Ugb24gdGhpcyBjaGFuZ2UuDQo+IA0KSGkgTWlrYWlsLA0KDQpCZWZvcmUgZ29pbmcgZnVy
dGhlciAtLSBhcmUgeW91IHN1cmUgdGhpcyB2YWx1ZSBpcyBjb3JyZWN0IGluIERNQSBtb2RlPw0K
QVNUMjYwMC9BU1QyNzAwIGRhdGFzaGVldCwgSTJDQzA4IChUcmFuc21pdC9SZWNlaXZlIEJ5dGUg
QnVmZmVyKToNCiAgICAxNTo4ICBSTyAgUmVjZWl2ZSBCeXRlIEJ1ZmZlcg0KICAgICAgICAgICAg
ICAiVGhpcyByZWdpc3RlciBpcyB2YWxpZCB3aGVuIERNQSBCdWZmZXIgaXMgbm90IGVuYWJsZWQu
Ig0KDQpUaGF0IHJlYWRzIHRvIG1lIGFzOiB0aGUgcmVjZWl2ZSBieXRlIGJ1ZmZlciBvbmx5IGhv
bGRzIGEgZGVmaW5lZCB2YWx1ZQ0KaW4gcG9vbCBidWZmZXIgbW9kZSwgbm90IHdoZW4gRE1BIGlz
IGVuYWJsZWQuIElmIHRoYXQgaXMgcmlnaHQsIHRoZW4NCm1vZGVsbGluZyBpdCBpbiB0aGUgRE1B
IHBhdGggbWFrZXMgUUVNVSByZXBvcnQgYSBibG9jayBsZW5ndGggdGhlDQpzaWxpY29uIHdvdWxk
IG5vdCBwcm92aWRlLCBhbmQgYSBkcml2ZXIgcmVseWluZyBvbiBpdCB3b3VsZCBwYXNzIHVuZGVy
DQplbXVsYXRpb24gYnV0IGZhaWwgb24gYSByZWFsIGJvYXJkLg0KDQpIYXZlIHlvdSBjb25maXJt
ZWQgdGhpcyB3b3JrcyBvbiByZWFsIGhhcmR3YXJlLCBvciBvbmx5IGluIFFFTVU/DQpJZiB0aGUg
ZGF0YXNoZWV0IHJlYWRpbmcgaXMgY29ycmVjdCwgSSB0aGluayB0aGUgbWlycm9yIGJlbG9uZ3Mg
aW4gdGhlDQpwb29sIGJ1ZmZlciBwYXRoIGluc3RlYWQgLS0gYXN0MjYwMF9pMmNfc2V0dXBfYnVm
Zl9yeCgpIGRvZXMgbm90IGVuYWJsZQ0KdGhlIERNQSBidWZmZXIsIHlldCBhc3BlZWRfaTJjX2J1
c19yZWN2KCkncyBSWF9CVUZGX0VOIGJyYW5jaCBuZXZlcg0KdXBkYXRlcyByZWdfYnl0ZV9idWYg
ZWl0aGVyLiBUaGF0IGlzIGFsc28gdGhlIGRlZmF1bHQgbW9kZToNCmkyYy1hc3QyNjAwLmMgc2V0
cyBtb2RlID0gQlVGRl9NT0RFIGFuZCBubyBBU1QyNjAwIGJvYXJkIERUIG92ZXJyaWRlcw0KYXNw
ZWVkLHRyYW5zZmVyLW1vZGUuDQoNCjEuIE9uIEFTVDI2MDAsIGlzIHlvdXIgc2V0dXAgdXNpbmcg
RE1BIG1vZGUgb3IgYnVmZmVyIG1vZGU/ICAtLS0+IEFTIGZhciBBcyBJIGtub3csIGN1c3RvbWVy
cyBzaG91bGQgdXNlIHRoZSBidWZmZXIgbW9kZSBiZWNhdXNlIEkyQyBETUEgbW9kZSBpc3N1ZSBp
biBBU1QyNjAwLg0KDQoyLiBBcmUgeW91IHRlc3RpbmcgQVNUMjcwMCBhcyB3ZWxsPyBUaGVyZSBi
b3RoIG1vZGVzIHNldCBSWF9ETUFfRU4gKERNQSBhbmQgQnVmZmVyIG1vZGUpIC0tDQogICBhc3Qy
NzAwX2kyY19zZXR1cF9idWZmX3J4KCkgZG9lcyB0b28gLS0gc28gSTJDQzA4WzE1OjhdIHdvdWxk
IG5ldmVyDQogICBiZSB2YWxpZCwgYW5kIHRoZSBkcml2ZXIgcmVhZHMgdGhlIGxlbmd0aCBmcm9t
ICJCWVRFX0RBVEFfTE9HICgweDg0KSIsDQogICB3aGljaCBRRU1VIGRvZXMgbm90IG1vZGVsIGF0
IGFsbC4gVGhhdCB3b3VsZCBuZWVkIGEgc2VwYXJhdGUgcGF0Y2guDQogICBodHRwczovL2dpdGh1
Yi5jb20vQXNwZWVkVGVjaC1CTUMvbGludXgvY29tbWl0L2Y5OTM4ZWM1Nzk5ZTgzZjViMDlkM2E3
YWNhYzcyODdjMGNkZTJjMjYNCiAgIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVj
dC9xZW11LWRldmVsL3BhdGNoLzIwMjYwODA0MDgxOTU1LjE1NjM1MzctMi1qYW1pbl9saW5AYXNw
ZWVkdGVjaC5jb20vIA0KDQogICANClRoYW5rcywNCkphbWluDQoNCg0KPiBPbiA4LzEwLzI2IDIw
OjU3LCBNaWthaWwgU2FkaWMgd3JvdGU6DQo+ID4gQW4gU01CdXMgYmxvY2sgcmVhZCAoSTJDX01f
UkVDVl9MRU4pIHJlYWRzIHRoZSBibG9jayBsZW5ndGggZnJvbSB0aGUNCj4gPiBmaXJzdCByZWNl
aXZlZCBieXRlLiBUaGUgTGludXgvVS1Cb290IGFzcGVlZCBJMkMgZHJpdmVyIG9idGFpbnMgdGhh
dA0KPiA+IGZpcnN0IGJ5dGUgZnJvbSB0aGUgSTJDQ19TVFNfQU5EX0JVRkYgcmVnaXN0ZXIgKG1v
ZGVsbGVkIGhlcmUgYXMNCj4gPiByZWdfYnl0ZV9idWYpLCBldmVuIHdoZW4gdGhlIHRyYW5zZmVy
IHVzZXMgRE1BLiBUaGUgRE1BIHJlY2VpdmUgcGF0aCwNCj4gPiBob3dldmVyLCBvbmx5IHdyb3Rl
IHJlY2VpdmVkIGRhdGEgdG8gRFJBTSBhbmQgbmV2ZXIgdXBkYXRlZA0KPiA+IHJlZ19ieXRlX2J1
Ziwgc28gYmxvY2sgcmVhZHMgcmVhZCBhIHN0YWxlL3plcm8gbGVuZ3RoLg0KPiA+DQo+ID4gTWly
cm9yIHRoZSBmaXJzdCBETUEtcmVjZWl2ZWQgYnl0ZSBpbnRvIHJlZ19ieXRlX2J1ZiBzbyB0aGF0
DQo+ID4gSTJDX01fUkVDVl9MRU4gdHJhbnNmZXJzIHVzaW5nIERNQSByZXBvcnQgdGhlIGNvcnJl
Y3QgYmxvY2sgbGVuZ3RoLg0KPiA+IFRoaXMgaXMgcmVxdWlyZWQgZm9yIHRoZSB1Y2Q5MDAwIGRy
aXZlciwgd2hpY2ggdXNlcw0KPiA+IGkyY19zbWJ1c19yZWFkX2Jsb2NrX2RhdGEoKS4NCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IE1pa2FpbCBTYWRpYyA8bWlrYWlsLnNhZGljQGlibS5jb20+DQo+
IA0KPiBEb2VzIHRoaXMgY2hhbmdlIGRlc2VydmUgYSBGaXhlczogdGFnID8NCj4gDQo+IFRoYW5r
cywNCj4gDQo+IEMuDQo+IA0KPiA+IC0tLQ0KPiA+ICAgaHcvaTJjL2FzcGVlZF9pMmMuYyB8IDcg
KysrKysrKw0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4g
ZGlmZiAtLWdpdCBhL2h3L2kyYy9hc3BlZWRfaTJjLmMgYi9ody9pMmMvYXNwZWVkX2kyYy5jIGlu
ZGV4DQo+ID4gMjdhZmNhZWNlZS4uZmFjYjU0ZDI3ZSAxMDA2NDQNCj4gPiAtLS0gYS9ody9pMmMv
YXNwZWVkX2kyYy5jDQo+ID4gKysrIGIvaHcvaTJjL2FzcGVlZF9pMmMuYw0KPiA+IEBAIC0zNjUs
NiArMzY1LDcgQEAgc3RhdGljIHZvaWQgYXNwZWVkX2kyY19idXNfcmVjdihBc3BlZWRJMkNCdXMg
KmJ1cykNCj4gPiAgICAgICB1aW50MzJfdCByZWdfcG9vbF9jdHJsID0gYXNwZWVkX2kyY19idXNf
cG9vbF9jdHJsX29mZnNldChidXMpOw0KPiA+ICAgICAgIHVpbnQzMl90IHJlZ19ieXRlX2J1ZiA9
IGFzcGVlZF9pMmNfYnVzX2J5dGVfYnVmX29mZnNldChidXMpOw0KPiA+ICAgICAgIHVpbnQzMl90
IHJlZ19kbWFfbGVuID0gYXNwZWVkX2kyY19idXNfZG1hX2xlbl9vZmZzZXQoYnVzKTsNCj4gPiAr
ICAgIGJvb2wgZmlyc3RfZG1hX2J5dGU7DQo+ID4gICAgICAgaW50IHBvb2xfcnhfY291bnQgPSBT
SEFSRURfQVJSQVlfRklFTERfRVgzMihidXMtPnJlZ3MsDQo+IHJlZ19wb29sX2N0cmwsDQo+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBSWF9TSVpF
KSArIDE7DQo+ID4NCj4gPiBAQCAtMzkxLDYgKzM5Miw3IEBAIHN0YXRpYyB2b2lkIGFzcGVlZF9p
MmNfYnVzX3JlY3YoQXNwZWVkSTJDQnVzICpidXMpDQo+ID4gICAgICAgICAgIH0NCj4gPg0KPiA+
ICAgICAgICAgICBhc3BlZWRfaTJjX3NldF9yeF9kbWFfZHJhbV9vZmZzZXQoYnVzKTsNCj4gPiAr
ICAgICAgICBmaXJzdF9kbWFfYnl0ZSA9IHRydWU7DQo+ID4gICAgICAgICAgIHdoaWxlIChidXMt
PnJlZ3NbcmVnX2RtYV9sZW5dKSB7DQo+ID4gICAgICAgICAgICAgICBNZW1UeFJlc3VsdCByZXN1
bHQ7DQo+ID4NCj4gPiBAQCAtNDA3LDYgKzQwOSwxMSBAQCBzdGF0aWMgdm9pZCBhc3BlZWRfaTJj
X2J1c19yZWN2KEFzcGVlZEkyQ0J1cw0KPiAqYnVzKQ0KPiA+ICAgICAgICAgICAgICAgICAgIHJl
dHVybjsNCj4gPiAgICAgICAgICAgICAgIH0NCj4gPg0KPiA+ICsgICAgICAgICAgICAvKiBNaXJy
b3IgZmlyc3QgYnl0ZSB0byByZWdfYnl0ZV9idWYgZm9yIEkyQ19NX1JFQ1ZfTEVOLiAqLw0KPiA+
ICsgICAgICAgICAgICBpZiAoZmlyc3RfZG1hX2J5dGUpIHsNCj4gPiArICAgICAgICAgICAgICAg
IFNIQVJFRF9BUlJBWV9GSUVMRF9EUDMyKGJ1cy0+cmVncywgcmVnX2J5dGVfYnVmLA0KPiBSWF9C
VUYsIGRhdGEpOw0KPiA+ICsgICAgICAgICAgICAgICAgZmlyc3RfZG1hX2J5dGUgPSBmYWxzZTsN
Cj4gPiArICAgICAgICAgICAgfQ0KPiA+ICAgICAgICAgICAgICAgYnVzLT5kbWFfZHJhbV9vZmZz
ZXQrKzsNCj4gPiAgICAgICAgICAgICAgIGJ1cy0+cmVnc1tyZWdfZG1hX2xlbl0tLTsNCj4gPiAg
ICAgICAgICAgICAgIC8qIEluIG5ldyBtb2RlLCBrZWVwIHRyYWNrIG9mIGhvdyBtYW55IGJ5dGVz
IHdlIFJYZWQgKi8NCg0K

