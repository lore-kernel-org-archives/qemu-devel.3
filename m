Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC6DCA9ED0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 10:30:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGDHe-0007op-0o; Mon, 12 Oct 2026 06:29:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xGDH2-0007ce-C1
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:28:59 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xGDH0-0005Eh-7t
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:28:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BXhZKX2B3K5SZpYiDDwfRXZmkIl8e0YQhZLut6NuaTB+HmvBaH2+kPDLeJ2eyzCD+saeRI+X8Zq4/y6/Dop/1kBYBGNrJVUmVKOi6IZKwQIpfGoFfaFJwsPgJ+75OOP4oPj1IPCSwIXC+MaOgRwtIDiKFCUtf/G0pNQqxDp4JgiroWaEZikbbqMdRlCPWgCTeMfoK90ZPVo5X0cNtrP2N74tQXQiYi6dcLX2P/DnV19YVRH8dX/EFtyrhf4dd81d/Vk0zD/efQwO3wMmf58kve8tMVji2FKaGreiU59Lr6JJrfkbD33aSZKxyj4PDe0BnK9YcD6AuzjCeUjjJDWvQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42TxjWWVF52+WjX+vXTK/F5rsdLUfNrhRilXbJ+LOJc=;
 b=QEmj/dVV+je4dIom9Ejx07Ihf6gd0AfKw7pX3pKT3+14Uqwdw0qrTdDhu550cA9TLaG5olFy1/PlbGbkov+MxEoHC9F6AT6LSQ9CGLV3K9A+TudnAcMzlwPAxEJC7LA59S0GprPdRMnW67ej+Favy+ersPcetZktcRLzH1wok/wMfmzTsLk7ju52k2IUZuqK/lA+Da7TIESpuHam0ocoxv0ZJmXzNrfedgm9rHPvCLzXMW9JSt6L6LSguNkqc0QsgU/vY3X/y5txzgs1F71JgBwFGoi9NIZGwNsnKTjN3VithFj5ce4FfbXv+1H5LgUs5Ql89Z++aqIBAA6oNzVpzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42TxjWWVF52+WjX+vXTK/F5rsdLUfNrhRilXbJ+LOJc=;
 b=GCAvOKWI+2AsFqs+fSFO03nAKCsK7NFcwDgUTp2dAimFB9cQ43ueiMjnPZZLc79OMigsXcAj2xwCflQyeo+RsXVwv26Ox5o1gVXH0dLLbHGrqYrCQVaTCtdXZ32h3TWn2Gp693DikRl3M3QixPTpiuWeGsvAhsrjnvUgeyQpPx0y/fup6zvZTtdrB89Nj5Jj6lkT3AwZQ2Q6DyNmZF6ek6xA5iV8s0iwcX8esl2OVXOHJF+KH1LthMDorUJnmkyEmrWsTLBJBcfo2+7jUAmE1HcAYt9Utn/EIHpHEl6hxW6FDZBUGBPV3lfV9rgWcF7mGMkNAdeEhkCcGgkJAKSxZA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AM0PR08MB5523.eurprd08.prod.outlook.com
 (2603:10a6:208:17f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.11; Mon, 12 Oct
 2026 10:28:36 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0522.008; Mon, 12 Oct 2026
 10:28:35 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Mon, 12 Oct 2026 13:28:14 +0300
Subject: [PATCH v16 06/22] vhost-vsock: block CPR migration modes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-up-vsock-vhost-v5-v16-6-36c38bd15ffc@virtuozzo.com>
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
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AM0PR08MB5523:EE_
X-MS-Office365-Filtering-Correlation-Id: fbb230d7-b333-4ada-1325-08df284b92a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|1800799024|23010399003|366016|10067099003|22082099003|18002099003|261009223027099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info: ti8vnUQOJziG9ljXFGd4jYcrN5HxHAYXmmXW0ssT7WdukdzjenhKS0oa48CE+RqT4IakIrMzcHXi2Ru9ThntbOIJkGiOpYjubolJ1P05tOismG+I5Ek/tPrw006KkPAKb2R9UkGcDdFiMA0jU/jRlVfrlx5hwffZtHvB1OaPi397jwaj4Sw0PlDgze4d2DJlaCk9ORmcnDyveCzMwAibQ6tY4EWG/xfF+SLCQpJ3E1ZEtbPwoXW1go7hHQrZ/6MpXTqKeG8IMEEuY6Sx1EXsQt/lfCgPWcjt8j8yjYw5/fca+fvC42pW9HyDqeDyryKpsNz7CrBXXSwubO426J3rJCLRGlvYFMt+ZEhFWD9KwmfO2Phj+3ghcoM7xrAooXseN5MZluHLjbD1rSxVq5xcWB9qOgPB5Nnob1Pt2CaF+NojvYHzPqTrmbR+mFFH97rPcKybeqZT49d12+jA1YO//+l5hvTet3XgDq5nJ0HBbuPrcM7HR1L+ieCoAE6OsliqhHEd98Dwr3riETObvxauQhRUq/oPURDHfRYVlgzWthnX6OZp0SDcE84ZjOeKEWrS8UF4BZh5moLLsh+10FrnwvybOIAJeQX4WtSVgZZMgGZzil/35uZlSzqQ1BAqv21apZcUjP6KfWTt0nc0bST2SUjFan7jX6y06RbGzw7qxJIfcbXLh3HBcLfZd6ClvKA6Visyn7fP3lzvtop13gLqzJYLxae9MYXGjpjxrU+JI9w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(23010399003)(366016)(10067099003)(22082099003)(18002099003)(261009223027099003)(56012099006)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MitGV0lVcHVNcy9tT2h3bThFWkZYVE1ZR01XbUVITFJ6UXVEb3RmY3FnWURM?=
 =?utf-8?B?N0tDZHJHRW0rSnVGd2FLRUFiOTZBdVpTclN5Y0ZMY0RnbTB2eG8vVmhwUUtW?=
 =?utf-8?B?NmFjTEVnUzZNemJySVpLQWpHSWFwTVEwWWZVeGthVWhETDZrVFQ2aTIvOFJN?=
 =?utf-8?B?YzR4WGgwSHB2cXpzbVpuak1tNWdiNlhDMXd5aGxuNERrdStEaWp6cE8rK1pL?=
 =?utf-8?B?REtCYk5WaEVrV2wvaXQyTWFIaXdBTy9HRVZaSkZoZFRXQjA4U3ZrSFlDTm81?=
 =?utf-8?B?VHlmL0IzU0kyK1dFZmFRU0QrZzN5R3RvMDBpSHRFdnFTYVBvUmJNYWNWc0Zn?=
 =?utf-8?B?bVFUM3ByQXV1R0FjZlQ2dmwrTjI1MjE2UUhBeHJPQ0E1a0txczRpek00V2VN?=
 =?utf-8?B?MW9FRVJVNDVrZlNrUWJjQ215ak0rWjQ5S2ZSTlA0ZGs4U2lKL0ExWUdRKzhO?=
 =?utf-8?B?eXJvYlhiQzl0M0tVVXVCVlBkaDFXenZ1N1M1UGtEdXc0MzByeHlUcXlNUnA1?=
 =?utf-8?B?WVJHTk95MU84QXV4QzZ2T0JPMW4wMzl1ZmhDU29GUHppZlNNQVZCdnJyayt3?=
 =?utf-8?B?WGljTDdGOGd1OEp4ODlacVk1RWJyRDMyMm16SFBsT0tpb0RTZUh6TDVJVWpJ?=
 =?utf-8?B?clhDTHZvcE5CU3Z5anJrcW5MYitKaUhSR29QQytSR214elh6QUgzRWNoK3h6?=
 =?utf-8?B?eEVHSzBpWFJFcTNFN3piWi9qb2pCcFRhczFCeDB5ZlY0TGwwcTFURnBwNllU?=
 =?utf-8?B?emVGV0NPVUw1TkZqOWUrbGVRVlB1NWMrYUlYaE9Sakc0b2daRFZpMDJGUWhG?=
 =?utf-8?B?RTNDZTAvWlBMSGhrVHJzWGxqZWltTS9iRUhGcjRYVWxveVA5bi9uSzcyeDMx?=
 =?utf-8?B?V2gvY013NThUQXVhb3RMcWVBNFlNZW1YK1pacytmQmxPKzZFTDFwQmtOdGdQ?=
 =?utf-8?B?OExGZzBvY2JtV0FwN1NrVXdoc0pUYUJSTU45M3F6U2MvREs2Vmxrb0dEUnBK?=
 =?utf-8?B?SEx6QWpSKzhoRy9xdUpwM0pKSTNRNWxLeDZzcCtXczNyU2crU3NIb3pqdWl5?=
 =?utf-8?B?OUVoVUpjK0l4Lzl3aFpJSnlOWjQrdGpMWDBDVmhid3ZVaFdjdXFmbVZwZktm?=
 =?utf-8?B?dDJFSTRrVFp0OWdObHh5dmtsRHUwd01RRmYxQ3lMRG5jM0RhNnpSSTdxUEkz?=
 =?utf-8?B?Ymp6QWpaVC9tYzJuWFk1eERqRXNiY0l3KzdoTFdkRlc3aVVteDNjQVB6emwr?=
 =?utf-8?B?dFNCMjVpdUx4czFDVkpQVG1iRW1PZkxoTTlHMjlYMURaRnl4WDFlNFlwRjFO?=
 =?utf-8?B?OUpwMkYveHc1QTZIQ2pObllDNkJkK1k4NTFINTVqQzU3TEVIamFGSzFSY0hw?=
 =?utf-8?B?cXlzV1p1R1B1VVZKTmgyKzlidkVzZUtBTXZTWHF0U2xjUnRlR1ZLNEE2em1H?=
 =?utf-8?B?b0hMdXBIbGE0cmNRZHJiaVlkY095YlFUd1Y2RmVjVWNwT3U2L1VKNFQ1eStJ?=
 =?utf-8?B?OFVqMHZsNWJ3U2tUczhMRjdTZ25rOVhNSzhEVStNR3liVFFkSW1hZXU5R3hE?=
 =?utf-8?B?enlxSU9ES1owRUh1NUpCSExkNThFLzhuZXNpZDBKdXkyRDhQL1gzWmZ0TXBI?=
 =?utf-8?B?MVd6R05oS2JpRUlhR3dTOG02cVNNZ0xNNHV5Tm80cEQxRXd2TG5nUkRqL3VP?=
 =?utf-8?B?bWZUOEZtSmNTUU90S25xYWNOSC9Vb3JTM0lXdERza1N3V2oxaXUwa21jSVNV?=
 =?utf-8?B?SnRPTmt3SnBaZzFWYWhZMFdqR1BGUmlKMEh0QlB4T1RiV1Z3M1NmYjdET2Nh?=
 =?utf-8?B?cnlVV2NGZWdFTkJmWkIrY3MrcjVaamRRUG9VY1RzblJuZDNGSzR0WU85dXdP?=
 =?utf-8?B?QVFrc3A5dDVvVjZ6Ri8zWkhCYkw3S2hLSWxhQjM3VXN6YkdzYU5LSUkzQ1hW?=
 =?utf-8?B?OFZ4SGx1WFg3R0JRNUlDeS81b0pBblJFdStuNlNZRTlqbExuNG5xOC80R1Zj?=
 =?utf-8?B?eUQva2xvUGFpWVFZR3pLSjlHMlFXU0N3VlR0MnovaVRneWpOdlpzbUQwWitY?=
 =?utf-8?B?bkR1M1c4bVpuckRuMS9yYTU1MjRFZ2xwaHVURCtZMDBiQUNzaFJLNWlwR1cv?=
 =?utf-8?B?MXBkajdWUHlOemduMk5XaVdwT1JCWjN5T1IvR2wzbE1rUldpYm9sVEFrbzB0?=
 =?utf-8?B?SWFUeFQrNEZQZTBWLzZMZ1MrSDhpUkFzbHpycncxc3c0SkxOZXFLWkt3S3RO?=
 =?utf-8?B?Z05hdWdjb0Y5Qy8zS3k1VDFlNjBYeEVNNmNFMEhrU3pHN1JWNUNaNHd4TWlS?=
 =?utf-8?B?VFhBekJtVkdOenJuWWFjQnNVNzhpdjg0MlBqZzRrQXNHNjdJVTJwellOSHc2?=
 =?utf-8?Q?nE6TWFds0n6uqjms=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbb230d7-b333-4ada-1325-08df284b92a5
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 10:28:35.8967 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CQekaTU1bJp03EFnNPjcJwkPZGkGHlo3rC177wAB/Rl43oKo/4f+rSK99LdEm8gb/7ALFlA27SGyuzyvowA2S0eDGv8s9jJ899snTuJg18I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5523
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


