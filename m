Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E57606A325
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 07:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=L/zlvVbd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQgI6-00005z-7B; Tue, 10 Nov 2026 02:29:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQgI5-00005l-1C; Tue, 10 Nov 2026 02:29:13 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQgI3-0005Xy-H7; Tue, 10 Nov 2026 02:29:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aPV5qguqAKFnHO0ccppnNm75F5HgSlLCAED5C+0glSY+oD8Ci+XAyMZjXTDUGspzLOcN/51gGCrIq0ALr1Juk8jECHKGJGH2lxpP/2TdKtiV+Fv9mAjzm05ScaMIN9dN3qScqpPEt9dGCjyyiYIZzuqTt4FVIIkUUYSk2aQztYr5QINtv9CVpDS/HnbYu9noUIrwW3XgiuMFoskX5d6k5297m4Hfe5h8Jeu1A0dY7tOcrV2To3uJJYWE/olrH9NXRaVmxqb/L0RDZ9+i+NJN2MtVxHnN8b8SgePgAr57QHJw+47pRhcuUvZ1Fw5lrXmcJpRsG30zVpOIalHF3mP84Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JyKnVcNB9bb9Oppe6x9bCVeam2Cwo6wbpr3zl72AnQA=;
 b=A7L5pl/mTTptXxWne2Ua8VwTtEZluZBXV+4p1x+TsmXwG9SiPXPo5PHBad1ECxv8LrJnnD+78NRS0aptsHtmQ04Dz+W4pKIfgrziJFQrSIe856BQaDe2XtcH18wXlAs0p1bqeGYitYbkWjRBAtQeylYePyASeLGoMQv2GqaQz8CHa0d4tDO+gllwTl9Jo2WlGOVPzBRsE+pF979FOWWUhxTNban1F8t5keyfNOVbLoR3Re8/3wOp/IsbjwfMHD06+CAnzfQwYs8H51B40RvTwGtUsu+vmzmsJETDVOX93gC40TD0aLtFmGRH64xUYDEhz+2swJAVvTzWNXi21NDhDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JyKnVcNB9bb9Oppe6x9bCVeam2Cwo6wbpr3zl72AnQA=;
 b=L/zlvVbdWP/lHwY82opBctSLrNhrP1QAuf8hUS0EMe7aObOxONeHtAamX0qD/vhw6ZLyGRSJU0puSplCe18oFliJQJnL9Vj0ejO9iSfB68ik1xec21M3JWFrYKtaqs4fQJnLYEzvBBo47bBYzPTCU8/UnqKdbxc+klAqxkOVs0NK/0fugXEZaWWv3HIr+VUXzyRu4grj04R1dhKyfPWDuqgrWWOzr8o8F62yag4wRShmc+b9pvuWpPO7VxMIh+lTTNL7vy1zXL2RG9pAYcOMZwprqaznQo1YZj94BYasAqfeXoWWBVfYoCc8xqVOqCbH3BymLipnKVo2K+cy6BPnvA==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TY0PR06MB5185.apcprd06.prod.outlook.com (2603:1096:400:21f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.7; Tue, 10 Nov
 2026 07:28:46 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0615.005; Tue, 10 Nov 2026
 07:28:46 +0000
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
Subject: [PATCH v9 19/19] hw/arm/aspeed: Enable the usbredir server transport
Thread-Topic: [PATCH v9 19/19] hw/arm/aspeed: Enable the usbredir server
 transport
Thread-Index: AQHdcOUfkhajqHuv+kaibtwV355Gxw==
Date: Tue, 10 Nov 2026 07:28:46 +0000
Message-ID: <20261110072818.2883349-20-jamin_lin@aspeedtech.com>
References: <20261110072818.2883349-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261110072818.2883349-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TY0PR06MB5185:EE_
x-ms-office365-filtering-correlation-id: 456e2dd3-e9ef-487a-cd41-08df3efc41c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|1800799024|366016|38070700021|921020|261028144727099003|261009223027099003|261021121427099003|261026140227099003|261026121527099003|56012099006|261022105027099003|261102130727099003|261102123227099003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: g83qVDL47Y/jFjihy98zSHjRmnh0DHkoDX5KZOaUlJvrnJplAZYVozaUr5nM0ml5mV+jSOySf4fVaex4C5b5r5+mrSnKawbmnHwkKIXPk9rFHYWSG5UXYicz2lHWFSGtWVvCyFmlpFnN1nLohzOaHXiV4c/NGCFK/qlqn3dHqE6PXO7QLxUB1A6jqaiBG3+CeuoknwpFtNxRwWTjTkD8bL0LaCDkFqUt5xsp0xMgangz+0kptsBEzyGY1YJg2voQHBC0gk7b9WXx5CSUlOe2HJOOiQmtXA7wsssiLv8j0xCJlYhv4lQAm3CYAj7ZfHdfYUcVAkS58HuX6A2UirjLdFsFVjxD8APTzA6JEu08Otk0gL2qgvGYJZh1BXzkseV4KVhOXafucsVrPs7kFu+Lw5nn811SZM+HpE4gM0CXPWWNZKKHgcnf8fnwKaq4XaWp1/UGSuWWvih0tnwPhv88IhW76BwI2aCP/sGZPzQEbH9i7cyBfGJ+eMl4r2D/SjLxywbnoBI5ssF7iG9MkXpuwF/J/XUx9/P3vg3TtPnCXCoTcHCGSeUYfl4lmlqPKWtU8Udzsu2BFOCEwMIvwpuFq6ug0ONbSgBywUAZ2wS7MhPoSRGvCeS5+tU9kCc2FSRhnY3XYGTZ6uJq9gtTersUnnJ3oeWQzx5D9sHTC+7C/ltPYX7+84vIxs+uwMkQdkTf7PzUCP7xUPRYtzgJ/ByjLgG2Ac7x72lYsTC43yUEwjtqP5PJFtHhLuJ3cd5kIqqd
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(38070700021)(921020)(261028144727099003)(261009223027099003)(261021121427099003)(261026140227099003)(261026121527099003)(56012099006)(261022105027099003)(261102130727099003)(261102123227099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?MeQ5gPG9Ujor78O3Y9SDth4gJTDbepPBYPI9VHCPkizKxHkqcgXWYuMY5k?=
 =?iso-8859-1?Q?Hx/xZRlo8YMhZ/sZnRUbyQDbrgNjWwb/6gAg3ElYi/2F34e4i+NftOaQpL?=
 =?iso-8859-1?Q?CXvBeMSM4ZBZJsUSTHXXaSlFDB+IR7xucIG1DOvS9GrBB/EQ3Xp1+3y/Cs?=
 =?iso-8859-1?Q?xmSKxCCD8IYr15lfoJScvFr50/1HZvKicqFdxq3mKFN3t0sdAHHIwt+jh+?=
 =?iso-8859-1?Q?BuoxjHcZR0qoWwGeUrFit/PD5l8X2Qxxa298OKID+VYedotN6mt+5kSwF5?=
 =?iso-8859-1?Q?FcIhwexR3ivePW8ymzKBhaHEfwkmb47tqmcet6C+QGBSn9zZteDVijS74L?=
 =?iso-8859-1?Q?j3cMudri3BEaTLnKuxhgLIe8ackCEwpF57IE75zG3EVxB9WUAQoY7m9Cv2?=
 =?iso-8859-1?Q?wDpRQQCSNS0kYfcslWPUXmnKTq1BOoEtNaGjF7akW1tfaisntMjC+3I8F8?=
 =?iso-8859-1?Q?eYiYqX/H1qExPfI3SaBrajQX6gn+fLxjoQ8nhGtXsNImsAVsUULDkcYu4x?=
 =?iso-8859-1?Q?sTZbDbBUl90ZGdE2MQXzwJv9zJ0xc7E0tCKBWfc+XPa2TsfLEjEwUxFEQI?=
 =?iso-8859-1?Q?idhc74d7sHVF7+u1VqkyFaMEcsjHOniMb1lJnMsg1n9pbI6zUS+M/rnOve?=
 =?iso-8859-1?Q?ykDaaL7f6xCf9v8dzI+81Z7DPQjDFZyjm1aY+2Oi0RRSRNAAmtpu2MzwIu?=
 =?iso-8859-1?Q?8XRql3Ian7Itz/W0D4n29dDX1VXVRHbkpPJN2zTeipPgmII/h2JJMm/lpC?=
 =?iso-8859-1?Q?wWfL3AjL0ENqBjH8Oz6Cm9Hv/p/KeKYtWtqT/rS40Iy/Z6Ju9DGORl2ekz?=
 =?iso-8859-1?Q?SAKLIQkJMYj6ZMSH4QhwabodNfFTVR86sID4eG8luwczE94NOe5LAF094z?=
 =?iso-8859-1?Q?QkOlo63txK97k3w1H7Y4G/rnnTCqhJM0n6Ops5SqncJ0YSmGGBicKBIuEz?=
 =?iso-8859-1?Q?eN1XvcLDSzxyqKIO/ldynvdA96tgHMQshpkXQQhncB7we4VoofRvxD8b/O?=
 =?iso-8859-1?Q?iFvrtqsyP8FsgpOpbCLvPYxBKsrb0B3wPzlUrta+T2T+eJc+G/6Ja+Kemk?=
 =?iso-8859-1?Q?kbv0eoyxFXWlJk+OqBV6ocBmgfcDtiUPP8++e6hUxodEpxN+IM65hDywuc?=
 =?iso-8859-1?Q?imFBInMfHUD7kEqyWFzCBw99TBFKhuuR+ufnGK92kRbv9oUey57p02SoGY?=
 =?iso-8859-1?Q?fpiHvsrjfXlBUejmQa/9lfyWV2xowLwJPtasB6x+wBpy1xlg2rVghfGhzj?=
 =?iso-8859-1?Q?UrlSxzbFp9aFePgxDDqSMNGINdsoeeHWyS/JZBF7OvRMFZwBm/YFEg3NB3?=
 =?iso-8859-1?Q?ghzOCQBV2N5cqLUCuBcQ8JMSPyzjIBr2synCYppgXk1hV8i14hBoV0it2m?=
 =?iso-8859-1?Q?14GIn0AIHDu0QOLn6Dh4T/JZw4jXcRxcN8u8t0MUmcaZWI6VwqMOLMuh6R?=
 =?iso-8859-1?Q?dEjaMm6kR3jO64QLZcLOLz/dfU3JfBtshGe0646/lP/mt7ItMuYNj5XmYX?=
 =?iso-8859-1?Q?mLg6nBb+NXmmQFP4+DPOWzGwZSW78JpmTmHtKy1EGw3SOG7g9lYtFwATzB?=
 =?iso-8859-1?Q?iEudPSIsXwEr4M8XMlPwMtJJT1gGJiL5yuGHU3uWS2EsRRxfNgJXcTzJtY?=
 =?iso-8859-1?Q?gkMRQFC8MQmp3RgmjNl6TnddTzwH5ahayzE7gDM++5XAb8JBW2VtkdZ/SN?=
 =?iso-8859-1?Q?DUCYGu2IVELwZu1ICgXBUpXkhK56dm8NTrGWI7np2kxuwhppVqUDK3xZGl?=
 =?iso-8859-1?Q?vVVhR2l2XtaT/4XMYuU6nFWEDvUs6rz1ZN1AsAcduMaEjNVRZUOK0Ap6w/?=
 =?iso-8859-1?Q?Wl9ww9u3xw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: g3+Hw3mbJeFB/BfrloqHNMZWuByECnum6UdVofHSJ5QsSEv9lnqXrcsThoe1lFyUqhsd84Ven430a0ZT+CVIUMlsU3v9XwbS1/vTXYm8Zedom9XBUhcvKLmmz6wxVYsy2w+EmDMkb/08Eb8ReARwfx28NQ/v87igL9LytvHeakSkQOSw44r8vQtcMMgGtmB5P2EcfbeofDEJDD78MddWXJxUvXk1ttGkKwweTslOyanSBrjIaBQHN+zoqJdudGrL4pbKOEPRpIl6fXCaIih12t76UrnhJIVb33glHRzI88QJiPjA3YKa6DJrO9giFvqR/OOsYl7F9rwLJqksRSMm3A==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 456e2dd3-e9ef-487a-cd41-08df3efc41c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 07:28:46.5567 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HaKrVLauQRQfgGUkKhor0lkzi3vENY73XX8NxzDHR/hL0rrKxEoCU15YKZJJ3+EBebdIHPGeXOC2Y4kSkG1/l6xP0jAqUOyCaOrbZhb9A9s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5185
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

