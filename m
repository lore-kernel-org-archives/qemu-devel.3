Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B4AC48260
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 16:29:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT2YK-0002LH-QF; Thu, 25 Jan 2024 11:26:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rT2YI-0002KH-RO
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:26:06 -0500
Received: from mail-dm6nam12on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2417::600]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rT2YF-0000T4-O5
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:26:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LiAcFwp88yrzx3DqWf/E94MfpxFn6rRev3Nhmi2OI9aQ0D+xG7VRwDEXo4ps1/5tPnQavBUXS8dYIPhc8YoMhUjZuEBuiE5o1SBfLzhvCSyYwIfLD9S8tqDzDaZYIleZ6gdBD/5/EqnqdEZcn2NcMMgYSHSV7TY7QQ3bilNob7OlIYaJ/+iBJtptgicYBVolQZQbLux4Q2QOhasNllim3C6G2s0mUTjHV/azuJw/FUu3TI6iaWhxyhuKJN1wdGXjrYPAt/S/pyYeeSgNPwf7/N2oI5NYHtZnwCvjMt9wlHaL43gZxDEpddKYk9rQVl6sjc2Vsr/SI1LnAUQBgsO27w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ba7dWjEyzyQAOMj9XAhXFtUmuD9yH6itYapvDIa1+To=;
 b=JAPVdFxECBuWdVXuucfaRgAwkyBUbRiCR1/XH8leOL4Dq3ltGdP1vFAF4T5+RFjMuJAEKLC9PVA4o7iDal/zqtMswDFBVThG+vboLEAQ4yJVaO3Vql5syqYmeCT7z5nvjuWEIB8k4Q1p5d3tB9cGmO0moCrM1R7UX+uIutuMHRWhnYCzWGcmXFelkcMQB4sFMV3quMlKRpWLmAaTKzFAjJQ3ShbmfBjoZ3LN7wf05x/520NQfKrx1QqTwRDHVJHow3GxjS1nBuWMjZMZqI3L5hPiu3iw2z1qj4wn/Hd+BFgrrmZtfsV9IjzNoGfiuyEjfUfFr1rUIXhwqMh132PRYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ba7dWjEyzyQAOMj9XAhXFtUmuD9yH6itYapvDIa1+To=;
 b=BrsqJawmlSAlgpl5JwwZ5sApgm8dE09YwYwUQrhyyiBJ9Pz1LxoG3YrEEUk6x0litMqetVKFV2n6PBroNotZ+NsJEYraxWyCJ6FjYFXkDkbp7pTghgphNrjIeUg+k2tMZBE4KoLHf7kfOzhLN1rTVgr5IeTBMDQGp3Mr/B9hWqui+RQs3EB6DmivsZUGJu0g1kouKSVaM01ODdiNLHIwcR5vXfw1rtw8jNpoFYcuRUvtLix9PcYpd/8fMYB5Wi4ldlv8kubsI4bNgUMB4paXKSD6yon+CuCgrNSufHpBr9Ygb65RRLW73tv0GPLZmZuNdGLuk4KV61wVLbHSl+TgcQ==
Received: from DM5PR07CA0065.namprd07.prod.outlook.com (2603:10b6:4:ad::30) by
 CY5PR12MB6130.namprd12.prod.outlook.com (2603:10b6:930:26::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.27; Thu, 25 Jan 2024 16:25:58 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:4:ad:cafe::72) by DM5PR07CA0065.outlook.office365.com
 (2603:10b6:4:ad::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26 via Frontend
 Transport; Thu, 25 Jan 2024 16:25:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.16 via Frontend Transport; Thu, 25 Jan 2024 16:25:57 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 25 Jan
 2024 08:25:49 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 25 Jan 2024 08:25:49 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport;
 Thu, 25 Jan 2024 08:25:48 -0800
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, "Avihai
 Horon" <avihaih@nvidia.com>
Subject: [PATCH 11/17] migration/tls: Make migration_tls_client_create() static
Date: Thu, 25 Jan 2024 18:25:22 +0200
Message-ID: <20240125162528.7552-12-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20240125162528.7552-1-avihaih@nvidia.com>
References: <20240125162528.7552-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|CY5PR12MB6130:EE_
X-MS-Office365-Filtering-Correlation-Id: 62a66719-4f3f-4f95-14d4-08dc1dc24fef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vPh7GKbpWsvjzGn/iIfd/2SVrjnfyC7ABgTlw7RIlmV1YDxPE3Nbj4xefTJDCC6eDth+vWPJTOp3HdEQk+6aNGDVnCGFSHJEGMQVwQmqeAxCT3cSW/lu8VgJ6tsfzFO4T0S+Snf+GA0p0m9vJPsMn+xW4T+yU3jAwGe7I65xe/jauqbjHb+KmkNm9Xs022gn+oQWeihiO8R8C6clEOp9eAJX7poHazM6EPVdXX7AqqQf3cCSUEy25vbPI2z/QRwMKRLrUBOCKyA57UoRb3QWnVa8a+BVwenY+FQJIk7/y5k3Lg2bwVOb1FnIGP24XKVy6YA8ZIvWr/BxboGFa41U9Ttwh9jvNL2q5v47JgOOHkn2WgAtgbkn3g3CdqiLBIIxJneSDWDWLLAYzv/+2ruRszwxekkokwjFtWWJbZFH2JwxuykbAr9jXV4gDuBkLrQflLcSSBvleULf3gqlgbJPmj6uLn6yFyROul77t48kFuWWJdP6evxF5W8U4gW9npIsRg3kVpmx7P11aaG6V//u2cOX+BtXrtOEaC/VuDEv/BLd8T4Xrdes23nJTdU+te3rkbkNaqq69cqWPrVncWJf4M0zbMoKtzKT8sR+lF7DqMNA7LQlt4UeJj9FQkPObu55MLcfwdZ9e4zsu+zjYReI9j7M4Lgqpj9qFt72obwjUoQF2O5rxsgBn0FDCrbWttrH75swt2N5vaKn9lajt56eD5BwGpuHhhjfsYCmDbZbIQTXNl5NXe3tWuYC5/UmRvaXm2Nu5wUpGVx6B0avLuC4vUWdd+gx1BQhEsrbVKNkcag=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(346002)(396003)(136003)(230173577357003)(230273577357003)(230922051799003)(186009)(1800799012)(64100799003)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(336012)(40480700001)(40460700003)(41300700001)(4326008)(36860700001)(7636003)(426003)(356005)(82740400003)(107886003)(2616005)(70206006)(6916009)(54906003)(1076003)(316002)(70586007)(83380400001)(2906002)(8676002)(26005)(8936002)(6666004)(86362001)(7696005)(5660300002)(478600001)(36756003)(47076005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 16:25:57.9666 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62a66719-4f3f-4f95-14d4-08dc1dc24fef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6130
Received-SPF: softfail client-ip=2a01:111:f403:2417::600;
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

migration_tls_client_create() is not used externally by anyone.
Make it static.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 migration/tls.h | 4 ----
 migration/tls.c | 2 +-
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/migration/tls.h b/migration/tls.h
index a6babbfa14..87a79b4102 100644
--- a/migration/tls.h
+++ b/migration/tls.h
@@ -28,10 +28,6 @@ void migration_tls_channel_process_incoming(MigrationState *s,
                                             QIOChannel *ioc,
                                             Error **errp);
 
-QIOChannelTLS *migration_tls_client_create(QIOChannel *ioc,
-                                           const char *hostname,
-                                           Error **errp);
-
 typedef void (*MigTLSConCallback)(QIOChannel *ioc, void *opaque, Error *err);
 
 /**
diff --git a/migration/tls.c b/migration/tls.c
index 99c71e4fb6..8f427ecc98 100644
--- a/migration/tls.c
+++ b/migration/tls.c
@@ -97,7 +97,7 @@ void migration_tls_channel_process_incoming(MigrationState *s,
                               NULL);
 }
 
-QIOChannelTLS *migration_tls_client_create(QIOChannel *ioc,
+static QIOChannelTLS *migration_tls_client_create(QIOChannel *ioc,
                                            const char *hostname,
                                            Error **errp)
 {
-- 
2.26.3


