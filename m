Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D623AD3C935
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2024 13:02:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2VZ1-0002VE-3k; Sun, 20 Oct 2024 09:01:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1t2VYu-0002Ua-2E
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 09:01:36 -0400
Received: from mail-dm6nam10on20607.outbound.protection.outlook.com
 ([2a01:111:f403:2413::607]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1t2VYq-0005zz-LZ
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 09:01:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NhOLHsJcPH+L3dyyH3OIHvVXxhEBrb3aW8Hq7i/fdY9r3y3fiB/GLXwu2PU2ZD7lnYLJ1V6/o9iTftlZS2LcXsoVSMPsDyNlQfGsPsz0zwPMSONI46pMCFD/fbMrjfdi5O3wRdwHyCU49n4EdgwCToduUL5Gc85xk8jcQZ/GL7xrH4Ptz+HRiN8dHs/4Lw1kwD5NV9MEBya8dJtoNMPJ4CFWnpzwZsbKp3LMZ5QAN60sP0+L9CSYet9LbGqSif+nVbNJaE7B1vH1a/OlMHv1bJ8oI8mEQJjzPUDEfH62PzEfmuxWZFNWe2cNCmWYkutKPAs//GSy9SSicjBXhujZtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RgDgzuV/ynKTSoloqrpuFHVI+42kYg9sJUadBdSsNHw=;
 b=jvUqdrgMnE1UoH6ogj5msUrUGx7UExNEm/j6d/GglWwdLeJQ7NVD/g41illItL+Kq8SEeIfqd/RO1nOWcIsXwo/km1CRCjZSaC6JdXrMUpBA83AqLl9RQZRf3J0aY2yygGiCe6LK7vHOoUPBZzycUoyufP2g65XYCzfD1fiClt7/qWyoPKY5WNpf2wA3GruBOByojjJjUxFGl7Hl7i/PXvn/IW1N5Cs0f7YCFjhFqy2Y/zrlH6gCo668pChNiDSoUpglq99Z8nTni9iPL5mW35CSi9mP85hrQfFItWgEe0SU2g69NgcWDcyCiegq1lDVJecpWYJ0s66wtTfI96axOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RgDgzuV/ynKTSoloqrpuFHVI+42kYg9sJUadBdSsNHw=;
 b=j2p+8ZrquUSUpzB1kAivaOY2NhUrp9yF/RKRVo7iqrrv+xRqEtzhFq5pioydXpxrBZsochxSISnS+r6pV2iO20Y2C7TpnYsjIM+mTeR28aeG8O9OnEM/0BeZT4AmmceY2rJtYx1DPxwJ1ymIuSEDwa1SeJtKipD6beHpMliG7vRVZFU9o9N1dVCIh3uarCftLrZ/uUZZtfwO2v6zEPCndZMUv/dtrwou5kIRzy2W4R4BcgDZjxEMsXv6m6hY6M953wefhLm/HBOGToNiRUUFauhQBBDBw8PkqXBVh8Wl2xGx1xP9Yuk0kV7QaFyNmQma8RXsuNwBh6ZHCjtK3dOX5Q==
Received: from BN9PR03CA0398.namprd03.prod.outlook.com (2603:10b6:408:111::13)
 by SJ0PR12MB6784.namprd12.prod.outlook.com (2603:10b6:a03:44f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Sun, 20 Oct
 2024 13:01:27 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:408:111:cafe::b2) by BN9PR03CA0398.outlook.office365.com
 (2603:10b6:408:111::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28 via Frontend
 Transport; Sun, 20 Oct 2024 13:01:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Sun, 20 Oct 2024 13:01:25 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 20 Oct
 2024 06:01:14 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 20 Oct
 2024 06:01:13 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Sun, 20 Oct
 2024 06:01:12 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, Avihai Horon
 <avihaih@nvidia.com>
Subject: [PATCH 1/3] vfio/migration: Report only stop-copy size in
 vfio_state_pending_exact()
Date: Sun, 20 Oct 2024 16:01:06 +0300
Message-ID: <20241020130108.27148-2-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20241020130108.27148-1-avihaih@nvidia.com>
References: <20241020130108.27148-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|SJ0PR12MB6784:EE_
X-MS-Office365-Filtering-Correlation-Id: fc432649-b82a-4be9-5e46-08dcf1074e2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hQ3a224Y90yXFvLSWayR/89jI/vb9xKWvt0EStVqHlpdmwx49USf1dKzmXUo?=
 =?us-ascii?Q?1Zf+Y8pUi+h/I8U3gzpwY4ZvMigtYPzeDLL/UHYiXi/ILQZZnu8YvdOSvvPE?=
 =?us-ascii?Q?e6NwEDcRaQplzlwRsdnsU42LjaDrfqLcTlWJwWvxtcvHK7bf0LzNFQTt1DSn?=
 =?us-ascii?Q?r+ph9TxBpuikXjd0yqZjzfij19kS0dApR9TGHM+CMfCOKJ/AzH+MvtwF/wpu?=
 =?us-ascii?Q?WpqsteNVjm5iQ9xUt+j0hmfUK9QOlRi3WEejfFDRlDXnOxHq1WndUIK3aaIs?=
 =?us-ascii?Q?2bWpjUyHOHWuU384z6/mnLSvM/Fv8jQPSFm87Wo5BjAbYiLJHld4Ah3z06J4?=
 =?us-ascii?Q?SPQzcKYfgLJbHmnPo13LfyZyW6bgosWY96NwHitDg7k+oxnMDqAPRCna+aqV?=
 =?us-ascii?Q?vDD5ICz2/NKyz6I4yDGlsTYwhaQWnvbzGYVruROVoKzWeROKt4xWw0vHxJ73?=
 =?us-ascii?Q?P4oRt6zwtmr1L0sBCVSNqCg47+bmH2o5Rqaa38GzS9fWTk9GBFCRMKXrSEed?=
 =?us-ascii?Q?yvR5xy6T72vgfZwFQGOT8hTyDsJalECkbp07jLRwvBbAXLZPBZVISs5ZXe4Q?=
 =?us-ascii?Q?zhgnMqZUt/BCmossWdlAX1wZH5A6h2MXFdYogcWOna/u/P+3BfmxZwn5CK0w?=
 =?us-ascii?Q?kSqN0zBFTuea3UYTfnNDmZiqlt8V9IC3GR6MrlTbScYj2GmvvjUSs6WQzAl/?=
 =?us-ascii?Q?tEsf02XpSbXw1UTJ+4v5GNk0L3Siw2EbWHEF6t3xNZBXlwYhPJdJq8CRzpZF?=
 =?us-ascii?Q?5gmuFdDKaeOKTIhaTcgXsz6HVueuot2fa2hgIHWkFUAjyBqf3RnclBBcM5lc?=
 =?us-ascii?Q?L9mhyIyXBi5S7DyWnls44z55cNVmcOI/S/vlL7IoDEx7RMLke0oXTJ/3qb/c?=
 =?us-ascii?Q?33uVw/tCmc+hW0WCDSHXf16NyNdrSDsqony6/Mja+iTvR+DtJTRgfppWqrOr?=
 =?us-ascii?Q?2q7BkYX9k4RtkHKh9A5jRfAIsiJh7HyEi08i//LyllxJrGIK5qpAYdTCuj8Z?=
 =?us-ascii?Q?Zusqwv8IMOVHRSwZ2iIlX5e0o3N2uZSNOHpyp39qRT6ceRaUPMtISEB+xET0?=
 =?us-ascii?Q?7mUXRyE423M7hs9AknrS5drIF7BTEEhBNVKdwH4dwz3B3Ziq6kvkjDIZUwe6?=
 =?us-ascii?Q?VgHUR13aSpwyLT9tZSEOBsWbqViOvHrZvO+9Nz44/hpywFk8UjYJPJvSlC71?=
 =?us-ascii?Q?YL1CxQTk1TOOUHA/Z8kAJ+L76rAT28QGTHTGhGc5k4rckOK2C8L7ns94oEqe?=
 =?us-ascii?Q?8UL7ydxgoJ7v7Gij+XHKyTo6YS0uTV5wC+24iYIaA9oTc10QAjYue0lFBlYn?=
 =?us-ascii?Q?0zIhno7XBGi+ULyphlrpbp6HuoULDOdPrBKNGIagSsq3fP4H340ZEfvA5LXD?=
 =?us-ascii?Q?wcDjIxZgafGmIoWLEAmaxjphE0BBXZyJKEUBEjLDLY37dB3Gpw=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2024 13:01:25.6463 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc432649-b82a-4be9-5e46-08dcf1074e2e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6784
Received-SPF: softfail client-ip=2a01:111:f403:2413::607;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.527,
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

vfio_state_pending_exact() is used to update migration core how much
device data is left for the device migration. Currently, the sum of
pre-copy and stop-copy sizes of the VFIO device are reported.

The pre-copy size is obtained via the VFIO_MIG_GET_PRECOPY_INFO ioctl,
which returns the amount of device data available to be transferred
while the device is in the PRE_COPY states.

The stop-copy size is obtained via the VFIO_DEVICE_FEATURE_MIG_DATA_SIZE
ioctl, which returns the total amount of device data left to be
transferred in order to complete the device migration.

According to the above, current implementation is wrong -- it reports
extra overlapping data because pre-copy size is already contained in
stop-copy size. Fix it by reporting only stop-copy size.

Fixes: eda7362af959 ("vfio/migration: Add VFIO migration pre-copy support")
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 hw/vfio/migration.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 17199b73ae..992dc3b102 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -576,9 +576,6 @@ static void vfio_state_pending_exact(void *opaque, uint64_t *must_precopy,
 
     if (vfio_device_state_is_precopy(vbasedev)) {
         vfio_query_precopy_size(migration);
-
-        *must_precopy +=
-            migration->precopy_init_size + migration->precopy_dirty_size;
     }
 
     trace_vfio_state_pending_exact(vbasedev->name, *must_precopy, *can_postcopy,
-- 
2.40.1


