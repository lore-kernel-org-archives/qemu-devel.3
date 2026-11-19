Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D1B606A325
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=axiado.com header.i=@axiado.com header.a=rsa-sha256 header.s=selector1 header.b=vB0ZuJG3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTwN1-0004AN-53; Thu, 19 Nov 2026 02:15:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1xTwLV-000301-Sy; Thu, 19 Nov 2026 02:14:15 -0500
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1xTwLO-0004K4-SI; Thu, 19 Nov 2026 02:14:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p+vIu8SDc9KM39z7mIHQH12LrgrqEr97UyhQkXrjdvGSlEPUe64xM78pWdfhkFkE1pbrgP97x9jPMrIbubpsdES6uondiDO1JFHrBrdlwwisKBrTXyMW3NwIlaFdS7jMFADZL0pzHSGDZDaoz+qiHs2Zq3qymKD/f3sb+bfJ3Cz9/PGXGnU8GxzmolWACnXEk1WCmnKJfKCX+IQNt2h7USHc/PxmDDCJuvW0CdgrrW1IHOxx+NXI93XdYpT0SiyT8xAdd9KoG1Mz2trUKOatRaxqS7w2ZYvOZ6Cu7wjgQ+kjUzvouMo6RBOs1QgcfB95TNaQGqvNGiqkdSHPCxQxtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1XHDLr2lCk/6Qr2x9Y8T5yZojzHQNkfXzh9bZlTCyA=;
 b=LBqhN+52EKczPL/58PJbZqVI72sNZ9cte5O0gNkY3pvcKvVJi+s2XBzFC8gE1rHSTLTTsjT4uIVYyNY58BRQonNrequI/skK16wyXmgEJv4N8+9BVqS0yPeTskv2mGf0txsBf3ID8IVPADlQhBpZ9ETYlfnaUuGG1byEnpdU6j1LM1z0By0iLfKunh4hVBiu2Fisgah3AGxiPHC5b0VExwsB5mq7Ww4Mla9etN1f/f1/1zspueyEAYLOz1CJG5yPnrv1YzH4OGG1QqUYnzcu+X9S5nkiXFJyndGZWLyKygXThpLcElDfuuCXflAlEhLhL0Dh5bfk9dZjw6R6xxBYAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1XHDLr2lCk/6Qr2x9Y8T5yZojzHQNkfXzh9bZlTCyA=;
 b=vB0ZuJG3BRQLWVmbvru2G+AbaGXDPC9YfrZmxFgQODhorCJ6+/jemRWCg8Y+PQ1qRFgbMV1khju9znaLgeIvOUISneBYr2dZyUr6rwKChO6O1oFUqshnrpxL/gXZrylOJwglVfG/ENOsnvnxD8ydHhrYbIZJlP/JxXgHrRf8AFMmLWUQkoA2keofK+oNQdfxs65JVpB+F1HREyJGTEMNv7aWQWSbWNe2U5AZLh010xxNBMIEamqXmt2jXT9R+RSRgFKK+8QzVV/e8Euo2hO/F9fQHimZSOlSLDU4IaWXwOuC0dcG8mG6kco2eneWJPnKyEo4gkCOKmcdQMw+dYTZ0w==
Received: from CY5PR13CA0102.namprd13.prod.outlook.com (2603:10b6:930:9::24)
 by DM6PR18MB3556.namprd18.prod.outlook.com (2603:10b6:5:2ad::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 07:14:01 +0000
Received: from CY8PEPF0000005B.namprd21.prod.outlook.com
 (2603:10b6:930:9:cafe::29) by CY5PR13CA0102.outlook.office365.com
 (2603:10b6:930:9::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.2 via Frontend Transport; Thu, 19
 Nov 2026 07:14:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 CY8PEPF0000005B.mail.protection.outlook.com (10.167.247.25) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.0
 via Frontend Transport; Thu, 19 Nov 2026 07:14:01 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 9FF3440BFE12;
 Wed, 18 Nov 2026 23:13:59 -0800 (PST)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: 
Cc: Kuan-Jui Chiu <kchiu@axiado.com>, mark.caveayland@nutanix.com,
 philmd@oss.qualcomm.com, 163wangjack@gmail.com, peter.maydell@linaro.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v8 08/13] hw/arm/ax3000-boards: Remove redundant pointer from
 struct
Date: Wed, 18 Nov 2026 23:13:48 -0800
Message-Id: <20261119071355.3520249-9-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261119071355.3520249-1-kchiu@axiado.com>
References: <20261119071355.3520249-1-kchiu@axiado.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PEPF0000005B:EE_|DM6PR18MB3556:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c322e75f-8a66-4673-8946-08df460caff7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|22082099003|18002099003|261009223027099003|261021121427099003|261021123027099003|261026121527099003|261102123227099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: C7GIY+U4lbagu8Pgat+Mc7OlZk2yFazbh7gvdOu2Y3XTBhLs99tii5cRL1QVWksWdLoiM8EkZzyZC+0HxoXaNq9+zZsHPKrsmquK4DZOKu0BSmDfehX4C5FbVYCV8f/2OuuUvnv4pgUfGYlugReNV0utKKo5EbnDvMQslUU+zhwTgGPQQX7gFu8jLl1EYhuERDQiFoUohxhUnt37k8Zk4PWVVgLYpUufLx5KcxXTs6nc2oAho9xVa0Ux+OuR/HecaK93cRpEMrFDFdM+bmPDEjoMFSPGqbWBbmfgeor+ssGC8TxJd2lIHmvO0hxxVyOOCcI70DfgHYo3FzpGbUW3l3lOgwil/ab7pM2x+bl13xTB7zpx+FKpCQra5EDoNm8w6ONYoxHtA/7G1X4/a9EIJSiNBgMuFwjbPCKeHOz2dgvZ8yRT6287mlQMQouj7cBjixm90lLwQHmjdyEZGk2jdAqGQ3VRSSoHuBhVcrkYVFI/tqh2dDKKsq5RxlS83PjcIkoHQ0gMjolL13MXIAgRUuoDBAvmJGZVtMJrnAO570E1/AmfT4uAPU5NByiBA19Y/he0CCQLhUiKA8NwU6sJn0u3gSXDNtX2sXFqnk2ikQ9XnfKf1stEdPmvqhbwF5FNVnOXtprdVwVkQfy7k240jyQN4VLd323YNye1OhldpD1XLh57h1daXXawziVchJOZ/ll71IbRl8nRDht0/sBGGg==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(22082099003)(18002099003)(261009223027099003)(261021121427099003)(261021123027099003)(261026121527099003)(261102123227099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aMTKTdNpW31TUkA93WQAItu6tJX/AChvbmMLtrK+sx2KXm1C+x2P72bkdWbdP/prabrT65YWNJL+oQZnpS4uIcDzN27IrCOCUF0E/SqdmqbEXjH1EQi33SLID5ktXGmi5mMngIXCbMEKZ2JsW1szs+q2UTDaT/cm8qGJz39NuWsyuHJVrCeIhvIyMN+K0xzNPbuw/EaHXEWkXay7RKFtxV9lf39lwhuuyZoTlpH/3JiA0iHf4u15Owbxsf57wIAYoGx2UEMvWxqWnWrHCbC/R/v64HexsNAIuo/XGwZyIg1fATmxgshfUXGJzeSuOcxyFPzIHffUHfAENwDfKmVl2+usUtep41+Anu+UBa/yMP7W/wqXuFvWXcP1l0gvX6cwQKwNGjWpLpDhSehr1Sj7yZCFHAwSRLfTyGvEglBy+0oklSPdnvOIl2grD+8BniXh
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 07:14:01.3823 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c322e75f-8a66-4673-8946-08df460caff7
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: CY8PEPF0000005B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB3556
Received-SPF: pass client-ip=2a01:111:f403:c110::3;
 envelope-from=kchiu@axiado.com;
 helo=BN8PR05CU002.outbound.protection.outlook.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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


