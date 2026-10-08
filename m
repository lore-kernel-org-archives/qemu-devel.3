Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C692FCA600B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 10:26:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xElK8-0003Ig-73; Thu, 08 Oct 2026 06:26:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xElJt-0003F0-LC
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 06:25:49 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xElJs-0000sa-1U
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 06:25:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DFNQSfVRXSoccFkLjzExbJkHeKJV6llr6wcbUK/MVjNk9LlomGt2VRx8pHjNiqMYhAocQ2rnKeQQ0T8OHL0fpSTyPSAeXwH8NVJaHPMvD1Yy99y5inUasig/5FRo6axaWNOKhKb2UNwzd8RsnOLL+yfzzRiNcKDBMtjsEhp4TASm5EoaWw3c8dr3Ctce+1sqKaSNgJZQPBGTHviuu2DKAUVwWGGjhgir9MOnZBPecBPURBS2AhCfstmMndjuC74AFeMVLDElKn8n7x0ruVZS8N/ZgzXgo2mj+d6Hur/7lFWBzE+SuCI8w0wFRxRsWOkUUnbPNT/3d1LBkbjAyzaiiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42TxjWWVF52+WjX+vXTK/F5rsdLUfNrhRilXbJ+LOJc=;
 b=PAzM0cjD8o/PNvQe0cPvy/AB/4w6TxsS/8wlvVBdQEswJHgRI7zFkS+jpHNBbK22CeizuRqDVfW7XBoRbhewY/I8Le31pDsBLGAsUKgNFTQDLUCDzPX8PRIp8xssVHgQ49rUX/1lnT8pSOYSVSW/vDxILXc4ymsm+HNZl+FhuRdW8W1AUfwCBHRJdEoQaVqonUBjLyfZVoTh37Yq4hfc1IuMTM/O5M/ZGkPSKQmyTjr5aDLPbEj3ZoGbUJ6WQcJhhXT4W4/RrJEI/F1pXNoDf3M4z763BZe2FU1pOVNl9IcKG1CqZ2TnDsIYGHbRkZNvUU/zFYF8mxKsIkvsD4KROw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42TxjWWVF52+WjX+vXTK/F5rsdLUfNrhRilXbJ+LOJc=;
 b=RDhO1851ElPgJMf5GYd69crsKcez+g1o7sJiNtT1bN4RBBPiCsICvuzBES5d8kVoU8LbQJ4we/k4rr1CL5peVPVt0tXMC/Nf7AfmYPUE9SksfxxL+39r964ZGXwxlzzZnKRT6KgEpqVw0K3S4V9rZJhnBdvP2y9RTqwYTVXqME5v4YUmycSrxtK6sHKIlQTKe5BK3DX42rNUN+nlibgKuuP2iBi0+XZEPvc9NVOWPvDZkTmg2aw1YOzA3t2JsPPms66g/weFTLKZGfeWq0uIWA8/MvVrEFzBnIL5iTwWimchKa2393CtjNWNyLMbr3xunTEMNzFMen8C7d2ZBS/Qhg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PA6PR08MB10593.eurprd08.prod.outlook.com
 (2603:10a6:102:3c8::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Thu, 8 Oct
 2026 10:25:39 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Thu, 8 Oct 2026
 10:25:39 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Thu, 08 Oct 2026 13:25:30 +0300
Subject: [PATCH v15 06/22] vhost-vsock: block CPR migration modes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-up-vsock-vhost-v5-v15-6-301b73b3f843@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5a9d5dac-66a5-45d2-922f-08df25267dec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|52116014|23010399003|1800799024|10067099003|56012099006|38350700014|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: EiDXwRxE5Eri26k/WqsyLs9+DsPn02Z+KXQSTssjauxhaSKAM2SB8JyDrTDPYdxdTRDvN02TsCAfldlvN7tkKbtrZ079G6qGKqECtS1zuf2Hg0JchEUao+CkyBGbFCyNM3UXo6AENzaxBueWEzFhhstaw68AwZfPjohWpXhpPVFVF0EB238OYb6oU6xk4x2uiEkRKQM2JS/OsZGj0ExO0KFHTQGr0WWGpdaUQm0a/gVI6tdbjQVhwn6KKILTw6Qfl6FJUYOn1liGEOrD6Cl9lSEsOEx9pBB4prnYvqeFPib/mfG4wUHbHRxXxj0xNqlmeWnH1XD0NhKSJLPi4NhdW/CqK7p+AW4uB/9W6UTbwaKdaKfkzunzAqSOFBi5kusOuzqlya6dWjr/os4D+DPiExmnmS4b7uddV5yL+o2g0044m86rPhS1nD7hzUAkYc7o0gLImYLsU3SgSpZSl1feHw1RHFxaI4qBZzXVizZExGmS07CDucLdDGc8V+z7RIBMnXAzCIa2J+K6tVPV6Y8s6wlkAIcuLJK9tsCovwOPKcrBtmZZMy/wZN6Cb3u+tFq/5lrT0Lpe7MJNJ0Fu91N+yoxk4bujGY/alWPq8tcgx9Qyr1v7xB4RaRoqaDEHfKIwyU165eFjQ8QJ0CnRpGLZ18FcKl+RBBfBCB3px3Sln18YyFgo/1DA8a2n+hq+QWCBvtF//rBQW70vXhZGajApLKo7IfJcSugjwZ0QN72+fmo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(52116014)(23010399003)(1800799024)(10067099003)(56012099006)(38350700014)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVlRa01YdDlVSC9la2N5SFdWSXRNY1RkRmU1VXJUL1hYQnE3K2QxaEtKWG0y?=
 =?utf-8?B?TlpnSEFnamZ5ZmFwN09kWWl0OUpEWklSTEJka290VEc1b1N3dVcwU2ptVTl1?=
 =?utf-8?B?Q05lMzZlTUw5cEhPMXZYd25Yck0vcjl3NW1JZzVXcXVaNld0eUg4amVOcFE4?=
 =?utf-8?B?a0pHcFU0ME9SMWdVSFNxc3o3K0tVYy9pd0hncTZWLzFPZ0k0a09MbEkzc3p1?=
 =?utf-8?B?SndsQ01BQ0cxd0h4RXBXQ01WN21kbjVIUlJGSC8zREhPSVZXcmgyc2RMSnJ1?=
 =?utf-8?B?TWlFcU9tanRQaXdxMERtdUxBcENuMUNaaUFHbjA4Qkp3OGhTeFRZRnpieDBl?=
 =?utf-8?B?VFZoMUttM0FicWZNVnkrbmRpMTU2Qm5XUTN5K1RBZktWL2p5anIvSHAwNDZO?=
 =?utf-8?B?WndORVU5aGMrZWIvaE5MQjA3SDJrTGVsY0V1QldpR3dOeEZTZ0JQNEZlbFZB?=
 =?utf-8?B?UzRNN0krWjNWMWFSWDJ6ZUJVR1hMdHlCNkJhb2lvM1E2Q1pqaGRFUm56TDYw?=
 =?utf-8?B?K3BsMVpZWlprRCs4Q2xOZzdDNmFmcjBCOXA4MmUwcVhETjdCaTQyc0lNTXYy?=
 =?utf-8?B?TXVGNGJLRHhWOXdEeTVHQ3M5WXo3M3orWTBmcFh2aXNCU2tBK3BSNFBQeCsv?=
 =?utf-8?B?ZnhDc1A2NHV0Y2gyYmtVL2NobloyTm5xVWJ2Mk05cHlFdVU5czRTeFRyQUxE?=
 =?utf-8?B?dGd4Z095ZXBlUUlFNmpJb0I1NWo5eEtzK1Z3VVZQalY3TE80N0hYTmc2Mjhk?=
 =?utf-8?B?bzlLcktCdmc3VHY5TDVENzE2eXIxRklvMXliK09vc0pmV3N0NDlqbkRDc0l1?=
 =?utf-8?B?NkdFaG9zemZncW5nalA3eTZmZDNiWERmV1ZydmNRelZMVWFsV3hYdVluT2Y2?=
 =?utf-8?B?RW54empuK2ppT1cwTmZlTlowVzMybSt1N3UwMWxyV3pRMDkyYzlmR2tQclll?=
 =?utf-8?B?MUhGQ2dSYnVIbUNqdkYyd3ZQMjBNYmFJek4vZFBSRkVKdkxJRHhjbStJVC9a?=
 =?utf-8?B?TVBOR055UEJISzROMlBkL1YvREh6UTBYZWl0MVM1aXdMaHhUY09DbzdEMXRh?=
 =?utf-8?B?Vy84akJ6b0grUWtTWWtqOWQzT29xTXRFa0RIUms5QTlrbVlhYjdYSWVNVWcy?=
 =?utf-8?B?MStYTDNOa0RrMHZ6Wnh3YUtNOTNCM1V6OHFsYmN0c1pENStWblZjb1ZuR2oy?=
 =?utf-8?B?SytwR25wVWNHakRkNHg3L3I0bWovZjBwa0lxVGdwZ1ArVUI0Yk5rZ1ZzUTBr?=
 =?utf-8?B?N2hiSTRsc2pIL1dLQTZLVU1NZmlOWDBISjFheTErdVl0ZDIrcDBXRHkxYXU1?=
 =?utf-8?B?blhDT0lvUStRY2pPMVFzQStYYlhxOGxJdU91dXdqQ0JoSXZzalhta1F5Skov?=
 =?utf-8?B?Skt3UjFIWnZXbW1qNU1BTS9nTTdoRmVFZEVlV0Frc01BUlJGRUg0TXFYaDQ2?=
 =?utf-8?B?OTRxamNxVW4rTlRVZmRuWFR5TCs2eWJERVZKR1NpODhueDBoQ0pRV3BKNTJS?=
 =?utf-8?B?NVNzWFhaT0xGamxvZXBpZXdQelVNTTF3OUc4WmRoVWxwRjVva0FaK0MxdzZy?=
 =?utf-8?B?U3BvYTlMdlFudTZ4c0VJckhsc1p1bmdsSWFuVVNwcHdsVlR4LzZCaXA1bTN6?=
 =?utf-8?B?RWVvSHRFWGV2eVRYOVorSmhoUVVONUJqc0ZHNzhKWXMxMHF5OEV1bk9hQkZW?=
 =?utf-8?B?RlZla3pWUzR1WFFocDJFOVdkNnErM3A3cDRoMmsxL1BrbUpCRjkrQVNxOXVR?=
 =?utf-8?B?ZkQ0a0lGRFJiSHZUVWJvQUFyOW9qOU1vS0Nkb2JvaGF5MHVDUDJXVFlRbStV?=
 =?utf-8?B?ZDZBRmN4REorcUR4NGR5NVZvREM5QTJCeEN3U0dHdkVXSjJIZFE4aUJDa1Vn?=
 =?utf-8?B?bTRHZzhzZG5YdkJFZWYxbUNDeGg3YWNtMGZNOURrY2t2c0hvNFFlWS9mWDMw?=
 =?utf-8?B?TEtISGt6K0kzaWUyZkJySE9hZzFhUGNjcThmRTNFZjZNdy9UVGx1NzY4YjI4?=
 =?utf-8?B?QWRnZGVjdHpWb0NHbkdsZEowb3lrS3VhRk9Fa0lMSDRJdVpENjF6VjlVdW9F?=
 =?utf-8?B?cS8yWmRtL1lPanpuY3N5RTdOUGtnM21FUDBCWFgxNHFXcXdheldZajJMTEdp?=
 =?utf-8?B?QUtpUVQ5Z3FuWDdEd1NBSkVpYVJwbkxnVEd0Z0lPTVRlbWd0MEFub2hVbUR4?=
 =?utf-8?B?WFlGSFhlTnE2NDNzRFRlRG5COU5icVE0bEd5QzJMeW9ZZTlHQkFHSkJuRnY0?=
 =?utf-8?B?QnpBeUJsR0RpM1NMYm9tR0FTcUl1ZUxSQVoxUlVDc1FuUGErcGFQY2UzNHg0?=
 =?utf-8?B?OG1ZM2pMVlY1SzZmRnVJMDlpS1VuY2lIdHFqaklkbTlCbUZiUVYxZVZyQWhV?=
 =?utf-8?Q?lkZuf+2TJnAmVkjY=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a9d5dac-66a5-45d2-922f-08df25267dec
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 10:25:36.3792 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FBbGaAizsXVe+G8ke5fiR9HaIqE2BduLBipehbN0TsjSFeQIt/lhmwR1KUGGuFmrQbc8xYMI1PiEnsiqlzhUmdLZPwmD9oQzkNspfTTXo64=
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
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
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


