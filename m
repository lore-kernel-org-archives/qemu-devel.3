Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94281D4695D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 18:04:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vicWM-0004wA-5Z; Wed, 21 Jan 2026 13:01:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicTs-0000ZT-IX; Wed, 21 Jan 2026 12:59:03 -0500
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicTe-0002ED-Gg; Wed, 21 Jan 2026 12:58:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pGwqzeFnTDtNCBtC3hsO0FeQ9w+CU7jQ0rqL8b9v2sBr+8HV6dk7GvH5sb1iKOtei5eeIt/PFyQTsxGKawM5HUpuuSsgyiK2ljLGA83wTxsGjYVorfb9Rn5iDUiFtpE+1uH994UCcmm69Q/pbkXxOQMmE4t+VooXlynRSrhm18hwfmg7+V3+Xh1r8YOwGbab4vvXqJIMTaz/FH6KaVKoY4VQjlxTei4lPBGFoQ/1BIWcOJipDNCtRTpIGYTPAEKvqRX+vIizXbzfbkKOazqAenaBvSFv2Knfw/cFfh7NKC7A9N+cizyuMYVjI3z0e+4S9rTgvKsMJvBRBRYFrpM/Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWyhHmUSGZz93ubb2peZoDpZOsqkNsnmHHR+RREFlcE=;
 b=qXcHENG/midbSJSB9n/SiSP54Jzf//686g+5LvgRWhI8gXMV+3Wu008+OISKhOGOygCLCX58OoONJ0p9hDxjSFBoIAiEMhoFZDLJfXEY1+LS41WcsziNKsrS7aARsdodHAwPV+2Cmcgo485dWKLcl8h6UYzmZFZ9U+G6YR46SMLEu8ns3U0PpedDk7MTivcK+n6fGhR6gySXNFUeHUwn2/79tCiBNiG0wnVIqVZdexDvyfl+ZKHXONOtz5EWt2NGzvgZ95L1bGBEN38Tc/OE9PUfDr9wxpwF1pE7IJoq2itlEdmlA1CBibJHW/LL4uOyeGO6LrpzDbQG4s6cvX05pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWyhHmUSGZz93ubb2peZoDpZOsqkNsnmHHR+RREFlcE=;
 b=MMT4sqIVjQwa1lrefRIcE3AU07XcxoswcKW9rVR2VzrvhLmN9WhCu1AjtApAPw6wqMt25r2etG+EY+TNZpkf2JkUtAGsfYe/nyIrobFKT8SaB99CoxiAobHe0kcLKoin+EnWGMvGhwADPK4ACuhnxEyMCBLfiJxTBB8rMaxoNSv+UPZvyAOsAa02pNwA5KouJXZuuoQ9CoAJBmOCD7lqrp76/kI1bIcKmk628pQm/d2QP2FOjVLV/DCzwSF/YQcJ3dcnFglytJlNot+wSOIiiqsGYqlL4rQlrMWb7YzFHy6tVV1m5bx1pZQ9+b7wV9ppVRLqUT1ukxTVFp59/PMnOQ==
Received: from BN9P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::14)
 by CY1PR12MB9676.namprd12.prod.outlook.com (2603:10b6:930:104::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 17:58:32 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:408:13e:cafe::23) by BN9P220CA0009.outlook.office365.com
 (2603:10b6:408:13e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 17:58:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 17:58:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:58:06 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:58:01 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>, "Michael S . Tsirkin"
 <mst@redhat.com>
Subject: [PATCH v8 34/37] hw/pci: Add helper to insert PCIe extended
 capability at a fixed offset
Date: Wed, 21 Jan 2026 17:52:39 +0000
Message-ID: <20260121175248.87649-35-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260121175248.87649-1-skolothumtho@nvidia.com>
References: <20260121175248.87649-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|CY1PR12MB9676:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f013e17-d62e-4122-e6c2-08de5916b102
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013|7416014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yLqvYh/L/nZ9B232Pub3zxhT50Z04kt0sBY0Vkf2JrGBTOXKnc5DaFKvNHXb?=
 =?us-ascii?Q?zHfv4NfdeDiCHgvme06ArH57zld6JLU69ph30aLFU1UOawHyBiYvzRVtePOp?=
 =?us-ascii?Q?krwGrvOPdhQw9mHCnhWgZS5qjUma9+UduVDzxkd+8TRCD0bnoQUVufzYmeY8?=
 =?us-ascii?Q?C3cENoHIDovAbpNDpGNvkAl2jj2cW7qurIXF6nSJGcTRwAf2GSBQ09l4tebw?=
 =?us-ascii?Q?8JNR/+Pn3Cf7flq+G3i5FnQJMXRXnmiWyq4IoLxU1saayooqw4G/hskQMwLF?=
 =?us-ascii?Q?MtNtd7TIAiiCKhWJfUl5RMazfuuAe+qfUaU32I0KDI8k1cj/bmnc+xoHqETE?=
 =?us-ascii?Q?1WsT6qYYBHbqW7KKWmQmdrJhVVKIiEzYMKMnTJ5PsBzODgVCNfGLHzJfjI9x?=
 =?us-ascii?Q?tcxVUt2KL9KztRpX2HgdE6ujoppwq2MGWT159/7NpCPT2PVyq4T2cmp/F2+Z?=
 =?us-ascii?Q?iYbJETP4zNHoXY6YeIyzOwv2lB8L/rA7GHXsJxijZr64/vOYJb35ASJfiZvO?=
 =?us-ascii?Q?ysmsoASw4EOElu6uJJLxvuyRkdtIljQeDUFzXpnR+sQrXYcSmezKBo3KVN0V?=
 =?us-ascii?Q?q66lHtIFQ5sXAgp3n/1REqd1rXz4fDk55G360dBhHA0m0Y7K5B7Myxg52bU+?=
 =?us-ascii?Q?tqOn1LH1HYNlJdmtyMJK/f6NUmUmR3jEJbOALAOgdQBTJajXixIKOd39TnYO?=
 =?us-ascii?Q?ecAaTstk0oRCaIW/ieS1abxx/hXSnqbhMrJIMA+FxqHW1VnkSOcm81UcQlOZ?=
 =?us-ascii?Q?oK4Ep4Yt5dJmAidp9uwTQeHt9J9w/BWqoZUzSWwQ77o77th+gwCtZ0V46fLK?=
 =?us-ascii?Q?SSNfyPLJcDUREgiCsEI7BNnLKDO135Z72dMwVu+73q9TooYDWNnu3Sua590Z?=
 =?us-ascii?Q?m4SYZYd3Y9CPFWC374ykNZdudA5iEgGmQyin98OS7iwNEtXyX31O+2S2q5Uh?=
 =?us-ascii?Q?Hg7eQ3ljeESj4oGAigX7hQoH35qozDOC6osMot5NzFiWKFCLj0nWdmoNy++M?=
 =?us-ascii?Q?7/qPY81keEHaQgtqR+N3jhctBo5eWP24zI0UONFDERozAZZMsTXRZeFYoFfz?=
 =?us-ascii?Q?Ghl7OsU7goAqIdQOz2XslHq3ZzkhxGGAAn+e0lStNEYET3uUe4ou7xDZis52?=
 =?us-ascii?Q?YPT1gm6m0haIKhkYL8p6uNvDkI0G1c8Cmpj7+OBQAIqVCJuHakD79aVlILzI?=
 =?us-ascii?Q?529iVmp+CRszMSi4gmuX1/+poDpYGkIbZjc1JnU3ZLHKfwFGauw9cnU72Sdu?=
 =?us-ascii?Q?3BcmEvbBdeGshvBNHeslClYXIyrh1zg2446iLTkQ78YsnygN9eQ8h5e8W+Ve?=
 =?us-ascii?Q?a30xdMgxxECD51DXSqJnx0ILDhSC8hiIuk3e2b3T64KOkqYmEkniSeQZuEtG?=
 =?us-ascii?Q?ckCpDGL+eKgnZnd/qW6PG6MkqyiwvKa8qx2zS/wsjmylmgSVdoycUVTxzo1e?=
 =?us-ascii?Q?6kAG74p1ybAeZPuoKAcZ0sE4ISvrCyL5q3a7rRLxyc2BiuCapGIuQSkKHvVo?=
 =?us-ascii?Q?8ljdEBZM+shnfa6L9cdSB4hEIn0YqWJJlwJ/k8Xz/RSsZfB9MajjJOBNveUl?=
 =?us-ascii?Q?aivB6dTMgrBgM7rCgwtqmChYuiFvGkqq091+MqNN+5IvSW6gf2NCq2XCS39v?=
 =?us-ascii?Q?LYgGQsx9ZG9amjl9M03gXTHVGtzaH7kAR21IV9knRk9cT898gLFPkX76gZwm?=
 =?us-ascii?Q?SYPA/w=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 17:58:32.5178 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f013e17-d62e-4122-e6c2-08de5916b102
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9676
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

Add pcie_insert_capability(), a helper to insert a PCIe extended
capability into an existing extended capability list at a caller
specified offset.

Unlike pcie_add_capability(), which always appends a capability to the
end of the list, this helper preserves the existing list ordering while
allowing insertion at an arbitrary offset.

The helper only validates that the insertion does not overwrite an
existing PCIe extended capability header, since corrupting a header
would break the extended capability linked list. Validation of overlaps
with other configuration space registers or capability-specific
register blocks is left to the caller.

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/pci/pcie.c         | 69 +++++++++++++++++++++++++++++++++++++++++++
 include/hw/pci/pcie.h |  2 ++
 2 files changed, 71 insertions(+)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index b302de6419..aa9024e532 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -1050,6 +1050,75 @@ static void pcie_ext_cap_set_next(PCIDevice *dev, uint16_t pos, uint16_t next)
     pci_set_long(dev->config + pos, header);
 }
 
+/*
+ * Insert a PCIe extended capability at a given offset.
+ *
+ * This helper only validates that the insertion does not overwrite an
+ * existing PCIe extended capability header, as corrupting a header would
+ * break the extended capability linked list.
+ *
+ * The caller must ensure that (offset, size) does not overlap with other
+ * registers or capability-specific register blocks. Overlaps with
+ * capability-specific registers are not checked and are considered a
+ * user-controlled override.
+ *
+ * Note: Best effort helper. The PCIe spec does not require extended
+ * capabilities to be ordered, but most devices use a forward-linked list.
+ * Devices that do not consistently use a forward-linked list may cause
+ * insertion to fail.
+ */
+bool pcie_insert_capability(PCIDevice *dev, uint16_t cap_id, uint8_t cap_ver,
+                            uint16_t offset, uint16_t size)
+{
+    uint16_t pos = PCI_CONFIG_SPACE_SIZE, prev = 0;
+    uint32_t header;
+
+    assert(pci_is_express(dev));
+
+    if (!QEMU_IS_ALIGNED(offset, PCI_EXT_CAP_ALIGN) ||
+        size < 8 ||
+        offset < PCI_CONFIG_SPACE_SIZE ||
+        offset >= PCIE_CONFIG_SPACE_SIZE ||
+        offset + size > PCIE_CONFIG_SPACE_SIZE) {
+        return false;
+    }
+
+    header = pci_get_long(dev->config + pos);
+    if (!header) {
+        /* No extended capability present, insertion must be at the ECAP head */
+        if (offset != pos) {
+            return false;
+        }
+        pci_set_long(dev->config + pos, PCI_EXT_CAP(cap_id, cap_ver, 0));
+        goto out;
+    }
+
+    while (header && pos && offset >= pos) {
+        uint16_t next = PCI_EXT_CAP_NEXT(header);
+
+        /* Reject insertion inside an existing ECAP header (4 bytes) */
+        if (offset < pos + PCI_EXT_CAP_ALIGN) {
+            return false;
+        }
+
+        prev = pos;
+        pos = next;
+        header = pos ? pci_get_long(dev->config + pos) : 0;
+    }
+
+    pci_set_long(dev->config + offset, PCI_EXT_CAP(cap_id, cap_ver, pos));
+    if (prev) {
+        pcie_ext_cap_set_next(dev, prev, offset);
+    }
+
+out:
+    /* Make capability read-only by default */
+    memset(dev->wmask + offset, 0, size);
+    memset(dev->w1cmask + offset, 0, size);
+    /* Check capability by default */
+    memset(dev->cmask + offset, 0xFF, size);
+    return true;
+}
 /*
  * Caller must supply valid (offset, size) such that the range wouldn't
  * overlap with other capability or other registers.
diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index c880ae1e04..d68bfa6257 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -133,6 +133,8 @@ uint16_t pcie_find_capability(PCIDevice *dev, uint16_t cap_id);
 void pcie_add_capability(PCIDevice *dev,
                          uint16_t cap_id, uint8_t cap_ver,
                          uint16_t offset, uint16_t size);
+bool pcie_insert_capability(PCIDevice *dev, uint16_t cap_id, uint8_t cap_ver,
+                            uint16_t offset, uint16_t size);
 void pcie_sync_bridge_lnk(PCIDevice *dev);
 
 void pcie_acs_init(PCIDevice *dev, uint16_t offset);
-- 
2.43.0


