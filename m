Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F23CA5FE3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 09:02:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCZA0-0006vk-Hf; Fri, 02 Oct 2026 05:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xCZ9q-0006v5-O2; Fri, 02 Oct 2026 05:02:23 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xCZ9m-0003xV-3w; Fri, 02 Oct 2026 05:02:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G5Z0fZ5F82gj5oFGB4SAiawD8tpvsvLYMxMu78YoFwyv7XN24DZbaeZJ4ZSoKWwfOm7bjSimZuwMSalHvylwd8InEB3la5YTxKOEbMK0KcXdBs9tn1VhhtdjBTRyRllihlc5dyF7iLN/qgUOGCNci/IxbtHGrvbFaFxV4esVDlk4/3EoKJ4t09AZOoR/v6g2TAQDsbQ2EDdrpmu8jlBRkjENEa92CVLEVYUk9hux+IbPmK2/5YijW8cWJA81hzqsdN4frVArNDu2CM7xHI7SlJS3UiFhmIbdQwZ5EZxQh/626bhWVCd1dgRgfKVuYQPoizGMWIjbanQJD94VRjO8Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gT06wyFygQTxbFHV3UNW9l8QOo/33LPffqjK6gk/nyk=;
 b=eObgCXH8v8V/CnUE5P2ZQKQLYWUYR4BHbiX3I26fpbYb0S2On4XgbLGuhxMw+mfEbd8CFs6WumgnACIsTrCzUuGDrz5nGTnEavp9HDsHStAuVips7mwq5GeAfQd4cCzcRmQ5F1J4Pk+D4c+QqEAULlDuyDgBNmXV0KdUIqs2QgKya8WHFVV6+OeYNJaUMwIF/v9q5+2Orh1U7BM0ppVqn72ORJssP4C/pAkVHuc25FHKOBEeiHC2htO62aQGvPwQFwU1AeqB/ey2HYz3Q5yZW6mldU0wpcwSHGNN1dWJKXjaWXJNd2CJY5MY0+W8XasrNMKqohAOb8WjnEfjM/lk9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gT06wyFygQTxbFHV3UNW9l8QOo/33LPffqjK6gk/nyk=;
 b=OXa5OPwxR5AAgk6WwiaUT9uUZKhGj0ELPd4rpL3dOhvS+W91AXHnoDVp9sOC9IwAdiNg4ekjDvz3gsqDP7W4XKiLtBtR/xnn6uUoSNgDEY3Yq2yzrGHuUnzL1+gxSqshqVqpJXLeo7EAZXSibiT9rVQZcZJHmpJl5Sc0pnJhpNyylGs43T4r5Ae27MnmrmiULpFpP37Qi9w6fiuKqMCAi9TzRKVwX3Sz5Q7ttopPu7pWUlzvIHM11CUFQejs9iitXESwLbgipJAVoM+3pxymPyQ38JnkpJAhUwKTjQ+rVEPh/+KNV0fzz9ObIEWT8gY8e2aPs8LrJ03Cs9th8MVaQg==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by OSNPR06MB8542.apcprd06.prod.outlook.com (2603:1096:604:491::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 09:02:07 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 09:02:07 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>
CC: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@oss.qualcomm.com>,
 Maydell Peter <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Troy Lee
 <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1 01/11] hw/arm/aspeed_ast2400: Use unimp array and table
 for unimplemented devices
Thread-Topic: [PATCH v1 01/11] hw/arm/aspeed_ast2400: Use unimp array and
 table for unimplemented devices
Thread-Index: AQHdUKzPC3bzrx/LLEOP46GqYDApebbmu80AgABGsgCAAAceAIABRYOAgABFzDmAAASKgIABXf/w
Date: Fri, 2 Oct 2026 09:02:07 +0000
Message-ID: <SEZPR06MB7362FB6E932EC8EEA123F2C4FC892@SEZPR06MB7362.apcprd06.prod.outlook.com>
References: <20260930072501.2612119-1-jamin_lin@aspeedtech.com>
 <20260930072501.2612119-2-jamin_lin@aspeedtech.com>
 <941d7bb6-3205-44cf-8d76-ffbb322a6f4e@oss.qualcomm.com>
 <0cd87753-da91-44ed-a629-43099bfb820d@kaod.org>
 <1197c1ca-14d5-48c1-b497-0c03a781c258@oss.qualcomm.com>
 <330f9a96-4508-4db1-a8a0-fa36c57ed093@kaod.org>
 <672CD4C9-8FCA-4E5A-B610-3F9C51B986B6@aspeedtech.com>
 <0c9ae93c-cd18-4552-9969-0f01568800f3@kaod.org>
In-Reply-To: <0c9ae93c-cd18-4552-9969-0f01568800f3@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|OSNPR06MB8542:EE_
x-ms-office365-filtering-correlation-id: 2d470c92-b2c0-4f10-9926-08df2063d615
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|38070700021|4143699003|10067099003|56012099006;
x-microsoft-antispam-message-info: LJG8VujCjVNQuIlWHCZz5wEFP80XzZOkUjS8yB1tTcF1/c89QLPYkY7bJdBxsLNvpsosOuLjnK7VP7i+pAVp6cMa/Cyhh07KbMf+zJV2KYIDtOKu65pNCtXTcE+/nUtCRnKY78CK9L7RVzfAKFBA0NEkMuFqsm5VKwudm/ayODFetF3r1DsCojvDwVudXznfbnoh3YqeOnTS74D3aAr5qEC0etQQ088rUCjZ8EL7zRHnfo3JoMeML8NiZCqAlinQFK/+YDxwW1mT+wIIoAhOS2JQN2u/LCAX8mgPrg8/ULawtgVg14Z2Tk3XaDnHXGHUhLQiK5osB4SzcGMFqXL7gvMS9FfHdWNF1NW+eJv375gxrmUSa7/dXd4bXKND+lkX0gqBbnilosc6gVQaKUeojAzeTXxYpspZ5f7wkqVi9XT6tMdinbuWKLDt5LAhzBpz/2sDWpUOSxLhKxE54kH8ki3HaF3kYoQaW7hLI35gF2UmF21rjCkNNQ+fbgZa13u5LO7Ps4bWBeE3+yCOUX+XJxAQRiYE0DoSoT6fxK7QHKeVxxtdvaFHZf3yoUTMQoZp5FW4cllGYRcYzF5lemZivRIdAGs7EoeCSchBjccrb1Dlgs+L1YoZ1jqjL3ZB8nc6UqvJbLfX9pKl1Uz/HtvGFCj7IG4GunUuYItBxildoSwcw85peRRg4acYB9qLp1KsgvH3A5r4qx+CSww8EpZdrBzeRFMyR5h6DcOrf1yqX14=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(38070700021)(4143699003)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QjFqOHBMakdCdlZ2MVNTdXFTU2dTWmQ4UGFGRnh4MStSb2F4aW01MDU4N1Fv?=
 =?utf-8?B?Q2dGUnVrQ2ZYcHYwa08vSUhMSlQ4SittcEZ1ZUlXQ25jelJ5S2ZRSFBhcmt5?=
 =?utf-8?B?bWZQWFRoTTlJRSs4ZDJMRldkL09yeTFiVFlESHpzTmI5K1BPOEpIS3IrOWRQ?=
 =?utf-8?B?T1VwZXgxTE9JTjJvWWJ0T3FRZDlHellHUm00eStBZEVIaTFhTzZpWGdpQTVE?=
 =?utf-8?B?QTFhZVFXZjNoRjVNM1pVQ1ZpMWFhUUxSY2txUDFWckFNUTU1VFFieVpNYmtv?=
 =?utf-8?B?UHVJMTdIZjVzS3pkOXdkNnpIUDRRcDdRYndsbE9YdE9SbU9VUU1RMEJXTmdW?=
 =?utf-8?B?UFVwUTVKZUkzOExXSWhnQm01NUNvVUtBeGl5T0RkYW16YlJaSjFPZi81QVRm?=
 =?utf-8?B?ZjdOMHk0SHcybDRJZFd6QnhWR01la2d1cDE3NUJSWG9vVzNjRHBnVGpzSlRr?=
 =?utf-8?B?WTlXeXlVVVpGYzAxRGMweVl3OEhvSnplMlpuR3lKRWdIS0wrRzNISEd2TVIv?=
 =?utf-8?B?eHBHS0w5Q2RFa05acytvUExDRTlvbTZIYnh3QjVBNHZXYkN2UmNRZGtya2Nq?=
 =?utf-8?B?WUZEVXhzZG9JbThQM2Q3c3ZlR0RyekJyN3czdThPRHJyOXdDV3dMenUrTWpz?=
 =?utf-8?B?dnN1b0V3WlRJTEJIMWdRaFZMbXNvYldRc2NxQWdyaGFQeVIwSHJsWW5XaEpY?=
 =?utf-8?B?UFloQzdpTlRPN3ZIZS9lOFhnVGZRQ1E4TWxpMDFDMkVkVVk2Nm5tL3k5WTlu?=
 =?utf-8?B?TlpvQlVYR1lCQ3ZUNlFKTEZyRzl4bnNyKytnT1lNVUxqems1VStvVHF3RXp4?=
 =?utf-8?B?Q1dRaXlPSUJtRFhjb1RMRFBvb2NuUi93dUYzOTdmbDUwT3hSdncvdFVCWmxW?=
 =?utf-8?B?RnkwVnVXVW9lTmV2Q3B6NEdVQWhzU28vVjJvR3BIVEI4M1QwYU1IUlV5Y2Zx?=
 =?utf-8?B?aitXNE1Mc2t0clFsYUViRVliODBBdjd4d3BTUzRIY3NnZ0UrdXpmWDdSQ2FM?=
 =?utf-8?B?bElVWnBVSDlkWjB2NWJPMUlldnd1L1RGOEpVckxSOTRuY2hKYllpMFBLODRr?=
 =?utf-8?B?YWZvRkoxUjF4ZUd2N1JGeDZUeGFLdC9TVGVMeXlXdUt1NXJLSkFSTTZtYVl4?=
 =?utf-8?B?UE5kVzhMcS9uMHI0WnZNRHh5TVI0TUZ6YlhqMHpqYnUwYTVoZEhCK3hBRWJB?=
 =?utf-8?B?d1kzUFJBTnprenAxQlJTZ0k2aG0ydHo4eVd1bnVzMFNEZDFYWnprYTA0bnUy?=
 =?utf-8?B?c3M0UVNHQk91VEVURnQ4ellBTnNyaVRsRTRsSXdROG1JQ01LelFKYzhHTHh3?=
 =?utf-8?B?eUptTVM4QzI2SVdhd1hlUk9ZbHVyOUhIVkU5QmhTSWJ6Q0E3eGg3OThwNi85?=
 =?utf-8?B?eWF6RzlFd2JBMk9YWmZkeUR6Zi81LzY3YndvNFQyQjFNdUpiTXN3d3JPenZx?=
 =?utf-8?B?aGkxaGdLdG5XTWNmUGZzQ2FjWnpldmFmb1VPai9xL3BvSXZ2S05iSytwaWRI?=
 =?utf-8?B?MzlybldXSWNSM0trVEN5ZFd6cDhON1o0cUsva3ZkcmU5TVRqSUt5RUlBN09o?=
 =?utf-8?B?R1JIMzdLbGxyaUVVVVlIQmNVMXFmR3NIU1RIQmp3OG0zclFsNEpHU28yT25s?=
 =?utf-8?B?SUhmSHJvSFI2Zi9aVzE4cHErSVplcUtuR1RUM3M4TUhDVHRkdU45VnBBZGFm?=
 =?utf-8?B?TWZaczc5eUIydVZUak9OQkVEZ29LQStid1A1R2hsaHVwbDBCWG5lb3ZBOFF0?=
 =?utf-8?B?dUE4ellnRjJud2JEcU5sWHg1bDRzbW5iQU54WUFoVEd6aU15Y09WQWZLTGI3?=
 =?utf-8?B?UURXSHNZVkJ6TDNxZmpJZUFIaSs0V3hlL1l4TllXandVMGdMMzJEcHlzTUky?=
 =?utf-8?B?djUxVDVlUnFDT2hMNW5lR1puMUJQcUVkSTFxM1dlZ01iQk9CVWZua00zK2hi?=
 =?utf-8?B?TWY2bENjQW9PbG01NE5jaVJGQThWTHZvRkhHaFcyQ1prMm44cmxOTHJjOW0r?=
 =?utf-8?B?WkhVYWhUOTNuTVl1ZnFnV25sRlFESW5QNDkzektNbHFFNC96bnlPSE5RU2Z4?=
 =?utf-8?B?YWpTVVpEL3RoNC9xd01MTnlGQ1pBWGFyaDN1TGxINHczRHdadTl5eXBHRGx3?=
 =?utf-8?B?QWY2b3VOZUEwUjBJdnQzZUk0VVp0OXRXVHYrUFFnMTVuYURFK2ZYQS9vVjNy?=
 =?utf-8?B?L05FTFJCTkw3VmxNd3l1c1dqVGcvc3E1MjJVSHd4VnRJQ3V1aE5Ua20rdmhT?=
 =?utf-8?B?Qk5NWUdoOWdENk9penpDT3FXUk80M0dHbmFMNzdValR4YWE4YllCR3dqeHV0?=
 =?utf-8?B?K0hPZEdBRjlCcE1YOTU5ODBab1RRTlFqOGtIcGM5S3lKNHFVajdidz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dR43Kpt3QQr2A8QuCwNkpXFSQxwYa6oKNlNVoz7jMKA+QldolI+2J9sXH1IqbbF1j9jAVPMYIqSEPwBNeyTeeBP5sB/WxeuF0whZG+g3/c5DY1Qcms0jly6TjCaaMDFPIAmZe8Z8Q394M8afhBoODs63/MI+arXIiRl8jl3qGs7eRR2YH7HKDkcACxNnGqjWYrB+0IkVslJ9NcGLHWO8o7t8qvzaP1RE3+ZaKQxXbwKQbiYSWjniyCGf/+3f1Lc0xUQC7KV6svl8rvoJ7JMSLYSFmwX3HYE0ad0vvrMBCH7giJ61X0z9///WcS8NTbo4Z7ndnm3++tyOgrvPwmEwog==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d470c92-b2c0-4f10-9926-08df2063d615
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2026 09:02:07.5070 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NE6t+uzbm4CJdqoulg+kcZapPjwc97xMiuPwKzGnOuzbjmsBbUzSct2TNhKfyXz2fG/oJJHcu/F8Etlta/NsUL1idIA42H5mHjNgq+fizF4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR06MB8542
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMDEvMTFdIGh3L2FybS9hc3Bl
ZWRfYXN0MjQwMDogVXNlIHVuaW1wIGFycmF5IGFuZA0KPiB0YWJsZSBmb3IgdW5pbXBsZW1lbnRl
ZCBkZXZpY2VzDQo+IA0KPiBPbiAxMC8xLzI2IDEzOjUxLCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4N
Cj4gPg0KPiA+PiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQGthb2Qub3JnPiDmlrwgMjAyNuW5tDEw
5pyIMeaXpSDkuIvljYgzOjQxIOWvq+mBk++8mg0KPiA+Pg0KPiA+PiDvu79PbiA5LzMwLzI2IDE0
OjE2LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gPj4+IE9uIDMwLzkvMjYgMTM6
NTAsIEPDg8KpZHJpYyBMZSBHb2F0ZXIgd3JvdGU6DQo+ID4+Pj4+IE5vdGUgdG8gUGV0ZXI6IEkg
cmVhbGx5IHRoaW5rIGtlZXBpbmcgZHVwbGljYXRpbmcgdGhlDQo+ID4+Pj4+IFVuaW1wbGVtZW50
ZWREZXZpY2VDb25maWcgc3RydWN0dXJlIGlzIGEgYmFzaWMgc29mdHdhcmUNCj4gPj4+Pj4gZGV2
ZWxvcG1lbnQgYW50aXBhdHRlcm4uIENvdWxkIHlvdSByZWNvbnNpZGVyIHlvdXIgb2JqZWN0aW9u
Pw0KPiA+Pj4+IFdoYXQncyB0aGUgYmFja2dyb3VuZCA/DQo+ID4+PiBJIHRoaW5rIHRoYXQgd2Fz
IGRpc2N1c3NlZCBvbiBJUkMsIHRoZSBvbmx5IHJlZiBvbiB0aGUgbGlzdCBpczoNCj4gPj4+DQo+
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvQ0FGRUFjQV9vYjZtSHFmQUFNOWlB
TWFlNXZmeGFZaG1jDQo+ID4+PiBxa2stZ0pIK3MxbUh1dkZwOGdAbWFpbC5nbWFpbC5jb20vDQo+
ID4+PiBjcmVhdGVfdW5pbXBsZW1lbnRlZF9kZXZpY2UoKSBjYWxscyBxZGV2X2NyZWF0ZSgpIGFu
ZCBhbGxvY2F0ZSBvbg0KPiA+Pj4gdGhlIGhlYXAsIG15IG1vdGl2YXRpb24gd2FzIHRvIGhhdmUg
YW5vdGhlciBoZWxwZXIgZm9yIGluLXBsYWNlIGluaXQNCj4gPj4+ICh3aGVuIHRoZSBVbmltcGxl
bWVudGVkRGV2aWNlU3RhdGUgc3RhdGUgaXMgZW1iZWRkZWQgaW4gdGhlIHBhcmVudCkuDQo+ID4+
PiBOb3cgd2UgZW5kZWQgd2l0aCBzdWNoIGhlbHBlcnMgbGlrZQ0KPiBhc3BlZWRfbW1pb19tYXBf
dW5pbXBsZW1lbnRlZCgpDQo+ID4+PiB3aGljaCByZWFsaXplIGluIHBsYWNlLCBtYWtlX3VuaW1w
X2RldigpIGFuZCBjcmVhdGVfdW5pbXAoKSBpbml0IGFuZA0KPiA+Pj4gcmVhbGl6ZSBpbiBwbGFj
ZSBhbmQgSmFtaW4gYWRkcyB5ZXQgYW5vdGhlciBwYXR0ZXJuLiBXaGlsZSBhbGwgYXJlDQo+ID4+
PiB2YWxpZHMsIEknZCByYXRoZXIgdW5pZnkuDQo+ID4+DQo+ID4+IENvdWxkIGFuIGFycmF5IHN1
Y2ggYXMgwqA6DQo+ID4+DQo+ID4+IHN0YXRpYyBjb25zdCBBc3BlZWRVbmltcERldmljZSBhc3Bl
ZWRfc29jX2FzdDI3MDBfdW5pbXBfZGV2c1tdID0gew0KPiA+PiDCoMKgwqB7ICJkcG1jdSIsIMKg
ImFzcGVlZC5kcG1jdSIsIMKgQVNQRUVEX0RFVl9EUE1DVSwgwqAweDAwMDQwMDANCj4gMCB9LA0K
PiA+PiDCoMKgwqB7ICJpb21lbSIsIMKgImFzcGVlZC5pbyIsIMKgwqDCoMKgQVNQRUVEX0RFVl9J
T01FTSwgwqAweDAwRkUwMDAwDQo+ICB9LA0KPiA+PiDCoMKgwqB7ICJpb21lbTAiLCAiYXNwZWVk
LmlvbWVtMCIsIEFTUEVFRF9ERVZfSU9NRU0wLCAweDAxMDAwMDAwIH0sDQo+ID4+IMKgwqDCoHsg
ImlvbWVtMSIsICJhc3BlZWQuaW9tZW0xIiwgQVNQRUVEX0RFVl9JT01FTTEsDQo+IDB4MDEwMDAw
MDAgfSwgfTsNCj4gPj4NCj4gPj4gYmUgZGVmaW5lZCBhdCB0aGUgY2xhc3MgbGV2ZWwgb2YgdGhl
IFNvQyBhbmQgaGFuZGxlZCBhdXRvbWF0aWNhbGx5ID8NCj4gPj4NCj4gPj4gSSBndWVzcyB3b3Vs
ZCBuZWVkIHNvbWUga2luZCBvbiBjb21tb24gU29DIG1vZGVsIGluIHRoYXQgY2FzZS4NCj4gPj4N
Cj4gPj4gQy4NCj4gPj4NCj4gPiBIaSBDw6lkcmljLA0KPiA+DQo+ID4gSSB3aWxsIHJlc2VuZCB2
MiBhbmQgcmV3b3JrIHRoZSBkZXNpZ24gYWxvbmcgdGhlc2UgbGluZXMuDQo+IA0KPiBQbGVhc2Ug
d2FpdCBhIGJpdCBmb3IgUGhpbCdzIGZlZWRiYWNrLg0KPiANCj4gPiBEZWZpbmluZyB0aGUgdW5p
bXBsZW1lbnRlZCBkZXZpY2VzIGFzIGEgY2xhc3MtbGV2ZWwgYXJyYXkgYW5kIEkgd2lsbA0KPiA+
IGxvb2sgaW50byBpbnRyb2R1Y2luZyBhIGNvbW1vbiBTb0MgaGVscGVyL21vZGVsIGZvciB0aGlz
Lg0KPiANCj4gVGhpcyBjb3VsZCBiZSBhIHN0YXJ0IGZvciBhIG1vcmUgZ2VuZXJhbGl6ZWQgc29s
dXRpb24uDQo+IA0KPiA+IEJlc2lkZXMgdGhhdCwgd2UgZm91bmQgdGhhdCBwYXRjaCAxMSBicmVh
a3MgdGhlIEFTVDI3MDAgSS9PIGV4cGFuZGVyDQo+IHN1cHBvcnQuDQo+IA0KPiBBaC4gRGlkIHRo
ZSBmdW5jdGlvbmFsIGNhdGNoIHRoaXMgcmVncmVzc2lvbiA/DQo+IA0KTm8sIHdlIGRvbid0IGhh
dmUgYSBmdW5jdGlvbmFsIHRlc3QgY292ZXJpbmcgSU8gRXhwYW5kZXIgMSBJMkMuDQpJIHdpbGwg
YWRkIGEgZnVuY3Rpb25hbCB0ZXN0IHRvIGNvdmVyIGl0IGFuZCBjYXRjaCB0aGlzIGtpbmQgb2Yg
cmVncmVzc2lvbiBpbiB2Mi4NCg0KVGhhbmtzLA0KSmFtaW4NCg0KPiA+IFRoZSBkZXZpY2UgbGlz
dCBzaG91bGQgaW5jbHVkZToNCj4gPg0KPiA+IEFTUEVFRF9ERVZfSU9FWFAwX0kyQywNCj4gPiBB
U1BFRURfREVWX0lPRVhQMV9JMkMsDQo+ID4gQVNQRUVEX0RFVl9JT0VYUDBfSTNDLA0KPiA+IEFT
UEVFRF9ERVZfSU9FWFAxX0kzQywNCj4gPiBBU1BFRURfREVWX0lPRVhQMF9JTlRDSU8sDQo+ID4g
QVNQRUVEX0RFVl9JT0VYUDFfSU5UQ0lPLA0KPiA+DQo+ID4gSSB3aWxsIGZpeCB0aGlzIGluIHYy
IGFzIHdlbGwuDQo+IA0KPiBPSy4NCj4gDQo+IFRoYW5rcywNCj4gDQo+IEMuDQo+IA0KDQo=

