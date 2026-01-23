Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE60DD77881
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 16:59:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjKVe-0005vW-5B; Fri, 23 Jan 2026 11:59:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vjKVb-0005fm-6t; Fri, 23 Jan 2026 11:59:43 -0500
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vjKVY-00029e-Ii; Fri, 23 Jan 2026 11:59:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xg9XVkYCkdXk2nvhcJYJs9MaHCW+q/AWl3ISNV4Sa37RVBSHsojffJR7qhYcduWvk7dk3Kboe04GTtpWyhBuDs7SxiXhkTippSM+6f04JcjPFPFxaA3lmA6dwdrftcb/2k3Jzd0gX1nSoCDUd6GBUYb1A4f8IMNyzwNdaIVB6JqfWdpzFBg9Z731UJYdg2evezXFgKkp7Ih8ZBWiLGtv7pKTMDKVZZreCn9hodDQP3YWzod/SFFnFrqVfdwicDPfIcZDnXXGB5w/rtMOiTSkpBHcCgZAj06q35w7tMH6k+aDbHXlT/hpR4fKnh1SQAGr3/RWUkRAXqKBIL/HkxIt2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0ryoOXmstM10nsU5Dk7t+Sp6JeTtmLPqwzO00YWpE8=;
 b=K/v3kQh9Vj66JVcRu4kM+YTPjQdU+cVuCIStyfYDD6NVZbmpwhW8GC/++0piqwFDJ8nO8X3laIUrzQpfyC3lSixD1w+aiYqD5LXFBZf8yyrRlZvRHH45miysbnxcb0Ksd0o+NWLZP72q31NdLBejtXML+3aSEl6yR/ToJwhyxdHE1urN1EawnQaCSxkHT9UuAmofNz19fwWxVrRr9PMU9sqHB/waS3BuHJNCcivVuoB4pfO/WxxnjN9ljdwYIPHHqpO1GovdwHAbI8kv7yJj0EhBEO8RH7Cjcw6gPuLYbyVP8qqIdSsqr3tKP8zobzIrb27iQMJuvZoC4cc7bATlNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0ryoOXmstM10nsU5Dk7t+Sp6JeTtmLPqwzO00YWpE8=;
 b=NL1TcqTgAYWpujtlkONgjrW8LJ9qXfqgC1j2InEyMKEB/aUt69sxSlFCpPQN1a4e6gJxsIwWyJ8F09E51iMyhVq8AtSRRURn6kUdYba/Bajo5y2dQTeYYrU9CHhOfQucpe+gIKeRoOi8PM+qCPUoIG74+mXTXjeyvKVuoRsrmJD0FiEWf9HlSpEnX2q1+Wlf2nqRSL78EkTw07Yj6cFpNMgS9dRGl2rNEMAuB+BKNWTaFQ7WxNxQJoCMmjR5qa+zab13hA9JbtjZhRwYr1uFrvCL0OueIjZqsBC/jDW2mJWhA8NOWEoDqd7442gUQ8elJishe+e2DI4Te53H//nv8w==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CH2PR12MB4231.namprd12.prod.outlook.com (2603:10b6:610:7d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Fri, 23 Jan
 2026 16:59:33 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 16:59:33 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: Jonathan Cameron <jonathan.cameron@huawei.com>, Eric Auger
 <eric.auger@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Richard Henderson
 <richard.henderson@linaro.org>, Jason Gunthorpe <jgg@nvidia.com>, Nicolin
 Chen <nicolinc@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v8 00/37] hw/arm/virt: Add support for user-creatable
 accelerated SMMUv3
Thread-Topic: [PATCH v8 00/37] hw/arm/virt: Add support for user-creatable
 accelerated SMMUv3
Thread-Index: AQHciv8RXDVv9+SEiEKA20nh1wOeY7VfZT0AgAA/SYCAAAStgIAAAURAgAAzGICAAAaFgIAABVUAgAARidA=
Date: Fri, 23 Jan 2026 16:59:32 +0000
Message-ID: <CH3PR12MB75481DCD5A4A890617429C55AB94A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260121175248.87649-1-skolothumtho@nvidia.com>
 <4d1a883b-5465-45af-8dcc-eb905f552c29@redhat.com>
 <20260123114149.000065c5@huawei.com>
 <CAFEAcA8RFqO-U5ayU2u=dNhjHCj=1mJiAv26QihfqNfqQVq1Lg@mail.gmail.com>
 <CH3PR12MB75480D0CDE889070E1F4C448AB94A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <CAFEAcA_8Zd1_C+94wj2c+pJk3ebFT5_Zgt1Ww0qxzFqW=F98xA@mail.gmail.com>
 <CH3PR12MB75482DA817149816D5CD485EAB94A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <CAFEAcA_w=+RHygwsSQVvE6XU44d6+hgKy=bqdD08aBM5_xyn=Q@mail.gmail.com>
In-Reply-To: <CAFEAcA_w=+RHygwsSQVvE6XU44d6+hgKy=bqdD08aBM5_xyn=Q@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|CH2PR12MB4231:EE_
x-ms-office365-filtering-correlation-id: bb2f55b3-160c-440c-6642-08de5aa0c7fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?R2FZRHgwdmY0ZGxUajFETFhFRXV3ZEc2RkdRLzNXeTdqb2FjSFZMc3kxM1pt?=
 =?utf-8?B?K2ZCK1E4SnU0UkVNQ3BlWDFZWU1YNVF6a2U2MlN4TUhyU05jOXFyTUdHSXFZ?=
 =?utf-8?B?NEFxSmVVcmtWNFREOXI5bGFuWCtRVWRUMERCWU8vazBscithMXNTeCthM25U?=
 =?utf-8?B?dXNJSmhPUVFSTExmT1hnMHhJQmFXQ1QwcU9mcVR6V09UQkNyaTZRMHJCVmZt?=
 =?utf-8?B?RnRlYjZmUUdGVEt1bW1nK3JuZlFBa1UyNjNkblNBenJuV2l3TGpTUXM2UGJQ?=
 =?utf-8?B?M0JzblF1WTFTSXRZQmFRUEJXZ2d0ZFkxb0NNWGU4SXdQWUJYczVFTmsvTnVT?=
 =?utf-8?B?eWtxOFU2MXhMWWYxOE1PeVZRMW5zbzRPM3pRdjF3Wk9wYmxNV25tTDhjU2VW?=
 =?utf-8?B?TmlHazdVWERKVU5XR1F1QllSMWc4b25zUis3N08rRW03Y0RXQXFBNUxmeHBF?=
 =?utf-8?B?UVNXalA2SHYweTlZL01LQWhNS2NaY00wazFCR0dwbWJrdU5OcnVRL3NoRUtO?=
 =?utf-8?B?TTQ0WlhPRDRhUzhOUnBPcDYyMmZ6WjkyWkc1TWF5WXpLazFjVkNCS2VPaGF5?=
 =?utf-8?B?K1BGRTBhWXlJemc1WFNwOWg0SFNNT2lqclRDV2ZEQUM3R2QwdGU2YWpmd2xD?=
 =?utf-8?B?MVBNcW8yUXFJVnRiVEYycVluWVJ4OWlWZmd5SC9kRzhxdFFrUlM5RUMwdmw2?=
 =?utf-8?B?elB0aWNQZTBNL1lvcW5Gd3FwdWl4UklZZk9veFRMYmozYk9PME4zVHpKL3hl?=
 =?utf-8?B?MnVnNTFrUXpyTGNOSTJ3VjQzeURaUU5kVXd6QXBCbDRTWWJxSUcxcE5sNnAw?=
 =?utf-8?B?cHJWaDgxcEZocmJCa0xQTVQrcDZFMmxkTGovTVM5aFpyUnBkVzB5KzhsVWpW?=
 =?utf-8?B?RC9SNDVNU1JmOU04SHpYb2JZZjZXVnBTblBBL2tUSGFNcjZDVlpRTSs2YjdW?=
 =?utf-8?B?V0tkSm5OZzJDWkhSWWxlbHBqa29MenJ0aTRSdllWaCttcWpERm9CSlExeThP?=
 =?utf-8?B?TnpQcXhXZzM2OTl4aTcyYUh4M0g1SXlWak9NcU1ON1pNbHVuL3VLSDYrTGRp?=
 =?utf-8?B?YXhlNk8xOVZ2NDY2VTlJSm0zdVk5WTZCRmJxVGtwSnVBdmg1dU9CeldmQUxt?=
 =?utf-8?B?T2VSU3BCRXJUWmt1aGJCbEZ3a09xS3hHc2xmbGF3U05YdEphQXVSU25TbnJx?=
 =?utf-8?B?dUp2OHNCeEM1QTNDQVYxWTk3ZWV6MEJKL0ZyMGxCR0ZrRFMwcDZGb2QzUVc0?=
 =?utf-8?B?THVVaC9CejFDRzI4WDVYN3M3Tk5Ha1lsNlJEMjdmVkl4REVDTFdWM01HTG56?=
 =?utf-8?B?M1VtVUt2eXNnMlJpT1F6SG1ldzJkTXpHd2g3aUpSbkJzZXltMTJCOFh5d0s5?=
 =?utf-8?B?cjlrYWRibm9pT0VOKzUrZjF3MkpsTTRtRnFiTEROVFpQNEFXb09uazlRVjIr?=
 =?utf-8?B?OWk0RzN4MkRaR25DYjVEMXhHUlhFTy9LaWFwQi9hMEQvejhoM1dZL1hoVFIr?=
 =?utf-8?B?OGxzSkxlektxTkJCazc0Z3dMdkV4OGt3MUVuckQ5MDhPdkdTQ3pSUmdZdlNi?=
 =?utf-8?B?aVFSV0psSGJhVGV4L3RQUmNzT25CTUJBK3ZNeXlEZXp1eDVrazJuUDI1dmdB?=
 =?utf-8?B?SHBYam9ubmhucUdHQ0I0aHdSeEJKVi9HbkFzTk1sRVF2Z09uWnFWYzhnLzgv?=
 =?utf-8?B?SnlHNnJtZ1E4UUJHdXdQc1J1Y3dqS2x2djVSOVZod0c5dUc0QVFTcERMaFRo?=
 =?utf-8?B?b0hNbktETXN1eUN5M1RxRU5PWjJuMjhxK3dEQ2ErSk1IVTk1QkJvNzdlVGpy?=
 =?utf-8?B?c0dsUGdkblhEenN2b3NMUkN0aGJPRlhyUlJ2LzJNRzg4TzRVQmRlNmVhZVZU?=
 =?utf-8?B?aXZNazJYU0lxWWZoVm1FMnpSU3lqYk5HWkNFS24yZUY0YW9QbDlabGlUTjEy?=
 =?utf-8?B?cUkwY0hYRGp0cEJvdHB3YWZEYWdyeEQrUzFhN1dJUU50RWswdWtNTnJsMk11?=
 =?utf-8?B?M2ZvdlF2NCtZeE52b1VGWmRYWFJ3WDZFamxVYTdnQ3VuclcxeWVHOHEzb2No?=
 =?utf-8?B?cHduaTdiMUU3RUQyTEpQbmhXeVRmV2tYNFByeWdYczFsVVY1T2Uxc0tSVFVq?=
 =?utf-8?B?ZXlhQ0dPYTVXRWxETGZKcjF0cnVVcTl4UGRuZS94ejRjekxnVDhWa1ZSaUUy?=
 =?utf-8?Q?RAqMdNLaiS+JlAQ36FH4ua0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXY1MnBwK1BkYVg5OU5KeHRJN0RKbFZIdWx6UDVqNzZIcEhteEFLVXlvalBT?=
 =?utf-8?B?bHFRdUJpVmxjTVlwNE4zSi9XdjE4UHBOZWJ2L2FCb3lLS3ExQU5UZzhPd0s4?=
 =?utf-8?B?SWd2RWQ2aVM0eVdKSEx4WUtmdVlqLzhYeDR3VWRFUmJ5TWxnWHFzbmRySzNP?=
 =?utf-8?B?NWI4ZkZHcGVNWDhPTVIwSzJyRWxNSy9rYUlHNkN4eW1YbmQ5Qy9LRzFobExR?=
 =?utf-8?B?NEE4UUFjcVBEd2VHb3hWc01oOGo5dS90eGtnQXc0SFk2VkJQVjllcHN6ZlVU?=
 =?utf-8?B?SEUzdFVCa1h2bGs0ZGxnNFFyQW9EODhJRVE4V0s0bXJuWHBPejdhU0lPTTV4?=
 =?utf-8?B?T0dFRjBKaCszYU1MajA4OWcyQ1QvQ1dJUGdSNnBIaTEyb1FjRXI2VWVLZ1Z2?=
 =?utf-8?B?MVVrVHllVWZmaC9DN0pmWGx0NVY3VXZEUmtLTUhsUjJQbXhRcjZsQ2kwaDdr?=
 =?utf-8?B?REZuTHZOVnhaS2d1US9kRVU3MkdVRXYrcUV2UjQ5RTJ3U1dPZmd2Nkl1NmNZ?=
 =?utf-8?B?WWw0SU5neHh0dW55emxQZit3M0hiSDhOQzhjK0V2YitzYnEvSUFKRVEwakhm?=
 =?utf-8?B?Z09MYzYyYzZBN3Ivek1nRXNacjgwbWxCdER6TjFsOGQwT1VRQU9zeDJvNWJw?=
 =?utf-8?B?SzBNaU8ydWt1T2dpa0drek1RRExMRWgxZ0w0dTRVbjgweWZ0TkowcitJQS92?=
 =?utf-8?B?TGFicFRmV3FGOE03bmRlSHp5ZkZ5dHhwYndPNTltMUJOWUpDL3VxbWZZeGxU?=
 =?utf-8?B?Tk5VRWViWlcwbHZWUWNpc1d3MW9GbnVvandqRDNHOUJXTHFIaCs5bm1uVjUw?=
 =?utf-8?B?dS9TUVVkVVQ2dlBERjh3MmxsTHNnbVpjVzNURVkvRHJ0R1NCTDNQbi9UbE1I?=
 =?utf-8?B?SkVlanUxS1Y0Y1dETWRrWXZSa3NmTVpGYUQvMjl4WUx0Q3k4am5QNlBaQTJ5?=
 =?utf-8?B?bmhmdHZWSXY4SGZFcmJwS0pSUUp3dlBaQ1RQTnBHdzdpRmFmSFBjbU1GNm1j?=
 =?utf-8?B?SUo4WHc4WS9HU1dmNHhnYnBuNjVQNk12dU80YU1TQ1RIc0VLOWtJbUNnQ0Rm?=
 =?utf-8?B?OS9hVWMwQ00xZHAvL2VyUEt0a0NLcmtNbUZpajl0Vkdab0xLNW8raTV1NEcr?=
 =?utf-8?B?RHZpQW9FWjNsWkVYeG03Z2Y2WXNMc2JzSG5KdVBpUm8zL2hBTDZLQWVoa1B0?=
 =?utf-8?B?TnpvdytnR3F3c3FjVzB6RFNvYWk0djdtUk5vNjdzR1Z6cU41djA4Zk80Y0Yy?=
 =?utf-8?B?OFRxa0tTdERicDNEZjZFazdtQk9KYlNrK1lGZlU0bnJFMDJUazNzVkExZzg3?=
 =?utf-8?B?MHhydGxkdmZSd2FUaXNXakNKK3FPRFVQejhMMkdTTnllYkszZ3YvUXI0Y0Jk?=
 =?utf-8?B?eXI5WXVySWVaZmpjdVp4TzQ1bXN4ZjB2cEVmZ1diVmJWOUExSGYvSENSZnFn?=
 =?utf-8?B?QTBpL1BmWFN6Z200MGYzTWdHc3BVd1hlekVsMVFaUldVZzh2UWVMQnc2T3lR?=
 =?utf-8?B?OXpYK2xSb0NHdk1pZ1Arb1h6K0plQUpnMkk2YUVtZGZmMlp2S2w0SVY0Y3dP?=
 =?utf-8?B?RE9EV205NFZSY3k2d3RLaUZ5UXU1bFVxZUhseE1kQ0tHbWk5dG16UGZWb3py?=
 =?utf-8?B?QUsrNlJ4U0R1NnFaVEMya1B6ajd1VGZ6Vzh5MHNtSlduc09HLzVkNHBxTnQ4?=
 =?utf-8?B?OE1yRjF4V281UVd5U1lNZktFU1JWSTlIWWE0dTdEODhsWk5udWFUbFdUbUI5?=
 =?utf-8?B?NlJGRGdLQ1FFcEhFYmR4MFFiTUJac3kxdEw5Z05FbHo4bDZTMWZ0WHNYQlpq?=
 =?utf-8?B?dkI2MmFNdDN4eGRVbGJUQmQ5Szlqa1R5dnM0Ym03ejljbnJBUW1qNTBZYXdo?=
 =?utf-8?B?eVRVZjM3RHBnajUyWGFRT08xd2puMHQ3VzZUUk9vL1I1NThUZ0dCZVVheTI4?=
 =?utf-8?B?RTZYTmlWSS9HSjM3c29XMEExYVRaRUVqMnRPNnBlU3hNL1YyWE5IelhNR0k0?=
 =?utf-8?B?MnNzZm5hZ29BWDJFM01ocmI3eU55cU9Pdy96bW52VFJCVXpYZkRGM25Xc29K?=
 =?utf-8?B?OWpGTTM4WVh4a2Y5cytjd0pWcHJaMVRoaXFHbktNUDU0MW5reEUzSGZaeExu?=
 =?utf-8?B?aDd1c2IzVUJhUXBKNUdadU1UMGFwb2owc1hkTFBnYXlkRWRCMnhJcVJKdytk?=
 =?utf-8?B?MTJZNExwblFKZ0wvYmtxaHBjTGVES3M5L2xna3F4SjF2RGN1REpFcXdjQ0NU?=
 =?utf-8?B?UVVvUVR0ZWl5WHVWZExhdG9VRHB3YWFpUmFuaEJKTDdhcnB4cTh0Q3p6aWsr?=
 =?utf-8?B?NlhvbmV4azRIaW5FaXVuWGV1UzdQMWM3c0RsMDdBanBjMkYySWxUQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb2f55b3-160c-440c-6642-08de5aa0c7fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2026 16:59:32.9486 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rKaYdY4mbjTVfFaDIZ5F4Hezvfpe8XrsgWImvTLQwk8OQqfN/9vzq3K1Z37BmUNzFBNNS3W8o7hstH5xdhLn8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4231
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.079,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGV0ZXIgTWF5ZGVsbCA8
cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPg0KPiBTZW50OiAyMyBKYW51YXJ5IDIwMjYgMTU6NDgN
Cj4gVG86IFNoYW1lZXIgS29sb3RodW0gPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPg0KPiBDYzog
Sm9uYXRoYW4gQ2FtZXJvbiA8am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPjsgRXJpYyBBdWdl
cg0KPiA8ZXJpYy5hdWdlckByZWRoYXQuY29tPjsgcWVtdS1hcm1Abm9uZ251Lm9yZzsgcWVtdS0N
Cj4gZGV2ZWxAbm9uZ251Lm9yZzsgUmljaGFyZCBIZW5kZXJzb24gPHJpY2hhcmQuaGVuZGVyc29u
QGxpbmFyby5vcmc+Ow0KPiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPjsgTmljb2xp
biBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPjsNCj4gZGR1dGlsZUByZWRoYXQuY29tOyBiZXJy
YW5nZUByZWRoYXQuY29tOyBjbGdAcmVkaGF0LmNvbTsNCj4gYWxleEBzaGF6Ym90Lm9yZzsgTmF0
aGFuIENoZW4gPG5hdGhhbmNAbnZpZGlhLmNvbT47IE1hdHQgT2Nocw0KPiA8bW9jaHNAbnZpZGlh
LmNvbT47IHNtb3N0YWZhQGdvb2dsZS5jb207IHdhbmd6aG91MUBoaXNpbGljb24uY29tOw0KPiBq
aWFuZ2t1bmt1bkBodWF3ZWkuY29tOyB6aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZzsNCj4gemhlbnpo
b25nLmR1YW5AaW50ZWwuY29tOyB5aS5sLmxpdUBpbnRlbC5jb207IEtyaXNobmFrYW50IEphanUN
Cj4gPGtqYWp1QG52aWRpYS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjggMDAvMzddIGh3
L2FybS92aXJ0OiBBZGQgc3VwcG9ydCBmb3IgdXNlci1jcmVhdGFibGUNCj4gYWNjZWxlcmF0ZWQg
U01NVXYzDQo+IA0KPiBPbiBGcmksIDIzIEphbiAyMDI2IGF0IDE1OjMzLCBTaGFtZWVyIEtvbG90
aHVtDQo+IDxza29sb3RodW10aG9AbnZpZGlhLmNvbT4gd3JvdGU6DQo+ID4gPiBzdGRlcnI6DQo+
ID4gPiBhY3BpLXRlc3Q6IFdhcm5pbmchIElPUlQgYmluYXJ5IGZpbGUgbWlzbWF0Y2guIEFjdHVh
bA0KPiA+ID4gW2FtbDovdG1wL2FtbC03UVFWSjNdLCBFeHBlY3RlZA0KPiA+ID4gW2FtbDp0ZXN0
cy9kYXRhL2FjcGkvYWFyY2g2NC92aXJ0L0lPUlQuaXRzX29mZl0uDQo+ID4NCj4gPiBBbnkgd2F5
IHRvIHJldHJpZXZlIHRoZXNlIGZpbGVzPw0KPiANCj4gVGhleSBhcmVuJ3QgaW4gdGhlICJqb2Ig
YXJ0aWZhY3RzIiwgYnV0IHlvdSBjYW4gcHJvYmFibHkgZG8NCj4gYSBwYXRjaCB0byB0d2VhayB0
aGUgQ0kgam9iIHRvIGFkZCB0aGVtLCBwdXNoIHRvIHlvdXIgb3duDQo+IGdpdGxhYiBmb3JrIG9m
IFFFTVUgdG8gaGF2ZSBpdCBydW4gdGhlIENJLCBhbmQgdGhlbiBsb29rIGF0DQo+IHRoZSByZXN1
bHRzLg0KDQpJIGZvcmtlZCB5b3VyIFFFTVUgR2l0TGFiIHJlcG8gYW5kIHB1c2hlZCBteSBzZXJp
ZXMgaGVyZToNCg0KaHR0cHM6Ly9naXRsYWIuY29tL3NoYW1pYWxpMjAwOC9xZW11Ly0vY29tbWl0
cy90YXJnZXQtYXJtLm5leHQtc21tdXYzLWFjY2VsDQoNCkhvd2V2ZXIsIEkgYW0gbm90IHNlZWlu
ZyBhbnkgQ0kgam9icyBydW5uaW5nIG9uIG15IGZvcmsuIEluIHRoZSBzZXR0aW5ncyBpdA0Kc2hv
d3Mgbm8gYXNzaWduZWQgcnVubmVycyB1bmRlciBTZXR0aW5ncyBDSS9DRC9SdW5uZXJzLCBzbyBp
dCBsb29rcyBsaWtlDQpDSSBpcyBub3QgZW5hYmxlZC4NCg0KVEJILCBJIGFtIG5vdCB2ZXJ5IGZh
bWlsaWFyIHdpdGggR2l0TGFiIENJLCBzbyBJIG1heSBiZSBtaXNzaW5nIHNvbWV0aGluZw0Kb2J2
aW91cy4gSSB3aWxsIGhhdmUgYW5vdGhlciBsb29rIGF0IHRoZSBzZXR0aW5ncy4uLg0KDQpUaGFu
a3MsDQpTaGFtZWVyDQo=

