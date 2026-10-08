Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A2F9CA600B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 10:28:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xElKU-0003O9-KB; Thu, 08 Oct 2026 06:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xElJw-0003Fb-Lc
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 06:25:52 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xElJt-0000xp-W2
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 06:25:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oSnN//WrXEWRCvzPqYSa2jKhvz7dkOqpsOqVlA15Oqq4dkgO6IbH6CQ6MT1SKjnT4bChpwKdGlQJ0bfnyA5APh8EcS6DYxuS2yao+hJpYqAUNG0n7vR5myykw63tnmjbQZqlVALSbtnQhZFMhYzhmGCtFCjJB/gRlITC0ZzYXEaQC3GoCaY+LHqdrj394ANPrXu1iWvfBNfyOYJraOog3mfeW2lsje1+adcg5ALCZgMT2wfRLL88iGWNtDLzprUKhNhY4Ds4HdbMxk3NK2Bz/5kFnYWJnTI9IC1XK5yT8FiGTwfu+WUOtR0jtVl1DEnR/iGHzymNvdqsUMdsyTwOzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFLHrTXYn30DKBGfZX9XawwQGNuxnOEL0tX4YglZD1Y=;
 b=Egye+7YIe2/cSKjkXwmNTY3ax835yg89YeQBsW0JzZGqP2aKUZ8oFYd7+6l+mvBfT9OEB3D38V6oW/TLgLmnXMA7dl0sYav7ubfPDKFuegwPwTYhUEvTU5Iyipuri0w7RZ2kdRCmg5k/nBs4RH7QjBDnfTMxEy6ESJqWwH9X+pxCVBjJjB4vFhnAlwJwgVWdgsaM3Smw+auaOzOEifN3QFmiWwCkPuW1Nm8Z4iyFWsl6izBHgNYA36hjkWB+Ne4/ztX2h5tnE0Q8YkAG231ZiJN4tBacgzsdqUq5dis+70JAHa2j99FJ4e5HHi865RtiovqQJp2zOpiWgsGuszB8VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFLHrTXYn30DKBGfZX9XawwQGNuxnOEL0tX4YglZD1Y=;
 b=yg4FIRMexpN/YMIJOZDiybOYC0NfIy0JcKEgWJZYxLNCHFYj/ArgeGSmcUkyR5pHsm413L2WXY+i48mP/pnJXGEMJ2MoLnZw0nwnBrgNi6D63UveT0dKcgOm4A+NSq+QjQj4l8mCOs84tNebT9NCdrSktJwO63bUDd6ABrdx5KPL7ZYTNe62pZKyHApa8Q4pK7Fz+HF4ay3jc1AqQb48mopDtplKM/cFSXKk/lUqfMr/DzOj1kGDc2DaOYL5+jKyTWB9DXMZCaXwUv8f2QogS+movaT5sMMQ4ruUcuuC8zgP3RD7B9CNqoFfW/vlT1rRYBH9rFbx9byWGjC34MD4XQ==
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
Date: Thu, 08 Oct 2026 13:25:33 +0300
Subject: [PATCH v15 09/22] vhost-vsock: fix FD leak in realize()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-up-vsock-vhost-v5-v15-9-301b73b3f843@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 79670898-b093-430b-6343-08df25267f7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|52116014|23010399003|1800799024|10067099003|56012099006|38350700014|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: chLwrxU3lcdKa5r3WQLUxXBlOvbpubf3QdB3ldkZV/zrrecZ6lp5Ly3doBp00yMT9eUEXViUMJdojUEaALlG+kcpWlkKm78+Ps/cXsO7YX6c3fYZMsmKeg2RmkvYz69Jh1tiobuvEH8YGVFjqC0QoO6Xj5Ld2dM+EMZL6Z6jUiIa/v8L4hCzT2LbE8mgGr8ncqio9ESvBu+HoWe//OuXOfv9cjIlmwoStvC7kZVxqBP78PR1go40YjjFS9Ao713ewN2++P3/GflMzm5ypcygzz282N8QuIER5DfKQflU2w9azDrfRL/K9HP6Zn+Ge0nHj4L/5zgJFdK5751dfxAN/dc94zKWP6UTX4hkZB2S6MJMgNke7M2jtObiOF/rZiFhC9a6C6ZepjjUIKiBW6oPP8+FfpUuw1wX+CZ6XzaGA/FfVFLGJIpR/igIkFv2CzoEyCYrbpx78RlwNSuKkCFP+MMpGpY/77P6DkWHDlqU+rc8SFHqlFTzU2tquFGAGK3j+JKSJask9Ay2cLL0nmkQURluo3VvUaoTCVx6GFI769/blYCja2EKzdACEO5kLoNfvX89hDKSVMK60KLQiZ5uFzrCGy2rS0lLbp4WVlXGuopKzihJm/HJaWFnoj+xm+BhcWDzw/ISl3BwJGntzkWHHjD/HCN9XRaHr1GL27ezqfwElIhDGyC3V4ZVh+ubpYH8IMwq0StS2P5c3TLqeFfDP9o1Nv5/V5grPNFQVZcCIAU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(52116014)(23010399003)(1800799024)(10067099003)(56012099006)(38350700014)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVZLK3Nia1ZqZ1ZiU1ExaTZWL1dGQm1jS3hXT3NubTUwd3orVGNYdzBCYkFR?=
 =?utf-8?B?SThXaDJkajFhSXlPeWhjTHJ4eGxGSS85VExwT1FsUHhWNi83Z2xTM3BwbmRm?=
 =?utf-8?B?WDh5bkVjWC81TzhpOFJhTk9CQVZmSW5HNXlJN2pCWlBUUDRtcGdDTzF3WFNL?=
 =?utf-8?B?T0xWYVkrdE16U2hNZjdFb0w0anVvYUNhU25TMkpTMGtOei9iSDNqVGZEd2dM?=
 =?utf-8?B?SWR6QTlxM3F6UUZkaWJuYkdxZGFNU0EzcWszZzF0MnF6Qm45OFNMblppNDhQ?=
 =?utf-8?B?RzVQVCthWHlGQ3NRcGh6WitzUDBqN0RXVng3UFVVN1RzNklMWVNUN1kwSDFj?=
 =?utf-8?B?akFDZHRYM0pkNEZLS0xUZE9yTUtLOEZYNlJZaWNVN0FRRkVtbUE3SGpQNjlI?=
 =?utf-8?B?enZEVXR0TkZDYy9lbklPYUJ3VTBqQzdpbHROSFVwVVVCcVJ2aFo1KzhoYVVp?=
 =?utf-8?B?TDVHYUlwTyt5S0tqMG9HWVpmcXVXbUxlcmpGQ2hidEpLcVlzN3o2Rysxd1Fa?=
 =?utf-8?B?K0dqTi9XZGc4N2pTek4wS2VzTTM2eDFNTDh5TDljYnlJaXBqQkhxbm5XUmgv?=
 =?utf-8?B?VWp3bGpSYlhsaE9RMkQ0bjJtSGtyYnlnNGJiNmMyRHh0aDgyRkpRd2dmMis1?=
 =?utf-8?B?SFY5ZTM5NXppYTlvUFhpY0xUUUNINkI4cXZtZzl2eVl4aGs1SEI0RDQ0OUh5?=
 =?utf-8?B?dXNKV3luenpJcFlzNTZXd01Dc0tTWEllOUdPaWNpejRscVhVRm1hc2RDUHNq?=
 =?utf-8?B?UHRRaGNjUkd4UkMvT3E2VFFnamdoNjM2VUEwTU93OXJ3OWdnZlhKY21zZVlo?=
 =?utf-8?B?bTY3SjBZTjhZSERicVFHRjFFRlQ0ZUIreXg2VU51ZTNXb0xRelpyWjRqbVg5?=
 =?utf-8?B?MDJCc2NmOW1YdzExWldBZzFuUElpNHNpSWhmeDdJNlNxMVZ2MVM1a05EdHNw?=
 =?utf-8?B?MGVnaXpEaWQwT3hsZWViQmVxc1FXOStTNGZoYUJkZzNRT1c2bytvQW9naHl4?=
 =?utf-8?B?ZTg2ZVluT21iU2g5UnJwNzVEenBmUlBjV2RGeFNDakNoWHhhY05wb1crS2p4?=
 =?utf-8?B?aytkNmlhVndvV3YvczNFaCt5V2VSaXJ1TFZLMEU0N2NpL1ZDMzJFSmZWbWpp?=
 =?utf-8?B?ZVp0dmh2NjVrckViazhzSlgveW51NUZIVzNraDFZNDZhSy9mSVpzYzlXc1JH?=
 =?utf-8?B?MDdVdGNhYXlZaGk2ZWU2VDJUUGE2bUh5ZExqeHlvUktzTG0xVmYzUHBCeFFs?=
 =?utf-8?B?ZkZOVlVuQkpBNEMrQjJXSW00eUZSQnJ0WUpxK2kvYXJRZEk3ckJPcFNGa25w?=
 =?utf-8?B?TW9UK3NtWEdxQ3liT2EvY1NocDIxVE1RQWhGbzNXak1OdnYvSzFNREU5cmg1?=
 =?utf-8?B?ekhBWTNsM1JIQTFXRWxPaXhNbFRBS3d3REUyUkg1NG5XK3FIUVZ4bjF0cFBn?=
 =?utf-8?B?a0RLUWxhY1lOT0dWQ3YvRllad2RWREZGWTNxNVlBRVp4UGxaK3JZMitPWGVm?=
 =?utf-8?B?M2llUDRpWStETFp3V25WVUppUHNpWlZENWIzTG9tYUErSlRxY0hTbXMvQmxa?=
 =?utf-8?B?aklacUtPQmpNSGliaENQQU9SK016NEJsYmplbG1aazdaWlN1eXRZdVlHRHhL?=
 =?utf-8?B?V0RQY0MyUHc2cysrSk9kT2MxSTFtaERidDNiMjBvNS9GR3BJcG96a2E4aGhq?=
 =?utf-8?B?NnRwZGY3MG5TYmZBUXJ0M0FGS2tCbUR6eUFaTERGRmRkdnhHaEhyd1pTMk1V?=
 =?utf-8?B?d0swc25LbGR0YVQ1VlIwdHhoSWZBTy9mNmtERFVwWjdFZWdCOVN4TEtNUUsy?=
 =?utf-8?B?VzBxcElaU1VMTnJVT2hIa0ZDSGpGWm0zdzg5Z2tWSDRzSTBEQU9rZUpITm1M?=
 =?utf-8?B?blB6YTM5Y3lVNHNlekpvbjgyUllBZ0dacGJiUzlIczlpNVY2TWRobHg3WXBW?=
 =?utf-8?B?ejMvd0dqUTJwM05zUkJpeC90YXgzVDVlN0NKLzF0dkhTR2ROM1FMcnhrUE8y?=
 =?utf-8?B?MytTSXQ4YVhZeXczeklyNkdQTXcxbEpuNmh2RkFBc2ljbVYraTRZN0lDQXlv?=
 =?utf-8?B?Um1NU0ZERUkwYmJMRVo5WmRNK1BJYU5XT2MyRjM3a3R4b3BBUERPdzVUWFFs?=
 =?utf-8?B?ZmNxeTlEbFZyUGRLMHdsOGYxQ2JCTTJDVFhzN25DaVBydEpHZjF6L0U5d1Rz?=
 =?utf-8?B?M2tBWG45ajRvT0ZQb2JLV0UvSE1WK3JpOVp3ZjlpSzF6M0xMbVNnOENqUGxm?=
 =?utf-8?B?YlVNMkhqQ2IraGpPMTlKUzM4dHgzdHZTbENBcTlxektSTnE3RmU0WTFjaExs?=
 =?utf-8?B?M0NoeXIveGFIb0lvbjBvaEZtLzJmRklSY0F2TkRlR21XdHFQRDJCaEF2aVJH?=
 =?utf-8?Q?7Jxk49FLkWaVF9W0=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79670898-b093-430b-6343-08df25267f7d
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 10:25:38.9140 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NGu3Sc7WUOdwERxShX0jxaZHusUeStb5SLiPNOcddtpsMpSHngN4rWnUyq/2vv+yPbtvo3prMQeL9yWSnFBOFREyvYRADRonXQ0ntJsup88=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10593
Received-SPF: pass client-ip=2a01:111:f403:c201::3;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
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

In vhost_vsock_device_realize(), after unsuccessful call to
qemu_set_blocking(vhostfd, false), vhostfd gets leaked.  Let's close it
explicitly in this case.  CPR-saved FDs don't get automatically closed,
thus it is safe both for vhostfd obtained from cpr_find_fd() and from
open(/dev/vhost-vsock).

Fixes: 384c2561bddf ("vhost-vsock: set vhostfd to non-blocking mode")
Fixes: 701544cfaf46 ("hw: replace qemu_set_nonblock()")
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost-vsock.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index c582ac9fcc8..3ec20d87606 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -176,20 +176,17 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
             error_prepend(errp, "vhost-vsock: unable to parse vhostfd: ");
             goto err_blocker;
         }
-
-        if (!qemu_set_blocking(vhostfd, false, errp)) {
-            goto err_blocker;
-        }
     } else {
         vhostfd = open("/dev/vhost-vsock", O_RDWR);
         if (vhostfd < 0) {
             error_setg_file_open(errp, errno, "/dev/vhost-vsock");
             goto err_blocker;
         }
+    }
 
-        if (!qemu_set_blocking(vhostfd, false, errp)) {
-            goto err_blocker;
-        }
+    if (!qemu_set_blocking(vhostfd, false, errp)) {
+        close(vhostfd);
+        goto err_blocker;
     }
 
     vhost_vsock_common_realize(vdev);

-- 
2.47.1


