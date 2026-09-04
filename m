Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55268C79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 16:16:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2WZg-0004Af-BP; Fri, 04 Sep 2026 12:15:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WZd-000431-6j; Fri, 04 Sep 2026 12:15:29 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WZb-0008SI-7e; Fri, 04 Sep 2026 12:15:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K6cCiQPYj0bAauwUsNk0rScRnLYBn3hjQh8WuUx8mZoVK455lgb1EttJdFaFgEKFYn0RTTheZ3yI6TzUeSXYkkd5np7N0LNUJifEdNX7xFCLIue45CpTDcruiguH+uyFDhw4fYUHIzDj4156GAY7xmvmXhNn3fw9PYtIZRJyjU53WvFYYaAxYfca3zh3GxKWiBMrtr95g44nmPUL06bDpDGVgGambp80SBqCcAm+2czPPq0FlsE4u7D9S6fB/AbtQ/B9R0gkyiC6dk8uBAMwSoz2Ii0G0Z3LStBKfH6Voui8oC2YVVXBZ/JtyJ8GozpqiKQpBlcKllbUSr30nhq/mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YUbK02GufP4K7iePgABoMn2et/d6TX8Ricc0xqJDAnA=;
 b=EqTeADx8xMj7Sqim3glv4c2YinTeZ5cofe1loGai10IY18YWQPVvqoBqxqOlJbajf+vC0zGl5bIeaLOey1y1Emc9h3OfxzRNVUj0yH+2m904xZj4iCEKBrZvKyeGZIqZ5qTp2lDwW4j6x0wjmcjQkUvtkIysNuk5YUNP9YzAzC9dMvMW/DcGw9hVHKU/C+niHJKriWr5IsgS4VVrsbr/SoLM7j3XKH8EZ2Wp+SQV251D93/vVHtFfzNOADh32Cu1sMJQlk1FETFp/Gtq5y3LMpLHjHMDkZjBFMZud0jiLQ6Xc3TFwu1F1/9aKireLJAH/M076n6DkqpI4z03ST3ZeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YUbK02GufP4K7iePgABoMn2et/d6TX8Ricc0xqJDAnA=;
 b=TciqenSwGsapWQSes9iXRukUVUkAbUquc6dPXKffC/WOGW88vNGZ0tSXj22E9khMW8055/8NBpbpoyXmW/l3yA90UgOOcwoZteguikjjyYuNopy1nzBtmSnyKLCQOkp/kIsFNOzVKjGEaT1nWIvGsuBKy4jaVic2boXJ0nCwHbcACSwAFhVGne60/MQv+EnWlfg5hgbpikPJsvG3NnF/rGj5QCHAX+cDr8WKn3WSbFLsxcNRtaTU2cDBDGcNa8RspGTy6OynxKVsufdU5NjGmOXVa0WKKBguQ+R/yRLiQmdA1oeDNMfPIlW8xVR3x7hmr8nzDK8sajgEyunz6kNZWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by KU2PPFE04A6CE19.apcprd02.prod.outlook.com (2603:1096:d18::46b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 16:15:22 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Fri, 4 Sep 2026
 16:15:22 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org
Subject: [PATCH v2 06/10] hw/sd: sdhci: Honor i.MX uSDHC vendor clock gates
Date: Sat,  5 Sep 2026 00:14:29 +0800
Message-ID: <20260904161438.3838261-7-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904161438.3838261-1-bin.meng@processmission.com>
References: <20260904161438.3838261-1-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PAZP264CA0120.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1ef::19) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|KU2PPFE04A6CE19:EE_
X-MS-Office365-Filtering-Correlation-Id: ad775d34-9ba1-4b23-dcc0-08df0a9fb8ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|22082099003|18002099003|56012099006|3023799007|10067099003|5023799004;
X-Microsoft-Antispam-Message-Info: qY9QutgaBFSuPo2/KfVf1UZSJtfvNMrH/LwN7FA4HDUevSzeFOswxJm3DF5S5/bcIpzpDsLLJAoLq5SB656FtUY7cSTsaFz7OqpCvGT2GKPtuz8gTvHfYSeDToua1goDpi1RvytiCMWMlNyg2rnBO6HRCm8rXB9IyOvk4v/SQXjtvFmRH9QNXdfrVMvPlFWQWzNE84INb99QYaM09NODUev/jCCs6p9ThYvA4JE80aa5/9XZFXjtQm7toGkZrIIXGCPVRMR7UtiQZ2enDpzKlxYiGKLbmaCA2VQRa5yNKHhA1IlX8SamBW9GWV7pw2R3CKTeBVqaINJ1BRv6w5H1GitErMDo7R/LguhMPiSjq8j+53O5whhCHsY9Gxb0DJyHUqofJb/FSv1xEP1ITN1J5n/ueBZ0YvmbtL69BUu6Grj8qCbTN6SHA6W8acXZ8+K1xolDCluvN6o76fRulJrMnDfvRXM/G56MH4CivQmOYSu1LzkSCIRddoZkJtPtNvIRaBIvUPxhq0k+n9AfOChICW8yglO9RZN/lEZIAUGYJao4n4G6SonRy4hLOs5OVXIVrEkIwv8WRr6kEulvyvw1BMTd4AYha6o4esQcCOrbd4fXf9wrnR3ZnFC2Nodri885/MCXjhYTwcgXHo9yMWaNod45i5UNeEcTXROqr8gkUgs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(56012099006)(3023799007)(10067099003)(5023799004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OC93UXRkSUhhSkltZFB1anNkSlk3Z1pmVElVcGVrZFhacysweWpCTG9lV1Zu?=
 =?utf-8?B?ZmRjTmo0cVhHUFR1d2FFclZ0ekpPaGFYRWxjdDFuY1pWWXBabG93NUQvSXd3?=
 =?utf-8?B?M2RWdFFYb1pTaGd6WjZrZXYrSUZHcFkxSWR4eTlnVkVxMGFHMWFLMXh6Njho?=
 =?utf-8?B?QTBYdHlUSW93MG9PamM4MDBsV2h0UkZMSUltMmxlM2p5TEw4MW5mSUhxZHZ6?=
 =?utf-8?B?ckNiYlpUV1RndUcxdDRvYUZlZjRnbVFBbE9EWnJCOHFhQ2pKN3hqRXRJZ25o?=
 =?utf-8?B?TG9uSWdBekZOa3hQSHR1UWJDTk9ZeEZGNE91REVWQ2dVVTNWNDV1aUpaWEdP?=
 =?utf-8?B?TkxtVTNmdE80TWxESEZ0OUdLcmpmdFo1UmZweUFlNHY3YXN4Y21pdjNoWUJm?=
 =?utf-8?B?b2l0SUFMUHM5S2dvck8xL3dNUnd5dWd2UGl3Q1lSWVcvZng5SEJNVFlUNFBl?=
 =?utf-8?B?a2FMZzg0bEpscUpxYU1yaEo0OEsxUlp4R0p1a1h6bXEvNzlQSGhJYUxrNEk5?=
 =?utf-8?B?ay8rSjU1YUsxOTVSTjZVKzNWVFlyZldlUTFPY0dicUs4cWJqNzZZODBISnYz?=
 =?utf-8?B?KytqWHNkbVVXOHJUalJ5SlJWS0pDb0U1WEF5YkFGOXhKaEt5WHhlS2VOYkNm?=
 =?utf-8?B?Vmxsb2ZXVHRBOUgzMFhDQmpwVmFxMi9ZbWpHTDRQM3lTVXVRenZmOW0wYUFu?=
 =?utf-8?B?UHpmVEphVnY5VjRxRmp0ajFxeXZabEJxMStyZW0rYnlKdit2ZjMrU09lZ2J0?=
 =?utf-8?B?emU0c0RKZWwvVkkyaGhkd1ZxYmVyWllqNkVNbWs3cDlEZ2c5Mnc3NHJvSE94?=
 =?utf-8?B?MERzU0luUGJldEJDS2Z2VUkwdEYrMUR4Zm1lL3JUSEI1ckNIbFc4MFVZZ1lP?=
 =?utf-8?B?cUwxajRQdXIwTllBYUJyMTRycnBjUWlnb1BSY2VhaDlIZzlwS3F1dEZmVlUw?=
 =?utf-8?B?Y29SZVpubmpNcS85NzRJd1oxc1BEYTdFY2poWXY4bHNSRHFObW8ralh4ME1r?=
 =?utf-8?B?T21XRHdZd0dxT0p2RjlBYnovYVBJUzBXNnlISFZ2ZUloUG5FNHhQWEliZ2hi?=
 =?utf-8?B?dU5Rb1RqOCtJY281a0pLTXBLd2RBMVN2RVYvWDB1UFdyY084bGtwUzM3SVQ3?=
 =?utf-8?B?TTZ1UWErcWFmSUlKNEtpc2tVS0c1U3pUK3FVSitXOVNFdUFkbmZhNWJOUnpV?=
 =?utf-8?B?Z2U0Z1plNlpyM281USthc3VWOVRPNk9mb014UXozUTZHL1RON2tkSmI0LzVu?=
 =?utf-8?B?NjFsdzhmbVp5blZKMkM3VTJRdzdhL21NRDE0UFM2aVl1eWVSTERHYVFrSmdt?=
 =?utf-8?B?SC85Skp6UkY3NTQ3MnRobE9wbXJLcFFjQ3hQVkR2NDQyZFhwNkR3b2I4eVVt?=
 =?utf-8?B?bmlUaTY1Mm10VU5VQm93Wnc3eHRsamlMZyt2RnZmenorcnk1TE9UZ004UFA5?=
 =?utf-8?B?ZEF3RUpwS0t5ZmJxVGx3V0N1TE1uaW5DdnZYaTNkcG9maEp4a3hBRDdBeWtV?=
 =?utf-8?B?Y1VLUGRPRmRhKytuVTFqTlZlSFBNRVo5TGR4K0R3aWRTS2ZwMTVDQTFwc2ta?=
 =?utf-8?B?aEcyWk14OTVWOTJqQVBlcTRmNkg1RDI4WWRNdXRpRFNiY2o4VWRpOTg5U2cr?=
 =?utf-8?B?WXNxY3lsTTJzYkZsMXJ6N0IxNjRHazZyZTNKR054Z0wzNmpTSUFmdE1DOHoy?=
 =?utf-8?B?eHJJeTZxMnVrVkpwRzJncUZjYmgxbElFZFhBeGJVay90MGZCeHd5WExtTGZ4?=
 =?utf-8?B?SjFIaHl0Tm5INE44c2x4a1ZLcTluUWNmUjVKQXB5WnVKS0NmRVpCcEtRKzlv?=
 =?utf-8?B?M1BYNS84OWRjZnRnVUxScFFyZkE1UmZhQ3pPUUdpem5uRERNeFZ5alpPcnZx?=
 =?utf-8?B?dmZGQm5yUXlFQWJ5VkNIUjJnM3YzdnVZY2FzNHlYcTZmcnJDYUthZmlqQVZp?=
 =?utf-8?B?L0NHZG5LMzdDQURSbnpLS2IwRXBrc3lrTVZHbE5mOHRmMUhjRUwyOG0zZjV6?=
 =?utf-8?B?SktMak1ZM29QQ1A2MElZbUVwdThUMm05VHFzSktxT2pBclNtZVRTUXBtYUpB?=
 =?utf-8?B?Z1ZNQzRPaTloTXdDMFlTbmJ6UVBxd3o5ZmFPOFlCMGdpZEdML1Q5dExCSlF1?=
 =?utf-8?B?c3NYZkZFcXFuWjdiV25MK0lFa3hiUW9ISnp2d2VJc00ySkZFR3ZxK21aT2ha?=
 =?utf-8?B?UFZUTytxM3g5eVJrUVh3bEhoM1l2b1Q3VDJ1OXgvOW84THpCTW9ZY0lkWlVi?=
 =?utf-8?B?enlBbnlCbnpjTXk4Yi81aXlXeG04aE1SSk9tK0xBanA0OWVDM3grSjkyMEUw?=
 =?utf-8?B?UWpmWVN6ekZLMHQzTlY2RlRNWExUR3JFQWpSOW45NUw2UGNDcEdMaE83c0Ny?=
 =?utf-8?Q?UEVe7VsG5VN++60s=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad775d34-9ba1-4b23-dcc0-08df0a9fb8ac
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 16:15:22.5341 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pxJLI2MEy3wju+X8TW+kxG/GB4uX85yTy3wP6hR4szQ0bDavg/TNPlMLJ9bY0VOkZQGzQx9pZvCVEzc0inhhUuSatGCYYJ4MSnAYI9jWvhw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPFE04A6CE19
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=bin.meng@processmission.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

U-Boot's i.MX uSDHC driver enables IPGEN, HCKEN, PEREN and CKEN in
VEND_SPEC rather than the standard SDHCI clock-control fields. QEMU
only checks the standard fields before issuing a command. It therefore
silently drops U-Boot's MMC commands even though the controller clocks
are enabled. U-Boot eventually times out waiting for command completion
and cannot load the kernel and device tree from the SD card.

Accept the complete vendor clock-gate set as another valid clock source
for i.MX uSDHC. Also report SDSTB when the vendor IP and host clocks
are enabled, matching the state U-Boot polls while changing the clock.

Keep this behavior behind an i.MX uSDHC quirk because the shared eSDHC
paths also serve controllers which use the standard SDHCI fields.

Reference: IMX6ULRM (Rev 2), section 56.8.10, 56.8.12 and 56.8.26
https://www.nxp.com/webapp/Download?colCode=IMX6ULRM

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

---

Changes in v2:
- rebase on top of the microchip polarfire soc series

 include/hw/sd/sdhci.h |  7 ++++++-
 hw/sd/sdhci.c         | 27 ++++++++++++++++++++++++---
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index 2d03e37653..83d465774b 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -112,7 +112,12 @@ typedef struct SDHCIState SDHCIState;
  * Controller does not provide transfer-complete interrupt when not
  * busy.
  */
-#define SDHCI_QUIRK_NO_BUSY_IRQ    BIT(0)
+#define SDHCI_QUIRK_NO_BUSY_IRQ          BIT(0)
+/*
+ * Controller uses vendor-specific clock gates in place of the standard
+ * SDHCI clock-control fields
+ */
+#define SDHCI_QUIRK_CLOCKS_IN_VENDOR     BIT(1)
 
 #define TYPE_PCI_SDHCI "sdhci-pci"
 DECLARE_INSTANCE_CHECKER(SDHCIState, PCI_SDHCI,
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 14c312a691..b6e447a805 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1107,9 +1107,11 @@ static void sdhci_data_transfer(SDHCIState *s)
     }
 }
 
+static bool sdhci_clocks_on(SDHCIState *s);
+
 static bool sdhci_can_issue_command(SDHCIState *s)
 {
-    if (!SDHC_CLOCK_IS_ON(s->clkcon) ||
+    if (!sdhci_clocks_on(s) ||
         (((s->prnsts & SDHC_DATA_INHIBIT) || s->stopped_state) &&
         ((s->cmdreg & SDHC_CMD_DATA_PRESENT) ||
         ((s->cmdreg & SDHC_CMD_RESPONSE) == SDHC_CMD_RSP_WITH_BUSY &&
@@ -1810,6 +1812,10 @@ static void sdhci_bus_class_init(ObjectClass *klass, const void *data)
 
 #define ESDHC_VENDOR_SPEC               0xc0
 #define ESDHC_FRC_SDCLK_ON              (1 << 8)
+#define ESDHC_VENDOR_IPGEN              (1 << 11)
+#define ESDHC_VENDOR_HCKEN              (1 << 12)
+#define ESDHC_VENDOR_PEREN              (1 << 13)
+#define ESDHC_VENDOR_CKEN               (1 << 14)
 
 #define ESDHC_DLL_CTRL                  0x60
 
@@ -1826,6 +1832,16 @@ static void sdhci_bus_class_init(ObjectClass *klass, const void *data)
 #define ESDHC_PRNSTS_SDSTB              (1 << 3)
 #define ESDHC_PRNSTS_CLOCK_GATE_OFF     BIT(7)
 
+static bool sdhci_clocks_on(SDHCIState *s)
+{
+    uint32_t vendor_clocks = ESDHC_VENDOR_IPGEN | ESDHC_VENDOR_HCKEN |
+                             ESDHC_VENDOR_PEREN | ESDHC_VENDOR_CKEN;
+
+    return SDHC_CLOCK_IS_ON(s->clkcon) ||
+           ((s->quirks & SDHCI_QUIRK_CLOCKS_IN_VENDOR) &&
+            (s->vendor_spec & vendor_clocks) == vendor_clocks);
+}
+
 static uint64_t esdhc_read(void *opaque, hwaddr offset, unsigned size)
 {
     SDHCIState *s = SYSBUS_SDHCI(opaque);
@@ -1861,7 +1877,11 @@ static uint64_t esdhc_read(void *opaque, hwaddr offset, unsigned size)
     case SDHC_PRNSTS:
         /* Add SDSTB (SD Clock Stable) bit to PRNSTS */
         ret = sdhci_read(opaque, offset, size) & ~ESDHC_PRNSTS_SDSTB;
-        if (s->clkcon & SDHC_CLOCK_INT_STABLE) {
+        if ((s->clkcon & SDHC_CLOCK_INT_STABLE) ||
+            ((s->quirks & SDHCI_QUIRK_CLOCKS_IN_VENDOR) &&
+             (s->vendor_spec & (ESDHC_VENDOR_IPGEN |
+                                ESDHC_VENDOR_HCKEN)) ==
+             (ESDHC_VENDOR_IPGEN | ESDHC_VENDOR_HCKEN))) {
             ret |= ESDHC_PRNSTS_SDSTB;
         }
         break;
@@ -2120,7 +2140,8 @@ static void imx_usdhc_init(Object *obj)
     DeviceState *dev = DEVICE(obj);
 
     s->io_ops = &usdhc_mmio_ops;
-    s->quirks = SDHCI_QUIRK_NO_BUSY_IRQ;
+    s->quirks = SDHCI_QUIRK_NO_BUSY_IRQ |
+                SDHCI_QUIRK_CLOCKS_IN_VENDOR;
     qdev_prop_set_uint8(dev, "sd-spec-version", 3);
 }
 
-- 
2.53.0


