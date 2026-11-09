Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DCF606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 08:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=LxagYwwp;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=ByOpHTOA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQLA8-0007U5-Ud; Mon, 09 Nov 2026 03:55:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xQL9z-0007Rc-UT; Mon, 09 Nov 2026 03:55:27 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xQL9x-0001YV-3J; Mon, 09 Nov 2026 03:55:27 -0500
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A96A1PO3271312; Mon, 9 Nov 2026 00:55:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=wvpnz4qSaJu8uWdk8OQKjNQoeV+lqhfItfkDw4+XI
 FI=; b=LxagYwwp2WumpNpUSfGQ5m1EymnVx9zkUTsBf0l/GW7waJoquGGTtLSBg
 LmEiVQBqSiyI/xZU4pUDmKmBBbHbpUjnyDFHISwoSP7nQkq3g7twgZl8VSWCiA2L
 OpkjDjXC5U01pYHfxmwLYcFgRmpq547zXmqP5OwmTavRgmha3lYtxwISCb3dCPgm
 MP0H3uAh1bmYlE5Doi3y9gSnBLDYE4NivHS0+IHgOExjTXzz/5XT14iIee7tKb5E
 0212fETBehp26WVDwiUMmN551NbWmNZylM7kk7hB8Trk4tsxbvUQmvvqDkHa8K0s
 LmHCqpsESr6t50v2pu9SBsbpVxCPA==
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11022123.outbound.protection.outlook.com [40.107.209.123])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4ht46gjbsy-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 09 Nov 2026 00:55:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wZ/oqrleGICoJ/77UTt78dcpyjPENtm520183CzYwUEcbOi0TRphJbODjoNKLuB6HzTwqab/uAFJZINm14PyEedp8ou4ArwWk/yUyYmbmloX8KquqORAB7CGAxqGLgY0TT+fx/XeWFeKroX70JoDbWJrdjnTrFMjRzYawW6i+xTflw05bAfvEF9a8FL7mwmA/u9YAqKPVkNDHmEQtBLo8gRPhNtmDwseU0thKFr0yo7C7eWHCgx+RoG8v9ASs/JtRWUqKPoToAjZhFB/OC61W6DAGc1IfiY4aSXPZIQ5OiE1xeweZgTl4d1Ew+/EGd7VA8zexCG6NCfOcRBF3yOkPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wvpnz4qSaJu8uWdk8OQKjNQoeV+lqhfItfkDw4+XIFI=;
 b=USp16eIIGlkuQVMuUmf+xDDvCibr/MB1RDNW3DujBfL54OCsFtlBRIuB81Z9Tv4vA0aATufblJq3xa8PUvDYosB315bzO6B+b3taWUkoJvuRlviImFGQ/zfauRxNt5LQFE+bMw6AGwB/7PV6kLyNRbhmO9JPm/UUSEWkjHun5+5n11AdQ3gqTC7nicGkbNp1aJWSUlq69VkVpPympfXyaJZRZC5JeSSaX4o5HuQn8qyjhqXtjgqYh+5glZpCduwGPD3mgI14JBLhkLmcsYo5KwjBEuXhU5URWcKA0Ytwj+ikQ8Udb0EmjBNPDsqfBFNnMe2swOlTjh3589Eo+mp9hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvpnz4qSaJu8uWdk8OQKjNQoeV+lqhfItfkDw4+XIFI=;
 b=ByOpHTOAiQMPonnwUIKoTgCHrAOzJzAOolZyHCJxNtpYhNKsXaiEYivpmbP4Qz3mQiKgjYtXMMJnxMdGdqsAMdU9cirMpvudZa2kiax66b1HOYV/qg1q1VYCm+l0EW2J2tUQIGUAOGFF10Bu0wVZVoRy75Bv1XCZBKFKh/fa4QOn5AIFlgAN/rIb1XD5QYXGqS3U8EwUT/BMoofAfCck+KXvJbmDxPmlc6REWwwU4gz6JhO63job5T5/jeYgmvZIpN4dhba0Qup7GPU3p/VlZNMO8mQvcZxvAIf4BsAbgcWTYc3LsHUnSlr+jdKNwgBnM4qZ//jfVHlWjKBHVQGJMg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from MW4PR02MB7153.namprd02.prod.outlook.com (2603:10b6:303:65::11)
 by DM6PR02MB6953.namprd02.prod.outlook.com (2603:10b6:5:253::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 08:55:19 +0000
Received: from MW4PR02MB7153.namprd02.prod.outlook.com
 ([fe80::2d8:c73a:b2f9:f1dd]) by MW4PR02MB7153.namprd02.prod.outlook.com
 ([fe80::2d8:c73a:b2f9:f1dd%2]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 08:55:19 +0000
Message-ID: <792a4d16-8318-4a06-b5b6-0122dbf4d19d@nutanix.com>
Date: Mon, 9 Nov 2026 08:55:14 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] hw/gpio/pca9554: Move most code from .h to .c
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, milesg@linux.ibm.com, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org
References: <20261106110440.3552588-1-armbru@redhat.com>
 <20261106110440.3552588-3-armbru@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20261106110440.3552588-3-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::18) To MW4PR02MB7153.namprd02.prod.outlook.com
 (2603:10b6:303:65::11)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR02MB7153:EE_|DM6PR02MB6953:EE_
X-MS-Office365-Filtering-Correlation-Id: b7f27043-1e53-4364-329d-08df3e3f2dfc
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|10067099003|4143699003|261028144727099003|261102123227099003|261022105027099003|56012099006|261021121427099003|261021123027099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: ahqAmKfirDOohTGLX+A+l0+0Vibf05blV+WCLw7RCLBQ/+vIOOPLs5uTVDE0Ql2z1Sud/+iVufmZIgu7Jy8+OqZHaTAtrUstWCF9OhjNMuGzmmQLyxTNbYjsPNVCPRAedo04rrcYMZFGIezDZN7tRjkU4/Pml5DOvMPStyEZoUph9plk0y3VDM/WNnmlu9bXC/4MjYuLyQpnn1SHt4obUdBwubl62bCq+yaDV2f/ShC4v4yl6KAbyDNwnV1cwP5vf6htDHjHn2Ex7b5c86wzB+h4KJhyeWWCmxSzaHvlte9tun3j5CEmP1lAShdPVA3UZSmBqqocy0cbaU9tduQ+StNH6eArtCWP1wiawvOKtVpfidy2UFN9Af12yiL8bV70UZAXhs2WdCB3S+q5717jsg0S5VILds1cLotqxt8YYLk4OzCExrwL2zwkEbSWGrud7NwEoWfinOScFoTWFemYW7KdPaa+rzHrv6++k9X7r3Ne5QSS9LdurLlHWw7pvKuDsHrgaenVd7kloKJLQk9lQq4pgiBd6RZCwcP9rwZmkxRdNl6sIB7SR8Gdu6uxjAJbD3stwezqu1+Gm63gpoHvZXI0Gj+/U0LGQO1c+epAwmirNOqNDvVXCvVmaS0iTDTI3gLJqECw7UHzCcfx8A/nnO/MgzM6CPXVSiSLSFqKpmA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR02MB7153.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(10067099003)(4143699003)(261028144727099003)(261102123227099003)(261022105027099003)(56012099006)(261021121427099003)(261021123027099003)(261026140227099003)(261009223027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?am5xWU92VFpSV1BFZDZTWHBHL3lXV21LT2M1N09NT0RrTDdTUC9RMW5zZ2tQ?=
 =?utf-8?B?ZFEvODUxTUsrNlVzWTUyNGRqbUZDZHhpY3FsSTVNU2k5SlhzVWpVMHJjVGVP?=
 =?utf-8?B?SlhkdHhkTFNXU1h5Mk5TYVpoZVBjZk9hcW5XT1hqcHU5VjJZMFpGMFQwbTRL?=
 =?utf-8?B?bm4zK0NjOGtNUFFzdzlwSXRWLzBiRjVXYkc0R1dXMzllbnQzQzJrVkM2cVZP?=
 =?utf-8?B?akhNWXB6RlVWb2U5Y0lWbUIvV2Y3OHhERkkvVVFVRVhlbmNHUXRRUlJKV0Qv?=
 =?utf-8?B?K2kzQ01iYlpDMnJTTnUvNjJzR1ZSeHFCczYxaUJwNmNwT29XckhPZmJSR3Jj?=
 =?utf-8?B?bzdPNktzZlFabThEeEhWU3BVby9aR3dGK2hUNy9WSWJHNWNqY3ZzOHI4ZUpF?=
 =?utf-8?B?VlhvZHI5bDRYTjQxNzB0NzFnNGRtS080dHcyY3RUaFZ6OGFmNGtGRlI2MWdj?=
 =?utf-8?B?K1ZRaU04bVFMVjFXQjNjZDBiU3ZiS1JTTGRycGJoSkVncUlkbkUyRmxZSHdv?=
 =?utf-8?B?MWhNZmVCZmt0SmEzdTFQSkRDZFp5WDE4T1BBek1sMnRwc0htOUtHZU16dDBQ?=
 =?utf-8?B?VHNRZlFya2ZsZXBIWitYNGxPRU16N0JNdGIrdDkvNnQ2eHpkcnQ0cVhWNVVL?=
 =?utf-8?B?ZHB6andTZjQwVExkL25GaHVuSDFXNk1QbUVBeUVUdHFIMWZMZHRiMTdZL1FX?=
 =?utf-8?B?VCsxdWtsbU4zR0JKdlkwQjF5RG4yeUZ0RkNTV3JkbzhndnRKM0JhRHRybEFD?=
 =?utf-8?B?QkZ0TzZlaWxJbGRlOTRpZjByY2NrdnMvVmY3cXpBeHQ5ZXU5UTVIVDQ2M3lz?=
 =?utf-8?B?SjVJRUFYTVlHeUdIUGh0emRWa3g4cUgySmh4NXhBSDJmVWp0SE1CQVN2WWR1?=
 =?utf-8?B?MXFza2dhS085MGhkWExwRGtxOVBJYXZkS3hmUEhkOFloT2VZNjY2djU0S01l?=
 =?utf-8?B?UlZ0Uzk1R1EvSWNOQnZFUk5hZGkrcm9xUmRSbzNIZ3ZudGVUdlNWYmRHYml0?=
 =?utf-8?B?K0JHVlU0bWt4TEhRQ0FFRVg2NWYyWVNvczNYYVRLQ3NwbjRNODNLdVBtdmVK?=
 =?utf-8?B?S2xuNlYxUzZSelB0MEozS05ZNy9ZTlQ5SHBpMEtKMjBROVhsTXd1dnBoSWV2?=
 =?utf-8?B?MTI0YjVZRHFTL2JHbDRHMjQrckFuclRxYVlCZThJRk4zUjBBa1lESjhhVzA2?=
 =?utf-8?B?ZTRacGFpUUtqSnNMM2ZpaHBiamVtYmJGTkhYWThZWjJYMnErVGFTdWYydk5j?=
 =?utf-8?B?MDhmWGp2c0JVRTJpeC85NHpNZDdGb2M1UFVpamNKNFROanlKR0VUbjJOQlE1?=
 =?utf-8?B?RkJ1eEg5eFpLQ2I2cENyQmZJeGdCQUgwb2NHWTBZOEs0SHZsaXhnOU15NjZp?=
 =?utf-8?B?cHFBWVAxbVFXUDNtWmlLSzIvYTdnNXhldGp6ZXUwUHREcmtYa0dFNVptT0h1?=
 =?utf-8?B?U0pzQjUvdnRSdE04SUdxUm01SkRCQzdDbEZ0QnpBZGUxRkxGdm1jV3VuNEhX?=
 =?utf-8?B?SDFXOStyNmFodVRuUjZ6Q2FPeC95RU4wWXorVWd0ejZ6cC9Hd0xNOUtYQmU1?=
 =?utf-8?B?dmtnQzRqaXpCVWtxZktZOGVQRHI3NFBUQkd6ZEFVTmhJQ0pvRUNUVHpnTElX?=
 =?utf-8?B?a2dqQ2hPdXViRXVDODFGQkdUZ1p2WEhjZ2p1ekFaQVQxLzNsYVhkSm5qZzlX?=
 =?utf-8?B?WXVROXgyMU1ySlkxU3dNeGRYYy9oS1JQRC9FMkNYYWk1aEIzdTA1dmUzKzBR?=
 =?utf-8?B?NTA2ZjdCUUVlRkpPaU9ISTA4c3ZOSUtpOEVyNXFkNmdzMitvOU9GQ0kwZ2pT?=
 =?utf-8?B?R2xZYmZFT1g0MHZiM1BxUngyTW5qQmJZcm5jcGRUNWNPSC9IcjlST2ZZblBj?=
 =?utf-8?B?Wmh5YzREclk0cFpoWGRlcUl6bS9xSUhYNWk2aG0vL3lYMWtEWE1tZ3o3ZHRy?=
 =?utf-8?B?d2RUakdKNjlIYStuQlJYdDRmNkhIUHJ2Z1ZhMkxPTFpnYmhGWTVqZmowNFpS?=
 =?utf-8?B?NFQ0NW1DeHBRUmcwbmlla1BXUDRXVXAvTy9WeWxVR2JCTEU1b1JLcGVxNlZN?=
 =?utf-8?B?SUY4NXF3WGp5Rk4rKzY3aXdnU29WakdrUGkwNFVadmx3YmNPbWZqTjlxTGtL?=
 =?utf-8?B?cml1WnV1ZzNGN0tBYkFDbDV0SFJoWGlZWWppeTNmdVpwYmRHM3ViU1NYb0pu?=
 =?utf-8?B?VUVuVDFsTjdFWWtPcDhKazVkbEE1SjhOWWhKY1RVeGluaHIrYTgwdVdvME1S?=
 =?utf-8?B?NmNMQzMycmpseFBoMVhKdlNLZzBwZXBVWjBVSG5meWU0RWo0RmgvME02ZGph?=
 =?utf-8?B?UDFoQUN2aVNCN2VidSt4Q1h1a1hsbkxmb3N6SVd2NWdXWFY0UVlWR2JjbUQ4?=
 =?utf-8?Q?ApZrUnPeOvdpubA0=3D?=
X-Exchange-RoutingPolicyChecked: gY+bg5pfG6zbstdsvetLhzczGlKWghVHTnvcfa8MOcQwr9IMok7m+OPga3l3Di8RRIhxoBWoGWHrSM/OEA0wvuT778pVh5nCoQ7MGWZxLWz1EA+eb716klikgVqBsBpLGNLQ9oewOsgb5TE7e0dsJnkLjJseNTPaUn2rr6DWBrPE7ra695Yb01APh5MkHdVy5M2lBsl7MxlJ/N0ZRq4Ry3ExMdOCBo4MB3NOLWK+fTr45v3RTPHDG1tUQSGVlpKB83Anvj8VxliTPdc4hGNIpeqlBiIoJ7ko72++qMOoD0qim4CjG1/rVi66bCKA5EUbOm6E0AQC9qinq+HQnYH50g==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f27043-1e53-4364-329d-08df3e3f2dfc
X-MS-Exchange-CrossTenant-AuthSource: MW4PR02MB7153.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 08:55:18.8701 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wLCQLMrdQ0aif8w8EoAMBJIc7+BAi4Fhbr3MtwEFFsnXDxI/PF8w+xYRmODJThQyWZuZxxS0HLRfQn2Hl5+UtLqT2HXawBty75w4LAFVBHA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6953
X-Proofpoint-ORIG-GUID: 8Y2WvOUmgvpcFaEV0MHMY_9QrkfdmHEu
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAzNSBTYWx0ZWRfX5Q7HDjW/T8ZA
 zbqIUtIAEahVGP0U4V6Hcjb83q/NvjpSmzauMHK8t4BxRTZ9PA9N3pPOmCECmPjoOdOr/D5iZYL
 WP4qm4ef46QpOoCY7omgVtyrT0diq74=
X-Proofpoint-GUID: 8Y2WvOUmgvpcFaEV0MHMY_9QrkfdmHEu
X-Authority-Analysis: v=2.4 cv=YuSa1IYX c=1 sm=1 tr=0 ts=6af18a7a cx=c_pps
 a=EEuUCq1UVZeKBjwkVe0TyA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=lvTum4n002TqrxmVWTwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAzNSBTYWx0ZWRfXz5zU8hBAb9P2
 c+EqIiCCfiqYJSjjnVvg/ihimndPdhqkV8uaWL2Zl9h6HQpBPpf5BneEXIMsWbLg4FgR7ILltNT
 5AmzT89ASHPK35vHjVi0FkACcd44Xg96vQ1ouAtpkuliglaIZiALz5mqzOGzeWvIxDnk4+dSaSE
 lreLibq8WJImWNrlqTQsrAcNod6tpvKe0KeuEmETo/3jvKlJCIDsIG2c5pkqdDbkONcf2miT9Kd
 zHWruhL/Uf4m50NZZvFtIG7uDiYzA5aCe5sK9VMqXIDhtb0O2PuP4x6FIh/cq6DKBZbaEtL517D
 j7ZirfTI9GCx6Iq+FE6rGm0DKheST22xmaFCMHEoZtWg2tu6Nw4GEXfZOXUyFu3zPz/9Zn6cFKS
 hRPxbRlWWyeoe3YMiZCD6vd6lrInSYiBjnUWEv7ZqSjigFGMQtMMk2l85ps3Ml5j21riY+LqdoB
 95zOpRXuGh+9cnlUHyg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 06/11/2026 11:04, Markus Armbruster wrote:

> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   include/hw/gpio/pca9554.h | 25 -------------------------
>   hw/gpio/pca9554.c         | 24 ++++++++++++++++++++++++
>   2 files changed, 24 insertions(+), 25 deletions(-)
> 
> diff --git a/include/hw/gpio/pca9554.h b/include/hw/gpio/pca9554.h
> index ac835371aa..1b33a8a752 100644
> --- a/include/hw/gpio/pca9554.h
> +++ b/include/hw/gpio/pca9554.h
> @@ -8,32 +8,7 @@
>   #ifndef PCA9554_H
>   #define PCA9554_H
>   
> -#include "hw/i2c/i2c.h"
> -#include "qom/object.h"
> -
>   #define TYPE_PCA9554 "pca9554"
>   #define TYPE_PCA9536 "pca9536"
> -typedef struct PCA9554State PCA9554State;
> -DECLARE_INSTANCE_CHECKER(PCA9554State, PCA9554,
> -                         TYPE_PCA9554)
> -
> -#define PCA9554_NR_REGS 4
> -#define PCA9554_PIN_COUNT 8
> -#define PCA9536_PIN_COUNT 4
> -
> -struct PCA9554State {
> -    /*< private >*/
> -    I2CSlave i2c;
> -    /*< public >*/
> -
> -    uint8_t len;
> -    uint8_t pointer;
> -
> -    uint8_t regs[PCA9554_NR_REGS];
> -    qemu_irq gpio_out[PCA9554_PIN_COUNT];
> -    uint8_t ext_state[PCA9554_PIN_COUNT];
> -    char *description; /* For debugging purpose only */
> -    bool hw_dir; /* Honor pin direction */
> -};
>   
>   #endif

Is there anything left in pca9554.h at this point?

> diff --git a/hw/gpio/pca9554.c b/hw/gpio/pca9554.c
> index 07bb00babf..e5a1932c89 100644
> --- a/hw/gpio/pca9554.c
> +++ b/hw/gpio/pca9554.c
> @@ -13,6 +13,7 @@
>   #include "hw/core/qdev-properties.h"
>   #include "hw/gpio/pca9554.h"
>   #include "hw/gpio/pca9554_regs.h"
> +#include "hw/i2c/i2c.h"
>   #include "hw/core/irq.h"
>   #include "migration/vmstate.h"
>   #include "qapi/error.h"
> @@ -21,6 +22,29 @@
>   #include "trace.h"
>   #include "qom/object.h"
>   
> +typedef struct PCA9554State PCA9554State;
> +DECLARE_INSTANCE_CHECKER(PCA9554State, PCA9554,
> +                         TYPE_PCA9554)
> +
> +#define PCA9554_NR_REGS 4
> +#define PCA9554_PIN_COUNT 8
> +#define PCA9536_PIN_COUNT 4
> +
> +struct PCA9554State {
> +    /*< private >*/
> +    I2CSlave i2c;
> +    /*< public >*/
> +
> +    uint8_t len;
> +    uint8_t pointer;
> +
> +    uint8_t regs[PCA9554_NR_REGS];
> +    qemu_irq gpio_out[PCA9554_PIN_COUNT];
> +    uint8_t ext_state[PCA9554_PIN_COUNT];
> +    char *description; /* For debugging purpose only */
> +    bool hw_dir; /* Honor pin direction */
> +};
> +
>   struct PCA9554Class {
>       /*< private >*/
>       I2CSlaveClass parent_class;

Otherwise:

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


