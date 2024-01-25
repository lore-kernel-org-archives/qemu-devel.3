Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E6CC47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 16:27:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT2YP-0002NT-4o; Thu, 25 Jan 2024 11:26:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rT2YN-0002ND-IW
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:26:11 -0500
Received: from mail-dm6nam12on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2417::601]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rT2YL-0000Uj-A0
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:26:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a57hk3qdsESaUJkHUKIkcbzHuN+BL7i2LeYrEBkxSBGBOdkDryVnBUK3Pi4s3JJzZHtOGLyGLbi5247LeXciK8gd6kKUPKHKgYWzQDTKalshDgLukBDQuwvBirqIRutT6/PCjuaikb/EYWOKMjbvTepWcFROSuV5R1VmshQY5tbhwBaiZGhnm/3R5ljkVFn/EJ7bSNIiTIjK9rwFXGY9bX7fy16dBAcyMpg2WNB3cstMIebt2EMLE7XmGAZnQCY0Iy9OeRDioabmtijAJNoUj0IQXskdD12mExpSQP993gBylOcEjFTggIHewT6K/GPoTvNt7Z5iTF+bSs0kDiYwxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e4sha71HdZUhKHTMFOtP5nR8gdgRaObHZiteRWW3SzY=;
 b=gslR4F/pdgT7L79djA7AiCXDZvw9DLHZzWzYxSsbxQqnYl0bgrurq3j/P8PSBmVdnXTPdRlexyhUkIYpSYAyIOICXfwDg8ni3AqYXsLslu/VwwunDzcQxMQp/9zCzaz+oPDMxvAb2fYPFmbmGODsPGEwUyvqCNxAaL2G0/qZn96e8yPgUa+AcDMVnsYsDOBtCHLKIT+Wf7JV5K6PPikTzOzDh2uukuZzuvY7rU1PJQ7yXA/fvVUYX4IyBg7jvlFqUxEcRJL/TVP2lL7A5ZYA4T/Azm+nkGgeOV4r8pIqBYvUB3EauAXibfZny5CkQH8Q5vz/ad5A/1EKQucnFhJ61w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4sha71HdZUhKHTMFOtP5nR8gdgRaObHZiteRWW3SzY=;
 b=Xx6rvKltuDb+fQeaF6AfZy/7pgxz39tBAZ6NTv524kRd8yUuJosUvZnRx9x+dz0R5z3nKmf//ceHB4/4jgpEKjJE2FN0LJ25seGFqOfxE2QlRF1ZFMTbAt3Bu0jEIJ2jQFjQXjvlKjOHFc72N0m0Lpf41091KKoCmaA5TF6jdoC6XQrysAOt8UGxRA0utvIsPj4n1Mx+9C7Rs1wudIo1EW3WAsJd5xtwhFZoB/fCRYkFwjCbIqnaByvI5SM3tYCvo9D8UcAeDvudArcL93/VXtSy0/PhnFsb8/nhSlKG6yPS8QDk6OK03iHd3icF4iOjAnzIxCeEG8w8W5uz0YbRvg==
Received: from DM6PR05CA0043.namprd05.prod.outlook.com (2603:10b6:5:335::12)
 by MN2PR12MB4376.namprd12.prod.outlook.com (2603:10b6:208:26c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Thu, 25 Jan
 2024 16:26:05 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:5:335:cafe::9) by DM6PR05CA0043.outlook.office365.com
 (2603:10b6:5:335::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.21 via Frontend
 Transport; Thu, 25 Jan 2024 16:26:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Thu, 25 Jan 2024 16:26:05 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 25 Jan
 2024 08:25:54 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 25 Jan 2024 08:25:54 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport;
 Thu, 25 Jan 2024 08:25:53 -0800
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, "Avihai
 Horon" <avihaih@nvidia.com>
Subject: [PATCH 14/17] migration: Rename migration_channel_connect()
Date: Thu, 25 Jan 2024 18:25:25 +0200
Message-ID: <20240125162528.7552-15-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20240125162528.7552-1-avihaih@nvidia.com>
References: <20240125162528.7552-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|MN2PR12MB4376:EE_
X-MS-Office365-Filtering-Correlation-Id: c510903d-c881-4ffb-7fba-08dc1dc2541f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bs4Eel3olKC6ekjTFpeCFoJbBfko00ryiJuI0hRhhzUarUlXkugErjyg8xaS4CV7ohmSqwmRvAjasN7jUcqnjzXHsa5kZJwE8qDtJoj+NBqEoYIuL70u6GAVo/1SAU6zVq/H4zAmLCZ10SccpFrEeStCqof2vAQk8mfQMeu4I4+I0xj5JQ5vWL15pi9PNqUZXx4MatduzZIBmC2JMz6f2j3NVR8DL5o9ABHjDnPl1oAS3+BDfbIVyf9ppNwJGD0cKK+/dgKAp+B4MRC647UNb8s7vP40JduqDRx/tqsXpkvv8vikldMhJ4XwzexJ6+jIg9gbv51LuIU08H/ObbQs3YB11filKzk11EspA3qKnZEPglDaz+IHng5nQAqgE8S7QEJ/1hHUtpUnGFclm5els4A9Tt63v50/4G4x+e2qkFK3M4fFdqoknSb4+QT2pSKXlyo3ojpPtVIBd5jpJ2O64HQOvcqwmQI8/yEBAnP08IbsGmm3yeTADciPtRMBlb608CEkgnON68d+Gtasi8eZldFCXmQDw0dMKcna3c0PlWM49Af2Lcb5sFBoV7AdEmmpNKX/2LpyAdc8j3oJR7NjEy3E/Esr6S2h8vHRBuupTR5XtPXwC0cHN3LO53Anm2MCct0VkPoqp4FrUND5N2mBPkk7hTMiyFCTbG49EYeAsGozcUMClK3pCzawI+HGPPJq0+NwQPmZnXfZAMdXkS8hTUne4mKUNzuW2TLS9lhjoh6Hvftwlt2sRNkRPKLr5iFp
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(230922051799003)(64100799003)(82310400011)(1800799012)(186009)(451199024)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(47076005)(83380400001)(107886003)(36756003)(7636003)(356005)(86362001)(336012)(8936002)(4326008)(8676002)(5660300002)(426003)(26005)(2616005)(1076003)(82740400003)(316002)(70206006)(36860700001)(54906003)(6916009)(70586007)(2906002)(41300700001)(6666004)(7696005)(478600001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 16:26:05.0729 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c510903d-c881-4ffb-7fba-08dc1dc2541f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4376
Received-SPF: softfail client-ip=2a01:111:f403:2417::601;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
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

The following patches will add a new API to create migration channels
with the same name, so rename migration_channel_connect() to
migration_channel_connect_main().
No functional changes intended.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 migration/channel.h |  6 ++----
 migration/channel.c | 10 ++++------
 migration/exec.c    |  2 +-
 migration/fd.c      |  2 +-
 migration/file.c    |  2 +-
 migration/socket.c  |  2 +-
 6 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/migration/channel.h b/migration/channel.h
index 5bdb8208a7..1e36bdd866 100644
--- a/migration/channel.h
+++ b/migration/channel.h
@@ -20,10 +20,8 @@
 
 void migration_channel_process_incoming(QIOChannel *ioc);
 
-void migration_channel_connect(MigrationState *s,
-                               QIOChannel *ioc,
-                               const char *hostname,
-                               Error *error_in);
+void migration_channel_connect_main(MigrationState *s, QIOChannel *ioc,
+                                    const char *hostname, Error *error_in);
 
 int migration_channel_read_peek(QIOChannel *ioc,
                                 const char *buf,
diff --git a/migration/channel.c b/migration/channel.c
index 4022b2c9b8..c1f7c6d556 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -55,22 +55,20 @@ static void migration_channel_tls_handshake_main(QIOChannel *ioc, void *opaque,
 {
     MigrationState *s = opaque;
 
-    migration_channel_connect(s, ioc, NULL, err);
+    migration_channel_connect_main(s, ioc, NULL, err);
     object_unref(OBJECT(ioc));
 }
 
 /**
- * @migration_channel_connect - Create new outgoing migration channel
+ * @migration_channel_connect_main - Create new main outgoing migration channel
  *
  * @s: Current migration state
  * @ioc: Channel to which we are connecting
  * @hostname: Where we want to connect
  * @error: Error indicating failure to connect, free'd here
  */
-void migration_channel_connect(MigrationState *s,
-                               QIOChannel *ioc,
-                               const char *hostname,
-                               Error *error)
+void migration_channel_connect_main(MigrationState *s, QIOChannel *ioc,
+                                    const char *hostname, Error *error)
 {
     trace_migration_set_outgoing_channel(
         ioc, object_get_typename(OBJECT(ioc)), hostname, error);
diff --git a/migration/exec.c b/migration/exec.c
index 47d2f3b8fb..043fb3f14d 100644
--- a/migration/exec.c
+++ b/migration/exec.c
@@ -89,7 +89,7 @@ void exec_start_outgoing_migration(MigrationState *s, strList *command,
     }
 
     qio_channel_set_name(ioc, "migration-exec-outgoing");
-    migration_channel_connect(s, ioc, NULL, NULL);
+    migration_channel_connect_main(s, ioc, NULL, NULL);
     object_unref(OBJECT(ioc));
 }
 
diff --git a/migration/fd.c b/migration/fd.c
index 0eb677dcae..9d3ff249dc 100644
--- a/migration/fd.c
+++ b/migration/fd.c
@@ -39,7 +39,7 @@ void fd_start_outgoing_migration(MigrationState *s, const char *fdname, Error **
     }
 
     qio_channel_set_name(ioc, "migration-fd-outgoing");
-    migration_channel_connect(s, ioc, NULL, NULL);
+    migration_channel_connect_main(s, ioc, NULL, NULL);
     object_unref(OBJECT(ioc));
 }
 
diff --git a/migration/file.c b/migration/file.c
index 5d4975f43e..60cdaead1e 100644
--- a/migration/file.c
+++ b/migration/file.c
@@ -57,7 +57,7 @@ void file_start_outgoing_migration(MigrationState *s,
         return;
     }
     qio_channel_set_name(ioc, "migration-file-outgoing");
-    migration_channel_connect(s, ioc, NULL, NULL);
+    migration_channel_connect_main(s, ioc, NULL, NULL);
 }
 
 static gboolean file_accept_incoming_migration(QIOChannel *ioc,
diff --git a/migration/socket.c b/migration/socket.c
index 98e3ea1514..c55129dc9b 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -106,7 +106,7 @@ static void socket_outgoing_migration(QIOTask *task,
     }
 
 out:
-    migration_channel_connect(data->s, sioc, data->hostname, err);
+    migration_channel_connect_main(data->s, sioc, data->hostname, err);
     object_unref(OBJECT(sioc));
 }
 
-- 
2.26.3


