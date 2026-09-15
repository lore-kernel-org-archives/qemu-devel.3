Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA96C88E77
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 21:03:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6aIv-0003K0-Mz; Tue, 15 Sep 2026 17:03:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x6aH1-0001S0-VC
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 17:01:05 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x6aGz-00011o-Ha
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 17:01:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tKAa6lpRRiN999oD0w+1gO0IAYGE9ZJq37CAm9MU+crGWMooD3U0Wd6cwsZ+Ppzjx2nWwNrqu/Mcthmy5KyHhSJ78bOPrQQcRVd37aq58J/6seVnY7EUQSuxL9vMaAVNjB3wzNFXmRDFNmZKcPQ88WrPDFrz5pckl31ILAuXhWv9MX0o6hHCSxtMaBmhb2xrEmvGODfdjtWLE9XHFo0TNOcoXCn22Sqgw7EWVE7kPd7baL2sOkUemzowHsEWBJpCW/yw7TTUwiyh8BAr8pZ6ogXHFnewjJl60Gq4uOX4UTrPfN+1joo0ZT1b3rj3O/JLFNvCU3vgeyi3r0EAnFuv2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQU73NXq2yU2Z3xrLFgSOiiT0jtJbRbuZNKzwQUluC8=;
 b=qrYXuXy+AyEsRUarL1c+1f/QEc1ldo1KS4jBXnzScfqkmz3vn7I/YeE6MWoPooL9NO9TzUVjW2KKgCZi5MJ+VytXF3i5kvGOw8qx4Bl8W6qRRBPaW0kupLqLY8orohySZ6gX+AVXpFBZduDC/s8Tg4ZwkzmotHkSVcvKIul8ezaMH75WPPcgK1k6t9M6lUPC364N0CXLh95LzEu6C2D0I9UYfIP2Viig+Qf1wg9d7Ckg7QoMTdEi/Tm6HGPyXHm1eqqPZjuOX0RiFfR7wjF6B58FkIHW3pKMj78Er4FtlRZpEnheskbcPFPcNjjuz/2PSILT0RVgt+7HOJnFunqByA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQU73NXq2yU2Z3xrLFgSOiiT0jtJbRbuZNKzwQUluC8=;
 b=PnteW4T4DzZ25x+tCekBwvUF9lLIsGcSbY1oBHESU2ht8IMX2u7+i29TcuCNTb7ZXYZNKZCgcmym0Wga90qmY1m0YSATfeI/B+HNTk96U9Kp0bDdG1bG4K9RMFpShduVBlQq+FDvguBv8jAQNJkh58nMTrqolNVhsLk+9BsEdV+9HP808jyPyy7V7w1cvV6ph8mIQOcfGIqCA4btNDRXRNnTnnyv9JgEtbx0CWhtTa8vitjB847BSsJtxtb4/w2dtQLYFBaELOD6S/r54cE6E1os4TFJQX3Wgt1zb7YHSLfeivQT5w+3U+QnTzMG9/n09dM5Q4lHgWKJykjpqthkJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS8PR08MB8708.eurprd08.prod.outlook.com
 (2603:10a6:20b:562::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.7; Tue, 15 Sep
 2026 21:00:39 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 21:00:38 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Tue, 15 Sep 2026 23:59:50 +0300
Subject: [PATCH v6 14/14] vhost-vsock: hand off device ownership across CPR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-up-vsock-vhost-v5-v6-14-4d31b2dc6afd@virtuozzo.com>
References: <20260915-up-vsock-vhost-v5-v6-0-4d31b2dc6afd@virtuozzo.com>
In-Reply-To: <20260915-up-vsock-vhost-v5-v6-0-4d31b2dc6afd@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: bchaney@akamai.com, mark.kanda@oracle.com, farosas@suse.de, 
 den@openvz.org, clg@redhat.com, sgarzare@redhat.com, 
 philmd@oss.qualcomm.com, maciej.szmigiero@oracle.com, mst@redhat.com, 
 dongli.zhang@oracle.com, peterx@redhat.com, andrey.drobyshev@virtuozzo.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR04CA0053.eurprd04.prod.outlook.com
 (2603:10a6:802:2::24) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS8PR08MB8708:EE_
X-MS-Office365-Filtering-Correlation-Id: d9f9faf1-4309-4022-b14b-08df136c6557
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|7416014|52116014|376014|22082099003|18002099003|38350700014|10067099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: XZ8XdBwV05M3tVSgiL4IYIVrl9FhSEAyshXnCGag8Osx7QEKJWmvfMJvNZhE8nt9NL4hW5ObQ4DjydhEclfZCVocULkZzu7umis8JE8Ek4yvTJVmzvljH4UPGrHjk2M7wK0ZtXDUnVE5Z4JT520QZ4EAXOjq0Soldp+QBV3SksjLE4UBsdsfrAOOYQL3lgDE63PTblcs3XruIbgd1Z6K52BZ9aWvVBwHoIa8NE9/SoThNJiO3Lmfpe1LydHJbqzljgQC0xu3O05k8u0rzLKLSZpw5GrGuUSdjpPIYFZSfXQTlGJEqQz/y8RrJh1a57Rw5vzdQcEzEMounXbg/r/7ffe2fJMZrd5MTvXQQtyUr8ZOkPUNQkX4OVhQtYjMwC+iu6Wl9OqkVzegPTh4fhkn67dFtVupgVcX2yx0jqNCG/RjTwn6RmJRdFtcsXlD9ViJgMmdFQxEe4+PFQMkIExUL9yE2iGgj2WqCpUgHNO8qjnFHqS3qfNmmbGMAse2h9M/CiSxjXhrUNFnz9BbEA/3eNDyx8aO933tcx4sKpVE24qBG1Jjz1+vxNr+WYY0VECcOpp/EM7Ht/QnjEvSYDwvNIVQJMPmEbtp9uGoJOqtGoNIEfW9vnL2PVrzWstYYukm2wlsBPkA1OgZzX6MaNjJLy1sFSxpB0Qg40JaRwKN8+gv+oI2RzUlcWjVL8xhjjpxbcT5LYMPKmrmJ6fcc4SqIz3WwVn9KO2ydl5BM9e9KF8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(52116014)(376014)(22082099003)(18002099003)(38350700014)(10067099003)(56012099006)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUdVS3poVW1tYjBVVHFkTFViWks5V2twYnR6cHNqZjJhR0pYdXpHT29sM2V6?=
 =?utf-8?B?d2IxNE4yanYydEJqTEVwVlZHaG81UDFtODNGaFppb1NEMWVLTDl2eTdHdDN0?=
 =?utf-8?B?WTdyd0pIYWVub2ZBbTZSOHRYZjdRN2lLTmppMmFscm1sd3RLYVpwQzZvSSs4?=
 =?utf-8?B?cDJYYUQ5TEZ0Y3ZRMFd1UDFabzZ5ZFgwRmpTYXBETHNyTnJSVHNnOG1KV0ZF?=
 =?utf-8?B?TnE1S1ZRVjI0YXdIOGFhV3JXYjZXTGt0ZFpVbVRsUmNQVCtFT1dtck1Wak54?=
 =?utf-8?B?TmJDWlRsckRKbi9DazFiZ2J4VkRtWXdVV1Y1Y0QwdDJ6em41ZDN5d3d1eVFq?=
 =?utf-8?B?bkdodkFub1pTRVh2YS80dWVVN2xUUmQ5QnovU3BsT25kaGRjVHBxUUhwMVpS?=
 =?utf-8?B?U3I0eS8vTzZqdi9GbnZNOGJ3MHNEL01nMkt2WFhRT1lMVGxIaHJST3NWMGJT?=
 =?utf-8?B?UWNMcHovcm5kTnVDYXJyR0ljSVZWazBEbmZ6YSt6MjBiUSs5b0drRVZzZk14?=
 =?utf-8?B?MnhZMU5DUWZTVGwzcUdOcGJKNnFDNEVCdTBBSS9jMmUxdmVvb2E2V0RjZDh4?=
 =?utf-8?B?S1VSNXhtdXNod0ZLUTZ4clhLRnFaWlp3Tk9QQThuYzkzV25ER0xBUXQ5NnBN?=
 =?utf-8?B?VzBRcUNWVE1WK2trb3lCZTZMbmlXbHpVdDN1MFI0OXpMOTQ3VlV1SlRrSmZC?=
 =?utf-8?B?d09XenZhdUt5U0ZLK0JucGZsUFVBdTBWeE1UZk8rN1RSdW83Mk5maHRMdURK?=
 =?utf-8?B?MjQ3T3FJNG80dGEra0FNa2VWNjh0ODdQSHU0MXVhL1VSRmtSVEY5MFpiK1Z2?=
 =?utf-8?B?NU56RGJCbnNTS3RtUEw5ZWduMm5RMk52RmJ0cXAwQnRtNytDV2dLY015NEt2?=
 =?utf-8?B?WDFGU2syQWdsR1lwbVMrWEUrSjJpQUwybWc2WVBmcUJoN0JPUC9kNElEOHZK?=
 =?utf-8?B?OFp6MXJ5NUZPcU43QXhXSEVxYjl1WDZTK25Xb3dYODF1SGJXZ1lubnRHNzFF?=
 =?utf-8?B?emUvSk5UQXZWSERldUY5TjRhZE1XbVVxM0g3eFZFVElIUy8rSlhEUjVaOVdF?=
 =?utf-8?B?Ny9RSkx5Q210dmIvNzVDajJNTEgvbTY3OVlWdFJoWVVocjE0QUpmRVlvc3VU?=
 =?utf-8?B?NjI0NU1CZDE4SW5YV0t3VXRvcG5oaU1oa2RFUmlaSlF4dGZkR05FZmw3MjEy?=
 =?utf-8?B?UXNUT0pBVUVIZTQ0b09Ici96SG1qN1RROVpyTEYvNm5JWm82Zm02T05JcWZX?=
 =?utf-8?B?ZGVyd1dIajBBajhqZnZqQ1puVnN1M2tOdFVOQXloTjBFQWhNOFN6eUw5aUls?=
 =?utf-8?B?WmRTWUhXejVraGZpU3pPUjlhb0FPSTloZU1wZHJuNlNIUFhuQUNieHpVREFm?=
 =?utf-8?B?MzlxZXdleVVOZGdXQm5iMGMvM1h1ZGQ5dWMvaVZ5Ty9SSi9vYlRRZU5VOHBx?=
 =?utf-8?B?dmVLNzJpWEpLU1YwNk1iWmIzcWc4MHNJbTViZytqdG5aYlpOWnpWNEdGWXp3?=
 =?utf-8?B?M3g5VjR2ZDRxQVBzRXp5ZVlTK1pTaGYvVFBMRnoxMUpreHdhZ2RrME9sbnFB?=
 =?utf-8?B?c05ta1dVaDAxeWpVUkZMQUlndW9RcUJSUXdNWmNXU1dIRnVnb04vMGFYVDZJ?=
 =?utf-8?B?QUZJUjhKa0piQjdlYzFnMG5GdkttRGFzOUhLelFnTG1pRGQ5RlJMbmRkSmhZ?=
 =?utf-8?B?Wmg4RHJIN0VpTzN0Mm1RenJjdzRrRkhjZ2R2eFZIN2gvc0orMmxXb1dobmlC?=
 =?utf-8?B?SzZ5WnFEVHQ4OWkvNC9OSC9wNFNvYkFvakgyYy9hNjNuRU5LNDZjWFZkMmFL?=
 =?utf-8?B?dEVYWmRxNThEUXlMa1YweENVeGZjSjlkL1ZNb0MvUTF6elYvaHpab1N6S243?=
 =?utf-8?B?cGJBZ2pGT2dRUTJqNUFqOVZNYW50TnhHalRtUXk2WndteTJhUGZZRENIMkFh?=
 =?utf-8?B?aSsrVXVMTjhIRWNseTNCc0ttVk1rM2RWMlN4VDJNSDlnRHlPT1FqRHVyMVha?=
 =?utf-8?B?Y3hFNE0ya1FQM2JrckE5ZGRsNFVZV2UzSVM1UDFKZlh5TWpTazdNaGdHYlBB?=
 =?utf-8?B?MVFqWmdCK0MxL3RKdS9US0ZsODVhb0ZvSURpdTlWYjB5R0VoektlZEtmaDBQ?=
 =?utf-8?B?cE8zU2Y3NjZFR0FpUmNPalNLK2RHWTVmMXMvRnZXTGNEay9DaHpQalM0QTBW?=
 =?utf-8?B?eVQyRUxBdkNEMytXMkczWHRyRTVYYnJVOUh2SGtWTGQ3cW1raHlxUUxUdlpx?=
 =?utf-8?B?VEZWTVAvZ2FjRUN5ZHNJYTFsa1RacWZpaFMyYkxIdVhoWklsNWpmOGgvUFNQ?=
 =?utf-8?B?SGU2S2xFQldTZXlDTCtob01UanF1OEdHMlRNM0dVTWlMb3NnUG9PYmVwOG1K?=
 =?utf-8?Q?YY10lplT0RH8t92U=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9f9faf1-4309-4022-b14b-08df136c6557
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 21:00:38.8536 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uX3HQblCqk/93YQEUeXrCShOlBVZrF8kZ0QXoGJMCGhRF4RL6F8LcxDBxyWcBDZxTj+5sPetVzD6zlfd6FXEIrz/y0YMYf6aqCnydDSjki0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8708
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
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

The previous patches reuse the source vhost FD on the destination,
however both source and target still call vhost_dev_init() (VHOST_SET_OWNER)
in realize().  For cpr-transfer the destination realizes while the source
still owns the shared FD, so its SET_OWNER would fail - ownership has to be
handed over explicitly.

Do this through the device's CPR vmstate hooks.  Namely, release device
ownership in pre_save, reclaim in post_load, re-acquire on restart:

  - .pre_save() releases ownership on the source (VHOST_RESET_OWNER) once
    the VM is stopped, for the FD-preserving CPR modes (cpr-transfer and
    cpr-exec).

  - .realize(), for an incoming CPR, only sets up the virtio device and
    queries the backend features by calling vhost_dev_init_backend().
    It doesn't take device ownership and doesn't touch the VQs which
    still-running source might use.  The full init is deferred to
    .post_load().

  - .post_load() reclaims it on the destination: the full vhost_dev_init()
    (VHOST_SET_OWNER) on the preserved FD, plus sets the guest cid, before
    the device is started at vm_start.

  - .set_status() refuses to start a device whose init hasn't completed
    yet (incoming CPR before post_load).

  - .set_status() re-acquires ownership before starting the device if
    pre_save released it and this QEMU is about to run the guest again:
    the migration failed, or it completed and the management resumed the
    source (e.g. cpr-transfer target died).

With the handoff in place, lift the CPR blocker.

Note: this requires kernel side support of VHOST_RESET_OWNER operation
for vhost-vsock.  Otherwise CPR attempt fails in .pre_save().

Suggested-by: Dongli Zhang <dongli.zhang@oracle.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost-vsock.c         | 162 +++++++++++++++++++++++++++++++++-------
 include/hw/virtio/vhost-vsock.h |   2 +-
 2 files changed, 134 insertions(+), 30 deletions(-)

diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index 34eed2ea997..65ba573da4d 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -21,7 +21,6 @@
 #include "hw/virtio/vhost-vsock.h"
 #include "monitor/monitor.h"
 #include "migration/cpr.h"
-#include "migration/blocker.h"
 #include "migration/misc.h"
 
 static void vhost_vsock_get_config(VirtIODevice *vdev, uint8_t *config)
@@ -85,14 +84,46 @@ static char *vhost_vsock_cpr_name(DeviceState *dev)
 static int vhost_vsock_set_status(VirtIODevice *vdev, uint8_t status)
 {
     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(vdev);
+    VHostVSock *vsock = VHOST_VSOCK(vdev);
     bool should_start = virtio_device_should_start(vdev, status);
     int ret;
 
+    /*
+     * During CPR, on target the full vhost_dev_init() is deferred to
+     * post_load.  Refuse to start a half-initialised device rather than
+     * issue vhost ioctls on it.
+     */
+    if (should_start && !vhost_dev_is_initialized(&vvc->vhost_dev)) {
+        error_report("vhost-vsock: refusing to start, device init incomplete");
+        return 0;
+    }
+
     if (vhost_dev_is_started(&vvc->vhost_dev) == should_start) {
         return 0;
     }
 
     if (should_start) {
+        /*
+         * vsock->owner_reset is only set in .pre_save() on CPR migration
+         * source, after a successful RESET_OWNER op.  If we end up here
+         * with this flag set - that means that either CPR migration failed,
+         * or we got 'cont' cmd from the management (e.g. cpr-transfer
+         * target died).  In either case, we need to re-acquire device
+         * ownership.
+         *
+         * On failure leave the device stopped.  The next start attempt
+         * (guest driver reset, VM stop/cont) retries.
+         */
+        if (vsock->owner_reset) {
+            ret = vhost_dev_set_owner(&vvc->vhost_dev);
+            if (ret < 0) {
+                error_report("vhost-vsock: cannot re-acquire device "
+                             "ownership: %s", strerror(-ret));
+                return 0;
+            }
+            vsock->owner_reset = false;
+        }
+
         ret = vhost_vsock_common_start(vdev);
         if (ret < 0) {
             return 0;
@@ -123,8 +154,44 @@ static uint64_t vhost_vsock_get_features(VirtIODevice *vdev,
     return vhost_vsock_common_get_features(vdev, requested_features, errp);
 }
 
+static int vhost_vsock_pre_save(void *opaque)
+{
+    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(opaque);
+    VHostVSock *vsock = VHOST_VSOCK(opaque);
+    int ret;
+
+    ret = vhost_vsock_common_pre_save(opaque);
+    if (ret) {
+        return ret;
+    }
+
+    /*
+     * Release the device ownership now for CPR migration.  The device is
+     * already stopped at pre_save, and destination reclaims it by calling
+     * VHOST_SET_OWNER in post_load.
+     */
+    if (cpr_incoming_needed(NULL) && migration_is_running() &&
+        !vsock->owner_reset) {
+        ret = vhost_dev_reset_owner(&vvc->vhost_dev);
+        if (ret < 0) {
+            error_report("vhost-vsock: vhost_reset_owner failed: %s",
+                         strerror(-ret));
+            return ret;
+        }
+        vsock->owner_reset = true;
+    }
+
+    return 0;
+}
+
 static int vhost_vsock_post_load(void *opaque, int version_id)
 {
+    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(opaque);
+    VirtIODevice *vdev = VIRTIO_DEVICE(opaque);
+    g_autofree char *cpr_name = vhost_vsock_cpr_name(DEVICE(opaque));
+    Error *local_err = NULL;
+    int vhostfd, ret;
+
     /*
      * Only reset vsock connections for non-CPR migration.  For CPR the
      * guest cid is unchanged, and the cid-change reset would otherwise
@@ -134,6 +201,35 @@ static int vhost_vsock_post_load(void *opaque, int version_id)
         return vhost_vsock_common_post_load(opaque, version_id);
     }
 
+    /*
+     * CPR restore case.  The source released device ownership in its
+     * pre_save.  Complete the handoff here, before the device is started
+     * at vm_start.  Init vhost device on preserved FD, issue
+     * VHOST_SET_OWNER on it, and restore the guest cid.
+     */
+    vhostfd = cpr_find_fd(cpr_name, 0);
+    if (vhostfd < 0) {
+        error_report("vhost-vsock: could not find restored vhost FD");
+        return -1;
+    }
+
+    ret = vhost_dev_init(&vvc->vhost_dev, (void *)(uintptr_t)vhostfd,
+                         VHOST_BACKEND_TYPE_KERNEL, 0, &local_err);
+    if (ret < 0) {
+        error_report_err(local_err);
+        cpr_delete_fd(cpr_name, 0);
+        return ret;
+    }
+
+    ret = vhost_vsock_set_guest_cid(vdev);
+    if (ret < 0) {
+        error_report("vhost-vsock: unable to set guest cid: %s",
+                     strerror(-ret));
+        vhost_dev_cleanup(&vvc->vhost_dev);
+        cpr_delete_fd(cpr_name, 0);
+        return ret;
+    }
+
     return 0;
 }
 
@@ -145,7 +241,7 @@ static const VMStateDescription vmstate_virtio_vhost_vsock = {
         VMSTATE_VIRTIO_DEVICE,
         VMSTATE_END_OF_LIST()
     },
-    .pre_save = vhost_vsock_common_pre_save,
+    .pre_save = vhost_vsock_pre_save,
     .post_load = vhost_vsock_post_load,
 };
 
@@ -171,55 +267,63 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    /*
-     * CPR migration of a vhost-vsock device is not supported yet: the
-     * device ownership is not handed over, so the target fails to set
-     * up its device.  Fail the migration early and gracefully instead.
-     */
-    error_setg(&vsock->migration_blocker,
-               "vhost-vsock: CPR migration is not supported");
-    if (migrate_add_blocker_modes(&vsock->migration_blocker,
-                                  BIT(MIG_MODE_CPR_TRANSFER) |
-                                  BIT(MIG_MODE_CPR_EXEC), errp) < 0) {
-        return;
-    }
-
     if (cpr_incoming) {
         /* Reuse the fd handed over from the source QEMU */
         vhostfd = cpr_find_fd(cpr_name, 0);
         if (vhostfd < 0) {
             error_setg(errp, "vhost-vsock: could not find restored vhost FD");
-            goto err_blocker;
+            return;
         }
     } else if (vsock->conf.vhostfd) {
         vhostfd = monitor_fd_param(monitor_cur(), vsock->conf.vhostfd, errp);
         if (vhostfd == -1) {
             error_prepend(errp, "vhost-vsock: unable to parse vhostfd: ");
-            goto err_blocker;
+            return;
         }
     } else {
         vhostfd = open("/dev/vhost-vsock", O_RDWR);
         if (vhostfd < 0) {
             error_setg_file_open(errp, errno, "/dev/vhost-vsock");
-            goto err_blocker;
+            return;
         }
     }
 
     if (!qemu_set_blocking(vhostfd, false, errp)) {
         close(vhostfd);
-        goto err_blocker;
+        if (cpr_incoming) {
+            cpr_delete_fd(cpr_name, 0);
+        }
+        return;
     }
 
     vhost_vsock_common_realize(vdev);
 
-    ret = vhost_dev_init(&vvc->vhost_dev, (void *)(uintptr_t)vhostfd,
-                         VHOST_BACKEND_TYPE_KERNEL, 0, errp);
-    if (ret < 0) {
+    if (!cpr_incoming) {
+        ret = vhost_dev_init(&vvc->vhost_dev, (void *)(uintptr_t)vhostfd,
+                             VHOST_BACKEND_TYPE_KERNEL, 0, errp);
+        if (ret < 0) {
+            /*
+             * vhostfd is closed by vhost_dev_cleanup, which is called
+             * by vhost_dev_init on initialization error.
+             */
+            goto err_virtio;
+        }
+    } else {
         /*
-         * vhostfd is closed by vhost_dev_cleanup, which is called
-         * by vhost_dev_init on initialization error.
+         * CPR restore case: only learn the backend feature set now, but
+         * defer taking ownership or touching VQs (the still-running source
+         * might be using them).  The full vhost_dev_init()/VHOST_SET_OWNER
+         * is done later in post_load.
          */
-        goto err_virtio;
+        ret = vhost_dev_init_backend(&vvc->vhost_dev,
+                                     (void *)(uintptr_t)vhostfd,
+                                     VHOST_BACKEND_TYPE_KERNEL, errp);
+        if (ret < 0) {
+            /* vhost_dev_init_backend() does not close the fd on error */
+            goto err_vhost_dev;
+        }
+
+        return;
     }
 
     ret = vhost_vsock_set_guest_cid(vdev);
@@ -238,24 +342,24 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
 err_vhost_dev:
     /* vhost_dev_cleanup() closes the vhostfd passed to vhost_dev_init() */
     vhost_dev_cleanup(&vvc->vhost_dev);
+    if (cpr_incoming) {
+        /* The fd came from cpr_find_fd() and is closed now, drop the entry */
+        cpr_delete_fd(cpr_name, 0);
+    }
 err_virtio:
     vhost_vsock_common_unrealize(vdev);
-err_blocker:
-    migrate_del_blocker(&vsock->migration_blocker);
 }
 
 static void vhost_vsock_device_unrealize(DeviceState *dev)
 {
     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
-    VHostVSock *vsock = VHOST_VSOCK(dev);
     g_autofree char *cpr_name = vhost_vsock_cpr_name(dev);
 
     /* This will stop vhost backend if appropriate. */
     vhost_vsock_set_status(vdev, 0);
 
     cpr_delete_fd(cpr_name, 0);
-    migrate_del_blocker(&vsock->migration_blocker);
     vhost_dev_cleanup(&vvc->vhost_dev);
     vhost_vsock_common_unrealize(vdev);
 }
diff --git a/include/hw/virtio/vhost-vsock.h b/include/hw/virtio/vhost-vsock.h
index a964d57e1bc..6e1c39383ef 100644
--- a/include/hw/virtio/vhost-vsock.h
+++ b/include/hw/virtio/vhost-vsock.h
@@ -29,7 +29,7 @@ struct VHostVSock {
     /*< private >*/
     VHostVSockCommon parent;
     VHostVSockConf conf;
-    Error *migration_blocker;   /* CPR migration is not supported */
+    bool owner_reset;           /* CPR released ownership; needs re-acquire */
 
     /*< public >*/
 };

-- 
2.47.1


