Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83210C021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 11:30:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpQTU-00056T-SN; Tue, 04 Mar 2025 06:30:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tpQTR-00055s-LK
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 06:30:09 -0500
Received: from mail-sn1nam02on2061f.outbound.protection.outlook.com
 ([2a01:111:f403:2406::61f] helo=outbound.mail.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tpQTO-0008Hc-VN
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 06:30:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LB7p9Rm10MrHlMteJuS0RBrSIAAdtgWQy9l15NJqLrpUnp75kyLz7K36htfvcG79MYXzujKavuvlypE6UiLYu3oTX3DnBVPQ6LBR8LF/6rhX4EBOqcFwGWYkpsz377C9NDdVeQ0iz1QEqoI+PKIitERzUymzQunqAUdBjn5+p516kUailAgkJVo8es0626FKle4aM3YLe/eytKhroiEGbep67+5BzxkPqIyVhzHOZYBqrRcksiXSeHvC8UKlhJODg/mqYM1dSNlmjjNOcyHmikr07vq+Q9vlQxbBdlneTZ3ow2EvTXdD7qpC46TRyK9RjgAbWD6iF+o0PFBA3qb7TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9NLxtBw2zXb4wHiCXcWHq+nTBD3JoXDw6gvdArlw7qY=;
 b=CE0VlGikcUwKhUVjrneHR/YPcyBhv/Flst+NiWLKKwyZ0uAaQXwfapemVuF1sLqqJ9C3K7wDDf5HVed2TxhcpuulRqHGmyFVhaKVsP3NRfFTZL5dmL8kp2RhMOAeUOc/f6SbA+A7N0pdojHOQdjYUSJx+jeAspl9ddpaHvqnAYQg3So39WIW2ExlwX7pX0oZRS0o4NEXxya6KC9mNOrxDKZSuZQgdDumpDMj5LuY91th0YyB3a676xoEYMJ1YL9bD80t2dfq+rWXMe9JQHp8csk3T4xHdum94KcQBqX6pt9+zELcbdCF/lKyYHcje1Xp2qdowMouRAVwrbE3fDVE5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NLxtBw2zXb4wHiCXcWHq+nTBD3JoXDw6gvdArlw7qY=;
 b=Pa3rFls3/bMvyF0vPfOarOg2PTeMnIMmcSQIIp04EqbCo3hXbt8cB7mVu75SOl8ixcg9kEo3iSsKovPv9WFSsraA63SfvPFDRyJPt9s65C6BvyjgN4hVC6iUaxH5kaJfQxRon47voUz2cxfC8p9BgiIU0SvkjRVn9xyXqv1euGKSXNLL6qiWWRC8Ps8fQAPqkVHCFlIhNj9MpsmlfAw3hamc5e/wwuS3+3VUJAuaQmUv/VZJtMlE0somLyf76X1+SsnPhRsAicy+C9DPee6UBXiDeYF8EZkMiSwAcNBcQL4kczkm1ylWLshRhi3wrVkC8roaJXhCfmpisb6uCBj1Zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by PH8PR12MB6915.namprd12.prod.outlook.com (2603:10b6:510:1bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 11:29:59 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%6]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 11:29:59 +0000
Message-ID: <64ef5268-a951-4a03-9728-e6daacf7d56f@nvidia.com>
Date: Tue, 4 Mar 2025 13:29:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 31/36] vfio/migration: Add x-migration-multifd-transfer
 VFIO property
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Alex Williamson <alex.williamson@redhat.com>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1739994627.git.maciej.szmigiero@oracle.com>
 <8f38087567dfc898fb0f1688be0689dd1dacfa22.1739994627.git.maciej.szmigiero@oracle.com>
 <f462d899-7cba-4673-b8bf-f6a3b25d25b3@nvidia.com>
 <0e982175-efab-4dce-b183-3ce53f17c522@maciej.szmigiero.name>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <0e982175-efab-4dce-b183-3ce53f17c522@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P302CA0043.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::16) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|PH8PR12MB6915:EE_
X-MS-Office365-Filtering-Correlation-Id: 62e60289-0fd3-4a5d-5a4f-08dd5b0fe5a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WmhtWGY0MEs2czB6bjMzQm9VUDRRYUpQaFpWUXFXLzBEcFNLazBja2djK3Fo?=
 =?utf-8?B?ZEZCbVR0N0dEdEF5Q2l6cy96RHRPOXV5dThXTFhvNlFhQ05haG9UblphYUsv?=
 =?utf-8?B?eUh3M0Jibm9RbVo2UGJBbm9iNG02R2VSaUw5VXo4Vm5EOU4vYVh2SytxTDFK?=
 =?utf-8?B?cmRxVndrSENUNVM4Vy9kM3NHb2NKVFd1TU5XMWpVUzgzd2pMcXptbVRSY1FF?=
 =?utf-8?B?dnBObEFWMkRYVXF4b1Z3c0ZIemxGSjFzYkhzSVFzM1E5ZUU1ZTdKWTRFMkZN?=
 =?utf-8?B?TU4zcGRMWnVUcWR1NE1rVVcwVTh3MmZLTGhWM2xwMlRuZGszQTlZRG5LNWQ0?=
 =?utf-8?B?YzZ4RTltb0djcUhpMTZEeFVzaE96OEw5T1Njb3lReStqVWVBdlJNV3EyZWYy?=
 =?utf-8?B?bjRUVk9TRHpkTVlBMnRnUHRrWlppb1R6ZUtVV3JndUVkcFVxQmlaYnFXY2V6?=
 =?utf-8?B?S2hHdHN1OGpNQWFxdE1sckppVzFabVBSdHhzbHRJZHhjNTlIOXcrVGtYQmtD?=
 =?utf-8?B?cktkbGhraldYampJV0tGSXorOGJwaVJUZHBtRElJckxmWmxpY3VWdE1yK2xI?=
 =?utf-8?B?TzI0WHlVaFZtdHpSaTliL280L00zSFQwcVRuWlJnQWdoaVN3ZjNjdWpsQVg3?=
 =?utf-8?B?YllJMXVjcnpqV0wvUTdaMXJnNVJvaEtyb3JtcCtOUDJONEp4bGZoSXZ2bXJB?=
 =?utf-8?B?REtKODhCc0lXa1NiOFBSbnc0RHhUL1dYTEE4VWoyV1FlaTVDQmREZStQR29x?=
 =?utf-8?B?VExWQVI3NTA2NDduS1BMbTUxd2VaWWdxdS9FSHZPaFRORnkvZFpReEswL2ll?=
 =?utf-8?B?c1B5WVFQVGxkUHZIdmtyczNXZzZHY2d1bkZPZUxYcnIwL3Q5V0RmaEZQWTJJ?=
 =?utf-8?B?RDJHWGcvYUpWbVVHMGdOcVpxblpJQkQ3aUlqSUNtSm5pUmE4YWRTbEV2MlFF?=
 =?utf-8?B?d0lPcmpRdzk4cm5vMFV1N2dvRWRvb3o1VWVka1YzdGNnN1FsM3F4SWVSM1Vr?=
 =?utf-8?B?enJ1NXZLdXFrUTJFaTEzOFRZYndtLzlzYnpZbitJZnI0SDllcWNBcG15RVBB?=
 =?utf-8?B?c2FDNU1VQklGbndDWVp6KzV1MG54VFpGUjVxWHNnRm00OEdLR3AvQlVKUi9p?=
 =?utf-8?B?M3Q5VGpxSWhERlBiT1IvSzNnYU9uSnJGZi9QQ2d5Rnlza0hrYTRHYzNWcW4v?=
 =?utf-8?B?d1c5Ni82S0VqdVZDOTlqbUJNTFQ4RmxvYVlOTkhvRTBzNUdIZGNNdDdYRE5J?=
 =?utf-8?B?Z1B6dWJ3ZW8rOWhUa3NjcEZTRDc0cTkrc2RNUE5BSEZ0UU5CZEVmZXNlVFZn?=
 =?utf-8?B?ZDh1YWZORzBhckNjNDFWT1BvdWJWYWpZRlVKNVJxTTZDYWtET1ZVaDgwdkJy?=
 =?utf-8?B?TDRXZmpzV3lGTEJlYWwxQU5CK2pOblBSZjcxc0QzR09QbE8zem9BT1dsZDh4?=
 =?utf-8?B?SHllRHVHd1dVRUdubFdWWFBoeVIrVzM4ZzBydzVxdDBUaW5ET1BuN1g4bnNY?=
 =?utf-8?B?NURLNlRqS29WdUMrTkxYRklzUy95ZXpGVmFmL2Z4MUxqVFZNOVIrYU55TW5L?=
 =?utf-8?B?ZXhWK0VCdHNQdlFLWXVlUnFZcmxtYWRtYWFzSGRkM0xuT3BhT0hKVWJpM0FM?=
 =?utf-8?B?SmdsRnJXQ3NYdmFnbk14ZStlZWN4V0dQKzFSaGVZdllOQ3ltWHlpZDBnd0JB?=
 =?utf-8?B?UUxOcjZEejMxY0Nuc0NQeGlERkI2RHY1SHZ3U2p2QkVycmN3YmhxdkNSNVVH?=
 =?utf-8?B?ZGNNNi9DODM0V1FROENLc09XM2M0eXhKZGxTS0tURkR2c2dQN2Nzb3N4WVZr?=
 =?utf-8?B?bTViVHBVa3JPRUFvTVBWOGhsc3ZwUnNVRUlLOTFZVnNTQVJ6YVFVOVdyTTA3?=
 =?utf-8?Q?QeFXCddTq2WXa?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHJ6a0lsWVZOZlBaYmtDNVFYdmlGZUNhaHl2eVFBVFUrVVJtaXYyb0k1QXVv?=
 =?utf-8?B?VjFSOEg3T1cvYzZiVjg2V3M1UkNWdlFGdXlTaW04QXBaS0RBaWs1VHRHLzZu?=
 =?utf-8?B?RDVBWGlhSW9KeDByU2pyTEwyVW9jRzdmdEgrUU1PQTdtMzFOaEgwaEhxYk9h?=
 =?utf-8?B?NmhyREZaVGVEMENhWTdJTU1MQ2FpOUtpZlB5clZ0OGR2RHlUaS82RzhCQ3cy?=
 =?utf-8?B?bm4vOElCckswNnlOUkoyMlJXbFE5MXM1b0R2YktmSDl3UWRlUythelBTS29j?=
 =?utf-8?B?cVFjcm1NQkxyamQ3eG96UGZpR0FqYjFITE04OEFycytUaVkwOUNKREc1amtk?=
 =?utf-8?B?QktVSWMrbzE4eFc0QU9HeWcyMWVKbUNGMG1UaU9oUG4zaUpVeDBMLzM1dFNO?=
 =?utf-8?B?b2l3dlh2WC8rZDhuRG4yb2NibzlNKzRhY3plU1RjdzlTVHhKUzVvMGVUUnJX?=
 =?utf-8?B?Z0pTVXlteEhlTzBUV3ltejVLV3RWUG1NMDNpRlNtRFJMNzQyZFU2eGJyM0gx?=
 =?utf-8?B?UENoRDhoRnJNb2VUSUxSVDREeWR0dTRyeTI1bHpzSE9FY1lyUk02ckhhRi9t?=
 =?utf-8?B?L3J6SGdlTkZEcXpZc3NEdXBGMWI4aHQwZ3hmcTdHZ0hPL2U0VHp1SnY0QlVr?=
 =?utf-8?B?M3k1NjQ1ZlFqMmlyVDVVSDBZdktCaldJajFVSFU5b0VObUg0TXFXTmc0bGtk?=
 =?utf-8?B?WWtRWUtKeEtWZTFvZHNLMnJ1YmltaXF0RWxmQjZReWI0QytlL2o2bkhJaTc3?=
 =?utf-8?B?Y0psTlkxSWJhWWV6S0dzWEh0bW11dHdUOFBDZjQ5TXlCOFF3RGFyelRTQktS?=
 =?utf-8?B?YUpjdDI0ckVsS1F0RnFGMXlvcldTeXYzdGRCS1MyZnBsUEFMZmhuMklwVW1F?=
 =?utf-8?B?ekRma2QzdEpyanZsYW1vUGQvazAyMTVNMTAyZUZkaHlUWE1Vc0tDNHg3Qmk2?=
 =?utf-8?B?blA4WkFXTENTU0JRdTd6a1FydkNTcnZNVWtXVzRDbjFGRXl0S2FkYzdBSG9P?=
 =?utf-8?B?bzB0aHdNOGZ4TnBLK3J0R3Q5UXB3K1lZQXFwZmF3ckd6eVFFOE1aMldwOXEr?=
 =?utf-8?B?UFQrV2RSMitXd1NUbm9jSCs2MnRReE15NnA1Z3NVZGRqRUdPdGZzVTc2VlRG?=
 =?utf-8?B?dHNkY1h1UVRTSEMraHNRa2pjZDlDWGI1TWhoTlNiaUhBaUx5T1ZmeDBPTlhJ?=
 =?utf-8?B?c1Q1RzdFVG1BRzNXN1p1eXRzRjQ3Ni96R3Y5ZFFEaUFweXR3emIxbFpVN3g0?=
 =?utf-8?B?WlNFTEZneXN4WmU2NlZRQmZmNEdKMzN5bE9IcTBrVy9MK3FZaSt5RWY3TVVh?=
 =?utf-8?B?Z1FVYjRXSUJIdE0wZjZCMjlLQ2tRNFVGTmtmd0tYcjhXSGtPbjNRcWRRa2tq?=
 =?utf-8?B?MDRhTytWU3JNbjdVTEJmZkR0WjJjOGJud3F1Si9ZTithZHZDQlIvb1JYc3Nk?=
 =?utf-8?B?OGt4cmlrckJqT2w1QUNJT1lkc2txL1psMm1laXh4bnE2V0ExV055bnN5YlV0?=
 =?utf-8?B?NG8vWU5WdzZjY1M3S0xHK0thWXBIcTllSWRaZ3dDOWtRWGhKUDhBNEVBdml5?=
 =?utf-8?B?SG1HL3FoY3plTUxJMUxZc0JYQXkvcmpFQXAwdFppVkFSRGpsR1ppQ2ttenFz?=
 =?utf-8?B?S3NJQVdnaDVUQ2lmZ0Z1L29jeGpuSktUeXBJait3SitPN1JsdUJVQ2lzSkxx?=
 =?utf-8?B?b2NZZ0JJc0NWendOZTNSZC8wUFZhZkVYVmt5bjd0SktjTS9uTVRhdEQzZDRn?=
 =?utf-8?B?d2RrUC9uVUd6TkVVeHc5bVdIZ2NRQmhLdG9WbEF0eDl2YUQ2bGtHSm9EZEZF?=
 =?utf-8?B?UmpyaGNjODB5WFZ2YW16WkUrSGEvSDBacDA1clU3bjNZTGRQUnlkRVVySnA1?=
 =?utf-8?B?aEJtRDBld1A1c2hNdWhlczJJOXJRU0lReVRBTFZOZStERk0zc29WdFNZLzE1?=
 =?utf-8?B?QnFNbmRXS042Q1dxQW9BOVh4WlpvMzYwNVdaanlobnl1SVo3NnVXbVo3VDV2?=
 =?utf-8?B?VnljZlhqeDlBSFJlcWtvK2FWR1NvWlp1R3RjS3BrQkV0L2lzaVNWVzdZajdy?=
 =?utf-8?B?SzJNMWRrZHJ4UXNwNHdyMGt3RDVsN2d5MnhPM2Z2K0tKQ293b25oN1diQkpI?=
 =?utf-8?Q?l9M3xeLbrpOcz66gIeoEaco7F?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e60289-0fd3-4a5d-5a4f-08dd5b0fe5a0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 11:29:59.3864 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MBDaoFAfbWrXOHh3Jj9T3K+EZiHUgig7s+UpIXXwKD8/tyZfyLy31JyKZ95p4/JgHFOGI/c2pmDU7UBbjPxRig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6915
Received-SPF: softfail client-ip=2a01:111:f403:2406::61f;
 envelope-from=avihaih@nvidia.com; helo=outbound.mail.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


On 04/03/2025 0:17, Maciej S. Szmigiero wrote:
> External email: Use caution opening links or attachments
>
>
> On 2.03.2025 15:48, Avihai Horon wrote:
>>
>> On 19/02/2025 22:34, Maciej S. Szmigiero wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>
>>> This property allows configuring at runtime whether to transfer the
>>
>> IIUC, in this patch it's not configurable at runtime, so let's drop 
>> "at runtime".
>
> Dropped this expression from this patch description.
>
>>> particular device state via multifd channels when live migrating that
>>> device.
>>>
>>> It defaults to AUTO, which means that VFIO device state transfer via
>>> multifd channels is attempted in configurations that otherwise 
>>> support it.
>>>
>>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>> ---
>>>   hw/vfio/migration-multifd.c   | 17 ++++++++++++++++-
>>>   hw/vfio/pci.c                 |  3 +++
>>>   include/hw/vfio/vfio-common.h |  2 ++
>>>   3 files changed, 21 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
>>> index 0cfa9d31732a..18a5ff964a37 100644
>>> --- a/hw/vfio/migration-multifd.c
>>> +++ b/hw/vfio/migration-multifd.c
>>> @@ -460,11 +460,26 @@ bool vfio_multifd_transfer_supported(void)
>>>
>>>   bool vfio_multifd_transfer_enabled(VFIODevice *vbasedev)
>>>   {
>>> -    return false;
>>> +    VFIOMigration *migration = vbasedev->migration;
>>> +
>>> +    return migration->multifd_transfer;
>>>   }
>>>
>>>   bool vfio_multifd_transfer_setup(VFIODevice *vbasedev, Error **errp)
>>>   {
>>> +    VFIOMigration *migration = vbasedev->migration;
>>> +
>>> +    /*
>>> +     * Make a copy of this setting at the start in case it is changed
>>> +     * mid-migration.
>>> +     */
>>> +    if (vbasedev->migration_multifd_transfer == ON_OFF_AUTO_AUTO) {
>>> +        migration->multifd_transfer = 
>>> vfio_multifd_transfer_supported();
>>> +    } else {
>>> +        migration->multifd_transfer =
>>> +            vbasedev->migration_multifd_transfer == ON_OFF_AUTO_ON;
>>> +    }
>>
>> Making a copy of this value is only relevant for the next patch where 
>> it's turned mutable, so let's move this code to patch #32.
>
> But we still need to handle the "AUTO" condition so it would need
> very similar code just to get reworked into the above in the next
> patch.
> I think that's just not worth code churn between patches.

Ah, I understand.
In that case, we can move only the comment "Make a copy of this setting 
..." to patch #32.

Thanks.


