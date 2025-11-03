Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16321CCFA03
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 18:18:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFz7c-00017n-Rc; Mon, 03 Nov 2025 13:17:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vFz7b-00016u-DQ; Mon, 03 Nov 2025 13:17:39 -0500
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vFz7V-0002Mm-Pt; Mon, 03 Nov 2025 13:17:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NbbfYPum3JMwedwsECHdu+Qf4o4yO8hRZbgOmD0IIBtzVEp2pqNynP6+hFm3nKs4ziANFKHpc1oBRSvItaa7Mnf5IbVk27UOIWIeWe+Xxt4MPcIJpSppNim8iETm5C/jtQ7NBcyRxWLMlEaqpsRB/COanzUJwYMGTaQLhyN/dyRggEX0ToruaYuu50OTkZF5IvjvnAsLQyXUQDHeTM0BvU1CnkBp8NeN9LanYgfBJgP6WwxTHl3jLci4jlJD2anq4JOqF8gJcJAqW8Fw1fN9OIGOZBhG8GLzNmCY9ucoHi0QENdToQWud8KP8G34LsfIkdQSxHN9z0pBQFcdUuql4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wu94ZovqQLCEYbzlK08Vv7ERoibFm4S3BnxNjdrx7Vw=;
 b=tqD4VuTSojFsz22MZFAFwyAGTF9RYRpcA+NoROCpT4xKHzpRTNq7iBoIvLhQWId/JXQdRvq2o1WGRN+PnbsZOIaL7rZ9y2qiOpyPZdC2teH524vm2lWnqx66bcZntNX1maNTOEDUcqF7xy4GYGYUSO0PWIcvVk17MtrODHPGr3tBmDQLxuCihETgaUmjYtBEH+U1tmCu8Y9hvFpKZit8i6Bkxnq6pj8DfkofmTsV4bXLWA641+ucDGScOuMy83twD6dmEbHtQT2cO3w1dkXe8QzMm8c6OMX2uxd1Hm9QDPkM7jMprQwxtQMXQ+18JtCJ2AjFbEZhVcMeHKJeEymAeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wu94ZovqQLCEYbzlK08Vv7ERoibFm4S3BnxNjdrx7Vw=;
 b=gFtH1o63m4G/kGmAdikRmPY6WBql8ThNmqnQ941YH14ozzKsKcKedKB4waCnJ0c4ncVGiBlkO775WH9CbC+U4FEualEwguQahLB/Ej15kXBd5VFSgS0l+AJzdeENNddNYKHgWVeymVy4DuI3KNhnQtvQKog2i2U/FD/TcUblcOYDX3sn5jeUsFDj7bIwJ2UsetW2jPYCvhe35sfdBuweW1n9S/GlaEisqetZEgWbJDRh56yT9g4HoiGNMXX70iXnC5QZj+ixndMkJIJh+GCk5AmJgLsF8L5D0YngdtLP8x/1wUpfrNFLsqfoynfRAXO8o6Xa7gOppsm06vYjnXiZNQ==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by IA1PR12MB6210.namprd12.prod.outlook.com (2603:10b6:208:3e6::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 18:17:20 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 18:17:20 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v5 17/32] hw/arm/smmuv3-accel: Add support to issue
 invalidation cmd to host
Thread-Topic: [PATCH v5 17/32] hw/arm/smmuv3-accel: Add support to issue
 invalidation cmd to host
Thread-Index: AQHcSsdxxb/8tkLCo0G9kXiIeGlCzrThFnVwgAAmxICAAAhH8A==
Date: Mon, 3 Nov 2025 18:17:20 +0000
Message-ID: <CH3PR12MB7548CBA8B4C962BE867C9362ABC7A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-18-skolothumtho@nvidia.com>
 <aQVVxV4I/nh3aAXn@Asurada-Nvidia>
 <CH3PR12MB75481D898FF28E9832B0013EABC7A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <aQjpzdwbJVPN7AqF@Asurada-Nvidia>
In-Reply-To: <aQjpzdwbJVPN7AqF@Asurada-Nvidia>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|IA1PR12MB6210:EE_
x-ms-office365-filtering-correlation-id: c303edb1-6576-489e-97aa-08de1b053ab8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?GlnDRPxf+zZvtt7G0xoI9XDa2akmZF0SCuJFru62dP3QkVKX72Kxd2OwV8Yg?=
 =?us-ascii?Q?pzDUAIE0OnwvaLSKnasNHqtV5gd6ik4fa/HtfbLiMAUNpvjOuKVQXoejnLkP?=
 =?us-ascii?Q?K9Q+MVWGXiZ82yp4e2AfDXyTUGqhpvz/bi3gaO7kWKAGHfUpzf6mZ2m7aNzd?=
 =?us-ascii?Q?/kfrk6gmCIGjNLSAvei8M2JZT5WsBtO0BWXnqdHjWxtW4zdNEewMbHD7aWWS?=
 =?us-ascii?Q?QGZSRt0DtSmRvMO34KOShpssKgbPyqOTw3wMq86kl/d9NLz7suhiC0hugNf4?=
 =?us-ascii?Q?umXsWuBK7eKoL5Hg5C3g+fH9AnLq+gAaiaFhtumkaKvbU7MZmw+xaQwsm3Rh?=
 =?us-ascii?Q?HEfd9Ng9dSggWXW5nrHF5PV25NZzlvKr9Xs+viosiYUOCTVtWurI2U9FKtgN?=
 =?us-ascii?Q?6ffQEmmCzqLvULPrfaF/gj1fIlgi9md7wEv9oOXSDczo6NG/jdoapb6gxIst?=
 =?us-ascii?Q?5QxX87BiwPCVg0CW0mMOui0M2fHVIqORifDOs5mNDhZSxV+8jARAYrGvN6W3?=
 =?us-ascii?Q?nB28Pwrrv2U/ls+TthBKL8NumI6NsC/9gSO02qpg+BpHusyaZnyUbD36yZSM?=
 =?us-ascii?Q?QW/M6f8vB5os3ThLhyIOjWA9CCm/5oo8VzqMUK8QeV5LnxyJq0D7vv9EacRP?=
 =?us-ascii?Q?GhPcIye44q7LqB18CtKokUm4VumRYhr+Z5FMLiPji5TPOxfF9l2MQM1nDEOf?=
 =?us-ascii?Q?iXp70qCPTn3FsWCWxeD4yNuhmgSBGY7er4+HAGo3d5mxmQB8j4k7qmSVgLTt?=
 =?us-ascii?Q?RC9FjhuXDJWkmD7voQUY8OAwqRN019/k6nVn2yKmXSgzWBb1/rbNlzFoM3Lc?=
 =?us-ascii?Q?h8RC2jYoTOVify90jdt5TQqZ8TrpWBu1lOrtm8ChlB3vFJBZO5SHWtQ9m+wC?=
 =?us-ascii?Q?J+3J34Ee992Ep3Igl0VdNPeVQhlq9/HkxMZyGrccvRWwTG5HsAc7mSEPT/26?=
 =?us-ascii?Q?4oCsbjr5WAj19v7aoGj/6eXscbfYQs3BBPrKOSQligGDQtS5+aXGzBsaBofA?=
 =?us-ascii?Q?c34NE7l4SN//+Cs4ApOy+6RZfxa3FnEayjVfULqx/YXx7bulTBFOPO9MCcaL?=
 =?us-ascii?Q?fIB6ozoXaDWs7mXhZQIxDuCVXkLn5NhTz6X5t17Amc3386kaI2jyyU1H1AHS?=
 =?us-ascii?Q?D3PpHV6ITgR2qdVnJSz6S3s19mcQ7dp5PTAU+Tq7Vl9mslqrwT/Gczz99sef?=
 =?us-ascii?Q?DbQEgRRCFiWvN0GLDW4ThAfzmAIJwqymEqOao1YK/9uN8uBM8skKCSEjjVrD?=
 =?us-ascii?Q?qF4EM/y6lI2YhLY0iMPLHGicRg25vwNFTEObE/20fn/mbm5TSPpyFD8rOOnS?=
 =?us-ascii?Q?44ZpWaj3vCZtpHDWolgJUqce8cElbHyugk7hzRKQh3BTpaExpQBvutyZB8DW?=
 =?us-ascii?Q?D9BPr37w31u2EZ45mex9MyjNdSCKMMlxB6LfXP0h/TdCOcSJpr1Z0789j8w/?=
 =?us-ascii?Q?/zb+BPdM8R6a36hEzqcML8E0Wk5dSVLCEmEjv8TCCzaftXZfxccKe/vWiltJ?=
 =?us-ascii?Q?gUCNyhK+7eU78Fn6RgmtGYPtPepyogx9vbC9?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?v/gTwNKtPGZJlysMd5u6NLNW8EhLXN8K+liPygti386XDrpCZtWn1v89SW68?=
 =?us-ascii?Q?UCwGmmXXl42yRdCrIq2VjwBEDgX0h7S4mS73edByMZ7y+ZuenCbiELL/gxgS?=
 =?us-ascii?Q?KU3AraFiqPtRvGmzuzI/GlVHk0KCxhb1W3+6E7/oyPrdehjzSsZr36Isxghc?=
 =?us-ascii?Q?0MijvqhzodQRp1euMyYDokk2Rs+YwaU2WRcZ706WXkpNISYTdM34a5AVrXMN?=
 =?us-ascii?Q?Dn5IkRp8YhVyMVVIk/FgsJVqaOw9gjNj9GhUE4vd9B7JO4zPOHvwWVJ9FaW8?=
 =?us-ascii?Q?car6D0cRH3li3tEYYyMYnOglFhqhbQ8t3pYGFshbuFbY4pNcs/N5HYoB2ThZ?=
 =?us-ascii?Q?AsrHGOjmcy8mA24Xfi1mWYL46SgmkGKD3ialQ9p8fiZrzXh5T2AlLkTgoAfl?=
 =?us-ascii?Q?SqwUGYeAPc4pAZiU5pAIpkOzrDAAsNgiuBJ8i8AsCmdNg5WuZBCHTLNkBcdi?=
 =?us-ascii?Q?N7eKieEyNWwNN2tHd2iGZKPnBYPycjwvcoSeH4holkG0NVVh2ggJ+KmEejpV?=
 =?us-ascii?Q?7H/QPh+iTqQWlaIXhPAopUidtYwZqxDcj3/Eik6i35+iAopIenztbTbQdWLM?=
 =?us-ascii?Q?PharFXlvHgiFrojSG4o9Kgu6kwddS3Nhe3S199VX5N7jld8p5Qe0epG1Z8II?=
 =?us-ascii?Q?Aq32zwsM+x64TdGKmkwal96V/Pr3DBwGI31rAoeTNTqqXkk0lyZReeiXFKfL?=
 =?us-ascii?Q?xK5W6LnyoXgrIcktLPdPRKeYNJltBAxusecOYzUzcjisezEQSAl6Hgnm07AZ?=
 =?us-ascii?Q?KYMIfcwI7sj/SQmcnrWwQU0kDVt8DdJrJ88yKM0tEWmKruAi+ITrDoomh8xb?=
 =?us-ascii?Q?0qvTfPYL3NVq+iHM5FkXsfwlB+VpCfdGmoAG+5R5Gg3eR7vGpKhIe18YDcvi?=
 =?us-ascii?Q?3v0MXHp7RxZde0TNwnWVfRZMt6GRWcPuKYMjNI6P7FIdFz82FX0R9BCc+RMh?=
 =?us-ascii?Q?8y2rs5y+6oPYM/YHdQ8f8uH70QM8JRYh2w09zygC2915EWckagLbxES4upKb?=
 =?us-ascii?Q?naS5aEZa2EEddHcq51enWyI5M7tatdKWGK45BnFnA/uGWaonw2W4kC7F2GvB?=
 =?us-ascii?Q?reJz7WX2hsfZ90/oCqSkOxwUyPxmc2rntqHIdYzrbHsHV1CqqyV8Wp2wz7U7?=
 =?us-ascii?Q?wySnfDqrowwdJTQ2jvW+Au1dSADwQmwq+FpxU6AknwlRAmH4LC2td3HEwwXL?=
 =?us-ascii?Q?4kT6Afe9UBHLzbRd4iikUzMSC1XScA4OiPjc6O4Qh5zUbxPnwOw1hL8BXHr+?=
 =?us-ascii?Q?V76y+3rWsYD31zQedvXY9OmBkDXuOjxIJd7XMb0/mjKwA5aJsnx0k+9DPb4H?=
 =?us-ascii?Q?amvNC5FkpufqQ+g+GlT2410/5OWCLDy1UlegzODo4LNMEbydvwf0bAUgfnd1?=
 =?us-ascii?Q?E+92+1g1Hr4X4F3iH73SsYrghDPINZvNRKaNbibIFMt4CurXQFCkuKV+5bDr?=
 =?us-ascii?Q?A0nWy0jrcMFaJJE9c1OgqXGAS/qiBz1S8AIE8c4X089uTCX5sKcpne2lb3gG?=
 =?us-ascii?Q?pCzks2eC2jIoRuBudRweS+wexnbvDfTzwnWLoD7JgIH/r+W8PvufZLbTihcu?=
 =?us-ascii?Q?D7ydvEwSSYuioBMFeRq5zQQ6YdZpJp6nNJ9xtPE9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c303edb1-6576-489e-97aa-08de1b053ab8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 18:17:20.7115 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RwzfivVunBtvB7PVaElOcX9K2uD0K4ExZ5miFA1XkwmIxbIIJQrN7bQHnMNZzM6yHdoDX+S1Xh4tflZDCS9e6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6210
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
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
> Sent: 03 November 2025 17:44
> To: Shameer Kolothum <skolothumtho@nvidia.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; Jason Gunthorpe
> <jgg@nvidia.com>; ddutile@redhat.com; berrange@redhat.com; Nathan
> Chen <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>;
> smostafa@google.com; wangzhou1@hisilicon.com;
> jiangkunkun@huawei.com; jonathan.cameron@huawei.com;
> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; yi.l.liu@intel.com;
> Krishnakant Jaju <kjaju@nvidia.com>
> Subject: Re: [PATCH v5 17/32] hw/arm/smmuv3-accel: Add support to issue
> invalidation cmd to host
>=20
> >
> > Though that is true, it is following the same pattern as
> > smmuv3_accel_install_nested_ste()/_range()  functions.
>=20
> We could drop the one in smmuv3_accel_install_nested_ste() too.
>=20
> > The general
> > idea is, we will pass the errp to accel functions and report or
> > propagate from here.
>=20
> But there is no "errp" in smmuv3_cmdq_consume() to propagate the these
> local_errs further? It ends at the error_report_err().
>=20
> If we only get local_err and print them, why not just print them inside t=
he
> _accel functions?

Right, we don't propagate error now. But in future it might come
handy. I would personally keep the error propagation facility if possible.
Also, this was added as per Eric's comment on RFC v3.

https://lore.kernel.org/qemu-devel/41ceadf1-07de-4c8a-8935-d709ac7cf6bc@red=
hat.com/

Thanks,
Shameer

