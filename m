Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A69606A321
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KWd6ppN9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRV9k-00075w-HD; Thu, 12 Nov 2026 08:48:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xRV9c-00074r-7L
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:47:52 -0500
Received: from mail-westusazon11010008.outbound.protection.outlook.com
 ([52.101.85.8] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xRV9Z-0004Fu-Jk
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:47:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R+2WzO7d5/sqpJK2KSEm+D8h1wVQxAASHt9sWKdTQanyLA7hjkCt+bj3sDfLr3kBumqr4PSVbT+kwclwNN/P/9Rt/KnzRRNWvVhnA4U8sFH5pkOf2HJVajBCBRLV4CbSYXJkXIYtvftNrM2eaeofzd113tuGmqioG5YQgMqogGDh3nC4ziP/yuAU9+jNPxlD7T5pdZqSz1ydiMzc63/3thOh8f+jS3m9qyWVZXeSp3Ysh/4WvqCV9i7tllTj9OLGM15v+YZhW3YqliGDOoTXmldxhFiwp+8v/g7cDPFNgQp1Nrca0keBBPD49wmkMnXRgpMivn/oxB5qR7Qe2rjUDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CWd5xL0/mLlBIO8h1l+Xtv8hSUZMHrbFlEbP9bksWEs=;
 b=NKD7iyvhZWgln1T8BL7ufpomkFWOS6j64uy4Z72Rw6l2tvQ4cz7QunL4ZU0USrPhd+IRm6dGkGo9eR655kEg7AdD+sX4FiMiCpwVwDrHmOh9yl2xOZRFZfyPjOHkOMztWzwYWjqtPgwR6FY2p6vPYglUVpiFExF+pFFkRmDH2D3OfOLFXUULk+N45mJJvqHym/8vHPKhgs7+JXGXK2bvCELwqGZV6/38+amY/HAf1aNigtqws3xECZw7ULSd2HFb8NGJR3/fIKeywGway00xnAZRFs0XP9wNBagWWWtGAwUGyCwkILgOMFcTGV46MkyvdRJp1pZfqe9WvWIoses5wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWd5xL0/mLlBIO8h1l+Xtv8hSUZMHrbFlEbP9bksWEs=;
 b=KWd6ppN91mjcuQE1FYDG2ZA6PCqBIuZdaDBEuEKCIJKJzzZIkHkHPvn4WNSQqSR9QxMt5r/DW/N3p5sUSLmYwYkdm6Y0qs3DR84GBxt0CEFR3wypZ7/Ck5dkVvjGPWyunfxFIMMgY97qWlTzaFFG1ftgYnydtGhEbjLQjWZ55zM=
Received: from DS7PR03CA0115.namprd03.prod.outlook.com (2603:10b6:5:3b7::30)
 by DM4PR12MB8473.namprd12.prod.outlook.com (2603:10b6:8:183::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 13:42:36 +0000
Received: from CH7PEPF0000001B.namprd21.prod.outlook.com
 (2603:10b6:5:3b7:cafe::36) by DS7PR03CA0115.outlook.office365.com
 (2603:10b6:5:3b7::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Thu, 12
 Nov 2026 13:42:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH7PEPF0000001B.mail.protection.outlook.com (10.167.244.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.0 via Frontend Transport; Thu, 12 Nov 2026 13:42:36 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 07:42:36 -0600
Date: Thu, 12 Nov 2026 07:42:06 -0600
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <richard.henderson@linaro.org>
Subject: [ANNOUNCE] QEMU 11.2.0-rc0 is now available
Message-ID: <ash57kbpyurpcp2lwtfq2mb4y7o6fbygckq5jqa2md7jfmr43g@hhkpjrshwoog>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH7PEPF0000001B:EE_|DM4PR12MB8473:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dabe563-96e8-40a4-fc7e-08df40c2cffe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|10067099003|11063799006|56012099006|261022105027099003|261022075727099003|261028144727099003|261026121527099003|261026140227099003|261009223027099003|18002099003|13003099007|27256017;
X-Microsoft-Antispam-Message-Info: u1JnbvIXMyyEdvHbuUi7Ju2NI08w4qy8EUPIUg9Uo6P1pawoUj+UgSNVvUuw6UNmytIE1em42l/+XETknVJWUgXGmMOt33hzpTlNvznubG5Ot9ey2geAu7j5iRkPnP9evIyHz5vWYYFP1DDRwtqTMwjQ3YyJJx9PvS3P+0bHYPL723jHX/f1m/LOrmDpVmjaBBpddvGi6vIZy1p6X6+ixdvzqdSU2X2zLKXMB5fASYI52TWuDaJ/7Bcp0K8w1VoBl+p7ehizVQ5DvNEwcsJQ8wL/5NYIm7jlOGJNzHbFsTj0nsOxr62IZqXgXcf0BGhdwiv0ESy7rL8+av2UfM0slDujGGxRt7eIx7jzJ4IXh0vt1RGwji1qMaJv128DBs4EdAHS3juqlK3hjHgiSYwSyJIlgQECXiTXnJcO1H78bu8b0Q5ZoXvUqBTxqvt//ygLl+jBcHTSn9pOoWSSIqWgL+WSJbGsXfMzPCRItkAtKw+X1T9ZtyqSsXbWtpDF/xqcBnvR7+dY5PJc7wzts9hIDR9tnJYDPSOtc+Qx1BjNu3JDUcC8DzbbZxkn788OZg9Y8PbglKNqSWPGCwW3NEBdf9cEgJGDc0Sr45gtP7XoJDtnouK2TaHHoIMIaMQk7516cEXcAUQXLWN6E1RmCDerluD2W0LdOvM1yrSI7xRNsN79jaLnWLZgPA7uTBpYfq48mHur00bIBKDcLnj1inX2Yg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(10067099003)(11063799006)(56012099006)(261022105027099003)(261022075727099003)(261028144727099003)(261026121527099003)(261026140227099003)(261009223027099003)(18002099003)(13003099007)(27256017);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DrCasQxtzsl+kcWhAls7ND2E6YcXsIz3Yv3CzKEsxMSL/k8gcXN58LprNPkWXSu8Y+MGIv1MEv3YRUVN8s6WMN/3WMt7l8L4+PtQ2+2yWVdLipwdUMUvR74n5WaBt8dmC8ITeXgbk9ZSroir/SmA9ksSb1kcBmqTFqNjhjMPq0QrjFyU2pnTL8rY1YmOBI5VaABM4pIdpalL+PU356V2+0e1oxFNohNG4/snBZjk7tATqCaQbcAjALp0MhcRCeD3AoJbjueR0jyxpovjWvmh7do0LYA8RoKW501wskJRvvYTZmpwrU7PXr9PITKyB68pnSidXSw3FMlXHJb9K8cCmrLGVbYoaZFIOwsZxumjL6YalxhSEVulgA7Cful2dZMYPq48n8fVqiowOmLxZHGO7i8IoYNlXS1VX3kLm59N0pmdNKs/Cc++aOfzFbw6E20k
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 13:42:36.6771 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dabe563-96e8-40a4-fc7e-08df40c2cffe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH7PEPF0000001B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8473
Received-SPF: permerror client-ip=52.101.85.8;
 envelope-from=Michael.Roth@amd.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello,

On behalf of the QEMU Team, I'd like to announce the availability of the
first release candidate for the QEMU 11.2 release. This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu.org/qemu-11.2.0-rc0.tar.xz
  http://download.qemu.org/qemu-11.2.0-rc0.tar.xz.sig

You can help improve the quality of the QEMU 11.2 release by testing this
release and reporting bugs using our GitLab issue tracker:

  https://gitlab.com/qemu-project/qemu/-/milestones/20

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/11.2

Please add entries to the ChangeLog for the 11.2 release below:

  http://wiki.qemu.org/ChangeLog/11.2

Thank you to everyone involved!


