Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E71CD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 13:07:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLKuy-0001pz-Df; Fri, 08 May 2026 09:07:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wLKuw-0001ph-3F
 for qemu-devel@nongnu.org; Fri, 08 May 2026 09:06:58 -0400
Received: from mail-centralusazon11010033.outbound.protection.outlook.com
 ([52.101.61.33] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wLKuu-0004IJ-Ct
 for qemu-devel@nongnu.org; Fri, 08 May 2026 09:06:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jv4+OCNKCYIDZ8xGJheFpP66xm1G/G43sryHqOSt28f4CK345k8m+deXC8bSUnHw6EvUSAjcNexp0r8MmYgtQIsaOXSAyqUC2Ul/vhsdxEdIefu1SnBs4nOcPbmUirqKqPv4ZUYaIAInQ3ZAZjT3uMa52j2RveD2XlJrRBLiHrk7l15UfwnPu94KrkQST70E/GHi7g+/BZ+YOJCMdKPkBAP4Q1KWSk1Wt92y0TvgkSdj5nWZtAhPx+k9isr8vxvA7y37oZVz0kkg5qnKDbdCN7P99luZAp0UKFeIwX56tvAYJWJwxq7Hljdm3xlk8E9v5ZHvsL1T1rop5Xr2QpJNNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+YmsEZ4ROqX1p/qMkpQh6q8QA16CNL89mgFR9f3xis=;
 b=WkEuSePYjWczqj5FrMhGeRd7mcn4xb9rKSVlQuJn/HiXDWV9So5DoIvhBHutL8d0C/dJWCF94fx0tzrMLMRUjXFC+cgVEznAoTQZR+J5J+1UVoZOgvUDj2CVr3oUVabUXZ0S528dh+evM6ZCkp0LgGtpnDP5TFaRRXyzyuoR5OR2s/ueNIvTfZ4g4CTtQPu2/f//2WybyVDqQfLWUj0pnbCWtzQgwiFSExkFqk6Du/mbIddL0mhnNIcQRLj4uCt5xaqF9BljCRwAxLFNMfa6jAQnONyvTGQZ9ZQrBuqlbzO8RPT5gQBDCWDlj2EJUd0bhaZnDExrBtj8MJmlNjoeuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+YmsEZ4ROqX1p/qMkpQh6q8QA16CNL89mgFR9f3xis=;
 b=Z5qOnZupHO6b7bMxCpkcdE14LF/VZbU9GZWTWxAPTMuyO0ZOFloz2DOLOXBwogWYRCaPGkLH7zmSHOlK0lD6zb7+RmbYMPcQ5485iBCr6cqCn/BlYxUhsfccjT4DL9JekodugbxIsXb3EBgzXMJ95eeNEipzvdJ1PZQtNw6jVqXk/ZutAYhquX7OZGfj7MWzyxNKv6bC2hJHxxmIxa258jYC7zhWj5MEYz/KPrNmIOjJTkucIu4gUqj5t1LrNFZ4Hjy2zPVeJ3YocTDhHRxe9gFpGfC+h+kZzW2FyfekseTl8LH4WRjU+fjqY32tLxNE4NV03Max6TkZaZatcjll2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by PH7PR12MB7139.namprd12.prod.outlook.com (2603:10b6:510:1ef::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 13:01:48 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%7]) with mapi id 15.20.9846.016; Fri, 8 May 2026
 13:01:48 +0000
Message-ID: <f3031406-7146-4045-bc5e-720fa4bf69a7@nvidia.com>
Date: Fri, 8 May 2026 16:01:43 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/14] migration: Propagate errors in
 migration_completion_precopy()
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>
References: <20260505081423.28326-1-avihaih@nvidia.com>
 <20260505081423.28326-4-avihaih@nvidia.com>
 <c439b516-b8f2-49de-907c-9dfa2edd9e2e@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <c439b516-b8f2-49de-907c-9dfa2edd9e2e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0339.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::13) To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|PH7PR12MB7139:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ef02f72-1ae3-4d0b-81e3-08dead01f6b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 3e3Ld/bitJhygvzgLCn0gHRx3oZfH+0NbhhZ9wWiig4Kl4le08AFFRaEzCxfdJbj1OhPQgHyb+NYYw9iGwqGhLmRPQ5oTG271AwFGnFTIVEq8YNUI4/d9IGPMMAt1oAgrLgq+1DWGaVtcMzDFvLN09hAurocMvfO0ZaSSTk0ftuVVpES4UNNi49Nw7h0iGxd4fzFDJs07/voYdwapJAzdnbpEpJBkSRMLAq8qKXYDMoDgG1JqmZljo8tlVN1bHFb0ImiO4GqQOROsYhKKQtHDD3cy61OG+pYrTARaZBxwKJgxD3m/nLVgfMUByzF2zvBK81VaJrsAuP/bsSihbhPAukkTU8xkiXsgS2z2xsZCoaupm4KMZ4DN8HAZyVP3MR/z5iMMY915JoA6ElBk+WT6eoXHi47CXLJ9RCxX6/fYQznR9SIipI+HXUuUBnCcda8EyY5dR1RzoOacHb7qfs+hDHFgLSX2p4qC8MCjq26UeRY/1KZJJh4NpGgmwUNJ1AkqeGcS1K/c/zMXFDNMOEPqRUijMA/0oJJpaOgJDc5nQIwoxB/c8IGQmmhhGSpC4TPsUXQ4b4le++2cS7pF47ry2GWlmqtnBRAjLsFlYRGoI214zoOKYcBv6twEXJcu0Uf/wkBEgyipXgTRtpjs0kjqlA97Bd340gtYyU36Yc72BUgOdE5PDcExQ088nFt9hpb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTRLT2kxclFBako2Z29UVCtqcFBzeG5TZVJQQXZXeklzRE1tSE54dzJFS3Jt?=
 =?utf-8?B?T3QrOGIvK3hka1l4eXdIdkZTcHdqMWhFaDY2TUlaemt0NFdRMXFKMk1tcExa?=
 =?utf-8?B?ZXp2NXJ0TE42QThXRTlmTUV5NzRMQWFIWkZQRXdMNWtoV1c3UTkxL1JiNGRx?=
 =?utf-8?B?azBGMlhGeXFPTnpnQjh6OVJLTlpaREFHRmc4ZEtrM2dXV0NQVS9rR2RsaHYw?=
 =?utf-8?B?cGhjT0FzR3NaelNaZDlPUFVCY1VhMmVETUQzYncxSTNiT3BjTzEvUnp6MmVV?=
 =?utf-8?B?Tm1OTWVRWW9GUjVrczhOWmszNmtwWUxmSXd4VHFCWkIxdFZHbktWUk9ySlpX?=
 =?utf-8?B?dXE2Y3ZvZnZpSnNwWU5jcWVkWkJDb1NHVU1GSGRvUU42amNBbE4wV3hUOGNp?=
 =?utf-8?B?YTh3WG9QbEFFYy9RckhYN1JHNEltamFmbnVVbVBOS1QvV0RSdElFYm8yVjBE?=
 =?utf-8?B?UWlVR0VPN1NLQjZxSDZEdVdwbjJWOEQrTFhGaFFMRlF0QkZhRG1ROEl3a25K?=
 =?utf-8?B?VUMzTFQyU00vQmRLMjQzWHlqVnRMa0pOcTVqeDM4R3NuRHVvUEZZRkVBODk5?=
 =?utf-8?B?aDZQdEpXMU05dy8wdStlU2VvWUhXSGJGMTE5WFdRQkNlY0pGc2FZZ2kwQVpS?=
 =?utf-8?B?SnZ5NDRpZGNpaS8rRGlsTS9QZEU3NUN3bnNhVlY5TG9RQWRUQkQwRW1CNFVi?=
 =?utf-8?B?a0VrMzZsOTFWK3lZVjRLaTVtb3VVd25JVkxQY3ZpM1p6cnRkd0lwaWNmb0dB?=
 =?utf-8?B?anRWdFBGbitNK0k0SnpZNUR2MjFTRm5LWnY1YzI2alhxdStySm1yWEFRbmxx?=
 =?utf-8?B?em5JSi9TYk9SZEUwK2VXeDJOK015OThkQnVoN0puRUpnNHptREpsM3hXY0lK?=
 =?utf-8?B?c2I5L1YydXc4R0hoUzU0YXZEczdubGh4VmJXVDIzQmg2R3l2aDJZVGNZNzdn?=
 =?utf-8?B?dmR1TWl6RllFR3Mvc29CVWtjbGN5cVBPUVZwSXBsaGpqN3Z1Si96OG9YUjBr?=
 =?utf-8?B?ZTluRnFYSSt5cFhRNE81am9xMXI3dzh0N0l5NGd2UlJ4RjZGV0R4MHhJWEt1?=
 =?utf-8?B?dlBCdUgrQTlMbE5JWVAyNWZVcEcxNlgvbmVxR0FLTlF3dFc5QkhCbVJNUUIz?=
 =?utf-8?B?WU5rWVJSdlArQStvVCtKYnhhcDdBai8wR1Nld3E3UnRGSm44MHRMWHQzNFB3?=
 =?utf-8?B?RHpkZEFQVEFqcWFMZDNJaVhHbXVjejRKaGZOSEtYRVhCZUJWY2VGRHNiQks0?=
 =?utf-8?B?QVZpVTlJa01xS0Ywc0NxdUlUSjEzVmlRem5yYXlpVmtxN1VoMXFaWVdkVHJM?=
 =?utf-8?B?QVpNV2hpdHFPL0ova3JYSUZibzR2ZE9DYlZFVnV0QkxaZTN1TDlBRWlrV1hy?=
 =?utf-8?B?N3U5RWlxV1MxSDZ6RENaV21VSmNyM1RwMlZVOUVUZ2RtNUtOSWE0QnhSdG1Q?=
 =?utf-8?B?M05FSzYzN3ZJQnNHaTkvOE5YZmI4WUhhcWNCRmIwS1F4Z294c0RFR1dWem5U?=
 =?utf-8?B?bU5vb3hid29IMTl1VkxIcnp4QjJlc2J2bUp4ZFEwU1lWTmpEMW8zcEVMVVFx?=
 =?utf-8?B?TW9nRXUyYnVWRmI0K1ZJcXhJcERFbWdGNTNDTGlEOWp5YnMvcTIrQnJYL2xC?=
 =?utf-8?B?enZoNVRXeGx0bll2YW1UWm9JNUtTQ3BEcHJUTEhrRVlzNjJuVHlmbmdxTzBS?=
 =?utf-8?B?Y3VvSnM4Yjh1NHRWcjlqMWVLcmVaZEtnM1VuQ25PYjRZdWpUTjB0UHVtdTJ3?=
 =?utf-8?B?MkE4K3hUZUdDdnJXMEN1a1dNNnQzRVpPVmRVb0FnekthVEFUVDFFcmhhYjdq?=
 =?utf-8?B?Ry9IaWhKS1prbU40Y0hRbmxoR3k3UUdUZlluQ0Qrc3dXekU0RDlWMXNTdEFq?=
 =?utf-8?B?UHVaaTdMaVM1eEx5VjhwOTJFMUozSlAwZXlQbitiNVBhK1NnYWZqTXQyYVh2?=
 =?utf-8?B?YUJWODVlbEE5NWRzRDcyY3pwY2dXdWpzNFFpcDZqYWZiZjc2YTYzS3RnWUVO?=
 =?utf-8?B?SmYrTlVqSkFEc0xDdlpvaTN0dExNaFB4VS9YOG1Ed2dpbVB3dDZ1Zkt0MGx1?=
 =?utf-8?B?MVdrWTNmZ1lwcnV2QlI1MUNyL1NkMkVhb05MZEk1UVNuMUFFRmIyQ1NhNG5H?=
 =?utf-8?B?bEV1NEt0TW1yMTlXMnVqaDNQZ1pZNU0xSmd5OStkM080NEFhYnRaWVk0cEYw?=
 =?utf-8?B?UlI3eFJUajVXRlFpSmo1R3VVU3daZ1dKOHU5dmd5M0g4OWQ5R1dYUGlsRTds?=
 =?utf-8?B?cU1zaExDVFp3eEpFVzBkYUpKa0FIUENUdU1UeUNrUVJUTHVnZTlmSUFsaUlu?=
 =?utf-8?B?clB5Rjh0Zks4aWZKdXJpVGd4amViclU2MzYrbTU5Q2M5Z25BQU02Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ef02f72-1ae3-4d0b-81e3-08dead01f6b4
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 13:01:48.1866 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t4A/Snn663meJEIarvNlBhgYz3bf5HW+QphP+egz+JPLd+URTPuSPpN8ibK8IBXLM+jufZay5ss8mlei4923Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7139
Received-SPF: permerror client-ip=52.101.61.33;
 envelope-from=avihaih@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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


On 5/7/2026 11:03 AM, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> On 5/5/26 10:14, Avihai Horon wrote:
>> migration_completion_precopy() doesn't propagate errors to migration
>> core which leads to error information loss. Fix that.
>>
>> This prepares for a follow-up where migration_switchover_start() can
>> fail on switchover-ack and still report a useful error. Errors from
>> qemu_savevm_state_complete_precopy() are not propagated yet as it
>> requires more plumbing.
>>
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>> ---
>>   migration/migration.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 6fd89995a2..a5c7ca6796 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -2780,23 +2780,28 @@ static bool 
>> migration_switchover_start(MigrationState *s, Error **errp)
>>   static int migration_completion_precopy(MigrationState *s)
>>   {
>>       int ret;
>> +    Error *local_err = NULL;
>>
>>       bql_lock();
>>
>>       if (!migrate_mode_is_cpr()) {
>>           ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
>>           if (ret < 0) {
>> +            error_setg_errno(&local_err, -ret, "Failed to stop the 
>> VM");
>>               goto out_unlock;
>>           }
>>       }
>>
>> -    if (!migration_switchover_start(s, NULL)) {
>> +    if (!migration_switchover_start(s, &local_err)) {
>>           ret = -EFAULT;
>>           goto out_unlock;
>>       }
>>
>>       ret = qemu_savevm_state_complete_precopy(s);
>>   out_unlock:
>> +    if (local_err) {
>> +        migrate_error_propagate(s, local_err);
>> +    }
>>       bql_unlock();
>>       return ret;
>>   }
>
> Instead, I would modify migration_completion_precopy() to use the Error
> variable in migration_completion() :
>
>   static void migration_completion(MigrationState *s)
>   {
>       int ret = 0;
>       Error *local_err = NULL;
>
>       if (s->state == MIGRATION_STATUS_ACTIVE) {
>           ret = migration_completion_precopy(s);
>
>       ...
>
I'd rather keep this change limited and not involve migration_completion().
The error reporting in this path is a bit convoluted (mixing error 
reporting via qemu_file) and I think it deserves a separate series 
cleaning things up there.

Unless I am missing something here and the above should be easy?

Thanks.


