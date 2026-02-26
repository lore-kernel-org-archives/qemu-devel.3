Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B414FC592B
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 10:56:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvYzR-0005eB-Ds; Thu, 26 Feb 2026 05:53:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvYzP-0005cV-8S; Thu, 26 Feb 2026 05:53:03 -0500
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvYzN-0000vQ-Ok; Thu, 26 Feb 2026 05:53:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J8g49JLb/hZsSFfcx9ty8I8jlSqKfFwudUNOroRsNipujAmEV28eL5JcCuWs8NOtGHzcYR2TMcxfaTgkM6W0VHAPMyb0JzQ2T4QPCZvt8HEDcEcV0s5xCC2ba0RpL/kFdMmXPnIgX0ni5gxcIuI21qbm1rPJS8bMKuD6hEIaoVTzd/BN1za8cFD3p9fHSGF74943Arp6hdGwPJulDGsPygUMoNcznhM7KWSFn/jmtRn7boXPFqGGbDrIlsFsb/chSJgS+xPdiDnB+yhYiODs90A02d//0G6rPQwTC7dz86jFWJAUPUFuWfPGmdSy97JXguIjHf8qZbdrLY++M8JnMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mOmUzNaaovJ/p7xg++2LU7soe49qzwpSpOfxpx8O6EU=;
 b=Vws1xuR305NUc/f9+ygDVPAfFL/AWrq3oRDYhdeE/3njd4Dc/zVsdZ8BHa0B7QpugtaYew0qt8l4ruMsT6jGku3+QTZvKwMdEbiJ6127j81W1kyavnIS5S6FdnuGZL+I8nt0Y3xK4z5cv3tYA2IWiqMLR5l8dtrcka0kcWeJzeOU7RLs4SvNA1WG1Lt+qQFDIenDPPJgy8b1FaKdDAVpqOfYpHVInm0VDVOktuOf07UQUW/Q+RzetAC5IEjiJysczovvVxZMP4Vrx17CtwXBkejy8wx961suRvnCK4dmJPpR65VE5StF20+hnRYhPzFPf+9gq1C5BArQa+sVIDEsCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOmUzNaaovJ/p7xg++2LU7soe49qzwpSpOfxpx8O6EU=;
 b=k0BBcxF4ZNz1epqvpBP4MYkOHcSlDGAYHXWoQfwsTjGK8KK98veLifPOv/dTPHhQGXu+W197aCg9JgiSptWUGoYlFJDR4xM/1GOqCdJLmy4gxORHT4gyr/ntxjl9JNXwLnAxuTyErQAj+53be3UdFPqSC31B1BdlqAXIPwCk0WWygXMcMeU/s/9ZnM6JHJp+b8+jk9xjRBw57pRxb+hkE7MX5fz+yXb1x3GWjYcu5qKNsKqdq1r+Jo8xeSwggVkkC999t7d6XM7QwzlieQZMuJbfdLiUiK88EOwBhesvzdXkoFM1N5goqFIFkD+DeSnJVUjtKgzmIdMcdqsiWT/Ihw==
Received: from CH5PR02CA0016.namprd02.prod.outlook.com (2603:10b6:610:1ed::13)
 by LV2PR12MB5918.namprd12.prod.outlook.com (2603:10b6:408:174::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Thu, 26 Feb
 2026 10:52:56 +0000
Received: from DM2PEPF00003FC5.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::3d) by CH5PR02CA0016.outlook.office365.com
 (2603:10b6:610:1ed::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.25 via Frontend Transport; Thu,
 26 Feb 2026 10:52:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM2PEPF00003FC5.mail.protection.outlook.com (10.167.23.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 10:52:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:52:36 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:52:33 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v3 18/32] system/physmem: Add address_space_is_ram() helper
Date: Thu, 26 Feb 2026 10:50:42 +0000
Message-ID: <20260226105056.897-19-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226105056.897-1-skolothumtho@nvidia.com>
References: <20260226105056.897-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC5:EE_|LV2PR12MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: bd44900c-e60a-4429-5856-08de752532c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026|7416014; 
X-Microsoft-Antispam-Message-Info: xfAvxhZMc9xdJ1WegBOZREkeUjlETB4VWylF9yMmnJOpy9d9KceKF+3nYlbcWHP2UxiAjbyaZ2HDm5IFzlOM9Z4H/9l8D+obF4tanYL58PjEh+plkuuQ68IEtaXwf/R3yZKypsMIGjZaogQmKE1352mZbMkEIbS7YpmSt6sq/HgTKbOoNtwdAexiusY7JjsqZf13rrla94a/d53J9l+ZjNPxPifBtX2tydVPHAV3xqM0liQOvMlPyiEuGxD+lat7pMpwRppyMsgjXapYoc59ebvzCv0VmaUIIvWqZtw20IoUrgGOSd9Q3rOjVphM92MSP3JpWiGPUUQhOSx51ryJXWnMd53rfq7MZ/vHNeeaNpKEG5RwSQwPiiy0g5vsYwtnb39Cmqeoz7HwnVRaGtkKZAX8ICCGZiRk6sd5buv3+lqGjdVUusGh/2quR73kMTPnJksvR2l9SedCBigIBsjZ1F9TsCTJKKy2HmBAyQnmRq2/kdWQBLMhOfmS0LFxtONOSrI3TtHgSyRmIffu1U/Ku6p9jym3wJxLz4/jH5zgSjzLUQ/tqtcokf7o5LK60OquGPWB2LszqyjE8GBm+fcgFdAQhB8WqYJoss65fCNXRP2EfvfB8eyzJ88z7gP4KTMlMcruI2bJFoIFR5KqkWbVDoaWGALPcmDXjDzXUB2CxzWn6XAMlyHZqOLgo9XmdH3BrdKlac2ljn2Xq/aPLr/p9oEy6DAnb2YVUbu3QPdwQb6y4vJPrPH3GQx+WFIT9GAJJV+FpprQUqtesOeKW9YgRFrXfIlZi2dtTSesakhHpezbm8vFJyUJMcbac+2Nr32oEn+mgSXfk+LnwTkBLNAZNQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(7416014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cS3mres96w+ula2So7h73seRNlLACuAEoYD6sHhey7aN6/3C3ZZdLPp+NMQXfDfbeR5B+u/x/96xuIxKkJAHl3ajCU7D3gZYAtVkjJ00ZnoodgS7JyITwceSDOdv5l3TlCWAGd+0mj8Iay4o1WOZwN/eL/CP1pdK9qvhQ++DUVDXPkNAPNEIIoRCGhe65mpIlmFgpXiqJMQjsC9ETA0CMEc09dmv2GBWvDOv1WA7qUxdRy1jRxh5mmIrxPzAmA5Y2005uBOHSdCrjMJq6ucFWSSuQcJy7YOf+mqosINaOUL7kvHfszjsSzxc05Jpb0LVGCvL0TezUVWY/y3uPETPsYzfDt340prwAAp01YMiE6H/aeNpNQ8XK1ihyZUArGDe7tP2VZMPd9V5j5GQa1L3gA16L+jQh/eCIPS24RlszueVhs+1KbdYkHICyFrwIz2Q
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 10:52:55.6269 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd44900c-e60a-4429-5856-08de752532c4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5918
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Introduce address_space_is_ram(), a helper to determine whether
a guest physical address resolves to a RAM-backed MemoryRegion within
an AddressSpace.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 include/system/memory.h | 10 ++++++++++
 system/physmem.c        | 11 +++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/system/memory.h b/include/system/memory.h
index 0562af3136..02b2e83fd7 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -2900,6 +2900,16 @@ bool address_space_access_valid(AddressSpace *as, hwaddr addr, hwaddr len,
  */
 bool address_space_is_io(AddressSpace *as, hwaddr addr);
 
+/**
+ * address_space_is_ram: check whether a guest physical address whithin
+ *                       an address space is RAM.
+ *
+ * @as: #AddressSpace to be accessed
+ * @addr: address within that address space
+ */
+
+bool address_space_is_ram(AddressSpace *as, hwaddr addr);
+
 /* address_space_map: map a physical memory region into a host virtual address
  *
  * May map a subset of the requested range, given by and returned in @plen.
diff --git a/system/physmem.c b/system/physmem.c
index 2fb0c25c93..ddcf921311 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3646,6 +3646,17 @@ bool address_space_is_io(AddressSpace *as, hwaddr addr)
     return !(memory_region_is_ram(mr) || memory_region_is_romd(mr));
 }
 
+bool address_space_is_ram(AddressSpace *as, hwaddr addr)
+{
+    MemoryRegion *mr;
+
+    RCU_READ_LOCK_GUARD();
+    mr = address_space_translate(as, addr, &addr, NULL, false,
+                                 MEMTXATTRS_UNSPECIFIED);
+
+    return memory_region_is_ram(mr);
+}
+
 static hwaddr
 flatview_extend_translation(FlatView *fv, hwaddr addr,
                             hwaddr target_len,
-- 
2.43.0


