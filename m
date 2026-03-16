Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B9ACF013E0
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 08:50:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w23ef-0000gq-Hh; Mon, 16 Mar 2026 04:50:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1w23eS-0000bd-6L; Mon, 16 Mar 2026 04:50:18 -0400
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1w23eL-0003qp-39; Mon, 16 Mar 2026 04:50:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=duC1yZGDGHaWCRhbqy7WnE8Hxww8u1WgqUAXCez0c1RwUTqOL1vdc378oz2mvgu8toApMGOryJFv5pXUrhJZGGA18OJUJzHWFL1gsJKb+n7uqmDBLoCSv4u4O2mrgzqrpnzQxKaYw9gWLEpcQulb1E6GsrTETs8NnUoKPj0DvTS3GVVLkiQeHQMLZGbMvp/dsyaCHmEcZACFE3btMrbT7L8GAYRGBalmRh7GS9fbdYiv1Yst+45T/9mUmvoRvXLmSDElkU9AtoupUuLmVIly9zckpJlAofHC1EEQ+2VoXHlKDTTHw5hyM5l9cQ7d/GwwrDFRBbiUWu+XBIHDxH9rwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ee6WRabl9AijZUAjaUXb7oEuSZ7ktNIczNoda5ODWOI=;
 b=LYv26v9rKAFwdxoNncj305G7F1t1FCflJZFSvjOBFlZRZvZ1yMuBVwc7bUOUbdnwtq0aiYUAHD7OzAaa+4zcC+XBP7Mln4RpFt7fmOeLwpYADkg3Z09YG7wwxBoYa8On4SyJdvJc390f7Lk36flc9mGMBlM01HH4F2rfpwrB+2Zqk8bL+p3ZYQkHu8VpkxHioNV7xWytIc/+2Z/AJNEFAQtmDulhFsXpbHdAzdKSyIZ53+hqmxPUcb0cmVDXAl1glwzexvI8rOb5P2AsiyrSAFRqw6JTnx0vPu2YZzXCBpDX1y07HYqo5qhJY0f4e/x8AUv/mMp4ch3NpUU0uPE6/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ee6WRabl9AijZUAjaUXb7oEuSZ7ktNIczNoda5ODWOI=;
 b=SzrqYGZYtHA8+2YGjSPPl5ezFDYXqan8EEwOvJ3K3bx4HJdTV2qaRTOq40NQHLSf72+Yolwa4Nm8GVFGS9nC4ZfsoG6inWhg4dDDfmD/sFVfvObyP82MUJY6eF1x37ATZIzWe3EurXKK6iCKD43y9Rzje4PZph3aOBeI8nnKzZT5NrnWlmVt6Fsrlt3GpPIY9h7n6b2oGdoyyoSc6/yiGWhfixT8pjmo+xBAQGlHFes9wixktgQu9A6ovuczhMa3alHMc7NC8sX3hlenR5/2Md8t2tfJEa62tA4DF4wUguhQ4t1qDEDG0uvpyab3GGFfSBIBm6eLQuiViumA2nlNow==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CY5PR12MB6034.namprd12.prod.outlook.com (2603:10b6:930:2e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 08:50:03 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9723.014; Mon, 16 Mar 2026
 08:50:03 +0000
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
Subject: RE: [PATCH v2 3/8] hw/arm/smmuv3-accel: Change RIL property to
 OnOffAuto
Thread-Topic: [PATCH v2 3/8] hw/arm/smmuv3-accel: Change RIL property to
 OnOffAuto
Thread-Index: AQHcsmO7RsYkCUkkH0qbGjXu3NLDXrWw3r2A
Date: Mon, 16 Mar 2026 08:50:02 +0000
Message-ID: <CH3PR12MB75481996C9F7D1580E169A80AB40A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260312210328.2016191-1-nathanc@nvidia.com>
 <20260312210328.2016191-4-nathanc@nvidia.com>
In-Reply-To: <20260312210328.2016191-4-nathanc@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|CY5PR12MB6034:EE_
x-ms-office365-filtering-correlation-id: aad212ee-686f-4330-8afd-08de83390397
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700021|22082099003|56012099003|18002099003|7053199007;
x-microsoft-antispam-message-info: Q8Zymlo1rlYmkl/il1HGptZl0mzrYY8O389l6Ogpfsaomg2qzkzyvKLhEXbCQY/AwA61WXvCEftZSs9fjX6sBdUyNZ108aOA1XKVxdYSai5syGbxkuqpWzc8QWy3h4KsJw8WIcnKjBaff+0bwsWg9wRm0GvfhjTz/B+HjQI4PApQn+AyJjBcbAW7oltpGbt3knz7zs1bX1G5w0VuBTGHoohg2ykzLbE01QUGCpmadOvBsFMPz6QiAFoPw917/jhOyQOaaqMsYIUIfprI/8325xy2SrseWp2n4o0EWdrWofpesQNe/EnAvnjkOuSq0gsjdhogvWo6UJQqNfk1oPB7H2tPfgkASvefhYBAg6i2eWzHD8VnT3OsEPrT+vjaLXz+ivg3/Vqm4WFacFwjloMdXlZnNYFRjzYKtgigYd7BJM7bYSv6jHZq6sfForFEGqIj8ce5gdMljZV4KYUt51MpNyqXwDK9UqKJ3TgZZHHh82WDLVuO25TwiHiEpS+BdRbcyTzvD9QWP7/YiUPWtBgGK45eJzEjvwbj4PSenR1XiT8rU3zDl1vl0l+onIsTl1hb/7lKrbx0qqUPNvpTL91OarBMmAHWagWrZVts1zwk6qFsDazozXsoS7ZGpuw41Mqm2vivF3gs/FGP6w9h9WMA4QS79XIyfiScz5fFvdGAdsXDNFHSSXEWyKE/2Qq1HXIDVmWSk6+gu17suyKK7AcRolUbMeZ1PJNWD04eEBQtkCvF5lI20xg8TOMn0yIi+dtEesyEGTotwxb2JNS3zYgQgwZ/ku7d9F9mb9wRo9uevnE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BPyCAmNcHiAWrnXW2C3Y/W5QnPyMEWT77O+6s8PZ+dCZXJ/9pywgz61fTU?=
 =?iso-8859-1?Q?bvd4bZZW8/zzJHKGXjZlXmURFasKhhx/iFMcEQjaiDuhI4sIdBEDW/7UZY?=
 =?iso-8859-1?Q?bM8dNf6QjnjIn+oF2CaN9J/Cw0GG2YaXHCNKp4ZWoUnaewVnhqKNBPdQez?=
 =?iso-8859-1?Q?IkgO4gCwPBZpEgvYfjihkVRrEAOnp+Xg9gRjCcPFI26pQaXdSkLiyWYY9m?=
 =?iso-8859-1?Q?MhzCtWZWiXnfrJl8JIjXWesSXADRLywLJ5Tkf97SeEISpy4ri5f/F1c2S8?=
 =?iso-8859-1?Q?0KiV8cOECOr9zuEIAyk5PnQv3Axb04Gtx1aHxkUcqglAJDeTIaiMmWCUUF?=
 =?iso-8859-1?Q?V2RRwW9YC20i730XreJQ3BvDMubRUTl+MX3hrQgr2sSxy0Z8qWnOsyIFI0?=
 =?iso-8859-1?Q?krQXgwyvB6siJu5j09q2LQSs446R6BmyyI76+97xOCf78VmlRktqE17yWS?=
 =?iso-8859-1?Q?T4My4k/0Wl8ZtDdI77EBlovXQtP2U/jZdZHfKgtP3QQCAogUc0S5NoQcgU?=
 =?iso-8859-1?Q?F9KrgyA4c3rQvj8mxePQ+mozEIGW8o1hYis8yLNT/Z0F4V/8sZ+2u7EOiE?=
 =?iso-8859-1?Q?XuaZr1VmwcZ2FM6GxmBL04uAROfKUF52APTjr/Eg38XaWvi7WYZntUv49V?=
 =?iso-8859-1?Q?r24RQ1qF3B54NAbjENLssTUEDSNpYXtCvKJDgugYQbVEvjhUBaxukOK6id?=
 =?iso-8859-1?Q?o19WCvGOJ/A2rmcyMR/dkjf/Lrdn8XruK0K+c9XKh6X3SX4Cy8tFZJNPbQ?=
 =?iso-8859-1?Q?uJCiFbHzODt2LQcquMGjoyXmFwUcRlhmAjoASFf1V0wAsfVFVuhVXHGnQD?=
 =?iso-8859-1?Q?6n7U2sy7Hy0qi4FIDqj3tlajxIxZzjgy2y3K7pGc7ik4GJfA+SGmoPcilw?=
 =?iso-8859-1?Q?GCyNU7VZChdnjdTIPTXDx8DXRDhQqmPwxl6mTXvd0IbozgAcyEkZu5i0Ta?=
 =?iso-8859-1?Q?zPu9A7F01tW5Zt9yZpVS7bNLbdjop9TpQNheQl48PAwX6Hao8v7kmZWEiZ?=
 =?iso-8859-1?Q?owS4VHEnstUEx9w+Jh3RNOa+f8GVDEqAUQK1xoaxu8ZLrgzNeT548jSNkC?=
 =?iso-8859-1?Q?lBPBdyCow8QZCYzKkbSZ399SryhwnfH/zeHXPM9+BK/dg0bSKKFNDcS+77?=
 =?iso-8859-1?Q?b4SU54b2r2OKQmaF9NZskhGFjp2pGbFEEdLhN5hJQzB/6c52jh4oQADOfv?=
 =?iso-8859-1?Q?HMJMrNQ2yOAEPk+xOI+SdfhQIspogh0BixJNPgNFLfHPpmR+cElv4aMmYL?=
 =?iso-8859-1?Q?PKd0RYUPjaz8vnSdBLP7QkPx0Atc2bX4m+oj0pBPy3vECSZDMnUnAcpXBI?=
 =?iso-8859-1?Q?ASNJJ/7BPEWcv0i6U2Gs6Q4+KgCOb47RUGtmznuifbaYUwKGAUrHwhu9tV?=
 =?iso-8859-1?Q?hRyNK4VLF+NJfMg4synz6hUN1jqaHwP8LqZgtYOtlX2wqgjsQGrbEwK7pS?=
 =?iso-8859-1?Q?HtXXd7MpVm3IFcxmz8rEvjONWWUB5aIBjGoq7b0HRITVPIl32rc+vDXjWk?=
 =?iso-8859-1?Q?tuqTtkQ821XtQVzXuyo59KIEAS4MnSios5CrbhV7KG1K0VMviTqhi6ymy7?=
 =?iso-8859-1?Q?xRdB8TUPNWZkV7TtlfR40NLMC0lO7spfFKyge3runA//CTdTkkOh9JkUm2?=
 =?iso-8859-1?Q?m/X3IaNlDXQaO/oRGAhbiDnWU6ZvD1e0XTPVaMYChOGVJPUq9KmrMX4vyt?=
 =?iso-8859-1?Q?Gfy05WBS/5w8KupqQDOWE2BiydT3UsBBegE3YGK3tkAdnMKCQxoSnwR0p/?=
 =?iso-8859-1?Q?4IQPq1ZI9ZThdMeHEdgSIkoFDQe/P482ndELYr0QJGvaTvso8Jsrz5u0XV?=
 =?iso-8859-1?Q?9uYvPgVg0w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aad212ee-686f-4330-8afd-08de83390397
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 08:50:02.9581 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GSC7G/4QiJ3a5HE8zzgdRB0L7kwGhro0Mcj6m0u4NVf48+PfUAUz69KU6u4BIN/gD45TSrhxMke2ZO5gNIZnpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6034
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
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
> Subject: [PATCH v2 3/8] hw/arm/smmuv3-accel: Change RIL property to
> OnOffAuto
>=20
> From: Nathan Chen <nathanc@nvidia.com>
>=20
> Change accel SMMUv3 RIL property from bool to OnOffAuto. Setting 'auto'
> will use the default set in smmuv3_init_id_regs(), i.e. 1 in IDR3 which
> translates to 'on'. A future patch will implement resolution of 'auto'
> value to match the host SMMUv3 RIL support.
>=20
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.c   | 8 ++++++--
>  hw/arm/smmuv3.c         | 4 ++--
>  include/hw/arm/smmuv3.h | 2 +-
>  3 files changed, 9 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 5d14abe307..6f44fd3469 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -824,8 +824,12 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
>          return;
>      }
>=20
> -    /* By default QEMU SMMUv3 has RIL. Update IDR3 if user has disabled =
it */
> -    s->idr[3] =3D FIELD_DP32(s->idr[3], IDR3, RIL, s->ril);
> +    /* Only override RIL if user explicitly set ON or OFF */
> +    if (s->ril =3D=3D ON_OFF_AUTO_ON) {
> +        s->idr[3] =3D FIELD_DP32(s->idr[3], IDR3, RIL, 1);
> +    } else if (s->ril =3D=3D ON_OFF_AUTO_OFF) {
> +        s->idr[3] =3D FIELD_DP32(s->idr[3], IDR3, RIL, 0);
> +    }

Same here. We only need override if RIL is explicitly OFF.

Thanks,
Shameer
>=20
>      /* Only override ATS if user explicitly set ON or OFF */
>      if (s->ats =3D=3D ON_OFF_AUTO_ON) {
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 862ca945d5..acbd9d3ffe 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1972,7 +1972,7 @@ static bool
> smmu_validate_property(SMMUv3State *s, Error **errp)
>  #endif
>=20
>      if (!s->accel) {
> -        if (!s->ril) {
> +        if (s->ril =3D=3D ON_OFF_AUTO_OFF) {
>              error_setg(errp, "ril can only be disabled if accel=3Don");
>              return false;
>          }
> @@ -2132,7 +2132,7 @@ static const Property smmuv3_properties[] =3D {
>      /* GPA of MSI doorbell, for SMMUv3 accel use. */
>      DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
>      /* RIL can be turned off for accel cases */
> -    DEFINE_PROP_BOOL("ril", SMMUv3State, ril, true),
> +    DEFINE_PROP_ON_OFF_AUTO("ril", SMMUv3State, ril,
> ON_OFF_AUTO_ON),
>      DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats,
> ON_OFF_AUTO_OFF),
>      DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
>      DEFINE_PROP_UINT8("ssidsize", SMMUv3State, ssidsize, 0),
> diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
> index ce51a5b9b4..c35e599bbc 100644
> --- a/include/hw/arm/smmuv3.h
> +++ b/include/hw/arm/smmuv3.h
> @@ -69,7 +69,7 @@ struct SMMUv3State {
>      struct SMMUv3AccelState *s_accel;
>      uint64_t msi_gpa;
>      Error *migration_blocker;
> -    bool ril;
> +    OnOffAuto ril;
>      OnOffAuto ats;
>      uint8_t oas;
>      uint8_t ssidsize;
> --
> 2.43.0


