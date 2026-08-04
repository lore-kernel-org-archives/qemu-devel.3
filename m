Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C353C55184
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 15:23:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrGyr-0001a3-A8; Tue, 04 Aug 2026 11:23:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wrGyq-0001Zu-Ds
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 11:23:00 -0400
Received: from mail-westeuropeazon11021090.outbound.protection.outlook.com
 ([52.101.70.90] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wrGyo-0005LE-Q2
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 11:23:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IjwmTUGUhgNXFgn2hlIdu7/g3NYbSHh1ymiZSUvEvcBGmyIq+HJhc1fe/tIIACxoHfiJRX4SLBdEq1yWUcO9zDY5oYH7kWbJixW5gzWuiZtBcluJviJAoa/K+kLxMabQjG8XwcDYXiaRoZaofEsnFW4FrtFaiiqKmfQNnKhXWgvtjPpHzADcxyS2iv8B7Tv0gdRrwRv+2r2UmUTejDLJTyl9qA+QfRLxz4ksGjpriPKrTI5vnjCfSP4hCc7iZ79Rwui4dvoRBQnB6h/CPrm789AkT44IAveV7JYi3EzQhWGYOJS21AZvb5xqHFDsa7wJ3pkMoOsn6raeGGtcJsDIIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xhm+DC9Bnesz0E11hOU1Zettghsj+W9WuLmdOiaFuZ8=;
 b=c7VclPBBByFDKVyAx0WGoZQwMIotMmMl2FSWZ0qKuzG+vRyv/oLUiNRkRq5BXjfKvOGNckjTG2s8aScjdNWDN1RIjgYC/B9ws8Mhgo/pohQqMe+P4xH7xtFvmDU4b791jRaxR9GeQwAThESHemG3HkiE4U+bFJEMjOlBuG5GW7m4oyOZYi7U/jX5ve5UfUSOyY5AGYWc5pY19UOvrOKJ4mN+X/+mqrtD6+Te9XDC9ORKC+3e6tmUIQOmj2SNyYCEZ9oYIqlIkgJUZr0Msjh9TyV1zTq8Oe/AlIFmLoabr0Pe7Iy21WmOaXYRC2M4VdPBxfyXe5TKwNEkH2Jy/n6MHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xhm+DC9Bnesz0E11hOU1Zettghsj+W9WuLmdOiaFuZ8=;
 b=xgDaEXNE9/bcynzPJvYPkbQ7UXmXsiFEGSKlK+qoiqu4j932ELU6/8/Dtje5ygz4a1Xq7x1DXQmSUm5vfeU3PijRpeeUh13Q6+mQi3vmupkjaMeChYZoynmhiiqfla3di8cyCpgO1Kee8LS2HhMBehTHjmnx266k/ecdG8rdxkQVMTiYftueaJ3Mn+TPKCCPoCgUnDlnsqkoDrZaRogtLY4QhKHKWKv559+5T6KN3iwymJ3gkrGOoq9gK1DCrcGQ+5O83kp+muQLqD+LfTee9x6FU9dGuklydHETGJkGOB/KhQE69o0LOc3+lRAqudSF+KabGHeKEceNzivCxA08vw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by GVXPR08MB11713.eurprd08.prod.outlook.com
 (2603:10a6:150:2be::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 15:17:54 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0270.016; Tue, 4 Aug 2026
 15:17:54 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, kwolf@redhat.com, peterx@redhat.com,
 andrey.drobyshev@virtuozzo.com
Subject: [PATCH 2/9] scripts/qemugdb: coroutine: Get rid of fallback pattern
 when dumping backtrace
Date: Tue,  4 Aug 2026 18:17:36 +0300
Message-ID: <20260804151743.937694-3-andrey.drobyshev@virtuozzo.com>
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
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|GVXPR08MB11713:EE_
X-MS-Office365-Filtering-Correlation-Id: 43921ee0-479b-4d00-e41c-08def23b8e46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|52116014|1800799024|38350700014|6133799003|56012099006|5023799004|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: dx4UQN/7SU3QOkEYQXpMbRjHHQotDFyI7GmNXnrc2+NgPCFxy/Ae54c4+AvDsuy3Bn+uA3ccJbOb12zBIV8+foBdy9OLKwQFTV9F86N4K6WArZjDHkCRSFnAqn2P2FLgXtsw1mwqTFPCC8y/zo9v4klUyal0xmg9Dn+L8KyFzrHIYLh194/HbIFK/yTSLvxOxNxqY2hDUy3GJus+qtG24CBWP6gZypVKDyu7e12ElzjtZONgIfkkO9Lev6ecQ08cMwhQ9xIkLN9no6WVhPr/cCWaCDsBMAYcf3qvsSWth8U/pHTLJE6EYyGMPLhsr9/siD68GAqp2QHCvtfMzqrWUdOVTT+1k4I7sWU2+VNztF9k+Z7uFwafUr4Ab1jJcQAwe0b0Zk+QBCrmrw7xSwteOBMQE3ODZMddr2kia6cjyQ7IcbKa7T/+WO1idQiJxCGBjtfCsL74tcGtfl///rSQ+DeLDm5lU7fZX0+gg6BQoROer+HRRWcKyBy+7uV1b3cbqgycQNdmpHnM7h1WV6K/eaVhQZ7TAtYcnAWhqQIAxMgZtSchNeTPkM8AEc5yl7qDLbWmWwzNL1P6BtbuBXw5P4eGv2kmes8z9AT2XTP8nC3TcS8DxgNR1LePB+cgHxencI0HdhN89HIt4qZheBFu4Fxi1NzGOxJxTv5Vi449deLX8SjwGv6xMzc8MTQCONtzJgQiGr6/qcl0beyxbBKNXatnV7/FUpHuo2NdakLiLG4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(52116014)(1800799024)(38350700014)(6133799003)(56012099006)(5023799004)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bHg5AF4DiPG6F/5mFfcHy9P6PP6nIYgHzvYkTvmXU7GDSr5GbguVbmV84Mhi?=
 =?us-ascii?Q?9UdCC3geT4Ki/UsOU0t3+1wxYfplOKG5qOZs79chLwcWNRowtBHMq1WOo68P?=
 =?us-ascii?Q?wOYXPCBZbRk7G9+28+Z4ZtfBmUQZSbiETVMEWgFJemkNWjdWYhuyiRtp0EnB?=
 =?us-ascii?Q?ip2UqrxsUT1yfXbGoTFhPw5LjkYEi87Si+fBQj6L+sqb4CCnKeOzX2zzaSdF?=
 =?us-ascii?Q?gdIge2fVPlhqosbKUFphnVEXaEkZXIBbMkMXwv2KXxWFQ34gEuRxHpaCem8z?=
 =?us-ascii?Q?3HywjO/4crt77krURq42VbQVzM4giL2lTSM4ca2EPpTBMZKkBD11cE61eRmU?=
 =?us-ascii?Q?f8E7N/Qkv9bj+1OERAeYpZD0l6IyrpoPNEzdM6HDFc1z7N0qb0t25lTOAHSm?=
 =?us-ascii?Q?J9iuahT1Jsg10aWPtWPzIAQUGoq0rmUPkDR2+B+Xactr25wTn4Efuretd9ln?=
 =?us-ascii?Q?pObXh/2k6VWH6muFD6PoQKn/0v877ghXLS7ElZzNfs+RH2yb74bDpc2R5Nlq?=
 =?us-ascii?Q?svLGFJ9WcfZOz0P9rdlBnvYKO0E4fChotvLdT6WOMCq69lKR50Nk7XgD7RYx?=
 =?us-ascii?Q?7n+e0Bu11HAgw8ny07Wf8zJ/vtF3t1mwFuj2u6f+Mqhn6PTSluVMtydvkvd8?=
 =?us-ascii?Q?qxbZ/tknI/4ixrgx3BQNievKRSirCyMRmDRGqyL7ZklA9fao8RykEsIjpxah?=
 =?us-ascii?Q?Ai329yVXD2IGchux9+AAg7gIYxFzjwMELdK6lxt7qMP8zUcIihu0CTVml3Am?=
 =?us-ascii?Q?gR9dYdCR4SFvHKGxlu3rr0MZHniQc+WzBluMjn56UDP8u8y4rL2Aim/JyjpY?=
 =?us-ascii?Q?J1M6IBRf8QPlarF0eddg2j/qfHkMr/afTmsPtp2VFxSLqHu7SYkJx8n6iiAA?=
 =?us-ascii?Q?dKPYq+f85r1uyExGMIbK+XKq40C9mneosdGW0nu6rmgotAKNPsoxocOoMdzj?=
 =?us-ascii?Q?ALsk8Uus8xbQhkaYvXxFiBBa8grpZgibl2ubTkaJNCyR+XQEC/80qT2Arv0A?=
 =?us-ascii?Q?3Qv6MEqeyuKO3FxpDLkiO6Y1S136mH1pm7ukDLtu2fiMUAblphT77LbpyWXC?=
 =?us-ascii?Q?mTwpqNhHZZUTuei9ZZmG+GD1PgBHjcf9BiV638bj0EXl3MQNRnV+pAEpg6Yx?=
 =?us-ascii?Q?MbBgxyxzRXQfJxUIrvD3U4+FHwBqP7CbvrO1HIVuV3fN0dBm0xykfnvQHygj?=
 =?us-ascii?Q?jcBwGxZ+2XWy2jTw+hVDMGgc08num6qPJFPMl5VcMXzNWoLCOmkmeqm0ZO7b?=
 =?us-ascii?Q?HrEDk3MUyZutlc/CRn1cFDcZJE6Qw+mun6LDkdaY7KrkxJ2Emqi4zKQOorYS?=
 =?us-ascii?Q?RiSe+1tgQZfjH8dDcyYIIujxfr0z30Doi31mglr3DJdS77KNImrtVAQJ+Ntb?=
 =?us-ascii?Q?aQM1v7eR6mfWcPpFhRPtVZ1zuJw/q4WS/V+FSpgvvWFKlp6BNZdO9uNjMmKU?=
 =?us-ascii?Q?B0pFwkMLaBDHi5rKmmD4qKZVGqq8LJnPmZ4t//MA8MUmBnrQwzZUKySWrAWg?=
 =?us-ascii?Q?WZucwxBmW2/C13CyXDfXHqmdcoPIiN2fLeJJEBtbAsdHOCRyeWPHMHy4AE/+?=
 =?us-ascii?Q?3Nq84pgAsH17xUlBbmXTQVvq4kq3jDw1ZSrHJMp6RpGQvSxoTt9csALwBrrm?=
 =?us-ascii?Q?qa5ME0LFIoLEQxn7h/f3K3goUnjXFSsUYA+GtgxVKsV5YW9RVwD6wTjgMm9U?=
 =?us-ascii?Q?KkHMIDIO2B36uZcxN1fDuj7LGtoJOS28ktLafLCO62LOrTaXJVPhLvgi4Gx8?=
 =?us-ascii?Q?iEVn/2QZuwQ0r5UQDRyBeyn8FZgVdes=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43921ee0-479b-4d00-e41c-08def23b8e46
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 15:17:54.0427 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zaao9xsTYmR/pc4idGpQW2h5RnGiMLVw4Ci7Hg+I0Fcw94z7KVWnmaOj3s0Gx2bL/pWOXj7OoizRIV1bPyQBp8ctzLSHyjb1IjtFyjUhTd8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB11713
Received-SPF: pass client-ip=52.101.70.90;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Currently upon invocation of 'qemu bt' / 'qemu coroutine' we try live
process backtrace dump first, and if it fails - fallback to coredump.
That causes us needless work and catching an exception.  In my previous
commit 42f3c143c3a0 ("scripts/qemugdb: coroutine: Add option for obtaining
detailed trace in coredump") class Coredump was introduced, and each
invocation already calls init_coredump().  Let's just pass the result of
this call further as a bool param and make a decision based upon it.
Apply the same pattern to obtaining coroutine pointer.

Note that we deliberately lose a safety net here: the bare except used to
swallow any failure of the live dump, not just the absence of a live
process, and silently fall back to the raw unwind.  Such a failure is now
reported to the user instead.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 scripts/qemugdb/coroutine.py | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/scripts/qemugdb/coroutine.py b/scripts/qemugdb/coroutine.py
index d1e6722d14d..d3f31bab9fe 100644
--- a/scripts/qemugdb/coroutine.py
+++ b/scripts/qemugdb/coroutine.py
@@ -281,20 +281,19 @@ def dump_backtrace_live(regs):
             # restore previously selected frame in any case
             selected_frame.select()
 
-def bt_jmpbuf(jmpbuf, detailed=False):
+def bt_jmpbuf(jmpbuf, is_coredump, detailed=False):
     '''Backtrace a jmpbuf'''
     regs = get_jmpbuf_regs(jmpbuf)
-    try:
+    if not is_coredump:
         # This reuses gdb's "bt" command, which can be slightly prettier
         # but only works with live sessions.
         dump_backtrace_live(regs)
-    except:
-        if detailed:
-            # Obtain detailed trace by patching regs in copied coredump
-            dump_backtrace_patched(regs)
-        else:
-            # If above doesn't work, fallback to poor man's unwind
-            dump_backtrace(regs)
+    elif detailed:
+        # Obtain detailed trace by patching regs in copied coredump
+        dump_backtrace_patched(regs)
+    else:
+        # Obtain a non-detailed trace by poor man's unwind
+        dump_backtrace(regs)
 
 def co_cast(co):
     return co.cast(gdb.lookup_type('CoroutineUContext').pointer())
@@ -353,7 +352,7 @@ def invoke(self, arg, from_tty):
 
         try:
             bt_jmpbuf(coroutine_to_jmpbuf(gdb.parse_and_eval(argv[0])),
-                      detailed=detailed)
+                      is_coredump, detailed=detailed)
         finally:
             coredump.restore_regs()
 
@@ -390,10 +389,10 @@ def invoke(self, arg, from_tty):
 
         gdb.execute("bt")
 
-        try:
+        if not is_coredump:
             # This only works with a live session
             co_ptr = gdb.parse_and_eval("qemu_coroutine_self()")
-        except:
+        else:
             # Fallback to use hard-coded ucontext vars if it's coredump
             co_ptr = gdb.parse_and_eval("co_tls_current")
 
@@ -407,7 +406,8 @@ def invoke(self, arg, from_tty):
                 if co_ptr == 0:
                     break
                 gdb.write("\nCoroutine at " + str(co_ptr) + ":\n")
-                bt_jmpbuf(coroutine_to_jmpbuf(co_ptr), detailed=detailed)
+                bt_jmpbuf(coroutine_to_jmpbuf(co_ptr), is_coredump,
+                          detailed=detailed)
         finally:
             coredump.restore_regs()
 
-- 
2.47.1


