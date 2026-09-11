Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2865C79FA1
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 05:18:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4tcm-0000Fs-2L; Fri, 11 Sep 2026 01:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x4tc2-00008F-02; Fri, 11 Sep 2026 01:15:46 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x4tbz-0005j0-6Y; Fri, 11 Sep 2026 01:15:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=saXCXZ69u9BcvO+rztOu4P7DfTF3/YJ1UojogmNHoRbP1SSN+Ln+Bj6OaViaDXJ6Kr4wJVNYtsZ1ihrpgG1UZxz3OBCMbqUbPivbcTxp3mdtgQw6F8VILb/e6h5kFD4lXbk1W7iKrco+1TBrKnMGK63sd5JqrPvW+zdWmY1bM8D0wPMb89Rsce5LAEZQgG35YCwzIXgrTZF3OQxjdcL1hkt+99k83WpJsClzZ4jCzb+fJeAG9aofqLuRJ7BTNj1aCRCYlfpwJ2Lu/JWDcybj9PdpFgdoEyw0xBc09q1sh6BK3hoD5FWR/bcqzrG8dJ40b77QJhD/+hm9hJgy7igOuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSkBbC6n7ucuTwJwHCHPMcJYIzG2om3MUS9qW59ZBV8=;
 b=nGUlnMDPZZRZXAgFGYfwZOfpf3WVnmKkmE55lzZKqBcil11uJuUUOdTXzXKuEJEO6JZDiG4jjY8qE8H1jbROEv458QQnA30pmZQep50QHbLMSiLNKD15eECdlrPDb7WEA3tsPjyh5urHJ/2/TADuty9T1F2R8WIkNmKTV8/bu2tzj4b6XOupnwVmBgl5zuUuHSn2xXrmMob853uURT2+pA2cLfiifL9RrgLjcFli5RZKLoiiUnBR5UMlMRJMchWhIxcN6GOKeVeY5H1S4SSiEZ0vFFv/k12sxfEz/7laew+j/+VhgauzfH0+P9R0SRl5g1biAGu2MiDEUdGc55meRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSkBbC6n7ucuTwJwHCHPMcJYIzG2om3MUS9qW59ZBV8=;
 b=XZK2lQnsbPjETMQGTBPBiRKFUA1Z78QXsH8ZM775TILqmDid/xVwyxYOURTWAww1m8+eou6KMHnUvnPaO8B2YZSQHvwFykbF+MKo2OLxEiEoPOttdTGOO2o1ArjeojgMavCiogqE/InRw64WH2wSnSEjl40DB+0gDPHlwbiDqvwR9krQ8pq174uVNRX65KApy5kZYXhv5dJ/WTZDNPGZLIo5BMklMZZ4ENO98lt78SpZ76cazv70ZZu1rBpA55d380rbhpJTtNbJU9TxZY1ujQOXsiESaQ03fqcsQ6SsjJEK5PtFPAmlihg9ineiCLIxvEVOepyxjexl+W6p+NX/BA==
Received: from BN0PR04CA0208.namprd04.prod.outlook.com (2603:10b6:408:e9::33)
 by IA1PR18MB5539.namprd18.prod.outlook.com (2603:10b6:208:452::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 05:15:37 +0000
Received: from BN1PEPF0001806F.namprd04.prod.outlook.com
 (2603:10b6:408:e9:cafe::4) by BN0PR04CA0208.outlook.office365.com
 (2603:10b6:408:e9::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.10 via Frontend Transport; Fri,
 11 Sep 2026 05:15:37 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BN1PEPF0001806F.mail.protection.outlook.com (10.167.245.197) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Fri, 11 Sep 2026 05:15:35 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 7D51D40BFE05;
 Thu, 10 Sep 2026 22:15:34 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: mark.caveayland@nutanix.com, philmd@oss.qualcomm.com,
 163wangjack@gmail.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v7 03/13] hw/arm/ax3000-soc: Enable BXRS support of CADENCE
 UART
Date: Thu, 10 Sep 2026 22:15:22 -0700
Message-Id: <20260911051532.2378501-4-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260911051532.2378501-1-kchiu@axiado.com>
References: <20260911051532.2378501-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0001806F:EE_|IA1PR18MB5539:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 478c057a-c7a4-43f9-43ee-08df0fc3b5e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|23010399003|3023799007|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: cy1meSZeX+UV9uIkKAx9hLeobMVS7Dc97z4qFqncegMJHWas6KMSwwPaZ3wQ4k9R+RZKu24XN1qMEcZv4+Wa9TaJaUcQHEkdl4bo1DE5MV47VS7mlnEisJg/vysQUl5Riryw2HvaM/EFYMLd3is4Sa3UuOettNO0iVR5LhlLWdw5M0iOXok8UUW4snTGimDZd3NZSrsZ+dKIwcC63HohEEMvLhrLH++Ta0HWoPqEY9z2UFMrheA1E3W8jntLyIaQUefJYUlmrxahIF8lC3uSz3wN610vuGbweAm4LjyKHEpTgngDLhotsic45/g2QsVQl8rzhvOfod7UtNFq/Eq9BjoPURE7n/gmUOET+cP0hl3OTmOk5Z98ElWnKk++CGWVBmzk1N76uVxEHfLZZvsSSlq/tfuCRgn/6fCYkOkEe3qTW9APX6VDi+hkbDnxfO0UN4RkygnbZOM/xitAzKALO0DJLOLsFI4TszHBi7aqJERPn30pao5Cr3oqvZujDrhrKSGpBLe4zK94H0mXwHK/AtcmCZBdhTnpmndV2PdzpFtPa9iAE9eciIJO1aItFEx36sQXrCmbogKN79SjOFhbIat9KkQv0QBZXTAomDgsMRfpfgtpxvw9Ik4jdHQu8fxyJYEm+SNXVRrHIfsKb2aX/DNNvLf6JRuk5IdamdYgRCxZAApNBDTvJFO9uyenC9m0cVuF396n3Jp3gZ1Khvn9UA==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(23010399003)(3023799007)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CR1ztmkXxDyA6kTv5XSDkzX0xse9gf/j4MUVb6rcB/JLqxIBKJ2yWFb6CvM1m2opuRdjTzGafK6vJWaXzErUEgniPCAg4ksuwGxk80zwDR1+GHr1+h1N3XTqOmsNeSnGgCM174bOS4VXWpxrJHw+Xfv6ssZbTv/Zba7v21CURSN7DUANv1CBZXvT4nldzoaBqUfiY5LYe8UGgXrs5x0XHIZv+1PzqBKMIdTUT0aecmLAUOY6uzU0yZSpCxX4KkZCALeMHtvDHBJGSU0oBvYh3YGean9J0spLZVjiQnO+eKkZ7KrTpVyfKRDRiuddSAKWB49aknZA+GLq6F5F2NPPXooXDgjKTfZZhcGGNCeoTv3cc7rzyqUgnlyIksOQ/58h0p5W4MlAGCzt5DLWZeSafpyEGM9X+Li8hqeZSTN0cnMuuvHPwtaO+8DdHpW+grch
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 05:15:35.2705 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 478c057a-c7a4-43f9-43ee-08df0fc3b5e1
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0001806F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR18MB5539
Received-SPF: pass client-ip=2a01:111:f403:c105::7;
 envelope-from=kchiu@axiado.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
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

In order to access BXRS (RX FIFO Byte Status) register at runtime, set
property brk-support of CADENCE UART to true

Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
---
 hw/arm/ax3000-soc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/ax3000-soc.c b/hw/arm/ax3000-soc.c
index ebe174fb97..7b96466860 100644
--- a/hw/arm/ax3000-soc.c
+++ b/hw/arm/ax3000-soc.c
@@ -155,6 +155,7 @@ static void ax3000_realize(DeviceState *dev, Error **errp)
 
     for (int i = 0; i < AX3000_NUM_UARTS; i++) {
         qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hd(i));
+        qdev_prop_set_bit(DEVICE(&s->uart[i]), "brk-support", true);
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), errp)) {
             return;
         }
-- 
2.34.1


