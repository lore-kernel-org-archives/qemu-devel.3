Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C25D0CDB466
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 10:56:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waWsm-0007kn-Fq; Fri, 19 Jun 2026 06:55:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1waWsk-0007kH-UJ
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 06:55:30 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1waWsj-0003WI-Fl
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 06:55:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oBSOrRTCLBZiDlmpKzxs8MnqGUxky5DeTvLKN5prQ6XKw1v/t+xsE8Ci9EG+nWeA1hA+50auyi+iUQQgZ638Pf3lrhlkXxZRquJOCmzvi7P21JL9ef11KHowMUrKIYZwlbma0ul0Hf5grDXNd7FibhIkpjhTTXPezpDsWTrtTkmbONWsn0AXWr3R+uuYyAcbAwY7i49uY1MftDvzL570OymS1fRT9ziNFJvVON3sWq0ZK9xsPFLUZZ+gwyxZRiXdn/XZGYCRGeNRPk9UTTJgTyD6q9rWy0NHsiOKB8psK6XlVwCq2b9Rp15JjPPVyRoQbyulJGcpmp1Y5/3QkOZRbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rNuVh9aJOadNgxq1cThfQSQ9+diLURLKMlLXXVPlBYI=;
 b=CENPITV18NV8Hdx6usCUm9Muv+K928buQGF7tJQ5hk1GG7Mx86KoPKzdYdKSLxWTkU8qKPWdtcj8Ck6OFMXlfqkrQGzj43TWDV/Q8TKIjHijJkxIlGip5UcI4FIi+j6Vv6pNmoz/ZN0lfUVSfHkPfyPWQrQbjpgL/xgOz5S0lkV3DT0JOfLfKr5Y5eiLTmdATOO91BZ8tzci5EkWROuRp+TcUfUJGSDSKECokdT1AuqMovYjxfodsFbK2cPSvYpHFNNhthIN64ae80ZCKVQBRn3g0+JZI8HC83hmh4uFqGTlPm9b1XAiF20VsrPsKbiHECsgGyI+yVqOZ4phzm/7zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNuVh9aJOadNgxq1cThfQSQ9+diLURLKMlLXXVPlBYI=;
 b=JrzSmRPtDV1867OZb6VfIbSbC3f/KV6gnQ1wwuAVW1tGmsGCU9HJOQix6VLofuaj8IfTMs6hNi7kvJj9KeX3kefPhLIB3GsDygT+eLRGl9CkY+Hp6O1Zc+GYIHPyJ0QkYpyf5XnmOwnMKxqu1mE6dXAZnSW+qfa0d5iNXcS/g3Zl3F+WaA783sIHtlctDvWZ66E3/42WSFZ2C2+co53bSMdTU3JoP0UqVM/HDFeILwgwc5xFS3fLRG0Wy+m+1QG0dO8inP+qktJTwKypnx8XZneyFbQqJwD7iNuyeKCwwz3vCTfimyoICNl/6A1pJowjdJ1rQ+VwCNjh8x0B4Pujpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DUYPR08MB11992.eurprd08.prod.outlook.com
 (2603:10a6:10:660::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Fri, 19 Jun
 2026 10:55:26 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%5]) with mapi id 15.21.0139.011; Fri, 19 Jun 2026
 10:55:26 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, sgarzare@redhat.com, farosas@suse.de, peterx@redhat.com,
 dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com,
 mark.kanda@oracle.com, den@openvz.org, andrey.drobyshev@virtuozzo.com
Subject: [PATCH v2 5/5] vhost-vsock: don't reset connections during CPR
Date: Fri, 19 Jun 2026 13:55:14 +0300
Message-ID: <20260619105514.128812-6-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260619105514.128812-1-andrey.drobyshev@virtuozzo.com>
References: <20260619105514.128812-1-andrey.drobyshev@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VIVP296CA0089.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:35b::8) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DUYPR08MB11992:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f91c068-2464-434a-c558-08decdf1449c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|7416014|52116014|376014|22082099003|18002099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info: EVgDez3SYDU/4+SL7AXpOaLZSzmvNV+BaGVPlbrNdeZ2uKHyYA4WYaElPHwFLrmjNnGZ0v5Ry+EoufQOCx590UIjh1J6EDTO/6lciGHOMYeeDN2ZXKyTMn6ZOFTrSbPzBLR2JErvMncXjdTYG1t2C/G9Henp2ITBzXIJQdT8KqhbWbqYNDITQUg4s+Qxmcw8KZhYfVgs0DCqts2cdHzATP4VQo1Zt+1OOhy8yNiykLU1hBi6NPljptx6EPrTb+VtOkNmNloBb8PN06ns9xPpw9UeuMp6p2iVEpJjWoWf40JAS8PO2wpEf0WiqbS/ehxo/jTMoQKpkyOhNAtrJgVAPvpjifQhkfZ+SLgcO3Hmx0e0VrRmjbEKLaBpi9njWwAEvTmWrZYxHtO9Jjn9OpY0k21it9ePULCoEjtafhbdwFuKEYQUr1o0pCmkWF8ZzYM9bt6jerlsMaclumaR7JbEGSvu06D4qOjVbcFQ3m8Knux1tvjzCAySo8uOz+kJxxK99Z8Jj7R/szQs64rh3aPOxQ5J2qJfjxVALXUy5+WfaE41KHSXtb2gC8zEIlgdgABZ5ppyiCL4BuQm3YGD6nsui8ub79egsAMS9mAFMCz1gIgYdOj5vq1WLxr5uFR8BmJ1C/g5Ov9opAtpCJanz3iwTeIrRTU7nW7HLnIdoUsgO+vLudU+TGYypgLmtOCBZU/bPJmzpzV0B56tlSVSvVfLCo21d+hVSfwTXGsw95VXLuE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(52116014)(376014)(22082099003)(18002099003)(56012099006)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K+bgApGCHRqo6UAoaflJQAYKgpJoypdhk2FxbLCvnEf7AtV8CI3K2s17Jg9r?=
 =?us-ascii?Q?aG0pW03VvMwKsldQgA94ys+/AJ4Nl/2088hncYqG9j6GGzZmzx//ma2rtS8u?=
 =?us-ascii?Q?/9wtV1jk8F83/3Bs25AoC3Aq4Kppt5Nu+R/SIQ+raih84lmXiShZPpMVfjnS?=
 =?us-ascii?Q?PAWX7HE9z/v54TzBuHLtztzVMs54kNo8IEzbl5amTwf0ld/nUtnjFPLWAr5N?=
 =?us-ascii?Q?gJdsNELrITEKALw+JFYtwjzsgalwQLFHFDIJKnDaXduwlnyHEHlrfyDqsEpc?=
 =?us-ascii?Q?Nl7spNdvyCg+VlsXpJI2A6srrmAT0MMpJ++sQ6pO8nGeSZe4lnUy6mHu2P6o?=
 =?us-ascii?Q?L41vYlNUuTReSVo7ys5InyX1Tw3NqGvni+bVXjPq1iLozL7obnKiF+aA2GTQ?=
 =?us-ascii?Q?oMMiiULriLwwI3jAOcvd+x03pupmxrxojptlOVyVVafmYXK6393lOTLn4Y8c?=
 =?us-ascii?Q?l85rfZzLyZRdxKAHdP8S4tfnBM5D7Y3JLGJ8HWh6mcNYjlSTZ6lckagEDaGY?=
 =?us-ascii?Q?4Gq6DZe5OgvUK5a3IgHdnmwW96fNJaGc8K9b/k2mNNeZOkLsSSk3IiBZhW2q?=
 =?us-ascii?Q?1dnL3LClz5GBDeCDvqy9X3a0NdrQ8BQ71sigsVet/SNfrD3zAjbZEy7bI8qa?=
 =?us-ascii?Q?/BOdgZwNjKTff9Zq4izyXhtR3+MXSKHy+k2rAlkPgI4fOP9G+aNEzcWhSYh6?=
 =?us-ascii?Q?DePqEUW1h7n2sDvXTDBejveYc2NIbCN62S6a5tagMPjNqmdYnDNQ1ZOIJ0sv?=
 =?us-ascii?Q?cIz9zynFnp7Eb9Epr2locJfsiFN1hJVKKRQqBKgaAJPO1DUbmf1bfHH3Ggve?=
 =?us-ascii?Q?2oborKLVdf8bTFBkU+qwRVlgHrnsz1rKKg0ZfjMPU3lfAoFKHjp8HCifGPia?=
 =?us-ascii?Q?TY8FAgH3C74Agx+Dua0E43OvtzNQhAvQRl8V87bHHYRr8H9BmmP3PQxu57ZI?=
 =?us-ascii?Q?33q9f3xWf6lMJlwmJTgunHRLAUXbf5r8V7HjgdOZ/hH6WCTQ5nVN56CvMtW5?=
 =?us-ascii?Q?6DCz9Q6A+hANE0TJWoy2bRbfLDaEvLggyhxec8qc+tIyyc2SbQ9BWoJRuDNS?=
 =?us-ascii?Q?xYJvxelIRLm1y0/AK836qw5fD6HJHGrnfnbaHMbp0sO0AQ94E2lFLczCRjhh?=
 =?us-ascii?Q?K3a+hdtFAOt+aAZGJ5nLbNRFWMgLdOYmQq0VUVInDiG/+yaP/rIZCdo/Uh1t?=
 =?us-ascii?Q?1YtOKWJZtOgx7XTipPwD1b3LJr7ANIUcBkD+vQ9QHKThz6FRxvkIkS4upD7i?=
 =?us-ascii?Q?xEo5hsi5wU97StMvzrTU1medg7DInKk+jsbqmicizNkd/xMu4txjKZ64hY+D?=
 =?us-ascii?Q?0e3mh4RBCl9Kk2Zk5IsRyJt7hxAo16nk6xopEwouAIY9Wyj0AXY8ClFYgXBY?=
 =?us-ascii?Q?yZDoZwvb6LiTg8N0dFoIM3TTwN9i0IJNaoZc/7TgjWMIWqg1kiyaxH2edMHs?=
 =?us-ascii?Q?6QIRlZKng2k3wU6AR0PJXtqQefeH+4Dm7tvAlYxaOx7wqe8pn/B5KtUqbD6l?=
 =?us-ascii?Q?eCk47RqgLQBDe50IUQAB+t5/8FJBY+hgEgv2QOE1Lae+Sd25CrekMuIUeloa?=
 =?us-ascii?Q?zntUWjAyfKcIsTFnZrBkEbnl1cov2jaTK00ovzUCTpXisXEjxrEOEL9Q9fTF?=
 =?us-ascii?Q?t0jG+M+uUoPhCVs/QI5Ktv/4QDNynJZ3U/vUve5+8bGPgxLOMIrPtRbI8kJi?=
 =?us-ascii?Q?Vmvoe9CP+o9DnGHWT8nzlrxhXn7AVG3eYZq6Sloc7VN9ucxs9sbjcZ4ZLSFH?=
 =?us-ascii?Q?z51wjfZEEWF2ROngLNcJmYs9ZcN7Iwk=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f91c068-2464-434a-c558-08decdf1449c
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 10:55:25.6397 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dV6XrMKeOoExTMxQXgzRL6R044C+umGeLHz11KDtLRnyz54wgGv10jxn0Jlb092dAzZMQ3YQeNZB+y5oNGZU7y4YFj3zJuk5e98xHTQnHJ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUYPR08MB11992
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

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost-vsock.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index ea9a7d2149d..8b033426296 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -109,6 +109,19 @@ static uint64_t vhost_vsock_get_features(VirtIODevice *vdev,
     return vhost_vsock_common_get_features(vdev, requested_features, errp);
 }
 
+static int vhost_vsock_post_load(void *opaque, int version_id)
+{
+    /*
+     * For CPR the guest cid is unchanged, so don't reset vsock connections
+     * (the cid-change reset would otherwise tear them all down).
+     */
+    if (cpr_is_incoming()) {
+        return 0;
+    }
+
+    return vhost_vsock_common_post_load(opaque, version_id);
+}
+
 static const VMStateDescription vmstate_virtio_vhost_vsock = {
     .name = "virtio-vhost_vsock",
     .minimum_version_id = VHOST_VSOCK_SAVEVM_VERSION,
@@ -118,7 +131,7 @@ static const VMStateDescription vmstate_virtio_vhost_vsock = {
         VMSTATE_END_OF_LIST()
     },
     .pre_save = vhost_vsock_common_pre_save,
-    .post_load = vhost_vsock_common_post_load,
+    .post_load = vhost_vsock_post_load,
 };
 
 static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
-- 
2.47.1


