Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E8FCA5FA7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 17:24:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBbYc-00064F-8S; Tue, 29 Sep 2026 13:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBbYa-00063n-SH
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 13:23:56 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBbYZ-0002l3-6y
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 13:23:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GHk1uiwVJOnWmICxdGaCMisv7YFmCYZUMubhbWAbTGyrmEZgZByX5qcDF41rMG+iJsDDmckNUnqgFAY23GQC92NbbCamQOI0oJmr8Cjt9uY8iJhCuJNL7eJGPeRnteIqIsZk6hl0sVv7jAhm1ifnwmXEWw5i2uy5WGBxBcgtYSHxBFn42hYNQ7GGtTgvWrdzLIGaIUhNleNyAIEoSFQ76bTnvvVzEQXuvFTCvLAk8+mOsu+7n8hay/HKvEf5BHtJp4lXrloqv0BiYlsozgFHzp2sieSqb3mAQiuB49IKVhLECYQi/nkZyDh+PnFW+t5SeTucECkzaMuA0lbeE9vNxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pI2kEvdyqWo2h3cBz00/awDb1Cv0bW/IrdoDs7geeFM=;
 b=MB868N/xyzWrVMLikflP+4orGG8nsJ2hhCNHgXPbVIIAUVLGofS1qQdYYco5pY04nl7R68ztjOkdqNSy/QTkMaEm/UJDM3frNmfzZ1uFNlicO5O0tguCqtIrf3N3D0Xq1i0X10vfBdh91UK/N53ySzJ1d/P1WA4wZCdhCs7mvT3+gNfamqbX8n52XqiQaCvjDoqEZ5rUPHzkBGBVrHuSFZiA321vwm17I3rS8GwnYZxR0xaMjvlXFUY337nTOhqvWCFKVuoJK54q0r7S06ESlC7I5ep9Gh5D3kzWEMwNZaCNcGcaujG2EiH3nAMvBnJisvgdC+I4PdD7g4wGmZBhlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pI2kEvdyqWo2h3cBz00/awDb1Cv0bW/IrdoDs7geeFM=;
 b=iN0fbP0NNkmuaEjUQlDpXFnXyaI4db4CMbQWEDtwP8v5tjXkRrDufvTxxNi3nsatV78SgdikVchZvYo/swYDK9ki7DH6yzwYr531rVM9cT5o3GdPyvixrwYYZtrZQu2vu2h7db6xpF4OcIXpyYxoXkWo7/Bu+GbiXzjc2raq1l9cR8u3jBCg2sRQNLTlqE4jNJkBJ8AX/aXgszdvNs+ihDlB8vsLnre5vMw3YWnzd5a/IwdmygMf9gAO44XWsVVeVMyhrdMtC8szkXGuwuTw89KARLOcnEf53L2ggZjlrpqJIBd9IbWUfR+US///F3uA1XSQISPHsiGnRn3/tcrclA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS8PR08MB8801.eurprd08.prod.outlook.com
 (2603:10a6:20b:5bd::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Tue, 29 Sep
 2026 17:23:51 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Tue, 29 Sep 2026
 17:23:51 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Tue, 29 Sep 2026 20:23:26 +0300
Subject: [PATCH v8 07/17] vhost: add vhost_reset_owner op
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-up-vsock-vhost-v5-v8-7-12bcf1c0b84a@virtuozzo.com>
References: <20260929-up-vsock-vhost-v5-v8-0-12bcf1c0b84a@virtuozzo.com>
In-Reply-To: <20260929-up-vsock-vhost-v5-v8-0-12bcf1c0b84a@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, maciej.szmigiero@oracle.com, philmd@oss.qualcomm.com, 
 odaki@rsg.ci.i.u-tokyo.ac.jp, clg@redhat.com, den@openvz.org, 
 andrey.drobyshev@virtuozzo.com, mark.kanda@oracle.com, 
 vsementsov@yandex-team.ru, farosas@suse.de, peterx@redhat.com, 
 sgarzare@redhat.com, bchaney@akamai.com, dongli.zhang@oracle.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR04CA0130.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::28) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS8PR08MB8801:EE_
X-MS-Office365-Filtering-Correlation-Id: a0a2b620-ca1b-4111-d643-08df1e4e6d48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|366016|52116014|1800799024|10067099003|56012099006|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: bpSRp/fr9ybHYInICCCQutfuaZbtHslExso1f0MX7KLiPdHfT0sLByOGbKxMV3SLAviZPtjkLmL4rcXPC7S1/YC5mzOm5QYt4M+6G4+2TmGWv+xPbMPKrRHosYnAIDE/g3LPCQEUqVlfn1svpYTX/t9vfvyzG51tLt4vs6uBvwUWrcz9gG6MHyzscqeGZCIhyHj6ffNpz4IE5bTlKHeMLbAxztwfQipPn/b1PgAR+Jxrhhq9mRd3Kw/QcMsWSRuy4K+VPVeP6Zik32s5CQeSDE/0+gEUtwHVOD9zWid5g5clRPKiQNS1lHa/45bOMoSwbAZ6evn3tUysN1rvIzRTRcAeh/fJHrtDdoC9lyfRwh0XpfQScYJYqZwRguVLttarRhnycC+0lIOQpEhm9iWBO2F0R5ODOFxRCa5SwQsEiC/GkBQklH0Z7vU97igMRhZdxlQUvVicIwlc9tTmzVfx7/O5gaS7TGYtGngHIm5wgb6sfDf0zCxKP+wzBRJ/BFX+nfjjN4gsIuU6oxHQ1XpARX+B0Xs+v4z0rLCtqjxhkgtGrNTm7yMSlyteSPUuz9112c5bnKfuDkgijL8e3Wkz7eDLZ6pxdzOSsRd8g5fu+VtpsaacLEKffoojftvTSFTH8lUKy6dzQ8O6Y53tSZq+35Dt0//4VVXhjZqXqGy9zA28FIBLXg81ClSR+y9phE2iGO3zSSqTAURmhyg7rDx7qg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(366016)(52116014)(1800799024)(10067099003)(56012099006)(22082099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVVxYUI0bXVsQkNLUVJiVlVaYnpzQzh3blQyaHM1ZFdTek13QzN0cnRXNzlM?=
 =?utf-8?B?Lzlka0NhdlBMSnY3ZDJKdDhMOWgrR1pRVmphZTg2YlNtZUtKYmc0YjNpOUxx?=
 =?utf-8?B?TUpLUkNEaEFGTGpPdys2TXlTekZzQXhCQjd4dld6Vk00eGRKck04bFZhMk4r?=
 =?utf-8?B?V0xGYWIwNEk4NW9QcTVHbEU5YjRaWHhlZHN6cFRJT0RRQjVWNXlwWUpxai9a?=
 =?utf-8?B?aSszUHREUnhwc2lVQ2paeWNmTDNnS2t2YU1VWlM1cTNIWTZGZVpnbzlPOE9W?=
 =?utf-8?B?Skl5MnlsZ0Y2M0kvaXhUU3lWQXRuMlBDS1BjVldCL0xsUW9mdkFyaTFrdi8y?=
 =?utf-8?B?cXd6TzFnZUZQNEpTS05xZEZ1UFJ3SlNIMDVZditUbHdKeHhtQ2FLTmNTOFlN?=
 =?utf-8?B?UkJTc3VheW0wdXp2OFdiNXgyMzlXTzlrTGR5Uy9zOVBlN2F2emMzSWxqMnZK?=
 =?utf-8?B?UitqalR6Yno0UDgvaml6UlBxSUhMNWdrVHpzU3JGQUlLeHFCYVUwZTY2L3Jq?=
 =?utf-8?B?VnVsNW9Hc1BvM0h3ZjZtK2hBdEVSS2hYOTdoTGZjRmVtcjV2dUNkQkFEKzc1?=
 =?utf-8?B?YXRzOUkwL3I0TTBZMndiOXlxaXZydzlGdjlUWE16TzdnMW5jUnFSSGNFZ2pZ?=
 =?utf-8?B?WkIxZGYrYVFybFR4OXZac0N1d2ljZlNiMUVlSVYzanoyZTVDS0xuVTRVdFJm?=
 =?utf-8?B?bHJ1dU1tNjVpdXd3RTRDRlRGRW5nRlFCY3oxbUx1dHl0K2dDV2pBT3hPbElu?=
 =?utf-8?B?MVBaR0l3TGhHQTlKcE03UjJBOWVlZlpDWUtSQTRsZzBhU0Zsajl0VUltWnVU?=
 =?utf-8?B?S3Qzb2VteWEzZlQyUm85SnJJUTNUT0ZmYmRGT2Jic0FJQm0wZ1VJUVlsUzd2?=
 =?utf-8?B?Q25ITms0aHhQQ1lYbjk1SC9yQkc3N1VSQWh2T2N1Y1AzL3JETFBTeHVwNFAv?=
 =?utf-8?B?cGg3UDRVbVVhUGZ5elBnclBTd0NRc3N5bFFaR1VLUHg2b1Q3L3JNZXhzTTFm?=
 =?utf-8?B?VFJCOTRIcG5rQXZ4ZWxnSlN0Y0RsTTJPNlNQNGsrVEJsV3hPYnVScTdibzk0?=
 =?utf-8?B?NFl5MEFWYlpnQWNETVk5T3NvOERmb3dtSVhMWG4yTEhGbXdvT0xaUjVLdGd5?=
 =?utf-8?B?bi8vRVBFYjJaejRVSExXRlcxWFR5QjV5em5PcVFydW5oUExiQ2xDS0phUHZz?=
 =?utf-8?B?VVlNVTZOUGVaNy9kbVJ1MzNoeWsrMENFOElTNmp1U3Q5bHJVdm41eFc2VVRa?=
 =?utf-8?B?ckFSMGF4c0dWNS94SHhTbHU3NkxNaUZmSnBxYUxVc29TNmdUSWRiNkttZXM5?=
 =?utf-8?B?cGhGZkVTQjQ0QVhVeUpFT2xVaGRYS2pxUmwyRmtKbm9ubUZUZlg1Q1BIcGFF?=
 =?utf-8?B?K2Q1UjN4bS9PZjdtdnFtNnYwQ1U3a1RRYmN3TGJkd2xuK3lPdEVUNXlpWE8r?=
 =?utf-8?B?UTFFTm8yY1FtbGpCWHZQT1Z5YjZOaTRYamNONmpmeWF4RUJIcWM0MjVlZHI0?=
 =?utf-8?B?YVluZk1jeHhmUVRibkMzVGJLWlhrUnpldmdnSTBMUFlzeGp1M2lTU3J2Z1Nm?=
 =?utf-8?B?NUc4L0owUlg3YjRyb21mVGtlSzJJMVJWV2JhK3JralQrMGhDVXJWMWtSZjZ0?=
 =?utf-8?B?eDA1c0pzVWRYVjlPRVdZT3NHWS9DVUdmbm1PK0IxbStTc0k2OFZ1cHh0N2Mr?=
 =?utf-8?B?ZVBpQlo1R3FBWC84R3dCU0Jlc0t5dXNJbkg2eEJyK2M3azZ5MU0rQkFSV01Y?=
 =?utf-8?B?VDFyOG5QUjNyZ081YXBwVisxajhDU1M3cldrQkltMXk5Wmt4djU1SnlabG1k?=
 =?utf-8?B?QTBVMjFSVFA0VElmbm04VGlZaTRiVDdYa3FJQlFIMGZiSXFaWlR4NXQ5YURV?=
 =?utf-8?B?V2tHaG0zTUJOdzdXMVhCR2JvUXp5VXVmQjBsWE1RVzZPZER1cW1hZy80YnUw?=
 =?utf-8?B?bGZRcTRLWkhIalA2K051K1hEb2I1RUg3Q3ZzU3RBVzFwVkFBVUFkOWlDRS9v?=
 =?utf-8?B?eldmMVFUTE5ycklFa2MxNEtKSDZGQW9rbnNPYmN2NVBGbjFrMzhJM3B6TkJF?=
 =?utf-8?B?dUgvd0VUWENPQXJPc2ZHeGVKeFVSUUNLSElrRDNEMXhlbEFSMnRaeFFjak9z?=
 =?utf-8?B?ME5Bcm9rMDNTOWRack41K3loSlZxUDJHUVlWYnZEeWlIYzEzdGJadnd4eDZq?=
 =?utf-8?B?akZGOHRjcHovTERYQVEwYkJEa2swdEJEQm5PL1p2RVExTFByL1pXMndNK3Ja?=
 =?utf-8?B?QUVsWDVlWWFmWFJQUklLeW94REl5V3lEenkyNTgxL01tZzRjZm1lUlFxbld4?=
 =?utf-8?B?ZDY5KzNpNGhIWmNNc1d1NHZHUXA2OGtUQ0FQb2d5T29lT1YxdE9MNjJiTzFF?=
 =?utf-8?Q?RA7LRn12idN6ZefU=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a2b620-ca1b-4111-d643-08df1e4e6d48
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 17:23:50.0558 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JVfA0MoIsdzW1qi8whHp3pyRXOYX+Rx5eFFP6SYsIQ5Z0iafGcyoIHKxPReCakcMhv9NN85D2aH26Bremi3DhxkFzJhJFmFZfcBUrPBo+vQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8801
Received-SPF: pass client-ip=2a01:111:f403:c202::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add a VhostOps callback issuing VHOST_RESET_OWNER, wired up for the kernel
backend.  The CPR (checkpoint-restore) path uses it to release device
ownership on the source so the destination can reclaim it later with
VHOST_SET_OWNER.

Originally-by: Mark Kanda <mark.kanda@oracle.com>
Originally-by: Steve Sistare <steven.sistare@oracle.com>
Originally-by: Ben Chaney <bchaney@akamai.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost-kernel.c          | 6 ++++++
 include/hw/virtio/vhost-backend.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/hw/virtio/vhost-kernel.c b/hw/virtio/vhost-kernel.c
index 3390b48c6f1..55d316b88e9 100644
--- a/hw/virtio/vhost-kernel.c
+++ b/hw/virtio/vhost-kernel.c
@@ -261,6 +261,11 @@ static int vhost_kernel_set_owner(struct vhost_dev *dev)
     return vhost_kernel_call(dev, VHOST_SET_OWNER, NULL);
 }
 
+static int vhost_kernel_reset_owner(struct vhost_dev *dev)
+{
+    return vhost_kernel_call(dev, VHOST_RESET_OWNER, NULL);
+}
+
 static int vhost_kernel_get_vq_index(struct vhost_dev *dev, int idx)
 {
     assert(idx >= dev->vq_index && idx < dev->vq_index + dev->nvqs);
@@ -385,6 +390,7 @@ const VhostOps kernel_ops = {
         .vhost_get_features_ex = vhost_kernel_get_features,
         .vhost_set_backend_cap = vhost_kernel_set_backend_cap,
         .vhost_set_owner = vhost_kernel_set_owner,
+        .vhost_reset_owner = vhost_kernel_reset_owner,
         .vhost_get_vq_index = vhost_kernel_get_vq_index,
         .vhost_vsock_set_guest_cid = vhost_kernel_vsock_set_guest_cid,
         .vhost_vsock_set_running = vhost_kernel_vsock_set_running,
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index daa979a1aae..fb580aa417e 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -104,6 +104,7 @@ typedef int (*vhost_get_features_op)(struct vhost_dev *dev,
                                      uint64_t *features);
 typedef int (*vhost_set_backend_cap_op)(struct vhost_dev *dev);
 typedef int (*vhost_set_owner_op)(struct vhost_dev *dev);
+typedef int (*vhost_reset_owner_op)(struct vhost_dev *dev);
 typedef int (*vhost_reset_device_op)(struct vhost_dev *dev);
 typedef int (*vhost_get_vq_index_op)(struct vhost_dev *dev, int idx);
 typedef int (*vhost_set_vring_enable_op)(struct vhost_dev *dev,
@@ -205,6 +206,7 @@ typedef struct VhostOps {
     vhost_get_features_op vhost_get_features;
     vhost_set_backend_cap_op vhost_set_backend_cap;
     vhost_set_owner_op vhost_set_owner;
+    vhost_reset_owner_op vhost_reset_owner;
     vhost_reset_device_op vhost_reset_device;
     vhost_get_vq_index_op vhost_get_vq_index;
     vhost_set_vring_enable_op vhost_set_vring_enable;

-- 
2.47.1


