Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD46DEF4ECD
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 11:29:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9i8S-0006mw-4N; Mon, 06 Apr 2026 07:28:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1w9i8Q-0006mN-L9
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 07:28:50 -0400
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1w9i8P-0006fM-2x
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 07:28:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RdMXn+FCF+69pLMTVTwAiFbk45Cau9DQ9nf9AyUfLFONKYeN0wjH7apRuMW5yYe4xva/ZqmcYdPA+LOEOKjty6VG88l7k4AAsc5SSOG3PLomPYeW0m8rcJRxnZcNWKCUB0NHhDckZphv+DJ3KMiMHDSBeoyHYsZRbuPJTLHaqeSd9aWWMEpT4sj8lKgzb8vd9KXMDfydxqULWJwCAddajzigi98dVffKdS7TXVHed1nRsw3dA5JO0id/JlT4QfhH59n91uKf0UvfSbR2KbeH5vgljHuqUk3aERg5kYQ0aTspwU9dbL4zl5dHCP9jUx1ROfif4KM8qjGrsk2wMdbL1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eWURtWt4Z2pnSqf9XoOvnnsRcLFBLIkW5goxv6/G5r4=;
 b=hKZcykIyxUNPcad82IjCDpWujZlQl3lMYKy0u1kwPCA36qPD8Cf6SUlI4t8u0m47Ys+DQbiMElyKIypeo12VKrJiqTj25Zn1BHn1DSTQ0cjblbok3YHhk0uNqkmwCF9xN/6Ff2RmbjGHkrk6bo557+hh+jyYG65J+oHRz0aLdE+eELKlqbps3pFH81JrWLQz1imCf1gdQaBYjFXfnEPjW936aT4foMeh/dIidvcKoDWrUR+6J9oxpS9EMsAPoqyQxCX0ov0+z4p10WH2P8E1c3/VtsQJYFLl/LJkCIZAeKsnoxid1JzVFZb0C6O0PqCN3eDgrOpH6A98kuW5/mQxgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWURtWt4Z2pnSqf9XoOvnnsRcLFBLIkW5goxv6/G5r4=;
 b=ZNgQcXKR3li0ixVu2Qc7s5MRd6SYJ75RIApB+qCyZCjBG2s0pnFXHZB50VFqb14RMzPNlfXwGyFMRUICExwgwmlI2wHAX6Rb7nUPd5etl7fi6u9fUDs+tf4QmaCTX0jMf0ZCU6SoiQoNbFlZVXa30QWd1+LV8t8OdjicUlBOhvOL+4mbxLs03p08lT9HI6kzz3Dd394g9UPEt+EIhMC/MlbOwMtAbEIbBlfhydnCHj09aYEUyt47hTJJRlRKy/d4Vfa0HTzoRhVbS5MCwDehSvjvsZcfEOfoo/eIGjki31FzFoVxjFdL/y0Xv+1M/t8zeJUGacGYTMlY3WF3YJbqhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by SJ0PR12MB5633.namprd12.prod.outlook.com (2603:10b6:a03:428::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 6 Apr
 2026 11:28:43 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%5]) with mapi id 15.20.9769.018; Mon, 6 Apr 2026
 11:28:43 +0000
Message-ID: <9ec06730-5da9-4c5a-b4fc-11df995e68c0@nvidia.com>
Date: Mon, 6 Apr 2026 14:28:38 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 04/12] vfio/migration: Cache stop size in VFIOMigration
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, Alex Williamson
 <alex@shazbot.org>, Yishai Hadas <yishaih@nvidia.com>,
 Fabiano Rosas <farosas@suse.de>, Pranav Tyagi <prtyagi@redhat.com>,
 Zhiyi Guo <zhguo@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20260319231302.123135-1-peterx@redhat.com>
 <20260319231302.123135-5-peterx@redhat.com>
 <894ad48a-6779-41f7-bf9f-08008c8e4bde@nvidia.com> <ac2C7b21mdR8phDl@x1.local>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <ac2C7b21mdR8phDl@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::12) To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|SJ0PR12MB5633:EE_
X-MS-Office365-Filtering-Correlation-Id: f169263d-e1a0-4159-02a3-08de93cfa8bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: Fq8uRi+R1XEawEZth/472uooXLbNH6YjyxCxorHTyo32cuigvzB27hfjbbyvbaFW7ImWASS7t1DYS6fKknJG0CrkiEDke0moJjDdfs2z0os0HYk8zhjrUp+PsmqdyVq9ANS1U6Dy0tZKcPUcfDHknTNWYR7nlKNvYy+3GZCkPGj+YpbMzLyvP00Pp8w877FcIrSsuZfu+bD69WfgTi3kJnCGdcT25dDUv3/B6ellla9LmPv0FXy/zoqT4Wg6dmrO+uov8P/2SJDqrNBCMMt/XxsP1oPt5nNe5a33nKBS8j7SqOSS1jQHEqb22lkfQeSD6p1UqqvEB+1GUsjCM/VYmMgtR3fV8Fknz/utXUm9bp3vJEe7jhfgz91Ku0Tax5OC4czl1JKU7lC17tprIy6LCMxNXcLtCV2FL1OMBWDWx8z9jywSOnoEajfV/SAnhLQn7A8covJfHdw2A/ScbALaUgCa4+2WwZ2OtAktbdvjc+lKFwgEN3BcSot/GAf+jEHS5pA8+QgqxUZoEgyVXFrfSfBZhbkSfUsGADhlcZlT+k1Sz1rb5a25dOBcLDA4Ud4wgXkUOSrOO440FBLXPDSotfIe0yEweS6xov6ZiHRtx1TcXkbliTF7n6ILwRuggDl9FUgWsJjo+MKYthWVLBOlid3atNghQnQX32WWbS7QOQ1UyCskGRcJ8Q9UNwzhRUp5psFaZzbL/VgHgsIjstyqo3fq4QINLMsCaemMaJSPPvY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7416014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGdnaCtoV2pKYUI1eXp6cEt3aXJJMHN2dlRRWXpxTkRrVmVIWHk3MEVzNWhX?=
 =?utf-8?B?Wktzd3AzYnFkS21jYzlOc0dXckY3R0luV25mWUs3Z01OV3ZlOFQ5ZmNuYzRM?=
 =?utf-8?B?aU94SVRZVTRhZXNlSG1oSFhsVGU1KyswaWJoaXFGZlhoZ0pya1FWMytzSDhH?=
 =?utf-8?B?V3NUS2xxRlA4Mk5kM0RDcnBXempmNnJRZE5UaUlmSzU4U2c4QWx4NzBiWFBV?=
 =?utf-8?B?eU9NdUN4L21oT3FmVkd4TGc5NmNxRnMxeTFxb201ZW1BMWNqc29Fd0E5K3FN?=
 =?utf-8?B?cU9SSmhBdEk2c2ZGdkcrd2tFUEF0OFJNVmIwVWtVSGdHeTFjUjlTZjhYSkl5?=
 =?utf-8?B?NU5qNk1TdjFHUGI0Nmg4Zk5TWXRhTFFLRHVGbmdOQjZadmxnY3gxb1VaR0Ny?=
 =?utf-8?B?enhia1FVSmNDd2gxdko2SS9JaXFiOGFldEtKb1VtcEltZXJXaURWVVlCdlFa?=
 =?utf-8?B?TWFVNzZGSjFhcVcrVi9lVCtHTkpKMGU4RExQVzlJdGFjdXhicHlPMDljRXBq?=
 =?utf-8?B?RkV4OVZiaDVxUkhXMjJvbHdUUDZOU3dTSUNqNUo5NXFzMzF6c3FtZjk1aWZo?=
 =?utf-8?B?MG15QVJGU1RuVTJkY1dzNjlyZUl0d3AyM1I4djZzb25iRS9nemg5OXR3d2Mw?=
 =?utf-8?B?YkhhZFdTMTF0eWJ3TEpWMk1DWldud2wwd2JSd1lVa3NlYVBFSDAvbUFUTzJL?=
 =?utf-8?B?OExHcXRXdDBoVTlPWHk3d0wyd29lV00rV0dteXNYRFpCSjZ2WTM5SlZFeWNK?=
 =?utf-8?B?bEdINHlkUGZGNDdEODVOcGVYdjI0MXkvUm5xNXpPanRUeHh6TjRpWXc4VCtY?=
 =?utf-8?B?bnlKbUo4Mkl3dS9lSGhtMm8wYms0K1hhRWxhMlVjOTlhL1l0K2dlanBjY1ZQ?=
 =?utf-8?B?eVVHbU9OclU3K2djUm5RbFg2SkU5QXZGQjc5Qm5jMG5TdFdOUzQweTdiQnhS?=
 =?utf-8?B?ZnNJU2p4bWhsdHF5eWttbzBiZ0pwNzNLYmx6aUk2RkQ0U1Q0Q0h4RmVYbTU0?=
 =?utf-8?B?NzFGaTVhaDB1cWxxR3FPWGxrV0Nib3U0am83MHkzMnNVbDYybXcrY3BWbjVX?=
 =?utf-8?B?Z3ZpY0hsOXZCelVOcC9oSUpKVjUxZkdrcEd4N08wd05XMGNRclk5dDJFWmor?=
 =?utf-8?B?OUlIOFZwdXJ4emlNa1VZWmV4WlNtZ0cwL01SK2JqaFZWRGwyOXF1aGZDeElX?=
 =?utf-8?B?b0lMNUdvNFU3TERGT2h2WUg4STYxM0dLUlU1cUJ1NzRnYmEzMGR1cmFxMTUw?=
 =?utf-8?B?dTZ2Q2wwYnQyOU45UGxwTzVHNXJ5YUcyemtXaTFlSGNQUXptSVZ2ZllKMU91?=
 =?utf-8?B?aWtKbTRsL3JoOEFwaE51bmpMOTh2clY5ZjZDQjh2T2VzQUhpaHpzM2ZnSDhl?=
 =?utf-8?B?citRWmttb2g5Z1R3eW9IdlJmYS92WFdrMnhXVzRlWEZ0ZVV1TVducWNaUy9H?=
 =?utf-8?B?K3JUc3VTdnhyUStFVzRlNWJvTWhVakRnUHEvSXpwdThST21vMFBVdDI2U0NW?=
 =?utf-8?B?Y2ZnQXpLN01tazBrM2lFOHl4YVlYaGxXQ2daM3Ric0RqK1Q0Q1l2TVZmWFBu?=
 =?utf-8?B?V0FUOGdyZG5TOGh2MS9oUDJUM1VmcS9JK1FqWmVmNjBFWGRmcnNTdTVIRi9w?=
 =?utf-8?B?ZHJ0MWJHOW0rcU5rL0RMTkwyTGxwZmI5ZWEzMnZISmhTTXBnMmhkQnR1eGZj?=
 =?utf-8?B?eE9xVlRDNlQ1Y0k2LzQzM3N0Nk40NUsxR25seUJWMFVuK3UwVEdvNUd3SGpj?=
 =?utf-8?B?R3FSc1VIcjRiVkZDeThWZXJBT2MyeFVWY01oaVhuVEhPTTc3Z2hoS1kvaElR?=
 =?utf-8?B?UkF2OEU5NG1oeDJVaVo4WWZzVnJuZGhVVUNDVDhCOEtESnRQQjhQOFBic1hU?=
 =?utf-8?B?KzJMUTJhN1hZQkxCZUdTM2lzU0ZxZnQrUnJCTEN4ZHM4TlhyTEthQlUybnp5?=
 =?utf-8?B?RURJcHN3SkY2WWtjWVhUbGdJcW9oOVpENXVnbWZwc2dKRDdoMEVyOW9lYWRL?=
 =?utf-8?B?UnhhbzdGYnZheXBjL3RZRE9xaHlMclM5bTlscXFPMHUvdVdqL013bGhaRUFz?=
 =?utf-8?B?eFRWbmtjMFNEUEdpbkFkRFVJQ3NMQmVWN1dVY29sM29Wekd0K3hoUmxLUTQ3?=
 =?utf-8?B?cDQwUkpOMkpZM1BqRnZZcm5ndm1lbGxUNTdrc0N5enBvSmFUdlVxOElmQVVN?=
 =?utf-8?B?Z29peFpGU2xXcEVzZmQ2VkpPc2ZhWGVGVWVETk1QK1o5SHA4MTJzWTE3VTFx?=
 =?utf-8?B?V2V2bjBXcm5ldVJMdWNlWURFRWIyaElJdFpqRlRyYnFCdWxibWZLN1pjeW9u?=
 =?utf-8?B?c3BDdUpXL1pyZDh2YlpNQW5rRG1sV2Y4QU1MakZNL2pzUVhMSnBudz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f169263d-e1a0-4159-02a3-08de93cfa8bc
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 11:28:43.3691 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pufBKn7yrrOq1RZvepUy57G8qiC1YrpcS3Y+PGK50ZgVtqQ33FUsdoGKYdRBZxiMq/Kxd/NfxHf4MVSXGrRNGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5633
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=avihaih@nvidia.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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


On 4/1/2026 11:41 PM, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Wed, Mar 25, 2026 at 04:15:45PM +0200, Avihai Horon wrote:
>>> @@ -415,6 +426,9 @@ static void vfio_update_estimated_pending_data(VFIOMigration *migration,
>>>            return;
>>>        }
>>>
>>> +    /* The total size remaining requires separate accounting */
>>> +    migration->stopcopy_size -= data_size;
>> stopcopy_size is also an estimation, so I think it's safer to have:
>>
>>    migration->stopcopy_size -= MIN(migration->stopcopy_size, data_size);
> I believe this is very relevant of the question in the previous patch, on
> whether reported value can be shrinked.  In this case, it's about
> VFIO_DEVICE_FEATURE_MIG_DATA_SIZE instead.  We can discuss both ioctls there.
>
> I hope it's clear to you on what I wanted to do with this series, which is
> to have counters cached in QEMU so as to align the estimate/exact reports.
> The counters should (in my hope) be 100% accurate reflecting the current
> status of VFIO device, not necessarily the latest.

Yes, I understand, but the counters are not 100% accurate (even for the 
current status) - both as defined by the uAPI and in reality. However, 
they are still good enough for the estimate/exact reports.
VFIO devices are a bit different than RAM, where everything is very 
precise and you can know the exact remaining size and remaining size can 
only grow.

Thanks.


