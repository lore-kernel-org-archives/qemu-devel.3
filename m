Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14203CD4F25
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2026 08:07:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOA2m-0006YY-SO; Sat, 16 May 2026 04:06:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1wOA2l-0006Xg-3k
 for qemu-devel@nongnu.org; Sat, 16 May 2026 04:06:43 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1wOA2j-000167-CN
 for qemu-devel@nongnu.org; Sat, 16 May 2026 04:06:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=bull.com; i=@bull.com; q=dns/txt; s=mail;
 t=1778918801; x=1810454801;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Zf9TCB9i/YZ8QD0JGlT7GZk/yIgBZhPWNaYAzuRCdFc=;
 b=pvZu1alIqTL1jMig+rL/e+/vQ7J9R0VLvz1nU8EgNb/L0C0uVRztfYtx
 Ojpo+/xUcuvxcUtP5G1PQ6wRse8MRiTgxCvTaBnok6tZwfBDe6jPuQCVR
 fdThoNFOOaEHxDvdw5+FiY2uGA8j3OG0Ycpig9gf4u45wF6SsT9+rDt4u
 +fhOKV6S2hp1pdBTfwfYR0LTwdX9HOW+4lhvTZe9bwidnVlf510t0aX9s
 l6iLvM0HnBpbfrZ+RP+IswcAIy4Ly55dfqw2c9X6RH/UcPkM7wGsGrq6Y
 qcB3BvpgW3PK82ulktkH8f5sNw0Q7Q+QCzP+GRNh+rYA8W4A8xi8c8RE8 g==;
X-CSE-ConnectionGUID: eJm9G7cSTuyhhux8sakpFg==
X-CSE-MsgGUID: XstdKb3xSSO7IHLvD/xucA==
IronPort-SDR: 6a082587_U7Cs4Cr4iQuypcLqEimEKqcEUXwkxnbX83V4DxiQgad1Su5
 TdhYvghdEG3KzEgn6qGeb7VH6+Bfgkalyl5pANA==
X-IronPort-AV: E=Sophos;i="6.23,238,1770591600"; d="scan'208";a="48018413"
X-MGA-submission: =?us-ascii?q?MDEpPYxHuSRYO7VOKE+1qEZ+evXw0reLimtj3B?=
 =?us-ascii?q?/DaeookBDmM1EbwVyGyutWtKJ2JI9+8wIAQ0RBSonmzh1XjvFOeDF9hK?=
 =?us-ascii?q?b1vIWdAZ5+CKYW7VEXLOMAf/CkpE/b0pMVuf32+bm+RdNc/6HjbP6HVs?=
 =?us-ascii?q?32ME1Dbm6hqqN4NxJ+Ar0zCg=3D=3D?=
Received: from mail-northeuropeazon11010052.outbound.protection.outlook.com
 (HELO DB3PR0202CU003.outbound.protection.outlook.com) ([52.101.84.52])
 by smarthost3.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 16 May 2026 10:06:31 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N9jXR29GvF9VJI1wJkR40hBevQz8jQBM6S9nH6ThkfdEAzX+9IpFf1EYPjRSYtFKulV11/NzV0X5HeyQxthJq+Z6H4Gbj8DPzBdNxJCDJp5usC+KyAcV1dRhlhAiG3doIHlPMXKflAqM1oGWRbf1nzFL5A80cKJJ256Y026Y0VzygjNPMaApJBhihk5/WQV2lyEl2Tt1tG+wwvM9W6S1DJYpe9tqIA4SbL1CU75ZfRdAEOuGPA31nqBSa+zX/IVIzBBQAdq/s60oD5nkr2NJFb9oM9Ns9+VPEghbqeEUY2Dp68rN6VhPkq4pwaTHQMu2qO/H22EAFJJ2jhWNXgDAXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zf9TCB9i/YZ8QD0JGlT7GZk/yIgBZhPWNaYAzuRCdFc=;
 b=FRYRqVMbGimAhgroUg3Q02xPM9nWMA9Lm7ehrd4mpZ4qsX8bMkNHMrlCGATwonJJPygiYWgrTqpSDH8Nk979cWhfARYNBF8Q38aEJgl2azav2xGQRAMyya2Hf7L03KiwLuWBAOs9j52taYUOrGMgZHYgNrzXq3wWVGFGt7YFi71kUGTQPRzpk16InfOi9UwkpftQxPIJH4bN0W1uR2W7EvcwbKL8qTTJ3pcfow3iZvFC9XzPr903KHry3PdI847ez5knKLeL2eYIlLemFoXoNl5RNnWhxlXuerULxCSTwIASpexXG8PcfLtbvR8VPm0+HNr06gC1JwB5nUy/uoULPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DB9PR07MB11255.eurprd07.prod.outlook.com (2603:10a6:10:60d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Sat, 16 May
 2026 08:06:26 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%6]) with mapi id 15.21.0025.016; Sat, 16 May 2026
 08:06:26 +0000
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
Subject: Re: [PATCH v5 15/15] intel_iommu: Expose flag
 VIOMMU_FLAG_PASID_SUPPORTED and VIOMMU_FLAG_WANT_PASID_ATTACH
Thread-Topic: [PATCH v5 15/15] intel_iommu: Expose flag
 VIOMMU_FLAG_PASID_SUPPORTED and VIOMMU_FLAG_WANT_PASID_ATTACH
Thread-Index: AQHc32mngwGX9VAyzESnoPhzrDIEDLYQVr4A
Date: Sat, 16 May 2026 08:06:26 +0000
Message-ID: <1930b1c51bff85ea947c331990b294f12567bf98.camel@bull.com>
References: <20260509040819.1044702-1-zhenzhong.duan@intel.com>
 <20260509040819.1044702-16-zhenzhong.duan@intel.com>
In-Reply-To: <20260509040819.1044702-16-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DB9PR07MB11255:EE_
x-ms-office365-filtering-correlation-id: f626c43b-d1f7-4fc2-f9ec-08deb3220754
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700021|22082099003|18002099003|56012099003|11063799003|4143699003;
x-microsoft-antispam-message-info: 77Zav3W7hGhnRipJaPBrAfJVAVbHm+zGgox6XXk6TYePQScvV9u1KvG1YoiNoLB+RU3QOthKiiEqrx3/UxTpqLf/spOvlM50R8r3mDeB0bOEH9+GuL8jK582DWnv+mXgDvya1BBLn7wR2r+/p6d6IG64qUD/YUSdrwrvBlX7xJRnD+akU83h9dBYJnFDa42N+cJxs+ShfHVTkJsGGOI836uDJ4VMg3kB0+cxTjNZKUZq6XwHZSUkdV63MQevOemkSsy3ijQRuH8Yzee779h+01qgQm/LFe2w6M543kpPnHKHccnURnYLyFSyDVaEheVkCWgWQEoLUplma+dbcU8fOKYyfOKlqCIDlZoE3x/7QxtzuRSCY61njt/YrunyXGL+YVDKI0D/b03tZrnmj9onnQfY0sHkR/dk88SAzd6caImIuT7Zm+lC2i0v9YYaOc9i+i1t3cIL7nWK9SGuCLadBaZJY1dSG6AS7CvObH3SP4azgerRtfraU2rh7Swsimnt++pTJ8tu+EKtY12R4rd2O3E+mg8W/glSw7qXO7TQ4Hg6vI+C+6/61MP4gg3QcTRAmKGvPyfaAaE5Hgn8vvtpGwSxWUxhoJ0dZY++KnoxwCHGsIbb4yqdkgeyA42IzbRVH66WjsISpef+QCYgZ6DPLpdSBpZBqp2YTDLlB41U5/sbFHF48Rz4H8HAg1xKOGJDX7J3af2/zxYiU12kHf1KlCUB6z8Qx/myRlkOCgSkdcLF9GmWEAb4x+xCRmk2+P2x
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(22082099003)(18002099003)(56012099003)(11063799003)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YzZEdEw5VHprZVAxR0tMSW13QXJXbEdMTVRvd2dCVFlzTlVPWTBvS1Rlem4z?=
 =?utf-8?B?bloyR2NpU3MwMU8yTmxUS0FjbmU2UWIvMmxQbjJTOU5GOURiZkxqaCtsQkNt?=
 =?utf-8?B?dkNXRTlSaUJLNVlCZGRuNm02QnN3Z0UvYTZ0WjRPN3JERjQrdTlJbWw1S21p?=
 =?utf-8?B?UEFpU3V6QTNQQm80T2h5U1ZqaEZiQ09QQThQL2ZiVFdDK25PU0Z5cDZKa24z?=
 =?utf-8?B?UmV4Y3Z6bXh0cWdVVGFnM0p3U293Y2dqN0tVWVBKb3lJLzd3UHprQ1RIMWM0?=
 =?utf-8?B?ZFZLOUEwYTBsd2FyUDJ4ZSs4S0t4OW5Xa2NwZjNvVEpaY0Ftd09uc1BpTy9h?=
 =?utf-8?B?SlJpNG82T2FJVU42cXhtZHFLaGlIdnhpMHBpa0Q3cm5tYk02NmM3L1hhWUhY?=
 =?utf-8?B?aFE1cGY4aDhHajdGeS9rbTMwT3c2TUVxV1IxTnd1d28zVHFIcGhXOVJMV0s1?=
 =?utf-8?B?NWkyVDZKbnY2RmticGlaaVBETFIzVE95elRDSUh6a1VZWVFhUHJiSDhSSlJk?=
 =?utf-8?B?NFdNOWhHSjBZOXZkcjhZdndKc1k1Uk9Oa0FLUzlwc1UyaHcxUC9vRitsTkJC?=
 =?utf-8?B?Tk52SjhiM20xVHB3U2FlcDlWZGtCU0tTYUQxRDVoZHFieW1kVk8xWlNONEl2?=
 =?utf-8?B?ZDMxUHV6amZyaVo4Si9SZXVqYzB6cWp2b0wwVXdjZXk5amowcmU2bjNIVERL?=
 =?utf-8?B?T09nTnRmK2gvNFlSaTBmanFRL1NDN3lONmZhUElyUSs0V3VaUjBWd3lzd1ZY?=
 =?utf-8?B?RlZ3aUpBeHRDU3RLbktlWVNVR1RTcWdWRXBZY3FmdDhGKzQwaXpPWU9OUGxs?=
 =?utf-8?B?UHhjQkowdG1nYnIyYnFRdTJLRVI3dlRtZmxSVVhqSlVYSDB0TXV1NHNSVjli?=
 =?utf-8?B?MDQyY2hJY3ZIS1F5a3pyODJYNldPemxDMWlTRlNRTjNyNGl5ek5TaGwxNTNq?=
 =?utf-8?B?RXZpc3lNb1dBc1Nlcm0yMG5CS1pkZ29WemVibFFTQlNoNXBVU1VvNG0vRHRs?=
 =?utf-8?B?K2w2TEpTYUc4cmRaS0RPRzhaODdvMjd6S1ZNU0U5WFpDM09VV1JrRVlQckZs?=
 =?utf-8?B?NnY2UnlMZVkzdURzVWxyQVcvTm0wSkpXOHEzbHhIVkc1QWtyalp6eHh2NnhG?=
 =?utf-8?B?QjNDVUxTWU0wOGpMb0JNSjdDc3lWV1BNdWdCNlk5bkEvNzFvbElENGZKMzBk?=
 =?utf-8?B?bCtYMEdxZUFyd0RXV1VkYWFSMXRIZ0F2aW5zSnF6b3pPZGYwSnArUXRnaDhk?=
 =?utf-8?B?Z3FXV215NEoyT1JMQTV2bDl4dXFFTGVWdXdhc21sRmNtMXN5M1NISjNlM3Ni?=
 =?utf-8?B?UmVNek83KzBQZkpJeXBtMGNTL1hpZ0g5cmc0TjJiL21EdnhDdzZCNnpUMzkr?=
 =?utf-8?B?RFhSNjg0WFJaM1Jnb3VqU2dMMXc1WktTdDZnbFhveTNLY1FDK05HL09MR1lY?=
 =?utf-8?B?MjI2ZlVhd2s1TGFNMmsyV1NzRlVtZkM3bHNiZ0c2SXMrZ1QwbHFFMHFPdml6?=
 =?utf-8?B?eEtPYU4veFg0NitKc0xwdjMyWHlrUWxkczZtMUUwc21CV0pLWGNYckRubUhm?=
 =?utf-8?B?aXA2d1dUTTV1enp2ZnYrSW8xRXpXWEN6UTJNRzhRYnp1cmcvWCtMYk5Oa1lS?=
 =?utf-8?B?RXV5MVhaS3YzekI1M2VHTG5JaDdET1QxcGJBaDIxRFQ1dDVxcEJmdzVrQlZu?=
 =?utf-8?B?VENHRXBqYW5mUWNmTEVkOWhyUTBMUHFEZjlIVHR6bE41VWFLOWVDbG16SW1s?=
 =?utf-8?B?ZzJmWlRsRTJVTmZNVnR6K21pY0tROVhLbHBBVEhMOGxWRWFkeEhqdnlnSXlY?=
 =?utf-8?B?T2ZXcVVML3R6aVZ3Z2RwdzkyejY0S2VRWVZGZHh0UTQ5enAremxPaXI4ME4r?=
 =?utf-8?B?eWFpcGgzVlhvSW1CczJFcTlNbk1BRGR1eFR6aVpmOG92RjFqV2NMQXY5R2hX?=
 =?utf-8?B?UWFqVG1EQTVIUWluaFBraWdJQ2p0UUw3MU5aWncvMjMreGxsN2JjVG9GR0o2?=
 =?utf-8?B?YTdwQkxwTlpvRVZnUWtCYmNiQTMxQmlwcmh3L2tTb2xYYmlMVEVtOWpVTnZL?=
 =?utf-8?B?bjdSR0tPa2ROT2NDbXNEbEE5TEdMWEJhTlJxR2orK2VmeGhwL1BDd0pUaEVG?=
 =?utf-8?B?OVA1eHZKeEMrQWFMaDhqN2t3QVFPbFQ4YXl6ZWxTazRvaDZJbEtTbFhUNUQy?=
 =?utf-8?B?aHdJak04RElXYTNTN21iZVpkSWpOV212SEZnL2pIQVdoNW1pSGJ0VmtKSks2?=
 =?utf-8?B?bXlETjBmd3BCYms3SU5YT2JEY2tEWkRQSG10OHlJYkRGZDZKeFE0Uk1YSjhV?=
 =?utf-8?B?VTRtN1VZWVg4RVJEMXZhdVl0Y1d2cFlqNFo4eFM2QUtoTlRZR2ZSd2ROVWJr?=
 =?utf-8?Q?oXwAf0cqzekQe0bQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <53C7AD06D551D7429081444E090E6214@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: VCTSmswDYB10aLlWSdCk05K3+PXq8sgvCejxEfN8LsJwmPyCdQlgJOt/ci68KWRCC84luQAhRB7NwiFvloHax/nwp9rKQpFlC5Rq5fFRPucot353AhBk57GTkfcpBOlmwW9Mx3OqQWR96QEZz2XoCAVAInoqc1bptnpchj8io8X2roJWSpuoOU3Q4OETDWmMhNJiXy2VRJKJkahsQvSWJ/1XBwrbnUDlTI4OTtMogZ/7t31zsE5a4AnFfoPnX0dPoHm53uC38MkjBKZdCT1NXLNLNme1MMb9YO2fqsF0bsq5nvCikgprjwQRtzh6ucoiLqwE90kx1dXpK+SBrE2QNw==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f626c43b-d1f7-4fc2-f9ec-08deb3220754
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2026 08:06:26.6430 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JApBlubPJ1W/PVAf1oiaC/b7kv0IqYbYt45ByGgkN+K4hr8FzUM1CR+rFo9KJtLBTaBlyopzNJcdzxCWk3lZ92PdE0Y2Nbb+CrJchPWdxTI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB11255
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
QGJ1bGwuY29tPg0KDQpPbiBTYXQsIDIwMjYtMDUtMDkgYXQgMDA6MDggLTA0MDAsIFpoZW56aG9u
ZyBEdWFuIHdyb3RlOg0KPiBWRklPIGRldmljZSB3aWxsIGNoZWNrIGZsYWcgVklPTU1VX0ZMQUdf
UEFTSURfU1VQUE9SVEVEIGFuZCBleHBvc2UgUEFTSUQgIA0KPiBjYXBhYmlsaXR5LCBhbHNvIGNo
ZWNrIFZJT01NVV9GTEFHX1dBTlRfUEFTSURfQVRUQUNIIHRvIGVuYWJsZSBwYXNpZCAgDQo+IGF0
dGFjaG1lbnQsIHdpdGhvdXQgdGhvc2UgZ3Vlc3QgY291bGQgbm90IGVuYWJsZSBQQVNJRCBvZiB0
aGlzIGRldmljZSBldmVuICANCj4gaWYgdklPTU1VJ3MgcGFzaWQgaXMgY29uZmlndXJlZC4NCj4g
DQo+IFdlIGRvbid0IGV4cG9zZSB0aGUgdHdvIGZsYWdzIHdoZW4gZmlyc3Qgc3RhZ2UgaXMgbm90
IGNvbmZpZ3VyZWQgYXMgd2UgIA0KPiBkb24ndCBzdXBwb3J0IHNoYWRvdyBwYWdlIHRhYmxlIG9u
IGEgUEFTSUQuDQo+IA0KPiBUaGlzIGlzIHRoZSBmaW5hbCBrbm9iIHRvIGVuYWJsZSBQQVNJRC4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDxbemhlbnpob25nLmR1YW5AaW50
ZWwuY29tXShtYWlsdG86emhlbnpob25nLmR1YW5AaW50ZWwuY29tKT4gIA0KPiBUZXN0ZWQtYnk6
IFh1ZG9uZyBIYW8gPFt4dWRvbmcuaGFvQGludGVsLmNvbV0obWFpbHRvOnh1ZG9uZy5oYW9AaW50
ZWwuY29tKT4gIA0KPiAtLS0gIA0KPiDCoGh3L2kzODYvaW50ZWxfaW9tbXUuYyB8IDUgKysrKysg
IA0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQg
YS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMgIA0KPiBpbmRl
eCA2MDY3MDY5ZTAyLi43MDU0NmU5MWQ0IDEwMDY0NCAgDQo+IC0tLSBhL2h3L2kzODYvaW50ZWxf
aW9tbXUuYyAgDQo+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYyAgDQo+IEBAIC00Nzg4LDYg
KzQ3ODgsMTEgQEAgc3RhdGljIHVpbnQ2NF90IHZ0ZF9nZXRfdmlvbW11X2ZsYWdzKHZvaWQgKm9w
YXF1ZSkgIA0KPiDCoMKgwqDCoCBpZiAocy0+ZnN0cykgeyAgDQo+IMKgwqDCoMKgwqDCoMKgwqAg
ZmxhZ3MgPSBWSU9NTVVfRkxBR19XQU5UX05FU1RJTkdfUEFSRU5UIHwgIA0KPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBWSU9NTVVfRkxBR19XQU5UX05FU1RJTkdfRElSVFlfVFJB
Q0tJTkc7ICANCj4gKyAgDQo+ICvCoMKgwqDCoMKgwqDCoCBpZiAocy0+cGFzaWQpIHsgIA0KPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmbGFncyB8PSBWSU9NTVVfRkxBR19QQVNJRF9TVVBQT1JU
RUQgfCAgDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFZJT01N
VV9GTEFHX1dBTlRfUEFTSURfQVRUQUNIOyAgDQo+ICvCoMKgwqDCoMKgwqDCoCB9ICANCj4gwqDC
oMKgwqAgfSAgDQo+IMKgICANCj4gwqDCoMKgwqAgcmV0dXJuIGZsYWdzOw==

