Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B682606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 07:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=ME5yFwvX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQgHf-0008N4-1P; Tue, 10 Nov 2026 02:28:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQgHc-0008LF-3e; Tue, 10 Nov 2026 02:28:44 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQgHa-0005V4-Hj; Tue, 10 Nov 2026 02:28:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vjEIUk7gr5NdP9G4kbxS2JDCi+Uq5/oSlD0YjB7w9vLWSHRyxlHUjF1cpNzqCZn+PXEyeMvn96UxKboTLJLxJFmJnDrvDK6R8Fy7Yhao5XbgggQY2ptbnxpSfTKri6Z14zZCxHvu9iQ0hCQvOAn6RxcLJhPMbmp97gMW165trMPbJMVgKxJFgugbrb2jp2Sjdd4gca6PJthHtEGD+ZYP4QjmpLfCoHNPHGR6PqR4X7FSM8ikCjVR1ZFMBlMpcycNpHvgbAyKPi76WYUDxhDrRDxemNsDgdY8oP8ZIpnUNkFJ68y8/p7f2a1GigSNd6KBFroTanfxoBB/Agz1mjVl4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7Lwug8hOsF0j+JcduZ0RbghxZtyiG2nsDqjDex9dL8=;
 b=NnNaf3yrpLLNMua2HH3dJdEy51UY6j4E5cFMN4hQLyaRCXN5ZDblWuZyaXtiB3tUiJjdi8iAsVP63tqPqwPheLgMQ2kGCIbnvCOJD7vgZc3h8gSTsMsA2g84Cphb1kW/ulbol1Yy6I9cbuDL4gxHF1o3BBRvjecnOa7SzzsN75eyIblSbZ5RA6HjdUQmndGFb1nvzY7CydxuUVRWRXEhXdcMJYtZGKojAWM7/vhFfIJJoc7eCZauc4k+nWCt3W688wFyAdx31h/KTGeGPxZL1V953UY+6pKUoHZ+qlte9ao47m5+vOf8aJZPaV7k6pB2pu0708kVK0KVXfLQgC4X8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7Lwug8hOsF0j+JcduZ0RbghxZtyiG2nsDqjDex9dL8=;
 b=ME5yFwvXOuQffn0dizuH7Uh9MLHrJpNZzKaoKN0ZM9/iv9VPtbSexYxP3QU6GQZG5RXjRPOZNPH1IbLVpohq8t6QT2cHpmabxxhDcaV7TNFUNR0Ccd4kwHPMHSDXSsCKsWjC8RolJtNkKqJITeBQTKQv/HmtEeT0ECAhWPjks3eniYJjCF4jIoLH77DP4zpsIZFGz/orsv8Nhsz9/r1XWYaxcTWrOK0NykbnEha16o0s2c3mGaFfSi4h8IwVjbKtO0Km2xEPIbPgmCKB5+ywqZmcZhpRugMWkTXZ2wf6TYdOCqIMQxGW+Prmj7ITtVclcfRcL8YqOWUHqqfxTKVxGw==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by KUYPR06MB8987.apcprd06.prod.outlook.com (2603:1096:d10:9a::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 07:28:32 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0615.005; Tue, 10 Nov 2026
 07:28:32 +0000
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
Subject: [PATCH v9 09/19] hw/usb/bus: Turn off the automatic hub by default
Thread-Topic: [PATCH v9 09/19] hw/usb/bus: Turn off the automatic hub by
 default
Thread-Index: AQHdcOUWPslb2rn5lUiKJGyQMhqFzw==
Date: Tue, 10 Nov 2026 07:28:32 +0000
Message-ID: <20261110072818.2883349-10-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 074a625d-42a7-458f-95b7-08df3efc3960
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|7416014|22082099003|18002099003|10067099003|921020|38070700021|56012099006|261102123227099003|261022105027099003|261021123027099003|261021121427099003|261009223027099003|261028144727099003|261026140227099003;
x-microsoft-antispam-message-info: knHncWOevKACOFQwvCgIEpopqReEOOR1GpF14Jg2AmLBKQuwbFR8vh3dXlK8kh5cR6JWYxIiCT1jXfT7KywWHA+yjE67IqLJwyvRKY7/NbdVo8fh8rivrwk85ROKTiZyFwFiWldoCbSp+RAeVJvms9Kc6MQEdoPLP4WO+vP8mIhMA4DqM9jnnxYU8F5VFEy08zE6L2vNurHmxvQcJfCYRohCSHD3QEIpgamuv/cXb29C390V407En/kwaLmTJrfutYkQw6XsearepcRbjuzDcMa24I95lI7y8ZVhrGdgdHPG5idth5p3pSGL/b7jA/iXBSIXR0meR/qFUuOD3bgIX/1gd7+Lo6H0NFS6rPfEYA0XoYCzUuKTSx4cZ+zxXNgfGbFWJRexNv3Vd5uOOdu6nccNhs2/j/u9hibVoklCE1MVFYDpelQny9N2pDGow0tYUZ1TuzCWm7eDGLOjR+qFeq4whdCO8zS6CJqtknpDdouIWPIgyvAe5WDnpAtf5u+3GZwgJ2kzMnFTcc7f9vURWSiM8fT1s2E1pWiHcJkm/GlgjmvwSomNLbDqZj4kA4OFuZWB5F3vIyHlGiB/0LbNe3pWL17pA+ft6XRRW7EbCmckW/vdYS5LFxCmFFE+gFq55GxiHoLTm0c9vHbg06RbE4A3HCAUbBqI/jU1ooXjtriKa0pLErfiwQoiGDz/MMHmXCEpt8dYL8sTDjkI36dP8a+G7pbCWWk6bzkBxA2MINCNxWU0OV3xx04OA5zKeA2z
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(22082099003)(18002099003)(10067099003)(921020)(38070700021)(56012099006)(261102123227099003)(261022105027099003)(261021123027099003)(261021121427099003)(261009223027099003)(261028144727099003)(261026140227099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?kniMtx1SJgY4Ss/sY4Mi9O4yLg8bMK9FlEhAPAZ67jlLRMV1SauG49C+ZI?=
 =?iso-8859-1?Q?rPduaEI2z5Mcfrzt51twlUh2pVt7NEM1asT+NWr8M6hM5GIVA/PebL/SGb?=
 =?iso-8859-1?Q?uel14FPIeEgPTq0Sc336cimBRjrZh4m6npRlL84xURFnhmITBop+B1uBCg?=
 =?iso-8859-1?Q?kYdqHrPH2FdRjQZbY3CZuO4vHRtbx/cZvnLbyvkjNMYgK5zXxZaoJxdvk8?=
 =?iso-8859-1?Q?tX5M5xV8C2Fm1x0fzU4fPRfgzTerFW2Rr4u/nYHtBa8cHvpt1gooAi4xos?=
 =?iso-8859-1?Q?N4nOPvtqeqiVq9SmqupfbHx+K45cIqf4+Zf1mkw3euvZCFAITwq8ollXfz?=
 =?iso-8859-1?Q?jjsQUZSOyzCORsSt2pd6lO9kZEW3DSzdrYtyfWFW2I+HEXi53q+jexqSwa?=
 =?iso-8859-1?Q?2YUw+JZybBvNqpdHqxEHgDbiaiO8uXymBlAYAZJV7nbifCx+I7lZ7xVHnq?=
 =?iso-8859-1?Q?BaB/Am5/8Iu9KC4cHWkBlkEjOdFbDP9IWhAqKdJt71NrDmjV/mCEfD0geA?=
 =?iso-8859-1?Q?b5HaRhyIwEjJ1TXZdITtcW4A/dRQ7I0lB3MVZY3pCnGFC1Z6pn/rZrIhyp?=
 =?iso-8859-1?Q?UnS9ZYG6kpo9kGN25CU1aCpMdE8tho57yzLBdSvHfEzB9MyO9nT4egu6Mo?=
 =?iso-8859-1?Q?9H5ZymZMjYMCYnQV6kv6+EVbECmV1P4a0yZsipw7l3nmTS4WXrrrKnr8WX?=
 =?iso-8859-1?Q?QzZ+5ahNhv6hMVmKWYn9NrNZBG7O0WO2qDejxucJT51AEb5Ptt/KtBv6zd?=
 =?iso-8859-1?Q?8sgvvslu223KWjrBkXTJy+hkNsX0carPwiMt1+RdKYY6Sl14vdp0DN1+tO?=
 =?iso-8859-1?Q?zrasItfsTK5kOKSksdRrgvrOeCGd53wjw9C0emowkwCc+lOV2uGsHDrMvQ?=
 =?iso-8859-1?Q?o1MHotBBM7O4+Spk8F5Mpqr5eCWyw2wI63mmpS/DyFF+pxkIp6+nnnri9h?=
 =?iso-8859-1?Q?1ebAfl3nbPpJNK76uXMZqil04rxQwoEDpZP0FY4Hf1FJYD+XECi9pVJKP2?=
 =?iso-8859-1?Q?Xh/pMXhXDzNgAr5x46B6KD9LHR5t1q/PmrvyzgrIOO11pbhtWIo/tkFIzb?=
 =?iso-8859-1?Q?VlsmEY2V1GqycdZTF7PA3kTsqs5tOo42tMZsQRYDhmkp5D8x/nY1DhYpLL?=
 =?iso-8859-1?Q?4byH7bbBhd7Ka1NFGahpH0rtcnq4PM2Fe/hlZ39Q98PaIn33sONgmCEDkH?=
 =?iso-8859-1?Q?B+5eV7r6Zm09lw6iDCDClGQqRQGABn+sec/v3pBGupMuJRgZ3EVRHF0NaC?=
 =?iso-8859-1?Q?k2bOmMcuDAjzLrhWDfsjX/vxpl/myW+QB2oyIaSCYm4Yb2sSVZzwc8IQdX?=
 =?iso-8859-1?Q?c7retlVN6aIE2yjzV5jdP7uhVHNstihtPteFqlS1MaNhQURPmTbBrMpt2r?=
 =?iso-8859-1?Q?RmIJYJeVkCZClnSK0r2cbt8HgpOYTfsD09ANW9dhAmIKaKIoYwK0TzZ46C?=
 =?iso-8859-1?Q?40GbVHn/TF5TaBdcji1MwOhaS5qSTAAu07fnpTOI6obRoDpGTrRxLCdtEH?=
 =?iso-8859-1?Q?dtxYuNGdol1G5BWnYH/Em09+mfdwGUNkqxtWNajXacWeXVyAhDUjpTwivs?=
 =?iso-8859-1?Q?IQZFZ1nqAF6IkS1k87KAqM++bgb1oVFcCREncZdqQ9dMifAya4zyfsY47h?=
 =?iso-8859-1?Q?fDDMjYQdsfeHPs5QeEsr+QbVN7LH6U76b30EjgWQnAxa128eR/PnDltfy8?=
 =?iso-8859-1?Q?qbXxJ90IYNXgsWdgWqALC/Bmi4nfEdlSkPmz0ehQCfewY4zO2WKn/sGEjg?=
 =?iso-8859-1?Q?ZXn769nfWfMY6/5sbruRkfXrWjqwL8c9L1r9txHYQdwfVqrZF/qa2yQb/L?=
 =?iso-8859-1?Q?IVcVj+pr9A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: T9LQZSJcdC3w0Ra+taFYyjjt+fl2LZUx3vYzUWI2eOUf1ErRv9u4kK9blqpyes3HHASOx0CM0oeQkVHKrG5mhdY9KKWneNOpi4AjiDYth4Fcrin7YehAWW809aB36lgZII0vUi+kIt9u/8QUrRVR1v+1pkQe0x5hhKIMCrUMFjw55OPvcdECOX1zwiCtYVQmLPHv+9p39n72pxA5QZVlZUl3qO+4oa88wRgOAOdY6014mf7uuWDhRpG+DzCHfnjMfSBMog288+sq1I0xMVvER11vtYFR7CozPIOPNo2qAZHbAPhgdNcq78JTbNIM0WEdnVIWkaGNza/uKd4YSbzGHg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 074a625d-42a7-458f-95b7-08df3efc3960
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 07:28:32.4657 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wPijJmCDbXMvz5s9s17fjZ96HOaV4cycMXVQmG5+8wu2o4sKzQtKCeweYrv5Sr5XJOCDtKIZcXcevqpPUxnAAh3Ek0YZby+mh8jCVb0vNlg=
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

Every bus creator now sets auto_hub from its own property, or clears=0A=
it outright, so the value usb_bus_new() leaves there is never read.=0A=
=0A=
Drop the line. A new bus then has no hub unless its controller asks=0A=
for one.=0A=
=0A=
Suggested-by: Gerd Hoffmann <kraxel@redhat.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>=0A=
---=0A=
 hw/usb/bus.c | 1 -=0A=
 1 file changed, 1 deletion(-)=0A=
=0A=
diff --git a/hw/usb/bus.c b/hw/usb/bus.c=0A=
index 92f67de4fe..cd587db892 100644=0A=
--- a/hw/usb/bus.c=0A=
+++ b/hw/usb/bus.c=0A=
@@ -92,7 +92,6 @@ void usb_bus_new(USBBus *bus, size_t bus_size,=0A=
     qbus_set_bus_hotplug_handler(BUS(bus));=0A=
     bus->ops =3D ops;=0A=
     bus->busnr =3D next_usb_bus++;=0A=
-    bus->auto_hub =3D true;=0A=
     QTAILQ_INIT(&bus->free);=0A=
     QTAILQ_INIT(&bus->used);=0A=
     QTAILQ_INSERT_TAIL(&busses, bus, next);=0A=
-- =0A=
2.43.0=0A=

