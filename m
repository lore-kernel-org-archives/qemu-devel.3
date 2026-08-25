Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D934C61DBC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 17:22:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyuqE-0005gz-7L; Tue, 25 Aug 2026 13:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wyuqC-0005gp-S9
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 13:21:40 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wyuqA-00058O-Ku
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 13:21:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OY6U8MwOb9wrCDj4gfAn48GXlpUlyoVU5NV/nRycozyJcbivMmrrx5UQWygIrYbKi7Go3UQvLhOxW0hsuzVGsG+rTRV3shqbRzhXsBWeRlFyG45MR0YTtkLwbD2qpWnn28RKhdpDrgs8oYM2jlKpX5jMnhvYxoasq1+z4zqsByvBwxa8aqJ2+34/z/iUJxuKnEiXDBpY/xGWDoD5O6NIJ3DzvWVPRhtXXt8xvoZUpTn7poq3RWDBBXyzkDlsM4z9JhKi6uYNL08azc0Yk29hGvN4QzRM02NM4mZdF5UQA1XsGbM3IHQrM0+H8GF6mw2lhgpyxJAtnUgOvPA8qv+NRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m+609TI1T8feS74l8FQNFGmiRmggBgeWxZHDYMtFl4c=;
 b=F8X8hm4762J8uToUVwQ7hh3J85FhAlXtVaj93A9YLHCgIvcACq3ILLITWSxeWmZcnLg6e1JAGimhK0ZI4/HEcT4B2kwvz6DRf2+UQh8R5D3aFpT5dbtcdslqP0+sTlryHCwoV7FLEDWL88nPzP+gaOQyBInINn/d7oRAEWjkZUjPVASi4L1eze8fbpMPiuAVc2fLU+b4hAQADOXIYojiv5rgi4yBccyXHHJ1ABioC7YYqYViGS/ISmQHba/jYOwQIVvccf2KICAhDvu3VVh76gtNu3OG7lfl1+NWodUt6Ntu6EhWEXcPfW+jaCQq9s1V9PeFwYxhjJJ+eV9uCzctzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+609TI1T8feS74l8FQNFGmiRmggBgeWxZHDYMtFl4c=;
 b=rK0rKjNB9GwVwkPtlkV8TRQQqk6tDGECqMlQw6ZPBHirXj2xrumtOe6OE4Vbydw3ioHvxNsDtatOgsfaXM1r2IoisUSteFev7tYJDhYkbHbye5TAXAEZxF1Y8Lpbi81jGHgNoT9RcrGB7zkq3wxf8Li+dWkXfH2Cwv3J5UTFv+7cvGxEDiD4bFOtV3k22mZM0DWGrTCLlwgh3mi8meDIeQQtA3NsyElKuEfB1UH4QlsUp91n8ADU/9gpDfeivKK3zm40C8onlTeCr2+/PdFKEqfp00cTabs72eQbhn0UJ0bwPGOQmCjsWl2nGJFZMefMcddSviKpQQlMpllVQNTqyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PA4PR08MB5902.eurprd08.prod.outlook.com
 (2603:10a6:102:e0::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 17:21:00 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 17:21:00 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, philmd@oss.qualcomm.com, den@openvz.org,
 andrey.drobyshev@virtuozzo.com
Subject: [PATCH 3/3] hw/display/qxl: trace skipped stale loadvm commands
Date: Tue, 25 Aug 2026 20:20:51 +0300
Message-ID: <20260825172051.435372-4-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260825172051.435372-1-andrey.drobyshev@virtuozzo.com>
References: <20260825172051.435372-1-andrey.drobyshev@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VIVP296CA0001.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:357::12) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|PA4PR08MB5902:EE_
X-MS-Office365-Filtering-Correlation-Id: 078e00fe-2bd4-4f70-a475-08df02cd3b72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|52116014|1800799024|23010399003|38350700014|6133799003|3023799007|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: +0cbooYEScyaaKWmp/c8EDGmcrGSMs90dFln3hFwVc+W3Y+QZ7DzWAs3V8yyY0hwPfUIw4ua9zccWkqPyb4RlVhOj7zAyt0+YDKQfOpFLj9u2VYGpp77hHiubs4LywoSyyInl6XWIuB4Uz+8gLMQIcMtLUVgqAvNcnnHmhCgQajS+Y4X0mHvh/Cuf+wJdgo/xGITxjjzxPQX6ItpVQ0lNVwhb6m8yQfTV6UfoP6hLM1roEqrGIctqj6Ds8+l8H3EhbPZ1Z5/D6qHhs7qsbqaQaE9PE9nCb4XmptCoODK+z6jRY480FkFNbxYNDwZzu67n2gv2mrA7YRWnWxJG2+V4AJma70C6b7wmwYQ+CAUMH1DsFpHz069IWDTr+6LAY+iCwU9JNTHAysyhh1j50w4xfgEC3LytrsCY5P2kzqQg0Ekp/yP8Xy12F+IXXqlOp4r70lv2D+85DLotCzHBvpyB6FVcdErt1oNepoPq9iRyIFpqp47R9uLIh46G7MGLFy5sTQr39gIrmVeuIhhk9ebohMnYQqzucCaD7ZTXYROaCvMTnQWFjbTUAyuMMH7wOpnuYMUzpu2wDLV9UA/22BZKOb+kQtQrGgUis6ESmXk3ewdlnPAAhgyHvTHHQjJETQIuShW/jNouVo9MnA6PdRrg+o8bIjlnifwI/ATlvis1uo5ZPKzypZPygZZ9XZBGlIBX7YaXReXfVCZogQrcNh+EW81Sqf54xuZZ0Sv7V3eyjM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(52116014)(1800799024)(23010399003)(38350700014)(6133799003)(3023799007)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bWsCNK+qcNsvpFKgpS1JgT32ClOraDHye0L8HFHUO2rmkqtr+4K3XlDyBwrg?=
 =?us-ascii?Q?3QG3R32LHW+SEI80ZqkuFWbqSG09UG+mHrAd/2PxdzGv4+MbLjGWmxbexZnW?=
 =?us-ascii?Q?bE3KZWJf0Yka1nUgn2ECMGZKzgBOgFAa4G+42QdELB7Crq5vw77ic8P9lM5u?=
 =?us-ascii?Q?xqbP2+fNurfaATOIeVFdN1wOJXaqd8iAJccTz/iNMZzmiTpvaw30H+hbvfBN?=
 =?us-ascii?Q?QkhI+B03L0iKVHTTwwG+GzFd4O5bKELUKwEJBCzyWJbccbBihh6cKAwjFQMG?=
 =?us-ascii?Q?2ngAWk6sgpyS01gdj/XYwAJB/I/qK0gTpMkOKx+VZ8wUglk08D4mjdNNUxfq?=
 =?us-ascii?Q?O/hfMSgEZcS9ISsFAKKay3phKO/FYK4PNn8ab/P/C5ttpyV8MVAc6Y+LTbD/?=
 =?us-ascii?Q?ji5OXjNcImlhjlIaTm+vxtNk/LRjbluaUOkz8g5fVRx1ymgLlnyND0c6cJTV?=
 =?us-ascii?Q?TQWsronzb7KsQpVvWZuIqv5Nj6WJEsttPdxMSZo8Srl4B4UAZLWRKif1F2ma?=
 =?us-ascii?Q?zoqRWYcVvI/R5HCZsKkpgQu2Oa9+92x9mKUQfd0zh5DdbC56F7yAlJVlFqON?=
 =?us-ascii?Q?RwEWdgcoPixUKETiY1dGZSeBZNibHGgdV5Vjgwx2TPtsQS4Ef2vKJUEU8PSB?=
 =?us-ascii?Q?E4VWtZsXZbi+BHBDXcZVEHBPYtVivuvmFaupTfC1gw2htAlJSxKd745wYB4d?=
 =?us-ascii?Q?Mo8ltjcbHtoL+d53y9ehbd+vvI0rUwf7AU2Gu4gPyZssj2NzbRew28ukn6cW?=
 =?us-ascii?Q?VCxvsgzb946x50/RM2nLBMmihwDYA4RZaI+G8vCiHnDdATpu7lduyhj5NGch?=
 =?us-ascii?Q?b2rN7Gt3yzDomqcOXnmA+WZAzMloKsSw5tUUFUyOF9iOFpGm/crJH8G/R+rQ?=
 =?us-ascii?Q?9kGb3i/ukwMmwakW7DUFAkMUetyh1uA16K++sd4wZMD8lnTuR+aq9bCrR5Qy?=
 =?us-ascii?Q?WUHvncpAHS9v0Dkaf2PWelVmnhFoE6f5NOi4WwM87Bh8HDmKyNzi0QCHjzgR?=
 =?us-ascii?Q?bDZDsB/auvchzxmmJQu4yOTtLioDDeyrzF7k8oCjms9LPgixyoivClOHbgQw?=
 =?us-ascii?Q?sq4wxDxMFtSLnRHuXRaudRu76wc6cc2NkpJIUr9u0Qq5r0mtKYZCzqfC8NCp?=
 =?us-ascii?Q?9Wb9pA6DRgrzXsxha7I1zbX095ZXRGEWcMFn2grmT3d2hK1n2vepBDY5HQfh?=
 =?us-ascii?Q?kuGOURsMmCOJWlccmz0/J8WVmoJxFgZoxdljac+58HOQs0GpjGAh/lYRkvfL?=
 =?us-ascii?Q?TvvQ6SWN48IV4PRO6JDeVZg0J6BWR5+B/xqu3j/cItrciKhEzgGOgQLZHT15?=
 =?us-ascii?Q?ZLzzQyXkbgPgiJrbaloQBMwUe7ozEbDS7yCbAGM+utHRJCBwLa85sNh/KtWM?=
 =?us-ascii?Q?4cZAlRlUrFSWMM+8zIOk3Wab2Y/77nsb+hXRbyr3vFPWBwE9XYe2hB4aBMug?=
 =?us-ascii?Q?l6Hy5gyYJ2cOikaWSKqwcmP0VqpIBfalPT3oZCA7p5r8+TdI7rVlXLQ4wEFu?=
 =?us-ascii?Q?ebNKDTdcyWv/u+tdiPfpm8qqK7n7qmqUs9cPNh2SWCCDAed04VpgUMnhj9FM?=
 =?us-ascii?Q?J0A+NLIF9rWCh4B6qqas8A19Ablgesd5MBVv+XYSQHJwLhpKBVfXkJJFM3bh?=
 =?us-ascii?Q?c7VKvuu+VQN6gWBOSM2EXsxgPlrgMno5CW8EPsiiqaAZ74YIdGW2Ow1u4wYA?=
 =?us-ascii?Q?dZXz784lRsYuPJBY2+KQuTNs+yQez4PkXLYAT59OF1kAhoknc8DpNSjR/CNk?=
 =?us-ascii?Q?RMe0z/f7e2vRcJIEgbS9Lt+MUg1wGvY=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 078e00fe-2bd4-4f70-a475-08df02cd3b72
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 17:20:59.9904 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QpuC2IEUTfo7Lvf1XK4dIeAsLHWryCgm9OxZbAhZwMByMxO/6u9J3gHZ0s6I1lt6+yVf5HuLuDRQ5clfnILqhGm9Jf/EiC6Y+wPwATpP6/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB5902
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
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

Emit a trace event when qxl_post_load() drops a cursor or surface
command whose guest address no longer resolves, so a migration that
lands on a stale tracked pointer is visible instead of silent.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/display/qxl.c        | 17 +++++++++++------
 hw/display/trace-events |  1 +
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index b9b19849738..9e7bc5c668f 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -2400,6 +2400,8 @@ static int qxl_post_load(void *opaque, int version)
             }
             if (!qxl_loadvm_cmd_valid(d, d->guest_surfaces.cmds[in],
                                       QXL_CMD_SURFACE)) {
+                trace_qxl_post_load_stale_cmd(d->id, "surface",
+                                              d->guest_surfaces.cmds[in]);
                 continue;
             }
             cmds[out].cmd.data = d->guest_surfaces.cmds[in];
@@ -2407,12 +2409,15 @@ static int qxl_post_load(void *opaque, int version)
             cmds[out].group_id = MEMSLOT_GROUP_GUEST;
             out++;
         }
-        if (d->guest_cursor &&
-            qxl_loadvm_cmd_valid(d, d->guest_cursor, QXL_CMD_CURSOR)) {
-            cmds[out].cmd.data = d->guest_cursor;
-            cmds[out].cmd.type = QXL_CMD_CURSOR;
-            cmds[out].group_id = MEMSLOT_GROUP_GUEST;
-            out++;
+        if (d->guest_cursor) {
+            if (qxl_loadvm_cmd_valid(d, d->guest_cursor, QXL_CMD_CURSOR)) {
+                cmds[out].cmd.data = d->guest_cursor;
+                cmds[out].cmd.type = QXL_CMD_CURSOR;
+                cmds[out].group_id = MEMSLOT_GROUP_GUEST;
+                out++;
+            } else {
+                trace_qxl_post_load_stale_cmd(d->id, "cursor", d->guest_cursor);
+            }
         }
         qxl_spice_loadvm_commands(d, cmds, out);
         g_free(cmds);
diff --git a/hw/display/trace-events b/hw/display/trace-events
index 4bfc457fbac..c5e7e42af23 100644
--- a/hw/display/trace-events
+++ b/hw/display/trace-events
@@ -82,6 +82,7 @@ qxl_io_unexpected_vga_mode(int qid, uint64_t addr, uint64_t val, const char *des
 qxl_io_write(int qid, const char *mode, uint64_t addr, const char *aname, uint64_t val, unsigned size, int async) "%d %s addr=%"PRIu64 " (%s) val=%"PRIu64" size=%u async=%d"
 qxl_memslot_add_guest(int qid, uint32_t slot_id, uint64_t guest_start, uint64_t guest_end) "%d %u: guest phys 0x%"PRIx64 " - 0x%" PRIx64
 qxl_post_load(int qid, const char *mode) "%d %s"
+qxl_post_load_stale_cmd(int qid, const char *kind, uint64_t data) "%d skip stale %s cmd 0x%"PRIx64
 qxl_pre_load(int qid) "%d"
 qxl_pre_save(int qid) "%d"
 qxl_reset_surfaces(int qid) "%d"
-- 
2.47.1


