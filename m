Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE881606A326
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=axiado.com header.i=@axiado.com header.a=rsa-sha256 header.s=selector1 header.b=fsWpBckw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTwLu-0003CN-6c; Thu, 19 Nov 2026 02:14:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1xTwLV-000300-Sg; Thu, 19 Nov 2026 02:14:15 -0500
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1xTwLO-0004Jd-I5; Thu, 19 Nov 2026 02:14:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ljfKcDJZjgAAXFa8R4yNI6L7Pgybf6iVfTR4PCIlF1+jk4Go4zKK4rHDghb8RwQViQZ61i+PXpx5QHsbq86bWIWFazKTvK48gQPm37fR7s8EI/VTE4+wDjRm2EhDJVsM3B6trrI/+NsEx0/+OnMb47EVPDygq5ysOsnkHjiJrMKtxBIUl0sGZsLg/bPP0cQtdLpOXH8YXIlz5t2X/JBfj1B4ylSOcWsLPUjyDOJMI6Bp9SwPM/3pqRfMIy+pK6g43JX9kenX9UV1mh5bsB1Zx2KlWqWpKF9zN8YxCbsoEWtr1tvHankWQDgtM8gt7kueeVHU4DDtBkI9qyinzhxOMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSkBbC6n7ucuTwJwHCHPMcJYIzG2om3MUS9qW59ZBV8=;
 b=gJE0DWMYhPFNaiDVwxbOHZGBbCRJV55Nl6nb94Cii80q50HVJ0wQZNaGj8/PmgvBkO5t8ZoFct1Ym0Y9cazICeeiZN9WChDvpdZybfWCX4OGJinLKUNf5H6CCbv10M8ugo6qnokfiFzgyp9TTMt9QrUuvtMe8AlGYQ6IJZrqXqKfyfTt+2cxa2E82zCEPsid03yDiWnFOt6zJMrcLykVvr2tTQS5ZP5h/zk72lCTeGlEQlJJoj4TXkP8b12e4OH74pb0IWPy49LKry8jFYCM8NXbf8D05gJlfAqRLOsn78OJN3G2utLq3Zt8GLblaZ5m/eO6UzpMEig4QNPGW+UkqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSkBbC6n7ucuTwJwHCHPMcJYIzG2om3MUS9qW59ZBV8=;
 b=fsWpBckwlMllCuDbr+sssPdYp77bdO4xFvTLe0JAWF25y24WVY5TgapnYdtljV/e6rlsX3XcXiw1ellruYHb8W3O5XenjsF2GQb5E4DVw/0OKNlel1lr6qojxD6vRFj66ziA7d2m9qPBYOd3roa5glydkAg5D4uD7okl0fsPzE46KNz7cRe6iSPwRtWtXyv3pNva0CRvTXUq3vxYs4we6rroa5EOc+WlW/hH1bZLyEZk/T97yhMlDPQ2jdsoyfDERxy8chCxtZESqfBYMVEB01MRfED3Tozap33cMaK2FJaX4un4jxSSgT/kC8NxXorDCnCthqSDRbmoICWPJ4DUlA==
Received: from DM6PR05CA0053.namprd05.prod.outlook.com (2603:10b6:5:335::22)
 by FT1PR18MB883273.namprd18.prod.outlook.com (2603:10b6:170:30::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 07:14:01 +0000
Received: from DSM2EPF0000000E.namprd02.prod.outlook.com
 (2603:10b6:5:335:cafe::60) by DM6PR05CA0053.outlook.office365.com
 (2603:10b6:5:335::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.10 via Frontend Transport; Thu,
 19 Nov 2026 07:14:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 DSM2EPF0000000E.mail.protection.outlook.com (10.167.23.8) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.5 via
 Frontend Transport; Thu, 19 Nov 2026 07:14:00 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 2BACA4186B5A;
 Wed, 18 Nov 2026 23:13:59 -0800 (PST)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: 
Cc: Kuan-Jui Chiu <kchiu@axiado.com>, mark.caveayland@nutanix.com,
 philmd@oss.qualcomm.com, 163wangjack@gmail.com, peter.maydell@linaro.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v8 03/13] hw/arm/ax3000-soc: Enable BXRS support of CADENCE
 UART
Date: Wed, 18 Nov 2026 23:13:43 -0800
Message-Id: <20261119071355.3520249-4-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261119071355.3520249-1-kchiu@axiado.com>
References: <20261119071355.3520249-1-kchiu@axiado.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSM2EPF0000000E:EE_|FT1PR18MB883273:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1ef39f4f-9deb-4a82-3c96-08df460caf43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|18002099003|22082099003|3023799007|10067099003|56012099006|261026121527099003|261021121427099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: mZXPhjpuipCtPxIuS4jU3GnFnnigSGqX5ts+dieR+ABA7q8VTnClHgucbGlAqLha1VXtzuUPFtHJoLJyVBTE7rnIIdFzz8Ok96AifqOKYGVIwc/+sPI7tk5+F6VGlaZ3WkOjgKw5UcDDBVvRCxpzwh282If1GMxHgtHm0LMIAauf6lFRpFU8o8vjafzNjbWJYTLXBPJgFRm81nC+XVFgyUWq1ja1y0Km3XoAwr0SSLg5c0U5NpNveCIdr0M9r8dTs5J3ybxfiUtREol5OqD2NQoUS0JNL6a2nz2qwoylZpjbR8JH0/hTSuldye2MHMzuv8KXMIHqJFJyCYspsYSb0jH6mNigqqtAqHX8q0f36uqjF+KuhrROCpr9chR9uDG2BFflIEHbongSTsXxVYN/HhOFcK6jkkwc20iV4SMK+NzHqrTa321v7dfKoKkrlPeO6TZ28OOvRyMk/kxWjnm7feabtg7NVCq0OXLH1iSWEttP39scRXmwH6HBpO6wLQKXsNxw912FoiHAoctA3FbkgEovQHks0LX6tn1ajmkxEVooZYy5WwmbYP+W2ljXtLp/d1RMEBnNx8ESH/chqMfoUtsD4v8ATH8DIpc3wNMm9lkx422KOYtyIKGQpURoqtgPk5BYnLMN2UrkvxCaoIioB/eHDxrSGZzq/sDvdO+RS3xNrat+XFfRHdxewS3J5weOUXCEBBbAPNxuxeg+yALMmw==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(22082099003)(3023799007)(10067099003)(56012099006)(261026121527099003)(261021121427099003)(261102123227099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: coSQnnvN5rDxyTl/Wyhhp5B+90Red1G472w5F5ae85Hb9QQjVHZdTWtCf1HkNDlb88UmFeidOQj7jLHVexav1hddX6/5P5tKmtqALO5vdfGKN5q0XJ+9CVF6u5xlDDFxiKl+pFm8BZ8PRj+OVRIyAWVvdJXjQ20UNvFjFmL+YBjhT+Dkku/ygF5gKrPvsU20jzNeP5OvDapM4PVYG2qCC70xEx3wRTUzlGhlCljDiEHpfnFQGX8/BEo2Ge0WmIQRhd+ScsZrQT+Fg7cPORpCfFoKcVTfgNusgqlg5NRy1akd3NE+Awm51CUENrfEQJqAWxhvMpZdR2hL1TXuIbUFnq850+3M5bkNzonAl2h1qX3hpvLSojHf0hdx0qDNMcMU4mLi6gejexh50PmBWlitqgGvzuFqP5HhvIvw+5xK41MiaobvcEaCHYfUrOmut9jE
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 07:14:00.1588 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ef39f4f-9deb-4a82-3c96-08df460caf43
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: DSM2EPF0000000E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR18MB883273
Received-SPF: pass client-ip=2a01:111:f403:c105::5;
 envelope-from=kchiu@axiado.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
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


