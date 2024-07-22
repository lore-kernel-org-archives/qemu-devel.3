Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 996EEC3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 18:02:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVxMe-00079O-UR; Mon, 22 Jul 2024 14:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sVxMT-0006RC-V7
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 14:02:15 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sVxMP-0003yI-IS
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 14:02:13 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46MHMY5F009740;
 Mon, 22 Jul 2024 18:02:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=/9eJyoaedKzISCqTjjf20JGMX6d/r0eDsg73VdUfw9g=; b=
 SqUMRqgGjz1te+zXBYIYV3tmGzPHTzndJ/orqQlZTwkf/lpaDYyL7Q2i7WxtQ7OD
 0YkFCdvwmQbO0NZgm71EkkAhX/85LQ0cna7x76VfnHWZFQaEFEqO2eJ4BzIgvuF5
 7id06W2MLkmFDcOZCwkk2mM21BNxLpe4hvh06q8ldSIxgl0IqB3i2RxMMVPJQkeh
 3NWBK+JGkmk6N2FSCtM+u/fvNl90x9dw1T5FdVCJWZO0vE5IwuoCjisbhOhqJHvv
 ZAZWw7ildUOPfw1gY83wrRzSKp6Bl/Y/yuxJ3uY5Ammh/mZMAlXHWf7KRnrntbXt
 y9ovibHA3DJVYNZ2F4A0gQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hgkt2ne6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jul 2024 18:02:05 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46MH468p040025; Mon, 22 Jul 2024 18:02:04 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40h26kb1fk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jul 2024 18:02:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EWpaAbG9Z9oY0X36bSJ9vo1DMUOEgGKV1WD80QzwdWw3Fh1nXy1Hg8xdPFufYqPe+AC6mao5FzaN2jmreXz1OYJO7xRtYnhhyzeSEAQwv+NkgRmlGv0DofLpg3VBBPL7eheDY6zgCzbrhJY+FQbRlnONE42BzFHFKAcbPRA9/nXKvgkSpHEZ702zZUk8R4jDZUTD6QBbC1UtfeAABv7o8733bpBkxkmtDvtxZjrZJi8a/4u5OL1df5REO4MPlEBr6cea0alA2kqsLuDEQjyhV4LQVs4H6EB/VZes91OtzJ3tqoKpppBtS4QzqHMbBEAoyd+Mn+tbt1EWkJhkpy3NwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9eJyoaedKzISCqTjjf20JGMX6d/r0eDsg73VdUfw9g=;
 b=Ed7R1atvgOXUjg+gXz3KATFS3Ak1PkMy1OeituBxZcUl2vqxT1+7q/9/bDSLnxYsUzUHB5t/cE5t0U0hlQTpoKZn0tf14bcGnL71d3NewmErVOPkkgTTDVAJGUQs4/jk/p/mQiUqsW1Vd3bAtypkfoNN8BjpDu+fMaTQqlcCmpY5o76dFtD7EgglxwxHlAsT8VF8RrHIqf2YbfwbfqTBnG295DgQAXLUzaFzoAPJqHpHreB7xcr+ax9ZV6z270yZMloDHUeQaK+80qhKjRWZgv9DRWGV+SW20A/w6H9dW2s7zk5QPo60XDjYaRjNPiKiE6CgL7+LrN7qIn5oWsPeFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9eJyoaedKzISCqTjjf20JGMX6d/r0eDsg73VdUfw9g=;
 b=BBggv+0y77beo0lIe9wpwYToM6UQCBj6arkDDrZwSm+uzzvmvhaxb93vXXbyw7ot7Ah5Kn7vE3jE4x9GGyTlWX4GXPkAtYdemKtLk++8HP6x4Riu4g6/3P+9iikS5RbC/WVZ5AjxtwSVFHsW07ES4e4i4BXOR5R5m5MLxev5kD8=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by MW5PR10MB5873.namprd10.prod.outlook.com (2603:10b6:303:19b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 22 Jul
 2024 18:02:01 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%3]) with mapi id 15.20.7762.025; Mon, 22 Jul 2024
 18:02:01 +0000
Message-ID: <a4129e04-5923-467a-a359-88697a5a464b@oracle.com>
Date: Mon, 22 Jul 2024 19:01:54 +0100
Subject: Re: [PATCH v5 12/13] vfio/migration: Don't block migration device
 dirty tracking is unsupported
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240719120501.81279-1-joao.m.martins@oracle.com>
 <20240719120501.81279-13-joao.m.martins@oracle.com>
 <a8239962-c987-4ca1-b342-95fd8f03179e@redhat.com>
 <f5d64358-70e3-4217-8376-356c8aaac8ea@oracle.com>
 <1304a8c4-be47-4b47-88dd-328a8f167e54@oracle.com>
 <967952f0-e3bd-4c86-b4a8-4906e6b3e248@redhat.com>
 <103a2101-3f9e-46da-b45b-b8a4eaa7d6e7@oracle.com>
 <51012898-c535-4fb1-b101-3d613d46fc30@redhat.com>
 <27e2792c-6eba-4fab-a22d-40e46dae9cda@oracle.com>
 <f9e3bc1c-71f2-442a-8697-19b64a225d57@redhat.com>
 <1d7aaeb6-67ab-4897-96e0-e6128680dd4c@oracle.com>
 <544c0bfe-7dcc-48e7-80a3-ca7f4b255d1b@redhat.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <544c0bfe-7dcc-48e7-80a3-ca7f4b255d1b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0497.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::16) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|MW5PR10MB5873:EE_
X-MS-Office365-Filtering-Correlation-Id: daa702c9-07b9-405d-8cf0-08dcaa7862b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?djJCQkFjL3lGMng4dmZBZlE3N1dybC9DaG1kaHo2dFhTekVZYXRMcmZNanlK?=
 =?utf-8?B?VEMyejNZbUpNTUpPTTViS2prbjBYWEMzbmFmR0pINjNpbmJzam9kTGYzaFFw?=
 =?utf-8?B?RWZHYnZWN2xRdE5vNkJIV3FCM2R2N3JkV24zODNWejJJa1QxWDNZd3l4Sk1j?=
 =?utf-8?B?QTk5bFgyZTFsMXVZMTczazZuWEdId3I2SWVWNktJRy9EZTNBQ0Q0Y2lRRk5q?=
 =?utf-8?B?NnFDVDFOdGU0Ynh1TUxzQW85eTBrUGhreWhGRW4vclh5SFRWbEEzelJKV3Fa?=
 =?utf-8?B?MDNyTjVyRlk2V3ZqTGlVeTlZSndiejIyTER0ZzdyVDJ0c25LM3dSUE5NWFRX?=
 =?utf-8?B?eDMyR250VDV4WHJuclJvWkJud0d0MWhUZWE4RzBzbGZ5WHplM1V4Z3FjbTdn?=
 =?utf-8?B?enMxUXdNTVFvRTc5emJiei83UHRod2Y5M1o5KzdJNW55aDlOWGFGVmwyL1dl?=
 =?utf-8?B?OEpOQ1c5N0dYbFUwamVZUUhLVGU1djgwdHBldHoxZkNsNDg3UlREVTBhYjhJ?=
 =?utf-8?B?ZTdJSitsa09jQVhkNk5tampCeGVZcU5ienlIeDZ0L2IzNVY3S2ZiUTVqQnpp?=
 =?utf-8?B?RDk3cExMZkwyalNrVWwzZ0JXMFRBVkVNRWpqT210NU14a3NqNmNyU0V6Mno4?=
 =?utf-8?B?b0pYcFJ3Z2dMZUp6WEdYUUIwSDlMdTVCbnBZRTYyVC85SFNKUFRsQ3BYT0Nv?=
 =?utf-8?B?c21XWk1rcEZNWnZBNTJrcTh5UGFlODNwdllFRUVYV1gvbytoZUlPMlFoSFQ0?=
 =?utf-8?B?eEhnekVsVmx3UFJFVjMrV3lEcjAvQ204dXRmQ1NBSTdteVNvNFd6K0d4dVpX?=
 =?utf-8?B?OWJuMEdjMWxRMUEyV05Qb3l2bExNQ0RrNUl3cDVIcjlRZndsM2RxNVhXMGx6?=
 =?utf-8?B?b2h1V1NhT28yUkZUR1Q1TVlnS0xrNlBTL2h0OUR4b1JPZCtpOXZmKzNUZDRB?=
 =?utf-8?B?UFpFN1F1ZHZFZVhYancyWFE5bnlFYjhUKzRvV25TNG0vRnFKdThYQ0V2QVFU?=
 =?utf-8?B?THQvYXFnQ2dJODAyVzUzQ3lSNHFwQWtpSDlvb2xydEM3dVZWV2RQc2lHbDMz?=
 =?utf-8?B?MHZHRExjUEVvQUVyTFdyVUZEU0tYWWplYkxpN2g5VmVsNy9CM0txYUNjcEFE?=
 =?utf-8?B?RytsbHFYVlgzTWN6TVl5QllxTkovMlA4SFVMYkxiM2hpRk1OZXBORWV2MU9P?=
 =?utf-8?B?S2tGc3hMWnViNDFmcCsrZ2UwdDQzWlNadEQxcEIxMzdFb2pxMXFnbXdpRzJa?=
 =?utf-8?B?cm9qbjlBZXFMQllUV2RsanNuTitjVWpLVFF0Rm1hOThnUzA2clQvTStnNzlG?=
 =?utf-8?B?dDhuSzJSYUNWbWdoOUVaSlY4aVZNQURIZUVoT21VRFZMRDNBOThtMGtkTlhN?=
 =?utf-8?B?T1dzWVRwVkNEekJlTXpvWXlrQU0rRyt6dXZmdGhDVTF6RkROVzI3N09ZNEJR?=
 =?utf-8?B?R044TG96ekt5YWtMb3ZCMVZJYW5wYlZ3K05VbE9XbEtuK1R3ODJRNXJrNmpn?=
 =?utf-8?B?NlJtbGJvdW8vcFFpa1NwV1ZqRHBTaFF3V3ZXdHhZREE1eFVLMCtabnpHSzBK?=
 =?utf-8?B?WmR6dlVCeXJBY1ZDR2ZuVHZVeUpIa2RpbUJ1VGxId1pHQmlGajZCeXdmTXRT?=
 =?utf-8?B?YkZPbGx6WFZoMisxYXNrRW5IbGlpMGppdnlBUE9OdXB2L0hrUndjNkNvNFFi?=
 =?utf-8?B?OWhCbGdLZ3lOZDlRdnFYOGxhL0h4ZlBGNjdPQU5heHJ6SHJ0SW43WVhVWHRz?=
 =?utf-8?Q?RieswOXOWAYYMYxmfo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1FNamxTZVdweWtqWkxENFVOK3JxMUxkL3JTNFBNYzFodnBqWmR4WDRPVUN5?=
 =?utf-8?B?Ym5FcThRWExtWjR5L3MvdmdjQ2tMSkZaNVhIN1hpbnFDdDE5QWNnNUgvY0ZS?=
 =?utf-8?B?L1RWZUVPNmJVRU03eSsyNVkxZjRCcS9HdXF4VTVWVXgxVFFMdEVwWmg5bWFT?=
 =?utf-8?B?ZkhiZGhYckJqM2Jjb1NMYXBSbVE2cDJkNGV2aU54OExIRjZYbkFhR3VsTUgw?=
 =?utf-8?B?cjF5L05ET0pBb1lHZTF4cnBZaklyOUVveGhJRjBYcnl2R0RFMCtRTDJ0VzZ6?=
 =?utf-8?B?ekRVRjIxb2FvbisybEs0Qk9valkvLzE2L3U1aFp1Umw3VlNzQjRzak5LcVpF?=
 =?utf-8?B?ODM0WjRYcUhjS01NT2swZWg2dzVxblNGcEczM0NVb09OMExhTk9LL3NXZFhq?=
 =?utf-8?B?YjF3NjVFN1QzWFZnVDQ3SWVyMU13R21kWWlob0toNEdjUW1uczFMU09uMFFR?=
 =?utf-8?B?cVQ0dmQ0bjh1V0Y1clFCTUVnbmpuNkJTYmxxNmtHUXprSnY5b25QUHlyZ05D?=
 =?utf-8?B?T3MxbTd2UytMTTJrVEd6WUZUaXhFUG1GVVZ0OXQrZU1OWGw3d2txL1JmSWt1?=
 =?utf-8?B?TDZvbFN2TllGMzMyV3Z0eFRnaFBNRkk2WERjUmpBRTM0QnZ6eEQ5RndLd283?=
 =?utf-8?B?YnFDdnYvRmxUL2hwTFpDVmY2VXRBcHRPL2Z5WThYanNFRFRsbFFBV0F0SnNH?=
 =?utf-8?B?SVd3UWZ6Q2JMazlOWjZobjNUUkNaZWFhMk5YMmFvTHpaNDdIU1lnZDdsYjN6?=
 =?utf-8?B?dENOVGlWTTYxY3AyVVdtZmp5TllNZXhFenNhZFF3UGlFOVVibzdSSG5FVkRI?=
 =?utf-8?B?WU5mZXpILzh3SjRUWTN0VHdCQUVKbnJkQmsvNTQ3UlhHVW1wRWlOMHBtQmg5?=
 =?utf-8?B?T0ozWGhzc1VmczlDRjg4Y1ljQk5tbUpwRGFjVXpFeUJlN29mZTU3TGczUUda?=
 =?utf-8?B?VnU1Mk5aSm5RVk9WQk0vTDE0SnJsRWV4SGxMRVZNY2VkV29OMEtOUm4xdGdV?=
 =?utf-8?B?QWFTNmxmRUU0V2VLUTI3THpHcVRKMzFLOW11OE1Xd1IvbjdtdnFUVldjaUg3?=
 =?utf-8?B?WHJnR25NR2trWUlvS3Jrc1hrOEJSZWxBaVpPMGtRYlVEbEM5R0J2ell1MmtS?=
 =?utf-8?B?bkE0elVjbGhtdlNCdW1NVnM0SEJNdGw2aVBvY2JUdXlnQ1lTM0lRaHprSG94?=
 =?utf-8?B?T2FzT0djQnpjOFdjVFAzeTl3bXRRZnhIYnNEYXVaWXVnT01hazZ0VGk2bXZa?=
 =?utf-8?B?WDJhaUpFWDRGWUcrVzRuSnM1YkNyb01VVkgxSTRCOTBGQ0RKNFJRWWlTTk5s?=
 =?utf-8?B?alp0d3p2ZEtXT3llWEtPd3N0QjZNZG1TWjRtOGRyN2N6N2c0VU1zQlZOMTE3?=
 =?utf-8?B?OHM3SUpKUkk2Z3ZHTW5iY1FnN0lKQ09ESFRFaThNY2U3YVJoa05tNERyL2Z5?=
 =?utf-8?B?VitPRHVlekhnZmJVVW5DZ0F4N1Z1SnU2Ulh3NjZTKzV2OGEzcllXNHFXOTl6?=
 =?utf-8?B?OGh3b0t5MFppN2xyWGl5SE9oK1dmMitpbGtUakNvc1QzU3N6c0xoZzE5RC84?=
 =?utf-8?B?Um9UdnFvUTVDZUNhU2NjOTBQSzc5TUlBOWwxK1VoN0hhdzRNWHVqS2xyUEow?=
 =?utf-8?B?MG9BUkI1TzJBcXI0SzY4emtEdEJkSFZjQm42TkZydTI2UVpJUHcwUGszTDFr?=
 =?utf-8?B?OWd4aXVwR1FDVHNzb0RrSXEzdW4yMG41ZWQwcnJHbmh4TFUraWlYZUFZaWc0?=
 =?utf-8?B?Wm91Q0s2b3VvSUdXeEF3L0d3NVV4ckRkbnB4WkxTSFdLM1FKeVRSR01VYmla?=
 =?utf-8?B?Q2JwUFhiYTlvbkd6eVFiRlcra0t0bi9lK1ZTM1BheWtPQlk2OVFyRGV5dG9Y?=
 =?utf-8?B?MWxpRGZoTWlJL1RXOWYvV1RtOUJWT1dSQldQQWhIdlVuQ0RFTDE0Wmp0dDhy?=
 =?utf-8?B?eFJ1c0dydnpNSmJqUmdDTHZVak5ENHQ3YUtobGNyVTZHTTNndTVOR0psOWtn?=
 =?utf-8?B?Qy9QTEI2L0VoOGU4anpKby9Bckp3WVF6RzJRb1hicmRYNzRCRlMxOXZ4V2JT?=
 =?utf-8?B?UGU1VVZ1bTNDdmdFd0srV0dQRFFMS1FnYVZmWHNEdWxCemFZWXhENW5UQzlq?=
 =?utf-8?B?bFRrM1g5c3FWSVRHQWZQeVpOVDZLb3hiTlB2VnNkSEtYZjhoU3MrTTA0Q1Za?=
 =?utf-8?B?WFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: WO7WVz+blFO1EmF5/FSvW5zTtgw3ZxiEJOS+2vKBl4k6Edtd36JCSZWF83gEd1nShZ9lBniyNJhP2VxMhz9LqnOU/lpWaStC7cw45Am+XooSz2iLe6pDisoN8lUzn/1FUa/XdZNuYRnOv8svrkPoV85zrQ3hUyV55+gvvgjGxlbWnT/9wusCLg2lP+tqQFFacv2INzfftcximRTb/9840hNLoUrzTt5pQb1ofo6yRLMnYlk/j5bt5T8v14Ny1V1S+5GR7JPbjuPCYhPDSLJM5HnIx+C3NNTOXZycuhMg9As/3wJJ0eL0urQrhOSTON9LhZuP3GtjUSMTsQzmh+ljAxDkLH+vjrhUbvfuTnTTdYDHw/8ln5hP3pJFbe7wYsSst68+NpenmUokosBSG+St79xfEj5ZvxReIBJemyRI970PXwDWchiePZ9Wa112oak2Q20lunwFczwaAsqwBsl8xlmpBpdHp2+sueocy0iy8pZHCsTYFYy2pBi6yuJ1up5PoH8IN9pb6sCdi/BlpxUt0QPVBCmYNnSWN37kuSOpACoY/jxJQYCV30VxSh8qFJ7rwP/KOfVt2UyEW6Wz6h+n796rW0LSsEMgBZu+j/ygt4E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daa702c9-07b9-405d-8cf0-08dcaa7862b1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 18:02:01.0947 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a+wLVJNbA3IT6kuGVx1sNoc96qsetYIuzrI3mkLfR/CYSGcKhgodsqDWYRd9TtrklPmm1BkK8jzKq3VuFqrnxz9MfYst8bWpQ4peWMrOws4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5873
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_12,2024-07-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407220135
X-Proofpoint-GUID: XH0Bu8GA8kJnqoDQT-0xUj8KHmQzOHwr
X-Proofpoint-ORIG-GUID: XH0Bu8GA8kJnqoDQT-0xUj8KHmQzOHwr
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 22/07/2024 18:04, Cédric Le Goater wrote:
> On 7/22/24 18:29, Joao Martins wrote:
>> On 22/07/2024 16:58, Cédric Le Goater wrote:
>>> On 7/22/24 17:42, Joao Martins wrote:
>>>> On 22/07/2024 16:13, Cédric Le Goater wrote:
>>>>> On 7/22/24 17:01, Joao Martins wrote:
>>>>>> On 22/07/2024 15:53, Cédric Le Goater wrote:
>>>>>>> On 7/19/24 19:26, Joao Martins wrote:
>>>>>>>> On 19/07/2024 15:24, Joao Martins wrote:
>>>>>>>>> On 19/07/2024 15:17, Cédric Le Goater wrote:
>>>>>>>>>> On 7/19/24 14:05, Joao Martins wrote:
>>>>>>>>>>> By default VFIO migration is set to auto, which will support live
>>>>>>>>>>> migration if the migration capability is set *and* also dirty page
>>>>>>>>>>> tracking is supported.
>>>>>>>>>>>
>>>>>>>>>>> For testing purposes one can force enable without dirty page tracking
>>>>>>>>>>> via enable-migration=on, but that option is generally left for testing
>>>>>>>>>>> purposes.
>>>>>>>>>>>
>>>>>>>>>>> So starting with IOMMU dirty tracking it can use to accomodate the
>>>>>>>>>>> lack of
>>>>>>>>>>> VF dirty page tracking allowing us to minimize the VF requirements for
>>>>>>>>>>> migration and thus enabling migration by default for those too.
>>>>>>>>>>>
>>>>>>>>>>> While at it change the error messages to mention IOMMU dirty tracking as
>>>>>>>>>>> well.
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>>>>>>>>>> ---
>>>>>>>>>>>       include/hw/vfio/vfio-common.h |  1 +
>>>>>>>>>>>       hw/vfio/iommufd.c             |  2 +-
>>>>>>>>>>>       hw/vfio/migration.c           | 11 ++++++-----
>>>>>>>>>>>       3 files changed, 8 insertions(+), 6 deletions(-)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/include/hw/vfio/vfio-common.h
>>>>>>>>>>> b/include/hw/vfio/vfio-common.h
>>>>>>>>>>> index 7e530c7869dc..00b9e933449e 100644
>>>>>>>>>>> --- a/include/hw/vfio/vfio-common.h
>>>>>>>>>>> +++ b/include/hw/vfio/vfio-common.h
>>>>>>>>>>> @@ -299,6 +299,7 @@ int vfio_devices_query_dirty_bitmap(const
>>>>>>>>>>> VFIOContainerBase *bcontainer,
>>>>>>>>>>>                       VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error
>>>>>>>>>>> **errp);
>>>>>>>>>>>       int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer,
>>>>>>>>>>> uint64_t
>>>>>>>>>>> iova,
>>>>>>>>>>>                                 uint64_t size, ram_addr_t ram_addr,
>>>>>>>>>>> Error
>>>>>>>>>>> **errp);
>>>>>>>>>>> +bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt);
>>>>>>>>>>>         /* Returns 0 on success, or a negative errno. */
>>>>>>>>>>>       bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
>>>>>>>>>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>>>>>>>>>> index 7dd5d43ce06a..a998e8578552 100644
>>>>>>>>>>> --- a/hw/vfio/iommufd.c
>>>>>>>>>>> +++ b/hw/vfio/iommufd.c
>>>>>>>>>>> @@ -111,7 +111,7 @@ static void
>>>>>>>>>>> iommufd_cdev_unbind_and_disconnect(VFIODevice
>>>>>>>>>>> *vbasedev)
>>>>>>>>>>>           iommufd_backend_disconnect(vbasedev->iommufd);
>>>>>>>>>>>       }
>>>>>>>>>>>       -static bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
>>>>>>>>>>> +bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
>>>>>>>>>>>       {
>>>>>>>>>>>           return hwpt && hwpt->hwpt_flags &
>>>>>>>>>>> IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>>>>>>>>>>>       }
>>>>>>>>>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>>>>>>>>>> index 34d4be2ce1b1..63ffa46c9652 100644
>>>>>>>>>>> --- a/hw/vfio/migration.c
>>>>>>>>>>> +++ b/hw/vfio/migration.c
>>>>>>>>>>> @@ -1036,16 +1036,17 @@ bool vfio_migration_realize(VFIODevice
>>>>>>>>>>> *vbasedev,
>>>>>>>>>>> Error **errp)
>>>>>>>>>>>               return !vfio_block_migration(vbasedev, err, errp);
>>>>>>>>>>>           }
>>>>>>>>>>>       -    if (!vbasedev->dirty_pages_supported) {
>>>>>>>>>>> +    if (!vbasedev->dirty_pages_supported &&
>>>>>>>>>>> +        !iommufd_hwpt_dirty_tracking(vbasedev->hwpt)) {
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Some platforms do not have IOMMUFD support and this call will need
>>>>>>>>>> some kind of abstract wrapper to reflect dirty tracking support in
>>>>>>>>>> the IOMMU backend.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> This was actually on purpose because only IOMMUFD presents a view of
>>>>>>>>> hardware
>>>>>>>>> whereas type1 supporting dirty page tracking is not used as means to
>>>>>>>>> 'migration
>>>>>>>>> is supported'.
>>>>>>>>>
>>>>>>>>> The hwpt is nil in type1 and the helper checks that, so it should return
>>>>>>>>> false.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Oh wait, maybe you're talking about CONFIG_IOMMUFD=n which I totally didn't
>>>>>>>> consider. Maybe this would be a elegant way to address it? Looks to pass my
>>>>>>>> build with CONFIG_IOMMUFD=n
>>>>>>>>
>>>>>>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>>>>>>>> index 61dd48e79b71..422ad4a5bdd1 100644
>>>>>>>> --- a/include/hw/vfio/vfio-common.h
>>>>>>>> +++ b/include/hw/vfio/vfio-common.h
>>>>>>>> @@ -300,7 +300,14 @@ int vfio_devices_query_dirty_bitmap(const
>>>>>>>> VFIOContainerBase
>>>>>>>> *bcontainer,
>>>>>>>>                      VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error
>>>>>>>> **errp);
>>>>>>>>      int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer,
>>>>>>>> uint64_t
>>>>>>>> iova,
>>>>>>>>                                uint64_t size, ram_addr_t ram_addr, Error
>>>>>>>> **errp);
>>>>>>>> +#ifdef CONFIG_IOMMUFD
>>>>>>>>      bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt);
>>>>>>>> +#else
>>>>>>>> +static inline bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
>>>>>>>> +{
>>>>>>>> +    return false;
>>>>>>>> +}
>>>>>>>> +#endif
>>>>>>>>
>>>>>>>>      /* Returns 0 on success, or a negative errno. */
>>>>>>>>      bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
>>>>>>>>
>>>>>>>
>>>>>>> hmm, no. You will need to introduce a new Host IOMMU device capability,
>>>>>>> something like :
>>>>>>>
>>>>>>>       HOST_IOMMU_DEVICE_CAP_DIRTY_TRACKING,
>>>>>>>
>>>>>>> Then, introduce an helper routine to check the capability  :
>>>>>>>
>>>>>>>       return hiodc->get_cap( ... HOST_IOMMU_DEVICE_CAP_DIRTY_TRACKING...)
>>>>>>>     and replace the iommufd_hwpt_dirty_tracking call with it.
>>>>>>>
>>>>>>> Yeah I know, it's cumbersome but it's cleaner !
>>>>>>>
>>>>>>
>>>>>> Funny you mention it, because that's what I did in v3:
>>>>>>
>>>>>> https://lore.kernel.org/qemu-devel/20240708143420.16953-9-joao.m.martins@oracle.com/
>>>>>>
>>>>>> But it was suggested to drop (I am assuming to avoid complexity)
>>>>>
>>>>> my bad if I did :/
>>>>>
>>>>
>>>> No worries it is all part of review -- I think Zhenzhong proposed with good
>>>> intentions, and I probably didn't think too hard about the consequences on
>>>> layering with the HIOD.
>>>>
>>>>> we will need an helper such as :
>>>>>
>>>>>     bool vfio_device_dirty_tracking(VFIODevice *vbasedev)
>>>>>     {
>>>>>         HostIOMMUDevice *hiod = vbasedev->hiod ;
>>>>>         HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_GET_CLASS(hiod);
>>>>>
>>>>>         return hiodc->get_cap &&
>>>>>             hiodc->get_cap(hiod, HOST_IOMMU_DEVICE_CAP_DIRTY_TRACKING, NULL)
>>>>> == 1;
>>>>>     }
>>>>>
>>>>> and something like,
>>>>>
>>>>>     static int hiod_iommufd_vfio_get_cap(HostIOMMUDevice *hiod, int cap,
>>>>>                                          Error **errp)
>>>>>     {
>>>>>         switch (cap) {
>>>>>         case HOST_IOMMU_DEVICE_CAP_DIRTY_TRACKING:
>>>>>             return !!(hiod->caps.hw_caps & IOMMU_HW_CAP_DIRTY_TRACKING);
>>>>>         default:
>>>>>             error_setg(errp, "%s: unsupported capability %x", hiod->name,
>>>>> cap);
>>>>>             return -EINVAL;
>>>>>         }
>>>>>     }
>>>>>
>>>>> Feel free to propose your own implementation,
>>>>>
>>>>
>>>> Actually it's close to what I had in v3 link, except the new helper (the name
>>>> vfio_device_dirty_tracking is a bit misleading I would call it
>>>> vfio_device_iommu_dirty_tracking)
>>>
>>> Let's call it vfio_device_iommu_dirty_tracking.
>>>
>>
>> I thinking about this and I am not that sure it makes sense. That is the
>> .get_cap() stuff.
>>
>> Using the hw_caps is only useful when choosing hwpt_flags, then the only thing
>> that matters for patch 12 is after the device is attached ... hence we gotta
>> look at hwpt_flags. That ultimately is what tells if dirty tracking can be done
>> in the device pagetable.
>>
>> I can expand hiod_iommufd_vfio_get_cap() to return the hwpt flags, but it feels
>> just as hacky given that I am testing its enablement of the hardware pagetable
>> (HWPT), and not asking a HIOD capability.
> 
> arf. yes.
> 
>> e.g. hiod_iommufd_vfio_get_cap would make more sense in patch 9 for the
>> attach_device() flow[*], but not for vfio_migration_realize() flow.
>>
>> [*] though feels unneeded as we only have a local callsite, not external user so
>> far.
>>
>> Which would technically make v5.1 patch a more correct right check, perhaps with
>> better layering/naming.
> 
> The quick fix (plan B if needed) would be :
> 
> @@ -1038,8 +1038,11 @@ bool vfio_migration_realize(VFIODevice *
>      }
>  
>      if ((!vbasedev->dirty_pages_supported ||
> -         vbasedev->device_dirty_page_tracking == ON_OFF_AUTO_OFF) &&
> -        !iommufd_hwpt_dirty_tracking(vbasedev->hwpt)) {
> +         vbasedev->device_dirty_page_tracking == ON_OFF_AUTO_OFF)
> +#ifdef CONFIG_IOMMUFD
> +        && !iommufd_hwpt_dirty_tracking(vbasedev->hwpt)
> +#endif
> +        ) {
>          if (vbasedev->enable_migration == ON_OFF_AUTO_AUTO) {
>              error_setg(&err,
>                         "%s: VFIO device doesn't support device and "
> 
> I would prefer to avoid the common component to reference IOMMUFD
> directly. The only exception today is the use of the vbasedev->iommufd
> pointer which is treated as opaque.
> 
> I guess a simple approach would be to store the result of
> iommufd_hwpt_dirty_tracking(hwpt) under a 'dirty_tracking' attribute
> of vbasedev and return the value in vfio_device_iommu_dirty_tracking() ?
> 
> if not, let's merge v5 (with more acks) and the fix of plan B.
> 
> 
>>>> I can follow-up with this improvement in case this gets merged as is,
>>>
>>> I can't merge as is since it break compiles (I am excluding the v5.1 patch).
>>> Which means I would prefer a v6 please.
>>>
>>
>> Ah OK -- I thought this discussion assumed v5.1 to be in which does fix the
>> compilation issue and all that remained were acks.
> 
> v5.1 proposes a CONFIG_IOMMUFD in a header file which is error prone.
>  

hmmm, ok, that's strage. It does look quite common in Qemu? e.g. We even have
CONFIG_LINUX in the vfio-common.h header file.

>>>> or include
>>>> it in the next version if you prefer to adjourn this series into 9.2 (given the
>>>> lack of time to get everything right).
>>>
>>> There aren't many open questions left.
>>>
>>> * PATCH 5 lacks a R-b. I would feel more confortable if ZhenZhong or
>>>    Eric acked the changes.
>>> * PATCH 9 is slightly hacky with the use of vfio_device_get_aw_bits().
>>>    I think it's minor. I would also feel more confortable if ZhenZhong
>>>    acked the changes.
>>
>> I guess you meant patch 6 and not 9.
> 
> yes.
> 
> Thanks,
> 
> C.
> 
> 
> 
>>
>>> * PATCH 12 needs the fix we have been talking about.
>>> * PATCH 13 is for dev/debug.
>>>
>>>
>>> What's important is to avoid introducing regressions in the current behavior,
>>> that is when not using IOMMUFD. It looks fine on that aspect AFAICT.
>>
>> OK
>>
> 


