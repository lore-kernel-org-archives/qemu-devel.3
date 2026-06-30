Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43725C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 09:44:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weV0R-0007Hk-RU; Tue, 30 Jun 2026 05:43:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1weV0N-0007Gd-Ac; Tue, 30 Jun 2026 05:43:48 -0400
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1weV0L-0003nU-NK; Tue, 30 Jun 2026 05:43:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tz4HWvp1IlNg575Y+eMZyghJrtFcqhxyMXN3t9S/xP5C4qhmn/kvl9ay+b0lviVvPQLZy2sDp+S0HCfDkapjGAMMpE29mZzZoyT5g0gg2l9ibIywZdoivbYNC99N3kW+eutIlZKnwL/mpoHYeTe6BbDBNV54ID12j37aFHrri6+ZXQVkO9EEj2QEcQEeyxj3KKVx3J9R5Mv1eG2E8sIlsTwEQH9oexhst/GrQ/f34GT16C5HbES2Dz7t++PozPqqI3iwTvC9I7KGqtQWECqD+g9Krn0E8NM82Ip7UBa3hZEhZoc7eRNdfwGbE1/p2728Uba+u/xXE5SnqPQKaJ37eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLDqfLs4liAvE1Qffke3P1Y16wc1Pn9hhcDPZEU0Nac=;
 b=KWuN/lbYb2lUVOczivJ5/oXS++NmR/nw2XeMrGurd/scEkzOyboFa2sJeyqzRTRyrLeuD8TfvFPfsOS/a+5UFnihBK4AGoe8wXRxJipXOqtgB244GhV/vjmJPoObwQYujKJMSzeIgtQZ4hNfQs9zBe9zCS6IzZuuuu8pIEAIsD8q2UHEMzYFc9Sg31+ZWZHuDMXkH7b1IkUI9TEJ7R+w3s/0QRkhYhqXkHt9YgLJouJMKDLFxql2TM5fGI+bOgMbHSjvMme5Sgjr1Tl76O3Dr7wEDaaX7JuVgiiS9OeS7m0rfaR1Fk76w7jd3R18q6G/EfUMj/6u4FwETxp7omQTCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLDqfLs4liAvE1Qffke3P1Y16wc1Pn9hhcDPZEU0Nac=;
 b=fmPSZZrGj3nSGs5VTjt4mvvljGQRq3ICgB7GHAUNkTA+nPy9W76lFQAEtI9HbaDzVxzG8Ik6IwWwYLh9YsOlfMCnvaJB2h68B28hDVFgXb13wfAwsZ157pk922gkkquqY/KzzsRKoQztL3A13DYyf7DpJtJimYAvDXzQ3/xNXjLSvh4A2/5nNqncghaDKejzN9ZA+aU2/OXiYqoBepODsjhYzpv3pe9slsMdk+D/xLgo4dtLcvXP7KlTJ53Ix/9OwtI9QdNjvCkmeb4CQXfDZXjtwO2appElwKnoXh979FFNFqqHq3qI+LA8mpi772L80TrvrCG7xc7kANOsTPL38w==
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17)
 by BN7PPFCEE68E7BF.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6e2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 30 Jun
 2026 09:43:39 +0000
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b]) by SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b%3]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 09:43:38 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "berrange@redhat.com" <berrange@redhat.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>
Subject: RE: [PATCH 2/2] hw/arm/smmuv3: Sanitize
 SMMU_S_STRTAB_BASE_CFG.LOG2SIZE
Thread-Topic: [PATCH 2/2] hw/arm/smmuv3: Sanitize
 SMMU_S_STRTAB_BASE_CFG.LOG2SIZE
Thread-Index: AQHdCGrK6U5bdcSOvkGYsaPpSq7zBLZW08xw
Date: Tue, 30 Jun 2026 09:43:38 +0000
Message-ID: <SJ0PR12MB8614797527766BD0AFDE5717ABF72@SJ0PR12MB8614.namprd12.prod.outlook.com>
References: <20260630083042.2692392-1-eric.auger@redhat.com>
 <20260630083042.2692392-3-eric.auger@redhat.com>
In-Reply-To: <20260630083042.2692392-3-eric.auger@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8614:EE_|BN7PPFCEE68E7BF:EE_
x-ms-office365-filtering-correlation-id: 5b325415-0315-40e3-724e-08ded68c1034
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|38070700021|22082099003|18002099003|11063799006|56012099006|4143699003;
x-microsoft-antispam-message-info: QAr+WJvLnC/dx0Y/FS+KShouB4YbbexOcckJB0bh+B0Oa1te+qDAFYCuuFVzAPryGwXC241IDRGNDfhbGgwDo80sk2DhIMuVuWLRXMCwTqb+wHc2Jl0UgNfLPCUsmg6MGdgx7K1CzAfuBiyLDlk+pWyZn3BPgpw68TITV6xZyNITCeupXfl03esxzoPdXd7bPh6UpP7ypShZLHZncdTdukcvCqukB8B6Pj0qoNt7sPMJs0OeO1xKhOjxRSsg7dCxq3gInby0xOBFsNxGF5oA8kPczmYBq3IGJqfYiZy7xz/1j8UFalKbWZSOobciurn2PeprUNvt7jNat68jdJ3Sxriw5pjUxWo7aXfMGG7zDDkGqJogMtVr/SbWxAa7KzKck4C6DmQTbO4ojpK7RgxkB1Y/ATCJGLhE5WO8IjNvLpkTE/UsiHDuj6tCee21iX5mUycye90PVAvSzp0qwEeYENM1k8zJixsNExnVIhH4gWY2S5Y6JTzp2vTcsadYnWddnW671a2tgz5tgCbvnktIA92NI6D0Jzaa3Avyh+MP0YxpA0HjFP0UEFKXETeBkPDMu2w01tCYmxP3qNMYgFN/2ggcUc9s3OjsvKh9vvfgRAO8hTGptaDlvGnKgZQLrjkBinS4mMPZsLZ8CMd5zxTQahCicztXHiqm1eh+3TuHfV5iU9Uf6Ik99rLqbQ8ih5Kn595WPqimTzXqx/zxh8gfdRpMM0ccfYSm1KvwksIHEeY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB8614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(38070700021)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XO2JhFTEVY4wLDCg5o3Z1qWw8g1H/6ow2uiyqU8HK3NXEwGiRPWnND8N2Djw?=
 =?us-ascii?Q?jYnSf8HO2QXmaku3LCgD07voN8g/qb2YjrURQ3RoVTjPD1JfkNTc5OUhL2NQ?=
 =?us-ascii?Q?+srF45Y7j/dVXY59AKrblQvs2A2bLzEl5uAP/zEkWGuszAeN7SOlkkz3VrJh?=
 =?us-ascii?Q?03o/W7IfCmU6iOtb3RSYCQDPa7bW78QrXfIxIB6dZL9b+vgSfvYNkvWUr7fT?=
 =?us-ascii?Q?QYLJpmVmV8MJnjK1rZCt7MC5BieNhjGWRMH1hGLc8AM8CPWzYbcKZzDyUMD0?=
 =?us-ascii?Q?67m8OJJoYS3sQZ0fDz9twwfK54APpxTVqNohMJKwuCc2mx9iyfZwi43EKuo7?=
 =?us-ascii?Q?atOXepnX8pgFDnaNxRiDKgyZcx/3iCrguZTvjAO7sIo3QcRd69d1GzsaYVlV?=
 =?us-ascii?Q?KXYrXaSMWB2havqZq4Nd0V4XniNVddU+4Uxo/meche6Mf4GoXY6bwDrQpIIS?=
 =?us-ascii?Q?YoT/H2K2A/MIhAzHK9Pzi7mIrsVHaE/lk+K8SEFhambG5zNhyxdZHCd7rpWE?=
 =?us-ascii?Q?Xq8hujWd1wJmCm3pGiYCvNq4JNqOdH07YEkugrDaTUdaogdO0ODX8HZvFMZ1?=
 =?us-ascii?Q?RkYIC0squrNulSWRKO1wz1UlXIT+BPcvXSeAYi0ThQLYhuqevLicREwEiT5O?=
 =?us-ascii?Q?8vtPS84A0BfGIGBSjHxtRAGnTcnYrF7IRB/ydDakw8ldlJ7qDRBYfa9WLtOd?=
 =?us-ascii?Q?eb/u4njJ2mjtuAeSoNNHdV1mwqCo6dkdBsG/GmAr1044MQIo6L1TjVkKgf82?=
 =?us-ascii?Q?7urMklyDmAyXW/drvnhylYQh9OFN5N33obzt24GyGeUQA7mFnAcm6mK7Q9X5?=
 =?us-ascii?Q?YRX/f4iUtFrwNo4ikfZVbtMXXIMwO1qtFPguM8Tp0+WV31juuTJSjbN2jgIp?=
 =?us-ascii?Q?e2Ido4NY3EczBFljbmZ1h1y1pWdS3rOIbDpzcZUXEjEx1dQAm+1yLoIPQQ61?=
 =?us-ascii?Q?fHvGLzZWNibz6eb9CmNzkX0+I9EJbD0JxhHJlnUa+tyCkmnrgA9tyxujnQBh?=
 =?us-ascii?Q?8PZJxEkwGATWIeFlaPTdEerYIa9WV52kjHHfEG5Pi9IpYldids7vYjX4BL+c?=
 =?us-ascii?Q?uvKeOLdzbwmzsJVOjNnn0T8I061LZ/QfV+I4PtlbthjWiNWYUC3hNNv5OB9z?=
 =?us-ascii?Q?2SeHD1YzwkgwbbzEc+PYIOpSNFjGwJwlgbbVAwwKiCGnpldLsPSYrQz+dnRC?=
 =?us-ascii?Q?rpCP5HyDV50r5+so4RfBAVJblFTX8PyWKNmQi/V5M0kRNDEQCn4OiDCteEct?=
 =?us-ascii?Q?8v5jCTtRsES22QbWNquLCeSpF++o+nSzptcOWEWPr4wd+pQaXSbmTLdRH94B?=
 =?us-ascii?Q?OdwYBQyZfhKHU8rcGxuMgKxhfWADE3+6OcEAnktDs/F58yt8v3A7KnooWJFK?=
 =?us-ascii?Q?COc7bY7Dsxsk8dc2xpJAey+HPnDuZElKlttZXQ4ZquS72w1yjPb7CqszjDex?=
 =?us-ascii?Q?a7ZXUiCCXKQXQwUWvNqrGOCUOI/W1GBs4O8VZ/YCKciuyl33zBKYFsqIGRSM?=
 =?us-ascii?Q?kUAExWf33ailoyaLefaW35Oc19Ywez3RxxPj6ECDYa0NqO92VRhyPE77nPDB?=
 =?us-ascii?Q?A/2Wxt7TjxL+AIheqajfECIR/dmFFlexk09pi3kgKHs+N9Jb5m98fOJwO84L?=
 =?us-ascii?Q?vB91WtkfL5quD2doRZKYA27+XWSIn/d4BwGw1vG6kC6Xp7kvPcIzkr06zlVw?=
 =?us-ascii?Q?ZtbZAAOMGeyyzffOxOKE49rhQPp1tDoT57k4NwadwEfqhe+7oQB/37r6C3Si?=
 =?us-ascii?Q?LoEIvSXigg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b325415-0315-40e3-724e-08ded68c1034
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2026 09:43:38.8226 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fvs9IiEt/oODqSyfZfr7PB6RNnanulDU/mbWgGG0sM55USM9pXiByuuWg6T+V1UeROsOIi2zFttKcBKv1DuSrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFCEE68E7BF
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=skolothumtho@nvidia.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
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
> From: Eric Auger <eric.auger@redhat.com>
> Sent: 30 June 2026 09:30
> To: eric.auger.pro@gmail.com; eric.auger@redhat.com; qemu-
> devel@nongnu.org; qemu-arm@nongnu.org; peter.maydell@linaro.org;
> berrange@redhat.com; Shameer Kolothum Thodi
> <skolothumtho@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>; Nathan
> Chen <nathanc@nvidia.com>
> Subject: [PATCH 2/2] hw/arm/smmuv3: Sanitize
> SMMU_S_STRTAB_BASE_CFG.LOG2SIZE
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> STRTAB_BASE_CFG.LOG2SIZE is programmed by the guest through the
> emulated SMMUv3 MMIO register interface. Currently the value is
> not checked.
>=20
> The SMMU spec says: "Except for readback of a written value, the
> effective LOG2SIZE is <=3D SMMU_IDR1.SIDSIZE for the purposes of
> input StreamID range checking and upper/lower/linear Stream table
> index address calculation."
>=20
> So for STE lookup make sure log2size is capped at SMMU_IDR1.SIDSIZE.
>=20
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  hw/arm/smmuv3.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 0a8d2fbb6a7..db5aca26ec0 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -672,6 +672,15 @@ int smmu_find_ste(SMMUv3State *s, uint32_t sid,
> STE *ste, SMMUEventInfo *event)
>      /*
>       * Check SID range against both guest-configured and implementation =
limits
>       */
> +    if (log2size > SMMU_IDR1_SIDSIZE) {
> +        /*
> +         * spec says: Except for readback of a written value, the effect=
ive
> +         * LOG2SIZE is <=3D SMMU_IDR1.SIDSIZE for the purposes of input
> StreamID
> +         * range checking and upper/lower/linear Stream table index addr=
ess
> +         * calculation.
> +         */
> +        log2size =3D SMMU_IDR1_SIDSIZE;

We are now limiting the log2size here and later in the code we use
this for strtab_size_shift calculation.

However, spec says(6.3.24):

"The alignment of ADDR is affected by the literal value of the respective
SMMU_STRTAB_BASE_CFG.LOG2SIZE field and is not limited by SIDSIZE."

So this will change the behaviour now. Please check.

> +    }
>      if (sid >=3D (1 << MIN(log2size, SMMU_IDR1_SIDSIZE))) {

This MIN check now is redundant here, right?

Thanks,
Shameer

