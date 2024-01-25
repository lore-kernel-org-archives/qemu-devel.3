Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BACB3C47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 16:27:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT2YG-0002Jc-AI; Thu, 25 Jan 2024 11:26:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rT2Y7-0002Hg-Ob
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:25:55 -0500
Received: from mail-mw2nam12on20601.outbound.protection.outlook.com
 ([2a01:111:f403:200a::601]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rT2Y5-0000RS-9W
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:25:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ahNsbUenSOnjVO8fmgtKYu3Y6nrekoKFapxGVOpr40fjoEXwyMm438jKYH9zhaWwkb8J8WOiUR0RBImb+aQLrbrBLLdq/xkq078chjy+Jj+xdB+OV0CXYQnr19oL4muDzHBYtw3Ply5SzN2CT1dSXPDQ5yj+6b88SrzAw1C6oJG40MnNyl4K2Y8dlSryfTxjy9J5BXrVKzL5FEu0+n1aUnznZKnbqRl5YuM+SYZMEuOKMxtiRwGXH562miTxcueSmmNA1skWq8VjIbVTZoklpHDt56HS33ECXXBg5HyvoU7CgXW/SrboRbTHeGzjc5i9gE/w1CLU6AwC6RByUdTCCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HbWKboD99E3jpvqxT8LmzTS86iLG2aPdwE9Aek8Rvo4=;
 b=I2PCdb9HGzFMFqCJ7T/Q+T2lQ+0G5I93dGZzUfeO1LmNV16ijpMxwIzqHzVuTLaNXsx4PpVIMXdsVDc970LcAzyCaX2dhA1bC9nms9S8ZPYIBZGl5Q8fxVOJDFShVy1hcf1dh4zqiqr8afqQPu9mH5aFd2jRjpI0VuiuN3Fx7GfQrAHkj5c7EiTyKv8NS49PdnkyVKoQIvUREurSIokDBxPtHoia+xoIelA34h+fhykc59GfIoBE5C96hUwsHNGFksYgcp5PoQqYlz3mAGr1jq/nXJae0f9AqjRLyFFrQVz/U+TyZglK4/vdRHwZxutzQu27IThxH9q18d//jdwYUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HbWKboD99E3jpvqxT8LmzTS86iLG2aPdwE9Aek8Rvo4=;
 b=HIYtYQTmKUpscTO4VdMADVnP5H07sz969ssuAQtXko8aDiuAHop9PU9bQZPrG6DgZz0LaYQGO29ydpGbQq5rzJH98oNDO7XnM+RFNr5MLf6ZgBvse88XyaRsBD5hvxbdbRguop4MxdQ336PfdsyNEWuDKdxE44QtMdq1oF9exXX2pE1GKNyywNZUULSyM2JiAwR/ffFyadY7zQHqRGiZnt8IxYPAb9LNfax7sSkMKEN7EMtY3HQrqskAU97TSRR6igp3UNLZvi6sdBCEmp92SZKFJzPV7eW3M0bX7y9NNcghqsQhD8z3Ln6+7tKbaMobEwwGrKRBE5KEgUqfo8hrEw==
Received: from DM6PR17CA0020.namprd17.prod.outlook.com (2603:10b6:5:1b3::33)
 by SJ0PR12MB6709.namprd12.prod.outlook.com (2603:10b6:a03:44a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24; Thu, 25 Jan
 2024 16:25:49 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:5:1b3:cafe::fa) by DM6PR17CA0020.outlook.office365.com
 (2603:10b6:5:1b3::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Thu, 25 Jan 2024 16:25:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.81) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.16 via Frontend Transport; Thu, 25 Jan 2024 16:25:48 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 25 Jan
 2024 08:25:37 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 25 Jan 2024 08:25:37 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport;
 Thu, 25 Jan 2024 08:25:36 -0800
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, "Avihai
 Horon" <avihaih@nvidia.com>
Subject: [PATCH 04/17] migration/multifd: Set p->running = true in the right
 place
Date: Thu, 25 Jan 2024 18:25:15 +0200
Message-ID: <20240125162528.7552-5-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20240125162528.7552-1-avihaih@nvidia.com>
References: <20240125162528.7552-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|SJ0PR12MB6709:EE_
X-MS-Office365-Filtering-Correlation-Id: aa8c39c9-0ef6-4d04-d70b-08dc1dc24a59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q+CaRrq/W6KTig7KdgPE5JT3byGMyZXWNrsAel5RD/OV2w7QK7Kkv8A67S1qm4bPomuKL5o3A4VwFySwmj8ihL8j0YCqDfVklvG6PrZZ728rJjLqWUAiWlH0njq9Td6Of/E9SR7aLr1c+l11//d3FWzVjbX4N7vYymD4JJjOUejNn3ZN5aVYGLKr8pfIAwQD7xb+pFZMN/3XCQhFOTiY12Hepo2BwILiRAFhz7btVOEyQ2UveBftqpqUEEOYT3kJTzNWx6VoCVnrss7mnlf7Jj2GIyxlQxjNYqfFuytQh2xbT3sk+LmS5prBSjwpyOj69vwAsTRKh7PlW8QGkfHzxV4fH9fGF4q1KPnh3bKi5a2FtReGwR3Il+Wy1F0O03DDmVvHR7MVFnL2Q7eM+Pv7AB6NOTJBPjuy38qU/Ybg9oO2TY9L0WyTlccn/EFfljgs2VkohaIcWtGCkcu6KEj1VpJM5GmYCLuEewvxIT4fhxPWUfU/mR/gzl573HlOARTTBNtM7J4r+I8OTGSrzf1PQSV2pj9wR9gDEsGaEfPjK6HivE+P9657/zpdLSABk6lpNbMwu7JwvCoviR6zzynDc+kzreNiIlFyHB4gvfBItzsDBa0fIq+HwdPWsBha4euuDNDlcg9uljen5ASTs9Ht1OmPqhpODnToTPNWoTrEeOXImQzCZm2XoMui2R3I9nU9P9d2qRMpDRN16MhZ1axmRNFLJMkGnchSTQH+RrClmYB54514oTGm8QiOhRg3BiQW
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(451199024)(1800799012)(82310400011)(64100799003)(186009)(36840700001)(40470700004)(46966006)(41300700001)(40460700003)(83380400001)(2616005)(26005)(47076005)(107886003)(1076003)(426003)(336012)(82740400003)(36860700001)(7636003)(2906002)(4326008)(6916009)(5660300002)(8936002)(8676002)(70206006)(7696005)(6666004)(478600001)(54906003)(316002)(70586007)(36756003)(356005)(86362001)(40480700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 16:25:48.6936 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa8c39c9-0ef6-4d04-d70b-08dc1dc24a59
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6709
Received-SPF: softfail client-ip=2a01:111:f403:200a::601;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
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

The commit in the fixes line moved multifd thread creation to a
different location, but forgot to move the p->running = true assignment
as well. Thus, p->running is set to true before multifd thread is
actually created.

p->running is used in multifd_save_cleanup() to decide whether to join
the multifd thread or not.

With TLS, an error in multifd_tls_channel_connect() can lead to a
segmentation fault because p->running is true but p->thread is never
initialized, so multifd_save_cleanup() tries to join an uninitialized
thread.

Fix it by moving p->running = true assignment right after multifd thread
creation. Also move qio_channel_set_delay() to there, as this is where
it used to be originally.

Fixes: 29647140157a ("migration/tls: add support for multifd tls-handshake")
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 migration/multifd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 25cbc6dc6b..564e911b6c 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -850,11 +850,13 @@ static bool multifd_channel_connect(MultiFDSendParams *p,
         return multifd_tls_channel_connect(p, ioc, errp);
     }
 
+    qio_channel_set_delay(ioc, false);
     migration_ioc_register_yank(ioc);
     p->registered_yank = true;
     p->c = ioc;
     qemu_thread_create(&p->thread, p->name, multifd_send_thread, p,
                        QEMU_THREAD_JOINABLE);
+    p->running = true;
     return true;
 }
 
@@ -883,8 +885,6 @@ static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
 
     trace_multifd_new_send_channel_async(p->id);
     if (!qio_task_propagate_error(task, &local_err)) {
-        qio_channel_set_delay(ioc, false);
-        p->running = true;
         if (multifd_channel_connect(p, ioc, &local_err)) {
             return;
         }
-- 
2.26.3


