Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51424C5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 14:13:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtnDz-00056W-0H; Tue, 11 Aug 2026 10:13:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wtnDx-00056F-Cn
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 10:13:01 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wtnDv-0006lA-QC
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 10:13:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DK0kqWBqDYfyzvJdf4Ka7gzRRJ5nWWwYKuyKZOUBAC37QvqmaQxOmLtg1+NjUd/UxXzXI1+i0krmsj1ign6nHfFXIxNQ9fciK1TFqTNaSf0qTBMDcqPfuqm2tVOW9NdUVQRbnXKOpYPSEvlKDHNoMOMLlO7YDG8/s6ptB07f6NXUT0EjBULW77sBV0KhwfO9e/8Ty/P2LVkt9hD2TwGQep0SU+d7+pMQOtB5OxkU0BAE9+RHxKB/fuNBKzFTMz7R7hrXGITOz1TD8ElD/xrHvJpIN5me2j97Hw02RR6QKIIeQz6FhnCRq3/tSJjhNZbMSlEYYqwqI4AjUrzfch1niQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0TC2C90/2lhYvZAxhnqOmD7W9uGmGQATe6uHjtPGhk=;
 b=w6EYi7TqHImbr/yiBo8ujiv3pVWkA+rY6QEbqO6UJAkd37Y9bgRkUtQdtUItK01mHgtKVZYUiLgUWgRgYxKrqDxAkamHICcXWXR4rbk7PCC8KteMT+n36kkxq3h5CHeIHirbtQU/8ZFgY17KmvQ65J6mAL4E1N2Pgbqwb2U7KTMKEBz+go7bd3Tf5LsvS/BWcOtBY2suo3bQuVfW4Ga6tL5eKMImhSISdvFnrUajOEoU0gPyWPvu/wrtbhxaHV5wLpUW9SieLXceUC4fZxK2Vjc3+Bdbp3JRpRpPql9x6uVMww9zxybX1UYD2iQBqplr8rFbDdRYebVXJzfhdP+uuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0TC2C90/2lhYvZAxhnqOmD7W9uGmGQATe6uHjtPGhk=;
 b=TgCw1ALPOCT3vXHzgzkpm7mTO4J8gvwZ1cRo7p9JFs+sVqFyNpseHKpLYisi4V+iCgLNbOpM+LqXwW4IQ8x4pS+Oj/MYJWDeTcuIabhU07aE1xbppbIJ1QUd/t+jJ2xDViFMdekSA77fCjdlEo6etMLNfW8OGhCN2pGRF5TtZ72p2KVEamQUDf2jQ6UXaT6/GdoRKlgWFN//LNzY0tWpkokuPjr62PA8QsyXZNRBDZRBuGWvjJnqCzwvIxFWfPrJFZ5ARwBfvsU67dvQA+nJgB+t4z1jT5r65gDCsxZZvzkzlPFTkBuvFd/uBLilh8IDVJ1NK0QT21xDKK3zfyuojA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DU2PR08MB10230.eurprd08.prod.outlook.com
 (2603:10a6:10:46e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 14:12:54 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 14:12:54 +0000
Message-ID: <f335aadd-1157-4a57-bd8c-18bd6b76582c@virtuozzo.com>
Date: Tue, 11 Aug 2026 17:12:53 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] migration/cpr: support vhost-vsock devices
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: mst@redhat.com, sgarzare@redhat.com, farosas@suse.de,
 qemu-devel@nongnu.org, peterx@redhat.com, dongli.zhang@oracle.com,
 bchaney@akamai.com, mark.kanda@oracle.com, den@openvz.org
References: <20260626164643.2526-1-andrey.drobyshev@virtuozzo.com>
 <ee6fc8e2-dffd-4a93-8501-7894c593b760@maciej.szmigiero.name>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <ee6fc8e2-dffd-4a93-8501-7894c593b760@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR1PEPF000077A7.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::435) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DU2PR08MB10230:EE_
X-MS-Office365-Filtering-Correlation-Id: a2040737-a775-424f-3f79-08def7b2a312
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|1800799024|366016|4143699003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: OQRsxqqKKgCtpKbucWef4YDbuv/lRdOyLF4gJbJTozSaV/8rfOoYUs9BDeYOK1Z3ZaVfCxyr9mRpVt2cQUIrMCMrnfgGHeCR8AhPsrwiNFIURN7sxnZ8Cqt7AhB7UdQijS4YB/rrd+0TA1H0wPbsmPS/HV84Euo/bxQYlE3ne9KnJ+cInIYLt4AibErPes+Gz9Nn7af3iuDfsdNK8Bwu5zNMRuYW3MjZH58dTAtqOPgyjzrEGsvYVEFY7S/++y82KGC82Qc9FRYLsYQugv/p0IBMQOYy6jO4yPyX2Bi7M921GcDr++WewBjKY9gGSuPn3r9yEc/SXd0EMcUEv/NycNP0e2PazUSz/Ujrvs5tUScka1uuyGwHseDybXv+0itD/Y6LbMIchevuwaslYUYbgVYbJ5Murx8/8VVMydx1XkSK+V4hdFuK9L6nmmIBOnhj5PlaD1F/dhh322Jb5VMzwvt1VOJQHyZaBc5TxdVOU9zL66zmiTcznSspPqWAOaYXzuic/yMPo66MSKPh4xHcqkoL3daR5jtmz/XwdVfkAjC1y+Sit+H1Ov4f/BLhaNrkVA5NdBv+pjj7s2s3PlMRyHSz20LkyYx+pS5/2sEh2PTtNIIXz3e4NvkDlXS2HNbKVrmta2omxObn06PYqBSYlWfs99YBFX78vPSrxOnTrJQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(4143699003)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWMzeG9RT3VJZFdTVk1BRnVMdFB4TkM3OTVheHpjUGNDNDJSMXdBSitqSnh4?=
 =?utf-8?B?WW1aL2IxSjJlUG1DRUhrc0JhMGUwZzIxSjNIeFpJcFU3YUpwekM1U1Y5aEt0?=
 =?utf-8?B?SFNXb29MSDJsc0JDOXlwSzZZdU1YcFJORVdFZm84UFZ2aEVlNGQrVURpZUwr?=
 =?utf-8?B?Q3owU09VOFN3WTlINUs4OHVPckFwV3ZRVWEwYysrdG5WWlYyODR0T0RuMU1M?=
 =?utf-8?B?VDhFcERIeWdTM3EwUU5OYWV4QXRvWW1wQ2wrNXpKTXdJUnlhUmhENDRxT05x?=
 =?utf-8?B?WG1mbmIzOWpIYWx6UVNIMVdUTjQzUmU1K04xQ0pqZkhsR2F6ZEJOYVN2ZVo0?=
 =?utf-8?B?WFFDanNuaElMM3RlZ2x2UUNOUkptZldRNDZCcmZqOUlpbW9nb2p3dHVXdW1p?=
 =?utf-8?B?QVZCYWI0RHI4K1JxZnN3cVRuSE0vZ1ZJdllHMlZ4UjhiTVkzYVVsZis1Q1U2?=
 =?utf-8?B?ei9tRk5wa2VkYVh1RG5oR0tneit3SEV5dU9hd2ozSGJzdE9ocGFMSExyQzhZ?=
 =?utf-8?B?UFpCUG9hS2NHRXd6eVNlZnYzZXFsamVVdERLVi9pTEZzOGQrY0d5TldWejRm?=
 =?utf-8?B?dmVJazRtR3d4QTJhOGtIY1U5Wnh2L1gvN1V3Wk5rVzU2V0hhVG9hMXJaMjhU?=
 =?utf-8?B?VHNtbWp1dXdyajMzajFScWtqRE9zUzFjazcwbFNiakk1eExNb0lzZTF1UU1J?=
 =?utf-8?B?OEl5Y001enJIQ3pxOHB3RGtWTC9waHgxSVBJZkx3Nk5NNW10STVQVnRGeFJ2?=
 =?utf-8?B?ZG9mZGtHdWMydEpydURreTVwWEpJV3drd2R5a0Nsb3o3bm1MaDVSUGttY1FM?=
 =?utf-8?B?cUZmdS8yTHhPNEUxUHNCUUR3K3MxTXlhWStiL05hR1pXejJyZmVHNS90NFRq?=
 =?utf-8?B?QXV5TGJERnNKSHdCUmZRR3VhV0hFaVJjS2hyNUhCUWNERE5aa2dUbTZ1K1hk?=
 =?utf-8?B?NGtEZjhkUHF1QktYYi84MGY4WXVYWmlGeDc1TkdVY3JKQmhWVitzUStld1pD?=
 =?utf-8?B?RnV0bi90N0lLZzVITCs0ZHZJUnN2cTZqM1QwV0lVVlZrMTBFYWRlQ050Qkcv?=
 =?utf-8?B?T1ZBV0FkbjNXWTNmN0RuSDJSZVdqSVQ2d1p2eUp1OE9DZzJHOW1wVVZTUDRa?=
 =?utf-8?B?L1kvVWNHeEpidk9LbWkyOU54aWxna29sZzFtQ3B4ejRGZzZsK3ZLaWs2VHdl?=
 =?utf-8?B?L1c1UjhVKyswVFY3bm1RRk92VFpKLzdGRnhGcW1TbTBySk1BeU1MQW9Ia2Vv?=
 =?utf-8?B?Y2FwTi8wZ1o2VnYxSG55VXljaEZ5Ymh4SE9pRStGTlc3dVAyeXdNeHlJYi9i?=
 =?utf-8?B?akFwZkdrU2pxU2J0OStWTTV6Wm41RTRzeTNJdFV5cnBVcSsvcGk5dlBWRXBX?=
 =?utf-8?B?UVNSY3NuUnA3LzVreTV1VFdlUnJTenRhbDdlTDFYdlg0T1ZvRVdxVm1uRWVQ?=
 =?utf-8?B?UWlYZjM4RGkzWFpqUE8wVGQ1aXMvZFpGdGszWnJXbDE3ZURhL2ZPSTdjcUNn?=
 =?utf-8?B?eThkbkZlbXJiMzhObHo5UGx4VGhtSmRoQWs0SVROdUllam5KZDJrTFg3dGhY?=
 =?utf-8?B?YlpNUVN4YjZURVRQdENDTSsydDBmanJTYk9QUllDZWJTRzNqbzBPODZLM1gz?=
 =?utf-8?B?dzVZczdTbDVXU0FCYndRc1RXVVFKeW1Penk5aStodXhjcHp5VXJXQVpTQlVn?=
 =?utf-8?B?aGRhV0tDNkR5a3ZwOFpFaEdXN0dnUDd4NFRYWHZodkh1c0dlbENmdTJxeEVR?=
 =?utf-8?B?ZGw5QytqOHJUVHV1dExhM1UxUzJ2SzhxVUd4YjRVaUJpUHh5akVsR0FUWWE3?=
 =?utf-8?B?bmtQaUxBZUlYcXVlVnh0ZUdBaDNHclV0VFR2VC9jUnJvdWo3eU9qMWtvK2RH?=
 =?utf-8?B?VEY4dGRCNUh0cHI5dDdtVndZVnBjaUtGa2oyR3owTTZRUEpXdXJsWHNoWVNK?=
 =?utf-8?B?NXdsaVhWaXFyVHpCOXRqaUl4aHNMS2dTVVIzcWc1T0ZTdGJsajEwQTN1MWdz?=
 =?utf-8?B?NGV2S3Q1b0hXQW9wNk9qVXZaZ2w4VEgxRU9tT3ZITDVzUVJ1cVMvZ2w5M0tn?=
 =?utf-8?B?TG1vYVBERkpLK0N0OHh3TS9ycWY2WGM4SHhmUlpzRkpzY0p4c1pla1Z0M2JT?=
 =?utf-8?B?SkdlckN5M0xPMG42RDRpcE81UEMvRk95SzU1U1lwZTZCZ1JyRzd5WVpnU0tl?=
 =?utf-8?B?MThnS3R5UUhyblhYNTVMeFhWeTNVSEg5OGFKcEc0VEVYTGN2VGN4RWJrekFx?=
 =?utf-8?B?T1QzNk5rbGZDSXR1NFlCSExHKzltZkpHMHNsQWNvbk84Z0k0c2Fqa1psV3NC?=
 =?utf-8?B?cDdESXQrcFY0NHZ4bFdVMGhhdmdGYVlSWTQvQW9EWDhPaGhQYUVTVnhpem5G?=
 =?utf-8?Q?t0Q7eud+qEzBzTRU=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2040737-a775-424f-3f79-08def7b2a312
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 14:12:54.6666 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v79a1DnjEdYnvyYEi7y7i1DbQqK9+/EO5iqJqPAr0iIanb/Q82tcPm2vHNOgZS6r5YTiHJkqpPZ0nKytuc4VgAON8KQu68DszeiF8vkRZbU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10230
Received-SPF: pass client-ip=2a01:111:f403:c201::1;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
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

On 6/30/26 9:35 PM, Maciej S. Szmigiero wrote:
> On 26.06.2026 18:46, Andrey Drobyshev wrote:
>> v2 -> v3:
>>
>> Re-design device ownership hand-off (suggested by Dongli).  Do not rely
>> on SETUP migration notifiers, as this approach forces us to reorder
>> generic migration code (see v2 discussion).  Instead:
>>
>>    * .pre_save() releases ownership on the source (RESET_OWNER) once VM
>>      is stopped;
>>    * .realize() is adjusted to defer device ownership acquisition for an
>>      incoming CPR;
>>    * .post_load() actually claims the device (VHOST_SET_OWNER);
>>    * FAILED migration event callback re-aquires the ownership on the
>>      source after re_save released it.
>>
>> v2: https://lore.kernel.org/qemu-devel/57c9c9b3-d758-489b-95b8-d16c258b9b0c@virtuozzo.com
>>
>> Andrey Drobyshev (7):
>>    vhost: add vhost_reset_owner op
>>    vhost-vsock: don't reset connections during CPR
>>    vhost-vsock: fix FD leak in realize()
>>    vhost-vsock: preserve vhost FD during CPR
>>    vhost: factor out vhost_dev_init_backend()
>>    vhost: add vhost_dev_set_owner() / vhost_dev_reset_owner() helpers
>>    vhost-vsock: hand off device ownership across CPR
>>
> These patches look okay CPR-wise, so:
> Acked-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com> # for CPR
> 
> But the vsock parts still need review by their maintainers/reviewers.
> 
> Thanks,
> Maciej
> 

FYI the kernel counterpart series adding VHOST_RESET_OWNER ioctl to
vsock ended up in Michael's vhost tree ([1], commits
6236e765f16d^..c7bfb8815d83).

Therefore - friendly ping for this series.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git

Andrey

