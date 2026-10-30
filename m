Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5997D606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 11:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=selector2 header.b=WIteih6k
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMkTj-0005yE-Jr; Fri, 30 Oct 2026 07:09:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1xMkTN-0005u6-PN; Fri, 30 Oct 2026 07:08:37 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1xMkTL-0001XI-U4; Fri, 30 Oct 2026 07:08:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xgFomzS/fVy+KEf0rI7XuXXMHN3+Xyw451/hdOHYWJPjM7CbxSAAyCyUrjDIbxIfFKIFh7vB5XexLtsXy0BCy/JaD9w1WJWE2w8Mkhp54dpcT7WNslRgIIJAXaEkCneSuJHug0iSwz96qwd1zhNXPSUVlXv2etKJ/IfvfpFl24RPFCYNocy2BV0akCHSVZ0/Bnz1fSeO6PztcPqbkUaG805yxp5EGLwFKoWS207UZbqn83a8Kp6pvoNn8en/envBGoZUXN8mKgwowkIU2gLsf8MPHx6yruHsSzeBPlFkBjOoUBpSukxq1XT5wyczpsyXkgznEqaZg2Jm27YJxjLCsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B8SH1GKkR3dpoJJdrXSSNryXM0kMfanPG2X5QbD1q3Q=;
 b=AP3EvV16R+kS538j9oHZ3BsNkGdhRtZWsA3NIioSmjuaDaK9qQz0EyKgDCtoPYh0Hl2BB/H/q3gjMjfk/qC28a54Mf3pzm0WVF5VPjYnKlKa6gj4FtaMVzjIKV9USP5pgcHEyrmxYfXv5P/ad6j54ClguINP8UidPvhJBIGHBR3DY5Z7IEyDvwbHkZSPIs4NYhXdYqZVttei3xsMfOIh1jxzGPDflv72Io8zIyL9WZtv262tAUbPbeHxZ9KqTh56q3d2/zCNRsSGfc8cC7hasW+Dq86g2EUltfkhXUPpJCJ0lQ2dmkyw1hNOqcEHAQh4sjCVq+WZq9oKbX3T5U7Pdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8SH1GKkR3dpoJJdrXSSNryXM0kMfanPG2X5QbD1q3Q=;
 b=WIteih6kDg+2InROtNnnsyolZV8lwXeCIfZQ1pYCBfRkazdMCqGqb0f76vDEhTO3gdmZnDfsl09Ul3XDkIh47aR06Mi1c8RarX3B4ZZS+J1WEJd/oxcCYnQQS1BavU41wcTDykQQReGZowdDqh4W1DJTsx0k7P2sk3HOwSxjc1+SXhhy/gpb5uF286B5UKic2zuwYXKo5hqORz/pLCCCAtahZkjx9e6nHuZ0w+nrgS6jw8YdSVV0NRyrhgR6yuACX5WM3mzOHke8+2+Qetj7tMQMamIHJ0bqWyE/F8cgN0Q1ojh5qXQNAtHVyYSINgxY5h8Yd4v12PBY7j87fgyabw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by DB9PR08MB7423.eurprd08.prod.outlook.com (2603:10a6:10:370::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 11:08:28 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%5]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 11:08:25 +0000
Message-ID: <b052d608-7dca-4100-a7dd-5d44f8529198@virtuozzo.com>
Date: Fri, 30 Oct 2026 12:08:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] block, scsi-disk: honour a size change on child
 replacement
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>
References: <20260812121500.1034178-1-den@openvz.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20260812121500.1034178-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIVP296CA0016.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:354::19) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|DB9PR08MB7423:EE_
X-MS-Office365-Filtering-Correlation-Id: aa61ed5d-e6f2-4f6f-6143-08df36761e5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|23010399003|1800799024|366016|56012099006|261009223027099003|261026140227099003|261026121527099003|261028144727099003|261021123027099003|261021121427099003|261022105027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: zN9Mo+8RZYmRDv3yGkdJKqfOqFmGY7R3d8/6uraV17ew1ew653gJqWv7/kDzgPjySSAuYuevcLNWYCiteRCo/vxKSBNqE9rzatjCYczP4jdEteoPP6tp5BP4aj4x5siDdD929oEmFyNOsWHq98oc1o+uCqo9WSssbrz0H8CxWRA7Mhs9YYH/aI9y+lLf2gLqrjr1ayR+h8rLbpqP2qa9s+wa0TBu3K4rwc7zQndQ9aWWUccET3sWPFpedyS4WLbDQ8IvCC3KsXZK4zplThTSgSeATINK6y0EKMzlNMglp/Xd51O1ilKMiScrzYJN7vSVcmDkY8hBHKjAl4LwltjkVfcHAvvnyuxwXBwwbBDqeZp3WmRcG5ly98XyJbfFE28vrBNZAwli6CmKOQDqd3tnOI7FuDf5+iAn1DgjoDiK4I7N4XVEnAXNof1dC/ygdlm5mWB9mTp0bycRUsWaK2x264eU4GC+dqQHShxgFsXE2Pf523N7h7WRCRMklbX3+vDgx8hqNDczxgrzuhTUKGNZ2A7iKOBtaW1jZKRAqWUo9CpHKstxB11ji+H3RENGzam7v4eeIv8SUoj0QNC6yBPOYsrZrUaFsaYP9ROZSEeB9THqAXTfervZvejOUgi3fY2Nl3YfGtciw7LxpNV/ETX4+9awtFl19NqvdhAy6USpw2U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(23010399003)(1800799024)(366016)(56012099006)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261021123027099003)(261021121427099003)(261022105027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDNjckVCeWZ3cnhReTdXK2ZLZ0hBV3NlRDkzNHR2WWd5QTlvVXRwWmtaQTFz?=
 =?utf-8?B?YlhONk5sVDIxNmJoWEd5ek81eDY1MTlnTFpjYkNqV0crTjlzSktOdGc2VnNI?=
 =?utf-8?B?ZGhWdHI3Sy9QU1g3SURPa2V4cU1UUnhyamZFc0lsbUhFZXBObFdVTkpJWnUv?=
 =?utf-8?B?c0VNbFFTV2ZYRjQ4NFNJZnNNQ0FXNUs4bWdYcTU3L0xNNHA3TDY2SHh0MmFu?=
 =?utf-8?B?WnFwSTdEVmQzeE5kYVlxYVpadHRIdnA3aGdWNVRHbkxQS2x1U0Uzck1TTkd6?=
 =?utf-8?B?SlZKSDNWL1hkenluTDZUM2RUaFpxaUw5dWZxUHQ0YmhoQnd6cFZWZGsreml1?=
 =?utf-8?B?R1hzK0Jtek5NTGp0cVdXdHhhRkNZbUlrcDEzRVMvSjBodHBQZ2NOSFN3Qmxi?=
 =?utf-8?B?QUNFUnhQcCtTQ21oRWF3bDdVYWJoMm1hMzhTWnFFd1o3eFY4NnNSMld5ZXVh?=
 =?utf-8?B?V0FPV2tJMG9ZUk45dktHenlReVk3dGJ2cU1UQ2V3cTR6aEpBUFVWNTNTeGR3?=
 =?utf-8?B?Z2t3VVA5NDlqUTg2MnVGWFd5dWdsUU1IdDRVa01YazN6TUlleERxalZzanVP?=
 =?utf-8?B?dkdQMWhHdGJORS82NysrYU16YVFwM2hJUXZ1MjNUQThTSEs2RUNGZ1RNcksw?=
 =?utf-8?B?NUg4dy85QzlZYTRTUEptaElxSm15SWVjSzNUQjVjNHBZaUUrOEV4WC9Sb2J6?=
 =?utf-8?B?T3c0dGNUTVdDZnR6SUxJWDZJcVVzaC8zTW5pdm1VOHhsNWUyUDJnY2g4VzJY?=
 =?utf-8?B?dTFtc3o5b2wrSmFyZGY5Q1JoUFNZeGZGby8vRnQrcmJwSThFRGFRbi9hNVBC?=
 =?utf-8?B?ZlFEcFZDRFhmaGFXZ3M4MDVVOTM4YllQNzFyL1VKTVNwSDZKZ0JVNWQxSys5?=
 =?utf-8?B?WmZYcTE0SG1JV0Q2ZVpEV1ovRTBxK1EwWDZ6Z1FHRkxxVm9aWVFoVGpaODFw?=
 =?utf-8?B?QVBBNVdGczh2cHJPQVRjNk5tQjFrTHBuSGI4aVJtRXdEMEdWSFNvcmowOXVY?=
 =?utf-8?B?WDhuTkRabTl3Zi9rN09vYjB0Q3RqRzZEWCtSd25kTG5temRMbWs4aVdwVmhv?=
 =?utf-8?B?TDAzODZzQXMxRnZ5MTlJdmhQcmF4VjJlNWNxYmpxUTBERzFhTWxibU1VMkU2?=
 =?utf-8?B?U1NxMElTRVNxUGxUcCtPYTUxQlVpWEcyVW9LUmwzcXVBa3BSYzVwVU1PRVJl?=
 =?utf-8?B?UVpSUFJQRVhXQkVIUWp4ZitQcVFxRDE5YnV6Rnc4cCtwSFVFUjBjakZyMVp1?=
 =?utf-8?B?Wk5FWmlvZ2pVNDFwRGZ2MTBVRUt3Q1JraFNMTC9MalJCdElaY3B4SEZNWTg0?=
 =?utf-8?B?T2tZK1k5akNISzRON25lOUtZcmdnQnVxVTE2cEtFQ3J3QkU5V09TN0pPaW5t?=
 =?utf-8?B?aU00azZvdklyUXhtckJpRzk5ZStJMjRIQlBXUlVVQ0RaWlRFK0F1dkJiK1ln?=
 =?utf-8?B?aTR6VnFaUVJZNkZ5YmxHWTdGY2N0L3hyb1kwbGIxRHFKTGpPdFVicEJiT1VS?=
 =?utf-8?B?ck1jbEpDNFFtZWpuMHVKc1Z3czNDckI5cHFBeDJ1dWowaWdpek5pVVkzTTBo?=
 =?utf-8?B?SUVxRkZqZTF6MFp4VXJhQW9tVzgzUEFOZXZZRE9URHN2VkRpbDU3MXlWOFgr?=
 =?utf-8?B?djFMWHhvclBudDFOakV6blRSMVRVWG1tN0pqMTZyWXk2UlluWXZ1UjRvSFF3?=
 =?utf-8?B?OEVpa210RlZUNXgrWFNTL3VZUVJBaVd5YWNRMU5qUGZLMFFWeE5KV2k0eG9X?=
 =?utf-8?B?SXNuWk84VXNFYndaSnkzMkVTQ2F3V3AyN0puSWVzYmRpTjNhZGFTMFlzNExw?=
 =?utf-8?B?NnYwbEdxRitnYWRvalNaaENoSmwxRmNGWTJpWm9zVDh5VTdsMUhBeStxTnVW?=
 =?utf-8?B?cFY5VEk4bGN4VW5Da3ZDTUVkWTgvL0dUZlY2VUtTTWhCWTJNMjRoV0g4ZVVS?=
 =?utf-8?B?Vkx0b3hGSXRLVzJYOTJlQUZQNU12WGFyMWh4QnU0T3VsYm0rZDJVa2VNNWRR?=
 =?utf-8?B?MExiaGFtc1paRXpiaW50eDRBV3JlalVPb0lMRW5KK20wMXMybk0xeFdQcXJ6?=
 =?utf-8?B?c29jYlFCODJNMG1TT0UwRGpPaW9abmpqMTlpSTNybDl0aVRGc3NxSnNCWElN?=
 =?utf-8?B?WDZ5Znk3enRLaEdQMWorL2x0R1JuODdYaDkwT2VzZDMwM0pWVThZZHFkVlh4?=
 =?utf-8?B?b1pYVU5lSitaakc3QjB1UHBLRGNzNzBMMkgybjl2enN2OEhUUHExY0tTU0do?=
 =?utf-8?B?VVp0ekVSMHZqU2JyYU1hMVBFOUJnVDF1UnFNTHNpQUR2U1hPcXF1bXgwWGNC?=
 =?utf-8?B?SnFsTVk0OVhPNjFEWjJyL1Y1MzhKRkM4ZGpPdTByc2hicUtWS0lCRiszbGxZ?=
 =?utf-8?Q?VlO2LTDLN+2TI/Djld0f2uErTRerw3KAaufCF?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa61ed5d-e6f2-4f6f-6143-08df36761e5a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 11:08:25.5060 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6rcdMaUD1z/JgxPtqUBL54F4t0a4ZUDHcBW2z5DavsgRmgoJppQBtH4sr8h/zyK0+7eC8WR3rtzdwsxphMp1sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7423
Received-SPF: pass client-ip=2a01:111:f403:c207::3;
 envelope-from=den@virtuozzo.com;
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 8/12/26 14:14, Denis V. Lunev wrote:
> This email originated from an IP that might not be authorized by the domain it was sent from.
> Do not click links or open attachments unless it is an email you expected to receive.
> qom-set of the 'drive' property is allowed on a realized device and ends
> up in bdrv_replace_child_bs(), which swaps the node a BdrvChild points to
> without telling the parent anything about it. Every other way the size of
> a node changes goes through bdrv_co_truncate(), which does notify, so a
> device model caching the size of its child has no way to learn that it
> changed.
>
> scsi-disk is the one really hurt by this. check_lba_range() validates
> every guest request against SCSIDevice.max_lba, filled in by
> scsi_disk_reset() and updated only by the READ CAPACITY(10) and (16)
> handlers. Point a scsi-hd at a larger node and every request past the end
> of the old one is refused with ILLEGAL REQUEST / LOGICAL BLOCK ADDRESS
> OUT OF RANGE for the whole life of the device, which Linux turns into
> EREMOTEIO for reads as well as writes. It is silent on the host:
> out-of-range requests are answered by scsi_check_condition() and never
> reach scsi_handle_rw_error(), so there is no BLOCK_IO_ERROR event and
> io-status stays 'ok'. virtio-blk and ide call blk_get_geometry() for
> every request, so they end up with a stale idea of the size but never
> refuse I/O the node underneath can serve.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Hanna Reitz <hreitz@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Fam Zheng <fam@euphon.net>
>
> Denis V. Lunev (4):
>   block: notify the parent when a replaced child has a different size
>   scsi-disk: refresh the cached capacity from the resize callback
>   tests/qtest/virtio-scsi: cover a replacement that changes the size
>   tests/qemu-iotests/qom-set-drive: replace with a differently sized
>     node
>
>  block.c                                    | 13 +++++
>  hw/scsi/scsi-disk.c                        | 16 ++++--
>  include/block/block_int-io.h               |  3 ++
>  tests/qemu-iotests/tests/qom-set-drive     | 14 +++--
>  tests/qemu-iotests/tests/qom-set-drive.out |  2 +
>  tests/qtest/virtio-scsi-test.c             | 63 ++++++++++++++++++++++
>  6 files changed, 104 insertions(+), 7 deletions(-)
>
>
> base-commit: 3e3ccab106f879b1512f8e0d51a827dd4de30e22
ping

