Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D31CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 17:26:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBbYm-00069i-47; Tue, 29 Sep 2026 13:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBbYl-00068z-77
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 13:24:07 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBbYj-0002l3-9h
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 13:24:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VPATayOtwEZNhj3qZjPVP1CM+S8rT3jjAMvbafsZzTCsIYwbI0LUFE/a9rrPoVG+KFIrSs0RvtubFT+HQof6z3mt6NsguCUHthnq3nHa2JXIt568de4AC1HXSrVtLcjiQeOslVcdGuvD+SNqCDuEzFBxJO86TDr6sqWsJpuj39NQqFv9owYY1eM27W8UlkTL6ZAaWZ0XQaEtNaEtJl46oh/SjVfwE06kVz/Aoneo9uB+B+T5OlJnKiti9txuUCZ+k4ydnxqtowWyES0obpZ9MioSgFUVFy72O8wEeqzuns3NL0gcNCUZ5JK9+GoCFmt0XnUao8EuVTVLXBSbedmi0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ExIQu0ecC+MilHqTTHG4T+cwdoW/u9j+e/13UOC8evk=;
 b=TbryNgQFmMcvu1gNqqBsFLG9azyf1oZZBXg5UtIENXdNCavaRxdnmk8vOK1CuPKTVAUzQGZlyiN4WKsCDqeh8KM8bDmMrH+V3LEDS+gxB3T/QnZkMjshJyg8XduUlBhAI9cyOXn0WpNcPJ4JVihHLaBWv6O3uOwNnpJI3BPbXtg0TyNl0ogsJ3w39U+DTgB3RuLkFBBkbACYIZV0DNuvl5txI/RDfwQtEaNUVBWjX1qRYvfqu6ovhUyIqBH9x7oENPbsej+3kAknKY08jvhMMIexmsyAN2iFp+TckvNAFGsdqGrjL5T2cKm7+E+F3MGtuDwjaJpv60MUuZQzDDO0mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExIQu0ecC+MilHqTTHG4T+cwdoW/u9j+e/13UOC8evk=;
 b=kiwdX9FYz56hWnxpNJrcpYdjBzO5G+mw2LoOaL20U177UCggtXcE+2DY8vLezaFsgTK4kxPmuXet/g4y0xGyRmKn47yzFfkb42omoYZu+q0TL/Yv5zfM5fH4UZumvHn3AMyfCUdHBL2p0S5jNNWi5UxsgxsweafuZ/LlpYC+eHoZ4zpqM6VIx4lEf2gFCq4e4RFRdJENscIcBHaKECP2+pL5CjWPLPJ14KpjA4mZrOqEiCQF0ewBBUcqaYNjb9PFj0+j1ZOwQXiwiUwC5MoCqDQSvIN60VYhx9UFJEesbez4fMKqkq2Fwl+0b2QLV4TtO0h5YarKfThL15Jo9FudNA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS8PR08MB8801.eurprd08.prod.outlook.com
 (2603:10a6:20b:5bd::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Tue, 29 Sep
 2026 17:23:52 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Tue, 29 Sep 2026
 17:23:52 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Tue, 29 Sep 2026 20:23:29 +0300
Subject: [PATCH v8 10/17] vhost-vsock: preserve vhost FD during CPR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-up-vsock-vhost-v5-v8-10-12bcf1c0b84a@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 248446de-5e5a-4d43-0f53-08df1e4e6e5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|366016|52116014|1800799024|10067099003|56012099006|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: JBdCwrx5oM6lfqEY7kDPinz8/JNexpo8FwQ0L+h/diu/yx1jahpFROthMV3Mtk0qqIY0MChy2uEW8hw1fNDFuN2KOO5f6J9UrW0DHoD1xprCAAoa1vYaNU4BVIQmfJo/Kn8jS/kKOudRbfqzccpGF9uHJYAI6rKVlMF7K9WZcz6n3HfYOd0qRydiQUZVaCUb89Zb++vPzyehXKfJ1O5eFWumXXyGP77hySSTIipzUh4llvR+kLJ6LvWD5Zp+X0rHXzgKaGeusqFOfTOaThrivfhQPndLaoZd1wWpSbRRphxsuSfxEHdJ6fLqSUZdGC0FbRPISTDty+KYKW/sm78Ho/qznqju6AXFLDlNJhSTg5Phe/OpA9Ic1gfj1LAvt1RNbOZ8eKZVkGi0rXwOiXTCQo8bsZ7jkafacOSY5D9GYXFdriCM+P8U/Z2tdCYFFBu0D897QY6aSjlbsub1W2jKVRQXsA2Up7ASY69YgzY1I4BpUhjdtHdKkLOzo57jqOoG7ceM6nwvSttDgzCPfxZLQhzUbjU8eRqZ8RJwCvuol7/7+blR2RX0LVIK3JROzl/cty0olGZG8FF5yX1kw5mr/5lWq+UpYY5vfI7yIOoLuWKxmiWAyx0ek1R98O+uamVKfPo9cvCkLshs31DGxM+iOLFJSME8r9MywJ1ltkSXcD9SZtpwFbSSbmtS7bvVLWjuReW4jwPUXRXo44yvo79xXU7kZqlvhFUyj61ZAOr+SVg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(366016)(52116014)(1800799024)(10067099003)(56012099006)(22082099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHUyUlhQcmhtZFZRcmJ3NG4wa01LSUJXNERTQlBuVVZyd3pPOW1ONGZjTGNq?=
 =?utf-8?B?K0Y2c202N2FGeHhXM05HVGlSRGd5MzhmQ2tieFVVN0l2VlNvSTdGMW1WeHRo?=
 =?utf-8?B?TnNlbHV1TGVvbVV2WWtydGtxRzE0Wk1NRm5hRSsweE5jYUxuK3liWXcvVXZv?=
 =?utf-8?B?NEZEZjRaRDQyYm9qZjU1VWNyK2FFalVkZHdxYUp6YVh1R2VwTW02OGZlU2l2?=
 =?utf-8?B?Vmg1bW5Yc0JWVHZzdXRoZlZOcVB3UThNS3AzdWliZHBGdnNyRzQ0eVRWVFU5?=
 =?utf-8?B?TjB3STNOLzMzdlpHZ2tpR0NVeHBONjVsQXNad2lSNFkraVhLakxVYXBFWFpC?=
 =?utf-8?B?RW1BQ3dlMUZrcXF1bThVQjF5N2VVblgvTUZMMzdJK0Flcy8vc2RBWEdjTDNH?=
 =?utf-8?B?VDZ6SmQxN3pYaUgwaThubjNGdk1HdENKK0dCeXNxSFI2b2kyNThMeGhWZk9m?=
 =?utf-8?B?aU5WNkgwQW5ZRTdEREplazBxVGxYUWNaMGt4enAzaVVsdVdEK3hPWnFxRStH?=
 =?utf-8?B?bW5jSWdrV1FzUURURy93clNKcVNabXpMb0xibmlpWWlrUWp2NVd5U3RPcWxX?=
 =?utf-8?B?enNIQURMWVJ6a0JiU3ZWems0TzIvNVRIOUJLcE9xS1k0NHFWcTBYN3YvSUZv?=
 =?utf-8?B?cWpzRE5ibnBVMGVWcE0zREZZNjM5VkRjOE51Q2dWTkVvNXcyLzltZEd3UDRj?=
 =?utf-8?B?RDFHclVaRnZJTWI0UURYQXdBUTZiMEp1R1ExaTVxWCsrV1hZUE5tZ1NWQkli?=
 =?utf-8?B?WWlFYUg4amQ5aG5UOE43ZlVDRTlSZ24vNDF2SXg2dEJKa25RcmVpYzZCNFpW?=
 =?utf-8?B?MFFsN3RrblNpT0pTOCtDY0owS0Z1NWo0Y3FUaE1RTHJRdzVLTUZLUlB3STdP?=
 =?utf-8?B?dlVQVFp4OVpDWEtQUmx5dXhqb21Xc3E4QWd3Z2VpWW9yT1pXemFLOHFuODNQ?=
 =?utf-8?B?dkd2aUd4elpiYWRBRUZEaml1UnBRcVk3bkdtdEJhTFlvQnl3cFpyc3BYRnpG?=
 =?utf-8?B?UStEWnc4SlhXeHVGREFuMExzS2ZOTVoyNnZzM1BUaEVjRE5DNjVEUCs1RFhW?=
 =?utf-8?B?TVg0RHJoNUVDdEdQU0UwdlEyUzdWV3QxTE56VWtYVXd5VkVSdERBM0hiYlRC?=
 =?utf-8?B?dEU0alIrS2lhSXkrU1pBRXRHYjR2VnRSYlIyNTRMbmY3cDk3ZEV4a0x1RmdR?=
 =?utf-8?B?RUFsNkg0eTd2amEvU29IU2JXenAvTk9lV0RIVWh4Q3ZiYVdLSzN1UUo4SkRz?=
 =?utf-8?B?K1NUbHZ2ZkhFRTRla0RXVVZ3NXVVYVBWaG1iamh4OVc3YSswMytqNW9zTDAz?=
 =?utf-8?B?NVAzZXBTR0ROZ0xFUkg1L2pmVWg0eTZ6WjdLejRibi94MWtHNGtLcFpvQ1pK?=
 =?utf-8?B?S3VsRUZDY1ZkRkxTbVFBQ083YjFVVFMwcUNKbjB2QXRBQ3QxODdhbC9MbGpj?=
 =?utf-8?B?U0tvaTBrQTFaRm5ObGZRK0RsR0Y4QXUxcy9PSm9tWXh1dFRZN2MrcGFpU0VW?=
 =?utf-8?B?a0F5aVo1Qm12MzNFSXhaVDkxZk43U0plNFdyWndjejFQdUl3dEN4TVpIN0gy?=
 =?utf-8?B?OUdOZi9wQ3BINlFWdWk1ei9HYWk5ZGVqV25vc3VaaEE0YnpnYnVkRmNDTDEv?=
 =?utf-8?B?ZkZIelQzWDVCMGRTenJ5Uy9LcktyOU1RWHFRVU1GbTRmVGpITnMwUHlqNCt3?=
 =?utf-8?B?b25tNy9EMWNCTHVaUjJkZUNFTndQZ21wV1MxTzNTSDN0NURzUzlXK1M5dmNp?=
 =?utf-8?B?Vlh4UlY5V1gyRFU5anl0Y1Qwc2dRdTFPSnI1ZFJaVC9oM2RBdk5Sa3IybndN?=
 =?utf-8?B?MldmdHI3TGVoUlhXZzlhWTRvQVJ4eGhhNUlFQ2JWSnFvYlFPd3NSK0Q4RjBq?=
 =?utf-8?B?dzhDUHFSWE5QcWZyUEVXUEM0cFBkT2dhKzZTaURmb0xQTDc2R2lMa1h1RmNB?=
 =?utf-8?B?eC9ZRGFvN1ZJY0tqRDRTeGV2eG96Sk5lL3pNeUxsTnhpWFZQQzArRjBwU3ZL?=
 =?utf-8?B?eXJKbGJwd0R4blFaLzdmMHVOR3ZiUVBlY3FFK3BqSnNiT2hTM2ZzdzM3NTgz?=
 =?utf-8?B?VDU1eVp4b293bGY0YzI3UitvK2FMTG44YjJET3hXN0ZraWVHLzRnWlVzNjl0?=
 =?utf-8?B?M3ZyekpJZVB5RkZHTDNncFArcDdvZVBlU2FEb1E5ODI0OGxLOHRFSFkrQUtj?=
 =?utf-8?B?TGZhczhkRG1WVXFkS2hvY2xnTnVFMUFEM092blpObWRQd3F0N3hncFhGMUlo?=
 =?utf-8?B?aVNaRWJOa2ZPTERIMWdtMDkvbEFuVUVKYkVIaTVKajFHM24zWk0zNWYxUEM5?=
 =?utf-8?B?V3o2U0dwUzJuaDZKazdnclVxY2NXSHErZUlsbjh1enhkNmp4VGU5N3NLVGlh?=
 =?utf-8?Q?76AvDtJT8zUUhmJM=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 248446de-5e5a-4d43-0f53-08df1e4e6e5c
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 17:23:51.8819 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m3NDBOKJwGEt802LoCMOp2xmndLkuH8cdpDBuByKP0mFCj1vvWul/ce1HpIAH5s5vhVyKoXgvr1pq0FPQKeYTQKhkfD7/RlZ6MmGsGXA1Is=
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


