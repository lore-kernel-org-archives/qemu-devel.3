Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E331C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 07:20:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHHFj-00018I-U5; Tue, 20 May 2025 03:19:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uHHFh-00017Z-W7
 for qemu-devel@nongnu.org; Tue, 20 May 2025 03:19:06 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uHHFg-00027W-Ak
 for qemu-devel@nongnu.org; Tue, 20 May 2025 03:19:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1747725544; x=1779261544;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=BFHl/TWNRbIvpJK5XA+uDm7thKhi8MptukB9vuywHMU=;
 b=SpuKWsZ/N9GnXbMKBrO6nuOL1znlHCTy6jEjs9L3XnScuwNAOmDKMRjJ
 wvZcFqZpZ11EUQxEAWi48JgnkRHUJ0MAMFC1gVv01ujFWbVC2I5gjKJj5
 y/Lq+aA7zvh59KFUYxk+tHwy9MghHsDsE8VTVsrRX3JC71jYpgnaVUjnZ
 cxV2YvwtF4fBpe8FYccxHlwqAGX9MFdsXw1/Qdp1AjnBiGuZ1/Riy9iyd
 gk18pfmrJgLjs6Eh3XF0dzoukZsn+7BypaVlJQk16dXggi+qGtfKqhZYE
 FhrAIt7WEjXgi/OpEW+AlNmFyJh+aQ0+PN3cYm3Tq0asQ1R/puRpmRcF6 Q==;
X-CSE-ConnectionGUID: HMaXqoz9S2ecFxVqw8kXFw==
X-CSE-MsgGUID: NxTR02CqQhO1PHElojDq/g==
X-IronPort-AV: E=Sophos;i="6.15,302,1739833200"; d="scan'208";a="37190741"
X-MGA-submission: =?us-ascii?q?MDFpL5f01lcG5mZAS7jnZIKbiv19iGmleMvBGx?=
 =?us-ascii?q?b6NxzZPJaiXH3w2TXs5KxtW+85q37qXP5i2KlJZP/yyHe4rppHhiDusd?=
 =?us-ascii?q?LEACX6gdoHu9G7Ze993oLP5XQ3LDogsvsymfVVfwxiTZ1/ZhzR2frxYk?=
 =?us-ascii?q?UKC+NZTYcuc08Z/ONkw9sWig=3D=3D?=
Received: from mail-am6eur05on2078.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([40.107.22.78])
 by smarthost3.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 20 May 2025 09:19:03 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d1iCayuUelyGqQZybP4FVwVvJ/m3QvoimOvkeBJ1HfLAGq9I+QntW4lId9A9MwLMm1fdNFSX5v0xx76eyPt4yIG0k5nVQxj+ONPsIImduYzaBxh+WNaRI5AiJh+gkK3a32/v45Arq0MAd2HpCajM0jLHrw8Fy9wBwke4YJF5OLtd0aeopg4eQt6WkVRu9rMIKM+Tj9VtuYJiyqgjKdWzVbEDJiCQUBN1BhjP1MBm3aPhW8sXzEQ0+6l50DGBECsKkZeaphiFmO4FUOebd/PAbk0H0ke2YimZFWuvuy5KvfnJgNLRSYTqUWQyXnKHfqk5lmnpaP3FNk7EFxSSwTNdsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1ltEV3icSh4NWhE4Ls3FmTVHBNbUBjWZTNKGBB1d/o=;
 b=hggVYtvegJ9AbLqwsUWmbkEx1LpRKr4f/4U1vbOrvtOLDMXiZ1dSnStdn0YPcP8SFuCL8Xqz7yOfnnpslURnTb6H2C7P6LWAg80NSJhmh11Gn1t4mHws4xzMb/AzvaJ7YtJ8S6Xc3BeUNe+wztPwz4Ah9qSD+6eCNz+LIsnTJiI2XpsdyZKmzY95Y1A+3vO961c7Q4UcaHtOB/pVA0PqmoKcKDZXCiKGa1DhMyUFT8qXpPBDRkdUdi8Sg64Dju9tlYXMlPz0DZLBk7hSz+pFRU7DxyriQKIu4ZVDvnL1NHlGfTmQJ3AhEJ3uWSiS1tWqj3DHUeFBDdmMPjzSqPGqDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1ltEV3icSh4NWhE4Ls3FmTVHBNbUBjWZTNKGBB1d/o=;
 b=WrmZHbWwlNLSs0vK1dwMgfNAvZpPEN8XbxMqvO6vtycnOii9YOX4FdE7eluw4+6h6sqp6XdpifoS0KpgJXuC9U22Uv2ZD6IMzSUGS+Y72lpJUXQjNO9n1rgX3+HHPc1F8rLpNZLFytFclt6VoGbX5I+k3cs7eSV6U3DVOkUY4hyhMoGzpq1PJ1+ECGIFSSvkng9aVjyxgtWFVpeeNQPewp+Hvt3uIa3xs6bdQZ4jFlS6Pe76ciL32pxKTzp1k9EcZduybh1u1ABdebznd3iaH9IQ6Cgf1Qd7hYNguP00PiR5foZ/Q4QWJ61t68dVJSPSszeBOGXfpENrm7p0X1k3Mw==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AM0PR07MB6388.eurprd07.prod.outlook.com (2603:10a6:20b:157::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Tue, 20 May
 2025 07:19:01 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 07:19:00 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "david@redhat.com" <david@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH 08/11] memory: Store user data pointer in the IOMMU notifiers
Thread-Topic: [PATCH 08/11] memory: Store user data pointer in the IOMMU
 notifiers
Thread-Index: AQHbyVd1X+3CWMVr306pfCyMBsfN+A==
Date: Tue, 20 May 2025 07:19:00 +0000
Message-ID: <20250520071823.764266-9-clement.mathieu--drif@eviden.com>
References: <20250520071823.764266-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250520071823.764266-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AM0PR07MB6388:EE_
x-ms-office365-filtering-correlation-id: 4cc1588c-7005-4db4-a6a9-08dd976e9809
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?t22ntsnt9V3lZQjO8rM4/JlCKPO7Ms+Fu3YNoAelXDVRvTILalVa2+NFXc?=
 =?iso-8859-1?Q?klVnVdkbg27JcAYw+4ki0lpIa310Go5OrZBawy6bbzEXOno867nq61tF8C?=
 =?iso-8859-1?Q?+Mwbo+2/4muqIz1DZTu9NOxUZ37PltmyfOuC0lEJvqOezivYmghSg74bRE?=
 =?iso-8859-1?Q?INJunPWImR1M6O0DXpl04mgvNsXoHtsq1vLLNk4sUu21C61S4qMEirew5i?=
 =?iso-8859-1?Q?j54uojCzxrpXtHiBfgTU/Gz0FBciNgFBdaDaML9Y0+ptzyStdLWyQ4Bkgc?=
 =?iso-8859-1?Q?O4nKNKCHtO2gP8tjeBjkorhwsortDeursTflYDwPuaD8MVo8nxtDhWvYS9?=
 =?iso-8859-1?Q?iPE+lfwNV8U3BX8Ct77jx45lxZooEFNHRh5pq4DDHU3SmeTYlewnOdvc3/?=
 =?iso-8859-1?Q?hSbmB17aMAt+317uGrbH/peUCXJrYxHOMLdrfVDE1On+wkjhSBjWw54Lqt?=
 =?iso-8859-1?Q?WIwGdL7Xv1gPv1avCxEcKRKxjY1xJZzJIweZNTuiuHnAkH5bnMeuB0TBsl?=
 =?iso-8859-1?Q?gwcepWxfPHHSV4tmQpsX6T6sQioS0DHoI0IE9+dlxN86Em0dx45Q5fJSPi?=
 =?iso-8859-1?Q?dEDQwMB9lqyHXngDt6ANyeHky8VlTJRMG3A0AL8dyrI68nycxA8fj39o4K?=
 =?iso-8859-1?Q?B/e5K0rvn6MZjMv7sHxEyxz4Fpyns6QnOK9QRGx7amxofrCAXVfCJ5aEWL?=
 =?iso-8859-1?Q?2WNy6MOzZA07UU4A3RMVmAJTJvOJKpGvgxeDHAHZF5myDYiKgex0GV5Mgl?=
 =?iso-8859-1?Q?IlhNTlNkYczLDw/1Zztb52uwb5JUCjOUyT0o3KsVg2gfdM4lXvdV2bNqd3?=
 =?iso-8859-1?Q?W+hEc9iK4/k4VBfrnKgJnT+2mPl8SGvepUYuVkOPVoaxbYsg7nOIchJc2x?=
 =?iso-8859-1?Q?PN4FhJ2NvPGch4ODo1gRokVPdSKqbuya4a8q1n7CLa7rFAbdDA0bataVG5?=
 =?iso-8859-1?Q?FJnx+cwBTcAa6Lwu7fukh2J/uSkbYNm2f5d/bwEsBk7qk4lw4/5Acr6HUZ?=
 =?iso-8859-1?Q?FSu9ME38xVTLBYfFtYXX8/ODNbIEvrlxeaBS0cPN7qHjTFT5JXoAsNOL0U?=
 =?iso-8859-1?Q?+bIQHzP5Eyhl2sr/FuW3WJ5y7+JgPz2759LBb3IiZRuEvwzwzyANXHuyqu?=
 =?iso-8859-1?Q?KMcYhbcFnf1WnL53de6K25UaVXUskPtE3mk+PdrIDmy6WWwUY33/yvlY7o?=
 =?iso-8859-1?Q?eV/pjEvKCqBqyBoNJrt1JT/p/m7dV81Ovnm63aLR9z3ruaCuL3zR+/IJue?=
 =?iso-8859-1?Q?fK3oZRDMJamLLEmu8/vffaN3DD8flJnq6Psu4Nw0An15P2ppSb1cgMdx/p?=
 =?iso-8859-1?Q?w2trvtIN3prvvecjKzEH+XFStbPN20tRFHPI8iP0s7D3Qs4joJsDwGPsK2?=
 =?iso-8859-1?Q?89+cSBg+850G6z09SLR3YmGr476vYvH5yz2QbybHefle2knySDhT4JRE5+?=
 =?iso-8859-1?Q?8dqviRP+bqn0AU5GyGgqW2xC/Bei5ySVTyuryYuQC4XhvpBxpFPPMB73It?=
 =?iso-8859-1?Q?kG0IiRpFGcYLF4R90bsJtRCwrQ0gJLdilgmku/eekQ0vfQiyhT6OI9+pgs?=
 =?iso-8859-1?Q?Roe9480=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?YfdPYYnaPKImA87Sk9vofi0DUqJ4pDqlSDNdxx+LBr5ZnOr22+yne4EckU?=
 =?iso-8859-1?Q?Y+YaOfCDUXgf8x2KoMiVNlRK7W6QBdZvs+7xgQ0Cfxvod98h2WauoKsnuW?=
 =?iso-8859-1?Q?2oXFbdukW6LxhQR/WBk+QSkXKVUslK1Rsj1eXL1pDCRdXfE7pO0tzE9eOU?=
 =?iso-8859-1?Q?gNCWFYFvLeSYJz5lOpbFV1j4FiFhMWRNLfftuUjShQg6otCLODzVdRItup?=
 =?iso-8859-1?Q?TfgupQyq+ycbz/22IVUdB7MGq1Va/Po1tV2KovudnsuuiRGMzVR3Ii1naN?=
 =?iso-8859-1?Q?NHGmcvXL77hnbdThz35K1LoPGrxRXyw3o8eJ+eOhefCQKEqS0LNyegDDBp?=
 =?iso-8859-1?Q?xnkgLtv0d2yGE6WEhVo/mWooiYqte7SzRdlUOpwD/CUmy2ZUqSzfUmn7gr?=
 =?iso-8859-1?Q?lbm/TyDD48tKfhQtaYSkYrcjqRUiqEyZIw5xl6OEVKsrM1ixC3PvQw3ZYH?=
 =?iso-8859-1?Q?8FBBynWtrz+wENh8CJ5Ggz0ngEv6Nfz1RYjhyLwxGlUMYELmb1+IF4qP7X?=
 =?iso-8859-1?Q?vBnsCJXR2LyQsFsH/CTMzBL+2IxqoDLt0jJM0hqSF5iG+fH5b0Sszyfrpq?=
 =?iso-8859-1?Q?NPArXnkbWqXzOwKd4BzMflG2aGxIIw5+oYKFy5aXkPBMGgxFWtVbLDZH65?=
 =?iso-8859-1?Q?v2KJyq94VQszgE/ai0wlSVYFKZhNqytwvAa5DRatejlTE1wsrm/qXhK+ue?=
 =?iso-8859-1?Q?EP9AkJcc7yfr9fl9hJpRe9jIJ53XA7sdZpxPiO5YjGjZgAd8JXIsth4joo?=
 =?iso-8859-1?Q?a9EZuWrfR0HE2goMn+RAigPE0s72msy+Pr6UAPBUPdt8J7mCt4MpHF3IHM?=
 =?iso-8859-1?Q?5ak5Ks5ad7Glbi6yt+Gz/MCOGAnF2m0L4r4CctC4Rf3PXlm9zqv+tRQvBj?=
 =?iso-8859-1?Q?+YJcDdyszvwXmpS5swobkOTLaayG657xjKME2lK/IniA0KzckcQDf14x81?=
 =?iso-8859-1?Q?TcUdjSCJ5UBOSU310DkdiosbVdRHbD5NFZW4Vya8jZ6I4KY5Fj9xc01Fre?=
 =?iso-8859-1?Q?YcD+raXsv15/9oJ6vnw3P0va5s5RcPZuT52cTuwQR/L49aOQDm30rIwCN8?=
 =?iso-8859-1?Q?322fstQSRIia1nY6fujpDgglDlJX/8bAnNCj2VF5C+zufAc5D/wbaH/6Rt?=
 =?iso-8859-1?Q?BzGF+0hH8PZq9wAHDCfoF7fWfxQ4nxNlqutDKYi9q2pG+QycNexXq/QTsU?=
 =?iso-8859-1?Q?lzY365CLoA2r9hcV3+vuBJG7XrxEHXQH2y0e2mKqEhtGU6Sg0U6tAXkiXX?=
 =?iso-8859-1?Q?smp5zStcFXupo88JoDECZt1RvCH9e7f+8cNCXSULpwsY37XXJifEUDDE8X?=
 =?iso-8859-1?Q?6wHBayKlKzqELOwZshdAn0VB9TT0f2pm1lGKG3K3Ub6BSiaFZKQPOMQyCa?=
 =?iso-8859-1?Q?sblmRT5o54UzPlagujWvMVnG30ncSEkwadDS6sE4DwC+VNk793S5Sl8Ijg?=
 =?iso-8859-1?Q?/zaClTllvIA49BXbYrEwhmNc4NLJivOSBFxxoRurik0bf6sQ7ivlE056z1?=
 =?iso-8859-1?Q?XMnuuKXeXTjENMGpNc+fKpC8oNM4LObwj5x5IQGlC5i3YGn29JvpSr7zzC?=
 =?iso-8859-1?Q?RKBUpLX9xFGYH1BtBv8MHBeLaIKDvGa2fVzsM6EacEh3F/Q54d5bj2GoWI?=
 =?iso-8859-1?Q?RWS0inxIQOEodaggVuzGFTrnDDzb73QBMPRysYTR1KgfoaGJG3rGwlNJGj?=
 =?iso-8859-1?Q?AjEtDwlZ9ibIH6jJ6Y8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cc1588c-7005-4db4-a6a9-08dd976e9809
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2025 07:19:00.8916 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tbDawwJgsWVDvSd3qBTsm3dykR+ahtF/4bR6dcaxd3QtQj53n9/6MM9sT8a94sODgwfvE3CsrULbMmB8mFAaUS1VyWCInWJmur5jpQAhgsvW8+mGvnJrul67UffePOOj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB6388
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This will help developers of ATS-capable devices to track a state.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 include/system/memory.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/system/memory.h b/include/system/memory.h
index fbbf4cf911..fc35a0dcad 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -183,6 +183,7 @@ struct IOMMUNotifier {
     hwaddr start;
     hwaddr end;
     int iommu_idx;
+    void *opaque;
     QLIST_ENTRY(IOMMUNotifier) node;
 };
 typedef struct IOMMUNotifier IOMMUNotifier;
--=20
2.49.0

