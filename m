Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D8DCAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 07:40:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzVhy-0004GW-2v; Fri, 19 Sep 2025 03:39:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1uzVht-0004F4-Qg; Fri, 19 Sep 2025 03:39:01 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1uzVhm-0000Tu-Fx; Fri, 19 Sep 2025 03:39:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f+PbFMAGok2wtr4AkeHSt+k6sPWRXEGqhprYtR67tpAHUGZeHdIgqCxx+IOvlJIJ1f7/5Yib4GaUua8t5H07Fl/f9RQsLljHfOC4lTTzDCNFmHGNgFjvpFySwgTg1F3LVnxCx754Hlmi/Qcc7n0kj97ek0F+EFgAvsvcLC3HDO1QatYK2sP4lvFnFtMvXV+XW0V9Ow23l3FnyFtduZr+tyrQetVBBMnkECbVUTU8EduOQzDNajivock+NhP9mmfYX4Bcyas/iv8pQlhEUpEgteEn2Tid9Ao5d+Lpv6gp8K1Vhmz10F28mpLpO7B9mu2Qyy/fVEUjwqHcBj+os4tZYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WxArBN3w6TtMcpX8KROWmn8So1WVLGNAn/5JRBI92eA=;
 b=latEyhL+w7x2J3+AlSVW8fHwU1UzuI5GcnfxP4Xm7ZexqUOVQ2y7tscncWhGjeXx73dxqQhy1vSIescbMGD9RQRa2q6AFx+RxJrDXN+DcI8YjUqQUoKp9G31RQtI+j9dNvA693i50vx7JNk8LtNUFmFC7eITxeRt9qTJqCaIw9almSzGmXsXHvVqv+clOTduhD1ncGKogs1sIUVL2JiN4fBAsWerJAJe09mf8sfbaqGsACo9NJo9l7/qLwIJMT80HqgT2qEH2mfUFp2V5IdUrUC0oJ6MWquJusF/6KshQda5eKtweYiw5BM+IQOhx5AJ1e0kUn/V20xe9zaGTW7v1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxArBN3w6TtMcpX8KROWmn8So1WVLGNAn/5JRBI92eA=;
 b=ZkIBMKvmklVtbj0dzPSp1n+r0i5fOjc97OOHxWPbMphdn/QSb2Lr5cxudw543JSoSPaimUKvYEUKBXiye4mUwYkfXrz4t57TZnr4T6X/3FS9mOvGnBm7/2u2q8sIagiNDbXQFqVgJI0ozNLv7/eXevffYE4yXcnN5+JjfwGt6WJuWwKEuQDyy1nyGhM18SA03nQALhHBHXaVu/Wnrr9fMhz7U647+/aO4poB3MUs3M+laopKidDLRCjuD3QWcnUwv8c3Rj/DxJcaPQGGzGHm8+rTB8Rv2bO6lOaQ+Go1keChB5+7Bj0kzmCfZJHreX7qTjdIjsadB2p3ODiSwRCf4g==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by BY5PR12MB4098.namprd12.prod.outlook.com (2603:10b6:a03:205::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Fri, 19 Sep
 2025 07:38:45 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 07:38:45 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: Shameer Kolothum <shameerkolothum@gmail.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Jason Gunthorpe <jgg@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, "smostafa@google.com" <smostafa@google.com>,
 "linuxarm@huawei.com" <linuxarm@huawei.com>, "wangzhou1@hisilicon.com"
 <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, 
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>
Subject: RE: [RFC PATCH v3 06/15] hw/arm/smmuv3-accel: Restrict accelerated
 SMMUv3 to vfio-pci endpoints with iommufd
Thread-Topic: [RFC PATCH v3 06/15] hw/arm/smmuv3-accel: Restrict accelerated
 SMMUv3 to vfio-pci endpoints with iommufd
Thread-Index: AQHcJvVSyZvN/mVpTUewNZT1jGrd9rSXuIGAgAABxLCAATN4wIAAk4AAgACX+rA=
Date: Fri, 19 Sep 2025 07:38:45 +0000
Message-ID: <CH3PR12MB7548BB774BB375D5056C062CAB11A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-7-shameerali.kolothum.thodi@huawei.com>
 <aJKn650gOGQh2whD@Asurada-Nvidia>
 <CAHy=t28z=wrXbXOJjD4sFw0RxJR3fccqF-EdaQDB_s_F6RC4FQ@mail.gmail.com>
 <aMsBvSSEzsgeMHkK@Asurada-Nvidia>
 <CH3PR12MB7548347E93651468E70B2470AB17A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <CH3PR12MB7548B6A98B640192579078EBAB16A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <aMyA4AHf7pqnOzSV@Asurada-Nvidia>
In-Reply-To: <aMyA4AHf7pqnOzSV@Asurada-Nvidia>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|BY5PR12MB4098:EE_
x-ms-office365-filtering-correlation-id: 700ebae4-9be0-4664-da1b-08ddf74f9042
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?7lBn4nrn8OJ7J0KqeW2foy6nBm0OmIvfcuKJMYbgp62TimMsC9MF0DLkdnUe?=
 =?us-ascii?Q?iORiih977ynOKlCaVVcNQpKejhbcnjMu4UDTLh/haQHmaZBF0kdM4q44hk2m?=
 =?us-ascii?Q?LAjpYSEGCn++9THKL461FF1W7WbOZbAtv8X9b3VCm+XACV0MCYgm1VJqPWC1?=
 =?us-ascii?Q?qiuyUajp+y4yNHlLh0IUWnQib+x7x8gwPiI+zfAv0pDctWYbZjBkTNGOGN7y?=
 =?us-ascii?Q?G3Mw6fWES5qE0mu+fXFUnIzdT2EuDd0sUyYVKPplt2swZmILmNKyxOn2uvMf?=
 =?us-ascii?Q?6JEW73G1qjTjkRb9aryMBf2eVL/xn96j8qMcCkTcAy7f1SgCyUb1+sPzvGsf?=
 =?us-ascii?Q?v7LC6YUOYV7+TluodmceIWoHB/BGJiT7lwbc9hsv8H6kbld3JZD9D13jnf17?=
 =?us-ascii?Q?3DKpq6+vdcpmqogrx7mm/ST6SWzRfK6cBieWFW5EDCrohjrjgGHNfBac91Mb?=
 =?us-ascii?Q?iUpEY2+N1rrDSzLdfK7CNs9opOvDtAK12MwFuogYemfJR3wHCnBmWogwk9JU?=
 =?us-ascii?Q?lznbW6AbxH7PsGFGPorQvNdznIusIrzBbh9FOY9Lv4oGl6Qd5zqo382Ccc81?=
 =?us-ascii?Q?i1uw20tqGbvgqptbuNzU/BJfvlENVQhBBdY9EKIUBb4rFY/axZYkXNAwCIDZ?=
 =?us-ascii?Q?41rIdcCD7cm+ySe9ln47qq/J6xz7U5B3fWC38nTb9rtAu+EwtR5VvbNFJUgg?=
 =?us-ascii?Q?IziY1nv/LwQv9NkH92+QqHIXqAjmDJy5gipnsoEhheHgpYTTt+I8RWEMWw8L?=
 =?us-ascii?Q?K5LSOo0ZEhZAZp/kfz+rMUMRf8ZxWqonuynK8hHX/JN0+7gv9RULFLW92JLl?=
 =?us-ascii?Q?/8eNJ6ZCwmlu7TKiWTnBz3VVfEyOIxGi9HRR4YOSdQCJIs3VKunaywiFzIIC?=
 =?us-ascii?Q?jnIk0G96gbwXz46Icc2wjg+QPYxS9dnxQ/1nNl4SHwJO+2KmOfgNutWhKAyB?=
 =?us-ascii?Q?xdAAIEnf7FADfGE5yYooWkVxBwmiXfJS1T55QpP45Q6EdZ4aQueRYlbK8+Cw?=
 =?us-ascii?Q?AZ8crkbO3KruOmcblqiontTalshG2k8Pv0Dq4MTIYgaDtv6HzHOy2YiFkXDD?=
 =?us-ascii?Q?eRpzA9TJqwIDKB8hKKuw7YtsBTFajZ7G8sidTki4pwPduQJ0g+MbQXNmRD1G?=
 =?us-ascii?Q?CKz3/9+J2RbS6mkIyuePxCi0OGORrbErlF+EuiCgaL3n1gN+qSWCppkpXf7X?=
 =?us-ascii?Q?TlQjD+m4e1EvXwEZfqFgaSX5Bfkr8I5VCmsqbVd6B3IxwrPaV6CKqm4vF9Rs?=
 =?us-ascii?Q?8zPMB9HDjA10UpXeZ+FQ/xt8+lfFxDL48LqL7SOpZPtL7nVZ0OOFVKQsP5Sw?=
 =?us-ascii?Q?mlIWi3EMFmQ6mW83cO3zqRXf788PX7b4Ahkk+GbHdta1wOQfFCkBXIxe5rzl?=
 =?us-ascii?Q?BqimoZRJ47N9QCLfbnqmKnqERpPmaRovakPPt4693l3rxriGMjg28cz5+zZX?=
 =?us-ascii?Q?3rvCev1ZPw9tWDVD2pq3EnvhnwQ7AxYq4/SKBZLYhCZ+j3rm4Q+1jA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PytZ64RxWg++uCy4CK5fqafKj3W3d7i/8iIAMwT2pNsbUD5GkbZQrNIz1Kzd?=
 =?us-ascii?Q?aNkZsitoXgJCZGoinK9pE8cOaE6k2Bxn6VWRAF5HokAfOFhPbai6gl8sry9u?=
 =?us-ascii?Q?sEhTjDvUfPtYEJ4cPCLWuyG5ATrr3W1nwc+ovkHOwh7Y1ufLOdc18nvr/sAb?=
 =?us-ascii?Q?0HP7Yx0gwwnxmkjp6DOjqpVd3oWMVh8cDKIadMw+hcWfdZO9LCsK2CLUMApi?=
 =?us-ascii?Q?kSYGJVWKyXWHKDEK37wj/lJR6nb5t5Wa67bxwoT7HbaKe6fEzQEitA4V49cg?=
 =?us-ascii?Q?RBDc0q6S4B9VglEeo03WZOTrKaI8HGqNfdYrvmwsVq38r8MxODU5911WkInp?=
 =?us-ascii?Q?4E/Axs3NXty2n7NepHprNfYLFBDhwQMw9vuZ7KNSl5cWVtkYWz9oAgyMPsD9?=
 =?us-ascii?Q?LISXt9hK5uyI4IuSFZ5HAP89C1l0NxG+NyS/RlqswWpNvP4UvffmAIWr8i4r?=
 =?us-ascii?Q?sQFLQ8oZDiLf1dz6O38h+pYYaBUPLjhQYM12wrSumygYOzIjwrb4vz76VCSO?=
 =?us-ascii?Q?0tlVPlfKJUXOYgWvUrA2jOhDDEU8i2neo/R/YD5rgHT89VlZLADXNcgLxiaL?=
 =?us-ascii?Q?rCOEQrc91WmrSDA9FXYt1L/ARQCwVrepr/FI6iWx7exyCoB4oBB2OyEJyyB9?=
 =?us-ascii?Q?gffsfFj0e9115lXLCYhxO8uZkQjdLiahMgsfnzeaUQUZArtabNVB/IelyGLc?=
 =?us-ascii?Q?WpvJ7u3PJffb30pfUO9z4LAfrZvDy9ltuMQEYcuUdh18Y/akRPnWR72vRm73?=
 =?us-ascii?Q?gaOo2hmBR49/CaZRpp7Fr1UvAzxybkMomw52GnI+EEmD+S9DT/SpIHPjQtL6?=
 =?us-ascii?Q?jbkXjZSgIJ+QvkBcahSQlivWMrUr6TKAeUyCt1YiCnnxAlP4GNh7bjx14qE/?=
 =?us-ascii?Q?AkyOkmXqF7FyyeEb6Mhvj35lvUtRYE4z98QSSQ16iwbIlE25luY+ZJCBBSEb?=
 =?us-ascii?Q?bnLsRPaJMYHLqKF9c0zZ8pdz51aOHOtnOEitXrbT5HG40Z1V8BjWQvHKrz7A?=
 =?us-ascii?Q?xdsVtuYvoRic55UWWBzlWdG52zjOARqZY9TfqdtTZAHv/FVruDnBsup7Cnd9?=
 =?us-ascii?Q?4bsFlhc4nvDv78kuYFGGfzt8goZJAW5PI/xwlK1MKHvcOCqf2GNDaaedp/Va?=
 =?us-ascii?Q?v29IYEK0fa/ME9d0RfCyPuLY41c4TxM0hCccVkSAclyVUdRL03SC3I/sBKu7?=
 =?us-ascii?Q?Yd5f0CgXpXiLONuiJj1Oa3pJecxGsG7wu2zkq9p7pm+lsaTzs+ci3gSH0x/m?=
 =?us-ascii?Q?7/tU65aXOFkGXlQAC1xHarwawDpp+a/bY1wEyrBp/P4QstHENNzJ4WB4IHnK?=
 =?us-ascii?Q?AoGdPiFICqxtoK/19fi1UKHn7hH3Y0k4nbTEzyyGTKqwoqcAYzqC+D82dATE?=
 =?us-ascii?Q?znBTFPus4l8vl3BcqipePOZPYgcwxYHv9E385g4WvfZuYTr5Rn93XppYCJZf?=
 =?us-ascii?Q?SYlY7XOJfmXy6wssZ8pFyo2jIoOQ3GK5ele1aMX9Ll23Yb9EcttD+BWdL6MK?=
 =?us-ascii?Q?Rr3wzUY1bN/oQnWU3DkCPP6rbHIV+DEiJtPFoNjoVefkO0cFf88AFyL9KaGr?=
 =?us-ascii?Q?vspi/Nl7YVyognm7L2KO345ThnXFd/bee+9xxhnV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 700ebae4-9be0-4664-da1b-08ddf74f9042
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2025 07:38:45.0990 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pOwEZKmGpNES/5Ya6eBisuRCedrGQO64G0k/ZEAUEEWWVdNCldXNbaZSipkLppVNhZyLZZLVyMfscwIFjB3h5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4098
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_NONE=0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
> Sent: 18 September 2025 23:00
> To: Shameer Kolothum <skolothumtho@nvidia.com>
> Cc: Shameer Kolothum <shameerkolothum@gmail.com>; qemu-
> arm@nongnu.org; qemu-devel@nongnu.org; eric.auger@redhat.com;
> peter.maydell@linaro.org; Jason Gunthorpe <jgg@nvidia.com>;
> ddutile@redhat.com; berrange@redhat.com; Nathan Chen
> <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>;
> smostafa@google.com; linuxarm@huawei.com; wangzhou1@hisilicon.com;
> jiangkunkun@huawei.com; jonathan.cameron@huawei.com;
> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com
> Subject: Re: [RFC PATCH v3 06/15] hw/arm/smmuv3-accel: Restrict
> accelerated SMMUv3 to vfio-pci endpoints with iommufd
>=20
> On Thu, Sep 18, 2025 at 06:31:43AM -0700, Shameer Kolothum wrote:
> > > > > @@ -37,7 +37,6 @@ typedef struct SMMUS1Hwpt {
> > > > >
> > > > >  typedef struct SMMUv3AccelDevice {
> > > > >      SMMUDevice  sdev;
> > > > > -    AddressSpace as_sysmem;
> > > > >      HostIOMMUDeviceIOMMUFD *idev;
> > > > >      SMMUS1Hwpt  *s1_hwpt;
> > > > >      SMMUViommu *viommu;
> > > > > @@ -48,6 +47,7 @@ typedef struct SMMUv3AccelDevice {  typedef
> struct
> > > > > SMMUv3AccelState {
> > > > >      MemoryRegion root;
> > > > >      MemoryRegion sysmem;
> > > > > +    AddressSpace as_sysmem;
> > > > >      SMMUViommu *viommu;
> > > > >      struct iommu_hw_info_arm_smmuv3 info;  } SMMUv3AccelState;
> > > >
> > > > That's changing from an ioas_id per VFIO device to an ioas_id per
> > > > vSMMU instance, right? I think it's still not enough.
> > > >
> > > > All vSMMU instances could share the same ioas_id. That is why I put=
 in
> > > > the SMMUBaseClass as it's shared structure across vSMMUs.
> > >
> > > Ah..you mean it is basically per VM then. Got it.
> >
> > Regarding using SMMUBaseClass for this, it looks like ObjectClass norma=
lly
> holds
> > function pointers. Eric has made a similar observation elsewhere in thi=
s
> series.
> >
> >  @Eric, any suggestions?
> >
> > Is use of &address_space_memory directly in smmuv3_accel_find_add_as()
> a complete
> > no-go, given we are talking about having the system address space for a=
ll the
> SMMUv3
> > accelerated devices here?
>=20
> smmuv3_accel_find_add_as() is per instance. So, it wouldn't share.

My suggestion was...

static AddressSpace *smmuv3_accel_find_add_as(..)
{
...
    if (vfio_pci) {
        return &address_space_memory;
    } else {
        return &sdev->as;
    }
}

ie, use the global to system memory address space instead of creating an
alias to the system memory and a different address space. This will provide
the same pointer to VFIO/iommufd and  it can then reuse the ioas_id.
I can see that QEMU uses "&address_space_memory" directly in many places
(pci_device_iommu_address_space(), etc). I think the idea behind a separate=
=20
address space is to have private ownership and lifetime management probably=
.
Not sure there are any other concerns here. Please let me know if there are
any.

> Even smmuv3_accel_init() wouldn't work.
>=20
> If SMMUBaseClass isn't a good place, (I haven't tested but..) can
> we do address_space_init() in the VMS? I see virt.c calling the
> memory_region_init(), so perhaps we could init the as_sysmem there
> and pass it in to each vSMMU instance.

That will still require you to store the address space pointer somewhere an=
d=20
each time a SMMUv3 accel instance is created set a property to the instance
via the hotplug handler. Doable but still...

Thanks,
Shameer

