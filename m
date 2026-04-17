Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E365AF4368E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 11:00:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDgvs-0004ZB-NO; Fri, 17 Apr 2026 07:00:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1wDgvf-0004SL-Ny
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 07:00:07 -0400
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1wDgvc-000293-8F
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 07:00:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kWvC3k7djHnTp8eAlZshmluzpkxwBVyuFZDvm7Ni5aHu6BaRTcYvtkvn4vXvl6yPPtZBH/1e+Z8QWmKvJXiqlGGiW1h+18qG236zntZp3fAmIDObA5emW7rG7LetQJNLHffWLL2wFdg8qpdsTMCtZ0B9NFh4jA6Z420MUTJWNQFj+rVuJ1ZWkJPzazX81EC3bswnvOr9oIlQMrdaI51Sv3+n1wNSt4ZyoEzABRcrr4oiS+A7+QLPPgIGqnmi6bclPN/EIU1ilbcaPGOoBwqKLkaqgO88+Gt4+SQFedDwqwTuZOhvQN24l4ddHFrzMjF/3h1gAmAs+mBTO60dFJTZuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VkhCsOygCwLdlemt/MBfY03OvGyKGZdFipNSBYVH+dU=;
 b=WS3KTIMWRWzW6kBOHC0WDVYYSO5feRF1QyoptY3jvM+mgn9p/Mg2Zqy0JhhhDvweKb8XG0aiWA4ES8JEs2uSRSjTTXxdl6lyNWMyx+x+p0fKG1Aa2Lgq1WZ6IFvCJiWD/Xywy0TFy4Tg0nbOM6OsOtVrFlaOXKNXkXdK4SeU21TysdxOZ+vpjJBx9FsbEyw4XqP4/Ygoa9DVe2jYwCqZm9WCcrP83zdSDGgdajZuvziN9gge1euIeJhukZCIXYn1aZ2C+NAGmFaGzPIBGOY+YNJvoFtP0qEhoHkO2Kq9jjeEuZtNTleFKjcgYZYaWBgAH9Bsc2dWhqg7wulDicLYjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkhCsOygCwLdlemt/MBfY03OvGyKGZdFipNSBYVH+dU=;
 b=ayFJE+6He7tAWE74O2iJjGF/Uvm3CTl0BuwoRrBy1xaGTSjdcGa8W+QdKGm3fDAaLIc/gzRzolUFy07aZwJpYp/bm/TpYB+na5SUQsnvBlXpgjVxOITM0Pyi/3QbFcTMdCiPctxE5HSx0raSstQaicKuWluKip75amAHZVhOcH1f2L3Z40QujUG0z0SyYUdGr8isGmmbZlRua5kkgTcCBXxqgjpbwfqfA6ypZtCtshSkxZb+vUrFicDUkO1fhMiCCDUcmfsGFXnrVIm3BGfab3BfmP9RduU0vhwmvZOqgvb+2Yfe9D/IIvGZ+n5YqSqwyI1M8JaZLb38M3zgtYJ6lg==
Received: from AM0PR04MB4370.eurprd04.prod.outlook.com (2603:10a6:208:6e::32)
 by DB8PR04MB7195.eurprd04.prod.outlook.com (2603:10a6:10:12d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 11:00:00 +0000
Received: from AM0PR04MB4370.eurprd04.prod.outlook.com
 ([fe80::fe3b:fb2c:9dfc:9b]) by AM0PR04MB4370.eurprd04.prod.outlook.com
 ([fe80::fe3b:fb2c:9dfc:9b%6]) with mapi id 15.20.9745.035; Fri, 17 Apr 2026
 10:59:59 +0000
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: Bernhard Beschow <shentey@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>
Subject: RE: [EXT] Re: [PATCHv6 00/15] Adding comprehensive support for
 i.MX8MM EVK board
Thread-Topic: [EXT] Re: [PATCHv6 00/15] Adding comprehensive support for
 i.MX8MM EVK board
Thread-Index: AQHczDvGHZEy6jW3qEa/d8JkfGoghLXjAr+AgAARnbA=
Date: Fri, 17 Apr 2026 10:59:59 +0000
Message-ID: <AM0PR04MB437073FD81E5B77C2F32EB0D87202@AM0PR04MB4370.eurprd04.prod.outlook.com>
References: <20260414182313.1691519-1-gaurav.sharma_7@nxp.com>
 <90624B7D-1B69-48C0-A159-4837ED9A1CBA@gmail.com>
In-Reply-To: <90624B7D-1B69-48C0-A159-4837ED9A1CBA@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB4370:EE_|DB8PR04MB7195:EE_
x-ms-office365-filtering-correlation-id: 9e6dfc37-0776-4eb5-7de8-08de9c70782d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|19092799006|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: vJjroabJWztmfVuvLfaKqV5nSIvwZIXoM3KwhTbM/C0jXlyCPZknuiAhenw4cSTMOYNqc3gQxrrordPP6np/TI6xgZivuomEOMbTzKlMMqsjM9AlSZ9w7w9BVTxG1LJtQ8tst/kiC8JK6+5jGFtCxktPCcGmrOyPO4Nlqjy1mJlccaomcKN8bnCyQWHN7o9lO4xNLylUBvdXaOL5/p0u5bxsurq+ydNc515uMkOpVvavCLwztIMHQ+zD1JBjCx+HIiTjoFR686Rqjn5+dcV5nZ3UBw8iUPegL8kDGDl909y+mCP0i6ftpBAlHcqmQ4xDSbp/vK/+Ka4LFhsNe+sAn/hhM71fXzkpAcHkHmTlEGEAzf7jV9YLomrHNFeUs9NHrSb7AESWUcW4EK40Ldq6S24kzYtXMgAizAz0Sq8mp692UuKGYIft/Op57COsrG+grkNLzGRitySj+6FDVw98tj3RmMe5cRKHcfQopHHuLu0JjmiiwpFFfE2hzU2v/Fc3zBgAK2KgI3QlEdox3AymdrxdQpEVDxKSLGQD24BkaZZGbbp9+VG+V2uGoiTZlsZ9S6Y4l3IEkwcbN/sOO1RXgqCeY7lhO0wspnAbQPYIJQ/SpD6PQgMKsuwRZXWVtu7YdAMW/36EFxDutcLGNUdJCtiaXJ+d7AritI3N+EiyPUw3RIRLdRZb047dcYpfBAg3sqjdZI5RY/81gGsnNU8GwKXd9OtwjUEnYXD1612tZjT0Vb+1IKV5Ja1x1FXwajzJ5xRh3AqZLLH/4cwdnwQFbTY610lSSJ85SW/+uWtwsK4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4370.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gZUvzJfRC2yAf+mgJFQypraewx3FvvxcpwyNQMSlKf5YI8G1AgXNhlIFkPkv?=
 =?us-ascii?Q?De6GHvxSV0i0X79uC2EX0VAv+vRonWiKcW0BBvzsWQ2KCw+a+9JzMTDrHQk1?=
 =?us-ascii?Q?91JiHb0n4uFANzuBrCgNOm2sgRD7JujI+4aSZWzDwUgcV73bjzcJqxBGN+FN?=
 =?us-ascii?Q?VVkl9o0hFapMbS90R0Ylcv5fiHCiVn52yI/qNvx45uRkq39uYGEPrHV6ptCK?=
 =?us-ascii?Q?hZPM/QFJveJpgqdw27K0759sXyNlFh+Q0TzQmn8G0k/QncybZKIIotRzbWQc?=
 =?us-ascii?Q?5v3FbyCJ/cb3TITSII7Fq0WyjJaeJqytSyJp00nzApg7mpgaZn57DgcBMPFf?=
 =?us-ascii?Q?c3aarghipNvCqPjJthAoV3X1RtiALvJmrHJ7RnDnMmElNAAes7WJbV5R76eK?=
 =?us-ascii?Q?5JzRtG3Nk1NcpBCp7nWE6mCTODVoj90S23Y4YuYx1pHv8typibY64mLHmYsQ?=
 =?us-ascii?Q?CqG0jmJQ2PdBitoUvRBrvfi6qJzE3gp/ptF56GXTfHZRA0MAwrpwg09qDoUi?=
 =?us-ascii?Q?wMHCO2lkHiNMmN3CmZ7qZMB17CmCFEzRTqtg33qJCwXCiEq8M7oNeVdZdlvU?=
 =?us-ascii?Q?diKrYaS1Uvl719PrWifw5XociCxRn9UlimekdmESvLjf7wUyR1g9Q4PFTbE1?=
 =?us-ascii?Q?bcvvAl1gNFM+Ke7397Ln7C/aCXM9TZMtkIJc6g+/DKdrIpFKLXiWJFhD+Xwj?=
 =?us-ascii?Q?nWs+RExQk3yYJxxUIlgVozMG5Iga9zSI31varP7t4riP4gGfZz3YAvJXjgW7?=
 =?us-ascii?Q?K9kBf57z8jYamCMigm2i+uWlIDWINTq4LtgG/zvjnKZHVgfAL4Es/4a7QhHu?=
 =?us-ascii?Q?I/WhklofuWWOnUKsYZE/D/6pWxlkl197c/74jfre/yY2krMN7XJOHvqbDi37?=
 =?us-ascii?Q?muFHXbnWLj1LGUoTM6/ncxDXK+BuBixQNrayEEnGwplCgJ3gEsvlT9v/mwuD?=
 =?us-ascii?Q?zBRQM4CZqi4P+6MC1JIqbAhXskYAa6S8vlHc87Sh4Ds7s04IybJC7mrvSBcj?=
 =?us-ascii?Q?1Y2ICEUvoZrmGALhK3mTO4Hoxm+xyU7/P2fnHlxv6cPDuPOwpungiSm0Uqn/?=
 =?us-ascii?Q?iU0xHhloxegbDKQcroc/PMLpp9RcPyHvM2RlrSB2tStfRIS1cP+FizI2iYBb?=
 =?us-ascii?Q?XYjNpVz7Y3AcUNLhrNuDG/8cntTRN/pRhl0AwCBxBDc5UAdT233rk1uXruaM?=
 =?us-ascii?Q?9PoW8PzFQQeKaBvTCdyb1YT5muXWZAsWHp267Tg4/sM8WzLJ6VP4u1I1lPMB?=
 =?us-ascii?Q?nJ/8CVK197eaPsU6iMEy9ViI2rd96Y2+OHjW5isaFhSL61w7CA6P0CtN3O+1?=
 =?us-ascii?Q?UQeYxiqerTTqU+cUqCgeJsk/N1Z5JlQCd0M0tpys+MxroYZuPK3Lk8OjxVOC?=
 =?us-ascii?Q?a9ziN9bY55OeKrSWMosPhf5Jb4bznlyheNT+7m0+JqZ9ucuYKEH0hdb/60A3?=
 =?us-ascii?Q?a9P6O33rwQ3TPDB5ZrjRGF7oiKf3KWDqPDFCdZKZ4mqGO2h+Qzuq7nG83gnR?=
 =?us-ascii?Q?NTKm4X1vjLgzyJoipSxx46DzS02t4O4yavB7nu9bFCnynnkc6gpBvPzZXizn?=
 =?us-ascii?Q?TVGWKYAdpXA7FYXaTLfi/1DitVlzoK23VuLUeQIWAzZDIxdqfXxFQ9gwBv41?=
 =?us-ascii?Q?vE9N3wlT70rzWoFKGBa2ZRbPO/Pfj2/blzQCOHdBSJ6BWBY8AZkTxyTfWNXr?=
 =?us-ascii?Q?LrSMSx/MEt6ZKq71bhzl3v9CgeMfcMwH5Een8vRk9RP2zI54MaIQdg/JnMrZ?=
 =?us-ascii?Q?AiKiK6hwgg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4370.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e6dfc37-0776-4eb5-7de8-08de9c70782d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 10:59:59.9294 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p0Z6oaVVzzwvsJDRj1SdFmj8esyLpbVoKDn4AxhkZ+D0w1e+fYpYV5Hv8rQbedDRCTfjSX1AdBGRq0WmZF4oNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7195
Received-SPF: permerror client-ip=2a01:111:f403:c20f::7;
 envelope-from=gaurav.sharma_7@nxp.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
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
> Sent: 17 April 2026 15:06
> To: Gaurav Sharma <gaurav.sharma_7@nxp.com>; qemu-devel@nongnu.org
> Cc: pbonzini@redhat.com; peter.maydell@linaro.org
> Subject: [EXT] Re: [PATCHv6 00/15] Adding comprehensive support for
> i.MX8MM EVK board
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> Am 14. April 2026 18:22:58 UTC schrieb Gaurav Sharma
> <gaurav.sharma_7@nxp.com>:
> >Changes in v6:
> >- Fixed checkpatch errors
> >- Moved maintainer entry of test_imx8mm_evk.py to the patch 0015
> >- Renamed imx8mp-evk.rst document name to imx8m.rst
> >- Fixed warnings that are generated while building documentation
> >
> >Changes in v5:
> >- Fixed SoC object reference counting by using object_new_with_props()
> >  instead of object_new() + object_property_add_child()
> >- Merged imx8mm-evk.rst documentation into imx8mp-evk.rst to avoid
> >  duplication and updated the title accordingly
> >- Added on-chip RAM (OCRAM) support to match iMX8MP dev
>=20
> Please keep my R-b tags from v5. You can conveniently add them to all
> patches in the series using b4:
>=20
>   b4 trailers -u -F 20260414182313.1691519-1-gaurav.sharma_7@nxp.com
>=20
> where the last argument is the message ID of the cover letter of v5. See
> <https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.
> qemu.org%2Fdocs%2Fmaster%2Fdevel%2Fsubmitting-a-patch.html%23use-
> b4&data=3D05%7C02%7Cgaurav.sharma_7%40nxp.com%7Ccc5a9fde05764500f
> 11308de9c64c092%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63
> 9120153705943610%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRy
> dWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3
> D%3D%7C0%7C%7C%7C&sdata=3DE%2BoH95jAjL1HfIlGpUOKAZJbCXCsd09tNCv
> MDIdqICQ%3D&reserved=3D0> how to set up b4.
>=20
> Best regards,
> Bernhard
>=20

in v5 you gave your Rb tags to patches 0,2,3 and 4
in v6, the tags were retained on those patches. Is there any other patch th=
at I missed?

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
> >Reviewed-by: Bernhard Beschow <shentey@gmail.com>
> >Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> >
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
> > MAINTAINERS                                   |  12 +-
> > docs/system/arm/{imx8mp-evk.rst =3D> imx8m.rst} |  35 +-
> > docs/system/target-arm.rst                    |   2 +-
> > hw/arm/Kconfig                                |  24 +
> > hw/arm/fsl-imx8mm.c                           | 704 ++++++++++++++++++
> > hw/arm/imx8mm-evk.c                           | 130 ++++
> > hw/arm/meson.build                            |   2 +
> > hw/misc/imx8mp_analog.c                       |  12 +-
> > hw/timer/imx_gpt.c                            |  26 +
> > include/hw/arm/fsl-imx8mm.h                   | 242 ++++++
> > include/hw/misc/imx8mp_analog.h               |   3 +
> > include/hw/timer/imx_gpt.h                    |   2 +
> > tests/functional/aarch64/meson.build          |   2 +
> > tests/functional/aarch64/test_imx8mm_evk.py   |  67 ++
> > 14 files changed, 1253 insertions(+), 10 deletions(-) rename
> > docs/system/arm/{imx8mp-evk.rst =3D> imx8m.rst} (68%) create mode 10064=
4
> > hw/arm/fsl-imx8mm.c create mode 100644 hw/arm/imx8mm-evk.c create
> mode
> > 100644 include/hw/arm/fsl-imx8mm.h create mode 100755
> > tests/functional/aarch64/test_imx8mm_evk.py
> >

