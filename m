Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D686CD6E57
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 09:28:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wULPR-0005zw-3B; Tue, 02 Jun 2026 05:27:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wULPM-0005ue-Tu
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 05:27:36 -0400
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wULPK-0004C1-Eo
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 05:27:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PvjiGuzFM8fld5znWyiE16nGw3owFbiyM0opvOZqlqOVzNnDCYXUR8pKWUssnvf8VIPpoeBuvwZaLST0TvOs8O8hXpgCZvPfD+Tv82+Dclqfg6mi5wkNLaVQpU/cQxjnN6zieF7GbLs9RZe2AHUbWFU5eSL4nHw+Uf3PPFC67yC5iTILzKjQhgicv7Q+yVGkvePfNyfmgVxF630TtvlC8z2w664XsyvnrV0WT8q/Jv6RCZzv5L1CXsWudcbjDtXVSrTWmmGPd4udwC6bHf/KxghN0QkGuOWJAGrAsyAnYjoPXSM9QYY6GZbwfSCDpzQe5ZZMJxL2EI2aporPFJKbqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VHGeQLARS16YmZjWWLS7sne17Yf4GC8ShnGAmlbOKV0=;
 b=VBVjpojbc5TflExGqoL+E6Px50BFLTe9Rl8ZPzyxJ24C297JHzRlt1GxpcazajCnFVinxJvtyKl1/vKOLC6q5+dKPhpizDTreqxjmxFU+Tg0nTLu7tvRmJcsqXm82Rv6w4TIoy2qH50ZgMI7jV+o05EYT7CPs9I8m+aIxMNjSaDABNQ7JUcIe1JWG9AKqqeA39cm7NVdeye2kzRYo6w/W++QY7/9f/yrZ7KRWpYHB2tQkoxR6xJRtpBM88lMzFQc0vB2TSkJ1u1S6akggbD8SFsaSQMuBpecNzjuCLscq2dtEywCOuWghrCXYV/9n4gn+RIcWJuqrle9lhH0+fDqkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VHGeQLARS16YmZjWWLS7sne17Yf4GC8ShnGAmlbOKV0=;
 b=CDzYJR0G0Hink7PoPs1++0T5/lg9ecM15DXjd0j2shiUvy0chgKWMXkMDei9zPIswhIVtfhlOnVmNCuSHsePSpNtnPLDaMMEfdq1Ra3b1VF3T3C+GNe/t3aYb0aLia5gFvGxFGE/Oomb0pqLt4DXLYsHRs0TL/Kl+vN4PG1dodMrY+ucIi+5vLsq9w83FEeZ8nsG+UltwZf3eBTaEVOdsNFRrkWgFzNIwhKRG3DQmx1N66K/iHsJORcoxse01Nu7q9mrt/r7Dcd9DxlkzsBFy1LtFEpgpj4DLDjTGY5Tmyxfen8Vs2trtVadjVwX+W1LYJsG8+Vtoguu5bLhsR1n1Q==
Received: from SA0PR11CA0201.namprd11.prod.outlook.com (2603:10b6:806:1bc::26)
 by IA0PR12MB9012.namprd12.prod.outlook.com (2603:10b6:208:485::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 09:27:29 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:1bc:cafe::82) by SA0PR11CA0201.outlook.office365.com
 (2603:10b6:806:1bc::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Tue, 2
 Jun 2026 09:27:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 09:27:29 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 2 Jun
 2026 02:27:14 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 2 Jun
 2026 02:27:13 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 2 Jun
 2026 02:27:07 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex@shazbot.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?=
 <clg@redhat.com>, Peter Xu <peterx@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Zhao Liu
 <zhao1.liu@intel.com>, Halil Pasic <pasic@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, Jason Herne
 <jjherne@linux.ibm.com>, Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 "Cornelia Huck" <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Vladimir Sementsov-Ogievskiy" <vsementsov@yandex-team.ru>, John Snow
 <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>, Maor Gottlieb
 <maorg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH v2 07/13] migration: Fail migration if switchover-ack is
 requested after switchover decision
Date: Tue, 2 Jun 2026 12:26:15 +0300
Message-ID: <20260602092621.382-8-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20260602092621.382-1-avihaih@nvidia.com>
References: <20260602092621.382-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|IA0PR12MB9012:EE_
X-MS-Office365-Filtering-Correlation-Id: e6529dcb-0fa7-4380-6c64-08dec0892ab0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|7416014|376014|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 3ZCdjb5Hl9q6da2kx5qly5zxLGSmUbWh4NHh/4PNZUWZ5TzucW83rHxc3uxYnCEEMgDHLj5lfaP7Q7HSKHmDancXosGjstmc5qkt3kQUgzR0OH2zzY+4T/AfHjilQc3/oynaiyN9McWZ+RiZOtj6dBG+GD+M1deYjafB8epV+0m8TdJMBlCXUsQKWWg8OKizvlygJBfdTEU10IDDAdHZ1IqhnKYKuoY2IpX+CIFkbAUvlZdAPMxxQlMluYUo+PDxvA2rNS2DPJnyQP674LIIVmcwVqUvjImfri6jozD9///L0LRB6x+jdwY0q6Dd75YOie/tdhHDDAdCtf7lAvjhldXcUfd0J4j91oFMj+2NddI9NA55KZ+wE9QXNkyWVEwZfmexIRN5wXrQRJ8WPZDwYSuAhXO/M23qtGe9QwirHRtkz4Jen25vhPmAOF+IpcXYhJ73UCVnn0CjFoCV3ZTFxPXh8AFagA5HrEEGdUQ+SKwsVq7pTQfuR49bz+EBmQMV/GDaSBuowzPtHRoJfliAzcOh2s3iX34ZSOIH/rskNoSrOHHQyOoZVnPK8gm1ufEDdL+G9CRw2ayN12XyzrGAak9yi3OLkDFP1SbE3RpQBu/8l7KR8rhnHwTf5oSP//MCHTdvmhq7wpJufbqwzf48FfMW0wamB4/hzrjaPrErOmMByvE/RIr1yNWBr8KZDjESmj5xxn23VSuN8Ak6pqh1KxwA86NZ6LQTsCByC75Rpa4=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(7416014)(376014)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hNX1ip+bkNtWKjL1OssBimqqTpsdeAqDwiNSZGdTEnaWQs/PeRIv+stpbVWeE70vMd0yMB6TmmguEQlcbAFdAOSyE1mvCGOervmIychb53ESfXOfCnNyltHuhP6v+IoNVfvp/RKzaRJLq9SSnCb9vfE1jeoO5DdhQWTocG1yIcF6NA9czmuV+pAqujgGculdCqAtXpjVN1+xP89w2TCRyXQvf8e9OgYjL6mihc2GVmMyNBqfg4LMunRkj7ghEeSM9AXCCS9HrHatCo+D4yhLp24LC6enksiMvtie6aIMb0AVrrZpS403wEgcw8uEOAPdI3G9etlf08UI27vO+GC0pBgnfRw6iZUAFJBOGAyW5tTKwbhsPOui+RGwi/jdYOvTLnN4+7smrzDsSsIdaSAoJJNOf/8ZNSS/fH8d4LHX2aXtxU+epvNZ43zdmhmk3/MB
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 09:27:29.1109 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6529dcb-0fa7-4380-6c64-08dec0892ab0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9012
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

Switchover ACK is checked only during precopy while the guest is still
running. The last migration_can_switchover() decision and guest stop are
not atomic, so a device may want to request another switchover ACK in
the gap after switchover decision has been made but before the guest is
stopped. Migration would then miss that request, which can increase
downtime.

Cover this case by failing the migration if a switchover-ack was
requested during that time.

Ideally, precopy iterations should be resumed in this case, however,
VFIO doesn't support going back to precopy after being stopped, so
implementing such logic would require non-trivial changes to the guest
start/stop flow. Given the above and that this case should be rare,
failing the migration seems reasonable.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 migration/migration.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index 4bb649a467..6ee1c795ff 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2810,6 +2810,27 @@ static bool migration_switchover_prepare(MigrationState *s)
     return s->state == MIGRATION_STATUS_DEVICE;
 }
 
+static bool migration_switchover_check_switchover_ack_pending(MigrationState *s,
+                                                              Error **errp)
+{
+    uint32_t pending_num;
+
+    if (!migrate_switchover_ack() || migrate_switchover_ack_legacy()) {
+        return true;
+    }
+
+    pending_num = qatomic_read(&s->switchover_ack_pending_num);
+    if (pending_num > 0) {
+        error_setg(errp,
+                   "Switchover ACK was requested by %" PRIu32
+                   " devices during switchover",
+                   pending_num);
+        return false;
+    }
+
+    return true;
+}
+
 static bool migration_switchover_start(MigrationState *s, Error **errp)
 {
     ERRP_GUARD();
@@ -2822,6 +2843,15 @@ static bool migration_switchover_start(MigrationState *s, Error **errp)
 
     qemu_savevm_query_pending_final(s, &pending);
 
+    /*
+     * Switchover-ack requests done after switchover decision, are not allowed.
+     * Fail the migration in this case since we currently don't support going
+     * back to precopy.
+     */
+    if (!migration_switchover_check_switchover_ack_pending(s, errp)) {
+        return false;
+    }
+
     /* Inactivate disks except in COLO */
     if (!migrate_colo()) {
         /*
-- 
2.40.1


