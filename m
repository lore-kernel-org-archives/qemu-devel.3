Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7117CCAC5A0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 13:33:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzEkQ-00065L-Qp; Thu, 18 Sep 2025 09:32:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1uzEjr-00062r-QO; Thu, 18 Sep 2025 09:31:56 -0400
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1uzEjo-0002c0-Si; Thu, 18 Sep 2025 09:31:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JLj31QrZN5b3MeoJKGSVdD2EtWh7HmncKS9kU8mmvQDIaJChdJhSZ680TRh4Z3GDEeuAOXVcJAQzO1Yf7FTd0sRFqIYfL4zEmpktM5tOXG/JDqCwGGWw7c68yMKjgWj15hsOKCYoRqgALrWPoQvIcGOJ3WIjuWbwI4djrEt1U8F9RI0YEcF86HqjSy6PzG6XiR3M2W5/cmCO+CS/QZRAzPygcw1vQM0CkMuhCTfDm7wlzSSAuR60ZKMbUzjSoKlSSlEAjoJJN1oHQUY4AfRw9nKh6mWg3poXWMUpii5UxdMibDacjFGqWQ/N8aBXHy5u2Gb0j+pHwIdUW2Dmd9XE3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YO7GlLzYLspLQbSpFNjXgYvrvup2VbZsSQsTjpgqnrM=;
 b=XyBSESOv0Urds9eKJMqBbKj8UNZhkR9qCfoHoNdLdFDxlqqngrblVlGU/knBAARhYbR8JuZFQIwHJcGFB+B+vivG+xSpZnguZseNJLizaglRiqqqRAa1puUw8ns0op32Nm2/JWGTKwd33lR8/Hma0K65gHaYNjN4iOgiXfpFttbxqYgCK4sgxSGORob6Bk9knyQekgw3opw0qLJeasgyXnu4xzvoQeDh64ONL949sItFbvAdZaCl/UWPqxtFS+cCewIQ6v9qxdj0E4NyZz6YbFMnPLPBATWdpI0koqzUtKRQou/MdTui6eG3bpZTyq1R3d0AQLXkKX9Qr9EW9w+QBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YO7GlLzYLspLQbSpFNjXgYvrvup2VbZsSQsTjpgqnrM=;
 b=hsLplm5tPc0BGGwOXr96NXriG0xQ5RKoowU1os+Y3MqLlxzRJbQxx7RjealzzHad0lC9/YoE7hzZaUOW4PIIdzLoZKW8XjB90ID5GfpvF3vaG2c82OYkRmZvgz8nR6h5SDUtfZyThEMIX/eW+UFC0fK4/Lec9C67okW97WUTykdfTToj9xvFh+4ZXkqgylhvrmxK23BK0KIwcSXPuUUKNmCNzyANxgZYjEbM7yDBCmShm/6lfejkqFy2MvAtsAkIq3XyRTToKgMCbqoNV1gPSba4GdnrGH5yE6Wt5Ihu5RRf08oR3emlD9Emn/o0N2QYBT20GiDwbKDbAgPwzWt2LA==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by PH0PR12MB5629.namprd12.prod.outlook.com (2603:10b6:510:141::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Thu, 18 Sep
 2025 13:31:43 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 13:31:43 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>, Shameer Kolothum
 <shameerkolothum@gmail.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, "linuxarm@huawei.com" <linuxarm@huawei.com>,
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com"
 <jiangkunkun@huawei.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>
Subject: RE: [RFC PATCH v3 06/15] hw/arm/smmuv3-accel: Restrict accelerated
 SMMUv3 to vfio-pci endpoints with iommufd
Thread-Topic: [RFC PATCH v3 06/15] hw/arm/smmuv3-accel: Restrict accelerated
 SMMUv3 to vfio-pci endpoints with iommufd
Thread-Index: AQHcJvVSyZvN/mVpTUewNZT1jGrd9rSXuIGAgAABxLCAATN4wA==
Date: Thu, 18 Sep 2025 13:31:43 +0000
Message-ID: <CH3PR12MB7548B6A98B640192579078EBAB16A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-7-shameerali.kolothum.thodi@huawei.com>
 <aJKn650gOGQh2whD@Asurada-Nvidia>
 <CAHy=t28z=wrXbXOJjD4sFw0RxJR3fccqF-EdaQDB_s_F6RC4FQ@mail.gmail.com>
 <aMsBvSSEzsgeMHkK@Asurada-Nvidia>
 <CH3PR12MB7548347E93651468E70B2470AB17A@CH3PR12MB7548.namprd12.prod.outlook.com>
In-Reply-To: <CH3PR12MB7548347E93651468E70B2470AB17A@CH3PR12MB7548.namprd12.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|PH0PR12MB5629:EE_
x-ms-office365-filtering-correlation-id: b7abf23b-a2fd-472b-165d-08ddf6b7b537
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?nHmbN8nCObuRTts5JkJVJItpn+UdO2WZ+pwF/NNGjkHNLHQs+t9cmwQjC9SG?=
 =?us-ascii?Q?7/fFYeM3jUKGIJOq9pL6vB5RHHNhFyvs+FuwM5014sgpuABwh4gUe+QevfrG?=
 =?us-ascii?Q?NRbyqJGjKhoRuvvfjQnVl/QOBtjWDS4hPja6m60+gxUEdRpdqjE7V4CUVBqo?=
 =?us-ascii?Q?oE+piEkIkCo7sMNM1190W/hx6LdldCAvMdBlscw/JWAVDijzGqI6P3vyEQkn?=
 =?us-ascii?Q?5lQWguNovkHO5Le60ql7dVpKmIj4Vv4dEqHntyju/pHziuvedH3uqIRq/cde?=
 =?us-ascii?Q?hnbainVcNLO50ZKOc7iu/BviCnIneIIu6eaDAgS+z38nACu9gwEThRW5wDBy?=
 =?us-ascii?Q?TRL6JqfffZ6TMdVjF3pIgWuHltjbhTtXerDEj0Xkk/XVz5bvyZUcknpah9De?=
 =?us-ascii?Q?/YjBADZXcPVQugTVHhm8O1iV2hJO07IZiEUIzLhk0YX52feNHChVq72hA6XS?=
 =?us-ascii?Q?g+kX7VeKj9Hm2J6WSW2dkP/YbY5HcDt24NmGuuzSsmqvcO3ZjuZ05m87+Xhz?=
 =?us-ascii?Q?y0q9q3Flp7OGB91ofUOJnIVmLbKLrcZQvz6tgi33KcwAm0OO7u3pJmeaXMKj?=
 =?us-ascii?Q?LcJSLMSwvFFGVaQZvrGKZSirsQin7qBS1Uez7NI2RJ+JmlfiXnUfSniZpxmU?=
 =?us-ascii?Q?Sn6uDzEJ7/Za3yre6tJ2hJti1ctHeBkDzNHb3rcTR7vJVXQPpeDJEmsE44nc?=
 =?us-ascii?Q?lvt6jaYZ0hu212tyCl8vD7E50X9lG04orzHoL9X30OHJ8AXHajGHVNKWi0fX?=
 =?us-ascii?Q?bueRE7wFArpvxfP3S5LeJ4v2mFebvnumSGGuaJEKk2jO0kfBH6uNc4obAsCk?=
 =?us-ascii?Q?KJ9v4ZK8LxPqZEQt96UOETNxyUxF23TeU591NDXtskZ8nAlF1ZGZM78kjF9T?=
 =?us-ascii?Q?R1E4yteZufJA4QlxbTV5Y9Sa/xorc5R2AGvNgK5LGD5Fki2O5et7G5W1eRml?=
 =?us-ascii?Q?KyxEWznwNc7i7N8k2nrSDMUkXJ+2jeW6C2UzkpNdYWwZPdSuQKRBD0F3Vji+?=
 =?us-ascii?Q?z0ohsihtXcOv61rpojK7V1AHj8fQ37GvJgRkAiCs0fe5ok2+YqTwVTRBzTJf?=
 =?us-ascii?Q?ZdPVV6UPKs5NGHWXdcSS6o06+2UjYIYHtb8+dsSz7iErCt25Wjib2niiEInZ?=
 =?us-ascii?Q?jKktxpzTYElWjne3hRpC21gfV2hsFBb5DMaj2YAPAH2Ll34mv92nlRJ52H5u?=
 =?us-ascii?Q?QhuHi9pj4OwT+Mt+zrOfWvQcO4yS9qM7MLRCJ75cCcVA1WUoPncmuGT5Hz8f?=
 =?us-ascii?Q?iToeP3V54nK/UdXD0YP0c4sx5cqmKrmBzsVmC+KX9P0jECypy1oftyWqSGFV?=
 =?us-ascii?Q?bz6whqzFKiarwXEQ6Qa3TFoVR0l9iSm+3+UWujtmgZkjqKeu2scpUMDLY4v5?=
 =?us-ascii?Q?IR6qmiGGtZ/4RRMAUi2tfLPiGsD0RunT4zbn4/mhrdV4Xfryr2SIrMj9zSnT?=
 =?us-ascii?Q?eVDvNZRREopE4jpkGKLWcqvYveP9UGuSXQT01gv5CvVvfpz5UMhYfA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xyVu9wqut7D1CbsbbzZaCyItcB9nQENkCJhFJVerC0vWX7s8FKOC1a0V5lnj?=
 =?us-ascii?Q?fn6cYJyMA4AoX09ki5ttkgeHwRZCoN2EboUNLFhpwgPo/gABJPsMDHpCdgWW?=
 =?us-ascii?Q?yJUt4Zs3nK+FS8IfCKzRfqbxrLLJ6rcAGK/d7sDkUOHR9dfgVhEPZZhXWv0w?=
 =?us-ascii?Q?6aQrTQntwesZT/psN7NC/4e+pqj4Ss7lQOgBn0jSLjqrKU63D2VfZppziMGp?=
 =?us-ascii?Q?FstkPhhti7YV77qrFaSWGEYcFkRFgsatkaGzSJRMS8FvkqJxlTCqrEGNFXz0?=
 =?us-ascii?Q?z65Fds4nqm3HAWKUy6DNKaag1i641rXCR4l7cQX0r4Ehb9+Jvb0ePu6DEkr/?=
 =?us-ascii?Q?VRjpavzTqyrbRo6kixW/P4ULwUIaHSWBcRdb0Go23LDt5wjS7qxNYP3OeFsS?=
 =?us-ascii?Q?uCxO7xSXE4rOjMlKMsWoW4HtSdWm305vwjaWq9s1/dtQSkaeMnd/orYoQCJi?=
 =?us-ascii?Q?uWeA9jWWIKZ/RtiXsJy+wypujy8aEa7tf/u46jg7noeAi2Bx5jOIa1dtEV2G?=
 =?us-ascii?Q?fCT5y+ZAN8Do3fEHm/oeKOvzQbCE0XWIwRGIN5lpwJXJVYSRjOiDGaT2L5NM?=
 =?us-ascii?Q?keds2MUbbEBWHnjwQg6qWV7yAXRXgLMG84pruJzoUNAZnioFP9xEjvlVdTDT?=
 =?us-ascii?Q?5STou6BJEp3RerZKLL5w+0I8sawRjTX9kKdLV3b0nHxYhCft0iPdanxRaAVL?=
 =?us-ascii?Q?yQ8udgtGG88pWEVgYCFieHCBds1XFs+RkHiiTUHkc7UgLXAYkbgOD3z3QZGy?=
 =?us-ascii?Q?6dG/xRCZt1aQPbd9L7NnnjZuZeiVxhzoP1AEg1XEOJv+25tQ8hGprz782ArE?=
 =?us-ascii?Q?Oym2NB7qY02M9gkGDiGVUpBr0Wc9K05FDQO2QKVt6MGEMjjIZiOaAqYCm05M?=
 =?us-ascii?Q?foUy5FeWz0WWtLgcbLbUk+0ZbtoM0mdmSoPcO4hEePy8FXdLNmT/eDtiglPL?=
 =?us-ascii?Q?NXV06YaT6neKSa6qDXEPZl/LHuf6P9qS3IQ7tTK/JtGvSPD0pFik+J+UimlC?=
 =?us-ascii?Q?gXIjiddLDe2lGa4QRQPJDzz4F/tnxf3KZ737OKY6Obcsh61VgYJbDaxg9xBC?=
 =?us-ascii?Q?DLBPaiBPq4mLM4xaWJhGre5ZscMxM4ELk+iB/0V90dfaQLDu7lo73r+/hy9W?=
 =?us-ascii?Q?iSKvF8cACrhd+5IpuB3xiakzRUt+bE1KPzbbk00aFXl/TicFZADt2aZob9kE?=
 =?us-ascii?Q?e5v6Eev/BZMCNibbg9DYNk/NZv8aM45jdKKh3MSgtrchFxLGHZnHIplnqP+K?=
 =?us-ascii?Q?oJlXVD2OjF/JkIbIIgUt1aI8FmWCGxUC5CNVxdR/95/veiXJAPy3hYNUHnX/?=
 =?us-ascii?Q?SCPirK82LBRMqIluIy9rSrvUNDeQPiFgEnu2SJhk6JFLjVFkJ9tjoNSwPRaf?=
 =?us-ascii?Q?ATU1eHl1akPWzPL7ksJ0MZ49uX4yRWMMc9KeIkt9kW8C7pG4C5yZI49BWWv2?=
 =?us-ascii?Q?u22es6l54YzdnTuZHtBgFHtrwGWo68Q5jGyBtkdbPca0DBR8jM8LrHTIKand?=
 =?us-ascii?Q?b8WNr2lanJvlHnjUSPf+GKUdUlzkA/md+paz1PTGhufOXfykPsEDxCpcx2oH?=
 =?us-ascii?Q?BIZwI4LAsbJxk8wZ1i9yAGNxOb+e14W653AtlmIF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7abf23b-a2fd-472b-165d-08ddf6b7b537
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2025 13:31:43.6026 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ip0k6cB3ErVcB4ZToWK8bR0bIoBwBAiTEDh+8DJvajlEuAnHpr+b1J+iDijW8HTY+oBadkbLAi0r7GWtAchVcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5629
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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
> From: Shameer Kolothum
> Sent: 17 September 2025 19:53
> To: Nicolin Chen <nicolinc@nvidia.com>; Shameer Kolothum
> <shameerkolothum@gmail.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; Jason Gunthorpe
> <jgg@nvidia.com>; ddutile@redhat.com; berrange@redhat.com; Nathan
> Chen <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>;
> smostafa@google.com; linuxarm@huawei.com; wangzhou1@hisilicon.com;
> jiangkunkun@huawei.com; jonathan.cameron@huawei.com;
> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com
> Subject: RE: [RFC PATCH v3 06/15] hw/arm/smmuv3-accel: Restrict
> accelerated SMMUv3 to vfio-pci endpoints with iommufd
>=20
>=20
>=20
> > -----Original Message-----
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: 17 September 2025 19:45
> > To: Shameer Kolothum <shameerkolothum@gmail.com>
> > Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com;
> > peter.maydell@linaro.org; Jason Gunthorpe <jgg@nvidia.com>;
> > ddutile@redhat.com; berrange@redhat.com; Nathan Chen
> > <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>;
> > smostafa@google.com; linuxarm@huawei.com; wangzhou1@hisilicon.com;
> > jiangkunkun@huawei.com; jonathan.cameron@huawei.com;
> > zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; Shameer Kolothum
> > <skolothumtho@nvidia.com>
> > Subject: Re: [RFC PATCH v3 06/15] hw/arm/smmuv3-accel: Restrict
> > accelerated
> > SMMUv3 to vfio-pci endpoints with iommufd
> >
> > On Tue, Sep 16, 2025 at 11:33:21AM +0100, Shameer Kolothum wrote:
> > > > I found a new problem here that we initialize new as_sysmem per
> > > > VFIO device. So, sdevs would return own individual AS pointers
> > > > here at this get_address_space function, although they point to
> > > > the same system address space.
> > > >
> > > > Since address space pointers are returned differently for VFIO
> > > > devices, this fails to reuse ioas_id in iommufd_cdev_attach(), and
> > > > ends up with allocating a new ioas for each device.
> > > >
> > > > I think we can try the following change to make sure all accel
> > > > linked VFIO devices would share the same ioas_id, though I am not
> > > > sure if SMMUBaseClass is the right place to go. Please take a
> > > > look.
> > >
> > > Ok. I think it is better to move that to SMMUv3AccelState and call
> > > address_space_init() in smmuv3_accel_init() instead. Something like
> > > below. Please take a look and let me know.
> >
> > [...]
> >
> > > @@ -37,7 +37,6 @@ typedef struct SMMUS1Hwpt {
> > >
> > >  typedef struct SMMUv3AccelDevice {
> > >      SMMUDevice  sdev;
> > > -    AddressSpace as_sysmem;
> > >      HostIOMMUDeviceIOMMUFD *idev;
> > >      SMMUS1Hwpt  *s1_hwpt;
> > >      SMMUViommu *viommu;
> > > @@ -48,6 +47,7 @@ typedef struct SMMUv3AccelDevice {  typedef struct
> > > SMMUv3AccelState {
> > >      MemoryRegion root;
> > >      MemoryRegion sysmem;
> > > +    AddressSpace as_sysmem;
> > >      SMMUViommu *viommu;
> > >      struct iommu_hw_info_arm_smmuv3 info;  } SMMUv3AccelState;
> >
> > That's changing from an ioas_id per VFIO device to an ioas_id per
> > vSMMU instance, right? I think it's still not enough.
> >
> > All vSMMU instances could share the same ioas_id. That is why I put in
> > the SMMUBaseClass as it's shared structure across vSMMUs.
>=20
> Ah..you mean it is basically per VM then. Got it.

Regarding using SMMUBaseClass for this, it looks like ObjectClass normally =
holds
function pointers. Eric has made a similar observation elsewhere in this se=
ries.

 @Eric, any suggestions?

Is use of &address_space_memory directly in smmuv3_accel_find_add_as() a co=
mplete
no-go, given we are talking about having the system address space for all t=
he SMMUv3=20
accelerated devices here?

Thanks,
Shameer


