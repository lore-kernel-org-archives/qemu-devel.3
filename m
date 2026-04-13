Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99557F531C7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 19:01:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCMWj-0005lb-Qn; Mon, 13 Apr 2026 15:00:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1wCMWN-0005j8-C2
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 15:00:34 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1wCMWK-0005MP-AX
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 15:00:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yI5wVgpApNCEDV2ZqsKrtfdflyzl92I59+kjGaiHnj/1s8IDKicteuIKIDrU5skO+qH7u/+G8PjJTJ1wpkCyESxeyDt3rgdP7dIepQTJdoy7jALicCM3pMm9AKBcgcNEExrtU+V1fXJsNsHyuPedCZ+p6hHhYBk0B7wzfanIkhtOYdoWucRnJIP86QWz62wpVo+PtzydXtk/fa5i6JtFKBuB7a659hC/s5gYuVJtMcPTv0xXu1GK+brhn40UM5nKQL6yElzCEnkx3VLbWf14UDKbPTDjHC9vaz2IbP7se8Q/ZRrclQLI72nvIKgqk1Pi5On2nxUEjqRJNzJ4Kt1CYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SMy7lECE0sVAJDvxhlcfyEN6b0MtHQM83d2EqFin1n8=;
 b=iySxV6iFfym0yATkIJ9iv5qSUMy8OpngyV5Yv2K7P4h9Wrray7gUIL0NG5vrlvKJtaofpfyFKqD8ZBWj0knONP3ySGcDF7Um6Qm2hntDa685dO5tM5lRt+TNAQ987c4eEVQ5mizfuB8PUAAHN6GPmTibTufviw9A2BO9yiy5m4QrvTlizHXUu3Z01+iKJgYM1eWe+S5QNO1JfApo1QziziNlkfUnHvM0FBLatii5QgvidgYsaa0kZABDQ0dLokYeDMCUbIE32y/DfdJwmzylXnW4IrOoXB2ml3vGoSOEAkOdJndGz+mqc28fzq1zCEoXm0OZLvQ8X8MF9t492icpHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMy7lECE0sVAJDvxhlcfyEN6b0MtHQM83d2EqFin1n8=;
 b=L1m9C9ED78Ra+2zX6KEv2zmdkq4T4IPqDIs8M8mtGZZUoMK0IDqEH/+qoFI44kxGwG86jLnn1CG8BFpbR9lZSurkAPZuKA3uHaP4U8DV0xfGsxcAdVOmhV9F6Sb/usas1BnCkrRsTODbdxFIMIwmIzQcLkiQMx1Og3FazcPBY7uIflGNlmYTRLALUNoGPGKJztV8m5XpPlz8v8sQ1B77t6Ex7EP0V44QQfaP9G7VPjOzmg8Wd/22vAa5AngAnxALadzBAr21RjMPvxTru4RE2HbY65+oA6Ypp3TEs4shbtTYRSEciEbFPrpS7619g54IsfHvP8aDgPvNljV3DYg4hw==
Received: from AM0PR04MB4370.eurprd04.prod.outlook.com (2603:10a6:208:6e::32)
 by PA1PR04MB10295.eurprd04.prod.outlook.com (2603:10a6:102:447::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 19:00:22 +0000
Received: from AM0PR04MB4370.eurprd04.prod.outlook.com
 ([fe80::fe3b:fb2c:9dfc:9b]) by AM0PR04MB4370.eurprd04.prod.outlook.com
 ([fe80::fe3b:fb2c:9dfc:9b%6]) with mapi id 15.20.9745.035; Mon, 13 Apr 2026
 19:00:22 +0000
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: Bernhard Beschow <shentey@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>
Subject: RE: [EXT] Re: [PATCHv5 00/15] Adding comprehensive support for
 i.MX8MM EVK board
Thread-Topic: [EXT] Re: [PATCHv5 00/15] Adding comprehensive support for
 i.MX8MM EVK board
Thread-Index: AQHcyxhq2POQGlihkUmOWoImS6Nbv7Xc/V4AgABboCA=
Date: Mon, 13 Apr 2026 19:00:22 +0000
Message-ID: <AM0PR04MB43700A10A6F9E20DE479701887242@AM0PR04MB4370.eurprd04.prod.outlook.com>
References: <20260413073737.986219-1-gaurav.sharma_7@nxp.com>
 <9BF9D1F9-DA94-41AE-8C81-2226B17E096A@gmail.com>
In-Reply-To: <9BF9D1F9-DA94-41AE-8C81-2226B17E096A@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB4370:EE_|PA1PR04MB10295:EE_
x-ms-office365-filtering-correlation-id: 762db446-64a8-4dd6-1051-08de998eea07
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|19092799006|366016|1800799024|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: OGUWHtGoi6HjwTDn0JZqGlGn+Jtd9U0dTlWDx0hXDiWlxZERuIMCQhqE+80CjJc4xVfOLEoz1SEMzISX6YAeA/WmXpnFu1GyghjrY6f8bVh7ec9T38f/nLyMZac8KZ/Ox1f2Wmivf7tGw85u0Dfuvs+LO1TOZ8zdUiGttUw5K+29cgp5A3lkzYq0kvkvFWVSItGIqvVpfQuJVRlNKuURO4IaR08kJ6EAOPMM2Pi56Sau/fKBzBLjOhyJwgPrzkCvBQ7HRiwfhyIJy5maJi2/bPVdIeNGPb/V2wnzMFGxMjimD/88Kqr9N01FGhuHfZ/To/8Ki/qngamjNLNFkn/qdNH05ZlGsLrpHULC4rVc62O3Ms0DevEFp8IdQn7K0RGmGRhT1aC6R0uaEClepRuIsUeR4Okb+UrCFA7MszqewOpbz6tmeG+iT7R+6sSHS4RaWRBb25XxNnHmcNfwLgikpavQdKcLN91ZsBhGPaSAUONdy6CjLiOyhZA/1r+QtSs/x5na3z73bP3zmcgjTf8/nPeWx2cYQqA/2sYofX11vn2UAtNDMGsvQpceeDEdL7aKJtpmM7HMEBwbBrRFijYftAvwuzteMbL5FM8EtJVKaXgithxSg4SlcKf90d6lFtn4F15rCeP3G+oPnkUO73ksac3JoZKnHJQ9SM/KDYwo9GYegOzXFP+eKuaxW7xlnKynGovWTgxTUY9ZA5rrIMoTd9oalaEqgkmV3aNYtJ5teR5kb9bV/VdgOv7ggb+IfobK270+/iYoIWnrTla1yRjXLGqd4RIWiZEsdsHuD5UoNKM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4370.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(366016)(1800799024)(38070700021)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?r2B49+3Fw+CGCxnv4LGAUtAZZh3hsFas4qlCNWEBp6tgcTniwSHdcD6A88Yr?=
 =?us-ascii?Q?gODGX2Xa8BVoFbdW/4zH03yffGwPRKbUaiOA9yqAWLBu7bHq58SX+c18XHUG?=
 =?us-ascii?Q?V6ki5CA/UdzF0jbVf2MQ3PgI0pOsZdgXU/JU1hM6ED1IbBH7YyRyHp30MZ0j?=
 =?us-ascii?Q?+fwrw8BOZAe6B0OvXsOjb5N5EBLsoHThL+T8rbftBhEigTTmWuKwZHXh6UQm?=
 =?us-ascii?Q?RrOcWx+xd1aM/meQNpuUR8fZWPkZkl/2GnmcZDqjyEvHxA3/mIutc5zgODYf?=
 =?us-ascii?Q?BdBlW4dDbV/2xATH2u5OdwdHaBxnJx2vUefWTRkWO/dyL6VmXKEWSnLjprZ/?=
 =?us-ascii?Q?2KaRlfaOjPMZEN9K7VjFc4nazEvDGh00u6nUpvzyAhXHCADpdz1hDGw15Zuq?=
 =?us-ascii?Q?aqZirhk+CX5dwSZ8Vflrebc7/Gl5rvBIBvgcshd4akmqw959ax0EwVIz7N1I?=
 =?us-ascii?Q?WAECllah0xTDSMV0kjrKR+6ksOxZ651K8LhGKUeg7PzjCqzk9SfH6ik4nXWf?=
 =?us-ascii?Q?+Jrd00Z+HSrYhfN1vWi96gZ1xqLzv2XP9WbIwmKSGbqKKAs/t9yb+2ylR1Y9?=
 =?us-ascii?Q?NGTz0zQ9//S83mv+/hJxJNfbnVC1ZMQqi8jy8dbtSu0kCETxxwOvXUWC6Ui8?=
 =?us-ascii?Q?CvnuAunv7GBclHn8g7LPoSXD0EfViD8y8av78jd0uNk9XjFWIhc3tGxTIdo/?=
 =?us-ascii?Q?6HV5uEGD7XQm548acrX/eUQ6g27Luu6GppCpPWUz4r+fZL6kp7RxdDt0SQ74?=
 =?us-ascii?Q?dtRpJOtAY0c6VLmrfr3cygvuCpuYcL+gmxh7xhQ74+qejZbb/prdVWNHDV6h?=
 =?us-ascii?Q?nfSrPfzNr2sPkuAoTc1rbsQBR6Jf+ySwenPQCcim9ThPs4k7lqlirdj9yjrM?=
 =?us-ascii?Q?Y176traAIM8ADIOAKmzeCfWmYTiS20vVw9UT8MhbJctNGXIw5zZwJA/1OWUt?=
 =?us-ascii?Q?t7PAnxPSfQ3Ht4EVXZM7KRHehHVBg5VrY+mRRlg4ncpwfTBuSfzCu/jBBDeL?=
 =?us-ascii?Q?brxQHXCmfFPlne42jpDMuXPETgoK+kcNdXsL5uOvmdTvpqtSTZnn97swtrg/?=
 =?us-ascii?Q?QSYGyu3pyR5M4l82JgRc4JY/vN4zu0+M/22kuyk+Hh7AkEw71A/WSPTpE8RF?=
 =?us-ascii?Q?A/1Z+D7BeEoNNF6eCRplLi3eRK9xXym4CsuTb3JLXqdW4JZBlmy7qf5rmbEK?=
 =?us-ascii?Q?X6yVGqpeIsoP+8l67zDOGdEYpJr8wNRzM6kAykbQJs3tuvx2EbVvJ+434R5O?=
 =?us-ascii?Q?jIiZueF4uGLjpgRlmOruOtHXlSqI/6s2t8HjyLh7abBlx6/CjdaV1dy2IqV+?=
 =?us-ascii?Q?QggXdLDLJSl/5Qw+vbDMETIU03HYWF+XYUXqQfKbgBRt2kubEAQTf2kjncvP?=
 =?us-ascii?Q?hLAUGE8ZLYpvlTY9Sj0RiNeyWzWkDkPJvNr6Sneb8D85ex/TzbXYDFcCSwPJ?=
 =?us-ascii?Q?+EblflGUwESk3b06vEtmb4BT43tbVgetu+VZO+arZM+tQZJwu87HaIFzdukr?=
 =?us-ascii?Q?XnQCCoH6ezYITIYOvy2gbLbhaJLb+S+8sNTgEUXdyvpsy8pF9zhA5+IY/boL?=
 =?us-ascii?Q?Z2cPliHcgqRrCXQqEhguQiEmNhQeuOUj0+NHa52ONKoEsKMhtf5RefWc27c6?=
 =?us-ascii?Q?5Y1hheqWzKg7F5FxnrC4DIxgEy/d5ENbxkPU9j11mUj/pXlsd68eH3M7wmMz?=
 =?us-ascii?Q?tB+s+QxCdcXUhMNTbw642KsNPGKL/NlwtLXvFmk/0CkFYEn/VMGrsjzgOufJ?=
 =?us-ascii?Q?3Dj7pdEi9Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4370.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 762db446-64a8-4dd6-1051-08de998eea07
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 19:00:22.3767 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ziUJMJpq2B7Icshiv6SyjxbLgMAWz2C+zWhaIcAIEdz7yvHmlrByCT701rW54GjXVygLD1YdV1fmnJMpo6f+ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10295
Received-SPF: permerror client-ip=2a01:111:f403:c201::6;
 envelope-from=gaurav.sharma_7@nxp.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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



> -----Original Message-----
> From: Bernhard Beschow <shentey@gmail.com>
> Sent: 13 April 2026 19:01
> To: qemu-devel@nongnu.org; Gaurav Sharma <gaurav.sharma_7@nxp.com>
> Cc: pbonzini@redhat.com; peter.maydell@linaro.org
> Subject: [EXT] Re: [PATCHv5 00/15] Adding comprehensive support for
> i.MX8MM EVK board
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> Am 13. April 2026 07:37:22 UTC schrieb Gaurav Sharma
> <gaurav.sharma_7@nxp.com>:
>=20
> Hi Gurav,
>=20
> >Changes in v5:
> >- Fixed SoC object reference counting by using object_new_with_props()
> >  instead of object_new() + object_property_add_child()
> >- Merged imx8mm-evk.rst documentation into imx8mp-evk.rst to avoid
> >  duplication and updated the title accordingly
> >- Added on-chip RAM (OCRAM) support to match iMX8MP dev
>=20
> I tried to apply v5 but I'm hitting the same issues as Patchew:
> <https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatc=
h
> ew.org%2FQEMU%2F20260413073737.986219-1-
> gaurav.sharma._5F7%40nxp.com%2F&data=3D05%7C02%7Cgaurav.sharma_7%4
> 0nxp.com%7Cfbdcd381f0014ebd086a08de9960ed16%7C686ea1d3bc2b4c6fa
> 92cd99c5c301635%7C0%7C0%7C639116838724991885%7CUnknown%7CTWF
> pbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4
> zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DnyynvYO
> v87nTkxEFkU8k3eSt4r%2Fa17rQkr9STABgaaA%3D&reserved=3D0> Mind
> resending a version rebased onto master?
>=20
> Moreover, you may keep my R-b tags which I've given during v4.
>=20
> Best regards,
> Bernhard
>=20

Hey Bernhard,
yes, looks like I need to rebase and create patches again. Lemme do that an=
d send over as v6.=20

> >
> >Changes in v4:
> >- Update Maintainers file
> >- Re-used iMX8MP CCM and Analog IP for iMX8MM by introducing a variant
> >  specific property
> >- Split up the patch that enabled CCM and Analog in the previous
> >  revision. Now we have 3 patches to enable CCM and Analog in iMX8MM
> >- Updated copyrights
> >- Removed '|| KVM' from hw/arm/Kconfig to prevent 'make check' failures
> >
> >Changes in v3:
> >- Minor documentation change - Added KVM Acceleration section in
> >docs/system/arm/imx8mm-evk.rst
> >
> >Changes in v2:
> >- Fixed the DTB offset in functional testing script test_imx8mm_evk.py
> >  and preserved alphabetical order of machine names in
> >tests/functional/aarch64/meson.build
> >- Fixed a typo and updated the documentation
> >- Modified structures type to static const in fsl-imx8mm.c wherever
> >  applicable.
> >- Added CSI and DSI nodes to the nodes_to_remove list in imx8mm-evk.c.
> >This
> >  is needed because the default DTB in the iMX LF BSP images have CSI
> >  and DSI enabled. Developers/Hobbyists using these BSP images will
> >  observe CSI and DSI crash logs on the console since these are
> unimplemented.
> >  With this change, both debian and iMX LF images will boot up without a=
ny
> issues.
> >
> >Changes in v1:
> >
> >This patch series adds support for the NXP i.MX8MM EVK (Evaluation Kit)
> >board to QEMU, enabling emulation of this ARM Cortex-A53 based
> >development platform.
> >
> >The series includes:
> >
> >1. Core peripheral support (CCM clock controller, Analog module) 2.
> >GPT(General Purpose Timer) and WDT(Watchdog Timer) Emulation support
> 3.
> >GPIO,I2C,SPI,USDHC and USB Emulation support 4. PCIe and ENET
> >Controller Emulation support 5. Documentation and functional test
> >included
> >
> >Key features ported:
> >- Basic boot support with Linux
> >- UART console for serial communication
> >- Interrupt handling
> >- Clock and power management infrastructure
> >
> >Testing:
> >- Linux kernel boots to console
> >
> >Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> >
> >Gaurav Sharma (15):
> >  hw/arm: Add the i.MX 8MM EVK(Evaluation Kit) board
> >  hw/misc/imx8mp_analog: Add property to analog device
> >  hw/arm/fsl-imx8mm: Add Analog device IP to iMX8MM SOC
> >  hw/arm/fsl-imx8mm: Add Clock Control Module IP to iMX8MM
> >  hw/arm/fsl-imx8mm: Implemented support for SNVS
> >  hw/arm/fsl-imx8mm: Adding support for USDHC storage controllers
> >  hw/arm/fsl-imx8mm: Add PCIe support
> >  hw/arm/fsl-imx8mm: Add GPIO controllers
> >  hw/arm/fsl-imx8mm: Adding support for I2C emulation
> >  hw/arm/fsl-imx8mm: Adding support for SPI controller
> >  hw/arm/fsl-imx8mm: Adding support for Watchdog Timers
> >  hw/arm/fsl-imx8mm: Adding support for General Purpose Timers
> >  hw/arm/fsl-imx8mm: Adding support for ENET ethernet controller
> >  hw/arm/fsl-imx8mm: Adding support for USB controller
> >  hw/arm/fsl-imx8mm: Adding functional testing of iMX8MM emulation
> >
> > MAINTAINERS                                 |  10 +
> > docs/system/arm/imx8mp-evk.rst              |  33 +-
> > docs/system/target-arm.rst                  |   1 +
> > hw/arm/Kconfig                              |  24 +
> > hw/arm/fsl-imx8mm.c                         | 704 ++++++++++++++++++++
> > hw/arm/imx8mm-evk.c                         | 130 ++++
> > hw/arm/meson.build                          |   2 +
> > hw/misc/imx8mp_analog.c                     |  12 +-
> > hw/timer/imx_gpt.c                          |  26 +
> > include/hw/arm/fsl-imx8mm.h                 | 242 +++++++
> > include/hw/misc/imx8mp_analog.h             |   3 +
> > include/hw/timer/imx_gpt.h                  |   2 +
> > tests/functional/aarch64/meson.build        |   2 +
> > tests/functional/aarch64/test_imx8mm_evk.py |  67 ++
> > 14 files changed, 1251 insertions(+), 7 deletions(-) create mode
> > 100644 hw/arm/fsl-imx8mm.c create mode 100644 hw/arm/imx8mm-evk.c
> > create mode 100644 include/hw/arm/fsl-imx8mm.h create mode 100755
> > tests/functional/aarch64/test_imx8mm_evk.py
> >

