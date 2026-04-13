Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5005E9380A
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 02:43:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wC7Fw-0004ju-KG; Sun, 12 Apr 2026 22:42:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wC7Fu-0004im-07; Sun, 12 Apr 2026 22:42:30 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wC7Fq-0003p6-Nm; Sun, 12 Apr 2026 22:42:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qxhcZ+CAfxUjeqCWyhEdhjxMVRn5j91GTmtNEx9tfb+ANQamT47h83AtjyBT8gxvng9ETE2O37Nv/SNh0/Cwcl6829Nqw5HKrkMRzm56eynFXLuqEu4SLN1onZbaAHac8TxtkHzqHhUiXkAURIWHfstCEprC+TmM1DWo1gKJGq0tkRw9bjrwQlnwaQuGTk3LtWLEOu8/0FynWDl1FXZ4eGhS3nTT7ZhGUw7VweNqR23vXAK84xZOnwO+rOtJG2DQg7FXMk0vikr0T/O89Vo6xM4H7t1eFmWJAO+LTZHNXnXnmZeDgZ/LuRjZfFBC0GNGlCJL6etIwggOxLXQZuWWGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T1HPvEedQyY8iN++AemYCjM+br+ewk3tC4msbr4y4xE=;
 b=eDtHrZGUJPZ4fwrrRJcl9c0Wsax161nNFRevKoDrkY5Tsu/lPnQc4GFWJj1ubsb7+xXU2M32dVkGqtdTwu2vwmmQMWT0v0dqn7Emg+A02ph535QCfJnd8/6rACww86p1b/4DbMY1oG1t85u6LLlubP3bqBHeRmEV+SficqX42EZ/u48Os0564d0YPbDfbgsepuNl1nz1kmlscV74xDvpyJLjYxEZFAaYqpaG3nCc2ixpCuVfcuDhgBOt090/tKpD9ABBMp5Pwmy37OaP9UC3ASpUPvxhwglGljhvHHDyxTpF9Slg2XEsNega/vDCeykjxYa3XmXab+ELCat6OU/SAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1HPvEedQyY8iN++AemYCjM+br+ewk3tC4msbr4y4xE=;
 b=VpAh57VImhE3cYfGXxaeF5eSZ9N4x4QImgcOaeQa31/OYnUbW+XouqnPWElZy7ry+XYe1dG+QfdHmPWYfzmifLLMp2fj8p5dcXfnNYxizcClhuqH1ZEev4vfqS0onRFWVAaE4Q+fe/46bkOnBG+htctsG8dTzk0yW8vlek0Ab5PnPaP1WgVnru73NOZCL8sG4E39xO+7yPqS7HrEOcbxWm4bQpPXv+0/bQ5M6axotqSAhKLFN+DmcJJpd668yRjvxXyMCg1fAWyGr7lYlPaDPcC/9uT+NHdKnghGP7qD3RZ6mfKNmDdF45JOD6gF7tfi2329bf/Up9bbEl+8kAzxUw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KUZPR06MB8214.apcprd06.prod.outlook.com (2603:1096:d10:59::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 02:42:18 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 02:42:17 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: RE: [PATCH v1 11/13] hw/usb/hcd-ehci: Add descriptor address offset
 property
Thread-Topic: [PATCH v1 11/13] hw/usb/hcd-ehci: Add descriptor address offset
 property
Thread-Index: AQHcsShgVVvWfyMXxk6VQwvYNluV1rXcGoiAgABdF4A=
Date: Mon, 13 Apr 2026 02:42:17 +0000
Message-ID: <TYPPR06MB8206C7461E004C4FF07B8E92FC242@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260311072614.1095587-1-jamin_lin@aspeedtech.com>
 <20260311072614.1095587-12-jamin_lin@aspeedtech.com>
 <f1f030b4-acc6-414d-a0ef-4afff50278fc@linaro.org>
In-Reply-To: <f1f030b4-acc6-414d-a0ef-4afff50278fc@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KUZPR06MB8214:EE_
x-ms-office365-filtering-correlation-id: 447f1a20-7712-4ad1-0ad9-08de9906474f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: fAM9izlmPhEQrPRafmOS4kfjZnBAhOYYMYP391EGC42gYm5cF22KvWRg9cAZ4cWkArAs4jRSFaZxAxLC/fzevJ8dqwOjXaqJZDLhdN0ViJ5EiTBBv0YOJoufYaqUpx1UYyCc/HY2sHYJbKL2Zmf1tgv6Jdo/S3wmEMWPI97i/0UVLKOvR9zgMN3EI2k2dGdRjhf8+4x9+YqNqx7TmlVjezXkpmytKuHSAWwB6C2jPCW74MHuF9TJCDTlrEdS+txUSTmvAYbRUClvAPKJosBYdw88gRBMbcPOsVkxTB6PX8TE1aSUEVnlw07aNZnfjMke+atvHSIVVnf2rejnOcTtGHb2zgfukdzWUAugSktfaLFnINHBPgTbLWfo6EhSaQTDcBKOeB5Z+O8zE7ttWoIAtvio1EUmlmVxq5uF5Sx89vm4ObW0Gn0q/RoU4sl/KYgTq8K+ELxpC0ex0hl7RJGb15KK+0Pm8KJhnqBLyjlUa69uDboQEojaqeg5e5Fu2KEO7mGmKg1Z1o9L6pgC1QEwYWhTgh/4ci9pmLftLA7wqd18z3q1sThLp7uyj/te8CB2nuFVsfgWK7I3hBLIkokQIVfwMjLQIJ/tN5PgIE6KW9ZfxdNKJTLR4Bi4iejPJL5aKL/cdiYQa99cnuIRsqr+4UVRdWiSKVXy1nLlN2xCfenTl58wLTjXGkMMHGC0jVJz/9SNI+gkKdZ31KiAVhMymId1nbanhYUarsyjF5rvx//mY2/4BW+DxOVp+NwIuB9AJEjXeHEqSQtKcR/BtZOUV10rQYuhQshf35QZsKtm6PU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(56012099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Tjh5ZDZuMXJrS3JHaE1yTkF0U3h6a3lpK25hLzhaRlZ6ZU9XeXVucUJMRjQw?=
 =?utf-8?B?dTNLZ1U3YTV6SVQ1YUFHQzUrR0hKaGVwaU1LR3JxYStaUXQrN1RwcVJYZkNZ?=
 =?utf-8?B?UFFES0tGY0FTTzFRK3U3SVBBOWh3ZHlRTUJmRTMyTmUzOFladW0zZWRLTHlS?=
 =?utf-8?B?NDRVVEN5cTBJdmNnNGVWR2t4Z0dVUjI1TVhqUXY1OEJQUUhTQ0h6a0J4UWFw?=
 =?utf-8?B?SG1scTdoRVUxNXl2cCt5bGRyUGxlMU5kMVdYelBQOUJnS014cUc5V1JncEFy?=
 =?utf-8?B?TXEzamV0eXJmQmtiVkJvNVdNcFFNTmhCb0dsZzZmQ3dGMy9qQU1vcjVVTmRp?=
 =?utf-8?B?cHlNa0RWdE51eVZsQ3lPU3BKMmdBU0NPaVVqWUN6N2hxQjNFT1RIOFlCZEdP?=
 =?utf-8?B?Rkk2RmdwTVZET0NkMmoyWHgrVDEyMUFiUGt3dmN5VGNoaGo3NUk2S2xkaytr?=
 =?utf-8?B?eG9SMnNtNHNaSkhuZnZKV3hhZkRPMHVaeDFKVXF4WmhqMVBxdEtQVXJUSmtH?=
 =?utf-8?B?Vm4veE92Uy9VY2p0Zm81TFhKOHpmUFd0bWxmM1NVNENXN2dIbXVFTG9VZ3JN?=
 =?utf-8?B?QUp1R3lBQm5kNFVwV21Yek4xRHkreFBRa1RtZ1B4NytaVmJNZWJCRktCSlJr?=
 =?utf-8?B?OGhtZDJJTXpBUFpxZTRwRTZkcXArVTNYVi9tYWd0U1V3NEhWeTY3SHpqdnVH?=
 =?utf-8?B?TjVoUG5yWHJUSUg0cUd1VGdmM0QwZlRNa2w5ZjZmS3F5U2RYNDZpcG54RW95?=
 =?utf-8?B?akNaUERITlNqVXpiczNvWFdiblFCa0JPL04ydERvNEdHOEpkOU1DaXk4VDd1?=
 =?utf-8?B?VEN4a0lNVHViUVpwWEc5R3NVY01DMCtoMFRmZDVHMEZ0U2N3OTgxZ1ExeFZS?=
 =?utf-8?B?V0ZJdzZEaTlVYWRLY1pXQTQ4bHR4d05tNmxlL0d4bkcwYVVUVFN0SVNJYW56?=
 =?utf-8?B?Z1ZJMWhsLzN5b0R4cFlaamNJbGk3ekFJQS9CZVJXcWx6Q2dpckU2UVdRV3Ez?=
 =?utf-8?B?dEgzYmNiVGE2TjAxVVlZVTNHeHVUU1lFN3V1ZlptWkNqcjlJeUZTWFFTeUxP?=
 =?utf-8?B?dSsxdFd6RWxzNTZkRkdLblhoQVFheU5JRDdYODkrS1IvZk5WcnJPbENRaXNx?=
 =?utf-8?B?bVd3eTJSeGJrbDNZSDd1Q2QzbVlBbXZxSmtmVkVZQzk5aXVJQTB1Q3BOSjg0?=
 =?utf-8?B?MkdoZUVsbUFqUE5Qc09TYmFDM1k0cVRzWEM4T0xtU2s2TlZvRDFidk00R1N1?=
 =?utf-8?B?b042a0xTNkRmY21QaURkZUQ4dDJYQlR5U2ZiS0pEczB6UmcxNE1Ud0VDdkNr?=
 =?utf-8?B?ellMbVAwZnQ5ckkweE1vYlNVNm9IdHVVQ1AvcWNuVTU2RkRTZ2RRbGlwaks0?=
 =?utf-8?B?S2JGTEFDM0xLSFVDQ1FUQmlTMWdaTUlnb3h1dlZ2enZDSjNDak9YSm9vQjAw?=
 =?utf-8?B?KzZYY0JQZFQwTjdWMmlNTXdHeFllSnVhQlRleGxJekVVcjc1dUY0b1RXbktk?=
 =?utf-8?B?ZXFSTlBRL2MwVEFscHoxUStuMlgwV1pqdDdEMmEwZTl2MHlnQWowczl5SVhm?=
 =?utf-8?B?Z1NTaXE1bkVDTVQ2SXQ2emZXcTh1YzZMYnBwS3BDa0czK3pDQnJacWpHaWJt?=
 =?utf-8?B?M01LWU0yRTBjcnRFVFd3Nys2NEtDajZKYlVXRUpoWTFTalVhK25MMm0zQjNT?=
 =?utf-8?B?Zmx1OExFU2JsS0d3eFNVc1pqM2lFcXBCakdFWXZNMTczQytZUEUxYUU2Sm9p?=
 =?utf-8?B?Q25YUnhSR1RVRHdhSkNOZE82ckJWRytwcVZITUJtUkdQOEhNQitDUW1GSHZo?=
 =?utf-8?B?bGVCWUQ0TjVPaUpuNG80L0lSSHZ5ajlDSk15Nnp4Sk9JaTh5TVlWeUJueU15?=
 =?utf-8?B?eE9xSkVVWFU5KzAvZFBTaWFZRG8yRXFIcW16aFNlR2JQNiszR05KdDlHNTZF?=
 =?utf-8?B?NFFUQXVUc2kvQ2I2b2JrRGY5dkQ4TjBpdHZQeEdkNC9GWmYxakZHUHZncVlk?=
 =?utf-8?B?SjZwSjZpb1M2K1JWVkdpaWhLT1k2N2F4S2VrTS9VU3Z0QWlCNGRNRk9zT1My?=
 =?utf-8?B?YnJOanBBMC80cFEvYkdwbmFWdEdxdmFCTkdwQW5TQlI3eFhNakszc29kNGZo?=
 =?utf-8?B?MzhvbTQyMVR1VnRNN3ZPODRGckNyeDBCRzUyMnlsVVdaZXpDVTZZbDZ2Unl4?=
 =?utf-8?B?U3puMWU4WTFkMXJaTEF4dzRjZ0xvQ0RqeFRJODFkNCs1QXgwZ0NDV3dMSWtt?=
 =?utf-8?B?d0gydEdYZ01EWmxiYVh5ZjQxcnVTTE9FUVBSODRLalAyR2ZrUnliVE1rRjlZ?=
 =?utf-8?B?SnJ0ZEJnS0tQajd6VmVxL2tLeTRUbng1OENDeHBCRmk1NTZCeGlDUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Dki4sGkOGXcMeLHRU0VMAZRwXdM4W5/plpQCtbt3OtuzQNeORZ+dPdwmTuLV9Zo+6aSrBcqPTVSLrMMsP0VZBnVwtSU/0PDrXcLWY73vRlUxvvoFuQ7SoYk+ChZWMMv2X+Wf6lzfSoMR3kN/ZAUNwqLDbt1X3/87kiXQi7cJ5gq00nWS+DQbDKHetLUPZpU6yFU4ytS+CggGplPW8CWcwSzwIDBINEU4+mizD0Qvlx3WMPe37f7DSMpBAhBbugO1SvZ3e27cO+ZVVZlYKDI1L3q0ptvNoGhcOktZY/1ikDPlx5VNSKo9vXD3d3bBGQ89AWyiv5C78X9B5wj5gd882Q==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 447f1a20-7712-4ad1-0ad9-08de9906474f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 02:42:17.8182 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wPQlz8TfU73jwPgKgEHF/KB8SbBb9/V93VgkCkM5dMNkP4tpgQxNK9lErLcIMbh68EtqecH5IEl93/b6ZSmIP/mN+VX23XVUy0eUOwNghbs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR06MB8214
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

SGkgUGhpbGlwcGUgYW5kIEPDqWRyaWMNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDExLzEz
XSBody91c2IvaGNkLWVoY2k6IEFkZCBkZXNjcmlwdG9yIGFkZHJlc3Mgb2Zmc2V0DQo+IHByb3Bl
cnR5DQo+IA0KPiBPbiAxMS8zLzI2IDA4OjI2LCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4gV2hlbiA2
NC1iaXQgYWRkcmVzc2luZyBpcyBzdXBwb3J0ZWQsIHRoZSBMaW51eCBFSENJIGRyaXZlciBwcm9n
cmFtcw0KPiA+IHRoZSBzZWdtZW50IHJlZ2lzdGVyIHRvIHplcm8uIFNlZSBlaGNpX3J1biBmdW5j
dGlvbjoNCj4gPiBodHRwczovL2dpdGh1Yi5jb20vdG9ydmFsZHMvbGludXgvYmxvYi9tYXN0ZXIv
ZHJpdmVycy91c2IvaG9zdC9laGNpLWhjDQo+ID4gZC5jDQo+ID4NCj4gPiBUaGUgZHJpdmVyIGNv
bW1lbnQgYWxzbyBub3RlcyB0aGF0IGRlc2NyaXB0b3Igc3RydWN0dXJlcyBhbGxvY2F0ZWQNCj4g
PiBmcm9tIHRoZSBETUEgcG9vbCB1c2Ugc2VnbWVudCB6ZXJvIHNlbWFudGljcy4NCj4gPg0KPiA+
IERlc2NyaXB0b3IgbWVtb3J5IGlzIGFsbG9jYXRlZCB1c2luZyB0aGUgRE1BIEFQSS4gVGhlIHBs
YXRmb3JtIGRyaXZlcg0KPiA+IGNvbmZpZ3VyZXMgYSA2NC1iaXQgRE1BIG1hc2sgc28gbWVtb3J5
IGNhbiBiZSBhbGxvY2F0ZWQgYWJvdmUgNEdCLg0KPiA+IFNlZSBlaGNpX3BsYXRmb3JtX3Byb2Jl
IGZ1bmN0aW9uOg0KPiA+IGh0dHBzOi8vZ2l0aHViLmNvbS90b3J2YWxkcy9saW51eC9ibG9iL21h
c3Rlci9kcml2ZXJzL3VzYi9ob3N0L2VoY2ktcGwNCj4gPiBhdGZvcm0uYw0KPiA+DQo+ID4gT24g
QVNUMjcwMCBwbGF0Zm9ybXMsIHN5c3RlbSBEUkFNIGlzIG1hcHBlZCBhYm92ZSA0R0IgYXQNCj4g
MHg0MDAwMDAwMDAuDQo+ID4gQXMgYSByZXN1bHQsIGRlc2NyaXB0b3IgYWRkcmVzc2VzIGNvbnN0
cnVjdGVkIGRpcmVjdGx5IGZyb20gdGhlIGd1ZXN0DQo+ID4gRUhDSSByZWdpc3RlcnMgZG8gbm90
IG1hdGNoIHRoZSBhY3R1YWwgc3lzdGVtIGFkZHJlc3MgdXNlZCBieSB0aGUNCj4gPiBjb250cm9s
bGVyIHdoZW4gZmV0Y2hpbmcgcXVldWUgaGVhZHMgKFFIKSBhbmQgcXVldWUgZWxlbWVudCB0cmFu
c2Zlcg0KPiA+IGRlc2NyaXB0b3JzIChxVEQpLg0KPiA+DQo+ID4gSW50cm9kdWNlIGEgZGVzY3Jp
cHRvci1hZGRyLW9mZnNldCBwcm9wZXJ0eSBzbyBwbGF0Zm9ybXMgY2FuIHByb3ZpZGUNCj4gPiBh
biBhZGRyZXNzIG9mZnNldCBhcHBsaWVkIHdoZW4gY29uc3RydWN0aW5nIGRlc2NyaXB0b3IgYWRk
cmVzc2VzLiBUaGlzDQo+ID4gYWxsb3dzIHN5c3RlbXMgd2hlcmUgRFJBTSByZXNpZGVzIGFib3Zl
IDRHQiB0byBjb3JyZWN0bHkgYWNjZXNzIEVIQ0kNCj4gPiBkZXNjcmlwdG9ycyB3aGlsZSBrZWVw
aW5nIHRoZSBkZWZhdWx0IGJlaGF2aW9yIHVuY2hhbmdlZCBmb3IgZXhpc3RpbmcNCj4gPiBtYWNo
aW5lcy4NCj4gDQo+IFRoaXMgaXMgZHViaW91cy4gTWF5YmUgdGhlIEFTVDI3MDAgaXNuJ3QgbW9k
ZWxsZWQgYXBwcm9wcmlhdGVseSAobGlrZSBzb21lDQo+IG1lbW9yeSByZWdpb24gbm90IG1hcHBl
ZCBpbiB0aGUgY29ycmVjdCBjb250YWluZXIsIG9yIHNvbWUgY29kZSBwYXRoIG5vdA0KPiB1c2lu
ZyB0aGUgY29ycmVjdCBhZGRyZXNzIHNwYWNlKS4NCj4gDQoNClRoZSBiZWhhdmlvciBvbiBBU1Qy
NzAwIGlzIG1haW5seSBkdWUgdG8gaG93IHRoZSBEUkFNIGFkZHJlc3Mgc3BhY2UgaXMgZGVzaWdu
ZWQuDQoNCk9uIEFTVDI3MDAsIERSQU0gdXNlcyBhIDY0LWJpdCBhZGRyZXNzIHNwYWNlLCB3aXRo
IHRoZSBiYXNlIGFkZHJlc3Mgc3RhcnRpbmcgYXQgMHg0MDAwMDAwMDAuIEFsbCBFSENJIGRlc2Ny
aXB0b3JzIChpVEQsIHNpVEQsIHFURCwgYW5kIFFIKSBhcmUgYWxsb2NhdGVkIGluIERSQU0sIHNv
IHRoZWlyIGFkZHJlc3NlcyBuYXR1cmFsbHkgZmFsbCBpbnRvIHRoZSAiMHg0WFhYWFhYWFgiIHJh
bmdlLg0KDQpIb3dldmVyLCBMaW51eCBFSENJIGRyaXZlcnMgZG8gbm90IGZ1bGx5IHN1cHBvcnQg
NjQtYml0IGRlc2NyaXB0b3IgYWRkcmVzc2VzIGluIHRoaXMgY29udGV4dC4gVGhleSB0eXBpY2Fs
bHkgY29uZmlndXJlIHRoZSBjb250cm9sIHJlZ2lzdGVyIChDVFJMRFNTRUdNRU5UKSB0byAiMHgw
IiBhbmQgc2V0IHRoZSAiRE1BIG1hc2sgdG8gMzIgYml0cyIuIFRoaXMgZWZmZWN0aXZlbHkgYXNz
dW1lcyBhIDMyLWJpdCBhZGRyZXNzaW5nIG1vZGVsLg0KDQpUbyBtYWtlIEFTVDI3MDAgd29yayBj
b3JyZWN0bHksIHdlIGludHJvZHVjZWQgYW4gdXBzdHJlYW0gcGF0Y2ggdGhhdCBhbGxvd3MgdGhl
ICJETUEgbWFzayB0byBiZSBzZXQgdG8gNjQgYml0cyIsIGVuc3VyaW5nIGRlc2NyaXB0b3JzIGFy
ZSBhbGxvY2F0ZWQgaW4gdGhlIGNvcnJlY3QgNjQtYml0IERSQU0gYWRkcmVzcyBzcGFjZS4gUGxl
YXNlIHJlZmVyIHRvIHRoaXMgY29tbWl0Og0KDQpodHRwczovL2dpdGh1Yi5jb20vdG9ydmFsZHMv
bGludXgvY29tbWl0LzI3NGYyMjMyYTk0ZjZjYTYyNmQ2MDI4ODA0NGUxM2Q5YTU4Yzc2MTINCg0K
UmVnYXJkaW5nIHRoZSAiQ1RSTERTU0VHTUVOVCIgcmVnaXN0ZXIgZGVzaWduIG9uIEFTVDI3MDA6
DQoNCkFsdGhvdWdoIHRoZSBFSENJIHNwZWNpZmljYXRpb24gZGVmaW5lcyBpdCBhcyB0aGUgdXBw
ZXIgYml0cyBvZiB0aGUgc3lzdGVtIG1lbW9yeSBhZGRyZXNzLCAib24gQVNUMjcwMCBpdCBpcyBp
bnRlcnByZXRlZCBhcyBhIERSQU0gb2Zmc2V0Ii4NClNpbmNlIExpbnV4IGFsd2F5cyBzZXRzIHRo
aXMgcmVnaXN0ZXIgdG8gMCwgdGhlIGhhcmR3YXJlIGlzIGRlc2lnbmVkIHNvIHRoYXQgYSB2YWx1
ZSBvZiAwIGNvcnJlc3BvbmRzIHRvIHRoZSAiRFJBTSBiYXNlIG9mZnNldCIuIA0KVGhpcyBhbGxv
d3MgZXhpc3RpbmcgTGludXggVVNCIGNvbW1vbiBkcml2ZXJzIHRvIHdvcmsgd2l0aG91dCBtb2Rp
ZmljYXRpb24uDQoNCkluIGNvbnRyYXN0LCB0aGUgY3VycmVudCBFSENJIG1vZGVsIGluIFFFTVUg
aW50ZXJwcmV0cyB0aGlzIGZpZWxkIGFzIHBhcnQgb2YgdGhlICJzeXN0ZW0gbWVtb3J5IGFkZHJl
c3MsIG5vdCBhIERSQU0gb2Zmc2V0Ii4gDQpBcyBhIHJlc3VsdCwgaXQgd291bGQgbmVlZCB0byB1
c2UgdGhlIGZ1bGwgRFJBTSBiYXNlIGFkZHJlc3MgKDB4NDAwMDAwMDAwKSwgd2hpY2ggZG9lcyBu
b3QgbWF0Y2ggdGhlIEFTVDI3MDAgaGFyZHdhcmUgYmVoYXZpb3IoYmVjYXVzZSBpdCBhbHdheXMg
c2V0IGJpdCAzNCB0byAxKS4NCg0KRnJvbSB0aGUgQVNUMjcwMCBkYXRhc2hlZXQgKEVIQ0kzMCk6
DQoNClsxOjBdIEJBU0UgQUREUkVTUyBIaQ0KVGhlc2UgYml0cyBjb3JyZXNwb25kIHRvIGFkZHJl
c3MgbGluZXMgWzMzOjMyXSBmb3IgYWxsIEVIQ0kgZGF0YSBzdHJ1Y3R1cmVzLg0KSW4gQVNUMjcw
MCwgdGhpcyBlZmZlY3RpdmVseSBhY3RzIGFzIGEgRFJBTSBvZmZzZXQsIHNpbmNlIHRoZSBoYXJk
d2FyZSBpbnRlcm5hbGx5IGZpeGVzIGhpZ2hlciBhZGRyZXNzIGJpdHMgKGUuZy4sIGJpdCAzNCA9
IDEpLCBtYXBwaW5nIGFjY2Vzc2VzIGludG8gRFJBTSBhdCAweDQwMDAwMDAwMC4NCg0KVG8gcmVz
b2x2ZSB0aGlzIG1pc21hdGNoLCBvbmUgcG9zc2libGUgYXBwcm9hY2ggaXMgdG8gaW50cm9kdWNl
IGEgRFJBTSBsaW5rIG1vZGUgaW4gdGhlIEVIQ0kgbW9kZWwsIHNvIHRoYXQgYWxsIGRlc2NyaXB0
b3IgYWRkcmVzc2VzIGFyZSBpbnRlcnByZXRlZCBhcyBEUkFNIG9mZnNldHMgcmF0aGVyIHRoYW4g
c3lzdGVtIGFkZHJlc3Nlcy4gDQpUaGlzIHdvdWxkIGVsaW1pbmF0ZSB0aGUgbmVlZCBmb3IgdGhl
IGRlc2NyaXB0b3ItYWRkci1vZmZzZXQgcHJvcGVydHkuDQoNCkhvd2V2ZXIsIHRoZSBFSENJIG1v
ZGVsIGFsc28gbmVlZHMgdG8gc3VwcG9ydCBib3RoICJwbGF0Zm9ybSBhbmQgUENJZSIgdXNlIGNh
c2VzLiBJdCBpcyBub3QgY2xlYXIgaG93IHRvIGV4cG9zZSBzdWNoIGEgRFJBTSBsaW5rIGNvbmZp
Z3VyYXRpb24gdmlhIHRoZSBjb21tYW5kIGxpbmUsIGZvciBleGFtcGxlOg0KLWRldmljZSB1c2It
ZWhjaSxidXM9cGNpZS4yLGlkPW15cGNpZWhjaTAsY2Fwcy02NGJpdC1hZGRyPXRydWUNCg0KQ3Vy
cmVudGx5LCB0aGVyZSBpcyBubyBvYnZpb3VzIHdheSB0byBpbmRpY2F0ZSB0aGF0IGFkZHJlc3Nl
cyBzaG91bGQgYmUgdHJlYXRlZCBhcyBEUkFNIG9mZnNldHMgaW5zdGVhZCBvZiBzeXN0ZW0gYWRk
cmVzc2VzLg0KVGhlcmVmb3JlLCBJIGFtIHVzaW5nIHRoZSBkZXNjcmlwdG9yLWFkZHItb2Zmc2V0
IHByb3BlcnR5IHRvIHNwZWNpZnkgdGhlIERSQU0gYmFzZSBhZGRyZXNzLCBzbyB0aGF0IHRoZSBt
b2RlbCBjYW4gdHJhbnNsYXRlIHN5c3RlbSBhZGRyZXNzZXMgaW50byBEUkFNIG9mZnNldHMgYWNj
b3JkaW5nbHkuDQpBbHRlcm5hdGl2ZWx5LCB3ZSBjb3VsZCBpbnRyb2R1Y2UgYSB3b3JrYXJvdW5k
IHByb3BlcnR5IHNwZWNpZmljIHRvIEFTVDI3MDAuIFRoaXMgcHJvcGVydHkgd291bGQgYWxsb3cg
dGhlIG1vZGVsIHRvIHNldCBiaXQgMzQgdG8gMSBpbiB0aGUgQ1RSTERTU0VHTUVOVCByZWdpc3Rl
ciwgDQphbGlnbmluZyB3aXRoIHRoZSBBU1QyNzAwIGhhcmR3YXJlIGRlc2lnbiB3aGVyZSBEUkFN
IGFkZHJlc3NlcyBhcmUgb2Zmc2V0LWJhc2VkIGFuZCBiaXQgMzQgaXMgZWZmZWN0aXZlbHkgZml4
ZWQgdG8gMS4NCg0KSWYgeW91IGhhdmUgYW55IHN1Z2dlc3Rpb25zIG9uIGhvdyB0byBoYW5kbGUg
dGhpcyBjbGVhbmx5IGluIFFFTVUsIHRoZXkgd291bGQgYmUgZ3JlYXRseSBhcHByZWNpYXRlZC4N
Cg0KVGhhbmtzLA0KSmFtaW4NCg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmFtaW4gTGluIDxq
YW1pbl9saW5AYXNwZWVkdGVjaC5jb20+DQo+ID4gLS0tDQo+ID4gICBody91c2IvaGNkLWVoY2ku
aCAgICAgICAgfCAxICsNCj4gPiAgIGh3L3VzYi9oY2QtZWhjaS1wY2kuYyAgICB8IDIgKysNCj4g
PiAgIGh3L3VzYi9oY2QtZWhjaS1zeXNidXMuYyB8IDIgKysNCj4gPiAgIGh3L3VzYi9oY2QtZWhj
aS5jICAgICAgICB8IDEgKw0KPiA+ICAgNCBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykN
Cg0K

