Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D553D1F9B8
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 10:55:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR6zs-0005nG-E7; Thu, 04 Dec 2025 05:55:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1vR6zq-0005mD-Ik
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 05:55:38 -0500
Received: from mail-norwayeastazon11023115.outbound.protection.outlook.com
 ([40.107.159.115] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1vR6zp-0003c1-48
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 05:55:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qYlb0TWzQpH5jOEqp6Dx8RkIGry1XkihxDqOxhNXLedsdLmmYRFmqS3Z/hx5Gu7ulRVFYGBgZitlsAeKRtNr7Wwao/KijABC04IVdM/husoOzaOTXaIjBm21LXPkZwJYYjnVpflyRKF3VTpiUKJNej3ukimwnJDmcTy9uPgUF2JvwLk6RFWPRD/CFTILfKH+J8eUbFt5/tVrsm9Sd90yCo3oj3gPEmemARJYjOtcncIgbc5SVyPU0TtLhFKSaVDWK+90Da63m0qFws8rHQpNXo7aQa3os/+LhyInaLVyd4JrlDqYiwX8jhyhFu9IsvDG3X1Qhe6LvGxF4IQfO6ZFJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zyLALDM8eDLQ6p9a+AKE6Crw8RDBjX1X8MYqiKhvJl4=;
 b=eZ9tAbDwRoU5ddx6JK6OTVh6VQZpL2uyRLT8Zr0hyRZ9qk4O8yQ9I5oBk5C9NGoP8qM/DvlrFPQejoR98AHtZi/L2WMhqv/m9VyfYSdUKD8BYuyzCBPl14oeo+J2OzKT+C9sovrroRgKhfrjmBvqBSsGGpY9OtzCXkBHsYmVbiCFeHT/gEJDnzpk052Hb5eyL+WClQwDdx0MdLYAGzx+EB6xjDCdLjyvDIL2ed3X6T6IQDBN7Jy2yTSZCohtvmRQ82KT2E7+4rdkzI8EBXaH7IFX08gkny5w9qIi/R61pJ+3i48bPQdOqyaXw7jautkP3/uF5xkwnT8zsF1aPFbjXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zyLALDM8eDLQ6p9a+AKE6Crw8RDBjX1X8MYqiKhvJl4=;
 b=nSWHakBUvsx7xZJObTiR48BwKpoAi+Wn79SBfMMUaGLVFiCd74nFcMXdSNXdyqcNRA7JW98A6SpnuuiBcfc2EGjLBHyrIhVEDmGU/vrqI17RmBftdnLHe+gFcyKZvR1QDTMLushlBGJYzBYieYYNkW+vZZ9b8i2reJdo2YlRNVpTtVY0K8M0QmjAHgV+xC9lL7K2CEl4fz8KyLs3ZX6m3wYJsPwGakp37Tp2ogkPb+3XMVpKafyPCMVAQQnfR4yDKZqTJ89DrwKUZEhPOtIg1GnaIf46a/lWGgy1JzaS3cSF4Cg3JHapqYt3TCURCVppnKC2R+xW/u4KAb1HGJEfhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS8PR08MB7718.eurprd08.prod.outlook.com
 (2603:10a6:20b:50a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 10:50:32 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%3]) with mapi id 15.20.9366.012; Thu, 4 Dec 2025
 10:50:31 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peterx@redhat.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com
Subject: [PATCH v3 0/4] Fixes and improvements for scripts/qemugdb commands
Date: Thu,  4 Dec 2025 12:50:15 +0200
Message-ID: <20251204105019.455060-1-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.43.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0158.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::8) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS8PR08MB7718:EE_
X-MS-Office365-Filtering-Correlation-Id: 19907860-c88c-416e-4a72-08de3322f20e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pVJ1/fhMtsJaX75kHDFYVX0xltb3Pp6dfRkAytMtZDLlHnx1Wt7I0ppca8aF?=
 =?us-ascii?Q?tLRINCHqJ2nFTh64GWOX/Obpj0Cf0S9Y4ay9oQHORgcjoyioAPOB2ZyEv3HA?=
 =?us-ascii?Q?HCzt79fY8uT1fobT5bZj9ISM2fqwLGpqlNJ88Sx7JHHFqKIduWZagrU8G3XT?=
 =?us-ascii?Q?lwbHCbOpZRou2nEfkgoHAU6tCMr0zE6VczvZNsDZ23JJMDXrOAz0TKUoREJ2?=
 =?us-ascii?Q?FMYb9wm2zCNkfBRiHiujIn/V8arcI7dO1wiAaUkY7/R9H1uGZKZokO3dwhyJ?=
 =?us-ascii?Q?QKu/D7Gx07xDP5eqKpzk6DFAJNvHCaDN99LOc4WRwiYSS3HYRaPsYmXcRteo?=
 =?us-ascii?Q?bIW2qzWjJl+bZt7x4OBi21Xqv28XqIfAb5H2iNNIIJYxbEaYIktwDrVXcuYr?=
 =?us-ascii?Q?j9FdhuHTYgA5VhZVc3tbg6vOSpt92+QEnsdULrVU44MADwsVa3TY4swXZXmr?=
 =?us-ascii?Q?PgJHiIlnn5uS09A/0Q/7VLZHgFo8VXKp48CJBG7ov3qaPLSRkRtcYfvagD3T?=
 =?us-ascii?Q?s+WtsH+TXo1OIGskPFaDhWvB4BtmrnuvnnDHjXrmJDquDJNhUyl1KsISFBGf?=
 =?us-ascii?Q?ircPfLxXleaHr7NDY5CNB3+3OycmPGY3g/WFksWzrD9zGJs1IOAit5VcriwT?=
 =?us-ascii?Q?SLUBhZFd6A8JdRFm9YB7Whvq2FDIpD+1hM4r0jyKsvWHYS9cxxOx2ICJAeFC?=
 =?us-ascii?Q?aPxLs/OQ+6IIxHQZUdQ6q5yD9dHHrMKylPkcPR0eq9ID5QpFu+sbM7Zc+8jC?=
 =?us-ascii?Q?WXDrPpeBlw0fK593KkgSIZeXTbb25e7hzEsqwiQ+9caIOhc1KW2pjw9a+InW?=
 =?us-ascii?Q?9rWnR54PDthyP7AQ+drcUmR7Z1RjDl6FALPbF6EJ0zFF8p1VpYk+FiX7tMJe?=
 =?us-ascii?Q?w8UefNZPhHGxOo9uL8UtKBYPPZ4aRkRdYuf/EtL661Uim7ViFes7LqM2DymG?=
 =?us-ascii?Q?4m26UwlytK64fBVp+pQBpd6rY5mUxLqB2L7gVM21V7k1xSLDxky5tvEpHiqA?=
 =?us-ascii?Q?YhuQxpFxUyYC76K3wlJTz8PL+4yjBtFvU0eeWb3wwm1eLmEvcMVou+a+wZER?=
 =?us-ascii?Q?UDxCTcc5VtICZNXC9y/debjDqpUKhuipB3lGRjrels593CxRUfOLDsHzAru0?=
 =?us-ascii?Q?oOqTUtWebhCY8eR+jPXd+PNOJp8W+rtxE7caVafDJf9k5v6PmWloYJWAJdp0?=
 =?us-ascii?Q?/2hHqCS0vQ6pDy/LIT7znJO7KvXwJ5w+LyKBR9l4kZmoDNsuCw9J8urplvjP?=
 =?us-ascii?Q?5XbyR/rjdDCP/SYScQ0kZZVGyEQUtYduBcqypTYIFiikWSQZeqKyxHTPq+1B?=
 =?us-ascii?Q?JncNo7xXVrGQWvUElmgszLZuv7ojMjiBTF5J1MhrrWckGZ8bnYa3KXybqSo8?=
 =?us-ascii?Q?ceHmm73j8ZW24yW2/O3L/GJcm5GT0PH8p4NcPDlpnj3HxiTw4ynIWglSrx4H?=
 =?us-ascii?Q?ha3ezZkYpK08GPbiFlht/pEgP4Oq4t/8goGVM0lZkghI2kvW27aq4fSb1SaX?=
 =?us-ascii?Q?kTAurWOldWetEItQVakDppUNeFhZufj/1IqX4b5JwM0Pvn0raoEIGJjWfw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BYa+1s09NVzEWEp5YadmCO6oTmIqnIvs4CFULFMpdr27pZ+QJo4XGa2WW5u1?=
 =?us-ascii?Q?Ixps0ydeL7d3W9RfFcC+itFvNjmMKDGV1u7j5tM9GE4j3YYKRHKtRAmIB8u0?=
 =?us-ascii?Q?4Xz/bLZiNyfWM2MVmqwxJ0iju25gt3gzo2g0MoFyOkW0Ek+k1qKlce7CRBp5?=
 =?us-ascii?Q?5RC7dNlpElYlV75IXrmp5xIptG3P+E5vgVtI5hosIG+BeYpsOTJYw1caae76?=
 =?us-ascii?Q?2amwlG9Rfhkv1rEw4Us0OAwcE6Rqr++YIdsjWP7N69ibmAd/Us5+zSG/UYvV?=
 =?us-ascii?Q?1S8OHMeT4u6HwibVaGslvIe9G4I3pXWldrfXgBMmeKLPMyp3KcsOHv9FmmQ7?=
 =?us-ascii?Q?nwU1H8AliQ6w8tzhBBY5BYdUCpWh1lbMeBybCJeDJzqVyAnrnhNEpIpT6+PA?=
 =?us-ascii?Q?lWP3ta5hScD+/8vZOvLMhFRDf4CP4rMfOzarVc/jlGICVcF4d4cYuBEnizZA?=
 =?us-ascii?Q?Xyejn7QmM3BSciTdHua2aCaTrBeXJhObYMM8zMkzmx08BbVzM/KR5RcPz0oQ?=
 =?us-ascii?Q?Ej8EwE/T7YSTv1spbbtlHwlBLnSaUUqMKYKlGFppZpI2OChlwCY/l/7aaaAX?=
 =?us-ascii?Q?5s5Chod9oT17fqQX3MjR+bJQDryCMdHOy4+gzQYDi3yE2NPqKIqfivczMuD6?=
 =?us-ascii?Q?NOtjVv6Ug9FQVROVHGkmNlllzNKOj0EeCl/Q6h/9E/BCKz95KWGViXFEnOHx?=
 =?us-ascii?Q?AtuH6wZoS2UotDRndutdhs/f8XN2Y9S1DDo0gvEmTCSBBdbwWEB+NttT/+OF?=
 =?us-ascii?Q?87a6kSGJVlRDE/dr1NVzzGqv7PPdueWnJ6haD0HMIoLt4Ig9UPGc54eOU+OW?=
 =?us-ascii?Q?iePhrSnpsWgfCb3YgjGM+nm6NVtYZNJMQ/JymlQgnYMEVeGAGYUAAPRS6bGG?=
 =?us-ascii?Q?Dhm9OXDaa76pmbCC0P3ZAzBVqSioWXIkR4TQlC/uCqMO6qcaJl0VoI1Jgr7X?=
 =?us-ascii?Q?2Me9zS/vItguXVwLdhBDUgPQvpZsW4m3odRofsmSwMpplQFMPFAjuA12Phqs?=
 =?us-ascii?Q?M+XvGVSw8/OZlxhtVfixmXrIB83hNv4RV5X0gncvzMTTaitpdPkLXUOVx/pI?=
 =?us-ascii?Q?VtmZKrk8l6OvvHCSsb+AKX5hbYgAO0oY+lLNQrY/2I0gki0qIXARkSL6WXmY?=
 =?us-ascii?Q?SPAnpYjcmLLkowjaeVjJ3V49eM6/OHw9mC3pU84xaD3nVeiuXdFYIFjtso69?=
 =?us-ascii?Q?3YG/80mGZYXgtDc+bsGLD3UHoVn8+Z3xachISGKCkGnAbfzlWK7BV5SNP0MU?=
 =?us-ascii?Q?pzkZX6xGzTRTLJkTxQK9QyMzCVS2grZso6KB5okUTL0PI07/MnHX8ZAHd2El?=
 =?us-ascii?Q?iYxugnBjvLtQpd3hU8m4MC3CbrhcKqc7p3QEfpSm3ByTFeSFfWBBTZX1lN1v?=
 =?us-ascii?Q?XOCRPb5X3WwEbvAlN1R6+7jGUJkGK3K9Grqrp0kcAKOILyXdK+Knlt2s+lWs?=
 =?us-ascii?Q?a8Nni8ZO80afBDqoC1cvoixIOXLlbscvnd2YCo3SfnnwfvabIciC6tXlNcl6?=
 =?us-ascii?Q?9Jx4gWw3CGG174paSLv5n2amHp1u9DE8LqhMKAXTsRS6K1PycRdjdPQ8djtt?=
 =?us-ascii?Q?t6SzuA+3kCWlWbXj0YD7m86XiG+F/ivXkUpaO2KbaJM+g4VyIJ8E3zbKATr+?=
 =?us-ascii?Q?OA=3D=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19907860-c88c-416e-4a72-08de3322f20e
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 10:50:31.8538 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LKplyHjMXGktT+8oaalo8uqvHO3ajSKWbwi4vA05l3ZMwke1toGsLyODnHcr5Q7KDJa2T/KMkBLXcOt2L5RIrx+gI50pH7kGAJZzhTb1+Wc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7718
Received-SPF: pass client-ip=40.107.159.115;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

v2 -> v3:

  * Use atexit.register() instead of gdb.events.exited.connect() for
    registering a cleanup callback.  That way it's called upon both
    normal and abnormal exit;
  * Wrap code in invoke() methods in try-finally block, so that
    restore_regs() is called unconditionally even we caught an exception;
  * Restore registers in cleanup;
  * Set dirty flag early on in patch_regs() to make sure registers get
    restored if we failed while patching.

v1 -> v2:

  * Use pty module instead of script(1) for producing colored output;
  * Patch coredump file in place instead of full copy;
  * Save and restore original pt_regs values in a separate file;
  * Wrap this logic in a separate class.

v2: https://lore.kernel.org/qemu-devel/20251202163119.363969-1-andrey.drobyshev@virtuozzo.com/
v1: https://lore.kernel.org/qemu-devel/20251125142105.448289-1-andrey.drobyshev@virtuozzo.com/

Andrey Drobyshev (4):
  scripts/qemugdb: mtree: Fix OverflowError in mtree with 128-bit
    addresses
  scripts/qemugdb: timers: Fix KeyError in 'qemu timers' command
  scripts/qemugdb: timers: Improve 'qemu timers' command readability
  scripts/qemugdb: coroutine: Add option for obtaining detailed trace in
    coredump

 scripts/qemugdb/coroutine.py | 257 +++++++++++++++++++++++++++++++++--
 scripts/qemugdb/mtree.py     |   2 +-
 scripts/qemugdb/timers.py    |  54 ++++++--
 3 files changed, 289 insertions(+), 24 deletions(-)

-- 
2.43.5


