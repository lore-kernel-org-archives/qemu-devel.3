Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93008CD4851
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 13:42:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNWK5-0006RQ-BQ; Thu, 14 May 2026 09:41:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wNWK2-0006Qs-En; Thu, 14 May 2026 09:41:54 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wNWJz-0004rY-49; Thu, 14 May 2026 09:41:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gppR1fnROEPZ2IRjQ1uEFc+0DkE9VK3SYS3ZdNsEolytEfFL9Shme9yv58Ua0JnYKAXiiqG3KFNl9j9HxaeCjlg6jt8c0swSZnFo4/sX4WYNBYMFY8ijhdFVeky055fzVaJz9MqleEUm1huh+RYOBanebzEeLiTbRobJi8owxZV9n6AztZ5ZMVA5m6f2cSvTcEjVeuKKT3muvDKq4jeHkODCISM7M/50EycsNVQJlM4QIMfYtFkASUqPhjK0DMFIc8WYEFqDAUTxhblUWe3TCPT1I8lRhdJ6L+fOGb4urJf3wSXPjPi9+VH6miSAKbnTqOeK27g+NPtajR+ySg2icA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+vSlY8zv2BJ4884xyghF1rJxMGSITis39ACOoTUevM=;
 b=KZMCN6x8wUwhCQHhbW9VDdK6a4CL3gj5osYen5YKWPLdSx5bD7Py1R2xKuSt4zQMCFg0juqYa1g3/hMoU/OC+kpKOkyf4XAPeWVm7uk3UJvQ9JiLVhzN5td3Shz438MXXu7u1/gK/Ej/mtkbxJVZJ1B4VmPWlI26yRxmYllKlJv9K663CejkMqYd7nHVdCaR2I2ysoW2UOjLcLKFz8uf0cEdWQyImMa2cZlj0SO6CXcTOdMkVHkYm1hZm2FuGEePcFKxelJaKSxaoAHyOKH7/PYdBj2KDZQvz3B7wOWWM11Yx7cRS8XvLHs5FJQ24+IJ3Cou8IOZwc2a+qgXPhRuDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+vSlY8zv2BJ4884xyghF1rJxMGSITis39ACOoTUevM=;
 b=AgUtk/VWYD3WAS7hgYK132V1Goe5wk/IoOvS5m1uBJjf7RYMeNkv8+pu7MwWUr16e2lxtdWFVOBnWbZF1UE8qEumtOKDhRjZerfrswg+smML45lGOTs0jUprPuHdtBL0nc15D76jnGV5cnYLCrAn1U8oabmy37JHGMPSf/GihjYEm8C456VRj9Lat9X98JGV2Tfk5zv9uND+OZjuAj/nor9+xQeIud3F7R/FUUrr9l7c1aLJQae4B4G0aH8lYbeTzxNN8KKtFxqccJONVxAcaXmyY57cnx89cg96HZd9k6uXsX3XXzyaatzN5z+Ku4gz1GLgd0ASE35sWG+9RaGqlQ==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by IA1PR12MB9467.namprd12.prod.outlook.com (2603:10b6:208:594::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Thu, 14 May
 2026 13:41:34 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 13:41:34 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Nathan Chen <nathanc@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Eric Auger <eric.auger@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>, Zhao Liu <zhao1.liu@intel.com>, Matt Ochs
 <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v3 1/7] hw/arm/smmuv3-accel: Add helper for resolving auto
 parameters
Thread-Topic: [PATCH v3 1/7] hw/arm/smmuv3-accel: Add helper for resolving
 auto parameters
Thread-Index: AQHc4kaHwnFAiP7CH0+3OrSE3oSCRrYNhWTg
Date: Thu, 14 May 2026 13:41:34 +0000
Message-ID: <CH3PR12MB7548A1A5114A588B8FFB57CDAB072@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260512193520.3109172-1-nathanc@nvidia.com>
 <20260512193520.3109172-2-nathanc@nvidia.com>
In-Reply-To: <20260512193520.3109172-2-nathanc@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|IA1PR12MB9467:EE_
x-ms-office365-filtering-correlation-id: 75755874-1f73-4893-4c11-08deb1be838d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|4143699003|18002099003|22082099003|56012099003|3023799003|11063799003;
x-microsoft-antispam-message-info: ImKH5Vy0uzsOhvS77jGh+InOBKQfY04CXBiEnYVvb4QF35PIp1ZOQQeVoyuDxZd7z7kAeIb7/Bys0bkDNluaWkTrkjviMj5GVbXHl7609Lxu+DhHAa/tPDD5ZIHDEo3oM5tPuSappfg5dpBUp/GT0nBqCG9jnxX7TxlBmturC37EBzMbvI5ukHmlRliNYOGh3GWVlc760BbGXZXvxkWIDXP6qLyJZNwYurUAWuAwNmnvvb+mfxQ4vuqYC34N5S9mQnGB/Xy6g8LlWCDmGgDZ800S8983/2KcksjUOeruLEyCAqTJJMvwB55o78oj92zfQLF7Gg4ZT45oj2Zp5xcEMP72hlVKh0eI2l6IACrDhBnSEtMrpLRtk28KuDjhFbQTX8fCf+6s167ODi7MqD27oi3sMz60ni8kzCwKgzW8uLB5UK1HVSk6c6f0tIfrORdyHB8XKfXS9n03nmJm8SDEyc2AlN+h/GGZhTWbTfxKw/yWL+NMS/6u/Cu49BgFiEh0rSplnNPSHpO5GjjrRfnVGawZ7jB92DM2W7Vi+7VJaC0m678/ukt10CZ4gl3juX6tXtGSbDWg1wFATQ3INGhmNLtF/e/u6qhinxW+6tTfA92NcFX5iR/7Ukmq94OQLXhdxnb43zDjyBU0LR+sG1KKOAerXVfPXUDWs8duwPtGOUU+QyEruf8HJLRCTZ0ylBKCrH/W9kQ3ygpu9x4YCpt68ptLB0j5zvX9BE1khA/r/Nhr0IerIPDJbuOdmwS33nnu
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(4143699003)(18002099003)(22082099003)(56012099003)(3023799003)(11063799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?AI++hfDNdPUwooayYsf2zkUHPfX+WIarpLBhq+NXRnBaRSS8fP0Wme6TYO?=
 =?iso-8859-1?Q?ywvXKYz1gGHq4gWJnsJJ8pgOr5/fFw4RuqtVAwHyHrvsoErZuwP3HprgT0?=
 =?iso-8859-1?Q?MorCCNhMMBalYmwkEzW1QU9rP3LzKwozmquyfRKotY9gCR1GfQo+1qKaxs?=
 =?iso-8859-1?Q?v7BiuIk/tKXGt3uDkxcIGJTqaHPTtaPx5tWpLcIIxPDQB+jU08ohR2DHK+?=
 =?iso-8859-1?Q?5JDGK+oLvJq33U/M/cmRzz7TPoTkKna8Zf1SE/xdDO0eg2+/V5R/BASra7?=
 =?iso-8859-1?Q?346d7m2Y5p6nqD+A9M37/3FjU5OBj4oltHCgj8f4MKOkpH6uWTdsSnt3nA?=
 =?iso-8859-1?Q?QxywZM8f7Z7PO3UavLtqoAgbePIAeJYqi48ozBbspdZIzIiyW0Rzzyx5GR?=
 =?iso-8859-1?Q?onfUDq/4b4wT+KlMC8/ppLkPwx1oPu+bfR1L7EMy1RZtCvHeiuhzQUlaH1?=
 =?iso-8859-1?Q?J3NIVep3iUN6qQF09ihqfKZsEgMgokpBbGUczMKEMbNpR/p2Alo2ZZ9PRk?=
 =?iso-8859-1?Q?5zMjMaml5xf1yTVl15ePaCNHQp+RfeeljdV91huCs/g/BP2U1qJMhk/TQC?=
 =?iso-8859-1?Q?dw4UZTUT4ZV8gtlzjoaIrjAkTjlbnVuENuWz8iMYc6s88A+qNLAYJ+tw4G?=
 =?iso-8859-1?Q?hN1HNGm/5n6W95gsT0A9dlfcHolM1ck7bLO1ifm+OcL4zCWwwNVmRKaFw9?=
 =?iso-8859-1?Q?uxNAs909n3xylw2sQdGebXScosxSTJrSrs3p3BJC7O/izWoHklDhNkmAQ6?=
 =?iso-8859-1?Q?QTSNML+nzPL0q4uAftjeVict62vD2FZsyZgGt5X/mDAfM+qScjMqacCxnw?=
 =?iso-8859-1?Q?UVw/FlKaDpJnWE7bryQgT4BgRT3CUKRJ5QLt5DhLXQGaqU5wsRpHiWKM0m?=
 =?iso-8859-1?Q?sHxt8q7NT9wJFgOM1s+RYmT2JvB4uNqtT/Wv7yO2cd167UT023xWVu8Jhr?=
 =?iso-8859-1?Q?gqWkebTVDbXLS8Jmu65SnyLMLxLo0xsylkM6//0JQ3BTcEvoDre4wbrY1z?=
 =?iso-8859-1?Q?0VkxUbFfEvrd7CmxjOUdjrNdFnvTSGbVYugxyY55YZhL2EFdp9RZwxiJA1?=
 =?iso-8859-1?Q?5atNNxZFeNj59xbzM96sDRAcZ3+zJlxM/ivY1f4LgOJCXJ3Rv5fDx1KDGP?=
 =?iso-8859-1?Q?vuxcM864jDciVmkcmTm57diSKlhQowUc1IpsHO7EReRByvEqPWeRo5sF4j?=
 =?iso-8859-1?Q?S+X+oEBRg/xFi45BxDc3uctUBOtK4KBOLQzCzNuM2yH97QMzLMYq7ig+KR?=
 =?iso-8859-1?Q?sBTd1xYdLJ8w+mJMOQ4s0UiBk7pZV23rQSRdXzYFqiAAvZBccbp3TuRfke?=
 =?iso-8859-1?Q?ABWcca6m4NSz6jXvTfUP1ACAuXK15AGOIFlefR4ulkQTfFod4JhK7XAdPh?=
 =?iso-8859-1?Q?H6d6w0XVaw/FRoO3CbhbbOIfx52+5IUIQQ15yNC03bazMUBiPOIeW7c2nf?=
 =?iso-8859-1?Q?41vMztoIv7QhC7LMjO7FUGDhhMh35YWPrrCn/C6bMpsQLWsUyyDcUa5Bhj?=
 =?iso-8859-1?Q?PNAZgzcI+rz7ObOzu9grOdoeORb8D96jkiOQxXZQITLWcjaGcV5gffdPEF?=
 =?iso-8859-1?Q?6yXUyc/kIem+m7zg1uEWpl9VPyF3KW+XdgMn6SeC/pEo7olfGqZMp3JprA?=
 =?iso-8859-1?Q?AlrEQroaZM+pwX8EOeD9f3CKd8AsCjFRzgU+LDMzPuKf/vuWGPPml49nOD?=
 =?iso-8859-1?Q?GaKpZV71ctku19dJzWmTwLuOzawNyQi1PFies3d2H3ex8H8DN4HIoZK712?=
 =?iso-8859-1?Q?BmGCkCZ/RMi9MA0P3RZ/jZwsOYt6rEmgTmYQo3HveekXR2l/KF33HyE1Ea?=
 =?iso-8859-1?Q?Y0Sav6G4vg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75755874-1f73-4893-4c11-08deb1be838d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2026 13:41:34.2010 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AtSyhdgF1tAAr7tg8jFgt29EI4x0jFU9Aq8Lc+3abzyZTo7clO2Y66Gncp2VX7HXO0IJjeZZR0nySqvlad8MXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9467
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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
> Sent: 12 May 2026 20:35
> To: qemu-arm@nongnu.org; qemu-devel@nongnu.org
> Cc: Eric Auger <eric.auger@redhat.com>; Peter Maydell
> <peter.maydell@linaro.org>; Philippe Mathieu-Daud=E9 <philmd@linaro.org>;
> Zhao Liu <zhao1.liu@intel.com>; Matt Ochs <mochs@nvidia.com>; Nicolin
> Chen <nicolinc@nvidia.com>; Shameer Kolothum Thodi
> <skolothumtho@nvidia.com>; Nathan Chen <nathanc@nvidia.com>
> Subject: [PATCH v3 1/7] hw/arm/smmuv3-accel: Add helper for resolving aut=
o
> parameters
>=20
> From: Nathan Chen <nathanc@nvidia.com>
>=20
> Introduce smmuv3_accel_auto_finalise() to resolve properties that are
> set to 'auto' for accelerated SMMUv3. This helper function allows
> properties such as ats, ril, ssidsize, and oas support to be resolved
> from host IOMMU capabilities via IOMMU_GET_HW_INFO.
>=20
> The later commits in this series set the auto_mode flag to true when
> an accel SMMUv3 property value is explicitly set to 'auto', or if the
> property value is not set and defaults to auto mode.
>=20
> Setting these property values to 'auto' requires at least one
> cold-plugged device to retrieve and finalise these properties. If the
> auto_mode flag is true, register a machine_init_done notifier to
> verify this requirement and fail boot if it is not met.
>=20
> Hot-plugged devices into an accel SMMUv3-associated bus will re-use
> the resolved host values from the initial cold-plug.
>=20
> Subsequent patches will make use of this helper to resolve 'auto' to
> what is reported by host IOMMU capabilities.
>=20
> Suggested-by: Shameer Kolothum <skolothumtho@nvidia.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.c   | 44
> +++++++++++++++++++++++++++++++++++++++++
>  hw/arm/smmuv3-accel.h   |  2 ++
>  include/hw/arm/smmuv3.h |  2 ++
>  3 files changed, 48 insertions(+)
>=20
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 862be814a0..82c0800f4d 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -18,6 +18,7 @@
>=20
>  #include "smmuv3-internal.h"
>  #include "smmuv3-accel.h"
> +#include "system/system.h"
>=20
>  /*
>   * The root region aliases the global system memory, and shared_as_sysme=
m
> @@ -35,11 +36,32 @@ static int smmuv3_oas_bits(uint32_t oas)
>      return map[oas];
>  }
>=20
> +static void smmuv3_accel_auto_finalise(SMMUv3State *s,
> +                                       struct iommu_hw_info_arm_smmuv3 *=
info) {

Nit: Move the opening brace to its own line.

> +    SMMUv3AccelState *accel =3D s->s_accel;
> +
> +    /*
> +     * Return if 'auto' was not set for any accel SMMUv3 property, or
> +     * if property values were already resolved from a previous call
> +     * to this function (e.g. if this function was called again after
> +     * VM boot during device hot plug). We do not accept new property
> +     * values in this case where auto_finalised =3D=3D true, and we re-u=
se
> +     * the values determined from the initial cold plug.
> +     */
> +    if (!accel->auto_mode || accel->auto_finalised) {
> +        return;
> +    }
> +
> +    accel->auto_finalised =3D true;
> +}
> +
>  static bool
>  smmuv3_accel_check_hw_compatible(SMMUv3State *s,
>                                   struct iommu_hw_info_arm_smmuv3 *info,
>                                   Error **errp)
>  {
> +    smmuv3_accel_auto_finalise(s, info);
> +
>      /* QEMU SMMUv3 supports both linear and 2-level stream tables */
>      if (FIELD_EX32(info->idr[0], IDR0, STLEVEL) !=3D
>                  FIELD_EX32(s->idr[0], IDR0, STLEVEL)) {
> @@ -918,6 +940,22 @@ static void smmuv3_accel_as_init(SMMUv3State *s)
>      address_space_init(shared_as_sysmem, &root, "smmuv3-accel-as-
> sysmem");
>  }
>=20
> +static void smmuv3_machine_done(Notifier *notifier, void *data)

smmuv3_accel_machine_done() better.

> +{
> +    SMMUv3State *s =3D container_of(notifier, SMMUv3State, machine_done)=
;
> +    SMMUv3AccelState *accel =3D s->s_accel;
> +
> +    if (!s->accel) {
> +        return;
Not sure we need this as we only register this for accel cases.

> +    }
> +
> +    if (accel->auto_mode && !accel->auto_finalised) {
> +        error_report("arm-smmuv3 accel=3Don with 'auto' properties requi=
res "
> +                     "at least one cold-plugged VFIO device");
> +        exit(1);
> +    }
> +}
> +
>  bool smmuv3_accel_init(SMMUv3State *s, Error **errp)
>  {
>      SMMUState *bs =3D ARM_SMMU(s);
> @@ -925,5 +963,11 @@ bool smmuv3_accel_init(SMMUv3State *s, Error
> **errp)
>      s->s_accel =3D g_new0(SMMUv3AccelState, 1);
>      bs->iommu_ops =3D &smmuv3_accel_ops;
>      smmuv3_accel_as_init(s);
> +
> +    if (s->s_accel->auto_mode) {
> +        s->machine_done.notify =3D smmuv3_machine_done;
> +        qemu_add_machine_init_done_notifier(&s->machine_done);
> +    }
> +
>      return true;
>  }
> diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
> index 407940616c..87fecb5c68 100644
> --- a/hw/arm/smmuv3-accel.h
> +++ b/hw/arm/smmuv3-accel.h
> @@ -25,6 +25,8 @@ typedef struct SMMUv3AccelState {
>      uint32_t bypass_hwpt_id;
>      uint32_t abort_hwpt_id;
>      QLIST_HEAD(, SMMUv3AccelDevice) device_list;
> +    bool auto_mode;
> +    bool auto_finalised;
>  } SMMUv3AccelState;
>=20
>  typedef struct SMMUS1Hwpt {
> diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
> index 82f18eb090..fe0493c1aa 100644
> --- a/include/hw/arm/smmuv3.h
> +++ b/include/hw/arm/smmuv3.h
> @@ -74,6 +74,8 @@ struct SMMUv3State {
>      OnOffAuto ats;
>      OasMode oas;
>      SsidSizeMode ssidsize;
> +
> +    Notifier machine_done;

Better to #include "qemu/notify.h" in this header.
It may be compiling through some indirect #include now.

Besides:

Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>

Thanks,
Shameer

