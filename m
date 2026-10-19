Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE71B606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 20:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=SmGfNwoR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xItol-0007S1-Bb; Mon, 19 Oct 2026 16:18:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Shivansh.Dhiman@amd.com>)
 id 1xItoj-0007Rk-Ah
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 16:18:45 -0400
Received: from mail-westus3azon11012058.outbound.protection.outlook.com
 ([40.107.209.58] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Shivansh.Dhiman@amd.com>)
 id 1xItoh-00009E-9S
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 16:18:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pBxU4+RUaMYDT71dVtgLeuZ5YBUyHHM30XAX8qIm1s9Wp/ClsUSMygJ/4BS7ba7y3E+vwTeSNVf46oFosst9XFdBg9oZWuFwRqUaHiZclaJnBZOMKy2Xmrim1VKSRB9wnMRY3UJn+uZg2qnGor9FbHtgcOblXV82e1FJcD1F2ArMndeT4JZsAN8C6HNFGHtVe+Q0imgjm/ODeLpemFuZkFpQISVQ7OTXkRSB0r1XeoWAPb1160Y4RFJL8PDDS5G3NzfIE+6Ss1y9dEtLmyCbVuZ+2u7jVOlf6+4pb9mGr3AUGc/TZ3eMjybjpMFyPA055U5bS9PrTgS0P3GTyupztA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rVWsT3EYwUtjVr8hufdMWsty3yJ5xMO9XV0NsnOvMgM=;
 b=Gy+ZjtTq8jQhJ4a4Dslp3ckHTLDNaBK5D1CxWXjNIrA8pMDY3V0rpu9/s+oBI6yFayn5NtLXrZbBLh7fxSP7lNaGHa5CcGgD6bqwfKWaFUAckHXfA9eLfOvIJIXS1PJCHy+3sMxSbujRz9kCyLfuIRfRGRzhpGUV6MCsI1te8y+F7ikMNbWoQsEgKP4EvvlfDOeILoL4/f6CN7jwDfBZ3C7Cu0TS0yDay6bBlxPemY0t1EnQbgIXY0QhfiLaxWwviajzg9EbP3BDkOqAf/3IAN/PrvwXwiaGh3ocSNcAqyOwfoBcydF/OPjPwbVTXw0k3YAx3NSR/SZpZ7t6S3pkDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVWsT3EYwUtjVr8hufdMWsty3yJ5xMO9XV0NsnOvMgM=;
 b=SmGfNwoRGVw2wrg9xJOXRgQ0ZXmZp/8N4QMNXtMt3sByrd6kaYIMjolWOfU3d6/5ePxqWH8aCiy3pgB/nO9J8wLTpeLvZDaIwGanJhXILxzyuqzZpUyQyPlDsPzISSonu/VXunYM8yFR7GB+6IGNhxG+hLmMdK0TyTEItY0QZ+M=
Received: from DS3P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:45f::7) by
 DM3PR12MB9285.namprd12.prod.outlook.com (2603:10b6:0:49::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.14; Mon, 19 Oct 2026 20:13:35 +0000
Received: from CY5PEPF00000E76.namprd02.prod.outlook.com
 (2603:10b6:8:45f:cafe::78) by DS3P220CA0014.outlook.office365.com
 (2603:10b6:8:45f::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 20:13:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY5PEPF00000E76.mail.protection.outlook.com (10.167.247.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 20:13:34 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 15:13:33 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <pbonzini@redhat.com>, <zhao1.liu@intel.com>, <mtosatti@redhat.com>
CC: <seanjc@google.com>, <kvm@vger.kernel.org>, <qemu-devel@nongnu.org>,
 <yosry@kernel.org>, <nikunj.dadhania@amd.com>, <sandipan.das@amd.com>,
 <shivansh.dhiman@amd.com>
Subject: [PATCH v2 0/4] target/i386: Add AMD LBR Extension v2 support
Date: Mon, 19 Oct 2026 20:13:09 +0000
Message-ID: <20261019201314.269798-1-shivansh.dhiman@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E76:EE_|DM3PR12MB9285:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f5d5427-91c5-4a2f-a005-08df2e1d742f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|6133799003|18002099003|10067099003|13003099007|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: vosuHuz3N7DpD2IkyP8OnYL4JOph+Eln4lIAs+4zrzVemVurNa2R5pS2MU2JA8WWNKytlnPT0sN69ob4/tumBO8JHIpBhQw0vVpwgP8eoB6I1qYfae06RZUTIgHOyoqwAAEQZIkYSXwFc0zdLbgCzl0Y+pwu3xh4hCVDW019KbULUOYxpk0N7yx349ISftw8s4nbi7DEpJw6zKhE1vlMXey0/NvdBxdXmNO1s2VtFzU1BEOUeZL9PDNKdTfNyqFxt/8u+GGxOUx4Q/XYF82KJgyBXPVRkdOGsLvwTHR5UKDRk+BDXF8YKSkGMwl2IRSbkGrCuW0RIoH2KMIFA1qbjvIuZsuRfc40dcltzJyWND68+fsLJPGftZ8/KXKIEhOk9tK+Sy0yJmIZgjiWwfjjmVxVrG9MzGviYZSaM8S1/kETp9rds3bmzjcQ0P6vQyxHxzCdG1i8XQeJb4sTKddtIt3bvlGIprwzRqPh/CYeE0zZ3RKhrK+EnND6pRgSPHIPQ4+dtx0EEsoJOIL9pgASpe6YiLoxzByj1p92Sng4BPug82GfWpBAPRTOlFf7C7vKh+E9B8wXykV3KF1sBhHCS4JWEVG65aia1R9Yfs65qK/qKXhsSyX2qNqHIkX+xZ9kFnoZGYK++Lr5CAM5nx/ja6YoVe1xoM9yGnWMqOrfTJM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(6133799003)(18002099003)(10067099003)(13003099007)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: inCgCTD5fofdq+gr04YUE5H2x9gHGb/F0YJIX2KR81EIhbW/E9T/AFf2xxbPUezwG+dCz5CO2sv9YtMix5i2VrRu+DIcv6+z7iRd/uYckFfbHwmsrOfwkq1pFPHfgr/OWaDXewusLHk5UM4cZHF6HBuWN3YfJ+sPz5UVOq/kaP3mc9gL3uOsDofm6z2Qaj0AbM9XmQX4lETEu3/+VOEOFONfkqcMYfwZpG6IjCk0MBAIY2MVqdwEq5KUJGKxYdZygGxwHkt/iGiiR8YIP5/+6Di1b0l8Yo4i7iQTSRwwCxoS/pLtgWnwj2prm3u/GE7xW9pmf7kzUsVzlxk/5xw0gOtEcdnnzmCL4PgU/FbgnsKdAqbhYBr9a4gJhSraMHjWMHLOKV/C8btsYXT2xezZa5tF3NfIwEHgJlEnWFMratVG/OuH5/DSfAt74QsLah5R
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 20:13:34.7271 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f5d5427-91c5-4a2f-a005-08df2e1d742f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY5PEPF00000E76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9285
Received-SPF: permerror client-ip=40.107.209.58;
 envelope-from=Shivansh.Dhiman@amd.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This QEMU series exposes AMD's Last Branch Record Extension Version 2
(LbrExtV2) and the dependent LBR/PMC freeze feature to guests, so that
they can use the LBRv2 virtualization provided by KVM.

LbrExtV2, introduced on Zen 4, is a branch sampling facility. It records
the last taken branches in a 16-entry stack of dedicated MSRs:
  * MSR 0xC000010E - Last Branch Stack Select  (LBR_SELECT)
  * MSR 0xC000010F - Debug Extension Control   (DBG_EXTN_CFG)
  * MSR 0xC0010300..0xC001031F - 16 LBR FROM/TO MSR pairs

v1: https://lore.kernel.org/qemu-devel/20260724201203.633799-1-shivansh.dhiman@amd.com/

Regards,
Shivansh

---
Changelog:

v1 -> v2:
 * Rebased on v11.1.2.
 * New patch to read and write the LbrExtV2 MSRs with KVM_GET_MSRS and
   KVM_SET_MSRS (patch 1).
 * New patch to migrate the LbrExtV2 MSRs in a new VMState subsection
   (patch 2).
 * Moved the CPUID_8000_0022_EAX_LBREXT_V2 definition to patch 1.

---
Shivansh Dhiman (4):
  target/i386: Add MSR access interface for AMD LbrExtV2
  target/i386: Add AMD LbrExtV2 states to vmstate
  target/i386: Add support for AMD LbrExtV2
  target/i386: Add support for AMD LBR/PMC freeze

 target/i386/cpu.c     | 26 +++++++++++++++++++++++---
 target/i386/cpu.h     | 15 ++++++++++++++-
 target/i386/kvm/kvm.c | 31 +++++++++++++++++++++++++++++++
 target/i386/machine.c | 24 ++++++++++++++++++++++++
 4 files changed, 92 insertions(+), 4 deletions(-)


base-commit: 4fc49f46dc95d4a27de2509e7fceb2931e91faeb
-- 
2.43.0


