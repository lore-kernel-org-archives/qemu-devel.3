Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75072CD4F25
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 14:12:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNWmw-0003rJ-Dn; Thu, 14 May 2026 10:11:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wNWmt-0003qx-IG; Thu, 14 May 2026 10:11:43 -0400
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wNWmr-0000G1-88; Thu, 14 May 2026 10:11:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tW6055+lJ71nGvz/F9GVPUHlDN1Md7aKYwVrCFM6LlE3gMBvfqxMIHjMnNDrMVJ/pDucehdFZKJCnCeOByYKGhkzP/mETDtJdt5fGgY3gnPDzuky3Eb/t4tk8hmfcmJfDqSLO5ruTnOUI5vYzl3WXf743DHFOG4xSrwaSfvEyWXbrKaKBv9s09agSIdyr+Z5FuE1RqIQAOA1SAlr+/drjXT09OEfA8IKkI4K7U9qPmag7YUOY8NqZXlsQT/ai/8tEaGo6dURHGVUqNzjZWJ8Nidjdos+4qs4Jq15yFBVhlUHVNAEH2N4UObXirG8hbVeMnYTpzjpLdvE/+5eU4O0eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Si/PjevTQEKAx9XtHskcPKbkI2YY8SbuulBoQldk7s=;
 b=L6zze7wlkm2T3ayhR1ij6Avo7wSkEQnpcvgDhWNK6614nZfes3lw7Vvk7O8aAOhpksZz9Dz5mpYSAz7VTrMb0Ku2zapGcNFKfvFP+Ab/GSPKtolZjFWr/eN4PWTjmPZ6miJv3fxsRsRzvJba3jAL6Djz0gH860L8PjbptddGCblcYvMnsTiXfgaqNAnv2jMl1KjHSEZZakllO2wCFvuZnIaKbm7JH+SbM9zjVutYYEAhrGkujWQ8q/Wx98Q1gNpPQlhFN9La3bQg6JsrjR8i8UT0Ug7BLbct//v91v+GNGNzaAqMShikHpMeEOykrUucTxAdT1SswP+dvkMxSuwl7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Si/PjevTQEKAx9XtHskcPKbkI2YY8SbuulBoQldk7s=;
 b=NRpTOCHjnUN403JNOBVihF4sUSvYWeqEGvs7iOaRjglVzHWpCyZ/fuFqKmIg5KQMUJGsRkEbWz+BBwRKUvOZc6uyz+VPjsZ8kpJ5V7OU5fZKqBBDiyGQvpU7y7wf5Rf18m34LnYJqIhvhR4bgjyrYfuyIxzF3OR+A9pnFX0CQ0UWn83xwH79F1j5/BjAf7B+uXKgA3dh8bR8Q6g5lRHFdIo1Dhr2oMfo1iPsS0bNCDbE6T6Ve+RAeZh0aN7MpSQpohar+wM5HLgnF6Wbe7Lk9fISQ5tBddgv+1c6N+KmJ9CORQIzAGrS+uuTodnaYSkstaHob37z4cCUJsqXwcNbwA==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Thu, 14 May
 2026 14:11:31 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 14:11:31 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Nathan Chen <nathanc@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Eric Auger <eric.auger@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>, Zhao Liu <zhao1.liu@intel.com>, Matt Ochs
 <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v3 2/7] hw/arm/smmuv3-accel: Implement "auto" value for
 "ats"
Thread-Topic: [PATCH v3 2/7] hw/arm/smmuv3-accel: Implement "auto" value for
 "ats"
Thread-Index: AQHc4kaIKC7DjtHfhUOSgnIS3G+/RrYNkQ6w
Date: Thu, 14 May 2026 14:11:31 +0000
Message-ID: <CH3PR12MB75488C9306659D939ACEE203AB072@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260512193520.3109172-1-nathanc@nvidia.com>
 <20260512193520.3109172-3-nathanc@nvidia.com>
In-Reply-To: <20260512193520.3109172-3-nathanc@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|IA0PR12MB8208:EE_
x-ms-office365-filtering-correlation-id: 547fd1fe-d68f-4ce6-2570-08deb1c2b294
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|11063799003|56012099003|3023799003|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: wSai7wadQ/nFYKDTWFbNXsXtJKxGITz5qBYizKqBNsT+NpsFo/OWyMFeNpNhcAsHe45ReR39Lu7EufAca3dlEObQH/KDoxG+CfItoYMR06579eW+VODoXGkQTELJb47GdElHvLZ4qsBHUOjXXKoPbfgK23C3zNklXMR9am9NfRpGz1s815D/fq0N14PKgfpXy1srHgrvC4ZkpiKSn7L4wLcqkSjaehB3tOdfeunOBLPEWHvHBpyE/Tfc8bYz8U7BIUYZnSX2SUuKNC4zkLprNjG+aTif1JU/VBtk9hwtKOIaPynku9LPSwji6WsHuNX+i1EHqVq9eUxvAcmyMqEwLCYZD9iIgS8mH8yrCkAyjeHnY8RTBl8LLTzMA06k7DC8D6ZmYWuYcL6OgQTrIlMLvzDWtLOpIk/tu9A98KXWgzqRUt6Vlh0R6KNTEqZZ91rC/ZIlun4sQIH7A8iPQp42TReALeu6IpCTGCYJJNU//OQl+0ccPauPgl7ErgxSKeka2nF/yLfIDxcHl3H00AJq6ywgvH1ruInnsIjEyM74jdVCWxJ4cKRBbGAGF3iIOQrMb/k8YKKQaFnWOrCC5BTw8cfXiBmQchxtfQjpNaEEfPhmp1Gcj17aJ06aSF0f0/s1hlOmdeayFFhwMbOn6WIec0YEeMmF4/XzbjAoSdrLnVrGLPS6EmIyGskie+d9EEGFtrDFuJpk9bfHJPo83WTXM7Dya968dG4iQxfLa1cVMbI5oLp0AJv3Kn0NIP5p5Sx2
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(11063799003)(56012099003)(3023799003)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fMOjp3Myu5m8qbZA/cf5cxoOoog0Rg0RL0KN0RAKpwnQpe2eeE0lHD3PDM?=
 =?iso-8859-1?Q?PNBZvNTKkPXZgosPYzaHWNTIZ8k6sm7BawC5+kncLm1J7J6RARDMQ1FeJ0?=
 =?iso-8859-1?Q?B8Hmo+q2CGEEb9GWpcMe+o7L1BGwsFNpYDU9c2alNLJjkQCDXdkB4AbVia?=
 =?iso-8859-1?Q?vzcQsRXk3lEcwWGl5LtvVFDKM1ZRNObqhriXvFlT2QtC9bhA6FJjdjy/um?=
 =?iso-8859-1?Q?E2lYRmMisdHJ4Vj0CDQa/ovHZH3p4yr1kU7ZdyInpNDNeAOYbyEekSQsuG?=
 =?iso-8859-1?Q?A+hCN6My2Nwbfp1AFp3h66DCjK/rBuTFCZaPN7nlQ42iaBQQremea/19Os?=
 =?iso-8859-1?Q?1FpRyL2yL6YssEG1AnE23AMTtiBPKb/JRaLgeEsBqZQ8XJK0hhVRjNL6tD?=
 =?iso-8859-1?Q?WtbarGwp6CBbcvcXIpPCQ/QEWI14DQtwybgleEhIaXkay9RpJiON8SE9uQ?=
 =?iso-8859-1?Q?bSt6rwAkrume0cN1wPEQFBvGaJTsRJJooNnZZBQCgphjTIE5EFnWJzWvyt?=
 =?iso-8859-1?Q?4oEP6XlfPPs0w4wDOVDq3v/Hf698Y/t7VQ5ryIS/WweAcrpyjUfQL21Tt3?=
 =?iso-8859-1?Q?yerdve/GZ4e0dIBDDPnb1Edf0B3LX/7fJmD6WJDJmrTGXlkO/Rc/5nrw6u?=
 =?iso-8859-1?Q?sAULIKelkcJNspsd4aBT5w7Ij1ucpnrpwOiX6algZjZGOoSWhszJ4KEPz/?=
 =?iso-8859-1?Q?G2ZvJ4AnhBwIOHEm+mMNkEAY2pNm5onYNXOJKAZXuyQVLdaNQTfycmmL6b?=
 =?iso-8859-1?Q?amvG6zny3nf6+PZqx+9WvwOIZhOTfEBzfYpcB3nerVHDEYGWSV74wN1jC+?=
 =?iso-8859-1?Q?ksvvpFlxPtnWXpAtH9ieRf8bLsVgIXKQWBE/mC1eX6ES1jlKoxrMvyTWSZ?=
 =?iso-8859-1?Q?vLjvY4g61ToTcXlLm2O6hXntvKJ4sGXVBCUYanGDzUoYCU6h5xLH2Ag7dJ?=
 =?iso-8859-1?Q?WzaFSP3WNv1RsiEBtWM0qG0T3oUp4Wt3h0FdVPWCDTNoTzmOp+Oudw6Fjh?=
 =?iso-8859-1?Q?UkdxN1TGTO7mmuCIZQHoSE9sZ4VduAzkfaSr/LLXnlLuFlYcs5/rCtiPmt?=
 =?iso-8859-1?Q?4kRaEfFsDiQ2Q+YFmRHVh6d1BE+wkVo7tcMnkwdyh4KxE2R6QWkEE2CoOb?=
 =?iso-8859-1?Q?nX+8k95ZSicwIhVs/ETBtfdvrTISbgO/gyqJxSrhucDU/t9wtMLqNKYEAS?=
 =?iso-8859-1?Q?qCMVZy+UdEazFaforxMrlSChnFB76RBWipDRZoFkpzIK3IosymPGXv1VFR?=
 =?iso-8859-1?Q?+qUkh3FdRq10o+CxCbGwqvV0Z1vhwvJWXiEGbvozEGpGTCZbaK+ZJtt7lH?=
 =?iso-8859-1?Q?uYVbFPsmqURWoaJ+HRb3xdfhLMynYlp56Na5YcmBhZhSMRYREJoyqKuhA/?=
 =?iso-8859-1?Q?KnUNz9FgvrAhkTEwkMxhuOxSM1P6mIv0BmGgu4/BJHZIdLsAQef78qZTGT?=
 =?iso-8859-1?Q?4xWiSuP314bYOo2hJqhqlL4GfCikuyugigpZysukVCuNm7decNhfQ5zihK?=
 =?iso-8859-1?Q?rVdFRYI4hH07+oExh2BpARk0Am7UNJ21oEOyDPIHdz7i0RPonm+pPlnp74?=
 =?iso-8859-1?Q?MW7QufSSDz13OaKR7q9BcTdGDIMBUuk2xl9dgT2amp0JYRq6RZTLINdwxB?=
 =?iso-8859-1?Q?5VV74iEVv6VpzzD27ynzt7Ojv5ABzvUEmbX6lLt8WZlQt/SOtGcHap64PG?=
 =?iso-8859-1?Q?/EqPfIt2itp4VuOqCgZI7EcEmGY7z+j+P/kFWYOjCrrcASA5exgtjvWGBz?=
 =?iso-8859-1?Q?Fc2PEbTkR1H3bUsJlJkdCxCYiGGVBQnhWHVEtZHq7F+3SHEBZBaj1pbnPr?=
 =?iso-8859-1?Q?6moVKlVJZg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 547fd1fe-d68f-4ce6-2570-08deb1c2b294
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2026 14:11:31.0658 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nL71wSqGb5sPUClk5C59HXp93LSJrOl0rT25XbB2ztJFf9L+xP3G4UrLTKQV7cPZPMvp8KQtovY7VnvP+WSM/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8208
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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
> Sent: 12 May 2026 20:35
> To: qemu-arm@nongnu.org; qemu-devel@nongnu.org
> Cc: Eric Auger <eric.auger@redhat.com>; Peter Maydell
> <peter.maydell@linaro.org>; Philippe Mathieu-Daud=E9 <philmd@linaro.org>;
> Zhao Liu <zhao1.liu@intel.com>; Matt Ochs <mochs@nvidia.com>; Nicolin
> Chen <nicolinc@nvidia.com>; Shameer Kolothum Thodi
> <skolothumtho@nvidia.com>; Nathan Chen <nathanc@nvidia.com>
> Subject: [PATCH v3 2/7] hw/arm/smmuv3-accel: Implement "auto" value for
> "ats"
>=20
> From: Nathan Chen <nathanc@nvidia.com>
>=20
> Allow accelerated SMMUv3 Address Translation Services support property
> to be derived from host IOMMU capabilities. Derive host values using
> IOMMU_GET_HW_INFO, retrieving ATS capability from IDR0.
>=20
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.c |  9 +++++++++
>  hw/arm/smmuv3.c       | 11 ++++-------
>  2 files changed, 13 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 82c0800f4d..9fbd13c438 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -52,6 +52,11 @@ static void
> smmuv3_accel_auto_finalise(SMMUv3State *s,
>          return;
>      }
>=20
> +    if (s->ats =3D=3D ON_OFF_AUTO_AUTO) {
> +        s->idr[0] =3D FIELD_DP32(s->idr[0], IDR0, ATS,
> +                               FIELD_EX32(info->idr[0], IDR0, ATS));
> +    }
> +
>      accel->auto_finalised =3D true;
>  }
>=20
> @@ -964,6 +969,10 @@ bool smmuv3_accel_init(SMMUv3State *s, Error
> **errp)
>      bs->iommu_ops =3D &smmuv3_accel_ops;
>      smmuv3_accel_as_init(s);
>=20
> +    if (s->ats =3D=3D ON_OFF_AUTO_AUTO) {
> +        s->s_accel->auto_mode =3D true;
> +    }
> +
>      if (s->s_accel->auto_mode) {
>          s->machine_done.notify =3D smmuv3_machine_done;
>          qemu_add_machine_init_done_notifier(&s->machine_done);
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 5c2855c377..e558f09652 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1965,10 +1965,6 @@ static void smmu_reset_exit(Object *obj,
> ResetType type)
>=20
>  static bool smmu_validate_property(SMMUv3State *s, Error **errp)
>  {
> -    if (s->ats =3D=3D ON_OFF_AUTO_AUTO) {
> -        error_setg(errp, "ats auto mode is not supported");
> -        return false;
> -    }
>      if (s->ril =3D=3D ON_OFF_AUTO_AUTO) {
>          error_setg(errp, "ril auto mode is not supported");
>          return false;
> @@ -2170,9 +2166,10 @@ static void smmuv3_class_init(ObjectClass *klass,
> const void *data)
>          "Disable range invalidation support (for accel=3Don). ril=3Dauto=
 "
>          "is not supported.");
>      object_class_property_set_description(klass, "ats",
> -        "Enable/disable ATS support (for accel=3Don). Please ensure host=
 "
> -        "platform has ATS support before enabling this. ats=3Dauto is no=
t "
> -        "supported.");
> +        "Enable/disable ATS support (for accel=3Don). "
> +        "Valid values are on, off, and auto. Defaults to off. "
> +        "Please ensure host platform supports ATS before setting it "
> +        "to on.");
>      object_class_property_set_description(klass, "oas",
>          "Specify Output Address Size (for accel=3Don). Supported values =
"
>          "are 44 or 48 bits. Defaults to 44 bits. oas=3Dauto is not "

In smmuv3.c we have;

case SMMU_CMD_ATC_INV:
        {
            SMMUDevice *sdev =3D smmu_find_sdev(bs, CMD_SID(&cmd));

            if (!sdev || !s->ats) {
                trace_smmuv3_unhandled_cmd(type);
                break;
            }

            if (!smmuv3_accel_issue_inv_cmd(s, &cmd, sdev, errp)) {
                cmd_error =3D SMMU_CERROR_ILL;
                break;
            }
            break;
        }

The above !s->ats will be true for AUTO case, right? I think
we should change the above check with smmuv3_ats_enabled().

Also, since we modified the ats to OnOffAuto in the previous
series, I am not sure the above should be a fix patch or not.

Thanks,
Shameer

