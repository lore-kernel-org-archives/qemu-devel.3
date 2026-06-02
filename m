Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76DFBCD6E57
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 09:41:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wULbl-0004Ob-4s; Tue, 02 Jun 2026 05:40:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wULbg-0004NJ-Cl; Tue, 02 Jun 2026 05:40:21 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wULbe-0000uw-Lt; Tue, 02 Jun 2026 05:40:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=crZTNF9QzTk/DJxo8QDlJ+hJXxbm+hL46HP4M4cabo53od6yHDL8UhlFyCF1+uW+XQvygdgwlI5gcAZBsb+st1xLoRa34q4UApWezBbEXdxPyI6H0wwNupPrg5cqm9wDikGtYyTQT7tYCrbT23AVTGH3oe6eAaW1n4sgx1zttgJ+HSfrWhAX19QYUR7KBOvTLaF04eljCnrCUdDd4MRs2B4XGIxeAzqPjeTgDgRQzrRnOOzzfcDAC9d2H1l4o69ZOu65TiI3cPtkswGhbW8TNlHkVrjTxlMwdrRj0FnBidN6A7ZFpIKxyGESz88hy29bUWVvChAqv5Y5MUK9zwZ+/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWVfXtUHRYN4Tj80CeZpxIwaGVmlDA42HO2qu1LKV4k=;
 b=ncJEqoLcdUakJ9YOreA5rla0/M/4NoGx7iHqAcsVAtXMDVIZ3n69dSdgWj/p08sy7vi2VSH8Uc3kCLZul8kEyWQJw9aNo2M6jM2FzXYKtkLm4O3im8Ka1rQbdISYOfArb+CU01Yphpv9Xy+YmZ+4/ITgw/hrT+Y1ddIl7P0nrVVcNQj9HQKoLmQ/3ci65gRmQ9DR7+Ild/p93btnCfzyw98ZpeIKxVzbfTaYZp6unbgNwi/hC+hUBA1PuEeJZVz7RIFFB3BKIH2IuWj768Mc9iW1pHxaiD6LvtD3lK8kncNZzHNpUnqMMbfUL19jw3fCRcxhGTm41R9TZY9uWpQyYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWVfXtUHRYN4Tj80CeZpxIwaGVmlDA42HO2qu1LKV4k=;
 b=b3c+/3Steb4F9dhPE/aPY2JZWcTv7yOAR9EzMLgQ/9JRYdugoobyoMQCeZnhBz0yucXayUhOiezyGEXKuc9TQ5DzcQ+NX0VjxnFcJ8stYkcor9attSdTK250U8/4yt5Zcxh10ghIhk1TKm3deTfxHvAqbadvhjm1FyOwMWQJOVUVsiDepxPecbaX7382AwO/scdJi13X2Oz9uwLaIc2YrDcYb2EbhQeX7NM6W7An2J6+r093ycIzAZN0w05SlVozPudohRXkOWfnCx4Hlhkq86hK28E+e5js9CFb6HlG0zV8Xaf/23H8SFFy9bp2ApgLA0QR3DxrzgkWV18J0UqJHA==
Received: from IA0PR12MB7555.namprd12.prod.outlook.com (2603:10b6:208:43d::5)
 by SJ0PR12MB6856.namprd12.prod.outlook.com (2603:10b6:a03:47f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Tue, 2 Jun 2026
 09:40:08 +0000
Received: from IA0PR12MB7555.namprd12.prod.outlook.com
 ([fe80::5a27:a8d9:43b7:3b8d]) by IA0PR12MB7555.namprd12.prod.outlook.com
 ([fe80::5a27:a8d9:43b7:3b8d%3]) with mapi id 15.21.0071.014; Tue, 2 Jun 2026
 09:40:07 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Jiandi An
 <jan@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, Krishnakant Jaju
 <kjaju@nvidia.com>, "phrdina@redhat.com" <phrdina@redhat.com>
Subject: RE: [PATCH v6 30/31] hw/arm/tegra241-cmdqv: Document the CMDQV design
 and lifecycle
Thread-Topic: [PATCH v6 30/31] hw/arm/tegra241-cmdqv: Document the CMDQV
 design and lifecycle
Thread-Index: AQHc8bzbQ6r3XeGQkE+G66/Ag9+o2LYqXnaAgACO0vA=
Date: Tue, 2 Jun 2026 09:40:07 +0000
Message-ID: <IA0PR12MB7555F3EB9CDFD9B063CD5B73AB122@IA0PR12MB7555.namprd12.prod.outlook.com>
References: <20260601114221.457995-1-skolothumtho@nvidia.com>
 <20260601114221.457995-31-skolothumtho@nvidia.com>
 <ah4aAZR29tw5/pV5@Asurada-Nvidia>
In-Reply-To: <ah4aAZR29tw5/pV5@Asurada-Nvidia>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB7555:EE_|SJ0PR12MB6856:EE_
x-ms-office365-filtering-correlation-id: a9327b4a-22e3-4a72-b4ca-08dec08aeea1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|6133799003|18002099003|22082099003|11063799006|4143699003|56012099006|38070700021;
x-microsoft-antispam-message-info: 2lOymQB21sRPXlrWAlNrFb/Qc2IXUuOux5lmGXVAoRzXXJJwfjbkxJjLyFBaBhppFw3fbcDzRHha72+Tc1TPo9w+WDXCljUXvmghZS9meDGoPHFHY3z1nBl44esGj7J9sh2vFujtB2hX7jTTKyq3xvwJiwYsyJ7Z3XBRc90bmWUJGUIpviubQxXcn6+7dJ7xC5J2yQR2BvuWf8N54qGeaKNAFeaEOLbP/TQ22YLbgSYD8XpdCF5L8et8+H/KGOEgAU7oi7ytDMseia1WNEwYb/e+7euikQr+F6M/q3PHACdfLFUGNVaig0eWF/IwidVY5iWJyRO8T2JdM+Z+VxtMZQaDu8A/eXVTpNrDDhhon0o8/83VfTwNwK3L8u+SGbJed5c3NjBn7345q3o2Q5PrCMk0809I/Rzqnqwutgz2JYC/GYgw5I7wpznZaYgsaByAqqolkAqTUK0cJV6epBxybwGfrZn4y58IgrnBGqyKeMeXZhev+DotJNaUkoNJXWf88mL3X22uiF71mxW0S8vGPxHKuaFPv6j1CsEtzNR6+SwSMaGDGhrtSI+I2QpQjVP3bbs1oSgGg2Fi2PCXFPG9C6bmPogkNzJTD67cHvSWgMO/49PFWqV+Wt8H52r4rHCjhduYQBBPpzwDzYIG7imR4vfQk6nIVK6bKBvkuLR3cOYYhC1K1xYLghKvNfNqJL6s9KqVGnOEeEFYFWDGHv61lqV5ML0n627t5P3++oSxStJqV1XPCbIdhvuiFBP0hAji
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB7555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(6133799003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/il1p6MI7Czt9yXuOj33egUIUvvlrJzLudB8OaVvZjD15yImKxFhwvkJ0wbM?=
 =?us-ascii?Q?4zRJnMijWwSNyfwyXTel8tFh21RzwAR6XmUriU9ZM3v6Q2CvkX6byu0UFnLI?=
 =?us-ascii?Q?e+k9Pbzl7gHHYu+9LbKO1dZIFicJ5YiFaOk+MXjm7snFZVPRWKDAp4Z1pxy5?=
 =?us-ascii?Q?xowYD1OgezJ9mZOHiXkHDLpLF4ellsX20wALCiREtUbBsRB7Mna0ZXQF6g/k?=
 =?us-ascii?Q?LUB0MATXkQOMx49I8bJkN3A6hWdMhHt0rZKpLCMOjUaG7yqFdmobyAcOk07D?=
 =?us-ascii?Q?18OQeAnODoS3k5OgNABekj3LscBI1feH6yjx5re01rbhkYktbYMOWWGsebnm?=
 =?us-ascii?Q?h5oR4jP4u461P3tCSvaKrod43hNy1hcyl2hovFNRcjTYQszLqy298BuK7Z/W?=
 =?us-ascii?Q?95JMrk1xnooUCOgygab9RhUK7wpOqvSbrZ43dqhbboEUiUrxNrJWSR7cT2k0?=
 =?us-ascii?Q?o4pn2fIdKsqcg+42DgbLoHEk8C3rZ5HR9p5y/lt9Ogr8e0pKZ72iDd9zKSXV?=
 =?us-ascii?Q?zsvO2DqUUNgtP4sIK5jg8AKVN6FlSv9hpKhFD9EOGgdhNeMR9PztTw1YBXps?=
 =?us-ascii?Q?p8GYKrYV1qHVrwg+ObI+YL5Jr73u5gvBik+KkmEod+x+JBtP9WikTYdxlKRJ?=
 =?us-ascii?Q?TZmd0KYEztNb4v+AJOts45eHThQDZL1FpfnQPyp3kPKHoYaECGFtU5rJTxxC?=
 =?us-ascii?Q?67G3Sf7jsdOOXF98bxNOStcs5kMaGbO51Ko8T/ivqCey8xVtYUH873bHL/SD?=
 =?us-ascii?Q?MfrWu3ndxU/DUZsq671l0pZ2VFNdGr1h0cVs4i7dRSeOkwrDTLcbcSLaGK+x?=
 =?us-ascii?Q?QVL5H9RG3BKjYI8dKgUTiOCblvRBn8/pKISZEyMc759rQSN3aNuWItjQx0qU?=
 =?us-ascii?Q?GgimyTRyllmXb8bQOK6/1lqqLKxLGx0sVco20jHVOwq06upYGDlJ54gr3ctt?=
 =?us-ascii?Q?bl7zZ5zqnTuNHBt4N8EhgUqipT31QpwHOSg0KSn3TwNMg4206mOboJ+IQVMo?=
 =?us-ascii?Q?SmMiiSHogNBFEIJe3NQIsbTf6a/jJi9J/l6ShfvFBTpbhsByzOHVrX06Pri9?=
 =?us-ascii?Q?FK4YbGpGZ5WU+/WNjYuNTQnmo/uxxWF78dzITng46Q9gDuAaZY/3jJ6P4A1m?=
 =?us-ascii?Q?ToqDUnGXWqfhX7pyS/vWyQYhYOhr9FzOv4t+EhYAfI6wj+t7+glYksoqhHKK?=
 =?us-ascii?Q?tl1bLdoBs2Il3zjFgLIsQBAmiaRerOfll2gK/XSw4FjSY6JH7xXBJFzXKdIl?=
 =?us-ascii?Q?SVIGvUV3ZCTXapzstW5dYu7gNBZkOzc/QljHiCieHvHxlwrQV1UMag7XDNit?=
 =?us-ascii?Q?XxjjUNy1CDmky7/8diaJGGqOD7TL6yvvOQGGqZLX7ANotamqpgY3XmHQ7Ror?=
 =?us-ascii?Q?4FnBzC3vM0qzgixAFMafP13NsN51Oluzad+Rs7lMg9lIdar14rgH10CS8zTN?=
 =?us-ascii?Q?5GQBJy/aInkBKB1ffE1OUX8KziDT7ssNvMi7LVF+igCdrllQTvhxIbbuUwCw?=
 =?us-ascii?Q?tdF0iSrQvQEtVLocohP82UurYwgLpeYp5Rj7BaFoxZUqan+RRTRsBb0lCFZs?=
 =?us-ascii?Q?zIvBL7YKGUz0Ij4aalcgJ63Ot8Brh093vkgWrV4R8jWdIBndHfCAfeggrel6?=
 =?us-ascii?Q?AvxMtzPyuYF+gaph6pEKpGRyx3JVoH1EIMqXhHEON8vnt0pj618awKurJCsR?=
 =?us-ascii?Q?tQ/c1zuQ9JEm0VYcInjIqS3EgmpTrBQlJyyoqDmG62D/Vn4SwW7t++zaUTIN?=
 =?us-ascii?Q?88Q6jTd7ag=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9327b4a-22e3-4a72-b4ca-08dec08aeea1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 09:40:07.4369 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9CLGpFUWUc9t1x3WXOlA4cHYZhlgxen0GJ9t4ZnwAJAOt28/TZ3WVzphG5vxRJjOEmPwfBgAKrUG0SD6iFYXqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6856
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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
> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: 02 June 2026 00:47
> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; clg@redhat.com;
> alex@shazbot.org; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
> <mochs@nvidia.com>; Jiandi An <jan@nvidia.com>; Jason Gunthorpe
> <jgg@nvidia.com>; zhenzhong.duan@intel.com; Krishnakant Jaju
> <kjaju@nvidia.com>; phrdina@redhat.com
> Subject: Re: [PATCH v6 30/31] hw/arm/tegra241-cmdqv: Document the
> CMDQV design and lifecycle
>=20
> On Mon, Jun 01, 2026 at 12:42:20PM +0100, Shameer Kolothum wrote:
> > + * Lifecycle (driven by guest events)
> > + * ----------------------------------
> > + * 1. First vfio-pci device attach (.set_iommu_device) triggers:
> > + *    - tegra241_cmdqv_probe(): IOMMU_GET_HW_INFO confirms host
> CMDQV support.
> > + *    - IOMMU_VIOMMU_ALLOC: the kernel allocates a VINTF for this VM,
> > + *      configures the VM's VMID (from its stage-2 HWPT) in VINTF_CONF=
IG,
> > + *      forces HYP_OWN=3D0, and returns the mmap offset/length for VIN=
TF
> Page 0.
> > + *
> > + * 2. Guest writes VINTF_CONFIG.ENABLE =3D 1:
> > + *    QEMU mmap()s the offset from step 1 into its address space and
> reports
> > + *    STATUS.ENABLE_OK =3D 1. The host VINTF was already enabled by
> > + *    IOMMU_VIOMMU_ALLOC; QEMU only acks back.
>=20
> I wonder this mmap should be done after the
> CMDQV_CONFIG.CMDQV_EN=3D1
> rather than VINTF_CONFIG.ENABLE=3D1.
>=20
> Spec says that:
>  "Program the CMDQV_CMDQ_ALLOC_MAP_X register(s) to map the Virtual
>   CMDQ(s) to the logical CMDQs on Virtual Interface following the
>   CMDQ allocation rules. This again is an optional step and the CMDQ
>   allocation can be done after the Virtual Interface is initialized."
>=20
> This means the LVCMDQ mapping can happen before
> VINTF_CONFIG.ENABLE=3D1.
>=20
> And the mmap info is returned with IOMMU_VIOMMU_ALLOC. So, this is
> doable?

I think it is. We could in theory as well do it just after IOMMU_VIOMMU_ALL=
OC.
What you think?

>=20
> FWIW, kernel finalizes a LVCMDQ mapping when handling
> HW_QUEUE_ALLOC.
>=20
> > + * 3. Guest completes vCMDQ setup (BASE, CMDQ_ALLOC_MAP.ALLOC,
> CMDQV_EN,
> > + *    VINTF.ENABLE, in any order; each precondition write retries the
> > + *    allocation):
> > + *    IOMMU_HW_QUEUE_ALLOC binds the guest BASE GPA (translated
> through
> > + *    stage-2 and pinned by the kernel) to a host vCMDQ in this VM's V=
INTF.
> > + *
> > + * 4. After the first successful HW_QUEUE_ALLOC, the mmap'd VINTF Page
> 0 is
> > + *    installed into guest MMIO as a RAM-device subregion. Guest VINTF
> Page 0
> > + *    accesses (CMDQ_EN, PROD/CONS_INDX, STATUS, GERROR/GERRORN)
> thereafter
> > + *    go straight to host hardware, bypassing QEMU.
> > + *
> > + * 5. Guest SMMU driver programs a Stream Table Entry for a passthroug=
h
> > + *    device: IOMMU_VDEVICE_ALLOC programs SID_MATCH/SID_REPLACE
> in this
>=20
> Ideally, the VDEVICE_ALLOC should happen right after the device gets
> plugged *and* its vSID is available; similarly the vdevice should be
> only freed when the device gets unplugged. So, its lifecycle should
> stay with the plugged state.
>=20
> We do VDEVICE_ALLOC when guest programming STE is because that's the
> only place we found in the existing functions. We could (or arguably
> maybe we should) find a better place to allocate VDEVICE. E.g., vfio
> code can call qemu_add_vm_change_state_handler_prio() to register a
> callback function, where vSID (vBDF) should be available once the VM
> start to be "running".
>=20
> I think your narrative fits the current design. But we might need to
> be more accurate here, since this is about "lifecycle".

Yes, the above is based on the current design. I will add a caveat to
cover that.=20

I remember discussions about use cases(CCA realm ?) requiring an early
mandatory VDEVICE_ALLOC before guest boot. Regarding the suggestion
to use qemu_add_vm_change_state_handler_prio(), it might help,
but I'm not sure it covers all the cases like, hotplug, guest PCI
re-enumeration during boot, etc. (Having _DSM #5 might help here,
but per the PCI Firmware Spec it only "indicates to an operating
system that it should preserve assignments of PCI bus numbers",
so, guests are not strictly required to honour it.) Anyway, I'll take
another look as a follow up.

> > + *    VM's VINTF so the device's guest vSID translates to its host pSI=
D.
>=20
> Nit: so that the HW translates the guest vSID into host pSID.
>=20
> > + * Limits exposed to the guest
> > + * ---------------------------
> > + * One VINTF per emulated SMMUv3 and two vCMDQs per VINTF.
> Maximum vCMDQ
> > + * size is 8MiB. The queue must be physically contiguous (the HW reads=
 it
> > + * via host PA), so QEMU caps it to the host memory-backend page size.
> Use
> > + * hugepage backing large enough to keep CMDQS at the HW maximum.
>=20
> The "physically contiguous" limit is handled by QEMU, not exposed to
> the guest at all; guest is unaware of this.

Ok. The intend was the queue size exposed may be limited because
of the "physically contiguous" requirement. I will make it clear.

Thanks,
Shameer

