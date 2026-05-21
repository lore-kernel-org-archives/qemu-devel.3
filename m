Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F71BCD5BB1
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 14:01:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ3xZ-0005TS-MZ; Thu, 21 May 2026 10:01:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wQ3xK-0005O2-AR
 for qemu-devel@nongnu.org; Thu, 21 May 2026 10:01:00 -0400
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wQ3xI-00040C-0h
 for qemu-devel@nongnu.org; Thu, 21 May 2026 10:00:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gJ9NSzia8kGEq7QmOszQI+HbKNj8MYgRrOqYypxOuK9Pze2VsrRuCNgWmirZ1/2ZvHlC8E5Y6zir1avGNsTpHMNXzjBeFarqOPI5vYsIyqSWJextp1kGpMRhAq+tg3KIkRhMSl4fk/cqLSlinhSe8FyVg9J5nZTBz/MXU4GBlFHPe+eI7ZDd1QSuXHh5GGWQTFuoLPVCPmWhuGiFqieOXYFFsSbkzrA2eaSt0pp+ZS7VWijIrVzFDhGBMcH3KR4PNE/cWzbzX8I+uc0TPczTxvcZ3TnYMlOc5t6Q/22/Ry/6o6BNKfevIxK8MUtooC+I5nTEfy6cq0Gi3/wwCT4slA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZHizFLFrVtNbrDUX3ZXeLUk6xFrfAPxfhCRAqeget0=;
 b=ZNKK/VJ2yzAGHNdzYy3bTFi0iLMQcbq/rZoviGi7JSbRgR8+qpTQeqNww7Ow2d7xk8OOOZ8VsWeenOeN11WgiZxqroEqi4TRq5UTUQXdYRx/bhb+yTZqK24TKz7A/SuuH9fG5jL3SIBGz7+IbVjEIAw2//IRWlym+A1+LwZrSTzF2iYImH4mcgticUz0eo+pZXezLlFCwFybcrMeXayYwL4k6H0Q8GrMO7W40KC+42UkyituOtMTOKWyc6XqpCkJuXISIdJy2n+PlCHjRYuooRdn8HIDgYub07ZZiarn/J1RCTX5I9X8HiN+0z7XNLyltz6U+P4lOIQANMuLxp8RzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZHizFLFrVtNbrDUX3ZXeLUk6xFrfAPxfhCRAqeget0=;
 b=JybEznLFXqdh1N+TnQacz3dJEfXsQAHj86N9nlkl2GHNrMOH2kMh0iG19+34udW8JNvc+U/kaAPAROOdGrt1tK9yZK3Xw2dXp+oL+MnoyVbv1zqQWqnHF/ldrQezGl3qMYCXidd1Uqxut4cKyN7x6U603cdOM3a6kbGFz+nsKD9TdlQeJkz0RK2UQfU/rA6eukjq8typb+43ZEh6kHf2MNi6zazJHtblqArAB1EbrnvtF+vtO8gpiZNT+erY4nkiEP7ZRtAIl48fadSG9Bc9k9S7Jg5ppcnfUXiIITJW9t1ORv7gJDqs8JSpP3MmG7EF74qOZ8Cl4g2LMXVgp0ScAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by SA1PR12MB7245.namprd12.prod.outlook.com (2603:10b6:806:2bf::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 14:00:49 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%7]) with mapi id 15.20.9846.016; Thu, 21 May 2026
 14:00:49 +0000
Message-ID: <66e26fcf-caef-4b30-aff2-6474f19013c8@nvidia.com>
Date: Thu, 21 May 2026 17:00:44 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/14] migration: Enable new switchover-ack
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>
References: <20260505081423.28326-1-avihaih@nvidia.com>
 <20260505081423.28326-15-avihaih@nvidia.com> <agzD1-wZ4MeKwgPT@x1.local>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <agzD1-wZ4MeKwgPT@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0048.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::20) To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|SA1PR12MB7245:EE_
X-MS-Office365-Filtering-Correlation-Id: fca99abc-6391-4938-2f99-08deb7415cbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|22082099003|18002099003|56012099003|3023799007|11063799006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info: YGJabOxT/x+B//Qmmp9RkF2+bw2V8SN0xIgvfmJ/sDcYPg7qnin67TLi5xcT8EAxw+Vd0AvV1SIuCjVF910cD6r36qw7sC/Zcu+ZG90TLZiVbmH7UY2JashqIyNa5CG/EzeCYzjgVEl54W+3a4wS9SEg8Hn2azmyefgp/bZle5AD6QYe0eXTtaK9gnqkLY5iOx25/pkYT2bkSnQpUKC5E8DYhZMaOCU8Biqi/3W69tj8NAO/k8B3Z0AuMf/aNxd3zRSKEu4KxOz9V65uWiNGdHS6bu1YADqyWMN8wHTWt5DAbWnCg2nIuQD/yfVPuEePYn/XG4c3uE07INaXy/Tf0ufZeLCZJCAFDwbGXJS4Dl/uf3TLNp9DbUZXl24zNbd6vOXQQfjro1k9J8ZrhfBZqd49b/i8mp+KQ/BtzoNAF9WXHhVYtEBLNzFqS6SJhvPYysd8OnCK+yfhakfZqSF3zirvG9rCLHA6U86eq3vfa7/loFl3RLzIsUV/lxHiDrF5BERrBNzFuMvcSUzqgkxQP9X11CYlvkDdK3w5DLLXpksXvsLNAET1Ow/jDBXka+fYDfQaO/rTo4ku8UagI3Dx7PBND7A7LqFe15yP4APSqIpRsAFcIlmeh4H1M0aCLV8g6jAxHVhQAIl5YaNmqGC+raUCuvtqMzgdbpXiG/4AE4JecPRu2zDpJ0ci3j8ljVAv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(22082099003)(18002099003)(56012099003)(3023799007)(11063799006)(4143699003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mi9DRFZ4clU1SHBKNVhzU2JIMUtKRS9yZ0F4aXpDZnpkV2hVYWxGRXRCSkhp?=
 =?utf-8?B?QVpMTEhabHVYQlg5R21ZUnNlWnJHQ09VcWJVNVdIcExFdWVPQ2w5RUdYaHk4?=
 =?utf-8?B?ZnlsMlg5QisyaGxRbXBoWFBXdUQxRkNxdU1BdjYwSVcxbjRLRC92QjA1NW9N?=
 =?utf-8?B?Q2hEazVqQTRxek5qQWdHMEcwRWtLYmdUVDdkN3lEbThLTlV0eDJlaEJKWUMr?=
 =?utf-8?B?VC93STdRYS9pcGo3Ylcxbm44Zk9aUXdKSzBNakRMTVBKT01hUmdiTjhncU43?=
 =?utf-8?B?d1ZvWXBubHRCOGFDNnFkK29wbmg5TlZRY280bUVZUmZnNHRCZnpoNDV0ODZ4?=
 =?utf-8?B?MFIwQysrM0IwM0ljU0FMZW5RdDVBdDE5c29ZaDY4TUJRWjdHSDI0aVVWMjRz?=
 =?utf-8?B?eUprUnZWZ010ckQ0WVhJb09nVjJnNU85UE9ZbXZWY2p5RGViVXJOVUp5Q2M3?=
 =?utf-8?B?WTh5ZytaQ3dsSlVUa1F1ejc3cXJhR04wMXdGYjdTbGd2SVJ5NTltRWdJRnVh?=
 =?utf-8?B?emZlRlJKb01GcjRnTVJGVFZRek5KV3d5MEdPUjgyWm52WVYzS1hRWWtIdmtz?=
 =?utf-8?B?R0NMeit4aXRhWDdGWTIrai9Td3ROUGpEYXRXK3Vldm9LT2FiOGdTSzJFMWkw?=
 =?utf-8?B?ZEh1N3BVUW5TbFNhb1lOMDUrYmorYlNQRDVUdVJNQVo1MHN0YUMvNXRpSmYx?=
 =?utf-8?B?bG1TWVV2NjdkM25SbXZwK055cnhGeG9neHBheC9rUFBTZ3VtN0RMWE82RkJR?=
 =?utf-8?B?dmVlQVVENERNemdiaCtYWFVsS1RRRjhpcmVFSTFtVk40V0dKL1RTSEdDbzNr?=
 =?utf-8?B?czVabmZSY3h4SE5SUkhKS0ZjOTRrNmNrbkhLc0xEK3AwN1RFbnZXWHB2Mmh0?=
 =?utf-8?B?c2Z4aVltckh0eVluYmNWYTdhMzlSS01HQkpSQysrN1hramlCYzFwRlo3bi9m?=
 =?utf-8?B?aHVZUU56SldHVit1NG5UWE9CU2hBTEllWjJ1RU1KdjJ2WjB4bnpVcmhhNDF4?=
 =?utf-8?B?SU1zL1BmWFRxckNsYTBYTldZYjNmK1UxZ1Q2WUo0aE5hcVZibXRReHVSWHpM?=
 =?utf-8?B?SHhiUldCcmQ0ZWlUMEpLYzh4YW5FOGIyVGcyZGRjRmdNaFhUZGtXdWRaTkh6?=
 =?utf-8?B?WTZUdVdlQ1NWb01XZFc0b1NjcklWZnFOZlR6R3JtVHUrTWZYVS9nTUFHcURB?=
 =?utf-8?B?YlpndUh3SG4wblVNU09QM1h0S09wVVNQME1hQ0dLWlNiMHhvTW5Ub1AxR3RC?=
 =?utf-8?B?ejdlVngra2pVYzhOczg1MkdnSGo3ZkVoVGhRdit5YmJQcU1sUG1iK1l4RTRL?=
 =?utf-8?B?b2tSendGMDJ1YittVXFmenFSNG1Kbkp1bVp1akpDSSs3RjlwQ0MwMk5SS2p4?=
 =?utf-8?B?dHo1bnJTUE45YnRWeEhqUWVaTi9LaVVqaW1VT21wMVZZZ1B5Ymt3Q2ZFS2c3?=
 =?utf-8?B?SXZBYzJMWW13OEJhYUhVQ1FVZCsxeGtVVG1pZjd3eFhJRVBjL1RaVHdTdWl6?=
 =?utf-8?B?dTJuQXhuRmIrQ2lkeTRLNzlhc3MxWkRvVEFYc3VnZHd1WVA2L3h2VFRtRjI1?=
 =?utf-8?B?MlVKUmMxcWJhMi9CbEJNVkRzMTRlZFRJcVZqaURwTTk5MzFWZzhYcWY5eDZl?=
 =?utf-8?B?YjBnRjI1eHhNa2RiS1U4Q09Qbk9vU2lqcGxxZ1RqODBVWWFMNUY2Q0xGaHVy?=
 =?utf-8?B?eTdJV1ZmYldlZEptbkJvTGtnNWZyUEE5dzJqd05MTVZhWEJaemgxaWcvY2pG?=
 =?utf-8?B?eHczckxyOVU4enphZzlDUEZlOElOakRRMldjVy9uaUs4MHlQTUM0cUlBb3g3?=
 =?utf-8?B?aWd3ZEZWTDRpNUZsNlV0YkRsSUZRVmZCK3RYQnJBN0VreXExYVdYUHJocmFK?=
 =?utf-8?B?VWNuTVJ1dkxlMUozT3JsTW5LSEZyekMyVXQ2dThEc0V0S2hFTWFncDNkRndi?=
 =?utf-8?B?WGRkZ3g2RGVDcWR3MWxxbmdyUXRiZXhYelJEYWtMaCtFclVnYnJ2dTk2Ukpp?=
 =?utf-8?B?RmdlMUpWQ0J1R2hZQldqS2U1c2JTQUpnaEUxbnhLNmE0Mk1xUVhpQW9rZDdP?=
 =?utf-8?B?TjdJazFGWkZnVEFLVmVwZzZVOHFwOE43Q201Z3VCYVVXd1BCVWl3c2t4YklI?=
 =?utf-8?B?NHBicmxBRjhiU3RWUjgrQWV1c1htU1BxL1RwNjNZVEZJSDBsYXo1c1Z4RlJo?=
 =?utf-8?B?Sm1FNUMxWUtaQW91WEVQYWJqc1BscDV2QXN6cmlDY2ZuVEhYZWtlK1UxMnZZ?=
 =?utf-8?B?T0lhSFZhVHJHQUd4b1B2UnRhMVpTZk83akpHRVFLSm82dVE3WVg0U3FqR1cz?=
 =?utf-8?B?VlZSN0NiNzdXSnlZMVJUenV1UzFUL0xCR3ZEV0tOWVRscysvTmJaZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fca99abc-6391-4938-2f99-08deb7415cbc
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 14:00:49.1613 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /jsvJlDcsFaG8fC6Ojls/J/54TFk9qFdDstRsVzEWtU8IXOOVtGLETK5Qenv6rHtTIsBZRSTPEp9Dv0JTeZD6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7245
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=avihaih@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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


On 5/19/2026 11:11 PM, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Tue, May 05, 2026 at 11:14:23AM +0300, Avihai Horon wrote:
>> Now that VFIO has implemented new switchover-ack, enable it.
>>
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>> ---
>>   migration/options.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/migration/options.c b/migration/options.c
>> index 44327c588f..91571f9d30 100644
>> --- a/migration/options.c
>> +++ b/migration/options.c
>> @@ -108,9 +108,8 @@ const Property migration_properties[] = {
>>                        preempt_pre_7_2, false),
>>       DEFINE_PROP_BOOL("multifd-clean-tls-termination", MigrationState,
>>                        multifd_clean_tls_termination, true),
>> -    /* Use legacy until VFIO implements new switchover-ack */
> Removing this line is fine because it's a very temporary thing.  But maybe
> it would be good we have some rich documentation on both the legacy and new
> behavior of switchover-ack.  Normally it would be qapi/migration.json, but
> in this case the user shouldn't need to choose, so I think when keeping
> qapi doc simple we need to have somewhere internal that document all these.

Sure, I can do that.
Would adding it as a comment above struct 
MigrationState->switchover_ack_legacy be fine?

Thanks.

>>       DEFINE_PROP_BOOL("switchover-ack-legacy", MigrationState,
>> -                     switchover_ack_legacy, true),
>> +                     switchover_ack_legacy, false),
>>
>>       /* Migration parameters */
>>       DEFINE_PROP_UINT8("x-throttle-trigger-threshold", MigrationState,
>> --
>> 2.40.1
>>
> --
> Peter Xu
>

