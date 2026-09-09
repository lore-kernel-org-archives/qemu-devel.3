Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A8FC79FAD
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 10:56:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4FyF-00043s-ML; Wed, 09 Sep 2026 06:56:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x4FyD-00040m-8o; Wed, 09 Sep 2026 06:56:01 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x4Fy9-0004FU-OB; Wed, 09 Sep 2026 06:56:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cKy7Mwdnf3mnbL/kkJ3/pHvZWCpSP7sPkKnjjueWDMYkp4HVNrexVj06NfD0ejdAylBszCBYYg5DkXD3gmJSi/B/ZxY6H8RR2T/QKL5sFsH3P2Rwx6ULGuScdotiM6JSVC+2lz1t/IKZzpGefJ2OdiNRPVFZ2MTmMeuThQ3eKHHlnpk3Xcge5dXBXW/6EqXopQ/DP9pJIZ6rRhURGf+eDhrPY5ZIAjR5ofZqEeQhxFdbrlE0qRohXkQQomqHZHBZpWkBENuxbl54oq+fdQ/YTFoXIVHwSFZ1he6J6YXNxJeSCmAhVliFQPOYc0vd15++a/BzX+uLTA7jRJnp/UWeTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1XHDLr2lCk/6Qr2x9Y8T5yZojzHQNkfXzh9bZlTCyA=;
 b=aQuScByukTiQRtUjM4cYFyEvoiMek3CL9TeH8NMrjZlTJvw/euHGETyAh9htjTTQmEEDrzcThGriDNaXcpfBNlEg55bHoTM2ozXDypwp7cxu3ZnaR/WhLXnkSIQeVipZHgijFmDRiFNmljWG2oOgKqo/kji7fEdity7gMRpXQAlbUHui58kkzqip1w9luAq89o1eg8VmuOB/4XERycYpyohI/GmCa5IISWpz+OlLNGQPmozXIG1rIBv4TJldLJn5j1d427XTibvE87qjNwg/GcJmdRd/r8NJIovvM9GrFQXqE9OaXJzlB8MHrSsHB+sSSHZVgTZEopEuuYXbFyF2Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1XHDLr2lCk/6Qr2x9Y8T5yZojzHQNkfXzh9bZlTCyA=;
 b=D3FI3AVW1AOtZ1zeXH8AZw5MueKS7zHmsPUzf02VMAY8ZcWoxi36qv07976B3ZIeVfkr27Z470Uf5ww9mvT86Etf5JSaYZ5ijDnyWhEuomq+uWkPGL3+RoucagjvqCly9ZMwEF6KpiTFo6zQzxABHkP1HhDf4d6/mHAiM3pWM6rlw+q869kktfX8tG+43KKlbj4Haz/x/sxR2RCnPS93Um1+lgTOCHwvpUIGzfpa+dQC/XpZ9NGbCivmU2R8+HWsH6j3dr96H5TXlBlXru5gnXCUXdlesh4DgEwZ+8NsUu50/ldz8j2ECPvEX9tSj2ei7H1aXgg2sUD/4jxnz3C0BA==
Received: from BN9PR03CA0755.namprd03.prod.outlook.com (2603:10b6:408:13a::10)
 by PH0PR18MB5168.namprd18.prod.outlook.com (2603:10b6:510:165::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 10:55:50 +0000
Received: from BN6PEPF00000072.namprd03.prod.outlook.com
 (2603:10b6:408:13a:cafe::22) by BN9PR03CA0755.outlook.office365.com
 (2603:10b6:408:13a::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Wed, 9
 Sep 2026 10:55:50 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BN6PEPF00000072.mail.protection.outlook.com (10.167.248.199) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Wed, 9 Sep 2026 10:55:49 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id C792740BFE12;
 Wed,  9 Sep 2026 03:55:48 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: philmd@oss.qualcomm.com, 163wangjack@gmail.com, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, qemu-arm@nongnu.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v6 08/12] hw/arm/ax3000-boards: Remove redundant pointor from
 struct
Date: Wed,  9 Sep 2026 03:55:35 -0700
Message-Id: <20260909105543.1478008-9-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260909105543.1478008-1-kchiu@axiado.com>
References: <20260909105543.1478008-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PEPF00000072:EE_|PH0PR18MB5168:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e75db981-936d-4cf4-cd48-08df0e60e928
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|36860700016|376014|82310400026|10067099003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: 3/qBpJ9hMcQ7UZbO1KqCi0GvATMbw579pPyuAizHMv9zx3TmsmUViXGrh9Jy/J+6QSm0KjbXEHKDlspqPI/eGoo0m0mWx9WS3RRPzuWPrPoXIWnIxwUOomqdpd4p+g/t7sHujLTtuwsrlgLfFTUzhGJoCul1WvUF1sio/SXUjmYXR9Rynbrac/t05BC+zRrzDwLkiBpeSIH4P8gPk+dk7GozPPZnSQgaiF5mEdUC2hiOPrVL4OxJxI92EPqcB4nkrADvj9PVS6Ob2Eax0Fzs1su4mQ+4VnwKpOYB83NlohzHDEB+v8CqdL3FbrRPxMMO9Q8ss35qWZ9O9ttXeBKPKYps9cYyvLnW8FzdAF5KUbXXruiTC25ythBS0vv2e5h0HkuI5ewaEJoxROOQEVVAAuNYYt3hY0l1GM6/s3JyU6lNJlZRtSSOvD4Lh7j3CGB5NG7rVQ8xT+x8Zue3qOOfkyDMH8aqrHKEy2IlZE36+PuXrvbgWU4mNR+zNOzPl6rFTCxYlZT2/Pz19fxdyz1uvV9CpFxKTOATZG8QNB+f0FZSj9QoSbV0IB/v3+uePi8zjCaeknFe2e9HSlt4C5fpPS+PNeiWakyHYocgmEESftgwvZ3Scw+r5NdskZeEyDuPpvth8iBRNaYJAUJYKKa93iicVgL5M+wqP7RdU6XTg8fRwAHoaiytU3PBYwvIgT1oy35cPx5FbXF+9RvWR057qA==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(36860700016)(376014)(82310400026)(10067099003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PhWO2PCWciuY7Qc2mfT4WMIzkj8jKKVfQLB3w7WD4Frtr7X5eqtHEMHY+vyq3nNWNVoPEsChZuY9g5D/pVzH9ID5cdbaWE4SH+RfBkHhxaOOfdKdfc1+bqxwBw6pTG30bThpFkl/cLI5u11yo9jWlbIXQziDpdtUodGKq3ceJBotlF5lOpBAVnDk6RjGeV53eGsQpZtbK8YH7D/oMbDY7/VODuGseiuHguxGNXogyA6K3X7wpiEPoranKwmJRdxV3pLw+6P8F9OQVl7HEMS12WUStytTGlzR5Jqz9cFZWja4oPHai/QU7amKPTiAaAMXpekzJNBWQoaA5RuqbJIISIy0RCqFRJ710QzXYAMAfwYikfw9uZXMcc/0IpouSBuCIYrtD7BICXzPIpDoGjMA22lPIVHpMXBcvMO/4A+YW3yWFl1jr2L0mDiTeQjstR/g
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 10:55:49.9643 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e75db981-936d-4cf4-cd48-08df0e60e928
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: BN6PEPF00000072.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB5168
Received-SPF: pass client-ip=2a01:111:f403:c005::5;
 envelope-from=kchiu@axiado.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
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
index 75e0aedb4d..3ca4a6f93a 100644
--- a/hw/arm/ax3000-boards.c
+++ b/hw/arm/ax3000-boards.c
@@ -68,7 +68,7 @@ static struct arm_boot_info ax3000_binfo = {
 
 static void ax3000_machine_init(MachineState *machine)
 {
-    Ax3000MachineState *ams = AX3000_MACHINE(machine);
+    Ax3000SoCState *s;
 
     if (machine->ram_size != AX3000_DRAM_SIZE) {
         g_autofree char *size_str = size_to_str(AX3000_DRAM_SIZE);
@@ -77,12 +77,12 @@ static void ax3000_machine_init(MachineState *machine)
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


