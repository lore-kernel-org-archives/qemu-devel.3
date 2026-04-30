Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 951E9FF8873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 14:23:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wISGR-00043p-4q; Thu, 30 Apr 2026 10:21:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wIRcD-0005iC-G4
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 09:39:46 -0400
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wIRc9-0007bO-0x
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 09:39:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ECddYtNjDkIXKe918kzxbdRDqQMXFLrj5XAXJ7+OpwTBT0iQeXGl/E6+r2uAyOozyXX8806uxy9Nylla7F0yVS6djIxLLVBW6g9+JiuDBIREwPKRgX4OmALRIdzyKa25rHpMF1Biq8K1xA8D/hcbvb8WO+CeqmlIu0V/Ou5m91KGUS8nDV6RCdNtlpaw3LtTAqX0zGXXUUgc193JqybvdTumVmmqKgkVMwlOKNoPXhGrOEgA8CpoO4yev2MIRz3bmibVWo554obkEknoyjOP1e2usT2epZ5CEz9K2RyRpW2C4cu0ALXh9iucYEaUuIgccNqM/h1gPBuipPa97Zac9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FRrqdjM/vxwKN9RcZmmFdbqjXB4uctnUrtOSccl4w6E=;
 b=vT6eixz8DtsVGu6252EPPV12dhH831pHA72LvSDI0w8D+iVmjRQGw7T02PWODGk2Qx4KE27MoCaWGlBSbMczdRldmUhwVTDdEgUrgv8bOsFoR0Jw5rfHuRfJO3tl4mLu7z+jRjcETsFxXzxHVkdc3glCnK0sFsXfnmcTmRP773s3BHvhULImbpkpE2c8VWNpCHth4CPmLSJfJFWbpCLPYo46jj84Uegar3ar2kMzBydNpJug2fEnpNF3oyOYi8Fl8I4eFB2Lmso6CoWzhFy4rcv06RoXfrbcVsn4Sw8kD6nfjBmrZIDNqlXmilAtiOKDLeR6Y1N0R0Saj8t3BBBlZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRrqdjM/vxwKN9RcZmmFdbqjXB4uctnUrtOSccl4w6E=;
 b=fW+RicjNW7sj+8GL/UoU0FIBIRJluD2H8BkBKxCFdM7LKWmM0XxS3U85zv7RPeLo4yS9vDpGEcrhf2qw38grQKZqlfztQhiNQflvc0Tp8lHf8dXwdg1xBOI/kBFb1D/MSscUZd6cuVnZ065npzK/0hajaJRKpCR5LGIjv3t2uNjdsagn5ZY7sd7+DENwm9XW4u6FxoaVDNTbH6ZF9kAR9UgUQsSBgdmYuWFWVUQbx1UmjoH02l7mU1x7fvB27eQ146qt69GRW+HLRfsm6NtwWg6lQXeJCij8PSaTXUkbqpFJclqHnvaWw2YuN3WNpk42vgjBElL8Ymu1PHWdXNlg7Q==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by BL4PR12MB9481.namprd12.prod.outlook.com (2603:10b6:208:591::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 13:39:30 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 13:39:30 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, Jason
 Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@bull.com" <clement.mathieu--drif@bull.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, "xudong.hao@intel.com" <xudong.hao@intel.com>
Subject: RE: [PATCH v4 03/15] vfio/iommufd: Create nesting parent hwpt with
 IOMMU_HWPT_ALLOC_PASID flag
Thread-Topic: [PATCH v4 03/15] vfio/iommufd: Create nesting parent hwpt with
 IOMMU_HWPT_ALLOC_PASID flag
Thread-Index: AQHc2HDieohr3/cOMkaPlLBhofricLX3mVHA
Date: Thu, 30 Apr 2026 13:39:29 +0000
Message-ID: <CH3PR12MB754848E6244366B28A0784AAAB352@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260430071315.354333-1-zhenzhong.duan@intel.com>
 <20260430071315.354333-4-zhenzhong.duan@intel.com>
In-Reply-To: <20260430071315.354333-4-zhenzhong.duan@intel.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|BL4PR12MB9481:EE_
x-ms-office365-filtering-correlation-id: 0f3181be-9d3f-42f8-24dc-08dea6bde7b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: nTqX6Ccp/cjTbmItZIw2u7XjaPp/x3KhZFRpIOrqlDEClY6we4lQkNRw6H+Q9iGMckgy4K8NWsdoS4Go6I9Y1o59TIMTmtSZLDy8dqpM/H/bctyddDXXG2a+22TAd9tBSU+RWcNF0biUXf+v0wm88qpL22RAt95Rg7qL3tjzHnpBSCPv/rBgkRPewOV3dFWBcsDQ3KRR5uh30SQ/Cf0uRwd9LNdTZOeD3cmV/vwD9Gq7SnMKm15VbOLDMLYIju8JIon8UuBwbHdmypiU8OOVGRaevOSu1ZeHtDXiMat07Ne6m+QMz56EB6tsQKq9HpoLW8iR20OA8MrCNUb20xJdMHkVV4TSQu7MsjiV3a4qtBzSopInQiJyNHuYiag3j6jopQ+P2/Yr3fwqB4nwfWrqBUEgMLFRRUtg3EgToo8lu59drXGqblFBuns0mb+3HfovSo20wShh7JOOWbVZqBw56iPA3hWAvEP6aSM4Ub9mmJzzidGMaYmfc93AwIfDvZv6VCVDG3KSycBSXw74q6BdSogO9P2t/fnKYw2Ps+q08xMak7qaaIUS769NTPbO7vZuk2PdtiAL54ZNexAEu3HL+tLL/1xBTA2iJYjTAY2y0lre8an8TI5YlSs7PVXQL+08+F9KfyFNFNNSbP5fJa2f7JHXhsNEngd+DuSgFsg9QDT7s7/Ss3DAeZ//PlE4wYux7bUQZU2ns8i4rUNwA8nKXpBzpSGzsLTG/dpbCTlZuQq/0f1+CINTVRzA7EEJM4QAhkV9OQMBJTJZlS1HjcA/mE2W0Ki99aTBZQeBB8kgScU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yYWbrZwmEl/FCv7OeTYyDKpA6URc2SrenAfnTYkKYcOO0oCRfAEt44aG1/Ju?=
 =?us-ascii?Q?ryaFmM5Kq8JnZ5JBDPM0bqmWuWPPKrCokjjrfqW7JFvV23oxMu85m0jvrDxb?=
 =?us-ascii?Q?0Lfel9TOkSRDT7yafZrmqj+j1AE9S/TGrdGBWfhlcsbhkm55bfN53a42VDPH?=
 =?us-ascii?Q?Un1qQ/WzKAkresEIt99jjTbjfdOSEHGOJKl0e6iiPMT31M9uTCR6qJmnysdD?=
 =?us-ascii?Q?GIKf6mK5EWA1S6GiSiEXpEvoBafQfCxkJOqwDN1v24L5FZHFAb4tkObfCflF?=
 =?us-ascii?Q?tiBbOWv9eIbqjoeXd1JDKyLyhvs907veIMgyTsGBj4nzfJ0c8GPX1NZ4b9Vq?=
 =?us-ascii?Q?9do1e3v6rTTXG3S+Kw1H11cSRHm7y80oz///m0iiBl+GxU8NqU4b8jMIMPcQ?=
 =?us-ascii?Q?VGRAjuVVM3pYwZyOnOVXymR/XmdOHPk62sn26Omsq4wzdV6hpENNs+WOjbM1?=
 =?us-ascii?Q?rwbiK9tmvRIdhIAZBZedgOkaswqXy7pMLYakfgDjyKE9FQJSqxrrL6EnEbiW?=
 =?us-ascii?Q?djrWG3YyrCK9//DhJsFBenrBx2v1OuwIQIs22YsXHNuxaCbz9ld2KB9uiyju?=
 =?us-ascii?Q?iSu20HJDg2HCX37826CXv01I4Ib6dM5BApiXg4W28ZlyY5XwHFinU0ZkurpS?=
 =?us-ascii?Q?Ojbwdv4fa76k9GdwlhKkbc7kXupf5Z7Jeecq7JEbHW6IQXBKr+TxDPXMKQDF?=
 =?us-ascii?Q?Sz1fPK9HEjX4ubIfNjOuR7FZ/0IB2u6av4xzMZcOt4LDcvfvtJ1BpmAMHMDt?=
 =?us-ascii?Q?M5wvZkW8OoFCcLpe/4voE11PwHfsc9obzR2AvJLxQO4RSpJk5CJWyv2L9hDP?=
 =?us-ascii?Q?lOma8CFOc2jIjBnFOpLD3tS5KI9AKLhpUMIRBExtjn2lVK6v0AYm3aK6LMDd?=
 =?us-ascii?Q?Nvx9EeZOgmqGGH4ezcAzRjqoPRGAgPwfVsPagHeWjYiCPprjDaKeb0DsHQOO?=
 =?us-ascii?Q?Bvb7vzoK8pNr7fpmoX+eMnQPvF8LZfMP2r3L1/lotdDSwBSanipKe3WQMkX7?=
 =?us-ascii?Q?D/1xt2RwyaMk5TCHGvL+5yY05ZAUgcSALivjr7vb3BUjbWdRWFhe9muqGAbw?=
 =?us-ascii?Q?uhOGYM7Cmu0p/uHtZiApyUZoy6s0YwN+DdZhNIvQJTWO7eduh4O+eyuUz+KE?=
 =?us-ascii?Q?/Li35cKMWGkGk6/PV0C61om1rDCkoCrVmqDtvOkoAYzVWWud5QHtDeegdpAo?=
 =?us-ascii?Q?XNFfaTFkeCbWRqEiuqORQBMoJNv64PKX/poZGLBt9+bOEkTUBu5RizZU0LJk?=
 =?us-ascii?Q?lEqyTwKbMDch1n5KJ+3Wfsvm8s7I1coOZtAmTXj9YPPVI04g5Y3pHcRoE6Fx?=
 =?us-ascii?Q?xX8Yky0AAAflOaLPmsjpOTy6W5oGBweFgWz67jRUUX9ZwBrSKf3YsEIKAb9H?=
 =?us-ascii?Q?dN/tK5urO4DMYPmoN9Y9OlOS74pQEKSz+wvQx+UJ64Nh23rClHZvfzoSZKfT?=
 =?us-ascii?Q?QsPNn6tstfkvMtyKYmW2aJWY+TnXQNSPiuZ/Vb4cJolt9eejUqMWIWX41yYe?=
 =?us-ascii?Q?/k7ixM/gsO47qnUmJkP6WmhYQmcMnZL3PfqIpFV1EMQZLYiB1WzrOCbJlus8?=
 =?us-ascii?Q?CoezUopWvxD7hdv/DJxK00zWPLfivL7d9mEwgn9s9usCpIzJGjx+KsjQpT5X?=
 =?us-ascii?Q?KaRup+L1xCv5TKbAEq1KUhDdsRKE4R5Uj+/kS7MRj2KIztMdujSVON1VXEY8?=
 =?us-ascii?Q?C2RopAebfXE2Jv+Ll1dmxUnpMMLLWsQJgh5NM6jL1MWxOoTAKqj6t3w8xoEw?=
 =?us-ascii?Q?MTJVNZ/pJQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f3181be-9d3f-42f8-24dc-08dea6bde7b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2026 13:39:29.9330 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kXRAXNCjKXY7RvFlLwTc4QozZUYMxbg3cBOz0S2iPRAO6KiFFW9UIHcxCM77TDn2ORRh7bdC0iEtaiC7gEKkKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9481
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
> From: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Sent: 30 April 2026 08:13
> To: qemu-devel@nongnu.org
> Cc: alex@shazbot.org; clg@redhat.com; eric.auger@redhat.com;
> mst@redhat.com; jasowang@redhat.com; Jason Gunthorpe
> <jgg@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>; Shameer Kolothum
> Thodi <skolothumtho@nvidia.com>; joao.m.martins@oracle.com;
> clement.mathieu--drif@bull.com; kevin.tian@intel.com; yi.l.liu@intel.com;
> xudong.hao@intel.com; Zhenzhong Duan <zhenzhong.duan@intel.com>
> Subject: [PATCH v4 03/15] vfio/iommufd: Create nesting parent hwpt with
> IOMMU_HWPT_ALLOC_PASID flag
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> When both device and vIOMMU have PASID enabled, then guest may setup
> pasid attached translation.
>=20
> VFIO needs to be aware of potential pasid usage and should attach the
> non-pasid part of pasid-capable device to hwpt flagged with
> IOMMU_HWPT_ALLOC_PASID.
>=20
> ARM SMMU doesn't support IOMMU_HWPT_ALLOC_PASID, only VTD need it.
> So
> we can't check the existing vIOMMU flag VIOMMU_FLAG_PASID_SUPPORTED
> to
> determine if set flag IOMMU_HWPT_ALLOC_PASID. Instead, introduce a new
> flag VIOMMU_FLAG_WANT_PASID_ATTACH which will only be exposed by
> VTD.
>=20
> Opportunistically add documentation for VIOMMU_FLAG_PASID_SUPPORTED
> and explain the difference with VIOMMU_FLAG_WANT_PASID_ATTACH.
>=20
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Yi Liu <yi.l.liu@intel.com>
> Tested-by: Xudong Hao <xudong.hao@intel.com>
> ---
>  include/hw/core/iommu.h       | 11 +++++++++++
>  include/hw/vfio/vfio-device.h |  1 +
>  hw/vfio/device.c              | 11 +++++++++++
>  hw/vfio/iommufd.c             |  8 +++++++-
>  4 files changed, 30 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/hw/core/iommu.h b/include/hw/core/iommu.h
> index 77739d4214..20d6d79062 100644
> --- a/include/hw/core/iommu.h
> +++ b/include/hw/core/iommu.h
> @@ -20,9 +20,20 @@
>  enum viommu_flags {
>      /* vIOMMU needs nesting parent HWPT to create nested HWPT */
>      VIOMMU_FLAG_WANT_NESTING_PARENT =3D BIT_ULL(0),
> +    /*
> +     * vIOMMU supports PASID capability, VFIO checks this flag and synth=
esize
> +     * a PASID capability.
> +     */
>      VIOMMU_FLAG_PASID_SUPPORTED =3D BIT_ULL(1),
>      /* vIOMMU needs dirty tracking on the nesting parent HWPT for nested=
 use
> */
>      VIOMMU_FLAG_WANT_NESTING_DIRTY_TRACKING =3D BIT_ULL(2),
> +    /*
> +     * vIOMMU requests other sub-system like VFIO to create a HWPT that =
can
> be
> +     * used with PASID attachment. VIOMMU_FLAG_PASID_SUPPORTED can't
> be used
> +     * for this purpose as PASID attachment is needed by VTD IOMMU but n=
ot
> ARM
> +     * SMMU.
> +     */
> +    VIOMMU_FLAG_WANT_PASID_ATTACH =3D BIT_ULL(3),
>  };
>=20
>  /* Host IOMMU quirks. Extracted from host IOMMU capabilities */
> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.=
h
> index 380a55d6e5..8472420d3f 100644
> --- a/include/hw/vfio/vfio-device.h
> +++ b/include/hw/vfio/vfio-device.h
> @@ -282,6 +282,7 @@ void vfio_device_unprepare(VFIODevice *vbasedev);
>=20
>  bool vfio_device_get_viommu_flags_want_nesting(VFIODevice *vbasedev);
>  bool vfio_device_get_viommu_flags_want_nesting_dirty(VFIODevice
> *vbasedev);
> +bool vfio_device_get_viommu_flags_want_pasid_attach(VFIODevice
> *vbasedev);
>  bool vfio_device_get_host_iommu_quirk_bypass_ro(VFIODevice *vbasedev,
>                                                  uint32_t type, void *cap=
s,
>                                                  uint32_t size);
> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> index 3ffd69a579..b954b44d31 100644
> --- a/hw/vfio/device.c
> +++ b/hw/vfio/device.c
> @@ -544,6 +544,17 @@ bool
> vfio_device_get_viommu_flags_want_nesting(VFIODevice *vbasedev)
>      return false;
>  }
>=20
> +bool vfio_device_get_viommu_flags_want_pasid_attach(VFIODevice
> *vbasedev)
> +{
> +    VFIOPCIDevice *vdev =3D vfio_pci_from_vfio_device(vbasedev);
> +
> +    if (vdev) {
> +        return !!(pci_device_get_viommu_flags(PCI_DEVICE(vdev)) &
> +                  VIOMMU_FLAG_WANT_PASID_ATTACH);
> +    }
> +    return false;
> +}
> +
>  bool vfio_device_get_host_iommu_quirk_bypass_ro(VFIODevice *vbasedev,
>                                                  uint32_t type, void *cap=
s,
>                                                  uint32_t size)
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 78e7b6a045..0718f029ca 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -364,6 +364,7 @@ static bool
> iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>      VendorCaps caps;
>      VFIOIOASHwpt *hwpt;
>      uint32_t hwpt_id;
> +    uint8_t max_pasid_log2 =3D 0;
>      int ret;
>=20
>      /* Try to find a domain */
> @@ -409,7 +410,7 @@ static bool
> iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>       */
>      if (!iommufd_backend_get_device_info(vbasedev->iommufd, vbasedev-
> >devid,
>                                           &type, &caps, sizeof(caps), &hw=
_caps,
> -                                         NULL, errp)) {
> +                                         &max_pasid_log2, errp)) {
>          return false;
>      }
>=20
> @@ -437,6 +438,11 @@ static bool
> iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>          }
>      }
>=20
> +    if (max_pasid_log2 &&
> +        vfio_device_get_viommu_flags_want_pasid_attach(vbasedev)) {
> +        flags |=3D IOMMU_HWPT_ALLOC_PASID;
> +    }

Here, suppose a container already has an hwpt without IOMMU_HWPT_ALLOC_PASI=
D
(from a no PASID device), and a PASID capable device then tries to attach t=
o it
via the FOREACH loop above, does the kernel return -EINVAL:

ret =3D iommufd_cdev_pasid_attach_ioas_hwpt(vbasedev, IOMMU_NO_PASID,
                                                      hwpt->hwpt_id, errp);

If not, it will get attached to NO_PASID HWPT and return there, isn't it?

Thanks,
Shameer


