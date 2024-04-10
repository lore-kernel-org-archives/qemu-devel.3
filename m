Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56C6ECD1296
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 07:57:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruSpO-0003QL-Ln; Wed, 10 Apr 2024 03:57:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yajunw@nvidia.com>) id 1ruSpN-0003P7-Ic
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 03:57:05 -0400
Received: from mail-dm6nam12on2107.outbound.protection.outlook.com
 ([40.107.243.107] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yajunw@nvidia.com>) id 1ruSpK-0001q7-PL
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 03:57:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kfSjQ2BAFc9ujtBdWCvb6PP6zOf60PxWkDInrQooXdR+/LqSbd5Da9Iy2/YD190tCiYJau43NoWEn3z1Yt6saz9EoiixDKrME2LPa/w1YswUjHacUBkn17IIOZYqIg40LT3xpCdNei7urQDSSZu4hRQ3Z/9yQzwTku6vhfaBS8FzX4IFp6mRdC/7/k+lxjzdyfR2rF+UbMMFQU52D64D+6VIv+OKc88/1Z/86eNN4AS3ScKwEVbCwZPFYq6dmqM7zZ2sCb43RFbvCGBHBgqhLM4zWEepqbSHkNCipEyk2wxrnmD1eTy8V45fDqSx3D4TfOOo/I41a9Dp+crH4LWYjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rxk4EHMvk8injGQD6IS4GsGUxpqPuTlEhj9/5b94KSU=;
 b=GEkl6BzqkAEG9degZgX5G+OnzHkChzpI/O0ZZT9SGN0igMm8kO8F+U9AEQpQW9Y5InxIlvHIVYTvdcOYtSvQigBBiTKwfswECiPfLgYIKJUwnAhCn/ETjukimG0toHX8GwYwEmNJ9rEECmvs52RAcLVicIgdKvRRHkMpE/i3w8Qyx+qgUu6jPV0jc22h9mm8Sl+e1q1EIJqW8yT5NR+8EvNyfC7GNbP7DUw9bPS7oo+uP4c49rpzK1hMgdj1P/aM8fE/zfa8BOa0E4QcMH3+5kMdpACYgMWYlgWckQo4oUHQaXHwZPWs9OYB/Rerd1B44DcZrP6pG+RItUUiZRIOkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxk4EHMvk8injGQD6IS4GsGUxpqPuTlEhj9/5b94KSU=;
 b=TJlE8IsQa8lH64wNM8ekL7sxUUQfLIZg1mdYNMDx0HS26VBGdWDQ8uwE/GE57L10pjGBE5tnjwMk4cie4xzaA4bfy78Pf/AKzWxbKvfj1JXaOHiwcwm5vWrRW78T4mXHSJmEK6F37AVV63cLvjFmvZOuV4x78sTPyBsg8lEZlUVsKAfnB6plcHEwwJ1mqR/i5c2s2Sd9rAUilw5QYixbr90HaB1f0Z8fYJiVPSCF06s7ln4DX/JhI8hne77w1PyE2f8hCu4sK1P3ZkvZ8ZwU/avTqmtX+fGqycLktVtNBmhNzAWIFUAsn0ZY+tje2Sc4kTZJIt68WuAP6loZh15hnw==
Received: from DM4PR12MB5168.namprd12.prod.outlook.com (2603:10b6:5:397::8) by
 CH3PR12MB8257.namprd12.prod.outlook.com (2603:10b6:610:121::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 07:51:55 +0000
Received: from DM4PR12MB5168.namprd12.prod.outlook.com
 ([fe80::a69:16d9:139b:efb5]) by DM4PR12MB5168.namprd12.prod.outlook.com
 ([fe80::a69:16d9:139b:efb5%4]) with mapi id 15.20.7409.053; Wed, 10 Apr 2024
 07:51:51 +0000
Content-Type: multipart/alternative;
 boundary="------------gMyzBj7MIBsoPaz9aNFQ75ot"
Message-ID: <f86d6159-5610-476c-a69e-cd3a717f9e40@nvidia.com>
Date: Wed, 10 Apr 2024 15:51:41 +0800
User-Agent: Mozilla Thunderbird
From: Yajun Wu <yajunw@nvidia.com>
Subject: Re: vhost-user-blk reconnect issue
To: Li Feng <fengli@smartx.com>, Stefano Garzarella <sgarzare@redhat.com>,
 "raphael.norwitz@nutanix.com" <raphael.norwitz@nutanix.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9_e?= <alex.bennee@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>
References: <DM4PR12MB5168C0DB5E4B8F30B47738F6B6362@DM4PR12MB5168.namprd12.prod.outlook.com>
 <vzwqswsxtiios4mzwab4br2utyrclkfsluwyvyw6r7gqnx55fv@z3rsaj4hs6cz>
 <add17160-7b47-4af0-908c-9c0617720cc2@nvidia.com>
 <70EC669B-52F8-408B-866B-9AFFB7EBAE96@smartx.com>
 <a6f3a386-4c65-4bc6-8d21-70b741919bff@nvidia.com>
 <F5C793A7-414C-47B0-9098-37D11F115917@smartx.com>
Content-Language: en-US
In-Reply-To: <F5C793A7-414C-47B0-9098-37D11F115917@smartx.com>
X-ClientProxiedBy: SI2PR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:4:197::6) To DM4PR12MB5168.namprd12.prod.outlook.com
 (2603:10b6:5:397::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5168:EE_|CH3PR12MB8257:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: raBP9uCRA5vgHduGbmhPB1yzAKyW0T741IamurM5TPRYE7n1bKnt8YRNkBOYbQ+Vcaiz8tY9Klna4vgqu8b3NWNkZbKh6UQEu1QhoNCsVyRLk86Ba7RaVWy1BCzYmtun8drVlVsauD8r/JdPl6/KXNUmYLVDftd/BkeL+G3TsehZJeXli5hKjshw9cTwF3xBMYoLyP+8t02QYFSgqO4XA82C4DibpXKFhp7s/CiZinVFrbd+OCyOtZyaa2OAmr7bdyoLzm3eQU4KZO+VJpMvJyTju1a31vOLHgDh5laX1NP4cibuWeovQm8czK8oWEPqEqnYNxLFvq8SjSn/eoGsuKsUapVInbeHFIVLZ/B/DsczCFZaf7BJGYU3Pd8iLSVaPs/4ey4H7dpgYjx1nYV/Sjmmw+/UKzBycyZz6RtYyB1MLtk0DtNnNL2sZxRBU7N+qUbKvMCrCPh/gyP/saOiSBoOYEEkdE5k1W1ZwuFLKoP3ch2oSrUdFxSt3Gmqg0Ea0KSqt3imRXmuo4ToyJ7TlEjnoPG47HvTdQXwv8qHxZnuFiKftH4kp8cNuSaDQqyVcoboUlJZKX5Oiu5Rof3jEY3CjkuUuxvufAg889RPvM2U0MqlYmc3HvTwrimsGjZG3VKfMEzOs9yG3r1NGyxnihnNPo8Yw2xVGU0Oj4BxC6ZHq+ni8XgJ5n9/45Hj3RuMhzL/uvVEjlMmrP9chPyn/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5168.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(4143199003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzZVd0hGTnpQWGR0clAwTmJkSUlyU0lZeWUwQnl1bDZEZnFjbmJCWGhjcWgz?=
 =?utf-8?B?bVdCQnNRRkFYRHF3UXNzVUtmUktNRjR4a0pGQ01UcVpuSWJHVXBpMzVmamdr?=
 =?utf-8?B?Sk1pZFZqdVNDNHlveGhydDF6Y1NiTGo3aUNkU2twQldGWWxUWU1ZV0RuU3Aw?=
 =?utf-8?B?ZTRVUm9kVHorbVlTL0lwRG5CUUpmSkoxVkhMckZjL2lsb2ZMUWZVM1JsV0s3?=
 =?utf-8?B?eEMwSUFXUVdaZDJZR0o5azhBaHJodkRMUkh1RXJTMy92endlN3dsdWY4R1RG?=
 =?utf-8?B?aXdjbEZuKzVhVTVBakwxQjd5UFdYcFVqbmxMRjNXRE9GSUFwUVRGR09KT2Js?=
 =?utf-8?B?R2ZEL3R0Q1kyZXZwbk8zVkV5d0hPY2MrNGFqMFN0UjlxNlZFanllcXgvbzF3?=
 =?utf-8?B?L1liK0hvOVVQR2QzZWpDMHdzQWZIUkg0eFJMQ205VjFsVzRQK1NnWk1VSGNj?=
 =?utf-8?B?eTVab3hTTFR6YWk0dDdBd0NjeDhTVmxjd0d6TS9aaExHNERudDVvNmFzM2c0?=
 =?utf-8?B?Vm14cUNlbU92WmFZTEpjTkRrUkdQTzJJazlSZnZyUEFnL0dpSm9vZU9jQU05?=
 =?utf-8?B?NU5LdE42UGRiVWRtdHRaSG5vcDRhaWJnWjFZdHNDT05BOFFiMEpuQ09CQVFI?=
 =?utf-8?B?V21PTWtEaG41bmM5WUhlOWdyNitLM2RRb2xGMEVRYzVkaC9lVDE5dUUvLzVl?=
 =?utf-8?B?YnhoMS9YcU1MelJRVTYrMXdVcDVPSms3ZUpzQS9sY2xBZlhjQWhPczJ0MFAv?=
 =?utf-8?B?N0MwbE5MNEt2eitveVpMKzR1b2VYWWhoK1BvVEh0NEhXMS84ZXJ3OWVVTjBa?=
 =?utf-8?B?US9FeVRQdjhEall0aGlNVlBMR3FhMytQMDRzdHpPVWVINktZRTNGRkRWQXpS?=
 =?utf-8?B?VXQyNVlqeStuV0tSMFFZSlZKWDBMUFNUc1h6a2U3NVBSUXF5cjdWMUxraGIz?=
 =?utf-8?B?eENWSTM2K2JSVnhqdmJIRzlQRU13T2pEYS8xdWpKVXVwbUhjUEFMYTAxU21B?=
 =?utf-8?B?VkpmalV1MXhIY2tzL0IwdE5WdHAzT0h5NUNWRTJBc2ZMb3hTMHRuZXN4c0FL?=
 =?utf-8?B?ajBKTlFVSUNNK1dSd2RubEUwbFdLZEl1MU9ic2wzaG5IMnBybTVNak1NRjlW?=
 =?utf-8?B?VC9pODdNN1RldGlGTnRRdDNTc21ab29lZUZsQk05RThLWUJmUXR0cmxHMC9G?=
 =?utf-8?B?NWMyTTFEUUZpSkNFZjYyajRSbHJ6YWdjK0hTZnZoRHlnNkNFaGxnRi9DbzN6?=
 =?utf-8?B?STQwTjUyQ0RVUnZsMzYvanVXMjhRRktJYis4Nks5WFBYNHI5RXFVWGNoMllk?=
 =?utf-8?B?UnBGS1NDRGZYbGpldHR4VVNCRXNWdjdsRTNKRXZ5OUpxOHJ2bjZCZHpQeVNo?=
 =?utf-8?B?SEN3em5tdi9FVDczMVRRQ2labURYVzV0VzRaaHNjeTNlOFZsNkl6cVByN0tW?=
 =?utf-8?B?OHQ5TW9wNXcwT1Y1TVZUYlQ0OHlaZ2tKZlZsU0tYS3VIL0c5cFoyMGpOeE5h?=
 =?utf-8?B?aWNjbTI4eDB0YkVoZW1MRlVqZDQ4RmxoTGltZGNkQUtFM2tsN2gzcUR4MDlW?=
 =?utf-8?B?N3VwM3lMNDVZY042bnVhRFFYdVNpcUZjY0ZqeWFRTHU1ZEtaZXNIK3VVZXB0?=
 =?utf-8?B?bDF1ZDgrbW1kZ1VXei9URlQ0SUxNMjB1Zk5Fb2tKN1BGbUxTWGVEYUVTZ1lq?=
 =?utf-8?B?ZUx6aU5hWFg5am5yTjZldlY3dU1Hb0ppMW1zOUlNditFOHozeldISzBxS0VN?=
 =?utf-8?B?VkxsWmdlMDFzK0tsT2R1NUsyNGxqbGhMV3pZUmZBZGVpUkFkdUR1QjBCZGpl?=
 =?utf-8?B?TVdxMVU2aFNPUE1LbFdiWE9sQzQxRXdDVno2ejRtUHpKSzlyZFh4YUVYT1g4?=
 =?utf-8?B?UHdTdXBxOEtBQ3RscjJ2OXNISEdEcWU1V1lPNHpmYVlEQ0V2YmJIRG9PaXNs?=
 =?utf-8?B?M2xiSVhsOVhJRXIvaWZqMEkvcHNVV3YxVlRsRkpiS042d1FtWmlDZGVWZDZo?=
 =?utf-8?B?Q1JZdWhjdGtZNkNoSGdSYk55RzJVN2d0cG94aTlVeHJpdFcyd1NPRVdzZUNv?=
 =?utf-8?B?Q0FpeDBXUDVHNUNGVWJrMU9GOTFNTHdYN1U0OXdIUVlYV0E0Q1lhSEduOFk5?=
 =?utf-8?Q?5A5ZnZO+Ig4NuBnENZTt3EC5c?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e64634-d988-488e-dbcc-08dc593314cc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5168.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 07:51:51.1245 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nFZyf/WSXSQwkm92ueyBDmL/WBizY/EJ46+iE3Jvnfz8Nno58Rs6FIKdHfNrB2QmukPmHXrBJE0WB2wOJcP63w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8257
Received-SPF: softfail client-ip=40.107.243.107;
 envelope-from=yajunw@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.701,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_REMOTE_IMAGE=0.01 autolearn=ham autolearn_force=no
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

--------------gMyzBj7MIBsoPaz9aNFQ75ot
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/2/2024 4:44 PM, Li Feng wrote:
> *External email: Use caution opening links or attachments*
>
>
>
> Hi,
>
> I tested it today and there is indeed a problem in this scenario.
> It seems that the first version of the patch is the best and can 
> handle all scenarios.
> With this patch, the previously merged patches are no longer useful.
>
>
> I will revert this patch and submit a new fix. Do you have any comments?
>
> Revert: 
> https://lore.kernel.org/all/a68c0148e9bf105f9e83ff5e763b8fcb6f7ba9be.1697644299.git.mst@redhat.com/ 
> <https://lore.kernel.org/all/a68c0148e9bf105f9e83ff5e763b8fcb6f7ba9be.1697644299.git.mst@redhat.com/>
> New: 
> https://lore.kernel.org/all/20230804052954.2918915-2-fengli@smartx.com/ 
> <https://lore.kernel.org/all/20230804052954.2918915-2-fengli@smartx.com/>

Looks good to me.

Thanks,

Yajun

>
> Thanks,
> Li
>
>> 2024年4月1日 16:43，Yajun Wu <yajunw@nvidia.com> 写道：
>>
>>
>> On 4/1/2024 4:34 PM, Li Feng wrote:
>>> *External email: Use caution opening links or attachments*
>>>
>>>
>>> Hi yajun,
>>>
>>> I have submitted a patch to fix this problem a few months ago, but 
>>> in the end this solution was not accepted and other solutions
>>> were adopted to fix it.
>>>
>>> [PATCH 1/2] vhost-user: fix lost reconnect - Li Feng 
>>> <https://lore.kernel.org/all/20230804052954.2918915-2-fengli@smartx.com/>
>>> lore.kernel.org 
>>> <https://lore.kernel.org/all/20230804052954.2918915-2-fengli@smartx.com/>
>>> 	<https://lore.kernel.org/all/20230804052954.2918915-2-fengli@smartx.com/>
>>>
>>> <https://lore.kernel.org/all/20230804052954.2918915-2-fengli@smartx.com/>
>>>
>> I think this fix is valid.
>>
>>> This is the merged fix:
>>>
>>>
>>> [PULL 76/83] vhost-user: fix lost reconnect - Michael S. Tsirkin 
>>> <https://lore.kernel.org/all/a68c0148e9bf105f9e83ff5e763b8fcb6f7ba9be.1697644299.git.mst@redhat.com/>
>>> lore.kernel.org 
>>> <https://lore.kernel.org/all/a68c0148e9bf105f9e83ff5e763b8fcb6f7ba9be.1697644299.git.mst@redhat.com/>
>>> 	<https://lore.kernel.org/all/a68c0148e9bf105f9e83ff5e763b8fcb6f7ba9be.1697644299.git.mst@redhat.com/>
>>>
>>> <https://lore.kernel.org/all/a68c0148e9bf105f9e83ff5e763b8fcb6f7ba9be.1697644299.git.mst@redhat.com/>
>>
>> My tests are with this fix, failed in the two scenarios I mentioned.
>>
>>>
>>> Thanks,
>>> Li
>>>
>>>> 2024年4月1日 10:08，Yajun Wu <yajunw@nvidia.com> 写道：
>>>>
>>>>
>>>> On 3/27/2024 6:47 PM, Stefano Garzarella wrote:
>>>>> External email: Use caution opening links or attachments
>>>>>
>>>>>
>>>>> Hi Yajun,
>>>>>
>>>>> On Mon, Mar 25, 2024 at 10:54:13AM +0000, Yajun Wu wrote:
>>>>>> Hi experts,
>>>>>>
>>>>>> With latest QEMU (8.2.90), we find two vhost-user-blk backend 
>>>>>> reconnect
>>>>>> failure scenarios:
>>>>> Do you know if has it ever worked and so it's a regression, or have we
>>>>> always had this problem?
>>>>
>>>> I am afraid this commit: "71e076a07d (2022-12-01 02:30:13 -0500) 
>>>> hw/virtio: generalise CHR_EVENT_CLOSED handling"  caused both 
>>>> failures. Previous hash is good.
>>>>
>>>> I suspect the "if (vhost->vdev)" in vhost_user_async_close_bh is 
>>>> the cause, previous code doesn't have this check?
>>>>
>>>>>
>>>>> Thanks,
>>>>> Stefano
>>>>>
>>>>>> 1. Disconnect vhost-user-blk backend before guest driver probe 
>>>>>> vblk device, then reconnect backend after guest driver probe 
>>>>>> device. QEMU won't send out any vhost messages to restore backend.
>>>>>> This is because vhost->vdev is NULL before guest driver probe 
>>>>>> vblk device, so vhost_user_blk_disconnect won't be called, 
>>>>>> s->connected is still true. Next vhost_user_blk_connect will 
>>>>>> simply return without doing anything.
>>>>>>
>>>>>> 2. modprobe -r virtio-blk inside VM, then disconnect backend, 
>>>>>> then reconnect backend, then modprobe virtio-blk. QEMU won't send 
>>>>>> messages in vhost_dev_init.
>>>>>> This is because rmmod will let qemu call vhost_user_blk_stop, 
>>>>>> vhost->vdev also become NULL(in vhost_dev_stop), 
>>>>>> vhost_user_blk_disconnect won't be called. Again s->connected is 
>>>>>> still true, even chr connect is closed.
>>>>>>
>>>>>> I think even vhost->vdev is NULL, vhost_user_blk_disconnect 
>>>>>> should be called when chr connect close?
>>>>>> Hope we can have a fix soon.
>>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>> Yajun
>>>>>>
>>>
>
--------------gMyzBj7MIBsoPaz9aNFQ75ot
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class=3D"moz-cite-prefix">On 4/2/2024 4:44 PM, Li Feng wrote:<br>
    </div>
    <blockquote type=3D"cite" cite=3D"mid:F5C793A7-414C-47B0-9098-37D11F115=
917@smartx.com">
     =20
      <table border=3D"1" bgcolor=3D"#FFEB9C">
        <tbody>
          <tr>
            <td><font size=3D"1" face=3D"verdana" color=3D"black"><b>Extern=
al
                  email: Use caution opening links or attachments</b> </fon=
t></td>
          </tr>
        </tbody>
      </table>
      <br>
      <div><br>
        <div>
          <div>Hi,</div>
          <div><br>
          </div>
          <div>I tested it today and there is indeed a problem in this
            scenario.</div>
          <div>It seems that the first version of the patch is the best
            and can handle all scenarios.</div>
          <div>With this patch, the previously merged patches are no
            longer useful.</div>
          <div><br>
          </div>
          <div><br>
          </div>
          <div>I will revert this patch and submit a new fix. Do you
            have any comments?</div>
          <div><br>
          </div>
          <div>
            <div>Revert:&nbsp;<a href=3D"https://lore.kernel.org/all/a68c01=
48e9bf105f9e83ff5e763b8fcb6f7ba9be.1697644299.git.mst@redhat.com/" original=
src=3D"https://lore.kernel.org/all/a68c0148e9bf105f9e83ff5e763b8fcb6f7ba9be=
.1697644299.git.mst@redhat.com/" shash=3D"UWtGHqxMNWjXyxwxch30fJB+PFvIMk4bd=
p7JgoWm1XG9uY/qqvKAdvGS9lp6nRrCqGPRj87hQ/wCXaH8XC2FLEwLkO8R97z9XkK7TlOBCA4P=
EuLQlqHCGe90O6zvtWYyY/wHfYUKe4G6AeKCJii1bID4Z+xgoKJzfp/QbwZqQbk=3D" moz-do-=
not-send=3D"true">https://lore.kernel.org/all/a68c0148e9bf105f9e83ff5e763b8=
fcb6f7ba9be.1697644299.git.mst@redhat.com/</a></div>
            <div>New:&nbsp;<a href=3D"https://lore.kernel.org/all/202308040=
52954.2918915-2-fengli@smartx.com/" originalsrc=3D"https://lore.kernel.org/=
all/20230804052954.2918915-2-fengli@smartx.com/" shash=3D"KLlUXnW5vGR3hj1FE=
6XDx3NZETH/WOt9u8iAfkzRtql2JkXsMvRrZP+erNN3AYsdZCI+8CkBnV6y7kKgnTeJLCusMTah=
TIgz4R1NWh61MoRQzLYevfxDW/Hq28EcBS5EuCv6vZLXwZMnMRSYOMlfWBzkvOEGAG6icETkG+u=
gQq8=3D" moz-do-not-send=3D"true">https://lore.kernel.org/all/2023080405295=
4.2918915-2-fengli@smartx.com/</a></div>
          </div>
        </div>
      </div>
    </blockquote>
    <p>Looks good to me.</p>
    <p>Thanks,</p>
    <p>Yajun<br>
    </p>
    <blockquote type=3D"cite" cite=3D"mid:F5C793A7-414C-47B0-9098-37D11F115=
917@smartx.com">
      <div>
        <div>
          <div>
            <div><br>
            </div>
            <div>Thanks,</div>
            <div>Li</div>
          </div>
          <div><br>
          </div>
          <blockquote type=3D"cite">
            <div>2024=E5=B9=B44=E6=9C=881=E6=97=A5 16:43=EF=BC=8CYajun Wu <=
a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:yajunw@nvidia.com">&lt;yaj=
unw@nvidia.com&gt;</a>
              =E5=86=99=E9=81=93=EF=BC=9A</div>
            <br class=3D"Apple-interchange-newline">
            <div>
              <div>
                <p><br>
                </p>
                <div class=3D"moz-cite-prefix">On 4/1/2024 4:34 PM, Li
                  Feng wrote:<br>
                </div>
                <blockquote type=3D"cite" cite=3D"mid:70EC669B-52F8-408B-86=
6B-9AFFB7EBAE96@smartx.com">
                  <table border=3D"1" bgcolor=3D"#FFEB9C">
                    <tbody>
                      <tr>
                        <td><font size=3D"1" face=3D"verdana"><b>External
                              email: Use caution opening links or
                              attachments</b> </font></td>
                      </tr>
                    </tbody>
                  </table>
                  <br>
                  <div>
                    <div style=3D"overflow-wrap: break-word; -webkit-nbsp-m=
ode: space; line-break: after-white-space;">
                      <div style=3D"overflow-wrap: break-word; -webkit-nbsp=
-mode: space; line-break: after-white-space;">
                        <div style=3D"overflow-wrap: break-word; -webkit-nb=
sp-mode: space; line-break: after-white-space;">
                          Hi yajun,
                          <div><br>
                          </div>
                          <div>I have submitted a patch to fix this
                            problem a few months ago, but in the end
                            this solution was not accepted and other
                            solutions</div>
                          <div>were adopted to fix it.</div>
                          <div><br>
                          </div>
                          <div>
                            <div style=3D"display: block;">
                              <div style=3D"-webkit-user-select: all; -webk=
it-user-drag: element; display: inline-block;" class=3D"apple-rich-link" dr=
aggable=3D"true" role=3D"link" data-url=3D"https://lore.kernel.org/all/2023=
0804052954.2918915-2-fengli@smartx.com/">
                                <a style=3D"border-radius:10px;font-family:=
-apple-system, Helvetica, Arial, sans-serif;display:block;-webkit-user-sele=
ct:none;width:300px;user-select:none;-webkit-user-modify:read-only;user-mod=
ify:read-only;overflow:hidden;text-decoration:none;" class=3D"lp-rich-link"=
 rel=3D"nofollow" href=3D"https://lore.kernel.org/all/20230804052954.291891=
5-2-fengli@smartx.com/" originalsrc=3D"https://lore.kernel.org/all/20230804=
052954.2918915-2-fengli@smartx.com/" shash=3D"dJeSMrwvzU/0gbzRPKFjowAYNGuQp=
m0FPQt25B42+/Lbu4trISe0qFnq99Zhj0GTmgG287vsUNUPkv2AjRm0nQcKJJ47qMSYScCJu3h1=
L0UUxw6sOM7kQ7mll+IC3538dkT263XQ0jmcSeL996jF93nKZXkxOMusZsaTt24kioE=3D" dir=
=3D"ltr" role=3D"button" draggable=3D"false" width=3D"300" moz-do-not-send=
=3D"true">
                                  <table style=3D"table-layout:fixed;border=
-collapse:collapse;width:300px;background-color:#E5E6E9;font-family:-apple-=
system, Helvetica, Arial, sans-serif;" class=3D"lp-rich-link-emailBaseTable=
" width=3D"300" cellspacing=3D"0" cellpadding=3D"0" border=3D"0">
                                    <tbody>
                                      <tr>
                                        <td vertical-align=3D"center">
                                          <table style=3D"font-family:-appl=
e-system, Helvetica, Arial, sans-serif;table-layout:fixed;background-color:=
rgba(229, 230, 233, 1);" class=3D"lp-rich-link-captionBar" width=3D"300" ce=
llspacing=3D"0" cellpadding=3D"0" bgcolor=3D"#E5E6E9">
                                            <tbody>
                                              <tr>
                                                <td style=3D"padding:8px 0p=
x 8px 0px;" class=3D"lp-rich-link-captionBar-textStackItem">
                                                  <div style=3D"max-width:1=
00%;margin:0px 16px 0px 16px;overflow:hidden;" class=3D"lp-rich-link-captio=
nBar-textStack">
                                                    <div style=3D"word-wrap=
:break-word;font-weight:500;font-size:12px;overflow:hidden;text-overflow:el=
lipsis;text-align:left;" class=3D"lp-rich-link-captionBar-textStack-topCapt=
ion-leading"> <a rel=3D"nofollow" href=3D"https://lore.kernel.org/all/20230=
804052954.2918915-2-fengli@smartx.com/" originalsrc=3D"https://lore.kernel.=
org/all/20230804052954.2918915-2-fengli@smartx.com/" shash=3D"T/dIPD2ox25jJ=
gu//nafHyacY7iHWXgoGE4q/qoXX5ZdigBWNs8LtD+lf0uCkNOw6mzkQEjNiaR0fJGC3FSAcGCs=
xjJ6bFN/qK15PPteE8kA82huNLXAMxQ52NkP2Lj6hmyGCbSqk4SR0eIlE7SXCXxGPJnJKbcnzeY=
z+B+hKAc=3D" style=3D"text-decoration: none" draggable=3D"false" moz-do-not=
-send=3D"true"><font style=3D"" color=3D"#272727">[PATCH 1/2] vhost-user: f=
ix lost reconnect - Li Feng</font></a></div>
                                                    <div style=3D"word-wrap=
:break-word;font-weight:400;font-size:11px;overflow:hidden;text-overflow:el=
lipsis;text-align:left;" class=3D"lp-rich-link-captionBar-textStack-bottomC=
aption-leading"> <a rel=3D"nofollow" href=3D"https://lore.kernel.org/all/20=
230804052954.2918915-2-fengli@smartx.com/" originalsrc=3D"https://lore.kern=
el.org/all/20230804052954.2918915-2-fengli@smartx.com/" shash=3D"Meiu/nQ1d2=
27893E02NjXizFTpc/rVQ7alpATrreeekd2mwLZJDreriUSAUa62OGKTVsFcP4DdLhQv+zZrXla=
U2Yv2RcPGuI456kgfxtYQlJDXn6+Q73OjGPxrEX480baA8w+vkEVbE9IbaNBUQFUs7WLuoQ20ey=
XvXPME3Y4EA=3D" style=3D"text-decoration: none" draggable=3D"false" moz-do-=
not-send=3D"true"><font style=3D"" color=3D"#808080">lore.kernel.org</font>=
</a></div>
                                                  </div>
                                                </td>
                                                <td style=3D"padding:0px 12=
px 0px 0px;" class=3D"lp-rich-link-captionBar-rightIconItem" width=3D"36"> =
<a rel=3D"nofollow" href=3D"https://lore.kernel.org/all/20230804052954.2918=
915-2-fengli@smartx.com/" originalsrc=3D"https://lore.kernel.org/all/202308=
04052954.2918915-2-fengli@smartx.com/" shash=3D"eHuocqu+W8vscDPv06xbyDHGWrn=
1KDf4zQZXfadZjHOQRs6AudZERpqMDanscjdWmObZRWOPKjnLcm9EJuHHlEuKmZFrlWXKXwttsT=
kVLu5G1YDGZwgWSm7p/wuqhmsWqXyOHlkrgkYqGGlOR2iAoHpxsdkVOMseyVwbzOSxXkc=3D" d=
raggable=3D"false" moz-do-not-send=3D"true"><img src=3D"data:image/png;base=
64,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
C/eeBfPdm2eoBKnHEAAAAASUVORK5CYII=3D" draggable=3D"false" style=3D"pointer-=
events:none !important;display:inline-block;width:36px;height:36px;" class=
=3D"lp-rich-link-captionBar-rightIcon" moz-do-not-send=3D"true" width=3D"36=
" height=3D"36"></a></td>
                                              </tr>
                                            </tbody>
                                          </table>
                                        </td>
                                      </tr>
                                    </tbody>
                                  </table>
                                </a></div>
                            </div>
                            <div><br>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </blockquote>
                <p>I think this fix is valid.<br>
                </p>
                <blockquote type=3D"cite" cite=3D"mid:70EC669B-52F8-408B-86=
6B-9AFFB7EBAE96@smartx.com">
                  <div>
                    <div style=3D"overflow-wrap: break-word; -webkit-nbsp-m=
ode: space; line-break: after-white-space;">
                      <div style=3D"overflow-wrap: break-word; -webkit-nbsp=
-mode: space; line-break: after-white-space;">
                        <div style=3D"overflow-wrap: break-word; -webkit-nb=
sp-mode: space; line-break: after-white-space;">
                          <div> This is the merged fix:</div>
                          <div><br>
                          </div>
                          <div><br>
                          </div>
                          <div>
                            <div style=3D"display: block;">
                              <div style=3D"-webkit-user-select: all; -webk=
it-user-drag: element; display: inline-block;" class=3D"apple-rich-link" dr=
aggable=3D"true" role=3D"link" data-url=3D"https://lore.kernel.org/all/a68c=
0148e9bf105f9e83ff5e763b8fcb6f7ba9be.1697644299.git.mst@redhat.com/">
                                <a style=3D"border-radius:10px;font-family:=
-apple-system, Helvetica, Arial, sans-serif;display:block;-webkit-user-sele=
ct:none;width:300px;user-select:none;-webkit-user-modify:read-only;user-mod=
ify:read-only;overflow:hidden;text-decoration:none;" class=3D"lp-rich-link"=
 rel=3D"nofollow" href=3D"https://lore.kernel.org/all/a68c0148e9bf105f9e83f=
f5e763b8fcb6f7ba9be.1697644299.git.mst@redhat.com/" originalsrc=3D"https://=
lore.kernel.org/all/a68c0148e9bf105f9e83ff5e763b8fcb6f7ba9be.1697644299.git=
.mst@redhat.com/" shash=3D"utaNja2Q8Q9/gPhwwMdDXUWXNC1mSvYV1OmeTvncz0Z3Xz9p=
TTjWke654gbraHyUr41U0zBELAVDzEr2F9k+NZfMTiyN1Kllpkf7WDXFsy5hgF0M1+RtCSc4rMU=
Ki9HuvEIGu7+988vYvULZwM+2fWkQoEVmsvDoi45kyXKImgI=3D" dir=3D"ltr" role=3D"bu=
tton" draggable=3D"false" width=3D"300" moz-do-not-send=3D"true">
                                  <table style=3D"table-layout:fixed;border=
-collapse:collapse;width:300px;background-color:#E5E6E9;font-family:-apple-=
system, Helvetica, Arial, sans-serif;" class=3D"lp-rich-link-emailBaseTable=
" width=3D"300" cellspacing=3D"0" cellpadding=3D"0" border=3D"0">
                                    <tbody>
                                      <tr>
                                        <td vertical-align=3D"center">
                                          <table style=3D"font-family:-appl=
e-system, Helvetica, Arial, sans-serif;table-layout:fixed;background-color:=
rgba(229, 230, 233, 1);" class=3D"lp-rich-link-captionBar" width=3D"300" ce=
llspacing=3D"0" cellpadding=3D"0" bgcolor=3D"#E5E6E9">
                                            <tbody>
                                              <tr>
                                                <td style=3D"padding:8px 0p=
x 8px 0px;" class=3D"lp-rich-link-captionBar-textStackItem">
                                                  <div style=3D"max-width:1=
00%;margin:0px 16px 0px 16px;overflow:hidden;" class=3D"lp-rich-link-captio=
nBar-textStack">
                                                    <div style=3D"word-wrap=
:break-word;font-weight:500;font-size:12px;overflow:hidden;text-overflow:el=
lipsis;text-align:left;" class=3D"lp-rich-link-captionBar-textStack-topCapt=
ion-leading"> <a rel=3D"nofollow" href=3D"https://lore.kernel.org/all/a68c0=
148e9bf105f9e83ff5e763b8fcb6f7ba9be.1697644299.git.mst@redhat.com/" origina=
lsrc=3D"https://lore.kernel.org/all/a68c0148e9bf105f9e83ff5e763b8fcb6f7ba9b=
e.1697644299.git.mst@redhat.com/" shash=3D"lQngmD253ejtmkCvit8DkgIu/fZvu3ku=
m17cKfTKp7kaLa4dU3wOIL6COU15fMHAaMfIv2KkOsbCS3lbVKHHXT4WAQ4lQiAyjBi3xq7Ah8t=
5RY+4zdWXoDMQ8o6Cqppfy7bXtBfigyFGBKymqHWcJ0cZd3hHIQpV0JNyYD92E9c=3D" style=
=3D"text-decoration: none" draggable=3D"false" moz-do-not-send=3D"true"><fo=
nt style=3D"" color=3D"#272727">[PULL 76/83] vhost-user: fix lost reconnect=
 - Michael S.
                                                          Tsirkin</font></a=
></div>
                                                    <div style=3D"word-wrap=
:break-word;font-weight:400;font-size:11px;overflow:hidden;text-overflow:el=
lipsis;text-align:left;" class=3D"lp-rich-link-captionBar-textStack-bottomC=
aption-leading"> <a rel=3D"nofollow" href=3D"https://lore.kernel.org/all/a6=
8c0148e9bf105f9e83ff5e763b8fcb6f7ba9be.1697644299.git.mst@redhat.com/" orig=
inalsrc=3D"https://lore.kernel.org/all/a68c0148e9bf105f9e83ff5e763b8fcb6f7b=
a9be.1697644299.git.mst@redhat.com/" shash=3D"xLYv+ZFDeUAAhS4W0F0squuTO53Cl=
D5bzm1AhOmMY2J3Yb5rbgNzTAbxC80WCcklS58nFA1vrGzb6TZp9BleEV4dVjGFXlIsQoNwqCsL=
jdYYB1JZCim+qaZHdkYsrGhD28ptC23CYYitWnf3hgNWoq/B9aSif8QvR6BhG59pQh0=3D" sty=
le=3D"text-decoration: none" draggable=3D"false" moz-do-not-send=3D"true"><=
font style=3D"" color=3D"#808080">lore.kernel.org</font></a></div>
                                                  </div>
                                                </td>
                                                <td style=3D"padding:0px 12=
px 0px 0px;" class=3D"lp-rich-link-captionBar-rightIconItem" width=3D"36"> =
<a rel=3D"nofollow" href=3D"https://lore.kernel.org/all/a68c0148e9bf105f9e8=
3ff5e763b8fcb6f7ba9be.1697644299.git.mst@redhat.com/" originalsrc=3D"https:=
//lore.kernel.org/all/a68c0148e9bf105f9e83ff5e763b8fcb6f7ba9be.1697644299.g=
it.mst@redhat.com/" shash=3D"oaqIgIv1bvQoPfffS1JsIaTaPx49nyYSe1uW4LOhswdj0F=
5AGVtUDxxwNsB4zpgD6LeyVj70zdyATSHbIO/Cp6WppWJvidA7a5cOTqRqGXJkYlKQJLW8YsMZf=
mMi6E+NWX/fbxcMOTBQM4ea0ykMLTYdG9yMn3oPjNt8xnTiq/o=3D" draggable=3D"false" =
moz-do-not-send=3D"true"><img src=3D"data:image/png;base64,iVBORw0KGgoAAAAN=
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
aa0MkU2VNcoN4J/SNoWT4gtFZ0FgQXXBq1mpsw4V6haKC9uKnIsWFz0qDi/eMRufzZ3dUmJdsqC=
kcw5rzta5yNwZc1vm2c4rm9c1P2L+rgWaC3IX/FjKKF1Z+sfCtIXNZRZl88sefhHxxZ5yWrm0/O=
Yi/0VbvsS/FH55cfHYxesXv6vgVfxQyaisqny7hLvkh688vlr31fulWUsvLvNetnk5cbl4+Y0VQ=
St2rdRdWbzy4aqJqxpW01dXrP5jzfQ156vGVW1Zq7lWsbZjXcy6xvV265evf7tBsKG9ekL1vo3m=
GxdvfLmJt+nq5uDN9VsstlRuefO18OtbWyO2NtQ41FRtI24r2PbL9tTtrTuYO+pqzWora//cKd7=
ZsStx15k6n7q63ea7l+1B9yj29OydsvfyN6HfNNa71W/dZ7Svcj/Yr9j/+EDmgRsHow+2HGIeqv=
/W/tuNh/UPVzQgDUUNfUcERzoa0xuvNEU1tTT7Nx/+zv27nUetj1YfMzy27Ljm8bLj708Un+g/K=
TnZeyr71MOW6S13T086ff1MwpmLZ6PPnvs+/PvTrazWE+cCzh0973e+6QfmD0cueF9oaPNqO/yj=
14+HL3pfbLjkc6nxsu/l5ivjrxy/GnT11LXQa99fZ1+/0B7bfuVGyo1bN6fc7LjFu9V9W3T72Z2=
COwN358OLfcV9nftVD8wf1Pxr9L/2dXh3HOsM7Wz7Kemnuw+5D5/8LPv5bVfZL9Rfqh5ZParr9u=
w+2hPec/nx5MddTyRPBnrLf9X9deNTp6ff/hb8W1vfpL6uZ9Jn739f8tz0+c4/xv3R0h/f/+BF3=
ouBlxWvTF/tes183fom7c2jgVlvSW/X/Tn6z+Z30e/uvc97//7fCQ/4Yk7kYoUAAAA4ZVhJZk1N=
ACoAAAAIAAGHaQAEAAAAAQAAABoAAAAAAAKgAgAEAAAAAQAAAEigAwAEAAAAAQAAAEgAAAAAs/l=
k1QAABadJREFUaAXtWVtoXEUY/jbdJLvbNJfG9JKWYFOv8dItUhAUbUEqTdWmD/pghBQCIiqS1M=
uDlMYrFKooqKVW7aMPgrSIYlQsiSLES7ZRa2pMtfXSeqlivMbaNcdv5uw5O3P27NlzWfTlzJJk5=
r/Nt//M/PPPHyBusQdiD8QeiD0QeyD2QFU9kIhgrRlX8HMxOrAI82nnD/yAr/AR3sYoZiLYDaFa=
j168ijyMMp88hilRH8JyCJU0tuIbCeQURjCEzbgAC1HHz0L2NpMyglOSf5yS6RAzBFLZgCNyshx=
uJoByrYXcnJQ7gg3lhKLTU9glJ5lAN5x7zygxnyCUCSm/C6kSbhUIi/E+zc9iEElaS6FHs6kDeh=
HtkpvEADUMjGOxJl2FQSemaXga2YKtOnyLcxW7KqDLcVjxYLaguUKRjtxdjqOE8x7aFEsP4XFlp=
AJ6HncoHKAVY9Q+iuUaNcIgIzfoGBo0Gx04KaOPRuRgAX3X7CA2SEg5ZBz0kMM9crGEd9RFAm7k=
5G5Nn/Zaegj0rVjyZ9zEg9K6aWhW7p0kJnFPIPUGPIe7ChpZub27A+m7CKdk3BkscNoxFQDSJZQ=
el2fSVN/Kr/Z51BAwSCMTitF2euk8F+BOUg3uxt84jdUKI4kPac36cgrDf7cex2lCd3OtD/WleI=
N6BnY4ZDeSdiKKj3ppIKfEFIf9MsPreOsLONPaTVbLUUKe194yej7IwzTbT7klPmRNkRSewpyEM=
4d1ttYyPEDP3MRxP3nDNj1gp5kJxl9ootZ+HMKtaKyofyE+lmCEf4pHvAc/4gl0Se0mWsyXxKmK=
hk2BTTQ7WpBdhxfwnbYETiMJ3CYPtgBjMDi22AIZLaSOkrvJ5gXq7KTqkKLhHgZNgTa8JIGYcAx=
cr+jp3SHKPaKT/I5epqp+p5fTvIo7xIIi/u4vJ0h6D/mvePA9WFNUNVfeQ4isnTigwZnBMg+FLs=
pOefA9WL9QVdxD3m0t/sH9zLCLHrrFU6GVkj95SpRliinqynJNRiPTii2E3WB76S3XuDVTANxEi=
wZz7lDNAlQ0VmpmL42LPGcezsAHnGrWkRGUakQAVHnJRGDYUphzHlbia2wrReCgRFiySpu6jZFp=
H30jWg2v3Dk+E81c2oFBG0bY1JWO/T7mjEvlZBfxjprDk2USNg1PpWNfo0tro085WqVR1EEf420=
/I3IK9zJBWYC1uB2/qQJKX1w/VhMWD1uDYH/Vq0NoppUcuoOv9z08T6sJJo9HPS+VJL5kqLyayy=
raCPddyKujeLkCZzHcn7QvhAQP+SSLDEOMQYdwqZzI61eGvszhTYo0ysu1eM95abnwrPTjBm7fH=
TjTlhjg4txJ35zGgwFKCouoL9KP12w7gTsiQRunVkab9nz8yUw7j4P2s9G/YRGrRF4UsqXkpble=
067lg9Gg47cpmbYmoA30Q7OempFSWDAlN+gJ8Zq32n2kjLHw4qetZPQWC2W2JBfZYIkmUkvx4aK=
+FNbgV+4eMxj6Mbwdn9iQxJeL/AwC3xwG90xWzp7GbpztB4cis53nUNTSVtGKgY0KJ3T3WRqalo=
WG1kIssUypS2nRRLy6pjhgbw1/zKf0Xo0eepDhLhL7RhQ21ZbGF0rmXORkmNR3FIfszZfFhoPVK=
jaACcYxCUlP1/q0VHRGvk9MHI/hYQWQWY45Vr1yjLDdKTf3Z1rkeVfbESqgcxhIrdQuy4RVbOZO=
BWJVuksYIkUCNlAIAm18IqlRRgUE9MmnT7Gk5/+pGQBsCk8Tkig+uFVWdUDCrFX03B3lNV8JX7f=
vsrDwp0FpN/CVZgnEF4Vz8xVmFc67eNZq+Wnho0ktnJ/4LwrnJnbxr4XXeb0KH7h98uSG/NdCIp=
B3dOEWXInL6JVOVqFFQfR3fM/INIl3uN1/1kXjUeyB2AOxB2IPxB6IPfC/eeBfPdm2eoBKnHEAA=
AAASUVORK5CYII=3D" draggable=3D"false" style=3D"pointer-events:none !import=
ant;display:inline-block;width:36px;height:36px;" class=3D"lp-rich-link-cap=
tionBar-rightIcon" moz-do-not-send=3D"true" width=3D"36" height=3D"36"></a>=
</td>
                                              </tr>
                                            </tbody>
                                          </table>
                                        </td>
                                      </tr>
                                    </tbody>
                                  </table>
                                </a></div>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </blockquote>
                <p>My tests are with this fix, failed in the two
                  scenarios I mentioned. <br>
                </p>
                <blockquote type=3D"cite" cite=3D"mid:70EC669B-52F8-408B-86=
6B-9AFFB7EBAE96@smartx.com">
                  <div>
                    <div style=3D"overflow-wrap: break-word; -webkit-nbsp-m=
ode: space; line-break: after-white-space;">
                      <div style=3D"overflow-wrap: break-word; -webkit-nbsp=
-mode: space; line-break: after-white-space;">
                        <div style=3D"overflow-wrap: break-word; -webkit-nb=
sp-mode: space; line-break: after-white-space;">
                          <div>
                            <div><br>
                            </div>
                            Thanks,</div>
                          <div>Li<br>
                            <div><br>
                              <blockquote type=3D"cite">
                                <div>2024=E5=B9=B44=E6=9C=881=E6=97=A5 10:0=
8=EF=BC=8CYajun Wu <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:yajunw=
@nvidia.com" moz-do-not-send=3D"true">
                                    &lt;yajunw@nvidia.com&gt;</a> =E5=86=99=
=E9=81=93=EF=BC=9A</div>
                                <br class=3D"Apple-interchange-newline">
                                <div>
                                  <div><br>
                                    On 3/27/2024 6:47 PM, Stefano
                                    Garzarella wrote:<br>
                                    <blockquote type=3D"cite">External
                                      email: Use caution opening links
                                      or attachments<br>
                                      <br>
                                      <br>
                                      Hi Yajun,<br>
                                      <br>
                                      On Mon, Mar 25, 2024 at 10:54:13AM
                                      +0000, Yajun Wu wrote:<br>
                                      <blockquote type=3D"cite">Hi
                                        experts,<br>
                                        <br>
                                        With latest QEMU (8.2.90), we
                                        find two vhost-user-blk backend
                                        reconnect<br>
                                        failure scenarios:<br>
                                      </blockquote>
                                      Do you know if has it ever worked
                                      and so it's a regression, or have
                                      we<br>
                                      always had this problem?<br>
                                    </blockquote>
                                    <br>
                                    I am afraid this commit: &quot;71e076a0=
7d
                                    (2022-12-01 02:30:13 -0500)
                                    hw/virtio: generalise
                                    CHR_EVENT_CLOSED handling&quot;&nbsp; c=
aused
                                    both failures. Previous hash is
                                    good.<br>
                                    <br>
                                    I suspect the &quot;if (vhost-&gt;vdev)=
&quot;
                                    in vhost_user_async_close_bh is the
                                    cause, previous code doesn't have
                                    this check?<br>
                                    <br>
                                    <blockquote type=3D"cite"><br>
                                      Thanks,<br>
                                      Stefano<br>
                                      <br>
                                      <blockquote type=3D"cite">1.
                                        Disconnect vhost-user-blk
                                        backend before guest driver
                                        probe vblk device, then
                                        reconnect backend after guest
                                        driver probe device. QEMU won't
                                        send out any vhost messages to
                                        restore backend.<br>
                                        This is because vhost-&gt;vdev
                                        is NULL before guest driver
                                        probe vblk device, so
                                        vhost_user_blk_disconnect won't
                                        be called, s-&gt;connected is
                                        still true. Next
                                        vhost_user_blk_connect will
                                        simply return without doing
                                        anything.<br>
                                        <br>
                                        2. modprobe -r virtio-blk inside
                                        VM, then disconnect backend,
                                        then reconnect backend, then
                                        modprobe virtio-blk. QEMU won't
                                        send messages in vhost_dev_init.<br=
>
                                        This is because rmmod will let
                                        qemu call vhost_user_blk_stop,
                                        vhost-&gt;vdev also become
                                        NULL(in vhost_dev_stop),
                                        vhost_user_blk_disconnect won't
                                        be called. Again s-&gt;connected
                                        is still true, even chr connect
                                        is closed.<br>
                                        <br>
                                        I think even vhost-&gt;vdev is
                                        NULL, vhost_user_blk_disconnect
                                        should be called when chr
                                        connect close?<br>
                                        Hope we can have a fix soon.<br>
                                        <br>
                                        <br>
                                        Thanks,<br>
                                        Yajun<br>
                                        <br>
                                      </blockquote>
                                    </blockquote>
                                  </div>
                                </div>
                              </blockquote>
                            </div>
                            <br>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </blockquote>
              </div>
            </div>
          </blockquote>
        </div>
        <br>
      </div>
    </blockquote>
  </body>
</html>

--------------gMyzBj7MIBsoPaz9aNFQ75ot--

