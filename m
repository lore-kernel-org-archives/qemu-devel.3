Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71490F9D0DA
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 15:58:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCg9H-0000UA-4y; Tue, 14 Apr 2026 11:57:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1wCg9E-0000Ty-IG
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 11:57:56 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1wCg9A-00013n-Jc
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 11:57:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NnmGND4xcjC2hBrPvZ/9KwkNrSXJTYeR5Q1QPDUDHYoMeEWP7rT0r3rfYEVAo8edKCsEG5K8NGFuB1gI4VNCFNCZgwiEm9u6eG5Xf0nkyhcJFasKhON3MWFHF3rNtJmsO2vqlj/8IZO4mp7rd/FhcrG/rO+R9d5wv3MT5zoKBZbLUc9R3x2ZDJ4cZGhUZGmq3T3ufndlUagaAV0405eA9bOt7f6gOXyWauo67qXMC5rd7ilZmatj9A5XI2Psvme129KAdgfFyFk95RR6mwCE/6wsRA0kZZrbr4monhOeYkmjcOzZNxL6L/38vaAeUhgzisGdYAvaErY3d3eVQppSQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y4JFwN4g4++YGAWQ7rS10J5NGyrrR8h5/Qrwv0FlooE=;
 b=RVDPSVaCJGfOobJWxHpwbRSkjcFlpXX6kFLWwlAmKkIx+hqccSmmfIiZks5dO7IcsAO5S4T6Ljfo69lNCEDfFmFruA4vD4K8yl8IS/VQ+9TMzLow2M5GJsHA/LrzRp8y7/KDdWMW8cCV8+BkWyQZcyWQ+Yz/H1yB9+IH0xgjYYbzoOrMzXEEyrEPg/xQDi8yM36ejvOfr6T3OKXHoEvZSJfIiId7x2D4VDFXM2fW4g18L156OJjlb36SQ/2o4pU0iSKyFH1+Ciu65No+ygGMYuomTBdPEcE6uM2D1Tw/ZHf2CUvTHdpCG/nE9Bs0757TpNTzqNlfqR4+xuB96mes7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4JFwN4g4++YGAWQ7rS10J5NGyrrR8h5/Qrwv0FlooE=;
 b=GhAbZq+DmsICYWkc8BXXHoZTdMT3gA8asqyCsa9xteydtTjhV3KlT1fVW4uoiI9yvIlfNUtlLDeSKAuR3lD6iiry7uRlqQedQ0AKbuZTSpMYA7ZXyTRHUjzDIJv1ktTHjkg/h1oVoieamcpae2qAO8thscuQgzgE1kDwGUXrzyC1ZncohNdtBkeYaxhldxRSIob+ManB01iJ1RIhZSVQTckhE9SUXrwZ/MrHJ3zMWGvWaS1igvSsRvJ2vsh7uv8ES2iS16JSY87WryplNKCEMdboMwbIhmKI9UDDHztF2UsQKhYOtJwnlLRnL7/gv/dXWaInTI5w2F9kjx3BLJvrZA==
Received: from AM0PR04MB4370.eurprd04.prod.outlook.com (2603:10a6:208:6e::32)
 by PA4PR04MB7694.eurprd04.prod.outlook.com (2603:10a6:102:e7::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 15:57:48 +0000
Received: from AM0PR04MB4370.eurprd04.prod.outlook.com
 ([fe80::fe3b:fb2c:9dfc:9b]) by AM0PR04MB4370.eurprd04.prod.outlook.com
 ([fe80::fe3b:fb2c:9dfc:9b%6]) with mapi id 15.20.9745.035; Tue, 14 Apr 2026
 15:57:48 +0000
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: Bernhard Beschow <shentey@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>
Subject: RE: [EXT] Re: [PATCHv5 01/15] hw/arm: Add the i.MX 8MM EVK(Evaluation
 Kit) board
Thread-Topic: [EXT] Re: [PATCHv5 01/15] hw/arm: Add the i.MX 8MM
 EVK(Evaluation Kit) board
Thread-Index: AQHcy9DG4Tq2c1qndki/HWXadYKLu7XeiFsAgAAtqYA=
Date: Tue, 14 Apr 2026 15:57:47 +0000
Message-ID: <AM0PR04MB4370D4D69523579FA7971C8A87252@AM0PR04MB4370.eurprd04.prod.outlook.com>
References: <20260414053715.1378021-1-gaurav.sharma_7@nxp.com>
 <20260414053715.1378021-2-gaurav.sharma_7@nxp.com>
 <D981B877-F5F8-4873-B241-AE20CA354410@gmail.com>
In-Reply-To: <D981B877-F5F8-4873-B241-AE20CA354410@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB4370:EE_|PA4PR04MB7694:EE_
x-ms-office365-filtering-correlation-id: cc2e5d27-2874-42dc-c5ef-08de9a3e9317
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|376014|18002099003|22082099003|56012099003|38070700021|18096099003;
x-microsoft-antispam-message-info: GcHCGvhItPu+IaUHj8967WLkVRtLz7Xe+278q9czHBDdVASntDOCvra/f3Bf2G1kOk1OHOhewtYPKQNLhvrFhZgm+EPi2zjOEAPsPUNuKDH7962tIxFSfG8yPWjAyGzJpzuAoCNFFntVUla3zdli6MAsaDBK2fuWBQGfcUnMG/xThc8jI3s8JV6bS7lksb+DrIvoU+yiUY2Yr3IwUDMlDsgZUvh6UXq0KDEr7MTrKRyxOfR8pZnn5KR47IH5CYnHM9nxWtxHJ2yg/ih4XO5zGqG9phrJdwnFkKtbplf8aP3Z1z0sYhT99tSt+/xd/NfCSxSwjbrhwDA0Z9z29AfoCqVXBgfwnrwyzhT9ETRrlN16ID9x8qXi1Hkx/im/oaKfrG1tK90lMt0sbBMffDu4k+3NCfbwPF9lz2HVUzAHYh3Y0ZLbEQAcbH9qlV4zOMBT0wpMMEhsW+MPupuRcKr79PVK0GlvsQYR/fwG/QlcyBavj7IzHfbLhk7H0r3l7+BWKaoz/4Un8clgkkRtWqBV4QKgw9lTYTxhN0CToa9b7mM0nnOnNU4Gwiu6vyoOjMhAldccs+ofs3LFgk/mefZlDgtjDyvj2fJ0O8ov8xMsr6jR5BYgVNO1gU+V0zEvlnxKa7jZhfTHWke2yYL6zFOnjidM/wptrpcvn/lh4CkZc0PuyZmcvYzU5A5Yk3Xvc0zVjo9kZnz6LPsn4xsvIVCQi2m7NPOHHJZNpZ6uizsan2RlzR73mqVRFWTmkzwDP7QSl+CCQpJkTHiUlcOgnfyR25tXrplqPEVJNroPMtemEq4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4370.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(18002099003)(22082099003)(56012099003)(38070700021)(18096099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iLSm/rO+1WD0aG7i/H0ELZlOsypy6SGg42HPzqExAdQVwxZpkLtTPEA2WnVi?=
 =?us-ascii?Q?oiszP9a7SC1k7hQ/yC22iZ5YDqkvnZU8ka2fmqgsmHgbp+ptrq2gVx5wqWfg?=
 =?us-ascii?Q?AIv75wSx8PwiJH5yIZm+ewYVsQ9uXV2wY8cZqUacCXvkqcInuYwicAEqvttY?=
 =?us-ascii?Q?fHnH/6CS/3liGWumJ2uVgEHFFrofax9+hs6DBOBbhk4sXwatZZ7BrzDecJMr?=
 =?us-ascii?Q?hcX32FznzoMvDb2kdSQ5GOlNogdTtgmeNuA587WIDATUqRyUTWocn9BZF4g7?=
 =?us-ascii?Q?JsjXhKsgKBODfvL/2oUwT8IwOZAufHhm3SprrF6RmSihc6eMlL9HF1/lNbLp?=
 =?us-ascii?Q?Py4euqzP09nx7QDQ+ulE7t03DREMqU5q2uTcOSxUYuN3lmyN43Usz7hqXMOP?=
 =?us-ascii?Q?TGKxJzhwZc5buB/Vh3kcBbD3/RdNhNrdI+uGQA0SwLtTjF7jTaVVWTH6An1M?=
 =?us-ascii?Q?b1Aw5FaNCO6KjmV6mG7JlYK82siQmJBHIQdAE+5sfzz3nN/A/am7g1FxhVCO?=
 =?us-ascii?Q?HsVKV6iy1uefO8bfnRDzdSGaie8mzAFJ+GShAbeB8nuvE5cc0W+6CSt6Tb5X?=
 =?us-ascii?Q?0iKBy4z+5s+LqZonoIksKUSlU7ij+79VVuNMN4h5PsutSB6s8mX06dTYx+/+?=
 =?us-ascii?Q?rUz3eZ+FKjCRoVB0fjZAMiR75IrTHX2Qw7kuVsBVq2egIeftRoEADGRoliJo?=
 =?us-ascii?Q?vKdaFc9pOAHGV6LLEPzI9dViC5Odl6ocA1Q0MJc/la/WtkPc4lKdB89LM+PQ?=
 =?us-ascii?Q?wlQVN8XUDY8lTv9K+LVCQyMgGWEp9mq9nULE18G14x2iTe7UPta0svEv+VBD?=
 =?us-ascii?Q?vNKbAWy8gxT2AQ0ENcy1fuHMhEgGAEPZrPYEX5C6p0dFReFkc59CzXgDrgUb?=
 =?us-ascii?Q?VpjMLLNRrBFEMi3pb6ZF6vP8ZIoUlejt3MY470OBRY3EZ/NpoSSNcNMWrzeo?=
 =?us-ascii?Q?bWuhXgb1vWkKefqlChGAAzaA4wvMvTtvn6UReC/kduI7h/3EUSeMsnEqU3rk?=
 =?us-ascii?Q?QizvXHXK3JDvTxXZVB1t2DIu3OmuTHBrrc9/b+hSudnuObkOmcHdRfMdtKU/?=
 =?us-ascii?Q?Bc35BvLOt+Zul9sDRsTbnr+dhwRWcThoz3PqEmaG5n6zuU9ouVPE2qUE5FWD?=
 =?us-ascii?Q?7WP3xHby+wXgSyXkIvEel2hRM/z3JfmjcjhvVVJbdqaA58nbz/QZp7+d4lS9?=
 =?us-ascii?Q?kA9X+XinkFGXG0zNC4cscVq44n277J+Jj58T6MVJKSWRlb3VJAh45SOISMES?=
 =?us-ascii?Q?yx8vXRTkQGwcDOPCCHxZhUTW6SB5yxSOynacdqt9CJZ4haYtjcOULl19GzPW?=
 =?us-ascii?Q?NZ8ewyG4Ven09ZCywbcnMXpS4ZLoZryb36MIuBUOnSDb8uEzRG7TJtEEiUSD?=
 =?us-ascii?Q?hvBe7lH/ZuhMT0ZXxglJXHuHEKK9+C7DlWaMKVsRPZrdGLK+X0KlH69b+QTh?=
 =?us-ascii?Q?1UIw5Oo85q2Dlx1/lxGfCfVtRDCV6hYcq08Y6MpcshDo4A/YxOsZ/KVGe8i+?=
 =?us-ascii?Q?EsJQyTBe+9kzysR5EdXBQop0EnVZR5hYWOBbi9ZnFxNhi5owzwpu16qNfEZw?=
 =?us-ascii?Q?kDKPEW49TSz+g5wZqWyDElHzjxmVy9CjWBApojxue8e9NrVYl6oRWMYunI0P?=
 =?us-ascii?Q?xt0mWsfwDGXHq47Jy+9S7cxklUGGFLIF0GHWHP3L3Rdp0NdzxKmF8/Wx3Oz8?=
 =?us-ascii?Q?/aLZe2jXk81ih5yRgpUwEd5r0OjzrV+HyRaPTHe1jnuBkFdV4eSbJskL8Mns?=
 =?us-ascii?Q?P3RaI7BHoA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4370.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc2e5d27-2874-42dc-c5ef-08de9a3e9317
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 15:57:47.9191 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JL9h7Z142wVLahoNSCV+lj0f/gDZVt13TIyUZCTkJK9Id4jQOb1IFUIX+nriuvUBKqEVNE8VRC0XHJjQFUTY+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7694
Received-SPF: permerror client-ip=2a01:111:f403:c201::3;
 envelope-from=gaurav.sharma_7@nxp.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
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
> Sent: 14 April 2026 18:40
> To: qemu-devel@nongnu.org; Gaurav Sharma <gaurav.sharma_7@nxp.com>
> Cc: pbonzini@redhat.com; peter.maydell@linaro.org
> Subject: [EXT] Re: [PATCHv5 01/15] hw/arm: Add the i.MX 8MM
> EVK(Evaluation Kit) board
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> Am 14. April 2026 05:37:01 UTC schrieb Gaurav Sharma
> <gaurav.sharma_7@nxp.com>:
> > Implemented CPUs, RAM, UARTs and Interrupt Controller Other
> > peripherals are represented as TYPE_UNIMPLEMENTED_DEVICE Complete
> > memory map of the SoC is provided.
> >
> > Set default RAM size to 2GB and default CPU count to 4 to match the
> > real i.MX8MM EVK hardware configuration.
> >
> > Documentation is shared with imx8mp-evk to avoid duplication.
> >
> > Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> > ---
> > MAINTAINERS                    |  10 +
> > docs/system/arm/imx8mp-evk.rst |  33 ++-
> > docs/system/target-arm.rst     |   1 +
> > hw/arm/Kconfig                 |  12 ++
> > hw/arm/fsl-imx8mm.c            | 377
> +++++++++++++++++++++++++++++++++
> > hw/arm/imx8mm-evk.c            | 112 ++++++++++
> > hw/arm/meson.build             |   2 +
> > include/hw/arm/fsl-imx8mm.h    | 158 ++++++++++++++
> > 8 files changed, 699 insertions(+), 6 deletions(-) create mode 100644
> > hw/arm/fsl-imx8mm.c create mode 100644 hw/arm/imx8mm-evk.c create
> mode
> > 100644 include/hw/arm/fsl-imx8mm.h
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS index ad215eced8..cc64d57342
> > 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -916,6 +916,16 @@ F: hw/pci-host/designware.c
> > F: include/hw/pci-host/designware.h
> > F: docs/system/arm/mcimx7d-sabre.rst
> >
> > +MCIMX8MM-EVK / iMX8MM
> > +M: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> > +L: qemu-arm@nongnu.org
> > +S: Maintained
> > +F: hw/arm/fsl-imx8mm.c
> > +F: hw/arm/imx8mm-evk.c
> > +F: include/hw/arm/fsl-imx8mm.h
> > +F: docs/system/arm/imx8mm-evk.rst
> > +F: tests/functional/aarch64/test_imx8mm_evk.py
> > +
> > MCIMX8MP-EVK / i.MX8MP
> > M: Bernhard Beschow <shentey@gmail.com>
> > L: qemu-arm@nongnu.org
> > diff --git a/docs/system/arm/imx8mp-evk.rst
> > b/docs/system/arm/imx8mp-evk.rst index e60a422824..f7db33de32
> 100644
> > --- a/docs/system/arm/imx8mp-evk.rst
> > +++ b/docs/system/arm/imx8mp-evk.rst
> > @@ -1,13 +1,13 @@
> > -NXP i.MX 8M Plus Evaluation Kit (``imx8mp-evk``)
> > +NXP i.MX 8M Plus and i.MX 8M Mini Evaluation Kits (``imx8mp-evk``,
> > +``imx8mm-evk``)
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > -The ``imx8mp-evk`` machine models the i.MX 8M Plus Evaluation Kit,
> > based on an -i.MX 8M Plus SoC.
> > +The ``imx8mp-evk`` and ``imx8mm-evk`` machine models the i.MX 8M Plus
> > +and i.MX 8M Mini Evaluation Kits, based on i.MX 8M Plus and i.MX8M Min=
i
> SoCs.
> >
> > Supported devices
> > -----------------
> >
> > -The ``imx8mp-evk`` machine implements the following devices:
> > +The ``imx8mp-evk`` and ``imx8mm-evk`` machines implement the following
> devices:
> >
> >  * Up to 4 Cortex-A53 cores
> >  * Generic Interrupt Controller (GICv3) @@ -27,7 +27,7 @@ The
> > ``imx8mp-evk`` machine implements the following devices:
> > Boot options
> > ------------
> >
> > -The ``imx8mp-evk`` machine can start a Linux kernel directly using
> > the standard
> > +The ``imx8mp-evk`` and ``imx8mm-evk`` machines can start a Linux
> > +kernel directly using the standard
> > ``-kernel`` functionality.
> >
> > Direct Linux Kernel Boot
> > @@ -38,11 +38,20 @@ is to generate an image with Buildroot. Version
> > 2024.11.1 is tested at the time of writing and involves two steps.
> > First run the following commands in the toplevel directory of the Build=
root
> source tree:
> >
> > +For i.MX 8M Plus EVK:
> > +
> > .. code-block:: bash
> >
> >   $ make freescale_imx8mpevk_defconfig
> >   $ make
> >
> > +For i.MX 8M Mini EVK:
> > +
> > +.. code-block:: bash
> > +
> > +  $ make freescale_imx8mmevk_defconfig  $ make  Once finished
> > + successfully there is an ``output/image`` subfolder. Navigate into
> > it and resize the SD card image to a power of two:
> >
> > @@ -52,6 +61,8 @@ it and resize the SD card image to a power of two:
> >
> > Now that everything is prepared the machine can be started as follows:
> >
> > +For i.MX 8M Plus EVK:
> > +
> > .. code-block:: bash
> >
> >   $ qemu-system-aarch64 -M imx8mp-evk \ @@ -61,6 +72,16 @@ Now
> that
> > everything is prepared the machine can be started as follows:
> >       -append "root=3D/dev/mmcblk2p2" \
> >       -drive file=3Dsdcard.img,if=3Dsd,bus=3D2,format=3Draw,id=3Dmmcblk=
2
> >
> > +For i.MX 8M Mini EVK:
> > +
> > +.. code-block:: bash
> > +
> > +  $ qemu-system-aarch64 -M imx8mm-evk -smp 4 -m 2G \
> > +      -display none -serial null -serial stdio \
> > +      -kernel Image \
> > +      -dtb imx8mm-evk.dtb \
> > +      -append "root=3D/dev/mmcblk2p2" \
> > +      -drive file=3Dsdcard.img,if=3Dsd,bus=3D2,format=3Draw,id=3Dmmcbl=
k2
> >
> > KVM Acceleration
> > ----------------
> > @@ -69,7 +90,7 @@ To enable hardware-assisted acceleration via KVM,
> > append ``-accel kvm`` to the command line. While this speeds up
> > performance significantly, be aware of the following limitations:
> >
> > -* The ``imx8mp-evk`` machine is not included under the "virtualization=
 use
> case"
> > +* The ``imx8mp-evk`` and ``imx8mm-evk`` machines are not included unde=
r
> the "virtualization use case"
> >   of :doc:`QEMU's security policy </system/security>`. This means that =
you
> >   should not trust that it can contain malicious guests, whether it is =
run
> >   using TCG or KVM. If you don't trust your guests and you're relying
> > on QEMU to diff --git a/docs/system/target-arm.rst
> > b/docs/system/target-arm.rst index 89f7b77313..11c750b3f2 100644
> > --- a/docs/system/target-arm.rst
> > +++ b/docs/system/target-arm.rst
> > @@ -96,6 +96,7 @@ Board-specific documentation
> >    arm/mcimx6ul-evk
> >    arm/mcimx7d-sabre
> >    arm/imx8mp-evk
> > +   arm/imx8mm-evk
>=20
> I get two warnings during compilation:
>=20
> 1)
> ./src/docs/system/arm/imx8mp-evk.rst:2: WARNING: Title underline too
> short.
>=20
> NXP i.MX 8M Plus and i.MX 8M Mini Evaluation Kits (``imx8mp-evk``,
> ``imx8mm-evk``) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> [docutils]
>=20
>=20
> 2)
> ./src/docs/system/target-arm.rst:71: WARNING: toctree contains reference =
to
> nonexisting document 'system/arm/imx8mm-evk' [toc.not_readable]
>=20

I have been configuring and compiling like this:-

../configure --target-list=3D"aarch64-softmmu" --enable-werror
make -j32

The build turns out to be fine. Not sure why it doesn't show these warnings=
 in my build. I have fetched a new repo, checked out master, applied these =
patches and triggered a build.  Any idea why that might be the case ?

>=20
> You could also consider renaming imx8mp-evk.rst to something like imx8m.r=
st.

will change it to imx8m.rst in upcoming patch series.

>=20
> Other than that patch LGTM.
>=20
> Best regards,
> Bernhard
>=20
> >    arm/orangepi
> >    arm/raspi
> >    arm/collie
> > diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig index
> > 4e50fb1111..1399a2e04c 100644
> > --- a/hw/arm/Kconfig
> > +++ b/hw/arm/Kconfig
> > @@ -618,6 +618,18 @@ config FSL_IMX8MP_EVK
> >     depends on TCG
> >     select FSL_IMX8MP
> >
> > +config FSL_IMX8MM
> > +    bool
> > +    select ARM_GIC
> > +    select IMX
> > +
> > +config FSL_IMX8MM_EVK
> > +    bool
> > +    default y
> > +    depends on AARCH64
> > +    depends on TCG
> > +    select FSL_IMX8MM
> > +
> > config ARM_SMMUV3_ACCEL
> >     bool
> >     depends on ARM_SMMUV3
> > diff --git a/hw/arm/fsl-imx8mm.c b/hw/arm/fsl-imx8mm.c new file mode
> > 100644 index 0000000000..ff3603645f
> > --- /dev/null
> > +++ b/hw/arm/fsl-imx8mm.c
> > @@ -0,0 +1,377 @@
> > +/*
> > + * i.MX 8MM SoC Implementation
> > + *
> > + * Based on hw/arm/fsl-imx6.c
> > + *
> > + * Copyright (c) 2025, NXP Semiconductors
> > + * Author: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + *
> > + * iMX8MM Reference Manual -
> >
> +https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fww
> w
> >
> +.nxp.com%2Fproducts%2Fi.MX8MMINI&data=3D05%7C02%7Cgaurav.sharma
> _7%40nxp
> >
> +.com%7Cde5fb41e9d614627bd1c08de9a272206%7C686ea1d3bc2b4c6fa9
> 2cd99c5c3
> >
> +01635%7C0%7C0%7C639117690057691656%7CUnknown%7CTWFpbGZs
> b3d8eyJFbXB0eU
> >
> +1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCI
> sIld
> >
> +UIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DZFWEpnHrDlBb5qjvFXv9hOCsgj
> eN9DTO%2Fx
> > +xoNn%2FUt%2BQ%3D&reserved=3D0 -> Documentation  */
> > +
> > +#include "qemu/osdep.h"
> > +#include "system/address-spaces.h"
> > +#include "hw/arm/bsa.h"
> > +#include "hw/arm/fsl-imx8mm.h"
> > +#include "hw/misc/unimp.h"
> > +#include "hw/core/boards.h"
> > +#include "system/kvm.h"
> > +#include "system/system.h"
> > +#include "target/arm/cpu.h"
> > +#include "target/arm/cpu-qom.h"
> > +#include "target/arm/kvm_arm.h"
> > +#include "qapi/error.h"
> > +#include "qobject/qlist.h"
> > +
> > +static const struct {
> > +    hwaddr addr;
> > +    size_t size;
> > +    const char *name;
> > +} fsl_imx8mm_memmap[] =3D {
> > +    [FSL_IMX8MM_RAM] =3D { FSL_IMX8MM_RAM_START,
> FSL_IMX8MM_RAM_SIZE_MAX, "ram" },
> > +    [FSL_IMX8MM_DDR_PHY_BROADCAST] =3D { 0x3dc00000, 4 * MiB,
> "ddr_phy_broadcast" },
> > +    [FSL_IMX8MM_DDR_PERF_MON] =3D { 0x3d800000, 4 * MiB,
> "ddr_perf_mon" },
> > +    [FSL_IMX8MM_DDR_CTL] =3D { 0x3d400000, 4 * MiB, "ddr_ctl" },
> > +    [FSL_IMX8MM_DDR_PHY] =3D { 0x3c000000, 16 * MiB, "ddr_phy" },
> > +    [FSL_IMX8MM_GIC_DIST] =3D { 0x38800000, 512 * KiB, "gic_dist" },
> > +    [FSL_IMX8MM_GIC_REDIST] =3D { 0x38880000, 512 * KiB, "gic_redist" =
},
> > +    [FSL_IMX8MM_VPU] =3D { 0x38340000, 2 * MiB, "vpu" },
> > +    [FSL_IMX8MM_VPU_BLK_CTRL] =3D { 0x38330000, 2 * MiB,
> "vpu_blk_ctrl" },
> > +    [FSL_IMX8MM_VPU_G2_DECODER] =3D { 0x38310000, 1 * MiB,
> "vpu_g2_decoder" },
> > +    [FSL_IMX8MM_VPU_G1_DECODER] =3D { 0x38300000, 1 * MiB,
> "vpu_g1_decoder" },
> > +    [FSL_IMX8MM_USB2_OTG] =3D { 0x32e50200, 0x200, "usb2_otg" },
> > +    [FSL_IMX8MM_USB2] =3D { 0x32e50000, 0x200, "usb2" },
> > +    [FSL_IMX8MM_USB1_OTG] =3D { 0x32e40200, 0x200, "usb1_otg" },
> > +    [FSL_IMX8MM_USB1] =3D { 0x32e40000, 0x200, "usb1" },
> > +    [FSL_IMX8MM_GPU2D] =3D { 0x38000000, 64 * KiB, "gpu2d" },
> > +    [FSL_IMX8MM_QSPI1_RX_BUFFER] =3D { 0x34000000, 32 * MiB,
> "qspi1_rx_buffer" },
> > +    [FSL_IMX8MM_PCIE1] =3D { 0x33800000, 4 * MiB, "pcie1" },
> > +    [FSL_IMX8MM_QSPI1_TX_BUFFER] =3D { 0x33008000, 32 * KiB,
> "qspi1_tx_buffer" },
> > +    [FSL_IMX8MM_APBH_DMA] =3D { 0x33000000, 32 * KiB, "apbh_dma" },
> > +
> > +    /* AIPS-4 Begin */
> > +    [FSL_IMX8MM_TZASC] =3D { 0x32f80000, 64 * KiB, "tzasc" },
> > +    [FSL_IMX8MM_PCIE_PHY1] =3D { 0x32f00000, 64 * KiB, "pcie_phy1" },
> > +    [FSL_IMX8MM_MEDIA_BLK_CTL] =3D { 0x32e28000, 256,
> "media_blk_ctl" },
> > +    [FSL_IMX8MM_LCDIF] =3D { 0x32e00000, 64 * KiB, "lcdif" },
> > +    [FSL_IMX8MM_MIPI_DSI] =3D { 0x32e10000, 64 * KiB, "mipi_dsi" },
> > +    [FSL_IMX8MM_MIPI_CSI] =3D { 0x32e30000, 64 * KiB, "mipi_csi" },
> > +    [FSL_IMX8MM_AIPS4_CONFIGURATION] =3D { 0x32df0000, 64 * KiB,
> "aips4_configuration" },
> > +    /* AIPS-4 End */
> > +
> > +    [FSL_IMX8MM_INTERCONNECT] =3D { 0x32700000, 1 * MiB,
> "interconnect"
> > + },
> > +
> > +    /* AIPS-3 Begin */
> > +    [FSL_IMX8MM_ENET1] =3D { 0x30be0000, 64 * KiB, "enet1" },
> > +    [FSL_IMX8MM_SDMA1] =3D { 0x30bd0000, 64 * KiB, "sdma1" },
> > +    [FSL_IMX8MM_QSPI] =3D { 0x30bb0000, 64 * KiB, "qspi" },
> > +    [FSL_IMX8MM_USDHC3] =3D { 0x30b60000, 64 * KiB, "usdhc3" },
> > +    [FSL_IMX8MM_USDHC2] =3D { 0x30b50000, 64 * KiB, "usdhc2" },
> > +    [FSL_IMX8MM_USDHC1] =3D { 0x30b40000, 64 * KiB, "usdhc1" },
> > +    [FSL_IMX8MM_SEMAPHORE_HS] =3D { 0x30ac0000, 64 * KiB,
> "semaphore_hs" },
> > +    [FSL_IMX8MM_MU_B] =3D { 0x30ab0000, 64 * KiB, "mu_b" },
> > +    [FSL_IMX8MM_MU_A] =3D { 0x30aa0000, 64 * KiB, "mu_a" },
> > +    [FSL_IMX8MM_UART4] =3D { 0x30a60000, 64 * KiB, "uart4" },
> > +    [FSL_IMX8MM_I2C4] =3D { 0x30a50000, 64 * KiB, "i2c4" },
> > +    [FSL_IMX8MM_I2C3] =3D { 0x30a40000, 64 * KiB, "i2c3" },
> > +    [FSL_IMX8MM_I2C2] =3D { 0x30a30000, 64 * KiB, "i2c2" },
> > +    [FSL_IMX8MM_I2C1] =3D { 0x30a20000, 64 * KiB, "i2c1" },
> > +    [FSL_IMX8MM_AIPS3_CONFIGURATION] =3D { 0x309f0000, 64 * KiB,
> "aips3_configuration" },
> > +    [FSL_IMX8MM_CAAM] =3D { 0x30900000, 256 * KiB, "caam" },
> > +    [FSL_IMX8MM_SPBA1] =3D { 0x308f0000, 64 * KiB, "spba1" },
> > +    [FSL_IMX8MM_UART2] =3D { 0x30890000, 64 * KiB, "uart2" },
> > +    [FSL_IMX8MM_UART3] =3D { 0x30880000, 64 * KiB, "uart3" },
> > +    [FSL_IMX8MM_UART1] =3D { 0x30860000, 64 * KiB, "uart1" },
> > +    [FSL_IMX8MM_ECSPI3] =3D { 0x30840000, 64 * KiB, "ecspi3" },
> > +    [FSL_IMX8MM_ECSPI2] =3D { 0x30830000, 64 * KiB, "ecspi2" },
> > +    [FSL_IMX8MM_ECSPI1] =3D { 0x30820000, 64 * KiB, "ecspi1" },
> > +    /* AIPS-3 End */
> > +
> > +    /* AIPS-2 Begin */
> > +    [FSL_IMX8MM_QOSC] =3D { 0x307f0000, 64 * KiB, "qosc" },
> > +    [FSL_IMX8MM_PERFMON2] =3D { 0x307d0000, 64 * KiB, "perfmon2" },
> > +    [FSL_IMX8MM_PERFMON1] =3D { 0x307c0000, 64 * KiB, "perfmon1" },
> > +    [FSL_IMX8MM_GPT4] =3D { 0x30700000, 64 * KiB, "gpt4" },
> > +    [FSL_IMX8MM_GPT5] =3D { 0x306f0000, 64 * KiB, "gpt5" },
> > +    [FSL_IMX8MM_GPT6] =3D { 0x306e0000, 64 * KiB, "gpt6" },
> > +    [FSL_IMX8MM_SYSCNT_CTRL] =3D { 0x306c0000, 64 * KiB, "syscnt_ctrl"=
 },
> > +    [FSL_IMX8MM_SYSCNT_CMP] =3D { 0x306b0000, 64 * KiB, "syscnt_cmp" }=
,
> > +    [FSL_IMX8MM_SYSCNT_RD] =3D { 0x306a0000, 64 * KiB, "syscnt_rd" },
> > +    [FSL_IMX8MM_PWM4] =3D { 0x30690000, 64 * KiB, "pwm4" },
> > +    [FSL_IMX8MM_PWM3] =3D { 0x30680000, 64 * KiB, "pwm3" },
> > +    [FSL_IMX8MM_PWM2] =3D { 0x30670000, 64 * KiB, "pwm2" },
> > +    [FSL_IMX8MM_PWM1] =3D { 0x30660000, 64 * KiB, "pwm1" },
> > +    [FSL_IMX8MM_AIPS2_CONFIGURATION] =3D { 0x305f0000, 64 * KiB,
> "aips2_configuration" },
> > +    /* AIPS-2 End */
> > +
> > +    /* AIPS-1 Begin */
> > +    [FSL_IMX8MM_CSU] =3D { 0x303e0000, 64 * KiB, "csu" },
> > +    [FSL_IMX8MM_RDC] =3D { 0x303d0000, 64 * KiB, "rdc" },
> > +    [FSL_IMX8MM_SEMAPHORE2] =3D { 0x303c0000, 64 * KiB,
> "semaphore2" },
> > +    [FSL_IMX8MM_SEMAPHORE1] =3D { 0x303b0000, 64 * KiB,
> "semaphore1" },
> > +    [FSL_IMX8MM_GPC] =3D { 0x303a0000, 64 * KiB, "gpc" },
> > +    [FSL_IMX8MM_SRC] =3D { 0x30390000, 64 * KiB, "src" },
> > +    [FSL_IMX8MM_CCM] =3D { 0x30380000, 64 * KiB, "ccm" },
> > +    [FSL_IMX8MM_SNVS_HP] =3D { 0x30370000, 64 * KiB, "snvs_hp" },
> > +    [FSL_IMX8MM_ANA_PLL] =3D { 0x30360000, 64 * KiB, "ana_pll" },
> > +    [FSL_IMX8MM_OCOTP_CTRL] =3D { 0x30350000, 64 * KiB, "ocotp_ctrl" }=
,
> > +    [FSL_IMX8MM_IOMUXC_GPR] =3D { 0x30340000, 64 * KiB,
> "iomuxc_gpr" },
> > +    [FSL_IMX8MM_IOMUXC] =3D { 0x30330000, 64 * KiB, "iomuxc" },
> > +    [FSL_IMX8MM_GPT3] =3D { 0x302f0000, 64 * KiB, "gpt3" },
> > +    [FSL_IMX8MM_GPT2] =3D { 0x302e0000, 64 * KiB, "gpt2" },
> > +    [FSL_IMX8MM_GPT1] =3D { 0x302d0000, 64 * KiB, "gpt1" },
> > +    [FSL_IMX8MM_SDMA2] =3D { 0x302c0000, 64 * KiB, "sdma2" },
> > +    [FSL_IMX8MM_SDMA3] =3D { 0x302b0000, 64 * KiB, "sdma3" },
> > +    [FSL_IMX8MM_WDOG3] =3D { 0x302a0000, 64 * KiB, "wdog3" },
> > +    [FSL_IMX8MM_WDOG2] =3D { 0x30290000, 64 * KiB, "wdog2" },
> > +    [FSL_IMX8MM_WDOG1] =3D { 0x30280000, 64 * KiB, "wdog1" },
> > +    [FSL_IMX8MM_ANA_OSC] =3D { 0x30270000, 64 * KiB, "ana_osc" },
> > +    [FSL_IMX8MM_ANA_TSENSOR] =3D { 0x30260000, 64 * KiB,
> "ana_tsensor" },
> > +    [FSL_IMX8MM_GPIO5] =3D { 0x30240000, 64 * KiB, "gpio5" },
> > +    [FSL_IMX8MM_GPIO4] =3D { 0x30230000, 64 * KiB, "gpio4" },
> > +    [FSL_IMX8MM_GPIO3] =3D { 0x30220000, 64 * KiB, "gpio3" },
> > +    [FSL_IMX8MM_GPIO2] =3D { 0x30210000, 64 * KiB, "gpio2" },
> > +    [FSL_IMX8MM_GPIO1] =3D { 0x30200000, 64 * KiB, "gpio1" },
> > +    [FSL_IMX8MM_AIPS1_CONFIGURATION] =3D { 0x301f0000, 64 * KiB,
> "aips1_configuration" },
> > +    [FSL_IMX8MM_SAI6] =3D { 0x30060000, 64 * KiB, "sai6" },
> > +    [FSL_IMX8MM_SAI5] =3D { 0x30050000, 64 * KiB, "sai5" },
> > +    [FSL_IMX8MM_SAI3] =3D { 0x30030000, 64 * KiB, "sai3" },
> > +    [FSL_IMX8MM_SAI2] =3D { 0x30020000, 64 * KiB, "sai2" },
> > +    [FSL_IMX8MM_SAI1] =3D { 0x30010000, 64 * KiB, "sai1" },
> > +
> > +    /* AIPS-1 End */
> > +
> > +    [FSL_IMX8MM_A53_DAP] =3D { 0x28000000, 16 * MiB, "a53_dap" },
> > +    [FSL_IMX8MM_PCIE1_MEM] =3D { 0x18000000, 128 * MiB,
> "pcie1_mem" },
> > +    [FSL_IMX8MM_QSPI_MEM] =3D { 0x08000000, 256 * MiB, "qspi_mem" },
> > +    [FSL_IMX8MM_OCRAM] =3D { 0x00900000, 256 * KiB, "ocram" },
> > +    [FSL_IMX8MM_TCM_DTCM] =3D { 0x00800000, 128 * KiB, "tcm_dtcm" },
> > +    [FSL_IMX8MM_TCM_ITCM] =3D { 0x007e0000, 128 * KiB, "tcm_itcm" },
> > +    [FSL_IMX8MM_OCRAM_S] =3D { 0x00180000, 32 * KiB, "ocram_s" },
> > +    [FSL_IMX8MM_CAAM_MEM] =3D { 0x00100000, 32 * KiB, "caam_mem" },
> > +    [FSL_IMX8MM_BOOT_ROM_PROTECTED] =3D { 0x0003f000, 4 * KiB,
> "boot_rom_protected" },
> > +    [FSL_IMX8MM_BOOT_ROM] =3D { 0x00000000, 252 * KiB,
> "boot_rom" }, };
> > +
> > +static void fsl_imx8mm_init(Object *obj) {
> > +    MachineState *ms =3D MACHINE(qdev_get_machine());
> > +    FslImx8mmState *s =3D FSL_IMX8MM(obj);
> > +    const char *cpu_type =3D ms->cpu_type ?:
> ARM_CPU_TYPE_NAME("cortex-a53");
> > +    int i;
> > +
> > +    for (i =3D 0; i < MIN(ms->smp.cpus, FSL_IMX8MM_NUM_CPUS); i++) {
> > +        g_autofree char *name =3D g_strdup_printf("cpu%d", i);
> > +        object_initialize_child(obj, name, &s->cpu[i], cpu_type);
> > +    }
> > +
> > +    object_initialize_child(obj, "gic", &s->gic, gicv3_class_name());
> > +
> > +    for (i =3D 0; i < FSL_IMX8MM_NUM_UARTS; i++) {
> > +        g_autofree char *name =3D g_strdup_printf("uart%d", i + 1);
> > +        object_initialize_child(obj, name, &s->uart[i], TYPE_IMX_SERIA=
L);
> > +    }
> > +
> > +}
> > +
> > +static void fsl_imx8mm_realize(DeviceState *dev, Error **errp) {
> > +    MachineState *ms =3D MACHINE(qdev_get_machine());
> > +    FslImx8mmState *s =3D FSL_IMX8MM(dev);
> > +    DeviceState *gicdev =3D DEVICE(&s->gic);
> > +    int i;
> > +
> > +    if (ms->smp.cpus > FSL_IMX8MM_NUM_CPUS) {
> > +        error_setg(errp, "%s: Only %d CPUs are supported (%d requested=
)",
> > +                   TYPE_FSL_IMX8MM, FSL_IMX8MM_NUM_CPUS, ms-
> >smp.cpus);
> > +        return;
> > +    }
> > +
> > +    /* CPUs */
> > +    for (i =3D 0; i < ms->smp.cpus; i++) {
> > +        /* On uniprocessor, the CBAR is set to 0 */
> > +        if (ms->smp.cpus > 1 &&
> > +                object_property_find(OBJECT(&s->cpu[i]), "reset-cbar")=
) {
> > +            object_property_set_int(OBJECT(&s->cpu[i]), "reset-cbar",
> > +                                    fsl_imx8mm_memmap[FSL_IMX8MM_GIC_D=
IST].addr,
> > +                                    &error_abort);
> > +        }
> > +
> > +        /*
> > +         * CNTFID0 base frequency in Hz of system counter
> > +         */
> > +        object_property_set_int(OBJECT(&s->cpu[i]), "cntfrq", 8000000,
> > +                                &error_abort);
> > +
> > +        if (object_property_find(OBJECT(&s->cpu[i]), "has_el2")) {
> > +            object_property_set_bool(OBJECT(&s->cpu[i]), "has_el2",
> > +                                     !kvm_enabled(), &error_abort);
> > +        }
> > +
> > +        if (object_property_find(OBJECT(&s->cpu[i]), "has_el3")) {
> > +            object_property_set_bool(OBJECT(&s->cpu[i]), "has_el3",
> > +                                     !kvm_enabled(), &error_abort);
> > +        }
> > +
> > +        if (i) {
> > +            /*
> > +             * Secondary CPUs start in powered-down state (and can be
> > +             * powered up via the SRC system reset controller)
> > +             */
> > +            object_property_set_bool(OBJECT(&s->cpu[i]), "start-powere=
d-off",
> > +                                     true, &error_abort);
> > +        }
> > +
> > +        if (!qdev_realize(DEVICE(&s->cpu[i]), NULL, errp)) {
> > +            return;
> > +        }
> > +    }
> > +
> > +    /* GIC */
> > +    {
> > +        SysBusDevice *gicsbd =3D SYS_BUS_DEVICE(&s->gic);
> > +        QList *redist_region_count;
> > +        bool pmu =3D object_property_get_bool(OBJECT(first_cpu), "pmu"=
,
> > + NULL);
> > +
> > +        qdev_prop_set_uint32(gicdev, "num-cpu", ms->smp.cpus);
> > +        qdev_prop_set_uint32(gicdev, "num-irq",
> > +                             FSL_IMX8MM_NUM_IRQS + GIC_INTERNAL);
> > +        redist_region_count =3D qlist_new();
> > +        qlist_append_int(redist_region_count, ms->smp.cpus);
> > +        qdev_prop_set_array(gicdev, "redist-region-count",
> redist_region_count);
> > +        object_property_set_link(OBJECT(&s->gic), "sysmem",
> > +                                 OBJECT(get_system_memory()), &error_f=
atal);
> > +        if (!sysbus_realize(gicsbd, errp)) {
> > +            return;
> > +        }
> > +        sysbus_mmio_map(gicsbd, 0,
> fsl_imx8mm_memmap[FSL_IMX8MM_GIC_DIST].addr);
> > +        sysbus_mmio_map(gicsbd, 1,
> > + fsl_imx8mm_memmap[FSL_IMX8MM_GIC_REDIST].addr);
> > +
> > +        /*
> > +         * Wire the outputs from each CPU's generic timer and the GICv=
3
> > +         * maintenance interrupt signal to the appropriate GIC PPI inp=
uts, and
> > +         * the GIC's IRQ/FIQ interrupt outputs to the CPU's inputs.
> > +         */
> > +        for (i =3D 0; i < ms->smp.cpus; i++) {
> > +            DeviceState *cpudev =3D DEVICE(&s->cpu[i]);
> > +            int intidbase =3D FSL_IMX8MM_NUM_IRQS + i * GIC_INTERNAL;
> > +            qemu_irq irq;
> > +
> > +            /*
> > +             * Mapping from the output timer irq lines from the CPU to=
 the
> > +             * GIC PPI inputs.
> > +             */
> > +            static const int timer_irqs[] =3D {
> > +                [GTIMER_PHYS] =3D ARCH_TIMER_NS_EL1_IRQ,
> > +                [GTIMER_VIRT] =3D ARCH_TIMER_VIRT_IRQ,
> > +                [GTIMER_HYP]  =3D ARCH_TIMER_NS_EL2_IRQ,
> > +                [GTIMER_SEC]  =3D ARCH_TIMER_S_EL1_IRQ,
> > +            };
> > +
> > +            for (int j =3D 0; j < ARRAY_SIZE(timer_irqs); j++) {
> > +                irq =3D qdev_get_gpio_in(gicdev, intidbase + timer_irq=
s[j]);
> > +                qdev_connect_gpio_out(cpudev, j, irq);
> > +            }
> > +
> > +            irq =3D qdev_get_gpio_in(gicdev, intidbase + ARCH_GIC_MAIN=
T_IRQ);
> > +            qdev_connect_gpio_out_named(cpudev, "gicv3-maintenance-
> interrupt",
> > +                                        0, irq);
> > +
> > +            irq =3D qdev_get_gpio_in(gicdev, intidbase + VIRTUAL_PMU_I=
RQ);
> > +            qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0,
> > + irq);
> > +
> > +            sysbus_connect_irq(gicsbd, i,
> > +                               qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
> > +            sysbus_connect_irq(gicsbd, i + ms->smp.cpus,
> > +                               qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
> > +            sysbus_connect_irq(gicsbd, i + 2 * ms->smp.cpus,
> > +                               qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ))=
;
> > +            sysbus_connect_irq(gicsbd, i + 3 * ms->smp.cpus,
> > +                               qdev_get_gpio_in(cpudev,
> > + ARM_CPU_VFIQ));
> > +
> > +            if (kvm_enabled()) {
> > +                if (pmu) {
> > +                    assert(arm_feature(&s->cpu[i].env, ARM_FEATURE_PMU=
));
> > +                    if (kvm_irqchip_in_kernel()) {
> > +                        kvm_arm_pmu_set_irq(&s->cpu[i], VIRTUAL_PMU_IR=
Q);
> > +                    }
> > +                    kvm_arm_pmu_init(&s->cpu[i]);
> > +                }
> > +            }
> > +        }
> > +    }
> > +
> > +    /* UARTs */
> > +    for (i =3D 0; i < FSL_IMX8MM_NUM_UARTS; i++) {
> > +        static const struct {
> > +            hwaddr addr;
> > +            unsigned int irq;
> > +        } serial_table[FSL_IMX8MM_NUM_UARTS] =3D {
> > +            { fsl_imx8mm_memmap[FSL_IMX8MM_UART1].addr,
> FSL_IMX8MM_UART1_IRQ },
> > +            { fsl_imx8mm_memmap[FSL_IMX8MM_UART2].addr,
> FSL_IMX8MM_UART2_IRQ },
> > +            { fsl_imx8mm_memmap[FSL_IMX8MM_UART3].addr,
> FSL_IMX8MM_UART3_IRQ },
> > +            { fsl_imx8mm_memmap[FSL_IMX8MM_UART4].addr,
> FSL_IMX8MM_UART4_IRQ },
> > +        };
> > +
> > +        qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hd(i)=
);
> > +        if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), errp)) {
> > +            return;
> > +        }
> > +
> > +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->uart[i]), 0,
> serial_table[i].addr);
> > +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0,
> > +                           qdev_get_gpio_in(gicdev, serial_table[i].ir=
q));
> > +    }
> > +
> > +    /* On-Chip RAM */
> > +    if (!memory_region_init_ram(&s->ocram, OBJECT(dev),
> "imx8mm.ocram",
> > +                                fsl_imx8mm_memmap[FSL_IMX8MM_OCRAM].si=
ze,
> > +                                errp)) {
> > +        return;
> > +    }
> > +    memory_region_add_subregion(get_system_memory(),
> > +                                fsl_imx8mm_memmap[FSL_IMX8MM_OCRAM].ad=
dr,
> > +                                &s->ocram);
> > +    +    /* Unimplemented devices */
> > +    for (i =3D 0; i < ARRAY_SIZE(fsl_imx8mm_memmap); i++) {
> > +        switch (i) {
> > +        case FSL_IMX8MM_GIC_DIST:
> > +        case FSL_IMX8MM_GIC_REDIST:
> > +        case FSL_IMX8MM_RAM:
> > +        case FSL_IMX8MM_OCRAM:
> > +        case FSL_IMX8MM_UART1 ... FSL_IMX8MM_UART4:
> > +            /* device implemented and treated above */
> > +            break;
> > +
> > +        default:
> > +            create_unimplemented_device(fsl_imx8mm_memmap[i].name,
> > +                                        fsl_imx8mm_memmap[i].addr,
> > +                                        fsl_imx8mm_memmap[i].size);
> > +            break;
> > +        }
> > +    }
> > +}
> > +
> > +static void fsl_imx8mm_class_init(ObjectClass *oc, const void *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(oc);
> > +
> > +    dc->realize =3D fsl_imx8mm_realize;
> > +
> > +    dc->desc =3D "i.MX 8MM SoC";
> > +}
> > +
> > +static const TypeInfo fsl_imx8mm_types[] =3D {
> > +    {
> > +        .name =3D TYPE_FSL_IMX8MM,
> > +        .parent =3D TYPE_SYS_BUS_DEVICE,
> > +        .instance_size =3D sizeof(FslImx8mmState),
> > +        .instance_init =3D fsl_imx8mm_init,
> > +        .class_init =3D fsl_imx8mm_class_init,
> > +    },
> > +};
> > +
> > +DEFINE_TYPES(fsl_imx8mm_types)
> > diff --git a/hw/arm/imx8mm-evk.c b/hw/arm/imx8mm-evk.c new file mode
> > 100644 index 0000000000..0a8cce8866
> > --- /dev/null
> > +++ b/hw/arm/imx8mm-evk.c
> > @@ -0,0 +1,112 @@
> > +/*
> > + * NXP i.MX 8MM Evaluation Kit System Emulation
> > + *
> > + * Copyright (c) 2025, NXP Semiconductors
> > + * Author: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later  */
> > +
> > +#include "qemu/osdep.h"
> > +#include "system/address-spaces.h"
> > +#include "hw/arm/boot.h"
> > +#include "hw/arm/fsl-imx8mm.h"
> > +#include "hw/arm/machines-qom.h"
> > +#include "hw/core/boards.h"
> > +#include "hw/core/qdev-properties.h"
> > +#include "system/kvm.h"
> > +#include "system/qtest.h"
> > +#include "qemu/error-report.h"
> > +#include "qapi/error.h"
> > +#include <libfdt.h>
> > +
> > +static void imx8mm_evk_modify_dtb(const struct arm_boot_info *info,
> > +void *fdt) {
> > +    int i, offset;
> > +
> > +    /* Temporarily disable following nodes until they are implemented =
*/
> > +    const char *nodes_to_remove[] =3D {
> > +        "nxp,imx8mm-fspi",
> > +        "fsl,imx8mm-mipi-csi",
> > +        "fsl,imx8mm-mipi-dsim"
> > +    };
> > +
> > +    for (i =3D 0; i < ARRAY_SIZE(nodes_to_remove); i++) {
> > +        const char *dev_str =3D nodes_to_remove[i];
> > +
> > +        offset =3D fdt_node_offset_by_compatible(fdt, -1, dev_str);
> > +        while (offset >=3D 0) {
> > +            fdt_nop_node(fdt, offset);
> > +            offset =3D fdt_node_offset_by_compatible(fdt, offset, dev_=
str);
> > +        }
> > +    }
> > +
> > +    /* Remove cpu-idle-states property from CPU nodes */
> > +    offset =3D fdt_node_offset_by_compatible(fdt, -1, "arm,cortex-a53"=
);
> > +    while (offset >=3D 0) {
> > +        fdt_nop_property(fdt, offset, "cpu-idle-states");
> > +        offset =3D fdt_node_offset_by_compatible(fdt, offset, "arm,cor=
tex-a53");
> > +    }
> > +
> > +    if (kvm_enabled()) {
> > +        /* Use system counter frequency from host CPU to fix time in g=
uest */
> > +        offset =3D fdt_node_offset_by_compatible(fdt, -1, "arm,armv8-t=
imer");
> > +        while (offset >=3D 0) {
> > +            fdt_nop_property(fdt, offset, "clock-frequency");
> > +            offset =3D fdt_node_offset_by_compatible(fdt, offset, "arm=
,armv8-
> timer");
> > +        }
> > +    }
> > +}
> > +
> > +static void imx8mm_evk_init(MachineState *machine) {
> > +    static struct arm_boot_info boot_info;
> > +    FslImx8mmState *s;
> > +
> > +    if (machine->ram_size > FSL_IMX8MM_RAM_SIZE_MAX) {
> > +        error_report("RAM size " RAM_ADDR_FMT " above max supported
> (%08" PRIx64 ")",
> > +                     machine->ram_size, FSL_IMX8MM_RAM_SIZE_MAX);
> > +        exit(1);
> > +    }
> > +
> > +    boot_info =3D (struct arm_boot_info) {
> > +        .loader_start =3D FSL_IMX8MM_RAM_START,
> > +        .board_id =3D -1,
> > +        .ram_size =3D machine->ram_size,
> > +        .psci_conduit =3D QEMU_PSCI_CONDUIT_SMC,
> > +        .modify_dtb =3D imx8mm_evk_modify_dtb,
> > +    };
> > +
> > +    s =3D FSL_IMX8MM(object_new_with_props(TYPE_FSL_IMX8MM,
> OBJECT(machine),
> > +                                         "soc", &error_fatal, NULL));
> > +    sysbus_realize_and_unref(SYS_BUS_DEVICE(s), &error_fatal);
> > +
> > +    memory_region_add_subregion(get_system_memory(),
> FSL_IMX8MM_RAM_START,
> > +                                machine->ram);
> > +
> > +    if (!qtest_enabled()) {
> > +        arm_load_kernel(&s->cpu[0], machine, &boot_info);
> > +    }
> > +}
> > +
> > +static const char *imx8mm_evk_get_default_cpu_type(const MachineState
> > +*ms) {
> > +    if (kvm_enabled()) {
> > +        return ARM_CPU_TYPE_NAME("host");
> > +    }
> > +
> > +    return ARM_CPU_TYPE_NAME("cortex-a53"); }
> > +
> > +static void imx8mm_evk_machine_init(MachineClass *mc) {
> > +    mc->desc =3D "NXP i.MX 8MM EVK Board";
> > +    mc->init =3D imx8mm_evk_init;
> > +    mc->max_cpus =3D FSL_IMX8MM_NUM_CPUS;
> > +    mc->default_cpus =3D FSL_IMX8MM_NUM_CPUS;
> > +    mc->default_ram_size =3D 2 * GiB;
> > +    mc->default_ram_id =3D "imx8mm-evk.ram";
> > +    mc->get_default_cpu_type =3D imx8mm_evk_get_default_cpu_type; }
> > +
> > +DEFINE_MACHINE_AARCH64("imx8mm-evk", imx8mm_evk_machine_init)
> > diff --git a/hw/arm/meson.build b/hw/arm/meson.build index
> > b187b946f0..8b7a6ad07a 100644
> > --- a/hw/arm/meson.build
> > +++ b/hw/arm/meson.build
> > @@ -84,6 +84,8 @@ arm_common_ss.add(when: 'CONFIG_ARMSSE',
> if_true:
> > files('armsse.c'))
> > arm_common_ss.add(when: 'CONFIG_FSL_IMX7', if_true:
> > files('fsl-imx7.c', 'mcimx7d-sabre.c'))
> > arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP', if_true:
> > files('fsl-imx8mp.c'))
> > arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP_EVK', if_true:
> > files('imx8mp-evk.c'))
> > +arm_common_ss.add(when: 'CONFIG_FSL_IMX8MM', if_true:
> > +files('fsl-imx8mm.c'))
> > +arm_common_ss.add(when: 'CONFIG_FSL_IMX8MM_EVK', if_true:
> > +files('imx8mm-evk.c'))
> > arm_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
> > arm_ss.add(when: 'CONFIG_ARM_SMMUV3_ACCEL', if_true:
> > files('smmuv3-accel.c'))
> > arm_common_ss.add(when: 'CONFIG_FSL_IMX6UL', if_true:
> > files('fsl-imx6ul.c', 'mcimx6ul-evk.c')) diff --git
> > a/include/hw/arm/fsl-imx8mm.h b/include/hw/arm/fsl-imx8mm.h new file
> > mode 100644 index 0000000000..2811e809b9
> > --- /dev/null
> > +++ b/include/hw/arm/fsl-imx8mm.h
> > @@ -0,0 +1,158 @@
> > +/*
> > + * i.MX 8MM SoC Definitions
> > + *
> > + * Copyright (c) 2025, NXP Semiconductors
> > + * Author: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later  */
> > +
> > +#ifndef FSL_IMX8MM_H
> > +#define FSL_IMX8MM_H
> > +
> > +#include "cpu.h"
> > +#include "hw/char/imx_serial.h"
> > +#include "hw/intc/arm_gicv3_common.h"
> > +#include "qom/object.h"
> > +#include "qemu/units.h"
> > +
> > +#define TYPE_FSL_IMX8MM "fsl-imx8mm"
> > +OBJECT_DECLARE_SIMPLE_TYPE(FslImx8mmState, FSL_IMX8MM)
> > +
> > +#define FSL_IMX8MM_RAM_START        0x40000000
> > +#define FSL_IMX8MM_RAM_SIZE_MAX     (4 * GiB)
> > +
> > +enum FslImx8mmConfiguration {
> > +    FSL_IMX8MM_NUM_CPUS         =3D 4,
> > +    FSL_IMX8MM_NUM_IRQS         =3D 128,
> > +    FSL_IMX8MM_NUM_UARTS        =3D 4,
> > +};
> > +
> > +struct FslImx8mmState {
> > +    SysBusDevice   parent_obj;
> > +
> > +    ARMCPU             cpu[FSL_IMX8MM_NUM_CPUS];
> > +    GICv3State         gic;
> > +    IMXSerialState     uart[FSL_IMX8MM_NUM_UARTS];
> > +    MemoryRegion ocram;
> > +};
> > +
> > +enum FslImx8mmMemoryRegions {
> > +    FSL_IMX8MM_A53_DAP,
> > +    FSL_IMX8MM_AIPS1_CONFIGURATION,
> > +    FSL_IMX8MM_AIPS2_CONFIGURATION,
> > +    FSL_IMX8MM_AIPS3_CONFIGURATION,
> > +    FSL_IMX8MM_AIPS4_CONFIGURATION,
> > +    FSL_IMX8MM_ANA_OSC,
> > +    FSL_IMX8MM_ANA_PLL,
> > +    FSL_IMX8MM_ANA_TSENSOR,
> > +    FSL_IMX8MM_APBH_DMA,
> > +    FSL_IMX8MM_BOOT_ROM,
> > +    FSL_IMX8MM_BOOT_ROM_PROTECTED,
> > +    FSL_IMX8MM_CAAM,
> > +    FSL_IMX8MM_CAAM_MEM,
> > +    FSL_IMX8MM_CCM,
> > +    FSL_IMX8MM_CSU,
> > +    FSL_IMX8MM_DDR_CTL,
> > +    FSL_IMX8MM_DDR_PERF_MON,
> > +    FSL_IMX8MM_DDR_PHY,
> > +    FSL_IMX8MM_DDR_PHY_BROADCAST,
> > +    FSL_IMX8MM_ECSPI1,
> > +    FSL_IMX8MM_ECSPI2,
> > +    FSL_IMX8MM_ECSPI3,
> > +    FSL_IMX8MM_ENET1,
> > +    FSL_IMX8MM_GIC_DIST,
> > +    FSL_IMX8MM_GIC_REDIST,
> > +    FSL_IMX8MM_GPC,
> > +    FSL_IMX8MM_GPIO1,
> > +    FSL_IMX8MM_GPIO2,
> > +    FSL_IMX8MM_GPIO3,
> > +    FSL_IMX8MM_GPIO4,
> > +    FSL_IMX8MM_GPIO5,
> > +    FSL_IMX8MM_GPT1,
> > +    FSL_IMX8MM_GPT2,
> > +    FSL_IMX8MM_GPT3,
> > +    FSL_IMX8MM_GPT4,
> > +    FSL_IMX8MM_GPT5,
> > +    FSL_IMX8MM_GPT6,
> > +    FSL_IMX8MM_GPU2D,
> > +    FSL_IMX8MM_I2C1,
> > +    FSL_IMX8MM_I2C2,
> > +    FSL_IMX8MM_I2C3,
> > +    FSL_IMX8MM_I2C4,
> > +    FSL_IMX8MM_INTERCONNECT,
> > +    FSL_IMX8MM_IOMUXC,
> > +    FSL_IMX8MM_IOMUXC_GPR,
> > +    FSL_IMX8MM_MEDIA_BLK_CTL,
> > +    FSL_IMX8MM_LCDIF,
> > +    FSL_IMX8MM_MIPI_CSI,
> > +    FSL_IMX8MM_MIPI_DSI,
> > +    FSL_IMX8MM_MU_A,
> > +    FSL_IMX8MM_MU_B,
> > +    FSL_IMX8MM_OCOTP_CTRL,
> > +    FSL_IMX8MM_OCRAM,
> > +    FSL_IMX8MM_OCRAM_S,
> > +    FSL_IMX8MM_PCIE1,
> > +    FSL_IMX8MM_PCIE1_MEM,
> > +    FSL_IMX8MM_PCIE_PHY1,
> > +    FSL_IMX8MM_PERFMON1,
> > +    FSL_IMX8MM_PERFMON2,
> > +    FSL_IMX8MM_PWM1,
> > +    FSL_IMX8MM_PWM2,
> > +    FSL_IMX8MM_PWM3,
> > +    FSL_IMX8MM_PWM4,
> > +    FSL_IMX8MM_QOSC,
> > +    FSL_IMX8MM_QSPI,
> > +    FSL_IMX8MM_QSPI1_RX_BUFFER,
> > +    FSL_IMX8MM_QSPI1_TX_BUFFER,
> > +    FSL_IMX8MM_QSPI_MEM,
> > +    FSL_IMX8MM_RAM,
> > +    FSL_IMX8MM_RDC,
> > +    FSL_IMX8MM_SAI1,
> > +    FSL_IMX8MM_SAI2,
> > +    FSL_IMX8MM_SAI3,
> > +    FSL_IMX8MM_SAI5,
> > +    FSL_IMX8MM_SAI6,
> > +    FSL_IMX8MM_SDMA1,
> > +    FSL_IMX8MM_SDMA2,
> > +    FSL_IMX8MM_SDMA3,
> > +    FSL_IMX8MM_SEMAPHORE1,
> > +    FSL_IMX8MM_SEMAPHORE2,
> > +    FSL_IMX8MM_SEMAPHORE_HS,
> > +    FSL_IMX8MM_SNVS_HP,
> > +    FSL_IMX8MM_SPBA1,
> > +    FSL_IMX8MM_SRC,
> > +    FSL_IMX8MM_SYSCNT_CMP,
> > +    FSL_IMX8MM_SYSCNT_CTRL,
> > +    FSL_IMX8M

