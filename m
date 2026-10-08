Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA46CA6007
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 10:26:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xElKZ-0003Ze-VW; Thu, 08 Oct 2026 06:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xElJz-0003GL-Ul
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 06:25:58 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xElJx-0000sa-4k
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 06:25:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gui8evwGMnI20RUS48GEG8hPrSTuXDtYaXLs+gRkE9qJWkRykd2CB7052NzPRUE6mmHsc0b8pU5TJUggiN61eKR38OsxUPvP4d0eCVYnFO9Im7lENu4wZY71No2x6TN3KAeD4d7vujmt4kzFXQO3tgog5+4dU1h53gVjHGDMGViTw6IhQrOqUEuF2VZhUWIjSxZ45HN6wZ0q4s/b05wkRKFjsnBPnTr8P6KivKDPUOCayA+yy1terH+78EDOP9gxoMcDq4/YYz5QY8c7yMVteuT7okW1GA8OKYYygn9nMaZOsTxUNRPgN/Z7DdNO3Q7nB8XUWPVGyVdHVaVVKOiYTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ExIQu0ecC+MilHqTTHG4T+cwdoW/u9j+e/13UOC8evk=;
 b=ZaU/9ypAbtp3BBWO3E1KjLUYjLjKrGtl9O5eedLuxG0BO9Vrg2RCWFxfCUG305EpB3jeirTJAybgWlD1BhCogdlQdP9bE6TfRJiBSvokPU5Hf5Jm0UfFKGoQAJ8BH/2iyaTtpMfBKMNeImEO3G+Kh3SNYGBWY7YIJiHIzgN8iIU6rjUBAv0xyjI9qYhwj6AxoyWLKW5wVOooyggA1CjtGVCPb3hXS9INheKuLTJ3IfrRlEnotrSNLoe2wgY+KH9VeEsjsTBnaVFWLBZ9hx4EGWqTNsyqGg+c6HN28jNQsZ6lcwuoU5bGWOiSdBMHgJxhIYMuFa0iqpwIJ7J83GUQSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExIQu0ecC+MilHqTTHG4T+cwdoW/u9j+e/13UOC8evk=;
 b=d06O0mn0fIOvnK0n0uSZfUIlrvUOgrIsDA4unX2eAMmdwbr5EFehIqTxjS1qot2Q1+msHvyakvpPVpITXELkkg+5n/VTpqz2Xi45w1UVB+vdFepFwFA1rDvGjjZshh86+y+0/TyUpxboQPyxB0knMbqMlhNgWb+XYV04Sz0XvgaTwZ5HO1cl5AfySk1UJljySZJOqVxOu2N/M9cuPhbQNQQVQvEC21RtTBREcpV1kvnRJkAUdrV705xvF0ldyb2i726AiXzcQ1IMTRrsCBYMzUOP4mj64SZNDBndD2jJhcRnFo5TDsoyy485hiQqGafUZPrqz4GWn9YwXdr5GUuEnA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PA6PR08MB10593.eurprd08.prod.outlook.com
 (2603:10a6:102:3c8::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Thu, 8 Oct
 2026 10:25:40 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Thu, 8 Oct 2026
 10:25:40 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Thu, 08 Oct 2026 13:25:34 +0300
Subject: [PATCH v15 10/22] vhost-vsock: preserve vhost FD during CPR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-up-vsock-vhost-v5-v15-10-301b73b3f843@virtuozzo.com>
References: <20261008-up-vsock-vhost-v5-v15-0-301b73b3f843@virtuozzo.com>
In-Reply-To: <20261008-up-vsock-vhost-v5-v15-0-301b73b3f843@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: andrey.drobyshev@virtuozzo.com, sgarzare@redhat.com, bchaney@akamai.com, 
 den@openvz.org, farosas@suse.de, mark.kanda@oracle.com, 
 maciej.szmigiero@oracle.com, dongli.zhang@oracle.com, dwmw2@infradead.org, 
 peterx@redhat.com, philmd@oss.qualcomm.com, vsementsov@yandex-team.ru, 
 odaki@rsg.ci.i.u-tokyo.ac.jp, clg@redhat.com, mst@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR10CA0117.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::46) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|PA6PR08MB10593:EE_
X-MS-Office365-Filtering-Correlation-Id: e40d2566-a732-41b1-4a35-08df25267ff0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|52116014|23010399003|1800799024|10067099003|56012099006|38350700014|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1gQqSJ3ELYELUaI+j4RbkUWzxqgDemhnFP0kOKRDSvC0hcO1/2LP7sH7h7IGnWM9H4wiXEX9nExOzLrNMwN+yR3k8v/nTpYYlT696K3Jd/u5eFqYy1mer0rcy4L2IL1DaUOi6M1aQyUrvSu5B6S+jje0R4KYAv1ddRn/7V+qHqAoG5FdCD03Pc/MbWETTFmzeo3J2kbhmgRCsxfJCmFEHnxfEL2cI4QtmoPPewnhftV9yl2Y11kek5V3PgdO4uNdG4lPD9EorYKI4VjdehCFT+mV8V7548lQ0eTI8c7rvOnA4HZNS4gW5VW9+YvfQHyGjqvMNH/UWsytdltDd9OSwfBbI8SKUf4JeffiemPimcn8yj9Key3jcMdahaLZJiDJWcq4Czb/A+qHdcoYlBHKj/8M0oILkSPGYEY5bRZgJ8mahCHNmF6JJrZKD17iOWx97Q4Zpxg0ve0PuhJUcbWW+KjpnuUBncnZOjAUv3GvgaCL8shoQ1qcQB0XkFfKtIEWT1HNvZaAlGHqTZ5a56OKYDrEo9OtTEc5VgoFmldUFlFMLRkWqKfBYrDsbXZcFmHQ3gunGEcqbJbfbqRoFX2AFoH+2M6LdShu/nE3yFmhlOARlTzM3SqxguAnutRMm3vJnLGmPTH40mLP6nPf6NAqhJOTKYktaZghayBm1AiIt9MXvSF+iSt/dMzlmmvIqvjldtf+h5zAV9qY8l3N4fVCyXzv8UCF/0CIjT9D021Df18=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(52116014)(23010399003)(1800799024)(10067099003)(56012099006)(38350700014)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVk5eTcrd0tjVVBnLzgyQVFSNENZelF4eDF6dWducmMvelRKNDdpbzd4TkZv?=
 =?utf-8?B?VUpUTXQvTnBXNVB2UWs2M2RQRUdhSzQ1OEcyRVB1NFEwazVWUnc1Y3VORTRv?=
 =?utf-8?B?QTlUelpJWEVHOW5JMHpCZUJNWFVlWnc0RGQ3UExFd2o5QUZ2SlhxRWNzaFlM?=
 =?utf-8?B?Z2g0UDhQNTdJTnZRVm1LQlVIUlBoVi9JRDhEZE9PM2RHZERzZi8zOGRaaEhG?=
 =?utf-8?B?KzdFdWxkaE9zaC9BcnpCZkUzVkJrNFRWTWVrbGJDSWo3Sm4vSytLYWVkM2pJ?=
 =?utf-8?B?TVcvVy9pLzF6SGdmaFhseFJLcHdBWDBkRGpzYnVMY1BxMEdMWW1EQTA3OFhT?=
 =?utf-8?B?OTNNTlhBalF4Qk1EaTFOZElnY1dQNGdmSytPOHJDREoxNHBsUkltODZYNFBJ?=
 =?utf-8?B?MHo1dTVMQWxwZkdMWUZnMDRVM3d6eHY3N1BUN3BYMlNTckQrdDNBVnc0QVIw?=
 =?utf-8?B?SWhFV051a3d0YW5DZmRQckFxYm1udmlhWFYzWVZoZkNJRTVySTdXM1lGaERF?=
 =?utf-8?B?blYxQ2Q2RlB4ZlkwUVg1TE5peHlSZi9VU3J5K1J2eGU1bCtjUzM3Tk9BM2Vt?=
 =?utf-8?B?L1F0aW96WTdQQ2ZQbnFWN0pORkxmTHdzaXplTlFaRC9USkVFTHN0eWhWRm5D?=
 =?utf-8?B?bmRCekozSHdzSzNsMXNZRXV4VVF4V0ZHZUVEUzVsdEl3UEl6MS9lNjlvWHRn?=
 =?utf-8?B?dTJKYldwcDFXNG1BWUhYeDJET0p5VjRkdWtyUjZaVHhYVGFRUjhxbTZ4SUVs?=
 =?utf-8?B?aGlPMDJqUng3a29LOWwrdUxIRjNlVkRweUVDUXZ4Q0tMM2xSZ09nNnRsbXZY?=
 =?utf-8?B?bHIrSlErSGhDU1lHZ2NNZ0k4Q1lTazRjK3N2UXRwYVdaVzhxUjRlNW1CQy9n?=
 =?utf-8?B?dmNNVXY3MzZKTFdTeHVudE9QRGdQbUxpT1JVeWd2bnJKanZGdXlibkl0eHZ0?=
 =?utf-8?B?L093cUp0N0NkZllaMzZwcGUzMnFaQzBTbWRyR0FEenB1L2g2Njg4Z3F5K0Uw?=
 =?utf-8?B?K3pCc0pRNFkvTHNmNTUwUDI5QmZEZGdsanpKUjRoNzZmYzhneU5GOCtjdFBV?=
 =?utf-8?B?ZnpqRnJ5amh6SFhleEtTU29FYmI3aG1tczlqai9TNDRNZFdYRks4ZVMxVTMr?=
 =?utf-8?B?bEE5VHdodTlHMU50R25ob29FdHlFSHVXMkNWYUtxeVUzKy84R3BxU1E0K0NY?=
 =?utf-8?B?U29RRmZLaGlnMjA3UytUQTQ3cEpWOWdpdkQ5UTBtOUozclJjZ0RJejlwWGR6?=
 =?utf-8?B?UGpJUWxTbktiTitxSzlIRjlIMUNoZWhFMVJYNUFkeG5tdzhGeDFmb0hFRjYr?=
 =?utf-8?B?ZkJwbzIvTmxDaE8ySHpPNllncFVIb3RhbkdKY1VsQVdDSEhnV0Nxaldnd1BC?=
 =?utf-8?B?K0JvdC9BeHM1WWd3SlJ1R21NQ0NMdG9iRk5XUEVoaXR2S1llWUZmN3UrcW5y?=
 =?utf-8?B?RUJZZlRrUjdEMFdQd1NUSEFqZURzMDVUTFZxcWdoaXVmVUZ0N2l3Mk9aekxN?=
 =?utf-8?B?VkZkcEYwaUp1dFBiTUFPTmU2N1lETnlVWWJ1bDlhQ2pNa3JISjJ2NnNEL0Y2?=
 =?utf-8?B?OE5mcFV1ZGZRdzZ5TmRjVTkyaWEwRUQxSTJaSlZJYjJabnNQVHljZXd2NFhv?=
 =?utf-8?B?T0ZFQ3A3NnVPZi9wQWhJdTFiTWExcVkxTHIvcmVCWHdKUEc0Rk9UeStYRnZo?=
 =?utf-8?B?R3JsK1hhdW5XanpVdjNKODlScXpaeTZheUg0VEthSEVQK1lrbVM4Y0pHdjY5?=
 =?utf-8?B?dVJYM2lYZ1VNbldWSmkrcUUzMTRNUXFlZWkxZFQvYnBvc1RlVHBGM08zekJ1?=
 =?utf-8?B?NkN5c2VPdWNISjlXd3grM214SkxCbWVEUkRVNVdPcllvdDA0ZGdmVkxMV0Mv?=
 =?utf-8?B?M2dnN3FxSVhrMVZ5QzNOT1QzQjB2SjlCTGtnTFlPRVFNT1pnaVJWaEcxNGdZ?=
 =?utf-8?B?QWZFSE92WDNqc3RaVmJ1Q1FpczJmU2hJdmhPRncwZWhiNDVZdE9XcU5pNjBX?=
 =?utf-8?B?Q1ZLTzJxd1U2T1N2OXdsb0tyek5DL0tFbGcydGlobzVEVFdMMExld2JUZG9M?=
 =?utf-8?B?enZXUnRESi9vUVk4cldTWEJJdFZJTVRtcjAvRUpGTVIzUTFKbURFQ3FjZ0tU?=
 =?utf-8?B?ekdOcUlvZmlpWGxUY2tQVWlNU0YybkVzTFJ4OUluczVMczJsdVM3cTJFK3lu?=
 =?utf-8?B?MGlBcVFqaFUxbHBFbXJOaGl3WktLdzRMOSt2OHZrM2ttODlGSFB2RmtuWkNO?=
 =?utf-8?B?emFsUXk5Tm5tei9abTY1Q3JzOWl5NGZ1eVd1SGJBMWNNN2tGQU90d2xuanp0?=
 =?utf-8?B?ZkxjQzF5ckVzenZsS2hxNFZzQnNsZlBsZFJiMlo5T1c1ZW9LT2RTL2lhcGZl?=
 =?utf-8?Q?uMfuMbb1LUfeXgaU=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e40d2566-a732-41b1-4a35-08df25267ff0
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 10:25:39.6337 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dY2KBvNUWqgKCQ6lZQYhayDgssFWbHFmuUVFyXZHUJjzm9lCJWlzkzMkECcTkm1clfgmmujxY0tKY7z4uMHrSae2tcDElANesymvI8Sqgh4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10593
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


