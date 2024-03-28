Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D89D4CD1283
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 14:09:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpqR1-0000GA-IT; Thu, 28 Mar 2024 10:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rpqR0-0000BS-BG
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 10:08:50 -0400
Received: from mail-bn8nam12on2086.outbound.protection.outlook.com
 ([40.107.237.86] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rpqQy-0004ut-8L
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 10:08:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g0zPlRtbyHgrYqsThqufIxXzCL+GnNe4VsgARWLVBXorVwpJFCPqh1+cHgwIvTgKfU1R/EBRifEFyGwJlbVpAarU7F2PQCYDmtKaEIF7XETIoZgeD83lQTffJ8pBTW5OJCg1VB9pjvHpyBDL6jK89C4v47HGhSHF5yUTqkonsTIGTjNe4TH4BfA/2ahmBPACPpl9w5dT3edJaidA7xBryfiQHvD0fQZAti/D3Dpqge7Nx6VQdkDwdGgvCu34bJQPNZy2QDi6+0lzoFGqpWyq5U+nnMnyhFtMfG9sdsN00hHaSILXdibyeeSILRzVBoU9j9BdVQs3sQRCMpW+AekWFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IEBOJfZH1NMwuBpz438sGCbB/PKALHGpjlyCGVZxIQo=;
 b=D4E1lM29xkE7wSCMcxJzt0GHxmlAig2C9T2KiMnd80DO30CS1wVHQ+j8i+wmCZbDVcZ31tiQYQ4vOqhDGWx/mgzTU2+rzTb727oa6QCxMkVmKFJR0rP9x6QIwv4H79jTPx3EWc+nUjv7BDIJxWJBXQhmfQrarKCdkIy8abKdK/yVmzSazURkCsnJpzmjU2MCnmM0Kv4YynyXD2kynAyVFyq9g4gJj0yB+t29ZF1zFBK5isXCrynYfNYUpsefcCzONvgU8Cri8NeKVUaVdSYrYxlY/tftTUmfVQsuwa6jCankEK606OH32DcH2Wx4XR0V1yvajBnNLUqXYZ6oVDQCzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEBOJfZH1NMwuBpz438sGCbB/PKALHGpjlyCGVZxIQo=;
 b=d6sTfJDRg8JfBIdfsJxWiosV4pXonkDI3R9oXWkaeQ/wWsCJrOS40frnTiJIfxP30vlqqpEeKoTgmcXxNhu4b1QusbMa+DhwI1vIrKylidRBv21AQ1CS+O+LzWFYn4jc0Ij7VafZUvTmNu3TxhabjVGxtWLuH4WCCmNO/zvT/WRX9aB7U0KiVGtDs5wxXLBkEAgBOOb6m+7GlxmLVDC+q9MvdXxRkTsfmWQlI3aVIox74Nc+njxz+4xfaGmL8T6rOH8ZHr+QJyFif52MfL9jWYeEFEJS0WK3UPNJXb84WYDkQeq9h/zqqFyoooJhhE5jnvC0gLHOC+3vcxv84gA/sA==
Received: from SN6PR16CA0055.namprd16.prod.outlook.com (2603:10b6:805:ca::32)
 by DS7PR12MB8204.namprd12.prod.outlook.com (2603:10b6:8:e1::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.32; Thu, 28 Mar 2024 14:03:40 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:805:ca:cafe::6f) by SN6PR16CA0055.outlook.office365.com
 (2603:10b6:805:ca::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.38 via Frontend
 Transport; Thu, 28 Mar 2024 14:03:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 14:03:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 28 Mar
 2024 07:02:55 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 28 Mar
 2024 07:02:54 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Thu, 28
 Mar 2024 07:02:53 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: [PATCH for-9.0 0/2] migration: Two migration bug fixes
Date: Thu, 28 Mar 2024 16:02:50 +0200
Message-ID: <20240328140252.16756-1-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|DS7PR12MB8204:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c9370f6-6199-4779-0934-08dc4f2fdebb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CZc/u7/yebczTusHV4jgsxKCjjejWxOufWX/vECRQYA+uOdTPUvghgF7K9Nn1K0x9lKpK9oGztoroZOUZ0nye6HmoG9BvEvRQZeJD4c1c43zG0Fsm9/sh+lAteAsclkVuVOAAZ6yWEaomV6C4z7fKsi9859t0ybbPgyYlP/ALgZAYqexW72BbHOSdk0dBHYMPwIHYHna4++ozPXBhy469L1DFNJK6+r/nwdDkjWi2r18r/4OyDDkezRPCmqYt8rVVr619e4Ry/zMA65ItSYaWJQFWPGaZrYyzlJfgotitUcXu+9YQkGxRkF/Hbi/C1rIMJwv3YlQ6jCjwMjERrscd4Ood83Wzqn3TwrauRuWKmTW9BjLesyzI+P4yUEXUPH4OpE22JRKxsnYgFj/Qv7ruouMBFoRHHTdMs2DrWyAdRul6jXbgVsbbfFbLDR6raUDJXi1oY9E3jRlwqtMbdxRC3GSYzNFnXrMdUvcD2uHuUHQUrJ4pv3BKO225FI8QoJofSCxbXXZUtvfzHeUY2aMXxrFfJri9kIDYpHTFet3WVnxorewA9KhWKucQ0q8NzIBernpl4N+oZ8NbXcvjvCuzBYbFUT6/DdLT5KXBJsKP+KUdHqQZ+mtmx2hmwS3SepGb+sSOzaPcWU1uXVgsuXVSZzSxAhvJuICV/xkmc7ZYo+GWWhAVK/6rR5/t8xMRmelNuFnmLvPIyxHHPRZezvOH1Ub7AkIlVmEjTCFF10A5nsW6ysymD5zbEu61e30P1y3
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 14:03:39.7374 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c9370f6-6199-4779-0934-08dc4f2fdebb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8204
Received-SPF: softfail client-ip=40.107.237.86;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.08,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello,

This small series fixes two migration bugs I stumbled upon recently.
Comments are welcome, thanks for reviewing.

Avihai Horon (2):
  migration: Set migration error in migration_completion()
  migration/postcopy: Ensure postcopy_start() sets errp if it fails

 migration/migration.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

-- 
2.26.3

