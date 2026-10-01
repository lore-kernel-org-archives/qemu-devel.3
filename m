Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C823CA5FA5
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 08:29:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCC8L-0005Qw-TB; Thu, 01 Oct 2026 04:27:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCC86-0005DR-Bd
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 04:27:03 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCC83-0003Pj-Of
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 04:27:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Trj3jxY73oK/ERUR0GM/qTF1VblpK2XVQ/olfauU4pC40fK25kR7pusYODEWEFGUqVclV97rPaE4KTLoFZkQ1kXLohvirZ9bvL9JPJIVOSuMrZTrGxVikMaCqs+5iE8NrZ7kEHj7EsDKv2gK6Q6X4mIpoZ2diDd1qv/1wH1+1gnY3LHPahMDQvbLEoZJ3a4GZ/obS0iTLNillIkhvZMldfqSUONkqTwezkRUOIkuMVebbSCsZ/5YPR61ffCa32Jmnzu0Syf5sVTqXRQtMwluRPM0T8QNAR0YYta+y0GYMp6h21/2yKRfcJlYL7bzROz0hZ0SDjVe2Rcea4zmoc3gpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5ksPgqxpkvwMZR46juSzPb3Jx553hY74OuSgtWMf94=;
 b=nbWt/Xl9gPMYJG31o6fS+tm9Jpw8Wc5aIJjcjFbkhwX9i7ZTKAmzIJFrzOEGvgyEGC4bIY1ayUcmq55KHKDQFpBcV5WgT+lSHtCdHFcy79+cn5fYo9sOktzV5ajXkJcmv4Z6kJbJns6EeMa9CWie710nCO7k9hr/zi6ch1iTLRPz/kNHeZrkZ355u3fSLPOY6U5OwkzqC7NehLEvoZzgx6B4ztjgmmLi6KSRNXoXxvTL0UoZuJShourSsRvshFnooFqWqvWd5zJcsoVFdPLnxXNa4RJMZvAhjEfwBdp6qXlKHcwaZ5xHPtT8alEL1EENcFemVK/lIho6t5Qr4jAICQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5ksPgqxpkvwMZR46juSzPb3Jx553hY74OuSgtWMf94=;
 b=KWfLpK7zgblHkPeVGodtQtZgTRY5GZn8iE9GXrAwD5+tXhPcK7C6dwjSiUjVLppDSVyYvx4epQxHddpS9YtrBokKHl4Wt9POp19I87FessN9ySxIvl7p9FoJphiPjpA/5KgOvF9ERph9KIIhB4nbRLomYOr6Ya2c+y+pcBcLav0boRJ7xa+uFVh+iE7IhgiKWev+Kthjwh09RcrxGZoUWbsyhGkZ32hUR6frRbr20ktpUgSslNrAbLYVBBzAAfjIaAY01hvWe0wpw2rsdYchh9Ch2a7hEWkMh1FjN89GCzP0+jG4T4uGdn6xs9mz8q3vX1uIo583LAJgCrdYoNlAHQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB4PR08MB9261.eurprd08.prod.outlook.com
 (2603:10a6:10:3fa::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 1 Oct
 2026 08:26:45 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Thu, 1 Oct 2026
 08:26:45 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Thu, 01 Oct 2026 11:25:08 +0300
Subject: [PATCH v10 08/18] vhost-vsock: don't reset connections during CPR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-up-vsock-vhost-v5-v10-8-8c094843e98b@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: fed8393e-4504-4a58-9f8f-08df1f95b97f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|52116014|7416014|376014|1800799024|10067099003|18002099003|22082099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info: +SIK0df2oSCnZQBXWw/Dq9AGwgBsrTxS1soygZiC8nbBLELc7dLeZfK3/9+R+WFgHVrejkg52NmEEPEe7iToavnJ4cfJT1F3gcQhec5Lbb43PZF9gwMqtxCxqSU2Wdlr9PbNPyfi8evyyoMVfcG0RMQU6MX5En14rBIx5vGY3NlH/uo9T2rJQytgkMLgcCngeALCQCwT8V3fyc9q50wbvaVXGkrAf4XWx2hqO1EaLz7im4UpOOGimbYS+HhejwUK+dc+wU5Oo/oQzhTUqrjK4v+XB+U8+M90PWj896dGok6v4RW2pI7MUDXbMqeK+VZxSHAxSae1+2DFcXctH71usTDEwqCR+5wD92mgC0SgbKmo9BMohUaygqRMDzZVh/NPpF/niHWNx2VY6sefl7i3sBGbjZ6zRxbY8tHRpc+cXh7zNVbOPErXTeUSpjPR+uFkF+039VwGuoL7CDQWpln4H21TbnI3LScNK2DK0saUZV7KMLHQzguezeGXrz/1DPXT7nDB+m7WXOwKy2Rl4Sc9+rGD+jJNIRmCv9BbCGZIAcKIKQ7tD1kJmefPmFpE3xnG6lZj7zY++ZKkOt0++3v+hY9DNbDcuM8JiDy/IJQEJOY0jMaECTbtjLXZYUqsCbdqewPzpS3/GJOQv12FaUdttwOAyVeNUA7C2qqZVg97pJVQCgddo9GKkaeARyHxDeFLL7AnkLVHaWYu5qWMIY1Dl6PfQq8KxWjhLWg6Mri9/hg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(52116014)(7416014)(376014)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTFENytPOWthc1U4STNkeDRqcXNwWEtJSHNKTE9vdWdtTDNaVVhlTFBuait0?=
 =?utf-8?B?SDVTQnl0aElpaHdIOG5QbGU1UTRpdkpzRFBFeG9WbktxckR6amh6emd0VXZw?=
 =?utf-8?B?QkM3K29RakwyMGhHdk0wa3JIK0JkU1pWZXl6MWg4SUZ5TmExQlZ5OUNxOUtK?=
 =?utf-8?B?aTB0Zkl0R05wV0l4SzdFS1l1Y1VpbDhuVE11V0VGRmdEdy9WenhpdTk3SXNy?=
 =?utf-8?B?WWxPQk91aXMvd0pXZlN3VXBqc3Awa0JUdXBZRDB0RFh3REYvMHFvbHIzSXZR?=
 =?utf-8?B?WUw1YUFhTEI5cGxOMFAxc0ZCeVQwbEt0SUFCM3c4bFVoQW9ldXN0QVpuMHBq?=
 =?utf-8?B?SHBaSGU5aVpSK0JJNzRGWncxMkVrZEdIQ0c2VlhLVWpScnc3Yis2MEhKQkty?=
 =?utf-8?B?cTllRkVyK0JQUjdxOStNTHJUVFFTbFdPQlJIYTJwUkk1RnZZV2tYRloxUFVE?=
 =?utf-8?B?QWh1WnRCUFlnbVdGcjN0enNLazRhWmp5UngyNUp0TkExY1k2YWwvbWpxREly?=
 =?utf-8?B?NTEyc2RXZnpieFhZZjZRQ1lzdmYrSFI4Q3ZEUVYrMEdQYWlJRDNiSWFZMTVE?=
 =?utf-8?B?L2poVnFac0JNV1lHRnJVVlBWNERncUYvVjMwbzYvVDZpcDlqUlBQOEQxbXVZ?=
 =?utf-8?B?anpnZWpYUUZvNkVLeVU0QzI1MUFhaHBRcGpueTNKUWMwWHlvZmltdWFkWG05?=
 =?utf-8?B?NWtsdW9TemdXQUFOT0VldzFIcU9QdUtDZmZmdVllSFR5NmpBd256YmVVTGJj?=
 =?utf-8?B?MnEwVXBUWTNVdGlSaEtNUFZKSHAxbjB2N0R4UnlDNUZ1VGxUQy92dGNxajJG?=
 =?utf-8?B?Rm1UVDRqZFZzU2Q4YXZCZ2xuZGx4MkhKRFhiV1EwN3VKZ21xWlk4OVBMODcw?=
 =?utf-8?B?Kys1MUtHUnFwQWg3SDZnSDZTbmtwbkZ4Q0xzYVQ1UkdpYzJFQzZzNGx2NEJv?=
 =?utf-8?B?UVk1cnRLS3lOS25EVXlRcGtOUW1vUk0wK0RFSUp5aGcwNWxUY1J3dk4xOC9j?=
 =?utf-8?B?Y2RVOUxVeUdYTjRoanNGbDl5TWs3SmV3ZlhzaTNVT1ZnQ21INFkwNXdBemtz?=
 =?utf-8?B?eEdYZndxOFZFclpuK2VEMDBveHBYVXdYZkUyVHQvOUpBMUhhRmlpREtFZDZM?=
 =?utf-8?B?MmFwZHBxT29tajNwM01FTzZJalNhcVhxNW9PcERtYTJOOEFsTzhrbUcvaUls?=
 =?utf-8?B?bDZiY0diMVNZTmpud0RDbXl2QWpadE1tUXNWcTBMb3VNVk9hdURNM1RMSGRL?=
 =?utf-8?B?TENLSGVHK0VPZmtSd2x4QVhjcVBGVVh4cjUxeGpjd2pITktlemgyZzVuV2s1?=
 =?utf-8?B?SHZ1ZThaWHcyQzg1eXM2eXd2SHFPVjlKU21mQjJiOEc0dVgxcG9lR0xpNGVR?=
 =?utf-8?B?UFdNdlprNWJrZ2lBc1FTZmJVVXZDYkFjUUFTV2FOakVOL1h1N1pDN1N6M2th?=
 =?utf-8?B?cWE2NGFqb20xSDB1Yng2NWxib2JqRG5mYmhxTkhsS1JoOGtONHBMb1hEa3RL?=
 =?utf-8?B?MFpLUW1hbGptd0Fzc2k3eTgvMzVkR0k1dVFVNnplZThvV3dzRTJRcHhxMFFY?=
 =?utf-8?B?NjdRZ3BMVE9WRk9yL0JFZ2ltZW1FeDBTR0RDNHd4UFpUQ0dkRHEvYmhCSVYr?=
 =?utf-8?B?dW1EZFh3Um51VVBCd2JkWld3ZEZQMm11Y3c0RjNGd3lPWWx3RGZNbnR5aWxz?=
 =?utf-8?B?QzVaUU8rRDdBb1RjSmp5YXB3OHZkWnE0QWd6c3NrV2d5aDIxakxDVUJhN2Mv?=
 =?utf-8?B?SnN6emZaRWhFSzUzQUFyY01GQXVtVVRFaDRjQUFNRS9ObnE4THlBR0EvUXcx?=
 =?utf-8?B?U3RxeEpXSk5xU1poamVxVzEzdU9Mcm5hNFh6WXRuUVJyWFlPTEdvNWdSNWpF?=
 =?utf-8?B?K0Q0aVBPRXJMenJGazV5SmlEdTh2U2RpckpIdTF0UEFTeWpZT0ZtdUVvdzBx?=
 =?utf-8?B?a0ZQSDVlSDJqR3dKOElVenhGWUJXN1VsWkhCaE9RNFNwOU8yRlpaWGo5MnE4?=
 =?utf-8?B?S0xUWWNxKy9oS2ZyY3F2NGF1c1FHeTN0RmJXV3kza2ZaYTJmTmZqM2VLRUNU?=
 =?utf-8?B?OFdoK2lwaTJOTjZVMVFMa3ZFKzlzWVNJK0d5dllmVHE0SGpZLytwRTFCUUR1?=
 =?utf-8?B?WWs3REI1M0o2RzBPYm5FOHNKa1AvbE5oQ0FTSXBMNkNRS0U2ejRDNUZvdEJo?=
 =?utf-8?B?ekQ0NkZ6Q0F3Um5DUlJLT1N5cGlrdlBXV1o3ZVlLL1VmK1dBK1BQL0swdHRt?=
 =?utf-8?B?aUt1U0tFZWdLVU9leUxjR3RGYVR2SStMUkpjWDVGeTFkRmt0Sy9sUUZBMU1R?=
 =?utf-8?B?N3dvWmswV2VXdnFSYU5EKzVZbzBtY29RbERlalVzMFFMcHBXK3AvMy9YTHUx?=
 =?utf-8?Q?S5pLVwLA5N29iGig=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fed8393e-4504-4a58-9f8f-08df1f95b97f
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 08:26:43.3671 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /cWe4Jag7RpXK1dZl9/ZwDd2TNmeqX36vHhzUCEAW/W1iRQBaZRXufsL63c8I7RJ/OB4G/Fg6YC26H5LARipLHyLC7PvZZW4hk/L5qJGGvs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB9261
Received-SPF: pass client-ip=2a01:111:f403:c200::5;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
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


