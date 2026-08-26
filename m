Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37877C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 06:26:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz75t-0007nf-Nf; Wed, 26 Aug 2026 02:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1wz75s-0007ms-8R
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 02:26:40 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1wz75p-00031O-Vl
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 02:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=bull.com; i=@bull.com; q=dns/txt; s=mail;
 t=1787725598; x=1819261598;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=vqOceC/ag6WSRiGZucREtF5DYn3jwaaO1bYy9gv1J74=;
 b=GriBu4t2vmM0SjITrqPoR4n3I3bK/MV9W6LgVY5sFZCUgVmjHGxqJcv+
 uTfwqsBXCgOl1+Alesr8Ks3xTePO5muz9DQEgrXsi8B6w0oWEbJFXFSnu
 KCKpcmu8xeufTVUa5GG+4r532bq3A6DAzaXlbMVuUUkxxirKivQ4b+85o
 1F0K4ltVD18fehEcqUIsXXKFi8wCTGmgowpzwNFPZgK7KOSTVGrGJ3Iwl
 l+h6BgTQ54VwfxXQOlDKTVhAQjySgI8ytnHucqs6poGejFYa5L68ozL9B
 qnN35DRZExNBpXULHmrqY80q9S3oAX6mAkUTl0LIzsE2Z7iLhTMxHtteY g==;
X-CSE-ConnectionGUID: otdzaHD6S3m1BiflnmwDmw==
X-CSE-MsgGUID: JjJGpfhqSqmcUKEjTrKhjw==
IronPort-SDR: 6a8e8719_IR57KOoJi9v3vDKM1ANDnjXbrw7O+UoIMvaAA6gocIR7LNR
 xu/bjZP3cUOvl1+mjyrPMpTUIyCZxWZ7zB0cQZA==
X-IronPort-AV: E=Sophos;i="6.25,244,1779141600"; d="scan'208";a="48651501"
X-MGA-submission: =?us-ascii?q?MDH3QJ1sYwnVPPtY3jJ/ZraOMdpe+oH81Q650+?=
 =?us-ascii?q?3cT1wioHJ/UqMe6vEu8SaRGWtLVKlYqKLho9iqBs378uxa9MAMZ9nD2Z?=
 =?us-ascii?q?ux2cPn65wSe0myWkk4J/4YA6kiha7jjvoxLW4a0URb45LY3iISLLVbtm?=
 =?us-ascii?q?tpcm69G87TWhrfbKXbyWXDgA=3D=3D?=
Received: from mail-northeuropeazon11011048.outbound.protection.outlook.com
 (HELO DU2PR03CU002.outbound.protection.outlook.com) ([52.101.65.48])
 by smarthost2.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 26 Aug 2026 08:26:34 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XO2X8Y/MHPRmWcxQJzxKSyQuDKDhJfT3BlYBX8qpuKL6Vuqi5/Mstew8uUEyP0oigwTp9+ND1uYCKVEf8PvBaNow4nqkwPPyedxMxLTFzzdmbB+HjcdiAiF4Q45wpT+vhtB1g1P1k1KWQmnH8/7S5ZduWEwiM4b1Y1O8yuOHdpjdw9oFI1DPz/5mCk+3YFqoA9cRM8/2iwBtcfC279r7LKV+QjHaJFvZavq/E3xeEQWDlq2sLHhJZ57oh+DCAbpSos7ndKwZSzS12W0SU7c4UQ6dUluj5RWBrVg2nBAf0Nd0W2ED7YtjBizVWKRH3Z9NLU/PZoQ93B2VqnWS2x7qNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqOceC/ag6WSRiGZucREtF5DYn3jwaaO1bYy9gv1J74=;
 b=LkX7r6CyRwLYLc1gXhaN2CIoPbzWbqQ+nLQh6MJf6/VKTSNxnASWmb+5kDjkNtYQDWEQpv8k0Sh+Hbck3RvW/ggnbTqc3wh+E1wMReS5ZtgEfpmSQR304qCmnc6AZh/nsafaDJLdBcX6IxM2R3O5/OrG6cIkDSe1woJtZpIYNF+1EWfTM6Kya/xaj7+76vjU2vg8tPibrT6iOInuTUwPSbKHnFC9Iwl21x8fXUiN1lNvc7S/dL7SzuuiPlZdYRVsS9ISODrrKb2Fs6YBgzdvvgiq9Au7MM3QTgeLCLZfYMoFWGjY5E/PvEOZybY2fkZE0fIL1khOGdPC/TRkRh+jKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB8056.eurprd07.prod.outlook.com (2603:10a6:20b:35b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 26 Aug
 2026 06:26:32 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%4]) with mapi id 15.21.0360.006; Wed, 26 Aug 2026
 06:26:32 +0000
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
 <yi.l.liu@intel.com>, Xudong Hao <xudong.hao@intel.com>
Subject: Re: [PATCH v4 2/6] backends/iommufd: Introduce
 iommufd_backend_alloc_faultq
Thread-Topic: [PATCH v4 2/6] backends/iommufd: Introduce
 iommufd_backend_alloc_faultq
Thread-Index: AQHdNGpglOpXenK6dU2UvegZYx18S7av3tcA
Date: Wed, 26 Aug 2026 06:26:32 +0000
Message-ID: <5e5d386a5b27e3731ce308ac4dc213fefed33b5a.camel@bull.com>
References: <20260825081814.138140-1-zhenzhong.duan@intel.com>
 <20260825081814.138140-3-zhenzhong.duan@intel.com>
In-Reply-To: <20260825081814.138140-3-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB8056:EE_
x-ms-office365-filtering-correlation-id: 1cc91532-e715-4b6f-0a04-08df033af89b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|23010399003|366016|38070700021|56012099006|10067099003|11063799006|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info: kVx3HzpYR1r62F0NTJD3XB1FUIiCHzZGUYjzHDCYittd8b8IpGl8XgQ2/oKrbq+sEW36pjI8bbJ0uD/j41mbJkFle5wwzd+XBVwRpUleVwsAyZWKYRGP2BTrWY5TXWbwvuxv5eP5IZM8XIbDU0N4cSM55tU3yVt+8QbQGIJNfMXgJND64fghNTX39na8BcUsRhAsOsEhTMwv+nXoaUVjS0U40d414Lk+2N058yPcoaKmOv7gGE94Foo9Yla7IQ6qr5Y+qa3lV5qZxpiLEHDITahpRoR2HMAt10ObEcNeW5H2BgPIPgbO8P/tyZcD9s7wJH9hdmNlUPkCZ5owUy1Bnakj915FZCgbLuP0ABk/d0ETV3pytTNW88/o5kqz3cvVoCXVa8OWIL+jd0mt/HjG5spHGl3qVY7QeqUmxYA3JKNBY+OianPdxH6oGxNB+zkYoEFBc5aL5p0WVo9P1NFXLgx4gI0v6qSBAmcgnBhXM7eDtBqwW6dGZMdOuWZ3NdwvesHlTlq7R5b4lUzuIQxMj/7DijpC5bdANgbanfcYJ1im3xdWPlmQ7coickhkKlXKpMljmZhOoK5LXR6jI+hddspGUJjOsg5U4x6sDfhLAwOvKePLl1W4xdjSevX8HwAZSFVaod3dWphYx/EnF8u5OKV+LBnui78N0l56RFcglJmAZWyaMh0xNfk+r+YRmJYIsjhfjzEzIqIA/AUHC0MeuBZOECHCePy25nTINbglzLY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(38070700021)(56012099006)(10067099003)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aHpFRlRwUmZaWk40Vmc3VCtGVGpNSzVIQlFZZkUrbzhjOFQ4SWZKcGtxdFFt?=
 =?utf-8?B?VDNuOVBxakVzamF3Y1RoYVBrVTI4NWZ2QTRqYzVzYTVjaFFDVGVFODdtbUs3?=
 =?utf-8?B?SkVBTHUxWEpGZk5lMUZVZmc5bStEaFpHOG5DcXoxeVhOaVMzTW50OXhVWXpM?=
 =?utf-8?B?VEV2bW1VT1dJVHV5aVMxVG45YS9veEdmSjZoNG5Bb2U2UHFueVFNR3dQY254?=
 =?utf-8?B?V2JVcWFyRlh6cjgvUkxsU2Rzd3hHS0daeFdwT0IxdDJBcFVDYnVmb2ZWNWlo?=
 =?utf-8?B?d2lwWE8vSGs1ZWZrU1F3cG1EUEpTQndJUDQydTU2dHdkdzVFMm1uRGF1T0hG?=
 =?utf-8?B?OEhxaHpwSExacFpzdTZybzJXQStWNmNrMHNXNW1FUzdEdW1NZk9pNFdvRCtC?=
 =?utf-8?B?MWhEeEU2K21vdFJ1OVBNeDdicjRQUWFWR05nWFRIeWdwZlc2YVlROVlVc1dn?=
 =?utf-8?B?WlBLMnZBamRjUUxZb24xL002eXJ2TGZyeDBGS0FOWm9QbW5Ed2p0NE90L0cr?=
 =?utf-8?B?UXh4a0w1blN1MFAyZW9ObXRwV3FDTXNmOFRUQWlzRG1IN0cvc2FTTldnM213?=
 =?utf-8?B?K09PQWJlbE1FcU83UTIyWFQ2aFJ6cExUc3hJQ2Rua1ozU2I0MGxSejBQcmIz?=
 =?utf-8?B?ckJJdGRzZUhWdE1sL1NPc3kxWjZ3SHlBT3JudUg1bkxoTlV5aGVFRlZFUDZP?=
 =?utf-8?B?RFg5blNEZFdvSVpXaFdVZWNrcDVpUmxGeHh1M0hENWgzN0dTamRNUDlpNkd3?=
 =?utf-8?B?OW5PZUdqL2JiL3ZhZnBYUytEK3JyOTVxVllTckdQSCtKWGpRTzhGVlBBbkUz?=
 =?utf-8?B?NnNIMFVmeEtWcmE3MGhQaU5MRERHMC9lSGZLQk8vdXdiV0MzaWNWUTVDb2E1?=
 =?utf-8?B?N1o4RjhWV25lcHo2SWJ0bFVIbUlvZUFHU21UUUpIMkZEMnhwSWJrdWI5TEx4?=
 =?utf-8?B?UkovekJ3ZzZxSWl3NEVJNCtBelczV2FpWkNWUjFjQ1JObHRQZUg0bGNyak1B?=
 =?utf-8?B?a0NLeXZlMGJQTWlsak05cG10ckpkZjJWZVlFTnNwb3RUUTN4dmJNK3JWTEEw?=
 =?utf-8?B?MEpmeDR3NnBJM1doL2dxWnB1VkpQZmhTNlgrbnJXZVdJOHJ0U21jWmFEK1ZC?=
 =?utf-8?B?SkZ5c0tNU2wrQjBuOHRaMlpWVk81cit5MU9rZjkrSnlZNDZjRnMvVkV5ZVhs?=
 =?utf-8?B?VVFndHJtbXRtVWV1ajIyYUN5OG04UEZ4R1RvUVhZRGJ6VHluVi8vS0paUXQz?=
 =?utf-8?B?dVhHNFBSQzhwa0RmUmppbXBJVnZnWmswcnp2MFJrU1d3L0puS3MxeEpNWmNI?=
 =?utf-8?B?enAxTFVFSXNWWUZWVThoSU84VnYwbHcyMitIOFliS1d1SkhnRlc4bWkvNnBM?=
 =?utf-8?B?MHJucU9ZUnBQMUVRU0ZLZzJ5YXIyWUFlTWJHNVVFZjRQaGxhaXEzblVLZVJt?=
 =?utf-8?B?azh6NzdrVU5IWnNFbzhzSXEvV09ZQUZYUHc0NlFadDRQRUpuWDRaUGRueHFD?=
 =?utf-8?B?dnJvbFVpVFhJTmpFdFRoZFczYVd6T2Nmd2hPWWZnNG80OGdPUlI5SmxxQWtI?=
 =?utf-8?B?VS9iMHpBVHhjZkUzUWduN1RrSnpiK2dxMnBoQVc2bVY2TkcrM1ViNjZkM3dE?=
 =?utf-8?B?bFVFWStqK2ZWRy94c3lUcEhyMUZUbVFsOUhVVkVDOFp3ZjdKOTZzV2ova29h?=
 =?utf-8?B?SUZJL2FmdlpWTEs3dWsxallZbjZBT2pHSnBQOTFqL0R4bkRVWTJ3OGlxT1Nt?=
 =?utf-8?B?S1FnRmpPZTRHY3cyRUE3TUFnWXByQkJiLzdtVENOR01NRVozQWZ2Wmdlejgw?=
 =?utf-8?B?NHZBSWZscVpJWkZwN2JMMUZUSkJDNHpHaUFpbktYcU96QkJ4TkdGMGpGT2ZQ?=
 =?utf-8?B?c3kvQ1VGUEdST04yTFJrS1NuMlQ5ZlRicEZSRmdnRHBBRVRpLzdjc2d0U2tL?=
 =?utf-8?B?MFozdE1TaDNxZ1JkK2N0dWNHM0YyNTJ6aE5wZGtRUktOTzk4b1BPYjdzNlpM?=
 =?utf-8?B?SXNVZDBxb2RtS05xWkNweUpWYXhXVktjdUN2cWxSeXkxcS9yQUpIVVRWem00?=
 =?utf-8?B?Wmo3QXRkWTBhL0F2VnE2VkthUTJHbHdoZllKYVVjSDlDU29TSGdlZSt4ZjRH?=
 =?utf-8?B?SjU4STJqRUNWS2NEY09zM1FqS3NMYVgxZEJheWxDL1JSQzJia0wyUHhWbmxq?=
 =?utf-8?B?M3RjMmh4K3FGaFNtTU1pamVud0hsL1BYc3RrNmpRdndZSi92Z3FRR1dwUzR2?=
 =?utf-8?B?K1kvdllhQ2NIYmJFRUgxOGtFRUFEeW1Cc2VTU1V0bUtreFZTdEQwcWY4Vk8y?=
 =?utf-8?B?MVAzbCtTL3RkclFWVWJzeUx0aWR5azZlYXZWQnFENCtPZDllMG5mNGo5eXkx?=
 =?utf-8?Q?yBG5oAaq7OCNm72UU4tkodE9TgHSYfMjkq3kf?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <97DB944A0E79984780B3B8511FDFF774@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: NTxQAp2FTqeIIYyIgy/v7RDP6Tcq7EhzWuOnILmGScYEf2sPQx+8WH9L7r5xowccS1cdLoMosUlSAW0rAlqKAJ+p6cIC0qHpMSVHxej0mlqfE0hETtCvY/0QiHY9O0JzUTaSmyk6iPBJ1ob1pkBNRHUlvRV1QJQTU81ZfguViUVIqReTSyjood811p6vbCBwGC6/WNui6nT2jr8ZVWKrEF5zh3WaPntxOzd/5q2AMC/N8A7zZVLgUenUFRBlHV7kByRbR8h+SW+l9qTpsfWyR4S96zFEr2oQ5ph1seErMbH6NveSR9CRu8HuPnRAAPrvqCDLzz5/E8shLKXxOIK0XQ==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cc91532-e715-4b6f-0a04-08df033af89b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2026 06:26:32.3330 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xEycrYW/YOtwxXj6E0ERqZhHt38hSYInZiGjysxR2QnH2XguS/t+9OncJCQS4zIf5SVY43GjIgJN9PC181+vUoHLkYcPStqkAkFNjEVHqTs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB8056
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@bull.com; helo=smarthost2.eviden.com
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

SGkgWmhlbnpob25nLA0KDQpSZXZpZXdlZC1ieTogQ2xlbWVudCBNYXRoaWV1LS1EcmlmIDxjbGVt
ZW50Lm1hdGhpZXUtLWRyaWZAYnVsbC5jb20+DQoNClRoYW5rcyBmb3IgdGhlIGVmZm9ydCENCg0K
T24gVHVlLCAyMDI2LTA4LTI1IGF0IDE2OjE4ICswODAwLCBaaGVuemhvbmcgRHVhbiB3cm90ZToN
Cj4gQ2F1dGlvbjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNs
aWNrIGxpbmtzLCB1bmxlc3MgdGhpcyBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2VuZGVyIGFu
ZCB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPiANCj4gDQo+IEFkZCBhIG5ldyBoZWxw
ZXIgZm9yIElPTU1VX0ZBVUxUX1FVRVVFX0FMTE9DIGlvY3RsIHRvIGFsbG9jYXRlIGEgZmF1bHQg
IA0KPiBoYW5kbGluZyBvYmplY3Qgd2hpY2ggd2lsbCBiZSB1c2VkIGluIGh3cHQgYWxsb2NhdGlv
bi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDxbemhlbnpob25nLmR1YW5A
aW50ZWwuY29tXShtYWlsdG86emhlbnpob25nLmR1YW5AaW50ZWwuY29tKT4gIA0KPiBUZXN0ZWQt
Ynk6IFh1ZG9uZyBIYW8gPFt4dWRvbmcuaGFvQGludGVsLmNvbV0obWFpbHRvOnh1ZG9uZy5oYW9A
aW50ZWwuY29tKT4gIA0KPiAtLS0gIA0KPiDCoGluY2x1ZGUvc3lzdGVtL2lvbW11ZmQuaCB8wqAg
MyArKysgIA0KPiDCoGJhY2tlbmRzL2lvbW11ZmQuY8KgwqDCoMKgwqDCoCB8IDIxICsrKysrKysr
KysrKysrKysrKysrKyAgDQo+IMKgYmFja2VuZHMvdHJhY2UtZXZlbnRzwqDCoMKgIHzCoCAxICsg
IA0KPiDCoDMgZmlsZXMgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2luY2x1ZGUvc3lzdGVtL2lvbW11ZmQuaCBiL2luY2x1ZGUvc3lzdGVtL2lvbW11ZmQuaCAg
DQo+IGluZGV4IDE3YmYxYTM3MjcuLjM2YjM0YjQ4OTkgMTAwNjQ0ICANCj4gLS0tIGEvaW5jbHVk
ZS9zeXN0ZW0vaW9tbXVmZC5oICANCj4gKysrIGIvaW5jbHVkZS9zeXN0ZW0vaW9tbXVmZC5oICAN
Cj4gQEAgLTEwNiw2ICsxMDYsOSBAQCBib29sIGlvbW11ZmRfYmFja2VuZF9hbGxvY192ZXZlbnRx
KElPTU1VRkRCYWNrZW5kICpiZSwgdWludDMyX3QgdmlvbW11X2lkLCAgDQo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgdWludDMyX3QgKm91dF92ZXZlbnRxX2lkLCAgDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdWludDMyX3Qg
Km91dF92ZXZlbnRxX2ZkLCBFcnJvciAqKmVycnApOw0KPiANCj4gK2Jvb2wgaW9tbXVmZF9iYWNr
ZW5kX2FsbG9jX2ZhdWx0cShJT01NVUZEQmFja2VuZCAqYmUsIHVpbnQzMl90ICpvdXRfZmF1bHRf
aWQsICANCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB1aW50MzJfdCAqb3V0X2ZhdWx0X2ZkLCBFcnJvciAqKmVycnAp
OyAgDQo+ICsgIA0KPiDCoGJvb2wgaW9tbXVmZF9iYWNrZW5kX2FsbG9jX2h3X3F1ZXVlKElPTU1V
RkRCYWNrZW5kICpiZSwgdWludDMyX3QgdmlvbW11X2lkLCAgDQo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1
aW50MzJfdCBxdWV1ZV90eXBlLCB1aW50MzJfdCBpbmRleCwgIA0KPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
dWludDY0X3QgYWRkciwgdWludDY0X3QgbGVuZ3RoLCAgDQo+IGRpZmYgLS1naXQgYS9iYWNrZW5k
cy9pb21tdWZkLmMgYi9iYWNrZW5kcy9pb21tdWZkLmMgIA0KPiBpbmRleCAxNWYyYTUxMzUwLi4y
Nzc1ZWVmNzQxIDEwMDY0NCAgDQo+IC0tLSBhL2JhY2tlbmRzL2lvbW11ZmQuYyAgDQo+ICsrKyBi
L2JhY2tlbmRzL2lvbW11ZmQuYyAgDQo+IEBAIC01NTQsNiArNTU0LDI3IEBAIGJvb2wgaW9tbXVm
ZF9iYWNrZW5kX2FsbG9jX3ZldmVudHEoSU9NTVVGREJhY2tlbmQgKmJlLCB1aW50MzJfdCB2aW9t
bXVfaWQsICANCj4gwqDCoMKgwqAgcmV0dXJuIHRydWU7ICANCj4gwqB9DQo+IA0KPiArYm9vbCBp
b21tdWZkX2JhY2tlbmRfYWxsb2NfZmF1bHRxKElPTU1VRkRCYWNrZW5kICpiZSwgdWludDMyX3Qg
Km91dF9mYXVsdF9pZCwgIA0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVpbnQzMl90ICpvdXRfZmF1bHRfZmQsIEVy
cm9yICoqZXJycCkgIA0KPiAreyAgDQo+ICvCoMKgwqAgaW50IHJldCwgZmQgPSBiZS0+ZmQ7ICAN
Cj4gK8KgwqDCoCBzdHJ1Y3QgaW9tbXVfZmF1bHRfYWxsb2MgY21kID0geyAgDQo+ICvCoMKgwqDC
oMKgwqDCoCAuc2l6ZSA9IHNpemVvZihjbWQpLCAgDQo+ICvCoMKgwqAgfTsgIA0KPiArICANCj4g
K8KgwqDCoCByZXQgPSBpb2N0bChmZCwgSU9NTVVfRkFVTFRfUVVFVUVfQUxMT0MsICZjbWQpOyAg
DQo+ICvCoMKgwqAgdHJhY2VfaW9tbXVmZF9iYWNrZW5kX2FsbG9jX2ZhdWx0cShmZCwgY21kLm91
dF9mYXVsdF9pZCwgY21kLm91dF9mYXVsdF9mZCwgIA0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBy
ZXQpOyAgDQo+ICvCoMKgwqAgaWYgKHJldCkgeyAgDQo+ICvCoMKgwqDCoMKgwqDCoCBlcnJvcl9z
ZXRnX2Vycm5vKGVycnAsIGVycm5vLCAiRmFpbGVkIHRvIGFsbG9jYXRlIGZhdWx0IHF1ZXVlIik7
ICANCj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiBmYWxzZTsgIA0KPiArwqDCoMKgIH0gIA0KPiAr
ICANCj4gK8KgwqDCoCAqb3V0X2ZhdWx0X2lkID0gY21kLm91dF9mYXVsdF9pZDsgIA0KPiArwqDC
oMKgICpvdXRfZmF1bHRfZmQgPSBjbWQub3V0X2ZhdWx0X2ZkOyAgDQo+ICvCoMKgwqAgcmV0dXJu
IHRydWU7ICANCj4gK30gIA0KPiArICANCj4gwqBib29sIGlvbW11ZmRfYmFja2VuZF9hbGxvY19o
d19xdWV1ZShJT01NVUZEQmFja2VuZCAqYmUsIHVpbnQzMl90IHZpb21tdV9pZCwgIA0KPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgdWludDMyX3QgcXVldWVfdHlwZSwgdWludDMyX3QgaW5kZXgsICANCj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHVpbnQ2NF90IGFkZHIsIHVpbnQ2NF90IGxlbmd0aCwgIA0KPiBkaWZmIC0t
Z2l0IGEvYmFja2VuZHMvdHJhY2UtZXZlbnRzIGIvYmFja2VuZHMvdHJhY2UtZXZlbnRzICANCj4g
aW5kZXggOWI3YjliN2Q2OC4uYjFjMWQ4OWRkOCAxMDA2NDQgIA0KPiAtLS0gYS9iYWNrZW5kcy90
cmFjZS1ldmVudHMgIA0KPiArKysgYi9iYWNrZW5kcy90cmFjZS1ldmVudHMgIA0KPiBAQCAtMTcs
NiArMTcsNyBAQCBpb21tdWZkX2JhY2tlbmRfdW5tYXBfZG1hX25vbl9leGlzdChpbnQgaW9tbXVm
ZCwgdWludDMyX3QgaW9hcywgdWludDY0X3QgaW92YSwgdSAgDQo+IMKgaW9tbXVmZF9iYWNrZW5k
X3VubWFwX2RtYShpbnQgaW9tbXVmZCwgdWludDMyX3QgaW9hcywgdWludDY0X3QgaW92YSwgdWlu
dDY0X3Qgc2l6ZSwgaW50IHJldCkgIiBpb21tdWZkPSVkIGlvYXM9JWQgaW92YT0weCUiUFJJeDY0
IiBzaXplPTB4JSJQUkl4NjQiICglZCkiICANCj4gwqBpb21tdWZkX2JhY2tlbmRfYWxsb2NfaW9h
cyhpbnQgaW9tbXVmZCwgdWludDMyX3QgaW9hcykgIiBpb21tdWZkPSVkIGlvYXM9JWQiICANCj4g
wqBpb21tdWZkX2JhY2tlbmRfYWxsb2NfaHdwdChpbnQgaW9tbXVmZCwgdWludDMyX3QgZGV2X2lk
LCB1aW50MzJfdCBwdF9pZCwgdWludDMyX3QgZmxhZ3MsIHVpbnQzMl90IGh3cHRfdHlwZSwgdWlu
dDMyX3QgbGVuLCB1aW50NjRfdCBkYXRhX3B0ciwgdWludDMyX3Qgb3V0X2h3cHRfaWQsIGludCBy
ZXQpICIgaW9tbXVmZD0lZCBkZXZfaWQ9JXUgcHRfaWQ9JXUgZmxhZ3M9MHgleCBod3B0X3R5cGU9
JXUgbGVuPSV1IGRhdGFfcHRyPTB4JSJQUkl4NjQiIG91dF9od3B0PSV1ICglZCkiICANCj4gK2lv
bW11ZmRfYmFja2VuZF9hbGxvY19mYXVsdHEoaW50IGlvbW11ZmQsIHVpbnQzMl90IGZhdWx0X2lk
LCB1aW50MzJfdCBmYXVsdF9mZCwgaW50IHJldCkgIiBpb21tdWZkPSVkIGZhdWx0X2lkPSV1IGZh
dWx0X2ZkPSV1ICglZCkiICANCj4gwqBpb21tdWZkX2JhY2tlbmRfZnJlZV9pZChpbnQgaW9tbXVm
ZCwgdWludDMyX3QgaWQsIGludCByZXQpICIgaW9tbXVmZD0lZCBpZD0lZCAoJWQpIiAgDQo+IMKg
aW9tbXVmZF9iYWNrZW5kX3NldF9kaXJ0eShpbnQgaW9tbXVmZCwgdWludDMyX3QgaHdwdF9pZCwg
Ym9vbCBzdGFydCwgaW50IHJldCkgIiBpb21tdWZkPSVkIGh3cHQ9JXUgZW5hYmxlPSVkICglZCki
ICANCj4gwqBpb21tdWZkX2JhY2tlbmRfZ2V0X2RpcnR5X2JpdG1hcChpbnQgaW9tbXVmZCwgdWlu
dDMyX3QgaHdwdF9pZCwgdWludDY0X3QgaW92YSwgdWludDY0X3Qgc2l6ZSwgdWludDY0X3QgZmxh
Z3MsIHVpbnQ2NF90IHBhZ2Vfc2l6ZSwgaW50IHJldCkgIiBpb21tdWZkPSVkIGh3cHQ9JXUgaW92
YT0weCUiUFJJeDY0IiBzaXplPTB4JSJQUkl4NjQiIGZsYWdzPTB4JSJQUkl4NjQiIHBhZ2Vfc2l6
ZT0weCUiUFJJeDY0IiAoJWQpIiAgDQo+IC0tICANCj4gMi41Mi4wDQo+IA==

