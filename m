Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A84C5478C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 10:54:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh5xV-0003CR-11; Mon, 04 Mar 2024 05:54:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rh5xS-0003Bz-SG
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 05:54:10 -0500
Received: from mail-co1nam11on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2416::601]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rh5xO-0005tY-Ha
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 05:54:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IJCjeyL7T2GP134F5hpZkIk9pmSdZ3pkBPhuCTNcvsEB/7WNRjBw7imsVWQGa2KQjBGRlqc66PNcuBU6vdwaEcLacsW4t7CQB7YpYWuYIksAWujJNf8weYEXmZbvORhpOnWzsYH8kNUEomTcNZ8KJV7MEwoNBsNQtGqqqyLmJxBZPYnlvs8mYiIl6RJ95TFNhzRQC5UbCWLiZ5UvElvtRheKpg4aVgtO/K9irN4L9ePQ/7Yo7YWoZxOcbhMN0TIUofr7thOlNZ6ewYogvOdXQlmPNMzOFjFOwlIZRJMdjlEd57Pyt4nNUPNUQxvYaX9TIjXgDOBBrzqO5HWbnmHV8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JVwuTJShlRAFgGKpN33gMlFEoL8O9HLOKs6/BcfdV4E=;
 b=fLWMeKf/Z+rhwQg2TsWRVUXRS+DgMyO0Ut26rqUzsQ4g+id9uG1gZxL8uoHOY/BsBqvrXdMIqhAHCiXZf9jveu50BALH6wtr5R/SuwpVxBasvoY2224s/ytRpYrIBhykfUZ2JRuvvWJAKzqzqag8VKdN5fhb1E178ITijTRAIOhs8a5TtJmFQkouoLNHgKyAo23WAimdtnJQupE3TGlB+WwL0z2ewqgzyS3hSBObQqPzbuo2AQSKN4GDLXLcUzGR4EhTxuKzxcJLOw97aq/F8USiWXnYEFCs6PleSX+SydwED6y2idemJ9R66z98wuoNfPHmHfT74DSolRAKAzDvpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVwuTJShlRAFgGKpN33gMlFEoL8O9HLOKs6/BcfdV4E=;
 b=WzWlRc+GaWI/Ov0GnTQhPIvwr7wKLR53C846xOxdYcuxij5ZGC8NZjuZhtXV0L5KNHotcw4LS8xghs0KSdmJY5jNXGEBA4nb3ssiCD9gDK2rx3rKtgNM0itYZjvwt5xAgXpv4LrC2pQEnhM5Ms9tsideWMJL9UFNXB2RJgj/BwYZG9Hr5G1kUJEPgtj1tm1vd2AmJGuQ89YaYA+rIsj7VIREYSHxZI6h/b7udpiCf2QGic3mcfr7kAZtryxJqn/xdz/uGPK7XYErdgrfGzck+qHzZ2DIzIIN5milBY500YNvInAPH52PpS6KuRPQQGo2MnpTkzzx76Azx1qrTkgA2w==
Received: from BL0PR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:2d::40)
 by CH3PR12MB7690.namprd12.prod.outlook.com (2603:10b6:610:14e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 10:54:02 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:2d:cafe::4d) by BL0PR03CA0027.outlook.office365.com
 (2603:10b6:208:2d::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39 via Frontend
 Transport; Mon, 4 Mar 2024 10:54:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Mon, 4 Mar 2024 10:54:01 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 4 Mar 2024
 02:53:48 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 4 Mar
 2024 02:53:47 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Mon, 4 Mar
 2024 02:53:45 -0800
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, "Wang, Lei"
 <lei4.wang@intel.com>, Joao Martins <joao.m.martins@oracle.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: [PATCH v2 2/3] vfio/migration: Refactor vfio_save_state() return value
Date: Mon, 4 Mar 2024 12:53:38 +0200
Message-ID: <20240304105339.20713-3-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20240304105339.20713-1-avihaih@nvidia.com>
References: <20240304105339.20713-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|CH3PR12MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: 07dd0b9c-45de-45ec-bc84-08dc3c3966c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mZH5Dbt360I7xTYGRCWmC4kD4MnnKWPdWb9z7vkPuY0E2zYtl24B/ljfxgSomWr82CWz0KsuGyYv+Dsrx3sexr//SEayARsycsv9dtdW+4+0gFEOh/G7WtYyrNUHNK2MKthIS+NWYVKKSCUcP9ECjFmYO2RYiUX4sRwsxgMGKpJT355pzsOPZJcoqMX6LMOtQ/lMiMOKYvPh45Btiz9z8ZC1AY9c3yijk9VDw0oWzp/uQDyuT2e5JSewNPxhQvesIVLf1VxTMWq07jRY0T4m/ncH9IcA1+YzUrGGh11LLJ5+khB3pzpo3ZW2JkFW7NOpBQtvjLMSum25fBrUAxzU01PEdp+nEVK7CHv/DxY5Or7umsHfDJqWh6EREIGlnzyL7c/F+ABP1TII1WOpaCXjk4siaSSBc+eKEH+uFSnRy+pjfyfUfi3x2d9MM30knli3hVaYvwknkcRpzIbAA+2FBrpBBOVsh/uiBFe677IxArB8WWMvBITUUIaojrEWqoRIZs1pGnIscnhjVd+nX2tPMrTMRyEba7dK2JHXsu02wC3LH4TX1/GerSGNuw7shgQjbIAenBdPuJnTGjPvLPkwQVKKOuWHpx/jAEBnFfQebF9QJWnalBnZSWTV5IHItrmG1r8l8PHrHkdbBTWMy2ie+HSIvtWyDgRPEYxQEo62masdusW288Ds/rgcnsal1v3FIcGfJoUlZxr8qhYe7zva9aAaVDWF1J+e04I0RcYJWRtMnA1+GcRVp3P2xIRixBxr
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014); DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 10:54:01.2904 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07dd0b9c-45de-45ec-bc84-08dc3c3966c7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7690
Received-SPF: softfail client-ip=2a01:111:f403:2416::601;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
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

Currently, vfio_save_state() returns 1 regardless of whether there is
more data to send or not. This was done to prevent a fast changing VFIO
device from potentially blocking other devices from sending their data,
as qemu_savevm_state_iterate() serialized devices.

Now that qemu_savevm_state_iterate() no longer serializes devices, there
is no need for that.

Refactor vfio_save_state() to return 0 if more data is available and 1
if no more data is available.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 hw/vfio/migration.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 50140eda872..0af783a5892 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -529,11 +529,7 @@ static int vfio_save_iterate(QEMUFile *f, void *opaque)
     trace_vfio_save_iterate(vbasedev->name, migration->precopy_init_size,
                             migration->precopy_dirty_size);
 
-    /*
-     * A VFIO device's pre-copy dirty_bytes is not guaranteed to reach zero.
-     * Return 1 so following handlers will not be potentially blocked.
-     */
-    return 1;
+    return !migration->precopy_init_size && !migration->precopy_dirty_size;
 }
 
 static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
-- 
2.26.3


