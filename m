Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A54D8C47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 16:27:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT2YG-0002Je-TG; Thu, 25 Jan 2024 11:26:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rT2Y6-0002Ha-3h
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:25:55 -0500
Received: from mail-dm6nam12on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2417::600]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rT2Y4-0000RN-FA
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:25:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ka1TFKI6VtIsh7k9/dalk6MkxiEsrzeoXKt1zXAEwucd2x8qcOKLuuUEk6LAlRF2IMMKNXtBc3nX3bdW7Hr9wyPxgwwcSVZMo9Gr1HfY3qk5T9Tzf/gXgebhQniQutssbdti6vxe0yZDbmYGw5ylKsiUCFdoaDdScrD5OFaOt6pc45ATU7oonSRuoOouax0hhXKeDNrRIaI69SGof5ehKG2U73dBKP63IO765O3593Al/Wa32F09cdYWX8fCzxCPhp04FAxekejmmcekE2RBoSME19JUlIZY9L4Oii2lyLC9Tw5R0WztBrBxc8G9t1LK25zH37DRofryEuwSywznwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wlPwzH63ATMiNUtDCCHHjny0M27LHnPipZqgvXnQbMg=;
 b=XLF6BTQUR4IPRpGzOF4w7pO9EqwS6TulCS1eOnMp78JX3Lr4AHaVDqrJTNbVSAQFDbV6LQAgbvXAkjyjzCfqB/DRlRs/fAtdyiqQNR0Gw2BxXPA8YldK64GUvNDTvt1lw2FAR6o41sLihKuCJq3es2cPMXtmwpPVhTRiC5xah+691FwwiGtp6u9jMANzuI9Vatdg2l0s1s/gYG81r2XK1Blpxw4jV4NxEwrmcF7kPvPiyDdqAxvFglE8sq5LS7eNhUreQjXNuv1FcT+DM5Adwi7ucpBMTQa0kmV1fcMbUJvZRX8f2y7D2Qkj5K/JIBnKRk1K3Q5ImcztEhyXvoALpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wlPwzH63ATMiNUtDCCHHjny0M27LHnPipZqgvXnQbMg=;
 b=SrQrMy1IX1ax7AiangcWA0+84dkqz1TXS2OG1JWz+R2w7phW34ebVRvs2kWiEyFZboZLU37UTCnf+enns2H/0907XyV39Rojm99IPjtrobvct4vpunSTGJhwy7r6VfoYebC77rou4MrDtWiRtKp40jwl0OVjLhvLmsozpIcXIbIUq+pv2Uu7W+K2+mJLFcgDqwz3uq6PSv9u8LdkLFtZ3xf8pt98HUiKbyqIn8eUN4nlxUfmfuTYy3cB34L7fwoiCfYitaGBEIs1V2UOCI9OktB+77Gh8nGpo+wHqBbyBihy1JJ+eBNW+BK5nR+FiSrHbcjn63kHHMJ18unZvpv90A==
Received: from CYZPR12CA0018.namprd12.prod.outlook.com (2603:10b6:930:8b::10)
 by LV2PR12MB5824.namprd12.prod.outlook.com (2603:10b6:408:176::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 16:25:44 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:930:8b:cafe::d5) by CYZPR12CA0018.outlook.office365.com
 (2603:10b6:930:8b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27 via Frontend
 Transport; Thu, 25 Jan 2024 16:25:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.82) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.16 via Frontend Transport; Thu, 25 Jan 2024 16:25:44 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 25 Jan
 2024 08:25:34 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 25 Jan 2024 08:25:33 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport;
 Thu, 25 Jan 2024 08:25:32 -0800
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, "Avihai
 Horon" <avihaih@nvidia.com>
Subject: [PATCH 02/17] migration: Move local_err check in
 migration_ioc_process_incoming()
Date: Thu, 25 Jan 2024 18:25:13 +0200
Message-ID: <20240125162528.7552-3-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20240125162528.7552-1-avihaih@nvidia.com>
References: <20240125162528.7552-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|LV2PR12MB5824:EE_
X-MS-Office365-Filtering-Correlation-Id: b986b661-a071-4c53-ce88-08dc1dc247b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OUIxz0txPN7n/kqED4mkudVzZnYuo2RusVlW99AZKQhBjFCf7g2xgOZOeGxnmPt8ZwvMEpzlMJ9/eiQ73/j5kJpPOUCXCBWG4uDm3oH0El+tj7GjSCJ5uqc3r35vODIyKlWzFLMsCwa0fw1egtqYY4FlL5mCQiEqB1QcMG2j82bEjaGQSvYeB02giytFm6tg1qr6SKk5bt3dp4ox5AsHCNodw0Rj8oLju5tzh7owKyIKA1ogcQ1FiXGFH7tpL5/B2NHX3QhEfeQXNvUrrPPz8usIooPxYP2NeWL0Uhj2Mo562dFrskIC+sPI7uACoWo6P36vHD60aL/3JapZ9F9nL2XFdTlXP2UMU1B2BWxg8m16fzWQuaa1EMmYD60/umathHht8so0mQkmy66b9g/lj2oRJoHHFIRCkCcXeWvsT0lXD0y31fHCL5+qSzSKiDxi9+73oOZ1II4OOc5DfHQ1Kmt98kd8MrUOeV81xfFgh9HtL8zILaK3lFBQ6a7qOHEBsl3G2Wi+fjUfWz0vi1e83u2M2UQ2wmQmG1XrpGrAXmd0/GEX3yk87Gkou7VAA4Ss/RMrEnsJ96pS4Pdl5BF18LPHf8xXeqwGRni2efy6oeFvb/NC9erRsbSXYm1qYnGJNioCkFfIUdM3idJX2p7s3/w0xuroWVzGXN1Ry7QZEgidomypH72NUbphSLZyKsc2+e8ynzgjWp0Zp7bT6FNXVMCOXFQvenOcZm/21UTjj9XyR7cBuvDDRHPwU4RpKU59
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(186009)(64100799003)(1800799012)(82310400011)(451199024)(46966006)(36840700001)(40470700004)(107886003)(2616005)(70586007)(54906003)(1076003)(316002)(26005)(336012)(426003)(70206006)(6916009)(8676002)(4326008)(8936002)(83380400001)(47076005)(2906002)(36860700001)(4744005)(82740400003)(6666004)(7636003)(356005)(41300700001)(86362001)(40460700003)(40480700001)(7696005)(478600001)(5660300002)(36756003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 16:25:44.2460 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b986b661-a071-4c53-ce88-08dc1dc247b0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5824
Received-SPF: softfail client-ip=2a01:111:f403:2417::600;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

local_err in migration_ioc_process_incoming() is used only in the
multifd if branch. Move the local_err check under the multifd branch,
where it is actually used.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 migration/migration.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 6fc544711a..ccd497ca21 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -863,15 +863,15 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
         assert(migration_needs_multiple_sockets());
         if (migrate_multifd()) {
             multifd_recv_new_channel(ioc, &local_err);
+            if (local_err) {
+                error_propagate(errp, local_err);
+                return;
+            }
         } else {
             assert(migrate_postcopy_preempt());
             f = qemu_file_new_input(ioc);
             postcopy_preempt_new_channel(mis, f);
         }
-        if (local_err) {
-            error_propagate(errp, local_err);
-            return;
-        }
     }
 
     if (migration_should_start_incoming(default_channel)) {
-- 
2.26.3


