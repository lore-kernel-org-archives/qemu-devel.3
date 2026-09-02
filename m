Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81094C61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 10:24:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1i89-0002ri-Je; Wed, 02 Sep 2026 06:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x1i88-0002r3-Qf; Wed, 02 Sep 2026 06:23:44 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x1i87-0006xJ-C3; Wed, 02 Sep 2026 06:23:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N1MUBpDA3gfwhgHej982rsGLUBrd5FO5ixXA2WQg3Pj9+HIlfQDkVxr4JQCEj32bzgt+6j3SFlaC/CCXYx8LHZfaz09dWgdqoS/z0K1HUNFhwplMxivnhE6l+/9mjIaPnb/HbzKHiB3IDfuF1ffbFiMikbk27SzPdmh5aF3eTtR0j/fZKUBh4pYVvch3/kGlqb4UkDz9EAjsXiwLsI6eip7xuGLCjq14b01t+gAY/V2WShcMAB/x1Go4DuoYzlnbKQrJKoHBmIfHhlXAc2sIUIURu0C4X7b74LN7yuV3eWjp7FU+hgRNHlq4Q+G54BJvQ/5f0cYy12E4BzxnnM97xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1i+MGsQeEyu30Mzg8uIpkY6g84qJdhPXy9+8GoD3uxw=;
 b=rMw5zLKFYPz/SzrZYNhki3jb6joV9LfFvjJKqTh0ZrGAo5PScIpjf47Wu8M6KvJLM7QFs+zoxGzEIwBssC+upRyj3tBqdJCSViAkLd/v/bU8PRFWEAWUU1isSmYMZjYJRP/FrGiEOqpEIlkKLSp7AbKGVR3VWhvlle9XwnAhuXYG8McZzsuldKwIGjdypPNRjCjnXmXjqnKOfY5txRs5+KsKqktbi2a5E72Y3LgvuIIfWKvQzzQSzzFRWaZfJN/UtNoOAs0vZ1hIynLlJVcEqpeZrI38WU9cOTWMHjRneVG1Nj42P8gStgod+VaMlIzJthHgATRyGLZf7hKlRtDB6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1i+MGsQeEyu30Mzg8uIpkY6g84qJdhPXy9+8GoD3uxw=;
 b=PvbcJc6gx6708xN7bzWuoxrmYTVZHdqTzUrqCY3Gc2/BO3zKMcAWXuk2gIZDb7VaRcc6hJK+mrN5DOrMLs6s0XnLJ9Urn/q/zJPvPmQNnswzGcr+6toNNEf1h1qLdbmNkLnHkg9nxLA67cc2URzgKqyVpRoiKvJHiR4Yfeh1Qx2m9jQvzrZr8s4C0g55gJk20xRfWuHFbzRYcVG7xzSQXCSiAqhppU3Sim3sqdfuBbrgSNWc2mkQvcia3SvkXFoeJYZ8ZZywxKXqNLgG1olVux6+DtUuJCYkmsS/UTPRjBiKsqMm81PayAXIZuXz3ETJlZYlK2lueB0+ZH2bnOV7FA==
Received: from SJ0PR03CA0226.namprd03.prod.outlook.com (2603:10b6:a03:39f::21)
 by DM3PPFFC05202B5.namprd18.prod.outlook.com (2603:10b6:f:fc00::6d2)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 10:23:37 +0000
Received: from MWH0EPF000C6193.namprd02.prod.outlook.com
 (2603:10b6:a03:39f:cafe::94) by SJ0PR03CA0226.outlook.office365.com
 (2603:10b6:a03:39f::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 10:23:36 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 MWH0EPF000C6193.mail.protection.outlook.com (10.167.249.107) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Wed, 2 Sep 2026 10:23:36 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id DCA284186B53;
 Wed,  2 Sep 2026 03:23:35 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: philmd@oss.qualcomm.com, 163wangjack@gmail.com, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, qemu-arm@nongnu.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v5 09/13] hw/arm/ax3000-boards: Remove redundant pointor from
 struct
Date: Wed,  2 Sep 2026 03:23:34 -0700
Message-Id: <20260902102334.3039348-1-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6193:EE_|DM3PPFFC05202B5:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7f75ff6d-d749-46ab-c719-08df08dc3fa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|376014|1800799024|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: +tlRVU6Wao8kpc22/yohl4eeLXL118HZMXzl9KSinW0lQiaRD33HoOZ4hZv2z1fg4Ffb14FvjLAvttlO07vNmWgkp71mVGgLfkCPGvD6LTvwVzfbzTIn1hdUd4zEVDIcbMkhVipLWdPBPEwywkvm3bq1ipdZ8EryokLDNurfdW0qQkgIyF7fZKTLvHhhbMOm3xT3AQIOKDwO+pFdVk0+1BbxNPMEFZhxwant4LglhcHd+0BttGpt4ZOr0r63Ka//t2fQga3jI1f2X7FHpK5uMc4gqpUTUJIItqB6Q2O8j6Ece6+QRtN4KuqharW7mGGQlSzuc08MrteFueFA780+Tachj9kLX2zA8muEoJeHdqWpUC2pI7Qn0sLAU7dJkZC6t6C84eQ1+/xOowmhfBCcjfj7Ej3I87uPL/8CVHG+yrxtE7bOTulHG+k3qt+KHtvW+al41OKchTsyFsCD/Lkz8UYh+coKKMF+m/o44gzGzqq28ci58fFvf5LKFcHsMEMAxyBTKv8yoOL0M+hYJ43OfOZkhsO94bZ2R/+k+e8XyPJB3Pi+ZFgnheVPOtyEx6JLGFi+d+uVr5b7r8r/zfNEXmr1xQ0NMSxrWmGB3PDDcUGUExX1XqoYOv3AeOQok1L5Fuj2NJBlc547LlTXe+uo4Nqip46VZtjlkpLwQIfAAhig8t8O+sYwjP7C9BuwB4NeSRfaYEYiXECwDzI9JzwsOw==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(1800799024)(18002099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nHSsuQRi8tQwy6+GG3f+vcKgsyfTtuVmt6Hf6qd7J4AhWdClSmQxeZvYvMqSuvSMjgEnTtSuBRBRoqt0EtMRntKC9gx5ZE93wESzU4auhm1GEeN58Xe9CFwYqev3kbOjd+Ose/zY9epP621KEEM4k+e7nAnfIy3QWi+EzFJ19brGxQdV7PbILkNhH4N2FdPCiH4gBCrIsksVTdp1SOg0M7ceA1xBX0KJvk3fumd+mPWy9qP9556YZO1ri89huP1berV5pKWpWtqyCM6II2cSJcJOn06nJod4NToCDGVzu1auuEkkOrHqJy5Z4dIve39neZtnVj3VqLXkTTjcTBZuH4pREpaD+4zAfxigmhKgskU3ASo6pXL2QtXTWmKMn1dv2GNGgLbbAEUubP58O5JcFv5kV4B3h5tznxu7716kLfdmvz9e8fdHa60Ys6zpee8a
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 10:23:36.2481 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f75ff6d-d749-46ab-c719-08df08dc3fa2
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6193.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFFC05202B5
Received-SPF: pass client-ip=2a01:111:f403:c100::f;
 envelope-from=kchiu@axiado.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Since ax3000-boards is bound with Ax3000 SoC, we don't need to have a
pointer in struct for SoC type

This patch remove pointer soc from Ax3000MachineState and create instance
in init() directly

Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
---
 hw/arm/ax3000-boards.c         | 10 +++++-----
 include/hw/arm/axiado-boards.h |  1 -
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/arm/ax3000-boards.c b/hw/arm/ax3000-boards.c
index 33e936a0dd..510c463d43 100644
--- a/hw/arm/ax3000-boards.c
+++ b/hw/arm/ax3000-boards.c
@@ -69,7 +69,7 @@ static struct arm_boot_info ax3000_binfo = {
 
 static void ax3000_machine_init(MachineState *machine)
 {
-    Ax3000MachineState *ams = AX3000_MACHINE(machine);
+    Ax3000SoCState *s;
 
     if (machine->ram_size != AX3000_DRAM_SIZE) {
         g_autofree char *size_str = size_to_str(AX3000_DRAM_SIZE);
@@ -78,12 +78,12 @@ static void ax3000_machine_init(MachineState *machine)
         exit(1);
     }
 
-    ams->soc = AX3000_SOC(object_new(TYPE_AX3000_SOC));
-    object_property_add_child(OBJECT(machine), "soc", OBJECT(ams->soc));
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(ams->soc), &error_fatal);
+    s = AX3000_SOC(object_new_with_props(TYPE_AX3000_SOC, OBJECT(machine),
+                                         "soc", &error_fatal, NULL));
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(s), &error_fatal);
 
     ax3000_binfo.ram_size = machine->ram_size;
-    arm_load_kernel(&ams->soc->cpu[0], machine, &ax3000_binfo);
+    arm_load_kernel(&s->cpu[0], machine, &ax3000_binfo);
 }
 
 static void ax3000_machine_class_init(ObjectClass *oc, const void *data)
diff --git a/include/hw/arm/axiado-boards.h b/include/hw/arm/axiado-boards.h
index 4a632661e1..566f22cd96 100644
--- a/include/hw/arm/axiado-boards.h
+++ b/include/hw/arm/axiado-boards.h
@@ -18,7 +18,6 @@ OBJECT_DECLARE_TYPE(Ax3000MachineState, Ax3000MachineClass, AX3000_MACHINE)
 typedef struct Ax3000MachineState {
     MachineState parent;
 
-    Ax3000SoCState *soc;
 } Ax3000MachineState;
 
 typedef struct Ax3000MachineClass {
-- 
2.34.1


