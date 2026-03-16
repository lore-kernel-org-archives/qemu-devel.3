Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C298F013E8
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 08:57:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w23km-00021e-Co; Mon, 16 Mar 2026 04:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1w23kk-00021O-UB; Mon, 16 Mar 2026 04:56:46 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1w23kj-0004v1-5Z; Mon, 16 Mar 2026 04:56:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=phL5tq2Thf/hmGyllbhL5+/gEunMhr+ZeFOZGtraQGzyj04hpaxrGvoHIrv3Qqh02PrnI7xeJm0CNFqi3n9g3rMsZ0qH/wAlDVzJ+n2S0TJKrT4//VBCpmd6NtY7iv+9Upey1fvYFcQw5aQbY6wcGCuTAFKVmW6xM+WN5c8g4N6Ut+lYpUJNv5U0poVCD92Gdh080JcRU3ajIjdVklQrBKRYFfrRCxAueQDtZUN0KW3jt+f+VM2My+H7qZkvkhQ9UZmyu3gsHZBpuCL/V6IbjsF30bLju2qAb+DbN/18jMXsJ/fL7fJJlKjij4ZZe8pc1IIu1foXLbiLK/6nj7H+/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NaPHSMuDeLkEMVNy0ZQJ9/U/LM6OfW6y6nM5THUGPH0=;
 b=V7iGiqx6TzZtCqxCKvmf4v2mI/QNvDMoNKPTNf+ksPvBM3HJKOSMqzhQRhR5bPMZALn6EFbuiZqLhqhZs9TSuQaiuTiFovWn5RhuzI8iUDg78j31FlmfIwG6pfczKgOcry5c0UQ//xb//vSBxxOyFAaf93941HdnYR3YCTEXPikshD4CdeRY2sMYUoRIDc0XfsHtlYhql841T2hp3a23dPsCZi4RTwpc/ptEfWwGEkI2rkR7weG7uw3gIKBQojxv4mm77lrN7TL3tUwJ1stOi0cLgDzTrp0uRmF8oixgL01ifW+Z+lOt3X04Tjs8DHepR27OzdnlPkdwAmM8M5Z9vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NaPHSMuDeLkEMVNy0ZQJ9/U/LM6OfW6y6nM5THUGPH0=;
 b=HSHCah5yq5UfzmAAL74r0VeWSAiDWACwgy5TlMjie4Nx51cESNS+Dq5BuaePaP4M+AKJSuKcoauizB1cQrtks8aG1hcGvt0oCIGBrFwIype0m97Bg31n9ms858639wCy65j59dhNCjAvV57TyFH8RHLOnumPunj2aXyU6DhN37tuIpi2pwADCSCIqtDVURIHOpSYOVKSzPZmjtrYTi3lZ0n7+/MyKrDS+SY2Ie99b/P8xJicQK21BUvsBMerbmrvecDhfRL/dBIR80g5BZHYuE0GsUq0y7hSf9LpWNhpyJvwmo1mHtJpj8S6oRPDcQemzDyKR0yDc06TjgpRDSSF4A==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CY5PR12MB6034.namprd12.prod.outlook.com (2603:10b6:930:2e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 08:56:39 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9723.014; Mon, 16 Mar 2026
 08:56:39 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Nathan Chen <nathanc@nvidia.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
CC: Eric Auger <eric.auger@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>, Igor
 Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>, Shannon Zhao
 <shannon.zhaosl@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Daniel_P_=2E_Berrang=E9?= <berrange@redhat.com>, Eduardo
 Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>, Markus
 Armbruster <armbru@redhat.com>, Nicolin Chen <nicolinc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>
Subject: RE: [PATCH v2 5/8] hw/arm/smmuv3-accel: Change SSIDSIZE property to
 SsidSizeMode
Thread-Topic: [PATCH v2 5/8] hw/arm/smmuv3-accel: Change SSIDSIZE property to
 SsidSizeMode
Thread-Index: AQHcsmO9MdSVT1KR/EGaZEYGGlMG2LWw4BjQ
Date: Mon, 16 Mar 2026 08:56:39 +0000
Message-ID: <CH3PR12MB7548AC937FEFC3CC4601AAB5AB40A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260312210328.2016191-1-nathanc@nvidia.com>
 <20260312210328.2016191-6-nathanc@nvidia.com>
In-Reply-To: <20260312210328.2016191-6-nathanc@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|CY5PR12MB6034:EE_
x-ms-office365-filtering-correlation-id: 4292f979-4a4b-4d86-8351-08de8339efb2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700021|22082099003|56012099003|18002099003|7053199007;
x-microsoft-antispam-message-info: +dP6EmP0JJmWFlz54hLZ9oBoxz/Rm/8rB3Z+sJbJ4UHaLG14AjygsT0YdSUFY5mRccCOqPBeBFNlIjzOQGKpFIDMiNquD+b+oY+cGfjP/oBaeaC/GuOGl4VLdcaP2K0tKo/VSj7I9wbKhf6uD0Bukd/ZrP0l9aCnOjYE7BbA/LMGL4N7L3pzO9WvU8fO4FanrqhckOCpvbZ66Z2dLM/jL1gyOGbYLVc8/MOMGUwsNU3hNHYp0St9PPYCxYa3ViQxI+KN04X6Nuuix/2hSBiRDgBDiKXrN2pkE+3fjeBI2O911FfxNEvQPB+j6POSe2tw6E8tOXdk/1mBvibJPbiKRkd0SLTb/MUR4EqABkvL6ky7ltvlD12724zkQh5bnk1/4kKDsR2vAU0gQCnhPPXLW6PSwjh322FyX2seSfe3SCm/K8fbzlIfXmkil1gBYDxE9awTIE4sWNiXLU/E8Lpyn7Fyus0fior8gdVSTIFx/+nNYxKyyyM2cDDXz7iixxCk0yh8wvukmh7kePx47oUTQoDxog6U1iBfa3EUZFnHRkyTcqGhKByPd0aKCK+j9IsVrIXP0Af1q2D6XB139C7pahE7UhQRgbywvddNEpJ0owgU/fCdddfmUC3Aj3h39Q1WK8x/bij2EoWhrrYXr8+ij+336WQ4gmumYhPcimPDBDyzICB7m3s8ZeZelPNiD/aTjFwdzZVnlxgR7NmNndbY0VFZtT0wCIm5bat6PocYlhOzKysuUia/LCtJdaU0x5STy4IqwN2EKmRkYGMtBB0mrZhlQtH9iTogDT0JzyObhig=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?wEM97sUC97/aB4x8OacPnaemhxbt3xM66W0OLL/IkQKqOQ67vw+UGNWp60?=
 =?iso-8859-1?Q?cOjTKI3LTpLdR7OkBSKHNihCtJqwFDYcsGYMzPtJucMynZUMUFiGW6NCnN?=
 =?iso-8859-1?Q?dnVb2Lr+kZenHl90AdLvDnbXivxYmqveuxpJkzRzG/2ze1al5/NYhDUFkP?=
 =?iso-8859-1?Q?6c9McFUGPrKw0RGdWa2fEk17ZU2GFVg+hIfzBqhxZmhADHAlOhHc5eudQX?=
 =?iso-8859-1?Q?DFcEzPi3F3s2njD7WmeuOjXnqnIIulvOX04QitCgfutmevChNo53qCrz/C?=
 =?iso-8859-1?Q?PK16O5fLr/eNEETbcz11hFbNT3udd9Wkj0sn6lsGmENzAJzLB006Vbm7OG?=
 =?iso-8859-1?Q?VumpdYpGba+tMHLMVSxDlzZYOiKeHn7DdMkDQeCeGeAXvUVrYpxu1+6ofM?=
 =?iso-8859-1?Q?LHSJXlcuIX0a4AgFRk4WFntmNlKgA+K5+/sg8BJUKjViKBmAPJseBHkKRD?=
 =?iso-8859-1?Q?Fa76Is3Y/2XgT5uNUkAcjtsP+CGh/h5Fk06BEIgKHq8Zh1pTyYAmGzA1uE?=
 =?iso-8859-1?Q?8fI6Zva7WY3szCThakeC9PmKPxob/5fgQ7pYbCZGCKMqtOcfvyp1MrA55G?=
 =?iso-8859-1?Q?ctW3mP6EiV6NkpDpt9MGjXWzevY6k9Sh5+br2GxOjdLsCWgTrBs97i7JUK?=
 =?iso-8859-1?Q?THSt57GIggzLgzeujy7AXtzUH0pqeO6f6AIyDMYPVpttm19lCVyBdE+5bX?=
 =?iso-8859-1?Q?WmsM6qkwi2I1/XASic/3N5jU8oOGzdWVxea87DomTw7f69mDahSQzjB9a3?=
 =?iso-8859-1?Q?Rep2mBeUvsGkf+98syoQzt4I6u2nf4KQj6Ck6fV/yrIIOEhkKbF4r2QxSN?=
 =?iso-8859-1?Q?tq5SOEwrJYq2uWYU5ciF64neDbulxrMHwHVEADqP4L2ra24B0544MSFr3p?=
 =?iso-8859-1?Q?SP1m1g3+fw0mXOXniTg1vK/K8drXdL9to55hXdPQUeocO2KYuwbo7zZeP/?=
 =?iso-8859-1?Q?DYjtx+5GwWhRUpx+WNAcq6k+ITxTkJXeoD/K+5SVzk7GyKFoJHYoboTj2s?=
 =?iso-8859-1?Q?4xvOEo70SyYfylD7iSI3zZGs7gfFB3HL4e3KXw8v6vENgExh/c97P8EGOg?=
 =?iso-8859-1?Q?UfP026EBrhxKcaMsIJnd8uVpmv0kPGVh2TzPm6Zj4XVXAj1HrCxx9cl5ti?=
 =?iso-8859-1?Q?1OjYCMP8+3le/jRS5Jqn2197n8TPDKKUSJtmISFM6MnpaCNyi8VM27QKEb?=
 =?iso-8859-1?Q?9i1UXXJd0ABG1DK4FHBaVtqlGpSLF6DDvZObtP/Ty3RvX6SCJKhA1UwJWo?=
 =?iso-8859-1?Q?CK7oqgPzhQLKkWhYGr4IacXzMyRlL0/BBS9FZ0Y08I5yIRIQOQpOtnBmO0?=
 =?iso-8859-1?Q?WslTt67jZFjeWmJqw2kTiGFRaM/LkLp7yX5jlIUy94o+nxP/Sx+PHiGqQ1?=
 =?iso-8859-1?Q?i8Tr0gnJuTJM4ngYFacnPzsyn38rPapIs5kx5VDapL2xN2uRXk68NtLoMT?=
 =?iso-8859-1?Q?ExI/05lyUBDtVwv/4qs+/n9S+MwuqWbYS2HVGHtBgjwKQ+XqDjIvnR9Ov8?=
 =?iso-8859-1?Q?Wnzxn6SynjlYDqc25e+/R7m6wUa8TV26gPKXSt4TYjlqU0xsfq3Tku4q4y?=
 =?iso-8859-1?Q?uj7YtwOxyjNtpCfYHG89M7NM3dTCMby5dxb83XF+in4rMGezrLDxG9cdTz?=
 =?iso-8859-1?Q?4JV8hBN4SsRQigf3CSZRXWbJp7Aw1MMtWXp+s+03kV9Jk8SsFxUF0w8sXa?=
 =?iso-8859-1?Q?XjU4mbSO9I/pHgpKlWRmvRb3ZLBO1SFII0v7CQPQzfYrS+HCvakE7bNPw7?=
 =?iso-8859-1?Q?Cs08zlhzQC8c63xfPNINGLw2uF10aK1zsL8LBZEZPOS3UtepOgoIovQ9TE?=
 =?iso-8859-1?Q?+XCMFMToXg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4292f979-4a4b-4d86-8351-08de8339efb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 08:56:39.0623 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3VDlt6UWoIXMzFkB4DM9gpC4xhlENSLdrhNMrOoWm6XCxtQQx2aM2E/ZZ02sVlNtMCvOjtxktm2UQxAZrG943g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6034
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
> Sent: 12 March 2026 21:03
> To: qemu-devel@nongnu.org; qemu-arm@nongnu.org
> Cc: Eric Auger <eric.auger@redhat.com>; Peter Maydell
> <peter.maydell@linaro.org>; Michael S . Tsirkin <mst@redhat.com>; Igor
> Mammedov <imammedo@redhat.com>; Ani Sinha <anisinha@redhat.com>;
> Shannon Zhao <shannon.zhaosl@gmail.com>; Paolo Bonzini
> <pbonzini@redhat.com>; Daniel P . Berrang=E9 <berrange@redhat.com>;
> Eduardo Habkost <eduardo@habkost.net>; Eric Blake <eblake@redhat.com>;
> Markus Armbruster <armbru@redhat.com>; Shameer Kolothum Thodi
> <skolothumtho@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>; Matt
> Ochs <mochs@nvidia.com>; Nathan Chen <nathanc@nvidia.com>
> Subject: [PATCH v2 5/8] hw/arm/smmuv3-accel: Change SSIDSIZE property to
> SsidSizeMode
>=20
> From: Nathan Chen <nathanc@nvidia.com>
>=20
> Change accel SMMUv3 SSIDSIZE property from uint8_t to SsidSizeMode.
> Setting 'auto' will use the default value, i.e. 0 in IDR1. A future
> patch will implement resolution of 'auto' value to match the host SMMUv3
> SSIDSIZE value.
>=20
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.c   | 17 +++++++++++++++--
>  hw/arm/smmuv3.c         | 16 ++++++----------
>  include/hw/arm/smmuv3.h |  3 ++-
>  3 files changed, 23 insertions(+), 13 deletions(-)
>=20
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 6f44fd3469..ab037df7ac 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -803,7 +803,7 @@ static uint64_t
> smmuv3_accel_get_viommu_flags(void *opaque)
>      SMMUState *bs =3D opaque;
>      SMMUv3State *s =3D ARM_SMMUV3(bs);
>=20
> -    if (s->ssidsize) {
> +    if (s->ssidsize > SSID_SIZE_MODE_0) {
>          flags |=3D VIOMMU_FLAG_PASID_SUPPORTED;
>      }
>      return flags;
> @@ -818,6 +818,16 @@ static const PCIIOMMUOps smmuv3_accel_ops =3D {
>      .get_msi_direct_gpa =3D smmuv3_accel_get_msi_gpa,
>  };
>=20
> +static uint8_t ssidsize_mode_to_value(SsidSizeMode mode)
> +{
> +    /* SSID_SIZE_MODE_0 =3D 1, SSID_SIZE_MODE_1 =3D 2, etc. */
> +    /* SSID_SIZE_MODE_AUTO =3D 0 */
> +    if (mode =3D=3D SSID_SIZE_MODE_AUTO) {
> +        return 0;
> +    }
> +    return mode - 1;  /* Enum values are offset by 1 from actual values =
*/
> +}

Maybe better to consolidate these comments and move them to a
function level block comment above.

Thanks,
Shameer

> +
>  void smmuv3_accel_idr_override(SMMUv3State *s)
>  {
>      if (!s->accel) {
> @@ -847,7 +857,10 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
>       * By default QEMU SMMUv3 has no SubstreamID support. Update IDR1 if
> user
>       * has enabled it.
>       */
> -    s->idr[1] =3D FIELD_DP32(s->idr[1], IDR1, SSIDSIZE, s->ssidsize);
> +    if (s->ssidsize !=3D SSID_SIZE_MODE_AUTO) {
> +        s->idr[1] =3D FIELD_DP32(s->idr[1], IDR1, SSIDSIZE,
> +                               ssidsize_mode_to_value(s->ssidsize));
> +    }
>  }
>=20
>  /* Based on SMUUv3 GPBA.ABORT configuration, attach a corresponding
> HWPT */
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index acbd9d3ffe..8b0121c0ed 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -20,6 +20,7 @@
>  #include "qemu/bitops.h"
>  #include "hw/core/irq.h"
>  #include "hw/core/sysbus.h"
> +#include "hw/core/qdev-properties-system.h"
>  #include "migration/blocker.h"
>  #include "migration/vmstate.h"
>  #include "hw/core/qdev-properties.h"
> @@ -625,7 +626,7 @@ static int decode_ste(SMMUv3State *s,
> SMMUTransCfg *cfg,
>      }
>=20
>      /* Multiple context descriptors require SubstreamID support */
> -    if (!s->ssidsize && STE_S1CDMAX(ste) !=3D 0) {
> +    if (s->ssidsize =3D=3D SSID_SIZE_MODE_0 && STE_S1CDMAX(ste) !=3D 0) =
{
>          qemu_log_mask(LOG_UNIMP,
>                  "SMMUv3: multiple S1 context descriptors require Substre=
amID
> support. "
>                  "Configure ssidsize > 0 (requires accel=3Don)\n");
> @@ -1984,7 +1985,7 @@ static bool
> smmu_validate_property(SMMUv3State *s, Error **errp)
>              error_setg(errp, "OAS must be 44 bits when accel=3Doff");
>              return false;
>          }
> -        if (s->ssidsize) {
> +        if (s->ssidsize > SSID_SIZE_MODE_0) {
>              error_setg(errp, "ssidsize can only be set if accel=3Don");
>              return false;
>          }
> @@ -2002,11 +2003,6 @@ static bool
> smmu_validate_property(SMMUv3State *s, Error **errp)
>          error_setg(errp, "OAS can only be set to 44 or 48 bits");
>          return false;
>      }
> -    if (s->ssidsize > SMMU_SSID_MAX_BITS) {
> -        error_setg(errp, "ssidsize must be in the range 0 to %d",
> -                   SMMU_SSID_MAX_BITS);
> -        return false;
> -    }
>=20
>      return true;
>  }
> @@ -2135,7 +2131,8 @@ static const Property smmuv3_properties[] =3D {
>      DEFINE_PROP_ON_OFF_AUTO("ril", SMMUv3State, ril,
> ON_OFF_AUTO_ON),
>      DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats,
> ON_OFF_AUTO_OFF),
>      DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
> -    DEFINE_PROP_UINT8("ssidsize", SMMUv3State, ssidsize, 0),
> +    DEFINE_PROP_SSIDSIZE_MODE("ssidsize", SMMUv3State, ssidsize,
> +                              SSID_SIZE_MODE_0),
>  };
>=20
>  static void smmuv3_instance_init(Object *obj)
> @@ -2173,8 +2170,7 @@ static void smmuv3_class_init(ObjectClass *klass,
> const void *data)
>          "Number of bits used to represent SubstreamIDs (SSIDs). "
>          "A value of N allows SSIDs in the range [0 .. 2^N - 1]. "
>          "Valid range is 0-20, where 0 disables SubstreamID support. "
> -        "Defaults to 0. A value greater than 0 is required to enable "
> -        "PASID support.");
> +        "A value greater than 0 is required to enable PASID support.");
>  }
>=20
>  static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
> diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
> index c35e599bbc..ddf472493d 100644
> --- a/include/hw/arm/smmuv3.h
> +++ b/include/hw/arm/smmuv3.h
> @@ -21,6 +21,7 @@
>=20
>  #include "hw/arm/smmu-common.h"
>  #include "qom/object.h"
> +#include "qapi/qapi-types-misc-arm.h"
>=20
>  #define TYPE_SMMUV3_IOMMU_MEMORY_REGION "smmuv3-iommu-
> memory-region"
>=20
> @@ -72,7 +73,7 @@ struct SMMUv3State {
>      OnOffAuto ril;
>      OnOffAuto ats;
>      uint8_t oas;
> -    uint8_t ssidsize;
> +    SsidSizeMode ssidsize;
>  };
>=20
>  typedef enum {
> --
> 2.43.0


