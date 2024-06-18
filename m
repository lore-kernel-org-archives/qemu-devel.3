Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C252C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 13:16:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJYhF-0005eI-4R; Tue, 18 Jun 2024 09:16:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <taisei1212@outlook.jp>)
 id 1sJYhD-0005dB-Vz
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 09:16:24 -0400
Received: from mail-psaapc01olkn2103.outbound.protection.outlook.com
 ([40.92.52.103] helo=APC01-PSA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <taisei1212@outlook.jp>)
 id 1sJYhC-0002No-7D
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 09:16:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dks8hayCGs6axYtOD8igKUdXZFe/smq/IZH1afCUCOq/0tKEe3zxooILrwZEt8qw5XAy7s81oZUZ53EUTvfZoENraXlhixpzqboHeiqQARhB0xnnooM5ILwTSfwhCwFUMXI4/mqxRlVa0anFp5vJvzBr8OxZGVRbvY9T44sQmDHr1OXw+XBapVRxmeJyNRtMk43vy9bgv7rRq1wwLI16FIsvqDnUUYhKpwtyKtE/Z7M9AWOSnJyzseIne4vLKhhnl2ZlMKr+/dfekK78uBDpFHQTAyif7nYAvjhut+QyzLk/K5325Dybc5Nmnr2v8YPH7E0E0QJ+wGL13Y5Y8DTGkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MiMIc9GbNf9vMhnhJKC5DUEjmRloEVBAMP6Sa05gnIw=;
 b=bogXDvOBCSpQSsBLlTUUn0gQNyyySYVpPPLEfgWKcGUQ9k+sV2F8VOSwA5+s3CDi11RLHSm29GRPjMccVLws3EQtLAHWTgxtYn3Pk0gKiGvFc/lmWwiU2J85S5WsLd5HT+TvoYjZih4DXNMypSJ6tTUATwsCk0WU3VjJRMmTl20G1nACXTKgFGtlBbcKZ8KV4T8QB6OxPY3/GqeT56maGcMh8PmSGSx/VDktD8OZ3lSywOTp0CGr6HkJuLJV5z9n70P3VH7Tq8MbNcaulmrWnRZ5/wVGInTnC1AKwFe4HT3HQ8MNnHoNFcbJdXnFLZp/HwBC48Kj0091eiJAnAbaCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.JP;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MiMIc9GbNf9vMhnhJKC5DUEjmRloEVBAMP6Sa05gnIw=;
 b=VUJzi8N6wnSvagWwP5x9RoPD4hp2UCyAz3qkbscSRQd5NTC7lFtDi9N3YdISC3F2PfH4KA82JHaY7hyyV7UhBt7YaONlJxT8V6fo+VLn614BKJgFMazS2HZDgXosAsYcl4Ni5aOAAU0MgwtAXMMSTEY7UCgFWLb4/ygdEeZrMvUN9fp6nphFkuB3Z/rdk2hIfDpKWHRIkOMsKWFpjyOcXETVqtG8BwMKn+5fcXUiSzkxRAv8etMYX5sJG3iCtbfv0YNwfWGs0qBn0z/8xZFA89zKBzBeIFUbPxquE4/N+do30mIZYCqpMJBIwtJ689zPeMqqHMzVYiVdowovmRmeZg==
Received: from TY0PR0101MB4285.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1b0::11) by SEZPR01MB4256.apcprd01.prod.exchangelabs.com
 (2603:1096:101:3b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 13:11:10 +0000
Received: from TY0PR0101MB4285.apcprd01.prod.exchangelabs.com
 ([fe80::85c5:f6c5:8a81:ee35]) by
 TY0PR0101MB4285.apcprd01.prod.exchangelabs.com
 ([fe80::85c5:f6c5:8a81:ee35%4]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 13:11:10 +0000
From: TaiseiIto <taisei1212@outlook.jp>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com,
	pbonzini@redhat.com,
	TaiseiIto <taisei1212@outlook.jp>
Subject: [PATCH] hw/timer/hpet: Fix wrong HPET interrupts
Date: Tue, 18 Jun 2024 13:10:44 +0000
Message-ID: <TY0PR0101MB4285838139BC56DEC3D1CCFDA4CE2@TY0PR0101MB4285.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [1mKi+Kbi95KLCmGrLonFHeBz92BrUeb/]
X-ClientProxiedBy: TYXPR01CA0065.jpnprd01.prod.outlook.com
 (2603:1096:403:a::35) To TY0PR0101MB4285.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1b0::11)
X-Microsoft-Original-Message-ID: <20240618131044.6987-1-taisei1212@outlook.jp>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR0101MB4285:EE_|SEZPR01MB4256:EE_
X-MS-Office365-Filtering-Correlation-Id: def1752f-1265-479d-2488-08dc8f981edc
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|461199025|440099025|3412199022|1710799023; 
X-Microsoft-Antispam-Message-Info: BXD5r1X/X8mEHwxAdwXB3JA61tE645nv8mgsMisSTkmcK3Rzqed4KsKarWpsJu/CgM0cKQVm6JtX5XWN1iEKejMfQJgQqWyO6XyDtaJd8+M182Xv8WekR9vdm83BVSaqaypnMj5m8iy5yy4fk855eFQ6r55jJFSFZjIbjvnFLmLBy3iPD4WCykcorqctAwKKvwrZNtTeB/jY0ASMsjcwcrAUgLs2YSVkFydv+FvOtsEmigTyGTLNCSTJa/KmReGEzSj4yuPyrJ6rPmBoLGyNzDrDSqRy8wEyQ9vHsgEcMFn/vrKHJ5rc+dXaa34GkQ4B9YBI9gPJM2uS2zywaRIjMzZaxyH0mtuOWICQd0338+BFroC+lT+4m1Gol/0CejnbVRIns9F713tSFpO4tZKvgE690jHeJEgbXJhvaYdTjy8IHeX64gs8ndQLI5dBvXC7qny6/55VuL+5RU/lOZZzt0ESYmWg2rBWHBIwybULU+vXwe+W9Z6xXDfmFyCoRL0uFSAvoh098Y050vlOoLeYFyz0aEfpurEULdhEcS65x6DiJYi9MRveXhadtl7DB2knBauRjcZGGSQekn9Gd7dQkEM14VleHt9zmd29iSpToKlIzd0AAB6h/RycRgpd+/NN
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tLs2lq0CO7wK9p2GuTmAgsmFhDwAD8mI2Ww4oNq3X0FWSmM9xG9xMBBws4LM?=
 =?us-ascii?Q?ipK1Da+KQoizQSCiAI1TrQp3kslTYdnjJpe8wOXiiyWv/vCOzHP+0qHfkwlm?=
 =?us-ascii?Q?/+6SSp0DrP8jJDZQxsxMPEWMNCgJ4wWWj9+fGSQx6kIzFf36u2RQHN3ODKv1?=
 =?us-ascii?Q?7KEPFiyUMnjTzB9CW1Hz+V/8BRNzI8jFHoh0epvIKxlz09d2A9msMZ+2bI2/?=
 =?us-ascii?Q?zNb17GQWn2/X02CJCvRstnzzpaF03/5uEmJu4EAcWE8H0QhEQSddiH4nl5c7?=
 =?us-ascii?Q?vkJcaav84Irh1tZ10sxC3WsHa08tyneBnKogqtkJOBWPl3HMQsK9v18jGDnl?=
 =?us-ascii?Q?imrnCHHDwz+ljrkAZhA+iTxVj6VBIUs3ewGlJJ5YtwdATqnD1xI2i3OTuEF8?=
 =?us-ascii?Q?5Zn2+v3zRwlE/jZFe/i2VdSD6EzJPDLu+UrMrFpIBndqVzzWkdCP+NEvd1VU?=
 =?us-ascii?Q?QNgXjs8szLqfNl2zsfvtltWqRBFE3lbz9S2feBwRGzonfJJzSB1SLlQwI0zU?=
 =?us-ascii?Q?wDhF4q/h4D5KIiriJrpKFi5oqVYt8e0FhVKaZNZbvhnS3nOCWapRSeXtU7C7?=
 =?us-ascii?Q?dPQOWk/Hds62I+Oik6PsnfotTfh5Br6JJ2zFix1Net6HM1oZ0jmFvVZ5RR/n?=
 =?us-ascii?Q?RBEsTbRAdALQkS0XyNnLniMnoZD/tbHhVd/mSQhon9kLaAVGl4dxWqNgMuRc?=
 =?us-ascii?Q?PcuJvFKHZ05ZgSeK+SdLQVivZ9kXHJOT4UAd6UObme6kNAxUEIZtrmX+xMC9?=
 =?us-ascii?Q?c/FcTxiQGkrCOPIwnEUfQjZU0IvMzhUWhEcKcFEx9riz+gRx+Kkp6j6StaRC?=
 =?us-ascii?Q?rEA8hiScC/md9n1nMF25snGigu70eI2FuduoyOs0avNEkCJjH0zeE/27gLLd?=
 =?us-ascii?Q?jFxk16m7JnNP63tGY47+CrDnulSDJbp+oM61sX2H+gvpY3+DjbZN/F1a8GKF?=
 =?us-ascii?Q?H9M1hupce2FD6qVHfYYXT70jHVYFFN3zLScf6typjKl5UInbkXtuTlyjd+cK?=
 =?us-ascii?Q?QIYB3qoGSpJzSfcC7ENAZHBEmuNa4RtVrV4u7pEvDc2vZTgYHC65/7SF36wF?=
 =?us-ascii?Q?GpEU/T7nI+WxkyzwWrrja7+r91pNlPO2KNfRSVTB5LpVEtEhkdIeDRWdUl+9?=
 =?us-ascii?Q?xAZ/1tm4QdjTcr4qLxZJzhe+SEWmraqLRPanqExjNz7b9ie601kTnVt3zOv8?=
 =?us-ascii?Q?WMncZ5NRBRx3Uo87Uz2LBJeJGIj+swL+m9+Ic7MOckz5Cb2bnG+RvGEbAXs?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-d8e84.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: def1752f-1265-479d-2488-08dc8f981edc
X-MS-Exchange-CrossTenant-AuthSource: TY0PR0101MB4285.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 13:11:09.8783 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB4256
Received-SPF: pass client-ip=40.92.52.103; envelope-from=taisei1212@outlook.jp;
 helo=APC01-PSA-obe.outbound.protection.outlook.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
register becomes 0xffffffffaaaaaaaa because writing to the higher 32 bits
of the register doesn't affect itself in periodic mode. (see
"case HPET_TN_CMP + 4" of "hpet_ram_write" function.) And "timer->period"
which means interrupt period in periodic mode becomes 0xaaaaaaaa. Next, the
HPET driver sets the HPET_CFG_ENABLE flag to start the main counter. The
comparator value register (0xffffffffaaaaaaaa) indicate the next interrupt
time. The period (0xaaaaaaaa) is added to the comparator value register at
"hpet_timer" function because "hpet_time_after64" function returns true when
the main counter is small. So, the first interrupt is planned when the main
counter is 0x0000000055555554, but the first interrupt should occur when the
main counter is 0x00000000aaaaaaaa. To solve this problem, I fix the code to
clear the higher 32 bits of comparator value registers of periodic mode
timers when HPET starts the main counter. About the other two problems, it
was decided by comparator value whether each timer is enabled, but it should
be decided by "timer_enabled" function which confirm "HPET_TN_ENABLE" flag.
To solve these problems, I fix the code to decide correctly whether each
timer is enabled. After this commit, the 3 problems are solved. First, HPET
periodic timers cause the first interrupt when the main counter value
reaches a value written its comparator value register. Second, disabled HPET
timers never cause any interrupt. Third, enabled HPET timers cause
interrupts correctly even if an HPET driver writes 0xffffffff to its
comparator value register.

Signed-off-by: TaiseiIto <taisei1212@outlook.jp>
---
 hw/timer/hpet.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 01efe4885d..2dcefa7049 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -599,8 +599,12 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
                 s->hpet_offset =
                     ticks_to_ns(s->hpet_counter) - qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
                 for (i = 0; i < s->num_timers; i++) {
-                    if ((&s->timer[i])->cmp != ~0ULL) {
-                        hpet_set_timer(&s->timer[i]);
+                    HPETTimer *timer = &s->timer[i];
+                    if (timer_enabled(timer)) {
+                        if (timer_is_periodic(timer)) {
+                            timer->cmp &= 0xffffffffULL;
+                        }
+                        hpet_set_timer(timer);
                     }
                 }
             } else if (deactivating_bit(old_val, new_val, HPET_CFG_ENABLE)) {
-- 
2.34.1


