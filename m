Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC065CA9ECF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 02:18:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xG5bR-0006dz-6q; Sun, 11 Oct 2026 22:17:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xG5ax-0006Pk-Lr; Sun, 11 Oct 2026 22:16:57 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xG5au-0004md-MM; Sun, 11 Oct 2026 22:16:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fknsqhzOSBB8TVz3qSv8MS6V4rVnEV5Yf6Qfi7yJ0+W4nEdqqVbZ/KV0QWybQUIsNQVfi8Y75yQm0vVsDQDXIXS4KguKtG8T/1x+pCBHtZAwFRIrYGk7Tmql44MTQf4NhFkc4xffLj+5sKJVAN8W5WUbJQ9Fq/RwK6QeV+rzyJIUmJuC7I2gYBY9q21Z02lSebTJ2waamFUfZ9JnQezdNGHFhBRHBBMc1ZxbcJXnS8cAMFFBao7QjlMqS1QoRW3NSwzOgIO4gnuM9HgX90ZwXQBp03cGYPNXRUrKOpZPoKQiopj4Gs9s4/+dX/35fFEjDaEJE9EjBPbsmwaapaRreg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L31m/ON33ss2pnQ02f0/Syu/9sy8itH6y55+EtT7AMI=;
 b=qZCuUr6weRL0i8QVf3YnM0hO9/2Rd5bya3mCyk1puSnt6AKbEzq7c87q3Im8JBm3Wn5fMiTj+Vnk39KsbJGGj/iiK2VGt4eCUDnVyDctQcuqptYCvBzSwEZTe3kRolnPKIrGHkkWLdx7U4Hj480ACS6CmJjCXCmbjsLrKaUzLrvjuSVHW4InGe/5XRPkREt6/zjAIFQUugBaRGCl+MsypiLVVhY3VB4qCpZYF+Rr1W6QlNVCeMQYYCJ/9vA8tn/4m9amuwkTU+7/d35xmiTaL7JQdtgy1jbtoku8lxeAF42f01AT3eynmXfWh8MLRy5qq/HePDooVjQKU9L+OhwlLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L31m/ON33ss2pnQ02f0/Syu/9sy8itH6y55+EtT7AMI=;
 b=k3NxV2YdIPNhQO/gij+pQWV2xI16ZXCQtGx5V2DGSqXe82/1JCtBUoAztPQgk/VGNVjxs2erI8BUPM8cPzCT3ufhKNzGeINmdRha834bnZeOdZLlez83ABG2g98Mv6Ndq2qabV9/TgWN4oilY6jNveQBcCfTOWD1kGrEOE86aLwWILbnfyN+yvmLCX7zbMTM/ByGVJdRXy163EkdvhahguOyfyx+GAOQZ5JfK7JhmXski9NMBYh9b7sXimzb6Wax8EptQxs8Hsnlgil1TsFg+z/MGqstKyp52/Bt8qEpvaQvTwFITuJjespfWlrvxBsANr64Ix8VpPgwcmf7m+JrSg==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SEYPR06MB5398.apcprd06.prod.outlook.com (2603:1096:101:8f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.19; Mon, 12 Oct
 2026 02:16:40 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 02:16:40 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v3 4/8] hw/usb/redirect-server: Announce the exported device
Thread-Topic: [PATCH v3 4/8] hw/usb/redirect-server: Announce the exported
 device
Thread-Index: AQHdWe+3JfrQ8E41+UGw4T7Om/yaFA==
Date: Mon, 12 Oct 2026 02:16:40 +0000
Message-ID: <20261012021634.2006424-5-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 44115c8b-9ead-4a2d-b6ee-08df2806da29
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|6133799003|22082099003|18002099003|10067099003|3023799007|261009223027099003|5023799004|38070700021|56012099006;
x-microsoft-antispam-message-info: fWRxscvpZsNuY0rqA3UNHst5iq2Wz2lkwsW0PpuqsI1eD2NX9VkUCYM961EbKP2rC5A/4RloDyEvWCUz/dulOpBx48iqft6pgx8GrtwVnFVnL500nonPqly+J5/GrP+yw2CisJ8M5BsYb11g0rZQLU+NQjujA9GTEwuiZHfKhSefB5CkDqQspLw+G+PW9WS+bJ4GQroFzD18q5sHShCKbSe+RkmUxCmIA4FCA585oi2kU2JGTxXY3E2HKFc2r+/yEb1iq0xK61KS1y2ee/FkomoSQFxVDYxZAuZt5kaHuyA2GJ9jRjPOCXFLFkQ33+13Uv+PAVfEXml/Z13GFpQK1LsA5xTxdecww1JxIN2cw4sO+06WdNlOzefRzT+XJVDMX1tpv6DLCZJxnwckJ75WAF3mtSFFROg/GNgyoCD6ltWNPnYn10Usi7/eW72veNsKEYFKQHeQ+k6p3HyDRq2lQ/+E/HpJylC8/FLGtF9imWYzRAGGRH2/P+LLxc/MlSBGwjNMglvEUp8GYkn9YD5tCZ3VpXd7Gnfos5Cm6HaUWwsFRQbCdaO88xh6Bt/3Iv+QGdG74yFE2bIXa97VHbABkfWxej8eqAfm4dspMDzivqARprigkgKdSJPqAlxUaYjfLda6bMAEc93dN6Bdql/Ah948x8TNUkO1mj8wy1anPr/OiDZu6+5nAq98G1EfByu3Ssa3hjc8VidCPkr624WmPUl+JSA/1xZg5XV5KC098tI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(6133799003)(22082099003)(18002099003)(10067099003)(3023799007)(261009223027099003)(5023799004)(38070700021)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?D6ly+CP0Y4mmv0U+lZnTgwYB3XRzaAQOrTNWUARn+UVQ/Sd1fDqFe5Brin?=
 =?iso-8859-1?Q?mdZEn2KRALG0oWgtFQ+Kr+L+nP4HyScUWV/75g1X9zClOTdf4vNSmVVp1D?=
 =?iso-8859-1?Q?r6VDktLVcWq5lNyI6XrndcuCmHLeLFnQVU/bPUYi28ZK6kKKrk6I1mTqyB?=
 =?iso-8859-1?Q?lE0f40QqQL3Gs4eSTZOKjgkHTNJKPJqXf4O+1gIm83WO0qjhGqnUcjW4iF?=
 =?iso-8859-1?Q?hoE+UxYXlMuVf+u8PXr3k4yW8tO5y9MoeBV+2DFhhRs789MpIJrhyRGUnM?=
 =?iso-8859-1?Q?moagJk5b3agNBhRyHz+z/Y45UGIG/hUl+iqoiSDLqGWm2xnJCdaOEHvE4w?=
 =?iso-8859-1?Q?WPej0a1VB4S2+w83tQ7GMQXH+zZIZXUD90wXJK4j0Qe80Bm23o0Qetsrob?=
 =?iso-8859-1?Q?lp0PwwK05xElcj0K7iRiKlPtHh2Fv9WBAkR4Dcqz9IVbBdlJmXAuDsTTBz?=
 =?iso-8859-1?Q?Iv3ai0KGorStivVBiPpVV0dKhlvI0Gc6JEoa2I051VWVs9B4X84JhgTusz?=
 =?iso-8859-1?Q?uJqbTfJ06RsnezDWRrjZ20fTrGNvMqyXPYod4P6e1pXhTEJCbOOU5jDdG3?=
 =?iso-8859-1?Q?WaKET1wRiXcgColmF8OVK5nRl5t6BEgncgOJmZwoLAARKQlEAIYQxeC+Z5?=
 =?iso-8859-1?Q?7mftavTN4O/caYJoHEVRDLFp1reNM1WImavyZIJlQrZ1UMwhoDefJMN31K?=
 =?iso-8859-1?Q?u6yQ8qpZ2EaQCLamBKf8Lb5KamzGP/ZIvWYbLDWJx6p8YyimtXDU9kyEqg?=
 =?iso-8859-1?Q?Z8eQGOx+egW3ZnH6vMBddUut7ahToiIkM1aSgSPi48lufiwss96WffYrw6?=
 =?iso-8859-1?Q?udOZbNHk8mtz4LpniCjZKLqJKODhYofDZEs+kFETQj+K0bXBZdP91FoCVo?=
 =?iso-8859-1?Q?+fv4RfGG2ge5enL2vW0+w+8lkBdXk5rX9LNINuvHrBAFCRaEkJcmlt76xd?=
 =?iso-8859-1?Q?+hvIH9BjzC4bGJYZTg1gDofyxFzxbmOS0lEKZUB/I/dDSWhWu2nLiUjq37?=
 =?iso-8859-1?Q?OLLyTEhVeJpuyFd/W8qQeFQ2TZoZ+JiB72JSjJA1nty3vsn/Rn6yZQd/hB?=
 =?iso-8859-1?Q?nxyTJa92PnLz6N1TifCDJgAxiNBERAeRAkhHpJVoq231tEmWths3C954c7?=
 =?iso-8859-1?Q?mzV+dwvbLeM5tQNsJXxjwL5+PwGTK9EtFSvRY7LZXfhqnomwDGA0QIcY71?=
 =?iso-8859-1?Q?jSFjMYt3MucdD8pA2RzcZ55jYBtrfZPcyzkgda9yol6NBtLSdA9IIACpxs?=
 =?iso-8859-1?Q?l2ATOva3aa3DGjPiz8cndBLQzvfh4AfJkXIvmwA1EAlllQRZk89JOG0kPP?=
 =?iso-8859-1?Q?LrwEk0bBKigRj465Zdz6xGBe0SXsJBcageXNSJeMcr1lgAygBiY+StSqzz?=
 =?iso-8859-1?Q?e4flY+nDyupUP1JETFlTYSi10RYJ1ui31/Ce6dDlQQwJ10PM5TUmOiRFib?=
 =?iso-8859-1?Q?sxv3ZcXETTbMPpn/RdnD1zg1e2xjqfHjcu37Xh0UmXwHwe9A6MNVdW9DjI?=
 =?iso-8859-1?Q?m8S3jl9kIndHGF0kN6FeuJ1gXYwAyOCFeU3EGHstru3OCgxC0F4uEg/vXs?=
 =?iso-8859-1?Q?XJnweuxYEbxcyU/RgFE2+LZDbgrvtYwu/tvsLfZoatXMZLYNoigT1WOyOb?=
 =?iso-8859-1?Q?OGQSv8R9RwAGVqUzh582dTvXkTd+ywaK+x642/Ypspmzp0qRC6sU3Tnes6?=
 =?iso-8859-1?Q?C4T7s7fnakRkfMVfS4ch+FcfaCQX33LfKJlSzOo1rQWWBDj3WWsC58oa5n?=
 =?iso-8859-1?Q?BR3Cbx/eSdhbQpnXLDteJlMNZW0s12HOJtXvS9EZIEy4UuzllmmNSAwoEI?=
 =?iso-8859-1?Q?k9PPPGdKuw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dZy8F2YoJC58Gu9goO5mHODC9GcIbDrUCKpwcoStRZmkWQlB8c+DJrh1tWUkkCEccwdx3DBLVIzpNhJnU+qHjMTTycfkKRvJwsvVMR+/f/lU9KMunMmZDTXXVwlqgwGUPmuRJ6qQpAun5fFUVbYgoi+MRmfDdpekpaHQdZqYPgVBSEPttDhVE/OleCBX/vELyWxEAmSuKJnC3BjjJt3EWsSWLuCpZ1QfemTspVHPrR7Xebkw7/RYNlekHz32hZ0SatAfoA8g9M5edMwFYABW3QYXbkZcsNC7SdDY0SIu0+NajnJoVZyp2gnrxdhvHEBLv6ckuycseyEAc5PoOFoKeg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44115c8b-9ead-4a2d-b6ee-08df2806da29
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 02:16:40.4413 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qNcxJqtFPAjJnngrkEo9TGOV3bhLnaD7ri8qwy7gfLQCmkoLFTVTmpUYQv51RbmshUeO0gd5wbZ7gu/k31wg1Axcpjasg3S39PIRb/tLf5k=
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

Send device_connect when a device is attached and the host has greeted=0A=
us, device_disconnect when it goes away, and handle the bus reset the=0A=
host sends before enumerating.=0A=
=0A=
device_connect carries no identity. The peer asks the device itself with=0A=
GET_DESCRIPTOR as soon as it enumerates, so anything we put there would=0A=
be made up. The speed is real: it comes from the device on our port.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/redirect-server.c | 130 ++++++++++++++++++++++++++++++++++++++-=0A=
 hw/usb/trace-events      |   7 +++=0A=
 2 files changed, 136 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/usb/redirect-server.c b/hw/usb/redirect-server.c=0A=
index a48b821642..05ee0f3873 100644=0A=
--- a/hw/usb/redirect-server.c=0A=
+++ b/hw/usb/redirect-server.c=0A=
@@ -56,6 +56,7 @@=0A=
 #include "qemu/main-loop.h"=0A=
 #include "qemu/module.h"=0A=
 #include "migration/vmstate.h"=0A=
+#include "qemu/cutils.h"=0A=
 #include "hw/core/sysbus.h"=0A=
 #include "hw/usb/usb.h"=0A=
 #include "chardev/char-fe.h"=0A=
@@ -90,12 +91,88 @@ struct USBRedirServer {=0A=
     bool in_write;=0A=
     guint watch;=0A=
     bool host_connected;=0A=
+    bool device_announced;=0A=
 };=0A=
 =0A=
+/*=0A=
+ * The device is whatever USBDevice the user plugged into our port with=0A=
+ * "-device <device>,bus=3D<id>.0". NULL until then.=0A=
+ */=0A=
+static USBDevice *usbredir_server_device(USBRedirServer *s)=0A=
+{=0A=
+    return s->port.dev;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Device announcement=0A=
+ */=0A=
+=0A=
+static uint8_t usbredir_server_speed(USBDevice *device)=0A=
+{=0A=
+    switch (device->speed) {=0A=
+    case USB_SPEED_LOW:=0A=
+        return usb_redir_speed_low;=0A=
+    case USB_SPEED_FULL:=0A=
+        return usb_redir_speed_full;=0A=
+    default:=0A=
+        return usb_redir_speed_high;=0A=
+    }=0A=
+}=0A=
+=0A=
+static void usbredir_server_announce_device(USBRedirServer *s)=0A=
+{=0A=
+    USBDevice *device =3D usbredir_server_device(s);=0A=
+    struct usb_redir_interface_info_header iface_info =3D {=0A=
+        .interface_count =3D 0,=0A=
+    };=0A=
+    struct usb_redir_device_connect_header conn =3D {};=0A=
+=0A=
+    if (!s->host_connected || s->device_announced ||=0A=
+        !device || !device->attached) {=0A=
+        return;=0A=
+    }=0A=
+    s->device_announced =3D true;=0A=
+    conn.speed =3D usbredir_server_speed(device);=0A=
+=0A=
+    /* Put the device in DEFAULT state. The host may not reset the bus. */=
=0A=
+    device->addr =3D 0;=0A=
+    device->state =3D USB_STATE_DEFAULT;=0A=
+=0A=
+    /* Send this before device_connect. The peer needs it to accept us. */=
=0A=
+    usbredirparser_send_interface_info(s->parser, &iface_info);=0A=
+    usbredirparser_do_write(s->parser);=0A=
+=0A=
+    trace_usbredir_server_announce(conn.speed);=0A=
+    usbredirparser_send_device_connect(s->parser, &conn);=0A=
+    usbredirparser_do_write(s->parser);=0A=
+}=0A=
+=0A=
 /*=0A=
  * USB port ops=0A=
  */=0A=
 =0A=
+static void usbredir_server_port_attach(USBPort *port)=0A=
+{=0A=
+    USBRedirServer *s =3D port->opaque;=0A=
+=0A=
+    trace_usbredir_server_attach();=0A=
+    usbredir_server_announce_device(s);=0A=
+}=0A=
+=0A=
+static void usbredir_server_port_detach(USBPort *port)=0A=
+{=0A=
+    USBRedirServer *s =3D port->opaque;=0A=
+=0A=
+    trace_usbredir_server_detach(s->device_announced);=0A=
+=0A=
+    if (s->host_connected && s->parser && s->device_announced) {=0A=
+        trace_usbredir_server_disconnect();=0A=
+        usbredirparser_send_device_disconnect(s->parser);=0A=
+        usbredirparser_do_write(s->parser);=0A=
+    }=0A=
+    s->device_announced =3D false;=0A=
+}=0A=
+=0A=
 static void usbredir_server_port_child_detach(USBPort *port, USBDevice *ch=
ild)=0A=
 {=0A=
     /* We only export the device on our own port. Nothing to do. */=0A=
@@ -107,6 +184,8 @@ static void usbredir_server_port_wakeup(USBPort *port)=
=0A=
 }=0A=
 =0A=
 static USBPortOps usbredir_server_port_ops =3D {=0A=
+    .attach =3D usbredir_server_port_attach,=0A=
+    .detach =3D usbredir_server_port_detach,=0A=
     .child_detach =3D usbredir_server_port_child_detach,=0A=
     .wakeup =3D usbredir_server_port_wakeup,=0A=
 };=0A=
@@ -210,13 +289,53 @@ static int usbredir_server_write(void *priv, uint8_t =
*data, int count)=0A=
     return ret;=0A=
 }=0A=
 =0A=
-/* The remote host greets us once the socket is up. */=0A=
+/*=0A=
+ * usbredirparser message callbacks=0A=
+ */=0A=
+=0A=
 static void usbredir_server_hello(void *priv,=0A=
                                   struct usb_redir_hello_header *hello)=0A=
 {=0A=
     USBRedirServer *s =3D priv;=0A=
+    char version[sizeof(hello->version) + 1];=0A=
+=0A=
+    pstrcpy(version, sizeof(version), hello->version);=0A=
+    trace_usbredir_server_hello(version);=0A=
 =0A=
     s->host_connected =3D true;=0A=
+    usbredir_server_announce_device(s);=0A=
+}=0A=
+=0A=
+static void usbredir_server_reset(void *priv)=0A=
+{=0A=
+    USBRedirServer *s =3D priv;=0A=
+    USBDevice *device =3D usbredir_server_device(s);=0A=
+=0A=
+    trace_usbredir_server_bus_reset(device && device->attached);=0A=
+    usb_device_reset(device);=0A=
+}=0A=
+=0A=
+static void usbredir_server_filter_reject(void *priv)=0A=
+{=0A=
+    trace_usbredir_server_filter_reject();=0A=
+}=0A=
+=0A=
+static void usbredir_server_filter_filter(void *priv,=0A=
+    struct usbredirfilter_rule *rules, int rules_count)=0A=
+{=0A=
+    /* We accept any host. The callback owns the rules, so free them. */=
=0A=
+    free(rules);=0A=
+}=0A=
+=0A=
+static void usbredir_server_device_disconnect_ack(void *priv)=0A=
+{=0A=
+    /* The host saw our device_disconnect. Nothing to do. */=0A=
+}=0A=
+=0A=
+static void usbredir_server_interface_info(void *priv,=0A=
+    struct usb_redir_interface_info_header *hdr)=0A=
+{=0A=
+    /* The host should not send this to a device. Nothing to do. */=0A=
 }=0A=
 =0A=
 /*=0A=
@@ -240,6 +359,14 @@ static void usbredir_server_create_parser(USBRedirServ=
er *s)=0A=
 =0A=
     /* Callbacks for messages the remote host sends to us */=0A=
     s->parser->hello_func =3D usbredir_server_hello;=0A=
+    s->parser->reset_func =3D usbredir_server_reset;=0A=
+=0A=
+    /* The parser calls these directly, so they must not be NULL. */=0A=
+    s->parser->filter_reject_func =3D usbredir_server_filter_reject;=0A=
+    s->parser->filter_filter_func =3D usbredir_server_filter_filter;=0A=
+    s->parser->device_disconnect_ack_func =3D=0A=
+        usbredir_server_device_disconnect_ack;=0A=
+    s->parser->interface_info_func =3D usbredir_server_interface_info;=0A=
 =0A=
     /* Capabilities: 64-bit IDs, connect_device_version, ep_info sizes */=
=0A=
     usbredirparser_caps_set_cap(caps, usb_redir_cap_connect_device_version=
);=0A=
@@ -267,6 +394,7 @@ static void usbredir_server_create_parser(USBRedirServe=
r *s)=0A=
 static void usbredir_server_destroy_parser(USBRedirServer *s)=0A=
 {=0A=
     s->host_connected =3D false;=0A=
+    s->device_announced =3D false;=0A=
 =0A=
     g_clear_handle_id(&s->watch, g_source_remove);=0A=
 =0A=
diff --git a/hw/usb/trace-events b/hw/usb/trace-events=0A=
index d141661673..2cc6a244b9 100644=0A=
--- a/hw/usb/trace-events=0A=
+++ b/hw/usb/trace-events=0A=
@@ -399,3 +399,10 @@ usbredir_server_chardev_open(void) "chardev opened"=0A=
 usbredir_server_chardev_close(void) "chardev closed"=0A=
 usbredir_server_write_recursion(void) "recursive write, leaving it queued"=
=0A=
 usbredir_server_log(const char *msg) "%s"=0A=
+usbredir_server_hello(const char *version) "peer is %s"=0A=
+usbredir_server_attach(void) "device attached"=0A=
+usbredir_server_detach(bool announced) "device detached, was announced %d"=
=0A=
+usbredir_server_announce(uint8_t speed) "device_connect speed %u"=0A=
+usbredir_server_disconnect(void) "device_disconnect sent"=0A=
+usbredir_server_bus_reset(bool attached) "bus reset, attached %d"=0A=
+usbredir_server_filter_reject(void) "host rejected our device"=0A=
-- =0A=
2.53.0=0A=

