Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 923E9C44500
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:55:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgf6f-0002OD-9l; Mon, 06 Jul 2026 04:55:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wgf6N-0001Za-Fx
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:55:01 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wgf6L-0007At-SC
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:54:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iFOM6dLZNIDJOLYR8lHKc1HAD763j7DDbRGnJcN9bAaH07ugu8J3ygNx3duyRPjpecaOGTMfhn9rCXOjTCEKV+T5eTpb4LS1cJo7I1lHB5l4aBISZnWq42Fc1zL1U8XI92Dj1jfi/c8Wq1W3ku7/35AktGQruZ3PcnTWHEE0ufQKB0kl3l1oAFzKRHvFrnAscTOEni+/cACZC3sZNwSS+K+WOt1g2iqvZS77Lmde6rq/NzNCDhC3TKBO0tSb3MxgazPPAn7CPC7bfNPjHOpVeUe++iA/hN+CnTZmpxML6cyoYhbSuPAUhTe8S6MIbpwnNZzfhjqKrQdaV4tBR1A1Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lqY9k4BSmOqLF52EfgXnt+HIYcLMRZC7le3cgtLmBT0=;
 b=XtcsgT/4G9P4QDCN3xR+xH3fctS7YkBnfiMsGkGZG8FsKoKIiNVaxwReREB8+xZFLIV/IqAGiMGmKasf830KTME7gD0mqPHZTQFptnRHA1oFgxtHwXfFkrkOgaurMGQaWBM4DeJp0hqvuw7LCWZrDyJVfmSbLR9mPKLrXFV0iRGP7vHEL/QMKYTov6rLH/bPsVzQCvaSYd7s9hdOxiFLCIusfbCfU2knQLcYUXldLJCSH/pFLNPnk/nkNnTmYh2xZLIkT3Uw36Nj/vhtkQqIn1yzwCmEUE6wimmqHSYROxMR6yZlxyIKILLheim738QOAieUOHozBo3oMQaUk80w7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqY9k4BSmOqLF52EfgXnt+HIYcLMRZC7le3cgtLmBT0=;
 b=T65U4MNtV/4KGxRbazpqBkzGF/Wmju8YQvbuzHASwbgJ9vlFWLo7qtHxNMTJDG4jG2Ydf0CqEf2+4bt5vPxY0K2efXz8MXaQc1WUTrFGrKS7WloqUKonv5/ZX5bgLytT16duECq70cd+9atDDVzsF9+BSEHJO5qu0yUvsHLaYsOD+18wKp71hUur8C0MU3OxIIGzsw2ZZN90zDK5NCwqNkEM/fiPiMBHOhfcH4nSfxVp0mH5wg2dBbNzF7nMWpIb1Akugmv+K8m+2ExtAVHNnTiZYfXVVvlb0IlJ5yUTDap+Kfn/Mkrlp38XB5jeIhSOQZAMquPn8uMI1LUAKECixg==
Received: from CH0PR03CA0401.namprd03.prod.outlook.com (2603:10b6:610:11b::35)
 by DS0PR12MB8453.namprd12.prod.outlook.com (2603:10b6:8:157::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Mon, 6 Jul
 2026 08:54:41 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::8) by CH0PR03CA0401.outlook.office365.com
 (2603:10b6:610:11b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Mon, 6
 Jul 2026 08:54:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 08:54:41 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Jul
 2026 01:54:29 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Jul
 2026 01:54:28 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 6 Jul
 2026 01:54:22 -0700
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
Subject: [PATCH v5 09/16] vfio/migration: Extract
 VFIO_MIG_FLAG_DEV_INIT_DATA_SENT sending to helper
Date: Mon, 6 Jul 2026 11:52:04 +0300
Message-ID: <20260706085211.13905-10-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20260706085211.13905-1-avihaih@nvidia.com>
References: <20260706085211.13905-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|DS0PR12MB8453:EE_
X-MS-Office365-Filtering-Correlation-Id: 957ac770-ec30-4c88-c3d3-08dedb3c37c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|7416014|376014|23010399003|1800799024|36860700016|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: xQJUxjh0PhUr/A28W7jTdxp5Zk3avtOrxK0fKtECNA6cMEGiJK67iLxAwdB7+s1NoyxSi5qxGYEVu6rfKhCOz3APJWbF1oliKgf0mTNZPh4QA0WkfBQgnS35lioPnCATAZxxYJqofJZEbk2JfdyKFhBw1jYmc2sYVRb84EPW8f7H6Ty8tfeJKQGl3wzZuVVKbj7IVpn/bzZi0qpbeWtjp48ojnRBFcGnGW8qBXoYjNq8qXnZmo+HlEXH1wjWTxun7bGwPEGfBt2zvzMxnPDV9YEZCNX37TZimemYBxv0sIf1MQUtd2SSx+4mEDchc5RtPAqGQpten8bYBBAgrMNXKqDy8KJlGuVUbROkN0BlV+b0w3v6TVc92qq2DKlc85Ldbd9bCX+9Ih27duFbzPfMrVCIvw0Dh8E3dKUbRNSEtA5v+uRby9SP3hOi2akr0u9x3tIOqiBu/D6dhWnhkRPLHuFFwm/vLy73T5za1r9X2UviWhodNMZ2xuqWWYswrUWENlW/s8DnmKs10T2Zx3fCleGkO4fR30Q/MGPIGBpi6ZARVDRHiPih/dlKjA/74RLajyRqUQzAnJfTDKorDwRe+nJiOnYbXj0qJ3HqJANP79VgPd3T6HJ77YaRsPe8XDT+uQqT21Inc4Qi2UOCQd4zw+nDdUzTJdd90BOaNr2pGScQFP5gFaik9QGauAUsncc4/7OmT3STmdmDvHqYT9KP2g==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(7416014)(376014)(23010399003)(1800799024)(36860700016)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: B7KuWthExzR/hsApkOnjgWXdMPIBNOAZTkut9FfFFIyiCVcYLJjGoIKfcMZVP8ekSBmV8rHERW6PMWOO8o4Py2oI5pOIsvOSRGsRDQ9FGBH9G0q5C4FbtsjFA/gH1x1Ckf9lFgs9IF95PubXyi8M7nCCHj3VUQqQ5FfzNNg8mhoCCq95dG1nkqfnW4px1gQFk7CxPgyhgEZMSQU0+wgH5kZbAJrSTYX/G/Wlnf0QfKzqGkV4RSDJhnAWIpgD9ERGOsnOZ+aoluPGQSnx0uBzDVQ8t75OdCY+otIhEayHIK4zpSZZBsC+ZL2+tA9+3rrE07h9lpupqomcL9NNDr/Sxry62NdodoDB+pub7CDgrZOEyjebmJW7u2/J721GumPm18zAam3rLjI4HyXx3t7UB+LeHGrJa+uTd4nF8yQ5zLJMoNMchc/NKfxLsJ37Y8IK
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 08:54:41.1828 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 957ac770-ec30-4c88-c3d3-08dedb3c37c5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8453
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=avihaih@nvidia.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Extract the VFIO_MIG_FLAG_DEV_INIT_DATA_SENT flag sending logic from
vfio_save_iterate() into vfio_send_init_data_flag() for clarity. Also
add a trace while at it.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 hw/vfio/migration.c  | 26 +++++++++++++++++++++-----
 hw/vfio/trace-events |  1 +
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 6b7acb2fa1..45f8e346b4 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -480,6 +480,26 @@ static void vfio_update_estimated_pending_data(VFIOMigration *migration,
                                          data_size);
 }
 
+/* Returns true if the init data flag was sent, false otherwise */
+static bool vfio_send_init_data_flag(QEMUFile *f, VFIOMigration *migration)
+{
+    VFIODevice *vbasedev = migration->vbasedev;
+
+    if (!migrate_switchover_ack()) {
+        return false;
+    }
+
+    if (migration->precopy_init_size || migration->initial_data_sent) {
+        return false;
+    }
+
+    qemu_put_be64(f, VFIO_MIG_FLAG_DEV_INIT_DATA_SENT);
+    migration->initial_data_sent = true;
+    trace_vfio_send_init_data_flag(vbasedev->name);
+
+    return true;
+}
+
 static bool vfio_precopy_supported(VFIODevice *vbasedev)
 {
     VFIOMigration *migration = vbasedev->migration;
@@ -693,11 +713,7 @@ static int vfio_save_iterate(QEMUFile *f, void *opaque)
 
     vfio_update_estimated_pending_data(migration, data_size);
 
-    if (migrate_switchover_ack() && !migration->precopy_init_size &&
-        !migration->initial_data_sent) {
-        qemu_put_be64(f, VFIO_MIG_FLAG_DEV_INIT_DATA_SENT);
-        migration->initial_data_sent = true;
-    } else {
+    if (!vfio_send_init_data_flag(f, migration)) {
         qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
     }
 
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index fa2204f002..fe0d2cc06f 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -177,6 +177,7 @@ vfio_save_iterate(const char *name, uint64_t precopy_init_size, uint64_t precopy
 vfio_save_iterate_start(const char *name) " (%s)"
 vfio_save_setup(const char *name, uint64_t data_buffer_size) " (%s) data buffer size %"PRIu64
 vfio_state_pending(const char *name, uint64_t stopcopy_size, uint64_t precopy_init_size, uint64_t precopy_dirty_size, bool exact, bool final) " (%s) stopcopy size %"PRIu64", precopy initial size %"PRIu64", precopy dirty size %"PRIu64", exact %d, final %d"
+vfio_send_init_data_flag(const char *name) " (%s)"
 vfio_vmstate_change(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
 vfio_vmstate_change_prepare(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
 
-- 
2.40.1


