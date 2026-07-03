Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A62C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 09:22:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfa6I-00023q-2B; Fri, 03 Jul 2026 05:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wfa6F-0001xA-Q0; Fri, 03 Jul 2026 05:22:19 -0400
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wfa6E-0005L4-5u; Fri, 03 Jul 2026 05:22:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kfvcNzwhlAd3NYCuVSjt8BxywDdvk3jKaqPjLWH19XYC/I/YbmUgrrI06FHS7bBMp60cGwB5m05Tog9A2EYI7MDSAcbDJrQGcE8fRe2yArxxsoZnR1OZcq3IUxGy1S+/KP5vxUri1AA7fjmo/6cPN8ih+aMo4RT2fuyfUatIf18OHrA9KONUEeOlbG3pRto5UBpydPwlU+yxvcOuQ7Kqh0Ixn0m4QsXPDhLRETlLAFNtbg0xyO8JkLDWlYrKlH01UCHEY/jJwJaJiVvtQugVqfiP5PD5SGtOPktEHubUP2vP7FLk7AZ5XvGT/4LNiEedzqiyXP0EHGGQHjedxlBGbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8+MdVaURkpk7tfGX8S8HktOAwI1UNAOEO3AEm9OszA=;
 b=dWxK2V7tceFI3Xe/Jy8oM0gtbrxZ9eEm7nCEewBik3WtppT5q/4bZP3hWxDaFcaoorn9DVxAJSVylh4B8+deQowt6c0Na6aS2R5fw5yyuMOWMQx+Tzx0jed+BnU186HbtmVPqTBXIYwlOwdytJTfwfGKocwzxAU4MwCcortGaeMVUnKE9LYZgWY66LMuzRZJOju6dRQNI10v38nhqt2U7X5sNKQ+CsIFpAZHaIRvrKgJxY6y/CGwW+p+q8oZuWH4bSTRlEAaJ6976ZixpLtIQiAcDxEfEADZ6e20hK0nGLb/aPl5Tq6zeuQoWHnnfTVPVum7Rlwz8A8y/4wsiAjC7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8+MdVaURkpk7tfGX8S8HktOAwI1UNAOEO3AEm9OszA=;
 b=ox8nf9R55AzJN5sgR+FFohMH59C95370pGlIzHk1j5yUlolHkSDQ5zsVc6TNB10+uJNnowVXUBtmVuJGshghyh0A9xFEZivRr4r+mvlvguUUMi6Pm0r6eNtMQj9TkgLbgszq/txHCcHUCY/ZvRdSLrFxC5jSfuckjLtNeRuxeTNoZn/POiafZyqbJcJEPgAaJk/eSNHwMGheLh8zk6j0UJgxNulQnmk/dGQLVDxFGAFLnvg9th+bXfMJbu1x/QsqO9TIWzLwV6N/DV3JDcVq6+4mEQ3VCjb8p2MgJq96pcB9mlKVake+QpM3q8rHyLiYtL2eNz4FUvkfdBIW1hfrsQ==
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17)
 by MW4PR12MB5601.namprd12.prod.outlook.com (2603:10b6:303:168::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 09:22:11 +0000
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b]) by SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b%3]) with mapi id 15.21.0181.009; Fri, 3 Jul 2026
 09:22:11 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "berrange@redhat.com" <berrange@redhat.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>
Subject: RE: [PATCH v2 3/5] hw/arm/smmuv3: Sanitize
 SMMU_S_STRTAB_BASE_CFG.LOG2SIZE
Thread-Topic: [PATCH v2 3/5] hw/arm/smmuv3: Sanitize
 SMMU_S_STRTAB_BASE_CFG.LOG2SIZE
Thread-Index: AQHdCTnCf0chlEiYXkGKm5e0ROLdZrZbhqJA
Date: Fri, 3 Jul 2026 09:22:11 +0000
Message-ID: <SJ0PR12MB861487A4F1ACE72442430F25ABF42@SJ0PR12MB8614.namprd12.prod.outlook.com>
References: <20260701091209.2860306-1-eric.auger@redhat.com>
 <20260701091209.2860306-4-eric.auger@redhat.com>
In-Reply-To: <20260701091209.2860306-4-eric.auger@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8614:EE_|MW4PR12MB5601:EE_
x-ms-office365-filtering-correlation-id: d21e9cf5-4cb1-4197-a4a2-08ded8e48ff5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|38070700021|4143699003|11063799006|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: Mww4ltqP+KThnyw6maK+0Zsdd9+6f5PFqiVMx9L0cO7Iq0tZazfUcovcwXw3yC/F/ud0Vc9+fEwp4T5n4dzgHedHT0S26xdj3+S3tYG+SVGzEnGeFSQ1NzEkOLg71sXBq9x0ascO9hnrNwrkzzaCjfBSq6W/D80bBWdW9II0YLSfi1wEJ7xr+IFkGx0L8opyRiqCFAwqU984tJK8jeTKQUwQnGUtqiBY0Ak4IdwvjU0V8WpvCaIzMA0fMRVBDZK4cqjGDysR31i1HcPk94CQr/WDpENkeIwoU05ngxEe3CQaakr6u1KT9qp5jnifg5/Tl7JM6xW1I3HR0Xtytr0diZLpk06+6lWWzUOoy/XYXrQjpXgdMhYvipyXLWQwpaUEtBGx6YLizkds0V67NyaFHxeYW03AIDZH60C+AH/tgTS40T08RAGmFK8jaRjTa9fMDRiSdHx+TbK2myB5Gn1bJGuwBHrZ9uRmNYR9dJ7W0nV2F3LITJE9+WirbWWOy+VBa1MWZwbPcWX66vuAfOWavO3EG5MMdhxKyzkUvvxF0gIbYg3ybTkruvg0/caNSF3mTFTBntscwGBE5dsFADOyxklV5QTWJZqeaMbvep9K/0vuveaUKQ4sFrOpUtIlOmTciUVJRdarnzpXEZLPjJtal9hHwIoiByLfHjg7LOJmSaJernSdhy3fcjW72Y1xj3bAoPcJUNaCpfOyrvPqYnGsbkKVHxKC1JHrrM8Kterl02Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB8614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(38070700021)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ch29S6g3byU/8erAanbvw7COgw7Iu3ioeU4GjbDxnXlV5ZmJY3g8EgKCubi2?=
 =?us-ascii?Q?wWtQHLzGKFflnTW4gSk68AicCWOfsazIQMBxZi+O2v8Rrcz+573iq/PDL2qc?=
 =?us-ascii?Q?52B/0MWbh3HaOIk4W9mInG5gI7SUjFFfDngijA7xvGleVgBGYpE9rW74k+W2?=
 =?us-ascii?Q?KouTQ8pYuFkd5mAQJFDhjXumRnsVp5FLHkVIYKnLPRAixn2VijMIcFDrpd8+?=
 =?us-ascii?Q?NVzCv8OWVGUFsPC3SweLD3LGcehLCUouWGKcleONBwXV80KB5CZjsTc8uZpe?=
 =?us-ascii?Q?XkLk/Yi/vdef9NVU9hWpMBWr4I7tRtA8NxmDdXbq5WeXv0jx+NN36VNbaD2w?=
 =?us-ascii?Q?6ksXC/tAB9ebL6TFnFYPDRmneYtIimJAUOOviLxOKiRuCHSj/rcxhRhctk4T?=
 =?us-ascii?Q?P3oVFOgVWMpWkxeyfx+nZlpzerjzmSoAEDh6pSxZS6Ybsnn3fdGGdcnbxRMf?=
 =?us-ascii?Q?hlifBRF6YTJqSsxJ4vb6MJVB/xhp8k/eQLL75moZyLUo2hEh21RMnJb6ujHw?=
 =?us-ascii?Q?YUZnILZYCPtWqRNxiHNcFdnJqYSS3SmUoMFrw93y/h1l/AxQAVTgYE5aB6d1?=
 =?us-ascii?Q?piYP/rAd9MkwV/PxTdfuwr8IHCTIutorMZeCVlv4SBTBMsHIUdxgquCqNvf0?=
 =?us-ascii?Q?SjF6CwqfQrqmIBrCRAOt1gsivjdypR0hLteKqjJUJKQFkFnTQy1T0qhGRTIp?=
 =?us-ascii?Q?SNSFXQqmtoc1tUv/wqtPVLNykfbgrvCn84Ddl/hS9wSFSLrLxy/6LecAhgM/?=
 =?us-ascii?Q?gUoXCKRCd3bL1N9Hf6oDPedkyaaFdqpeflvtuKp70bK34BTlNUaTPoEmcbg5?=
 =?us-ascii?Q?PixWMtqmZDh48bEC8hlkrrqhkYaxrZrSUR5D4yl2hIGYN3NoZ3i9JgcUifo5?=
 =?us-ascii?Q?VPU6J07wEobnYOVWIMtgOdYOZWuT3JpXkFNfsxiKBWtStq27a8k3APdKhVw8?=
 =?us-ascii?Q?wWVDsuwkcatuFLk6nqX0nLU05UGev49XAcxpnDOuvlejl22J3t2MA5Aa6R39?=
 =?us-ascii?Q?vEcNwwML0Jizsj/0nbDU2khVnmJ7OyE/e0TFQ1ez1v5/k32yfr7l4dSeNcI2?=
 =?us-ascii?Q?vpjFhdIu+u9yythL7N5SE+qFvSdF5SzYvAMrcFD67hGgkQZJ4z6K0OItoAVp?=
 =?us-ascii?Q?5rht3j+leZnqIN97F1mEir7X3AFBf2ZpbAXbwHJSDb0Y7go3KekZfZ7beKdG?=
 =?us-ascii?Q?vzEhJbKmrOY/vUNNJe9RdleZAJXnHj0/fYB5o6IjBfn1rPirqvOwIjKujyOq?=
 =?us-ascii?Q?hsiJjI8Qr2wnMpFeteUfN80F4V1JF84rraErtLoYp8MpliKxjNNHahbkA/yB?=
 =?us-ascii?Q?gwyjNsraY22zuyMQdrhhKIiOES/Mv3u51x/fRPXXSZUv7hg/xOPYfgW9Cx6b?=
 =?us-ascii?Q?DUW1xyQQNM0q6eQbrSOSI8lqdbzn5Hviq4XD+4SxPa60shdA0KqNkN7d8saA?=
 =?us-ascii?Q?0v2ziown8UR1zD+oxNCUi96oIZuloCGbq6Bv2BaZTa8cBnYdpNfvbAOmZZ0c?=
 =?us-ascii?Q?JYy1rAIZjdUxcntMTrd4ccdd02j4n9pqiR3GtuGilo/Lmykvn30fYCjCHruG?=
 =?us-ascii?Q?FMQm8QSDC+oqwDBAbBIgo/23MO+RE+aWBrEbLx248u+tmmGvxided7pM8spQ?=
 =?us-ascii?Q?Nwf3ed5SFIoh8+oSKH1e38aTd59qjLxPCoj2xtXa+6vsbJkjy3VjfbZsOeK+?=
 =?us-ascii?Q?rWubAERzvQ3HGr9ohj/AzsBFnv/c+OyFPJRdRb2ci9fJlDz0fvxsr3OWCSZN?=
 =?us-ascii?Q?q7mtPAXCpQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d21e9cf5-4cb1-4197-a4a2-08ded8e48ff5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2026 09:22:11.2437 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ao1UT4JWNaVHN05nxWBdZ80QuUhDqij/weWBBuCKCmQjoZHFpaFNlRdBqMwj2R7qXXwZ4A/3FVWX8+oHAjsM3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5601
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
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
> From: Eric Auger <eric.auger@redhat.com>
> Sent: 01 July 2026 10:12
> To: eric.auger.pro@gmail.com; eric.auger@redhat.com; qemu-
> devel@nongnu.org; qemu-arm@nongnu.org; peter.maydell@linaro.org;
> berrange@redhat.com; Shameer Kolothum Thodi
> <skolothumtho@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>; Nathan
> Chen <nathanc@nvidia.com>
> Subject: [PATCH v2 3/5] hw/arm/smmuv3: Sanitize
> SMMU_S_STRTAB_BASE_CFG.LOG2SIZE
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> STRTAB_BASE_CFG.LOG2SIZE is programmed by the guest through the
> emulated SMMUv3 MMIO register interface. Currently the value is
> not checked and used directly in smmu_find_ste() for strtab_base
> alignment computation with risk that MAKE_64BIT_MASK() runs out
> of bounds. On FMT=3D=3D1 the strtab_size cannot be greater than 64 after
> the SPLIT being at minimum 6 (log2size is max 64).
>=20
> However on FMT=3D0 path, strtab_size=3D log2size + 6 can potentially
> exceed 64. Let's abort in that case.
>=20
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3632
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  hw/arm/smmuv3.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 285e6164a07..5ec3700d0d5 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1696,6 +1696,14 @@ static MemTxResult smmu_writel(SMMUv3State
> *s, hwaddr offset,
>                  s->sid_split =3D 6;
>              }
>              s->features |=3D SMMU_FEATURE_2LVL_STE;
> +        } else {
> +            uint32_t log2size =3D FIELD_EX32(data, STRTAB_BASE_CFG, LOG2=
SIZE);
> +
> +            if (log2size + 6 > 64) {
> +                qemu_log_mask(LOG_GUEST_ERROR,
> +                              "Invalid STRTAB_BASE_CFG.LOG2SIZE: %d", lo=
g2size);
> +                g_assert_not_reached();

Ah..this will address the bound check issue I mentioned in patch #1 I guess=
.
But this will terminate the Guest. If we limit the strtab_size =3D MIN(strt=
ab_size, 64)
in patch #1 and patch #2 sanitises the SPLIT, do we need this patch now?

Thanks,
Shameer

> +            }
>          }
>          break;
>      case A_CMDQ_BASE: /* 64b */
> --
> 2.53.0


