Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42A57CD11C2
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Apr 2024 08:17:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtNhv-0003Av-I8; Sun, 07 Apr 2024 04:16:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rtNhu-0003Al-3M
 for qemu-devel@nongnu.org; Sun, 07 Apr 2024 04:16:54 -0400
Received: from mail-dm6nam11on2070.outbound.protection.outlook.com
 ([40.107.223.70] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rtNhr-0001oD-Vd
 for qemu-devel@nongnu.org; Sun, 07 Apr 2024 04:16:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lnh0Gl2vbXS3bUvtkqkJgTbP0YJlcNdphl0Irx6gL7UY+Q88YH81yFT0qPt3iZJOqsaTRHGBRCx1kn16gBsCGdcq48dG9kiScHp4G0HI858W53KyoUDX/YQHytdUIyccl3tRpaXr2lBm7tIoXRxADQLE3PabRuE+oV53+e9CYh9T7TajSb+dH88t59voiNA0O3A6+Hrn4owivdFhi+JwPPgV5rSNffRWwldWUR/prNb2+fhg2kvExlSFA7sPVdBE0anjd0UhoEP4wILUoZDsEX87HCQghoISU30xjIz0pEA/odFNCh7DK2X4JrjemtDn19Sl1BnAAlgRZdfypoVmWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nmEPZhwuNCmI4peCR31SJUMPoqDJ4f5+XI8qIF4E5zE=;
 b=KmYMVI/lLFgt7EZAudzxq7Kv1xLd02+xuzuIEm17NO+Yc2BSPZa4qBevUVsL+56CQLx9HUwKKYxaKFl8TYu3HAQFIUseRo4cVsx+rxwqYwIkU9arUP+wI2bTI2/TCpx1UiwYKFgU1UM6z4lSIqTdAHFWVBUaWoTSsvxj/F7DE9FcnepaZYryPV7AfvDx7Fj9HzLQSaVpiMgwolAL5mLm1iXUMpy57f+MTv7eFciWArj8jqXr4Fsg1+K35risIorj9TOtdoS+fzn2icdIjGCIoxFxzDAO49LBUWop0+LDQBurPGq+f08Gy2hViPALyi70bGSOGvMsallTdDL82csu9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmEPZhwuNCmI4peCR31SJUMPoqDJ4f5+XI8qIF4E5zE=;
 b=h8cPtIIpeilC2cuq4sOnrxllBw2o+RKcfEJTiaFHc1pa5lUhHV2dbrLxRKQMIQBEsH4qvAKQYjGzh6gaPuankBLCMROKLnHB3rjD6RgDF18aBJPkUYS4T2SCMo11zdtSs+6C4oGUpuxLCUVwtUs8RVpKzdJbhMpTk9j98Guy9tWarsEGsVnu1QQNKKr2aHJK0Pz5xBWu2ZmKEKvYp7bFNKdV6XUsVLO/9BzjOzQ3Rlwelyp2T9idGgIY+NTHI9pfJ1ajo1IJXi9YjPajL2dGqcN4I50Svy5cUIirRoG4aGlM/Goqot9csJyNS6qyUJt60FhbEb7BMBAJpHt0SiB3qg==
Received: from MW3PR06CA0028.namprd06.prod.outlook.com (2603:10b6:303:2a::33)
 by MW4PR12MB6851.namprd12.prod.outlook.com (2603:10b6:303:20b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sun, 7 Apr
 2024 08:11:45 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2603:10b6:303:2a:cafe::97) by MW3PR06CA0028.outlook.office365.com
 (2603:10b6:303:2a::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.35 via Frontend
 Transport; Sun, 7 Apr 2024 08:11:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A6731.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Sun, 7 Apr 2024 08:11:44 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 7 Apr 2024
 01:11:28 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Sun, 7 Apr
 2024 01:11:28 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Sun, 7 Apr
 2024 01:11:26 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, "Alex
 Williamson" <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Hyman Huang <yong.huang@smartx.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: [PATCH for-9.0] MAINTAINERS: Adjust migration documentation files
Date: Sun, 7 Apr 2024 11:11:25 +0300
Message-ID: <20240407081125.13951-1-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|MW4PR12MB6851:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b18bb49-a2db-4b78-a3dd-08dc56da5d2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g7sohq8YsTMyvzvQnzWvkbpARLCnej9dhUAd6dj5drb9WpC6K6MSi/6MhyhcFcqi37VDWIyo+3uJfm/eOzt9qf4f6Mkk2EI0vPNuTxCnwrWSHzZWBxciCP+XtL0yU0d5tp2gpe9C8vf59t0PSs37jdkdgq0F3RCS5jcqK6RO/4zjc3I8ls6dzRdgKKE3HOr73WJXF+RQnuTtVf5LGGLzTvlH3qXlQ2fitcNGF1TF8wCqmB4IHrvMYGBFMgroM4gAXsbHe5+hWfwGyyPGwYE4+cuzClKr/0QO1mrLT8zeFB3qtNl07KYHZEiD1g4R0xYt0598pjqsTgYY/UFMa2hyNtAJBhG2enR2XPolLV7nUvJkB6osYjR/IaNXtZNwSYgE4YMp1r1Q65F3hzzWXudHKJJLzseWzTSTmZaMTHI59/K7DdEbGGA4fSTJjgYyk7PagMduxtDD8X8yJOtpzTKQAyC7UaLXE1rEgto+gwzhj0VgtG9N/Tnk7+WPwe5Vm9gFGA4vprHIy6FWzMw10slHE0cxmABUldiveEN/h8n/OyblSnyNUxsVnlNI3wAsn+vkjbfyGi4Il//UmvSE+cOlIYaMt+iniVoitMmegwACguW1Ab9wNff7D48rSHE33YPhH+RXQ2NPKv5A9s2EhH7xfeLa6RPg4iFA5jeUlca7tfq2xcuB3j4iU2GucmD6d7INhDIxPSKZQwxt+JRMnf4RnZamw6/VznVW8DGyznMJAC1HQqQDJyf1cu7dXwxPHO6q
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2024 08:11:44.5027 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b18bb49-a2db-4b78-a3dd-08dc56da5d2e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6851
Received-SPF: softfail client-ip=40.107.223.70;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Commit 8cb2f8b172e7 ("docs/migration: Create migration/ directory")
changed migration documentation file structure but forgot to update the
entries in the MAINTAINERS file.

Commit 4c6f8a79ae53 ("docs/migration: Split 'dirty limit'") extracted
dirty limit documentation to a new file without updating dirty limit
section in MAINTAINERS file.

Fix the above.

Fixes: 8cb2f8b172e7 ("docs/migration: Create migration/ directory")
Fixes: 4c6f8a79ae53 ("docs/migration: Split 'dirty limit'")
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 MAINTAINERS | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e71183eef9..d3fc2a06e3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2170,7 +2170,7 @@ S: Supported
 F: hw/vfio/*
 F: include/hw/vfio/
 F: docs/igd-assign.txt
-F: docs/devel/vfio-migration.rst
+F: docs/devel/migration/vfio.rst
 
 vfio-ccw
 M: Eric Farman <farman@linux.ibm.com>
@@ -2231,6 +2231,7 @@ F: qapi/virtio.json
 F: net/vhost-user.c
 F: include/hw/virtio/
 F: docs/devel/virtio*
+F: docs/devel/migration/virtio.rst
 
 virtio-balloon
 M: Michael S. Tsirkin <mst@redhat.com>
@@ -3422,7 +3423,7 @@ F: migration/
 F: scripts/vmstate-static-checker.py
 F: tests/vmstate-static-checker-data/
 F: tests/qtest/migration-test.c
-F: docs/devel/migration.rst
+F: docs/devel/migration/
 F: qapi/migration.json
 F: tests/migration/
 F: util/userfaultfd.c
@@ -3442,6 +3443,7 @@ F: include/sysemu/dirtylimit.h
 F: migration/dirtyrate.c
 F: migration/dirtyrate.h
 F: include/sysemu/dirtyrate.h
+F: docs/devel/migration/dirty-limit.rst
 
 Detached LUKS header
 M: Hyman Huang <yong.huang@smartx.com>
-- 
2.26.3


