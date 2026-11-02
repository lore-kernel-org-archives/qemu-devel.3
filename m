Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48483606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 09:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=ZsoDF8ge
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNoGM-0007g9-VG; Mon, 02 Nov 2026 04:23:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xNoFS-0007MZ-WF; Mon, 02 Nov 2026 04:22:46 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xNoFR-0000Zj-An; Mon, 02 Nov 2026 04:22:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g1ZdZguM1FQ8vg3SJzFhwzJQzqXL+3hM9/AteQ8nO88AxdPxKbth8atPNjW4TDX/IlP/kEZA0rnjvcx28JOFi0RzWkw5t4dMM7AVcrS7aUpgKBt8aBg7KSIBbjA/W5HaVpMqh9p2GErJgkN/HrZQb4JkUrzWfb0FPiLOmT1Leg/pIZhhxUEDEy12IVbIc09r2BQ3H/CBdzTrf2LkENUMOlnXmcCILqs0m/caU63HzTIqgoS7m4bQFAj6PeWlVKUYgF22si6LA83Er2gEqXc0sp3MjDV+YUrOcFbKWPO+U77aoTEQqrkk0qjhs4rkRzvTSiqM7nKGMyOq9Y/Vhdwtfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JyKnVcNB9bb9Oppe6x9bCVeam2Cwo6wbpr3zl72AnQA=;
 b=e9Q0kdAMJix+6G9jmTifqM5W4fYwWqnD/Y+ZyRIUmZ72lTSe09WSHBur+kS+xifIVqXgjXFcfBnLxPsZU47hjUQHXU9qybo4NoAy3+MTSY+51NYwyqBytIZDHR92Eu2New06XXNcSK5zlmjSD5hxeWgi5AQLjpjej/imCPHFm05a2UQf6phJeHuxo3UHIBhsQ1DR44rQHEHTpK+AY414+EDwHeCRp2dSNyO6ReN96p+E8TAXkcz25qEgHyvLk85wVG9NbjSrpjyGWmMhTt13KmWQmtCkIC/rbojJSBVr3U7dni0C+xw3t73lTlpnUd2LC3kLAg1HTXszi2eYWRHNfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JyKnVcNB9bb9Oppe6x9bCVeam2Cwo6wbpr3zl72AnQA=;
 b=ZsoDF8georuT7bruHA7iGarg0w8PIwhCl3uWOqGVNI4vyEdTp9sqRq8MqUcET7jgWWgk2LKDvE9p5BX0DaqSHopW2O+FOBNOTc/K7kl+g1biccUym3WuxmlcoXIVoyxUT/9k0GWputfyQafDdqpqULR4gMf5pnpNX6knYJsgyj5Bjo5vqxr7vhJNv1wjrEWe1kzGfaWQgFHf82YQkAEammjIGgne+nJmy+R6M8L0Us/Vm8xtRMvgENBX/PRMgUVkwSUcUJ0TSpj0TpS+/FsSykoAUs/pTOF0ZYBt8zFnhIl6rxGvmyScLEYXXyaaTphQ4uvFZSPb28rS+2EyO5CqPA==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by PUZPR06MB5499.apcprd06.prod.outlook.com (2603:1096:301:100::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Mon, 2 Nov 2026
 09:22:33 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0592.007; Mon, 2 Nov 2026
 09:22:33 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "kraxel@redhat.com" <kraxel@redhat.com>, "marcandre.lureau@redhat.com"
 <marcandre.lureau@redhat.com>, "junjie.cao@intel.com" <junjie.cao@intel.com>, 
 "junjie.cao@linux.dev" <junjie.cao@linux.dev>, "clg@kaod.org" <clg@kaod.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, Peter Maydell
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
Subject: [PATCH v8 18/18] hw/arm/aspeed: Enable the usbredir server transport
Thread-Topic: [PATCH v8 18/18] hw/arm/aspeed: Enable the usbredir server
 transport
Thread-Index: AQHdaquuxEBCsVxC+0+Qv5Y70HdBCQ==
Date: Mon, 2 Nov 2026 09:22:28 +0000
Message-ID: <20261102092201.1729245-19-jamin_lin@aspeedtech.com>
References: <20261102092201.1729245-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261102092201.1729245-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|PUZPR06MB5499:EE_
x-ms-office365-filtering-correlation-id: 3d81c971-c3f4-4ac0-9dfd-08df38c2d375
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|23010399003|366016|10067099003|18002099003|22082099003|921020|38070700021|56012099006|261021121427099003|261026121527099003|261022105027099003|261026140227099003|261009223027099003|261028144727099003;
x-microsoft-antispam-message-info: 4qhBorJ1GBAsHRVUtZvMsppGz8DJbbJOtD5qBDIhFQ0uaLDqkIclcj++HLU1K+FDmxM4X2dIBijuxr4RZdeBjS+64qlfk0XD+Xdrc/58Fo26U5ehcTr2VcrwHFUiFyj/enSfw8Uu8UqR7Nxy1+fKOrKrMdsPrH16WlvC16q6gwrGnN7fG4KsegCt4UxirLWmAvKbcakdobKkVZ3SknuG4ZGPD1K7EqI8B1zKrMyPClH+/wRaGw0mbvWdqy8aHOqJxNxWrt5cbeYIo6AlDaVfgcJS77msrrWJ3837CEj9d5LvGQ02Qg93SseLfxSQ1DIHOGaZkG8RN0pomfk4RgKBMmywGJSI0o4r/NXlmAxnEIa7YXqKG0/kFJQEp23BmNcCxPdDXo4weDtehsREPxNeABHc8ZEwGCiQedblv+aErF8/VZe2iIppCv8xESTJLgkhJRykQLSz8eHe/YWFVK+7S6h7xhqUXr8rMGVWlWPJ3e4fZm18o5q/cnGKxMbj6Hi6mDWRfWlVhaN2QtmpzMPytTYOKxYytiF2Pll5Kb0xbScFU7un5SgVUSXYCKpNlXCIAWXG4hs52AKwlzt9XGvS+Kr6TpOaSxyQjgH/4EWPOEUxrMtKt/psOy3p2Dsu6SIW3JqkoeKWg7Gkd24bcEy3CSUyr2dUIJb2ERlVsjXOZCnnQU2txROKk6jMSMIl2xb5NU9OinPEOTyaQjorB+m2E33QViD/vOAzyem4FyZP8mwbdg2/YkB+VtcRrpUlYAEn
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(10067099003)(18002099003)(22082099003)(921020)(38070700021)(56012099006)(261021121427099003)(261026121527099003)(261022105027099003)(261026140227099003)(261009223027099003)(261028144727099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Toi23wnPtI1S9NOLSzhYbyBc5d5RdQNPvdTWdVfRbEFSmkYeSO51MmQ1zn?=
 =?iso-8859-1?Q?bg4xFXMJLqEll3cYoiP9RXc1XNd1fg7cLaSesZs47XW/u1se0bjQ036uoC?=
 =?iso-8859-1?Q?Iu7rA38I5GBOIpTxxri5s2LxioP128LVBfoTnxchqb78nqPKYr1wlc3tL2?=
 =?iso-8859-1?Q?mcZIyymDtd5Yrar07Evpx0a1sHhDPWs/zz7FSbbFyERm9RrT4U0CRoxoCi?=
 =?iso-8859-1?Q?wTabnhwkqSvb/PPFeyBNR5cQHWK5Sf4OH/ng5OFWXP/vJq4ep8qYSQv89O?=
 =?iso-8859-1?Q?CEEJAh3dmmn8ZJ4v/uijra0DKQN4YVShqJGCzsoMQ2PD61FSUuNF3k3A+r?=
 =?iso-8859-1?Q?SS71X5aKZjP4221vu+x1eEzzHFaummrWh6hTDKviDNnXBJZmXvr4N0pyUu?=
 =?iso-8859-1?Q?YOl+I7sMoCBBM9evgI5/JdED+d1BoUNx3XzWMUrAS9uRWq5/IfzLJl6HeJ?=
 =?iso-8859-1?Q?aHdwdJC8gQqf8evIjooeIadJwxrN1ltFbA1czKIKFaV+pzbcEQR+3nBO75?=
 =?iso-8859-1?Q?A3W9jK8ULhxen5tX6FawIIxDuXBBwla65DTTDb7GAdeHSm0LZg2FRuacTL?=
 =?iso-8859-1?Q?yTMBAaR3wcuw0G09yJB798ZOU/fmZQV0oAO7MMB9RaK0MeKV+JuXL8Y8Ng?=
 =?iso-8859-1?Q?aJjw5l1uRiFXI12CyYGbIeA8iYBHIBsrlLqT+ElI5Mt8HEdVZDtGcqiLXp?=
 =?iso-8859-1?Q?mfS26MYlZFNtD/4dCiIwB01oCfsj4WrYYgqHpi0+PAhBuZLuR8k5eLsCCW?=
 =?iso-8859-1?Q?BRzH8oLBcW9KsfkYrUIrSBa5mFV/ipT6ohrefaftULds5pz+SXqw9m6ygg?=
 =?iso-8859-1?Q?xxNipybjYvMs4JjUkaKQ1MUDz0DPONcBNPwxhCaD75chw4u0guSY3KWsGG?=
 =?iso-8859-1?Q?/bVuI1iaXUh6MJtLKIBAoB8/OlWc+uZ1c7ifUXc6vmpOeLuqS+h4mDU1mr?=
 =?iso-8859-1?Q?D1EjrjMPt3e6WfS7AxN3yYQ2KMbAfSRsWWDBhojeVAUYI7ULB0ZX5J6goS?=
 =?iso-8859-1?Q?UWV/l5x6eNo9TJid3iJdAH62Q/AcVokX/3dUi+W/MciNTIn2/xFG0xUk12?=
 =?iso-8859-1?Q?9DJQsxkzqT0jr0REi6axLSL+BHquzRvvff2WC7wVj/hyBcwF+5J7K+F0t6?=
 =?iso-8859-1?Q?SwRDf82DpGdKZhNdU+AJlGrh6VnjeLehoJ+b7V9eXzp2BUYKjexzMewbXf?=
 =?iso-8859-1?Q?rF3zZsCgX5/Lm0RaHvn54HjKWQGMXpxhdeJF27MtSDch/h1/eUaZpei7t3?=
 =?iso-8859-1?Q?tVPRYccjzjedYIcXXtOaKgj7icO8AmN6A4GI5MG5cIFreSoB63ulf8pvam?=
 =?iso-8859-1?Q?+rYd5kogxslfHdq0tqHUd4THqcCH0Ogp6pHx1a5zda5od3Td9d6kc9oGbV?=
 =?iso-8859-1?Q?qxRtqvRHXhkx/Ekbzocuq+iBvQup8xDqL0cq+Z6rzQUXiDdnutyNefREtC?=
 =?iso-8859-1?Q?0vX2KS70BCvujBOKYvNFx8d29fWreYsBvEzZX1n6/e2io2THTWjaUAW5ni?=
 =?iso-8859-1?Q?iYxcyNg/lgDWhhMmT01abEUN6Rsa3lH8gpX8I5//E/rO0iTJTEcQ5U3uJ/?=
 =?iso-8859-1?Q?LxJU0wnK0Droez+UoRTW0OXpZ9ILbMScct0O9Yu5m/X/kHdI0oZHSejwvf?=
 =?iso-8859-1?Q?HQI6kjgGY/v0bmv9YXP5KBGM1tQu3SYldK+iez/BmRy/aqzU7UPxN1Xv2C?=
 =?iso-8859-1?Q?L69SnWtgID2mNz1BydeJvIjiQ5A9uPi1gJaSw+/tbtCK+pbvONM58KbdYa?=
 =?iso-8859-1?Q?sQsDJDZtludT6kMwjpwPI3SdTWI5rF1C7QF/ip+Hk1rSU4IUm5ExjdZ4oH?=
 =?iso-8859-1?Q?k4Bi3PL/dg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: RGoginZbfwSbovwo/gOReTFogX/Pdo8biSbUqboJyGy9FW/ZM8I42ikzv7avNYmyheSZjNHhhTfdYuRVR9UT021GeSq0OXUFbYqfcT3zJuupMXBzPNj9ZC6ejDt0QXfUuq2gVcLkmhBEemIcnv8tRFxHCs5VOIIYGVDSlfiKLVumPtJGDym+Z7Odgs9U+qsT9GeMrq+A2OPmpbn65IpaYyNK61nzt4YCEO7iGTBoZogZzGbq+U/NNvlg6/e0bRUWsWo7Yn+21R+vSrtB0asVsiS2xtE6r9VmTtLzfSxHvacWRzl3XXQe+XO94KIU8lClZszcSjffc1xkGyRsoy+cjw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d81c971-c3f4-4ac0-9dfd-08df38c2d375
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 09:22:28.8273 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M0An+H7xYd0rRp5QNFgX8uhGuPZwEwNYqM75LQs0PDOkfAeNf9m0gC2tgZXSrCCJkEiRgGkSLkJFKJf6slktGUg6UWDEAyvL7DyPVwh+QuU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5499
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

