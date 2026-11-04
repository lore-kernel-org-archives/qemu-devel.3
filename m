Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF20E606A328
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 14:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=selector2 header.b=Lbs72ZhJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOc6E-0002HQ-GA; Wed, 04 Nov 2026 09:36:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1xOc6C-0002H9-CH; Wed, 04 Nov 2026 09:36:24 -0500
Received: from mail-swedencentralazon11023121.outbound.protection.outlook.com
 ([52.101.83.121] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1xOc6A-00024R-Ik; Wed, 04 Nov 2026 09:36:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tnkxc28zrjzy/+NwDJFCEBeJ0CqlGbNDQzv+N8UUVxIaK0VRe/zq8yo3J/+C8hxyjTZDA0Ry8Mc2LlBLaVuhntOSD+JexCKfPnKRSYctDDb35VKMkzlGQCvv27PklSpX49BLNCY0GN72l6tJT8Ow0wt+1V2VxCYDM9rD3cpTbZfXK/gNOc98kVTzPpZ4mQNOA7010ZIvh1FrHPcJsTsQSV1d79/j5Uxq3UxE7ZsL7XokET9f1TIkvCLe1LM4tiWoh8FShSc2UsFyT9ALTubuRJU8WegO0xuhIhb+fi95UrXBNGOqlBKCYYxHw1ud6gSyVp2V9gLU8dyUEBjnh6jKcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LnLgWNQY4BnXm4zdLDtxn4s3JowsSI1ogWD8k29YOPs=;
 b=b9jopB0IMlrsDU1y2Zgz+PhmhF/2VCj7cGclrqhJUzCbp6nFoYqdU7tQosn3x6M3OdrPgGBzO0J23i0ETGVcgBlDzkgRSTFkjabIZJ5bVRsOSysbrrHwkSKZp/iRc0xJb010t4IcF8O3iQhwVPBJKRB3sJBXtZClkNAwvPPG2soKhfxtpPhw91KG+xsOZE81hkmDN8I7s+8g6FDoCgfT0mLELDhAfuPO/O3zJmttbSw1ATK8WVSVtCUraaogUWmuVB3lmVIwYbyWa0gJ/7lPoSB/azaeMoAJEP2qY7Zn3wX9sg/xxxXZH7Ydz1h2KXbcDCitgNy3nl7rtbjo/iv42g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LnLgWNQY4BnXm4zdLDtxn4s3JowsSI1ogWD8k29YOPs=;
 b=Lbs72ZhJuCrjxZY+34iPZSQAvk9taqlmaNStkAyNQOBo4oVvlIxUmCstW6QbhO+ql8mNLMORoeHHQxmP4iRPT1OS9DpbFNDGq1hHApHdMJHZWW6/Js/gRQ3wWW+oyOt8gTPCHA6YCxbdvy2nWM5WJKkMhA2zzVGsRNXO3SCiecWtucdzw6fL2u+JJZ11RmCxXZuryuaXMCihvytRsQxscYKaNsACDSPYW3wU5Q3vaMpWbqO0FahCTZsHAOQWESNANpcRjSlTCxm4ZKf/3tfR2lxzCdIeTKkaV8ZjHs1CAYCdlHOPl6sBkkMs2fTNPqA2SGeLnrORhyf1s/h67R7RUg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by AMBPR08MB388037.eurprd08.prod.outlook.com (2603:10a6:20b:78d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 14:31:11 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%5]) with mapi id 15.21.0569.011; Wed, 4 Nov 2026
 14:31:10 +0000
Message-ID: <524d2fd5-a63c-4205-bacd-24915b211a4b@virtuozzo.com>
Date: Wed, 4 Nov 2026 15:31:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] scsi-disk: fix UNMAP and WRITE SAME racing with
 inactivation
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, qemu-stable@nongnu.org
References: <20261026174220.674460-1-den@openvz.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20261026174220.674460-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIYP296CA0001.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:29d::17) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|AMBPR08MB388037:EE_
X-MS-Office365-Filtering-Correlation-Id: fea37137-9ebb-4e2a-cc87-08df3a80458e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|10070799003|376014|261022075727099003|56012099006|261022105027099003|261009223027099003|261028144727099003|261026121527099003|261102123227099003|261021123027099003|261021121427099003|261026140227099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: d0mtK4BveqNjIkZRpquoSjg+nrh27F5w1qj9hVs2AAzFJk4jns6HINu8CG0BmE42OIpZo+7Mv2F8uUI6t7KBs4hlhxQ48vTatTM1+xPcYatZ8gBl1ChEEPiKfUiXcsTo/2rKtti/qtJMS4ioiSI5goXFhvJAEniaCPjKStZZUpQo1Tk58snRHcIHwnRbMr78ae5C5ilNDTypFQG3U0nwu7Bh+k6mMBwdLWRFOLHtuQMxWuo7PqiqISlfq0K0/FLnl7hZSIWRRazvOkDhTBBnsqnDDuzhwL0uUQJGhklDMxnVO21xOWsq2WFrTiD8ecnEq19whep3IPxjVhVWZPLjKOPTJHMpGUk9uMOYkDMmoUPjVHibAzJ3hZc4TPwIVSlgLSd0VVHftBBRZp1SxRGkaSeVT/DvHKS8i7WfZMjpR76sUBaU7v0CX5ihDsT/5XD23MKV8QGt83dw4ube/IBGYm7Qs2ULSmDhrA2oj+73vlIy80Gs1WIYyaRowPp1hcBs/ucN1lC4PDg4Nk3jR1Tdv+V8ZyUfRcS6eyFYeCqBef3IovgRC5duhdPigKdC7jiRSma0WhGZZSYqcxPbFIBdSborbT4FJI0b3guezvuWy1m0HskiroNWAPi5T9N6Jo62
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(10070799003)(376014)(261022075727099003)(56012099006)(261022105027099003)(261009223027099003)(261028144727099003)(261026121527099003)(261102123227099003)(261021123027099003)(261021121427099003)(261026140227099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0plTnVnb0o3anRQRVlmaVBuUmlrZUczNVZVQUZVS1JkMFdVWExBaGJOZSsv?=
 =?utf-8?B?aEUvaEdNYXhpM1ZWSEdDYVA1ZXVRZThwUUZyeUZnQkJzYnphdnVkcFFITENM?=
 =?utf-8?B?dzhjRVpLOXlmMlBOcWljWjBDZi9maUtOb1RkS0d4WGtoUTFaeCtpMTRiUzdX?=
 =?utf-8?B?MGpoT0YvdXFXRFUweWY5RTliNXp3dEJVWlZNSEVQcElUR25VNG81WGNSN2w0?=
 =?utf-8?B?TmFZdm85dGxzdmd1cTlOMnVtR3FaSnFXbHpLVWlGUlhjSFNwajNQbDZCa2R4?=
 =?utf-8?B?Y29ZbE9TTzZrUmI3bzRmQ1NhazdJc2EzSVJhanBWYkxMRVFoMFFucmU3QXdj?=
 =?utf-8?B?NjJYY0NMWDZhMG1IdE16UEVSWUhVZmQxT2YxbjhiYWxKY3dtSjdJelZsNjNI?=
 =?utf-8?B?WjdTZ1VjQTJsZWpSOGQ2WE5nRTlOL2lDMFNwWEpkN05yRXFma0lZKyt0d1J4?=
 =?utf-8?B?SWx1ajZRWVk3aDR5cG9GdDExamo1YWRMZldwZHBjdHZVUis1NGRWSWxQZms2?=
 =?utf-8?B?c1RSMmpNbkxOSC82ZE9UR3N4TjVBZEY0QUlRQUpKaXR6VERqa29sTHlhWlQz?=
 =?utf-8?B?ajFnVWJDNlhGaGJNeVdSQ2FUVkFoZkRZdVVWRkZMejd5d2NBa2QvZ3V6dkFt?=
 =?utf-8?B?aytTZTI1WW53MVlScW5HdDBhRzdmTEJOY2dnakxFcTJYZ21hdWZJK2hjb1N4?=
 =?utf-8?B?RTNyaFdRczBLRm5aVUpyUlpIVkpxSzFUWE1FZi9mUEFXSzNnckxKV2dzbnRZ?=
 =?utf-8?B?S3JrK0dqY1k1b1VlTUowcklxK3ZXYjJMeUw0OFg1NG5xNjNlbGlqUkxqVXVM?=
 =?utf-8?B?Q1VNL0Y5b3BVZFJrdnBTMDBKeC9wcVV1Uk5TR3gxZFU4TXN4emVITzcxVzdw?=
 =?utf-8?B?b1JuRkVwU3A3Vy9LcmsxU1dTbUdyUlUvUHFNYW9zbEJINi9GdmJDVDVuYnVq?=
 =?utf-8?B?SVV4b2pNZ01CTlJsY2diQlg1azJEWER4K24rZER6QXFCRkEyYkNxREI3WUxG?=
 =?utf-8?B?dmhldmtxdElhS0Iyd0pHWW44cDREcGNkVG1lM1FxbWI3R1BvaHYxYWJ1eDQ1?=
 =?utf-8?B?eksxS0ZBN2NKbUJoVnhlc3BFOEVvc2pqU1dEeXBQdWhlTkwrdzRiQXJSekQ0?=
 =?utf-8?B?K0N3MXVVMGZIcEtJck5FZitKRUdWTHFvQm5Sc00zcmhQci9IdUZFbURFV1R4?=
 =?utf-8?B?UUVpWHI4RXQ3bEUyNExaaDQweUJYb2lyQlM5b0lrQ2U5a00xd1QzYUpDN0sz?=
 =?utf-8?B?TGkvUDZTUmE5WkI4ZjVWbCttK0d2WXJaM3VCa0lQR1lqUzhCTUN3U09mSmo1?=
 =?utf-8?B?WVFTS0hJbUM3UU0vVVpjdlNQTlZEQStwd3BNemlCVFJRZzdPTW9QaTROTHFX?=
 =?utf-8?B?MStudzY2dXBDemRoTWMwWVpwbFB1bTE3UytQSDExMlBlS1AyNndHaHo1a2xx?=
 =?utf-8?B?cmFvU3hRWFhDOEd0UjNDb3RMOURsMlY1K3ZrU1NpbjFwZGNPSmdpOUtCNlNZ?=
 =?utf-8?B?S0pMTjZoeDlNbVpuSkIxSEt3bjZKSDJjWGRUdjU2dmVuLzF3RkFvNk5nWmlE?=
 =?utf-8?B?ZGtDTGVUNHltN2F5Q0dUM1I4WEFjcU9pOG55cGZ2ZTFmaVArV200VVd3Q3pW?=
 =?utf-8?B?Q242WU9Kb3k4aC80UmZOTFljTkh3THB5T25wNG03ZTJBcml0aE01TEM0SkNL?=
 =?utf-8?B?M0Y1VXZwa2VZcDQyMzJleU55UHhJdVhHckt3QnlMbFZQb3UvVlZsNGZNaHpE?=
 =?utf-8?B?K3VhM2FONEQvTEt4WndIYnJtMjBaVmM2RE5iUmRqTXJjeDF0MFZmU3lNYnMr?=
 =?utf-8?B?RnJ4UEJ1aVN2dUx2SmRuR0FzdGx5ZU1Wb0dYN3I4UE9sR001TzBqbzdyRXVG?=
 =?utf-8?B?ZjRsOTROSnl2cHFBV2N0eThqdWp4Mm1VbEwxeUtEek4zTGJDUzg1MTJGNTFQ?=
 =?utf-8?B?K0NTaUhuT0VNcmczUEVqd0E3SkRaMmRtWXh2QjU0UmhoZXZhYmRUbTFIdzNU?=
 =?utf-8?B?dGtUSUUvaS9TWkdvVE4wVWZlclZ3bG1GL281UW1jU3pOQmU3cWRqUGlxVUxV?=
 =?utf-8?B?SFlTZHhJaXRpaVhHbDdsQ053NWtEenpkUUozOEdKcEFPQTl6YktNL0hkMHdk?=
 =?utf-8?B?eDBIUnRKUjJtelErcHRuOVdMOWRMSWYxN2xmc3dhbjFiU3ZBTy90OXRmRit2?=
 =?utf-8?B?TEpHZW9RbHFpZHhVdDc0QzJYSzVHZzJJUys0OWhyYk00aHgxaklkZEZYc1ZR?=
 =?utf-8?B?OXR1Q3pzbXNhaStNNU1lRmJmdnMrOTdhdXJZT2Z1RExyeldoS0lLWktwUFFh?=
 =?utf-8?B?SVptdzNsT29FUTIzRFJqK0pCeXQ4dENTMmUxWkllN2VqMThtU040U2RoeVV5?=
 =?utf-8?Q?5Bhrofu5PsoiQGfMW1NqFg4TgZ7Ok1Z1le8tJM3tKFSiS?=
X-MS-Exchange-AntiSpam-MessageData-1: 4StA2Mq/Awt+Hg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fea37137-9ebb-4e2a-cc87-08df3a80458e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 14:31:10.8456 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r92DO5P1FZHXOs5D6n6plk+lsTsMab4JmNTQfZmwmZDpU5KjRcTOGwYUl0vtrpFLJX7VbuGDTZURIaA5Q4K85g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR08MB388037
Received-SPF: pass client-ip=52.101.83.121; envelope-from=den@virtuozzo.com;
 helo=GVXPR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 10/26/26 18:42, Denis V. Lunev wrote:
> This email originated from an IP that might not be authorized by the domain it was sent from.
> Do not click links or open attachments unless it is an email you expected to receive.
> scsi-disk splits UNMAP into one discard per descriptor and a non-zero
> WRITE SAME into 512 KiB writes, submitting each step from the
> completion callback of the previous one. A drain in between only waits
> for the step in flight; the next one is queued by
> blk_wait_while_drained() and resumed by drain_end. When the drain is
> the one in bdrv_inactivate_all() (end of live migration,
> blockdev-set-active), the resumed request hits an inactive node:
>
>   bdrv_co_write_req_prepare: Assertion
>   `!(bs->open_flags & BDRV_O_INACTIVE)' failed.
>
> We hit this in production on a guest UNMAP with 38 descriptors.
>
> The fix follows the one Kevin did for IDE TRIM:
> https://lore.kernel.org/qemu-devel/20260421161132.99878-1-kwolf@redhat.com/
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Hanna Reitz <hreitz@redhat.com>
> Cc: Fabiano Rosas <farosas@suse.de>
> Cc: Laurent Vivier <lvivier@redhat.com>
> Cc: qemu-stable@nongnu.org
>
> Denis V. Lunev (5):
>   scsi-disk: check all UNMAP descriptors before discarding any
>   scsi-disk: fix UNMAP racing with inactivation of block nodes
>   scsi-disk: fix WRITE SAME racing with inactivation of block nodes
>   virtio-scsi-test: split virtio_scsi_do_command() into submit and wait
>   virtio-scsi-test: test UNMAP and WRITE SAME during inactivation
>
>  hw/scsi/scsi-disk.c            | 277 +++++++++++++++++++--------------
>  tests/qtest/virtio-scsi-test.c | 173 ++++++++++++++++----
>  2 files changed, 308 insertions(+), 142 deletions(-)
>
> base-commit: d73149283205645625bfa9fe029cfb68e4c4a9ae
>
ping

