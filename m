Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC544CD98C7
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 01:32:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXqkF-0000Y4-2c; Thu, 11 Jun 2026 21:31:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wXqkD-0000Xs-As; Thu, 11 Jun 2026 21:31:37 -0400
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wXqkC-00075z-3F; Thu, 11 Jun 2026 21:31:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gUU6s0IicMXUiq85qc5Pb6Sc11gz0BnbA2HxGriluG3WsOHh3cc9ZRP7vzNFMWFR6WhrWrSjm8C4VRWtGaUzFW+UW+hIYg2t3mXzF5t5ItrK8tZpvCyXYkoj5Z9k2Z2+2MPLv+G0iDAMdLB0wlszmbC1uEvehDYmAD3QqJZSfWLdBwQE7VQSpr5O3txBPgB7Iq8sOwXMOkVue8SOdsmwGeIuFJM403mn1F4gIsb9OL9sCazimlAA+tGubb4s8rKuVhUUkW0d5Vc2I29xROobIOGH7dQJEE9AxvE1GkKs1W602xMT/NKZRRk9uDjeZXjhNwTqbMj/euMpckcynmhkAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RIELZ0Jk2r2z2qLlNFsqo4QLWu7OwEVhxwNPeTkt94Q=;
 b=GHTRuo3WwxvO8ke4G8vw2G3y8LhnD6FaCkPGB/TTNeQfevEgoRKiSQmXTtwRNvxyX6nB7MYk2Fdw0+QZpsQmGastJA/HsPMcl+ONQW9wqaW5Y2rZtM8xfC1e8/65u1qSQWJOUeSvyV2W+Az+guDl9uPmVXHbRZ+lC8Tg+rmXOP52AlFZefIXgmwLfkVYti0/bVPdzc8+ys07Hqs39RDfP2uUzRR8/LflTsh5YB/0QUI1wXQzcHfRmIUva/YEYQ670OZ7/l2sBrl9lofGOWWHDVKKUkTKOxwAsJ+d7pbGLACrbbFNRMq2Dnl6ijxxMHYKuqX2N62xPcZIx6xo5IYVZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RIELZ0Jk2r2z2qLlNFsqo4QLWu7OwEVhxwNPeTkt94Q=;
 b=CtRYz9cobiU3JM0IAmTjAl9wOSvmaxmM0j9dzH3WOqrkPfV304PBTGd/kEXRXvYgmFfdKNL26ik5g7SpV4z9MFu5lyn+kX8ao5iXmuI2O0dpxocEMvCiw/8MAy936l3G8ZXL2cRDH1H0Dc1J7GYsMHiVTGBA7O6bG3RgxhYpEPfvH+Dunt4rx9yhA8ztBCmI2GXKAgWVaAPVec/AN98R5HSN0hCVuii+wESzcTk/WVhSYTzCb3qCu8IPbOn0XsACjaVq6hbySOpCHCd89dAJGdm2Q24j+zBfGzjtGl02gkS2wNvK2191iMWVRezCB7Z6IzqsSV7+BFO0I2m5E1AVSw==
Received: from BLAPR03CA0151.namprd03.prod.outlook.com (2603:10b6:208:32f::15)
 by IA0PR12MB7749.namprd12.prod.outlook.com (2603:10b6:208:432::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 01:31:27 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:208:32f:cafe::39) by BLAPR03CA0151.outlook.office365.com
 (2603:10b6:208:32f::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.13 via Frontend Transport; Fri,
 12 Jun 2026 01:31:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Fri, 12 Jun 2026 01:31:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 11 Jun
 2026 18:31:06 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 11 Jun
 2026 18:31:06 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 11 Jun 2026 18:31:04 -0700
Date: Thu, 11 Jun 2026 18:31:05 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <clg@redhat.com>, <alex@shazbot.org>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>, 
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>
Subject: Re: [PATCH v7 30/31] hw/arm/tegra241-cmdqv: Document the CMDQV
 design and lifecycle
Message-ID: <aithWWFWlkCbTw5W@nvidia.com>
References: <20260609112552.378999-1-skolothumtho@nvidia.com>
 <20260609112552.378999-31-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260609112552.378999-31-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|IA0PR12MB7749:EE_
X-MS-Office365-Filtering-Correlation-Id: 40897b9f-2441-4736-acce-08dec82252ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1WRCAZRLdudxqobd4zE61QeegbWykKAyI0rVEnZPPW/AOg7W1Ir4i0fAlxX7WUbF33ijLZWSmz3wyRMUwZvfkni9GW0tNXuBtOGFJoxa+Wt+hy9PU6MsPF8IaMKqwPW8JmoubXTUX6F85hc+/kjUaggdziAlBQ9z5+kAcCo9hi5pvfQqnvTAw2RNVBMCEjVRvmAr9IOE4DmL8ltuMxUcj1Ft0UqBUaHZREBR64mNLDILWhIi90P5xTkpk6aMHoDA2HqsM02rFJwS+UUgBnwsB5x0u0mfcJdgnZ0YfWapiQcR/AuPMkqi2M3R4Jd65jClZj8HxyLqpMjDTbHJ/RnYIL+yd+q8eKNm9jmK7l7M8gJc94IUcqUDimO+f5CqGRYDMKg6rS7+AUe5PzfcPpsnxp3hz+uEUbvSDN6H3zCvEa92LLanJPtrZrLNo5XdlnE+ZMrDud3LE3os3iVcjUBmbtYSZvh1FVFhUHpiRVFhvotbYVUqeiUj96GpoCoAyQzkvBQT4E7vKEWe4Zga/oD04W1t70bi/5gWK/64VMAeT7IpWUYxqMPAJjgamm9doIraiEjJgZTJcFuhE8JdrbAabjyF3/jTLAqsxqHxwsleggzj9vFlcwwAKwZa7iO4H9cqw4KaLqr4QKZvT6MPsTX197QQ1QEEZCkZ+vl/3HA7D5mbDxyVQ239ZsTEZnMXlIyRHzYrrn2gC0Nn9v/cuo9rzbKF0OS11ImI094dPN6Rzgw=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lRT0A+O/MbbseEj8sbzqxvdu7b045JNaMjEzT58wY98ZpnEfEoJbhZucxe0+gwcgoGSJy0AWXifghu4xg0BIFhrDgEXOm+OnQPcHbIuUj+b8SL/L5Hz05Gj6B3mZy/wRa1ta8LcdvfyMrGngKzoDyoZ7OClRfj01e6rjHNLBXaKAI7Rvva0B9cPqUXCjahJEvF2/n0ZFxiKDJtDQ3nxi2vbPVAqgva0lUjNcdYNMmYdi7/mhahH7NnYwaEWgiLaqkJEeYuxM/HRl0m9s5VlBfJ6eotgXsiKX+sc33XQfubyo1XL7eQII/ExLShDB5xhAtESoIfRNvB/WlKzx9QjLH8L+aRl9EF1U8GnzfoC0BDWpxwNJYJ+02QRwpTVwfZJfT9OLmTBkbrdHNgpZkf20y4yEsulNA/fAstP1QsBMZmP2aVUteLOWApgPpaHgs5fn
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 01:31:27.2719 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40897b9f-2441-4736-acce-08dec82252ab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7749
Received-SPF: permerror client-ip=2a01:111:f403:c110::3;
 envelope-from=nicolinc@nvidia.com;
 helo=BN8PR05CU002.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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

On Tue, Jun 09, 2026 at 12:25:51PM +0100, Shameer Kolothum wrote:
> Add an overview describing the Tegra241 CMDQV passthrough model, MMIO
> layout, guest-driven lifecycle, and per-VM isolation.
> 
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

