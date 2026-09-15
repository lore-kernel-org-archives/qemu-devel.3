Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CC09C88E53
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 13:23:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6T7t-00062M-V3; Tue, 15 Sep 2026 09:23:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x6T7p-0005z9-0d
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 09:23:06 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x6T7m-0001Nk-Rf
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 09:23:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cpDvyasxyNy5WNviGiwUzC3jw6jND631OHkuE+4tEpc/GPGaVZDHYu3p+05qwTQ+gOo6M39f6x/X+Wyj2JY5V7n0hxXfBurLGKZjghEoRJ7n3BD53jQWuEZ+G3yn3f88eHWPiOTKus1VG78X53S7Oi3QNOOcdV8Q9Gj1we3Tw5ZCPEFUF3aLqlJpNCsHJ3k5dp4FFQS5aFMXabnz9O/M4zIvc+Bi1xDpE4+7HNAXS/uC+D61EEelaS8M09+E0NOW7DdtNdt/33I7S5WmOOxniD5pamzwdp0mq1qV/60k/HLCxq+QUWLzCXacrJzjpg0YJ6QlyMQcKJnsGWLQxot/DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKtIauDjd1+rGC71BJm098ozY+2k8wr+mJ2emkURFso=;
 b=SG6Fz3HqUeNPTb4CwtJ6os7Wbrfw7W3bEjloOzktJuPNT8LNUHeBxyCL1z/mWXoRuY+kXSbwvKWUhiWN/o2fIJsXPQmklqzPFRTH1ETzQ96GiLT2BdtI/m8939Ead/tdVD3j5FX/Tp0C2T2ruzxVxFTJ+hERL1BJo8njagL4DPa/4J4m0dUzgp62feFCyqZrcQEDnx7Wnqi/zBUyx9DGVcxRuPv8Z36aEymhIe1Yw8uuxbT63jnsMXlTrf6NDb0gKRaft6PeQ0T3oUVvpp73njUNPgEoGdJ96V3wKobIsjeq+KfGfWBFKKRvpw5CbF8v9nlq3EVbUsYxUAADDRHHyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKtIauDjd1+rGC71BJm098ozY+2k8wr+mJ2emkURFso=;
 b=NWNFp6dGC5rP7tEa+iD56QhNEzCXacgCuyWZxaTrVahyzslGryFi3zARCTcAY+yhDpFuoljd/Vg/A+EYrVpy9iXCrfSggI7LIW9uR79+MXQpjqG+FW5G8Ke1wG4bg3MaUj8aQWYaeW+eCc/IqkyBSqaPgQ0gnFDn25+SZPzvA/bHnd9xz4gUaN2JiLVIcKkpA4zJy6zIqcxSHM1MxcTkISvl6KGT6xYj8ZRB9KUpAw9AMDfBYZTs5vkIWuEQ8ro0kxinmJ9n/a2UDHgdRbhIvO57WlPxSohi8wMBbWVQE2sI+CI1LE8p/VqYzPFP2j7junNptKSo/rOA/iUyUsF0hQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS8PR08MB9455.eurprd08.prod.outlook.com
 (2603:10a6:20b:5ed::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.8; Tue, 15 Sep
 2026 13:22:55 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 13:22:55 +0000
Message-ID: <5c4deae1-339c-422f-ac37-17445b474eeb@virtuozzo.com>
Date: Tue, 15 Sep 2026 16:22:53 +0300
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
 <328755e2-31d9-432f-88be-bda72d3ba3f0@virtuozzo.com>
 <aqkXTbt49bPJW7R7@sgarzare-redhat>
 <a3d27ffc-679d-4b1a-aa5a-f3d9a7be155c@virtuozzo.com>
 <aqk_2QBTUzWeJ8eT@sgarzare-redhat>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <aqk_2QBTUzWeJ8eT@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0033.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::12) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS8PR08MB9455:EE_
X-MS-Office365-Filtering-Correlation-Id: aa50db71-f919-4d18-771f-08df132c73c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|23010399003|366016|4143699003|10067099003|5023799004|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: c7yHjAzRAenDF0lL03YwbOiAGioW9cb6ihUzn7wl1MrFUdXhh71XIzcajqu3749cufd55cvDjoY/RRFUjLj8CD5n8+wowEODIdub9DP3W0EiCpU6ug+qarC3TdpzkN1FPaXg1ArgutzkogfYR8jJK1OhmIy1ctoti/939YkRTERPsu/JZTavpAt/rozbVN/z+PedE0x4g32o+dfvvje0qLfawBlDFHHT5OViGBBx5yVkASqA6f6dxoybe9ngSBLfMUmPckXfNpb4Dq/WpqNWgBDukwHU8k/KZZbK1Wx3QDOyTT07RYgU6ZM2Q7mAx+hTJXp1hmOp2VC2QLi5O1CnjtwFFy9OUhYLnRGzHXVuFsGcMTwQB/xj3aaEZBTtUgiEmLtf7PNKkH/xIKTOoUSbn1X4n+i7lzaVNhM9DID/I9uWdS/u7fMQnU2IDRv0ycShazHm99vhEhkkwC9yplQscg7gprkloLOpikV7Zx9jLA6laibhgc76SoBCsZ05e3bH5BudxzmyqdL7cgBu837yy3pcutzegtshsmAOGjBqEMhMxVHL5pGfyzGNk3sqnQa2ELoEwSeunCO9vV8IN436a+HV2RfGEUtMpEBSHMgt13u+L+LDaOeIbuIxTM58YYAnlP/3qo17OnDEordo34raZK4W8up/0PdqH7v0c9KtINQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(4143699003)(10067099003)(5023799004)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzVqU29vZGpSMjRjcHd2Z0c5d3BwZUZnZVJvV1VIdEdCT2hFckNDZzdNY0V0?=
 =?utf-8?B?ZEh5ZXZQMUZyaG9zK0ZtZ1hZRXBHajdxU0J1SXp2N1grcVNtaldjaXBTSEcr?=
 =?utf-8?B?YzRGU2J4NHJjN1ZYYjZOcEVYV2VlcXNJWTNXbTNlWGRPMUxaZHpUYUJ1Z0Ny?=
 =?utf-8?B?eThibWlMWFRPamhhN3BmSzFhSy9pVTVKajdTQ0I3MXpLMlM0NG5PNmpQZ3FQ?=
 =?utf-8?B?VjF5WHlsNG1kMHA3TnVBVnozVDZMMTRGc0FMUzlwdUhPNjIyM0pFdWhFU001?=
 =?utf-8?B?L1I5Q0JyTVZNbTVrMGllZmZBL21oV0xyNHhGWnBYSFlPOFpiZUp3d2h4MkxS?=
 =?utf-8?B?SGl6c3Ixem1QMmlJbTFIQ0IwckNRSFpLdWJISnJnTStBc01JWFFkL2V0VnJo?=
 =?utf-8?B?MUNxaFZiRkFaNDFxNzR1dXNYV1dhbjRJN3FLZHgrL0pUL29Sb0dsWVpNTWNr?=
 =?utf-8?B?clBZelB0cTBQbWFZSDR3Z0NnZUZqR2Jta1hLeWJ3ZUxoS0N6OVVrNmNTcG56?=
 =?utf-8?B?Rmo3THVMOTk2emkxUVB5bTVPdmlTV2cxQWdhdVZCZ3Z6bjZGTVZONm5Qem8w?=
 =?utf-8?B?eDZKeUlnVk9DSjNITWFERWdNN25RM01XRzNRNXZacXF0V1pYdHZGRjBvb24z?=
 =?utf-8?B?bERBQzkzMU5TU0hVeUcwMllzdXRaYkZBVWc4K1lXTG5HeHc3TXUwbmxRd1NE?=
 =?utf-8?B?WERkVk9LdnFkV0VOcUliTWlLMGtnRnlFUUJsckdDd3dyUWUvK3VKQWk5Z1A1?=
 =?utf-8?B?Yk5zM3pwd1lrM1cwV1ArUUlQK3o4OFVGallUVk5hTDUvMHRpbW1GNE5xUStt?=
 =?utf-8?B?MGpZQldCRVFXcXc4Z21EWWREN3YxejVvRUc5YXlvUVc0TW12aU4yS25PT0hG?=
 =?utf-8?B?dEFFR3VXU3M5RlRLYTdSc2x3VDRnQjB6VmVadC9lVUE5NGt6S1haVmhYaFBO?=
 =?utf-8?B?ZUdLai9sRkZqTTZZTnJGeElFY0Q4QzVGQytoaU9rc3dtZU10OUswV0VKYnRo?=
 =?utf-8?B?N1UySGJyYjc3S0wyRWRYTjdqbHhiVkg2YkQva2dZajhwUzJOUTdOWndoV1NN?=
 =?utf-8?B?dGJ1TEVZYk5IT1NjYUhCUjBDVTJXQlZLNVhQS05DSU5tbnlQN3JMMFZqK2oy?=
 =?utf-8?B?L1k5M2ZGNlR2V1VLYmxDYUVJU2x2Yk5OWUlUejAydGt6Zkdpcis5NEtoT3NS?=
 =?utf-8?B?QnhCbld1alNPTGtnLzltTERSY0UxMittaTFjVjJheG16NDJMR2ZIVVorTllw?=
 =?utf-8?B?MUpDcjE4eE1yYmRTdkREVkhOb09UZ0laZU9nb2VCWUp3MlFNQUZHV25QZUdx?=
 =?utf-8?B?Uk9XWkVnVjVqM0gybVk0cU8xRXZRYnVNZVJaKzBvdkZtU0lTU0lBRDBiZncw?=
 =?utf-8?B?Y0JrcXEyU0gyc2dwcE50V2lIVkdSb3FtRUNSMGdJcmdRWm9WWFlxbnJSa0Zy?=
 =?utf-8?B?U3M0QVR2Zm00azRMWmVSakR0d2pCUUUyaFE5OU5pK2ZuYmNlRGFCNCtxTGU0?=
 =?utf-8?B?dG1hdys5cEU1Ukw0bEx1Mko4SWdlanVmQmU0c1Z2eHdMQW4rYno0U3EzaGhI?=
 =?utf-8?B?ZEk0Qk9mUEMyYnlNRkZ0ais3eVNIZFJKN0FLbWRLdEI4Qms1YTdTaHVISHhX?=
 =?utf-8?B?Ymc1UnlOZmkyNjBCQzZ5WkVWVFp4aVdZdXFTTC9YU244Qnl2WWVCcUc3dnlU?=
 =?utf-8?B?ZktUT05qNjl4TDI4b0U3aVg3UmtkT1RvZG4wT0NSWGk5bEl4aGRKZ0dQbTFB?=
 =?utf-8?B?MHlObHVaK1o0Y29EcmgzZEsxWEtqSFZ5K215TWhjRU4wWlJUMjRia2VKTGFD?=
 =?utf-8?B?SmRHRXloSDRUR3dKbndqYUVub2xsSEoxaEhaQ09UcFlQbVF1Z1lhYjl2VmFk?=
 =?utf-8?B?eXM5bnVIWW5HenAvTk1KZStjVzNpd1N2Z24zSGlkOUh5NzNta3JBSHBsL3hz?=
 =?utf-8?B?UlIxV2NDdElrdXY1d2wrMWF6RlZjcW1aWGNoOVhjRHp5NGN5MFZMUGtxaE1Y?=
 =?utf-8?B?eXZLNEtzTGNQYndlaENNWDRsUjlYSGpOUzJaZXBMRjNBNVMvYndDNlN1OERN?=
 =?utf-8?B?TFg1T0ZGS1NkdENnTzdMLy8yRlFnaVpwREovOWlRVmFtMHhmaWdOTVQ5dHA4?=
 =?utf-8?B?NC9LN2NGRnIzbUg3NXRrMlkxUEpUNGg5bThqSnhPd25sNEZkMWdyWTY3dGcw?=
 =?utf-8?B?RHBqV3A0YS9ZMTF0eXRiTnVxYjRNaDY2MzdqdjhPclhTeFcxeXFrdmpKVG5a?=
 =?utf-8?B?L1k4b29QSGZuRUJuM2VLTFRFYmRtV1lxamlqYlRhVDhPVjlEdk9VVVoxSksv?=
 =?utf-8?B?QWs4Um9VVDNOaVoyRFVUbUdqYXFiMWJEU0FUem5idTY0bUhEL3luRElVdXBI?=
 =?utf-8?Q?HPYF1w3UUdhTRebE=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa50db71-f919-4d18-771f-08df132c73c3
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 13:22:55.2493 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KwbUvRBRNxS9UZVjl0TAQn0kQkfM82KtXzHy3uK043por+hj8GtLGTFfFb59pFNSIYw3Rh/MdXSXqyvm9jAl1DlbFCbgv6r+AwYA65j5vxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9455
Received-SPF: pass client-ip=2a01:111:f403:c201::3;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
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

On 9/15/26 3:56 PM, Stefano Garzarella wrote:
> On Tue, Sep 15, 2026 at 03:36:10PM +0300, Andrey Drobyshev wrote:
>> On 9/15/26 1:07 PM, Stefano Garzarella wrote:
>>> On Tue, Sep 15, 2026 at 12:56:11PM +0300, Andrey Drobyshev wrote:
>>>> On 9/14/26 6:36 PM, Stefano Garzarella wrote:
>>>>> On Mon, Sep 14, 2026 at 11:37:45AM +0300, Andrey Drobyshev wrote:
>>>
>>> [...]
>>>
>>>>>> @@ -115,8 +147,44 @@ static uint64_t vhost_vsock_get_features(VirtIODevice *vdev,
>>>>>>     return vhost_vsock_common_get_features(vdev, requested_features, errp);
>>>>>> }
>>>>>>
>>>>>> +static int vhost_vsock_pre_save(void *opaque)
>>>>>> +{
>>>>>> +    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(opaque);
>>>>>> +    VHostVSock *vsock = VHOST_VSOCK(opaque);
>>>>>> +    int ret;
>>>>>> +
>>>>>> +    ret = vhost_vsock_common_pre_save(opaque);
>>>>>> +    if (ret) {
>>>>>> +        return ret;
>>>>>> +    }
>>>>>> +
>>>>>> +    /*
>>>>>> +     * Release the device ownership now for CPR migration.  The device is
>>>>>> +     * already stopped at pre_save, and destination reclaims it by calling
>>>>>> +     * VHOST_SET_OWNER in post_load.
>>>>>> +     */
>>>>>> +    if (cpr_incoming_needed(NULL) && migration_is_running()) {
>>>>>
>>>>> Should we also check if vsock->owner_reset is already true?
>>>>> Or it can never happen?
>>>>
>>>> Actually you're right, and we should also guard the RESET_OWNER op by
>>>> !vsock->owner_reset.  If we fail somewhere after .pre_save() and the VM
>>>> was stop before migration - we don't call set_status() just yet, so the
>>>> device ownership isn't re-aquired, and a subsequent CPR attempt would
>>>> fail here. I didn't think of such a case, thanks for noticing.
>>>
>>> oh, right! Thanks for checking!
>>>
>>>>>> +        ret = vhost_dev_reset_owner(&vvc->vhost_dev);
>>>>>> +        if (ret < 0) {
>>>>>> +            error_report("vhost-vsock: vhost_reset_owner failed: %s",
>>>>>> +                         strerror(-ret));
>>>>>> +            return ret;
>>>>>> +        }
>>>>>> +        vsock->owner_reset = true;
>>>>>> +    }
>>>>>> +
>>>>>> +    return 0;
>>>>>> +}
>>>>>> +
>>>>>> static int vhost_vsock_post_load(void *opaque, int version_id)
>>>>>> {
>>>>>> +    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(opaque);
>>>>>> +    VirtIODevice *vdev = VIRTIO_DEVICE(opaque);
>>>>>> +    DeviceState *proxy = qdev_get_parent_bus(DEVICE(vdev))->parent;
>>>>>> +    g_autofree char *cpr_name = vhost_vsock_cpr_name(proxy);
>>>>>> +    Error *local_err = NULL;
>>>>>> +    int vhostfd, ret;
>>>>>> +
>>>>>>     /*
>>>>>>      * Only reset vsock connections for non-CPR migration.  For CPR the
>>>>>>      * guest cid is unchanged, and the cid-change reset would otherwise
>>>
>>> [...]
>>>
>>>>>> @@ -164,19 +262,21 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>>>>>>     }
>>>>>>
>>>>>>     /*
>>>>>> -     * CPR migration of a vhost-vsock device is not supported yet: the
>>>>>> -     * device ownership is not handed over, so the target fails to set
>>>>>> -     * up its device.  Fail the migration early and gracefully instead.
>>>>>> +     * With the ownership handoff in place CPR migration is now supported.
>>>>>> +     * Having a unique ID is mandatory for FD preservation during it, thus
>>>>>> +     * we only keep the migration blocker for the ID-less case.
>>>>>>      */
>>>>>> -    error_setg(&vsock->migration_blocker,
>>>>>> -               "vhost-vsock: CPR migration is not supported");
>>>>>> -    if (migrate_add_blocker_modes(&vsock->migration_blocker,
>>>>>> -                                  BIT(MIG_MODE_CPR_TRANSFER) |
>>>>>> -                                  BIT(MIG_MODE_CPR_EXEC), errp) < 0) {
>>>>>> -        return;
>>>>>> +    if (!proxy->id) {
>>>>>
>>>>> Ditto about using `cpr_name` here.
>>>>
>>>> Agreed.
>>>>> The rest LGTM!
>>>>>
>>>>> Thanks,
>>>>> Stefano
>>>>>
>>>>>
>>>>>> +        error_setg(&vsock->migration_blocker,
>>>>>> +                   "vhost-vsock: device ID is required for CPR migration");
>>>>>> +        if (migrate_add_blocker_modes(&vsock->migration_blocker,
>>>>>> +                                      BIT(MIG_MODE_CPR_TRANSFER) |
>>>>>> +                                      BIT(MIG_MODE_CPR_EXEC), errp) < 0) {
>>>>>> +            return;
>>>>>> +        }
>>>>>>     }
>>>>
>>>> There's an interesting consequence of adopting qdev_get_dev_path().
>>>> IIUC vhost-vsock device inherits from virtio device and is always
>>>> attached to a device which is virtio device.  Then in qdev_get_dev_path():
>>>>
>>>>    bc = BUS_GET_CLASS(dev->parent_bus);
>>>>
>>>>    if (bc->get_dev_path) {
>>>>
>>>>        return bc->get_dev_path(dev);
>>>>
>>>>    }
>>>>
>>>> And all virtio buses, namely: virtio-pci-bus, virtio-mmio-bus,
>>>> virtio-ccw-bus - implement their own .get_dev_path().
>>>>
>>>> This essentially means that for vhost-vsock device qdev_get_dev_path()
>>>> can never return NULL.  This in turn means that our migration blocker
>>>> which is now guarded by proxy->id can be entirely dropped.  We can just
>>>> always allow CPR migration and simply do `g_assert(cpr_name)` whenever
>>>> we obtain that name, as it's expected to never be NULL.
>>>>
>>>> I'll try adopting that approach, unless you have any objections.
>>>
>>> No objetions!
>>>
>>> I haven't looked closely at `qdev_get_dev_path()`. Can you check if it
>>> includes the device type (or the id) in the path, or should we add a
>>> suffix?
>>
>> AFAIU it includes neither of those, and it's purely the transport bus
>> address.  For different kinds of virtio buses that'd be smth like:
>>
>>  * PCI: "0000:00:02.0"
>>  * virtio-mmio: "virtio-mmio@000000000a003e00"
>>  * ccw: "/fe.0.0001"
>>
>> And then we have precedents of other subsystems appending suffix to this
>> address for the purpose of CPR indexing, e.g. physmem construct RAM
>> block IDs for CPR as "<devpath>/<region name>".  So we might do the same.
> 
> Oh, nice, if we have something to follow, I agree we should!
> 
>>> Let me explain: I'd like to prevent other devices from conflicting in
>>> the future, so if we use “vhost-vsock” as the suffix, we should be fine,
>>> but I haven't checked carefully what it returns, so maybe it's already
>>> there.
>>
>> Now, IIUC when we add 2 or more distinct devices which a siblings on a
>> virtio bus (of any kind) - they do get distinct addresses on the bus ->
>> qdev_get_dev_path() will return distinct values.  So we should be good here.
> 
> I see, and source and destination must have the same bus addresses, 
> right?

Sure, but it has nothing to do with the CPR code, it's a generic rule
which must be followed by whichever management layer orchestrating the
migration.  E.g. libvirt must launch the target QEMU with the same
cmdline and devices having the same addresses on their buses.  Otherwise
guest OS would get very surprised when a device suddenly changes its
address on PCI bus.

Andrey
>>
>> I'm going to adopt this approach, as well as drop the migration blocker,
>> and do a respin.
> 
> Great, I agree on next steps :-)
> Stefano
> 


