Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C1FCCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 14:45:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDkwf-0005IR-2D; Tue, 28 Oct 2025 10:45:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vDkwT-0005Bg-KG; Tue, 28 Oct 2025 10:44:58 -0400
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vDkwP-0004fT-O1; Tue, 28 Oct 2025 10:44:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TKisauXN54syKfdShewlBRfVuum5TPZTmRGAzb5+AJa5LpMPEu9aPpwLqH5SXCqWJhLHHSEUffoT5xEBYl4eql56yKlpxA+nEZGaMG3NUnQ6TqkkhCMppBhNPEnSq7S98JxIc4Ql9+B7ordYJtq0IlFCKDYOeap0ukbQLk+gpS8InAY0gbGI1r6Ou4Ikt2AQfwwyY0fzEgJPuDNF5ymyny1I1WCoMg19ruYg/vJRW+MFnqu+1c+vgOyk7tZGVwq7hT1cs1B2oJfZqvM7Xowh4q4Z+WCnU1dSf7DnrDUOiNYXE/Gdg/6rRpAO5HotqYkMmGMgDyZvbOCB5132ZHGiwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CZRv10miyeR24mdO7IjK5iLgyAq6iEMhRMtLM3UBdh4=;
 b=GrTW5k1wjphuQiGNXEKeG628R4+3i/Lc9EQXlRagIYQJVODDBsoHeKQMEL4u9pD8e1/WnlpfYAE4bWHTO1Gp6LXNeRMHXSBu9pribjx0WptYPdoS3gbWd/jvz2E6k5SYDinaXZypR5yDMhz9/YhvfwC6ZjV3fmZby1FLuriVcvXdcsYI3Rw03Iy7DgjBmpWdVc97J3E+KfxJ5ss6RLpS4cPKNIomtihPoRR4ZSt0yhEAdlkh3o4uLW7L0fpd+or055CO5vB2RILTECcMSTuANGdczHpkUOxx6M3QK8YcuRAgaZgdjmxxC2UmXNkZi/NKC5xR9Keqql8YjbpEyg9Gng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZRv10miyeR24mdO7IjK5iLgyAq6iEMhRMtLM3UBdh4=;
 b=bT6q+spa1aeESBngRgzL/wrMgjgZEcsSh6jZ0kQVrHTsHYcOIwXNo6ckth0jE34dVimQ2kNgDHxBUB4O+n9lIUPcZNqaa/1ESTQ20eZPApHVVqqGPL8j03tk67XolQcc1wapsj/c0V3az39IPa6oy1zJcFCL9fpjTmyHqXWQb5sWSf3q2lY79xD+z8kmE+oCV/x4H7mbyiuFhDAm38pLdAm+NwBDkdkSaZNyFv8wcykRLZCWJPlpYEjjrk95Rq0xCFqgusrIiHj5lR8fBE/of/f5soUXmwRGyZMC5v0+W+bzwfmJ/dNPbScI90ZtEP6HoQYxwkVZvfeE9KMrnArA7Q==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CY5PR12MB6477.namprd12.prod.outlook.com (2603:10b6:930:36::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.16; Tue, 28 Oct
 2025 14:44:39 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9253.018; Tue, 28 Oct 2025
 14:44:39 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Eric Auger <eric.auger@redhat.com>
CC: Nicolin Chen <nicolinc@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, Nathan
 Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, "wangzhou1@hisilicon.com"
 <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, 
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
Subject: RE: [PATCH v4 22/27] hw/arm/smmuv3-accel: Add support for ATS
Thread-Topic: [PATCH v4 22/27] hw/arm/smmuv3-accel: Add support for ATS
Thread-Index: AQHcR2MFngFyUDoiY02aRyWaAGA96rTWO04AgAAG1gCAAAQzAIABND6AgAASMgCAAAWpAIAAArWAgAADaACAAAjEwA==
Date: Tue, 28 Oct 2025 14:44:38 +0000
Message-ID: <CH3PR12MB7548868B3DC111DF90364DCAABFDA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-23-skolothumtho@nvidia.com>
 <26f4d9b2-75be-4913-bb60-01e647a7ec83@redhat.com>
 <aP+oRLu/BYNaAPHG@Asurada-Nvidia>
 <25d22f06-69e2-4954-9bd9-f73f899fc114@redhat.com>
 <aP+xhmLCRu6y0eQm@Asurada-Nvidia> <20251028121625.GF1018328@nvidia.com>
 <9748e922-057b-4e7c-ad6b-b83f5591290a@redhat.com>
 <20251028134148.GH1018328@nvidia.com>
 <15e0d683-e524-44ed-b253-c6221585d9bd@redhat.com>
 <20251028140340.GI1018328@nvidia.com>
In-Reply-To: <20251028140340.GI1018328@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|CY5PR12MB6477:EE_
x-ms-office365-filtering-correlation-id: ad415b70-c6a3-41fb-5de6-08de163085ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?pYOqaC/AVbOUMZ3PTrG14kP0LIUd1pmi5rj7kHKipY6joQHyAsQVKgiQMfgC?=
 =?us-ascii?Q?is70SOmWfNf2juCpqL3IwJ3ZpEehQzHVI69HLbMqw4gj40lzkhJgnv/Z3TU2?=
 =?us-ascii?Q?E9jtAeOpk467GwhCLHaf+//UPhXveSqm85OsWIprcjxq1+O0vp7YX7n1eDM7?=
 =?us-ascii?Q?dy027d1TeEFMIqXxhMQ2QbZOQNuTXty1Id0Bz5VSScurHd5yqbf2Bbm1Uf1q?=
 =?us-ascii?Q?SSGi5J9QMCUufyyNR5W8gOwTI+yQU9u0N6VlKpjgXe0Ia8IOiO6HkPwvFjAP?=
 =?us-ascii?Q?HATUcBPQGq2/9PMnn8wmwepyP0kLbpLGForCo7BfKWUcm7cdCOlR+acKmyDV?=
 =?us-ascii?Q?NzLHRbt1NNEv9gUxUH2XQGFt5AU08BpyGY5NAxlwE9Su7fQAHaWhq9WPglv8?=
 =?us-ascii?Q?TBch3agRj+mnQWRvA6bRIK4Sl50WGVp3594hrjFqlcM66BX/fJ9BSu/UhfPU?=
 =?us-ascii?Q?1RNUfIUBPwd1T6R1lC0iAndF6qRcZSP95RfGqC1oQg2/PffAzckJXmy9A+fZ?=
 =?us-ascii?Q?fQCqWVrzEc42GzslQWYeXpohajkUSCqZ3BGue1Wrrgtb+5hF/QmixdzclvYG?=
 =?us-ascii?Q?HArmzgBu4uC7GhnfxOd41Pk+UuMX4l8ZPPUCfbETqSPW/CTov7X19jAkVgbj?=
 =?us-ascii?Q?+XDzNRsM90JjHzTrF1aFWCRnMuylN/sCGjI0ciQoaod5/BmmAcSNnBv/k/1d?=
 =?us-ascii?Q?4HuT+lujcyX0h9fHQoxso8doTYNZ9moLd5FjR9sUoBpgQraRKTev4+/jnI1F?=
 =?us-ascii?Q?AitRzdDLjD5+8Z2P6E8rJ4SfQywIX4K6D/7EKiCoBU/1GKauaF/UONoFFK6T?=
 =?us-ascii?Q?BHV3Ls4OdnO5WgTPn5LoGtrnpxnn7gPGSUt8v+0rCYI21INwjbiFyc6PkgJG?=
 =?us-ascii?Q?fc/j+feHrR02uWg5amC7mb+J5A578KxspCO3CyTaR/CiuialllPpPYAmVE/q?=
 =?us-ascii?Q?dREfKcn53zZ2BNNm7ygqEI9jxo4kJgFrQbYThNsVHI5COxztqY3PCtN0ulwU?=
 =?us-ascii?Q?n0iU/nQE4UTFzfPTVqy7ApILN3wRA77XeN9mG55Tnm98De3CiGBxrLNT5bka?=
 =?us-ascii?Q?riCfnXskeeh46NRj6M92KWzazpNZGVjNACZqxeETuTVYTvpSulAHGRKoVVu1?=
 =?us-ascii?Q?m+ylmcOX1J+iKuN3u9m0y80j08KG7Pw7uTKkm4cbFXw5HYrwAEKcEq/1eIMz?=
 =?us-ascii?Q?nkVcaRQFH01REa5ImAyE8dF/EcjRFFliYznN0Q/61id+c34A5vUeQfI6Y741?=
 =?us-ascii?Q?0BQbSRw4HRkV0k1eF4YXArIfwwvmElA1SP2dlmrzFtVpKWyqxEaZvsMjx0HO?=
 =?us-ascii?Q?Lb1vMqwRgfSHvciuOANbHuNMXvcjlN6eB0d6kouyZcD2YEyvPlOt16Y1dGlp?=
 =?us-ascii?Q?EOOr4IRP/yOYcTBnOGjdq+lUEXpHiojoshw15HmSx1hoSNALjrN2w7zlClRq?=
 =?us-ascii?Q?CA4wCbuoNVrff0wdnKky+IwrmfF7UAZxWwPi421yNvsTkvGhSCtIjjYTGd7K?=
 =?us-ascii?Q?f+sgd8bomrOjPN9QQxindkH0fTHRdcaHQ+Ez?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aocTteZm4fDjNSOpxMdrDg+1w5Q1/vinK91bAMmBrsgfD42DZw2GbTRfL3oP?=
 =?us-ascii?Q?wH9mCPpOMmuWCyvmK9jPGNZmCf1/Holju3kKvwCsnXwweSe8V0Sd6M/ruKs3?=
 =?us-ascii?Q?Sg2AsvqmwTK8tAf0aUrMVYAFVBWG/Wy11GWSMpFZkwvm2zqXneCP2BGNeuAq?=
 =?us-ascii?Q?QDvq6wZXSvf4W0lF30VOqvtI1EsKpLA5EIIQXhAAzix1GQ4lqhq7c+WoC/x2?=
 =?us-ascii?Q?lW6dMo4gjjGs/iZLpx35zU2LTZMXOuqxV3UaxdKk8q1+mWbJU8px8h6Ga8cE?=
 =?us-ascii?Q?6g25Kgr/sVaHDtXCv53t2itivaeCtwifDKMHVBELWZSK600QZ5lgR5NdmfWB?=
 =?us-ascii?Q?CVkp1Y5qai6eK1kcPdWtQA3LcGxVLvgrobTq5eBXdIqZEJahbbA+GGsmRl0K?=
 =?us-ascii?Q?U87VEzttqfEBzcgYczdq2/dO9XVXQyzXHmuQiWp13mNAFLxu059sdXBHRm77?=
 =?us-ascii?Q?xf9H0UQZk1ZBeN9xsDRVPj8v/jkcE1ZLm3HnB8B2qG7fBVpVm5SLGSy23up9?=
 =?us-ascii?Q?OF9WY3WYwHNq12aDBFBWXyoogmblSvv+B5j91q02Stnbe811ITxft3RCM2iM?=
 =?us-ascii?Q?4VChNl9bMH8uIlSURa+wNNMP0xNQa37+90DdYgc+XdjLvi4n8tEJgCOtq8op?=
 =?us-ascii?Q?MmZeeVrVJRiP/Haj7aubhUtfmSJFB4KrUu7P9yDJ4lWi7xbb/vF/jYKVViGZ?=
 =?us-ascii?Q?yFrTUq/BiKfBJpNdgNhGQCIf6zru7pQ3cKVNriA8eMvnWdLAuWwL0+HR18J0?=
 =?us-ascii?Q?O0S3pjVHkZwbRrP4MPaHaQg28JGMRNw5paIlJrWGcHuvSsYgkqY5rVaHHxnH?=
 =?us-ascii?Q?xbLQVju9Rr5Ih7UUHjzLGn/UxuRqshNH3FizJBWbcC/29jd1Gl9FRIVbwbmZ?=
 =?us-ascii?Q?HctaYJ6Kf3QaSceNMPq0rayiLFwK5gVOJmEn3btgdE/TniRB14ybL0pF5gXy?=
 =?us-ascii?Q?WORT2WZ0vPF+0zA7+FcgVmoOiyBkObsngPX84ZxvJH4Vxgt3aqy2dnLd8tHf?=
 =?us-ascii?Q?aLKI62ABq8rT979xakoST7ySyvaCf5VD89RyDMy1G8THOOXzEbgq0qlk+yTp?=
 =?us-ascii?Q?OhJ0jaFIYzsTPhFu4i6ty1tlNKkbSFVI6tFiZLGytw21nCI32VpKRY+G7hqZ?=
 =?us-ascii?Q?hXYmKrZPnqBnRbQrCsGNbImnccu1Zb9mRf1uQpbo1+rpBLEHmT4yqgyUo057?=
 =?us-ascii?Q?qy5AnxWvQsZlCzXIBCv04ufqrkSvdgjo0vI9nxiJAA8ZNaPpGDhMVtO9YBQ2?=
 =?us-ascii?Q?fclINm6yRQWFWPfElGZTiNFyQZm1BD2ZgQ5DZMzbXbeweuPzFYFGjQXxW3Au?=
 =?us-ascii?Q?CqKgSk4aszYSCMsd7Xs8VwfSIMjYWCpsdFZmqKioAH+i5c4O0sJe8r7/ADOp?=
 =?us-ascii?Q?xXiiu/JURcwGmhQoyCyMJZ8iz5gi7HetN+y4GZZO470iEttxQNBibTs/jDQK?=
 =?us-ascii?Q?/y0CIYerjVB0hFwG2swG9KLUtIaiESnpUeSjoR+PKn8F6v8k8gCeyKpDPvAg?=
 =?us-ascii?Q?JETx6war+RsEdyxFvMxFiULVDHwWl3scxOwGuazJHR/xoPv1vgd/HvidHlmt?=
 =?us-ascii?Q?p/Dhjq01UcKuhuSBCvdwXJ+YiNPAsAiq3NDsLuc7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad415b70-c6a3-41fb-5de6-08de163085ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2025 14:44:39.0104 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KhY8OJZIKCyXb5wnmTeA/atujF/FHBLwx5U7ZrXvvqnz14j06an2NYXR8oWga9rhMn573anPUB+l8evejCdW8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6477
Received-SPF: permerror client-ip=2a01:111:f403:c000::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
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
> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: 28 October 2025 14:04
> To: Eric Auger <eric.auger@redhat.com>
> Cc: Nicolin Chen <nicolinc@nvidia.com>; Shameer Kolothum
> <skolothumtho@nvidia.com>; qemu-arm@nongnu.org; qemu-
> devel@nongnu.org; peter.maydell@linaro.org; ddutile@redhat.com;
> berrange@redhat.com; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
> <mochs@nvidia.com>; smostafa@google.com; wangzhou1@hisilicon.com;
> jiangkunkun@huawei.com; jonathan.cameron@huawei.com;
> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; yi.l.liu@intel.com;
> shameerkolothum@gmail.com
> Subject: Re: [PATCH v4 22/27] hw/arm/smmuv3-accel: Add support for ATS
>=20
> On Tue, Oct 28, 2025 at 02:51:29PM +0100, Eric Auger wrote:
> >
> >
> > On 10/28/25 2:41 PM, Jason Gunthorpe wrote:
> > > On Tue, Oct 28, 2025 at 02:21:32PM +0100, Eric Auger wrote:
> > >>
> > >> On 10/28/25 1:16 PM, Jason Gunthorpe wrote:
> > >>> On Mon, Oct 27, 2025 at 10:53:10AM -0700, Nicolin Chen wrote:
> > >>>
> > >>>> Hmm, that sounds a legit reason, though adding the ATS support to
> > >>>> the emulated SMMUv3 isn't seemingly a small effort...
> > >>> What is "emulated ATS" anyhow?
> > >> I guess it means implementing ATS translation requests and capabilit=
y to
> > >> send ATS invalidations. something like:
> > >>
> > >>
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.
> kernel.org%2Fall%2F20250628180226.133285-1-clement.mathieu--
> drif%40eviden.com%2F&data=3D05%7C02%7Cskolothumtho%40nvidia.com%
> 7C9f9c8fc639214f54ca0808de162accab%7C43083d15727340c1b7db39efd
> 9ccc17a%7C0%7C0%7C638972570246014005%7CUnknown%7CTWFpbGZs
> b3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIs
> IkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DYQfzKiIcBbKj
> kIauHU8ELDk15jclFnFcevMMRf7LHF0%3D&reserved=3D0
> > > Why would you even want this? The cover letter didn't explain what th=
e
> > > point was.
> >
> > well I am just concerned about exposing ATS support to emulated EPs
> > while we actually do not support it.
>=20
> Sure, that shouldn't be done. There is ACPI/DT tables indicating if the
> each device supports ATS and qemu should not be marking the emulated
> EPs as ATS capable in the first place..
>=20
> However, there is no big work with showing EPs as ATS capable. They
> don't implement an ATC and there is no concept of "translated address"
> inside qemu so the only requirement to make it "work" is to just NOP
> the ATC invalidation SMMU commands for those EPs.

The only case where an emulated endpoint can appear with SMMUv3
accel enabled is during a hot-plug scenario.

As mentioned elsewhere in this discussion, that can be handled by propagati=
ng
an error from the pci_device_iommu_address_space() path.

I will take a look at that if this is the main concern regarding ATS.

Thanks,
Shameer

