Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEFBCC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:56:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgf7Y-0003er-1p; Mon, 06 Jul 2026 04:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wgf7E-0003Jg-Sj
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:55:51 -0400
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wgf7D-0007WJ-Dq
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:55:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bB8+4GNoZcVElgO4U0yQnXWkRRzWQBpWre/Lt2vXuRiIIx5o0lCknUdf/66ojwK521vai9KRBNvQINBL4xqHApfrCI4BJUXy5d8lG/o+CtSvCjFJR93YLwGv988krlegi+V2ppT+okxq4o15vf6axxHBk/o7wytuEy9lu37gDAlyndPlXepR/LTVfP2pJ0NY+YNlYJlRsTlWO/QX6H9jaAN8hV+Cja3pMt3q9x1RLBtrD7N18GsgnJLoI9BCWmUUd+QIfk2ytL/LQv/buwgnV3cgZxbI+kSh1BD1qFAP68Ez3XQwewMmBxtZo8wTKXpCFEb2XMfRTUjRuwDQ9AeOyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=shhQk6VW+q3+v51VLMVK/BFdaJ49NT/fDvcxHJyTU9A=;
 b=ysrkKom3hYZnuLUZb6o1N5lctmBlTre2Wy1qI/FiKeBxKRI9liR3tRkcPI1SFCe3IqU3HzYr9aSYB+A8Ta38L+4GxGjm5hcaFj/QTdN+qdLxmZoGct1m21+cutGvl2NxUO5V8Ly58RRZ766DEAQz5D8iufqzd4XBlKvan7cITMcgknpdg326aS7GBrzxjjQSAeE+Enu0KffL6MXTSQPOZppNcgz0whM41oJOazT+nOnM5zOn+ZnEQXv7CcDEOV6E/DpRWTZE0Nv30tNb0j63W5lUOgkVG9eMysMV1qe3GJtBH3m4BWORSBY4rRkRyB+dKgpaw25+wEBKep9GgUqU1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shhQk6VW+q3+v51VLMVK/BFdaJ49NT/fDvcxHJyTU9A=;
 b=DDKbw2meI5US1PDlac4bL7KljCoqE9C+U2+ejS7+371KuC8/O+y3iidX6jsvFo5JfDxqhOfkDpPiHdYTO+rQl0EhyFBFH7KviuCKuNw4y48iMSyTc+XGONB0qEald21ZMo0fR/ARfRGE23IdHK/u4GIecEVJCsVe9yO5YvxxEXCxHLj4pdMNbWJGfVYt0/YMth6MpOpVAywa++42R1w8+nrzdcoboz86EtAxGPmubBB+tkNUEdVWyg0eR+pIOvyvym18PrsW0dFb51wpIVys7ImS/rrGySn1itrYEXqHOKlhgvkMr7GG5dndEOlGAw0np2zGE/1KMRFrbra5jV3pmA==
Received: from DS2PEPF00004568.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::50c) by SN7PR12MB7978.namprd12.prod.outlook.com
 (2603:10b6:806:34b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 08:55:39 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:2c:400:0:1001:0:9) by DS2PEPF00004568.outlook.office365.com
 (2603:10b6:f:fc00::50c) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Mon, 6
 Jul 2026 08:55:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 08:55:38 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Jul
 2026 01:55:23 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Jul
 2026 01:55:18 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 6 Jul
 2026 01:55:13 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex@shazbot.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?=
 <clg@redhat.com>, Peter Xu <peterx@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>, Zhao Liu
 <zhao1.liu@intel.com>, Halil Pasic <pasic@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, Jason Herne
 <jjherne@linux.ibm.com>, Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 "Cornelia Huck" <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Vladimir Sementsov-Ogievskiy" <vsementsov@yandex-team.ru>, John Snow
 <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>, Lukas Straub
 <lukasstraub2@web.de>, Maor Gottlieb <maorg@nvidia.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: [PATCH v5 14/16] migration: Enable new switchover-ack
Date: Mon, 6 Jul 2026 11:52:09 +0300
Message-ID: <20260706085211.13905-15-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20260706085211.13905-1-avihaih@nvidia.com>
References: <20260706085211.13905-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|SN7PR12MB7978:EE_
X-MS-Office365-Filtering-Correlation-Id: d098f37a-0216-42b2-5205-08dedb3c59e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|7416014|18002099003|22082099003|3023799007|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: uU6RfEO0tJTyKFycUz+UrEFkwpn3G9CvmKpPL40W3GObBlNh6/6iXosMcbzRRmYJGPXM/SIdAwRAp4mx5wIurUibkagM13Q/eNCHtd7qeni2Ps6Aml6nWE2qshrii5CjEPN5JyQ3kxaxJ1bm6UNB/fj7491fkjo20k0kalN8IxEbh3CT4XeqCduWDjFrpcTzSzsUnMbME8x1RrmwNPAVnnpXjZ5JRnU/rLiMajVauDonR7oW91J3AV3NjvaTxgWIee1nsXNqGg8fE2ngCKoQxwLfjsm1i34A3HW30wtt2KoQziLP3BadR1XzjIVNOI+bBCrmD2/X/SrSNrbUNYxAJGPKbeq/lMcHd77E/vL02Nqw9LhtxaecOsgZSr/nIgG4Of2IPp5XZr0tCTkelGEhCplZL/l4n83Ye6clPlD2mlqRPCcasReXKTxp5ENs8rmyi8xjMwlIn2e/0UN+jiDRiobxbX/fruJGNc60lYaucuKi79T29UZcrUjp3pjqxPgqvHtRYRQVXxwPOmWX3Z9sHOZPPReXRGKOZNMNEUl18j0JpXf+I0Fzff7BX4G7yLO8lreOn/xToHvkmJX6RlUdLSut6x6ZAzJfFQbFY1NXEEFHvcbFscFDUHRilRz/qlSchTpI7CoMd9srOwu6P3YjXkijtO5kuz/QIL0eyskyW0NMXI4VNzeC07tS5A879gHqtHSDDXp0bo1qnDZQ3pr4zQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(7416014)(18002099003)(22082099003)(3023799007)(11063799006)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jPpJc0EwxRwCjaBdki3VoipCFFA3x93N1vj7nGSIRwZFxObGvQVlMM0uAo4tWEKNGcxg/ofOQUqY16t2sS3dwCJt26ToEs1URr+1LWQXhKkXYcxVnS1UVLJHw4w+431MYS5IsnvQNikEd1aOnZnJRtuHghYtwHbhBeF8oAaWGItMEJWsNfboqB6nY6MhQqWDih3RbwKDuXDxpPIqwg1wEHRB9FCdy/kjlK6wdf/APMym/Dvu9oT5sWGE8L38HnOtZb/Ph41be9/tfjrV7ijsu6TrRr2fG7PDJo4KK/a/IWXrdBG03lyWLUNREKjVeBriC0FF1aTKL6OtE6cE8bEsK5PQj8Az0UYvxsiIfpm8aXMUfBjBmqvDe3FbURq1dBMPS8qgS+oukXrnbzBR9G41kysJZPHeYYC9D7zB4JknKvvrYcQcfFHCI9gvwOSjtgxz
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 08:55:38.4675 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d098f37a-0216-42b2-5205-08dedb3c59e9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7978
Received-SPF: permerror client-ip=2a01:111:f403:c007::2;
 envelope-from=avihaih@nvidia.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
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

Now that VFIO has implemented new switchover-ack, enable it for new
machines and keep legacy behavior for old machines.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 hw/core/machine.c   | 1 +
 migration/options.c | 3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 5b97df6db9..15886a56b1 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -48,6 +48,7 @@ GlobalProperty hw_compat_11_0[] = {
     { TYPE_ARM_SMMUV3, "ril", "on" },
     { TYPE_ARM_SMMUV3, "ssidsize", "0" },
     { TYPE_ARM_SMMUV3, "oas", "44" },
+    { "migration", "switchover-ack-legacy", "on" },
 };
 const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);
 
diff --git a/migration/options.c b/migration/options.c
index 4c9b25372e..dfce19405d 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -110,9 +110,8 @@ const Property migration_properties[] = {
                      preempt_pre_7_2, false),
     DEFINE_PROP_BOOL("multifd-clean-tls-termination", MigrationState,
                      multifd_clean_tls_termination, true),
-    /* Use legacy until VFIO implements new switchover-ack */
     DEFINE_PROP_BOOL("switchover-ack-legacy", MigrationState,
-                     switchover_ack_legacy, true),
+                     switchover_ack_legacy, false),
 
     /* Migration parameters */
     DEFINE_PROP_UINT8("x-throttle-trigger-threshold", MigrationState,
-- 
2.40.1


