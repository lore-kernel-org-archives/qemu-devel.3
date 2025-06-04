Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 432EDC5B549
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 12:29:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMnEa-00044J-5N; Wed, 04 Jun 2025 08:28:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1uMnER-00042m-OA
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 08:28:36 -0400
Received: from mail-dm6nam04on20606.outbound.protection.outlook.com
 ([2a01:111:f403:2409::606]
 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1uMnEJ-0004s5-Rg
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 08:28:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U0vvhANm8S2qcXtNYTgH8HnpLr+1GQ+45XP/bI+9+dok1IGpV6QUW7svK6cdMMwc1SFL+N7fbVQFbq1ffxYftCN/40fAZX0VtKSIOZmN6BRgfSJTjuNbYIkGPCL8VkD+ExePhPZeatVUerEHWF/qDQDjk1d3KfT20Nchd11i55T2ShkI1YAsj3dJ6nL9AqLYmT2CyAUngxB4ELlPUbv1c/bSPWxj8C9E9gkvCu9s/64QFXLlYZAm9LioIP8Nq6vYZT0dqV9W62VkV+eJQ488w3quKmcKzc3/QNUAacs49KFJSuOKEKGH4OSiVo+03V6dq6+Lktf4N/M7EJ4AnUm8UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=emJ1yAJB2pKPg1y1uy73ZFtLLj1JnSdibzoUAexL/Us=;
 b=hUdSESLMpi/+SAYrXjOemRNMc3sgcmJiMK+Zsg2G+81U7JP0hBEvSLoca2JtFpPpDESUheZuLhSM4mbTlODeggXLp5j43G0cBQO+zfNqS6MGhKKHeqkeOCOVFB39jI4qD9q7Yr514ju9PP7fr0qI9+4UDqoDm6HSraswBM4Df2BqdCNXBmE4P+927mo88KRW3s0Oh+oqM2xpLHJU1QyGWU791J1nQdUA8DqyS2jD+S3mzx5bSAkZbe6jpujoX1Yuw2mBqy/FCaty589bmlunPh9VQI4b5FTTM7a2JQEP49XVzwkpfOTFETi553mGiDNT8o2wOlELAG1tq+kLN3nkKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emJ1yAJB2pKPg1y1uy73ZFtLLj1JnSdibzoUAexL/Us=;
 b=nggfKkCEc0yK9iZr9l+BAcyYl9zeYAmV1Ghn9OrKQBHuDAJqfsJbqYGygzFEUQJA3KLB5sn04N7auNvj4cygRb4e3X3iu9x0yyRoWSRd6xiUqc6sXOWO50nMm4RAhi7yKErMzCOZVfV4MnBdoEH9jGmRfJICG5Y6z5NffAwdt0aEXHsTltXRKDXezP100QDDUv3Zh8EFpBROUtfIIwUL/XIg+zxxr+neDvRm06O2keWDxHTC+nIv0A1MAie3qi+HT1yg5fGIUlWCoXtoRHUi0lR04Zr0F+5E/E4RIio7akAccUgpWf7kXc+sqKZU6jT5jd3jyTbfo8FOHNN2vD9phQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA0PPF95ABFC125.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdb) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Wed, 4 Jun
 2025 12:28:22 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 12:28:22 +0000
Date: Wed, 4 Jun 2025 09:28:21 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org,
 alex.williamson@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com
Subject: Re: [PATCH v3 0/4] VFIO and IOMMU prerequisite stuff for IOMMU
 nesting support
Message-ID: <20250604122821.GA16659@nvidia.com>
References: <20250604062115.4004200-1-zhenzhong.duan@intel.com>
 <22733f4b-d759-448d-8cc0-ce25e723e859@redhat.com>
 <20250604120820.GA5028@nvidia.com>
 <c34c79ce-6e3e-44b8-8293-714aa783a837@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c34c79ce-6e3e-44b8-8293-714aa783a837@redhat.com>
X-ClientProxiedBy: YT4PR01CA0203.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::28) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA0PPF95ABFC125:EE_
X-MS-Office365-Filtering-Correlation-Id: db376d81-bd2a-4ff0-2cf9-08dda3634b84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZmlsKzA5eUNCWEJ1Q3U2RFpiUzBPeHMrK0wyRm11d1J5blNsNUZrMzhueHk2?=
 =?utf-8?B?MGY2RnZJYmJwNmw0Tm5DWXNHNndqbmhRbXJsN0lhdVVBNlFidjRWb2F3amNo?=
 =?utf-8?B?QkJudU11QTRLT1A1c3krQ2tZT0lRTmdlSkNJMWVQWm45SWw4WmNWR2xZei9E?=
 =?utf-8?B?M2ZKb2tzTCtkRloxblZxNnQwNUJ4cnZlcEppdDhrUXpqN2F6VXZhdTVYb1NI?=
 =?utf-8?B?YzBvaHRNMFFBa3l0OEpWait2QkcxbnRQMk1zQnhsRjlPMGx6eHZXaXpGWVRz?=
 =?utf-8?B?MHlEOTMwU0Q3U0NzbXlsYWVJb0RaaFJFNHkwcnNUeTdLTyt4eFJmMGRPUW5E?=
 =?utf-8?B?TWxvblNUMlN2T0lTUS8wWEVYblorUTltaUFod0M1SEtscGlnOUlCb1VLeXIy?=
 =?utf-8?B?S1B4eFlpUDJVeHpySmpQS2g3UlNTK0MxSno3UGZuRUpYVjJUeDJUT3J4c3VJ?=
 =?utf-8?B?WnhhbG1pbzU4aUxtNTdtbUpYcTdUdDhnTUdrUWJVOU9NZ3d1d1VtRy9tNzlX?=
 =?utf-8?B?RmtyRm4vK0JKbUVzSkZJZVYwQUpCNGNkdkp1a1hpVkJTTTRlbkUzemdPU3lz?=
 =?utf-8?B?ZjYxNFM0VlZIZUlxMEFMNUVtT3ZwdDF4ZWsyUjhVUFhvUHdTU3RzT3pzSmxL?=
 =?utf-8?B?MFgzQUJlUklmbFRLUERoZFE5MERJMDdBaUlkaVBNaUFpSG54OGNGREFBLzBL?=
 =?utf-8?B?VTY2aWtjVmxXaVJhalovcG9zNmlHRzV2NTVzYmpKR1NUMHMvY0lVMlIxbXpJ?=
 =?utf-8?B?cHZMaGQyUjcyR3JYQmgvYS90Q0xhamEwS0dUOTIyT09oRU9CeWJaZHpJamY5?=
 =?utf-8?B?V3dkWnI1TTgrT0E1OWRkdVZnU00zZ05HWldWNEVzMVRrUXR1bkt5Mkx1NVBR?=
 =?utf-8?B?bFhGZC9QdEptN3RLd29XLzJYaDJtVHVpSE9uY25wTEFidUJVNUxEZmRpL1Fv?=
 =?utf-8?B?MnoyOGlnSVl4SWFxaUN0ZENvOHVmTE9PZVVLYWhVU2FkRUFPK2hKTzEwS1Bp?=
 =?utf-8?B?NHdOR2EvUEJNNEpCem1xTXZOSWF4VkR6ckdySmp5OHVTRXFwbVZvQlI4REQ5?=
 =?utf-8?B?aTBBM3ZCZzZPdkgzcU5pY0JtZ0FzY05sbStJTkNoMjdrbUl1T25YbDZvMk5r?=
 =?utf-8?B?TzZYZ2t2RlV2bDM2QUFKeFdMR3o1aGIzbXpvY2lycnVWK0diYkpEYUdvby8v?=
 =?utf-8?B?Uk12UEJ5N2xuL0xpa2U2NGEvQVRSTmxTdjJtdVgrUm1LbWc4TEJFMFdzZjJB?=
 =?utf-8?B?azFReWVoUkk0VWRtOFovNUpkQ09nL3dqekVUZ1o3MlVaMzQ3UE82bnVOWXI1?=
 =?utf-8?B?c3hONkNuckQ4OWdyUGhvU2FYWkhRZHozVU1ka0J3UWp5ZmowcCtKYkxkSG94?=
 =?utf-8?B?d3Zqa016QU9sUWU1YklkSXJkOXpqYzNCckh2cXNHcG10NDNtVVJsVkNLblRH?=
 =?utf-8?B?UzhtQVVjRGIrUnk3U0pwZURJQlpJdkRNS2pBd1ZtZG53YkFUSlk3andEV1dQ?=
 =?utf-8?B?OWJQY25qMDVmbDJXOUFtWVhQelVTUHFNVnE1RkJIaGNEV1p3NkZJRmp2bkpG?=
 =?utf-8?B?YnZVMGVHUXdnSndYM0VsZm9TdVRHQm41OTZuTjhaaDRxanphejYxbENSay9I?=
 =?utf-8?B?SDZ5MEVOTFU3cWViM1dFNUs5NEhESjlhZGFiZkpMS1F1WFhtajJmQ2g3eXhx?=
 =?utf-8?B?ZHplcHRMbGdCVWRQV04vS3RhbmtkT0QrektFK3VrNVhwNHpOSGFIaUwzcEJO?=
 =?utf-8?B?dDhtakljbGdBNVNGZDhlYlVWTk01bmtuRi8vYlhHcUdEQk1MekczMXNrdlZY?=
 =?utf-8?B?OFRVbmxDeHNLaXRtcm1HYjB5UVZ6Z2I5aGhkV25UWVp6WlJGYUw5RnFUdTZB?=
 =?utf-8?B?K0lqZzJzajQ2R1B0WlRYQzZrT0xLdU9Ja256ZFZhZG1lZ1l3WDhUamx4RU9Y?=
 =?utf-8?Q?SjYwk+oqd24=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8659.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXJrN1BQc2t0OFU2c1drcThmYUd1dkNPazVXSDBhRlNGSmtVQU5TQXg4TXg2?=
 =?utf-8?B?d2wxVjdrRU8raFlhc1R4d1VHL1FFUE1USENTdWJjM2JYMktVUU5nNGZVcUVD?=
 =?utf-8?B?cnVTcjJIRE9ERUdJMVBFc2tZMWlTVlQyaHFmSXl5bTlEc25NL0VSL1VkSk15?=
 =?utf-8?B?aFF4cFlIMU9tam1KTjk2eElKZXIyRUdXaHR5WG43VnRYbUxMT0o3N0RuYmFy?=
 =?utf-8?B?NUlGKzZxYXhWdlZUQVJWNnhGcGQycEhpVXk5em5jS0t5UG5yS3h5WUgxT0Fw?=
 =?utf-8?B?Tm1sM3c5aUlYcWhiK2kwbzdLKzczd3NBMitZbmxhQnVDenF4UWxOemlSeVZT?=
 =?utf-8?B?WEZobnRnejNVY2pHY0w4Q0cvVWs1QU9xdUtXYjVlY3VpZnRaaEo0RERCUk5t?=
 =?utf-8?B?MHdjTXd4Ry9JQU5DSlRNSGRNZHhFbHlXS0hXeFFRT0lOOElsRURMWS9ZTFI1?=
 =?utf-8?B?NU5wek5xbG9EbnczYUsvOTNaVzNzdCtGcHpRajE5eFF4dXFGSlRpWWhZTURO?=
 =?utf-8?B?dmpyYjFSK1lWcFF5TFBRRVdIYzYzK3ZoK2prdS8wc2hYeTVvVmxOUnBVd3U3?=
 =?utf-8?B?NmRqaXpkQnJpUG1XQ3kwUm52YndvOU5lZk1vZ0VyQ3VHZkJXcGpmcEhYb2ND?=
 =?utf-8?B?WGxVS1lPZkpKZHRNTW1MbW5mS2ZrbWRXZ1NLMDh0Y0gvRXN4MFZYOGlHc1VP?=
 =?utf-8?B?clIrT0M0NmlTWGdlc21qK3ZJTGdoWGtJL21mMjczd0VMV1hsY0Npc2xNK2tB?=
 =?utf-8?B?dS9YL2ZLaW9UMlVpRkZQYTl0eEtIQjdQaGsyVnY3RGRyY0FzVnFIaEQxYUg3?=
 =?utf-8?B?bzhFWFByWHBzV292RDZ0UTE0K0FvalcrUzRMKzZadnlBN25oNUNkNXJ1T3Er?=
 =?utf-8?B?RENqbTZlaWdzUjA5VlNUd1pwNzcxeGJRc3loTzY0ZW92UnpIU2pqUTZpN1c5?=
 =?utf-8?B?UHNnNUVraVQ1N0xIQVJjUDhYdE02dzdXeVByV01NUkhTU2N5K3VFQ3RscFNo?=
 =?utf-8?B?VXk2WUhQc2taTUpQMHBQaDNqdlNyVEdIV3hOK0FMUXR2Vlk3Zm9XeG1ya09W?=
 =?utf-8?B?bUNyT0p2eWNPbUZCdWdUeEJhNGZkMnIvVWM1aS9yZW9sZVUyYjF1OWZaU3l4?=
 =?utf-8?B?TXNrcHQycGZmRFh5MzNPVzdkQUZpY2EyMGwzbWY2K0Z3cklmZ1VMYWxNN3Vv?=
 =?utf-8?B?TWpvclJpcWpPVXZZOG1qWU5xL1NVZDBtMGpMUjZ5ZjZGbDYxZ0prZXBNcjFm?=
 =?utf-8?B?Ky9Bbi8wK2k1VENvcjh1YmR0UUxsNkdEMTVtNDdLODBUZS82ZHVJUkN3NTJx?=
 =?utf-8?B?S3RNYUlYSlZ4a1pLOUo4MFBPWWt2Ly91UmVJS3U3TTRWVno4dU5VdzBtQUJN?=
 =?utf-8?B?UHd0emkyczlGdkNCT0dqa2dTOXpFZnhEOFVoK2FBWGlyN2xGVXZLdEdzUWwx?=
 =?utf-8?B?RzdnOGNNaXY3TTA4ajlPTTZ5djJEc1lSZENsRFpYVjRyaUlLUjNIa1c1b2di?=
 =?utf-8?B?Y2U1cThFSjRGU2NwZW5oNUFIMXQ5SWRIY2FGQTMzNW1INEsvWlZPcVVQTFpW?=
 =?utf-8?B?R1FwamxXM2VTdWdFVE85NVc4UVZRSnRlcC91WW0xcFlvdm5ZUnV2RmhyUUZT?=
 =?utf-8?B?a1A5OXhRSkc2Sm41YzRSOXFoK3ZXditYZlVnZEI5OWU0YlhGUDNMWW1Xcy9t?=
 =?utf-8?B?TGppUEc0Wmh5Umxac2JSWkFDQmF2Z0RpZGtWTTMrMFJ0d2h0Ty9LNE16ZTN5?=
 =?utf-8?B?OFg0NksrbTI1UzVVR3B4YkpZVW1PcU1Xb2J2VFBlTEh6NHJmUmxKelM2Mmwz?=
 =?utf-8?B?MDhFZ243eWdUajVTYXpkVUdYM1QwMGhQTDRTZEQrTVltc2Z5Q1VUd2pBdkpV?=
 =?utf-8?B?VDNmTTNabmQrZkdtMUxoT0haSUxqdHUwY1V6TkxwVi8rdnNLbWorbEJ4dHRi?=
 =?utf-8?B?YytzTjNuVlJGZEU1dWVtWnhTL2QrenAvKzBJaEdBaGJ1U1ByZEFJbmhoV2lz?=
 =?utf-8?B?RzhXRmtsRnNjR1hNOVlLcTM1UlhaU2dGSE1lbzhabTJzOEtMYkdPQTRVZUpP?=
 =?utf-8?B?M2FjcTAwU05oR1ZWOEVNMnJERGhlL2RNdlptbnNtR2Y5WVAyWWU0Q0dhekNJ?=
 =?utf-8?Q?MjcxynU2hjSX+oL/NNbn64ivC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db376d81-bd2a-4ff0-2cf9-08dda3634b84
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 12:28:22.1883 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OZumyCgyTMtc+Z8s4erWeHrPWrzX+q1/vIc3iL0AYf2hM0SkSG+x/Nb4g3bbDtLJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF95ABFC125
Received-SPF: permerror client-ip=2a01:111:f403:2409::606;
 envelope-from=jgg@nvidia.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, Jun 04, 2025 at 02:20:23PM +0200, Cédric Le Goater wrote:
> NOTE: some trailers ignored due to from/email mismatches:
>     ! Trailer: Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
>      Msg From: Nicolin Chen via <qemu-devel@nongnu.org>

Oh this is some some mailman dysfunction causing this :(

mailman starts mangling messages when DKIM is turned on in some configurations.

Jason

