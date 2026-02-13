Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93CF9EDF148
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 10:44:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqqe8-0008K9-R4; Fri, 13 Feb 2026 05:43:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vqqe7-0008HW-0Q; Fri, 13 Feb 2026 05:43:35 -0500
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vqqe5-0006cm-9q; Fri, 13 Feb 2026 05:43:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LJ1ts+l++C3sH7bkjgotgvVwOCglsIwTI4g+wHvozsJinbwCAPFgSk2aMr4f72V8LtYQzNlKecxbwmLAlcLn34ensuNWBS7tbHKYGVeTeJXhDGmRyKlpAsTUWghuzP7DvrZRqe7aFn9EPTIDIKlvXhYf+88uMvnuMkPTUisGNnvBZIDqGy933uMLszzXEm+1GCiCui15BLGzFem21BuVQTml9WSCSIma0lwtSYx2uK6Odmnm/cW2AScbyl0tWz9vqcFT5Mpd728s4hzDhHCAKVYS/0wyrjdMHsaV4SBRtjaYrENcKgA7mk/LeaXMNhFyuQ8XdMzLa8OsnreyGt1ssA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pMOAaQGWVmFXeShfjJs5bSQVNS0YFvQBw16xqIM8FVU=;
 b=gciLnU3S8Qhw6GdbC6IzNsGDD075llrSr0wQ5nvyZQMIp+yJelNWJFDoduDFdJDHwlQ03sEhig97SJ6JsKw/tKUyxQg9xFZAdvQIcKEAoDPzZhbSbbFkvZfr/3fpwH0unDfWTV249PQsfcC2nN3tUnRXIa987OPDZ0VzJBxuEB2lmEiwEQ0IYW4dqreHZu+IInLpczn3yuI2KUVzpYzR64XjiyPxu6v6jTSoUvslEUU9aJWX2nsKwgME6L+V03/JWhvh/je8Hv+nH1/zJIwO3QLLMhIBKc+x3om31+FzqOsrfjM5Lhrc6SleEoMt59YWxDWr9m460i03KPw5+A4iuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMOAaQGWVmFXeShfjJs5bSQVNS0YFvQBw16xqIM8FVU=;
 b=YY/GfCQ1G1e58wMmVEa9K1zdWnfPbUD4mmgD4FwV64f0ljd45aR5L8rTtqm6OPXVvWfAu7llNuoCRQfn3t4ck0EIaz4fr5jVTd0WDVss3Yxfl3g1JOefcFQ1wUIHr9Z2XDscSHMVBeUovBZ1Lc29K92v3+39CPYmZXVJ+T+KzAnaZH39RIkJ4fndB3yf4sdWKp3TTNa7L0r03u80DkitNSw+TRCNOlbTY3JkYuAn/O3z65983j22DE9YCIjNC3EN3zojOZeF1ejfScj18bELhEj9YqR05jm4m8hipqRLsEFKbRWjoh0YjnS8NISQp4P9f3lLFqALzHX9zLFrxpMIEQ==
Received: from MN2PR19CA0066.namprd19.prod.outlook.com (2603:10b6:208:19b::43)
 by SN7PR12MB6690.namprd12.prod.outlook.com (2603:10b6:806:272::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.11; Fri, 13 Feb
 2026 10:43:26 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:19b:cafe::5f) by MN2PR19CA0066.outlook.office365.com
 (2603:10b6:208:19b::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.12 via Frontend Transport; Fri,
 13 Feb 2026 10:43:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Fri, 13 Feb 2026 10:43:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Feb
 2026 02:43:11 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Feb
 2026 02:43:08 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jan@nvidia.com>, <jgg@nvidia.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v6 5/5] hw/arm/smmuv3-accel: Read and propagate host vIOMMU
 events
Date: Fri, 13 Feb 2026 10:39:42 +0000
Message-ID: <20260213103942.142823-6-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260213103942.142823-1-skolothumtho@nvidia.com>
References: <20260213103942.142823-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|SN7PR12MB6690:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d71a405-a8d6-4cbf-5519-08de6aecb7eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eHsceKdZzIK/moFT0TIiPMFgmEtjaQ5EmTfCzaF4Y7iAqQZFiZ09r7Krhrlc?=
 =?us-ascii?Q?JhIirtz8xCF7E8ZlScbXL5ybJnCxn9ZxDrgSL1T1UDO1qqJDF+lDs9f9B5+e?=
 =?us-ascii?Q?v6DLchvdDC4sNPwreTfaWlRSCgPmTktBzrLq+gJGm4x6WP2sB4HLzj/ve7x/?=
 =?us-ascii?Q?gC7BLN9oIAiFmHHtCmwYjDR0nvMyJRcqEnAexzbTmnGsJueuJ/rzfrqjkXzk?=
 =?us-ascii?Q?uWM5wD14ERgLlcnCaK1yKPtRhh/augXM8Mr0uV3e8gpI12b4MNIh1cat+Isd?=
 =?us-ascii?Q?ImV0jNyjlIIoUVPcGyUOJNOM5zOXzeHlaTKPPHc2rkMg0b5FJN/l0y115cBK?=
 =?us-ascii?Q?SpH3fYvvjT8u2WPwmBr9HHa6XeVQ6a4zm7lTVUJBMGsc4lxgud4AKvsGd8zV?=
 =?us-ascii?Q?KkXkb/gNRfCQbX1n/SVh6epqBFVv53BXFwg1JdVYLRQ9P7EwwyU7uqxUX8Pu?=
 =?us-ascii?Q?m25W6xlHQrKNNnhF2iWF2sHVZ9FSzel5ztPu+CPTA3dRjmao1LN3WgBRh+n7?=
 =?us-ascii?Q?SSdV9yQqQCU9xxojddP3y+V2/eGoDg/eeIIHau0okvw5+Rfh8YcRVh/IXNMC?=
 =?us-ascii?Q?PuRBJUuBI93dX+o5uP2yw09tI5eQeSH1nDZzdlGQ1aA7QdmRY8gSGVD0EPzZ?=
 =?us-ascii?Q?SX6jIukAR4iptT8i/xWdzyObtSQ8cImRMVxqv45N5aePwPIBEvxHKPeHGm7Y?=
 =?us-ascii?Q?WGrIy8OQgnjCk3FZnp9k++NIqIn+bYIvi1SFwu1YfFj/eJ5anKqAj0QXcIhj?=
 =?us-ascii?Q?4TwldmYXFQkx1x0iu+HD9eq5gFpJnEaHajdayKDykI8LnH7rgJ0mvj7veEJk?=
 =?us-ascii?Q?S4i2QFNlO5pUsyp+5NFy6Imhk3f5HU9F/4iJc+5FOoiIpoMhKPa+6sPXkwgY?=
 =?us-ascii?Q?ZWk4c2L+Ws9Gti2ISbVSa+llPr+VzK40HbQPaL6qI8Ziia6k/VRypUeAEDTd?=
 =?us-ascii?Q?bjI2kGcDbG7dTyRbcossSYU9ErwAJntqlR3ibBSJVVq2eJzTNN4i/lZoIN2+?=
 =?us-ascii?Q?QQgoMK/vgdZpi1sBb+qzWjL3S1d0NqfiCH9DrVbPIC+E3KpSkpCtY27Gt61Q?=
 =?us-ascii?Q?pxYfproxC7OAf3rYeHaQb8DRm+AOnQtTO0g13jfEFR2CnL1C3ZY2u5d6EHuH?=
 =?us-ascii?Q?XgidA8wWlOOZeINlZVKGfCdUh95kYnE/dKN8cbL6XwnRYMDs8w8fekib9B29?=
 =?us-ascii?Q?yvOM2TXp/FDHg66VIK4Yg0K/tffXhs66Ypc85+cwiEqRkTqg7ndXGMuT7FmA?=
 =?us-ascii?Q?1yJ2T7mcFo0NQ8ANXDtjm3fGb/io+tbOimlCl6PwVK5wZa0KLd/2vuoLUY6u?=
 =?us-ascii?Q?lOgZiHr6IEmcGBhJQsyAddipkQNGvIUxQNv63SLW1Me5/i6JZftkW9XP5dt8?=
 =?us-ascii?Q?RR3L1XMi1fCXcH07jHHQUJ3ze++cnecrJSnIxhTo7bPEeaBQeVpM7cxnABw3?=
 =?us-ascii?Q?n4vVeSZQlZKpBFb+mO0TVcSzfwL4T+wiDU50JmVnXJfICsbAjitB7PhcjtbZ?=
 =?us-ascii?Q?d7zM1f61yp7L4tCfiH9GKrtCrOQy2x7BbunG4wlGi3Z2P5Mlv4ul9MIQ8mqG?=
 =?us-ascii?Q?sHxfVXWw+cV6cuCbzPtQKCQnTW+gtb8QLkbh+Xv7k0VSGevgsf+TAZ2yu0fF?=
 =?us-ascii?Q?H4EqHOYpjLtGFBcxTH4wrwrENYbmLorfOWz/PsHxyiiebYO1WsW1Rt5T15jv?=
 =?us-ascii?Q?EElf0Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WcOq2UouT4E17lzLmuSRBCDOcxDIn67kAcMW6RQuBEeQszt0dW8kP62MkYlxPAUCYy2SdoP9cOh/ojCLB98iLassr5sY4kQp8HCf5zBmSdtpmxfQh5bTLUhErHdtO9Oj8WxMbMcmJtJBCeglrOkiouknUM5ePKj8FTgmG8nwtsqDEH0rhDWC/3bW+6chiI02mFMYFqhZSZsUV4xMYNQ48suMLvp0zMA5EYQy+GFVmwOXKb0FpCv6qRftjh7xsHBNcLBx5VKaacqj5FTn2t07W0A2QByjGE7mW86fNvmP7NUJXYqBD4wc+UZaXWK7fTneV89Qri8BI+lCu7WWlcCl6jWn2jNPmEUjaWxE1RDFXJ9Q7wHP3BZ3M/LYpHHAKVAUQVTyrUhoUM22bITSaWHaCgeE9TAiqLCnzjPgcXn3htFkp1reHJgCSMZhnxAVJ1YF
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 10:43:26.1833 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d71a405-a8d6-4cbf-5519-08de6aecb7eb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6690
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c | 64 +++++++++++++++++++++++++++++++++++++++++++
 hw/arm/smmuv3-accel.h |  2 ++
 2 files changed, 66 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index d92fcb1a89..dac4526a7f 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -390,6 +390,50 @@ bool smmuv3_accel_issue_inv_cmd(SMMUv3State *bs, void *cmd, SMMUDevice *sdev,
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
+    enum iommu_veventq_type type = IOMMU_VEVENTQ_TYPE_ARM_SMMUV3;
+    uint32_t id = accel->veventq->veventq_id;
+    uint32_t last_seq = accel->last_event_seq;
+    ssize_t bytes;
+
+    bytes = read(accel->veventq->veventq_fd, &buf, sizeof(buf));
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
+        accel->event_start = false;
+        return;
+    }
+    if (bytes < sizeof(buf)) {
+        error_report_once("vEVENTQ(type %u id %u): short read(%zd/%zd bytes)",
+                          type, id, bytes, sizeof(buf));
+        return;
+    }
+
+    /* Check sequence in hdr for lost events if any */
+    if (accel->event_start && (buf.hdr.sequence - last_seq != 1)) {
+        error_report_once("vEVENTQ(type %u id %u): lost %u event(s)",
+                          type, id, buf.hdr.sequence - last_seq - 1);
+    }
+    accel->last_event_seq = buf.hdr.sequence;
+    accel->event_start = true;
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


