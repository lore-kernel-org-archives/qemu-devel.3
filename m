Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E84E0CF8855
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 13:26:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM4fD-0000ax-JV; Thu, 20 Nov 2025 08:25:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4f3-0008Vh-EV; Thu, 20 Nov 2025 08:25:21 -0500
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4f1-0002bQ-PU; Thu, 20 Nov 2025 08:25:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PQWcw681lTVlzYIU8jBbQOm0uWr0n7QM9LdPeEFITxeBhxbJL9FP9wDHr/I+38QyBh3+5OsA6Y/AiCJii/Gh2PUoUD1Gv+C9LRrUVduJPTm+nXIN3BghVw7n9L8jiAdEbkWbY3PWvaHVFVdr+B4yUXbxjuiRw99edv192MDmbEFmkUdM9irrPLtN4G5IZS+hPf6HcAWbcRmgQM5S8QJGJ9JuO2OjjcqUcfKD8F5bKyHhZyNXhiR7Z0Z9u07vvTqPRZ31IJmlzTixCQAW/HVNJzYCb0Ht903tTZVwaa8lQ+vyxV47p/Nrykwt8Ps7CJociqnYrDa3msXYThsYiDP4iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2OzkA8b+f8qKwpdhODuHsX7V5qTi6RBSGKjXN2gEEb0=;
 b=Cu0CUmnc+1ZBgXjXb3yUfa9xQzEOGPnJhGc7jRbp79n1bskh/htbfzFEe7lWuOTDYc2kY3DX1sh+ikp8yztza0vpD33kZylfy2m1yX7O7hO3s6KLeksofmc1dLLnD809tOt0XbADAgVQkoQTLOvDKgEJ3AQ2Tybxn+AH0BxAUIqs1J2PcUKx0Gq9tHe9nYnzTOdSdgMNn6wd19uxN9PwZ7D7GnA1tOymZRfrkVAFOg7DQ605mx3+3DbT6BH9cwh3xJ9SLWNIUiGh3ZaYKhPvCKGvuOtOla57DEDb3VdPdnC+ZX/68D6rBw6TkVNYRxMjafwaWBJZ6AWcKhzPuGyThw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2OzkA8b+f8qKwpdhODuHsX7V5qTi6RBSGKjXN2gEEb0=;
 b=mQlUXhyHafCdJMIk2pPJnmWZ3HYWtGE/t6/VPcUA2q6AbHC6R9dW6fhf5aMrWemYIgiuxCvVxYIT/P9tOkKFbUCeC0pI5Xd1zOnHl0OBtGlKWIGhUyFJ5r0v4J3V4osbi1UPBW2sN03ui2jUqs2quzcHtrT6B4lolMTZNI/ImZnbdKf/Vni8Fus7WqDoF5WVc6Abj+45DAdn+DkLRnfG76OltawNhpY/SiHhvV8xZ/xIZWZPRPFcvVzwikkJsK1yEa1yThCr/wyTkFGQ4urfaON3uWLfrYH0RX9wrtupdwLMn9E8PNsIiKp3SPddz4y4jBD25gVKuyNJ8vm2YcY7HQ==
Received: from CH0P223CA0013.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::30)
 by SA1PR12MB7200.namprd12.prod.outlook.com (2603:10b6:806:2bb::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 13:25:12 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::67) by CH0P223CA0013.outlook.office365.com
 (2603:10b6:610:116::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 13:24:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 13:25:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:24:57 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:24:54 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v6 23/33] tests/qtest/bios-tables-test: Prepare for IORT
 revison upgrade
Date: Thu, 20 Nov 2025 13:22:03 +0000
Message-ID: <20251120132213.56581-24-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120132213.56581-1-skolothumtho@nvidia.com>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|SA1PR12MB7200:EE_
X-MS-Office365-Filtering-Correlation-Id: cd263be8-3766-476a-9746-08de28383c50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|7416014|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eTlvS0JSN1oxOForZksvUjFYaE9yNk5jOGxVQ0hOWUNYQ015SVNvZDhIT0NS?=
 =?utf-8?B?ODdtakZkdUIvUFhleWlIZWRBSVFjOU0vWnFSUXgrVnI3NHdlTXZ0Q2NTUzNo?=
 =?utf-8?B?dEFQbk1mdmxoK256Q09TcllEdnVyVHFzZTBlcTF0UlJyMUxXQ1ZHeXNXd3Vt?=
 =?utf-8?B?RUpKRW8xMTBGZDZWZVIzVXlVcmhXeERGbkRQMG0vRzlHQ1RiTmwyTUxZeUds?=
 =?utf-8?B?L3VhK2pwN1NKR25nV01CK1BzYjkwTG03dFpPcDU4MXhjSDEyVW40TkYyYUhD?=
 =?utf-8?B?QUR3VnVqdEJaS3F2MUhVRVd6cFpRYmZNRWF4dDQvQ0ZiOFhtWDNHNkI4WTd4?=
 =?utf-8?B?VmdiM3pvSUoyc29WQ2E3NjhaVW5LZmhiQmI4YVdZaXdXTFQvaUY5WUtNdW5L?=
 =?utf-8?B?bkQ4Wml1TzAxcXFVaWVtSVVEZ25oZXVYQ3hxc2JMWkJGc3BqM2NzTWNSM1Vj?=
 =?utf-8?B?TUVpMlVqaXdyRHRGbTZ5bTFhdEplTjlnNFllR2dQbmdoMW43T3BMSVd5U2th?=
 =?utf-8?B?dk9oZlpwT0crWGtiU3NXeUVpSzZUU2NvWkFCY3hUNkpadTJ2VjFxdVlKQzBL?=
 =?utf-8?B?Vm45VCt0bkhaQ2JqWksreTlZeUMvTXFOZG5sL1NiVXhJMUVZdXpLZUhyQ2lv?=
 =?utf-8?B?QThxL1ZYODh5eXNMVWlwYzFwSk5FN2dKVzNLYll4c1psUDdHKzJISnhFRWRl?=
 =?utf-8?B?UjJpM25yeEI2dmkrQkpWQ1Zyd2hjZXhEcGhUNTN0ZFdmMmZKaUp1L0FzVUFw?=
 =?utf-8?B?aVFLenZTOVhMekZSajQ4TytSMjdSWlFZOS8vR2ozSFNHTWJLc3FMcmdyQVht?=
 =?utf-8?B?K014bXhzNzdYSHVxREJMWldITWxtdG9IWGJWdkh2blczRktWRTdDKy9vaWZR?=
 =?utf-8?B?dFBkNTRGL3p2YS9Bc2lQbWZRU2hQdzBuL0N0RHlOR1NvbkJXK2FON2k3MldI?=
 =?utf-8?B?SEloaGFjZVI3eEdqY2JjdDc5Qm9lL3k2TlVOV0NmdE14b0hlRDBZN1VId3FQ?=
 =?utf-8?B?UkRPdHIrdDVjQ3MwKzZLc0FnQ3RkOXcwNVhtQU9PMnY3YkxhbW5vS3pyNVhv?=
 =?utf-8?B?RjVQeUtzaUV1OHdJYllIMUN2MWNKcDdpUnNhUi9ad1FyS2VJdzRwcFpLaXR4?=
 =?utf-8?B?eFJSM0tjWkRPY0dQREJvZGl2RFZZbkxSZ3BMbDhYZlpVUVphMGN3MnZ0Nyti?=
 =?utf-8?B?dXpZR0lpN0l2TElOOE9vVTZBbys3RUpscENLbEFXOXhYWTMvcUszcUNRZXhp?=
 =?utf-8?B?eDRaWGVnSzlKazNkcENlSDZJS29sYXJPaGZhYlVsTWJIRHh3ZlJRTU4yWXZu?=
 =?utf-8?B?Z1RxaUFLM0Z2Tytmank5SEg4YTVubDJSMW1PSklmczNzRFpzcEU4dytzanFj?=
 =?utf-8?B?dkxmYjBLeGg3UytEYjc5by9KVHlDZk5DRDN5ek14dnpuZVlrdlErRFBsMVJR?=
 =?utf-8?B?bDBqNHNHM05uVUJaZktRYVYraGovRGpUVjRIRmx2U2lFMmJ4d3ViZzJWaWtT?=
 =?utf-8?B?Uk55Z3lTWjB1RHZ4Z0h1NXdtd3c1anEzYktNdGpLeGF0d1U0U2tVdHdubmla?=
 =?utf-8?B?MjY3YXhhdi95VS9YS0hFcDNsK25aMkd0Z2hFWUxsQ2hKUHdsNmk0aDVscUxj?=
 =?utf-8?B?Z01CK2dQMW8vZVMyR3ZlT1pEVVZaY0JqcWlWbEFVb0tLTDlQQ2VuVGpKMER1?=
 =?utf-8?B?Tm9CNm91emd2enZpUVdUMzVyQ21WY3VwUlBUUk1OK0twMjloMmpRa280L21B?=
 =?utf-8?B?cjdvYWNRUTlJNEFOOVdSUzBLanBEQmZrSlg5K0YvWWRsUWRpeTJYWmJuSUVF?=
 =?utf-8?B?Um5FRkdzNlpFNjZEQlpmTWkzcnFldVhJV0E3djM2NWp6S1Q5V2h4K2lSSVRV?=
 =?utf-8?B?V1BSSzM5SlZMUHA5dzRFdnhTbi9hUGZ0RFpveXd2aHp6RjJCL3dKM2NHZ2dZ?=
 =?utf-8?B?dXBkWWdTaHI2cmg1WW55OTZEWVlybTFWZ1lYM01SRTU1WGkzbnhES2Z0WHZo?=
 =?utf-8?B?NU9HcU11S3piUUJyYjNSU0xURUk1YU1TK2pDZGdQeExDQTBnRE9mUnI1ai9l?=
 =?utf-8?B?MVBjakFUK1Z0QUtmOWZ5S0d5R1ZyUC92SW0xY2xMR1BBMGg1aUYvM3k2VUJp?=
 =?utf-8?Q?hZCQ=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 13:25:12.6763 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd263be8-3766-476a-9746-08de28383c50
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7200
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
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

Subsequent patch will upgrade IORT revision to 5 to add support
for IORT RMR nodes.

Add the affected IORT blobs to allowed-diff list for bios-table
tests.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..3279638ad0 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,5 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/aarch64/virt/IORT",
+"tests/data/acpi/aarch64/virt/IORT.its_off",
+"tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy",
+"tests/data/acpi/aarch64/virt/IORT.smmuv3-dev",
-- 
2.43.0


