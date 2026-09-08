Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B3CC79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 13:34:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3vyJ-0003nP-3p; Tue, 08 Sep 2026 09:34:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x3vyH-0003n4-ES
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 09:34:45 -0400
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x3vyF-0005my-CR
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 09:34:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YkXJkZ1oG5HkXSWwGwnJyO/60E8o03R4E7xhSDAlbCJHVVjTfgkH5C10tcASEb3M2mesdBto6PIBErbAtvqoNGZWt93FCQfx6FsmZuX926tiTBeY3pYaRCqS3TZKA5gsS0LGzLzRh24ArH0hkda5ATi+uOCyg/EP3F7oPOKqe0P/SrsB701vXb/EroDAXyeRBywY2kU+/qYp4CdsGCLQVHgXNmZMXLsyKNMcLP0resdxmApi5ugpavd0RchSWGUljpEWogBm7llO6C4LyL0HBuOkJJabUkBow7rXdC0VFDFu7i8pBCJXBYbSoFR2frhWoPohhsA1cDPDa36qWt2cyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRj3zg+9itdYyS6z7QNXQBDIItCdYPar+DU2LFF/qUc=;
 b=CBoTijMuYDoW3ZYZ4VrLg5Ci52CyOlle8hU9odN/hkPVRH6Khl/zi0aLzapwkaRplxLUDr1ELzJ7hssGSsVFtpg8thI4ks7oTRF2K4thRJt7hFAS0VNFVEjEPt3mzVx8N5HV8mlMArntBQSkskLFwaQSkkLfQ72EvJfPwm54SRYtGGz/HOQ4ugPrIZvZwVayleAdszPMM7OnxsMRSCihEdhvzYbfMwoRpmGrE7u1ppDp2Xw8RiCafcmZ3Y8ck8u6by/YL8lb6VqshXvd3qMv6CHDCTuKSglFLY3cILcGv3k+hrWH7HRmerQq3cFj4M+9qiqjQbSa0twago3LAfyUmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRj3zg+9itdYyS6z7QNXQBDIItCdYPar+DU2LFF/qUc=;
 b=VunEDgdXmkzvvdq9RVSKHl+9VPgYwmzfCp2pVhB/oaOapyouEXiE5K2+8EjEk9TYLaArWf1Y96zvajrwtNAJaBMaWQw1fqxiffQIMbCDXkrFV4KnvPecPsOQUEbY9nw2C59YjrXWNaMWPaTiDT4YK7n1B3crnqOnYEDXwl7SrxA=
Received: from MN0P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::26)
 by DM4PR12MB5866.namprd12.prod.outlook.com (2603:10b6:8:65::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.7; Tue, 8 Sep 2026 13:34:32 +0000
Received: from BN3PEPF00022BC7.namprd05.prod.outlook.com
 (2603:10b6:208:52e:cafe::2d) by MN0P220CA0016.outlook.office365.com
 (2603:10b6:208:52e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Tue, 8
 Sep 2026 13:34:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BC7.mail.protection.outlook.com (10.167.248.212) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 13:34:31 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 08:34:31 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <berrange@redhat.com>, <armbru@redhat.com>,
 <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>, <xiaoyao.li@intel.com>,
 <chao.p.peng@linux.intel.com>, <david@kernel.org>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v5 02/12] kvm: Detect guest-memfd flags supported
Date: Tue, 8 Sep 2026 08:30:52 -0500
Message-ID: <20260908133151.836685-3-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908133151.836685-1-michael.roth@amd.com>
References: <20260908133151.836685-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC7:EE_|DM4PR12MB5866:EE_
X-MS-Office365-Filtering-Correlation-Id: 16e9f05f-1791-4bfa-261d-08df0dadea0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|82310400026|1800799024|36860700016|23010399003|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: OlwJaSZfk5DkR1fE7lYVqr1jrALe43AKivakiOMf6SilXMBKeFsijy+Z8iTdUL/Px8jsNmljNWZUdcNLQIm2P5G2cXGDwVgBrmnLfxABBf8T0AF9fSYPaK+wrZDkwlX6Rf1zjQaFN7L5B0LrdHLKedArz86elK2bKIAI5mGje3wQoWZD8JgYul3hptEEKzRjPH6GGBMqG3S+zWRMFeXyjofhO52MXudJqmCeyO4hxBjKqJNR68xugiU2jfqj9v6Rbs93KD5tAhgu5CGOuDX7A4xcbJ3jFx/FdLJGRmTld2iLvup6szk6rMaZgtfB4zGf9ckstOFgS2SqE1SNP62WJ1gJMtRTcheU5AovZnbO9l632SObQHGCK+4RqbqijN1vyXIg3JBdMFewJ9Z8PRcWxh64gYZdqIF2KjrD397KCNhn+4ZHzwRVG02woWNd2occpJVQrzhlsRltJ6jYXNvLncQ+i39oq+ZHCAxm1ALMnp8rgge6gMC17w04lYDBzuod7ie812LPM5/c/RYP14juc0IrkXHwt6mrro0g2B6YsxRM6kmdaSsddXbYVlF7cuq/XQgtc1hU7AZbDtKSz4gMrDRZyV3tS4amPF83jBcOWgfzfgIh0INyINkLTJkux0BjwpctlAXvG38T0webIK1TtkYyPwIKPyuNDJS/djOxQqShcijkOiPwG1gRAtSlWaCq3jlF2RwLrfdHgrkNcENKqA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700016)(23010399003)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iE9PW4kQIfyOMflLoEKAI0cjHBipXPwFVsQTyHAMZgW3sXPwi/1jkF3MLEedtWGBeXTFcEuh3HcViIf8FuAF0kS/lRc0iMuV6B8FC1KejCt8DlSevLOklqIXLdCTCTbKdBppaMiz3/a7YuH0jbJSzsdW6YQBd3dBEgSd78Tkx2KCblAm97oaW3gKy16R8qTvxibR2N6/WFuLEVMabunkIHFpeGkbanKovVuW73/r6xOMqxfsuYxL/LFRK+oJGTyBr2XXoViKN5ssT7g1BbZcCL7IeYTe+GsL/CW7KRAcnMuY2i2/Exy+ok1nUiWgb5Dx7PE2rtpHbrKc7jaq65BRNHnbCOHyhSpH/L3dyCry5a8TPZT0gwvyf7+eTniOpVcX1WLiBV6u4+3ySGNGNXjQz2qCMGHIHoxkKY3mhfbzLsTuBWEZ64jyeziG+ndQyXL4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 13:34:31.6785 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e9f05f-1791-4bfa-261d-08df0dadea0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BC7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5866
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=Michael.Roth@amd.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Peter Xu <peterx@redhat.com>

Detect supported guest-memfd flags by the current kernel, and reject
creations of guest-memfd using invalid flags.  When the cap isn't
available, then no flag is supported.

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 accel/kvm/kvm-all.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index cdc7554082..120cab1e22 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -107,6 +107,7 @@ bool kvm_pre_fault_memory_supported;
 static bool kvm_immediate_exit;
 static uint64_t kvm_supported_memory_attributes;
 static bool kvm_guest_memfd_supported;
+static uint64_t kvm_guest_memfd_flags_supported;
 static hwaddr kvm_max_slot_size = ~0;
 
 static const KVMCapabilityInfo kvm_required_capabilities[] = {
@@ -3065,6 +3066,8 @@ static int kvm_init(AccelState *as, MachineState *ms)
         kvm_vm_check_extension(s, KVM_CAP_GUEST_MEMFD) &&
         kvm_vm_check_extension(s, KVM_CAP_USER_MEMORY2);
     kvm_pre_fault_memory_supported = kvm_vm_check_extension(s, KVM_CAP_PRE_FAULT_MEMORY);
+    kvm_guest_memfd_flags_supported =
+        kvm_vm_check_extension(s, KVM_CAP_GUEST_MEMFD_FLAGS);
 
     if (s->kernel_irqchip_split == ON_OFF_AUTO_AUTO) {
         s->kernel_irqchip_split = mc->default_kernel_irqchip_split ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
@@ -4760,6 +4763,13 @@ int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
         return -1;
     }
 
+    if (flags & ~kvm_guest_memfd_flags_supported) {
+        error_setg(errp, "Current KVM instance does not support "
+                   "guest-memfd flag: 0x%"PRIx64,
+                   flags & ~kvm_guest_memfd_flags_supported);
+        return -1;
+    }
+
     fd = kvm_vm_ioctl(kvm_state, KVM_CREATE_GUEST_MEMFD, &guest_memfd);
     if (fd < 0) {
         error_setg_errno(errp, errno, "Error creating KVM guest_memfd");
-- 
2.43.0


