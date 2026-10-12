Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FBE0CA9ED2
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 10:30:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGDHf-0007tM-LB; Mon, 12 Oct 2026 06:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xGDH2-0007cf-KC
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:28:59 -0400
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xGDH0-0005Fy-Jn
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:28:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wPlKdvj7Gg31eYoP6glDNU01BCC3BoSw2fCE53c6YSagQkBnG9l3Iq1F9cJOO06/OSSzV6ISbqgzmjXdQFjw8kRt2HVdGWzhXI2z+hZ1wyUZ6eXd6AYFEjCzRsvELGMXPFpeODUrzq5H/g1GO+xEr4mpSAYhlhJdlBwqn56YDLj1Us07oF7aCOpcneZztXQZRZh9hHmTe3gQ8Resc/49ve5IAXICaz//mKx5neaP34p72tUVwooKoM6xZNeQMhfZTD9EITDpYrgLcfbUvWmPMHfFgNT9PojW8/pvicSOoa+5ykkwljBOmr4yyTjiix5C5lEltb1GcB1vIsKBAt5aEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3TExFPwLeMXjlLuiIvbbRNjfeIdrEhSOIYSBxmZt7sY=;
 b=RgYREY1jl16q2rFzti+6PrMiutBR819LNDSwkaTa/AKNDp2hx9iadtBZUjNoxNrkAay9/azk86N8GZLiWMycwZ27CiEV+x8OwrTLPKPLIe//TCz/cFC8Ka6ZWeTD4C631fvEhZW6WkSRM6Dz7N4vmaEc4TqgkYSjsAY6KY0JmdKf9ifKNdt/4any2/a0FHrsEcZ2O25xb/Kn4HiKqwTCx53+UIhzIaHmZcQGA+/+BTNHqDa0l9clLKBBTRSfISS1rNCUJOsC4l9uzdgjuN8ajnqYAvtC3AWMpIg2PWcvhoOxzq1odCYT8y+JV7kvNuLagmOcCDhV7qAtuRmn5Jrp2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TExFPwLeMXjlLuiIvbbRNjfeIdrEhSOIYSBxmZt7sY=;
 b=bS05E7l6BTGOLhuy1aFs+ZkAOisxizoNyltrs9QtQkVLZXfTMHeoaYT1IkI/GXzspLuvx2PQq3DepOBK9LCwqE+473ChZ2OaVji07D2LarJVEY7pFuke3DYa4bK17Ru1P76N7jWHsk+hvhPttPOCZZK2GQpaYg+ROFiBpdDbdeOuN2gcd+s/SW34jPcwq5cYTvyZJ0Gcr09SQYI7B5QwHC42HmPdR/k8h4orGqP2u5pW6lwSQ0TyN0nvlR6wZLdju0pYvodC+Wt5v8hEtmZxWOB8SvzfDaW+QBHSGY3sfmpTvaZNIADmXc/NhHLxf0ZIF4z531NjNxeUVaFAPNzftw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB9PR08MB11921.eurprd08.prod.outlook.com
 (2603:10a6:10:614::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Mon, 12 Oct
 2026 10:28:47 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0522.008; Mon, 12 Oct 2026
 10:28:46 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Mon, 12 Oct 2026 13:28:26 +0300
Subject: [PATCH v16 18/22] vhost: release ownership on exit
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-up-vsock-vhost-v5-v16-18-36c38bd15ffc@virtuozzo.com>
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
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB9PR08MB11921:EE_
X-MS-Office365-Filtering-Correlation-Id: ed7ab587-32d8-456e-904c-08df284b98f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|7416014|52116014|366016|18002099003|22082099003|10067099003|38350700014|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info: e2A2MclcUrW5pohjlK30FzLKe3s6Ay3AR8zxdU+qGSE4Ado10ZxSjQ4+A3tp1+3CGaW69xBenwBgKYtSxzE2FRKB64nioJs9nWZ/JPgfslv8jQ4FIaRi09WTqPxMUiX9Lg7FQJ0wWM1FZ92PzYlng24EQDMY3GRtMoE6ApdzxtgqVDOmG1rpqmWXCFNziFb5hpkawWBG6qkgXJLamjR4Bafl2NZf8IIt5do3bYm4/Ro/9gT4pjvs7eqgRcJRk+AFvkw7kYVB774aLGnEt5Di4NqNtkNs9NK8WWQBeG3r3EBevUfla8ncCMCi/zKPFt91ecs91qsTzZn0vCLAdepDRVjfYbRz0oL6H0SfP+QMw2r1bdhQdF1yzoTSd88wsNKR4EJxYC066pSf/bK1HnFY7abH22OzkUpgoYBcvuLTKZRv56DtMSqfmxXVeVJmHcrzr9qSBW2rIFCrb3NA5QGuPpwDmY3szZmozx4xE18xkGtZHUnOveu0JHE2H9Zk7VQHx8myOdPkX3HLSQaRJkFlKmRD1mH0l/h/gjVk7L6nPyMhWcEzlHKtUBmwh10A2r09CwbMHF2H4ZBRDSshrwsNIqpUlEpPcA9cLQQ1Y/lN812j/D63OoeZEgHVrus0DReF+UxKFqEBNvIZk9AufgnWE47ASscoi/eL/JtwPuDmCDtbvj0TPQ2ZTB3CMQ4kQwrJYfDmqxnf5Ug6STqoo4oOfZye7LsSL3DSJdVGqgR07WE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(52116014)(366016)(18002099003)(22082099003)(10067099003)(38350700014)(56012099006)(261009223027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzYyUDMvR0FxS3RXLzhhZTEwditweEhBR1p0eFlKQ0k2cEQ2ZjZaR0dXODNn?=
 =?utf-8?B?MzVFN0cxVHIzZnlFaFBkL3dzL2xIcGtxWUhjZzZGazYzNFhKOForMkZYMUdO?=
 =?utf-8?B?VzIxSjJ6dWI2Rk9Ed3hDSXBoL2JvVnRvWFI4QmxEZlFBZXhsSnlOd2ZIVFJu?=
 =?utf-8?B?enFqVFNWeFFNbmxYWmxxK0lLeWRoVEJwNGpIWFppYzRPOUFkQkxYeWV0MTNj?=
 =?utf-8?B?d05Ec1ZxSnJocmxhQ3B2d2RrWEw0VGhuS1VYcEpPWFhjbmZiOUJkbXdRQ0Qv?=
 =?utf-8?B?L0EzbHBCZU5EeVc0QW5EalNVRFk4RWdmZE5tTk9WVkd3NnBQbmdRWVF2U0Yw?=
 =?utf-8?B?ei9YM1hneEVqeSt3Z1lxZGdNTDhQNzR0dTFBS1IvYVdPQ05BZ2RTRGNHL0o1?=
 =?utf-8?B?Y3BiUFZQbERVakxOYzRBSk5TZ1R3V3AySC9XZFc1Ky9CaXBGNkhxTDZGS2o0?=
 =?utf-8?B?TEtSOUJEQWdpcndqVFFRa2dSK2NHL24wNStIOW43a0NzVlRUVGZRTHp3ZXFV?=
 =?utf-8?B?aTFHcXZDbEM4UllXOWFudFNBOWRTdTl6eUphekgwRXM2WkVCNFVyL0R6MjFX?=
 =?utf-8?B?WUpCcktmOUdJeFZ2L0EwU3pwbG9wR2R6dkxoU2ZLWXZqV0hveU13dEJqaVBu?=
 =?utf-8?B?QlNwZDdHbmJUc3Z2LzdSMzk2VU5DTnBnNnNOSmZ4bCtUZ3NGUEZubXBXazAz?=
 =?utf-8?B?QW5lYkNIdzkyVDl2eXdmUTBkK1YrVnhEM3RkVWtJUUtoZzd5ajRqOUZpUTQ2?=
 =?utf-8?B?SHhaRlkzL0s2M1BVLzk5SVJadzNHUVBWc1p3bFQ3Rmwvd3h5RWtOVHAxQTRw?=
 =?utf-8?B?d0k0ZFhSUi9uVTJIRGR1cDduWFlqM2FBRXlpT25xV0VEZzJzUnZER1gyazNK?=
 =?utf-8?B?UHhDd2l1VldSNDRXZ0FZS2Q4ZVdwbzF4Mm1SbFh4VUEyZm5NbkE3czI0Rkg2?=
 =?utf-8?B?YUdsdll2b3hkQ0plcWJUbUJ5OHRXU2RBeUxwWUw0S3RWY2g5T00raDNJNzF1?=
 =?utf-8?B?OHpnYXBtNzl5MjlMMytpbVdoUThCVXlYdElGbjlrVmRTd0oreld2c3ovenMr?=
 =?utf-8?B?bFhLNmtzWm5abXlGWXZGT3IwUUdySTc1UGc5MTRNNlFWVnRjMkJnWkwrREJQ?=
 =?utf-8?B?cGxKTzJBSHRVK09JMFJ0REpteFZzdUt0ZFpXeTVqWW9USnh4RW9aSVNQaVdY?=
 =?utf-8?B?K1cvRXRON1VEMzBZQXU3TU01aDgrcTVOdHMyTGR1LzBCUWMvMnZhYmtPVGNP?=
 =?utf-8?B?cFFHeFhaUlUvQm1KY1VkSFErUTFPcnBwU3pabEZOSDNlRmZldlZtZWpJR1pz?=
 =?utf-8?B?YTI3RllVcVJRUlRjQXF4cUl5alBFc2c5ODM3L3BqYVZPdEVxd3hIUVY4eHVk?=
 =?utf-8?B?K1Z0QUhFaVFaNmVGOWtHSXlVcFRodHY2TTZ2aU5jZUIxUlg2Z1ZsZFlqNC91?=
 =?utf-8?B?TnBKVi9lbUVUNWRGQUQ2c2gzRHNrSTZWK1kzRzgwUjJrWVZHVkpyZnB3eWFY?=
 =?utf-8?B?OHFuaEFOek8vNmNuOUZYbis5TmcvR3dFNldTMGY1ZWFLeU1uZTlhN3RnTVQx?=
 =?utf-8?B?Rmlncmo4YzZWL214T1F2UDVVUERrR3hqeWJrQVhQQnNpc25mWmMxNjZyeE5U?=
 =?utf-8?B?dTlYbGVTbDVpekdWY0xicHdMdDVscjdKemZWNkZ1d0k4UXVmczhOMGJGTDls?=
 =?utf-8?B?UkVuQzBFeFozaHJPdStneWNqam4vQzlFbVdwSUpYTkhRTkJMQmlRYUdrOXM3?=
 =?utf-8?B?NDZIYXRIdDNxKzVmbHkrVnZCbUZlcXRNYUZIT3IxcnVPbW9lZ3pBV0J5Tmxx?=
 =?utf-8?B?VkVxeEJYSC80djlOLy95VXhFNlh4dWo0ZXNXTU5HTktyc2UvSDk1U3ZmQVVv?=
 =?utf-8?B?THArYllnSGYrSjllWjFhUkhFYUgrUk54SmZmdVk4SXFvQXRUUnVJcnNwQUtn?=
 =?utf-8?B?bGhvWXg5NytaYlBkc3VzdGdDMUVpdkIxcVROSEZjS0FYSGtkMzlEZmJ3UFpQ?=
 =?utf-8?B?alpMMHZwbmlqZEc5S0VwRlowRnE4ZEZsRWpvcGVSaXo3QXpuanBUckQrVCtG?=
 =?utf-8?B?Z1hORXVvRms4a0d3dFZpUklKcWxKOWhZZzFYK3VkMmM2MjNBVkQ5K3BtQWJW?=
 =?utf-8?B?OEJxWi9OV3daY0lpVkhYWms3cHJQZVc4ZUxJQzJ3ZW9oYy9jZUZKQWdMbVdO?=
 =?utf-8?B?RzJRTWpha3A1aHpEb1l3dmxLQ29OVHMxUjBHa1FmMjdJTzUxWHV1bmJwUkxq?=
 =?utf-8?B?UFF3b04xZGtHd3Qxa0dHRU9BM2x5ZVF6T3ZKSm0zZUgyQ3c2OGQyT3BIWXI4?=
 =?utf-8?B?QW5sRDZZSmxKTnFrbDVzSUNKR1dRZkhJMW93VXFMSitOL1Bsb2dObkhIcUFE?=
 =?utf-8?Q?xX5xC4v81Fw2iDQ8=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed7ab587-32d8-456e-904c-08df284b98f4
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 10:28:46.5855 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v3LSvEyb7ULGY23cwAyQEgWZg+5tw/rXlzCLJ6rG9mEMf+48ewPYzUf5HUMIDLONNAEzKXotkEveoRTidNg/9LEZXZviCdciK4SV2LeIBhE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB11921
Received-SPF: pass client-ip=2a01:111:f403:c20f::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
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

A CPR target that has taken the device ownership in post_load() doesn't
always reach vhost_dev_cleanup(): a target which has loaded the state
but hasn't been started yet, e.g. one started with -S, may be quit
normally, with the source being resumed instead.  Devices aren't
unrealized on quit, so the ownership stays with the dead process.  The
source still holds the FD, so the kernel never releases the device, and
the source can't take it back after being resumed -> SET_OWNER fails
with EBUSY.

Add an exit notifier to each vhost_dev, registered for its lifetime,
that releases the ownership if still held.  This covers every orderly
exit.  A target killed with SIGKILL or crashing still leaves the device
unrecoverable.

Reported-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost.c         | 20 ++++++++++++++++++++
 include/hw/virtio/vhost.h |  2 ++
 2 files changed, 22 insertions(+)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 7fd2883504f..cbf6e82afbd 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -31,6 +31,7 @@
 #include "system/dma.h"
 #include "system/memory.h"
 #include "system/ramblock.h"
+#include "system/system.h"
 #include "trace.h"
 
 /* enabled until disconnected backend stabilizes */
@@ -90,6 +91,19 @@ static int vhost_migration_notify(NotifierWithReturn *notifier,
     return 0;
 }
 
+/*
+ * Release the ownership of the vhost devices still held at exit(), so that
+ * another process sharing the backend FDs (e.g. the CPR source) can take
+ * them over.
+ */
+static void vhost_exit_notify(Notifier *notifier, void *data)
+{
+    struct vhost_dev *hdev = container_of(notifier, struct vhost_dev,
+                                          exit_notifier);
+
+    vhost_dev_try_release_owner(hdev, "exit");
+}
+
 unsigned int vhost_get_max_memslots(void)
 {
     unsigned int max = UINT_MAX;
@@ -1860,6 +1874,8 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
     hdev->log_enabled = false;
     hdev->started = false;
     memory_listener_register(&hdev->memory_listener, &address_space_memory);
+    hdev->exit_notifier.notify = vhost_exit_notify;
+    qemu_add_exit_notifier(&hdev->exit_notifier);
     migration_add_notifier_modes(&hdev->migration_notifier,
                                  vhost_migration_notify,
                                  BIT(MIG_MODE_CPR_TRANSFER) |
@@ -1913,6 +1929,10 @@ void vhost_dev_cleanup(struct vhost_dev *hdev)
         memory_listener_unregister(&hdev->memory_listener);
         QLIST_REMOVE(hdev, entry);
     }
+    if (hdev->exit_notifier.notify) {
+        qemu_remove_exit_notifier(&hdev->exit_notifier);
+        hdev->exit_notifier.notify = NULL;
+    }
     migration_remove_notifier(&hdev->migration_notifier);
     migrate_del_blocker(&hdev->migration_blocker);
     g_free(hdev->mem);
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 3b9ef86bacf..eb693e32898 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -123,6 +123,8 @@ struct vhost_dev {
      * when this vhost_dev goes away.  Set by the device.
      */
     bool owner_handed_over;
+    /* @exit_notifier: releases the ownership at exit, vhost_exit_notify() */
+    Notifier exit_notifier;
     /*
      * @migration_notifier: releases the ownership when an incoming
      * migration fails, vhost_migration_notify()

-- 
2.47.1


