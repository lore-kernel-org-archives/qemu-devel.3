Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E2BC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 10:54:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh5xa-0003Ct-Sw; Mon, 04 Mar 2024 05:54:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rh5xX-0003Cc-AJ
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 05:54:15 -0500
Received: from mail-dm6nam10on2060f.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::60f]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rh5xT-0005uD-Ut
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 05:54:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gsG1vfoheecn/tF594PUkjSQDAmBQvTWqPQQ+Ybb+LtsD0hgU7L0qgiwPbGPCCXIEFWKbop4lP5yvjCqnX51yEN4sr5GlM2MLw3JYQwAPYTu8KB4v8BzbRdcfoeaJGKBMChe/EbbHNE83hy1SHfkx1UKzPxTdiUkP6tVQg0k3fempV4gt5PfUy4UL6Zs2VRnjKNhLeU9o0p4IYwSdOzCKStmth5Oo+GEyN/nh/cogAIs4YRZDkEARxgT5B5Mq5J4EH/KXc9G9lcK9iTgPFScztlRsN6mEYue4TTYlRqwfV29gYn1F7DQs3CMj+U6/Oz+srEMz6yTb0ClI7ktxoQs3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3kM7KgztYCkLtrafdUf6/mkJhTM9jfLsyNBrs6f2Chk=;
 b=DnkDJcnWfNDDenDWBa40i6XlIvfsAtgUy406VUzFI09MN1uAAhNMGjOzlWjhYi8UCTsE5thxc1LO/8/0glAUJOMOqSqGv9ji9842pSLFiL5rf43ZlEcTpfG5D1yZ/c+QpNCqJBhkuc5axS+LtCyEfYcdjmg97+iwYEfNoJNsk9TGJopmtsHgzqY4/NRO9G4u9CPaqPeq6nA7mE1+t+WW7OgRdKBTXamPnMq8TOV3Wad9kDUhyFf7DGSY/EYblPuZbdSe6OyAN7icqd5WyyaNFFQscHa2M1IkoBHQ/mtYk7Cue1PTTskounyuXYohyqd7c1mwegw5DYMPNurvTQJ6fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3kM7KgztYCkLtrafdUf6/mkJhTM9jfLsyNBrs6f2Chk=;
 b=ixiAd/Q/jAKf1lxlH9Nkw3kS8WMSNRPIgArbtqtAIP/G/IEiQ4kY9/YIzGkuhdMYZdlV+845ksy+uXXhp9iLshJFUwyicebyEXWs4kwB+RDkDExh/N+DbObTV508gmHQ/nZc4tCt7obYIkiID7pQbL59cXhmFAgw8Y/piQUMGibLX+USCT/tZl6oW1DUmB04q3YJmw+xH9EmO40P4nB+v0WIPZb6D/DPn1DPI8BLq8v51cIkzeOp8TGeJ4X8WYqE7MfHQTOYUaKNm7P3sleOVyGxTEiMc3yBlHymmcc+V8H2VegnYsGFLPiUSs/hHvsLrrfeyAFrn/mtS4NeUb4mVQ==
Received: from BN9PR03CA0928.namprd03.prod.outlook.com (2603:10b6:408:107::33)
 by CH0PR12MB8506.namprd12.prod.outlook.com (2603:10b6:610:18a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Mon, 4 Mar
 2024 10:54:04 +0000
Received: from BN3PEPF0000B06E.namprd21.prod.outlook.com
 (2603:10b6:408:107:cafe::14) by BN9PR03CA0928.outlook.office365.com
 (2603:10b6:408:107::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39 via Frontend
 Transport; Mon, 4 Mar 2024 10:54:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B06E.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.0 via Frontend Transport; Mon, 4 Mar 2024 10:54:03 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 4 Mar 2024
 02:53:50 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 4 Mar
 2024 02:53:50 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Mon, 4 Mar
 2024 02:53:48 -0800
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, "Wang, Lei"
 <lei4.wang@intel.com>, Joao Martins <joao.m.martins@oracle.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: [PATCH v2 3/3] vfio/migration: Add a note about migration rate
 limiting
Date: Mon, 4 Mar 2024 12:53:39 +0200
Message-ID: <20240304105339.20713-4-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20240304105339.20713-1-avihaih@nvidia.com>
References: <20240304105339.20713-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06E:EE_|CH0PR12MB8506:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ac8a222-9830-4b06-d8bf-08dc3c396826
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AAmXQSIVMoiT4o+k+xCCMg1SyxpX+Nu0sDRXQbpVZIT8uplKadh6ZJd+V7IzNSwGvUw4xYMAa9kf8TLEas9R67NPHNVhjoqha6w8U07nUzIgVy3evJU2UJ1mnBGpE4V3INOXngsHj5Du7h0nc/M844P7QVx2aBvv4dLw3zLFAfIvseDacWS0PqBvsMgscJz9YI28p1YEG8DWXMw9G9bDsAbKFAWmR68XTyubltzJOjxk4sZ4ZIlofKQYGFvm4v4igWXxsbxFpkIF2sGGlWxM9DH/84nX16ha1U9O1/RdwaNjVyJy1bU+HmxH50OSPyVWTlvTpORIiuXZ8ILf5bDLXv+7x8UQSmTcUx/eO394DZVj5459l//gKHeQi690lPJIjeIcqoYNGH25FFpX8Ozfh0cX6axQaUGlDQDmdPkbocIdMNFomFk0cVSJSAfAE0PPqxKrgcrkJdC64h/ECtAiAjXOQcjExGnsFITA/07NwD231bK1rxbKrEyZTknTouB/rBsXt9RD+10/yXTL4Df8bWulfRmQ0+kJMarcoqVN3nuMWtjfGMvucZAQ9PDmoHGAtuz6Fcs+MleV0l92DW9OGR7tXEsXeUu11foZzWRh7MUsT1k11UWlCYsQg5pWYG2Rc5k+kryrexu5aNVv9CuIUFNAJWDOO1NBq5PjtTe24/CW2Nayd+WktXXZQI2Z/Fz+XsluL2XA3PVLCdhy2NsUaE+G2hxm3C73zlUbMZZLyLpnzPdr4ZQJCFJhzbbS5jKy
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(376005); DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 10:54:03.5915 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac8a222-9830-4b06-d8bf-08dc3c396826
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8506
Received-SPF: softfail client-ip=2a01:111:f400:7e88::60f;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

VFIO migration buffer size is currently limited to 1MB. Therefore, there
is no need to check if migration rate exceeded, as in the worst case it
will exceed by only 1MB.

However, if the buffer size is later changed to a bigger value,
vfio_save_iterate() should enforce migration rate (similar to migration
RAM code).

Add a note about this in vfio_save_iterate() to serve as a reminder.

Suggested-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 hw/vfio/migration.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 0af783a5892..f82dcabc49a 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -505,6 +505,12 @@ static bool vfio_is_active_iterate(void *opaque)
     return vfio_device_state_is_precopy(vbasedev);
 }
 
+/*
+ * Note about migration rate limiting: VFIO migration buffer size is currently
+ * limited to 1MB, so there is no need to check if migration rate exceeded (as
+ * in the worst case it will exceed by 1MB). However, if the buffer size is
+ * later changed to a bigger value, migration rate should be enforced here.
+ */
 static int vfio_save_iterate(QEMUFile *f, void *opaque)
 {
     VFIODevice *vbasedev = opaque;
-- 
2.26.3


