Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F8DECD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 15:14:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZVTl-00027L-8a; Tue, 16 Jun 2026 11:13:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wZVTj-00026y-7i
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 11:13:27 -0400
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wZVTh-0005Lq-JS
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 11:13:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IRcPw4EetxB+o+X/gI5BF6GzO3eDrnYrmdAKG4uK2wDFBmGKyDUucwhXqfl42gaGe81xAcqeyPd9Wy2KRx3h2IMuz8uV/iekfGFzdbXW4U6KZEiZiNzW9/30nbeCrWvx3Zwd12Cs/Y/XExJY8nLTsllCNtI0vIsyZtWbSVc0EtLrg7+dgvEPSgoEzULgxFTkqsHSqWHxiUIECbZTKvbKm89204Vi96WTdKArhDZotDdS/QYOrlhbuxhLlks1r6b/N6DjyobiuMFaiap2oLvI6If3+LK/mkChECGB8UQXDfoCDAjc/MXJ8cL2//+ZiQuQln4SO+FZn2ExLvyWKo+xtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qwdXek3KdSXc9Tjb5CTz/0ybonCWNJsaeVFAhsJ1i8=;
 b=PZ21TaHK0mZXV7sqoav4lwNK1RkZ10uimT4QQjviKfuQ0CyxggKvb4AVzRGNSmaMIkIf2hCRZH86uJunnSvfN0Cca4p7d6EKwB6tb/BlKJ6fWlsaSOAXW/uJfHqfVu5ygliPZ90k92F364pLo0Dx0UXJGxuIeSvHslnsd/puzI7+oLfFycfoHSLJYYE255efa8Nt9u122hnj4NUDLSh5TI0LX1B7IW+xeLtyQVNznBP8BgvI73/ZI92efwq3w+CcB9FgoZH3L44YR79TAH7/ZfGmq+3JaklaqCP+KYJfLBdAMIFUFpIavVTmanHjhZ7v6+FhGS3i1h3uJq/pUHMutg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qwdXek3KdSXc9Tjb5CTz/0ybonCWNJsaeVFAhsJ1i8=;
 b=S7ptN4O1Dfuemiu76yK7DzJtZ6TamCGnUbwIgCPVdWOmTN62nvBEm4ixx41ZhZLUTT/VliGTrCm8k56gtIft9unehEXt2wYEVhDFvlvhIQxkhNv2EY3SoVZLcAu6e52tEp6Z/elRlF5X9FnVa69y4kpNsL2SaA92VejEA9ev1RpzD+ALcuWQElfKdufejtheXpXhkjGLkqbj8eHSYe/nW2+9/jA6U/aaDhn11MwRYkNMXJ9Pkqao5eAeglpO/YK33Cj2V/WQcFmTpEcpe2v1CPGjeP12ZgimoCB1niKUgUnfVF5XX/INWTppkHZxCiLQEjKao5rqFXZG+YC2fDEs6g==
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17)
 by PH0PR12MB8774.namprd12.prod.outlook.com (2603:10b6:510:28e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Tue, 16 Jun
 2026 15:13:18 +0000
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b]) by SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b%3]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 15:13:18 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Nathan Chen <nathanc@nvidia.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>, Zhenzhong
 Duan <zhenzhong.duan@intel.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@mailo.com>, Zhao Liu <zhao1.liu@intel.com>, Alex Williamson
 <alex@shazbot.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>,
 Matt Ochs <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v2 3/3] vfio/pci: Warn when ats=on but host device lacks
 ATS cap
Thread-Topic: [PATCH v2 3/3] vfio/pci: Warn when ats=on but host device lacks
 ATS cap
Thread-Index: AQHc/QhqJgvfK+xkkUqgmo4JGPIB/7ZBSkyA
Date: Tue, 16 Jun 2026 15:13:18 +0000
Message-ID: <SJ0PR12MB8614F625B742312E8A830FDFABE52@SJ0PR12MB8614.namprd12.prod.outlook.com>
References: <20260615204849.3659647-1-nathanc@nvidia.com>
 <20260615204849.3659647-4-nathanc@nvidia.com>
In-Reply-To: <20260615204849.3659647-4-nathanc@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8614:EE_|PH0PR12MB8774:EE_
x-ms-office365-filtering-correlation-id: 7579d705-5139-4884-e951-08decbb9cbd8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|38070700021|22082099003|18002099003|11063799006|56012099006|6133799003|4143699003;
x-microsoft-antispam-message-info: zWIO55BHKwLbW4esEEGIfkOMj+B5p9lzLDdvguVXezcP0S/OVump/+P1fDGVMjunUqJFIR9a3dUa5r8FxadkxIpXGfsbNOdGqmeqpxK/VkRgpKZb4h8uLX+VFQAwlvRUuwHbSZX0PeQOz2ARViFC4fmZ5oxtEd0tCcNGJUg3p2ZqeadiSWKA04Fs4xgSnvJjJxNTc/Rd0spgZDWWUDC7kBrNmSDy+jy4KpTeC12oV4W0+Pr7c9+tCGqHS9Nkmo0ZSi3wTNQqOKNB87MHwVHDeK2mZsnp5H091G/Snn9ido3QSeHOlzD0owj00Oe/9sJlc/K+Fb5Weof03c44W1x4B9WvXGd0KRk0XjOUocd7KQQZ++LoGsTl3LgU5GvAATziW/JXfokTy74DcE9DFtOHwQCX7+AgPYKIQ8fp49GJDhOzrRs2LhwANkrA/rHRaFZnex1yxHySsmv6HujJ9scXhp9bLS8xWQM7C6j68oI02aq9diT4DiKtNYcpfyN7oVVqfFpYv/X0zodEUnidgEoVxNfB2OUjR0TuyUmQcaDiluMYHzo3rlvGRaE35SNaZUXma1rUuj48oBUOt41XL6RynsSmuJL2kKZre8ED9X2/vCpaR9mVqd5hVHtEWBQ/lSCkNcQUWAuZP1ENWIf05F9g3ejnH5NAZteyKj0+qpryaJG0vUBK90aB0D6Py+M3FKiNCymQZmCaaGHJer2+9ppGjKmLbZmMczDbr3RzYKnN+CE7kfjjEP90Z98WkN+z4OTu
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB8614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(38070700021)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?I7RKQxufhXasTfhWzwBPuv42veyZRmjxUaFxDCTeRWBd2W9aOqtBhMCX9r?=
 =?iso-8859-1?Q?D+10EWVEtrE8i5KcBw8dDd+piIpzW1V5jK4R76cOjJbK7n1xtOL6OIi794?=
 =?iso-8859-1?Q?GzEZLfTXFuDeSKHS3hd5IQ0mjCWU3tq0VkuQtH/23DpY/FCRH8q8U9PxRk?=
 =?iso-8859-1?Q?Eyb8SUO6svVu/aD8s4oUeImzcVovHiP1bIm4CZDiLAO9ZhdFRPpfJ2TeiN?=
 =?iso-8859-1?Q?p3Cb6np/QthrHfq8GOu8an9LO/+E9cTSqLbG1/g75ULp8kOhprE70gJYjD?=
 =?iso-8859-1?Q?sClYsqr6BTc5kuZt+vq+wMDh26VI/+E2PEB8CNI13TmMUmBm2tcKZXo5+7?=
 =?iso-8859-1?Q?s/Q0fu8IE8UuK9nbX6XxxLilBKKTNcLp2FkzQMSQiGSNBN7GmwnhIYXcqe?=
 =?iso-8859-1?Q?s+wXo4D6pZKiVHnJK5DNECDP27lf/2lOvnKqHMZ8s29RVEuPficn+Sf2iM?=
 =?iso-8859-1?Q?waxMdfrzJylJC9txM5VRWUNJZS7VHz2y/wTSu2gQSK0Xy/UFA38hL9UvWH?=
 =?iso-8859-1?Q?LlGp+qDRXJHhzodlgoZ0jZ6m9XSs7AQx+bvUvPNYpXhF+JG9w9I6DWq2O2?=
 =?iso-8859-1?Q?7ws70jjNBKYr6HTYozLGmjWxSzIWChvsH+kPNd5Zp/pPUcs0gAFqBumlmV?=
 =?iso-8859-1?Q?ZpzTQTSXdRsUnb6+Hi3CveRzlc5tZuN9Q/bxFwYUi3p8GxUeq2CBjy+O/j?=
 =?iso-8859-1?Q?mmnfPX35I9sWZCEmj4RnrlQ/dMtsYp7M5hAyJlhgYifeRuG7BUEHL55xGX?=
 =?iso-8859-1?Q?gsPSfJGSKcQ6by1FeTP6JbY459Cqqot4qMhxjkLIbR1oeWIP2BmkSwKEHU?=
 =?iso-8859-1?Q?vRFEBQCIFJQ/0Vk+3IFwR3pTLuUGw6kifvQkaDE/RiEJTzKxhAtc5tFoYf?=
 =?iso-8859-1?Q?rhZzXRJa5qoXPycfgALfc1mlkfAinGZFURgKQy6APpCf5wkxaY74vtj2QY?=
 =?iso-8859-1?Q?KFVFI8IVVfn64/YsKUPu3aQFf1AMgcVE2A6qdog3zu7a+XjKNgsEiB7+5r?=
 =?iso-8859-1?Q?3T1FWN+iDx0xd+QX35RkOSscpMmFcQHSbtjfHlrX/unzQb0CniUwTNxlo/?=
 =?iso-8859-1?Q?YsuYAcnn1dSthTQBZpSnw+F5xbcNcbkZ9p9HsO6eY/waJRxo0pBT8/v/pj?=
 =?iso-8859-1?Q?xhP5NGqnrIFSmVEAbveOzL93ue0r8FXWH4HscI4N9VOthiQFnToE7lgDbF?=
 =?iso-8859-1?Q?L8BGbygQG6VHoTM+zC9YOaKpf3tLK/7Ce4nJW20Z/eUqAI+M5YcpghbNab?=
 =?iso-8859-1?Q?AtqgtxDTRbSMUPfUIVewWBjJCog4Mw4Rsuu7OFSflRJAAJQF48lQW6HsVv?=
 =?iso-8859-1?Q?2kYrDKoaynogYYbwYF1slULea6OxVcNh3dTU6aAHgWkZD26gT2KD38lV9B?=
 =?iso-8859-1?Q?TLO7D2JqvrYIMVqu1tOv3+1T4rTubLFVYxGlY2HNVABohEepttAXue9Zuk?=
 =?iso-8859-1?Q?bNC/NDRAob1/PvRX88mugbGwlSX4uPIUB4nHyl3q6Kb5ayUfUTiWNaTbuW?=
 =?iso-8859-1?Q?TaOiWJ29PjZKUUA9NVDghwY01imix+nGPLxbrBXrUolsVJKo+Q/EFIWTIv?=
 =?iso-8859-1?Q?aTagfUYwwIUcGg/d/F04ud22Rpfp2na+FP5+rWDR27StsSFo7G5uNIV8Q1?=
 =?iso-8859-1?Q?+ivbFAB1dr2ABcq6OlhY5alGiI0bTT1uKpVV1ysE3rh8xmJciW3MPj2NOU?=
 =?iso-8859-1?Q?cjLYnnAXrNgQtsjAqt+ToHYIB4k0UJ/1mRevFf/J9t6U7KJlcLFa7RdTX3?=
 =?iso-8859-1?Q?aE28V858XLWOJXrQrh9YIGBuXBAkqF54TauBPzb4hmpOBo65qLAms/IGWR?=
 =?iso-8859-1?Q?OlfKwIb48w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7579d705-5139-4884-e951-08decbb9cbd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2026 15:13:18.2119 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tfuytTSde3z4o7BvVhWvIHOrRrmxh5JKC8DHSOOHm4/curvNW737o5m2sAejE4I5lWy/fWXZ25YZOfK0uRgYrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8774
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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
> From: Nathan Chen <nathanc@nvidia.com>
> Sent: 15 June 2026 21:49
> To: qemu-devel@nongnu.org
> Cc: Yi Liu <yi.l.liu@intel.com>; Eric Auger <eric.auger@redhat.com>;
> Zhenzhong Duan <zhenzhong.duan@intel.com>; Philippe Mathieu-Daud=E9
> <philmd@mailo.com>; Zhao Liu <zhao1.liu@intel.com>; Alex Williamson
> <alex@shazbot.org>; C=E9dric Le Goater <clg@redhat.com>; Matt Ochs
> <mochs@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>; Shameer
> Kolothum Thodi <skolothumtho@nvidia.com>; Nathan Chen
> <nathanc@nvidia.com>
> Subject: [PATCH v2 3/3] vfio/pci: Warn when ats=3Don but host device lack=
s ATS
> cap
>=20
> From: Nathan Chen <nathanc@nvidia.com>
>=20
> Emit a warning when ats=3Don is requested but the physical device does no=
t
> advertise ATS, since ATS cannot be exposed to the guest in this case.
>=20
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
> ---
>  hw/vfio/pci.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c index 0f592ada89..49ba6813ee
> 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2592,6 +2592,7 @@ static void vfio_add_ext_cap(VFIOPCIDevice
> *vdev, bool ats_needed)  {
>      PCIDevice *pdev =3D PCI_DEVICE(vdev);
>      bool pasid_cap_added =3D false;
> +    bool ats_cap_present =3D false;
>      Error *err =3D NULL;
>      uint32_t header;
>      uint16_t cap_id, next, size;
> @@ -2680,6 +2681,7 @@ static void vfio_add_ext_cap(VFIOPCIDevice
> *vdev, bool ats_needed)
>              pcie_add_capability(pdev, cap_id, cap_ver, next, size);
>              break;
>          case PCI_EXT_CAP_ID_ATS:
> +            ats_cap_present =3D true;
>              /*
>               * If ATS is requested and supported according to the kernel=
, add
>               * the ATS capability. If not supported according to the ker=
nel or @@ -
> 2699,6 +2701,11 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev,
> bool ats_needed)
>          error_report_err(err);
>      }
>=20
> +    if (vdev->ats =3D=3D ON_OFF_AUTO_ON && !ats_cap_present) {

Nit: Can we do:
 If (ats_needed && !ats_cap_present) here?

> +        warn_report("vfio-pci: ats=3Don requested, but host device has n=
o "
> +                    "ATS extended capability");
> +    }
> +

Also, why this has to be a separate patch? Can't we fold into patch #2?

Besides(if you plan to keep this as separate one):
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>

Thanks,
Shameer



