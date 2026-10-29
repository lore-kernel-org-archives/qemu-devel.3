Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDAB606A321
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 05:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=puZlPsyO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMIZs-0002xR-30; Thu, 29 Oct 2026 01:21:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xMIZo-0002v0-PH; Thu, 29 Oct 2026 01:21:24 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xMIZm-0006ua-Hr; Thu, 29 Oct 2026 01:21:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LBi7yEh/q/JmngqGgzqS1PjIqH5GfFPzLY/9wNGp+1YLocnA/61zZUKrIAPRD48RNWjHjsZvp/r+q4VfbuTuhSFZp5jrU+rAkxwqt6yA5VvD2OUb1Dy9iWZ5izpy0wojsaqv72eOR3GvB1r7eHtaaTvo5/mpjWB5FmmHohC3LdNxza5ZMmaR5TjismxaoEREEc+j9CkDaRFu2hKkNxn001M9wE1GlkMMJ2zbHgOm2e/If6Azu5EJ9DDBUDZ/OeSwkMdh5GfI8YRRyX9G/4IqNclKei1oBKZoc3DhNMbLMgpFzfKF6z3qolqZmbbkl/zKev8f1klBI6aCGcBpqUIoqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+kWPXhVzzxEoNRHZ5iOTfT1ZVb3S9G0ClAf6kKCtIE=;
 b=I18nwWMPpeYhEZm7X7HuGoyoRaQUVbZp1JUFpjxPIa0NS+9W5MaEptfD4kVloS0QPUuFlsedBjg/H940nKN23UIzmwJqzUrH9iZwYiXuZxvn99RT+IRA6wfv0qgPRW2NrGycWVEy2opSlymGLbY3cb2zl1g8gCNPc/1z156AQVNMS8E+sUQZnQcqUDV/GUBxN/JihL01WZ1K2T5rCRxizJ6swTvgqUL4cHeZcPn5NV2jBq0DTyuNzmn6zNUNQ9dUkI2WLTfkXI2pLe/EpaqAZ9CNluMS49FS/NkkgmISlwUTP/w0roaS5FPTJz/O41VmUuZCwUcceZpXQ0VgTbtQWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+kWPXhVzzxEoNRHZ5iOTfT1ZVb3S9G0ClAf6kKCtIE=;
 b=puZlPsyOALUKump9PijshC3JF1HjW73yjV2+TXnSzBMW32seJLqoJydgX0o1OCwAuONHDu4vc8eBtepU6k21BCuNCeHqFHBJ+597yuFnDJJCNn3bDRMh6oqNFzE6aBOinhQNVhqx0yNLCBFvkEdqcXrmkIoIoDc0+CkkpzMraQQOw/wI83+obdfFn4UddQDRtD8M60krp8c+Gp8UXLbLe0n1wrLLfBX7A7OiVnkBbkY/XqElvGDSJubDXdb7tJt9AJB3pQZcJJ6DZQ3/FZVMtUZ76TuCxGqJCkIzo0UBlqVaanPbMTbFbtRxRNlr+bGLV0Iavwc+tcCusvGHthdkbA==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TYZPR06MB6699.apcprd06.prod.outlook.com (2603:1096:400:45b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 05:21:12 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 05:21:12 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Timur Maksimov <gessingate@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Kane Chen
 <kane_chen@aspeedtech.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Subject: RE: [PATCH v2 2/6] hw/i2c/aspeed: fix BUSY status reading in new
 register mode
Thread-Topic: [PATCH v2 2/6] hw/i2c/aspeed: fix BUSY status reading in new
 register mode
Thread-Index: AQHdZky0yUoy3KUSwUW2OSnfMSEetrcT/bCw
Date: Thu, 29 Oct 2026 05:21:11 +0000
Message-ID: <SEZPR06MB73620B13B2B6D5C316DE409AFC6E2@SEZPR06MB7362.apcprd06.prod.outlook.com>
References: <20261027-aspeed-i2c-nonpkt-fix-v2-0-07deed1dff60@gmail.com>
 <20261027-aspeed-i2c-nonpkt-fix-v2-2-07deed1dff60@gmail.com>
In-Reply-To: <20261027-aspeed-i2c-nonpkt-fix-v2-2-07deed1dff60@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TYZPR06MB6699:EE_
x-ms-office365-filtering-correlation-id: 68128c7d-e707-4ece-a0be-08df357c7250
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|38070700021|4143699003|56012099006|261021123027099003|261021121427099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: IGRGs+2/EUb5to2vU4qrJ03puW0iKrZdpuHdNOdaEw4eEZ4qHJw+YYE1PfGRYUPxrg3oytSVWt4w3v5RkuK/FGzMcf9R/ApvOaQ4yWJqKRMCjCGc0XJBy3nnjINOC+AmCLw1xhWgWI4OG4rY73LVYSTy0EmUvD1HApDPkXJpC3ueq3dbsxC7SiyOI+fCD3e3ohtEcRXfpPSACu0Y8zvKnghmYLOzMSuNwjp3nsScIq0LZMCSX3V03jo0bHTvJKKfQuZAVGcS2/FLNegrcRzjVxsWdEm9YVL9FPhThP0jYKX5q0RSxPo8J2IM3eZ+QECj8fdCW0uzw0+ARbG0U03zJDy0quLxAsZJmMe/8qaQZohwbbWPoldc/DPnVBzMfPY3+XUvjgQzVGSkiFeVSVehlaXKCLdki/wcEqIEMl+eWH4eq5dQdd8G2WJNLDw7y9iLoHbFMEe89YjeUQ7PbMrYu/Dl0V4ShD5Bt6NYNZGoXSkSKtr0Aeu28giKOsBptHweWUjmioIHrTMKdNe5kWD3U857KuvxZ95daKRNO+I+DGgagmJiL9ZV4UiwFaW1auVqFqJq75c8N7DrU8bkdvyQsdEOFXUkmfTXhi+9xoZceVglXF+M/Nlmwa2nb4Nugiy9IjO0vP/qYY4zCG/c7OeBEV4UHby8sn7ujyy9n081Hev47K/f3ML3wfI65pCKU1QaGqv9qFp87H02RYQuNmo2SCWGMmfdTzZg9CFOh9YhiJ8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(38070700021)(4143699003)(56012099006)(261021123027099003)(261021121427099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEIxRWxiR1E2RzFMaE5JaFgyTkxoNlQ1QldUbWFNSkxKTEhucVl4NmNPRUhR?=
 =?utf-8?B?aTJ1M0pNbEdoVC9wZDAzRXJ4MVVQRzBYYkRtVjM1UlRVRWE4UXpIOEdPZjcr?=
 =?utf-8?B?NlNmdTBpbFZrQ0RSTmxBYTQwK3FWL21LVnZjLzRUZ3J3MmhGTWtCWFJaUEFB?=
 =?utf-8?B?Z0dmVE01UEozbVdrb2l2UGJDb0Q0VnhNZDlBS3A2TXZHWDVWSW9kdXhBQjdQ?=
 =?utf-8?B?b2FnaUxjOFNSZEtsbVc3UjZxZjV0bGUxZFpEL0x2Wk9RQUNnWFNycWxDV1k2?=
 =?utf-8?B?NnVZVlBiWXl3dkVCbzMwdnJkaGhFdEsxOTJ6RDMwY1ZzVE9YQlp2YS9aN3pY?=
 =?utf-8?B?dklhTkRCQm5hRmxsK2pqTXZZMFlOKzFzMEgrengwb0ErdjFnRUg5Z251K29D?=
 =?utf-8?B?UTNVSFczR1J6OEVCclhqMk9odEVvd3ZpR3paZnZ1dEFWTUdzVVJjNHpzVnhi?=
 =?utf-8?B?NkpWQ2R3VjA5N002bmZ5SkNRN2xJcmRDR0tkSDFzellOS1oydGhtTTg3ZFZS?=
 =?utf-8?B?ZG9DbXVuM1hBQUtIZmlyNjN2cXZzWkp0SEtBeVBaY0xXUFdhMWFaRWc2d3lp?=
 =?utf-8?B?cUEwMTNIU1dRTXFqOEl5MGh0MUxwbkE2Q0J0cmxTRVNVNmNpSmpra0pqWTd4?=
 =?utf-8?B?aTFlVlJITVY3djRzbGxyWWhGd0RiNHpVY0Q1VU9JRjJGaUMxaDkvYytmeVFK?=
 =?utf-8?B?aFlSYUwydnhrMVc3K29LVURTd0RqbGtML1BFalZPN3Q3R3lxV0JmUmtpamRM?=
 =?utf-8?B?OWFTejZGVWIwRVhBa0pqR0c4VWNrUEswWWg4dkxLU1hLQTl4NXgzNVRIMGV1?=
 =?utf-8?B?Uit0QkdSMWVNcmI4SE5ZM1NNWS9zL0ZrZGlUb0x3STlTL0pRN3ZjSTlzK3Av?=
 =?utf-8?B?cVdBaXAzamMxZmFEQWRqQ2U3aVJFL1JONjU4eEViM2NuMEdrWFRPeEV2NXNX?=
 =?utf-8?B?QWtVOUQzcmJXV1NjUitTVzUyeGhJQXBoQWlwRUoyVlY3NS9BN2N0cjQ1UnZS?=
 =?utf-8?B?bEhWUUVMbktLeDN2cEtRMDJCajl0SGRZVktac1ZCc2luVDdKbHl3dzREUGcw?=
 =?utf-8?B?VGdKWDVZbmszL1NTSllobktwK1RUbTZhTE52aEc5eUhGbjZjUWtuYXZTZlpX?=
 =?utf-8?B?bmhXTXhYSEVoRUtkcjFBMnREbE4ybmlEcWN6dUovV20ranZmcXBXNzJHd2l5?=
 =?utf-8?B?WjJHOHU2MDVCUHFXQ0tvUGdqRjVZYkNrNnhYdGJTaGxDeXM4STcrKzVmYjN3?=
 =?utf-8?B?aGFrcWJLUXZ1dmtwOFpuK2VkTmk0bThpYjlaZ29MekVXZEs2NVlrQ3RYTHpx?=
 =?utf-8?B?aXg4MjlrSHU2SFJKTXZtZTZaelVxQm5WK2FjT1J0QndWYWMvWE1UVERMamgw?=
 =?utf-8?B?bkpscjhvNVhBWXZPVmFxSWtzeHBEdUpRTFFiTlFhb2U4R0tuNDl1M1p1SWRY?=
 =?utf-8?B?T1ppejJTQmpFWHc2enRWMXpLa0Fkbnh4L2ZBNDNuSVl3NGwwa1dDcU9VV0Fa?=
 =?utf-8?B?TE1nc2daeU1mMkJiSHV6K2wyTzFILzU2R0x6VXNaNFZkK1dQVk5ycmlTSUlE?=
 =?utf-8?B?UlVEWjd4eEZsb2F2eG10aXh0NkJtREdzZEg3cnV2Qnc3cWtOdVFDY0FhRGJw?=
 =?utf-8?B?cW95T3B2STJCaklRVDZyTVhWSm0yaW5BR280THlNalZkZTA1ZSt5L05uak5W?=
 =?utf-8?B?eW40bXdnUy9TR0dVT0JNSDdCakpzYjlMdTh4bEpZTDhKWnIwYk5QR0IySllX?=
 =?utf-8?B?UnNvTUJtS1p0cVRsc2lDVTB0ZUNldlNWalRaSStLSDVEeng2N1NsdFV6QVRl?=
 =?utf-8?B?OWdsQk0rbHllbFJDVjVwdEtMNVFFRzVVSXVtNWJNMStUNG5WN050TlV1bFhq?=
 =?utf-8?B?MkRyMlFJYW9ta1NTTkVuWldHaGZxd0dVMU1rNEtlMTZCRFhkZHpKK3ZxNG1l?=
 =?utf-8?B?WkFVQ2FqSUF3UWV6dFM5QWtQM20wekNEY2cxbWc1cWlvTFpnNHdub1ljTEN5?=
 =?utf-8?B?aGwwOE9WM0l1NkFnM0p5VEVDWnpjaU5KbVRRS3E4QzF0SmdlWkg4OExqYkFN?=
 =?utf-8?B?N0dlRnY0dUZFV3ZqQkFIdzg3WGpFK2dQMjJNWW5kTEMwN2p3dVg4U0dJbmU2?=
 =?utf-8?B?YTdOL285L3RlZGhkeGlJcVM2TmxHT1JwYkVvdzE1WHVYb0lrM09jMi9GYnU0?=
 =?utf-8?B?TXQxMjhFRTVqM2I1ekw0Rys2Zi9SYTZiQXFWMUx5cjFRQTJWWXpMNnArek4r?=
 =?utf-8?B?WkdndHhOWnlwTk9oR0JKVDBhQ1ZrTi9KL1VPY2FSd3ZIeVdHZ0lhdXk3N0Zy?=
 =?utf-8?B?Ym0rUFNEUlQwdXBOeWZ4S3pHOXdjRm5yeTdrNmsxUXFhdjVFNCtnUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: F2DZalOtOVZdnyLn4CiHCsD9YSqX5OdFJuDs73kv5HWrzePZEQfO6s807ioI7OMdlEyUluCqkGEZjv4BVTkx/FHQn2nop+KwJ332xokG7z2ZBCZgU7T3YwAccMdho4DBdpchT+vZawkbKuqMqKsXTOdXlrhghn8wxn0yfyfkTi+TfVoiGQBhK+XpSFONi+V12JMgOtj+64IEyp9ftRi3RSJFMZYaxj3u7qDjS/HRQBgLmZUBvHFfqx/yp561xHZGaHq+O+G7LSnptf0Diwk7LF/XN56z/Aes8JJDS8NlJzSkoydzRTe8joSwAaAo6lZrYk/MdU77FJXSOkl1BrcPnQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68128c7d-e707-4ece-a0be-08df357c7250
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2026 05:21:11.9489 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CYnOUjb9IEABYCvIH0en3eavTTVOQ/XgP9qKtg+TEetT4NfU5cfx4QW6827uXCe9o88iAq8BwtqCqxUjI64C1VDGfNiLbRy4yZB03xrZppw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6699
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
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

PiBTdWJqZWN0OiBbUEFUQ0ggdjIgMi82XSBody9pMmMvYXNwZWVkOiBmaXggQlVTWSBzdGF0dXMg
cmVhZGluZyBpbiBuZXcgcmVnaXN0ZXINCj4gbW9kZQ0KPiANCj4gSW4gbmV3IHJlZ2lzdGVyIG1v
ZGUsIEJVU19CVVNZX1NUUyBpcyBiaXQgMTYgb2YgSTJDQ19NU19UWFJYX0JZVEVfQlVGOw0KPiBi
aXQgMTYgb2YgSTJDTV9DTUQgaXMgUEtUX09QX0VOLiBSZXBvcnQgdGhlIGJ1cyBidXN5IHN0YXRl
IGluIHRoZSBjb3JyZWN0DQo+IHJlZ2lzdGVyLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogVGltdXIg
TWFrc2ltb3YgPGdlc3NpbmdhdGVAZ21haWwuY29tPg0KPiAtLS0NCj4gIGh3L2kyYy9hc3BlZWRf
aTJjLmMgfCA1ICsrKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2h3L2kyYy9hc3BlZWRfaTJjLmMgYi9ody9p
MmMvYXNwZWVkX2kyYy5jIGluZGV4DQo+IDBiYzRiYjZmYmUuLmZiNmQxOWMzN2IgMTAwNjQ0DQo+
IC0tLSBhL2h3L2kyYy9hc3BlZWRfaTJjLmMNCj4gKysrIGIvaHcvaTJjL2FzcGVlZF9pMmMuYw0K
PiBAQCAtMTQ2LDcgKzE0Niw3IEBAIHN0YXRpYyB1aW50NjRfdA0KPiBhc3BlZWRfaTJjX2J1c19u
ZXdfcmVhZChBc3BlZWRJMkNCdXMgKmJ1cywgaHdhZGRyIG9mZnNldCwNCj4gICAgICBjYXNlIEFf
STJDQ19QT09MX0NUUkw6DQo+ICAgICAgY2FzZSBBX0kyQ01fSU5UUl9DVFJMOg0KPiAgICAgIGNh
c2UgQV9JMkNNX0lOVFJfU1RTOg0KPiAtICAgIGNhc2UgQV9JMkNDX01TX1RYUlhfQllURV9CVUY6
DQo+ICsgICAgY2FzZSBBX0kyQ01fQ01EOg0KPiAgICAgIGNhc2UgQV9JMkNNX0RNQV9MRU46DQo+
ICAgICAgY2FzZSBBX0kyQ01fRE1BX1RYX0FERFI6DQo+ICAgICAgY2FzZSBBX0kyQ01fRE1BX1JY
X0FERFI6DQo+IEBAIC0xNjYsNyArMTY2LDggQEAgc3RhdGljIHVpbnQ2NF90DQo+IGFzcGVlZF9p
MmNfYnVzX25ld19yZWFkKEFzcGVlZEkyQ0J1cyAqYnVzLCBod2FkZHIgb2Zmc2V0LA0KPiAgICAg
IGNhc2UgQV9JMkNDX0RNQV9BRERSOg0KPiAgICAgICAgICB2YWx1ZSA9IGV4dHJhY3Q2NChidXMt
PmRtYV9kcmFtX29mZnNldCwgMCwgMzIpOw0KPiAgICAgICAgICBicmVhazsNCj4gLSAgICBjYXNl
IEFfSTJDTV9DTUQ6DQo+ICsgICAgY2FzZSBBX0kyQ0NfTVNfVFhSWF9CWVRFX0JVRjoNCj4gKyAg
ICAgICAgdmFsdWUgPSBidXMtPnJlZ3Nbb2Zmc2V0IC8gc2l6ZW9mKCpidXMtPnJlZ3MpXTsNCj4g
ICAgICAgICAgdmFsdWUgPSBTSEFSRURfRklFTERfRFAzMih2YWx1ZSwgQlVTX0JVU1lfU1RTLA0K
PiBpMmNfYnVzX2J1c3koYnVzLT5idXMpKTsNCj4gICAgICAgICAgYnJlYWs7DQo+ICAgICAgY2Fz
ZSBBX0kyQ01fRE1BX1RYX0FERFJfSEk6DQo+IA0KPiAtLQ0KPiAyLjUzLjANCg0KUmV2aWV3ZWQt
Ynk6IEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPg0KDQpUaGFua3MsDQpKYW1p
bg0K

