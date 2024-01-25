Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7143DC47422
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 16:26:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT2YK-0002LK-Rh; Thu, 25 Jan 2024 11:26:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rT2YJ-0002KR-7Z
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:26:07 -0500
Received: from mail-bn8nam12on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2418::600]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rT2YF-0000T3-Pn
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:26:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TwI5RxOMEbA3u16IPv+rS86uE4qwl6g5VgO7c/VYQzgN+8YKSZprbMmFtbXC8Py+mBJUy18Px1C9kT6mmtmwzkIXBkromTjPGZsR29SNFEpcG0C0T7dJcd7WwlmFHYrGVJjBPtMhS7zmUjrmGxVAfc78bMm90qUCrLNMIkgHSKehzlkG/VohZDYj3keROK6yIhm0+sa0XBEUlCqrG7bwVnwMRGy7W4GyhctrZXSWNGZ9P7yVWa5sZHKodsklvEm6cml2k8EgRWsLWbfmDGHBPiYtX5XpvY1EjW6eYRtb7LRT04yhecmGpWqOFTDiznFckFRYp3WKpXxYbVmJhiHpgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Ocf0sCT8Krz5mSRKDRKw+1vkobmMVkdNjftn0d7hY0=;
 b=XVFtz+4d4iKx1wlazdTXHKIGqCy3Q4f0IVMtk21RW736yjyldYSERNdG8IWJbEBSiZJzgTrnlU2536cUR9C8DyaHQSS0TeSYGocZz5Ru7KASRscEmhAkECqTA73DXvOnny49css+A806MXRAK4hw8DowSWMNMyAOfrE9K2V0Ey+IhZ5cg1Q5WxTjRVZpkwYHouf+QHkOF9rRVaB4bVRyW0DXrMCqP6ceUiiA6qic0wz30qZ72mTDcgFUT5iYFets0RXMH9yjQSSDUFzAWcUHYeznovGeQFjYIvgnMDHKFEf7snWObZ0jGRwof+OD5uzm4VWVco8G3w6HlDlQ4U6XNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Ocf0sCT8Krz5mSRKDRKw+1vkobmMVkdNjftn0d7hY0=;
 b=iIJHSZANvH6fXVGb9cj0Q6Ica6MQbwIkZuY8u3gxZRrkLvHCtkkQ0+pSQz5EhPSkfzjmirs86omi8BJbllKDyi8b95AjxnGOe2vSmLyeBXh2VJxfN6Dvcwz5huOxQC4Wg2UzyecQJdkmwPjMECKngEIdpQuTzUondHZ95ME10Gwlv18Fpc8grkFIliTFgwhi63alNrXeqHt77o82eTWLa5odAb1+sqbuz02ccLGgyeQ8REw8s+qiF6y850a0NQimG7uUYVrvqnEKnioZ7iT4mjq6cPFiX0QypZ9StCRLRTlf1a4nJ6vnodbFkLthQU9SkvbDv0/0ySFIvSdbaU0kUg==
Received: from DM5PR07CA0069.namprd07.prod.outlook.com (2603:10b6:4:ad::34) by
 IA1PR12MB9063.namprd12.prod.outlook.com (2603:10b6:208:3a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Thu, 25 Jan
 2024 16:25:59 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:4:ad:cafe::92) by DM5PR07CA0069.outlook.office365.com
 (2603:10b6:4:ad::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27 via Frontend
 Transport; Thu, 25 Jan 2024 16:25:59 +0000
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
 15.20.7228.16 via Frontend Transport; Thu, 25 Jan 2024 16:25:59 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 25 Jan
 2024 08:25:51 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 25 Jan 2024 08:25:50 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport;
 Thu, 25 Jan 2024 08:25:49 -0800
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, "Avihai
 Horon" <avihaih@nvidia.com>
Subject: [PATCH 12/17] migration/multifd: Consolidate TLS/non-TLS multifd
 channel error flow
Date: Thu, 25 Jan 2024 18:25:23 +0200
Message-ID: <20240125162528.7552-13-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20240125162528.7552-1-avihaih@nvidia.com>
References: <20240125162528.7552-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|IA1PR12MB9063:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f592ccd-9e66-4184-e4cf-08dc1dc250a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XXKpo0cbSopFMgmCISfUo7BxtAoceIXl9AFKcp0R942csLL0zd1dLha4c3eMgBd0L5BXahyLrhxyRFcswd+UTS6m+PeyfSwRrLL6CY2Lr2OLu/SpwoIzdG2Gvc21duRunb+KSPrJBajq0vKHLkAsEM8kRsj2prk4ZyL4Ha/m4qwhQrGP9NxPlzO7f0bwd0v64H5Z2LLnk4H5rLibc+tzBajeTL85SsTdK4tBZc554uzVTlgAlPB6grbS7lX7Jx6gqLrW5bE8tmjCIwdlbDW6WK6RAe3lq8WKJr3Gm10jhdi76ysa5biu2FNjF6QkfKftCF6195KNNZQzLH7Q6nnV3p0Z0st47NiXG+4xjrNRKffB04KYs7LV5XH8/DYCBeLm5aeoeqknT99Ztt+BdUVPhfTQsoz9h320UD9gmjtJMkogFd2zks9S5l18DGeBVsqjef1f+sByLDbpJv3NvxvBQ0GQCfE68db74fJCGYDfVfzsY8YAwizLuC+R+EvaU2FhXTh76K98zWebgbfyF8RQO1PPNpbLv4nIopQBVnpCfuP3+vXSd4OTo0io3hxpGBULXI4mg+DEThha4qrvvTWH+b22bJqNO2x8mdu0dYL3uf2fAdRWrVaGDzkBRbbHFhx7doNuODr227ULc1yXN0LQsxU84AcdulmjXrznv/VQFFO2eHHEhD1CbSD0dV12uQgehuZPVTbqIiB05gtg1PBtsrpub7HGTQPFKKvrnVZBUfntVsqwrSxaxhA99I/mY0fj
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(376002)(396003)(39860400002)(230922051799003)(82310400011)(64100799003)(186009)(451199024)(1800799012)(46966006)(36840700001)(40470700004)(36860700001)(83380400001)(4326008)(8676002)(356005)(8936002)(82740400003)(86362001)(41300700001)(36756003)(2906002)(7636003)(47076005)(54906003)(5660300002)(316002)(7696005)(107886003)(1076003)(6916009)(40460700003)(40480700001)(70586007)(2616005)(70206006)(478600001)(6666004)(26005)(336012)(426003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 16:25:59.2009 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f592ccd-9e66-4184-e4cf-08dc1dc250a1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9063
Received-SPF: softfail client-ip=2a01:111:f403:2418::600;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
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

The error flows of TLS and non-TLS multifd channel creation are similar
yet they don't share code. Consolidate the flows by using
multifd_new_send_channel_cleanup() also in TLS error flow.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 migration/multifd.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index f4d8cd0023..cc9a1182fa 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -794,6 +794,9 @@ static bool multifd_channel_connect(MultiFDSendParams *p,
                                     QIOChannel *ioc,
                                     Error **errp);
 
+static void multifd_new_send_channel_cleanup(MultiFDSendParams *p,
+                                             QIOChannel *ioc, Error *err);
+
 static void multifd_tls_outgoing_handshake(QIOChannel *ioc, gpointer opaque,
                                            Error *err)
 {
@@ -805,17 +808,7 @@ static void multifd_tls_outgoing_handshake(QIOChannel *ioc, gpointer opaque,
         }
     }
 
-    migrate_set_error(migrate_get_current(), err);
-    /*
-     * Error happen, mark multifd_send_thread status as 'quit' although it
-     * is not created, and then tell who pay attention to me.
-     */
-    p->quit = true;
-    qemu_sem_post(&multifd_send_state->channels_ready);
-    qemu_sem_post(&p->sem_sync);
-    qemu_sem_post(&p->create_sem);
-    error_free(err);
-    object_unref(OBJECT(ioc));
+    multifd_new_send_channel_cleanup(p, ioc, err);
 }
 
 static bool multifd_channel_connect(MultiFDSendParams *p,
-- 
2.26.3


