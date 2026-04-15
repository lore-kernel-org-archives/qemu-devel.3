Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0882F41990
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 11:02:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCxx5-0002Qf-7t; Wed, 15 Apr 2026 06:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCxwn-0001dT-Vf; Wed, 15 Apr 2026 06:58:19 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCxwd-00048f-4I; Wed, 15 Apr 2026 06:58:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QK8cuxdH+IkE/gYsxRbH8sOszCsKGJPLypgwmuRP38vJatUe7Oum7Svqm6LjuicbMGY5CA33zq/iG4ILAiFNw/lSS7ysbkVQ6cw6YFklQ/tPg9up97jFHSrrD1WZ5j/pgIDwhSVE8Pa0K1iJuIJHx+nXxfKCIzBK27ij0EEv4dJMEcYh06wWamgVnusNr0wVguKlpAj28pIhyQCgp6F6bw72raEjSp0SEtuhlgU98GPJuyA1ZoYyzGHgadTy0lrcrUzuxJd4pb59n1ZAHG8UqubZmCCQtiseUdPrfluouqo4cffWxDyl+C7LNoqbpA3bFkv/i5LcS9Meyzx+nbw1NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6r+Hdh0UaXe6geJ9NxCVfX1LSSSfCPXuwn11Jr7Pbqg=;
 b=cAg5MCmy9oAT+X4eYKP4SVgYzemkvcyJhXKH+M4o1qiWwt3ND0g9IsdmRdSqzEWLchgPfBMItQeGh9VWLbMzApBxpdz9qBYzI1UQDLwuq8dzbiPfBbQv87YxKue1nZSEf9v8pJbZBW9n9DKD6rGQf1hK2iyVaPVpRHGLplXdPV68sxVX02Z8pgU+2vYAkDNmUGXrwXnjJc8x7UqPnv9OWihps8zkJCws1mZvKPHzJ3hf7gnYNytGMxmZKq0JLDcchsjSnsq6sWBj7Mv0CJ0m4rCjMwwAbLmquVeqtZ3Yleb0EHzSq31nLMn66hp1yCzVQQhnqfuZZXTbRfBPA5eqxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6r+Hdh0UaXe6geJ9NxCVfX1LSSSfCPXuwn11Jr7Pbqg=;
 b=UXtcje6cdSdMKCapTDXV/+qRzfUioiKWONtj+/Vu3ku7WvVYYGw8zBGmN2ZrUcn8Artb8lZxOLwrdckCJO2XWnRduP7+/zGZr+lM9D1U9i/lzayzensQYu027+tysWwtCqkCEIeHex3b5zId9cKbpPa6rjZQ3xniOUn6ijHgGnI+9wepn+0SmUzX4b6qjk+WPJThaNa3hBsS/44N7MCm9SUWDZviRk+Pc97z9h5U423lXmq+4aEd2otCb+74f+9ptouuqwcUHLEHtNv4YjHjWnLU0II9oQjrSZMjZD1WkgRZFYwuyVsGDNjAvc6Mr6ym7QNh8PafCU/PpOtuHNjszw==
Received: from CY5PR15CA0211.namprd15.prod.outlook.com (2603:10b6:930:88::13)
 by DS5PPF7B9F1F8E0.namprd12.prod.outlook.com (2603:10b6:f:fc00::656)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Wed, 15 Apr
 2026 10:57:58 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:930:88:cafe::5e) by CY5PR15CA0211.outlook.office365.com
 (2603:10b6:930:88::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.49 via Frontend Transport; Wed,
 15 Apr 2026 10:57:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 10:57:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 03:57:41 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 03:57:37 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhenzhong.duan@intel.com>,
 <kjaju@nvidia.com>, <phrdina@redhat.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v4 18/31] system/physmem: Add address_space_is_ram() helper
Date: Wed, 15 Apr 2026 11:55:39 +0100
Message-ID: <20260415105552.622421-19-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415105552.622421-1-skolothumtho@nvidia.com>
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|DS5PPF7B9F1F8E0:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fb12066-3c82-4ac7-0711-08de9adddb02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: Wm6U8FdWC39hPTNnPK2dCKIvHwv/rHSAd39dawRvC30WfJMxTtIZkvdr0sHl98d3p41J2/C+s/HvqhI7Ur+d1EN8uRYg0W4wtjNmY0t+TfC/UgWAtkRnnmaYuw1QRKOqn3vSse3wH9gp9qo9aHRwBKMGdFM3Tko7A1m/Bwv5ebq3IAiPblfz2/b5v54i8omoDYpb06/4AxS1eFFpzlfGJ4tOjbf6LBv18mY6fGbHa6Ap+jra4Oyl7cTsf7zGIOAbxX8SJkAaLzLu/vJbkq6pAnHn6BmdiyziM82952el27S9jn3ud6aYMR8cqb8zocbRgQMAihLd2wXAFqrf4e6KUZ7A/CFI57HiQT0NYf2gY0MzCPFtDHlQIZykMcIlTyv9orchFZUae1n61sohSijOtWNPhp6yUn/Bcv+vsst3e6pl+QQxLimUAnE1+ItEJI33IBjBLVTyG+rCd2ewu///pVDZdquMcM1OLKhbRiaJXlGXkjW1C2uGt2HD8KiN+L3uWyBvxXV98ou/bmtT3HXgULhc6gsdthypG0QwDoVVCGL0VGunU8H7pKr34zIZfWpixibWqvq0S9jYexJ+W3Au1Pvlr3aSkF5UDcmwWz6WaOumum1NbydGHQZj9d5dwl1Z3O99l1TKNuzCw0gqDiqBcanpmwblPcz78Nmchh9sQbGiapg1KzJBfNpX++ttCWmM8CkoVAZJ0SaiZWrj9godLO93XEHCV1WYsnG9RbIwYyn7s+ISC8iJ0E+yjLAfXauX+iQrXJV33nx3qSuZM1Y5UA==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GI02E5FWexukPUwWccm/3NgMYjJKSDfgIl0k5W6zBgzmL1Zy7YDOlHPS37yYtJy+WBx+KfPS87lToOSctfXIasVnOr/40P/eJ4pIl+PrD1JQnCW5rS3G4PdenRZAgaasaYWXvlVZa1ZqAMHzFym1/UBOenOsNGLqjZigV7SJLgUpfBKnTgoHtJNHCaWjsZtqGI0XfGi8Y7/kKo0rNYrTE+wo0iT7CDAU3rLftT6dlUZrHutDV4Pq0yzgUoAAw7qNiGPjkChER4RVJjXfcFLaBHM7xydr3ujCH++s3IzmTIaXfUSqFSPH9CyGdeCBYAzIJrwZ7Y3Q1g30IM+OxTJbCk/HQH17WNS/+xK/zj03BDNsAtJEB57/wTDULVTMyzXR0hm072eWaMd6RVbmQGZ1OOyiuPOz8QbXNxaar1AldqFFrjATMApO7J2lUyW89By+
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 10:57:58.4606 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fb12066-3c82-4ac7-0711-08de9adddb02
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF7B9F1F8E0
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Introduce address_space_is_ram(), a helper to determine whether
a guest physical address resolves to a RAM-backed MemoryRegion within
an AddressSpace.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 include/system/memory.h | 10 ++++++++++
 system/physmem.c        | 11 +++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/system/memory.h b/include/system/memory.h
index d7b18b632d..7aed255e81 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -2841,6 +2841,16 @@ bool address_space_access_valid(AddressSpace *as, hwaddr addr, hwaddr len,
  */
 bool address_space_is_io(AddressSpace *as, hwaddr addr);
 
+/**
+ * address_space_is_ram: check whether a guest physical address whithin
+ *                       an address space is RAM.
+ *
+ * @as: #AddressSpace to be accessed
+ * @addr: address within that address space
+ */
+
+bool address_space_is_ram(AddressSpace *as, hwaddr addr);
+
 /* address_space_map: map a physical memory region into a host virtual address
  *
  * May map a subset of the requested range, given by and returned in @plen.
diff --git a/system/physmem.c b/system/physmem.c
index 4e26f1a1d4..b67dde80fb 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3674,6 +3674,17 @@ bool address_space_is_io(AddressSpace *as, hwaddr addr)
     return !(memory_region_is_ram(mr) || memory_region_is_romd(mr));
 }
 
+bool address_space_is_ram(AddressSpace *as, hwaddr addr)
+{
+    MemoryRegion *mr;
+
+    RCU_READ_LOCK_GUARD();
+    mr = address_space_translate(as, addr, &addr, NULL, false,
+                                 MEMTXATTRS_UNSPECIFIED);
+
+    return memory_region_is_ram(mr);
+}
+
 static hwaddr
 flatview_extend_translation(FlatView *fv, hwaddr addr,
                             hwaddr target_len,
-- 
2.43.0


