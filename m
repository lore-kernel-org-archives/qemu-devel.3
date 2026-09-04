Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC59C79F8C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 18:07:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2YJm-0003eN-Lz; Fri, 04 Sep 2026 14:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1x2YJj-0003bc-K4; Fri, 04 Sep 2026 14:07:11 -0400
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1x2YJh-0001lE-Sq; Fri, 04 Sep 2026 14:07:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hElyv3InDUEG3jz/iLPcNk/iTcGNGyh8EWnlIfPJyz9R79HpA4bOUhxism4vKtIDXU8FDmkn5D9FePQHRCdU2SLGFOFSjf+XlDCISUWhp1ETx3hqsr6TJ5IuL1WECyU8XtAHrh0Dw4ZmTu+zqlgr35BQmeP+DdkUACh5LISoY2ZsAIobe+Yxen+xSy7/MwVXPHJEb3upt5lUF3rlyDd7nmkJ9adrILByuZHGKIFJO7zyM8c5M3MaT78CGIcQ5aYl1tl5k3hFzjbudIXbgKVwXFWSuY/3q5NiGa2+oyk+d07407iKXYl4QK6CehjzRwDXhhPmJhTIPSLD58a9XRMf2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gz5uRBtFK/IDu4vP2urIKp0swgGuYfjZT/egDXY/Pk=;
 b=NZjsI+WFVJzca7xTnnaYHtyuO8LzdAZOa2TWJgwMrl2xQDmhO7ugaNROdYdOA5lMPe5+jqAERcwthnL99ccBVZRD/HKEyhxTKzTI3nbUk3KEejHyX/SYHGcfwo95aBk9p/2W8V6ayOyiaEzMmu1h4zyY9ed/OP+nmchuYKvT+7cg9AAbbR1MW1bWOnlqmrArxzg9yr08T2FuRDqVlkve1yprKy42hgXNiqx/Lpc18DCjYYknaIytLhuYatbQ4L7JZSzYcZHNFTdy8lJ2EgQL0Uutb8qRmBbSvbKCRfENDms5wRYo1RsmBHRdGGPmtB3F1zPcJLXdoJui+pKKFiAbPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gz5uRBtFK/IDu4vP2urIKp0swgGuYfjZT/egDXY/Pk=;
 b=KVi/Vs9LVbec4YKY5u9/xljqvp8YiiGJKmDmumSPTWQ22tZ17HvdzSaUrXpy6XyOCffUaDgZ68cKFfzKji4oXrcAvtkAx0v6fLhOyZx2vSPGbk42uo1PRBNbgJj99Muc5fgj2idl3dDT3QSZ/K9v+ZfmIoNWeTulPa+DL17+qar+fRbZDuf5jSrSorAe9Dy5esp8YeIDcWR/+PopYYLOClKgaWZv0qqoZQVRUmboMtJCdh42X4JSLE0HCX4YrkrLRZxk1aRS8JnImNhKvXW17w6QoDNIOpYV9muLgABEhwasuIskZifKu3mhl0bQ0HTS8GDqUC2CZnvmBQEQDNG3bw==
Received: from CH5PR04CA0011.namprd04.prod.outlook.com (2603:10b6:610:1f4::27)
 by DM6PR12MB4386.namprd12.prod.outlook.com (2603:10b6:5:28f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Fri, 4 Sep
 2026 18:07:01 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::4c) by CH5PR04CA0011.outlook.office365.com
 (2603:10b6:610:1f4::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.13 via Frontend Transport; Fri, 4
 Sep 2026 18:07:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00029927.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 18:07:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 4 Sep
 2026 11:06:36 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 4 Sep
 2026 11:06:33 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jan@nvidia.com>, <jgg@ziepe.ca>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <skolothumtho@nvidia.com>
Subject: [RFC PATCH 4/7] hw/arm/smmuv3-accel: Add a helper to replay all STEs
Date: Fri, 4 Sep 2026 19:05:10 +0100
Message-ID: <20260904180513.248396-5-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00029927:EE_|DM6PR12MB4386:EE_
X-MS-Office365-Filtering-Correlation-Id: 36e58478-f86d-45e5-bfa9-08df0aaf5150
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: SqkGBaObYpQIkWp+sWaIG6QLvsnkmWGF0MUIneVvxKUYPkS08qMmf94ifhFh/U3OPwOhWmfHUWJrru97LOUPii1l2rBHFbAhRXWoZNBIqViVQYZhMe2QqS3yv/Ylnsm02GJuhqtVsFNfRxNxhuO041+VOwvIV4DU/8OEZYjW0z47Jv+TBAM5VjwOekMSjpjyaDiql5Wf6uKA87N6J4z6tzoxQF6cXg3mgltXhEYPj841wMH6ag3BDzltFDHL6eyZtXTsHTaZ0mtC1p2Pz4B2yH13EOjueHfqQgdb0Bj7oQCbHIMmSs2b7ZJDspKYJIOWj527ch254qkUrKn/29XwLjqfVPZ9pAQ98+TEcsHH85OFSc+KDQFfvumr7TBwRdbJtXxtOLMf1w6MWj7krfCaSPuriiRUX9wNiqmyeU9kJY5PiuCOr/MtZ/uXrHLAPG5ZeWqaTuemoU1sA1NvZGW1czC5n2SaSUKMo3EJkXtrElFYz8z49O4xZyLIaAKnze1GA7GuoH+hLMr3Y44Ckj+/BS8zszB4N+EsCl3l25xSamgXI8Xd4ZI+HMtam9aMzXHMLNfvy6K6sYpka+z6dFw5Iq+kPgRIpwSJl7gozCeIw3vLWPR6MUFZJYNTd13LZnRKVnPtK7MtmdhrOMzkJEEEJL4xe5qqe1kyB7S47dNZQag/CeRiXWN1drV3QwqRNkVbjO8ioy+nPZX8DM3OL28Daw==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6VHr00Lif7TIZJdZhPoB9Sl7uI1tnZgqAvo54a3uysCxP0BBr9sm2Dob7RczkpA6GiRTbHM/FoUBmWo8WovaXAkh1h+E0c95bxu6ldzT+F4KWSp79RdSJeqqfnvTfYBVW3qmQOvZHnBmngEaxV1nYgKqdx/uZj31waGtBYrYf6T/DqnHD0y3CBfxEYcyFl+ZJ4C4CoQOVWTMODWEj3YJfyMirVxnacyajXO/Fi/pjc6uSkk0XsTTUExcqByIHtKGMwdPYrngrjna9hOrw+gfNNjU31vvbE0YHixdB5TNs2kbIyBTqbEK8H27TdGlatUu6StU4PZHsG0hTgB+X0Bj+vWxhWRKdDRWZPE/3tdMsEd4wyx9PIoQn0w8kP6kZPQZOMJ8Mp8yQjNw+8ctKYcW8o38zNrfLIkoELihG2HXlP8F0zsb34+3REsBriNgjpMn
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 18:07:00.7812 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e58478-f86d-45e5-bfa9-08df0aaf5150
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4386
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=skolothumtho@nvidia.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
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

Add smmuv3_accel_replay_stes(). It walks the guest stream table and calls
smmuv3_accel_install_ste() for every device behind an accelerated SMMUv3,
which rebuilds the vDEVICE and the nested HWPT. The incoming migration path
uses this instead of transferring per device host state, all of which can
be derived from guest RAM once strtab_base and CR0 are restored.

No caller yet.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.h       |  1 +
 hw/arm/smmuv3-accel-stubs.c |  5 +++++
 hw/arm/smmuv3-accel.c       | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index a91d188d61..24828ba9ab 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -92,6 +92,7 @@ bool smmuv3_accel_install_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
                               Error **errp);
 bool smmuv3_accel_install_ste_range(SMMUv3State *s, SMMUSIDRange *range,
                                     Error **errp);
+bool smmuv3_accel_replay_stes(SMMUv3State *s, Error **errp);
 bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp);
 bool smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
                                 Error **errp);
diff --git a/hw/arm/smmuv3-accel-stubs.c b/hw/arm/smmuv3-accel-stubs.c
index b57b5c01e7..0514915e45 100644
--- a/hw/arm/smmuv3-accel-stubs.c
+++ b/hw/arm/smmuv3-accel-stubs.c
@@ -28,6 +28,11 @@ bool smmuv3_accel_install_ste_range(SMMUv3State *s, SMMUSIDRange *range,
     return true;
 }
 
+bool smmuv3_accel_replay_stes(SMMUv3State *s, Error **errp)
+{
+    return true;
+}
+
 bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp)
 {
     return true;
diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 287ea91fbe..6678e49f6e 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -407,6 +407,40 @@ bool smmuv3_accel_install_ste_range(SMMUv3State *s, SMMUSIDRange *range,
     return all_ok;
 }
 
+/*
+ * Install the STE again for every device behind this accelerated SMMUv3, by
+ * reading the guest stream table once more. Stops at the first failure.
+ */
+bool smmuv3_accel_replay_stes(SMMUv3State *s, Error **errp)
+{
+    ERRP_GUARD();
+    SMMUv3AccelState *accel = s->s_accel;
+    SMMUv3AccelDevice *accel_dev;
+
+    if (!accel || !accel->viommu) {
+        return true;
+    }
+
+    QLIST_FOREACH(accel_dev, &accel->device_list, next) {
+        uint32_t sid = smmu_get_sid(&accel_dev->sdev);
+        SMMUEventInfo event = {.type = SMMU_EVT_NONE, .sid = sid,
+                               .inval_ste_allowed = true};
+        STE ste;
+
+        /* Skip a device the guest has not programmed */
+        if (smmu_find_ste(s, sid, &ste, &event)) {
+            continue;
+        }
+
+        if (!smmuv3_accel_install_ste(s, &accel_dev->sdev, sid, errp)) {
+            error_prepend(errp, "Device 0x%x: Failed to install STE: ", sid);
+            return false;
+        }
+    }
+
+    return true;
+}
+
 /*
  * This issues the invalidation cmd to the host SMMUv3.
  *
-- 
2.43.0


