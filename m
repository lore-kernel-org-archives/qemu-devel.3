Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C985C88E45
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:29:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x53Bo-00088z-5v; Fri, 11 Sep 2026 11:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1x53Bl-00087y-Kg; Fri, 11 Sep 2026 11:29:17 -0400
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1x53Bj-0007DB-T8; Fri, 11 Sep 2026 11:29:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jd6Sw7PFIqpR8DI8jvBTHVXPiD+LwYBa7WYxpGGVQHXQBmQIBWltoSyysJC/1p8x1ThfyPpXHHviOt/9GgXA7SF++PzvK9642Q5akB6bA+7Ki9J8S98u7YHR9N3Z+IMDmmKnh7as2yXU8UggLtS07e9+f5X6ETDMbjiJGZD/1dKPtYDYiHZvE7n4TSplQhOJNdzpPGYVjQ3NlUpPBN0FUE/JEghwrTbNTg9xUKoCb9t+Tot7ccy8lyxq7dr3oKfR++9AbuF49vwicGnFkm5iYl0d4WaBspwi/FeUb4hFuuak2DuSRgBGSQ0Skxt6RdMVeXYdt0qScLn9dVW3mW6WBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X0VPTy4UiVkwvjNpZj8eYKkSBbjb008hi+rPXEOBVYE=;
 b=ZlH6VqNaOFi7Txgm2vWR3Qq+5PRinNhGoN2gHhZf63CJnRUyIuOfg1hyyM4YOk0gnBWEtBeQrsqBYwGrvvU43ks45aRQQ330twt8XDwovJeagmAV8XJtOfrpkjsO6yw9MBn8pMYioy6XekWWijP07pP+l7MIXrMRP1KqjKKCQMrbFghgHXw1QnkjcYSa8Lui6KGCpP0ZvHCTnQ81Y4foeA20am1u8d1BSrwYuFyPctPUNf78d+Dztt5Qu2rbGsoIsvhDHVjv+Bf523bU1UA2kk8A4r8NlCvr3SNnlon1X5sNf3SNtpkGGhmLaa1iHnxVo5WVloWSGCiFMC2G7rXIbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0VPTy4UiVkwvjNpZj8eYKkSBbjb008hi+rPXEOBVYE=;
 b=A0T0HnDfBI6YJpDc2yAzI9AhPE5KqCP/DXE2aG6Rv6sr/KRmDo7RKyGQ7OiMCiqcNJeG6063K3cICdWyglkSFn2ACpr6J0HZdb4TA8DPiaGyErcu1/KWuOb6W2B3GkaYFJ3KOaUaL05WmltrOFgbU1zFD+gcJWKePb3dA2p2PuCGJnKvax7riacSJX/EQzAKJaIksdzVNSD0jA4nerxgstY4d/NeixfeOijHCfTS1bzZYsU42ibPe9bX9fz4i0ewNzSMbwiY1zPJvqZ9IKT49WySGzvRg7x4LM8yRpCJxpEbGuZWQ/FYdDhrrxSrw4GDNOgryS/+QDPbXM5TeXXH3Q==
Received: from PH7P222CA0014.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::16)
 by BL3PR12MB6475.namprd12.prod.outlook.com (2603:10b6:208:3bb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Fri, 11 Sep
 2026 15:29:10 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:510:33a:cafe::1d) by PH7P222CA0014.outlook.office365.com
 (2603:10b6:510:33a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 15:29:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 15:29:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 11 Sep
 2026 08:28:41 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 11 Sep
 2026 08:28:37 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <cohuck@redhat.com>, <sebott@redhat.com>,
 <berrange@redhat.com>, <peter.maydell@linaro.org>,
 <khushit.shah@nutanix.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jan@nvidia.com>, <wangzhou1@hisilicon.com>, <maz@kernel.org>,
 <oliver.upton@linux.dev>, <skolothumtho@nvidia.com>
Subject: [RFC PATCH v2 1/5] target/arm/kvm-consts.h: Add SMCCC vendor
 hypercall definitions
Date: Fri, 11 Sep 2026 16:27:50 +0100
Message-ID: <20260911152754.706518-2-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911152754.706518-1-skolothumtho@nvidia.com>
References: <20260911152754.706518-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|BL3PR12MB6475:EE_
X-MS-Office365-Filtering-Correlation-Id: c9f67182-7cb3-4878-fa69-08df10196c22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|7416014|82310400026|36860700016|56012099006|11063799006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: h6+xeuuQyvNSxtY2uNAfgUB+RW6tUvC57VvIU2t5iQEv6mK2mDhh3a7XlrMBTCaLrtNYLDuE6i0hNxt0v1FLPr8wk7zNHUJALneMIHM6gwzVPFNEl7smhkaHBGySbZshpPNMGwTYeeSLawzpI+8nMlQw9sm/MDfnLIT0hVsUsog5MZynXpmLQ44K+rUokmoaCV9I43WF+aKyeZMqBkr5YmytmqgFLiL1Y3otYt0H/uAff5KZPAsEf0wFZypSZkJgtTc9WdXl2gkDK+16WSMBdH742HfULYxGz6n20/CA8lDd4neKpwjU9OkE8eGS4vK+D80PqOeG7ZvogA6S7Sk/ilGZhkc/lPxTlFDFduQQ3FhjU01cLqwD8eWjpyo+9zE/z8Kh5U06XsQLyIiDukvA+lNg7SV93vRUD53oJYHH6pdq7uWogQw3vOQh5fPc0trM0hm5UDSImlfwzXfKV2ttkwVhWIIOqJN6nhecGZkmbj7vw6R/mmT63Wgc55n9AxwTTzNP35TrAnGrJF3P5Sv+CgbJl3zb4Ponp2eWZ0dkilxnoD99TqpSknuQKYn8tOF6KzTukoNsyQHkH1O9lCeFjdpjEoPtsQY3KFob2M8p1DwQ5khJqLlKd8/J3n8shqJGjjaeQsHcdmxsGAjXi7rKsmEqaTptgzqGSqa45Oj3vP2XYzkY1ZrvVUXhpo+DtKHW8GHYfmoox+yxChdJ3QZfiQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(82310400026)(36860700016)(56012099006)(11063799006)(10067099003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: djRrOR/8tFRjNHhew587fORK+e7z/gbUzVfGrs6iDl44y5cGJO/j7rJzn8FdYnTiPegerqsuKRgzMLyP72r7tjExHNWFuI2G8Ee8E0+oaUskYmuFmSWcjnPLeuxkxdt7IzH3gdjr0G6dBIGdUdPNA7dvCMA+cbdrHoQhWM0Aivda1qxinadxaOcRCqheXdfq+Va3rETOAD1Wo+NNXRGl0nLM5qo/2aXHKuY65pneuqmuX5fn13efwlA+16d/pxVG+nN1jtDxrbbP1V2SfgbFHYlB2ZA9CQWgjHeyJ/V5yp7sP6uLVkLMBkBCGZGxLL502SudN5kMUhEA5bpiCDqekSl84IX44WwviBnU/KkkByOYANOYA1MuYx0/nurWQcmkOiBw7o6bIsZu3iHgbAvwIgvfcDLwQNsfuno68qa8uos8sXTXi2DsSizsNKNVZE4S
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 15:29:08.3247 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9f67182-7cb3-4878-fa69-08df10196c22
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6475
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
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

The KVM target implementation CPU support relies on two KVM vendor
hypercalls, DISCOVER_IMPL_VER and DISCOVER_IMPL_CPUS, together with the
SMCCC return codes. In the kernel these live in include/linux/arm-smccc.h,
which is not a uapi header, so they cannot be imported through
linux-headers/. Mirror the few definitions we need in kvm-consts.h

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 target/arm/kvm-consts.h | 48 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/target/arm/kvm-consts.h b/target/arm/kvm-consts.h
index 9fba3e886d..741309c300 100644
--- a/target/arm/kvm-consts.h
+++ b/target/arm/kvm-consts.h
@@ -190,4 +190,52 @@ MISMATCH_CHECK(CP_REG_ARM64_SYSREG_OP2_SHIFT, KVM_REG_ARM64_SYSREG_OP2_SHIFT);
 #define KVMID_AA64_SYS_REG64(op0, op1, crn, crm, op2)   \
     (KVMID_AA64_SYS_REG_(op0, op1, crn, crm, op2) | CP_REG_SIZE_U64)
 
+/*
+ * SMC Calling Convention function identifiers.
+ * These mirror the kernel's include/linux/arm-smccc.h
+ */
+#define ARM_SMCCC_FAST_CALL             1U
+#define ARM_SMCCC_TYPE_SHIFT            31
+
+#define ARM_SMCCC_SMC_32                0
+#define ARM_SMCCC_SMC_64                1
+#define ARM_SMCCC_CALL_CONV_SHIFT       30
+
+#define ARM_SMCCC_OWNER_MASK            0x3F
+#define ARM_SMCCC_OWNER_SHIFT           24
+
+#define ARM_SMCCC_FUNC_MASK             0xFFFF
+
+#define ARM_SMCCC_OWNER_VENDOR_HYP      6
+
+#define ARM_SMCCC_CALL_VAL(type, calling_convention, owner, func_num)   \
+    (((type) << ARM_SMCCC_TYPE_SHIFT) |                                 \
+     ((calling_convention) << ARM_SMCCC_CALL_CONV_SHIFT) |              \
+     (((owner) & ARM_SMCCC_OWNER_MASK) << ARM_SMCCC_OWNER_SHIFT) |      \
+     ((func_num) & ARM_SMCCC_FUNC_MASK))
+
+/*
+ * KVM/arm64-specific vendor hypercalls which may be exposed by KVM/arm64
+ * to guest operating systems and managed by the VMM.
+ */
+#define ARM_SMCCC_KVM_FUNC_DISCOVER_IMPL_VER    64
+#define ARM_SMCCC_KVM_FUNC_DISCOVER_IMPL_CPUS   65
+
+#define ARM_SMCCC_VENDOR_HYP_KVM_DISCOVER_IMPL_VER_FUNC_ID              \
+    ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,                             \
+                       ARM_SMCCC_SMC_64,                                \
+                       ARM_SMCCC_OWNER_VENDOR_HYP,                      \
+                       ARM_SMCCC_KVM_FUNC_DISCOVER_IMPL_VER)
+
+#define ARM_SMCCC_VENDOR_HYP_KVM_DISCOVER_IMPL_CPUS_FUNC_ID             \
+    ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,                             \
+                       ARM_SMCCC_SMC_64,                                \
+                       ARM_SMCCC_OWNER_VENDOR_HYP,                      \
+                       ARM_SMCCC_KVM_FUNC_DISCOVER_IMPL_CPUS)
+
+#define SMCCC_RET_SUCCESS                       0
+#define SMCCC_RET_NOT_SUPPORTED                 -1
+#define SMCCC_RET_NOT_REQUIRED                  -2
+#define SMCCC_RET_INVALID_PARAMETER             -3
+
 #endif
-- 
2.43.0


