Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA1D4C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 11:41:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx182-00016i-TN; Thu, 20 Aug 2026 07:40:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wx180-00015r-GO
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 07:40:12 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wx17y-0002G4-SI
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 07:40:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iuVpHiD/MgmWT74gizyXrW3U3L9amRmAPgCLOltRsfp0cl40XPGhcAYp2KSzedEvO4ibSiqDNC7jxIWRPwU+uaDz8HoxBt8UJNR4i97kvtpV871p0OBa6nmX3Q2ivd82ZaOG/Yb3LNOtMKnjPdd3Obnf0XMnyKJz9R6m0ko29jYh04qyWoCl6c74CCFsHIXJqImEYrCUmGir4pKBGwLuOfZ/woC+KtUJlsuhv6HXISsqPgVLQPAKm+SlYRosoBDSxbEQow1paD/4XMAC8sn+0P3vZTW1CSSjzBi5b/uSSTLsIfVutUL/EXOkdFx14SLiuFtawefLpapvRvA3is60/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vYmC7sNrXNkqTVZh2OoUnq1ub59oVvPZrx7QwCf1rfw=;
 b=AkAcJXE/g5hwYgpoYgtOFviSCuBOuNrblh8QYr9WErgHIFcPG2cilFpuCkN9r5MgzHqRWqkD5mW5Ql0KZjaMddxXktA/IN6+RL3EzIXT1jAZbLwQTrV/acwcsJqO5S3Gd8oqsK0e+/l03+sjj/z4+QGKhODwUA4K6SDF4kOQqv1/HS8v3O+7jtrTR0GzdLa4GlmDlh24iRMQYf+xbUYm7uW5QlNF01P38p5/S79ekJH4ViXillrHO/IjNwOJbCiwO2xCiS2EWKfj2lPiGh9abRBvmwz9JM3TbA0WxowQX9WBOHCENLYDZBv+6Mk7W3Auri2LzhxQLlz9ntjeJeiCLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYmC7sNrXNkqTVZh2OoUnq1ub59oVvPZrx7QwCf1rfw=;
 b=mBIiqQnbLmUy0rHuphkiM8bTbzkFNVG44HNDCnIjhR87r2q3G+KINPma+NM7FVO+VZaPlMF14GqMVFmyHrT/xALVI43J014e44xzhGhEBa/b7v6jayQd9ivbpp9UZUWkzXCNBz9s9bYNhZRkFcvknd+M6RuDxhys0i24cRXjviHpluXPQd4cviAPLn49TkR04V9va8fEm19BhjYRFzkPqWd8viZ+teODu/LCB464fj5BVpD2Av3L7jjBvRkxIf42JfMBzUOHQc+9XL+qCqu5yYhYniCYr4PPaSOU+KSz99KhN76BIocbtBfzmJFpvDA7z2BHUsvYMxVBYndFqyy16w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by GV2PR08MB8413.eurprd08.prod.outlook.com
 (2603:10a6:150:c3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 11:40:04 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 11:40:04 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, sgarzare@redhat.com, farosas@suse.de, peterx@redhat.com,
 dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com,
 mark.kanda@oracle.com, den@openvz.org, andrey.drobyshev@virtuozzo.com
Subject: [PATCH v4 01/10] vhost-vsock: block CPR migration modes
Date: Thu, 20 Aug 2026 14:39:46 +0300
Message-ID: <20260820113955.509478-2-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260820113955.509478-1-andrey.drobyshev@virtuozzo.com>
References: <20260820113955.509478-1-andrey.drobyshev@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0102.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::31) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|GV2PR08MB8413:EE_
X-MS-Office365-Filtering-Correlation-Id: cfa85aca-7ae9-4e11-ed55-08defeafc696
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|23010399003|1800799024|366016|38350700014|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 2sfe5i0WdM4MCTx4/iFCMygNcAMaiew8ZN3BQWi6Bk4h0b+9Q4URisU4GeLyPFuRSohmrj7CZQEVoXzZFRUCw7C4SKCHKvcEsvNcxI3T4ggRLaqh0G5/xbblFbMGSso1rb3ugjm2XGb7QHrL3Vac+7frMFLNYDh/92GcMd16/XH9yPUp2Hj7dS5eshw1LBVYlEYJH6HB3n+Tbdm9IOi4wM5TUGqdgYZEFxAUlr5F7/E2Frv6UeZTxrsViQI4X/0xtKyzREeLqmJ7WCoh0DFfZlsklz+f8ZEdasOKjiplFnMROn74V284dkRguGiReaMIIhmUFy6DsNP/ubRukdft/ZdBkLepWZuKcvfIKq0/Fr95xTKpH8r9HNNjjZx/n0KBjNa+MElLkqpNswktmpb41JZTzt0YSK8QVAlGGc8RuU3SWQVQKF7FdiaKgMlvzhhRDm9QqMNlyHp79vf0YaUu/7ZYszD/yBepIUH1gQZZ6h0qOYczyKVTmLtz2/VjoYXkSjZPNukBHRHd1IwKPoUDOxFVXbIrFyXoxvNACLnTvlRQ99pbdJvsb4Q0qjjbbH1ESzXWJWPyyVdx+zF03jHh8AaiaeuxxFNe06AvyKLSRHWhcbkePufnnxIlnjwo90Bsyxon621cK5uXwjC1SVuIuCNreGaO7sIzuVq37GqPM+M9NfeTtNCbhvXfShgpWwT/2K6PPfGmCFxRUYEtjxmDs2s3RKPQ5qJwk4bojwwpWpM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(23010399003)(1800799024)(366016)(38350700014)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SDM8WXu6cOXmb5Ew0EFc/Q4QUZymDxuai6YZD+sheua1FOnzSSL8HsyvkB7c?=
 =?us-ascii?Q?X6tnH6N5dswArOnFVf+1/xvUljSQI7qm06ZHhVeLjxXqMP+NzHk0dr/uujkc?=
 =?us-ascii?Q?U62S5mFUDk2G4WGyQSGEI/OPoKWFM4IFtOPZbGo1STOU72LH1rSR6Yv09tzr?=
 =?us-ascii?Q?uBshQgNbtRY3CuLTGV7avH26RRRGuR6qrEzw3dXeR/8QLnGnMVEjJSDC/hnr?=
 =?us-ascii?Q?rNXqyuHXVkDdmXvpg0MvCw8NsWH+/XB2mVenf9tOgGHhaCY8H0LuqhFMMSQ+?=
 =?us-ascii?Q?8yXwQciXleG0si4l86NJrObG9QpVhwmqHPDQPBYQzu1abbPmzyMv6nGkO33G?=
 =?us-ascii?Q?3iOV3xLsRRzi5vKZv9iPOI3Ih+hEPktTnTw+WnB2wvCjrKhgFwMJMSwwLDiZ?=
 =?us-ascii?Q?LOVozUdlFyaLVMQH/F3MBgtkB8f8koy8O3ri3gJ3dJdPA8ENqQ//PXRVeh/O?=
 =?us-ascii?Q?BxpnAnn0aJHQ25wNdcB6S+Wo8uOKO6N/QHC9z9HmAShApHzJ3/a5u3V+YEb5?=
 =?us-ascii?Q?j2IqaV/j72MFO4z6dUyNeTJcq29EqYDiAwCLnGOKYZ2vPUT8sURIGUGQnOiu?=
 =?us-ascii?Q?h+cnRAK24Do7tbY9jhW5xJ3u0p7xXx+jaGXXnTqR8gHB50i7DGr3ZsAnK1+x?=
 =?us-ascii?Q?EBVULF6MGZEFFrg3KkSp6oWf45XDQfWG8lcvFc0TKmcBSuXo0Bywt7fSDwKP?=
 =?us-ascii?Q?deksj+a4jG0K/DEb9mh821GYz69TCHyA/bnu7OoATLq8ChbD3VbAJaLH6d2y?=
 =?us-ascii?Q?2dxI9iSGgRCt57RbygLeCsoSpiLHRnQAvbI4+ENIc7wSSEBcMoUxQE35tlHu?=
 =?us-ascii?Q?6IYWm0p2AFjOC73f5w9CPnPuRw07ZXruoy+f7lWEd33NXaYkn0sqs+cHCEb7?=
 =?us-ascii?Q?xGiF8r8zDaZGm43soyWqHEn0rpTDlnvh3sumW+lhzjw3KoSWsrRlh3Vizl7t?=
 =?us-ascii?Q?Q11+bUmdShJSTrJzaEexHSqidehpbUyKzJ8zz1/7L5IQSA9j50ZxSKYgmt9P?=
 =?us-ascii?Q?oQYwn5xYqqik/3WZuGxV94z5Ar9NFIQg5YlrdaxAF3JxBTAQs93jxtyZDq1K?=
 =?us-ascii?Q?oV/dTich5yjCfnSTrYFg62CRIg1Wf9p/ar4QizdDJESXCzAEMll9FSH4EFgG?=
 =?us-ascii?Q?SX9aOwXTiV2PvfCDGzGKd+y3ZsFDrWohFaMRKdxysyywr1bWue3XzGk3mSZT?=
 =?us-ascii?Q?Qccpe0U8ZIXslzuHqEvyRYdwqk1T/GY3BPO4BJEKzJOzyURgSaYjXpQaAYc0?=
 =?us-ascii?Q?mc83HJ3zE6kz0dr0Fot8p41UJiUgNcrpA7f1xmuwNvxizGBZZjQqtFOEFjcJ?=
 =?us-ascii?Q?jZAgZbF12HUJ84+/WXr3KwBLKZrH0LnVHBt3sRpELTPjlHQ1XfKlawwpROyN?=
 =?us-ascii?Q?cMq5xexDKE9Qs8XqJo9D7p64zIYncR9azagmR4pKBilJD6Iod64h3YVKqon4?=
 =?us-ascii?Q?6tW9qjRYtXpS50jPjhT9XsjoEhCP3s/jpNGjyz3ZBoAOQjSbcgw0Rl56NX82?=
 =?us-ascii?Q?NRZBPccj0gMVOQsAEymCWWw8u0h/0t1FGSvYKPsPGfSRFaDQbPoEhq6ueo9p?=
 =?us-ascii?Q?GWoyq0J52BuFVpqH9WtjKIJNmM1gzB5zHR/9nRwOWQ3uKbIKZFmIS5rj64Y5?=
 =?us-ascii?Q?baVLHVR18v8r27iVSo9tkKO0erlSX5AGhPddraI0eGxJAWuSwBa8Psb2DSTT?=
 =?us-ascii?Q?gXiEDP1TqOBkbNsmQO0K83tebCI0W5BonYtdIu3xJDGUFwcIauc8m3T/yKwN?=
 =?us-ascii?Q?gB8yviArUcawd1+YjspGcPUDG+sEzF4=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfa85aca-7ae9-4e11-ed55-08defeafc696
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 11:40:03.8719 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CaKGh5e3s/PS4y3qNlK8hp8Az5BLczMhlK9JwJTQ+9NHwtnnWfeJ41QCBoJX9ZGJlU9d1bff4w8UNikVW0kzl/M0Uywc+ptT+PpI452LxIE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8413
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

CPR migration with a vhost-vsock device currently crashes the target
QEMU.  The device ownership is not handed over, so while the source
QEMU still holds the guest CID hashed in the kernel, the target's freshly
opened vhost-vsock device fails to set the same CID in realize():

  qemu-system-x86_64: -device vhost-vsock-pci,id=vsock0,guest-cid=3:
  vhost-vsock: unable to set guest cid: Address already in use

Add an unconditional migration blocker for the CPR modes, so that such
a migration fails early and gracefully instead.  The following patches
implement the actual vhost-vsock CPR support, and the blocker is lifted
once it's fully working.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost-vsock.c         | 27 +++++++++++++++++++++++----
 include/hw/virtio/vhost-vsock.h |  1 +
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index da244eb1657..503d248a617 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -20,6 +20,8 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/virtio/vhost-vsock.h"
 #include "monitor/monitor.h"
+#include "migration/blocker.h"
+#include "migration/misc.h"
 
 static void vhost_vsock_get_config(VirtIODevice *vdev, uint8_t *config)
 {
@@ -140,25 +142,38 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    /*
+     * CPR migration of a vhost-vsock device is not supported yet: the
+     * device ownership is not handed over, so the target fails to set
+     * up its device.  Fail the migration early and gracefully instead.
+     */
+    error_setg(&vsock->migration_blocker,
+               "vhost-vsock: CPR migration is not supported");
+    if (migrate_add_blocker_modes(&vsock->migration_blocker,
+                                  BIT(MIG_MODE_CPR_TRANSFER) |
+                                  BIT(MIG_MODE_CPR_EXEC), errp) < 0) {
+        return;
+    }
+
     if (vsock->conf.vhostfd) {
         vhostfd = monitor_fd_param(monitor_cur(), vsock->conf.vhostfd, errp);
         if (vhostfd == -1) {
             error_prepend(errp, "vhost-vsock: unable to parse vhostfd: ");
-            return;
+            goto err_blocker;
         }
 
         if (!qemu_set_blocking(vhostfd, false, errp)) {
-            return;
+            goto err_blocker;
         }
     } else {
         vhostfd = open("/dev/vhost-vsock", O_RDWR);
         if (vhostfd < 0) {
             error_setg_file_open(errp, errno, "/dev/vhost-vsock");
-            return;
+            goto err_blocker;
         }
 
         if (!qemu_set_blocking(vhostfd, false, errp)) {
-            return;
+            goto err_blocker;
         }
     }
 
@@ -187,16 +202,20 @@ err_vhost_dev:
     vhost_dev_cleanup(&vvc->vhost_dev);
 err_virtio:
     vhost_vsock_common_unrealize(vdev);
+err_blocker:
+    migrate_del_blocker(&vsock->migration_blocker);
 }
 
 static void vhost_vsock_device_unrealize(DeviceState *dev)
 {
     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostVSock *vsock = VHOST_VSOCK(dev);
 
     /* This will stop vhost backend if appropriate. */
     vhost_vsock_set_status(vdev, 0);
 
+    migrate_del_blocker(&vsock->migration_blocker);
     vhost_dev_cleanup(&vvc->vhost_dev);
     vhost_vsock_common_unrealize(vdev);
 }
diff --git a/include/hw/virtio/vhost-vsock.h b/include/hw/virtio/vhost-vsock.h
index 84f4e727c70..a964d57e1bc 100644
--- a/include/hw/virtio/vhost-vsock.h
+++ b/include/hw/virtio/vhost-vsock.h
@@ -29,6 +29,7 @@ struct VHostVSock {
     /*< private >*/
     VHostVSockCommon parent;
     VHostVSockConf conf;
+    Error *migration_blocker;   /* CPR migration is not supported */
 
     /*< public >*/
 };
-- 
2.47.1


