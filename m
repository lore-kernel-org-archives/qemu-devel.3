Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F32CD8CAD
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 08:00:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWrND-0001wE-Dh; Tue, 09 Jun 2026 03:59:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wWrNC-0001w6-GF
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 03:59:46 -0400
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wWrNA-0003Vg-SG
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 03:59:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NeEPXIrHF8YFV5qQK/Uvs+yLlD9reed02eyr3cY2L/nPyMe7a1F8RCj9wFgLtLamf6EAHwe5G26jFdH2/zDM8iqWoowAPw69+NRFMgn20pQeYU1aFPQlliBvylJlZGCD7pAc4hoDmOcbSVVClo9EKqLB2ffTZnjZRJol7LPWm1jEsj5/OFB+bZX5o7PCaPLYsMAmAXwpSLxbrKs3/u3Ul3Bkb9qp1X0fZDSgdQ9CNEosyRbZbFFQ3+R0VRUzFxCa1giN80bep4gA5AsNCOr/uuCpK4UqanWyx6XV6QUBfm2o7Dsab0ltiVLVPo4gSr/E29zKGBpvzYsMdaMjbc3puQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cTJ+28Aey7GgxxE7luuxNI/z/lA62dD9O8waK5z3Mnc=;
 b=u8p69bSSjwuHKKq9wPhKRtjufPJnXl2ff5U6RCznoUbSaYV2sJFkCLIblDDGbwGrIG/94V2URLHspGLaaerx/R8y6ar4YDSi/GK9h7bfHjORCaWfbZcEryW4sViETlJYyXAXUrz4aSTqGh0FOS94lQBxnPJO3zNoQ0sKfKtK6GgBLw8FFzjE3MbPUcDBFQngrhr+hR4vOIiRRSV7H3DhHKg091gubdfirUcX982/cYowmlGNGWT1ggTRxdZ8QvPM1uPplvWZpaLZv8fDw2D3xKipME8eqsNRKKQ4bbE27IYJx1JW5PEVkp0AcFXUhfCJBKJAYNgD3WhPU+a0lCNvrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cTJ+28Aey7GgxxE7luuxNI/z/lA62dD9O8waK5z3Mnc=;
 b=T3ClEUqoh0bWNOdHOgzIN7WDMyPDaEou+vtskXpFf+2cxpyjIhu9LnLjNEbEPAd4oExFHrhv/6CVlKg8QZd1dqe+13N/whivm2wTPA2qRRqlQclfckkJqCbVQehfO3PfGA5wy4dBVNoqpTlFEcpQSWoeN/LOPEQ2nzYz/ci6PBwNTUHLXtA9KWclH2+DTvChtYKwDXL4/0OttyPLqsbcvAFjiaUG2TRfeH6LmD4uErezWFCxlmDRrSXWG6LZpGoZ0RfXIf+CAYfZlO+BSql4FC0fdg4QLl7inB4N9fQANXu9NnOR5fiSQVyTcJcEsoOXpmAqz8wSaD409Huelo77gQ==
Received: from MN2PR14CA0001.namprd14.prod.outlook.com (2603:10b6:208:23e::6)
 by MW3PR12MB4476.namprd12.prod.outlook.com (2603:10b6:303:2d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 07:59:38 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:208:23e:cafe::2f) by MN2PR14CA0001.outlook.office365.com
 (2603:10b6:208:23e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.15 via Frontend Transport; Tue, 9
 Jun 2026 07:59:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 07:59:37 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 00:59:20 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 00:59:19 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 9 Jun
 2026 00:59:13 -0700
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
 <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>, Maor Gottlieb
 <maorg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>, Gavin Shan
 <gshan@redhat.com>, Wei Wang <wei.w.wang@intel.com>
Subject: [PATCH v3 02/14] migration/ram: Use migration_bitmap_sync_precopy()
 for postcopy discard
Date: Tue, 9 Jun 2026 10:58:00 +0300
Message-ID: <20260609075812.32067-3-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20260609075812.32067-1-avihaih@nvidia.com>
References: <20260609075812.32067-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|MW3PR12MB4476:EE_
X-MS-Office365-Filtering-Correlation-Id: 192ef29d-d063-444d-1be2-08dec5fd0db1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|7416014|376014|1800799024|82310400026|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: zaMzxon7gouxoPh9XdP5mOsNVUW3cB3QvrwM92uROq/iZHI27UKnvfaPd+2y06nTTNatbCBsh0jVbfolxcSfAJEy2APMkjKHeodjMAir+9tK+n45t4+nHCVNCI4jgde4zQsdvl6wQH3q+ZEgdMxwrrpfuuYfrXxZ/nU8tWWMfzETXuSPBZDieAzpkIweJ4eMhLph8rErgxgF0rCJOezXu/BOcZW0NacyL4h/eYPOm5j4cQVHnJFUQfX0kMConhZbvh3sUeQE2DkR9yH7UKCuMULM2Ryb0Dg/KIkiHs8jIfOgkm6eA1QltVzop2yCSI5yJtaoDF2I+1nP57SU/se8XH5gtIJEcnBc6JD0Gh+Uj9p0CO7H20k/Gs3jteflVGnHaO0mdI2f7F7woySkJoc1nZ6esgvITIDK+/1AycidGHpbCvKaI6x8YtqnwjAstfX3t+jXza2HvG4DWyaGfuz0yhdUkETgU+Io+N2mjiU7+UKSrjv6DAEGt8WJep4uyM/7awuJco+c6sdQFilMmcAjl/qJP2lgZm3PTQoVJ97p0yTVXa+AgQ2VM6dU0LeVFyXWLjLoJFHSBGMFyhfbhfrPpzzEsxxheqD89o2wJtybj9WXKEFOxBsxPErfFqEG/Ly41XgJj/vNOtKAnbTE8Dskoq+MdBSFd5hZ75MwG0CEI1ZCGpXsgP6UJqgZXsMOxySw1kuvSDdExLVCxw4zL78tTOXKRknmnphv5LYoU4XIrns=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(7416014)(376014)(1800799024)(82310400026)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: w7fB4ESsJj69SonogTL+1iRJNNLvJbFduBk6dgVO21d7N/eI6+GaJuv/hYeIQkis5m4+2nXn1/wVu9kqi7uiys4MC8Qn5rzgIQQ/l7rwIBDC5JMuNnf9POQ3IqbpZR1RwkyJEHueo3DmKCrfzfwfAWGp23DOCdz+GJ7tB/LSI3sdYDMVpshyjdD0Y5dbTs6Cbl4NUSgVYpKZOr67Gl+mKnDnAIJkwHEwgubeoS6/NEcRYv8BUCp2uacBO+BHiHJURp8pzPKvcTbi+kVLRARAtbarVQBeqSLeybcWBvgC0HrZj2P7D0XoArqxs0zHrwopQCCaxFqBxzfAHncABIe2YmIPWutMcyfvo9UNmZWHBytMHC/TKima/fo5alDalHkoIuLagjffpVxD5Gq+trWnKfqv+dtw/zc8zeZ+sF9rMP2FkyceFCsWFWbbthETbgcJ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 07:59:37.8288 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 192ef29d-d063-444d-1be2-08dec5fd0db1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4476
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=avihaih@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

ram_postcopy_send_discard_bitmap() performs the final RAM dirty bitmap
sync at postcopy switchover, before sending discard bitmap to the
destination. Unlike the precopy switchover path, it currently calls the
raw migration_bitmap_sync() helper and passes last_stage=false.

Postcopy switchover is also a stopped-VM final sync point, so use
migration_bitmap_sync_precopy(true). This keeps RAM final bitmap sync
handling consistent across precopy and postcopy switchover, including
the precopy bitmap-sync notifier wrapper. Current notifier users are
safe in postcopy: virtio-balloon free-page hinting already opts out when
postcopy-ram is enabled [1].

This prepares for moving the final sync out of RAM completion/discard
paths and into migration_switchover_start(), where the migration core
can run a final save_query_pending pass for all modules uniformly.

[1] fd51e54fa102 ("virtio-balloon: don't start free page hinting if postcopy is possible")

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 migration/ram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index fc38ffbf8a..d7b8cc61ea 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2684,7 +2684,7 @@ void ram_postcopy_send_discard_bitmap(MigrationState *ms)
     RCU_READ_LOCK_GUARD();
 
     /* This should be our last sync, the src is now paused */
-    migration_bitmap_sync(rs, false);
+    migration_bitmap_sync_precopy(true);
 
     /* Easiest way to make sure we don't resume in the middle of a host-page */
     rs->pss[RAM_CHANNEL_PRECOPY].last_sent_block = NULL;
-- 
2.40.1


