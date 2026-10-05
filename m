Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F09E7CA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 15:02:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDkC5-0008GW-Cs; Mon, 05 Oct 2026 11:01:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xDkC3-0008FU-Ca
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:01:31 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xDkC0-00056n-RW
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:01:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MWtUSSjopNTbd59Zn95rX+zVdZ9Vfz6XmWwTGv9YIYZYfytBkkzMhCTsPN+EIHOmtRgMI7Lnvg3OA55NPXTWZgn5hBHAwyqD/pDW6UmT3HcI1H7HpT3ZrHrq8DVJrNhhranDYmutDunw2jya+29VK+H5K1yvlo+YW8v+VlZfJz67ZCtgh7a+IENBbZ3+BXyFa1bvHAMxNpUgDdgn8RqtE2H64ZLy18ygVVOadTgVhH74ZQqWVyJ5ONlJUjtfb5IJcvcxM/Kf+W0V1tu9Oor+4o0u12oN57PBFpalLwP7/afX/TtDu66HOrtzyfkx6gbPCxZz5jIYUkFyOFUKlRX9tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5ksPgqxpkvwMZR46juSzPb3Jx553hY74OuSgtWMf94=;
 b=xX46G+2QJm7veLX0XrN/VXipXSSbLF8Yt0Hm6et13RdUorL2HgVx7nn0k5+Ham0SyH77SODdNcj2hi7rBvd3KK3wmz1EShzjfe+L2KlDlT3nsEw9mx39VSwIh40xogARUijDbpk1a5xHvjPOipU8+7f5A0CB8546FW+npVtM0Bpy6HZ589bq2zGKNoLj0oJ1PkOwnyLNe6UYhbBc1FkmJ7716m77sdoTeX+A9sESag1lxTNVjxC+6L/9z0Relks9tSA6uZzO7O1ztkkITNIxLjyBzhBD8N4GwJds8n9F51MzSvgcw8lxFqaM4jxxqShT9pPMj25/tl4vyJfXUSWBug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5ksPgqxpkvwMZR46juSzPb3Jx553hY74OuSgtWMf94=;
 b=ZriUz8SeQyANLJkvU19H/Srff2WP5OyCE+xYMLnIMGiTl5X+06E/uzZsFO7piY8SuylSGH4PIJUSiArfCKGrBWRNrVJrqNZ4NMoT+DYWaZR+qIcLl2WEDH550x0hQx1w8V+YRt+q4q2oec86LVn2/qDyc96+/A/t9OHaGY7QBYts/RWWQHdF4En2ymsycudEk/FrSbYeoL3kB8nbqjtX9KqGQRMA7BKLx2SX7erk7kK+OKNfw995lxIUUzhOMOXI9dDSf7Zg8hlVnkP4VUqxUKooXu7Debyz58nETj0bjsyjl9obpmBD43VdJizmGwxTp+sxoeWrK33nmfzJv0zx6g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PAWPR08MB9736.eurprd08.prod.outlook.com
 (2603:10a6:102:2ea::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Mon, 5 Oct
 2026 15:01:16 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Mon, 5 Oct 2026
 15:01:16 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Mon, 05 Oct 2026 18:00:47 +0300
Subject: [PATCH v12 08/21] vhost-vsock: don't reset connections during CPR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-up-vsock-vhost-v5-v12-8-40162390c68a@virtuozzo.com>
References: <20261005-up-vsock-vhost-v5-v12-0-40162390c68a@virtuozzo.com>
In-Reply-To: <20261005-up-vsock-vhost-v5-v12-0-40162390c68a@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: vsementsov@yandex-team.ru, clg@redhat.com, odaki@rsg.ci.i.u-tokyo.ac.jp, 
 mark.kanda@oracle.com, bchaney@akamai.com, mst@redhat.com, 
 sgarzare@redhat.com, peterx@redhat.com, philmd@oss.qualcomm.com, 
 maciej.szmigiero@oracle.com, dongli.zhang@oracle.com, den@openvz.org, 
 dwmw2@infradead.org, farosas@suse.de, andrey.drobyshev@virtuozzo.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: WA0P291CA0014.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::19) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|PAWPR08MB9736:EE_
X-MS-Office365-Filtering-Correlation-Id: 91075f5c-0748-4f16-f854-08df22f18154
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|1800799024|366016|23010399003|376014|38350700014|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 0UfwQwg+KETBcluc2pZs+yiD67YuqVO69s31biy90BeW+sJz33GVsG+c1ELa8FDRb7opvm8dfHr+YOG1eNTSp8cSyJ87W6Sp3fLbcK8W0YapQ0dgghXuyZZmykCXcpTfs35B4XryjuPWBHbbft6BwmxNh3FrsDvj4PVgRrIrHngB+OBCtwJ0IYz2LKhtkARDNxH5hlRpBD/7iyU2n9rB6V0CcqIGGaP8W4RupaCnV75QHKHkTolk462wFT0kcsDNv8EnS8IvcsT8wVkGReqxawMNYU663WBMuSe+hodf36aaheOo0WFyUEU5n/Zf/FU3aKtCAaftroIBj7wEFh2N2I8JWOtEY8v/vdOUKtOzNqbMYKQIwlV//4AjzGBJMLkevgKs067NCJWufvfsojhTpdeQb+dJ0YYMmEFWx6ejxOlniiMWxPKB1zT1MDYcwVSc1qu9gY+/xwLM4PtHxPQaAtQeuhqRdRBwGZ1vMc3d4lxCitoMktdqGNRob+mpVg1Ke5QtFzcAWd9yNbpv8Ho27K06C+KLQfr8W5/dJp0RBHDlwVaEY8+7dfPw7i/QqGfbIUkgH0B68by5KYtNM12G6tCdSrb5UyM7zvtoGa2h8smOY+kRyUecZZDOkd9Lpw4drQkP1dzPIxabuNrWYprg4SZ4wvccoLWN1IjsNV6d543jUGor47PhJpniI5Zh0Upv7ok5cwjfZNWnXcWP+VjM/8n6KS+sCRFN1KngqRLYvgA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(1800799024)(366016)(23010399003)(376014)(38350700014)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlB6YUJZUmJBLzVNVjUwN3JjT3lHc0pVeGcvdmZ1ODcrUEFvZFJrV2RXRi9H?=
 =?utf-8?B?L3lrcTBRQW05SzBqS29hR0ozak1CcnNOM1habThESDNnWm1wTnFVdzBZOVdo?=
 =?utf-8?B?N2ZHNU1oNDZUWDBaVkUrSEtPbjVpNVhCZUxkdDVkcGx1U3N4Rk9aTUxaUC9s?=
 =?utf-8?B?bkp6ejdxRHZZcTljanNEWEJqcCtqL1VKcXk2cUVtMFRNRUVOcm9Id3dJTytv?=
 =?utf-8?B?Z3JPeW9DSTBCOGExK0YvUFlQVnpMNHRwaS9OZDd6MnFUWXFwT2c0OVU3cjgz?=
 =?utf-8?B?QS9HTlJWQnowVktDQ25pREZlTDNZUndld1MyK2hnVmphdXRYUDR4RndRSWFC?=
 =?utf-8?B?M0pvOXB0ZmI2aGk0YVhtdFEvcHU5aFRiNjZsS3JjSGx0a1BQbGFCbUVxU0JW?=
 =?utf-8?B?djJKdGpVZEdRRjR3WWlmdVdhcnQ2ZnhGYUZVOFZuTllRekpsSUxNNERrajhP?=
 =?utf-8?B?ZWtra1lyczlzS2wrV0ZHR3FiMDc0VGNFN2l0ZnhQb3lDdzJPQlducnhyVmNq?=
 =?utf-8?B?ZW45Q05PK0FnMDk3Ly9RSTZEdHIzN1U0cEtMRVR0aVV3RGpMQU9zT0Q2czZW?=
 =?utf-8?B?QlJjNGNNVTJhNlRzSXJuNGlqSlg0NjkvdXBPMjl3bU1qMDczb3FpakE0aUpP?=
 =?utf-8?B?dzhBZitOQzd5UHArWDZqQmJEM2d1bVNQVlE3Q3RGWW1GaDZPQ3pQVUdHMXBu?=
 =?utf-8?B?L0hWSmJnWnJBNGpPMHBkejNDOExIWFBsQnhZRFJkU0tXN0w3akI5US80Mkh3?=
 =?utf-8?B?cUlGWUxTZW5HSEpmdGZrWjBkczgxM0FTWUhHYzJJR0UwV3Zzb2U4Vmt3SXZZ?=
 =?utf-8?B?b2tRZDVqUUVnRFlhcGJubHUvSWZ3Q1VaU1NYZHdrZ3p5K0R3UUxVd25XaWZk?=
 =?utf-8?B?elZLMFgwbG9WUFBkV2VsM3pJQWRPSjQ1TEc5dTQ0dkdYNE9WOU1CYzhzSlA3?=
 =?utf-8?B?NHNZN3ozVUkxUGplSUJ0RHRwN0JCVGlDcFdKY25BSnNCQUhwVGl3eDAwZ3BF?=
 =?utf-8?B?OHJOajQ0cDVCOWFlRGJ3d2hhNXpLQ29XVk9xSXVTekZpaGViSWIvbGhrRWlD?=
 =?utf-8?B?aEpvVUFNS3JORkRqNlJDLzIrWTNPU2h3VUNoL1VIQ0pwTTFPdzFEeUU1aURB?=
 =?utf-8?B?aytUeFV1UHpMc0kyNXhuUWJ4R1ZQZVQ3bExQajlBcTd5d1hoNk1jbWhMeVFn?=
 =?utf-8?B?QWRDd1hKVWhybDZsQ0xCT2JUV2ZyNkV6SXRYRUpXTGNWN0w1Nk9uL0d4Ympv?=
 =?utf-8?B?YTBVVmpmZUIwVnNCUjF5L1lwTkhGbm5hUVIzWXkzbFRuRkp0ZUsrdncwalVa?=
 =?utf-8?B?ekpCYUp4QXlFTkphMmcwUm5ZcWoyZlNxWVltRzJKRlV0dVZZbEdKSkRyZU5i?=
 =?utf-8?B?MjZSSkFSRngySlRtZ1FIRzFrUmFyMUhXL3BqTE5wRXlxUXp2QTZzZy9YWk1G?=
 =?utf-8?B?MVJldHZqeFVHeEdyOXRwdDgxTFcwaDJXU1YrbGRUcGN2UWpzczcvMnNHOEhh?=
 =?utf-8?B?TTg3UlEyWjRSSHpFcHpaNjVvaHRHVHlvOVgyUFRWQmlkRS9TUGxqRklZT0ZJ?=
 =?utf-8?B?N2QwNDloYmVIT3NQY1hCYlNGTll6My9QSFlDRU9LNVIvVk1RZURucEpveFlC?=
 =?utf-8?B?OTJhMVRVRUlLeGd2RG0ya2J1VktpYWNtUTdKWnEwQVZQVGRFc1pxNFVrWXA0?=
 =?utf-8?B?cytHTk9VN0h2L0o4TExiZG83QytCdTFRT0MySWJWTmp0SXFmbVl6Vm5ld2JR?=
 =?utf-8?B?aC9pTlE4bUpNUXNlNlh0N1BPNmd2Q21DUkViNjZXdlc2VnltRGFPT0JxUEh6?=
 =?utf-8?B?NWU3aFE1YlJDZmVxL2puRndWb21qY2JjLzZ6VmJkV0tjMUVZOVVHVndYUk05?=
 =?utf-8?B?dmdZN3M5cnFTNmV4YjEyNG1ocEtkZnpRZEYvVXJpVE5SVE1vaDBXc1RNNGtG?=
 =?utf-8?B?M0xBRDlCdUx0T20wbE5sMlRpREhGOXkzbENKTERtNDRReG9XdllzcXhkZ202?=
 =?utf-8?B?Q1owNm9jejlvcjkzQ2RyUXJrZzBqT3FzeXEwcEI2dExqOU1YUkhldHJwdTFN?=
 =?utf-8?B?NWRmbTZhdnluY3NubW13QVRXWjlIdjJhenlwRjFVRldlVzRpOGNhdVpSOWVE?=
 =?utf-8?B?QUpSdXJXYW1qK2VzSW9zSkRpYldrL1BZd2pnb0dZUUpLMU84amxhZWRJc2sw?=
 =?utf-8?B?czV0VjViT0VJT3BVSU9jazZSR083NzFqTFcxWnQ5MmlERGRaY2pyT3FzK3Iw?=
 =?utf-8?B?MzRWWGxBYVdKL1lyRkdocm5zT2tvWUc2RnlNaFdCdENlcGZlRzdtM3RwbnE1?=
 =?utf-8?B?Zm5TUmFnUXpsUmdTWnpBUmM2Zk5kNWY0UFNNY2FYUUFCT2JiRTBYazMvSDNm?=
 =?utf-8?Q?vfjQRbC/UfTTDmRo=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91075f5c-0748-4f16-f854-08df22f18154
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 15:01:16.3240 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R/jscgyy0uFiEQz27V5gyA9qSHI+hCgwuwKXSdusbVBU32Stu11I2N+Z/guPJfYKJHJNCBBqWpyZljtRZKmjJDwNuqOxIwSZCZace32JydY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9736
Received-SPF: pass client-ip=2a01:111:f403:c201::6;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
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


