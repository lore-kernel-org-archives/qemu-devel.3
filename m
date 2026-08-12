Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3667DC5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:08:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu9cr-0005mO-3g; Wed, 12 Aug 2026 10:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1wu9cm-0005fU-Hw
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 10:08:08 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1wu9cj-0003Oe-M1
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 10:08:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=bull.com; i=@bull.com; q=dns/txt; s=mail;
 t=1786543685; x=1818079685;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=b8TjAVTy/9igEXKnIDWusYOh4AqUu9brAHN7f11pz0k=;
 b=Jeq1DrNpo/if5DWjko5fQU+gOJW3SVRfnhz2ceWpCjZNmN1qPkKiTVXM
 7z5KnIw1E0+NJ/RtzrdgLwzr6y43q6AL2citwsIGAkO0v4u5IkdQkoBlJ
 piA8lD1c1BxGfGJjGLuiQgeJxVR7FIJJz5mJf8Efxg4mL3LHU7l7Cv0Zj
 Z21wxk/lkQ3tVkxnYIrfF0ljV/KEh97lu4Unk0WA7BuHjuL8P+b8bTxNo
 w/TPt8VoJobYixzNqLWNGA9WKYMs558bVeg53u8ZfydVR1ugx6GDKH2aI
 bOUfvUZpSq21bmgtTw2iaIQL/es54gLIcRpZcx57d+idV/q5NT989vT9S Q==;
X-CSE-ConnectionGUID: 1WgKrLG2RB68eHzD7T74QA==
X-CSE-MsgGUID: wlrFCOSQRuagWXQu4tTo2w==
IronPort-SDR: 6a7c7e3f_gQWRpVraPEsAgVW/RVcT+Wn2pfNFP/lNQuTaBBbfbkV3sFm
 1In4T2VMWQiAkhszZ3gjJ57bFmUIJT/o5nmHzYA==
X-IronPort-AV: E=Sophos;i="6.25,219,1779141600"; d="scan'208";a="48596263"
X-MGA-submission: =?us-ascii?q?MDFuYvcu3dSxMTKvAm5YgaW2NoFu5r8DrpxBCQ?=
 =?us-ascii?q?QSa+EGIsje+InFFYxgJiQESJrkmU8mqYFHV9Emri4K35sovEw/xY++up?=
 =?us-ascii?q?XLrvND3/TfMGMjggAPWiS3MlBaNYVAYGiTdF4FgdnBjv9xXy8VuMWx6J?=
 =?us-ascii?q?4nc0dFVpkTRZsvLuIsRmkfSQ=3D=3D?=
Received: from mail-francecentralazon11013058.outbound.protection.outlook.com
 (HELO PA4PR04CU001.outbound.protection.outlook.com) ([40.107.162.58])
 by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 12 Aug 2026 16:07:58 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qAFsu3WSdWoBQ7W+c+iNAhmLhkyeXw5PgnmYiJ27E2bxTdWPx0Eg+jjuPalB2Vara7TrY0erNGCGvtF4PWun/JqyGNAmAKTh1JP91sgvopOM5NQ0JcPUUtUB+0Y0IVv2RYSPh67/BMMQU15P7yty9uzon4xq7C0JGLEgLkAFKEcrR2KH6W3mZOY8eS7nw3Gv9pCXZUlccFOHEFBwZmv7oNSYixgrOi6XUoXRhelJu/jNgSypiHMYWlfGLcKQ7522XyggzZftCQTYtNbTK4reJcAVkUF+Vw9hxPEjCv8oXlE242d+5VSC6m6IV+rkjFtOPdKCN7iaiGMoSdzV3tRyvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b8TjAVTy/9igEXKnIDWusYOh4AqUu9brAHN7f11pz0k=;
 b=MCHl4ECYNCKDsDbrQ260EBRqs6BVOdrLnWv7iWxOVzEovz9ox2jH6NztsowK5NBLMm5HibhO45T5PlLrr6bguQh2gaBqmGFoSC0cotOe66zzqIhESUTDSno8nQLdXBu/XbbKK7x3fPdmC0ppQQjWxBozbFQcylE/ZNe4Fg1l4qzhF6HAKGAvETWjooCukixd9gAydG0iNVd2qa+jOSZb6mvywyGwOtq2ooU7HnrhWxMAQqeHHETG7tpbd2sy00l/3YrkULDd5AOieDFDFwRlkjk6Eve+s0hs3gP467q990Nd4FqQ4n0qdtdKmvAPiAsL9pterFtJoF+hyltCA29syQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by GV2PR07MB12040.eurprd07.prod.outlook.com (2603:10a6:150:354::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 14:07:53 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%4]) with mapi id 15.21.0315.012; Wed, 12 Aug 2026
 14:07:53 +0000
From: =?utf-8?B?Q2zDqW1lbnQgTUFUSElFVS0tRFJJRg==?=
 <clement.mathieu--drif@bull.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowangio@gmail.com" <jasowangio@gmail.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Hao, Xudong"
 <xudong.hao@intel.com>
Subject: Re: [PATCH v3 0/6] intel_iommu: Enable PRQ support for passthrough
 device
Thread-Topic: [PATCH v3 0/6] intel_iommu: Enable PRQ support for passthrough
 device
Thread-Index: AQHdJXaknO6gra3UQkST2flmIiB+OLaUUwKAgALN34CAAAZzAIADSi+AgAALfQA=
Date: Wed, 12 Aug 2026 14:07:53 +0000
Message-ID: <2d811cf876963acc75673078a869a63fdccdaf06.camel@bull.com>
References: <20260806073825.363468-1-zhenzhong.duan@intel.com>
 <45013c8a3fe7983ee31f52d9d9ba6c176ce98fdb.camel@bull.com>
 <IA3PR11MB9136D461AAF0FCC8D757B33C92DE2@IA3PR11MB9136.namprd11.prod.outlook.com>
 <97d42422c79aaa53a4a3faca5fc04ca75e22042c.camel@bull.com>
 <IA3PR11MB9136F6CEC9314AD408EFFE7992DC2@IA3PR11MB9136.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB9136F6CEC9314AD408EFFE7992DC2@IA3PR11MB9136.namprd11.prod.outlook.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|GV2PR07MB12040:EE_
x-ms-office365-filtering-correlation-id: e9634c6b-bd45-488a-2a84-08def87b19eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|23010399003|38070700021|11063799006|56012099006|10067099003|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info: /shqQR05bXNPyt7/tMJHkF7EkID9QRFwoFam8xTPLWM97Bz85QoxQAAjiG2cKCNMJVGyOrlSXwAd97uw51CtK1snYtOQMM8IH3J6lgxrBxg5XipOf7JPrGp9Z3sl1kbM8C+urvI4YmNoNKF8T8bs1uNKTfmVaOPj/TLu+CHCWujFLQRQighIlU6qDV5yt32CKpQLxAqRquvRYSh2e6dCd+Pi3WzmzTjRNI7iWr4Iu9y5xXZQnYuBIwu9Sh0W+UywJ4mEGYtEiirfLHm4Y2rYlogNnnBB7fuvIR0pdvtNAdgXmcCnsnk3N35VqMQcpu/mCNmufhdiGKiLU5868yqXGMsVXINlk/fd8HSfB95+jLnu6kb6uUoCw9gAHanczajOfxdXNs3OugK2JkW+EYPnOBNeBdlb52OaxlVv/F5Wwh2LXhW6TKVz2HPc2fD8Oz0+NHWOkgHUZ+4ohd/YehPO7GmbHnIVWxEMKfbs03qbAIvkkC3zmD7WZlBGJ2O5+QeBYewCKy+0hJECXU0Skj18JL4990sfFLtSY1h3ceLDRbK5MNHADXkvO4ljk+UAbFQwIaZAEr7DYOzvtMdAc+f4my1xD5lVCadX43hW5mNIRhHFtebnPxD7537K/EWVEOfUHDGd0TCFshzU4a0C+n0rvWfhwdA0fVmq6JJP1F/2gSPeSCeaaguiFEm6VeMln4dldU2GobhuIwO82m3OO98ak8neYUfLGzNku+HPHfvMuUw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(38070700021)(11063799006)(56012099006)(10067099003)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WmQvOGJkWjVQY2wxdlpxb0dTamtrRFhwOXFrN2pmUHJZT1RYN0FpWDRWNDBz?=
 =?utf-8?B?U09DRXZsdWZMK1hGL2NPWkFOQ1JUQXZqc29hTFQvS1pCVHVzcUc1eS81QVBI?=
 =?utf-8?B?NXZDNGM1M0RGK3RKMXVva2llZzhhMlJmVzdjRFQwSHp0UmwxV1hCYnBrbi92?=
 =?utf-8?B?TFo2UHZzVEZjZFB1QVJKb2wyWkJNcjI5c3l5Y0JFRmlWVkp6OEdDY0Q4a3hV?=
 =?utf-8?B?RkRDL1pJRithZ1NLUVhON2hYVjhnMXlneGZ4UzMrdzdlSlRpdGcyVVlYREM0?=
 =?utf-8?B?MCsvdTFSbitOTmJvSnhabVhGVUhlMHc5WXdpN0wwNzZiWE9xVmw1K1JVVEhF?=
 =?utf-8?B?aUxwYW1vamxGbFE0Y0NEcHpVNi91bkdIZ1hTSnd2ZGx5V05pR0NtV3BkWWFy?=
 =?utf-8?B?Q1p6bkpYbkVHYU9HUjFwbWFtVkhud0EyODduZlpUVjN3cHBKaHJFTzJpYWxP?=
 =?utf-8?B?RGxqWlpTL1Y5Q2JmV1RtTkE2VW1KdkRpa2VDTmdmNkN4TWxsR0Z0NkxweFZq?=
 =?utf-8?B?VkZ4VHp3cEx3NHNMM1Rib3pUSDhNcG1ETWtzOTZYR0pmWW1iL1Fza0Z4VDR0?=
 =?utf-8?B?M3REOFQxYlFYRVlMR0NQRVBvcDNQa0NHV29PZEc4WmNUd0xJK2xMYzYrNDVE?=
 =?utf-8?B?a2cxUU9LSjV3Wm85aHE4UXNObFJTbVNuaFRyUDM2ZmZUWmFaYzVOY3hFemc1?=
 =?utf-8?B?clJyYUJ0Tmt3TDdscG0zVG1rYVM0RHRhRVptS1ZVa2lNTVVyY0pWblBaQk9D?=
 =?utf-8?B?OWo1VmRVUlo2eFlmT2dySU9YY3YwWVo5MThpU3F4UTRQOVFCQWljQ3FtcHI0?=
 =?utf-8?B?QUlLcjltNVllaW5BaDVCOGIwS1VINUVIdG9wUE92M0RCTjkvSGo4bUF2Zmt2?=
 =?utf-8?B?OTIxaFVyWkU5YjB5VnBFWHZHWk0xblVVT3l2d3NSOUE2Q3VScCtnOGgvTVNh?=
 =?utf-8?B?MGNoSUtPYVJZbWwyWWNQZFFrdkhKQUdZbXFWL3N3YjBVcm5NQnZLQmk5cDBX?=
 =?utf-8?B?OXJzQTZFZmxhUUpMTE8xQklEUUhqK0F2T0Eyc2lLVzUyb2hoMFJhM2ZTaGZI?=
 =?utf-8?B?STNPT1I4ZE5IZHVGZWFOVkdTMEkrMVhha1N1VmUzM1NSWkFQeFlhc1NWVXZG?=
 =?utf-8?B?U2ZrTks4Z3JsN2I1N2xNVWt2UXBicmp6U2lpRDJKWlBYcHBuRzd0bTNmbDFs?=
 =?utf-8?B?NExlTEpKbHNDTGZEYU5HcXBGUjNGeEQ1REhaM1R2bFNvdFMzdTBCcUhNMG15?=
 =?utf-8?B?cGliWVFVYWcvMmpmTFByZUdEQkh5S0ZnNm9RV00rdWtVMzI4TGgxYkRPZjUy?=
 =?utf-8?B?YjI5bVN5cVlkK3ZxaXdNVHN4aDRHM0FtR2lHM2hmKzBEdW9Lb0R3UE1WR0Jl?=
 =?utf-8?B?K2J5cWhsSlNvNXYwUjJXUmM5NXlRYk5kR0Y2SGd1SEQwN1RUQzMvc1ZpdnQr?=
 =?utf-8?B?U3VoM01lT05zem01WC9FdGJzSlA1bEVSUUYvZGhpU2Yra0xFWEJJcUFJbU50?=
 =?utf-8?B?MklDMFc5TEJOaDVoYzREVnpCbFczUjNsREE0cWdoNW01UTk4aVFyMVJTVXNw?=
 =?utf-8?B?WjA4NmVLRlVKekJDZkwzWVAva0JmS1RlNHl6b2ZMWEtBWUFabkZ3b25QMldY?=
 =?utf-8?B?aFIwTldMbXJxU1NBWDVxenlsWWtLalpzM2p4UDRSOUZCYVRhQmZ4d2l5RDln?=
 =?utf-8?B?enRMcFRDSHJWNjc0enRlN1hTQ2ZSSWlqMytleDJzSTlzSCt1T1F3WWJhTFps?=
 =?utf-8?B?OWUzOGRHM1RRVksxcFZvVGVUbTUxYjhKWEVyUjd1LzB4ejlaVWxvRjhHK3Y5?=
 =?utf-8?B?WG9EMWl0TUJpOVRPTkhwYkRwL0lldDg2OFBSZmFTU1l4SkJ0VTlmWG11M2dQ?=
 =?utf-8?B?UW1RYzRzcWlWbWVkYjRiWFZlRjVUdVVxcXpjcE9BRW9ONjZLckxGSGRlMmtr?=
 =?utf-8?B?TFR1MmNxTkhYeEdkQzhLU2tkcmFtQk9iUUwrMzNLNkRvR29jcGRQeEZrTnEr?=
 =?utf-8?B?enZhd2k3aWpvT2pvOEh0UWlGMm9KbXB3aGUyVVE5WEpSNUlGbTdWYlJRaGtm?=
 =?utf-8?B?ODdGWlZWUEwwQ2dLTm5sQjdMdGVoZTR1cTBXdVo2dFFGMkRIOFdVcmdqand4?=
 =?utf-8?B?RXgyZk9BM2E4bHdVZ2dMR1BVcFV2dEpqTEhpNjlKVm8wSmNtak9CNTJNSWY1?=
 =?utf-8?B?UXkyUEpBelVUK0RpQ0xzSDBXcnpQaHpVRDJXWVR4T0J0WFNyalZRSjU5d3hh?=
 =?utf-8?B?dzVRV2F4bzdsZk81am03UEp1bkxVWCt6VFhOVjIzZGxPcVUwS3F4SzVJbUNO?=
 =?utf-8?B?YzV6QWpmTm5KNGF1VXlocmZ0YURhSWdQZWNQUjRKUi83Vy9RNngvU3pIZy9i?=
 =?utf-8?Q?t3fUniBhzZOElUBwoBlcfskPb3E/NSdyJSAI4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E59203F9B745424487E202A2934AF1C6@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qGbzmECzf/2NwTheDYEPpB0Srhex0h93lDTpp0Tcp7Xi+weT9aGjmXJtJKa/0QIgZJ5aWx2oHE9BpT/26bA3XofVMO2Ycq3MvBc+VSg3fOz7Y7LizsPKMK3yR1TiEgLcoGZuoyqjYRypFCXv9z1j2Ljq4Mqvon/mi7MW4/KKOTFzuLPN7wuuBZesHt/hzYr1h9q2jObDQMfMNnaIYfmPMVtMmFiEurNuZpnJrHgjdUua43ERwmYPLZO7gt/LZigz0ZV04yN74wwvJ5p0rpg1eL+dYFoDDT64BWcZoGBZL6BBVyvC48pNQs1As2JflTY4P+IonGtoUfVSo8BEU3B2uA==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9634c6b-bd45-488a-2a84-08def87b19eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2026 14:07:53.2307 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0cP44qjmEVgRxNq/DxDox2Mn3uQwxVMEvCe2DV+FLNO/EBYdCjIWZduA8i2QAOOB9q5WrB9POZRXz4RjEs+Ekv6JascCjHSfPYpPb9vwWVo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR07MB12040
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@bull.com; helo=smarthost1.eviden.com
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

DQpPbiBXZWQsIDIwMjYtMDgtMTIgYXQgMTM6MjYgKzAwMDAsIER1YW4sIFpoZW56aG9uZyB3cm90
ZToNCj4gQ2F1dGlvbjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9y
IGNsaWNrIGxpbmtzLCB1bmxlc3MgdGhpcyBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2VuZGVy
IGFuZCB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPiANCj4gDQo+IA0KPiA+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogQ2zDqW1lbnQgTUFUSElFVS0tRFJJRiA8
W2NsZW1lbnQubWF0aGlldS0tZHJpZkBidWxsLmNvbV0obWFpbHRvOmNsZW1lbnQubWF0aGlldS0t
ZHJpZkBidWxsLmNvbSk+DQo+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAwLzZdIGludGVsX2lv
bW11OiBFbmFibGUgUFJRIHN1cHBvcnQgZm9yIHBhc3N0aHJvdWdoDQo+ID4gZGV2aWNlDQo+ID4g
DQo+ID4gDQo+ID4gT24gTW9uLCAyMDI2LTA4LTEwIGF0IDEwOjQ5ICswMDAwLCBEdWFuLCBaaGVu
emhvbmcgd3JvdGU6DQo+ID4gDQo+ID4gPiBDYXV0aW9uOiBFeHRlcm5hbCBlbWFpbC4gRG8gbm90
IG9wZW4gYXR0YWNobWVudHMgb3IgY2xpY2sgbGlua3MsIHVubGVzcyB0aGlzIGVtYWlsDQo+ID4g
DQo+ID4gY29tZXMgZnJvbSBhIGtub3duIHNlbmRlciBhbmQgeW91IGtub3cgdGhlIGNvbnRlbnQg
aXMgc2FmZS4NCj4gPiANCj4gPiA+IA0KPiA+ID4gDQo+ID4gPiBIaSBDbGVtZW50LA0KPiA+ID4g
DQo+ID4gPiANCj4gPiA+IA0KPiA+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+
ID4gPiBGcm9tOiBDbMOpbWVudCBNQVRISUVVLS1EUklGIDxbY2xlbWVudC5tYXRoaWV1LS0NCj4g
PiA+IA0KPiA+IA0KPiA+IFtkcmlmQGJ1bGwuY29tXShtYWlsdG86ZHJpZkBidWxsLmNvbSldKG1h
aWx0bzpbY2xlbWVudC5tYXRoaWV1LS1kcmlmQGJ1bGwuY29tXShtYWlsdG86Y2xlbWVudC5tYXRo
aWV1LS1kcmlmQGJ1bGwuY29tKSk+DQo+ID4gDQo+ID4gPiANCj4gPiA+ID4gU3ViamVjdDogUmU6
IFtQQVRDSCB2MyAwLzZdIGludGVsX2lvbW11OiBFbmFibGUgUFJRIHN1cHBvcnQgZm9yIHBhc3N0
aHJvdWdoDQo+ID4gPiA+IGRldmljZQ0KPiA+ID4gPiANCj4gPiA+ID4gSGkgWmhlbnpob25nLA0K
PiA+ID4gPiANCj4gPiA+ID4gSSB3aWxsIHJlYWQgdGhpcyBzZXJpZXMgZWFybHkgbmV4dCB3ZWVr
Lg0KPiA+ID4gPiB0aGFua3MgZm9yIHRoZSByZXNwaW4hDQo+ID4gPiA+IA0KPiA+ID4gPiBidHcs
IHJlbGF0ZWQgdG8gdGhpcyB3b3JrOiBoYXZlIGV2ZXIgc2Vlbg0KPiA+ID4gPiB2ZmlvX2Rldmlj
ZV9nZXRfYXdfYml0cyByZXR1cm5pbmcgNDcgd2hlcmVhcw0KPiA+ID4gPiB0aGUgaW9tbXUgc3Vw
cG9ydHMgNDg/IFRoaXMgbGVhZHMgdGhlIGZvbGxvd2luZw0KPiA+ID4gPiBhdyB0ZXN0IHRvIGZh
aWw6DQo+ID4gPiA+IA0KPiA+ID4gPiBgYGANCj4gPiA+ID4gcmV0ID0gaGlvZGMtPmdldF9jYXAo
aGlvZCwgSE9TVF9JT01NVV9ERVZJQ0VfQ0FQX0FXX0JJVFMsIGVycnApOw0KPiA+ID4gPiBpZiAo
cmV0IDwgMCkgew0KPiA+ID4gPiDCoMKgIHJldHVybiBmYWxzZTsNCj4gPiA+ID4gfQ0KPiA+ID4g
PiBpZiAocy0+YXdfYml0cyA+IHJldCkgew0KPiA+ID4gPiDCoMKgIGVycm9yX3NldGcoZXJycCwg
ImF3LWJpdHMgJWQgPiBob3N0IGF3LWJpdHMgJWQiLCBzLT5hd19iaXRzLCByZXQpOw0KPiA+ID4g
PiDCoMKgIHJldHVybiBmYWxzZTsNCj4gPiA+ID4gfQ0KPiA+ID4gPiBgYGANCj4gPiA+ID4gDQo+
ID4gPiA+IEkgZ290IHRoaXMgd2hlbiB0cnlpbmcgdG8gbmVzdCBWTXMuDQo+ID4gPiANCj4gPiA+
IA0KPiA+ID4gDQo+ID4gPiBJIGFtIHRyeWluZyB0byByZXByb2R1Y2UsIHdoYXQgZGV2aWNlIGRp
ZCB5b3UgcGFzc3Rocm91Z2g/DQo+ID4gDQo+ID4gDQo+ID4gSSB1c2VkIGVkdSBmb3IgdGVzdGlu
Zy4NCj4gPiBBbiBJIGhhZCBhdy1iaXRzPTQ4IG9uIGJvdGggdm1zLg0KPiANCj4gDQo+IFJlcHJv
ZHVjZWQgdGhlIHNhbWUgd2l0aCBMMShmc3RzPW9uKSBhbmQgTDIoZnN0cz1vZmYpLg0KDQpNeSBj
b25maWcgaGFzIGZzdHM9b24gb24gYm90aCBWTXMuICANCldoaWNoIGtlcm5lbCBhcmUgeW91IHVz
aW5nPyAgDQpNaW5lIGlzIFJIRUwxMC4yICg2LjEyLjAtMjExLjcuMy5lbDEwXzIueDg2XzY0KQ0K
DQo+IA0KPiBJdCdzIGV4cGVjdGVkIGZhaWx1cmUgYXMgZmlyc3Qgc3RhZ2UgcGFnZSB0YWJsZSBv
bmx5IHN1cHBvcnRzIDQ3Yml0IElPVkEgcmFuZ2VzICANCj4gYW5kIEwyIHdoaWNoIHVzZXMgc2Vj
b25kIHN0YWdlIHBhZ2UgdGFibGUgc3VwcG9ydHMgNDhiaXQgSU9WQSByYW5nZXMsICANCj4gdGhh
dCdzIG5vdCBzdXBwb3J0ZWQuDQo+IA0KPiBUaGlzIGlzIGRvY3VtZW50ZWQgaW4gdnRkIHNwZWMg
My42Og0KPiANCj4gU29mdHdhcmUgdXNpbmcgZmlyc3Qtc3RhZ2UgdHJhbnNsYXRpb24gc3RydWN0
dXJlcyB0byB0cmFuc2xhdGUgYW4gSU8gVmlydHVhbCBBZGRyZXNzIChJT1ZBKSBtdXN0IHVzZSAg
DQo+IGNhbm9uaWNhbCBhZGRyZXNzZXMuIEFkZGl0aW9uYWxseSwgc29mdHdhcmUgbXVzdCBsaW1p
dCBhZGRyZXNzZXMgdG8gbGVzcyB0aGFuIHRoZSBtaW5pbXVtIG9mIE1HQVcgIA0KPiBhbmQgdGhl
IGxvd2VyIGNhbm9uaWNhbCBhZGRyZXNzIHdpZHRoIGltcGxpZWQgYnkgRlNQTSAoaS5lLiwgNDct
Yml0IHdoZW4gRlNQTSBpcyA0LWxldmVsIGFuZCA1Ni1iaXQgIA0KPiB3aGVuIEZTUE0gaXMgNS1s
ZXZlbCkuDQo+IA0KPiBUaGFua3MgIA0KPiBaaGVuemhvbmc=

