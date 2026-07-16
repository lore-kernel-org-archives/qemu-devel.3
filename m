Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A51DBC4450A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 09:42:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkIbS-0001kl-Gb; Thu, 16 Jul 2026 05:42:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harry.vanhaaren@openchip.com>)
 id 1wkIbR-0001kZ-E6
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 05:42:01 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harry.vanhaaren@openchip.com>)
 id 1wkIbP-0000PF-Sh
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 05:42:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iJlh6K4xwEBozAktrzBYJWxDx3PibE0swsb3O6u2kz2svx1DZByWfIQ2YiGMbVc8H35i0xb+65L7YvtxHn7yCtGa4VJeCcXD0K5ygIdbBP+D1+1N3VPY6bmLjCi+EXDxLov2P0M7Kf94EZAUAOZAP0A3aBHCdDMlukpebRGNOq1rV/jgwJqyT4hyLqpLwOk3R0ADWn/0Af1v/VIlBPvfxlMc/6A6CCi6dM7XEnUhDxdjwlGcwxGelx0gm5UzLuc4UCX60JZ9uuSqHQiYyp2j+JYl34VOs85UlqrmG9J2Nyi/Fka+Fn4QVTAqG7Sv4dvXDjl3L9woT35szB1UqKSDxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=09MFqSeoKXjoALxqoVcrzwepF2cOL9rFEWmTk+rZKYc=;
 b=FADPBhr6sfWlhAtwyA0TnMS+ClC+WDLm2I8WtlIcibwDRe0EM+5vaCxoU++2zVzGEjLFUSia1tysE9tRu+iyXOOzQ1BhAJDn2NDRw0WyX2aohEKfKF+X0e9l+zD3VuMkCowbdDuN/R3reIb9Tzm7xJCrEXYD6cj1YcUP1UuiZ/wHGDTRrP8oBlLaMewFYF69IDGpdqS6ivLlfrgvid2635CG4xbXUyfXFRbBoGE3U+l0oLeKyddXb/j5PLZSkj5NZFA0EVQSsa230oJ77ztUnbTXG0IYWHfXLwA3kyLyJUt6Vokv1q2UwmEjZARvvqhjb73Oybk8WGqh2AVNko+gkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=openchip.com; dmarc=pass action=none header.from=openchip.com;
 dkim=pass header.d=openchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=openchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=09MFqSeoKXjoALxqoVcrzwepF2cOL9rFEWmTk+rZKYc=;
 b=dz+Tq6q2Tp59UojuNE3q2N25RrgGMYmSRZNtE/db7bls3jxRNel0rfiJUGjxV0wpeUBUowH3oKItZEmCsqUSLh0wPih4GMEEp/JtYFNqn6KAKJoqcqdj8sxgBbivQ9c7NIl9TNLJWKGyYFN8a9DGkpVp7SiCvx7WpbPBn7h7O2VeAb+DdRc1cuV9QpN5sMJVq83ZNf8IStTaVvGvyMeR18WS1/+RYtqaO8HcxTOW7ZiFZe7tO6rIU0Bg7hLo7sNgayERO1WDY7qXtotU2SnXV8LJFGJHMHNTh+EWcnWWDDVTNlxKFmVHmF5vuUw71hMQkS3vNPEC08ogHO328U7a4g==
Received: from GV2P192MB3464.EURP192.PROD.OUTLOOK.COM (2603:10a6:150:328::6)
 by VI1P192MB2186.EURP192.PROD.OUTLOOK.COM (2603:10a6:800:1c9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Thu, 16 Jul
 2026 09:41:54 +0000
Received: from GV2P192MB3464.EURP192.PROD.OUTLOOK.COM
 ([fe80::7ed0:3600:9df4:af64]) by GV2P192MB3464.EURP192.PROD.OUTLOOK.COM
 ([fe80::7ed0:3600:9df4:af64%6]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 09:41:53 +0000
From: Harry van Haaren <harry.vanhaaren@openchip.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: BALATON Zoltan <balaton@eik.bme.hu>, Alexandre Iooss <erdnaxe@crans.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Harry van Haaren
 <harry.vanhaaren@openchip.com>
Subject: [PATCH v2 2/2] plugins/execlog: fix execlog vcpu_exit execution print
 loss
Thread-Topic: [PATCH v2 2/2] plugins/execlog: fix execlog vcpu_exit execution
 print loss
Thread-Index: AQHdFQdVLKYSBNRzCUKYrDmbyMMPWQ==
Date: Thu, 16 Jul 2026 09:41:53 +0000
Message-ID: <20260716094126.787556-3-harry.vanhaaren@openchip.com>
References: <20260616161242.267315-1-harry.vanhaaren@openchip.com>
 <20260716094126.787556-1-harry.vanhaaren@openchip.com>
In-Reply-To: <20260716094126.787556-1-harry.vanhaaren@openchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=openchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2P192MB3464:EE_|VI1P192MB2186:EE_
x-ms-office365-filtering-correlation-id: ebf5bbd7-b609-4ffd-7d00-08dee31e77d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|3023799007|6133799003|4143699003|11063799006|56012099006|10067099003|22082099003|38070700021|18002099003;
x-microsoft-antispam-message-info: QRoJOW6HDhhiP7gsI9yUmWqiIr/YLTYI9KM2KbFVt41AyQwqxb6y9aOtF0RVY1VV3WJciSW6pdvuFIWyIIt9/fdJxNn7zkftwukm4DG5nz4hP5Eq+pGwVQhaL/SGs09EpD9MfoFniASrTM11mBVvCKE2MkSqEwTZacPZxv6SPWZi3M0H3nYf4AGXUy1ZrGafckjkaP9+jGaNwlCQJ4rWZ51lN90+8SnN5Rt6z1dEavYNcdPKScOF7Ym2rH0Uw2GgdEQHZgD/BTBLrBQk8N12ijgUVtklY0EGAcpGS8VR+JhEQw8ar0TF+zdC8x4U/vfuFWyiicvALTgaWp3g//MULBAp1X+XaKPWfc2RzFgEGFyNoSLnPb+bIaQU7hx5MpucMRO+k3AerYNHSIvzzyXuQKW8U4ppI1BwZnw+RdUiNn4cnNoom8V2JQv/KZ87uIxlGYzHsymi7OzC8N06hC1RDjlxWtQ6M5myNkeK6avVxsFAny8LLY+372iqqSW/PnPMK0sJI4YPEQ5HfiD7/D4EsGF9eyygFCepYMJ7ukUo0Mfcx6nkbrixPh2JR9zIK5zCLi/6tmwufKf7VBZdDDvd3rVfldMVgV6N+5l+H1PXB/N91E1+wInW1evbv30yH0A69iSXDyBvI7eTvgfj7/phYcozUZAsgBgh2HxTr7nDI22ccZ4hdki5Z7P/wtZsNjIwfwae+Sjee3TlaD/ZesArhWS9veDmmcgYecZY5qZ79RM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2P192MB3464.EURP192.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(3023799007)(6133799003)(4143699003)(11063799006)(56012099006)(10067099003)(22082099003)(38070700021)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NFZwTVVTeXFFK2JKWERLbnZaWmVONjNGQjU5NDg1VS9FN0ovZHRWVTJ5Lzkz?=
 =?utf-8?B?QXB2ZkdJTTQ4VDBMeFYydmVLNXc1MncwNDh1Ukt3SktMbjh6WHFEWkptRGhx?=
 =?utf-8?B?NTYyUzRYSCt4QVVqVjN0bzdGSUwwd0ZEVDRMUE9vTklZSTgyVkgyTCtCbG0v?=
 =?utf-8?B?aTFDMzZYRVcrRjlXRFB3TkY1d2pCa0FZSVBOVTF3bER4YzRVRmJHTjVkR3BV?=
 =?utf-8?B?bW9Kd0ZTRDZkQ09IVnVlbllFd3UweWVwM28wQmc4NnZtTmZ5VkY0M1pBZ2t1?=
 =?utf-8?B?a0NMTi9RNHlxd2J6V3YzTnJ4V2pKajFlQ2tjdjg2Y0JUL2RJMnlEb1lWekxt?=
 =?utf-8?B?V3phV3dhQ1puUjVkQzlOQllLWDFuaTcwMTdqY0JiU1VrZmI5emk3ZmpML0tx?=
 =?utf-8?B?L0IrK21MRWRZakZCYWZ4VVljZTBSby9ObnBGOU9zN0E2OVJHT1JsNEh4VzZF?=
 =?utf-8?B?L1Z3akYyVlp3c0xZVC92bUdqaGt5WnZCR0lFakdIUHQ2WDZSQkhzUThLaDUz?=
 =?utf-8?B?RkNXUm1OVE5hdkx6VTRWZ01pcUNJY3VUUnpTT0VKTk9DOFc1Y2xhbnhRQ2RT?=
 =?utf-8?B?Nk1jdlM3ZC9hc3R2S2lCVnd2ZU9ia1FtNFJhYkNUSEg2SEZhRXpLSzhEZngw?=
 =?utf-8?B?WjFSZmpmNkhYY2szTTljSWtoVHc3dm5UMi9lbjh6clM3OGpTSWZ1Z0JoVzVQ?=
 =?utf-8?B?eWU4dytlaDdNcHZnNGtjQitVanE4dmFidGE0aEk0MmNqeis2MzhpdGVLaWU0?=
 =?utf-8?B?ckgxSVZBU0hVNHZyUGZvTlFOaHA3cW41azY4NmQxRXhxNXN4NjlMc0lmQVE4?=
 =?utf-8?B?MW1NN2pwazcrREdoU0dweTZpOFE2aCtVR0Rhd3hCYzNYaHdnSXFUUWhwZ1hT?=
 =?utf-8?B?NEVwZTIxQUpPNE5WblJ3Qkt6dmtEdGc3SDluUXN0Sk9jeE9LODBVckVnYTFY?=
 =?utf-8?B?bndoSGRwRlFkYVNudWo0dnM5c1JrOGxuK0hwcEdhWHc2LzY0NUd3QVhaNlFF?=
 =?utf-8?B?clREdkdsYzQ0VFkwUGtaRXJLWTU1UWVnYVR4czF1dUxUdmNIandBLzY4Y3V1?=
 =?utf-8?B?M3pCN21hSjNJQVBWMUhqY0pxSXZsYTZEdjlneXp3RnVYZHI0U3lsNG5MdmZp?=
 =?utf-8?B?WXQxNVFqc0ErSnVIbi9ySStZSkx5RDB1MDA2WVBiWnRSZlFCTVNBZTBoTE1y?=
 =?utf-8?B?ZEZVNno5M2VrVkRWa1A0Ynp0ZEo2QjZRc0s0MCtUdlk1czBFT2ZUT29nQ2hS?=
 =?utf-8?B?SWFsREZ1akZaNW1lV1VvVUxOZGhTMmgybE4vY1ZoVWdYM3ZzRWZCRHQrSDFw?=
 =?utf-8?B?VlNJR3lQTVQ0YlZsYllvbTQxY0NlRnNGNERBRDR1NW9sVDdseUNwR2dhRWNX?=
 =?utf-8?B?RFFMV0Y4b2NwcW4vMHU4UmNpNUQrV0FtQ0pFdEgrQXRZZFRpa0FqWDg1NjFw?=
 =?utf-8?B?SGNVV3ZhY2R6dGtUSzdmK2RjRlk1am9SUnBwQmU5bDNjcUc0bWdmR1VyYzZi?=
 =?utf-8?B?RHNzREVMcHVFOGkrRldmU2ZwaTVsTUlGdEhoWU1ERVN0WC9Dbk9vYXUrOEU0?=
 =?utf-8?B?UWpCci8yL3Z3RkxOZlBlTlFSTXV2SXNkN0ZBeWVIRXVhN3dMNHFmUWxhR1Fa?=
 =?utf-8?B?YVdzT2IvWTk2cUNmL0ZlM29KeTh6NGs2ZHBudDNHZ3VlVzNXdDBwSys2NVph?=
 =?utf-8?B?Wm55SjY3NG5jQ0RzUG1XUElVd1cvbFRaWDFmMXNOTUF2TWtxS2g5SkNQMXRS?=
 =?utf-8?B?SFVvS2t0OFJ2RDE3a2w3UXZndjBKbFhoZWZnRU1mUElyKzJKaEx4ZVphdGsw?=
 =?utf-8?B?Q2FrVXdVeVJQY0gySXlKS1BraGdiWGM3cUlqTXlTZzZGYk5zck1laFIvdnpH?=
 =?utf-8?B?RFVucUpOQzRUYXFHTEhteHlSTFpkM0pwNVFZYlh5NWErUytDSXNtNlJjVDNP?=
 =?utf-8?B?c2pmc282ekFIQnI5d2c5cm1UUmFudnNpSExxVXNEWk5QcHBVT09FWDQ2Sy8y?=
 =?utf-8?B?NWNmR1lhenJxSldZS3JiMjdMc3ZuWmtKRTNKYnlDODFyb1BnRGNsaGgySmhm?=
 =?utf-8?B?S3NicnRhODBzTUdwekp3akV1eHZNblBOWnBxRFRhWUNrUzYyVWtVaklVMDR1?=
 =?utf-8?B?S1hLWWMxNGRWR3FiQlJIaFI4anNiZFJKMEljcEJhQU5ENWh3YVpUSkNEMEtF?=
 =?utf-8?B?QWhUWmxmS0hiWThCaXk0ZFZqUDFiMkFDV2wxbkZKU0syRWNlV1pXbXc5bnVC?=
 =?utf-8?B?L2ZMVEZFeTlGRGtsdkd5enVZeEM2S0ZMdjNCTTJSek9ndDh0anF6S2dtWHBv?=
 =?utf-8?B?OFozdmN5aU0zTkMzT1Rnc212blEyTEx0R3VkSnJQdHkyTmFJSnZrUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: openchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2P192MB3464.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ebf5bbd7-b609-4ffd-7d00-08dee31e77d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2026 09:41:53.1961 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dfdd4aff-e2c9-4e1a-8642-7f6cc6bbbe6d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z80QRfAx3tTihrmKr+ColdQkhc7UayEleT4tlUTBJgv7D7/Q+lkmAxyGMJiJGaY43Q051lJuGXUpCwbqWL2nXbcJTSRDljeaeRRlxSZaB9s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P192MB2186
Received-SPF: pass client-ip=2a01:111:f403:c207::3;
 envelope-from=harry.vanhaaren@openchip.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
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

RnJvbTogSGFycnkgdmFuIEhhYXJlbiA8aGFycnkudmFuaGFhcmVuQG9wZW5jaGlwLmNvbT4KCkV4
ZWN1dGVkIGluc3RydWN0aW9ucyBhcmUgY2FjaGVkIGluIHN0cmluZyBmb3JtYXQgaW5zaWRlIHRo
ZQpleGVjbG9nIHBsdWdpbi4gVGhlc2Ugc3RyaW5ncyBhcmUgZmx1c2hlZCBvbiBleGl0IG9mIGEg
VEIsIGltcHJvdmluZwpwZXJmb3JtYW5jZS4gVGhpcyBjYXVzZXMgZXhlY3V0ZWQgaW5zdHJ1Y3Rp
b25zIHRvIGJlIGxvc3Qgd2hlbiBhbgonZWNhbGwnIChyaXNjdiBzeXN0ZW0gY2FsbCkgb2NjdXJz
IHRoYXQgY2F1c2VzIHRoZSB0aHJlYWQgdG8gdGVybWluYXRlLgoKVGhlIGZpeCBpbiB0aGlzIHBh
dGNoIHJlZ2lzdGVycyBhICd2Y3B1X2V4aXQnIGNhbGxiYWNrLCBhbmQgZmx1c2hlcwphbnkgY29u
dGVudCBpbiB0aGUgYy0+bGFzdF9leGVjIGJ1ZmZlciwgdG8gZW5zdXJlIGFsbCBpbnN0cnVjdGlv
bnMgYXJlCnByZXNlbnQgaW4gdGhlIGZpbmFsIGluc3RydWN0aW9uIGxvZy4KClNpZ25lZC1vZmYt
Ynk6IEhhcnJ5IHZhbiBIYWFyZW4gPGhhcnJ5LnZhbmhhYXJlbkBvcGVuY2hpcC5jb20+Ci0tLQog
Y29udHJpYi9wbHVnaW5zL2V4ZWNsb2cuYyB8IDIwICsrKysrKysrKysrKysrKysrKysrCiAxIGZp
bGUgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2NvbnRyaWIvcGx1Z2lu
cy9leGVjbG9nLmMgYi9jb250cmliL3BsdWdpbnMvZXhlY2xvZy5jCmluZGV4IGRmZTAwYmY4MzYu
LmNiMGJkMzk5ZDggMTAwNjQ0Ci0tLSBhL2NvbnRyaWIvcGx1Z2lucy9leGVjbG9nLmMKKysrIGIv
Y29udHJpYi9wbHVnaW5zL2V4ZWNsb2cuYwpAQCAtMzgwLDYgKzM4MCwyNSBAQCBzdGF0aWMgdm9p
ZCB2Y3B1X2luaXQodW5zaWduZWQgaW50IHZjcHVfaW5kZXgsIHZvaWQgKnVzZXJkYXRhKQogICAg
IGMtPnJlZ2lzdGVycyA9IHJlZ2lzdGVyc19pbml0KHZjcHVfaW5kZXgpOwogfQogCisvKioKKyAq
IE9uIHZDUFUgZXhpdCwgZmx1c2ggdGhlIGxhc3QgY2FjaGVkIGluc3RydWN0aW9uIGZvciB0aGlz
IHZDUFUuCisgKgorICogVGhlIG9uZS1pbnN0cnVjdGlvbi1kZWxheSBwYXR0ZXJuIHN0b3JlcyBl
YWNoIGluc3RydWN0aW9uIGluIGxhc3RfZXhlYyBhbmQKKyAqIG9ubHkgcHJpbnRzIGl0IHdoZW4g
dGhlICpuZXh0KiBjYWxsYmFjayBmaXJlcy4gV2hlbiBhIHRocmVhZCBleGl0cyB2aWEKKyAqIHN5
c2NhbGwgKGUuZy4gZWNhbGwvZXhpdCksIG5vIHN1YnNlcXVlbnQgY2FsbGJhY2sgZmlyZXMgZm9y
IHRoYXQgdkNQVSBhbmQKKyAqIHRoZSBmaW5hbCBpbnN0cnVjdGlvbiBpcyBzaWxlbnRseSBkcm9w
cGVkLiBGbHVzaGluZyBoZXJlIGd1YXJhbnRlZXMgaXQgaXMKKyAqIHdyaXR0ZW4gYmVmb3JlIHRo
ZSB2Q1BVIGlzIHRvcm4gZG93bi4KKyAqLworc3RhdGljIHZvaWQgdmNwdV9leGl0KHVuc2lnbmVk
IGludCB2Y3B1X2luZGV4LCB2b2lkICp1ZGF0YSkKK3sKKyAgICBDUFUgKmMgPSBxZW11X3BsdWdp
bl9zY29yZWJvYXJkX2ZpbmQoY3B1cywgdmNwdV9pbmRleCk7CisgICAgaWYgKGMtPmxhc3RfZXhl
YyAmJiBjLT5sYXN0X2V4ZWMtPmxlbikgeworICAgICAgICBnX3N0cmluZ19hcHBlbmRfYyhjLT5s
YXN0X2V4ZWMsICdcbicpOworICAgICAgICBxZW11X3BsdWdpbl9vdXRzKGMtPmxhc3RfZXhlYy0+
c3RyKTsKKyAgICAgICAgZ19zdHJpbmdfdHJ1bmNhdGUoYy0+bGFzdF9leGVjLCAwKTsKKyAgICB9
Cit9CisKIC8qKgogICogT24gcGx1Z2luIGV4aXQsIGZsdXNoIGFueSByZW1haW5pbmcgY2FjaGVk
IGluc3RydWN0aW9ucyBhbmQgZnJlZSBzdGF0ZS4KICAqLwpAQCAtNDYxLDYgKzQ4MCw3IEBAIFFF
TVVfUExVR0lOX0VYUE9SVCBpbnQgcWVtdV9wbHVnaW5faW5zdGFsbChxZW11X3BsdWdpbl9pZF90
IGlkLAogICAgIC8qIFJlZ2lzdGVyIGluaXQsIHRyYW5zbGF0aW9uIGJsb2NrIGFuZCBleGl0IGNh
bGxiYWNrcyAqLwogICAgIHFlbXVfcGx1Z2luX3JlZ2lzdGVyX3ZjcHVfaW5pdF9jYihpZCwgdmNw
dV9pbml0LCBOVUxMKTsKICAgICBxZW11X3BsdWdpbl9yZWdpc3Rlcl92Y3B1X3RiX3RyYW5zX2Ni
KGlkLCB2Y3B1X3RiX3RyYW5zLCBOVUxMKTsKKyAgICBxZW11X3BsdWdpbl9yZWdpc3Rlcl92Y3B1
X2V4aXRfY2IoaWQsIHZjcHVfZXhpdCwgTlVMTCk7CiAgICAgcWVtdV9wbHVnaW5fcmVnaXN0ZXJf
YXRleGl0X2NiKGlkLCBwbHVnaW5fZXhpdCwgTlVMTCk7CiAKICAgICByZXR1cm4gMDsKLS0gCjIu
NTQuMAoK

