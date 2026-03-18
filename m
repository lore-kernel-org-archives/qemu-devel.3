Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39CDA10854D7
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 09:32:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2nFj-0007Ah-L5; Wed, 18 Mar 2026 05:31:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1w2nFh-00079p-0c; Wed, 18 Mar 2026 05:31:45 -0400
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1w2nFe-00026K-TZ; Wed, 18 Mar 2026 05:31:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J6U1OWkif574QGtjb5DYglFJ9U2JFtlpjj6jUae+N+ZcLt9waGVAOgrC2eedC3EuD1keIRyJqPHpWW1jWLoLN4M4AXJ9hU1+Rrg3FnOlMLJHQZugzOi8/bv73n7DzK+QVlSPU9tQyXknlOuyrvI3YLApBcm608mmIM6H3imDClWdnv745ALkqPT3Bm8j3rbMzADVhRUBChwqvkqVnxroxoA1kG/ge58vzAmFQYjr3ioVsHL7vp+ZKTGB8orOspFhZ1mSjn0TxMjuHNiFgk8Q00YywRa0geFP8wVojA0YUzzKv591mhi/81qUb/+oS5B7Sma+Fk8Vy3rrAw3nLISXxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nMSFfSnP8Oe5hlW/Bg6cb1rjDCVwHQjyWpFyk2CLBFY=;
 b=TDNmgAWdMLAuaWk4XuSHklHENCqt0lmNXq8gxd3cgi2Styx06gjKrBvGB0fVcU4yOqQ9mi4GVrhW3no8d6b2cch5C+nY5+k6q56J4JuECJgJqkfITyUlG7OnDBf8mIBBsQEINM1rAHt/bS+VA7KKdlNS14tcdT1+bUdy/DKbPnfWQpR8MjOk/mpIbO5KZ8J8cFXRVzve0HJUt4xaneLdIE3WK4kK0sW3ZDs13Ws+9XpfVOpb3GidO7XCyo+VMtQd7mKZE2CIJ9/hXQJhfOnPfQL9sjPziXegcDdbbwTehNPQespIl/173wMqlkJq4d7pCo1joWkjRM2Ks5o71j8LVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMSFfSnP8Oe5hlW/Bg6cb1rjDCVwHQjyWpFyk2CLBFY=;
 b=R9oFECbse3eD8SBiDoWefJFFdY750erPN+0W99vXULca38IiobnEfMqc8cHPLfj6dB6BmUaLXNcjvuUqaIOuQ7kOhpLgBmb680mHE38ckYGNaPNFoZYOAj14sCY67jx23SdOSRb3tr3BCIIrV9arTCHJmUcF/mOPPBn/a4QbcHqtXOQVhraI1I1hzMbZjFq4YVmlptrNBCUhNEBlTSLnVOIysnlCIjefDYenuV90MkHIrpibJpLPhJXvgtIpLwbhcmV+a1f0VF4a4rp8ThegQeSnzSZ+tRpZQx2eaF3/CEJh2gCrm7cXug3TpC8GuqAN0EqWx++f29EylbuUwuz3sw==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CY5PR12MB6084.namprd12.prod.outlook.com (2603:10b6:930:28::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 09:31:33 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9745.007; Wed, 18 Mar 2026
 09:31:32 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Nathan Chen <nathanc@nvidia.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
CC: Eric Auger <eric.auger@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael
 S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Daniel_P_=2E_Berrang=E9?= <berrange@redhat.com>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Matt Ochs
 <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v3 2/8] hw/arm/smmuv3-accel: Change ATS property to
 OnOffAuto
Thread-Topic: [PATCH v3 2/8] hw/arm/smmuv3-accel: Change ATS property to
 OnOffAuto
Thread-Index: AQHctj1A602KWUZyckqcFyhauS7IbrW0BNPA
Date: Wed, 18 Mar 2026 09:31:32 +0000
Message-ID: <CH3PR12MB7548D2B0E4C731983EFC8EFBAB4EA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260317183755.3721625-1-nathanc@nvidia.com>
 <20260317183755.3721625-3-nathanc@nvidia.com>
In-Reply-To: <20260317183755.3721625-3-nathanc@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|CY5PR12MB6084:EE_
x-ms-office365-filtering-correlation-id: bb22bf8d-27bb-4a99-7d90-08de84d12481
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700021|22082099003|56012099003|18002099003|7053199007;
x-microsoft-antispam-message-info: LXYHK6TedWhGE+Y9lgaS5AzFBY/3chAzKe1guOdsDxTtGbZpQrPYOJkKODeYtTKUj8dwea1lvQb3/s4vVD1JOkg772HwemPuNFcDeiKxvV7TIbuwaiKgVjHvIvLGv3vqLOaOgJXHlhWl/s/kUWyvPT/OX6oRx7UJBZBQHRxPhBhTRjxyO9yeh/0yWxOtR9rfzRB14Qwtx15AQZupue+1VzK2Cxk1W/C2C1NBsRYpicX04YMEMp6AZh++rudgc2dOq5ws6tHsXtlhNvjdsxPjpaBnyucORA2FOMEFVtCvjlWxxBRdK7U7XXYJXI832GVqU7RCYhfV/lbo9gClPDvEMsfiw5HO6oAw8+zPBpSajQ8lpk/vFKD5sudL+o7AyCpAI3DjAhWQq0GXJQBd+G2Ac7Gk92rw9wcw9php+iCfEyPH0xPeBZNS6pX8EtvuhxV5prKnbe7rK//Ar6b/fr7wawD9mkm+qV9gCj5m50QJq4LHmNbr5sz7MUbFAvAOe/jYJqUFEVjMpt3HxW13TENEZXFLwg+qYf9TsHPS1rRkgKEMoXOgrPzKLTO4+yzDy4xBSYHJmq7S7jcI7ybLVemRFXo2wJO8SyIBvPU0NRceOIlUKJbkJ+iTud2/T7DKhwXj77nEkoK1VJRshFpALgz/uOUYP7te0nJwhAn0eemHHhfhXPLju0n5vOkdAUSJ/xmB4OgEAqPlngCBcfhph2e+OPYFtHjR8XqP99NeopYVJBIcmpBOFCEMEVqlSyxXqbh2THkZuRn9Gc2zEWh+j6p6WNJT5W/0KCtYgsUoEWXT3O4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?igMPhq/dRYBZRXFmKnWE/aYya7bsM76SQOHkjI/AvclrD79gGIfU0blMHu?=
 =?iso-8859-1?Q?Y/4UuFgKDSn6qNUz0vy2bMmhharuR8VieuC3swr5ARf0pc58sYemPN+4wo?=
 =?iso-8859-1?Q?qsooEzXcmCQSzZ2A0GoboTMu0iaVBfOHczQyKUzqHeAR8gzKJOzJT2jvxF?=
 =?iso-8859-1?Q?bHvBj4Fa2p+/NVtl4+ns0gi55Obb8bTV6AZ8PUtSrIRvAcjYe+MIwh8xsA?=
 =?iso-8859-1?Q?UOp5WEe/AEqX+UlQVE3bkF4fYkO+zDZXZH7FTBRYEctsZpDsCYw6lQiQLc?=
 =?iso-8859-1?Q?ZUSst06+eX6PAo5uZBf+4bABtkWFoMoCxOaKj+dI82au//bD3jaXgdAEjc?=
 =?iso-8859-1?Q?46NtmgxRAs3Pr7+wzmBG3JmazC0yanyD9ddwckKjIoNXfas7WLTaVH0ts2?=
 =?iso-8859-1?Q?GnouYjog3TTO0s+1XDkfgXRva4mkTH3oWIK1oYTBfsk0euyfp+bYwFBqM3?=
 =?iso-8859-1?Q?bJL+rsf2UJLBa3uZOc6Yh0dFYkS4LczARAaHHsfYAN28ejwNbxhDIHuLqa?=
 =?iso-8859-1?Q?2ieiX1sFuukKTpdxSuuNOxyKO6bl3KBbzugpw49TTmXMiGe2RL26j/l6Dt?=
 =?iso-8859-1?Q?g5JIh/T9Tj4kI+LVni+5EXXx6NLK+BtOt4s/qisQV6VCQl+Tam4nVwcQqa?=
 =?iso-8859-1?Q?eg2K8imZAkaE354gKg4PurztL5bLQTQ7mQqRTZEknMWpZVDcAw9V0ehG4a?=
 =?iso-8859-1?Q?9fIYNyGGE/0xrYGsmPHqu8XvjEfgJHv0czeH/FKspUuECS+rgUacwoILGJ?=
 =?iso-8859-1?Q?aW0uwemZKOwLItA9QSty1JixONbkEht3dVm/jrLoUO5ZyzhCYC8KQffih0?=
 =?iso-8859-1?Q?RF39xL33DxlyUFXdRk7SSY9I64bJwTgNdgYmpsd+RLoHBYFwez+HaZTfaJ?=
 =?iso-8859-1?Q?Cf0feSqMm3TTD+/0ha95ChZjnEXBCbkiEpGQqFmE122Jy7I4DyEhSojkOG?=
 =?iso-8859-1?Q?szVVVQQoGrsJUmY1lK8HmyOlDSylGbR2OVFozgOYM4XW+espkZzasizvKp?=
 =?iso-8859-1?Q?d9RPinoSFexvAepWo82ISPnXbG2NK4TsZf7l9nTnYMUrzwA6R4o9AlJfXU?=
 =?iso-8859-1?Q?lG7BvYXpqjQ3EF7NM56doNFoleSyIQP7JtXoEu0Fba696nM9sqgAr3mmA+?=
 =?iso-8859-1?Q?QQqZCMu+ixAFQ5tVTVsOoPWgh9HR8zh/8ePcXbu3umQKH5QEsVc2gD+dyt?=
 =?iso-8859-1?Q?wC1E8eLeqS5gDtXtwsGoNs0UztPQJlc/iZmoAk4r9jpU8qWsEH/JoLpmK8?=
 =?iso-8859-1?Q?c2U62Vne9epDO2ayAU6Lw2LRfjItGhuBXqavYKrPWAGbdnOyBcesdGCoQa?=
 =?iso-8859-1?Q?N0q0M7yaaRKVEV3m4Bc/+abdTdp7amA/umnfagdwTn+07pVRis7VQZ1c8s?=
 =?iso-8859-1?Q?Q718bjHIbKoMS5Eav0yxf9cTBFWFLVXF2o0r1XFgRVvuCljmYQfIY4odOc?=
 =?iso-8859-1?Q?jIgyTqGqxuMv45ri/xNIXmFfeM9T1XNjlas3QzXpCzE8T9TexXOj3oJxTV?=
 =?iso-8859-1?Q?lzN0CUN0z8RSCTMT6RbKtQ9aR6INSnaLCJvL/pCIxElEeOHRYnwOTTNTgh?=
 =?iso-8859-1?Q?LFIJTdXYaSl2Ng8JSClbu5j7OcQp6Sufy1YpoIDqhUyPUH+zPYMSIE9tr0?=
 =?iso-8859-1?Q?QauwYj6sGvAnJpMLf9zI0oCw6j2gGqXO560BD0ivFnm+9Ie92vPStDjY+6?=
 =?iso-8859-1?Q?9XnftNvdqvSThYVw4oTmLawQ8fQwVR1pEGnqebHnr0Mn4ibkymBvKtwhMk?=
 =?iso-8859-1?Q?ksav1cLvglzxJfF4EliVny8qaN0mT30pBH6xev7AcRQOn/7mpJ1zUFL2kQ?=
 =?iso-8859-1?Q?76qNBSMwvw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb22bf8d-27bb-4a99-7d90-08de84d12481
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 09:31:32.8638 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ynEtrsTztwI+6jCZuSm4VkdTi6rF/M76+Ya+68nEVxGimuuY71hZpJokK4soy3ntckLKY+JNFM07e1ZSL4YjdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6084
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
> Sent: 17 March 2026 18:38
> To: qemu-devel@nongnu.org; qemu-arm@nongnu.org
> Cc: Eric Auger <eric.auger@redhat.com>; Peter Maydell
> <peter.maydell@linaro.org>; Shannon Zhao <shannon.zhaosl@gmail.com>;
> Michael S . Tsirkin <mst@redhat.com>; Igor Mammedov
> <imammedo@redhat.com>; Ani Sinha <anisinha@redhat.com>; Paolo Bonzini
> <pbonzini@redhat.com>; Daniel P . Berrang=E9 <berrange@redhat.com>; Eric
> Blake <eblake@redhat.com>; Markus Armbruster <armbru@redhat.com>;
> Shameer Kolothum Thodi <skolothumtho@nvidia.com>; Matt Ochs
> <mochs@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>; Nathan Chen
> <nathanc@nvidia.com>
> Subject: [PATCH v3 2/8] hw/arm/smmuv3-accel: Change ATS property to
> OnOffAuto
>=20
> From: Nathan Chen <nathanc@nvidia.com>
>=20
> Change accel SMMUv3 ATS property from bool to OnOffAuto. The 'auto'
> value is not implemented, as this commit is meant to set the property
> to the correct type and avoid breaking JSON/QMP when the auto mode is
> introduced. A future patch will implement resolution of the 'auto'
> value to match the host SMMUv3 ATS support.
>=20
> Fixes: f7f5013a55a3 ("hw/arm/smmuv3-accel: Add support for ATS")
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.c    |  6 ++++--
>  hw/arm/smmuv3.c          | 14 ++++++++++++--
>  hw/arm/virt-acpi-build.c |  2 +-
>  include/hw/arm/smmuv3.h  |  4 +++-
>  4 files changed, 20 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 2bb142c47f..621ac531a5 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -826,8 +826,10 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
>      /* By default QEMU SMMUv3 has RIL. Update IDR3 if user has disabled =
it */
>      s->idr[3] =3D FIELD_DP32(s->idr[3], IDR3, RIL, s->ril);
>=20
> -    /* QEMU SMMUv3 has no ATS. Advertise ATS if opt-in by property */
> -    s->idr[0] =3D FIELD_DP32(s->idr[0], IDR0, ATS, s->ats);
> +    /* Only override ATS if user explicitly set ON */
> +    if (s->ats =3D=3D ON_OFF_AUTO_ON) {
> +        s->idr[0] =3D FIELD_DP32(s->idr[0], IDR0, ATS, 1);
> +    }

Nit: I think we can keep the original comment.

>=20
>      /* Advertise 48-bit OAS in IDR5 when requested (default is 44 bits).=
 */
>      if (s->oas =3D=3D SMMU_OAS_48BIT) {
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 068108e49b..3dead0bcd3 100644
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
> @@ -1993,6 +1998,11 @@ static bool
> smmu_validate_property(SMMUv3State *s, Error **errp)
>          return false;
>      }
>=20
> +    if (s->ats =3D=3D ON_OFF_AUTO_AUTO) {
> +        error_setg(errp, "ats cannot be set to auto");
> +        return false;
> +    }
 Nit: Is "ats auto mode not supported" better?=20

Also, should we do this before the if (!s->accel)  check above?
Otherwise, I think it will carry on for non-accel smmuv3 cases like,

-device arm-smmuv3,primary-bus=3Dpcie.1,accel=3Doff,ats=3Dauto

I think this applies to other properties in this series as well.

>      if (s->oas !=3D SMMU_OAS_44BIT && s->oas !=3D SMMU_OAS_48BIT) {
>          error_setg(errp, "OAS can only be set to 44 or 48 bits");
>          return false;
> @@ -2128,7 +2138,7 @@ static const Property smmuv3_properties[] =3D {
>      DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
>      /* RIL can be turned off for accel cases */
>      DEFINE_PROP_BOOL("ril", SMMUv3State, ril, true),
> -    DEFINE_PROP_BOOL("ats", SMMUv3State, ats, false),
> +    DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats,
> ON_OFF_AUTO_OFF),

I think we should update the description in object_class_property_set_descr=
iption
to mention auto not supported.

Thanks,
Shameer

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


