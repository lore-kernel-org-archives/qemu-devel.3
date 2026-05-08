Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA32CD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 13:07:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLKvT-0002TS-Bk; Fri, 08 May 2026 09:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wLKvQ-0002QE-Li
 for qemu-devel@nongnu.org; Fri, 08 May 2026 09:07:28 -0400
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wLKvN-0004Ms-8l
 for qemu-devel@nongnu.org; Fri, 08 May 2026 09:07:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jv0zNpkjPtdrxUCFY44U5b5ZkVcNH5r64SKOT4s9QpO3mRST9zwev4Uk75Lwo7ERXvMXJOAJqch8bCGY/oeyHqzxcb3b6uyN48L/HWIP+QEuvPc+sRobbixbBvI5nCD5MQNir92r5OPr30QmFHkutsSkVl7fW5Ja3mwu2+Dx4tOE0/O9DAxxvP4ArgHszs1LoYxlCHmjjJXf9Y52IAimHdj50oszrjGsPYfEDzl8UV7M8wPEPZO1eHEU5NDuNlj5ocD9Do3+IC/LCU2j5ISD3LsYNBtORB/Qxrgcot8w66YS/uFaPA7AvWid6dZencP8oMIvC3ifJii0orH/wK9i3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QrKmuklAMCtuPiLKFSeEZZjzaQuEc50ddQCpN19Oh1Y=;
 b=tiJpR+YRR7FAmkRqCBuhqLNNX2HkpyekvqCunkJ8PkmeG3H8x1jNzjGZs8hxXYnG3FbbMauIiSF0sZljBATtn+r57/mjhNjJaVqWPeliTdF0LcICgMrKM9UvZjD3FnpLD/oxdRVAM/kGr9ck0xc0IkQFF3r+RTf4DwqMcYTuGw7COSyt0G3pgr1lh3voruUPxDRMVwcTzBM2gxrF6t3FtLvMN6P/lJYe7Ryctyw1TQywOS3YGAQp9vsizNGvAx+RsRNfnIdPzPNRVkY+3iTQQKAEzSTFfZjihzLwZmkQQ1fpeKgDZDodt5ATX9G0tVZj/Qx6j5VpTFTRo8B+asF3GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QrKmuklAMCtuPiLKFSeEZZjzaQuEc50ddQCpN19Oh1Y=;
 b=DR29pBo/p8+jQanT/4E6BchX3zDZr+YHq0z/O7ihxPKoPEaFygAjUMlv5xvbKgUQ0Gz+s87PrgCcygqlGTdSAe0RbMzYKsHpm3FY0bLHdnMLetND70CrHXXCSnJz7RsVZmFWswi3qLzsqL6X5Ggz1dW6gscmhhcoKjmZmrGTml83hCyusixhm7mkNXTm0xd9TdgFow2OLOTMeaqPzmkLI8NPyo19HmKCkhJpdtUQC1FpE2tnE7yFOr2GrY1GHP8coePWFjnrsg5nYKBvG/rIssTCnIY3A7m4NswHYEDDZ/aCd6Jn3HYWyC8C01dI71a50ZBNWXt+t8j7QDmskJoE4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by PH7PR12MB7139.namprd12.prod.outlook.com (2603:10b6:510:1ef::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 13:07:16 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%7]) with mapi id 15.20.9846.016; Fri, 8 May 2026
 13:07:16 +0000
Message-ID: <378728f9-e771-43bb-8226-669894d66a86@nvidia.com>
Date: Fri, 8 May 2026 16:07:11 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/14] migration: Log the approver in
 qemu_loadvm_approve_switchover()
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>
References: <20260505081423.28326-1-avihaih@nvidia.com>
 <20260505081423.28326-5-avihaih@nvidia.com>
 <3de5f050-f87b-413e-b967-e51e78c5e302@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <3de5f050-f87b-413e-b967-e51e78c5e302@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0334.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::10) To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|PH7PR12MB7139:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e770411-49e7-44e7-102c-08dead02ba8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: SaWP43Vx+k4h5Hh3m1wxS5vh2EFZwHvHXMyhcMw2Jz7LQhoDTUApoV3sOeGMmI2apVCOKn+B6gcJdQPYHyIjMwqHu9bzYIwSOP9FhSGI/6M2K9xiJErscQwAQACPrkAfeVbvxVllUS0LhI3NSgbhnKUr5iuMzbMNkHQDRC5grvJcjsvDf5kK6Bx6vQkPlyDDF030fB2Vo1iPbV97sfJrTRSs68SW9ng//H+HDobm3VLIXNIF/HPgeGxRp2qw+0U3yzI5KF1S0p60gJSrxMTBUt0qvByt8I49g0OyQLAFHc42jh/tIWVpDKDVKYI4pT8OEdZK4vFxoQ21VWeTmXU4YeJ3kO514FA4Z3xmqi/nRTRw+cGz5bb1r9XowMEgN99oDMDwaBdnZexOjWJNBXYPD7P1jSy3tP8fzWKt9ZpbjYoWHKMRHxLTJSWivkAGufQA9pDZKhGG1wvNNCOMOgHS7ppmAxrcmwt28tBednaUCH/I9Ig/K0OsMzeHWYuyeEAqzj0ib/inRkrIemRArYNyIJg6MWZ7VppZ+cVUNG1d4kNRGo0iV8ba8icrOglKqTj+0x8IOJd3rNtdhoAm0lDnrvV7FbJWtHGdwRvOhinzr+rAGNnBVT9w7OzLQz6VTvPAuL5ARfsKHIsgvLeb6PmtRnquY1I5yAUd2jXYYfFgdd2fXd7mb0yMOu9FOFVvbJU7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHlXWnJxTmxzTVFGc0ttSUttcVlpcThtcHNacEt6ZHJ2M3BrcFNqRnJFL1BN?=
 =?utf-8?B?WkE4TjYxcG9CWUNRcngraC8yNkFTME03Mm96S3IrcVFKUktURGg0MEJxRlcz?=
 =?utf-8?B?eUtyeXNraEV5d3p4WHFXS3E3N2VrWFBNMkJPS293aXZVWEFJWHFEVHgrWXI4?=
 =?utf-8?B?M29jL3dVUzlNbDNxNTE2d2xVbXJXeWR3eEdkV1VoWW5kekQvYzJDWVEzNC9h?=
 =?utf-8?B?OG1rekxQeGNHa0srSE16K1ZLM0l3NzdMYW92MmlrdkhmQithVmI3cnIvMkJZ?=
 =?utf-8?B?NlFzZmFNTjdiR2FySDlPc2pTWVBUK3VKOHhNVmVRL0FlTnZpWlNoUlNicU02?=
 =?utf-8?B?WHozaGZHQmNDUTk5dlo3ZjRrSkl4R25MdjdoeVh2U2Y2N2QzRlMzMXlaUUJE?=
 =?utf-8?B?UmpSdjQ0b0ttbFQrY0lsYjJQOFF4TURBRkFqdlZvUHNrQ1BnblVBM0tZVjR1?=
 =?utf-8?B?VkdlK29CcnIzU2ZhbWN2UElBMnIxelZLNDNoT3A4bkdiaGJlV0RFK3J5dURV?=
 =?utf-8?B?ZjkyNndmaHJvUUY2NmxPNmtZTm16SGZCWndPbDBYYnN6SjFhMTd2UmhPMERn?=
 =?utf-8?B?bUgxK2FvaWM5eHZhRXBnS1RHdktYbEIwaUJqV09CNUV0akJMQS8yQVBGR3Vw?=
 =?utf-8?B?SGpwSE1ZRldIZDR2eDRVRXpURzRyMUQ1aEwrODlWeDV5Tk1OR1RRVE5YaS8w?=
 =?utf-8?B?WGkzVHVORkFwZWtBS042TVBodHhoZG9XMTB4SlVMQjJwUGxUcEovMFpFclh1?=
 =?utf-8?B?SDNwMVFiQVByUGFYZXVjNnU2OUZiTGR4TjRYaVZ6UWN1Ym1VU3daQnIzaHps?=
 =?utf-8?B?L0lGVUlENlA1emVEZDBsNnM3MURlcWNERHFwK1M2dTA5eTl4ek9Mcllsa25L?=
 =?utf-8?B?eUt2YXNqU1B0UWU5b09UdktPM05acHIrVE9jdHhwU2p6a2dLR0ZJR1RtVjZr?=
 =?utf-8?B?WWFMYTE2K1dsT3JmVEJNSFMzZnlOaGgrQXNUakpuMmE5elFaWGhaZ1FUb2dN?=
 =?utf-8?B?LzFWU0pQL3hXcHVJZjJCWE05aVFaOVpyMlY3NmxaWHROajQxUHY3aitQdWh1?=
 =?utf-8?B?OGNnYUFscklhYWZpUEZBNDRxUElRMzdCaGM5K0lMWFRuQUlXaEtTM3phUmlV?=
 =?utf-8?B?dXloYWo2SnE2M2R3ZHBKbTA0SDErN2VldnJXNXhjVXZwek5OamFrMjlZcDRy?=
 =?utf-8?B?N3JUOTc4ZGc0WUFBVWc1Q05FUi92a0ZuVjQvYWdiZmIwZzJHRDFjQm1MM2dQ?=
 =?utf-8?B?L3UrQXlEa0pjYkR4aDd2aDhxNGlqRkp3dGUrRU1BdUM5Z1pvNkZqNmorbm0r?=
 =?utf-8?B?bEtpanNCNVZKdXpaNExRcjRzWjdKMXdDSkY2QnBYVFBLYVpZd09DYnBxVXVO?=
 =?utf-8?B?RE1LUE5NYklnYU41dlVnbjRyQmYxTzhMS3BnS3FId0dqMjVQU1o5YVhJZlNv?=
 =?utf-8?B?ZUFwdzN5NitXU3JwMHVXMCt2a0svZHJtdDJEVHo1WmNuQ0JEakdReEVmU0Iv?=
 =?utf-8?B?S05BbGV2czNUamJ0Q0pnYXppbG1FeU0zTU96emZvY2NuUHJ1Y05UOVp1RWVi?=
 =?utf-8?B?Q3lvbkg0VHZMTGJtVTRHRHA0U29OT1lhdnFWYmx1WmFxMDRySFpWb3E0TDNO?=
 =?utf-8?B?RzhXRHlTdUg4bTNaQ2liR1hDdlBESEZSWmdOVVdPSlhRZW5CVjd2a2RtY0U0?=
 =?utf-8?B?dW9tY05RM3luNUVBQXk1T2xtKytzaldBSUZGSFJrditYdktFTjRsdXBXNzZN?=
 =?utf-8?B?WExYWS9kYnROMmdwcU9QK2dvbjBQODh6cnpkRXVTV1AwNFRyaWdlVlNZUFZE?=
 =?utf-8?B?WERDKzlFTStubFNVYUdKUTVIakJZQVdWSkp4NkN2QjFoYThZbjliMVB0dnlR?=
 =?utf-8?B?alFWanZhcHVJbzZPK2tzUjFOdk1veUlJU0dUNzNNN3JDVHVlbUtkR3JQY2ZW?=
 =?utf-8?B?dSsybVJ5V2p1NHF4QXZZUExNRm1GT2h3WUM3ZUxMS1lQbEpMUGY0SUtyaVJq?=
 =?utf-8?B?elJUSytXOGUyd0FuOUZhbnRPNVpDQktIdmx6UEYwaDlsZC90c25rOTZjczdz?=
 =?utf-8?B?VzFYb2F4NHVoNS9UcGREUHliOTJNWktvS3NVajRDYkRCZFM3ZEROK0ZWVHJu?=
 =?utf-8?B?a3FzVmZWTGljZzM4NXVhUHZ3Sm5jMTViMEd4cnN3MkpEYmFYeG5IK1V0RUl0?=
 =?utf-8?B?QnNMOHE4M29FZFM5Q1hEUkVHalRkQU1CeFVXcS9sZnEzbStXcjRaNkxNK0tC?=
 =?utf-8?B?ZVBIdVdsUVh0bExhVzl2b2NWMzQ3SmFpM0YzMGhSTnp2YkRMRmlZSU9oeW5H?=
 =?utf-8?B?cDRmc2gxTFRtSWZGU2ZJYkJrYTdGU2c5TGtMOGFNWHF3MFdYTnI3UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e770411-49e7-44e7-102c-08dead02ba8f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 13:07:16.6712 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H22XrwFzuZ3ROtyO38Dr+eppgZCqob1TItZy1yeRb4/9bOF+bd+Bi07ApfUATNgPPrcryfFLCVvJEeBSI9/Yww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7139
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=avihaih@nvidia.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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


On 5/7/2026 11:09 AM, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> On 5/5/26 10:14, Avihai Horon wrote:
>> Pass the device name that approved switchover to
>> qemu_loadvm_approve_switchover() and log it in the trace for debugging
>> purposes.
> hmm, isn't the trace event in vfio_load_state() enough :
>
>        trace_vfio_load_state(vbasedev->name, data);
>
> May be we can improve it instead ?
>
> Anyhow, I won't object to the change.

We could print "data" more nicely, but the main benefit from having a 
separate trace is that we can enable only switchover-ack related traces 
without getting noise from traces of the other VFIO_MIG_FLAG_*.
Plus, future switchover-ack users won't need to add a trace of their own 
and we can also log switchover_ack_pending_num.

I found it very convenient when debugging/testing this feature.

Thanks.

>
>
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>> ---
>>   migration/savevm.h     | 2 +-
>>   hw/vfio/migration.c    | 2 +-
>>   migration/savevm.c     | 4 ++--
>>   migration/trace-events | 2 +-
>>   4 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/migration/savevm.h b/migration/savevm.h
>> index 96fdf96d4e..1efbe1d79d 100644
>> --- a/migration/savevm.h
>> +++ b/migration/savevm.h
>> @@ -70,7 +70,7 @@ void 
>> qemu_loadvm_state_cleanup(MigrationIncomingState *mis);
>>   int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
>>                              Error **errp);
>>   int qemu_load_device_state(QEMUFile *f, Error **errp);
>> -int qemu_loadvm_approve_switchover(void);
>> +int qemu_loadvm_approve_switchover(const char *approver);
>>   int qemu_savevm_state_non_iterable(QEMUFile *f, Error **errp);
>>   int qemu_savevm_state_non_iterable_early(QEMUFile *f,
>>                                            JSONWriter *vmdesc,
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index 150e28656e..c3dd30d619 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -818,7 +818,7 @@ static int vfio_load_state(QEMUFile *f, void 
>> *opaque, int version_id)
>>                   return -EINVAL;
>>               }
>>
>> -            ret = qemu_loadvm_approve_switchover();
>> +            ret = qemu_loadvm_approve_switchover(vbasedev->name);
>>               if (ret) {
>>                   error_report(
>>                       "%s: qemu_loadvm_approve_switchover failed, 
>> err=%d (%s)",
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index d1dd696c17..bd8c6ada5a 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -3158,7 +3158,7 @@ int qemu_load_device_state(QEMUFile *f, Error 
>> **errp)
>>       return 0;
>>   }
>>
>> -int qemu_loadvm_approve_switchover(void)
>> +int qemu_loadvm_approve_switchover(const char *approver)
>>   {
>>       MigrationIncomingState *mis = migration_incoming_get_current();
>>
>> @@ -3167,7 +3167,7 @@ int qemu_loadvm_approve_switchover(void)
>>       }
>>
>>       mis->switchover_ack_pending_num--;
>> - trace_loadvm_approve_switchover(mis->switchover_ack_pending_num);
>> +    trace_loadvm_approve_switchover(approver, 
>> mis->switchover_ack_pending_num);
>>
>>       if (mis->switchover_ack_pending_num) {
>>           return 0;
>> diff --git a/migration/trace-events b/migration/trace-events
>> index de99d976ab..d9084a2692 100644
>> --- a/migration/trace-events
>> +++ b/migration/trace-events
>> @@ -24,7 +24,7 @@ loadvm_postcopy_ram_handle_discard_end(void) ""
>>   loadvm_postcopy_ram_handle_discard_header(const char *ramid, 
>> uint16_t len) "%s: %ud"
>>   loadvm_process_command(const char *s, uint16_t len) "com=%s len=%d"
>>   loadvm_process_command_ping(uint32_t val) "0x%x"
>> -loadvm_approve_switchover(unsigned int switchover_ack_pending_num) 
>> "Switchover ack pending num=%u"
>> +loadvm_approve_switchover(const char *approver, unsigned int 
>> switchover_ack_pending_num) "Approver %s, switchover_ack_pending_num %u"
>>   postcopy_ram_listen_thread_exit(void) ""
>>   postcopy_ram_listen_thread_start(void) ""
>>   qemu_savevm_send_postcopy_advise(void) ""
>

