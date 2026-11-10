Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FB2606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 07:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=r8AFt5p6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQgI2-00004r-U4; Tue, 10 Nov 2026 02:29:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQgI0-0008UQ-3G; Tue, 10 Nov 2026 02:29:08 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQgHx-0005Uy-Qu; Tue, 10 Nov 2026 02:29:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nkX1oh49duT+TdwWadboW4FdtASYSJtXl06ahiHFALdbR54XSHFD/oI/8uHTw13UHNGvfyEvrz5Nb1r9zZ+zIl7Sf7bl/N+K4nV7Q994j/r1DCFFF7sw4RzIU43slz/b/3Zn3pF26T/E9OHUzCUnXT/U/5TAr+Fhef78qoz301w/dTzUkGHkr3gupzIJe8vkNcqu21DR2UL508aqW8WqGemcLX9q3+mGjMZxwfQ2bvqV+pBdhr59KDcYDNDkH8+w8TnZAuqssxbTeET6VnqKdSeOwOMH8AIEsywEwBBTL9QMB+rqqicSdfmzqLvfp7RYbSt/qWqddSTu07noPpaWBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LzZnNHdIzeYhKsPQFw1u8IQOjkXuF17uzwh1t+JYzwo=;
 b=D1K2uu4s3/wDGxjfcHY8sr4J3kyc3fuXF0zvZeCsuRcgop4OBBEP9v4jLQ92i/u3ae4mRrYeftDGpMxyLV8gK7X/RPpQDIsoveUQ//JodnHw/BzKfnUoV6mQANPZAFeCZo3z5LO/BvJyO7crMhXEdmTvyALmF14EznJVfUibgHRJGWf1MWq9DIF95k36ERqJkg256kQ1AE4glJRrohtFmbzOyCQTYAXrh4DwJgdKuxhjN0EAc+t3Cfk3oQKBtbeYSi0GgxxflR72l3sbdzltWzCPrxmE4dKcsvWVfgJbfKHWvNEkbwX8uKN7PZnxjd6QRgUZ1tA+abP+JU+zykd7Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LzZnNHdIzeYhKsPQFw1u8IQOjkXuF17uzwh1t+JYzwo=;
 b=r8AFt5p6PPWabWOrFVnscA7vzetz0zjbBmQ/grTP+XwLCTykG/9JW75TmANgQbPg6tkxve83wEd5455bearSvLr27/2Z655pU3+wL8KvkkyV3LvXo0GQDDEH3YM6wvj1znS0L7f4Fu77yn3XzJjuZ8x7A68zG4HXCHeaE0qTEXDhRU5AjAZJAxvyDVgKGyTr8hYyon53s3nXpVJYJB9ZC0r70n8KLLxCds2xiz3aH4jB8Rj5kKjAycOKUlZASs76HeKWoh3NU0m7Xxs1EHbFgX2WP9DZdU3Ah7rY3Zd6rh+Vkk/3u105tO/xvr7ixvur61bmm0Q/9mnMmxjMsEelAg==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by KUYPR06MB8987.apcprd06.prod.outlook.com (2603:1096:d10:9a::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 07:28:37 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0615.005; Tue, 10 Nov 2026
 07:28:37 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "berrange@redhat.com" <berrange@redhat.com>, "junjie.cao@linux.dev"
 <junjie.cao@linux.dev>, "kraxel@redhat.com" <kraxel@redhat.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "clg@kaod.org"
 <clg@kaod.org>, "junjie.cao@intel.com" <junjie.cao@intel.com>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>, Tyrone
 Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>, Zhao Liu
 <zhao1.liu@intel.com>, Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v9 12/19] hw/usb/redirect-server: Connect usbredirparser to a
 chardev
Thread-Topic: [PATCH v9 12/19] hw/usb/redirect-server: Connect usbredirparser
 to a chardev
Thread-Index: AQHdcOUZA/GnlLMb2kS4EVyouxZcDA==
Date: Tue, 10 Nov 2026 07:28:36 +0000
Message-ID: <20261110072818.2883349-13-jamin_lin@aspeedtech.com>
References: <20261110072818.2883349-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261110072818.2883349-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|KUYPR06MB8987:EE_
x-ms-office365-filtering-correlation-id: fcd64ba9-e75a-4e21-0abd-08df3efc3c04
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|7416014|22082099003|18002099003|6133799003|10067099003|3023799007|921020|38070700021|5023799004|56012099006|261102123227099003|261102130727099003|261022105027099003|261022115727099003|261026130827099003|261022075727099003|261021135927099003|261021123027099003|261022113327099003|261021130227099003|261021121427099003|261021133027099003|261026135527099003|261009223027099003|261028144727099003|261026140227099003|261026121527099003;
x-microsoft-antispam-message-info: wmiz0BJX6osCLZOOCKAuNuoJ0fyCGqsBQ0ALHKTwjw+s0j4bvdevKKT2XqDC8Ts8UzU7zbTXs2bHmjmmTI/jAoNoysYdoYYIGnunOT1MzuZ+zNZCrRzBoO4FRlo3VCe2wyagHeXpFLPK7M2Uoky3L9TUQmk91Sq6R8bZjx7MXhEYa8QjtbGZmFhmx4d8GyEl5d4px+EKWL0PtScCvfRh0fgbKw+MYrohu8jyF3hZW6M2N0UYbwaKnXO4ZPoBEwjCD+4WP4W3N02krdtS1UE4+diwbNPWYhkA35tvOeX6verBiOebget40MvXa7gt7rUV2sEa9PozkqYEoLu3I3GXgosUMJz7a+AogqIyPiLAIH6wfuAti9E+gAevjeoQ6vkvAiNaBW4cVpoM3TNKWnYodMsvskB9FCtDfCxIuAB6afjKlOMGELMVtvh8EFSyOKzkp2VHrQ2L1+rWvNUK52yPVtdBm6ZNPrwqif8Vf4T+EhiLrV8JlcBspSKD+2acLCs7dlmPzxWJpM0w6ZeAJIuxkzGZmSZRd4d2XhWREVpnSJSvRQVBG4maiUoXRtnCXOBx5aY9CCZSA8p2dqXTKGEWTi0Vu5nDYz99Y7OWpjtV+og1AwR40XQ7pwaGTy94kwHx8gpF1YhM0BiGkB6slwaP9BiNUwqZNEa6bSTq4mRJ8/MTYmsD8aZY2HONRQdzxSt7UkKw1cX/H0KklpplYJix+I9QJ+PEZOERzQHlI3lpZvj2aHT3nSMU79tZhlIlvuLd
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(22082099003)(18002099003)(6133799003)(10067099003)(3023799007)(921020)(38070700021)(5023799004)(56012099006)(261102123227099003)(261102130727099003)(261022105027099003)(261022115727099003)(261026130827099003)(261022075727099003)(261021135927099003)(261021123027099003)(261022113327099003)(261021130227099003)(261021121427099003)(261021133027099003)(261026135527099003)(261009223027099003)(261028144727099003)(261026140227099003)(261026121527099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NeCutmH1tLBQ+XX3Q40m6cW5yn5DgINvMark0BzPCNei+Q2l9Be0iOk3BQ?=
 =?iso-8859-1?Q?cFZsDD9zS38Zc0LJm5WXLM/urd63tlwFXuVetKI6gkXi9wwltNpN8UCFZe?=
 =?iso-8859-1?Q?BQWUaM9xQ39XWg7xs8+Sz7vqUk3dCPJU5Kv5gHdzb036RfQrBvIGGwfzlY?=
 =?iso-8859-1?Q?c+ete1wbbQIemaMQ42roLyUZXP4KqE/jbVBQw8O7/nlfqX4Vh8Py2/f8GI?=
 =?iso-8859-1?Q?dZ6jglzbOdOuF3rXOv+Qo1q+v2uZEWu6mrOrLyObDIvfTwvT/vsZnW8+sF?=
 =?iso-8859-1?Q?V+NOv2Wmn6loalHDNNy0ZL4fIqN/QHnZYlXpK4dxhwtkDdQPxtPAJxouao?=
 =?iso-8859-1?Q?Ih1aznSWiaXMlW7V94Fu6y8IFiO3vRZY3fDc2CKfGHzEm3T+vQEsJvTlBz?=
 =?iso-8859-1?Q?WwOeTM2Cv9vSr5uaviMYOFnsqrwDdCLKZ/4PUqOKo+8p2jMunsfhLq5ko8?=
 =?iso-8859-1?Q?FQO6OS8ExDMvH2GAOsmQyGXh0kUjkbur+9yO38M4hghlZD5WeYgFQFzLIG?=
 =?iso-8859-1?Q?uTEPCSnsbTO3/c3JLQjvHNzpnhfy5XyH5phvGEg5yxNarwTvPWK4oMC0gi?=
 =?iso-8859-1?Q?jgmLOGvq8aIN6hwIcUh3J8xMpAgtTa9z8hab2o2o37/AgNu7KrUC3bWAsA?=
 =?iso-8859-1?Q?zFx5g9L0LiiMG060l1NTI2kIWRw73qVJ91U4VLNDm6xmq8PR/n44yWHxJx?=
 =?iso-8859-1?Q?WDEsuflDgoSykyk2a1INeU/NMw6kPezoR++F/keUTKL7qSQKPti3I2FrKE?=
 =?iso-8859-1?Q?FFmD2312qPR/5sJGOsQgNbihylBnKJcawuCUTX1pa2ef1VyXD5aSkKqh2W?=
 =?iso-8859-1?Q?BL5+qKWrEqT0rVTgQIpecw/+DUcVL/duIRnbYB2QXvnZ+XVFcUmZC6lpR/?=
 =?iso-8859-1?Q?JDREVgpf66PlFLFQxt23+ERMolssfzWlw7gEN2N624eOM4SG0Cq4o26lan?=
 =?iso-8859-1?Q?ALVUOn3nssIk4O/pCsVFsty7AIOgnansjV1LyoFqPuWwj2+SVF+zPVbDXV?=
 =?iso-8859-1?Q?odreg9i3rrdpKqfIEJNzDUs21ycNaBRTQIC0TvpVjM5fxSaRnZJ8hNwVBR?=
 =?iso-8859-1?Q?NyfzNcSKdKaS8bXbrlO6QB4JiklBnRk3FC00q0E8Cd1bGGEukQ7BzGgd7g?=
 =?iso-8859-1?Q?MJHslisGQhWWTSZMKtfC0fmoaZp/U+L6lnS944HkPrccJNwoPxr2TUzIBX?=
 =?iso-8859-1?Q?Tq3YiIBCJciNfB1oRwANSO+boOf5ITznOgE8W2Tyt0mcKYRYiaWhOqumKS?=
 =?iso-8859-1?Q?QmdGiQU7X+tCgVTylvywRCaEj8RoTjvPAMqd6J/IlwFmCvPL2Gmd6ljniu?=
 =?iso-8859-1?Q?Ngxydh9MGHMFU2eHYrD0jOnbDFadZ0dxXQhB7hxu+yIS0nQ9lErUlAknuz?=
 =?iso-8859-1?Q?Ag/ICndXm7l5Fxz3tgQ5TiQTyPWP4OAG6tcBfNJ6aDeBNGMqJdOmHWqsVm?=
 =?iso-8859-1?Q?EVxYndsKJ64Y1R0Mj8P+XuXshhLADn9VmHHNIAA3ADMEBUCJbrvRSaDpHd?=
 =?iso-8859-1?Q?zRMGU989z/kdPlZjMkUXzjeo/8ziX2Ux1GdPz9CVYsdQYMbX06OxDMGjVc?=
 =?iso-8859-1?Q?JhjRfy0GR4BFyEpsmeC38/npc0/w7sbxyoAdbmkCiGhnB6KucpvyxJNQ17?=
 =?iso-8859-1?Q?jIj86bp+DCG7OlAdGwTmsJiyIZMpLCwvOhiBSD4G59Vy+EBDBS15MUGwJQ?=
 =?iso-8859-1?Q?HwEQoSESlwDpQXPzt7gklTexyeyVoqrD4h8BQfVOBkyRW1nSW4JEr6OGRQ?=
 =?iso-8859-1?Q?7JCm7MQGcJHlnllq/7W+h2PXRioEqJ4aaIjVhONxTONWmnIQCJNcRYL36J?=
 =?iso-8859-1?Q?Q5Ev2dr6fA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: hljH+aHI55Zrk14Ymx7QTSr7n8WnTiaWUkT3xnn2sCcXl22/hLsTvO8Aifz6EvhVA0y37dO66PNIebGjj4+vFPhPMSTWUh5wy3VQK1R3n3LqhxV0HOzD2P352c5jbP9ljJLVqakf7ysXjZfhqH+jd3MlmyyYItu9wdE1Cw8Wen2QGcE8W578n0bAlOV5BbRxZY0/DZ6T9fzBDcWG0Wel5nTUPcjfuiSF5MYCS4X2ZEGZ2ML45JessuGc6cj69AdWJYkECYyeFwmGJASVfZudNqgW3VnwporNXrXkmSQ1MTkMw5QYk28Z8KSQqezOIxHHsdToAkJhZhE8g8q0phN1gw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcd64ba9-e75a-4e21-0abd-08df3efc3c04
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 07:28:36.9277 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jF29EpwagbXDGld/6duH0G2Tfsk7bsUQKvENXF6X+JDC5zhp5JK+A7JvJQkUkrcJUscjY9vE6Q1xRDalIozDGHVDajqvhmGQzFSSdj2gj9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR06MB8987
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

Create a usbredirparser when the chardev opens. Feed it from the chardev=0A=
read handler. Destroy it when the chardev closes.=0A=
=0A=
The side that exports a device sets usbredirparser_fl_usb_host. This=0A=
side drives the device, so it is the USB host for it. redirect.c is the=0A=
other side and does not set the flag. The library uses it to decide=0A=
which direction a packet may travel.=0A=
=0A=
The chardev handling follows hw/usb/redirect.c: take no data before the=0A=
parser exists, do not write to a closed backend, do not re-enter the=0A=
writer, and let a close that is still queued finish before a new=0A=
connection opens.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>=0A=
Reviewed-by: Junjie Cao <junjie.cao@linux.dev>=0A=
Tested-by: Junjie Cao <junjie.cao@linux.dev>=0A=
---=0A=
 hw/usb/redirect-server.c | 289 +++++++++++++++++++++++++++++++++++++++=0A=
 hw/usb/trace-events      |   6 +=0A=
 2 files changed, 295 insertions(+)=0A=
=0A=
diff --git a/hw/usb/redirect-server.c b/hw/usb/redirect-server.c=0A=
index 1423564d22..5abaf7e01e 100644=0A=
--- a/hw/usb/redirect-server.c=0A=
+++ b/hw/usb/redirect-server.c=0A=
@@ -50,22 +50,46 @@=0A=
  */=0A=
 =0A=
 #include "qemu/osdep.h"=0A=
+#include "qemu/units.h"=0A=
 #include "qapi/error.h"=0A=
+#include "qemu/error-report.h"=0A=
+#include "qemu/main-loop.h"=0A=
 #include "qemu/module.h"=0A=
 #include "migration/vmstate.h"=0A=
 #include "hw/core/sysbus.h"=0A=
 #include "hw/usb/usb.h"=0A=
+#include "chardev/char-fe.h"=0A=
 #include "qom/object.h"=0A=
 =0A=
+#include <usbredirparser.h>=0A=
+=0A=
+#include "hw/core/qdev-properties.h"=0A=
+#include "hw/core/qdev-properties-system.h"=0A=
+#include "trace.h"=0A=
+=0A=
 #define TYPE_USB_REDIR_SERVER "x-usb-redir-server"=0A=
 OBJECT_DECLARE_SIMPLE_TYPE(USBRedirServer, USB_REDIR_SERVER)=0A=
 =0A=
+#define USBREDIR_SERVER_VERSION "qemu " TYPE_USB_REDIR_SERVER " " QEMU_VER=
SION=0A=
+=0A=
 struct USBRedirServer {=0A=
     SysBusDevice parent_obj;=0A=
 =0A=
     /* USB bus */=0A=
     USBBus bus;=0A=
     USBPort port;=0A=
+=0A=
+    /* Properties */=0A=
+    CharFrontend cs;=0A=
+=0A=
+    /* usbredir over the chardev */=0A=
+    struct usbredirparser *parser;=0A=
+    QEMUBH *chardev_close_bh;=0A=
+    const uint8_t *read_buf;=0A=
+    int read_buf_size;=0A=
+    bool in_write;=0A=
+    guint watch;=0A=
+    bool host_connected;=0A=
 };=0A=
 =0A=
 /*=0A=
@@ -94,6 +118,237 @@ static USBPortOps usbredir_server_port_ops =3D {=0A=
 static USBBusOps usbredir_server_bus_ops =3D {=0A=
 };=0A=
 =0A=
+/*=0A=
+ * usbredirparser I/O and logging callbacks=0A=
+ */=0A=
+=0A=
+static void usbredir_server_log(void *priv, int level, const char *msg)=0A=
+{=0A=
+    switch (level) {=0A=
+    case usbredirparser_error:=0A=
+        error_report(TYPE_USB_REDIR_SERVER ": %s", msg);=0A=
+        break;=0A=
+    case usbredirparser_warning:=0A=
+        warn_report(TYPE_USB_REDIR_SERVER ": %s", msg);=0A=
+        break;=0A=
+    default:=0A=
+        trace_usbredir_server_log(msg);=0A=
+        break;=0A=
+    }=0A=
+}=0A=
+=0A=
+static int usbredir_server_read(void *priv, uint8_t *data, int count)=0A=
+{=0A=
+    USBRedirServer *s =3D priv;=0A=
+=0A=
+    if (s->read_buf_size < count) {=0A=
+        count =3D s->read_buf_size;=0A=
+    }=0A=
+=0A=
+    memcpy(data, s->read_buf, count);=0A=
+=0A=
+    s->read_buf_size -=3D count;=0A=
+    if (s->read_buf_size) {=0A=
+        s->read_buf +=3D count;=0A=
+    } else {=0A=
+        s->read_buf =3D NULL;=0A=
+    }=0A=
+=0A=
+    return count;=0A=
+}=0A=
+=0A=
+static gboolean usbredir_server_write_unblocked(void *do_not_use,=0A=
+                                                GIOCondition cond,=0A=
+                                                void *opaque)=0A=
+{=0A=
+    USBRedirServer *s =3D opaque;=0A=
+=0A=
+    s->watch =3D 0;=0A=
+    usbredirparser_do_write(s->parser);=0A=
+=0A=
+    return G_SOURCE_REMOVE;=0A=
+}=0A=
+=0A=
+static int usbredir_server_write(void *priv, uint8_t *data, int count)=0A=
+{=0A=
+    USBRedirServer *s =3D priv;=0A=
+    int ret;=0A=
+=0A=
+    if (!qemu_chr_fe_backend_open(&s->cs)) {=0A=
+        return 0;=0A=
+    }=0A=
+=0A=
+    /*=0A=
+     * Re-entry guard. The chain is:=0A=
+     *   usbredirparser_do_write() -> this -> qemu_chr_fe_write()=0A=
+     *   -> chardev feeds us -> usbredirparser_do_read()=0A=
+     *   -> a callback -> usbredirparser_do_write() again=0A=
+     *=0A=
+     * The second usbredirparser_do_write() would walk the same buffer=0A=
+     * queue as the first. Returning 0 means "sent nothing", so the=0A=
+     * buffer stays for the outer one to send.=0A=
+     */=0A=
+    if (s->in_write) {=0A=
+        trace_usbredir_server_write_recursion();=0A=
+        return 0;=0A=
+    }=0A=
+    s->in_write =3D true;=0A=
+=0A=
+    ret =3D qemu_chr_fe_write(&s->cs, data, count);=0A=
+    if (ret < count) {=0A=
+        if (!s->watch) {=0A=
+            s->watch =3D qemu_chr_fe_add_watch(&s->cs, G_IO_OUT | G_IO_HUP=
,=0A=
+                                             usbredir_server_write_unblock=
ed,=0A=
+                                             s);=0A=
+        }=0A=
+        if (ret < 0) {=0A=
+            ret =3D 0;=0A=
+        }=0A=
+    }=0A=
+=0A=
+    s->in_write =3D false;=0A=
+=0A=
+    return ret;=0A=
+}=0A=
+=0A=
+/* The remote host greets us once the socket is up. */=0A=
+static void usbredir_server_hello(void *priv,=0A=
+                                  struct usb_redir_hello_header *hello)=0A=
+{=0A=
+    USBRedirServer *s =3D priv;=0A=
+=0A=
+    s->host_connected =3D true;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Parser setup and teardown=0A=
+ */=0A=
+=0A=
+static void usbredir_server_create_parser(USBRedirServer *s)=0A=
+{=0A=
+    uint32_t caps[USB_REDIR_CAPS_SIZE] =3D {};=0A=
+=0A=
+    s->parser =3D usbredirparser_create();=0A=
+    if (!s->parser) {=0A=
+        error_report(TYPE_USB_REDIR_SERVER ": failed to create usbredirpar=
ser");=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    s->parser->priv =3D s;=0A=
+    s->parser->log_func =3D usbredir_server_log;=0A=
+    s->parser->read_func =3D usbredir_server_read;=0A=
+    s->parser->write_func =3D usbredir_server_write;=0A=
+=0A=
+    /* Callbacks for messages the remote host sends to us */=0A=
+    s->parser->hello_func =3D usbredir_server_hello;=0A=
+=0A=
+    /* Capabilities: 64-bit IDs, connect_device_version, ep_info sizes */=
=0A=
+    usbredirparser_caps_set_cap(caps, usb_redir_cap_connect_device_version=
);=0A=
+    usbredirparser_caps_set_cap(caps, usb_redir_cap_ep_info_max_packet_siz=
e);=0A=
+    usbredirparser_caps_set_cap(caps, usb_redir_cap_64bits_ids);=0A=
+=0A=
+    /*=0A=
+     * In USB the host is the side that starts every transfer; a device=0A=
+     * only answers. The exported device sits on our bus and we issue=0A=
+     * its transfers, so for that device we are the host. That is what=0A=
+     * fl_usb_host means, and why the side that exports a device sets it.=
=0A=
+     *=0A=
+     * The other QEMU does not drive the device, it receives it. In this=
=0A=
+     * protocol that makes it the client, and redirect.c leaves the flag=
=0A=
+     * clear.=0A=
+     *=0A=
+     * Without it the library refuses to send device_connect.=0A=
+     */=0A=
+    usbredirparser_init(s->parser, USBREDIR_SERVER_VERSION,=0A=
+                        caps, USB_REDIR_CAPS_SIZE,=0A=
+                        usbredirparser_fl_usb_host);=0A=
+    usbredirparser_do_write(s->parser);=0A=
+}=0A=
+=0A=
+static void usbredir_server_destroy_parser(USBRedirServer *s)=0A=
+{=0A=
+    s->host_connected =3D false;=0A=
+=0A=
+    g_clear_handle_id(&s->watch, g_source_remove);=0A=
+=0A=
+    if (s->parser) {=0A=
+        usbredirparser_destroy(s->parser);=0A=
+        s->parser =3D NULL;=0A=
+    }=0A=
+}=0A=
+=0A=
+static void usbredir_server_chardev_close_bh(void *opaque)=0A=
+{=0A=
+    usbredir_server_destroy_parser(opaque);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * chardev callbacks=0A=
+ */=0A=
+=0A=
+static int usbredir_server_chardev_can_read(void *opaque)=0A=
+{=0A=
+    USBRedirServer *s =3D opaque;=0A=
+=0A=
+    if (!s->parser) {=0A=
+        return 0;=0A=
+    }=0A=
+    /* usbredirparser_do_read() consumes everything we hand it */=0A=
+    return 1 * MiB;=0A=
+}=0A=
+=0A=
+static void usbredir_server_chardev_read(void *opaque, const uint8_t *buf,=
=0A=
+                                         int size)=0A=
+{=0A=
+    USBRedirServer *s =3D opaque;=0A=
+=0A=
+    if (!s->parser) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    /* No recursion allowed */=0A=
+    assert(s->read_buf =3D=3D NULL);=0A=
+=0A=
+    s->read_buf =3D buf;=0A=
+    s->read_buf_size =3D size;=0A=
+=0A=
+    usbredirparser_do_read(s->parser);=0A=
+    /*=0A=
+     * usbredirparser_do_read() ran our callbacks. Flush whatever=0A=
+     * replies they queued.=0A=
+     */=0A=
+    usbredirparser_do_write(s->parser);=0A=
+}=0A=
+=0A=
+static void usbredir_server_chardev_event(void *opaque,=0A=
+                                          QEMUChrEvent event)=0A=
+{=0A=
+    USBRedirServer *s =3D opaque;=0A=
+=0A=
+    switch (event) {=0A=
+    case CHR_EVENT_OPENED:=0A=
+        trace_usbredir_server_chardev_open();=0A=
+        /*=0A=
+         * A close event only schedules chardev_close_bh. If it has not=0A=
+         * run yet, it would destroy the parser we are about to create,=0A=
+         * so run it now and cancel it.=0A=
+         */=0A=
+        usbredir_server_chardev_close_bh(s);=0A=
+        qemu_bh_cancel(s->chardev_close_bh);=0A=
+        usbredir_server_create_parser(s);=0A=
+        break;=0A=
+    case CHR_EVENT_CLOSED:=0A=
+        trace_usbredir_server_chardev_close();=0A=
+        qemu_bh_schedule(s->chardev_close_bh);=0A=
+        break;=0A=
+    case CHR_EVENT_BREAK:=0A=
+    case CHR_EVENT_MUX_IN:=0A=
+    case CHR_EVENT_MUX_OUT:=0A=
+    case CHR_EVENT_RESIZE:=0A=
+        break;=0A=
+    }=0A=
+}=0A=
+=0A=
 /*=0A=
  * Device registration=0A=
  */=0A=
@@ -102,14 +357,46 @@ static void usbredir_server_realize(DeviceState *dev,=
 Error **errp)=0A=
 {=0A=
     USBRedirServer *s =3D USB_REDIR_SERVER(dev);=0A=
 =0A=
+    if (!qemu_chr_fe_backend_connected(&s->cs)) {=0A=
+        error_setg(errp,=0A=
+                   TYPE_USB_REDIR_SERVER ": 'chardev' property must be set=
");=0A=
+        return;=0A=
+    }=0A=
+=0A=
     /* One port: usbredir carries a single device. */=0A=
     usb_bus_new(&s->bus, sizeof(s->bus), &usbredir_server_bus_ops, dev);=
=0A=
     s->bus.auto_hub =3D false;=0A=
     usb_register_port(&s->bus, &s->port, s, 0, &usbredir_server_port_ops,=
=0A=
                       USB_SPEED_MASK_LOW | USB_SPEED_MASK_FULL |=0A=
                       USB_SPEED_MASK_HIGH);=0A=
+=0A=
+    s->chardev_close_bh =3D qemu_bh_new_guarded(usbredir_server_chardev_cl=
ose_bh,=0A=
+                                              s, &dev->mem_reentrancy_guar=
d);=0A=
+=0A=
+    qemu_chr_fe_set_handlers(&s->cs,=0A=
+                             usbredir_server_chardev_can_read,=0A=
+                             usbredir_server_chardev_read,=0A=
+                             usbredir_server_chardev_event,=0A=
+                             NULL, s, NULL, true);=0A=
+}=0A=
+=0A=
+static void usbredir_server_unrealize(DeviceState *dev)=0A=
+{=0A=
+    USBRedirServer *s =3D USB_REDIR_SERVER(dev);=0A=
+=0A=
+    qemu_chr_fe_deinit(&s->cs, true);=0A=
+    usbredir_server_destroy_parser(s);=0A=
+=0A=
+    if (s->chardev_close_bh) {=0A=
+        qemu_bh_delete(s->chardev_close_bh);=0A=
+        s->chardev_close_bh =3D NULL;=0A=
+    }=0A=
 }=0A=
 =0A=
+static const Property usbredir_server_props[] =3D {=0A=
+    DEFINE_PROP_CHR("chardev", USBRedirServer, cs),=0A=
+};=0A=
+=0A=
 /*=0A=
  * The link to the remote host is a chardev, and we cannot migrate=0A=
  * that. So this device cannot be migrated either.=0A=
@@ -125,8 +412,10 @@ static void usbredir_server_class_init(ObjectClass *kl=
ass, const void *data)=0A=
 =0A=
     dc->desc =3D "USB Redirection Server";=0A=
     dc->realize =3D usbredir_server_realize;=0A=
+    dc->unrealize =3D usbredir_server_unrealize;=0A=
     dc->vmsd =3D &vmstate_usbredir_server;=0A=
     set_bit(DEVICE_CATEGORY_USB, dc->categories);=0A=
+    device_class_set_props(dc, usbredir_server_props);=0A=
 }=0A=
 =0A=
 static const TypeInfo usbredir_server_types[] =3D {=0A=
diff --git a/hw/usb/trace-events b/hw/usb/trace-events=0A=
index 80ead23358..d141661673 100644=0A=
--- a/hw/usb/trace-events=0A=
+++ b/hw/usb/trace-events=0A=
@@ -393,3 +393,9 @@ aspeed_udc_handle_data(int ep_nr, const char *dir, uint=
32_t iov, int ep_idx) "ep=0A=
 aspeed_udc_ep_data_in(unsigned ep, uint32_t rptr, uint32_t wptr, uint32_t =
iov) "ep %u, rptr %u, wptr %u, iov %u"=0A=
 aspeed_udc_ep_data_out(unsigned ep, uint32_t wptr, uint32_t avail, uint32_=
t iov) "ep %u, wptr %u, avail %u, iov %u"=0A=
 aspeed_udc_ep_ack(unsigned ep) "ep %u"=0A=
+=0A=
+# redirect-server.c=0A=
+usbredir_server_chardev_open(void) "chardev opened"=0A=
+usbredir_server_chardev_close(void) "chardev closed"=0A=
+usbredir_server_write_recursion(void) "recursive write, leaving it queued"=
=0A=
+usbredir_server_log(const char *msg) "%s"=0A=
-- =0A=
2.43.0=0A=

