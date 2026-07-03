Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F7A9C43602
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 12:55:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfdQ2-0004ZQ-Qq; Fri, 03 Jul 2026 08:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wfdQ0-0004Z2-7v
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 08:54:56 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wfdPw-0000jx-Ro
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 08:54:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xiPGwk5W5ed963/43Xrkt8AZNmLhsVh0bwYOMSEkIOCTBCMCQJOFj5wkFGyn76n9AnqN57qWhax+seLCW4MJrwzwYO1rz2ZCNginY7MH1LPH1qRUgtmj9adJBwrY8vQtjywRBc4CHry3R9WNBNaCYE3geqxcclf+TmeCe7v5bT+gjSCQcHLpdRoR0d2jFCDYdEHX+65WSryJVWr/AolrxvNZ4kdSVYTL0NT9VBdDQvkSlPY+FTUjbw1AzUxvrWK+3QvJxcDIBuRVYFsb5R3mQmzVOI6llZqOwYYI1ZfaE3Len0SZqn7jEdra3IzyTGbF0k+9YNd5ldn/beHFadbw7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bSTsE/py7znEj0FoYlE/RloGjWCO4O7c7IFmonQlSls=;
 b=tZeJoo20qShW8dWR5RXMtZC0us0kKGkaHd0j3qwWCT/X6khYwDgv/Nz+kVLAViqtrYKunsWiZxVPVQnnej0RzPiBDH4nG1neh5G4liPiUAfMNoIQo7D0LLPOs24ZjyjJpn2LT1fjrxMeTHXYC7T5NBwSbfDUK/r2nrb2/x9nu0uojSp5J6F3TWWseqxIzANdVYowOdXuJET6uBotWMAH4qrGu+j49lIfai/LAg/A0IoYx2lOBjb26+0Xj8fxXnIVdto1Nnin8B9pcLkVuZzRaHNQpCl7SFehVB6+ciCBxpBpbO76rPH6QfrjjLhoPsEhWeA3SxOxPsZytyHhlNDIkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSTsE/py7znEj0FoYlE/RloGjWCO4O7c7IFmonQlSls=;
 b=WuiUgv7D1m0OhX7C0R8uyCoR3X858G/kUn0wO9cyq1UkDwRJ87TnFX5CUiz2yUK80AwzUiBuToi8mlgG2jM+1uzS4E4OlLZd9/Qy3JaGAycKY0tS6/WogsCAwAm4QcpJ6apGGCXNIPXmJt+FtzQo4eUtllWvaQtH4/zWTn3/JIzpKIinxgc/CaZandTMtKfEHz1RbMWyQgShPXDNKFOXVUqVly9cB+VtMhIk7zEuy0YZrv1XxQCHF8glCzojhzz48WysWg7BTMmjnE578UtSz4x0WjlVQn/rTTia0BJr8hxS3MzoP0gStI5uTdCGQJoR6yBU72w6ma0D1bvBxh2dqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5119.namprd12.prod.outlook.com (2603:10b6:5:392::10)
 by SA3PR12MB9200.namprd12.prod.outlook.com (2603:10b6:806:39c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Fri, 3 Jul 2026
 12:54:45 +0000
Received: from DM4PR12MB5119.namprd12.prod.outlook.com
 ([fe80::261:eff5:d149:2d56]) by DM4PR12MB5119.namprd12.prod.outlook.com
 ([fe80::261:eff5:d149:2d56%6]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 12:54:44 +0000
Message-ID: <e7bd3ab2-2eca-44d6-8a18-29cdbcb57768@nvidia.com>
Date: Fri, 3 Jul 2026 15:54:41 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 08/23] migration: Run final save_query_pending at switchover
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>
Cc: Peter Xu <peterx@redhat.com>, "Jason J. Herne" <jjhern@linux.ibm.com>,
 Lukas Straub <lukasstraub2@web.de>
References: <20260630043107.1511076-1-clg@redhat.com>
 <20260630043107.1511076-9-clg@redhat.com>
 <a82ece02-d9fd-4ea4-b934-a9bc5abde663@nvidia.com>
 <df58c2d0-cc0c-43c2-9dd3-ea0614de7d72@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <df58c2d0-cc0c-43c2-9dd3-ea0614de7d72@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0107.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::10) To DM4PR12MB5119.namprd12.prod.outlook.com
 (2603:10b6:5:392::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5119:EE_|SA3PR12MB9200:EE_
X-MS-Office365-Filtering-Correlation-Id: bb7cb707-3a7f-4857-a1a3-08ded9024185
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|4143699003|6133799003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: /lUDbR//zcuQh9bpw3wEJTdJ9vBtVmtywj+MH7QaSMEtIEcESRrif9ldvZuUfFsuu9cZXwHIhcJ6oQgLRSDX1sp3vKsLlNOYq9aMpoafu2gq4/uNhdT/eevgbHq831VmxQPCBOR3FdfR+qnAqm9KFPhq+2DtGF4LOKGtZU25/Sh8+oMNs1Of3On7oryK8hZRfYmZlskmfuiy43KW59ROYRb8kpQPm+4sFu0ki2iwPAo++dkQPLyK3SHG6ud3LJPG3uyEwqjToHkk59VZi02FPS24TdeRQBJMBmwCRk8sWIBKZiMTjEkQ5lxgWp5pNhuZ0+vS+jCAjlPrWh4EM+kUKiAxLyMdH50I0paVQJ9sAJymvCdaS+8RNzEGZg//gmW3xEMPVstrAsB5FkhsMwwzxean8/cFovnYoSLZROuV/G3nebc55MvX5AWnaXKsapol+WdYS/kSNd1Jp97vxduIYUoVRP6QBk5zytE7+EZdCFkum578+wGxJywxmuE3/+PyCp6X8Q79V1FCHW/fhdeMBktZC+knfLw5yDbSYS+0c5NHLrY7I8X2XjMo5ts4QN2yTGTtjmi62V745030d+x+EUkxgHjybv2Au+KJvQBxQjejDnbk1rwg57KDNIdF4EBd9bHVn/1jlGMQ/xrtifVP97N7Xh29Y/DzIXHfzJdblaM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5119.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(4143699003)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHJzQkZvbklZZU55REx1VWpUZHplMU9PczhacUExcllscGJXVmFSSnVMVi9w?=
 =?utf-8?B?cW1CRnlubFV6QkRFQkxIb3B0V1NVdDNpUUpLbHY3VmtSS0JxdmduSVFLbyti?=
 =?utf-8?B?NzkwNTFCWXJxTFd5dHRMWGMvU0trVmZhc2ZtdFhHZHF1d2RsR1BpWGlFN3Np?=
 =?utf-8?B?QU5WbFVSN0VJaGNzVGpFcytTUWdJY2t0UStoMkdiTVJ6ejhSeWpsVmh1bWYv?=
 =?utf-8?B?NERBc3JHYk1hdHlOTmFiL2wrdkhFRFUrdE5JdjdBYjNBekFPYjM1dHE3UWdu?=
 =?utf-8?B?VHpxVWJCWDNuUVVkK2dCNVg5d1JFOVk1ZUxwc2tCS1dtYVRPUEdpazB1RjFN?=
 =?utf-8?B?a1NXZDhkcW1Fd2I3WE1wK21za3ZYRHcvSG10bXovNktkZk0zMGQxbUVFVncy?=
 =?utf-8?B?cWZYbldnV2NXeHFhR1lyMXY3VzJSM3N5dW1yM0gySWVHa2llNXkyWUZmOC9i?=
 =?utf-8?B?djZGckhXNHU4QURualNTWWtOUGlDKzMxMmRGK2RxQzRRMTZlVWhPZ0FpYmNq?=
 =?utf-8?B?T2I5aHgwRmtvYTlnaTRSVWRNVmRLSU5EUnVZSFNFSzJqQ2tSMGpTQ3pjMGE4?=
 =?utf-8?B?bW5JbjUyazRoaENRMld4SmhaT291TUVYZ0h1ZmNOZHZUUmVISGlvUHplRFFu?=
 =?utf-8?B?NTBzQjN0Z2QzTFBESEs1d1NabUxrRmx0V3RkOXBDZmZud2Z2QU9iYlNWN0pH?=
 =?utf-8?B?U09yQ1VycmcxRmVmbHoxVmFYTVpQeUxCU21taFdPZ0JKZThjOHByOUZsQUVt?=
 =?utf-8?B?Q1VvRDh0alBYMDc4RkJBYXAyVmNlWHl1TWRVcm42UmdZRUNiUkJWM1RtM2lS?=
 =?utf-8?B?VzVzOURoZk5jVUZ1dWExSS9ORWpQd0xaTDhzcGZvVkVlOW1QeFc2UStTYjdr?=
 =?utf-8?B?QUFQT0h6MVg2K0FpMEVSVUcvb1hTamUwczZXeFY4SnpIRXBPK1hoSUdVK0FZ?=
 =?utf-8?B?YTl5QWZEelNxeFB1dmNvb2gzU2Z5aEIrOGxISGUwREhlN29XQ2JESWtpSTl6?=
 =?utf-8?B?YU1LdFRyZ0VGaXQ4SlMwVmFRcHMyVVcycjJPOERJcFlKWFhNMHluT2pvditx?=
 =?utf-8?B?ZHVsc1JXbml6SEU1d0FQTFhhRzQyaThxQThhcGQ5UGxmUjFzWmh3VmFTZ05G?=
 =?utf-8?B?WmdXK1Z1Uk1idENpNXdGQndBQm5SS2F4NG1mTGlyN0N1RTZ4MXhLdVBLaEho?=
 =?utf-8?B?aXhYV0FyL1NCdWN3MGdKYy9FM24rcTdFczZDQytCeHFzMytsR1NwbndaU21X?=
 =?utf-8?B?V1REd3lVaTlHTjZsYXRHZno5cG9FZXREbU5wUFF6R0ZmK2RDdTVTQmpqYWZ1?=
 =?utf-8?B?RmJDZEgwVEJuSlloRFhsQ3FIMExZTk5USDNOamQ2V2pOVkdUbE9VTE9aMHl4?=
 =?utf-8?B?Z1Z0OTBVaHBlWDlYRE91bTNrWXoxcHh5TnZkaWRpVWJVRmNyTXFES252dVk2?=
 =?utf-8?B?dXJqakFqY1VkQUpvQUVvbnZrRXViZXN5azdlZ1ZrS045c3JvenhwbmdZRFNG?=
 =?utf-8?B?dGhzSXNha3VXN0F1Z2gxNzlsNk9qUFNjRHpIMHh5bVBiUEVwY094Q1FFaVhM?=
 =?utf-8?B?NllNb0YvbUJPUDVqM1U4UWxSM0lTZVl1SkJhVDAvRFBWZmtZMXhpRlZ1bUxh?=
 =?utf-8?B?YjFSMFV5Vk1RSG52emNwazAxMUVjOXM4WXplSFZVOFdxajlZTHo4SWlCbGto?=
 =?utf-8?B?YUFUZG91MGxFQTd5OFZWTFJsZGxxRkdsYzV1V01yaE0weFZpQW5yekNtczFk?=
 =?utf-8?B?a0N2eTgzQmx0ZGlZL2IxUlkwV3JPNmVwZnU1VlpsVkdrR0NLUUpKSEtyaG9F?=
 =?utf-8?B?amk4eW56R2VJOGdzNFlqa0J2VHE2MmxITkE2d1FQdGVHVDhxTWhwZmREMjJB?=
 =?utf-8?B?eFRvZ053ZllLQTY0dGIrcW5SR0luczVjTmJ2akNIN2RPY1FZZkx5R3FVYmwz?=
 =?utf-8?B?RUMvbmZOcjB0U3JBSnlvM2hRclFiV05USzBvQVlNQXlMNHFuZTY5SFJTY0pT?=
 =?utf-8?B?RERFRlhjSThzMHFiQXBWVDZ4VDVCNWQ4THdJQ0tPMnhlQUlua0ViRTM0SDdi?=
 =?utf-8?B?TkMyY0NhTTFGMlJzM0ViTURseEtlN3RVdE5KWEFGNXV2RjVYUFQrYjZtd1or?=
 =?utf-8?B?SzJoT1hBakpTMk9JcHkraEFnWTM0amtvbC8razVDeUwwUEpHZkw0SWpVdEZr?=
 =?utf-8?B?YjNCMnR2dDIwT1FyV0drQmxIM3A0UE1BVGpva3dvdjVwdVZPWjBBUW9QMkF1?=
 =?utf-8?B?MVN2ZXRJSHQ2V1d0R3dxUi95dzloMlNuTEtWZWY3U3Q4YXhOOGJzVHlTdjQ3?=
 =?utf-8?B?cklaOStCa1BYL1pyUkYwYk5FSVplbTVNRDliQWthVStyVWUvazg0Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb7cb707-3a7f-4857-a1a3-08ded9024185
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5119.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 12:54:44.7833 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: upbN1m9hrKCGNwPLLBXXbQbx+E+NPwSW3BY+frGsYo/v7W6oZhLU2QSEv3aqIHusFElW5h++lQ8RAo6aSMVUjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9200
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=avihaih@nvidia.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
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


On 7/3/2026 11:44 AM, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> On 7/3/26 10:05, Avihai Horon wrote:
>>
>> On 6/30/2026 7:30 AM, Cédric Le Goater wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> From: Avihai Horon <avihaih@nvidia.com>
>>>
>>> Before switchover, the source needs one last exact pending query so
>>> modules can flush dirty state. This is currently done ad hoc in modules
>>> handlers. For example, RAM syncs its dirty bitmap in its save_complete
>>> handler.
>>>
>>> This should be a general concept relevant for any module, so extract it
>>> to migration core instead by running a final save_query_pending before
>>> switchover.
>>>
>>> The final query requires special handling by modules (e.g., it's called
>>> with BQL locked, during VM stop), so extend save_query_pending
>>> SaveVMHandlers callback and qemu_savevm_query_pending() with a "final"
>>> flag so migration modules can tell the last pending query during
>>> switchover from periodic iteration queries.
>>>
>>> Reviewed-by: Peter Xu <peterx@redhat.com>
>>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>>> Reviewed-by: Jason J. Herne <jjhern@linux.ibm.com>
>>> Link: 
>>> https://lore.kernel.org/qemu-devel/20260622101214.25770-4-avihaih@nvidia.com
>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>> ---
>>>   include/migration/register.h   | 41 
>>> ++++++++++++++++++----------------
>>>   migration/savevm.h             |  3 ++-
>>>   hw/s390x/s390-stattrib.c       |  2 +-
>>>   hw/vfio/migration.c            | 11 ++++++---
>>>   migration/block-dirty-bitmap.c | 11 ++++++---
>>>   migration/migration.c          | 14 ++++++++++--
>>>   migration/ram.c                | 40 +++++++++++++++++++--------------
>>>   migration/savevm.c             | 20 +++++++++++++----
>>>   hw/vfio/trace-events           |  2 +-
>>>   migration/trace-events         |  2 +-
>>>   10 files changed, 94 insertions(+), 52 deletions(-)
>>>
>>> diff --git a/include/migration/register.h 
>>> b/include/migration/register.h
>>> index 
>>> 5e5e0ee432e537781ce78e84b2ff2d81c33e8f37..6f632123f1d0710de0556e68ba53e068a1e02640 
>>> 100644
>>> --- a/include/migration/register.h
>>> +++ b/include/migration/register.h
>>> @@ -171,6 +171,28 @@ typedef struct SaveVMHandlers {
>>>        */
>>>       bool (*is_active_iterate)(void *opaque);
>>>
>>> +    /**
>>> +     * @save_query_pending
>>> +     *
>>> +     * This estimates the remaining data to transfer on the source 
>>> side.
>>> +     *
>>> +     * When @exact is true, a module must report accurate results.  
>>> When
>>> +     * @exact is false, a module may report estimates.
>>> +     *
>>> +     * It's highly recommended that modules implement a faster 
>>> version of
>>> +     * the query path (for example, by proper caching on the 
>>> counters) if
>>> +     * an accurate query will be time-consuming.
>>> +     *
>>> +     * @opaque: data pointer passed to register_savevm_live()
>>> +     * @pending: pointer to a MigPendingData struct
>>> +     * @exact: set to true for an accurate (slow) query
>>> +     * @final: set to true for the final query during switchover. 
>>> When final is
>>> +     * true, the query is called with BQL locked. Otherwise, it's 
>>> called with
>>> +     * BQL unlocked.
>>> +     */
>>> +    void (*save_query_pending)(void *opaque, MigPendingData *pending,
>>> +                               bool exact, bool final);
>>> +
>>>       /* This runs outside the BQL in the migration case, and
>>>        * within the lock in the savevm case.  The callback had 
>>> better only
>>>        * use data that is local to the migration thread or protected
>>> @@ -210,25 +232,6 @@ typedef struct SaveVMHandlers {
>>>        */
>>>       bool (*save_postcopy_prepare)(QEMUFile *f, void *opaque, Error 
>>> **errp);
>>>
>>> -    /**
>>> -     * @save_query_pending
>>> -     *
>>> -     * This estimates the remaining data to transfer on the source 
>>> side.
>>> -     *
>>> -     * When @exact is true, a module must report accurate results.  
>>> When
>>> -     * @exact is false, a module may report estimates.
>>> -     *
>>> -     * It's highly recommended that modules implement a faster 
>>> version of
>>> -     * the query path (for example, by proper caching on the 
>>> counters) if
>>> -     * an accurate query will be time-consuming.
>>> -     *
>>> -     * @opaque: data pointer passed to register_savevm_live()
>>> -     * @pending: pointer to a MigPendingData struct
>>> -     * @exact: set to true for an accurate (slow) query
>>> -     */
>>> -    void (*save_query_pending)(void *opaque, MigPendingData *pending,
>>> -                               bool exact);
>>> -
>>>       /**
>>>        * @load_state
>>>        *
>>> diff --git a/migration/savevm.h b/migration/savevm.h
>>> index 
>>> b6bb4fa977fae84ed121b0668cdefdf49e3d9c67..81abd96dda94c6c95cc40b3c188df23d11c19463 
>>> 100644
>>> --- a/migration/savevm.h
>>> +++ b/migration/savevm.h
>>> @@ -45,7 +45,8 @@ int qemu_savevm_state_iterate(QEMUFile *f, bool 
>>> postcopy);
>>>   void qemu_savevm_state_cleanup(void);
>>>   void qemu_savevm_state_complete_postcopy(QEMUFile *f);
>>>   int qemu_savevm_state_complete_precopy(MigrationState *s, Error 
>>> **errp);
>>> -void qemu_savevm_query_pending(MigPendingData *pending, bool exact);
>>> +void qemu_savevm_query_pending_iter(MigPendingData *pending, bool 
>>> exact);
>>> +void qemu_savevm_query_pending_final(MigPendingData *pending);
>>>   int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool 
>>> in_postcopy);
>>>   bool qemu_savevm_state_postcopy_prepare(QEMUFile *f, Error **errp);
>>>   void qemu_savevm_state_end(QEMUFile *f);
>>> diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
>>> index 
>>> c334714b31ab4313e26c0cf57091a8cb21e55306..b0f04eb30c7f73e5dd91b1345d71a14cb404a4eb 
>>> 100644
>>> --- a/hw/s390x/s390-stattrib.c
>>> +++ b/hw/s390x/s390-stattrib.c
>>> @@ -190,7 +190,7 @@ static int cmma_save_setup(QEMUFile *f, void 
>>> *opaque, Error **errp)
>>>   }
>>>
>>>   static void cmma_state_pending(void *opaque, MigPendingData *pending,
>>> -                               bool exact)
>>> +                               bool exact, bool final)
>>>   {
>>>       S390StAttribState *sas = S390_STATTRIB(opaque);
>>>       S390StAttribClass *sac = S390_STATTRIB_GET_CLASS(sas);
>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>> index 
>>> fb12b9717f773fdde657911517de9d74c1eb3931..195498845ed95d6a55cf68537a100b4e83221fb0 
>>> 100644
>>> --- a/hw/vfio/migration.c
>>> +++ b/hw/vfio/migration.c
>>> @@ -622,13 +622,18 @@ static void vfio_state_pending_sync(VFIODevice 
>>> *vbasedev)
>>>   }
>>>
>>>   static void vfio_state_pending(void *opaque, MigPendingData *pending,
>>> -                               bool exact)
>>> +                               bool exact, bool final)
>>>   {
>>>       VFIODevice *vbasedev = opaque;
>>>       VFIOMigration *migration = vbasedev->migration;
>>>       uint64_t precopy_size, stopcopy_size;
>>>
>>> -    if (exact) {
>>> +    /*
>>> +     * The final pending query runs during switchover downtime. 
>>> VFIO does not
>>> +     * need a fresh device pending-data query then to get the 
>>> latest dirty
>>> +     * data, so avoid the extra work and report the cached counters 
>>> below.
>>> +     */
>>> +    if (exact && !final) {
>>>           vfio_state_pending_sync(vbasedev);
>>>       }
>>>
>>> @@ -646,7 +651,7 @@ static void vfio_state_pending(void *opaque, 
>>> MigPendingData *pending,
>>>
>>>       trace_vfio_state_pending(vbasedev->name, 
>>> migration->stopcopy_size,
>>> migration->precopy_init_size,
>>> - migration->precopy_dirty_size, exact);
>>> + migration->precopy_dirty_size, exact, final);
>>>   }
>>>
>>>   static bool vfio_is_active_iterate(void *opaque)
>>> diff --git a/migration/block-dirty-bitmap.c 
>>> b/migration/block-dirty-bitmap.c
>>> index 
>>> 7ef3759e5348a6907c0fb3773e2c6cbb0850632e..cba54e25cd50da924e1958bdfc23ce060784b0ac 
>>> 100644
>>> --- a/migration/block-dirty-bitmap.c
>>> +++ b/migration/block-dirty-bitmap.c
>>> @@ -767,13 +767,16 @@ static int dirty_bitmap_save_complete(QEMUFile 
>>> *f, void *opaque)
>>>   }
>>>
>>>   static void dirty_bitmap_state_pending(void *opaque, 
>>> MigPendingData *data,
>>> -                                       bool exact)
>>> +                                       bool exact, bool final)
>>>   {
>>>       DBMSaveState *s = &((DBMState *)opaque)->save;
>>>       SaveBitmapState *dbms;
>>>       uint64_t pending = 0;
>>>
>>> -    bql_lock();
>>> +    /* Final pending query is called with BQL locked */
>>> +    if (!final) {
>>> +        bql_lock();
>>> +    }
>>>
>>>       QSIMPLEQ_FOREACH(dbms, &s->dbms_list, entry) {
>>>           uint64_t gran = bdrv_dirty_bitmap_granularity(dbms->bitmap);
>>> @@ -783,7 +786,9 @@ static void dirty_bitmap_state_pending(void 
>>> *opaque, MigPendingData *data,
>>>           pending += DIV_ROUND_UP(sectors * BDRV_SECTOR_SIZE, gran);
>>>       }
>>>
>>> -    bql_unlock();
>>> +    if (!final) {
>>> +        bql_unlock();
>>> +    }
>>>
>>>       trace_dirty_bitmap_state_pending(pending);
>>>
>>> diff --git a/migration/migration.c b/migration/migration.c
>>> index 
>>> 0f9e891cf85c8e5074f7f9800515e244fa413fa2..ea0b236597087cc005541e1916ceabb229afab4b 
>>> 100644
>>> --- a/migration/migration.c
>>> +++ b/migration/migration.c
>>> @@ -2787,12 +2787,22 @@ static bool 
>>> migration_switchover_prepare(MigrationState *s)
>>>   static bool migration_switchover_start(MigrationState *s, Error 
>>> **errp)
>>>   {
>>>       ERRP_GUARD();
>>> +    MigPendingData pending = {};
>>>
>>>       if (!migration_switchover_prepare(s)) {
>>>           error_setg(errp, "Switchover is interrupted");
>>>           return false;
>>>       }
>>>
>>> +    /*
>>> +     * The final query to the whole system on dirty data to make 
>>> sure we
>>> +     * collect the latest status of the VM.  For precopy, source 
>>> QEMU will
>>> +     * dump all the dirty data during switchover.  For postcopy, 
>>> this will
>>> +     * properly update all the dirty bitmaps to finally generate the
>>> +     * correct discard bitmaps; see 
>>> ram_postcopy_send_discard_bitmap().
>>> +     */
>>> +    qemu_savevm_query_pending_final(&pending);
>>> +
>>>       /* Inactivate disks except in COLO */
>>>       if (!migrate_colo()) {
>>>           /*
>>> @@ -3285,7 +3295,7 @@ static void 
>>> migration_iteration_go_next(MigPendingData *pending)
>>>       /*
>>>        * Do a slow sync first before boosting the iteration count.
>>>        */
>>> -    qemu_savevm_query_pending(pending, true);
>>> +    qemu_savevm_query_pending_iter(pending, true);
>>>
>>>       /*
>>>        * Update the dirty information for the whole system for this
>>> @@ -3336,7 +3346,7 @@ static MigIterateState 
>>> migration_iteration_run(MigrationState *s)
>>>       bool complete_ready;
>>>
>>>       /* Fast path - get the estimated amount of pending data */
>>> -    qemu_savevm_query_pending(&pending, false);
>>> +    qemu_savevm_query_pending_iter(&pending, false);
>>>
>>>       if (in_postcopy) {
>>>           /*
>>> diff --git a/migration/ram.c b/migration/ram.c
>>> index 
>>> 55aa9b47dc8ab8463fd1aeba19726a493b81b070..8918b2f03b6fbcc98532bb45ab905f9bac59384c 
>>> 100644
>>> --- a/migration/ram.c
>>> +++ b/migration/ram.c
>>> @@ -2686,9 +2686,6 @@ void 
>>> ram_postcopy_send_discard_bitmap(MigrationState *ms)
>>>
>>>       RCU_READ_LOCK_GUARD();
>>>
>>> -    /* This should be our last sync, the src is now paused */
>>> -    migration_bitmap_sync_precopy(true);
>>> -
>>>       /* Easiest way to make sure we don't resume in the middle of a 
>>> host-page */
>>>       rs->pss[RAM_CHANNEL_PRECOPY].last_sent_block = NULL;
>>>       rs->last_seen_block = NULL;
>>> @@ -3376,10 +3373,6 @@ static int ram_save_complete(QEMUFile *f, 
>>> void *opaque)
>>>       rs->last_stage = !migration_in_colo_state();
>>>
>>>       WITH_RCU_READ_LOCK_GUARD() {
>>> -        if (!migration_in_postcopy()) {
>>> -            migration_bitmap_sync_precopy(true);
>>> -        }
>>> -
>>
>> (Got some technical issues receiving QEMU ML mails that I'm not CCed 
>> to, so replying here for Stefan's mail [1])
>>
>> Seems like this patch overlooked the COLO case which calls 
>> ram_save_complete() on each checkpoint and expects the RAM complete 
>> handler to sync RAM dirty bitmap.
>> This patch moved this dirty sync from ram_save_complete() (the 
>> removed lines above) into a qemu_savevm_query_pending_final() called 
>> only once at migration_switchover_start().
>>
>> I believe this is the root cause for the CI failure reported by 
>> Stefan, since I was able to repro this locally [2] and the diff below 
>> [3] fixed the issue [4].
>>
>> I have zero knowledge in COLO so would really appreciate some 
>> feedback from Peter/COLO folks if that's a valid fix.
>>
>> Thanks.
>>
>> [1] 
>> https://lore.kernel.org/qemu-devel/CAJSP0QX-8L2CSX5q95Md5V6NTE_4p+K8Kr-QGbqKm2BBMtdh5Q@mail.gmail.com/
>>
>> [2]
>>
>> QTEST_QEMU_BINARY=./qemu-system-x86_64 ./tests/qtest/migration-test 
>> -k --full -r /x86_64/migration/colo
>> [...]
>> # Running /x86_64/migration/colo/plain/secondary_failover
>> # Using machine type: pc-q35-11.1
>> # starting QEMU: exec ./qemu-system-x86_64 -qtest 
>> unix:/tmp/qtest-1415533.sock -qtest-log /dev/null -chardev 
>> socket,path=/tmp/qtest-1415533.qmp,id=char0 -mon 
>> chardev=char0,mode=control -display none -audio
>> none -run-with exit-with-parent=on -accel kvm -accel tcg -machine 
>> pc-q35-11.1, -name source,debug-threads=on -machine 
>> memory-backend=mig.mem -object 
>> memory-backend-ram,id=mig.mem,size=150M,share=off -serial
>>   file:/tmp/migration-test-GF36R3/src_serial -drive 
>> if=none,id=d0,file=/tmp/migration-test-GF36R3/bootsect,format=raw 
>> -device ide-hd,drive=d0,secs=1,cyls=1,heads=1 -snapshot 2>/dev/null 
>> -accel qtest
>> # starting QEMU: exec ./qemu-system-x86_64 -qtest 
>> unix:/tmp/qtest-1415533.sock -qtest-log /dev/null -chardev 
>> socket,path=/tmp/qtest-1415533.qmp,id=char0 -mon 
>> chardev=char0,mode=control -display none -audio
>> none -run-with exit-with-parent=on -accel kvm -accel tcg -machine 
>> pc-q35-11.1, -name target,debug-threads=on -machine 
>> memory-backend=mig.mem -object 
>> memory-backend-ram,id=mig.mem,size=150M,share=off -serial
>>   file:/tmp/migration-test-GF36R3/dest_serial -incoming defer -drive 
>> if=none,id=d0,file=/tmp/migration-test-GF36R3/bootsect,format=raw 
>> -device ide-hd,drive=d0,secs=1,cyls=1,heads=1 -snapshot 2>/dev/null  -a
>> ccel qtest
>> Memory content inconsistency at ea2000 first_byte = 53 last_byte = 53 
>> current = 54 hit_edge = 0
>> Memory content inconsistency at ea3000 first_byte = 53 last_byte = 53 
>> current = 54 hit_edge = 0
>> Memory content inconsistency at ea4000 first_byte = 53 last_byte = 53 
>> current = 54 hit_edge = 0
>> Memory content inconsistency at ea5000 first_byte = 53 last_byte = 53 
>> current = 54 hit_edge = 0
>> Memory content inconsistency at ea6000 first_byte = 53 last_byte = 53 
>> current = 54 hit_edge = 0
>> Memory content inconsistency at ea7000 first_byte = 53 last_byte = 53 
>> current = 54 hit_edge = 0
>> Memory content inconsistency at ea8000 first_byte = 53 last_byte = 53 
>> current = 54 hit_edge = 0
>> Memory content inconsistency at ea9000 first_byte = 53 last_byte = 53 
>> current = 54 hit_edge = 0
>> Memory content inconsistency at eaa000 first_byte = 53 last_byte = 53 
>> current = 54 hit_edge = 0
>> Memory content inconsistency at eab000 first_byte = 53 last_byte = 53 
>> current = 54 hit_edge = 0
>> and in another 13488 pages**
>> ERROR:../tests/qtest/migration/framework.c:190:check_guests_ram: 
>> assertion failed: (bad == 0)
>> not ok /x86_64/migration/colo/plain/secondary_failover - 
>> ERROR:../tests/qtest/migration/framework.c:190:check_guests_ram: 
>> assertion failed: (bad == 0)
>> Bail out!
>>
>> [3]
>>
>> diff --git a/migration/colo.c b/migration/colo.c
>> index 2d36f933cf..5c486c09ef 100644
>> --- a/migration/colo.c
>> +++ b/migration/colo.c
>> @@ -409,6 +409,7 @@ static int 
>> colo_do_checkpoint_transaction(MigrationState *s,
>>                                             QEMUFile *fb)
>>   {
>>       Error *local_err = NULL;
>> +    MigPendingData pending = {};
>>       int ret = -1;
>>
>>       colo_send_message(s->to_dst_file, COLO_MESSAGE_CHECKPOINT_REQUEST,
>> @@ -465,6 +466,18 @@ static int 
>> colo_do_checkpoint_transaction(MigrationState *s,
>>       if (migrate_auto_converge()) {
>>           mig_throttle_counter_reset();
>>       }
>> +
>> +    /*
>> +     * Run the final pending query so migration modules can flush 
>> their dirty
>> +     * state (e.g., RAM syncs its dirty bitmap) before this 
>> checkpoint's live
>> +     * state is saved. Unlike a regular switchover, COLO reaches 
>> completion
>> +     * repeatedly for every checkpoint, so this must be done on each 
>> one.
>> +     */
>> +    if (!qemu_savevm_query_pending_final(s, &pending, &local_err)) {
>> +        bql_unlock();
>> +        goto out;
>> +    }
>> +
>>       /*
>>        * Only save VM's live state, which not including device state.
>>        * TODO: We may need a timeout mechanism to prevent COLO process
>>
>> [4]
>>
>> QTEST_QEMU_BINARY=./qemu-system-x86_64 ./tests/qtest/migration-test 
>> -k --full -r /x86_64/migration/colo
>> [...]
>> # Running /x86_64/migration/colo/plain/secondary_failover
>> # Using machine type: pc-q35-11.1
>> # starting QEMU: exec ./qemu-system-x86_64 -qtest 
>> unix:/tmp/qtest-1417324.sock -qtest-log /dev/null -chardev 
>> socket,path=/tmp/qtest-1417324.qmp,id=char0 -mon 
>> chardev=char0,mode=control -display none -audio
>> none -run-with exit-with-parent=on -accel kvm -accel tcg -machine 
>> pc-q35-11.1, -name source,debug-threads=on -machine 
>> memory-backend=mig.mem -object 
>> memory-backend-ram,id=mig.mem,size=150M,share=off -serial
>>   file:/tmp/migration-test-0TMNR3/src_serial -drive 
>> if=none,id=d0,file=/tmp/migration-test-0TMNR3/bootsect,format=raw 
>> -device ide-hd,drive=d0,secs=1,cyls=1,heads=1 -snapshot 2>/dev/null 
>> -accel qtest
>> # starting QEMU: exec ./qemu-system-x86_64 -qtest 
>> unix:/tmp/qtest-1417324.sock -qtest-log /dev/null -chardev 
>> socket,path=/tmp/qtest-1417324.qmp,id=char0 -mon 
>> chardev=char0,mode=control -display none -audio
>> none -run-with exit-with-parent=on -accel kvm -accel tcg -machine 
>> pc-q35-11.1, -name target,debug-threads=on -machine 
>> memory-backend=mig.mem -object 
>> memory-backend-ram,id=mig.mem,size=150M,share=off -serial
>>   file:/tmp/migration-test-0TMNR3/dest_serial -incoming defer -drive 
>> if=none,id=d0,file=/tmp/migration-test-0TMNR3/bootsect,format=raw 
>> -device ide-hd,drive=d0,secs=1,cyls=1,heads=1 -snapshot 2>/dev/null  -a
>> ccel qtest
>> ok 2 /x86_64/migration/colo/plain/secondary_failover
>
>
> The culprit appears to be patch 3:
>
>   migration: Run final save_query_pending at switchover
>
> I can reproduce the issue consistently with:
>
> while [ 1 ]; do
>     QTEST_QEMU_BINARY=./build/qemu-system-s390x \
>         ./build/tests/qtest/migration-test \
>         --full -p 
> /s390x/migration/colo/plain/secondary_failover_checkpoint || break
> done
>
> The patch you proposed seems to fix the issue.
>
> Could you send it as a follow-up patch? 

To make sure I get it straight, you suggest to merge your pull request 
and then send a separate fix patch for that with a proper Fixes tag, right?

> if Peter, Fabiano, Lukas
> would prefer it to be integrated in the appropriate place, it
> could be included in v5.
>
>
> Thanks,
>
> C.
>

