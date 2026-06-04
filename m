Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A2BCD6E6D
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 15:38:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVA9R-0000bQ-EP; Thu, 04 Jun 2026 11:38:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wVA9P-0000b7-7T
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 11:38:31 -0400
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wVA9L-0007qk-Um
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 11:38:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lwBtBB8gZWGVbHMDmoKu0Ws+BSseBs431tPhu7dgJGCZwWf/UOZVke7VVwWkG3UuSvcNs84s2R7g/IbQ+/6wenYT4FT+ZQw9iaSs5s7vPHX76RXThl4cJAzipJFhQKO6nfphnrrpsfKV7M0Wk9HG4EBafOLTcfl7O8DV7psq6/WoRbKsepQ9RyNHyKBVcscjlNjkOzdlsiTC0sOZT/o2xCWQDFAd5/VXIhSJHjVShdDm3NACDTkUIjc8Xu2vP+eCnOaveDcqEG7Bo0GjRMzmphhKadm62s7asuOgk+GEIzAYVVHN0gSiBW5dRwSnUimo4D3OjoywWOK0PjAXeXCHvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lkX219RHQo4Cn2NCLRISZ9DYwE7R1JiuOfZ9BRjOF0c=;
 b=esCI5DPROS5l9I0s1OQAR09to1bt9NGv8FW51RoMTap5vYxIgTC1W1+1O9BTTxo0dgdi/G/y0SdGYV0200RpmdjrcLWpi1Wt9pqmabd1DgRnp6IXfxGDyxQKm5/pdm/tHIMoCsPAnsjcw6fBFbTR3VFE/8aNCm1KWZXKRcJl7Xs/xKXq9VJ9S6jOEMfXHELkMIP0CGGbo6D3iCnQKfIEv0bvyhNo7JFQ168fYLx5C0Tl0t8XjOMJVWOksiw43sxMr0jIyCWoqSlzeZV0GnqdlNVxcPLOpmjA2S4++hVSliAB8xSHOTY4kHyHCaQ3RkxRYp+ik2fe0U0RMNR91yAXAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lkX219RHQo4Cn2NCLRISZ9DYwE7R1JiuOfZ9BRjOF0c=;
 b=IdV+ZEk0Y3APxYLtXQvV+p2EzaISoGrdtmExpuQ71jZODJagCnYH/0xOLKBi198IO9yrhMZWZRGRf5DHW16kkdW+54nxAlHZa0i3uVsV1bN2Vv3BdI/x3DBg61NpMwEMG/zVCcoxuNmQQY82gI6zhUKwqYvsYRwXbNPdUN9iUvoULCYcVFo8EEbgZhfJhPSxb+nxhI6IcBiKeNIfphtCtDksyw2LVP7fiHZm7OLKxgW7AhwSObUuNXYjdJPle5uxHkK5W5xg7sZBS2NgFU62mZpkTljB+bKsT2b2nft7UTo67rPhCg9/iY5cYleRn5z1w2X6xq6gCVltcuiap1NWUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by SA6PR12MB999200.namprd12.prod.outlook.com (2603:10b6:806:450::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Thu, 4 Jun
 2026 15:38:23 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%7]) with mapi id 15.21.0092.007; Thu, 4 Jun 2026
 15:38:23 +0000
Message-ID: <4f71da07-c55a-476f-92a8-1398d90f0668@nvidia.com>
Date: Thu, 4 Jun 2026 18:38:17 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/13] migration: Propagate errors in
 migration_completion_precopy()
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>
References: <20260602092621.382-1-avihaih@nvidia.com>
 <20260602092621.382-2-avihaih@nvidia.com> <aiCEuAmX3qpWDS5n@x1.local>
 <cdd8c52b-74f3-44a9-8d84-917b363cad4d@nvidia.com> <aiGYCVUVwtsdgrWu@x1.local>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <aiGYCVUVwtsdgrWu@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0284.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::8) To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|SA6PR12MB999200:EE_
X-MS-Office365-Filtering-Correlation-Id: df191849-8754-4440-5cf6-08dec24f4fe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|11063799006|4143699003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: AoBhI9vo3vNxr/EjM0ZcRZ8kE6jXP2Ft6H3QruTCl9RQGwE1cQIkcCF2K5SyUsc+q70AG/F8dAkofi6bC+bR+Rfb2r+IV6YUtLOdbujZxReNU3Ex4NcCWksecbunmsAu/op6fchwTWU0PVPLWBe7AR6eRmmNCkO1VenwC/gg8FpjMOvuyhYpsgge9c1xn0xX8Evhwm7hmVDIAP4chCpG2Bx3jl+nQ+Ce/nDXEupJ27tils+1Z58iCKLZpS04wL6bwE5hKxcSPgK7gNDaw1j83CDyR18TqLmsZt24Y7KV/VpBGGYPl9yo/wyAz/k/8JRgFjFLnX6yPoiToezO03tDAiyVT8/vgscDd00BPZnklM8l3pSd57rwyU6Hx1al+GGu91svKAcooHsMXGW5qv+VOY8dDxUxPpD0gqFkhZE+5VJV8EMlmN//w+KV4/VBii2jh682clggW7Na+Q/gL7S/9sramibSpR48ODYkG97435StNQZQCy/iFxJaLa2QqtO82dAqlI8w7kjxwESKYqQ86sntM+Q32N9cBLl5jeCInxQnKRYdWCPV1fSCtPmUtbYsow8a6QICKOpdwo+YbREzwsNMdJjM/saWF9tp+w7mqERDosYi+5XIQ3gP/wJI8XLA+Ptxc4VpM2chALwLg+gGczkjkqXRAFP6LAuC2KuW/pCeIdlajlAq+4S5S4W0xj0N
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(11063799006)(4143699003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnpOa2p5TDV6RWRxYk5wZWM1dFZhNTJza0VTT1pXSUh1MGZEbXVIYlV4eVZH?=
 =?utf-8?B?K3RaRFpScGptY0lKS2RSUlVnSmlRTHR4VkxoWkI1UWtqSHpsWDliK3hMTlJR?=
 =?utf-8?B?Y1JzOGhDbElUeFpLaldMdmtjZVZPNTVHOVJxdlRoVzc5bG5PYVJyRnlVK3pv?=
 =?utf-8?B?NS9oLytWcGhiWi9xU3pROVU2bllXaG54SzlnWEpYVXZtY1dsQXIvRWV0VjYw?=
 =?utf-8?B?akUvbXRGRUtFM01FSDBXTmk5dGhmaklJaEtMYmZYQzhxMFl5YmZLU1lFZDR6?=
 =?utf-8?B?M0VHTTY2dkpneTZlb01RZ0lDcmpxbWd4VnYvUzlTaFRTY2tHOCtyQzc1Z3Ix?=
 =?utf-8?B?VGNiNkhRZ3psa0ExMURGWmNGNFZUaHZOMkwzSWFQY2YzaGJyVU9lNHlNVkpX?=
 =?utf-8?B?V0VJajNmY2RtSVMvKy9pNnpkOUV6dkdOblRkN2FZOXlaRmQ0RzcyU3JVVTQ3?=
 =?utf-8?B?cmIrTHV6aWZPa3NSMmVBUms0UWJXRE0rb1MxUFUyQnl4dzFBczRLOXpzS2Fj?=
 =?utf-8?B?dFRTdFdFQ1B3WjhpN3hiVEFQbFdOeEJ1ZlpNVnVoZEV2RkpaRHIzb29MWjhj?=
 =?utf-8?B?NkxCV3lTYURYN3o0VTRuYTBPQy9aa3ZMeDRUT1E3UW9MakJ3TkFYcUI4Tm1h?=
 =?utf-8?B?S0s3aXFPRDNZWGlTd2c3eUtmTnJWUVM3eTNZem1qN2dlQVhiN1R5MG9OZ0pJ?=
 =?utf-8?B?NFdtQjRWUzlkelFZY003clJFeDFJK2VjTVRKMFFxZGRJRkFTZzVNRk9lL2JL?=
 =?utf-8?B?bEtMZUp1RWk3WktTdW9ZcExabmVCQ1gyckdMZWdqdFJGQzV5WWFoWW95d1pD?=
 =?utf-8?B?L2lpVWl5K3pJN2hyVG14SHRoUFBIc1RzNkFQNG03c3JaUzBvb28xOWdVWWVN?=
 =?utf-8?B?NEpmUlY2L2xKK1krbFNkT29SQU8vT1VhMDNhOHF4OTFFRUVmalA2cGpiQnla?=
 =?utf-8?B?bUlOTkhKd292Ty91VHBIb0o1S0d0UDlBWXhJc3dvRklNR0JNZjVjbFdnbXZo?=
 =?utf-8?B?bVJiaXNIRHZZYWFqTmUvVGMyT1VpL3dDU2FJS2VnWExIY3J6cncwUVNpekYw?=
 =?utf-8?B?RWcyWVE2b0hSc1VDaWFkTVRwMlJMRnNNcjMvbldodG9kbTZVazAxSFljM29D?=
 =?utf-8?B?c2VtYmUyV0J3alE5QWp3ckxNL2UrL3dGZHMvN3F0d2RQejQ3dnI3R1lnOTRj?=
 =?utf-8?B?S2pFTjBEK0RqV1l4cS9Xdms3REtJZkRySXR1blJGTDVEZ0NjdkdxN2N3RkZX?=
 =?utf-8?B?clNQOTRyUExCVmE2VW4zZ3JGUS9JVEE2RTNmSnczZEhXRjVFMDRRbXQ5NFV0?=
 =?utf-8?B?VytScVdpNHNmMTZKVUdlRkZKeVZFQ1ZkTFhjQkRsTWg2bXpQbnFvcWFRTFd6?=
 =?utf-8?B?YWt5YUp4b3VQdmlsd2owa1ppMFBxa1NBNWd5S2F4UWVvbHFQaEEvUTBrSnlq?=
 =?utf-8?B?STUzaHVkL1VuRCs2TkhJZjBSNU1xYnBNWDBFc1pKaDlLVDNqeERzbldQeTRI?=
 =?utf-8?B?bC9DNzhjcTc2VjRmRmJUdzNScENvT25NZDc5b1hZdVBYSG9iSldMUzRCMEhJ?=
 =?utf-8?B?ZlpjVTFiSFBQSEp0Q0xNbFVCOWZrQXhYS3dZZFFRWG9BVnFuWE8xd1R3UTNP?=
 =?utf-8?B?SWE5dDNDdkM0SDFCR0JVbFM0V2dGOXdtd0tYRk9USXYyNndWWEI1cmRCUzNa?=
 =?utf-8?B?ajdvVWQwMm5vd0JTRkxMeG5ORWZLQW5ScGV6eS9zTGQ3T0EvVGc4OGQzVzIv?=
 =?utf-8?B?dndYQ211ZDNPTjQzN1ZwNkpGcVkrQi8xNTZQSGpkeEIzbVplcC9GVXdKMTlY?=
 =?utf-8?B?azYzM09FY3lYNGNSZEFrckdLZnFBcm0wd0wwcW1jdzhNeGR5S2FvdmFubXRU?=
 =?utf-8?B?VWZTUTZSeThWQktsbzM4RmFaS0Evdlo2ZDhMdnp1Uis1SkJKbHFpZVJsZ3du?=
 =?utf-8?B?Z09lNG02QkFSTTUzUHI3bVpabGt1VlVZSUVvOWZrTGgvS1RaNWRBT002aUtR?=
 =?utf-8?B?cEtiblJjQlByRmd1a2dJY2pJUlltYk5kQUFleUpRb1F4MGVOS0N5RytNa0pq?=
 =?utf-8?B?TTBFME9TK3FOSm5CbzRBN0FLK0dCdGVWaXVJQ0VBclFIQmh4d0VKY2Y5OXdM?=
 =?utf-8?B?TTVRM1lsNEdFNnVEaHRnbGdod21SZURZVDk5aktZOUVHdTcrNXdhTjQyMXRy?=
 =?utf-8?B?eUJReGo5MXE2YXErbW9NTUw1UXNjdjhwcFp1dVhIbmFmODhyaTV3ajh1MndF?=
 =?utf-8?B?bEZuTTVBV0dVMGxpN3pKQ3lDWDZqQzNSZ2EzUzc0WXVVR0c0MUNETXo4STZX?=
 =?utf-8?B?Y2dldlljTWZLRWpvZVg5RmM4UGlhSDc1NkZ6c0lWRmUwK2VjVlBFUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df191849-8754-4440-5cf6-08dec24f4fe3
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 15:38:23.3799 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aDWef5M8cH7dwhHPb7Asjxl6l0aV+zgs1ojBRl6i4jleUsNG4uZxjMtTl1F9e0VS4zfT8iYMbgQ9NJYZXe9lTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR12MB999200
Received-SPF: permerror client-ip=2a01:111:f403:c110::3;
 envelope-from=avihaih@nvidia.com;
 helo=BN8PR05CU002.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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


On 6/4/2026 6:21 PM, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Thu, Jun 04, 2026 at 06:12:11PM +0300, Avihai Horon wrote:
>> On 6/3/2026 10:47 PM, Peter Xu wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Tue, Jun 02, 2026 at 12:26:09PM +0300, Avihai Horon wrote:
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
>>>>    migration/migration.c | 11 +++++++----
>>>>    1 file changed, 7 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/migration/migration.c b/migration/migration.c
>>>> index 074d3f2c69..7488a94206 100644
>>>> --- a/migration/migration.c
>>>> +++ b/migration/migration.c
>>>> @@ -2814,7 +2814,7 @@ static bool migration_switchover_start(MigrationState *s, Error **errp)
>>>>        return true;
>>>>    }
>>>>
>>>> -static int migration_completion_precopy(MigrationState *s)
>>>> +static int migration_completion_precopy(MigrationState *s, Error **errp)
>>>>    {
>>>>        int ret;
>>>>
>>>> @@ -2823,11 +2823,12 @@ static int migration_completion_precopy(MigrationState *s)
>>>>        if (!migrate_mode_is_cpr()) {
>>>>            ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
>>>>            if (ret < 0) {
>>>> +            error_setg_errno(errp, -ret, "Failed to stop the VM");
>>>>                goto out_unlock;
>>>>            }
>>>>        }
>>>>
>>>> -    if (!migration_switchover_start(s, NULL)) {
>>>> +    if (!migration_switchover_start(s, errp)) {
>>>>            ret = -EFAULT;
>>>>            goto out_unlock;
>>>>        }
>>> IIUC this patch overlooked the follow up call:
>>>
>>>       ret = qemu_savevm_state_complete_precopy(s);
>>>
>>> We should make sure ret!=0 will always set Error*.  Better pass Error**
>>> into qemu_savevm_state_complete_precopy() too.
>> Yes, that was intentional, because this requires more plumbing in
>> qemu_savevm_state_complete_precopy() (as mentioned in the commit message).
>> Although not clean, I thought it was OK to do this one-time exception since
>> we explicitly check for local_err in migration_completion().
>>
>> I can give it a shot and try adding Error **errp to
>> qemu_savevm_state_complete_precopy(), but I think it'll be opening a can of
>> worms.
>> Do you have any thoughts?
> If we want to keep the min change, we can consider setting errp at least
> when qemu_savevm_state_complete_precopy() returned non-zero in the path of
> migration_completion_precopy(), to make sure errp is always set when error
> happened.  Otherwise it's error prone.

OK, I'll see how that works.

Thanks.

>
> Thanks,
>
>> Thanks.
>>
>>> Thanks,
>>>
>>>> @@ -2869,7 +2870,7 @@ static void migration_completion(MigrationState *s)
>>>>        Error *local_err = NULL;
>>>>
>>>>        if (s->state == MIGRATION_STATUS_ACTIVE) {
>>>> -        ret = migration_completion_precopy(s);
>>>> +        ret = migration_completion_precopy(s, &local_err);
>>>>        } else if (s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
>>>>            migration_completion_postcopy(s);
>>>>        } else {
>>>> @@ -2900,7 +2901,9 @@ static void migration_completion(MigrationState *s)
>>>>        return;
>>>>
>>>>    fail:
>>>> -    if (qemu_file_get_error_obj(s->to_dst_file, &local_err)) {
>>>> +    if (local_err) {
>>>> +        migrate_error_propagate(s, local_err);
>>>> +    } else if (qemu_file_get_error_obj(s->to_dst_file, &local_err)) {
>>>>            migrate_error_propagate(s, local_err);
>>>>        } else if (ret) {
>>>>            error_setg_errno(&local_err, -ret, "Error in migration completion");
>>>> --
>>>> 2.40.1
>>>>
>>> --
>>> Peter Xu
>>>
> --
> Peter Xu
>

