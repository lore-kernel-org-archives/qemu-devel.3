Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D089ACD4F57
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 10:41:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPHsA-0001mr-HF; Tue, 19 May 2026 06:40:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHrd-0000yU-RK; Tue, 19 May 2026 06:39:55 -0400
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHrb-0006Xl-I8; Tue, 19 May 2026 06:39:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QcLaML0SuSTPr4z+7TOSFXb3IibRtQ/N3ZW+mFxGebxF7zVdGBD5a3S+X9AjAp0zxd9eTnQJSMXXKTZYuE7dXNG1g5fmVSGZfL1tXjHI4B1gyFIy3oDlsygL9RSrfBTG6y6xj6a5KfkeC4Vc2/pHo1IDExSACTZiHtNw0ys7j/hUkeskp2DjJkAaCov4wR7gu8SjOrhkk+muCMgtBObjpd3/gOZs2yiZmLE7oQ4qeYCevBdpikSmLxQIkVfU7eSL4eD/XgY/nY4DoU+/xcbJFAxQKwkIdm8HEjlOnTZrgMaoioLEGmIOnUnKnPQ3vnJzyrPXerdMl0BtJgd1E+WL8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Va96SirhYRknJ1P+tBvn4cGX70lMspwMPqcIzl+VFQ=;
 b=Mhfw70ZDlq58I6Xt9R8vjvQjnKIhE9/tjuc6W8K0NZHe77JyHa75RpkRQdaWDqNYDgVXv5a9uEPdmwt+puofQyh7yTeOQbsR6E3wzjKYLSr2WKrtSyvRfbE0J1Q9fZIMl/Mu76xz0iDvIKyRYyze5DhZ/A+02a00bo9vEj5fX3NuuEzLoWL/HvBmdHL8UopQHniEaO1jC9VKNcx3nmyIyNmy6txrQVrJGfVo0WFAJVIkYfaPiJU2Pjo5l0eHTVSwKidwJws6Vbd4UVNNE+X+XZEikD1ojrvWWhut/0LkZj8oEuhyjqywxU50wMUX1XHvMn150wsfujCTMB2JstP87w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Va96SirhYRknJ1P+tBvn4cGX70lMspwMPqcIzl+VFQ=;
 b=FBxjHi9OR5WgC0i/k7cJBZmgNtWjmzcBDm3JKIbDPn920yy9GxOrXTLcfImij4FB6OKjwe2T7X5P37yF5dzDaFQzXMYlGFjN4ggDUH1x6Co/1H5AXoJHbS+Y7HYlP+Chee5KshVyl3UeR+qeAqOLyf0qeTAqpbx5lPopP+tgvbwDj1yJEUqXi9IqKislnfB87XTRSIEMqcRL/d+dARl2COkGL/P+dHy7+R8ux9izSiK/eGYGqVqwxVybJZlRj3pFxza6wyTxsZCZOie3Sz4n3nbkuOJHzCMkrDWX2NR8oTQOtMT/VnnTyA/T1hThs5oOsaexyaoanfYaOEM77apKhQ==
Received: from BL1P222CA0005.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::10)
 by DM4PR12MB7717.namprd12.prod.outlook.com (2603:10b6:8:103::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 10:39:43 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:2c7:cafe::d0) by BL1P222CA0005.outlook.office365.com
 (2603:10b6:208:2c7::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.23 via Frontend Transport; Tue, 19
 May 2026 10:39:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 10:39:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:39:27 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:39:24 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v5 18/32] system/physmem: Add address_space_range_is_ram()
 helper
Date: Tue, 19 May 2026 11:36:56 +0100
Message-ID: <20260519103727.899332-19-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519103727.899332-1-skolothumtho@nvidia.com>
References: <20260519103727.899332-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|DM4PR12MB7717:EE_
X-MS-Office365-Filtering-Correlation-Id: 697e067b-6a4a-414e-2161-08deb592efed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|11063799006|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: ERH5Jp+udi77AN93bZdAVxY0U3mAACUR3iuyYEJJsniI5LWvlg5bv+WEywdi8yp0wJ6Qjt4yYqu22Qe4JmWBFrKNKyPqSWe2y6acZSHMoso4RwKSBM3Temgp2Dhvv63vhRhVqRBu3QdHW9ATyurCSaR2rJ3000GV3MqcJhC3JcH3fsgduYG06vi1KmPQPwR8mPCHFLRr3aYTjNmuKD5sKXvLaCWnTfyADhWBloKtVuCKv0M2+e+j8QNItsbrKoEbPaTW9FQ/6+sExRiwpSBsxsg/QgudjxultwWds+dXam0MpyDPNlFwCcl7BDQr7FlYkb+Os7f8x1RIU4ZnwTUa/09QJps8kD/Ig3yWtZVkmZ9b3z2YiOHm38zhRyOYSPqEkCAHRum6Xx9fJ9fvvqf8kgszOlyJrP6YQVHHs5t4XWUnLAnm1I4y/6IYX32rBugpCI4IQcUrcsc2z8E1DZqNVYlk4dScN63PIn7jqctVJY7DolcQgrVUgofq8W+Oy9PqWJaH8AldTB1O2j4U5WanmrmalA20h5CGvVuDNj8XK+da/6qsO45cbC+rTnQcdSwmWntRDfnnPwnjEQ65iB0eYq0vc4asUmFYQhn5SlbZ8RLzI2XPybmZSyB2vst9BKgmCIvz2jfalN1d2qUi7qfY4cGMY3U+mB+6j93C6SST+wtfRfkVJZ0A1nj4HEGh+UlLbnl12jz/yLQVoL072v9lazCvW8jVeMhxkbqmfTYYpeY=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(11063799006)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VQhOZmUd1aZUNN7LvZ8hnKjUEgY6BlWn8CZkFWvxZtKSUOUNCRBXn3E8yhoPcj6umxLdE9TSMMK+EU/h6aGrLAqzukqDf6bEtH6vIeKdpXg1sm/RxpyN0XwCu7sl7ZVe1rypP46p8Jl3lMO+Vj02pKccD/BKfEDmGOemn3qOZhQjgYpzNNYqa5Yw3hjYG4fUzRlAj1g6h2dNM6+ynHGEF1LzuS0CsdJjwcJH1FW64wwDZky8NXbZmHnihCHboDAq+En/jdHYXQUg3/F4z8EmX2TEF2n/VHJYpg9XbWF8SqUx7AdDI9CL7yo2M7C946asadpqF1DVxBY+fzNlZpPKYNZjLhANefxnGIFkcr5BOtSzgW8Fop86bq+nNMunNavco87ijI6+9+rvRb20uot2IIRYX7VKOQ2DHkYHAH1UY8OubLVDuHobUaBE6e4RDOKW
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 10:39:42.6487 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 697e067b-6a4a-414e-2161-08deb592efed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7717
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Introduce address_space_range_is_ram(), a helper to determine whether a
guest physical address range within an AddressSpace resolves entirely
to RAM-backed MemoryRegions. The range is walked using
address_space_translate() so contiguous RAM-only ranges return true
even when they cross multiple MemoryRegion boundaries; any byte
backed by non-RAM (MMIO, ROM device, hole) returns false.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 include/system/memory.h | 13 +++++++++++++
 system/physmem.c        | 19 +++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/system/memory.h b/include/system/memory.h
index 1417132f6d..af5f96f6ff 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -2841,6 +2841,19 @@ bool address_space_access_valid(AddressSpace *as, hwaddr addr, hwaddr len,
  */
 bool address_space_is_io(AddressSpace *as, hwaddr addr);
 
+/**
+ * address_space_range_is_ram: check whether a guest physical address range
+ *                             within an address space resolves entirely to RAM.
+ *
+ * @as: #AddressSpace to be accessed
+ * @addr: address within that address space
+ * @size: number of bytes in the range starting at @addr
+ *
+ * Returns true if every byte in [@addr, @addr + @size) maps to a RAM
+ * MemoryRegion, false otherwise.
+ */
+bool address_space_range_is_ram(AddressSpace *as, hwaddr addr, hwaddr size);
+
 /* address_space_map: map a physical memory region into a host virtual address
  *
  * May map a subset of the requested range, given by and returned in @plen.
diff --git a/system/physmem.c b/system/physmem.c
index 7bcbf87573..46b36c7b10 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3668,6 +3668,25 @@ bool address_space_is_io(AddressSpace *as, hwaddr addr)
     return !(memory_region_is_ram(mr) || memory_region_is_romd(mr));
 }
 
+bool address_space_range_is_ram(AddressSpace *as, hwaddr addr, hwaddr size)
+{
+    MemoryRegion *mr;
+    hwaddr xlat, l;
+
+    RCU_READ_LOCK_GUARD();
+    while (size > 0) {
+        l = size;
+        mr = address_space_translate(as, addr, &xlat, &l, false,
+                                     MEMTXATTRS_UNSPECIFIED);
+        if (!memory_region_is_ram(mr)) {
+            return false;
+        }
+        size -= l;
+        addr += l;
+    }
+    return true;
+}
+
 static hwaddr
 flatview_extend_translation(FlatView *fv, hwaddr addr,
                             hwaddr target_len,
-- 
2.43.0


