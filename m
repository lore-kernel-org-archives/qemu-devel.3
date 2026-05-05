Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB5FCCD342F
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 08:15:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKAvr-0001HM-U6; Tue, 05 May 2026 04:15:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wKAvo-0001Gx-Ea
 for qemu-devel@nongnu.org; Tue, 05 May 2026 04:15:04 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wKAvm-0006IQ-K0
 for qemu-devel@nongnu.org; Tue, 05 May 2026 04:15:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h7tpSylXFpI0buolvaIIbsVI+6n73dVgWwhKKTTrTXSvZYAX6SqcIcnxPzbhW1Eoz7Zq3Nw6vUpQcmp7bOt5sNQizosyQ+F1HuDKosiX7/AO7XPCNKHcZAkMSqRErxjgWE8IkQPjEYeXhbr75wymBybRweFmX+17c1fYUK8jpThzukh/IDpuudy8VOJ1DeWwBAztKRup5UTDVgCXUfVTKfNaFeo37nRCUR7hYRKUTSvdoBy5lf0N0V7ZblcxJu5Ohu8nC87eMsglTfPXBSoEhuGz+mkYT/ejqe8OnisQtzruZoDmMWgo9+zWuYaqtn0XPtq/jbbeZAJO2WvMvltJCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nt8pslSabHYzzX9uVFR23rbL4otp2/r/BOOjBgnViI4=;
 b=b85sscb/sAPeej+SANK2yaiIws+FRYnX/zg725DM3s61ocXdJW3Z6+t+R7SQohzA7ZdSF2TgblsMt+je3vUkQ9OOt8MZ2Lir+HEPSHWf62F0yZ/2GjmmBBAHBZXpL86odWgdtMnxfvGZdtMRYY2fbkkXSNaclaQxtJ6yF2I/47DCHONPvamvD9w3Y8aPZQQbDEceybghCUOS0HvGLCcko/EURjshXzTsa+Fo9A4XCVZlBIw052CMaxqFJwsXH6gFFwoaq0JAAsELDXlAfsEv1qcnmYsw0BSIF72F0mFWWBhexIcfYCrNny3U3b3mUX7xG+JHoEw30GmC8dtoJxQN4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nt8pslSabHYzzX9uVFR23rbL4otp2/r/BOOjBgnViI4=;
 b=btXIy3vDLC89b4jx+srss4WToH7Rk7aAFWnPz5W0QCv+vsY71M20Ylj6cLxJhtNyj2GBlk+US0WoTDEBWrhKtU2STfE5/qg0xcKElf17VIBDNdR0iK7DBipBfhimc4ELgYZGYbW77OaRMy0yeSXDcZrWYLMgvutqhVtpLC0kEBEv97b1Tg7VFT7gBwUR2xLj1XUr/1p1vwipQ9nE1G38HleMDw7Y2DX8BSLCtgrcfWdtJD/+hxetTGx7txrT/xSp5zS5BAHDDvBTxx947NupPNsSA9fgJMLsG/4xX+arZP/NT7cjGaM/2a3/PIzvMC7lxRCivC9Ksn63q7cyG+F/hQ==
Received: from BYAPR06CA0031.namprd06.prod.outlook.com (2603:10b6:a03:d4::44)
 by DS0PR12MB7946.namprd12.prod.outlook.com (2603:10b6:8:151::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 08:14:53 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:d4:cafe::d8) by BYAPR06CA0031.outlook.office365.com
 (2603:10b6:a03:d4::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.27 via Frontend Transport; Tue,
 5 May 2026 08:14:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 08:14:53 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 01:14:40 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 01:14:39 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 5 May
 2026 01:14:36 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex@shazbot.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?=
 <clg@redhat.com>, Peter Xu <peterx@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Zhao Liu
 <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck
 <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Maor Gottlieb
 <maorg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH 03/14] migration: Propagate errors in
 migration_completion_precopy()
Date: Tue, 5 May 2026 11:14:12 +0300
Message-ID: <20260505081423.28326-4-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20260505081423.28326-1-avihaih@nvidia.com>
References: <20260505081423.28326-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|DS0PR12MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: 73f6cd25-d240-41ec-5a3e-08deaa7e62a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|36860700016|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: kYPQSewQPLE+tlw/PPDSa5aDK4dSxvrdtBoEq1KcQNLzEs9Uj5sxhoRsUP2Ph/x4dMwpH43ID5MRLCPo1+ecujCS3wKk49GLusyVtXK6ig/zk0xLIw807A/7Uw2U1BAzUd8IwIaF49fwN3Q/NxfdtqxYlbdq+I1CEaNw9RP0H50ScUstzN/8Cnzt/APbSSyG6OGHPAB89J/OymIUtKHpK2rq5/Hy4j82rRJoImK4+oa0F1U3XqB9NJ/XIx46svutUlqnmhXdPq5bKhyLbAqJzQvsjgFg6nzyoyeVMyF2LtpdD68G8biZungY83vLCZvDRjOp00X2zgbIleCaW4GA/eIIMFnKK9IBaWZkHgTiTUmgBYbxiwqQNDPwOEOpvop7Kkh6WKu7XOPUGtiuvjjlE0Vl2kfgfUuZHFHUschy61wWMObMADQW8Abv7iyKMdOqmjPoPK6sCf0nedBcnJRyDoXjhsfHGRi+7qbGZSY6pCsSEtH7ZkqlNP91I6G4c6eTev47QX3f1+h127sdOmsZChq9Y7rDb/VxvD4922jjyFjLg3Ek2KsgA4ajA/fFq0NEhBdZC0XLV7nyRZ9UgaqCkMtSxkFnyrPiAikxjNVFF3CBDv0cnbmDDMJlvVMVtn962jrdPqC2j3pKaTKnC6i/fpFEtjxaz+mB3IlgnA9lBzGw0Ugw9eXJP0EN1blRdAz9Tm4ZmwAWWGeRK4CHcrIhoRgfpKhgKePS4ymo2RL22So=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(36860700016)(82310400026)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: C1W4oIxxIhbdNZSsNk/SZ2lVqOS8sPK8NjbeMO0kpGLOqwZ+Rim11U/2YVPCGuF38RndagnPV36EkB3DuxNYw2v8SayvBowX6iWMyfCAyXHcloWbb9lIJ0iKYvu+0MH2IoFU5MWnG1uaSWvxoa5zoqWkt4kCugL5tbHpFDd0O0/VVe7qLdIqUSZuU9fQsacDPNyjbvjbdV2HgQKXyiV3s/V5wItJJqtTKHF5pIe9BKlMqosnrG2Xqx2TtpiVE1zczeCDouPkysJdUeljEKPF1a3nvK+yfWXD8361OXVDpHtaNQMOlz3UpGJMlIG6eFlH1LXBw+iLIAEN8sMFfk9QmhPatmdhXdu9RuB6jocdxyWc/hP1mRAfnKrsQrRcK+aSgeFoRuw2eYT+X+kAnN+BN+0Ce+VYDdSCkBDsETDhZt596k4zipeQdfLXSGvNHDZK
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 08:14:53.0472 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73f6cd25-d240-41ec-5a3e-08deaa7e62a4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7946
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=avihaih@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

migration_completion_precopy() doesn't propagate errors to migration
core which leads to error information loss. Fix that.

This prepares for a follow-up where migration_switchover_start() can
fail on switchover-ack and still report a useful error. Errors from
qemu_savevm_state_complete_precopy() are not propagated yet as it
requires more plumbing.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 migration/migration.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index 6fd89995a2..a5c7ca6796 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2780,23 +2780,28 @@ static bool migration_switchover_start(MigrationState *s, Error **errp)
 static int migration_completion_precopy(MigrationState *s)
 {
     int ret;
+    Error *local_err = NULL;
 
     bql_lock();
 
     if (!migrate_mode_is_cpr()) {
         ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
         if (ret < 0) {
+            error_setg_errno(&local_err, -ret, "Failed to stop the VM");
             goto out_unlock;
         }
     }
 
-    if (!migration_switchover_start(s, NULL)) {
+    if (!migration_switchover_start(s, &local_err)) {
         ret = -EFAULT;
         goto out_unlock;
     }
 
     ret = qemu_savevm_state_complete_precopy(s);
 out_unlock:
+    if (local_err) {
+        migrate_error_propagate(s, local_err);
+    }
     bql_unlock();
     return ret;
 }
-- 
2.40.1


