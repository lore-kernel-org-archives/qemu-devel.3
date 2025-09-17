Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D50FCAC598
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 18:53:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyxGo-0003HC-4v; Wed, 17 Sep 2025 14:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1uyxGi-0003G9-PJ; Wed, 17 Sep 2025 14:52:40 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1uyxGf-0007zx-1w; Wed, 17 Sep 2025 14:52:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QgISSa56hNd4nE3pWGnfkMFCDLhy50T3EfzlUz4YjbD4Xqp228m52uJowmKCpmemn0SxsXcdzE5+JBR7mKtpFst/FJujRpQ6PCTBkvTPaFpduK+qDR6qdbF9tsG5mFX5Y4l/FSRi0CibZ/1ezEZXE0ZKckO1OgkNg94Okx3l1F0QCoWKGcqiTUYs15QS/uSPtgkPj0CHWa5LdcsJCShTeOCPGbfA5NRZfeFLnEk7VI9Tm7NCrn6VymaaUg1xgCafjSIE4tEHX1FHkGiY+SKqPKkCGkv94uvOu5WDzaVLdxAtU47HVUvtUyDlaUcAP1V1h17EA6M66ePDRt1AXSaycQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hoUMpShJFE5/nr6pX5yccGEfENUOfvzAGVhVcvsGRSU=;
 b=f7hxrYPuubrWvEpwkWPBa1zosMGrlDga1Ur3EbWu4Py/6lX+V+zebFkEl1NG9pBnhrnjFxSRFtsUM1SFx0vkxRmi5MHrdw08vJyGR1UCuq3VJlwQdoHLRsAVCO5bT5ZRK1Hm0XqhgGFnDt5YfAp4GM/T4wQ/JiNTno5Cqe/PMARgRKBLhaO6lrcfo+v5UQeX3IS9X8GqTwyS1O2lkIM+btr5UXhXm/gNh3quM4f7RT1jk5FVE5bkZa4qoLv0rA/tqt+2brslvWGxxpgr/Wz/6I9xScFDOfJeeWjVKPq8tmcytJLpls4gMnlWAF1IbB70EC9vcpbIjd+7drMejATAVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hoUMpShJFE5/nr6pX5yccGEfENUOfvzAGVhVcvsGRSU=;
 b=A19dd0FxF9AR+oCxmmoxfUkP4L955iAeJlzE21DzVuk3tbNM0WSI89QBZ9VFrTs9Xmvg2bgbqc0XRvX9gcdQ0/jXFYzgif7dTgjAAdCTCsOEwHJIrDxSqfGAr5PkqFqmHDxW4Fdxia6mTU5cOKx4wsq85KnYvnFWPte8U97SBYDtJKslntvqqMUHA/eI/L9NGn1ZKOqP/+9QFRXU9GiuO4U9cFXKxqb12jLS3Q+N1hUY0vrTbs9YLt9OiLnCcm7nVuvG4sAz6wJ98kSf2pVvY+uWQoLDQUUCLkWaht1pfoaPHSSAqJDwGCmuWnLEVEWhWka7i2QhXwKpTKGSvTPi3Q==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by LV8PR12MB9406.namprd12.prod.outlook.com (2603:10b6:408:20b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 18:52:31 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9115.020; Wed, 17 Sep 2025
 18:52:31 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>, Shameer Kolothum
 <shameerkolothum@gmail.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, "linuxarm@huawei.com" <linuxarm@huawei.com>,
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com"
 <jiangkunkun@huawei.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>
Subject: RE: [RFC PATCH v3 06/15] hw/arm/smmuv3-accel: Restrict accelerated
 SMMUv3 to vfio-pci endpoints with iommufd
Thread-Topic: [RFC PATCH v3 06/15] hw/arm/smmuv3-accel: Restrict accelerated
 SMMUv3 to vfio-pci endpoints with iommufd
Thread-Index: AQHcJvVSyZvN/mVpTUewNZT1jGrd9rSXuIGAgAABxLA=
Date: Wed, 17 Sep 2025 18:52:31 +0000
Message-ID: <CH3PR12MB7548347E93651468E70B2470AB17A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-7-shameerali.kolothum.thodi@huawei.com>
 <aJKn650gOGQh2whD@Asurada-Nvidia>
 <CAHy=t28z=wrXbXOJjD4sFw0RxJR3fccqF-EdaQDB_s_F6RC4FQ@mail.gmail.com>
 <aMsBvSSEzsgeMHkK@Asurada-Nvidia>
In-Reply-To: <aMsBvSSEzsgeMHkK@Asurada-Nvidia>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|LV8PR12MB9406:EE_
x-ms-office365-filtering-correlation-id: 9f99a229-d4c0-481f-e632-08ddf61b5b40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?m1bMB3SN6IZzX/pi8qJO6U/i6Gh0vQybGqUhXP8YCI7FOw2XeQVLeOkhFT4S?=
 =?us-ascii?Q?/iV/ziV6127LhFq0KYB3fA7xcPxuywxJC6dc91CV067tT81KLtLcO5OF8Ud5?=
 =?us-ascii?Q?Xv8WJbo1sJo/fw4icG10WCforMU6IB8/oOfrWXp3gNUHht5lUQT1Ct4+6UTZ?=
 =?us-ascii?Q?a02iBW5XLWCmUPKEMT2jGKusiLQM+WXsGLvPyxSOPEw+hR17vFxzaft4uShY?=
 =?us-ascii?Q?VVqD0EkkVOXus4vGxY9X4O2VYMU54V5uCPWAatPg2cqkBquAAXnQhJXNdIWA?=
 =?us-ascii?Q?FZ8FJzdpe1xjy2wmIV2yYEACf7VkihsNJIAwWbFy7PVZFJP3WELZ6ZlZUff8?=
 =?us-ascii?Q?win40LAT5XpDmwjEWGEsOpnjVY/QTRmSfTqPyZVDUxPwLSapMnQpKJ6nXiaN?=
 =?us-ascii?Q?ZXeHH6FoAZdLYSWltU5/rMFGilYjx97BmR/LGKLi+CS73Zr0SEsOp8gx+1OD?=
 =?us-ascii?Q?0OqSxybzSzJiNutmGfGAu5wjuBC/8V8oje3qomxJzje8FTPk84sbrpkPGmHF?=
 =?us-ascii?Q?MHmFJMqWva5zbm+wtRSdpWfjBysd/TbsgzrxpGktuinsRVG7sL0/sFKiSxrm?=
 =?us-ascii?Q?PAxF63GIip6bJ7VRjkTHQC1W5vDqseXxC4PF3O8Fz11rRx4xXP3mcdHbEsN6?=
 =?us-ascii?Q?b/NOD1CPfcITPKzMTODoO/sJGG8SNGZCKbbmamj0UtOk5/LeJ15isNVoWjh+?=
 =?us-ascii?Q?bv8fkWOVZnQ1iqW1zXfbbeUyFoiPzRo7kt9JFc1m8qfBrUc/4m3Ma72AxkAX?=
 =?us-ascii?Q?LFdLqSQfMxEetwBZYN8c9d8MOkz2MZzLANYviuV9Cygh/Y2Tc7RJNNFQPKbO?=
 =?us-ascii?Q?6b16V8KvxEXZK15T+fgdPJki/YxeYlG6jCG7LWcyZRayufdgVRGLRLpi19iY?=
 =?us-ascii?Q?KVvX8lx9M+304WOWQOueTyIEuarI6xoO9tAfYwE8ALakwEoQ7iL5Z1kt1xwF?=
 =?us-ascii?Q?As/tMoAVdiRV7o4tPF1FQmoCOV4IpiIblKi/EFjPMImy7azz9mVskjrQd4+N?=
 =?us-ascii?Q?wNuXK4oe0PQ/wJX6qYZg3h1gSrjEOMMoNOnp9oBC55ZCGlKVROBCF+waiO4n?=
 =?us-ascii?Q?7xH+GIphyWU1ljnf0UzFfFTwwZWwE+OZoosUnKcH9jXUF4aNy5Eiv8Ecfkv6?=
 =?us-ascii?Q?VrdgUjKc1Rh9GnqmlRO7Y/fFBnXMqtUwa3ICswvks0cyhce36KyUwLTFUWBf?=
 =?us-ascii?Q?F6aNH4iDm+whBNTpUZJH0lg8L3h4S4BbRQkdfu3dhloQzqzKuSFHQ8akfBAI?=
 =?us-ascii?Q?cXaax3DfWKG6cuzbM29ZuSi62kaasc0prxxYpdVQNfDBGDpWGK+pKtv5o4ls?=
 =?us-ascii?Q?4mPcOtE/Uw3lGIGxAlg90vgvcQ7smP3VdJKV6aeBthL6ZHuU1zHxZLPde/Q/?=
 =?us-ascii?Q?aq8J7bDtUk28ejM3L1turrwly/aGBrWdWx+TGaA4ls1VSw8t0HE0/x2VTzmh?=
 =?us-ascii?Q?6CSJZhPU/AaJnlGHniLPOJ6JW7Lt/WjuELHPJb90xda9/PNLlWJ7nw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m8Lal1kbYLhLsQ6W8RgyUd8LomPMZ1wScL8J4kmMYsC08RB7R2nBiHneJsb3?=
 =?us-ascii?Q?vR6tozZfBSi/33ZqiSLcFF+el53QA+ASSUrelnXGr4dtphXsuNaK+i0hyDqj?=
 =?us-ascii?Q?nIDJpH/It6erK0qBlejSNlzEvIxhDVDIc/GlhDynWpU3cGYhVk2fiID6VALV?=
 =?us-ascii?Q?gCTXMjeWbJbXW5mwX9xJe1QbhKs/6lcit5zgEHgdtv9cNrxWlq4dBGk4Wmu/?=
 =?us-ascii?Q?OFqvT1GatOsrsPvJdRy2zZeo+2qy3FpAJtxwL8Mn9AJrlpuEVwEHGlRAiOCo?=
 =?us-ascii?Q?i0OikrN9isLVHfk1T2PaG+RJneCSmUridiNtCp9HY74Kanr+gnaKWDiJY/tF?=
 =?us-ascii?Q?nIiwKepV1jAylw4KmWO7PJgH4b4kIuqHB4Lqj8kditaMAsRaXxpvPUhRTZ1U?=
 =?us-ascii?Q?hN+GcgemYczO7tI1/YOiBx+eLu8ZOtp+ucgToNwYhPjiv1Ly3+wVTfXR34Sx?=
 =?us-ascii?Q?yNCaPTLA7CEyOt6XzyQX9uFN3aY1+wI4RrZzjzIF6AQ9PFtFi4l/sYAVwevN?=
 =?us-ascii?Q?PGwr78roCuKPrkrN9f0rEZuCMaDQvx9oukedAZvmon0t47Hzl1mR5aIRP6g8?=
 =?us-ascii?Q?qrjCHOMTmULbWEW6PRY8YVp8cm3s3oSFeBlBit50D+Z6mr18aHLPZJkZ+3z1?=
 =?us-ascii?Q?BYS8Hkjr6de/F2fbH+AXRlL2dYUM0oqxE0wsXoYKBlT49Xy7KF8902l4cR19?=
 =?us-ascii?Q?steYDwWW0Q1SY94QryIUwXvJ0S+c0BpwFzeHYVZFGZY1jLOZAkYzQzZwHQWI?=
 =?us-ascii?Q?jkq6e7JqrpNt6WqgjbAyU9lvfwW+HcLMWxcvYL/+RQ+tefNC8uLVgVAiUB1L?=
 =?us-ascii?Q?lc6Et/g2VNPC/jRZ376sB45bFxTGfs4B90I/7tDF+Ip6vGLsCQ9eh72URvCf?=
 =?us-ascii?Q?4QGHYbJ4jOyax5LXjW76zLIXo12BbZbm5GfiZqBusdQVmsVI0tuuNpp/KBUw?=
 =?us-ascii?Q?tTeUG0j8f25lM9YCbs346alW/amlNc6vAsPxHd5iG1xTcH8cm7Vour5ZVP8U?=
 =?us-ascii?Q?aRjnZRLfCzLtwbj7RR49uSyIdcV2mo9DNku7DXXbmORaQxEHuL7RsZGa3CKT?=
 =?us-ascii?Q?eO/y1OKSDBvEf0HQXavfOZoj0GSO7B1XvHFqph0hSbqhJU5Go78/y5ljVRW3?=
 =?us-ascii?Q?Gco2TfTYFObhcXA3ybHMo82sHwOjSwhMubExMyO2krgFg3b/ahk+iK99FGfD?=
 =?us-ascii?Q?0ugifynTC4F+u11ibvF36tWS5/f+VribIc4Fo23AM/i+JngpDU8pwwKsEyvn?=
 =?us-ascii?Q?W4EudYz5X+HsfHl3+/oxWaTrXK/iODPw4u64Jo/6uXAAx9CCQTvLG4Ysbkzi?=
 =?us-ascii?Q?c69VJp9TvWuiGETfIegbO8Tdd6kFs5KBYmXNIGxMqx0o1R9gvpaZA5MagO4M?=
 =?us-ascii?Q?0x8INqoK0qzlT8PVTbFEOpfDNql/dU1ByW5KoYcRuFwioT00y8imsKdjzr/i?=
 =?us-ascii?Q?YTIG+K08vA25Y2mOtUnOarRck9Sh1guzYFpc+NZ92AhMPYOldD4FvscE2kx0?=
 =?us-ascii?Q?WEV3+ysCpL1YPE4dqFrwq/Xu997wpbey0pWYSQnMECUlhHkbJTlDKrnjg5fV?=
 =?us-ascii?Q?9Qx2MIXEnigBg1hA8cVmMijLEtDAeOyUfbUXo+9F?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f99a229-d4c0-481f-e632-08ddf61b5b40
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2025 18:52:31.1597 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FwS8cxSpgIIUVC3A9+N83Y4wq3JABJ7+CmM0wAvm28SJGEoYxgcZrkdp3PNVAXDX2JzMpIwp1rG6g0UCt403xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9406
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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
> Sent: 17 September 2025 19:45
> To: Shameer Kolothum <shameerkolothum@gmail.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; Jason Gunthorpe
> <jgg@nvidia.com>; ddutile@redhat.com; berrange@redhat.com; Nathan
> Chen <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>;
> smostafa@google.com; linuxarm@huawei.com; wangzhou1@hisilicon.com;
> jiangkunkun@huawei.com; jonathan.cameron@huawei.com;
> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; Shameer Kolothum
> <skolothumtho@nvidia.com>
> Subject: Re: [RFC PATCH v3 06/15] hw/arm/smmuv3-accel: Restrict accelerat=
ed
> SMMUv3 to vfio-pci endpoints with iommufd
>=20
> On Tue, Sep 16, 2025 at 11:33:21AM +0100, Shameer Kolothum wrote:
> > > I found a new problem here that we initialize new as_sysmem per
> > > VFIO device. So, sdevs would return own individual AS pointers
> > > here at this get_address_space function, although they point to
> > > the same system address space.
> > >
> > > Since address space pointers are returned differently for VFIO
> > > devices, this fails to reuse ioas_id in iommufd_cdev_attach(),
> > > and ends up with allocating a new ioas for each device.
> > >
> > > I think we can try the following change to make sure all accel
> > > linked VFIO devices would share the same ioas_id, though I am
> > > not sure if SMMUBaseClass is the right place to go. Please take
> > > a look.
> >
> > Ok. I think it is better to move that to SMMUv3AccelState and call
> > address_space_init() in smmuv3_accel_init() instead. Something like
> > below. Please take a look and let me know.
>=20
> [...]
>=20
> > @@ -37,7 +37,6 @@ typedef struct SMMUS1Hwpt {
> >
> >  typedef struct SMMUv3AccelDevice {
> >      SMMUDevice  sdev;
> > -    AddressSpace as_sysmem;
> >      HostIOMMUDeviceIOMMUFD *idev;
> >      SMMUS1Hwpt  *s1_hwpt;
> >      SMMUViommu *viommu;
> > @@ -48,6 +47,7 @@ typedef struct SMMUv3AccelDevice {
> >  typedef struct SMMUv3AccelState {
> >      MemoryRegion root;
> >      MemoryRegion sysmem;
> > +    AddressSpace as_sysmem;
> >      SMMUViommu *viommu;
> >      struct iommu_hw_info_arm_smmuv3 info;
> >  } SMMUv3AccelState;
>=20
> That's changing from an ioas_id per VFIO device to an ioas_id per
> vSMMU instance, right? I think it's still not enough.
>=20
> All vSMMU instances could share the same ioas_id. That is why I
> put in the SMMUBaseClass as it's shared structure across vSMMUs.

Ah..you mean it is basically per VM then. Got it.

Thanks,
Shameer

