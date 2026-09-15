Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D74E9C88E7D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 21:03:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6aIf-0002j9-Oj; Tue, 15 Sep 2026 17:02:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x6aGl-0001N4-Ft
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 17:00:47 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x6aGh-00010Z-La
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 17:00:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HjDWx8hz/8CN/Xfh6hKfSkA61Sa4Dgu/wYKDYnLsvvEetpH9/dIeziZtqKmuIYr4Bi6b1+qSrGoS8P2USoWlhkVSothWuZ/huqOKldurKmH81dgq0U8+XvWATT0q+iEWxJ+cwViT8v7mJfEnmflWbFPJsWqpQUVSW+nIKeZgSwFaeOwkAfkg0RrnPBU0zDmecmYD4uxjKo6IwYn3qqi19cg95Naor1aEhPcud+5pUWMxGrnnbEJ2/2Hy+n0KLNux7YBGNMazqmrKzF2aGxhqUEl2JKAzLOVpJkMAVXA6Bjl1Ow2AlSCM7PoBFw7WL4CAejLsQkrDmhYVfzUNf1T7XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42TxjWWVF52+WjX+vXTK/F5rsdLUfNrhRilXbJ+LOJc=;
 b=V2Rpa8U9cJaHepvoHv9KHvzEsDmFTVVqeJQqpxa2bUsOv+sXL2mGuJSVhZHOUYPXuUCsjuEEVW/H7zZxY9t2E0xFK23g70CNeXRnSNKci285XrQzZHJc67itS4clXFNkzARDvluT9xPnqcbh9XfXc/RMU9FJHyki9QkOnOWxyBKNPJCI3HGXG2uyt2RZj8iorPt3TZAp7nZHE8NXZBTARgWJRNkrKUe0DSfoqUrb4g2NF4wcSxFfRdf0a+lL6seuqFi8ZvrgQIRLXwDPK/Eg6nnNChYW6W4IzpNlMpHpL7pUzZ+13HlPEloVaD+EYie7Bu+tT8v0r2xuVENOXPruMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42TxjWWVF52+WjX+vXTK/F5rsdLUfNrhRilXbJ+LOJc=;
 b=fivGqIuzHXVqr4qlCpu0YLrIezC9+1k+voZpRrNgLHVLxlnu25al1eW0vR28YCBlGE5gy6Mjv1RVIZu7EW1oQxvNZBTLiW3CM5T7L6dfB+XsMt7L3AIq2O12LDUGf2xHAOtKmHtJsLAAd6CL3pmcnX0VkawLFquosTmKGR1njlzw/TwHgSQ5RCyLOXbMw0dZiZkDfMl/azYhoJ7/2FRnwk816W9Vjlf3Mo9MEpGIMuqZDol8mG/qcSSQwimFbiEcZl30/qcpv7rqHAgLVniQI4l7n2fRFsheBdq7eKvqJOZmT59qFmrtYSidGcCiMNx4hTN0f8JvDe2xRAKptYtM/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PAWPR08MB11454.eurprd08.prod.outlook.com
 (2603:10a6:102:50b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.8; Tue, 15 Sep
 2026 21:00:33 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 21:00:33 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Tue, 15 Sep 2026 23:59:41 +0300
Subject: [PATCH v6 05/14] vhost-vsock: block CPR migration modes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-up-vsock-vhost-v5-v6-5-4d31b2dc6afd@virtuozzo.com>
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
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|PAWPR08MB11454:EE_
X-MS-Office365-Filtering-Correlation-Id: f1364703-0dee-4772-d0fa-08df136c61e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|52116014|1800799024|376014|23010399003|56012099006|10067099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: toUW65ufBQMOfbFfRsPFs3BBo060s1Wpmmwf6P2jAbxSfGIOAYqlwA/NYnDtewPF7tTc/ONdFiQb6u1YC7BncnW+PAmlOrHUCLdVnTzNIBKvl7FigzkAdHrfR5koKExCW6YhiE63kXmeHtT34TiPhXexAdZmEw69xDW5PoxYHn+KNdwzqsghrqYkYQZAYdHbRhIF4JcD9MJckyLllXuV6CUZgb/nH6O735/LwmvR7yH69vlDutV4MD2pXHdPDRVBCggV8/N00BKjH8e+XMYluMaKB36/hkEQYM+ObB76X05DyjuPZ6v4kGGlkWzO647zl/vG37IB0D6g83mCwujBdwLj/YIh0xl0Q36HJ+wVwmTLty2CEBHU8RFPhA0BBRDjqtkmokNhcFKOSXz8vt3dcRG8bBipphxrnPlRJA2SCtv7RHrUFcuYiFXO3pU/TzRwpYx6RZaZPfhZJ4F2caFv/yTRYKtNKOwXpznMgsgMdU+skD13TAp6kFqgv4j93jvu3jDkI93+rsTZLWau01fs1tTsKa89NYavnH5WYrjuIyt3GuSartCZzMvwog1l3G+7/qLT5HPuslm7pl64YqPsOVC8onxgV98YpUl251w914DtlR4bsNUGE2vjyRu9uWxP5DQCWWEBL23mjzwy5ZxQoRdXj8LAnXke3X8gWM2CX2Pb45eXtz1Es058obMv0YBICOWQ+E0yDnJlnACAm5guzuzMUk5Ebt7WNhwlItZxkKY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(52116014)(1800799024)(376014)(23010399003)(56012099006)(10067099003)(22082099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEN3MFNNeTNhVDlIcmZQTmlNZWVIT3dmL0ZVQnJITHQvK2d3eG5zRzNBcmkr?=
 =?utf-8?B?dHJ0N1djU1RoTWQ3YXMvcGxzT2llQVI0b1Rkb0dTN1FqaGRoSDFVbnRwc3Rt?=
 =?utf-8?B?TUlsejFra3lWVVlTRnd4ejlDOHE2aDQ4Nm1lclNLNUxFRzFwVlZKQTFwNmV0?=
 =?utf-8?B?anZXVmxudjYwQUVubGZ4UCtReGlZOTg1Wm9NV3JlMHV0dFNLWFNQb1A0ZEtI?=
 =?utf-8?B?RjN5bU42cjMvc3ZGb3c4S2ZmOE9IdSt3OU0rbTFRVkh2RjdIcnY4RTJTTngw?=
 =?utf-8?B?ZFV2TzBHQXVBbDBVSTZ1aEk4L01veC9QZ3FPRnZWWllxckRIeWZtbUFscmlK?=
 =?utf-8?B?MGRTbkZaOWdRUWRJb0lFL0xlRU5tZ1hSTE15N0grbS9NQ1VjVnNhT3pUenc5?=
 =?utf-8?B?Yk05RmtwSEtLWkFDbVo2YlFTVFJkQno0dUluOHkzc0FQems4L0RWZEx6cEl0?=
 =?utf-8?B?SDlyTTIzSmJ2UnZjZFJVazMzakt0aDJYMU56TE0xOWo0MEJYeHpSU1ltbjYw?=
 =?utf-8?B?eGxoK3A1SWFQenluVHVLODRsbG9xMFVKNm1DOXFCNU5uejVpNERtSE05Qzdu?=
 =?utf-8?B?b3VNZDNtdE5ONnQycm1yUVFpbUlPT2NkZUg2S0c2U2x1VDBTOGlRMW5RdTVM?=
 =?utf-8?B?YlI3MHZhblRkZTk5eDNzWDBlODh3ZVZXZHRycjJkU1ZJU3RNQ0Ixbm5kc1Jx?=
 =?utf-8?B?TEtBMWFzSUhoRUVPR3VxQXZQNm12eTYwZEp5cFY3Mm92dFFWS05CQVdSdXR2?=
 =?utf-8?B?bFpCclM3SUplZDVvcWdOSFU2dUdGRHZWNVlqdFZ3MzV5QnR0bGhFZWVzNE5y?=
 =?utf-8?B?OFFKcU1RUHRsRkxOVGt0Z1J3ZkpKc1lmdTc2TG5tNWo3NUsxRmpZM1NMRXMy?=
 =?utf-8?B?dDNaSzE2NW5SSjdLeFp5aGhlOGh0eE9RK2t4SnJNR1RrYjU3RS9Sc0NJQlJt?=
 =?utf-8?B?d2xxK2s1Y2ZVRjN0YlkxSVcvOGpPeWUxbkdqcjlGclVrNSt4Y1Z6ZiswN21P?=
 =?utf-8?B?SklXcHlONGJQaGovTXUrdm1mUnFKTXYvN0dRRmRCZXMzeGwxbDZ6SXMwUWZN?=
 =?utf-8?B?TytTZVpwVGFsSXpKQUZhNlRvRkpTN2k3c0JZeTJPUGhuMmFVRVoza0hIUElk?=
 =?utf-8?B?YU9YVnVMS2pKZjdNWWVSNjY0ZXJNQm9VMjN0VWd1cEErcjhMNk5yZFlIdWRl?=
 =?utf-8?B?QS9OMXl6UkxpZnc4eXlnZzc2VkdYdTZyZkZUNjBPaEcvYnd4N2VwRDlZUzEv?=
 =?utf-8?B?QnpEaWJlUWNKZ29WYitOMEt3SkdDendHczJIMlN5endtTHhPai9MYUVsbjAx?=
 =?utf-8?B?RHlDNXlNc0xRclptM25Gd1Bib0MwaUVDZDl4QVlsR1ZiTytvekhFbVMxdm9R?=
 =?utf-8?B?U0M3YzlTV3JJdWRzMDlrK3dXVUhsSEVRVGVDdGMzejRpNGJYS3pucklFRHAz?=
 =?utf-8?B?U3Y2Y0IxamFkSGpPUzRPWFZTU3VtQ2xMM1hNTjlsbHFuRjZIbTRpUlVXdnJo?=
 =?utf-8?B?WFNiM0FJYVNPSGhPb0lXejBwQmoxeHZtaDVJRmpPV1poWlRsNXV2Z0NxaXRr?=
 =?utf-8?B?dCtZVFZNMk1iRGFoZUtuMTY1VzBHZEQ2T0VFNDB0QWx6MXM5dE9WZU1kQUpr?=
 =?utf-8?B?eVhoUlVzdVBUMWJqUGsrRk8rdmFKYzB5MWJaemt3WEV1NFpHZFNZUU1mLy9Z?=
 =?utf-8?B?NVV3czlYREhuQjFWVWhUdndNWFBDS0d6ODE3dHZGNERVNC9iMk9RemZjS2tR?=
 =?utf-8?B?TmlUQWpURlh1Rm9qZGpJbkwrVHp3WHBmbnE3d0NUb2Vya2NMZHRNTUltb0Fp?=
 =?utf-8?B?YWphUWFkYlAveEM3N2ZuN1lqeXNMUXF6eEtIVndHSUxVU1k1OGtleENaU3Nh?=
 =?utf-8?B?bGlLelRZSllFV1UrOGZYOXZuNjIrY3ZDWUhBRkJkQzZSTlYzM3RDVjh1bzBz?=
 =?utf-8?B?eUZUd0RMV3BpZXJGdTY1YjNRWTBwUEs2S0NhZFhURWlNTTU4SmsvZVVIcEow?=
 =?utf-8?B?aGlyZElKTnVGTjRsb0JEemlqOFgxVzkxemV5SHNGUXJPOG9JWHFsSUpzcVRs?=
 =?utf-8?B?WG5mRFRmaUs3ckVCZzNVbE1KL3Z6TnpFcUd6R2ZqNnZETjg0VkF1VUNKRmc5?=
 =?utf-8?B?YzR4bkMwVEpmMXk4SElhbFRYZ0oxMlBQQS9YZ3l3R1RSVm0vTVhUeVcrM1Nw?=
 =?utf-8?B?L1VySDJVdHArK1FZMTNZZ0RXQVJhRURpZTU1Ukw0YnpwUXVRM0ZDT1VaNUFy?=
 =?utf-8?B?M2sveEVBSmhDUVhERGh6bGJBeHhGY2lkeHdTUm5BNEJjUzFPSEtOUm1oVnhZ?=
 =?utf-8?B?S1NHcnNDUkpwTDVXNzRJRzArVnR5bHJMRkNHZThyZFArR3NhYTdvL2tJdElR?=
 =?utf-8?Q?O+NPrTg1rQ9NHiAk=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1364703-0dee-4772-d0fa-08df136c61e0
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 21:00:33.0443 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T3ybeZdbygDT42piafYenRDotA057gDCk8vz9BDp+Xxv96q4gqg9bPlpF4yMlsG9Q/xVCYCOPTZyKXtG/VRRrynmPVfL8THMqq5V1je6NYI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB11454
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
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


