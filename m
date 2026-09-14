Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A60C88E71
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 08:41:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x62FE-0004Gg-Aw; Mon, 14 Sep 2026 04:40:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x62F9-0004G4-SB
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 04:40:51 -0400
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x62F3-0005PZ-Td
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 04:40:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pJz0cDvazi0svL9pbBZIoFvMUdf9AJYbCZrzTYOWflwqg9gpBe8k522xSUwFmRYKwI8nUl0bQKvfzGPGHI4pjb+dCIZOUhDodsAdg21eIhNYZu/VTXSMxp7trYZ12fmxvzcA/FeQazIWST7aVTUoB2vZ6aVZSn1c4CA0WoNAxdtSSWxNBZyRKCwOl7TfzHe3agAMYgz8WXqdneUJWnOi+JfNTlcLyEWGNoGzp2WeXy/C7dEXU/kUhSfFImwERkyOR6i5YcQvaepJMb2G06SxWH03bHVie975NwvcIgvBBRTIy6su5n/IAjho+xuXvXO5LgvuKtVVRjTYmVFJ5YormQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42TxjWWVF52+WjX+vXTK/F5rsdLUfNrhRilXbJ+LOJc=;
 b=jQvCzo43f7sG3jB6wCDr6lKAidHtYdjwilix2LPEV4yfUSSZ42Woi++5XqvGeU4jiJNqL4BYc0URFt9Adv8Yj0ZlAYstRHN0O3R+psHqyE4mXTlh1tqhADXNDzitF+/lSHbVNU11rEFm/hd2xwoKWIwp6JUgrLr/CJL+KZD3WE5tpnzJzRJ+DhEeYAj1AdC7wXyuKlguTXIbdQe2J1Q4mBcsVnBm79xxSDX08/8MMqg8AjX0Z8qkGmGyfqaM7styg/pl3peS9NTXK9jhaWIenydYlntfh8mfkL4fq5DM6C6LY8+0jZOpsYdQQonvILDiIY9uTevLmtdXtXFPIGVCAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42TxjWWVF52+WjX+vXTK/F5rsdLUfNrhRilXbJ+LOJc=;
 b=PggUAOB1ah4RdVRMY0P3dLreUxoaD+7sGCDITnFAoB+6xSoPKkrh9xs11PJeMb1L/8ZlDS4+/xa5kV6I7RxY7e1Qpc+vzkEljcP2QC+4f/PEUrzWN+3vzOSHZBsB7+dnJ9LtWIlIZjl+qc2oVETwJlHv+/SRkf+8LMGAB2tnKorozXDLTAE1MCI5Wu+Xr4jLMt8joyUz/dn6AH6b8kJBqf6Lva7l6xuWigGSXeC+9MwBTjShV2S6iNDIgOqiqNiRnrcUXn54YIbOoMLJudPv3okoZXcJxrMopce2m3JEtrOjBGAqJO25I8GLmMOxGvTPx/O7gs52k6X8pNKIZTithw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by GVXPR08MB10916.eurprd08.prod.outlook.com
 (2603:10a6:150:1f7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.7; Mon, 14 Sep
 2026 08:40:25 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0428.004; Mon, 14 Sep 2026
 08:40:25 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Mon, 14 Sep 2026 11:37:36 +0300
Subject: [PATCH v5 05/14] vhost-vsock: block CPR migration modes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-up-vsock-vhost-v5-v5-5-d17423589f48@virtuozzo.com>
References: <20260914-up-vsock-vhost-v5-v5-0-d17423589f48@virtuozzo.com>
In-Reply-To: <20260914-up-vsock-vhost-v5-v5-0-d17423589f48@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, philmd@oss.qualcomm.com, maciej.szmigiero@oracle.com, 
 bchaney@akamai.com, mark.kanda@oracle.com, den@openvz.org, farosas@suse.de, 
 peterx@redhat.com, clg@redhat.com, andrey.drobyshev@virtuozzo.com, 
 sgarzare@redhat.com, dongli.zhang@oracle.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VIXP296CA0028.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:36e::13) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|GVXPR08MB10916:EE_
X-MS-Office365-Filtering-Correlation-Id: 33fc258c-e463-4af8-2231-08df123bd10f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|23010399003|1800799024|366016|10067099003|22082099003|18002099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info: R5KG8KKNASHZJ99rpx0j7TwiCgbc9oaCcxupxFVtEY0uOZ8RaDJ2eCSDiaCaNIUXAbLKNYXt5Hm4GLQu2P3kw0IUker08rUhn+uW+eIb25/fCatJ/Nd/kecwotY3XXul0/lcdGgfANZoyFC4j3oQCVOkAP0B5wWtj3cJZ7QLHovnZSdw2y0r1bqokay2xxh4+ISazRKHgJ8rfdxgsH1we9CRBSIkMaZzF0TpWAqMJ9+iZ1+5uGFuohKk61AYs35W3UvmrSuK8YvYnjYZGf62u7x7w/AEdO8rO8IzzNeoU2gSKji1dUpFVwU5vvChlvEaqbi1oSZNoaj0IqnEWQoXP3jyNgcYvnywexATwCJfqNhBQvCBespFAjbCpj2MpXzDZ2yinwYp48J49pqHLKMivk7lbX7AjpHJBKTJEpeF1sRMAhkToabuXlYjzDWc6/D8S4G1kC3TXpiww+QfM9tXG8loW15m4lkbah8DgMX2spKARjpToVSzjEhTZNecF7FbPvatL8e8jBACPsGsAZg/3bA/AAN/FoVMxddLW6i8Gr7Rr4RYVXSoFBsYN2LdF5LorHp4UwB9o3xuxLOrRxqR8c+JuFEoS8wGdwSiytJq3Xdr3C32h++QrHqu4jZH0uGz1+4myPkpAJiG8KT7+Q+O0Jz9yp8gHCFZGGWET4JhgLzYZGU041rmglR+0rTmsrI0VLrrrRLzjaANYXqxx9ZUOErvQ6e4RmyI51EOAOovY7Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(23010399003)(1800799024)(366016)(10067099003)(22082099003)(18002099003)(56012099006)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlVYcXhsTXVlL2RMQ212ZHQrRjRadlEzTlE3NUZ6UUgzeFU1UnlwUFJYVlpB?=
 =?utf-8?B?UmhqZUhJaW5QLzdSeFE1dEVMWlBMRmZOQ3NZQjFlSXA1R0pDT0t2dnN3eUJr?=
 =?utf-8?B?Z3B6TjAzZW1OdGVMKzZMVUFncFZrTGRsTGhJV0ZsN0RnZGJMUkN4amxKVS9j?=
 =?utf-8?B?TXd1QktnS0wwamVUbWdXeXk2WmdWbzlMa0dTR0Z3bVFGT0RTQldOYjYzOGtq?=
 =?utf-8?B?NncxZ0ZpTnB5MTZBV0ZIZ0hoZ2hHVWpNY3c2RUFFYjNyZmxaQ1NVSGFweDda?=
 =?utf-8?B?TGRGQmtWNnN0bW9xbzE3ZTVmTGQvUVd3WWtRSFRPRkcyYm4zaVFZUGRCSVBH?=
 =?utf-8?B?dWlMVVEwTURLRVRKd2hsY3hJTTMxN0IvUHF3UGVvSU11eFYyRHFjRHFhSkNa?=
 =?utf-8?B?M2tKczIyQW1ORExwVGpvcjdiUUV4THRhVjJpZ2daZXlHb0lxaFhCNVN0RVFU?=
 =?utf-8?B?ODg1TVJheXgzUDBSdDMrYVlGeGxIdW9QWGZuZjNRaWxQLy84dUY2Wlh4NkdR?=
 =?utf-8?B?Mkxaa0NCbUZMalJDekRaSkJQRjZTOURCRW5md051VWRIUnMxNFJuNEhzaGNI?=
 =?utf-8?B?anJ6Z3BXYk1nUWE4eTlyZGZNM01DWXdLYkRmNFU0aEVXekxXVW5MQ0JwZ1Na?=
 =?utf-8?B?NC9rOGdDUklmeGJpdHBpVTFTQmVmZk9DT2ViNUdFM0JCY1QrV2xyTkh3K1dq?=
 =?utf-8?B?d2RiNzl6MDZzdkNpNTk4bUVLYURrN0RtbDRaU0dkVTdGQkdTeTlVYXB2RGo5?=
 =?utf-8?B?SU5qTkhlTVJVczB6VU5zWDM4Tlp6TUdUaXhES3BjMUgyVWR2OXlQOFRQQkJu?=
 =?utf-8?B?T2d5MUd5WDRHNHVCZVd5dXUvM2Q1MnQwQ3ZDWnZUYS8rVERsYWw5VUpEK1BP?=
 =?utf-8?B?RXp1MEVkMEppR2Z0WCtoNkg4OUFhRXNSaTM2Y0FGbEN6eTlWZGtIeVF4TmMr?=
 =?utf-8?B?S1Z6QTRnTGNuZEppZUhqbXV2WW9tY3hUQ2RqUzc0MFJoMkpRcTd3UUUrOS9Q?=
 =?utf-8?B?eERyYkJvbHd4ZTJsM1JhZ1NCWkYwbVNKNnAwczBPQ3hDbmpSU3Y2T3lYeVRO?=
 =?utf-8?B?eUpKQjFKMmZVZDdrMll0Q0tlWk9RSEQwQWZhQ291SFU2bzlhcEQrQkRiWkw3?=
 =?utf-8?B?SnJkdzJpN2ViRmVFWUZMZ0dWRmhYZFNyWWpXU04rV2VKWHBoN05tVmp2dGZP?=
 =?utf-8?B?OThZSzlIenZ6eC96L29PamR3VEQ4clFWaGpPSnQ3Y1dWQldCSjJ1dGxLTXpq?=
 =?utf-8?B?QTc1YjZKK09zbE5JSWY5c2pQZlhoTUlFYWtLWWFMQVdCMThnV0ZIKzFocCtx?=
 =?utf-8?B?K3JGd0pUMy9NbkxZVEJkSlhsdW9kc0RhK0RTWWlVNHZZaVgyejh1cjF5eU1w?=
 =?utf-8?B?RkNQWUdPOWZaTEU2L0pzOGs2aHU2RjRzQkNhUjFZM2luVk03UUdJM05hakdG?=
 =?utf-8?B?bmJmYnJhV1pZVnFzTFRpaUgrVFMyazI0eTRSVnNpRkxtVnUyUmhITXhRTlA1?=
 =?utf-8?B?VXEyTTI2M24rS3IxdDh2REFmVG0zRlNwVmFwcjlML3FoU2dBNG11bWd0SDlM?=
 =?utf-8?B?bnRYL0FwR1pWTmYvSWV2blVKelFucVNEaDQ1T1o1eGROcmhybUlsR1Vrbm5R?=
 =?utf-8?B?RkhzK3UzeEJmcmVSd25oTjJuNXZBcE9NKzBFSDY4VFpBT1hWSjFwcytra3RF?=
 =?utf-8?B?eGwzY3ZXRzFRUE1ZeWpNaWcyckRySEhVU3dpYmk4RWxqWWhwRm45Vk1HVGk3?=
 =?utf-8?B?MkpSY01xK0kzWTJQRVRITGtXMHRSQmQrejVvakxRb0owOTZZbkROUU51VElv?=
 =?utf-8?B?WlFZajR1aGUwZ2wwNlcrOWpaclV2K3huTjBRdHNjblZJM2ZTZmhXcmJ6WkJP?=
 =?utf-8?B?QWIrSTZiQjJ4L3h4OElJSmNXajVTQUZnZVZ4bERMdXNkT2xFdW03MERvc2d3?=
 =?utf-8?B?ck10RGZMT3hEMG1sdUZMMDhHY3M4STNUTHB4bnl5WURrY1J5TXNKcGlvZVlh?=
 =?utf-8?B?NVFzdkhwbEpQbDBGUWZ4Ykc5QnhmSjFYbjBrWTd6bW5FT1pnR3hPZ3EzenRo?=
 =?utf-8?B?eHNzeGs3YUFHWnZMbEluTmdrNEJZMks1aXQ2QmtvekRnOUcyenhmRjFBSVpN?=
 =?utf-8?B?SmtLRkVUelpCYXZrL0pVbklOQURXa0ZWb2xXYmpodG5YdnF0Q2NRUURXUlA4?=
 =?utf-8?B?MXR1MWJiS0U4blBYWVFTSmNqMjFpMkdFZ2hCc0Vsd3gwcjJlbm8rUXphWHF2?=
 =?utf-8?B?bEJldzJzMlR1RUN5aEE2cTVjNkNDSXpRbDJSREtzTnY2MEt5b2JtbkRlY1Vu?=
 =?utf-8?B?NGU5aW9pVVdray9aNXVieDJSeWEwMFpGdUVLRDVFb0dKUGordVhpaXZFaHF3?=
 =?utf-8?Q?wkP20xO9vL0wE/qE=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33fc258c-e463-4af8-2231-08df123bd10f
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 08:40:23.0626 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X57MKSF1DREvs6pdpRpJZwF+0y1UfKj8uTaTpZff59tkC0cwaZVlPcAnSgXcmRAy2jdGN1yXixAaWxjCBN++h80ReH9Tm3K6cTp5CcTpmlU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10916
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


