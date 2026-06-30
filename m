Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1362BC43602
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 09:12:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weUVU-0008Vd-Cs; Tue, 30 Jun 2026 05:11:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1weUVP-0008V5-5n; Tue, 30 Jun 2026 05:11:48 -0400
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1weUVN-0006wD-HJ; Tue, 30 Jun 2026 05:11:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A6jENx0VtFJ86ZUlA04E9j3C5q1kKmTcFDvXqo0CkLGj0ny0/LR7R9hSKRnWsVFiUqjYXdi5fvNeU72hDvCnr1diFcoHtchUZTeyeUomPENiny/7Ztx7dqS9msfeDr47c6gaUIXWSz6FaAm0oYPE1PTqlvcB6dIlCpNkr0GVsv1yogjvDLvNP57nlLPIH1QWnLngCQScxEkXUVAFYvavqY4n6Y1t8GjOX9eXQSJXH+8QkpWecOeN1/6qwQivJRW9YFSZ4QWyAxUJtJBwOaQsrzeyLxqU/PIeBvs93DaunfOwkhgXGMkLQYsjZoAg7QFLM/VrJU9M5p4e7x+XmKUR/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KZ80yA3mpn6OPH64QwQGpC7EkzL9g3EW1Pvg0zD6gtc=;
 b=viDPFvX2QO6iedPI8Ze1t3tU2iZIk7ew0VY9PYYkzGI1/2GKTYGixQ/mDIVXTPZoh+QFEYx9D/C0U/fBRFBvUZoeZ/QMQZFsGrYa4gYRsw5V1VUJ1KT8woVc0ZfORTLMu1VqltpvVyUI/8iLSxTExSzanGfdkDDN4yHK4j3jYEC+RASI6DcQJxH2hhxJmqL/mDUBUw4UNPnMT44Bkwp5ZNx0JaKy0KagovVEhjCe1viw3HzHkCRkJrrkgp+U5pacXgKHO1RME3IDkvjHpuGiuWuTU60ED3CDuXDTWOPBd11rC7dv2+kjHQgUEzP4rf5LwcN6NnXNddVCWGA9o58+aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZ80yA3mpn6OPH64QwQGpC7EkzL9g3EW1Pvg0zD6gtc=;
 b=sK+VPR6YtvYsSweD+4bz+xU/55ZgArDAuoKgrPN7wDXtGVj4mdExt/hzUxJwM/GijbcIxGH/I50VR1nBMzyRvc2Oov7Ll+Y/UY4vRA9NHTSq349M8uRKbp7LAEd+V/tomhZhfA+VZf0c8QdNjhGWtRRZuHWmvxqUAyxNEfsUeoKV2M42EKn8KJamQ2aV7eb6l6B25om8cH+dTTiw30sVfpa7cl51xqRA29vVgx3Nu4Oq1nmlR+bA8xz691NpbOlFlEjkTW04YiUQ4go3oNdB8fZwA8HJO+/s63tRkIZ0ND+3YygMrMOG94wUOJ3NEvnOnuawKb0c03UsjFOGl49/yg==
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17)
 by CH3PR12MB9218.namprd12.prod.outlook.com (2603:10b6:610:19f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 30 Jun
 2026 09:11:35 +0000
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b]) by SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b%3]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 09:11:35 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "berrange@redhat.com" <berrange@redhat.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>
Subject: RE: [PATCH 1/2] hw/arm/smmuv3: Sanitize SMMU_S_STRTAB_BASE_CFG.SPLIT
Thread-Topic: [PATCH 1/2] hw/arm/smmuv3: Sanitize SMMU_S_STRTAB_BASE_CFG.SPLIT
Thread-Index: AQHdCGrJHjiFCUes10mJFw6CgulT6LZWznIQ
Date: Tue, 30 Jun 2026 09:11:34 +0000
Message-ID: <SJ0PR12MB8614BCB8A6B565224E8468ABABF72@SJ0PR12MB8614.namprd12.prod.outlook.com>
References: <20260630083042.2692392-1-eric.auger@redhat.com>
 <20260630083042.2692392-2-eric.auger@redhat.com>
In-Reply-To: <20260630083042.2692392-2-eric.auger@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8614:EE_|CH3PR12MB9218:EE_
x-ms-office365-filtering-correlation-id: 1539a183-49a3-43a6-ceb4-08ded687957c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|38070700021|4143699003|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: aFTUfzN7E4yJXrLBuW760F87+vPvclxuCggabevmGGeTKw4Akbll/h6y7bh//s8RNa77ELqM6rFf9gKzlnqSFKeCW8ucdLEwcxViImz/ITzJSMWqCHIuMX5QBM7U3ArmelDQvdGzWzdDNquDFaqWO07e+vwGUoHjue7eivbFvaZnLtA4XkPUjltxL6tIhLMN2QWIovq6OY+eHxh5rQ6bX66mYcq0S1l+Yhvj7Ir4w+U3UD+Fe4omxGtnsqi86uJA7T9HwWZGtJEbFSCZJ0L8ufxWrvJiIaUZgzKJ3WFRed0Zs0Qvxc45pDWhJ4FAxoMOdmiwcZs1+nHnc9hrp1Uu4GKVch/XUNE6Gsv419sEOO9AFaMpog3fKcUsWaUQj1GBMmT85Bmej6wsd1Tm/ZZI9m53pLIQnAh8N8WWLXEl88bqXb0k/2lZtIXgcLcji68WD7NUCdMbUcaN4LZah7E8SFim1MhmpTxCFXTKzFvoFtiLxR4eY+OstEwfzyFLpvQEm1D0SJO4J2Qm2XrN8s4zq2i9fh4987MfniXnMhWup1VVorA0h8bdq2N+0tLTCy6EnZ1JHOYVg/UrYR5gjMoTRvuzhXTlg8qchRO3ihl3i8wJavGA8LxepL7kJnRdEtCt+ave1DPb+gIJRbmZGF52ID5Of1rHZdfs1TwcQmkEsqKAeLmJ9dRK0LsSBeHZexV1P5fyPmy5Jt2bTv2G+BpV//0kpX2aUh5y6aeWOlUDomg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB8614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?haCJQXK7mOkvpgrmAGpoR1X8SC7KXrnKiTPyLLqAYdAzorbxYnhoOWsR1bOm?=
 =?us-ascii?Q?esbtE5dZFko9zZI5Qo4w2odojHxzYdlofLXJxb2XacfXKYrqoWaA5LHslYQ1?=
 =?us-ascii?Q?0AfxUf8yOmAgNxMIKev5fI24AwjGqedc/89arfE2oEgdlvHUcB2SrD8RcaJt?=
 =?us-ascii?Q?+ckr/7TL+zhVM+JktYn1GKwG2WRSkQgUnR9DTbIjsFjd4lXF2BiRKZ6PGH7F?=
 =?us-ascii?Q?NjlKas8LBSywTVNcwmiZHYCub/QO03tuSQ3Q+eMlXUAGghq8mSI5EnHTq3iO?=
 =?us-ascii?Q?91FZA8l3Py80GHm3gl7wORWuVnKHMYqx6EKGBJ8Dj3eT+YmY17lFs8WnvVKW?=
 =?us-ascii?Q?w/EQNNvsdvrpu21ThxsC/1fUin2SW3znlIvrGjzZj3HkD8Ns9K7aF8+4BdEO?=
 =?us-ascii?Q?b4C+N/KZoR0OvqBFrw4wdIl7N4ITMooNecCn1BbfQVVuFt0yiD/FVmX1hDsS?=
 =?us-ascii?Q?qqg8HrWTuJ5Ifo0blTzM71XvRlQJtwGhxa2LvFWwoGwI27Q4Yb7lXA3qKDfU?=
 =?us-ascii?Q?b8zfDZnSpjgTrChSPFl5315SfAxtEuqh1eEsLSFN7b7fhUsoUgUE3UB+msIf?=
 =?us-ascii?Q?0cBomJS7OIE+fG8QuFa7fP+ddgRbGZI+1xMM8QmkpFOpUnsHVsPXRrlctc/o?=
 =?us-ascii?Q?mDamFDdPgkC1CcvAhqtchXz7ipozP62BaWCoMZf/DjAC9zkTA0w/4Olv8CF6?=
 =?us-ascii?Q?+9QQPhkl6anypweWvmR+ixTCKcomT/TY3Ayrn06Kjmk0W8ThGc7eFdKV9KoD?=
 =?us-ascii?Q?TPzZiPNT/JrP3O09NieqAUYg4C5QjoujhPgGDdSlsx438hd3FJNPJxAM0Cwq?=
 =?us-ascii?Q?mPstoPWdXuTc9go6/R2Gg32xfTICcxbfyS0v4yKfepSW9jSc75YIlq/o+Q1O?=
 =?us-ascii?Q?Xphnrpxne4fKzYREbwsY1gnXZVulUx1iHEdt0x9lBOvVHei7NVUu8JUR1W9/?=
 =?us-ascii?Q?b32v9EmykkN9fZgS2dCGOJ/WmFo7VHwTFbInFVyBNB1V8LkACoGWwkBbYUlF?=
 =?us-ascii?Q?jtF2RBSFUf5rfdltxx0vdOXsRqs8WZmYDSOwM4UmOu8MUa25sBTN9O/XBI0K?=
 =?us-ascii?Q?yQD4Dx+D4cWj349WFfrj9K1XJpe/qLWu9DCUtGNwBneoHeySVjHNos6mk1D0?=
 =?us-ascii?Q?MD6LKwi0u9jvf3jMW0o+PG05nxtHAGesG0oNtQATNocOk1gVV+1S5wM8QUhF?=
 =?us-ascii?Q?bbuqvrwqW1grHKNQAkclLHz4dtPfIYS/cJNMQLCrbyI9w22TjfUuqrvuXuKO?=
 =?us-ascii?Q?7T/rVEHrN2V8Y1agNNRfy2V8IbexYa5Y+HM3/uxLzyOU7CBfB8SxACr+0fqL?=
 =?us-ascii?Q?pOXVvV3dA3LnEjzJFRoev0fMZK3PYzV6SiZ764kGm3/tGZOWtfWFoL2ixZlq?=
 =?us-ascii?Q?g6nBH/Qv3ZcTYs2OrWV1LLFPmu3NifXlOEGeRUaXJEGFDAaowsFT/E1gTOdK?=
 =?us-ascii?Q?uoR303r9rn9vLqgPv4LjNQHnf3iXZBmaRvbjo2AQSmnu8PfCclbReolg6TYS?=
 =?us-ascii?Q?RZe/tHija7xzS/24mQtXmDPt3kTdLbut71fpY/dJTFlqxL2374UbzXyIJsl8?=
 =?us-ascii?Q?ipK3XYTFFdjRFq8sPYmwcVkq1k/m9nhREmomfyPGKACqd9TVa/73Hw4L3Ln2?=
 =?us-ascii?Q?x3XxWG+veu06HGmLEa5gAGkGZBPkdsx7RDsXBM0mUjMxXyj9jhe3li7ALqZZ?=
 =?us-ascii?Q?k9aFkD/8PgDy/n+zr0VoA/xw+TGkDvYTiUBzWaap9qTBSzWGk3qy89H/eJZ+?=
 =?us-ascii?Q?RJmMF5AY/g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1539a183-49a3-43a6-ceb4-08ded687957c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2026 09:11:34.9581 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kfsvzvKFZovdl3jh1qzYx6Q+KPyTiNIVXNhU2ugKHb0c1ZT1OKeuCphm2d2QQLWvIr71zZKRRfyiK8z+8Y/IdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9218
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
> Subject: [PATCH 1/2] hw/arm/smmuv3: Sanitize
> SMMU_S_STRTAB_BASE_CFG.SPLIT
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> Currently the guest value for the SPLIT field is not checked.
> Also the spec says that values different from 6, 8, 10, respectively
> meaning 4KB, 16kB and 64kB leaf tables are reserved and behave as 6.
>=20
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  hw/arm/smmuv3.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 5e5a6a960c9..0a8d2fbb6a7 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1688,6 +1688,13 @@ static MemTxResult smmu_writel(SMMUv3State
> *s, hwaddr offset,
>          s->strtab_base_cfg =3D data;
>          if (FIELD_EX32(data, STRTAB_BASE_CFG, FMT) =3D=3D 1) {
>              s->sid_split =3D FIELD_EX32(data, STRTAB_BASE_CFG, SPLIT);
> +            if (s->sid_split !=3D 6 && s->sid_split !=3D 8 && s->sid_spl=
it !=3D 10) {
> +                /* Other values are reserved, behave as 6 */
> +                qemu_log_mask(LOG_GUEST_ERROR,
> +                              "Invalid STRTAB_BASE_CFG.SPLIT=3D0x%b, use=
 0b0110\n",
> +                              s->sid_split);

0x%b is confusing. I think either 0b%b or %u is better.

Other than that,

Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>

Thanks,
Shameer

