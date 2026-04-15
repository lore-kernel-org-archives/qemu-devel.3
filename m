Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC52F4198E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 11:00:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCxx3-0002Fo-SM; Wed, 15 Apr 2026 06:58:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCxwp-0001eb-Uo; Wed, 15 Apr 2026 06:58:20 -0400
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCxwo-00049m-AN; Wed, 15 Apr 2026 06:58:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a72CkQUrzDDhHmeDKKggrmM7/RbNMtBPLd15xcunxl18IEqH8z2aY/QDJh/s4ihCvnCLWXs8IVm3DY0EmCHx74T53ZAa2BIoecoDGguj7khy3gTT+bmTS/sAujxVAf4QNTGUohYnhAc9g8fzIuLt19L9FWDzpSNauPpmWwVscsobKbuyTkhGtSdyh7rQjRjnj7v4opQ5h+ZEkik041zRqhmh2kTNrUadhkT7b06wrWaj1D2/LkFl/dzdqzvVMZHGDFnO9FJRg6MJEru1TUy4ghgEx7pSU8U1uJ99bVq7JEtoJ1M5Rv9ScgxQbFavWHLQXOgfSHtquvlb+Q6SbBS0zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88lDOJP+DRVIEkOLe/8oAZrn22rYofsJhUkimrenwNs=;
 b=eQbyqJEcHAtQQlig2y5Yz+aVulw+GVW4/6qNOQsNMPzDno6pucN8hi+7fUu5vVr2BpHnOVc/Hbpvk0IRfN9re8enxIfm98TIhb550QSimZoCmQgUFMGYUUf1p/6ftE0qdC4SByVpjTnzLD2AwgjQ0OXUiCnQhT0Lb1KZAHqCWyyrB2db7ziyXfgnZZzlsGfKygrf3jLtbsK72Dm/x+4FlMbn+6u37Z3WgQ+wmpcArXK0hjmsmZ7DUp+YmI37AxOAs++J56uKaXluZe2rX4LXcJ9OkmXuA+gtZNzS3uZVkst76Ci5VbC+S44hJPI0X8sHGiYcTgnoFYjPTQ7/4n+iyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88lDOJP+DRVIEkOLe/8oAZrn22rYofsJhUkimrenwNs=;
 b=LLQ6/SZ9i6cGbuk4M2ZOWgZaAsdbGeybK5A1mBDz/QR3V46ytP0hroszCw+gbTfBniXoUsGATWannA/LfsUYCRvDfxM62qCnvG7pfpy/tlf2YsspcqPSh4lkRU5MjK2rEEV7Uzso1855Y4A9bm3e5yFAjIpR+TSOP3idJ8eawbKngVUQms8gzSZjr879Ku8WzstlFDymQzkR13VilZ3CtqRgqb4ytTSxGdvbbcUc5E7hPANDXl0u8boQdPRrMKAWaDzHxHwHxpb86yqqC4Kx5r2Wjyn0o17noAspmXvpfXQhpOxKghIlwtIQ1T9x9H1PQtokSR9lX4aaCr3ynqySgQ==
Received: from DM6PR02CA0118.namprd02.prod.outlook.com (2603:10b6:5:1b4::20)
 by DS0PR12MB7581.namprd12.prod.outlook.com (2603:10b6:8:13d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 10:58:06 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:5:1b4:cafe::4d) by DM6PR02CA0118.outlook.office365.com
 (2603:10b6:5:1b4::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Wed,
 15 Apr 2026 10:58:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 10:58:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 03:57:48 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 03:57:45 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhenzhong.duan@intel.com>,
 <kjaju@nvidia.com>, <phrdina@redhat.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v4 20/31] hw/arm/tegra241-cmdqv: Use mmap'd VINTF page0 as
 VCMDQ backing
Date: Wed, 15 Apr 2026 11:55:41 +0100
Message-ID: <20260415105552.622421-21-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|DS0PR12MB7581:EE_
X-MS-Office365-Filtering-Correlation-Id: e48247ac-a224-44c1-372f-08de9adddf37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: TtqaLwwEu1J8tnQX4+Pn8tj2d8ecBaHfQ5phA/vJZS1icT2vAGEftCQ6LgCe+mLZ0zwqa0vwjHBJeopwbpzwI/MaNRA9YWDWnXGi9hG1EsNARZW8ELAUYxhysU+qxVRqE6wWnXO+oVDt5rQVUGwQN+rKsOKPwLeMy2Lcg0kqpayOuYUG6EQlbb0fB34jVlWS6+1UbRnHV44K0FlFuVwx5LNQUV7ngKyKFyX0HHhsZmtuRTL1E7pUVXFl5tasLUP/Rjx1z9IPn+o16p14JynzLiEeZY8ShgM8nwFCt2yIiDKScEB2lPxX6fX8Svg44iMCN9grMiab/j6SUyhaJm6zkaL8zfVnPi0l95X7NGN3STyB5513Tk3K4lqkXWgH6lb76q6pBYmknrErAinhvAuM2XBWbRVZ7R3eTWKIEu/OdC+j95ZIdb4I3hriwgSQoOW4WKRq6elS++Ofi+kCHu0aScrpOEZNpgwcLusYIsQjTCxcOntyRteL0/B/PhohTDDq8EqxSQNYDuYTI6BsSD0FoM+xTSeJrDWpFw/ddpVzQnGpfp4jHdCJ9dFumRhqoEweWQ6p8XgEfrxyV324uUyWx5Cgx8UptD2Hy2Nl09+SvPr6qNaIoFTGEsCkIyfEC6TIZToG6uDMkQaj451bYbXmJFj2QnBVPOAMr3Yeygu54WeAz/dgOtGQNpXMbDDvqHwj82gE0lo9dAajSses1qQskuCgfx+Lb7A+PO4YoeLmnYfSZi9mUP1x1Lc/hIEo3ShwKoFG3ggjB68U/Tu9cDNqzQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gwdfJYpfN7gMNHzrv5qa38iEq5BPg4sPJjx2n57Ssa8ttf5iRK6LcY3nZdqbK6mZAehYtihIRRkiRrbyQyoqFUdpLzmMAQDOStFQzytKiMIPDAYAA7lY5c4c1eSfTFl7c7hQeCcpnng7RQUQjzZVrsEwSdB8BBhPmpMrkqikAnmgZ5aRxKIi8kGYdrEmEJDZaLOkHwFOV23jYvrh2zGb0QcDGdgDbGCMzMq6gIfY1eJdCpwqTZ7x2YWVxkKyakzfhOIUF6FW30ibr6MDMQQ0l1yws0vWN956mhXkRC2xgGfX0MkXwL+WRKpQxr/siFtNBCpdmFDHMCcJWbjZDg8B2wWtXnsv3h8qV3B/zNNC1eGtYd/pwo++uVsQMiSjbtcaEPhqMTd0TZbTDEYXQc4+xEqCP7ejDU1hBCEkrT058ITsaWAtLhMCfXNrKlJUeW7R
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 10:58:05.5140 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e48247ac-a224-44c1-372f-08de9adddf37
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7581
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
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

Introduce tegra241_cmdqv_vintf_ptr() to route VCMDQ register accesses
through the mmap'd VINTF page0 backing once a hardware queue has been
allocated.

There are two QEMU trapped MMIO apertures for VCMDQ registers:

  - Direct VCMDQ aperture (offset 0x10000)
  - VINTF Page0 (offset 0x30000)

These are hardware aliases: they address the same underlying registers.
A subsequent patch maps the VINTF aperture as a guest-direct RAM region;
in this patch both remain QEMU-trapped.

VCMDQ register accesses operate in one of two mutually exclusive modes,
depending on whether a hardware queue (IOMMU_HW_QUEUE_ALLOC) has been
allocated for the VCMDQ:

Pre-alloc: vintf_ptr is NULL. Both apertures use QEMU's register
cache. Hardware is not yet engaged;

Post-alloc: vintf_ptr is valid. Both QEMU trapped apertures access
registers directly via the mmap'd vintf_page0 pointer, bypassing
the cache. Hardware is the single source of truth.

The pre-to-post-alloc transition is triggered by the BASE register write
that initiates IOMMU_HW_QUEUE_ALLOC. No cache-to-hardware synchronisation
is needed at transition time. The hardware mandated init sequence requires
BASE to be written first; PROD_INDX, CONS_INDX and CONFIG.CMDQ_EN are
programmed only after BASE and are therefore always post-alloc.

Any pre-alloc writes to those registers update only the register cache,
which is discarded at the transition.

CMDQV acceleration only becomes active once the guest enables VINTF and
programs the VCMDQ BASE register. Until then, all VCMDQ accesses are
served from the emulated register cache with no real hardware command
processing. This matches the CMDQV hardware specification: if the logical
CMDQ index does not map to any allocated Virtual CMDQ, "the access is
dropped with no Fault/Interrupt".

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.c | 48 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index b5f2f74cf2..eb619e1134 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -75,17 +75,45 @@ static bool tegra241_cmdqv_setup_vcmdq(Tegra241CMDQV *cmdqv, int index,
     return true;
 }
 
+static inline uint32_t *tegra241_cmdqv_vintf_ptr(Tegra241CMDQV *cmdqv,
+                                                 int index, hwaddr offset0)
+{
+    if (!cmdqv->vcmdq[index] || !cmdqv->vintf_page0) {
+        return NULL;
+    }
+    return (uint32_t *)(cmdqv->vintf_page0 +
+                        (index * CMDQV_VCMDQ_STRIDE) +
+                        (offset0 - CMDQV_VCMDQ_PAGE0_BASE));
+}
+
 /*
  * Read a VCMDQ register using VCMDQ0_* offsets.
  *
  * The caller normalizes the MMIO offset such that @offset0 always refers
  * to a VCMDQ0_* register, while @index selects the VCMDQ instance.
  *
- * All VCMDQ accesses return cached registers.
+ * If the VCMDQ is allocated and VINTF page0 is mmap'd, read directly
+ * from the VINTF page0 backing. Otherwise, fall back to cached state.
  */
 static uint64_t tegra241_cmdqv_read_vcmdq(Tegra241CMDQV *cmdqv, hwaddr offset0,
                                           int index)
 {
+    uint32_t *ptr = tegra241_cmdqv_vintf_ptr(cmdqv, index, offset0);
+
+    if (ptr) {
+        switch (offset0) {
+        case A_VCMDQ0_CONS_INDX:
+        case A_VCMDQ0_PROD_INDX:
+        case A_VCMDQ0_CONFIG:
+        case A_VCMDQ0_STATUS:
+        case A_VCMDQ0_GERROR:
+        case A_VCMDQ0_GERRORN:
+            return *ptr;
+        default:
+            break;
+        }
+    }
+
     switch (offset0) {
     case A_VCMDQ0_CONS_INDX:
         return cmdqv->vcmdq_cons_indx[index];
@@ -120,11 +148,29 @@ static uint64_t tegra241_cmdqv_read_vcmdq(Tegra241CMDQV *cmdqv, hwaddr offset0,
  *
  * The caller normalizes the MMIO offset such that @offset0 always refers
  * to a VCMDQ0_* register, while @index selects the VCMDQ instance.
+ *
+ * If the VCMDQ is allocated and VINTF page0 is mmap'd, write directly
+ * to the VINTF page0 backing. Otherwise, update cached state.
  */
 static void tegra241_cmdqv_write_vcmdq(Tegra241CMDQV *cmdqv, hwaddr offset0,
                                        int index, uint64_t value,
                                        unsigned size, Error **errp)
 {
+    uint32_t *ptr = tegra241_cmdqv_vintf_ptr(cmdqv, index, offset0);
+
+    if (ptr) {
+        switch (offset0) {
+        case A_VCMDQ0_CONS_INDX:
+        case A_VCMDQ0_PROD_INDX:
+        case A_VCMDQ0_CONFIG:
+        case A_VCMDQ0_GERRORN:
+            *ptr = (uint32_t)value;
+            return;
+        default:
+            break;
+        }
+    }
+
     switch (offset0) {
     case A_VCMDQ0_CONS_INDX:
         cmdqv->vcmdq_cons_indx[index] = (uint32_t)value;
-- 
2.43.0


