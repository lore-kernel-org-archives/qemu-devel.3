Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7702C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 08:23:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trYPu-0004Tv-1y; Mon, 10 Mar 2025 04:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1trYPs-0004TG-8p
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 04:23:16 -0400
Received: from mail-bn8nam12on2063.outbound.protection.outlook.com
 ([40.107.237.63] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1trYPp-0004nQ-0c
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 04:23:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I9VCAf0wdvT2IcdqCvNsQFnnPHtBb5GA8g6YpjI97NKg5KwidtY4E2AX6g3THC0PaauOMi3i/QWlQZggkVJ63U7g/nzzo/yA8MpKFVi35eto0IosHybEF9bQNjGMqw5ohbzrTdA9hzNhdk8i90y1IUyiIQxb0y/mlHRPhQpMLpQ9n0xTe1nmV3vneYlJKJ6/7HNBqbVjuyavW+LSNJULXZrc/zytACmBupOFjlHAyNPUMV5V9ClVZ2zHNyzfFfuNJUqJKuiz+CoElmImEZgyUZRvN/j/pbzUET1mkTHsXa44E5zHVVG0K5qls4FAVs2UhcB8NnAAThFtUYAUG/NF5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EE4bTSymec1gYG9GZXama1ldrJ2XaTL3BDFNw4gCSdY=;
 b=cV7uFpdypXeto1HoFp1X+0fSbvv0K0oV3kDURcXrsm955yq7wUnJY28THCl4qCy51B/mwuzj8M9ZBYwVBqSQ+3ZtzGu5PTwE9DmWnoxsgdPU2HBFMmsLvdQXLBKC8pF7ZBtXnrEign9WPY++iX5yFMv4hd5C8uxHVi4ZJYJk0jkhEGfSAbxvHm4Q4UPgHgm3lqhAbup8QfZvGYvtIRpTeeuRJmsJ/d/xyiexuJnzUJtLnhxKQCJSoZIThX8raKcT6wvllZSSV1kwYTUvNvi51Xm+huCbkRV406M7CLdtrZYMOm0jrc7M6bqSQI0UlvH6E9d5eVXxYLqoa8CKTUdmWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EE4bTSymec1gYG9GZXama1ldrJ2XaTL3BDFNw4gCSdY=;
 b=DzKOEWxQSQdIUhHrR8o63hj4qSE1WOF6Es5H/9MQxM/xajFHOkWt4lj7mHuW1OGc8EEtwkpGzOivNJqtuiN/CEOVnDO/L7riPuJ0QO/LsZlH6HhHylurygtXsTZA2cP2Oi9sgxBwfhCQSFk7il6x0HuOH3KCeJZsxucSaAIpk+iDt3KIljVEOUD6BDc7fyXl568a39m3LWbMiUGSO+D8Nka6PfLxGRH5x7BqLnOwqOzLPhAaocoz3IU3jnvYcMTk8BxOnAJov4bwlE02fcM6LKUivRQwGE7pWvTknfRUvr+ieIAyWnX1cvLyjg4DL0LJ0gxopqUtqWfHL/n5zIRLKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 08:18:05 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%5]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 08:18:04 +0000
Message-ID: <aaad9f89-56c8-4df7-bb36-fb212b39ade4@nvidia.com>
Date: Mon, 10 Mar 2025 10:17:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] vfio/migration: Use BE byte order for device state
 wire packets
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1741124640.git.maciej.szmigiero@oracle.com>
 <f0bf02377f18f3cf6b8942528b3b5bce97fb6ab7.1741344976.git.maciej.szmigiero@oracle.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <f0bf02377f18f3cf6b8942528b3b5bce97fb6ab7.1741344976.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0361.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::17) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|DS7PR12MB6071:EE_
X-MS-Office365-Filtering-Correlation-Id: 96cbbe8b-6bea-4f1a-724b-08dd5fac14bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MkV4Umo5Y2lYay9WeFlabnliSUw1d2JhWkkrOEd6RGxYZ0w2L2RNM3BJQ1RO?=
 =?utf-8?B?ck8zbTArZEhNeEE3VWF4OTdEUWxNV2dFR3djNEhlRkE0OWx6YUt2czJrVmFP?=
 =?utf-8?B?OGVybVRYTGt5R1MydnRQWURERStvVThJVFdYZEJNdHFYSFBpYUVvU2RCbUdT?=
 =?utf-8?B?T04wdHNORktFQ3J1bmxnNVZza1dtSTB5ZjNFVEl4ZU9zS0lHV2MzeW9Va1Rh?=
 =?utf-8?B?NGdDdEkxM1FCMWxoNnRPcVVOK2NOTHpGV2ZaK0xlalhpWHFPVmc4Qy9TeEMz?=
 =?utf-8?B?VGpFNkdyYlhZdUVSSldBekJ6eWlzL2VCUyt4R3Q5WVA4RE5MclpWMTVZWWtj?=
 =?utf-8?B?eEc1NjUyRFAzUjlyMlhCYUMzVEFSVFhTZHMyeXNpQWNnOGt2L2lHL3hCMStR?=
 =?utf-8?B?ZW1JVm1iNkJsamtrcUJKOUNPSlNzUzM5Vm5JNTk5LzhJSWRCZXlSdEpwMzRj?=
 =?utf-8?B?TXloaGREcURZcWZsVWExVUVJdCszNE50dEhwdW8wMXBLclFkdG1QbXVvNllG?=
 =?utf-8?B?VGZhVUFacVNzakxxK2lqdk1RV2MwdVlPNWsvUEl6eUxwd1BFSEtzVHFzS052?=
 =?utf-8?B?NGl1U0JQOGJNL2s2Mi9SVTMyMWhabTdYY29tWUhxUjJPNHc5TXgvZ2ZEK044?=
 =?utf-8?B?d1FsWmJkQlZvMjd4dk8xNnN3TGtMd2dack5VOStEMC9hRE53Rmw5R3BRY05R?=
 =?utf-8?B?eFJUS0lJSDJmYUovV1NtTlFlK1I0VFpxNGR3TndVMlhmMytMZE5UNnhPVlFX?=
 =?utf-8?B?KzZsSitqS2gwZHI0YStRV1djK1o3aTR6TWRydlhtQmhkM3psMFk5WjJWckpN?=
 =?utf-8?B?K1dPRlljM2RCSzRPRUc3dHl4YzcwWkVSUUJNemdudnhqTGpIUi9sVDczdXlU?=
 =?utf-8?B?SEU5ZXNYUkNCWURzeDRuSWtYbDdtck9XcDRmbzBxOGMybE5HMG4vditKVEJ2?=
 =?utf-8?B?TGdWcGcvcDlPeDZKVHF0VW9ZdHBCZjZlWTJtN2orYTN5MU9YdjMwN29NS29Q?=
 =?utf-8?B?c253NXRQMXpLekRyenRmQ3ZkWE1IYnh1ZWZIekREbU1Ib2EvVVBJSDJ6UENa?=
 =?utf-8?B?NSt1SHRpV1RmUVZFQjFDV2MrUlVJMnlPSTVLU29FZm5WQVo0anVRWlY0Yk1u?=
 =?utf-8?B?U296NjVETnA4YytLRE9XZVJxUmFCOWZhV2l4R2tmbnlKeFNnVnVQdHNLcE1F?=
 =?utf-8?B?d09EbFMzZmUvRWUvWnhNaVNGS1dqT0ZqZW55cnlWcDRYZXpXeFFJWEUwNUJp?=
 =?utf-8?B?NjJvMy9VOEhRUWdEYy91bStRc3AxRitLTFpXSlJYUXNEVS9kMVA4UFViV05C?=
 =?utf-8?B?azc2c3UyY1FEdEU5SGpEWFJqQzRIZG1xdERGMUZMZjVuTFMrZnVFeHc4ams3?=
 =?utf-8?B?NVI1U3ZVU0tsQ0Z5UmtXQlIvN3drUXRxSUV4aEZXbGQzV3Z3MEVldG16Nkha?=
 =?utf-8?B?L253cE1wTzJVc1Uza01wUzJkNDVsQmJQWG0veGdlbC9MQS8xNE9sdjl1SGtO?=
 =?utf-8?B?YWpSNzMxVjdyNmdzV2ltMkQzWHlzQlEwNzRwTlhCZ3hzdmZQL0czdDNGcTZX?=
 =?utf-8?B?cnYxYlp4WHNFeENzWDgySGkzVUpDSzEweVM5ZXB0emZrUmFpM2JOKzFCS3Zx?=
 =?utf-8?B?V3dXY2srcktzYldBSEZjWFRyU2daMmRjZXlEWVNOc1JxcmxpQUVVeE9xd3Zq?=
 =?utf-8?B?RFhFZUtUcmViTnVqWU9kSStQQ0F2T0tFMGpNWVVqZHJPUUlGclFKN0x0a2l2?=
 =?utf-8?B?TEwzWHNrTjQ1bUllUGtlU2JQN3ZxUlkrbGZGdjh6Wk5KQ0QrelY0VHRRcEUy?=
 =?utf-8?B?KytNT3h6U0FCb3pCVlU2c2IyL2NkUG9OVWpDT0JNSDM1bDc2OExVdmFhQytq?=
 =?utf-8?Q?gM5GtDes/YJs5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2pEK3U0cDQ0blpubmJNSXgrdDZXVHBrTUxZaUxIOVY2ZURJb0IrQjdYOUdw?=
 =?utf-8?B?bGprTjMxbW1oaVlveStGWllEMUFqUWh2ZlpOR2VsR3U1dStiYzNNeXN6Qkdr?=
 =?utf-8?B?S0RMenduR01MVzcvQmxyeU5uNGx2aDRwdVUwMXlhL2t1OGE5emR1aWZOMy81?=
 =?utf-8?B?TFBLZXcwNkc3MXIyb3N5WEpQTFBGZGZXbnNwM29GS3pqMU14SXROV0wzS3hL?=
 =?utf-8?B?SUR0VzJZV1JCazVlTTZxeUpHZHkwZXh2VWI2aFVPMnFnNWMzczZ4cWVENGd4?=
 =?utf-8?B?c1dHY0hneUR1WlY2b2JtbGlhcGRULzFZSjRGdXpYNHVvSVJDSjJNd3pZM0ZH?=
 =?utf-8?B?MlZYT2NYQVR2THp5RFdiSFVLMTFwL05uZTkvZXduSzlaOXRvZlpGaXJScEQx?=
 =?utf-8?B?MTUvZzdhMEdLNDNraHFRZGg2dms2SnpDcHNHK3NLdHNlbTRhczVheDBpSjJY?=
 =?utf-8?B?a2J3d2YySnA2RjgyTW9tZTV2UUdreW5Ra2RvSXZ4RCs2Mi9GaWFLdTZaNkpH?=
 =?utf-8?B?TlY0dUo3eEdhaGdCWFBJU0pjVW9GWXZTRjZwcUp4bFc4aGpIQXNtLzlHbjVO?=
 =?utf-8?B?eDNrTkhEOVlycDBFVXVvUE5ZbUtlRUpKa0tTUFFLQmhRSk42eExVQktCRnpm?=
 =?utf-8?B?YU16UkdFK0EwZ1BxVkFMMSs1TnlCYzNOL1FWMUNXdE1wNVc4aW5leTI0V1dW?=
 =?utf-8?B?OUNieXNQbFYyZk5KY3U5RFpEVVJaQmNxZk1weHdOblBkaW0yams1SDRjSXdh?=
 =?utf-8?B?aVlocm8yNEJpTUVRSjVNSzNna3UyaHRCaGwzWDlWTzhoTXNkY3d2eEJhR0M3?=
 =?utf-8?B?K3Z1VGdkVkgwLy81ZVY0Y25tS3ZpRWNiMlJpSWJBaUNjMVAvbThpZzZUdWF3?=
 =?utf-8?B?M2J5R1Y0cnVQQkZmbENlUmUzMWtzNUZkZGdxUU8zVE4zSXNoYitOREVWd1NN?=
 =?utf-8?B?UEJUa1dUMXRJQjI1amtlTSsrSWp1emNLYVhRZmhxS2Y5bGRubGx6UlJuVkFt?=
 =?utf-8?B?cG42eEk0OUhzTGFiMFlXNlYvUk1BdEdrdFIxTnNQb1cveFRjVzRWQjBnT1U5?=
 =?utf-8?B?WjQxSEg3N3poQXMxVk43aDB4Wi9IMlBRZDNXSFpNMGo4WVZyYktpUnNyVWYr?=
 =?utf-8?B?eEx1YVNBRUE2ZUk4NXdIZGtybk1CRmVpS2I4VENqWFhscWlkRzBHY1lGQ2JF?=
 =?utf-8?B?Y24vUjdpc2gzTmwrM1k1VmZ2ZnlkYTc3UHIzY0tBMXR6TXhnVjg1VVNzdEQw?=
 =?utf-8?B?V0RmSDJCMGNVbktpb0hvTU5UcE9xdERqTGdhWjNiZ04ycWhRc1loeXZpbm1n?=
 =?utf-8?B?S3BISE14NGtabG1zL0lxYmF3bHQ2a0V6dWJyR05HU0p1MWd3MkhpRXZwMkhM?=
 =?utf-8?B?b2pJbGFOVWtjRnhWbHhuTjVyVW9Gd3hFMlErQmF2bmFSMjhCdUFOUmwrNW1r?=
 =?utf-8?B?L1J2cjVDOFBRT0c2NkpYVHR6S1V5YUhkU1FWQW0xSTVEYlo5MjRvWVoxd3pB?=
 =?utf-8?B?TVZBdE1rVVpRZ1p0TExoK0M3Ri85ZUo5UUVUWGk5a2s2a29mQm1kQk1ENFRr?=
 =?utf-8?B?aXJUR2RvV203V3ZYYkJWZ2NSTWwxSmlxQkdUSTBHZFpGYnJIRDUyeGVtcWZ3?=
 =?utf-8?B?a2F4Y0psdDc5L3lLNzFPdmpxZWF5RTBJTnp3d0FWN2taM3drL1lreTVtM3Z2?=
 =?utf-8?B?YzIrQWxTazBQODRSSnVYbkpxdnAyeXBpaTI4MTN3a0ZPRm80bDdTRlNMZ0sv?=
 =?utf-8?B?aDdBSDV0OVc1WHF4ZlN0T05Bd1gyaTRHRnZEUjhRU2tLVHdQaWV4cmJUSUg5?=
 =?utf-8?B?bWkzZG5yMSs1V0VZR1dhV253d3RNVTFQUStWb1AycENHdlEvWU9zbndGWCsz?=
 =?utf-8?B?eTdaMTFhdnFDZ0V2Wm0rVTl5N1lvbHBjRzJrNkh1MmJNWlh4alM1cytpaWxK?=
 =?utf-8?B?bk44eDg0QjJzclBUclRJUndWSy81a29OV044LzdLMjd0SUQwMWZHZXJDQTQv?=
 =?utf-8?B?RVliUUlZeWdQN0NudDlTa01YTC9weHNtUkJncittaUVOTzZxNGM1Wkg1bXNn?=
 =?utf-8?B?d3JLNXk2aWRSZ2dRTjJsaGpNZTEwSzExZ0c0OHBFbFk1UFFNemtTd05aZzNl?=
 =?utf-8?Q?orIH1tbp1pVBz/wwAV7xeKEnX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96cbbe8b-6bea-4f1a-724b-08dd5fac14bf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 08:18:04.5927 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +tMFQvANWnTf6Q0C2J9HwCHHzx3HY6HW1hCUVg8U1/54aXn46E6iufsRMLxPjcWBcoUP4QNSQAFpeZf080CESg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6071
Received-SPF: softfail client-ip=40.107.237.63;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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


On 07/03/2025 12:57, Maciej S. Szmigiero wrote:
> External email: Use caution opening links or attachments
>
>
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>
> Wire data commonly use BE byte order (including in the existing migration
> protocol), use it also for for VFIO device state packets.

Nit: should we add a sentence about the motivation? Something like:

This will allow VFIO multifd device state transfer between hosts with 
different endianness.
Although currently there is no such use case, it's good to have it now 
for completeness.

>
> Fixes: 3228d311ab18 ("vfio/migration: Multifd device state transfer support - received buffers queuing")
> Fixes: 6d644baef203 ("vfio/migration: Multifd device state transfer support - send side")
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>

Reviewed-by: Avihai Horon <avihaih@nvidia.com>

Thanks.

> ---
>   hw/vfio/migration-multifd.c | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
> index a9d41b9f1cb1..e816461e1652 100644
> --- a/hw/vfio/migration-multifd.c
> +++ b/hw/vfio/migration-multifd.c
> @@ -13,6 +13,7 @@
>   #include "hw/vfio/vfio-common.h"
>   #include "migration/misc.h"
>   #include "qapi/error.h"
> +#include "qemu/bswap.h"
>   #include "qemu/error-report.h"
>   #include "qemu/lockable.h"
>   #include "qemu/main-loop.h"
> @@ -208,12 +209,16 @@ bool vfio_multifd_load_state_buffer(void *opaque, char *data, size_t data_size,
>           return false;
>       }
>
> +    packet->version = be32_to_cpu(packet->version);
>       if (packet->version != VFIO_DEVICE_STATE_PACKET_VER_CURRENT) {
>           error_setg(errp, "%s: packet has unknown version %" PRIu32,
>                      vbasedev->name, packet->version);
>           return false;
>       }
>
> +    packet->idx = be32_to_cpu(packet->idx);
> +    packet->flags = be32_to_cpu(packet->flags);
> +
>       if (packet->idx == UINT32_MAX) {
>           error_setg(errp, "%s: packet index is invalid", vbasedev->name);
>           return false;
> @@ -682,9 +687,9 @@ vfio_save_complete_precopy_thread_config_state(VFIODevice *vbasedev,
>
>       packet_len = sizeof(*packet) + bioc->usage;
>       packet = g_malloc0(packet_len);
> -    packet->version = VFIO_DEVICE_STATE_PACKET_VER_CURRENT;
> -    packet->idx = idx;
> -    packet->flags = VFIO_DEVICE_STATE_CONFIG_STATE;
> +    packet->version = cpu_to_be32(VFIO_DEVICE_STATE_PACKET_VER_CURRENT);
> +    packet->idx = cpu_to_be32(idx);
> +    packet->flags = cpu_to_be32(VFIO_DEVICE_STATE_CONFIG_STATE);
>       memcpy(&packet->data, bioc->data, bioc->usage);
>
>       if (!multifd_queue_device_state(idstr, instance_id,
> @@ -734,7 +739,7 @@ vfio_multifd_save_complete_precopy_thread(SaveLiveCompletePrecopyThreadData *d,
>       }
>
>       packet = g_malloc0(sizeof(*packet) + migration->data_buffer_size);
> -    packet->version = VFIO_DEVICE_STATE_PACKET_VER_CURRENT;
> +    packet->version = cpu_to_be32(VFIO_DEVICE_STATE_PACKET_VER_CURRENT);
>
>       for (idx = 0; ; idx++) {
>           ssize_t data_size;
> @@ -755,7 +760,7 @@ vfio_multifd_save_complete_precopy_thread(SaveLiveCompletePrecopyThreadData *d,
>               break;
>           }
>
> -        packet->idx = idx;
> +        packet->idx = cpu_to_be32(idx);
>           packet_size = sizeof(*packet) + data_size;
>
>           if (!multifd_queue_device_state(d->idstr, d->instance_id,

