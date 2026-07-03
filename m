Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84944C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 09:09:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfZte-0001fX-3d; Fri, 03 Jul 2026 05:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wfZtc-0001eW-Lu; Fri, 03 Jul 2026 05:09:16 -0400
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wfZta-0008G2-Vx; Fri, 03 Jul 2026 05:09:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kMYL2iQ/2w3CLqQw8faOlM30pV9GNbknzPU3ZFN0JNfEx8xuk5Ha6vIQxbbZNHpNul0CN6nTL1PlU3qwLK7y48BrqY+WhJfDRd8sSFaUgPYPXySyZ7aoQWwuS8Kz+yKYoMhGaMWULj/UsdxTH2CShn3pYmNbQoV0dHCcefdIiBjS8Z6CpOxb5FxjV78YHySMkJNrP8A4gb9Z54H9XLgs5syoICgdi4879M70t0x13YUvaiQI2eYHjRLKSkWA6AxHkm4U+akQwRqHXnOSxEjTDA/nARwDMxnfJEkXrEMFcHKx1zS8y0Ejx4mVtm+l/qMgaByxF5VZ0WOFU3Qmz6naSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5043Nn0xn7/k8ExBA7jxtosdKB/Ybg9v1gg7G2GFpg=;
 b=IoAmRUG76hlZ2NSsSpIL7dIIiqHUcD4uW+jGqXpvReNmpnF95KsEdgOUZm8RRkYNSwy4uTmW6opnUk0G1vcJn9ElxWuSuB0WQTsC3jPjiXQyA2n6gZ5YV703JKRt3TC1ZCaMPCslG5kjggQL674C46KCUFmaUNp6SIX5EbbTh/2bpZqdahx0U71yK4DlGrkLzw2BM/qCG0Ri+j8VXYXmOeTy5VqJvg+SQNs1TojWryUzCn+xqZqAdcg//fObYF1zTieYk7C028Xy5D95cEGlVB0KlzHdZZwho6iJZdpEkywKPvTS1W5Dv3LBo+CdJKvALw4CNNzi8SQpFDOTzRH2xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5043Nn0xn7/k8ExBA7jxtosdKB/Ybg9v1gg7G2GFpg=;
 b=m8oYsPz3JbgIGj4eXqfJYp1rh3Uenbk1l9BYAEyAqQNrVK1MjW6ZQlCTSuJL8xgUmQrodXAyblZvF3ImgOogeANtvH+gbOwfquRaHmc/okWqHIZrmv5mlP1B2nWsZI+RT9NLveOSebJtNPInRP76OOPxgss/LBtwwFvx2VeVPGALqF5RJKTJ6UxNryepIpc+fF6/+R7vjdGdnNp1U6ksWinPK4PLow/T0WJMfU9NAqh5qSYqUA0x9mVIkhewjhORMzOxyAPiMU6mlnUTXFFaQBDF0EhKrq8zAISHy0yGAyjZ6UXAOitSdgvViXZngGIoaDGzmBJNhxZMqXCe/XvOCw==
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17)
 by BL3PR12MB6428.namprd12.prod.outlook.com (2603:10b6:208:3b7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 09:09:06 +0000
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b]) by SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b%3]) with mapi id 15.21.0181.009; Fri, 3 Jul 2026
 09:09:05 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "berrange@redhat.com" <berrange@redhat.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>
Subject: RE: [PATCH v2 1/5] hw/arm/smmuv3: Fix off-by-one bug in alignment
 strtab mask
Thread-Topic: [PATCH v2 1/5] hw/arm/smmuv3: Fix off-by-one bug in alignment
 strtab mask
Thread-Index: AQHdCTm+4HPwCweQB0eNn1elXjz3LbZbgvrg
Date: Fri, 3 Jul 2026 09:09:05 +0000
Message-ID: <SJ0PR12MB861457EF468B2B8DA5BE605AABF42@SJ0PR12MB8614.namprd12.prod.outlook.com>
References: <20260701091209.2860306-1-eric.auger@redhat.com>
 <20260701091209.2860306-2-eric.auger@redhat.com>
In-Reply-To: <20260701091209.2860306-2-eric.auger@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8614:EE_|BL3PR12MB6428:EE_
x-ms-office365-filtering-correlation-id: 692e77a4-f64c-4853-87e1-08ded8e2bbb8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|38070700021|22082099003|18002099003|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info: BbCOkPUYkw4lBCwUXHQ+e3yQFTqJwAs1T9CqKVRbLfeMRHHmwDV+DeeurTIVUw+2+ZJBkrgRIHz+DMdcDsWNUpRGEcMxUsTYXuCl1TeWo4jJls2xeEuv6pzKKsq6q/CCSC0F+eIESSWHq3EQPgkLM7eLrwBmTKexfTHssHyfeWyE7TPjTY6dJbM+Q0JoeLhtV+rcasY308DXYZfJrOPWe/ksDlC5vipBxfP01rflzR9L5XCK0wKaEu08HfeonYpvus1gmRRTh/VtOA6cmfy3Xs8CwpG9+ytq9o0cpVx9wTK/ub4qjPlRXjQyfFlLzCbxNLM0ov3sR3X/TBRw1VN2t69NN8fJHiVyGg4vweQvyKo7lOWuGmaprLsKO8vLV/TF5JBIRW7KsJZPUWb7gFuijT9gRANPwlQ9kNxw8s0XgHnPfAKcJD4b+fn8Aj5Kz4Kg93i8BcKDB11P9VcWA8i0+6LDAL3mdVsZ98/uAFmEtmORUJW42iSG/Ubahk5LEmGRqN32b4pspWz26hWBWYXYjBcyO4ahLejgPw/Dz5PtW8oi540VAD8IqgpmulAvZNq9rGvQYMs/vz2m7pml06G0kus+4HE6bo9rqvA3mTPBB1NPyVpwgW6BG85yJ1/JbJLPV69NguoJCQg9Jbf6/KZkek/RI+WfETG2b1Zw7ebOMXIvIJqURgms/gGbT4J8IZeKO/qiSO6+WeiS6flBHxEE4snyDGEteB8by9jNMjXEl8I=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB8614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(38070700021)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?g0O1sqAwElPi4yPBGeBuk8B5WUtUZB74VT6Qi2+NsgRmgIz+TyISthqC9lO5?=
 =?us-ascii?Q?Xnqp0YwQKU3qPY4gB4rjy3gqAI/c4m0I7JdK1TOqkxsWt/2adD5EuDGQ/6kY?=
 =?us-ascii?Q?KFZFKHfo0q2IvFtncVzL3cvJACNtkusJ6oCNSci/Kuodf5qbpCA06kre3vUx?=
 =?us-ascii?Q?lty7U+d+eG4P8YwCPG4/M2tcK1kVY6mNLxawb+/yLQC3aPj33chqlM0/3B10?=
 =?us-ascii?Q?G6+9DtF0burWYUtl6+7fhD0YQYpqKtDaEN4xEG2IeU/Js333oEmLzrA4Ht7r?=
 =?us-ascii?Q?OOCTIC8xU7JyDHY8lyDuCMq0+uTJnOLVdj1AOuBdvAeBJqSfZOwnArKpuILJ?=
 =?us-ascii?Q?c9kOE2ibJa/zPUupWhG0DCy6j99DA6XcRnsQbsFnp/rDaGL/IcUqLJNQgzm+?=
 =?us-ascii?Q?48Oa/6tN87kV18wTEdX80DJdWC/FqpzJcWcxlVn/UjG1eqEHE1HE9Zpf2e92?=
 =?us-ascii?Q?k2VpmdnZhFV490dY6y/0zYjs+Ige8y1E7pJ0jIse4dipxMI6pe1zfeNO7MCr?=
 =?us-ascii?Q?3e0n7kWgwDsgWDyEB2OV9BhKLre/y8WwBwvi0diAQZc9A+mF0d5YeOUJ/uYb?=
 =?us-ascii?Q?5CAggz373juZRul2kZQijssRogOjwsO7WeKeUUQKts01bXOx7Kl4zJGl2vOc?=
 =?us-ascii?Q?9WhZnUo7s2v4VJOeDUpXMhxkGBWRs3RwoJdyxX9LqXCI5yo9J/RY1kQXqIzL?=
 =?us-ascii?Q?cUPize5l4bxjQdNYI3pCoBxY30aiSmfdKiryOmrQO0S+k4Ar5O7nU5xmd0lE?=
 =?us-ascii?Q?Lm+0pTTYc2zmglo3iVGxasjN1Z7bsbptxNZd6jrFFRrNPAnQAf+iH76iV5Ia?=
 =?us-ascii?Q?tFxNHxSTSLy1KBhmCZOahqjBez++1RIoS28b9XxFKnNOOajqWp1Z3C9J5BFz?=
 =?us-ascii?Q?G1LOhyv9ExV5/7aJXtt7EQWgOUZ/yPU3OQLcrMfX2VO9iFsS1Pn1UQZVIKsu?=
 =?us-ascii?Q?kU1uF8fFMLICzs0jQB/dQrIGP2v8xCtf5imGwPp4m9SZPENhZQQ1xKH7I5rl?=
 =?us-ascii?Q?hisH01NRkbnyg9OmnyhsJLiS6uEp0Byl61Q/uL/8lKGAtWQkQe5xi3dklZWf?=
 =?us-ascii?Q?kCNMUnJXK1NbhBueH2YEoBWpprP2wfLTCkKgs5LleUwEHZ1i+SlsnqGKEW1h?=
 =?us-ascii?Q?wXdDmvB/ngfQj733rRuu2nyUo2KJs1dzp2oFqfniem57Q5v24moE8PO3oycN?=
 =?us-ascii?Q?c8V3nJyBpcTsc5TrnGZsYa2pMOlSHtuz3LJzQyRaGQLGj9XpF/e75r7if3Wh?=
 =?us-ascii?Q?2nu7ZZcISrWzcJTbGG1luLZEML7cQtdxKVbLerSdnUJ1eaibOXjagcEZp56d?=
 =?us-ascii?Q?EGX4EbGAkV7FYgZn62pXdBs+R1tvw7uwnGjPScpWyzX45K9CoNSQcQRgAduC?=
 =?us-ascii?Q?b8HfnreUYCgDQEv6I7vQ/MiUcx2oU96xzxIdvm2sLFQvG7XvekptfDa+VykK?=
 =?us-ascii?Q?JzX4RWvJ6FTYoPkkHyE9W0C+ehLITXKfVoOggSSqPSqcJajwvnwQjPhkQ2oJ?=
 =?us-ascii?Q?VTigMiLCyPCmtGIm7cxVIMhz74oMgHjjiVwAQXSv58C3GrsrZUeHRHAvrokG?=
 =?us-ascii?Q?Rd1cXpvDIAdrCSVGd4pTjkmfkDUgp5xjZ4gY56kXJPUCicfdXaXvE7/CdGEX?=
 =?us-ascii?Q?dEK3FO9d4UkcDiRGVSMl6YVvXs8lvxNxBo4LcYZwh8JFmJee/J5n2VNrJwR6?=
 =?us-ascii?Q?ihwswFe/XfXxevQTKXULJNzwv3OTE8BzbqdM/nU99EqLySd64JitL0uUBgt/?=
 =?us-ascii?Q?gq2igCsJbw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 692e77a4-f64c-4853-87e1-08ded8e2bbb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2026 09:09:05.6799 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BDal4tA0J35n2SUBAov/AyTVhCpftJ4+Zc8h7gI8AtUoZomHd5VvwRxIDoLjHpivNNCpBZ5FpsCgWViw1Rf5hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6428
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
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
> Sent: 01 July 2026 10:12
> To: eric.auger.pro@gmail.com; eric.auger@redhat.com; qemu-
> devel@nongnu.org; qemu-arm@nongnu.org; peter.maydell@linaro.org;
> berrange@redhat.com; Shameer Kolothum Thodi
> <skolothumtho@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>; Nathan
> Chen <nathanc@nvidia.com>
> Subject: [PATCH v2 1/5] hw/arm/smmuv3: Fix off-by-one bug in alignment
> strtab mask
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> The stream table base address needs to be aligned to its size.
>=20
> With FMT =3D=3D 0, the spec says the linear stream table base address
> musst have ADDR[LOG2SIZE + 5:0] =3D 0. STE are 64B
>=20
> With FMT =3D=3D 1, ADDR[MAX(5, (LOG2SIZE - SPLIT - 1 + 3)):0] =3D 0.
> L1 descriptors are 8B.
>=20
> MAKE_64BIT_MASK() second argument is a size and not a shift, so
> there is an off-by-one computation.
>=20
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  hw/arm/smmuv3.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 5e5a6a960c9..38aba9c0af9 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -664,7 +664,7 @@ int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE
> *ste, SMMUEventInfo *event)
>  {
>      dma_addr_t addr, strtab_base;
>      uint32_t log2size;
> -    int strtab_size_shift;
> +    int strtab_size;
>      int ret;
>=20
>      trace_smmuv3_find_ste(sid, s->features, s->sid_split);
> @@ -685,9 +685,9 @@ int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE
> *ste, SMMUEventInfo *event)
>           * Align strtab base address to table size. For this purpose, as=
sume it
>           * is not bounded by SMMU_IDR1_SIDSIZE.
>           */
> -        strtab_size_shift =3D MAX(5, (int)log2size - s->sid_split - 1 + =
3);
> +        strtab_size =3D MAX(6, (int)log2size - s->sid_split + 3);
>          strtab_base =3D s->strtab_base & SMMU_BASE_ADDR_MASK &
> -                      ~MAKE_64BIT_MASK(0, strtab_size_shift);
> +                      ~MAKE_64BIT_MASK(0, strtab_size);
>          l1_ste_offset =3D sid >> s->sid_split;
>          l2_ste_offset =3D sid & ((1 << s->sid_split) - 1);
>          l1ptr =3D (dma_addr_t)(strtab_base + l1_ste_offset * sizeof(l1st=
d));
> @@ -729,9 +729,9 @@ int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE
> *ste, SMMUEventInfo *event)
>          }
>          addr =3D l2ptr + l2_ste_offset * sizeof(*ste);
>      } else {
> -        strtab_size_shift =3D log2size + 5;
> +        strtab_size =3D log2size + 6;
>          strtab_base =3D s->strtab_base & SMMU_BASE_ADDR_MASK &
> -                      ~MAKE_64BIT_MASK(0, strtab_size_shift);
> +                      ~MAKE_64BIT_MASK(0, strtab_size);

Should we cap the strtab_size to 64 here?=20

A log2size=3D59 will make strtab_size=3D65 and MAKE_64BIT_MASK
may return invalid in that case.

Thanks,
Shameer

