Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D08A8C43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:56:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgf7Q-0003QO-Jl; Mon, 06 Jul 2026 04:56:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wgf6l-0002t3-MK
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:55:20 -0400
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wgf6j-0007Rp-EI
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:55:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H2v0rLetorBbL5TXah767DpZyXjsEgmORdpsIlhy6wqd7hAwwlcLwDfC8i5BqWKVpc6Yyn5AYWj88V47DMvrF9aKqEsDcVQD++Hb1ulCNQYYQAXNRsk20aydwGjMXZuo3IV72FoUip7YHs3KN70opUEmbaLfFhdbsonzHL7z1yzA1p4lYfXepAJ7w0DGoJsJHIe3QM4Ms+SQzHA1kOmpG1kE4JLfP1KqTp8KstK7QcmtQCydKwOdB5vj7KLczIi8BukH6J1lx1ErOLIrfqNNoSI3CY3dAHfnj4ED/MxmZLkKpk50J6rBnMwDjl/fA6NG50HKGJzUNLXaFf07OD+R7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bO1AHCRY+621ffU8oevGHxJaP+7h5dldYul0r1Vhb2E=;
 b=y++lDdvayHM2Cd3H3Ypndho4GiyCZS/gu9YhY1tZubmLgdsxc2/ZMf5QLFiq2MwGjKOu/nz8QqSS0JIMfzqEyTxcc5oiufopa70qt2mXglvnd6U03s2VmEPrGY3JHc8BJv3+81+MtkQPzs4FZzzX4RidlPdsVj1BwDGjXzuVlSG3iLwckm4QuZCn3893RIsYn314StDO6xCEtajMGI/gRw2u6AWBqOLxI0c0qmFJSCzzhOxIF8XRSt5379ncI+LVD2q4GQwODqYLsmgH6SehO3mYoZQDQ4ZKx/jMKv1QNsabkb/JVMDm4rYC9GMH5cvSKNCxfBabCLWnIJOJm82tPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bO1AHCRY+621ffU8oevGHxJaP+7h5dldYul0r1Vhb2E=;
 b=aTE37EXkdnTPn04iM9sWARxvuKIQ+PEq3xmZpgfSgEpk1q0GWFvpWALu1DN3edBUYLgQjmBY2SliAy7TaVFDKoVD/91wND08L41bblK8a9hzpMjL46m/326iNlMhn4ZPsry9t4E+m08Da4BaWsHLQwc40iLGfaZVuHGQ94iYNqEFmpjrt7s+7ly+JO0ngyrm9r2e6Fs9Fi3ef94+evDkCZ5eDd59qw5fEJD/MWsdiiMyMC1rMNtSA9nDByknCsE7LO02N7NkMolEh+vgBn4UPG+E/+zEjx//vRcZNevTY4QPlMlR2cX0W5Xjh2vwnGmuxG8dyubSV32X4Wkv7K2liA==
Received: from CH2PR11CA0006.namprd11.prod.outlook.com (2603:10b6:610:54::16)
 by PH0PR12MB7079.namprd12.prod.outlook.com (2603:10b6:510:21d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 08:55:09 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:610:54:cafe::2) by CH2PR11CA0006.outlook.office365.com
 (2603:10b6:610:54::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Mon, 6
 Jul 2026 08:55:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 08:55:08 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Jul
 2026 01:54:55 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Jul
 2026 01:54:54 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 6 Jul
 2026 01:54:49 -0700
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
Subject: [PATCH v5 12/16] vfio/migration: Implement VFIO_PRECOPY_INFO_REINIT
 feature
Date: Mon, 6 Jul 2026 11:52:07 +0300
Message-ID: <20260706085211.13905-13-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20260706085211.13905-1-avihaih@nvidia.com>
References: <20260706085211.13905-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|PH0PR12MB7079:EE_
X-MS-Office365-Filtering-Correlation-Id: e9034e7a-4dbe-46c2-6db6-08dedb3c4854
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|7416014|1800799024|82310400026|22082099003|56012099006|18002099003|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: OPZf1NhuTIJMPJD+m48siyyEbdyxuD3HpNUc8Em2dImjyv5pulMTgcuMTnE+iI+Yi5wjsPPPv5VQ/2YCDB8gWU3lA5tiyb1Q56JuDJ5XypwVjvBG4gV5Eg52tj0FGoCV+2H94qdQ1XEGyOhiBe7ansrfNjuwO7klUB84b6fx8uZBN70CHNxjyFDkhdw8L1G3ghln6sptiBrGAgJp7vIn0RKVbMVh5NmnoAordao1Ipp96M8JJVFmpotZlu5Gon9Ym1L0DgWesVOFUnXJZP/8EBRf0eUAUheM1vBlSx77kpSjNlP0UTcR7f1s6hbWWo2zN8zj2cbw/NBkjhHgfyJdEPMQwc4b40o+akwnmOjVXYbVYKcfhH1VVhFgD0+lstN8JPTmSYb/De9pyavwnNrQl3aUhfAeGr7wmWkFv6CWJ7FBSNdDcUNuV3jkrWkdjSzBZTf096sWPy+F8sEqeGsHQ3Z8vr9YX5OHny4i2Uoc7S4D6cGAca8JLQb4xY8//kQoAyuJItnznHM6Wc1Q1kSLmodd9SJDhC5ctb3SlqteXlNlCkf05eVHlg5KrpNP4MDA9KsUpGAmQLVFcpCaDuWPJJa5NPZxXFjFyEh2w448tNwYGShmMKhp9y6uZQBm3M2RbMe67TTNUWSOUNibi3oC22L5jWZvi4gqYvdMmLPL7h3W+W+Q0vyJJfGvvJYO+5UNIygH0P9HfmHXRDkbvXwcBg==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(7416014)(1800799024)(82310400026)(22082099003)(56012099006)(18002099003)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6sk09zjVck8IFqdf1zXWM93jNFM2rVyTgZqiZ6izanPxdq0rFwlm8iFBo2KI7ORxOyR4gBHyoIzzT9EZykVFkwnsEP6s88vaX8FMVtI8hbbxdLFGOl7DsBE6dXG35/F7g94os92SxBSoFmDNU9ynSSzaQq7FHU/r9RetB43R42p4RKRB4RymCzX4eIkBBm1WQhAOm3h5OOaPSnMXCf+g7W9F9GMSFlNxEIcIjqMGRQ9gB6kWvxB60hjGIepaFzg+9ajWq/DlvaP/3qwMZBertynerMAtT9tw8FrNcO0GHUOaUmybSAMXU204pRsmqCxeNCZGrVhVpiBVDgobnW5iRNWTt8QfGkb7UjvUzJ3toEaMCQWgg5C4r2lypi3/Egptygpaq+xoXgcjz1iNHuZTVoE19FQCdlainHaAm0z0+mL2qD9TFaT5naQdMKBnsbG9
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 08:55:08.9717 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9034e7a-4dbe-46c2-6db6-08dedb3c4854
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7079
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=avihaih@nvidia.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
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

According to VFIO uAPI, precopy initial_bytes is considered as critical
data that should be transferred and loaded prior to moving to STOP_COPY
state to ensure precopy phase would be effective.

As currently defined, initial_bytes can only decrease as it's being read
from the data fd. However, there are cases where a new chunk of
initial_bytes should be transferred during precopy.

The new VFIO_PRECOPY_INFO_REINIT feature addresses this and allows
reporting a new value for initial_bytes regardless of any previously
reported values.

Implement VFIO_PRECOPY_INFO_REINIT feature:
1. Opt-in for VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2 to make
   VFIO_PRECOPY_INFO_REINIT available.
2. Request a new switchover ACK if initial_bytes increases post of a
   previous switchover ACK. This ensures the device is not moved to
   STOP_COPY before initial_bytes has reached zero again.

Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 docs/devel/migration/vfio.rst     | 14 +++++++
 hw/vfio/vfio-migration-internal.h |  1 +
 hw/vfio/migration.c               | 68 ++++++++++++++++++++++++++++---
 hw/vfio/trace-events              |  4 +-
 4 files changed, 80 insertions(+), 7 deletions(-)

diff --git a/docs/devel/migration/vfio.rst b/docs/devel/migration/vfio.rst
index 854277b11c..f235c2d4f9 100644
--- a/docs/devel/migration/vfio.rst
+++ b/docs/devel/migration/vfio.rst
@@ -23,6 +23,20 @@ and recommends that the initial bytes are sent and loaded in the destination
 before stopping the source VM. Enabling this migration capability will
 guarantee that and thus, can potentially reduce downtime even further.
 
+For example, in mlx5 devices, the initial bytes hold metadata used for time
+consuming pre-allocations of resources on the destination. Although init bytes
+may be small in size and sending them may take little time, loading them in the
+destination can take a significant amount of time. Switchover-ack guarantees
+that this pre-allocation doesn't happen during downtime.
+
+Initial bytes was originally defined to be monotonically decreasing, however
+there are cases where a new chunk of initial bytes should be transferred during
+precopy, e.g., due to a device reconfiguration, etc. The
+VFIO_PRECOPY_INFO_REINIT feature addresses this and when supported, allows to
+report a new initial bytes value regardless of any previously reported values.
+In this case, a new switchover ACK will be requested to make sure the new
+initial bytes are loaded in the destination before switching over.
+
 To support migration of multiple devices that might do P2P transactions between
 themselves, VFIO migration uAPI defines an intermediate P2P quiescent state.
 While in the P2P quiescent state, P2P DMA transactions cannot be initiated by
diff --git a/hw/vfio/vfio-migration-internal.h b/hw/vfio/vfio-migration-internal.h
index dc741e5142..a1c58b1126 100644
--- a/hw/vfio/vfio-migration-internal.h
+++ b/hw/vfio/vfio-migration-internal.h
@@ -45,6 +45,7 @@ typedef struct VFIOMigration {
     void *data_buffer;
     size_t data_buffer_size;
     uint64_t mig_flags;
+    bool precopy_info_v2_used;
     /*
      * NOTE: all three sizes cached are reported from VFIO's uAPI, which
      * are defined as estimate only.  QEMU should not trust these values
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index ebe2eafded..1e172dd10b 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -373,9 +373,11 @@ static int vfio_query_stop_copy_size(VFIODevice *vbasedev)
 
 static int vfio_query_precopy_size(VFIOMigration *migration)
 {
+    VFIODevice *vbasedev = migration->vbasedev;
     struct vfio_precopy_info precopy = {
         .argsz = sizeof(precopy),
     };
+    bool reinit = false;
     int ret = 0;
 
     if (ioctl(migration->data_fd, VFIO_MIG_GET_PRECOPY_INFO, &precopy)) {
@@ -383,25 +385,43 @@ static int vfio_query_precopy_size(VFIOMigration *migration)
         migration->precopy_dirty_size = 0;
         ret = -errno;
         warn_report_once("VFIO device %s ioctl(VFIO_MIG_GET_PRECOPY_INFO) "
-                         "failed (%d)", migration->vbasedev->name, ret);
+                         "failed (%d)", vbasedev->name, ret);
     } else {
         bool overflow;
 
         migration->precopy_init_size = precopy.initial_bytes;
         migration->precopy_dirty_size = precopy.dirty_bytes;
+        /*
+         * struct vfio_precopy_info.flags is valid only if
+         * VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2 is used.
+         */
+         if (migration->precopy_info_v2_used) {
+            reinit = precopy.flags & VFIO_PRECOPY_INFO_REINIT;
+        }
 
-        overflow  = vfio_migration_check_overflow(migration->vbasedev,
+        overflow  = vfio_migration_check_overflow(vbasedev,
                          migration->precopy_init_size,  "precopy init size");
-        overflow |= vfio_migration_check_overflow(migration->vbasedev,
+        overflow |= vfio_migration_check_overflow(vbasedev,
                          migration->precopy_dirty_size, "precopy dirty size");
         if (overflow) {
             ret = -ERANGE;
         }
     }
 
-    trace_vfio_query_precopy_size(migration->vbasedev->name,
-                                  migration->precopy_init_size,
-                                  migration->precopy_dirty_size, ret);
+    trace_vfio_query_precopy_size(vbasedev->name, migration->precopy_init_size,
+                                  migration->precopy_dirty_size, reinit, ret);
+
+    /*
+     * If we got new initial_bytes after previous initial_bytes were
+     * transferred, request a new switchover ACK. Don't request if legacy
+     * switchover-ack is used.
+     */
+    if (reinit && migration->initial_data_sent &&
+        !migrate_switchover_ack_legacy()) {
+        migration->initial_data_sent = false;
+        migration->request_switchover_ack = true;
+        trace_vfio_query_precopy_size_request_switchover_ack(vbasedev->name);
+    }
 
     return ret;
 }
@@ -1054,6 +1074,27 @@ static int vfio_migration_query_flags(VFIODevice *vbasedev, uint64_t *mig_flags)
     return 0;
 }
 
+/* Returns 1 on success, 0 if not supported and negative errno on failure */
+static int vfio_migration_set_precopy_info_v2(VFIODevice *vbasedev)
+{
+    uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature),
+                              sizeof(uint64_t))] = {};
+    struct vfio_device_feature *feature = (struct vfio_device_feature *)buf;
+
+    feature->argsz = sizeof(buf);
+    feature->flags =
+        VFIO_DEVICE_FEATURE_SET | VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2;
+    if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
+        if (errno == ENOTTY) {
+            return 0;
+        }
+
+        return -errno;
+    }
+
+    return 1;
+}
+
 static bool vfio_dma_logging_supported(VFIODevice *vbasedev)
 {
     uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature),
@@ -1075,6 +1116,7 @@ static bool vfio_migration_init(VFIODevice *vbasedev, Error **errp)
     char id[256] = "";
     g_autofree char *path = NULL, *oid = NULL;
     uint64_t mig_flags = 0;
+    bool precopy_info_v2_used = false;
     VMChangeStateHandler *prepare_cb;
 
     if (!vbasedev->ops->vfio_get_object) {
@@ -1106,12 +1148,22 @@ static bool vfio_migration_init(VFIODevice *vbasedev, Error **errp)
         return false;
     }
 
+    if (mig_flags & VFIO_MIGRATION_PRE_COPY) {
+        ret = vfio_migration_set_precopy_info_v2(vbasedev);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "failed to set precopy info v2");
+            return false;
+        }
+        precopy_info_v2_used = ret;
+    }
+
     vbasedev->migration = g_new0(VFIOMigration, 1);
     migration = vbasedev->migration;
     migration->vbasedev = vbasedev;
     migration->device_state = VFIO_DEVICE_STATE_RUNNING;
     migration->data_fd = -1;
     migration->mig_flags = mig_flags;
+    migration->precopy_info_v2_used = precopy_info_v2_used;
 
     vbasedev->dirty_pages_supported = vfio_dma_logging_supported(vbasedev);
 
@@ -1134,6 +1186,10 @@ static bool vfio_migration_init(VFIODevice *vbasedev, Error **errp)
     migration_add_notifier(&migration->migration_state,
                            vfio_migration_state_notifier);
 
+    trace_vfio_migration_init(vbasedev->name, migration->mig_flags,
+                              migration->precopy_info_v2_used,
+                              vbasedev->dirty_pages_supported);
+
     return true;
 }
 
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index c9d143826d..f71d0bbc0a 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -159,11 +159,13 @@ vfio_load_state_device_buffer_starved(const char *name, uint32_t idx) " (%s) idx
 vfio_load_state_device_buffer_load_start(const char *name, uint32_t idx) " (%s) idx %"PRIu32
 vfio_load_state_device_buffer_load_end(const char *name, uint32_t idx) " (%s) idx %"PRIu32
 vfio_load_state_device_buffer_end(const char *name) " (%s)"
+vfio_migration_init(const char *name, uint64_t mig_flags, bool precopy_info_v2_used, bool dirty_pages_supported) " (%s) mig_flags 0x%"PRIx64", precopy_info_v2_used %d, dirty_pages_supported %d"
 vfio_migration_realize(const char *name) " (%s)"
 vfio_migration_set_device_state(const char *name, const char *state) " (%s) state %s"
 vfio_migration_set_state(const char *name, const char *new_state, const char *recover_state) " (%s) new state %s, recover state %s"
 vfio_migration_state_notifier(const char *name, int state) " (%s) state %d"
-vfio_query_precopy_size(const char *name, uint64_t init_size, uint64_t dirty_size, int ret) " (%s) init %"PRIu64" dirty %"PRIu64" ret %d"
+vfio_query_precopy_size(const char *name, uint64_t init_size, uint64_t dirty_size, bool reinit, int ret) " (%s) init %"PRIu64", dirty %"PRIu64", reinit %d, ret %d"
+vfio_query_precopy_size_request_switchover_ack(const char *name) " (%s)"
 vfio_query_stop_copy_size(const char *name, uint64_t size, int ret) " (%s) stopcopy size %"PRIu64" ret %d"
 vfio_save_block(const char *name, int data_size) " (%s) data_size %d"
 vfio_save_block_precopy_empty_hit(const char *name) " (%s)"
-- 
2.40.1


