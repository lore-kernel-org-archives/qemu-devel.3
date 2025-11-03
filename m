Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F05CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 15:45:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFwj4-0003BG-2X; Mon, 03 Nov 2025 10:44:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vFwiz-0003AJ-0R; Mon, 03 Nov 2025 10:44:05 -0500
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vFwis-00024C-5p; Mon, 03 Nov 2025 10:44:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C/5cURHTzuRSAh80AkT03WBwyQ7hcqO7efPxgjA7xHtVNoA7xVe5PQtrmEWE1dOkE85H9VYeBfN67X0qrU9U5VCa3JAdfyP4/d9CVPnbp5OKydF8Y285uB8JW29tEJw2EVcxQ3/BFF3o3chjKTSN68XbdJrZZtHqVHoT1fZxR+3YQBmD1VuzX81MeRdPMUqLhRcGRJORWHh7JB1VC7vtzma+n/WOUGXX0TktxERzdgYSFyzAkT7N8rZcduQQSyDTbJa2ApFAmZWzWHAk+T937qQ39k7CrHWO0Fy5xeEbhnFVuQp30ENhlqHWPQl1rCkp8L3REeNew2/cjj6tPTbNLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qNPEcrNVjaX/9hcCcDJ0ei1KXAG6T+NFTMGcUJI6X+c=;
 b=qQkkWfTkxJ/K1fF7wpAMYfRY1A9eF9dY80IjocUBLkKq8lv1EPTCLgLCGwRyEcGYIflZ6I8SHJ2GXZyAPNUuqz+7nJjdI941p9UHxSKYXrVFxhBwhs8/ivqbj066VL5kJmuA8tiZjjAiX0iu4SJq+nRLezrbdsnKmtufGlWXSO39QRKfBgSa6h1KjSCANp+ya7bKfzUhRSVeCsKpv4pxUs0IFXf8Qrj0NdGuMXD0q9jQbvXiQoUwTTNnaH1WIER+UfynoD9Sue7NIQoSABfoqUoUMjV4fFqmfxgms4OmcbySvhVGKHyVhZq5VHb8K7ddHadguyPi2zpDAwgfkEZKNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qNPEcrNVjaX/9hcCcDJ0ei1KXAG6T+NFTMGcUJI6X+c=;
 b=BhrlUrflwPy5uiNZNCIZr4+cPvlCAxd5qP41nNbg0MsQ1wd/73k5NaTjsdAgxlEDdZtqotJUiaP+fF3G6OjkUu3gs2CV6H+ro/uiXo6DLCp5vuriM0u0Y5RVKbbGOT59o45IzfM6hoc5yfSQXHWq/HUUHE/iT5aPNJ1052qmfEAyDnEiUWlyHZP6mbg4uGpz016A9vdxU7RAmynx74UJDR3luld4borBxAeD0iSsYpjdNtxIHL5jbysflCJ0n15Muo86Ede1Ye1RVVbbPjiVaB2hkmJkFsI9x4k2KNb70nNa0OE66Z25hpf9I3mf46TF28s5VjiEdZdaDt0TzIuuzg==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Mon, 3 Nov
 2025 15:43:44 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 15:43:44 +0000
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
Subject: RE: [PATCH v5 23/32] hw/arm/virt-acpi-build: Add IORT RMR regions to
 handle MSI nested binding
Thread-Topic: [PATCH v5 23/32] hw/arm/virt-acpi-build: Add IORT RMR regions to
 handle MSI nested binding
Thread-Index: AQHcTNGyRm6NIJof1E+8Vd2Q6CYHjLThF2rg
Date: Mon, 3 Nov 2025 15:43:44 +0000
Message-ID: <CH3PR12MB754878FB353F2367DE5F46FDABC7A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-24-skolothumtho@nvidia.com>
 <20251103145352.00005c24@huawei.com>
In-Reply-To: <20251103145352.00005c24@huawei.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|DS0PR12MB7900:EE_
x-ms-office365-filtering-correlation-id: df693303-43a5-42ba-4bc0-08de1aefc55d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?IE/IqvUDUL3pD4vh6XwHzhyAehmnYGYDpzOJLN6mD72wdtA6ApZ576e7n/iN?=
 =?us-ascii?Q?ricVZ4mIClCpjkaTGTa3kYUHT1Rm3Wnzf9lACIs5kcPWLXuKvidbUQV4QnX1?=
 =?us-ascii?Q?xewfSVF3Bds8roivcXXYIhFN8OiymHTDLMSse8k7H6dRLuVgx4EFNAOFPgyO?=
 =?us-ascii?Q?Y318K8mDIZ9mEk8g179c8AEP/sSBYDVC1GXEzDLHAMuZIac1U/wnMyT/k2Oa?=
 =?us-ascii?Q?X2B0BwaTz9+fRv1HeoDP+YoPlK+EtU4giKTrtDGeTEBl6WRTaEsNMvHFhXQe?=
 =?us-ascii?Q?NQwmVUIOpkpLwXNKFVexqiw9+nr1lj/YY/1/nwpS5LgyckkP0bwmhxTHGAfP?=
 =?us-ascii?Q?n1HNCGJcDcT2SPMVoiEYuEd6fBBQ9FKAx1fAT/LePDJizcJlD0Se6IpZ/5ca?=
 =?us-ascii?Q?O2LBthxV9kGdtHXaHp7G3jay3GyyKU0t7HCMk+my9a4QOrS0CduTCUwNWIm0?=
 =?us-ascii?Q?UVdj9mZv3ZSQjDbaKA2qJeiUahxGqvXZc/rFuIMCECFQ2E+IpCO5wHgKRS5S?=
 =?us-ascii?Q?BreX+1fPahrzhQqPo/ixpsKgw1WaLLhvj8EYK9haqnY/BZJIPkunC4tBmj1T?=
 =?us-ascii?Q?IKy/4zcWmLX+4MzpmS54B0FU8IkBATuGRpiALinml5FQ3gWNc0wxvNt5e6Po?=
 =?us-ascii?Q?TbVI2fUi7iLYn6oum7FWWIxI+hif4gKeicu+39AvajDvrpE/3b7I0yRErVaC?=
 =?us-ascii?Q?MmpkxcrbQA4qSJ2sLanBXE2B+vg0rxIDCydq1hEMAtOEUzEKT5UfP9acP1Mg?=
 =?us-ascii?Q?BPiP/v1KNZK/JNxNqT+dnWNzCoZUo5dHvodzl/xDIOwU9Sdbn1brSYpZCZ3t?=
 =?us-ascii?Q?yVxn3Ssv9wMRcXo9a0sjXLtyb1Sqy3a+oNf+DmSQ/YV9c1PNHYlhacXUSykz?=
 =?us-ascii?Q?7gVmv0sTMkoHVkNzdgRGL6JAK//dhRYY9+cA1h72oN0ZMtsATaJYT2cINg0A?=
 =?us-ascii?Q?keRf3zXKg7oewVjignr0u4CTCDIFIRTQI7W5SovmYb8ll11LVg5CHnRirX9w?=
 =?us-ascii?Q?OiQD+ftCwZbXbogDnu6wBiEFFWUfhQeqgaxJ45Tm1XlOZPR0JCRCcQLaFgkm?=
 =?us-ascii?Q?FKbvro9JH6A9go+y83Vf0qC/QxlfPcgWwehMsIl03Jki2OBYW5gDJCXtLJi9?=
 =?us-ascii?Q?gcE+L3w0KMbmqZEUuNLSqcTT7QQeMNZ77stHJh2sbIOm0aFDtVUB3iOgPaXX?=
 =?us-ascii?Q?88fGkx6ODS5EONJGB0Nf5/fnJ0dyCPPhP/yQHBDKlGXHUCccsycOKboW4zbM?=
 =?us-ascii?Q?peZDpsJCW2SCgWN4E4TEMvwR0A0BYvRnQoSHJLfSw4OBrjdJuKQibId5xK5R?=
 =?us-ascii?Q?aqWpqzXWqTiwGmMrjL0NX/0VynhvEGEidAM+9vUUrn90yfHuEryV51ReNVry?=
 =?us-ascii?Q?8KMpZXQ0/HcgIu0aVXfF0vp8EH1J9M2+TzXYZYBeF03KOCYOn5rQ9rbwoLLz?=
 =?us-ascii?Q?73bzUXPktc3sazCIjNJMo020Mb/JdKWEt46AI+295kgrVwl7C4mNUjROdY8X?=
 =?us-ascii?Q?rqabsFMqOge5biSNfzpV2oc1KUlN2W3ll/P/?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+sATfPRiDTmG/hA5Za5u6OofEJ0ZELZwuhaHUMZt2TUlTtt4QVU9YG74qkpm?=
 =?us-ascii?Q?+5Ux5AkQ8P3gwz5EJNF5MKMmd276tuyXHrMnoA5DLwf9E6Dholg4FEfTz9hz?=
 =?us-ascii?Q?boe2jLVPYWEvNL0fJ/5RxCe6U2UlAnmXDuE+9+4Bo+N3atklR0y3pqzY5llX?=
 =?us-ascii?Q?5LJ79in/VPQ3rWyqotJMqyW8SxOnucHebJNvimcXPqZRpzcUoCToS0BBULqf?=
 =?us-ascii?Q?6UFi/oCVajTog7M2wPrxZ8dkdCSQRwawY8n4YLUwCBe3S3CEABc6EZl2GYZg?=
 =?us-ascii?Q?Z/rrBTIFUO9c0dArmaXuUiNPI8REtUr5ai3af7OJ/w4xZ2u6Hag/n16x+IoG?=
 =?us-ascii?Q?dUnSRpPEo6HcvIT6cetwtjI1nCm13ATDSqm9BYmjyP6+l/HUtY8tpw0f7/wb?=
 =?us-ascii?Q?Laj90Ti8wrSKgj/WxmvpIzgJq5k8s+bq4e7TXEjXEtkkOLbnowWe0zwotm58?=
 =?us-ascii?Q?YAUgnHdlSGnCYTOYLIeF1hexHc1QJ98fX+mhvzhPQPcz4WjGYgWqxnxPJyC1?=
 =?us-ascii?Q?2TMS4PsGA5ipOWLcH0mrHIPiq52E+wAr4TudXSxxNBRfOKqLvjLv6sz8LrhA?=
 =?us-ascii?Q?0/alHGTLqUjP5dps80XT6Ed2YS3PoyqG1RPRmLTSrHrVthr1wDAzmuHheKfS?=
 =?us-ascii?Q?aUNwm3wVfN18v/8jX07rm4xejF5+O3hpc+9+zZiJ25aC3sQNCEP1R4YHcPxp?=
 =?us-ascii?Q?iuQxUCVBmCtPcjquscf6M2ZqG5nhhXy6HdchVnwZvfmdP8el5tGyTR4u1xsA?=
 =?us-ascii?Q?s5S4Kyu25GLQokynRwhYBf0X/QLy66IT+ALMFZ+ukcO1J+H/dmKmtoTh/bs9?=
 =?us-ascii?Q?4m25qPNG2nYEqYIr4SMFaKFNyOWeqiS9jotwMjCaE5LBRRrhkKh3zmzXaWMb?=
 =?us-ascii?Q?fDaUD/EnYuyCC+RwRV4MrxMqCbXA/GMFpK72Z00hvZNlJfgaKUR1DFi5OwNe?=
 =?us-ascii?Q?WGrHzpBdypWELN4NMaMACZVeZZNP+McSC2OaLdfkehkI+Njr4Me3BUc/EYDX?=
 =?us-ascii?Q?tod3mldBuAgg9ROux8iR7uSmUS9dGUzmgl0Dm+j4IPcdej90e0OgviJ8Si5r?=
 =?us-ascii?Q?ICnWpBuxtoWK8TlhTN4atfi/8TECQE3IqgQ6Bvu03XDkPZecqp5vXX9iBvHY?=
 =?us-ascii?Q?VFwE46aKgjsLMVD0KL0m6LtqTRFQlmi31T6EcoTYWQ5uVT2uiarUIwMEscx6?=
 =?us-ascii?Q?8pxk6WWY4IfFNFHAK4mW6XpXXkDj0YSP3u9xAOkLzqJHyvjWZIXJG+elBeAo?=
 =?us-ascii?Q?O5fJJjy0R9Y6L8M3vdE4wLUNpFJTJ4Vl5OXaxf4BUvIZoEuylsQVUbkxZVif?=
 =?us-ascii?Q?Fo4Jypqui+C1fvdjS8VWm3Z0F7mhDBLR3UX6siL7oUN5SbFuB21WEpVD6y/U?=
 =?us-ascii?Q?26ArmBD6aHVWrMygrYeb5Ts12lhNUQMWnWRYJ/QTWXVCw8b9yZZxGTeZ1kCw?=
 =?us-ascii?Q?sdnC8SKXD2F2IK6W2+5gTqnn0CyRSk3kcWYFqapJNcWr5qRlPSZVUMpbuqmd?=
 =?us-ascii?Q?VuRIbUaQgkXt9kst+cMOCHXMjE2Y+SXhlYAJT5eWJ2Rh9UdobML8qnJgveHQ?=
 =?us-ascii?Q?iSDjdtKcGdOizaVyW4V83MH9ZrQPjyX1LW7irLeE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df693303-43a5-42ba-4bc0-08de1aefc55d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 15:43:44.3738 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PgH90w3xKMd/iVBUnhKd0GV+qMhsdycCWYDbnrSJCoxmJc2f1D2a9r0zkehTuHt9eY73nnNHKohXgWX+8i3yew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7900
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
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
> Sent: 03 November 2025 14:54
> To: Shameer Kolothum <skolothumtho@nvidia.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; Jason Gunthorpe
> <jgg@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>; ddutile@redhat.com;
> berrange@redhat.com; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
> <mochs@nvidia.com>; smostafa@google.com; wangzhou1@hisilicon.com;
> jiangkunkun@huawei.com; zhangfei.gao@linaro.org;
> zhenzhong.duan@intel.com; yi.l.liu@intel.com; Krishnakant Jaju
> <kjaju@nvidia.com>
> Subject: Re: [PATCH v5 23/32] hw/arm/virt-acpi-build: Add IORT RMR region=
s
> to handle MSI nested binding
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Fri, 31 Oct 2025 10:49:56 +0000
> Shameer Kolothum <skolothumtho@nvidia.com> wrote:
>=20
> > From: Eric Auger <eric.auger@redhat.com>
> >
> > To handle SMMUv3 accel=3Don mode(which configures the host SMMUv3 in
> > nested mode), it is practical to expose the guest with reserved memory
> > regions
> > (RMRs) covering the IOVAs used by the host kernel to map physical MSI
> > doorbells.
> >
> > Those IOVAs belong to [0x8000000, 0x8100000] matching MSI_IOVA_BASE
> > and MSI_IOVA_LENGTH definitions in kernel arm-smmu-v3 driver. This is
> > the window used to allocate IOVAs matching physical MSI doorbells.
> >
> > With those RMRs, the guest is forced to use a flat mapping for this ran=
ge.
> > Hence the assigned device is programmed with one IOVA from this range.
> > Stage 1, owned by the guest has a flat mapping for this IOVA. Stage2,
> > owned by the VMM then enforces a mapping from this IOVA to the
> > physical MSI doorbell.
> >
> > The creation of those RMR nodes is only relevant if nested stage SMMU
> > is in use, along with VFIO. As VFIO devices can be hotplugged, all
> > RMRs need to be created in advance.
> >
> > Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > Suggested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > Signed-off-by: Shameer Kolothum
> <shameerali.kolothum.thodi@huawei.com>
> > Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> > Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
>=20
> One small question inline on the id increment.
>=20
> With that tidied up.
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>=20
> > @@ -447,10 +475,70 @@ static void create_rc_its_idmaps(GArray
> *its_idmaps, GArray *smmuv3_devs)
> >      }
> >  }
> >
> > +static void
> > +build_iort_rmr_nodes(GArray *table_data, GArray *smmuv3_devices,
> > +uint32_t *id) {
> > +    AcpiIortSMMUv3Dev *sdev;
> > +    AcpiIortIdMapping *idmap;
> > +    int i;
> > +
> > +    for (i =3D 0; i < smmuv3_devices->len; i++) {
> > +        uint16_t rmr_len;
> > +        int bdf;
> > +
> > +        sdev =3D &g_array_index(smmuv3_devices, AcpiIortSMMUv3Dev, i);
> > +        if (!sdev->accel) {
> > +            continue;
> > +        }
> > +
> > +        /*
> > +         * Spec reference:Arm IO Remapping Table(IORT), ARM DEN 0049E.=
d,
> > +         * Section 3.1.1.5 "Reserved Memory Range node"
> > +         */
> > +        idmap =3D &g_array_index(sdev->rc_smmu_idmaps, AcpiIortIdMappi=
ng,
> 0);
> > +        bdf =3D idmap->input_base;
> > +        rmr_len =3D IORT_RMR_COMMON_HEADER_SIZE
> > +                 + (IORT_RMR_NUM_ID_MAPPINGS * ID_MAPPING_ENTRY_SIZE)
> > +                 + (IORT_RMR_NUM_MEM_RANGE_DESC *
> > + IORT_RMR_MEM_RANGE_DESC_SIZE);
> > +
> > +        /* Table 18 Reserved Memory Range Node */
> > +        build_append_int_noprefix(table_data, 6 /* RMR */, 1); /* Type=
 */
> > +        /* Length */
> > +        build_append_int_noprefix(table_data, rmr_len, 2);
> > +        build_append_int_noprefix(table_data, 3, 1); /* Revision */
> > +        build_append_int_noprefix(table_data, (*id)++, 4); /*
> > + Identifier */
> So *id is incremented here and...
> > +        /* Number of ID mappings */
> > +        build_append_int_noprefix(table_data,
> IORT_RMR_NUM_ID_MAPPINGS, 4);
> > +        /* Reference to ID Array */
> > +        build_append_int_noprefix(table_data,
> > + IORT_RMR_COMMON_HEADER_SIZE, 4);
> > +
> > +        /* RMR specific data */
> > +
> > +        /* Flags */
> > +        build_append_int_noprefix(table_data, IORT_RMR_FLAGS, 4);
> > +        /* Number of Memory Range Descriptors */
> > +        build_append_int_noprefix(table_data,
> IORT_RMR_NUM_MEM_RANGE_DESC, 4);
> > +        /* Reference to Memory Range Descriptors */
> > +        build_append_int_noprefix(table_data,
> IORT_RMR_COMMON_HEADER_SIZE +
> > +                        (IORT_RMR_NUM_ID_MAPPINGS *
> ID_MAPPING_ENTRY_SIZE), 4);
> > +        build_iort_id_mapping(table_data, bdf, idmap->id_count, sdev->=
offset,
> > +                              1);
> > +
> > +        /* Table 19 Memory Range Descriptor */
> > +
> > +        /* Physical Range offset */
> > +        build_append_int_noprefix(table_data, MSI_IOVA_BASE, 8);
> > +        /* Physical Range length */
> > +        build_append_int_noprefix(table_data, MSI_IOVA_LENGTH, 8);
> > +        build_append_int_noprefix(table_data, 0, 4); /* Reserved */
> > +        *id +=3D 1;
> here. Why this second one? Perhaps a comment if this is intended.

Oops. I forgot to delete that one.

Thanks,
Shameer

