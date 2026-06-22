Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF51CDB46B
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 10:16:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbbhX-0006o6-C2; Mon, 22 Jun 2026 06:16:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wbbhE-0006b7-WE
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 06:16:07 -0400
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wbbhD-00070D-Fy
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 06:16:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HlFXXEgB011mWDtcbo7Y4oh6EgDWEI/rcb6pI9bIN7lPxPy1FD28zB/56Cp2K8V3/sTyyK2nyIjdShvWnHX+fY1I6JTo7jKuvlRX3UaZd2j+JecLCKb0SimYVPqZoqvF5d6zsZ9Y/MNx7idWRl5WLdCDzLar6JGDZLQF08DOHsvXGyDCxT1e4vmtufOOLLgqMTiAfAzKcfK/4fPP8PqMF/fLz8utBAb+eSBJ5X68jSR905wIoPpvo30ZOQw6lsU3gvwU8u7MwcWMGc+Oe8HatRxnZU1Eqo7QJbTtUgLnNz3/eMIKwA6nklB3CDOpQfq0YNhXB8WvQFzCwOmoZB9kqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W4/LSmLTVX8j8d6DYTwwPr+4HBd2/OjwsAn6w0fhEqA=;
 b=mzOsozGrJ+OIa12u+i53ULZCcjN5BpdZ+q8Zr7SM15tYxce2ihyC4tPrlLUPJUCqmUypZJRnMuI7FQkoG9QTCd15oJ1SjtD5sEbZWxvleQ0DmxcgzrYCdqdqNojUbvJJh5U/0GeqtIOcu0s9quQSCZFZNCuWSgx5PfZApIdSAyG3SiAfKRhFWF2+ClYUsY2/uqXuA5ML7p0jITSxG/DRShFK7hHijmRy2iK+3TgQ2PxvTlDJfe1jTFg0OMdr5+5+G06zDmPv3IL+WBEJzEJG/sOJn5VnYYMnp/B3yeHQh76HlWfcxWv2mUwUQKBo2qMYnJOhUm5kJokIDwxGLPDDXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4/LSmLTVX8j8d6DYTwwPr+4HBd2/OjwsAn6w0fhEqA=;
 b=lsa+4VCLWTwR6uMx93Hy1c3E1Mm2vgZYYwTIhfcJilVm7PhGmsairWxgJ0nEQdq+gmaV0A5rwa5usp5BjqcyZAMQU19Kkp6I5vhvq/P9yoxjdamZZQKQLEDbIxb7j3fDh2JPRCE3OBhKgCMwmfphgoR1eZL8i9gvZHhdCHCO8cnczPFgjdp+dBOyPLFjz2EzOZlIPzHnJw5gWVSZ499fzPiD70oqqYLaG1l/+Id2rqiO4rt2mXSjErt0/3MlOaMZTteDVhb+iYsOhl/ZxQFoJAP+sIt9jEgMDqEIXVqS6J/B+mm9l0z0XgTOPPzn1ZqeEaQcIXYQcU6V1eo2poDK7Q==
Received: from BL1PR13CA0175.namprd13.prod.outlook.com (2603:10b6:208:2bd::30)
 by CH3PR12MB9249.namprd12.prod.outlook.com (2603:10b6:610:1bc::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 10:15:54 +0000
Received: from BL02EPF0002992D.namprd02.prod.outlook.com
 (2603:10b6:208:2bd:cafe::67) by BL1PR13CA0175.outlook.office365.com
 (2603:10b6:208:2bd::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.14 via Frontend Transport; Mon,
 22 Jun 2026 10:15:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0002992D.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 10:15:53 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Jun
 2026 03:15:35 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Jun
 2026 03:15:34 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 22
 Jun 2026 03:15:29 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex@shazbot.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?=
 <clg@redhat.com>, Peter Xu <peterx@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>, Zhao Liu
 <zhao1.liu@intel.com>, Halil Pasic <pasic@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, Jason Herne
 <jjherne@linux.ibm.com>, Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 "Cornelia Huck" <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Vladimir Sementsov-Ogievskiy" <vsementsov@yandex-team.ru>, John Snow
 <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>, Maor Gottlieb
 <maorg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH v4 14/14] migration: Enable new switchover-ack
Date: Mon, 22 Jun 2026 13:12:14 +0300
Message-ID: <20260622101214.25770-15-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20260622101214.25770-1-avihaih@nvidia.com>
References: <20260622101214.25770-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992D:EE_|CH3PR12MB9249:EE_
X-MS-Office365-Filtering-Correlation-Id: f0eb40b0-6f18-4de3-9a64-08ded0473e4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|23010399003|7416014|376014|22082099003|18002099003|6133799003|11063799006|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info: 1WtwgiYYA7aqmKTjd0DHT/T450fwkPmU9mBC9P4WZJkBsLyzEQgytGYu7tHA4ldY+sTuoRoWIP6bh76K+AxBN4jatpbJWuxK6NPefWM6adESVHY2KtHdk4yNcvACx6S+0+HTohjY84B+iKdVO0euqK9Xa89i5yRPloQlgdt5Z7VMHj9Hc+Z5xXttRgOxdxvLX+opTtghW43pK3XYdPIjJMcIYtmDW8XSPMfDRkrBNDMLzSwCEo65+Bl1BU6MQPQ7F2hDcYEWcYvxhLuv5FoGB0Y7uXbGmEk3+nlogubWVgpQT4FbvXxCx/BbhWl24ifIdVn9yKuJdtKeKtKZzrBI+7EMvhR2wzxFTZqbbEexjB6jcWeZK4Rvfvuf9FZiomtCk21AE8Avk5no1D+C6S+tCNj2hOPJwhKKFCEKB0jhZScVF4ijGVm9R/lxlV64/Y9aohBE6GXfljdtdwg+yjV2768fBExkBDmCe7uQVkRekVnVbk5mxifsZJTp0bWhKiqLzZWCjZtSar4ros8UBxAGllhMehLe6Vl1Hl40Ze6aKhHfuSvFezGNatArp45ggonCr/TuE0HMOIbsyUEcAa/M1sWSgXnVR5tLrOV8JLDM0rZlF6MBBBxq9ilNSdcXEwyuFGyzGn0Uu7eTo1DzFZJOeWQcfuN4jkEv5NOMY9a2/Z5p3A4iCiydYMqU0UiONqRiUI09f2D39Kueou6MRMssLQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(7416014)(376014)(22082099003)(18002099003)(6133799003)(11063799006)(3023799007)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tH8WbFgHis8XB74siZ0EawWsxDdHRXwIowbI/mwJYJ/9jOSLVyLwwLO1+Swg9dgxYjgsIMGzBd2oA4YFwWvdTY6zqUX5s/Ib4hl0aASH5RhTdbagCbQ62TVg0cXJ76jA+kcqfiYJNDthf66jlwiRHP3QRCbzAy8d/YO3HuFbI2raHd5jtm8A/A56gAWidrp/52IpKSBTz1/hMgOSVs/o7gj3LoeRW4o6TpvCzthnMWcYM0Bz+an+3vmnHloAN9XoTlpn5njEv5GUwHBHMZ2BVvpgD8LF0oj6mHXvolqJskU1JoaT6LGFqvJNmxvTQKI2vxnoZ7qHnfoAlQqc95cba7PMkB3ciIsXVtTks5L8KgNlSAtpRjMB0yIsLzBJ1wNCLXwsVGEQ3XiFVG8wLAikgmkx6yOL0lNW2uePiET0H3jO75oWRCnDS0z2rqh9hZYC
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 10:15:53.7928 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0eb40b0-6f18-4de3-9a64-08ded0473e4e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9249
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=avihaih@nvidia.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Now that VFIO has implemented new switchover-ack, enable it for new
machines and keep legacy behavior for old machines.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 hw/core/machine.c   | 1 +
 migration/options.c | 3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 9a10e45aab..a4af779357 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -48,6 +48,7 @@ GlobalProperty hw_compat_11_0[] = {
     { TYPE_ARM_SMMUV3, "ril", "on" },
     { TYPE_ARM_SMMUV3, "ssidsize", "0" },
     { TYPE_ARM_SMMUV3, "oas", "44" },
+    { "migration", "switchover-ack-legacy", "on" },
 };
 const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);
 
diff --git a/migration/options.c b/migration/options.c
index 4c9b25372e..dfce19405d 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -110,9 +110,8 @@ const Property migration_properties[] = {
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


