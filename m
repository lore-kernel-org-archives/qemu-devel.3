Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD421E77180
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 09:47:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN7h5-0000Wl-RW; Mon, 16 Dec 2024 04:47:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tN7h4-0000Wa-2X
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 04:47:14 -0500
Received: from mail-dm6nam12on2060f.outbound.protection.outlook.com
 ([2a01:111:f403:2417::60f]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tN7h2-0004ML-84
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 04:47:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QfO1MhysJz8rH1nvxMAaNVG1SkmdcXFqoGr7K3rWxyH05PVL2fvZiRL5j8cvOQTfmp4jMD2wM08hfuwXmEnRn7Yw6N/Pyn7a/p5d9kvMRQhw9g/74FFduBnxHtIMdR8pG07YYyCcLYl/Cs7wbm17wxt+O2SERDP3xhtRgiL3R406EUfoRn0YYVpuwzMAoqimZ0MwFP7NZclO4D/aFBF2H94GBikZikrQS/wnYgiLEgtz4iPXiFIN14fjitmsC/Z8Jv37US87P1mDJTpjGWhZREpSKrt7gZGIAZVPqWhRGZHTsMlMQSeb0JSKiFna6fk3mUiU1wkeZj7KVz4n5QhOSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lM9gghSegxOSpyH8vflVWUT1rpjWXEgZQ/Gkym8vnKU=;
 b=sY71Jgm1iYn/UzvBwVMLuVaEtXy+8X4Cwh63o3m5lmHPdOHhtRv8nPqeYb6XvZ6E6VpAx7KwVZKVe6weK+msxW9QjdfbFZZt9wwKH8XbRDExysRQ+j1MRB1+nQ7HjRanoA5+7q7J3rqg7f7YPbO7d5HQZvgQ+Tb1RkF8WwkRmFrqmRXwSLIsY6FjESIN1h3gxYMSZ++YlURj0CqMZEHmNeuOUTVvaLH9tlHqBszpzPD+dZ0aQpcdsjj6byE4cHf6t+0RQARMYRNAp0O35/71USTDgqsvVFOWvxBzAF14SWyq6h2tSVQ/sgkStt5LQJOh6NX+xeLqwnv7QdxxfjX1ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lM9gghSegxOSpyH8vflVWUT1rpjWXEgZQ/Gkym8vnKU=;
 b=X8EtIdamTTeAj/IiJQ3ZUuVOOdo/ch/LhhB//MD0TM3Gew29Tywxd6dXcToRsG15hP8yGr7nA/1i7h/5GbNIUI6BmSjPaWMe2CO/AD+Pq8Q2kjsl522QiYCw/dblnSLjL+mSZMUFdTOpGoHLOAaAx//PQ/Q/M1aPUJBslZMiQtpY3kFmg1ItwAhjmn3Rg8pumduH71DRSnYMBZTsvn9u/pZ9PV5wF1fmn+TGsd9VIHk7RHiP7zzsGXhvQ9w/3yGjc3ARqerhtJ3/QcBxGO96/EQ72jz/+Wp2ff9+xsybih/821KvUpDf+6wBZUQV9pdY2e3NegO8tHb8xwUREc4QcQ==
Received: from SJ0PR05CA0155.namprd05.prod.outlook.com (2603:10b6:a03:339::10)
 by SA1PR12MB6971.namprd12.prod.outlook.com (2603:10b6:806:24e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.19; Mon, 16 Dec
 2024 09:47:07 +0000
Received: from SJ1PEPF000023D9.namprd21.prod.outlook.com
 (2603:10b6:a03:339:cafe::67) by SJ0PR05CA0155.outlook.office365.com
 (2603:10b6:a03:339::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.21 via Frontend Transport; Mon,
 16 Dec 2024 09:47:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D9.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8272.0 via Frontend Transport; Mon, 16 Dec 2024 09:47:06 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Dec
 2024 01:46:46 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Dec
 2024 01:46:46 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 16 Dec
 2024 01:46:44 -0800
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, Hyman Huang
 <yong.huang@smartx.com>, Maor Gottlieb <maorg@nvidia.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: [PATCH 2/9] vfio/migration: Refactor
 vfio_devices_all_dirty_tracking() logic
Date: Mon, 16 Dec 2024 11:46:31 +0200
Message-ID: <20241216094638.26406-3-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20241216094638.26406-1-avihaih@nvidia.com>
References: <20241216094638.26406-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D9:EE_|SA1PR12MB6971:EE_
X-MS-Office365-Filtering-Correlation-Id: 53db2bba-874c-4011-46f3-08dd1db69a35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oH8l98/LCIUEtSF/ia0EI+IMWPgLU1ngA6EVMqjTPhe2dTxlkNIZFDijsfRm?=
 =?us-ascii?Q?4mlWl5sJIswCIpS3gXm1KAfhLGnyZLgX7yCAzm72pfCftInj60ATa6sjov10?=
 =?us-ascii?Q?YcDantUSj4bKUPmt4Hk5x4DnCeFfEAd9RWVULUXEJ14wi/2YlSaUWp+cYbaB?=
 =?us-ascii?Q?BllpsEGatE9tUtCh5WiXuV7kfg0eX/cWNT87YZZ2ptkKcYq9/ujpkvp2GC4O?=
 =?us-ascii?Q?9qU293Uvdvw0wTdsiyNrpXHEge743JmkNVhUnd0AUDZAGsOWe7NPQZhdyOfM?=
 =?us-ascii?Q?FYhkGQIgWMuCOFncUTnBlx4sA57gF2SVy6TmSQT0JukguWThOVF9gCmYV2/3?=
 =?us-ascii?Q?6p4wJ797mh4UtgfP945l0qszfTN1bOdh1+32366HDVnoZ6zT4WDav1+H/ClU?=
 =?us-ascii?Q?5YGS6z2FkdhFi9z7OXJ9AKilBOIyeQ+tLohVgMi8jMh2ErNXOGGo5p9D7+iu?=
 =?us-ascii?Q?gN2VQ5LL8Fep9hLeZRa73bRQ1oDTYx7AMhvHP79NamMO/efIiPZrHZk9cvMU?=
 =?us-ascii?Q?K6l9Flu4zWgGpkJx5hhQIuWZG+3Wf3QFFXbKhjyo+N6/qqdISQHqp46wiK+W?=
 =?us-ascii?Q?LQ1yR3DjgT6r6AK8aCDKTTviA8+5o3BRXN9KmcMrE6w9i0mNdjLIiGQzIKlR?=
 =?us-ascii?Q?vr08vGpmKqf3yNj2YgAEOZVQwtKv7sCvrZpkD8OTU4sJx7FalQKxtPXzbDnK?=
 =?us-ascii?Q?OEWFvZhU8MBZ7RXsfyPOuzoG7bdsFLzP2MOmC3BYrx3OXnR7C7hINLwutrxE?=
 =?us-ascii?Q?iNp6cYFkC9sar7hr9KEkzx09DsEkBlybYAkrDKMPZMr3gIb3ZVFPdFdhpk+9?=
 =?us-ascii?Q?rSlN7d1+CnWyR5pUToCh7Po8yGl/YTonnKlkf6GzwquodZpc4R1FlgduRtOL?=
 =?us-ascii?Q?XhHk9y5U1pz+UjrRMMgbE/kkf90Tk/02Clwq0ok6UEiz/T/H3hLXYNP5nIU+?=
 =?us-ascii?Q?wZW+xkK8x3kIroXl9Axa52r2QJM2bcJwS6JzdlrJ9G47zuXikXDTd2GU+2MY?=
 =?us-ascii?Q?soEVe6dTa3J30B8GBCxKhBe4eByi3M7u6ZF+yGRXutq13RY2bQiDdMpThoBx?=
 =?us-ascii?Q?hlqLJaYwlNjnEo9D+GePJmfE1imOhP2ktGyNVbT7ptg9PQr+jc5VdQP4Zeae?=
 =?us-ascii?Q?N7OJYd1HjWWfDt4VTCC2GSzqBRfL5FmZRYqkqtzED/viQbqfydmEY8Xrim/4?=
 =?us-ascii?Q?0oX10GaYRbL8bbm8bDlGfzh4QwAECHHaCt1rAukfiKJ1M1J7tk7qHpqVKMOw?=
 =?us-ascii?Q?dCSdPlmvrsgpfdB1d8VKc1HyIcwZLby05GYyjD6EILrFNKY/bBCbnKQO85Rw?=
 =?us-ascii?Q?KWcI/Am+AE7zTiPFvIcp0lqMMgE0qEbjOsa+h7/fqXnSoPZr2is/R8tiinFW?=
 =?us-ascii?Q?fvrXfUMKW2TcivrdLGYA9QybO3rOXRi5x5uq6HmQ3YtOZlDiLQPP55HUSmcx?=
 =?us-ascii?Q?6jkuIRsRNDWgrNaitRaVSwiyBzM24W2FTKdwEXc472tEo6vxCbZQEkVx/A8B?=
 =?us-ascii?Q?hE8Z/BpEMhx+Y0I=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 09:47:06.3508 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53db2bba-874c-4011-46f3-08dd1db69a35
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6971
Received-SPF: softfail client-ip=2a01:111:f403:2417::60f;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

During dirty page log sync, vfio_devices_all_dirty_tracking() is used to
check if dirty tracking has been started in order to avoid errors. The
current logic checks if migration is in ACTIVE or DEVICE states to
ensure dirty tracking has been started.

However, recently there has been an effort to simplify the migration
status API and reduce it to a single migration_is_running() function.

To accommodate this, refactor vfio_devices_all_dirty_tracking() logic so
it won't use migration_is_active() and migration_is_device(). Instead,
use internal VFIO dirty tracking flags.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 hw/vfio/common.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index dcef44fe55..a99796403e 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -170,11 +170,30 @@ bool vfio_device_state_is_precopy(VFIODevice *vbasedev)
            migration->device_state == VFIO_DEVICE_STATE_PRE_COPY_P2P;
 }
 
+static bool vfio_devices_all_device_dirty_tracking_started(
+    const VFIOContainerBase *bcontainer)
+{
+    VFIODevice *vbasedev;
+
+    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
+        if (!vbasedev->dirty_tracking) {
+            return false;
+        }
+    }
+
+    return true;
+}
+
 static bool vfio_devices_all_dirty_tracking(VFIOContainerBase *bcontainer)
 {
     VFIODevice *vbasedev;
 
-    if (!migration_is_active() && !migration_is_device()) {
+    if (!migration_is_running()) {
+        return false;
+    }
+
+    if (!(vfio_devices_all_device_dirty_tracking_started(bcontainer) ||
+          bcontainer->dirty_pages_started)) {
         return false;
     }
 
-- 
2.40.1


