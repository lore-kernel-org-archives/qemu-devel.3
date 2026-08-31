Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B6BC61DE2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 01:22:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0qiP-00022V-Q9; Sun, 30 Aug 2026 21:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x0qiO-00022J-BQ; Sun, 30 Aug 2026 21:21:36 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x0qiK-0000Ov-8s; Sun, 30 Aug 2026 21:21:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FhaXs9Hw7UTWjlBvTWKXKQl+txADlOz3MzCUL379ibAB6rL93PXWSK2q22/iJjFZakj6er6VdW7LxAL38B3RQDyTFfh2ZXYFC40GBOcYfR4Y0xlb/w1LdvpPpTTWyZmeTj0GjxdhY9PdZc0o52YczyFfb67qbn7WvOz/lZ2GPOhDb0Ny5xn3f3/ewGIK5/6B2wUR42ECeBExgAH5K28O28isZaHWbdVv/sHigWL+hDOnA45WrRfuLgTsy2PVCtRppY9nKIb0p81Ne/hdJTA0qa1VQLzBLoqMfvlIUBk6+esV7SYFpbQxNqXof0UqWyMq70z6NnLqevcdWac0vy3bAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jAKB0dpLpvaCCQAYTB6VYGpbfOhWkC25olorDGDYJGE=;
 b=xG5Si0n/o+XzF5KSktjX7HlEsgXhhYUiELYo8R1F0xAOMmdG7rDyi1ri6MJYdWZUVdqP2REsg/d1/PAqT1JE07aKEs00+0V3u3tbp4yUFuqlTAEyaheZtFUVq/G938zc4v6GoIP90J9OydMYW3RwdQvUVcVqeE6OIB84VjAU0e8CzeGLDOVYexSVZaDykob/0Af039Bf9ibzI/yu3eQaku/i/eo2xD5J1Zdns2npkfzI95DyxIXqMTi2Y63TEE7Tmui1ooe8jX922HMDCLDUAwT5xgYcFVtk5jRpLLUUhankSxZrMtG8JE2C4kSpYzDw6VYqxQQSEYucph43+3S7yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAKB0dpLpvaCCQAYTB6VYGpbfOhWkC25olorDGDYJGE=;
 b=AbnkmSR2rovA9D8os97HBtuHWQ78anePXH2saiMK25XLMe1Gr8tuAoUjj66u3FwMCkaZK7Vp9vMVRMy9dWPcc/PZiteJN6GTISlaxiBHTKxpAoJ5RoyTY+cFuPfY1UP2WppfO97rEOslWCGfd1JPXJLKfO+Nt/W5eR6Wy+JYT7dWexX+d1dJyxSueEWGLB0G+7FG2TvqiN4eTOQS3Eckqdr7VpFT8VJlMC8HgFQiAlukdNk3MVF9doXgjZVNZAHscJYilMBihB+MMWw5z1Fj5r9aAjYsvs6YwIa+/spffuUwjawvUBc5FY65tEoFgyR2ErZtgxn0x/Gry/t2+Egrxg==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEZPR06MB8813.apcprd06.prod.outlook.com (2603:1096:101:337::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 01:21:22 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 01:21:22 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
CC: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, Troy
 Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v2 4/9] hw/arm/aspeed_ast10x0: Remove obsolete
 unimplemented SBC mapping
Thread-Topic: [PATCH v2 4/9] hw/arm/aspeed_ast10x0: Remove obsolete
 unimplemented SBC mapping
Thread-Index: AQHdMRwMgjEASpTQWkiRlxIBaIxg2rax4R0AgAWKinA=
Date: Mon, 31 Aug 2026 01:21:21 +0000
Message-ID: <TYZPR06MB49802041CA2F83382CBE524AFCA92@TYZPR06MB4980.apcprd06.prod.outlook.com>
References: <20260821032036.1829294-1-jamin_lin@aspeedtech.com>
 <20260821032036.1829294-5-jamin_lin@aspeedtech.com>
 <apAw9PsvZkpbFDbF@redhat.com>
In-Reply-To: <apAw9PsvZkpbFDbF@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SEZPR06MB8813:EE_
x-ms-office365-filtering-correlation-id: c29157ae-a918-4f6b-8046-08df06fe2ac6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|7416014|1800799024|376014|4143699003|56012099006|38070700021|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: foPFT9Q5XbRmIQI78AF5hWc8kOTNOS9gYsPrci1pxJNXhxAGQvxQclZOoppo6PbXfibeoN/TFc1DyTQ19zbIn7TcXRVgXy4puDfYu8Odn9Aj+pPxZm57PZD/Xk+xiXlBaYGZQOc79xL9TH8I7ZukzYJ3fcASVNbJ/OoJLL5ymWkH1mOwUgs79gu5SDKoxZvFQxHNuuUvHb4NI4Kx2bH89dIIR+HvKkOFzs5ue+45UotFL1ofliy83apRRj4gDj+pyvHa7b3Vy/MSKIvkxMIyI7Eot6zbv/jcyMpqSqQNUmYwO1H+gds4k97OnpCeo5R983geSOFXbYT9xJR52kOs3xgMqfMhPTtbraL3cj8DCUiD1hfH7aKpH3jIEp2RNOG9ptjfxskpbVZdotflyk6Ztlghjp4s6CSrvisPyuWy+pGvOodGIbN+UXZ2c/aNKzj7UI7mTI3STjIJR1wQvDjpCYg9pQdzUcKAeipAu5IHUQst+W2VGQzVDeAZ8kr05OLFOYQ0SU7PzZSaS8OWThhug5YjiZdSqHKB+sjbGVd7m/Gtjiqj9N3Ny71/aF20iDN7ImTwKkYk1pEchmO5wOddKhNDZwIkSi2UAYUklWPyNI/mjPg3waXf0gZ57h8yFjVYHeN/obvbjoxUFqOFRBbkiyH+IPRbamHbs9Ov/58OsOE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(7416014)(1800799024)(376014)(4143699003)(56012099006)(38070700021)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1Jiak1MZ1VnYU1xaXhkb0kzWkExZHdmQjUvYnVjOWpTZEtlRHJWV2tETDZv?=
 =?utf-8?B?TlgzTHIvQmptci9FNjNXRWtLRklIVVFoTHlLQUs3bmYvS1djeDRjMUNJRUI1?=
 =?utf-8?B?RHk1MCt1V3VjU2FDMDdabDErVlR5akIyK1VPVGxDRXNqVUc2LzVwR21pWWpV?=
 =?utf-8?B?Tm0zc29zS3Z5UllwT3RiOVBnTmtmVnA4Z3UzUC9XRGlpYlBNNmJoOTEwN2xo?=
 =?utf-8?B?bmRya1FzL05TN0VKWkZBckFvV2NLcXN6Z3Y0NVdMYlNjZUNocWNSVlFPMEg1?=
 =?utf-8?B?MkExZ3Q1SDhOSkgxR2Y0YUxrT0ZydENveGRGN0FsZzNWTHg0K0ppRzAyM1lz?=
 =?utf-8?B?VmNBbTdqVkxYRGZWSmFqM1hlOWhzdkNHb2lmTU1RVlJqYmdSSG1ya0VsQits?=
 =?utf-8?B?M0dPYkZnbnR2Sk0rSHB1T0NyejYzdE83QmpXSEQwT2h4YWtwUzFoYkZGbWNX?=
 =?utf-8?B?ajU2M3g3aGZ0VExMK21wcnJEUDZtK3pXcmZvejVTc0dmWTNKcTA1eTRaTHNU?=
 =?utf-8?B?aW56OW1ZbUQ1V0tJbWRJcllhTVh0S1RUTmZqK0h1RjdEVzJ4TWR3cXNrWTlz?=
 =?utf-8?B?Uk5mbmNMR0pDck1qaXdoZ3VlaEh1eDFUaWVpZDM4eG5HQTdWNTM2ckp4SGJB?=
 =?utf-8?B?aVdhdE9kcEFsa2NPUDBNV0ZuYkRhb0tzZnJUelFTeUprbmZUNFpLNU9rckxQ?=
 =?utf-8?B?SlArb1A0YVp1Qm9od1FKRkFocEgwbHIxSlExVEcvek9EN3hFK3A5Zyt6MkFo?=
 =?utf-8?B?MWlYaXl4UkhzSk40cUIwcDFGMnBuWlZDdmdGNTVrNUxXVVcxcjJGNHgrczFF?=
 =?utf-8?B?aDJvVnVwYXpRenB4VVEwdlVMK0I0aWNUd3Zlc0FJNlNoY2x1bkwvOTB3NnRS?=
 =?utf-8?B?YWg5YzdteGM0d0Fqb3I5OU1OM0tnZDRXa01KdHNsS0lwVUk0bjZkR2RCTnNP?=
 =?utf-8?B?ODlLM1ZiKzdmWjRBSDNiT2pSdWRMTlkzamxoSVRsNmQ5SnpXVFV1THlZczZN?=
 =?utf-8?B?YSsyU3gzS3pIcDY3LzNNRGQ4UXZIbXN3R3JYQlBIMkhrME81ZW1Vay9tcG9Y?=
 =?utf-8?B?cHlITjlZdDVFQS9kKzJjVGwvYmQrbWJ1eDluWXVFRGZKYjkxK1FGZGx5VkFS?=
 =?utf-8?B?Nit1bnc1aW94bk5XcktTZU1vaEhKZldSTEtOUENFTmcxalBhcVBhNmlUR1Fp?=
 =?utf-8?B?RXBJR2FuZmtnT1NmY0ZtM3lLS3gwYm14bUEydzhpV2dVWTR6ZkpObUtTU1Ay?=
 =?utf-8?B?SWRYSkE1aVFHWjlTcjhqMnFuZmo0enRpdUlqNHZwWE9KOHRxL0QvSXRJRjBE?=
 =?utf-8?B?MFJhM2NsN3owbU00UkdONE1FbFFzVWFheEg2TnkyZGVHYmFaTkxBeWl6Wklp?=
 =?utf-8?B?ME9NVW85STZxdFlYN1VKd0NrSmk3azBrSGg3MjNyeXJMYmtHRkE5ck0yYUtR?=
 =?utf-8?B?RjdDd0x1a1YzRUs4VGRjRXdaa1hpOFh1SXF2U1E0NFBHVW9sUDRXUFJKWGtr?=
 =?utf-8?B?MmdpUjUwUVRJaW5uR3pzSlAxY0wveS9VVFF6K1Zub2RGejg2OG9aQ3lCekJv?=
 =?utf-8?B?a2hsNENSNUtNRmcvalRuSEpsTkNTM1FFdlllV0JQZFlVbURQMjJHQmhLdEl5?=
 =?utf-8?B?K3FHSnFiU0x5TWEzeXo0VE1Kak51aWtLM1RvNE9mZko4ZzBOMG1NRkNnWXJB?=
 =?utf-8?B?TmRLSjRnZE95K0NmOFBNYkZUQzZLYStqcVRnS1Q3QmduNUtpNzB3VUIyaHVV?=
 =?utf-8?B?MmcwK2RxRjhGbXc5UzdYNUJkOTBIbUFFeWh3eDc5QWpFa3Y3NlNkajZCWkVC?=
 =?utf-8?B?aWpDL3VnMXB5SWZyV3VnOStSL1phSlU3cm1lczg3d2J5RkY1cVg0WUVnY0lZ?=
 =?utf-8?B?Q1dTbG9PN3h0RzlLTGRRYkNiMWJXS0d6YnFVREg3dDZSWk9ueDZWSGZMUnhm?=
 =?utf-8?B?ZFh2K0ZwN1ZnZEd0RVBqQTA0UnNaWjNvNGNmcnFYZXN4azB4bDVBUHZEbjgz?=
 =?utf-8?B?dStETlhrdVI0bks2TmpCTVVVelNXNHZhaXo0NzNidzNSL0lkRCttR0RBcFBC?=
 =?utf-8?B?ejd6UWR1Z0NxekpFSlVEbmN0VGJQSGpCcTR3ajBPWEpsbUphOVNJSHJmTDB6?=
 =?utf-8?B?aXRlN3JmVEo4NWIrcHVyZ2Zlekg4WnJDaDFzSXMrTXdkYWwxeFNBRkRKSm5V?=
 =?utf-8?B?WTdZNy9zaTV4eHJZM25WY1ArOVJDeXN3S1R1L050dGFIcnBPclN2aHZPdjRk?=
 =?utf-8?B?TDdRYTBuK2hyOEpwRWRqQzJjWkZMbjZadlRET0xPMkNQOGNxWWZ4ZUZXRFhM?=
 =?utf-8?B?MWVOam9vOUJhUlFuQ0I4SEp5Z3k0eEM5RzdFTnBiOFBHNmxicEJJUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ryse2866pMmBsDEssIKrM8g5BL+piVD2euYidAb/MQggXqovm1fj4ZVF+rxXO/lI5eLb0OG+ELG7xpbtGsaGUrGZbc82dUagaZPtHVaX+RrP3GnIcwmaTB4rua8nwcrgOWZ5tTBRM//5OjuTktMrquNAP9pYwYBmXo4dvIBj7qgP7gjGA7E7FkUrHjdWmqKppk0UrTjWP1JQQM9DI55gNr9qMpgR3OMaANykmcdoBePxYUgWjWcnUu2oJyLv1JV39qJUVGDUHcMXXHRiekEhJktYgW9vuWdYmj7wJnQgzkb5dZKxtRuTK1TCoaq5q371FOkn7ZwWCvMyG0Dm5X6ctQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c29157ae-a918-4f6b-8046-08df06fe2ac6
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 01:21:21.8404 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zJ2wnULL8gwOyIYOr2ta3F34XPTLzmbkjMutbEJLnSlDnmBhD5FcqjGBwUPmF1HO+qrPncYn9nuXagZI6rqapCcm/RhQe3jxBxB9bnZRmUk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB8813
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

SGkgRGFuaWVsDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiA0LzldIGh3L2FybS9hc3BlZWRf
YXN0MTB4MDogUmVtb3ZlIG9ic29sZXRlDQo+IHVuaW1wbGVtZW50ZWQgU0JDIG1hcHBpbmcNCj4g
DQo+IE9uIEZyaSwgQXVnIDIxLCAyMDI2IGF0IDAzOjIwOjQyQU0gKzAwMDAsIEphbWluIExpbiB3
cm90ZToNCj4gPiBoZSBBU1QxMHgwIFNvQyBub3cgaW1wbGVtZW50cyB0aGUgU0JDIGRldmljZSBt
b2RlbC4gSG93ZXZlciwgdGhlDQo+IA0KPiBzL2hlL1RoZS8NCj4gDQoNClRoYW5rcyBmb3IgdGhl
IHJldmlldyBhbmQgc3VnZ2VzdGlvbi4NCldpbGwgZml4IGl0Lg0KDQpKYW1pbg0KPiA+IG9sZCB1
bmltcGxlbWVudGVkIFNCQyBtYXBwaW5nIHdhcyBsZWZ0IGluIHBsYWNlLg0KPiA+DQo+ID4gUmVt
b3ZlIHRoZSBvYnNvbGV0ZSBtYXBwaW5nIG5vdyB0aGF0IHRoZSBTQkMgZGV2aWNlIGlzIGltcGxl
bWVudGVkLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNw
ZWVkdGVjaC5jb20+DQo+ID4gLS0tDQo+ID4gIGh3L2FybS9hc3BlZWRfYXN0MTB4MC5jIHwgNyAt
LS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA3IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlm
ZiAtLWdpdCBhL2h3L2FybS9hc3BlZWRfYXN0MTB4MC5jIGIvaHcvYXJtL2FzcGVlZF9hc3QxMHgw
LmMgaW5kZXgNCj4gPiA5M2M4MTE5NWI1Li41MTY1ZGNjZTU5IDEwMDY0NA0KPiA+IC0tLSBhL2h3
L2FybS9hc3BlZWRfYXN0MTB4MC5jDQo+ID4gKysrIGIvaHcvYXJtL2FzcGVlZF9hc3QxMHgwLmMN
Cj4gPiBAQCAtMTYzLDggKzE2Myw2IEBAIHN0YXRpYyB2b2lkIGFzcGVlZF9zb2NfYXN0MTB4MF9p
bml0KE9iamVjdCAqb2JqLA0KPiBjb25zdCBjaGFyICpzb2NuYW1lKQ0KPiA+ICAgICAgb2JqZWN0
X2luaXRpYWxpemVfY2hpbGQob2JqLCAiaGFjZSIsICZzLT5oYWNlLCB0eXBlbmFtZSk7DQo+ID4N
Cj4gPiAgICAgIG9iamVjdF9pbml0aWFsaXplX2NoaWxkKG9iaiwgImlvbWVtIiwgJnMtPmlvbWVt
LA0KPiBUWVBFX1VOSU1QTEVNRU5URURfREVWSUNFKTsNCj4gPiAtICAgIG9iamVjdF9pbml0aWFs
aXplX2NoaWxkKG9iaiwgInNiYy11bmltcGxlbWVudGVkIiwNCj4gJnMtPnNiY191bmltcGxlbWVu
dGVkLA0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgVFlQRV9VTklNUExFTUVOVEVE
X0RFVklDRSk7DQo+ID4gICAgICBvYmplY3RfaW5pdGlhbGl6ZV9jaGlsZChvYmosICJwd20iLCAm
cy0+cHdtLA0KPiBUWVBFX1VOSU1QTEVNRU5URURfREVWSUNFKTsNCj4gPiAgICAgIG9iamVjdF9p
bml0aWFsaXplX2NoaWxkKG9iaiwgImVzcGkiLCAmcy0+ZXNwaSwNCj4gVFlQRV9VTklNUExFTUVO
VEVEX0RFVklDRSk7DQo+ID4gICAgICBvYmplY3RfaW5pdGlhbGl6ZV9jaGlsZChvYmosICJ1ZGMi
LCAmcy0+dWRjLA0KPiA+IFRZUEVfVU5JTVBMRU1FTlRFRF9ERVZJQ0UpOyBAQCAtMjIyLDExICsy
MjAsNiBAQCBzdGF0aWMgYm9vbA0KPiBhc3BlZWRfc29jX2FzdDEweDBfcmVhbGl6ZShBc3BlZWQx
MHgwU29DU3RhdGUgKmEsIEVycm9yICoqZXJycCkNCj4gPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICJhc3BlZWQuaW8iLA0KPiA+DQo+IHNjLT5tZW1tYXBbQVNQRUVEX0RFVl9J
T01FTV0sDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBBU1BFRURfU09D
X0lPTUVNX1NJWkUpOw0KPiA+IC0gICAgYXNwZWVkX21taW9fbWFwX3VuaW1wbGVtZW50ZWQocy0+
bWVtb3J5LA0KPiA+IC0NCj4gU1lTX0JVU19ERVZJQ0UoJnMtPnNiY191bmltcGxlbWVudGVkKSwN
Cj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJhc3BlZWQuc2JjIiwNCj4g
c2MtPm1lbW1hcFtBU1BFRURfREVWX1NCQ10sDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAweDQwMDAwKTsNCj4gPiAtDQo+ID4gICAgICAvKiBBU1QxMHgwIENQVSBDb3Jl
ICovDQo+ID4gICAgICBhcm12N20gPSBERVZJQ0UoJmEtPmFybXY3bSk7DQo+ID4gICAgICBxZGV2
X3Byb3Bfc2V0X3VpbnQzMihhcm12N20sICJudW0taXJxIiwgMjU2KTsNCj4gPiAtLQ0KPiA+IDIu
NTMuMA0KPiA+DQo+ID4NCj4gDQo+IFdpdGggcmVnYXJkcywNCj4gRGFuaWVsDQo+IC0tDQo+IHw6
IGh0dHBzOi8vYmVycmFuZ2UuY29tICAgICAgIH5+DQo+IGh0dHBzOi8vaGFjaHlkZXJtLmlvL0Bi
ZXJyYW5nZSA6fA0KPiB8OiBodHRwczovL2xpYnZpcnQub3JnICAgICAgICAgIH5+ICAgICAgICAg
IGh0dHBzOi8vZW50YW5nbGUtcGhvdG8ub3JnIDp8DQo+IHw6IGh0dHBzOi8vcGl4ZWxmZWQuYXJ0
L2JlcnJhbmdlICAgfn4gICAgaHR0cHM6Ly9mc3RvcDEzOC5iZXJyYW5nZS5jb20gOnwNCg0K

