Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED3CDD3C92D
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2024 13:07:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2Vdk-0006QC-J3; Sun, 20 Oct 2024 09:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1t2Vdj-0006Pp-5j
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 09:06:35 -0400
Received: from mail-mw2nam12on2069.outbound.protection.outlook.com
 ([40.107.244.69] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1t2Vdh-0006YY-0H
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 09:06:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jojxCZoSx0W4TOpZZPKoAAG2+y+Z8Xg+yUfuoXOP19/SkCpo6M55lteB2HtLKu5sX7Y3K//C9zxFsgF6VRbt37XJ0l+53SrBO7oWxh0zuQG0HCaH7p1Ngro3XvM1OO2zJpIAGUbiW1/BgkreJMgboIzJwIFLFlsXQDqg4fMQsDbhVeoN3Tns2Ih6zbqMEgL4hTgOhCctOfG1L2vwsEFuvPiih4+FKMCIRi6CSEooiGD15ZpSQKw0VbhI+pp7wlsBsUqw6J10R6yKT7wMoEz/aMfAyRAf9lyErPfS1zmw3nu9OeEJYBYgwQAOcZJyl7yBYyKfWfKPEFkMISQRL1QsVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rN1XjDfNqpntAwwv1iXDekLCdezAfuraYXpHDUB6+c=;
 b=LkkUDfrpHaHVs//yUUhRi2u7LVt59/RUPiMiiT3p8nWtM+Vy0O2Vp/ZaDxn45Mu0BrF00JLvuNUWdeUdV7yY/O71Emo95fp3nymO9g1Pae5PxY2i/wtQNncAaTV9dGp0AVTD8kwROmV/Vk9KPe+k94e6gO6P3USV+2tsEjQpD89NrBo5u5O1xhiiOG1kAKDr3C42bjDJKKDH5X4kcXxV0+Scu5IjIyOUGQ6Gbk4YMLnCnzJpxZ4S1tyI/pn4CSuPBq9czt6qJZkPDs9QzHfg69kR4+ae7qfS7NZQDt5C5oky81YkNC11xPXgJFID/L9vy4ix/SFOlQA0QWFbHtSeKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rN1XjDfNqpntAwwv1iXDekLCdezAfuraYXpHDUB6+c=;
 b=AwGX1N84F+NVy2JlTrNNLvESJiLuVHZAtUbeAsdp9PYgcIeImxe6Aru1c3UUDYLmAJA2b4oT9xvAmFBsbJcDebeYzq0brQGv6Wo9KlsOgmKUYCUgrsBEJDi+moRqxBcm3eMg8EqhjrutaOk+ZAbWafBnxtlAbtbG4i6hl1EXeP759vlxHgZq51FKepenuGsREtZQ1juMAWOgG9er3Hnfc70opDJLFt+Sz4iOPBDCLHyd4Lm/pSP2VPz1wDE4FJ9Spwqwzr9b07jEt/OmwEPxRy3c5k92Rac8cNNeu8opIUKM+VQX9iiQaO32a7Lrb6vMAiXqBL5TRS9/HQu+FS7/KQ==
Received: from BLAPR03CA0039.namprd03.prod.outlook.com (2603:10b6:208:32d::14)
 by DS0PR12MB7995.namprd12.prod.outlook.com (2603:10b6:8:14e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Sun, 20 Oct
 2024 13:01:24 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:32d:cafe::b9) by BLAPR03CA0039.outlook.office365.com
 (2603:10b6:208:32d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28 via Frontend
 Transport; Sun, 20 Oct 2024 13:01:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Sun, 20 Oct 2024 13:01:23 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 20 Oct
 2024 06:01:11 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 20 Oct
 2024 06:01:11 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Sun, 20 Oct
 2024 06:01:09 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, Avihai Horon
 <avihaih@nvidia.com>
Subject: [PATCH 0/3] vfio/migration: Some bug fixes and cleanups
Date: Sun, 20 Oct 2024 16:01:05 +0300
Message-ID: <20241020130108.27148-1-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|DS0PR12MB7995:EE_
X-MS-Office365-Filtering-Correlation-Id: a3fa9710-e193-4525-7c72-08dcf1074d00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TNl9BnJq1m5GPr7sOR/1rgsNOFFEKztMX5azwezAh0DFYqojnqYvlsY7DJ2q?=
 =?us-ascii?Q?CUSTHkgROJHI+uMBlurPI6dvMClZdB8r9K+X4shqe8Wec3uqOplSqQK1DZxj?=
 =?us-ascii?Q?5T1Rd37ROyfcHQg24N9VTcydqHFsC+b3YM+BURDzc3iQ4+FlSu8cOKX6ewnN?=
 =?us-ascii?Q?sCh7TvkgOoTB3UKrH75anKd6Vno3ykGt6lqVYILR8IxAEMxzd0gB4hwRy2U9?=
 =?us-ascii?Q?lU6zV8x/EuBbFh4eTypmx4rJ30xS+JLmJtpMaom1FyDs4lrT0pmb2cUxiiNy?=
 =?us-ascii?Q?X8wPkpdYlQ9Hyb6RU98skyKMpHGUXXaLDrWh9Fi5bHeCYDjb/Gb7gG0qimeZ?=
 =?us-ascii?Q?cu3dnekwcL7U+dzKc2StVvL+MQcmvlpdDShK+5bY0W09MXUwE2dlEdcwx0bU?=
 =?us-ascii?Q?kMUyuujdzEArhCZI2dcAPLQlrjDLoACt0PN25WjFuOcfbsMUr9bGj97RIm0H?=
 =?us-ascii?Q?DQfT22ALPnF+FKkIMk/NczEi9+rt9yoIiIVs/xlLurCyjJwyjc9y8cRzdlbB?=
 =?us-ascii?Q?QrxhvOZp3UKXz+DngAI5qN3niirca0g+F5BgcaWEQHsEKTXHNB/P9i6SzgbJ?=
 =?us-ascii?Q?XN84RYwRVuCOS4DwtxP1U9OsV84MwlYUbRwrXXp5yFCKuBQ1e0pNyuSq0Fa8?=
 =?us-ascii?Q?mCTLv1tbQAZT8Et/tGynilfeKbMgbh4dEs/p8gkEHVVhJflvF84fkPd3BEGj?=
 =?us-ascii?Q?BalWmoU1kX34wyvoKCY2l9WTxQhNBGvEB82aGelwu12yRXQoY7PLUSxHFzyk?=
 =?us-ascii?Q?aglLbCFx/s4I0SDZEDIt+vU27rGpIirr6b2+QpDSTLFHF9qGW7swF3+U4dSW?=
 =?us-ascii?Q?UbQHPWBqhfa5HqH4N+vpGxOtIHaGER5BvCPalDQCQo9vUEc/dQctS19en1v/?=
 =?us-ascii?Q?m2Rdrxe0Vr3U8L4i/rK53QRt3kD88cBRikihF1+35CXMG9kgWxQ4rsMCeP2+?=
 =?us-ascii?Q?tokkyk44j9dPk+Pilz7/Fmu2UrOsu6ia8Bpe06F5oelKfhpK7Ng9FonZ57o7?=
 =?us-ascii?Q?r0kFu3/oci2uMIyYSxEa4PBoQWeSBsiAbzAVx4bxx7K+AX3yO/BMUi9ktiW8?=
 =?us-ascii?Q?ANT2xGM3zFBU0dJlqYIZN3ApooHrjqme8X6X0jLzsvFIKvWL3FKnM0jU7AAK?=
 =?us-ascii?Q?iIxvB34U1ViHne+Wo9jdCmxuTZlsF5wzin/oqlk/gB+1nuc60PkWEd1M6GB/?=
 =?us-ascii?Q?+qYwIcX48VtBkvQpsnCbFrGjkpBZaGUWYsawR8SqU4DzbGmS1BwO1ALKQsSo?=
 =?us-ascii?Q?SlEmlYqBPen1snSGjIxSXzMsPfutbOKUkDLZLn0tTzlttS5wZmd0OPNZ5azH?=
 =?us-ascii?Q?Q0UfDFl6DgL2BIZQ2hBDaWv6JR9HJq6KEa7aWfqURRA6tO3I62MmZUkzyC4O?=
 =?us-ascii?Q?2jIZ8Je15KAMmPSxOitFiZntEv3e1k9jeyYuuwtSXAbEVxUKxA=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2024 13:01:23.6679 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3fa9710-e193-4525-7c72-08dcf1074d00
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7995
Received-SPF: softfail client-ip=40.107.244.69;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.527,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-1.699, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

This small series contains some bug fixes and cleanups.
Reviews are welcome.

Thanks.

Avihai Horon (3):
  vfio/migration: Report only stop-copy size in
    vfio_state_pending_exact()
  vfio/migration: Refactor vfio_vmstate_change/_prepare() error
    reporting
  vfio/migration: Change trace formats from hex to decimal

 hw/vfio/migration.c  | 34 +++++++++++++++++++++-------------
 hw/vfio/trace-events | 10 +++++-----
 2 files changed, 26 insertions(+), 18 deletions(-)

-- 
2.40.1


