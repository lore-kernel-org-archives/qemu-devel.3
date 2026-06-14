Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46A0ACD98D2
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 09:51:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYhUA-0007Bj-CC; Sun, 14 Jun 2026 05:50:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wYhU4-0007BI-1y
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 05:50:29 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wYhU2-0008J6-BX
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 05:50:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v6n76waELO2ghhE5F+p0gyffyMhf0lYSCqgVOwc7eGmnmeFEZmpQHQV7iXa2gLZX12ZcCKIYvvtvC/H/3ofHPo1X+qKdiLeJ5Owq/AQOffsrnBD23lormfmAT3GiMCA/LEdgDM8FDj41s/aLKyICV4Itb+BMHiuOBQ7Xth4ydI+9L0Kt4zmkZ+TXxtOwcYJ4sCgIyh/eUzHiMausXMJdsOae9BU5NUCA3A2MYW0VfBnNRSPuluk4nem3vu/9TeS2+8/URyfTCOz3jviW6REHuxq7t6yYxRcF428vdJIJKfbZpDfKXZqFjmgyJD3ZBHwCfEbbozBCpgDuOh/40/qsEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zm8PC/WEmLsNU2Ywzb+uLhA1weVcxszjQ+Dc0Evq5m4=;
 b=izFNuXbeZmLLflsBYi6r46RhX6K9L8DK+z4ioyQEuxWDcxbt9bmNjM9IjiQdzWVpccmhZMWQrRtCo+UMPnbzi3oaQdqSrMXRnu+KSLViTR8TKJKO6zowBGcWaG58WjaArhZp0Q5NsdIUH73ZcDT8XCFyrgrHoEWftdtCXcQ5WYARbLLrFcYWAvoyvJVaDN/G4LtZJrXYqc7Qj2yY/5LBUmuhm8ximt+bSuwT7BwxwJL1Pupe1wR42NWm6P1c/d+jkLMJ7VcNnegWIH/8WYZ+MHlQwrvU/AR1wNy7N23mcfOESy5vmPy6Dsm04jdoVo64ZKvONERbP2v7Ndp/zcn3Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zm8PC/WEmLsNU2Ywzb+uLhA1weVcxszjQ+Dc0Evq5m4=;
 b=kmZr4sTmhK6A7cvoBEwGY6awHaIziA1z4h9PU1V13n4hKf9rN1r2Dcv1h+hqyZ96tlCepx+vdHeNY5QeNeYIo/dsb2FEYdSlJ9wISMpkfzdB1IIL7UIUq9CyiCe1duY0je67Js9xHp4mBWTmk8peQLa7hx0k5ICAgqkzJp2aU8MjUAj+Rey96z3a2Tewa4fpFirdljZAQHNy3lEwgZJggofptOMrnXUIEQgWqYry2wkbX5fXLRbjAJqZrxJ5R1eunzNRFR6rclcUdFg+iPJdJ6tiQAE7SVAiZIo9W63wr/WqiTdCIH20jBqgGm/Oof2TpXiwq4MqMU/qt+PImg5ZBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by IA1PR12MB7664.namprd12.prod.outlook.com (2603:10b6:208:423::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.16; Sun, 14 Jun
 2026 09:50:21 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%7]) with mapi id 15.21.0113.015; Sun, 14 Jun 2026
 09:50:21 +0000
Message-ID: <e4d00894-990b-44b3-b89c-7cd1b0398a0a@nvidia.com>
Date: Sun, 14 Jun 2026 12:50:14 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/14] migration: Make switchover-ack re-usable
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
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
References: <20260609075812.32067-1-avihaih@nvidia.com>
 <20260609075812.32067-8-avihaih@nvidia.com> <aiww8tN6dRLA3t_R@x1.local>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <aiww8tN6dRLA3t_R@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0028.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::10) To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|IA1PR12MB7664:EE_
X-MS-Office365-Filtering-Correlation-Id: 74deb998-5a41-4c7d-bb95-08dec9fa591b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|366016|1800799024|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: heW0NU2nvNfDXSVQz88S8K1x91x9dS07yS9U2q2TH6IvFuy1/d6GlQ7rnmRmbD5zaTwiqsLGjJLZmu8BceDmNBUOrWAiul9REIC7xtB/2iKlA91Fz6edYu/Pxdqzny6BoXDJEWrBup3L3fqXHjme32ByJm4jDdb6oU6WNM4jE3dym2zAna7lbjYlyccL6PzVR3tiV0sBx5C38fpvcpJkUSDgtrB70Ao9Xojz5HYow6jVaqWMXul5L5QepcyzEx2XD50mfL8KKFADoaznYv+e1FK+uLnhSeYBKxICS0ZSnnSBmmuuIVYpRlgrYbhZR0qx8SdG3LmGhgggBapy/mNacsvwkyB1E6Kuut/UuOyvwypXgbNLHzy/vCby9Uc9W4DdKSTfi79VxSUYtp6lc0fQMeMDe3LMRKQGzC7PF9UUsarFmSaVlCo5qXgg1+Vg8iLEZf+0fWArBmIcRTurbcnerGyrjwH2ulphyHFDT8h1KXOf4nPXXBhFW08cFkaQ7wWfJ9ApJqo/JmOqA9KWiwPYhxVs0uzupuMajsQcjPJymZmw1P1IHEn5ql7i6WsXsQrBwiTIrxzZN/H1zLbhtJZMLHT1FCEf7KBgKOSnoAILUuBThAg79giUeUBVb2TAl3oP01/6DB8jHvDndjfa1hap6jERy63BBCS17poYXMEfwGUBweeg+GwaRCfJu3j+qxS4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHlJZDR1Y2Q3M25QK1QwdjN6SnJCeFZ0MTZuK2htUndHUFJneGdETlByWllO?=
 =?utf-8?B?UW9nOVkxVWhzRlpWakhQZ0lJVEozOU1BZktGNzNGdU1HWTlZYXdJSTdJV2pX?=
 =?utf-8?B?NDV5cVF0MnAvZ3RvcFVaVFpOdkRpS3JPaWNLdm80Y2N4VDhWcUczR29WaHBJ?=
 =?utf-8?B?OWZ0ZHNkaUZaYjdCdUpUcjdzeWlhM2tPOG01Z2wwTktUeWVJTFFiVk0wT1Jl?=
 =?utf-8?B?WHhnN2cyOW5sRHhtT25VNE1VSk9ZY21BaWV6WXBaZzZReFZNVjVVdXhhYklm?=
 =?utf-8?B?dk5idXVyenR0UFQxRC8vNTU5R3FBTHBkUFdpMTNqdHBjOFhGdnQwZGtvb0JS?=
 =?utf-8?B?ck5maUpBY1lOcFdjUU5sb3BxUmh6V0JkbGwweWlwRDZDL3JyZndzdVJqZUlm?=
 =?utf-8?B?dm9WWm1HdkNoUjRMSjllYUU1NDJ6STRsYmhWVjc4WkxKMHF1MW0yL2pWQ2cw?=
 =?utf-8?B?a0xVSkNQRldlVnVBZjR2aWoySE1Pbm5jU3JZUzEyeFRwL2VyS0t3dFZEa2lF?=
 =?utf-8?B?NnhXUUpZYk5rREFtK2ZiTC9IWHJJR2g2WkYxdWpQQmhUQlI0OVFhK2VSWGxE?=
 =?utf-8?B?aHRpdklhcGdkRVRnMkZPVEhWVTJHYWVsRGpnaUUzaUhSM2tTWlBUamcvb3N1?=
 =?utf-8?B?djZaNFpCMGV6MW9CVjhWcEc4VVB5ZkVDNTRUNk1Camc0K1drQTBHVXhHL1M0?=
 =?utf-8?B?Ni9HUDdtNW5jNU5mbEFRSzl3a1JxeEZUUnVWUnpSV21kaFlrcnl0eXA0NVl3?=
 =?utf-8?B?M1M4SE93bzlMM3BWWmV6VEV6QW5FbUljcTIxTE9vZHF6YXJxZFdjN2RtR3JG?=
 =?utf-8?B?TGZFRTNLekoyN2NKRy9IQUF5Y0k0dWpIQ1VxNEpYbWJzaTZBMGplVnJhS1hM?=
 =?utf-8?B?ditCUHEyOGtldDExSnRyalNyQXFNNm5rK0lBc2VLZkdHZm0xemwyS09sMXls?=
 =?utf-8?B?MklFQkc3cjdMK0U2TjVSMzVIYllVN1Y2ZWlybnIydWlUdlRwZlVvOUkzYm5m?=
 =?utf-8?B?UW1qSTAwOWdiMmlUaGJJTnNaaVV2L09SSjBwUVk4alJvN3NNeUxKSU1rNkJh?=
 =?utf-8?B?bHVlVFhTazl1d2NWcXA1WmxZcVRmME5ZY28ybktGUkh4eTczQnlqeFZMYlM2?=
 =?utf-8?B?MjZhRnBZZzlBd2FXajhScE9OeWtoOFd4c1E5ZE9XSDZMSjZyMnZCUC91MHc3?=
 =?utf-8?B?bjFVbDYwNmZ0MkRlWUFoN2Y5U1YwYlFuMVBaTFVjUERwS3JwaVBjRXZKV1hi?=
 =?utf-8?B?UnJGUGhzRWdoVGQwUi90RS9PVXRsVm1xNDAxL21rOTlLdVlZUXM1MndUWmhM?=
 =?utf-8?B?RnB5Y3pkQS9zQ3ZzOVFYUXlSWjN4bXpnQkdEbVNaOHNvbnN3aGdFWnI0eUdx?=
 =?utf-8?B?UmtoZG0zVnJFandFU01MbmxCUXltcnNaWW9aZm1RK3F2aTBud1lQMWVHTEgy?=
 =?utf-8?B?Q3VnekYxQzN4dllkOHp2anNFSEN2TGlhMWcycm1VbVVMM05hNk0wT0psNVVs?=
 =?utf-8?B?ekFINFRTbFdMNmdlUllKUnRNYWcwZms3Q3NlaHRDbHVCM3VFVlVOYTJyMUw4?=
 =?utf-8?B?YzBRS09MaThKV1RqSlgvUHJSMThGZWlFV1A1eTV5OWFieWF5MGdvT0hSR1VC?=
 =?utf-8?B?YXBaTkJ1c244c3hkZG1Bb1ZYK21hZHdvT0UrM2t3UnoyTklxa0Jxb1A0alF1?=
 =?utf-8?B?RUM0MUs2eGdJK2VrekQrS1UvMEMzeXZYNlN0ejM2ZG5vdkdmSzgyNTJ0dG56?=
 =?utf-8?B?dFE5SGNuYUxBU1NMVzh2UlZKVlJBMVZXckVMcmVoNW1uMUxJUzdOdnl4K0F4?=
 =?utf-8?B?WDlMVTFzN3BaTExSNmtsYm5VZGF0SnVNeVpZbjZrS2g4bVY0VTJmU212ajdp?=
 =?utf-8?B?MlRhUFpldmZuVk5VN1paYjJld3lMRVVGdVU0YkxxUEhaeXROdjFJZFpoSXNo?=
 =?utf-8?B?WlBJemdPZ0l2SXpxY2V2dWtJcGlKVWZHamU3cTRuR0IvWUhjeFNxTVFWSGNN?=
 =?utf-8?B?dTFHM2k5TnpQS3JzUlB1ZDg4VGJaK2l4UzdBZ3hvdVViREZlbDJaTitkZURC?=
 =?utf-8?B?WWdBSVhBSDhoclE2ai96V2hGWktPM3NqQU9NQWY3ZlErRWV2QmJCaVFWanZj?=
 =?utf-8?B?T1ZuTUw3KzVaKzlkQnU4UWdJb1VxU2JNS2JjUU1UYi8yZzdEU29OQVRyUlZa?=
 =?utf-8?B?aFBzM21kaDF1ZE9PWW1EWldlNmkzb0Rxc2hGRkNDbnpQQWMzcEVhVkZzREJX?=
 =?utf-8?B?ckU4RVpnV1FSZFRaWDBlYjl4TFoyQ1ZGc3RMVzkzSDJ2c2d4b1dtZjJjb1Mz?=
 =?utf-8?B?bUZCSWRodHowSjFjOGUxZHZOQk1MSnEwNWJlRzB3RUE0OXN1M3NLZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74deb998-5a41-4c7d-bb95-08dec9fa591b
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2026 09:50:20.9561 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 88QKcS12gevNdmyJnB4HGLzXhP5p8asCYWoqv0wCdMxW7vHlzNZ7xnC8Iwfq/bdG7pgvwzMQ5ANkSBq12ZgKiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7664
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


On 6/12/2026 7:16 PM, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Tue, Jun 09, 2026 at 10:58:05AM +0300, Avihai Horon wrote:
>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>> index 4d8b15d99e..8219f13779 100644
>> --- a/hw/core/machine.c
>> +++ b/hw/core/machine.c
>> @@ -43,6 +43,7 @@ GlobalProperty hw_compat_11_0[] = {
>>       { "chardev-vc", "encoding", "cp437" },
>>       { "tpm-crb", "cap-chunk", "off" },
>>       { "tpm-crb", "x-allow-chunk-migration", "off" },
>> +    { "migration", "switchover-ack-legacy", "on" },
>>   };
> This line needs to be moved to the last patch, or people will get very
> confused on last patch flipping default without caring about old behavior..

This patch Implements the compatibility flows for legacy switchover-ack 
which use this property, so moving this line to last patch sounds even 
more confusing IMHO.

The last patch should not be viewed standalone, it's tightly coupled 
with this one. Plus, it doesn't make sense to have the 
switchover-ack-legacy property if it's always off.
So I personally don't find it confusing, the last patch simply enables 
the feature once everything is in place.

If that helps, I can extend the last patch's commit message to something 
like:

   Now that VFIO has implemented new switchover-ack, enable it for new
   machines. Note that legacy switchover-ack is still used for
   compatibility with older machines via a compatibility entry for
   switchover-ack-legacy property.

>
> After move, feel free to take:
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
>
> PS: If Cédric feels comfortable updating that while queuing it'll be fine
> too.

Thanks.


