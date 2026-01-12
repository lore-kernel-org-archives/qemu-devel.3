Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53408D2505F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 09:46:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfEUv-0001c6-Tl; Mon, 12 Jan 2026 04:46:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vfEUs-0001b9-W3; Mon, 12 Jan 2026 04:46:03 -0500
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vfEUq-0002hI-Iy; Mon, 12 Jan 2026 04:46:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cj+mYHyVJFru/wsKcOz6OZF55/K6jkgtpotnXjIm/xKUU5Xl97lVEHqq6YUL58OYX7gQ/rBV4i1Gf1Pydb4ioqwsT6N5Gg3InhX9sZhuGVj43DeNOjlgaLjdbZtZzpINCRjIPRvHChl1jCF4SNJm3QNI5jgc0U92Fb8Y0nraMoh7tC+5pyfZRMJB8GmOUYloUoxtvuopmW4KP/YZGeyC9Q6ybA5j9VQlA+/lxfsEyoNgy4lt/lRUnD6Krj/qndXqzKXt0IvL4kxm5s8q4V4UTBM7OumIbRF25C9n6aCXL8jtldnyVHWqBCsAOIfquw3o/IH/Gid4vpaXuHD49lSVOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKvpTGKHzBi1hhZh6R8LnqLb2fASPazqJApHAYTSKTo=;
 b=U0Ygw87OcVhqnocw2SE5EW/0/SkcLqDfDlESf8apjxVsiKsMECNy7bz3Z6KGHeWKiD1S/JGEhGljA8Ka/FC0xFplwyA4iRznb8LHyu6LmqxSrl3zA5sfWtl0JDH8zK77tiHgAz3GFdgK3L4s2YajUcvGhdQPZjMdma/XKrxZLrLGKpnwnTOSoUmsEG0/P6WsnZz8H9piabxvHdJAMNkCiZobbv1iP4inxRn7t5nnRvTnxhE7O2GpR6cavVyBJ18m7mnOKPjlTZiAmcjWuECqOvbuZ+Nh+pFIpCAiik/9+cDOd09XzmYiexMQnKmqooqY0fP9IraFN/r87X7HtYlqjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKvpTGKHzBi1hhZh6R8LnqLb2fASPazqJApHAYTSKTo=;
 b=EfHbCM5thTSbgk7RYFuGfN99sDrS1M8jpB3Sa3Xqh3EwI8xyDe+bm/j3aliai8ukVtGJOHiT/vsxcPdw3o+X/P7XuQ98pvrkUWtDoS1XEpbz0Dt57Wi1r+eJU4njlfAxf6xOHOjwuySMFHuCPLvPvFn249fi8P9x+/EHgLH9CCQWDyqJRLPRIZnhFwRxVbZMX1iVdDrrSxB5FA4F3vh1IUV2ivHYSOwyj2C0IdieFnXefpj/MBnmSYPrWqV9WlG7SthP5aA8lZxBIrTQKVDPnUn4Uu5tNWlgcvPGjkOtoOpitYKDHwtZxIKQCDygIFhI59fmadIJPU6tgxZNL1yVEg==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by PH7PR12MB8122.namprd12.prod.outlook.com (2603:10b6:510:2b7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 09:45:54 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 09:45:54 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: Mohamed Mediouni <mohamed@unpredictable.fr>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>,
 Nathan Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, "wangzhou1@hisilicon.com"
 <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, 
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v7 17/36] hw/arm/virt: Set msi-gpa property
Thread-Topic: [PATCH v7 17/36] hw/arm/virt: Set msi-gpa property
Thread-Index: AQHcg0NmIofDyvvrj0mrc0xS48ivF7VOLyAw
Date: Mon, 12 Jan 2026 09:45:53 +0000
Message-ID: <CH3PR12MB7548B4E80C4660147906DC6CAB81A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260111195508.106943-1-skolothumtho@nvidia.com>
 <20260111195508.106943-18-skolothumtho@nvidia.com>
 <526B3AB7-B0D4-4104-AF8F-012ED34EC990@unpredictable.fr>
In-Reply-To: <526B3AB7-B0D4-4104-AF8F-012ED34EC990@unpredictable.fr>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|PH7PR12MB8122:EE_
x-ms-office365-filtering-correlation-id: 00a1cb43-24ea-40ed-c1e1-08de51bf60db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?fYEZbv5JN4qQSQhdiOEZnReRQxJ3J2C1IkWLs2ah9wumdj1WuTVOOpowawEr?=
 =?us-ascii?Q?ZFVFuXtZP/bvt4WK8LvdRDG1KLd3BAyTTEz4pXBhrvY6a0S3KjE3yvSVUP9N?=
 =?us-ascii?Q?AdFxxL2CBsYdhtPskpbZ9ANVWvhZvWGJB1WH9hSkN7Ii9WtJLfyO6sQY+JFc?=
 =?us-ascii?Q?xAGd2lGytMG3G8epBtz3V44W2XJW+8xqzsIO7mkNDSHWGJ52DBk2F03dvJsK?=
 =?us-ascii?Q?pqeIeOUuwC8laSTqzIz5pmapnA/X2AQs8u/u/BYBRcG6pQuSZGYGk2LZDI4i?=
 =?us-ascii?Q?DeThaXvyoEDExRlw+hPEDeBiEARmDymH3jSUcNRel+Fdocq+qMgxz9awcS3S?=
 =?us-ascii?Q?Wj7LHPM1aJ91YjkVedVPslLaH8pq1mp8wxf9gfgNOqUu71LQcgpX4iAjRMtw?=
 =?us-ascii?Q?U2/0AA/gk8YPQo1WLbuA97UMVWyDncVjnBJa9EaidSvw7r0xKcigk1mNmO7X?=
 =?us-ascii?Q?lxxczVz/mfBXVJG9KYpKV9umYMj3J5Zk9U+dmlOqQhsM0h2qJyUXbiBJ/7VK?=
 =?us-ascii?Q?hUCsRkPDB9HLXlE6qfKiKPKXsLf3N7JHSHx/h94hHa2KUqHCfI31mZO8arZF?=
 =?us-ascii?Q?zf+8BuE5w85hLqklMcC2yrIbmZeHaJvqYSD2lr/a0woqEcPT0+6iK+EK+B9Y?=
 =?us-ascii?Q?KSnyVSJYetfae5fARPAuICuGHwDrwQRtYwdMwAFBk9oQuGsDaFKxq09hFhwV?=
 =?us-ascii?Q?szXyenCj0cVzbsomaBmyl7ZOX2sn8MhDqT86VfZ2nN4IGkjkqMLNDdcOqoK0?=
 =?us-ascii?Q?uYARpjhyWlk0F7LChxMzAsNi82qvnkHDun92hmCI9tVDlCRVc80F3Atk85OD?=
 =?us-ascii?Q?El/l6QOxE77skZhZTN7tigRwXgjtXuO1rED5jNY2SCnuccLcieBFenqmfSs8?=
 =?us-ascii?Q?6Pozht+7xxNdn5qkn5vPOn1iQ6JG7r3OyJe6PPBBYN1DECMPzF+j0Rqlxnfl?=
 =?us-ascii?Q?pvy6WExda5ggTOTSXSp0asrIXdVWYmXohkaH9fhzm3QYheBNzWJxC8LyUVoy?=
 =?us-ascii?Q?E2MzE3BXnv+zULg6KevQegzmYBfXH/Y48QMyRh3grZKVIOKvould9fDlOkV+?=
 =?us-ascii?Q?TmYsRI8mSp4vgohdtXz5n+bLYAg7kMzRN2MYxEx4DKRjGZjNgQCkqtV3kZjE?=
 =?us-ascii?Q?rm9IrVLxVdzScQPucxwvKnyFrHK2X4aQh+jNcI6cRyYl6paUXyRR8bvxlKQs?=
 =?us-ascii?Q?bgSqd37HhzdyfFCMphTbt5CPedtsiSbSwjwLctNutAj/ESnKoLR/xnYpmUmo?=
 =?us-ascii?Q?gkfWewjPpC1pZBpsNN7K/XwvEgo4+B1wRroKVgLLFGAXGNqWD1upXBIkxNCa?=
 =?us-ascii?Q?7FtdhKTECOWWKmCUdv3DmyVe6PG9Bh3l02I9e1Ss948x/dd4tYu9dYfzl+yV?=
 =?us-ascii?Q?CrYgE9LCL5NEsEvAyToBDlns9WvONBdg3PjnRfNSta7Jw/LAyKKbgJ9Gu4lx?=
 =?us-ascii?Q?BBFCt/WNJp7/laW3kKngasQxauVyYFIa+6VhqiQWqIEpUhzAet102eZWCm+0?=
 =?us-ascii?Q?qRoTN6eKcI70je1w91S50yGWO1cFa/6n/NeT?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?62Izyao/Vvems+JHXK5wB/2JYlYOAmc4dPVCPii6wcL5pf1dEnVIgcioVgAO?=
 =?us-ascii?Q?xPJP5XX6+ixpr/UeUTf4A402AdOdanMj7bTE58Nr8Ldsf2Px9lG6kL4JMiCj?=
 =?us-ascii?Q?7m9/9tBIn9Z56h6rC6swGlajUWshYYyVvzzVvbto4zZpaSs3s9RyCGs/sQzX?=
 =?us-ascii?Q?zxJ4nfMTP8uHjjduoMWwI2hAje8xtk11mp0hOBe9TVXlEpnnE5gvyUQ+eJUg?=
 =?us-ascii?Q?efYEcSyPLl2wLJSElCqe6Ut6lABSEl5b0RGLOWz6khwilTdZ5PA+DItxBmxz?=
 =?us-ascii?Q?HkcY5ZWckBk1rRoxpgR5dUMIrCLKgjdYI8ThjqdvI5A1q6Xjw+hmXi+Ue7T/?=
 =?us-ascii?Q?DQfOsH5l+omqz4oKtl8QBAbJ2zUKT9w/Wkf2Y9acbpCI4QNuQwbpCSskkIGl?=
 =?us-ascii?Q?yu95A/Lpxu3DYBFZT9a2sprrGOznNyhcwuz7Qbw/q8BOcrjXdX4dRl14vPW5?=
 =?us-ascii?Q?EJnxGrjvi/fbJU+tM0MJdI0ZjiN6J3VyChSU5HN+l5OMwKVdsAmXFyRuqhPO?=
 =?us-ascii?Q?ff5qwvsEEwz6T29+b/3yO5R31VrDEZGk3hcydnbBzmLb50Qc7ee/ZIiv+O3X?=
 =?us-ascii?Q?6KUQdhUn1aFHrDzjGRUSmrxo6Bo8Jc9OocM4dVBmBzhPb5q/ubHEhgqL2K1+?=
 =?us-ascii?Q?QcPv/sF6j7JHWfxRCmYtWrO+8iAYVjavkrKTmd55G7DZ8G2Aa1XvFsQaGN86?=
 =?us-ascii?Q?WtxjP3lGs4T5l1ERXQhbNE8YoJLIQOEbIi+ayOZ7TKj/fBi8iFlBhqm+/ky/?=
 =?us-ascii?Q?etdXys2WrwG9J6dgG9O7nOhixOp32fk4QvH8QIFFgxZpjbdDdBR6ti3xd8P9?=
 =?us-ascii?Q?3Clam9C75yBJ7nafvET5dbz3c6uS+AkGlUSufUVe9jFMZum7iwTeuh04fTz9?=
 =?us-ascii?Q?jtYK0PBeOeBo5PVtvuVlF3/EcAKiiyPtgpkXfLrTi1OtY/k965iLeiGxyLvj?=
 =?us-ascii?Q?BDnp+qonx9UcpmCtvBy8LkNjVDYh/IFQ3UQQ6qHvwdJme/aHc1fvbhOllp6E?=
 =?us-ascii?Q?/3sM4keJUd19nQeseLoXMKb3514fPy5dk8PolMBmRflOzO8cRCbk1HX11iEV?=
 =?us-ascii?Q?8lkz5uvBl08+TK3s6QErzI72aSXy3fw1OM/08jPLc037TS/flk71XpElL5FA?=
 =?us-ascii?Q?C1Up+sqv9aD63emWHT//avLyM0R+ScYgPGVwvBkd9epZbNdmzfI75Xs3N/jh?=
 =?us-ascii?Q?LkTQ+8TambjGWUKFOv9LbRGiDx/KBZoDEOHesC2mN/48mYUCAL+MLNMjFaZp?=
 =?us-ascii?Q?PSMXGUvcQC5jMDVmzXOy3gx7YCVvT9YIcFM0crqeu5A1moPt5ncNAl3I4+Wg?=
 =?us-ascii?Q?P+GzKgg3MmWx3yMY0pI6o/qRij4CeXSc7cpKCHuzzeKqkOCRrZxpWkrlz5BJ?=
 =?us-ascii?Q?BfkexLzr0kr2MewLT+QwmZdj/KEDNQc/954FL4dM/cO93Z1CLTOFunuAl+92?=
 =?us-ascii?Q?WNQBJFSwsLIo6gnBzRKjhfPLLfVDFeyQ7rvCq5NwryrswdPQ0QrB9q8TN4HW?=
 =?us-ascii?Q?1EWPRu1IVHrlgRhvp3yotCSBIkkyVBS5pP8WYh8/ahXmmMNQsYOp3zwqj+zF?=
 =?us-ascii?Q?tBYBFPMFtIZOeAHr+awRcZzaAm/JoXnAv65ozpV5kfIILMzgFLI1zk7VDDlx?=
 =?us-ascii?Q?tH1GuafkC3U1d4AW/59BHXfgzcjt+kJ4zclvNYLNNxJMMPu6sl3Icqq0RWRb?=
 =?us-ascii?Q?URU8oInPgVQ52pPD/VVCOA0JSE989wjyJABF2UGGl6ONxziXlr+/mphHk6JK?=
 =?us-ascii?Q?y/6x5eQcUw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00a1cb43-24ea-40ed-c1e1-08de51bf60db
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2026 09:45:53.8203 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pmK2GGeGqkD4JvoNJQch5zVi5b5yZiXK/lRNUtq4Kp+kqR/lALusWXWHiPnFBt5qcTCQucl9HkPp90iKrj7vhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8122
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=0.001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
> From: Mohamed Mediouni <mohamed@unpredictable.fr>
> Sent: 11 January 2026 21:44
> To: Shameer Kolothum <skolothumtho@nvidia.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; Jason Gunthorpe
> <jgg@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>;
> ddutile@redhat.com; berrange@redhat.com; clg@redhat.com;
> alex@shazbot.org; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
> <mochs@nvidia.com>; smostafa@google.com; wangzhou1@hisilicon.com;
> jiangkunkun@huawei.com; jonathan.cameron@huawei.com;
> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; yi.l.liu@intel.com;
> Krishnakant Jaju <kjaju@nvidia.com>
> Subject: Re: [PATCH v7 17/36] hw/arm/virt: Set msi-gpa property
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> > On 11. Jan 2026, at 20:53, Shameer Kolothum <skolothumtho@nvidia.com>
> wrote:
> >
> > Set the MSI doorbell GPA property for accelerated SMMUv3 devices for us=
e
> > by KVM MSI setup. Also, since any meaningful use of vfio-pci devices wi=
th
> > an accelerated SMMUv3 requires both KVM and a kernel irqchip, ensure
> > those are specified when accel=3Don is selected.
> >
> > Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> > Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> > ---
> > hw/arm/virt.c | 20 ++++++++++++++++++++
> > 1 file changed, 20 insertions(+)
> >
> > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > index 9d0568a7d5..08feadf0a8 100644
> > --- a/hw/arm/virt.c
> > +++ b/hw/arm/virt.c
> > @@ -3052,6 +3052,26 @@ static void
> virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
> >             /* The new SMMUv3 device is specific to the PCI bus */
> >             object_property_set_bool(OBJECT(dev), "smmu_per_bus", true,
> NULL);
> >         }
> > +        if (object_property_find(OBJECT(dev), "accel") &&
> > +            object_property_get_bool(OBJECT(dev), "accel", &error_abor=
t)) {
> > +            hwaddr db_start;
> > +
> > +            if (!kvm_enabled() || !kvm_irqchip_in_kernel()) {
> > +                error_setg(errp, "SMMUv3 accel=3Don requires KVM with =
"
> > +                           "kernel-irqchip=3Don support");
> > +                    return;
> > +            }
> > +
> > +            if (vms->msi_controller =3D=3D VIRT_MSI_CTRL_ITS) {
> > +                /* GITS_TRANSLATER page + offset */
> > +                db_start =3D base_memmap[VIRT_GIC_ITS].base + 0x10000 =
+ 0x40;
> > +            } else {
> > +                /* MSI_SETSPI_NS page + offset */
> > +                db_start =3D base_memmap[VIRT_GIC_V2M].base + 0x40;
> > +            }
> Hello,
>=20
> Currently (but soon no longer the case for virt-11.0+), its=3Doff means n=
o MSI
> controller at all instead of
> GICv3 + GICv2m.
>=20
> Would an else if with an error returned if no MSI controller is enabled b=
e
> adequate?

The MSI doorbell setup here is only required for MSI translation cases.
When ITS is off (and no MSI controller is present), passthrough devices
cannot use MSI/MSI-X, so no MSI translation is required. Is that right?

If so,  skipping the doorbell setup is expected and correct, and returning
an error would unnecessarily reject a valid configuration.

Thanks,
Shameer

