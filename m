Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D6E606A32C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 14:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=selector2 header.b=vwcTSAOo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOcJz-0004al-LW; Wed, 04 Nov 2026 09:50:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1xOcJx-0004aK-Mb; Wed, 04 Nov 2026 09:50:37 -0500
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1xOcJv-0003N1-QG; Wed, 04 Nov 2026 09:50:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XDt2W/RoUETwpNGYTHMu3if25Oa1TyNkRLBnU6Zdz4TPbe4dcs7j5y26ewbMnqoKziHFl2lcZAR3l4dhFoihgzsMxR6sosJpD6Qma3fGdUrc72fM9eUP9ORP9VTfwnhu5j9KI5acpv9wPIpeArjxYjIOTTnqzGd/gZ9q530LIdd9PjGSgNZ0LR1jENBrLpZORUKNNUKUBJTrlz+XYAeiO3QEKNzf8sYs3tON/jf/P3dehwEmeJetRJToRk973xVxTIvyJzQ7WqAe1x2mcP+Eh7DZtc1/Cm3oDFT3j5SemakIPAGUcT1+zDX8RxbHv1vi9BUIg1YN0/DMilWjmJ63Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhd9fxZyHG9SNpU4xsRQ18WVzrB9rGBWKUyhXGXrEz8=;
 b=S3JrOiaO90SbVj6+1a1/QTh9UEg9X4djyw0KylOgks/rBBIEL8IESwXl8iT0XxrStKpqIfKcnDIgkO1Yys4RgilBYmAi5RHil381/3KTGW2K549yh5k8rBzDy2r8jZo9OCH0zE9RkadgaLGty4sLwo7nCU0svQPtOE9jWb4Diklu41XB8GhGqe0wcEdCs72T9hUTGfMLqIyikRWSzcLBIXle/PpNi9N2uf1ckhuYA6UnYz6TodEZjubvS4ZLF4UkC8iwloUe30nd5rQWY5sfmp+mypcCEz9tjVhePdd90Y7yLOL8ygsK2/rr4sELYXCQYccRfBbenpCVr4Xhs5hvdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhd9fxZyHG9SNpU4xsRQ18WVzrB9rGBWKUyhXGXrEz8=;
 b=vwcTSAOo8A9WdLAj4u9a7GltgklFWlRnTX06qBWFPcNPKQstWwy1O8YQO1sxqDlsjwEQjVHRWyvkxag+K+a+rpRupiR8p3MhKlx2j9mpiM45qZco5dAVmNQGc6/TB3vmCYDk1ZMyWV8fqBFK7oPHtVsLXxmJv45ekYlR+exN5PImkRPPM7FgLpJaVwgaHZF1iQaUacu52wxY8OOM5VU2VzJSOta+IDKm4BjXV0RsHTqECSLt1nS9w/xwQj1MaFBAi/+oq8hQkoJWxnaIpG+QYRn8cup0ofzpomNc5sQTxUBA0wQB3cV0USfilzwS0rL01nayXWIKOaPocdyaRLxZUQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by PA6PR08MB10694.eurprd08.prod.outlook.com (2603:10a6:102:3d7::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 14:50:29 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%5]) with mapi id 15.21.0569.011; Wed, 4 Nov 2026
 14:50:28 +0000
Message-ID: <ab8f044d-79ad-40c0-8857-50cef77b0b68@virtuozzo.com>
Date: Wed, 4 Nov 2026 15:50:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] block: notify the parent when a replaced child has a
 different size
To: Kevin Wolf <kwolf@redhat.com>, "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20260812121500.1034178-1-den@openvz.org>
 <20260812121500.1034178-2-den@openvz.org> <aumxKEG88eJAAupA@redhat.com>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <aumxKEG88eJAAupA@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0502CA0011.eurprd05.prod.outlook.com
 (2603:10a6:803:1::24) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|PA6PR08MB10694:EE_
X-MS-Office365-Filtering-Correlation-Id: bc6468ec-55e7-4915-14d3-08df3a82f7cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|1800799024|23010399003|366016|6133799003|10067099003|18002099003|22082099003|261102123227099003|56012099006|4143699003|5023799004|261021121427099003|261009223027099003|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: 8YzzRGQ+UB+8zM2jI3BfvJzsYAkravSGp82Tun/6hJWmAXr6+LEFImwa96jSkkj133Q4qFn4yKVXCYhb8QhZLQ3Ynia3gzYHy2KpsTGL0Zk6zl8xMCJtErojhR96ZSUikLSmvjD61HOkdwqskvxTCkZ4n+X3QiJ/mQuFnH8sryKYGIbtSbZXFAFfl0UUK6DrltygspYFhggnFmh6VgX/IFc+teBMVRYGpvCo0vUdGIrNwJibDbSU2XJfZ2+l5vPWvverWRDrfwanYGHJ3v0tp/kdRPiPEypf4SuB9a5RtZbgW6pmLGQxVfdQBiHGRuWYTvC5mNvSbPcw5oceiRPCrsb//ZZ86M2XXK8BrR5l593gOM90VHMwSMnAJ/pcsrEfwqlDhIm83UpZzhOhry0uuXLi0XjeiUoieMBdrTMfYZLXLh781cdATI+U6lF+AeqEfYXl/DfxU6MqYXIvQgQLSGaFuvNS6orNAiCGBfazBKNOuIkN0my4B2imWLBOBK0apy5/HMn+CgUhEsicy01/Ramy5JO1lwre8+82DqEuugpyDprizWCs7ZXDWCHhipU4VdwKbbb+vBLpbiCqZHQDvBfFXpc5tmj16yLYZ3jujLg0sT98Avs7U/C3Ib4VNLC4nzjHMaed4selo6WsOJosZLgNU/AyzDZRKWOC1qfVlT0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(1800799024)(23010399003)(366016)(6133799003)(10067099003)(18002099003)(22082099003)(261102123227099003)(56012099006)(4143699003)(5023799004)(261021121427099003)(261009223027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261021123027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFNmcGI4TGxxRndOMDFoTHROUDhHeXBYR3o3WjE1TGhFak5QbDVKZFc1emhx?=
 =?utf-8?B?aTdjanFHLzc5elp1aDlNTjdmdFd5alJiYXZQVk5EYkYzT2NTdlI4V1pHVDk3?=
 =?utf-8?B?ZVVFMzUrRVRGc3dTSXVLUVkyVEZERzh0NHNmS1F5N0lQQmJGaXJWOG5HZyt3?=
 =?utf-8?B?L0FPY1pXK0Y5Q1lhT3F3N2h4NTZqK2lDT0hXc09COTRCQ2ZJOG5vL3RMOUwr?=
 =?utf-8?B?OHc3aXdtQk1OT0gwVVZ4bVdIYXYwVGJpQ0VUaHhFemtBMlc3TlJuNzYwVGNm?=
 =?utf-8?B?WkFSYkd3Ni8yM0FQRHR2QWZoNy9qaEUvdkZuSkRjSVFrTXhBVGtpVUxhNUli?=
 =?utf-8?B?Q0JXdWx4Uy9vcWJvcWcyZzdlZjdlemc0aG5NVXVXM29OZTdTYXMrNzVNTWRi?=
 =?utf-8?B?QU1XSnIyMktaWjN1aHBLSm9aVjVYZ3llVzVpbDg1aFRUUm9qTTZ4SlJ2N0VG?=
 =?utf-8?B?Tkl0UGNOdU4xNzdpTExweWtWSUhTZUJIbm9DMmtlbkI5WHpQd2RabW1ObS9q?=
 =?utf-8?B?dElWNHdRS1FDNWpaOUgwU29Nai81QXdWc3dJL0UzL3I4dGFyeHJ2K1JKRHgy?=
 =?utf-8?B?NnBSSHZhcmk3T2M1TW1tK1haRWFZSFFNNmpwODBhdUlaSW9VS25kR1BFLzg5?=
 =?utf-8?B?aVc5ZUgxYmkvc0R4R3gyUTdjNWtLT1FJeVY0WGVNMjRSMnRUUDl6QWxZZ1Nz?=
 =?utf-8?B?dk04dTVoNXIyb2p6Z3VhUVJmOEE3N0l1azFONGxyeFFXUWhHb2tqWVpuakww?=
 =?utf-8?B?OElheXdRSUV5Z2FubTlaMnM3VVdQS0VhY3h4cm5yQ2h5QjJhL3hUSGxtM3Mv?=
 =?utf-8?B?NG5pc2FjOEc1MktrSEEvWFZpSC9KUmpKTkd4SXhnZ3dMVUtmMnNHUHBXUWo3?=
 =?utf-8?B?Y2ltOUdUWkNCSXV1dndjUzhkVlpzTThlWTY2SGVHWTU2dHEyYk1EREc0S1hi?=
 =?utf-8?B?NEVMSHphanI1bXJLM1hqc1Y0dVo2dmcrQkxQaUpPRUhJOVNjVytFalRmdlJr?=
 =?utf-8?B?akVoSk9ka1YrVzBMWktJWDJpWTU5R1grWmx1RHJjQ2FOeTlhNVh1d2piVEEx?=
 =?utf-8?B?MVZXNzJTVGh0NU1oQXdBQ1dsVDdTTEhWV3lNTEV6cFRXZDFBSDdXVitsVGps?=
 =?utf-8?B?eU5LWUg3YVZNeVZ6bTJQUTlvZEdKcjMweFd0NG1PTGpITk9RS29LTEVDb1Bk?=
 =?utf-8?B?K2gyaVkwK25LRFhHR2pTQjdDcDZqMmlEV1BCZ3lQajdsWFVmakVoeU1WWWxx?=
 =?utf-8?B?cytnZm1wbGk1Sm5kZ0lqMDhSVlQ3K1ZIbUdmN2MrQk83Q3ZDZjRGcmx4aFpY?=
 =?utf-8?B?ZFpnanlpYWlFSllMYXdiVE56MkhpMmdCY3E1dUZqMWlDVWt6NEppaGpWaWpi?=
 =?utf-8?B?MzlkdVdJQmtxa2NFVmJxR2c4YU15SFNuQ3k1M0VRME5pZUNwU1pSNjQ1aWtI?=
 =?utf-8?B?R290OEMzWmJwMXphMzdXZEJPZWRDZFV6Q0RyNEdQckp1QVhXUVgxZVdVRTQx?=
 =?utf-8?B?YUFCbEkrRTMwZzBhYlMxM0sybkRmbnAvWW11RG1VZUwxamFKeDBqenFxTzAv?=
 =?utf-8?B?emNwSkZiM3lqZzQ4eDZqNy9yUGVOaVloWXVxNDlGQzQyYWd2Y3BMT2ljMXht?=
 =?utf-8?B?eENaaGlsVjc3eDhPOWNxNGxUTkFxR2dOYU5HcDZodC9rMndJcHlqOWxGZUFs?=
 =?utf-8?B?eDVDTTlSOERtdjNHUERXWUhXdFFJYzJJUjZUVkVFR01lVlNqNTkwZVdEcm1y?=
 =?utf-8?B?VGhZVWZ4a1VNcHU1WlByM2h5UXZaLzVZYk5yRXoxeCtmZTZUMmo3aHBINkpG?=
 =?utf-8?B?N09kNis0ZU9IWGZTbUl3STJEMkdxNDdNcUJ6YTNFcE80Syt4SEF3eXFnVVFR?=
 =?utf-8?B?YVVhTmtHME00UlhTOUR4REZSRnJjbkZHQzMxTXdJNWVRZlRubVd1ZlQrVUN5?=
 =?utf-8?B?bXpjanZTUXpDRWVhK3lNL09sZ3drSkE5YVZ3dE1BSlZUZzV6U25yVVVOQkpa?=
 =?utf-8?B?Q1kyM3JMcTE1N2Jvb2Z1VHdTS3ZKck5vWkJZM3Q2R2JDMUJwNGhxc2JNRGNE?=
 =?utf-8?B?WldyVmh0V0JqbmlBRlBJU3h3OFJaL002bUplYlVIKzMwRDBONkZtdjFwM0pE?=
 =?utf-8?B?elJRNnpsY3pKWFBCOStRejF1VThtc2wrYWxmalpvV2hHclJHQmliQWlMU3RE?=
 =?utf-8?B?Vys2SUJhZGhoQm94L3d3Sm82SUVjem5BRnh0cWMyU0hLc3dLK3ovT3dyN09s?=
 =?utf-8?B?Z05VT3RNWTNpSlUwR1FOVGQ3bmx4ZXppeUVNVEdCQmErWXdoTU1xdHRMdVQx?=
 =?utf-8?B?VFlNcW9jMlNzNDFLT0cvMjE4cnh2a0lZaThhME5EL1M4bm1YaEpPREsraVN0?=
 =?utf-8?Q?39LHWLj+dNKJwd+e8vPODbQtaeBZOMF6cfzAzNmLT+J0S?=
X-MS-Exchange-AntiSpam-MessageData-1: rePQms5aRGLJow==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc6468ec-55e7-4915-14d3-08df3a82f7cb
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 14:50:28.8483 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3c42fN5O2BQKCsOXJfs+FxEVVvOSyKMvU1jr/fKw03VrRz/tXfNpp40Yv5Q1h5iv4xAQ2NqScEthc+FWFs4Pqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10694
Received-SPF: pass client-ip=2a01:111:f403:c202::7;
 envelope-from=den@virtuozzo.com;
 helo=GVXPR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 11/3/26 11:02, Kevin Wolf wrote:
> Am 12.08.2026 um 14:14 hat Denis V. Lunev geschrieben:
>> bdrv_replace_child_bs() swaps the node a BdrvChild points to without
>> telling the parent anything about it, so a parent which tracks the size of
>> its child never learns that it changed. Every other way the size of a node
>> changes goes through bdrv_co_truncate(), which does notify.
>>
>> The device models which care all register the same BlockDevOps hook:
>>
>>   virtio-blk  resize_cb = virtio_blk_resize(), ending up in
>>               virtio_notify_config()
>>   ide/ahci    resize_cb = ide_resize_cb(), refreshing the cached size
>>               and the IDENTIFY data
>>   scsi-disk   resize_cb = scsi_disk_resize_cb(), reporting
>>               CAPACITY DATA HAS CHANGED
>>   xen-block   resize_cb = xen_block_resize_cb()
>>
>> Only scsi-disk is really hurt by the missing notification, because it is
>> the one which validates guest requests against a cached size.
>> virtio_blk_sect_range_ok() and ide_sect_range_ok() both call
>> blk_get_geometry() for every request, so a missing notification leaves
>> those guests with a stale idea of the size but never refuses I/O which the
>> node underneath can serve. check_lba_range() compares against
>> SCSIDevice.max_lba, filled in by scsi_disk_reset() and updated only by the
>> READ CAPACITY(10) and (16) handlers, so with nothing to make the guest
>> re-read the capacity every request past the end of the old node is refused
>> for the whole life of the device.
>>
>> This is reachable with qom-set of the 'drive' property, which is allowed
>> on a realized device, and it is silent on the host: out-of-range requests
>> are answered by scsi_check_condition() and never reach
>> scsi_handle_rw_error(), so there is no BLOCK_IO_ERROR event and io-status
>> stays 'ok'. The guest sees ILLEGAL REQUEST / LOGICAL BLOCK ADDRESS OUT OF
>> RANGE, which Linux turns into EREMOTEIO for reads as well as writes.
>>
>> Emit the notification from bdrv_replace_child_bs(), so that every device
>> model gets it through the path it already implements rather than any of
>> them being special cased. Send it only when the size really changed, which
>> keeps the callback out of the common case of a replacement by an equally
>> sized node.
>>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> ---
>>  block.c                      | 13 +++++++++++++
>>  include/block/block_int-io.h |  3 +++
>>  2 files changed, 16 insertions(+)
>>
>> diff --git a/block.c b/block.c
>> index f0a6042e61..1fe66caf8d 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -5524,9 +5524,12 @@ int bdrv_replace_child_bs(BdrvChild *child, BlockDriverState *new_bs,
>>      Transaction *tran = tran_new();
>>      g_autoptr(GSList) refresh_list = NULL;
>>      BlockDriverState *old_bs = child->bs;
>> +    int64_t old_len;
>>  
>>      GLOBAL_STATE_CODE();
>>  
>> +    old_len = bdrv_getlength(old_bs);
>> +
>>      bdrv_ref(old_bs);
>>      bdrv_drained_begin(old_bs);
>>      bdrv_drained_begin(new_bs);
> bdrv_drained_begin() involves nested event loops. Can't old_len become
> stale here? It would feel safer to query it after draining.
I do not think it can. The only caller is blk_replace_bs(), so @child is
the root of a device and old_len is the virtual size the device checks
every request against. blk_check_byte_request() refuses writes past it,
and block_resize is a coroutine QMP command, so it cannot run while the
qom-set one does. Any size change that does happen goes through
bdrv_co_write_req_finish(), which notifies the parents of old_bs, @child
included, on its own.
  
If the size could really move in the middle of a replacement, comparing
it at this point would not make sense in the first place, no matter
whether it is read before or after the drain.

>> @@ -5542,6 +5545,16 @@ int bdrv_replace_child_bs(BdrvChild *child, BlockDriverState *new_bs,
>>      tran_finalize(tran, ret);
>>  
>>      bdrv_graph_wrunlock();
>> +
>> +    /* A parent caching the child size has to learn that it changed */
>> +    if (ret == 0) {
>> +        int64_t new_len = bdrv_getlength(new_bs);
>> +
>> +        if (new_len >= 0 && new_len != old_len) {
>> +            bdrv_parent_cb_resize(new_bs);
> This notifies other parents of the new node as well even though nothing
> changed for them.
>
> Especially since you already query old_len/new_len to avoid unnecessary
> notifications, we should probably call only child->klass->resize(child)
> through a coroutine wrapper here to notify only the BdrvChild that we
> actually changed.
True, but the extra call costs nothing. The resize callback re-reads the
size from the node: virtio-blk sends a config interrupt, scsi-disk
raises CAPACITY DATA HAS CHANGED, and the guest finds the capacity it
already had. A second parent on the new node also needs share-rw on both
devices, so this is rare. A dedicated coroutine wrapper for one call
site does not look worth it to me. If you still prefer it, I will send
the patch. 

Thank you for a review,
    Den

