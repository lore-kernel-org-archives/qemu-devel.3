Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06864CC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 07:51:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGtl7-0005bF-5q; Wed, 14 Oct 2026 03:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xGtl2-0005aW-66; Wed, 14 Oct 2026 03:50:40 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xGtl0-0006yR-N2; Wed, 14 Oct 2026 03:50:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sJkC+4spMQtO2JtC6JM3cAcV+YprwxneIWhPfOROmUCy1dDHo/VbbthU4Q3EMu36Oc0T6Sr1doUavGaEy3nQjTnrU/LRtNot1sKKquh2EFOGatncks6MHXISYzEHsMq3bvmglk6kTRwrk/DmOvxrEL2rvQy8sRAAHdx6/9AYp3vEMt9wv4cTrlAL9IVbEPft5gkVmDQApTNh81SiVBbhVT3HHhtlQSqhIt4fKb5s/jmDfuDwb3d9M7De8/EG/Vs1as46wSLkl/CRpn1q0fstviA73/wSUrtnrxa4QBYX2YaU24xPSbUZHgz7rZiqR0yyGxpqCkYgwlGZG5bQyeljOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JyKnVcNB9bb9Oppe6x9bCVeam2Cwo6wbpr3zl72AnQA=;
 b=UFxATvZSaxoQA/BlkOqJE5BR41QnE8mp0l9ABbfYtk8z/xoHHbyrh8Y2uBezztzSsxrXbcg4+2/mT4Xr+6sycR8AjBM3YYynN65sko7gMEv4jjgBY2BQoLEYubh1c6Rv31/AVk71daw0oFh0DhacXapD3fyYe1fI3qcKskT/WpV138uqezG6rdCjXmX9GGwEqWYuGyDmmQdowCR6PUkIOxin27H9GgnJq1hzysfOt6VAomv6N0x6cL6Gu/RTJZlLqG7yfU2vkKoRXs+4ZLqmgP8t4YINRgp1ev1Vdnn7mLzdDHjvVQs0HdFMtPLwe4IhWsr2mlQDqhrVfofKGhoxGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JyKnVcNB9bb9Oppe6x9bCVeam2Cwo6wbpr3zl72AnQA=;
 b=CMh3fm4mejwNjggC+k3/2IwjuXbJAJcEWScwYwHNYvKRa/U+ZuYdsHJ4auh/Hdc7N7YKKHKfQEcNS/sDrjgMsF7OxDlHeaoQlEuYW9nBWQMTq3FqDkXm030UNdzB4dXcU+qsxC5kfuuG3drXk6YAZbdKfWUUF/iTuHX4/nnzUR9vYW5HPatB6tVnO+KvuPkAI+adCu2L+Vg7YNT1pVi19QIBbKliW+gOlLXa7tzxzRBZOLzfFlGWff5tWd0rJ39fXvi93ZeH92QSv4u8qsVrpoCNnxZDa682rnswxm1B1Jkhs3jBwcUt5vwNJ38GxNToBbNcLX8JW8PumAbaH2uuAQ==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SEYPR06MB6864.apcprd06.prod.outlook.com (2603:1096:101:1b4::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 07:50:21 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 07:50:21 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v4 8/8] hw/arm/aspeed: Enable the usbredir server transport
Thread-Topic: [PATCH v4 8/8] hw/arm/aspeed: Enable the usbredir server
 transport
Thread-Index: AQHdW7Cpq30dj0fulEmIKiJDnL6sRA==
Date: Wed, 14 Oct 2026 07:50:21 +0000
Message-ID: <20261014075011.2708115-9-jamin_lin@aspeedtech.com>
References: <20261014075011.2708115-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261014075011.2708115-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SEYPR06MB6864:EE_
x-ms-office365-filtering-correlation-id: 31f7e878-bed3-451a-99d5-08df29c7cc70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|22082099003|18002099003|921020|38070700021|261009223027099003|56012099006;
x-microsoft-antispam-message-info: VUgrUiOdTRNoJKOPNtoHf10c2qDqEiTkbmWXmB1tGHRXMelcFmlGbgh/swTDeIEXUFElK6DYcN/ltUc2qhGUskU1Upu3MTcln14RHn1ZOnH1k/XaS0VckJVOaYHXGGfOyou7xNyzyYp4oT0HFjcON0Vdk0cPpZfK3UNM7LouCgkkHsISjjVhUF+tjWW3zOcv5MOlS2ce7BIiBfx4/17dgbhiZwtyVytVe5odkupMLJpIHLdRkFMd4mrXGkDvtHVLao4Sz2heDKTk3OWJDrX5oy82FaBSluCOuE+Lgt885bnAa8oncW7zbGFbuO5Dj/C9OdeH6yNAFmllt8ZV7/ptRq5UPvQeyi+aBm+MFM4aTn0HxLwqnU1d2bLJNl9okYak/9FRr89uyMYUWdgyubRHOM5oddT4+oSwnO7GKwZ/XS32B+GKMT3nh33IpNgl8dHZQUiOEgRwuNql2X5BqP0A5pKDqDR28bOE8/w9BVdTunnCdX046fkl1pHs2Qb95DwYe8cZ7inujNq9YfkaJfMWSNYUAs7I053nSkRAb8bb8LpEG8AWpBVf8OZu/91neXCanSQXJMZUE6rseh/uO9kKsPIYyGETj7/uYCwaQ05iIj2ILmIeXG85idBx+Pua9nxmei3SnKreBwC8J+xdH2Ku8UCKsdd2wiLcvDV9LlzyKe5ENn2AfBWnYkoFTiTC08QBAflxe2OIav8goSgqfq7NVizNcES2HuOMP77eQGhDSQ9PYutlWHOhDrwMzgoI7Uza
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(22082099003)(18002099003)(921020)(38070700021)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?l9UqEgfh+u3mLhiwQYvL7ChtdrkdIPnYv9XZmH/B/FVTG7PqX4hQAIiRgw?=
 =?iso-8859-1?Q?sS0TrcPUBwf60W8U0eN1GBtS7++uQvbnvoo2pBrZ2LMTiqfgAeBrcxw7Zc?=
 =?iso-8859-1?Q?ZyzWoicoAj1cu0he+4nzhlruCgIO7a9WXFbSgUW4A8KpY4iTv+68OwoQ6A?=
 =?iso-8859-1?Q?mgajvJ/+tDXNqIluwSsyBjvRPq4bDTPXque6sz75Lqb2V7LCZIkUi8l870?=
 =?iso-8859-1?Q?q9QimrXb+we9PlbdF6/CgLFgp1F1DeNCV9BRPn9ocWavijluVUgrcs4qGi?=
 =?iso-8859-1?Q?XU/czfVf3MkK5eKBSrkFZ3D58DFZPBWZxlwlXuFppiXIB0wvYgA2VxFZeD?=
 =?iso-8859-1?Q?wLrOZNxTK7H+ERbkHqO7q2dklcfrvGeAEJ/rI1Aud6asqpDAlSXPk9xCv4?=
 =?iso-8859-1?Q?rciBDj/DQEKoIbh2tbq5FA8jgKWbB8U2ZmXitpz+HSlv+BhKX0hGjoEv8z?=
 =?iso-8859-1?Q?YC0IDYZrGaIzNlLdsh5heAvkmvgRMb9iBPNvPDu22vZzaUSG+gHq+UzBZD?=
 =?iso-8859-1?Q?K9n7MchnFsUlXh6RfdOl/t0be0l2nln3RbZLNN9A4FfGKfmmOF9d9ngdRH?=
 =?iso-8859-1?Q?kIC8VLZS33eowq93venB6TfuMyH5kCNDeKXlzUQ5EUiOFcH1XCZI0oysvW?=
 =?iso-8859-1?Q?LsvdzoK7COI14XHC9P9VY3o/3hea+vCCTUD+1JkBnfTt4y9kaeIqLUYBWy?=
 =?iso-8859-1?Q?4xKgd6eI3YkSED5TPthA/4Br5vsmV3KSAN30I27nrhue9AMNyRA8H6ISmJ?=
 =?iso-8859-1?Q?OveYMHxi51ZCO2fJelRtUhlgQdwN8z8S9Hr3HhcYwArL0dbqkZzDKEiNIj?=
 =?iso-8859-1?Q?JXrtzr5COZ6go0VncWr7b6fWV1j3begsx9oMij8JYIM9fSurQ+lDojnPSa?=
 =?iso-8859-1?Q?eNv69HnTwykZ35SD9EIjByPySwWC38uNCPPlOaK/gaPUsntPknr/nh7d3z?=
 =?iso-8859-1?Q?RmHFU4qdCtqM8rO5nsdrGDupZjtY9w9OElqXFo/9fsBerPQ/5vJmQxLBFX?=
 =?iso-8859-1?Q?dep9uuPQwfWfMpPKNn2lDTqavQFiT1wdmmfpBXtSsxAD3E62fctE5ACpC2?=
 =?iso-8859-1?Q?WTH0AAs2tah6D1Nzm22tTp7BVXWPTtsu5ALkHwWfX7JzGN/vVSOQaX9+cE?=
 =?iso-8859-1?Q?mhD5DKx/t5B3pf8HqCGd9j6TN3uWb4H4firgBEDq95n6UrqPr9+hEn/Dfr?=
 =?iso-8859-1?Q?yK2udC7vrMqpwSvng3vZF6mgLqMvBMIYcLo+85Nxd5RflldaZYdZrVNVmo?=
 =?iso-8859-1?Q?fr7p20dpPkM858UbFjTQCS8OV04OuI2DMpbxBg2Je4H3qVje9BMm8KBrDY?=
 =?iso-8859-1?Q?U1+khPfx6N2hbjTQe5LEa6CR+vWX7j0Bd/67U6f8iGdR1LbBYDzdhJRnUn?=
 =?iso-8859-1?Q?Y+3rRvIlLiwoy651a111NjlMrwyF9mkRnYx9SPDHA52ExIp6zxV16WVkXP?=
 =?iso-8859-1?Q?0tNyVuCfpqd5PiVKU0aTs39zJtFC/KbxB6AxMBoAd779gIOEVWhUr/+4Mr?=
 =?iso-8859-1?Q?+1kFMZBTAtaaQNiS9zz/boUuDofK7+yrqkGddlNGW+lfjGh5qE0VWsCRPg?=
 =?iso-8859-1?Q?6/6hxkKr3Un3mgud/x5/wdaE7bnBOqFgrs7UkfTb5stvM4OMb7h1Z8msDN?=
 =?iso-8859-1?Q?26d5K8bbJLSXU+blsQai1qAzCnbYNWfewj/p90VyxcZSYAO3MQucdSVDxk?=
 =?iso-8859-1?Q?U4MAo3+/erx0mZRgZ6XxupScovNQPycfyyFD5EpQfPPkzb2aA0Fq+AtNDs?=
 =?iso-8859-1?Q?9w8m0D/k3Bok28M51euAuu+setHM61aIElrKp77CqMjcWndDrDVIr+IuKC?=
 =?iso-8859-1?Q?DU4HFp1Yfw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: f4NUyWe8QZbwF2nxJkH3q2oANdyXEyY6IsYeE3u0Bj9zi5xRgBK0iTdR9tHUmw3Z6vzvGsA56gwlMB1Cv7PF88/ytW/6tGpcWIr+1ff+3g4HWRaqo7q8E8vrt2wlZZjlFx26/McwH5fk+1fOALO8XqsaHF0pbpnW4+aZ/ZbTw4rk4t5T6tstsBBIlAJlQMCsShvIfTqIsuAnuxCh3Jugoz1oyLsSbd5RRXz34v1gdHYBn3vbphnRaRsvh5FQ5LFDAAWMk/Ax5oQBNlLA+/5um1uhMSgkcd/PdAUkdd5uFRpBERsEtk9jvboF45H12GssrEti9B4VRcQoAwQnQIn2wQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31f7e878-bed3-451a-99d5-08df29c7cc70
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2026 07:50:21.4950 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8NkWlunSHd3bydEeP3o5QIqVf/1RMCtrggkGID4r5ODTrRCuKknTqiagVBPdLcZSVwk9J1IW9OKbYPAxtSS6MCoi0dBpkLaXpduq/NCNmvY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6864
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

Let the ASPEED machines accept "x-usb-redir-server" with -device, so a=0A=
UDC gadget can be exported to a USB host running in another QEMU:=0A=
=0A=
  -device x-usb-redir-server,id=3Dredirsrv,chardev=3D<chr>=0A=
  -device aspeed.udc-gadget,bus=3Dredirsrv.0,udc=3D/machine/soc/udc=0A=
=0A=
x-usb-redir-server sits on the main system bus so that the USB bus it=0A=
provides can be found by "bus=3D<id>.0". That makes it a sysbus device, and=
=0A=
a sysbus device can only be created with -device if the machine lists it.=
=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>=0A=
---=0A=
 hw/arm/aspeed.c | 7 +++++++=0A=
 1 file changed, 7 insertions(+)=0A=
=0A=
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c=0A=
index a7cfbd6c5e..fc27ac1788 100644=0A=
--- a/hw/arm/aspeed.c=0A=
+++ b/hw/arm/aspeed.c=0A=
@@ -409,6 +409,13 @@ static void aspeed_machine_class_init(ObjectClass *oc,=
 const void *data)=0A=
     mc->no_cdrom =3D 1;=0A=
     mc->no_parallel =3D 1;=0A=
     mc->default_ram_id =3D "ram";=0A=
+    /*=0A=
+     * Lets a UDC gadget be exported to another QEMU instance over usbredi=
r.=0A=
+     * The type name is spelled out rather than used through its macro so=
=0A=
+     * that this still builds when the usbredir library is absent.=0A=
+     */=0A=
+    machine_class_allow_dynamic_sysbus_dev(mc,=0A=
+                                           "x-usb-redir-server");=0A=
     amc->macs_mask =3D ASPEED_MAC0_ON;=0A=
     amc->uart_default =3D ASPEED_DEV_UART5;=0A=
 =0A=
-- =0A=
2.43.0=0A=

