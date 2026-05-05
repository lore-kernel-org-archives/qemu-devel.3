Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A19CD342F
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 08:17:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKAxE-0002Wg-O0; Tue, 05 May 2026 04:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wKAwj-0001x0-7E
 for qemu-devel@nongnu.org; Tue, 05 May 2026 04:16:09 -0400
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wKAwg-0006ls-0U
 for qemu-devel@nongnu.org; Tue, 05 May 2026 04:16:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jriw3Fb1VqHbiCpkBuis26dPXJ0AK+T57rBu8Fx/KPvzuJX6vJ7bwf4py0g7bCynS/suzDy7kxKQMv0Jm8lJLTsLT9pSM9h48Ec2zw6r4yUiDFwyb9GXGLto+caIZAVLRS5Z4zGLPQ46D2Ke2QJ+mYVmy39uDk2g78KXYGClwrC8x1A2xHRwez2tY82Ndz8XeMukDmEUHq9x8BkVS8o2wdx7yFPRrw6MSA6VhhSmQve2wEF92H2rLqkijtWZ89ALA7VvTWFRbnJZ/cW9Hn1tdSUhMDoWLDEcLh0z4aMnV3xFLpj3cRTI/2TK7Ic0T125lo16bsMbe+QADoZX+ake6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VfLHfa/0IBH0sDn9RlXIMN08l/g9FZnssBPMyKOxZOk=;
 b=SOL1AfVvYnYaUXiCJMllYRiE4y/KJOp0OLp+0UwfMznIa4mBZC6I/NCeMPbZZQgPMlEcc0iX2qyjPDn9TQ5PfgfkM83u+ji6FbdX35JzbyK6hOd3TG07aEWK4Ytlc1qhSRca1CgC5TJ0h8lwbPMGQJOrOPNTArNbgmecJjWoKcpAkVQm5xrEI3vJ35wRzS6wwXm4pUfIMDNX1NtT9gG7cPuK7UGdiWPxR88emXfNKd+VZ+lrWkBKgTlAJI7xGs2+9J9q54YEkkE9xUBpjPh/pxmwaeQ2djeCRM0pfwYqSdrGy5Ws7s52+PZStM9vOH+zVJsUSvkee6FjGZlMH87/3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfLHfa/0IBH0sDn9RlXIMN08l/g9FZnssBPMyKOxZOk=;
 b=uk2CU7uFinTlrQzknhIiEuFe5BbEfTbaAF5yoOXpREUuKKi80fAE0ZjxxBp9q60eJQM5C7S3/jJ0r8lI3cf4REUzdP2PvYmv8A2zbC23MEvtQ8CBpE8YuOUuQRIRpq0d8Mg4bZmGhNhB6BLs7TPA3kkCactHSGkgo+3BShcCKyseTm9+32sEkqys+FwaMYEHoNAUNs1KAV4Bu09MVBaaMgmYXBL3jlmSmy/4ojDMZ65DpbB89bYkyJP1+nP+jN7iqZUcGACKcXPmhU2nTdGTxfASC3WeeXd3hvX4BGyvVMOMcyyAu0CZ+h8KNpO6RH9LoDscSVk6qKNPXQJU4KhhZg==
Received: from SJ0PR03CA0237.namprd03.prod.outlook.com (2603:10b6:a03:39f::32)
 by LV5PR12MB9754.namprd12.prod.outlook.com (2603:10b6:408:305::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 08:15:50 +0000
Received: from SJ1PEPF000023DA.namprd21.prod.outlook.com
 (2603:10b6:a03:39f:cafe::de) by SJ0PR03CA0237.outlook.office365.com
 (2603:10b6:a03:39f::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.27 via Frontend Transport; Tue,
 5 May 2026 08:15:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023DA.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.1 via Frontend Transport; Tue, 5 May 2026 08:15:49 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 01:15:25 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 01:15:24 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 5 May
 2026 01:15:21 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex@shazbot.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?=
 <clg@redhat.com>, Peter Xu <peterx@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Zhao Liu
 <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck
 <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Maor Gottlieb
 <maorg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH 14/14] migration: Enable new switchover-ack
Date: Tue, 5 May 2026 11:14:23 +0300
Message-ID: <20260505081423.28326-15-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20260505081423.28326-1-avihaih@nvidia.com>
References: <20260505081423.28326-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023DA:EE_|LV5PR12MB9754:EE_
X-MS-Office365-Filtering-Correlation-Id: c5d75481-df3d-429b-6afb-08deaa7e843e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|7416014|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 8RJnunfV+fkHAGKP0omHwmujfXNZT0GVCvB9S7xzXHer9f7tOWxMMf/AsIi9NU0WSNwf7raqmsBlc8TimZfrXb89ZRe0pRsAfwVyh8cbHTCMuzuvJt2aWTYkh26TGRXr8jPeQCqiJsolto/AFZTBgjwEJyuukbf8MAI4HzpeNYIP/LxffSsARDkhsGPEcKIoarCzzLtnRQVce309svOzr3EsF7nRs9J6QGIfBO/djVS+zwOZVBN4lzzpW3HhD3ORUTjaHo9VTQ6D7PvzDBNZDBJTxLi8Zkbq2Urpk2HAhYtQALvpSTdVIzM1n9Wx6cjCAKGPmE8F5XStbqpj9IzB2rAnheBP+WNL0vBKWNQTo3tZ9HJ2nM3HXxaeO90JHQ1sHg7UMlNNJLersO1qEFLWVLtHNoNKk52gjDJkN97pLDtdFqOjPhG/DFxtQlPDwaNW8nH7S9dFuKsS421igCU3tbOr77ggP3H8AVdGfrNn0O7luLhOIvNwpqbT9AsRwK5rmWAq5arOgoYJ5/EvK5cwKxSAjIMAPodmDlyh/peuPoNBs6GPKhbdKNL9wOg9BOVOd/zB9SaKGjaPj8NAxOYWqDU99WGRbGC6+Z6MrmIeyaLR9ZD1uPBjSV0vINNWYLbq7UIhgEMCtt++apH+48RGuYjQEsWOnjZ/V1S/9F5Dj2R6NuO6jPu5JwgNwXfrQ2YPLlPIs3e7wXCYq6bK5PQiE5g1pkxR9nToNvZFjlnhhaY=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6JOkD8aEcV8qQQlj16ZzQiNdIG6Q3LRoilCsIs6zSU+dT1/vG1VsjSQUn0lDY3V7Qky/QEErODlcR0Q6Vec/nqzfFhv94krKrBCEMgHA66WRVKHNnBtX3iOQXy3B6CWyNU67367EBTLCVEQ85XfPEMMTMFF5oE5pwkTFp+KanQ+wryytdbcrxILvHGNy9J+26Qgv2cKYlb/z7v00c7hkOBHBJHuEtG8L3j4IfdLwN7I/T/B9pOQXNfPX2j+20hvRwTSbplZUASFjRfpBm0bIRjUE9Ovcimp6NGRiSajNmG+vTfwatYm+VFmmcE8xU0O0VcfqVczOYMrn7wdXmTtImy9ZEBvB0KTpV8zLDBWz4DzKRh1kARBtpBlAgiTvZsEDQD0EwjJiCPUJI8tcmobZ4jIQximGFLUISBsDHghBA9+j6Caxh/eE+Tuy9r/6sSnY
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 08:15:49.3134 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5d75481-df3d-429b-6afb-08deaa7e843e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9754
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=avihaih@nvidia.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
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

Now that VFIO has implemented new switchover-ack, enable it.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 migration/options.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index 44327c588f..91571f9d30 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -108,9 +108,8 @@ const Property migration_properties[] = {
                      preempt_pre_7_2, false),
     DEFINE_PROP_BOOL("multifd-clean-tls-termination", MigrationState,
                      multifd_clean_tls_termination, true),
-    /* Use legacy until VFIO implements new switchover-ack */
     DEFINE_PROP_BOOL("switchover-ack-legacy", MigrationState,
-                     switchover_ack_legacy, true),
+                     switchover_ack_legacy, false),
 
     /* Migration parameters */
     DEFINE_PROP_UINT8("x-throttle-trigger-threshold", MigrationState,
-- 
2.40.1


