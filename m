Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3255BD13C3E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 15:47:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkOnx-0006Zw-P8; Mon, 26 Jan 2026 10:47:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkOno-0006Z2-Fr; Mon, 26 Jan 2026 10:46:59 -0500
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkOnm-0002md-NV; Mon, 26 Jan 2026 10:46:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AMx0JZ1YxFeXTD90zu0tVqkMFci8bfjRXrhZUUzp/KKuAxSczL+eEf2ZsgJuOlN2BMvyAInx+s+oGpUSbwIMbr5y162T3c4WXF6qihyecxGfh2ugpjWIWal7Qs6mG2iAiJxLR9prLCQWLi4Ogf8RMJ+sMpActIV9xHv83XMUspMcse4B7SqYpJ9Rcpoi5dTPf+ivOBEW5nzujC623VpT2IAwA86j4JtXRWtzpFcWHxKu9Opq+G55nXH83vfwIQvPdzoS7yJnRuGnchfN6f8WzsFY6iICKkasVKbbaT2XMiEZXJFj7feD2Fz35HbMooXd4VH2lU9odWstWok5E7fuXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2Jy4HRGrTcixz9gj5cmpzkQsZnZEt6mRBHULWM86oQ=;
 b=jOnJSm+rXz/+XHgFDiPvTfY/XPcryOAOQdylp6hCpCiIlLXJxh2OArIvoJmUoe/Uk8SuIhZuFs1Z4MLWTElPY8ZwdjcQQbsOiHCxHHHGKAVNglLSdhi3db4shVT71L+jLZLtOcfqcPoCg7CYM44KvBJ69YRqM+eYerkqEvJJVVyMMgDGR6v8T+cN0UCC/kZPX2oUk9Atalv66CRqn4oVnXrt641wCmGvIW11+l1QWjQvKoFOw3cn73AQviRhsdTZogqp7TMaQMi2Ncu9234LhHdRdQNXvlLW1zodYX3+mGNkbxj42RNym8B8nmEXsqafx+aep/weqBlvuB7HN8u/iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o2Jy4HRGrTcixz9gj5cmpzkQsZnZEt6mRBHULWM86oQ=;
 b=StOUfvTnC7pgS7k+hHRmz1Y13kJ+Ijp/UkGhlhNLFJ4lGjLbOAjnWocQrvdI49grJ800qIDjc5U12DQfy9212g5MvAb5aJvZO+SmqFKE4zWMYh8u7ZuDPbgnivOMu/khXskeSSOS1wvKlzJMCB9I6mGlPZaoz+SCC/W4GRxd2zQVBz9rocJiNi2eAZSCjgwB0Dm+otN0rg39vnJuRak9eNKLzpgCzU3gzWSKmNtd+ijjyYc6uMfm68rGDriUjWnynXySizhun6u4BMnc1z7z75rS70DXYCNpYGDQltSAuq1q2cRSr8QhCIfWLNk120MjKomHjtfxseQsLvQYGQK9rA==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by SJ2PR12MB9190.namprd12.prod.outlook.com (2603:10b6:a03:554::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Mon, 26 Jan
 2026 15:46:46 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 15:46:46 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, Krishnakant Jaju
 <kjaju@nvidia.com>
Subject: RE: [RFC PATCH 06/16] hw/arm/tegra241-cmdqv: Map VINTF Page0 into
 guest
Thread-Topic: [RFC PATCH 06/16] hw/arm/tegra241-cmdqv: Map VINTF Page0 into
 guest
Thread-Index: AQHcjsqDUtfevyO/FkGC7fEtyBu2xLVklimA
Date: Mon, 26 Jan 2026 15:46:46 +0000
Message-ID: <CH3PR12MB7548B3EA72D252DE8ACB7A07AB93A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251210133737.78257-1-skolothumtho@nvidia.com>
 <20251210133737.78257-7-skolothumtho@nvidia.com>
 <58f0ca59-b08c-44cd-b469-f152271c14f6@redhat.com>
In-Reply-To: <58f0ca59-b08c-44cd-b469-f152271c14f6@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|SJ2PR12MB9190:EE_
x-ms-office365-filtering-correlation-id: fb130169-95aa-4a2c-d8e8-08de5cf21c71
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?h30DaBWK/C+g2fvMZqonlLPNLe+X68I48VDVwTNJMcgd3OEGN7gk87TU3vwP?=
 =?us-ascii?Q?tzjDE/dIWo7gbtLxng6PUmglzW8lx2jRj/Fq6/4KCpjrPvh7p2zfytY63qps?=
 =?us-ascii?Q?pMLokai+4x5x4TuQpvvOkNPAjY0pj28Ij5lPaKVtRAYjJgeZv84aMAuzEBLZ?=
 =?us-ascii?Q?bIJ8IcDvZjNvOFYC/W+hOdF1U7ncOMXpB49ejye4Jql3I0lAllTGJQ6xKr5K?=
 =?us-ascii?Q?7Hmutmluxp4scNuHDxfz87NsAZtlrUPW1185DJkLiWdrpsjPFgYGwe5GE9LE?=
 =?us-ascii?Q?wTsz4aMI7np0zRJlJLBc3d08goALlTlZPcbdO9BAIPbeGG/aiA4Zc6n1jZg7?=
 =?us-ascii?Q?sfz3xRgx/bbUoGpEtDcEvSkPwvqnVSI159rtrxVx0+eMw1DcPyu1B8NveFwd?=
 =?us-ascii?Q?V9/0tvrPL1y869Z60EAetnQIUrd3xFVfIDj8EqUenWFV2acHCHwuCHdghpoM?=
 =?us-ascii?Q?6hrSBbemLX70pwxqP7SSE8VvhPV6yDaB/AGN8NcSJOADpSRTrx2QrWVAMht9?=
 =?us-ascii?Q?ZDyM3YhbHcYP/7X+vRhfbQuonC58OAb2l5rkflkxhW2AlEXF+PhPMxloCpth?=
 =?us-ascii?Q?tWFU4iyWd5zc163KebFNvtS7Qe7k721PbIyEOt+fMQb/wdgZl0lJlwKWAe1r?=
 =?us-ascii?Q?/ox/a/kroUMDxlyY9raPNgrzwE97JMjvYGzojuBYvduk3kHAASCKq1C5ApCU?=
 =?us-ascii?Q?49ltVYSyGFvsJ3+OomRjXPyE3B/i8TwvO41kjdB4653xXTFGqaNHWslzeV8m?=
 =?us-ascii?Q?ghP4N/VP2NT5sL+C5hSBNQ24Ibcm/yayekfjOkGAHd8QLsL/noD1oDj7qMNO?=
 =?us-ascii?Q?YSelOp2mesCJXVgJAL6YTEiDY08ywBgEHSB9HDZBoQnDkusTsSj/g8Ei7Khz?=
 =?us-ascii?Q?QQ43Pr9SGniIq003K/HQsIdKxLAoa4aV7NuVrAFygAxmtrTgYadLZUyeIzx9?=
 =?us-ascii?Q?0ASxibJ1xMLwiJNX5ouhpzHn1c3A8SOI88rlDPbpt9+Jppg9DzoRvm9Yaazb?=
 =?us-ascii?Q?XC0czwLjaDpW4VQXFBJWq1Qkzo6QJjPm3diqefNvKS2sRgAQh/qIl+EY6GM0?=
 =?us-ascii?Q?LfN7A/sq5e7307Rs7kwX/gVurk5rwH4k3MkMlqlsgkZOrAri5brcRBkbKsbz?=
 =?us-ascii?Q?8GPbxmXfmkPexJP4D0IDA/kKzQRrEzTa9dggGiTnB1QeCVXNuz/Rvy6AwVPA?=
 =?us-ascii?Q?bM0D13HcBRJfyEnx0A60NFdUb9zkub2xl3cuDdrqUNNd7zLFEiafw8lOIYPy?=
 =?us-ascii?Q?nEBknJfWZJ3I2tJMbVS5S0w1MMqZ/V2xea8m8nirkuU/OAqfaLvCF0uPC5yw?=
 =?us-ascii?Q?sAU9NE29VJ2lCzUo9An8ogpY8GbCkD7G750igkrn4PzyHWjhgTew3K2FzpNo?=
 =?us-ascii?Q?rq8EzSoUc1LGDL/mORlPBdSmv9kTKyAMbi2F2mbaL8Viv1s9itVkvuDM3Vks?=
 =?us-ascii?Q?yO7SFeq1IUjeQU1uNAACLCHKynPw2/J9WW8boSMoJTDdrJQkjVZQN+VpPKaH?=
 =?us-ascii?Q?LpFel4Cr9fAwXjcSKMWTJSzQgnZ+IYAei/eX82wDmFkUrMOIzO9GQIkClKd/?=
 =?us-ascii?Q?pHFVWAm4GDv3D+JnUfzCKWquu92/somGPcOIV8E+mJRBtD8oevRRRrHTu9CL?=
 =?us-ascii?Q?6zkg4sEMerV8zXlZMHno2qE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/9GYoZhtixwrkePFJfHTOqNBkn9Aae1Svz/0233hH3zOhIZRYkfmBtzy6kkz?=
 =?us-ascii?Q?s2umjH2LnRJTldBIXwj5Q3PfvnD7GtBG5YNY5ZO27CqoLR+AmJJRgwRsYqn/?=
 =?us-ascii?Q?wS6fphy8jZNd5BPd7GX/fco74JyDgW8n8vYV0RYGlukFaBIdNPLgI00s7807?=
 =?us-ascii?Q?SfIj27LpehHES0xPxMVqMbPbbT2psXWIvwnWvgmY2OazLuEP1XUspvvJt3pe?=
 =?us-ascii?Q?ULU53XEfPV/ET8Pi8JCbHsaCHGNjiFOISklhCYz+CAMWVYvFiPUOd1P4r4QZ?=
 =?us-ascii?Q?X6DJ51d77/xdSfiuzWgNe/A74ph+a7A+zTqiG0vHaHxve6/mdkYTOVDN86MZ?=
 =?us-ascii?Q?HFEQvZ5oPSJgoR+4SKOL9yjQqjMfET5TNikQtoyo1wK1wrGN1Xf9aXWvGNdu?=
 =?us-ascii?Q?Wh6uBYhwzr+kQUOlD0zH5O9lQoiU2ObTNNYgTq3eb3JtCXvbhESCbB2CiMwY?=
 =?us-ascii?Q?0HQcg/9/l38mPRp8qJtK8DtSJYc7IHTbU9Qn9tb5LSTMYBbslM921p1oh2i2?=
 =?us-ascii?Q?av1NvXWqfcgw7crRa8fhWbjA5bYy7vW4WZn5HG1UcPhOwhkuO6+j4VXtEau2?=
 =?us-ascii?Q?ELMuuqoKKKmzooraPmni29tcHO/sWlyYsXAFW2WCyS4wGLSgeyONiNViVPB3?=
 =?us-ascii?Q?0TBFTOP6ndsR8xwsMLCQJyErpRe9e4QEENeBtypy80QQOHKqZLSoOCIh4hMe?=
 =?us-ascii?Q?nX/jS+tT0TPeaXEPmuwyp15sW3ZbWdqL/gQV2XKVTZarltf07i6m/HHaQbI8?=
 =?us-ascii?Q?0XC+twY+dWQ4s7484vOIkyYmBFFwXNpYf4Un3QhEcnVQhmDdB/P9G/wRglo0?=
 =?us-ascii?Q?7moRtf0RCSouwsP8vgyJdwNlqxfUSZm0T8czIGrl4tP9c+j7/sbtyqnxnOfT?=
 =?us-ascii?Q?ySqMuf55BfKGGRHMuDrnjtZxsvH+hQJ4Gi2WwIwHdJqcXSIKPG76UHoVwU43?=
 =?us-ascii?Q?O9wZQ4KPFASf/9MHcJgZVtHI/zXTfFEM7CT8gSODnmPo2eioLjtp6RRG09a4?=
 =?us-ascii?Q?Sjgk8K2viunLZex+L6z3ba8Mb9VVyoEGNv9OYOSePxZ8BF3B/TckK1LEhJ7U?=
 =?us-ascii?Q?+o93SmK+mvIJChhUEbTd9OXT5PU849W7LxjZwDKz6KxE7xMQpkQVKWybTSZk?=
 =?us-ascii?Q?KCtBrpUzeNoDn+AsB9BLWbD7yA8H4Ga/CSf+tVzhVt1YfPj6olQc5hjBd8KQ?=
 =?us-ascii?Q?OVpvXoy3bbjczOqblBrHiPJ4AumTLG32VhKi/8uQ6j9d3hN8WIaccjMw62eh?=
 =?us-ascii?Q?e/Wa0tai7hxMH7lDfo3yhAmh785Z7dHqtWTx2Uy8N04X+edWOJxopjl1AIss?=
 =?us-ascii?Q?nafa/qP9YHZ2Ka3nbzwJV5+bCZm0qu4QzO2gFszRnjZAl7YMIcc4FCI8mPmd?=
 =?us-ascii?Q?9lHwzuGS9qBGslRG+ctC/grS5Gm7N+Cv+60sorrYCrZyGYbtOYBh23Q1pgXY?=
 =?us-ascii?Q?3I4+YGFVPt7/2Y/FgPh2azw1p1g54acT512XpohPm71vHJkD2DghiRdEtOd4?=
 =?us-ascii?Q?MK1VQbvRT0eNWIi08KTVIZHpLVi+VpA7IUl7/NLZk8TrPP/RolDYoVPh53lY?=
 =?us-ascii?Q?et4u5ROzir760NKSHI2VrIS/oooiScNObIln8aIMiE5rRXTin2EclA4P7ns+?=
 =?us-ascii?Q?DdzFLpDHXGwqm6jrrqVLOobmJI31lYAq9K2r8rFMpNk702BXhCwzbp9pHwAy?=
 =?us-ascii?Q?JhvRneZC8gfME/XAz7o14JQ6s3Bz0YEUV0Il2RnWoYqUFGHKhmoJL0GVQ3QT?=
 =?us-ascii?Q?wCXttEN/+g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb130169-95aa-4a2c-d8e8-08de5cf21c71
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2026 15:46:46.2042 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mEl8OUnr6xqINuJ7PmJM4kTKtrvG2LH+eNdBrODKFwxeLDL67H0n+noiG1cqd9rLhHT3wOOb5a48N9imzPMeRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9190
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=skolothumtho@nvidia.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
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

Hi Eric,

> -----Original Message-----
> From: Eric Auger <eric.auger@redhat.com>
> Sent: 26 January 2026 13:49
> To: Shameer Kolothum <skolothumtho@nvidia.com>; qemu-
> arm@nongnu.org; qemu-devel@nongnu.org
> Cc: peter.maydell@linaro.org; Nicolin Chen <nicolinc@nvidia.com>; Nathan
> Chen <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>; Jason
> Gunthorpe <jgg@nvidia.com>; jonathan.cameron@huawei.com;
> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; Krishnakant Jaju
> <kjaju@nvidia.com>
> Subject: Re: [RFC PATCH 06/16] hw/arm/tegra241-cmdqv: Map VINTF Page0
> into guest
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> Hi Shameer,
>=20
> On 12/10/25 2:37 PM, Shameer Kolothum wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> >
> > Tegra241 CMDQV assigns each VINTF a 128KB MMIO region split into two
> > 64 KB pages:
> >  - Page0: guest accessible control/status registers for all VCMDQs
> >  - Page1: configuration registers (queue GPA/size) that must be trapped
> >           by the VMM and translated before programming the HW queue.
> >
> > This patch implements the Page0 handling in QEMU. Using the vintf offse=
t
> > returned by IOMMUFD during VIOMMU allocation, QEMU maps Page0 into
> > guest physical address space and exposes it via two guest MMIO windows:
> >  - 0x10000 :VCMDQ register
> >  - 0x30000 :VINTF register
> >
> > The mapping is lazily initialized on first read/write.
> >
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> > ---
> >  hw/arm/tegra241-cmdqv.c | 60
> +++++++++++++++++++++++++++++++++++++++++
> >  hw/arm/tegra241-cmdqv.h |  5 ++++
> >  2 files changed, 65 insertions(+)
> >
> > diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
> > index 899325877e..d8858322dc 100644
> > --- a/hw/arm/tegra241-cmdqv.c
> > +++ b/hw/arm/tegra241-cmdqv.c
> > @@ -13,14 +13,74 @@
> >  #include "smmuv3-accel.h"
> >  #include "tegra241-cmdqv.h"
> >
> > +static bool tegra241_cmdqv_init_vcmdq_page0(Tegra241CMDQV *cmdqv,
> Error **errp)
> > +{
> > +    SMMUv3State *smmu =3D cmdqv->smmu;
> > +    SMMUv3AccelState *s_accel =3D smmu->s_accel;
> > +    IOMMUFDViommu *viommu;
> > +    char *name;
> > +
> > +    if (!s_accel) {
> > +        return true;
> > +    }
> > +
> > +    viommu =3D &s_accel->viommu;
> > +    if (!iommufd_backend_viommu_mmap(viommu->iommufd, viommu-
> >viommu_id,
> > +                                     VCMDQ_REG_PAGE_SIZE,
> > +                                     cmdqv->cmdqv_data.out_vintf_mmap_=
offset,
> > +                                     &cmdqv->vcmdq_page0, errp)) {
> > +        cmdqv->vcmdq_page0 =3D NULL;
> > +        return false;
> > +    }
> > +
> > +    name =3D g_strdup_printf("%s vcmdq", memory_region_name(&cmdqv-
> >mmio_cmdqv));
> > +    memory_region_init_ram_device_ptr(&cmdqv->mmio_vcmdq_page,
> > +                                      memory_region_owner(&cmdqv->mmio=
_cmdqv),
> > +                                      name, 0x10000, cmdqv->vcmdq_page=
0);
> > +    memory_region_add_subregion_overlap(&cmdqv->mmio_cmdqv,
> 0x10000,
> > +                                        &cmdqv->mmio_vcmdq_page, 1);
> > +    g_free(name);
> > +
> > +    name =3D g_strdup_printf("%s vintf", memory_region_name(&cmdqv-
> >mmio_cmdqv));
> > +    memory_region_init_ram_device_ptr(&cmdqv->mmio_vintf_page,
> > +                                      memory_region_owner(&cmdqv->mmio=
_cmdqv),
> > +                                      name, 0x10000, cmdqv->vcmdq_page=
0);
> I don't get why we need/have 2 RAM devices pointing to the same @ptr
> =3D cmdqv->vcmdq_page0. Is 0x10000 ~ VCMDQ_REG_PAGE_SIZE?

Looking at this again, I am now a bit unsure as well why we need these
memory_region_init_ram_device_ptr() calls here.

I will go back and discuss with Nicolin and come back. I think we need to
document the memory layout better here. That will avoid the confusion.

(Also, will check if we have a public link for the spec or not).

Thanks,
Shameer

