Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92D0ACAC59A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 00:56:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uz2w1-0004dg-4g; Wed, 17 Sep 2025 20:55:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uz2vy-0004d3-PA
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 20:55:38 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uz2vu-0001V4-RH
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 20:55:38 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HNPvLX007349;
 Thu, 18 Sep 2025 00:55:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=/doaooiHuhGrbZTRdNOleT2qjIrxkk+O91a4XCq9nrY=; b=
 bF/pb6pP15I68iUGD9TfZXGZxGbxmejTgKjVSYLlLyn+dkYl2LHR5rlLEU1D+eXN
 6VCvY/qDx9bFMHOTijiDQqOG7Y0oMtqvxWGc/V7cqwV/WtoNJn0pZ22bDKPWqxGt
 vP+QLzHluYQcjgG53wqIVB8x7FdMjXjhlsSZqbkspHQVPLO8+1o1s/MC149ztHBp
 H5EsTj/CpB3fVoK+1GJqUIivh2vcKc9m7i6m2bIwXwWXaRfxjcgEzWiHwrRNAJDr
 4rrF0eOxjq5RVnE21mKzImVrnNLpNoD0cVWneqvcEGABNmRomYFAzrPgpkJl/96q
 /2bdFP/rxp/nX1D27yZwMw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx92dwu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Sep 2025 00:55:25 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58HN5p2O027194; Thu, 18 Sep 2025 00:55:25 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11012022.outbound.protection.outlook.com [52.101.43.22])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 494y2mr3x9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Sep 2025 00:55:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=agtxgVFi627jeaEPlEgC/SAd+ITPUOWE/8I+SzOpWc6ZC/HlAdsWRHE5bd68Zme5baqS6Ze5dGfehIcXbyM+DWzSDW4FxZJH2O7Eek2uoC577GvjRKdxouqfbw1AKEmhtuVYhLy3DtbWD8tzV6ebuUxXe9QHWZ0AiUkp2FBT0lHd/fFWHWDuDA01mu8mqFZ6ab3M4mxRgKF3iqP5ebEpvW2wxzyhR3SeJjykgOFuwIwh6UHGrfiPwkgAMo+5zGsLUk/tiAgWD8abiWwk1lqtbBYebpSUMj9wcU/w7fMtX4ESaZ3zvmz/Q/ikdKaz9Sgp+TV8wq39EEGOPgTL+mDsFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/doaooiHuhGrbZTRdNOleT2qjIrxkk+O91a4XCq9nrY=;
 b=NUAqZcK1muTR7crCy2enfaHd+uvRv6vzNAiqf5cU/yBt0/aZYIQCU5tMhg3xWLoviv+QHOVqL9ApJiOqxG4/aWCcpWiWpmZUgTon+Ejyg73Og8quEFydsbfyeaL6j6bMho9qIFdeW3ITazB6Bax/T2RCTzot0pEfT+8CVbjTow8QkHSNHmyiIDbpNM919FnqVpWFAl/wWkWDndQEA9OfrzUM6/dejNuC7XFYAA0tDSPJ3knqiYJpE3LlwuQd+5ikMvqCsnqYV3jr1slaRozF1zh9nRu3fcWeE4GpZEbY2QiDl8yoHZol6JX0HMWDdo4A8WAhk2E+2ObKeNuIdCMDFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/doaooiHuhGrbZTRdNOleT2qjIrxkk+O91a4XCq9nrY=;
 b=tCXqTv2Hcj2J7+FoRgp/M1vM3hCCrcgvCtnkq/OCbLNPVAX6DIGlebjk3TblqUn4HmdNToy7g5doIX/oaF1o1L1MT89V0sOUJEgT2lnRrQGQBwV/BeWyN8xW6PArFQ3jkxNf2l5hvtKaK3wRHAxWYuj8uEOGH/aiKOTPPfGYd0M=
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by BY5PR10MB4355.namprd10.prod.outlook.com (2603:10b6:a03:20a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Thu, 18 Sep
 2025 00:55:21 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%4]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 00:55:21 +0000
Message-ID: <cb2f1cc3-146a-4950-98fe-a763d6f8fd91@oracle.com>
Date: Wed, 17 Sep 2025 20:55:14 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/20] amd_iommu: Toggle address translation mode on
 devtab entry invalidation
To: Sairaj Kodilkar <sarunkod@amd.com>, Ethan MILON <ethan.milon@eviden.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "eduardo@habkost.net" <eduardo@habkost.net>,
 "peterx@redhat.com" <peterx@redhat.com>, "david@redhat.com"
 <david@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "vasant.hegde@amd.com" <vasant.hegde@amd.com>,
 "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
 "santosh.shukla@amd.com" <santosh.shukla@amd.com>,
 "Wei.Huang2@amd.com" <Wei.Huang2@amd.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>
References: <20250502021605.1795985-1-alejandro.j.jimenez@oracle.com>
 <20250502021605.1795985-19-alejandro.j.jimenez@oracle.com>
 <5fedf606-dd01-4a0a-af67-077e9ef9d0fd@eviden.com>
 <9fc055e7-aa69-4c14-a8ba-5d555da42033@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <9fc055e7-aa69-4c14-a8ba-5d555da42033@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0056.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::31) To BLAPR10MB5041.namprd10.prod.outlook.com
 (2603:10b6:208:30e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|BY5PR10MB4355:EE_
X-MS-Office365-Filtering-Correlation-Id: 62883dd4-fb90-4b40-f5d4-08ddf64e0b3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OUVadmIvU1JWcldLQ0E1UjUwbUJHWmlUQmVrazUwMVdScjJDYnBhTVJZSWtl?=
 =?utf-8?B?ZmM2V0RBVHhSTjZXUkg5bXR6aWh1aURiamZkNUVaWmIzZFVOdGlKNTJ6czBM?=
 =?utf-8?B?MS9KZzJqb1I3eGtvSjlmSDgrYlNvSjlXK0tnK2xBamYzSFQzVEttcGMzZHJU?=
 =?utf-8?B?WnlZRWlqdmpJQTIrOFVDbzBYeUJFelNaKzRmM0FOYnpILzZPaVM1YTBySG1Q?=
 =?utf-8?B?aUpXdXVMTTNuWExhTHovTWNkaCswalR3bXJYVkVQeW9VVE81TVJBQ3VuQUFF?=
 =?utf-8?B?QXRhMW5SVThLNHlvS0dxclRJZ1VaSEt4bXUxR1Blci9OK1UzRG9hQU9jOEZQ?=
 =?utf-8?B?UXBFV3BZcVAzUWZYaWJFNWJQOFkwU242WFJVZkIxS3ptU3F2bGFtdFNUUC91?=
 =?utf-8?B?SUkvbG5WSzVQTTVGUzhjdGdZdFdBMWUxQkZYTHRhbUR2MDNhdlFkUWVHSks2?=
 =?utf-8?B?KzIwc0FHWHpaemllRlBJQm1mMXN4djdzemg2ZFFXWUlBZlhzRXpUZVMveFpl?=
 =?utf-8?B?MDk2OVlBV2U2bVgzcXNTZktVS0QzYkJkVHdERDFmT2VTOTBwckFjR3FXZ1VZ?=
 =?utf-8?B?aHJNWW9nV2ZjRVp0VFJQa214bDM5MVNJckt3VVdhd1pSVUFTSmRCblpGMy8y?=
 =?utf-8?B?QkRNbkNkcU9qVngxQ2RFcEtoVC9BN1pIalBUSmZwOHZ0Zk5OVmpEbFQ2bEhM?=
 =?utf-8?B?OExHKzNMdWFScWQzME9wbkVTUk9Nelp4MXVCaDBSRFFlMGxjUnNqclpmV0NS?=
 =?utf-8?B?L1RMTzNHM2toVHh2TnhSOVBXeWI2ak5iLzl6aG9vNUd1NW16TVl4YkJBQXgv?=
 =?utf-8?B?b2pRclhCcUpvWDlTd3FuWG5SOHBuT0VVTWZwNHhIbjZOVURzTzNDUUxsSCt1?=
 =?utf-8?B?UWNtbXVMOTF0RnJONlM5VUk0eVJWTjBhUURlTGR3Uk5nN1EvUHMza29QV1NR?=
 =?utf-8?B?eDhodWlESFdvdXdYaXMzMmRDUi9pZk8xVnc3UzNsRFZmY2xmUjRmR0FMT1k3?=
 =?utf-8?B?d295RU9hNzJ1bTlLZktuWmU1aVFlY2ZDQWJudnI3ZTgxcGJ5aVo4c21tQm02?=
 =?utf-8?B?Z3ZUSllQWUcrMTNJdzdHQ3ZpZFdqQ0x2SWhjRjRjeExwRDZna24yYVNwdmxn?=
 =?utf-8?B?dWloVnVUTmtpSXV6eWN0R0hqN0YxTUhGejlKdkZxU3cyZWFzWkhiNm4yc2hT?=
 =?utf-8?B?ZzAwb2xmSGFaeTUwYzVnUHgreGRUZ1BiQWZUSHlyZnFNR2g4aFRlNW91WG9R?=
 =?utf-8?B?OUJSb1BJWklxb1dGb0ZtM256Yk5jUnAwdFlLN1NkWGlJbGREUnhhZ25jbTVn?=
 =?utf-8?B?bWJuNS82ODFmUnZxVWhMRjVFdWVXZDdMWmd5NzA1UmJtdDZJd2NyeE9LeEpE?=
 =?utf-8?B?b29RMGdhazczTnVhT2pSL0g1bHE1OUMxOWlkaEFmc2Z3VHlJUVZ1dDh0SW5i?=
 =?utf-8?B?MFZiaWswbDRUQzh3ek50Y0lyQ0xrMGVkWGxXOFRpdTMxSG5VRkpZRUNoMVM2?=
 =?utf-8?B?aDF1VkZ2QXBkdXNPcXQvRjBncnN4SWtpVFZXWVhTSFdjb0ZjNUhRN29NR0tG?=
 =?utf-8?B?MXlIYmIwMjBBUS94NFdYMGljSFZqcE5wR3lrTURPVHBqTGd3ZDc5ZGlBOURl?=
 =?utf-8?B?Q0ZWTHl0dGpmbHhPb05UdS9QMVIxRGhjdG01ZDQ3VHRmeFpZTTRwaEpid0F5?=
 =?utf-8?B?OWViMnlwdU8zaGV4eDQ4czdwRUdKUXQ5RjhTOHNJUUZRTHVWNGxyM1JQVHBU?=
 =?utf-8?B?cGdMNlorS1NWdG0yK3FrWXRMWGhHY054dWxKWUx5YllvSDhGYW50cThOZFJT?=
 =?utf-8?B?UHkzdFFzb2FlNkJEVis4aWdmcEhIa2U4TElnYXRmSWpRK1VwV0Q4RG1TRWhw?=
 =?utf-8?B?S0lLdzZTVXgxU1l2VlNIYWUwZlhIdnoxZnViSzlHNUxlN3lSSkRNeFZ6ZUFU?=
 =?utf-8?Q?aKYYxXDJlVA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5041.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b05YTFVQSmw5cG1LZXQ5SUR3dTVVRVk0RS91VGlSTytnVDlFUkRrN012V25J?=
 =?utf-8?B?MmxDNEpRWUlGRkM5TFhSVzloaUY2bmVWalRHa2FRUHk3R1h2M1BabXlvUnhm?=
 =?utf-8?B?azJ6eS94VHJLdVBzenN4TnVxTjloWGdNTW42c3RYUVN6cDNhdVc4aHcyczBE?=
 =?utf-8?B?TE1FclB1Vk5ZRUFSbWJETHhZRUw3MGJNaTlMZFdpMDdnL3Bvdy9ZN1I4NEhV?=
 =?utf-8?B?Rlo4VytDOTNYNnFwL01kNGcrRFcxOURJZlNqdmxtdmw0TFBDZU9wY3RMRENU?=
 =?utf-8?B?U0kvV3k2Rm5tY2RtZVRQZ2s0djB0WGZCcTNRd2N1cmRxRTJka3BvMWcxdkhP?=
 =?utf-8?B?U1R1emhDckk1cmkzbzBEQy85eTg5QnJPYlRKU2lnOTFtZUhWWjFldUNNMkE1?=
 =?utf-8?B?ODZJSzVBaXAvNnl3N21xckMxRktpQmI5WG1wNlVmVk9ZbG5lZlVQYm1Jckhp?=
 =?utf-8?B?UVE5UVgwSUdQOUZUbWRNNjF1NlBsK3BJVUNXaklnM3VQVkNncDBlRFVRUmVT?=
 =?utf-8?B?Z1lZeloxZnNzU0pzWU1QaWJxZU5iVGVtR2pSeHZMMG94NVNPUnBia0JCeXlx?=
 =?utf-8?B?b205ckJmcUNLZ3lYNEpNc2hWOU1lY2pWTi9acVpPNFY4eDNqUTVnUmRaOHNK?=
 =?utf-8?B?UlQreHd1a0FxWGV0RTBWMnJqaWpZZjF4L2VlbFNieWlPYkE0TFBuQTdIK3pE?=
 =?utf-8?B?U2ZUZjZSVnFwVXJJS1dpU0xaUDBDMzhQMVU2ZnhoRUF1emkzU2tNVU5ZN3k4?=
 =?utf-8?B?MGRLcmhERXE4b083ZzJnY25raFJ1UFZRckJ5a0ViZmJYSWdCU0hZb2lGSktT?=
 =?utf-8?B?ZzhvRG1zeWwrVWdMaUh1Vk5OdXZPbjJxb3pGWmUra0xsRTludEg3OWxsRmpz?=
 =?utf-8?B?djROS3lXOWdCM3VNNTVnbW02Skg4Y3JtWTdQb0RWVTVQZG1lR3cvdlhoTUdw?=
 =?utf-8?B?c0xNZEd4ZHVPbXFpR2diS2YrZlIrMkRWSkh3NUZGallsMXdiQjlJVFlTZlQ3?=
 =?utf-8?B?MEZldUdUZEU1L1piempXMjljbTBNbTlNaUdIYWtvb0xGUFhwWEhqME16Qk5l?=
 =?utf-8?B?QzdVK0hrL01qY3NwWXBvVFdQUitrN3VzRG5uQjdUSTFLZEo0eUVnYkRDbkJN?=
 =?utf-8?B?RXhtckZZTzRHWkxxRytQR1VFWS8vSHpOdlJjelI3aGM1SFBqT3dwTXlycjdG?=
 =?utf-8?B?bDZ6VC9xQ2svQ1hSOUU0VzJrVTk4K1UyTXRzN0M1ajMvVlVPdXFOb2V6eEJE?=
 =?utf-8?B?R3h6ZjRiTCt4YTJUUHE3Vi9MYUZMUDQrUUtQQnh2RFNGdk5JZUk4SG5wb21T?=
 =?utf-8?B?MElvY2h4THJ5Tlljd1pHV3hLOXZ1c1dZT3NabTBqZGdva3JqMmx1QWdZbUoz?=
 =?utf-8?B?czQ0U1YxS2dxNkRMaUtSNXRkd2VJRVlzY0hCb0VaZUdHQlpHUG1peVpDNTdx?=
 =?utf-8?B?RThVaDdHN0tEaTUweGxnV0xuUUZmWGVzTzR5VHlueUU1eFZUS3pvSFR6MTBs?=
 =?utf-8?B?STlZazFaUkF2bVJnTmtjVmdWWlNFUEFNVlZueUhJYVcweXlrQm0xa25yWUo1?=
 =?utf-8?B?cmxZUnlyK3ZSd09BS3dlMFBIeDFzSytOam5wcmtOYU1XV3ZQTysrVWREN1dn?=
 =?utf-8?B?a2ticUlsR21kWnIyM0tlbkVobFMxRzVCcU5NRWpIa3pCRkY3WjYveHNoR0ox?=
 =?utf-8?B?Z2xHaFNsRUZ3aDNMQWNzS3NVYXEzR3JGVC95REdROVhXRmwyMWUvaytYV1VB?=
 =?utf-8?B?MWc1U1lMZElzZVdWRzdYSnhnRXpjT0syTVVpb05LR1JvcG9XMGFzckNkWjF0?=
 =?utf-8?B?OEVlOXQzSFJvSTRveWttZWpzcXlXMlQ1VEl4WFFJRUxBYXRUUkVOQjlkM1ZN?=
 =?utf-8?B?dTYwYi9PWjRqRlM4dnp5eG1QemVueVRPaDlQQXdqd3hWWFU5c2dGNlFWcU5R?=
 =?utf-8?B?UlBiMkx4YnFYVmxiRGZKQjluK2ZJNkFvVGZEeVNSaUdlWUcrSVYzaTdURmZt?=
 =?utf-8?B?RGl1OE5acDIwMmp0UVBqdEV5K3lvY1FYL080WGxaNW9VMGkxNTBobk5CQ05P?=
 =?utf-8?B?cDM1N2dCZ2VKaDgxQ2lrOVdOUnphbmQ0WVdpV2N4QXdVbFNxTGZkY1hrdm1Y?=
 =?utf-8?B?bTdoNkwxSXpyUm81VGNKQ0FLaUdQRzMxQXlsNHZoVGNaL1RvT0Q4TXQya1p5?=
 =?utf-8?Q?l9mhCfhymBOzjkjRRjixM+A=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: z++tHXzNk8sFRmSan7Ny7Sdga7gv2MddhIt6A8yOQWH7dPm9hMDFopAwLui0k8cPvlY+vrlmpo/3ibcmJviMQCoovSoA2+ruVCQG11D/vUOekvHV72uBeYEQe4jz+rcxigm4bP9gKmwc8hhe6TSWPObQy0VJBkZZsKHGHx5QccAxZpMyRIz+WHX5xpdHlVTen1uk/eR1mfMhCyQrtTV3ZHoEfKrErKC2y2EXnQuFqhwhpuKKvHnldooWSf/hj0CcV3xWnx+hQl3kg7Ce+GPNVlKLBNuIbLyQm/aeSfyhpYzs7r0JA6o6St4FXWvNS75792KB4Kv2VpYxaUcjcfNHYEhYy7mjp+Eiqo3hXFPLAc/Xfx48OLUJjfj0vQEEU1gj+Y66Bh0nEueE7/p28N7piP8mJK9GQrev2DSjpy3HhpfG5A0xOm2+t7OYPvP6nBZBrZVFyzKqvXhuIxKS2ftPBh3/12O7+WuNhV+XZe3Hkp7KTfN5e5pT9yIfNv+93X8CQY5WnFpnC/LRAxt8S1AY7Q6iqOfrE5ktElPjJ3nMnf/RkNNtQ9nDhMkU67M85a+pUOV2xP6GaR1PjK7RIAIA+NGqv6xWBQiiBtFRYXaJSRg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62883dd4-fb90-4b40-f5d4-08ddf64e0b3c
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5041.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 00:55:21.4301 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sXClKchD5P/8O7icsdUPQlr3q5eeKtaMKsvSmMtM7QeLLw12ChJqgc25veRo7SyqbY2bn0VIdtqefRkVdR7FasH9bQe/c+EMxW0mFwExfKc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4355
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509180005
X-Proofpoint-ORIG-GUID: vHL0J00DQyjsPAQqP5reeUIF6GjCH1RH
X-Proofpoint-GUID: vHL0J00DQyjsPAQqP5reeUIF6GjCH1RH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX03oAnoecIzkY
 UCwMvy6cfrqTyw0NQBasrx55eoEIexQbH4alKEGMz+KQcf5BAisFILc259yVrHIGpq4KM89Z7UW
 CKgDWP2SoNTkJnGaoRdw3A/F6ro4g8ShQOi1Kr2uHQDGnY7go8UEJAqPf4sHs2p1y8/NDiuLx8d
 Cz+03cXS5Pr8my+zRuOqR6FLvzAk5httZosn4fTFwNrX0bzkQJ/vbWHzu3MSN43nyI8pMnqLPI0
 2DSScmQuIkOeXbsfgsFIFGrIwYEIyhYaG3Hi4Sfjg4wJ0UzLz8ScE5UgeRkWK+vr3xa4zOM11bL
 ptY42Ig4o6UhCdYO7cF/fawOzO4y3YjEEBKh9ZYhKo+v9ny1cVY/pZMfAlt0xSuO4lLoX3pdQol
 6duFlmO1Kq3ki1kCNqcbONODwtidsw==
X-Authority-Analysis: v=2.4 cv=N/QpF39B c=1 sm=1 tr=0 ts=68cb587d b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=4QmELKNebTp2gj7mLH4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12083
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 6/12/25 1:23 PM, Sairaj Kodilkar wrote:
> 
> 
> On 6/12/2025 1:57 PM, Ethan MILON wrote:
>> Hi,
>>
>> On 5/2/25 4:16 AM, Alejandro Jimenez wrote:
>>> Caution: External email. Do not open attachments or click links, 
>>> unless this email comes from a known sender and you know the content 
>>> is safe.
>>>
>>>
>>> A guest must issue an INVALIDATE_DEVTAB_ENTRY command after changing a
>>> Device Table entry (DTE) e.g. after attaching a device and setting up 
>>> its
>>> DTE. When intercepting this event, determine if the DTE has been 
>>> configured
>>> for paging or not, and toggle the appropriate memory regions to allow 
>>> DMA
>>> address translation for the address space if needed. Requires dma- 
>>> remap=on.
>>>
>>> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
>>> ---
>>>   hw/i386/amd_iommu.c | 78 +++++++++++++++++++++++++++++++++++++++++++--
>>>   1 file changed, 76 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>>> index a2df73062bf7..75a92067f35f 100644
>>> --- a/hw/i386/amd_iommu.c
>>> +++ b/hw/i386/amd_iommu.c
>>> @@ -991,18 +991,92 @@ static void 
>>> amdvi_switch_address_space_all(AMDVIState *s)
>>>       }
>>>   }
>>>
>>> +/*
>>> + * A guest driver must issue the INVALIDATE_DEVTAB_ENTRY command to 
>>> the IOMMU
>>> + * after changing a Device Table entry. We can use this fact to 
>>> detect when a
>>> + * Device Table entry is created for a device attached to a paging 
>>> domain and
>>> + * enable the corresponding IOMMU memory region to allow for DMA 
>>> translation if
>>> + * appropriate.
>>> + */
>>> +static void amdvi_update_addr_translation_mode(AMDVIState *s, 
>>> uint16_t devid)
>>> +{
>>> +    uint8_t bus_num, devfn, dte_mode;
>>> +    AMDVIAddressSpace *as;
>>> +    uint64_t dte[4] = { 0 };
>>> +    IOMMUNotifier *n;
>>> +    int ret;
>>> +
>>> +    /*
>>> +     * Convert the devid encoded in the command to a bus and devfn in
>>> +     * order to retrieve the corresponding address space.
>>> +     */
>>> +    bus_num = PCI_BUS_NUM(devid);
>>> +    devfn = devid & 0xff;
>>> +
>>> +    /*
>>> +     * The main buffer of size (AMDVIAddressSpace *) * (PCI_BUS_MAX) 
>>> has already
>>> +     * been allocated within AMDVIState, but must be careful to not 
>>> access
>>> +     * unallocated devfn.
>>> +     */
>>> +    if (!s->address_spaces[bus_num] || !s->address_spaces[bus_num] 
>>> [devfn]) {
>>> +        return;
>>> +    }
>>> +    as = s->address_spaces[bus_num][devfn];
>>> +
>>> +    ret = amdvi_as_to_dte(as, dte);
>>> +
>>> +    if (!ret) {
>>> +        dte_mode = (dte[0] >> AMDVI_DEV_MODE_RSHIFT) & 
>>> AMDVI_DEV_MODE_MASK;
>>> +    }
>>> +
>>> +    if ((ret < 0) || (!ret && !dte_mode)) {
>>> +        /*
>>> +         * The DTE could not be retrieved, it is not valid, or it is 
>>> not setup
>>> +         * for paging. In either case, ensure that if paging was 
>>> previously in
>>> +         * use then invalidate all existing mappings and then switch 
>>> to use the
>>> +         * no_dma memory region.
>>> +         */
>>
>> If the DTE is malformed or could not be retrieved, wouldn't it be safer
>> to default to the DMA region rather than falling back to direct access?
>> Or am I missing something?
>>
> 
> Hi Ethan
> 
> I also agree with you.
> I think right way should be keep the IOMMU DMA region if error codes are
> AMDVI_FR_DTE_RTR_ERR and AMDVI_FR_DTE_TV. Otherwise when error code is
> AMDVI_FR_DTE_V, switch to direct access.
> 

Implemented this suggestion in v3. If AMDVI_FR_DTE_RTR_ERR or 
AMDVI_FR_DTE_TV errors are hit when retrieving the DTE, isolation is 
enforced by using DMA mode.
It adds the complication that all current mappings must also be 
invalidated in such cases, since otherwise guest devices would still be 
able to do unrestricted DMA using the current mappings.
As far as I know there is no current functionality in the Linux AMD 
IOMMU driver that uses the TV field for a specific purpose (other than 
setting it as part of building a valid DTE).
I suppose a hypothetical guest OS driver could attempt to toggle TV as a 
temporary method for enabling and disabling DMA translation, but 
modifying TV has to be followed by an INVAL_DEVTAB_ENTRY command which 
will end up rebuilding the mappings anyways via amdvi_address_space_sync().

Thank you,
Alejandro

> @vasant what do you think ?
> 
> Thanks
> Sairaj


