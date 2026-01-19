Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B34DCCF2C5
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 08:37:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhkkq-0007YT-6y; Mon, 19 Jan 2026 03:36:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vhkkk-0007VX-Dj; Mon, 19 Jan 2026 03:36:50 -0500
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vhkki-0005aY-SX; Mon, 19 Jan 2026 03:36:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cLlsRkk4121jZvyg/FWrxWh4h7933HcX4UWUwckh/Nw3fCvHTTvrHYr850BrmsGIxAzhUMHonMUYU4ErjUqXfcSkCAqA22BW+VhPmW8TeBl04ZVtAil2VQgJnZ9n7SEwr3hHDk7MXDp5OYfFMFwGFEuGUKZvaBycHLjzbTYwlryX24UVWZMTAtnwdMfoY5qYfyTVmksZdTtoNeJrCHP1efrncFZ9vQrC3IrN+hNgKGOTEovda2loi2kURzZwMYlzqb8Wok0leMrBs2oqLGuRPWdSpW4FWvvH2l4XdrFMG8BjnVSjhRgCJH+/UWwyNWOMcop02phz2RvaKbPozhGNFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VfdfTOPt4MopyJY2T7+G5cCmMV4WTbKjFrUrOEgK+NU=;
 b=fI1mRjrcJUv52E6pt0blDEntcrGF+MZZUUbDa2wXbFQhZizII/4IrMOmgK6XSqeBa74XqfahEQl9wgsXSvakFmHF2q1PLlzSPIUUgVLZkvNpZNR63ynqgqKH+2/KmvM0VV4xO9KOhLbIfq3pObtU8tgTcq5cgB/uGx6jfvtEoWkns9zWvdgsAhW1NRKWQWWT7NvaX6+wksgVCtEuTrYq5Oj44cso+GURY6oz0xUI0dzsEToynlJ60nhhc1sI0xGFLfn4vltBbU8/BMs/k54nD35VuyVEedR9W5GnJftjE9QW2y8QFxb76lrRIIzaUTRJvBt4ZLdltIhEhTZZH94kLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfdfTOPt4MopyJY2T7+G5cCmMV4WTbKjFrUrOEgK+NU=;
 b=pH0KtKKIuam/7GyYRJz23mUho/1Q3ZsptsBK8LjYAiEqBsE+wuJ3TAOk9bcmL++I+DUwZzac7ahO4mBQCuT9A7VGGj1U/MTSbrjUcWk3TB7Z5kthsA7WRlGWOeaSLKNTWsRTa+u9FXEUHreZXZsWD8SUoq/PDtfwoHwjjXC8W7H/dPckhwTCwQO+7gXUYBI5ztleDCDh5PmllEErxh+GxUzl0pn7psKBpdBblrhOaVXSdt0CUakmesT+zqdNSKulBLzGgD/7BY+2PM3cajf91ctcuf1LEVzs4Kx1z3NNlhk4N3OxEbfRI6R7BewH1zHsaV3fEDj2Wxh0qDBOVkeykw==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CH2PR12MB4152.namprd12.prod.outlook.com (2603:10b6:610:a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 08:36:41 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 08:36:41 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>,
 Nathan Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, "wangzhou1@hisilicon.com"
 <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, 
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v7 00/36] hw/arm/virt: Add support for user-creatable
 accelerated SMMUv3
Thread-Topic: [PATCH v7 00/36] hw/arm/virt: Add support for user-creatable
 accelerated SMMUv3
Thread-Index: AQHciRwfDQFIat0mIEueFhGIHGVjs7VZKGWg
Date: Mon, 19 Jan 2026 08:36:41 +0000
Message-ID: <CH3PR12MB7548FE8A47AC85B80754C3C8AB88A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260111195508.106943-1-skolothumtho@nvidia.com>
 <CABQgh9HD=2CJC2n5_h0vwFn3yr3SKbvTJWKGqWBo4ppSFgjj3w@mail.gmail.com>
In-Reply-To: <CABQgh9HD=2CJC2n5_h0vwFn3yr3SKbvTJWKGqWBo4ppSFgjj3w@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|CH2PR12MB4152:EE_
x-ms-office365-filtering-correlation-id: 11b0ca4a-a900-4f21-1a33-08de5735decd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?QEDGIJ1zMgeRE4GuowFI1no/boidYKNIzNhIYTpQB9IFFovodvcIMJuNyB7j?=
 =?us-ascii?Q?ZOqd5fqbRD8IWCbhWckX6OgyaRC2XTMuixCoWOQU4aziR2x5bztHiYc/lUMB?=
 =?us-ascii?Q?mGrwezSIh6RJojDzM5eycCzAQ7k77wxdvS6/8UyLX+POpRODGKG4CvYBQDqL?=
 =?us-ascii?Q?Rqi0GEcXBDXBhg6f5QdxATjGg0m1weM53Z/CHN9+7w2gGb9XKL/6ds3+jlOW?=
 =?us-ascii?Q?YH5curq34GCyFZqvA395PpZIjF87N63kNbdOTLDoOiPEO1FnXs8OvSO7bzRZ?=
 =?us-ascii?Q?7hr+KFl3XO2G7FbNaeyxxxPvEZdNw51ZgUnYgBn2/0Mqil1bW5qNuJT+HCou?=
 =?us-ascii?Q?in2kb/Wd5sDiI84RXE2Sg6wooa6uFWeEOGvysM+WOPyKwbiLEJJkVGHJ5p8c?=
 =?us-ascii?Q?k1hgWsnWdOytR2KprGk/WzXJlPFFhamXxm7h007GAaZAwzL7x04w/f/Dkeml?=
 =?us-ascii?Q?QR4UsaE9uJ4DUKO93xMwdgDsKWbgg8dPNU3BWLLpBNo5rQkTrRAzXlIdLSPO?=
 =?us-ascii?Q?h/er/H+0dJECZUGm1xlHMYPEO40+KEglwxMAWxGMQD4g+dHephfavlbua7XP?=
 =?us-ascii?Q?GpHviqBQp9C7EkE8yh2bDFyylrahavhxT6EHHTQ4wbLC9bxmB3EC8lUPqJRI?=
 =?us-ascii?Q?RKlJzklGzd7S7cVsILo07j90/rp/Ny5eqRDFw38AtOI9fU2wc0ZNl9vEEEbe?=
 =?us-ascii?Q?unCLckZ827ZhK9fqdox7Oz3O1QULaD2dK3gazxU00egrdDyLA1tCHaiQbNnI?=
 =?us-ascii?Q?UaCVObWJslA7de3fwKWa/P4eI81xRt5J5632PjHauNcBcXJoCIw8GtSYCNj7?=
 =?us-ascii?Q?+PuLM8m246N4q+s2KIvUh19SpD84Xti+laiiK0L7q/BynyhRRl4TLbC8BMWX?=
 =?us-ascii?Q?hF5mpYyy3Nwt4Om7tr27TSatVJDUn/zXwFmfcotJqGxmesJ/Kkq5eB/lDPKT?=
 =?us-ascii?Q?NmA10MUAxuLyzve8/4gz7suK4KzdgcZEBUnJqvPTqI6D/5LWlTpN84qBCbqQ?=
 =?us-ascii?Q?0diSF/A6/DNPFO5J8/PKc7nZQIPdx1j/omgMmtiN+8EFYgUTGpxRKcdQHhY6?=
 =?us-ascii?Q?Y4bYIqPBdEeVWlIlGuj4BG2mRTmtB5tMWL4vKyyUWGVte5Q4ba2nwelcu8i7?=
 =?us-ascii?Q?I+FGh+Ydq9uy0MHN73XiL98PHA0VQCcHl7bQ0MQ/iS+/+hebAm4dyzwomva/?=
 =?us-ascii?Q?FysNwu8j3fX/ki31/glNXxhkmJBlkj4+dH5g00Y3WV94HR4ohHmZnq0fzB1B?=
 =?us-ascii?Q?HTwm/1K5FWfTFZl8Is9OiSAbzANf+n+NnKLuXOKaStBj4r8Ls9vbZOoaVdia?=
 =?us-ascii?Q?PnpjRzE/VfW9P4Ot/chIvwQZLH9OCJg9Y0EiebhtK10PZcTUHRwBXUtIQz/w?=
 =?us-ascii?Q?Jmgg2lfTbBSdPheJcOe4hq+0SiTYOTv3/WOKbdg1bwqO5t1aH6ZXM9ZKE/QS?=
 =?us-ascii?Q?Q121hbQ0UQK5mrmzQ4XrMGYfqXTozwHMFIocE9j2BIRD7srSH7aPryoBqdLY?=
 =?us-ascii?Q?xFr0w6ISirRS7xkPCHj5komx53pBdrfnCNGrmsziw5mO+yhDVL5ruKpl57/v?=
 =?us-ascii?Q?1dOB8TDhSBXNvrlkf6g2gOLveI2JX3ywY1G7P195c47gtJZitrQ4VD9vMDyL?=
 =?us-ascii?Q?BvIeYfwbpz5dmyeaHS7XGpI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RUyd2mQQTsNOc8Py7m1JnYXei+HVML12IaIkD410yiupe9x6rwtJOtfU5ahX?=
 =?us-ascii?Q?OvrdYpK40dzaleick7ldcf7o5N5Nj77RgjeEQqZEzfr44FEZr3ijNRNaP08m?=
 =?us-ascii?Q?dK4RMMNaSNheCDCVFX8ESgz5xpfZhpAKpmtiw0LZDhIM88b7AL3CdgYiWdQd?=
 =?us-ascii?Q?/ORv4bYBHhD+UE0OiGjBrbN40iTf++2zgLFf/SbrdfRKcT62iqDqGyamNWCO?=
 =?us-ascii?Q?Haya0fDiapz1GPsh0HPj1JoY7+TLRb9beD57BO69zNPvseZX0nj/eaV9+j5g?=
 =?us-ascii?Q?yrjL34Wep2jKeG3IE7emxi/QXltISuV+29W0nfmXG7OyjI4+t/jscJr8Vf2k?=
 =?us-ascii?Q?7h3tdSBA9WEfPwOpyLe0kQlln7Yu71xugZiBi5h/pmt7Tzi6nBGNnXZFCkuK?=
 =?us-ascii?Q?e0DaQK5Ca/d3x+HIOoY0WTfFKUzlUev7DjvnbnlyBv0VNgWzHXF6spT4xCDW?=
 =?us-ascii?Q?YIrTwrFTy10V69Jqqx1Qb0WJ3RQc5PZ/6iXQjVzl55+kNjhJLFgXs6PZc7Xf?=
 =?us-ascii?Q?BOLBKgXSlWHFp5qxxheCoYWq9+854wLVFiV5rIjLS6GqY6jw3fiSdlgJMqmS?=
 =?us-ascii?Q?JGei6s7Uva2LoczLLiLRi6nctWGhVRC616BV7Pow1X599M+6PHogE/1NwFTo?=
 =?us-ascii?Q?/SKp7UEON2rIh8zOdlARZG9+E4EXf5lmCOnC2KjIjwvDjPV199+SdaVkeISj?=
 =?us-ascii?Q?eJnZwciAoU/yPS3I+ClULDAwyK9qWUQgO0gSqennW603OpyR3ifmn5M759Qd?=
 =?us-ascii?Q?R2OjQtY/AR9tyqKq+s8hQpUwRRa6xQ6Qedr2ZSZooQwEJzwgTjrn/sYVaitH?=
 =?us-ascii?Q?UlY6N5bcKiW7Mt5SZgwIwVBfHxrEP/Lurpm/IOmoCXUCPFYGKMPTi7ysH8MC?=
 =?us-ascii?Q?2AozshneWu39kz7I63uvAdF6EZ8X7nqn26pJLAeWtTiq8suVxDqQ92iJTN3o?=
 =?us-ascii?Q?cXUCezJJAp0AfN30Pbn6pa1gVgPh0RJKi7WKg1YvNN7cfuPt33oRtMATr5lz?=
 =?us-ascii?Q?HRItsi8xSZKmSTg9664Uvp4TbVJtYYXn8nK3oRPn+tdpqcu5MvH45LvfwpV+?=
 =?us-ascii?Q?vdR3bgxNZpzKeTQJd3E8cMEWp71syIrWm/uIVoYfTIFwuiZjTAkLGlnBqTq2?=
 =?us-ascii?Q?q740jOCRDQs0Hb/HvGvX1mkkbMGn43ckGDVCy4tdSq118FpgFuADqJxWqG/d?=
 =?us-ascii?Q?3isBSBrauUeGavKtg8QZft+RNMZsm4w2LQfETR/L7mMopPibvRtnweit462U?=
 =?us-ascii?Q?MxgyVSZQeGac/PU8msuZTtcM/qVlourNm1ux8M5FoC+HKblB4xHfjfiZ0CTg?=
 =?us-ascii?Q?aBMnbsgdDGGnBHb8jNAY0IzNLG3dClUJjG8l+6L/WeW12Q3k4bAtvt/EEYKx?=
 =?us-ascii?Q?AgpCsVkb4dUB9PpKrkmQq4SwBEKUsstO5tDxlF6moB7Jz6jjQzpu6DiHjUfj?=
 =?us-ascii?Q?vL0Fznbd7m7aRpXKsvGa0BCN4XhhMTUg3RyTSzY7hDIMvk3vPke/HU2LBKrw?=
 =?us-ascii?Q?Ue4p/mc6QiVt1NeGi4t4ymEz/hUALBv5K9pL9GjRVWtlshq03VVaBf1NQRt3?=
 =?us-ascii?Q?JAW+uVzRUzZ3Y4rFuAh/mh+Oj9zcF25BZ3+XfvysCifW4tqoqIs3DTcHjTlJ?=
 =?us-ascii?Q?LNCUm7mLzlUY75i3Z445SDwHyqlTfQq+S6WqJneq1UrX1KPbve57myIXL5uf?=
 =?us-ascii?Q?vEf4Zwwpkb4NwZSOgqzhM8nFAtC34njOaWc5eLkagf5L+VPBXxj+gl6dt6Of?=
 =?us-ascii?Q?hU1Bx4P6YQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b0ca4a-a900-4f21-1a33-08de5735decd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2026 08:36:41.5765 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i+6FGnQTMZO8L0IPofFSuhZqkYYNzznLHUt8eWH4/OAE8I78V+eZbYSwRr+0Ng4eerqD07xTbeAwI/J4u6yFOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4152
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.077,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=2.399, SPF_HELO_PASS=-0.001,
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
> From: Zhangfei Gao <zhangfei.gao@linaro.org>
> Sent: 19 January 2026 08:18
> To: Shameer Kolothum <skolothumtho@nvidia.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; Jason Gunthorpe
> <jgg@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>;
> ddutile@redhat.com; berrange@redhat.com; clg@redhat.com;
> alex@shazbot.org; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
> <mochs@nvidia.com>; smostafa@google.com; wangzhou1@hisilicon.com;
> jiangkunkun@huawei.com; jonathan.cameron@huawei.com;
> zhenzhong.duan@intel.com; yi.l.liu@intel.com; Krishnakant Jaju
> <kjaju@nvidia.com>
> Subject: Re: [PATCH v7 00/36] hw/arm/virt: Add support for user-creatable
> accelerated SMMUv3

[...]
> >
> > Please take a look and let me know your feedback.
>=20
> Thanks Shameer
>=20
> The whole series is tested well with Shameer's fix of patch 33.
> Tested-by:  Zhangfei Gao <zhangfei.gao@linaro.org>

Many Thanks, Zhangfei!

I will include that fix in v8.

Hi All,

I'm planning to respin this later this week, incorporating the fix
mentioned above and the other feedback received so far. Please take
a look and let me know if there are any further suggestions. I believe
the series is in good shape now and would like it to go into the
11.0 window.

Thanks,
Shameer

