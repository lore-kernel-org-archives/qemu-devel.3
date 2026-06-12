Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 482FFCD98CE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 16:52:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY56f-0001iE-Qx; Fri, 12 Jun 2026 12:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wY56c-0001g2-Q3
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 12:51:42 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wY56a-0000Xb-Jt
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 12:51:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dGXitPQlXl5v1I2lpY7JJODiaFp0OWeFclY3qpzOtvycK5EK7mBer+mMxpfYju2IeqbW3N/ZkvEuRN+WnVKQ9YIiVd2/9ObBCKK5IrxXz34qcm2WnKlpljJsyrUKAcaYoGDtnwD1h2BZxQg9cop16ShBhGV/HigROSP5f+JocTwUU5T/reUOK3lH44mXR0SQjDySrDwY6bjrrBLuliBzWbpeiAU0ww4GR10PmTvRQu6yi1RnHj9XTOC2ELcr6l/zcF2RxTPBb8uwMsG/Kree74I4Rd2q1ufl/0ueqhZ/AjClgyjRWkGjVY6pg1H0vhHsZdFX2trkg+JcHeRE5EECZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1nKMlYtBAaenXuuJ9b1/XUxgMUGf6mS0EN+rHM48jjA=;
 b=p4tOwdch6gz5/ee6cGBGBkAIyRHKcA4Wk6xgzsq5z/da2nW+eP3+Ecb5dXGn2nsK6J+5XDxfrH/Gdu0DVyKUVX/dIiwb63mC+3v+46ykzHxD7b7a1INIOxGdYDLRypRK2kbo6XWFX0jMZWzxC1zdVpaw4vuO1urwflpkGGvFdZxhDpYaiPXaw/gTQ34Rf8ZO1xWWHkJM+yYU/kS9gnptVOycPgT5s/YnG5aeEo8a5S0dIuNt0U0S+mI1YKBBBaBuGVzhWkjxutnGu3AXydqx12WKDZReJAudJCEF9KLg/pEuGlC9qVS6JcC05msS2Qdgv60W+zXplflf2pwLPA8KZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1nKMlYtBAaenXuuJ9b1/XUxgMUGf6mS0EN+rHM48jjA=;
 b=RarrChwfYGPE5fLojavMo0Me9pM4iBPQeH04CscmvLcub17afhdhC68xwXrfJmv2GuZuNsk/uYfcxLLbGboibl+Vm3PqMiw0sMu4MS8k7KiyAOULTAP/c1Y48/+PcCV091ycNDNnERDr3808y0zTS2Vew/ZpTHxsAWDdN24pxe5BUfbFXIV252Zvlrbxl0owkEXkinNeYK7Wz5tIHQxo+kGgJfZCY9NUEQqTM6X5uRTqS6TnPEkTZmrVLo6CEkPn7GN9dGooRA9mY/zojOuiQ0VD0BYw+QvaX5QOBpxh9bQTuCv/dK7K88olEvXY/7187ZAtHRMNEeLJOq9a7yyOTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PAWPR08MB9097.eurprd08.prod.outlook.com
 (2603:10a6:102:330::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Fri, 12 Jun
 2026 16:51:23 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%5]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 16:51:23 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, sgarzare@redhat.com, farosas@suse.de, peterx@redhat.com,
 maciej.szmigiero@oracle.com, bchaney@akamai.com, mark.kanda@oracle.com,
 den@openvz.org, andrey.drobyshev@virtuozzo.com
Subject: [PATCH 4/5] vhost-vsock: preserve vhost FD during CPR
Date: Fri, 12 Jun 2026 19:51:09 +0300
Message-ID: <20260612165110.431376-5-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260612165110.431376-1-andrey.drobyshev@virtuozzo.com>
References: <20260612165110.431376-1-andrey.drobyshev@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0202CA0021.eurprd02.prod.outlook.com
 (2603:10a6:803:14::34) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|PAWPR08MB9097:EE_
X-MS-Office365-Filtering-Correlation-Id: e60b3b1b-bedf-42f2-f95f-08dec8a2d606
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|52116014|1800799024|56012099006|6133799003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: tWgwafHYt7IUDpSDt71pPYrTQ7m6YIriV6/v5jYgCQpeU3+w6vAk6yW/Ocup6n2WKZ7Z6KXI0ZHyZTtUn/UNBaOuPPhE+ygR7W3kLUhY49U3P93vZOLD1CMNgYqVGtHaLwfMJHE/BzZgPSyJY3CefwuHkv/T387nAsP1d8483PZtHECJQMBd3+5PhKbmLphaxwg9ikICTM2J0QT6zrLid9byLd2Rci6snK+NMFBaLrDSA0kH408L3SgbaQS5qxZCA7t4QIYyLRoia9kC5zdnQYreAEIN7YaEzNBS1HuiSsesQZ5F4d4BDwUEZbBnUxFZuW2dacdkbcr5hste6Az9HZMtEPJSmlzMEW7fHKuUOs/XmpgLNqmryPCr4IJPWSBIy6RY9+W6x6ZWs+ZTCBNdrBXJuXkq63TNGopzy8eQHtvWfMNRMqOoeyehZP5/vNpjsHdocdsdPCPlctxxYDoHZD5WjCnpVMhL7S0EKe7SnjwIJkqBgwlGWXm2xlsWYjXyQSnJkOHyoJJhNroWykV5RaPEOtRY9VdtdseR9pUhf0dGcYpfSiTpPwVt7RvposlY3M/h7lt4jGe6uFen391JJp8XDvozj8cfHC5jdN6SA1MRrzsHC2+2yEmzPkz7CLgYETe5iArqTWaGUDlJLO6rsKjlE7BJcZv6jJlJ1FB4BmMuqSqZ2PCfqtGJXGvZvltF27hWzO4VmbBpkjgFTWkWEaWBYDVvCKem46Rhe+5tKhGcgyo0GVJ3LEKF6b1YU1by
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(52116014)(1800799024)(56012099006)(6133799003)(22082099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MVd8hoH5O3dzQ8NeU/7Knb9HnpnzPYRVd+t48DUP92laZwYzcOU9aAOR97EE?=
 =?us-ascii?Q?j+7Ij2wmA3cbyfQ5dFMpQG8YSDMr/lDE6XwPDNQ8Y2C50lskygncTT/JJuIn?=
 =?us-ascii?Q?OAfu4Hm8LISBB2YAPilAEelFf5Xhz1ZM8HZB1fN1F9qgXNTJJkEted24qCvW?=
 =?us-ascii?Q?JGGPFXzNnfpRHLtCN2aaBqatGPsEyXWnYW+OyDCdiYykCOgbQo773f+DpUY4?=
 =?us-ascii?Q?/edCp75ExMITLelHo6RWDg1ZYftLBMFWJu0EIrFgkIJf8FwwwV8VWKrKGeP+?=
 =?us-ascii?Q?o6viX/0VCutzqiajdHnXLZSvIUTQ+Gr1TUbbT4iqOdtWTIzhvZNQWT7cc9L7?=
 =?us-ascii?Q?Id4pIYcHQXJDQ2/mz/ndnPN8Z0qcWD3x6PrHLAbQJRyS6glw0+DGSiagqbpy?=
 =?us-ascii?Q?m3jR9tB7RYAw6SBSIUcd9vjoxPxZ0m6gstPbRx6vnco0UdxsPdN4yOxUx5L4?=
 =?us-ascii?Q?WHUewBRHjt1VPViH7l8Q04V7peQKbu58D3iQwwbUDJ/gw9VXVeu+OtXp9k3R?=
 =?us-ascii?Q?SjH432DlxCUYKK3rIqaNkGz2wKACLqzIRP0rt2CXizfw1zQxJL+MiSLX7kNi?=
 =?us-ascii?Q?TDXLvw65ngMbJSsE7SkM/EiaP+Oxa8BRDkp3wa8p3blPm2Mla2JnspegpDtt?=
 =?us-ascii?Q?7txxvZ3fFZ6oF7g1QYGdwizhrqrCMxcdUZkkFWP8vwJogTQIzsWyAm+BQUbF?=
 =?us-ascii?Q?RFeE53fOYjrG4FUj3v3owkoyY9fHuc19N06TQ4QfCPTLvogi/VLhRGr3y0EN?=
 =?us-ascii?Q?ap9vbwV2ItIPr/TRrmpGRrwTuq68whpAElGcDITwVN8jnnlPS/Pl+5fD6IVJ?=
 =?us-ascii?Q?mW1fR0SPqlIvGtLw4rtTW1BJ7jPGyo+ULh7xQ3hceSqdySsJdXi3e9m0SLHg?=
 =?us-ascii?Q?FrXBCzkYd586JVmaOegzbpI4YQr/sLfrdMJGDIYmZF7encdSlqYQkyGYGHp1?=
 =?us-ascii?Q?KGabl/PzQ5yuEoEUt05iEqBcGBJhPkq+5bsw6KBi/fWk8dEYodKnnc4I5pE2?=
 =?us-ascii?Q?gjeN/T2cBNXlUSNZI6fDXibiyrhIDif/z9sPnwsEASukmClQfKo8U9iSmLiB?=
 =?us-ascii?Q?sCt/12+7wd3Vku3Yadl8qHw8iMS8xQdUVLSmch6Y7NYdVCnoIM0axJUZw1M0?=
 =?us-ascii?Q?TRDgEOKtQbpJAbyWXjN33IcYMrNa0tjSPjGwE4UdL38e7qtzVmTdQHxn4Ko2?=
 =?us-ascii?Q?tXg+cGD1foMQLJaSSCUyXsh64Xr91+q7fiVJyRihMXRs+1erXtRY5EWGnQog?=
 =?us-ascii?Q?q+dRnZcFOtsCM/biQgPgaaSchEblitBZt6cm3Z8MByHugT5oBLEpA5ae43T3?=
 =?us-ascii?Q?NFg+Ru/9TVUxLa1UTW7JvXsK1R06Sn4QSucb621Ez89mcV8kDcuQoyeXnQQT?=
 =?us-ascii?Q?db+1S8FGY4bXDAvNu1Jbr6+q4qimuKn/hdYbxtwapsCqGzrMtZU4P7zh4ncC?=
 =?us-ascii?Q?mN3L/5SFSV+HHBPB+FGF0S5xmoqsJ+3NQAe6RXT8Eo+YCC7kzKccxGxndrBu?=
 =?us-ascii?Q?GHbqe/4PeohCvmeI4AcbMuypmbYnU6jWVJgNu0Z0dXKdgfEkvqJjKSbY02IZ?=
 =?us-ascii?Q?CUtlwlOEjJXcJ80Z04aStXSw5yflwjJ93b2tHKEgTnjPGfjvPBK7eAt4GQJO?=
 =?us-ascii?Q?6UkaUQofKAb/pCuownYvZd1qxT66UmGD4JHAhDGNFuXDSQdOhMXWHhoumImR?=
 =?us-ascii?Q?JU1O0aFnivYcDLxkq4cwgislbLif6lvk5aM/pNxV6ZPvPTlVDaQbiulciIyX?=
 =?us-ascii?Q?jLX8F5WlAfFGUy8m+DhvJf8i2IFZrWA=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e60b3b1b-bedf-42f2-f95f-08dec8a2d606
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 16:51:23.5280 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F5r23BIm2O46H4ONT0orkRQMhTDpJ5YWon4aFp06a7XeJ5H9wiHwi0SlDnWFlH1APF1BkcR1pEr75VPOqT47j/b4z00pmYzuentjy00EUKg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9097
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

During CPR migration, instead of reopening /dev/vhost-vsock device on
each initialization, let's make sure the already open FD is preserved and
properly reused on a subsequent initialization.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost-vsock-pci.c     |  5 -----
 hw/virtio/vhost-vsock.c         | 27 ++++++++++++++++++++++-----
 include/hw/virtio/vhost-vsock.h |  6 ++++++
 3 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/hw/virtio/vhost-vsock-pci.c b/hw/virtio/vhost-vsock-pci.c
index 3a94d06f8c0..ca86a361696 100644
--- a/hw/virtio/vhost-vsock-pci.c
+++ b/hw/virtio/vhost-vsock-pci.c
@@ -28,11 +28,6 @@ typedef struct VHostVSockPCI VHostVSockPCI;
 DECLARE_INSTANCE_CHECKER(VHostVSockPCI, VHOST_VSOCK_PCI,
                          TYPE_VHOST_VSOCK_PCI)
 
-struct VHostVSockPCI {
-    VirtIOPCIProxy parent_obj;
-    VHostVSock vdev;
-};
-
 /* vhost-vsock-pci */
 
 static const Property vhost_vsock_pci_properties[] = {
diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index da244eb1657..90926f95fe1 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -20,6 +20,7 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/virtio/vhost-vsock.h"
 #include "monitor/monitor.h"
+#include "migration/cpr.h"
 
 static void vhost_vsock_get_config(VirtIODevice *vdev, uint8_t *config)
 {
@@ -126,6 +127,8 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostVSock *vsock = VHOST_VSOCK(dev);
+    DeviceState *vsock_pci = DEVICE(container_of(vsock,
+                                    struct VHostVSockPCI, vdev));
     int vhostfd;
     int ret;
 
@@ -141,7 +144,8 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
     }
 
     if (vsock->conf.vhostfd) {
-        vhostfd = monitor_fd_param(monitor_cur(), vsock->conf.vhostfd, errp);
+        vhostfd = cpr_get_fd_param(vsock_pci->id, vsock->conf.vhostfd, 0,
+                                   errp);
         if (vhostfd == -1) {
             error_prepend(errp, "vhost-vsock: unable to parse vhostfd: ");
             return;
@@ -151,10 +155,20 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
             return;
         }
     } else {
-        vhostfd = open("/dev/vhost-vsock", O_RDWR);
-        if (vhostfd < 0) {
-            error_setg_file_open(errp, errno, "/dev/vhost-vsock");
-            return;
+        if (cpr_is_incoming()) {
+            vhostfd = cpr_find_fd(vsock_pci->id, 0);
+            if (vhostfd < 0) {
+                error_setg(errp, "vhost-vsock: could not restore vhost FD "
+                           "for %s", vsock_pci->id);
+                return;
+            }
+        } else {
+            vhostfd = open("/dev/vhost-vsock", O_RDWR);
+            if (vhostfd < 0) {
+                error_setg_file_open(errp, errno, "/dev/vhost-vsock");
+                return;
+            }
+            cpr_save_fd(vsock_pci->id, 0, vhostfd);
         }
 
         if (!qemu_set_blocking(vhostfd, false, errp)) {
@@ -193,10 +207,13 @@ static void vhost_vsock_device_unrealize(DeviceState *dev)
 {
     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    DeviceState *vsock_pci = DEVICE(container_of(VHOST_VSOCK(dev),
+                                    struct VHostVSockPCI, vdev));
 
     /* This will stop vhost backend if appropriate. */
     vhost_vsock_set_status(vdev, 0);
 
+    cpr_delete_fd(vsock_pci->id, 0);
     vhost_dev_cleanup(&vvc->vhost_dev);
     vhost_vsock_common_unrealize(vdev);
 }
diff --git a/include/hw/virtio/vhost-vsock.h b/include/hw/virtio/vhost-vsock.h
index 84f4e727c70..ed91bb837fe 100644
--- a/include/hw/virtio/vhost-vsock.h
+++ b/include/hw/virtio/vhost-vsock.h
@@ -15,6 +15,7 @@
 #define QEMU_VHOST_VSOCK_H
 
 #include "hw/virtio/vhost-vsock-common.h"
+#include "hw/virtio/virtio-pci.h"
 #include "qom/object.h"
 
 #define TYPE_VHOST_VSOCK "vhost-vsock-device"
@@ -33,4 +34,9 @@ struct VHostVSock {
     /*< public >*/
 };
 
+struct VHostVSockPCI {
+    VirtIOPCIProxy parent_obj;
+    VHostVSock vdev;
+};
+
 #endif /* QEMU_VHOST_VSOCK_H */
-- 
2.47.1


