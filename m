Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C195C79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 18:07:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2YJX-0003Yy-39; Fri, 04 Sep 2026 14:06:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1x2YJV-0003YS-Hx; Fri, 04 Sep 2026 14:06:57 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1x2YJU-0001jj-4j; Fri, 04 Sep 2026 14:06:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f8C1qwAjJ33xZS7QFLAcypMK4uPwZkyZRILjNsn86mNHm+TQQl8k7CvHcPDObET9RDgylliLh2PB3eDYhbOKJ/J7PFglwqIOKdNZ/B/k70paL0idnIbWuLCpeWQ7rO80+v85IWXY1e7s/KTkqAsdA/Insnu3ZORZkiLFKHQSLGU6xeCnI47L1x4cYwLYgkD9TInu1NwmQW6pfqaDhx2KMlYc4xOr0DdHE+Q0CTOZoMcO0VhJM4hOM0HJFhlbre74OURVmqd0py9uhsqrOPzcIiUmK8M7wJ3FwZpqFPk/Z+1fYymQBlAC63hjRdYS8BJukdS4Z98bWF9WdQahdjcHzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BuXrVsOtE5S145qrf1rklaLTKJ8S2HNWbO8hGKuuqkQ=;
 b=vmdnEcr7LlTbjjjPG8ixuPNxTi1oHAw9iU4Fru0nb6L1CUimLeOZ1mGxsNgGqyg96fwqUAXa4fVL+dcO27051ZMH8ZGMFKWU0DPUyvCFiqX798JxU4DwxZqPPWvaIcad2ubZQpBbHBmpDWKuDzarsHwBh3XVj4H5TB9/NES42Ao30t33xbGr1UyzO2lm/uSz5ZzTDwtP1BD4CfV2SM8l2CUBbNOnSCMUnXE4dlHZ+v8sBswDpdJXQUfJwA2QwosSWZCtLoTg15xW0koJKz0QsPkDXvLOSvBbc+LUyGGL2jeV5pBXTgpIyfpGoqSc9qOkZYjqrSuhj4+/jVFkbgf4eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BuXrVsOtE5S145qrf1rklaLTKJ8S2HNWbO8hGKuuqkQ=;
 b=Qc8on0tASTScIALKgwWB6w5eWRXUK6HS1PMEbWQPcYGWCb6f5QVRnygEogf/EWgIz36xhHefHwhUBvV0DYVoqpzlEQpUvgdgWfKBcFei6n/ZIJf3aVNUWwOBNtKLMUIsF9omDKW0SpZY6de4zdLTDZ4ho/CeUpOxykoYki/lMyMROf31rzpLBIya83/r4aqJUF1oWvA+IVqQaOsDiSX2M5lG50e9aLO872TjTAhd1VXPhr0rQnrXvm5JR0GRgqcLHyozOQGpgQRnNSyWB4RtBIQWA2h4uIwNxa6S74yEDFVURKFu+FHpBJi94AkzxGIqaspotIkZLcPffNNk0bJPMg==
Received: from BN9PR03CA0982.namprd03.prod.outlook.com (2603:10b6:408:109::27)
 by DS7PR12MB6191.namprd12.prod.outlook.com (2603:10b6:8:98::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Fri, 4 Sep 2026
 18:06:47 +0000
Received: from BL02EPF0002992D.namprd02.prod.outlook.com
 (2603:10b6:408:109:cafe::f) by BN9PR03CA0982.outlook.office365.com
 (2603:10b6:408:109::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Fri, 4
 Sep 2026 18:06:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0002992D.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 18:06:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 4 Sep
 2026 11:06:22 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 4 Sep
 2026 11:06:18 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jan@nvidia.com>, <jgg@ziepe.ca>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <skolothumtho@nvidia.com>
Subject: [RFC PATCH 1/7] hw/arm/smmuv3-accel: Factor out the single vEVENT read
Date: Fri, 4 Sep 2026 19:05:07 +0100
Message-ID: <20260904180513.248396-2-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904180513.248396-1-skolothumtho@nvidia.com>
References: <20260904180513.248396-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992D:EE_|DS7PR12MB6191:EE_
X-MS-Office365-Filtering-Correlation-Id: 77ea8880-b403-4e39-a219-08df0aaf4980
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|22082099003|56012099006|10067099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: LyiEFOk7rRZ6oGiE5sW2xuKoTLd9Rc86bXyDkwehdufdxz5vkFnM7ib8M70owKR+wpakMACzYLA1jX7QW+8YfKYwi0L2BUWZqOuu3mV8sg000MTQ4IjSY+RMg+hJ/EhuJNcymHJ++L1LQp02NswPu9JDFBxxFCwl+gU+C0grECYJYV65NgkN+iBWSDYqZlInnkKNcONNtbGfeKssUpCAIqeWu+gJtybFOlqiEXeaIIUMKEKm1Qzsuil26+8gle+J48ehdtXnrqFC7dOcqHdxc4v8EnspjKfcT83EkpAUYJ8QSqRBqoD9I4Gw7kZEEtkwCugemGXdMDzKk3On4U6ra5Ow0KQJZDy0f2vJ6OE8GgA+rbyFAqBhh07K9Abh/bEPfo8fnuSjLLzk1C5/WjlhHOJNOQOinbxnCsPIWUA4Pzpjh3AOtOhLHTsweexdyqlmA6lw+v4zzAcKQnDXmYEMwntMxxt8LcaOBZ1xos1ejiZbR+NyNil/agE0d3Zg7/rt/MH1WCaWQTMxI2WAEdQI9HgAfdtyr0zueGZJdumrlEMhKSveFbLtWZfzYHQXStRMUFcwui/Miayf/tlfAItSA3ipPA1zCZEc36PAvTyFE5lCVQ9QeuyOWLbzC4CRxWnnzQRpcjmhb7utVuvAqFLUYMBG7nzEJLJuu5sGIdlbHV7l/QbNBbE9s/qiHfDOZxpvfYCsF2NidaMNI4Q/HAKf8w==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(22082099003)(56012099006)(10067099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HdKPCfG6nX5P+n1icSPtE+nAMDeJUnQ/aJrjxJ4wGRZTCZ8Cvlez7UxHCMvM6yaqRQzLCkq13fMjOZkDQA/xnYh5nmDaSi/R9TfRaRiHsma2Da6o5fZygB0IpCr51lOmKxf1kT06NKnO5AHrBeOVFEHJnbKSt9d+RWow8IjG2pZzNYwzEA7aHDAkkUjK+TAL2IwazuHo2A/unPg/hJDnLrI4mvby5eq11sYvlr3+kaCC9a6vD/LaYjQL6hOlXG2NxHsd1S2re4f1uWS5MkEX4qy1CbXWzysnUFnAW2aHGhQH0agl5REdCJRQf9veQKdp17z3BkN2gM26W+tywkUrHvG7wFk6/4xpW+y/DWjAaoakzJfIvMiEbf9hEOZCv3COotDtPS3CuQDzvdleDYyWTd/cOkBHg5Av4djfgW/Dg2Ngv7aDtI/TD4yHDrLQw6Tg
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 18:06:47.6679 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77ea8880-b403-4e39-a219-08df0aaf4980
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6191
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
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

Move the body of smmuv3_accel_event_read() into a new helper,
smmuv3_accel_event_read_one(), that reads one vEVENT and tells the caller
whether it propagated an event, found the queue empty, or failed.

Subsequent patch will make use of the helper to drain the queue.

No functional change intended.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 91aca1aa14..fc503578f5 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -484,28 +484,38 @@ int smmuv3_accel_event_read_validate(IOMMUFDVeventq *veventq, uint32_t type,
     return 0;
 }
 
-static void smmuv3_accel_event_read(void *opaque)
+/*
+ * Read one pending vEVENT and propagate it to the guest event queue.
+ * Returns 0 if an event was propagated, 1 if the queue is drained, -1 on
+ * error with @errp set.
+ */
+static int smmuv3_accel_event_read_one(SMMUv3State *s, Error **errp)
 {
-    SMMUv3State *s = opaque;
     IOMMUFDVeventq *veventq = s->s_accel->veventq;
     struct {
         struct iommufd_vevent_header hdr;
         struct iommu_vevent_arm_smmuv3 vevent;
     } buf;
-    Error *local_err = NULL;
     int ret;
 
     ret = smmuv3_accel_event_read_validate(veventq,
                                            IOMMU_VEVENTQ_TYPE_ARM_SMMUV3, &buf,
-                                           sizeof(buf), &local_err);
-    if (ret < 0) {
-        warn_report_err_once(local_err);
-        return;
-    }
-    if (ret > 0) {
-        return; /* EAGAIN/EINTR */
+                                           sizeof(buf), errp);
+    if (ret) {
+        return ret;
     }
     smmuv3_propagate_event(s, (Evt *)&buf.vevent);
+    return 0;
+}
+
+static void smmuv3_accel_event_read(void *opaque)
+{
+    SMMUv3State *s = opaque;
+    Error *local_err = NULL;
+
+    if (smmuv3_accel_event_read_one(s, &local_err) < 0) {
+        warn_report_err_once(local_err);
+    }
 }
 
 static void smmuv3_accel_free_veventq(SMMUv3AccelState *accel)
-- 
2.43.0


