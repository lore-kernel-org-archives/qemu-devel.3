Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50DE7C61DC2
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 07:47:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz8Lx-0005ET-Vg; Wed, 26 Aug 2026 03:47:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1wz8Lw-0005BL-8B; Wed, 26 Aug 2026 03:47:20 -0400
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1wz8Lu-0001Zr-H8; Wed, 26 Aug 2026 03:47:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=woFgYTq9qAc+Cx0vEbwWC6q6w1sPdrHaEHw1MIeugxoVWM774hYgIIxcTrR6OnV5+g3C7XMcKmIZSnfwm44A+BNDntdV5KLzKrVtlMuehiFMPUROdyxjJetRlwNgpl5DmijL3JcnKNTDl++3udk/K+5GaMYgYaMm5VpZvC/a4AaQtMc8K1RD3zAp5UNeznTeSjfKrFZrJLJQ/ZjVOgwVybNw7HRWljCToYATB+spp4jtYJpTccxA819Mggb9V/0fainzXfw79Hy1L6HWV9Nn11NCdv1y/JiRw7vg09ktmBPcqFZJtzdQO7qOi/IYaMUP5O8fTqCBUA6w7kVzmzTK7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8u0ZhxAWidip+F8DBAYN8B40n2HFcCDsLncll+kbiw=;
 b=qWQe/T2JOSn1ibSKrEJ/HL4Il9n2DmegovBe8WZYjb+L850Ik0Wki13H39OKXqEazVK2iTtAXaBpMkJsceZYxy4L2lyRhmbzB0ZjoK9FeljopLgR3A+iwIgu50CrYMaqVXlvVQ3WlUAZlZ6Gyup1XgW4ALYSQPiCdVI+zuJTTkAUhncfh/VGMQlkCn2/vmMHCu8duOiri3/SwoYBWXpMPYNTxz86QsSR+f4PYL6os+Blpgc19eR7govxxNK5tlLyz2ZVxJLavPivAQYN5LaFuCf0hJf+ZZz7PvmrRmZ5ZRFmxi/ph44QCyOf+BmaJJ2I1Itlc60wrxKgmPV0nUFLcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8u0ZhxAWidip+F8DBAYN8B40n2HFcCDsLncll+kbiw=;
 b=gpjjEOJ5xITwpMCMwAGRrsRkcxrdDURsgyNMdwj0gpqfM/ZB6vETrYP8qz409Piv9RyTfPW7b6eo88yQM6BjxevMd415EAIXJSpqJL9p7zElxcUYSUS4SUn/Oh3IQ9WkLAgVNd9qJ9PwKuk62660aZ/twQ6CMt6UcRarG7ekDtn3OaeWHXQ1UJxesJ8lcUqF/ffwaFf3NZSxAoFjzckKdICbNvONjTr8Pbc8EkrH6HKRp+qLcvY3ArAlMCnG44swfqr+BbAbcRVjEKSdaFIh0l93+sXhPbBJk/vdLptj0pr8OGg4G2wKmKWw2uz0SgL4LiDy+5Q8D39WZ/DJ3op2/A==
Received: from BL1PR13CA0329.namprd13.prod.outlook.com (2603:10b6:208:2c1::34)
 by LV3PR18MB6175.namprd18.prod.outlook.com (2603:10b6:408:27c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Wed, 26 Aug
 2026 07:47:14 +0000
Received: from BN3PEPF0000B372.namprd21.prod.outlook.com
 (2603:10b6:208:2c1:cafe::4f) by BL1PR13CA0329.outlook.office365.com
 (2603:10b6:208:2c1::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.7 via Frontend Transport; Wed, 26
 Aug 2026 07:47:14 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BN3PEPF0000B372.mail.protection.outlook.com (10.167.243.169) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.0
 via Frontend Transport; Wed, 26 Aug 2026 07:47:13 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 3A3904186B51;
 Wed, 26 Aug 2026 00:47:13 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: 163wangjack@gmail.com, qemu-devel@nongnu.org, peter.maydell@linaro.org,
 qemu-arm@nongnu.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v4 5/8] hw/arm/ax3000-soc: Reserve MMIO of UART with 512 KiB
Date: Wed, 26 Aug 2026 00:46:31 -0700
Message-Id: <20260826074635.2850931-6-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260826074635.2850931-1-kchiu@axiado.com>
References: <20260826074635.2850931-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B372:EE_|LV3PR18MB6175:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: dd348f5a-cf31-4496-de98-08df03463e6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|10067099003|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: 23pCqHdoYyauPEhFpXUyhp1GhrK5sjgYL8eTCAgvCPyVtXzVv1sV92IZbAf3tMtCVWKQHj3lNP2uWS5cbDb3cbsJK5LvhnA4jewotNL/h8doywW+9rKeSLAiVKQCO4CF6ic7oe8FJiWt6uyB5kTWthFFgQhPGz4ykn/Yhsn3Dt5ij12qlXE7xWpkqP4rCTKJ3RIFWqEB9BfPI9No49n2FDAJ8XTOITGFkj8Ci9WdXcDzYqiqTKa58sb8+80uMmbdW2quJoiLlQc2mxoNGcOkX9K2n0ygPmRvh0g76B6yStScuUE5wx/Tdf+szu4Fmdi6uKEES7LZ1xxhArfIRIKitkQ0bfM7OFn1qmkcVQMBtAjUdfI+Dd6PNxpaUVFREWGWsYqKpKaO9938GSC83jtbDqRXfQ4241fDix1x3TIcaPhVkCC+3vu3M+L1jhbgB3wtu4fTGHFp8NZItTPAO/nzaYsc64SBUq9xKbr6YjulAMQMr0PtylcK/tp5A0zJB8GRVRLMZMeejc3TnvgM1T/cPlndnV/pzvpQ5+gHD9he8tVHaAkeRbc4uMegU23f882SV0t5H+2Cyon/qBbNKql9YABYOmm6Jd6H2vlduxUflU6RzauN1xfPz/vpHsUmfbAwBcO5cPP9zTanHflNOsNVjHYDpXnSKGFhaznlx4ROW9ttQxy4hFEAiQwvP/Ukeg2IesUWOVZ9IydxtKPzfh4f2A==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(10067099003)(56012099006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NSFdxfnyPiWwSczYqQnDf4FI2f5yYhgrjZjxfRRO9U3MLLpXtlUb8jzfZRFZ+AYvZNpdwyTZzKK9lbjalt9cPQ0/bw75r1VDCCNywJ4clCWmcJs7B31ksHgOyQv2gQxMNIO4aqfK4jIlUnzW07jSDpV9wm8tiqDqo+SK3RP5fD2YEaFBMxuC9fGQg3SMixif7Df8CkdI6YS3r4b2fxI/slZv5OrMiKjBdfEN8pSGfuqcNMYdcQn0fjF1izSrDVQFElcooGCRxEjtgOuktCD6l/sco2eEaZpqvzFzbR/eco/5TuzA/bj0awdRvpz9w17amuYjk6Kg+faVuAPeAtQuUfbdQ7y9armCYQu95gc/XT+JVXyEzdMJbTXIckCKuhhw3gTfQMlbynNOdZVrMLubEhMj2kSirIL0/9yIUXs8KIzh7IzpbjJx8pWdOJ2vTbp+
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 07:47:13.8207 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd348f5a-cf31-4496-de98-08df03463e6d
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B372.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR18MB6175
Received-SPF: pass client-ip=2a01:111:f403:c111::9;
 envelope-from=kchiu@axiado.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
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

Ax3000 SoC reserves 512 KiB for MMIO of Cadence UART
Set the mmio-size of Cadence UART to 512 KiB from 4 KiB which will
resolve overlapping issue between UART0 and UART3 in QEMU

Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
---
 hw/arm/ax3000-soc.c         | 2 ++
 include/hw/arm/ax3000-soc.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/hw/arm/ax3000-soc.c b/hw/arm/ax3000-soc.c
index a2e0b19732..046a5b7aa4 100644
--- a/hw/arm/ax3000-soc.c
+++ b/hw/arm/ax3000-soc.c
@@ -155,6 +155,8 @@ static void ax3000_realize(DeviceState *dev, Error **errp)
 
     for (int i = 0; i < AX3000_NUM_UARTS; i++) {
         qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hd(i));
+        qdev_prop_set_uint64(DEVICE(&s->uart[i]), "mmio-size",
+                             AX3000_UART_SIZE);
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), errp)) {
             return;
         }
diff --git a/include/hw/arm/ax3000-soc.h b/include/hw/arm/ax3000-soc.h
index 344fcb6f3c..032edafff4 100644
--- a/include/hw/arm/ax3000-soc.h
+++ b/include/hw/arm/ax3000-soc.h
@@ -35,6 +35,7 @@ OBJECT_DECLARE_TYPE(Ax3000SoCState, Ax3000SoCClass, AX3000_SOC)
 #define AX3000_UART1_BASE       0x805a0000
 #define AX3000_UART2_BASE       0x80620000
 #define AX3000_UART3_BASE       0x80520800
+#define AX3000_UART_SIZE        0x100
 
 #define AX3000_SDHCI0_BASE      0x86000000
 #define AX3000_EMMC_PHY_BASE    0x80801C00
-- 
2.34.1


