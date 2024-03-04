Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1297C5478C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 10:54:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh5xO-0003BB-Fx; Mon, 04 Mar 2024 05:54:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rh5xM-00037k-U7
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 05:54:04 -0500
Received: from mail-mw2nam12on20601.outbound.protection.outlook.com
 ([2a01:111:f403:200a::601]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rh5xI-0005sk-Od
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 05:54:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJ2L8E+W50OMU5Jp6MpQDq5iUb8z9M7gdVXXPgcyjjVxb46q3d/CJBO37Oj41DH/kCJyh33DEonkJ29fnDhb02vNndZ9/vOD2DpBxohbw7zBYoDJmCAF35JTXFoDRyWUUGhCj7uagx6wFc8EnAiEfBO/Ia7YGIGAsOKmDXwln3floMH7nqdps33qGWXCboL0pernzSZpWS70aFKZhvIo4I0ZhXVohgFCRMotegZjkBnY47oKt6qZ8DUpXjDpV3o7y/dY1UA+IeUbN5OXGX8p/qnxNr3QzjcNncOPjpgyujxM0EAdMgGICZcC+cl+iHdEvtgnzUDTSldolNh9WIskTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fAaTZkmK5Z4NYyxaOuFMHZxiguoKYxh/qH/JgnxsVY=;
 b=az2WTb1fZ8aB8nGHKTgzuF5FGMtpNjPM6Tyrfcql4YCVt9JOq0pE944bEb035WT8ejeKMg/wCOykUp03gheNaeTVM3xujUyn7bu9h0iga5cl8oLL4VwbUpK25ePvI/94nAJZs1gaQwgnE3YaabUbMOkVINI/cV1CDKqXlHLjA2XG9IaLq8YFGdsF7iARNywLOhLGbIVAeGeFx0C99qnhCY/bvfWYeltp28I3OzHfQwE1nzyJF6LlspjMYxsnH9umpmfA448iP7sbf0WfrLIucAI2lZNzHSoH/Ta6V+qjD9VTyVrFTk3kIz/THNb2lfcswa8cWKvDDOrgK+MrGfwKtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fAaTZkmK5Z4NYyxaOuFMHZxiguoKYxh/qH/JgnxsVY=;
 b=WhxQuAaCEqQJ2+x1LLMeRbiIQOgckQblOu3frP+2rKU/ayT2nL3aE82RFPKh9UPudEd+2AxMzDERkz82VeONnm/mu6eJWzhNfrL/2ueJEi1FiUOCQ0sLGTQVIIbcu7djR8jdz7XctAju6kb3OcP02ExWHAK8zl41HZZwKr3Jx8EE4I9nd71JimzxsUtKpBkOg0Ukab8NAY3r/VbLyHmaaDOtl6BDvbll/tQR/jIhgjNEM/pUCyNC2Nb2OM8HLdh9XL4mgm06xiLiqd+k6rMDoSvs0e/KZHDfbly63ojLfofvwYMyZu1KUPbEZXkZrBmjJfDqG5qnxfiZmiy1IyQn9g==
Received: from BN8PR04CA0024.namprd04.prod.outlook.com (2603:10b6:408:70::37)
 by SA3PR12MB7783.namprd12.prod.outlook.com (2603:10b6:806:314::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 10:53:56 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:408:70:cafe::70) by BN8PR04CA0024.outlook.office365.com
 (2603:10b6:408:70::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38 via Frontend
 Transport; Mon, 4 Mar 2024 10:53:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.0 via Frontend Transport; Mon, 4 Mar 2024 10:53:55 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 4 Mar 2024
 02:53:45 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 4 Mar
 2024 02:53:45 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Mon, 4 Mar
 2024 02:53:43 -0800
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, "Wang, Lei"
 <lei4.wang@intel.com>, Joao Martins <joao.m.martins@oracle.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: [PATCH v2 1/3] migration: Don't serialize devices in
 qemu_savevm_state_iterate()
Date: Mon, 4 Mar 2024 12:53:37 +0200
Message-ID: <20240304105339.20713-2-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20240304105339.20713-1-avihaih@nvidia.com>
References: <20240304105339.20713-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|SA3PR12MB7783:EE_
X-MS-Office365-Filtering-Correlation-Id: 2060c735-f9ed-4adc-b909-08dc3c396381
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YdFgmc3j3sme/EcwdTObs4nIW/oEf4WxEnyf5NJ3cxgU8dK27H/hlGDsXa1Df1NpqAOXfW8YJLcpdeO4wszcxYmIfEOrMG0OPowuxue6Q0WgLDc9jm3iSsp1/grE+WYR4IAYI2SB/4oLgHTUe2jdnC//XqGc6r5NsYSjdethT1dqvVyIqxBM+tqq7C4/ltjpPO05ow/F98JjR6bvyskB2By4ljYSPo6L2kKU1m+bXlcahnIKR3F/ZaIIlln+VPxg/LSw0jFUBcipjexGEn8uUI+R0eFtgoZVDh36+cBViPpOBYNIhhhYDOBj4HxhwcXITnaxIy8ZOat0EfdYOFi5VINR0Dvtb/IwbjoKUQnBCBgNFq0ncXoYYC+jh+roajDyadn05FpJ1UrRg07KBxE5Fds5TuunsKTJuUtD1+1DdSQRHwmI83D8dopOd74cNcPkVQJ022lfT75mAXDisHQhj/hDNj7hKbiPzTb63madCfP07bWX2kSNEAy1eenJVM4mGNLFImfZDLkvajCOCuD2VXLkoiczOcvWPmBK3ewlo4nF7UOjG71N3uDGrK/S7Z3I/TBvleXgZGLo+EF54IEyLBvYX+u0qMkstMpsr8+jb6Tz9HmOe1LIMcwsHUGIZLRnANN3PJF/nwp3Pajz207GC8edXg5q5yVsNpjdqfDzfStWohGb13TT09VanVi1a+kpCt8w0e2gwBIOXawq8CLQJmARFL/XMR1/iJQp6xr6uGm6W/v4fs1u4NhxbwraY/kc
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014); DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 10:53:55.8141 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2060c735-f9ed-4adc-b909-08dc3c396381
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7783
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

Commit 90697be8896c ("live migration: Serialize vmstate saving in stage
2") introduced device serialization in qemu_savevm_state_iterate(). The
rationale behind it was to first complete migration of slower changing
block devices and only then migrate the RAM, to avoid sending fast
changing RAM pages over and over.

This commit was added a long time ago, and while it was useful back
then, it is not the case anymore:
1. Block migration is deprecated, see commit 66db46ca83b8 ("migration:
   Deprecate block migration").
2. Today there are other iterative devices besides RAM and block, such
   as VFIO, which are registered for migration after RAM. With current
   serialization behavior, a fast changing device can block other
   devices from sending their data, which may prevent migration from
   converging in some cases.

The issue described in item 2 was observed in several VFIO migration
scenarios with switchover-ack capability enabled, where some workload on
the VM prevented RAM from ever reaching a hard zero, thus blocking VFIO
initial pre-copy data from being sent. Hence, destination could not ack
switchover and migration could not converge.

Fix that by not serializing iterative devices in
qemu_savevm_state_iterate().

Note that this still doesn't fully prevent device starvation. As
correctly pointed out by Peter [1], a fast changing device might
constantly consume all allocated bandwidth and block the following
devices. However, this scenario is more likely to happen only if
max-bandwidth is low.

[1] https://lore.kernel.org/qemu-devel/Zd6iw9dBhW6wKNxx@x1n/

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 migration/savevm.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index d612c8a9020..d76d82e7596 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1389,7 +1389,8 @@ int qemu_savevm_state_resume_prepare(MigrationState *s)
 int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy)
 {
     SaveStateEntry *se;
-    int ret = 1;
+    bool all_finished = true;
+    int ret;
 
     trace_savevm_state_iterate();
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
@@ -1430,16 +1431,12 @@ int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy)
                          "%d(%s): %d",
                          se->section_id, se->idstr, ret);
             qemu_file_set_error(f, ret);
-        }
-        if (ret <= 0) {
-            /* Do not proceed to the next vmstate before this one reported
-               completion of the current stage. This serializes the migration
-               and reduces the probability that a faster changing state is
-               synchronized over and over again. */
-            break;
+            return ret;
+        } else if (!ret) {
+            all_finished = false;
         }
     }
-    return ret;
+    return all_finished;
 }
 
 static bool should_send_vmdesc(void)
-- 
2.26.3


