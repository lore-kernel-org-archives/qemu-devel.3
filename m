Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D18AECA0ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 06:16:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1untA1-0000Fn-Lg; Mon, 18 Aug 2025 02:16:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1unt9y-0000Aj-Oq
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 02:15:58 -0400
Received: from mail-mw2nam10on2073.outbound.protection.outlook.com
 ([40.107.94.73] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1unt9v-0007KJ-R2
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 02:15:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RSSZKaWD9KVKgx5ziRbhXT0tbOolk8RRB7ANEcSkvCeDGv0AV8vE/aXNnOFXZRGDRihdKs1+tghsXrlWtPCnzKld032b4ccrog+Ftx96BkVd3qS3kmutTZh2xEktBfEOo3C8MWhjGUE0WuJBkuP2nOUCzqofjcQUEyOuMXvAYJbc9Wkgg58AUus19m0nP3Fz4a+tbC7G37tdZhMJsNodufA2/0Q8SRK8zOGTo6eA+gV0X8IkDrSkM2BcgssojVmWmHEXZXsdWT+vsirwEph/gQZCWrYeQC01O8b2OoLVNIIPTtEFpjgKezl+iifj5ZDx2SfpeCjnq1TcqyBKnzZb0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDmtJ5Si2BkQmdZ0NMZg7cYVZZoZuseL2SgdI2wofPE=;
 b=tewk2cG70o+wyzrI2UfNCoo5dIqZJcwmj7RihmZOeDXXGK38mpCuDlHiAFzN+GasycWetoSx1Jb+hCYHY08uYJVYUrGhRNKqfaIb+QSknWSCHYKk6l1O7VWsiZpISkmUCWIA3xV4467jPUCSMFBARCEzTt0eQpKv2KXWi1KFHrSNT6B0Rbdkk1dqS2lqibMjuxUd6GSPjiRsW6gXo37l/8wuUVE8fg9yXqVHuH8hbLab9ann7GSOSutGwH+mO6Pi+N28MKWz2o1L1V1qTsLqzGPO71L56Y3RD8pHi9WPVxqCwNlz6YdGyM/z+gkepN1d8K2U62cA4o4C7jiDcnfYEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDmtJ5Si2BkQmdZ0NMZg7cYVZZoZuseL2SgdI2wofPE=;
 b=fP44CU5MhtiJ5YapqXEFPIOdDqiCQmvH4p/9TqhU1Lg8IzEP6Cbx/LfjphTv8xlxh3YGpy9dbruYNeqkphHwSrYsU8Upp2x6mb0SEAyRUDWq3Tuk0OMB+4jeEYfgUkULfCk+IzExPyKaA8lDd7PMoknmCGIyXyE/11cuWHpp5VdxODyQvUbguJiCWh8S2EafHEim8vlCI87Lse7hb1KiWx17tdn7IATyqKQfCVrRp31VwQauxoAMyQxBXNZUSWhPDmzlS58JMcp5sn7pd9Jya7rasivm74ZybMtSNdiphXlIyvffjYxgBKeaT9Ey/ZjHKgmT+9+48FKhZJ2H9sfJIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by SA1PR12MB8966.namprd12.prod.outlook.com (2603:10b6:806:385::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.21; Mon, 18 Aug
 2025 06:10:49 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%7]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 06:10:49 +0000
Message-ID: <1e099ea1-7728-42e6-b78b-d8762db01aab@nvidia.com>
Date: Mon, 18 Aug 2025 09:10:43 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [Question] VFIO migration will not be aborted in a corner scenario
To: Peter Xu <peterx@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
Cc: Kunkun Jiang <jiangkunkun@huawei.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Yishai Hadas <yishaih@nvidia.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 wanghaibin.wang@huawei.com, Zenghui Yu <yuzenghui@huawei.com>,
 Fabiano Rosas <farosas@suse.de>
References: <6f64724d-7869-1283-bb75-193c7fba5576@huawei.com>
 <f6c1cff4-a0ca-436a-b8d7-3d19ce49e848@redhat.com>
 <506cab2c-35aa-4c68-ba94-b26ba1b315bc@nvidia.com>
 <c2ace9fd-e61f-4449-b41e-ef01bf8d4481@redhat.com> <aJtWmb28Gkoeno1m@x1.local>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <aJtWmb28Gkoeno1m@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0009.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::18) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|SA1PR12MB8966:EE_
X-MS-Office365-Filtering-Correlation-Id: 1938944f-06c4-4e4f-d477-08ddde1dfa07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bXlhb0dTMHhVTTRnSTVaa2lQNFdxMTV5TEtGU1lJempJbWdzWDNHVjBqaVh6?=
 =?utf-8?B?MDFKdlZ4SkFCb0lMTk95Q2ZjbENDOGxkQWNNbzVab3ozTmdCeXhDODRMOEZi?=
 =?utf-8?B?VEJYYkpQdFZtTUVodmdrMm5ra3RCUGtXSEUvUDlxU3NKSTRrZlZYdVBPNldM?=
 =?utf-8?B?NElqWWU5MUtLOXlTa0hKcENlVlFPZDdyQ0ErY042a2RDdzhTL250aGk0M3RR?=
 =?utf-8?B?bEwwYUN5cUhLMGZPd0JzYnNyTFkvT1dIRWU1V2NnQUExak5GeXB5aHM2amky?=
 =?utf-8?B?VXRFYXRMa2xsdTFHc2JFb3p1bVZ1eTE1L1Bad2J6QmJPSkZZRVFOUm01a0t5?=
 =?utf-8?B?T2hkTXpENWZVaVZBUkg0VDRydjI3RGJBeUlWNjMxME1CUFRVVnZNeFdHU2h2?=
 =?utf-8?B?WEU0clI4S0x3c0RhbTdmajRDRHdWdVR1YktVM1owc0dGU2pHK0ovNEE4YVdm?=
 =?utf-8?B?L1lhSkJJZWRRL0xJOWQ0OFp2cVdiL1R6V0JQNS9HM21Hd2M2emU5RFJzaURr?=
 =?utf-8?B?V1hBVUt3VzcxM0NrZlNDNVQ5ektCR3MrVElmZG5BSHVqVUdDMFV5WHZxbE1w?=
 =?utf-8?B?QVRrTVR1NVNBWHY0TlhiOXlUeUhiSCtGRzl4RW4vVzdHWlVKK3JLNUxRNjda?=
 =?utf-8?B?M1RFaXo4RXhDSWEyUGtNMXFlWGJXZmVFUi8yZjhSenJFNnNYdXIwczdaUFhQ?=
 =?utf-8?B?Z1J5d0h3c0ZkMnk5R2J1bWtrcjNva2NJTEpnaU1rSWV1VGI2Q1Z5VWVtbjlR?=
 =?utf-8?B?NE9NMmNzYU5sR1lqdmNYVk1KY1IvK0RwY0J2ditUdGN6M1JkM21VNFVNV0lP?=
 =?utf-8?B?a3diay9PeHBTMkJuT3VUcWJBUGpaNklNc01ibUQweUlkZS81V25wcWM3TXZT?=
 =?utf-8?B?YnBQeGRBUExzU0NYRVJtNnNpUEpSM3doZ3BRMWl0WVFTTmdzRGMzdzc4U2ZR?=
 =?utf-8?B?T2VCYUszQmdpY2FXWjZzK3FyOUNTWDFkS2xqcm02alBod1V5NkdKTTM1K3pS?=
 =?utf-8?B?TVRNbDArcURsc1dWR0Q4NVBPNFM1UVJpRVRpZVF3RTI2dkxCQVZLK3FhS0lF?=
 =?utf-8?B?ZGlqUUlpK2QvWWZ3bG5VRGdqRmJIM2lxT0o0emhPZU8vVmdTbzJ6aDgrN3cy?=
 =?utf-8?B?NGljOUtsalBRWW12aFd2ODd0OXhXY3h3TVlISzlZQzdXQi9pT3dMcGJ1MHhx?=
 =?utf-8?B?ZmdhejdNTkpUdW5GQzRuWS90WGdKWFJadDNOMU9DV09vQlM1K0pqV3prbTVp?=
 =?utf-8?B?WE4vQ0tuME5ROWk4b3MrZ2xGQWRpM0t1ejBoRW9GVTdYREtRYkg3UVJkbDlt?=
 =?utf-8?B?c3ltQjNtNlA5QVpDdjFXMDBMd1JyRmRISFMrdU9zeDR5c0UvdHR6N0Q3YllQ?=
 =?utf-8?B?YWdoWWpKMGVlczdrOVVuY3FiQ3YwdS9tWjRNVjJMOHAvNnNxazdtQkhMTG5j?=
 =?utf-8?B?RjVQL3BYbG5OVEVLTnNTVzUyMS82VzlOTnlyQzFZM0pjQkptTmQ5d3ZZZVJL?=
 =?utf-8?B?Slp1b0VZa0dUTVZ2c3RXaHdXQUUrZXhsRzZETGoxTGpEZjVmN3hzbUQ4N0Rr?=
 =?utf-8?B?SkpLQ0lkN1k2cVViUWxYWTZ4VWF1TWFNRVk2QUttVDhJcWtocjFxMFJHREo3?=
 =?utf-8?B?aWN1dEwrNHRYWmZJQlhWOVNqNnZqV1RlOEhGVXNQU0RrT3NLUzlQZDdsZk9B?=
 =?utf-8?B?Tjk1b0hqMkNmQzBlWDlxWGpyVDYyTC9WeHBEVjJicWVhakhjSzgzWk5veFlP?=
 =?utf-8?B?RGtXb3QyU0tIN2g4aTJEVGtkWU9CelFFRDhiOUNhOGFEdTRCY2U0SlRDanVa?=
 =?utf-8?Q?HuRXW98AfvEbJWJg9TRoh7UtlSV4rR9gj6eYM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFpXZ1dQdWJ5aDR4VDZLV2NuRlBsbHhTQnp3bUVKdy9EUE9Kbm9mb2lvUWxD?=
 =?utf-8?B?NVFqdjB6a1Bwc29TeXB0a0NNMjFMZWIxc0U0K0VUS2JiMFJzNWtYK01mQW5o?=
 =?utf-8?B?d0UyTlZ2RzFEZ1JjN3RMRDJXdko2S3gwcythTTNNSjNsN3lGbkJFM05sOXRB?=
 =?utf-8?B?eHQ3ME1Lc3JqSU9KbEYxNUxRaWRSK0UzQnFrZ1cyV3hudUM4VWZMTlE4REF5?=
 =?utf-8?B?YU5VZXRXcm5GbUxhQ0c4UDNQUktRY1F0cWNSQUYxMEVPQVhjaTlqYXphMHZF?=
 =?utf-8?B?MExndkowUmhMSnMvYTZWVU1xS2NoSllYNmVCSW43b1FQQjhRb2orMlpGNzJG?=
 =?utf-8?B?K1R2aVJMZ25Sc1B4a0tXWGxBUTdUWUtwQTN1SGJkNklVSEZ6Znl0NjhYMFBD?=
 =?utf-8?B?OEdac3BVQy9vZk1lOVFadzM3MjF6Zm1nNGlZOUJFSEJ4R0NHcHl5UnhNYjQ5?=
 =?utf-8?B?bnhFMFRRblZSa2xCNURzZzZ4ck9XVUtkWDZIMWwzUkhrbDJ6NHpHSkN6OU0z?=
 =?utf-8?B?N1BVaXBDaVlnMlpvRDB3WmhSNFpZL2orNitiYzJlUW8zMW1Sa2VGRXp0emUz?=
 =?utf-8?B?ZHgxUDEyL1NTRkZTalFodW9zOTMwTkVuZUVVblNrWFBjbGd2WG9Za04zTWsy?=
 =?utf-8?B?czRXbGt3aW9pbVY3ZmI0VjFMQXgzUWs1YW1LdllwbHNIUFV0QTltNWhsaDYx?=
 =?utf-8?B?TkpxcmdjRi9NTUFTVFE3ck5hU3JCZWVHRS9jN2hzeW82QXRIbVYvQk53SE4z?=
 =?utf-8?B?T21ySHp4engyUjdUL0pQdjJaZ2RhOEpvMXZ2MW9ZbVpVUWNwbnZIMHRkazVZ?=
 =?utf-8?B?Vmc1TjhxUXRXQ3h4Q0M0djlPM25mZzVsMktmeDNkWkJ4MEJnd29ieVpQMW5l?=
 =?utf-8?B?NHdxVHRJS29ZZFB3Y3I5c3B2ZFlnVWVWZVpzS3hHcGxmRHplcUNwc2lnTnIz?=
 =?utf-8?B?UzA1V3RreUNBNzk3c05EMXVPYmZoZmt0Z2hWcWY4ZDlWcUFYeTlOeXVXcmtF?=
 =?utf-8?B?cHZTUjRnZmRMY3FaN2FmWHQvMHJHb2JyU21PVkorbzAxK0ZwV0V2Qis0UHc4?=
 =?utf-8?B?VU52eGx3akhQb01mWDA2aStsaWt4dWUvYVlCa0h1S3BhRm1CaHUzcGZrSXlZ?=
 =?utf-8?B?TTBxQjdiR1d4Q25kM3FBUE44L09vdnhZR2haanFSRWI1NklEZkhxbmtLZ0lU?=
 =?utf-8?B?UW4wRWZUSXY1WU1UY1lmVmJoYW52YVczWnpUR0JnMUJTVEZTRUhBNlB3OGpP?=
 =?utf-8?B?SHBQNjhEV3NjbjZMOXdFbDlwUkJUQnNDMnNlbHZqK011aXVZeWxwSWxTZ25l?=
 =?utf-8?B?aXZlUXRPMm1KYkJMK1VxeWM2c0xzS2JEUS9KMFhGQ3RPeGY3dFlmVloyaW1P?=
 =?utf-8?B?UmRlb0RYdXhIS1lhTEFKZUsyYTF5ZzJ3ZzhCQklTTTlzTkh0aVZCMUlSOGNL?=
 =?utf-8?B?NUlWYUZZaWZJVGdsZFVqZTRyK2gybXdhUDZYMlFySUovTVNlN2pzZlZHWVJu?=
 =?utf-8?B?TFlzak1QZzJTMlZBTEFlazJrbjVzQ2pBSlI1ZU5lM0h5WS8rZlRIeWFFdFdI?=
 =?utf-8?B?KzR5Z0RSWlQ3cE9Ec0U3UEJTVkMwQXFwcTArQ05rRkNKdmd5cGRpbW5TcDdB?=
 =?utf-8?B?Nm1sM1dsZCtYb2RmWklNRTg1RTZrdTN0YnNtSmVlaE9VanRDQ0JQazlHLzI5?=
 =?utf-8?B?eVZBVi90MGd0T3V0OTBHZ0p5aHRBQXI4eVNudlZEL0Fpc055clBXc0J0K0N1?=
 =?utf-8?B?blk3OWorNWdEQzdCbFdrSkE1QmdkRTQ5SjhuQ3JFRTBDeG4vTUJZaVNodDlJ?=
 =?utf-8?B?RG9JalBxbkd1cjNDUXZmTGJYeHRNN0JSNThkaUNWamwxQUgwN1JVbHpoa2JH?=
 =?utf-8?B?Nml5c1NIRmsvWUljNlRDU3JjUy9HcnVYcE9ZZ3RLc0toVE5VT2t1ZzgxcURi?=
 =?utf-8?B?dTRHRFNXUzk0MVJrRmZYL1IyQW1PdERaaDI3c0UycmdTRDVzRWtidzd6ZWxp?=
 =?utf-8?B?M2pRbS90T0RKK0pTK052N2pDRE91bFFWbkxXK0ZkMDZQQlg4S3EyODdmTnI2?=
 =?utf-8?B?SU5rQ2V4R09weUMxYzlCczNnQVBjTDJQSEhDZjloZDVNTGozMkdhemkxYzYy?=
 =?utf-8?Q?ygNRkJwBvXeRJjibV3esv680j?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1938944f-06c4-4e4f-d477-08ddde1dfa07
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 06:10:49.0099 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q0F5OCZ5o/fRHA4fI2hGBC505Nu9HD8DiHXgCXy7TWUOxxMaczPZKtxhY0LGTcZ54cbUvGXJQztb6HsuRnFl6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8966
Received-SPF: permerror client-ip=40.107.94.73;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1.376, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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


On 12/08/2025 17:58, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Tue, Aug 12, 2025 at 04:34:34PM +0200, Cédric Le Goater wrote:
>> +peter
>> +fabiano
>>
>> On 8/12/25 16:08, Avihai Horon wrote:
>>> On 11/08/2025 19:34, Cédric Le Goater wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> Hello,
>>>>
>>>> + Avihai
>>>>
>>>> On 8/11/25 18:02, Kunkun Jiang wrote:
>>>>> Hi all,
>>>>>
>>>>> While testing VFIO migration, I encountered an corner scenario case:
>>>>> VFIO migration will not be aborted when the vfio device of dst-vm fails to transition from RESUMING to RUNNING state in vfio_vmstate_change.
>>>>>
>>>>> I saw the comments in the vfio_vmstate_change but I don't understand why no action is taken for this situation.
>>>> There is error handling in vfio_vmstate_change() :
>>>>
>>>>          /*
>>>>           * Migration should be aborted in this case, but vm_state_notify()
>>>>           * currently does not support reporting failures.
>>>>           */
>>>>          migration_file_set_error(ret, local_err);
>>> Hmm, I think this only sets the error on src. On dst we don't have MigrationState->to_dst_file, so we end up just reporting the error.
>>> But even if we did set it, no one is checking if there is a migration error after vm_start() is called in process_incoming_migration_bh().
>>>
>>>>> Allowing the live migration process to continue could cause unrecoverable damage to the VM.
>>> What do you mean by unrecoverable damage to the VM?
>>> If RESUMING->RUNNING transition fails, would a VFIO reset recover the device and allow the VM to continue operation with damage limited only to the VFIO device?
>>>
>>>>> In this case, can we directly exit the dst-vm? Through the return-path mechanism, the src-vm can continue to run.
>>>>>
>>>>> Looking forward to your reply.
>>> The straightforward solution, as you suggested, is to exit dst upon error in RESUMING->RUNNING transition and notify about it to src through the return-path.
>>> However, I am not sure if failing the migration after vm_start() on dst is a bit late (as we start vCPUs and do migration_block_activate, etc.).
>>>
>>> But I can think of another way to solve this, hopefully simpler.
>>> According to VFIO migration uAPI [1]:
>>>    * RESUMING -> STOP
>>>    *   Leaving RESUMING terminates a data transfer session and indicates the
>>>    *   device should complete processing of the data delivered by write(). The
>>>    *   kernel migration driver should complete the incorporation of data written
>>>    *   to the data transfer FD into the device internal state and perform
>>>    *   final validity and consistency checking of the new device state. If the
>>>    *   user provided data is found to be incomplete, inconsistent, or otherwise
>>>    *   invalid, the migration driver must fail the SET_STATE ioctl and
>>>    *   optionally go to the ERROR state as described below.
>>>
>>> So, IIUC, we can add an explicit RESUMING->STOP transition [2] after the device config is loaded (which is the last data the device is expected to receive).
>>> If this transition fails, it means something was wrong with migration, and we can send src an error msg via return-path (and not continue to vm_start()).
>>>
>>> Maybe this approach is less complicated than the first one, and it will also work if src VM was paused prior migration.
>>> I already tested some POC and it seems to be working (at least with an artificial error i injected in RESUMING->STOP transition).
>>> Kunkun, can you apply the following diff [3] and check if this solves the issue?
>>>
>>> And in general, what do you think? Should we go with this approach or do you have other ideas?
>>>
>>> Thanks.
>>>
>>> [1] https://elixir.bootlin.com/linux/v6.16/source/include/uapi/linux/vfio.h#L1099
>>> [2] Today RESUMING->STOP is done implicitly by the VFIO driver as part of RESUMING->RUNNING transition.
>>> [3]
>>>
>>> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
>>> index e4785031a7..66f8461f02 100644
>>> --- a/hw/vfio/migration-multifd.c
>>> +++ b/hw/vfio/migration-multifd.c
>>> @@ -267,6 +267,12 @@ static bool vfio_load_bufs_thread_load_config(VFIODevice *vbasedev,
>>>        ret = vfio_load_device_config_state(f_in, vbasedev);
>>>        bql_unlock();
>>>
>>> +    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOP,
>>> +                                   VFIO_DEVICE_STATE_ERROR, errp);
>>> +    if (ret) {
>>> +        return false;
>>> +    }
>>> +
>>>        if (ret < 0) {
>>>            error_setg(errp, "%s: vfio_load_device_config_state() failed: %d",
>>>                       vbasedev->name, ret);
>>>
>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>> index 4c06e3db93..a707d17a5b 100644
>>> --- a/hw/vfio/migration.c
>>> +++ b/hw/vfio/migration.c
>>> @@ -737,6 +737,8 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
>>>            switch (data) {
>>>            case VFIO_MIG_FLAG_DEV_CONFIG_STATE:
>>>            {
>>> +            Error *local_err = NULL;
>>> +
>>>                if (vfio_multifd_transfer_enabled(vbasedev)) {
>>>                    error_report("%s: got DEV_CONFIG_STATE in main migration "
>>>                                 "channel but doing multifd transfer",
>>> @@ -744,7 +746,19 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
>>>                    return -EINVAL;
>>>                }
>>>
>>> -            return vfio_load_device_config_state(f, opaque);
>>> +            ret = vfio_load_device_config_state(f, opaque);
>>> +            if (ret) {
>>> +                return ret;
>>> +            }
>>> +
>>> +            ret = vfio_migration_set_state_or_reset(
>>> +                vbasedev, VFIO_DEVICE_STATE_STOP, &local_err);
>>> +            if (ret) {
>>> +                error_report_err(local_err);
>>> +                return ret;
>>> +            }
>>> +
>>> +            return 0;
>>>            }
>>>            case VFIO_MIG_FLAG_DEV_SETUP_STATE:
>>>            {
>>>
>>> diff --git a/migration/migration.c b/migration/migration.c
>>> index 10c216d25d..fd498c864d 100644
>>> --- a/migration/migration.c
>>> +++ b/migration/migration.c
>>> @@ -91,6 +91,7 @@ enum mig_rp_message_type {
>>>        MIG_RP_MSG_RECV_BITMAP,  /* send recved_bitmap back to source */
>>>        MIG_RP_MSG_RESUME_ACK,   /* tell source that we are ready to resume */
>>>        MIG_RP_MSG_SWITCHOVER_ACK, /* Tell source it's OK to do switchover */
>>> +    MIG_RP_MSG_ERROR, /* Tell source that destination encountered an error */
>>>
>>>        MIG_RP_MSG_MAX
>>>    };
>>> @@ -884,6 +885,11 @@ process_incoming_migration_co(void *opaque)
>>>        ret = qemu_loadvm_state(mis->from_src_file);
>>>        mis->loadvm_co = NULL;
>>>
>>> +    if (ret) {
>>> +        migrate_send_rp_error(mis);
>>> +        error_report("SENT RP ERROR");
>>> +    }
>>> +
>>>    trace_vmstate_downtime_checkpoint("dst-precopy-loadvm-completed");
>>>
>>>        ps = postcopy_state_get();
>>> @@ -1126,6 +1132,11 @@ bool migration_has_all_channels(void)
>>>        return true;
>>>    }
>>> +int migrate_send_rp_error(MigrationIncomingState *mis)
>>> +{
>>> +    return migrate_send_rp_message(mis, MIG_RP_MSG_ERROR, 0, NULL);
>>> +}
>>> +
>>>    int migrate_send_rp_switchover_ack(MigrationIncomingState *mis)
>>>    {
>>>        return migrate_send_rp_message(mis, MIG_RP_MSG_SWITCHOVER_ACK, 0, NULL);
>>> @@ -2614,6 +2625,10 @@ static void *source_return_path_thread(void *opaque)
>>>                trace_source_return_path_thread_switchover_acked();
>>>                break;
>>>
>>> +        case MIG_RP_MSG_ERROR:
>>> +            error_setg(&err, "DST indicated error");
>>> +            goto out;
> If this is only a boolean, we can reuse RP_SHUT.  Likely we could pass in
> an error to migration_incoming_state_destroy():
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 42a2a6e8f2..2ebba7838a 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -441,7 +441,7 @@ void migration_incoming_transport_cleanup(MigrationIncomingState *mis)
>       }
>   }
>
> -void migration_incoming_state_destroy(void)
> +void migration_incoming_state_destroy(bool has_error)
>   {
>       struct MigrationIncomingState *mis = migration_incoming_get_current();
>
> @@ -466,8 +466,11 @@ void migration_incoming_state_destroy(void)
>       qemu_loadvm_state_cleanup(mis);
>
>       if (mis->to_src_file) {
> -        /* Tell source that we are done */
> -        migrate_send_rp_shut(mis, qemu_file_get_error(mis->from_src_file) != 0);
> +        /* Tell source whether load succeeded */
> +        if (!has_error) {
> +            has_error = qemu_file_get_error(mis->from_src_file) != 0;
> +        }
> +        migrate_send_rp_shut(mis, has_error);
>           qemu_fclose(mis->to_src_file);
>           mis->to_src_file = NULL;
>       }
>
> Maybe it'll even work as late as process_incoming_migration_bh(), where
> vm_start() could fail - right now it couldn't, but if there'll be an error
> message reported upward then logically it can also set has_error=1 for the
> RP_SHUT message.  Src QEMU relies on RP_SHUT message and retval=0 to quit
> src QEMU, otherwise QEMU should fail the migration and restart VM on src.

Ah, nice! I didn't notice RP_SHUT can take an error value.

Will try that, thanks!

>
>>> +
>>>            default:
>>>                break;
>>>            }
>>> diff --git a/migration/migration.h b/migration/migration.h
>>> index 01329bf824..f11ff7a199 100644
>>> --- a/migration/migration.h
>>> +++ b/migration/migration.h
>>> @@ -553,6 +553,7 @@ void migrate_send_rp_recv_bitmap(MigrationIncomingState *mis,
>>>                                     char *block_name);
>>>    void migrate_send_rp_resume_ack(MigrationIncomingState *mis, uint32_t value);
>>>    int migrate_send_rp_switchover_ack(MigrationIncomingState *mis);
>>> +int migrate_send_rp_error(MigrationIncomingState *mis);
>>>
>>>    void dirty_bitmap_mig_before_vm_start(void);
>>>    void dirty_bitmap_mig_cancel_outgoing(void);
>>>
>>>> I suggest you open an issue on :
>>>>
>>>>    https://gitlab.com/qemu-project/qemu/-/issues/
>>>>
>>>> with a detailed description of your environment :
>>>>
>>>>    Host HW, Host OS, QEMU version, QEMU command line, Guest OS, etc.
>>>>
>>>> A template is provided when a new issue is created.
>>>>
>>>>
>>>> Thanks,
>>>>
>>>> C.
>>>>
>>>>
>>>>
> --
> Peter Xu
>

