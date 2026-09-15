Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC96BC88E53
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 10:01:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Pyo-0000bs-Cw; Tue, 15 Sep 2026 06:01:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x6PyW-0000ae-P1
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 06:01:25 -0400
Received: from mail-francesouthazon11021142.outbound.protection.outlook.com
 ([40.107.130.142] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x6PyT-0006Gk-Ih
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 06:01:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v63Cm+CjBbOTtECT3tD9DXda0zTZ/dBERWmdgJ4/xDESE1KP4xNyZTSdC3xCQMPbvwLiS6VhhIlY4mWoKH8rAPpKv7Hcob/UaX+hd+s7mNfMfdpxvTd/tVkLlRpypw0jNarl+xHB5+eZbK/ONZRVj86la1KXrsCiw/NmWf7KTRLCRNk2D04MdcCVWKD50U3oOMyJAwEHgXTXnjRYy+KN/a23+RbRxpRGx+vB/S9pe3+zqxzEZsOjq3BsjI0tIyO13a9Tv5rqBt0viAIl3DnXPmrqS+M8lo9rdewkJMlGTrf96CJkvTnKKnZpZbcWxrey3tg+taL8RUWH1LIC/dlCKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ue9XEgHlAgad1Fg+N39LzGe6Qn3T5eSLxS9gsvxkDXo=;
 b=nrE5r407XkdHMMZx0VeL2E6lDtPVOd/3j0Nb7sjM5J7yRUdYjgCj6WZ2yh7N1mnZxzAEDGHFKx8X/l4Pi6mCZ2i28eVCei+RKsRQcTdD5i197JhoG3VefGU7SX+oWvPJVU3aZ3nAxZPyHvK+ABi7M1SKGRLephFy4l90LJU99CZ4LHwsTG1cwBHIH+AXsiKAkI+4EUldJs6wy3tG5uIZWH1wHI5RPZ2OzSWRyH5TrSn9s8FsNsQZnJ6F6AwjRX83UbxFkNhpk8la+nLdcujEG8RXZSHQTIPRHqSLfWmlogcaFd6z9JzSZ+B3YqNNjlSOzWpqu6HDQm7UexHt41tRNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ue9XEgHlAgad1Fg+N39LzGe6Qn3T5eSLxS9gsvxkDXo=;
 b=gfEW1n/WU9OlssxYntx9Y1pSQALxbVvJn6kmVPYY+hP6Z3GKijx/oxNQB08ej93uyYpC+e1rJgLgzUyg3jZi9xnj+/It8K+jPYaP5mH6VBhx0QxGY1uRPJdN2Yrs3rTkAu3V2KfkF4hV0psz039DKAwCjKJ00gR/tM7dkSgBgsByceNdUevnzD8jJ5inhUGUokjVE0uO5IyBULUI3JEGxSXxhWVUCqIjEC610H7Ddn/dG4GhP1I2gnQIDzVF73H9ZT9vR62RfoNg6wY1OZtjEtqIb/aqrjfHevcoyMTT6V+mW1sOHHY6VKYTK3IEFl/AW2rELcZc+FIdYc0cYs5IrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by GV2PR08MB8512.eurprd08.prod.outlook.com
 (2603:10a6:150:c2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.7; Tue, 15 Sep
 2026 09:56:05 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 09:56:05 +0000
Message-ID: <940c273f-6205-48ff-9bd6-e4f9cc05f9cf@virtuozzo.com>
Date: Tue, 15 Sep 2026 12:56:03 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/14] vhost-vsock: preserve vhost FD during CPR
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, philmd@oss.qualcomm.com,
 maciej.szmigiero@oracle.com, bchaney@akamai.com, mark.kanda@oracle.com,
 den@openvz.org, farosas@suse.de, peterx@redhat.com, clg@redhat.com,
 dongli.zhang@oracle.com
References: <20260914-up-vsock-vhost-v5-v5-0-d17423589f48@virtuozzo.com>
 <20260914-up-vsock-vhost-v5-v5-9-d17423589f48@virtuozzo.com>
 <aqf9QkwF9J8SkHA4@sgarzare-redhat>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <aqf9QkwF9J8SkHA4@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0242.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::12) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|GV2PR08MB8512:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a127913-7fa3-4596-1483-08df130f8eb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|7416014|366016|1800799024|4143699003|56012099006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: fi4Rx4YZyQ7ZT10YkYlspOmHHrltvF+wD+PRezuCanDyr5J45w8dg4psNo6p6yf6L2Iq5qFhguVaohFXIZGw2x689JAWMY97/V3r5sqhKl7exCGqdj1K1F2gTGSh3Qyisubf3XHub8Joe7D0RN++HWxRxf/inEaDesIpwjIzAcLfyifleHfh0msJoao1nofcOoT1m4T7M92S0WR4VX07YGZRbQjZVOxBEo3dLWPx58T16va+tiKZT2w/9/ptvy6ZeOoSlju6HNLEuk5uQngVA6y3Y3sudRDUQeSW72Puo1lq9KGnaildSz05PWag8JUsahCHOSav2kqlm6IJbn2Jd0rpkduw8Xm3ZR9aqJO9sloyfJRiUzPRfI8wmQDWbTkj+hNOqv94vWIG+AHHXeOKFvIKTy0ltM3VqHiLNj0RVhUubZ/nvL1dv4qVlEt0gBd6kejmJjffakbm7ODEKXoT66/Sg4wQ2zXEnloU+tePpbGLHbFZYcdGUoUqyRvphuuQEX+vvM6UdzFRCmoTbeyCoLRs3dJkHqUyh6bt4nwvYdTrCrR9TsSAegVbChgHNF8Qr46Fi6Zqrj8jBu/3Du3B8y1iFOrQqqhMKYBXtG8ZcfDLh6oEQ90FCNDxaqeGpJrrcjvjo/qVdDyZD84zRnATJyHImwol+hgmGFDpvXP0guw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(4143699003)(56012099006)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2U5OGxZbk85NGJBRGd6MGFyZWpOdVBpeXRiTUlUVWtHdVpaaVBxVVFWcmZm?=
 =?utf-8?B?TXQ4QUlpa3JSeElsZXlsd2NKTnVPOEFVTlQ5b3lSM2ZMa1h0TDcvRFlxa0hO?=
 =?utf-8?B?VWpEVHZFMXNScGI4L3Fha25VZHlia3VjaVpFK0NwT01pMG5Lcno0WERxZDY3?=
 =?utf-8?B?M3JVTDlrY1FqeW41djc3WVpUTDN3bWRpWVlVZDh1dldjbjU1RW80U05rajBZ?=
 =?utf-8?B?bDZZZ0tLZ0J2VENCVUI5M3d0ZGFLTHFZMEwrdE5ZaWh3T2VUVXdlYVlCVmJ5?=
 =?utf-8?B?aTlwdUR6TXNVWjJwYzVVT1grZnRlM2dQaEtyRlUycElvSHpvWVZPUVZJZUJD?=
 =?utf-8?B?ZjV1dTNFSzdLM1RHQlhUN2VsLzJxZU0rUjh4NU5nU2FOOXRlTGMxd3ZGZ0VS?=
 =?utf-8?B?SXorcjg4MmhqTmNxRkdlTVBMOXBHSXZxN3dEd213TkZDSUhmVEdpN2h1Zys4?=
 =?utf-8?B?VW9scDJaRlR4eFpqOTBjdzQybWtubG56Ly9vdjhUZjRsdTZoM0NyeERjbW0w?=
 =?utf-8?B?M2c3N3FPMWhxcmcwSk9WWHJaNDBTd0ZvZ25kS0YyL3VnZ1VRTFJhQWppTWsx?=
 =?utf-8?B?Ui9odU9rT1dLTVNOVjUzYjlhTkVpdDVxbTBlTS9acHJ2N2R4OVpyWjdXZWlO?=
 =?utf-8?B?ZTA2ZjNseXMyT2hTS0crS2NpYVhJOFNpVkUvbnVCYjFDb2VNbFZQT3dOQkYz?=
 =?utf-8?B?c1hQcVNuMVlvZlVDeXd0TWZneGFmWnFqMXZiZkNBZVdjSFNqaUppais4U1J3?=
 =?utf-8?B?WkUvdDFKYXJnNGhEU0JnUWxLbC8xRjFkM2xteFNCbkVZTnh2M1k2eEVXM2t6?=
 =?utf-8?B?aExWclVzcjI0VTlVTGkyUE9WQzhHK2ZTT28xaGg0ZzV1Vy82YTVFMU1RUWZv?=
 =?utf-8?B?djFlNDd6TGdySHNUVHdyck5Ld1JmemFQTmx6U1BJeFlmbHR2Vi9iVUJOSklE?=
 =?utf-8?B?aXp5WFdUUkNwWnhsMTNhSlJMTXhLOE5sTXRtSnJraUtpNG0zOU1VN3VLd2Rt?=
 =?utf-8?B?VytWZmlYU3BRS1dXZ051RWdSUW5kbzJZRVp0aHU2UUNrSC84NlIxcU43amxD?=
 =?utf-8?B?WnVNdE9VNlVwS2haZDZvV2pCY1hGT0xUY1ZmNHppcmdZSk5PbHNKMFN1OThj?=
 =?utf-8?B?dHhBbEVWTllxUEVFcTdUTXFxd1Z1RWo5ajBVTDdlMmRlS1ZNN3RHbXVTWGEw?=
 =?utf-8?B?cksxSWswbCt6cGtQZjVVd0ozWVNtUjMxK0k5ZWtDc01XaXlKWUlSb1lodjRi?=
 =?utf-8?B?NEoxRVVCNG11NHFKams2U05STG8zbXVYY3FUL1J5SUVOeXlSMithMEdaZ2F2?=
 =?utf-8?B?a2dCd1hRVDB2MmNGQUp4ZnFGYVlCRG5EMDNsNXROcEpSRXhIblBJNzR4YU5u?=
 =?utf-8?B?NHF0VVVoQTQ0akVOZHMrU3JkQWtDTk4wVjVEeFJMQnQwenQ3STcybDd1MFVG?=
 =?utf-8?B?eEpaYzVib2ZCN3ZCQzNJMkl1Uy9jazhHUkJxWUlWTVNoNFo0cStYVnByditl?=
 =?utf-8?B?SDNKV0dadE5EQy9vT0pmTTcwOTBtSStKbVdMcTREdjZIc255VTd0YlFjUTRU?=
 =?utf-8?B?Skd2cm5qQi92NEVMc0hqTjNidnd4cGJ2QzBDVkEwSUJ0OEVhV0hzeFFnNDZP?=
 =?utf-8?B?eE5VSGtpU1k2VWc4cWJQaUFiSU9PSEE0eUVkcDE3dCtmRUZQdklCeGdsdEZ1?=
 =?utf-8?B?MmsrQ0h2cVl1TndYSTlsSGhsU2NlbWFVQUY4UzhOVzF1NWxtYjdsSXJQQklK?=
 =?utf-8?B?UXhRNzMxRUNwWGFBeEhaUFVIVVNQeC9hTXZQamJtazR2TzRaSlIxRWpzZ2E5?=
 =?utf-8?B?N3RJWWkyMHhrTnd1NkJBVmE1dzN4R3JNVnVRa2tyTEQyeUl5eUU5MlZuUWZk?=
 =?utf-8?B?c0lHUVBGZ1prS3RMMWhJajZZNWxzbm8xeDVkMndmSWozRjkybGJBcEZiL0pK?=
 =?utf-8?B?Y2o4UlpVN0NiM05obmE3di9UaVFRRTlOMGIzV1luK3JwRHhvTjBUMGhKR1pq?=
 =?utf-8?B?aUhKNW50Z2FwaEc0QzBRcUtubGVXM0Radm5vUFZnL1pUZlNuaXFOYWYrbXls?=
 =?utf-8?B?WGxteU12Qm5mRFYvY2lhek1sd21LRFBmL1FpU1NhcjN0K3JnQ0kzbVQ1REFI?=
 =?utf-8?B?M2pKb2lDSGVmYjF0dWxFZVVpWjFnSis5ZENhTFo5bmUydWhGSkl1RDI3bFNM?=
 =?utf-8?B?Z2VzN25RZjJwdlNNenFsNE9aak1uRU9yT0Vmc1owcTRnODUyY0k4UVduTWNu?=
 =?utf-8?B?dkRrRk1MMnhoNEUrOTE2bk9UeTJFc1UzdzVCcWFNNjBiNTIyMHkxZytOZTZS?=
 =?utf-8?B?WHZGUXlRRVBoSHJjRDdpdUxuS1JFMGpjZDVhSTlacjd6U3VDR2paY0x3empE?=
 =?utf-8?Q?+stYgYwzpH7HUYz8=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a127913-7fa3-4596-1483-08df130f8eb5
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 09:56:05.2738 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qRoW9h3yfgu6lRX6s/gO/p8BFs750vW9wFE6IQbM+vQjkHKqKMo0ZZkKzF9cP+KdvL9gjlZpjiBwbZr4httS4z/BZKhyJUJgKl5gr+QJIFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8512
Received-SPF: pass client-ip=40.107.130.142;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/14/26 6:16 PM, Stefano Garzarella wrote:
> On Mon, Sep 14, 2026 at 11:37:40AM +0300, Andrey Drobyshev wrote:
>> During CPR (checkpoint-restore) migration the guest keeps running on the
>> same host, so instead of reopening /dev/vhost-vsock on the destination,
>> we should reuse the FD from the source.  The FD is saved in the CPR
>> namespace (hash table) with cpr_save_fd() and then reclaimed on the
>> target via cpr_find_fd().
>>
>> Since the key in CPR hash table is the (prefixed) device ID, CPR needs a
>> unique ID.  Thus we only preserve the FD with cpr_{save,find} if this ID
>> is present.  In a following patch, when we lift the CPR migration blocker,
>> we're going to condition it on the presence of ID.
>>
>> vhost_dev_init() (and thus VHOST_SET_OWNER) still runs in realize() here.
>> Deferring the ownership handoff to pre_save/post_load is done in a
>> following patch.  Until then CPR remains blocked, so the restore path
>> added here is not reachable yet.
>>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>> hw/virtio/vhost-vsock.c | 30 +++++++++++++++++++++++++++++-
>> 1 file changed, 29 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
>> index 3ec20d87606..203055354ae 100644
>> --- a/hw/virtio/vhost-vsock.c
>> +++ b/hw/virtio/vhost-vsock.c
>> @@ -69,6 +69,10 @@ static int vhost_vsock_set_running(VirtIODevice *vdev, int start)
>>     return 0;
>> }
>>
>> +static char *vhost_vsock_cpr_name(DeviceState *proxy)
>> +{
>> +    return proxy->id ? g_strdup_printf("vhost-vsock/%s", proxy->id) : NULL;
> 
> Sorry, I should have asked in previous reviewes, but is it okay to use 
> the proxy in any case?
> 
> IIUC this will work well with `vhost-vsock-pci`, but what about MMIO 
> deivce like `vhost-vsock-device`?
> 
> Also the "proxy" is used just here IIUC, so I think we can move that 
> here entirly to reduce the diff, I mean pass `DeviceState *dev` as param 
> here.
> 
> 
> While looking better at the code, I found qdev_get_dev_path(), can this 
> work fine for this scenario is some way?

I haven't indeed tested this series with buses/transports other than
`vhost-vsock-pci`.  qdev_get_dev_path() looks more universal in that
regard, so I think you're right.  I'll use it instead.
>> +}
>>
>> static int vhost_vsock_set_status(VirtIODevice *vdev, uint8_t status)
>> {
>> @@ -143,6 +147,8 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>>     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
>>     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>>     VHostVSock *vsock = VHOST_VSOCK(dev);
>> +    DeviceState *proxy = qdev_get_parent_bus(DEVICE(vsock))->parent;
>> +    g_autofree char *cpr_name = vhost_vsock_cpr_name(proxy);
>>     int vhostfd;
>>     int ret;
>>
>> @@ -170,7 +176,19 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>>         return;
>>     }
>>
>> -    if (vsock->conf.vhostfd) {
>> +    if (cpr_is_incoming()) {
>> +        /* Reuse the fd handed over from the source QEMU. */
>> +        if (!proxy->id) {
> 
> IMO we should be consistent and check `cpr_name` everywhere to improve 
> readability and reduce the diff moving the proxy in 
> vhost_vsock_cpr_name().
> 
> Stefano

Agreed.

Thanks,
Andrey

