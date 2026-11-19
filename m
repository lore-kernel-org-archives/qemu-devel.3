Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F416606A32A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=axiado.com header.i=@axiado.com header.a=rsa-sha256 header.s=selector1 header.b=PplJwfr1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTwN7-0004ML-LB; Thu, 19 Nov 2026 02:15:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1xTwLX-00030U-AB; Thu, 19 Nov 2026 02:14:16 -0500
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1xTwLP-0004KI-Jx; Thu, 19 Nov 2026 02:14:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uBqyIKyTNvSeOHdiquzL4z2UuSHTztG42QaTYY8v93iTKTgITFKAEG4KIWc+uO0k+kgrOlRUPym71ruSotiAbs9iKIZZrk58GJ2nBtrO8nqk8CeoBylr/rflZU3gVVeNjkXi5HBeuM6Ge0FboMNaeBnilkx1CCfpFBTkqcpaFAhI7QxNKhUUTNPkCBOEYkpdXaKnF+qKqDL9mkKQ+EoarZfJWVbqHEQuwgXZp1MvB/0kJPCXBwe5eRZAfIyy7fId7QpM6etVANjvYlb2wawe5106+fWjoRafwqNxzVehwEwJVeaBwsmZc/XVOTukiuSQ4Ske9kPKYVE9JsOiNlcNMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zqn7LyYVOuvwl2brEYItfdK/gAOVjL9nDh3yEC/hUOY=;
 b=AFz+27nBhdrguTiL98qIL943gBHZW4sMo5et0k3VZcKaem0NeYZcF54qt6GFQhkFO8AL0eKxaVz46pwT2CXSACLJI6Q4dx9AJ5oQpkCjkFSxH3V85JLh2/hkBuQiwF1fmH++oczyEKHq3g1NOG0SW1vK+FK7vyo9MLSLmR7X+DsWQC7fo4UkD0cvALoOYX4RDAv2bMApXTrr0RPr5G0fdU/wzRG68ZsTI87tr3Q4CnSYCiPnjCEPXD+1NsotznkgUNMNcZRphZIgD43dG+s0Lq4PSz/I+EMGqZIUwigiL3W4xNcf9IxBQcztDuaxeZS2MA3DoAB6Wv7YFCS+txH0UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zqn7LyYVOuvwl2brEYItfdK/gAOVjL9nDh3yEC/hUOY=;
 b=PplJwfr1ii1LjwhwzSVG2Rx8mzGcpuj2A2rcKMl/+/VqvPGGjhG/kRWe8NMqDyrQWDwVyc2F8S/GaZrAzTW4u3YcOT8IR18a0He7e0JoxqmASN9W5tK5EEOajmnHNigYGZ9Skw+lbgHK9a49kLz8bI5Oa5Ym333qaDv6fi7yNHo4HDWrgiuVX5RnRFK7I/F0sX0OEw5SDqz9eD2tkOOoeQahruip4H3xAKYVMRMGOwnyd8Rvr5YSw1xlhjr+MAuxiWFv1QT6hTBKDZ99sXzmYsXen4QqlxrsHTduUEHkGHxjS0gYvmPE8qLqOQ/iTaIKp8srS+x3SnVOmoDT45CAiQ==
Received: from SA9P223CA0007.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::12)
 by CHBPR18MB434425.namprd18.prod.outlook.com (2603:10b6:610:407::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Thu, 19 Nov
 2026 07:14:01 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:806:26:cafe::3e) by SA9P223CA0007.outlook.office365.com
 (2603:10b6:806:26::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Thu,
 19 Nov 2026 07:14:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.5
 via Frontend Transport; Thu, 19 Nov 2026 07:14:01 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id B4DC140BFE13;
 Wed, 18 Nov 2026 23:13:59 -0800 (PST)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: 
Cc: Kuan-Jui Chiu <kchiu@axiado.com>, mark.caveayland@nutanix.com,
 philmd@oss.qualcomm.com, 163wangjack@gmail.com, peter.maydell@linaro.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v8 09/13] hw/arm/ax3000-soc: Revise variables accodring to
 QEMU idioms
Date: Wed, 18 Nov 2026 23:13:49 -0800
Message-Id: <20261119071355.3520249-10-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261119071355.3520249-1-kchiu@axiado.com>
References: <20261119071355.3520249-1-kchiu@axiado.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|CHBPR18MB434425:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ccb60b69-1b4c-48cc-eb29-08df460cafff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|261026140227099003|261021123027099003|261022105027099003|56012099006|261021121427099003|10067099003|261021130227099003|261021135927099003|261021133027099003|261102123227099003|261009223027099003|261022075727099003|261026135527099003|261022115727099003|261028144727099003|261022113327099003|261026121527099003|261026130827099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: sXKEqc7Wovg8u2wjV4TyiSNLqI1LXDuG0JvoINrcR1rnYcsp8+wvOscDt2Lq8Ehem3p7HBSfPqfHqePX9gvaqDLgpHv5IyHAUDY5azKE0uyLWXHLZoQbrE3N244WslwOtIDOhcsP6ZEMohIzYiEnV6pvWFt9mGFZfttJiF+ZqV73rKXi3Nu/Dwd6Q8zYaExKp5G9z0/D2gEfHzWxQq8EQ6+XJ0ae350gwBmyTdsnyyTqVzpPTlJ+fh/pi+QQ5uD+Dr13y8obQ2VZdQYg7U1H1I482jageeWOZQ+QXo4Ir9pdFVKQgnyoW10emT95kZ84T2s5m+uRM4VDDfvG3dhtY1CRoA3Xto8rGMTXUrSfYoOFxSUPLbrHx0Dl41RDCH45gOyLLhgqbuqOqESkJESsqHfNxb0ckIy2e6XXw7SAcqDYh7CM6WdKBK8fKZF3T1X6eqflvDGAyDCE76tWjp8+/Wcs0mHrzcz5uEmOzpZe/SHFcAfTfYQ3g/n9rMPnLKS+b/2jI6AdR5kJoYaNT3qy2T4gs5Oh2yf1y3yG7X970RlXn/s/7zlV1u9VIgcUzsqjqt37uLjk52XII/WR/X80LibC4ytxKh/I4OftAtI+4Fywbx7FZaRxpU8Vq/uspIBeO35rpvvZnAAjCWdcFCYVhOH5xt5Gt8lynMP49BpnhfbrClpXX8OxIS0lKeTFG+ZeetOtP0Q1lnZsoW2d77B4Wg==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(261026140227099003)(261021123027099003)(261022105027099003)(56012099006)(261021121427099003)(10067099003)(261021130227099003)(261021135927099003)(261021133027099003)(261102123227099003)(261009223027099003)(261022075727099003)(261026135527099003)(261022115727099003)(261028144727099003)(261022113327099003)(261026121527099003)(261026130827099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JnRK0ssVOU8qf+5nvwM1Tt//NnqVzDL33gZh5P14bO+3jtCb/zP5r7UlTL+gWg+yMO+95hrraxhH3fnk4WAieUkzfTkCJ/44NitR/pTTTc9BbvrM6jxWApE50arPraP2zVyXCE0Q3XAxgDoqRrNmg1nV9wjAhm5MyfRx4dr7SFmw5Y3qmBAA8C7dO/X6XMuK0uI5OnSc9V2LWJk+uXEWF5k0ZGmGzqKlMoFa3ptymU9SXMPwXmr3rlN08yh22KC+kukHw/kc8T5XZO0+/6V2bz5F3GEIBmdN1Ulb7XS0s7YMFNWeDKXgpfDHU19TdGn7nuSqtUkjPlD4HrPlbLy7kJHEZEp3HxmGruGUYC+sAGU+AR0iOZot+BLdqkfk32JYMo+36XxmWvLt5Hgr1O1FBUenxf0anbEPzWvLM2utRQv7oWxTaltOXY9wRVlwWChF
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 07:14:01.4991 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccb60b69-1b4c-48cc-eb29-08df460cafff
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHBPR18MB434425
Received-SPF: pass client-ip=2a01:111:f403:c107::1;
 envelope-from=kchiu@axiado.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

1. Change the first declaration of struct to parent_obj/parent_class
2. Remove unnecessary typedef since macros add it automatically

Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
---
 include/hw/arm/ax3000-soc.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/hw/arm/ax3000-soc.h b/include/hw/arm/ax3000-soc.h
index 4987ee3834..e09cd56c30 100644
--- a/include/hw/arm/ax3000-soc.h
+++ b/include/hw/arm/ax3000-soc.h
@@ -60,8 +60,8 @@ enum Ax3000Configuration {
     AX3000_NUM_GPIOS    = 8,
 };
 
-typedef struct Ax3000SoCState {
-    SysBusDevice        parent;
+struct Ax3000SoCState {
+    SysBusDevice        parent_obj;
 
     ARMCPU              cpu[AX3000_NUM_CPUS];
     GICv3State          gic;
@@ -70,13 +70,13 @@ typedef struct Ax3000SoCState {
     CadenceUARTState    uart[AX3000_NUM_UARTS];
     CadenceGPIOState    gpio[AX3000_NUM_GPIOS];
     AxiadoSDHCIState    sdhci0;
-} Ax3000SoCState;
+};
 
-typedef struct Ax3000SoCClass {
-    SysBusDeviceClass   parent;
+struct Ax3000SoCClass {
+    SysBusDeviceClass   parent_class;
 
     uint32_t            num_cpus;
-} Ax3000SoCClass;
+};
 
 enum Ax3000Irqs {
     AX3000_UART0_IRQ    = 112,
-- 
2.34.1


