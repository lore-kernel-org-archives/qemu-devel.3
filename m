Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 038CDCCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 15:50:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGfld-0006im-8s; Wed, 05 Nov 2025 10:49:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vGfla-0006hx-MG; Wed, 05 Nov 2025 10:49:46 -0500
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vGflZ-0002Ut-7a; Wed, 05 Nov 2025 10:49:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AvclvDEwHQXgBacqfyvG8slGp+Y6mns3gYxvPhzoPZ7LSffr3/gBrlC/1RmvQeCe37J4pIVaMgYz8n/Nu+j1BaLYeTBJKNrDUa+T0S4ilQEjGLzDFr/lFJWac6lQZLYSdDrFEiLFmZtSjBuDJeIZA/3c5b/FwGZ0TrSdGnOR/oO3+aeuU65xizviWmos6NdePNlt+O5VtOjuswHbpIEBRkhH8VrHBdKBZrmkXYgowUdWrb8n0p38ttlN6pqalNLv5HOD+vTiAkFlpcoXmcSjt32ugrJlyDH2+nfgzVzu1bGt6gONCeGJWp7WKuLGI818tNpQjiG+4S0OVFrsL6chiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cenchd2pAxNXYSjd6ucttpYGEyDCS7xdAK4cZkGYfWo=;
 b=HxEntkacYfkMD+xh6J1T3+zR9ZRiMv30we39suFlcxG8w86gnKcDnYkubUjFm8wHuqxTCLM17u8Saz43lAaayMD/T0wpxDCaL+Y2s3pT4h7LFB4XXHKIyzPT8/ZvxdnzJtCj30jJamMo1SgJN09KZTKy2PFUQw0gt+N6IBDx4/PrbV38+tkGiMurkeTpi9XbTMQIdlTIIukvmwOThWzy7l+hAYlFeS+b2ZP8AYaj5LVvlI2pJmGlQAjDQOdwRHqsgaMOgacWOAuz3oxRtTtqRoTcFry1jTYF0OX79ip11jyDDPOE5mNDlPYmdSsDmy1P9tH2piq+Bj7mcaay5WEStw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cenchd2pAxNXYSjd6ucttpYGEyDCS7xdAK4cZkGYfWo=;
 b=gB3JieVCmHDkx9Rw3uHrZRFgCj2W0zjUjig9FRcFO33x29J8nFzcyHAtUNcREK3vMZHkJ88CWaGQPwZ/bzXJQtwc9vxz0veWTfzPxOSp6e0A7zuwG4tyUos1ZZiwAgOq5+Gs6u4namV4FEDX/OF+5YSrfhgSb98HbmOfm1bODQ4gP8vqX8UFrFHKm4+XKh12Dz5GWamMsYSHN77OCg0ge7/vVTXKjb18zCLzN1V8yIyFa2Js0BvIcWd662nNb3t3pOhniBOf3VPBs4xxV8ngJ4/qhS7Y+zMQjXd9X+OK/h43smb42NvOndH0ImsssWfB+qxujrUIIAljGxghHBuh9A==
Received: from BN9PR03CA0293.namprd03.prod.outlook.com (2603:10b6:408:f5::28)
 by DS7PR12MB6072.namprd12.prod.outlook.com (2603:10b6:8:9c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Wed, 5 Nov
 2025 15:49:37 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:408:f5:cafe::bd) by BN9PR03CA0293.outlook.office365.com
 (2603:10b6:408:f5::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Wed,
 5 Nov 2025 15:49:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 15:49:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 07:49:19 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 07:49:16 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <jgg@nvidia.com>, <kjaju@nvidia.com>
Subject: [RFC PATCH 4/4] hw/arm/smmuv3-accel: Read and propagate host vIOMMU
 events
Date: Wed, 5 Nov 2025 15:46:52 +0000
Message-ID: <20251105154657.37386-5-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251105154657.37386-1-skolothumtho@nvidia.com>
References: <20251105154657.37386-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|DS7PR12MB6072:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eb96423-b5a4-400e-e827-08de1c82ec84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MHJldzM5K2ZXUTJFVnhXd1lGeERIZ29BYUphdzNXdWhLQW9mSUNMYUpiVUo3?=
 =?utf-8?B?d0thNXZtQXdDalpKS05rQjljR2Z0Sk5FK1I0Mk9TSGJTRnpBYTJPU29xYmQ5?=
 =?utf-8?B?RWNUSWkySDNWUUsyYXhTVHk0OEJ6MnRIV05hUTRuQUVhTmF3bCtoMjV3UTF3?=
 =?utf-8?B?cnBEVHNUa0JRQjNMaE1qQjUxdENwYnowbTBjWHprTVVvUm80aUl3UWswUEZw?=
 =?utf-8?B?TTZzMGtvR1VUcnV6N212NDIxYktNVjVVSU9YYWJWa3gvci9QVUl1M0ZHQzN3?=
 =?utf-8?B?N2NIN0Roem1XdFFGU0lWZExBenFHK2lwaE9GcSs5QXUrRkFpR3NMNTA4Zy9Q?=
 =?utf-8?B?RTF0K0ZvZHBEZVMwa2VGUzYrdXVXSFZLMmkybkUvMmFkUnBQa0xTWDNpVldF?=
 =?utf-8?B?ZXFHblhiQ3l2NG1NS1FUSUNZdjNQT0lZcEcyMm9DQmZWcmc4NllIOGRTRHpI?=
 =?utf-8?B?eU5KSHQwREhQUk5kaTRFK3VMNnRrM1pta05WZXpvNkg4T3MxcDZXWlVVYmNP?=
 =?utf-8?B?VVo0dG5aendCRkt4bGFrbWJZVHkxckZ3NnJ5djRYdUN3MjUyQjBjeHNwUytF?=
 =?utf-8?B?TUVmYTlWN0U5Nks2MEdjSkt4YXJpQ3poRm1NV0pFbXpNbWVUV1lmVEVPQjA5?=
 =?utf-8?B?Z3V3MEhyN0RiYWdqZzRuQjVtcGZJZ1dYSjExc2tvSmdiRXhETW9rNS8xRkJ1?=
 =?utf-8?B?SGNlVU5MRzNndGxobzBQaXFJby83eGpEeitjclRsRTFqRWtzY1M5ZzBoMTFG?=
 =?utf-8?B?aVg0ODdrQWdLb2hzam9ORm9ES3JEU1orM1NZdElWK0FaME9pR3lXMzUrTXBQ?=
 =?utf-8?B?OGJVYTVrWnlWYytTZ0dqODRoRnJNNGFVR0FhTE1ua2V2RVBqQi9GUlNjNnJh?=
 =?utf-8?B?eDNORmF5RjFXcURuMXdQV1Z6QlFxMFRJeXk2UGVYakhMUitGcytDTFE1WWZ6?=
 =?utf-8?B?Ukw4eU1DY1JpNnlPZFRvZVpXTGpsWU9FNFJYV0c2bkZ1a2tZU2xPeXA2dGZD?=
 =?utf-8?B?V3RlK1IwVGZtWCt1OWUrdVlKYkx0YXhhWitQQTVmU3YzYTg2YUk2TTZGd2NU?=
 =?utf-8?B?NUNuQnBBY2J1em11QUJIZVZCREdkeUVZMmtkemc0QkNrQ0J0S0lmTTlnc1p6?=
 =?utf-8?B?M2tpak9jVnMyY1UrYU42MDI2TUl5MklZZWRtaHpmN01qTzFzL1RMcjVjSkQx?=
 =?utf-8?B?N1dnMzJEWWlxdEY0SFFZRU1Ca2tKSm8xZ3FmZ0x5WXlpYlZ4Mk1OZGdrdUt4?=
 =?utf-8?B?Tis0VGttN2J2bXFwZW5HSWdLdk9wM2puS0sxY1lMa3B6b1ZwUmtqcjBKWE03?=
 =?utf-8?B?ZGFQN3dKTVBKTlNBZFJ1cmU0aFlCenhpblRKMEJ1N1ZnQ04wZnp4aDBldUJT?=
 =?utf-8?B?V2NGUTZqeEwzb2FZTTd4S2FVZWJMNjE4c0V4Rm1hcHozYmZYeCtvQ2d5MW9r?=
 =?utf-8?B?aW95bkhsZDhEUVVBUGNhKzBvT1dRTWN2cXppRklEdHBKcHpOZDRZWWdQNCt6?=
 =?utf-8?B?VXc1S3pyeTIzUHlhNlN6TEVzd2h2b0thV3c2QmtUeHVlcGRqNzFuRUxvdWgr?=
 =?utf-8?B?djNTZ3pDQkNtQVQ2dTZPbzVjbVFLMlQrdE5Ta0k4UXJIRjNkdkJpb0VYMzJN?=
 =?utf-8?B?U25xL2pyM3BrYjhFbWE2VW93aE5IVzVMb05nQmIxUnNReC9MWXgvekRoSGFN?=
 =?utf-8?B?L0NXNlp5Tzl3ZWMyalcvbVlFMHJoY3ZGMGhWSytSSmtmU3ZRTTkrTXhabzlm?=
 =?utf-8?B?U3dWK1o5aHZsc3RkM2txR2w3eHlGNVpmMEpGYzRmSFZyQnc0KzhEK0N1YzhZ?=
 =?utf-8?B?TUQwTDVDZDZZSVpOYTlsbFdUTHJzUHZsM3B4ZnZtWG5SUEg2dkYrMnk3NjJz?=
 =?utf-8?B?SlNZbnRmTnlwUFV3VkwrUW84ckZLUjZYdGRzT05md0NqemIwcitqUW91OHBV?=
 =?utf-8?B?cFhQVmNVME04RXl5RVovVlNtUmJWU0ZMZkJWY0lSR1BmUTRid2dzQVRlbWdP?=
 =?utf-8?B?dG1jaXQwTEZmb0FORm1SUUpGZElWcmFqYkI3cXNURHJpUkF5R3ZMWTlvZWEx?=
 =?utf-8?B?Mk83bnJCb0ZUQ2prenRZaTVoWXpOQ24rOGVmSHloZEpYaTBUVVMvZytReTdY?=
 =?utf-8?Q?Eu0U=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 15:49:37.0867 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eb96423-b5a4-400e-e827-08de1c82ec84
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6072
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=skolothumtho@nvidia.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.517,
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
 hw/arm/smmuv3-accel.c | 62 +++++++++++++++++++++++++++++++++++++++++++
 hw/arm/smmuv3-accel.h |  2 ++
 2 files changed, 64 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 210e7ebf36..e6c81c4786 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -383,6 +383,62 @@ static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
     return accel_dev;
 }
 
+static void smmuv3_accel_event_read(void *opaque)
+{
+    SMMUv3State *s = opaque;
+    SMMUv3AccelState *s_accel = s->s_accel;
+    SMMUViommu *vsmmu = s_accel->vsmmu;
+    struct iommu_vevent_arm_smmuv3 *vevent;
+    struct iommufd_vevent_header *hdr;
+    ssize_t readsz = sizeof(*hdr) + sizeof(*vevent);
+    uint8_t buf[sizeof(*hdr) + sizeof(*vevent)];
+    uint32_t last_seq = vsmmu->last_event_seq;
+    ssize_t bytes;
+    Evt evt = {};
+
+    bytes = read(vsmmu->veventq->veventq_fd, buf, readsz);
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
+    hdr = (struct iommufd_vevent_header *)buf;
+    if (hdr->flags & IOMMU_VEVENTQ_FLAG_LOST_EVENTS) {
+        error_report("vEVENTQ has lost events");
+        return;
+    }
+
+    vevent = (struct iommu_vevent_arm_smmuv3 *)(buf + sizeof(*hdr));
+    /* Check sequence in hdr for lost events if any */
+    if (vsmmu->event_start) {
+        uint32_t expected = (last_seq == INT_MAX) ? 0 : last_seq + 1;
+
+        if (hdr->sequence != expected) {
+            uint32_t delta;
+
+            if (hdr->sequence >= last_seq) {
+                delta = hdr->sequence - last_seq;
+            } else {
+                /* Handle wraparound from INT_MAX */
+                delta = (INT_MAX - last_seq) + hdr->sequence + 1;
+            }
+            error_report("vEVENTQ: detected lost %u event(s)", delta - 1);
+        }
+    }
+    vsmmu->last_event_seq = hdr->sequence;
+    vsmmu->event_start = true;
+    memcpy(&evt, vevent, sizeof(evt));
+    smmuv3_propagate_event(s, &evt);
+}
+
 static void smmuv3_accel_free_veventq(SMMUViommu *vsmmu)
 {
     IOMMUFDVeventq *veventq = vsmmu->veventq;
@@ -390,6 +446,8 @@ static void smmuv3_accel_free_veventq(SMMUViommu *vsmmu)
     if (!veventq) {
         return;
     }
+    qemu_set_fd_handler(veventq->veventq_fd, NULL, NULL, NULL);
+    close(veventq->veventq_fd);
     iommufd_backend_free_id(vsmmu->iommufd, veventq->veventq_id);
     g_free(veventq);
     vsmmu->veventq = NULL;
@@ -433,6 +491,10 @@ bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp)
     veventq->veventq_fd = veventq_fd;
     veventq->viommu = &vsmmu->viommu;
     vsmmu->veventq = veventq;
+
+    /* Set up event handler for veventq fd */
+    fcntl(veventq_fd, F_SETFL, O_NONBLOCK);
+    qemu_set_fd_handler(veventq_fd, smmuv3_accel_event_read, NULL, s);
     return true;
 }
 
diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index 740253bc34..6ed5f3b821 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -23,6 +23,8 @@ typedef struct SMMUViommu {
     IOMMUFDBackend *iommufd;
     IOMMUFDViommu viommu;
     IOMMUFDVeventq *veventq;
+    uint32_t last_event_seq;
+    bool event_start;
     uint32_t bypass_hwpt_id;
     uint32_t abort_hwpt_id;
     QLIST_HEAD(, SMMUv3AccelDevice) device_list;
-- 
2.43.0


