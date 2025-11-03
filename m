Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18808CCF9FE
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 14:20:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFvNv-0000KN-47; Mon, 03 Nov 2025 09:18:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vFvNo-0000JW-Ud; Mon, 03 Nov 2025 09:18:10 -0500
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vFvNh-0007Xt-J4; Mon, 03 Nov 2025 09:18:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CxGq+XQosgAnFPEFB+o16LK6S3IQTgjYju/kTYzh5MJfI92ktWmDPsrsJ8SF7sljxQPz8SOBrrHgEPEbQp2CPIyuRgxUQBz8yDkP0P5mceD6UNri29AQfnr9G7Od4P4v08O+vrxFZVRlzUCGIyMLwI/3CCVz+EwZiwXldAS2VvdHpMtXStKqIqiMHD8EwHmQ3yt3xCUoAQI/QlGesP0hjq7x1bvRB8XGOPIOrQrH3OhC+r6H5ukdhIq7REgs/0vMfjPC4ZIWHbhvMtkpx7LP3rxg7t3i8RWuN/nwZgOE+n6rgiev6cJ/gERgPJGg+RWLo0q623ceHrQnSQmenqENKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxoIhJ5nDWhJdf73YDnWQNz3YLnBj8Y6C3GF3lTIRuk=;
 b=eqs9yyhy5B0lTME4AKGp2skYs5f6P18V5miPg1GUosT+nGjqqdzfJF3rbeFdrVw7wEcoMR5YUL8wDkr39451aN2E8B2CZyG4m9Nt0yllz6eXXcBA2wJHNyOnM05M8Jnn+RoOmJyLppoHFu2Qmyjw05ReANB2H4FxH6RqvhukjdNo+IJt6pP4/6JstsJT3sF0DzSH4UTEAEquRTx3Xt9XwcI8G36iHAJPzwn4lamyvbrbsogz2/63kS2lNIGRPbopShc2qszlO3uRY/9Jq/waLLEEdjzDMQn6FiPxqZwqKn0dd4NtDvo7pacM29mX4Aw4P6gKyFq0DIwUtuw/FQYkaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxoIhJ5nDWhJdf73YDnWQNz3YLnBj8Y6C3GF3lTIRuk=;
 b=fDmpgJ82fKbN7AfIDPN659c/4/P8pPp0bx3D3FJTZG9LLUDDfjHWJQeu2PA8htLkoKHvEzzXu+ED3ptBxkBCwNe3LU1viselXko1WzC5BkfVkxfSMb2hP4gbphV9BT2VpyPse5WjR5mNpuy3I1pR8REbCt0wvIgW9qEz2l7zcbXl4607P9bSwFzlgAna9vdMs5Ibpx6TtclQ/+X0K+0yRsodWe+4ALeaQaVy0pJwwO3cS1Q/VYd8muwx4lGq7RnAyFwt7kU/TmyqyaoDwKQb6WmnBWgB/cuHwqXNfigzQJ/0yoWEUIzvoYipwlboMJ3GOWhxbVaGrEHzzQyT9LSPWA==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CH3PR12MB7617.namprd12.prod.outlook.com (2603:10b6:610:140::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 14:17:46 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 14:17:46 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v5 06/32] hw/arm/smmuv3-accel: Initialize shared system
 address space
Thread-Topic: [PATCH v5 06/32] hw/arm/smmuv3-accel: Initialize shared system
 address space
Thread-Index: AQHcSqrZPrjQaU5QuEmxxa/ZVBB8ELThA9Ag
Date: Mon, 3 Nov 2025 14:17:46 +0000
Message-ID: <CH3PR12MB75486A4AA3D2286EE9C4259CABC7A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-7-skolothumtho@nvidia.com>
 <aQUlypv8TqmZM0PU@Asurada-Nvidia>
In-Reply-To: <aQUlypv8TqmZM0PU@Asurada-Nvidia>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|CH3PR12MB7617:EE_
x-ms-office365-filtering-correlation-id: fdcbc44a-bd2e-4aae-a4c6-08de1ae3c2d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?F2pjWQ0JmRoIuay+quMYHrS+KGBQh6a7238HMqiXw2HDL517IcaDitiaRzFd?=
 =?us-ascii?Q?vhky7nyAoPO+o+bX6plgq3mZqbYVkXWP2Hf3Z1bmFcez1ANA+GXOV664MeOH?=
 =?us-ascii?Q?bK/Si1PBJTKvPf2UGNvinpHrgpDV8MM6muLrjHxw7Z9WibJpREgQhL3sIwxH?=
 =?us-ascii?Q?6IO8FRtZtgKUm/Ut6yUt/GOYnmnuDUzbuvqeS/M+CBfU75aFEL3KaVjD7S4b?=
 =?us-ascii?Q?aKSUc9Nm1QClZmhy/rr+nmI7rO6CNcr8313/xkBmOMkivl2+X1EGsaWXI7IL?=
 =?us-ascii?Q?XEebgljP0/I9ZAarp1/B66AzH4W52j59Q2arGvAkRzwwPs10Ogxu6Nu+sd4s?=
 =?us-ascii?Q?e2zwb2/PQ0u0BVUflH1BCztwea9dj4wa1omYbHC2YPmdfrTk+d995vGKJc3X?=
 =?us-ascii?Q?HGXcAyt7zp3niqgZ3Tz8buhy2ju5thdTMRYeZ+HmvmbrCLbwUTUb0w97bcRL?=
 =?us-ascii?Q?LhqTrvaAjCS5PLrSs/XUn2eEdkuImp+H3YPgBFEW6n2rJGT84FtIe3FTg3qo?=
 =?us-ascii?Q?NPp5o+GrfAtQSxQCsTH1GZIsOJPvDgrBN/G3j9BhgODRzjuDPPUuA0v80cU0?=
 =?us-ascii?Q?CvHmnD8/+ITWGyLhHPDbFK+sV6NOI+3rTYOkeL1TV5OQ13BK9GF4cg2Vgg0R?=
 =?us-ascii?Q?jgPz4n7OHGnqFGRqAupkW5963GQXsfkuclfT7DI4sJ8mglMBFspJItCnpWKP?=
 =?us-ascii?Q?VK7L6KZnF7HQfELR2GBMkXK74JFZIqCeWkw10EWT4B3Mh87teVI1k9FAcXje?=
 =?us-ascii?Q?o2kvdamT2sgwhs/52vFc3rBbm368KEYoQWVOL9+9rIih8IlVeElYrNjEV88h?=
 =?us-ascii?Q?KhYvBGHMTaBofFbKaSb+fYeDMVFw4tgWI1sFu046S4X2Om8xti2aiFaJpxUY?=
 =?us-ascii?Q?mlhkIGQXOZDM6s3jdkJwSsQOodSDmSLujaDLedO8IMwpMxdGYTFjGEETqca2?=
 =?us-ascii?Q?IcrqztlBWDA2PeU2yz5YEUFanx3Js6Pji7Ak/uv82+Fa/INSECNZzq6LKknK?=
 =?us-ascii?Q?6Y9boV+yz7OmSZ5hB9XCe97XTHedrMr8ApMykvzRme0aZNy+FIO08fpJ0B/D?=
 =?us-ascii?Q?bAU4KTyprXa50l6H65kAMh/us3c8Mg+tcOO0YC5bEZ5QIMispd0bPw8BTr9H?=
 =?us-ascii?Q?hCk3y7v+f6X45AGmq95N0xWzF7t6P22R6gjE+Ll2Fm66iBJu8h1ri2HkBdjJ?=
 =?us-ascii?Q?mihS+/9KevFpFiDoCgqH+IesAwbkI2chM10zGgjuNK9zuK8bcPQNVn656n4L?=
 =?us-ascii?Q?0NDb6Mlgdyb1VjWCXtUU4awVDvtcoVq0Y1bl/4sifH1QD1MW6bFQM9PaFM74?=
 =?us-ascii?Q?6kvvL2D4yn++TLYnylIQrREBtPWXton3C+fV8xMrcZbqUV75gZ/d1Zxw1/wy?=
 =?us-ascii?Q?t/7KKL/7szQ4a9Qtz1QDk3LaDqQqAnimg/mTUwIe7BpeJ9rxI/euC1XRf8Tr?=
 =?us-ascii?Q?ihKw8DYSkBOwDtyHq3dOq8tJgdPOvssSp3jBsjTM3fwkPNDrz3a+5tQrtQxN?=
 =?us-ascii?Q?2XP716eMxnDATf5M+1s7rM9hHMfMkxSS6auU?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2pGAURB2tfFXxjab1zxoMcl9XeD28TEgkKbzNF/sks7nxa7ShlZ4d/Ic2MEU?=
 =?us-ascii?Q?Yr4bXswDek/DM2dZlK2fyXslE05827QIawfx5KSMDo2h2kqvSxRMlS74W8Y0?=
 =?us-ascii?Q?czfkAl4W/hZ4TR413VxpF/0+yVmTAOdQRedOiLz/ccsA/kdKCMyggEQbhwyX?=
 =?us-ascii?Q?I8nxqXGlR1tik1p/U1DXaezHoWYx08JbR1910RKHDq4TYoE0TE+oRZgazWNG?=
 =?us-ascii?Q?7sRcgKXRJ513VJrjWE3WUf3oSPLtdkM7Qxj1Fu5XjoqB3hQWQ9k2CpX0T341?=
 =?us-ascii?Q?NNcRvRnrGcV6WVPw4gAezCAcz7qsDsDrBE0M3EcUKlV/I/MfbhpM5NyN+2w9?=
 =?us-ascii?Q?i5Cr75opwjMhIVx4sCKuCmQln9S7TiUKDyzCPmTzqMdhFDU/XlVVmj0qz6kJ?=
 =?us-ascii?Q?DcbgkXEnvbJENI9Pj1h9eMUKO7sIXlY2FVlWJm4JED9snJZp4GNgVYwa6M78?=
 =?us-ascii?Q?0mo1iCq8ZsDwCYnCzCby5VCWWUU5XKQ7UVoyJwfIFD+ScMhXKxC6l2tVVdNt?=
 =?us-ascii?Q?8QQ9Ue1Ed0R3CAHalIrymSwqxeeFHwFmkNAd3435oEEd6+D6y3OrauBGU5ZQ?=
 =?us-ascii?Q?b8Z5eWUSYEo7mXfk4cd7+OKcdDboshXEYIavIX8GpORxQUvK4RS723XBFgiB?=
 =?us-ascii?Q?b1PK4p3UlnRXL8GH0Bjxs4iIp+1hwcjvpAwpqxSAMVz1J5BF/9dOuENVr9aD?=
 =?us-ascii?Q?3cpm/hh496L6NYc/SeKhg8OMjulufVv6BXfE2rRqhqWygFu3I7kqnpU/nYHG?=
 =?us-ascii?Q?LlM/BK3BCx11NR3GToGnwQmOv/tVe4CgRJRlDROJVCQC6/vYCqbXxQywdH4f?=
 =?us-ascii?Q?KYGdiXADDRQoiEFfy9LhCcJRg8GkkA3dmENPVat0J0cz7RGzoxXUtOhXdHd2?=
 =?us-ascii?Q?jApA+drW2AwWxHf1tkPFrypOi33VG9KomaGO1vqqD2zBwzh1q+TU35I3rWo5?=
 =?us-ascii?Q?Zw/Q42YWvWCpy1o+TmjA+7PvahAl83AK0odu6WLI5BhEG7w1qYlBSDOL317Y?=
 =?us-ascii?Q?Xa14v27Wb4PFrELgRunSmOIlayHlqr4Zbv6O60HDfqZsEyu4GjlZkM369veS?=
 =?us-ascii?Q?CqmSyl+rqDhiWirgFkThQCY2cxEP3K7meAVtbiETWLr3xUlnKXbQWV6Cvk3f?=
 =?us-ascii?Q?thDclojq09d5J+W6/y7j+i9Cwx8Re3nY/ZPOBFSdX+tPK2+TcQKqxJQEyBBj?=
 =?us-ascii?Q?FB0/0P+tGdro/vp9Lv1sqALYtodAyATtokpVCOMhEklY9V6sLcYzeixP3GYb?=
 =?us-ascii?Q?GdYWW/sAwebVAMzyRYkQF3by6Yw9OcyXnCAmj8TG97OL66MappYdEuztBzBB?=
 =?us-ascii?Q?sh2jnregqF9oflCh0vbYg7XHg7xFmb9N9246gQC2zijtbukI6rV4Ph9lFjNE?=
 =?us-ascii?Q?MUW3n1dRuBjkLwFIgqqXDB3Xqo0cBHd8SOMOZupS8pUL2/OTpohNenVIwLAl?=
 =?us-ascii?Q?472Bc8R54rk1MaOjUaOD7GLiqoq9xauS/sz35qYLGoR/Ji3U34ulTrFOcWeT?=
 =?us-ascii?Q?y13Ber2BBvDbGhx+em+MFkGQCK9kCVgzBcvWK41nVyaKh6s1fCB/I+PT1LRf?=
 =?us-ascii?Q?/b3oRgAbjh5rzNf/WFuKncXjoRaowT6WruLWpHEz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdcbc44a-bd2e-4aae-a4c6-08de1ae3c2d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 14:17:46.1547 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /+7p19uYJoaCybgugoP9ScInwPM/T04H3II9lboGHK7qFsBRlBPUAKdRi75JGB9hSu4qNG6Hnzj1qx4o61Kihw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7617
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
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
List-Id: <qemu-devel.nongnu.org>
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
> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: 31 October 2025 21:11
> To: Shameer Kolothum <skolothumtho@nvidia.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; Jason Gunthorpe
> <jgg@nvidia.com>; ddutile@redhat.com; berrange@redhat.com; Nathan
> Chen <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>;
> smostafa@google.com; wangzhou1@hisilicon.com;
> jiangkunkun@huawei.com; jonathan.cameron@huawei.com;
> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; yi.l.liu@intel.com;
> Krishnakant Jaju <kjaju@nvidia.com>
> Subject: Re: [PATCH v5 06/32] hw/arm/smmuv3-accel: Initialize shared syst=
em
> address space
>=20
> On Fri, Oct 31, 2025 at 10:49:39AM +0000, Shameer Kolothum wrote:
> > To support accelerated SMMUv3 instances, introduce a shared
> > system-wide AddressSpace (shared_as_sysmem) that aliases the global
> system memory.
> > This shared AddressSpace will be used in a subsequent patch for all
> > vfio-pci devices behind all accelerated SMMUv3 instances within a VM.
> >
> > Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
>=20
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
>=20
> > +/*
> > + * The root region aliases the global system memory, and
> > +shared_as_sysmem
> > + * provides a shared Address Space referencing it. This Address Space
> > +is used
> > + * by all vfio-pci devices behind all accelerated SMMUv3 instances wit=
hin a
> VM.
> > + */
> > +MemoryRegion root;
> > +MemoryRegion sysmem;
> > +static AddressSpace *shared_as_sysmem;
>=20
> static MemoryRegion root, sysmem; ?

Sure.

Thanks,
Shameer

