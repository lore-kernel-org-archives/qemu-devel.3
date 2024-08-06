Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 810B2C3DA64
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 06:35:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbDnK-0000B7-71; Tue, 06 Aug 2024 02:35:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sbDnD-00089t-FC
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 02:35:36 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sbDnB-0005Fz-07
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 02:35:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1722926133; x=1754462133;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Kn0HEL0VKHxG5iAwyXoSuBlZyNEIzT6pa62U89a6hVA=;
 b=rBk6lDGXjBEtb9XLJ+nvCodoVHkem1b35hYPmPt0UdOaR576KmrmB1Gw
 zZ6LoZOwggzK3dp6/yo13p7aiYXWz1l/xoeH8HW5z/le0jeD6lHg5Ms5q
 eCqnzTy1bxqUx3JZUaFf12c3Ny3Ql4GU4jaWvPnYis0E10EJq1ti9Y4vh
 EirU4l3lKFrSXRXUWptdXBKkZQw+LtWb1vVoMd8AHe24ZB8zaOaW0NhtU
 AR0oynNHGRvkuvg2faC8/dSryLKAAH8FbKyroQX+Hrzcyebqo2Luv0k7A
 xgcyOS1E3dpGOI24RCzXSAP48PWM/p1LmuDMAoWDWznA5vsqKyGOFSGeY A==;
X-IronPort-AV: E=Sophos;i="6.09,267,1716242400"; d="scan'208";a="18053176"
X-MGA-submission: =?us-ascii?q?MDGO+pB8B++CoMf0Jp9THqpH1pQf4mBafGlVZL?=
 =?us-ascii?q?OauLYmoNzlljN2gHEJ5jI/0QGmbTmgOZ7iPJ6ouwGcqaGsnRCpPAlrrN?=
 =?us-ascii?q?0Q/uouRot/W/z5K7HbI4LjM1O4+fkoC1+yAs4UgPc/LCVEwMQNsjeOw1?=
 =?us-ascii?q?ZhXSgrYW8a9EErJo9HDv9jCQ=3D=3D?=
Received: from mail-db8eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.104])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2024 08:35:29 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yQiOaUdVln7jL6Hi4yWxr5ArdAdv2nLSsc1pkoTu4e8yUfkiWBeXgf0M2dSIPvXur1baKLAWiN46tSrmlUxXKHTBI3adtWd29wjEUGsccd0dH129shBgW0aiwBYHoB6662Miscki9rndfBZgccTOu8L+qa1tnO68arMTHp6mH0PPkYwxAPbVg+NvJtBS1V0WFtGs01FxLh8lREfMyLjDCE8xvuk0Zc3V2ZrwuhgOQxRNam690R4TNSHIw98pqZyqPTK7U/m+yj33rmDEkDa/M4a6KtYxzDn0d53dyl0efdbcHYB46oopq7xzm7Nh27XpeXx2VDyRCxVzTPCohaTkIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kn0HEL0VKHxG5iAwyXoSuBlZyNEIzT6pa62U89a6hVA=;
 b=GvgFi49LKtxvmoFCDC/0hmphKzj6lgGmk+sPHtFOf+D69YwD04yer9kGdIaGMjEXGatvdUSIpMt9SUqYoscWXTwo01Pu7JxuhXJAe9NNrcVxuZInmpjDQgqTArY0Dt3BBFmTaBtYmdl7NpECWYSwu7QFxYMKyMNXFRXTfLIfJWN7g5HM5RYlR73w7CKJLqP6tJC763lFmVgvMsJ6qaYQ+AvOgdkmoF28L1YiVY800ewyBi+EdCv6H64lDypBvIJ8JVBd8e5V2j6fm/2GRGNGbjlhuioV7uiRYzz1utf0fgMogYvjEeDewb0xla/liFNQ3gcJG3HzdMHZN1mv56V4DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kn0HEL0VKHxG5iAwyXoSuBlZyNEIzT6pa62U89a6hVA=;
 b=kTRc+9D7Mfa85GmIrEizjZdcHhYmEJmB+Ldhcq8rDs1YIL2KREMwJg4uXUxl6o4tQBxBj8iUW2zabESnS9Oq9gIFiK1VlKJmY/poepGiSDI1ZTLhcWgsvpG0/GgMYphtlBaBgpkvX6c1Ow4C5+3OiGE41YvJXEGcPkmOfELilRO5j9LAUQy8OZaLxYMbBf7iqi1qT4TnRtvbmqc6rZp1zh7qS28gZirJBSai/oPwJ6djnKr+3/9wDBo1+xcMN0R+4OE4HINix8+PlUTHRlT7Bqcgzb1wxQCNXVZSGFruXShsmw7dRaugQcasVj3Z2mKWPNLIUt3V6pukRD6fuTGbHQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PAXPR07MB8000.eurprd07.prod.outlook.com (2603:10a6:102:130::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.10; Tue, 6 Aug
 2024 06:35:27 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.7849.008; Tue, 6 Aug 2024
 06:35:27 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "chao.p.peng@intel.com"
 <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v2 03/17] intel_iommu: Add a placeholder variable for
 scalable modern mode
Thread-Topic: [PATCH v2 03/17] intel_iommu: Add a placeholder variable for
 scalable modern mode
Thread-Index: AQHa5wDz+IzscR3Wh02h51iysT4RrLIZx5WA
Date: Tue, 6 Aug 2024 06:35:27 +0000
Message-ID: <cba7ec79-e2db-4919-a1ea-553ed20e0e2b@eviden.com>
References: <20240805062727.2307552-1-zhenzhong.duan@intel.com>
 <20240805062727.2307552-4-zhenzhong.duan@intel.com>
In-Reply-To: <20240805062727.2307552-4-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PAXPR07MB8000:EE_
x-ms-office365-filtering-correlation-id: fcfe45cb-bc7d-49bf-aa6c-08dcb5e1f5c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?RUpRNEgvVzlMcytvR050czlNMGIwVzNqZkdNTWNCWVNzK2hpWDNXTGhqcjVm?=
 =?utf-8?B?QkZjalFkNldGVW8wWmVYS3Z4eWhHUHZkYVZTajZKandhQ3p4Tm9oNU5adVAr?=
 =?utf-8?B?K250MlB2YXhzdGRlZEpJL3M4cWJUWC8wQnNITVdCQlo1VVllVm1iaXV0Z25J?=
 =?utf-8?B?cEsweGRSa3FlZW4ySGYrMFRmY0lvNFdUMzQyWlNORWhtajcvMlFFdE5ZN2NE?=
 =?utf-8?B?VUMvV3U4bGhrZVppNENINElKeUh3T1lxUFRNeE1oK2I4eHd1UjZNZW5qOFFE?=
 =?utf-8?B?bHVMYXhzMy9rYVlOWmRsNkkzeHVYL0tOZFZTTGxwNmcwVVduL3prcWJqR2hN?=
 =?utf-8?B?V3BDOVdPeTJVQlp5QWFycDBxMWFRVnI1VW94NndYMFc3NWdpYUFvUlhyUnpy?=
 =?utf-8?B?S05BY3FQZ2t0MTMwQ2c3STZJci83bFVTYjFjVnRnTC9VL1JBdDlwcVg5czk3?=
 =?utf-8?B?ejNRTCt2TVIxT1hqbTZWUllLd3Zyem9ZeFRSeFFtVGZFUzJheUZLSFhvWXdH?=
 =?utf-8?B?NWFHUWw0WTl0V0JhL3VwR2U2aGdEdGlBNi9qK0VUUnFlQ09WU3hjdjhWMitW?=
 =?utf-8?B?VWRqN2hzMkREcDBjOWNVNm5TcHNkdTJ2SWo5Vlo4WkVLOGcrQ2ZvcnJnNkZz?=
 =?utf-8?B?OTVCWDlyL3o1TS8xMTJlcTJ0WjlvS2JrODNRSGU3THh4SzJwTWxLZ096cTNB?=
 =?utf-8?B?N3EzQTIrdzFjcWpqSVlnOThpb3VaM2VpOWdnbHZ1ZkRTK0M4ZmFKbnJYZnpD?=
 =?utf-8?B?V0RIRk5rT25TaVZucTZPUjdvMzF6WGRDdHZrZGtxMTJkUnVWSXBvZ2x1Q3BE?=
 =?utf-8?B?cG5EdmlnRmJxa3BGWjkvVVZyOGRPNjVjWFJqUzhRb2tGak1xVHdOaE1uajlT?=
 =?utf-8?B?UHM3akFqUk80a2JUcExMWGdGWElOd2pNdDExK0hjOWV5d29pQVV5bkVwUnFy?=
 =?utf-8?B?RGR6VitQQlI4L2FwdGpLRUpSR2l1MlNsK1B5bHhDT2ZUZDdhNTZEL3QwK2xt?=
 =?utf-8?B?am1OV1BPRTJ1MHVEQ2Y4b3hQaVY4M01UUENIT096d29ldkh1SVR0eklkcEVN?=
 =?utf-8?B?ZUJLTkpaRFEwUTJXbnNGb1NxSzlEVkg0RzB0aFdBWjlacUkxaFBKVCt5UjRr?=
 =?utf-8?B?UG5VNDdHUDdpNE5xZUxWNjc1T1pHL1lHcjhqMzVteW8zZFozQmhyMUlDQ3Ey?=
 =?utf-8?B?dTZPTUpSSVhkeVcybTNpc2NoZGU5Vjd3cU9CV0szNGV1K0FHUDYxeSs0cVhC?=
 =?utf-8?B?Q0txQWtJN2VmSENkSVBwL1NoVWkwNXc3OVgxeHJIakZ0VUZSRWcxMjRvZFd0?=
 =?utf-8?B?T3VETEk2amlYcEMyS0dxYncyMFBuanRtdUdHbEhpVjc2K3VwejkrWkRyN1gx?=
 =?utf-8?B?L1pRbkZFQWF0RXVHWnpHVnFiTzNtQ0pDUk10U05SS1Q2cG1KcVpWUnMrYjFo?=
 =?utf-8?B?WUlZS2p5amwyak4zM3BwRUI0ejduZ0RaWFk4M25kT2EvNHowVndEUFpyN0d1?=
 =?utf-8?B?NjYxT3dwYUdVRWd6OVVFZ0ZNdXBQTnJHVkp1YjZZVVpGU290SU9WYUlSS29m?=
 =?utf-8?B?aFZieHNZMGNTeTBXSFJycUtHYXMwV0N6ZzF3R0NQbTRLMjRRZ2VvdTFreHlr?=
 =?utf-8?B?WGl0azFWR3VzaUszYVNzVEVuS3pPa1E5SlFBVFFvOGlMRHRpYzFzY0Jpc3k3?=
 =?utf-8?B?azBKM2JkU2puWDdGWkQ1UTZYYThyYlBjVStTKzRSK0lERWtGZy9DVGtQY3hP?=
 =?utf-8?B?UHptTDZYVlJ5S2JIQjYybU9WdzVDbDdSSTZycDZJckd3UWhLdGxOSzdqdkkv?=
 =?utf-8?B?UG8yaG1jQ213b0t6SkhQWnp3WkJJcmc4VmRtb3F4R1pPN1pNRDU2UXlzTUVv?=
 =?utf-8?B?bG5VL3dQcGlmcVRkU0lYZy9SMlVlREl1Mk1TcS8zNGlIOHc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VnpTQWVWOXMvSnpZWXc1R2JZNU9WMTNxM1ZTWGVmSndwRVZlU2VxbkNqY2ts?=
 =?utf-8?B?akhCMXJBWUNxM2YyYm5EWGlxSWZIVFdWb05lcjdXakdsOFAvd1A1Wmo1QnBU?=
 =?utf-8?B?NWdnaFpwQnhJelNWbDBxZFFjZ2lOT1hwM2lVWWIyMWwyN3VZY0FHby9zbHM1?=
 =?utf-8?B?dTVhUStBZk02cGxHZ3R6aEdhUmNzTEpxVVFKZTZtdU44cGxHL0ROditnV2tr?=
 =?utf-8?B?bUc0KzF1S21ISHpRZHB2UXA5RDRPV01MdE9vYTlWNzFMY0ZWLzJzU0pJdU5G?=
 =?utf-8?B?N0d1U1FpVlM0SnhtVjdiR3pLYmJ3R3E4bnpNT200YkJwWG5rZ0RJRTBIeS9O?=
 =?utf-8?B?a2ZCSklQTHZqeUJxSTI2ZHRzV0svYno1Ulo2dEZJNVFSeGZyZVVTVDhmc1Vm?=
 =?utf-8?B?U3pHZjdCcy9hajdwMGgxLzFjaG92Q1RqcFRmUVRlOC9TYmRUTXZWd0V4ZXR4?=
 =?utf-8?B?ODBkcnVBbFdKWW8rcE1UVEJ6c0hCYXhmdUhpZTNKQ0MvbmFuZVNlTWZTN0Vp?=
 =?utf-8?B?YjlHdmNFNzJIcmw0THBBZTRBNXJuOTlhOHIvdktyNEUvQXUxZURLb0t1Ti9a?=
 =?utf-8?B?WnlOQVBDQWcxKzRmK1FvbTFPR28zVmJpd1M0ZnpQa3Jtd1IzcWRXNTNNMjV2?=
 =?utf-8?B?d0NNOUxsWEdMWFVYd29KQkdkaFIrYm1KZkgwclRTVGxJU09LQURIZ2JlNm03?=
 =?utf-8?B?S2Z4cDNHY1gxRWZLWklEMm9JSWVTZmNydVltRGpOYnJCUmE2Z0NmY1ZULzgz?=
 =?utf-8?B?SVR6V3p0OHE0czJ2RjVGaUx3Ti9jZkMrSG40enF3NXBGb05kZjFyUUNZMUQr?=
 =?utf-8?B?MU1hcVFqV3grcWlLRkJ1VnZ2UFRjbGZGOHh6VS9ZQVVDN0dFM3U5aUNzcU0r?=
 =?utf-8?B?cnhaUWp6bzRmaXNPUVFNdUtHSEVIN2N4bkk0bC9paFlnTEFqVVRzcUFyVTky?=
 =?utf-8?B?Ym5BMGlSTkZsZVFvWEFodDRxc0Z5bGw4T1VwODRWQ1JRZTBHaE9naGp0azVO?=
 =?utf-8?B?TUFkRkxVRWxUSFRURzIzam1od3RkZGVJWUxpTThOR0E1ZzF3eEMvKzM3OHRM?=
 =?utf-8?B?WHNHY29ZaXQrYk9UUXhmN2lNd2ZSdzhKWVRHY2hRZDVsOU1rQ2tRa2ZQNnVp?=
 =?utf-8?B?MnRGQkozMC9xcUozTVBvVkdQTXpsd3JGeFl5OFZ5anRjd0V0MlZ3QWxKL1dW?=
 =?utf-8?B?WEpzOXJLTTlXTHptRlpRRUJ1TUptY1JSTTNFd0dhd0xBZ2VlQWdhRHFEcXQ1?=
 =?utf-8?B?T1kyelh2M0F0ZXZPaUpkeEZjcVpqU1RSSW12N0p6Uk9oZ0RPcWx5RGRKNm9K?=
 =?utf-8?B?Zk9VeWR4b1c4T3pLR2lVYlNqWStxVFc3UEtUT1ZPMlp5c0huTjVNS0ordFNk?=
 =?utf-8?B?V0JIZXFTaElZbW5MUjF1bTl2bkNkcGsvWEJ5d2RmM1lLalUrYjlCdFdCbXpH?=
 =?utf-8?B?S1BHSUVzZUZTZndPY3dBYldyaGZoYytLZktCV2lYTENkczFQdU1pRUlCNUQz?=
 =?utf-8?B?VEx0L0ZOd0Z6WHoyQ2VOZzZGZHVPYzNhSGpLbFN1WU5idHAwMDNrbm1KQ3dB?=
 =?utf-8?B?YkpEbzloaFBpUWZFYmd2RUIvUnRoSnpYNWlTbXA2bTZUZzRZdERqS0lvdW1F?=
 =?utf-8?B?T085RzZ0ekRwWnZqTXpreHM4Sk5WYUxrRDR1bnU2SWQreDl5RDQvajlWcDlE?=
 =?utf-8?B?N0M1NzVGQ1FQOGVVbEcyZlk1OW9OS1kyUk5QZTU5NHVPNk5EVURncGJqZnRQ?=
 =?utf-8?B?RmNVY2RxWFJVYzNWRFdYTVRWWjF2Y2VkWFdEU2RFOTZtYnN6eWRFTUc2Qits?=
 =?utf-8?B?VDl1cWo4VWo5cG0zdmpZZlVNalB6WkN4akNFSTdmdndGRWZ5UlRjWTVaQXo5?=
 =?utf-8?B?V2ZpVHMzWVAxTlVIWTdia1Z4algyYWJLNUlKdVhMVGhvTmVybW9IVTc5OElF?=
 =?utf-8?B?MnVmeTNlVmt5b2JjalptenFoVmhENVYzVlRBQjhyQ2lmYTlIa2J1dytZUG9s?=
 =?utf-8?B?Q1BnY0J4MVl6ZkNlYUlFVkRqUTFzdmJOOEd1UnJaMCtRWjBWakErejRnTzgw?=
 =?utf-8?B?RllhYjN4bnRWYmUrbEpRUUZnakFnd3ZSWTZrYk9LaVhmcEZleDdBNFZxV3NW?=
 =?utf-8?B?dW8zRWxHMHBsa1VGR29BeDkySGZlelZkSEtLM2J5ZjJQcHF5UU5KNDlUVzhs?=
 =?utf-8?Q?xyjI5nLWPjpHmEstXIYWDcQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F3EF18FD6330F428C1DF69198AB5BD0@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcfe45cb-bc7d-49bf-aa6c-08dcb5e1f5c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2024 06:35:27.4636 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AeEOGgCX2/O3EbOnNZjH+NGePo933GSghQDJ5gIwlwW005W9/MFj6Q3e/E8Zric3XcAfDW92JmTY1wx+lugNJCqsSOzsWzaqr5xmMco5LJH3rI62g5LsHs4DleDm0G3l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB8000
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQoNCk9uIDA1LzA4LzIwMjQgMDg6MjcsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPiBDYXV0aW9u
OiBFeHRlcm5hbCBlbWFpbC4gRG8gbm90IG9wZW4gYXR0YWNobWVudHMgb3IgY2xpY2sgbGlua3Ms
IHVubGVzcyB0aGlzIGVtYWlsIGNvbWVzIGZyb20gYSBrbm93biBzZW5kZXIgYW5kIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+DQo+DQo+IEFkZCBhbiBuZXcgZWxlbWVudCBzY2FsYWJs
ZV9tb2RlIGluIEludGVsSU9NTVVTdGF0ZSB0byBtYXJrIHNjYWxhYmxlDQo+IG1vZGVybiBtb2Rl
LCB0aGlzIGVsZW1lbnQgd2lsbCBiZSBleHBvc2VkIGFzIGFuIGludGVsX2lvbW11IHByb3BlcnR5
DQo+IGZpbmFsbHkuDQo+DQo+IEZvciBub3csIGl0J3Mgb25seSBhIHBsYWNlaGhvbGRlciBhbmQg
dXNlZCBmb3IgYWRkcmVzcyB3aWR0aA0KPiBjb21wYXRpYmlsaXR5IGNoZWNrIGFuZCBibG9jayBo
b3N0IGRldmljZSBwYXNzdGhyb3VnaCB1bnRpbCBuZXN0aW5nDQo+IGlzIHN1cHBvcnRlZC4NCj4N
Cj4gU2lnbmVkLW9mZi1ieTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+IFNpZ25lZC1v
ZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+IC0tLQ0K
PiAgIGluY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oIHwgIDEgKw0KPiAgIGh3L2kzODYvaW50
ZWxfaW9tbXUuYyAgICAgICAgIHwgMTIgKysrKysrKysrLS0tDQo+ICAgMiBmaWxlcyBjaGFuZ2Vk
LCAxMCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvaW5j
bHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmggYi9pbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUu
aA0KPiBpbmRleCAxZWIwNWMyOWZjLi43ODhlZDQyNDc3IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRl
L2h3L2kzODYvaW50ZWxfaW9tbXUuaA0KPiArKysgYi9pbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9t
bXUuaA0KPiBAQCAtMjYyLDYgKzI2Miw3IEBAIHN0cnVjdCBJbnRlbElPTU1VU3RhdGUgew0KPg0K
PiAgICAgICBib29sIGNhY2hpbmdfbW9kZTsgICAgICAgICAgICAgIC8qIFJPIC0gaXMgY2FwIENN
IGVuYWJsZWQ/ICovDQo+ICAgICAgIGJvb2wgc2NhbGFibGVfbW9kZTsgICAgICAgICAgICAgLyog
Uk8gLSBpcyBTY2FsYWJsZSBNb2RlIHN1cHBvcnRlZD8gKi8NCj4gKyAgICBib29sIHNjYWxhYmxl
X21vZGVybjsgICAgICAgICAgIC8qIFJPIC0gaXMgbW9kZXJuIFNNIHN1cHBvcnRlZD8gKi8NCj4g
ICAgICAgYm9vbCBzbm9vcF9jb250cm9sOyAgICAgICAgICAgICAvKiBSTyAtIGlzIFNOUCBmaWxl
ZCBzdXBwb3J0ZWQ/ICovDQo+DQo+ICAgICAgIGRtYV9hZGRyX3Qgcm9vdDsgICAgICAgICAgICAg
ICAgLyogQ3VycmVudCByb290IHRhYmxlIHBvaW50ZXIgKi8NCj4gZGlmZiAtLWdpdCBhL2h3L2kz
ODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPiBpbmRleCBlMzQ2NWZj
MjdkLi5jMTM4MmE1NjUxIDEwMDY0NA0KPiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4g
KysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+IEBAIC0zODcyLDcgKzM4NzIsMTMgQEAgc3Rh
dGljIGJvb2wgdnRkX2NoZWNrX2hpb2QoSW50ZWxJT01NVVN0YXRlICpzLCBIb3N0SU9NTVVEZXZp
Y2UgKmhpb2QsDQo+ICAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+ICAgICAgIH0NCj4NCj4gLSAg
ICByZXR1cm4gdHJ1ZTsNCj4gKyAgICBpZiAoIXMtPnNjYWxhYmxlX21vZGVybikgew0KPiArICAg
ICAgICAvKiBBbGwgY2hlY2tzIHJlcXVlc3RlZCBieSBWVEQgbm9uLW1vZGVybiBtb2RlIHBhc3Mg
Ki8NCj4gKyAgICAgICAgcmV0dXJuIHRydWU7DQo+ICsgICAgfQ0KPiArDQo+ICsgICAgZXJyb3Jf
c2V0ZyhlcnJwLCAiaG9zdCBkZXZpY2UgaXMgdW5zdXBwb3J0ZWQgaW4gc2NhbGFibGUgbW9kZXJu
IG1vZGUgeWV0Iik7DQo+ICsgICAgcmV0dXJuIGZhbHNlOw0KPiAgIH0NCj4NCj4gICBzdGF0aWMg
Ym9vbCB2dGRfZGV2X3NldF9pb21tdV9kZXZpY2UoUENJQnVzICpidXMsIHZvaWQgKm9wYXF1ZSwg
aW50IGRldmZuLA0KPiBAQCAtNDI2Miw5ICs0MjY4LDkgQEAgc3RhdGljIGJvb2wgdnRkX2RlY2lk
ZV9jb25maWcoSW50ZWxJT01NVVN0YXRlICpzLCBFcnJvciAqKmVycnApDQo+ICAgICAgICAgICB9
DQo+ICAgICAgIH0NCj4NCj4gLSAgICAvKiBDdXJyZW50bHkgb25seSBhZGRyZXNzIHdpZHRocyBz
dXBwb3J0ZWQgYXJlIDM5IGFuZCA0OCBiaXRzICovDQo+ICAgICAgIGlmICgocy0+YXdfYml0cyAh
PSBWVERfSE9TVF9BV18zOUJJVCkgJiYNCj4gLSAgICAgICAgKHMtPmF3X2JpdHMgIT0gVlREX0hP
U1RfQVdfNDhCSVQpKSB7DQo+ICsgICAgICAgIChzLT5hd19iaXRzICE9IFZURF9IT1NUX0FXXzQ4
QklUKSAmJg0KPiArICAgICAgICAhcy0+c2NhbGFibGVfbW9kZXJuKSB7DQpXaHkgZG9lcyBzY2Fs
YWJsZV9tb2Rlcm4gYWxsb3cgdG8gdXNlIGEgdmFsdWUgb3RoZXIgdGhhbiAzOSBvciA0OD8NCklz
IGl0IHNhZmU/DQo+ICAgICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJTdXBwb3J0ZWQgdmFsdWVz
IGZvciBhdy1iaXRzIGFyZTogJWQsICVkIiwNCj4gICAgICAgICAgICAgICAgICAgICAgVlREX0hP
U1RfQVdfMzlCSVQsIFZURF9IT1NUX0FXXzQ4QklUKTsNCj4gICAgICAgICAgIHJldHVybiBmYWxz
ZTsNCj4gLS0NCj4gMi4zNC4xDQo+DQo=

