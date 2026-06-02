Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D7ABCD6E4A
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 09:28:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wULQJ-0006sU-AJ; Tue, 02 Jun 2026 05:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wULQ7-0006cy-DH
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 05:28:25 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wULQ0-0004Lt-A5
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 05:28:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=abu+1dFF7Hw3Y/SX1ULKrZDTuz7Ihl/L4A/58avsDmZhndWFU2zVC7DTnh0HR/Vmji+34CvxkMX63F5C6hyagukDOB6hzrZ7FCL9q3Hhnei2KI4lYKsc65mVcAcbjuZXqV0jrSeyYoP12nyfKWODlyrk3lvX52Fe1Uz7AYdP8IhEs2M8JmX1cAjPdphx3+LJUMRSnLBqa5A7rT56cpfueaWm/QE4lcxJguftza5l0A1UD1vN7ypC83S1ci/Pw6PgPilcH8LQYsM5a941L6JWU2kTTf8tcGQqk+pezP2TbwenEDijf5PbEOfy7UGPCBOAL6hObKRH7ek4VxJIisNxQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAPf6ypRI91bWzxqxMgh6cVCnam81mpqg/BkfFaWtas=;
 b=x+imQyjgVZmbbEH4ZQlNDiRfYw9CiQyg+7hlU+MV1IrWx1GhlWse93coVoUERXg7QDTXSzOJmcAt3DMKbj8Iuu93bU0Y1RKW+8RTMQ3+9Id3jrcASvhMGux+4zXmFtwXLe+xPq5wkszRAcSUkP8B5ptdWsht1DrthS715we4h3J/ZNQc960Vjcj0cdPnbt3DbhuNV+dXcycaz5tWvnLmYwcHcImja6WHovh+Ktw2AOuOtu+AGEfEQfnz6sMIfaAvVs+fgbQgnP2I/s5fWw6iSaK6fj27QHB7KRcwmrBAq++Ag69+0nNwd2HLqzoswKMDC9DzHkwvqf3+oVl8JUE9Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAPf6ypRI91bWzxqxMgh6cVCnam81mpqg/BkfFaWtas=;
 b=PYru4trsxyc2OL3WQXGD6S9MR8iglRgTDV09WrNKPgUCFdxsaPeDLObyGn2v/P5Tt1c9rbZjPYZc/0cNKZom+gMgpV+P1w7AkswEvxUiMRVyHkyalerTV95o7By/d/IUP5qrP5tClbnLUP7BWP7fGiKYrsJGeJzaB8vnet7yww+AFxFxoV6l0EgdAQD0mFESQY70R6eFt1kIVWHMzO161337MvKzOJcrwJQB/6U7Kx4KN/3B0mmbcwaBzel0bng69TLPavgkyU11FsgzGtQjSFx2yxYcU8BaIignkm5KSTFzy06Iq3dJ9ADkIssjvkNVO8HjDZ4TG7JrsLoDbhotHg==
Received: from CH0PR03CA0271.namprd03.prod.outlook.com (2603:10b6:610:e6::6)
 by LV2PR12MB5896.namprd12.prod.outlook.com (2603:10b6:408:172::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 09:28:09 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:e6:cafe::54) by CH0PR03CA0271.outlook.office365.com
 (2603:10b6:610:e6::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Tue, 2
 Jun 2026 09:28:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 09:28:08 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 2 Jun
 2026 02:27:52 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 2 Jun
 2026 02:27:52 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 2 Jun
 2026 02:27:46 -0700
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
Subject: [PATCH v2 13/13] migration: Enable new switchover-ack
Date: Tue, 2 Jun 2026 12:26:21 +0300
Message-ID: <20260602092621.382-14-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20260602092621.382-1-avihaih@nvidia.com>
References: <20260602092621.382-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|LV2PR12MB5896:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b9a00ce-51e8-44d9-6b1c-08dec089423a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|36860700016|82310400026|1800799024|56012099006|11063799006|3023799007|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: wCo9XQg+Pkk0Urzsx8rClsIbpuzKaVQIas1YYXiBTSFhwEs/WMlxv31p3ehgsVxR+Vqu4Cc8XhYoI705VSFVHIfImEcluQxW3rTKlSc++Jn4Na8tT2J5r0a5uVATCcW06BTxb2h+rBX/Qzq8ZaXADCTxqhdj/hMrcu9VApe7nqrhbdyavp6iE1aa4mqkf9DgcBG9iZuuRcRJ1Y3kdV0oLtwWX297x223ByRNNQIK3N5Df2Fm2wvCLi/ZKYEyTi2Zb1d++bfW/JjjunhRMMC9LWOFIokyV9qrOEurj0jkugNx1ZSr57oLCKz0On9QqhoBEjLODP1yLQZPt7xrQ7s2O9G55GHAm2uk7rx98AdUKT7FqruUM6K/QhcxPPHCsEmUs4du5Lg80i4ZABN1ibDLn32wl6VVyjekGAfzP/YicEI1MY/tLWXKg9NCVD0GrDEvWOJ2aY1f0RMqXwaMWBdhyAj5XtPdjGJi1HrEbdZ6GRm4WOllKjUxcOwKLbxSxTJQkhhtpLvOJCmi7/YC8EnhGktNktvrh7BqAHxMHrRjpkqUncBg4veau/YoJZFUQOWbpVVllVp6agASFogRy7nVWHk8VUSdHGBEqXhUb+8B4PBQo1QFNcbJWYYPzHYVZ30ef4OnM2WavAbHH+td2DNEmN1ffZite2Iv3/smzmDmezxOW8dWjG7X9IbILS3y/1ESq1Fl3vNpO2WoueQnUWWXlMu8UqIW/Aw8Bt1HMfKleUA=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(36860700016)(82310400026)(1800799024)(56012099006)(11063799006)(3023799007)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TayJ5pG8ipoDmF1TZ94wWOzPkZpJz4j4nmb/obEU+5KliDh0iJk/QF/sNZSY44Hnp2C48r9Z4ggXJFW1X73TBCunby9/advneShExJ7FIpyzY/ZyQmUUGomHDbT4GkLjek+yWmxvIK4/FYZ5pUN/vq8/m2ZS4PvxFv7rccL/iBRzXVL+229I0UPdwy3ofZBVpPNAwbhCw+JtLgW4oHhY37mAI0OJPrpR8RsM0lLr7RQixboaaJ8fUGvcb7jgVBLS64S+LNiVUSqcDRGkCQ0HWPQQead0JLQXf1b8SSYfswesyijlGOEVhbaFyAkLJVs+s06mE+ajs/QJPB4Wg8JitWujjczgApRiG6UHfVo53Gtgh+xkLFEw2UnDDbzzWvBs7UlStoJqHq8ttzRv89dB5o1tAJ8pSGpK9B4634vhQep9GzW6ND9A+uTOIYoMp8uY
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 09:28:08.5811 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b9a00ce-51e8-44d9-6b1c-08dec089423a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5896
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=avihaih@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
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


