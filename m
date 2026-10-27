Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9E9606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 14:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=b5zFMZgp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLiOr-0003kF-EL; Tue, 27 Oct 2026 10:43:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1xLiOp-0003Zg-1R; Tue, 27 Oct 2026 10:43:39 -0400
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1xLiOm-0006mS-T1; Tue, 27 Oct 2026 10:43:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IIrvwJ3rzNuPcWZ5efCbzuRj84Wp/kWgjZz1x/mCaKD1Vp1uF2+JH+2smHNmwPvlXIoLUD8Wi1S9CJqg0aJifdFwRt7+Y5GJXiBu5Gpee1JM6CJqvXDdfqbIH+4uq1J8dIofhRQHIBDFkPl/swptl66mSd7ErdLyCqgJI7SX3azUwGXhw6fXYSGB44Y/Ca5KO0Tf1DhTKgR3dv4+kyY6eof/DK8c6RR/zD4Q/9Kp8TCgKO1ehT9TaXDuKX8gdZpug27ABy0nD/UcsLVonWyQuuo9bdaVzZeLaBgB0GCCSiwM45MV9KiYbzMs7Fgy+WX+ChOs4iXO75gQNLw/salPVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yX6lR7hdkPTzJccDzBEqSFj6Jh31ihRqDsYgtI8vbdw=;
 b=m5TD4KLN0lsEVHVHFCQlQ4b+zATKWoinB5/KgjEG03UNB49YvSWgtHMa7sRWiVNCpeNB8NuD4TmIUow3kld39sNRaxaWPBpjChUNlPeQztJ8ctIurMofys0ifLLJ7ivwiO50NqGfQclTgNl4sjbVUTk+nvkk87lp0xxAxCWD4oO6Ggm6z5Gu34Kszs58wAvlm9O8lvGu4QOtE4EU5Q+FFuX8mcSBC6keIOHycRr8IGTIzidGeTFKgah0aHgGdl+kq/WE3ELt/FadFnx1lzenKDxBojxfpb7NNEhUvxmCPPorSGSCUWokc9UjXo/OZEsb2og/sKGJh0JHz5WrozdkEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yX6lR7hdkPTzJccDzBEqSFj6Jh31ihRqDsYgtI8vbdw=;
 b=b5zFMZgpizcN/U1bImLsqUKd700HOpOYs0AVVn4yEjbZBK6YDr4FRaSCxe5ZNT6gsALqKnHhFqYA8RBrlvA1fOxN9B3GJCYlYzV29n0SI8W8XhVPBOsiWysXdCXVgklLhMZkqegtqadM014wunBZZMJFLijND8O9/388MCSGV0ftuLu3X8mb0BAVwrrwPa0el73Knl+Cb3E+UDyiSC+qBu7pnhW1lAjurbdsTfpmmIlJ5rEx20I11Kh44tS1uUvgL1s2UreVs+KxXYsHfXzISMW4Yc3GYA8F9Tp9MmdmO1XhG+sHxjIUQFiBdncagt7GjBIQToEXqnHQyPQyN7cnqQ==
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17)
 by PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Tue, 27 Oct
 2026 14:43:29 +0000
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b]) by SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b%5]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 14:43:28 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Tushar Dave <tdave@nvidia.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "marcel@redhat.com" <marcel@redhat.com>, "devel@edk2.groups.io"
 <devel@edk2.groups.io>, Alex Williamson <alwilliamson@nvidia.com>, Jason
 Gunthorpe <jgg@nvidia.com>
Subject: RE: [PATCH 1/5] hw/pci: introduce PCI fixed BAR properties
Thread-Topic: [PATCH 1/5] hw/pci: introduce PCI fixed BAR properties
Thread-Index: AQHdRg0IOReaIxB8eEKLKF0CFzAF/bcRtdEw
Date: Tue, 27 Oct 2026 14:43:28 +0000
Message-ID: <SJ0PR12MB861469AD6121282858D853C0AB602@SJ0PR12MB8614.namprd12.prod.outlook.com>
References: <20260916185554.917526-1-tdave@nvidia.com>
 <20260916185554.917526-2-tdave@nvidia.com>
In-Reply-To: <20260916185554.917526-2-tdave@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8614:EE_|PH0PR12MB8800:EE_
x-ms-office365-filtering-correlation-id: f9a2b62e-dfb3-4d78-3d78-08df3438aa1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|6133799003|18002099003|22082099003|10067099003|261026140227099003|4143699003|261026121527099003|56012099006|11063799006|261009223027099003|261022075727099003|261022105027099003|261021121427099003|261021123027099003|38070700021;
x-microsoft-antispam-message-info: LwxVDn449dtfzUzRcBDoDhQrL2o+H71XTTi7RiQluHEsmbXau3v3M/qR1VAR7q0jOg8wmJCacQiWiX49BhVGqYhWjle/SKjkzN8E3QCfMksFBPshNM7RbZgiFOBoqI2EsALkXnq3ssW544ldLqd9RRROsyBZPiDLmFY+CobWMBxXqFlwMsDe64W+r7m+LsPxiWkwvEFuGxV7pcHjcBIL59S1NQ3TmaLISBmmmyTGtfGY4K+2LtdNh2kZZ8WEasOk86wUdG1v51nwOBxffzBdKlz1DT88SvUKpUeYgfCfCGKIHI/b15qmgejXk3C238Fa0jMvsfO5olwD/BIIKRb4VnSb5pwO3MU5ZN4mlTjY/8XM3LVJlptFLM29ypHyMCpTTmDp8s49qfSGG/8ocU6bftBUCCh0eYEigHagqNiQZ2LY7oTgp6PI8sU3QHRcNmkCf/hdwdgzAmbFu9y49lwVs3HwQZpoI4f90a4DZb6w0gey5PgUjwNf4aemKG3qnS7v2y1z+Te3ZeY8km85Myryyye6ARVvemAqWoIAnMmHmusdzWtc4d7BcsfqXyQlef/tan+HedZOSZbpi1c2zRRXbVJHFmUK9gClztxJKORbUxmWiKoGZp8KbXLACw3MyBT7Iu9VZJoTt52UOF2TZkcu7eStk5YZ7voWokG6Rl36Tj4mlLpitYBL+JeGmr+KTa3V82UN/b7C5nStHXbQLBxPIjG/Zx7jCnfs3MsGmwXHCCY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB8614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(6133799003)(18002099003)(22082099003)(10067099003)(261026140227099003)(4143699003)(261026121527099003)(56012099006)(11063799006)(261009223027099003)(261022075727099003)(261022105027099003)(261021121427099003)(261021123027099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YbK++qOC13jHT34k/YMWFWSYgfLvi89DDGmQ16b+8L/LTjw2zTEPznSkb+NR?=
 =?us-ascii?Q?cdEZupuqzXdu0UeTmAiNstVR22XBjk+lKKC0LML6/QvekJVhAfUugWGSEGo0?=
 =?us-ascii?Q?gCN4B9/+iZJPaWpQRIuI9jd3QedQdsxd/CdiRn1DS+Fcx6QOKHqrqDWk2LM4?=
 =?us-ascii?Q?yqYNOI0GG0/XGNjUz2l9mPLZs2qJdVJQvyRm66UucjGxINZILsiuOswZ8mk+?=
 =?us-ascii?Q?Iy1/Y3dCgG/3rb+VFTXoGmNhB2rwX5DAwUIRCgrbjqQKbWpmYLfGNWIk1S6b?=
 =?us-ascii?Q?3rMCS4ITMdlBTsDrBqGJ1gQaxJoSnEmRd5iEPxaIxDbDCn+Riu5Wrg1YUwZ9?=
 =?us-ascii?Q?vI150lB3vUMSFDxTrzphJ0wTyloEUSbI3xYCt47UckbMu/3GfyfYp91X/CoI?=
 =?us-ascii?Q?R0dIxmpPlswzNn/vxU7HmlZVqErchteQE7Ch5XiLPagv1XMFsDpEfMafcAek?=
 =?us-ascii?Q?vu2Avw76ET7FrjGTiDuKSwFW/9y2hJmMO10jM9MQv01jfq+gGbrS7zVyMCXj?=
 =?us-ascii?Q?iMADyNCtymYsJY1V4znVc9Jc6aiC2FoMqX7lEAm57h9fNC8oW78gvjxsyCWT?=
 =?us-ascii?Q?2kMlBTWkoy/Z0N7o0Ni1O9vh+DaCKIsjePIyg5nrFXIpMCLtWvQiszMq0ndS?=
 =?us-ascii?Q?oJWh6IiHQAsxlFc8LSwOI3g3CLjWioIPwb+0ScCMXjtYXc1SqlzyDa+t7MpV?=
 =?us-ascii?Q?Edz7nJMS2U1dKbVsnwaIoXXFyHyVYQvWPOYjDaGh4C0HDAFcO7EKPiGZjz4k?=
 =?us-ascii?Q?pDsC7XQXR2D2tID21Tnc2Tfah9+j+G7hs5j+36bXW5p0GiNlZ4dJEUJkxC4t?=
 =?us-ascii?Q?59pGET58VKpfAzaVEdSCvq/k9guHFCVkfyoGzZnEve0C475q9hsNwovjQGVB?=
 =?us-ascii?Q?xKozVcYHz1Of39aCptjkb7sH03jC6vu5HZLhJ/Zyn7zUmECGt6uLra/VusDd?=
 =?us-ascii?Q?Ujf6mNedV9FFlOi+tMYlkG81wCq4xgCS1k/V3rjaOPs/NlBy8J88hhGXPl2e?=
 =?us-ascii?Q?sQ4jCwia0I8N9ZPMeeSzoSvqkjj3l+rQc3sumPb3iTlFZdm0rsnNApXxDNCN?=
 =?us-ascii?Q?DWr7xg02orjemWt4OMBzvqiLe5S8hsjYF89BDlWt1lbbmtyUuN8XDk4/iTjf?=
 =?us-ascii?Q?otgPZ84TmcS/AicQ47C5HCfYv//MY4IT4pacygVWRvvyHqI930HshsomaTW+?=
 =?us-ascii?Q?UPobXD4bnjoJVjhBsD9yNh/B86M8cmRCBNF4XLuGIgt8acgBrslbekoTAMp2?=
 =?us-ascii?Q?sd4RDn8ggcmDSGgtrsmwXlUEVQcow6UmX6GKjQGOTqe1s+tFJP0s8kJmrLhQ?=
 =?us-ascii?Q?QcBk1XXRzSVKi+5Qjjgqs9Rx4UkLSYYSxOUCHUU4XDHaCFDH7ENyxh/GUFkY?=
 =?us-ascii?Q?aGKIsCr5Vexu7jjMwLyY/U1X4n858ERgPJeSdY06t2jv1J/jtl900gW5d2nN?=
 =?us-ascii?Q?XtssvtiE1XgBwo5Ex6yyB17bQUY+tNOFXlBiDB05cVF7x9MI8/GflVyWL8Ml?=
 =?us-ascii?Q?4lfY3YwKmVTA7+Km2wkrPBwjlUhLNzxrki0EsKvUPeuTD9UiHJhQgIDC6/Rq?=
 =?us-ascii?Q?oeVQuBO9BAn4IjwxSAtwpfD1lxCB4qUNyI65cfINDjix3JltbtmMNy+AzHJh?=
 =?us-ascii?Q?7eAdlG95PI0yNRZpYf0tt4dnjrqYysgQKngpJ+adLpsTXwfmFBeWwCcfrcC+?=
 =?us-ascii?Q?h4evDVbQ8PclhdgQ0PivgCvZd/btsym+FJ+pdlydZefLohFmhNu5Bq7EsBNA?=
 =?us-ascii?Q?STZtURK42Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9a2b62e-dfb3-4d78-3d78-08df3438aa1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2026 14:43:28.6539 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Djbr7xcQizNL56BIHzxxfbGDvFoUIjKvrsOk0MsRkGD6ZXLj8lUJ50Wb3wEmvFv6+QkT4krbf6MU4E450Q5XGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8800
Received-SPF: pass client-ip=2a01:111:f403:c001::2;
 envelope-from=skolothumtho@nvidia.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



> -----Original Message-----
> From: Tushar Dave <tdave@nvidia.com>
> Sent: 16 September 2026 19:56
> To: qemu-devel@nongnu.org
> Cc: qemu-arm@nongnu.org; peter.maydell@linaro.org; mst@redhat.com;
> marcel@redhat.com; devel@edk2.groups.io; Alex Williamson
> <alwilliamson@nvidia.com>; Jason Gunthorpe <jgg@nvidia.com>; Shameer
> Kolothum Thodi <skolothumtho@nvidia.com>
> Subject: [PATCH 1/5] hw/pci: introduce PCI fixed BAR properties
>=20
> Add fixed-bar-N properties to PCIDevice to allow the guest address
> of an individual PCI BAR to be explicitly specified. The properties
> are available for PCI BARs 0 through 5 and accept QEMU size
> values, for example fixed-bar-0=3D0x40000000 or fixed-bar-0=3D64G.
>=20
> e.g.
> -device some-device,fixed-bar-0=3D<addr>[,fixed-bar-1=3D<addr>]...
>=20
> During realize, validate that each specified BAR exists and is a
> memory BAR, and reject fixed BAR configuration for hot-plugged
> devices.
>=20
> Signed-off-by: Tushar Dave <tdave@nvidia.com>
> ---
>  hw/pci/pci.c                | 43 +++++++++++++++++++++++++++++++++++++
>  include/hw/pci/pci_device.h |  7 ++++++
>  2 files changed, 50 insertions(+)
>=20
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 0efb4eb4bb..775fef1beb 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -89,6 +89,12 @@ static const Property pci_props[] =3D {
>      DEFINE_PROP_STRING("romfile", PCIDevice, romfile),
>      DEFINE_PROP_UINT32("romsize", PCIDevice, romsize, UINT32_MAX),
>      DEFINE_PROP_INT32("rombar",  PCIDevice, rom_bar, -1),
> +    DEFINE_PROP_SIZE("fixed-bar-0", PCIDevice, fixed_bar_addr[0],
> PCI_BAR_UNMAPPED),
> +    DEFINE_PROP_SIZE("fixed-bar-1", PCIDevice, fixed_bar_addr[1],
> PCI_BAR_UNMAPPED),
> +    DEFINE_PROP_SIZE("fixed-bar-2", PCIDevice, fixed_bar_addr[2],
> PCI_BAR_UNMAPPED),
> +    DEFINE_PROP_SIZE("fixed-bar-3", PCIDevice, fixed_bar_addr[3],
> PCI_BAR_UNMAPPED),
> +    DEFINE_PROP_SIZE("fixed-bar-4", PCIDevice, fixed_bar_addr[4],
> PCI_BAR_UNMAPPED),
> +    DEFINE_PROP_SIZE("fixed-bar-5", PCIDevice, fixed_bar_addr[5],
> PCI_BAR_UNMAPPED),

These properties are exposed on all PCI devices, but only virt wires up
the validation and fw_cfg export in this series. On other machines, a
valid request would be accepted without placing the BAR, right?

I think it is better we add a mechanism(MachineClass flag ?) and check
that.

Thanks,
Shameer

>      DEFINE_PROP_BIT("multifunction", PCIDevice, cap_present,
>                      QEMU_PCI_CAP_MULTIFUNCTION_BITNR, false),
>      DEFINE_PROP_BIT("x-pcie-lnksta-dllla", PCIDevice, cap_present,
> @@ -228,6 +234,36 @@ static void pci_bus_unrealize(BusState *qbus)
>      vmstate_unregister(NULL, &vmstate_pcibus, bus);
>  }
>=20
> +static void pci_check_fixed_bars(PCIDevice *pci_dev, Error **errp)
> +{
> +    PCIIORegion *r;
> +    int i;
> +
> +    for (i =3D 0; i < PCI_NUM_REGIONS - 1; i++) {
> +        if (pci_dev->fixed_bar_addr[i] =3D=3D PCI_BAR_UNMAPPED) {
> +            continue;
> +        }
> +
> +        if (DEVICE(pci_dev)->hotplugged) {
> +            error_setg(errp, "fixed-bar-%d is not supported on "
> +                       "hot-plugged devices", i);
> +            return;
> +        }
> +
> +        r =3D &pci_dev->io_regions[i];
> +        if (!r->size) {
> +            error_setg(errp, "fixed-bar-%d: bar%d does not exist on %s",
> +                       i, i, pci_dev->name);
> +            return;
> +        }
> +        if (r->type & PCI_BASE_ADDRESS_SPACE_IO) {
> +            error_setg(errp, "fixed-bar-%d: bar%d on %s is an I/O BAR, "
> +                       "not a memory BAR", i, i, pci_dev->name);
> +            return;
> +        }
> +    }
> +}
> +
>  static int pcibus_num(PCIBus *bus)
>  {
>      if (pci_bus_is_root(bus)) {
> @@ -2393,6 +2429,13 @@ static void pci_qdev_realize(DeviceState *qdev,
> Error **errp)
>          is_default_rom =3D true;
>      }
>=20
> +    pci_check_fixed_bars(pci_dev, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        pci_qdev_unrealize(DEVICE(pci_dev));
> +        return;
> +    }
> +
>      pci_add_option_rom(pci_dev, is_default_rom, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
> diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
> index 5cac6e1688..fc5f50a1c4 100644
> --- a/include/hw/pci/pci_device.h
> +++ b/include/hw/pci/pci_device.h
> @@ -187,6 +187,13 @@ struct PCIDevice {
>      uint32_t max_bounce_buffer_size;
>=20
>      char *sriov_pf;
> +
> +    /*
> +     * fixed_bar_addr[N] holds the guest address configured via the
> +     * fixed-bar-N property for memory BAR N. PCI_BAR_UNMAPPED means
> +     * the BAR's address is not fixed.
> +     */
> +    uint64_t  fixed_bar_addr[PCI_NUM_REGIONS - 1];
>  };
>=20
>  static inline int pci_intx(PCIDevice *pci_dev)
> --
> 2.34.1


