Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1FB3CCD1A5
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 18:59:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAv6C-0006Vs-67; Mon, 20 Oct 2025 14:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vAv68-0006VE-PO; Mon, 20 Oct 2025 14:59:13 -0400
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vAv65-0002HF-Nr; Mon, 20 Oct 2025 14:59:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MTY3AvbKcClqPBHHDK/ptnJeWQFL4radgvEl4xT0sEZ3lbSyHjVhq+CRGn9CC62kXkpumQUy6qehOrvZRtBYbNCQhHt1/TXt02idpZx7PeKP50dAQG7XrzFrdqhxA0k2wLWcTSsiCZMHS0U3sdR2v6nV4R8qY7WobJ2el0XLUbaSDmohrhHxfV08D4kuGLw27UvCA2YCjQjs4n4ftMv9IjUoCp5s5a+ebB4Kb9Jz41fUtEJJF4RTvt0H8GZ+ibriLiWxCcMW3i+zAc8PzBDZJR+dQ42H4yAentw2LXDJPFtBUXHnnQMcHVMFH9v2S8jSuOQ04hfgV0rOvtidIrRKMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zBpYy2Yl6J8m5XaMr9gn1hlxAYcZ7C4tNC0cSOD1C0=;
 b=vYUkTiUBExZef6lE6tYEtnyrTlut/OHoV5dO/iQ52MKX0rx29YYH3Gg1FCB37P/nk65gJ/MFSYvLHmYUAevLtOS7g26+N53pViGLRCRNmNU/zlEAU+Pbjqejms4AQ91sGMU5L8iUw1kD8PO2bRHcgnLJ5yFbRr/RJe4HZKLSjBMhQsTu9XZsFq0klgoq5+FB62wTYFGDjjP+z1e7TKtEDI1tqXUapEGegqhEiGN0XiwNBg5w6zMWeemttyq84ZoH3189aDWyU+f64RK3xGE4NWFXg/0BS+YL5iTq8ZxVjJkRRliA25uQOJzr0H6SaeufKCvuY1gHUN6UJQk8kqNnZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zBpYy2Yl6J8m5XaMr9gn1hlxAYcZ7C4tNC0cSOD1C0=;
 b=jMduVx+5Iw6eUGsVellLvRKgJJXPotIHFybR7ymNIppkuOUFxFByIKrtEoWxkhCWF9sYSkEG12akYQ4wR6SyPValMnnlQcPu1EV9TQbtO0p/nsZvAzla0XU9KISORfutfFcrLD+EI3MNpZ2eaArUQNVsUtSeLy5ZRvvZpXmuKZm0lpwcBvC19AB4GY767/XyzTC9gMokSgxxf1YMohrbk76uIVZUoAUamE13SaGNJamifuqY3kLiZrRaal9QJ8KFCs6u1GRE0Aw/7NLjjiUvTDodPfpcbzwaDk6Y/iDCBfXz7uWvPNwYsUfK/7ikPL5HuA6cCd9XjzCLb+IBSQpxlw==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by SN7PR12MB6981.namprd12.prod.outlook.com (2603:10b6:806:263::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 18:59:01 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 18:59:01 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>, Eric Auger <eric.auger@redhat.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Jason Gunthorpe <jgg@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, "smostafa@google.com" <smostafa@google.com>,
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com"
 <jiangkunkun@huawei.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
Subject: RE: [PATCH v4 06/27] hw/arm/smmuv3-accel: Restrict accelerated SMMUv3
 to vfio-pci endpoints with iommufd
Thread-Topic: [PATCH v4 06/27] hw/arm/smmuv3-accel: Restrict accelerated
 SMMUv3 to vfio-pci endpoints with iommufd
Thread-Index: AQHcQd8BHNFvMFbT2kCFLixXDfUlObTLWgSAgAAI5iA=
Date: Mon, 20 Oct 2025 18:59:00 +0000
Message-ID: <CH3PR12MB754822875EB806B9C5F6889EABF5A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-7-skolothumtho@nvidia.com>
 <b222848f-c933-43dc-b6e0-97dd8455cee6@redhat.com>
 <aPZ+i6Vgxww1OTTo@Asurada-Nvidia>
In-Reply-To: <aPZ+i6Vgxww1OTTo@Asurada-Nvidia>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|SN7PR12MB6981:EE_
x-ms-office365-filtering-correlation-id: 9ebf8432-3ef5-4ebb-b02a-08de100abb42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?0OotLpd0u4t1W6klT8VITDVDr8Ga3VoAHf/uWgL4TS5vd8tJwUxOe2DxQdBi?=
 =?us-ascii?Q?N6jxTdFaBvmGPk6hRekXM3kN3irC4qldXivgbJCcV+NziquiKQeHNxoBcFaP?=
 =?us-ascii?Q?30N2d0fy5UMEZrmLL+rRcP1kDmUeEMer2S+nj8h6lpEG+OgSNcNuliOa35xT?=
 =?us-ascii?Q?MQ5YYDlFYbMOGHbU5rBDRe8uhCOsBfSBhK0oKOvtO5hB6Wo3gNsee8xGbYTu?=
 =?us-ascii?Q?Eqz3thE/PMIsy4GPzOcdMRWaC1HSmbuGqhyYzmKFIgyt71XHrYgagHkOZoYf?=
 =?us-ascii?Q?RWmWIXZaIABDdJhBa8EG3c7BBNhrEjf3BJ+JmxNH/yxIfEstadiW1UG2+JSz?=
 =?us-ascii?Q?LEQraQYuzXpzkWemMPys+rgDFN7xY9HkgjX0sFWQ1n0DoUNfLBMKjPnVINry?=
 =?us-ascii?Q?yloht0knYjQ15QwEBrY0c8Q74VarxOVNW1ENSpehbs/jU9pA6qCfsaWwDaut?=
 =?us-ascii?Q?51Yy2iNSLxcJTSIZnWjFSwMkpxXpkyaVn5/8AwHaUKNCWgg+5oXuu1JVyrY6?=
 =?us-ascii?Q?pcdC3MiUwRdR38EN0Va6QB8iDfkfPGtqK+n49zQJZwUz6uF886EHWbWtgQPZ?=
 =?us-ascii?Q?Fj9mXh87IctDNxVwMXGiYfyDxflARiFS4SvbD3Atk6PlUXkw1zrbBnFrzIUw?=
 =?us-ascii?Q?yOV5NNyAOHxBApYs1OmQjaerOU4da/l4jwbVC0Bfw4LP4ubTKznDpzVCkYmE?=
 =?us-ascii?Q?S0z3MgE7TW/NwsfUVGlKSIjxZDmh3XEpsEeVY6d/uMy9eEJPnvuTmAVAuXRW?=
 =?us-ascii?Q?27JnxDyF1riyptj/ki5OJ1uR7lY0Wx0Q87wgNQb4vq44suoG+lBb0mjovCRG?=
 =?us-ascii?Q?7BBlzZmDE3RcEG5fSrqqz1OE5wMLz+2wrEYjqT25Ac6RPyhLBRshR1vwwpcC?=
 =?us-ascii?Q?glEOXFrH1EkDAlYfLsGGRVHusV72O5mu6KHEJd24My641dSVv2ES1wU9Q9Zu?=
 =?us-ascii?Q?f+tMiRsQYJrZADxKICwI5eF+CzWaW5sx6V4gOXDjs+71sK3QeyyB4PZ0fK3v?=
 =?us-ascii?Q?O4Am0DtY2Pug0z3GNDc/es1HeI6pB4arMo131OcWpTPjGLjbiWxJSGXFbxCV?=
 =?us-ascii?Q?9e5nEKhWW10ydiGc4/4NUkRjseHhA1VfNuqzRPxDWbhONsMUH1DZA8tCF5us?=
 =?us-ascii?Q?qXEtGeTeV/ZVGbYnVhxDAU5xAGxs12OT658Zx9ojVShZ4TWLJkcmUddQDdVz?=
 =?us-ascii?Q?JAIPd39hw7fpgcEBbJ/7B1OyH5fZL1BmyRuOkY8WSJ02mwm12ykZBcdwCzcd?=
 =?us-ascii?Q?C4Wf08M2BNf9WU3vIn3GJ1x8cTtqxmQQm4RWkdoaTa35iZ1xhJTZlAP8+9lW?=
 =?us-ascii?Q?qU05pHtxf8Cz2nQfdCC1/YkfAr+rnmwsVTVWYBDmTMOzryuTPKy5C1GHS522?=
 =?us-ascii?Q?2kqAaqJlm+Gvq9sxuBcEUEOIgruqPo4WWkMpRF+T8FnkGlEYs0mahBoi+kY8?=
 =?us-ascii?Q?vn/3M94/dHVh/xQhsdVfkIBmgxjI0xlDDzG4SmBzIbwZKMMV6yCRO3DjcVx7?=
 =?us-ascii?Q?eR/FFkhNrrN+w1g0vJiLPfzYVzd54uiUv2lM?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?euXo1zCVmiFH0J0IsP2lQGK/WT0oTrQrtj6atzQt7N6sOfQ8gVVcI9MX+uyj?=
 =?us-ascii?Q?MeeEGm61GmqD2cH2zEC2RvA9b5DwHp2x0jgzdH239YqBZBjhJLkK3dp943tU?=
 =?us-ascii?Q?FZ7CKvpTsTxWK5AWairoqMrXhEWA6rVfk8ddwx/xqRtUEFaILtMSNRoqOAzU?=
 =?us-ascii?Q?y1gckFDETLDihdsoiqCRqZV3W/3dmrNXM27GAMJvpViVC/YSJwl/sSryagO3?=
 =?us-ascii?Q?ElVHfSyxs3BTI8oW1AHNZP0bQjqfkN40TyfK91txJXZqL2yAY5bg40J+yqt8?=
 =?us-ascii?Q?xQyuQrQDrs5UKKuzvxBu+VLpPU05yDex4Lz7AE1HP0lVs29gAZQmfd6kiJTO?=
 =?us-ascii?Q?LXngdeByFbgOXxMe0bhyIqLjsArH14vVHJDvA+ROZsQ1Ax4LND082g+5xVKh?=
 =?us-ascii?Q?CfKi3uuQj5rT945M0ybuX6x0UcPeaMULR3wm5GJXAyqJ9ApGGn9TjD8ubAxK?=
 =?us-ascii?Q?kiJ4bWtGDWJpM8pRas85fdz4+21U3KBLOmh0J0NFYBRcPKFcqLn+Gx5c3VjW?=
 =?us-ascii?Q?UACURl1AdQ2WDAN0ttkdiLS8qBXYL8mhC7sQt5IMKGLowOwH6qJIZAJIvOx6?=
 =?us-ascii?Q?xTvWCO6Um2Bd/0hZbh4Yh0F/kfguVzR5xhdSbYCkt7Ux3you8af6KYw3LYTu?=
 =?us-ascii?Q?bHMA+S5av8rrug7GmXxeM2yO2SuDdfju2IvhTblE7UVdWd78/FDuALEHc/mU?=
 =?us-ascii?Q?aIdA7pjfklJ3Z3tuO5qnx/29QUmEzqxJzQ7tWWDi9H6D9YhhEzfuf6LmE9D7?=
 =?us-ascii?Q?zKBuF71e/bfUBZF31gTF78TKBDYoEX4IUOzd+9oytjvf4X30/y42uYRz1eqv?=
 =?us-ascii?Q?WLiy+IyVbUMlE5PxbJL39d08CZ1TXTR9UcIM/AykmGHUneJW5rik26YISxxs?=
 =?us-ascii?Q?FU1kyOCO83ITJrharg/ZL1yLmEAcVvI3dHcC/x5NVzd2rGfwSL0R47nVXg12?=
 =?us-ascii?Q?x+X8PQSU85TZqU7xOKbus6lKSOaRPUsKwTxPq5Nuc/Vsglum2rY+3HrXt+S4?=
 =?us-ascii?Q?OeSvuTEfFUYs/8h7RbTde297fQSAVf6pnfnXebDRM+VtWMur2kVsAMHSO3wW?=
 =?us-ascii?Q?mbesBwpuGjbGLXMquBtTxLake7FM42/YhNLqQOmk3YtMnyjbvagnDrWBLjTM?=
 =?us-ascii?Q?RSGwuwvzurE8zceaX2NiPcX58OevCUxGXoaBewRfToZFWADwmVxH8V2DDjBN?=
 =?us-ascii?Q?e0LvRR9SA7H9Q6C5jfHaEhES2fDno7sj2jkkIhAB14GoDe0uBz7S4qFEUjJY?=
 =?us-ascii?Q?/z6XEe9V841bkjjVC2jmh6mJmcqqKWHkjhOZrh0l4Q6s6JRuTAu9Lg/UKAxp?=
 =?us-ascii?Q?5QH/o07yOGuSwBsNd2oHQsBOOLCmNF3Xynrba/Gp4sH4/geUBmrgz9LKSCS1?=
 =?us-ascii?Q?E1tEde3ZsPfY3sLP4lUWYGQx7P+L0DKakriVU/ajF1zzy8s+fh60q2Kl/0Ap?=
 =?us-ascii?Q?Rm76hiVAlcoxpJV2BDhSEriREU8qMS9CiGm1+9T47aS7sGL7EqKyoqvw42yd?=
 =?us-ascii?Q?NUwKD1P3JzAzmOy6i/Lt0eeuv2tjAorMEnMOswq/qroO6CU/DPZ67Yk/S+3s?=
 =?us-ascii?Q?LfTHmciRrBCZjHDItHtuC68FyovkmHJZHwx4XIer?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ebf8432-3ef5-4ebb-b02a-08de100abb42
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2025 18:59:01.0110 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gCKFR/gkMkZpADiD61BNSfqiw6LSyIsn1cW76PZN0QZZA2/YmCglpjQ6CLhE2ozxoMZFvZS1cHWeJ2cNNCaKqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6981
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
> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: 20 October 2025 19:25
> To: Eric Auger <eric.auger@redhat.com>
> Cc: Shameer Kolothum <skolothumtho@nvidia.com>; qemu-
> arm@nongnu.org; qemu-devel@nongnu.org; peter.maydell@linaro.org;
> Jason Gunthorpe <jgg@nvidia.com>; ddutile@redhat.com;
> berrange@redhat.com; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
> <mochs@nvidia.com>; smostafa@google.com; wangzhou1@hisilicon.com;
> jiangkunkun@huawei.com; jonathan.cameron@huawei.com;
> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; yi.l.liu@intel.com;
> shameerkolothum@gmail.com
> Subject: Re: [PATCH v4 06/27] hw/arm/smmuv3-accel: Restrict accelerated
> SMMUv3 to vfio-pci endpoints with iommufd
>=20
> On Mon, Oct 20, 2025 at 06:31:38PM +0200, Eric Auger wrote:
> > On 9/29/25 3:36 PM, Shameer Kolothum wrote:
> > > +    /*
> > > +     * We return the system address for vfio-pci devices(with iommuf=
d as
> > > +     * backend) so that the VFIO core can set up Stage-2 (S2) mappin=
gs for
> > > +     * guest RAM. This is needed because, in the accelerated SMMUv3
> case,
> > > +     * the host SMMUv3 runs in nested (S1 + S2)  mode where the gues=
t
> > > +     * manages its own S1 page tables while the host manages S2.
> > > +     *
> > > +     * We are using the global &address_space_memory here, as this w=
ill
> ensure
> > > +     * same system address space pointer for all devices behind the
> accelerated
> > > +     * SMMUv3s in a VM. That way VFIO/iommufd can reuse a single IOA=
S
> ID in
> > > +     * iommufd_cdev_attach(), allowing the Stage-2 page tables to be
> shared
> > > +     * within the VM instead of duplicating them for every SMMUv3
> instance.
> > > +     */
> > > +    if (vfio_pci) {
> > > +        return &address_space_memory;
> > From that comment one understands the need of a single and common AS.
> > However it is not obvious why it shall be
> >
> > &address_space_memory and not an AS created on purpose.
>=20
> We tried creating an AS, but it was not straightforward to share across v=
SMMU
> instances, as most of the structures are per vSMMU.
>=20
> Only SMMUv3Class seems to be shared across vSMMU instances, but it
> doesn't seem to be the good place to hold an AS pointer either.
>=20
> The global @address_space_memory is provisioned as the system AS, so it's
> easy to use.

We had discussed this previously here,
https://lore.kernel.org/qemu-devel/aJKn650gOGQh2whD@Asurada-Nvidia/

Thanks,
Shameer

