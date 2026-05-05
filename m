Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33336CD342F
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 08:16:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKAx9-0002IW-Mw; Tue, 05 May 2026 04:16:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wKAwa-0001kr-Gd
 for qemu-devel@nongnu.org; Tue, 05 May 2026 04:16:00 -0400
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wKAwU-0006lE-A2
 for qemu-devel@nongnu.org; Tue, 05 May 2026 04:15:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uY0V4LmuuG1LlEKLZTj7h5NigpLiJm3SBSNsAtnHkYsvKKBsjrTLfmwVVHmWOydqlQFbRtwOYk84UX/S5adwqhaAfDOyCz4+IPDydGQ5OAv4t14TCbUyk8AVRUVVYIgK4tMF19DCWSjZt0LhoIPFQg899xmgs9FrQ0dfWPVh1ZB1yeOC6a8bpT7XT4kLjTDjWMlagdlmkdiVXT2+3Je+Pz7zcPkk9KhWOcG+VGWlGAVl32+vk856egaMzbefRcaavKBG8h3PbU32z1UplytcxwWcxj0ELWO6TOvoOJLt1MRLHt5zwyZD7LztIZXP55r3cwL6Z0ZSsv9CSY8iJbAzzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0AAs64w412hwEauOreCCjTrPPPHc9j1OZ9YHIjRtvig=;
 b=AJMDC3by0TBs3PKcQmQ1jSprBcFlxffRZ4dsi74oY7w7zfTdBrlmaSSz5H5bbAXVSU+Vh5vcqT9LDtuUffQKijSY9I+rha78HGgG9R6NbUl4GcwqQ7ZoRp7aVZkjhuMqTEL3sc2BtHDuA11rhhAA/MXnxosLoEO5wgg54exu7TbvhOJAcfV9rbr/1mvdDVB7g4a9j2PN4V5qRdYfWWtl8quFEZjVdlZ8A0pc49sAOQoP7HdMyzqTLgDe/viEnVkxnZpojSUmPCF+SDYMEfJW00WcZ4CEktYd8JR5s3tJBFuOEm4PErSOKw+wRmHR2AoOD/1GFjmH4D0fa40aYytmqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0AAs64w412hwEauOreCCjTrPPPHc9j1OZ9YHIjRtvig=;
 b=slvhgIZ1TR4bK41zTLcQGe39F6PHq+5qxbbeBUQEeli7lN1LFV1L2ll+GCs5Vd8waV4vslfB8OlZXsWK8mdr8kkFzXE4YKEJqWAroL+4YqFwCUnQ3oKhePQIi9VzCywUWPOr/rKtGCAhq2eHBFxQ7faLeRwXlWQumpvmmecnT9Ycotc190RaFN3tMXRZIXzojhU1moCFtCE/LJCwv6DyF4GTBD0DONkCmT+KWuvnc8dwTtIFZIQRxO2OEwAblH37pVPH7Nc6+soitRV1EicFYj71cSgnpntAv43Q3LvtYapmVsM8T/MmXOWzHFXvinl5u7UV98ZL3qXo6+qJ1vOfwA==
Received: from BN9PR03CA0448.namprd03.prod.outlook.com (2603:10b6:408:113::33)
 by CH1PPFF5B95D789.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::62a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 5 May
 2026 08:15:38 +0000
Received: from BN1PEPF00004684.namprd03.prod.outlook.com
 (2603:10b6:408:113:cafe::93) by BN9PR03CA0448.outlook.office365.com
 (2603:10b6:408:113::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Tue,
 5 May 2026 08:15:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004684.mail.protection.outlook.com (10.167.243.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 08:15:37 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 01:15:12 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 01:15:12 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 5 May
 2026 01:15:08 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex@shazbot.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?=
 <clg@redhat.com>, Peter Xu <peterx@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Zhao Liu
 <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck
 <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Maor Gottlieb
 <maorg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH 11/14] vfio/migration: Add new switchover-ack mechanism
Date: Tue, 5 May 2026 11:14:20 +0300
Message-ID: <20260505081423.28326-12-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20260505081423.28326-1-avihaih@nvidia.com>
References: <20260505081423.28326-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004684:EE_|CH1PPFF5B95D789:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d1b363f-b1c3-461b-8e2d-08deaa7e7d6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|82310400026|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: XYKN7L6cCGP3R4DSNNmnSEBa8ny5uUXYxN2JYbCqUOaUH8wCVYvJzubICRx1fTHFurLnOk7SAHw4ccTOcr1eyJMqAwfXUw/LJB+2WOT5suEwFtpKDwic4abxEQl8XD4MzXNtDQ5y9H4yyDBkaP4QgZvGfcqWtFQOHbA3Egl5P9UcYYIBJmwKcT9kT0ZsEuk9BOV6DAfKvhyDhGKx3pmZpbaoJYbUD+11APwWq8Rcsv7c1+HYGWV974rH3ElOhlMQ7w8ywitO6fZ6q0RD1/AId8YopOGdETtQo+Zi7quGSzbRpe37WoI8ZwKbP3n8DSEzUgqelhzDX+pz9d4DTZFeZaDJFNio6MWLg6AW7ulJx+gS5FdXnahTlUsR0j/vphZjBdMtWkTeIYPQXwFcEPCkus6uFw0yGYIqwk3BDRRrLZVroM+crc6IDQrddOEn2PYFBgZAWxvCqn9hX3TBqYD4vvzZFHiRilMoZnV5DezUUCcqLoeEAQYAd9h8yc/f7T5+qyOuqU7W8OtlQCSlbYwvvMCA2jzTBfSDrRLyIsZBjq/dfIc8TUBs/x3CDWS0GMF1VmffwutYhGSepjxLh5mCanhBhe167MbtOwYKui3VdIWKCOrovuUCzqgveGnHxpI3XteAmcd7dKBoTXU7/tTbcAmiPq31UOECvDQDtxytX58+2xI7a2UjgVux63+SfiZ65WS+k47c5u8V9CVFjief6QzqDxLYCm+r4TVCbJOFzcc=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: F+/8abUs29mP/LBZO0zwwWE9S3Y3+sY8qKjMVOJScx3XtKj63akN6MldDjNBclceT0KzpOGZV1oqkxJueziwQLSFApXrAPvO7Tb00Nrfmy9J/4e5YQRGsx2VPKpeVMuPYQsL9XpMndjUyA/QLybjLAFNj9wwZ2CJKCtIuj7t5AMIw5J914HJha95mslHbEgQQ7Rl2M04J1RoFD77jZQyylZ8Is/q7Q1F3jCAo1PA1WEXEhQNjhuqE219VABJzAvME2EFU28E8c0DBIIj+mXxAqPLdCYWI+305FuIx0Gp7f9pOXo1Yah1advOrM52SknP3pgld+qjwe7vBRZYo92/SF68VZVB1/FYJ/do19T8SzT4ZVTz6ZSrq9k41kKtkXMtJwxq9IdcL2W8uBuGl+hPAumYkhRDGYY0hX+BRLY43sYKyTRO1bNR/pFLeagyjOe3
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 08:15:37.7988 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d1b363f-b1c3-461b-8e2d-08deaa7e7d6a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004684.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFF5B95D789
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=avihaih@nvidia.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
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

Add support for the new switchover-ack mechanism. This includes
implementing a request_switchover_ack handler that requests a switchover
ACK on setup.

Keep legacy switchover-ack functionality for backward compatibility.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 docs/devel/migration/vfio.rst |  3 +++
 hw/vfio/migration.c           | 16 ++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/docs/devel/migration/vfio.rst b/docs/devel/migration/vfio.rst
index 854277b11c..7f4e065506 100644
--- a/docs/devel/migration/vfio.rst
+++ b/docs/devel/migration/vfio.rst
@@ -59,6 +59,9 @@ VFIO implements the device hooks for the iterative approach as follows:
 * A ``save_live_iterate`` function that reads the VFIO device's data from the
   vendor driver during iterative pre-copy phase.
 
+* A ``request_switchover_ack`` function that requests switchover ACKs when
+  needed.
+
 * A ``switchover_start`` function that in the multifd mode starts a thread that
   reassembles the multifd received data and loads it in-order into the device.
   In the non-multifd mode this function is a NOP.
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index b7e929274a..2607ce4cec 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -882,6 +882,21 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
     return ret;
 }
 
+static bool vfio_request_switchover_ack(enum MigSwitchoverAckRequestStage stage,
+                                        void *opaque, const char **requester)
+{
+    VFIODevice *vbasedev = opaque;
+
+    *requester = vbasedev->name;
+
+    if (stage == MIG_SWITCHOVER_ACK_REQUEST_STAGE_SETUP) {
+        /* Precopy support implies switchover-ack is needed */
+        return vfio_precopy_supported(vbasedev);
+    }
+
+    return false;
+}
+
 static int vfio_switchover_start(void *opaque)
 {
     VFIODevice *vbasedev = opaque;
@@ -905,6 +920,7 @@ static const SaveVMHandlers savevm_vfio_handlers = {
     .load_setup = vfio_load_setup,
     .load_cleanup = vfio_load_cleanup,
     .load_state = vfio_load_state,
+    .request_switchover_ack = vfio_request_switchover_ack,
     /*
      * Multifd support
      */
-- 
2.40.1


