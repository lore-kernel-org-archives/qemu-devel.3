Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D78C79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 17:46:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4MMX-0006Oy-9M; Wed, 09 Sep 2026 13:45:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x4MMV-0006Ol-7Q
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 13:45:31 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x4MMS-0002gh-8R
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 13:45:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dqIXLygOMTRA4Kv9lJ1UDlzHhmwEUzxUfe/0Ux01PngdP4tEgT8XBQYURGGg77Yd+mBy7yE5txlwcLk5Ut2MbgDAb9kX618DbUmiEa2vRNSO1xffzpLx92v+8tU4SZIrlxvYkLQlrommpdTOMgDOEEpQ0Ffc7I/yRGzXiWw+c9eHWC/BpAAgOO7GqA8yS10xxPMyu0rtRZsR2M8QNFT6icHhxlL4v45vAivsXJSkc0QlOlHeVSPdY0BxbjR6+W9x2BDbfeW+yH7JMK+E5M5SmS/M8WlAXD+jJBvhQ5vXR4XVrnwfXc5sO6HLmUs5aZHXsdDinpIP5iGy1WwKiG/zcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G0xLv1WUiqggjgxQ1GR1iyuCmXDLKrXJTX2f4p9oJUw=;
 b=kRi9CZdkJo2rl8AHDbgJtZvviI1GbtzmeVNrUBID38V9sbcWFPuObpyqVXHNr0Y3VcNJxFQAl6SE4e/4JMk/RoUB4n+0bSl0QMvxM7tmrFyeU8sFdbJ6kkMrPjyDYgplHo+OLGKmxm2bjiHUQ43qfSC2grvqfa7PhYtBfHXzdOelmIWDRzpxiOqlqkiIWvA2ELTlAxNR1HL1by8NFsvZSRk32tVKlW/n2RVsCXYkQu4YzjRo5juX50u826To0KYQkIzPln1Qjm9Oj1dFVBj3JVC12aCzoW5dqhGFoGJGZye1bs7o6XVXQPVqwsYqUQ4H/fTlFWGSeniEWA6ZHzkZWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0xLv1WUiqggjgxQ1GR1iyuCmXDLKrXJTX2f4p9oJUw=;
 b=cAjphrAiwmWhN4GuFjkfpbDoExvD6nXQSAo16/imIYW0iuvzpF0Z87mAIKpHbmRJ8rtnpZE6hbHsSfxIpePBjD8ZjfDRFjHuZ3tRtDX7ePvwxBbzCUSmjZfbhrkj3pSzDMVgXZxw5Er+yNMitc2nKOT2lnjH+clGRAip1C+tdaU3f8JATFBKHoIDSGJ6H1CbJv8gN2RosQ8ULDZSiuJzoTwLrum+pQw+PVTVouLIbEbqmEw1DPvGEH55klXv5xeQFRBfIJjVx2dU9obmtTMTmYff9IynTNarWeZaKn8B3qVHutz4Y4Pk6o/15aGHhMK1ROa+ooJ36Rlhqu6nAh0obg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DBBPR08MB10722.eurprd08.prod.outlook.com
 (2603:10a6:10:530::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 17:45:24 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 17:45:23 +0000
Message-ID: <6e1b82d9-b2c8-4c10-bebd-9d500c14b1de@virtuozzo.com>
Date: Wed, 9 Sep 2026 20:45:22 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/10] vhost-vsock: hand off device ownership across CPR
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, farosas@suse.de,
 peterx@redhat.com, dongli.zhang@oracle.com, maciej.szmigiero@oracle.com,
 bchaney@akamai.com, mark.kanda@oracle.com, den@openvz.org
References: <20260820113955.509478-1-andrey.drobyshev@virtuozzo.com>
 <20260820113955.509478-11-andrey.drobyshev@virtuozzo.com>
 <ap7Lma3zpbr6QDb0@sgarzare-redhat>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <ap7Lma3zpbr6QDb0@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0221.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::17) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DBBPR08MB10722:EE_
X-MS-Office365-Filtering-Correlation-Id: bbf5c668-fe09-43ac-19d9-08df0e9a1fed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|7416014|376014|6133799003|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: rQ3UFqh32h4Lrm0JB1oW0GTlVAa0yzbsPnpOJe2AJR1PwL16mak7yMHn+zNUKHjG7b5bW76ZkXxtHHNiORl22Nnsz97EEGTLWf8WiAh8E6Mcqh5rNmGGhvyrdGxXlZtTjJJlJEmMGA9wyogIDrvflVWIE0pbnNIHF7bE4Uuz0QawLh+YhiSwZqKtCda8ZGV+en2p+xoyAHBoTaFLPe5hmzCdastLI0Sf+yqR1FcIAcM+iilvcCdQG7NiO6Rfbsgq8ObrdDvJleax8O2EsoVQ0iL0sLf8BigT4y7l4/GfkSm22wa88qlA6jEqOZZFlT8zdea+xYn6HQ9uMSdZx2tbo1OcZbzVnEZcEeJCY8QVwt5wocWg6XpserXmUotYHNiXy/+xMcLn67qA6xddMxgNyAEhe/UhHDthi3LSucXAMWzMD4dzNCLNceoPU9vpBv/GNyD4GnNA5rIPArpz+17hZ5lX6zdOW2SaUsWINHhu7X1sTw1oki1NzVypvP4dgh5y1wv4yMHrCs07G6r1VUNieyc9kDtQQuIZl+K3Kq6m90Q4Q2aoHXuGF8eGu43PTjKBGsL2Tflse7ahhHIMTkauTG5gUVvLBTcuB1uGr1Cw3zKAHJjAvEXzPE9/57KemCjdXhrTboY2nVaPrnnXP8OYg+EJqwY4r7quWopmDah0TI4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(6133799003)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGNBZHFxQ1QwR05MeUM0c2VYa1g3UExEMmYzbVZKNFk4NS9vS1BmcEFMYm4x?=
 =?utf-8?B?ZnFuSUlSWDlNV1B1dWx6Y3RDakcvZVJMcnU1ZU9seTN3MW93WmMyd2JZSU9Z?=
 =?utf-8?B?RUNwcHhCZVR0WWxWcWN2RFh0VDFpaENmSDA3Q0pvaUhEcG1LMUxlQi9EVFRu?=
 =?utf-8?B?ZExUVVNRaTRmK0R4ZWcvM2VuNTFMSjB2UU5jTXZ5dFVqaW9nUlJScDRqN0tZ?=
 =?utf-8?B?b2tjWFpHTncvTk1Jak1NeFNjdm93TGQ3TFl3elFvYnFaZ0pOTU1qNXp3bGFh?=
 =?utf-8?B?Z2tvRW5Ya0ZxZEVPTFowbWlvbGxycis5TFVYdlRsMDZiVXFGWGpUV3lkZnRW?=
 =?utf-8?B?dFRFUGJ3NmxVOVJQZHhGdHkvSEpnWEM4akcrT2pXRXV2V3ZEYjUvWmNnN0FJ?=
 =?utf-8?B?cm1rT2FEa1JxNWF5bkg5SXZJQnovNitkTXdtQkFCaTFKaFRjcjJKSTlSaE93?=
 =?utf-8?B?SS9pdzZMc3BCT2FRUk5NR2NqWUlUUU5KY0tlZlAvZ3FkRmp0eGJOV2hJelVB?=
 =?utf-8?B?c0tLeGR0L3hmSSttUHI3ejNpWkY4ei9sY01JSEYzLzVUNWZWaUxPenBkandH?=
 =?utf-8?B?SWxWR3lMZEI4ZGhFTk1PZE1lTnk1dlRiMmhIbjlNb2NEa1MwUC92V3QySlV4?=
 =?utf-8?B?dmFTN2NWZU1jY0QwN3dmT0RIUGZidThkdFNqRFBNblR3RHNKUDJRaldlU1VF?=
 =?utf-8?B?SG1SQXNxcnY2RjZNbHAzMWZhLzNEOVN3QVY5cFlxSU5TTFJPeW9pbFRwbElj?=
 =?utf-8?B?bVg2NVg2R2RMMW41ZzA3K2JJRHdKVlNOeE8zV2UvcGxVTWdDaEJ4OFNDZVlZ?=
 =?utf-8?B?eGFmdjMxTTRpMFlmZ0xoQnA3eTloclUvbmM1TWd0Y2hNTHRqd3J2TGIrdTNM?=
 =?utf-8?B?dlNLSXg0OTZUM0xiL2VORkJ4VjFjK1Y1TklEMGpIM2tHT3JFRmcvd1BoZW91?=
 =?utf-8?B?RnJQd09xczBWK3R6UWZhaW82YzQzMmhXbnVXNHEreFVlTGcwSmU4dkgyMTlj?=
 =?utf-8?B?V3N1dFpuWVZMMnJsZHRiV2FHOXZEOEZsREl0Q2NWa2xGNkdhS1NJRm1hYzFR?=
 =?utf-8?B?M01KbDlGenZVUXNjNjlHWGZDbU90UDhlMEtoMzZnOVlyNGhNK2NyWEIwdDBK?=
 =?utf-8?B?RExJZE4zSEdsWk9SbnZOMUw4MnBqd0tZS25VMi9pdDh2eWtSWnpMSmJSdlRQ?=
 =?utf-8?B?ZzBRTkdXVUlDRkU5alVNWWYzR3d6aWQ3VG9USCtVMmNLbFFMNkMwNk5Xa0pw?=
 =?utf-8?B?U241V1lLcDRyczJtdWhDNlFKS0VaeWw5cXdBUVNtaVM1ZEpPNnVmajYwRzI1?=
 =?utf-8?B?OC9majlUK0VOa01qcm5hWWx0aHhSV3E4U0JIb0xpeEE5YmhBdEdwd0VPUHNB?=
 =?utf-8?B?a0tQOEJraG5KdzR2K1BEUEtnYmNGS29salhqN1VORXljSjZZZk9WaCtKY05m?=
 =?utf-8?B?YU96QjArK2hxaitiT2xqTEcrYnh4K1VrQU51ZXprNStXcTZoRlNDVU5HVm16?=
 =?utf-8?B?T3VvUkZmWEw1anlyZ1ZnNWxqRDUvWHpDVDJ2K1h4Z1daN3ZQWDRjSjd2QUNw?=
 =?utf-8?B?NWt5RTBrQXp4SU9kMng0NDJieWNnVFBwSlFXd0dGOVFBTDE3T3NWL25lTVBX?=
 =?utf-8?B?T01COVFvYjVEVnZyS2tWRlNvWXdadEtQU0pIRDRvQmUzR0NsVFE3WGlwTEE4?=
 =?utf-8?B?TmJnbnpETHRiVG1Rd0NEMjRCYWoyUlNGSDRFcFdPN2xadk5DY1VVWE05aWgr?=
 =?utf-8?B?cG1ucTYwczNBTTJ4TjdjbzRnWHpvVzJibUdWbVZJN0ZkMk5yRTJ3dzlTTzdM?=
 =?utf-8?B?dGZ1dW5ORnhTWjdzdGNxekQ2NFYvazYySmZJSStvN0FVdG9yaW5JSlBuaVRy?=
 =?utf-8?B?VUxUMzNOazR6NXJqUm1IZElrSkdjRVlHcndlOHpVMXltR0R0NHVFV0xtVDdW?=
 =?utf-8?B?Q3EzQk9HUTJmREE5c2kwWDR2UlZ5bStXaWw1a3ZVWjNPclM0Z0hBSE5YTm9M?=
 =?utf-8?B?Vmd2amdmU3ZrM2JTencvYmxLdUFCYzhwUnFjakdUUWZBcUp2ajBoMytVa1lC?=
 =?utf-8?B?aktSQkR3ajBGMW85akczb3BkTStoK0tkSDJUNDRWSXJqYXJrZFR4R1BVWFRo?=
 =?utf-8?B?c2xkVEFuRkVDK21tUGsyK0hTcHNrWXdNUWEzQmxsbkVwTGpxYmRLS0FPaEFr?=
 =?utf-8?B?WE1zWm1WNFoyazAzMk91OEhkUEtBWS8rUHhPbW9WU0wyaGFwTkxWR2oyUitk?=
 =?utf-8?B?bkd3bklYUHBFWFBML3BGUGR3U1JpaHVHbUc4OEJiQ05MS1V4eTFlWFdVR3VS?=
 =?utf-8?B?STBqdmhUWmRwNVhBNDJteUxhdS9ZMW9iZVNPZ21YZDF5VWdBUnBYc01tR2M5?=
 =?utf-8?Q?vuquPrmHXgMClAD4=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbf5c668-fe09-43ac-19d9-08df0e9a1fed
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 17:45:23.4296 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eMN/hyIIE6Z4PkOWcQXyG9uXSG5CE/V6ZIzxL5RdDXFP7GpW6PzvJDlKFLNur10BE2E78lCVkpRZaOwHCPTAbTzM8PUF3HC6MufYaHqeW9Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10722
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On 9/7/26 6:13 PM, Stefano Garzarella wrote:
> On Thu, Aug 20, 2026 at 02:39:55PM +0300, Andrey Drobyshev wrote:
>> The previous patches reuse the source vhost FD on the destination,
>> however both source and target still call vhost_dev_init() (VHOST_SET_OWNER)
>> in realize().  For cpr-transfer the destination realizes while the source
>> still owns the shared FD, so its SET_OWNER would fail - ownership has to be
>> handed over explicitly.
>>
>> Do this through the device's CPR vmstate hooks.  Namely, release device
>> ownership in pre_save, reclaim in post_load, re-acquire on failure:
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
>>  - A MIG_EVENT_FAILED notifier re-acquires ownership if the migration
>>    fails after pre_save released it and the source VM is resumed.
>>
>>  - .set_status() refuses to start a device whose handoff hasn't
>>    completed: not fully initialized yet, or left ownerless after a
>>    failed CPR.
>>
>> With the handoff in place, lift the CPR blocker: only ID-less devices,
>> which can't preserve their FDs, remain blocked.
>>
>> Suggested-by: Dongli Zhang <dongli.zhang@oracle.com>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>> hw/virtio/vhost-vsock.c         | 165 ++++++++++++++++++++++++++++----
>> include/hw/virtio/vhost-vsock.h |   5 +-
>> 2 files changed, 152 insertions(+), 18 deletions(-)
>>
>> diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
>> index cec2c31f0ca..e25e5350905 100644
>> --- a/hw/virtio/vhost-vsock.c
>> +++ b/hw/virtio/vhost-vsock.c
>> @@ -73,9 +73,23 @@ static int vhost_vsock_set_running(VirtIODevice *vdev, int start)
>> static int vhost_vsock_set_status(VirtIODevice *vdev, uint8_t status)
>> {
>>     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(vdev);
>> +    VHostVSock *vsock = VHOST_VSOCK(vdev);
>>     bool should_start = virtio_device_should_start(vdev, status);
>> +    bool initialized = vhost_dev_is_initialized(&vvc->vhost_dev);
>>     int ret;
>>
>> +    /*
>> +     * During CPR, on target the full vhost_dev_init() is deferred to
>> +     * post_load.  On source the device is left without an owner if a
>> +     * failed CPR couldn't re-acquire it.  Refuse to start in both cases
>> +     * rather than issue vhost ioctls on a half-initialised or ownerless
>> +     * device.
>> +     */
>> +    if (should_start && (!initialized || vsock->owner_reset)) {
>> +        error_report("vhost-vsock: refusing to start, device init incomplete");
>> +        return 0;
> 
> Why returning 0?

That's just what every other error path does here, because return value
for vhost_vsock_set_status() goes nowhere.  The only thing it'd
influence is having one more line in the QEMU log when we're called from
virtio_set_status().
>> +    }
>> +
>>     if (vhost_dev_is_started(&vvc->vhost_dev) == should_start) {
>>         return 0;
>>     }
>> @@ -111,8 +125,67 @@ static uint64_t vhost_vsock_get_features(VirtIODevice *vdev,
>>     return vhost_vsock_common_get_features(vdev, requested_features, errp);
>> }
>>
>> +/*
>> + * Re-acquire device ownership if a CPR migration that released it (in
>> + * vhost_vsock_pre_save()) failed and the source VM is about to resume.
>> + * This runs before vm_start(), so the device is owned again before it is
>> + * restarted.
>> + */
>> +static int vhost_vsock_cpr_notifier(NotifierWithReturn *notifier,
>> +                                    MigrationEvent *e, Error **errp)
>> +{
>> +    VHostVSock *vsock = container_of(notifier, VHostVSock, cpr_notifier);
>> +    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(vsock);
>> +    int ret;
>> +
>> +    if (e->type == MIG_EVENT_FAILED && vsock->owner_reset) {
> 
> IIUC MIG_EVENT_FAILED only covers the source failing. If the source 
> completes it successfully and something goes wrong afterwards (e.g. in 
> the destination), what will happen?

Hmm that indeed might be a problem for cpr-transfer.  E.g. target fails,
management (libvirt) sends qmp-cont to source, and we bail out with
error in vhost_vsock_set_status().
> Thinking if we can try to call vhost_dev_set_owner() in 
> vhost_vsock_set_status(), expecting also -EBUSY, instead of relying on 
> `vsock->owner_reset`.

Moving .set_owner() to .set_status() actually looks promising, I'll try
it out and see how that works.  Although I'd still keep the flag and
restrain from tolerating -EBUSY - we shouldn't proceed to realize the
device if we don't own it.


>> +        ret = vhost_dev_set_owner(&vvc->vhost_dev);
>> +        if (ret < 0) {
>> +            error_report("vhost-vsock: failed to re-acquire owner: %d", ret);
> 
> Is it okay to return 0 also in this case?

As of now it's mandatory cause migration_call_notifiers() asserts on
type == MIG_EVENT_SETUP whenever notifier returns non-null.
>> +        } else {
>> +            vsock->owner_reset = false;
>> +        }
>> +    }
>> +
>> +    return 0;
>> +}
>> +
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
>> +    if (cpr_incoming_needed(NULL)) {
> 
> Am I missing something that keeps pre_save from running outside an 
> actual CPR migration (savevm, or any save path taken while mode is still 
> set from an earlier attempt), or should the condition be tied to a CPR 
> migration actually being in flight rather than to the mode parameter 
> alone?

You're right, that's a real bug.  Should probably guard it with
cpr_incoming_needed(NULL) && migration_is_running().
>> +        ret = vhost_dev_reset_owner(&vvc->vhost_dev);
>> +        if (ret < 0) {
>> +            error_report("vhost-vsock: vhost_reset_owner failed: %d", ret);
> 
> vhost-vsock devices that don't support `reset_owner` will fail here, 
> right? Is that what we expect?

Which devices you mean?  No other vhost-vsock devices should ever end up
here, e.g. vhost-user-vsock has .unmigratable = 1 set, so .pre_save() is
never run for it.  If you mean the kernels which don't support
RESET_OWNER - then yes, we'll fail here.
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
>> +    Error *local_err = NULL;
>> +    int vhostfd, ret;
>> +
>>     /*
>>      * Only reset vsock connections for non-CPR migration.  For CPR the
>>      * guest cid is unchanged, and the cid-change reset would otherwise
>> @@ -122,6 +195,32 @@ static int vhost_vsock_post_load(void *opaque, int version_id)
>>         return vhost_vsock_common_post_load(opaque, version_id);
>>     }
>>
>> +    /*
>> +     * CPR restore case.  The source released device ownership in its
>> +     * pre_save.  Complete the handoff here, before the device is started
>> +     * at vm_start.  Init vhost device on preserved FD, issue
>> +     * VHOST_SET_OWNER on it, and restore the guest cid.
>> +     */
>> +    vhostfd = cpr_find_fd(proxy->id, 0);
>> +    if (vhostfd < 0) {
>> +        error_report("vhost-vsock: could not find restored vhost FD");
>> +        return -1;
>> +    }
>> +
>> +    ret = vhost_dev_init(&vvc->vhost_dev, (void *)(uintptr_t)vhostfd,
>> +                         VHOST_BACKEND_TYPE_KERNEL, 0, &local_err);
>> +    if (ret < 0) {
>> +        error_report_err(local_err);
>> +        return ret;
>> +    }
>> +
>> +    ret = vhost_vsock_set_guest_cid(vdev);
>> +    if (ret < 0) {
>> +        error_report("vhost-vsock: unable to set guest cid: %d", ret);
>> +        vhost_dev_cleanup(&vvc->vhost_dev);
>> +        return ret;
>> +    }
>> +
>>     return 0;
>> }
>>
>> @@ -133,7 +232,7 @@ static const VMStateDescription vmstate_virtio_vhost_vsock = {
>>         VMSTATE_VIRTIO_DEVICE,
>>         VMSTATE_END_OF_LIST()
>>     },
>> -    .pre_save = vhost_vsock_common_pre_save,
>> +    .pre_save = vhost_vsock_pre_save,
>>     .post_load = vhost_vsock_post_load,
>> };
>>
>> @@ -144,6 +243,7 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>>     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>>     VHostVSock *vsock = VHOST_VSOCK(dev);
>>     DeviceState *proxy = qdev_get_parent_bus(DEVICE(vsock))->parent;
>> +    bool cpr_incoming = cpr_is_incoming();
>>     int vhostfd;
>>     int ret;
>>
>> @@ -159,19 +259,30 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
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
>> +        error_setg(&vsock->migration_blocker,
>> +                   "vhost-vsock: device ID is required for CPR migration");
>> +        if (migrate_add_blocker_modes(&vsock->migration_blocker,
>> +                                      BIT(MIG_MODE_CPR_TRANSFER) |
>> +                                      BIT(MIG_MODE_CPR_EXEC), errp) < 0) {
>> +            return;
>> +        }
>>     }
>>
>> -    if (cpr_is_incoming()) {
>> +    /*
>> +     * Re-acquire ownership if a CPR migration releases it (in pre_save) but
>> +     * then fails.
>> +     */
>> +    migration_add_notifier_modes(&vsock->cpr_notifier,
>> +                                 vhost_vsock_cpr_notifier,
>> +                                 BIT(MIG_MODE_CPR_TRANSFER) |
>> +                                 BIT(MIG_MODE_CPR_EXEC));
>> +
>> +    if (cpr_incoming) {
>>         /* Reuse the fd handed over from the source QEMU. */
>>         if (!proxy->id) {
>>             error_setg(errp, "vhost-vsock: device ID is required for "
>> @@ -204,14 +315,32 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>>
>>     vhost_vsock_common_realize(vdev);
>>
>> -    ret = vhost_dev_init(&vvc->vhost_dev, (void *)(uintptr_t)vhostfd,
>> -                         VHOST_BACKEND_TYPE_KERNEL, 0, errp);
>> -    if (ret < 0) {
>> +    if (!cpr_incoming) {
>> +        ret = vhost_dev_init(&vvc->vhost_dev, (void *)(uintptr_t)vhostfd,
>> +                             VHOST_BACKEND_TYPE_KERNEL, 0, errp);
>> +        if (ret < 0) {
>> +            /*
>> +             * vhostfd is closed by vhost_dev_cleanup, which is called
>> +             * by vhost_dev_init on initialization error.
>> +             */
>> +            goto err_virtio;
>> +        }
>> +    } else {
>>         /*
>> -         * vhostfd is closed by vhost_dev_cleanup, which is called
>> -         * by vhost_dev_init on initialization error.
>> +         * CPR restore case: only learn the backend feature set now, but
>> +         * defer taking ownership or touching VQs (the still-running source
>> +         * might be using them).  The full vhost_dev_init()/VHOST_SET_OWNER
>> +         * is done later in post_load.
>>          */
>> -        goto err_virtio;
>> +        ret = vhost_dev_init_backend(&vvc->vhost_dev,
>> +                                     (void *)(uintptr_t)vhostfd,
>> +                                     VHOST_BACKEND_TYPE_KERNEL, errp);
>> +        if (ret < 0) {
>> +            /* vhost_dev_init_backend() does not close the fd on error */
> 
> Okay, but IIUC this is returned by cpr_find_fd(), is that funtion 
> passing the ownership of the fd, even that the fd is not removed from 
> the hash table?
> 
> Should we call cpr_delete_fd() when we take it?

You're right, that should be a proper cleanup.  Every path that closes
the fd after a successful cpr_find_fd() should also drop the entry.
Will add this.

Andrey
> Thanks,
> Stefano

