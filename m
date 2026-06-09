Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5A7ECD8C85
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 08:02:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWrPL-0006F7-JK; Tue, 09 Jun 2026 04:01:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wWrPJ-00065W-0n
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 04:01:57 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wWrPH-0005AB-9l
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 04:01:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=niMZAsnhM6ubQ7zMhBCoPQ9cJ+lur0CzIr2fVpSLQa3llROnOBfuqUCnMBaxOlUg9JD4wqlvgMgI29jFm4easJKGAfGAw081W7hk/mMhv7Kb0gkYguADUeWcF5Wo9DZ4MIc4ybZ/9c26jaq6txLE1aUPDz4SlDMoB94MIbiSuVNx5JKlCNNwOPHeaQtb7pl0qk2AOo+mIpssPc3182dqTC+ySDPXBADYe8Qi/ztED8Ft2RyAKxc2jb3slV8Ly4g4JQDjKetJXTqTvJvIE7quYjM4G4TwqurkLxIW023TyZ1NxkgQJ6/NuqYZD/ZueO+1ZlDieE2bgegRQpbVg7nZvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAPf6ypRI91bWzxqxMgh6cVCnam81mpqg/BkfFaWtas=;
 b=PXFb2YzzZIYSdpkHKbanhfYGFuweAVl8MG9oq9SRnDg7uVC2BemdSkA2FKOGbZetA4FyHeFMfwq2kC5U9+PQs5Yfv+Bj+93ae6t6KPBf4+PZa2Xbjslmx3KTw66/yyZUm9bJHEruheqmDL11XL/KiY9RvLDpq0h12Fbg37OUNnVC6H0KvobiiuXl3DtBbxJWdkfcmxKdiFHl5ChEm/SlDtXfAplN72fZf4DzH1Bysx/C3f972OegfWBcK2mEm5tmQ6MB7VyQjm4REG7i1B5ULvm9BAW2LIWQ9U7Pnek/R5QlNyKSFNjK7iMU+hKBxbUoIypR8maat1IRI/dAN7nPhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAPf6ypRI91bWzxqxMgh6cVCnam81mpqg/BkfFaWtas=;
 b=tb/Tg0gqj0uuk58ktD6AOO2CRT3+ns2YGkIOUMpJopXrLZYXsAat6E+zYAfpiBSTEam0OGn3VrrSEaInZkNgXiSBZ1ybr1F7FqXHiFvGIZ6xEveALoanUaZ8KXGkl+K5ULc+06sXCQQxpDWSPqIcmixcEhjEsaNVf2VXNCWfffLFZl3qqbVwDX2s+rg20wkVQBL66u4TM0iD5tTtixFi02GV411p+S48UP4WG0ukpm3KUmmWH2Y1ckxcf6dD0GtxVGxDYSWkhzkNzxxonTAlT96LfJWaPV0ufqY0V5VryTeh/Zh+6kGDPdWL+sem8OF2eG51BA7oxTRWY6WbtfR50Q==
Received: from MN2PR14CA0009.namprd14.prod.outlook.com (2603:10b6:208:23e::14)
 by CH2PR12MB4086.namprd12.prod.outlook.com (2603:10b6:610:7c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Tue, 9 Jun 2026
 08:01:46 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:208:23e:cafe::47) by MN2PR14CA0009.outlook.office365.com
 (2603:10b6:208:23e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.13 via Frontend Transport; Tue, 9
 Jun 2026 08:01:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 08:01:45 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 01:01:26 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 01:01:26 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 9 Jun
 2026 01:01:20 -0700
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
 <maorg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH v3 14/14] migration: Enable new switchover-ack
Date: Tue, 9 Jun 2026 10:58:12 +0300
Message-ID: <20260609075812.32067-15-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20260609075812.32067-1-avihaih@nvidia.com>
References: <20260609075812.32067-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|CH2PR12MB4086:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c722148-d0b8-4943-05a2-08dec5fd59f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|36860700016|82310400026|376014|1800799024|56012099006|22082099003|18002099003|11063799006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: NkOl9eUCbua+j7klemdWUWhz7W8P9LEIf5ZBbyEeyZvPcHaGL+GDOckk4HYJozjWjuLMFEQ+58V8/nV5yFX0J+scvgN+/fd4DqQaOrGhSMKLomB7KRbvMu5M9YeaaE1h2QLxmEjBX4fnRGBFddguPzPqIUVy4GSOerTvIu/WPxwfqUPQRkkazvoZPbrk6hcWX10GZxeM9Or3bOaDpopMkPoRwiNxwdRjLi/OJ1l4rLpI/BGy8lUX60JLgMJfTuOe8PmLzy/IaVEoFxt290mpRqyTUSinHt/QJebeAKUJatL2HLYt2zK86/TYWrJ9Jqr7/dg+orqvONC2WQT0v8CeOteAyZ0y7xwi5CmexVbxLerBSiWv7L1EnerYWo5MGZina234A+GQ548ULpL3cPYegO9A+g2DcvfqFRz6QfQDjvakC8y5N6iVnCMEWRHv1BkvldjnB4N5JWgustuikKvA3M1xYXFYO/RhOvhoBlEyX7/4Cunki//rhG1o0w+5JX8XhbTyh1aXsZf7TAz9y1M33PuoKY0974hF9hZpO1Mrog7BRLfdhsV/coSJlIgmOTWJOy+DpzMVse0JmwkBFIx0Rge2IHegF/0FZHPBKyxzNE0Vd/aZ3JsRFm0RJov6A7r3TLRAL5Sb9M1A7faocn0n0Ie+kk907CmknQPLhEZ57dqnznDlXkQ61TEcW0F2ceCgUnRFIPa5BVEkdbllqGG3yV+pRJq26JsYMaUvPYB9KPQ=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(36860700016)(82310400026)(376014)(1800799024)(56012099006)(22082099003)(18002099003)(11063799006)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CbwuH35zHpgmmOYK9nLWrulQInj49rX+Gy+CFBHmfS8lstko7k8aGr9us2nIQGFg1EuAzTrbYxt7ucZEs5TeUJf5lob+DsM2o5oqlj0lWjOAadSyGMBYt6oxfpB/kN/pph5i8Qk8hN2e958BVG0RDWW05HAP2WzmIzDPHWkwxzP1RV2ROgnxynN8ezhf30o2FvvNqfnd4k1STMxk0tQ77eD8OzkqNHRmQjxMTFw/9UXOjpBMvvRxmzFIrwtcj40uHEbGvaFZ3X9QhRbUnuob0ykumlKPe0Lv2Ux4WeM/1/arirnJrT+Z0W+N/PcsX09UCvkivH42qbYZ4ACWYLeE4dnXnsqWtK3Aj5J3J+Rg7Njf/z7CAS7AVpnkr88Fzyzoonnpa8PW/MKhwqpI5NvjsNIuR6Xd4ZMW3VtOg6VY62+3Z/IIu8EYcy0I4YHY/21F
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 08:01:45.7614 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c722148-d0b8-4943-05a2-08dec5fd59f1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4086
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=avihaih@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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

Now that VFIO has implemented new switchover-ack, enable it.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 migration/options.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

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


