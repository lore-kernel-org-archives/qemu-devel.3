Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB7A9E81BD2
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 09:25:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq6T1-000432-Li; Wed, 11 Feb 2026 04:25:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vq6Sz-00041s-Rf
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 04:25:01 -0500
Received: from mail-westus3azon11010011.outbound.protection.outlook.com
 ([52.101.201.11] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vq6Sy-0003Aj-4W
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 04:25:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yfFAD2OEWorqjv70aNvmJTGMwkFxXhPTXrsvKI9tcNkoyR7JYgt1AdmVgAbcIzdbNHeYIwAVrpIeYUztEXDiSu2/E3ydpCtYOkxCTL2YfDDTk51PYgJdhxtxpsJ2Y0q4+H+fyg32p/HsBdd9M0Mjz+msDjrEoelQY36vXjlix43pqMGHCNKSxJQ2ZW9glmvauEU6X2e5mBfd2mNT0PVmPT4CCVyh8mPBbLn8XMYLPeg8oBZbyfEhvSO9DwJnpTm+AsX30KdyiJHmxqerrtW/PN4ORiqxkqahn1fJ7sVWnF3OGgufDA8mFXbVcO25DmcRUfYi9JB1rvMCAxdPbA4BMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TletMeOygm01HmynSzSEq7YJV7s84RfU2A5CSH5OTKM=;
 b=YrHcEDVvlfsAVYaLf2N/JQtFNoVCgTr6RMbfRbY0dnPN7cmtMhU9oak4b2pVq/rjmffo0xCbcKtyMqqom8tmmLliveOtu1D1odjPkn4jTt1bhJTzr7YN5n2jEPcXUWX9lWRLh/YzgETAYbYo5Lbe8AGVXHhLX5oHRJvCzUZCML3rlb2F+OsjeoXbOhO9MBmuIwconeqRAQfF1oTAmux6JaBIIRKgCNKZFbybC6Ymc+MLENH2AvqbbNqiMgTNzA4TxZsG4xLVaq594DD7eStuGHhu5jwA5NRNiY8p4QxDIdGnusJzDeQCteToEpu0sXgGWVMzZPfmAhCse8qSsxdMUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TletMeOygm01HmynSzSEq7YJV7s84RfU2A5CSH5OTKM=;
 b=j/t5XE/P5xumR7eSPOr0FmSsYhGdia+jjzCNNetjK7UcDw/jfFS9PsG40DXybdKsoCIp6Jmbm4TsPVSDlO6b1Wg54q5uwY0063RGiJUVev3X2SyCfsBvhXeCvBwLaFdh9kh0TsCJz+G0CSpDWK0N5OA81Ihx20ZuhjfDCqloLYOoTg1oMUpEKd4B7mDxfhxkrGH+DVuR4n/YlyJkaq+z6toMWvyq5h4XFuvhe3c5uSJ0aOR6Cn9SGFEJzDifhvfyaxFjkcNVhBXQL+1lqM4kCvcMvbcZCbZa+2olD+mcLwYNJVQR1T5FRcL9A30wOeenGmJoaF0Q6AU2r4gAOS1l4A==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by DM4PR12MB7693.namprd12.prod.outlook.com (2603:10b6:8:103::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 09:19:53 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9587.017; Wed, 11 Feb 2026
 09:19:52 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, Jason
 Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, "xudong.hao@intel.com" <xudong.hao@intel.com>
Subject: RE: [RFC PATCH 01/14] backends/iommufd: Add pasid attach/detach
 callbacks
Thread-Topic: [RFC PATCH 01/14] backends/iommufd: Add pasid attach/detach
 callbacks
Thread-Index: AQHclk1A0jbRvwQcXUyYvASyugR2rrV9OhEg
Date: Wed, 11 Feb 2026 09:19:52 +0000
Message-ID: <CH3PR12MB754856C12CAD98891555C791AB63A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260205031133.74357-1-zhenzhong.duan@intel.com>
 <20260205031133.74357-2-zhenzhong.duan@intel.com>
In-Reply-To: <20260205031133.74357-2-zhenzhong.duan@intel.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|DM4PR12MB7693:EE_
x-ms-office365-filtering-correlation-id: 1e8edea1-9cf6-461e-9d89-08de694eb6ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?tOD/BUi6YJlXHjSqFqix812CvUx8iUJNlEqEWwSX8VGAmOWZY8z87LZCkYpx?=
 =?us-ascii?Q?Kd/F6SFYqLXZ7GU/HjKo1m7DSF6KYnckdN5883iP+WTsaceYQS5nsEXvXcUe?=
 =?us-ascii?Q?S382SQYP23XL1ypUwsaXYTURPdY5ZwgsKTtFnSOvA13SxzyCINZw3UOwAwk0?=
 =?us-ascii?Q?B6x50UAoGbciwmepIboOiHclDhtBJdR7KH8T8afVCZFaAZ6klisyoatjfJJ6?=
 =?us-ascii?Q?EMsJtfRiSf9fcnog0jiUkhtQZAv6nqfm46RZ5K15lSk2XcCbGgPqq5LqOLiE?=
 =?us-ascii?Q?hP8vzREWm1K0HdBkEe8k4IFr6auwc9nskA9BMCNq6IijKVC2vxEVIywr2nYD?=
 =?us-ascii?Q?QAItGgCHboqyqxEWW0oPCYH52i0NgD8ikPyet+Z0W/ZrqIzeaMXK1+iGPObi?=
 =?us-ascii?Q?3enRUZrj84CDjubWlmlRPH5nhE4qUsQ/S1KqSdeRV/Lo8FRvuQ5arK3G9PJg?=
 =?us-ascii?Q?vU6cTTq5NBFTp7shtzbmfufegwhiDxm/RsX51RXfFvT3L6HZZicWmvIWrH+S?=
 =?us-ascii?Q?VBsgfH7Smgmz7mz9zU6B6u5N9ACz6GTXodq2Q3bPuNFZnbSRKpdtleTS84KT?=
 =?us-ascii?Q?lpYXO8G3bvIoA/hYRYHy4cNWVEJbwCNOtQzOIH3i6kP0emc/n//iFEnQ7AbK?=
 =?us-ascii?Q?vnanOnd48u8J4tJQBURt1IgigwHvBJLOTPMygG2Bq4R6axgpLQovQaneKJ/S?=
 =?us-ascii?Q?g8eBWh1oMuOLdNOsTr3sbK5SCtw4wdfUIfN6gymDvcEFPKtfRMdXGqVfOO1B?=
 =?us-ascii?Q?f7HCJuepT6J2hvjbg5+3Fw2wpxLGWt/NCmu84cidIXCnudNRxwdR1CtmF2Lp?=
 =?us-ascii?Q?Lrx0KI8o4f2sm3EoolHIWu01rnsrzSXRL/CWddM1fhWXFn/EP0ivEYeumakS?=
 =?us-ascii?Q?8Hc/YNIvXLLj63ORMI3u2T5g4w9iuTDoPLReNX4XsOMQ79KxMmlbPLGnZknS?=
 =?us-ascii?Q?Nny1cUNYTYC6/X3y69QbD67tYJ8OlFCSAPJfp8/9DVQMscDJpOM/Im+A1LjA?=
 =?us-ascii?Q?qqF3zjpXGqb8IjCYln2wIKNBkiDsWhkxJZiXLYibpNJnkSO+VVHhPGPGVVy8?=
 =?us-ascii?Q?uMhPum6NZn+62AnxN5VofNg741L5flbyXmO1qnT4Q5lXq0ByM07LE0TLaogl?=
 =?us-ascii?Q?nkctzK3IAcIPBQigirBsqTtS5PkEt2GEtTR4MiH5kkThTaoF1uOo6kKgfG2X?=
 =?us-ascii?Q?PtDkqOhAQgkYZgZcpNhhlwRCDVEUzext0QuMbHc7LqKmXT3WQGPvc5EZyaSW?=
 =?us-ascii?Q?TwnRiaazczSftGUTW/2SsRlMIkwqS7zZTTrjMwrDCzPClEVRZldnnG3cXWOq?=
 =?us-ascii?Q?o0Vq76oVyqk42n4b0R+Qmx8cdXH+e7iOyvPfkY5+mE5Sj8eh+mcdPRkgpBm+?=
 =?us-ascii?Q?C+zXc+FhFEhBdJAQdKuLTbKyujcjdlSiOS8u9WpVxfL1kOY2US0+ByUXAxB+?=
 =?us-ascii?Q?xq+FTKN6Q6Qozt4U439PobvfcLaV9kof1ZVHPB8mfkAsCgWmWSmRB1bbm3a1?=
 =?us-ascii?Q?jC/obH200+2YUFQQZ2UsSckQn4QkJtpAQwRU6LDKcE+urlA2nXBQLDhaX8al?=
 =?us-ascii?Q?yuJhGbM/k/0czWCbKo+VBPKptG1rxm5F4PHOD0EM8H83ULvJIXHBvSUV1hZU?=
 =?us-ascii?Q?LjM8KCxxFB4qLEMMqUdWVCk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Nl9N5FAIJR9Ah72JQAPZXNrbQ4IVYmHfMsx2X93REWGZ+y/lQaSniECDu+Xm?=
 =?us-ascii?Q?ot5OMCC5xc/50ka9SlcAqzMHKk3pLrB+mh/2YoDNWwrONbq5b09Ld+R1NUq6?=
 =?us-ascii?Q?qkU/Ww+KsI9TWLkKQ90O81g9S+MnLFhPLai6QV49z2caHt3q7CS1l+v7kmEb?=
 =?us-ascii?Q?pvyyXsz10+WsO+qKFuX2vYnZGtSPyYwdk6qu9wFhAekTmVUA5Q5IFHdle1Cr?=
 =?us-ascii?Q?iIdKK30mC7u8nDOy3F+HOEdro5PN6Al1WRhMG04JqRFdbTNuShU5vmyBvZy0?=
 =?us-ascii?Q?5+nkzBls+XctP82m0LEIlVq2+AU+B0m+cJHdjxM61W2VFF5Z5z6nCGMUUuvL?=
 =?us-ascii?Q?tysRV2WMA9rQNbn1oeKdYUQOv5PZNr3JPzGDkEP76gFSu4fvyIEFfNmy/o4z?=
 =?us-ascii?Q?SPYr4AMugWxeuw+Axg5+yHG0Jib0Z+eaYSB7e58Y8Uvqm+NrI3Pf1VFuZvsj?=
 =?us-ascii?Q?IW/Wm9sTWQjJ6nNPT/0Bf4w6aIF3QDlFWQR0+66b4lgoyq101adrqCQeMoqa?=
 =?us-ascii?Q?Hd04VFr5TE3yg5zdW07Kdky5Q66xdGu99E1XNaKYqDlVOPyWVBAuT4Xwro4N?=
 =?us-ascii?Q?ln7TkwQBecxm56Ne1RpMMdQHjpLTrFWh1it5hbn7kuqrUrHUb+NliIOFSfrH?=
 =?us-ascii?Q?4K33W3/QFqi55WF4KLfbNXEqEPtpUwM3sObhCbnSbsbdRvx1rA3EMC2BTPn5?=
 =?us-ascii?Q?3ulcqgsF+SJubh2zsiLlp9aoBa1LjIO0CkIJo4wJycsX4MdxzVwoBRyKletv?=
 =?us-ascii?Q?xwutYjcjq1zlCRgYEVJNiCquj1LlPBokRsmmVfGLWYp6jYMPSryAoL3AgN04?=
 =?us-ascii?Q?G5snhX/NRjB0ARgTbZQNxBe18GzcYynSxDaLyxzB1VfS7LBMFLPyYjgqqfN9?=
 =?us-ascii?Q?5Dz7lFS6yQGERcJHxoj8g3bpLl6Zdwl6SpbwzeWFLUJ/0B0f1JoNXVq4j5Op?=
 =?us-ascii?Q?wnCjBtQ2lwhmaT9a/oXgbOQZL2XDkEVG5PD3ZxsJHFsWapODIRj3V+TVMRU5?=
 =?us-ascii?Q?eXIe0QtmmkqpYkS76jhcSrze+8W6g9q0Yz4v0uOsh/8Ea03fnFE+e3g+P3yC?=
 =?us-ascii?Q?bazcqqyhpMlvC6DDCWaWi4gPU6gTS69vykxD51abNQSL5LhcnB5xMHxfM2CC?=
 =?us-ascii?Q?eDR0JOjrx/h61j0/0sFyikIcg+VJeFJMZmkSDPEU8Oy/3e5C1tSOACxxaFkk?=
 =?us-ascii?Q?AYdFg7qVEvYDig4IG8SduOavmCR0etMSPM4P4lnAZ/1t3mYa7FrU3DS/ZKiP?=
 =?us-ascii?Q?Sgm8t0lqcq5jwO0bmE0d6ee4srg7918MmiHnt0rbqa/2BZpBWMwhOaukGbab?=
 =?us-ascii?Q?KJQHWkz1a8f1H+5fstcVrfGapClbm8iudFpoOaojSvrV9WWQEdhm8KMU2SzR?=
 =?us-ascii?Q?6jvtb5EI3fRnwE2l9WBuhAeXJzDvmrjeFbNfdjen6zgLgXrxr6qiMDbUfg3j?=
 =?us-ascii?Q?LbJAmimIN7bkBjUjxhqDxJvLbu22o+8hnw4FSp8ELtpfGecZv476uoCI/+q2?=
 =?us-ascii?Q?nxEDQC/u67uZ4032OsoFNkKx+nNJ7g6osF8f8eSDzBh14CLLzIuvDptBs2AT?=
 =?us-ascii?Q?Yzq/H4joP7diI+ZTZsf1927vTigcfxBbhTtay0ajPGBaMsPX5OulNbocMISf?=
 =?us-ascii?Q?eboBhVmAorTQKqO0/vzDdHyjBTnIMGt1VmzgcVqK0i2u7ndJ4+fbNlyMyXvc?=
 =?us-ascii?Q?h0PRecbr/Wv4Gmd+2QzOC275fiKEqKOrWMqFa3813rG5QpEHyWMrlGCHOT2m?=
 =?us-ascii?Q?cMWRp9J7eg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e8edea1-9cf6-461e-9d89-08de694eb6ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2026 09:19:52.8054 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gVyWew8UrDeIfj+FHmZJ4HIrnOx3s2pa4wUqANSIqSpBrzgUZWH4Ulzj/Kqjq/mJMEuXYEd8puzPNwZGDsP0mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7693
Received-SPF: permerror client-ip=52.101.201.11;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
> Sent: 05 February 2026 03:11
> To: qemu-devel@nongnu.org
> Cc: alex@shazbot.org; clg@redhat.com; eric.auger@redhat.com;
> mst@redhat.com; jasowang@redhat.com; Jason Gunthorpe
> <jgg@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>; Shameer Kolothum
> Thodi <skolothumtho@nvidia.com>; joao.m.martins@oracle.com;
> clement.mathieu--drif@eviden.com; kevin.tian@intel.com; yi.l.liu@intel.co=
m;
> xudong.hao@intel.com; Zhenzhong Duan <zhenzhong.duan@intel.com>
> Subject: [RFC PATCH 01/14] backends/iommufd: Add pasid attach/detach
> callbacks
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> Add two wrappers host_iommu_device_iommufd_pasid_[at|de]tach_hwpt to
> wrap the two callbacks.
>=20
> Use assert to ensure the corresponding callbacks exist.
>=20
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  include/system/iommufd.h | 40
> ++++++++++++++++++++++++++++++++++++++++
>  backends/iommufd.c       | 23 +++++++++++++++++++++++
>  2 files changed, 63 insertions(+)
>=20
> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
> index 80d72469a9..615be10aed 100644
> --- a/include/system/iommufd.h
> +++ b/include/system/iommufd.h
> @@ -145,10 +145,50 @@ struct HostIOMMUDeviceIOMMUFDClass {
>       * Returns: true on success, false on failure.
>       */
>      bool (*detach_hwpt)(HostIOMMUDeviceIOMMUFD *idev, Error **errp);
> +    /**
> +     * @attach_hwpt: attach host IOMMU device's pasid to IOMMUFD

s/@attach_hwpt/@pasid_attach_hwpt/

> hardware page
> +     * table. VFIO and VDPA device can have different implementation.
> +     *
> +     * Mandatory callback.

This currently appears Intel specific and calling it "Mandatory"
may be confusing. Have you considered extending attach_hwpt() to
take a PASID instead of introducing a separate callback?

> +     *
> +     * @idev: host IOMMU device backed by IOMMUFD backend.
> +     *
> +     * @pasid: pasid of host IOMMU device.
> +     *
> +     * @hwpt_id: ID of IOMMUFD hardware page table.
> +     *
> +     * @errp: pass an Error out when attachment fails.
> +     *
> +     * Returns: true on success, false on failure.
> +     */
> +    bool (*pasid_attach_hwpt)(HostIOMMUDeviceIOMMUFD *idev, uint32_t
> pasid,
> +                              uint32_t hwpt_id, Error **errp);
> +    /**
> +     * @detach_hwpt: detach host IOMMU device's from IOMMUFD hardware

s/@detach_hwpt/@pasid_detach_hwpt/

Also comment needs update?

Thanks,
Shameer


