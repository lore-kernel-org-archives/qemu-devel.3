Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84DF2E7DEF8
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 15:39:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmw10-0001qz-51; Mon, 02 Feb 2026 10:39:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vmw0y-0001qD-CB; Mon, 02 Feb 2026 10:39:00 -0500
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vmw0w-0005Nt-VJ; Mon, 02 Feb 2026 10:39:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MqiqWhvx82bLD4J1qUOOxBXSWMBgxPfI1/2AehCubeLG4Vnj0isbeg+KU8rS2lA58c8dLKl4ek3MIsFtj+K/PztrMwUiKMN+LiUj7aDehkSzV+zrujt63Kcn80nf5CmSi+5t8VgixgR1geJE120AC4ZI1xvSJnRICEOM8gVfCG6L3SI2HGHDPh2SXKyHy5N+3vpYAD7vH8aJvWBvrJ+gv86qRd2O30+CW0EeUZO2i+d2y/vn7t8CGUOcqvEw+LOhwX0wp+R7PEYfX84usU4F7w0f9RKqE03ltbgMahmYSIKx/o/SAWtkQ37T6aXs5a5YD8vNugccZ9R3M9CRePDWqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vMvFYUom47OI0ErCm4iCgLZTWGE7BuOZDAvdACshcQE=;
 b=VPBQOb5tyG5Ga42Nw39X/PphsA0bfSfLDwcLsbbG9wnfYErPuELkQSqlT1n23yMnYyDm+BDrIRkJgZFFnhZrRTEYK1H94t4z+WgUEOJ2QesU1RyD2xDvjaaAmIVv7cNLnOrDvyugt3LDcCUwlyzb/p/2EXdyHp7/bIInamLGCE+5uAXnpUoaF/PWyDmP1YHnwI1xaenjhfFbOkFdTVyKkg0YOVrTQimNeMo6vBitXGKKeahbsJkarItVnC++k928FFPZfBreZhA3GyNCJe8qlvW2GGDfBaXvAkRPifgX+W8dHXrEqyrd1M6hv5jZGJnKgaegAXGI/RCeoKS3M8SIKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMvFYUom47OI0ErCm4iCgLZTWGE7BuOZDAvdACshcQE=;
 b=AvJlmkKBjeLGRXJ8DTmiljZSqUVCdQCfmCBAgDi57PFQsM6gMHQg6Jn/ctdRlcxekYeoEuZmnMEu9uS3lGdj78apAOyzGmYWXRikERM9a7O/A/lzlTHHuHK47ztj9h/evJZBsfTdiKo/4swM4UpkxZsn5flwoExB1G7m0hZpEEbVMJoWhTG9C7UB1hO1wIIb3QehqolTiew4Mdiivov1CiGTrWFpmNGfSnIDKNfS92md2r4SU11nT0+/z+8asH4ADvJGzKuLNgKtkmupvwdVOHkUvvepXCvGTu0wTHP8lJ8zFaO289KvMA3ObSPZCFk31xKG2M9E+6wFiOZBbmKEBw==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by SJ1PR12MB6316.namprd12.prod.outlook.com (2603:10b6:a03:455::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Mon, 2 Feb
 2026 15:38:51 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 15:38:51 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Nicolin Chen
 <nicolinc@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v9 31/37] hw/arm/smmuv3-accel: Add property to specify OAS
 bits
Thread-Topic: [PATCH v9 31/37] hw/arm/smmuv3-accel: Add property to specify
 OAS bits
Thread-Index: AQHcjrF92YpMmGmntEqRZLFfH3O4H7VvhjCAgAAEUKCAAAa0gIAABIOQ
Date: Mon, 2 Feb 2026 15:38:50 +0000
Message-ID: <CH3PR12MB754835BE4A5C54387122504AAB9AA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260126104342.253965-1-skolothumtho@nvidia.com>
 <20260126104342.253965-32-skolothumtho@nvidia.com>
 <d9192ae6-a94f-479a-b19f-734cc52a6be0@redhat.com>
 <CH3PR12MB754867E986856DC7718D4051AB9AA@CH3PR12MB7548.namprd12.prod.outlook.com>
 <20260202151917.GO2223369@nvidia.com>
In-Reply-To: <20260202151917.GO2223369@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|SJ1PR12MB6316:EE_
x-ms-office365-filtering-correlation-id: 32b534b1-d596-4344-9555-08de62712a0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?8I+T5UWp6pkvWWVr2lpeQHhgMUwEoC5zNzlj+HXoTqFSW7NzeWOBRv2KM7nQ?=
 =?us-ascii?Q?LaoBxVE477KCLSxPNSwYFGx4iwGJmyr+pGJ1VTUmr7g0ilFF7bTitFQJxXq+?=
 =?us-ascii?Q?IBHVHcY6PXTEME5nS2nhmVJxjWL47zWLekYp6vOZSmYDQhLfA9ezDx5iqDRc?=
 =?us-ascii?Q?zU+k/rRHPp1ZiLfA5WnF3S+jufpEkBr4Wbbkp05CXcdyTtUPzXtQxvr6XIUq?=
 =?us-ascii?Q?Wlya4zvv0S4mYT1TousRnfeypmFUthHvxGFm+9Aw5RsfcdDKIyvVjunj2nxc?=
 =?us-ascii?Q?AQZOnoR8TvJIKY8unuH9y/PDb7MR9rfjBNbRzo/I4a3OKB+rHWfkwh3fXg/R?=
 =?us-ascii?Q?QZ+DkJjMHNfAN9pVSYtz2e/MF0PjBLyBC+Q2RKX0vA0oY66dan4PYiyOh8Mi?=
 =?us-ascii?Q?kGubRelbpzai5kZuzPFog9wzMCPtSUgPdUHTmILdHquROqXjhVr7QZsqpDbe?=
 =?us-ascii?Q?8zOMpkLI9ymoyvO9WgTsqQb0JwRqfQOWYkNfCIL61JcOa39I7TbQvHx6V/2+?=
 =?us-ascii?Q?hHhUi5sNisxSV0asNMkJXhsc46yYZ643/+OfHkRVaAV0in5e+nLxdc69uIwn?=
 =?us-ascii?Q?alPtfPHd0zHco87Jf/uSMlaohWQNyPWWodk0jZbE+/yPw4uwd26BfeT0gBU4?=
 =?us-ascii?Q?oYnCYp7N2O5836itJm7rNC5YS2jg9BQ4z1y6ucaXU0pWXWAtApey28BpG8Ix?=
 =?us-ascii?Q?4Zo4QZbhv/v4AliAe3qN+1C1gA8shjCpvRMx3y0o/AkdwY60KqUKMrCl7kqq?=
 =?us-ascii?Q?4cmRTSrjVsd647Pg29njwA83A77azigD4z1CeraAXE23hmh8wstHKBgrRETn?=
 =?us-ascii?Q?uBxxVlaZ5cu4+QhMx+w4+Lj+ZVrh55xrPoKMohmmoI4+DwN/w4Ld9aQ3d/kC?=
 =?us-ascii?Q?JwFNwEh//2X0eLMPYoEnvwSrfD7ivtsxjmIHTazO2zStvgmqVWHjR38+ZoJd?=
 =?us-ascii?Q?l1/dCXvAPDQLQqU3IeddEc1fHjSZeqJ/lQPhIolRLPFOdmR+KdBBsFK0zXDE?=
 =?us-ascii?Q?E5LG1gslTfe8IJ/VfPFzBMrKQNu/OteXwk/Kk7hIdMTxMMeDMFFjo6ZF+ct+?=
 =?us-ascii?Q?J18GHARm7K6CBTob2nBLt8OaIc9YQRxpTDw5J3CtUY5OD2ZqxGURY3a5Tmie?=
 =?us-ascii?Q?Rx3r3tEvKVSVnPw7eGVrTCtfGnu9vKvX+ktdZTZtu+Ho4HYQUHCVIvwSSwDD?=
 =?us-ascii?Q?L44GGuHGgcNcKVIAtqI/4gFFO+iCFWg8hewpJBqkNtDsWPYXVdpLPgnZ/sJZ?=
 =?us-ascii?Q?OsX0oWKaKL5XREHw5iMzeLs0mPJCpyVbWVbyCwkr+5lbv6Q6HxS96TavdqP7?=
 =?us-ascii?Q?+ONMin1SI0lJKp7iywwYKH6j7iQznatWj85fnOWbwKLoscWb1AHVOS2+Oyyg?=
 =?us-ascii?Q?SEgMrcCnuJaB7k5U9JS7pWM1hXy++LntPDu5CjEt8nqKZUHDp+d9TTFkum7V?=
 =?us-ascii?Q?ZkdBBLVOHN+kD4IsbcXUInR32viG+lzb4sqEGPKjDX2609DvCr9bscbQ2hmS?=
 =?us-ascii?Q?2tkCRJX8AYSBp2T3ZvfGHupqvUMIlCOccKYMHrFOZGXqzEp206G7ohbgNGy2?=
 =?us-ascii?Q?prH086gFwzhxSFOVxjGDcRbcYGBkK+mqvKKHbAxXXGEmQYE5qCVbuk3Bqk+V?=
 =?us-ascii?Q?aegS11s1NmTcF9GzHGBPTWw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?O4nimsfXfZVu/ui//2t4Y47zyQccWWNSFM/EADIN/OZXqpGO+FXM/YCk1Cg7?=
 =?us-ascii?Q?LYqf6Tev5cNuaroYTlFD6VV5kFtHmP6AmG/KzOTLMm8wr96IW1MpyMHEai3Z?=
 =?us-ascii?Q?4kwxwBjneXdAlpsup8gMNWbYDjPAHdCxGhInBLpVUueJIgMCwxYz+raVe0mz?=
 =?us-ascii?Q?5vIG97crXnQ9rzhWshWYvBh+rTT4QyVRl+E/Zh+GrYJGYBpWK40qahQeZfEw?=
 =?us-ascii?Q?0r5lA0jKtULfTyZg76dZLBMcQE8QTKeDKSt3Zpc6GNaTlBgl+3TEvZxRJP3g?=
 =?us-ascii?Q?nfVw/aKwOKYeM3HUoQ/ProNJ7w71JuvViIoor88NeqAxwye8koSv0XGx+8zo?=
 =?us-ascii?Q?xyLbmC/RYcyjEQUtpRB0NNdmgOQfXRHHtfYre3Ad3XNWOtBu++6tFNm9h10j?=
 =?us-ascii?Q?XuyNICT3Xb2yRorfpJtBw8LLcjohIJVP9shHBY5fGa8ohW2ax6YjcZdQ5qpK?=
 =?us-ascii?Q?8uxRmRT9azEO0Wt3CMetkF8SI9DRqby7K+dJ3BfunaLFiFPRGJ1X5/YiIqjZ?=
 =?us-ascii?Q?gc+mmOH0yHZemUsOhXdbbZSPeXVM1y7QuzUMQ8yzUDMgsR2Y3XbkZDkxslQB?=
 =?us-ascii?Q?+wAEvpqQY4Kc5s65cepCGdEKNptwoSRM1fJieVLiXFYpXEeUghlFdPV9zWXB?=
 =?us-ascii?Q?AMV+1Ql5T4q1tUFblo9Oo1FVaC3ubqEEOBjBAlsh6OU3Dah1GAlyqvbkEMXk?=
 =?us-ascii?Q?gleOiPA/mJQelidsCeiH4YBt8Y+Dc/iSO90Vg6+o1EwPBrhht0dD7j7nLCwU?=
 =?us-ascii?Q?nX+iOKXcFVfU/VtFDbee9gRpcft1MYjMIm8DGMhxM27NNIQw5Rw9cEIBknuT?=
 =?us-ascii?Q?8J2mrTxAGb0D/+H/a9xUsgRbmj+rWUOwIY/1fvgWu2YqvadTMq9hVhFfXgd7?=
 =?us-ascii?Q?MHC89weQdGIXl9dj40ojHaZG/QWigWZSHOKIXeppKsmqo1o/+ccV4mH8vtnI?=
 =?us-ascii?Q?4S7uHEwwPizp2f7aOLjzF1j119udZwnq3k8o5PiMBl8iidw4vodiqmBarj86?=
 =?us-ascii?Q?N7wwO4RoRL/I89Rwm+mBGE2F6S27WqsRNjPYggoPl5Q/mCwRKZcjdQ1xw5TF?=
 =?us-ascii?Q?6fANC1ruYJv3B6qzs97jcwaLEUhHVAuNI+u71YZeJlE6LUQaxE2uv9ZtTsr1?=
 =?us-ascii?Q?LJMh/WgooF5HCoCkUz00C5qDTyYya3F2DHinDEFEp9O0W9mYceCm566MmSxX?=
 =?us-ascii?Q?x6g9qHsr5C4JMCWao2h5vFDNZDhSqSKnVefWNEereogJGAD78IWgEVRjssD/?=
 =?us-ascii?Q?9vzZ1uEQ0FmtSov2barGytNzSuorjBvFqXep0vLYMIkKM+VCVPfDUcCTACrM?=
 =?us-ascii?Q?Vqq+sCCxqbQroufS2A7UICjNRhOufLkQ2VWSIt2g5bJQGZFQSaYEkXqmm3vz?=
 =?us-ascii?Q?HWg+Y70Lh3q5XWsiRWkh2OM8cjjxYUcVQVCun8FLSPHLv9IZaYZQErYPZ6aD?=
 =?us-ascii?Q?K4iQ6HNBPDPoZt4h+TmmG7sARFDgiPFyx8jNSUo14szL+x9QgPtDPIlOn7dX?=
 =?us-ascii?Q?DWm8FtztX/eb4pjtjjrPVTNaLnI9NSoXJgCfmCnI4rukG7TiX8xRm/YJNlMW?=
 =?us-ascii?Q?gfq1NHamSVBgqwu1dsIrNjFMj6ICc9eiQXIpfG39Jj/TrTlKrogK89qFJqX4?=
 =?us-ascii?Q?K6TI0eVq0JoGAMFZ1kiTQ5Z7tiNSOvwiwHkgSZKlNogl1LORa0cQLyN6CuYY?=
 =?us-ascii?Q?igYnwEZhTMsD5XTyCfOTil2gGtDA+8RKj7g/n+klMsZ2T2cRUrZ96lCWU8jD?=
 =?us-ascii?Q?d+zedlYESw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32b534b1-d596-4344-9555-08de62712a0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2026 15:38:50.9370 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cy3HmIZmzARLEtskWRvjU4noakeNxCWQzNgGeu/pxKCiBLRXfAn/mCu9VHAAtoUVHBc+2pEFpBjUnOeXLMOq4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6316
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
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
> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: 02 February 2026 15:19
> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
> Cc: eric.auger@redhat.com; qemu-arm@nongnu.org; qemu-
> devel@nongnu.org; peter.maydell@linaro.org; Nicolin Chen
> <nicolinc@nvidia.com>; ddutile@redhat.com; berrange@redhat.com;
> clg@redhat.com; alex@shazbot.org; Nathan Chen <nathanc@nvidia.com>;
> Matt Ochs <mochs@nvidia.com>; smostafa@google.com;
> wangzhou1@hisilicon.com; jiangkunkun@huawei.com;
> jonathan.cameron@huawei.com; zhangfei.gao@linaro.org;
> zhenzhong.duan@intel.com; yi.l.liu@intel.com; Krishnakant Jaju
> <kjaju@nvidia.com>
> Subject: Re: [PATCH v9 31/37] hw/arm/smmuv3-accel: Add property to
> specify OAS bits
>=20
> On Mon, Feb 02, 2026 at 03:11:28PM +0000, Shameer Kolothum Thodi
> wrote:
> > > RIL is in IDR3
> > > ssidsize in IDR1
> > > OAS in IDR5
> > > ATS may be more touchy but maybe this can be introspected too?
> >
> > Yeah. ATS might require some kernel plumbing as BIOS can override it.
>=20
> We can treat ATS as a per-PCIe device property.. I think it would be
> fine to tell the SMMU that it always has ATS support, it will never do
> anything with it unless it sees a PCIe device with an ATS cap, and the
> physical STE generated by the hypervisor should sanitize the EATS.
>=20
> BIOS overriding it should be reflected as the devices being reported
> as not supporting ATS, qemu should have a per-device flag to disable
> ATS.

Do we have way to detect that(IOMMU_FWSPEC_PCI_RC_ATS) from
userspace now?

Thanks,
Shameer


