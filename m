Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6929CCD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 12:09:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOwlR-0003Bc-2k; Mon, 18 May 2026 08:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wOwlJ-0003AL-OP
 for qemu-devel@nongnu.org; Mon, 18 May 2026 08:07:59 -0400
Received: from mail-westus3azon11010023.outbound.protection.outlook.com
 ([52.101.201.23] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wOwlF-0006mO-9G
 for qemu-devel@nongnu.org; Mon, 18 May 2026 08:07:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iTOuw2ra0AhLzThvHyiOLQFe6u54dJLrv6AyGgAlfNHrMVDVbzYBIFvLDciKwuJG4tGmYYdCoEAu2LmSa+v/nGEsOMsCEerCUyVEiDjz+I6MdNmKskmAgMTFHvbDjgQgBfqHklxBkbNyNp0VWaiXiVTRejfodS9839w4/KZpl25NESY4IFGool2mpekEcawXB7jDDELOtODNkazXRII4Jt+v6bf+MgrZYdX2KzbwkovXEgfNwLgSkSzLU8E5/2a6Zh8bRk/8wfVsLUjfNl5BGeZSKDaKKNQ+Pv+mBlsFQmHklRaej7o8y21jHgByLWJMPMhFB+Z7U5gYiNrXR6w9iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=63X5yDDzRUer2Sgd2x2yaQFHq9mQv+K6tAXvhpz0wHc=;
 b=nIMYJOM3DNK+rNpYY7OHELhQT3rtCRlOOTZDxnTeoZ9c4p3SYceB/Ft5Ojq3mrim8sAWut8OLyq13+p6DbnfT8BlcOs4ExmL4EWa8XY+1bX8qgnT5tpodVYfcQQdu0VB25c2sZJIcodwqCik9h/QlV0+MnRlRrTcoxxGPri23T78Iuq+IoLceT5rAfjAXUm0peXkoksoXz8CJmsU+lHEH6ITPz6JPxk+AFYSQP28zVD+yd4Wj4wLNVQqtdbAt+U8GhGJX77FerHIxH3kGzvSm5Oe3c/41rJHpHoXfoPyWbCsJTYd2laU7cWsa5fY7BhttvReon79Ve+43Y3VBWEDgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63X5yDDzRUer2Sgd2x2yaQFHq9mQv+K6tAXvhpz0wHc=;
 b=rRQGc6Zhvoql1WmiySfl6TabT6HY7dL4/mgJVCnnJxWNLwQe0NqfRi2dLkscg0Mv2e83qG6X/cck4h7QRm2WGO5IJ06mCF9GA+u2YT10qnwlUNBHKZeaJtwaHErIfYf5KxzVYXIspK4xMAWXtznduh5vJzOBV+VkesXCABdWbs34Hd2DuR9FiWcXM/7Xici/U7ka62YIM97UxhIsWGu79DJ+2JbkcB2zr7MOeg4th5yFAHo3uTBBb1Ha/dWGYGSRtcX3qOFr/ziKd9soPIs3NgBbjufTVIRFm5eRD1N9X9CajRG4AjTvQyRSv3dty2kwb7DCCWHvsn8XhjjRLrowgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by SJ5PPF183341E5B.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::98c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Mon, 18 May
 2026 12:02:35 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%7]) with mapi id 15.20.9846.016; Mon, 18 May 2026
 12:02:35 +0000
Message-ID: <0b724082-63b9-44c6-b9f9-d697af0ff54f@nvidia.com>
Date: Mon, 18 May 2026 15:02:30 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/14] migration: Propagate errors in
 migration_completion_precopy()
To: Peter Xu <peterx@redhat.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>
References: <20260505081423.28326-1-avihaih@nvidia.com>
 <20260505081423.28326-4-avihaih@nvidia.com>
 <c439b516-b8f2-49de-907c-9dfa2edd9e2e@redhat.com>
 <f3031406-7146-4045-bc5e-720fa4bf69a7@nvidia.com> <agc5u6udcw4gRxQp@x1.local>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <agc5u6udcw4gRxQp@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0156.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::10) To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|SJ5PPF183341E5B:EE_
X-MS-Office365-Filtering-Correlation-Id: a6b3cbac-ab99-4c57-a91c-08deb4d55978
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|18002099003|56012099003|22082099003|10063799003|11063799003|4143699003;
X-Microsoft-Antispam-Message-Info: DxIFETxGfUm+hLUMR3p/SJFlJTocqT9pFdl7+jSsQ1x9zpQAkLSNlyBR/w34/rpfMHpezzasUv9HUjV2zOU1+cRwCnHT8F5xGGH8DdJ1mUDuWOo8HlNsBMcQ+4zyyPtucxm7oZPSHPvikUP31I2MzxwaZBD2iaAQifAl9IuIoEWYX1Um9AZl1H/iP4qxn+yvtYedPQSbOFiU8lGXr1Kbhdd1rLTCAH/BhZ3GeHuS8VqOkr8JDjWi1cqcSDGj+tKAHubsWwB72Jkrr5Rm3u/QNGuBkHJ6GmmuMkYlF9zUydv8Myrj+6mO2cooyRieptnxSQKYrF+Vqdw1D4EKpq11IwBvhLfBNOEqbFjfYrB25yvEbT5/gSTVAbRnS5bM4VgibFqm93H0vQ5Yq8D71hN7l05v0+x4jTTdrs19h6fuiOImj2b4KwZlSOX12WU093yaI2Kt9fQTzfLq8wyqx4yxHDovOqhNNyDs5yNu/VyEtk9+zRn583iW2YoUhKUK7x4BCiwjcZHm6K7+0ggrp8za4FxFEteeGBxd9qfUKEoFek2s+TU/HprV03iNm8JrD64VSyqC4lFWGvHbYLFSPfMZ6TKCsFSyjhtO2pcoT/zZi1MuWb59Thw6sSXJc8YfASGt3t+LvPqd4RAYOKM83di8bI7XXljJtM+U3s7M7R5WoVzwcCOJm/yd0cX/YoN1LdGN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(56012099003)(22082099003)(10063799003)(11063799003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmE1MTY5NDBiVkI3VS9Jck9QQ2xvQ3dJd1grMC9XaGdRQlFDbDJLaWhmdExQ?=
 =?utf-8?B?K0ludjFNRDZLUmRNODVIUkUwVzkreWM1cmxJeHRjNmtmWEw3Y3BvWUNtSmZ1?=
 =?utf-8?B?bFJobG9NSTFZRXNNbUdSN2dMMDE2bERWa1Y0Z1AzaVNQa2dGemg2YVcwZm9J?=
 =?utf-8?B?eVFSOXcyTTQrWW8xNVpGc3NVckR0MHczWHVsZnVyR2ZDSGZYcGplMFVDMGRu?=
 =?utf-8?B?dFNtdzA4VThLa3B5eENDYVIydmlBMTczVnRkdlpTSnA5enYxTnorWEtkbmhM?=
 =?utf-8?B?TzJrdk5PbS93elhtVnA1Wk8vMlhzTS8vbUx3QUhGakd3NElpbDA0YytzNFV0?=
 =?utf-8?B?VWN1bU13TzRFUFVXRVVVY1E5eGhSWTFVcUd5d2FXRHBudjQxZjBoWXVDVE5P?=
 =?utf-8?B?cEU2Vitod1l2RGw5K1ZWUUhkT2Zsb21XazdZOHcyUksyTWlpeWZld0Jtdklk?=
 =?utf-8?B?MkdjbS93cDVrNTNqQ2hpdlozS2orZU42L041VWs3clJ2VnFWSXAwOE9icGZz?=
 =?utf-8?B?L0dRQ285QnpGWDRic3krUEwzTkFCTXhiM0J4TjdFTU4vU2hheHI0T3FVTko2?=
 =?utf-8?B?MGN1NmpUSmpVR014Z3Jncmg1UGU3WXJlNmpJbGJnZmtZcFVFUjY4S1hZYzEw?=
 =?utf-8?B?ZVdqNGYxNnZMb29IVnY3VGxsTDhhV0dpMXN3ZjQvOGhMdnhtZndQNkwzRFNv?=
 =?utf-8?B?aVkycFpUZENhRUNiVS8xQ0ZlWTF5MCs1UFczT1lndzRMcnE1cDVCVXR3b2JZ?=
 =?utf-8?B?L2xzTlUwM1hlQkNhaVM1eWU0R0JxVGRQRSt5L09mOUsvZVUvS0xrVFhnOEFC?=
 =?utf-8?B?cVA1eldWamw2ZkNWY1IwRFpKVHFvdFF4UEVtSWhmcHBDSy9DM1Z5Y1pnOWw2?=
 =?utf-8?B?MVJaMlM0NnVoSmhXRFFMdDh0QmQxVHZOY1hZdHBoQzd2TU1qNnFKL0NlMmNP?=
 =?utf-8?B?VTV1OHdwaVJvT1pYQUpyd0JtdXZvRUJwcHBKNVozeERKYXNCMTJ6elZTSXgx?=
 =?utf-8?B?cVpjSTd4bXhwYUdGYU5qQmdDMTRDTXZoYkorTzBMYmp6MlFzMGpzdWZSMFhp?=
 =?utf-8?B?eGVPT3haak1DbmxiUkNTSFlXcXJwQ2xRblRnTE1NVGt6Mmp1Wk9KTkFmUUhj?=
 =?utf-8?B?RjhBelkrQnBVZERVT2d4VWx6d1h1SEM2dkFTK003TnJzbTZMcU9IVmVQNjZ1?=
 =?utf-8?B?SmtneFJmdnJ1eklBOGJVMnFqeWxlTXo3WTJxM29sbTlrUEZlSjZzN3FYaU1T?=
 =?utf-8?B?QmZycVVCZ2hzYlY1Zkc2c3lqU0JnZEV0cGkvR2dWMDZIWFV1bnJTSnBZTTc2?=
 =?utf-8?B?WVpLdXhpYTdqYlpqVjdqWGhLWVdpWlZJQy8zSllSQnM0Z2JUa3hBUFpYR1NO?=
 =?utf-8?B?cGsxNkVEWUV1a3BFOENJdDNSYVVOcTVsQTNnYVY2U0gxbG1Td09uOU5PM1Bm?=
 =?utf-8?B?L2t4RWZvb0VBRGd5RFNiaDhYQ3NRS21RZnFkSXRQcjl5L2RkYzduM3RHSHU3?=
 =?utf-8?B?dDJJWjJ2czd0U0hXaEJiRG5YY050MmdTYkswQk1Eam9LakZLaUIzK0tlY21R?=
 =?utf-8?B?WXh2MklwY29KS1JVQ0pXeTlZQTdaOEM2YU9ReVF5S2FLTjhZaWlWSDd5RmRW?=
 =?utf-8?B?M0VlZ0VQYWZVNTFHY2FyMjZsKzVOMTFUN1l4bSs0UW01SHo4ODdIZ3NKUis5?=
 =?utf-8?B?dzZLUG1Ob1RIa0FnMXdJenNHVWUvZWRLL1NKSWZZQjZUd2RBTmkxLzNIa1d0?=
 =?utf-8?B?UjFXc3RYdE9kRi9lam5DRWhsQzlreVJjemV5ZTVvSU4xUHpaVG9yZGR0dHUw?=
 =?utf-8?B?STVmOVl5bHFxYmNaKy94SGFlVUVyMzlWdEJiVTR5Ujk0MzY3ZnE5Qllid3Mz?=
 =?utf-8?B?ekpHcEVQRkRLdXFFcUozNCtXRHVUL0ZWZjdsZDIyQVArU1pkbFpmbXRhb3E5?=
 =?utf-8?B?VCtuK0pBM0dqN09iOVArdW4zVzNQWFhackVKS2NLalpER3R3OUVucVllVDVD?=
 =?utf-8?B?a1BLdUUwUVdidms0NHpHajI5NXpXUllJUjJWRE14Q3RBS2NsVjJ6MmVmTFNB?=
 =?utf-8?B?dDN3aHRYOFhDc2k2TkdubnpVbVRCdWdSNjcrUnNzTnhiYWZmcnNGQ3JEcG1u?=
 =?utf-8?B?QXZ3TDlPdkF6Q1M5K2xhMTNjZlhZaEs3Zy9ieXFuT2pyWDBzNWxUVlFYQi8v?=
 =?utf-8?B?Z2hmRXRrUThXNEdaaHpzMGpoNGhuSkRRVmlWeThtKzFJOVN2bU55RFRZMUJ1?=
 =?utf-8?B?Qi82OTUvdVRJV2I1d3o0ZHNpQjFUbndFYzJFOTJucDdEc2puY01zdDRQZmxD?=
 =?utf-8?B?bUpFenBBZTdnYmdYczZJOHFEc2dhY3kzV3BtY2ROYXAyRnRyVWdtdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6b3cbac-ab99-4c57-a91c-08deb4d55978
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 12:02:35.6887 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fc1MzdlKwz81y24v3uXce3VPdO2s0c2urCp/1DOQK+xAmn6tLNFLWDUyyGTVMPyk/aK20+abm1v8yp4zNJvC6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF183341E5B
Received-SPF: permerror client-ip=52.101.201.23;
 envelope-from=avihaih@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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


On 5/15/2026 6:20 PM, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Fri, May 08, 2026 at 04:01:43PM +0300, Avihai Horon wrote:
>> On 5/7/2026 11:03 AM, Cédric Le Goater wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On 5/5/26 10:14, Avihai Horon wrote:
>>>> migration_completion_precopy() doesn't propagate errors to migration
>>>> core which leads to error information loss. Fix that.
>>>>
>>>> This prepares for a follow-up where migration_switchover_start() can
>>>> fail on switchover-ack and still report a useful error. Errors from
>>>> qemu_savevm_state_complete_precopy() are not propagated yet as it
>>>> requires more plumbing.
>>>>
>>>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>>>> ---
>>>>    migration/migration.c | 7 ++++++-
>>>>    1 file changed, 6 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/migration/migration.c b/migration/migration.c
>>>> index 6fd89995a2..a5c7ca6796 100644
>>>> --- a/migration/migration.c
>>>> +++ b/migration/migration.c
>>>> @@ -2780,23 +2780,28 @@ static bool
>>>> migration_switchover_start(MigrationState *s, Error **errp)
>>>>    static int migration_completion_precopy(MigrationState *s)
>>>>    {
>>>>        int ret;
>>>> +    Error *local_err = NULL;
>>>>
>>>>        bql_lock();
>>>>
>>>>        if (!migrate_mode_is_cpr()) {
>>>>            ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
>>>>            if (ret < 0) {
>>>> +            error_setg_errno(&local_err, -ret, "Failed to stop the
>>>> VM");
>>>>                goto out_unlock;
>>>>            }
>>>>        }
>>>>
>>>> -    if (!migration_switchover_start(s, NULL)) {
>>>> +    if (!migration_switchover_start(s, &local_err)) {
>>>>            ret = -EFAULT;
>>>>            goto out_unlock;
>>>>        }
>>>>
>>>>        ret = qemu_savevm_state_complete_precopy(s);
>>>>    out_unlock:
>>>> +    if (local_err) {
>>>> +        migrate_error_propagate(s, local_err);
>>>> +    }
>>>>        bql_unlock();
>>>>        return ret;
>>>>    }
>>> Instead, I would modify migration_completion_precopy() to use the Error
>>> variable in migration_completion() :
>>>
>>>    static void migration_completion(MigrationState *s)
>>>    {
>>>        int ret = 0;
>>>        Error *local_err = NULL;
>>>
>>>        if (s->state == MIGRATION_STATUS_ACTIVE) {
>>>            ret = migration_completion_precopy(s);
>>>
>>>        ...
>>>
>> I'd rather keep this change limited and not involve migration_completion().
>> The error reporting in this path is a bit convoluted (mixing error reporting
>> via qemu_file) and I think it deserves a separate series cleaning things up
>> there.
>>
>> Unless I am missing something here and the above should be easy?
> Not easy to keep everything as before, but I tend to agree with Cedric.
>
> The hard part is to maintain the same error when something failed in
> migration_completion(), but IMHO that's a legacy problem we'll need to
> tackle with, sooner or later.  We can do it now, facing risk that some
> error message might change: I think it's worthwhile to try.
>
> So it also avoids introducing yet another migrate_error_propagate() call
> deep in the stack..  Ideally we move it upper and upper so the invokation
> should be less as time goes.
>
> The old priority to handle errors in migration_completion() is:
>
>    1. if qemu_file_get_error_obj() succeeded, use it first, otherwise,
>    2. if ret!=0, generate an error for retval
>
> Side note: (1) is currently slightly off when qemu_file_get_error_obj()
> returns non-zero but without an Error attached.. but let's ignore it for
> now.
>
> After this patch, we could prioritize Error* whenever set, hence:
>
>    1. if error non-null, use it directly,
>    2. if qemu_file_get_error_obj() succeeded, use it first, otherwise,
>    3. if ret!=0, generate an error for retval
>
> I think this order makes sense because neither qemufile error nor retcode
> is better than a literal error passed over.

Sounds reasonable, I will change it.

Thanks.


