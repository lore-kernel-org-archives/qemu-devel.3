Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF5ECA9ECF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 02:17:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xG5az-0006PM-4V; Sun, 11 Oct 2026 22:16:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xG5at-0006O7-Tr; Sun, 11 Oct 2026 22:16:51 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xG5as-0004md-1T; Sun, 11 Oct 2026 22:16:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kPgxsWzBDMScrZ1KFIUDkzYC6IZSd4wvs64WHp6vGjT1Z0wXIIddiqa/nnac2xNsKysecYc2imXN6WIEUt/jZf62GDmD3i9gehCL1hJj8j0lIvaF25LUVblL9P8nv0lglPp8psZiikzLIttaewacHsI4gnxF2cRj0E0iGII+lZK3geaKS1F944r0E02WABFOmV7ZtGbgzNPvy1RRzBaORqb8n+yODHe48eGMiLDR+l45NoqfnnE+y4nggecXAO0zO9gQpva2V1YNvWg7HQpJ9p8h39HAYobCzHvl9/ZSqDJALzcDGNCJGTfMU98Eyu07xOkVhg6pZ/fqC1/Q/YcslQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=08so2F6U1KYknCKa+AXt5x9EoU/qtcbzb805arRbJxg=;
 b=ZQWg9QODhpQulKBSn+ENbUDPi7bdwwZFdoC4a89L5RZnJWJDrQASWr4GjuS7iOlQ5QezM7frq/qU1EsxqXE6s7sP+25iGnSz1cH1BLxKwHJ1Ehgp+xTtEx2w5aHMAXS+Xr10rJZ1xH3SPdNbVRQKVb8pOTp2e8xOQekzA5n16uLgfd6ffX4nFNkIwEj6dY6sVoIJIJSoCCDO6fCoBr/L9SoBal7M8S9BObp2OhJF7ckX0/dE0Aor6WjE/U9KlC+HGHiYN0NzwjEsW2P65c3A08hWHJrEN/yFuU4Q/s/N3RcH5us4HSWD3DkxnFEuxm7sLui3sYKGiBOOxAWNgmj5wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=08so2F6U1KYknCKa+AXt5x9EoU/qtcbzb805arRbJxg=;
 b=RngkhYbnpazfq4+lF/c4fzdInMvFbzSzS4MQpbmcVtRrS9s/yzc0bq3JpNlVR9ZCDsotFA/ci3+iFpLyy3xnrMIAz5nrpytBpJgAtwoaL0DssKVeRNGefP/DOUGX6/OpzTmFMTD7SpedCHhjS29+nnKAJA4Wp7G9NvkLLlU1T3RG8pM9yOgWBVhGmAJx0VPB4XNsNxNtXPCFf3RrRtjAaMORm4ar880vV+OQjAXfhXs1Ty2qneCV5P4DcBKXVKx1JgIBXX3oNqvGB3eaSbpVp/0YEHWPps9taOPjyGvocyvuvhm004NEjKQKfS7xBMS+oZRsLf+7qxYYeuyvFRyi0g==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SEYPR06MB5398.apcprd06.prod.outlook.com (2603:1096:101:8f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.19; Mon, 12 Oct
 2026 02:16:36 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 02:16:36 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v3 1/8] hw/usb/bus: Let a bus opt out of automatic hub
 insertion
Thread-Topic: [PATCH v3 1/8] hw/usb/bus: Let a bus opt out of automatic hub
 insertion
Thread-Index: AQHdWe+1b5T4oNA+yE68f74FLmdQFA==
Date: Mon, 12 Oct 2026 02:16:36 +0000
Message-ID: <20261012021634.2006424-2-jamin_lin@aspeedtech.com>
References: <20261012021634.2006424-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261012021634.2006424-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SEYPR06MB5398:EE_
x-ms-office365-filtering-correlation-id: 41ec4b49-0dd2-424d-a095-08df2806d7f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|10067099003|38070700021|56012099006;
x-microsoft-antispam-message-info: wTlamE3tdHO6giEu2a7VlOsazeLZjRiUQILZgfKwkMmtvppYYqD5k4zX2uEHAm6EuJvhqLGODS5zuW+md7UtRO/AwGbCp5gYpSEFO6de8v0995wLBumAMNCKY7nrXaEc9tcQaSMteVtpcBs0oWFC3zDw0q/KQlhEPtyvaZ0benU4PCPJOeCpuHhkKziZa8h0ek19D7DafB2pVLnG3Vdy/GFIaMG5QWtsMk9XEFiv75RdhhJQ5hjaL04A6sIQloT25m8re3QeBSZUYmv5Dqrw8MXjzjO3z9PWGEUm78Ck2fuQ0CzyZGMpHmmnBAurbj0XTUekN9DzdpcEyX5WAGaQw7Gy+C5asNDx4MWaHIEDuHPajW6cp/2vuasL4DRgCNVzXgmNSKNx3Ar/N8iZA518uqGrbWIzwTOSDLkRawaNgK7pLmCZIrqdVEEO7mah3Qky1BNl3zt9BtnwnnUzSDrgI4BF4kTw5yUFx4CUu5jb33qKFIZv6Jey2rKNTpU3joZZ3K4WunlME71mbsV3KnnCqq9dfPB7D6JFRLnD2v58lsLpAi8s7DfSOTkQBBjkdYplpaXWXLSqk8FHWhAB2VEZgHuoxA9vRidM48uh0tTaDav5vXZNnf6Pn8jP7R59EAifcepsWrolvbtjLs6/aAv8qA0/wVBtkZHFWZLESZEq/kalnyKTSbfoz2opjsY2LKEQBUxOdyqw2NtAofC3SI0zU0Gl+hMpMVxjIeHRt3nlyCI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(10067099003)(38070700021)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?YjJc9c45QERmfC/Mp2JnCNFeLS3ePXJqgfSYyjXaf9qjeHpklkzj10q8YZ?=
 =?iso-8859-1?Q?I0sPUi9Ny4pLVfkVR1Di9wJlqcBQUBAF3fiRIdEShewbv1AUUubjanAQa6?=
 =?iso-8859-1?Q?dG1nI0zLHGy0THCS0eYNzf6at/IAT7ta7j3eG0PogbYkQ+um9+i7lmb92j?=
 =?iso-8859-1?Q?BktbLrkx+Le/0FRZ7m9/1hprLjVZr5X+lXqHjc7gLnAAx+x2R6tSCiTmnm?=
 =?iso-8859-1?Q?GcvmeMoYdwPDCEL7GUqD1Ii4qfJ9xjtsGW3u4DC3PlUiZDPMSaQqlUvR5S?=
 =?iso-8859-1?Q?8w8EZe9i1zBWtPR1ZjoDdJFynmQQw2slfr/4w8xETzjDEQIV0j7wVgG5Nc?=
 =?iso-8859-1?Q?zawgvZt12IuQbYYBH3MwkeyZe1PGAEnJvm4hi9ehHD+dLAonNyqRDL3B2S?=
 =?iso-8859-1?Q?EhwecuKtZUa2waFlX+o/e+YRF8tuZqza9r41Mu4OzyeEOL8gCOlwaXQkWJ?=
 =?iso-8859-1?Q?mPyyax4GaXHbWT6dZ3XocDzIrnKeqEyUgLx1q1V+b4/RFICYllKUsk4Cre?=
 =?iso-8859-1?Q?E0fkkojplzp6HMmekJsiW4HloyqeJF+FbF6eSlwc+l37tX6XqB+xT0sieq?=
 =?iso-8859-1?Q?VbLikL1JspKv202r38xg8qeOSV3uU4KDTTlQ6K27uBF8cRg2bPiPaGpprn?=
 =?iso-8859-1?Q?SQvJbvhmb8vtYgwHpVUTeYakd6Kz+U/yjt18+9rxUmR0T5c+Q1ADrWLM72?=
 =?iso-8859-1?Q?KjP9J/ocxnbZ2t/dRBb5w6Oh5SUMXX0Nu6F/dhaz36y/Ka4YCvFg/dDQZ9?=
 =?iso-8859-1?Q?iydKlMk/WMpbpjK9ifiyV8eGi/w43ETUXGzsmss52Nm8hQbdJhKXH8qUVq?=
 =?iso-8859-1?Q?uQhv+ZdlBEDPfNajNeJZdW1TXiVK5CnvScvR3Sf0rl1V6gQ3ERn9FHuEE1?=
 =?iso-8859-1?Q?xegcS/tcMvBnXX5/PCqUIQ+zjlueFY1p8C/IiYlah1SeD71zaJkxnPRyiW?=
 =?iso-8859-1?Q?PVGzoXlf9teyhVwXPnxZCB51iEyRbADFP0a/CBsoAWhJf5BtwZ98q7S9Sr?=
 =?iso-8859-1?Q?cnFS0Yc5F3KEnhxiPkOoV9e7xmGA+UdLBtsKV92saCnn7kFMS6lThbcOb4?=
 =?iso-8859-1?Q?djZLyWliUrAvN97PviaGT95KJuz9g2KssAmqoldRjDRRlhfntv6zNWQEYT?=
 =?iso-8859-1?Q?WBev6Ebag7p3I8nRhspVF5P8CXkwLNJzEGWI7I9u3NDE02meoz6MSKUY/l?=
 =?iso-8859-1?Q?N0tbVnZqlBoSTX9OtufQgXcAZ7KX5De0SmQF827rcQ3C+g6o8o5/uFiiGQ?=
 =?iso-8859-1?Q?3FsoshqyQXvk0AUAUX+XxRM9fo5YLkz9pnrn+w6jagxMzlI/rWyN7lWLfn?=
 =?iso-8859-1?Q?XqwawUrLD49SUIdbAGvrcn/rRJqjlnJQnfeupKER3JgrX8Qvy0jVvDqtGf?=
 =?iso-8859-1?Q?4YX26AyoTIntLqmnQWZrlxTYRE6aXBU8IzT1dO77aQwUVWVCYtTY+ksFTx?=
 =?iso-8859-1?Q?reRtwyiDErKzjvfxoUS8hfqDJzzoexeYyvL7TrYd+HC3z6iOzcmfMHLA6r?=
 =?iso-8859-1?Q?uhF/cPJDC+3ynvmQB9VdKYHSHfbQeA13MdvJMiUds6aavn2rH+AHVuLueu?=
 =?iso-8859-1?Q?/SVwenkPQxxagMfVUjXUwItYmY+qpvhdaagEhPM34xl2dMHATkCa5UH4m4?=
 =?iso-8859-1?Q?4ShpXD3BWskQCm7EutSNW1bEBkWn4Ia6YERfSHlYbsRdsxzFJK7WJt+qds?=
 =?iso-8859-1?Q?NOySn7dkJGEzwvsaM+g7ZS89uJ4JJ8BakEnyuoqzdoH1KOnI9pev78rj3j?=
 =?iso-8859-1?Q?aZneaoD+ZcZJSOsluZyLjuU3SH+lmoMcxcz6cb3/ARulSnj8vGwY3FR6bj?=
 =?iso-8859-1?Q?yr76hINcZA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BtXZjVyvNLO5U0rOU8aladAXW/ajBPOs6SdDpjqIzpOOlsRKm/72wGeqGvMQgWZ31oHE/z4SAq1hm1pgqDzXbfAD44xk7So17ZJx0mXUZzPSnx2wzF2bev3eWz2WSFAVBZ60Tdihl1UzuacC53L4nA64p0l1p9OMjqZ9idErZv0milR504848gVVJyoIzx2B2hJ0IrMndNgg2o3egqCIQAPJrZ9NUj9wk5/pcUn0oATM/hkbT/olnFxOaxc52kQqkKn+Z4mzH7DM01nNlEYKikTf+lz7uUmdUyN8w49LyY+isbjjOGnz28/1wnjAduL1AUqBxskwaci19T4ftqZIqg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41ec4b49-0dd2-424d-a095-08df2806d7f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 02:16:36.8146 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rWFt8QRj6jvNUX0ORqimzXZfkIpi/GGhJWwS1/7cLU0aU0ds2yxNq4SzoCzvdItyFpkSyLKAvy5d6Dq8qcOFkzSkQqEGfF3OYcpmW34ttZk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5398
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

usb_claim_port() inserts a usb-hub when a device is plugged in and only=0A=
one port is still free, so that more devices can follow. That is what a=0A=
host controller with root ports wants.=0A=
=0A=
It is wrong for a transport that carries exactly one device. The hub=0A=
takes the last port, and the device that was being plugged in ends up=0A=
behind the hub instead of on the port the controller watches.=0A=
=0A=
Add no_auto_hub for such a bus. It keeps the ports it registered, and=0A=
-device fails with "no free ports" once they are used up.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>=0A=
---=0A=
 include/hw/usb/usb.h | 1 +=0A=
 hw/usb/bus.c         | 3 ++-=0A=
 2 files changed, 3 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/include/hw/usb/usb.h b/include/hw/usb/usb.h=0A=
index cbd4711933..ab96812adb 100644=0A=
--- a/include/hw/usb/usb.h=0A=
+++ b/include/hw/usb/usb.h=0A=
@@ -484,6 +484,7 @@ struct USBBus {=0A=
     int busnr;=0A=
     int nfree;=0A=
     int nused;=0A=
+    bool no_auto_hub;=0A=
     QTAILQ_HEAD(, USBPort) free;=0A=
     QTAILQ_HEAD(, USBPort) used;=0A=
     QTAILQ_ENTRY(USBBus) next;=0A=
diff --git a/hw/usb/bus.c b/hw/usb/bus.c=0A=
index 5cc5ffec33..8a24b1837a 100644=0A=
--- a/hw/usb/bus.c=0A=
+++ b/hw/usb/bus.c=0A=
@@ -413,7 +413,8 @@ void usb_claim_port(USBDevice *dev, Error **errp)=0A=
             return;=0A=
         }=0A=
     } else {=0A=
-        if (bus->nfree =3D=3D 1 && strcmp(object_get_typename(OBJECT(dev))=
, "usb-hub") !=3D 0) {=0A=
+        if (bus->nfree =3D=3D 1 && !bus->no_auto_hub &&=0A=
+            strcmp(object_get_typename(OBJECT(dev)), "usb-hub") !=3D 0) {=
=0A=
             /* Create a new hub and chain it on */=0A=
             hub =3D USB_DEVICE(qdev_try_new("usb-hub"));=0A=
             if (hub) {=0A=
-- =0A=
2.53.0=0A=

