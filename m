Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD28FCD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 13:41:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMPwy-0003Qx-I6; Mon, 11 May 2026 08:41:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1wMPwu-0003QR-E1
 for qemu-devel@nongnu.org; Mon, 11 May 2026 08:41:28 -0400
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1wMPwq-000438-Jg
 for qemu-devel@nongnu.org; Mon, 11 May 2026 08:41:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z3wnbFtw2kmLgUl2TDCu4evPnHZeydZOr5UI/pYIVyEz72s2fGzH4zUAMdUVnb5PK2uzICdZLPyWVTj1lryPIwiedabUuel6AlUW7iCvL9Cbkx5Bs3RuRGdbkcC6E5Jhttzm7eaqGPdQzowGfQicxUrpmiaca7hfQavycaSAjm3+iRAKaZxDBIvJ3c7jO+FlJ9Q70tOjyHtrXm5bX5F5YEOfbfbHMLyfaObADINqbwrMPRcrX61uKNWnvWVHwXfp4aeUchpHI97p1yta3jhtkgUUO37y5qceKu+//5lINNBW12v+G+nd6qR3wLslqbmkPEwSitrGCt+hAUGRzLSRvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8J69IbyPjeICFA8KHaNvJcfrL1i0xk3/b2Ykh0q9Hjo=;
 b=NHwZMXcGUihYY9V9Gcn8RqD4uzs3DE7iSFCvCVUhmrDVsWi40OZKFR6FxwGMm1cdlH/UIaBpDRXI4iuEx+iK6EAwJGZHfAbCGV9cMMtY8VsnYD/iFDAhrnZKzAd2F2GLaoSN9Oj9k2OhZuxK4p7Msl39h9OsUlFwQBfXTToIn2knrO3NyGr1xWL4c0WU1UUP5wPhuCwvqS7msvTRhJxRRQw6tpf09cHOT+8b2YRSXWCCVuJ4M97cFi8y13I2jdDIdOTUIjtrPXBFKbikJpfMHksuDVJmOnezPIXe8qKrFxyRRhN4GMx6fscY50vJdbtNH5e1G8O2vx2LuTSgXYpccg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8J69IbyPjeICFA8KHaNvJcfrL1i0xk3/b2Ykh0q9Hjo=;
 b=rr1cr7LV96I0+DODcnFoYGCc60xewBPxfeiD50DkppGLzEoTecE5ri38m9/3BGUnCL9wlk090xTU09EPdP7MuLQnO5/XjTsd7Er2AFU59NFQRAFP/hRQozDYIJwLBW54TtK2kpIEm5vaRlppcjluOfaoDFPT5JS/zPsrDMKIZtc=
Received: from SA0PR11CA0103.namprd11.prod.outlook.com (2603:10b6:806:d1::18)
 by SN7PR12MB7346.namprd12.prod.outlook.com (2603:10b6:806:299::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 12:41:16 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:806:d1:cafe::2) by SA0PR11CA0103.outlook.office365.com
 (2603:10b6:806:d1::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 12:41:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 12:41:15 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 11 May
 2026 07:41:11 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Alejandro Jimenez
 <alejandro.j.jimenez@oracle.com>, Ani Sinha <anisinha@redhat.com>, "Eduardo
 Habkost" <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, Sairaj Kodilkar
 <sarunkod@amd.com>, <qemu-devel@nongnu.org>
CC: <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>
Subject: [PATCH 2/8] amd_iommu: update PA, GVA and VA size macros
Date: Mon, 11 May 2026 18:09:31 +0530
Message-ID: <20260511123937.32743-3-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260511123937.32743-1-sarunkod@amd.com>
References: <20260511123937.32743-1-sarunkod@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|SN7PR12MB7346:EE_
X-MS-Office365-Filtering-Correlation-Id: 827db31f-3784-4e90-d933-08deaf5a9776
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|921020|11063799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: OK57r2m225Ec/olBBmP5c2+8g0uSUWlSsXyVOeTtHpaPZO1bEP15sgEI5y7RxV3Ta/Zmnrk66ZjEveglPjK5pYPy5Hh1Sr8sJoDJfrXVu03n+OX9z02XJhRqvkYh8c6LBO+3m0+OS4Sk9PqYgvxAmTUtP5o38bBlu6MWmRaoFhwLzhjOnvBl6oOCqGRP/7gf0KtlVeoItPGJEwsoTO4HMoqGAcII4oQjaqNQ5gXvnDxaeF1v9qK0mH9PATjRyJ4CAXK/ignHAV2m9UwhXEfD1tNQTk29FzCXmh3Y8/nn440rY6K+K/76QrXHdYFip3AviF9YhDKBBUwUehHyj/StOBEqkxuHU7F2BEcQXaidyHuaRYVOiN7295cZslyFsZ+CdzuO/UKzFuzjdKDctNvGcFKDhfAdSbwA0Ti9bGvFN/NrIr8+N1OgJO9M6htKnpNoFmk4zFyH+FgldzaV4ncUmgLiN4rYAkayPI1kUsKYizXa4YMS1dLEWvVgOhIiZLjmeVIWuZHIPv8OeMQysi+5mwLoSWQZne0c8+hU0DlhdEhiLs8R+lFUKBKdAmlrDr4CSgsygyhYL/B4TpoF3Si0DvE2MR2ecdFcFRhYKn9+vaKbVpG/GX618wXerIxO2H27cQ0v6HkTwGuMoQNhMWfbXX6yv4Hx6rB1C8DA0ibg0FZ+VQL/bEwKk++diPQd0BnealuyyrjZF/0FuJQl/Jf5zHVGc8OO2k7MyUj6JmP51w1PnMikBjRlgULasIhpn5j+qxO8Sg8PybKesjaUp+0NLQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(921020)(11063799003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: O805dEtN/aW77VO6V2ICj2ntvpdr+jQKZBg9R3cmKZHjjyyw763SGlbRZfp9XINBjeTaSv/pPl6+cYeYW17nLnDdB4gKA9x70iKYMLoC4baTlM3rn4qOJXosH/v3X4JIRvUnnOlsxD3xBwx4BWXxdHPtYDSEqDLEp7FcD4vac6kODv0Njmy2MLqJ4XFTplV4z42phxmz1c5gNDldvK7CfymvcpRGrf7p1JS7k1uMQaFGBqXMwNclBciv+PdGQBadjvdFZXKZvmyaZs4sDZLNSTboOwYNd8G0NX0RzzxFpB0YJoRTf0Dg4eMJmDtF92TT/9qIbH58RLpkS1im8VOdluRC16fPn5VBPGgWrpxb8IxEa4rZq1kJgyv2w6iUjRwufKj8yBrscZCAX2h11m4zBgiJzRCpudgG//iDL+GDqt1AfcNc/S7K5q1aV7C9fQfc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 12:41:15.5654 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 827db31f-3784-4e90-d933-08deaf5a9776
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7346
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=Sairaj.K@amd.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Current implemenation supports upto 64 bit IOVA and upto 52 bit PA.
Modify related macros so that guest can see right size.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 hw/i386/acpi-build.c | 2 +-
 hw/i386/amd_iommu.c  | 2 +-
 hw/i386/amd_iommu.h  | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 9446a9f862ca..e4ad01eec037 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1763,7 +1763,7 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
      */
     build_append_int_noprefix(table_data,
                              (1UL << 0) | /* EFRSup */
-                             (40UL << 8), /* PASize */
+                             AMDVI_PA_SIZE_52,
                              4);
     /* reserved */
     build_append_int_noprefix(table_data, 0, 8);
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 789e09d6f2bc..7c52f9ade6e6 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -2450,7 +2450,7 @@ static void amdvi_pci_realize(PCIDevice *pdev, Error **errp)
                  0xff000000);
     pci_set_long(pdev->config + s->capab_offset + AMDVI_CAPAB_MISC, 0);
     pci_set_long(pdev->config + s->capab_offset + AMDVI_CAPAB_MISC,
-            AMDVI_MAX_PH_ADDR | AMDVI_MAX_GVA_ADDR | AMDVI_MAX_VA_ADDR);
+            AMDVI_PA_SIZE_52 | AMDVI_GVA_SIZE_48 | AMDVI_VA_SIZE_64);
 }
 
 static void amdvi_sysbus_reset(DeviceState *dev)
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 302ccca5121f..fe8f4a6cdc74 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -245,9 +245,9 @@
 #define AMDVI_PAGE_SHIFT_4K 12
 #define AMDVI_PAGE_MASK_4K      GENMASK64(63, 12)
 
-#define AMDVI_MAX_GVA_ADDR      (2UL << 5)
-#define AMDVI_MAX_PH_ADDR       (40UL << 8)
-#define AMDVI_MAX_VA_ADDR       (48UL << 15)
+#define AMDVI_GVA_SIZE_48       (2UL << 5)
+#define AMDVI_PA_SIZE_52        (52UL << 8)
+#define AMDVI_VA_SIZE_64        (64UL << 15)
 
 /* Completion Wait data size */
 #define AMDVI_COMPLETION_DATA_SIZE    8
-- 
2.34.1


