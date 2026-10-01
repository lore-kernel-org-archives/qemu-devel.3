Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E8EFCA5FB3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 08:29:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCC8h-0005yt-Q4; Thu, 01 Oct 2026 04:27:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCC83-0005C3-TM
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 04:27:00 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCC80-0003P8-Sd
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 04:26:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=drJcDSiVgc1RJw+O8RoucR8NQwOsdNUAja/+0QXzRduB4KEduoUC14/VG43xobL5RFGV4TEkgDqXaorJziGXPViZx2xhqi73SDHYKAtvWip417xh57DLsbWBr5ARljkqPJXKYhknGaGd5psqz9RuKD+2ktihC95n8aHeMhlNdX2q1BQmMeOyHEiy9stJtqdtzZa+y8iGqq/2jBkN672wt+W8kx0jAzxWGfg6CHSbPXc9ZVqE9DGgsz7o6BYxhS6eY/fa+CCDfgCMUEFRsTk/asYabZmxP6KD1FVxwLsrtfF+gInLT6XECjqlq4+GUHMn2wlEEwGC0U/CUrgNyka/VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42TxjWWVF52+WjX+vXTK/F5rsdLUfNrhRilXbJ+LOJc=;
 b=Troufd/ua/tOKmfYs+iQ0IimQhBY5hZTbTbxDNy6DmUbQCPCaXqcTA8JwmJv63zeYWbE3pjUEjp5/wr7GgPpat5x8LRLHcpQGLzrK7+F2m18ae95B8ysekpHolGz+Y2HrJG+u1bmM41pouIWMBpqNFY4Ky2rGAwUeiKVrhc2/XZpwWVD0ZcT2vdbm0uWJyzbm9sh56L1rfOeu5KzKuVJuGS4V4wI1DbXQFXL9RKP3aU6x1zhQ7OGauUfKKGVk3KZkbiQaQI62ioeme1ef905p9zZLANc2/3vf8W1gUu4GBxLe+CTamfJyXBQGRpNLZAw+iHbEQ1PCd2L2wZ6rcgPDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42TxjWWVF52+WjX+vXTK/F5rsdLUfNrhRilXbJ+LOJc=;
 b=pQabNLJo+8YeIctQqIypQMr4tzoZL2x8bZW9zaHxk5Stq+ppNhotOyQ3xofftkePEMDJZNQcBXc+GNIfpE0tMXFIt6ktDLr6yRP6dr1/v10qL/Ab49EsBYGgwnqkKVEBiLRH5LRWONvsEnQkAfr5eJ75Ecurx3+DReuWBPfVA3zjtX5hAfkvpN7mb4HYV6+NCOSwFlqhwQiTz5ldoITaJl5SBKiT0zqDRRgmDpmFnKpcnUj/iBPvARKb4rItZjJ+/uLA8Y8wy9MJ6IxsKI8tuLY/X1fvqwJNTokaHu9W+4FERdLwmprMv+c9ZWprVPk5P7GRDRP0Hm/c6xmzLENlXg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB4PR08MB9261.eurprd08.prod.outlook.com
 (2603:10a6:10:3fa::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 1 Oct
 2026 08:26:44 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Thu, 1 Oct 2026
 08:26:44 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Thu, 01 Oct 2026 11:25:06 +0300
Subject: [PATCH v10 06/18] vhost-vsock: block CPR migration modes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-up-vsock-vhost-v5-v10-6-8c094843e98b@virtuozzo.com>
References: <20261001-up-vsock-vhost-v5-v10-0-8c094843e98b@virtuozzo.com>
In-Reply-To: <20261001-up-vsock-vhost-v5-v10-0-8c094843e98b@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, odaki@rsg.ci.i.u-tokyo.ac.jp, dwmw2@infradead.org, 
 peterx@redhat.com, mst@redhat.com, sgarzare@redhat.com, 
 vsementsov@yandex-team.ru, farosas@suse.de, mark.kanda@oracle.com, 
 dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, 
 philmd@oss.qualcomm.com, bchaney@akamai.com, clg@redhat.com, 
 andrey.drobyshev@virtuozzo.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR07CA0284.eurprd07.prod.outlook.com
 (2603:10a6:800:130::12) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB4PR08MB9261:EE_
X-MS-Office365-Filtering-Correlation-Id: 0900019c-eda7-4d43-9b48-08df1f95b88e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|52116014|7416014|376014|1800799024|10067099003|18002099003|22082099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info: SsoEbXNhxY4CMUA0bXdVQnncjsmQTzgd3z3V3VaFtYq/dN7e6TlRdbGmBPkIdihkiZWjwI/d4GS9QDUwTkVJHi3eVvt27ztGhBQo+oZMOyzg6oS+VZeW6WIf80jK53jDb4SEqG+DsQyI2WdOFAvQkGdXkJIjSO+vCW/1qGlL4rSQXfhhRClQAnPggrBxksCEKQOqneB6+nqu8Xg4XC3B+q74QtvXi6+nMJjQu8UMzOq/JjiOyoCMjsLv5+NzCro1qWUD5x8zO+HWUZZzSDe6iO3zA1JMM3dxgjytRct5CRcgiXFRnh+2jbE3c1FgQjrXJ2x5wb4MdBtooBfKZlBR22feLwTL/Y9iawq7BLIYe8sDnTp3l2hLJIUiw26Rfk/g8EdgKKkyRprYY2Q9DaHqlxrXvaq61f1DYqMMb7hoXr9SRA8+ih8rxztSSoC852YrfbexjmbXugDpr3Hdn+Qe25JMpRQQQ/ti2whFInA7Dd6kDntyczPY6DsLNrwFkP8X/ElqgjXSdf6yC8f2Uq6y9df08012/EpMGjZ+y0TlqPmmjv5CWB26BrJMVXs4wi5aUqdB3kfSfUI57TuSBktNmvJQq9Phoo12u7sMYSYaelg7Ht/dyTAAjEvl+XJVywgM8xYikGjndTouiY5tZqTm0/J3LHw/haEuFv9PHTrO+RDHjUwPiV0cFHx7v8a4XGVRR5nFI2XnDGyhy9mnKCbEabs+dGfRMf8426kiB/cyxb8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(52116014)(7416014)(376014)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NE1vTXYvLzZwVUlxM1NVdFdlb1NURFRJSXJ1dTlZUGtTZGNsSkU2WHZQNFlD?=
 =?utf-8?B?QmhJYit4ZnF6NWcrM3VZM0I3QVQxQ3BkeURvdTVpOFhXeUVaT2F2UU9ZMXBp?=
 =?utf-8?B?YXJlTnZKUytLUHY0b0g4alN5c25FSWxZWVU5cS9TU1RYSkRrajZxcVBkaC9X?=
 =?utf-8?B?Tngzd0J0UVNTSUZYYitTekZWMFZBeFNvbDdSR3NtclZkOEViSlRScDBsNXJa?=
 =?utf-8?B?akNhY2lkdUNVbmlzZlJpMWFSaVluMU5YR3Vva25DT0d1NUdScy95SXoxMTFv?=
 =?utf-8?B?c3BnM0Z3WDQxU0xrQld1YU84NnAzazhON1pXN1B2MjgvV2M1RkdoUnpPbGhk?=
 =?utf-8?B?YXFSZHpYcG1HMXkyNG1BeFNrMWtWR0t0a2Z5R0Q3b3g5NitPODh2aldUY1Y3?=
 =?utf-8?B?bjV4Y0FLd0lRN09nODZMNXpvclBCZTl5ZmRtWmZRQTMrMjhpM2o5QkdXZHdr?=
 =?utf-8?B?cjVjUVpHN1oyUXNlRThHcER3RnQ1aXZ2RWFqNjduZldiUkpPaC9rQXJCdkJQ?=
 =?utf-8?B?NEZIYUdIeUdSeHJYdnZiTWhrQ29RRmZaNVRKL0x1NGVIL25iOWhTYkZyMW5m?=
 =?utf-8?B?QWgzMk5UQXFjMUNCK1N0K3VSai82eFdyWjhQTFdZZkFxVUc3ajM1QzJodUhN?=
 =?utf-8?B?aXJ2SDRXK3hsemc2ZWdQOHp6S0t3Y1IrejlIaEtUTUN0alpXdDk1YXZYRXRV?=
 =?utf-8?B?RElUaW5TUm1EZkZFT1E2U00xOVROVU5aQ1RXYXRObjRNMGdyZjZZUnRJQk1w?=
 =?utf-8?B?aHpnVU9rQ2NEQlROVDQ5UFBoZ3MwMy93Smh5TS9HRVlzSlZIUnV1RzBEeEhy?=
 =?utf-8?B?RzkySUdHcU52ZnZ3NHpxbkVYV3VuUzhOVm15VkdxY3p2cWVEaE16NE80a3g3?=
 =?utf-8?B?M0tBM0hpMncrNU9xc0I2Zi8xVnMxRTRXRVZuSnlpMEIrZHJrVE93Vk05aDVo?=
 =?utf-8?B?Qnh4UXpUeVBOZlBESVV6aHRUOVFTRDU0Y2JaeVRhL3Fkc2FYSVd2Vlo0dFl3?=
 =?utf-8?B?cG5LUEZXN0pwV1JLYVZVMnFqN1o5TFZJU0ZNT0JJNUMyZ2Zybll3K3dEejBo?=
 =?utf-8?B?NVZtc1g3Y09YZEZLMWkyaXdrYXJLc3hsNEZvaStiMk9qOUxyby80RG9VV09J?=
 =?utf-8?B?T1pqZUNDVmNmeE9GS0g5RXJpQWpBT2w2NmtIYkE0UVA4QlliRzFpMTFmUlA3?=
 =?utf-8?B?V0JQL1FRWFpwWkl5bjd2Mnp6Z2dpQUh4cGpDQVpnNktPV1pQOWFMZGtmZ3RE?=
 =?utf-8?B?b3dCM2NLS2ZVeEpmUHlxK2RZcnVsUGc2dm9nUlR4cmpvV3Z6bHNOcThaOXIr?=
 =?utf-8?B?UUYyMzgrdyt1OE9Zd1NKYWZUbldoVUVqNFRXOWdaUkFqNmxEbE92MlNNb2xX?=
 =?utf-8?B?Z3NxaExrT0U1Wjh1aHFDWTZLUmV6ZFhodnJxTS9hSUJha0lVaEx6VUpMV094?=
 =?utf-8?B?TzJHbXAxeVhSbGlqYlB4bjI2cmhYSW1COFo5aFdzeWlXMmVZaEdoZjhXTmhG?=
 =?utf-8?B?NDhYbWNPMFhNTEJRL0xHQU1PQ2ZQekw4MHdicmQ4OUFhMTlkN2NtRkNSRUwr?=
 =?utf-8?B?UmZweURQdmR5Q3RJMVA1WFVWYjI1d2YxajFoR3ppOVZlL0QzRDFUWmJLNjVu?=
 =?utf-8?B?bnZSKzRLRStFWmt6emJQUG1jeTJvZHlVYnd4eTl3b0wrMlhDRlYwZGx1VmhD?=
 =?utf-8?B?OHcxNFBDdWRUdGZTV2lDMHZsb0NrcXVrNDFhbXk0UVVCTjJsbHY5bWVWSVRE?=
 =?utf-8?B?M3Z2eSt3emhGanM3TFk1WHRqUFlFaGplUXpoMGhkSFdqdG0wUnNPZ0p6QVFn?=
 =?utf-8?B?OXcvSFhhKzJDcWx0bUxwYWFDa3FPN09xTFpzVFY5TEYveERucG1jekZKSUtW?=
 =?utf-8?B?bGZZQjRPOTh6Z3laUi9lZEN3TGZ6S0VrZDBYQUpSck5sUnhBc1VWaE9EaUhK?=
 =?utf-8?B?UUxHdTMwRnF3ZGY3cTV3bHhCcndrdTAyOGg3Z3F1ZDhJMENONXpQTkF5TU5S?=
 =?utf-8?B?YlFURnJDN2kvZnpERmt3RzFkNGErQzJlaEpZampOTTNiWEFxeGpTcmRjeVo3?=
 =?utf-8?B?Zk9TRWlESGFCQWJWdUFZZFhQVmhuc21YQnZpcVNsVlA5T3JGa0RDODJVUDc4?=
 =?utf-8?B?QkZzTlMxUFhYYXRJcHEvL0NlR0h1YVM1VktZUTFBcURObFJ5dmlMTFFBRnQz?=
 =?utf-8?B?TlFzODlNNHArV0ZFZE9wcU9maUFiZGxGVStxOEFQWVdETFp3dXR5QXdyRzlE?=
 =?utf-8?B?djFEaCtpL3NLL21FTkI2N2o0YzhIU2VDU1dDcTRtTXk5TkgvSC9yZ0UwWllu?=
 =?utf-8?B?djNhdTJvTm1SRlAweGcxVU4rRmxLV2d6VCtjOXArOEVHa21RM1A3QytiNzFK?=
 =?utf-8?Q?VIhrZVg6GgKKHOVY=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0900019c-eda7-4d43-9b48-08df1f95b88e
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 08:26:41.8102 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u2HZsXDHGeKLIgJj261/mafHcW0Y9mVPMDG6e2RYsoCjX3CpfQv/2D1zmLlaNgQIsYcAVJwEVHEhWWKzCmLEr5+FmMnjxxIjnfjrtGcsEqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB9261
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
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


