Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 869BBCF65D6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 10:47:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkK7w-0002EU-M6; Mon, 26 Jan 2026 05:47:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkK7M-0000vv-AZ; Mon, 26 Jan 2026 05:46:48 -0500
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkK7K-0005hu-Uz; Mon, 26 Jan 2026 05:46:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vh2XSjilzVZ8hbX1keQgt9Od3W8Lbycjsdv6ANvrxhyrvp38F99//eOWTZVtKGSyY0d1qnk7oNqTcWpso/O1j/rtyYH2IIKdqam5HK6XiWod7kLFfytrKb5dtf0hu5o37AtmzGvTpYT7AxBSXLq3+VSYG9bHHsCOoFboIxroJVWFM+fxcxnyL0XwnOdgad2JmYWzCkdzqSyVcPL/q4toJ+2Wve4Tq0hQv6/jGiGxT4QXfkCnDehlYrWHRgRm0ShggKjzzayRX0ayW14zHX4WgR2eug4/gNvYPn0SwP7DqGVaWbcC8PrzCV062i1245A2NZi6VWuXsiXAoW2YciHVhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9/z9vcnNHyTjYwUUCXKWpKjzDVknRD6okAP9TjBN/w=;
 b=nDFIg8dxn8GE6Bn4xWrPUEZSpxnlejz8L7HhtnA02ujVJchsaOV1blW66okdednTo/jyOsJy9gZHGOIXGRRE/JpHALwxSI7qpOIAH4BF7Bbqx6Ris/CFh6+0MH8MfdnwI5ue3LXpoyMOJx/dJu91OT3mhit4pOUt5hEEgiWPpWVvQcQopeg86zayJkWrN0CJQ8+xR5aTrL3qgjTo8AAGQCyz51skRkQq3OmHZU3D6gBUMY22om1o+NcFEOFhhZutCXUjQFwzgBDzJdmcLAdBrW4MHsc0ysYtSz2PI0g7+SvUK/RgjhEN4FHo1gEwmHXo/9FgnRxLTdTNej6tr3+Daw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9/z9vcnNHyTjYwUUCXKWpKjzDVknRD6okAP9TjBN/w=;
 b=lqz+DbRpU0XWkpwKVjlMwvJaZ0sGUiiMGZo8XE98NYkju572kOwqS/25RDyyfCWzH7mBCI0qOJcwQAyccY5/td6Zjfpim4GWKjQowaEIIk8iZERvytJ6syNrg2M3n2obKnBBKq6wnopHZiLo0FsdLuvs0eVmz7Ko+R6ukkJUHXHaYD+Ddw8IAV8VksIuAv/TmEvSoKS3Yx+/nNj2aogIb9bIt3zqlt7YqbfXSeEXfuObN3fuHyJtVV5Qe8GLgEQi3F7gHR19cbYzuNs4hlCHemdpeoHEfSp2CZkCNtbdSFnDMWuxwg0XgcC3gECNFtT3Y7y767C376VAZFAmgMpOxA==
Received: from SJ2PR07CA0002.namprd07.prod.outlook.com (2603:10b6:a03:505::25)
 by LV8PR12MB9153.namprd12.prod.outlook.com (2603:10b6:408:185::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Mon, 26 Jan
 2026 10:46:40 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:a03:505:cafe::25) by SJ2PR07CA0002.outlook.office365.com
 (2603:10b6:a03:505::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Mon,
 26 Jan 2026 10:46:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Mon, 26 Jan 2026 10:46:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:46:29 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:46:25 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v9 24/37] tests/qtest/bios-tables-test: Prepare for IORT
 revison upgrade
Date: Mon, 26 Jan 2026 10:43:21 +0000
Message-ID: <20260126104342.253965-25-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126104342.253965-1-skolothumtho@nvidia.com>
References: <20260126104342.253965-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|LV8PR12MB9153:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e2f3ea1-fffb-4618-f402-08de5cc83023
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|7416014|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YzlZTHJObnBCNXlQa1c4VXZKbTZ5T2hZNHIrNk9jT0E3T2VodExDTTBqT1Ju?=
 =?utf-8?B?c0N3S3o3STlJY1ZXeG80NkxBMVdpNmJqMHIxNXI1VmdsNktNeGtVa25wUW1M?=
 =?utf-8?B?d2xYSUhGZk50SDhEUGVhTEJRWmREWlJrUnRRSEJBMTNHVmo4TXpPWEI3c1E3?=
 =?utf-8?B?dUYxZXpTYnRobDNWaUU2UGRObFZkMW0wVDEweFFuQVVocUIycnBiTzA3QTl5?=
 =?utf-8?B?WG51WTVKbnlSU2ZPU3dZVDNNVm5jRHMxZk1hVHFiL0U2bGRVcUE1c2JWNkhF?=
 =?utf-8?B?Q1hjemtvWDdycjFFa2Q5ZFY2dUFTSUtpQTBHTDRUWDh6a3VNUWo5NEs3NEtI?=
 =?utf-8?B?YkZpRkJqNHZWUW9LbmxMWWwzTWtZRVR1VUhid3JMaUs2cUJpNFhBajZpanhp?=
 =?utf-8?B?N04zNStaNmNKRWJsQTR2VTZzL2tuSk8vUXNmVFRvOG83eTNJZjNKc3pQVElC?=
 =?utf-8?B?OXdobmNmVmgrdDBHdjRnMFBpZDFQNkFTZUVkZGlKRzJ6d3JFa2dqY1FTdjlm?=
 =?utf-8?B?cjZsbVljZnh5aE15Szdva2h4MWllTnVOR21QZDFvYllnY2duOEppbnQ5bWph?=
 =?utf-8?B?ZmFuQXpZLzVQWUswV29NbnZaSXpOS1gxTERRLzVaaGJ1WlM2bEFCWGdOQjRj?=
 =?utf-8?B?QzVjOEdBVEg4dzM4Ty9OamMvcU1lMmF4a3JQM014YUdlUWdaT2lDTEd5cjVF?=
 =?utf-8?B?UGlDSDJKWHhQa2FVajlLR3lqVWllVEIrbXVod0FhZ3poZFJid1ZRZ0ZGUFdj?=
 =?utf-8?B?ZWdML3lGdExlUC9zd3NuS0VybEhVN2xGNzFnRHBVSkZMSEtJTGpFYkEzWmlY?=
 =?utf-8?B?OWd6Nlp0MHZBNEJNV1ljanZvSmhtcWZJREV5QURMUm51bENMMXMzeVFvMTBo?=
 =?utf-8?B?UTh2ZGo0RjYzTW1VL1JuYjV3WVB5bkpsc2JVeVE0M2ZZNk41d3p5OTM1TnFm?=
 =?utf-8?B?bnNKOUYyRHRxOWNmUlBLUVdjK2J3dzUyNmtzV1ZDc0VJaElrbmVicDlGekpu?=
 =?utf-8?B?MEd2RlEzNUxYd0hoOHl5OC9PZ3BOUERrLzFZdUNwQUtEQkpRblgzRlRpVitM?=
 =?utf-8?B?RitxUTh0Tm5wUWpuOGllRGpDcFBFL1JFb0poN2lzeDY0UHVZa2ZUMnlzZ0l4?=
 =?utf-8?B?YU9GVUp3a2tIMGpqVkNSSG1rNGszL1prR3FEbHVuRVRHM3NkUkE3cXl2Vlkw?=
 =?utf-8?B?RUtJdUI0RWUyR2p6SnhyMHlxNWtHaDFGdVVaRVhUZFdnZVhQaWxMSjNNMG8z?=
 =?utf-8?B?Z3JkWTVvR3RIM1lCcXJUeTUwTjJLOENselFlaTNPS3pUVU42YTRHZ0lHRStz?=
 =?utf-8?B?Ulh0a0hxVGtWKytqT0xBSmJKOEZlWG96Rjc4WURTUDlnWkcwdmZuVmdtc3hN?=
 =?utf-8?B?NHlQODBVSWdhOVY5NWl1bk53aFRTQnVDRjBvQUJyWUF4TzVqeWhzUFhsYUsr?=
 =?utf-8?B?K0dBRWdvMkcyUFhjV2NNZUQwNERPT0MyRE02aStBRU41YjY5NHdvUC9sclZ5?=
 =?utf-8?B?ZWs2Y3pnbTA4alVycU9iODlJOVY3bE5QUWNSUjBQdTg3a2lCdEFtNEhGQTBU?=
 =?utf-8?B?SWxnMlFSNURmY1NRbWFnalR2b3g4blZPR2hDR1U5YXNGT09renBROURZS3Z4?=
 =?utf-8?B?bzY0MXdRaXNQQ05YeU0xTlZpMDFtWXloczhWNkthR3M1azZQamxYNENzU2lv?=
 =?utf-8?B?czZWUGdhcFNuUU1pdS9WWnFTMHhmLzdsaFZXSmgxTWZmYUlMQ3FzVFA5WjRr?=
 =?utf-8?B?SHpST1FLb29vQzNmVml6akpiNy9HRFhhOElKZithRzN5bFE0M05FOVFDVnZo?=
 =?utf-8?B?K1EybmFaU0lPSzNGUTZINFN4ZUlxK3IzdG45RjNpNjA0a2p5OTgydUdWYTgw?=
 =?utf-8?B?dXBOK0h6QWFGODhDaU9LVDV6Q0Y5YkRrSzRvaWQzZ1o4T2xFdnR1OUt1WlBW?=
 =?utf-8?B?Yit0YjFQRlRZaG9oU1ZvcVJmUnVGU0NOYm5veWd2RXpYQVhCcHFBS0owZHRa?=
 =?utf-8?B?V0NSTUlmMHJFVnhlZDlRWVNGdTNiMkFnZThnNzUxVnBMQkZxb0M3d2xzclJX?=
 =?utf-8?B?NXQrQU8xT3VXclJDYVdvWWpzWjcrdW52cWtvNi9iRzQ1YVVEWGdhUTFCYkZS?=
 =?utf-8?B?aEN0K1VEOElua0o5RW1ZUkIwcmlLSzlNbXEvNjRnMkMyK2FDZHJFSEp4RDQ0?=
 =?utf-8?B?MUxGdUVPWVlHN1J1Z2NmcStkUGg5SEVPVEwvSUxnakdNUHZ6QmM1NnhqT0JZ?=
 =?utf-8?B?TnZqeGhrdndKNFZULzNMVVVJY3lRPT0=?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 10:46:40.3766 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e2f3ea1-fffb-4618-f402-08de5cc83023
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9153
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Subsequent patch will upgrade IORT revision to 5 to add support
for IORT RMR nodes.

Add the affected IORT blobs to allowed-diff list for bios-table
tests.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
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


