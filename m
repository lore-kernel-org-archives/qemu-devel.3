Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E444F8A171
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 13:44:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDN0I-0002kU-T6; Thu, 16 Apr 2026 09:43:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wDN0H-0002kH-HG; Thu, 16 Apr 2026 09:43:33 -0400
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wDN0F-0005K4-UD; Thu, 16 Apr 2026 09:43:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vIdPgv02dYpAIcHFYcNsiuzwBFITbQleppiH6K2KhCxCBrr3YbWCymufR0FS1ogh/qiWnoGFGKxcmdNkTK2LEIvlm8IemGLVXJqXmmoFs483b9IzWOUItwpO3hVGU+f6jfryB2x4veFcNn8uwSMwWagyTHWRU83IB4kjc58Lqh//Vgbrspt39Nx2xS/Et0CBuP39d3NpPGG+q+pWcedBt1iVcL4gaF1CbrDeWBjR0+dqDhmobRSovXVUgcBBu6fQns8rOqccA5e5O+fiSvakSmaQyygUkkxZxB9lO+gv3yrbK1Ch1eimI0AS5K6UJYypMwwcRA+y4JWbDNVJma10jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2cIhT2vAbjyQCQW06lfDqOA43X17Zg6qzayLxKnE/Io=;
 b=hP/vNEQyTX/FXWPyYOmSqCaMpVA/61cYCLT22j4X45rjIwzbP8GXDq9mZcovOiA7EeNl8Mwjf780SOyFrFMEFd2NAEswEsTEZ4CSEYTPtXWWa9GJ/otwRkC9K/19a1ofRlJhq9xFnx4nZJyEPtDVwMJ/9EaihtL2cMRyfhBbnQAQPbhTqwt2Z9VishnGb7AtRJQd8Xi8ra8dqNXuQWj9lUl1C36L9WXe1sV4tl0IcSS7nyZE9pAmhAejAmkmsI7jXMaPifn5n5rS3bNwudPEu/Eczrz9NMmzMa2BoTH9gtdtfYNDy8yGmKcTKa0liNBQO1N14iAzMTxi8/HhdHWoMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2cIhT2vAbjyQCQW06lfDqOA43X17Zg6qzayLxKnE/Io=;
 b=SvU2KdwXfQJ+gFf16si5ZUI0GkfTYxUHRpJ5wl4IY2kmtLO6HVO8jrw65b1gY9pDobtmWK7pHWMC59tkNPdcKvy9RxcvW8KSu4RbRqnesVHlzcllmoQqWH3usjIBBc+/CnVkKO6d+MOwQ58UrJgQEmvGsCbrhd5tf+C8wpXCuizy34D1y0W2PUDsDnEo4Fa6Le25kM99Nhnwj+7z5T1pKLBSDeQ4T1br3wpk5XiwLddEy17dfIoFGdCC9GD4wVp26Xt7OAVtvTycALyiFRrOW2miajowxNTByRpllD47UUky+IOxC/0rnD0QCdpSgxq4qFZhED4RoaUjCf9aQJ2UNg==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by DS7PR12MB9549.namprd12.prod.outlook.com (2603:10b6:8:24e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Thu, 16 Apr
 2026 13:43:23 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 13:43:23 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Nathan Chen <nathanc@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>, Zhenzhong
 Duan <zhenzhong.duan@intel.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, Yanan Wang
 <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, Alex Williamson
 <alex@shazbot.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>,
 Matt Ochs <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH 04/11] vfio/pci: Add ats property and mask ATS cap when
 not exposed
Thread-Topic: [PATCH 04/11] vfio/pci: Add ats property and mask ATS cap when
 not exposed
Thread-Index: AQHcwXNAhKlzZKlPhkyvRghD8znFEbXhylwA
Date: Thu, 16 Apr 2026 13:43:23 +0000
Message-ID: <CH3PR12MB75489F2F88BAFAC2EE8EB8ADAB232@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260401010231.4166776-1-nathanc@nvidia.com>
 <20260401010231.4166776-5-nathanc@nvidia.com>
In-Reply-To: <20260401010231.4166776-5-nathanc@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|DS7PR12MB9549:EE_
x-ms-office365-filtering-correlation-id: 3a2e8c27-f846-4be8-528b-08de9bbe2112
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: LZijXOpeR6CmrD0iHvWZK7PVt5ZiCwdOOeunhHx/njiBDZqM/C7pwn+sGD5Yf28cT+F5GoXh30bkbGra5UG9pxYRxZ6CLl2z7q6hKGMk5GWoCP5wQJ5YbFQd+5tFWTJzY7UiMQmRVYRkmrdbKwq6hNgL7syl4Nqr50vuHEDmnYVtX8RROoPc8xhRVEKhhPUlVJYWGrb3it/H1V4KCn1goe7KVx/T1A9+7BGGEvZo/o2jyVLrVY99SBNxSLubmPz+CoKm8o8DhyHtZoWkfmd7xLsuaNjms7xMYLhVP2KH0a8OyfhO2PuOL1toCLVbmDTvPv+zxZPtPGYXa/oGgiuPtIKOmtcW31+rfZwB0m/BpXFjzOjA6SMAYIQLwLpA3Tfk1xo6gZLh3e0mgLMqVYuxj0AIwh8ctwHPbMjSv4eqzLlV9jlEgMxGULAfvxYpGB+n+CAJUGd74tbVw3ladWZF9h+r8BAwrHs7gtzb9Zij2I32ZVzZr9fNO8kSXRBYigjlWmvfuak455m5bvP0CIHRz1C3ATwKsmLxTffgEACe4bl3oLUgzMazVM/pZDRmYHLwlj6cm9HUpFRF2egXQrCDX1Z3URQ5i3yicqyz17LqUmN5H1fCOUE79SOrVgrkrJLjzs3ITaPkDvHy5Nqg/NtWJ0wjUXn9mKbkCdRHFms9tH64ja1h7sRNZCZUtbJY4BHZZxC9jnJt0fON/495Ua+ZbfkBKzZcMTzvh8Io5MRtlvErKsnZNMeTvr4gUuNRtVo0bPtmvt/Mz5e7vwa3P/7nLth9erXoqfF17wkKeXCHdoo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NFbt5ljf8n8RJw8lPXKQzfSMGAodZpOlbc0+zywKrJDHGT5xawIbMbJO3q?=
 =?iso-8859-1?Q?/v8WiomQPTsAm9u0+zSKn51ZgFbn4tmQgm40JA17WxfgtKHfmmDUEIS460?=
 =?iso-8859-1?Q?OdFvLbabxUr0oY86dCvhhcZWJhowWrlqLtorrH16PARAxetzyfuSFBPrdT?=
 =?iso-8859-1?Q?Q+r98yq2LJ6e8w+owEDsCKWG/skbBPKcErsdenZtUA9AN1qqG0Yq55SXOC?=
 =?iso-8859-1?Q?0KcN6MRxz2sAYBW7sNO6lZSR8kVxD7IWHH78bJBnIABnZJi3kRPHjUIsEa?=
 =?iso-8859-1?Q?avbWdGsR9SrWvTrheAdBvKUDfsNTe3fKEUnzT6KYbuA8y2EALCEMcLd2WD?=
 =?iso-8859-1?Q?y56ObA/Y5zOhlYN12ff4At6ar/+jKNlS7rpPqWifocGQRNdIQbXs8VOPVY?=
 =?iso-8859-1?Q?l7UCAx1aA2+ckzGppzOJFkAY0iDYe98EHeJt/vDEkm3vwny23Pcmk/o+94?=
 =?iso-8859-1?Q?Gn0nZ6JK6EZLkv+pFTKbzaxKdJT+keZzxAJnXg8bWLzKqOR+RhfNtj8nx4?=
 =?iso-8859-1?Q?WAkpgwQUjbfurO9vCvL069+je+7pv447I7V7Xwuk1+Y/DZFea8FoXJcBVC?=
 =?iso-8859-1?Q?lcx7UL3wEw76dCm9pMoeLmUX/HXxAhrTMkIxAO5+2SZoyOpgZ9c8MAeoSN?=
 =?iso-8859-1?Q?XObWkMt62dMeFr8s2TXU42m9nq2h7AvToJ9ZxuZDJNmjEll6D2Rh/u7m6o?=
 =?iso-8859-1?Q?rcTiuklqR6ZCg47YwK/V4NR63EIGQMmBc4qkjAgydb7OjoUIBMvVnMkGja?=
 =?iso-8859-1?Q?7Pd6XFZJV5pzsYSlrLpbyK16WtW8/FtNFILRM2/9pZtYDvZWDHJJVrxN99?=
 =?iso-8859-1?Q?4IcLHPPovdk2kObUblRgTBSfXKEdOqZFMnGQ8bUNB1KGBj7d8J1mzAJWTc?=
 =?iso-8859-1?Q?KJwEdR+PlJUGbKBSLsZnGodckSDxYrtGQ5eYQUD8Cm6MkMIYR9g3r7N5Rb?=
 =?iso-8859-1?Q?ohBNPnehEmniT+VUJoEVaLeaGOlM7jG4XnrqINlGv5K+ms1gzK7BMnxDWU?=
 =?iso-8859-1?Q?wzGAGqH9G2oe6e39Y2ju0I87ECaXasev4Qr/zHQL4J1UrtgJM1x06oHVIO?=
 =?iso-8859-1?Q?ZAIcll+hrcmGTCwNJZSPRntO/YmFMmrqdOD3ynmf6IVSVKU5tn66ZNE6rY?=
 =?iso-8859-1?Q?PBue1dJYtqpMKPrdLzOgLOXTQVe6yF2CFYHtmBgnKCcOJuNQNDmhBNZVhY?=
 =?iso-8859-1?Q?KGuHiuzKbM0w6ZuAE9BPUMH0hsvW0bjT9/Z9AMn1Avc3LalAsg9G3PTPuG?=
 =?iso-8859-1?Q?J/Ajd4vuEYBvEPmNg601ZHDRHIEVNY5asd3pPiPkoZo0Ru4Nn/YmLeJw3X?=
 =?iso-8859-1?Q?ngYHUZGrQa6/Cz765MrFgGbbs35frnUMKYCGr+bNe8PL4uwssNfzolM09w?=
 =?iso-8859-1?Q?YX0JGVOtBllad5E3kTruVPE24/F15ZhZJBApdEqJ4Qg8Dl54DZV1xn8xw+?=
 =?iso-8859-1?Q?m87GhrUyM43+NyeuKhw8VZbwZfsMv/5yjnHp21OwZNNT9c0wr16RaNHbGd?=
 =?iso-8859-1?Q?VyXVWr8oy7rNeOnLGpVkKgkyA7vplF0I3Okz39BZvtolFydH3WYHq68UcV?=
 =?iso-8859-1?Q?2Qsh9lYguiOgawTiRvDEjgoaGD/TP27dPteRsDKR/UAKS8s8VXOhSuLFYf?=
 =?iso-8859-1?Q?CUUfTz1SLyNyDIg5c0VRAk1fxeR4ZLxR2y/eXk+hF/mciTgBuLw6l0CXBM?=
 =?iso-8859-1?Q?o1P0R8frmNprPH2NczvvfahTRIOOpVQwzMR+lVub1/v8frTnduNAdZyrY2?=
 =?iso-8859-1?Q?dnrZ5OEppWqBc/6t89jT/GQY/IfvmRzAeb8t3F9S++SAcgzqx+yJwZc8e+?=
 =?iso-8859-1?Q?+oLdwZptjw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a2e8c27-f846-4be8-528b-08de9bbe2112
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 13:43:23.3938 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AT9dd3PhNvZnpfeb9XW4uz5StZXBuO5DDG7i6zZ2m38AUy+AhN2qovr9zbxvqzdHbvwjfJEekLCmuPV4Theofg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9549
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
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
> From: Nathan Chen <nathanc@nvidia.com>
> Sent: 01 April 2026 02:02
> To: qemu-arm@nongnu.org; qemu-devel@nongnu.org
> Cc: Yi Liu <yi.l.liu@intel.com>; Eric Auger <eric.auger@redhat.com>;
> Zhenzhong Duan <zhenzhong.duan@intel.com>; Peter Maydell
> <peter.maydell@linaro.org>; Marcel Apfelbaum
> <marcel.apfelbaum@gmail.com>; Philippe Mathieu-Daud=E9
> <philmd@linaro.org>; Yanan Wang <wangyanan55@huawei.com>; Zhao Liu
> <zhao1.liu@intel.com>; Alex Williamson <alex@shazbot.org>; C=E9dric Le Go=
ater
> <clg@redhat.com>; Shameer Kolothum Thodi <skolothumtho@nvidia.com>;
> Matt Ochs <mochs@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>;
> Nathan Chen <nathanc@nvidia.com>
> Subject: [PATCH 04/11] vfio/pci: Add ats property and mask ATS cap when
> not exposed
>=20
[...]
=20
> +/*
> + * Determine whether ATS capability should be advertised for @vdev, base=
d
> on
> + * whether it was enabled on the command line and whether it is supporte=
d
> + * according to the kernel's IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED
> bit.
> + *
> + * Store whether ATS capability should be advertised in @ats_need.
> + *
> + * Return false if kernel enables
> IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED
> + * and ATS is effectively unsupported.
> + */

Returns false only when ats=3Don is explicitly requested but the kernel rep=
orts
IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED. Returns true in all other cases.

Isn't it?

Thanks,
Shameer

