Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6ADFC5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 15:57:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx57N-00068k-6n; Thu, 20 Aug 2026 11:55:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhonap@nvidia.com>)
 id 1wx57K-000684-TX; Thu, 20 Aug 2026 11:55:46 -0400
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhonap@nvidia.com>)
 id 1wx57J-0000cH-BA; Thu, 20 Aug 2026 11:55:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B1qtV15Y8ud26FnpVmZC/S46ZJJi3WYiVC/b5d3H/cJAkHMBTxkUf8Qgo/7+3WOH9tHTPmotSBhFpb+uB6EtOHYLy8PKG73Pd0FfLy5cp3/hzJHn3ex7KykOgGgaHZNCV/82w3W5J9MB9PCOViXH7hWSVPJa5smTrN6Ozrn66rDRlTqOo3rlpA2BOXfvzBULXwf63a7vs3RqxaI5COmPV/2wDcc+q++2LphWe6xFYGVQDdETn8CIayiZfFxKcuPL6/X0GXLiv4cIuOcZbBT1dRYGV86Nrpzwh1vM7Xt36r3QDT/iNtIbo8jiXZljp9DwsPEPep4UOhSHe1Kxcl40Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7j7FHCo4MKACJWT0g3zernGi8W4b0HcoS8/K1/12Xag=;
 b=Qy0NGixkaPHvYmZLfTIwxmdUIsUP3Y9kyWUH2oznwx/1FK9Gzrpl3rsmXbtbj+v67HWLEomhuj2vB3I6bZbeHdS2xC1SsigQsmzt4GrfdyKq+z3ZBKN+woV/W8vOIIqysKkLpOPti7olh5O8fTYRt1d66bR8lWvZMKemjOFFcv/z0BiUCcLIqatWhf7kKtvZo7SaUJzGHgD4ysTKsuGDiTBQQFoVgqcXvwmJ/qRcKpAdnuhV+yYGVbHofjG+SrY536I86/3iFo9ADUFbflDN+o+vpOOO5SOGJ0/7eVD0BbMOJp9wT2erj9t+zDdHgRMEy+HPXsEFNuJ70pID8eyZnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7j7FHCo4MKACJWT0g3zernGi8W4b0HcoS8/K1/12Xag=;
 b=fUDrl0MKoK+2Vx08jLopSfwFHjQK1Sm+d4Ui356bRovpfhvZXio8VVjteFZfm52e5mncJJXb3zsVocBIhNqUcMHhrE8vh8pE48N6VW5nkEWoEGg86c7EnIukZlRqgfu8OM++p18Oyir+VJ7fT2/kSA6tuWTQZaxv5KJb1H3njyLLsuM3/t2/itYajHArzkFwiRSn8hxNarMpM+3w+2sLIkE8lVsXsixKVLIg5vX329EMIVXDAN4vK/YK9lqx/C1yg8ZWlm7hnDf0foz0zjDl3jE1OWQ77LxvzRl8nB7830dVnvN/kiAJ2CSTLbtGIBmDoxNYDMVCxQlI5fZ2H0/bUw==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by CH3PR12MB8755.namprd12.prod.outlook.com (2603:10b6:610:17e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.9; Thu, 20 Aug
 2026 15:55:33 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%7]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 15:55:33 +0000
From: Manish Honap <mhonap@nvidia.com>
To: Junjie Cao <junjie.cao@intel.com>
CC: "alex@shazbot.org" <alex@shazbot.org>, Ankit Agrawal <ankita@nvidia.com>, 
 "jic23@kernel.org" <jic23@kernel.org>, "dave.jiang@intel.com"
 <dave.jiang@intel.com>, "alejandro.lucero-palau@amd.com"
 <alejandro.lucero-palau@amd.com>, Srirangan Madhavan <smadhavan@nvidia.com>,
 "pierrick.bouvier@oss.qualcomm.com" <pierrick.bouvier@oss.qualcomm.com>,
 "mst@redhat.com" <mst@redhat.com>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "anisinha@redhat.com" <anisinha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "clg@redhat.com" <clg@redhat.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>, Krishnakant Jaju <kjaju@nvidia.com>, 
 Vikram Sethi <vsethi@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, Manish Honap <mhonap@nvidia.com>
Subject: RE: [PATCH 00/10] QEMU: CXL Type-2 device passthrough via vfio-pci
Thread-Topic: [PATCH 00/10] QEMU: CXL Type-2 device passthrough via vfio-pci
Thread-Index: AQHdKySn6WX0msXSi02KSmRfvAy5s7ajmBgAgAOGyuA=
Date: Thu, 20 Aug 2026 15:55:33 +0000
Message-ID: <IA1PR12MB9030BE8DCE38D3477F565EF3BDA42@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260813130623.2499506-1-mhonap@nvidia.com>
 <20260818095151.252195-1-junjie.cao@intel.com>
In-Reply-To: <20260818095151.252195-1-junjie.cao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|CH3PR12MB8755:EE_
x-ms-office365-filtering-correlation-id: 581c9310-3c37-45ba-f601-08defed377b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|7416014|1800799024|22082099003|18002099003|38070700021|11063799006|4143699003|10067099003|56012099006;
x-microsoft-antispam-message-info: kqpegqZvV0BIK6dOw9FmOp1zeaR2DDxIdtk9Rla/YjGcTfIJwDisWbrRnfSFPoQybBFNhFwyp7/II5RHkp1NUzIS1v7vJvRX6zbZL5xtKu9VHRvZudtRv3QNqJ3DUywldcVZCLOi8fs8olmuSnlbuIRD7IENF4gLcEGMMcnVpd2wYpJHgArd5th34TSo9KUxu6HGRNutPHFUTD3/jQ3+pigLehU/bqW6rpmSKyS7cWADfK2V6Ngg+zAbQezFOORxx6dA81eZvpc3X4Jb+7lI6AU+0HAhIjowDkp6Z8tIX25jmNxWtNv1zpvXpc4yEaXPxlgK543RYGVnHBUz7YXHSBFVILodauK9h5R85ou8ct7EuFUtn34aJbCRZWxy88MiqkW4r3a3XUBWhNvWojfzlshM+gH7bMh58l4A2OJxeNq5dzaKfaAbZLsEDzqtP9VR9DRSxbLfCIDmcssxrt1poM1uh8+qVSblM7WRSD7fgEKje53AKl4YT0By4H2o2wUl0UPySOZlAyz/egcqeYZe/XgDQ+NzW7pYGE1Yopk7xr70NIjGvBi1aSLq3wwnn4rDmUHnTZ5gPU8zXPvqFTCZHySFIp5oM19BuCHNZlDP8J+nB2d2DAHT/zp9daO5xIHRmH6bBCiXnH1Zts+x3v7ru23uA2U2uc7EJl/ndezrdRp6BKpcHpRNIl3ChLow/se9dj7EH186ZIOir5SGBWtLrK/MU/St64xNVxmT4oGAY34=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB9030.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(22082099003)(18002099003)(38070700021)(11063799006)(4143699003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aWQyl3fo7Jqsx7vX5Yog9KJeSn6fSKbo5QaFiX8RfmGeBxd4ERm5pEK7jzO3?=
 =?us-ascii?Q?KkshYHVko5abioNhQYLpPv309BTMTzx6U6x3uo6V9ej4wGnnff4E2l0UeqcE?=
 =?us-ascii?Q?Gy11M1pC+/Cu5q4R6ptcoxBqSLfk2iVUEs2GlA2nbbAN2J2QrIDsgdP5PEzW?=
 =?us-ascii?Q?5hzN/OGwFXQEx0d3o0HYY4uKVnHqRuBueAKASdMyCgdUIuvVs8TRgB8bFwAx?=
 =?us-ascii?Q?fIAZFVNO20zSg2MfOccO/NQtrKPQVizNgprMq544MGmz0zPKS4dYPje1TPfY?=
 =?us-ascii?Q?tN1ILWuar9fG0KmAYbeNRi7VydqO6bXZuapTB8W0v0D7aNx/B/rtPpq+T0/u?=
 =?us-ascii?Q?R3g5jJlt4VCQfr888Qc3jryZKd3ajRg/CFcGEJvi6S76bgS5QZpllm1rAZsW?=
 =?us-ascii?Q?w9HAvyUFWz0rplsauu8+sG8f3VxmjBs612GHxmKsVSSzJwGBJbTB7yy56uU0?=
 =?us-ascii?Q?3+lsGoW6OP7mtbxWR6myXSg5qggkomOqCsJWi35yWqkUACXgpZrz25cxm0oD?=
 =?us-ascii?Q?TrYIkyDhGalEcToSxFRTYxlJoGVchBrRqScH7EPDpdEnw30651HwSQmDMVB9?=
 =?us-ascii?Q?MRlYAIIKFPFA4ROzvo1iCANlEbHG9lvHV5L5Pn8GT/80FnhVgTCqBJEs4GBc?=
 =?us-ascii?Q?Mt51BXiWn98KwnzDSCz0t8oGpQb6AX94d8OmFle+JbC6kGXaZpm9G64a6AVC?=
 =?us-ascii?Q?oLe+fC3fBhPO5ZXviMAI8nvL9QatJQU27xSI5ADiFp4M/p8NG7YY4HhVkMpq?=
 =?us-ascii?Q?hFou9hs5OJ/qVIZIDMim7EiHsbdXNqsuEVsrKjjS8ZWjSwEctAsLO2bJh7iT?=
 =?us-ascii?Q?yZO6rWjMjBvFiK1TbkKivLuH1jVGlLzgZ/pD2QBq3tGVLK93geKpAwlTpV9z?=
 =?us-ascii?Q?DLaVB4VmEk56qKu27V7qQuR27IJ9mqJAgcnYoMiUdrO1l96ctk/nhAy34TvG?=
 =?us-ascii?Q?lju4xFN5nAwjk9Zufo57Le3N50LIvejq+XDzFLl87gIHQa72QBb0XxOyvTHC?=
 =?us-ascii?Q?83JSVsK4LOIo64NWs5tVobQKR6BZP3F8hGdwk9540TCJ9lAaonWriCT6JwjT?=
 =?us-ascii?Q?+Yy1SvIyhlRGfLB/eL1/vHfU16qhlDN+fAGpl4APYlwJ7qGFYm4RzWFEb9uU?=
 =?us-ascii?Q?5BR2iKqhWeO9lU7cw9ZDHmCV3Aa/YrFZT9/mjqt72LeYcMSc/flw9RtsTGLI?=
 =?us-ascii?Q?PhAg/eyjfQi7SZyUvBbOHfHs3i7vVYi+Jrb3whV8Tx2RhfOvd09E/VA/aN91?=
 =?us-ascii?Q?PlXWUjvOv/qXWn66kbM5hjsNyND90NVkMzFYRHNlhbZlpGHOl8tikfZbFYHq?=
 =?us-ascii?Q?q2x2sgpS7YnyxJcrp/XOxiV+4G8yDSNmuhaMcdx3jxPW/9SKjyQ6KjcqHtpf?=
 =?us-ascii?Q?V3/mHraxsHqxj+bkK5kjBytA9a0dDunVy5fz/G6OYIAwHUYnBBIZuFlgP8l7?=
 =?us-ascii?Q?DjKMbjY6eVIWyAMvxcaLGD4vb2/itrm5a2SeWtO0pcONHadrnPQQyk9XBfV8?=
 =?us-ascii?Q?bl3mCMHgraQVwotJnUYJlhb7CueN1cGt436K3+6Qq9nAwb+6Y79xaeKUyYXI?=
 =?us-ascii?Q?PP3u7WusMySz81NdEcNXLMY4StXbwPmP2Uu3NExum+qVZ0wZ9bewAhLWpdPn?=
 =?us-ascii?Q?E7xid9vOLHyeLYwI/KAWbkZS0LNGqrIsKUTARWq/rFkBsKOKFq1TQJlRNIFm?=
 =?us-ascii?Q?BdBlzsqk+rrawIFFHrMgLsffr/LPlXU5b/iWrATZRCBKByh+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9030.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 581c9310-3c37-45ba-f601-08defed377b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2026 15:55:33.3269 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X2bko1akYoW8GmtM73bSwJnRIb842iakKCb9GdUz7Ci5qEDooFPJvyu68R00JXHW3gAXM3TSZuHHt9g5C9o19Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8755
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=mhonap@nvidia.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
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
> From: Junjie Cao <junjie.cao@intel.com>
> Sent: 18 August 2026 15:22
> To: Manish Honap <mhonap@nvidia.com>
> Cc: alex@shazbot.org; Ankit Agrawal <ankita@nvidia.com>; jic23@kernel.org=
;
> dave.jiang@intel.com; alejandro.lucero-palau@amd.com; Srirangan Madhavan
> <smadhavan@nvidia.com>; pierrick.bouvier@oss.qualcomm.com; mst@redhat.com=
;
> imammedo@redhat.com; anisinha@redhat.com; pbonzini@redhat.com;
> eric.auger@redhat.com; peter.maydell@linaro.org;
> richard.henderson@linaro.org; clg@redhat.com; cohuck@redhat.com;
> Krishnakant Jaju <kjaju@nvidia.com>; Vikram Sethi <vsethi@nvidia.com>; Zh=
i
> Wang <zhiw@nvidia.com>; qemu-devel@nongnu.org; qemu-arm@nongnu.org
> Subject: Re: [PATCH 00/10] QEMU: CXL Type-2 device passthrough via vfio-
> pci
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> Hi Manish,
>=20
> On Thu, 13 Aug 2026 18:36:13 +0530, Manish Honap wrote:
> > Base: master (post pull-9p-20260725), commit 6333226c2a.
>=20
> The footer's base-commit is 055952c0aa (the pull-hex-20260812v2-1
> merge) and that is where the series applies; this line looks stale.
>=20
> On that base, cxl-test still passes 12/12 and bios-tables-test fails two
> cases from the new pxb-cxl _DSM -- details on patch 10. Comments on 6 and
> 7 as well.
>=20
> Many thanks,
> Junjie

Hello Junjie,

Thank you for your review. I looked at the branch commit state and you are
correct - the base commit at the footer is stale. I will rebase onto curren=
t
master and regenerate the patch series with suggested fixes.

