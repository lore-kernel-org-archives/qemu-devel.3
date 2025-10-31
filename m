Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 824F3CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 11:03:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEmmZ-0006Zt-LA; Fri, 31 Oct 2025 06:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmmD-0004rI-0e; Fri, 31 Oct 2025 06:54:39 -0400
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmm8-00031e-16; Fri, 31 Oct 2025 06:54:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TAzC8k4xlypSgtT0uAPxpklt6cTq1hrCUrO6LzGtGiGchs3FpSfOnvRMixWHEeRh0mDvfNnRBi7EtOWHIv3gi9pqqeEawXXSYEFYVy20FtxejQoFoMxOROwYNevJ14lWi3it0QIBkWLrr480BVzzUxb20T/gvNY3ahhu13NfUMU0Iq8sqjfmG1EBCFiKKGQ/CyQa7YQc0EpI1SSydUFTF9OxglkDAsOGDEGRuJ+GhRreRLHCA366NY7cqUQOz9ORDvJZA97fYC9MSXCiCjxB03Tf71yBs8XGrNZI7T45bPaBepL58DtGH3wOhnK1joZji35rx7voX02Ug50qSHl/cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NixQd3gPWQmXET4tY+IAmx69jImRanwGlNLfCy8YfWE=;
 b=fTYUkbCad/acm1bQNuWkN5qqySHUpIPjTOqBIVrQ7+3a4Dz3m4QRt8Du893W7Eq6TQSv6ot1x3zLnx+JgQ7Ea0Dbg5thS9M+0saMsS80S6ugM6bKZ/aSixCB+z2SJvtcbKu4pGJMKtXo5wcNivcTNvzoz8NhndQ68Pn9zVWBW9y5OyhpUcENPGa8lFvWU+h0sthPNpGs475xu6VPrfMQ8fdL9ogzEHXJyxBxafo0ReR3sKkmyEaxexp1QNNEHxKA5OZaijq9Et8cqfdsvXxX7RCD9YRUgsOeKHFyrwBtl3UeQZBWghIII+l81IasiotoZkH06OA7l/8+1aZfRY464w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NixQd3gPWQmXET4tY+IAmx69jImRanwGlNLfCy8YfWE=;
 b=tENqzV1zg0Wr26Xa+okU5hygvoKaqvjiz11HA/AytO19Gi0TWCRpmC7DUXFXYWi3z+pLbd56oX3SqowwS6HXUpuF9fzfszjHCa9pkUzobLBkv7BkVdRd34PxkVByLgaEKcpMg1d+NnJH+l9iiykCmfQr2sW3ujCouWndZBEpVqVPHcAJirCsvMCvKoJycO1rD2mv2ftkO1V7YlWlj4J91yhAIBCfhtLIjJj4YO4u6m3kSFEHOVG5SjFNnz0Cuo+P48EnI+tTlCy5KYCefXfw82hADw+NIYz20cxmxS06Sxzm3y3hkmhlcxqGrx+oUTpfTbU/utBmYnkqWn4hyV1vXQ==
Received: from BLAPR03CA0158.namprd03.prod.outlook.com (2603:10b6:208:32f::24)
 by MN0PR12MB5833.namprd12.prod.outlook.com (2603:10b6:208:378::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 10:54:23 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:32f:cafe::e1) by BLAPR03CA0158.outlook.office365.com
 (2603:10b6:208:32f::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 10:54:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 10:54:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 03:54:15 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 03:54:11 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v5 22/32] tests/qtest/bios-tables-test: Prepare for IORT
 revison upgrade
Date: Fri, 31 Oct 2025 10:49:55 +0000
Message-ID: <20251031105005.24618-23-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031105005.24618-1-skolothumtho@nvidia.com>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|MN0PR12MB5833:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a3d3b3e-e5c4-479e-a72d-08de186bda0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z2p1TXZUQlhldHpxakZ6aTdXYjVNbTZoSU1iVXE5R2dkWm9BbHpJZEFPOEZV?=
 =?utf-8?B?dXpaK1VlMDh1eUZWK2xOdStSVE9MOEgwemJ3SnJKMEQxNmN1ZTJob0dOaVlN?=
 =?utf-8?B?eUg3ZDROQng2NUVQUGQxTVdIeVd3dzhHdHF2dlczSldoTnF5VldvK09iNUsy?=
 =?utf-8?B?RXJQRTVTM2R5TS9EK2JHZlZ0UjBLbC9WbkpaWFJIb3hJRis3QXJWQ3NiUGph?=
 =?utf-8?B?Y3FuUkRqTnVQMVNnRmFmVUdpVUpRS1BFbFlHL0tCWGJZNXZPQ2xacVZjbkxu?=
 =?utf-8?B?cUNabS9FQldwZjBXMEp2eDFrenRYMHJka3RQVEc2OEM5b3lXdFE2a0hoZzNJ?=
 =?utf-8?B?S2VyWVBGTGFsMzg2dVZvOG90and6bVFmeVc3UnA4ZWtFUk9rTkY5RUNrd1hH?=
 =?utf-8?B?QTRwS0NYQTlMOEIrd0M4andrSVpTQU1FMW1XOHpYTVY4b2lSQjd1dzMrczc4?=
 =?utf-8?B?UDZab3pIbVpQWTFTdHRLNUV6czdIU3pKOFNMVlpSeC9RNS9YRjBwd0R0Ry9t?=
 =?utf-8?B?Wk5hL2c2L1FGKzVWdWU2eVd3U2I4Zk5iOG9qT1ZuaGRMc3RTOHpIS0EvMVJS?=
 =?utf-8?B?NC95WjBlYmZCT1pyNkJtWVYxMVpaejJmc0Q1cHptWmp1eVdvcXR6czU3em5s?=
 =?utf-8?B?V010NktJV0NMMWswUGFUU1ZqVzNPSkUvdzBtQjkvUDhqTUdWWlNFR0o2akpT?=
 =?utf-8?B?TXVIWFFxc0w1cjlUcGFHZlcrYmhjZWQ5RkJVOTYwaVNVRURrNE5TREdMZHhU?=
 =?utf-8?B?R1NydnA1bTF2Tzl2aFRwaERaeUN1UWltMnNvRWhPbExaQ0kzMllONTdkK0Z3?=
 =?utf-8?B?bkZpaXNrZi9RVTk2SVgvOXZUSXgvejNuaWRudG8zS2tKWTJ3ei9UV1Y1QzBy?=
 =?utf-8?B?aDQrb0E3RmJDc2F6MU0yY21iZmVBb1dJdDNjTXI0eHpKai82RjBPRDZ0c2t6?=
 =?utf-8?B?Z1pvWm5KanBtWUFMT2NJMktjR3g3NzdsRi8rYzN5aEY3cEIvSmtDbGIxcURV?=
 =?utf-8?B?dHpWUHNIUGxDVStMSUkxZ09mcmJLMm5qRlIzZkJSc2NzT0RLZEVDYW5saitW?=
 =?utf-8?B?OTNVZ0lrRE9oeVZnYUllRTNZMUloNlg5L1RYMy9vL0V6cW95TjlZY3NCeWJr?=
 =?utf-8?B?Z1NQV0pjRTFkcmlMWk5zZitmVjdtcjl0Y2xORmZPaFpMOVBaNW90TjFSc3RS?=
 =?utf-8?B?VFN4a1B2WEg1UXYxWjRRZUtwdDFsQmlkemJRM1Bxa1NhamR0SW5XTGFMOVdV?=
 =?utf-8?B?WFFPVG1oQ3pPc3VRS1doR05VWkNzUXB0M1hVWXl6TEJrV1dyaUJaQXczQ2tJ?=
 =?utf-8?B?clRxYVdOeFZUVXNzVzAyZFd1b3hiSFRIWU1WYTVUb2pzamMxeFdJNGdpZTlO?=
 =?utf-8?B?YmlVRDkrS1RyclNRdlA1dFp2NmhLVnFneDg2Rlh6KytRQkdaUkQvcENiWC9z?=
 =?utf-8?B?Qk85eHdXMEszeGdsL0JMekVQTzZCY2hTL2dDR0RMWFJIeUIxSmhWUzdoU2kv?=
 =?utf-8?B?cW5xV3JFUEc1MGZtTXpEdFdOTmNtclY3TUlveWsraXh2bjRiUUI0TCtLdkcy?=
 =?utf-8?B?Y3FQRDJkZHZKVXhhVUV0dzBJLy93VnM2WnU2SkFqaXlUV3ZLdWVWRUtCSGpu?=
 =?utf-8?B?emZMaUd0am5zY0d5cWtkRXdyOXgzdnFRTWcvenpLSzRUVng0bExvZzJaZG5B?=
 =?utf-8?B?bkg3STYwT2wzTEhwOVhYaEQrUUtvaHN3b09HN1NXNHo0NHpTcWczZERZRlRz?=
 =?utf-8?B?YXhZZUtPbnNGUzJ2SnZiVlltR0lEZ1RCU3JVQ2NJak9MS3BTQ2FuTnQrWjVk?=
 =?utf-8?B?SWo2Y1ZkWmlYcTA4ZGQ0SThsMWxLNlhjSGZqd2wySjIwTW9yMEMrZUhaTXNm?=
 =?utf-8?B?VUQwWFhocFBKV2I5dmZrQ1lrN2k2M0I0MGc2OWpwQTltbk0yM28zRllZdFJF?=
 =?utf-8?B?RW81bkx3ZmNvZElVZUFoNDlvdWx1T0FIRTZtK0Y4NEN6WnpnV0loS2JhTjRL?=
 =?utf-8?B?NXBjb2NwS3BaQUgwcGRrV2R1WkpLSnppejRJSUdnTFcyV3llUEpIS1l4cE1n?=
 =?utf-8?B?SUM3R0thOGtlNksxbnRpbXN2aTduRFZwV0t5UmxoT2M5V3hVM2VzYUhZY2x1?=
 =?utf-8?Q?vXos=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 10:54:23.0260 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a3d3b3e-e5c4-479e-a72d-08de186bda0c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5833
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


