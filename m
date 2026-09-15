Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E369AC88E77
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 21:03:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6aIj-0002on-1n; Tue, 15 Sep 2026 17:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x6aGj-0001Mn-Hd
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 17:00:47 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x6aGf-00010d-SH
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 17:00:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gnzbleKv+VUyDEd1OwrSeidU2iahj0C1VofMWlqqDfvB4mhRlXjWfhksnCVhkGF3hlRxgaqTCBWLm1R2uzyp+UZ70ivM6ADbbwQStWIZBuxDX7q1UX/zYBwKTZ/d1sNcF3wivXe4c9EVJwtmtMwDWWa89cwrfGu0WCa91/GCnGtOQz6D1vl4uQp9RgOg8HFBL/CDjmiRY6arPUiLA7DCDwRbrUFaERiuO7npk6P0T2ZDFa6L6TzlujxvD8CGq/+DNcKedV+BS6GCm3GnkuQGHAPAlFwdZIC5FKWJJJKHQGSlhyg+XYGszwiavBjBrfZJgc5PVseslDx1AsH6qKRF1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HwEYmn5DstVbyfa0cfObfacYY4zXugM4jB0jReZWNmY=;
 b=gomJq4Vu/BokyFRT6qoYhnVd+DpZoEEkxZeC75E1OJSy2JNDXNZ1tL2tUOQCzOqwZiSzX1pM2qSA4KsI90pVkfVopkIEU2S/2AmA8gD4PUGLgjXg5teQ32WreZKZPJ+RFwa1Ig63ZnK+rzW0r/w/F2Ad8c811N3RjJ+DwtET1C35o+BwGTlOTPei0ZrgpUyKs2khpao61ychIpbXk12ZYsRVbbN8sgYzQyYYGdsUHUL0XDUl7RNL0/M5Dtmo99q170H2kAPx0E5J+b/6WPfJM35FRCiidoG1pU4z9Bd/oyjXYB0+AApspE45fwZ9VfQG6iW3os7ghLZ0pbYlBXpkyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwEYmn5DstVbyfa0cfObfacYY4zXugM4jB0jReZWNmY=;
 b=Ms5RzPtQcUF171W60+asT8EMwlpXlToL+hF/O5ELyvBPmazVckCEnjBAfxl5ZmgWjWORrVLJBQnT/aYoy2ZjP3juTaTbAf+82Yv71LOF1RCS6hltA3mBsh/NAdfqPh3l3Th2gWxiO2+lsdqTOWOGMrMjPCvKIhMyVlBb646jPJhMhP0YqtnxX3tz1njqoiNIQixOWjqE4Esc+X0hR3aeRa+/BqhyiMrWr/OokrNsgup6kJuLZmp0RoLDqnBoJ6SqBcOWPAHFb+oLWxud96XvZ3X3SuqCEiWo6bjgZSjUmATDq2ff8E1Sinf977eDrOwRKA00r9p2uOifkMwEwZuETg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS8PR08MB8708.eurprd08.prod.outlook.com
 (2603:10a6:20b:562::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.7; Tue, 15 Sep
 2026 21:00:35 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 21:00:35 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Tue, 15 Sep 2026 23:59:45 +0300
Subject: [PATCH v6 09/14] vhost-vsock: preserve vhost FD during CPR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-up-vsock-vhost-v5-v6-9-4d31b2dc6afd@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 11d057d3-6c97-455e-84dd-08df136c635d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|7416014|52116014|376014|22082099003|18002099003|38350700014|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: GHmKmzxUstZKJIOHKfNrqmyHrvioe/0NZ9c4ygt37GDV5ZtGgj7cx4XHFkGOJwSAe8uXOXjwe0JOj+9wmrWXwX/pjMzOeuBgRW3SGEK5aZyHJHUiqs2L2o0GH8tEgBQoNv/NRs4mEJwxNl7AMK/imUFHaHKWnSpkfr6/obTY9f//tZOLvBet4S0ezPFeoRFCojtyk9NnWyq5R0rPLPEy2FtUcabvD+fXsbX0FrzEXdhQMDT+vpC0Yt+NIwAZYTj207hYzXURsMFB3XTPjEFGxvJjQn/MbRa+iutBboIoXrUKUtdwO//40xSJGeSvsZrlMshRu42FRaVbqpMpbOzPJ+Z/MCNhmq20+ISvZgqheH1lv3p/uwejIPHSZnU6Gaq4Dh2TjRsNORYOFZttO8dh+VkbymMIFJkEqkpcbKY/1EGum99atl+7QABVclG9bif6vB7CbAmJ1NSCR5pbxW3S9qMKHpSNla1kM1bw6FZGsRKVj4/+sUMr1hoEWUyey53X+z7IkZ0xvhn6JZBJa3oFKBYattX5G3XGx0qqsXoJsJp8DyccT64w/QyE3ybsqNKsX+p8ODZf1C7xIdT66D0XVOtDD9R5MSudqQxJkPx2GeERthfLTRUiHnYjgnfJOHv6dRtCvvVQ7dY3iUQP0DOWFPhGWcW97iIKONwcMbZ1k/RXV2dne968nSg1LA1I/NjjWeVp2bt2X9cnnhp3QHmoSB+2AZHLtpTQV1gab5jqzvY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(52116014)(376014)(22082099003)(18002099003)(38350700014)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0lRRkN2UGQrUEJyYnFwQUQySElWMTRld3V1MEpnaVVsWWpnWHZLeHJoSlR2?=
 =?utf-8?B?WXd3NWJqRzJ4dzNzak80VnVwTitpZFNYbmVpblR4bUZBYXFjT1ZnN1R4ckRv?=
 =?utf-8?B?NWxONTBUZmpLUzZrOUZ3WE9rM21aUWF4cXlLSkowNHROOXdFMG45T1FZcVBB?=
 =?utf-8?B?MW1CVVpEOExXVlFhSWs5MU5ZM2R3cDFnbnYzd0hxN1dWc2Q0aHIvRG9LSm9Z?=
 =?utf-8?B?aTNZMWZmZWl0WGFDQ01mbGQzM0dGT09FelhQTFI3Z0JmS2pialhtbFlzREw1?=
 =?utf-8?B?UFNUOXhJZ0tGYjM5UW92aFJIV3ByL2M4N2t2UXNFZTVFMkwwL2Q3NlpzeGI0?=
 =?utf-8?B?WDdMZWorNU1BYjBRT3BiaysvYWVkNGdRSjJsYjJlQkdlNW55SFRmR3RWVWl3?=
 =?utf-8?B?dExhTXFOMWVoODg1RXkyQ3lqdUI3bFpPZFFyY0Y5ajdLWEc2cmx6Ylc1Y0VB?=
 =?utf-8?B?bmJQcm4wUU5sZ2FQSUR2a2FBRmtmN2RlYTM4dll2WENIYUVVZ29ILzVyNHpX?=
 =?utf-8?B?M1RqLzdjTUNUZlNlQTlJNzIvOXRBN0NwQXF6WCtsVDVGZ3dzamVpYnp3eklq?=
 =?utf-8?B?QTUyRE94NThMREc0RVJnSE4vT2JDdG9RUWptaUNiSFlRY1dWK0NQeTloY0Vt?=
 =?utf-8?B?V1VhL1ZVMVR6STBtZ01uWXM4NTZZUEFJZTFQMFZJSWJ3eU5xZGJwdlBaTmhK?=
 =?utf-8?B?Z0JLUkp5K3NIK1J1WWxCTWhCMERmaHBzTWVIVzlZRGFqOHpUeDhUZm9pMlVV?=
 =?utf-8?B?TjNYUHpnUjVPb1Y0RjBZU0krMmJxdHQ1ZDA0SWlrZzdPUm0wZWtMZWkxUXZP?=
 =?utf-8?B?Q1NVUTJXbURYUEZ3Q050YUN6T2lHcnpTdnRyb3BGdU1NQ1JraU9Ud28xTDZZ?=
 =?utf-8?B?RDFOamlIUDFkdUV5amgreFpXaXgyTmhVNXgvNk1FQW9LKzh2NUhsU3VNNU1I?=
 =?utf-8?B?Rm11b2ZGcW5vdENpb2lOM2wxUWRzR3VJc2xmMXZkdXY4Mi92c1JIT3JpMzRl?=
 =?utf-8?B?SHd2c3JzVUJvc3RNajZxYlJPQWM3a1U4R054Q1dtSDFTUzc2UzRmOW4wRENC?=
 =?utf-8?B?VWF1SW03eU5rSDN4ZlkyaEpJeUduaHlaY3pKc21RV0hGc3RSa1ZzUVZTTGRx?=
 =?utf-8?B?S1J2UzdkVzR4dWVYNzVVMm9FOGpWOE9ya2NVVGFzM0Z6NUg5Slo3TVcwakRF?=
 =?utf-8?B?d0tXNmwvZlBHU0xNKzVtN2NxTFVzSE5zWkJSQVE2VWlHcGlSVEg0RG8yMWg3?=
 =?utf-8?B?YVZGVGNOUHRYeFlLdVRzU2NEcGQrL2pXZFhiQ0hHT0hGWnhYdmJzN2NQVnFU?=
 =?utf-8?B?NFVkb3FCYXhOMGhaOFZHY1NqR0QrWmcwSGtPSWJHalVGem9XR1dPVzJLVGk5?=
 =?utf-8?B?dVY1RUFnSVA1c1Z0VDdhL3dOTFgrTThuVHN4V0N6ZWFxMER2M1ZML3BDbStM?=
 =?utf-8?B?YTJyWVRtNFRra2JVbnAwb0Exc0J2Y1Q0dkphMEhRY2p4eStUbmRTQVNJWmpW?=
 =?utf-8?B?SkJRUUlCaDh1WWYzQ1JTQmxFeUF5b0hYZVplQVRFdlVWL0grQWh5ejZGUUVl?=
 =?utf-8?B?Qm5SZTArZXQyWW91VWdiNkhKNGp0UmlPVkIxQ2RiTjRRMlVEL21iMXZjOTNr?=
 =?utf-8?B?SXkrWXh4OVk1NFNtQitCSkhPdkNYMVdYWnN4R2JPeTA0aVpJVW9ieHlReUND?=
 =?utf-8?B?a2N0Y2FLZThZWkpKRXlBYjZ4cDdIZXN4eFFEWWZFODhtUG1mZUh4NGo2blRP?=
 =?utf-8?B?LzRZRkMxZW8yWFBqNForQnlxNk1iSzg0K2Z2L1JxejVhenZzTEdEYWhFRlIr?=
 =?utf-8?B?TWkzelZ4bWtWdDBNdWRuUGJRWE4zSW45aTUzeXgrNHBVblNMSVY0L0F2Rjl3?=
 =?utf-8?B?Y2tVWTZ0Y2ExMENmNk1Cck15bXNISHlyN2VjaGV0aGRkTm9kejZNc3I3dkhB?=
 =?utf-8?B?ZHNybGtMSVhITHZzQ1lVUjhvRFVRbFFtdHltS3hHcGExOXI1MWNFU1IwQTRV?=
 =?utf-8?B?Wjlyb25ENlBKdHFEc0Vtek5pZ24zU0RiQWVKem1zTXNBM0JUSnRnRXpPNWhE?=
 =?utf-8?B?N1FEeXpKN25CQnFhSnp3VHN6dEdEbEd5NmZEaDlCYWNROUxkdkJqaHByNitF?=
 =?utf-8?B?Vno5UTdzbTFQanAxY2dINkpVWFE3dzBFLzlmWXYxZkVHVzJHS3QzbmNmbmYw?=
 =?utf-8?B?QUVyMCtZMUNnekNTZkc3TEx4S21ZYytpTFlWbXNWNVdhbWxiM1c5S2J6SWJE?=
 =?utf-8?B?c1RJOENpVkJvdEx1Y2V6UjBFMjlySWV5b0VvMmNWNk9oYVpBdXJIK3hqdnlP?=
 =?utf-8?B?T2dlK1JiTEJkbUQ3NmFCcWJTN1hKODl0NnY5aWdkOGlKeGhZV3FtSmc1L3ZL?=
 =?utf-8?Q?1Cv/Bgxbd3KIeWeI=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d057d3-6c97-455e-84dd-08df136c635d
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 21:00:35.5497 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mOQ64LXO6noKXxA/ITaHK6C6NnqmLL307gyW109LBIFETTfmkohDIprZ6my2APQ9TcxnKHbaU7iXlnsQvpUFYFMe++6cNgyPEQV/MF/ePe0=
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

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost-vsock.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index 3ec20d87606..34eed2ea997 100644
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
@@ -207,6 +228,11 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
         goto err_vhost_dev;
     }
 
+    /* Register the fd for a future CPR after a fully successful realize */
+    if (!cpr_save_fd(cpr_name, 0, vhostfd, errp)) {
+        goto err_vhost_dev;
+    }
+
     return;
 
 err_vhost_dev:
@@ -223,10 +249,12 @@ static void vhost_vsock_device_unrealize(DeviceState *dev)
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


