Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA17EF3C995
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 15:19:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuuB9-0006nl-TT; Tue, 24 Feb 2026 10:18:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vuuAt-0006lg-4t; Tue, 24 Feb 2026 10:18:11 -0500
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vuuAr-0000OU-AH; Tue, 24 Feb 2026 10:18:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=olM1j8DhPhXLHtSGCagPbc6W+OynOTBe7O0KUswC9jrRvPG7BVjfxT+ADSCtNDtPk8UvYhNXgTR6PFbVm41HcnB4+LTwLdLAJUw+1w/q0fDyYuceGUrR4bmht10+igNk/xMQgg6goNBiC1YLk507vYrq5nJ9ZfGTRZYVGX64f71QH7bOC1PlogndEwwZzYkmQBpERdAT1TeHQZYL0xVg3HD4b5Nogif0RTDir+rsvt6l4y35/O2+kfLuT+JvKUClWB7I4skEkMhnYgfPAJ4AYOt84piM/QhsGqHiI+X2GtEGp1SdpivfwbQwJE4oJo8fE78rDb4oq8y+SHznj4574Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bUqs5DrDQ22pks4F0P8IJDayYbHIXeEYaDjG9qiTWC8=;
 b=d9qH7wLpoPpNHp8Y9t4cn6DhpXbCiiH5D2xpkgDi54C52oSaCkYKhM5hDdiYLZ+IwKzlSxDWuju9PxrpJK7mnnqz7hPJgCkaHy37pln7XscwB6+T7O+ol3fZDKhwAfAEoo0rsfcw8MtE071sNeEvpxXr4vzbXT9cmI5hqFtmBJkijnRc3V+yjMYWXrfBlTNWlV6rgFI6PwQzd1yjZBwaWeE4rCim1KArVzr4Oz2LSEPcVbQ+NIp/raOQ2tFf23eTL89ntmNAAjFGp8Ho+O1ZtxFA4qjLOPqKRLhxUUFOqB9i4oECp4/xVSrHQCNYCVg56SahiogC4SOGmjSEDGYTlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUqs5DrDQ22pks4F0P8IJDayYbHIXeEYaDjG9qiTWC8=;
 b=ZglAXMz9Uz9G2iusj2zJK0M6HS5fUC0DxesHypBuwWwOfO5E8PW8rK50qTwwcgg30eCxF+/4sD6frvO5yNHYdGQgo/vaDpoSHiNlEZDgaN8/jlb7MwutbYTkx42oAdD2L+V95xkRFLSHYkl1UzzCHmGRa2vBNcjYOIOhxzMT977lyEbn1l4OYcf8fodn+0Jc4OzquQkrgs+ppcGB1mAXTYPSuzi3gsQY/DG6QQOIg96ZCAkoIC2Z5smQ0anBmZMkNcPN2BKTaBee8KeDblMbF6AtYRchddbUOYo6LLVDULtuh/w386/wQHZj+lPhInMwahHCLcPkkPfLrZklY7xssQ==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by SJ2PR12MB8112.namprd12.prod.outlook.com (2603:10b6:a03:4f8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 15:18:01 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 15:18:01 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, Krishnakant Jaju
 <kjaju@nvidia.com>
Subject: RE: [PATCH v7 3/5] hw/arm/smmuv3-accel: Allocate vEVENTQ for
 accelerated SMMUv3 devices
Thread-Topic: [PATCH v7 3/5] hw/arm/smmuv3-accel: Allocate vEVENTQ for
 accelerated SMMUv3 devices
Thread-Index: AQHcoX5mqsuvOdSY5kmqaAuAN0RYDLWR8NSAgAAAo8CAAAiSAIAAAGwA
Date: Tue, 24 Feb 2026 15:18:00 +0000
Message-ID: <CH3PR12MB754814ECFD29951EFB571585AB74A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260219090103.33697-1-skolothumtho@nvidia.com>
 <20260219090103.33697-4-skolothumtho@nvidia.com>
 <20260224142857.00005fb6@huawei.com>
 <CH3PR12MB75483EAD05125D5FD3998474AB74A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <20260224150154.0000074f@huawei.com>
In-Reply-To: <20260224150154.0000074f@huawei.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|SJ2PR12MB8112:EE_
x-ms-office365-filtering-correlation-id: 4ad7f654-ae0b-45cb-a0ec-08de73b7e61e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?pq6ryZjaS+9KSXGgZsh0TjJEseTlDR7MhNdvG2M+yCXPaXTX73nnqs9Ce9Qf?=
 =?us-ascii?Q?iIlJvE3tka8qQVURTTtdv/7pwlp+anWToBIkxoAjmtYr5qGJpVtsEnpIzP3S?=
 =?us-ascii?Q?dHgBpDXUkps01APyXgiwJ0pasdc7Yn8toWZcCg5PbjbeKkO/Gtx/FdnS59Bl?=
 =?us-ascii?Q?iL0dm3sR3ILu4he3XyVvciZlO+BmovxMsgmkFedLc5DreMJHRbnguraBPtW4?=
 =?us-ascii?Q?EscGOLZ32dZpDvYW3C0r7aK6f7mlLD54BGD2SUgon6iMqS4kgB0m3QSQA3Qg?=
 =?us-ascii?Q?dO9LYx9JgkClp6K+D71m9IZNlL8POrPyHywQKC+SNcXmI6YZ0hEOpRYVCAy9?=
 =?us-ascii?Q?Sa+VZytqG3KMnq8isuY/um+ODnKoTfZ+UfMn00z7Ccgvsp5evtB2udPU0b33?=
 =?us-ascii?Q?TodPxHcQuT2pchXqufzbCR5XdFtAw003o3/zy2l3SOORUH4mdfBZCpDu1f5M?=
 =?us-ascii?Q?VkaSAQvfVwozsNi2Y0IejyA3EdM+kR667MRV2SPyQhM0jB7mBYYCgZaggDko?=
 =?us-ascii?Q?4iILE7a1bb1Vn5nBBKRmoeYIO6r3Cr/IgmSjUvC9bF/UR8K3C+NGF5JQRu58?=
 =?us-ascii?Q?mI/oyLUF+aIBGSijOCKN03Vca0Y4ZVRi7AM5lLFdCo//WOogPY95TMb9nlin?=
 =?us-ascii?Q?2a68WER/PsKgsMGqqONHrVZ8PhPTLocbYWs8RfcCgYC5vg8XO1eXhx0C+8hL?=
 =?us-ascii?Q?GsAG2n6dgTDC7xm7iyDI08Altntz/lfktxZ100kHR0c9NJZRQnYXefRcJZo+?=
 =?us-ascii?Q?/jI3TNS+O00fMxFu9czOkeMiKlN+f6bgNgDEJFBVk2pte5Mr0wRfKm7r6DYt?=
 =?us-ascii?Q?MDGoAGtu20GHgZrz+vMIo1vKrCnzWBpyc5q51XucPQTrG2xtvEbmkz7trT0N?=
 =?us-ascii?Q?PbbDJyCIGVOHtRcliWhIzt0Hw1kc44Iusqo5V1B9cqK6Uy1kgSfiQ/bsZG48?=
 =?us-ascii?Q?IKQ4ITVk1PLZa9gKbanFnjWBWqOmR/JQFYIFZ1M39ncSEa3lpaClyT7RHW37?=
 =?us-ascii?Q?Ry9Mbv3Em6C2qeGkRtbLYnp7+l98P74Mo4NOBr3or7OIx5FUCesxARdh8sy8?=
 =?us-ascii?Q?uEu8VHfH8z+DMF773YkkNqqQ+TlWA7GOuBChiT1Vq6c6tnxwT3LqXtEXKBwB?=
 =?us-ascii?Q?l7eJ++/Vl8l79CMmJsLLkXmsUv4Q/TFAIPH+kfS8NPhQ6mjG/GDJ4D1hPanF?=
 =?us-ascii?Q?S3SAK99IV1tloq9bhWMmmJP6n9Xfy/qgYVs5jZRUlHlbVNWDZtXlh063ctWK?=
 =?us-ascii?Q?zIsJOm9bRwOUKdus7ibIisrmyIYKSrxxaJ/yscp1j1F8ukeEPD4lgtwrtPPp?=
 =?us-ascii?Q?YqFoXSBrPQ7nQq/d6H0CGYJQ8jJkXffGC/gH4Wiv+9GqVNdPTJrVH1woZnkc?=
 =?us-ascii?Q?Ij612Tsd/eSNnwHzHQbUwqqa3OvJqMX982j786SHucmOPhYGc9t1LVrbM0Ur?=
 =?us-ascii?Q?EP8ALCJv1Ap8YVyx5gwpBG+s8J03zOMbI1WS4fa8AJS2FBRrzh8m0ML+fVtM?=
 =?us-ascii?Q?as+0qH9lvnSAtCSGTyVdO0OA6eWazJjG2PXiFhRj92nn4s8fCR96enBStzjz?=
 =?us-ascii?Q?CymN08lCLjzm0ubqx1+I7DA2KV14grxqINAnK4SPrAyNQ+P2gibeCxrQ4aaa?=
 =?us-ascii?Q?oac5BatVfiPJ+Gw4SBPiJrA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iHYqHg/VKtKO97NronVPDxodz4tANehF0NPRcTgRdbxdV2VnvMJwRmvUwF5F?=
 =?us-ascii?Q?EXurym6EK4oNgXx76vjhPKuNBKefapP0bRQvqLsuugZUVB4wf6cIMm/7JUsH?=
 =?us-ascii?Q?vVl4XL4wPwQcpqY+szP7OM9UgSgdced8r8JjQq2BvyfoELP/GHVEPS+oGn5S?=
 =?us-ascii?Q?AZe7slKTTPv50YQNyBjymAbTm8STSh/DQO7VP/sMjrKsJqbDCd71QKAu9HLG?=
 =?us-ascii?Q?qpMInebCh62K+jMsC6Z8VlyLbbTVgJ66JSDn70z75QkpmiSXnM73lAlr1DCd?=
 =?us-ascii?Q?1jvXl6qKtG/mZi/D+zef9Q/FaYJzUm4aRnOQDNo6xDcHtM0yiY6Xs4i3GcTK?=
 =?us-ascii?Q?BksSo2oRo2xFvdZtBtDkrbF5gITENNxR1O+86SlcMUUxtPbMmvh/yHwbRMIo?=
 =?us-ascii?Q?0AjiX/xs1zutF2SaWJ9qLwF+ZNTd/6ilKis896UGGIz6C67SrJ/Nu/7KTdaH?=
 =?us-ascii?Q?hda8u05Q3LX8qFV1jNtS/71o8y6giEjSNgL42zp05v2QS8SdqSdddpw+6cef?=
 =?us-ascii?Q?PVumCirs/yHU8uN+jjDsY16cymL/ShXUhQFn8lryixNFFwYA1XniLFQdyiGt?=
 =?us-ascii?Q?1TmeRH0pjyaEWazWAoyOp/Zx72C1dxs/1uDAS3BKXDhu5cfmvenDagDBPKXx?=
 =?us-ascii?Q?O1zhIJelkP7M99YNpOn3JoerSgINbgJhD+pesjT4Hwve9x9PNP5wSIzGQrda?=
 =?us-ascii?Q?Pn5W/XCF5J3QkoFo+DP3O7F5mDPPRNWHlguYwYsdhcH7Xn6SLAVXvo/lWf5/?=
 =?us-ascii?Q?2gPEdpxLQkLBYKb+oPIPhaF/0ECrjISt2G+VquJB4ndMqMpRZqNjFJdJDgCw?=
 =?us-ascii?Q?mffyhUvcPixFQjSQvR2YsTkSp6EVKf7wMVTpH2qcRBEDd0fN7iG0tV0yKDmx?=
 =?us-ascii?Q?zGPCKSfPrHqi0EOH0OJF6UjP2wltCADXJ8ZUQ09nW2diIPJktGVlrPeqtdJT?=
 =?us-ascii?Q?EXiSoMIOKOxGUi9BP/fnLQa1ye/bMRf58IjIFDO7+AVfpglSxy05UKpk9ax8?=
 =?us-ascii?Q?IyEh7H6V2j1Grz3APyW0lFivy0MrCa4AWQ+TQl99DikeN6awSebneaUdZXq9?=
 =?us-ascii?Q?Vbn2SrsatGcWY0JLcSAKgsMwX8vrr3mQYiG78XUBQazyOKgt6g/s7T9Mx1Sd?=
 =?us-ascii?Q?8EFv55rFMUI6WQMDITeCkGd2hjbIPrMzpvT/gUQLHD3Ml0iRaiO6yVPVm+6H?=
 =?us-ascii?Q?DyG27BfUvphWsZZeT6YVB40SYKk0yCn640IUcs2pxx3M9iJUWzEFH62VOit4?=
 =?us-ascii?Q?7oUtk6f2EKdaZR3lJw/L07aRGu/vsUG3rEquUUliUqkLjXXOpK2XQ2slHP3X?=
 =?us-ascii?Q?Apzlg1PVS2zxGTz1c4FSGlsZ/kzU9Y5134dkgPHeov/Gf2Cgau8EEYPv+eHZ?=
 =?us-ascii?Q?ScscXpR3JUt7tfsEhayHpcObtSNY34f/mNPXa+vPEDd0Sw/069/1CASlDht6?=
 =?us-ascii?Q?aaqVlhcXIQ+utJjCs2pmYZlCYT6RcktjK3yYVCrWHQ/gZEZGZlm64QxuBl09?=
 =?us-ascii?Q?DJvHYp1U0Xp/8s4rYLfnCVQaVdy1cBR/duyS5GU46BzsF74T7KDzBB6ATUQi?=
 =?us-ascii?Q?kIHcPcfFpAzVZZAK8lmh8UeqQ7A2Zw3gEa+qT2uOYo17Ud+WdFLn4w8Hq8fU?=
 =?us-ascii?Q?1RdiI0kUk3XohaGtEVhTQMj7Na+sH76HkBR1VhgVzcM78dv5q365C1W3f5Ed?=
 =?us-ascii?Q?ZVJKsWKV1wP3Z2Kk2riOu4KabIFiW6LnYcT4PtEIVuF+1SHCZW6Qm7zXw/P4?=
 =?us-ascii?Q?3oU0lllzXw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ad7f654-ae0b-45cb-a0ec-08de73b7e61e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 15:18:00.9656 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dv4mNYO3dNL/SPD6z35nqGL0d2XWRX/Hvz6z6CK4WoBRUKAZALtbSfBzuKe86YQKVMWelOUDuWUbXFfPtd/0rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8112
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
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
> From: Jonathan Cameron <jonathan.cameron@huawei.com>
> Sent: 24 February 2026 15:02
> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; Nicolin Chen
> <nicolinc@nvidia.com>; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
> <mochs@nvidia.com>; Jiandi An <jan@nvidia.com>; Jason Gunthorpe
> <jgg@nvidia.com>; zhangfei.gao@linaro.org; zhenzhong.duan@intel.com;
> Krishnakant Jaju <kjaju@nvidia.com>
> Subject: Re: [PATCH v7 3/5] hw/arm/smmuv3-accel: Allocate vEVENTQ for
> accelerated SMMUv3 devices
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Tue, 24 Feb 2026 14:41:08 +0000
> Shameer Kolothum Thodi <skolothumtho@nvidia.com> wrote:
>=20
> > > -----Original Message-----
> > > From: Jonathan Cameron <jonathan.cameron@huawei.com>
> > > Sent: 24 February 2026 14:29
> > > To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
> > > Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> > > eric.auger@redhat.com; peter.maydell@linaro.org; Nicolin Chen
> > > <nicolinc@nvidia.com>; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
> > > <mochs@nvidia.com>; Jiandi An <jan@nvidia.com>; Jason Gunthorpe
> > > <jgg@nvidia.com>; zhangfei.gao@linaro.org; zhenzhong.duan@intel.com;
> > > Krishnakant Jaju <kjaju@nvidia.com>
> > > Subject: Re: [PATCH v7 3/5] hw/arm/smmuv3-accel: Allocate vEVENTQ for
> > > accelerated SMMUv3 devices
> > >
> > > External email: Use caution opening links or attachments
> > >
> > >
> > > On Thu, 19 Feb 2026 09:01:01 +0000
> > > Shameer Kolothum <skolothumtho@nvidia.com> wrote:
> > >
> > > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > >
> > > > When the guest enables the Event Queue and a vIOMMU is present,
> > > > allocate a vEVENTQ object so that host-side events related to the
> > > > vIOMMU can be received and propagated back to the guest.
> > > >
> > > > For cold-plugged devices using SMMUv3 acceleration, the vIOMMU is
> > > > created before the guest boots. In this case, the vEVENTQ is alloca=
ted
> > > > when the guest writes to SMMU_CR0 and sets EVENTQEN =3D 1.
> > > >
> > > > If no cold-plugged device exists at boot (i.e. no vIOMMU initially)=
,
> > > > the vEVENTQ is allocated when a vIOMMU is created, i.e. during the
> > > > first device hot-plug.
> > >
> > > Why do it differently?
> >
> > This is because a vEVENTQ must be associated with a vIOMMU, and
> > iommufd_backend_alloc_veventq() requires a valid viommu_id.
> >
> > A vIOMMU is only created once at least one vfio-pci device is
> > attached. If the VM boots without any cold-plugged devices, no
> > vIOMMU exists at that point.
> >
> > In that case, the vIOMMU is created during the first device
> > hot-plug, so we allocate the vEVENTQ at that time instead.
> >
> > So, the difference in behaviour simply follows when the vIOMMU
> > becomes available.
> >
> > Hope that is clear now.
> Ok.  So maybe this is just a description thing that was confusing me.
> The key to my mental model is that both conditions must be met. That
> is SMMU_CR0 has EVENTQEN =3D 1 set and there is a VFIO device present.
> They happen in different orders in the two cases?

Yes.  And EVENTQEN is set by Guest ARM SMMUv3 driver probe time.

>=20
> What guarantees we don't get a hotplug event before the guest has
> set EVENTQEN =3D 1?

 vEVENTQ needs two things:

1) The guest must set EVENTQEN=3D1.
2) A vIOMMU must already exist (which happens when a VFIO device is attache=
d).

EVENTQEN=3D1 is set by the guest when the SMMUv3 driver probes.

These two things can happen in either order.

In the cold-plug case, the vIOMMU already exists before the guest driver
probes. So when the guest sets EVENTQEN=3D1 during driver probe, we
allocate the vEVENTQ at that time.

In the hot-plug-first case, the first VFIO hotplug creates the vIOMMU,
possibly before the guest has loaded the SMMUv3 driver. In that case,
we wait until the guest sets EVENTQEN=3D1 during driver probe, and then
allocate the vEVENTQ.

So we do not depend on ordering. We just check that both conditions
are true, and allocate when the second one becomes true.

Thanks,
Shameer

