Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F61CF65DB
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 10:50:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkKBH-0003II-Vv; Mon, 26 Jan 2026 05:50:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkKB6-0002YC-Nm; Mon, 26 Jan 2026 05:50:43 -0500
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkKB1-0006AR-Sp; Mon, 26 Jan 2026 05:50:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gEnSMEyFPZDU9hGTmbs0uhmyyNHHnIUHpN6IwI4P25r6ZKKPubzjnoIxbZPvJJQ8pjATnUj52MUJ/pCA1renTJhx3kxmKCOji2LMMsHrDVT5EdkYGEZGluxrfjwByGdWWYrTGcB730bS0DlS4Y/4AAhiQIF3gqR5Gkw2yEBYnx0xPP7wTNwOjq8OtlqW412+jsk0YGDiPi/8qFMnB1rzim5pK2Ic2J7vXcrlpAjtXyzdXwBRbKlShNMg119lo0XKSmnNGOxf64XYhB3oYwc4quL+BuaywRwy16W0n4R6H99M+E30eJBSAN729z2J0ikeoj4d1N7V+lThstZ8dO6v9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mlYWbYPk2t2WmYsb3fa/uMdMYru2Uo1JnSfr90dWI9M=;
 b=ko3/KQZOdgNuIvyY6FoaRmGIJXi3VW/alCY02IRrDtqiQ3Q+tdF4e42eEAKKDISdzL+N62Svel4qlLhdL9XbmxNFXVOhLaruLubjrhdSQnMOJT59HzEq+jnugy6t0NWjpPpc5l6LcW041fvCWAMrE9iun4t0gs6gZnJMigmX+aYkYCKXl4F+k7jtbXsv03yrR0V6c+HhFAql+z004U28tQ3wgx2YlRESF+URSvtCiVvVCmxV16mSoHQkY7PZehLCaRf9POgy/gTP3bsEHv4ua6RrPHKrZuFciUCJXcbnskWlE8vNP6gIW7UweAePv563cLFFQgOlARD6m0nU0fYg+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlYWbYPk2t2WmYsb3fa/uMdMYru2Uo1JnSfr90dWI9M=;
 b=QDDo64aYwrqbUyX5dvMWFCdOQIQHU4hQ8Fx8EiDPiApgTUIdxf2Jr9KMOlbICkAh7fOo2zK5xFhx/3p67uwhzrPHt1O9WtwJ6dHff3MPmtQWRLlRtUYjYwFl6clMecy5Sw4wRJ6iArX3+gVvx9X3kdE0K26srSVyeZN8UmwNpeo696Qs0+ho3yVWqiQr2xGhXvhbyyR/RA6YkfH4WTCYTwI2/MJ12TLT2zyywylGyvgzOizh+3FKTztzv/CEU9ZFPFD2NvUCsQ+aWNuuZq5IQxVxtYWOcrnTULL7qK16Lfvi8U1dif9AlRbyFrqpOuIUf1btFP/uQW0kkyI3g9efyQ==
Received: from CH0P221CA0019.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::8)
 by SA1PR12MB999108.namprd12.prod.outlook.com (2603:10b6:806:4a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 10:50:29 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:11c:cafe::40) by CH0P221CA0019.outlook.office365.com
 (2603:10b6:610:11c::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Mon,
 26 Jan 2026 10:50:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 10:50:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:50:13 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:50:09 -0800
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
Subject: [PATCH v9 34/37] hw/pci: Add helper to insert PCIe extended
 capability at a fixed offset
Date: Mon, 26 Jan 2026 10:43:31 +0000
Message-ID: <20260126104342.253965-35-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126104342.253965-1-skolothumtho@nvidia.com>
References: <20260126104342.253965-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|SA1PR12MB999108:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a66b02e-5d46-425c-101c-08de5cc8b853
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|7416014|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FwgjNBhj6kNUjp5QkLDgVVIQpofNuoLR5E4Y2/Dtn+QNiOz8xtGmqjQ4AGUf?=
 =?us-ascii?Q?AgCFf9EQpKFQ0DEHiwTKWNIlb3tVsmuUd0yMFB22Nl8Qev+HaUIDegMy+zHC?=
 =?us-ascii?Q?1GruPKWr5rza9pTc6WpXdDxeC1TyscGKetStz7LFfnnVeEgV52ghvcGty+BN?=
 =?us-ascii?Q?a/4BkBFY8JagK2ZggpAd/stXMevbPBf4FXXqf7ilIaeNuQwFydkGrOITpXnU?=
 =?us-ascii?Q?MCoGmPu8JyhJoOGaMXXaSdIA6NMyNQD52jC+xSTKXYMzUwCXpquSCoPPC3yS?=
 =?us-ascii?Q?UjAOO40oujJnkMvT/iqPoLKpP8LFhbORahHSeuTEWWikvaAL+BVG0GmPBI0B?=
 =?us-ascii?Q?147xqQY5lEpp/fLxvj0bFJpHARycWOYt1mABUznC+kGl8nya0YoeeQtlEtBD?=
 =?us-ascii?Q?CEuKz/8uFkRt/upZs2Dyxh6nHq6mkfT0BwndKeSJXvYLUXrqfD0aDzMxwkvx?=
 =?us-ascii?Q?1m08RuS7DHUxVJhRd4+B00jCBz5bwPoWkxfdaaIZGdDaiHmUPXy/t7HP9bt2?=
 =?us-ascii?Q?PqxnNf6cnlcnEkkJSssizHoIFSvreHx/jUiD+P78qGmkrbWebkfakosjZfS5?=
 =?us-ascii?Q?oj2dND/Yt6YxbLJw+X0FIl2QFx7DoTy7m9tdpCW1CdlxNMaRfJIp08LYor4b?=
 =?us-ascii?Q?BEw+nwpHsreUtBk3iEkHeWRkWUvoELd7ENHGE0SF+t9Slx5/LAFOQd2njMWY?=
 =?us-ascii?Q?zbShIi+nf6rPrIQjyuOCu/mUIAhdpbOwuHL4m2eVjURW5r3t/JIM8e19i3ke?=
 =?us-ascii?Q?9MiqEMqEYzs/1Mng8IKogRs+uF7c4rGWu+n08tPNzO+2DjxdWfNvRDkOnVtK?=
 =?us-ascii?Q?RFVyfJ0+iSiOx4GXfR3ZKfYb5GYh8XGGNhFTiONA+Wv37f0NvUxYhmyUYr+A?=
 =?us-ascii?Q?pJvu5bUFTezRSCFE63AaWSjFrKfhvpYkhkWQVSFAqe7EkN8hTWiILSNdQgZJ?=
 =?us-ascii?Q?MrR2jU9O04Xs8k7D3Ljbh+J5yp6pQeWtMx9EYaMY9SkSnb/f095RKY0inncl?=
 =?us-ascii?Q?SGdPvttA7XJ7mqgNjhhbsusg3qHC596gKNguM2sb+Fie8wDNq8pMuPKeFY5Z?=
 =?us-ascii?Q?qUfZ5hmLSG8/u8C/RnJvdngQeDBdZ6Qt/nxqhW6Dlyq54cO5jqFF5q7kvF+V?=
 =?us-ascii?Q?2Kcqu0ti1Kp1Aq5P1/1SrWBO2/PIiZ5xC5jH2BfT19ZyAGXmYQEkABEJCdnG?=
 =?us-ascii?Q?k6s3WJfJFp8oKtToYeD6eiPB5s2dcebCrPwqyv7KkKQUWOan2WZa74hBJity?=
 =?us-ascii?Q?ADrETpPoDP9UTenazuU9SS/yvh5ne6ttPWhAZvE5u2VeUqRjKT/d0HDC5fUo?=
 =?us-ascii?Q?MOlm2vCLYaZ/Saxw6l0eIvPXGQ0/aKxvwljqZHQ7BW0xtASm6kmA9ke8Mq+L?=
 =?us-ascii?Q?CKf15teR6VfNc0s5X9N6I3moj2Emsb/kQAz53B3enKo1S0W/yuPjiINBH3oA?=
 =?us-ascii?Q?Kak3e7FknXyGBin+77e5KADs41PVPpFxANOgIc2TErjetxS/eIvha+Q+O/Ep?=
 =?us-ascii?Q?J1/qPyfLhQu/s1vYNMK30F/zWv+lk7YJmOfEatzku3nuP79CizJDCx9o2/x+?=
 =?us-ascii?Q?ej3FVfataWhVXdXSmuQBQrPKldLnf02Ihhv/17bg+iJaGkolq52CiHz88aPa?=
 =?us-ascii?Q?zXbBbnIeQ313ez1uEKFxlQMDO5qxLixmPg+rCjpZvzXJjpF5QMGwrXxqRuXt?=
 =?us-ascii?Q?s0QUJQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(7416014)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 10:50:28.7247 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a66b02e-5d46-425c-101c-08de5cc8b853
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999108
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=0.587, SPF_HELO_PASS=-0.001,
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
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
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


