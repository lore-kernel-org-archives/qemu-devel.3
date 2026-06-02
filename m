Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BFF3CD6E4A
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 06:54:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUJ0g-0004Hb-Ed; Tue, 02 Jun 2026 02:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1wUJ0d-0004H3-Cq
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 02:53:55 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1wUJ0a-0000qB-VY
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 02:53:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=bull.com; i=@bull.com; q=dns/txt; s=mail;
 t=1780383233; x=1811919233;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=i1lbTXrciWH3nn+FTyzNJGG5rdgVlywTuhVUkGdac0g=;
 b=HxjsEoBGMM3GwH2aqQctYoWr3jraGhZvb6RBIX2NBYsjASX6w9h4p8wD
 GIxPxkF5/B57p3ggF396QUUFNjwy4N2Jz9dbyq+HMwntrmTlqlNP9B4D2
 JzRd4GArFYsAJlz8SDMT1ojox/ZBmB0s0ZNGj/vzADsS76BcK4iO4Isn+
 bfYS/l3fdcgnAyHfPxN3mfq4DW/Ahkik3ArgUeO0RfPeU8I0W9ClkSnjd
 hdAgZvNGNYy/8dL+GKRNXRYVDVuCnDlv767rS/9a5C7xoClK0xnOlOqBt
 6Q0+NFMursqU6BjsB5xYwXCka2hvzBwZPESC3a7Xdq9jhc1uaX7LXf6Oq w==;
X-CSE-ConnectionGUID: 9/+Kfrk4R3WUZlFyb5Gkfw==
X-CSE-MsgGUID: cx+WSE2WSOGZk2bBGxyR0w==
IronPort-SDR: 6a1e7dfb_A7ri9FSNEaXe2SbJhVXAtmrAletdUSsD6iGUAu5E7ZGYbd/
 2HpZPH6B64PCCaT1Afmu99yk4RgOAUWgGV9Hvkw==
X-IronPort-AV: E=Sophos;i="6.24,182,1774306800"; d="scan'208";a="48136920"
X-MGA-submission: =?us-ascii?q?MDGrQc2v7T+Yf/MWSXdXSQFKXr8YMoQsMT25ph?=
 =?us-ascii?q?dF4qFJFyxeXgpGrV1JH/hsHRjJnoAbMKZsE3APY1ufdOzvpUF+Rh1hAL?=
 =?us-ascii?q?VNChPWiOFIYUIO2ybIRAoGLx1SNwcj4E3g69InPRv32EqfCcHODKkQWK?=
 =?us-ascii?q?hH/U0O7uUp4oVvEjkoDROoZw=3D=3D?=
Received: from mail-francecentralazon11013060.outbound.protection.outlook.com
 (HELO PA4PR04CU001.outbound.protection.outlook.com) ([40.107.162.60])
 by smarthost3.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 02 Jun 2026 08:53:46 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uFNxR3xgjGjamZEng2a47gDxzE6cc05L8gJQY7MrOxMpXtngFyAymoDyKVp/zPknqShg2bfI0da25ZTKYQ4KWnEUY87RlbLH4VvDCsNxQgL501Dh0nQqHjrEuHtYbHVAYipnMIpjTDzHgia7+xhIEQjHaPth9/1aA9RI3enjBEU7xVAwr2l/Sv+UuZixQq3/iTkLOPu8T2khkf0MtIetCUEToEARwhNCxoLK50JXbe9wb0oPN26ng3OT7gN+Ywq2zQy+yORsBFyx5BPLvAMuk4ZgkD4wdsrLqURPnBZ+RerHCjdx2wuKw9vaOCaBQnqd/9lGEySabj58uKBoGYqDtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1lbTXrciWH3nn+FTyzNJGG5rdgVlywTuhVUkGdac0g=;
 b=uCqGMOFGILbSl4qPcip9alcx7+UhhGV/wP9/oB2qcHYaKlxcyBznawazWy45TTlvFMGHjWeQ+NIO0OlV6TWGAwhy12E060Vok8d79vN6ZX/D3JfF4/kaGt+s8CGJuh4+JABmZ47qkP4Ng49QYGvFb+XsrcQjDPBjy090hJ++/zmldHrHQ+1Xq3iqvAMBYmQu/eg4gYazB1LFO9TPhEOmcx7LJ03RMucAzjG3vRxiIndSH09RUmsyVFcBAxJw4l/jhDASex5E1NaM0EphflJ//IruK2kv+2YEtEumYl6IfhucPX8xr4fN1b84yI4rjrlPMxRXhba+T9XqqYbUuILtrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by FRWPR07MB10787.eurprd07.prod.outlook.com (2603:10a6:d10:188::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Tue, 2 Jun 2026
 06:53:44 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%6]) with mapi id 15.21.0071.014; Tue, 2 Jun 2026
 06:53:44 +0000
From: =?utf-8?B?Q2zDqW1lbnQgTUFUSElFVS0tRFJJRg==?=
 <clement.mathieu--drif@bull.com>
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
Subject: Re: [PATCH v6 08/17] intel_iommu: Fix PASID validity check in fault
 reporting
Thread-Topic: [PATCH v6 08/17] intel_iommu: Fix PASID validity check in fault
 reporting
Thread-Index: AQHc7ZxoA2jeimks5US5TU4p0/0ZIbYq3akA
Date: Tue, 2 Jun 2026 06:53:44 +0000
Message-ID: <7b3c64be6be8f662dcd107331ff10fbdcfb4fe35.camel@bull.com>
References: <20260527054658.1021096-1-zhenzhong.duan@intel.com>
 <20260527054658.1021096-9-zhenzhong.duan@intel.com>
In-Reply-To: <20260527054658.1021096-9-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|FRWPR07MB10787:EE_
x-ms-office365-filtering-correlation-id: 2dd88401-8681-4d8d-1f5a-08dec073b085
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700021|4143699003|56012099006|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: Nvspcviw/kPtRhe2SvOldbyMBTk+C4eRF9OPTEyUndyGgXbN82PpWscChdTzy1RFPpqKzDLb5daw51AKZ5PrIWk9x22mNovdklrFu79niRVR68sultuXcHcC6UCnfnN2Gyak+X71Hqa23XGzsRWwz0CR9ilrPYM49KiYgUN2WuZV3nFY9Qz/3af8PBxWJyDac0bQwpFLmCHny/jt1ajTlZQKP/chZlDnSQjwFd5l2BZY+F85AdrqU80U3BvkqecYxWQ5L9vZByxFX9RobKX1+JMRCwREy6fUe4SYiqxLxpsQ7v48fBDSCckhO7pJlufKtoBUgeQDs2eWr38djAcDsD/UtqYOiZKycD7VKkPROpTmtKy/UhN36sNvO8rRlAQfPqBo3l9s99MU5E8a0fW9EgrLwl7DBdYP1Ud4NvdHWVT7LjQEwcE9sFhQbJgCDM0CbDYurH0nqJoevsMQv2xqElUxvmxI+YTih7669UU6Y6rxRpNWcXWV1BQUUMKBPuH4QjWa3YP8deQOQ9lD8hcwo3lf8PnsH2nQQhYWrkGhy4+fX84QDkUjymWFRVLhx2bjGq7Wz8Bk7Te/Q/qAkgnCF5q9eVHcfXw1apxyH9Pdng+zR6O7LIMYOuxJc1rmpDRb/YC8WnwyUssoskqaKqsdKKH+FbpxLa0UfpDlL1OpvIGPGKZeD2gKlPhSnD6NQgiBMnEGTNFK1dbcziUu1Xk6EHjJi8eqcArhQwAL48Yafpy5qANTeDggTqnepmyvd7Ki
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGhzZVR1WkZkbEEvdkNFRDI3aEIvRzFoemNaZlhTMmI2ckU2ZHMrUmpZc3FS?=
 =?utf-8?B?U01ZZy9QMnY0Y1R3UjI1dGRONHRXNDdERkViZlZWVGMxSXM4SUV2WlJvRXNq?=
 =?utf-8?B?UFdNQWdkL2wyUHZQQWFhQWEzTjZjMVBXVmtDVXhyYnNEZWdHTDE1TkdobWtO?=
 =?utf-8?B?Qi9OQ0dYYXhuWmdPSWc0eVZnV2ZPZm1wa0h4MkpxRXE0UXRqTHdrQ0RSZVVr?=
 =?utf-8?B?N1JHOCtwSHN3cEM4ZGlZU2NPRHl0WXFKRXMwZ0YwSTVuRzdObGhaWUJ1SVBX?=
 =?utf-8?B?eWE3dmhOcG1pZVF5SUJwZVU4K3FUSGtkcFBiVGRlY0V6SVJ5NkRJcXJqQ0o5?=
 =?utf-8?B?cWpPc1ErNDhEbDAvTWFOemhFMjVXVGpEcTVMa2pva0xLc3FrUytSL2I2NSt6?=
 =?utf-8?B?VmZDYUlNOE5QUlhOcGxKUE9MZmptQlc2cmRDaFNYc1F3NzNRakVCNnIxT2Vq?=
 =?utf-8?B?S3MyL0k1bFB5TGdxNzFWVnAwSVhpa0JVcHNtcEZFek5WQjdXbmtjNk03NjlW?=
 =?utf-8?B?QVg1eDBWTXJDWG9EVjIxZW1CbWpwUFlyZjUyZ1Z0V0YrTmxrejcwQlBjd2Zl?=
 =?utf-8?B?a1JVODEvR0UweUZJSkdET01iTTdkWktGK1ZwbkNlbHN6d3RMRk1xc2NjR3JS?=
 =?utf-8?B?WjVBMHpJRng5dlFZWi85VGhNQnNxT2VvMmQ3NThDU09WbWhHdzVxTVl1UmRY?=
 =?utf-8?B?RFI3OW1oWkJOMHZhS3FPMFlrajVPUU1HeG1FbW9TRU4rbUYyZUhIQ3lsTDlD?=
 =?utf-8?B?czZxbXQ3Ym9aeENSRVcwK3hGR2ZwQU9aSDJ4ekNmQWlsRHJmcEMrR0VKYmZB?=
 =?utf-8?B?UXVPRzYrQVM1UXlsSnFzM2dxUGgxbzQrTWgwZE5ENXZKWHZvYklYV1NTdHVW?=
 =?utf-8?B?L1FjQzBYbEM5V21IYmtMQ3NIT2hJMXo3Qm1KZEM2MWZJb0VTV2Jkc1p6N0lX?=
 =?utf-8?B?REpPUURnbGcrRlFSRU0xVnVXQk5rZE1uUlAxMnBQQ0REaER2NWJ6d2dlYmhM?=
 =?utf-8?B?V2tGeXZzMVFrbFZFc1pFdjZmRXRXSGRKbkNWcndtNFFyY3RzRzR1S3hwanBs?=
 =?utf-8?B?WExzdWpXSUtZemtsOEdiOXQxV0o3ZkZIekcweWllWDJmQmNFTWFhemZwWEEw?=
 =?utf-8?B?Tk0rME9td0V4RUw4ZUhibEpGZjJYSmNnRlRMa1lzRzlCblZsb2xRSXBvaEFZ?=
 =?utf-8?B?cUJDTitNTStvVHZyY3U5cE51RTRicG01eWVYM3ZEd3AwdC9DbGFMcHI1aTJU?=
 =?utf-8?B?OTBRcnR4a0hkVjJBUDJRVm5zRGV4T21wNEphRGtMVnF3STM5RTBRdmJBd2I4?=
 =?utf-8?B?cERsNXJNamRobmxmOXd6a0FWVzdZUGpqcW11cy9iSDNLS2xTWFJDaUlLN3JI?=
 =?utf-8?B?bThVQjdvOEJ0ZUJOSjJ1dDBpQWc4V2plVUF1Q0pxMzJQNXdIM1YyOFRRUzht?=
 =?utf-8?B?LzJ4L1pSWmtENExwVE9qNS93a2VvN2NqNGN6emVxenRKWEdUVGY4SFZJcG1H?=
 =?utf-8?B?U0drVVRoSVF2SW1zb0tUbkxlaTBIZ3RIdExoM0IzN1djWW1SalJwTWFNSlZl?=
 =?utf-8?B?dzhUVFZna0tYaU95bFpicGZEbEZwZW93dSt4L0ZZaFZLQWdKK1U2R3RHM0Ro?=
 =?utf-8?B?dVUwRUlXd1VaYjlIQjRtWVQ0NkZZbDVSUitDdTJ5bm56M0lzNm9GZ3d0SjNa?=
 =?utf-8?B?QldrSy8vanp2UzFWR0pWTjZkbzgwUzJUWDdkUmNISFJKbVZkWEx3NnFUdUxl?=
 =?utf-8?B?ak5GSnhLZGVwd1ExOGJVSHFJUGhoT1piT2ljaXRzT1BEVUc5VzhVSW00ejZz?=
 =?utf-8?B?NlR3SmFXUnJLU3liNnlvMjExQXdIMnR5U1Q0Smk4REd6aE8vb0dYcnZNQUxV?=
 =?utf-8?B?ZmZBRlIzMFF2N2hPajF5WkxHRnRhWE51SU93QlJQYnZid2FuSHFTOE1GYS93?=
 =?utf-8?B?WG1iN01FS0RzMFVFMmpIbFZ0TlBsT0ZyK1F6cjdvWWE2Y3gvY0JFbzNTSnNS?=
 =?utf-8?B?bzdvQnJSRnh1TDEzS1NFVDNCZDY5Y3VmR2l1dm1oZFRJSHpkLzRsWk9ZODM4?=
 =?utf-8?B?WElsRm9Bbndoa0M3TVp4WXk5eVhzNWVUR2dkcXJMRDhUa2phaDk5WkdrWDJC?=
 =?utf-8?B?UHhLN0J4S0gzUTR5UWZjS1U2c1NmSmQ4dzU5RldvN0NYQVdaMEZRUnJ5MTNN?=
 =?utf-8?B?cjNkem12NEtjbzVaajJXQ2ZNazJWOTVlUk1iOWdHRXh5bkcxUE91VzdvM2tT?=
 =?utf-8?B?NUZFZkkxZVRidnpybnRQU05pUVRpQ2VCSjFYNVNOUFpKMGt4TFNWZkV4c0M5?=
 =?utf-8?B?SUxpdE5JblQwa1hwTVFhZVpHZHRWaHBodDhhMEJqOUJTRFY3Nko3cUd5NVZ2?=
 =?utf-8?Q?8YEJTzfFgOJhD4Rs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DBF49FF20D24ED4AA85FAC3E0097AD5B@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: scu4wlTw0LDucVYVp6YTXGIFNGgRlpAr/DAzjSIB8XYdqMaB8ERbZutq+pU6ZRebUO3ZZGqH0ODF1WFeHFWgmqeUj79oKhRqbxD8ysZpF4CAdsrKyAZ5P9GhzKDfnxYlg28XLn6fFJt3XfH3LOtGzfBWXaZrQe634L6Uw5z55t7KuLHib6EdjvyluH5onN4zfbAzfbZ9ZppP45+e5wZHK657U2yiJImkXRX3mF7XlZFq7kn5De0Zxbc75/zztGVgTwLlrZNBrzMSteFw7cbEqiLjGBYrbyXpffyp95nXKFIVZsw1B/X3LCSDvfKPgus40z9Ndd+dtn02dt0l9JV1Bg==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dd88401-8681-4d8d-1f5a-08dec073b085
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 06:53:44.8200 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QUqYVwXZzbD0eIXuKWfhmQMSP3uI+xst7bDCuu3I8eOukOPhgj69R9oSZMCkY+7hTlhu3NZJjGvtgPUt490j5wDOPyQRV2lmt0nuZUgzmGw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR07MB10787
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@bull.com; helo=smarthost3.eviden.com
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

UmV2aWV3ZWQtYnk6IENsZW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlm
QGJ1bGwuY29tPg0KDQpPbiBXZWQsIDIwMjYtMDUtMjcgYXQgMDE6NDYgLTA0MDAsIFpoZW56aG9u
ZyBEdWFuIHdyb3RlOg0KPiBDYXV0aW9uOiBFeHRlcm5hbCBlbWFpbC4gRG8gbm90IG9wZW4gYXR0
YWNobWVudHMgb3IgY2xpY2sgbGlua3MsIHVubGVzcyB0aGlzIGVtYWlsIGNvbWVzIGZyb20gYSBr
bm93biBzZW5kZXIgYW5kIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+IA0KPiANCj4g
VGhlIGN1cnJlbnQgY29kZSBpbmNvcnJlY3RseSB1c2VzICJwYXNpZCAhPSBQQ0lfTk9fUEFTSUQi
IHRvIGRldGVybWluZSBpZiAgDQo+IFBBU0lEIHNob3VsZCBiZSByZXBvcnRlZCBpbiBmYXVsdCBy
ZWNvcmRzLiBIb3dldmVyLCB0aGlzIGNoZWNrIGhhcHBlbnMgIA0KPiBhZnRlciB0aGUgY29kZSBj
b252ZXJ0cyBQQ0lfTk9fUEFTSUQgdG8gUEFTSURfMCBpbiBzY2FsYWJsZSBtb2RlLg0KPiANCj4g
VGhpcyBtZWFucyB0aGF0IGZvciByZXF1ZXN0cyB0aGF0IG9yaWdpbmFsbHkgaGFkIFBDSV9OT19Q
QVNJRCwgdGhlIGNoZWNrICANCj4gInBhc2lkICE9IFBDSV9OT19QQVNJRCIgd2lsbCBpbmNvcnJl
Y3RseSByZXR1cm4gdHJ1ZSAoc2luY2UgcGFzaWQgaXMgbm93ICANCj4gUEFTSURfMCksIGNhdXNp
bmcgZmF1bHQgcmVjb3JkcyB0byBpbmNvcnJlY3RseSBpbmRpY2F0ZSBQQVNJRCB2YWxpZGl0eS4g
IA0KPiBBY2NvcmRpbmcgdG8gdGhlIFZULWQgc3BlY2lmaWNhdGlvbiwgdGhlIFBBU0lEIGZpZWxk
IGluIGZhdWx0IHJlY29yZHMgaXMgIA0KPiBvbmx5IHZhbGlkIGZvciBSZXF1ZXN0cy13aXRoLVBB
U0lEOg0KPiANCj4gwqAgIldoZW4gU2V0LCBpbmRpY2F0ZXMgdGhlIGZhdWx0ZWQgcmVxdWVzdCBo
YXMgYSBQQVNJRCBUTFAgUHJlZml4LiINCj4gDQo+IEZpeCB0aGlzIGJ5IGNhcHR1cmluZyB0aGUg
b3JpZ2luYWwgUEFTSUQgc3RhdGUgYmVmb3JlIHRoZSBQQ0lfTk9fUEFTSUQgdG8gIA0KPiBQQVNJ
RF8wIGNvbnZlcnNpb24sIGVuc3VyaW5nIGZhdWx0IHJlY29yZHMgY29ycmVjdGx5IHJlZmxlY3Qg
d2hldGhlciB0aGUgIA0KPiBvcmlnaW5hbCByZXF1ZXN0IGhhZCBhIFBBU0lELg0KPiANCj4gRml4
ZXM6IDFiMmIxMjM3NmM4YSAoImludGVsX2lvbW11OiBwcm9jZXNzIFBBU0lELWJhc2VkIGlvdGxi
IGludmFsaWRhdGlvbiIpICANCj4gU3VnZ2VzdGVkLWJ5OiBZaSBMaXUgPFt5aS5sLmxpdUBpbnRl
bC5jb21dKG1haWx0bzp5aS5sLmxpdUBpbnRlbC5jb20pPiAgDQo+IFNpZ25lZC1vZmYtYnk6IFpo
ZW56aG9uZyBEdWFuIDxbemhlbnpob25nLmR1YW5AaW50ZWwuY29tXShtYWlsdG86emhlbnpob25n
LmR1YW5AaW50ZWwuY29tKT4gIA0KPiAtLS0gIA0KPiDCoGh3L2kzODYvaW50ZWxfaW9tbXUuYyB8
IDMgKystICANCj4gwqAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9p
bnRlbF9pb21tdS5jICANCj4gaW5kZXggMjRkMDIxMWRiNy4uMDM0NzQ3YjBiNCAxMDA2NDQgIA0K
PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMgIA0KPiArKysgYi9ody9pMzg2L2ludGVsX2lv
bW11LmMgIA0KPiBAQCAtMjEwOSw2ICsyMTA5LDcgQEAgc3RhdGljIGJvb2wgdnRkX2RvX2lvbW11
X3RyYW5zbGF0ZShWVERBZGRyZXNzU3BhY2UgKnZ0ZF9hcywgUENJQnVzICpidXMsICANCj4gwqDC
oMKgwqAgYm9vbCBpc19mcGRfc2V0ID0gZmFsc2U7ICANCj4gwqDCoMKgwqAgYm9vbCByZWFkcyA9
IHRydWU7ICANCj4gwqDCoMKgwqAgYm9vbCB3cml0ZXMgPSB0cnVlOyAgDQo+ICvCoMKgwqAgYm9v
bCBpc19wYXNpZCA9IHBhc2lkICE9IFBDSV9OT19QQVNJRDsgIA0KPiDCoMKgwqDCoCB1aW50OF90
IGFjY2Vzc19mbGFncywgcGd0dDsgIA0KPiDCoMKgwqDCoCBWVERJT1RMQkVudHJ5ICppb3RsYl9l
bnRyeTsgIA0KPiDCoMKgwqDCoCB1aW50NjRfdCB4bGF0LCBzaXplOyAgDQo+IEBAIC0yMjM1LDcg
KzIyMzYsNyBAQCBzdGF0aWMgYm9vbCB2dGRfZG9faW9tbXVfdHJhbnNsYXRlKFZUREFkZHJlc3NT
cGFjZSAqdnRkX2FzLCBQQ0lCdXMgKmJ1cywgIA0KPiDCoMKgwqDCoCBpZiAocmV0X2ZyKSB7ICAN
Cj4gwqDCoMKgwqDCoMKgwqDCoCBpZiAoIXZ0ZF9pc19yZWNvdmVyYWJsZV9mYXVsdCgtcmV0X2Zy
LCBpb21tdV9pZHgpKSB7ICANCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZ0ZF9yZXBvcnRf
ZmF1bHQocywgLXJldF9mciwgaXNfZnBkX3NldCwgc291cmNlX2lkLCAgDQo+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYWRkciwgaXNfd3Jp
dGUsIHBhc2lkICE9IFBDSV9OT19QQVNJRCwgcGFzaWQpOyAgDQo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYWRkciwgaXNfd3JpdGUsIGlz
X3Bhc2lkLCBwYXNpZCk7ICANCj4gwqDCoMKgwqDCoMKgwqDCoCB9ICANCj4gwqDCoMKgwqDCoMKg
wqDCoCBnb3RvIGVycm9yOyAgDQo+IMKgwqDCoMKgIH0gIA0KPiAtLSAgDQo+IDIuNDcuMw0KPiA=

