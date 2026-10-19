Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEE74CCF2DB
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 09:25:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIjce-0001JT-NJ; Mon, 19 Oct 2026 05:25:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xIjc4-0000nj-UO; Mon, 19 Oct 2026 05:25:02 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xIjc2-0002px-R7; Mon, 19 Oct 2026 05:25:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gABvTYFBNFC+hGJTo51TMyUoV1fXe3BKFF870+SZuaWIymClYwz0tAf+XwteUyihc8WONGX8fbdXZVRgmyZi2JOFD2C5T35X+fg2/9DgJGP0GB7cXn6R35PtMcz9wP4VyyXTTXFoJ/EFAdkyJfFHbzB+Lt9SVXSH5y5qBC0nMfbQeIxttb0uv4TTPtrfosePA6wSJkZy12CUqpJAGEqICenb2x6kolrEfy92mLyDU5VGgvSxbXYNBGkkF3eq1S/VMoIwdDjLmeHwqpaGr8gE5SC4V6kH6Y/5pZ+KXEJAi6en+Tm/l5iOXyCUCfPK31N8lA+MdCUaUFYRfclodptaCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U23PJIr2zCrBIIO4P8/Pf2Wi0Fn8XpWOLAS+gb5zWYI=;
 b=x0hfrFDUOABRKN6MvemgClrhifJqmgAFlpVIyJk5ABftA+mAUz1lQeXxnVJyps4lHArt3tRs7j9XGRzMirxQL79XchmM4ANRIo2Y2XQtNtf2yyGMbXTJOQ0LkvPf/AFU14LhR/5keZQL/BYRMfb2GEwpkV2wq/yAHrMkFvqs6tZPSWAdJJnYtX9BJdgI2Spu3aQ0NgSNMOfvxoksRVxG+WS/IzAzWNiTP1LnQ2+cDk8wZ+JMD6aJvx1L2Tyv2duIlduB1nM2StNQwIdKr+GD6NOySPaDLekprqW+N8t8UOuIQ2RFoKO9Lf//Q7Owg9CjtoXaioO+MMKWYt2suKkRTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U23PJIr2zCrBIIO4P8/Pf2Wi0Fn8XpWOLAS+gb5zWYI=;
 b=QiUg0fkLQlKDmOd1YfXfaDvfAaQYI9aNKfQfGTmOat24QgKNH5E1gMPy+KJXwiDWDaTtjY5C9t38KLh/o2jclVST3TXnkEbttHwNNvsSs0GXuxbyPJ4Ot8YlQ5WA9AQv7Dfl4LS0qZ3kuLaQnBgyWlpe1FlIbMLiaHFIykYff+ge1JCX14JXp60wK0KPFijEO25TTsJPU5DvBtmBL/jzb6n7Er6irINoDd30SEQCt/brruB+tWWQsHVo3q/D7nYiqkzVP623QkCNB2tiXIWSLxKPoQLucjqbqJa/Yw6eyx64nZeO3evPCR02G90P1WgRh4QYX5GD2Byq8A1up/C/0Q==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by KUYPR06MB8674.apcprd06.prod.outlook.com (2603:1096:d10:8c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 09:24:51 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 09:24:50 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "junjie.cao@linux.dev" <junjie.cao@linux.dev>, "junjie.cao@intel.com"
 <junjie.cao@intel.com>, "marcandre.lureau@redhat.com"
 <marcandre.lureau@redhat.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Kane Chen
 <kane_chen@aspeedtech.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v6 1/8] hw/usb/bus: Let a bus opt out of automatic hub
 insertion
Thread-Topic: [PATCH v6 1/8] hw/usb/bus: Let a bus opt out of automatic hub
 insertion
Thread-Index: AQHdX6uxp6OpQ9yqq0CEeDiwsS34zQ==
Date: Mon, 19 Oct 2026 09:24:50 +0000
Message-ID: <20261019092448.278079-2-jamin_lin@aspeedtech.com>
References: <20261019092448.278079-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261019092448.278079-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|KUYPR06MB8674:EE_
x-ms-office365-filtering-correlation-id: bd47be02-c069-4ffb-ed78-08df2dc2d38e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|22082099003|18002099003|38070700021|10067099003|56012099006;
x-microsoft-antispam-message-info: +yKmiVzMIWf3BGrb9F5HuJIKI3jHCBElwvlqVuDLp9SkmMmA1UcToz/LnA2TmwTfy4tGqXke1XFBpA+1fch7rsdvG2S3D7rciWhBDrjZ41DFg0e98qBwp9z3D5fNzjdJBpWktIP3+qcO3Bx/9tLGr2G8QzNkzXb2F5p3I1e4ZDXum0I4Y7066m3PsCZwQe7+fexv6JDiLLCW5zSnBJxCdml/iLvjMTUYDM4TLye4U5rpuQ0niYqi0kKH6Vqe5k5f4jyWUC08jfEFD7+7ucJ7Kks9jc0MCiBmQyJVDW0t7vnkQdPVUPBP9Nr5QDWOV0eSFRDZeGI6LdRRx/ryJ3zUkQGl3iBODl7PoGc6hTEb1gIWYse1ndLUocrCM8PkAHJoyNrDZm75m+wRhIz25gIjG1bNhSMVHnwG/0+s06B8vIwYnMi+7HY0DJRtoQ56JM1LJ/vN/2VSvO39axVl7MnTyqAJuqGMgz7cVafk6yCtGWFvLuMLB3lRslaSNPfCLbWtO+VZJqa5Y4y9zNUbLjeArqlth2uAZm2cYBK7CfEK6dXGiTe9b+3YKtjSCmvN5fJmkuCxoWXGYdjGrGAHNYO/kOXcyVBJgSepMrHvIW62/j+COWNwMbFlIQS67PgTvqkVj0/IwteC6jEr8t3yyirtz8xqA1b6Y/aq7G2xIqIqMKLul9yaKPNoXlxT796oY64Vzty5S2qkn0xypDqXOCtLsO2A1se56agd8sStSCj45Ok=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(22082099003)(18002099003)(38070700021)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ODWRkFApBW/CSZTGYZ/ttSeOsZwDrza+S0TxV561tfA14aN/W+KjLfr6RZ?=
 =?iso-8859-1?Q?IOCVF0ZGEQ2nbB/gzM/fD6LwPK7GQIqiBiaTPOw3qzIri1GL0eRXyJS3F0?=
 =?iso-8859-1?Q?IMKiDlIumeF4Es0A6slLQs4PP8wM3qVsyNEmwJm6uYzILnngLNv6gVjB4M?=
 =?iso-8859-1?Q?DDKuZ9BSOj7vZuRBl/a6/XceKSIfQ5LxbfPq0RYKs1d4jAdIC1pTh6NAqQ?=
 =?iso-8859-1?Q?+rXGZZXsSTNR9wProqkTbDxzM3vP/pPrN5ueahTAjARHzChzvoyTdl02Kn?=
 =?iso-8859-1?Q?yaq+DNgVtb4AUWc7OtsQUHwffctp2BUs5csKtu73FsSzg2tLeMgXFZf33Z?=
 =?iso-8859-1?Q?1IxIctmMgtUWQb3O9SZmCRyl9LZJd3+WCO9xwlPxdOXO3ikNJI4ts86Srv?=
 =?iso-8859-1?Q?0AWPMjWvGfq4QvRFGm5dN7/sp7LW8Vxh9PmyxaV9kfElrxyLIG5PYqC/Ep?=
 =?iso-8859-1?Q?imZza2S9wzG4amYK6/+Rgr8u50TLyFtqJ+mmtIIfP0U6Fx1GDUcqh4IrO7?=
 =?iso-8859-1?Q?r5mzA5QB9DZWrYFBe5aAE7jE7qfYS24sMa8/JdSnZfXFt70aBMz+q+cBCO?=
 =?iso-8859-1?Q?e52w517TF37RFnymN8HZjI/L2LVY6k96gCwnAM3NJNWkSpuGvanjRZN9lJ?=
 =?iso-8859-1?Q?LeVtjF0tbXxO+fbl61C6GKJoWMLSuazJmsLzYNDsPfo81nMlTpjOkqUcrY?=
 =?iso-8859-1?Q?DGsbgHX8D/Vpbb+I0vgPk82HZqnksYz7Rk0UEEV/wbk88wD0Dj5r5YzT6K?=
 =?iso-8859-1?Q?HCWHEl4jYR9o2CgT8NqLdlaNopmKh7zXEg5L7RgWhCXprV1bHoN4LfWX4x?=
 =?iso-8859-1?Q?Cc0Rb4eOinPu4/Gw+ndHwE5IF7HIQMyXQUx5L3DDeBG2Sp2Ieo8RLKZPve?=
 =?iso-8859-1?Q?mffNNd+g9qD1CWBxzuhMg9rLiJez4P6VzBvgRj4UlDv7JqSTOJc/SIvCQi?=
 =?iso-8859-1?Q?pqHjjv8rB2wLNJg58sYyppp/3juSbfHfuKnTt2tYfvlUWYlEI8jw+X7XrO?=
 =?iso-8859-1?Q?3zVeXe/zF4mMIVrpYRAgXq8IAL3yeA1d5Z8MMvs073i8i5+esqA9wMiD7W?=
 =?iso-8859-1?Q?qf8jTsHTLLoIjx2K2Go6nP8AJpqbnA2EuOJLAqWLQgaNUU6Wh5CD9F1YRX?=
 =?iso-8859-1?Q?SawWYb5QWiERGXufK8ILH3bfP8TGicXaCleee3MbD5c/fHkdGDHnp7N2RS?=
 =?iso-8859-1?Q?X/XQQ1NITFLnqA/g7ZfsZxCsPfv6H9LrmXA6kDnjDFEWVbxybdrAjYfjYX?=
 =?iso-8859-1?Q?8VLBeT4xFHsJLRugkXyvwgKQxA5B0EXoVebk6tZxwk+Cemkn/HGnDfxnRD?=
 =?iso-8859-1?Q?fwpkg8iXcPBeGV/XZiqxAn6iQjbxU4XmnMiYO4pcNGFVR60CxNajEo9A/1?=
 =?iso-8859-1?Q?Dz0TGF7x22ewO/N52rhfze+929uJUeKiD/yZuOY/bzdmbYqdblWaKS7/id?=
 =?iso-8859-1?Q?+ocWXL+24ri9bmR/rJeQ0QRMF9vlk4LQzUPr3/QAIA7m4pPr+2KBLF0uy9?=
 =?iso-8859-1?Q?UdQLDMTqXDCgeU5RDnAPVjDNo6KQpREeLEec3bQztR2nW1QulwT9U1NTI9?=
 =?iso-8859-1?Q?ik4Idbu+ACAxjau2i5bj+q5jqGDUYY1eBbgTrOb5hvjhpiQdH/hax4ROkv?=
 =?iso-8859-1?Q?ZDixvbVQQ3E9eIvwIRfx+zxvz1kB+Y1Db/zRwCsupE863fBgILZfAsMc57?=
 =?iso-8859-1?Q?WyVKUhW1I7p2e3UEnkKAh4uMa2HvQTrJA+AvUbyzM88s9uws+BB3Z1sS+W?=
 =?iso-8859-1?Q?RAL+YXHoTUl8mN90NPVjDlO31vF1ZGP6qpiuAfpAXtEVUQbLl6D03vQ3b1?=
 =?iso-8859-1?Q?+QfkvH83fA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd47be02-c069-4ffb-ed78-08df2dc2d38e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 09:24:50.5945 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: imuJUXOD8BFFv0dw5R5IRAg/PXKxWJcMrr2tIu3GmioeGEbvg60R0UDmmr4T9HmUqaEHwC4qS/+50UvGp0BRnwuc5aYyKvT1OGWDu3GTbeM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR06MB8674
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
2.43.0=0A=

