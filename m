Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F6F5C5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 04:53:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wteTq-0004Am-Lf; Tue, 11 Aug 2026 00:52:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1wteTp-0004Ac-3b
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 00:52:49 -0400
Received: from mail-northeuropeazon11012042.outbound.protection.outlook.com
 ([52.101.66.42] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1wteTn-00027L-7p
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 00:52:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JGlToFA8JYTHIM+fdff9faXorvNoWEHHYIIJGUb998xYE5BHIFKYyoJVQQDeW3lZbzy9Nx9Dbyzn/b/CKjHr85/z3d6Xc53wCrxl3O9V4QncQUtKxayYeeGbU6xPVhiL5+JVIm8wlS1q7DzeJZKUPJvf0Ypr1UaKan2q97jH234tNOGsdF6MNYprS7FvkjHiuWoh4/95FXTthZbgy4UoMk5WCdY1Jy8HCnyEXuJ2m4SMV6GTLT4bFmqLxQUnzHcz3m+3VljJyrTV5lw4ApQ0gZKpdzWGsOxx7dAdgumTtBBvNQVzAXvdtavZK9LxJLuybZfqjIuw3dmPRbdpEPYWWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LgRCqBJEfBhOtRDHXcm1oxx98fX+vjoA8ZNI8PA2oJU=;
 b=p+n3Er4HoK8Pc41pdIoJPuhdessIZcjok/by8yVMR9Yu2ehOQiT26T7FRQF+uMVYgnAkZWnER1Leu4qcQPkYyKk3KlU/tHo3ef327dXfntBtSDWsfSz7xBlH7dRIPDkdj1Ys2PnfTpZ6HXtkup1yt7Ez9X0HqdDAfLp4EBQRLVLCU/N7aOzyYrliypnp+zMg2/FisqnTBC7fpKF1W0hgVUxaI61VKYXOpLfYosh3udlaDrNRTwh01hFmb3QGVDFf3BcFPQrVDTdCR5YkEdeXGGDcxJllbb7LHeLqhsNhrB+iQU8MsyQ9XoRe4TcG8wd42+MgZi/nQCoMo5tv/wD3IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LgRCqBJEfBhOtRDHXcm1oxx98fX+vjoA8ZNI8PA2oJU=;
 b=LfJMNfluPgPq01vkD/6KscZeoSToYWs+fDZYZfp2uZnwXGuwE/0qRfHXWqUsUZdYAricH7e65Uy9UFrvJeW11KtRd4ovdf3eJzCBbVZ2+rFHibS3cp5KGLz2v59E2Eh3Ec6x5QM4PrC82Dl9p+uBrwFN/7XbLPrQLkOguGSXo+Qsl/nNqMP7qefyGWc6K64XSSeWbH68zn7f9kyUXYUoLhrQUIO9wOjil+v+wl8SE1EsVCLyM9PksP+vhi2sfZZkyvdkWj0QsSSLFeOv3XTyPNMlQ35x0JiO7hq1fuRt1LUBRZHicvKvNM3qKhNCeAWp1QIbvKOuu3dbSXe7Wah3fA==
Received: from DB8PR04MB7177.eurprd04.prod.outlook.com (2603:10a6:10:127::23)
 by DU4PR04MB12131.eurprd04.prod.outlook.com (2603:10a6:10:642::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Tue, 11 Aug
 2026 04:47:41 +0000
Received: from DB8PR04MB7177.eurprd04.prod.outlook.com
 ([fe80::cf7b:6007:220b:97a2]) by DB8PR04MB7177.eurprd04.prod.outlook.com
 ([fe80::cf7b:6007:220b:97a2%4]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 04:47:41 +0000
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Bernhard Beschow <shentey@gmail.com>
Subject: RE: [PATCHv2 0/7] hw/arm: Adding Cortex-M7 Asymmetric Multiprocessing
 boot support for i.MX8MP
Thread-Topic: [PATCHv2 0/7] hw/arm: Adding Cortex-M7 Asymmetric
 Multiprocessing boot support for i.MX8MP
Thread-Index: AQHdDWSQYf08EcE04EOcCOxujcqOMLZ8J0EQgBxXAYA=
Date: Tue, 11 Aug 2026 04:47:40 +0000
Message-ID: <DB8PR04MB717730147C8E5B87FF57D07D87DD2@DB8PR04MB7177.eurprd04.prod.outlook.com>
References: <20260706162859.3361063-1-gaurav.sharma_7@nxp.com>
 <DB8PR04MB717781FAC6A65C0BE2AF1D0587CF2@DB8PR04MB7177.eurprd04.prod.outlook.com>
In-Reply-To: <DB8PR04MB717781FAC6A65C0BE2AF1D0587CF2@DB8PR04MB7177.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR04MB7177:EE_|DU4PR04MB12131:EE_
x-ms-office365-filtering-correlation-id: eb42bcc5-876c-4d69-8714-08def763ace3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|19092799006|23010399003|366016|11063799006|5023799004|56012099006|10067099003|3023799007|18002099003|22082099003|4143699003|38070700021;
x-microsoft-antispam-message-info: 3J/79OMv5Q8yq2cHyWUg5s5cRJ+HUX49Lyw7QXOX766jJ7w+98UjdZvJibr1teQDO9nKsaXm4Val4u8U0ThvwbhUwwwAz6To9+98aNXVCp9ISwUxrbkLnB6+WUSx2OphgeU4SeyTUkrMXDHXECNpCRMylS9tuP5WG7RuzgEhdkfvTVMjc6ZmhJA4J6LHuzj4z51/krSvi9ulvzsTsa41vNG8R4KIGjItJCicESX4nKGxr3LX5qnH7JvhDEkrm0mUm6yPVuD4ACyD6x9cx+Au+SlAWgby32QUdkf8ceWf9VEn8/gggn5x55fR3hNbFEUc2Sm2zFh132AKWMBb6MHYqxNWEbp4Hod+xB/PIkBCbkeoorEV7ALEP+NW223zwp/3mnrQEyQ2ZZNBYDqElKizjNQ/x39UCvRYIhk9VA5DtL/21jl1GOBMz0c1+lYiViwH/NB87UBdA8LnI5qLIzfNHke7+aDEroEOD8L2c12z4ui+sMLzCxP0/NdOjgUvqOwRPF3LPQeMv8dpSuivN24Oz6wElkZKtE6nnk5L+m5W6LFI5nQDuz3VHX3LF5UB1VWrNNwJdsnGXSW60XSrHibPgm5QqyRyOnfiOUe0ysXaWNV59WS8vxkmBntvDLbCpBMaTqchjtZUudtWNyWw1iv7s4w+7kC3VrBTjkelH4WHTWXCFsqXK9fEF4+hwTGnJG3R3gbctRi5BavvNf5JSH0yaM7h0VH/xUmUFB6HfUcTZdw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB8PR04MB7177.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(19092799006)(23010399003)(366016)(11063799006)(5023799004)(56012099006)(10067099003)(3023799007)(18002099003)(22082099003)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m0AE+BIWIosyrVoULBbbJkX7LhFiuJ1eTHHC1eNQKVICvzd94F7hWlL3pU5k?=
 =?us-ascii?Q?NZArAhgxofS6J0KmopnrRdX300YEnJzfxkhU7wW17nUn8oujFBlyXM6hFz9s?=
 =?us-ascii?Q?AtKULRojBNzBV4lKs/s8Ol4OVp1NO84mvAD8qu+TFMrDEvdJOva7XPvHrBHd?=
 =?us-ascii?Q?10nkJTEc1rlJrnSBSlM8M4ZcIEN8hG1QXMr16vHRye+KGx14/K8546Xcixrm?=
 =?us-ascii?Q?SPo412p2c2ActOuf1QJrLqfV2pkAfA5wYyxT387aOP1QDegba6mQxYWkB+rD?=
 =?us-ascii?Q?3eiPWwshP1aPRmT3tTu6L6hjCk7CnMdkwV1LmajmWf7/DM+BdJdaJTLCLFkL?=
 =?us-ascii?Q?G+4uDEMvjEntnCrrFv20bghE6Vb+sk2O2RrUVvkFhRX1CL+KRPDpg5MjSYAh?=
 =?us-ascii?Q?6XMa91wFXBdhpf0PCil4vcf0MRd1Eaijd/icF11G5qRoj9B5eeNPoqgbDNJj?=
 =?us-ascii?Q?kdeqv3RuzD8Rlv5dBFENVEIRRg6oADwBGRHdATaXaRMf+dcGRSkVSJlnL936?=
 =?us-ascii?Q?/IVpjB2eAjr+boaLsHYQKurKXVm5l4uNHAmmhci4Ua+ktumbIKxiQMcIhhfL?=
 =?us-ascii?Q?IyRWb0HwPLIvDKFfT2r5/ak68WRXNSVG1M1Va3hiw1+UtnKxgaNk8gVomCMp?=
 =?us-ascii?Q?oeLsC1q9tVhsbx5ALCAef88W9aJZmWZhxgk9D/dA/wbi4Tjdsuqd9wkcERDS?=
 =?us-ascii?Q?+lGqqXTXidRe2uYXynoPQJ5Fu/B3iKrMTiBAHgS8G3db+j6bzHOimM+DljFy?=
 =?us-ascii?Q?tnWuxR3sePsIjlgsAbvfdOuDgvdl6R6Ck8dOpN4nKgnJAdUe/VcW69x5ZyVh?=
 =?us-ascii?Q?TqcCcbkmVMr3WcAVheFT2JoksgQjlRkAMgyt54KSrrSzr9Hf4ehmHBGz9UZp?=
 =?us-ascii?Q?PBCZHN6+sBsfmAi1ZeAg3M/Ez2vr9+sbtdQjjnlBMgg3DWeMCL4UgYw/TeUP?=
 =?us-ascii?Q?6S6i6pFlSxXxGWxWpMzzQeVbbDR0LJyOxfdGIDBEwUZy/JlSLLJ3GyhjWTYm?=
 =?us-ascii?Q?OhuuoRXgmVM0HVXqY32PYMkFL41+keD8QoUDVyT2jSyTwrlAl08FibaF0lhp?=
 =?us-ascii?Q?DLmkAFPsre6/7NjG1n3uXLkNMcJPdMUBXhv5aND4Rbsebqnf6f3S/hcL01cN?=
 =?us-ascii?Q?OWZSadC1OWfC6s4RuYtFKwPbEXqtoo1kmOT9SXP6ozcxPA9Vd6D7PsY8DRxJ?=
 =?us-ascii?Q?UzAzRiztN+qyWNNekdqxhBaWf0eFGe8QlRrFmZkyRtfp5lUygaBC13GVcIcj?=
 =?us-ascii?Q?VATrGqkeZ88Lo8bi8FTcmUK7xGSN+BSJ1E1BzU1SyGITe5qMlKACb8P2GWNN?=
 =?us-ascii?Q?/XL3uo4n7PTrU+Z1UmIX+I6dLhtgiifIb9EBLnJgLOMjbHpg4Ff9iwkgICsm?=
 =?us-ascii?Q?TCL6tHIQrahE25n6zaCuAuZAa0ixWKZUJ9mABHkTiWxCrzG2CzBA/A5pKCSH?=
 =?us-ascii?Q?Wfs6RBD771x4zXwlSZ/P1w1CwlhIlj5fT/PYOb9hU+AJt+Tf3xvQ/9jtwoHR?=
 =?us-ascii?Q?9OGejrQvTh65UEMtXPyU40lMBN9jpPHiAILo3BnVFREdcI60H29CSaKq5lSf?=
 =?us-ascii?Q?nWoOGvkuW3dkNukdQWGybf6l+ctLyVAUcKVI5bVikRPMNNqZnZVezGFYF+Sv?=
 =?us-ascii?Q?XUl3Q0rIrNXOGb6SYUg75LXb0gGabmQ0J6iudyJECXgd6Pl3PgLVOvRtXTp5?=
 =?us-ascii?Q?SuwXZ9BJnKM0eCs/yqRTR9+QyXheZWNqSj43iDMZb/K4YSj5kQRLLJyM+MGp?=
 =?us-ascii?Q?Sj/z/Uzcrw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7177.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb42bcc5-876c-4d69-8714-08def763ace3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 04:47:40.6584 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YTkIgC2cI/SOm5LStTDGxYG/2Dh1nmjDf+xgoCakcfCes+x1orCcyc0sIZF16bWQYIlGb1tJjFTvnre90I0XyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB12131
Received-SPF: pass client-ip=52.101.66.42;
 envelope-from=gaurav.sharma_7@nxp.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

ping

> -----Original Message-----
> From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> Sent: 24 July 2026 09:32
> To: Gaurav Sharma <gaurav.sharma_7@nxp.com>; qemu-devel@nongnu.org
> Cc: pbonzini@redhat.com; peter.maydell@linaro.org; Bernhard Beschow
> <shentey@gmail.com>
> Subject: RE: [PATCHv2 0/7] hw/arm: Adding Cortex-M7 Asymmetric
> Multiprocessing boot support for i.MX8MP
>=20
> Ping
>=20
> > -----Original Message-----
> > From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> > Sent: 06 July 2026 21:59
> > To: qemu-devel@nongnu.org
> > Cc: pbonzini@redhat.com; peter.maydell@linaro.org; Gaurav Sharma
> > <gaurav.sharma_7@nxp.com>
> > Subject: [PATCHv2 0/7] hw/arm: Adding Cortex-M7 Asymmetric
> > Multiprocessing boot support for i.MX8MP
> >
> > Changes in v1:
> >
> > This series adds Asymmetric Multiprocessing (AMP) boot support for the
> > Cortex-M7 core on the i.MX8MP SoC. The M7 firmware can be loaded and
> > started from Linux running on the Cortex-A53 cores via the remoteproc
> > framework.
> >
> > The series introduces the following peripheral models needed for AMP:
> >   - GPC (General Power Controller)
> >   - GPR (General Purpose Registers)
> >   - SRC (System Reset Controller) authored by Bernhard Beschow
> > <shentey@gmail.com>
> >   - MU (Messaging Unit)
> >   - Extends the CCM with M7 clock outputs and wires into the i.MX8MP So=
C
> >   - Enable Cortex-M7 boot in i.MX8MP EVK functional test
> >
> > Changes in v2:
> >
> > - Removed the usage of device_class_set_legacy_reset in imx8mp
> > gpc,gpr,mu and
> >   src.
> > - Removed the usage of 'smp' , 'maxcpus' and 'enable-cm7' to make the
> >   invocation simpler.
> > - Cleaned up imx8mp_src by removing redundant/unused code.
> > - Updated Maintainers and improved the imx8mp documentation
> >
> > Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> >
> > Bernhard Beschow (1):
> >   hw/misc: Add SRC (System Reset Controller) to i.MX8MP
> >
> > Gaurav Sharma (6):
> >   hw/misc: Add i.MX8MP GPC (General Power Controller) IP
> >   hw/misc: Add GPR (General Purpose Register) IP to iMX8MP
> >   hw/misc: Add MU (Messaging Unit) IP to i.MX8MP device model
> >   hw/misc: Extend i.MX8MP CCM with Cortex-M7 clock outputs
> >   hw/arm: Enable Cortex-M7 AMP boot on i.MX8MP
> >   tests/functional: Enable Cortex-M7 boot in i.MX8MP EVK functional
> > test
> >
> >  MAINTAINERS                                 |  13 +-
> >  docs/system/arm/imx8m.rst                   | 188 ++++++++++-
> >  hw/arm/Kconfig                              |   4 +
> >  hw/arm/fsl-imx8mp.c                         | 220 ++++++++++++-
> >  hw/arm/imx8mp-evk.c                         |   3 +-
> >  hw/misc/Kconfig                             |  12 +
> >  hw/misc/imx8mp_ccm.c                        |   9 +
> >  hw/misc/imx8mp_gpc.c                        | 146 +++++++++
> >  hw/misc/imx8mp_gpr.c                        | 153 +++++++++
> >  hw/misc/imx8mp_mu.c                         | 328 ++++++++++++++++++++
> >  hw/misc/imx8mp_src.c                        | 275 ++++++++++++++++
> >  hw/misc/meson.build                         |   4 +
> >  hw/misc/trace-events                        |   5 +
> >  include/hw/arm/fsl-imx8mp.h                 |  29 +-
> >  include/hw/misc/imx8mp_ccm.h                |   3 +
> >  include/hw/misc/imx8mp_gpc.h                |  34 ++
> >  include/hw/misc/imx8mp_gpr.h                |  56 ++++
> >  include/hw/misc/imx8mp_mu.h                 |  53 ++++
> >  include/hw/misc/imx8mp_src.h                |  31 ++
> >  tests/functional/aarch64/test_imx8mp_evk.py |   1 -
> >  20 files changed, 1539 insertions(+), 28 deletions(-)  create mode
> > 100644 hw/misc/imx8mp_gpc.c  create mode 100644
> hw/misc/imx8mp_gpr.c
> > create mode 100644 hw/misc/imx8mp_mu.c  create mode 100644
> > hw/misc/imx8mp_src.c  create mode 100644
> include/hw/misc/imx8mp_gpc.h
> > create mode 100644 include/hw/misc/imx8mp_gpr.h  create mode 100644
> > include/hw/misc/imx8mp_mu.h  create mode 100644
> > include/hw/misc/imx8mp_src.h
> >
> > --
> > 2.34.1


