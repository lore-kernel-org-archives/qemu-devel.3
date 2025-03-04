Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F4EC021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 10:04:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpP7f-0006Cc-Ov; Tue, 04 Mar 2025 05:03:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tpP7U-0006AJ-DN; Tue, 04 Mar 2025 05:03:27 -0500
Received: from mail-sg2apc01on20713.outbound.protection.outlook.com
 ([2a01:111:f403:200f::713]
 helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tpP7L-0007EN-M3; Tue, 04 Mar 2025 05:03:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gbL4Vzt2BjcN+hKrN5dL6vS9zu0+Du21NOBMMt96VUODzfJ9xsBxMoOUEQdj9q/15UwRgfVg/IWj+4uwPcVobJICowrkxUkgGaIDL3izzccNRKSir/Rx4elUplfRVw2+8HPHHI4yj8M3+3Nd4TogwpcYaykPiewBo1mBOosSe2w2dUuWd+QMY2FGzHYqBsR542xB+6hXP+mpTEAHZX1U9l5i8ywiHPOidyyrEUHImXQxNiHoI4LjuRb6khsfsLa/sWWrX9ljq/xrboMkEiBrSr8thozDTAtef2bJbJi9edynrIx289zRepTBQH85ApU+XlFYJGxbP6Q75ynUnBxPcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mLL16b/WqZqqG29cONY8WomPEIhJyspmzpHS9DfFAww=;
 b=PxfE+z0BQLOyrwrXaI/f3yy/ItTb1cyUiHA3u1vGPrTsyWtAh7OsU6kFYkrCTbaTEFepF9oRVgUIG50Sew5hh26qIooPjzgRCXfU2ReFc5RB04tSJITweZKFKSAuZTDsBafkgLcefGj6LM/jjXR0Ccl5WuMTzCNxRPBFcNpHHyyM3MRtZzU5y43LKN/V4aIPAE2Oi9Ssb0A+2kH7Z7A5ezgBtUje+z6WB7QQ602VMGJyzjpTf3BBo72ryq1d/xhELsUWzgiwQyUngaOWUBXxQsSs702DxXc6S2YItE5Il2uPuHasX0XVAmFVh2o/tr51YcyaRcMKEbHHOPUPRYxLrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mLL16b/WqZqqG29cONY8WomPEIhJyspmzpHS9DfFAww=;
 b=gLBg3qCBRsBpgtL5RK+ovaBYAGFsHEldhabhTElwVAwCCtWl3/KanB06p9oHsTW/ED4ojbpVbiLldiEHD2RrJthoAqBcS6QzOZck1lrsJaTxZnhd6hau9Hx8XFMACWXkXZruBoqzULperJr+VY3digld2gLQ4wQgEYc91NM6LnFeeTORv3oJiB8QPi//RGt8Qox3NAL5rQuq3PY+WoFdsZyOhQmCaHtzWgPiQEQd+0xQKMhG34v9DZJZQmNNcFt0NcpQz0Vzbje/80m63DSXi3ODTgoDRy//0tzly7l3dyXEzjuOMI1Pex2MUqz5qugWr8WA+3GoNsdOYJFlbihrow==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TYZPR06MB5075.apcprd06.prod.outlook.com (2603:1096:400:1c5::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.28; Tue, 4 Mar 2025 10:03:02 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 10:03:02 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v4 02/23] hw/intc/aspeed: Support setting different
 register sizes
Thread-Topic: [PATCH v4 02/23] hw/intc/aspeed: Support setting different
 register sizes
Thread-Index: AQHbjCJW61vDmafg3UCN4/iC6oXZm7Nhb0CAgAFO4vA=
Date: Tue, 4 Mar 2025 10:03:02 +0000
Message-ID: <SI2PR06MB50418330F56FE29AC5C87781FCC82@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250303095457.2337631-1-jamin_lin@aspeedtech.com>
 <20250303095457.2337631-3-jamin_lin@aspeedtech.com>
 <91f57db1-515c-4594-84a6-cdfd776ef2c9@kaod.org>
In-Reply-To: <91f57db1-515c-4594-84a6-cdfd776ef2c9@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TYZPR06MB5075:EE_
x-ms-office365-filtering-correlation-id: 65566015-8709-4f0a-931b-08dd5b03c018
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QWVvbE9VaUpPbUg1dVF3Q3dBbUYrNy9iYURsQithOEhsZ3NsQnRMNkd1QVdv?=
 =?utf-8?B?RlRVYk45Mkhsa2VwWHZNZitFbDVZc1BwRk02VVBaQy9wbG1scjFJQzFFN1dB?=
 =?utf-8?B?NUE4U2VSUXhTYk1aWlVTYjdXaHpROFcxNFRFQWpJZFA5OE85bGNrT2hUTWhw?=
 =?utf-8?B?a0tjeFdLZm1rSWdsY0V2WHIxeEFrbHdIRll6VDlHTVZpNWJBWXpJeHlSdGFv?=
 =?utf-8?B?cFZyYWpCU3RXdDluMlVPSUZZWEZWY3p5ZGh2WVd5QmpWVDFNQVgwajNjZnZw?=
 =?utf-8?B?SVlDUi9jMXUrUmJlelVjd1JWV3Y4OXNLd3lvUHBNNlliN2ZoVmJBZVZSMm5p?=
 =?utf-8?B?NUVvdUZWOEpKYUR6czNGbUNwZ05jY2ROUGFrRFEyUS83NWpRTUVyelFPQnRV?=
 =?utf-8?B?MlRjRG1MK2FzZVlDZzVlNW8xRVFOWVMwZTUvMDY2YnZtaDFCMW1XOWp3TTlh?=
 =?utf-8?B?d0RnUDBLTnM1eGlSSk9NODcyWXdSMThLS0VSYVZMaE9aZWxFUEdIRzJhTE8v?=
 =?utf-8?B?Q0FZb0IwaXlHY3M4Q3BvUUZhMkFvMmZSR1QyOE5IM0syZExHRml0QzE4NkF3?=
 =?utf-8?B?OENUWEpTY0l5ZnE2Si9Jck5pR2JYZUQzMUVsdjM4WldSeE1GNTNqd09JYzZ0?=
 =?utf-8?B?aWZtRW9qSHZmbmJYRzV5Qm1OMzAzaEdrWnZlZSs4VXBtT3VYOTFzNkhLN3NX?=
 =?utf-8?B?T2EyNWVZQ1Y4SktXdGIzKzlJYnc0SFJYcFllQ0Rkb2grWHlBeUhqNWozU1RT?=
 =?utf-8?B?eUZTRGFZOWUzZ1A0QnFXRG0wVW8velA2NitBVFpsQXdYVnduWTN6ZFBuZm5N?=
 =?utf-8?B?OThXRGZLMjdDdTgyRDVoUUlaVmRmOHRwQzdXVmZ2eGQ0K0NuRE9JbXNSL0lL?=
 =?utf-8?B?anIvd1BscGcvTWFOVU9WMXMzWEhNbXFIWlpIamhWb0h5WVpoVEoxMnI5bzJP?=
 =?utf-8?B?amdCZjhtdjBQVmxlb0h2blY4MnlhZjZpUW5rWnVmU0ZKRUxOa0ExQVlLN0kx?=
 =?utf-8?B?UU1xUHlWTE9GTGlTa0htMkZIL3RwcVNNNWdZMktaTWhsbm01UWFlbEVCclhJ?=
 =?utf-8?B?Tk5RUVh6T3JNVUp6RUI2T0prSnZxWWR5eU9zdHVDTW1kVHJzS1c5a1JTWnU3?=
 =?utf-8?B?amQzb0lYc0lwRUlMdHUwR2U4bTVuM3VuWFdtNFpjVzlRK015UmJlald5a04r?=
 =?utf-8?B?dTZQckZvVXROb1dwQnRzS01IdGFubjdHUnlKZFV0cDB2d0R1bUlSNlVzUm4v?=
 =?utf-8?B?dXBKdks0VnZ0aU50VWtla3lHWVIvM1F5NDR0Sk5iclNPZHNDejRNQ2NJNCtj?=
 =?utf-8?B?OWxWeUcxSFRUMG1mQ0gyc0VNNnBmNG95RVBXbEJPN2pGcTNpc3ljcDR4NlYw?=
 =?utf-8?B?aXdRLzJKWlk2cW1CZ1FvTEJqZDQvdE1tNVJMY0g3ZTBxeW41UXlrYWZ3ejJC?=
 =?utf-8?B?WEliZ0RpVXJDMEs0ZGdBSTBqOWMvcVlIVFZRWCtqZlg2djJuN2tqWTdKb1lz?=
 =?utf-8?B?VFUwWURnUEllS09lbHQrVUluMCt6Z3BhcU5RR0RSU3Z2cnBvSy9oYkxCQkE2?=
 =?utf-8?B?Z25PLy83M0tMcWlyNGZQWlpUYzgwT0ZRNDNaNmJxSzBTeFIzVHRId0ZLaTF2?=
 =?utf-8?B?WmNKSlN3eURmTzJwdGY4ZXNJcGRhcndBMXc4V1BmczhpdG5xTWFwb1lPdFVY?=
 =?utf-8?B?ZFN1QmsrZm1EcUNJUE5LU3NaNHhsVU1DamJXTk5uZy9VR0UxMENiUFNZRlpZ?=
 =?utf-8?B?MDRWWTZJQlZEUXNsTDFqckpacXlRTGRBNUlvNUtONks3RXl6T1p5SDJrdVJQ?=
 =?utf-8?B?bkhZZXBNZFRCbTNKQjZnd3NkVnVkQUdna2s2ell5b01GaDI0U3N4di96TlF3?=
 =?utf-8?B?SXBQNUxkL1I0M0R5UC8ycTViVTlnczdSc0txc2pHRlJuQVhKZGI5em5mdXhy?=
 =?utf-8?Q?pABuqdZq1DvGQZmTU+hBvE/+tVajgBe6?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YVU5YUN4dmZXS00xU0hMRHVHU2tUZ3Jta2ErN1dWQlJZTVVSQXo3TmdBcE1F?=
 =?utf-8?B?NXYvSFpHbFJlNXl2YWZSSnVicWgrSlR4SmVLMTF5d0dLNzAyTWZhd0FGZXRV?=
 =?utf-8?B?NlozYnBVbnVINmx2cUhWSFozUFh4TWNaTEdFN0RpWG9NL1kvWDFNbVFLVVBl?=
 =?utf-8?B?UlNLR2tUN0RBRnRpQ1pHZWQ2N1RCTk4vL0k3MUd3bnorWDV3Y2p1SXBxU2N0?=
 =?utf-8?B?R3lhdlMxcm1lcUtKS2tMaDBFeThLYmlyWkR2OU9nc2h2UXlZc1NhOTNybnhG?=
 =?utf-8?B?bzFxVlFQOUJNQmI1dkt0MEhYNkN1VlhQeFMxSTlmaDVnYVIyVGdsY0Y1S3k0?=
 =?utf-8?B?blRCb20xQ3VxNyt0T2xDcHNZd2RhZ1BZRGJpcjY5VDVxVGJZR3UraXZNblhZ?=
 =?utf-8?B?WC9GaTRoV0JkZ1d5WnZER0JlSnNJSFkzOTFjODlSalJxYnRQa3V3ZU5SU1px?=
 =?utf-8?B?bDYwNVo5bVRzUXA4REs5aW5VU0JmOVVaMG1TWVFGQXRleFJCeGloM3ZXMnlq?=
 =?utf-8?B?NHhndnk1MXpYWnVMSWRPY2U4UkNmT2FiYmhLT01zeHN0cmdTYmVQMFNNdklu?=
 =?utf-8?B?YmFlNVp0bFZtUzhKcitEdDJYZ0VDakNUaTZOOXpVWlNaSU9lZ1lGV2doOVNP?=
 =?utf-8?B?N0tFSWk1cTdEcW85dkRTeWppOHl6Z1IyL2VhMmlVYXZ5TFZrVnBrQUxMRGNj?=
 =?utf-8?B?L1Y5dHhjdVB5N2YvL1RXNVlQUE1sZ1pkbkwwQjFRcldOWnpQcHdGVG1Wb3Vk?=
 =?utf-8?B?RVpIeklOSjdrVGt5TDFxcDhzOE9wR2tIWDJJa3V1cmh3Zi9XMzV1bGYxWld6?=
 =?utf-8?B?TzcwU08yNE1ORU13Ly9lZjRDUnZOUnpOVG44cXJ0YVRxcHlsb3h5aFlhUXN5?=
 =?utf-8?B?Um40RUFUTmIyMG1Zbksyc2t5bzFxUUszNGVXUHhDMFJJWWF3aW42MEJyQ3hI?=
 =?utf-8?B?d3E2L2JGbDFEUW8xTGJ4R0F6VEEvTElraTdINWtrNk12aWRGUG5ZVlhzbFRW?=
 =?utf-8?B?Z1hkZWhqV0V3d1NYYXQvUWc2aVNZZ3dXeGFJMXVxaHB6VnQ2S29BeHlDQzJ5?=
 =?utf-8?B?Z0ZBRnhuck0xeFE2dFk3SFkxbWpTSzFpOUI2dGExcEgrdjI4UHM2Tzk0SUFQ?=
 =?utf-8?B?dHk4am1wQ0lzM2Nkb1c2djJZRnJhUCtmRGYxS1lSclMybmRLSS9USEQ2TjA5?=
 =?utf-8?B?Q2xCbGpWdEo4eDk5K2tyUjE3emh5eWx0UkEvSXd5OW5yRE0wb3V6Sk5IUEli?=
 =?utf-8?B?OGJxc1hzaFU5amRYZC9WRmdiMUR2Nnl6bEg3NU9vR0NQamwzd1NLSy9NTUFL?=
 =?utf-8?B?NUhaVnFSR3lqeXYyYWN0MXgxVm1FMGloM1ZmUlNicGlKbWE1VFRhaFBSWmZZ?=
 =?utf-8?B?c3cyUG1ZcmtUMWZBSzNYSis0VDJ3dlBXTGxkWGNta1J2cU1FaTlBbEdvQ3lR?=
 =?utf-8?B?OUlITjB4MUU2bW9ic213ZHJhTmUvRUlyOHlEOWh2NXhLR3piemxiTHhralJO?=
 =?utf-8?B?eG9zZHQzZ09FeEQrZHJWanJWc0tKZEFKYllQYVZ3OStxWGY4K2RySnEyZGc3?=
 =?utf-8?B?VnNBUVVPTUo4NUtTa09aK29oNE1Wd25hWklldkoyYndRcFlHRGlnWmU0dkJj?=
 =?utf-8?B?MkVobE5mZ09VRXlocXU2ZUE0bkoydS82UjBpanBMUHpTZFBpaTl6L0YrU2d0?=
 =?utf-8?B?dEUwaVJCYnNRaWFkV29pTjg0N1RRakVTekVGWnlzK0k0Q0YwSm9MbnZXc3h0?=
 =?utf-8?B?T0ZTS0dTODlTSTFjdVVzU2NxS2dRN01TNndIVDFTcmg2bTdhWk9nZW5sU0lX?=
 =?utf-8?B?KzFPb3YrMkduTGROa1lpYjd3Y09xT00vRHhIYWpOcVRMUS9iVGswVFdhYnVF?=
 =?utf-8?B?ZDBwNXRYblNwOW02UWc0dUlsOGVDVEtDMEpVTXc3OXcvMW42SVZYMjBxNndK?=
 =?utf-8?B?bm5ZOXF4TzRmNkszTDRDa2ZKaTFoZHMxVmdOMmVGQTYzWWpoNU9TczA0TUxI?=
 =?utf-8?B?ZWNoTXA5ZkRMNTZ5MTNTaUdpTC9iajl0eEpoamQ5VUd3dmFOYU9tRVltUTV1?=
 =?utf-8?B?ZmhYTW9NdW5hU0tqKzFmNFdVYnRaNGZUVU1YeERkUTRrQVRtOG4zY0hpQTBF?=
 =?utf-8?Q?U6gnK1HTFZn+FBZ8/wG4umY9H?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65566015-8709-4f0a-931b-08dd5b03c018
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 10:03:02.1855 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nhavGQMKNNwbHX+aTp0JNa6BtjI9Umwr7b9euE7sSaRm35jpJPVKJCQdF1Zpu9PUDG2BoO6lJyxHGqo8gQJ7Fl5KejUL7kjjPLNwSnyPixM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5075
Received-SPF: pass client-ip=2a01:111:f403:200f::713;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-SG2-obe.outbound.protection.outlook.com
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

SGkgQ2VkcmljLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMDIvMjNdIGh3L2ludGMvYXNw
ZWVkOiBTdXBwb3J0IHNldHRpbmcgZGlmZmVyZW50DQo+IHJlZ2lzdGVyIHNpemVzDQo+IA0KPiBP
biAzLzMvMjUgMTA6NTQsIEphbWluIExpbiB3cm90ZToNCj4gPiBDdXJyZW50bHksIHRoZSBzaXpl
IG9mIHRoZSByZWdzIGFycmF5IGlzIDB4MjAwMCwgd2hpY2ggaXMgdG9vIGxhcmdlLg0KPiA+IFNv
IGZhciwgaXQgb25seSB1c2UgR0lDSU5UMTI4IC0gR0lDSU5UMTM0LCBhbmQgdGhlIG9mZnNldHMg
ZnJvbSAwIHRvIDB4MTAwMA0KPiBhcmUgdW51c2VkLg0KPiA+IFRvIHNhdmUgY29kZSBzaXplLCBp
bnRyb2R1Y2UgYSBuZXcgY2xhc3MgYXR0cmlidXRlICJyZWdfc2l6ZSIgdG8gc2V0DQo+ID4gdGhl
IGRpZmZlcmVudCByZWdpc3RlciBzaXplcyBmb3IgdGhlIElOVEMgbW9kZWxzIGluIEFTVDI3MDAg
YW5kIGFkZCBhDQo+ID4gcmVncyBzdWItcmVnaW9uIGluIHRoZSBtZW1vcnkgY29udGFpbmVyLg0K
PiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5j
b20+DQo+ID4gLS0tDQo+ID4gICBpbmNsdWRlL2h3L2ludGMvYXNwZWVkX2ludGMuaCB8IDEgKw0K
PiA+ICAgaHcvaW50Yy9hc3BlZWRfaW50Yy5jICAgICAgICAgfCA4ICsrKysrLS0tDQo+ID4gICAy
IGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+
IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2ludGMvYXNwZWVkX2ludGMuaA0KPiA+IGIvaW5jbHVk
ZS9ody9pbnRjL2FzcGVlZF9pbnRjLmggaW5kZXggMDMzMjRmMDVhYi4uZWNhZWIxNWFlYSAxMDA2
NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2h3L2ludGMvYXNwZWVkX2ludGMuaA0KPiA+ICsrKyBiL2lu
Y2x1ZGUvaHcvaW50Yy9hc3BlZWRfaW50Yy5oDQo+ID4gQEAgLTQyLDYgKzQyLDcgQEAgc3RydWN0
IEFzcGVlZElOVENDbGFzcyB7DQo+ID4gICAgICAgdWludDMyX3QgbnVtX2xpbmVzOw0KPiA+ICAg
ICAgIHVpbnQzMl90IG51bV9pbnRzOw0KPiA+ICAgICAgIHVpbnQ2NF90IG1lbV9zaXplOw0KPiA+
ICsgICAgdWludDY0X3QgcmVnX3NpemU7DQo+ID4gICB9Ow0KPiA+DQo+ID4gICAjZW5kaWYgLyog
QVNQRUVEX0lOVENfSCAqLw0KPiA+IGRpZmYgLS1naXQgYS9ody9pbnRjL2FzcGVlZF9pbnRjLmMg
Yi9ody9pbnRjL2FzcGVlZF9pbnRjLmMgaW5kZXgNCj4gPiAwMzNiNTc0YzFlLi4zMTY4ODVhMjdh
IDEwMDY0NA0KPiA+IC0tLSBhL2h3L2ludGMvYXNwZWVkX2ludGMuYw0KPiA+ICsrKyBiL2h3L2lu
dGMvYXNwZWVkX2ludGMuYw0KPiA+IEBAIC0xMTcsMTAgKzExNywxMSBAQCBzdGF0aWMgdm9pZCBh
c3BlZWRfaW50Y19zZXRfaXJxKHZvaWQgKm9wYXF1ZSwgaW50DQo+IGlycSwgaW50IGxldmVsKQ0K
PiA+ICAgc3RhdGljIHVpbnQ2NF90IGFzcGVlZF9pbnRjX3JlYWQodm9pZCAqb3BhcXVlLCBod2Fk
ZHIgb2Zmc2V0LCB1bnNpZ25lZA0KPiBpbnQgc2l6ZSkNCj4gPiAgIHsNCj4gPiAgICAgICBBc3Bl
ZWRJTlRDU3RhdGUgKnMgPSBBU1BFRURfSU5UQyhvcGFxdWUpOw0KPiA+ICsgICAgQXNwZWVkSU5U
Q0NsYXNzICphaWMgPSBBU1BFRURfSU5UQ19HRVRfQ0xBU1Mocyk7DQo+ID4gICAgICAgdWludDMy
X3QgYWRkciA9IG9mZnNldCA+PiAyOw0KPiANCj4gJ2FkZHInIGlzIGEgY29uZnVzaW5nIG5hbWUu
IEFzIGl0IGlzIHVzZWQgYXMgYSByZWdpc3RlciBpbmRleCwgSSB0aGluayAncmVnJyB3b3VsZA0K
PiBiZSBtb3JlIGFwcHJvcHJpYXRlLg0KDQpXaWxsIGZpeCBpdC4NCj4gDQo+ID4gICAgICAgdWlu
dDMyX3QgdmFsdWUgPSAwOw0KPiA+DQo+ID4gLSAgICBpZiAoYWRkciA+PSBBU1BFRURfSU5UQ19O
Ul9SRUdTKSB7DQo+ID4gKyAgICBpZiAob2Zmc2V0ID49IGFpYy0+cmVnX3NpemUpIHsNCj4gDQo+
IFRoaXMgaXMgYSB1c2VsZXNzIHRlc3Qgc2luY2UgdGhlIG1lbW9yeSByZWdpb24gJ3MtPmlvbWVt
JyBpcyBpbml0aWFsaXplZCBiZWxvdw0KPiB3aXRoIHNpemUgJ2FpYy0+cmVnX3NpemUnLg0KPiAN
ClNvcnJ5LCBJIGxvc3QgdG8gcmVtb3ZlIGl0Lg0KDQo+ID4gICAgICAgICAgIHFlbXVfbG9nX21h
c2soTE9HX0dVRVNUX0VSUk9SLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICIlczogT3V0
LW9mLWJvdW5kcyByZWFkIGF0IG9mZnNldCAweCUiDQo+IEhXQUREUl9QUkl4ICJcbiIsDQo+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgX19mdW5jX18sIG9mZnNldCk7IEBAIC0xNDMsNyArMTQ0
LDcgQEANCj4gc3RhdGljDQo+ID4gdm9pZCBhc3BlZWRfaW50Y193cml0ZSh2b2lkICpvcGFxdWUs
IGh3YWRkciBvZmZzZXQsIHVpbnQ2NF90IGRhdGEsDQo+ID4gICAgICAgdWludDMyX3QgY2hhbmdl
Ow0KPiA+ICAgICAgIHVpbnQzMl90IGlycTsNCj4gPg0KPiA+IC0gICAgaWYgKGFkZHIgPj0gQVNQ
RUVEX0lOVENfTlJfUkVHUykgew0KPiA+ICsgICAgaWYgKG9mZnNldCA+PSBhaWMtPnJlZ19zaXpl
KSB7DQo+ID4gICAgICAgICAgIHFlbXVfbG9nX21hc2soTE9HX0dVRVNUX0VSUk9SLA0KPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgICIlczogT3V0LW9mLWJvdW5kcyB3cml0ZSBhdCBvZmZzZXQg
MHglIg0KPiBIV0FERFJfUFJJeCAiXG4iLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIF9f
ZnVuY19fLCBvZmZzZXQpOyBAQCAtMzA4LDcgKzMwOSw3IEBADQo+IHN0YXRpYw0KPiA+IHZvaWQg
YXNwZWVkX2ludGNfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2LCBFcnJvciAqKmVycnApDQo+ID4g
ICAgICAgc3lzYnVzX2luaXRfbW1pbyhzYmQsICZzLT5pb21lbV9jb250YWluZXIpOw0KPiA+DQo+
ID4gICAgICAgbWVtb3J5X3JlZ2lvbl9pbml0X2lvKCZzLT5pb21lbSwgT0JKRUNUKHMpLCAmYXNw
ZWVkX2ludGNfb3BzLA0KPiBzLA0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgIFRZUEVf
QVNQRUVEX0lOVEMgIi5yZWdzIiwNCj4gQVNQRUVEX0lOVENfTlJfUkVHUyA8PCAyKTsNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICBUWVBFX0FTUEVFRF9JTlRDICIucmVncyIsIGFpYy0+
cmVnX3NpemUpOz4NCj4gPiAgICAgICBtZW1vcnlfcmVnaW9uX2FkZF9zdWJyZWdpb24oJnMtPmlv
bWVtX2NvbnRhaW5lciwgMHgwLA0KPiA+ICZzLT5pb21lbSk7DQo+ID4NCj4gPiBAQCAtMzUxLDYg
KzM1Miw3IEBAIHN0YXRpYyB2b2lkIGFzcGVlZF8yNzAwX2ludGNfY2xhc3NfaW5pdChPYmplY3RD
bGFzcw0KPiAqa2xhc3MsIHZvaWQgKmRhdGEpDQo+ID4gICAgICAgYWljLT5udW1fbGluZXMgPSAz
MjsNCj4gPiAgICAgICBhaWMtPm51bV9pbnRzID0gOTsNCj4gPiAgICAgICBhaWMtPm1lbV9zaXpl
ID0gMHg0MDAwOw0KPiA+ICsgICAgYWljLT5yZWdfc2l6ZSA9IDB4MjAwMDsNCj4gDQo+IHRoZSBt
b2RlbCBzdGlsbCB1c2VzIEFTUEVFRF9JTlRDX05SX1JFR1MgaW4gOg0KPiANCj4gICAgICBzdHJ1
Y3QgQXNwZWVkSU5UQ1N0YXRlIHsNCj4gICAgICAgICAgLi4uDQo+ICAgICAgICAgIHVpbnQzMl90
IHJlZ3NbQVNQRUVEX0lOVENfTlJfUkVHU107DQo+ICAgICAgICAgIC4uLg0KPiANCj4gd2hpY2gg
aXMgcmVkdW5kYW50IGFuZCBlcnJvciBwcm9uZSBJTU8uDQo+IA0KDQpEbyB5b3UgbWVhbiB1c2lu
ZyAiZ19tYWxsb2MiIGluc3RlYWQgb2YgdGhlIHN0YXRpYyByZWdzIGFycmF5Pw0KSWYgSSB1bmRl
cnN0YW5kIHlvdXIgcXVlc3Rpb24gY29ycmVjdGx5LCBJIHdpbGwgbWFrZSB0aGUgZm9sbG93aW5n
IGNoYW5nZXMuDQoNCjEuIHVpbnQzMl90IHJlZ3NbQVNQRUVEX0lOVENfTlJfUkVHU107IC0tPiB1
aW50MzJfdCAqcmVnczsNCjIuIGFzcGVlZF8yNzAwX2ludGNfY2xhc3NfaW5pdCgpIHsNCiAgICAg
IHJlZ3MgPSBnX21hbGxvYyhhaWMtPnJlZ19zaXplKTsNCiAgfQ0KMy4gc3RhdGljIHZvaWQgYXNw
ZWVkX2ludGNfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2LCBFcnJvciAqKmVycnApIHsNCiAgIG1l
bW9yeV9yZWdpb25faW5pdF9pbygmcy0+aW9tZW0sIE9CSkVDVChzKSwgJmFzcGVlZF9pbnRjX29w
cywgcywNCiAgICAgICAgICAgICAgICAgICAgICAgICAgVFlQRV9BU1BFRURfSU5UQyAiLnJlZ3Mi
LCBhaWMtPnJlZ19zaXplKTsNCiB9DQoNCkkgaGF2ZSBhIHF1ZXN0aW9uOiB3aGVyZSBzaG91bGQg
SSBmcmVlIHRoZSBkeW5hbWljYWxseSBhbGxvY2F0ZWQgbWVtb3J5IGZvciByZWdzPw0KDQpDb3Vs
ZCB5b3UgcGxlYXNlIGdpdmUgbWUgYW55IHN1Z2dlc3Rpb24/DQoNClRoYW5rcy1KYW1pbg0KDQo+
IFRoYW5rcywNCj4gDQo+IEMuDQo+IA0KPiANCj4gQy4NCg==

