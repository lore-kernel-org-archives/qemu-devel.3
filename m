Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57499E9A03B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 09:03:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vszvk-0005Br-96; Thu, 19 Feb 2026 04:02:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vszvG-00052F-JQ; Thu, 19 Feb 2026 04:02:10 -0500
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vszvD-0002Qo-4y; Thu, 19 Feb 2026 04:02:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DfSTrv+95U28av0N10j9p8sAj6mttehXIwCo2cCAoPyJZypbMKE2Bh6GEUdreJXJKBdim7eFCGN9SaVW0nKhXcn7o1BrAJmuBxhXoQ2BlSxv+eWlsEPkinfvzg3LXflzJ+FBccuj+1YRLCpx9sxYnvCIuSaNiREp1lCvxiLTXP5fZHXgOVc8FJZUnxDEpcWtm5jmk+RNbQSPjGZySarS/CCPYPlo4dQMVkUG7HkS5kNJP3hSKKLI6FlrRW5Wq/+V4VcW+dpcOYG7yRf59SLy2cMVRwCnbYKB9l0eDm7rbgTwo7qQk34iZMtce4NhijWRSL00QCQXNy4GC0l1VS23SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XclW4P3vYsM/JneYRrxknQeQ3n7W9HnlHGNzSo7yfKo=;
 b=UwhByeD1YdTkAesEMul7Hu++rkrrkGz/djiHkx1jVzLIKK1AH9UAhDth/fTg32zHXDufR14aCXtCiDTVM/wuITzGEMdTIrEkSY/p7nXIXhkEqeN95kWKrZvtk0UGvq++JZpX2zPIHNMh1UwIy0QyYu+XyRYmBRBCHQNtI6AhO7ZnA/D+oAEuO54qhPrg8UDFVEd4uaOaOXlneQtgxo0uD5ir3ADvqV/mrPZQDu4/44XiKPzF55ko+UQpoiZ8uZKp/LWF8acGVXIe8CjPJqglnDHguCkuGwo87Xezh4Di7o624rAnDc4JB0JOzjUTgpEXLbMyASThMXpZQc1MMY29RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XclW4P3vYsM/JneYRrxknQeQ3n7W9HnlHGNzSo7yfKo=;
 b=PISvcij32EbGJZh1YH2MK2FSuTlCpE6LggKhMcbKzOLPDpcGZWdEHCcBKZtRJV7ppMrgf3+FM49rVlg+3ExsV1QkxAICjAUeegPP7wNY8kjBvXzThIGFTe1CnviCb1v+9dS3fBc2egcVLsoTygSQfNAKXKrttXZ6ZGX4uCWnGOgCukebybMB2NwqXnFny2o7QyNYGJ3wQzbyZWaVoOof6js940R8F79RbP/vRjdozKLmBTL0qOwM3wTmRBv6sEyd47GemzNNGGJJC8jPmE/3VW2mV0e5GCixIchQrEaiH/6su90Y7wiz4eS2UljLWwu02PA4q+UQtNmGhDbj0pUDjQ==
Received: from SA9PR11CA0007.namprd11.prod.outlook.com (2603:10b6:806:6e::12)
 by CH8PR12MB9744.namprd12.prod.outlook.com (2603:10b6:610:27a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Thu, 19 Feb
 2026 09:01:59 +0000
Received: from SA2PEPF00003F67.namprd04.prod.outlook.com
 (2603:10b6:806:6e:cafe::24) by SA9PR11CA0007.outlook.office365.com
 (2603:10b6:806:6e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.14 via Frontend Transport; Thu,
 19 Feb 2026 09:01:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F67.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 19 Feb 2026 09:01:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Feb
 2026 01:01:46 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Feb
 2026 01:01:43 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jan@nvidia.com>, <jgg@nvidia.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v7 5/5] hw/arm/smmuv3-accel: Read and propagate host vIOMMU
 events
Date: Thu, 19 Feb 2026 09:01:03 +0000
Message-ID: <20260219090103.33697-6-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219090103.33697-1-skolothumtho@nvidia.com>
References: <20260219090103.33697-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F67:EE_|CH8PR12MB9744:EE_
X-MS-Office365-Filtering-Correlation-Id: 002eb52e-413c-459f-d162-08de6f958a34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CsJSiaNn+hzhOXZBts58g1Qf9ZDUKzKrXzPIaflm5jszPOMwJOaacSKlUfkR?=
 =?us-ascii?Q?c9PpMAFFBNaAGytZXxgjFAmvkjJRtkWx36cP9qMaSXoN4Najc/X8jvz91r7D?=
 =?us-ascii?Q?u6e710EqnGYYZV9jDnBxU1zhdGHpPHsiBBKpRqXBfOfSDiz44tKTbRLDcdq/?=
 =?us-ascii?Q?KU8JLrPaeLEu17eAA8mHh+s6QJa2t8U9Qpzcp45NO1pR/27DODGOv9x1eHqv?=
 =?us-ascii?Q?XCcmzdo7rBrl536RA6ZQHJtzZRLQ/Q/ilGB1MscMVsVWjpd1bkOnCE/ec98D?=
 =?us-ascii?Q?2rXU9m82Wub8eb/xqkGBtRcq2TvH+PbKK5EyJNd6P88qsjk9gVtLnnzsX+HQ?=
 =?us-ascii?Q?xu/zm+R4PwcuhlMf63K5uqZDhMlXI4/YEyUJz6IGnATyO02GTuFNhAr7ip5T?=
 =?us-ascii?Q?TyFbp72zi2Z2iHgbqjKkpIpFhL/Sfg1+cMve4jDH7vcRD/kKWMsaxFuWRrwZ?=
 =?us-ascii?Q?nDX+bYf9+MfBL7F8gWiPgWC9GDGUjFPNH/xbL3BpnPjKSu5+FwkoSy5OBYCy?=
 =?us-ascii?Q?CH+9wohGdN1hldEfouaRXvffadnrlTCKqW2rGz6RP3YKc8rKoZ1C76pCLkRF?=
 =?us-ascii?Q?9MOh7gIXD3r39BCobb/69OIaQzOGzhFODMR8o40Qae6VM8r618pFTqG3fQN4?=
 =?us-ascii?Q?KF01fyHgj9yvMqy/8IEV4cwpKFRuNZTYaC83JvIpLSTWEfEBz9regrydZsWX?=
 =?us-ascii?Q?9tmbmq0+0BVSQA0Er7yj35anJpZ2bbwqIq9YK5mDVQi/A0WAKJBBxED1nZuC?=
 =?us-ascii?Q?hau2Mu3415zYN44yR5vF0j0QF+TiAEt0KP5beYyVKWtKy87rJM3hQXcT1fg2?=
 =?us-ascii?Q?4BL9VeNewPES/i72/vR61O4Tlj35n9HQEd89IUr3gyWdEFZdfQImuS/bz8y4?=
 =?us-ascii?Q?tPkQloPpQwtONrJ/g0KO0hJdsZvNePZk0zOzLPHZ8i2CLUZdCvcB+ZXTcVKa?=
 =?us-ascii?Q?O+f9LNggxmHwIZAPOQ5wfNxCXanhPS6xMZx5dutj9BsPWJQMmiPzYxGPNR1N?=
 =?us-ascii?Q?3u19+PTVsPOJhGWoULdvryDUy8gn1Vh4DGDdu5jovPlx9b9jA3WPwdLVaa4V?=
 =?us-ascii?Q?SBMHpo90f/2gIcHGeOxkde0h8BFDldmVFV26DX3HNOTX1xcQHqp0gUVLbDWx?=
 =?us-ascii?Q?Tr7ANzxVCbB7DBN7E5azOzOsspq9RCvHM82wEkH1cNJEvplN/pYy1AYkJVXX?=
 =?us-ascii?Q?mFJ0C0GLmttGhxN8h/FKaRmsWH2m1MBw2Vcv4Z6TKrIh4aeElhr3f9m3ycy4?=
 =?us-ascii?Q?RIoRnrE57TRFxwNR8qRopi7w8keCc/lX7pzZLPw16wUAMPr/hWHcwV+XwgSg?=
 =?us-ascii?Q?ohe+Fiy4MWPM0qH8UjZGeeXLX8EvQ8odlM2rEJN16zCSx0RMfrUTRvXMw7jw?=
 =?us-ascii?Q?UyRjMoO3xJNWjZlukTXO4iNJfFBFdhTQ9QGdH+q4g3FBCj0s3zoMkyXLKEAF?=
 =?us-ascii?Q?V0lNrHbp2Vi06IYgeWVnirV6QuF4Yt/CBfgMhR3jwkAe3/K0Q1a4WFngiD7O?=
 =?us-ascii?Q?F1tL3b1wY/YgxN+nYKCrnAy235MK3lcl53QlgIKQjZ+IbSV6ohZ6EiagbaI5?=
 =?us-ascii?Q?YGjBt+qeAjnuNXPPCyht72Lj0kSUaXDpH2v5+Rhh5fQYDh3Hs/yAR0fPpvuk?=
 =?us-ascii?Q?9CkdIl0PbzRAaoo3M6846fboGwf4pI6UUvXtz7nl7D45XaOz0myBBfKu646I?=
 =?us-ascii?Q?1Rk6pw=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6S44l0SxPn42g/UWnm1sqIAZBw622I+UHlj+I8GnrxjSGlYv378aqK83Xd2w0g+0ZSP93B8mvEwn5uN8HFZGP334EioPoo3LYGijpEiejwVZ95GgQOJhwu5r2zw5B7LKcJEf3/WEagMhfIbYqBq9r0xTDsB5zKO1VsW0XipgCmqFoY6bXc8bv6qMSgSHmiwXBVEd/aLJ0lWg+/oiygQthLqGBc+so6Vd8V7J744Ul5SscBFdUQgj2nK7DNQgmCeLN4vraBpWUE8sSjcTQxGp+P/TKnp/kNGWI+z2OYy/LztvFCsYe151nhZIg08QQEDimrJxmFATVESpEuhLrp9Rht5ySaaopOW53CQcURrzqujUDcrKJHo97bVEJe0xyYeUlegRCFpTdnreimEZ7KPL0/5/CBSIixWKr3vfDadD/zdGIX50ciFmlv0+eO20mOJD
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 09:01:59.1132 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 002eb52e-413c-459f-d162-08de6f958a34
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F67.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9744
Received-SPF: softfail client-ip=2a01:111:f403:c100::f;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
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

Install an event handler on the vEVENTQ fd to read and propagate host
generated vIOMMU events to the guest.

The handler runs in QEMU's main loop, using a non-blocking fd registered
via qemu_set_fd_handler().

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c | 64 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index f703ea1aac..17306cd04b 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -390,6 +390,50 @@ bool smmuv3_accel_issue_inv_cmd(SMMUv3State *bs, void *cmd, SMMUDevice *sdev,
                    sizeof(Cmd), &entry_num, cmd, errp);
 }
 
+static void smmuv3_accel_event_read(void *opaque)
+{
+    SMMUv3State *s = opaque;
+    IOMMUFDVeventq *veventq = s->s_accel->veventq;
+    struct {
+        struct iommufd_vevent_header hdr;
+        struct iommu_vevent_arm_smmuv3 vevent;
+    } buf;
+    enum iommu_veventq_type type = IOMMU_VEVENTQ_TYPE_ARM_SMMUV3;
+    uint32_t id = veventq->veventq_id;
+    uint32_t last_seq = veventq->last_event_seq;
+    ssize_t bytes;
+
+    bytes = read(veventq->veventq_fd, &buf, sizeof(buf));
+    if (bytes <= 0) {
+        if (errno == EAGAIN || errno == EINTR) {
+            return;
+        }
+        error_report_once("vEVENTQ(type %u id %u): read failed (%m)", type, id);
+        return;
+    }
+
+    if (bytes == sizeof(buf.hdr) &&
+        (buf.hdr.flags & IOMMU_VEVENTQ_FLAG_LOST_EVENTS)) {
+        error_report_once("vEVENTQ(type %u id %u): overflowed", type, id);
+        veventq->event_start = false;
+        return;
+    }
+    if (bytes < sizeof(buf)) {
+        error_report_once("vEVENTQ(type %u id %u): short read(%zd/%zd bytes)",
+                          type, id, bytes, sizeof(buf));
+        return;
+    }
+
+    /* Check sequence in hdr for lost events if any */
+    if (veventq->event_start && (buf.hdr.sequence - last_seq != 1)) {
+        error_report_once("vEVENTQ(type %u id %u): lost %u event(s)",
+                          type, id, buf.hdr.sequence - last_seq - 1);
+    }
+    veventq->last_event_seq = buf.hdr.sequence;
+    veventq->event_start = true;
+    smmuv3_propagate_event(s, (Evt *)&buf.vevent);
+}
+
 static void smmuv3_accel_free_veventq(SMMUv3AccelState *accel)
 {
     IOMMUFDVeventq *veventq = accel->veventq;
@@ -397,6 +441,7 @@ static void smmuv3_accel_free_veventq(SMMUv3AccelState *accel)
     if (!veventq) {
         return;
     }
+    qemu_set_fd_handler(veventq->veventq_fd, NULL, NULL, NULL);
     close(veventq->veventq_fd);
     iommufd_backend_free_id(accel->viommu->iommufd, veventq->veventq_id);
     g_free(veventq);
@@ -424,6 +469,7 @@ bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp)
     IOMMUFDVeventq *veventq;
     uint32_t veventq_id;
     uint32_t veventq_fd;
+    int flags;
 
     if (!accel || !accel->viommu) {
         return true;
@@ -445,12 +491,30 @@ bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp)
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
     veventq = g_new0(IOMMUFDVeventq, 1);
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
-- 
2.43.0


