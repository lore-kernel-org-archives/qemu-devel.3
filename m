Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA52CD5BC7
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 13:46:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smCoN-0003Z4-CK; Thu, 05 Sep 2024 09:46:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1smCoG-0003Xf-Th
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 09:46:04 -0400
Received: from mail-dm6nam12on20628.outbound.protection.outlook.com
 ([2a01:111:f403:2417::628]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1smCoD-0002H1-L3
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 09:46:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OIkMy//S4X+d1PjHEhUO+VnEgNd+mKuuf57uJW0MIL+ds8MQGUB0h7tFY90eZ+Yqj2Faw4RGCCrDgzKtbQb8BvjTkPnanIqMoznBb6PJfXyLS6FohCV5j01PnsO0mtYFPuzHp4XDVRr0+FOsEaHXg6++8r1g0YVg4SfgNx5iLJYpNklwIvJz6KIXnBrVRJS4cVoNGsChMKsRrQfV94gR7keV76NYXlCK5zZTYYpeDJ+63nkKIjSxu36v35JkNpNOsRlehCgyxZ13zy90kpGbbDafgk0c6Sh4xx0QJegwjggTM0mDCeGWZz+MNjRQ4NQ4KniLrSiHHAVAE3iE32aQsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/N1y24CfsCgf7WEJWKVDJngHzis5ulgPIYnnpEzK0E=;
 b=PPEsCfFMxT7KVVlOMXKtl33Q4TOFbp4VJP0eQn6h6uVzRopp5HevApSqw6IfQVi0QsPJGrzPKchVH4SNdEqKq0kNfH8RIBT+i5bso9z2C1cW3OuDbHqOgeISUjoJBYxYKepYY3Q//jr9Xdc+OmyDhYhRImlqk2UwSTBpXPnPAYk3fj/iYZ6iMzyDUKVty5nruw8MYGKfJNO+cS8T4qAEYiU5prJO0U1neznJolEH5tBpLGkLA28aFDp8BXKtqQzipj1v+ZxeIyxRtkxMCSsCUDDBgdywoylr7JuMN0dLQBlW+zpbpGbQjD3Ez0wNZeLj8isRO+bol74UT5hzcE+zlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/N1y24CfsCgf7WEJWKVDJngHzis5ulgPIYnnpEzK0E=;
 b=C2eeJtdH42hcY0rqUw+8dlHOY2jn0CTzzF+o/e8oFREt6PqSERCzk2xDKgcRUNZKWaL76eCdMxnP15yLjIfkAqR3cjd8G8mVyx5uuHONBM2zPOLsOdqaJ/XMH7zON8kscVy/kn4zEqxJe8PiJb566Etd6qCnxcCzxyNktKTEkDVCQhqprBkoYMoG3OwWrAkUjUUk2ZKHJTCkFoZo44inWW05dRpQjz0TKF386x76c9q5V6imRdlJcahcErSURElyOP4ybvW+n1IDHTUUJwxPkyu6GkM+oXHZUq85oJdQbXZwWe75WwDxCq27Az0QPWdTijDVfk/54JGbO3fmTdqxJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by SA3PR12MB9177.namprd12.prod.outlook.com (2603:10b6:806:39d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 13:45:56 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%5]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 13:45:55 +0000
Message-ID: <9f9f0408-866d-4dc8-8c8e-80c3cfdd190a@nvidia.com>
Date: Thu, 5 Sep 2024 16:45:48 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/17] migration: Add
 save_live_complete_precopy_{begin,end} handlers
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
 <afe0bc649007593edaa77f5f3923acb733a24c6a.1724701542.git.maciej.szmigiero@oracle.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <afe0bc649007593edaa77f5f3923acb733a24c6a.1724701542.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0014.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::26) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|SA3PR12MB9177:EE_
X-MS-Office365-Filtering-Correlation-Id: a6743313-38a0-4e14-84f3-08dccdb110e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dXppOThwYzlMVTJwSi9jU2Yvd2hWYU9ra3RxR3BTRnd3cWhFeXN0SitSMVE1?=
 =?utf-8?B?bjNTMUtFNUVNcmlmYkVaSGNhdFdrQXRZNjU3eVVRMWZsUUFEbFdxc1lnb1Bl?=
 =?utf-8?B?WDJxM09aVVc2emd3VmZ0dVg0ZGJqRGptZTdOSm1FbFJiUjFaQmQxK05tUEww?=
 =?utf-8?B?MDhsMkUwOGpqbWl0QnB2N2dLeUR4VjdmVnR4ZXJlVGsyWkpZR1hTQmlpNDBE?=
 =?utf-8?B?U1hvWFh1MTlZNlh4N1o2WmZpcmZHaDdZblVReW51UzUwQU5HdnhOK0ZGTFBo?=
 =?utf-8?B?RWhKSWcyN0g5YlJqdERoYVBmVUdtZGxwdGZ5SWZTVGIrWHU4MHhWdkpFZW5Q?=
 =?utf-8?B?eVpTZkhzeFVEODNObnFrWlZZRS9hOXFBblZ5NWliSHRaQ2VjSGFnZS9OdG5P?=
 =?utf-8?B?SlYrek9WWkFEdWdWK1JNdUJ0RUhNQzdSTnRBaGVRL0hNUU1aS3BSbzhZZjJx?=
 =?utf-8?B?d1lzZGpUV0xZVzBRY1RzdDJXZ2xUbkVIRGUyZ2ZwQm1YZ2o4S0lLc3pSZ3NE?=
 =?utf-8?B?QVkrR3RDeHRoSVRFdkIxcHNYQWJ1N0FCU1ZKOHJvckt1ZVUreXU0UEFGL1hN?=
 =?utf-8?B?bkVjYWRYYWJBeTJQcGhGM2FhUi9IMWNuU20rbkhQTFFLMW96Nzk1TGpnRFpH?=
 =?utf-8?B?aFBGSWllOGNTSjQ0Tzk1QytRTzU3c0I5M1VHdEltcWM4NFQxS3JzK1MvOXYz?=
 =?utf-8?B?ZjdUQmxFOUpjUkhWM1V4cGI5dEhvdGJUR0V5dmVQTTg3TkNRVHFFTWNJTUJj?=
 =?utf-8?B?ckxqM0V0SndiNUx0aUtHZWhWVktKTkx3NGsyU3cvWDJtbVpQQWZPcDVVdXlF?=
 =?utf-8?B?SzhOcjlvaTdCbGNhamNQZG15MVFkem1OWjdBRXpqd0FYRVBvUHBxYzUvWjJk?=
 =?utf-8?B?WDNzbEk1T3Q1QXBmQmRWM25WY29CMi9QS2g4RkpRTzdTVkJMUjk5UFhHOTZ5?=
 =?utf-8?B?MDZhdjZhUTBOYlBzL2wzc2w0eHlMc2x1L2pObytpRVQ2TGtWM2VZVEM3Zk4y?=
 =?utf-8?B?Q2dxNDRlWEdvVFU4U1VVZGlMaHowa3NWMWdjYys4MnB2NW1IRTJ4YUs2T01Z?=
 =?utf-8?B?ckxEaTNCK2J5bEx1bUFjZ3ZmMTNyckd5bXlvQnZHRkZCbldvT1JOdUN5aVFj?=
 =?utf-8?B?eEN3THdweVkwRG51RkxpN3hIaXk0MjNxOUE5VDh2dHRscFI2bmJUdTBQRW9r?=
 =?utf-8?B?aFBSYWZmNk9ZdTFJWmVZendESVFPZnFpcXJKOWFMbUtyeEl0bHQ4dGVLcGdT?=
 =?utf-8?B?UFpYMEwxd21uQkw0dUFpVC85UjBtUmlqQmVrL2VYbmpzNFVYdXZBanhJUkJ4?=
 =?utf-8?B?OTV1eUYzdlZjQ2JLL2VrM2RZVjhYV2xlZHgwbGo2dzRKVUJnYXd6WE43RlFq?=
 =?utf-8?B?UVF1TU9xNXRZQWZRNGJkUFpZMXBHYk1kb0V5K0lLRG5nRmRkUUhTYTJyYUpt?=
 =?utf-8?B?WVkzM3UwZXRWeGJaY1dxdWU3b29CV2tJajJMSkdEWktYMlFNc2F4b0tWVFJ2?=
 =?utf-8?B?T0xJQjZLR3d5SGhZY3lLTXhreEN4MVlYMGdNVU8ybE9XMzRWcUN0OU1jdGpk?=
 =?utf-8?B?dGd4aXJmaUNaQTBITHJ4VlZkQi9EQnkyMmtFR2NWdjYwcklmaGJ4MnJlZld5?=
 =?utf-8?B?U1FUdnpUbFNrc21xUFA2bnFYV1N0REs3dncrZEJNWEF4dkw2SmlTdG5OVnJi?=
 =?utf-8?B?eUFJWWdDaUJmcXZjQUVMUXRSRkpCUlVya3pSMUhMdWxkOFNUMThuMDhmd0pR?=
 =?utf-8?B?NUNVU3lKQmVpSEpvejg3Tm5WZ0VpdTJ1VUM5YjRyWWp2VTFJVUJ0Wm9aVmZP?=
 =?utf-8?B?WndYd1BNRmZaK1BaWFVaZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWhhUUkrVHpSOUFTQUFXUmVzemJRc21HN2pKOHFDcng5NXBwbko5Y25PemlI?=
 =?utf-8?B?Nzh0RjZFeldlWHRYZGFYQWEyVlUzQU5KQU1TVTliVkozbi9yTm45NDVPQXZj?=
 =?utf-8?B?T1NBQk1tTTlPNEptN3FrUGNqRjEvOXpvSVEvSWI3Yy9zc3RLY2tGUkNMSksz?=
 =?utf-8?B?NVdwQk5za1M4dkdFRGJRTjJOWkVnV1k1cDRSWXRRelV1clVPTjU5Q0hCOGwz?=
 =?utf-8?B?VGs2K3RqMVhvNGFJd1ZPcDlEbWsxMjRzbElKTmUrZHhtTzlzZUZyc2NlVzFy?=
 =?utf-8?B?OEp3Z3kxUGxxQmlGZ2dUMjQxVi85Y2lhcCt3cDBqNkhLSHE4cDBKYnRSYkdW?=
 =?utf-8?B?Q2ZKaHAxS1RtOWxyZ2N3U3dVeVpBeGk4b293Z1NnR1kzNVVGMDNBU2VhSndV?=
 =?utf-8?B?VE96QURNN3A3aVNiTUZsMWl2dFNtTjZDdkNEaTRVSHYwZ2JLQnZZZnMzdDJQ?=
 =?utf-8?B?elNvRldGdWVjSTJEbnVNRzZSRGovQjhjZWZkQyt5ejZYanprbjh3RUhkWS9h?=
 =?utf-8?B?Wm1wUHFSOVJTRGhHUjh2K3pReEQvL3I3WlNjZDlzR1NUcFFoWUludS9HQ0xp?=
 =?utf-8?B?MU1KUk8vUkxUb001d2dkc2pGVWdBTlplVWpmSGE5Y3N0SjNIcytoSDcrNmZx?=
 =?utf-8?B?cVBXZ1crSVh1a255Q3AxRWdJMGxOSEtteXNEcC9QTlQwWDVobVkrVlpDdmdy?=
 =?utf-8?B?UTZPUDBRTzdLMUxydTRrY0Qyckh0Y2ZGVVNJYzkvUWl3QjlDQ25zSWVyWFZD?=
 =?utf-8?B?d3cyM0xRZDNNVWhYS01ZVHFvSHVHL0pzanNGL05uQmhSL3ZjNmVtMG5CZmRp?=
 =?utf-8?B?dUtpZXAybXozRHdvU3BsVm1zYkRpZmtRREZhZGMrM3JZaVFjUWlkQk56R2tw?=
 =?utf-8?B?TXZldDI5ZFBaSUxBV0d4TitZTWRCZENWbjZpNEEvU0NxbHlHdFBLb3hpcFIw?=
 =?utf-8?B?ZWRiY2JKdC81R0pGZEIxL0JzSVE0Wm95enFFV2ZKWnM1MmlXSnA3SE5XTlRk?=
 =?utf-8?B?bXprdHE5NTVYQjVHZVdIREk3YmFDeFhadUdjd0lTSWllbFpkOHUya0xDb1Qz?=
 =?utf-8?B?UGdmZGhtQ3lIbys5RlFQTGpBQ2FBcGsrYStrWnpMN0N5eXVENGRtdHZrM1FP?=
 =?utf-8?B?R2JZZnFSYTAyMWljUjAvMnV1YUloamttTFRwR3VTenVLaU5WVFlVSHRCVmhw?=
 =?utf-8?B?bENiZk5QQVFoblNBd0QrQTBTRjhOMFhpQy9PelpheW40UVZQUHFPYWt4bzdk?=
 =?utf-8?B?enhyaklVcGNuV3Y2aEVmZzg2akRvdGtWdGlDQVNUTk5xUjRTbWc5dDV5WEh2?=
 =?utf-8?B?ancwNHBvd0xidWcvSjNmdW9BaHlaelV6SkFCYWhUbUt3U3lBRlZFMWg1MDUz?=
 =?utf-8?B?RzJIbFpKTGsvWnZjcGtKTmI1M29lajYxNFNoYkVyN1krMit2QTJYT2FnTjFC?=
 =?utf-8?B?NzEyTXFvMXhBY2dPSkE4NEdqR2tZbHhxNFI4QXdvZXorNXl4RlAzbCtETDQ4?=
 =?utf-8?B?OGFxcHNLcG9mTStLVlFkVXdxYmVNRWdFWWluYWtxSDZBRlFtRUF4SXJPbGNT?=
 =?utf-8?B?K0ZhT0VHQlhKcVowUS9BTEc5S2xRUU1iK3BsekRmc0dTM1UyYmIwZ0xscjAw?=
 =?utf-8?B?Rm9jalpETG1CcmVuNjBQR1BJTmoyU09IcVR5ZElTbnd3QWpURW5Md3g1UFBl?=
 =?utf-8?B?dGRXMFJMZFZpdDNLL3FadXhha0hrYUE2MXpCcnNTUzJoOHhVVFhsUnFmTks1?=
 =?utf-8?B?UktVU0lzV3kwUVJCYWV3VmkyUW9LL0xPdmhUQ3JuRFZlMHp2T1ZURzJtRFpB?=
 =?utf-8?B?NkxQQkNlUmJZY3R5UmdwNXZzZitPOG01OUZNOE1lOVRYd1czMVhaanVoaUk5?=
 =?utf-8?B?ZGU4cEk3OGUyVWJHMnREa3JadXFSRW9XUW1sTHFCaFJ2MUp3ZkR4SHZuWE1B?=
 =?utf-8?B?dEZXR1VmSGxMbUZJUEpWN3V1a1k3OUp3UXFNV2VZR2NDbmlkRktEeGF0RTJu?=
 =?utf-8?B?YmZzY2M0dDcreFYrVlhubU5tdDh2U0RRVTVrZm8rOSs1WXE4ZUxBRmZCZ0V3?=
 =?utf-8?B?b09SaXlrVFVPWWNLTmFLM1BGZ2x6bnF2V0IvNzBoWXRWemVQVkJjVzllNENz?=
 =?utf-8?Q?YtOGwndJVJSdWUZlWRcy/o/Vr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6743313-38a0-4e14-84f3-08dccdb110e5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 13:45:55.8363 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nvQJqm1MGuf8Bijf731OroMp+05/b/rE8r0OqLrau710VzQb8NgfiogEjel3QIS9S3SKUhro49Ryi5ycusIsqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9177
Received-SPF: softfail client-ip=2a01:111:f403:2417::628;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


On 27/08/2024 20:54, Maciej S. Szmigiero wrote:
> External email: Use caution opening links or attachments
>
>
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>
> These SaveVMHandlers help device provide its own asynchronous
> transmission of the remaining data at the end of a precopy phase.
>
> In this use case the save_live_complete_precopy_begin handler might
> be used to mark the stream boundary before proceeding with asynchronous
> transmission of the remaining data while the
> save_live_complete_precopy_end handler might be used to mark the
> stream boundary after performing the asynchronous transmission.
>
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>   include/migration/register.h | 36 ++++++++++++++++++++++++++++++++++++
>   migration/savevm.c           | 35 +++++++++++++++++++++++++++++++++++
>   2 files changed, 71 insertions(+)
>
> diff --git a/include/migration/register.h b/include/migration/register.h
> index f60e797894e5..9de123252edf 100644
> --- a/include/migration/register.h
> +++ b/include/migration/register.h
> @@ -103,6 +103,42 @@ typedef struct SaveVMHandlers {
>        */
>       int (*save_live_complete_precopy)(QEMUFile *f, void *opaque);
>
> +    /**
> +     * @save_live_complete_precopy_begin
> +     *
> +     * Called at the end of a precopy phase, before all
> +     * @save_live_complete_precopy handlers and before launching
> +     * all @save_live_complete_precopy_thread threads.
> +     * The handler might, for example, mark the stream boundary before
> +     * proceeding with asynchronous transmission of the remaining data via
> +     * @save_live_complete_precopy_thread.
> +     * When postcopy is enabled, devices that support postcopy will skip this step.
> +     *
> +     * @f: QEMUFile where the handler can synchronously send data before returning
> +     * @idstr: this device section idstr
> +     * @instance_id: this device section instance_id
> +     * @opaque: data pointer passed to register_savevm_live()
> +     *
> +     * Returns zero to indicate success and negative for error
> +     */
> +    int (*save_live_complete_precopy_begin)(QEMUFile *f,
> +                                            char *idstr, uint32_t instance_id,
> +                                            void *opaque);
> +    /**
> +     * @save_live_complete_precopy_end
> +     *
> +     * Called at the end of a precopy phase, after @save_live_complete_precopy
> +     * handlers and after all @save_live_complete_precopy_thread threads have
> +     * finished. When postcopy is enabled, devices that support postcopy will
> +     * skip this step.
> +     *
> +     * @f: QEMUFile where the handler can synchronously send data before returning
> +     * @opaque: data pointer passed to register_savevm_live()
> +     *
> +     * Returns zero to indicate success and negative for error
> +     */
> +    int (*save_live_complete_precopy_end)(QEMUFile *f, void *opaque);

Is this handler necessary now that migration core is responsible for the 
threads and joins them? I don't see VFIO implementing it later on.

Thanks.

> +
>       /* This runs both outside and inside the BQL.  */
>
>       /**
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 6bb404b9c86f..d43acbbf20cf 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1496,6 +1496,27 @@ int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy)
>       SaveStateEntry *se;
>       int ret;
>
> +    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> +        if (!se->ops || (in_postcopy && se->ops->has_postcopy &&
> +             se->ops->has_postcopy(se->opaque)) ||
> +            !se->ops->save_live_complete_precopy_begin) {
> +            continue;
> +        }
> +
> +        save_section_header(f, se, QEMU_VM_SECTION_END);
> +
> +        ret = se->ops->save_live_complete_precopy_begin(f,
> +                                                        se->idstr, se->instance_id,
> +                                                        se->opaque);
> +
> +        save_section_footer(f, se);
> +
> +        if (ret < 0) {
> +            qemu_file_set_error(f, ret);
> +            return -1;
> +        }
> +    }
> +
>       QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>           if (!se->ops ||
>               (in_postcopy && se->ops->has_postcopy &&
> @@ -1527,6 +1548,20 @@ int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy)
>                                       end_ts_each - start_ts_each);
>       }
>
> +    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> +        if (!se->ops || (in_postcopy && se->ops->has_postcopy &&
> +             se->ops->has_postcopy(se->opaque)) ||
> +            !se->ops->save_live_complete_precopy_end) {
> +            continue;
> +        }
> +
> +        ret = se->ops->save_live_complete_precopy_end(f, se->opaque);
> +        if (ret < 0) {
> +            qemu_file_set_error(f, ret);
> +            return -1;
> +        }
> +    }
> +
>       trace_vmstate_downtime_checkpoint("src-iterable-saved");
>
>       return 0;

