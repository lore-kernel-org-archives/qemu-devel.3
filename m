Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB138D2D8EF
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 10:39:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkgRn-0004C7-7D; Tue, 27 Jan 2026 05:37:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkgQQ-00039D-Fw; Tue, 27 Jan 2026 05:36:01 -0500
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkgQM-000181-5w; Tue, 27 Jan 2026 05:35:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cvrB/GTHpIguKLAw7DqN0FsRYgWUkGP6qrUC5fXUAOGWH29U50D02mZrxyqC47OUS+9GHM/OkvTHDEh8Qf8jeShD0rPabKLvMbujPBH6wEgwX896Uyz7m/Jb3ZEYYcFq6nJSzx+9ErlTrI+24HvIwv1csnZCBDCY+DTi646gxo0s0KHwrNP6mN/WJR+ziQO+jbfYH48Azxulwll4+90W8FcGoOM454V8JYKNTr27BqvtK4lDJ80tRRFV94dq5zsjzHABTp/Qyj7jgi7asX71txxAy926sy4uvtIAZ8t0Bh9sQuE4+kmDS9V/EOWDmHSegI2a39rtmcvStXeOqpwTcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ercu/wxWGHZfgiGGSoP9OwgLgh4cvv4omBPnx3s9cj0=;
 b=w6r95tuqvMc6X/pIeVDX27wiNRSMlJRQxPvjkS+YfCBbsL3MY63hcUQEh5DKvaRhw67zHIvPHB1oTXuR9OyP6lam6OIdvlHTYvmACzs6748FTix0fCZF78kYJYkQI+jREKlxNfrf4uNANswohC7o2hZ8JxhfmDErk7pDVaKg+X2QcxSPO8U0B0kU3BAGVqOzQb83ZVY+bzauLMvLz5TQdEIRYVQvVgYnksggDxHx8CtK5/hLPe1Fh3dT5waXf05qCuQGsbCDY6tKr5ogEl+sjdwyf5OYG/+ygqfDNESm7lG+iFlOc20W4ISAKq/igvp9jIlGNmAkc2dqKRCYdnO4Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ercu/wxWGHZfgiGGSoP9OwgLgh4cvv4omBPnx3s9cj0=;
 b=ghOry4puVFsmLsk+RS41JbZr74HQsnhpt4TMtxCWjtJMevOVaou59eKQ0do7eNYkQvvt4OYmdLLOuXGpb9tPvu7yS1yTKAX+bmabOJJbV4WqWHDBv+nAg9hP9umkwFtCbVmMip/ilhUR+BL1RqkUl9eFruMJyGxB6Y7nntsCjNMZ9KV6AR+ErjlOfciaGqsSVjLRR/NUd5G1sZs0gh9mI+RZbUyfHtrKa9qb/BO7P4hW2Pl+9U8pQMW/QHWTjcm5IX0f/ChhUrouephNdlTu37KmNZKuYAj6At2U/LmHX8ZPw4Kx6VqaLyffA2PS3foSRKQ/qAg8+dqNi0gZLHFoUg==
Received: from DS7PR03CA0054.namprd03.prod.outlook.com (2603:10b6:5:3b5::29)
 by BN7PPF8FCE094C0.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 10:34:40 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:5:3b5:cafe::b6) by DS7PR03CA0054.outlook.office365.com
 (2603:10b6:5:3b5::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Tue,
 27 Jan 2026 10:34:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 10:34:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 02:34:27 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 02:34:24 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jgg@nvidia.com>, <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v3 4/4] hw/arm/smmuv3-accel: Read and propagate host vIOMMU
 events
Date: Tue, 27 Jan 2026 10:33:28 +0000
Message-ID: <20260127103328.255382-5-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260127103328.255382-1-skolothumtho@nvidia.com>
References: <20260127103328.255382-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|BN7PPF8FCE094C0:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d207200-9ccc-40c6-5912-08de5d8facd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ak1pSVhFbk1hRFZ1cGF5ajhic3dYeDdkanc2dHdxS0syRnBlKzBJMTl0V2tS?=
 =?utf-8?B?QXZtdWxtTTBqWkk0dEp0bzJrK0hhRHB5a2piazBwVGowYmNJMVYvR0JRdHlx?=
 =?utf-8?B?d0FXQU9HVnNMZ0hGRWdEWDFEMUxjTXErcDV6ZnMyRDVMdGVuTTh3K3prMUI4?=
 =?utf-8?B?MXNnWnVQaGlPb3NDZmR6WEZ0YkhDa2U2a0RXaEVaUGJ1K1hrdE5XSGxXaEJa?=
 =?utf-8?B?RFUwWExEL2NVWi9KOGF3aGo4OE9sdGdaTlBlb2V1K2Vmdk9FcXkzSFlETXZZ?=
 =?utf-8?B?dWltNktVMXZPS01lL21kbEd2d0pvcUd3QngrdjBueXdueHNlRTMyS21DTDVN?=
 =?utf-8?B?dlA0K1V0K3dXSVZDN1Z5Q2RjdzY2RnZIL2ErL1ZjclBzUDgzVFBCdCt2NDRC?=
 =?utf-8?B?YXNnOEZmYUdsdjI0ek9SeHcvTmpUK3B5aUZVRlZnSDNMcjQ1eEliRmNId2Rp?=
 =?utf-8?B?REE3UGR3TzNHR29FamhvMm9YY1pENWRwOWowZkhsM1M3VGh2MDdick0wZzdG?=
 =?utf-8?B?clk0VkVsUjFGVWVCU2s0b2hQeEFYaHcrZnJlQXBmUXpHSGZ4WnViVUpEbW8y?=
 =?utf-8?B?U3d6M3lZM0hIR1hNcmZBN3NaeDZVRjdQK004bklVSzQ4M0VNRkp4U01Fa2Rx?=
 =?utf-8?B?azJuNXFpUXBBSC9DK2FOK1VIT0hvRDh4VnNjSlM3UUQ2T09MR1JhRzJ1Ulpp?=
 =?utf-8?B?ZGpZMzFqcU1Ea0tNR3dOZC9VRDlhS0djeExnamo2ZHdsY3l0eEJCT0NXYXRx?=
 =?utf-8?B?eUg3MUJiVVp5QUFSbENsblMyZkE4UmtzRmM1T0p0cUFYUTV4cWhsM1BJWHlH?=
 =?utf-8?B?bFp2NGtXckVwYXJYejFSUkpXSVVlajRPYVUxRHBFajg4aEZRZE1jVlIvcG5Y?=
 =?utf-8?B?QXMzVWVxNGUxWEtaYXc4czgwN2taK2UrWmo2ZGtTcDdTNEdHdXoxR3pYbzEz?=
 =?utf-8?B?NWozYVVtMExCcEJsUzdIR3FXM1pQTk5GenFNY2ZlL2ZraklramtRRkdnVllO?=
 =?utf-8?B?ZzhiMEc3R0dicTNKT0UwU3VGR1ZHeUF3WTVhcldGTHYxMzhaTExZRU1RMVhB?=
 =?utf-8?B?OW52ZXczUkJIK0E3a0QwUTB1T2lwT0F4WUxUZGJ3NkJKamc1dU9QZjV5T0VX?=
 =?utf-8?B?ZnM4ZjBLYXhSQnBhU1dQLzI0NXFmUW9wSGxCV1JVZHZ1bE9tSUNlalA2a25l?=
 =?utf-8?B?Y0lkUHQwWmR6b1VpTWtIcWlmM1BISWxoYlNINlUvYWlETzRlOUQ5d2MxZXRL?=
 =?utf-8?B?eDhWMjBVZVZCTFRqa2ozTEx5VEswN0w1dDFTd05DV3F1WHozT1FvZGtyVmNw?=
 =?utf-8?B?OHFDUk9rOTYzTU9rVE4zU0lIZklYRWs4a1QrK3lQbW91VEhvbldVanRFNGR5?=
 =?utf-8?B?M0lqVFFlcGZPUzl4UHowanpJTGJqakZWOU9MNXR2VytZUUtjT1haNUtEOG5M?=
 =?utf-8?B?MTBqL0xhaDNuOGlzTkVUSlk3VkU4Qm0xSUNMeUR3RUdGR3hNanRKZmFydjdp?=
 =?utf-8?B?YkpJUEcvV1pmcFNCdmNjN1dic24rdEN2WlAyRWh3M2lLa2RmT1JTRlFDcSsw?=
 =?utf-8?B?TzljYU9VQ1FIT0dkaXpwUW5iZDdTWFZvOFE4UEl3ZTJEK0h5Rno5ZjdNdUIx?=
 =?utf-8?B?NEttQzNRUTl1L3VmOWwwQ0RTV0J1enpjWWxLYjdVT0R4MlNZY2QwQ1pCeVZn?=
 =?utf-8?B?ZkdaWmUwdG5aZ2ZVZno3RDVJemNuZHVuZS9jeDVlQmlQb0x6QlZoUmtaclQr?=
 =?utf-8?B?allmZjA0YlVvYkhCM2hkRmRGdzRIZVFWTUt4K1M4bE84YlJZTDkzU1N1Zldn?=
 =?utf-8?B?VU9DNnJaOTAybytQQU1WTnVST2o0YkxOemV0aWd6VGY3NVh2QW1uYzhPeGti?=
 =?utf-8?B?QnhJdXNUNmJvRUkyS0ZrQ1RwZWxKTFpBWXpha2NjTkVUQjlYeG1jK3pwZWgz?=
 =?utf-8?B?OTNyTGszdHhTNk9UanNQb0NuVDByaEJxS0VpbHNsNTI3TjA1Q2pPU3kxNlgy?=
 =?utf-8?B?UW9wZ1BhbSt4NkZLMDZIMk1xT1d0Rm1Wd3ExNFFGREhBSWxua1BSeUtyOUpw?=
 =?utf-8?B?a3l3YTlJYk9nUWF3YlFWWVBJYmkzaklidHQvR1ZVdzlEc0NsNTZQbGNRZEZl?=
 =?utf-8?B?SzhWZ05pYjBEVHQ4dktVdDJaajRnMGY5WFZKb2xhcGU4Rm1TTHRWbXRtOEJG?=
 =?utf-8?B?UHVJVmFqcWU3U2piNHB5cm5PUTZFZnFheWU3WUkrd1JZbW9RdHp6QTJSZ0Yw?=
 =?utf-8?B?RHF2VmtpaVc0RWdXSzhyRXU4dDdRPT0=?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 10:34:39.2741 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d207200-9ccc-40c6-5912-08de5d8facd0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF8FCE094C0
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
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

The handler runs in QEMU’s main loop, using a non-blocking fd registered
via qemu_set_fd_handler().

Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c | 60 +++++++++++++++++++++++++++++++++++++++++++
 hw/arm/smmuv3-accel.h |  2 ++
 2 files changed, 62 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index e8028d4be5..ab57eae575 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -390,6 +390,60 @@ bool smmuv3_accel_issue_inv_cmd(SMMUv3State *bs, void *cmd, SMMUDevice *sdev,
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
+    ssize_t readsz = sizeof(buf);
+    uint32_t last_seq = accel->last_event_seq;
+    ssize_t bytes;
+
+    bytes = read(accel->veventq->veventq_fd, &buf, readsz);
+    if (bytes <= 0) {
+        if (errno == EAGAIN || errno == EINTR) {
+            return;
+        }
+        error_report("vEVENTQ: read failed (%m)");
+        return;
+    }
+
+    if (bytes < readsz) {
+        error_report("vEVENTQ: incomplete read (%zd/%zd bytes)", bytes, readsz);
+        return;
+    }
+
+    if (buf.hdr.flags & IOMMU_VEVENTQ_FLAG_LOST_EVENTS) {
+        error_report("vEVENTQ has lost events");
+        accel->event_start = false;
+        accel->last_event_seq = 0;
+        return;
+    }
+
+    /* Check sequence in hdr for lost events if any */
+    if (accel->event_start) {
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
+            error_report_once("vEVENTQ: detected lost %u event(s)", delta - 1);
+        }
+    }
+    accel->last_event_seq = buf.hdr.sequence;
+    accel->event_start = true;
+    smmuv3_propagate_event(s, (Evt *)&buf.vevent);
+}
+
 static void smmuv3_accel_free_veventq(SMMUv3AccelState *accel)
 {
     IOMMUFDVeventq *veventq = accel->veventq;
@@ -397,6 +451,8 @@ static void smmuv3_accel_free_veventq(SMMUv3AccelState *accel)
     if (!veventq) {
         return;
     }
+    qemu_set_fd_handler(veventq->veventq_fd, NULL, NULL, NULL);
+    close(veventq->veventq_fd);
     iommufd_backend_free_id(accel->viommu->iommufd, veventq->veventq_id);
     g_free(veventq);
     accel->veventq = NULL;
@@ -439,6 +495,10 @@ bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp)
     veventq->veventq_fd = veventq_fd;
     veventq->viommu = accel->viommu;
     accel->veventq = veventq;
+
+    /* Set up event handler for veventq fd */
+    fcntl(veventq_fd, F_SETFL, O_NONBLOCK);
+    qemu_set_fd_handler(veventq_fd, smmuv3_accel_event_read, NULL, s);
     return true;
 }
 
diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index 92048bb674..ba0f40a565 100644
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


