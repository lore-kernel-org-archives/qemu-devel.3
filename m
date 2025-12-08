Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A17FD3B7DE
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 11:16:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSZDN-0001WW-LE; Mon, 08 Dec 2025 06:15:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vSZDL-0001W6-6Y; Mon, 08 Dec 2025 06:15:35 -0500
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vSZDJ-0007w4-3v; Mon, 08 Dec 2025 06:15:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HA/RquqVYJpRiXFlpTWtpMk/GxDADQ/8qAjLNGd9TZXwJTMqBZKpXCL9BDvWYJtwYzk78VntpcwufbLyWOb9G/WkEdNAyA4BJr3SX8wnShHe1rcWbjpTZhVgTI57+qseFsXSKbYdKZS1/oJ3spizqnRCUsZcPxxmH00lG0uhohj6lbtOsaftkMn/qBh7e5VUyISQgD1byU7aGQ9C7L6/qrNT3HuBUlnJc39rvmIWxHXZ1pXP3OMbYxZ0MUQnbo27Qy1YKmoQ1//AmrQ49+7JjccSDQvBUqIlHE6f0qIS5WIJPFTW9pHlLEZEA7gwdtS8UYPOoHqHGbbYAQW5TXncVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7M1gzhvG6GswJPG9aYpC1zq1WPzImlQJj12ejXFbCas=;
 b=ouJOC8YtA+iAY9kCrB3b/Prwadgo2rZhyBQMLuPghAgcaE8ClBrJpn0cy9EW3g9AkeMzp/ReTqJD3i685eUoiXGjuFCy4m4A4s9QWJ6CpfyEVQxFoewbb1dGS+SS+SCizbnmIjZHLMIGYwHqK6jVJ7WgkSfWfFLCzzIClRlVoLbzLiRDu/lfa/6EOmGY7WgwzQPF+djV7R+ZtxJIg4sKQK6QyOic+BPzx0/j3w7OdHLJWKHpe+Yu7lTqEUzR8BuYu/a4WkeWPLcMfF3jtlRshrhXAt+ye8mdKauGK0Lg3oVBDSwvCYb9c3FPMeygnYv6t+DeAe8CW7CrRZj6bwrA1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7M1gzhvG6GswJPG9aYpC1zq1WPzImlQJj12ejXFbCas=;
 b=iBmKi4FyZtTKuj0rwG2ccCMsh3NLiy2GaVWE93JgR4y5zQrNrbbbR8tlu2o5mfVGYVyGEGLbAqd10Kn4p8z5Z/qAVXm9mOBZDc1QtKIwTYbWTUrx4Q+RKIhkdumd8DPfSmZj4fWWZ24qU2Vs5IrDaPCW2vVie6f4Ne0E/RGrHLEpph1fhLVTzNE2ReJIB7Bg20//DRJteht2xbiAWZnn9edUhvOMra+6xLXwMQdg9umx/VrkFlR2Zl4IL/wbPBai3Si1XmsAYw2zIThUPnT3/mAB3rPX8a8jzCcF75wjc2eAh3eJuFE8JNHYTLyg/Vh/d/NHC/voQSGW0rytmvOGMg==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by DM4PR12MB6565.namprd12.prod.outlook.com (2603:10b6:8:8c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 11:15:26 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 11:15:26 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, Nathan
 Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, "wangzhou1@hisilicon.com"
 <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, 
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>, "Liu, Yi L"
 <yi.l.liu@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v6 00/33] hw/arm/virt: Add support for user-creatable
 accelerated SMMUv3
Thread-Topic: [PATCH v6 00/33] hw/arm/virt: Add support for user-creatable
 accelerated SMMUv3
Thread-Index: AQHcWiCazp4qsH43iU6000IVdgrRfrUXoOQAgAAPzgA=
Date: Mon, 8 Dec 2025 11:15:26 +0000
Message-ID: <CH3PR12MB7548A9B094B7E7CEBC1D1A58ABA2A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
 <IA3PR11MB91361CCD9C11FACB77057AB092A2A@IA3PR11MB9136.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB91361CCD9C11FACB77057AB092A2A@IA3PR11MB9136.namprd11.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|DM4PR12MB6565:EE_
x-ms-office365-filtering-correlation-id: 3a32871c-b005-4b62-65bc-08de364b16a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?WkN4Y2NSL09TNDl1aDRNUFlEVVNLdHN6L1g2SU1yUE9IRXFWMHRFTWEwdUov?=
 =?utf-8?B?RHU2aDl1Z1RTVkR3WUtpTU5peExUNGhMWkVXOTBHdW1ObTNNUHpteWRTVTZB?=
 =?utf-8?B?cnBvdERmeWFjRndmdy9iUUJmZ2owWFl1bkNGRUkrQU9yMy96UTNBQjF5V0tW?=
 =?utf-8?B?NW53K0tPSlFTdmpBY2ZubGVlU0c2M1g1ZTVZaTJCT0thWkVJL0NZNUdZSzBj?=
 =?utf-8?B?amdKYWVkbmVCc3JCZGU3dHdUSldGS2VlMXVmY3gyY1EyOUthd2JIS3BQY1M2?=
 =?utf-8?B?RVdMYzlHZS9tWi9wZUlrRmk3akFNb3ZCSnpyUmpESy9ZcWFPSHhyK21LYWpm?=
 =?utf-8?B?ZndHdC9lbVZhMElZOU05cEgycWNiNDJqeWt0THhRRis0dVZqandlOGM0N2pu?=
 =?utf-8?B?b3huaDhKQVRoRjJKTEp2K1hQMkRoaUZ0MzFYZ2Y2THlHZVZFa1ZHRUtFSVRk?=
 =?utf-8?B?aU1oczFwUHFWZU1rSXhYdEtScnMyQmwrMFVpZjhJRGRwTmdXTzQydUFNL0N6?=
 =?utf-8?B?RVlHNlBUOEdiVFFJRERGaUNmQVVMSHA2dVdQbHUxWGtxS0J4VGFwVTdCOUxv?=
 =?utf-8?B?Y1Iwd1JKSGsvSVFveVpFVWpTbWtBMndzaE1lUEkvSGtGRjE3UVNjdmVuZllO?=
 =?utf-8?B?MDVsY2UxL1d4YjVPUW9lK1VDSkNXTXdzbFRVSnVzVGx6QnlITDRPWGdRNzZr?=
 =?utf-8?B?OEhub09uMWQzbkJkWFpzcS9FOU9LNkR4OVdGbEcwakhrSlhMbzhqcFpRSmg0?=
 =?utf-8?B?b0U4aXdFTU5xTVZNUUhZZ3U1YnNqY3UxK2JscWRaWTdMdjJ0WURpT3o0Z2E3?=
 =?utf-8?B?dURZenh2bWNqNXVWR3cvR1ZBKzgrdjRYZUlQWGozNEc3ODUzdXpaY0d0K08r?=
 =?utf-8?B?ZUJEb2FUZ2hCNEd0NTdwUWpSN0RtYi9nUW9SbThvekZOa2lnVlBQdm05aU45?=
 =?utf-8?B?em4rQnpFUFRZVFZ6QmloY2xpeTNzNXgwSlAvQmloeUY1RnNheC9OOGxQWFc3?=
 =?utf-8?B?aDZva2JKZmE4TkhJOW92K1dsenJxcGdjWkZNTUpFekZMUVJ5c1BtZ09BUEsv?=
 =?utf-8?B?M0lpNVZrbFZvNGxUdHJHa3VYZjIzTkJZUElUamxlRDJEM2tsaHk1eVhVcFJU?=
 =?utf-8?B?Q1NUaElta0Z2dUJoalNlQXVMSXF2ZklLWXVCOWRGYTdHdjBneFdFcHZic1B2?=
 =?utf-8?B?V0ZkQXYzcWdkYjQxK2VtTU9LUW41dzlXYkNGTGxVOEswaXB3VEcrNWk4TGRL?=
 =?utf-8?B?YlJrSDZUbUJxY255S3VLd0FvOEo3V05KQmljdXJlRFlyc1c1THQ3RVpIbk5z?=
 =?utf-8?B?WTc3ZXFZcllYOTlkNnM5eXdoK0ZSeWJpaWRsK3RNbkFxN3F2WDhYb0U3a0Y0?=
 =?utf-8?B?bEpMcTQwRVQ5ZEZTNWtha0tqZ3RSOEprWHh5UWxobytlWlhONUJEZVdOTUl1?=
 =?utf-8?B?UWZoa24zR2IrYkk1NFYrMWhwUk91NGFlTVF0dVBuU1N1dnFzbTNZdE9nRFpW?=
 =?utf-8?B?MXF6dUEyTXk4NTFzb1dLTEVMSVplNlJIdDc3cjFoVlhoczdXWm9tUE9GTkFV?=
 =?utf-8?B?eWp5TUJ3YWNTK2FFQ2ZaTjdBaVBiM01tSHJpdWZRYzVlYUJvSnhHcGs2MHpj?=
 =?utf-8?B?d1JLWWVjTS9qMTY4U3dISnhhQTBIb2lJWERydjB0eE5SRVNlVnE1T29MYXhU?=
 =?utf-8?B?cndmU0VwYmRyVzNuU2hadjJrcWxLVVpPMENhdGoyRTBhY3VJVnlzM094eWR4?=
 =?utf-8?B?SUZ4VWNFZVh2WVgySVkxR0Jwck12NnF2c1p4RUwvS0JYeFhpd2dRMDd4YVpG?=
 =?utf-8?B?MzdETVIwR1FKV2U2Q2ZSd0NlaE5TdWlhZm9ZM2RFYzBsQ29GMGpYTmZlREdn?=
 =?utf-8?B?Qzl3dXBZRGRCRzhRVndOVUh1bk9qV2pIeEs3THVMeGxiOEVPSVgrMGJoenJO?=
 =?utf-8?B?T041T1hEbVNkUS94Q1dUOU5EdWZpcmthZEI0T2p4S1dWOXBRaHk5cktMTEJD?=
 =?utf-8?B?aURCL0N0STlxMHNaTGN5UGhpbTJrQVJ0RUJKcEdlclo5bDNQemk1a2dVRmVT?=
 =?utf-8?B?bDJrUXdWdHJZckUwMDJ6NmFRdHo3R1Y5WHd2dz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UlZTeUhNYkxVRmZsWis3MmxuUndsNVFKdXdFWEJXMVJXeHVHaTJFeVBnVFZI?=
 =?utf-8?B?Smg3Z2RiRkhoaFhrNGtDK0hyRmRhcW9YV3k4OUJFbE9GdkVueWw5LzRHeEpx?=
 =?utf-8?B?YTZZYTJzb0dMSVF4cFFGZDFWVmliYVlxUjRuU3RxUWkyK1dRbDZTUmpycnNm?=
 =?utf-8?B?SmtsNG5nRklSWmVucXJVUGVRUVJ4MmtTc000elNVdTZUQlI0dWcrWHRHWld1?=
 =?utf-8?B?Z091K1FlMHhxaWI1a21Yc0Q1SExuaVQ5ZEk4djRvWTYwVVByZDhxK05vK3RI?=
 =?utf-8?B?MW91cFVyZUVuYTlmVHE5VHBOWktFMXJtb0VpeEUxMTlOQ2dGdHVVQ2xZMktE?=
 =?utf-8?B?Umx0RXdodkh6VXM5bm95UzZaK3VXRUNwY1d0QllDU0lBNlcwdnhJVnJ2RjhV?=
 =?utf-8?B?TEZFa0kvbVhMdXVjcmp1NjRlaVJJY05sSDFtK29QdUdRNzJUMWpCeUJUQWxa?=
 =?utf-8?B?cXZFQXp5dlZUbUFzeW9IMmJoZ0x1YTRYRTdRUWhrMEI3ZlVTSHljR3E5YUE4?=
 =?utf-8?B?S1hSOUhNR2hhSDBpUkhsQkhGYlIrVUdsRGw4ZmZJRjVQTWpKUVdUM2FSKzRH?=
 =?utf-8?B?b1JyQlEycVNhc1dHMFZCOGxEa2xkT2k2Z3paZ2thR0VBeXV3WnFqOHBqQVFZ?=
 =?utf-8?B?d3JJQ2ZzejA1U21FRGZQbTcvV3Jua1JuSktNYUtMeXFOU2tPVWdzS0VZY3o5?=
 =?utf-8?B?THV5aGN3aHdhbk0wUkd5bFVCRkNTMnpZeGV2c1I3S1FZa3piWUEyeEZuaGtL?=
 =?utf-8?B?UWp3b0kwSk5WSmtMaUdEZXRtbmtnbWFjb3paK3prL0lwM0xKSWxnL3hSSENN?=
 =?utf-8?B?WVlMV3Jrb0dZQ2M5NE4zOVpUWnROWTh3aldORXlTN0tkbUkzOTRHK1g2RFdI?=
 =?utf-8?B?TTB6K0V4VGhWcEw4K2wxV0t0K1pLcTlWbjYrT0UrQVRRTUtXL2Qwalk3cWhN?=
 =?utf-8?B?aHJ6S0w5anR4bGs0aW9Ud3pLMkk4V2F4MDUxRUpsSk5iWS8zSkdNRlFXWEhR?=
 =?utf-8?B?aEljZHFoZy80MTljQnR6N29yTnpqRlhEUjU3QWROWGx4UlNJSWRrcXVuTWdt?=
 =?utf-8?B?dWJkR2tGenFQOUxMMitaVlVQRWlZU2lGMVR1N2p5OW9BSWNYU2NvWUlHZDZm?=
 =?utf-8?B?VThtU0NMc1ljTDV0RHN1NXFCSWVuRFp4L25ad2pXUElmT0FNK1puWEQxZEwr?=
 =?utf-8?B?dGRmSkZsUTFWVGZFbUphc3VhdXRzMW1zRzQwN1h2MlNnbW1XbWxhdWQ1MXBB?=
 =?utf-8?B?L1k4Ni9xdW1VdXVqQlNydGlLaGY5ZFhZNzdLeTVJZ3pGKytuRSs1ZUhMNHFn?=
 =?utf-8?B?UmduWkFQS3pWcDEvYkN3TGxtS2FUQ3pRVEVzMnhmbTNVd1RvMkx2MTJ5em9i?=
 =?utf-8?B?QlQvM2MwbStGL3hpK3UvQ01wdmNqMVdlemhzQzExZnFUb3ZZMzU1S0lnSWl5?=
 =?utf-8?B?K3kwRFVpYUVzUGRRZ2pBWUpDS0hRSkRBRERnTTBhcmRhcVg0d0czK2w0Q2hQ?=
 =?utf-8?B?V3pXMGk4akQxcG1oUzVoQ1kzYWFpSDVqSmg3TjhOY3Q0QXhJeWV5Y0toek10?=
 =?utf-8?B?Rnpua1VUZGRocUFySDlDOFlnVmtqejNvSTRjYnRXMUJsb2VqcUE5cVJjaXdy?=
 =?utf-8?B?VUFMN05GQ0tIWUFHVW5PNEFJUUgvZXN5TTg4UVZrakx6Y3FCMVZ4K1pxSUI2?=
 =?utf-8?B?aEEzVHhPSWticmtKWVFsdk1CRlVuYzhFanpaU3RWNVF5dEFsK0w4bTlFZlFi?=
 =?utf-8?B?QmM2Q1k3YjV2TngrekVsTXA0RS9tN1hvVklJbEEvbjFLNzJzdjRiL3lLQWtW?=
 =?utf-8?B?MTF3WUJOSWJCN2l4UG90N3BYUitxRnd0OE5YVWh3OWlYaEkvem40Tk5JWDcw?=
 =?utf-8?B?V2I5eFo4bGU1aDgrdHBjbUFtbDNVTmp4a2Y3NEp5TGgydmZ3eS9XUVJCdkE5?=
 =?utf-8?B?RVFXa0pKVXRPbW5Ga002VHdTUFNlOEpHdk9FckE0UHJYWVZDU0ZVQkhCZGd4?=
 =?utf-8?B?SG9YMUMwMW4wdHExR2orY0tsek1ISjhUK3FiSjNROE5Ld2ptT21WS0JoNDMx?=
 =?utf-8?B?RnhhSDN5QktQeERPeHN6aTMzbVhOS0FJVG93MDZxcS84NUMyRXNjY2lJYXR3?=
 =?utf-8?Q?uJmLGBsXyxch+1limplm0NzW7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a32871c-b005-4b62-65bc-08de364b16a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2025 11:15:26.3248 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yAGMs7iQvt3qbC+ZgzQiE8oKLGAVjg6Y4Zi6fxTKHa6IYoIIToFWly4ygklKJfUr5GVkRa12vBl7AJBGpsnZgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6565
Received-SPF: softfail client-ip=2a01:111:f403:c10d::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1.997, SPF_HELO_PASS=-0.001,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRHVhbiwgWmhlbnpob25n
IDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+IFNlbnQ6IDA4IERlY2VtYmVyIDIwMjUgMTA6
MDgNCj4gVG86IFNoYW1lZXIgS29sb3RodW0gPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPjsgcWVt
dS0NCj4gYXJtQG5vbmdudS5vcmc7IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogZXJpYy5h
dWdlckByZWRoYXQuY29tOyBwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc7IEphc29uIEd1bnRob3Jw
ZQ0KPiA8amdnQG52aWRpYS5jb20+OyBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+
OyBkZHV0aWxlQHJlZGhhdC5jb207DQo+IGJlcnJhbmdlQHJlZGhhdC5jb207IE5hdGhhbiBDaGVu
IDxuYXRoYW5jQG52aWRpYS5jb20+OyBNYXR0IE9jaHMNCj4gPG1vY2hzQG52aWRpYS5jb20+OyBz
bW9zdGFmYUBnb29nbGUuY29tOyB3YW5nemhvdTFAaGlzaWxpY29uLmNvbTsNCj4gamlhbmdrdW5r
dW5AaHVhd2VpLmNvbTsgam9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tOw0KPiB6aGFuZ2ZlaS5n
YW9AbGluYXJvLm9yZzsgTGl1LCBZaSBMIDx5aS5sLmxpdUBpbnRlbC5jb20+OyBLcmlzaG5ha2Fu
dCBKYWp1DQo+IDxramFqdUBudmlkaWEuY29tPg0KPiBTdWJqZWN0OiBSRTogW1BBVENIIHY2IDAw
LzMzXSBody9hcm0vdmlydDogQWRkIHN1cHBvcnQgZm9yIHVzZXItY3JlYXRhYmxlDQo+IGFjY2Vs
ZXJhdGVkIFNNTVV2Mw0KPiANCj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcg
bGlua3Mgb3IgYXR0YWNobWVudHMNCj4gDQo+IA0KPiBIaSBTaGFtZWVyLA0KPiANCj4gPi0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID5Gcm9tOiBTaGFtZWVyIEtvbG90aHVtIDxza29sb3Ro
dW10aG9AbnZpZGlhLmNvbT4NCj4gPlN1YmplY3Q6IFtQQVRDSCB2NiAwMC8zM10gaHcvYXJtL3Zp
cnQ6IEFkZCBzdXBwb3J0IGZvciB1c2VyLWNyZWF0YWJsZQ0KPiA+YWNjZWxlcmF0ZWQgU01NVXYz
DQo+ID4NCj4gPkhpLA0KPiA+DQo+ID5DaGFuZ2VzIGZyb20gdjU6DQo+ID4NCj4gPmh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNTEwMzExMDUwMDUuMjQ2MTgtMS0NCj4gc2tv
bG90aHVtdGhvDQo+ID5AbnZpZGlhLmNvbS8NCj4gPg0KPiA+IC0gQWRkcmVzc2VkIGZlZWRiYWNr
IGZyb20gdjUgYW5kIHBpY2tlZCB1cCBSLWJ5IHRhZ3MuIFRoYW5rcyB0byBhbGwhDQo+ID4gLSBU
aGUgcHJldmlvdXNseSBzcGxpdCBvdXQgX0RTTSBmaXggbWluaS1zZXJpZXMgaXMgbm93IGFjY2Vw
dGVkIFswXS4NCj4gPiAtIEltcHJvdmVkIGRvY3VtZW50YXRpb24gYWJvdXQgdGhlIHJhdGlvbmFs
ZSBiZWhpbmQgdGhlIGRlc2lnbiBjaG9pY2Ugb2YNCj4gPiAgIHJldHVybmluZyBhbiBhZGRyZXNz
IHNwYWNlIGFsaWFzZWQgdG8gdGhlIHN5c3RlbSBhZGRyZXNzIHNwYWNlIGZvcg0KPiA+ICAgdmZp
by1wY2kgZW5kcG9pbnQgZGV2aWNlcyAocGF0Y2ggIzEwKS4NCj4gPiAtIEFkZGVkIGVycm9yIHBy
b3BhZ2F0aW9uIHN1cHBvcnQgZm9yIHNtbXV2M19jbWRxX2NvbnN1bWUoKSAocGF0Y2gNCj4gPiMx
MykuDQo+ID4gLSBVcGRhdGVkIHZTVEUgYmFzZWQgSFdQVCBpbnN0YWxsYXRpb24gdG8gY2hlY2sg
dGhlIFNNTVUgZW5hYmxlZCBjYXNlDQo+ID4gICAocGF0Y2ggIzE0KS4NCj4gPiAtIEludHJvZHVj
ZWQgYW4gb3B0aW9uYWwgY2FsbGJhY2sgdG8gUENJSU9NTVVPcHMgdG8gcmV0cmlldmUgdGhlIE1T
SQ0KPiA+ICAgZG9vcmJlbGwgR1BBIGRpcmVjdGx5LCBhbGxvd2luZyB1cyB0byBhdm9pZCB1bnNh
ZmUgcGFnZSB0YWJsZSB3YWxrcyBmb3INCj4gPiAgIE1TSSB0cmFuc2xhdGlvbiBpbiBhY2NlbGVy
YXRlZCBTTU1VdjMgY2FzZXMgKHBhdGNoICMxNikuDQo+ID4gLSBHQlBBLWJhc2VkIHZTVEUgdXBk
YXRlIGRlcGVuZHMgb24gTmljb2xpbidzIGtlcm5lbCBwYXRjaCBbMV0uDQo+ID4gLSBWRklPL0lP
TU1VRkQgaGFzIGRlcGVuZGVuY3kgb24gWmhlbnpob25nJ3MgcGF0Y2hlczogNC81LzggZnJvbSB0
aGUNCj4gPiAgIHBhc3MtdGhyb3VnaCBzdXBwb3J0IHNlcmllcyBbMl0uDQo+ID4NCj4gPlBBVENI
IG9yZ2FuaXphdGlvbjoNCj4gPiAx4oCTMjY6IEVuYWJsZXMgYWNjZWxlcmF0ZWQgU01NVXYzIHdp
dGggZmVhdHVyZXMgYmFzZWQgb24gZGVmYXVsdCBRRU1VDQo+ID5TTU1VdjMsDQo+ID4gICAgICAg
aW5jbHVkaW5nIElPUlQgUk1SIGJhc2VkIE1TSSBzdXBwb3J0Lg0KPiA+IDI34oCTMjk6IEFkZHMg
b3B0aW9ucyBmb3Igc3BlY2lmeWluZyBSSUwsIEFUUywgYW5kIE9BUyBmZWF0dXJlcy4NCj4gPiAz
MOKAkzMzOiBBZGRzIFBBU0lEIHN1cHBvcnQsIGluY2x1ZGluZyBWRklPIGNoYW5nZXMuDQo+ID4N
Cj4gPlRlc3RzOg0KPiA+UGVyZm9ybWVkIGJhc2ljIHNhbml0eSB0ZXN0cyBvbiBhbiBOVklESUEg
R1JBQ0UgcGxhdGZvcm0gd2l0aCBHUFUNCj4gPmRldmljZSBhc3NpZ25tZW50cy4gQSBDVURBIHRl
c3QgYXBwbGljYXRpb24gd2FzIHVzZWQgdG8gdmVyaWZ5IHRoZSBTVkEgdXNlDQo+IGNhc2UuDQo+
ID5GdXJ0aGVyIHRlc3RzIGFyZSBhbHdheXMgd2VsY29tZS4NCj4gDQo+IEkgc2VlIFBBU0lEIGNh
cGFiaWxpdHkgaXMgZXhwb3NlZCB0byBndWVzdCBidXQgbm8gcGFzaWQgYXR0YWNobWVudCBpbiB0
aGlzDQo+IHNlcmllcy4NCj4gV2FzIHRoZSBuZXN0ZWQgaHdwdCBhdHRhY2hlZCB0byBTSUQgaW5z
dGVhZCBvZiBwYXNpZD8NCg0KSW4gQVJNIHdvcmxkIHRoZXJlIGlzIG5vIHNwZWNpZmljIFBBU0lE
IGF0dGFjaG1lbnQuIEFSTSB1c2VzIGEgQ29udGV4dA0KRGVzY3JpcHRvciAoQ0QpIHRhYmxlIGlu
ZGV4ZWQgYnkgUEFTSUQoc3Vic3RyZWFtIGluIEFSTSkgd2hpY2ggaXMgb3duZWQgYnkNCkd1ZXN0
LiBIZW5jZSwgbm8gc3BlY2lmaWMgUEFTSUQgYXR0YWNoIGhhbmRsaW5nIGlzIHJlcXVpcmVkIGlu
IFFFTVUuDQoNCkhvdyB3YXMgcGFnZSBmYXVsdA0KPiBoYW5kbGVkIGluIHN0YWdlMT8NCg0KSWYg
eW91IG1lYW50IFBSSSBDQVAgdGhhdCBpcyBub3Qgc3VwcG9ydGVkIHlldC4NCg0KSG93ZXZlciwg
WmhhbmdmZWkgaXMgbWFpbnRhaW5pbmcgYSBicmFuY2ggdG8gYWRkIHN1cHBvcnQgZm9yIGRldmlj
ZXMgdGhhdCBzdXBwb3J0cw0KU01NVXYzIFNUQUxMIGZlYXR1cmUgYW5kIGhhbmRsZXMgUzEgcGFn
ZSBmYXVsdC4NCmh0dHBzOi8vZ2l0aHViLmNvbS9MaW5hcm8vcWVtdS9jb21taXRzL21hc3Rlci1z
bW11djMtYWNjZWwtdjYvDQoNClRoYW5rcywNClNoYW1lZXINCg0K

