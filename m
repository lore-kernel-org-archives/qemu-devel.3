Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6765D3C909
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 13:41:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTKPu-0007dl-2K; Wed, 10 Dec 2025 08:39:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vTKPj-0007Y7-R6; Wed, 10 Dec 2025 08:39:33 -0500
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vTKPg-0001QQ-G1; Wed, 10 Dec 2025 08:39:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YA0IxmwYyhfiHac6DSoXVrgS6PomhPI75IXkD9BQoJDxULyPfDcmzj+gUN60v+LonhDAWosvw6o7gALQVA0kVI704ytIj0zbOIgACdVom4bnZnwjd6SR9/NJn9UejhaUQ4gysEdgU30dULKX4rD7RU0i5NBKFUVI9zEBRmm2YFt503sJxiPm4WgfGbTlCB++Ukd6tRKtfulpsUqk1vTI9LmjzOy/8ZV9yyQVH3KOxdK/WH6rcZKTuhqk2jjPGiOrd3sZI8JxndGF3WXaYlwItOTnIhU4x1OXy+jtHEkgfV7Qb2zXYhJUgIs+6K7S1gVXkB5tX99co2VYFiKTpvUWSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vMhuuK7H2KpyhKdJsweY18PYcZYtqzvCmwSwRwBAWvo=;
 b=NotJZr7PXB2/ZJIN1I+1sd7UAZ+qQpCVUjFh+0m8U07x6T3cw9/egAMYVJxP/8MrG64FkdnSmfxHS5BaSrQh5eiWHoEkGZV0VI/lYT0XrplGZXMJis4twRu3oa/oMIdnySHPZFj4te7KsbSSqO7jnGRTbho7JrQeKHxB9YrszaCXVNjpzF0jZn2XB9+mhKlxV6WLI2emHvXW7E8JINBvdP9cl02zG04zJZNu8hw6+ppcqCmET3DejlVzvlTLQhG1OZBlPXRc0xmNds3MNyhjdVY/0bCLhU96F0ol2mgzGad0F3+BzE1r8wpxwmgxcg9c+A9+QIVr1jVrVRY7LZzbxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMhuuK7H2KpyhKdJsweY18PYcZYtqzvCmwSwRwBAWvo=;
 b=E9wwFjFWW1HGm190K1P3jRP5MyECFhK22csekPBgiHpCz4e22n6rrImzva4yMlxF38pZJtRTOyrH5+bWbYqGV0EIgLi+KpRVjthhHHrVHYFFdCOcEehISSAfoc4v7XF14YjeSWUe23kqBFmz77n+lcAjtnfMJwtopIgmRird8MwfbPOu5/O0aBcx3voiXolZMfXLfMqgKJoN3hWfbPnuppoIIQKje4cMIBoH5cf6N2IwivdDJ7m3HarReAWve7oCLkjMy6uk7VTYfcH9V8Ek8+jTDiFtVgQiirraQA714ZFL/fLi/u1KKkzwcff7q7szacVpMT+cMd7SLJQ8S6oAvw==
Received: from BY5PR03CA0011.namprd03.prod.outlook.com (2603:10b6:a03:1e0::21)
 by DS7PR12MB6021.namprd12.prod.outlook.com (2603:10b6:8:87::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.7; Wed, 10 Dec 2025 13:39:18 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::2a) by BY5PR03CA0011.outlook.office365.com
 (2603:10b6:a03:1e0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.15 via Frontend Transport; Wed,
 10 Dec 2025 13:39:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Wed, 10 Dec 2025 13:39:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 10 Dec
 2025 05:38:57 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 10 Dec
 2025 05:38:54 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jgg@nvidia.com>, <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: [RFC PATCH 11/16] hw/arm/tegra241-cmdqv: Read and propagate Tegra241
 CMDQV errors
Date: Wed, 10 Dec 2025 13:37:32 +0000
Message-ID: <20251210133737.78257-12-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251210133737.78257-1-skolothumtho@nvidia.com>
References: <20251210133737.78257-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|DS7PR12MB6021:EE_
X-MS-Office365-Filtering-Correlation-Id: f9550a51-8e53-4d69-9217-08de37f18416
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cldhMEdzVnFWYzhiMGtKYys5ZWc3ekRYQjRGaUJCaW5IaW5zUW00dXpSQS9U?=
 =?utf-8?B?R2pGZGlhazVvUjF2eG0zMlBocTNDdnU3MDFxTEg0MGlldDIrdjB3Zi9XdjlH?=
 =?utf-8?B?T1h0amtSU0JPSnlqT0x5dUw1ZmFXSGdPcVFhSHYrcTVXcVJ2eTFEZlh1K3Zx?=
 =?utf-8?B?NDhxaFNsMHc2MXpabDA0SXBGRWMvMEE5UHI3L1RrR3lESzFOMHZDMXQwMnZN?=
 =?utf-8?B?ck9ucXo5ZE52RHRFNXJ6ZnRGekZHMTV2OFlZM2NmRi96MzFZcnlSN1I2a2kv?=
 =?utf-8?B?K0JsVjd4Rmo2N1Q4NE9Gbm50ZWZyNEtSRzg2V1dia0d1cTV1TVdNSnVmKzNI?=
 =?utf-8?B?VXU4K0hkV1FwT0ZVMEVwL0dNSVVXTnNUQkVDSWlySXh2TmxRSXJ6Tk5HT2dh?=
 =?utf-8?B?enh0OW1qNDVPRi9DblpSc0hHT2JEaFpQWHRQSnFiUkZIT1h4Zy9WbVJIQjlX?=
 =?utf-8?B?bk5mVjNuRHRjSWIxWEFRVXU5WGZDcmJJZzhlZWpWS3N5WFF2clFNejdrcmhO?=
 =?utf-8?B?c2xmYUovRExBT056UkF4ZEVrR0VNVXZWQlBhMDFFRXlJUTc3SkhHdVU4bzF2?=
 =?utf-8?B?Zmd5Qnd6VlcvVFRyOUhiQXBBTWZDdEtmWVVIdmV3ZEtsaEF5bXBlK3BPTmxu?=
 =?utf-8?B?RGxvZDBzOEtkOU9uZDdyL0dqd2s5NEVKRnk4NGNLWmJ3TE8zNnNwZm56bEdm?=
 =?utf-8?B?VXdJQ0RLTTMyMlZkWkhjOUdQVlZrRG9ZMmNBS0hmSkljLzVaYmVyd0wwWnhq?=
 =?utf-8?B?bXJMS2xKM2wxcFZHMXBVdzVzcnZpcGRVUHlWWStJSFNHWCtVQWszSHZtajFZ?=
 =?utf-8?B?WkhlL01LNllpSHE2WjFXZmNRejFUMVJJQmNGdzdXT2I2VVA2L0ZWVi90TWtl?=
 =?utf-8?B?SktMN1NuMHZ1VkhxZWhNWHU1dkRlbE10YjBHaTJiMGRsL2F0UGhKTE85NDhR?=
 =?utf-8?B?cG5SZXFFV1RjbzNjTHZBWCtFc2RDalpwWGZWazBNenVORk9xUlhCWkhDQTd1?=
 =?utf-8?B?ODdSamxoekg0UzI3T0oxd3dpOVMwbzBDb0d6ZSs3VDZTQW1jMUl6cGRWNzBI?=
 =?utf-8?B?eEd2a3ZuRUdIdEdaZC9VSnBYS3hUM3J3ZU1vVnNmWlNQWW9zQ0tNMmpDUHI3?=
 =?utf-8?B?eWkzZktYMkt4bnRuK2lMM3lLVlNtYkQvUytFUVVnWkp5dHRGWE42Z052a3FW?=
 =?utf-8?B?TGQ4b2Y0cHBwb3dJNjFKVzZwU01PanRNRzNqUjFPR28yeXhWV3lQOGVwNm1m?=
 =?utf-8?B?Vnh2aXBXNFlQSHd5dG5GUE50Qmd2NzZESFlDdUxKWSswY1drYURxUHB0ejV0?=
 =?utf-8?B?SDUvYnZRVXVXSW51K2hRMGliYjQra0VVeCtCYUxqWVQ3SHQzaVltSWU5NHF3?=
 =?utf-8?B?NWJpOWxkeTFtMzBGN043akQvbDhXNjhWT05WSGkzZHgxOC9JendmaGN0S01a?=
 =?utf-8?B?OWpaK2hPWEJyVWJmdFFWdGlHQ2NrYTR4anVFTUxaRTdJVmV6MlBGYXF5MkFL?=
 =?utf-8?B?bm5rdlc3cmdRQXhGbjVUT0ZKbEhmR0NTZ0NTdklZUnFHYWMySVpvRTRsTU5E?=
 =?utf-8?B?R1U1R1BvWGxmV0VkdzJ6Y1l3aWFuejEyblZIYWR3a3NEQjBUa2pWWklYNE02?=
 =?utf-8?B?azNzTEZvaTlEeU1YbjAvRzJrL1lOY0ZkcEtRYUgveVc5RFpnaHpqenRZbk52?=
 =?utf-8?B?d0t0VWVyME5yenErZElhZEpQZkhrYnhGR2hRQmcyWkRGYzZFa0dlamZFMEVq?=
 =?utf-8?B?aVZ2ZmRqeDBoaDhLSEZ2WnVFN05TSjZ2alltV1FrQWpCU3FjUklrR1BLRWNH?=
 =?utf-8?B?S3NneUM0NklTQlhSWnExdVFMS0xGRkh5dVNnZ1Vtc3NPZHU2Ym5lRytFU0lZ?=
 =?utf-8?B?ZnhxemkwZzFhcWdyampXTVlhL2MrVHlFb0pQUHBvdkduQktZK01neVpIVFFs?=
 =?utf-8?B?L1NMNDdyejMzVzFZRWM1ZlE5TmwycFRnNit2U1hoWkxjRjJiWkp3bHorbjIy?=
 =?utf-8?B?WGtybGFMVFBFYlRLb1ExeDU0ZGRtcGRacEwzVjZhcHo0ODlVb3QybGhlOXZY?=
 =?utf-8?B?N2NLMDFobmhXd3VIWnFYWGt1ZWsxVEVoUzdidXNVLzVPRzRkZlREeG92eXBF?=
 =?utf-8?Q?UCEw=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 13:39:17.4976 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9550a51-8e53-4d69-9217-08de37f18416
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6021
Received-SPF: softfail client-ip=2a01:111:f403:c105::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
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
List-Id: <qemu-devel.nongnu.org>
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
 hw/arm/tegra241-cmdqv.c | 80 +++++++++++++++++++++++++++++++++++++++++
 hw/arm/tegra241-cmdqv.h |  2 ++
 hw/arm/trace-events     |  3 ++
 3 files changed, 85 insertions(+)

diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 812b027923..5b8a7bdff2 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -8,9 +8,12 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qemu/log.h"
+#include "trace.h"
 
 #include "hw/arm/smmuv3.h"
+#include "hw/irq.h"
 #include "smmuv3-accel.h"
 #include "tegra241-cmdqv.h"
 
@@ -137,6 +140,79 @@ static uint64_t tegra241_cmdqv_read_vcmdq(Tegra241CMDQV *cmdqv, hwaddr offset,
     }
 }
 
+static void tegra241_cmdqv_event_read(void *opaque)
+{
+    Tegra241CMDQV *cmdqv = opaque;
+    struct {
+        struct iommufd_vevent_header hdr;
+        struct iommu_vevent_tegra241_cmdqv vevent;
+    } buf;
+    ssize_t readsz = sizeof(buf);
+    uint32_t last_seq = cmdqv->last_event_seq;
+    ssize_t bytes;
+
+    bytes = read(cmdqv->veventq->veventq_fd, &buf, readsz);
+    if (bytes <= 0) {
+        if (errno == EAGAIN || errno == EINTR) {
+            return;
+        }
+        error_report("Tegra241 CMDQV: vEVENTQ: read failed (%s)",
+                     strerror(errno));
+        return;
+    }
+
+    if (bytes < readsz) {
+        error_report("Tegra241 CMDQV: vEVENTQ: incomplete read (%zd/%zd bytes)",
+                     bytes, readsz);
+        return;
+    }
+
+    if (buf.hdr.flags & IOMMU_VEVENTQ_FLAG_LOST_EVENTS) {
+        error_report("Tegra241 CMDQV: vEVENTQ has lost events");
+        return;
+    }
+
+    /* Check sequence in hdr for lost events if any */
+    if (cmdqv->event_start) {
+        uint32_t expected = (last_seq == INT_MAX) ? 0 : last_seq + 1;
+
+        if (buf.hdr.sequence != expected) {
+            uint32_t delta;
+
+            if (buf.hdr.sequence >= last_seq) {
+                delta = buf.hdr.sequence - last_seq;
+            } else {
+                /* Handle wraparound from INT_MAX */
+                delta = (INT_MAX - last_seq) + buf.hdr.sequence + 1;
+            }
+            error_report("Tegra241 CMDQV: vEVENTQ: detected lost %u event(s)",
+                         delta - 1);
+        }
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
 static void tegra241_cmdqv_free_veventq(Tegra241CMDQV *cmdqv)
 {
     SMMUv3State *smmu = cmdqv->smmu;
@@ -179,6 +255,10 @@ static bool tegra241_cmdqv_alloc_veventq(Tegra241CMDQV *cmdqv, Error **errp)
     veventq->veventq_fd = veventq_fd;
     veventq->viommu = viommu;
     cmdqv->veventq = veventq;
+
+    /* Set up event handler for veventq fd */
+    fcntl(veventq_fd, F_SETFL, O_NONBLOCK);
+    qemu_set_fd_handler(veventq_fd, tegra241_cmdqv_event_read, NULL, cmdqv);
     return true;
 }
 
diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
index ba7f2a0b1b..97eaef8a72 100644
--- a/hw/arm/tegra241-cmdqv.h
+++ b/hw/arm/tegra241-cmdqv.h
@@ -25,6 +25,8 @@ typedef struct Tegra241CMDQV {
     void *vcmdq_page0;
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


