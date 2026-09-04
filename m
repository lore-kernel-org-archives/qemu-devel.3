Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0A8CC79F87
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 18:08:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2YJv-0003gE-62; Fri, 04 Sep 2026 14:07:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1x2YJm-0003eV-JS; Fri, 04 Sep 2026 14:07:14 -0400
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1x2YJl-0001nF-3t; Fri, 04 Sep 2026 14:07:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C56H8Dl6Tp6fWP5is2IJYKHSAsii4aR0O77JEy0VhW/fK1/EXl3fLck+C67BYZi4SUTqX019aFSTCu+GnQi/Ma/dxjLwdqf7dvwtZLEY+YeJ4Xpo9k/PO5ky3Shnry3gP8kVjp4cSfsWQW+O76YJpnKhT18FzBe6ztPL7gSUo7HUKjjvRu1QhAU8n8oKKpv59DrxJmmv38dGos51oc9lAU/Feu3d6iRo0EtroPumtDWF/Z5yNumX7J5My8thkkFDZ8cQI7YBW3gro9Qg4LUkdURQ/w5Bi6nnUn/9/8DrLEw19yboE+R++Tq7jWsNvLTqL7NP5rZoXwvj7gMDCV7bvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZB5i8WRh/0Jo6Uj5VkhaAU9qknn1GDguvQHphZ9N3qM=;
 b=DLvyDmL+F+Uy5o/7blwmKoDQx/hiXT5TTa/4sabIfVwjBWwkB7Ic16Rol/l293PmSZuGISwLdtQUneCleHe59TfPfzOYOvevgjFkRpAtcJ4u5Q+8vXwKFrZgaWcjR6mmQHX3t3+TxdzsbBGwFSEX6OCUpefeus0k1qupxhe38re5vRnTKNVD/UGAiRdjrVi9f6Zg/jTcWRLf3xiXofdekpuiXTyS+2iDetkvYMlt8oA4IxfOoudWlabbYeHdMyG56M+8JsH4BZoNKCUTh+o8r3D1hUhHVi2W+9sR7mF5QmJ7oD5HhlvBdmsm7ZybLtpJn2JL2toqTnYf/5qW7AIuQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZB5i8WRh/0Jo6Uj5VkhaAU9qknn1GDguvQHphZ9N3qM=;
 b=JkyWS8eFdWxlvpn/ziOx9cS4NdgqU+DsDidHg7MUzlvhJ+sRK6W6ijuQgIZbFa45ToHQsAWXw+loIvl9t+NcMsX1tALNXv2CXtjANbNVUoqXItjXrnly177tA/soYj+3aNuHhkzMrJTW4deyaoEgykkHwk/lplvMeKwMvhAnDQKClN5z9BhkC2lAfLed91xB30jM4/A+3+UaknfbntVDpyEKXNAcMiL2rltM2ZQS1pdbnbBzOY5X1CSJaJk2/fWEOhhYeTHik0pyrcnyvElJ/FxZLT2OwdrrvTNUMuJ6dU98WGyqG1De5Z1omaC79/CjZtQZBH9/7KLQmJJgRrU46w==
Received: from CH5PR04CA0015.namprd04.prod.outlook.com (2603:10b6:610:1f4::16)
 by SA5PPFF1E6547B5.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8ea) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 18:07:04 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::55) by CH5PR04CA0015.outlook.office365.com
 (2603:10b6:610:1f4::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.13 via Frontend Transport; Fri, 4
 Sep 2026 18:07:04 +0000
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
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 18:07:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 4 Sep
 2026 11:06:40 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 4 Sep
 2026 11:06:37 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jan@nvidia.com>, <jgg@ziepe.ca>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <skolothumtho@nvidia.com>
Subject: [RFC PATCH 5/7] hw/arm/smmuv3-accel: Restore accelerator state on
 incoming migration
Date: Fri, 4 Sep 2026 19:05:11 +0100
Message-ID: <20260904180513.248396-6-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00029927:EE_|SA5PPFF1E6547B5:EE_
X-MS-Office365-Filtering-Correlation-Id: f189d651-1cfb-4a4a-af0d-08df0aaf5360
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|56012099006|10067099003|11063799006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: VuVhkkj3sXJpfRAnV9mIgufysixobLlvqI5yE2YbdBcATYeZlks7FuVJ1KNYbXaYvzlprxbx+2OmWlr8KxyiH5QgWH2qbL3RsZnxYtHxJT9177mvU428dSX1WrfPZbMu1OL6HVCCda94VcPqPd4MICo2/Dgp9b7vGg0tmtXz1ZsDuSldcl/P3opZ4ym5txTGsgUAL2aTfr1mgKB0XBVc12B/t4hFlMnGFVvDUfcmPxhJsMQqEx8leLnZb4q/bKGXFrtG8s1yIYkAnqqPfMuOt0raC6BZd2snJudil60lNCpHqIIRaZngC3Ufal5OqwXcOrDjqzQCsKdKI8xFtnVZch8LlwUhUCeqBdrjAwN+l7bcoV26Mq6GAbwnd1miEKrm7IlmZL1wqHtbEFEgL7tri5Re3g5qie4WY/HfdSo6lMfpAHKudn+2P1+m6wnruaigxtx5vUR3v3vZ0p1YjqAtHQYhQ3Kf8I8B5YXoGh5E/CLdY8PKivQN1CqhOMR6n+KsPBJD1Im+yAnezhcvUnGRFBeX7QXCOB+Mds07fp3WEC2w7/uWGEnDlPkG0OQRMkuzdjx8TbPIdW67igk7t3/493+aUZ38ns6uxMT6fggG5zMZforEMZrWePJgRJ0uLOpQ7J8IbtQuPL/wR8R+wS+5JKwMbrGCPl62Er6RHmp/aetV+ZLY2O2PNyESbsM7Wzj5yiwkCu7mV9yAAYoeJx6HWA==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(56012099006)(10067099003)(11063799006)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KbkhrkbEvIDPO2+6C4egbW7/QhIqruF4ekamNGG5tabU0Xbrbtl28H+9ZOFeGrwGfTf1KZYLhnq9GNSfQk1T1gikhHt+1Tf5/L8lY74BKGyfEK+WFCsbPUJeZfX7g7qEWahXrEMFPQGZ3qohd4Dx8ZH3BS8TdBp69z/BHzHUNpZdbOkyBpJhvXtwbiK9tuMQ5aYVVcHQ3Z9/PMspz1aF8dxOytRMOoS/2nYqXhwPjxs2cQZsyLcIZrBAZb+vJJ9ITypc+BmJIk0cAh9y/gmjyRtQg61lXXgdqrYKdf+AcS0BLv/fcb+e0KHj1eWFOistObL87mf5OVFjdjkPvDt8PF8PTMKOcnS53yz/v7BbxkEeqJTiohigtkq4PZ+RdfJ91KQdPMl+rmJuC4gV+l9CBCsXAHOaQUJr6XeDfCRy7Kgjmsw6gQdnrrtWKl82EVoo
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 18:07:04.2334 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f189d651-1cfb-4a4a-af0d-08df0aaf5360
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFF1E6547B5
Received-SPF: permerror client-ip=2a01:111:f403:c110::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=BN8PR05CU002.outbound.protection.outlook.com
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

Extend the accel subsection post_load, after the IDR check, to bring the
host side back in line. It allocates the vEVENTQ, which the A_CR0 write
handler normally does, using the restored s->eventq.log2size. It attaches
the HWPT for the restored GBPA to every device. Then it replays the STEs,
which overrides that HWPT wherever the guest has a usable entry.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 6678e49f6e..b653f3f4ce 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -1165,6 +1165,28 @@ static bool smmuv3_accel_vmstate_post_load(void *opaque, int version_id,
         return false;
     }
 
+    if (!s->s_accel->viommu) {
+        return true;
+    }
+
+    /* Normally done by the A_CR0 write handler, which is not replayed. */
+    if (!smmuv3_accel_alloc_veventq(s, errp)) {
+        error_prepend(errp, "Failed to restore the vEVENTQ: ");
+        return false;
+    }
+
+    /* smmuv3/gbpa is listed before this subsection, so it is in place */
+    if (!smmuv3_accel_attach_gbpa_hwpt(s, errp)) {
+        error_prepend(errp, "Failed to restore the GBPA HWPT: ");
+        return false;
+    }
+
+    /* Everything else comes from guest memory, which is already restored. */
+    if (!smmuv3_accel_replay_stes(s, errp)) {
+        error_prepend(errp, "Failed to replay the stream table: ");
+        return false;
+    }
+
     return true;
 }
 
-- 
2.43.0


