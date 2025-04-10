Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04137C369A2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 07:01:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2lup-0004M0-J5; Thu, 10 Apr 2025 03:01:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1u2luT-0004Js-4z
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 03:01:28 -0400
Received: from mail-mw2nam10on2061c.outbound.protection.outlook.com
 ([2a01:111:f403:2412::61c]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1u2luP-0007gD-Iz
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 03:01:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YBj1TOHaow9I53oUjoMmNTuUGib5b40JLPB9jyvwXb7DhJvqeFTH3H9tHsoW+i3R+ZxHSUSoiO0zXr65EHg/rVvsVvV4SZrVnwSkE0P3nKOpI2Oz0wUFe2XkeJPrAYKtOroBOrH5CPm9UayHDtWFS8zGVVvuGFhfDspec60snYjMCgPNVHDuERX8tJaatENORn8KS1Ir3v+Ux451RY4mhUCUwUFdCtNcNMl2cTC3iswo2GthcTgRzmiHlJz0zptfmp01DLVOuY494T1Ghefi64nK+vigSCZOGonE2UWSJ/XR1VJWN2yy1BtbmwUD693PgpybhL6ThCtbodalZVMwjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qx2hh3r7ca4uL831/SFU/V00VFlH2vRY49XwQjZuYdE=;
 b=I1vOwJmIZ5xY3sW94m+5ZuJvElPk/CssVgOtH/cs/Ra7vqyrALs2gOwt/18aAqZAhRli7RdKc6lkKaQtcexYHQz4lSdx3VC5yl1oBBvdvW3tBbYDix1ceqwNTHsK+LOYmkWqmmfl+QgZxeZdk1mCSsQcaAnhqw1mVlIvr3geeBubtS/CCLfpn+6n+3C+GBZ923/sbqKOdLUFDdRxqqkSiodWGEHAI3wh63mf2vcif9W62+5glBLU9Bor4uBZ81snkLGrLCq9JWrG2cS5Ehi9cNUSQGiQ218OJmTqzMKWZTAdppmxSTsps8+Nz0E0qed7N1qAHtl51CMVk0QxF6Yx1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qx2hh3r7ca4uL831/SFU/V00VFlH2vRY49XwQjZuYdE=;
 b=tN0RnDClNinfRHlsu99T1pnlIgSBScyM9Yp7Fb0p0xqUukq14TaH+EPzF1osQw0HDTeNVei17Xk182EZrItbgUHZes1GSgJ9GIZdTlstWZOfJjZN0T/geb8UiamhxKAUjf1SaB/QGcw6Gs04dIiKMApSwIxpLcNgVbJnad2lhLo=
Received: from BN9P221CA0004.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::12)
 by MW6PR12MB8916.namprd12.prod.outlook.com (2603:10b6:303:24b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Thu, 10 Apr
 2025 07:01:00 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:408:10a:cafe::d4) by BN9P221CA0004.outlook.office365.com
 (2603:10b6:408:10a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.23 via Frontend Transport; Thu,
 10 Apr 2025 07:01:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 07:00:59 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Apr
 2025 02:00:56 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <qemu-devel@nongnu.org>
CC: <suravee.suthikulpanit@amd.com>, <alejandro.j.jimenez@oracle.com>,
 <joao.m.martins@oracle.com>, <philmd@linaro.org>, <sarunkod@amd.com>,
 <vasant.hegde@amd.com>
Subject: [PATCH 2/2] hw/i386/amd_iommu: Fix xtsup when vcpus < 255
Date: Thu, 10 Apr 2025 12:14:47 +0530
Message-ID: <20250410064447.29583-3-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250410064447.29583-1-sarunkod@amd.com>
References: <20250410064447.29583-1-sarunkod@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|MW6PR12MB8916:EE_
X-MS-Office365-Filtering-Correlation-Id: a24ff94f-b15c-4a34-bc55-08dd77fd7330
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y1UvaHZXL1lPRnhCODlMSWZTT3pBSjlmeDRnSkJBL1dmVHZZVDhjcHBLRzFW?=
 =?utf-8?B?dkMwNmtIaVc0aDd4MG1QZXJxZjVCcjlSL2ZsV1VCSXVmQXRlZjB0SllveThw?=
 =?utf-8?B?d2tkenRRZDRvSWgycG50SndtalZYT2lGTWZCdmF0amZvRmZzWUVQMnhxZzBC?=
 =?utf-8?B?YU9kM3hmVmFISE5YeUtsMFFtZTVSVGJsVUEvOUpaQVY5VVU5bE91S3U0MWhi?=
 =?utf-8?B?UC9qYi9TZDRWNGJmU2NkNjg4Z3FmR0NVaGtMSFJRcmh2ajZ5Qkkyb1o2YjB4?=
 =?utf-8?B?NFhoNmdvT3JUdjkvWEdSR0s5YXo4ZnVsM1ZyTGFhOC9WYng5cXREcFFUR2JI?=
 =?utf-8?B?ZGd5b1YvSHJXV3gwZGhuQmdERHpoTXJuTVBiUE4xMGd1K25yWUxoVk9kOVQ3?=
 =?utf-8?B?VzFtdlhPN2ZoN1k4NjNTMElPaXdlQmxpRWJ3MytaS2pocjFnYmd4Q1JUTFN4?=
 =?utf-8?B?ZTE5dzBnY0hsZlFCbWNHSlhHVnN1ejdKTlVtRkNkTW13bHJ0SlJhdHk0a0tP?=
 =?utf-8?B?cE9HMlpQQXJwc3M4bGJXaFhWTGIrbng2OTZlcEw1NytkQUpCMU5vZ0hHQmZE?=
 =?utf-8?B?THl2VDA0RnJTN1lVMjVnYVNkVU51Y2dhaFRqUkYxaTBzUGppVUpLMFp0cHMw?=
 =?utf-8?B?L2FPaUpZdVp3QTVCRStmRmw5YWxLRXF4L2dXQUs0cE5iUGRxZWprc1IyUnNr?=
 =?utf-8?B?bHRQN093OTRQR0xCUThybG1TcmRIcVgvL2FaejdrSmJXQnVUN1Z4aE12akl6?=
 =?utf-8?B?VmJsRys3K1hMZmdFQStuYjRrSzk5b2w0RVloZTYrNmRGN1dkZlFsSHVoTytr?=
 =?utf-8?B?TnN2NnJKSnR4VU5NWmxRYlBCWEQwbG5QeFRTMFhhRnA5SFhROEw1NTJTL1JM?=
 =?utf-8?B?U0kvVm1qd2lXMVYzSUFmZXBPdGdvV1lvcnRPMlhZZDVvYjlRcGVBb05ZOTVO?=
 =?utf-8?B?bG1xU1BNbXdtMmNpTk0yd1AyZFdHMmtCTFhmNXNvajQzaXp2QVJFSm9TdE9G?=
 =?utf-8?B?RkxTSm5WcytCTHBmdVRFSHpRMUJET0xDQVJQdjhRRG4vNGxqNjNNQzFDZUpQ?=
 =?utf-8?B?MGkrU3RyL1dORGRFL2hWYlFGdzZTOWVRdkU0MVJ1a2FBb0hxL2YvZ3RnUnl6?=
 =?utf-8?B?NEpRaFNKd0FHRHFtUTFFYjZzakFhZzgzWGc2ZUcrYndQSU42RkRwZ0tMOHcz?=
 =?utf-8?B?cCtCQjRTaVUrV3VIRHdHbFdoZ01TR1FTUXIxb3hCdWIvSkVNMDg5dGZSbUUw?=
 =?utf-8?B?MnhteG5WSkhmUm85bWlEZGNmSzRzQURveThFY2h2R1IwdjQ3RGFEeEd0TmZH?=
 =?utf-8?B?a0xZd3l3MFF3MXNhODBJWjZoSGdZZ2YxSE0ydzR2SmRUYTRQUG1TQ2FnK2lr?=
 =?utf-8?B?emhMa3JhU3dqTGRzS0xVSkV6di9MTGJEL2EzZENwSVIvMjZvN1o0NHBKbHhM?=
 =?utf-8?B?UDdTZlRmc2p0ZEJRVHRJdVVleDhRZjF5OXhIYytGM0J5aGpxMFVqeDBpYzgx?=
 =?utf-8?B?emF1NFRPZS9mQ2VrT2hUelBDU0lBWlNGbzRhQzRBN1NYSEhCM2JiakxXVXJ1?=
 =?utf-8?B?Z1VNaEs5MnZQVVdHWDhjS0hhMFBZNFlhMDZxZnZwYkthQXJLVHVUTWtqK2J0?=
 =?utf-8?B?RjN4SzBaQ0JuSndFU05IM1dxTDF2dHo1SGJHdXI5Q1FGNnJOQW1aaUZZTWtI?=
 =?utf-8?B?azBiUHltWHRpRzd6L2M4bUhqeFAwYndSamc1WkhtbU4vS0ZWWXBWVjBvcHhX?=
 =?utf-8?B?ZWFQSmkxMmdvY2JwWkxiWVoyNlpYU0hLTndFMTRKNGpYR1NVYVJScUtHQXg1?=
 =?utf-8?B?OFNqeVVTYzJBZWhOcWV4R3BGNjZwcFY2dFBMaHlZcGMvWU02b21GcU5NaUxL?=
 =?utf-8?B?T1o1U0ZXNlZLNGxxeC9vM0xoUVJkZkMvdnF0N04yL0owSEpYSTFidTlQV0Z6?=
 =?utf-8?B?RCtwekFPYmdlUUtDeEhoREpna1ZOdDBrMTNVbjA5U1B5TEh3ZGc2RU9mSXJ3?=
 =?utf-8?B?RUdQRHByUUlXVlZhN1JFcWhyKzY3UStwaFV2Mm9Qak1HWGVUVlRPRG83L1Ft?=
 =?utf-8?Q?dLEyUi?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 07:00:59.9014 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a24ff94f-b15c-4a34-bc55-08dd77fd7330
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8916
Received-SPF: permerror client-ip=2a01:111:f403:2412::61c;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.505,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Vasant Hegde <vasant.hegde@amd.com>

If vCPUs > 255 then x86 common code (x86_cpus_init()) call kvm_enable_x2apic().
But if vCPUs <= 255 then it won't call kvm_enable_x2apic().

Booting guest in x2apic mode, amd-iommu,xtsup=on and <= 255 vCPUs is
broken as it fails to call kvm_enable_x2apic().

Fix this by adding back kvm_enable_x2apic() call when xtsup=on.

Fixes: 8c6619f3e692 ("hw/i386/amd_iommu: Simplify non-KVM checks on XTSup feature")
Reported-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 hw/i386/amd_iommu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index df8ba5d39ada..af85706b8a0d 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1649,6 +1649,14 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
         exit(EXIT_FAILURE);
     }
 
+    if (s->xtsup) {
+        if (kvm_irqchip_is_split() && !kvm_enable_x2apic()) {
+            error_report("AMD IOMMU xtsup=on requires x2APIC support on "
+                          "the KVM side");
+            exit(EXIT_FAILURE);
+        }
+    }
+
     pci_setup_iommu(bus, &amdvi_iommu_ops, s);
     amdvi_init(s);
 }
-- 
2.34.1


