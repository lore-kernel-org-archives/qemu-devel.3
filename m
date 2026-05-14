Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF75CCD4F25
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 14:25:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNWzN-0006RL-2s; Thu, 14 May 2026 10:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wNWzH-0006Qo-Pz; Thu, 14 May 2026 10:24:32 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wNWzD-0005Xi-Hl; Thu, 14 May 2026 10:24:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n6PaliVFUiAdJO3qXc8RqStfbf3VCS5QaOPXSUkUZJ+w0pHIBcMKm9a5uMRHfYRagnmi3ggqoCmUC8PQfnj2+ppSING2NYc+nEX6xtp7YAjdWN1+ute53NwaGi8H+Z/fgXPC2m6eEP5C7TT4VHuHjl23m5tihw3cE/3BwSrnHsSkpfecWL6i37PUZt1EGrklhYrgm9zE5HNNWUDpKhB0paV5M+xVZoN23SfDB8AJvcUOTDaPP/YEH8NHQLoy5G38VXRy+v6oYMyGwFRG5cfszSH6oQ78VDZ6C2rCn/fhQFo86dRSRNsKvJ+2OgaC82aFOAZqXy1Ju9U7rtRV1OBfgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sKA6eW9tuAT33px3mqITlPG1UFyfm9WGd5ZEbb+BAas=;
 b=EUgXy16bfKFQ+5tYB08UUXgWYOqxJ1uv+FPt/IEb07EMygAKeWW/JNbR3SAxT5MiXKYzcWrs+38I7R/0DlrQ9SWMJ/jIva8dvJ60u/NQ5XEp3xc7w+scuBwbWHgUlH6YJwOkGECHOSaDpNUbM8ov5BgTFGI/hHhYE0CiZStpJzn91pPGJAx194NpNnA6ZMmsp4/gGcze2pJWudC7Y05yj2t8J1CVbRvNMB0NFJm0arTOGcDXYMFMY4czKneLD2TmUOXxPGaDm4EDw89h5xXOpR4W9ofSkU6jWqTiy/GA7f32KgZk4iMtxY7uxwiwAHwuFi3OJn/j5dDXCTwxfrxJww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKA6eW9tuAT33px3mqITlPG1UFyfm9WGd5ZEbb+BAas=;
 b=c9YSras+yrehALAG8s+2qVy1Il8miOh+cvQZ44dkk7tRLF76v3I1LWUiJT8MffXWC/mONS9yTDSDlLU+E4X+UmqCJ4B0RTkN8KXmaxMYMVAQkQzqkNzJCWQ7hTI4nemAT99RAIxYB9hDCiX+1T0vqWsnq9M1i3KpO+a3tX0ZasHHqvoTts0Q4xP6ltwG+DURVUQdcCQUdzxAqxAXoz9ePivtBNCMPsUisXHvnWWAR4rYcOumNFC3O2lFMa9FS5W5+nG5ckWBHZFqUd9ZBH0dH3uaq6qFNs4V8FkQjV170OWMjFpZX9OyUz13lQVX9zBNkOuRSNj3GTDqF2yNq62OaQ==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CH3PR12MB8756.namprd12.prod.outlook.com (2603:10b6:610:17f::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Thu, 14 May
 2026 14:24:18 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 14:24:18 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Nathan Chen <nathanc@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Eric Auger <eric.auger@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>, Zhao Liu <zhao1.liu@intel.com>, Matt Ochs
 <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v3 4/7] hw/arm/smmuv3-accel: Implement "auto" value for
 "ssidsize"
Thread-Topic: [PATCH v3 4/7] hw/arm/smmuv3-accel: Implement "auto" value for
 "ssidsize"
Thread-Index: AQHc4kaKQw5twfxRDEWJCCb9Ajz/VbYNlDQA
Date: Thu, 14 May 2026 14:24:18 +0000
Message-ID: <CH3PR12MB7548125AB6137EF2D9954810AB072@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260512193520.3109172-1-nathanc@nvidia.com>
 <20260512193520.3109172-5-nathanc@nvidia.com>
In-Reply-To: <20260512193520.3109172-5-nathanc@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|CH3PR12MB8756:EE_
x-ms-office365-filtering-correlation-id: 05d43211-c564-4d49-296a-08deb1c47be0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|11063799003|4143699003|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: KAbPF7MYH/5C7mQgrr8hNNO55Bwu4udoi/T7rHYkrY9Dt/mtFciRifciz8+PiGeieyZj39Wik/MjqCuDWf4gL9UwD/XS2zMOxuGlNpr7++Ei5rYV237fhS8epW97GvqgNHiF/28qj1YffuQGcP0w7AUq0s6rwJwabLj0Nadq78FZRPoaHEWQ81UaVbhAmFe3ewT+ohILms4rKCi0ZkySdJz+Kuuq6Um2GbgqA4xAo/WeDlWe+Ot306YYoa8wR5hHGjRD6kmXgSkHWrW03R81ALBpBZf6ii3bTyG7Q+gLZk6YfsWCuMiyExUUaOqXNbfJTKssPr4hKlTILFFGVnBR4nubXHAotIqBxllIFszKCNuYFz8utaoR4QcYL6upLEMyseINTdI+utb4hJjArXffc0q965omyqp+zmcxepec4m/RLbJdaztAVVXJ3+pMgEs2QiGlg1m+IuTw5GPvDb8KH6nViF+wbwkDYjhFjD/WKgaLWM9Fs05gubK0Dv5y2Eq0+etlkmZfSCvTvBlARGSYWmwHGt17HLfhRgGeqsYhXh/WJdYQ7OJUk6mxlsDlYZLhx/QX6Tpbg4rX6Ov4j9dRNe1O89v8Hw/GVBgwkaMv0gMf4B7Oh1N/Rgy5GvquDKfPw87gSKmTK1JSaKrCgVL1qRNaAbRYG9OJwKVgsWzmlXbNfYMDBE4tiYafhaMGa3GpwUwpVsDIxLQVz/Y8UufSjeKeJO+l+PbUQeaBOrCZePizae3ePAf1nowA/fYOckrU
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(11063799003)(4143699003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?AZIl+LOYhiiIR1CblQqbwj5u8ZPuThchd3OM4R000t8fvzz461e4maxiTT?=
 =?iso-8859-1?Q?iL6GZCDUw/ioEh6ePLmuTUVJ7yNp2MNuacKNxioQ0A3+eOtr2ax+OYoess?=
 =?iso-8859-1?Q?eAJtnQpk1T2WvOMQ7ndQRLhO00Rprpn1tCznDi0WGVN1jSj2/CmNdZBeu/?=
 =?iso-8859-1?Q?hSd0V4wP8U28A4uJxM6Mz2AMk5ay5vyTrd9HAeRN69cf+mJFFYIFydgWNa?=
 =?iso-8859-1?Q?7zGmo2osByVQATwmKqWyrzVugCKe1xJgXHIBm0/9KKDSrqXD/W6ArDK3d6?=
 =?iso-8859-1?Q?GLHehBkFhvkoxtwGeFMqM1fmupFMMIvcUojT6Ftse9gxxo8vSlHRkmYXbW?=
 =?iso-8859-1?Q?GWt6H8H+QSHneBTafknHoHS9cTjNBa69jom/dR7oUEjBd6BqxDZdjRG5Wp?=
 =?iso-8859-1?Q?QfLzk9VIUF638Ogy1dcvb1A3XC3dQjHJNZ+JPHXAEi2NPsrcWlD7QjobE/?=
 =?iso-8859-1?Q?tcO3jG2RwKUvQbgN5ii1F/1iN0vxt/px3wuStHf38l3e48Je15gn16eTqE?=
 =?iso-8859-1?Q?GXC+lU9WobA3iHf8r6c6tV37vfYI9SJ5vXujV84cKXywiwuHYLopkXA2g4?=
 =?iso-8859-1?Q?xeDxQ4ain2OOStxOxRV48n3SwzCIishXXcrhSrsHMDKAg9um0kVRA3yBd0?=
 =?iso-8859-1?Q?Ga6EEt2CrstE3QIESaTu/22mJy2i+yj5U78fmpoQmDXIsozfyjRyYQkbnv?=
 =?iso-8859-1?Q?OnWiHXnNSuR4WPAeCWdRBjHhmgLj6AhjJgFZT0r9aNixesZS8/KjubJi6N?=
 =?iso-8859-1?Q?mUN3oGiQiLREHNtwbzPko8J/mwo/h/5/ZPWWgK6uY0UfD2qpMBbTSL42YJ?=
 =?iso-8859-1?Q?/3ouZzbDO/ENbhQHg+ua+1bb3k1AbvYohzgVLGKSnff0VndLosWAUQslHU?=
 =?iso-8859-1?Q?Ni68nRbXyF3VNcCeaxlBhaT57PHFWMXZu1U8L+KyO32PEULJ9Hs5hVzpq2?=
 =?iso-8859-1?Q?HKgvyfsMWHuXOiiq8A+tyl2yF9rs7+DC9eFycJgSCeRSdVI2SdsyNI+R9e?=
 =?iso-8859-1?Q?G8gRY2vGmYs3w4E6/XXd1QBJsppC+H8nCeEM2rW2/aBeB3Jk7wsEGIgGlH?=
 =?iso-8859-1?Q?ooHY3RRR3gYNuIipYW1Ra1sitWAsQZ6lE13pqt6Euqho2sH3VEsDV4BKw7?=
 =?iso-8859-1?Q?q957V+o55x3qflOc5tAy8DKCRuaBqZLBL+w78mI+603R43DSZe5uBdxmJ1?=
 =?iso-8859-1?Q?lR7JK9NG5UaB9itBlbxkGoWkdG0/+KENkNJWVivffHTW5RYBb3QpdILIhZ?=
 =?iso-8859-1?Q?J1E8r5CHyPMINREdYxgewtrfJevt/bccljgUaIfcgPjuaLengIikD1liZD?=
 =?iso-8859-1?Q?XiUi16TMFrI3jBDLCE+FlwUGeTXKTGbR3TU0KeWwaoVPIr817ZgmrftcWI?=
 =?iso-8859-1?Q?zdZRvuN2chkjoZAOM/+GfsWT7HAYW6weBFno6uMhKehd0EGRM9sw1LhjbM?=
 =?iso-8859-1?Q?RbrIbt4bFXoKmgnTa5Xh6ndZ+8h6lwChqPRY0rLkW0FxNFoeKfbwjcRbq5?=
 =?iso-8859-1?Q?GHjpvsqcyO4PMORGdOqvQyNcr3cEaMe58FHTiA9H0chlv4GMzG2bd8yvNr?=
 =?iso-8859-1?Q?GFer2GfCqRMhHtRlezaKrJCSHC/7eV51Nwy9lrpE0Wrwnoxq9cAm2xdKui?=
 =?iso-8859-1?Q?mLBy7xAX+Lsu36s/DcwwaclRZ5uAdJK4NdYWHz3N1mA7JXOiwyNQSnt5fw?=
 =?iso-8859-1?Q?JL2N6HcltlQjqHVAfx9mke9A16HtZXT11ZZB5GkjuU8o7BZc8I6BYxH9Ux?=
 =?iso-8859-1?Q?kwJ5sUxiuxDzIi5bQVpEooMzr+baHhACL93osLpCKk9paeLZWLF1xwDQ/j?=
 =?iso-8859-1?Q?plsEba7PgA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05d43211-c564-4d49-296a-08deb1c47be0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2026 14:24:18.3145 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kbk9V1guu7tXfO83uwD1GPxlRoEL6ltnkWZPaz7SPw917gQ8wwm2jP65rGoXuqzUU/u/ZHMZTNhC1YUY9Dr6KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8756
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
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
> Sent: 12 May 2026 20:35
> To: qemu-arm@nongnu.org; qemu-devel@nongnu.org
> Cc: Eric Auger <eric.auger@redhat.com>; Peter Maydell
> <peter.maydell@linaro.org>; Philippe Mathieu-Daud=E9 <philmd@linaro.org>;
> Zhao Liu <zhao1.liu@intel.com>; Matt Ochs <mochs@nvidia.com>; Nicolin
> Chen <nicolinc@nvidia.com>; Shameer Kolothum Thodi
> <skolothumtho@nvidia.com>; Nathan Chen <nathanc@nvidia.com>
> Subject: [PATCH v3 4/7] hw/arm/smmuv3-accel: Implement "auto" value for
> "ssidsize"
>=20
> From: Nathan Chen <nathanc@nvidia.com>
>=20
> Allow accelerated SMMUv3 SSID size property to be derived from host
> IOMMU capabilities. Derive host values using IOMMU_GET_HW_INFO,
> retrieving SSID size from IDR1. When the auto SSID size is resolved
> to a non-zero value, PASID capability is advertised to the vIOMMU
> and accelerated use cases such as Shared Virtual Addressing (SVA)
> are supported.
>=20
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.c | 18 ++++++++++++++++--
>  hw/arm/smmuv3.c       | 20 ++++++++++----------
>  2 files changed, 26 insertions(+), 12 deletions(-)
>=20
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index a5973bd499..5b1af062ee 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -62,6 +62,12 @@ static void
> smmuv3_accel_auto_finalise(SMMUv3State *s,
>                                 FIELD_EX32(info->idr[3], IDR3, RIL));
>      }
>=20
> +    if (s->ssidsize =3D=3D SSID_SIZE_MODE_AUTO) {
> +        /* Store for get_viommu_flags() to determine PASID support */
> +        s->idr[1] =3D FIELD_DP32(s->idr[1], IDR1, SSIDSIZE,
> +                               FIELD_EX32(info->idr[1], IDR1, SSIDSIZE))=
;

Nit: Not sure that comment makes sense. We need to update it
anyway, right?

> +    }
> +
>      accel->auto_finalised =3D true;
>  }
>=20
> @@ -822,6 +828,13 @@ static AddressSpace
> *smmuv3_accel_find_add_as(PCIBus *bus, void *opaque,
>      }
>  }
>=20
> +static inline bool smmuv3_pasid_supported(SMMUv3State *s)
> +{
> +    return s->ssidsize > SSID_SIZE_MODE_0 ||
> +           (s->ssidsize =3D=3D SSID_SIZE_MODE_AUTO &&
> +            FIELD_EX32(s->idr[1], IDR1, SSIDSIZE));
> +}
> +
>  static uint64_t smmuv3_accel_get_viommu_flags(void *opaque)
>  {
>      /*
> @@ -834,7 +847,7 @@ static uint64_t
> smmuv3_accel_get_viommu_flags(void *opaque)
>      SMMUState *bs =3D opaque;
>      SMMUv3State *s =3D ARM_SMMUV3(bs);
>=20
> -    if (s->ssidsize > SSID_SIZE_MODE_0) {
> +    if (smmuv3_pasid_supported(s)) {
>          flags |=3D VIOMMU_FLAG_PASID_SUPPORTED;
>      }
>      return flags;
> @@ -975,7 +988,8 @@ bool smmuv3_accel_init(SMMUv3State *s, Error
> **errp)
>      smmuv3_accel_as_init(s);
>=20
>      if (s->ats =3D=3D ON_OFF_AUTO_AUTO ||
> -        s->ril =3D=3D ON_OFF_AUTO_AUTO) {
> +        s->ril =3D=3D ON_OFF_AUTO_AUTO ||
> +        s->ssidsize =3D=3D SSID_SIZE_MODE_AUTO) {
>          s->s_accel->auto_mode =3D true;
>      }
>=20
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 7ec4241ecf..cd30275717 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -626,7 +626,10 @@ static int decode_ste(SMMUv3State *s,
> SMMUTransCfg *cfg,
>      }
>=20
>      /* Multiple context descriptors require SubstreamID support */
> -    if (s->ssidsize =3D=3D SSID_SIZE_MODE_0 && STE_S1CDMAX(ste) !=3D 0) =
{
> +    if ((s->ssidsize =3D=3D SSID_SIZE_MODE_0 ||
> +         (s->ssidsize =3D=3D SSID_SIZE_MODE_AUTO &&
> +          !FIELD_EX32(s->idr[1], IDR1, SSIDSIZE))) &&
> +        STE_S1CDMAX(ste) !=3D 0) {
>          qemu_log_mask(LOG_UNIMP,
>                  "SMMUv3: multiple S1 context descriptors require Substre=
amID
> support. "
>                  "Configure ssidsize > 0 (requires accel=3Don)\n");
> @@ -1965,10 +1968,6 @@ static void smmu_reset_exit(Object *obj,
> ResetType type)
>=20
>  static bool smmu_validate_property(SMMUv3State *s, Error **errp)
>  {
> -    if (s->ssidsize =3D=3D SSID_SIZE_MODE_AUTO) {
> -        error_setg(errp, "ssidsize auto mode is not supported");
> -        return false;
> -    }
>      if (s->oas !=3D OAS_MODE_44 && s->oas !=3D OAS_MODE_48) {
>          error_setg(errp, "QEMU SMMUv3 model only implements 44 and 48 bi=
t"
>                     "OAS; other OasMode values are not supported");
> @@ -1989,7 +1988,8 @@ static bool
> smmu_validate_property(SMMUv3State *s, Error **errp)
>              return false;
>          }
>          if (s->ssidsize > SSID_SIZE_MODE_0) {
> -            error_setg(errp, "ssidsize can only be set if accel=3Don");
> +            error_setg(errp, "ssidsize can only be greater than 0 "
> +                       "bits if accel=3Don");
>              return false;
>          }
>          return true;
> @@ -2173,11 +2173,11 @@ static void smmuv3_class_init(ObjectClass
> *klass, const void *data)
>          "are 44 or 48 bits. Defaults to 44 bits. oas=3Dauto is not "
>          "supported.");
>      object_class_property_set_description(klass, "ssidsize",
> -        "Number of bits used to represent SubstreamIDs (SSIDs). "
> +        "Set number of bits used to represent SubstreamIDs (SSIDs). "
> +        "Valid values are 0-20 and auto. Defaults to 0. "
>          "A value of N allows SSIDs in the range [0 .. 2^N - 1]. "
> -        "Valid range is 0-20, where 0 disables SubstreamID support. "
> -        "Defaults to 0. A value greater than 0 is required to enable "
> -        "PASID support. ssidsize=3Dauto is not supported.");
> +        "A value of 0 disables SubstreamID support. A value greater "
> +        "than 0 is required to enable PASID support.");
>  }
>=20
>  static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,

Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>

Thanks,
Shameer


