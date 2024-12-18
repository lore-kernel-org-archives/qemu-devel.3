Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C760E7718A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 13:46:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNuN9-00033C-GK; Wed, 18 Dec 2024 08:45:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tNuN5-0002ro-LE
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:45:51 -0500
Received: from mail-dm6nam11on2081.outbound.protection.outlook.com
 ([40.107.223.81] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tNuN3-0006ls-LJ
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:45:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kgn7Y3V23E5/EU+IMV8/BI6Ze6vvR5QQne7GDpWAojcSj+iYbuxukXhWyuNCYnwZCn+WHB7cUrV4miU1ztANceMHRA5IR+oIbi5v7OPh0las6sQcdGY/tTmb8+G5gIRfmYma12R1E+zf/9oY3cIsEM/RpUNkl9shSAjykslwQ1uZnzU+/5pnTuZy5+9hm5ZBdPcIWVN+/2zIxXeTm4CywVOT0eRqy6LwI37zkBQgvLeSb69L7V+Fs8iyeealntcbWqhODsxLInqQ6LxHTMe7kX/MN3ctq09MF8POtMv6qUK3h+XZBkhEpSsY4XV/KyLydeUDlpMJ/W/898emEM29Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rgiIgGV4fqskFj4E2H/w2O9l1cHrMBY5lf6jcj9ksBk=;
 b=dvbuKWDBpFWhfNJXeyoljc+5O0hRAyKkyJrbwerSFPRfo6KCjIZmHPFnI/U6+/23xt0VI/fXkTEoSmJd4+j9DDoMea+ET1xsPePEAkEMDhAoirM9VDgn+IJoAzKhqeA7eciLysrRRs1Vvel1lWocQH1WS5wUIi0uKnopOUCKuqM+1YFi17kxQjzLJjRQio5zvl+npvQuMgtdJcPiHPQ78PrDq/gvjyw8lA5w40uyl71ujafS/zJ7K5B5NKe2b1BsT9uSrx63nkvCFEdZ2AIY3U6H6gt5MgO52e/VgS89kNFx2Fs/pp29NiGiGI2XyfQ6czkGPzQ9nJywqmyZBw3StA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgiIgGV4fqskFj4E2H/w2O9l1cHrMBY5lf6jcj9ksBk=;
 b=qWWGy8GYuxZWsekaLksPMrKhDOjjN3yziu2kFvd4GrML76zO6Yj7YGYh9FkoKDF0942oUcz2X7/PpfQ34+FYcobdWF0B7n/1ZT+0jRoP3mVgknQzSYNRW+KZKuT0X7/38Mju8WsTzthoILk8/HKHkN7iwfIbhOeW/bnQP/QjZosFN29Us4c1uHLffhtM/WUReX9/DNNVXDvq5xpdtwPBMFOJ820H2SVrCs71QJGfr29/Vv9lDNjEY350hKGsz7dkUZpKPaZbPfDzTGuM79VocneQgYUSZPBnIBY6OfSSzWMK8bFpCmfduvLEG02Ulwg4NkgSj4kpycwR5JSBlyRcsg==
Received: from BYAPR04CA0029.namprd04.prod.outlook.com (2603:10b6:a03:40::42)
 by IA1PR12MB8407.namprd12.prod.outlook.com (2603:10b6:208:3d9::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 13:40:42 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:40:cafe::74) by BYAPR04CA0029.outlook.office365.com
 (2603:10b6:a03:40::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.22 via Frontend Transport; Wed,
 18 Dec 2024 13:40:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Wed, 18 Dec 2024 13:40:42 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 18 Dec
 2024 05:40:25 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 18 Dec 2024 05:40:25 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport;
 Wed, 18 Dec 2024 05:40:23 -0800
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, Hyman Huang
 <yong.huang@smartx.com>, Joao Martins <joao.m.martins@oracle.com>, "Maor
 Gottlieb" <maorg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH v2 0/7] migration: Drop/unexport migration_is_device() and
 migration_is_active()
Date: Wed, 18 Dec 2024 15:40:15 +0200
Message-ID: <20241218134022.21264-1-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|IA1PR12MB8407:EE_
X-MS-Office365-Filtering-Correlation-Id: fea84ce6-2824-49dc-5445-08dd1f699106
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZEc2YzlCWWZUcERhcFU0QjQ4aHE2Q09aUWY1cGI2T3kySGJZOGdpeU85eGxL?=
 =?utf-8?B?eUl3aXY5czE5SFJjK3dFTFNCU0JyTkw5am5nWHlnNFN6Y01mS3FMRjErYTNT?=
 =?utf-8?B?T1F2ak1zUWx0VUxRUGkvblZraTduTnBHQkVTQ3c2aWdlVEhtY3JzWWUvZWF2?=
 =?utf-8?B?M1RDK09PYm1DNTE2Wmc5TjMwTktmQmhPblY2bzRSdHUwU01oYWhuK1NSTVJv?=
 =?utf-8?B?bGI2Q0xlU3MyZU1XcHlEQzZ5Z0h0c0U0dFF1KzhqUDlLRUVLelBBajBCbW5k?=
 =?utf-8?B?U2xyY3kxeUQxMStGTURkdTgxWWVPQnFIMEdCOGU1bDZweTg2VWhmcDFvUHBi?=
 =?utf-8?B?cERtNmczZzd0NnU5L0RENGNKK29zRE5kYlU4UTlidy9IdU14V3ExK2FVNW05?=
 =?utf-8?B?dzl3MXRVbjlLSW9JSngwem5BeEhVcExhWlE4RzlsVXZBelFQSkUxamUrVmg3?=
 =?utf-8?B?UUxkL3lCdS9uZldNWnpuRGVpdkFwb21PbnhzTHdWT3hNL2xWa2U0Z1FycTFr?=
 =?utf-8?B?OVpmeWx5YWw4Zjc1TFhtSlA4M1l2UVRka1V0MnpoWW5OK3gxSWI0MWoyZThX?=
 =?utf-8?B?THVWSWp2azJmV0NZRjhGUEN6L0YvZkxqVWNaRmtQdzdSM1lkWjR1KzIyYTFC?=
 =?utf-8?B?NHVHSTZwME5xSFA4WjR0VGp6Zk9NSGZSZ0VaQ0hoY2dVdlhDMUZYNWIvMlho?=
 =?utf-8?B?cXBCdEF5SHd5RzZQVGY1UEY0SVNhRkgwLytNMjNhVmMreG9lUnZXMktFQ1FG?=
 =?utf-8?B?a2ZnOWVyZTkxbTlxNTBtVm1LNW81MllGQ25xOGd1UnVzbW1HWHhIL3hIUk9U?=
 =?utf-8?B?SGl1WkRxL09iQzkydC9CaHNmeElZUDJWWWNVd3lnV29zaU1zQlZlTy9JZG9N?=
 =?utf-8?B?T2NLaStWU3prTjJ3UU9DMFhSS29mdkJzV0VrR0VqM1BzNnBYT29IUGRxbFJ5?=
 =?utf-8?B?aXl2c1RaWTdhTllhWDRValRYZkhvMi91dWU2R3dCay9JaE1qYjFPNHYvYllj?=
 =?utf-8?B?UEY1a2QxTWlnVkhSOWw0YWc0OWNNL0wyUEJNank5OWE5MU4xV3NOREdoRExG?=
 =?utf-8?B?MVhjWE5qOFpqTlRNajVvbjBLUlpLUWxJMTJyTC93cDFJWThWWlI1VkdQaUZH?=
 =?utf-8?B?TUgrdG9JcVJ4MGMwNDFNUzhDK1B1T25RL3FFZGptbEsxNGo3SDhlWGltS3Ey?=
 =?utf-8?B?dXAwR21WMVhWdmxUWWtQRjJsN3A1b3dKUVUyRWRLQjI2VGQ4VTlmbnpidjlM?=
 =?utf-8?B?V0RUcFRyeEUvY25nTW03OEs4cTY3aU5xVzR5TzJKVFFSRWNmWHkxUkc0YTRM?=
 =?utf-8?B?UVE5VFhlNzZqdHVKVkExRnZ4YzVrUmVSVTdrU2JTYVVCRWtJODRiNUsxTGN1?=
 =?utf-8?B?bFEzMStmRC9TemRGd3MrWHhPZXZzS1pxL1ozMWFaM3gzMXQzaGRDSWgvMHk0?=
 =?utf-8?B?c0VERDJSSWQ4UHA5N0ZPTHBiMzZTWEpmdWhWU2lQNWNUUGppYUgxUlkxeCts?=
 =?utf-8?B?MDYrekRaWXh5TWJVN1FBeVllR1RXUUF2RXMyWURYZFFlU2grMXMreHovTlFQ?=
 =?utf-8?B?Myt4bDluQjFaMVpNazZvY1B1c3FrWkpIeW83dEJqK0F1Z3lSL3U5KytFeU1q?=
 =?utf-8?B?cUR4TVdTd1hhaWJtMWU0WVV3R1V4SmdtR3VLemJ5eHVjSzAveW5VNkt3U2Y3?=
 =?utf-8?B?YUQvem8rbEwyRXZLdC9hdzVPdG0ycWhKODRzMEx3OGtza3NWUExvcTNibTNC?=
 =?utf-8?B?VE51UmFmb3Z4bm1wSEVIZitSU3R0UGVrQWhoSmVGa0h1YkJNa0hQZXl6djlr?=
 =?utf-8?B?ZmJmSzNBMlpaVWQvSVorY0tUL25KUWc4RnNLaHFWUTdFUlF2dDgvSXNJaUNE?=
 =?utf-8?B?UXFLQWdEZlNXTWt4eUdaWExrdUxvOUJlMWhkTnM3dC8xaGVObWhWR0w1NHBE?=
 =?utf-8?B?M1V0bWZaL0tlTENYWVExMFdCV0ZmeUF3U05uWWl5QzFvck04YjRId0V4UVd5?=
 =?utf-8?B?U3YzNFFqaVJ3PT0=?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 13:40:42.1147 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fea84ce6-2824-49dc-5445-08dd1f699106
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8407
Received-SPF: softfail client-ip=40.107.223.81;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello,

This follows up on Peter's series [1] to simplify migration status API
to a single migration_is_running() function.

Peter's series tried to drop migration_is_device() and
migration_is_active(), however VFIO used them to check if dirty page
tracking has been started in order to avoid errors in log sync, so they
couldn't simply be dropped without some preliminary cleanups.

This series handles these preliminary cleanups and eventually drops
migration_is_device() and unexports migration_is_active().

The series has been migration tested with the following:
- VFIO device dirty tracking.
- Legacy VFIO iommu dirty tracking.
- vIOMMU + Legacy VFIO iommu dirty tracking (migration with vIOMMU is
  currently blocked, so I used a patched QEMU to allow it).

I also tested calc-dirty-rate as now VFIO dirty pages should be included
in its report, and indeed they are.

I didn't test it with iommu DPT as I don't have access to such HW.
It would be great if someone with the proper HW could test it.

Patch structure:
1-4: Refactor and clean up VFIO dirty page tracking helpers.
5: Refactor dirty limit code.
6-7: Drop/unexport migration_is_device() and migration_is_running().

Changes from v1 [2]:
* Bail out early in vfio_container_set_dirty_page_tracking() if dirty
  tracking has already been started/stopped. (Joao)
* Untied the dirty tracking helpers from migration (i.e., removed
  migration_is_running() check) so VFIO dirty pages will be included in
  calc-dirty-rate. (Joao)
* Added comment to VFIODevice->dirty_tracking that states it's protected
  by BQL.
* Added R-b/A-b tags.

Thanks.

[1]
https://lore.kernel.org/qemu-devel/20241024213056.1395400-1-peterx@redhat.com/

[2]
https://lore.kernel.org/qemu-devel/20241216094638.26406-1-avihaih@nvidia.com/

Avihai Horon (7):
  vfio/container: Add dirty tracking started flag
  vfio/migration: Refactor vfio_devices_all_dirty_tracking() logic
  vfio/migration: Refactor vfio_devices_all_running_and_mig_active()
    logic
  vfio/migration: Rename vfio_devices_all_dirty_tracking()
  system/dirtylimit: Don't use migration_is_active()
  migration: Drop migration_is_device()
  migration: Unexport migration_is_active()

 include/hw/vfio/vfio-common.h         |  6 +--
 include/hw/vfio/vfio-container-base.h |  1 +
 include/migration/misc.h              |  2 -
 hw/vfio/common.c                      | 57 +++++++++++----------------
 hw/vfio/container-base.c              | 12 +++++-
 hw/vfio/container.c                   |  2 +-
 migration/migration.c                 | 23 ++++-------
 system/dirtylimit.c                   |  3 +-
 8 files changed, 49 insertions(+), 57 deletions(-)

-- 
2.40.1


