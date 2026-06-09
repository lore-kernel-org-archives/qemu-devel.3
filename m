Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73197CD8CA7
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 08:02:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWrPJ-00065L-1g; Tue, 09 Jun 2026 04:01:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wWrP6-0005oU-MN
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 04:01:47 -0400
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wWrP5-00054R-25
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 04:01:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UchLnEiTYJBxrxO109zPuOfrPVnDDRxU9TT9+a7j/dThJsujA326/vP51eBG/5qrHwhNDZdDSVF+u+BGXs7OGkJlZxKlbQX/Iu3pWmL+CXn0cQUXyTNYwCWmPd4ENBHVjaxOjGq+Ly7aJ56A5aqP6yNtk7qtid4Y2Owk/UIkTG4qhYwTb3qqqHfuEBGxwEgfo1idPouxxm7fsu4zN7kMKxYjctTzuW968WTyYw3JOtpUCYQ6Vd4i0/0qst+MWhPKWdPitmANVtpMe3ZUcbv+dIOLu70ANye+ciot2+QgnOvYuJcTpwG3Rjp9hVgK1rsVC4ZIoM8Ek2xzJkVNUjbXsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XOZfBibeYzQV6iqoNNH9pw0B7WARl9iQHYdwfCcgRi0=;
 b=wwAWRWrUuw4JlMpJ5XVfv4tfyKO8ULN9TmjM0z3HA09KONUntg5dUDXF3WE6TQ9XyF+1Aqw129uqF1+zoc4QvyQO3U9AqxhdV4C24V259I6g1DrZmpfVxavNYwLGPVcQVpGgeYCt2aGGxXzyFnMrih9lDCul5u2bsGqjjFYeVou+ubYFFZm6hdP96XuUTOsrk9zEv8afG48lm/CgyFrcs2eVDURwIkXdXdONeaA41sF3IoDegbE61D3M4W86Dm/BMkOiU8hNjNie+uHTt3TKH7ZEr5otKDeefFNWvCZFU2MFMf9HATYuiD8KV0oRAXeUkP6J3aEiIGNGuAoPqgFQrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOZfBibeYzQV6iqoNNH9pw0B7WARl9iQHYdwfCcgRi0=;
 b=MJWE/Pe1WpThDPAM5FjFvx3uh65X+U1WwDHpirupMONF/kN3Kztzd6uQu7WkAqAXNfeXwGkSNOxJipqFcn7qUdtIppqET/J4VHEI0nHatgqIoA6Y38g+rYmBtJFy8F9cvz43CuWDOaH7RqA7JYAnLyXha/DX/z2IbomGJRut5FsdYx0uL9ULrGGOai2+tQ24XXtcSllh8SB36yJQy7WPRZst6nXTsSzAyHfU4L8gdE16r3pyAQSX1cF03XEOqfZx61zPkdeGRIsXCJI8rKdz3NsulKZUkEzgLiftdN4+ZgDgVt90lz7Eqj/AtwJWdRYafMgiedjEB+uyDPk1h90bxg==
Received: from MN2PR22CA0009.namprd22.prod.outlook.com (2603:10b6:208:238::14)
 by DS0PR12MB7850.namprd12.prod.outlook.com (2603:10b6:8:146::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 08:01:34 +0000
Received: from BN1PEPF00006002.namprd05.prod.outlook.com
 (2603:10b6:208:238:cafe::6d) by MN2PR22CA0009.outlook.office365.com
 (2603:10b6:208:238::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.13 via Frontend Transport; Tue, 9
 Jun 2026 08:01:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00006002.mail.protection.outlook.com (10.167.243.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 08:01:34 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 01:01:13 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 01:01:13 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 9 Jun
 2026 01:01:07 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex@shazbot.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?=
 <clg@redhat.com>, Peter Xu <peterx@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>, Zhao Liu
 <zhao1.liu@intel.com>, Halil Pasic <pasic@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, Jason Herne
 <jjherne@linux.ibm.com>, Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 "Cornelia Huck" <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Vladimir Sementsov-Ogievskiy" <vsementsov@yandex-team.ru>, John Snow
 <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>, Maor Gottlieb
 <maorg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH v3 13/14] vfio/migration: Check VFIO_PRECOPY_INFO_REINIT
 during switchover
Date: Tue, 9 Jun 2026 10:58:11 +0300
Message-ID: <20260609075812.32067-14-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20260609075812.32067-1-avihaih@nvidia.com>
References: <20260609075812.32067-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006002:EE_|DS0PR12MB7850:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bb3b85f-16a0-4937-06ee-08dec5fd5327
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|82310400026|36860700016|376014|1800799024|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: poxK4Bh+TXZ+zbyFesq5xkpjvA2H9xCAPC5ViTVyTc4oAyyZRY8JU47o3PDfDiNRDDROftetM7h/EHbY0EhF5tOtrwF0W3drE0HkuOpEk1c4FW1TPeEoVp0ikJea01axCau1Krzw/PppeNU3unjAauITdeT6M2iCBWaZMjMLTSwuhczOmJBx71oqVA0rK6/G/v28IU993hOgLiS/jCbZKiLYzHf0ah+F5ILJYoAGbBMHBjbRSZyN3DMmqsqqCY0zoUD+gauUMfffAh5xN/EhmqU04EzGjM+R0rdV/Mkn8BmPzSXRnGa5IL07wbld/H+pKVhKe4IavxZz+i61EQnaL4HH7AXEFoLgDwkKWjFsrDttC73bwjD2SzDhdQP5kWcJQucP+vKm0Gut2pR70MPU4I/EFa+x/vmcH/+tA4MnMsUJxhl9ar2tgB4rcBwMz1NUfRp1NpusZf8SG2BcQNjmmIDtKzWeaE/ozvNOfYtBiZODylPKqT3igvk1tOtIMBYb+f7FYHOrjOJ5JDpYaZqZicBGGm63FODbskOKf6PKG9djhkxSTyRkAyqSiRxbNUn/nifSr/ye2K9eNSYpDqhVYIT9FURt4YJBwGqqmLXRU0ZP1iWebcprMFCIvnmhgPTvCkH8gO/wSD8oE1kuP+JyQYqomAWuA9N1lO3BmIvnedjmIEHeFZMdPFLIc82fvgFxYZiWDrVF7A6g8wO21lO4bEoBOoy0efDP16H5lU7JNGs=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6gBo10EQz0veOLcdymk0KmiIQqwr1jwIlT93d5ZmEdULNjxO4orpdX7eekiNaDCXT6SgWS1YPgFYa9Hh6H6b4kNIwlTbSuR0DagbnSOayYuSvnix8jvsz5aap95AEvMIUt2E+gxVRRLhlMVH+J3h0xkNgCH+E7T3bEQkfR2Do6K5e+oJI6erGyhK+FrLx0Ski692lNZaZow9lfIBeAQGBhmnu1ijTqrKqj2ezPqnDMbwl0zzn3Tid7+kN5OrUgJrNuaoeQFzxM22hSvW5LLrMFGAdmfbnNBwiO1Az8eH54QNwdX3DMP1hB57eL6zLY3/LtIG8l4ELlCKZN5amehDn1vWvbUYNOBayYNyGCXoRAKBx/yNPnwRlwX5nMH1AaYL8sKuAAHs1mqfqFcYGGAOOHi2WQsr8wMt0hkJcShMkCDnpdQKC2fwy8Q4fWvwNlGt
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 08:01:34.3789 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bb3b85f-16a0-4937-06ee-08dec5fd5327
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006002.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7850
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=avihaih@nvidia.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

VFIO_REPCOPY_INFO_REINIT is checked only during precopy, before the
switchover decision. However, the switchover decision and guest stop are
not atomic, so a VFIO device may want to set VFIO_PRECOPY_INFO_REINIT
and request another switchover ACK in the gap after switchover decision
has been made but before the guest is stopped. This would be missed and
may increase downtime.

Solve this by checking if VFIO_PRECOPY_INFO_REINIT was set during that
gap, and request a new switchover-ack in the final save_state_pending
call. Query precopy info after vCPUs are stopped but before
transitioning from PRE_COPY state, when its valid to call the ioctl.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 hw/vfio/migration.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 1e172dd10b..73c49d8c24 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -685,6 +685,9 @@ static void vfio_state_pending(void *opaque, MigPendingData *pending,
      * The final pending query runs during switchover downtime. VFIO does not
      * need a fresh device pending-data query then to get the latest dirty
      * data, so avoid the extra work and report the cached counters below.
+     * On the other hand, precopy sync is needed to check if switchover ACK was
+     * requested, but that's already done during guest stop when device is in
+     * PRE_COPY state.
      */
     if (exact && !final) {
         vfio_state_pending_sync(vbasedev);
@@ -964,6 +967,26 @@ static const SaveVMHandlers savevm_vfio_handlers = {
 
 /* ---------------------------------------------------------------------- */
 
+static void vfio_final_precopy_reinit_check(VFIODevice *vbasedev)
+{
+    VFIOMigration *migration = vbasedev->migration;
+    int ret;
+
+    if (!migration->precopy_info_v2_used || !migrate_switchover_ack() ||
+        migrate_switchover_ack_legacy()) {
+        return;
+    }
+
+    ret = vfio_query_precopy_size(migration);
+    if (ret) {
+        error_report("%s: Final precopy reinit check failed (err: %d)",
+                     vbasedev->name, ret);
+        /* If query failed, assume reinit and request switchover-ack */
+        migration->request_switchover_ack = true;
+        migration->initial_data_sent = false;
+    }
+}
+
 static void vfio_vmstate_change_prepare(void *opaque, bool running,
                                         RunState state)
 {
@@ -977,6 +1000,15 @@ static void vfio_vmstate_change_prepare(void *opaque, bool running,
                     VFIO_DEVICE_STATE_PRE_COPY_P2P :
                     VFIO_DEVICE_STATE_RUNNING_P2P;
 
+    if (migration->device_state == VFIO_DEVICE_STATE_PRE_COPY) {
+        /*
+         * Now that vCPUs are stopped, check if new init_bytes are available
+         * since switchover decision, to be reported in the final
+         * save_query_pending.
+         */
+        vfio_final_precopy_reinit_check(vbasedev);
+    }
+
     ret = vfio_migration_set_state_or_reset(vbasedev, new_state, &local_err);
     if (ret) {
         /*
-- 
2.40.1


