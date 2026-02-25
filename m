Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 956A3F357D5
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 06:42:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv8aw-0008D3-NS; Wed, 25 Feb 2026 01:42:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1vv8ap-0008Ca-88
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 01:41:57 -0500
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1vv8am-0006RQ-2r
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 01:41:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1772001711; x=1803537711;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=JMWsBR6D41lO7nAty/EYFGJX438gyO/ofAAnTBqXxK8=;
 b=DvbfmmYSpe8C1CK8l32VK3bfJoT2jmkTLWpsyHDpu0eCxQkjYbWcxcES
 BBCNaWqVDqdzNa5/bRcNoVh6rx1p8lS+LlzcVH88B8zE4qGRsjDnpXw1r
 n1kF0v5CSYtiNpMsICbT8yxB5hfR5AEttzmvj0zb9oWlx9qnYTNUtkXjz
 w7k95zvvDSKS7uBmmwtxruI9UVonmW/j9x3aCTtbvFP787uuXHv/OUkIk
 joGPc2pJYIEaOP/A4k0viJZm8MEvmCugKtjjW9nuYdyOfgeOX6o3fnQ8i
 BIvqp3w3odSflvOZbcMLhyHq8QZbjSqabo740L+Rkc6+njgqZLXw3Dn6b A==;
X-CSE-ConnectionGUID: Cpd9seN0SIi8soX6LGvQmg==
X-CSE-MsgGUID: AiYXjBtHQkqy9VlYyDgsWA==
X-IronPort-AV: E=Sophos;i="6.21,310,1763420400"; d="scan'208,217";a="46641953"
X-MGA-submission: =?us-ascii?q?MDF8ln8raJsU8+wEjpYn3VdChXCKIcbKJM5N77?=
 =?us-ascii?q?kaVSXavpXOx8ahBGrOupF0WgMwjh5VYwHOkDewqWfLrJAi0eo8taYXkM?=
 =?us-ascii?q?JTgfWn0q4LMQIydL7252Ikmmj2LqG1N49hqeN7riF5BAtCBjw20D53Js?=
 =?us-ascii?q?DpPGuIPAFVbj31jTgqdGnNkA=3D=3D?=
Received: from mail-northeuropeazon11012069.outbound.protection.outlook.com
 (HELO DUZPR83CU001.outbound.protection.outlook.com) ([52.101.66.69])
 by smarthost3.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 25 Feb 2026 07:41:49 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oq+ki37KmNHepjg8KA7YuPgAncyowqQIj8LJ5siDJjkZPrUFrVYeGnnreEQjri4ybKT/j+wTXfZXRPfDCRd6H6lGycKakrc4Xfb3xdvITftKQHavTWduS6ChZ224u/jgN+oF3lp+0NQGoE2XmTbgKrbaqAKFOeMuj1AMUxH6JKGbooBoIUJAanyWrQ7K3lnBZ1FOB9tqaWTT113KwE9bd9F7qwccbUZoHr+nc7+LJBbxdh/U7QUZjpTdcwYdrTU9Fj6NdjsRswbj7ouVh3INYAiNf1wdAd4m0p1jSV6uWwtPg83aj5jdO/NUF63mxthi5ZPLeadUGjQGmSVRn7akNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gO9vZzENb1uY1mjT44v9lJgWFgoQ0H2P4dTYjGt95P8=;
 b=ot6E5u++Hh7IdXJe5RQrYFqHx2YB15KNAMmzH8XuW1AsznskiS0iQBms34Itv29NrtY5CSJlqzlskK/G9dA9rRVclTsKZfnh+r5vy4O0uhi0Qyk5TMv+oYmGjEyjXCxv/8RpmaC9ljojN/3tudEZgIQt7m8mcGkA1Ip5tKuJj8xS2bdbrQfR/4G+FpSoEjT9wlA+hC6bkKdHvucJkMh2wjV3vNctwbhmiYPnVM6ITbikQT1xzod9kLTiQiSA9ZyvUwjGXLxO7B2BMSlLDxk8h/xYX5ilz0lhJ+FXvQ3OfOnpFQxow8U8rG9vdse980X9pLKnaUpZ50HYDA26xOZPnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gO9vZzENb1uY1mjT44v9lJgWFgoQ0H2P4dTYjGt95P8=;
 b=rTdw6SHuAp+tc+wU54l48/b+PS7EEFua06FxO35+SqhTPUPY/6d1oCwsd87G2vKgz0wsbGTzxzTo8SKBNs01SFm8Ax6R/r6ntAxJLWEYEBwjg1vlMGUkv84di/NIXu5tfrO68LA/faU/XJhcYdjOp4aIsXDJ0eK6tJxW7PXyLa7R7XdQJQIvR7c6JlDhFBspq1etD/x6eKi4KgRnYL2/RcvnJe/7nS4zdZfAtXXAxzNHmRQo8T6IZsDGriNXDT8CuVfVKWmMTdmWN7RXn8kOd4qm4jfoWxSExX3dXqBEc798G3ACeZDkomW3JIAbxFaOHK0TaNsakY7cJ3Kw3wdUJA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DU0PR07MB9162.eurprd07.prod.outlook.com (2603:10a6:10:406::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 06:41:47 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 06:41:47 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, "xudong.hao@intel.com" <xudong.hao@intel.com>
Subject: Re: [RFCv2 PATCH 12/13] intel_iommu_accel: Add pasid bits size check
Thread-Topic: [RFCv2 PATCH 12/13] intel_iommu_accel: Add pasid bits size check
Thread-Index: AQHcnWP20QrD5iQNmEWrT+7sB8IeqrWTBahB
Date: Wed, 25 Feb 2026 06:41:47 +0000
Message-ID: <AM8PR07MB7602F76D7799033FFCB1A5608675A@AM8PR07MB7602.eurprd07.prod.outlook.com>
References: <20260214034135.220413-1-zhenzhong.duan@intel.com>
 <20260214034135.220413-13-zhenzhong.duan@intel.com>
In-Reply-To: <20260214034135.220413-13-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Enabled=True;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_SiteId=7d1c7785-2d8a-437d-b842-1ed5d8fbe00a;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_SetDate=2026-02-25T06:41:23.127Z;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Name=Eviden
 For Internal Use - All
 Employees; MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_ContentBits=1;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DU0PR07MB9162:EE_
x-ms-office365-filtering-correlation-id: f1420b67-0c8c-4556-fada-08de7438f2b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|8096899003|18082099003|7053199007|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Y8yVD+A+9Nwop0dRZBUIn3pFMwcYN7DQUMtnD11alz8r7/zbXOZT9AUX03?=
 =?iso-8859-1?Q?WMajbo5yixsl+wSvX41GheLeSrnDsYovxiQF1KYu/uqHryYsIMoUGVbdg7?=
 =?iso-8859-1?Q?3E8xUsfoCFv3G1Ce4u6/UmHO/7ZvosaimjS78YCBo1By2KSDv4+1KW3MIU?=
 =?iso-8859-1?Q?lrvoeow6eXG+Nnd0YQgE9GCKjmD+KiLPxI73m8oD2mHe+6Vfel5tDm0b6k?=
 =?iso-8859-1?Q?xUC5BOOZltRcFfdsbrWJBWHidzDVtxBwtQsSJvjFb/y1GEQaiJ+SXXDFdu?=
 =?iso-8859-1?Q?wR5GKFHc8w/0YJt9lXcQZM2ilHYtliPtcbCaYvb4zLOABG4TTf4ATuFRGQ?=
 =?iso-8859-1?Q?r1L39JVRsxzA1GnZwU1Q0KThsoXkolgHdBhI2vctgIh7e8QCpiLm2OZvRj?=
 =?iso-8859-1?Q?NhzVJphNbbCe51LkE2DmqzYYnFjLXQDLJne1jYzPUFxz4j6ZqAbJeoKASQ?=
 =?iso-8859-1?Q?K4Wb34tqeioJeX9N3zW4DNjDmXaDUizi0nuc1L3XUJoa9PxFvRr2m718Lo?=
 =?iso-8859-1?Q?axmASAFKyJNfbvOcdA3oRNueqj4mWJq4zJFJ+CFSrmY7eI7+2KHdnGzEJ+?=
 =?iso-8859-1?Q?q8eGW6GEI/4lpKt05eK5IqCsOyd++IcT1kGHadrcUXfoKGQy6fyHBdQ93e?=
 =?iso-8859-1?Q?5I41bjL+rQQ0P6pkbGuUu5jH4mY78I+aG5j6tMQkNwBCACVy4mDzCNw2oB?=
 =?iso-8859-1?Q?yNIqHH54uZQftlSidZogh64AjHvrOpHRf4t1dBSTAZwqyHYq3J0Jhtcv+m?=
 =?iso-8859-1?Q?9C20h/vyfZUNwSUayYn6bKfBf7UyfpTy/mutcNwUpAC2zKJyqFbdNqzvkM?=
 =?iso-8859-1?Q?SdYccxYeZTDRELnxGM+xxwOYZw41prmxW9Usv+hLVS50WIg5u36dwwJE2L?=
 =?iso-8859-1?Q?DFycOKavuRdVjdWYOZd+6v82e/pkOfW6QTpI6gh69137HE/197OIqA9nfN?=
 =?iso-8859-1?Q?ttVEqsgZkbsFfZhIHgAD4Jo0xRaRE6Jt83DF5GW+av9agfM2cE+gurhprZ?=
 =?iso-8859-1?Q?nZY5d7/Wpym2UErM5jUb0lnDiWqBZhyXiQuDMu5V/fVHBrS3NzF99d3JI0?=
 =?iso-8859-1?Q?unZ7q1XUSDPzDPTGnmHdIW2FN4J+7IwGZuX/YvYMSzQNvptz2LifgmszHC?=
 =?iso-8859-1?Q?/V4D49uHIXSas3i5ElwRV/6Bzq2ysBRBXLhjTWLLxaw+JlCw1OXn2zbL4x?=
 =?iso-8859-1?Q?G4+nDhtGjAOGU1f/9O+5kt9locaxO60+nOO/OxP6i+gTYFPLbUveyNYcii?=
 =?iso-8859-1?Q?WbdsiiJPnwTD7lTnecgA9kB4hea52zVNNKym6b93+tOyv6to0X8dq/wz3Z?=
 =?iso-8859-1?Q?NUL32y2EUUHD12q4VOcOhIxuuPpZh9q/8CPcqBRLsVTfu/NNCOr448fi1Z?=
 =?iso-8859-1?Q?PXE+1fiJCgG69U2McIl3UZzHqfBpTKDT8YtwNoLfsKNdn8rhV+0KcIQL4i?=
 =?iso-8859-1?Q?Zffz2HAcek8lsxBVJJq3z2iFqoPJ89LPW5zVktGnrXmAhZnNoXFkdgOz/z?=
 =?iso-8859-1?Q?cnd4n1+jiiCGq4amrfS5iLZNuenchxwmMqg41H2jT7N1L/0tKN/UtHgzxP?=
 =?iso-8859-1?Q?ywfdAQev9UpyRFbIz5YGRbrTG5V23JAo0PU7k1TnESaMXxj8KSw1XFnksp?=
 =?iso-8859-1?Q?BZ/NNfSAMtQ8mKRgJZ6rNDMvOjktqrVzsdKyCtyZ+zyVXydlS437hdKbwm?=
 =?iso-8859-1?Q?jYDHXdShJ7Fs4dKVohM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(8096899003)(18082099003)(7053199007)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?CFSauYLVqOzq4F/5FOIZsVNqIqBdJfZKZYmWBgRw9kQtOiJnfIzJElGbM4?=
 =?iso-8859-1?Q?vacH2ZZmAjyXtVDt3ZHpeqSfsAbeXP5MDvayWavarNOnJp9Rxed6gSDspA?=
 =?iso-8859-1?Q?nK1iyOrsKYYfi8q+4GLLx/Bg2vn3s0twLH9B2uR0BqnrcW1gqUshnmh4ZD?=
 =?iso-8859-1?Q?QmY1xHhMyW4YEmg+O1SqbmxFi3483UtPWDdobG5fFaYeCRn+k8VKdd//OE?=
 =?iso-8859-1?Q?8lLEijQwjNtWJYRqBmlisb3plbFUdjdzFPd8kszKYi+T0zjWwfaxBeROSj?=
 =?iso-8859-1?Q?mbu7YBMi7KKJGkJ8ZexatcCibkJ0KY73Z/e/mJghGJUJ5n3OCr5egZDU1R?=
 =?iso-8859-1?Q?VhVXlG2i87a4Pg3L/ZlhQjd2RE7QAXctQqOeWMylHrqECRHS1YeOsgH66l?=
 =?iso-8859-1?Q?YluAiX3rKpOblXgtvhA7jtQ9O4DzeTQGAP/K7VM58k1Q0uuz4gfh2iK3dq?=
 =?iso-8859-1?Q?g+xFBTbG8cyXt+2jpXKqd6+Lyc1KDilZWu8Wqco74Fr5FygdAd7kkcj0CC?=
 =?iso-8859-1?Q?gTGLVbXjApgSp8ZfkhG5TjxqnV2znEi29b2XkGHt2Aplt7UqWgmcOcx7/8?=
 =?iso-8859-1?Q?V7buVMNEPxfqIuY9UdDfyL1E36uMYhLbt6IOLB9IJXz5vBht8BvvCyc1wS?=
 =?iso-8859-1?Q?yzCzyzbCE3UOlf/kph5sFszqT+p8xda19KZb9iwarsQf4zl8w5eM1i9RbS?=
 =?iso-8859-1?Q?KtpQx2L0cvvcovwANqdEJjT/Xr9N/xzd6F5oULkaGZfYN/n145wR0P7Hk2?=
 =?iso-8859-1?Q?m2tjb7KdDcPJEO5A2oO2kWCQizfkY6rD86fCQIpgAMEqO1+03kqvVb1ntu?=
 =?iso-8859-1?Q?pk5misI3qaz08hHQ1McVk5+hWS8XXG3ldzBVZU8xsvbJ8u7sZvDgmgXLTn?=
 =?iso-8859-1?Q?ruFaigC/QWNsZmSY50YuN3BbOFTmpaPAsByBrh1FK5pyagPtxafSJEU2vY?=
 =?iso-8859-1?Q?vpg5ZlQDwXhBumPYrhtZvF4uqhZKhh1Mq8Ub7RxUadO3UsCLVnEV5PNAwB?=
 =?iso-8859-1?Q?ZnP27E+r9yiRrjbr8sW8k8i9RFYdbaHVhmW4x6WbGK6FBGJB9+Rr1WaESh?=
 =?iso-8859-1?Q?nz57OGM9AgbW04oTc11E7AlDXch/48V4u96QgieyJFo+6ldNEy3VJOuAKT?=
 =?iso-8859-1?Q?vM+dRp4eQBDnjB9QpRhAEan/nemUn0pj1Gi5zV/UiF5GbH9/uAS2j7H44V?=
 =?iso-8859-1?Q?3rFqZmieqQU2X0PyjeGUbTHPoLHyT8MTC9FkhFffIAijvdVPgtXFd5YBFC?=
 =?iso-8859-1?Q?1jNUH3Df6Mw5EL94cT1q6UtDeFY5WstKUqcDXICGy8qzfFn+VEPdrpSxZi?=
 =?iso-8859-1?Q?RsEun7Eq7xN2MWGFa6lCOpJYaKaMX5KmJBBRxxfzg43Cg6K6u/nZU0cO8I?=
 =?iso-8859-1?Q?exVamNGw+vqsfhwFDgvd3OyuvUFd8WOi9HtmKM7JdTyXZUOEEaUljx8468?=
 =?iso-8859-1?Q?qs/iNm9APompKRkNhNtO+KmQreBUWU3yFidpRLY/WHBrmVKs33mVWflH+4?=
 =?iso-8859-1?Q?EAk09LASc9kv4S38g86F4aUyZIPIOQFKJhq6yRfu5sgXzdPCvHyaVukioq?=
 =?iso-8859-1?Q?er8VXdxaf1TDoxWMb2g9KDyz/3uL0srCQ5nSEXV/qvHKRWaaM8BYajSoOS?=
 =?iso-8859-1?Q?jRGRJbmD6FKaJr1/eO0fI1iaWncA41t6pflAHSv//KaMULA7nH5OyVIwCm?=
 =?iso-8859-1?Q?dM9ZLt+orEkUYa8UdmPoa+ZMt9xJBtxD0iUqnsVbb+H4HfxpRUnsblM/G/?=
 =?iso-8859-1?Q?Od/IoffnNlI9ZB0dj1CfB5KY3Nwoc3n56ka879Ht0fnYjNukn5iSj5PaRu?=
 =?iso-8859-1?Q?AP8k7ciyI+P+qtR7+T4lmB1yC3GFxDk=3D?=
Content-Type: multipart/alternative;
 boundary="_000_AM8PR07MB7602F76D7799033FFCB1A5608675AAM8PR07MB7602eurp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: r+QpInTVCYqk7ObPGPpCmX6pZBAoe4OpX7JVS9DLUKdmtiKjZ5ClaHrpZzP/fIhA0MaqPV1TkArwOSqy1ztN093kwZlVGKmRgxscjPq2/fdLfw+62CvIdMNgf6YKdj3/w+HZx38Lt8o2Ck8QWmAhjM5AfwUbnw96b6Fmcn71JAmYd5tm7w2i7wVVRU1MpuGkSKp9upAICbSAc51q8P+jR4zOhqUujQDvmAyCGpNTk0CZo7+FNaOJerCucRXK9XNJV69zwdZil/ZTkDbV3mmNJzLFqQimcwQkEi5AjPxI0swjfFjeMMxz1MYSh+d4q3iZH+ekZFgWhmkYfuAS26ThFg==
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1420b67-0c8c-4556-fada-08de7438f2b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 06:41:47.2190 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0wS7or2jc/YJbViz3B0W1oP2ryeg1xDUo56ZB5Mc6eesJPL6M6rQhKPesgtnYlGsJ4Xlg0Og8jgyG/lUNFxChKZ3AYKT6QIrvVoncz6JNvFRtEYeSa9gOc1Pn00qv6vn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB9162
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--_000_AM8PR07MB7602F76D7799033FFCB1A5608675AAM8PR07MB7602eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Zhenzhong,

Why do we capitalize the first letter of each word in "Max PASID Width"?
I guess you try to match the pcie spec, but just want to confirm :)

cmd

________________________________
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
Sent: 14 February 2026 04:41
To: qemu-devel@nongnu.org <qemu-devel@nongnu.org>
Cc: alex@shazbot.org <alex@shazbot.org>; clg@redhat.com <clg@redhat.com>; e=
ric.auger@redhat.com <eric.auger@redhat.com>; mst@redhat.com <mst@redhat.co=
m>; jasowang@redhat.com <jasowang@redhat.com>; jgg@nvidia.com <jgg@nvidia.c=
om>; nicolinc@nvidia.com <nicolinc@nvidia.com>; skolothumtho@nvidia.com <sk=
olothumtho@nvidia.com>; joao.m.martins@oracle.com <joao.m.martins@oracle.co=
m>; CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>; kevin.tian@in=
tel.com <kevin.tian@intel.com>; yi.l.liu@intel.com <yi.l.liu@intel.com>; xu=
dong.hao@intel.com <xudong.hao@intel.com>; Zhenzhong Duan <zhenzhong.duan@i=
ntel.com>
Subject: [RFCv2 PATCH 12/13] intel_iommu_accel: Add pasid bits size check

Caution: External email. Do not open attachments or click links, unless thi=
s email comes from a known sender and you know the content is safe.


If pasid bits size is bigger than host side, host could fail to emulate
all bindings in guest. Add a check to fail device plug early.

Pasid bits size should also be no more than 20 bits according to PCI spec.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h | 1 +
 hw/i386/intel_iommu.c          | 5 +++++
 hw/i386/intel_iommu_accel.c    | 8 ++++++++
 3 files changed, 14 insertions(+)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.=
h
index e4bcc884b0..e5518a94ea 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -195,6 +195,7 @@
 #define VTD_ECAP_MHMV               (15ULL << 20)
 #define VTD_ECAP_SRS                (1ULL << 31)
 #define VTD_ECAP_NWFS               (1ULL << 33)
+#define VTD_ECAP_PSS(x)             extract64(x, 35, 5)
 #define VTD_ECAP_PASID              (1ULL << 40)
 #define VTD_ECAP_PDS                (1ULL << 42)
 #define VTD_ECAP_SMTS               (1ULL << 43)
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 6483cb3d85..c1b31b17de 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -5545,6 +5545,11 @@ static bool vtd_decide_config(IntelIOMMUState *s, Er=
ror **errp)
         error_setg(errp, "Need to set scalable mode for PASID");
         return false;
     }
+    if (s->pasid >=3D PCI_EXT_CAP_PASID_MAX_WIDTH) {
+        error_setg(errp, "PASID width %d, exceed Max PASID Width %d allowe=
d "
+                   "in PCI spec", s->pasid, PCI_EXT_CAP_PASID_MAX_WIDTH);
+        return false;
+    }

     if (s->svm) {
         if (!x86_iommu->dt_supported) {
diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index acb1b1e238..15412123d5 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -44,6 +44,7 @@ bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMM=
UDevice *vtd_hiod,
     HostIOMMUDevice *hiod =3D vtd_hiod->hiod;
     struct HostIOMMUDeviceCaps *caps =3D &hiod->caps;
     struct iommu_hw_info_vtd *vtd =3D &caps->vendor_caps.vtd;
+    uint8_t hpasid =3D VTD_ECAP_PSS(vtd->ecap_reg) + 1;
     PCIBus *bus =3D vtd_hiod->bus;
     PCIDevice *pdev =3D bus->devices[vtd_hiod->devfn];

@@ -64,6 +65,13 @@ bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOM=
MUDevice *vtd_hiod,
         return false;
     }

+    /* Only do the check when host device support PASIDs */
+    if (caps->max_pasid_log2 && s->pasid > hpasid) {
+        error_setg(errp, "PASID bits size %d > host IOMMU PASID bits size =
%d",
+                   s->pasid, hpasid);
+        return false;
+    }
+
     if (pci_device_get_iommu_bus_devfn(pdev, &bus, NULL, NULL)) {
         error_setg(errp, "Host device downstream to a PCI bridge is "
                    "unsupported when x-flts=3Don");
--
2.47.3


--_000_AM8PR07MB7602F76D7799033FFCB1A5608675AAM8PR07MB7602eurp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Hi Zhenzhong,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Why do we capitalize the first letter of each word in &quot;Max PASID Width=
&quot;?</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
I guess you try to match the pcie spec, but just want to confirm :)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
cmd</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg">
<div style=3D"direction: ltr; font-family: Calibri, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Zhenzhong Duan &lt;zhenzhong.duan@intel.com&gt;<br>
<b>Sent:</b>&nbsp;14 February 2026 04:41<br>
<b>To:</b>&nbsp;qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;<br>
<b>Cc:</b>&nbsp;alex@shazbot.org &lt;alex@shazbot.org&gt;; clg@redhat.com &=
lt;clg@redhat.com&gt;; eric.auger@redhat.com &lt;eric.auger@redhat.com&gt;;=
 mst@redhat.com &lt;mst@redhat.com&gt;; jasowang@redhat.com &lt;jasowang@re=
dhat.com&gt;; jgg@nvidia.com &lt;jgg@nvidia.com&gt;; nicolinc@nvidia.com
 &lt;nicolinc@nvidia.com&gt;; skolothumtho@nvidia.com &lt;skolothumtho@nvid=
ia.com&gt;; joao.m.martins@oracle.com &lt;joao.m.martins@oracle.com&gt;; CL=
EMENT MATHIEU--DRIF &lt;clement.mathieu--drif@eviden.com&gt;; kevin.tian@in=
tel.com &lt;kevin.tian@intel.com&gt;; yi.l.liu@intel.com &lt;yi.l.liu@intel=
.com&gt;;
 xudong.hao@intel.com &lt;xudong.hao@intel.com&gt;; Zhenzhong Duan &lt;zhen=
zhong.duan@intel.com&gt;<br>
<b>Subject:</b>&nbsp;[RFCv2 PATCH 12/13] intel_iommu_accel: Add pasid bits =
size check</div>
<div style=3D"direction: ltr;">&nbsp;</div>
</div>
<div style=3D"font-size: 11pt;">Caution: External email. Do not open attach=
ments or click links, unless this email comes from a known sender and you k=
now the content is safe.<br>
<br>
<br>
If pasid bits size is bigger than host side, host could fail to emulate<br>
all bindings in guest. Add a check to fail device plug early.<br>
<br>
Pasid bits size should also be no more than 20 bits according to PCI spec.<=
br>
<br>
Signed-off-by: Zhenzhong Duan &lt;zhenzhong.duan@intel.com&gt;<br>
---<br>
&nbsp;hw/i386/intel_iommu_internal.h | 1 +<br>
&nbsp;hw/i386/intel_iommu.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; | 5 +++++<br>
&nbsp;hw/i386/intel_iommu_accel.c&nbsp;&nbsp;&nbsp; | 8 ++++++++<br>
&nbsp;3 files changed, 14 insertions(+)<br>
<br>
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.=
h<br>
index e4bcc884b0..e5518a94ea 100644<br>
--- a/hw/i386/intel_iommu_internal.h<br>
+++ b/hw/i386/intel_iommu_internal.h<br>
@@ -195,6 +195,7 @@<br>
&nbsp;#define VTD_ECAP_MHMV&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (15ULL &lt;&lt; 20)<br>
&nbsp;#define VTD_ECAP_SRS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1ULL &lt;&lt; 31)<br>
&nbsp;#define VTD_ECAP_NWFS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1ULL &lt;&lt; 33)<br>
+#define VTD_ECAP_PSS(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; extract64(x, 35, 5)<br>
&nbsp;#define VTD_ECAP_PASID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1ULL &lt;&lt; 40)<br>
&nbsp;#define VTD_ECAP_PDS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1ULL &lt;&lt; 42)<br>
&nbsp;#define VTD_ECAP_SMTS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1ULL &lt;&lt; 43)<br>
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c<br>
index 6483cb3d85..c1b31b17de 100644<br>
--- a/hw/i386/intel_iommu.c<br>
+++ b/hw/i386/intel_iommu.c<br>
@@ -5545,6 +5545,11 @@ static bool vtd_decide_config(IntelIOMMUState *s, Er=
ror **errp)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; error_setg(errp, &quot;Nee=
d to set scalable mode for PASID&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp; if (s-&gt;pasid &gt;=3D PCI_EXT_CAP_PASID_MAX_WIDTH) {<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; error_setg(errp, &quot;PASID wi=
dth %d, exceed Max PASID Width&nbsp;%d allowed &quot;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;in PCI spec&quot;, s-&gt;pasid, PC=
I_EXT_CAP_PASID_MAX_WIDTH);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
+&nbsp;&nbsp;&nbsp; }<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp; if (s-&gt;svm) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!x86_iommu-&gt;dt_supp=
orted) {<br>
diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c<br>
index acb1b1e238..15412123d5 100644<br>
--- a/hw/i386/intel_iommu_accel.c<br>
+++ b/hw/i386/intel_iommu_accel.c<br>
@@ -44,6 +44,7 @@ bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMM=
UDevice *vtd_hiod,<br>
&nbsp;&nbsp;&nbsp;&nbsp; HostIOMMUDevice *hiod =3D vtd_hiod-&gt;hiod;<br>
&nbsp;&nbsp;&nbsp;&nbsp; struct HostIOMMUDeviceCaps *caps =3D &amp;hiod-&gt=
;caps;<br>
&nbsp;&nbsp;&nbsp;&nbsp; struct iommu_hw_info_vtd *vtd =3D &amp;caps-&gt;ve=
ndor_caps.vtd;<br>
+&nbsp;&nbsp;&nbsp; uint8_t hpasid =3D VTD_ECAP_PSS(vtd-&gt;ecap_reg) + 1;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp; PCIBus *bus =3D vtd_hiod-&gt;bus;<br>
&nbsp;&nbsp;&nbsp;&nbsp; PCIDevice *pdev =3D bus-&gt;devices[vtd_hiod-&gt;d=
evfn];<br>
<br>
@@ -64,6 +65,13 @@ bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOM=
MUDevice *vtd_hiod,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
+&nbsp;&nbsp;&nbsp; /* Only do the check when host device support PASIDs */=
<br>
+&nbsp;&nbsp;&nbsp; if (caps-&gt;max_pasid_log2 &amp;&amp; s-&gt;pasid &gt;=
 hpasid) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; error_setg(errp, &quot;PASID bi=
ts size %d &gt; host IOMMU PASID bits size %d&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;pasid, hpasid);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
+&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp; if (pci_device_get_iommu_bus_devfn(pdev, &amp;bus,=
 NULL, NULL)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; error_setg(errp, &quot;Hos=
t device downstream to a PCI bridge is &quot;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;unsupported when x-flts=3Don&=
quot;);<br>
--<br>
2.47.3<br>
<br>
</div>
</body>
</html>

--_000_AM8PR07MB7602F76D7799033FFCB1A5608675AAM8PR07MB7602eurp_--

