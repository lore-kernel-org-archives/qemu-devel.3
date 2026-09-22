Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01EF2C982F1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 09:03:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8wOF-0007Tf-05; Tue, 22 Sep 2026 05:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x8wOC-0007Sm-Md; Tue, 22 Sep 2026 05:02:12 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x8wOA-0002Bc-UM; Tue, 22 Sep 2026 05:02:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vR3wAjDky8lyxjjD6/G0Wz9covtQSE8LRBm1Ci1Uk+iYKcA2MDEfTHt12dfKN+g6mou8zaGoVjjFz1tkUc5sVQyB5VRx19ZTH5LZ0ysNPsuhrQy4flrqZdFhTXH/jJIoPvdHnEjaTg/TItGcpjMYRvrv2P5rhwVh1dzKGY59j3uvtmRrgUlo4u8+CoOGeV3AF4c1BcO8r22kOFzoIKbNezvKkJ/hpsA4d0/Mps59XLUKAJsn69lwNFY2g0gq6PwS0VN2OoOF/UsInkNIqH9EWh8dy0aZ0Fu5eJ6vol8NKno4l74u9onR1z3Jxz40ctU0uEz2bk8fsoSIcsvTbNydWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQ307OHFOzN2qI+AqHJoQyNgJxibnghKMYIAWEylz80=;
 b=BDYeaVe1OOC4neAazYqMFEeepsvORysDlra7P1dQqYKpwnFHZsUQz1SxCma0ZTnAlrn23pWABVoBECnPTStg5DHfisy6T9WNybF7rPzaec0vrksx6U87YnUCw23UkzuMsH+28yh46j1q5yV9x0ZmS1mWP2+t6m72X9zuYYTBuBTpXDiDPS3gN2tbuXuCN/rfcdxgDYrHLR1h9dV63FxcGdzyIdwnfijcb8Vo0FW1xOwBivDFwCJZpjIYIcXJ9UQe/PQHJMZlh2ZCdMuU+fMZ8PCW/noagdB6vhP0afzQVbtoLifGrq/FgFEUkykW1iN5iYxJ8/gJ3MFnFttLsqUMWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQ307OHFOzN2qI+AqHJoQyNgJxibnghKMYIAWEylz80=;
 b=PZY0jP1tLiRagjFZCVInC7xzbc88NRp4AqbLoIkTUaJFJj4/WTuFOYWcMvY4jtHnbGqdhgAqOLG62pKLkFy8GKv27DAskMv8/hfehz3etc8FATWlpDS0zxKlD8s10M5n4EdRG43ard+OCwrwFRDnMsfXt7JORr7bOUD4NQU8BZ4NBVIFURwuINc94U5LtCpXe1DT3PXZX6w4ifbTFsUwyM8FxmblVFSnBlLdj3s1wmOqnCAvSUGLeR/zMcxk4/nn/rFzjfCIXnRSJUysOYS0Q+9I7DMngvQ1cJicGwXUeRCmE2Mo+Gox7vCX2zsKosK/olUqKv0Vy34wPo4U2oMiDA==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SI2PR06MB5090.apcprd06.prod.outlook.com (2603:1096:4:1a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Tue, 22 Sep
 2026 09:01:59 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 09:01:57 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 01/19] hw/usb/bus: Let a bus opt out of automatic hub
 insertion
Thread-Topic: [PATCH v1 01/19] hw/usb/bus: Let a bus opt out of automatic hub
 insertion
Thread-Index: AQHdSnEFQ4FVALEpsUClDcIg7oFjqg==
Date: Tue, 22 Sep 2026 09:01:56 +0000
Message-ID: <20260922090154.1792077-2-jamin_lin@aspeedtech.com>
References: <20260922090154.1792077-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260922090154.1792077-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SI2PR06MB5090:EE_
x-ms-office365-filtering-correlation-id: 545696db-5d85-4a86-ac85-08df188827ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|38070700021|56012099006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: LTjrUeSxKvRbKsmxMkk06liV99UWRY7Fyki1oe6MTQIqSaniKSXuSaL2pO0eVATzEmGsOsoixS+34IfBwWMMnHNR051aZnFmeU5Y/32RfIwKSUUjV1yxpOWF1vn/irlOVkKavkt50ErV6pNUkK4lUd7i46aMMEImNjMhxm2KA3BlysuVRpyJ8QpnQwyWUlFfDlcgXFeQr3WVZ3GVaRppWsrlxl3H9KEt8+bSbOip88mU3Nc0Korgt47+2KnW3yvFCAPK87EaapjfWeZHwvPlV3+RKEZ4CphXoCus5QeLxLxtO1h2mX7kYm4dLRt6JUlQvR1wA/Q9tsGRWSI4yXEmA2mgNM6bippPp/ZcbEU5kOObRoEwaPec9tB1bq8A44GgwEE+fVzhuDMUI4gN3iCLE+6g/NBJ7rpHPDTBSeJmG9JcUI4ghN8+4/ml94hU/YsXvayMc/KwfQxvPZA/Knyqnw+sKw1VHoDjC3woUM+2iM7uH+IM57JIiXj/ZRFGJ/AK+iWuRlp24//afutqrSCpenhat7kwtjLuHevn9W8HYLrxZrd2MhXv1nMgoMohjVBax/Dj6wvFvUS+aGyeLHAf8GYdvvfjE3GpJpMdx/4hFQCqwQYAyA8IOyGnmqXV7IKm8l6KeCowe7EX6nRsSbGcXTLF7ViQshHlz/LTmt7BGMRgVz4mo4cIcRTL2trjsU0mNAujlv0VrtGRhXQe/XXfjNiwImbZ/+g7XolegTIMrcI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(38070700021)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?kGrma+BgWKWLTyNLm3cp6GFzlGhwr3idi1Dt1C23CDYTKytW30zsF/bQ1V?=
 =?iso-8859-1?Q?Yu/3xHX4jenK5DVMLcz7Z0HYXrUYOZFgL2kaIxPc6Z/GouC3h4NwMh2rWS?=
 =?iso-8859-1?Q?+uo75O8WUomP7jL9+PzVeXwI6CB/73FGWE51ZCB/Mmukg6IvfDM8ZW6vWt?=
 =?iso-8859-1?Q?dgcsEG56h/Ek9hlK6jaV+twKtYCtdnE7tUK2pH73xHmbNOEcYHz8Y4G9Zj?=
 =?iso-8859-1?Q?vNpGXwGKRKslaDNoPTCss3QraiIxiCT6GAK4FLbK9JHwM6/lpxlvXDkNUe?=
 =?iso-8859-1?Q?Vvu5YBM/4nGCcL06+cpzlLGfSVCTprlUT4Yzj0dPlC0lTpQpXpRw93P1ZY?=
 =?iso-8859-1?Q?7PkLJUEApb79VWj1VrNLqHJaifK4t0BpBCjb4nMArLHyE92I5K7vLNesYX?=
 =?iso-8859-1?Q?CnakJ/1fX+uaBm9YG/zPn5YrhVBsluCW0Il4D7hUHEdTVSmUdVTSC6oUQr?=
 =?iso-8859-1?Q?ektplekPzOz+lC6YdSS7cuVdjvvJ+Sn7NI3tQz6EIYMy/cMQdlLR0eSv40?=
 =?iso-8859-1?Q?2p0QEvNkrDCZbamzA3DOkG+3+x9n5G40qxOhsZzG0J+BeL5XCJz8FI3ieW?=
 =?iso-8859-1?Q?Tnx0li6SpaYm8mfrWojjTu3LYriCl+7e1858Y27EzuxaZ6Pzl9cb/4G6go?=
 =?iso-8859-1?Q?1/UrkAwAgaftIjOZDcvsE6VDAtwjE1WCDIV5IB1tTtMJ1Ig6P7601lIAPp?=
 =?iso-8859-1?Q?awXEUj7UkwJGC7RHqy4u11evPOUvC4jhZbvn2/ShH6e+2kYmG4FkW4FbHk?=
 =?iso-8859-1?Q?/zQqXNu5ZNa7fRcZcFGVnphP2zx8T6VZcQgTsVFOuN4gRHaaM2TAlwUp53?=
 =?iso-8859-1?Q?+ULZwqkqdG3ytCImwJ2CTUg0SmjF0A3nGM2pTt6Tl9QPL6i8CWIi+yNEN6?=
 =?iso-8859-1?Q?6cm7m8+A0gqpb3zhidJjJ7KiubZWuU2cEUA/reIo/lXY9jfKAiFWGNMjSZ?=
 =?iso-8859-1?Q?Hm6JAMuhA410ecb9NZA5Xoq7kKaGbVfT9xxD1vzeKQ/yNGUbmpE4dsaS6U?=
 =?iso-8859-1?Q?xjoSWs31Dk8hUq2vNNJHExiqLZVEq97KBPf0sxN+qet+yJHU+s814h3hUo?=
 =?iso-8859-1?Q?QnLQTRFvxf5BhGiD2MSRmUCVceZw8A/bNHbDkqRbknSpCLsXpCxd7fSQH0?=
 =?iso-8859-1?Q?2ANkxwfCyoT3kJBnSu0XeQbdGHYRXwKNZbaAFoh1ijFdcKghwAwLGRdheQ?=
 =?iso-8859-1?Q?qQK4op6RkD371KwuwmeIAknsJ9lTefwnuwbLPmOpRYIo9FMf7TkLQwNHIv?=
 =?iso-8859-1?Q?WOmvlBg1E0c8RAkDOIihVh6zaZ9VkntxgbTAEr80neponHlniBIfLd0VHz?=
 =?iso-8859-1?Q?gDStnzWI/n+B0SzlvC12ju1i2a0iZ0k73hKFYtbxJZDl7e5ldRds6BXhl7?=
 =?iso-8859-1?Q?5zDjAxTQqyi+AFLGLwnv2bUn1gbTKk4dMYQ5iyD51VYlz4aG4qOTrkpDaR?=
 =?iso-8859-1?Q?uUmWqDDPBki3uFPv80f0jR29scf1Gny70aviN4fKvIymUZRcco8nNXDoie?=
 =?iso-8859-1?Q?f0u8P6mUxruMh8kmflRtvqoGnkQRJs9/HbNhV8AlfVGCMrLSbxOOHYGM4h?=
 =?iso-8859-1?Q?W858IxvvESzjIeIqtIXINVyu8uncb6yxHzObLPcpRxNPsVnJA5MXAmKhDN?=
 =?iso-8859-1?Q?Av47zovSrg6u+zZUi8rmuXvbKZnqIDiYft3CF1mnYCa3T9Le36uie7od5s?=
 =?iso-8859-1?Q?WnXnXRl9IMvIdvNmAQZ3XykSccfPqzqp6Cut+zv0bgYvwe5BqJl0rAAE/b?=
 =?iso-8859-1?Q?b3oQSIPauNgVy1rT0zVM4HGeQPX82WILaUT9TTQWqeKdf2VK4+o4Y0Kmxw?=
 =?iso-8859-1?Q?g8qhWrh2KA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PFgZtEk0u1QzJEkjw8X2TLPwCYG5r2RRuEaOtjlb/cMQzh4DO3bhvybuhbZ17bItfZkuWFyRyrnGi5rwDX76xLciFMWacGcP9bbVF9+HHUUg4g+tLB5wh7VkyiDMT5JoZ8HKY62mCSQ8YVAAYn7/oMDMuoeGqy06aifnRlPJd/wQcnF0lBgQqWTzl1gPmUbWurtKceU/1crNmPr/nZE+reG/tpALdu1n7LcM4PCjXSiL0KkTmv6qW+FGwP/kErvY8h/c4phWpBrZOI/P79uekrKt5FjWBZSSKloAjYAEOlZQ4EQrtqX+WotzLKnwZAwIA+SymiNOwCP7J0pfwuJ3AA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 545696db-5d85-4a86-ac85-08df188827ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 09:01:56.9940 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Vu7fQCX9UIRDim/qa86xwZds1Xqp6I63XFrnL8/l4qlnPTh3hvdL/OMdvuQ72REG/BQNlgh90290SVgwU/mWpf6MTG/pqd1aAQWw8AruyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5090
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

