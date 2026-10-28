Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36C5606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 01:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=Iz3Wb1uz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLsCI-0002Fn-Bc; Tue, 27 Oct 2026 21:11:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xLsCF-0002FR-WD; Tue, 27 Oct 2026 21:11:20 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xLsCD-0000Zl-ES; Tue, 27 Oct 2026 21:11:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DXQXtpjJKHxyHQCiZ3a2RSRvgYjNwvWm321x2g8mfdToVpoQntYd4M9LnWn3FxkzLQsqiDX9SCsT/VxIQTP9aZaqqz/KJNviG/099ZSwbhKIBgvdEsuKMnRNlQ/cjXqFRSDT6Iy6aIlOH6avmkSK2jU2XGirZmTGb20+Q4IoE6l//xxjYqYPfSR+Ulg4MsZ9ViDGOMOb88EQLU1iDDo0SmVYhnyh7rQic/p2/Ixc24ci2vG60ZcDqusIK/EgdfU/TxX/41teBcu/7WronG7EEfAA2Dng+VVbVgGFbuHIhTc/PZABj4OGJY5gxXnMd/TBSsJ5XBtADH44CYueMuj0UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Z3Ir1KrvP6CuBYq3dgcS0EsUOqIiwLswTMr8rSFvjQ=;
 b=xirYY/QS8Wa3cy1YjTpfcyD45U9OLs4DjR2ysdP92uvl8TEhziOqfNirx0bp+dNI8O8j+Dlr+bo5ZdRMNcO/e8Z4D6Ww9f2Zb3B9mF3qCppxb77iDjrEKMYRkPEUlgLrVf3XuWRE1H2HweCwRqRhYx/q7hOItAiAsDcmEe2Z1m6TUI2tWHG8ey3jC0KemorMi2g3zJlm3Hg0Mof2F7bWg/ppB0do1GM5+LlxBBtSLM4J+ryKXHCLYjsgwF0G/Ydj2j8mNiw5lJwZRGECgDLWGMo8/SE44Rjz9VkFn60nn7mtra1k5xEMRuASpWtPe4Nxch/pFnxHCZOCuVhlwSAwww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Z3Ir1KrvP6CuBYq3dgcS0EsUOqIiwLswTMr8rSFvjQ=;
 b=Iz3Wb1uzYgOURVuOvchOBeBQoJ5d0haB4jR8ld5LX2my3relZz8FjPucO7cRA1cUCQCmRQlVt6RrsL6Rtoo9BdPgj+I3DX+38/v6FiYiz4rFAOzVuYwf+qboB8npTDFBWeFhQ8X58mVJwdMBCOmjChIzOOEgebXizG4pwyd6tzlQSSbFrNqQ9QQZKsxZpLhNSlDdZwZs94qY1wnVen4XLxwNTtuuU3sU9p0bXZ1F4Sds8nvuRJZQTmoRxG6skfI74iSiJywGDbZcWHMywuV2DOzoxj2MoOm/0JxDdL6Kr6BPoGKskPuJtXeHH8UsKwQeGf6OOZ8uqt7UrAJqTLSMlQ==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TYNPR06MB8670.apcprd06.prod.outlook.com (2603:1096:405:3d1::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.7; Wed, 28 Oct
 2026 01:11:07 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0569.006; Wed, 28 Oct 2026
 01:11:07 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1 03/14] hw/block/m25p80: Rename w25q32dw to w25q33pw
Thread-Topic: [PATCH v1 03/14] hw/block/m25p80: Rename w25q32dw to w25q33pw
Thread-Index: AQHdXGn2L8V1TgY+PEeI7EZZXZP+LbcQHXkAgACPVJCAAItvAIABATpw
Date: Wed, 28 Oct 2026 01:11:07 +0000
Message-ID: <SEZPR06MB7362BF28624ABA67DA07D33FFC6F2@SEZPR06MB7362.apcprd06.prod.outlook.com>
References: <20261015055642.106204-1-jamin_lin@aspeedtech.com>
 <20261015055642.106204-4-jamin_lin@aspeedtech.com>
 <d4a1ce6f-96c9-422f-9380-b8c0bbdfa775@kaod.org>
 <TYZPR06MB73734264E93D567EF7AF1E0CFC602@TYZPR06MB7373.apcprd06.prod.outlook.com>
 <ceb9d0f6-0df6-44dc-ab59-ac9c41c4c1b8@kaod.org>
In-Reply-To: <ceb9d0f6-0df6-44dc-ab59-ac9c41c4c1b8@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TYNPR06MB8670:EE_
x-ms-office365-filtering-correlation-id: cfd17698-a7c5-4766-8ae7-08df349058b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|23010399003|366016|22082099003|6133799003|18002099003|921020|56012099006|4143699003|261026121527099003|261021121427099003|10067099003|261021123027099003|261022075727099003|38070700021;
x-microsoft-antispam-message-info: Ijhhs5BficS/CZUKAalsNna+6LZvZKq5bOWFzxwfrMBRvRz68446/gsQ1YOJfMEcmISfJzsS6lCgKwK+EfAoggNc8lvopm1xFHdSmDf/glL9sTyMeFO/GnY9x7WKoG77xsZm8LFevu4vJCht0Lk7VVZyxL1iVLVgn8/cLC2nkf7dW6d+GUuQXD6tC2BKDQKx4cV20Sgw3+C1QWRzJqK+cwbp1jjl1wboq7LZDiAHVanFwrwYXS4Hq7zj6GgCWHAbtGyf8ly8IGNQ6WcEJuJzj+5MAn2OkMXI4ItdLZijGNX/qVN3WacqwWT/Yx4pQQ8Wj9caX7B790xImuv472Cmpf8cbnhbM49oe7yqtaZPFY+sJY+kGRgizqzYFBWDzUHzHShNvBhPX426oklX5r7vNvWPqGdO+Iu8Mr2PvGleJsnqL04Joosxqbt4IzV+nmZbWJIwSFSS5vEfvwASr+VGrclSfPdhWNGrf2xqO1PT6Z8ZZG/3VCxfpkfBJwxt+/fi4Pr0Oj9ruLnRl1RYnF79xqzO1AtjzI+fA3j4CgiuFmPNyZewLPxIwQChQBlCtvCGIYleRkn7mKs5rz0uvax5sf9uvv32kSm+nnJDRPCWtjE6A+Oi34jxcP2EoOlIjv6Lw+LT0T5ClvMvuyQP6DhgK0IBss3Ro8bXsQ4egMzzmCIuvA6Q0LDIpcZkn0RTarwitIVAQ27wCjzbMvHbiTd11oz23Gz4nIivEQvOybZnVwWECxJs9De89bJNF0Xgukdv
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(22082099003)(6133799003)(18002099003)(921020)(56012099006)(4143699003)(261026121527099003)(261021121427099003)(10067099003)(261021123027099003)(261022075727099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nk5BSk5aTG4wcDdUZDFkTlJBRFNYeE12RFFDOCtHOUpDWGlac1FxWHBJZVRI?=
 =?utf-8?B?MTlxdU4yd0JPTE1XeG00Nk1qNnVrQVJJRmNpRlRGOWg5ZWlSYlBlczhJdGdF?=
 =?utf-8?B?OExUOWFGUVBtT1NyTnFtNitnSkVmVFZPV0kwUG1XZVhWMjlRcThUcTM2M0xB?=
 =?utf-8?B?UHIrbXl5ajg4WTU1WC81VFJJbTd6OC9rSDNpWnhKZFFQT09PZFRLdHh0VDQ3?=
 =?utf-8?B?SGwwZG9BeVprWmtuSjN6ZjY3OEk4VWRwY1czdkU2WnZOcXVIWUtsU0ZSNURL?=
 =?utf-8?B?bmxmN20rS2JOS2d1NE1NZ3BzaERJd0Nlc1U1ZkZ3cjNtOHFQVWRFbDNJVTVP?=
 =?utf-8?B?bWhhMzhLL1kzdk5JOHMrdEdNc0xoNXEzSWdHaFN5eENQbHZ1R2hYQlZyRmdx?=
 =?utf-8?B?MzJsODZJWEpsZnVVOGlycVRrK0NvWHVQQ2FUSlNuNnFIK1hnZ2tKOEQzWGFS?=
 =?utf-8?B?S1hjTUdwbjJHYmZNR2ZLR0gyYVozZGZieTAwSkVPckJlZXAzYUJxeGpYamNm?=
 =?utf-8?B?Z25aa3lQQ0NEYm51VmVmVW1JbmtKeXZ4K2xsR21Pd2xBb1RCNnhGYU9GWXRU?=
 =?utf-8?B?YmVMbTdtVFBRYVkzTlp3VFMrOWpzMVFqZUZTQzd2SFU0Slg5TEdxVmV3Q3hr?=
 =?utf-8?B?dkpkRDVseXJ6UHpPUGVXeTB0MnhIcFh6SGVTOHFWLy9sdkZtKzZLdGhlM3B0?=
 =?utf-8?B?bHg4VHBJUGNDMUNMM1JKWkplUDNUeFFrRm9idHJ0NUJmUktVVVFKakZQZ0tK?=
 =?utf-8?B?eVhBY2R1cVpna0pHTkdsUEJoMXRlQUc5RzZ6RUZPeGVrVXBaL2kwMVhsYUhs?=
 =?utf-8?B?RlBTWUk5RnRwZkZjM3pKTUNTMVZwZHkxVFlHd3F1SXdCdTFxRW1OdkkxUUxq?=
 =?utf-8?B?TG1aakpkeTE5RVlRdTUxNFpHcVhJYnhtN3c4WjlTSGZsZUdFQUlPck1lR2hh?=
 =?utf-8?B?UEFRY0xNTXEwWkVOL3crbkg5WjZMbDJsSXQzdlRBK0FSZmxTeUZNbEh4SHZm?=
 =?utf-8?B?dVRzVVA0MWtjUFVQRDgvMGdoWmFJVG95MkNkSUc5VTgwK1VKeDRSMFlrU3Jo?=
 =?utf-8?B?N0RhYWYzdmgwWEhjdGVweFd3aGlvc1M4a1dqNms2SlgzM08xZE5FdEdqM3pY?=
 =?utf-8?B?QTJjMkZVdDFXbmFGWWUzUnlBZ2RiWlpMZVJ2N21Rd2o3LzRlRFRnL1NyMGZJ?=
 =?utf-8?B?Q2Qwck9GakRoRzlwc3JPNHFTSDk0VktjaVBOd0IrQktJQXFpQ1h4UlJwVzNV?=
 =?utf-8?B?SlJOWkxaYTRXTElOMnRYYWJZbXUyRDlXcTRSMytKdUlwZkx6c2J6RjlEVDZU?=
 =?utf-8?B?bEswQ0pzanZIelhRN1hJb3dHd1RXekZxaVFhS1pGQUpkR2NIUkNJd0RQSldI?=
 =?utf-8?B?WmJPOHBGb3N4SmFrNlNLNE9JUktmakQ3bVpuWTllQ1BHYjVzTURMdStsVVNt?=
 =?utf-8?B?K1Z0dkp6TTRHaUdiekp3dXRacVRQdm9SeXRFRzg0MDRpaHR6bHUwdEE5Zmlv?=
 =?utf-8?B?b0dEb3N4TVA2ek5jR3pLaXRYUUNFYmZ0VzdoT3cvL0VsRTVMa0oyTFk1Wi8r?=
 =?utf-8?B?THBEM2N1dGZ1cWM3MUk4aEtuY21GemhXZDBtdnFESXFpNlJkcElVTVFBVytu?=
 =?utf-8?B?TFlGTUJOazBxQzFKOWNiQ0ZVTkVDdnhQRy9oQWEzNjhWL2RrSGFjeGl3K3dC?=
 =?utf-8?B?b0ZKSWJ2TXhRaVdvdk9QYXlqdXdqUmN0ZCtjRHQybXFSbkpQM1hVeElkZXhK?=
 =?utf-8?B?blRWeEJmakdTSUlFaGJnM3VEOHI0eXhKaFpRMmNaNTg0eVhmZWVPRFg2WUxq?=
 =?utf-8?B?NmpJekdMZ2VHODgyQnI0UmlxbHh1MzB5WVlFT0xjUE81ZmxzWFNuc1FVdjZ4?=
 =?utf-8?B?SVkvbitNVzl1U1BWa0pkRm1qZlI1Q1RES2dneDdzRFJyZ0pkeE9CZjlIczRr?=
 =?utf-8?B?WnNOK0hhT1NqT0hpRk1rM3lkQkh2UzV2aVUvN0p6d0JlZU9lVFVOa29xWG1K?=
 =?utf-8?B?bGlweExVVEtyRU12SU00SEkxTE1BK1QrTnV6RjhhbTdxdWJzVmVXQTB4Zm5S?=
 =?utf-8?B?UGMxeVdwRDMwWlpZMjBWdE10WVdKeHp3djNjL1V5eWdlSDJJMzJZTUVnOGtN?=
 =?utf-8?B?d3ZKekJDYW4xdk1IdHlhZG5qTjlJSXNyQjNMWDZjeDc1eGc2aUw3RHphaHZE?=
 =?utf-8?B?SkcyUFJzekd4QkJESlo0ZERLTWpDTjdubDh1eVVnRnFUR29zRTN2M2xpdzZ4?=
 =?utf-8?B?OEpaeE0vME9hVVlpdWIrZC9hei9yNm8zWVFoS2R1NVh0bWpNYkkxOXJZREo2?=
 =?utf-8?B?dWZCQy93dUtXcEQwYmR4MjdBSGdEd3ZlQnFzRERHVnF2YWxPdUZHQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: S4idL0P9XGBHawbOx9LfVbv4cw0wPM9sS8gqsnH/B6UZDMgTCxzHnyidYdakRtdGreQJFlrzCNbdHypD2rqWKqGD8kt/+Aoe6mzBvTatFU3+Z0EufRuz73s9PHaEHCCltA7LDbv91vM+PFStXcmEJmvJJvhA8IQHwV+8L86mcrM1ssFlVt40vWce17Lq8FUU4nJu7GspLLSO9Kvd/RSVg/ju5mef+18Ow/yvYp3mSIPB6v/uCOhpbeLPMwH+UiPCStr/OhziuPAEnT6WI+WQ2qm+G+B0XJY+vsFOrs2hxCtPrsYOZVID5AfiI26txTChwPIYr19Ox3VoFDw0YHMFdw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfd17698-a7c5-4766-8ae7-08df349058b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 01:11:07.7020 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J4CJpii+v+kh0J4Edj5muKImGHNZraQ84QQTm7B9IcXlGSENqsTXiQA97UHhsCzX9ubAK/gSclUjs1vQ1saI6c6/lhONY7kynhDnbZxRMyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR06MB8670
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SGkgQ8OpZHJpYw0KDQo+IG9wZW4gbGlzdDpBbGwgcGF0Y2hlcyBDQyBoZXJlIDxxZW11LWRldmVs
QG5vbmdudS5vcmc+OyBvcGVuIGxpc3Q6QmxvY2sgbGF5ZXINCj4gY29yZSA8cWVtdS1ibG9ja0Bu
b25nbnUub3JnPg0KPiBDYzogVHJveSBMZWUgPHRyb3lfbGVlQGFzcGVlZHRlY2guY29tPg0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIHYxIDAzLzE0XSBody9ibG9jay9tMjVwODA6IFJlbmFtZSB3MjVx
MzJkdyB0bw0KPiB3MjVxMzNwdw0KPiANCj4gT24gMTAvMjcvMjYgMDI6MzIsIEphbWluIExpbiB3
cm90ZToNCj4gPiBIaSBDw6lkcmljDQo+ID4NCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MSAw
My8xNF0gaHcvYmxvY2svbTI1cDgwOiBSZW5hbWUgdzI1cTMyZHcgdG8NCj4gPj4gdzI1cTMzcHcN
Cj4gPj4NCj4gPj4gT24gMTAvMTUvMjYgMDc6NTYsIEphbWluIExpbiB3cm90ZToNCj4gPj4+IFRo
ZSBXMjVRMzJEVyBhbmQgVzI1UTMzUFcgdXNlIHRoZSBzYW1lIEpFREVDIElEICgweGVmNjAxNiks
IGJ1dA0KPiA+PiBoYXZlDQo+ID4+PiBkaWZmZXJlbnQgcGFydCBuYW1lcy4gU2luY2UgdGhlIEpF
REVDIElEIGlzIHVzZWQgdG8gdW5pcXVlbHkNCj4gPj4+IGlkZW50aWZ5IGEgZmxhc2ggbW9kZWwg
aW4gUUVNVSwgYm90aCBwYXJ0cyBjYW5ub3QgYmUgYWRkZWQgYXMNCj4gPj4+IHNlcGFyYXRlIGVu
dHJpZXMgd2l0aCB0aGUgc2FtZSBJRC4NCj4gPj4+DQo+ID4+PiBBY2NvcmRpbmcgdG8gV2luYm9u
ZCwgdGhlIFcyNVEzMkRXIGhhcyBiZWVuIGVuZC1vZi1saWZlIGZvciBtYW55DQo+ID4+PiB5ZWFy
cyBhbmQgdGhlIFcyNVEzM1BXIGlzIGl0cyBuZXh0LWdlbmVyYXRpb24gcmVwbGFjZW1lbnQuIFRo
ZQ0KPiA+Pj4gVzI1UTMzUFcgaXMgY29tcGF0aWJsZSB3aXRoIHRoZSBXMjVRMzJEVyBhbmQgdXNl
cyB0aGUgc2FtZSBKRURFQw0KPiBJRC4NCj4gPj4+DQo+ID4+PiBSZW5hbWUgdGhlIGV4aXN0aW5n
IHcyNXEzMmR3IG1vZGVsIHRvIHcyNXEzM3B3IHRvIHJlZmxlY3QgdGhlDQo+ID4+PiBjdXJyZW50
bHkgc3VwcG9ydGVkIHBhcnQuDQo+ID4+Pg0KPiA+Pj4gU2lnbmVkLW9mZi1ieTogSmFtaW4gTGlu
IDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+DQo+ID4+PiAtLS0NCj4gPj4+ICAgIGh3L2Jsb2Nr
L20yNXA4MC5jIHwgMiArLQ0KPiA+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pDQo+ID4+Pg0KPiA+Pj4gZGlmZiAtLWdpdCBhL2h3L2Jsb2NrL20yNXA4
MC5jIGIvaHcvYmxvY2svbTI1cDgwLmMgaW5kZXgNCj4gPj4+IDU0NWUwYjU3MjguLmU4OGVmZDkx
M2IgMTAwNjQ0DQo+ID4+PiAtLS0gYS9ody9ibG9jay9tMjVwODAuYw0KPiA+Pj4gKysrIGIvaHcv
YmxvY2svbTI1cDgwLmMNCj4gPj4+IEBAIC0zNTMsNyArMzUzLDcgQEAgc3RhdGljIGNvbnN0IEZs
YXNoUGFydEluZm8ga25vd25fZGV2aWNlc1tdID0gew0KPiA+Pj4gICAgICAgIHsgSU5GTygidzI1
eDE2IiwgICAgICAweGVmMzAxNSwgICAgICAwLCAgNjQgPDwgMTAsICAzMiwNCj4gPj4gRVJfNEsp
IH0sDQo+ID4+PiAgICAgICAgeyBJTkZPKCJ3MjV4MzIiLCAgICAgIDB4ZWYzMDE2LCAgICAgIDAs
ICA2NCA8PCAxMCwgIDY0LA0KPiA+PiBFUl80SykgfSwNCj4gPj4+ICAgICAgICB7IElORk8oIncy
NXEzMiIsICAgICAgMHhlZjQwMTYsICAgICAgMCwgIDY0IDw8IDEwLCAgNjQsDQo+ID4+IEVSXzRL
KSB9LA0KPiA+Pj4gLSAgICB7IElORk8oIncyNXEzMmR3IiwgICAgMHhlZjYwMTYsICAgICAgMCwg
IDY0IDw8IDEwLCAgNjQsDQo+IEVSXzRLKSB9LA0KPiA+Pj4gKyAgICB7IElORk8oIncyNXEzM3B3
IiwgICAgMHhlZjYwMTYsICAgICAgMCwgIDY0IDw8IDEwLCAgNjQsDQo+ID4+IEVSXzRLKSB9LA0K
PiA+Pg0KPiA+Pg0KPiA+PiBJbnN0ZWFkIHBsZWFzZSBhZGQgYSBuZXcgIncyNXEzM3B3IiBkZXZp
Y2UgYW5kIGtlZXAgIncyNXEzMmR3Ii4NCj4gPj4NCj4gPiBUaGFua3MgZm9yIHRoZSByZXZpZXcg
YW5kIHN1Z2dlc3Rpb24uDQo+ID4NCj4gPiBUaGUgcmVhc29uIGZvciByZW5hbWluZyB0aGUgZGV2
aWNlIGlzIHRoYXQgYm90aCB3MjVxMzJkdyBhbmQgdzI1cTMzcHcNCj4gdXNlIHRoZSBzYW1lIEpF
REVDIElEICgweGVmNjAxNikuDQo+IA0KPiB5ZXMuIHRoYXQncyBmaW5lLiBTZWUgOg0KPiANCj4g
ICAgICB7IElORk82KCJteDI1bDI1NjM1ZSIsIDB4YzIyMDE5LCAgICAgMHhjMjIwMTksICA2NCA8
PCAxMCwgNTEyLA0KPiAgICAgICAgICAgICAgRVJfNEsgfCBFUl8zMkspLCAuc2ZkcF9yZWFkID0g
bTI1cDgwX3NmZHBfbXgyNWwyNTYzNWUgfSwNCj4gICAgICB7IElORk82KCJteDI1bDI1NjM1ZiIs
IDB4YzIyMDE5LCAgICAgMHhjMjIwMTksICA2NCA8PCAxMCwgNTEyLA0KPiAgICAgICAgICAgICAg
RVJfNEsgfCBFUl8zMkspLCAuc2ZkcF9yZWFkID0gbTI1cDgwX3NmZHBfbXgyNWwyNTYzNWYgfSwN
Cj4gDQo+IFRoZSBvbmx5IHdheSB0byBkaXN0aW5ndWlzaCB0aGUgbXgyNWwyNTYzNWUgZGV2aWNl
IGZyb20gdGhlIG14MjVsMjU2MzVmIGlzDQo+IHRvIHJlYWQgdGhlIHNmZHAgdGFibGUuIFRoYXQn
cyB3aGF0IHRoZSBrZXJuZWwgZG9lcy4NCj4gDQo+ID4gSSBjYW4gYWRkIHcyNXEzM3B3IGFzIGEg
bmV3IGZsYXNoIG1vZGVsIGFuZCBrZWVwIHcyNXEzMmR3LCBzbyBib3RoDQo+IG1vZGVscyB3aWxs
IHVzZSB0aGUgc2FtZSBKRURFQyBJRC4gSWYgeW91IGhhdmUgbm8gY29uY2VybnMgYWJvdXQgdGhp
cywgSSB3aWxsDQo+IHVwZGF0ZSB0aGUgcGF0Y2ggYWNjb3JkaW5nbHkuDQo+ID4gQWx0ZXJuYXRp
dmVseSwgSSBjYW4gZHJvcCB0aGUgcmVuYW1lIHBhdGNoIGFuZCBvbmx5IGFkZCB0aGUgU0ZEUCB0
YWJsZSB0bw0KPiB3MjVxMzJkdywgc2luY2UgdzI1cTMzcHcgaXMgY29tcGF0aWJsZSB3aXRoIHcy
NXEzMmR3Lg0KPiANCj4gYXMgeW91IHdpc2guIEJ1dCBkb24ndCBkcm9wIHRoZSB3MjVxMzJkdyBw
bGVhc2UuIFRoaXMgd291bGQgYmUgYSB1c2VyIHZpc2libGUNCj4gY2hhbmdlLg0KPiANCj4gPiBQ
bGVhc2Ugbm90ZSB0aGF0IHRoZSBTRkRQIHRhYmxlIHdhcyBkdW1wZWQgZnJvbSBhIHJlYWwgdzI1
cTMzcHcgZmxhc2guIEkNCj4gZG9uJ3QgaGF2ZSB0aGUgU0ZEUCB0YWJsZSBmb3IgdzI1cTMyZHcg
YmVjYXVzZSB0aGlzIGRldmljZSBpcyBvbGQgYW5kIGhhcw0KPiByZWFjaGVkIGVuZCBvZiBsaWZl
Lg0KPiA+IFBsZWFzZSBsZXQgbWUga25vdyB3aGljaCBhcHByb2FjaCB5b3UgcHJlZmVyLg0KPiAN
Cj4gVGhlIHNpbXBsZXN0IGlzIHRvIGFkZCBhIG5ldyAidzI1cTMzcHciIGRldmljZSB3aXRoIGl0
cyBTRkRQIHRhYmxlLg0KPiANClRoYW5rcyBmb3IgdGhlIHN1Z2dlc3Rpb24uDQpXaWxsIGFkZC4N
CkphbWluDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBDLg0KPiANCj4gPg0KPiA+IFRoYW5rcywNCj4g
PiBKYW1pbg0KPiA+DQo+ID4+IFRoYW5rcywNCj4gPj4NCj4gPj4gQy4NCj4gPj4NCj4gPj4+ICAg
ICAgICB7IElORk8oIncyNXg2NCIsICAgICAgMHhlZjMwMTcsICAgICAgMCwgIDY0IDw8IDEwLCAx
MjgsDQo+ID4+IEVSXzRLKSB9LA0KPiA+Pj4gICAgICAgIHsgSU5GTygidzI1cTY0IiwgICAgICAw
eGVmNDAxNywgICAgICAwLCAgNjQgPDwgMTAsIDEyOCwNCj4gPj4gRVJfNEspIH0sDQo+ID4+PiAg
ICAgICAgeyBJTkZPKCJ3MjVxODAiLCAgICAgIDB4ZWY1MDE0LCAgICAgIDAsICA2NCA8PCAxMCwg
IDE2LA0KPiA+PiBFUl80SykgfSwNCj4gPg0KDQo=

