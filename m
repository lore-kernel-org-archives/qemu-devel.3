Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A4F2F8D74E
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 14:09:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDNOF-0003S9-8V; Thu, 16 Apr 2026 10:08:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wDNOE-0003Rr-3a; Thu, 16 Apr 2026 10:08:18 -0400
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wDNOC-0005Hr-CH; Thu, 16 Apr 2026 10:08:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s/FSKDcWoaZm3cPbx5Tt3HuAvKQCPUHphajqhhnyE7BavxeBCYV3xIQY1if3KGI7NrvGowAdRuOeogPc+FTgFXQoCsjNir5vqS/VHN6gIVF1LLxBWaihbr7yhUOBJ9fHxfS++VoBkF34zs9eGy8ewlcwoQGeMNRXz+qAUxMpuLpl97jJtCKJBkqhl939ie6e2POvA5sNF6c7ODe1YG4Y1jZYqXYqYKxOFpRSlkSCQsNHPXd98Tq3NAp1SwVKZLvktT5r+Adz3CTErmqZ5f+794EelrGA0lmtQpASa0eRrjCa7h7QP3hgybXOF5GVa8r0brPv02PRFzR45tJQt9Rr2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SX81ZcVfeGaH7+uYeT1YprTgWsi5bfeQCqClPHCltqc=;
 b=kWWhGA7QhqFXB4QJhNATo3OkXLDW42GYNp7LSMakI0ndrjRkwKDQQPbBBDxuBXKKBNT0y6dNNU/k5Nzf2otB5AyqgXNVrbZB4qYNiSy7FctExWwZIqVXnDrCI5eiQyOEfgwA5czq09V+MeUMlLp4OnfhJpeW2nuZvAr0rCBf99+oVckiLjSjU9KcUnmxmyANfBXLj/1DaN/TFtwz/31ic2ogG469ZysgL8rqX2RjHARecgkTuibUp/AnmScXMlWPatzNszAEEOk7WBf0bl2LHnCIFD3TRmUk2jBxm9l99TfLRutB2B7IU6/oOVs7zSWF3Qe/hyGn1CQqIUSaZFr4Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SX81ZcVfeGaH7+uYeT1YprTgWsi5bfeQCqClPHCltqc=;
 b=Qiiikr1uPLxojTwzpFtrwR5gu19GZCFHyqkpzkzAoGkzHpXH/x3QoY2B5IFBl5HyoNzYeYZwXQNxz/K7Bx3SOJ/9kvmYttUHijZLSj1VOxFZmuQf/2TG8szqrCcYQdryAVHUsr9TqdEhn+TnMxBVyhopxiJTf/Ng+FEH8yoJjobR09vCMHDZrAoOKaGl1SSJa+tHrVBsVq1tcjt7dExK+ELshljTHTgQwewN4Nkq1V9hIkPNJFsg+z833deToTF5J8+06OrZPZ1mWeu5VJq0i//Xbo/gviwfKY59sOCBZJY+ivFIueQ16SkhLWUuY/ehIMaovFwg1WJKLcZIJWoviA==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by SA1PR12MB7125.namprd12.prod.outlook.com (2603:10b6:806:29f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Thu, 16 Apr
 2026 14:08:04 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 14:08:04 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Nathan Chen <nathanc@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>, Zhenzhong
 Duan <zhenzhong.duan@intel.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, Yanan Wang
 <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, Alex Williamson
 <alex@shazbot.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>,
 Matt Ochs <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH 09/11] hw/arm/smmuv3-accel: Implement "auto" value for
 "oas"
Thread-Topic: [PATCH 09/11] hw/arm/smmuv3-accel: Implement "auto" value for
 "oas"
Thread-Index: AQHcwXNEiYayflWfEUezRut3L1IVirXhzwYQ
Date: Thu, 16 Apr 2026 14:08:04 +0000
Message-ID: <CH3PR12MB754858C236A5322833654F34AB232@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260401010231.4166776-1-nathanc@nvidia.com>
 <20260401010231.4166776-10-nathanc@nvidia.com>
In-Reply-To: <20260401010231.4166776-10-nathanc@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|SA1PR12MB7125:EE_
x-ms-office365-filtering-correlation-id: 8ed5aad0-0846-4cc8-0c32-08de9bc193b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: xCnevaCxshA1GMwmo5SdfU8hk/IZVooozE/spAsfTnKVMb6Lm8k/y2+Z1/vcZVBLNm0tENgyl7TFf2ImR+JSlcDA5rOCRS8IeH6DNY2cnPyRLYLZuw5b7S8b9MJ/CkRea31+0aqYUigTS/2v9KPHpAbGE/vwJ9HN85uKTubHz9D2npv8LfilQWcRaiztMiDPUJZSI/xV0ND56/SWUIlfqbV8PcSia4YOxqqqNb8Wtc7u4GViYvzhkjSshJFTLni2rMHlm4GLR49VFNt0TalSo0OFE2kYOxCNQRhRpldCoTE0iola/0QzTxC7mAOvZBoyvctFZeTHDAW9KSeluqmzyyNN0RW1/EEospiZxiG5/nj3kL+xxWvMxpn8a2HVf+LmCpzf3rPC4DbehxjQE3gStTmTCOXDyd8InW67uh56RwbOZMMmfdvsr+G7eC4fuF/jcwO90tOmN5v5Icz3rl+Ao8IDIDaa+g7xaUj58FetCQ6QfzAMwP+8ki2kZPRgEMvEZfCNJzPBjFHB2hHC7fpC/xqaBxi9hUmSR4f23DJzDlqmHhLoYJOAQkeASYBhb7dVDlh+Y7ZGxDVJIbPyJPfhDXMSHjQK1NP6nshAm6mKOm7jwb2GMGXqgNTxrJP+hCYfCKv71hw3kpHxAkR454PqYQgxSFnaxMTSnfsc4tQrFQsL+RpG24FVRlvTPAqrd/H0vy+wcT6mB1cxB7BYCXjxL9hg/C5OP5QJ+EYvK0cbBb3UGO6m1sOfs5Nxl1/SIiQCV5U/2v9zYcYjAA9b/zNXXRtA0Pw0a03Xd2VAg0y4zzs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/it8g5MvYBtCdEF+yFU0RXUP2yCapVN+V0wFvWtmdyEmfRSw9PfCd3Tjrp?=
 =?iso-8859-1?Q?gVjw0wtSebMrtk0yQsbJcQvhc+oiysAqkKCFpojz+ZYjOAif0tKLQnh8ms?=
 =?iso-8859-1?Q?e/reSP23Rmz3i3nToIpEpdfgRwgglWd0NEXFQZr9elMqDgoqBWLt/gpyp6?=
 =?iso-8859-1?Q?u0ZCEnqGoyz2XtwCuM+nEKDSJMZF1MG+suo149za/74fMoLMss1GZJB1Gl?=
 =?iso-8859-1?Q?RIdvLraZRvlam+MdPO7W73wffeGGIYEn6Oa9JH7E+jDULbyHwZyMni3UvY?=
 =?iso-8859-1?Q?3sdvBJ86H8+EqPUqu7gXWsWMsbAC7jzYueeONOF5LrpcgAg8rOCFPeGtOC?=
 =?iso-8859-1?Q?N4RetCBTPuPuw9nWzoY7mmCcKLKMmIiVcCPwPSagrrZGSj/PDnlVUF9W5z?=
 =?iso-8859-1?Q?P8iddnnB7u9lEhw3dHAYUdhWQ4lpyL0aiGjwNXjrmbAkSHA7GyblG93VwV?=
 =?iso-8859-1?Q?sWpoIPIjNtCaFnWG2r0Kk58gkbYcMIY0uH9JqFTIfogWO0UWE0fZC1gYAX?=
 =?iso-8859-1?Q?hGf1+wBobbiGcNDxO+ZlgTUMCn7tYQyP2RTOI4MsCUyjNYJc3rdDc45IjM?=
 =?iso-8859-1?Q?HaXEry+C9l/ZCWsQdFnq7/vXUfiPYCTmvCMUcEhreYRb4Ih6+rfDawnub+?=
 =?iso-8859-1?Q?kPa2d/bquM6yCqDv+Ful1KDohDiNV18I610DT5G79AYrQqVwtrC8vQD/Jq?=
 =?iso-8859-1?Q?xzpk9x9naII3DG+Pa9Jm89FBRE58f9jXPBGMnSJ7B7dxdS14zv3XLL6ODD?=
 =?iso-8859-1?Q?rJJ17W+71HhTwgZupGJZRK9ZiHQtbYyE2Zq39ye61cDbPrjyqaNJ+Cw0EW?=
 =?iso-8859-1?Q?EwryF8hdoBWPTOSABIcH7YuSC/3fGHucoYEMyPTLNZkrCx6Mhzgku1c5pp?=
 =?iso-8859-1?Q?/OuV+eypvpgZmxgvukq6j/gxUSOYMeO8msEiiOvAAECPIeVlc7vQRDdnSZ?=
 =?iso-8859-1?Q?fmXID6L6Jdl4pRyvvt4ivSsXdm+ejyJ2KlcfEX/SjQoqfAfRggk2OtmIFE?=
 =?iso-8859-1?Q?0yPO7aMehdQr2KuqBxD8wbN2dvq1S4q3mXAbJZgyVv4wfCG3fQxhd8N2Ad?=
 =?iso-8859-1?Q?Y/iyLi3+sIKEaw1mCtv8tOnaR2xKiWjmqSNBTE4Cb1KcOBu2bMzrYBMYu4?=
 =?iso-8859-1?Q?4VxSbanqReog6BLxdMhZ8Iz4UkgGqDzN6aUVIsbsMOcw8XwN0feCY0d5Ud?=
 =?iso-8859-1?Q?9/P/uIqRalSWfHwgFT0j6S0lFtOIwe2Ob2E6IorFWXyjRlYLzAKU2P1cFY?=
 =?iso-8859-1?Q?B+lV5PleAey1L7bR9s/dnhCiiJkDVvTUdoDRwLH/YuKfeSI9EGjtuc9JOZ?=
 =?iso-8859-1?Q?tNecrDSQIE0aX58ktJmlCCVGKzG6D0VUd6zzd6PS3ijhLXPLfBq8/F6V2T?=
 =?iso-8859-1?Q?GoR69iPmcMgPHZ7se3AbEMmRwgWSHvK7OoFwtEwfHbmC0xvAReDEzPjddO?=
 =?iso-8859-1?Q?JUEHUpbs4ktNv7VFmjD2RJ6jE1jbM3js1di1kTIiM1mWkw+zG7TX3N/wmO?=
 =?iso-8859-1?Q?0vrRqBnmuwlQcWpuXUiDgR+OjMpUed740OYdFfaBjllVuUuNGcwn9QQhu8?=
 =?iso-8859-1?Q?1yR8VT751Op8250en1D5T14hvNhuRGsbqiFIL9stJcg/FGslPkt+TAAzdt?=
 =?iso-8859-1?Q?3KPSsJ3incADnCjxXj1ey35luei/n11bL+0DpgJpBWJCkX05WYjNK8cOEs?=
 =?iso-8859-1?Q?dV2XjfoofJfbTy2wiFgUCDAlqC/HF7BgjyhP8JcJGLv1Xs2ow7B3oYqK0v?=
 =?iso-8859-1?Q?GDqFzvgoWnXxX2gSet6kIV1UVgmgxRq1punL97a6yJxTHNqPybqqaDfc88?=
 =?iso-8859-1?Q?7kMKBscMkQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ed5aad0-0846-4cc8-0c32-08de9bc193b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 14:08:04.1178 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OoPkN2ZGu5if3gN3RSSZL0RJfNn5LaI7Xd0ZabxPdah3Emu2Y7EuAtxSmK6JjHhmG6/qRZLzt23xvNlnAqqeVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7125
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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
> Sent: 01 April 2026 02:02
> To: qemu-arm@nongnu.org; qemu-devel@nongnu.org
> Cc: Yi Liu <yi.l.liu@intel.com>; Eric Auger <eric.auger@redhat.com>;
> Zhenzhong Duan <zhenzhong.duan@intel.com>; Peter Maydell
> <peter.maydell@linaro.org>; Marcel Apfelbaum
> <marcel.apfelbaum@gmail.com>; Philippe Mathieu-Daud=E9
> <philmd@linaro.org>; Yanan Wang <wangyanan55@huawei.com>; Zhao Liu
> <zhao1.liu@intel.com>; Alex Williamson <alex@shazbot.org>; C=E9dric Le Go=
ater
> <clg@redhat.com>; Shameer Kolothum Thodi <skolothumtho@nvidia.com>;
> Matt Ochs <mochs@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>;
> Nathan Chen <nathanc@nvidia.com>
> Subject: [PATCH 09/11] hw/arm/smmuv3-accel: Implement "auto" value for
> "oas"
>=20
> From: Nathan Chen <nathanc@nvidia.com>
>=20
> Allow accelerated SMMUv3 OAS property to be derived from host IOMMU
> capabilities. Derive host values using IOMMU_GET_HW_INFO, retrieving
> OAS from IDR5.
>=20
> This keeps the OAS value advertised by the virtual SMMU compatible with
> the capabilities of the host SMMUv3, so that the intermediate physical
> addresses (IPA) consumed by host SMMU for stage-2 translation do not
> exceed the host's max supported IPA size.
>=20
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.c | 9 ++++++++-
>  hw/arm/smmuv3.c       | 6 +++---
>  2 files changed, 11 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 03393fd7ba..105f6d26bf 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -63,6 +63,12 @@ static void
> smmuv3_accel_auto_finalise(SMMUv3State *s,
>                                 FIELD_EX32(info->idr[1], IDR1, SSIDSIZE))=
;
>      }
>=20
> +    /* Update OAS if auto from info */
> +    if (s->oas =3D=3D OAS_MODE_AUTO) {
> +        s->idr[5] =3D FIELD_DP32(s->idr[5], IDR5, OAS,
> +                               FIELD_EX32(info->idr[5], IDR5, OAS));
> +    }
> +
>      accel->auto_finalised =3D true;
>  }
>=20
> @@ -962,7 +968,8 @@ void smmuv3_accel_init(SMMUv3State *s)
>=20
>      if (s->ats =3D=3D ON_OFF_AUTO_AUTO ||
>          s->ril =3D=3D ON_OFF_AUTO_AUTO ||
> -        s->ssidsize =3D=3D SSID_SIZE_MODE_AUTO) {
> +        s->ssidsize =3D=3D SSID_SIZE_MODE_AUTO ||
> +        s->oas =3D=3D OAS_MODE_AUTO) {
>          s->s_accel->auto_mode =3D true;
>      }
>  }
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index cb14a08a66..0ab6d1e762 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1976,7 +1976,8 @@ static bool
> smmu_validate_property(SMMUv3State *s, Error **errp)
>      }
>  #endif
>=20
> -    if (s->oas !=3D OAS_MODE_44 && s->oas !=3D OAS_MODE_48) {
> +    if (s->oas !=3D OAS_MODE_44 && s->oas !=3D OAS_MODE_48 &&
> +        s->oas !=3D OAS_MODE_AUTO) {
>          error_setg(errp, "QEMU SMMUv3 model only implements 44 and 48 bi=
t"
>                     "OAS; other OasMode values are not supported");
>          return false;

Do we end up now allowing OAS_MODE_AUTO for non-accel mode?

I think we may need to adjust as below:

    if (!s->accel) {
         if (s->ril =3D=3D ON_OFF_AUTO_OFF) {
              error_setg();
              return false;
          }
          if (s->ats !=3D ON_OFF_AUTO_OFF) {
              error_setg();
              return false;
          }
          if (s->oas !=3D OAS_MODE_44) {
              error_setg();
              return false;
          }
          if (s->ssidsize !=3D SSID_SIZE_MODE_0) {
              error_setg();
              return false;
          }
          return true;
      }

Please check.

Thanks,
Shameer

