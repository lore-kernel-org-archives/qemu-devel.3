Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 704C7FC590E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 08:47:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvX0f-00052J-5P; Thu, 26 Feb 2026 03:46:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvX0d-00050U-Vw; Thu, 26 Feb 2026 03:46:12 -0500
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvX0Z-00054h-90; Thu, 26 Feb 2026 03:46:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LZvjjjZs8BzXfN5Qm2vi2rItIlUDH+iHcm7Gj4xIhJA98qB9W5z1MeWkHAtz5YrCDbFvFwZzC+c/1gmi6KosRfmCsKR9E6cPPSzgcp1R8/v7dcS+l2iFPOF/THzgCCxrzmuM3LOqEM5L+1wVPfj5Gfs5Wr2w/oosnLI/RcOBY46wLDAcuMknuCR62DHLvN7L4aEssDwD4pCAhCLqv9BN2HroNAvwWTyZ+cQWf2gdhKSqRhPFtlvCxBxlTP+fi6DnOjey4WlaJ5Fl6sr/FpAI1GaQTnFHHupGBtDpppj9BgftRsUDQIVjAq5bC1UrHopGCfdbuIwu4oHksv58lotfjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mx8w77jLC2339BfDF6gIf7PNvStkO/4I3uOMvquoAT0=;
 b=SrCTLRYJ/nShPw75XdRTPnfGIPdxT1bUs50NDJT2WMwg23NKnmTrIUN8NzcQVhsKIOsKumLEBF6VvjCgKE80WeSGB0IWwstQMn1S8FK8/yj9AfuBv7z6ypCFi46dZJ1RGL9J9++VsZQvdOoDMwOjbf07naNYxi+1JzF/55AtBtBe/sIJhMHK6tHUw/Rj3qb7ysCyPIIb5CKD6+zxtkxWP9jtyWMX2hMAczFaHbyQKdzxwCZwZElIc4jYUmBRWiR7TeWSvJRCMdKAPdYuQPTEFwY3USVyTbwK2eSI2zgrOrbwxPxYqCJP2/yLhwMqStNZA78MeN95u++xi0ZP2P3Xxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mx8w77jLC2339BfDF6gIf7PNvStkO/4I3uOMvquoAT0=;
 b=gWEkptto+voxuMJopIxmJmn6cuHvtXhvDdgbhWyqCH65+agSm3O++Bolg+B6r2FTV905b1nFYhr7hO6Mf5hnTQjb2Dk59TAIoQLvrUaRQqCGw0NbxKwWeihZeuQd9DM0179qtcTUE9+UFPwjC+QZ6rqsXBqXTmsUwxRWkW7htj0+woD6c8VJf6+Fbl/mwJSYF6ZV6rmHvuS2//L+ALKXcVVaOOKyXS+SXIwprosaSRbI6N23th7JpYfXNwI7KbEIqGndL3DsWZtwdINdf9ogQv6oI2Rbp3qfJ1ny4Wqq4vAa07RIJK0rL4wA0LCEyqvDOeMPUNr2GrN86casjzf89A==
Received: from SJ0PR13CA0104.namprd13.prod.outlook.com (2603:10b6:a03:2c5::19)
 by CY1PR12MB9604.namprd12.prod.outlook.com (2603:10b6:930:108::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Thu, 26 Feb
 2026 08:46:02 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::43) by SJ0PR13CA0104.outlook.office365.com
 (2603:10b6:a03:2c5::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.14 via Frontend Transport; Thu,
 26 Feb 2026 08:46:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 08:46:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 00:45:39 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 00:45:36 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jan@nvidia.com>, <jgg@nvidia.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <philmd@linaro.org>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v8 5/5] hw/arm/smmuv3-accel: Read and propagate host vIOMMU
 events
Date: Thu, 26 Feb 2026 08:44:56 +0000
Message-ID: <20260226084456.112142-6-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226084456.112142-1-skolothumtho@nvidia.com>
References: <20260226084456.112142-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|CY1PR12MB9604:EE_
X-MS-Office365-Filtering-Correlation-Id: df1937b5-ca4a-4e64-b6bf-08de75137868
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: ILlajkjeDP4lz8BHTgdcNzro3vYzidJwDvWO5wrGVfjUyFXJMjgXQj6Yw8wnT5dwNzI2lrraxzUKWBcf7mjCpTYrVKMiQ9nOViBbS4hcyu2M3XQe3HL4Mh9HukY3Idmj6HcQ52Q9kWxBCurN8M1sbqGWoZ4SEynObIFgZLaooBJVIv++agS/O70f8R+TVtqDQIcsmcC+h18qwSql8GR62761ck39LQFqa2JLzPL8hkjm+m2S5EEk59QU05Cxpe3I3h9jti+ccuzZD4lsaSXnH0+r4BTG92yoQ7KmLeL1AlwwQD7XthupdESOCiPskXB6tKbW4EzqF0vG4W4mnCiSKGpGndR2E56OF5IgxT071f50tOUat+ydnzqo9D6sc9YhdZv8QtLHISOFdE2s9JUORptX8rxKDayOAOaERPTetSlBsO2AVJPZDzQp903FvllbTrAY2sGNjQCFNEYNzlCNhelzsJuXTi+dNaHg2jxls0Q1mxaZkovzYzWWoFvqaxM5vXibiWQAI8gd0HxU4e16alsatK8ZUMkdm1Zfpbj9Y01orUCXsSyg/qZzK9CoP6zsXhcnxg5H44RG3UpMDNse3/NsSlY8mPk0KyZ6W3fih+Oj0oOjdcYx/G0fJ6qTeknXQPvfQHKzwX/dnHhIZuzVUwSUrdlQYn8XjBg4psb+jq7tx7JhW8M65c0eEDWR0maU4tzxaGKlo+MLvqkk+xJtkmUYy2pMBmSofcl/rfnNDC14TVPvVBmp/qMclr26vutgX+uq+Mlf1jyTguyaBEBp7DQBHoJtzm+Ny82ggHDNNR/kGEXqwc3Jwy3tNfwjlrYpdRsXZQ5cF+rIFngLjCI+Iw==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rP0lLAnYw1+R9ibelcgYtMvnLxPmfvGDEwwqKET9nsbKSpKvbRMTDoI215OH/80doW4zXh0f18HVPx7/NGqMHNguoy+1ZcvrfqzG/YaCfUvFIRMeY6zszhncQBNhNGMnZOoZEWBS2YUcw8+1IHeeZzhDS4TmfPmJ6JOL31xY1WK5TrAKKRrP32qe4SznxqcXCZT4AyBWyf5q0NsiuKIn5rz/yttenHSQfRCLn4wurMWHZn1V8sngjE1XvCsEQH6fiiqi3uSQmNjOz0IOy4pVS69t7HE2ljm6iVHm7zWIApA7AUefEdD+7IDGt5hfcZUhNCGHnjwYAnVUJnOiA2R+SKxHnSGv7seX/i9jkvL1Z44UI5mxdKkCPUemxO/crHqUFNENJ8flHQV73vPas1qiOX6y5Fh/zzOenCRfXqCjbEWqVO2O/M2/N4hUFRaTpBev
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 08:46:01.6828 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df1937b5-ca4a-4e64-b6bf-08de75137868
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9604
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Install an event handler on the vEVENTQ fd to read and propagate host
generated vIOMMU events to the guest.

The handler runs in QEMU's main loop, using a non-blocking fd registered
via qemu_set_fd_handler().

Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
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


