Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C6860A261E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 09:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=NzxDBS+G
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNoGL-0007ek-A7; Mon, 02 Nov 2026 04:23:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xNoFF-0007K2-4z; Mon, 02 Nov 2026 04:22:25 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xNoFB-0000WQ-Ck; Mon, 02 Nov 2026 04:22:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CyAJzpOVM6JLqr9npg11ChlRgBbNBonYEIWV8zUkbcP++0eN3QPtPpyBSh2Tx18VSqJjRd339IGNQkTdthJugzBFIdKzM73B9aNsNM2CVOZLLz89+TCvE7xRfM4pZAPfLYA6iigu8/YdUgsRwRHCLRaGM1+IBZ1FspzKcm5nzB/HgOvBSQFiFb8DgDbqhu3hHCsmJEu/6LQcaWrCQcgBvDmIx/TeG5yMuuqaTUaheZKUggfUOeoUvbDH1bOOe3N5DGT0cVfwqAMcIFUovg+bAQ1BWpcqzURMzpNddCzw0jfeTrZqKutDGChxOPVJTS9sUcXrwUc4pCMdZV6/N4Alhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vEWlejgjfgQucp6V6Ol4TvUQGfDuT+Tfdpd37ISkCag=;
 b=LQr29Ej/eUjnLf+YTSg9zg0brdRr6P32kmnnRaYp1WiWi1OL647qaeCS6t3akPg/+r0DxyiS1wSQSzz4oUq79yHlOP81k62MLs8GOBfR66KB1isk1l2lEkoUX/I1cTqIbFGbE0Ia1XOaqBTVcrZNxqyUlusC3y7BrIIhrgazOCsSbT7cAARPG+4vPXYuza81ZxSXq6N3FL2jhJIdp9M+eikTRTxd+aMCfdota7B/wmZXtBr1ki7WDRUpcF3Lv6LJhmlfT1bFCFziuvA5HYfcIkdYJHw4TXtoLpkrS5R4zlubgJNPUVhKutFsuc+N5lvIXnczfWEgsJMP/S9wgeCUEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vEWlejgjfgQucp6V6Ol4TvUQGfDuT+Tfdpd37ISkCag=;
 b=NzxDBS+GB1fn8X+knGM8zcoli1yiOOPLpWtg1AsfxoBkq5tVfAvZ2Wz30BvXa95gKp0HSyHVhjs57uOaI3/D4mC9mbhMeZwDiPiLfZhYdKcWQI+OwRC55tPFyUCveeW5L49YYU5UAV3hbo0Acg2Gmc/Lf4AgymLPdBlqo9EqYwCeV+BccX4v7wTmQDWKYDjNyBVhP5lIpWfKO11C90Pi3hCe7KZ8Ey2QZjKmfoSqp0m2lfDy7zOdh4RDigf+A3gj6r9qKAy49/XPDaBS1p4acnn2fEXNLAwTNrZclBsBH3pCDnda61kZbcspzHb+mTHODcMTWFqc7vtLj8GnBePGNg==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SEYPR06MB6832.apcprd06.prod.outlook.com (2603:1096:101:1b2::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Mon, 2 Nov 2026
 09:22:11 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0592.007; Mon, 2 Nov 2026
 09:22:11 +0000
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
Subject: [PATCH v8 06/18] hw/usb/hcd-dwc2: Add an auto-hub property and leave
 it off
Thread-Topic: [PATCH v8 06/18] hw/usb/hcd-dwc2: Add an auto-hub property and
 leave it off
Thread-Index: AQHdaqukW8xwK7/WBkWVcuKiha5nVg==
Date: Mon, 2 Nov 2026 09:22:11 +0000
Message-ID: <20261102092201.1729245-7-jamin_lin@aspeedtech.com>
References: <20261102092201.1729245-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261102092201.1729245-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SEYPR06MB6832:EE_
x-ms-office365-filtering-correlation-id: 7527509f-e186-497f-0cd3-08df38c2c693
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|7416014|921020|38070700021|260925022911599003|260925021311599003|260925021911599003|56012099006|261009223027099003|261021121427099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: wH0rrJr0cQvER08lVWSr5UigztyOc2me5sL7vI7ljOT4njPRDXDAKw/wAgVHwOx6/b2A9CadtclLE0iSxMdNOnNPoWmzt/AbHtU0rvp34jEyqoDlHtoREvNPM7w4u8gSyMcMunnNsNIzMEzKUr5WW0x8lsydgG8OvUr8TL6CL3HqkYZHR25lMwB98DLQN6KQCymMNsULhbDQWK7PmTeZmFQrAE7b2PWmi3ymD4J4X+G7m/Cs8hoy8WF0R2sf2et8SEOf4KT3NDiPWw8TmfE8bH0GZWjR7iYUvJVPCd3BH/xFXQWSIqnoCwBkX4k54Hw9O7vdsrkWAeX2Y63H1wbvtvXaAYXFUtXXGP799HC8UwKohMU2a5mt+Q19mwuJsyrpKYiLkNyQUmh4gHHgPx8K0Ygtw3UDuh7dpZhPkGjdArTE59mOhImpaJSPBQVV0eieSbHlgK9o7UB7Fv0WRFFyXWn+g2ugVO2XZsDEw0CGkfkNZW9s+7r14r7WU7qh/1j3+19OzSDNWTeHu52aJwON7ygjKvEHMOepUdBiV53J6GY4Yui7tzjZ5wavUqlEXhgKUu/R00u2k8Sq9RyxO+wcroAWjDns3e8wXGVLnvZNdBKijzxJefaSFFR3MUFi5jZ/FYMKPMM6AgGAZO04XUJVbjycL0exe83AJj62o00hw89u5Pcmes4JnZAguq9hUvBS9Au0FC9b1GUTr7jbEO01ehKXMIBquAQI1UUvIJ2agRmwQE4wIw7QzvguC8Luy2YP
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(921020)(38070700021)(260925022911599003)(260925021311599003)(260925021911599003)(56012099006)(261009223027099003)(261021121427099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?a99ExvLgJ1cRoYgVeNfaFqBjnLoN4KZni5Bz2mmr6xID702f1L3Ith7NsW?=
 =?iso-8859-1?Q?t8nKOw1jn/IUEO5pQvjL9WseTCmTHZOpqoPy4PZ9m0bTfv3UTfzvwV5NZe?=
 =?iso-8859-1?Q?WL6ZdJLaOeuwPInR2NWfZSy9sTZDIsekvn14Ewpu1Cquf8tyHGeHNoqEBF?=
 =?iso-8859-1?Q?n3a1++NC9z6KHsdphp7MIUx5/bdvxUm97uZX++gpoq8zGYJcUKq5PUsqkt?=
 =?iso-8859-1?Q?c8WPJHIjIhdhfoghJ2Ev1EtaPuho/h5JLC5FFC1fE1U3Kmqt9PA3BSopKA?=
 =?iso-8859-1?Q?Bb6Uo57dgp8xSs/4CkCkKViQPk84cX9xQLhfBSjm1zm2gJxElu8HJkuYpM?=
 =?iso-8859-1?Q?MVUXSWa5J8r0juNsc5Hq5X7UTpU+2x/AyIQIyQV82++UEU+JF4gadklukV?=
 =?iso-8859-1?Q?hPuFA3F3+Jeg5ITgsMvbSKkG5UHbPIb06sbU3KIS7lWMMaE1ew+zmoC0Y9?=
 =?iso-8859-1?Q?G5Cl5dy17szkjd168OlMrCe2AAfEoP7v+KBxcTyfFAYNUqLHAudcTqxcfS?=
 =?iso-8859-1?Q?buz3j/wt4TI2HcjGPvSNA2YyJoGSJuHSrV7tSiUfTHdJp9Z+8Hi5Cd287S?=
 =?iso-8859-1?Q?mdkcKd1w22ZXE5sGWZ53WesNYEl+oSofPGIwPWdxlzgk7gSDAX3lCJAqM8?=
 =?iso-8859-1?Q?FC+m7WnK0YCQcI4DXkkIlPvVBZyI3tEIEt0WIQtYsmdXtDnCu21zbt35/G?=
 =?iso-8859-1?Q?KEm0HKOaj+BVe8i7LZbFN1gLmjl8NUdJ4JW+Z/0w8mdwzHCEAnJsiW1dRA?=
 =?iso-8859-1?Q?XH3cjvsyglqATs1tCEqU/ouXzc3+GpJ4dcaJlfWw6rSQKS0PtVeYOL/6eS?=
 =?iso-8859-1?Q?1xgAT+T2UzRmuXgytp6SnxbDykONg1NNSd91yPRO1yMvcyRqadFYvG+Bu7?=
 =?iso-8859-1?Q?ylqKu18MOVXJURSNVwaTPeC2ZkOzDeu1trQcKboGHsIurH1vxw/mfXR7Rn?=
 =?iso-8859-1?Q?r7mdvSdCSgpimqLo4Qx2Y5z5Ce1sRkv9TytH8yulv56YuXNSwhNhJQcFbN?=
 =?iso-8859-1?Q?auL91PGvLaXZ6HkUP9HMeK1DQsLryhqwR9M6pkL2Li/ya9Y98g/ax6XflY?=
 =?iso-8859-1?Q?SjNb5arFaBCOguOCepTeNh9nTPsh8PgsOfE402CK3T0VfMJFAvWWZ6tayh?=
 =?iso-8859-1?Q?PuS1EDDXBrdV4/tf1m/Ae3PieuCUBczKN3/4ps9FmsU/e3CGVuLstg0ipw?=
 =?iso-8859-1?Q?hz3vmj6rRYWXkYrBHNZJNGMYM6fhvs1MIm0h04tSNyNRoeuDuhCLWk97cQ?=
 =?iso-8859-1?Q?kC6YYTYISU8ka3rJtq9tzg0VblW+mu7ZFKsyp8w12PXwzvXBcpfggaMB0f?=
 =?iso-8859-1?Q?+1EpnjMQCF/l1i3uBAQc6LwOLoeA0egopJVXH2s7nb+FosdIrelLXI8RTg?=
 =?iso-8859-1?Q?Gq6qqT4G9NHi/clyzpIsjqi5hJ9I7I/+FBF9H+++7QGKh9bT/EELuxg+t0?=
 =?iso-8859-1?Q?PFU5qmZPQVzR6+5tXKZNMo4PIoKMn3PbDiAXq+nTKbmBFUEUgPrMGFMHqC?=
 =?iso-8859-1?Q?X/2AHefPrBVoUsGh450IsqAl0JTRWbyc14r9Z3efIyaq4c1mkfaWpKgGC0?=
 =?iso-8859-1?Q?EITAHXo/RVayFHjokXteHJ0uc6c7pyQRmvBcTIPK0QTYT4CicMHFBvhCuv?=
 =?iso-8859-1?Q?xZUK/jd5l0tfOb4hDCnUHKyQha9tCuhB6FGq9pUm0wL078pRZZX9WjR70E?=
 =?iso-8859-1?Q?HOB/TQBznSX7h1BcH1uXb8natdw6y+UKQDkYorE37+XhgNyclyfkE8OmCU?=
 =?iso-8859-1?Q?gYBCr3jnyi1jbI6zCmztCoEZpPp+/CEkzvxnxe5AH8kiiIcp1+4aMXcNww?=
 =?iso-8859-1?Q?UHWST4WJfg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 4BZNIJMYTNSmv1n11VS6LiAPhrdbIzI2t1rjNF9cAOIY5nse4uNtQ6i52E0c+x14x1KXQMpSvoHVS54v/cU3zAoyxWT0sbz0MkhOeKaOQVb8P3nBjJ5MtfE1ziaO/XAy/heOTomcTGzNEnKZBrb/sk0XfTwm6i/CuU5BGh9PYjzlvnj8foc0MqIzQqtKqAvYyNrvReqLL5MlmnCPvRcYANklnZwWPmRZ5sqni1t9kmBjUVRcElwWr6hs2tnsvAvzdWJB3H1DRDDk4bY5CmSYo8uPWkkW6vl9fAxWEfCtOO9eHWR0azMSyyfjcihGqnbET3Z5YTaWnxVKHpycl9kZLg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7527509f-e186-497f-0cd3-08df38c2c693
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 09:22:11.6043 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U1+SOcBRUGNY0nbURzgl74h+Dzs4OVP0WHozRTwp8bel+S0fNZVR+sOga9za61ORx/pw7X/zEQgifdqRgg1nJcgicpRltGwRpUSoBJd7VkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6832
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

dwc2 has one root port and runs at full speed, so a second device only=0A=
fits behind the hub.=0A=
=0A=
Add auto-hub and leave it off. raspi has no versioned machine type, so=0A=
compat cannot reach it. bcm2835_peripherals turns the property on, and=0A=
raspi keeps the hub it has today.=0A=
=0A=
Suggested-by: Gerd Hoffmann <kraxel@redhat.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/hcd-dwc2.h            | 1 +=0A=
 hw/arm/bcm2835_peripherals.c | 1 +=0A=
 hw/usb/hcd-dwc2.c            | 2 ++=0A=
 3 files changed, 4 insertions(+)=0A=
=0A=
diff --git a/hw/usb/hcd-dwc2.h b/hw/usb/hcd-dwc2.h=0A=
index 68877661ca..be06f0b0e7 100644=0A=
--- a/hw/usb/hcd-dwc2.h=0A=
+++ b/hw/usb/hcd-dwc2.h=0A=
@@ -167,6 +167,7 @@ struct DWC2State {=0A=
     uint16_t fi;=0A=
     uint16_t next_chan;=0A=
     bool working;=0A=
+    bool auto_hub;=0A=
     USBPort uport;=0A=
     DWC2Packet packet[DWC2_NB_CHAN];                   /* one packet per c=
han */=0A=
     uint8_t usb_buf[DWC2_NB_CHAN][DWC2_MAX_XFER_SIZE]; /* one buffer per c=
han */=0A=
diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c=0A=
index 558c180df9..9187376812 100644=0A=
--- a/hw/arm/bcm2835_peripherals.c=0A=
+++ b/hw/arm/bcm2835_peripherals.c=0A=
@@ -152,6 +152,7 @@ static void raspi_peripherals_base_init(Object *obj)=0A=
 =0A=
     /* DWC2 */=0A=
     object_initialize_child(obj, "dwc2", &s->dwc2, TYPE_DWC2_USB);=0A=
+    qdev_prop_set_bit(DEVICE(&s->dwc2), "auto-hub", true);=0A=
 =0A=
     /* CPRMAN clock manager */=0A=
     object_initialize_child(obj, "cprman", &s->cprman, TYPE_BCM2835_CPRMAN=
);=0A=
diff --git a/hw/usb/hcd-dwc2.c b/hw/usb/hcd-dwc2.c=0A=
index cd3b61158d..14211e6413 100644=0A=
--- a/hw/usb/hcd-dwc2.c=0A=
+++ b/hw/usb/hcd-dwc2.c=0A=
@@ -1354,6 +1354,7 @@ static void dwc2_realize(DeviceState *dev, Error **er=
rp)=0A=
     address_space_init(&s->dma_as, s->dma_mr, "dwc2");=0A=
 =0A=
     usb_bus_new(&s->bus, sizeof(s->bus), &dwc2_bus_ops, dev);=0A=
+    s->bus.auto_hub =3D s->auto_hub;=0A=
     usb_register_port(&s->bus, &s->uport, s, 0, &dwc2_port_ops,=0A=
                       USB_SPEED_MASK_LOW | USB_SPEED_MASK_FULL |=0A=
                       (s->usb_version =3D=3D 2 ? USB_SPEED_MASK_HIGH : 0))=
;=0A=
@@ -1450,6 +1451,7 @@ const VMStateDescription vmstate_dwc2_state =3D {=0A=
 =0A=
 static const Property dwc2_usb_properties[] =3D {=0A=
     DEFINE_PROP_UINT32("usb_version", DWC2State, usb_version, 2),=0A=
+    DEFINE_PROP_BOOL("auto-hub", DWC2State, auto_hub, false),=0A=
 };=0A=
 =0A=
 static void dwc2_class_init(ObjectClass *klass, const void *data)=0A=
-- =0A=
2.43.0=0A=

