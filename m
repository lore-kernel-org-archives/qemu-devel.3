Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41D8CCCFA03
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 15:55:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFwsf-0000ca-J7; Mon, 03 Nov 2025 10:54:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vFwsM-0000aQ-12; Mon, 03 Nov 2025 10:53:48 -0500
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vFwsE-0004kj-AU; Mon, 03 Nov 2025 10:53:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oZNTYIYUhfW4tmbX1GyNqMbW7wgFrE7zf2GnIIvBMBZVts/07YujHSeguJc+sqQ4wjg85VTgoMvlofVDCY1EXNbGUki2GIWsqCcRh77Fd7e6qQY5xJK418aj4y+HxDaWC8RM/RUGli+87jjIzMyM5a9NoiY/E6ADfwz70FcQ0GkY+XB/uLGkoY8ao/jSgyJU4OM9Bj3LJ4ET0c5Afp2qgJoEW7JHQQ6kUVRSEjEVqCVotsX13+zY5AVKBrrtLhgFN89AOlm64FJgYBWe7gxmk8SvtCTM967duDJX6pNKUrsiclF4kSt/Gj4rIW45JKyF4zNl5BBLnLL5qi5AyLlGEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8SJxU5/pbsP0I10wjyjzqA46Vy2dQg6lsG0DjBLuxkI=;
 b=TiSu4kQIQ+/TAAwnVVWp7ZbwUpj9wngQj0ykC84PUk3wNKKNKowndTx2MAa9AaIKoAKD0SD0oY/py99GtOVQu6XE8L/72n+ev4RTs91GnFh8YC1wSBj9+OHX2XC/zal/6GwkN+Dvt9ll6MngeKKkyGSOGsY3hpkkmPbXIUUDryLFaUJgtYK+OXJLCsWNEBE+gr0gs4avK0eprKE+4BBHxiBY8Qtq2mLiZv2q+0uPrQBOoQ4E06md0uXfPm8c2MDgonG6Y9pcG1IhLY1SxYyg1GMw/hv/eEljg0XiDK0uNJuPt0xxxWhJePsRBbNB7vERNV1Jz3M37OSbuLQhLLUtEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SJxU5/pbsP0I10wjyjzqA46Vy2dQg6lsG0DjBLuxkI=;
 b=Y7W6sU8ENRkqylbINJGmx/zYbtvIt/g+RktqTM2bSrvJTBRqvHUjVkRuqnbicAjIuv/B3zgBftof4wTZqf1D7oitHqgGJlGm+JmvjzTChCSP3oOvWzS9DdlnT/Ljz0AzT4fTBy7W7F2IkG/jnTVAnSkvOtWGg1hSaARnlJdfTjaVUQJMkwEGIdfDWLHgeqI4LYdLUhYagt5MPnhkXbp4r5VwvT0OH+8a4ITPJdv9xECEtnsB9Ewmj6rXeYRAhmgaDVZTOP9tsAdBxkGvxO1p4SiJPK5iV/t3Yf8mUFNCz1zBi1sTC4fjwjYPe4fFJAmpSWsmd59g2nmm1G3Fk8SeAw==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CY8PR12MB7193.namprd12.prod.outlook.com (2603:10b6:930:5b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Mon, 3 Nov
 2025 15:53:24 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 15:53:24 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, Nathan
 Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, "wangzhou1@hisilicon.com"
 <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, 
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v5 06/32] hw/arm/smmuv3-accel: Initialize shared system
 address space
Thread-Topic: [PATCH v5 06/32] hw/arm/smmuv3-accel: Initialize shared system
 address space
Thread-Index: AQHcTMN7PrjQaU5QuEmxxa/ZVBB8ELThGk2A
Date: Mon, 3 Nov 2025 15:53:23 +0000
Message-ID: <CH3PR12MB7548011A8C438654BA914FDAABC7A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-7-skolothumtho@nvidia.com>
 <20251103131219.000079ca@huawei.com>
In-Reply-To: <20251103131219.000079ca@huawei.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|CY8PR12MB7193:EE_
x-ms-office365-filtering-correlation-id: 72e71d6b-8300-4380-4d68-08de1af11ecb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?FblWEUECEQqWHWmQYOlwOtPb8Zk+zmkob2cLzbtyFVHvWcB0hhJuiLhkY9bA?=
 =?us-ascii?Q?F59PftXVdsp9JfKgO7qbCY97cCZOApO4Inm2ggRFfc0qKX4jF4QenBKTl6xT?=
 =?us-ascii?Q?73P6+x31p1zgMLLesXBE1+Ge8vHNl1Rj/aT6TlvvY9xa8PYtrxXMCHyGcaGf?=
 =?us-ascii?Q?gWv5yVtWjOUGOH2ZFX6KYXD+ASVdyZqEFO0uGRCgPPuiWCcLloW6KCPSPCCm?=
 =?us-ascii?Q?ya0MSQY50/QNpKwyBfhjuihSWmvFKhfhosaAVavj9v3ZgeZ/wdNt/cd99tLa?=
 =?us-ascii?Q?osERgu3Mvz/WzTHJIsoRyLhDjRoIwb5ilWMu228O+jmqcUP4cnNSn0HjhWBV?=
 =?us-ascii?Q?1Ng4HGsiSKrCc33q7EiFGZJq/X0gZxAFePBz3TgfgYU87NfZE8Mz0R4QWTrQ?=
 =?us-ascii?Q?d5G2MX4tUlWdCv22B1ZGJGTBjy2NhVwcIN+wIuHDW9Oe/gfwRAEhIq0P8DVv?=
 =?us-ascii?Q?7kv22sHEt1+Rrj1ItkAMZCLrHYLVih2O3MYYjZ9Zz6jFrahrUCC2w1P5+nWa?=
 =?us-ascii?Q?4tLohzDcEpR7GcoMB2AaIbXZ7b6xrLH4E/8R1pYEeLR7f33dFgydL+IVcDcG?=
 =?us-ascii?Q?B3wpmImnzWpWEISNUiosK+skAi2XfSwE+cwNgnSdrNgSGL+8qri/MiY1t/He?=
 =?us-ascii?Q?nhwZk+rjB073Ybbl/qCHbmGpVgnnsYzmZLMLae4kVuNhg/5HAqfwxk6b4li8?=
 =?us-ascii?Q?SM/rceHY4Qz5Ux0MxMWtm36MRYQ6lP6ijmw94JT5/Y/C3n38ZyBacgj04ER/?=
 =?us-ascii?Q?oMokB0xP7ok8sopQS80JKzerY9WFkA2Gf4hXr5as2l+PcydRjC3irZqm1pJf?=
 =?us-ascii?Q?ErygG74ruZ0CbUJXRL1drJU3gKsTOH11vvFieJsVkkBqtaRJc+jvA/xA8lHr?=
 =?us-ascii?Q?T8c9h6Ijb7Isqyu36FUq2pcX4D8elEJ9VXn2mF7wkguLEBr1JE0fBxfw/AJA?=
 =?us-ascii?Q?rCK7evprKNJB27QVbPbSYyY7kHFqRAMq1IuXZ9lnznTGAfxwBiO2NM6PPOCp?=
 =?us-ascii?Q?vx/ABGOEyixJRSrxTdx520czg5l5Ge+cgynuOzHDTutNv89B6K8cSeSh6pGM?=
 =?us-ascii?Q?8V88U/JW9DqaDyLY/XqmHWrAozMzKOgHKXTEQIDwvzrjrVgXXD6kxLqzcpme?=
 =?us-ascii?Q?dBv7oDY9tqu3Tns7R+tr1Fqx1fyVKQk0TiXyTujG6h9PzN6A17shioG7tYyl?=
 =?us-ascii?Q?xBdV7S3NGdpTHDTVCqaCXXrf2zxLOLiPqzqmH5r7ru32HTEC4tv6WrMAzy1+?=
 =?us-ascii?Q?dSsrbS+eBvTdfroR5/Tr4qY8tqaLinnckBclGGgumU5n/t64ulP+HehYspar?=
 =?us-ascii?Q?zUxNM8oNOhVItIqu7bUMT1W6cJnB+4OFLGWsm+2Q1YcYuPky5VsSvMxpVGXp?=
 =?us-ascii?Q?0a64cPjJGhg5gU6xYPbQMn8zsSto31hZUY7mhn/NTENZ0kzk0Oy6rLoFmVRp?=
 =?us-ascii?Q?P3H8+9hM/oWhUnB6mdfh/8NSLtibYOJ2WlEMRp1GSwKYqqI6vkzUoYrkkLM5?=
 =?us-ascii?Q?3H1letpWyv05/aidNP0U5UoN/AUjz6lPyr49?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DgQ1bnWF0hXDWCu0zeaNtGLo5qGYGPQV897iameq5CLXHA2LydbwtluOq8TN?=
 =?us-ascii?Q?WiGhvOMlDXESq/5VHg60/ex/a2moSpQHk+ToT/O8eXnKxoYNrLZwALRShtkY?=
 =?us-ascii?Q?9DQAX4nnKerQyhBWlZ83Fo9rU4qAYVSat47OhpS8c2lwICSmVClglC9UyM1/?=
 =?us-ascii?Q?LPo5T+L2MubHSnyUAX6hRqtkirPsIXAOj3CplAHBb1AJxA8PI/kUt9b84TFY?=
 =?us-ascii?Q?kpHovr0SY++cLC8lf4bByfY7EIMEM1zo8XLN9sG3wQfK43ibwZBK/xcMJUVI?=
 =?us-ascii?Q?bBArFtiHMQNf5m67bAUrI1I28fNoVzVlY3ss/AcitFo734vLi0EQ2Wsjsnam?=
 =?us-ascii?Q?vXZozHxlLzzJtsebtsD80qfMcaW1uXq+nnvq19tx4AVE5IFVtcWp9nLGo1m1?=
 =?us-ascii?Q?LgQe4SBvaYwoaPAbfnzCPvl2ykT9TdrwoyDF8Pp8J2N+0OEDUmLvdLBum7Ga?=
 =?us-ascii?Q?aVXfwghRbfOzwGT5aSrK3OfTl4vHonOWLP/WMFnJ0qo0nGSe4qyxQjtmJEFY?=
 =?us-ascii?Q?S/m2CrTkBwFgKg5ZaMD43bH3vdS3Y420U+4HwV7TsL5TNJbecfoug/EPitOh?=
 =?us-ascii?Q?Zct0ICAAS8oGpbrdfoAoLlxzsozERTUxMFf+B8rcPkbZmj/qXXCU/4+iRPPr?=
 =?us-ascii?Q?VMZtagmnyttXiEnSi5SaoqH09AmA41vpuAP8To27V/e4iukFIxAOwVzaPA/3?=
 =?us-ascii?Q?1tLSCOEI2EgPZkCNjthONLM5G1UxWub8Zmbn9QYnpapDgkllJ0DMcmbOu1Cs?=
 =?us-ascii?Q?u+8gYdwywuTa9anQz31ht+KFUxCG145lxmuxcAtmYLCF/M6CvkQqGdIypy3u?=
 =?us-ascii?Q?iJ90qHFR0F5XJN7C8Y/vw93EeuQbQxzqV4DEi9v47jVJ5zFRhWm3qtbjGkRS?=
 =?us-ascii?Q?l9/39a0SW+5zuibt0jsfq7La4xvcqwZoUqaTXZ2OZH4s2u3Ib2yylk7IHbtt?=
 =?us-ascii?Q?xbocJqxiXEUZXGKiyT5bol5Wtl+GK9dSr4Vq/gk1T6hz2rRnch/OeV0dM5VT?=
 =?us-ascii?Q?s1GjxPMx5Hfq4t7QBb8HXTpNulQxkMeYBRmvuRGg20pLlyY7EBUP4t2RRjNx?=
 =?us-ascii?Q?ytGgz+iH4bZKUF7xH74w3TGjeAgAZNAyyJ2suZb3MI8toiGZvIUwxoMaKnTF?=
 =?us-ascii?Q?hiKI53Ksavw0KyXvrlhmBKChdqm/18ZdyilxQgJhmJndTxGfa02wgDLWKyBE?=
 =?us-ascii?Q?ChIDFUXZlYplu/rRoFVQCklK+744Ow0sLcTZRNy+wq5CzxE7p3TJrDc6qdsK?=
 =?us-ascii?Q?BlFppHGfrTIMP7Npo22K+dz9bjXByCNrsj6xPeMSiQQwlj4M9Mh1Wfah4TvC?=
 =?us-ascii?Q?/Cdh31XuPg1kq57HMWvWDEzItnv/d0B8dPM2v6yM6SOURNUWKUX5vhlhZM4j?=
 =?us-ascii?Q?Y7gq0lewuwY+zltlUQV2rdU5IC/3luB82X053twhFq6I9+KRCcn5nO5GSGtm?=
 =?us-ascii?Q?qcenBAEcI4I9gb2pvodu9Nxh7ELlVRGmB/c2uoXHhIloC4CAYbZL++n/Rj+R?=
 =?us-ascii?Q?4/1TeOfsev0PhIdAlObLjk5JsOdmJmqNpMAtJ6CbRYc0BBaIITGacEf2JuAc?=
 =?us-ascii?Q?fbn+Ky6l7/7krKvgoxAWdRmHHrGslRGla+hSeOhF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72e71d6b-8300-4380-4d68-08de1af11ecb
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 15:53:23.9212 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bCNUp4/1HxaczKPQPW5hx22P73nNO9nPt0gu1o/HWYpngVPzxTKH4uirPoEhk+2tqSus8rWMdh4abMylJE6YGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7193
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
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
> From: Jonathan Cameron <jonathan.cameron@huawei.com>
> Sent: 03 November 2025 13:12
> To: Shameer Kolothum <skolothumtho@nvidia.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; Jason Gunthorpe
> <jgg@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>; ddutile@redhat.com;
> berrange@redhat.com; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
> <mochs@nvidia.com>; smostafa@google.com; wangzhou1@hisilicon.com;
> jiangkunkun@huawei.com; zhangfei.gao@linaro.org;
> zhenzhong.duan@intel.com; yi.l.liu@intel.com; Krishnakant Jaju
> <kjaju@nvidia.com>
> Subject: Re: [PATCH v5 06/32] hw/arm/smmuv3-accel: Initialize shared
> system address space
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Fri, 31 Oct 2025 10:49:39 +0000
> Shameer Kolothum <skolothumtho@nvidia.com> wrote:
>=20
> > To support accelerated SMMUv3 instances, introduce a shared
> > system-wide AddressSpace (shared_as_sysmem) that aliases the global
> system memory.
> > This shared AddressSpace will be used in a subsequent patch for all
> > vfio-pci devices behind all accelerated SMMUv3 instances within a VM.
> No problem with the patch, but perhaps this description could mention
> something about 'why' this address space is useful thing to have?

Yeah. The "why" is missing. Will add.
> >
> > Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Thanks,
Shameer

