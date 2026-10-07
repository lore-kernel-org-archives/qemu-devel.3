Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6053CCA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:41:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENwZ-0004UK-Ah; Wed, 07 Oct 2026 05:28:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xENCH-0001In-Ms
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 04:40:28 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xENCF-0006jK-Qb
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 04:40:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WvbPd0l9KKEXivX70DlSI7aVo81ME1vpPadKz2sUxxMB9l5smHEEZriXCSN4GVufPApR4GGttvskNd20tm4Ro6ZZmf7NEe6nUmLFOW+pQYfTQpjCerPcpNIBuDW8/bekLGjBCCjBJWOd/4mnPH8/PU3VWoxg2FTAdjBxaTEFfu5exGIfDB0R/eYPG3t1T2CICHtvwh4LRhu2le9oPB16KTL32DR0z5P10AMF1gzfaCTe0TK0jZqWu/sCSMQmQC/3T4VnA0nn04C1XLFa6QbUb+V/3ORYqIahSYT4q7IJ3YP9WSJPD1TC2dGlj0S5eHvbWNVlxW3hhOpnaVWMk+nQrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LsFB3FDQ+3FBoUdGrsPH789lm9GaLA45KHUm/J4Q16c=;
 b=xE1JaXLJQtxPwOjC3ZyqaDdB9cq48nNofOn+2etSNsu8wNs7+Enwjr0qC3jOBcn3BOBTxELVWR8BlVkGOmhhfgFINePIaUOZzxiAjlKWgLWRPBiG+L6XdlUJNscPOoQ50UD4qF/WxJ6nSs0Mu4zpBQAgY8XQL7cCBbWxsRZcBAUldcsU0qDPP8TZSDZZhCmGO4j1lwIhXGtYew1prOSN4wzLCQmKOF89z/VXCeBYsp1dM0MWzbSWvg5Cb3gNj3eV/xzEW9cxfIZi3vHLTpxhFNHy2Bg6ZF9u1qUK5rrKoh2cV4bfAwsMngtLat6NaOUHNKG2ZOtEAgjDWMPuOIRBnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsFB3FDQ+3FBoUdGrsPH789lm9GaLA45KHUm/J4Q16c=;
 b=iupwIlvI/M9KUi7tNjnkjS2Qs7NZcOo6Syq80glNqt8blmOF1n7vB7mpTaSNVIzmFMaLPUx+k/if/UdnlJG7naNxXkT4Ukg/B00+FZPaaYgCJJIaPXNdrDSmH+eBsBI9+gXc6/Sb04xYqdGzbZlpkuGgScVg8eQaHriSYlysInjb4sxNyTm1vEgXQ7atK2DvrAqBwi1Zj3W+KK8NJy+8ouSa2kZ6/lk8a/A5uuqTzw0Q+ZQmLSwNksenuyGLMCT2Xk/Z5DJUTCafuyLQXTh0uzZYAzrJz4Bm+RqGnaN0+0VD479vak3iQDB6YQNnECnZs2/173EoXT0r86Q5+ekSzA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AM9PR08MB6292.eurprd08.prod.outlook.com
 (2603:10a6:20b:2d8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 08:40:00 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 08:40:00 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Wed, 07 Oct 2026 11:39:57 +0300
Subject: [PATCH v14 04/22] migration: forbid snapshots under Xen
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-up-vsock-vhost-v5-v14-4-e16de9962df0@virtuozzo.com>
References: <20261007-up-vsock-vhost-v5-v14-0-e16de9962df0@virtuozzo.com>
In-Reply-To: <20261007-up-vsock-vhost-v5-v14-0-e16de9962df0@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: dwmw2@infradead.org, mst@redhat.com, vsementsov@yandex-team.ru, 
 farosas@suse.de, peterx@redhat.com, dongli.zhang@oracle.com, den@openvz.org, 
 andrey.drobyshev@virtuozzo.com, mark.kanda@oracle.com, sgarzare@redhat.com, 
 maciej.szmigiero@oracle.com, odaki@rsg.ci.i.u-tokyo.ac.jp, 
 philmd@oss.qualcomm.com, bchaney@akamai.com, clg@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI6PEPF00000236.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8ee) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AM9PR08MB6292:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b1f0fa6-8b1f-489e-909e-08df244e92dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|52116014|1800799024|23010399003|38350700014|56012099006|22082099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: 9uWx/j0s+5mtQ1vtu4jhJ7kWrz51T0kYa/XP7v/U/hlbh/XO2WOA18aOQ24YIOeIa6Nu/8Vbg1C3SPKcoLWUDjIFD36Md3aJOjijE35jIomYL9itgqxZq7agOh9Q2ZTx5XajF0KPIpZsQmyuE3eMs7zISqoTQQ6ur6bho936XQ9rki3OFfwCrefhIr8cm/UUl5jVNL4cFrTyPtmcvHvxwo00zKudGy/RbNG1m5z9lOgA/4Gea+WTVneaoJ0iipWMKXQYVMBMzC33f6iZiUf88/Y2QLEf/HXsm+qM4AoUo8dH9yhfA5SXeID8E+z9x++Og5SmMgs0/OUoojpdXo5ODYnsj9Kynp9iwCF3jK8cKAY/zI7BWZycr5vpHKDVQjcVqn8kRL0MMDCdeKmK+pQBW3vvIYH2NwjQxzkydZMHff94Wr+f3VQEjJz0Ge/lRTywrZpbs+c+5oRydhM9EPrsirgBHSVyJTYoKom7bbaW/PtEY/PLyz4le3+PGGiaSeNhL/YMCLZqbn3vZXaFuAdX7I0nqzoccl7OSezrZ9KmfuaJ6B3kdhx+rE/etMhzKf1JJS2jTfZRSkj8WcO2aY+XaAbnhYOGqtuw9IQRpSUKn7YkA66gJVGPUxAUy/wjhcYRzuxLvUJB/yPFXOVpGSWvcFN8oLBUbsDulso9qtjcyxvBWZCrO1X7mEz9W/2/dI5c2m57MpMnZJbWoGLYPC/DuBk8h2UW4O+H4kERUBtOf78=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(52116014)(1800799024)(23010399003)(38350700014)(56012099006)(22082099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEVJbWExZnpqUGU3SDUveExFNGZlbW14bThKa040LzgyNkd6OVpxYjhRSSs2?=
 =?utf-8?B?eG9VN0VUbDloUVpGeWJqSXJqcjNCQTB3NFAyQ05kOGZLUk5TNUdQeW4wY3pr?=
 =?utf-8?B?d0NTenlta2MvcHZkT2NhVnZLWWF6R1FpOFpsNXdOb1AzSUozR3ZaSnduYzhU?=
 =?utf-8?B?eFIvSTFhUEMyTmY1SzBXOXlzYUJMVDBpUUkxazhNQndyZjI1UW5EYWIxVzdk?=
 =?utf-8?B?N09idWtZWHA5N1lpRG8zbzJNL1RaZkFqSzNORWxCS3EwcVRabU12SVNSUVd6?=
 =?utf-8?B?VFFMcEZwQTBhVk1XNHZzVndqeEF6R1ZPZ28vS1NZVmw4dVdNblNSRXVsdzFw?=
 =?utf-8?B?VTZ6dXUvREVtclZlQ0ttcmNheldzd0tUa1pQWU5pelUwYUtSbENRS0FpK1Mx?=
 =?utf-8?B?T1RmdTRrSTlTVmhhVHhTNmVlZXJHN2NYZGg4TzdwUlNva0FXRVdqQXg5L2l3?=
 =?utf-8?B?ZVdzZGh2QlorWFNQc0FxdSthQklzb2NQdXgzVUwrRC9OM0dIRzM0Q1MwVzJN?=
 =?utf-8?B?NGJTNnVUUGFoa2hqT3I5cDJCYlpvbC9uL0ExV1ZJSXloZUw1eWo5bUZaT252?=
 =?utf-8?B?RWJWeGpOY1pKZ1cwR1p1M1d1RmhKMjQvME1qdnhsdHRGbTNLaEFpWkNKUnJP?=
 =?utf-8?B?Vm1FVitMd1p3WitBWmt4VlRWQTc2bUozMCtWdzhpSVVUa2lCaTBDSXpaZEU4?=
 =?utf-8?B?RCtnaWhucW5BVFZsaHZsNnRPa0hIYWhEVVR1SlZzTkZwdS91ejRaQ0E1blFG?=
 =?utf-8?B?T0UvTXBxSm9Va3JSSG1IK0RHWUJHTG9CVm9lejEwQWNHdGlCelQ3Zk5rWi9w?=
 =?utf-8?B?NzZ5L2VQbEpEY0EzR0piRGl5L2VlblFqMnExZnJOT0FScWRqdzRsZmRyb3RG?=
 =?utf-8?B?VGlSZVlVd1R3aG1RRnU2d3JJbGVmV3NGWS9jNUVjT0djNzNGOUVFT2h6VW9G?=
 =?utf-8?B?cnJ1dC9nMTBSaTcxN0hjY21keHRLcmxsaVNueFEvZ0JqOUpnTFc4SDNqRTFw?=
 =?utf-8?B?bUQ3dHhPRldtWGpKd3BKdmVma0k3UVJvV1JVc2V5OFh2WmNtdGgrZlduYVZp?=
 =?utf-8?B?cmYrSWROanBGcG5qNDFMOVc2Syt0SnRISHBoMXIvZkFWTE1STG40YzZsczRm?=
 =?utf-8?B?QmhlT0pjTEJWVlVoRk5NZng4RzBqUnZSMTdqL2RoYVFWemU0cEJ1WVd1dm5t?=
 =?utf-8?B?WlJIaEp1MjlEUzlVamYwSjRrcDdwbkk4YzZ0d0g1bVdDUUJoY2ZlZWpSM3hp?=
 =?utf-8?B?ZmlqY1ZPVVdXTGNWaDdOcExFckNmOG96OUVhWDZXK2xaOVozSXN6RWR6bTJu?=
 =?utf-8?B?QW01NGZ2WVEwZHhtNnE2QXlSN25aY05SL0JsOGMraHN3NlBRUlVlS3lBS0JH?=
 =?utf-8?B?bm80azVyTHJRenE2UFNaRCtsNStrbzJSeEhENUszbnNGL2EydzZyM0hWSnJi?=
 =?utf-8?B?SU8rQjZwaG1aaWJpYzR6ZDdLaDUwL0JtNzhTVUcvNzFLOGxlUkMxbXNzU295?=
 =?utf-8?B?aVNQUXJDSC9GVmd2SEdKVWNNcjBBeU1SNjN1c2RwcWJtd2hETGEvd1VNUXEw?=
 =?utf-8?B?WTJmYytpQ0Y3L2NtNU14Y1p0VXpJOUJBRUFTZ2JWM2puNS9SNTFxNEhhTmhN?=
 =?utf-8?B?NkJEQXp2c1ZWeGljVXJaL3hWYzVnTVN6VGhqcHIxUDhHVXExKzIzbHpPclZx?=
 =?utf-8?B?dTNJRlU5UCs2TVBudUJ5ZzZIbUlnUmtSdzhZaC9JZ3BJOWhRbWxxamJNTFcw?=
 =?utf-8?B?MFVhK3hjUktHNDFOSzQ5ZURJR0E3VzFMdmZlcU9hM2J6eG5Nd0NGMVFnTkhN?=
 =?utf-8?B?dG5GZkFXK2FvaUJUaXRPbHk5M0hvNXJWRjhkVlZlWGVkbHhreitCSkZPSjZi?=
 =?utf-8?B?WlNlWWZabkJnSnJyS1Y5TG10YXpVNjJ5MXhpRUdWaThEdEhuaXk4cmhvTlp5?=
 =?utf-8?B?eVJsUWlmTUcrN1JOS0x3Z25TK0YwNm9CZm5Ca3dWU212cS84V0NyMFdSTGJO?=
 =?utf-8?B?Zk9DRUZKWjlYNnRycWlQQUNHZzFqSGNDS3RsL0pEYVhZaHhXeTJpeVBpaHNR?=
 =?utf-8?B?ZDk2VjZCVjhZSk5tdnd5ZUhIZjVabEJLTG9UZEhPRklPSWdkWnZmSnEzWHZU?=
 =?utf-8?B?emJ6dTBYWTlpK3ZSY1JacE80Yyt6U282NTJzeGFTbnRyOVVvTU1rOFNXYmNZ?=
 =?utf-8?B?OEdZdmRzZVl1SmR1R1FmaTJ2VlNJWUdqeVJBbXV1NldraFEyZk9hMnp0U1hG?=
 =?utf-8?B?bVhGN2NHOGlNbm9kM0xWRGpuUmdiU2NrRmZqN0NCT2VRSnhsUG9OR1hwbk5Z?=
 =?utf-8?B?V2kwTjVURkRXTnUrUFBlWlpnR01YK011OFpZZ0txUHpWNlBpd0lNM2t3azVI?=
 =?utf-8?Q?dwD71tAfwzMc6Ksg=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b1f0fa6-8b1f-489e-909e-08df244e92dc
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 08:40:00.0649 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: evSDB8JoJtOVi2g693G7o/c7KRm+dOqgYeXHi0B4JHG4TJfcRlU+LL7JFwm9AaF/YBA5GvXv1QulRWPQqLfhAJffzzs0sKfiaa+6YbZxbqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6292
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

The snapshot RAM-saving path does not support Xen's memory mappings.
Refuse 'savevm' and 'loadvm' when running as a Xen device model, the
same way they are refused for CPR migration modes.

Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Acked-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 migration/options.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/migration/options.c b/migration/options.c
index 92eda90114e..0b7f393492d 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -37,6 +37,7 @@
 #include "ram.h"
 #include "options.h"
 #include "system/kvm.h"
+#include "system/xen.h"
 
 /* Maximum migrate downtime set to 2000 seconds */
 #define MAX_MIGRATE_DOWNTIME_SECONDS 2000
@@ -563,6 +564,11 @@ bool migrate_can_snapshot(Error **errp)
     MigMode mode = migrate_mode();
     int i;
 
+    if (xen_enabled()) {
+        error_setg(errp, "Snapshots are not compatible with Xen");
+        return false;
+    }
+
     if (mode != MIG_MODE_NORMAL) {
         error_setg(errp, "Snapshots are not compatible with migration mode %s",
                    MigMode_str(mode));

-- 
2.47.1


