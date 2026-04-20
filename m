Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE18CF99C86
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 05:56:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEhcO-0005LW-SG; Mon, 20 Apr 2026 01:56:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wEhcM-0005Ko-38; Mon, 20 Apr 2026 01:56:22 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wEhcJ-0005M2-PA; Mon, 20 Apr 2026 01:56:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h1hlNXedgSnXpR+wcH7y2Eb7oX1RomSoczV0glz7fUEMRqwyhB1FjC5xXKeQh0wd2Y2ICq/Yt274KetonTGbLMdzD7YxrkxExqi70TqmWkhLgSaHW5tiuAN+z9OyYrsU/GcG9S+yvPYtUUZCb3tHlFmtLJCcpYCxy+4MTH5WIi7+zJjgsJMhcCCbGEmF2nkSe9E8FSmovgwXcShDb3EtGhKdqCkUKi3I9840j6rVzo3JVEF7BkurVx1RwDNGSTMRFjWSqDdlbCIkjGxT40rFmAVx3k828r2G4z+e3ZZFTIODq6YYKwUCcmQLVxYgkWV01p14PiX5TZAD7PddM5E6Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/N1bCehV+OOkupOE6DdgNlmLfSblwJp7VpcO1yibEg=;
 b=NuwJ5wWcjJJeqKmUtCV/F+vmSTx+hGhk+3cMroVXbw5svX+gAZlfMIc8qnGHhIEZekJih1UeGGoCy/OOjX6/0JlKWjH5Gico2O7/KTCAUELY9pbzAIDYrRZ3xH5PequYXB50C3c8qoxbPWqaS6qjpB7X2gSgYTbGSruY1KVtsnnREoAweJ1loIZj4IgBFBW+rKljbtybAlh8+y40l93CXuQDVfNqXaq2LOJVUxlBwZ54IhKN9vxT5zz9H67GUWZUnEpi5sLbgm+J3xYz8ci+iUm4kQgmNcX5i28+LQZB5UsPbl+66Blt0NvG2YK+G2+I09DuscQSEc7P86C1HsnvVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/N1bCehV+OOkupOE6DdgNlmLfSblwJp7VpcO1yibEg=;
 b=jcSrrcQqdsqdo7lnJA4U6D7mtvKUhizygU/GHF1YVaOC7mQoGOEd9efdlL5igqCkyVGuNmDJK35s0TZPDRLnO3PT6kGShVCDDWWwxQefa6e9fKZr6BJT9k87V1iiQWYAJp6WUyTa7dhZqBa4BvPD5GzEvatyWlbWeyDtw+Eek/IclafxO0UXFs74tz9Euz0CBF6gF9FaxqzZEvimxQlPfaZLnToOGjQp/Ddr8E+gyYZInNpll5NhyXHd4rdguohyg9/KxAGfJ3t8NJ0nbVmtVSn9bpDFvAfHO4ybFY0ArMdO8A/JpDTmatERQcq2fBmonDswWQbM2orLjwlkhJZPqA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TY0PR06MB5032.apcprd06.prod.outlook.com (2603:1096:400:1bc::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.30; Mon, 20 Apr
 2026 05:56:12 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 05:56:11 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Peter Xu <peterx@redhat.com>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?=
 <clg@kaod.org>, "philmd@linaro.org" <philmd@linaro.org>
CC: "philmd@linaro.org" <philmd@linaro.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, Troy Lee <troy_lee@aspeedtech.com>,
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, Fabiano Rosas <farosas@suse.de>
Subject: RE: [PATCH v3 06/17] hw/usb/hcd-ehci: Change descriptor addresses to
 64-bit
Thread-Topic: [PATCH v3 06/17] hw/usb/hcd-ehci: Change descriptor addresses to
 64-bit
Thread-Index: AQHczUNKKWmZ+R83iUmW5is8kUw4XrXi1YYAgACIrACABBnIQA==
Date: Mon, 20 Apr 2026 05:56:11 +0000
Message-ID: <TYPPR06MB8206C244CD249505E6B543F8FC2F2@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260416014928.1279360-1-jamin_lin@aspeedtech.com>
 <20260416014928.1279360-7-jamin_lin@aspeedtech.com>
 <3ee36a34-573e-48aa-91e3-9140244717f0@kaod.org> <aeJNdLTRSZQiEiP_@x1.local>
In-Reply-To: <aeJNdLTRSZQiEiP_@x1.local>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TY0PR06MB5032:EE_
x-ms-office365-filtering-correlation-id: b1225b44-f932-4a80-1703-08de9ea1869f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: Jk/wE6McK/trvUwV3PvuM7LGqA8hC7GSBpBY17zrgybkMNXx373Amyp+6t56xoYM0tbGbNGnDHxldcUuCvW5689ldKv/GM/MKzrMtb/2930WSGK37x1Pic24tJ2RNU6Wj/I6mqcOLIuRFZOYDN/z0fy9CD6/45uS6XXcb53OZ00BDCR6BNSVX6n29Iau0bv5L0IISThPizcqOaPxGoEJiHcp4OpZP+3iTHsQee7h7gRBvsWjjN7pCNTjoSlf/yXXyLMKNxaWcaudJ3KMMJDWsVDUHC0xawEBENGG45q3NoIjZ/6kN7tkUwARiRknVZoRkoo4AKDdVyEOjBHQ3eY0PuMtavNX5iuCaY7fRRCx0zdspe9/YPvDyE2spxXCYr/phT+a0aulP2szZW/X3Rc6HV/jJ5BkrY7qts7ffIvmCWMevAB7XmgpfU9R0WgLafVsefxVfOGOLSWrX5YfZo95vyK3fLRqhUgxfYE7h3bx92uS4TvSDIvrYMQ2enT+RxDdyn+tO1qXrLyBhzBcmBE56kt+hgQ8YSH4PPlEe/yly3zOUkCB3CPF1p11b4f/RgghxCAzjVd+TqDGG4MydiKnlxfATTzwVyYg9NZaQzG33WLo/1MaJ/8iQ982GO6IVjsi0KhJc0rywmlnh1Obr/6xtlwrqFIZYEXoc7roxlB4q1ZlTdfZ5hxBt29hX/v9sp32NgyLzNxJn7qJ3Pav1jAj9DDY4whkgq4smPrZfOZsVRtanxc7su3XVXBf74jX3WRuBteHAWD/TOcXBKcttEyfC0UG0mllDirSF5hDmy0q9A8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TTNVbkhnY0U2Y2FTdmdoQUlOZUV3ODBPUHA5YUx6R0N2NU1vbjZRRVZ1S0dE?=
 =?utf-8?B?blNNeXhRK2xZS29NeUlYanBENURyazRRL2lqQVkySmJQVVoxUC9zN1lOS2Rk?=
 =?utf-8?B?TWd6YzZLdEF1TklqbU8vK1BPc3ZkbUJJQXRqVE11enBsM3FzajIwVnRPN014?=
 =?utf-8?B?SWs5SFBQdlRlVUt4QWVyWC9uMW02RDZZUkJpdFYzRS9haHJMZThKb3QzRmFo?=
 =?utf-8?B?T3hwTHc1TnpvM3hYSGFZTFVVbFh4QzRRNmt0WlhQeE5zK2tiNTBjZFdmN2hx?=
 =?utf-8?B?eE4zbUpWeVlCMFpGQzRIeDdNcEdRYmlRTTllSlYzajZOclBtdjhkZXhlRC9k?=
 =?utf-8?B?MzV6WVNqZDBESEw5L1F5OEZxOEpIOXkvaUpMcDZ0clo4OU9WWjUxbHF4QlMx?=
 =?utf-8?B?VTk0ZHlOb29NNG10RWR2ckNaMWJmaUVxdko1Rm4xUmFGVGdmVFVBZFA0anhl?=
 =?utf-8?B?Z2w0bTdjS0RSMS83VEtWd1crL0NpalV6Vk9CaWJLQkFDV1lJcjNPbkVyalVJ?=
 =?utf-8?B?c0hkNnpjNzJlQlBFRElaTHNXeDhtY2VsZlFYbWxRRGhUVzVpc3NGb3FRck1W?=
 =?utf-8?B?aDhrZGl3UGhEbkQyK2pjb3NuQ2hLRDhxYkVSRkZ3MjdCdWJNNnRpOFd0RXYv?=
 =?utf-8?B?MVBHOHFnNllCSFMxWDVGSHdpMUEyWVdXZXFpeWJ2U2ZzQldEK1NUZHpnbFU5?=
 =?utf-8?B?WCtpMkFlVjlLTEVobkRSdTVxVUtZMnZFejdqbWVMZlFKcjZHbUhtV1k1eHh3?=
 =?utf-8?B?WUN3K3cwODBWODRtU0EzUnUyWWlvck9iZmFHcWM0OXh5ekloaFMvVkhJOGp4?=
 =?utf-8?B?NEs2b3g5QnZEZ210QngxYWViZFVYWDFiWWtCS1gwOVBrbnU3OEZOUXI5dVMy?=
 =?utf-8?B?c0wzQTJOK2c1QlduWHdZRGxMVTVRR3Bla3BzZUFQQmczMnFTandVbFRybkVq?=
 =?utf-8?B?N0FxV1FBcjFnS0xubW5uN0M1K0ZOdElpMHk2WjQ2N0NhVUJFeER3cmkzZ2pk?=
 =?utf-8?B?MFlZbWdqSzJBcnNBeFQwSjhudFZFNGwxTGM1SlluWFNybWxnQ2hkQ1llcUNZ?=
 =?utf-8?B?aWl3TjlvNHN2aHVqNUxlTTVMMENrMVBVd1c3WWxCZFpmbStQNmxIQUZHL09K?=
 =?utf-8?B?SzVac0M0WGFmN2E2NmgyanM2MkdIYWVQZXZoOTRwa25YeHZseExQa3lXZEEz?=
 =?utf-8?B?RmlTblFySlpLSVR1Sksrbm1KVHZlUlI5OU1MQXF2czBBcFk3M0lYMElYQld2?=
 =?utf-8?B?dTZjUjJIa0tNK0tCc1RsVjRHRXZET2JoazJLSDBIdzJlQnBlUGJuRFBHUHpD?=
 =?utf-8?B?OEdNdWdoallEWHBERC9tbWJ6WXhrNCtnVytDNjA3d3VUK3NGRzA4ZHpPZnJp?=
 =?utf-8?B?QVphNHo1RHhlN3h4RXdPbnZEaXVpRktaRmtWUlpTbldkQUY0RDlmYTdmZDBT?=
 =?utf-8?B?ZndnREFvNlp1ZTVTZmJIOHczejYvVDgyNHB6WGV1YktDRnpSa1ZuWENXTHp2?=
 =?utf-8?B?YTNZZW56bTAwOFRqSE1vc2VHWkNQS0hHcUtadjRNK09XSW1FRk1kSU9ERDFv?=
 =?utf-8?B?SkRDTnA0U3RobHc4QXJwSjJ3UUhPdUNoL2JzTmh0VnFHYWlsUVA3aWR3QXV5?=
 =?utf-8?B?d2hqTFdwQUxHd0wrcjBwc3NYdCt1N0doc2hva0VVZG5KOGlCLytIcnc0Z3ZE?=
 =?utf-8?B?SGFsMXg3eUs1S2llYVllUXNOWlRRR05IK1JoNVp4Nko4djNUZFZyZ2FKRytT?=
 =?utf-8?B?cktjWnllWkFKQlFROCszaU1xSFEvU2xMN3ZidWtqUlBBRnJOMVdWbjd1MFJ5?=
 =?utf-8?B?QkRqczVCMkxmcit4TWtuVVYwV1Q3bWJ0OE13MHpaSC8rc0ViZHB5VUh3ZGJL?=
 =?utf-8?B?YmxmeUx3K0kveFJRcStjL0g2bWpVZU0wZEd0OWYySVhOWmdzb2FYNVhYYU9y?=
 =?utf-8?B?UjJPL2hXQk9iK0hLd0JJODhHbjZEVFNYYTJBZ1p5ZHVabUpLVXRFS3FYNG9m?=
 =?utf-8?B?d0J5Rm5IU28xNTlsamFyOGJlSXhwWmZ4RjU3TG1jcHYyd1ZFUWM5S1lzbUJz?=
 =?utf-8?B?UzZLSHVqMUxka0Z3bkh5ZnJxQ1Y0R2NwZnJCNDJiVlkvNEpjZVF0THhPMUVS?=
 =?utf-8?B?N0JDRDVDVnlRYmZrTDNockJSaDB0MzYyY3lPcDM4dXRyTTFFU0ZYOW14ZWxh?=
 =?utf-8?B?V1daNk54b2UyODlmcFFBUGtjbFhaVlJoSUFYN0tuS2NYTWNpK1M3L241blFC?=
 =?utf-8?B?OUlhN2N4dFJLZnVGQkc2cU13cmpJOXAya202aGErYVQ5REh5cVdOUEhoTnNW?=
 =?utf-8?B?S1RsYUJFWGlYc0o2d3h2UUdYNlQzS0QybnQyWWorM1JZUTJkQTZndz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: TSSJ+CeZkLiKas2fcNX92JTNGBwyTNfuq21g0Uxk+E5JqEgiKT64MpwlNUCyZGg8iQ8H+Sa5NhHvOsZ53nj+KYiN7PtfjDARIaSqlzTzbS4uT8TGcsDArJHraBOWX1/c3gSNKddyUccWVpQGNS6oisOv2b2X+F/zYh0VlwEshrWaPX69Ca/clxUXsrLEj6PrY+k9Ur/dmmxkkRM8CNzaPSC1Nw6O3uS8QhuLApzlMsAjCr8lpKg00lNxBbRxsxbqKfYcR8fGHq3N8UaEdawNBMTnkfN81Y8sq96zmHh+1z5Rsr6vxN+ZH6cdNvl591QqMF7zdXEkT6WViP25Lqcg0A==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1225b44-f932-4a80-1703-08de9ea1869f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2026 05:56:11.8330 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x072+qQav6AeYME41qmAdCQkqMxWGnpDZPXi3OixR+ToGLeB0QLhCXtx53HfYT3Z9EKohujayMLqWH9yNhELBafW4+CGFGzj7fUBdZnarH4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5032
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

SGkgUGV0ZXIsIFBoaWxpcHBlLCBDw6lkcmljDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAw
Ni8xN10gaHcvdXNiL2hjZC1laGNpOiBDaGFuZ2UgZGVzY3JpcHRvciBhZGRyZXNzZXMgdG8NCj4g
NjQtYml0DQo+IA0KPiBPbiBGcmksIEFwciAxNywgMjAyNiBhdCAwOTowMTozNEFNICswMjAwLCBD
w6lkcmljIExlIEdvYXRlciB3cm90ZToNCj4gPiArIFBldGVyLCBGYWJpYW5vLA0KPiA+DQo+ID4g
T24gNC8xNi8yNiAwMzo0OSwgSmFtaW4gTGluIHdyb3RlOg0KPiA+ID4gQ2hhbmdlIGludGVybmFs
IEVIQ0kgZGVzY3JpcHRvciBhZGRyZXNzZXMgZnJvbSB1aW50MzJfdCB0byB1aW50NjRfdC4NCj4g
PiA+DQo+ID4gPiBUaGUgZm9sbG93aW5nIGZpZWxkcyBhcmUgdXBkYXRlZDoNCj4gPiA+IC0gRUhD
SVBhY2tldDo6cXRkYWRkcg0KPiA+ID4gLSBFSENJUXVldWU6OntxaGFkZHIsIHF0ZGFkZHJ9DQo+
ID4gPiAtIEVIQ0lTdGF0ZTo6e2FfZmV0Y2hfYWRkciwgcF9mZXRjaF9hZGRyfQ0KPiA+ID4NCj4g
PiA+IFVwZGF0ZSBnZXRfZHdvcmRzKCkgYW5kIHB1dF9kd29yZHMoKSB0byB0YWtlIDY0LWJpdCBh
ZGRyZXNzZXMgYW5kDQo+ID4gPiBwcm9wYWdhdGUgdGhlIHR5cGUgY2hhbmdlIHRocm91Z2ggdGhl
IGRlc2NyaXB0b3IgdHJhdmVyc2FsIHBhdGhzLg0KPiA+ID4NCj4gPiA+IEFkanVzdCBOTFBUUl9H
RVQoKSB0byBvcGVyYXRlIG9uIDY0LWJpdCB2YWx1ZXM6DQo+ID4gPg0KPiA+ID4gICAgICAjZGVm
aW5lIE5MUFRSX0dFVCh4KSAoKHgpICYgfjB4MWZVTEwpDQo+ID4gPg0KPiA+ID4gc28gdGhhdCBs
aW5rIHBvaW50ZXIgbWFza2luZyB3b3JrcyBjb3JyZWN0bHkgd2hlbiBkZXNjcmlwdG9yDQo+ID4g
PiBhZGRyZXNzZXMgZXhjZWVkIDMyLWJpdCBzcGFjZS4gVGhlIHByZXZpb3VzIG1hc2sgKDB4ZmZm
ZmZmZTApDQo+ID4gPiBpbXBsaWNpdGx5IHRydW5jYXRlZCBhZGRyZXNzZXMgdG8gMzIgYml0cy4N
Cj4gPiA+DQo+ID4gPiBUaGlzIHBhdGNoIGRvZXMgbm90IGNoYW5nZSB0aGUgb24td2lyZSBkZXNj
cmlwdG9yIGxheW91dCB5ZXQuDQo+ID4gPiBJdCBvbmx5IHJlbW92ZXMgdGhlIGludGVybmFsIDMy
LWJpdCBhZGRyZXNzIGxpbWl0IGFuZCBwcmVwYXJlcyBmb3INCj4gPiA+IGxhdGVyIHBhdGNoZXMg
dGhhdCB3aWxsIGFkZCBmdWxsIDY0LWJpdCBRSC9xVEQvaVREL3NpVEQgc3VwcG9ydC4NCj4gPiA+
DQo+ID4gPiBVcGRhdGUgdGhlIEVIQ0kgdHJhY2UtZXZlbnRzIHByb3RvdHlwZXMgZm9yIFFILCBx
VEQsIGlURCwgYW5kIHNpVEQNCj4gPiA+IHRvIHVzZSB1aW50NjRfdCBmb3IgdGhlIGFkZHJlc3Mg
YXJndW1lbnQgYW5kIHByaW50IGl0IHdpdGggUFJJeDY0Lg0KPiA+ID4gVGhpcyBlbnN1cmVzIGZ1
bGwgNjQtYml0IGFkZHJlc3NlcyBhcmUgc2hvd24gaW4gdHJhY2Ugb3V0cHV0IGFuZA0KPiA+ID4g
aW1wcm92ZXMgZGVidWdnaW5nIG9mIHF1ZXVlIGhlYWRzIGFuZCB0cmFuc2ZlciBkZXNjcmlwdG9y
cy4NCj4gPiA+DQo+ID4gPiBNaWdyYXRpb24gY29tcGF0aWJpbGl0eToNCj4gPiA+DQo+ID4gPiBU
aGUgZmV0Y2ggYWRkcmVzcyBmaWVsZHMgaW4gRUhDSVN0YXRlIGFyZSBleHRlbmRlZCBmcm9tIDMy
LWJpdCB0bw0KPiA+ID4gNjQtYml0LCByZXF1aXJpbmcgYSBWTVN0YXRlIHZlcnNpb24gYnVtcCAo
djIgLT4gdjMpLg0KPiA+ID4NCj4gPiA+IEJhY2t3YXJkIGNvbXBhdGliaWxpdHkgaXMgcHJlc2Vy
dmVkIGJ5IGtlZXBpbmcgdGhlIGxlZ2FjeSAzMi1iaXQNCj4gPiA+IGZpZWxkcyAoYV9mZXRjaF9h
ZGRyX3ByZV92MywgcF9mZXRjaF9hZGRyX3ByZV92MykgZm9yIHByZS12Mw0KPiA+ID4gbWlncmF0
aW9uIHN0cmVhbXMgdmlhIFZNU1RBVEVfVUlOVDMyX1RFU1QoKSwgYW5kIGludHJvZHVjaW5nIG5l
dw0KPiA+ID4gNjQtYml0IGZpZWxkcyBmb3IgdjMrLg0KPiA+ID4NCj4gPiA+IEluIHBvc3RfbG9h
ZCwgcHJlLXYzIHN0YXRlIGlzIHByb21vdGVkIHRvIHRoZSA2NC1iaXQgZmllbGRzLg0KPiA+DQo+
ID4gU2luY2UgZWhjaSBpcyBzdXBwb3J0ZWQgYnkgZG93bnN0cmVhbSwgSSdkIHByZWZlciB0aGF0
IHRoZSBtaWdyYXRpb24NCj4gPiBtYWludGFpbmVycyBhbHNvIHZlcmlmeSB0aGUgaW1wbGVtZW50
YXRpb24uDQo+IA0KPiBUaGFua3MsIEknbGwgb25seSBsb29rIGF0IHRoZSBtaWdyYXRpb24gYml0
cy4NCj4gDQo+IFsuLi5dDQo+IA0KPiA+ID4gQEAgLTI0NDEsNiArMjQ0NSwxMSBAQCBzdGF0aWMg
aW50IHVzYl9laGNpX3Bvc3RfbG9hZCh2b2lkICpvcGFxdWUsIGludA0KPiB2ZXJzaW9uX2lkKQ0K
PiA+ID4gICAgICAgICAgIH0NCj4gPiA+ICAgICAgIH0NCj4gPiA+ICsgICAgaWYgKHZlcnNpb25f
aWQgPCAzKSB7DQo+ID4gPiArICAgICAgICBzLT5hX2ZldGNoX2FkZHIgPSBzLT5hX2ZldGNoX2Fk
ZHJfcHJlX3YzOw0KPiA+ID4gKyAgICAgICAgcy0+cF9mZXRjaF9hZGRyID0gcy0+cF9mZXRjaF9h
ZGRyX3ByZV92MzsNCj4gPiA+ICsgICAgfQ0KPiA+ID4gKw0KPiA+ID4gICAgICAgcmV0dXJuIDA7
DQo+ID4gPiAgIH0NCj4gPiA+IEBAIC0yNDcwLDkgKzI0NzksMTQgQEAgc3RhdGljIHZvaWQgdXNi
X2VoY2lfdm1fc3RhdGVfY2hhbmdlKHZvaWQNCj4gKm9wYXF1ZSwgYm9vbCBydW5uaW5nLCBSdW5T
dGF0ZSBzdGF0ZSkNCj4gPiA+ICAgICAgIH0NCj4gPiA+ICAgfQ0KPiA+ID4gK3N0YXRpYyBib29s
IGVoY2lfY29yZV9pc19iZWZvcmVfdmVyc2lvbl8zKHZvaWQgKm9wYXF1ZSwgaW50DQo+ID4gPiAr
dmVyc2lvbl9pZCkgew0KPiA+ID4gKyAgICByZXR1cm4gdmVyc2lvbl9pZCA8IDM7DQo+ID4gPiAr
fQ0KPiA+ID4gKw0KPiA+ID4gICBjb25zdCBWTVN0YXRlRGVzY3JpcHRpb24gdm1zdGF0ZV9laGNp
ID0gew0KPiA+ID4gICAgICAgLm5hbWUgICAgICAgID0gImVoY2ktY29yZSIsDQo+ID4gPiAtICAg
IC52ZXJzaW9uX2lkICA9IDIsDQo+ID4gPiArICAgIC52ZXJzaW9uX2lkICA9IDMsDQo+ID4gPiAg
ICAgICAubWluaW11bV92ZXJzaW9uX2lkICA9IDEsDQo+ID4gPiAgICAgICAucHJlX3NhdmUgICAg
PSB1c2JfZWhjaV9wcmVfc2F2ZSwNCj4gPiA+ICAgICAgIC5wb3N0X2xvYWQgICA9IHVzYl9laGNp
X3Bvc3RfbG9hZCwNCj4gPiA+IEBAIC0yNTAxLDggKzI1MTUsMTIgQEAgY29uc3QgVk1TdGF0ZURl
c2NyaXB0aW9uIHZtc3RhdGVfZWhjaSA9IHsNCj4gPiA+ICAgICAgICAgICAvKiBzY2hlZHVsZSBz
dGF0ZSAqLw0KPiA+ID4gICAgICAgICAgIFZNU1RBVEVfVUlOVDMyKGFzdGF0ZSwgRUhDSVN0YXRl
KSwNCj4gPiA+ICAgICAgICAgICBWTVNUQVRFX1VJTlQzMihwc3RhdGUsIEVIQ0lTdGF0ZSksDQo+
ID4gPiAtICAgICAgICBWTVNUQVRFX1VJTlQzMihhX2ZldGNoX2FkZHIsIEVIQ0lTdGF0ZSksDQo+
ID4gPiAtICAgICAgICBWTVNUQVRFX1VJTlQzMihwX2ZldGNoX2FkZHIsIEVIQ0lTdGF0ZSksDQo+
ID4gPiArICAgICAgICBWTVNUQVRFX1VJTlQzMl9URVNUKGFfZmV0Y2hfYWRkcl9wcmVfdjMsIEVI
Q0lTdGF0ZSwNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgZWhjaV9jb3JlX2lz
X2JlZm9yZV92ZXJzaW9uXzMpLA0KPiA+ID4gKyAgICAgICAgVk1TVEFURV9VSU5UMzJfVEVTVChw
X2ZldGNoX2FkZHJfcHJlX3YzLCBFSENJU3RhdGUsDQo+ID4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGVoY2lfY29yZV9pc19iZWZvcmVfdmVyc2lvbl8zKSwNCj4gPiA+ICsgICAgICAg
IFZNU1RBVEVfVUlOVDY0X1YoYV9mZXRjaF9hZGRyLCBFSENJU3RhdGUsIDMpLA0KPiA+ID4gKyAg
ICAgICAgVk1TVEFURV9VSU5UNjRfVihwX2ZldGNoX2FkZHIsIEVIQ0lTdGF0ZSwgMyksDQo+IA0K
PiBUTDtEUjogSSBmZWVsIGxpa2Ugd2Ugc3RpbGwgbmVlZCBtYWNoaW5lIHR5cGUgY29tcGF0IHBy
b3BlcnRpZXMuDQo+IA0KDQpJIGRvbid0IHVuZGVyc3RhbmQgdGhpczogQ291bGQgeW91IHBsZWFz
ZSBkZXNjcmliZSBpdCBpbiBtb3JlIGRldGFpbD8NCg0KPiBEZXRhaWxzOg0KPiANCj4gV2hlbiBh
IHYyIHN0cmVhbSBhcnJpdmVzLCB0d28gX1RFU1QoKXMgd2lsbCBkbyB0aGUgbG9hZGluZywgdGhl
bg0KPiBwb3N0X2xvYWQoKSBleHRlbmQgaXQgdG8gNjRiaXRzLCBsb29rcyBmaW5lLg0KPiANCj4g
V2hlbiBhIHYzIHN0cmVhbSBhcnJpdmVzLCB0d28gX1RFU1QoKXMgZ290IHNraXBwZWQgdGhlbiBs
YXR0ZXIgdHdvIHRha2UgZWZmZWN0Lg0KPiBwb3N0X2xvYWQoKSBza2lwcy4gIExvb2tzIGZpbmUu
DQo+IA0KPiBXaGVuIG1pZ3JhdGluZyB0byBhbm90aGVyIFFFTVUsIGR1ZSB0byB0aGUgZmFjdCBz
YXZpbmcgdm1zdGF0ZXMgYWx3YXlzIHRha2UNCj4gdm1zZCdzIHZlcnNpb24gZGVjbGFyZWQgKDMp
LCBJIGRvbid0IHNlZSBob3cgaXQgY2FuIG1pZ3JhdGUgYmFjayB0byBhIHYyIHN0cmVhbTsNCj4g
aXQgZGlkbid0IGtub3cgYWJvdXQgdjMuDQo+IA0KPiBKaWFtaW4sIGhhdmUgeW91IHRlc3RlZCBt
aWdyYXRpbmcgZnJvbSBhIG5ldyBRRU1VIGJpbmFyeSBiYWNrIHRvIGFub3RoZXINCj4gb2xkIG9u
ZT8gIEZvciB1cHN0cmVhbSBhbmQgc2VyaW91cyBkZXZpY2VzLCB3ZSBuZWVkIHRvIGd1YXJhbnRl
ZQ0KPiBiaS1kaXJlY3Rpb25hbCBtaWdyYXRpb25zLCBiYWNrIGFuZCBmb3J0aC4NCj4gDQoNClNv
cnJ5LCBJIGFtIG5vdCBmYW1pbGlhciB3aXRoIHRoZSBkZXNpZ24gb2YgUUVNVSBtaWdyYXRpb24s
IGFuZCBJIGRvbid0IGtub3cgaG93IHRvIHRlc3QgaXQuDQpJIGFkZGVkIHRoZXNlIGhvb2sgZnVu
Y3Rpb25zIGJhc2VkIG9uIFBoaWxpcHBlJ3Mgc3VnZ2VzdGlvbiBhbmQgcmV2aWV3Lg0KQ291bGQg
eW91IHRlbGwgbWUgaG93IHRvIHRlc3QgbWlncmF0aW9uIHRvIGVuc3VyZSBib3RoIHZlcnNpb24g
MyBhbmQgdmVyc2lvbiAyIGFyZSB3b3JrYWJsZT8NCg0KVGhhbmtzIGZvciB0aGUgaGVscCwgcmV2
aWV3LCBhbmQgc3VnZ2VzdGlvbnMuDQoNCj4gVGhhbmtzLA0KPiANCj4gPiA+ICAgICAgICAgICBW
TVNUQVRFX0VORF9PRl9MSVNUKCkNCj4gPiA+ICAgICAgIH0NCj4gPiA+ICAgfTsNCj4gDQo+IC0t
DQo+IFBldGVyIFh1DQoNCg==

