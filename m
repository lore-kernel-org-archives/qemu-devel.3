Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB9B2C531F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 20:18:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnML2-0005iy-NW; Fri, 24 Jul 2026 16:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Shivansh.Dhiman@amd.com>)
 id 1wnML1-0005iY-B0
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 16:17:43 -0400
Received: from mail-westcentralusazon11010014.outbound.protection.outlook.com
 ([40.93.198.14] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Shivansh.Dhiman@amd.com>)
 id 1wnMKz-0000MQ-Bj
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 16:17:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mo5tdokwng0XxbDMnpjWB/W/cjWSgzBsyobMZx+Uz9jyxyjbGLdMIcvfFGHr3sryfzEl/lcrhX0morFiFOQkeNODPoA+Ck1M7VhDTzEAWTLhsVekA+DXxJ95jKY0xwlEssL+LwuMo1Ij1lIfknDEhRl4nHrL7ZGFsgg+Tz0y9cSPKI8aV8cGoFinIXn5E9p76FefVXJmYlS+u4fAz6swlcyq1TBmvFCdNa7rMHqpaItJC4ZG0YkilkZtshMbIAeLEDdavbikF4xQzqoYwaH3Fjh8RaIdzeXIRdnEris4/wSIIhNvUfzR6CoYAcd2u0qKKUpPWqXcAmbCu82ayryITA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQOK3TFH7pimxXHkc3vaxz1+nlxc164TQ1zsOvfan1k=;
 b=sdWDb2mH6XPCfpkR0sCrgf9tcPmnxZy4QCIx5jXtL1yvfA+VXmRBfjiE/CDpCfjbqLoQiTdbKRF4ECdFiyGUQEI18n5p4SLS32DXcPa60ZQv1oFxn1AmZb7Duo984yGNY1YDvXWXO8rEGfBs6M5SDdiRUEFDIJyQ7i4rEivem4aa0YX5fmvYvrgL6nZMe9oydmaJ6cZ1syw7R80LrkLuxKUinp0nHCoSgU8pRTFMNz/Fr7ybk6NHlQlJ35kXaGJCs56DC2BSr36SQ7kVz11SJxd6hbsC2NFheT1EoA28JgeoHICNN/5Y/0jib7aRoYRgLooz+Dp1NAa6n/6NH1tTCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQOK3TFH7pimxXHkc3vaxz1+nlxc164TQ1zsOvfan1k=;
 b=f9chaf8gAsofLJb+hnEuO1q0Jc0elxucRiTc+oZYRS21u1NwpXY2UAw5DUt0sxSt1RzSqZs55Heq90yO9KqEJ2Z044z8Hg8vYj6TMHpUGb90FNiVcvvlKctyUj9s6ivvKTybhP0mQgH3VO2nDU15U+Z4jlKM7vQmR1ydkMU/DxQ=
Received: from SA9PR03CA0010.namprd03.prod.outlook.com (2603:10b6:806:20::15)
 by BN5PR12MB9462.namprd12.prod.outlook.com (2603:10b6:408:2ac::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 20:12:33 +0000
Received: from SN1PEPF00036F3C.namprd05.prod.outlook.com
 (2603:10b6:806:20:cafe::a4) by SA9PR03CA0010.outlook.office365.com
 (2603:10b6:806:20::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Fri,
 24 Jul 2026 20:12:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F3C.mail.protection.outlook.com (10.167.248.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Fri, 24 Jul 2026 20:12:32 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 24 Jul
 2026 15:12:27 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <pbonzini@redhat.com>, <mtosatti@redhat.com>
CC: <zhao1.liu@intel.com>, <seanjc@google.com>, <kvm@vger.kernel.org>,
 <qemu-devel@nongnu.org>, <yosry@kernel.org>, <thomas.lendacky@amd.com>,
 <nikunj.dadhania@amd.com>, <sandipan.das@amd.com>, <santosh.shukla@amd.com>,
 <shivansh.dhiman@amd.com>
Subject: [PATCH 0/2] target/i386: Add AMD LBR Extension v2 support
Date: Fri, 24 Jul 2026 20:12:01 +0000
Message-ID: <20260724201203.633799-1-shivansh.dhiman@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3C:EE_|BN5PR12MB9462:EE_
X-MS-Office365-Filtering-Correlation-Id: a477e093-a85a-40e3-c072-08dee9bfe562
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|11063799006|18002099003|56012099006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: AJFIYBuB58XrD4HWIhrUY83sdlskeMaVHC8uUxUpADNIOu3umNdLjGNoEt9g6FGgxd78jXswwZm3S2AuD9LXpjofCS95pG5oxGtWIw78r4igld3Rt8Qp5Ya6Vuc3oZAzQxqzTlDeuwlFl0++LszoaEikkAXZnzXLDnqhVvRugaku8fgnGiQDfSyHQJ0rJkoJFKziAxvMAzSaoNe2UCfE34hcOjgI0qED6oRsfs1+EmZrYiGmZk0mJJS1b76462t+MWCbb7G/CG76DskP4Mwc9HdOPmambH47iz8q0CDtVVvVrcE2WRqXyeMRtE3gl1uEAAIyKNCgcSn0OPRodAZIVWRffE8KAhEch576K6lnp24CFJMewjnNZu+alknH2jhfCqBlWREdM1YP4ASsy+dfRk389BjN9/PoWqAhpXS+vAPtiDIuHTYkEX5VIgyIZbEPa5SMlIxLOMvWo6JDtvpSprmcS9P/iiTGFteQS4qu/hlcGqRCVNuv3s3MNar21GCURlien+JurbaNj3F9EPi+qVz9rhAde2ewKYalcJDDaZ7Z4TnnNQmkTp57+5J0D+w8YLxfg0McxIkudExg36IYQdoCG+rloMVsAdYV1rfjaMhdORYzFW1YCjy6+9UZ1nRDV0e25jUIe83Mrpj7cSCkkPG9VOmWO0ZcQxsLlikpfGg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(11063799006)(18002099003)(56012099006)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zo/c+FDuvZ5sW/MXg4rZ6LE+KbbeJnodjGKxeeNMwvdv2M/5f45kF5Q9SF6dX9HPQP7AIKXo6m9IZkDq/pa71KuuYjq8FfjTuC+QP03nEPeS8TDn3PILSo61jrs1//NRugDlIqVtEiFnBNQZb2NydqeDRYXo6WM8EwQkgjmam52fxndvGgRteUowO7fNJSdGS8zmy6UiCImlSkijT+QCbj3VuplGPoCgtnMjN2sZJxrJhCrevqDL5ri7abFlJF8jCJTCkAQqWHBZkc3UKVf5z2qxfvHTfLxALgUhF2O2zjvoB7T/ZehCdti3xMvHZuqE+ZFBk8UrzWgCEqklHN7r2itfTvFOPZ8kh3ookmMCiNiIYbiBtDBZW7gq5FEO8y0TEF+WV5rE6wNpsJogvP82PG1TkzQJl2HfhzBxWZHZoQImvpn+zijqnpm+sLkjxUK8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 20:12:32.8939 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a477e093-a85a-40e3-c072-08dee9bfe562
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9462
Received-SPF: permerror client-ip=40.93.198.14;
 envelope-from=Shivansh.Dhiman@amd.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

LbrExtV2, introduced on Zen 4, is a branch sampling facility providing a
16-entry stack of last-taken branches via dedicated MSRs:
  * MSR 0xC000010E - Last Branch Stack Select  (LBR_SELECT)
  * MSR 0xC000010F - Debug Extension Control   (DBG_EXTN_CFG)
  * MSR 0xC0010300..0xC001031F - 16 LBR FROM/TO MSR pairs

This QEMU series exposes AMD's Last Branch Record Extension v2 (LbrExtV2) and
the dependent LBR freeze feature to guests, so they can use the LBR v2
virtualization provided by KVM.

The related KVM patches for this feature can be found at [1].

[1] https://lore.kernel.org/kvm/20260724195040.630468-1-shivansh.dhiman@amd.com/

This series is based on top of stable-11.0 (tag: v11.0.1) branch.

Regards,
Shivansh

---
Shivansh Dhiman (2):
  target/i386: Add support for AMD LbrExtV2
  target/i386: Add support for AMD LBR/PMC freeze

 target/i386/cpu.c | 26 +++++++++++++++++++++++---
 target/i386/cpu.h |  4 +++-
 2 files changed, 26 insertions(+), 4 deletions(-)


base-commit: 6e9a825c1d4e7b62d072e99a89ecd1a74c7f0d55
-- 
2.43.0


