Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5682C3ABC9
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 10:08:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFryr-0001Xo-Un; Fri, 16 May 2025 06:07:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uFryp-0001TE-IP
 for qemu-devel@nongnu.org; Fri, 16 May 2025 06:07:51 -0400
Received: from mail-bn8nam12on20620.outbound.protection.outlook.com
 ([2a01:111:f403:2418::620]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uFryn-0006zq-Ip
 for qemu-devel@nongnu.org; Fri, 16 May 2025 06:07:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wQ89KsD5NZ4WucBXOfyvQ+F7xns9HW9MvrXqVA9Wec557GxO1lPbBEmF00qo2DFNBBvm6e4TBncgbsggJdjsgxABFNMVJsnIbOfzxK13rjN8cczucO1BZYk4iGXhKgiZqXVfxCrEPKAyueG6YGt5B9zV7ty+6tgMozaVQGwNx3EslCIXIc4EA/CjkWRpvG4LdePyZDRNhF3MIH5lGW9BbHpmSo192bn6uY4dlsuMBx395ki6/3XPEU2ifpHmRjNtKa21IqljebzcOmGFZ3j5n0d0eneoyPpt9aSYHLethdhuCOCs8TTblaLBrMXECGFbxWkNaZbMD/5N2+BdEz4eUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=14oAf5A0EYNmXltDJ7ufxtxGt2aefGtNtiiSPgLMGRA=;
 b=GpLYNCebKD958WUc6n76YZrGAL7RkZgBW2u0I2fN3/Xg6PR98zxkL9kzz+Xot7c0og+663w9XVNwOxsfLoB6AW32cs/qdan+3DnEI0k8y2N8wd53gwm1eGxujk+EgAFd9vU03k9ssMG7gFYD6Oho5gUkPj2b/6FK5SWpHuQpuyBlGxmzyAfZC29PC6f9oaNHVksxtJXN77I09fyr9k/fw5XTtCvoQHzKOwmXuSvIJrXCdrgLG0v6fcblywcCKpsZ3KlkjHh3HdDDZlnt5czyMWZl4oAi2nfBmEvXsN+EGcJHkYYAmdEEXQied9j1kcQjTj59NpE/KCssL2czvwvBNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14oAf5A0EYNmXltDJ7ufxtxGt2aefGtNtiiSPgLMGRA=;
 b=rB+uwse/1YfpOgN1UQRgAP/GF5yzmrVLWa9TzZjZV5jRXbKE5H1C88Sm5obvI1aAfNSIqkYqYxqUFSNSVlk1A99e6KKI8hoMoC6VSuIAick6KsBkU6ISnsXDPbh0uRWLAwHAbA158X35Ck03rzNzOLaarhZ0MhWHeyRIfWkPZkg=
Received: from PH8P221CA0009.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::12)
 by PH8PR12MB7254.namprd12.prod.outlook.com (2603:10b6:510:225::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Fri, 16 May
 2025 10:07:45 +0000
Received: from BY1PEPF0001AE1A.namprd04.prod.outlook.com
 (2603:10b6:510:2d8:cafe::c6) by PH8P221CA0009.outlook.office365.com
 (2603:10b6:510:2d8::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.20 via Frontend Transport; Fri,
 16 May 2025 10:07:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BY1PEPF0001AE1A.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Fri, 16 May 2025 10:07:45 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 16 May
 2025 05:07:41 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <pbonzini@redhat.com>,
 <richard.henderson@linaro.org>, <eduardo@habkost.net>,
 <suravee.suthikulpanit@amd.com>, <alejandro.j.jimenez@oracle.com>,
 <joao.m.martins@oracle.com>, <sarunkod@amd.com>, Vasant Hegde
 <vasant.hegde@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: [PATCH v3 2/2] hw/i386/amd_iommu: Fix xtsup when vcpus < 255
Date: Fri, 16 May 2025 15:35:35 +0530
Message-ID: <20250516100535.4980-3-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250516100535.4980-1-sarunkod@amd.com>
References: <20250516100535.4980-1-sarunkod@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1A:EE_|PH8PR12MB7254:EE_
X-MS-Office365-Filtering-Correlation-Id: c2138177-99ba-4c79-ead7-08dd946180ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VFFDdGdEU0hmSkVnTDFFYzFUR1FQbUl2OWNRdUhLenBxS21PSUg2ei9pbUsw?=
 =?utf-8?B?MGJHTVVxcXEwRFA3RG1qQXIxQUkzWCt4QXdJOG9MWXVFQXpPaGlqK3lzdzEz?=
 =?utf-8?B?L3djNkY4NkNuaDljYzBEZHdkM3FhWXlPN0JINE4vRUxoUGpISHZKdzVsWUlq?=
 =?utf-8?B?RW1MZ21uZkpRL1dESEtsa1FJcXNzY3AxRm1YOGdTbW0weFZWTUJvTmFxY2JL?=
 =?utf-8?B?L3ZwTnBCMXFCbVFRS0FSRUlBZjZ0ZWlUTW04VUh0VE9IdWVhZUJDNGtOYVpx?=
 =?utf-8?B?MUFVbFptSWxyUVFqbjVianlKZnlIeExRc0RlZEg2VFd4OThzS1poYURSTUZp?=
 =?utf-8?B?ZDh0T1BqYU40WjV6SkZaWGZPbnd1Y1Y0MTNWZnlESzdiZk82MEJXcjJNY2VP?=
 =?utf-8?B?cjVEdWZBaVFmUDZJWVdnQkFkNWlaT1R2Vm1PWEowY3ZPN2QvTnFZcmhxRFNJ?=
 =?utf-8?B?Q090SUk1a2x3YiszcEd2R2wyUUMrV0NvTXVyUVdmdm53dldNbFRabGVkYmtD?=
 =?utf-8?B?T0tiRVdoTVVBR096ODVwLzRXY1VqTE5IWmVzN3hGUG1hRWJ5ZHdCNzRXdDFW?=
 =?utf-8?B?RjJXVEI2TkErK0xuTjNIczhuZlpISjg5Zjk2R3QzdVpwRWh1cXJLRTlCRVBD?=
 =?utf-8?B?RUE3bmtDV2NkSzBMRVlJNHQ3N1lxTTZ6NGkvemRiaEN1aGFOTzhZV0VkSXc4?=
 =?utf-8?B?UnFUVk5PWTlOVHpheUZ1bmo4bnpmRlNja0x5TG52Z095RE1RL2xYUDJSZDcw?=
 =?utf-8?B?SWc1czduRFozV2ZuUWgrelAvZGw2dkNWcjlnSnJVdjhCOUp2NEJkNXhUbDVN?=
 =?utf-8?B?MXBER2lHWm5RdkNVMjNJbmtCOXJLWGpuK1dqTGdnZUpIWkxOUjZ2bklLSWky?=
 =?utf-8?B?ejJnZ1pOMEc0SGVxZUZqcXVqcVNiV010NDVTeHRHMVlKQ0RGVlJQUWxESlVN?=
 =?utf-8?B?RzJuTEpLSXE3ZkxnUk1lMnpBdkdBUDcwTXR5SWw0Wm9wUWVUNlh5WEVxM216?=
 =?utf-8?B?MDNKMDhrb2pNYTBYWlJ2QVhCa1p6TWhVU25PZzNqVDdUd1YycDFqcXBoYThP?=
 =?utf-8?B?emxJVTRNQzBUSGRlNEo3ZDBiV2V6djJmZ21Pd3ZJZEZHc3dNSHpTWStuR3dY?=
 =?utf-8?B?QnBhTVYxUE9USHExZG15Ny9UbGpTdk00S2Q0RXAzZDljZlZOSjhRL3lFNVdp?=
 =?utf-8?B?cDhyck9wMENsQ1hwWVFmdjJPRFVtbHR6RmhaZkU0SXdMdVN1ajhOWjJFcGo4?=
 =?utf-8?B?d1RyRXRFbkFtN3I1OTZuamhJd0grU3NjVE55NTEzcjJoNkdHSnluU1dGRU4z?=
 =?utf-8?B?Z1JFZ3BOSzNVcmJHUUh4S2pFR0E0eW9mdkJzL1N3TmE0UG12RHBQRjZnZ1dv?=
 =?utf-8?B?VjZ1M0VFS1J1ZzEwMHdzblJSbmh5MmRIaVZIL0JZSWNiTExMelA2R0Z2S2x4?=
 =?utf-8?B?R0VrZ2c5cUphb0ZpYUZyQ2Y0N3N2MFFzS1oxb0FpTUp0a2I0cVhYdXdlT1c3?=
 =?utf-8?B?cjlkUHh2RTR0SkRSdGI2UGVIYjBiYnlGeXUycVVRNnBGQm5pdXYrY2hYWW8x?=
 =?utf-8?B?Rmc1MEk4emU1WXY3QTFqdmtIOTZkc3lGbXJNai9OQlVJUDJma3RncVdmL042?=
 =?utf-8?B?ZDhod0tudDVhM015d0N1TDdSKzd2VURRMWhKZ1puK2VVVmRweTRUb2NxaTNB?=
 =?utf-8?B?QStwYW03M0lJK1ZDbW45czlCSHhjQnRvR1pRTUU0RmVNdzBlYWdRZCs2cWNu?=
 =?utf-8?B?K2hOR2hST1VLc3FRc1lFcFhFeHNqQTd4dENuWnZZckI4ckpNbVZwcWw1MzJZ?=
 =?utf-8?B?Y2d6NWNrNzgyWFQxUzFHVDdXZitneElLY2h5TFJNYW5qVTVNRlJGYTNOd09B?=
 =?utf-8?B?bi8zZDBMaTduSThNbks0SHNiNi9aQzdiaUo0VXdiaExtMHF5NVdhTGZVNDdt?=
 =?utf-8?B?WnJCNUVNbEhZbm41TFpPVzV3Sit5STdrM2x0cUJnTE9Gb2pGbTlzY1BHRkJa?=
 =?utf-8?B?WVAvUXNlVkhoRW44RmRLZkwwR2xlRWpwY2ltRGx0cEZqQWVuVGI5QjFOZXY5?=
 =?utf-8?Q?RHkSEX?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 10:07:45.0985 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2138177-99ba-4c79-ead7-08dd946180ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7254
Received-SPF: permerror client-ip=2a01:111:f403:2418::620;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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
But if vCPUs <= 255 then the common code won't calls kvm_enable_x2apic().

This is because commit 8c6619f3e692 ("hw/i386/amd_iommu: Simplify non-KVM
checks on XTSup feature") removed the call to kvm_enable_x2apic when xtsup
is "on", which break things when guest is booted with x2apic mode and
there are <= 255 vCPUs.

Fix this by adding back kvm_enable_x2apic() call when xtsup=on.

Fixes: 8c6619f3e692 ("hw/i386/amd_iommu: Simplify non-KVM checks on XTSup feature")
Reported-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Tested-by: Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
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


