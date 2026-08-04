Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F54C55184
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 15:19:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrGuP-0006fm-7p; Tue, 04 Aug 2026 11:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wrGuI-0006eb-CE
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 11:18:18 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wrGuG-0004md-TN
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 11:18:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hXdEVZ8TupaoY+Jo7adyvBuwGy8oGWNllIwnrJltOpd13FIL/kCzc0ZMMUDZjNhgsuN/o0ARp1KuiWk29gRZft2Qwv1+nC1Dvs4fkqnhcHvO10sFPqayHcmT5OTX1guGXy43XQoIDL+GUz5iCcZGg2iFCunG7Lc3Gy8Xdf6xgTG3QdauaKx/Xi8NV5gy1uqD4M6jAh6KiKwMByrPw3/83ZG46T9Sgw4mj+QC2nwCFv9SQrvvoP1WtRbZNp7u5CDmO2xKUA55vyMxIMUj1P1Xd1ExkkbKo8j4RDCfsjYzUYbziaFvvbUjvCnnv9eRGWhwRmutGDPRxusVazwElpgB3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AKo5yPpDHi8R1HQqiYlwipcvXSS1RvgcoYohPZOp04U=;
 b=VdKHds0W2/aumi5su4VfH0xqSMdEAvFfOpwXmJ0MesksTnET6AeHb+XY4B6sPl+/TQDlkif/eEwdJ32wDRfcmzZ4CfkQYNIUfeQ9zJ0G/MlEbwmzxcp/uQ3j/B8WruGgch0f7TvUzlE1zNZ0l1IhGiPgvILtQ0aburHXiz2+z8gW+RQKp4JM4BLhBEeRRgv4CcNp/9m85BXyv/wwjWmOPsV/U8ALys0ZTjV2BXvUfVQzE2A3vIlGiVQorktin1eMKAkwyN0w55ZMFIvMwHeqPXJakMDZIDLjZtlEu8+vLUZpVHunlRDKvJVeqiBX/6ZDJeQeceAwT8nQ9PtPumj3tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKo5yPpDHi8R1HQqiYlwipcvXSS1RvgcoYohPZOp04U=;
 b=r2u8CtfvRNFxoQz9QU4qehffwMm7uQMmKJAuceVdY7KIZhp1qUKlmDUJSfP9AVWU+xofpkRV6Hos8MFpXxpfwXz2mFGH0lu8ppFQRdnlrV9tbsXBublAQEFVNI2zuj91+DIt3gcPEo/mMG/A8sMakFAd+FzXRWplixm5I5DSGOE8jAv+YHpb2UToctCBHHW6Pv6omXZTKjrdjAd+6mT4Y3gxrxUQF6dzPguhTpsOM3IG5G1kqdkGup3u28R/FLiKDCPAe2flODIFzu4fTF+hXzsr/kaHhs8G88o5zml/bjk8HLLbTcWpEbmqYk6JTqqvh6Uaf25HrbjPnSppR7+d1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PAWPR08MB10317.eurprd08.prod.outlook.com
 (2603:10a6:102:330::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 15:17:58 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0270.016; Tue, 4 Aug 2026
 15:17:58 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, kwolf@redhat.com, peterx@redhat.com,
 andrey.drobyshev@virtuozzo.com
Subject: [PATCH 8/9] scripts/qemugdb: coroutine: Speed up coroutine lookup in
 a coredump
Date: Tue,  4 Aug 2026 18:17:42 +0300
Message-ID: <20260804151743.937694-9-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260804151743.937694-1-andrey.drobyshev@virtuozzo.com>
References: <20260804151743.937694-1-andrey.drobyshev@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR09CA0148.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::32) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|PAWPR08MB10317:EE_
X-MS-Office365-Filtering-Correlation-Id: 04aaf308-f678-4f23-cbc0-08def23b90dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|376014|23010399003|366016|38350700014|6133799003|5023799004|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: AJQuKKxC+KOzp5YNBzvfyt6C/Y/seB32ltzVpCnV3aMPGlogHjbNl0O0BQ0ZfLcTCve37EBKclsFsP1R/L5x+iq1brNUtIi8op1IeNwu5W32BvNs4toLQVITzw5157J6Ba48KQSiv+7bbM1ub+YckIEj95tzyUJP9Ztc3tV3lEJLbH5fgMTrHWKMaY/+8AK02cC7ixBMHTzEIsWWzTjoTcAO9HO6dx+HP7T5kDqUnVDKIlYEanuAr7vOH7M8AVN0F9bHJO/OQah6Ezjt0q5YYOu20/Yj5JmyvqA8CB73N69W22jpSvDV7gntfbnxa7JLNW7G28+JjLDjahXKvsaDT2SRn/EdOwTNu6pZVq3i4TU7BMikT5zGVastQwPsAV6vepUTqeW9szZGIhovbyJQOA5owj2bLC8xbq7Tm3nKzpxq5b4a64AeyR3dKicYqte8fpsVYMocqECvvXmcLA1bDT0+vgtECp6M+e7ojPqPQbo/ecjIOPV/VB953zKV6VWcmZBcnc91XkZnbcUp1Yv92lMTKYi/pkgIsiT3N/LhxWRh+SdHJyOkkafl7BbYaCFTj+ThhB+7dQydvtUqHj9VTpCvL6JaiDEOndomJtc4AzTEQgpyszUE9FGjwVWflc9YqAUp6HhRumYshp0gkW86GSSTqkKlMmCZUQtXfxVfBOO83nA+uIWIUPQ9aI5KpdrqmqwIPbPp+5K4DOs7OZEr1CYYGUCI+LQbO44Y8r3jIu0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(376014)(23010399003)(366016)(38350700014)(6133799003)(5023799004)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4sxX3Z+DUP6K6s0cLpkV9MRtOAnghbnVHAgN8n/OgZ2YQutZh9mRNPP74cQz?=
 =?us-ascii?Q?nResDIBHcEUUcurFkj7UkU0BWoRCB+YdO0gX/EFFMhYuVX7ZFdM2tSuSiIal?=
 =?us-ascii?Q?fH191u1fUX+2vIYn5Bk8sl8uFP+jJnE6j1g5lW84gHNeLOQrfW3sGwvUtZ0f?=
 =?us-ascii?Q?bXYul1ziUxr+Ukyjz63CgPspI4Sm5f/aUzyPRiMRQl5zVND+yNwNTE2PWr6X?=
 =?us-ascii?Q?BTnjgCkmX1bgR/FC/6EqiMECFgbRcVZDxRxHgA7hOkiFvcxrkMO0+9Db29rC?=
 =?us-ascii?Q?ZYJ9gvnXG0KqBKkdQYyTgxiwa9iSV2yNUrfyRiXWmtYGJoG7bFUQYIPe24KI?=
 =?us-ascii?Q?iIAHUcScKn2BTu7N+efpv7d3HSeRfVBrA3K1SAqYedPFe/pWwP7LdJZdU8Pm?=
 =?us-ascii?Q?2RrT2/pOkn4v2EFimOYPBVQoyZGO5bNv9W7M6r2F7EA+cb4QBURFyKvYrKOE?=
 =?us-ascii?Q?N0YulFfGOUQNKsX8k4wt1vg3PZx5gUbLs5zG+eTpy25Ki/1thuzdbwGrd8Jd?=
 =?us-ascii?Q?zZg/7ReQ0DChKskYth+kNnWZt0G5ujdjARea3/DPMjKe6USuI8f93FRUzDZh?=
 =?us-ascii?Q?UzTyBBkc41do99gWFuoNLHrg8Io1pWvOcpCHTllXLm1OOSaOUamJvgbBVnnv?=
 =?us-ascii?Q?XtTG0KJVjtAEy6G1QlJmwSdm15u2jDBswTsWBQEhXJFOzpBp7IyVmUw2+2KH?=
 =?us-ascii?Q?J13GvMwEUk6AlwALZVypziN+CA5fB1sN9klkMtuvbZ2/tKqe+/0bHuoPA+vI?=
 =?us-ascii?Q?yqywiS3jGG6QdkxJdTNg9cK4KaNSYc2EbeeYMhtrSgsNWe5K4JNv5z77VHa3?=
 =?us-ascii?Q?sQCYv23W+hdZksNjTcjOJJARP82qHswpJ4DGLTPuLQ7aq3ma33OJosrY6+B0?=
 =?us-ascii?Q?5gqWPII0ZWWmqRrqddFfzj9sTrcHF8/+n0BlvZTqGQD6tRUilHBhti0lOKYr?=
 =?us-ascii?Q?Uah3K4P/NxiBup4ySEmFVxY8cFJkqB5Sby6mDKCiKqHj+fS2y0YFGFnnIwaA?=
 =?us-ascii?Q?fqjKVIUWHsbM93zhCmf4/or8Vs9hM21NMZ5J4t/YmEeBD5ofWUUeeMZ4s3co?=
 =?us-ascii?Q?lbzUlNgF18cMZ+5vkHxvOExRczG3CBGOZyLnYvjAls8yaQaCbQw4UfI+y2XD?=
 =?us-ascii?Q?nE2GexZgKuU1WakaWIv1dW8gq9Ql0V/3zr14vce8BQnRAfNtg6d2+iacFHVj?=
 =?us-ascii?Q?hFSkT8905c2mTPwLYoqjtoRZFKZ8YX/XHq2eWDOWIM9zNHdSkRxijSx39lDi?=
 =?us-ascii?Q?yEUTj5+uMTqkNpbAdnuNpf2j2jjribzLQ2lKbZpDP2o5CCH/LJ2emotU1dxf?=
 =?us-ascii?Q?ZMwQ0BX/FH/G8Mbh+MRiGsO7n4oYHJx+ArxsdPQZ8TY5cDLDR1CMi8p1b5am?=
 =?us-ascii?Q?TLMMeexc/6GpWfncnv8xyXOAUXBuLxL4+LUGABo6gCPcymrcqLPjy3HWyYqn?=
 =?us-ascii?Q?OrUOFayMviQYSyGRDcY29aV60oyGFSHH955a2MN8r6BQkybNIfKumhavB8Ze?=
 =?us-ascii?Q?mKe/KRf0LsfVgIQ9jbWqNg1kz7mvHDqEdLdXNA7pQYevaKB9xuCEmPDBoXo2?=
 =?us-ascii?Q?5iMirbMvTChi8HmwX+ImN5amDJ+jk//hQcXMhULIWkMu7/R8hxS9YNGbt2o/?=
 =?us-ascii?Q?D4zFgP8JTl2mEJbVMQNWO3To0HBXuUb7pvYvCzvkK+jnk7V1wf5+br3qoLDC?=
 =?us-ascii?Q?SUpX5tBfVuW2QzcYHbjE2u6luh/8Z/VsHBbaiip4qM1JFNGhQbHB5WXCKAeP?=
 =?us-ascii?Q?cTkZOmN4LA816w+QvMBW/nDIH9Iyi8Q=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04aaf308-f678-4f23-cbc0-08def23b90dd
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 15:17:58.2820 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jx1TzKoDyouzp+i3bCLvrMJfik5ZZv3KnvDQHt3OzhEs6sA4ZZbSqWcl+dH1C77qirYFB/jFbMdqrgKzk85yN6X9FkVmjrc0wPXHlckmx/g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10317
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
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

'qemu bt' on a coredump takes significant time before the first
coroutine frame is even printed.  The bulk of the delay is resolving a
name.

co_tls_current is a file static variable, and CoroutineUContext is defined
in the same compilation unit, so resolving either of them by name makes gdb
expand every symtab in the binary.

Look the static up with gdb.lookup_static_symbol(), which is served from
the gdb's in-memory index, and scope the type lookup to the symtab that
comes with it.  This significantly speeds up 'qemu bt' processing.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 scripts/qemugdb/coroutine.py | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/scripts/qemugdb/coroutine.py b/scripts/qemugdb/coroutine.py
index 3e0b37b73ea..21ed7cbaab8 100644
--- a/scripts/qemugdb/coroutine.py
+++ b/scripts/qemugdb/coroutine.py
@@ -313,7 +313,16 @@ def bt_jmpbuf(jmpbuf, is_coredump, detailed=False):
         dump_backtrace(regs)
 
 def co_cast(co):
-    return co.cast(gdb.lookup_type('CoroutineUContext').pointer())
+    # Unscoped type lookup expands every symtab in the binary.
+    # Better scope it to the symtab of the ucontext backend
+    sym = gdb.lookup_static_symbol('co_tls_current')
+    if sym is not None:
+        co_type = gdb.lookup_type('CoroutineUContext',
+                                  sym.symtab.static_block())
+    else:
+        co_type = gdb.lookup_type('CoroutineUContext')
+
+    return co.cast(co_type.pointer())
 
 def coroutine_to_jmpbuf(co):
     coroutine_pointer = co_cast(co)
@@ -416,7 +425,8 @@ def invoke(self, arg, from_tty):
             co_ptr = gdb.parse_and_eval("qemu_coroutine_self()")
         else:
             # Fallback to use hard-coded ucontext vars if it's coredump
-            co_ptr = gdb.parse_and_eval("co_tls_current")
+            sym = gdb.lookup_static_symbol("co_tls_current")
+            co_ptr = sym.value() if sym else gdb.parse_and_eval("co_tls_current")
 
         if co_ptr == False:
             return
-- 
2.47.1


