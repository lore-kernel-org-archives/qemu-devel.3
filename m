Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBBD8CC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 07:52:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGtkt-0005PM-5A; Wed, 14 Oct 2026 03:50:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xGtkr-0005Nj-E9; Wed, 14 Oct 2026 03:50:29 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xGtkp-0006yR-64; Wed, 14 Oct 2026 03:50:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m8RtU+tSmBAcNyi/wfDVEqZxiAEFiLGZmXl8RF2PCHlbg9RvAdJew1/+WBQKjed20cQZ9fEMW2DWkBFio/v2Ui1zs2s1F63PIrIJ27/IpQLGWigqw43MkyW9EVoJ+jLwbVCEJxDVjl+WGTOG6hbmyV2TE1uMiH4QZ8vWxlwxW/Sh8v1ESjz/7sSQ19DzOZm3uLc5Muu/PYdbWyT/7r/AlPg7FJNZmO+7UeEFSbMVanX6pFDVYOSkI3Xf+uNSQZmI3WvHpCGAbXTjJw7iOv1Z6+GYSQd4s4S8OjMMzmw+ogO26RzBJHdM0LsjUQ+Veb4D5qe6WS9gvkiWHRiTWiZ1YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzJkIHHAongGi5wKoqAHGBrOereIQjvb5ARw/TgaKqM=;
 b=vDRhaflp+FYmfSl2pz55QQ50avmhdAl6536kaI+BCTGPYX/J9eFpFVThwfvyxS/06PKW8xaJ+L9ciKpjsjyzJLzMn5RbWJAh9RzaOYt/8MlfF2yvHcuNjNRq3PAotkjeYLDuzIyYbhVN51Cka8MKrDJn13rbTbnMDja5ohkLgVGhutwXydIoE5ffPn1Y9kJadHaSkWZfo2CxlplCNa5HX4kL0pq4BHyK3t8vZtoKT8No+twrAEfsnj+/kCc2NhXKBeIZGCeS1cCyZ3Aer9bunk5F8dySrrUZjIACwFfwrjH9pGfLfZ+yU4MKVT96KxI5huYQpH+ZgAMk5TFFQFrtPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzJkIHHAongGi5wKoqAHGBrOereIQjvb5ARw/TgaKqM=;
 b=WD8Ot89bjsRTUgxmSZ9t1KXKc7pt4Q+TuHceoF3honERu+I3EHjaBnhytn2NYM+eDlkpJ/ygIzFlw9DrD5e6BPk7fAwuV+3qdYEvm3z4TAr1skrOyDCG/Y4R2Q9ROIgjzmlRuYkjQovCtR8joNSdqtCbBdS/cWxa28ZoWgv2R0pm2Jm7RhOaYrm3jA44ihCTRix29S/tHZxZyRUsBLap8ev/2iGALJzVK6mD1k1FdASW8BwsDyRWnLYitNE229wWexOYE39i94mvO8vQ+tjABcwsfoonwmtWA91Aq9DjHaychDUMV0u//byeucJ1iuup3pHvHd/OShPy5kpntCtrag==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SEYPR06MB6864.apcprd06.prod.outlook.com (2603:1096:101:1b4::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 07:50:16 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 07:50:16 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v4 3/8] hw/usb/redirect-server: Connect usbredirparser to a
 chardev
Thread-Topic: [PATCH v4 3/8] hw/usb/redirect-server: Connect usbredirparser to
 a chardev
Thread-Index: AQHdW7CmxgO1pOR0cEGSkGTcUoNGKQ==
Date: Wed, 14 Oct 2026 07:50:15 +0000
Message-ID: <20261014075011.2708115-4-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: f1d5f979-0725-4f6b-bbbd-08df29c7c92a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|6133799003|10067099003|22082099003|18002099003|3023799007|921020|38070700021|5023799004|261009223027099003|56012099006;
x-microsoft-antispam-message-info: guF8XGbEAeIleoNi/dxAXmcCksa/A8KAq6P8RVcgYl2hRB17jjoNR0x7+2NCYjSTCPLWhnbFmxaZv47xyUH3ss74AoJmExot4WtttjCwYKh26Xa0+gY32wLINVAe52x9b1EkBSas8POrBvuwYCzv+XyH2HzNcIvJ9W0Pkh3hGIF48iJkYaGQUO+HtNZqyauwOoqtiNZJtQQkM6yx/LpMad+WmQjb79Y4XMsnHu4Lx2v/RKDZpx4+CWicFpKmjnSwTzdnBumJ1JypxEEjevuUnliR+eq/nN08BXH7vqeyC32/1xHNMMmEgtATtQiJf24Ov3C/InO7EvUo+MIn0C5u3AR0bsVxCcc+/75bdpDdlNyJGTNIMK2t6lUQeuWHWUmtjDdOXuleog0KbiEap0lIkTkbx4xwWqafR4IdioEnqIutBvZuvhDFLFdFpIVxMwiwgG7s9MiQF+0YNFY/T8HQPPwpQpTacFNLbPSsQkWA6sEVg6Vnsf3TuOqd2QU9ah9WtSDcsPMaec3qOM99s1lbpWWrNjDQzE0xOl/eECqClRXC6Uq8wAMF1CLMJqrSt/8BrOsDMoJ0f76gNChOnlnorKS9gznC1UIrC36ZC9OWET9RudeU48R/s8SxpiX0jhCDzOmT+0G9LUR3BHeeK+LlPsXos6i8PQ9wP8lIiUJJpv3yDJP2h8PeuioKHE4nX50Kl0kRukgrRFevN3C2oLRQnPHWIqe5sYdErRFLaDgBQ0yphBouDSBSC0TQnwdJIMWh
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(10067099003)(22082099003)(18002099003)(3023799007)(921020)(38070700021)(5023799004)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?TqqcivBymtTaihwCAiFVawxw8sche1OKHh1spptxNaiSQU1v5ENdwXKxro?=
 =?iso-8859-1?Q?i0lD4cQtbSyUxtlELf5myxDTOmo4aVc2K9ML/jUk00KuY2nNOZx6gx3jXk?=
 =?iso-8859-1?Q?r+AFr/hbMhlJVkUw0eBSWNPu9s8+EeqspYvueSO0FQkqrmyHOAlOfiQchI?=
 =?iso-8859-1?Q?zpeZNsZYND9QjCoRGpVS+kJoC3NRsxC9Lopsuea0J9sV3NSRccFxvPrXGo?=
 =?iso-8859-1?Q?pDxQAzhA/98x0HxPJYSY8HUkjKuE74TkkYLSC5b3XEJNBoHZd7OtSRKzxQ?=
 =?iso-8859-1?Q?AzBCb7JERZj/DOLuRbV7R3aKK0SBifuc5Yig/5rNcUBXJqGnRjshJaGFYf?=
 =?iso-8859-1?Q?cUMBtm7UWu+RRgboLnKi+sGBm+COL08hdQs4/5gHo7ILbuVx4CvELZIMyY?=
 =?iso-8859-1?Q?RCHO+ryWuVg6gAcLBOaeAj3Z2oXaD2Ie7i/iDAunvjtbqyEVdBuXaGS2a/?=
 =?iso-8859-1?Q?UmmbL08/Ntg70HXIsqtxDwUszEB0h9GCoatsRNkmsqKScUJZ/vLp10467L?=
 =?iso-8859-1?Q?eV6Kt+G9BCZUC5Cm7kzbYWT7LmsF5nn6GZdYUBbd0hp1yYidT/LTB90gnX?=
 =?iso-8859-1?Q?zp7OsT1ImF578EUOBcyJip+mYVT1R5yYMF4UsFQqBwDk9LbUyOhdQzv1mn?=
 =?iso-8859-1?Q?B/lYUJdsBxm6GTLFVuzO2C8Qdf+N61MkgvBirFs7rLueiJwENv5Tb8+YgO?=
 =?iso-8859-1?Q?RVtAVzRdfJjQBwm2jtz295V7PB7nBUKIq2h5C/BZ/S9wLRD8QW21/+I7Sf?=
 =?iso-8859-1?Q?l4++Mw8uUvG7kZU/+HwsFx3Eyw4rU0N4Qa5jRgvfxm9UZyRv1b8msuL28M?=
 =?iso-8859-1?Q?TxgAL1uLeBl5c4oHCVt6R5qPfrW8JtgEPutVNlT8Kc291iPuRBO9UGsNHi?=
 =?iso-8859-1?Q?RvrFH6Ro4OpiJ6ld/tKb0cBFch+uFxx76nxDcZAzi3dL8Noc8hW9IRD/WB?=
 =?iso-8859-1?Q?M8tKu8tlF3GXgqoYiIz4zFBKg+z3qmwQoJhWehuk3xCxQZgshPILT3VZUZ?=
 =?iso-8859-1?Q?YRGbuqxdTt5wxFMwXiS+GIOa1vaB5gKiz/1ZyCfDUhPq8YLGRH4Qi9VqbR?=
 =?iso-8859-1?Q?UGS8spjimHUXIvbVKHutPUdkaIHqzQC/PCPZvSbP+BlJchQKaAjxgv2ZbT?=
 =?iso-8859-1?Q?rahiMbAPf64J46olXNwv4de41fJdM1gvHv5ridKTayQ0wBjY+oyneUyQ8u?=
 =?iso-8859-1?Q?e4dsn+GwjTfCnNIkShmOSTI0+Ym1cDFEnifXSolZvakYgMyfQbB18/2H4o?=
 =?iso-8859-1?Q?RHpACk5goiG9fqyhwcMqEnmuvpe2A/rfovPsyHUakSpIrTlL2nQHixcEq2?=
 =?iso-8859-1?Q?104VjXw+rY7c8KuRsZrdmz+uZ3glr5ZNG4uLbwQBQYBPvXhCfkyp9jTG+i?=
 =?iso-8859-1?Q?AwoJV1dmjI953Vrtf0q/CQNZtxWtC5KFjdE7bVI29g9Ia5VGIuB4HquZ50?=
 =?iso-8859-1?Q?RFD9rVtpdBisZkD45CU+ZF+sye0RfTlDthdfW/Wc5LL+yXRCZuP2gym367?=
 =?iso-8859-1?Q?gvZO5+tc7JkJtX0ddtgCskpmspuey6tcm8uNjghDECjARWWHWExeT3o3Ky?=
 =?iso-8859-1?Q?wJ6g0Jwny1GkiqAXfZWsaQIrZJaiMtfsA1VUxk0V5bdFRmuujcbagZLyBg?=
 =?iso-8859-1?Q?SnvxC/NjAcvmsSasx8dGnHuRCsxXN2nN6RUyR/4qYUW4aUsH7tD6y4HzSE?=
 =?iso-8859-1?Q?v6BVniLqBhg8VIUUPKJohQ6vvKZyvCol7l7X9ag11yoYM9mg6jEq31vrpS?=
 =?iso-8859-1?Q?op7EBbcrywTIGb1wtWn/rHdNjyqcXpLzS83POuEWYePETz9ROclAcu0ZYJ?=
 =?iso-8859-1?Q?W8gXADTL2Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: CNhADG0aSkgMkQ3j5iXDbX3jrWhttfDLWIoGDhMUOxSO7wLqkPuy+X/kd82C8tmgzJTJstlKi4rAS67e5FSP1IVGD5WXO1YqIcJtTv7QNFRS6WqpVvBVBfdoQ5+epv1O9BrGyB0Gpg9F0TYj+KpcqAGd3tlBODrEjEUYyLE/Xh4GnvPi8uIGrKgXgwZLDyZ5Xh7qTLErrPslPnuhDyWplUqQM/yb+pd0dXflgpmwQXjJa9vosc8TeCOIsDJqh4fkTl1sPVM+HUOmNITRKXnGy119692M7oCbdkbgW5QDesCjhCpjuA2p0K6hVCAQ1XWdI5rdywGs0Sc2egQoCpU8QA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d5f979-0725-4f6b-bbbd-08df29c7c92a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2026 07:50:15.9996 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GaGSurOVSMPGdteKxlzt6n7YG4rSk6v3S/OvQNXiawygXeeh4aCw+DiudNpNV1p1taymUTVkOjsIW+YXZsdCue7GQ1Lj3TTEi0p6qAvFe2Y=
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
---=0A=
 hw/usb/redirect-server.c | 284 +++++++++++++++++++++++++++++++++++++++=0A=
 hw/usb/trace-events      |   6 +=0A=
 2 files changed, 290 insertions(+)=0A=
=0A=
diff --git a/hw/usb/redirect-server.c b/hw/usb/redirect-server.c=0A=
index bc883add0e..a48b821642 100644=0A=
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
@@ -94,6 +118,232 @@ static USBPortOps usbredir_server_port_ops =3D {=0A=
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
+     *   do_write() -> this -> qemu_chr_fe_write() -> chardev feeds us=0A=
+     *   -> do_read() -> a callback -> do_write() again=0A=
+     *=0A=
+     * The second do_write() would walk the same buffer queue as the=0A=
+     * first. Returning 0 means "sent nothing", so the buffer stays for=0A=
+     * the outer one to send.=0A=
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
+    /* do_read() ran our callbacks; flush whatever replies they queued */=
=0A=
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
+        break;=0A=
+    }=0A=
+}=0A=
+=0A=
 /*=0A=
  * Device registration=0A=
  */=0A=
@@ -102,14 +352,46 @@ static void usbredir_server_realize(DeviceState *dev,=
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
     s->bus.no_auto_hub =3D true;=0A=
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
@@ -125,8 +407,10 @@ static void usbredir_server_class_init(ObjectClass *kl=
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

