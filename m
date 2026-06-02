Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3126CD6E57
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 09:29:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wULPX-00061t-AL; Tue, 02 Jun 2026 05:27:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wULPW-00061g-Kl
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 05:27:46 -0400
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wULPV-0004F1-6Q
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 05:27:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bbiuus+eaNpA9EUQwasTOV9P3YO72pDmYcSY170YzVPiugV/tu872pK/ctDLOQLSSccJrMieUtIKSZggqWEGAwspWqseqDIbB+7smWfRtD6NkJNoAakH1apd8GK3zG8b8raDHrf+Jyuyb6nFaB0Sk0vqaIEk30zhzRlHN5fO5ESW4K9mgNHGJmM6Tf1P5hlECb3ed0F5CtlwQBM6H23t9feJTU3tcOYsOX7TJECOzb38Ayu6NIUS8tHowdMElWHeBM/pjqflk3J2psIasqbTp8yMxwC12mik4WS7eo28phbR3VhYsOBWhXGi/Q6xlHX1w76zJHBXPWDQPxeRnep+JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MDvTHtKzWXXY2+Vb/T93yC+5OXzg+igVcKG1Vo97EBg=;
 b=S7d3rkzBA/uohmSM0zXFgEeicqqeibzxnhu5MaLgFcp2gqrOpFdk1958SeiYoFnkpLCttNDCZVEspbolHBKki5g8o5EE4uE4qq2ao6rbfiNyj28C162RUUfWYdlNwYZ7UeWHzf743Hb5iScounX6NKSDJc6q7Zn5rS42q9s1cR20N7Xu3Wa5AofVpC8Yir0DNpAeQeelLAvnSajtjefi9Zfvc+zK8LagpBNwDUacl2vw5zTWAmc1OOP231XLD8NIejVQPvK8nUDwan6ipPKdnex+eROxLfoHPoiMjqFqssf0BkRap+NsUx19R1bGjH1scbZwLR6Gd2p4LMJkttCblw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MDvTHtKzWXXY2+Vb/T93yC+5OXzg+igVcKG1Vo97EBg=;
 b=URMBQ83yVaOJ88KUJmRIqQLYGlrSWPge/NbzLa5BRI7eLfboFa/eL356HQDIPIqswQ1Q7hsuM6FwDn1C0pRVhSzas0LoPuBVEtQ6ahX+FFGfJ5eKBtJ/OUZhiGDwPuE9xQnztFrNtaIMRUN4ii0jXA+TW48Cp3fY3AbFp1qzTj4frqSCqdKySd/sLJw9gpyvorxVXfgcM21BoSfJyPW5P+2EUdGq8vxiJDpj4TQVFEOweX8I8qPBLUDEFfhmbzzbWTkBjdfoxZhlalgfoeD2L0kbdpZcjfrpapXH5oGgTUiMQfQP6xGVq4lEdgT2G5C076dxCjMmnKZN3D8hFr8JRQ==
Received: from CH2PR07CA0012.namprd07.prod.outlook.com (2603:10b6:610:20::25)
 by CH3PR12MB9100.namprd12.prod.outlook.com (2603:10b6:610:1a8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Tue, 2 Jun 2026
 09:27:33 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:20:cafe::3c) by CH2PR07CA0012.outlook.office365.com
 (2603:10b6:610:20::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Tue, 2
 Jun 2026 09:27:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 09:27:32 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 2 Jun
 2026 02:27:20 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 2 Jun
 2026 02:27:20 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 2 Jun
 2026 02:27:14 -0700
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
Subject: [PATCH v2 08/13] vfio/migration: Extract
 VFIO_MIG_FLAG_DEV_INIT_DATA_SENT sending to helper
Date: Tue, 2 Jun 2026 12:26:16 +0300
Message-ID: <20260602092621.382-9-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20260602092621.382-1-avihaih@nvidia.com>
References: <20260602092621.382-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|CH3PR12MB9100:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ce7183b-f879-4eac-b2e6-08dec0892ced
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|36860700016|82310400026|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: ANTAP7CVNNBTVfAxHXxRb8N/LnDIP+UdW5d5PcVy2CSYrOontuyBWRZ41XmUuzvjVF4nC7t5OazeBNt8NQnn04m5B1CfvbjmVBZMR0vgZLw2IQvDvZwaF0rGsG2E0dVe6zj8YfdYxFh4jwB54X2PgxU8+MsXzhmT3eI7GQeKs+fO7Oa+b6Lmxz/SURmtk3AHJF63kvc5h3gbYC/DOlgAUTh/UP5hi6cQ4buZ53VXNW1Ufff+AKuT988/DOGOK3lFI+fCerp/at5QEu3Ttwxuak4V2yA7YUrMaSwoa9VELZBK7TbE63dXTv1cYnVRlX2kZVYzroffHnXjvAeG4aAmFB4sZjkduuuw3yYNdGIZ92dHConFUYQFVDim2Uo6/pTqT7itpkTKTqqGEKWry+mLbh7ApWNNpWeogB4MJo7aOYm+NFACit0SZul9kCTjpiWw5fb5mIdTwAra0hd2Maywd8Sle47d59MceeQc9WimUzkOZwH0Q2rEokKA8WXzs0xFOEBtU7veVBYWf2SVHDJJIYFtttRrRHGgHo7/V2un2vuhQuxotBIPhrzKAnAyHj3GQLzawjYSW274V2xkk94lreBdrnXDXgzbvWm/rBuMb1rv5zJNL+ueYIDIMU9XLBSvf3krAJQczCYGUwkhxfaFEgXEo+yUDBZ7VjYO4kByzfqwmSG9kKpG2WQ6Jw7YcTbGltQzq1b8ymz+psh++giM061I0QKQiFgU02qHmmeKk5g=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(36860700016)(82310400026)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iCOPVV7iF8zHUuOhDay3ht/FMA6EmfFakoczLRU3obfnnsi5TTvr1pxKMAxdzfcCf/Q3cmxVzKOqnMy37Fq3R+yPDyPOfG3lRxFwzrXUdVle+IoF1SZXTT8S6uVY7g0Vpf/zqqw97tfsplIGPc0izHE98oeeBXMcEk3uu7sHsgXRAwR7pTUvROcoR9blJ6rwgDS+GUSuLJtwM0PC4y3r6X1jWzx5XOxTpNNJEIzMpvoQ31tsbUkKSLyJJopAxh0wJwP6K8wf/CLq5Hb57SHWqHV0g7IxU33HtkQUBwBJTffC/8ZWh33Eq9f8g9+J7mQdmWwnb5V6XM0S9D6IhN/vJF2vOrv1TcaYRMUNX2PPEm6nYGBX+fDib/J6R0Fx1kl4uyRSuGcYDSAR+PgCNXaOEnZqL3ylLBRz7tuaLOVA2k7Na/8YPKntbkIy8LoaLYqY
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 09:27:32.8667 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ce7183b-f879-4eac-b2e6-08dec0892ced
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9100
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=avihaih@nvidia.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
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

Extract the VFIO_MIG_FLAG_DEV_INIT_DATA_SENT flag sending logic from
vfio_save_iterate() into vfio_send_init_data_flag() for clarity. Also
add a trace while at it.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 hw/vfio/migration.c  | 26 +++++++++++++++++++++-----
 hw/vfio/trace-events |  1 +
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index d5be135584..a15e877fd3 100644
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
@@ -692,11 +712,7 @@ static int vfio_save_iterate(QEMUFile *f, void *opaque)
 
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
index 2049159015..e99ee2ee8a 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -175,6 +175,7 @@ vfio_save_device_config_state(const char *name) " (%s)"
 vfio_save_iterate(const char *name, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy initial size %"PRIu64" precopy dirty size %"PRIu64
 vfio_save_iterate_start(const char *name) " (%s)"
 vfio_save_setup(const char *name, uint64_t data_buffer_size) " (%s) data buffer size %"PRIu64
+vfio_send_init_data_flag(const char *name) " (%s)"
 vfio_state_pending(const char *name, uint64_t stopcopy_size, uint64_t precopy_init_size, uint64_t precopy_dirty_size, bool exact) " (%s) stopcopy size %"PRIu64" precopy initial size %"PRIu64" precopy dirty size %"PRIu64 " exact %d"
 vfio_vmstate_change(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
 vfio_vmstate_change_prepare(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
-- 
2.40.1


