Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C95C47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 16:26:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT2YA-0002Hu-15; Thu, 25 Jan 2024 11:25:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rT2Y0-0002Gv-NT
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:25:50 -0500
Received: from mail-dm6nam10on2062a.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::62a]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rT2Xy-0000Qg-LO
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:25:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gGyWw7qivkxc6JYrMuAzC6yoiC+beQToCLijsJDxGVoLsKv3dwTqf8fTuQUxX9dTqdh5/bEiW6WseQAVZ+Outi/8TFpxwd/UqAHeo9eqa1n+wHyIJG/6G0g4hK9aENEjJVs5twxeDvo60T9Nct2lKAz3se5KdqQtp7SDLOf3P4mnf2HPqrJJ+VVeKcT1uxzCUcL8+Y8Payi/eJZ4M/7o3chVl3kGiKZ7xgy/hXzUw/xlp4O+gtM0IzZsQEJuIUKK0FTF/ucemc45MdTTTHw5miDHmF2WaqWVe6VxW21SgqMOsZ7E0VaB1Q1GTYhkqQNP/HKmNWM9kCH76WBrZytCEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=crbYLni9S89KWLQnHn85X3Qv2aaylUqb4MnpLmw+pR4=;
 b=LhJwhQCYqrg++Bs6DJwvOEEUUOD1SfitfHZh8Yji0Ec9TOt79OEjIDYB5T7PYlSnb9R2vXF+SRNnCUF30/pu2lIATYfpbe8OFuQTYfkY5FDymoxWLxbnhDvqVfwwW7LwIZaABLX5QCeBDakIOac+YiMT9VpH/eUI0r3shyDneNS7xQEU92wR7JHsef0qPhfMUpAW91xJF+6gT1i6M4ve9IH2o6Voq0gavlZBsqiTwWqay18YRxx2fukaDyaRYDJpM2mmeTXs/uel6K8UsQoKKHbbffqdpz43lruvqEj0zXnKoH9iWElAgnYpTHwM17ULkfJ3VKEJr2eF0boJXjzO8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crbYLni9S89KWLQnHn85X3Qv2aaylUqb4MnpLmw+pR4=;
 b=XBIv9agsd/0B4guaWB5RmuZ6ISXaw4H383UGxktw8mc2Qd1jrn4RgG33cjpw2PEeNEUmZgMBlizn4h4Jq/07Dt2oCHIcTSzSvPT5mbOLMoWYTIEyX6JNMAnj4AUmAoOb6mXH1ZopIJ+e8QhX3J8fml/msKMFaeLLsRdwjE6b0NoEMYryZ79URei+yL3jn1PIcghuquveqy5KBOzZqEnlAMFW1lorYmG8lJH2x+qT3MGTdgfNsd77BQZn9Jkxv2j6a14eNtxWsW4rriV5FEyO6spDJbqipTtmn8rTcpxbsFWKJXY38RCevEweL91bkNta+YHCLj6XLAgnyi6x/3qe6A==
Received: from DM6PR17CA0014.namprd17.prod.outlook.com (2603:10b6:5:1b3::27)
 by LV3PR12MB9354.namprd12.prod.outlook.com (2603:10b6:408:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Thu, 25 Jan
 2024 16:25:40 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:5:1b3:cafe::b4) by DM6PR17CA0014.outlook.office365.com
 (2603:10b6:5:1b3::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Thu, 25 Jan 2024 16:25:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.81) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.16 via Frontend Transport; Thu, 25 Jan 2024 16:25:40 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 25 Jan
 2024 08:25:32 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 25 Jan 2024 08:25:32 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport;
 Thu, 25 Jan 2024 08:25:30 -0800
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, "Avihai
 Horon" <avihaih@nvidia.com>
Subject: [PATCH 01/17] migration: Fix logic of channels and transport
 compatibility check
Date: Thu, 25 Jan 2024 18:25:12 +0200
Message-ID: <20240125162528.7552-2-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20240125162528.7552-1-avihaih@nvidia.com>
References: <20240125162528.7552-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|LV3PR12MB9354:EE_
X-MS-Office365-Filtering-Correlation-Id: 8db83e9b-9bce-419d-25c0-08dc1dc24557
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FCkw7mG6aTeyp5A9tHQ7qHIvEIx/AzY5+6+lMZIHlqHyYUJ5OKySos53u9Dn56n99UNJjqr91yKpfbf/rJJFPL7g4VPtyYlsPWz0kvnr2+AzMpVxo7tZjfoJTjNdHQZK4Azk4Xh/K/A/vqZ4fOylhhTDi2Pn5FDMcjHNOTMaQ93JMIKChdOG+XRd5adVu/Yv2Tr5qyluJnov9s1qZ1Z+V+2xR9Xs2dLoc0utKyGgDWpxlE2srLb87R4xHFu1XCEtTZPquA8rUwFpciGnBiQ+6uwsOnHoVyDuGWFQWeKrQPssAEmqu8kZKMLRHs7D5AdxCpsuFnGFHiFv1J3bdf/57JZQ8IJTJZjtTQeu6KmST94hDB6seyJvt0bzT+6oFGRSGJtXcO+7vqhsN17PtWDaHLvg0ePkchbqquQsIRez7+3dmOodzQfZfmYFSb+GMJASGuIDvIpzDmqgRBzYNiF0Y7ghi9DoLWl3qF3RnDM44qzk30D+zZKnpNhBDMAZhAQp8Tc7659N4+1czCl+ECzaDoEIie6C36tD+jb57NxtJCIdaiTMngOATPtfbTjdgeEOoPaqbT1nuS1hFaWYTZS/VXhrE3eC/joe6oXScWDvCyYN4sYw48YtP0nF2seqlcmSR6MekC9Uo1uxNgSA5EhPSCM7IB7d2XgIvGE2AxEMQuSxz2W74zB8e+F4kGiVlwDyZr9zemkMEXYSslNotD8db6iHriomc20zD5X+OaeozEX+w+AJMNmX7slv3ub3P2qI
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(376002)(136003)(39860400002)(230922051799003)(64100799003)(82310400011)(451199024)(1800799012)(186009)(40470700004)(46966006)(36840700001)(36860700001)(47076005)(36756003)(2906002)(41300700001)(86362001)(7636003)(82740400003)(356005)(54906003)(7696005)(6916009)(316002)(70586007)(478600001)(70206006)(6666004)(83380400001)(336012)(426003)(8676002)(5660300002)(2616005)(8936002)(26005)(107886003)(1076003)(4326008)(40480700001)(40460700003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 16:25:40.3030 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8db83e9b-9bce-419d-25c0-08dc1dc24557
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9354
Received-SPF: softfail client-ip=2a01:111:f400:7e88::62a;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
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

The commit in the fixes line mistakenly modified the channels and
transport compatibility check logic so it now checks multi-channel
support only for socket transport type.

Thus, running multifd migration using a transport other than socket that
is incompatible with multi-channels (such as "exec") would lead to a
segmentation fault instead of an error message.
For example:
  (qemu) migrate_set_capability multifd on
  (qemu) migrate -d "exec:cat > /tmp/vm_state"
  Segmentation fault (core dumped)

Fix it by checking multi-channel compatibility for all transport types.

Fixes: d95533e1cdcc ("migration: modify migration_channels_and_uri_compatible() for new QAPI syntax")
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 migration/migration.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 219447dea1..6fc544711a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -128,11 +128,17 @@ static bool migration_needs_multiple_sockets(void)
     return migrate_multifd() || migrate_postcopy_preempt();
 }
 
-static bool transport_supports_multi_channels(SocketAddress *saddr)
+static bool transport_supports_multi_channels(MigrationAddress *addr)
 {
-    return saddr->type == SOCKET_ADDRESS_TYPE_INET ||
-           saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
-           saddr->type == SOCKET_ADDRESS_TYPE_VSOCK;
+    if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
+        SocketAddress *saddr = &addr->u.socket;
+
+        return saddr->type == SOCKET_ADDRESS_TYPE_INET ||
+               saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
+               saddr->type == SOCKET_ADDRESS_TYPE_VSOCK;
+    }
+
+    return false;
 }
 
 static bool
@@ -140,8 +146,7 @@ migration_channels_and_transport_compatible(MigrationAddress *addr,
                                             Error **errp)
 {
     if (migration_needs_multiple_sockets() &&
-        (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) &&
-        !transport_supports_multi_channels(&addr->u.socket)) {
+        !transport_supports_multi_channels(addr)) {
         error_setg(errp, "Migration requires multi-channel URIs (e.g. tcp)");
         return false;
     }
-- 
2.26.3


