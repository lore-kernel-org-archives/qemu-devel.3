Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 732FAC5B569
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 06:39:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtg8V-00066O-J5; Tue, 11 Aug 2026 02:38:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1wtg8L-00062a-CH
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 02:38:50 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1wtg8E-0003Bg-P2
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 02:38:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=bull.com; i=@bull.com; q=dns/txt; s=mail;
 t=1786430318; x=1817966318;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Zq60CjVGP4bAsj9/wTSxIp42b+HQXyiULM1ZpTbN3+o=;
 b=biG0WjjWzT7EBh9RNRXuEg6Cmn8biCafRLJyMxuZOGwwF1WBh13wVsCW
 s9ks0b0z5+T/VfnQmLGqpCSYBXlcp2VlyRA4GFyRlSMhRnb5nuoe0it1L
 Zoh1pJgvx9s/+lj1e/LeGV2KYy2RTPAIaO/R+KBrGjyUbwQT5nBbUus0H
 o+KHjlUMldrAtRQgJ4FGsWJMCrvfAV33eQ/A4leurvcnMVrQczuNZI1eU
 KzAGMcG2CTyZuLODEC6Jd79m+eg6zGJwsj7CgSSyc/LYUBYr2Wz+v5JFz
 /Jo5nNU8h6qmyyQIw/DtPsFONzwD4tGmM1Wlo5qDuPDa11WGfd5v1UJJ7 Q==;
X-CSE-ConnectionGUID: 0qQZj9O3SOWw5d0N+GU5Ag==
X-CSE-MsgGUID: MULIFlCmQ4mVBktnLLDi/g==
IronPort-SDR: 6a7ac36a_fqqOtQA4k/MG3QdTC+mtmqXQkcWKy5pJxv1gU8zQJjqwtpY
 ZKbAqE8/XZOEvoIJh8B79lEL6rS+1/ip2OcjGtA==
X-IronPort-AV: E=Sophos;i="6.25,217,1779141600"; d="scan'208";a="48572220"
X-MGA-submission: =?us-ascii?q?MDHbMzOVJLIL4KV5E8ncmAcrBr+KaBjtwGHdZq?=
 =?us-ascii?q?GUgFMp2AeXtyu0LJhEMWSlvfjLarvUtO6cf9swWh4beGhdaeiEEREBoW?=
 =?us-ascii?q?1YKWhkCrX8hiwbi1DgVH3R7UOscEEhhVLi4gq2eKyH8XR4nqJ4EdtD1i?=
 =?us-ascii?q?iFepE+Kgop/esg50ln4ZfrdA=3D=3D?=
Received: from mail-norwayeastazon11013043.outbound.protection.outlook.com
 (HELO OSPPR02CU001.outbound.protection.outlook.com) ([40.107.159.43])
 by smarthost3.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 11 Aug 2026 08:38:34 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XNlxlZVHOeiA76QbxcIz/hlV2BoyrAmUybgQASuQoNHV1VMoDJ7qIuL5tZ+fTKZJuj5MeifLj81MJVKBrmOlDN16UeFCXQC8thwEAnJ11MfU2JwV15NpTrcqEW7azrp60JguvlqVpESC+YKUQMQRz9eqz//unHjzFRfyhoGUO3BJc6n/KdTyNtNdo8zFzo2FzGyvGdMvssl7JXvEtUR7hvdukYGB36x5bPaBmWyR3OwAfuf22+dg8ubdFWyiYUF5zFZInDAPL48ixFcwbRbZpRHt9gWaTctWJZ1h5CGrgl5K0/7A2qSkymtuyrG0q3D/IZSmUmlvntLIPC4jRallYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zq60CjVGP4bAsj9/wTSxIp42b+HQXyiULM1ZpTbN3+o=;
 b=C0S/jCDjsSS8HakHKgaPCxf93iRbxz9uqWMf+zI8jqaqWwD0VymwHb2C+23hWdl0bqoPU7/ul8bZGjTfVXbHpE03vfpDc7GgiM4cbzd4x2GM4rNb1PhVl5ebAJKMJBN+hVaygM1gJMYSS6qgM1m48j/P37X3wHYlp5Tye9nv98c7O+Me9OHyqsMpkL5JJWoXwWVNoRMwNUHgahx93tjZG5gpyUDfQyZSUwGrApqELkypMY1ysuX83JvkkrqzJt7YdnVjMpY6sOKheG/Z1LRmtEKJcrqY3jiiwCTbOp5ylAtDjYuUo3GRNRwsbh+TSLwoQcVf7opZ8aHLx5k3QHOsYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by GVXPR07MB12140.eurprd07.prod.outlook.com (2603:10a6:150:2c6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Tue, 11 Aug
 2026 06:38:28 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%4]) with mapi id 15.21.0315.008; Tue, 11 Aug 2026
 06:38:28 +0000
From: =?utf-8?B?Q2zDqW1lbnQgTUFUSElFVS0tRFJJRg==?=
 <clement.mathieu--drif@bull.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowangio@gmail.com" <jasowangio@gmail.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, "xudong.hao@intel.com" <xudong.hao@intel.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@oss.qualcomm.com>
Subject: Re: [PATCH v3 1/6] intel_iommu_accel: Guard VTDAccelPASIDCacheEntry
 definition
Thread-Topic: [PATCH v3 1/6] intel_iommu_accel: Guard VTDAccelPASIDCacheEntry
 definition
Thread-Index: AQHdJXanbXS/54v6M0uu0chwJkMSr7aYbRsA
Date: Tue, 11 Aug 2026 06:38:28 +0000
Message-ID: <099097ada213b5764eef133744f0b1047c314844.camel@bull.com>
References: <20260806073825.363468-1-zhenzhong.duan@intel.com>
 <20260806073825.363468-2-zhenzhong.duan@intel.com>
In-Reply-To: <20260806073825.363468-2-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|GVXPR07MB12140:EE_
x-ms-office365-filtering-correlation-id: 77de3df7-1da0-42c7-70c5-08def7732740
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|366016|38070700021|4143699003|10067099003|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: EB1Jmlz3NasUjUvh/5YCPtGyeQG8TIrmIhmRcDApXfH8k347YzEXKlKVxtTxYdjh/o/OisABZtqd1ETvR8r3GCJH4tx/1VJefXyZn6Yhi+JDJFsfOCRvKFWfndOxfmZYC1ppDhXx+usRZhnt0AJsiatUmFTzW1xosBFOspaVo9imsf42uS4UK40HfoHScTLMJwZBy+OQ3blvCZxLm6T1z0DmOy9kBV8nAnexxQJY5E62oHb12FtzTU2LWC6cCSoM/UTiNuLukJbr877xMfv6/lR9MAoimnF9dmKoUL7LhE7wEfVTj/mBZq0kWwtSorn4i0QvulGVtREu/z0ukqhBlZHreOc5PYv/HsK9qJbWq8LVk8wfZW2xoB+V1xmfiOetaZmLpp3jI2uA6GyNnHLXxE6fSAQczoaE++pIwJi73KjTIhMKyTznW9BZaRS1nQX8Fk/cVu9vUpH5C5FjKPOH9pOMIu6bY6FPVy9cdCWajE79eQMIPaTaG6SEK3mWMPEIhQn1qt741YomO5gWhluj8sUyxf76Zksj2JYthR+DQCMIb2PlU2uWhOoRNmYtf6PgsqfWqKe8TuWAY5xPaN6YSnD2+HxpqA3dj5HE8SG/VVCCcKN0Z9TCx5p2TNzHEr8xbGa+3i77W8ja95LG5c2mizi3l4Mf0dLdEBbEGTCWhI7wE3SLPGQNzvDET1kWy46inS8PkPWC4U/Tvxk1kh7xI1oP4Ksig3ZAH34czUNpI54=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(38070700021)(4143699003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWZMUW9kSWpCUUZwT1h2MVZ0ekxyUzA3U0EzNVYwTTBDeTVURGo4cGRtRGk5?=
 =?utf-8?B?cmhHdmR6WWtidTB3NzFNL2pCdXBCWHRzSndNWDFxNGxtQURLN3M2QWwzUEI3?=
 =?utf-8?B?Y0NVQytIVUx2ZTVPVWVqcGpjZEI3aWE3b3BBZFZxUmY3TW5NS09nU3YvRlBq?=
 =?utf-8?B?Z1prcG5jNUhhQndPNlMwR0UwdWljL2w2SVFwYXZrekJNK0tTbjVJVEZVWHJ2?=
 =?utf-8?B?RG5QdklYWThmQmZTV2Izb2VmKzUxenRRT2RIKzBneTNJdnNqdi9zMExjb2xU?=
 =?utf-8?B?eUQwYmJlTlZ0TVRCbmk5T3JIVk5McFN1YzhzcVJGMlVPSEN3Z0wrenBGM1ZS?=
 =?utf-8?B?N0xsbHFlbHBiVWhFZTFxbU13SmszdUkwUnZtd0Z6dE4rOEoyYnZaVk1ncVI1?=
 =?utf-8?B?bEJObUNqS0wwWktCZ2VvV2xVcDEvRytweFpJWDFKeStBbFFPeXhFeXBTbS9Q?=
 =?utf-8?B?RWNMZkNtMEYvYmdIemtjRGlKYzZHcElWMGYvaFN3R1FURTZmeFdlMTl6WHRu?=
 =?utf-8?B?bDZ3VjlqRm5TSGlxN1diS3EwWHVhbjJnd1Zib3JtM0orclp3UkZNaFdRcyt4?=
 =?utf-8?B?US9GdE45YjVrdTBUdWVDWkxHQkQ0VEhmVDU1SVU1MzRqMnBiNDFXYUdmMzdz?=
 =?utf-8?B?N3VqY3lXVy9DdFQydUtua1hIQXVSQzY5VlFQTjRSTmduc2dCVmFkUDRoMkhv?=
 =?utf-8?B?cGFHZlZkcmRWa1ZmdUkzTWtoNGtSaWMxbDdadkRXOWIrUWNaRlQxMnpUKzFs?=
 =?utf-8?B?VTdXQVgxalpoaXdDejRocnpHYnBKazJ3OURXZno5SG5MOG9FYnh0QWxBaHlE?=
 =?utf-8?B?ZUdMVGIrMEt3cVNqSGFvWG14enZvSWFkUnBlM0pBUVdmeFZjV0djc3plZzlv?=
 =?utf-8?B?bWNWZHlvQVBTekttME9YVXJJNmhNVnpxMUJ3QXpHOTZLMVE2eENqRXVNV1ZL?=
 =?utf-8?B?cW41WnhMREZjMHhxcGRrbGxwTjcvUXV6b1VmUERqdzdiRmpMcVI3VS8ybkd1?=
 =?utf-8?B?MHh2VEI1aG5MZ2pZQStRcElBVjdWa2pKVkEybUZ3QmI1VlV1a0JaTi9KdU4y?=
 =?utf-8?B?d25tV2NGcS9UMDU1VGRBVkVOSEZlaVl4MzlPSnRGZTJJeWZLSmVJTVNha1Vw?=
 =?utf-8?B?ZGZCYkkrTDNBd01rZXNGbkdTUlpyL2NkeGxxWHUzNXpmYnQzUERPQ2w2QlFu?=
 =?utf-8?B?eFFURUQ2OERxa1ovUE9lY3duYmFrZU1lVlJLVHVGRVl3c2NyOFFRNWVRL0Np?=
 =?utf-8?B?TTM2MVcwZnFSSmFKTWh2aEpuaUgxcTY3bWR6VytVbFI1ZjBOeXhSMDZlZ0F6?=
 =?utf-8?B?NVVtQmxvVWRpM1hOUlFod2JVeXJDS2RsNmtVUHY1MmdDYWREUmZ5dUIrU3Nj?=
 =?utf-8?B?Qis0TXlpL2hkb3cvT1FwNVlGYWNoVHcwWFlTdEhNUWs2cFlGcWdteFVldnRD?=
 =?utf-8?B?ZFF6MEZiSGJLSXNja2xyRDFDYlVHM2FHMEtuYU5MZmZ0VlovVVYrWkx4WEVi?=
 =?utf-8?B?OVNRNnVtYW44M0VvSGt6WTFLK2p5Ym4rRzZ1MnZmbHVTYjhKQ0l4ODZzSzZ3?=
 =?utf-8?B?K2kySm80TVRRemVjSnBJK3NUVUozT0NKOUFjQmQzckU1L05NdkxvdytjQkVZ?=
 =?utf-8?B?cmNSNVdRUGJDd1g3TjZaR0NQc0V5VEY2d1dVcDlxbjFGQTh3aUY2UEpzNFpF?=
 =?utf-8?B?TmN6N0tlb2FIV1NvVnNYdUNEcFVsVTVzT0ZTMzFHNm9ESXVFcHQwZU5QWHBo?=
 =?utf-8?B?R1dFajdhaG1hZmhiNXJsMWRHcGh0S0NzNUxrcFZxck4vL2hhRGxQaG91K3dY?=
 =?utf-8?B?c2xpRHY2MHM5ZFFMVjl6RmllNm9mOStEWFpkU1Jvc29pSTVGY1l5VDRIbisr?=
 =?utf-8?B?SkRzWmlSZTZIRm8xWnVuZWJWTnR4RWEyNEt3QmczZTRqNEVBVDhTcVpTS3Z6?=
 =?utf-8?B?TExnc3p5bmM0Q25SakdZSFQ0TEhjRnhDcEg2VFJNVnBuTXBMek1NZG4zNGFK?=
 =?utf-8?B?S2psRnQvVWpyYmRST0c0Rkd0TlE0aU1QS2l5bG1ObnVaZG5MWkh6YmFpeXM0?=
 =?utf-8?B?K0kwaUVNUHFGd3drYUN6MVpob3A0ZjNCL3ZlZC9Eb0NLcm9BeXFkUzZCR2Rs?=
 =?utf-8?B?Q2JQWlp1bG1BZk5mYk51YWZqQ214VjljeHk0bjM0NEVWcDFaVUVpV1RSanBo?=
 =?utf-8?B?c3M4eElXdVUxTGRaLy9RWWxuRDg4Y2ZyOTA5dFB0cWtEcnNRVkdsL2ZXdGhs?=
 =?utf-8?B?endqMUM4d0xCbEdFUklYeHovOXQ0YUJLSmFUN0s4RkcxTnkyQnVicnk4dU0x?=
 =?utf-8?B?aUYyM0lBS2c5M2FOTnZkbzJzMndHWG91dzhHNHIzNTJ3a0d5cldZSTN4K3g3?=
 =?utf-8?Q?BMP4g3mj0vKNPd9Ho+m4Am9a24HT/MfASeG9w?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <27427E6AA042ED4C9AEA1FF17E2475CF@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: c7oyE4GH3eoAYqkU0oYpkZ7yXszACGlPAcHwHpMUHHXKIqNjZxv4hYjLjKSjm17SBpV+1ajD0MJ2J9hmFyNc1MtTjLJYRXmU9k9v1lfmoei/bReJX7TXeCYpX0g/rhD9BbOK8hV44q92ox3q9x5yDfPmNh9DmNhJ/V0DlVsd/cQh4cUaWbNdAy2ckfsL4hTP+GhqOqXbzxO8JKUW2fzJNcmA1RyeqW0c70gRBaQk4TtOXG4UCNHwpXjtiijxb+EGsw2tZH8Zdc2JUwroqkpevajRd1hUc7h6QzRqU1kzvB5p61N+B5UHOAKqPc4m/SwwGT9KWfeaUqwytTv5eeiEpw==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77de3df7-1da0-42c7-70c5-08def7732740
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 06:38:28.4899 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6RYzoKRn6uhuet659FIHHVUO/JeBhBwWmNlyS4emcIVOlLAP5yk31NKHoL8+eJmXtexv3xEKuUt1QjEWlFc+FHSzOiH3MhsbUibyNuo5luY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR07MB12140
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

SGkgWmhlbnpob25nLA0KDQpsZ3RtDQoNCk9uIFRodSwgMjAyNi0wOC0wNiBhdCAwMzozOCAtMDQw
MCwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+IE1vdmUgdGhlIFZUREFjY2VsUEFTSURDYWNoZUVu
dHJ5IHR5cGVkZWYgc3RydWN0dXJlIGluc2lkZSB0aGUgIA0KPiBDT05GSUdfVlREX0FDQ0VMIGlm
ZGVmIGJsb2NrLg0KPiANCj4gV2hlbiBDT05GSUdfVlREX0FDQ0VMIGlzIGRpc2FibGVkLCB0aGlz
IHN0cnVjdHVyZSBpcyBlbnRpcmVseSB1bnVzZWQgIA0KPiB0aHJvdWdob3V0IHRoZSBjb2RlLiBN
b3ZpbmcgdGhlIGxheW91dCB1bmRlciB0aGUgZXhpc3RpbmcgcHJlcHJvY2Vzc29yICANCj4gZ3Vh
cmQgcHJldmVudHMgZXhwb3NpbmcgZGVhZCB0eXBlIGRlZmluaXRpb25zIGFuZCBlbnN1cmVzIHRo
ZSBoZWFkZXIgIA0KPiByZW1haW5zIGNsZWFuIHdoZW4gYnVpbGRpbmcgd2l0aG91dCBWVEQgYWNj
ZWxlcmF0aW9uIHN1cHBvcnQuDQo+IA0KPiBTdWdnZXN0ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUt
RGF1ZMOpIDxbcGhpbG1kQG9zcy5xdWFsY29tbS5jb21dKG1haWx0bzpwaGlsbWRAb3NzLnF1YWxj
b21tLmNvbSk+ICANCj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPFt6aGVuemhvbmcu
ZHVhbkBpbnRlbC5jb21dKG1haWx0bzp6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20pPiAgDQo+IC0t
LSAgDQo+IMKgaHcvaTM4Ni9pbnRlbF9pb21tdV9hY2NlbC5oIHwgMiArLSAgDQo+IMKgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9hY2NlbC5oIGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9hY2Nl
bC5oICANCj4gaW5kZXggNGE5MDAzYzkyZC4uNDZjMWEyOTQwOSAxMDA2NDQgIA0KPiAtLS0gYS9o
dy9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmggIA0KPiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11
X2FjY2VsLmggIA0KPiBAQCAtMTIsNiArMTIsNyBAQCAgDQo+IMKgI2RlZmluZSBIV19JMzg2X0lO
VEVMX0lPTU1VX0FDQ0VMX0ggIA0KPiDCoCNpbmNsdWRlIENPTkZJR19ERVZJQ0VTICANCj4gwqAg
IA0KPiArI2lmZGVmIENPTkZJR19WVERfQUNDRUwgIA0KPiDCoHR5cGVkZWYgc3RydWN0IFZUREFj
Y2VsUEFTSURDYWNoZUVudHJ5IHsgIA0KPiDCoMKgwqDCoCBWVERIb3N0SU9NTVVEZXZpY2UgKnZ0
ZF9oaW9kOyAgDQo+IMKgwqDCoMKgIFZURFBBU0lERW50cnkgcGFzaWRfZW50cnk7ICANCj4gQEAg
LTIwLDcgKzIxLDYgQEAgdHlwZWRlZiBzdHJ1Y3QgVlREQWNjZWxQQVNJRENhY2hlRW50cnkgeyAg
DQo+IMKgwqDCoMKgIFFMSVNUX0VOVFJZKFZUREFjY2VsUEFTSURDYWNoZUVudHJ5KSBuZXh0OyAg
DQo+IMKgfSBWVERBY2NlbFBBU0lEQ2FjaGVFbnRyeTsgIA0KPiDCoCAgDQo+IC0jaWZkZWYgQ09O
RklHX1ZURF9BQ0NFTCAgDQo+IMKgYm9vbCB2dGRfY2hlY2tfaGlvZF9hY2NlbChJbnRlbElPTU1V
U3RhdGUgKnMsIFZUREhvc3RJT01NVURldmljZSAqdnRkX2hpb2QsICANCj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBFcnJvciAqKmVycnApOyAg
DQo+IMKgVlRESG9zdElPTU1VRGV2aWNlICp2dGRfZmluZF9oaW9kX2lvbW11ZmQoVlREQWRkcmVz
c1NwYWNlICphcyk7

