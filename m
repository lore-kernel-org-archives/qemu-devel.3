Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B5F9C5478C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 10:54:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh5xP-0003Bl-EU; Mon, 04 Mar 2024 05:54:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rh5xN-0003AF-BJ
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 05:54:05 -0500
Received: from mail-mw2nam12on20601.outbound.protection.outlook.com
 ([2a01:111:f403:200a::601]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rh5xI-0005sf-Lg
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 05:54:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNV4F+TRjXBXQ9Dj9Xk2XHVyQEeo6vwiJfuHCz7pgwj/NHB8l9N0bIT8zXvv5DUumu74+RhsBu3cbPUmvu57p0MTuSNCb53kUJxFjFOdfL7Iz/DX9AOq2dKLPjkvY6+oXjuav1mOaS83zlYTwvp4CAtrISYiVMQdeqakcqpm80YT8g+xj77YNkX15Uxt1R0GlEFv0sCrhyk6vIUHxRQ2Q1rQD4bxLEnbrc6zSKkbCDM2W7bPYIFsAG4Cla43r2ciy9FYO7aLp74ZeNU1Rf1WtWceJraQBTMK3frB7DItucqLzwGF46mdAqncQykK6F1Q05TQSI58hVtno8ADttT0Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETxPJGVeYLSq2+Wueh4B7xasL2q50/Vn/U19q+OiWRE=;
 b=aCIzW/JoZzGfpZ3c/kuBZCmGNIpBMKNkBHLwGIxw1NPmG8MosyhV5mPWAj2t2ll791BCkNSEIwt+MRUhO7RUnqYVWBr11ERQPIUIJ6rHTydgzMXAKVQwvy9EXc8OF37v9EN3XPj4gz0bhvyap/WkqF8ce4R2/p3a7q50uXdmGQLHQ2kE+E9mTzQbiD70x5BDFD4JznCHu6yaLJb7aaqbRXcpadd5TVvvRX2QNXPbab9OnSAtj9VcdHLatniAvJ06Yi4i2SFbfbEm3uRN0bil9FLk9Se1aoaR2Lx15oZrtAvYX3A1Gw4WfGWd7csytRkJYWlfmYClEwQF7s9CXp1Ouw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETxPJGVeYLSq2+Wueh4B7xasL2q50/Vn/U19q+OiWRE=;
 b=KOfYh60BnTNBsfR9C3AjcTfKPh7OCU+lIruOcTLcUMllzO7+oqmWe3lgjUQejQDDtgbqfiUnkKAs3xfnCIJRoYzLD58t1TLaxJLVKUAZUp4hWav2PGkBVB8Vsh1Tg5gDHBDOTIN1KrpzkcK5UXPOV/CA/Ye9X6BKQAnQF2gy5RdJauXmABWLxVBZW917/OJYvAzY6y0lDe4tLqkQ+AtZ5bDkhPSV08egsQPvLzO+M9eJDmpSy+IhFTk8KHvYgTJQNCKJQl6Pm1aMNVJ0LOK1mk6fyKT1Is7X6+TYicKMG1cOUI8k1yWt+84XG+tRicsESYXZ4y+hI3MijK7hEoBkzg==
Received: from BL1PR13CA0232.namprd13.prod.outlook.com (2603:10b6:208:2bf::27)
 by IA0PR12MB8225.namprd12.prod.outlook.com (2603:10b6:208:408::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 10:53:55 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:2bf:cafe::f8) by BL1PR13CA0232.outlook.office365.com
 (2603:10b6:208:2bf::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.23 via Frontend
 Transport; Mon, 4 Mar 2024 10:53:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Mon, 4 Mar 2024 10:53:54 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 4 Mar 2024
 02:53:43 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 4 Mar
 2024 02:53:42 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Mon, 4 Mar
 2024 02:53:40 -0800
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, "Wang, Lei"
 <lei4.wang@intel.com>, Joao Martins <joao.m.martins@oracle.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: [PATCH v2 0/3] migration: Don't serialize devices in
 qemu_savevm_state_iterate()
Date: Mon, 4 Mar 2024 12:53:36 +0200
Message-ID: <20240304105339.20713-1-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|IA0PR12MB8225:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ccd694e-4dc8-4858-a855-08dc3c3962fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l9zoBch0BnKTW+IX+2PcojEGVsoua9rIikYyzrp0BnUmM7hEjuQUkJKubALuO2H5ku1J9g0/BWsnci6eNSNW1L9BTUi8nnFY+EzVPkou+fgbT6YnwJ1vZi9uKOr2/4w8WWn89WYZ+Y1SRSJ4uWoKCdFXi6ak8fARz0PTqoViX9Mme6AUYK49/dcrluHbToxr00p8V7+/6/Vxaa9puwSVLLMKnODJi6JqDm6vN7ZDRzx4Pue/A359CGQe/SX0Ugp4VaPVEdzIAP5RE9uwD7SwP1HNFgkgs9wrlPxOScwJgnGWzFBEHjsVHgQ0kKUcAW34H0tvZyPgQYzw9/FckJ1/e43lq7PDaZtncCNF/kj6N4V/jiMhO5ClcY76XwxMJdXNU9KFcYOVe3VLWenYzuDVT0Qigww0neYMcYTMwDg3+zxZxXySbh6fz0IOJQho2J5uEsie3iVShartOdgb84hrx8ho24G/vMXZHi0DwKpIo9PRK7NkEPsQcMdEjwYWT9v9ePqcvyryT2ARi5X5kmdKao9CBf53TVsy/VOVaszqU7BCkQBZkv9S4/Lui140mD7DFiL0dwOH3tCFp3I343eQzc+7hQBoP1OtUK7YjI8Kl7GM27IBDXsa5TnQYv/8po40uxlDrHhqpMtYqSH38/0W+SjLJ6GuidowdWmajckJRBsm4IIU43U9z+ONJrD8cG8Xao+zZVDb0UfYZN5p1FCbeAH9L/47C8y6RDjA8lvccVLQq2RiKq3os2KKvof/98X8
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400014); DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 10:53:54.9133 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ccd694e-4dc8-4858-a855-08dc3c3962fa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8225
Received-SPF: softfail client-ip=2a01:111:f403:200a::601;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi,

This small series is v2 of the single patch I previously sent [1].

It removes device serialization in qemu_savevm_state_iterate() and does
some VFIO migration touch ups. More info provided in the commit
messages.

Thanks.

Changes from V1 -> V2:
* Remove device serialization in qemu_savevm_state_iterate() always,
  regardless of switchover-ack.
* Refactor vfio_save_iterate() return value.
* Add a note about migration rate limiting in vfio_save_iterate().

[1] https://lore.kernel.org/qemu-devel/20240222155627.14563-1-avihaih@nvidia.com/

Avihai Horon (3):
  migration: Don't serialize devices in qemu_savevm_state_iterate()
  vfio/migration: Refactor vfio_save_state() return value
  vfio/migration: Add a note about migration rate limiting

 hw/vfio/migration.c | 12 +++++++-----
 migration/savevm.c  | 15 ++++++---------
 2 files changed, 13 insertions(+), 14 deletions(-)

-- 
2.26.3


