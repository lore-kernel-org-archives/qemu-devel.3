Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45E3606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 09:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=F2tdEDtJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNoGK-0007e6-Ic; Mon, 02 Nov 2026 04:23:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xNoFF-0007K0-3D; Mon, 02 Nov 2026 04:22:25 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xNoFC-0000WO-5b; Mon, 02 Nov 2026 04:22:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BLbi5IBwvH5BtoeP7pJO/zmP2xT9XpXaJ/YjhOZukh0XKuiVkaLgwwh9R6AY+fmb+jnhDtVKNxAH4ykiKTxw0ZiN4z7ijUTNpr7KZOvY8McFyyJVgGrfB/UTZuyR5TX3SELOahiVWFgZzXtr07We1ULvmUvEoKDLCXvDnu0cx4CUqxoHpFXuRqju5AW89S1zgfn3uJX82hV9QuTU9CWczoB7kqzpZlqMq40Fu4gXxHBB8EURNzQAe6rUC4GB60LWpNBxwJI1uxKhwCRPveqtMZjqklJmfRsNFPXXvrBmBszc6S476WeE9/HUvW48AIXr9GRi6shnBHwnYtVAAvWlvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=slEpC7sA1u6HimItMYOg/Z7wH4ep4k9iSBPq0AALo/Y=;
 b=AJGS4i4jFuhuC92d1CJxSQ1vM+tMNkrwXK0atCgeg6S+zt+U2LCLLDpiMSp7v0kf+B7xq6ki3j+CIrqqPxgB3LeX7/pK3wpIqeGb0BnuINt1Qmrhfm1SxpIq1RXNE2Qg2FI6npW2CCJhtr5a/I4/wXUkwbK5lABrTZW5MjOlxGwDUKolos5Ik+TGKl52vjss84f5D2DNQP9WJ2WcyE7ytL4v32cBjYtZUO44Sew2KUAo4gSWx3N7vBD9uL6yN2bplNyrSY35zReZoPzCXMPe/3fv6pKMnPcDP9bHlfCL8Q3/7br3cTz4GU3EbJV1m6+6a5fXDa7OVdDOy9WFkDH+mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slEpC7sA1u6HimItMYOg/Z7wH4ep4k9iSBPq0AALo/Y=;
 b=F2tdEDtJXuxucU1ffEGEkeP4mGXy8Hx1/kkWcWpe7rd36896AObJQhvayUg4/kxwLeJHZmOkpRYmRAoiKGdCKofB1AuDAi3+t3GSJFTs11WJCmdzgUTHjhzdZ6n4SVzYBbbbaxPtUnb+JOST9xIKb4wuLZ8sZIi1YJWqx4QB5/ysXS5rb5JJYiukaoK1GqpuvAkfRFsULFHOo7puLqBMY20NS0q81wtO/UbASiN9ffbgEyDRWW0QlZMTj8y18uCIQo2Ua3Oo8YB4pexgsU0MtUNkWwVmuPnhDEc8JA/sZY22Wy4Gh34kS6h4BDPoJFHDpRrBYpOPBv5+MiBGGCb7yw==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SE3PR06MB9218.apcprd06.prod.outlook.com (2603:1096:101:335::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Mon, 2 Nov 2026
 09:22:10 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0592.007; Mon, 2 Nov 2026
 09:22:10 +0000
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
Subject: [PATCH v8 05/18] hw/usb/hcd-ohci: Add an auto-hub property and leave
 it off
Thread-Topic: [PATCH v8 05/18] hw/usb/hcd-ohci: Add an auto-hub property and
 leave it off
Thread-Index: AQHdaquj7EwX/4j+EkiS0LfitZAyFA==
Date: Mon, 2 Nov 2026 09:22:10 +0000
Message-ID: <20261102092201.1729245-6-jamin_lin@aspeedtech.com>
References: <20261102092201.1729245-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261102092201.1729245-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SE3PR06MB9218:EE_
x-ms-office365-filtering-correlation-id: 5b3d00d8-4f87-4138-f1e1-08df38c2c603
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|7416014|376014|921020|38070700021|56012099006|261009223027099003|261021121427099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: OUkLPFmGsj0MeL1b0j1UC6ddq2OuGLcfoUhVf7atSSgJT2rB2U4R+ZakR+1v8ImvMdx/858BUSlDcMCpAIJL0AntavYSi6dzcZXcs9tj+eB07H1lKn8PBdGvphRpkNHwO7S+DuBfle6gy3kBUn/uZtblLjXG1BtQBPBHuhYPhxGPiQqcyc9XDI9dg8lOhX3A5hzXNue8oftxWpswiJbPg/9JrVSp7tfCg7f8lGJDAOpcpMkDzhgRrFiEeqBooLmVMkBG4wZR7HmidsLGWWkzWasr8oJ9UXQeQN1ODRDiTDbhyAS/GW8Cl8REFauhDpMEKMwEheht9GePaAF0nnijmBFLKtdyS/uYoNYfe4i6gIlZKlaUr4l3oh+XQDIxnGXInO4ZN+x0MxX61EMvjMmtNv2MeWxhjPwc5vSiFhPYyyFAtJOeNHZahBAS3ZzF47RLG7Iikpl7gn6e0YgM1daGtEmA7cz7dNH/SAHq6rrajmHu2Xd/mA2qSs9CU19Uz2u6ZwSTnIXKoUcfQ3N40S+a6X3HpmXZuonPhJcKeMLhC0mU7GY0UobEc2MKKlAK6H8EkdRMbfX0kCgLP2rjbT0tl444oQLe1YIGX6YCainVsspTNQq5URvnQX0sPcSq4tp1OnJSxMXMoIiNAe6bb3r+QvGCvWgThTksxUdVgb6NmuK30aE+Stnyry3QR3IEDCnyq0L1wIjIGxyqW3vKG91sRCwT47xm6Yau2cU1KF2Mg1eTB5zgPvBDjqpgd+ffyZ8m
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(921020)(38070700021)(56012099006)(261009223027099003)(261021121427099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6t05kPOdUMBJnQ9s8bQ6xb9D0J27PNjL7ImYQaEHrb+o1m+cQgP2EMzEuM?=
 =?iso-8859-1?Q?zFDU+GSlVm1O6Dxv0mRf+hP0XBBszmmlKrcSy/WXzFazjF4RAt/PmftTTi?=
 =?iso-8859-1?Q?T5L/23Dw3Jq6xL1ogVouFaIm/zgEQ2U88vC7aTf0tQysGq5zoaeShPSyzg?=
 =?iso-8859-1?Q?Ua2pBaIqd1oNHRXAaALmeiPg9KsfOPuJQjytrzb9/uyvnAgqD6YS7oijpz?=
 =?iso-8859-1?Q?DJG85GrGkU8B3rQdGV/qR/pMGfnGTu6pWOVrhYiljCFNXgnAxkhLrGN9kR?=
 =?iso-8859-1?Q?C/5D+/K5QwRfDd+ETH3EIroEWCFLLV+txCPImWXEO4wO3C9unaDrfZfe+f?=
 =?iso-8859-1?Q?ok6djnkH1WIeYn6QRe3a2Gs7yuY8whMx0J6TAOhQkQMpBm5Z7AOYiQ/MX2?=
 =?iso-8859-1?Q?PyCGPorHUrBukDl1H7mpacw1SEeERWii0pjviJ1/LlDMLozG1Jm6LCpDSa?=
 =?iso-8859-1?Q?zzoMy4tZiYVB2RfivA3lm1A68A4vay39F0dks6F2mm68XyNQOF4tYAvB6B?=
 =?iso-8859-1?Q?VQb5Wq7IpHHmVjsSwgcraSkYYExdPbanMSTo2LFRvLP6t5xy09Bp3Hx5hZ?=
 =?iso-8859-1?Q?0hi87CCHcybXx80mwJsVUwwwQSMhIrRGN3cXNxzYH7Pcj4q+jZD1kw0Hr7?=
 =?iso-8859-1?Q?tlnd0rw0NAVA3R/1JCy1jHEnzu5dkCIU09Wu3s9EHk+hnrgraTSYjsAfeu?=
 =?iso-8859-1?Q?Wn6JPl/zPIgmT68bht9n8aVjSWIUq8AU+p7Q9En8VOx1+SZMy4XpL+XGtt?=
 =?iso-8859-1?Q?FGn8Uapft1Ihqk7bZ2F5OZOOM9i1v/TufObqa839usVI9BZc5ZFRuPFlao?=
 =?iso-8859-1?Q?d7kZR1CozFu2FnilEbW3L+lf2iM9VA7fA1BrGYY0GYnd9J4YNQH7UXB3Ee?=
 =?iso-8859-1?Q?3sbteORjhp2QtRMH4lBdqB6OjqHcTBpagkDyFnWImWkCDeq7WSUKQbI2eg?=
 =?iso-8859-1?Q?diI2gqVnFLTl9LDhc772Is/3lB5p0DC8HseIaOjpIBLJMsFpaB93JyOf8M?=
 =?iso-8859-1?Q?Eu2iez/U8YNqV+pn0TQvYQ5spgPrYDw6lqYIXYfHbfOpLI4EkT8OyJcz+X?=
 =?iso-8859-1?Q?h3qDcHuybsp8yvvvLv6AE+pBQ+bK+/J60VE+9Zb2reZuvRO51H5VsYMPwk?=
 =?iso-8859-1?Q?9qYcOcqtRElpMkAd9PpwSwYnHlyW9/+NpD2AHBocYjCF1NR7tFemoMaveO?=
 =?iso-8859-1?Q?4zgcedIr7JD2Xm8OKf3OA5iHDlvHtqlF1PcOI38CopsbwU7J+q2OwWoFq1?=
 =?iso-8859-1?Q?Rl4eRIPSx7KekEjRSd9XumDByOSSKmwMn5RheqBYvhmh+LBezgOhExPREv?=
 =?iso-8859-1?Q?RHrFp7fKYqj1JY5S2Z2NGj+Gma0/dyKWPaLWazWBGJm4T2lwX3iaRuvoc2?=
 =?iso-8859-1?Q?LnI1roiN8nLPROad8Ano+oeVZs2/q/G6N7aYO2FRpA6qfl/PX+PDUPL+pn?=
 =?iso-8859-1?Q?vDZ4n/j87zHRoMhC6Udqb9yczMZCyUeLbrT0vD+bjKA+NNDoHt12ALBcCP?=
 =?iso-8859-1?Q?O6NwIpvzt9ZP9sKgfbg8la+qXHLaZVS6OX7B5eCL93MYVPIFnViokzPKHv?=
 =?iso-8859-1?Q?X+bgq2WC9DghXGJP7ZWe0RmH751VlAlw72J14cadXyKBSW+1ewqSInS+z/?=
 =?iso-8859-1?Q?8AChRHHSstwdUrfWJkjjGofFboH3FB3yaC1tYxMaPGM6YhXFTkj8iVQGdH?=
 =?iso-8859-1?Q?4CMxiKjiWWxvbY/AAA5Q6llDAwblEN4MPRfI0vErOIZphm9f+GaHcLH14A?=
 =?iso-8859-1?Q?GPLa8/2u0jffZSbJEhwyyElhY1ahCZSb81UrXxM8VLlapkNXsPSdVFlAM4?=
 =?iso-8859-1?Q?9nB4YR2imw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Za7xd447FRlhmCEjWm17VM0JbiZz87yEf+KTnSQZHDNtnG90aSDybNQyhP410EzoJBCBlKGgSLlC0OC7R46ry0T5umtkTBpK2kIuxecnOmRbamxsYOSr3FRdoQP29+Xsggwk1tr627byKWTSKBSuuIn8Hcow/ap6UY9SzjVQ/mSKG4h/OTZZwwMLMT7px7Dwm7Y27ZoCSoJND8zkBm0xFdelbBhokzF6AVMzZk3oRDicdPcByxWf+kX84FY//T8LfORgUhAOPOYVqMY25pRV9VNjxBz12hcPoqgMjsYFbyrI1A76S/p3G4h8riDoGZBICGmlSejUQlzz1whvOwp3sQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b3d00d8-4f87-4138-f1e1-08df38c2c603
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 09:22:10.0648 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hzYBnBlIPJrr2CefW37s+GX3s5sKbFzzjOSSusl6i7PCZdZGS3uz4jFyBUryBlQGMul3OdZkF/skp82n4IO+sZL8qilQpkyAu/kK7Iz51vQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR06MB9218
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add auto-hub and leave it off. hw_compat_11_1 turns it on for=0A=
pci-ohci and sysbus-ohci, so an older machine type keeps the hub it=0A=
has today and a guest saved by an older QEMU still loads.=0A=
=0A=
pc87560-ohci is its own PCI front end, not a pci-ohci, so it defines=0A=
the property itself.=0A=
=0A=
A companion OHCI adds its ports to the EHCI bus instead of making one,=0A=
so there the EHCI property decides.=0A=
=0A=
Suggested-by: Gerd Hoffmann <kraxel@redhat.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/hcd-ohci.h        | 1 +=0A=
 hw/core/machine.c        | 2 ++=0A=
 hw/usb/hcd-ohci-pci.c    | 1 +=0A=
 hw/usb/hcd-ohci-sysbus.c | 1 +=0A=
 hw/usb/hcd-ohci.c        | 1 +=0A=
 hw/usb/pc87560-ohci.c    | 1 +=0A=
 6 files changed, 7 insertions(+)=0A=
=0A=
diff --git a/hw/usb/hcd-ohci.h b/hw/usb/hcd-ohci.h=0A=
index d079f8d24e..43240622ef 100644=0A=
--- a/hw/usb/hcd-ohci.h=0A=
+++ b/hw/usb/hcd-ohci.h=0A=
@@ -98,6 +98,7 @@ struct OHCIState {=0A=
 =0A=
     bool big_endian;=0A=
     bool consistency_check;=0A=
+    bool auto_hub;=0A=
 };=0A=
 =0A=
 #define TYPE_SYSBUS_OHCI "sysbus-ohci"=0A=
diff --git a/hw/core/machine.c b/hw/core/machine.c=0A=
index f79337e7d7..22d2b83459 100644=0A=
--- a/hw/core/machine.c=0A=
+++ b/hw/core/machine.c=0A=
@@ -47,6 +47,8 @@ GlobalProperty hw_compat_11_1[] =3D {=0A=
     { "pci-ehci-usb", "auto-hub", "on" },=0A=
     { "base-xhci", "auto-hub", "on" },=0A=
     { "pci-uhci-usb", "auto-hub", "on" },=0A=
+    { "sysbus-ohci", "auto-hub", "on" },=0A=
+    { "pci-ohci", "auto-hub", "on" },=0A=
 };=0A=
 const size_t hw_compat_11_1_len =3D G_N_ELEMENTS(hw_compat_11_1);=0A=
 =0A=
diff --git a/hw/usb/hcd-ohci-pci.c b/hw/usb/hcd-ohci-pci.c=0A=
index 70c9e9ac4f..11c754a948 100644=0A=
--- a/hw/usb/hcd-ohci-pci.c=0A=
+++ b/hw/usb/hcd-ohci-pci.c=0A=
@@ -112,6 +112,7 @@ static const Property ohci_pci_properties[] =3D {=0A=
     DEFINE_PROP_STRING("masterbus", OHCIPCIState, masterbus),=0A=
     DEFINE_PROP_UINT32("num-ports", OHCIPCIState, num_ports, 3),=0A=
     DEFINE_PROP_UINT32("firstport", OHCIPCIState, firstport, 0),=0A=
+    DEFINE_PROP_BOOL("auto-hub", OHCIPCIState, state.auto_hub, false),=0A=
 };=0A=
 =0A=
 static const VMStateDescription vmstate_ohci =3D {=0A=
diff --git a/hw/usb/hcd-ohci-sysbus.c b/hw/usb/hcd-ohci-sysbus.c=0A=
index 4f51eebccb..69f38b9fce 100644=0A=
--- a/hw/usb/hcd-ohci-sysbus.c=0A=
+++ b/hw/usb/hcd-ohci-sysbus.c=0A=
@@ -61,6 +61,7 @@ static const Property ohci_sysbus_properties[] =3D {=0A=
     DEFINE_PROP_UINT32("num-ports", OHCISysBusState, num_ports, 3),=0A=
     DEFINE_PROP_UINT32("firstport", OHCISysBusState, firstport, 0),=0A=
     DEFINE_PROP_UINT64("dma-offset", OHCISysBusState, dma_offset, 0),=0A=
+    DEFINE_PROP_BOOL("auto-hub", OHCISysBusState, ohci.auto_hub, false),=
=0A=
 };=0A=
 =0A=
 static void ohci_sysbus_class_init(ObjectClass *klass, const void *data)=
=0A=
diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c=0A=
index 5e5fe41f47..2c25829b76 100644=0A=
--- a/hw/usb/hcd-ohci.c=0A=
+++ b/hw/usb/hcd-ohci.c=0A=
@@ -1987,6 +1987,7 @@ void usb_ohci_init(OHCIState *ohci, DeviceState *dev,=
 uint32_t num_ports,=0A=
         }=0A=
     } else {=0A=
         usb_bus_new(&ohci->bus, sizeof(ohci->bus), &ohci_bus_ops, dev);=0A=
+        ohci->bus.auto_hub =3D ohci->auto_hub;=0A=
         for (i =3D 0; i < num_ports; i++) {=0A=
             usb_register_port(&ohci->bus, &ohci->rhport[i].port,=0A=
                               ohci, i, &ohci_port_ops,=0A=
diff --git a/hw/usb/pc87560-ohci.c b/hw/usb/pc87560-ohci.c=0A=
index cc00f6e936..66c1e62d48 100644=0A=
--- a/hw/usb/pc87560-ohci.c=0A=
+++ b/hw/usb/pc87560-ohci.c=0A=
@@ -296,6 +296,7 @@ static const Property ohci_pci_properties[] =3D {=0A=
     DEFINE_PROP_STRING("masterbus", OHCIPCIState, masterbus),=0A=
     DEFINE_PROP_UINT32("num-ports", OHCIPCIState, num_ports, 3),=0A=
     DEFINE_PROP_UINT32("firstport", OHCIPCIState, firstport, 0),=0A=
+    DEFINE_PROP_BOOL("auto-hub", OHCIPCIState, state.auto_hub, false),=0A=
 };=0A=
 =0A=
 static const VMStateDescription vmstate_ohci =3D {=0A=
-- =0A=
2.43.0=0A=

