Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A0C8E909C1
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 15:31:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsN2l-0005o0-6F; Tue, 17 Feb 2026 10:31:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>) id 1vsN2X-0005hP-TX
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 10:31:10 -0500
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>) id 1vsN2K-0006x2-Mh
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 10:30:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h0jJ5N/nQHo2XrzpScs+2BzfQeL2pe2ISacImIeCARevzQOg+abSD9WlKI5FzF6SbFGEUxBObEt4c2+QuvS4UoqC46i8LBiz4MfkjeeXiJtw02tCk3TljUVOpoLII99MjdXDbTIsBfJxBlrVXr0MJlh8hzvYa3NcxDphSHHpSV37BvJQb3/+eVaxQEpCEebFfGEnN8ppkNhzZ5YZPli5KspPE7QkR9xXxTn94D7H6v91a0jIDyhw/V+MK7ycVcLoyfOeZvRAf63tndwsOxjLoCr4i7nFmVdIkp15EbnWHh4A2tUXqLl9GxMSMfa60vVj2Mv58YrDUftU+VI0YmR8Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MDqQBjjl33lfr86RHxlEYIwhIrv/kGfk84dVRYtf68M=;
 b=J4Fd1XI8tq2pQPbFntUUyYSqO+XpROmT0OASweF5liUgRg2WyrofpRsZxf5pEMvLD1Q5V5bdvbNjd7hAkj9Vw9g6FnMKi5VoWawN3xBDXJWZnpuxTGzeSszAUAe4wjLSdFqzQ3+Px5SsNC3tqNe6OJb6rLFp/CvUgam9/bu7MqDKh63FgefdBF7zo8tNdIYK6he/vK8e8fDTkNeHNh37fQMdghenFoLrotR3C9PQshGmq6BCGM7nBM8oWCl2gghYyfB5jx+N9svMKeSfzcafBRPfZ1pR/88GU4ysDWFw+MPDE6WjXDwpeblvq0XHR4qsPI0QgP0g+NdpoVfbPBeNqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MDqQBjjl33lfr86RHxlEYIwhIrv/kGfk84dVRYtf68M=;
 b=hdKOVpcL3FN34815hJa/FcKCl//vui6w4YTwKBwoo5BhWQic5lTSrw06FaZnbQSzm1NxSFyGs+se2cgaz1FeEvm3sfIN6GTPOLlMmC6SPdqzWsi/1MpfEd778JC7xwXqfO8mGGeVjuvhM9m1kYRPsBy6POJCBMdyEOX3NrJ4EtPWIm2EOwW/X+2VMMTCzpM9CDZszaWYPIfJze4X8pivvhWyXAGbdEsLwpOFWG3YWSE4XVBA9hi6xvCFnnEJVtSyzh8bm12yUJNeuQQdzLYpTGc5VIGcbA5DX85RBxkFct5TRiL4oOgN5AcXqoK5k/qDqpCMuuyJnUb9VvbzbrEdHQ==
Received: from CH0PR03CA0367.namprd03.prod.outlook.com (2603:10b6:610:119::24)
 by PH7PR12MB7353.namprd12.prod.outlook.com (2603:10b6:510:20c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Tue, 17 Feb
 2026 15:30:36 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:119:cafe::b7) by CH0PR03CA0367.outlook.office365.com
 (2603:10b6:610:119::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Tue,
 17 Feb 2026 15:30:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 17 Feb 2026 15:30:36 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 07:30:13 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 07:30:13 -0800
Received: from localhost.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 17 Feb 2026 07:30:12 -0800
From: <ankita@nvidia.com>
To: <ankita@nvidia.com>, <vsethi@nvidia.com>, <jgg@nvidia.com>,
 <skolothumtho@nvidia.com>, <alex@shazbot.org>, <clg@redhat.com>
CC: <aniketa@nvidia.com>, <cjia@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <zhiw@nvidia.com>, <mochs@nvidia.com>,
 <kjaju@nvidia.com>, <qemu-devel@nongnu.org>
Subject: [PATCH v4 2/3] vfio: Add Error ** parameter to vfio_region_setup()
Date: Tue, 17 Feb 2026 15:30:09 +0000
Message-ID: <20260217153010.408739-3-ankita@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260217153010.408739-1-ankita@nvidia.com>
References: <20260217153010.408739-1-ankita@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|PH7PR12MB7353:EE_
X-MS-Office365-Filtering-Correlation-Id: 901112f4-e204-41cf-bdcc-08de6e397f58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?q082Cmjj9Q012QlUZctg6Zoa2uamCP46QAmmj42cFCZ0jg9f4N0JUSgcAyyE?=
 =?us-ascii?Q?zBw4wz2BHFHF+378HpyklTr1FqbRLB66b/sjib2+K4rZ5t3tVxDhz+ou4Fm4?=
 =?us-ascii?Q?eJWSmpsNjiUUjc/STbj/XKKZjvmtR+jhxhh7OvKI0Sp8C08peosF9iA9PSsS?=
 =?us-ascii?Q?FSkcAezjZu6iitZzMYaT30V4LxNj6TzNm/mPLKXsTbkWbz5Yz5hIzPIihk2F?=
 =?us-ascii?Q?gvMPG/arV+JINGreNHiM+mht6z/76/rxSMomdfq07Z4dIlmw40ldeJKxyuFb?=
 =?us-ascii?Q?9ybS4ZuidHvmANckbWfshD1Wg6R0+lsqeN1wLg6s78jJabNrpDP/GchOCY44?=
 =?us-ascii?Q?zCRAGt3TYj4DL5mrB3mhaAz7Aj+d4IX+M31yoeQEpLLGdDEkmmd+N+24Uw1R?=
 =?us-ascii?Q?AOVRlVXxeCIIWvtSXtrFv4lqJRIkI+1juH8CnF0T8/uRCegVwnDPm6JwKqeX?=
 =?us-ascii?Q?NsAEmf8C8R9LwtNSkPd3fxC5eVr2ufksFE9aIxbwxLDEcWdD0FyOLFULmS6p?=
 =?us-ascii?Q?rW8g/w1P7fcW+0L7czENzgyQqdfIlxLeCaVsEsC6tg4rZOCF5vrsM2WIUjiA?=
 =?us-ascii?Q?TZJ7UFoSneCZHczk5G2kiZwSNF8fTh+vEWK6JDL/coEQB/WuspWeRzc2ZnWo?=
 =?us-ascii?Q?OfP9m0i/crYsjIkiDetW7ylR9DVBI8mnj3R1+GvhPkiy9qEgrsIApnDXialF?=
 =?us-ascii?Q?W2uZKAFneYKpR92he0VLgixUyfUZCmF2OrKh/rNHImQka1y4ha2FwLeAH86M?=
 =?us-ascii?Q?Z0jWO7cTHD7uRvVpBVdYRaMdZUFOgCJE44YuQ5A9t5zgaoiUe0XQicJEvJbh?=
 =?us-ascii?Q?x/rYiOSDktWMOEkAd32GN0lD87dwMHxXQdgrDowmbzvW5AzappfE3dmHDfmV?=
 =?us-ascii?Q?QGKVI2o6Wt235zx7SzT6NklYX10xzYCJJaYaVVk8oeOGGylD5kdk6I8VMFEH?=
 =?us-ascii?Q?OOvan5AQTVmYZzb23jXm25QvEnJf+WLcxrXbVu6aWxLNGXHBDisaEtUXCXTV?=
 =?us-ascii?Q?e2SXFFMiIq2sZzSi2SlsOOARIUCddiqX0fOrRl8uK+0MS1+NcaZVmMaVkmam?=
 =?us-ascii?Q?cy225pvGuPcjYCfTWBkR4KqpVPXCK/TyQhrBieTdo34evHDvbCHhlzRvquAu?=
 =?us-ascii?Q?fwwDhTd1BrkTo0D0t5piMb5tBPWjvilaTeDem5OrDgz2Jg37xLI7v0Um6z5U?=
 =?us-ascii?Q?Tz5ceMzK3RiGQ8JRhEoHgY4917Fefc0tJ3jizzPzxuBMS7vHTRePdBiA+w5r?=
 =?us-ascii?Q?Qw3buUrYkGMAo9eWv7teYHV8GtNYDVYz6wXTNuGvRAUFjTkRdH84KhWEAg/R?=
 =?us-ascii?Q?6tdfMoEWyCaDIGopIEABjHHTyiw8+RoytswzAO9pQP8pll/XP+2zlcMueU9S?=
 =?us-ascii?Q?/LKgVZ+6c+FX2h4IFkaaolO/GBkxr8B1lUImhuY4MP+pnflgvsiaemfjldqn?=
 =?us-ascii?Q?KC7Wm9CEu1d/zCbT+aZJRGJxkq9KGUutIlj/ENAGe1E38BZqKsBpTx2eI5C3?=
 =?us-ascii?Q?sGI+d+pMKleIx0NDszgbKgtbm7R/pv6uZSDdS0F+5I3d9vOLdrzAqvWZCksF?=
 =?us-ascii?Q?5eWsgPU/wCHL23x9BpFeJm7sbRkM8yLTfhbd2fYOfGK7K/EDIjbLllBq0SQp?=
 =?us-ascii?Q?//g1SUB33IMMco8RP3NN840AWHL/eOEvltv1Z+AOYoSW3nXcXuLW1AB6N66g?=
 =?us-ascii?Q?6Slxfw=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: u93vHZOlSjpI6cJSMcuFNcL+2vaK14akW4dysiFWcs++2xmohKAsTlQhHrP1yE3N4psjxlN4vEeU32SQBYZSmKcsWYBXVYr8OehlPAaj+Nhqjolxm0heqt4dldnB9tkvwMUHNCZnDl5SEDBPIAIhLq91eNl+u0vkxDL52DzOtPGzoPcOYlH8wWBhi2mZRpNXj0/AnJVrGOj198vXpx72Kll3qVSqcUzp7bZYhTdMIVn9A0bTL4erGLAnC/xwlgrzrcHhpnuRtIihrgjS3EL3ur0vbYnRPfO7Pf7mly24MsiMbV69SOraKJGHypQhZYH8vLpyQp+QJff6rJ7oPn67iMHLLGQJ3wtOHo7afKKUr1DEzuMhCafegdtNbwvFcvet2HGPSitIfZWyhttaeCq5z13wuQbY8fSNma08g+MvFYG5Wkrgh0R66wKKfNV+Bw2I
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 15:30:36.0282 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 901112f4-e204-41cf-bdcc-08de6e397f58
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7353
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=ankita@nvidia.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
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

From: Ankit Agrawal <ankita@nvidia.com>

Add an Error **errp parameter to vfio_region_setup() and
vfio_setup_region_sparse_mmaps to allow proper error handling
instead of just returning error codes.

The function sets errors via error_setg() when failure occur.

Suggested-by: Cedric Le Goater <clg@redhat.com>
Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
---
 hw/vfio/display.c     |  6 +++---
 hw/vfio/pci.c         |  3 +--
 hw/vfio/region.c      | 20 +++++++++++---------
 hw/vfio/vfio-region.h |  2 +-
 4 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/hw/vfio/display.c b/hw/vfio/display.c
index faacd9019a..5a42a6f7a2 100644
--- a/hw/vfio/display.c
+++ b/hw/vfio/display.c
@@ -446,13 +446,13 @@ static void vfio_display_region_update(void *opaque)
 
     if (!dpy->region.buffer.size) {
         /* mmap region */
+        Error *error = NULL;
         ret = vfio_region_setup(OBJECT(vdev), &vdev->vbasedev,
                                 &dpy->region.buffer,
                                 plane.region_index,
-                                "display");
+                                "display", &error);
         if (ret != 0) {
-            error_report("%s: vfio_region_setup(%d): %s",
-                         __func__, plane.region_index, strerror(-ret));
+            error_report_err(error);
             goto err;
         }
         ret = vfio_region_mmap(&dpy->region.buffer);
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 36d8fbe872..c89f3fbea3 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3056,11 +3056,10 @@ bool vfio_pci_populate_device(VFIOPCIDevice *vdev, Error **errp)
         char *name = g_strdup_printf("%s BAR %d", vbasedev->name, i);
 
         ret = vfio_region_setup(OBJECT(vdev), vbasedev,
-                                &vdev->bars[i].region, i, name);
+                                &vdev->bars[i].region, i, name, errp);
         g_free(name);
 
         if (ret) {
-            error_setg_errno(errp, -ret, "failed to get region %d info", i);
             return false;
         }
 
diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index 8fbc98918f..d464eadf9c 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -163,7 +163,8 @@ static int vfio_mmap_compare_offset(const void *a, const void *b)
 }
 
 static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
-                                          struct vfio_region_info *info)
+                                          struct vfio_region_info *info,
+                                          Error **errp)
 {
     struct vfio_info_cap_header *hdr;
     struct vfio_region_info_cap_sparse_mmap *sparse;
@@ -210,12 +211,12 @@ static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
             off_t prev_end = region->mmaps[i - 1].offset +
                              region->mmaps[i - 1].size;
             if (prev_end > region->mmaps[i].offset) {
-                error_report("%s: overlapping sparse mmap regions detected "
-                             "in region %d: [0x%"PRIx64"-0x%"PRIx64"] overlaps "
-                             "with [0x%"PRIx64"-0x%"PRIx64"]",
-                             __func__, region->nr, region->mmaps[i - 1].offset,
-                             prev_end - 1, region->mmaps[i].offset,
-                             region->mmaps[i].offset + region->mmaps[i].size - 1);
+                error_setg(errp, "%s: overlapping sparse mmap regions detected "
+                           "in region %d: [0x%"PRIx64"-0x%"PRIx64"] overlaps "
+                           "with [0x%"PRIx64"-0x%"PRIx64"]",
+                           __func__, region->nr, region->mmaps[i - 1].offset,
+                           prev_end - 1, region->mmaps[i].offset,
+                           region->mmaps[i].offset + region->mmaps[i].size - 1);
                 g_free(region->mmaps);
                 region->mmaps = NULL;
                 region->nr_mmaps = 0;
@@ -228,13 +229,14 @@ static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
 }
 
 int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
-                      int index, const char *name)
+                      int index, const char *name, Error **errp)
 {
     struct vfio_region_info *info = NULL;
     int ret;
 
     ret = vfio_device_get_region_info(vbasedev, index, &info);
     if (ret) {
+        error_setg_errno(errp, -ret, "failed to get region %d info", index);
         return ret;
     }
 
@@ -253,7 +255,7 @@ int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
         if (!vbasedev->no_mmap &&
             region->flags & VFIO_REGION_INFO_FLAG_MMAP) {
 
-            ret = vfio_setup_region_sparse_mmaps(region, info);
+            ret = vfio_setup_region_sparse_mmaps(region, info, errp);
 
             if (ret == -ENODEV) {
                 region->nr_mmaps = 1;
diff --git a/hw/vfio/vfio-region.h b/hw/vfio/vfio-region.h
index ede6e0c8f9..9b21d4ee5b 100644
--- a/hw/vfio/vfio-region.h
+++ b/hw/vfio/vfio-region.h
@@ -38,7 +38,7 @@ void vfio_region_write(void *opaque, hwaddr addr,
 uint64_t vfio_region_read(void *opaque,
                           hwaddr addr, unsigned size);
 int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
-                      int index, const char *name);
+                      int index, const char *name, Error **errp);
 int vfio_region_mmap(VFIORegion *region);
 void vfio_region_mmaps_set_enabled(VFIORegion *region, bool enabled);
 void vfio_region_unmap(VFIORegion *region);
-- 
2.34.1


