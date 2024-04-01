Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3224CD1288
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Apr 2024 08:44:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrDGt-0002ZZ-8A; Mon, 01 Apr 2024 04:44:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yajunw@nvidia.com>) id 1rrDGr-0002Z9-8S
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 04:44:01 -0400
Received: from mail-co1nam11on20701.outbound.protection.outlook.com
 ([2a01:111:f403:2416::701]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yajunw@nvidia.com>) id 1rrDGo-0003VJ-Pw
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 04:44:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iB8YW4KWPASZlroSQY9u2woAwhueHUnFFjkMwhU6gB+WzZ3S5748DzgN/upZHLcY4MowcJsPLX/YZp47AAM8pc86NYw4yzoFUpild0gUWA2hB00FAJjNR2oGU8iuVQ+POyfY5m2JppdVQtuYgHWrJNyPtSII/3dqOJltObmK4Fh8yYmLaKjP/tbcusUFk/UQuUs/oCG75L3m2uQJcayVo1bOTyg2mCsQ4viqBG8iAIjhb1ZXSk3u6VP1+UJ/ZtdFxEbIDSYv7Ehy/ZWv6zvvXYL+eWIBnt5/d6OTLoRS/GTlMG7p100KXi8ELNuRTkobSO0Tf4Um/QZa4GsU56rl1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IMPxvQw96JOUt82Tri3xapl3sLHFBq5D+bwAtQpiFgc=;
 b=OXyQD8O/n+A3XzXEKUhSVF0O8h5l1jOilQahYzMNCped9Ol4jMsroPAvmLJPAAXVeplaHOVA7oIajl4qyEb/ICsMH8M8CGU+s9pw8RryW573f/oxvqqtLoP21EBMRxh/fiDQmqzUUomWPnyghgBVjeKYF8fj8R+F2VwDtk36CwoietcsmKgsSKP4t8SladyJTrI3vYc8b2Oxb5K58+PMxZqSlPuF2sizZbo87ZCpttNKSIErl8f074eF9Yr7dfrh1HzbdbLnNKG+R5TOVM1juxA4jcgZgpZOuwgb7WrmJUUear7pgMkCCdM6WXFTX1jE7Ml0WC/04W17kj7acdOEBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IMPxvQw96JOUt82Tri3xapl3sLHFBq5D+bwAtQpiFgc=;
 b=RXjgBZ6oiCpvuU28NLu7IesvgHM1MwPjCXN7vlXQrqEnkIVaDl1r2cb+Tv3Jp4TZ33MZWI+WiFB80mPsd4zCre+9wl9QQiNeB98UE7/4bUxYWyyDvvHliL1YJxPV62zaR14DrvWH9+CP7UfKnaVT3MrXodlvh0gKPAyGalYA8BLWtxFGzYZWXhoyzhTpmgJyJO5gGvKThxwEt8RtTytNTwS9pNZ/7UyBdTDUkce1MddnMxTrGq5V+VtVelhdGiy5rpthd1JaMneVnHYlxQ1MdxNO8luC3aGgGVc/hAPeXZtAsUcS97LytyCQ9fh/95PZRexFk3jWGDXmPY5gLAVYPg==
Received: from DM4PR12MB5168.namprd12.prod.outlook.com (2603:10b6:5:397::8) by
 MW4PR12MB7030.namprd12.prod.outlook.com (2603:10b6:303:20a::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Mon, 1 Apr 2024 08:43:50 +0000
Received: from DM4PR12MB5168.namprd12.prod.outlook.com
 ([fe80::449b:329d:c9cd:5824]) by DM4PR12MB5168.namprd12.prod.outlook.com
 ([fe80::449b:329d:c9cd:5824%5]) with mapi id 15.20.7409.042; Mon, 1 Apr 2024
 08:43:50 +0000
Content-Type: multipart/alternative;
 boundary="------------ebzYRRnqfislD1nVuSn4ts1N"
Message-ID: <a6f3a386-4c65-4bc6-8d21-70b741919bff@nvidia.com>
Date: Mon, 1 Apr 2024 16:43:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: vhost-user-blk reconnect issue
To: Li Feng <fengli@smartx.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9_e?= <alex.bennee@linaro.org>,
 "raphael.norwitz@nutanix.com" <raphael.norwitz@nutanix.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>
References: <DM4PR12MB5168C0DB5E4B8F30B47738F6B6362@DM4PR12MB5168.namprd12.prod.outlook.com>
 <vzwqswsxtiios4mzwab4br2utyrclkfsluwyvyw6r7gqnx55fv@z3rsaj4hs6cz>
 <add17160-7b47-4af0-908c-9c0617720cc2@nvidia.com>
 <70EC669B-52F8-408B-866B-9AFFB7EBAE96@smartx.com>
Content-Language: en-US
From: Yajun Wu <yajunw@nvidia.com>
In-Reply-To: <70EC669B-52F8-408B-866B-9AFFB7EBAE96@smartx.com>
X-ClientProxiedBy: SI2PR01CA0045.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::19) To DM4PR12MB5168.namprd12.prod.outlook.com
 (2603:10b6:5:397::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5168:EE_|MW4PR12MB7030:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Euu2BpPiAdjTVLkfewxklYDO17ZzPkDKggxAcNwSud1NNWgddK+JRyvIGgmpeWXePFXI4ZFCiVGrRDVERRwmfT+HJ/rw5ZeP3pH+cYTAoR3pKsjLK6qyWUc4mayR+yQudD5vkx10iYDO7qlSnIijaPGRz2+y1YLlC5cNx7e7X1WxmT5ZR0FofooQvTIXQ3j39g673bNeI6UN+F4PUmsuA/mgaJuPsIv0Nc+rkMrG4xBOFEP/ZyPKjBMeLH+Wr+kxszTiJYIxkHi06O+bLUneTNyRk9X1ufDswpipJEiMGuggYa/TqnZ6DodTHVSA8LsmK+C0va/3VeoC1ddbEFcQ/9FyHTy+GFI4Cb4rmsibdAXIpPv7xKKxF4gCysd7tgH96lijfgsJZfIc7Lx1d67N0/K7RpWrzQC7yUzKalQGMM4zfFt5o/xSfjHW0HN9m9fq97dGbCsWh9R+pI5b5kn2NqfPmDMoz6YW1zjWhasCMYoIX8Ptn+4IzXtqHAx8OTXvtLZZV64UIdmKv+AfZ9P7nm8nQWlm4hYFOYtW/uuY3DUiQk3+z61pTwAuFQx8AmXtT2IYDiWQwjF3h1L1Z1enyikx2CTMmmxHiTsj1mfBQRkG1UmEf9419Q7s3Y1Q7+0ANIVTaMDuJL17t+Z0Cg481thLXIakR03PkWuXnx80hyU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5168.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(4143199003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDY0a1FxTzR3bSszUkRTQ1IrdDFNa0ZoZzF2UWxJakNkODhzNXpweEFlang2?=
 =?utf-8?B?dGY1YjVSSHhCbDN1RUZxYkl2T2NrVVVCSGhXano1Uk1mR1RxY3VhY05iUk4y?=
 =?utf-8?B?K2JQV2V6aHU1UHlyT3FMVDV2UWVuTTVZOTVyc01BTkUwMWZzK2FQWnp6YUFQ?=
 =?utf-8?B?UkdEbzFqNUMxalRUdkhXRVpuUWpYelZpejcwWTVqL01SRGZhTXJYdFR1R2Yv?=
 =?utf-8?B?NUFOYTcyV3llZDFKbFpONnF0WmJSRXJTREx5VUpRSkNFS1ZSckU5RDM2c29L?=
 =?utf-8?B?YlBCNmkyWWlzaDZjazJyVXA1N1VHSngyRGx2bCtCaXVVaTVONG81ZmZqNkRP?=
 =?utf-8?B?eXFNK2RmR1ZMaVZJaU50Tnl3clBseVBma3NOS3l0Vm9BWVhIUHZ0Vi9MMFd3?=
 =?utf-8?B?RzBXRzFIdm1KSTdTRjlrblp4dHFYVjZKQmZ3Wk1CT1BRRTZZVkh4elhDTEJL?=
 =?utf-8?B?aFFPQTdZOWhSR0RTY3FFTEtvM3Y2Y0VwamlHb2ZMNWptZ05QUGdBanFTQ045?=
 =?utf-8?B?eFRWTG16VlZXTW9SWmxGQ3VWUTZPMnNML2Q3WUdmYVpITnQrUEY3NkdweEFj?=
 =?utf-8?B?OGVPM21CbXA2Z21yamlPUjg1RTZtK0prN3hmMWc1aUNNSkVVS2NNc0plb3px?=
 =?utf-8?B?LzZPNEtzMnU3Q2JDQnJKbzc3Y0ZsdFJYbjJEcnoxcnBTU28rUXRDNzRqd1hl?=
 =?utf-8?B?dFZoWlp6Z2NVYnBZb3JSU0NFZXVVTGtRNThGWFlYRzJteU1MSmswSEpiS1Iv?=
 =?utf-8?B?eG01QVlrblFUa1NmbU5pZU1YN0VUaWY0anMzMFJyNHdqSmhqU3NCMm9vaTdt?=
 =?utf-8?B?cDBPVWpIWE53dzFQWVZUUW9XejhHNHFxN25SMjZFMzJZemd5V25nTWdnK0N6?=
 =?utf-8?B?R1pSSm9KQnFtazFYeHJkK0UrT3V1bDFEeSsrTko3c0lPQng1TEl0UFgyWEYw?=
 =?utf-8?B?dk1tY09KcnNPeStSR0NMSFk4RCtaOXRaR2NZMGZFUG9lZExMd2RLaG5JQ25H?=
 =?utf-8?B?NncwSEwvbzBwV3hHWUtOZVlkVFFUalFNbitPZE9UR0pXTnJ2M3JYaXM1V21s?=
 =?utf-8?B?QVJ4amZuSjlSUHFCMmpCbHlWN3U2K2hNdlNsL1dMUlZ0dW9FTE5qMVo4Tkcy?=
 =?utf-8?B?TmM5Y1pLUytySFFWMzVnL1F6cVFDbzZDVWZUaFgxNGF4UVRjeHNCSHFMUDB4?=
 =?utf-8?B?ZTFUQzhPN2gyZUtxUzRxR2dXbFVBUnY1SEFTa2FsUWNUUVpTeTdsblhVZEN3?=
 =?utf-8?B?S1dJQ2VZdi9kV2hFQlZ3YXQ3a1FiUHRjVzR4enV5VC9VOFhqL0w3ZnR4cTlh?=
 =?utf-8?B?UFVRVFBBYXFxUmFIOGtDcVRRVTAxOHZyaGd5MmRWWmNFSHRpcnovQmdiNjNV?=
 =?utf-8?B?OCtUYkhjb2FvRE1CSkJWaGNCVzlQN3grcDM1MXpKeks0NUU4K3hyTTdaaFZk?=
 =?utf-8?B?WkJkaGRvc1FSVHowQUJNdXdab1B1UDB2TkFBMm4yWDZia2NvRUNPME9BaWxC?=
 =?utf-8?B?K21vMzRzQTZZN3gxQVhNQjVYN3dGYnJBN1h4RFlkODEwZWNXbGZxK3lFd1Vm?=
 =?utf-8?B?eVdNc1UyVWZpMkxJU3VkeUdpT0txTEdyK08xanlveU5qZnhKMUt5em9IZW9i?=
 =?utf-8?B?cmh3K09qVHhLRUtxQW5DSzQ5Z1RFU3U5K2o3Z1NHdWF2TE9RL1cvRlU1Ung3?=
 =?utf-8?B?R3hTeHg2SkhFSXI2SW1PTTRMUmRGZWpRT1dkRXR3ZFRrSTRNSENLMUpTRGZ0?=
 =?utf-8?B?VGJleGM5RHFadFRkNVdSc3c2UldsbVZLTEdrZVpjWitNTEt1Q252YTF1c2I3?=
 =?utf-8?B?TVN0N2x4TlZiOTRFV2t3T0JSS3dONEw1WXc4THlWNDFiM2kxdjdKcW93Z3dt?=
 =?utf-8?B?UThwcCt4VDBxWXpidzdKcXhmTldZMnc4Yms5VlJ4emt1ZitPNjRMdFgxbXln?=
 =?utf-8?B?NGV3SSs1WEpZdHhBdWpWM2paTXlEczFlMzJ6aWxmT3pyNE10TzVPNXN2Q1VI?=
 =?utf-8?B?R3JpSDgzenNXOE1ZOWNKWFdhaVNsWnNqZFdDRjBPZFpYa1prNk9BMlhlS25l?=
 =?utf-8?B?QWNhc01VMllqVFVOTk9WQ05yVmcxOXdzQ3V3L1ZkaTJvelpLUStuNitKM2w3?=
 =?utf-8?Q?NHhcLdk4cwkFjuo/HjdYwDY1o?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca46314d-2079-4c4a-e77c-08dc5227da4a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5168.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 08:43:50.2400 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kpp0Qoiu2GzzRu08sDJWp0NIR3fBKV3GE0xNfZWVdaNknf4Ezn1f2kpqnTNXyPHSgU/WENqR6YrEfe+Gb23O9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7030
Received-SPF: softfail client-ip=2a01:111:f403:2416::701;
 envelope-from=yajunw@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

--------------ebzYRRnqfislD1nVuSn4ts1N
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/1/2024 4:34 PM, Li Feng wrote:
> *External email: Use caution opening links or attachments*
>
>
> Hi yajun,
>
> I have submitted a patch to fix this problem a few months ago, but in 
> the end this solution was not accepted and other solutions
> were adopted to fix it.
>
> [PATCH 1/2] vhost-user: fix lost reconnect - Li Feng 
> <https://lore.kernel.org/all/20230804052954.2918915-2-fengli@smartx.com/>
> lore.kernel.org 
> <https://lore.kernel.org/all/20230804052954.2918915-2-fengli@smartx.com/>
> 	<https://lore.kernel.org/all/20230804052954.2918915-2-fengli@smartx.com/>
>
> <https://lore.kernel.org/all/20230804052954.2918915-2-fengli@smartx.com/>
>
I think this fix is valid.

> This is the merged fix:
>
>
> [PULL 76/83] vhost-user: fix lost reconnect - Michael S. Tsirkin 
> <https://lore.kernel.org/all/a68c0148e9bf105f9e83ff5e763b8fcb6f7ba9be.1697644299.git.mst@redhat.com/>
> lore.kernel.org 
> <https://lore.kernel.org/all/a68c0148e9bf105f9e83ff5e763b8fcb6f7ba9be.1697644299.git.mst@redhat.com/>
> 	<https://lore.kernel.org/all/a68c0148e9bf105f9e83ff5e763b8fcb6f7ba9be.1697644299.git.mst@redhat.com/>
>
> <https://lore.kernel.org/all/a68c0148e9bf105f9e83ff5e763b8fcb6f7ba9be.1697644299.git.mst@redhat.com/>

My tests are with this fix, failed in the two scenarios I mentioned.

>
> Thanks,
> Li
>
>> 2024年4月1日 10:08，Yajun Wu <yajunw@nvidia.com> 写道：
>>
>>
>> On 3/27/2024 6:47 PM, Stefano Garzarella wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> Hi Yajun,
>>>
>>> On Mon, Mar 25, 2024 at 10:54:13AM +0000, Yajun Wu wrote:
>>>> Hi experts,
>>>>
>>>> With latest QEMU (8.2.90), we find two vhost-user-blk backend reconnect
>>>> failure scenarios:
>>> Do you know if has it ever worked and so it's a regression, or have we
>>> always had this problem?
>>
>> I am afraid this commit: "71e076a07d (2022-12-01 02:30:13 -0500) 
>> hw/virtio: generalise CHR_EVENT_CLOSED handling"  caused both 
>> failures. Previous hash is good.
>>
>> I suspect the "if (vhost->vdev)" in vhost_user_async_close_bh is the 
>> cause, previous code doesn't have this check?
>>
>>>
>>> Thanks,
>>> Stefano
>>>
>>>> 1. Disconnect vhost-user-blk backend before guest driver probe vblk 
>>>> device, then reconnect backend after guest driver probe device. 
>>>> QEMU won't send out any vhost messages to restore backend.
>>>> This is because vhost->vdev is NULL before guest driver probe vblk 
>>>> device, so vhost_user_blk_disconnect won't be called, s->connected 
>>>> is still true. Next vhost_user_blk_connect will simply return 
>>>> without doing anything.
>>>>
>>>> 2. modprobe -r virtio-blk inside VM, then disconnect backend, then 
>>>> reconnect backend, then modprobe virtio-blk. QEMU won't send 
>>>> messages in vhost_dev_init.
>>>> This is because rmmod will let qemu call vhost_user_blk_stop, 
>>>> vhost->vdev also become NULL(in vhost_dev_stop), 
>>>> vhost_user_blk_disconnect won't be called. Again s->connected is 
>>>> still true, even chr connect is closed.
>>>>
>>>> I think even vhost->vdev is NULL, vhost_user_blk_disconnect should 
>>>> be called when chr connect close?
>>>> Hope we can have a fix soon.
>>>>
>>>>
>>>> Thanks,
>>>> Yajun
>>>>
>
--------------ebzYRRnqfislD1nVuSn4ts1N
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class=3D"moz-cite-prefix">On 4/1/2024 4:34 PM, Li Feng wrote:<br>
    </div>
    <blockquote type=3D"cite" cite=3D"mid:70EC669B-52F8-408B-866B-9AFFB7EBA=
E96@smartx.com">
     =20
      <table border=3D"1" bgcolor=3D"#FFEB9C">
        <tbody>
          <tr>
            <td><font size=3D"1" face=3D"verdana" color=3D"black"><b>Extern=
al
                  email: Use caution opening links or attachments</b>
              </font></td>
          </tr>
        </tbody>
      </table>
      <br>
      <div>
        <div style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;">
          <div style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space=
; line-break: after-white-space;">
            <div style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: spa=
ce; line-break: after-white-space;">
              Hi yajun,
              <div><br>
              </div>
              <div>I have submitted a patch to fix this problem a few
                months ago, but in the end this solution was not
                accepted and other solutions</div>
              <div>were adopted to fix it.</div>
              <div><br>
              </div>
              <div>
                <div style=3D"display: block;">
                  <div style=3D"-webkit-user-select: all; -webkit-user-drag=
: element; display: inline-block;" class=3D"apple-rich-link" draggable=3D"t=
rue" role=3D"link" data-url=3D"https://lore.kernel.org/all/20230804052954.2=
918915-2-fengli@smartx.com/">
                    <a style=3D"border-radius:10px;font-family:-apple-syste=
m, Helvetica, Arial, sans-serif;display:block;-webkit-user-select:none;widt=
h:300px;user-select:none;-webkit-user-modify:read-only;user-modify:read-onl=
y;overflow:hidden;text-decoration:none;" class=3D"lp-rich-link" rel=3D"nofo=
llow" href=3D"https://lore.kernel.org/all/20230804052954.2918915-2-fengli@s=
martx.com/" originalsrc=3D"https://lore.kernel.org/all/20230804052954.29189=
15-2-fengli@smartx.com/" shash=3D"C6tagv56k7iKH4hU3GzpNn1wJ0qaJf06+8gRxEha2=
xoNhrXzrOsgsWDDTk4jwmIl+s2XOCP1J0XsJ6+YbZ+GApR8yFK137cOidTolUYSbdCk5G5Td206=
kJLZqZgh0Oa8OQtr6AJy35bzEv8sF7NtSTO97bRO2YvzbCWPqa7EaHA=3D" dir=3D"ltr" rol=
e=3D"button" draggable=3D"false" width=3D"300" moz-do-not-send=3D"true">
                      <table style=3D"table-layout:fixed;border-collapse:co=
llapse;width:300px;background-color:#E5E6E9;font-family:-apple-system, Helv=
etica, Arial, sans-serif;" class=3D"lp-rich-link-emailBaseTable" width=3D"3=
00" cellspacing=3D"0" cellpadding=3D"0" border=3D"0">
                        <tbody>
                          <tr>
                            <td vertical-align=3D"center">
                              <table style=3D"font-family:-apple-system, He=
lvetica, Arial, sans-serif;table-layout:fixed;background-color:rgba(229, 23=
0, 233, 1);" class=3D"lp-rich-link-captionBar" width=3D"300" cellspacing=3D=
"0" cellpadding=3D"0" bgcolor=3D"#E5E6E9">
                                <tbody>
                                  <tr>
                                    <td style=3D"padding:8px 0px 8px 0px;" =
class=3D"lp-rich-link-captionBar-textStackItem">
                                      <div style=3D"max-width:100%;margin:0=
px 16px 0px 16px;overflow:hidden;" class=3D"lp-rich-link-captionBar-textSta=
ck">
                                        <div style=3D"word-wrap:break-word;=
font-weight:500;font-size:12px;overflow:hidden;text-overflow:ellipsis;text-=
align:left;" class=3D"lp-rich-link-captionBar-textStack-topCaption-leading"=
>
                                          <a rel=3D"nofollow" href=3D"https=
://lore.kernel.org/all/20230804052954.2918915-2-fengli@smartx.com/" origina=
lsrc=3D"https://lore.kernel.org/all/20230804052954.2918915-2-fengli@smartx.=
com/" shash=3D"xsx7V0zLzZUjW4OMnPS5fZXFo1lo6kilqtOMM2leumVckQleTN6uFjurb6A8=
3+t1TL4WFFM+oeVyRtSi+kqljXOcucMliG6dLdsXKXTskHRYPFrQyMDRwT9r9NENuvNtm/yFIZh=
lJH7vlNVrg6nzdKQ9QLr5URD3C/hwHUiw2v4=3D" style=3D"text-decoration: none" dr=
aggable=3D"false" moz-do-not-send=3D"true"><font style=3D"color: rgba(0, 0,=
 0, 0.847059);" color=3D"#272727">[PATCH 1/2]
                                              vhost-user: fix lost
                                              reconnect - Li Feng</font></a=
></div>
                                        <div style=3D"word-wrap:break-word;=
font-weight:400;font-size:11px;overflow:hidden;text-overflow:ellipsis;text-=
align:left;" class=3D"lp-rich-link-captionBar-textStack-bottomCaption-leadi=
ng">
                                          <a rel=3D"nofollow" href=3D"https=
://lore.kernel.org/all/20230804052954.2918915-2-fengli@smartx.com/" origina=
lsrc=3D"https://lore.kernel.org/all/20230804052954.2918915-2-fengli@smartx.=
com/" shash=3D"TtG+k4QeoQMw4Uo6nIN7oujAW8gSATEwbHEOXGcnFnCDu8j5/wWbzaSiQcKI=
iHrrhikbMpcFJbv8oLRMYWyD89RLtGdbNq5tsia7BdLvLUpLzGdvlG/Okhx9eh+hcgbN51akSgJ=
gyHnpKWpq2fPssqnoWE5+sRM/wjGj6QrHiTw=3D" style=3D"text-decoration: none" dr=
aggable=3D"false" moz-do-not-send=3D"true"><font style=3D"color: rgba(0, 0,=
 0, 0.498039);" color=3D"#808080">lore.kernel.org</font></a></div>
                                      </div>
                                    </td>
                                    <td style=3D"padding:0px 12px 0px 0px;"=
 class=3D"lp-rich-link-captionBar-rightIconItem" width=3D"36">
                                      <a rel=3D"nofollow" href=3D"https://l=
ore.kernel.org/all/20230804052954.2918915-2-fengli@smartx.com/" originalsrc=
=3D"https://lore.kernel.org/all/20230804052954.2918915-2-fengli@smartx.com/=
" shash=3D"cIUcSFQU8wgPcQovkb6qLefSrVOlLyGbySgghyxlb3Yl0+eBNdnIfXeoowldHFBv=
5HDpDgVjwOk/0ID0EEqXR3ZfWx+QCUi4Ws9Afmijkj+wO2POKvE9mFE3YgZ9w6vyULXCKrWknHe=
xtgG4YmgbcSRyuKm5DLhMlfujPHlFlaE=3D" draggable=3D"false" moz-do-not-send=3D=
"true"><img src=3D"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEgAAABICA=
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3D"=
 draggable=3D"false" style=3D"pointer-events:none !important;display:inline=
-block;width:36px;height:36px;" class=3D"lp-rich-link-captionBar-rightIcon"=
 moz-do-not-send=3D"true" width=3D"36" height=3D"36"></a></td>
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
    <blockquote type=3D"cite" cite=3D"mid:70EC669B-52F8-408B-866B-9AFFB7EBA=
E96@smartx.com">
      <div>
        <div style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;">
          <div style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space=
; line-break: after-white-space;">
            <div style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: spa=
ce; line-break: after-white-space;">
              <div>
                <div>
                </div>
                This is the merged fix:</div>
              <div><br>
              </div>
              <div><br>
              </div>
              <div>
                <div style=3D"display: block;">
                  <div style=3D"-webkit-user-select: all; -webkit-user-drag=
: element; display: inline-block;" class=3D"apple-rich-link" draggable=3D"t=
rue" role=3D"link" data-url=3D"https://lore.kernel.org/all/a68c0148e9bf105f=
9e83ff5e763b8fcb6f7ba9be.1697644299.git.mst@redhat.com/">
                    <a style=3D"border-radius:10px;font-family:-apple-syste=
m, Helvetica, Arial, sans-serif;display:block;-webkit-user-select:none;widt=
h:300px;user-select:none;-webkit-user-modify:read-only;user-modify:read-onl=
y;overflow:hidden;text-decoration:none;" class=3D"lp-rich-link" rel=3D"nofo=
llow" href=3D"https://lore.kernel.org/all/a68c0148e9bf105f9e83ff5e763b8fcb6=
f7ba9be.1697644299.git.mst@redhat.com/" originalsrc=3D"https://lore.kernel.=
org/all/a68c0148e9bf105f9e83ff5e763b8fcb6f7ba9be.1697644299.git.mst@redhat.=
com/" shash=3D"o690TPSGdWnn0ZbUx6QF/RZrrnSnyscTbtiJj+4Qh19WeQj/uQwTikL+eLPi=
Hp6vpjlV5aHlxp3O7toOOjxWU6/04z1P9KTwEod4QU2CrbJZftwB9VL0qD24YaicOqlD8LmNNB4=
vC8Q0VobpGqhaI+6p6Gbu6Q+/WXD0QSWFMKU=3D" dir=3D"ltr" role=3D"button" dragga=
ble=3D"false" width=3D"300" moz-do-not-send=3D"true">
                      <table style=3D"table-layout:fixed;border-collapse:co=
llapse;width:300px;background-color:#E5E6E9;font-family:-apple-system, Helv=
etica, Arial, sans-serif;" class=3D"lp-rich-link-emailBaseTable" width=3D"3=
00" cellspacing=3D"0" cellpadding=3D"0" border=3D"0">
                        <tbody>
                          <tr>
                            <td vertical-align=3D"center">
                              <table style=3D"font-family:-apple-system, He=
lvetica, Arial, sans-serif;table-layout:fixed;background-color:rgba(229, 23=
0, 233, 1);" class=3D"lp-rich-link-captionBar" width=3D"300" cellspacing=3D=
"0" cellpadding=3D"0" bgcolor=3D"#E5E6E9">
                                <tbody>
                                  <tr>
                                    <td style=3D"padding:8px 0px 8px 0px;" =
class=3D"lp-rich-link-captionBar-textStackItem">
                                      <div style=3D"max-width:100%;margin:0=
px 16px 0px 16px;overflow:hidden;" class=3D"lp-rich-link-captionBar-textSta=
ck">
                                        <div style=3D"word-wrap:break-word;=
font-weight:500;font-size:12px;overflow:hidden;text-overflow:ellipsis;text-=
align:left;" class=3D"lp-rich-link-captionBar-textStack-topCaption-leading"=
>
                                          <a rel=3D"nofollow" href=3D"https=
://lore.kernel.org/all/a68c0148e9bf105f9e83ff5e763b8fcb6f7ba9be.1697644299.=
git.mst@redhat.com/" originalsrc=3D"https://lore.kernel.org/all/a68c0148e9b=
f105f9e83ff5e763b8fcb6f7ba9be.1697644299.git.mst@redhat.com/" shash=3D"qnpv=
nX4reHqPw3XyUx63PdXSmk+f0hT0FdWe0QN9jiAb3ePGRKD5uj8Uu7eHq0WMLOM9stm0LoprAX4=
F4Y+pTxm0YL7C6+Tn8lWV6um/z9mSVO4u+zo27fdqLySBGrPc4JGhcys27oNpit8e4r308FOyD1=
vM6+OpSZ+yzEzI8Hc=3D" style=3D"text-decoration: none" draggable=3D"false" m=
oz-do-not-send=3D"true"><font style=3D"color: rgba(0, 0, 0, 0.847059);" col=
or=3D"#272727">[PULL 76/83]
                                              vhost-user: fix lost
                                              reconnect - Michael S.
                                              Tsirkin</font></a></div>
                                        <div style=3D"word-wrap:break-word;=
font-weight:400;font-size:11px;overflow:hidden;text-overflow:ellipsis;text-=
align:left;" class=3D"lp-rich-link-captionBar-textStack-bottomCaption-leadi=
ng">
                                          <a rel=3D"nofollow" href=3D"https=
://lore.kernel.org/all/a68c0148e9bf105f9e83ff5e763b8fcb6f7ba9be.1697644299.=
git.mst@redhat.com/" originalsrc=3D"https://lore.kernel.org/all/a68c0148e9b=
f105f9e83ff5e763b8fcb6f7ba9be.1697644299.git.mst@redhat.com/" shash=3D"RSn5=
TF9P2G2pOEJul3iGVFApCALoZzWTPKUvLGiHGwAjoKq7nCRWqQcCcgStK5A1g11hWCnVZu7NK+b=
kITRuhWl0XpONkINUhDV6/p61N/N4K9j2bu9ljOM4MMLv2DAhN6gjQwgcVNWc7xPQ/y0z1t4Edd=
Jnttp6GAuV5Z39f/k=3D" style=3D"text-decoration: none" draggable=3D"false" m=
oz-do-not-send=3D"true"><font style=3D"color: rgba(0, 0, 0, 0.498039);" col=
or=3D"#808080">lore.kernel.org</font></a></div>
                                      </div>
                                    </td>
                                    <td style=3D"padding:0px 12px 0px 0px;"=
 class=3D"lp-rich-link-captionBar-rightIconItem" width=3D"36">
                                      <a rel=3D"nofollow" href=3D"https://l=
ore.kernel.org/all/a68c0148e9bf105f9e83ff5e763b8fcb6f7ba9be.1697644299.git.=
mst@redhat.com/" originalsrc=3D"https://lore.kernel.org/all/a68c0148e9bf105=
f9e83ff5e763b8fcb6f7ba9be.1697644299.git.mst@redhat.com/" shash=3D"DfQZCCmw=
lpH2uRRCtVSBnpUx6smuHWcGbVPP0MGX7pjDzerTQhCV/5OUBA1FHdcLfJmTRfRMNhNF/VjgNBq=
kaNtQZ+nKvFo/izxjU7c3rh8IQnCX9ePVCBeIeKnRa/sfYj/qHmlmZ0Hr0oBGIx1HKRCc/2JCMJ=
VEkuq/KGU7VLU=3D" draggable=3D"false" moz-do-not-send=3D"true"><img src=3D"=
data:image/png;base64,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3D" draggable=3D"false=
" style=3D"pointer-events:none !important;display:inline-block;width:36px;h=
eight:36px;" class=3D"lp-rich-link-captionBar-rightIcon" moz-do-not-send=3D=
"true" width=3D"36" height=3D"36"></a></td>
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
    <p>My tests are with this fix, failed in the two scenarios I
      mentioned. <br>
    </p>
    <blockquote type=3D"cite" cite=3D"mid:70EC669B-52F8-408B-866B-9AFFB7EBA=
E96@smartx.com">
      <div>
        <div style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;">
          <div style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space=
; line-break: after-white-space;">
            <div style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: spa=
ce; line-break: after-white-space;">
              <div>
                <div style=3D"display: block;">
                </div>
                <div><br>
                </div>
                Thanks,</div>
              <div>Li<br>
                <div><br>
                  <blockquote type=3D"cite">
                    <div>2024=E5=B9=B44=E6=9C=881=E6=97=A5 10:08=EF=BC=8CYa=
jun Wu
                      <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:yaj=
unw@nvidia.com">&lt;yajunw@nvidia.com&gt;</a> =E5=86=99=E9=81=93=EF=BC=9A</=
div>
                    <br class=3D"Apple-interchange-newline">
                    <div>
                      <div><br>
                        On 3/27/2024 6:47 PM, Stefano Garzarella wrote:<br>
                        <blockquote type=3D"cite">External email: Use
                          caution opening links or attachments<br>
                          <br>
                          <br>
                          Hi Yajun,<br>
                          <br>
                          On Mon, Mar 25, 2024 at 10:54:13AM +0000,
                          Yajun Wu wrote:<br>
                          <blockquote type=3D"cite">Hi experts,<br>
                            <br>
                            With latest QEMU (8.2.90), we find two
                            vhost-user-blk backend reconnect<br>
                            failure scenarios:<br>
                          </blockquote>
                          Do you know if has it ever worked and so it's
                          a regression, or have we<br>
                          always had this problem?<br>
                        </blockquote>
                        <br>
                        I am afraid this commit: &quot;71e076a07d (2022-12-=
01
                        02:30:13 -0500) hw/virtio: generalise
                        CHR_EVENT_CLOSED handling&quot;&nbsp; caused both
                        failures. Previous hash is good.<br>
                        <br>
                        I suspect the &quot;if (vhost-&gt;vdev)&quot; in
                        vhost_user_async_close_bh is the cause, previous
                        code doesn't have this check?<br>
                        <br>
                        <blockquote type=3D"cite"><br>
                          Thanks,<br>
                          Stefano<br>
                          <br>
                          <blockquote type=3D"cite">1. Disconnect
                            vhost-user-blk backend before guest driver
                            probe vblk device, then reconnect backend
                            after guest driver probe device. QEMU won't
                            send out any vhost messages to restore
                            backend.<br>
                            This is because vhost-&gt;vdev is NULL
                            before guest driver probe vblk device, so
                            vhost_user_blk_disconnect won't be called,
                            s-&gt;connected is still true. Next
                            vhost_user_blk_connect will simply return
                            without doing anything.<br>
                            <br>
                            2. modprobe -r virtio-blk inside VM, then
                            disconnect backend, then reconnect backend,
                            then modprobe virtio-blk. QEMU won't send
                            messages in vhost_dev_init.<br>
                            This is because rmmod will let qemu call
                            vhost_user_blk_stop, vhost-&gt;vdev also
                            become NULL(in vhost_dev_stop),
                            vhost_user_blk_disconnect won't be called.
                            Again s-&gt;connected is still true, even
                            chr connect is closed.<br>
                            <br>
                            I think even vhost-&gt;vdev is NULL,
                            vhost_user_blk_disconnect should be called
                            when chr connect close?<br>
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
  </body>
</html>

--------------ebzYRRnqfislD1nVuSn4ts1N--

