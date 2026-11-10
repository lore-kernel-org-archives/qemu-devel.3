Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C800606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 07:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=rk9f2UVt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQgHe-0008MZ-JE; Tue, 10 Nov 2026 02:28:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQgHc-0008LZ-T1; Tue, 10 Nov 2026 02:28:45 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQgHb-0005Uy-EA; Tue, 10 Nov 2026 02:28:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B7Qz8X/PEoD86Jb9HZH4I8IQ8F6Nk8at/J0vo4xSHrkTTbReAUAVYPmx7HsmUCFQV1BRSjgCAqHW5rjEAGsm1tOT0jed9BrcRS8X/jfroBzqRiaqFiNeZb9kaAW2gKx7WsAIStKmm3rnjjDCUIDcFdp7iDFwXx56p/v4eRmwxDC5zzksySEfla1ng5b1mX9qFzeCWHKIu8BvoCPXXfXrToR3VPSCJ6Zxky4Vut6fOglVGstjDX3+RnYIBqPbueQ0vhMDcWBQ0rRPye2YoR8B0jMwlLlZDqIPc0o8+NCbXS+V5SH9IpwYKlPfXfF3uZISetxGCgTV2P6Ywx614J1aCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0Wi8pcjCzVI/25GAwV4gAuJfwyQPtS6TbTYXqQJyxE=;
 b=TaPatWceQwkPMN4Trl7MOTVu1vQTqNxys6ci5sSa6g6/SgqGCv7ad6uQshWZep8lc5dN4SYQOKvEXOdDL8tITyNclkN6XlF8IRWTe+4W37pxxKnlzRsTH53sdNaBFLYDJoOLT6/BpvSfQqiqEzOfTw1LyAjDspHWb5KJPB1sBtoOBAheKxoqpYZa+vIDYauQ/teM1WfypDJ7Z+0hrRV+QIq5RQxochVTYV8hd2QU36xzOtKRHC20gYBgDbVMuRgv+x7c6zG7VWM7ziGWbkl6OX/WRC/sFsjABel1+ak7i5XoQlToSCf4ot2JAo1Eofg1W+GmxxSn2o92Z5E4Y1qVSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0Wi8pcjCzVI/25GAwV4gAuJfwyQPtS6TbTYXqQJyxE=;
 b=rk9f2UVtGHiR7K0yFxz84Ienh3jDffHV5IxsDerxVeXF2ZyXAS3J505GSQdTabGZPCfAMl+NI2VVlhbhJtwpbJ+3ByiwM0Iv/4QQupLYx+zSjm018afHIwFVtPRGG5dHa2WPVC9P2F79wnw5VJl7FC21K2Tvr3Vhlu94/MPbPJc4O/gluEvpRkfKOGLx5+rAXdA6MU11n35WhXaHr43bkkqGDUzfq40L1ZjSN3WpK5NjySjzFLmTlBrRuP8bpQ5+mrq63p+ZntK+/SW8+1b8Abf1w59jW2WREGfanicLlJ4jnlXtg8p0pR92GoCWDrVintvCvpmHwUZ1W7ktaKLflA==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by KUYPR06MB8987.apcprd06.prod.outlook.com (2603:1096:d10:9a::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 07:28:34 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0615.005; Tue, 10 Nov 2026
 07:28:34 +0000
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
Subject: [PATCH v9 10/19] docs/system/devices/usb: Note the automatic hub
 change
Thread-Topic: [PATCH v9 10/19] docs/system/devices/usb: Note the automatic hub
 change
Thread-Index: AQHdcOUXXeP+rsu8KE6Ii/LyMMZ2iw==
Date: Tue, 10 Nov 2026 07:28:33 +0000
Message-ID: <20261110072818.2883349-11-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 9b07bf1b-0291-426b-4db7-08df3efc3a49
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|7416014|22082099003|18002099003|10067099003|921020|38070700021|56012099006|261102123227099003|261022105027099003|261021123027099003|261021121427099003|261009223027099003|261028144727099003|261026140227099003|261026121527099003;
x-microsoft-antispam-message-info: 4WLH+cqL/gLoSEbNdd5FFgNFTTzZpwtJ9r/Y8hvHbuUGfpH6SkS5dDYNnkz7BkXwJ0W3roB2RqXQvkP421YJJ/B7e8Ek6cncbivRoNkwhjeh4nDCqPST/d4a45dPmplMzO1UO6f6PbdpmBwzlgnVZeAcFtN8a2ncobo97HzZVP/3Kj2iNz4eh8hUc9t9BbpEpZ02YXHF4hl0DHe8BpyRIQ1WQOjZu+WsT2vWsOwxK9j1ydW3VFE2Y7+4zQ2Q3+xAPkHfa0R9Cs10CDMbukIt1Xs+1VMeTmZEj+UWTmw19akwEvTl3sXM1TN0RnuV6Hp9vxRIFMV2LSC7ysjqoeOtAG3rZnz5ExeD7M8C2Vy1xD4kCXXp4qjmNq1NkZ69mu6nnYs7/JSNea+ab9PybS9zLSzhr3u6GhVdpAx8TFHr71mIBCBFZdOJwCaZx1bVmubyifvKP6uYD90Vi2twboRNOwLB0h2dwZT+RRN9aX/W2mN/6FifLeGgYWZyVhGjCZZcMbhUv5Ge6VpCbAnf+uAgo01A4t5rE+oYXRIs6mWVyKaUj8QIb0BKdkSQIgdW5cuYUz/qzwSTe2crIz9s90igVCnUtnFfY/ypH4DZahrUhgIeUHi/nOetuKC5YPxk1bUFCn25jQPRG5OD/sm5dxudmFApAtZbWX774129DoHHGfIMTJVsmBcpNDAuti4iw7jL0hk9G2PGRH9IfwddLcCJPoAK1kIi3R73WcL2NYm7nD8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(22082099003)(18002099003)(10067099003)(921020)(38070700021)(56012099006)(261102123227099003)(261022105027099003)(261021123027099003)(261021121427099003)(261009223027099003)(261028144727099003)(261026140227099003)(261026121527099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?PD0REbv9viYxDtJCcZTDrjVV32gO425OJ55bEEpg5wNmRMb4WeF1pxFnj7?=
 =?iso-8859-1?Q?7N5Qc/wGivEcUJTVFpNIM5jFJRTJD3uPFqqeaHtR5bhYpyUvhrUeI644N5?=
 =?iso-8859-1?Q?ARaDLo69se+iowQQ+TzD5y5ivXG7vzqGojr+ulOfAW0Yzx3P1VHmsIEiWD?=
 =?iso-8859-1?Q?yzeiObgVdJ6q52/iSxR0H5hX+GJZsDYPxhOl4FhEIzAtPWQRYokE56nZyG?=
 =?iso-8859-1?Q?nE6/jul4sgBYCcGcwtjRaGaLffnxKKZRNAFV+BxEu35UJqLMkcntN7YLc7?=
 =?iso-8859-1?Q?pNW3G82JOztfzKXa3G2RkU+PzV5qiMXNd7iWdc7r0mCpgFhz/Lh4cYm19R?=
 =?iso-8859-1?Q?5s1l7JNi6Eg+qHg8dgcizNxuhnDsejGX9+7n72E5GqpP9aRKeHta4cEc50?=
 =?iso-8859-1?Q?5JytSy7Ht8GJoZvu6G5ycnl6ydGWEwMnJdeN7eAj0z3Z8BgvE4aeZlHlen?=
 =?iso-8859-1?Q?DtFdtxSZ5PmJ9LRqDKYg6e1XrPckLQdJ1FsxVUKrHgq81VvAa79qzrCfUu?=
 =?iso-8859-1?Q?j/+bdF9tZLYALGHjpIAEc9NqUu6mEWo2+IT8UVS9+9L6Dt4CC6cIuClsEb?=
 =?iso-8859-1?Q?HSeAnZ6lgPA/7vG4IUFIIjKAPZSmt363o2LBW6U38lwAxDcqBAedo90h3O?=
 =?iso-8859-1?Q?RA7F8UtQ0HhF4plzvzvC3L8Boy28dOBqfwMvL8o8lvOxuCJu81Xc3TWuz+?=
 =?iso-8859-1?Q?dgeiCOEd2AaOkpMMIlL+1Zy+tq2SGq4t1nMQ87EYs7sWUXSVI9D/PNiaEn?=
 =?iso-8859-1?Q?Ntn1N9RLQyDsM3V6EgFudbblOEEDG0AGbM9B/lA+K3g2UcSsdOOMSFBtxY?=
 =?iso-8859-1?Q?3Bl5YLmqmhBdp+obLmebOJ5jrcM5J5JArAxnT68zT9SMqWvKPHa5SIXW4j?=
 =?iso-8859-1?Q?+6yq6203+w02pFhClLV51T1k/ajknp78NXfZOZ7mP0ne0Gk4cnqA+FUwNN?=
 =?iso-8859-1?Q?9rIaM9tl0LG+O52QSidyHv3tVRRZNHyX0Aa2xzj0SSaBIgFdzXpaMSzWp+?=
 =?iso-8859-1?Q?s/kb6+Ol/8+miI7weBj1uECD4moXOfUF8oopZHcPtDGlZaK5DLxNJOOiCA?=
 =?iso-8859-1?Q?t5HFh9Ihn8if6zxQ7wvifPrqrYkdXXunE7oilCYVZGgG5xy9rWPmRFvsv3?=
 =?iso-8859-1?Q?JQqIrupiiE1tz+kphh3R0VEIUxbRGjiHV6W3ffMHSlsrhim51R1jHJ5NEM?=
 =?iso-8859-1?Q?ja7gTQU3rD2pwYXyv/15Nqo65ESEZJWap9EcZCVlPE0P2HlLDEldHgtRFB?=
 =?iso-8859-1?Q?NjTtWme9aEBWNkYZZOjBdyYmatw7pLjY5gE2WYbXP8zv8UOEp0abN3PQp6?=
 =?iso-8859-1?Q?T66gjCCTEUSal+tx1uX998gfvvg3pa1HY++vZ63a1QHA4WUAFIP7vMjJEq?=
 =?iso-8859-1?Q?DiqdR9lsUEbAbH8r8zd9q5aG6IM/7i7ri/6RXXdJFZJug9lRj3CspThlx/?=
 =?iso-8859-1?Q?yj96WGmTUmi0F32cseFvss8mq/7FvcXD45YLAr0ApUgN9v4yfmTspLCzKm?=
 =?iso-8859-1?Q?9kSdyDDqi1NC9Mo+6MhKsjB2yOnD6BRmNFEYbh/1UoRYRtj8jsA/jrTLAx?=
 =?iso-8859-1?Q?dNZ9XoBQdB/wAq3dyVHLX+rNbqic33HA5k5xCd2yArJK+rhLeyTLzR+kHV?=
 =?iso-8859-1?Q?fGM9cR8bInTDfrqpaqLa2zuFdMoRoeE08+m6uKnUb9pJ61z7iCpLFvWxQv?=
 =?iso-8859-1?Q?yC4DNUKsOwA343hPRYhH54rltcgqr26lkciXd7L5eNfkD6KXzJjZc4u1eL?=
 =?iso-8859-1?Q?S/i3sj6tElTPHpn1AW5G2SJVLDISj8Eimtng8d0Lw0H94xTFPkBwk/e+w7?=
 =?iso-8859-1?Q?4AVIGVRMPw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: sbwTgQy5zlIYgs31LfNbp0hAHDsdG3G51xR5VX+1tYl5MCsUswRusHOYk8K0+HwNbBsjgWud28DxUkB0pJE7ojI4TbTJBImUudCVuwLet72WVkQdjpPD5zm8MxMB+2tsj8XgTV0Prpr3nSzxf189PZtVS0LjVzKpfFfX8JyST/vNjJefn/MFSr70d3W7NCNMugKYs9rBfAyhkjHS05v395PYblDkD8YRNwhbWKBajmKh8dEJEf9ER7/lD82ki4wiGTAWm7wRQc5Rb5NqK5GnnqDf1IdejMK8rsKuxskkkGpDug1u2KBqOZla7UCXRczVXAUF7V6jcsi+eJiZi3L0wQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b07bf1b-0291-426b-4db7-08df3efc3a49
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 07:28:33.9956 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I1qg1jSNeW3rlmQbwkJB2GkO3NeeXy66aOw7L1xfCShmLv59qKQfDqt88dN7yUyqPdO9Sk57m+Ibxktq1CXV5VMgmHK9hfHB9ByR7gpqqeM=
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

The automatic hub is now off for a new machine type. Say how to get a=0A=
hub back: plug in a usb-hub, or turn auto-hub back on for the=0A=
controller.=0A=
=0A=
TODO: The text says 12.0. That is right once the compat entries move=0A=
to hw_compat_11_2.=0A=
=0A=
Suggested-by: Junjie Cao <junjie.cao@linux.dev>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 docs/system/devices/usb.rst | 17 +++++++++++++++--=0A=
 1 file changed, 15 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/docs/system/devices/usb.rst b/docs/system/devices/usb.rst=0A=
index dc694d23c2..dc73c4048e 100644=0A=
--- a/docs/system/devices/usb.rst=0A=
+++ b/docs/system/devices/usb.rst=0A=
@@ -3,8 +3,21 @@ USB emulation=0A=
 =0A=
 QEMU can emulate a PCI UHCI, OHCI, EHCI or XHCI USB controller. You can=0A=
 plug virtual USB devices or real host USB devices (only works with=0A=
-certain host operating systems). QEMU will automatically create and=0A=
-connect virtual USB hubs as necessary to connect multiple USB devices.=0A=
+certain host operating systems).=0A=
+=0A=
+A machine type older than 12.0 plugs a virtual USB hub into the last=0A=
+free port, so that more devices fit. A newer one does not, and a=0A=
+device that finds no free port fails.=0A=
+=0A=
+There are two ways to get a hub back. One is to add a hub yourself.=0A=
+Put it on the command line before the other USB devices::=0A=
+=0A=
+    -device usb-hub=0A=
+=0A=
+The other is to turn the automatic hub back on. Use the name of your=0A=
+USB controller, for example::=0A=
+=0A=
+    -global piix3-usb-uhci.auto-hub=3Don=0A=
 =0A=
 USB controllers=0A=
 ~~~~~~~~~~~~~~~=0A=
-- =0A=
2.43.0=0A=

