Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77549CA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 10:30:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGDHt-0008OW-PU; Mon, 12 Oct 2026 06:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xGDH8-0007dV-9d
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:29:02 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xGDH6-0005Eh-FX
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:28:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BSStoIUXi0WNX11M9ipgQQvfnZCJq5BDzIWi1UW6+mqmzCUbGmObvLpK5Cz45ZlLY9g5o9OGFHjQrb9pGU+zPEP4YDRodwmybNBi6ULBZSfpGN1EZnYWatfeO8O285O1AIOAFltDtcU1KrqnzY9iF9knREz56twiKdC80d1C51A2O4BxaB6pl7uvPNzo8lrhtseqU/+vokBH59vzDf+aZJiMhASjz9Y6/Fnk44m5P7BveuabHPHAYQuFXnXUujGsi4uf+s2x1JOKjB9n3ZkYivvTupdck3lgPkcmPys0Zd1tB0Q6nuNeoAZ7Dcy2mMHjXEbsElmDNTFeQrissdPReA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ExIQu0ecC+MilHqTTHG4T+cwdoW/u9j+e/13UOC8evk=;
 b=lpYzXKwewcADNPttl8YwdkeTU1iWj2jNlF7sdFz+KPITJ0sm7l4xHxZznpNRDc7+X5DruBuyiGfyhcbms3V0w7yOVMnfioSKn/9y9260/H+k856A8LxaF5mDaHmdIcq4Un9qxXMjNo4cfwuEdw9ptDVviJ8cnXDTe78kNfF83MsUeTcAVcS6fq+hB7Bm04JoCZKI0uqwxmNAqsL8EDrBt4itiFPmfsZSkX9ApxGqQzPq5hLmIoRYI+sOhZW5g92hMt6+M+GqRul7RRMdglQ74PJdvzK2Y9UxEzjLgP9azARjvYb7UQzucIdVy5JlaPsD8cYeX6lRBbFjYyRcJcDvew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExIQu0ecC+MilHqTTHG4T+cwdoW/u9j+e/13UOC8evk=;
 b=Gms9gvEBNYPXaMfpjnO1xTFQpCZEESHEJucYk/jklLuMnPBge3upzOG2wdYV5tUaMjpJBCdtfAS1a6d5/zj6K6HxOdKxtXw5+H0xeHcAFcoB+Bo/vRvZw/U44QmZZZOrpS0zCsDaWc9vuV4HLGLq7rY/Cbb7Jplz/ihALeOWGrjL1eu6wsTcMrVeyvm4snH/wSUoOkLrT/zKkYikfoRQGt7B8OY6pnODD3sP1cdIGwcCqcyXqaHK2z0onl30bXiOboI8EXUmQgzpN4SPU50YTS5vikod4b6VEmyC8fcEGuJZ5UUirLBChyIG28cSvrPlj99jgtk3Pc0nicKf6TQzcQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AM0PR08MB5523.eurprd08.prod.outlook.com
 (2603:10a6:208:17f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.11; Mon, 12 Oct
 2026 10:28:39 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0522.008; Mon, 12 Oct 2026
 10:28:39 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Mon, 12 Oct 2026 13:28:18 +0300
Subject: [PATCH v16 10/22] vhost-vsock: preserve vhost FD during CPR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-up-vsock-vhost-v5-v16-10-36c38bd15ffc@virtuozzo.com>
References: <20261012-up-vsock-vhost-v5-v16-0-36c38bd15ffc@virtuozzo.com>
In-Reply-To: <20261012-up-vsock-vhost-v5-v16-0-36c38bd15ffc@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: odaki@rsg.ci.i.u-tokyo.ac.jp, bchaney@akamai.com, mst@redhat.com, 
 maciej.szmigiero@oracle.com, sgarzare@redhat.com, mark.kanda@oracle.com, 
 vsementsov@yandex-team.ru, clg@redhat.com, den@openvz.org, 
 dongli.zhang@oracle.com, farosas@suse.de, andrey.drobyshev@virtuozzo.com, 
 peterx@redhat.com, dwmw2@infradead.org, philmd@oss.qualcomm.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR03CA0043.eurprd03.prod.outlook.com
 (2603:10a6:803:50::14) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AM0PR08MB5523:EE_
X-MS-Office365-Filtering-Correlation-Id: f1e66e11-b491-4c8a-34eb-08df284b94b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|1800799024|23010399003|366016|10067099003|22082099003|18002099003|261009223027099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info: ogFgRIRIaVSZictNS+IgfJfxfNWLZ9Rd4liwI5kQrbeGZzIkMjf99wIXSu3ZE8XGkwAAhx1Cuo86t4t/aifsgFXo45kzssYpMzfgn9k/HC1Rdxv0MOUt9VmB4J3QzJMO3s7UJyZwYbh4vZsIWg7EirxYDuwajJzzPnWRt8q9d2XrrU4h7ydHTFwgDzYzZZAQqD5OaSodz2fXsvqqnZJrMFFlRIYD39wmyhZqc+jsjjaBYP5ntn+1meT8gi+X8HjmzytGQBCxXVk3DRRsrwLVzp7sulhKzu1UoIhiyNElk+XpqCEWtNuqrD2+ewJRRmtEMezE44PXeOsbpWhBPYb51ylQjsQ2pLFo7GVupP4tZcPPFiJr6u5KgIqQYZcftKXj2UFtbnTkdRoBsHSE0GhQ4a2wJMcICS3k3sLr1VpvB2tLK+7P12kRCLJg4NpYq2E0IK/bebVCBzNQ6UfBGjlWDY+aOLjmF2ZpYSq/ioHKzdkBfNHuSLUE9c0pDsw6IYkHClKlCP7wJXYvyMtZ+I2MkbWX48GtuTfngM5LJDJlZgoOYpnlXBAJQEu2526FUa7SZbJLZEtv2Y3V+9uSSmKOuO1+arhygFK2hFULbTKfpp/wEFgcS1FQ5aCJfHgi0FAlHT604ZU6lO9VhTZu/zrwYs7ZHsgR48auNYcYM/HFFKo7UQ+/YPTJtFtntoO6hCNAHabfILX2+kh3aHLdAE3GFfvGB/C/yuVAfXyAAco+nF8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(23010399003)(366016)(10067099003)(22082099003)(18002099003)(261009223027099003)(56012099006)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFJwWEJMQTdLdU5Pc1FLeHhOMm55K2Q5cE9hZVNYUXhWVG9kQzZnTXRXVkgw?=
 =?utf-8?B?THRCd3B5dFEwbjU1S0U4WDNaUUVDbXJiTDdnOGJPZk9wbjBxejRpNzNkU3FS?=
 =?utf-8?B?K3NVQWFUK3owcTMyeEV5dm1hQmZ6aWpGS2ZCSTF4SEo2THdBaTQyMUxJZlJj?=
 =?utf-8?B?YmJYd2pNdEVrMDh1VENHN1ZXNEpiWUtRMytoV0dwVjE1djdxbEhoRHVHK2JF?=
 =?utf-8?B?Sk9UTmtOOEsyQUo3TWduNlUzVnlHbHBlZHBVdm00THVPMFBQK0J6MjhwVzNv?=
 =?utf-8?B?bTBHK0s4cTRpSFZmT3JUcmdpNERiT2IyRmtiNUMrQi9MQ2ZnVC9ZK0VyZ2du?=
 =?utf-8?B?WW9nZEwvRGUxWUlIZHVIUHdsYmRpSkxZQ05UWjZJRDBGc2JRTEdjTnUxNWtC?=
 =?utf-8?B?WDlGWWZZM2laRGZ0MEF3NG5CTzEwNk8vQlYxckJlN0YzRTdoS2RuYjd2anBl?=
 =?utf-8?B?Si9BMTF6VytwZTlPN29VcnRzRlh2dUdlcTRuQ1dvMjl3b1IwT1Z5NDY0N2h0?=
 =?utf-8?B?Yk9uS1lrMis4aDVkcGUxWm5oVk1FUGJaZERyWGdoMTNjelBlVGR3NXJzcFV1?=
 =?utf-8?B?TUpFME5pYzVackJwZXN5TFg3VzRRZCtqVWlNMlU5K29uVS8ycG00SjV1Q254?=
 =?utf-8?B?cFBYSE00R3psVzg3cWp4VGRKQ3JoclM2N2hsdkpQK0g5UnA3LzJoclU5dHFt?=
 =?utf-8?B?RDBLZkRXNjhoWEZkVWpOSTVtNWZjRWg4WGVkZkRTbHVPb1pORkgvZmo0M0pm?=
 =?utf-8?B?ZzB3T3QxVkducS9qY1RaV3g3bmpwL2hMU0Q1elJGTGpJdERYUktCME1rMXRi?=
 =?utf-8?B?Qi9pVkZSNTY2Y1NlTEtEVTRuQ2Nkek9RbWF4cDNOdmdHa2l6Sk9NSnZBWXF2?=
 =?utf-8?B?UXBnL1Zzd2Z6ZFBYWmVsV3Jjc2puQTVvOVlkdlliTldRK3lQL1cySVMreUFU?=
 =?utf-8?B?R1hyNmFrckppaHFqc1FUSjhuQU9lVFRkb2VUSjBmeE5JK1hMVldBN1lnMWEr?=
 =?utf-8?B?NU9rTjhlYkFLTk1QS3ZqN3VqdXJkVDFCQ2pjM09IL25US2lKMEQ4WGxIZHNY?=
 =?utf-8?B?Q25OV1BHZk0weHgyVTFFOG9lZm1qeDdRREp3MDEyTCtwNFFnUmdzeitRc1BH?=
 =?utf-8?B?bmZhWE9QVlh0ZjFUZ0oxa3hPOU1QaDdHWUo1NGt0MDRpaW9YZm00MXdRRmJB?=
 =?utf-8?B?Qzl0dzJiV2grbVlLeVNNS0lkNXBMbnZYMlAzRWM0MlgyZW5IWld0ZTZqRWtR?=
 =?utf-8?B?K3NyVkkzdmpVem1FeFVHVHpmZGhXV3ZpMytrZTVRbmQ4ZjNUS1g0RDAydWhU?=
 =?utf-8?B?alBWVktrVjg4SWgxNnBBeGlkcmxxcTdYc0N4a3RSS3k3NWxLcHFMUHBEVDNL?=
 =?utf-8?B?cTlSM1FENmtvSlQ3TEgrSDJ2WFJ6MThodW1KeDByYUx2V1dvellDN202dmZ6?=
 =?utf-8?B?RjcxVGY4Vm8ybmxIL0MwSmN1OW8wU1AvQ2ZIUHdxRWppVjNzQ0t2dzVaemZD?=
 =?utf-8?B?Z05rZEFxMkVnN3hMMTZFK3RyOG5EM285M01VVEZJTmgwOEZHUk1TdmZRaHZV?=
 =?utf-8?B?SEJOZHdSTEZLQlFqS0Vrcksxd2NGbllpSDIyOVhxMGo5UjQzYXVhYnBONGM2?=
 =?utf-8?B?ZmRNNjBVYmdMSjhzNEJ6L0hmSmtmbUs0dS9mNjFjdnhjci8vTXVTUjFMVHVk?=
 =?utf-8?B?TDVyUkNXeklKSVVmM3V0SjBHWm82RkJjc2xzRkJHY1pnZEFRZ1R3VEkweVV4?=
 =?utf-8?B?SUcrb3g2NXE0YVV5bGhYQktzSTUxUDIzSkpNdzlXNjdNaTJTN1h4VFFPa2Qv?=
 =?utf-8?B?QlEweGNDSTdYR0VvdXhVVTdxS2E4bXRoNi96MjlxTkpTRkxSUHNQMjIxeWQx?=
 =?utf-8?B?MDZOQVVTRDJWM2RmenQxMlpLK0FWUFFiTHpFanZJRSs5MkIvU3JVZXhUWGJa?=
 =?utf-8?B?bVdlRXJRaEY4Z0EwamJqQUpHbnpwNzVqNCtlTk54dk1aT1EwVGN1TDdwSTJV?=
 =?utf-8?B?M2FVbkZPQnBQdGVGR2NVZThVUGhFbmw3bzU1cWZvdWhPT0xzOHJuZDNDejZ0?=
 =?utf-8?B?dkdRV2VWYjVaWURocVNpUURFT3lld1RWOHE0SE1qV0ZtUm5TSkpLclQzNFBk?=
 =?utf-8?B?blhIK3c4UVRjZnp1ckFySWR4R3lGMnJDUEV3TE1XeGllV2lzbExQK1F5SlIw?=
 =?utf-8?B?M0lXeE44QkJIRXVId29rUk1WN0N4RHpFb0xMWmMwVmtoMHZsQXBwSlgvV3dH?=
 =?utf-8?B?clB4WmlHeUR1Mk9CUFNrdTVVRHF4eDU3cmNHTWRlNHZ2U0dFM2RYOEJUL3dB?=
 =?utf-8?B?QWZ4eHh4RXZFK1pnNnlyMkVSbnJEL1J6bStzSVNBQTNvOFNyM0dqTU5BVGdk?=
 =?utf-8?Q?Rm7Ukcz1tcGuzKvY=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1e66e11-b491-4c8a-34eb-08df284b94b9
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 10:28:39.3850 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x18kGIiKg4ZhP1Ehbke3KB/5IilRZkPGS+W3kufSK1jLtrctwnZD5/95NLs2jtVM6hCufcimlwRyMwJMOMcJ4UonsfK0pjDyMp/B1VzHdMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5523
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

During CPR (checkpoint-restore) migration the guest keeps running on the
same host, so instead of reopening /dev/vhost-vsock on the destination,
we should reuse the FD from the source.  The FD is saved in the CPR
namespace (hash table) with cpr_save_fd() and then reclaimed on the
target via cpr_find_fd().

Use the (suffixed) device path as the key in CPR hash table.  Device
path is obtained with qdev_get_dev_path() and is essentially the
device's address on the underlying bus.  As any vhost-vsock device is
attached to a virtio bus, whose .get_dev_path() forwards to the proxy
device, and every proxy bus (PCI, MMIO, CCW) implements it, we should
always be getting a unique non-empty path with qdev_get_dev_path().

vhost_dev_init() (and thus VHOST_SET_OWNER) still runs in realize() here.
Deferring the ownership handoff to pre_save/post_load is done in a
following patch.  Until then CPR remains blocked, so the restore path
added here is not reachable yet.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost-vsock.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index 3ec20d87606..6e89007b2ce 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -69,6 +69,18 @@ static int vhost_vsock_set_running(VirtIODevice *vdev, int start)
     return 0;
 }
 
+/*
+ * Any vhost-vsock device is attached to a virtio bus, whose .get_dev_path()
+ * forwards to the proxy device, and every proxy bus (PCI, MMIO, CCW)
+ * implements it.  Thus qdev_get_dev_path() always returns a non-empty string,
+ * which guarantees us a unique CPR name.
+ */
+static char *vhost_vsock_cpr_name(DeviceState *dev)
+{
+    g_autofree char *path = qdev_get_dev_path(dev);
+    g_assert(path && path[0]);
+    return g_strdup_printf("%s/vhost-vsock", path);
+}
 
 static int vhost_vsock_set_status(VirtIODevice *vdev, uint8_t status)
 {
@@ -143,6 +155,8 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostVSock *vsock = VHOST_VSOCK(dev);
+    g_autofree char *cpr_name = vhost_vsock_cpr_name(dev);
+    bool cpr_incoming = cpr_is_incoming();
     int vhostfd;
     int ret;
 
@@ -170,7 +184,14 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    if (vsock->conf.vhostfd) {
+    if (cpr_incoming) {
+        /* Reuse the fd handed over from the source QEMU */
+        vhostfd = cpr_find_fd(cpr_name, 0);
+        if (vhostfd < 0) {
+            error_setg(errp, "vhost-vsock: could not find restored vhost FD");
+            goto err_blocker;
+        }
+    } else if (vsock->conf.vhostfd) {
         vhostfd = monitor_fd_param(monitor_cur(), vsock->conf.vhostfd, errp);
         if (vhostfd == -1) {
             error_prepend(errp, "vhost-vsock: unable to parse vhostfd: ");
@@ -186,6 +207,9 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
 
     if (!qemu_set_blocking(vhostfd, false, errp)) {
         close(vhostfd);
+        if (cpr_incoming) {
+            cpr_delete_fd(cpr_name, 0);
+        }
         goto err_blocker;
     }
 
@@ -207,11 +231,20 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
         goto err_vhost_dev;
     }
 
+    /* Register the fd for a future CPR after a fully successful realize */
+    if (!cpr_incoming && !cpr_save_fd(cpr_name, 0, vhostfd, errp)) {
+        goto err_vhost_dev;
+    }
+
     return;
 
 err_vhost_dev:
     /* vhost_dev_cleanup() closes the vhostfd passed to vhost_dev_init() */
     vhost_dev_cleanup(&vvc->vhost_dev);
+    if (cpr_incoming) {
+        /* The fd came from cpr_find_fd() and is closed now, drop the entry */
+        cpr_delete_fd(cpr_name, 0);
+    }
 err_virtio:
     vhost_vsock_common_unrealize(vdev);
 err_blocker:
@@ -223,10 +256,12 @@ static void vhost_vsock_device_unrealize(DeviceState *dev)
     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostVSock *vsock = VHOST_VSOCK(dev);
+    g_autofree char *cpr_name = vhost_vsock_cpr_name(dev);
 
     /* This will stop vhost backend if appropriate. */
     vhost_vsock_set_status(vdev, 0);
 
+    cpr_delete_fd(cpr_name, 0);
     migrate_del_blocker(&vsock->migration_blocker);
     vhost_dev_cleanup(&vvc->vhost_dev);
     vhost_vsock_common_unrealize(vdev);

-- 
2.47.1


