Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC905C3DA45
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jul 2024 11:55:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSbL3-0004jm-MU; Sat, 13 Jul 2024 07:54:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <taisei1212@outlook.jp>)
 id 1sSbL1-0004jE-Lg
 for qemu-devel@nongnu.org; Sat, 13 Jul 2024 07:54:51 -0400
Received: from mail-psaapc01acsn20803.outbound.protection.outlook.com
 ([2a01:111:f400:feae::803]
 helo=APC01-PSA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <taisei1212@outlook.jp>)
 id 1sSbKy-0002lL-5d
 for qemu-devel@nongnu.org; Sat, 13 Jul 2024 07:54:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CqmkNRxsSkTEEb83NfsGVc7rhjibC4sg4ja+VeAY54W6PMEJkbPcWvdAVLF1gwe2p5sL5IUcPzN7pzki+lJGljMm4ZJ8R2Mw1lK5BqXQGmEjH44AwJV6HdZc3Bcj2YhQH3kOiCFRJBT1PoG7ZvJjf1Z8TQlv8XgFdZ4HosTembtiaR7FMWAHLRA+AApAp2xNGW9MGJh4YlwUXpmbPrm2pq6xy+8A2XTjz3iHs5Ai+/FBb1CX10BWGfmFUqrWNCj5myMrzo8mU+8U/W9cFNF5diZvCflcu8+p8jEq4ub8J3ALGbij4DstRBNHzozf5YrE037LQdsXlT9jj5Oq7IqU6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8UCbt/BfdAM3P9aaNaAXufebf6a4oTFhdeCDWg29fok=;
 b=iDAogLU27QhC8dD8vj4o8SoKxTDa1G3zIrUPAIXQr8O8e4OpKpl3m15PI6fwa2p/+ghzvAQ0emcjjw1owVDwdjpzjVWJ2kERMjj7CoE3y6aFyF7Zb1iaX0lqRNydZoRgNG4DZ7juBsfJ8GdfMV5XlqOZT+xZMMq+sUJZjclaV4SH7OYmNWkDRJuWJ8p0z82skJBiGTqYtUDGXEnxw1+BImjvAT5aG/AArWE7vU42MeTlACcBis5VUM7AUS1kLxBi3+3OP2y3lu3V54UfSqOmwbDtw3dRBvqs6WqXJVNlE9js6SZ1qdo5+y8f1Tx2PlhZSRA8MkRLmm+vbe+S7mp+0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.JP;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UCbt/BfdAM3P9aaNaAXufebf6a4oTFhdeCDWg29fok=;
 b=kjfxuOMchH8jgz3dScEYJrFtG9Y9TH4ra3kqD84ZyiefuSjUQTZNcwLVXBCiBuQKJA6XvSkzn8S0AUwy9xsgTZ1RqNXd2tXaZQbkjwIShqnz4nEQ8pe+CxJjps95qSEPncwor2pujQtkMFEQs9qLk3Z98g7oXJ+Yg9b6I+Bf48xStIBNnxXNbV3uWc+yxDLJoa5Zrk045HH76MhBmsaS6S4KhwYCRMxhz/6CW/OqqVsnIZ2yTJUD5yrjZsvxi8A/lgkSRen6H+4g1w4EJ96yvlBWAxcdA1W4QFR4rfowPD67m4SGtaZBEBrCZLDMmT1YhINTlSIZC6CDGsSBhYIbyQ==
Received: from TY0PR0101MB4285.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1b0::11) by KL1PR01MB5922.apcprd01.prod.exchangelabs.com
 (2603:1096:820:11f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.24; Sat, 13 Jul
 2024 11:54:39 +0000
Received: from TY0PR0101MB4285.apcprd01.prod.exchangelabs.com
 ([fe80::85c5:f6c5:8a81:ee35]) by
 TY0PR0101MB4285.apcprd01.prod.exchangelabs.com
 ([fe80::85c5:f6c5:8a81:ee35%6]) with mapi id 15.20.7741.042; Sat, 13 Jul 2024
 11:54:39 +0000
From: TaiseiIto <taisei1212@outlook.jp>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 TaiseiIto <taisei1212@outlook.jp>
Subject: [PATCH v2] hw/timer/hpet: Fix wrong HPET interrupts
Date: Sat, 13 Jul 2024 11:54:17 +0000
Message-ID: <TY0PR0101MB42852FB948F0F0E8E753E257A4A72@TY0PR0101MB4285.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [TzNrwPH2NerMOTzt6D8tCKg8mjRWjLzP]
X-ClientProxiedBy: TYCP301CA0056.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::18) To TY0PR0101MB4285.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1b0::11)
X-Microsoft-Original-Message-ID: <20240713115417.11937-1-taisei1212@outlook.jp>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR0101MB4285:EE_|KL1PR01MB5922:EE_
X-MS-Office365-Filtering-Correlation-Id: baa2f303-2a24-41df-412d-08dca3329213
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|461199028|8060799006|19110799003|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info: c4+kvkJVq016on1Rc30930nQAwofvm9cEXfF+uyJQhRvtaXFgYJ41U9hEZlVKaNPwjdMmMros1VmYNwlyHIAhwwyaN93Qg3CTNCo4qexUUbMalvFI6+e08DeS2KoYAdQljAmmIWGWSMHXj/BWR9gKrB6cc7lu3r/5YyfIvW8I13BiBztlo3x8ht0aC+C+SHrGQ9J/obWpEG2wQyM/0rXAN1X2FTy++7zRad+8tTTqQsM/Lo/b/Yv+lPMT3fSvSCRgP3KOoOMieAhrQa+P0RCOXFCH8gg/jAcy7/03JpjzTHPSxTp1SBPYHPxq5v3X68sQH3I2OX924P4tMF36jO6OJd3QP4rTwtBL6rLPfftOOE4F92FLy/dXjFhJgbr8B+FMra5DqLTxQryJ4cie8N7kLPYz6BYSwHASOqwjU66NruB5CyrpKyRggOBaCFAlR6fy9pYmhuFAdUSwrcq2P17SRqI+jOAwuX/0p8tv/lgh+VNMeHxBKqnjbTPODmuvutvjwbw034Mte39EDknFYfsCXXr5Op5qt/aYVvK2Jk2YuVLr4IEazd9JyWtD+9vC4xWy18ID9Pw900sQwOtQ2Bj+CYbwI6nT51ODk2JyO2z7uk3lDD3WqvKTuizXCF1z7Y+7Zi3UUrguwTybDWouzbZrDTvRKOncSbyk3Z3PatbE5h6scEQHliDbfwVmtoPJ1yrRGRIFJS0FEQBEXA4KzKyMCpNs2H/SGLpYZKCihg2umM=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Auc3USeBa8RD4VIoNxOVrmMmwpavt0qIE2w58c/7Z1OAapnVrzMC7A15Q9Hj?=
 =?us-ascii?Q?ieTIK1ZmCkQ+rJHIHVEfPDTS/zmi1PdgGnuqn67aPCI3fnQUVbXw1IV5WfjY?=
 =?us-ascii?Q?zu1clMoj+/YkIMpHY93lBeh5GtuXi2QSPTeS70869C0IVh5LSlvCzxiDNfSj?=
 =?us-ascii?Q?N/G1acHE2hI1HLB3rwC/XWdnDvXvhfeP3QQTIoLX0YK367YIJ5L6y+tLB5ng?=
 =?us-ascii?Q?G/En+/dxsITq1DiPIQkQVvy2c68hqrvE897nReZxJX8QKyqmHPQTatCThYX5?=
 =?us-ascii?Q?rB9d16vOenIvCl81Scs4VzuBftcF3IJce2dMsqhpXPyBcTCnA1S6aObWbGso?=
 =?us-ascii?Q?WrVkYZKrw92ik6c9hZjEKtdTQBExLFifO5Fppp8fJMNxy2WbExKzkBvZR72a?=
 =?us-ascii?Q?0QJhEe0gl8KyQgecXrhLYeDTX/PTwNkMCJct4ULppueprNly46bVbsz35Xkn?=
 =?us-ascii?Q?XlxHUyBDNv3AsNd3i6OfAd6SrUQPiqDSyXeztuiilMWqQibEDzpR7ieQ/LYk?=
 =?us-ascii?Q?WXh/nKAotf1jox0dbkKsANpg4YD8AEqcueRidGVFXGwjKYhadwtP1uOFrDVC?=
 =?us-ascii?Q?Za1bChpNgHSmtBItNZYJ1FVy0D+6/pU223iG+tybT4dJ/48LgY4GNdpBm+s+?=
 =?us-ascii?Q?F2xK3xzIAj1L3Zh2HJwUwZCkxRn1dFYzs8kd6PSmsu3EIJMrI0qOfUehPZq4?=
 =?us-ascii?Q?wl2qxZxwf8MFBQh8IJbXRGt/EsSl0Y60GG6saJEd8/1Xg97rQiFI7ulUVLEX?=
 =?us-ascii?Q?p5giAeHTZ7+pN5LjczQ5EFwdf0Licvj8Q1uwcD1THkt8DpZtTsC6ZxFZWv1i?=
 =?us-ascii?Q?NMWj96Ro36LErDXjKiUygB29PR8ODe41zR9/ckaJ37ctxJUTFeswK2gnj9hH?=
 =?us-ascii?Q?5JvowC/4A+65oc2dD2F41FOFqL7BukANOzLhDCLb5WMmYqhtHNyHzUnnJ3sF?=
 =?us-ascii?Q?oiU8gZLk4b2R0I7eHO++MNxHA9AGQmRSGG54VQLN2RWFGIXU9/4DuIkkQjnu?=
 =?us-ascii?Q?DhmKMsDi7wbEACT45LDUtgNra5us9svOOEYRZ+6oGJeleI+6oJ5C62Y82PRm?=
 =?us-ascii?Q?8A5ZlkIcR7TvBnGC/kWLXFRXiDFI3vVtduLclFht0WGAgoEK/Nt05ZqrvCuB?=
 =?us-ascii?Q?Bjvxwfq70gHxzOtdD6dQ0ZNFMnPvHPtijefgUai1UCB/O3Rn4JN0DtoSgzQC?=
 =?us-ascii?Q?XTv63++q1R8v8VIxvnEuGJ/nEjAKccDEbPAJTFPVVz++cJ3tVdaUiiniCl8?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-d8e84.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: baa2f303-2a24-41df-412d-08dca3329213
X-MS-Exchange-CrossTenant-AuthSource: TY0PR0101MB4285.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2024 11:54:38.9829 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR01MB5922
Received-SPF: pass client-ip=2a01:111:f400:feae::803;
 envelope-from=taisei1212@outlook.jp;
 helo=APC01-PSA-obe.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Before this commit, there are 3 problems about HPET timer interrupts. First,
HPET periodic timers cause a too early interrupt before HPET main counter
value reaches a value written its comparator value register. Second,
disabled HPET timers whose comparator value register is not
0xffffffffffffffff cause wrong interrupts. Third, enabled HPET timers whose
comparator value register is 0xffffffffffffffff don't cause any interrupts.
About the first one, for example, an HPET driver writes 0x00000000aaaaaaaa
to an HPET periodic timer comparator value register. As a result, the
register becomes 0xffffffffaaaaaaaa because writing to the higher 32 bits of
the register doesn't affect itself in periodic mode. (see
"case HPET_TN_CMP + 4" of "hpet_ram_write" function.) And "timer->period"
which means interrupt period in periodic mode becomes 0xaaaaaaaa. Next, the
HPET driver sets the HPET_CFG_ENABLE flag to start the main counter. The
comparator value register (0xffffffffaaaaaaaa) indicate the next interrupt
time. The period (0xaaaaaaaa) is added to the comparator value register at
"hpet_timer" function because "hpet_time_after64" function returns true when
the main counter is small. So, the first interrupt is planned when the main
counter is 0x0000000055555554, but the first interrupt should occur when the
main counter is 0x00000000aaaaaaaa. To solve this problem, I fix
"case HPET_TN_CMP + 4" of "hpet_ram_write" function to ensure that writings
to higher 32 bits of a comparator value register reflect itself even if in
periodic mode. About the other two problems, it was decided by comparator
value whether each timer is enabled, but it should be decided by
"timer_enabled" function which confirm "HPET_TN_ENABLE" flag. To solve these
problems, I fix the code to decide correctly whether each timer is enabled.
After this commit, the 3 problems are solved. First, HPET periodic timers
cause the first interrupt when the main counter value reaches a value
written its comparator value register. Second, disabled HPET timers never
cause any interrupt. Third, enabled HPET timers cause interrupts correctly
even if an HPET driver writes 0xffffffffffffffff to its comparator value
register.

Signed-off-by: TaiseiIto <taisei1212@outlook.jp>
---

Changes in v2:
- Reflect writings to higher 32 bits of a comparator value register rather
  than clearing these bits.
- Fix wrong indents.
- Link to v1: https://lore.kernel.org/qemu-devel/TY0PR0101MB4285838139BC56DEC3D1CCFDA4CE2@TY0PR0101MB4285.apcprd01.prod.exchangelabs.com/

 hw/timer/hpet.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 01efe4885d..4b6352e257 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -552,6 +552,10 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
                 timer->period =
                     (timer->period & 0xffffffff00000000ULL) | new_val;
             }
+            /*
+             * FIXME: on a 64-bit write, HPET_TN_SETVAL should apply to the
+             * high bits part as well.
+             */
             timer->config &= ~HPET_TN_SETVAL;
             if (hpet_enabled(s)) {
                 hpet_set_timer(timer);
@@ -562,20 +566,22 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
             if (!timer_is_periodic(timer)
                 || (timer->config & HPET_TN_SETVAL)) {
                 timer->cmp = (timer->cmp & 0xffffffffULL) | new_val << 32;
-            } else {
+            }
+            if (timer_is_periodic(timer)) {
                 /*
                  * FIXME: Clamp period to reasonable min value?
                  * Clamp period to reasonable max value
                  */
-                new_val &= (timer->config & HPET_TN_32BIT ? ~0u : ~0ull) >> 1;
+                new_val = MIN(new_val, ~0u >> 1);
+                timer->cmp = (timer->cmp & 0xffffffffULL) | new_val << 32;
                 timer->period =
                     (timer->period & 0xffffffffULL) | new_val << 32;
-                }
-                timer->config &= ~HPET_TN_SETVAL;
-                if (hpet_enabled(s)) {
-                    hpet_set_timer(timer);
-                }
-                break;
+            }
+            timer->config &= ~HPET_TN_SETVAL;
+            if (hpet_enabled(s)) {
+                hpet_set_timer(timer);
+            }
+            break;
         case HPET_TN_ROUTE:
             timer->fsb = (timer->fsb & 0xffffffff00000000ULL) | new_val;
             break;
@@ -599,7 +605,7 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
                 s->hpet_offset =
                     ticks_to_ns(s->hpet_counter) - qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
                 for (i = 0; i < s->num_timers; i++) {
-                    if ((&s->timer[i])->cmp != ~0ULL) {
+                    if (hpet_enabled(s)) {
                         hpet_set_timer(&s->timer[i]);
                     }
                 }
-- 
2.34.1


