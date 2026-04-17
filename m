Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD73DF43682
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 08:50:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDeuc-00044d-Cp; Fri, 17 Apr 2026 04:50:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDeuW-00043y-N0; Fri, 17 Apr 2026 04:50:49 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDeuS-0002pp-5N; Fri, 17 Apr 2026 04:50:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AAqitwwaLXooJZx6SYGMBHJ+0rd2WLne91RTu0DqNEGQ2BSG27IAcwLgYuoLqGxKKkngZ+t07Yi1k0HFCcfQX/fy6dRwOtiWUycxYgpsLZNFzFeB37waFtYKpCCaTmtsTEaILRSk5xeS5Oa333eDwnogztA+Jvqtxhn83c7O2VtXHAZv40t35aIEE5aeEzLZtI+4WR/MaUSrxE/6uodedQVNxoH12s6GaM8Z8XQcuVXARK5e2+38Ey6Gu2yh40iy1gpj6krZu3B7zoIPOOX8nJq3gOjrCD7WuM3AOyqHfYCVorGlnv0yjwSO9g+mrZpo32m0R0p6wogIpB9Vnzk4rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWG6cAbBplSr1H2koPka0QlHHjtH5s/9uAY7/srk22k=;
 b=A3tUzjHGFOmHPAISFRzLGduNp/RhrypUwiX1oOethY6n8+lhwOTsR7iJkPeiMVmITuZCkDKPkOWPGESuOGfd2a9svbOJ7pmtejJbRuXpILhGghXsNqUDz6vzWV7aXtqhQnsUpIRmwfvjMl/KQ9D4EnYCNP39py0ifbfAQQoTygCpBmaaqXK5Ae8agBDeZkYwU4KRVCFwIsVCcSqJK99kp/smMPzTGQZu9sM3IsIF15PZCVyj6sYEm6LKi7YBNlLOv1P5lUN5Oi1Ggo98S0ziEY83527TbQvdDsQG6EW8+zRhsa1LEpBvDElfSM5HzOUFDmm/i8cHJr/s2QCaUYWEnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWG6cAbBplSr1H2koPka0QlHHjtH5s/9uAY7/srk22k=;
 b=jhLYWO4zi9Q9MNIxA91GlTfG7aVVY1bNTC6GQTtx/4TvPjadCnzp/5a3q18BAodv1EkHJDMMXkxa1ZSEx6o0XBOQ+Yxw2lUqBBEg6wR7w4/7+rhxujAVMJgydsO1eoL0Rq/m+rBh84J6dpoFoyfxRcIoOv/KmFd8GJ1AnRFn4+p/1rhxv/PkgLCKxLIiJLTkBVJOtq3sG2hzzym0UzcZqxJOB9n/llgeNXFQMpwnk6TBSxvAqKhUpRV0kz5qVlGr4/mXzlrumdQwLtfQLXV2LcuA85GgOdLiFR24wilTWVhGXArQjKb6fBacHR1nFZdRDFevLIZ4bsxtNKuYWGpyNQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KUXPR06MB8414.apcprd06.prod.outlook.com (2603:1096:d10:82::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Fri, 17 Apr
 2026 08:50:36 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 08:50:36 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "flwu@google.com" <flwu@google.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>
Subject: RE: [PATCH v3 16/17] tests/functional/arm/test_aspeed_ast2600_sdk:
 Add USB EHCI test for AST2600 SDK
Thread-Topic: [PATCH v3 16/17] tests/functional/arm/test_aspeed_ast2600_sdk:
 Add USB EHCI test for AST2600 SDK
Thread-Index: AQHczUNXa7m48IJ56E+5bAyC84EEb7Xiy+aAgAATUfCAABL+AIAAALGw
Date: Fri, 17 Apr 2026 08:50:36 +0000
Message-ID: <TYPPR06MB8206C1638ED1807954659FFBFC202@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260416014928.1279360-1-jamin_lin@aspeedtech.com>
 <20260416014928.1279360-17-jamin_lin@aspeedtech.com>
 <1738caec-dfa0-4d88-b7dd-5eabc075f5ef@linaro.org>
 <TYPPR06MB82064C14C44392EEA1F98BEBFC202@TYPPR06MB8206.apcprd06.prod.outlook.com>
 <4ee72e0c-2fd5-469d-84c0-ca0bf75f1143@linaro.org>
In-Reply-To: <4ee72e0c-2fd5-469d-84c0-ca0bf75f1143@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KUXPR06MB8414:EE_
x-ms-office365-filtering-correlation-id: 9866de74-3bb6-4596-c8f1-08de9c5e6495
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|22082099003|56012099003|18002099003|38070700021|921020;
x-microsoft-antispam-message-info: oWaM8NyxA2lVTUE+fKBQgNpXhp1HEiMQ32yxGVm6907DUy+P2UXxlq4mQE+epH1Vng2vswwOJu7j8nLUj5R+R/Ik+DR7EhYl4U9DQFXtwIVJyoPhZ4/S4POuowIRw+7bEKUhPX6BL+Vf+T/1IfjHAozXYhAjwQz9gdW8CsH74ZQaYG18lzq2YoPEdj0DQDVxQixw2guSdpd4rvjrAksVsyk1dEH+l1+y4Yl4/H7JZ3Hc4rvfadY2mRuMFnarDbwonHdQxShui0U9oazj5MpAtMNfOzS7PuCCF3V/yq7CnAsFQJUUUbuTLGWQOfEuHqmES/7CZ1Eh5NOMn0zJn1iEjvQJS42UMIwsx2Fv6/l13Yf1MIgiMs4MwE45uWdHPv+P/c9nArGoesaHeG32+EPYGxi1JIgVm1kOSQNaoX5rXNqYz5H559vYjFvvLlMYmwnr8gi854UhwlTYRR+ebStZcE85VYbiaYsjuPspkmjCB8Vgq/rBGfqKHCXhlRmrTnBIvboXYVbc23IudRzZ3y78Loc+zlAeKptYpasS1geMbsSHvwhDCjm9pXFhbLTBJsRlOtTXZM1K1hZN5u3/Cox/IDpVgr6Y/Mxjpop0Y41gbbMZiVYTBE752NybrXOyEm7VRbPTMlOTOjezTgOkjuUijzJB8R5Il9ZaZSb0G4+lAZIjoz+BKKWS/CX/EmUk12wURMYM/1VN6iUk9Dhskek5P74nU1L8gCG0/wGtBu04J18W6P8KYCiX7ReDouakzfsnet7YqWm8dm3ZwCqilMvdHBMY4mNIpS2p0JaHzTMz/s1EIFF8+Uze+rcsMs3gBNUO
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(22082099003)(56012099003)(18002099003)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SlRzeng2dDhhMDU1QS9wZTN3QWtyUVdVcVVPc2VSMnVkdEFQOW4rZXdmZUVx?=
 =?utf-8?B?Ky9EQ2xCTVNsUlVuU2haMWx1ZkRpY0Q5YnRkbERodG55RXE2eEVucXBJdXQ5?=
 =?utf-8?B?cDFjQnpDY3l5MVdITE95ME93SmJ0aXI4S29kUVRmZ0hMWXZhbnRuSmZTbi9K?=
 =?utf-8?B?RG5oOWM3bWJKSEFFcG9zN2p3MHlUNXBmM29wenVOSmtsbHhPcnVSek5zamNB?=
 =?utf-8?B?bTR2RFN2Vi9vckVBOGxiV3hzWHM4bEoxcmZVYjA4c0JkbFp6Q2pqZmI0b0pH?=
 =?utf-8?B?bGtLQ1lrNitydHRRNzRZYUNLUGZScUtTZ0Q0QlhZNUhESjJFT2NRQ0dpVC8y?=
 =?utf-8?B?cGF4OWFXTFlpekNWZkZobWNyM2NIMktRWDk0VGdmaHMxVjJOemxQb2d4dTUv?=
 =?utf-8?B?Y3dDTVBsMkwvaytQY3lMb3RjT2E2ODB0UFY0MkYvVVFPbkc5bnJ5ZWVselp3?=
 =?utf-8?B?WVgyTmE3emJDNTdsU0JtK1ZPa2F1dUZTVmgzOWsvMmRlYzJUWlJQeWVnTkt3?=
 =?utf-8?B?Z1VKVGI4Z2R0VmpGRWdxc050aFdJU3FacWZXcWx0SitDRUNXL01RMjdxakFx?=
 =?utf-8?B?YlVJcEg4TmJuWUtHSlN5czQ5bGhYTENSY0VxMTNEMktVY1p5MEFJdUpHa0U5?=
 =?utf-8?B?Z3pkZ1pxNm0veDNQZmVnN0hBcm5JRWs2RG9JaENLUUFMMjR6U2ZBaEJnSUg1?=
 =?utf-8?B?NEdiWlJQdkQxK2paUTdXVVVNMjh1NTBiOHhGaGtsWE1DcmkvSGwzQ0lRZXJR?=
 =?utf-8?B?RldsVGlWcGJWUmNsYlc3TDhOOWxZdWxDVDZzbU9TSDBaVXg3cWVQU3lKcnRI?=
 =?utf-8?B?eFMwd1lidmVEOG53NEVmUHd2NzVGYWJoUjdLMmx4L2NzcXppay9vckJKN2Rj?=
 =?utf-8?B?d2ltMmRVTjBxMmk4MEhqYm0vVVpMRjJTRGpyVUsyVHRaQ2Z5NytWc1Y4SEY5?=
 =?utf-8?B?dkZVeTM4V215ZWF3M1BjVlY4OE4vUGpkN0VOR3N2Q1NGc3VFdGQ4S1U0RFVu?=
 =?utf-8?B?My8wN3FCckpIMGZ6bjhVelVkc0hNN1hBeTQxdVhoalZLbTJTNDhTVFJjTlov?=
 =?utf-8?B?Z0ZpUXNDeC9iMm9vSkxYZUlsSnNNT1IrVTdoWmlnL3FyNmlOazB5YWMvRThN?=
 =?utf-8?B?dXo3eXNFQ2k2VWxSdDFjTzdXU2JiK200a2svOG5lRmx2MUV4YVFIQy92MmJO?=
 =?utf-8?B?TDVlbUk4ZFpyR1YzVWJHVEE0QytSenBubHhYcWw1R285RGN2Uzdtdk5kWEo4?=
 =?utf-8?B?eVZZVHp0WTBOVnpCQVFuSnB5MnVxVzg2WVZ3UVlYZjVRYlRrWmxQWmtremNn?=
 =?utf-8?B?NXNHUjhYb0xhbTRBQURURnZma0haTFhIbmdZWmh6aHg1MTNCT2JpWjM3dVJz?=
 =?utf-8?B?b1hEbDVEdnllbjZhb3V6RTFkcDFneGdtUHBpOW1kNVcvdmNDZnluTmxDaWN3?=
 =?utf-8?B?bjdJNi9DMElIYkVyQjE4NUlsdjdrcnpPRFpza2NuRHkzOUZkYUU0bjhUSStJ?=
 =?utf-8?B?cXZZSnVObzgwWVV2VnpoVGRUNzl6VXAyY0t0Q3Exbk13aGdoS3BKbVVFbVR2?=
 =?utf-8?B?d3NnVTI2N0MydnM3b0VHVWtsem0rbGtvQlAyRzF0WGtBR2V2NHk1ZGk4RCsw?=
 =?utf-8?B?d0RzQmdIZ2lhV01URzhRYUF0UEVoR2twV2c5eWxneHMwZlhTVmxSRWQzbVZh?=
 =?utf-8?B?MnpaS0pzZnRCSUt6MmRSRjZIdmhyenE3UHRkZ1MzK3BwRGtIb1k3WVUwUXZs?=
 =?utf-8?B?cjYxbmhqVitZbnlrV0tJZDJNVWw0N2F1cm9ackladmphb1VkOFNsM3MweWRK?=
 =?utf-8?B?ZzhXdFM5VTlVeVVCNnd3dU44VTZtRVlKaTRjL3VQb1pnMkdMeGh1LzZ4c3NJ?=
 =?utf-8?B?Q1pkc3h0aU1tUGpaVUdnN0EyTkltQ1UySEo4QnJ6TlhKNHFPWndhZ0x4elM5?=
 =?utf-8?B?aTJNYTJKWnpaa2hNdnFBdGE3NjIwMUpYYk9aQ2lDaVR2eHFkKzNHSkRaS1NR?=
 =?utf-8?B?M0tWaUZNdDR1REgrQThYMkVZd1RzUitqWVdGOXlzeXAzZU96YWc5ZUY0UzZn?=
 =?utf-8?B?UEthMmlHQy9jR1NLYnZUUHRnZ0lVU0hzSGY5bFdXSmgxeHpsa2M5Z1RNelBB?=
 =?utf-8?B?ZkthRFUvT0x2eXI5Z2pvRkFzcUlkNnRCSWh6c0FXdXVReHZCZFRxWXRweVla?=
 =?utf-8?B?VG9LdkJ0MmFJSkYyWVU5MGhSRUhIOFpGWWIxdC9TdmpkWUFVMmxuL0oxVUNI?=
 =?utf-8?B?bDZmSUhzdUxDZkpoczBWNzc2dFNSUHh4eWszMXNZdVgxT2NmbHo1R2NIZHBF?=
 =?utf-8?B?M2llUHZUMmtib3BNSmU3VEdpclBVNm5YbGhPN3FiRHFsZmtrQkZpQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Ye/8YGXgSfISR1qMh3NuALGHu6gs/VxB4Ryz5AHIWOa5OBBqod9wq2maBiTPmLFee0SYVR+Qn9+NiW2TI0BWHFqepxwQ17qZMXPbl5EuT7fLDu3oaSVEdI5IEdV93Yp7frFMS/Uoc//TmRQiNfd2B88PCNGhi4NWDFlwAtR9GUi1E13XrsuCKiPSveD8kiysUfQV+p27PLrn0qPup3DzWL1Dso6AtmhHUmZmGZKAnJCR1NGMZhfWF6oBAF4D7QSznMq9vxGyYJohia9ogqtOyscLLv35g2Cx+oWRaJ/7nU+TpxPMzPf+Q4DVY9inHbDm8sncSwu/6YlU0dk7wVx/Hg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9866de74-3bb6-4596-c8f1-08de9c5e6495
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 08:50:36.0803 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QlnT5C3uewBGFJ0K40MjG0cv+Zf4Q763Tx/BATh02QwvsZtJugB7S9dUwXNAipXgcPFLBo/FLDnfFMZwIiK0fLu/0AHD2OplUvDEW57dBUA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR06MB8414
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

SGkgUGhpbGlwcGUNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDE2LzE3XSB0ZXN0cy9mdW5j
dGlvbmFsL2FybS90ZXN0X2FzcGVlZF9hc3QyNjAwX3NkazoNCj4gQWRkIFVTQiBFSENJIHRlc3Qg
Zm9yIEFTVDI2MDAgU0RLDQo+IA0KPiBPbiAxNy80LzI2IDA5OjQwLCBKYW1pbiBMaW4gd3JvdGU6
DQo+ID4gSGkgUGhpbGlwcGUNCj4gPg0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDE2LzE3
XQ0KPiB0ZXN0cy9mdW5jdGlvbmFsL2FybS90ZXN0X2FzcGVlZF9hc3QyNjAwX3NkazoNCj4gPj4g
QWRkIFVTQiBFSENJIHRlc3QgZm9yIEFTVDI2MDAgU0RLDQo+ID4+DQo+ID4+IE9uIDE2LzQvMjYg
MDM6NTAsIEphbWluIExpbiB3cm90ZToNCj4gPj4+IEFkZCBhIGZ1bmN0aW9uYWwgdGVzdCB0byB2
ZXJpZnkgVVNCIEVIQ0kgc3VwcG9ydCBvbiB0aGUgQVNUMjYwMCBTREsNCj4gPj4+IG1hY2hpbmUg
YnkgYXR0YWNoaW5nIGEgVVNCIGtleWJvYXJkIGRldmljZSBhbmQgY2hlY2tpbmcgaXRzDQo+ID4+
PiBlbnVtZXJhdGlvbiB2aWEgbHN1c2IuDQo+ID4+Pg0KPiA+Pj4gVGhpcyBpbnRyb2R1Y2VzIGEg
aGVscGVyIHJvdXRpbmUgdGhhdCBydW5zIGxzdXNiIGluIHRoZSBndWVzdCBhbmQNCj4gPj4+IHZh
bGlkYXRlcyB0aGF0IHRoZSBlbXVsYXRlZCAiUUVNVSBVU0IgS2V5Ym9hcmQiIGlzIGRldGVjdGVk
Lg0KPiA+Pj4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6IEphbWluIExpbiA8amFtaW5fbGluQGFzcGVl
ZHRlY2guY29tPg0KPiA+Pj4gLS0tDQo+ID4+PiAgICB0ZXN0cy9mdW5jdGlvbmFsL2FybS90ZXN0
X2FzcGVlZF9hc3QyNjAwX3Nkay5weSB8IDcgKysrKysrKw0KPiA+Pj4gICAgMSBmaWxlIGNoYW5n
ZWQsIDcgaW5zZXJ0aW9ucygrKQ0KPiA+Pg0KPiA+PiBUaGlzIHNob3VsZCBiZSBwYXRjaCAjMSA6
KQ0KPiA+Pg0KPiA+DQo+ID4gVGhpcyBwYXRjaCBzZXJpZXMgdXBkYXRlcyB0aGUgVVNCIEVIQ0kg
bW9kZWwgdG8gc3VwcG9ydCA2NC1iaXQuDQo+ID4NCj4gPiBJIGFkZGVkIGEgZnVuY3Rpb25hbCB0
ZXN0IChBU1QyNjAwKSB0byBlbnN1cmUgdGhhdCB0aGVzZSBjaGFuZ2VzIGRvIG5vdA0KPiBpbXBh
Y3QgdGhlIGV4aXN0aW5nIDMyLWJpdCBzdXBwb3J0Lg0KPiANCj4gVGhpcyBpcyBhbHNvIG15IHVu
ZGVyc3RhbmRpbmcsIGZpcnN0IGFkZCB0aGUgQVNUMjYwMCB0ZXN0IHRvIGVuc3VyZSB3ZSBkbyBu
b3QNCj4gYnJlYWsgYW55dGhpbmcgd2hpbGUgaW1wbGVtZW50aW5nIDY0LWJpdCBkZXNjIGFkZHJl
c3NpbmcuDQo+IA0KDQpUaGFua3MgZm9yIHRoZSBzdWdnZXN0aW9uLg0KSSB3aWxsIG1vdmUgdGhp
cyBwYXRjaCBiZWZvcmUgdGhlIDY0LWJpdCBkZXNjcmlwdG9yIGFkZHJlc3NpbmcgY2hhbmdlcy4N
Cg0KPiA+IEZvciB0aGlzIHJlYXNvbiwgSSBwbGFjZWQgdGhpcyBwYXRjaCBpbiB0aGUgY3VycmVu
dCBvcmRlci4NCj4gPiBJZiB5b3Ugc3RpbGwgdGhpbmsgdGhlIHBhdGNoIG9yZGVyIHNob3VsZCBi
ZSBhZGp1c3RlZCwgcGxlYXNlIGxldCBtZSBrbm93Lg0KPiA+DQo+ID4gVGhhbmtzLA0KPiA+IEph
bWluDQo+ID4NCj4gPj4gUmV2aWV3ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGls
bWRAbGluYXJvLm9yZz4NCg0K

