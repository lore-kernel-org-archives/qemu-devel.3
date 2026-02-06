Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 266ABEE20A8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 14:54:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voNCc-0005Mh-JP; Fri, 06 Feb 2026 09:52:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1voNAh-0001DJ-QP; Fri, 06 Feb 2026 09:51:04 -0500
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1voNAf-0007Vx-JU; Fri, 06 Feb 2026 09:50:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wQukcOY4I14N6h1VLdXOtqRoJ2TcCgBW3JLvPT+YaAtq8TE+T2UO6kwCbPHY2ibPEO4U7l7n8pcYG4Gf2BNVzjLPfKdh+Uyi4Or9lNTx65ojOMcxHsf67i2CNzSlxozlAcyHMUuS6jNg/LtFDzzbVnpSL9Z8WI4oUMSKN8rdOP+Qjx6J4r3WWh/0BIVvXgrf3B5Y2EpWf/YN7dZVKDKzz220bgCJVQToZ3tRZHlMw295CmiRnqejlzREJOC+le+Ep65Zg2kpnPJFXfgjdKHTKajD90HIRYh8CUCT8qfsOvefb1ZEjsxEFuIQtRPgP5F5+Fo5tnvGPe458EApc7YS1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/oyEA0DU9nc8jOITakexb84u3tlw0o36hi12md9REPs=;
 b=e6M+KDpyNCBvMzawmogg5BhwPzqqbq+NBCFVmU4pU7AkKorC1l09c5NbVFFyIf7cCG7fW5NsO70y+vyfuG0i9ECnrNH7nTlye5lfag7XDBJof1yefqgeENMclmqhRWvWX8mX4TbyJc6SEM1eintSxI/+c5fLyQWTJ5x+yOk4QfVW9T0ArZ8i7Fmd4gTF6aCDXDhEztnsJzm8S/KKqG+rO6Yvgd/dz81nAJ9jHk1dRvGJSB8EPtxTZNG3mtGNrtGDWK3Wt5Tmz6cTGVC1obthIatd9h8jXWmy366smNcm+KXRcVcVa4x7ZU6SmRkqWF9KkEnzpJQU+soQ/Cns+Z2oPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/oyEA0DU9nc8jOITakexb84u3tlw0o36hi12md9REPs=;
 b=AsyXqzlrr2v8U2lDg/NJiqzRASsCYOwlXng1CnTBKc7+VpzDdgEgrA0HJliER6gun9CZnB5nysDnBJJ0xVQQ5lvAxLOlo6/QFWxDNN01FgWByXVrPjKjZ+KA6/WAFHCpPdOAjgw351PRPi37SKyw2JwL9DGDJgr8CN9xYE3BlrRSWcOipgabX0ruFD/4g0C1VU4Tgtdz7EqexGS1Qn9aPi0cpOtgM4wxOYsud7Hg4EDc83KjvJSvqGDwi4K6WQVjePH/T9pt1ZMEmMooW9iVEEqYsd05KhPeeqzwzx17tRLl+K4s/0y8dSdL5rKW91n1Ju+4UHLHdwaGKJ77PNHL0A==
Received: from CYZPR12CA0015.namprd12.prod.outlook.com (2603:10b6:930:8b::15)
 by BY5PR12MB4083.namprd12.prod.outlook.com (2603:10b6:a03:20d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.16; Fri, 6 Feb
 2026 14:50:47 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:8b:cafe::f9) by CYZPR12CA0015.outlook.office365.com
 (2603:10b6:930:8b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.16 via Frontend Transport; Fri,
 6 Feb 2026 14:50:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 14:50:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 06:50:18 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 06:50:14 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v2 18/24] hw/arm/tegra241-cmdqv: Read and propagate Tegra241
 CMDQV errors
Date: Fri, 6 Feb 2026 14:48:17 +0000
Message-ID: <20260206144823.80655-19-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206144823.80655-1-skolothumtho@nvidia.com>
References: <20260206144823.80655-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|BY5PR12MB4083:EE_
X-MS-Office365-Filtering-Correlation-Id: e347c181-233f-47df-98bc-08de658f1cdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QTVhYm4xS1NBMDR1akNiWTZ6ZFJCdVFvWmM4RWFReXBvNmx1T05hcDlWNlZx?=
 =?utf-8?B?QWJPNkFMc0dBZHBMcGZXNlgzNEVEQWV0SGdpQlJNYWtNVVZ5dko5cElDNWNS?=
 =?utf-8?B?RlV5RjFoa09vNzNKcHU4OElSa1JRck51Z20xcVVPWVBHeHZIRkFPSTRPMmtn?=
 =?utf-8?B?ZjNjTkJQTS9pVlVzbGRQZlJ2NFJBMEhlaWtXbExlZXNNK0hYZTFDTWZlc2pt?=
 =?utf-8?B?bU9EekRPZGREOStqMFZsbkg1cVdBY05oRzNSV2E1OG9sK1dpRExjdzFVcWNi?=
 =?utf-8?B?a2E4UDY0QlNPY3Y0QzRiSHNkWUVWQitsTm5Xa3dBWDNORW9ZdWpodUgxQTBl?=
 =?utf-8?B?UDNuVjVFdXFEZ09ncFUvdGFlQW5rV3VUdENidmN2enNqK2F6a2FiM2N1NHhC?=
 =?utf-8?B?ZjEyQ1NLc0xHRWNEK09XOVlyUFVBeDZBa0lRZUh1NFZvWWFWZk92eGNPVEI2?=
 =?utf-8?B?SWp5bUpvV2t0anUxM3B5WmNkSGM5T2FkNnV5RGxzdVU5WUtYSGwxSU8vKzlQ?=
 =?utf-8?B?cFM0ZEZJYm5CcWpPYytSZ0kvRzVjZWxlSEtzY3RRdXp6RXoyYWdZZ21DVTR2?=
 =?utf-8?B?MlQwY0V4MTVsUFVaZTBGa3U4Y2ZmclRjTkhVM2hUejI2T0QvNWo3ZHNQT2E0?=
 =?utf-8?B?Y3B6NlVTK0dOYVRwcDBKRTUxNnFPOHpyWCs3Nnc4bmE2ejBjRjIvQ3podCtL?=
 =?utf-8?B?aHlBMDNsZlJLWXBEU1I0dW9ETHN6SFRKMEx0Y2pRZlMzY09xWDVDanpZWTNr?=
 =?utf-8?B?S3ZTU0N3d2ZWWFEwODlsUE80MDE0MGZCRW15aGx6SnhyK1hqSGphSEFNQ1Zu?=
 =?utf-8?B?d1lyU0xOWTU4R2kyZ213RmtJV3JleWQvZVNDa2drRVRkeHB2UmMyVzArZjhO?=
 =?utf-8?B?Mk9oMVJPNXVaMS92U25MZDdtL1Fpc1F0QkJGeEhDL0Q2RHJaektXVVMxdzZx?=
 =?utf-8?B?OGJJdVB1dTM3UUNHYWpvT2NIQ1QxNG5jZ2JYdW9yOE90OEwzd3piS3VHWTZQ?=
 =?utf-8?B?V0hjS1VyMk1maXFxUlRJVEZEL3JiWmdBNE1GejhMR3kxQVMzYXpVbmFzc0ZL?=
 =?utf-8?B?YTNnc01Memp2Y0Z2ZFRobmg4ZEhVdXhVbnNKY1dxeDUwQW5sUDNFN0lnY0VZ?=
 =?utf-8?B?TlhScDhFREY4SElUVEQzQ3hEYWVOYXRzTmZjaTFkcmY2MjltL3lsL1FaV29U?=
 =?utf-8?B?NDZmRFlqcWdkWWg2ZUIyZFpOQit3dTVrVGE5MUh1dHFJVGxqL00rTVdoNzB5?=
 =?utf-8?B?SjltcllHdmxFbUFpS2daSHFvWC9VaWRTd0V0KzIwTmNQRzloQjBUaE9MWm8w?=
 =?utf-8?B?NSt1Ti9lRzBhUTJSczVVVjVzL1ErMnFBYnNLOC8xZGlnQ2xQaWtiQXZXQnRG?=
 =?utf-8?B?ODBaNHhuU2xNY2U2OFhWTmRxWW1YcXR2Y1ZGazZteDlic1dTSmtkVFo1S3Jt?=
 =?utf-8?B?WXFTT1Vsc2kzSXFGbllHeTluQ2ZCVU1SWU9kb0k3VlNTcHRPZG1XWjFYYUlL?=
 =?utf-8?B?Sk81M2crZkE2NnV1SUJjTzMvRTJCT294VWNHTHVSR1ZTdnV1L3hTbnFGTEdI?=
 =?utf-8?B?V0ZxTHRmS1ljZVhpQkNlQlgwbmtOY080L0swTDNpdE95Y3VHYUE5Rmh4ckdC?=
 =?utf-8?B?K3UxaXNQWFg0TW1yREFVUWFybkxjUnJKKzJuVkxlc2NHNi9mb2FTNDNmTW1G?=
 =?utf-8?B?RlBHVFhqdDdvOHVMSTlEYXNTc2cxMEpHSng3bkxRazVMb3BORlFyTVRTWmFC?=
 =?utf-8?B?bUpsQXpqNGZGOFg0SFFrL0hycWl2LzY0U0FDd3ZLZzVlMEozRFZZMEJVS1la?=
 =?utf-8?B?dnlkaVlxSjNOcTdiQmxxS3o3c2hpbm1jUDBPSXRaNjBQK2oxN0l0QkJyTFRH?=
 =?utf-8?B?SUNaN1NIZkRGWEt0dmVvZ0ZGWGtMSFJucHBJUE1wQmEwRkc4Z1ZFOUVwTisr?=
 =?utf-8?B?Qmk2V1FZYTFQeCtEWlNvY0UxY1g4VEdndzlOVGNVc0NXSXpNQk5taGNQOHds?=
 =?utf-8?B?UmRES1V0VjBKOFVRQ1V6RC9WcGJyR2tabE1rTHFqenQwYXZkSWMxa1FTR1Zw?=
 =?utf-8?B?ODlsUXI0OG5PZ1pCeVZzd09KVWNhQnZnMWxsZjFxQWw5Yi9lRytTYWtDQmZu?=
 =?utf-8?B?NitaWTh3TXBvWUNSSEk3cFg3RTQyQ2hqd0lDMUdLYVB5ak91NVdkZWRKWDlu?=
 =?utf-8?B?bThrS2ViRXlXN2ViODdqZWZvZnBnRDhHQ1pNZXozRHI3a2R4am5CYjk4K1Zi?=
 =?utf-8?B?ZzM3WHZjTU5SV1JTK0poWHZsTkNnPT0=?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6LjMt+x481sUDGAxiJAAsZb6vmANx3DA0p3cZovkNjta2ds66PsX9dWlM355FPfOdme9CbRSSynDbwGMdSkGyInJFuvoXxa7i1DT0jlMDHbgnH5tR9GD+vTXjWWT+YxCRkLbQSDJH39vvC8ul92Y+pWSjo9YGkYrMziIu8voza0n0FSqrstDgAiA6M+3gq+QV5aYuCrosRngYXjQVay+CMUUI4guud96XdJMqxU03ENR2sLmbuwS6siIGG9LwYdn2dZdOPmnc7y65FpczEL/BAJr8/b3w2pbn1KCAuMjFvscyvEoUwPw5MdYKpf6DHrK9xZB8jYm97SpWq/lCJsEUg0Zbd36ImF4xTEtn4QJ1WTq3tQykintXlOdYRhCVnxGg6z2dkTxCOY6yfjDxm8yMMUZkHQnE/KZa0aaOkSnkIkU+bgO7U2fjwqVqnZ/kruZ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 14:50:47.0541 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e347c181-233f-47df-98bc-08de658f1cdf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4083
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
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

Install an event handler on the CMDQV vEVENTQ fd to read and propagate
host received CMDQV errors to the guest.

The handler runs in QEMU’s main loop, using a non-blocking fd registered
via qemu_set_fd_handler().

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.c | 83 +++++++++++++++++++++++++++++++++++++++++
 hw/arm/tegra241-cmdqv.h |  2 +
 hw/arm/trace-events     |  3 ++
 3 files changed, 88 insertions(+)

diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 9e0e07e85e..3dc5315677 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -8,12 +8,76 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qemu/log.h"
+#include "trace.h"
 
 #include "hw/arm/smmuv3.h"
+#include "hw/core/irq.h"
 #include "smmuv3-accel.h"
 #include "tegra241-cmdqv.h"
 
+static void tegra241_cmdqv_event_read(void *opaque)
+{
+    Tegra241CMDQV *cmdqv = opaque;
+    struct {
+        struct iommufd_vevent_header hdr;
+        struct iommu_vevent_tegra241_cmdqv vevent;
+    } buf;
+    uint32_t last_seq = cmdqv->last_event_seq;
+    ssize_t bytes;
+
+    bytes = read(cmdqv->veventq->veventq_fd, &buf, sizeof(buf));
+    if (bytes <= 0) {
+        if (errno == EAGAIN || errno == EINTR) {
+            return;
+        }
+        error_report_once("Tegra241 CMDQV: vEVENTQ: read failed (%m)");
+        return;
+    }
+
+    if (bytes == sizeof(buf.hdr) &&
+        (buf.hdr.flags & IOMMU_VEVENTQ_FLAG_LOST_EVENTS)) {
+        error_report_once("Tegra241 CMDQV: vEVENTQ has lost events");
+        return;
+    }
+
+    if (bytes < sizeof(buf)) {
+        error_report_once("Tegra241 `CMDQV: vEVENTQ: incomplete read (%zd/%zd bytes)",
+                          bytes, sizeof(buf));
+        cmdqv->event_start = false;
+        return;
+    }
+
+    /* Check sequence in hdr for lost events if any */
+    if (cmdqv->event_start && (buf.hdr.sequence - last_seq != 1)) {
+        error_report_once("Tegra241 CMDQV: vEVENTQ: detected lost %u event(s)",
+                          buf.hdr.sequence - last_seq - 1);
+    }
+
+    if (buf.vevent.lvcmdq_err_map[0] || buf.vevent.lvcmdq_err_map[1]) {
+        cmdqv->vintf_cmdq_err_map[0] =
+            buf.vevent.lvcmdq_err_map[0] & 0xffffffff;
+        cmdqv->vintf_cmdq_err_map[1] =
+            (buf.vevent.lvcmdq_err_map[0] >> 32) & 0xffffffff;
+        cmdqv->vintf_cmdq_err_map[2] =
+            buf.vevent.lvcmdq_err_map[1] & 0xffffffff;
+        cmdqv->vintf_cmdq_err_map[3] =
+            (buf.vevent.lvcmdq_err_map[1] >> 32) & 0xffffffff;
+        for (int i = 0; i < 4; i++) {
+            cmdqv->cmdq_err_map[i] = cmdqv->vintf_cmdq_err_map[i];
+        }
+        cmdqv->vi_err_map[0] |= 0x1;
+        qemu_irq_pulse(cmdqv->irq);
+        trace_tegra241_cmdqv_err_map(
+        cmdqv->vintf_cmdq_err_map[3], cmdqv->vintf_cmdq_err_map[2],
+        cmdqv->vintf_cmdq_err_map[1], cmdqv->vintf_cmdq_err_map[0]);
+    }
+
+    cmdqv->last_event_seq = buf.hdr.sequence;
+    cmdqv->event_start = true;
+}
+
 static bool tegra241_cmdqv_mmap_vintf_page0(Tegra241CMDQV *cmdqv, Error **errp)
 {
     IOMMUFDViommu *viommu = cmdqv->s_accel->viommu;
@@ -435,6 +499,7 @@ static void tegra241_cmdqv_free_veventq(SMMUv3State *s)
     if (!veventq) {
         return;
     }
+    qemu_set_fd_handler(veventq->veventq_fd, NULL, NULL, NULL);
     close(veventq->veventq_fd);
     iommufd_backend_free_id(accel->viommu->iommufd, veventq->veventq_id);
     g_free(veventq);
@@ -449,6 +514,7 @@ static bool tegra241_cmdqv_alloc_veventq(SMMUv3State *s, Error **errp)
     IOMMUFDVeventq *veventq;
     uint32_t veventq_id;
     uint32_t veventq_fd;
+    int flags;
 
     if (cmdqv->veventq) {
         return true;
@@ -462,13 +528,30 @@ static bool tegra241_cmdqv_alloc_veventq(SMMUv3State *s, Error **errp)
         return false;
     }
 
+    flags = fcntl(veventq_fd, F_GETFL);
+    if (flags < 0) {
+        error_setg(errp, "Failed to get flags for vEVENTQ fd");
+        goto free_veventq;
+    }
+    if (fcntl(veventq_fd, F_SETFL, O_NONBLOCK | flags) < 0) {
+        error_setg(errp, "Failed to set O_NONBLOCK on vEVENTQ fd");
+        goto free_veventq;
+    }
+
     veventq = g_new(IOMMUFDVeventq, 1);
     veventq->veventq_id = veventq_id;
     veventq->veventq_fd = veventq_fd;
     veventq->viommu = viommu;
     cmdqv->veventq = veventq;
 
+    /* Set up event handler for veventq fd */
+    qemu_set_fd_handler(veventq_fd, tegra241_cmdqv_event_read, NULL, s);
     return true;
+
+free_veventq:
+    close(veventq_fd);
+    iommufd_backend_free_id(viommu->iommufd, veventq_id);
+    return false;
 }
 
 static void tegra241_cmdqv_free_viommu(SMMUv3State *s)
diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
index a3a1621e3a..fddb3ac6e9 100644
--- a/hw/arm/tegra241-cmdqv.h
+++ b/hw/arm/tegra241-cmdqv.h
@@ -35,6 +35,8 @@ typedef struct Tegra241CMDQV {
     bool vintf_page0_mapped;
     IOMMUFDHWqueue *vcmdq[128];
     IOMMUFDVeventq *veventq;
+    uint32_t last_event_seq;
+    bool event_start;
 
     /* Register Cache */
     uint32_t config;
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 3457536fb0..76bda0efef 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -72,6 +72,9 @@ smmuv3_accel_unset_iommu_device(int devfn, uint32_t devid) "devfn=0x%x (idev dev
 smmuv3_accel_translate_ste(uint32_t vsid, uint32_t hwpt_id, uint64_t ste_1, uint64_t ste_0) "vSID=0x%x hwpt_id=0x%x ste=%"PRIx64":%"PRIx64
 smmuv3_accel_install_ste(uint32_t vsid, const char * type, uint32_t hwpt_id) "vSID=0x%x ste type=%s hwpt_id=0x%x"
 
+# tegra241-cmdqv
+tegra241_cmdqv_err_map(uint32_t map3, uint32_t map2, uint32_t map1, uint32_t map0) "hw irq received. error (hex) maps: %04X:%04X:%04X:%04X"
+
 # strongarm.c
 strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
 strongarm_ssp_read_underrun(void) "SSP rx underrun"
-- 
2.43.0


