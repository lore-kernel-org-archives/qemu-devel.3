Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C25D0CD4F26
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 07:52:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbvvY-00070g-Fb; Tue, 23 Jun 2026 03:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wbvvW-0006yF-9y; Tue, 23 Jun 2026 03:52:10 -0400
Received: from mail-westusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c001::5] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wbvvU-0000l7-NU; Tue, 23 Jun 2026 03:52:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qv7F6rElwbMqTVXzrP/9bDiCqOFeo0mzX70kY1RtshLRAhslI3Ooc1glSrIYQqJBnKo9rJHfCc1FDRBx5YGEIiQKCmFT/2h4q58Ry31HOpLPLOGyn203flIpwH4F7iRNKjKZhvbsY1CEE73fBfpjNWdJUaorjvV3Nq68Yhlw8KR5V+v1NybJCudwL2/Z6tuRRyFri/SjrBSQjFyrnM437j/jCWDnAGNF3AxTQqWL52AyVbFhe9V2+95JurqrlB65VLi8opMH370rHHDc1HdYIOz6EvfcqRfPVg7lNvUfuSjxLfF0XMm55ArG/kDGy+4GHqLMSPufDJTvixUuugdIHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NfoaHq4ARm4a6D3x52FnR2TZQi+GHQsYO9BeAx+YLo8=;
 b=tUGs+C7nfs9IfCOjXsizztsABeRquYAwUKAu2YsnYCIEhsXUB7pmpdkrXXaZjSnY1WXGBN12/15FgKHk1qw04olrb6w87Vrlm769ova9+Q40QgF6in+sYL8GFgndWnVYepVz5t8tnPMfyUXWoqHJN4NEPylXSf+A79vQ5gKxuQ8rU5Q/Iw69GQMO48ehou3SAjg8JZgw4zaBRitOU0n+tGfWepwXKvpzRVaAqunUwn8qu9NvPvsne5Yw5FPM73t/AqElwAw+Be04Mqt57HS09oJr8tKKf8gAJT/sQM8mlDHierjW3U4EGdfIrJUX6uJNIhu3hCLSZ/GPTLHptPSbJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfoaHq4ARm4a6D3x52FnR2TZQi+GHQsYO9BeAx+YLo8=;
 b=cM0MzJpG/ctoioIWGOUopVyH/dDPrP9qQeg+SuUOG0w+nGiyNk9LPA+LLPV12MWsnou4eXtLd3VUrwKzZboRVPePMBPoenF9V2svdNUt3/I/F48UXBMv7Mf44vlHIi4MSU96N57PUxm+399vTbFP6lkgoZVmy1GOFyNtvaGJUv7jFYWWwXEXEWF2GPdmyjOtjx8Hu+SjMe8uMcDzxGjEcFQkRfmasfmqtCnZ6WEHFJ6juoMGEosV1v5ihpBUi9oyjWxS3MvicU+AgWHWlv90JcwGs0AsXq4743DKS+bghL5QvVtu0Ws/JXVfddGdxAxOkvEuZ/sYraEB9Qn3Cl8EhQ==
Received: from SA9P221CA0002.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::7) by
 BL1PR12MB5850.namprd12.prod.outlook.com (2603:10b6:208:395::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.20; Tue, 23 Jun 2026 07:52:02 +0000
Received: from SA2PEPF00003F68.namprd04.prod.outlook.com
 (2603:10b6:806:25:cafe::2b) by SA9P221CA0002.outlook.office365.com
 (2603:10b6:806:25::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Tue,
 23 Jun 2026 07:52:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003F68.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 23 Jun 2026 07:52:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 23 Jun
 2026 00:51:45 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 23 Jun
 2026 00:51:43 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jan@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH] hw/arm/smmuv3-accel: Fix veventq read returning true on
 EAGAIN/EINTR
Date: Tue, 23 Jun 2026 08:51:01 +0100
Message-ID: <20260623075101.17770-1-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F68:EE_|BL1PR12MB5850:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a42f686-aaff-47c1-af3c-08ded0fc4fbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|1800799024|36860700016|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: /1akjiU58M+bCsrQFfHdq0kMy38qfaSZIIFSBCHgIOXvq1KvOjaOJ+LPQBzJyHEg9LYBAPV3iQY9kPJiQN43d+oU434/W6wV3j6sYRUqozPvjmxXS5zDr5f8ES5K7R7l/3YJH5DJk0gUHAab+0TsyDTfz1Jb0expd+y3mo9kVoaVZbkGNYobfWRDIHvbhVlxV2Wzq+veN9NCjnuZyUSJaSZF11NIJR/eY2TjZOZ3JtBMf22sa7WeKPo4yJlG9/koBlJBhzGdCNHGwGh15HvrIfQ1aHa3PlYjCxRm5e7NCp8mszvZUbn/4zDTbFYFGThnuglsyXaSoGJRjRSzaBgjXvd4yPDbSZjSCsWQXUjsB8rE5jEKroSCOPHMm1MNAduHvNh2O4y6TKOXtlT7Gatn7V8K0t9QF8goiSo8ej7ykxNK5yeSGsu255nAFKk/OgOLO8MNyN0ydKWZed3+gl6y9JZf6q6INtVInG0EDcZ+gSJRzQyXP+IkMi1jlzwM1g67aHaVhspdMlVPrpuvisBCDrgxMNsg0hiSwtFTPalzd33e6hzB9zUBPN8f63WKGmO8nj+Dm/nPsNBU18+GY2nWItNyBXYNlFTYTanFEu0U5rJY9zEulAyVDtFumFi+U2hnxdMAt1NGRh8IFras8cwAuIODqkhUmMlHai+hw7p4JuBYeoIbsvo/0a714VU+0LzWS8Vy04itao+3lZzozBl9Vw==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(1800799024)(36860700016)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jn8jW/0D+XripOCiPSJfPBczTZD1Gp/KanWx21xidMMrvAiqQczX+0btVQNNQfFST5fszWW2ESB3Tq0zJ2ASv7mcS7mz+paprkfl7wbmaQqt2+68Cp/rdCLsehQK0t+3BRdhz6hl6t6xLVewZa4MN93t2YTysBncyDTkhUhUPAc/sIMjT598HTFG0LIak/5/16Yy/D5PVsIjMbj2Ha1utroo+k6M2oN7etsIIZ0mj1dS0PbUHiWguDvn1VQUJucsq0IC0eNcjDPoqg8BqIAZ8etj6JSrDK5kL90FgqorpcGFmdsoPABze1iixmwqaX9aBldRaWf1yjeeiVi5u8Cv6EslgUO6/a4sP7LpE6RLEHGqfTsXcTqxaIomOc/ISAo9kUEIsnWCWaed7p0liKnrl1xTN2akKNMbtPRu+29I7nsaJ+hkWogArUf2Kdw+ttRH
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 07:52:01.9932 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a42f686-aaff-47c1-af3c-08ded0fc4fbe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F68.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5850
Received-SPF: permerror client-ip=2a01:111:f403:c001::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
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

smmuv3_accel_event_read_validate() returns true for EAGAIN/EINTR, but
no data has been read into the buffer. Callers treat true as success and
proceed to use the uninitialized buffer. Return false instead and guard
warn_report_err_once() against NULL Error in both callers.

Resolves: Coverity CID 1660057
Fixes: d4aea0f75b ("hw/arm/smmuv3-accel: Introduce common helper for veventq read")
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c   | 6 ++++--
 hw/arm/tegra241-cmdqv.c | 4 +++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 80900c2521..6d402d2ba6 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -451,7 +451,7 @@ bool smmuv3_accel_event_read_validate(IOMMUFDVeventq *veventq, uint32_t type,
     bytes = read(veventq->veventq_fd, buf, size);
     if (bytes <= 0) {
         if (errno == EAGAIN || errno == EINTR) {
-            return true;
+            return false;
         }
         error_setg(errp, "vEVENTQ(type %u id %u): read failed (%m)", type, id);
         return false;
@@ -491,7 +491,9 @@ static void smmuv3_accel_event_read(void *opaque)
     if (!smmuv3_accel_event_read_validate(veventq,
                                           IOMMU_VEVENTQ_TYPE_ARM_SMMUV3, &buf,
                                           sizeof(buf), &local_err)) {
-        warn_report_err_once(local_err);
+        if (local_err) {
+            warn_report_err_once(local_err);
+        }
         return;
     }
     smmuv3_propagate_event(s, (Evt *)&buf.vevent);
diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 29c488e0e4..bb0b417e90 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -845,7 +845,9 @@ static void tegra241_cmdqv_event_read(void *opaque)
     if (!smmuv3_accel_event_read_validate(veventq,
                                           IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV,
                                           &buf, sizeof(buf), &local_err)) {
-        warn_report_err_once(local_err);
+        if (local_err) {
+            warn_report_err_once(local_err);
+        }
         return;
     }
 
-- 
2.43.0


