Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 093DAE77180
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 09:48:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN7hN-0000Zm-6Y; Mon, 16 Dec 2024 04:47:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tN7hJ-0000ZW-7G
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 04:47:29 -0500
Received: from mail-bn8nam11on2062c.outbound.protection.outlook.com
 ([2a01:111:f403:2414::62c]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tN7hH-0004Nd-Ha
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 04:47:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UKX7yRzpBj5c/FhLysFgzUvfSIF2X/pupvrSPmuKPptHHf0jQZt5sZeVFJlNoVR/1whQl9O7naBFEghtk8QRLS5ByKftunJZ1bj4ht8fL3lqhsiDqjucRfEYiCsvi9izHOV6BcLYXBOMTUu1Gp4gMg2n5d7Tg3BqBzBXDqOXEOfYefy8hHmBWllmqU7p7pRgRXU1ePj1rJM+Ay0RSha7PQXwpHZDh73QXa5RqWmy+/FOMjDvQ5hEZ31N1rmAnc1x3ZQ4Y6u9UnE2qYrgTyxhpF0byAgD8hZUflz79exirhLL4WzmvqbioJ6tnC+QlkUrMNj1/Oy2r/qDfuk+Z0zoRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r1jFyooOR9bbc8ADSfxULEp0uavRGZn1SNL0Xp74KJ4=;
 b=gS98Vu7FbQM7uMJ0CGuxS6Ca+Cm+CIVdsLi5FqA+8G+o/0KYYTd8XJTr9E63ARjQa2OLaRkNxg8ZQJiP3QTHn7OXvsQgqFOgl0LCXu8isPVWMxS3940i1ozVsP21aMdqIkV2TpPbkfMtFtcSIk/6Hv/AD3K5SIEwFLsBylVYIoriivz9lzOyOTEtJDSNSpFGWSLElZ5VCn5X8CL3+aQOYhfIkmq34zgOc/zjNR0+O08go1+I4cFzFtW34Z42+h4UXGgco02B0uYsPEi1JICH5CzRfQK8yFnXW/co3y/Z13j8EXWIJamz2k9N6tKwMJ1Tiux22TVgU7XHYCx+gP9e9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1jFyooOR9bbc8ADSfxULEp0uavRGZn1SNL0Xp74KJ4=;
 b=RHW3kyXE0rHdUr9WYuf13DjzW9B+7LT0eflN+719jda/XER8uz8iN8+TsBa9qK5qe+260hiu05KPU/mWZnfsI1ym4aPmdPXo8G/oS7tHMpHxediRS3vga0K4LUMMh2dtbVoNKt1CybyaHS3rjddUDy3QKCkkvbA3xGG8NTvrv2sZPjvzvBEN8uo/qMlfigeJKmPoJYw8Zf1KGxByZLAA3ER4xWTE3D9cFatn/V7/qfAyewMiA7cJNRWPKq4PHk1PimqQ7GNIpHhQTEzBhX/COSeEYSyAY11e1ttDu9Zc86hTwyUzo2aJ/JwuIH1rRi1Iv9zucI02Nos7mWV32CB6jg==
Received: from MW4PR04CA0346.namprd04.prod.outlook.com (2603:10b6:303:8a::21)
 by SJ2PR12MB8832.namprd12.prod.outlook.com (2603:10b6:a03:4d0::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Mon, 16 Dec
 2024 09:47:14 +0000
Received: from CO1PEPF000066EC.namprd05.prod.outlook.com
 (2603:10b6:303:8a:cafe::4) by MW4PR04CA0346.outlook.office365.com
 (2603:10b6:303:8a::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.20 via Frontend Transport; Mon,
 16 Dec 2024 09:47:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066EC.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Mon, 16 Dec 2024 09:47:13 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Dec
 2024 01:46:57 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Dec
 2024 01:46:57 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 16 Dec
 2024 01:46:55 -0800
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, Hyman Huang
 <yong.huang@smartx.com>, Maor Gottlieb <maorg@nvidia.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: [PATCH 6/9] vfio/migration: Rename vfio_devices_all_dirty_tracking()
Date: Mon, 16 Dec 2024 11:46:35 +0200
Message-ID: <20241216094638.26406-7-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20241216094638.26406-1-avihaih@nvidia.com>
References: <20241216094638.26406-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EC:EE_|SJ2PR12MB8832:EE_
X-MS-Office365-Filtering-Correlation-Id: d3f4634e-289c-484b-7f20-08dd1db69e93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bNQVjwrq6rFgpuW7EKlyxAFLi82kgUT6vWO20EPvWND2ZbbNPQBMEd63m17s?=
 =?us-ascii?Q?mKCFYBZ9a70FxWfnRbSPS67ofcUO07PEcKRDonjyAr2Ox6Q2NrCR4E2JyPyw?=
 =?us-ascii?Q?+1CgM4okmc3iHO6EpKWpGDTmLvYSx3ja2MR1FzUp7rBDifN9WOJSBAKGTnAd?=
 =?us-ascii?Q?idzJq7TXdgvXqG5v9CV6VflQpqViYYut+HBBXdk7n2XrF7EswjNZAXltkW64?=
 =?us-ascii?Q?FdMBde7oYB1QigvFLXJWIuQdIe5Brcvh4J9PSj/T0/XTvjh9q/ZB17GwvrZF?=
 =?us-ascii?Q?wwqTQepH16zD/idRyJo+iQBxJZR80xPwFKQMp7vf+bUo5qXr633SvXl+QJp6?=
 =?us-ascii?Q?08kMRIkCkw5Ol6eQsySBg/zsUsrG4fUDeGkUnQpKpf24J0+DzTMyedevNbGL?=
 =?us-ascii?Q?sAVayNzPV/XPem8sHRDkawrJ5Uh6o2dhEbs+wTTmChkr7lgkGFnMxm0NnTUG?=
 =?us-ascii?Q?ch0174PDD5FbVMZBQdvbPAQGcNfLXDTa4ikuPp/Wqw2Lr5eCm0uSVlL+t05J?=
 =?us-ascii?Q?spnttId8AF7DcrBCJQN9HUc+77pFYp7U6RCyv8pjJD6k5u0EK5ki7AGaUAkV?=
 =?us-ascii?Q?DD7IM6zc7kfAxId1LIEJev7HLl706JQaVsFATte3JHpvXEZd3vDY6k14MBQt?=
 =?us-ascii?Q?WRkeBJjoEcfQoJG1LJOoPtFg85qQ7P73wvpZttDkl0RJKMll7cU4AVpmG60E?=
 =?us-ascii?Q?Z5MwbYJOWrRnsnwsD2+fPbBlhiZMQS0deKNLirHe5xjKTbn54vFhw/A5cuiw?=
 =?us-ascii?Q?x09qHNBnp6uQqB6cEKENGZiOdUcDzD2YjkLVndF3RxebWOe1bWiPLkU/3cr/?=
 =?us-ascii?Q?WXbjD3poaS9ELM87YGAgal6qfUZ6KugsMtUH0DrLjmqFDH9L3vc9nHQdvZNr?=
 =?us-ascii?Q?/qvEA/hE12/KoIt/bKOeptvlnthcO8ojI8xqyEyrepaP0ehDXToTVWQCzfp0?=
 =?us-ascii?Q?tXP0sZMv8ryjywltwqDK/IWVFPosz7dAmiSG50ZudqHsNGZdlFxUM3y0UmLT?=
 =?us-ascii?Q?zxMoP4QfzGn2P07EGRgPF0Cyle6A3QjKien7VEQ95KPxhtdYAtB5RzvfDna0?=
 =?us-ascii?Q?zRt40eaOOFEb5OnbRQo7SpisSfjSO4sxEI9+VGRklixVOPmiBApqkNFjeEhG?=
 =?us-ascii?Q?WqanE95U160AUEWm2GdpkO+LmeWChvVmCAi5YEscyh7TpeotT4O0HJojCigw?=
 =?us-ascii?Q?eou0DnKCVr1GZ2W4/HPJR0eZGLwa4ZyS0MFjaT2QiX0MMV9MbNBGCA1U9tgn?=
 =?us-ascii?Q?cidghmeS96XHt6+9LEjIxxwzTNvEpONpL8lSfX7tTkHzoYyTN+WlySGAaEBC?=
 =?us-ascii?Q?TNPpvdod8a3juLKw8kjgTfDZEbur0ciVIS+rG08CLuA7Tg4yeaZmvD+3F7IJ?=
 =?us-ascii?Q?R0dIelvQmNri1107LI3vNN6NP03XbQS8Qfukfha+Nro9+zVYtFN/fEfsj/Ow?=
 =?us-ascii?Q?Rs/2ZbqtJNXtygaY/C24wq55tZK8yr4QxB6RzjuaH+6pv57tRkN4YAjAy5Zt?=
 =?us-ascii?Q?lUT27nWg0F1vZdw=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 09:47:13.7260 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3f4634e-289c-484b-7f20-08dd1db69e93
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8832
Received-SPF: softfail client-ip=2a01:111:f403:2414::62c;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

vfio_devices_all_dirty_tracking() is used to check if dirty page log
sync is needed. However, besides checking the dirty page tracking
status, it also checks the pre_copy_dirty_page_tracking flag.

Rename it to vfio_devices_log_sync_needed() which reflects its purpose
more accurately and makes the code clearer as there are already several
helpers with similar names.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 hw/vfio/common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 6e4654218a..dd8c5c52b5 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -195,7 +195,7 @@ bool vfio_devices_all_dirty_tracking_started(
            bcontainer->dirty_pages_started;
 }
 
-static bool vfio_devices_all_dirty_tracking(VFIOContainerBase *bcontainer)
+static bool vfio_log_sync_needed(const VFIOContainerBase *bcontainer)
 {
     VFIODevice *vbasedev;
 
@@ -1368,7 +1368,7 @@ static void vfio_listener_log_sync(MemoryListener *listener,
         return;
     }
 
-    if (vfio_devices_all_dirty_tracking(bcontainer)) {
+    if (vfio_log_sync_needed(bcontainer)) {
         ret = vfio_sync_dirty_bitmap(bcontainer, section, &local_err);
         if (ret) {
             error_report_err(local_err);
-- 
2.40.1


