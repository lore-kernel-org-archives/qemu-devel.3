Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C21CDB476
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 10:14:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbbf4-00043f-4D; Mon, 22 Jun 2026 06:13:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wbbf2-00043U-Ot
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 06:13:48 -0400
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wbbf1-00068D-78
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 06:13:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uxaHy2umHutwu3c2IL5SXU2YJBAJpc/aIE0I1RYzp0Y142KOxptLiIVlIQe7bLATOoKQhGC/wuxKGIc45N0cMCje5wKi9J8jEfbf9yiODqe4zcsTdYUBj6LY+75UBbF3Azvtgcoeyp/06t6GVrfXA5LZWRVoOdZNQDkmlBOhSwwhXImbkB35To+quHegf0cNNysZ9Clp97KhMmTipnzjs2hYXOBlR1GxpzKClvFYMsy7F4p0lXM7PTzx7V98Q9VUUylKpInGVemtDSITziTnqaMNxw8P/BP8AGf4gwqBHzWlQHaYrY0p3A/9ZQR7Bh9k6GROykNQd2DAbqKU6jLQug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZMNak4tdcCszbtnBhr/DA41TL3mxWYr4VaPrW6RzfmM=;
 b=eGUxHY5iWZfSkmYwHEMg85BBd1+86bG/0m/uDL3HHUwMUNeGtMWPL0TRbxTdx3l3H47ix5cty4qgzqbSEDLIqrhq0lYRBuN2JzJ4TPdEN0jhtZnfQUkCVrLIbGJuHjyVxnpEgC9zt5SI3foVIRPcrCKzvzUuqqmWQpAeR8xtD7EKPR+0b8m5hqSd9LcTCG3tAwZihj4EQMISMeyQUPR9YtAsve/lidt9phb4u1kZAsRHzlQVAs0KSL8W2dJb/piii4CeFPPizaJfauwsVITuVRRwLoJbWdvcKPU2imLzOBC2C1C9AoXO9aJyDNnCSaF9DGZ8ayMFU1WwB25o2zTtyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMNak4tdcCszbtnBhr/DA41TL3mxWYr4VaPrW6RzfmM=;
 b=EeRfjgZxcCs/0Y+aA78TNmZQH31WA5+N6CxP7w6lgS5nLsrettNPknZ8p1cy2SzUlRDGpAKnylQkFxCkPVEOsHlzJc2clqwEbd+5kZzKxo5NFwLEufT2lqdf2d2DnvqfbAgUO6LZnt1Ca4m2B7+cgIB/6p3+pKpGUd9C/XVHjEMddGWTjhN42mEY9LlH8mZ/Wa+65BMJi7oQq19c57OiUA3gUesAN6pmeZmhix+RA1kZAgPuKziFHSDp7OHvDVYjc15eYlCitWoAoDc010HzYyyQlJcpA2vBfwSyJxKfWKJ9PDu15ZtLym6hrFbSC3c/kHInnLA1A9y1KiAghlavuw==
Received: from DS1P221CA0012.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:451::14) by
 DS2PR12MB9751.namprd12.prod.outlook.com (2603:10b6:8:2ad::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.11; Mon, 22 Jun 2026 10:13:41 +0000
Received: from DM2PEPF00003FC4.namprd04.prod.outlook.com
 (2603:10b6:8:451:cafe::7e) by DS1P221CA0012.outlook.office365.com
 (2603:10b6:8:451::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.16 via Frontend Transport; Mon,
 22 Jun 2026 10:13:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM2PEPF00003FC4.mail.protection.outlook.com (10.167.23.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 10:13:41 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Jun
 2026 03:13:26 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Jun
 2026 03:13:25 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 22
 Jun 2026 03:13:19 -0700
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
Subject: [PATCH v4 02/14] migration/ram: Use migration_bitmap_sync_precopy()
 for postcopy discard
Date: Mon, 22 Jun 2026 13:12:02 +0300
Message-ID: <20260622101214.25770-3-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20260622101214.25770-1-avihaih@nvidia.com>
References: <20260622101214.25770-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC4:EE_|DS2PR12MB9751:EE_
X-MS-Office365-Filtering-Correlation-Id: 8699e0ca-68ee-4935-35f5-08ded046ef36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|7416014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: bJU3iKonOeVREJ9+tyY6QYhLf4DdI8DB+2dDKu9AEp2H4HHDuiJSoCoKXW7utnz5GzUix0lBSLKSUIgWwj7PqxGDYxg1CmIS7WjpEnmLoEXh3d0qQq5NZpvm59Ugi0FFi69Q686I47AKcHJndCrnY+WXYZuj51eoCJ9dYswmYC1qaDKAjQkfdNfM66NRGMBaKAh9yDQYXGkCqGbu3msJ2dSoltUOljvZbqZA1+yUTliRDzjgTCl2EDcATWtHOnFMb01iJ73LQ8Vp4duu6w+SSKmjPPyWa6TxFwGG+uPbRp4xD8ihZpMU+9mkCUy33x4Hi4a2LlL/U2AgzWrKN8Epkdkvbid7+McjxQ0h5mWMpIERzIlMSAkVBYVDcozxpYU6qpBI9nfhCRliiegnCsq/rjDv+aKTsQDkWMKEh8cOseTZTMMrGqlM5/YC+TnpWYITrYQqfTK1f9trw5zj4nbT2hUqK2IILDs2hpG9qWxFrrcej5QeVRiPiX+UnSSPriOSMppRkRbGxJOXQHO2di0nMX/UbvARJDAeJTUCzh1if8REpm4E8I9chu83PPr+MDLkYokWahmNfqDtedYpCdhjJsBAOdypLZUUSczTqnlfUl+tllXvC5QnMgciwJwujK7/cRX390WDm1lhxmDg7oBmSZLijvFshrmOAr8YNvzJngq1JS7ithVrVPNDUvSVnAhIhe/0NulbSbkCzbdg3+5S+g==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(7416014)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wroDepG23VXGKJUC2zIXtC0Lhqum17kX7ssciNBfVKr8o5uq+HBZi2apwAQVE4e02ew6GGhQiM4O3j1o1qrLxIkiJVBUkLqj9DiaxC7WHCmt0r548B5FvpYPHEYX76sGj04Zxe6m9SFGDF2koWqID9feIZph7JIwxY2r0Znnt4GKiLGx9gAUmyfPGmdbYoWDawMM7MDRZeNjvm9ZLA+4n/8QLOHONyjgb3kSIztYYIiYdmMgXf3TuXPHKwqSElQ+fjsg7F2vtc5oxUAqeJa3h0PUKqNJhPpZ96kg0vWmV2Sgm3bhrlSA/BS9Wtr/jZFUg9Ep6XvU665IBu68K8RtHeru11zyTb91e8kq+7V22KRv4hYnbYdBEFPUoGD0KpeNxyX/mR/OSjfzd4qsHj6QxnoOvGVVNXt6ZX2zlWAS8GLxLK7+4nitnfnQDVlRBu/1
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 10:13:41.1331 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8699e0ca-68ee-4935-35f5-08ded046ef36
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9751
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=avihaih@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
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

Reviewed-by: Peter Xu <peterx@redhat.com>
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


