Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4899EB7EA3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 08:27:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxhZW-0004KW-Nw; Wed, 04 Mar 2026 03:27:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vxhZV-0004Jm-BP; Wed, 04 Mar 2026 03:27:09 -0500
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vxhZT-0003Ub-Go; Wed, 04 Mar 2026 03:27:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KoxvfJ1+i3YWYBzef9lUeQfUA0igr2vf+b3zqeDjI8QNWWEYvGf0GbUHxdpNieXW6LzisC5W6m9EALs3FJDuIKdpBL6uwrkKP1YIi/Qy0F+Q/wRgwKGAtwShtXPKSfYrRPke4Y+Z3KitgIZFglb518Q2vlAtnQ1yQsjRM4v39qyQPVstE+ppDqUfHzuhQnebC5jSnKHsrgIWJ9CCIibE+kr0a2/P1a2Y03IK2N9TqrHisU/PwvUNMaEBWXN3Tg1uigr0zhE7NvNVh62k8x8yr8+ONz0kbc0j7QHlZz1mEmKl+Sm5GiCuBJB59eRTxliJO+U9AbzxjwKZtUXzeDzO7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TvOkUxmt2b8ohyap0yliQ8c4SA3ogzmJKlH+8HDT2w8=;
 b=zV5GvtRsPn5cbSNf/0hY6pgn1wtgTJAAsu9exbNJ84bJuqko1VTpBE3vhVcGuWZ7u8EOUmvUuSrSSSd9Z+GlVqaXLTIxEKeGq6J03Vlf6DE5x6d9LC5fNpdA8NCg89+6dc59Y+sfRA/QxhzitjPtcgMbokzWVY7e5itu0EFYhbv7LVSzL/6RNuDS3fWIHQQd9f4FP14KJq2e6kSvD2ysW2KCYo+bH5F+2pGsdmGhcxc9Yct9EMqVkCrkueHDClwD9w8Rdy7FeV+ND44hZaGiSVqrOzzAI5z6FSCBXJoUCSDKhZpStUZGlDI0kvW2Rx/GD+Fkl+DJyw0KrzZ4yJcnqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvOkUxmt2b8ohyap0yliQ8c4SA3ogzmJKlH+8HDT2w8=;
 b=a4VgfEkeyVIQEUV2aOJE5vYfq4CEX80uc/L82jiiPX1QI6bRWEg01oeTASDNgphyu8Nr11lHH8tzM6kwhj14B5tzFG1TuvPn5GP1iZGTL3UxmzbC1dsbU2EW49MpNYYfjkwWBtyqh9sqCfdSrBX9uiYLSHRb6yAOJXgfmII9Xeaai9862VK7XVtKQjjCZcwsKEmY5U7CmJrsf4bIejg6Jtxpnffwvd3l0wo3qWnJifD/pSq6qlMpJYwhUOGW/x74X2pCLciCGRV54E52DaWyy4evqUCKJIO5ugAqxw1wVleWm0ZphXd1MXvRnj3W3oE0RrqZr2+qIb9RYhNh19Fy0w==
Received: from IA0PR12MB7555.namprd12.prod.outlook.com (2603:10b6:208:43d::5)
 by DM4PR12MB6064.namprd12.prod.outlook.com (2603:10b6:8:af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 08:26:57 +0000
Received: from IA0PR12MB7555.namprd12.prod.outlook.com
 ([fe80::5a27:a8d9:43b7:3b8d]) by IA0PR12MB7555.namprd12.prod.outlook.com
 ([fe80::5a27:a8d9:43b7:3b8d%6]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 08:26:57 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, Jason Gunthorpe
 <jgg@nvidia.com>, Pavel Hrdina <phrdina@redhat.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Nicolin Chen <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>, "clg@redhat.com" <clg@redhat.com>, "alex@shazbot.org"
 <alex@shazbot.org>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, "smostafa@google.com" <smostafa@google.com>,
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com"
 <jiangkunkun@huawei.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v9 31/37] hw/arm/smmuv3-accel: Add property to specify OAS
 bits
Thread-Topic: [PATCH v9 31/37] hw/arm/smmuv3-accel: Add property to specify
 OAS bits
Thread-Index: AQHcjrF92YpMmGmntEqRZLFfH3O4H7VvhjCAgAAEUKCAAAa0gIAABIOQgAAG3gCAAAAr0IAMfn/AgCIdpwCAAAfwYA==
Date: Wed, 4 Mar 2026 08:26:57 +0000
Message-ID: <IA0PR12MB755548A48375D1856ADE89F5AB7CA@IA0PR12MB7555.namprd12.prod.outlook.com>
References: <20260126104342.253965-1-skolothumtho@nvidia.com>
 <20260126104342.253965-32-skolothumtho@nvidia.com>
 <d9192ae6-a94f-479a-b19f-734cc52a6be0@redhat.com>
 <CH3PR12MB754867E986856DC7718D4051AB9AA@CH3PR12MB7548.namprd12.prod.outlook.com>
 <20260202151917.GO2223369@nvidia.com>
 <CH3PR12MB754835BE4A5C54387122504AAB9AA@CH3PR12MB7548.namprd12.prod.outlook.com>
 <20260202160000.GR2223369@nvidia.com>
 <CH3PR12MB7548DFE7F7CE555A3B3BF947AB9AA@CH3PR12MB7548.namprd12.prod.outlook.com>
 <CH3PR12MB7548515EDA96BD03F64DCAA2AB62A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <41aaf959-b417-469e-89aa-41c20a4b906c@redhat.com>
In-Reply-To: <41aaf959-b417-469e-89aa-41c20a4b906c@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB7555:EE_|DM4PR12MB6064:EE_
x-ms-office365-filtering-correlation-id: 4db03f0b-af16-441b-3786-08de79c7ccf9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700021; 
x-microsoft-antispam-message-info: 3m8AXrEmTwi0ej0DAnNWOebyPB7WYwgXsILyPkNj/Xf6biblBA2UlQZFVkcezkWE49sJARLfcVWYsTmRqatiWouwg9tf8vb05d8mNrVM6ksveSAB0RkKku9V4hW7Ji2iM37AlTxLP7AAWn2beElLUaw6UbTRFuPX5kDr6gKwVmXAhF0WdvXiskVH/ba3pn692yJGSjQmDGaqFmlw2qRzPcKNI/2xsyR5ryXdw1ASd4xFIz+vvBPdD5sD/ToAKFsrw1PnZb2iyLgXLCqyu9Rv/bBCBHzpWSDiUJw0jxr1ap4XS9DDAD3vtwF2jTp965Jn4MShNS3vYboTMzG4uNYKXXB/36kb+F6doWyBsnz8jWux2we12YiuF0lehrSXKamZtp0d/y2E43ZQ2Cv5uihytbTbm/3fgXrFJH4Yavy+TWqNIn1jyOOYiuQimwhFsY2NAuD2H4F2umV8xNZonZ7a/mxpaHRfK1vkRGVU1N6sORVmD/9+reb7w9c/4H5lxDrKzDFNfjn3//CgrQ6Y0eZlDBJOglLGjg9xGB3t30lHU7SYhdRgVEl3M06LGooLOhbhEzHN4etIbpzsF0DnA0Bm9mLV6jofiPvKi+VDhn6ikbx3W8DShvVLHASMNK41k1fUhx0DJ8qVEzJDhnymY4oNEvwVTy6SnA2Rb4tEL1HSTapyYj5/Bi8qLJ4ikvbp9SVU34DEA4PsQy5am1uD/Qy765w2kR3XS9mBqA4RNaVwqzL4LcGcbeS3eSZoWJiU6xoxxSUEvQdOeZ11+ZzBkfxdFGbHi2gS0nPaYPMfL8MwMU8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB7555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q2I3RmVMMEZKMGlqZUZlRTRPSW5LaHRYVGFWbkY0L3ZzRHhmc2JmMi9NTHpK?=
 =?utf-8?B?Yk5vSDM5ZXFhVTFZVUpneHltaVRJRUZvTVVqV1hXT3FnTWREMG10dFMyVmlz?=
 =?utf-8?B?VjdUUzBobW5jTVpGeDdTc3o0UE1iOXdnWEF4ekwrOXVlUUw1b2lhSTd6UGIr?=
 =?utf-8?B?NjdQWW9aR2kwT3BIelJxUWNYMk9zdy9NeG9BTktWQW0vSTdjaFMxVENnSUd4?=
 =?utf-8?B?MjR1TGJjN0EvMDN2K29ESmhEK2pJbGhXaWtaVlBrYmc0QlBOTkd1UXJGZkNF?=
 =?utf-8?B?M1NsWCtLVjA0NWpqUGNTWE9yQW5TcnFIN0RIdDZMWkJRMGRJQnJQWDdFRHBy?=
 =?utf-8?B?OUlHd1QwT1dKbHBJajcxVkJpWmtCRjlXcWg3Ym9nS3VwbUNqRUNsbFNwY1J3?=
 =?utf-8?B?bGUzL3VYNTJSblJDVWhsR21kRlpWMUVRaWhGUnQwVTRYR1JEVkZ4ek1hd0l6?=
 =?utf-8?B?RXZRZFZZOWdMMG1wS3Zma2N4OStKZHp3LzNPcTBMcjUyV2U1ZzJyYklRclY0?=
 =?utf-8?B?eGgwZFNia1RCd21EOTR6OVdqamlMRDAzbHQwOEtORjdZYXJkMHNIQTVNNFFN?=
 =?utf-8?B?eFE2S3JFanh4bEJTOTZnL0k2ZStGWWxRRFM5M0lpU29VUnRtd21QN0tJVjFp?=
 =?utf-8?B?ZXJrY1Nlc1NmeDFQWEtXekY5Y0ZHR0VRMXB6VjJrdkxmL3ZOTTlHN1c1clJn?=
 =?utf-8?B?b2VzUUE1NUdFQkRiV0I1MVM5TW9KZEVsMEYrY3Q4OUl6QmtyanhGTW10Y2du?=
 =?utf-8?B?UWRvV1BtUmcyblVCVVNhenNnRHpiZ2REQ01mMm1vN3dsNHJGWjZXK0wySWtq?=
 =?utf-8?B?bWE3UE1BNDlvTU11RFJpSlVEM2k0UWU2NCswZGhPOUY3QkRqQzIxVmFUazg5?=
 =?utf-8?B?M2s0ZGxRQ2ZybWZXV3ZqdDZqU2NuMXhjYjBaTHFJV0N3eDF0blhleWU0Z2tp?=
 =?utf-8?B?d3FuQzByMVRRVFVIbzVDMCs4SC9jSCttK2ZZMlY3WTZUV2pPcmRFdzh3NHQ4?=
 =?utf-8?B?QjJSOTg1SzdRMlFxQzRTdkdVUU8zYjBqV0JtaWxzczFFMFFXTHlJVmU0aE1Z?=
 =?utf-8?B?QzYyazRNSDFISnVEZ2VzRlZDTXMvNUhKejJjVFl5LzdYK1pzU0dCR2pNOWp5?=
 =?utf-8?B?Z2xsd202ZUpuVGpUcDFBak4rWHpxU3dDaEhhRzhSbkkrWUExOGtzK1Y2M1ZL?=
 =?utf-8?B?K3Z5eElXUjFRSU1WVWpkWHFLYUJScmtlUkdwd1hGbFZ4U2Jtczh0a0lQOEkv?=
 =?utf-8?B?NUVSaDRKYk45TmR4M2k4VnNYekNFTTVpYkdqVXdDM05lQm9pN1huQU5Rb3Zv?=
 =?utf-8?B?TkZaOFl5bXdCZTUwc1lkNnFtYUtaNit0R1hTL1hHZ2JpbVJsMXovZi9VRUZU?=
 =?utf-8?B?RWNtclBqZVlsRGkwZlpLcXVpNWJxOERiSk9MWDRHb3p2NEFVTk5hTkd6VWRL?=
 =?utf-8?B?NXNHbDNGQmF5RHZscVdMZzJJOUJ5YjRWRFI5bUNvdkx0Z1czV3B1ZHNZdUN2?=
 =?utf-8?B?Q29NRUZsRmJ5WlBpdXpXTjFwSTAvME56OVNPWElGYk9EM080ODltbm9EbjFV?=
 =?utf-8?B?dUZGTThENEpJS09RV2kwTHhjOUZxSmR6dmtnSmVyS3lXaTlkOFNtUk1sRHEy?=
 =?utf-8?B?VUNFU2N2Q1p5RFUwb21iUWFjSWRaWm81aFdkTllaUmhWaUdEY3cxZzdUL2Ri?=
 =?utf-8?B?WXk5dDhLWkk0elphVythVVpJeGwrb0djL0JyeHBBWVFucHlGc2N6QXl1VmdX?=
 =?utf-8?B?Z1dDQ0s2THRoMUErTTZWZlQ1blkvR1NObFNXVDdNVER2S25mRDdnNTZ1djBE?=
 =?utf-8?B?U09kZ29ONXRGQkxOV2oxbVpNSjNmL0NjNHVHVlorZDFlOEw3b2loZE5ySnZ6?=
 =?utf-8?B?eTNITFJuaHh6d3d4N1dZVy9mTFErQUlVUHloek55aG4wdUVNMFZOSFdMdlEr?=
 =?utf-8?B?a1hONlVRNW1wOCtiWXZ2ekQvemY1N1BqMTZuZFU3Ukhvc1dacU50aFlHN3ZO?=
 =?utf-8?B?dkMyNHlZZldvNzBHRDNtRE1icU80YmN2Nm5ZMlBNVldoQWtsYWZUYVIzcmVH?=
 =?utf-8?B?VDJGejA5VS9DMkpBZEJWWFZtbE9vT3NITjNRR1g4cWNTa3NRcjV0V1Z1clpj?=
 =?utf-8?B?eG5lN1NBNUVLNXB5UWsxblBhUHluVCtyNDJHRlhBejIrWkVSU0RGWEU3eEhK?=
 =?utf-8?B?S09LMHZoSy92QzJFNE91djBDNmNhNzBPSnM2N2FJc2ZROWpMYnhuSHVhSXJq?=
 =?utf-8?B?YnUrNnl1WFhSV1VsNmlTVnZoQVlZZ1JZWXo2Q21ZVEtMV0lDcm12dWpKL0I0?=
 =?utf-8?B?L0VCNjBwaFRFUm1rc3hteWtiYnFmZ0NyYjc0U2M2RW90RWw0dUhiUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4db03f0b-af16-441b-3786-08de79c7ccf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2026 08:26:57.7464 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2m+08eySQNQrpRp86+dQcIZgYykxAhT3OOvwxVmojbHtmLFVJKADSaH6MQNWhxA8QDPIHM4geAwKuifi3sH3jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6064
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
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

SGkgRXJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIEF1
Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+IFNlbnQ6IDA0IE1hcmNoIDIwMjYgMDc6NDcN
Cj4gVG86IFNoYW1lZXIgS29sb3RodW0gVGhvZGkgPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPjsg
SmFzb24gR3VudGhvcnBlDQo+IDxqZ2dAbnZpZGlhLmNvbT47IFBhdmVsIEhyZGluYSA8cGhyZGlu
YUByZWRoYXQuY29tPg0KPiBDYzogcWVtdS1hcm1Abm9uZ251Lm9yZzsgcWVtdS1kZXZlbEBub25n
bnUub3JnOw0KPiBwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc7IE5pY29saW4gQ2hlbiA8bmljb2xp
bmNAbnZpZGlhLmNvbT47DQo+IGRkdXRpbGVAcmVkaGF0LmNvbTsgYmVycmFuZ2VAcmVkaGF0LmNv
bTsgY2xnQHJlZGhhdC5jb207DQo+IGFsZXhAc2hhemJvdC5vcmc7IE5hdGhhbiBDaGVuIDxuYXRo
YW5jQG52aWRpYS5jb20+OyBNYXR0IE9jaHMNCj4gPG1vY2hzQG52aWRpYS5jb20+OyBzbW9zdGFm
YUBnb29nbGUuY29tOyB3YW5nemhvdTFAaGlzaWxpY29uLmNvbTsNCj4gamlhbmdrdW5rdW5AaHVh
d2VpLmNvbTsgam9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tOw0KPiB6aGFuZ2ZlaS5nYW9AbGlu
YXJvLm9yZzsgemhlbnpob25nLmR1YW5AaW50ZWwuY29tOyB5aS5sLmxpdUBpbnRlbC5jb207DQo+
IEtyaXNobmFrYW50IEphanUgPGtqYWp1QG52aWRpYS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjkgMzEvMzddIGh3L2FybS9zbW11djMtYWNjZWw6IEFkZCBwcm9wZXJ0eSB0byBzcGVjaWZ5
DQo+IE9BUyBiaXRzDQo+IA0KWy4uLl0NCj4gPg0KPiA+IFRoaXMgaXMgaG93IHRoZSB1c2FnZSB3
b3VsZCBsb29rIHdpdGggYW4gYWRkZWQgImF0cyIgcHJvcGVydHkgb24gdGhlDQo+ID4gdmZpby1w
Y2kgZGV2aWNlOg0KPiA+DQo+ID4gLWRldmljZSB2ZmlvLXBjaSwuLi4sYXRzPW9uDQo+ID4gICAg
IGlmIEFUU19OT1RfU1VQUE9SVEVEIHRoZW4gcmVqZWN0DQo+ID4gLWRldmljZSB2ZmlvLXBjaSwu
Li4sYXRzPW9mZg0KPiA+ICAgICBrZWVwIEFUUyBvZmYNCj4gPiAtZGV2aWNlIHZmaW8tcGNpLC4u
LixhdHM9YXV0byAoZGVmYXVsdCkNCj4gPiAgICBpZiBBVFNfTk9UX1NVUFBPUlRFRCwgZGlzYWJs
ZSBBVFMNCj4gPiAgICAgb3RoZXJ3aXNlLCBlbmFibGUgQVRTIGlmIHRoZSBQQ0llIEFUUyBjYXBh
YmlsaXR5IGlzIHByZXNlbnQNCj4gPiAgICAgKHRoaXMgYWxzbyBjb3ZlcnMgYmVoYXZpb3VyIG9u
IG9sZGVyIGtlcm5lbHMpDQo+ID4NCj4gPiBEb2VzIHRoZSBhYm92ZSBtYWtlIHNlbnNlPw0KPiBE
byB5b3UgaGF2ZSBwbGFucyB3cnQgdGhlIG1pZ3JhdGlvbiB0byBhdXRvIHByb3BlcnRpZXMgZm9y
IHRoZSB2YXJpb3VzDQo+IHZTTU1VIHByb3BlcnRpZXMgKFJJTCwgc3NpZHNpemUsIE9BUywgQVRT
KT8gSSBqdXN0IHdvdWxkIGxpa2UgdG8gbWFrZQ0KPiBzdXJlIGxpYnZpcnQgaW50ZWdyYXRvcnMg
dGFrZSB0aGlzIG5ldyBkZXNpZ24gaW50byBhY2NvdW50Lg0KPiBQbGVhc2UgbGV0IG1lIGtub3cg
aWYgc29tZSBoZWxwIGlzIG5lZWRlZCBmb3IgdGhlIGNvbnZlcnNpb24gb2Ygc29tZSBvZg0KPiB0
aGUgcHJvcGVydGllcz8NCg0KWWVzLCBOYXRoYW4gaXMgd29ya2luZyBvbiBhIFFFTVUgc2VyaWVz
IHRvIGNvbnZlcnQgdGhvc2UgdG8gYXV0bw0KcHJvcGVydGllcy4gSSBoYXZlIGFsc28gc2VudCBv
dXQgYSBrZXJuZWwgc2VyaWVzIHRvIHJlcG9ydCB0aGUgZWZmZWN0aXZlDQpBVFMgc3RhdHVzIGZv
ciB0aGUgZGV2aWNlLiBTb3JyeSwgSSBtaXNzZWQgQ0NpbmcgeW91IG9uIHRoYXQgdGhyZWFkLg0K
UGxlYXNlIGZpbmQgaXQgaGVyZSBbMF0uIFRoZSBRRU1VIHNlcmllcyBuZWVkcyB0byBtYWtlIHVz
ZSBvZiB0aGlzDQphcyB3ZWxsLg0KDQpIb3BlZnVsbHksIE5hdGhhbiB3aWxsIGJlIGFibGUgdG8g
c2VuZCBvdXQgdGhlIFFFTVUgc2VyaWVzIHNvb24gYWZ0ZXINCmludGVybmFsIHJldmlldyBhbmQg
dGVzdGluZy4NCg0KVGhhbmtzLA0KU2hhbWVlcg0KWzBdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2xpbnV4LWlvbW11LzIwMjYwMzAzMTUwMzQ4LjIzMzk5Ny0xLXNrb2xvdGh1bXRob0BudmlkaWEu
Y29tLw0KDQoNCg0K

