Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7EDED1D892
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 09:24:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR5Zh-0003RY-Pw; Thu, 04 Dec 2025 04:24:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vR5Zf-0003Ly-7d; Thu, 04 Dec 2025 04:24:31 -0500
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vR5Zd-0004nT-ME; Thu, 04 Dec 2025 04:24:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RQO6EPmIjIpWRGW5HsdQsjf5zjsnZfmOaDNVHUnl+v4nllOiUuoWv5CppVUieLrreeHmHXZjhsF7Pv94Fx1QaRsnCnmlX0ip+0/lToQImoMQs7i9IMfZga5eFCnJNVtGkheLEx12iyJ/V+yF5xBqMLY0h/KmlplNXAWuvPDsTEpliK6GFPKTlyN69RWT9jEg8HNaaZbSd9HDIbteA+juK2kRQdieo3KkcTsr12kIUXU2G6bhfv1Q2I3U8SF9n5bzMNcRqKh3zdAfdSMJ0xcyBjrJT3Nms2WmEvUzyATE98TtKNwrf2MZRSXFfwDgCMlKZoGl4mB89xcM+6WN7W+r2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ljj0d0sopaR6Htyn+HeyUbLui8ABzfQ1CvNS1L4LGeE=;
 b=ux7bECDDOZGM0trgwmea1JRxAQHz9gZV1FmqQn/Sh4aMoe5DYkcXbClE129bFa/2+3rtGTC/RL3b/zYDpdNT37j/N7Wv0z3vbSgwZ4Cfnnc+TjfaeyTuP5AtitGYFicNbeESfcdUKUkzNhIo7UxHYO6TFghGYOGcKWIcykd2MUbY8QKK0IBZuxg0u1K2k+MuPVTqxARVrQwB3At+FQPkTT6wlYf3S4kMd9W4EAzzyRVm88dlDNLLxWN3pH03rf+17rzZVX0fwk1nksUMaKkbkGk/MoONi5rJ8yPjse2XR7Kmca9gG7tE1jzVNCJkej48ZH8tVDk4gvZptuk+AMADFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljj0d0sopaR6Htyn+HeyUbLui8ABzfQ1CvNS1L4LGeE=;
 b=RvsVfsCfibiHbWyiY9d2VCsIGmoLQz6v3xRs2xhz35lWeVSp7e/BKeZ2DBLK/8aM7igtXxYUzRwmDvL4w5+PTtu5DmtyKh/pMniTVd9bFJeLsp1Tgrugz6uwco66dS6YMh0MOVPjzTP3rUJzLWSPrP3lm90/zenaVsiYeVbu2MTO5XSq3r7smqHimjJLYkK1DljbCQDYFJyuPiS1yLBhfSsPZgjnAWbGn9ln+SUiot2Kum+/dRzlY+/xnHowweJBbEpdqT5tR9TETghp1lEVWQIB8uq3oIXa2+t2tMkj2AdOnTF/z6H4dZ0Cxp75sHPfvi/rkkHpKSBWP0Rnw+Sd3A==
Received: from BN9PR03CA0540.namprd03.prod.outlook.com (2603:10b6:408:131::35)
 by MW3PR12MB4427.namprd12.prod.outlook.com (2603:10b6:303:52::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.11; Thu, 4 Dec
 2025 09:24:23 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:408:131:cafe::f9) by BN9PR03CA0540.outlook.office365.com
 (2603:10b6:408:131::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Thu,
 4 Dec 2025 09:24:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Thu, 4 Dec 2025 09:24:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Dec
 2025 01:23:36 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Dec
 2025 01:23:32 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jgg@nvidia.com>, <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v2 4/4] hw/arm/smmuv3-accel: Read and propagate host vIOMMU
 events
Date: Thu, 4 Dec 2025 09:22:41 +0000
Message-ID: <20251204092245.5157-5-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251204092245.5157-1-skolothumtho@nvidia.com>
References: <20251204092245.5157-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|MW3PR12MB4427:EE_
X-MS-Office365-Filtering-Correlation-Id: 84795330-10a8-4359-d9e8-08de3316e96b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TkszOTAwcjl5MjJDREoyemdzc3VJaFNXRnlWTjlaRHlyclhhOEtaazhtN1or?=
 =?utf-8?B?L29zR2Vaa203YXFTd2RjVUlSNS94eGlQekhQWTNOcXB6WmVqMCtCRXU4RUl2?=
 =?utf-8?B?cDBuTmpLQ0pGRHhvdmV2RDZ6SENKWm00SDJwRmxScTd3WVYyVE9qYzNFeDhW?=
 =?utf-8?B?cmhqdXlyMGRyVVBheXg2NldHR1F3OVJQOWRjUlREQ0YzcHFnaXRJUkFxOHZR?=
 =?utf-8?B?OXcxSHEvRUFRc0cxQlZiODg2MkQ2S1hoOVE3LzF1bFlMejlVSjBCdkZYUzZs?=
 =?utf-8?B?dzh6aWNIVzFSTUwwTHlDOWt0ZlU1Zlo5NU51dnFNQTFVN1JNY1pmT0dOOUpv?=
 =?utf-8?B?aXV0OXVEQitCYnhSUmxtVlZpOGxqMU9xR2VsOUdHK1E0RmZEcmdpc2FYRTlp?=
 =?utf-8?B?SEpITnNpc1I0S2hZMkNCZHNDeGVUS29vVytzV2w3cjBiQTlSTEVCRE8zWVA2?=
 =?utf-8?B?ZjBOaXc3VFBrckl3eUdwNzFPTndYWWdybVZVT0c0U3VyUVBadk9oNHQzcFBI?=
 =?utf-8?B?WUlDK2IwT1hzN0ZuYW03V2JLeFdGejRlODJsMUtidUQzVkM4aTVrVlkySEhK?=
 =?utf-8?B?eVozdW05dW5POXdDNEQwZ0VlUENETTJOa2Nvb2pLK1RhU1JzWlNGN2N6WXJF?=
 =?utf-8?B?b21LQnRmdno4OWxWdURaYTFySXk4SXZBS21LYVhCREpvSkh1SlhIRnFHRnFr?=
 =?utf-8?B?TFNCWVFUVWpQeU1RbnhnejFZM1k3VWJId3pKaTdYT1RDVHV6VVFuczBNQTBR?=
 =?utf-8?B?OEpOdDFGc0N3TVkvdWtKVWYwdTZ2TzNHRThVTXBHZlpHMmpvQUQzbGx2dFF4?=
 =?utf-8?B?ZzdxbndHQ2F4bEF5dndob1h3aHlqUk5VQkN2b1JYcmVKaHNQS3ZRbTVtb0NC?=
 =?utf-8?B?T1VsaWhJTCtMUDJnYU1wbEkxV3pJSEZ4bFBwL1JZMUcvVkJSL2ljMlRXOTdl?=
 =?utf-8?B?SEx5cFd3Z1IwYjZ0WFg4eWRaenBlQkdudWh6VEVVbXhIN3VlcTJwTUhTTWxj?=
 =?utf-8?B?Ylh3UHNCZTdPSnN3QWVzWVlpR3JPWnVEM1F3ODkxQkg4ejJCRC9UaEVNeUs2?=
 =?utf-8?B?bmpJRTNJeDhMNHNDVXNGVTJvNTl2QWJXQW5FVkhDU3BUYW9NVnZCb0VUZFF3?=
 =?utf-8?B?WmNWeDMrMGVCREJIRHRNY1NKamUzRUptVU94bWZSNmF2TGJ3bUtreVoyQXFv?=
 =?utf-8?B?aGV6WHZTWnNnOUltWkpsWWx2Q0RJUUZWOWRDQXY2Y1hHVjN4SmNDRWNwd08w?=
 =?utf-8?B?UTZSVHdGbUZ0OGJpUFRZdVRIU3dmSHpvYkdEYVRwdkZTRjM1R1QyNS9jVjFK?=
 =?utf-8?B?ZkYxeGpEcGFwdVZtR3o3UXBENFM2N1dSOSs5a2lDV1JBZDNoZ3RSREtEU0Z1?=
 =?utf-8?B?Wms4QjJCejltZHozSTBTOFdvcloyallHbStTNHlISE5MUzJud1lneHJuNnJ0?=
 =?utf-8?B?bE9Ga1k3ZFFyc29xSmlOdXBreEZjSTdFZ2tPbXJqZ0oxZ0FWZlVYM2ViamY3?=
 =?utf-8?B?Smx1QitqWVUwRlNpTGZoU3Q3Q1lWQ1BSbUYxWDVwbVhtZlBuaHBpOHBEbmR1?=
 =?utf-8?B?RHFFbVZRQmZvWExBSm5Gd0gxSXVtMSs5eDdleHlRbGZzVDhCRlZYcytFbnVQ?=
 =?utf-8?B?b0NPS2hVQzhiMTNGYUE3N1J4OTk3bVI2aFFmYkRhSHhhanhObWhhWitJL3lw?=
 =?utf-8?B?OFhKTTFXMXBaL0FoWG9PQTk0SEM1Z0hXbUladVBIMS9iYkN5UXBIaGE0Rm0r?=
 =?utf-8?B?bG1qdGxXQ3IyVEJXNWNEdU9xN3EyY1VvNFZpU0NEbk1lcVNWM3FoTm1Ba0dm?=
 =?utf-8?B?R1AzN0ZMSXlTWUxFYXlEMnpHclZSNXhxaC9PeXk5aXNwQUJEbnFUZWtBaDVh?=
 =?utf-8?B?a2hBcmo0b2pnTzkycnJxZDdRV0JkS29zeUMrNFhyNUovdWZLa04yUDA2S2hM?=
 =?utf-8?B?bzlETGsyVnNZWWUwbzhrSERhQWxEMmtIN25HTTIyRmVINFo2cldaelY3NUUv?=
 =?utf-8?B?bDc5MVVFeEtOZnRneC82dmRLMkIvSFZ6R3JkZmJ2TGxpMENaOXZlc295M2la?=
 =?utf-8?B?eWNlUzNBbFRQNXdmeUNlaUNRZlkxVm16RVl6c1FEZlIvcVB5L3ozenVYN2Z5?=
 =?utf-8?Q?vK4Q=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 09:24:22.8540 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84795330-10a8-4359-d9e8-08de3316e96b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4427
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

Install an event handler on the vEVENTQ fd to read and propagate host
generated vIOMMU events to the guest.

The handler runs in QEMU’s main loop, using a non-blocking fd registered
via qemu_set_fd_handler().

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c | 58 +++++++++++++++++++++++++++++++++++++++++++
 hw/arm/smmuv3-accel.h |  2 ++
 2 files changed, 60 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 74f0be3731..d320c62b04 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -378,6 +378,58 @@ bool smmuv3_accel_issue_inv_cmd(SMMUv3State *bs, void *cmd, SMMUDevice *sdev,
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
+        error_report("vEVENTQ: read failed (%s)", strerror(errno));
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
+            error_report("vEVENTQ: detected lost %u event(s)", delta - 1);
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
@@ -385,6 +437,8 @@ static void smmuv3_accel_free_veventq(SMMUv3AccelState *accel)
     if (!veventq) {
         return;
     }
+    qemu_set_fd_handler(veventq->veventq_fd, NULL, NULL, NULL);
+    close(veventq->veventq_fd);
     iommufd_backend_free_id(accel->viommu.iommufd, veventq->veventq_id);
     g_free(veventq);
     accel->veventq = NULL;
@@ -427,6 +481,10 @@ bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp)
     veventq->veventq_fd = veventq_fd;
     veventq->viommu = &accel->viommu;
     accel->veventq = veventq;
+
+    /* Set up event handler for veventq fd */
+    fcntl(veventq_fd, F_SETFL, O_NONBLOCK);
+    qemu_set_fd_handler(veventq_fd, smmuv3_accel_event_read, NULL, s);
     return true;
 }
 
diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index 7b0f585769..2c7c30d6a0 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -21,6 +21,8 @@
 typedef struct SMMUv3AccelState {
     IOMMUFDViommu viommu;
     IOMMUFDVeventq *veventq;
+    uint32_t last_event_seq;
+    bool event_start;
     uint32_t bypass_hwpt_id;
     uint32_t abort_hwpt_id;
     QLIST_HEAD(, SMMUv3AccelDevice) device_list;
-- 
2.43.0


