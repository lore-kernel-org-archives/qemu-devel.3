Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A438C25B5C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 15:32:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2YNW-0003mu-PJ; Thu, 02 May 2024 11:29:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s2YNU-0003m3-Hc
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:29:44 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s2YNF-0005ys-Q7
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:29:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1714663769; x=1746199769;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Bmjrnlq+EsZbqElkWo+w4HVWYLdNhU0hhvoJB34zwx8=;
 b=weR+vhKQtMAtOkE1TTsbK8u3tWULRlnRWSyvyuG5of2WnJ6egCxT7ZeC
 eMP19MN6gUbazFqnfG27yCOMdtn7HTLMXpIToUCGcORyHXKmBpBdDrLCW
 Tq8H25jO43qHA2qUPzUQovQfm1jdcZChlBOkrB5cPvPtXK8iXecZdNc6E
 yHhajc/wbavadSVbfOuJWvmmNBsIVVtb11lk1psYNyGjm3SQ+o4QDoUvs
 zu3cYYtRYT9nIqvFIVfVV42sHDE3JmOH0HWT2/RrPpQQv2KGbfE053RVa
 is0GolTWa7Wl/9s90MuWJDaExyg/aX3iG2eu3z+cK+BbOKqcCmQt+UqmA Q==;
X-IronPort-AV: E=Sophos;i="6.07,247,1708383600"; d="scan'208";a="11785875"
X-MGA-submission: =?us-ascii?q?MDGDUPH/ZPG72orzt6m8j73WFtRqr97aS8VOu2?=
 =?us-ascii?q?xVuIrlNbM0NRBT1i/woOAhBfeXZ20991KAkRq6fEuHinJmPzF6LAJkZZ?=
 =?us-ascii?q?1Qs69L1N4D1/uRXNmCw0B1d9e75dKRfYsBHw6IsTccfFUTOE3oZDJQdh?=
 =?us-ascii?q?FP1HHKlWBpFheo9PqfRB9pAQ=3D=3D?=
Received: from mail-db8eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.104])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 May 2024 17:29:19 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZL2qUok+vOs52EQK4zgK9qkNp+2pG3hQS6pGFl/wRbSxNdpDfntyj9M1mx8SsrXYzn3qE1kvIHYA442NFJMxS0i9+JLvkc6NTFmnTcBRikyF0IHJ4cEFgkAeh6SAdkBXm7DiBHg+qLVYtzPoPG8QbsfYx9GLMBwqK7R6iJdaeDVB1cQTwjwrXFS5QsxLruv2Fou35LGydLUqXLpl6qY3jKnfaLkjwXBJaWkHXpTkSVd/TfCojqnYfOOp65PWkj4KtMLC3Fh+eXQjCmWI+kdcvkIlyHei6LBv51rQPBi5urGS56NvJ0prhhMg9SSmwu5FgcHuCTPauOU2ztZVqXzMbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bmjrnlq+EsZbqElkWo+w4HVWYLdNhU0hhvoJB34zwx8=;
 b=UQi4FIcnLGpRKxOv6RU4dX607MVrmYklxFf2J4Quhpcf+TJ9FSIatjPhwPO/xFRUOPwsFN0B7uIcoChkS8b05L+7o9AK6c6b62yuZqW9J3pugMVPdKAcDqJ9lRQ3l5w6oat0fhJghgM1eb2IDcI3N/Bm/f2DAgSVqPfIX4F92JqJNpupNch5Zzepg7Ji8bnbUe62R+qUX6/S/egiVTYZkctSh+4AkbLb7ivatO1Z24BMhhVMTgMG6V1kz0Ikk0OAEZtHDnpZ/yWwHDmG2hjcyVRksfitoM7hKAHIcyNx1/P2FCMLU3YUhAwIoMLuBjsrI8UcgX31TfKz5p6U3I4KpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PAWPR07MB9661.eurprd07.prod.outlook.com (2603:10a6:102:389::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 15:29:17 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7519.035; Thu, 2 May 2024
 15:29:17 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v1 03/24] intel_iommu: check if the input address is
 canonical
Thread-Topic: [PATCH ats_vtd v1 03/24] intel_iommu: check if the input address
 is canonical
Thread-Index: AQHanKV+UzSPoW8ik0CkQzcjTSZ5Fg==
Date: Thu, 2 May 2024 15:29:17 +0000
Message-ID: <20240502152810.187492-4-clement.mathieu--drif@eviden.com>
References: <20240502152810.187492-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240502152810.187492-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PAWPR07MB9661:EE_
x-ms-office365-filtering-correlation-id: 92f60acb-d931-4cbb-b954-08dc6abca163
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?blJtS0hJNFUvVThmOWdQemMvcGpCZEpKdkV5RVF3ejRTYzdVN1BXdkVoaHBI?=
 =?utf-8?B?cENGN2VJSWx5a3BiNWJYSWdJYnVsVlJYRXJDeEIwSTFQRXExTmVVZDN1OWJ0?=
 =?utf-8?B?cEViOEE3d2E2NnExQWRrSmUvNEE1MW1TemxkNnRkSnl1WWVSRTJKQzB1MG5K?=
 =?utf-8?B?bVVWV3ZUVWNrVHBLa2RsenNBYVIwQnYveUorOE9BQ3Rxc3d0ZlozMEpaRVlh?=
 =?utf-8?B?bDhuZTNRRWdwbWZSWjIxaWNuYTUxUmxESHhaVW1tZHcrbFdqZ1FLMUlaUXcz?=
 =?utf-8?B?OWtiY3Y3a1hueXFLVWRILzc2blE5eEUwY1pWV1V5a0RKcHp2SUYwMjMzOXBz?=
 =?utf-8?B?Z0EzQmRFOGphTkdVWXg5cGlkcWtCaFBQdXNSUnpWRFdUKzV0MWNnZ0x0dGdx?=
 =?utf-8?B?bXJTbURXeEhlWWNESGlKKzRLV2ZhLy8zd1pCM1k2L3QwQzQ0SHNyU2R3ZEhl?=
 =?utf-8?B?TnlSZkdQRGZROWhvR2JUbnE2aUwxOTlzeEtsUU51RzIzM09nWFlON0pQTm9a?=
 =?utf-8?B?anRlRnU2bzRQOXBlenFrQW5nSEFQVDV2aUFzTENlZXFlc2RsQm1oYTdBNnJM?=
 =?utf-8?B?YndjVWozTjRINzdobHBwM3M2V0hqaDgzR2ExL2hvazVVK0JkU2Mzb1ZVOWNO?=
 =?utf-8?B?WUNONE8wajlWbFlMdnVwRXZkZ3hZQ3JPeWVleGFEelE4L0c1b2dCN3NLRDlO?=
 =?utf-8?B?NitxMmZ4VFptNEdUdEFWZG15R0hHWlMvTG4rVFFUZysza2tLdmVoV3BxSVNI?=
 =?utf-8?B?bWw5SzF4emo1ZVNBY29sbWVIc3kyQXF3aUZuai9rWkg4SkZ6UXU5WnNnVFJD?=
 =?utf-8?B?NEVSOEl3NHBQKzNsOURQYXh4bGxKQ3B3LzQyOGpIekpPa25MSDNvdC9qYmJR?=
 =?utf-8?B?bjFJUXVQTHRRTzhIemYwcVkwZ09IbDNHQzFXWTlrSWZ4UnhMVUVGZ0svREc1?=
 =?utf-8?B?N2NyUm5uWStWSEx6RUNPbkFtd2VRSGFSa2R5NGhQM3VXRG1BMCtsb0FPdlgv?=
 =?utf-8?B?Vkdpa0k4TDNvOVhOeWtZWEFkbElnbVdsSGMyZWNlVlFnSU9DdVNlOERaV1lP?=
 =?utf-8?B?Q0NUYjhhVUsyR0ZwK0ZueXd4SDFCT2xqYkZiN0pwNElnTVVwZjJtUmI0OGxT?=
 =?utf-8?B?cnRBR1owWExzRk1tWnlPbGUxVlkxUWZBRnIxTXplNmtMTnpKbWtLWThHbUEy?=
 =?utf-8?B?S0dnRUxoYUFyYmZCUmQ4ejFVSFUwU1g0dUhnZHE0TjB0T0RMaUVTZzlYbmlF?=
 =?utf-8?B?NUEwZkUrY0o4MkcrYlBiZE1kcmhNZGdVb1Vxa2FVOVVFU1ZIeCt1dEpibXFt?=
 =?utf-8?B?RElybVZyREd6Z0VlcmZvNWNUNHpRMWxhZytwakQ2Wms0a2U1UHprbUVza1p5?=
 =?utf-8?B?d0V3NlRFTTdVYXBHOXNPd0RrTk0wWmIwWlpqSXR6QUVraUZ0VE42RndqNDlt?=
 =?utf-8?B?Wko1Y2Jjbk0yRWprOVNPamp2SVNWSWtnZ1FnNVhSZVBxTWIrMGRGSUVGMGp3?=
 =?utf-8?B?cXNUaldoWmY1czFiTlFyUDM3R3J2RitWaTRHZkhnNU85MlBoQTVWRU5rUGkr?=
 =?utf-8?B?Ylk5Y1JvZVd3ODRFeU9zWTJFUVJjMjFOMU52NTNjRG9tdTF4cnlmMEc0K1pQ?=
 =?utf-8?B?ODlOMmg2UmtnR0J5WnIrcWZqZmZNemlBaTJUS1BOR3FPb2VwYXlDN0ZBSFVh?=
 =?utf-8?B?S2liMDhwZGN0bXNrRlhTQVBXM0pIOTcrUVhOazI1elFuR0xjTTJVUUc2TVd6?=
 =?utf-8?B?dUxxZTFqL0kwQ3dnMDZrVWxmZWFlaDQ5WDVjNS9LVmdlbmIzZERKU04zZ0Jl?=
 =?utf-8?B?Z3VJMndoOWo0UDVMLzh5dz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M21DTDlrYWNDc3AwRHJwbXpXdUxiN1pvQ2xVeG1ZT25LMVdjcHN4ME9uSm05?=
 =?utf-8?B?d2c0a2xUdTNnTzFNeFpNaDRGTW9BM2hDb0RsWXpIcnlSYTdWdkZWQ1ByVTNo?=
 =?utf-8?B?MXNBVFQ2TE1hTDBISzliemJYYzliZkg1RjFORkQ3SkJ2VlF1YWxYY3BDODB3?=
 =?utf-8?B?TDNSdGVnbVZjMStQN3BHQW9acHZtWHk3WEFMR0Y4MDVaUEwwQU9EN2doUHNu?=
 =?utf-8?B?N1Y3MEQxQ2VzaG1hT0kvVnpMY1U4bG5iZFhPeTErM0Rvb0o2QXZidzA3aTJQ?=
 =?utf-8?B?L0UzN01Ra0U5RUhnMVhlL1RCZ2ZrdWdMMmJlTUF5bkQ4UXhHS0w0TUhNODhx?=
 =?utf-8?B?NERHUFdPS1ozb2hnZVl0Mk0vbyswd0ZWckFmK3d3MkFFZmFabXp3SDFNbm9v?=
 =?utf-8?B?aXR4QUtYK1lxSFlEcHJFUmpLL0JkUG1NallNTjdCWkk4SFAxWGcweEQ1K2tF?=
 =?utf-8?B?VGlBQTVjb3gyQkRJRkNiSm05cXM0Qi9RVEZUZDJoanI2Zyt2eVJvU1ByWi9y?=
 =?utf-8?B?Mlp6b0lUVldhR25KcS9IVndSMUhHdG5uamk0WkRFY0VzWXplQlpYT21rVzVp?=
 =?utf-8?B?RGZkT29NRGtkRm1PcEFOMExHZEdOOVZlTXNLaEpqczJla3dnSWxpNHVOaEdZ?=
 =?utf-8?B?ZTRhSEo1VEx0UmlDeWpUQm1UTjh0bE8rL2FVT1VERFhOa3NPMmVYSitHS3NU?=
 =?utf-8?B?Mk9nQWxhV3ZBTk5GN0owOHdqb1J6cUxXK2lrY3FPQWJMY0pHODVvQWxGVzUy?=
 =?utf-8?B?L1ZiRThBY0NLWGtFYVQwRVJPSEFpeGtoWU9DSjhaNnVBaVBJOVF6ZDFYZ014?=
 =?utf-8?B?VVR0RWRHRU5MM1ROUzU1bG9vZ01YT2dFclNFNVBBYlhWeHZ2U0FGVFhJK2dx?=
 =?utf-8?B?dU1KYUsrTzZsM2tqQjNQVkM2T3NsRk8ycmpwNGcrZkJuNGpWKzErVHM2ZStP?=
 =?utf-8?B?am1ISVg5Rkw2d2tvNW5ITnlDV1FreDFBbzhQYy9zbXZuRlZTQU4vQW9YTXI1?=
 =?utf-8?B?d05GSE1yaUxQbmlDYktwNEdtU2IvR2UzNzdSUHJyWWRYRlRXMS9HNSsyanRZ?=
 =?utf-8?B?YUIwRDdMK0lBVGVFdUVzbXJJK05uL01nM2k1aitJdmp3cHFpejVpT2RLdGFO?=
 =?utf-8?B?SWVUdjBUa2RVbnExeWIrclRnYlYvRDlqbVRTRC8rUFpnQmkzeHdRclhRdGtw?=
 =?utf-8?B?Vzhuc2ZPUVRTbzRWcHU2Zjd4elVpNTMzbXpzQWx5aWVlZTcvVFhKM29tV2Z6?=
 =?utf-8?B?R0gzOU9kUGNTSzZqVnlMSXNObEVOUmovdUwzSGlMM2hBUEcwcHBRS3JmbjF1?=
 =?utf-8?B?OEJzSXZWSU5vc2xIOXRDdkRZN3E5cndwUWFsZSttWDlrb3hTNmFhMjE3NWNR?=
 =?utf-8?B?YitSQ1R5eFlCT2ZGT1dObDdVY2UwTU9YNWVPWGdIUEtqUkdSLzVxU3NjbnVn?=
 =?utf-8?B?SmlxS3BHMjdFRlVtSERuVmNRZm54b0tVZ2oxeTlXaUY1ZUlyV3lLd3Urc3JK?=
 =?utf-8?B?NDFkaXYzYVhpSGt6SFQwVTY5VitWU3hPUGM1L0dxbGZKUEVaVkQyZEJsYWM3?=
 =?utf-8?B?SjFROWVvZVFrU0lkZmhHbVJqRndxdFJPU3RMMVBkbitDaVBkN0htRTQxU3gr?=
 =?utf-8?B?Si9Wa3VBcE5BL0NUaG5NdHpBcGgxaDRvZWNITDZKYTNwbFdvSms2M21kR0kx?=
 =?utf-8?B?dUd3UEZ4ZURFbFJrTWh6R1R2dWZZRzU0S1ljSVBOdFRVY3NVVjFKenFscDVY?=
 =?utf-8?B?RjNWZzl1cmhLbmE1cXVXRUNFY2JNTkM2a0FhYVo1cjBPWUJVZEtyZVhzaVdv?=
 =?utf-8?B?TURTZFN5ZXdNVjV6bWplYjlqQSt1VjM4NS9NM20wcU9ob0ZUNThJdjVCckQ0?=
 =?utf-8?B?UFhCWkgrbytGRUVHSTZxcGh6ckFIU2l2cjJXdVZIRGV4Yi9uL3Y3bE44cFFn?=
 =?utf-8?B?dUd5SHdnTDNwMysyaTllMWh4dkNiSEh0UWdqMkMzZzZaaUdXZWhraStrZTdp?=
 =?utf-8?B?MnJuajVWN1U4ejhRVFRZNHpUZ2hUUC84bW54LytDai91ajB3eE5yMENpOUxz?=
 =?utf-8?B?bVhDVGhIcXdNZlFvbTl6amU1ZVJNamdxOWlyOXFIazIwRmpMNlJYUXdDcEs4?=
 =?utf-8?B?MExtMzRBOVVFY0NPaWJqMUpOU1FaaFlSNmt1SGJoOHZlK3R4aGtYOElqMTBa?=
 =?utf-8?Q?mSFp7oKh/zxYmb7DEpiczBY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C7B7209A5DD2B498988CE68C26FD393@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92f60acb-d931-4cbb-b954-08dc6abca163
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2024 15:29:17.3490 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ou8uIftzPsZfLfGHM5PBkBu4xG2AUNA8WjDdj99c4Qak7zB4X9t1ug829RFx1GazWRo6j6h8UKXldPm4BjdNuDIVEpt/HUc1WL/EXiHiCutuAf4ExLRP/3Jto1jAIpCj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR07MB9661
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

Rmlyc3Qgc3RhZ2UgdHJhbnNsYXRpb24gbXVzdCBmYWlsIGlmIHRoZSBhZGRyZXNzIHRvIHRyYW5z
bGF0ZSBpcw0Kbm90IGNhbm9uaWNhbC4NCg0KU2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGll
dS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQotLS0NCiBody9pMzg2
L2ludGVsX2lvbW11LmMgICAgICAgICAgfCAyMiArKysrKysrKysrKysrKysrKysrKysrDQogaHcv
aTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oIHwgIDIgKysNCiAyIGZpbGVzIGNoYW5nZWQsIDI0
IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3
L2kzODYvaW50ZWxfaW9tbXUuYw0KaW5kZXggODBjZGYzNzg3MC4uMjQwZWNiOGY3MiAxMDA2NDQN
Ci0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5j
DQpAQCAtMTkxMiw2ICsxOTEyLDcgQEAgc3RhdGljIGNvbnN0IGJvb2wgdnRkX3F1YWxpZmllZF9m
YXVsdHNbXSA9IHsNCiAgICAgW1ZURF9GUl9QQVNJRF9FTlRSWV9QXSA9IHRydWUsDQogICAgIFtW
VERfRlJfUEFTSURfVEFCTEVfRU5UUllfSU5WXSA9IHRydWUsDQogICAgIFtWVERfRlJfU01fSU5U
RVJSVVBUX0FERFJdID0gdHJ1ZSwNCisgICAgW1ZURF9GUl9GU19OT05fQ0FOT05JQ0FMXSA9IHRy
dWUsDQogICAgIFtWVERfRlJfTUFYXSA9IGZhbHNlLA0KIH07DQogDQpAQCAtMjAyMyw2ICsyMDI0
LDIxIEBAIHN0YXRpYyBpbmxpbmUgdWludDY0X3QgdnRkX2dldF9mbHB0ZV9hZGRyKHVpbnQ2NF90
IGZscHRlLCB1aW50OF90IGF3KQ0KICAgICByZXR1cm4gZmxwdGUgJiBWVERfRkxfUFRfQkFTRV9B
RERSX01BU0soYXcpOw0KIH0NCiANCisvKiBSZXR1cm4gdHJ1ZSBpZiBJT1ZBIGlzIGNhbm9uaWNh
bCwgb3RoZXJ3aXNlIGZhbHNlLiAqLw0KK3N0YXRpYyBib29sIHZ0ZF9pb3ZhX2ZsX2NoZWNrX2Nh
bm9uaWNhbChJbnRlbElPTU1VU3RhdGUgKnMsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHVpbnQ2NF90IGlvdmEsIFZURENvbnRleHRFbnRyeSAqY2UsDQorICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQ4X3QgYXcsIHVpbnQzMl90IHBh
c2lkKQ0KK3sNCisgICAgdWludDY0X3QgaW92YV9saW1pdCA9IHZ0ZF9pb3ZhX2xpbWl0KHMsIGNl
LCBhdywgcGFzaWQpOw0KKyAgICB1aW50NjRfdCB1cHBlcl9iaXRzX21hc2sgPSB+KGlvdmFfbGlt
aXQgLSAxKTsNCisgICAgdWludDY0X3QgdXBwZXJfYml0cyA9IGlvdmEgJiB1cHBlcl9iaXRzX21h
c2s7DQorICAgIGJvb2wgbXNiID0gKChpb3ZhICYgKGlvdmFfbGltaXQgPj4gMSkpICE9IDApOw0K
KyAgICByZXR1cm4gISgNCisgICAgICAgICAgICAgKCFtc2IgJiYgKHVwcGVyX2JpdHMgIT0gMCkp
IHx8DQorICAgICAgICAgICAgIChtc2IgJiYgKHVwcGVyX2JpdHMgIT0gdXBwZXJfYml0c19tYXNr
KSkNCisgICAgICAgICAgICApOw0KK30NCisNCiAvKg0KICAqIEdpdmVuIHRoZSBAaW92YSwgZ2V0
IHJlbGV2YW50IEBmbHB0ZXAuIEBmbHB0ZV9sZXZlbCB3aWxsIGJlIHRoZSBsYXN0IGxldmVsDQog
ICogb2YgdGhlIHRyYW5zbGF0aW9uLCBjYW4gYmUgdXNlZCBmb3IgZGVjaWRpbmcgdGhlIHNpemUg
b2YgbGFyZ2UgcGFnZS4NCkBAIC0yMDM4LDYgKzIwNTQsMTIgQEAgc3RhdGljIGludCB2dGRfaW92
YV90b19mbHB0ZShJbnRlbElPTU1VU3RhdGUgKnMsIFZURENvbnRleHRFbnRyeSAqY2UsDQogICAg
IHVpbnQzMl90IG9mZnNldDsNCiAgICAgdWludDY0X3QgZmxwdGU7DQogDQorICAgIGlmICghdnRk
X2lvdmFfZmxfY2hlY2tfY2Fub25pY2FsKHMsIGlvdmEsIGNlLCBhd19iaXRzLCBwYXNpZCkpIHsN
CisgICAgICAgIGVycm9yX3JlcG9ydF9vbmNlKCIlczogZGV0ZWN0ZWQgbm9uIGNhbm9uaWNhbCBJ
T1ZBIChpb3ZhPTB4JSIgUFJJeDY0ICIsIg0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgInBh
c2lkPTB4JSIgUFJJeDMyICIpIiwgX19mdW5jX18sIGlvdmEsIHBhc2lkKTsNCisgICAgICAgIHJl
dHVybiAtVlREX0ZSX0ZTX05PTl9DQU5PTklDQUw7DQorICAgIH0NCisNCiAgICAgd2hpbGUgKHRy
dWUpIHsNCiAgICAgICAgIG9mZnNldCA9IHZ0ZF9pb3ZhX2ZsX2xldmVsX29mZnNldChpb3ZhLCBs
ZXZlbCk7DQogICAgICAgICBmbHB0ZSA9IHZ0ZF9nZXRfZmxwdGUoYWRkciwgb2Zmc2V0KTsNCmRp
ZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmggYi9ody9pMzg2L2ludGVs
X2lvbW11X2ludGVybmFsLmgNCmluZGV4IDkwMTY5MWFmYjkuLmU5NDQ4MjkxYTQgMTAwNjQ0DQot
LS0gYS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCisrKyBiL2h3L2kzODYvaW50ZWxf
aW9tbXVfaW50ZXJuYWwuaA0KQEAgLTMyNCw2ICszMjQsOCBAQCB0eXBlZGVmIGVudW0gVlRERmF1
bHRSZWFzb24gew0KICAgICBWVERfRlJfUEFTSURfRU5UUllfUCA9IDB4NTksIC8qIFRoZSBQcmVz
ZW50KFApIGZpZWxkIG9mIHBhc2lkdC1lbnRyeSBpcyAwICovDQogICAgIFZURF9GUl9QQVNJRF9U
QUJMRV9FTlRSWV9JTlYgPSAweDViLCAgLypJbnZhbGlkIFBBU0lEIHRhYmxlIGVudHJ5ICovDQog
DQorICAgIFZURF9GUl9GU19OT05fQ0FOT05JQ0FMID0gMHg4MCwgLyogU05HLjEgOiBBZGRyZXNz
IGZvciBGUyBub3QgY2Fub25pY2FsLiovDQorDQogICAgIC8qIE91dHB1dCBhZGRyZXNzIGluIHRo
ZSBpbnRlcnJ1cHQgYWRkcmVzcyByYW5nZSBmb3Igc2NhbGFibGUgbW9kZSAqLw0KICAgICBWVERf
RlJfU01fSU5URVJSVVBUX0FERFIgPSAweDg3LA0KICAgICBWVERfRlJfTUFYLCAgICAgICAgICAg
ICAgICAgLyogR3VhcmQgKi8NCi0tIA0KMi40NC4wDQo=

