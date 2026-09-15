Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4FABC88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 09:57:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6PuM-0008GI-PC; Tue, 15 Sep 2026 05:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x6PuJ-0008G2-8g
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 05:56:56 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x6PuG-0005j9-R9
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 05:56:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C90em5T63MfaalWVYViTKzJFhSFDI/cE03p0zUsPpdfitQPQqIilpK1i7a/wxbIZb2vqigoak8PiIMrIpi4kwN135sfCoMRxv1XVeXZLnoY8WT9WrWQMnuX8hbkLu6/xZLDILUui0R0+TXbhdXGzfRrVmuqMjhsqf2eSRBVT2bQIQVcoUCRFyYHWvqCE+zVeMl7niOoLpjsm3OxFpnTFDcV6CuxBx7FAMelUw2+dOFCnG+bJkDa1s3Nmgp5s7H2v9pWYUpAZZZo0UVc70GFJo6H2ZP5cP8zokSRK7TiEhY8N2yzXhHRKIuke6b5hAc4RdhrTNIbIS6m1/JHX++gCmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HRo6+qRmTFQbXk8IJZ1wJ9tU3Fv555wzp30a+BFLuTc=;
 b=JcJLbOEHMJGQWtFmUdK5CXbOJi8pEWq1mnTgndJsGFCDFthxBcsuQ3ZmyRUak5DTMnQ1zYrd6CL5Oz5HcVaqw2jUc5tMccjUx2nAzRWcJzZGANzEKwQOvbjNkDpLpSbjbKAFjxv1MxrjAW3S/FrzwLLk//peIftXSsbkKZvb5tHsUijMqzPm5sww0x4GQUfK4oWBLklOCjJlkn3WtszgYR136i//cJPDf+Af9pC3shO0H5hznGOfuSJO+Ula5QMUxX97q2fEHIiXF/c60XEZMK7i1F0sksaQ/1+o1XQpRw0AR7Am04fBFX3fRCM9+fgDC7SnK1dxylgm2h/o+DMwkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRo6+qRmTFQbXk8IJZ1wJ9tU3Fv555wzp30a+BFLuTc=;
 b=OsHqZNmpfIbhZ7FIsL9AAv1Tgw9RiYeXwwOZ0sbJ70ah4WUTSBLg+VmWnkiSNaPud9Fj3H8guDmZRpiBK4LoSJRphSnVnQGd69YhmnRrzq+gA4OD2/ipjW22p2zC5ZAlMNiKWsWcwGPar4vM6uipvqcCH+YEfhtIIFooN8Q6K4BjeFIkvXgK3C1swdHIi+qmxxvT3GG/PDRZ5V/xuGw7L0wbBfN25LMROzrPUdn4MHoOTkSNYHM0Kp2HKhwXhkFRq+6yJKywcsuatEjOHd/ZxlqLL9R9N3Qia6CXtOETnEHRRmlyRiEdv5NrwRuKmdLdJObV5ZJgrP8fZdD7SlF9Cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by GV2PR08MB8512.eurprd08.prod.outlook.com
 (2603:10a6:150:c2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.7; Tue, 15 Sep
 2026 09:56:12 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 09:56:12 +0000
Message-ID: <328755e2-31d9-432f-88be-bda72d3ba3f0@virtuozzo.com>
Date: Tue, 15 Sep 2026 12:56:11 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 14/14] vhost-vsock: hand off device ownership across CPR
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, philmd@oss.qualcomm.com,
 maciej.szmigiero@oracle.com, bchaney@akamai.com, mark.kanda@oracle.com,
 den@openvz.org, farosas@suse.de, peterx@redhat.com, clg@redhat.com,
 dongli.zhang@oracle.com
References: <20260914-up-vsock-vhost-v5-v5-0-d17423589f48@virtuozzo.com>
 <20260914-up-vsock-vhost-v5-v5-14-d17423589f48@virtuozzo.com>
 <aqgQYmbLk6O1Af7I@sgarzare-redhat>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <aqgQYmbLk6O1Af7I@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0254.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::9) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|GV2PR08MB8512:EE_
X-MS-Office365-Filtering-Correlation-Id: 06797b16-e97b-4875-fe91-08df130f933f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|7416014|366016|1800799024|4143699003|56012099006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: cHdiSE7+GhSSPHfYP6iWbZ+eMpeDiuIJsQCiNXgbyCklh6ZqtqLvBy524+mp348Z1+Sy15GIMbcQtzZpl9wPv37szmEppbKQwNa2PDnlrq3Vv4d2I/KkESi2X+foOSH1PwSP7MInLGQ26X+QD7xJyjbLcuESJZJfRV9WuxRPD1ECHfhjiyIblUOrWcjGFb01c8LuqmVYPYfldjmeMpxO4ojPEB/e7PRbUA2+2SFUns6FL2NlBRliExCepJjOi0GGu5zkOu4p+X8kN3Z32q5U1XrHaa8mui/mhxwu545/zWgB9xh6PdtZcF6DWvUvDPjH89vXiHkZZK95jRzVOjylnG5Y2M5a3vmcaeHIVMoTFDZq6bO3G/h6K7A6ov5qMRnKmzEK41UizLXDLhslvn2gPxm9nab4vEq0BW54UHt5Hi6bi3H66WyBwamYBg48Nvjdux/6nSBeVqNnTrRzgGs5IxEQK+mJdLxUjCDQuEAUzUgnSTlDbkpYWDXG2kbKuIFQekM5HLUwPQ9sfLdotl6X1EyOo1GfRQxCL2fn5z/KbYeneUCN1RjYlRSpQwbWVhoi+vYmOxyyQ0QueEd+vJdP73pgyeOGE2bMg/czetDy/7bo07v18ZmR5aQUj6JhzmUbpkiOkbGIEq8NJZM2YwA/rH2hO+5AphZbUhkq+gThwwo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(4143699003)(56012099006)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmFQbytFd3A4NjJyUEVMS0FZbGlOTmNFcFVUeG9qUDZFR3pFQVlUSlM1VDBw?=
 =?utf-8?B?eHI4M1kwWG0xbHRqTlNacVpIYm1NTkZod2VnVnpvVzZELzhOZWVJQ1FtVzdp?=
 =?utf-8?B?NE1yMUFvekhobGwxZ2VMM2FxNisrTDJxM2IrZk9WKzUrTDg2Vi9lT25UcnhE?=
 =?utf-8?B?amUyWXJJbXZweDhMSk9BaGVGR2hDMm9ZTzFyaWdlN1BmT3QrRkkvNncrM0Jh?=
 =?utf-8?B?RlM3R0pFS1hvZkthVXNVd1lwTWlsd2ZKRVhOSGNZR0FReHZCMUc3RFBoRVRD?=
 =?utf-8?B?Z3RXZlB3V0NENUJCSkNVUXNUV1RTRmI4ZDlJNnlscWVMQm1maEk4M3dsNVhz?=
 =?utf-8?B?RXkwNnQ0UnVYbENHRFd6MFdGckIzYVdBNUM4amJJT3YxaGNEWS9IL3NPNDl2?=
 =?utf-8?B?a045UmZQQkRlNk5YUEh4MTdQYzdwUU1tY0ZnSTcweVJkanMyQWovVCt2WDdS?=
 =?utf-8?B?Z0Q4cWJXMllid25uVmhHdDFrTUdDUHhYTGhHL1haSUgwRWlJVHQzNDlOMEIy?=
 =?utf-8?B?dVV1QVNGcWRQVUJMdVBhc0F3Rko5Tk5nVGFuUW1GYjJ2QVJxekl4N1hRSFRj?=
 =?utf-8?B?cEJLS05CNXA4bTc5cnVUdnlaZER6QnFqb1EydTZSbDhubmdOQjF3cEpxQmtQ?=
 =?utf-8?B?Ny9DekM0OUJYcFkwZUNlRmFaMnp0SVJHRnlSNEYvUk5DSUpBc004cEk1RUdU?=
 =?utf-8?B?S3ZkeWpVMitvaWU0eXdTVVNWcGtMVjl3YTJuTFI3T0luQWFxVzNXUWFVcTBJ?=
 =?utf-8?B?UzZ0VnZWQUJZdmFSdUM5ekh5Q1RZREl1cGRjWUUvOWxqYlpiakgxOFp0dThW?=
 =?utf-8?B?WUVqa1psREhFNXNQWElScFRQT0IvTWpNYzg1NTU5ZGJkMmVSTEV6Y1Y3RkJ0?=
 =?utf-8?B?SllvbVp3TWxOZFZEY0dBczk2c3NLcHMxeURiS1Vubnc3cU5OcFVZYXBRVXRj?=
 =?utf-8?B?SXhzSFdmKy9VTkgvSEhoRVpvY1lXSlJRNkRlYmw5aG1YeG90NjBUWHhPYU82?=
 =?utf-8?B?YmM2cGtNY21CelRGUTdOdURtZVhMbXo0VGw2blpZcVUvWDV4U1FxTzI1SFp6?=
 =?utf-8?B?bDBZdDI3ZWpwaEIvN0JUQ2RsVi9HS29UWjVkTThBN0lMOHJuRTlUWEtQNkJU?=
 =?utf-8?B?NkovMUZiNlg4NmcxVjBuQVdRNlFVVGVyT0RjKzlDWDgvc3hSOU9ibjExSlZl?=
 =?utf-8?B?SkdUZVlEZDRrUGM2WkEvYnozMzJrdG5YRnk3Vk02MHJMR3BOR2YzUUV4R28z?=
 =?utf-8?B?SWM0RW1IYjRrdnRqaGJKUXNLTHJXczdCeTRjYlF1UGN5bk9XOWRFRXlOTnh6?=
 =?utf-8?B?V1ozY2w1Zkcxd2VURzlYd1RlVWtCalEyenBzVUkyUWNEUXBJTlY0TnFYZ0M5?=
 =?utf-8?B?N3VhL3pERlBJRFA4a3NmZFppVi9DdEVDUSszemNHdnRJVFZBZHNpNXBTQVpY?=
 =?utf-8?B?bmwxaTVRZk9sTkJscUwyUkJKVE0yQi83dUdpbmxWeHN5bkFlaWhHdVlwbFIv?=
 =?utf-8?B?S25NNVY5QnhoVCtua05KSmxDdmRjeHlxMFlRZ1YwTjBZTlpWaEIrSUM4b3Y5?=
 =?utf-8?B?MzdOQkhXWmRVMkZ4aFE2bms2bjZpWlZSRHBUTWI3aC9UK2pwbThkbnI0QnA5?=
 =?utf-8?B?TVFjMThueG9ISmdSQm40anZmUWFiY0hSS3NFY3p0dkJWVmQ2ZG9TcjBrS2R0?=
 =?utf-8?B?QmY1bXhWQWN5VlZxUThQL3lGei9RbjRwU055ZGN6Smd1N0FWbWhMVnVxNEpl?=
 =?utf-8?B?MmJnMjBXMkFmZTErNnliZEExVDRqMFBIZEtRNmIxQlZRV0p4ZW55bWVHVzBC?=
 =?utf-8?B?YkU5YmYvRmVMV1ptbVNuczArMEdJSERNb2VIc00vV0FRU2pFUFZwSTN2SEZl?=
 =?utf-8?B?UVk3ZXh3akZVWjI4S2ptZFE5RDNQZURHN0pBU3FTS2MxL2VmaU9oWTg2aXp3?=
 =?utf-8?B?Qi94UjQ2bk0ra0dZQjFpOTNocGxUazdsbi9ab09oSjlxWlkxWEVpdzhFU2p5?=
 =?utf-8?B?OHVtRkJaUG8yeURiWmhzaTdqNWVCbDJpczZWeGxwdjNzdU1UMVArMkFZTEVT?=
 =?utf-8?B?TUFmOVVDZWZXUXREM1RtNTVSMXJNb1VkdnZVWTEvRXNFYWI5b0hvYlgvcUZp?=
 =?utf-8?B?KzNjL3QxdDliRjA5VkQwRVBZa2tSNFB2UkM3d3E1cTR4SU8ySHVZdnFrUHB5?=
 =?utf-8?B?anQ2UUNsb0JiUVdFUjF1Mk9Oc3p6UVd6K1FJblpQQjVqMi9mZFJSWTdJbkFH?=
 =?utf-8?B?S1hSbFFnTndvNmFVRTFhM21NcTZQTC8wTnVYVmo2OCt2bXhqR2NDeTJLRXl0?=
 =?utf-8?B?b25GdkowZnZSakZTaHlmaUJZYXQ1N0EzNkJzNGdqTDQ3ZWpNYzZ4Z0Y1c0lw?=
 =?utf-8?Q?nxMwvxRXCOhbAQls=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06797b16-e97b-4875-fe91-08df130f933f
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 09:56:12.7029 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wcG9BHdgKbgk8HKSodpykJlzEWfuLRJGSBLmzZvmYaJffNuyzkkDsrKoAv4XyiJplX4DEgefmxFAvbXYN/s9pW0SHuKpUufcuFcDJcxSCUk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8512
Received-SPF: pass client-ip=2a01:111:f403:c207::3;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On 9/14/26 6:36 PM, Stefano Garzarella wrote:
> On Mon, Sep 14, 2026 at 11:37:45AM +0300, Andrey Drobyshev wrote:
>> The previous patches reuse the source vhost FD on the destination,
>> however both source and target still call vhost_dev_init() (VHOST_SET_OWNER)
>> in realize().  For cpr-transfer the destination realizes while the source
>> still owns the shared FD, so its SET_OWNER would fail - ownership has to be
>> handed over explicitly.
>>
>> Do this through the device's CPR vmstate hooks.  Namely, release device
>> ownership in pre_save, reclaim in post_load, re-acquire on restart:
>>
>>  - .pre_save() releases ownership on the source (VHOST_RESET_OWNER) once
>>    the VM is stopped, for the FD-preserving CPR modes (cpr-transfer and
>>    cpr-exec).
>>
>>  - .realize(), for an incoming CPR, only sets up the virtio device and
>>    queries the backend features by calling vhost_dev_init_backend().
>>    It doesn't take device ownership and doesn't touch the VQs which
>>    still-running source might use.  The full init is deferred to
>>    .post_load().
>>
>>  - .post_load() reclaims it on the destination: the full vhost_dev_init()
>>    (VHOST_SET_OWNER) on the preserved FD, plus sets the guest cid, before
>>    the device is started at vm_start.
>>
>>  - .set_status() refuses to start a device whose init hasn't completed
>>    yet (incoming CPR before post_load).
>>
>>  - .set_status() re-acquires ownership before starting the device if
>>    pre_save released it and this QEMU is about to run the guest again:
>>    the migration failed, or it completed and the management resumed the
>>    source (e.g. cpr-transfer target died).
>>
>> With the handoff in place, lift the CPR blocker: only ID-less devices,
>> which can't preserve their FDs, remain blocked.
>>
>> Note: this requires kernel side support of VHOST_RESET_OWNER operation
>> for vhost-vsock.  Otherwise CPR attempt fails in .pre_save().
>>
>> Suggested-by: Dongli Zhang <dongli.zhang@oracle.com>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>> hw/virtio/vhost-vsock.c         | 159 +++++++++++++++++++++++++++++++++++-----
>> include/hw/virtio/vhost-vsock.h |   3 +-
>> 2 files changed, 144 insertions(+), 18 deletions(-)
>>
>> diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
>> index 203055354ae..e3d83815ed3 100644
>> --- a/hw/virtio/vhost-vsock.c
>> +++ b/hw/virtio/vhost-vsock.c
>> @@ -77,14 +77,46 @@ static char *vhost_vsock_cpr_name(DeviceState *proxy)
>> static int vhost_vsock_set_status(VirtIODevice *vdev, uint8_t status)
>> {
>>     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(vdev);
>> +    VHostVSock *vsock = VHOST_VSOCK(vdev);
>>     bool should_start = virtio_device_should_start(vdev, status);
>>     int ret;
>>
>> +    /*
>> +     * During CPR, on target the full vhost_dev_init() is deferred to
>> +     * post_load.  Refuse to start a half-initialised device rather than
>> +     * issue vhost ioctls on it.
>> +     */
>> +    if (should_start && !vhost_dev_is_initialized(&vvc->vhost_dev)) {
>> +        error_report("vhost-vsock: refusing to start, device init incomplete");
>> +        return 0;
>> +    }
>> +
>>     if (vhost_dev_is_started(&vvc->vhost_dev) == should_start) {
>>         return 0;
>>     }
>>
>>     if (should_start) {
>> +        /*
>> +         * vsock->owner_reset is only set in .pre_save() on CPR migration
>> +         * source, after a successful RESET_OWNER op.  If we end up here
>> +         * with this flag set - that means that either CPR migration failed,
>> +         * or we got 'cont' cmd from the management (e.g. cpr-transfer
>> +         * target died).  In either case, we need to re-acquire device
>> +         * ownership.
>> +         *
>> +         * On failure leave the device stopped.  The next start attempt
>> +         * (guest driver reset, VM stop/cont) retries.
>> +         */
>> +        if (vsock->owner_reset) {
>> +            ret = vhost_dev_set_owner(&vvc->vhost_dev);
>> +            if (ret < 0) {
>> +                error_report("vhost-vsock: cannot re-acquire device "
>> +                             "ownership: %s", strerror(-ret));
>> +                return 0;
>> +            }
>> +            vsock->owner_reset = false;
>> +        }
>> +
>>         ret = vhost_vsock_common_start(vdev);
>>         if (ret < 0) {
>>             return 0;
>> @@ -115,8 +147,44 @@ static uint64_t vhost_vsock_get_features(VirtIODevice *vdev,
>>     return vhost_vsock_common_get_features(vdev, requested_features, errp);
>> }
>>
>> +static int vhost_vsock_pre_save(void *opaque)
>> +{
>> +    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(opaque);
>> +    VHostVSock *vsock = VHOST_VSOCK(opaque);
>> +    int ret;
>> +
>> +    ret = vhost_vsock_common_pre_save(opaque);
>> +    if (ret) {
>> +        return ret;
>> +    }
>> +
>> +    /*
>> +     * Release the device ownership now for CPR migration.  The device is
>> +     * already stopped at pre_save, and destination reclaims it by calling
>> +     * VHOST_SET_OWNER in post_load.
>> +     */
>> +    if (cpr_incoming_needed(NULL) && migration_is_running()) {
> 
> Should we also check if vsock->owner_reset is already true?
> Or it can never happen?

Actually you're right, and we should also guard the RESET_OWNER op by
!vsock->owner_reset.  If we fail somewhere after .pre_save() and the VM
was stop before migration - we don't call set_status() just yet, so the
device ownership isn't re-aquired, and a subsequent CPR attempt would
fail here. I didn't think of such a case, thanks for noticing.
>> +        ret = vhost_dev_reset_owner(&vvc->vhost_dev);
>> +        if (ret < 0) {
>> +            error_report("vhost-vsock: vhost_reset_owner failed: %s",
>> +                         strerror(-ret));
>> +            return ret;
>> +        }
>> +        vsock->owner_reset = true;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> static int vhost_vsock_post_load(void *opaque, int version_id)
>> {
>> +    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(opaque);
>> +    VirtIODevice *vdev = VIRTIO_DEVICE(opaque);
>> +    DeviceState *proxy = qdev_get_parent_bus(DEVICE(vdev))->parent;
>> +    g_autofree char *cpr_name = vhost_vsock_cpr_name(proxy);
>> +    Error *local_err = NULL;
>> +    int vhostfd, ret;
>> +
>>     /*
>>      * Only reset vsock connections for non-CPR migration.  For CPR the
>>      * guest cid is unchanged, and the cid-change reset would otherwise
>> @@ -126,6 +194,35 @@ static int vhost_vsock_post_load(void *opaque, int version_id)
>>         return vhost_vsock_common_post_load(opaque, version_id);
>>     }
>>
>> +    /*
>> +     * CPR restore case.  The source released device ownership in its
>> +     * pre_save.  Complete the handoff here, before the device is started
>> +     * at vm_start.  Init vhost device on preserved FD, issue
>> +     * VHOST_SET_OWNER on it, and restore the guest cid.
>> +     */
>> +    vhostfd = cpr_find_fd(cpr_name, 0);
>> +    if (vhostfd < 0) {
>> +        error_report("vhost-vsock: could not find restored vhost FD");
>> +        return -1;
>> +    }
>> +
>> +    ret = vhost_dev_init(&vvc->vhost_dev, (void *)(uintptr_t)vhostfd,
>> +                         VHOST_BACKEND_TYPE_KERNEL, 0, &local_err);
>> +    if (ret < 0) {
>> +        error_report_err(local_err);
>> +        cpr_delete_fd(cpr_name, 0);
>> +        return ret;
>> +    }
>> +
>> +    ret = vhost_vsock_set_guest_cid(vdev);
>> +    if (ret < 0) {
>> +        error_report("vhost-vsock: unable to set guest cid: %s",
>> +                     strerror(-ret));
>> +        vhost_dev_cleanup(&vvc->vhost_dev);
>> +        cpr_delete_fd(cpr_name, 0);
>> +        return ret;
>> +    }
>> +
>>     return 0;
>> }
>>
>> @@ -137,7 +234,7 @@ static const VMStateDescription vmstate_virtio_vhost_vsock = {
>>         VMSTATE_VIRTIO_DEVICE,
>>         VMSTATE_END_OF_LIST()
>>     },
>> -    .pre_save = vhost_vsock_common_pre_save,
>> +    .pre_save = vhost_vsock_pre_save,
>>     .post_load = vhost_vsock_post_load,
>> };
>>
>> @@ -149,6 +246,7 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>>     VHostVSock *vsock = VHOST_VSOCK(dev);
>>     DeviceState *proxy = qdev_get_parent_bus(DEVICE(vsock))->parent;
>>     g_autofree char *cpr_name = vhost_vsock_cpr_name(proxy);
>> +    bool cpr_incoming = cpr_is_incoming();
> 
> nit: maybe this can be introduced by "vhost-vsock: preserve vhost FD 
> during CPR" commit.

Yes, agreed.
>>     int vhostfd;
>>     int ret;
>>
>> @@ -164,19 +262,21 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>>     }
>>
>>     /*
>> -     * CPR migration of a vhost-vsock device is not supported yet: the
>> -     * device ownership is not handed over, so the target fails to set
>> -     * up its device.  Fail the migration early and gracefully instead.
>> +     * With the ownership handoff in place CPR migration is now supported.
>> +     * Having a unique ID is mandatory for FD preservation during it, thus
>> +     * we only keep the migration blocker for the ID-less case.
>>      */
>> -    error_setg(&vsock->migration_blocker,
>> -               "vhost-vsock: CPR migration is not supported");
>> -    if (migrate_add_blocker_modes(&vsock->migration_blocker,
>> -                                  BIT(MIG_MODE_CPR_TRANSFER) |
>> -                                  BIT(MIG_MODE_CPR_EXEC), errp) < 0) {
>> -        return;
>> +    if (!proxy->id) {
> 
> Ditto about using `cpr_name` here.

Agreed.
> The rest LGTM!
> 
> Thanks,
> Stefano
> 
> 
>> +        error_setg(&vsock->migration_blocker,
>> +                   "vhost-vsock: device ID is required for CPR migration");
>> +        if (migrate_add_blocker_modes(&vsock->migration_blocker,
>> +                                      BIT(MIG_MODE_CPR_TRANSFER) |
>> +                                      BIT(MIG_MODE_CPR_EXEC), errp) < 0) {
>> +            return;
>> +        }
>>     }

There's an interesting consequence of adopting qdev_get_dev_path().
IIUC vhost-vsock device inherits from virtio device and is always
attached to a device which is virtio device.  Then in qdev_get_dev_path():

    bc = BUS_GET_CLASS(dev->parent_bus);

    if (bc->get_dev_path) {

        return bc->get_dev_path(dev);

    }

And all virtio buses, namely: virtio-pci-bus, virtio-mmio-bus,
virtio-ccw-bus - implement their own .get_dev_path().

This essentially means that for vhost-vsock device qdev_get_dev_path()
can never return NULL.  This in turn means that our migration blocker
which is now guarded by proxy->id can be entirely dropped.  We can just
always allow CPR migration and simply do `g_assert(cpr_name)` whenever
we obtain that name, as it's expected to never be NULL.

I'll try adopting that approach, unless you have any objections.

Thanks,
Andrey


