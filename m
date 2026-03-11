Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE5801125825
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 13:59:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0K6D-0007EW-LN; Wed, 11 Mar 2026 09:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1w0K66-0007CE-8l; Wed, 11 Mar 2026 09:59:38 -0400
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1w0K64-0004he-6M; Wed, 11 Mar 2026 09:59:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CwhBKKWc+S7yoSBMSm76iMadI3XeEC1lLpTntjffD1tKXEAhjDxyHwZ6Ga2XF4l6mGwrDTP3N5ARxOwVHYzhZ2zQflZfqUCECc6K4TGohfYbKT5XaLalqvJdzL0yo9p21b95PL59G5QC/N6ymyiXul8Q4x20hnjiCcFI06WHAeLaaueTXlsGKceUb26HtZFk/PveuV9etzothD1UyzFM+L/yDvfQkwTCx152GO4op7hUmzjrhSCGX5F+E7i6E2KYMOsyydqifokJQ28Flx11oDru+zcaaAfw1Gjc2Ld4//AqOhVqToZIdbaJKCmGPN7Cnx8XwNUfk26tHdZVMoFtNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fb3fHbukx4VGa6IZXUDQtg3E8cYLrSf+IGxuuYOusRE=;
 b=iXdrgESzK0y+zXehvgePh/CzXuxKmlQTxoUzACcKdni4rQheqv+Hy3JAx9lfiGJImnVcDaIfA4KueOrDgMYRA4GBQ3fMNNU7n8GyzJ6asH4dH6K7vhIUb8uwRUgZGv3hlp1Gt+XgmxCebkFs+15qcHsGfmnm3Wgvyhf7LJo5TwKSTMHtnftcKeRUWb9TLxxTrxLXUgrItii1shQCiVyW4pxYiOfg5bYyTVdorWAdE3sZjirSXKsaktiBYGFxFasse7HhoYVAEoBzPbEyQESGf9Gktf0Ghd0b1yVn5aewnhqsZxzYROmMbGwp6C66oqEQ74YuKKr2R3C0TjX8cDGfWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fb3fHbukx4VGa6IZXUDQtg3E8cYLrSf+IGxuuYOusRE=;
 b=UeyoW109L0+vKH20jef9DxWKRudTUUuyjAxunbCT4+FVEZBAuO+VTV3NNiknia3jUd3Ll9Gu+QsCQIUGhH1vzh6DT4YFrJYkyzJsLHqMCverSBeIv7APhXKMeoL4YkPRVCLk8O5RKgpsWVJdaYkgCJOrt6SeHB8AmPit2eDoKnMg3N/D8RlkvDzaRGoGTfeO37WQkHAZKwS8IB3+ddqPjPKrrG8DOY95GdANT43ClYfnoTLm3B1p5GbWQo6xraWt13CIFMg7TZISqPJJCKjy4iF63XRq2hs1JgftCjjHth4ntMdFNQB5QczqX/B+uvQHIeulwloJtY2bkErYzM/gOQ==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by SA1PR12MB7367.namprd12.prod.outlook.com (2603:10b6:806:2b5::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.7; Wed, 11 Mar
 2026 13:59:29 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 13:59:29 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>,
 "phrdina@redhat.com" <phrdina@redhat.com>
Subject: RE: [PATCH v3 17/32] hw/arm/tegra241-cmdqv: mmap VINTF Page0 for CMDQV
Thread-Topic: [PATCH v3 17/32] hw/arm/tegra241-cmdqv: mmap VINTF Page0 for
 CMDQV
Thread-Index: AQHcpw4RCbTPqX85HUillxSq8Ev4K7WpCqgAgAAKhZCAABnNAIAAJ8xwgAAObICAAACicA==
Date: Wed, 11 Mar 2026 13:59:29 +0000
Message-ID: <CH3PR12MB7548AB5CBDD893E34F4542E7AB47A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260226105056.897-1-skolothumtho@nvidia.com>
 <20260226105056.897-18-skolothumtho@nvidia.com>
 <22acfd93-72cd-49ca-b2f6-a080bf66104c@redhat.com>
 <CH3PR12MB754885F68C4F08CC39732EB2AB47A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <8ee0ec15-bf22-473e-85f4-96426a9e763d@redhat.com>
 <CH3PR12MB7548CED599FE7D572486BD6AAB47A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <641d5a7b-e487-49c5-abcd-4efce4cfd56d@redhat.com>
In-Reply-To: <641d5a7b-e487-49c5-abcd-4efce4cfd56d@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|SA1PR12MB7367:EE_
x-ms-office365-filtering-correlation-id: e19be8f9-887e-427f-e10d-08de7f7669fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: xw7j8cRQSQHepdJwQi5eeHg2heuDgFVe/SmTtvKMgaI6FjTsRODx4GIS+P9niVR8ucxBmST9ipkch1EYrrmJc4sX0nmngGXGDUn7Mm1aydkgp+QbvTWEz0tzVZ3PKbOnS8jXiBTadjGVgJ/hPnul8mWhVAexNcRwnW2PKOHTszrUFhLEeBOUnOYbbjrX/vcGCygFbimbFPlyL4Lqre/x+ens0Gc4GMg+3r+bynCmrwNztJsNM3gqMMF98NTXuD2Dvcza4GCYZoRlQ3n9m41pTZQVzZGYGwXMDNH6GDEXk3lMJTtaCRi+ITEpb/J7bS4PFx/nfC4lub9Y1jAR/+9KGUlylunmfSxfC2tbLBVHjs669tfzWgOh6K3vjE+wuFJ1ZAm0V6tkm8dElbdvcDj3OV573mXEIdLxRG/5WAxkk2cFfHEQO/5Gog7weaxaNQTezKyKRid4rF5C/EOIMmwxAaOC36WW0YUfba9vJms//WbDahHGmxcZfjHqvPTXN6T3LctyM4oqoEf3ACGCBkjqWQuwbodpMly7Gq62BNO2osxhYa3uOJoI4bDZE7lh7u5NKw9EzzpBEynAdwvd5xbSdzD8mQRX83wl0+RZwcDrrY7KmhibpuX199ux/wPbLMy7XcsG8XsiywRdZqltmIiMUOqv6sT4sXH+VxvZd0wE4qYieo6Ow6s4OnqRpOhKdsHQhRiyj8WwlpLDAYkabzvG3Y5X26rbjvEZn2cCd7G+neeqYa5UeO1sUQ+qcUPLHg6L3hONcYf44pjOAHff5Y6FlrW22uhToM+ufusXUXIKzFU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?U5avAApIjgzhgW4kYltpVXdId9/U6O1c1euFxBaZxfwAaL3bZa++8ea54R7c?=
 =?us-ascii?Q?tm7HX1hqICWW7ZE/kuqWtt9butqWrpePX3capX0slL6JEfyglxc3rgTb2A8J?=
 =?us-ascii?Q?yp8OvVdE7eJhfWx3jO2K+4rpT2nguETNmmDSpotxt5RtAlqO5JsUkmWntr2T?=
 =?us-ascii?Q?FQJhBLV5wA9CCpwKKtlC1slPDsT0sp+Dmg7xLuI8L8JjxatneAK+/SjVde5g?=
 =?us-ascii?Q?9eGrvTgmgb+buTzJ4qNE1JrlXfWcroqXAHW0S+1aWsOKPTtLnAQnDS30TjB1?=
 =?us-ascii?Q?umPDmtLE3Jd0nZyw5jwljHDPAXUj4sCSErY8pnZw0NLiac7MZSgo63f4zQCM?=
 =?us-ascii?Q?xzfss9WGkUnMtk16JyQHsz7LJxwbpMARoIXr+ubPYvjtSHyl8UdqcgSUlRID?=
 =?us-ascii?Q?pOR2YulBexM5aqgTVpbHcDqEdAa04H+YyHcpb2WF/+eSGGNHKR+beAWRojvh?=
 =?us-ascii?Q?PUfzSqDk8prjYkO+57Ap8Lby1rAfoZRYuUdIMq/mZDjaFkOWs/S0c4VRYGrX?=
 =?us-ascii?Q?Bk86MY8K3eMs64m7jtomfsnVayqVkiQ/IJV2i+miaZWq0rV/SSVht4QI28lB?=
 =?us-ascii?Q?T+P3kxfOtRHIrDlffXLE1/RTIvv2t0++LH8gPd2ybJHYvaAvbWzpbYmd89G9?=
 =?us-ascii?Q?/ByvHuJ6kvZT+EO0Ng6Z8cuit+Yohv3mwaVzDAaGoVQmMowcT4JF+g5GD+tm?=
 =?us-ascii?Q?VSl7+nWXkvHeoTu3YbRKpqGkHp+KBMvXB/61HubbCcs3diAgRFmUw23XvFAf?=
 =?us-ascii?Q?NOoM61Qy+etXFuYAuEfC/LVDvuH9u+opPHMWzWX3S+9WqrHN/SOUcc1k02VQ?=
 =?us-ascii?Q?qG875kbAYiGz6qcS8POy+AXMxaI9zrXmlS8pgva5FCxn64xO20JHdHi5e+Mc?=
 =?us-ascii?Q?ZrT9yJu+vtUjZGuf6sQhbYksGLkeBGRlK+4XmAS2onVG/gNzozwpQFk1n/80?=
 =?us-ascii?Q?3s73WZ+N4NLX51Se3hbpYlQ2n2f/fgMF785XFOyJtitSYS+QEEJ2ECG6ADp+?=
 =?us-ascii?Q?eaMYNBz/TrnG9ik7NKmwFCb11CP7sx0/7CUEUt6BqNSmYOa3+6HQIUBlLzyU?=
 =?us-ascii?Q?8lUzQPqf8V0Qz3NpJe/o7g2AGcMP9bYGoNw1LCjYdiKvlMkTnDbdj248ctTc?=
 =?us-ascii?Q?PKeQf06279fD2YqXyK3adj+QZflpESGFCF+8Ke1zIyeiJpZC2NaDGupgooqy?=
 =?us-ascii?Q?wD4kK0+HwO+ebcD/b6yCQ0GPqTPdIo988K0r9L+X1tWOwvIBsEB9bq0KyRZZ?=
 =?us-ascii?Q?zstkcozhYwlouWLT6P5SA9wf/pTAULykqSJQbOt5FWvXMG9WoqMrVj+W2mSI?=
 =?us-ascii?Q?VKWfT0ITullzW4tiBRzTtbSpHMjjuuineKP0BUgyb1IKrWDZW5DXYZ7svkUP?=
 =?us-ascii?Q?3sLsylyBLlgEqqn8oWzqqkaJ1eB7TkXDu5uDceFGEnf4VjoK/W3wER91i76p?=
 =?us-ascii?Q?3ukx0Seroe34HdyzXTG9SSz5P9fOdlj3KZLOUH0OjV1KuV8M6auszn/ScTf+?=
 =?us-ascii?Q?obe9+WaB1xivR0BDTfU+2CJzheFUdT/8NI+r0RYyZnIY3bm2AYrFbCQ0gVHa?=
 =?us-ascii?Q?ClvcTMT4ShZG20oG0sJNUbBxigQaqIS6BliqDUX7tXKytozsB9l0RUK5RbhO?=
 =?us-ascii?Q?hXnHVOiNvph8V0Iqk0L3rvm7UUkjO3mZh92O5DfcttnpXzozAhbu4RFrbDzc?=
 =?us-ascii?Q?pJ+8YSxyyFz1ZDYVfAwAcsZ6bQehnDh/NsPJodR7frd7ZAs+vqjMvnmDO5Fu?=
 =?us-ascii?Q?mVDiFUcO2g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e19be8f9-887e-427f-e10d-08de7f7669fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 13:59:29.4212 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EKXOk6G5uBWEOGUkbvbUABbmVX50z8AwgU/9OP3gciQyU9s54wKICId6pteGt5qqHhutHp1zkHBcs1S0pQe52Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7367
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
> Sent: 11 March 2026 13:19
> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>; qemu-
> arm@nongnu.org; qemu-devel@nongnu.org
> Cc: peter.maydell@linaro.org; clg@redhat.com; alex@shazbot.org; Nicolin
> Chen <nicolinc@nvidia.com>; Nathan Chen <nathanc@nvidia.com>; Matt
> Ochs <mochs@nvidia.com>; Jiandi An <jan@nvidia.com>; Jason Gunthorpe
> <jgg@nvidia.com>; jonathan.cameron@huawei.com;
> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; Krishnakant Jaju
> <kjaju@nvidia.com>; phrdina@redhat.com
> Subject: Re: [PATCH v3 17/32] hw/arm/tegra241-cmdqv: mmap VINTF Page0
> for CMDQV
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On 3/11/26 1:34 PM, Shameer Kolothum Thodi wrote:
> >
> >> -----Original Message-----
> >> From: Eric Auger <eric.auger@redhat.com>
> >> Sent: 11 March 2026 10:05
> >> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>; qemu-
> >> arm@nongnu.org; qemu-devel@nongnu.org
> >> Cc: peter.maydell@linaro.org; clg@redhat.com; alex@shazbot.org; Nicoli=
n
> >> Chen <nicolinc@nvidia.com>; Nathan Chen <nathanc@nvidia.com>; Matt
> >> Ochs <mochs@nvidia.com>; Jiandi An <jan@nvidia.com>; Jason Gunthorpe
> >> <jgg@nvidia.com>; jonathan.cameron@huawei.com;
> >> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; Krishnakant Jaju
> >> <kjaju@nvidia.com>; phrdina@redhat.com
> >> Subject: Re: [PATCH v3 17/32] hw/arm/tegra241-cmdqv: mmap VINTF
> Page0
> >> for CMDQV
> >>
> >> External email: Use caution opening links or attachments
> >>
> >>
> >> On 3/11/26 10:26 AM, Shameer Kolothum Thodi wrote:
> >>>> -----Original Message-----
> >>>> From: Eric Auger <eric.auger@redhat.com>
> >>>> Sent: 11 March 2026 07:55
> >>>> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>; qemu-
> >>>> arm@nongnu.org; qemu-devel@nongnu.org
> >>>> Cc: peter.maydell@linaro.org; clg@redhat.com; alex@shazbot.org;
> Nicolin
> >>>> Chen <nicolinc@nvidia.com>; Nathan Chen <nathanc@nvidia.com>;
> Matt
> >>>> Ochs <mochs@nvidia.com>; Jiandi An <jan@nvidia.com>; Jason
> Gunthorpe
> >>>> <jgg@nvidia.com>; jonathan.cameron@huawei.com;
> >>>> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; Krishnakant Jaju
> >>>> <kjaju@nvidia.com>; phrdina@redhat.com
> >>>> Subject: Re: [PATCH v3 17/32] hw/arm/tegra241-cmdqv: mmap VINTF
> >> Page0
> >>>> for CMDQV
> >>>>
> >>>> External email: Use caution opening links or attachments
> >>>>
> >>>>
> >>>> On 2/26/26 11:50 AM, Shameer Kolothum wrote:
> >>>>> From: Nicolin Chen <nicolinc@nvidia.com>
> >>>>>
> >>>>> Global VCMDQ pages provide a VM wide view of all VCMDQs, while the
> >>>>> VINTF pages expose a logical view local to a given VINTF. Although =
real
> >>>>> hardware may support multiple VINTFs, the kernel currently exposes =
a
> >>>>> single VINTF per VM.
> >>>>>
> >>>>> The kernel provides an mmap offset for the VINTF Page0 region durin=
g
> >>>>> vIOMMU allocation. However, the logical-to-physical association
> between
> >>>>> VCMDQs and a VINTF is only established after HW_QUEUE allocation.
> Prior
> >>>>> to that, the mapped Page0 does not back any real VCMDQ state.
> >>>>>
> >>>>> When VINTF is enabled, mmap the kernel provided Page0 region and
> >>>>> unmap it when VINTF is disabled. This prepares the VINTF mapping
> >>>>> in advance of subsequent patches that add VCMDQ allocation support.
> >>>> So at some point we transition from something that is purely emulate=
d
> >>>> (page 1 global cmdq) to something that is mmapped on a host page.
> How
> >> do
> >>>> we transfer the state of the cmdq from one to the other?
> >>> Right. If a guest uses both the "Global VCMDQ registers Page0" and th=
e
> >>> "VINTF0 Logical VCMDQ registers Page0" interchangeably (and I see
> >>> nothing in the spec that forbids this), then we need to keep the two
> >>> views in sync.
> >> Also assuming the global VCMDQs are accessible and thus used, I guess =
we
> >> shall properly handle the actual commands (equivalent of
> >> smmuv3_cmdq_consume()), no?
> >> I don't see it done at the moment.
> >>
> >> By the way, do we want support of VCMDQs in fully emulated mode. I
> guess
> >> it would be sensible?
> > Yes, command handling is not implemented now.
> >
> > Since this is part of the accelerated SMMUv3 feature, I am not sure it
> > makes sense to implement full command handling in QEMU and then
> forward
> > the supported invalidation commands back to the host again.
> >
> > The idea here is to accelerate the CMDQ processing through the hardware=
.
> > I am not sure a guest would have a real use case for VCMDQ in a fully
> > emulated mode.
>=20
> OK but really the whole user model is really confusing. One starts using
> a "global" vcmdq and then switches to a logical one.
> On real HW I guess they are synced. But on emulation, currently they are
> not. Also when the guest is using the global vcmdq, it can
> access the registers but they actually do not trigger any commands. This
> really needs to be clarified.

Yes, this could use better documentation. I can clarify the model in the
commit message and code comments.

One option we discussed earlier to avoid the confusion was to restrict
usage to the "VINTF logical VCMDQ" interface and return an error if the
guest accesses the "Global VCMDQ registers".

However, since this is still MMIO space, the thinking was that it may be
better to allow the access even if it is effectively non-functional, rather
than making the behaviour unpredictable.

See the discussion:
https://lore.kernel.org/qemu-devel/aa8cJszkOKGLUYdD@Asurada-Nvidia/

> Then I understand we want to focus on accel mode but above points need
> to be clatified. I just wanted to mention that vcmdq should logically
> also work in fully emulated mode (and you seemed to implement a mix
> actually when you have emulated access to vi vcmdq) as it replaces the
> SMMU standard cmdq, if I understand correctly

IIUC, in the current Linux implementation VCMDQ does not replace the
standard SMMU CMDQ from the guest perspective. This is also why we do
not expose the HYP_OWN bit to the guest.

When HYP_OWN is not set, guest still uses the normal SMMU CMDQ.=20
CMDQ is only used as a fast-path for a small set of invalidation commands
that can be sent directly to the host hardware.

See:

static bool tegra241_guest_vcmdq_supports_cmd(struct arm_smmu_cmdq_ent *ent=
)
{
        switch (ent->opcode) {
        case CMDQ_OP_TLBI_NH_ASID:
        case CMDQ_OP_TLBI_NH_VA:
        case CMDQ_OP_ATC_INV:
                return true;
        default:
                return false;
        }
}

So VCMDQ is not a replacement for the SMMU CMDQ in the guest. It is
only used to accelerate these invalidation commands.

Thanks,
Shameer

