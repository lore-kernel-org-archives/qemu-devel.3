Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B242ECD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 08:41:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZlq3-0006jT-M6; Wed, 17 Jun 2026 04:41:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wZlq1-0006ig-AR; Wed, 17 Jun 2026 04:41:33 -0400
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wZlpz-0002Ma-5U; Wed, 17 Jun 2026 04:41:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vK1lKKAh/k3Em3vIHx/22TM6NXzyMVD3y+nSnepPgTCNNEbNGdIV/Gddo7v8t8d2PY3sDM6Kk+Cvd+uwqTACktKVcl4pHCr/snlevNze+GzyslKSb+ZEUKvPIk1Q5oSRm28NxKHafgmRBqbR7QjYwxPLJ9KW6kSv14bbXhOeX0lKgtYGz/aOHJFDusetY7ieaY4a2qztNWJ3zY/R1K19V1qrtZbOYKBdElWD/JJIgpAuW6Gvj/kG0vcLko+cyhzbsDPmEYlj+EW+AWmUzGB7/aRPzomna5LEEYEnRHGm0P4t4AezLuGo9zkW0u/G2I/Y7LAuq/BTYD78FbB4x2ksjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iv4GIIBx+ZCf9SM9PKCl2G3If9w7rfVwlSZBmKY9T4A=;
 b=GdX1Aws9/b6qlvKqfN5x3oidgfy5f7OmdtBRLSEnffFKd6eCU8szq4VUkc9dc1fwqusM92pXT1mTcdtab1PAp84RHcMGY2AV4LR5uRtHFSnj/MClzIMtldg6pp+RzZBVfDllFtj8kCNcz+eyD7Xckod63IL8LdpmZny0NWXeBFYgnmlsTC7DPLj2qhxnMlF0dBIO6gYr13nKZmkROQmiFk7DhGoWpJ9fP8qI714T6pzDhTV5a9WIfRVcyig0zLJ/bThdypg1fkSpo6Qdj38MFbKk9lL98t54cPIVx4BR9HQEMoGlhwcwZgILoWtcQvAtLKepXLiEa8luQuRRjFBUJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iv4GIIBx+ZCf9SM9PKCl2G3If9w7rfVwlSZBmKY9T4A=;
 b=Mgd0U7eRMZxHt2U25wVzJvmDWPoWXAXxI3fetuJOonKSvYK2kURjdjGeOpd7ye6UII910MNQfoyEXuMuypqgvSgZM9yMXJk4s88mI5+43yz6/G2A0SOL1sm50sEJRxyTowWfy5GkAZ5e8tQG46fLh4WNJnNvgl/sMlhRJ94KhJ2XJjmljAfCq1L6/MrWXJmRoIhAfIPfBelbwAOHWL8tiqoSMqgkL4yE9tVfrVTjtsDJ+uSAT157p6cK7F59LZyYbahUBIDMKAlwE7vGdKjJCuESbvDeLLynWhpz81kYXvTaaSTqnfrMKKCzDWE/nltucHK4FZxocj4IYnMGcDkdOQ==
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17)
 by MN0PR12MB5955.namprd12.prod.outlook.com (2603:10b6:208:37e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 08:41:23 +0000
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b]) by SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b%3]) with mapi id 15.21.0113.015; Wed, 17 Jun 2026
 08:41:23 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt
 Ochs <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>, "phrdina@redhat.com"
 <phrdina@redhat.com>
Subject: RE: [PATCH v7 00/31] hw/arm/virt: Introduce Tegra241 CMDQV support
 for accelerated SMMUv3
Thread-Topic: [PATCH v7 00/31] hw/arm/virt: Introduce Tegra241 CMDQV support
 for accelerated SMMUv3
Thread-Index: AQHc+ALmli4k4ZogXUCjb3NnLXqt/rZBl3mAgADcHOA=
Date: Wed, 17 Jun 2026 08:41:23 +0000
Message-ID: <SJ0PR12MB8614017E64CA7822CE44DA95ABE42@SJ0PR12MB8614.namprd12.prod.outlook.com>
References: <20260609112552.378999-1-skolothumtho@nvidia.com>
 <CAFEAcA_c_g+Kw_vz7A4D8oQV5fwvcg00gagQ9Ph4_S1dntBFwA@mail.gmail.com>
In-Reply-To: <CAFEAcA_c_g+Kw_vz7A4D8oQV5fwvcg00gagQ9Ph4_S1dntBFwA@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8614:EE_|MN0PR12MB5955:EE_
x-ms-office365-filtering-correlation-id: 47e378ee-b6e6-4cf5-e07b-08decc4c3671
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|56012099006|5023799004|4133799003|11063799006|4143699003|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info: 2+TeOfKjiHo0YE6q67flcu+y4+MGM/LoXfgg+iwviFkgc9E3aclv67viSBAGOHdUY9obvScA8M/0b49feSF1WWQLVzoG8l7yQQVmmvOvBUeyiewbYoKVGbZx9H55qYk/AC18ck6tbfNFaXVpN/nDXcsZXdJgm6slqIDc5/hOgIOPAJBy3XU3tfosf5LS3mk/jvGDI0FSU3CYNQH+ro84vtv9hVvopo9cTyHtp7ZjxfdOCtjwC/OFHQwgRUGMlyQXar135z1YhbBjTb2nmPsf2WZWbBG25MOGqQ0CRGeYYSYltqqpH3tbeUhEwx2RoLWhKz0pS0c7E6MPTgR0oWsjwXdst04aEAdJNpqPfb1ZfMD4ceHvxeT0EG37YeLXMpRo2HQAzWClRWGEyTuK3dJPhIEDjYj8KJU0LyrKM+1MZfKe7lT4SQ/mAz8hxc640rFdJXWyqzt+PG073HVSvi52IaVUbBaL3h2KL5IOuFiYxXc0Kv3YQgAO1OIMZovr2hVbpwSNgzwSyOP+oDcdlHnjbN5heGU+d1XeESPRi6jr1oduz9rhGm2Bf63q0855Z29orEGxDjkpq25b9iBVTJmC0B6IoT2NTljTMKTHG0RPcfCOPCnkOUnIFkPAD9oZ0f4xjZL4BPbxXjCtKXeYRpnavNG4B0GMp4TU7e2n6CY3fJbK1OkQ/2W2XMIDyDl1eG2rw7Lzi8QGOXItLL4X8kXLR+7gGkPyheEg/kv40ty0/m4lqLEac8EjdGtC5ciAzavW
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB8614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(56012099006)(5023799004)(4133799003)(11063799006)(4143699003)(38070700021)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PnX+k3aEa5s6nAeV8Z/hcBUzSoJYx1pSik01ufxuyEvlZbM1pDLo4trMzQjV?=
 =?us-ascii?Q?IQHIk6sEyzSQpi2DVprDq5wIXZLFXH680Z0Sn6zVu9YLDEv+kiWN84ZEws/r?=
 =?us-ascii?Q?CKn4z4BwK8zI/6xGOukOtx8lARksIKUH/o83ceATLg9I9mKViJFgeu49YsKU?=
 =?us-ascii?Q?tQMB7qMy5v3h/PEPy2G6tDOnizOqnJ/E+ifykMmU7iF4Rbk51VnsxWZu5hl1?=
 =?us-ascii?Q?fp0Q2O+0xjRdn8Rd6zGiMF6uGguW9Kpu1o6DmCLEiW4otQSrUpzKEOlbhARL?=
 =?us-ascii?Q?TLHAitoR9RwKo4c8KB5+8BcoSuxILT58fuvDdgUWTIe5xQVNagqiQvUBo1PM?=
 =?us-ascii?Q?lNvp2mNo7uRNIo9bvQfiiqtVbGnfbUsGZxlXVfCfew3AQkvPDMNrWjgJ4Kuj?=
 =?us-ascii?Q?csDhpUfR2BtzRGdeMxuEK83LMAyYbh2oV3oLZrgCgaCALWgl3cQM69aBW1br?=
 =?us-ascii?Q?Jt4GxLoyK6AIzOtAmBTIqLPzLS6kBJ/+kDXHjyEFmHf1gIOpC3xjj/Y6YiHH?=
 =?us-ascii?Q?RdQcnRzBzdx9wQP+A2VdOn8VL+6XdEC2DGfoXLywe7Exdv6a5kkjKLZuUc8L?=
 =?us-ascii?Q?U72n/InAcytIlDAGWgoDlmpf6rodRh7wwedNEKgl55hBFz36/L2lp1mpEsXA?=
 =?us-ascii?Q?Vas0vmjteV15HxBzKawDN6NwCCA6+yvPU0BggD5RoYE6ms2AtmjIWrgKh54z?=
 =?us-ascii?Q?IlAWTmm924AiezBkK0+7NbRcSfBDQ+xiTDunpIy/Y9STxfEN0phuR9Meb+nW?=
 =?us-ascii?Q?1kaBJYjheNf4s76YMDPnL0HBU9vpAbcu8rEV93BAonbeCElha9vJR0V1Os/S?=
 =?us-ascii?Q?R1bi2otCTMZB1zI5LOIeJ17DncnCwId1oH/1JkPYjchkqd71/e7jTskmurjs?=
 =?us-ascii?Q?ZC18sFXV+c8ki7OxzjbDPjafv2kjQo0+ocaQVe8P/ChZoGzL19bPT/4jlwCu?=
 =?us-ascii?Q?DFa2GKK23Oe3y4vYUEsoGDyrFkYtIkm1/BmYrA7D5g1QJgkmmFCFiNrPSLQ3?=
 =?us-ascii?Q?1r35wC5drLQp22G82g+MlH4mMJb+vJ3mWTBORfZNCvA1nNv0WwzbLNaRbE8b?=
 =?us-ascii?Q?jTEh3fP270zyAjG5gKHvfCCJhquzA28LDlG0FxCcqTthT5JYF35YDIY1W8qS?=
 =?us-ascii?Q?iG4oGjBbnNS2AAggYFDj7IOw4Q2o+xrCieP5pAZruN+S35ysf08Xkz9WXlnx?=
 =?us-ascii?Q?nMMarEXgxz+6yRrKpBlwZmw5chR2WjjTPqjDX9w9TEyoPNaTn31Zj9p9dj8y?=
 =?us-ascii?Q?775oSbZ0/5kZzoauh87k3UOx5adwNz438B2CWrwB8OH3kfDBnpUHC67d0QRm?=
 =?us-ascii?Q?bNAhH4uEXzkEJ1iBstCupcpYF8TXPB+jpxKgBj7M1/hutGsLIb3ZIVIIJGP8?=
 =?us-ascii?Q?SCwkTb9ZDUb9SKMa8LydIoMPlivRZv+qxRlQ2UeTb7DiEk+w3ksC/rfzVpAW?=
 =?us-ascii?Q?vJmv5DFtJIjWslOvhXXLH0e0sAQAc+dZ7laceKylwRNlqNef2cwx/jmqZkjq?=
 =?us-ascii?Q?l7P7IWedNdSO9mcPmlkEhruqi3J/hHKfy1C5pO/93GxwVs49lI4+ykPZZyx2?=
 =?us-ascii?Q?gSS0pxSwNzbChgs+RmXHd36NpFZfDhX70d/WmzVedrAtk5tWIvYkFL7vR8B6?=
 =?us-ascii?Q?SUg1E2qbyGJwSXSYJKZw+Kur51xt+aTtq4+7KzD7u11yQQ3dqvhiSSGKAEKC?=
 =?us-ascii?Q?u1PzvxRngO369S75TaGkE9gsxhN7pewFOdPlnhkaZWQZWW2XcqN+hActoiAr?=
 =?us-ascii?Q?zWittqmxdg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47e378ee-b6e6-4cf5-e07b-08decc4c3671
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2026 08:41:23.5899 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DgXViGnm2JsVXlexWJ2jA8sU63SkYQcmw2w4uP7VAzFDBN8q+COI4eVPYx0X9XqayFkUdORO3uo+LDlkhXgzVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5955
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
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
> From: Peter Maydell <peter.maydell@linaro.org>
> Sent: 16 June 2026 20:10
> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; clg@redhat.com; alex@shazbot.org; Nicolin Chen
> <nicolinc@nvidia.com>; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
> <mochs@nvidia.com>; Jiandi An <jan@nvidia.com>; Jason Gunthorpe
> <jgg@nvidia.com>; zhenzhong.duan@intel.com; Krishnakant Jaju
> <kjaju@nvidia.com>; phrdina@redhat.com
> Subject: Re: [PATCH v7 00/31] hw/arm/virt: Introduce Tegra241 CMDQV
> support for accelerated SMMUv3
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Tue, 9 Jun 2026 at 12:27, Shameer Kolothum
> <skolothumtho@nvidia.com> wrote:
> >
> > Hi,
> >
> > Changes from v6:
> >
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.
> kernel.org%2Fqemu-devel%2F20260601114221.457995-1-
> skolothumtho%40nvidia.com%2F&data=3D05%7C02%7Cskolothumtho%40nvi
> dia.com%7C85054cd29a1d4722ba0908decbdaea61%7C43083d15727340c
> 1b7db39efd9ccc17a%7C0%7C0%7C639172338322799010%7CUnknown%
> 7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAi
> OiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdat
> a=3DL73ziLGdAYoHaufzjyIBUBafyDdhNnIE9EyaJbzJWjo%3D&reserved=3D0
> >
> >  - Addressed v6 feedback and picked up R-by/T-by tags. Thanks!
> >  - mmap the host VINTF Page0 at IOMMU_VIOMMU_ALLOC instead of on
> VINTF
> >    enable (patch #14)
> >  - Reset the per-VCMDQ Page0 cache when a queue is freed (patch #19)
> >  - Distributed the reset teardown into the patches that introduce each
> >    resource (patches #18, #21)
> >  - Added a VCMDQ readiness helper and renamed the Page0 backing-pointer
> >    helper to vintf_lvcmdq_ptr() (patches #18, #19)
> >  - Trace the VCMDQ Page0 backing, hw vs cache (patch #19)
> >  - Renamed patch #24 to reflect the changes accurately
> >  - Updated the design and lifecycle documentation (patch #30)
> >  - Based on top of Nathan's "Resolve AUTO properties" v6 series [0].
> >
> > Please find the complete branch here:
> >
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgith
> ub.com%2Fshamiali2008%2Fqemu-master%2Ftree%2Fmaster-vcmdq-v7-
> ext&data=3D05%7C02%7Cskolothumtho%40nvidia.com%7C85054cd29a1d47
> 22ba0908decbdaea61%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C
> 0%7C639172338322871287%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU
> 1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIs
> IldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DuHKbMM0Gxk6t%2Bw7gRw
> M%2FiTcx9xuDNFKeaDDFZ48qfZA%3D&reserved=3D0
> >
> > Sanity tested on NVIDIA Grace. Further testing in progress.
> >
> > Feedback and testing are very welcome.
>=20
>=20
>=20
> >  hw/arm/smmuv3-accel.h         |   48 ++
> >  hw/arm/tegra241-cmdqv.h       |  384 +++++++++++
> >  include/hw/arm/smmuv3.h       |    3 +
> >  include/hw/arm/virt.h         |    1 +
> >  include/system/iommufd.h      |   17 +-
> >  include/system/memory.h       |   21 +
> >  backends/iommufd.c            |   64 ++
> >  hw/arm/smmuv3-accel-stubs.c   |   12 +
> >  hw/arm/smmuv3-accel.c         |  194 ++++--
> >  hw/arm/smmuv3.c               |   10 +
> >  hw/arm/tegra241-cmdqv-stubs.c |   16 +
> >  hw/arm/tegra241-cmdqv.c       | 1119
> +++++++++++++++++++++++++++++++++
> >  hw/arm/virt-acpi-build.c      |  127 ++--
> >  hw/arm/virt.c                 |   37 ++
> >  hw/vfio/iommufd.c             |    4 +-
> >  hw/vfio/listener.c            |    6 +
> >  system/memory.c               |   10 +
> >  backends/trace-events         |    4 +-
> >  hw/arm/Kconfig                |    5 +
> >  hw/arm/meson.build            |    2 +
> >  hw/arm/trace-events           |   11 +
> >  hw/vfio/trace-events          |    1 +
> >  qemu-options.hx               |    8 +
> >  23 files changed, 2024 insertions(+), 80 deletions(-)
> >  create mode 100644 hw/arm/tegra241-cmdqv.h
> >  create mode 100644 hw/arm/tegra241-cmdqv-stubs.c
> >  create mode 100644 hw/arm/tegra241-cmdqv.c
>=20
> Hi -- I just noticed looking at this diffstat that it does not
> make any updates to the documentation to describe this
> new feature. Please could you add something (e.g. to
> docs/system/arm/virt.rst, or elsewhere if more appropriate)
> that describes whatever this new thing is and how to use it,
> in terms that make sense to somebody who isn't deeply immersed in
> the SMMU and this Nvidia specific bit of hardware ?
> You can do this as a followup patch, as I've already queued
> this series.

Thanks. We have this in qemu-options.hx(patch #31)

+    ``cmdqv=3Don|off|auto`` (default: auto)
+        Enable hardware Command Queue Virtualization (CMDQV) for the
+        SMMUv3 command queue. Currently only the NVIDIA Tegra241 CMDQV
+        implementation is supported.

We could add a subsection under "User-creatable SMMUv3 devices" in virt.rst
to add a bit more detail. I will send out a patch.

> Also, a bullet point for the Changelog giving the short
> summary of what the new thing is would be nice. This
> cover letter was too cryptic for me to be able to guess :-)

Maybe something like:

NVIDIA Tegra241 Hardware Command Queue Virtualisation (CMDQV) support is
now available via "-device arm-smmuv3,accel=3Don,cmdqv=3Don", giving each V=
M
dedicated hardware SMMUv3 command queues, improving performance.

Thanks,
Shameer

