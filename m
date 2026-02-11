Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A4AEB597C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 08:36:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq5hY-0006rj-87; Wed, 11 Feb 2026 03:36:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vq5hP-0006o4-CZ; Wed, 11 Feb 2026 03:35:51 -0500
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vq5hN-0002mL-KC; Wed, 11 Feb 2026 03:35:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wiVvZrGHX/H1O3Ho8eM5c/PlC7VHnuCzzYvhyQnOibI3O4fVB+Slb+6hIz+u7y541z78emTnpDAGssBu06kEuiDVCVckSEPvfWSc9vzwd01hqET7HcvwlURTr/SaItIM72CupdS9ix5Ru7NXgej3abdUhcYl0WvJlaiEkk1ndDLAIhCmwL3AQJu211bMQtiphWomlbOh8uNlroW8pc7bJVtyg7W96S+ioEV001qomOlCBdHsriAKltME2/V1WjvJ8cYnlKMmK76wYWuxjRLLF5X1/AmVDBrqoXsWy48KgqOSchoqD9n0QTGsef1aGMkD0+iKFX5oVd/hbiK4ep+Lvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s8EJWlSU+V3M5XnhTqMiDvsUhp96w6z5Xu2cN9XhREc=;
 b=lQRF/9Z29ZfTMvOfq5pbuJQF6j3hUZXNf1nAETPmEJP22vYMSsWN000V2hnsNuJr6tYbZN8bSpAEC0coSfqUzskE8d3i6ffKUP3mNlLl9x3YV3Xvgy5ssDTuMOIeO74oh4Ny7SNBa9g/ZqsB+AMogonLjbb3iPgZnFkJqtu5qTjYpVmI0D7VFSzbTqnum0q8DF3SFH4FZn5rRpLa6lDC5pWxtY9/0WjCpbxCnXSNaSVXtmg1YTgq1tqCm9XZEjKnSOKsaMViT9dccLxazW11AMtRBAdhG1vBCuyRBTA7DjO5p0nYuqbIy1wsilJUWZyKVWpyMQzE008MlsHXEgYSQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8EJWlSU+V3M5XnhTqMiDvsUhp96w6z5Xu2cN9XhREc=;
 b=T9nI0oCOhYaZl6I4jAJOoO1JiNwgF2uff9g13Wx36MkWpaNo7hn9cRSTW6H0TLpNJw47JPCVswXifVfGYCCxOj7gL8kTGEXzG8Sok8gIF+KvwMHCLzdbDzJg2LaxO5HjBR1m6NPJ2VJVdqpSmixYVcnvbQ7629GtlJRetxwudah6SilPHNgJsyujmCOEwDyu63HRvmA1lTKQBCokH18W3OQPmGg9pKRvZLZkaiYQlRR1L3aP0LpsRL1G9RUZ8mVPN7VQds0aP+ZRIFJpzkZXuXxNtrgMCyzcV/GAjLrSzDhExWfg7ueq7KQqkL1Xzyj6q+x27UpNXEHIZdG/rJandA==
Received: from PH3PEPF000040A8.namprd05.prod.outlook.com (2603:10b6:518:1::4a)
 by CH3PR12MB7738.namprd12.prod.outlook.com (2603:10b6:610:14e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 08:35:39 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2a01:111:f403:f912::4) by PH3PEPF000040A8.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Wed,
 11 Feb 2026 08:35:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Wed, 11 Feb 2026 08:35:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Feb
 2026 00:35:23 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Feb
 2026 00:35:20 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jan@nvidia.com>, <jgg@nvidia.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v5 5/5] hw/arm/smmuv3-accel: Read and propagate host vIOMMU
 events
Date: Wed, 11 Feb 2026 08:34:15 +0000
Message-ID: <20260211083415.133534-6-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260211083415.133534-1-skolothumtho@nvidia.com>
References: <20260211083415.133534-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|CH3PR12MB7738:EE_
X-MS-Office365-Filtering-Correlation-Id: 66c35351-17b1-4c7c-cac1-08de694888f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?N2cG66hItPweL2IdtyRLw6I88KxPUMpSycmX++QKf4HElp4AQ/wGSz20MXTq?=
 =?us-ascii?Q?5RSM22aVnzxxZepmVZkbl8a4DPbHVCzfqwgUSW3xAk/kyLOYr3NcskZgpDUL?=
 =?us-ascii?Q?VTi4WCR0Yauv/K8hEXovyUV1nfAQPOGtqG+LbUSQHoGLSzONJ1ELsSj97wws?=
 =?us-ascii?Q?q7vtLZZAjyxP0PHPk3Rvcg6n7stpJSRfDB64He81gzDuW7s7zBIvhNqKYB/U?=
 =?us-ascii?Q?XaKFOS0+FdDGKEj/phdP7+nh8EGsK8XgBarJz9PiJ09u9smli1o12NtcyePi?=
 =?us-ascii?Q?RuUkIxSqwvku60SRxd1N/As+sKcR89rWRoby8TdbkuOFrMI8yBlr6QBp1Plk?=
 =?us-ascii?Q?GtVWlg38er3xL0v7BXQkXLU3vEragWKa3FBAaqcz5Kf8qthGI+/qFY6CCWsE?=
 =?us-ascii?Q?Ek62ATdy3ds4YVd59rhPUwOnm370997hMLTVu1NjeHG0DxS+eattN9QqZNzs?=
 =?us-ascii?Q?R36SRbDw6PeRt0YEaP5BXp5ZjcAQ4MaZ4mQHYMncabYhdAi/nMF5uCR3I7op?=
 =?us-ascii?Q?qJpm8wOHiwTKV4txg3wG/76LC3hatcDfa2LnR0FaJLaNfwVG0MEgl17bQFyM?=
 =?us-ascii?Q?I+4ZEmfHO9jvMCu+lV/xsIZuFDNtD0LvtrPvuE/tXESgY+tQnz8hQC1qR/FS?=
 =?us-ascii?Q?nYtf1C1XbZqBmzRsgsX0pnfG2PLhnC+fEztVk3RyfTdhOTB3TGcBF4UVaySe?=
 =?us-ascii?Q?ogDFG4YZv5+odC5Vn1TZONsL7JR/BERh/NoTeZi46YeQhrnZbYIJ2HaixV/L?=
 =?us-ascii?Q?YMxJPaUwALwdVw99SK+jMb81W+V4U+4o5CSGpaM3Rb6iN8QRmXkxUxFzN599?=
 =?us-ascii?Q?UUiwTvHNxA6shHFiMgu5T3Xpm27RCSMLDVXDw4iT8gimei1Tyl4FZg5TOvHG?=
 =?us-ascii?Q?V2/uG/RW+e8Yhnsfe7RIMKEw/owXUwRHNdmIdaa9Wqvf5q+swzsZBjF4V4wu?=
 =?us-ascii?Q?CQLGcGnl0qnjP4rR/bI4tnWL0dZKmcMEW7rpM7mP26dbrX1w+uBIHiSDRDSj?=
 =?us-ascii?Q?5M5YvxxiqYmWtyv4wPABxrt53PGB0zjNM8HKoJhvAdLFf2IwqpudK9syrxfI?=
 =?us-ascii?Q?+tJ1xV0pKz01A4jqjgJnzg/gAugDT9/iF5ru9FNyw4VLs2Bm7zhmNFzlod44?=
 =?us-ascii?Q?3+fwwLhkX3f8jcKHM7r+bAJCrLdANAHXDPXgwfWqqKwO+yHrmypyAXPiKMEe?=
 =?us-ascii?Q?B92Yz+SHfTws8WbSLf9p8mzWVw4AbYTglv1b6ZWLm1LMsJYiKAZLCHft+HVK?=
 =?us-ascii?Q?uhGYeLBNVol842ClDa7gNIMJR4hFY/3AF4VxCbCDv7MAtGQ+uKdwegObGSaI?=
 =?us-ascii?Q?7YZTdGrrAgZlGXISWxFQHx2BS5FHJibpDvUjMxrZxyCW0UufdUI/+wzcektC?=
 =?us-ascii?Q?2jVpKOWU+JpP5IFBICrgAM51kUEwT/ReMBkhtrXyGDUGmwH5b3BJRUjes1Io?=
 =?us-ascii?Q?Yox+9Dnd8rY4JaM89v7STixzz9uGkCvAwW7qy6fRS9GPhe10bu0VHAvZ1Fya?=
 =?us-ascii?Q?Xh5Pjjg9Fai9Ot5l9wZ8BfSbpCTAVTbtSy96wQvdu3VB0uo7NaGhLpTdDMq5?=
 =?us-ascii?Q?0STIQFITNnxvHJgowfDdceJhivL1LUQzAy0dbrDlRwzUdxt/v8uENQrcyQkQ?=
 =?us-ascii?Q?fsZDScypn7asTncl85u/YcbX4ZBMgjtM0UnoiLDAwJzQYY/GWM8y+wDdrtxI?=
 =?us-ascii?Q?Ba64Lg=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: R3D+5T6Za2IucudDacpUN0twu4zAQB2dlYuivVcYg269D6c9ZPcdV6JBUu85M5EHRtAHFZsG41XUm0CGC0fYWB/Rt/D356L2Y+rvDl72Xk8+B0Am1HAdrJw1cY/OdKnROfvaXcZnkRilOYoTYU0EqSl6H3b4f83iftjMISS3Bm1arsLv2Yyp9Wls9vcllsbKPRvFjYH57ohtJjjw5/ej9gPhZtVvG83W7AKtrxXrB1lE2Hyoahj3g7w3tMiWTS/rh0ajT7KUiAfHDyg23yjyIEC/M9KkKWbDZH7tTZxjAzQhg3mVZW4vf8MceLtqCpaWbabQ6LZy0bOwkcoOHe+zBb4vssEd9bwm8YWHUF8OnT8pCKAuZVL4gP+uYx2+I9cTCNIgOelmccIsVcQrQnF+B45Z98MsPQLRJASrVhB9tjK9jAu0pnYLs7N6cgJt0hVJ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 08:35:38.8199 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66c35351-17b1-4c7c-cac1-08de694888f2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7738
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Install an event handler on the vEVENTQ fd to read and propagate host
generated vIOMMU events to the guest.

The handler runs in QEMU's main loop, using a non-blocking fd registered
via qemu_set_fd_handler().

Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c | 62 +++++++++++++++++++++++++++++++++++++++++++
 hw/arm/smmuv3-accel.h |  2 ++
 2 files changed, 64 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index d92fcb1a89..0d5dcef941 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -390,6 +390,48 @@ bool smmuv3_accel_issue_inv_cmd(SMMUv3State *bs, void *cmd, SMMUDevice *sdev,
                    sizeof(Cmd), &entry_num, cmd, errp);
 }
 
+static void smmuv3_accel_event_read(void *opaque)
+{
+    SMMUv3State *s = opaque;
+    SMMUv3AccelState *accel = s->s_accel;
+    struct {
+        struct iommufd_vevent_header hdr;
+        struct iommu_vevent_arm_smmuv3 vevent;
+    } buf;
+    uint32_t last_seq = accel->last_event_seq;
+    ssize_t bytes;
+
+    bytes = read(accel->veventq->veventq_fd, &buf, sizeof(buf));
+    if (bytes <= 0) {
+        if (errno == EAGAIN || errno == EINTR) {
+            return;
+        }
+        error_report_once("vEVENTQ: read failed (%m)");
+        return;
+    }
+
+    if (bytes == sizeof(buf.hdr) &&
+        (buf.hdr.flags & IOMMU_VEVENTQ_FLAG_LOST_EVENTS)) {
+        error_report_once("vEVENTQ has lost events");
+        accel->event_start = false;
+        return;
+    }
+    if (bytes < sizeof(buf)) {
+        error_report_once("vEVENTQ: incomplete read (%zd/%zd bytes)",
+                          bytes, sizeof(buf));
+        return;
+    }
+
+    /* Check sequence in hdr for lost events if any */
+    if (accel->event_start && (buf.hdr.sequence - last_seq != 1)) {
+        error_report_once("vEVENTQ: detected lost %u event(s)",
+                          buf.hdr.sequence - last_seq - 1);
+    }
+    accel->last_event_seq = buf.hdr.sequence;
+    accel->event_start = true;
+    smmuv3_propagate_event(s, (Evt *)&buf.vevent);
+}
+
 static void smmuv3_accel_free_veventq(SMMUv3AccelState *accel)
 {
     IOMMUFDVeventq *veventq = accel->veventq;
@@ -397,6 +439,7 @@ static void smmuv3_accel_free_veventq(SMMUv3AccelState *accel)
     if (!veventq) {
         return;
     }
+    qemu_set_fd_handler(veventq->veventq_fd, NULL, NULL, NULL);
     close(veventq->veventq_fd);
     iommufd_backend_free_id(accel->viommu->iommufd, veventq->veventq_id);
     g_free(veventq);
@@ -424,6 +467,7 @@ bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp)
     IOMMUFDVeventq *veventq;
     uint32_t veventq_id;
     uint32_t veventq_fd;
+    int flags;
 
     if (!accel || !accel->viommu) {
         return true;
@@ -445,12 +489,30 @@ bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp)
         return false;
     }
 
+    flags = fcntl(veventq_fd, F_GETFL);
+    if (flags < 0) {
+        error_setg_errno(errp, errno, "Failed to get flags for vEVENTQ fd");
+        goto free_veventq;
+    }
+    if (fcntl(veventq_fd, F_SETFL, flags | O_NONBLOCK) < 0) {
+        error_setg_errno(errp, errno, "Failed to set O_NONBLOCK on vEVENTQ fd");
+        goto free_veventq;
+    }
+
     veventq = g_new(IOMMUFDVeventq, 1);
     veventq->veventq_id = veventq_id;
     veventq->veventq_fd = veventq_fd;
     veventq->viommu = accel->viommu;
     accel->veventq = veventq;
+
+    /* Set up event handler for veventq fd */
+    qemu_set_fd_handler(veventq_fd, smmuv3_accel_event_read, NULL, s);
     return true;
+
+free_veventq:
+    close(veventq_fd);
+    iommufd_backend_free_id(accel->viommu->iommufd, veventq_id);
+    return false;
 }
 
 static bool
diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index dba6c71de5..c9c10e55c3 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -23,6 +23,8 @@
 typedef struct SMMUv3AccelState {
     IOMMUFDViommu *viommu;
     IOMMUFDVeventq *veventq;
+    uint32_t last_event_seq;
+    bool event_start;
     uint32_t bypass_hwpt_id;
     uint32_t abort_hwpt_id;
     QLIST_HEAD(, SMMUv3AccelDevice) device_list;
-- 
2.43.0


