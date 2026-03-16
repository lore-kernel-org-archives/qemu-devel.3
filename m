Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F057F013E0
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 08:49:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w23cv-0008Ca-08; Mon, 16 Mar 2026 04:48:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1w23ct-0008CI-Pm; Mon, 16 Mar 2026 04:48:39 -0400
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1w23cr-0003b3-RA; Mon, 16 Mar 2026 04:48:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BHC0pebDhgMXJCCfC6QPw+N9shq7+ewuoikiEZxy/pZW4WrmReNaenuyuFHpPMpmjCSx5s43pu8+ob6EFm5dvduZ8+oufGmdCx+EDrq+YMe5btZPENEHpygyVi7N9IYQZa2eWNMN1TmKwVxoLA2sJXQaJXxxTsV3UmSXR73gVcPXM0Zk0WlG5HZGf2BofVLeYTYRiDk8kXrW6bqBbWHfM2LG4wM4l5ZtD4R9U28ER3Xm5ZT0gbEI41qg48h8hyHONx+JdIT/iGtZNegNAGo69EUgjtPtLyAzA8fXazK8UxP/td1yzmgjK3DJ9FlXWrbUcWpV/j9ASA6yJMZE1KsyZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xFZlk9Mw3hgLsPv0G8Y518U47nwkSPvAgFg4gVjApZM=;
 b=u7q7FQx49gXRKNt6UVWzaF3zFbhXcXn+5j1t3APeogtUBToIGHj4MhU9ZDL/HUgh7ucDGpfL2drzyuGFDpCjqaOn4bh0OmXCpp19MNgBsnJRee88o9ROLLc76bymHSv1YKnXAYhVU2Rw4aV+hkA3Nd0xpWwm4Edp8z83W+G7aOEHnRcFwCloB7qcXD8U9QYNBHdtvpVF3Go9+AZtw84Nm3fGjKc6Dc+AmnS2txAXexsxIrTN5dHroiQKuG/0Fmk8WmQ3YT3nRdRedduoZ17Vd8ZrI+BEbUuu8Jubx1D083vWWck7yvBpvcA8zoSZaoMJpUkC3sijFfZ0p7uUNt9YgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFZlk9Mw3hgLsPv0G8Y518U47nwkSPvAgFg4gVjApZM=;
 b=CnlleG+7cIS1yOEDtp+KO6qLnDbnD2xtO5TGR2xhNMS4bq/PlYMQsHiiSddfz7vJxGUdsbDPzHyBl0vX9FBl+LP3gn4/tVgeSr45TLWHezKRZh/U698l/A5YjD4iRd/A8Q4Yk61A0BwJpeR2YIGnQyxczL678FOhsnGloahgnVJJ8ltsOQw4hu4CYYEQHqf5HzqVJlrLdoMsZUww5uWzjjU97nUA7zPyiKkfGcnCXe7nU5y95kL+MJr77EBsnwglXL8ScfvtKxV4YfQSvwRCfmleWXqDR+fuInv8WHeD+eFwLVca0a34UjZh6Ht0E7MfJcInmnIFaYQvpRCDIn6YLg==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CY8PR12MB7194.namprd12.prod.outlook.com (2603:10b6:930:5a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.8; Mon, 16 Mar
 2026 08:48:30 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9723.014; Mon, 16 Mar 2026
 08:48:30 +0000
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
Subject: RE: [PATCH v2 2/8] hw/arm/smmuv3-accel: Change ATS property to
 OnOffAuto
Thread-Topic: [PATCH v2 2/8] hw/arm/smmuv3-accel: Change ATS property to
 OnOffAuto
Thread-Index: AQHcsmO6V5wwudIhR0OFqad/AonHmLWw3NbQ
Date: Mon, 16 Mar 2026 08:48:30 +0000
Message-ID: <CH3PR12MB7548E1905A6500D2D685B55BAB40A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260312210328.2016191-1-nathanc@nvidia.com>
 <20260312210328.2016191-3-nathanc@nvidia.com>
In-Reply-To: <20260312210328.2016191-3-nathanc@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|CY8PR12MB7194:EE_
x-ms-office365-filtering-correlation-id: 6dcaee90-9e60-433b-9c06-08de8338cc4d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7416014|38070700021|18002099003|22082099003|56012099003|7053199007;
x-microsoft-antispam-message-info: 5uIBhkWVDgyeIgq9TRKyTExZeGhiib5tNzENxyD7r6NAGmcn6qWO4TYNevM090T0Sc6+m81KkECPxh9wwuTBGm/2C3T6D/kkMV/DZTjEuqTLy2mdvQ5dVs4nqz7DdVDG1KTyNCWF1Q5h9cfVVD+RaD06lcuonPsYDmvX7p1VzV1QLL6no8CtONkrPxYX+ZGxff9BRiFdjC7bpcaDehuBpO4VfBF32b9ug4DywCAy7vAH2M87JQG1pTSM2JTcFbc9DVUAMDW1d4UTAHTL/o6G3BuOybWHY6nMqkWQw4/x9nsVoT53KNRDhe9l8u3pMIByETJj+wXAtRTCDJ5aOYWEedZyLQySThoNQAri6JqDqTymkWU3DJDTZY02SfDSIZTG3ztBhPzcZJpbshAwx1CllwoYCTEsXLX2XpcjecpDJGJjMk69mDYu+oc0pxgb6NUEA3eUf++1CEULsPbBbFjtGXBy5WAdRoVLFaTAXz6uNaVBaOGZNLXEDHdf6JPclE0+2cZ6IQbhW3LYntUZERX4lk/0ozA+PhxraTjebvhTROp+YpT+c2MdC20oSl51yBuFqdAieA3cBMcloBbo93aTp05rHFea8DwRMYL8eXE2SK8GysQN9jRURmcL1NQiGm8/+fNZlaVh2MLSg9Hkqb+wDLhhMZ0MhkgGnNgN5ivcNyrV5kxaXaebnr4dD/1f4UoQkzbaV8osEdHGIPepkiFyYLbmezRYrfqqWpU3PCkCEHEUMXFxqnEIMfY/TFPD3NyO3F/9JZ4lnbhxUEaW564r0GQboqAsCrimqY6VSv2NoWo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700021)(18002099003)(22082099003)(56012099003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?vQsHA7f7lMZhxmlRWMm9qImnQng0Fap9bWTNdp6LTi+havl7Q6LI2JbCBt?=
 =?iso-8859-1?Q?ojTd9Qpn6B1Q+mxNhOs+fShhkZVKjxj483v4v7ADus25KzWAukN/ro3cP+?=
 =?iso-8859-1?Q?641EqNSyLAEyuekp8v34oPfBIiQdjctZmF9FsyQpO9eyh+rEe4V57Lu3UA?=
 =?iso-8859-1?Q?D4L8yXsM4cnf3CMNOHSyfIs0P1e+LW+FstNL09lBOMobvuGRHeZ8luwIaX?=
 =?iso-8859-1?Q?95vP6vq4tKivuQTiIQPmLmeBCjKvwtg6wLDcy6cTjFtmELSnOApEaTb8TC?=
 =?iso-8859-1?Q?+9jdnxcmARhoZiZu9vRljLk11jYiDdr6HU0vjhORsPgk5po2gVh2GrVQd+?=
 =?iso-8859-1?Q?k5j5lGmtX5tc11Z/5ziKFlzcG9QggWkYNwPcFQllkSty7jGMabarCg3Hsg?=
 =?iso-8859-1?Q?rhypnCokiEmmb3u9dQav9ymabrVxx8s9N2j2njzsG2A7bGgp9FIAlWHA01?=
 =?iso-8859-1?Q?luo4mRPizzFgaK/sPTRBdC4a3MTKbbSyYgYGctyvvjv/ts7MOf9sfTgQPZ?=
 =?iso-8859-1?Q?OWe6C3vC3Jr/lw34Aanc4xdNoHvK3xq6dwd/7lCLDAxLie4yytsSXcFZmI?=
 =?iso-8859-1?Q?jWtPp7/QhFDjVxEVymdxyNLtHSi+I3XmtxNRmepoPpKDJl4TL63T5wB7eE?=
 =?iso-8859-1?Q?3rp3axfG3ccOTB7eX0zykaZgjeoegbzp/2IDJ9LUJEXL2OIKZMlz1HMDnb?=
 =?iso-8859-1?Q?ahgay5LBNuf6tVj8Dan9HWrH+R5HAHHRD/r1mcFBtvWqnX07Ex8dlVeOYs?=
 =?iso-8859-1?Q?LafYALDn4USUOEILOxaiGyj2tRt8bxTIXJ7hhs6hSWoeUT5j7uO+xm7kOd?=
 =?iso-8859-1?Q?FZzeiPw5Q4XCzPVRgpGYS+1S840jOfOPTt1pVWuJEyfKD+CB0COOg6cX6A?=
 =?iso-8859-1?Q?FsG6dD+wej2z/wxinXYUJLg9CMIWy06G+3LnR6bWUoaDkHiW282tbzEzkS?=
 =?iso-8859-1?Q?8VZOtiFZMUPOzkwTIqW6NcdAd1jm+OXqWDCT3qOlPU0IUxcpCJjshfOoqS?=
 =?iso-8859-1?Q?m1dubvFNlRsgBSRYsIqadpI/dW3X/ve4osu+ewl6h8HCPqdYmPkalHIVWl?=
 =?iso-8859-1?Q?janigjY1S4ceTM6YVOsBEW1sv/parCy2C/XFF4UWIAOMtaK3xdQoPGidCE?=
 =?iso-8859-1?Q?82+khQ2sU5so7chEXF8V86Vfyb3TbsDM/hYiURZViwwNFu3C3s/9UHO2vI?=
 =?iso-8859-1?Q?dKqcbYqp8+ZG+4WLmdgWQPf7LO5XsgAmL/w6f+YcJG5aRoffeglzuSXpBb?=
 =?iso-8859-1?Q?hMSQRE1MKFbAgZMNj2nOm1s+qQy9UPc+Z3VeHZQdMpqKqonEO3TCnK1Tgi?=
 =?iso-8859-1?Q?53AutgwVHSROxg9PiOp52W7pF++m+SLMH8L//Acu5Sa5ZfYzrK7x1uqm5b?=
 =?iso-8859-1?Q?zXODUbnAjInlo7h05xVQipgjwCZ1FOd0Z7Mur+7f59IFvK9oMqcXq97yQD?=
 =?iso-8859-1?Q?/mw44cJKNQPxpwgFkgt5zbcV8TbbVk709Ow3YIJF+39p4T8ow5ypsQVG4E?=
 =?iso-8859-1?Q?8yvuJ6hgSuAFq9Um6XkV/3sEExJrZOfkKBDLP0sJZ11wSHfu/NMTraPfDe?=
 =?iso-8859-1?Q?9tzmQf4FtHgArAEozlq7E6RRFZTWCSGJVOf8bINkglNLzJmeK/Z6WqwtEB?=
 =?iso-8859-1?Q?40uX7pp/3RkOhyWp3GZyTn6hOpawGJ9DuNwcPKIFEF/tzWW3ucJrRI3C3O?=
 =?iso-8859-1?Q?x89dSmdny6fForj7RELpc1T3I1hBSAP+yH/j6dNmWY7iH4qT+Fa1U4A+6+?=
 =?iso-8859-1?Q?F3gdRW/d8te0Vp3rRlcTaWTZLgjGGDTpem/N8r9KlEBQH9e1NvTuMoNXSw?=
 =?iso-8859-1?Q?hLiEEl6qKw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dcaee90-9e60-433b-9c06-08de8338cc4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 08:48:30.2199 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xuMMJ2YUi8mCy1IYHhinyWmoMU0YXktWZttpshWVmV1HNiKd7aVinxwwJBNqhG6gYvH+6wqmCbg3aWcidXVoIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7194
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
> Subject: [PATCH v2 2/8] hw/arm/smmuv3-accel: Change ATS property to
> OnOffAuto
>=20
> From: Nathan Chen <nathanc@nvidia.com>
>=20
> Change accel SMMUv3 ATS property from bool to OnOffAuto. Setting 'auto'
> will result in the default value being used, i.e. 0 in IDR0 which
> translates to 'off'. A future patch will implement resolution of 'auto'
> value to match the host SMMUv3 ATS support.
>=20
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.c    | 8 ++++++--
>  hw/arm/smmuv3.c          | 9 +++++++--
>  hw/arm/virt-acpi-build.c | 2 +-
>  include/hw/arm/smmuv3.h  | 4 +++-
>  4 files changed, 17 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index fe78ce69a5..5d14abe307 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -827,8 +827,12 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
>      /* By default QEMU SMMUv3 has RIL. Update IDR3 if user has disabled =
it */
>      s->idr[3] =3D FIELD_DP32(s->idr[3], IDR3, RIL, s->ril);
>=20
> -    /* QEMU SMMUv3 has no ATS. Advertise ATS if opt-in by property */
> -    s->idr[0] =3D FIELD_DP32(s->idr[0], IDR0, ATS, s->ats);
> +    /* Only override ATS if user explicitly set ON or OFF */
> +    if (s->ats =3D=3D ON_OFF_AUTO_ON) {
> +        s->idr[0] =3D FIELD_DP32(s->idr[0], IDR0, ATS, 1);
> +    } else if (s->ats =3D=3D ON_OFF_AUTO_OFF) {
> +        s->idr[0] =3D FIELD_DP32(s->idr[0], IDR0, ATS, 0);
> +    }

The else condition is not required as ATS will be set to 0 by default.

Thanks,
Shameer

>=20
>      /* Advertise 48-bit OAS in IDR5 when requested (default is 44 bits).=
 */
>      if (s->oas =3D=3D SMMU_OAS_48BIT) {
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 068108e49b..862ca945d5 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -317,6 +317,11 @@ static void smmuv3_init_id_regs(SMMUv3State *s)
>      smmuv3_accel_idr_override(s);
>  }
>=20
> +bool smmuv3_ats_enabled(SMMUv3State *s)
> +{
> +    return FIELD_EX32(s->idr[0], IDR0, ATS);
> +}
> +
>  static void smmuv3_reset(SMMUv3State *s)
>  {
>      s->cmdq.base =3D deposit64(s->cmdq.base, 0, 5, SMMU_CMDQS);
> @@ -1971,7 +1976,7 @@ static bool
> smmu_validate_property(SMMUv3State *s, Error **errp)
>              error_setg(errp, "ril can only be disabled if accel=3Don");
>              return false;
>          }
> -        if (s->ats) {
> +        if (s->ats =3D=3D ON_OFF_AUTO_ON) {
>              error_setg(errp, "ats can only be enabled if accel=3Don");
>              return false;
>          }
> @@ -2128,7 +2133,7 @@ static const Property smmuv3_properties[] =3D {
>      DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
>      /* RIL can be turned off for accel cases */
>      DEFINE_PROP_BOOL("ril", SMMUv3State, ril, true),
> -    DEFINE_PROP_BOOL("ats", SMMUv3State, ats, false),
> +    DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats,
> ON_OFF_AUTO_OFF),
>      DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
>      DEFINE_PROP_UINT8("ssidsize", SMMUv3State, ssidsize, 0),
>  };
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 719d2f994e..591cfc993c 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -402,7 +402,7 @@ static int iort_smmuv3_devices(Object *obj, void
> *opaque)
>=20
>      bus =3D PCI_BUS(object_property_get_link(obj, "primary-bus",
> &error_abort));
>      sdev.accel =3D object_property_get_bool(obj, "accel", &error_abort);
> -    sdev.ats =3D object_property_get_bool(obj, "ats", &error_abort);
> +    sdev.ats =3D smmuv3_ats_enabled(ARM_SMMUV3(obj));
>      pbus =3D PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
>      sbdev =3D SYS_BUS_DEVICE(obj);
>      sdev.base =3D platform_bus_get_mmio_addr(pbus, sbdev, 0);
> diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
> index 26b2fc42fd..ce51a5b9b4 100644
> --- a/include/hw/arm/smmuv3.h
> +++ b/include/hw/arm/smmuv3.h
> @@ -70,7 +70,7 @@ struct SMMUv3State {
>      uint64_t msi_gpa;
>      Error *migration_blocker;
>      bool ril;
> -    bool ats;
> +    OnOffAuto ats;
>      uint8_t oas;
>      uint8_t ssidsize;
>  };
> @@ -91,6 +91,8 @@ struct SMMUv3Class {
>      ResettablePhases parent_phases;
>  };
>=20
> +bool smmuv3_ats_enabled(struct SMMUv3State *s);
> +
>  #define TYPE_ARM_SMMUV3   "arm-smmuv3"
>  OBJECT_DECLARE_TYPE(SMMUv3State, SMMUv3Class, ARM_SMMUV3)
>=20
> --
> 2.43.0


