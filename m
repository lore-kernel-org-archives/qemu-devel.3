Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB6D4CA600B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 10:27:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xElKZ-0003ZC-D8; Thu, 08 Oct 2026 06:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xElJw-0003Fa-Lk
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 06:25:54 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xElJt-0000sa-VJ
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 06:25:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jAYu17/K5PBME6CIgKv2JCMxNk+bpdRbgee67muj+wwiEG1stc66QfRrY1Dat7WtcJu+0hg0njK/IreB2yZUSh7lsoQ9a5VCaiM8TPGB1Mdr7IMFWtjl1qQgFgCFOza4dRg0wsat+AuOE0HtdnkpoCeP98GLwj7wYMLM9dg3tP8Uzv7G0kELv6yix0DIbqy6pFhXbC2C2Z5ufJs6za+TXIHXT8lIMN76RFG+bby3cJ5WH2yDjhycH8ywH+EGtntVrQ4MKb1W+pFYn9xm2l7/U/0RQwSn1HMZgbfHZdjq7ULnXhbxg9YOT4sFDX+qiFRFH4UIFOxe55UbA4bdmsaqPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5ksPgqxpkvwMZR46juSzPb3Jx553hY74OuSgtWMf94=;
 b=C6KwrhpIrKntE73QGf//gE/qoSiNwHB8zWK4HggQ/ZEli5BEnw9K7Yygs5XNTK+CXCB+UPE8x6UgsENSMgRTIU8bnqCNomhYWjF+I7ylYViUJcaRd9DyVcAs2Xat4AuDso2G5fVnqxDj2kYNDlsFo3gL8jdbNqH1RRBASD68cXO0xyHvHzxBOxNJiMlFNn+LiH+TNzsjXNvZ1Ld+y7/g8i6dYeVwGa4FggME8056gnBTguML5/6khzge3uJtVtcmRF+ixYYJ2T6Le7iwtVIqcO6YxeZbSBwgBWF9dkp4bGap5dzZiA9Gpe+sU/AxG49VhO1T/6k/+QPDiOa1CxVqkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5ksPgqxpkvwMZR46juSzPb3Jx553hY74OuSgtWMf94=;
 b=pREDbm8WeI1C367vxkpvRc3F39hPreDRQ3+Q0gOg044l6wnxc12ISjbgngQSXEh8qsD1L6knOgx7uGv/Jty8FF+XiTRNAbS/2FnGioEdeXnB+LPXVakyFfpZEiHot1L4LD4NT3SRRDhn/ik9zBoGmU83ly0acS4toNiGa7TeFeWbzvQg6xT8rLCO1RpmzgmpdyXeBnVBrG69ScRwxtZR77vk40vRdEVXSfqInpCbfYEn1oq74e+PUNmRzI2uohH7zY+XseMNBjmCmkYLbre1la5ciMzdJ6SrZFW1bqkX/ZLlgcuQZiAkR+H8qu8aaPQwLyeUmqfkI6JB18rZefV7Mw==
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
Date: Thu, 08 Oct 2026 13:25:32 +0300
Subject: [PATCH v15 08/22] vhost-vsock: don't reset connections during CPR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-up-vsock-vhost-v5-v15-8-301b73b3f843@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 74304911-dcdd-4937-05e6-08df25267ef8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|52116014|23010399003|1800799024|10067099003|56012099006|38350700014|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: NcP+VuM2yqy41003Z9iou02KMkElBaF9h3OV88t9zC2BY/61mKUZzno614jOJcw8MORtpM8+pPXfdE8hRlZODv8QRBW9pYdSqIk7ANb+wvpq8xEujzTfupFQAdeVlO/Vizx6FU2QZDZjW6vnV0/bzHCIuPesavZw8INK1lZ71uGMnzDJW4BhjmZHt8NReiIsmsfJVdCuN7j6kmhNDoNHxuDMP6XAdagisG4juJrwzArSX/9ndoDrW68RUOpRruFw77H3DcZ+3Eo7StjPLXJF0gzsFqx8LQa4iCAoOygEia6GUsATVOlQtjWFCaSZjlE0w+fmT+85jpKm2VAUHhUBDjh5jW1cYcUhr68IyclHuEfvEzWDSxTMTyUxV/4K+pCgw2szKkrZy5g4N877w4PqTnI/1Zd20eC7neyLjluNWGLvMkQwSnkjmxrNXK7CoLBIYZMq7Ga3m+inks7TtutvEcpVAgFe2lCcR8JCLX7u+j5AM7nE3JHeyLq2GIUWnqq4S8RU+mY5oHFXPRjMB6LppDJwjxIUw058aFy3mIvJdxiE2MCm2jKD5koBelkZveK0kwIt6wVS2S6mN9Ruf335yWtuTmyCSmdDjxdyLhH42fmXuyieGX45svDIIQ1ohd1awSH33oJTUvjtiMixOZR8vLXlDAF6u2+JcQh4Z9Wc6EDBmHCEJv+ja/QCniXtCo8SWl6i6X2Oti4l1aiDRo1hAg9kfzU3lOymHIWuEGCJ4S4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(52116014)(23010399003)(1800799024)(10067099003)(56012099006)(38350700014)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0ovbWRvS1paUnJFUzJIUEpjdERvR1BOWG9MQ2x3cngycG9aWlJCNW5CYjF3?=
 =?utf-8?B?TW9WZVR5Nkx3VElPcU1SVFF6V0pzcXJwL1RrVXpFMEhsM2NKZXVzb0JDRXhk?=
 =?utf-8?B?aWpHek5TU0tNaElpQm9sUmh2ZG9ldmlta1A1ZS9HSHhBT2pWd3NqRVBHM2JI?=
 =?utf-8?B?eGVlTHdjU24rKzI4aWdTY0lsMGlKSlJCaE93aFRPNWRkS20rZ2lDTzFzLzFJ?=
 =?utf-8?B?UjVWSWVLanBYeWFkUHpxZmFnSFJ4Sm9kS2RiU1NNZ3V2L2Via1VZdGFUMnpD?=
 =?utf-8?B?WGE3KzBWSnRrRllmTE9ELzVGODlOMUxNZG81VC8veHpCZFB4QWxFMGRKRFZn?=
 =?utf-8?B?d01UMWd4bHkyWjQ0N3dSajZZSmFoUkRDSHB1b0NoMnQ2ejNPWUk5bExzamh1?=
 =?utf-8?B?Z2JSVHZMdGVaVGpSRFVQRmo2bjJaeUxPNjN1ZTVjTUthZzVMN1lhWk5iRTJO?=
 =?utf-8?B?NmJ4eDVVY29tWXNTdkZLb1ZWa3VYWnhrQ0VlQnIrWm9jZ1RWTXVERG9Ub1dP?=
 =?utf-8?B?dFFHbUpja2hmcDhuTk82czhBdUIwOFZjNmEwdzRkQWNsempGZFVNdGYxdkVu?=
 =?utf-8?B?QVhKU1A0UVF3ajRwbVNqWmFUME5Yci9kcVdkeWtWZ05kbUlxdTl6eWk0OGpS?=
 =?utf-8?B?a0NyTUlWbEMyb0N6czJlODRCeTRHYWdtZUlpUFlhWGhuY1BxUDUzdGlPeEQ1?=
 =?utf-8?B?cTA0NmxmTDlURDBXa29ablRBSFc0WE8wNHdqZE1VN1I5emlpUXdRMXRRNyt3?=
 =?utf-8?B?VyttbVlRVE5IZEFMdFVXZi9qcmRVU0VSM2I0c1RUSlN4SWNEVys1dmR2cWhu?=
 =?utf-8?B?RXE5UTBsZllXTHU2dmNlTTdDNDlYVEkyUnFuQnlyN0hqbjJPdTMrQlgwT0Mw?=
 =?utf-8?B?R2haYkQ1TTh4ZCtpdlNaMHZsTE56TXlvRW1YRlhHb3pXMG9YTGNMNXBzQmhL?=
 =?utf-8?B?UVpsUStZNklZYTJ3cjMxMHBlYTZTSEdKb2R6cTEyQjluL1I1VHRLWWZFb1N2?=
 =?utf-8?B?L3VtTXRFQ0Y1YlVOaDlDY055aDg4ZENXbWJkU2xCcjlXWm9OTXpHd2QyNHF6?=
 =?utf-8?B?RFpTQWJtRldwS2VoZVJTUHdkLzdXeFhGZHBMbGtIK3BWM3psaHlZOTNTVkU4?=
 =?utf-8?B?c1htSzlTUHNzWHE5YUZwZ3l4ZXdlWHQ5UEtySm1lSzNSOFBQUGVxQ2djT053?=
 =?utf-8?B?dFg0R01VbHdmdFZjK3l3V25POHYxb3RVdVJOd0o2eHdOWFIwbXRRalByM1ha?=
 =?utf-8?B?bXBmVmIxUU1Zd3VOVjJzNm85ZzJSNUpySE50blpYdjJjWlBxQ3NUSCtNbHpL?=
 =?utf-8?B?SmlUR2NTUmJKVXcxVUpQaTdHa05qVjZHVHpINjVTWEc3VVJiRHJwUmFYeG9i?=
 =?utf-8?B?TUR5Tm14eGtZaEFNRVY1bFhxQUtoakxCTXk4RFZ2Sk5ZL0dIN2txYnlkNWp5?=
 =?utf-8?B?cktleFJKem5Kc2REcnlBcEVnYi9sVkVaVDlKdzVEODFQZVB2SW1iUTFlMHhD?=
 =?utf-8?B?R2tMQWZYMWszRzAxWE9mTXNzSUl3Ry8rUkx0c3BZVVA0a0cwZVRQdEliQTRt?=
 =?utf-8?B?NHZNVVRHZHVlNVJoYkw5OCt4RVV2VDNNV3p4a2pQazVkWGR5cFkxbjNjeC9k?=
 =?utf-8?B?R2dTWlZzbU9mTnRFcHJVTW53d2RXSkZENDl3RFlUQ0N3T0hTNm9qWm4vaDBz?=
 =?utf-8?B?N2pUbWZBMEk5MzVNak5KdEpraUprSTJMeUdDQmZVOEowNWJqUGpkdjNJcXhK?=
 =?utf-8?B?RkZoTitqOWRCNVpXdkVGTk9Cd1VDVVJmNVozcmlaRFpjR05XaThENlcwRGhy?=
 =?utf-8?B?b2hwcTZuTldreTJyNU5CenIwWVVBWXJaUWJnTStwR0FFR2owN0h6eXpuaXU3?=
 =?utf-8?B?ZWxJR2JVY2djeHEzaENmdWZXblVHdkZmNTA1dEU0elBlZ1VUY0hvSnVYbkxQ?=
 =?utf-8?B?aGpwcGY4ekxOd1NzUkh0RWRISGQvbzduVWJsOWluMXRDM2U2SCtZK1h1OUNE?=
 =?utf-8?B?bGxnT2M5eWRveHI5OVlLUm1HWFk4SzY1Si9WOXVCNGxYc0NmRHFFT3FXWUlO?=
 =?utf-8?B?M0ZkM2tySllobWRlRk1vNU53ZTgvcTFUejVWZnU5dnZFM3d2c0tGY3hTN2ps?=
 =?utf-8?B?Q3B3QjFKK2tZL2VJSzhwYlYwd0h6R3daL2FreVJ1RXQyTHVraVhEQXJEZ1FS?=
 =?utf-8?B?dU1HUk1RY2tZR1M4N2E3TUZ6bTVWYlZiZTRmVWdueFp1dlUxLzY3SzVPMkcy?=
 =?utf-8?B?amExaElCVWU3SzdXM0ZWaWdBMng4RForM1hRUEZkVmFoTTI2WHF1Q04vU285?=
 =?utf-8?B?RnlQREVUWExSZHpHbkx1TFVRWlFzVGt2MTJkQmtkOTNwRy93ZlYxbEd0cm9H?=
 =?utf-8?Q?LwVxRukH/aI+cR7w=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74304911-dcdd-4937-05e6-08df25267ef8
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 10:25:38.1256 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VmfNVpwI83mjXP0yQyPcsNRr3EihuWqYle25Vodkkw1dR3qrsNpRese1ubk5tKm+y8pFcVugztu+wbzpROdrCmVqeqb3a5CZM+xHwqReLXE=
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

Migration target with a vhost-vsock device in the .post_load() hook issues
VIRTIO_VSOCK_EVENT_TRANSPORT_RESET event to the guest.  This results into
the guest tearing down all its vsock connections.  That reset exists
because after a normal migration the cid may change.

However it's not true for CPR-style migration.  In this case cid remains
the same, and we want the connections to persist.  Thus, let's customize
the .post_load() hook to skip the common transport reset part in this case.

Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost-vsock.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index 503d248a617..c582ac9fcc8 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -20,6 +20,7 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/virtio/vhost-vsock.h"
 #include "monitor/monitor.h"
+#include "migration/cpr.h"
 #include "migration/blocker.h"
 #include "migration/misc.h"
 
@@ -110,6 +111,20 @@ static uint64_t vhost_vsock_get_features(VirtIODevice *vdev,
     return vhost_vsock_common_get_features(vdev, requested_features, errp);
 }
 
+static int vhost_vsock_post_load(void *opaque, int version_id)
+{
+    /*
+     * Only reset vsock connections for non-CPR migration.  For CPR the
+     * guest cid is unchanged, and the cid-change reset would otherwise
+     * tear the vsock connections down.
+     */
+    if (!cpr_is_incoming()) {
+        return vhost_vsock_common_post_load(opaque, version_id);
+    }
+
+    return 0;
+}
+
 static const VMStateDescription vmstate_virtio_vhost_vsock = {
     .name = "virtio-vhost_vsock",
     .minimum_version_id = VHOST_VSOCK_SAVEVM_VERSION,
@@ -119,7 +134,7 @@ static const VMStateDescription vmstate_virtio_vhost_vsock = {
         VMSTATE_END_OF_LIST()
     },
     .pre_save = vhost_vsock_common_pre_save,
-    .post_load = vhost_vsock_common_post_load,
+    .post_load = vhost_vsock_post_load,
 };
 
 static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)

-- 
2.47.1


