Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0EFFD4A61D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 09:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vggB4-0002z0-AY; Fri, 16 Jan 2026 04:31:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vggB2-0002vT-Ml; Fri, 16 Jan 2026 04:31:32 -0500
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vggAy-0005Sn-11; Fri, 16 Jan 2026 04:31:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vdL8FjDSeFkEAgmzvJgTjT8mngz0fQQfFUFx/hvdR0RsA4RBfamgKgGVfkerNcGWGEBAjlPWw4PlW2G54Jk+Nohz7EWz7nWkGq6bp70aCqN5Xad1WbX4ZMJMpLZkQcDRcJqBbGFNTpGTsqf+7FKhkRrT9SrAmmBE3UylcbsWdG1qFmXqyZSvTCyt+dhvX4aRGriSSghqGX5Udwa5OsH1LMeWiyuZy17MD0hp9qStKs3SEalDgZY97XNcQ39XhP9H53/ojXkIny6nuLt5tcdeRcYWSrXw60amMIggmZMJDmPkkqjwedk56DSwYJvnpKa9yjIJ9oEZ2XQayc0dzfEluQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DOFCoYq1tT/FrdmpCyHrEBPWfPnzSrq6NYMu/cQquMs=;
 b=aifPGWGuGeC7qWbO8/LWbhT9hYeNTnUUhJwbMpeo/AirugWfsbxq/R4FJa8OXEPRqxv0VEFcR4OysgGmZ/UppBIOxDbBokfRvWNR3a/QWhE+XGiYdFT01ZChd+6z7SxnopACh6OdsYIyU2bhZECfJWOIzshwt5GHr/7URNDNNXC9kJY9RjaCmiD711w6HxzDYmCDKdiUUKnkXHLPxU4roLcc7bw4CREgNS0wplQOFZ0Apnd7u5lxlFpox4deoBQ0WxCr8xBPScGdWqI4Z6fyPm8NGGKANd0tKPhFEXVVasgI27Yzx+SAhIsgd5uFXm+r4ph7kFKFpr2AhCvp9uUcEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOFCoYq1tT/FrdmpCyHrEBPWfPnzSrq6NYMu/cQquMs=;
 b=DA/ahQ9ohoOtQzpoRhlWSlCyR6eb/E4MulI+eaYg2rkiSU/xCEUaX74MxYvN5U9liemy41lS0yLEvPNEZVTtaF2ypc43x7XAQ4QAyE9Q+4x8dKVdr/sQThSHlmPZ2z9gOVP8TCE9sJM0k0K200Id/Ddra4AhB/JtGjNFXzZjs3VHCvsYedzHOo2fzfM+jNdf9LjTmIx7qJ0E+F+wLoE83dWNFRpTVw/ljeKcH/IYTb1HkXMFHgRkVfKcoN8h3cJTUEhoigWyMfaYQy9gG/Hvry3ut6fRCA2RCVlTtsLlbao8cUd8+yQqmKT+VD1i5FAV0TODvtjUhzWwxsXjDAwKmQ==
Received: from PH7P221CA0064.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::18)
 by DS0PR12MB8017.namprd12.prod.outlook.com (2603:10b6:8:146::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 09:31:14 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:510:328:cafe::6c) by PH7P221CA0064.outlook.office365.com
 (2603:10b6:510:328::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.7 via Frontend Transport; Fri,
 16 Jan 2026 09:31:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 09:31:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 16 Jan
 2026 01:30:55 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 16 Jan
 2026 01:30:52 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <alex@shazbot.org>, <clg@redhat.com>,
 <cohuck@redhat.com>, <mst@redhat.com>, <nicolinc@nvidia.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhenzhong.duan@intel.com>,
 <vivek.kasireddy@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v3 1/4] linux-headers: Update to Linux v6.19-rc1
Date: Fri, 16 Jan 2026 09:29:46 +0000
Message-ID: <20260116092950.15796-2-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116092950.15796-1-skolothumtho@nvidia.com>
References: <20260116092950.15796-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|DS0PR12MB8017:EE_
X-MS-Office365-Filtering-Correlation-Id: 0293936b-e168-45fe-1838-08de54e1fdd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|7416014|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c20xci94S2hDaUlmQzY3b2Q3VnJXVDhPbjlKM1RnNGxrQWNCcGpFZWZxUXh5?=
 =?utf-8?B?dDMweXZ4N1g5V0NNcG1VSXUwMGlQd211aEZ4M2lxQzYzV1RUSzExbTVCYVZm?=
 =?utf-8?B?VzBKcktiS25HRml3aVFpSStGSUpDR25mTVRHSlo5UlhWQnRvMEthT0d5T3Za?=
 =?utf-8?B?VWh3Z3I5ejI4SVpPM2xNWlM4bXhzTDJaTEppa21GMUxZQmJ0c0FFYVA5ZGVo?=
 =?utf-8?B?MFpRWnZ4Mkd5VTQyWlZ5bHp4OE5BZkZwMU1rQTVJRjNQUTBxKy9vSlRwRThM?=
 =?utf-8?B?Mko0aEVkdXBrMmVTRFU3WTY4blhaZWdaWkFqNHZHeVlRMlBOTk41NWcvOGwx?=
 =?utf-8?B?WklKenp0K0xwczN6aEx4ZjR1c1ViWFdERGtJTFphV3lsTGozdDh1aVNVQVJ1?=
 =?utf-8?B?Rm40NTFVQUE2N2NxT1k3Ny9aYlY5RUtZMUZEZHFyWDNJWTdxRlpwa2NGKzVC?=
 =?utf-8?B?YmZoaklOWS92SE10TldNL3p2Zy9mdTFwbzJQUU1mek9iWVJWU0lxMGFHR3JW?=
 =?utf-8?B?eFBMZU5tWUsxeis1V0RmeFhCTmlKZTJsdzFoRzJxYjNyK1NkUVZzM1A4L0ZY?=
 =?utf-8?B?ck9DeXd5cno3Y1lLTm9XQjJuWjZqNXZkVTBGdHhySnNENU1vTWUvakNhTllL?=
 =?utf-8?B?R0VVV1BuQWxoUWQwaFAzaUNaQ3pmYXhZVjdHZU9qVG10UU9hMjYvMTd2ZnFR?=
 =?utf-8?B?QjlzL081WW0rV09OSGJxbUE1M0pkemh0UHpMRU14UzFBVzJWbjJTOGN5UTFC?=
 =?utf-8?B?cXUxbVk2V1hFakpDbzVRd29aOWlUVDRTa0JZclUvc1ZwdFhVQmpNeEtYdGFl?=
 =?utf-8?B?TnArNyt4NmlwNFZhUG9pdEMrNzBBbG1xcXN1NzAvenl0V2kzRGs0TnppWHhB?=
 =?utf-8?B?cmU3TEtneFB4VGtNclNWRXZreEhPWFJPemJKRTRIUWpGQXg1RXFJWTRXczdr?=
 =?utf-8?B?UGE5d2EwQzBFeHNMT1lzVkVtL0lWMEJZWkhlbUJYV0V1c01QK2FJWE9BaEho?=
 =?utf-8?B?OGdFMUNicjBjMkF2NjZQZEJqTEQyNHpxd0pFTFNzVnozK1dlWEtjbm51Q2ZZ?=
 =?utf-8?B?SHp0N0xvZS80TFM0WWZ1a2w5bDRZQWtRQi9TZi9Eek1ZTXVkODYwdERIQTdW?=
 =?utf-8?B?Rm54emdmcC9DSEgzRldCZGdDRTFvb2pOSGFHSnlIcnYvRFZnNGErR1ZJSWJx?=
 =?utf-8?B?eTFmNzY2YlRvbDAyd3NsUjVzZzd2QnRmVXF6NTR0eUc3VVR1aVMyZUsrTFBJ?=
 =?utf-8?B?QnZzRndmc1c5cS80dVRDZ2V3OW5DRzZSNSsrbjQ0TTJFZUljcDJtNkJ5Nkwx?=
 =?utf-8?B?TWFuQmRuMXNCVk16Wi90ZUY3MVI3emFZcVFNM00vS2ZrZUs4UWhzSjFPaUxj?=
 =?utf-8?B?OEx1OE53N1hrc2ZZS280WVpLWEI2SnlRNVpTOWMwMzlleWNCcXMzajZkL0pT?=
 =?utf-8?B?cEF4SElKbDFZU2toYjlxMEl2UWdjd2haTFk1UlJvRHh4WEtlUms1T3g0VFB1?=
 =?utf-8?B?NFZLenNDTUdsZGJaMnQxMGRHVENqSXZYY21xaXdqMEczSWhzcHhJL1FsL3Q4?=
 =?utf-8?B?QUFIQTd2SUNWVUJINGZab21ITWRmT0xIUlk2R1ZYaEVXVG5jemt3YjNxTmJK?=
 =?utf-8?B?Rkg5bTJuL1FNRllYdXRBWFlQM1JWSTlSTWJKY1Y3QmM4OUFycVlLOWpLd2Vn?=
 =?utf-8?B?Nm5FOWN6bFlja3AwN2xNQS9yYVhKckpacUFzelg4bjl6QUgwM1JXU01KRjU1?=
 =?utf-8?B?bEdmQ1doNUdLSEo0S2x6Z3dGTU5UZVZlMldxZ2tITlVib3JzOHVSUldVbDRH?=
 =?utf-8?B?cVc3Q1Z0ZUJKQTk1c3Z0eGdveXpBVTRITnJVemNYZTBLWGd0MDVRRzZWT2dI?=
 =?utf-8?B?VmQyblZkdnRlUFBJTlhzN29XRmZMa1ZZbWc0Y2FFSmZLb0g1azljSmsvVjdu?=
 =?utf-8?B?OE5YSkk4NXZrdlE3NkV2UDRCSEo5NkxvVGhiWTd5ekdWa251MGRod1RpRVJi?=
 =?utf-8?B?VHVjZlJMRmozZG41T3crQlY1YkRCS2JxZkJiNTV2d0pQOXp4b0l4bExoTlUw?=
 =?utf-8?B?eUEranNpWGZXbDFmeWpsamRTZWw1ekFwb1JQS1Q0UFRnSy94YVQycjhvMjd2?=
 =?utf-8?B?S0pFR2haOWRUUEl6eDduamlEWDBLaWV5K0JFb2JLQkZHd1QxbHY1Q0VzQ0FE?=
 =?utf-8?B?V2p3VzIvTCsra3N1bkVDeURxRXF6bksvT2pQQVVJVFVpK0xjdmp6b3ZXNlJQ?=
 =?utf-8?B?VUluNFRTZnN2VFZZTmNnUXRaczV3PT0=?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 09:31:13.4704 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0293936b-e168-45fe-1838-08de54e1fdd5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8017
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Mainly for adding support for VFIO DMABUF. While at it, update all
headers.

Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 include/standard-headers/drm/drm_fourcc.h     |  25 +-
 include/standard-headers/linux/ethtool.h      |   5 +
 .../linux/input-event-codes.h                 |  14 +-
 include/standard-headers/linux/pci_regs.h     |  89 ++++
 include/standard-headers/linux/virtio_net.h   |   3 +-
 include/standard-headers/linux/virtio_pci.h   |   2 +-
 linux-headers/asm-arm64/kvm.h                 |   2 +-
 linux-headers/asm-arm64/unistd_64.h           |   1 +
 linux-headers/asm-generic/unistd.h            |   4 +-
 linux-headers/asm-loongarch/kvm.h             |   1 +
 linux-headers/asm-loongarch/unistd.h          |   6 +
 linux-headers/asm-loongarch/unistd_64.h       |   1 +
 linux-headers/asm-mips/unistd_n32.h           |   1 +
 linux-headers/asm-mips/unistd_n64.h           |   1 +
 linux-headers/asm-mips/unistd_o32.h           |   1 +
 linux-headers/asm-powerpc/unistd_32.h         |   1 +
 linux-headers/asm-powerpc/unistd_64.h         |   1 +
 linux-headers/asm-riscv/kvm.h                 |   3 +
 linux-headers/asm-riscv/unistd_32.h           |   1 +
 linux-headers/asm-riscv/unistd_64.h           |   1 +
 linux-headers/asm-s390/bitsperlong.h          |   4 -
 linux-headers/asm-s390/unistd.h               |   4 -
 linux-headers/asm-s390/unistd_32.h            | 446 ------------------
 linux-headers/asm-s390/unistd_64.h            |   9 +-
 linux-headers/asm-x86/kvm.h                   |   1 +
 linux-headers/asm-x86/unistd_32.h             |   1 +
 linux-headers/asm-x86/unistd_64.h             |   1 +
 linux-headers/asm-x86/unistd_x32.h            |   1 +
 linux-headers/linux/iommufd.h                 |  10 +
 linux-headers/linux/kvm.h                     |  11 +
 linux-headers/linux/mshv.h                    | 116 ++++-
 linux-headers/linux/psp-sev.h                 |  66 ++-
 linux-headers/linux/vfio.h                    |  28 ++
 33 files changed, 363 insertions(+), 498 deletions(-)
 delete mode 100644 linux-headers/asm-s390/unistd_32.h

diff --git a/include/standard-headers/drm/drm_fourcc.h b/include/standard-headers/drm/drm_fourcc.h
index cef077dfb3..b39e197cc7 100644
--- a/include/standard-headers/drm/drm_fourcc.h
+++ b/include/standard-headers/drm/drm_fourcc.h
@@ -978,14 +978,20 @@ extern "C" {
  *               2 = Gob Height 8, Turing+ Page Kind mapping
  *               3 = Reserved for future use.
  *
- * 22:22 s     Sector layout.  On Tegra GPUs prior to Xavier, there is a further
- *             bit remapping step that occurs at an even lower level than the
- *             page kind and block linear swizzles.  This causes the layout of
- *             surfaces mapped in those SOC's GPUs to be incompatible with the
- *             equivalent mapping on other GPUs in the same system.
- *
- *               0 = Tegra K1 - Tegra Parker/TX2 Layout.
- *               1 = Desktop GPU and Tegra Xavier+ Layout
+ * 22:22 s     Sector layout.  There is a further bit remapping step that occurs
+ * 26:27       at an even lower level than the page kind and block linear
+ *             swizzles.  This causes the bit arrangement of surfaces in memory
+ *             to differ subtly, and prevents direct sharing of surfaces between
+ *             GPUs with different layouts.
+ *
+ *               0 = Tegra K1 - Tegra Parker/TX2 Layout
+ *               1 = Pre-GB20x, GB20x 32+ bpp, GB10, Tegra Xavier-Orin Layout
+ *               2 = GB20x(Blackwell 2)+ 8 bpp surface layout
+ *               3 = GB20x(Blackwell 2)+ 16 bpp surface layout
+ *               4 = Reserved for future use.
+ *               5 = Reserved for future use.
+ *               6 = Reserved for future use.
+ *               7 = Reserved for future use.
  *
  * 25:23 c     Lossless Framebuffer Compression type.
  *
@@ -1000,7 +1006,7 @@ extern "C" {
  *               6 = Reserved for future use
  *               7 = Reserved for future use
  *
- * 55:25 -     Reserved for future use.  Must be zero.
+ * 55:28 -     Reserved for future use.  Must be zero.
  */
 #define DRM_FORMAT_MOD_NVIDIA_BLOCK_LINEAR_2D(c, s, g, k, h) \
 	fourcc_mod_code(NVIDIA, (0x10 | \
@@ -1008,6 +1014,7 @@ extern "C" {
 				 (((k) & 0xff) << 12) | \
 				 (((g) & 0x3) << 20) | \
 				 (((s) & 0x1) << 22) | \
+				 (((s) & 0x6) << 25) | \
 				 (((c) & 0x7) << 23)))
 
 /* To grandfather in prior block linear format modifiers to the above layout,
diff --git a/include/standard-headers/linux/ethtool.h b/include/standard-headers/linux/ethtool.h
index dc24512d28..d0f7a63f10 100644
--- a/include/standard-headers/linux/ethtool.h
+++ b/include/standard-headers/linux/ethtool.h
@@ -2077,6 +2077,10 @@ enum ethtool_link_mode_bit_indices {
 	ETHTOOL_LINK_MODE_800000baseDR4_2_Full_BIT	 = 118,
 	ETHTOOL_LINK_MODE_800000baseSR4_Full_BIT	 = 119,
 	ETHTOOL_LINK_MODE_800000baseVR4_Full_BIT	 = 120,
+	ETHTOOL_LINK_MODE_1600000baseCR8_Full_BIT	 = 121,
+	ETHTOOL_LINK_MODE_1600000baseKR8_Full_BIT	 = 122,
+	ETHTOOL_LINK_MODE_1600000baseDR8_Full_BIT	 = 123,
+	ETHTOOL_LINK_MODE_1600000baseDR8_2_Full_BIT	 = 124,
 
 	/* must be last entry */
 	__ETHTOOL_LINK_MODE_MASK_NBITS
@@ -2190,6 +2194,7 @@ enum ethtool_link_mode_bit_indices {
 #define SPEED_200000		200000
 #define SPEED_400000		400000
 #define SPEED_800000		800000
+#define SPEED_1600000		1600000
 
 #define SPEED_UNKNOWN		-1
 
diff --git a/include/standard-headers/linux/input-event-codes.h b/include/standard-headers/linux/input-event-codes.h
index c914ccd723..ede79c6ae4 100644
--- a/include/standard-headers/linux/input-event-codes.h
+++ b/include/standard-headers/linux/input-event-codes.h
@@ -27,7 +27,7 @@
 #define INPUT_PROP_TOPBUTTONPAD		0x04	/* softbuttons at top of pad */
 #define INPUT_PROP_POINTING_STICK	0x05	/* is a pointing stick */
 #define INPUT_PROP_ACCELEROMETER	0x06	/* has accelerometer */
-#define INPUT_PROP_HAPTIC_TOUCHPAD	0x07	/* is a haptic touchpad */
+#define INPUT_PROP_PRESSUREPAD		0x07	/* pressure triggers clicks */
 
 #define INPUT_PROP_MAX			0x1f
 #define INPUT_PROP_CNT			(INPUT_PROP_MAX + 1)
@@ -631,6 +631,18 @@
 #define KEY_BRIGHTNESS_MIN		0x250	/* Set Brightness to Minimum */
 #define KEY_BRIGHTNESS_MAX		0x251	/* Set Brightness to Maximum */
 
+/*
+ * Keycodes for hotkeys toggling the electronic privacy screen found on some
+ * laptops on/off. Note when the embedded-controller turns on/off the eprivacy
+ * screen itself then the state should be reported through drm connecter props:
+ * https://www.kernel.org/doc/html/latest/gpu/drm-kms.html#standard-connector-properties
+ * Except when implementing the drm connecter properties API is not possible
+ * because e.g. the firmware does not allow querying the presence and/or status
+ * of the eprivacy screen at boot.
+ */
+#define KEY_EPRIVACY_SCREEN_ON		0x252
+#define KEY_EPRIVACY_SCREEN_OFF		0x253
+
 #define KEY_KBDINPUTASSIST_PREV		0x260
 #define KEY_KBDINPUTASSIST_NEXT		0x261
 #define KEY_KBDINPUTASSIST_PREVGROUP		0x262
diff --git a/include/standard-headers/linux/pci_regs.h b/include/standard-headers/linux/pci_regs.h
index 07e06aafec..3add74ae25 100644
--- a/include/standard-headers/linux/pci_regs.h
+++ b/include/standard-headers/linux/pci_regs.h
@@ -503,6 +503,7 @@
 #define  PCI_EXP_DEVCAP_PWR_VAL	0x03fc0000 /* Slot Power Limit Value */
 #define  PCI_EXP_DEVCAP_PWR_SCL	0x0c000000 /* Slot Power Limit Scale */
 #define  PCI_EXP_DEVCAP_FLR     0x10000000 /* Function Level Reset */
+#define  PCI_EXP_DEVCAP_TEE     0x40000000 /* TEE I/O (TDISP) Support */
 #define PCI_EXP_DEVCTL		0x08	/* Device Control */
 #define  PCI_EXP_DEVCTL_CERE	0x0001	/* Correctable Error Reporting En. */
 #define  PCI_EXP_DEVCTL_NFERE	0x0002	/* Non-Fatal Error Reporting Enable */
@@ -754,6 +755,8 @@
 #define PCI_EXT_CAP_ID_NPEM	0x29	/* Native PCIe Enclosure Management */
 #define PCI_EXT_CAP_ID_PL_32GT  0x2A    /* Physical Layer 32.0 GT/s */
 #define PCI_EXT_CAP_ID_DOE	0x2E	/* Data Object Exchange */
+#define PCI_EXT_CAP_ID_DEV3	0x2F	/* Device 3 Capability/Control/Status */
+#define PCI_EXT_CAP_ID_IDE	0x30    /* Integrity and Data Encryption */
 #define PCI_EXT_CAP_ID_PL_64GT	0x31	/* Physical Layer 64.0 GT/s */
 #define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PL_64GT
 
@@ -1244,9 +1247,95 @@
 /* Deprecated old name, replaced with PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE */
 #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE
 
+/* Device 3 Extended Capability */
+#define PCI_DEV3_CAP		0x04	/* Device 3 Capabilities Register */
+#define PCI_DEV3_CTL		0x08	/* Device 3 Control Register */
+#define PCI_DEV3_STA		0x0c	/* Device 3 Status Register */
+#define  PCI_DEV3_STA_SEGMENT	0x8	/* Segment Captured (end-to-end flit-mode detected) */
+
 /* Compute Express Link (CXL r3.1, sec 8.1.5) */
 #define PCI_DVSEC_CXL_PORT				3
 #define PCI_DVSEC_CXL_PORT_CTL				0x0c
 #define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
 
+/* Integrity and Data Encryption Extended Capability */
+#define PCI_IDE_CAP			0x04
+#define  PCI_IDE_CAP_LINK		0x1  /* Link IDE Stream Supported */
+#define  PCI_IDE_CAP_SELECTIVE		0x2  /* Selective IDE Streams Supported */
+#define  PCI_IDE_CAP_FLOWTHROUGH	0x4  /* Flow-Through IDE Stream Supported */
+#define  PCI_IDE_CAP_PARTIAL_HEADER_ENC 0x8  /* Partial Header Encryption Supported */
+#define  PCI_IDE_CAP_AGGREGATION	0x10 /* Aggregation Supported */
+#define  PCI_IDE_CAP_PCRC		0x20 /* PCRC Supported */
+#define  PCI_IDE_CAP_IDE_KM		0x40 /* IDE_KM Protocol Supported */
+#define  PCI_IDE_CAP_SEL_CFG		0x80 /* Selective IDE for Config Request Support */
+#define  PCI_IDE_CAP_ALG		__GENMASK(12, 8) /* Supported Algorithms */
+#define   PCI_IDE_CAP_ALG_AES_GCM_256	0    /* AES-GCM 256 key size, 96b MAC */
+#define  PCI_IDE_CAP_LINK_TC_NUM	__GENMASK(15, 13) /* Link IDE TCs */
+#define  PCI_IDE_CAP_SEL_NUM		__GENMASK(23, 16) /* Supported Selective IDE Streams */
+#define  PCI_IDE_CAP_TEE_LIMITED	0x1000000 /* TEE-Limited Stream Supported */
+#define PCI_IDE_CTL			0x08
+#define  PCI_IDE_CTL_FLOWTHROUGH_IDE	0x4  /* Flow-Through IDE Stream Enabled */
+
+#define PCI_IDE_LINK_STREAM_0		0xc  /* First Link Stream Register Block */
+#define  PCI_IDE_LINK_BLOCK_SIZE	8
+/* Link IDE Stream block, up to PCI_IDE_CAP_LINK_TC_NUM */
+#define PCI_IDE_LINK_CTL_0		0x00		  /* First Link Control Register Offset in block */
+#define  PCI_IDE_LINK_CTL_EN		0x1		  /* Link IDE Stream Enable */
+#define  PCI_IDE_LINK_CTL_TX_AGGR_NPR	__GENMASK(3, 2)	  /* Tx Aggregation Mode NPR */
+#define  PCI_IDE_LINK_CTL_TX_AGGR_PR	__GENMASK(5, 4)	  /* Tx Aggregation Mode PR */
+#define  PCI_IDE_LINK_CTL_TX_AGGR_CPL	__GENMASK(7, 6)	  /* Tx Aggregation Mode CPL */
+#define  PCI_IDE_LINK_CTL_PCRC_EN	0x100		  /* PCRC Enable */
+#define  PCI_IDE_LINK_CTL_PART_ENC	__GENMASK(13, 10) /* Partial Header Encryption Mode */
+#define  PCI_IDE_LINK_CTL_ALG		__GENMASK(18, 14) /* Selection from PCI_IDE_CAP_ALG */
+#define  PCI_IDE_LINK_CTL_TC		__GENMASK(21, 19) /* Traffic Class */
+#define  PCI_IDE_LINK_CTL_ID		__GENMASK(31, 24) /* Stream ID */
+#define PCI_IDE_LINK_STS_0		0x4               /* First Link Status Register Offset in block */
+#define  PCI_IDE_LINK_STS_STATE		__GENMASK(3, 0)   /* Link IDE Stream State */
+#define  PCI_IDE_LINK_STS_IDE_FAIL	0x80000000	  /* IDE fail message received */
+
+/* Selective IDE Stream block, up to PCI_IDE_CAP_SELECTIVE_STREAMS_NUM */
+/* Selective IDE Stream Capability Register */
+#define  PCI_IDE_SEL_CAP		0x00
+#define   PCI_IDE_SEL_CAP_ASSOC_NUM	__GENMASK(3, 0)
+/* Selective IDE Stream Control Register */
+#define  PCI_IDE_SEL_CTL		0x04
+#define   PCI_IDE_SEL_CTL_EN		0x1		  /* Selective IDE Stream Enable */
+#define   PCI_IDE_SEL_CTL_TX_AGGR_NPR	__GENMASK(3, 2)	  /* Tx Aggregation Mode NPR */
+#define   PCI_IDE_SEL_CTL_TX_AGGR_PR	__GENMASK(5, 4)   /* Tx Aggregation Mode PR */
+#define   PCI_IDE_SEL_CTL_TX_AGGR_CPL	__GENMASK(7, 6)	  /* Tx Aggregation Mode CPL */
+#define   PCI_IDE_SEL_CTL_PCRC_EN	0x100		  /* PCRC Enable */
+#define   PCI_IDE_SEL_CTL_CFG_EN	0x200		  /* Selective IDE for Configuration Requests */
+#define   PCI_IDE_SEL_CTL_PART_ENC	__GENMASK(13, 10) /* Partial Header Encryption Mode */
+#define   PCI_IDE_SEL_CTL_ALG		__GENMASK(18, 14) /* Selection from PCI_IDE_CAP_ALG */
+#define   PCI_IDE_SEL_CTL_TC		__GENMASK(21, 19) /* Traffic Class */
+#define   PCI_IDE_SEL_CTL_DEFAULT	0x400000	  /* Default Stream */
+#define   PCI_IDE_SEL_CTL_TEE_LIMITED	0x800000	  /* TEE-Limited Stream */
+#define   PCI_IDE_SEL_CTL_ID		__GENMASK(31, 24) /* Stream ID */
+#define   PCI_IDE_SEL_CTL_ID_MAX	255
+/* Selective IDE Stream Status Register */
+#define  PCI_IDE_SEL_STS		 0x08
+#define   PCI_IDE_SEL_STS_STATE		 __GENMASK(3, 0) /* Selective IDE Stream State */
+#define   PCI_IDE_SEL_STS_STATE_INSECURE 0
+#define   PCI_IDE_SEL_STS_STATE_SECURE	 2
+#define   PCI_IDE_SEL_STS_IDE_FAIL	 0x80000000	 /* IDE fail message received */
+/* IDE RID Association Register 1 */
+#define  PCI_IDE_SEL_RID_1		 0x0c
+#define   PCI_IDE_SEL_RID_1_LIMIT	 __GENMASK(23, 8)
+/* IDE RID Association Register 2 */
+#define  PCI_IDE_SEL_RID_2		0x10
+#define   PCI_IDE_SEL_RID_2_VALID	0x1
+#define   PCI_IDE_SEL_RID_2_BASE	__GENMASK(23, 8)
+#define   PCI_IDE_SEL_RID_2_SEG		__GENMASK(31, 24)
+/* Selective IDE Address Association Register Block, up to PCI_IDE_SEL_CAP_ASSOC_NUM */
+#define PCI_IDE_SEL_ADDR_BLOCK_SIZE	12
+#define  PCI_IDE_SEL_ADDR_1(x)		(20 + (x) * PCI_IDE_SEL_ADDR_BLOCK_SIZE)
+#define   PCI_IDE_SEL_ADDR_1_VALID	0x1
+#define   PCI_IDE_SEL_ADDR_1_BASE_LOW	__GENMASK(19, 8)
+#define   PCI_IDE_SEL_ADDR_1_LIMIT_LOW	__GENMASK(31, 20)
+/* IDE Address Association Register 2 is "Memory Limit Upper" */
+#define  PCI_IDE_SEL_ADDR_2(x)		(24 + (x) * PCI_IDE_SEL_ADDR_BLOCK_SIZE)
+/* IDE Address Association Register 3 is "Memory Base Upper" */
+#define  PCI_IDE_SEL_ADDR_3(x)		(28 + (x) * PCI_IDE_SEL_ADDR_BLOCK_SIZE)
+#define PCI_IDE_SEL_BLOCK_SIZE(nr_assoc)  (20 + PCI_IDE_SEL_ADDR_BLOCK_SIZE * (nr_assoc))
+
 #endif /* LINUX_PCI_REGS_H */
diff --git a/include/standard-headers/linux/virtio_net.h b/include/standard-headers/linux/virtio_net.h
index 93abaae0b9..17a0174d6c 100644
--- a/include/standard-headers/linux/virtio_net.h
+++ b/include/standard-headers/linux/virtio_net.h
@@ -193,7 +193,8 @@ struct virtio_net_hdr_v1 {
 
 struct virtio_net_hdr_v1_hash {
 	struct virtio_net_hdr_v1 hdr;
-	uint32_t hash_value;
+	uint16_t hash_value_lo;
+	uint16_t hash_value_hi;
 #define VIRTIO_NET_HASH_REPORT_NONE            0
 #define VIRTIO_NET_HASH_REPORT_IPv4            1
 #define VIRTIO_NET_HASH_REPORT_TCPv4           2
diff --git a/include/standard-headers/linux/virtio_pci.h b/include/standard-headers/linux/virtio_pci.h
index 09e964e6ee..4c82513df2 100644
--- a/include/standard-headers/linux/virtio_pci.h
+++ b/include/standard-headers/linux/virtio_pci.h
@@ -40,7 +40,7 @@
 #define _LINUX_VIRTIO_PCI_H
 
 #include "standard-headers/linux/types.h"
-#include "standard-headers/linux/kernel.h"
+#include "standard-headers/linux/const.h"
 
 #ifndef VIRTIO_PCI_NO_LEGACY
 
diff --git a/linux-headers/asm-arm64/kvm.h b/linux-headers/asm-arm64/kvm.h
index f4d9baafa1..46ffbddab5 100644
--- a/linux-headers/asm-arm64/kvm.h
+++ b/linux-headers/asm-arm64/kvm.h
@@ -31,7 +31,7 @@
 #define KVM_SPSR_FIQ	4
 #define KVM_NR_SPSR	5
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/psci.h>
 #include <linux/types.h>
 #include <asm/ptrace.h>
diff --git a/linux-headers/asm-arm64/unistd_64.h b/linux-headers/asm-arm64/unistd_64.h
index 4ae25c2b91..1ef9c40813 100644
--- a/linux-headers/asm-arm64/unistd_64.h
+++ b/linux-headers/asm-arm64/unistd_64.h
@@ -326,6 +326,7 @@
 #define __NR_open_tree_attr 467
 #define __NR_file_getattr 468
 #define __NR_file_setattr 469
+#define __NR_listns 470
 
 
 #endif /* _ASM_UNISTD_64_H */
diff --git a/linux-headers/asm-generic/unistd.h b/linux-headers/asm-generic/unistd.h
index 04e0077fb4..942370b3f5 100644
--- a/linux-headers/asm-generic/unistd.h
+++ b/linux-headers/asm-generic/unistd.h
@@ -857,9 +857,11 @@ __SYSCALL(__NR_open_tree_attr, sys_open_tree_attr)
 __SYSCALL(__NR_file_getattr, sys_file_getattr)
 #define __NR_file_setattr 469
 __SYSCALL(__NR_file_setattr, sys_file_setattr)
+#define __NR_listns 470
+__SYSCALL(__NR_listns, sys_listns)
 
 #undef __NR_syscalls
-#define __NR_syscalls 470
+#define __NR_syscalls 471
 
 /*
  * 32 bit systems traditionally used different
diff --git a/linux-headers/asm-loongarch/kvm.h b/linux-headers/asm-loongarch/kvm.h
index 57ba1a563b..de6c3f18e4 100644
--- a/linux-headers/asm-loongarch/kvm.h
+++ b/linux-headers/asm-loongarch/kvm.h
@@ -104,6 +104,7 @@ struct kvm_fpu {
 #define  KVM_LOONGARCH_VM_FEAT_PV_IPI		6
 #define  KVM_LOONGARCH_VM_FEAT_PV_STEALTIME	7
 #define  KVM_LOONGARCH_VM_FEAT_PTW		8
+#define  KVM_LOONGARCH_VM_FEAT_MSGINT		9
 
 /* Device Control API on vcpu fd */
 #define KVM_LOONGARCH_VCPU_CPUCFG	0
diff --git a/linux-headers/asm-loongarch/unistd.h b/linux-headers/asm-loongarch/unistd.h
index 1f01980f9c..e19c7f2f9f 100644
--- a/linux-headers/asm-loongarch/unistd.h
+++ b/linux-headers/asm-loongarch/unistd.h
@@ -1,3 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 
+#include <asm/bitsperlong.h>
+
+#if __BITS_PER_LONG == 32
+#include <asm/unistd_32.h>
+#else
 #include <asm/unistd_64.h>
+#endif
diff --git a/linux-headers/asm-loongarch/unistd_64.h b/linux-headers/asm-loongarch/unistd_64.h
index 5033fc8f2f..aa5daac4ef 100644
--- a/linux-headers/asm-loongarch/unistd_64.h
+++ b/linux-headers/asm-loongarch/unistd_64.h
@@ -322,6 +322,7 @@
 #define __NR_open_tree_attr 467
 #define __NR_file_getattr 468
 #define __NR_file_setattr 469
+#define __NR_listns 470
 
 
 #endif /* _ASM_UNISTD_64_H */
diff --git a/linux-headers/asm-mips/unistd_n32.h b/linux-headers/asm-mips/unistd_n32.h
index c99c10e5bf..a33d106dca 100644
--- a/linux-headers/asm-mips/unistd_n32.h
+++ b/linux-headers/asm-mips/unistd_n32.h
@@ -398,5 +398,6 @@
 #define __NR_open_tree_attr (__NR_Linux + 467)
 #define __NR_file_getattr (__NR_Linux + 468)
 #define __NR_file_setattr (__NR_Linux + 469)
+#define __NR_listns (__NR_Linux + 470)
 
 #endif /* _ASM_UNISTD_N32_H */
diff --git a/linux-headers/asm-mips/unistd_n64.h b/linux-headers/asm-mips/unistd_n64.h
index 0d975bb185..1bc251e450 100644
--- a/linux-headers/asm-mips/unistd_n64.h
+++ b/linux-headers/asm-mips/unistd_n64.h
@@ -374,5 +374,6 @@
 #define __NR_open_tree_attr (__NR_Linux + 467)
 #define __NR_file_getattr (__NR_Linux + 468)
 #define __NR_file_setattr (__NR_Linux + 469)
+#define __NR_listns (__NR_Linux + 470)
 
 #endif /* _ASM_UNISTD_N64_H */
diff --git a/linux-headers/asm-mips/unistd_o32.h b/linux-headers/asm-mips/unistd_o32.h
index 86ac0ac84b..c57175d496 100644
--- a/linux-headers/asm-mips/unistd_o32.h
+++ b/linux-headers/asm-mips/unistd_o32.h
@@ -444,5 +444,6 @@
 #define __NR_open_tree_attr (__NR_Linux + 467)
 #define __NR_file_getattr (__NR_Linux + 468)
 #define __NR_file_setattr (__NR_Linux + 469)
+#define __NR_listns (__NR_Linux + 470)
 
 #endif /* _ASM_UNISTD_O32_H */
diff --git a/linux-headers/asm-powerpc/unistd_32.h b/linux-headers/asm-powerpc/unistd_32.h
index d7a32c5e06..a3f4aa2fe2 100644
--- a/linux-headers/asm-powerpc/unistd_32.h
+++ b/linux-headers/asm-powerpc/unistd_32.h
@@ -451,6 +451,7 @@
 #define __NR_open_tree_attr 467
 #define __NR_file_getattr 468
 #define __NR_file_setattr 469
+#define __NR_listns 470
 
 
 #endif /* _ASM_UNISTD_32_H */
diff --git a/linux-headers/asm-powerpc/unistd_64.h b/linux-headers/asm-powerpc/unistd_64.h
index ff35c51fc6..d4444557f1 100644
--- a/linux-headers/asm-powerpc/unistd_64.h
+++ b/linux-headers/asm-powerpc/unistd_64.h
@@ -423,6 +423,7 @@
 #define __NR_open_tree_attr 467
 #define __NR_file_getattr 468
 #define __NR_file_setattr 469
+#define __NR_listns 470
 
 
 #endif /* _ASM_UNISTD_64_H */
diff --git a/linux-headers/asm-riscv/kvm.h b/linux-headers/asm-riscv/kvm.h
index 759a4852c0..54f3ad7ed2 100644
--- a/linux-headers/asm-riscv/kvm.h
+++ b/linux-headers/asm-riscv/kvm.h
@@ -23,6 +23,8 @@
 #define KVM_INTERRUPT_SET	-1U
 #define KVM_INTERRUPT_UNSET	-2U
 
+#define KVM_EXIT_FAIL_ENTRY_NO_VSFILE	(1ULL << 0)
+
 /* for KVM_GET_REGS and KVM_SET_REGS */
 struct kvm_regs {
 };
@@ -211,6 +213,7 @@ enum KVM_RISCV_SBI_EXT_ID {
 	KVM_RISCV_SBI_EXT_STA,
 	KVM_RISCV_SBI_EXT_SUSP,
 	KVM_RISCV_SBI_EXT_FWFT,
+	KVM_RISCV_SBI_EXT_MPXY,
 	KVM_RISCV_SBI_EXT_MAX,
 };
 
diff --git a/linux-headers/asm-riscv/unistd_32.h b/linux-headers/asm-riscv/unistd_32.h
index 6083373e88..9f33956246 100644
--- a/linux-headers/asm-riscv/unistd_32.h
+++ b/linux-headers/asm-riscv/unistd_32.h
@@ -317,6 +317,7 @@
 #define __NR_open_tree_attr 467
 #define __NR_file_getattr 468
 #define __NR_file_setattr 469
+#define __NR_listns 470
 
 
 #endif /* _ASM_UNISTD_32_H */
diff --git a/linux-headers/asm-riscv/unistd_64.h b/linux-headers/asm-riscv/unistd_64.h
index f0c7585c60..c2e7258916 100644
--- a/linux-headers/asm-riscv/unistd_64.h
+++ b/linux-headers/asm-riscv/unistd_64.h
@@ -327,6 +327,7 @@
 #define __NR_open_tree_attr 467
 #define __NR_file_getattr 468
 #define __NR_file_setattr 469
+#define __NR_listns 470
 
 
 #endif /* _ASM_UNISTD_64_H */
diff --git a/linux-headers/asm-s390/bitsperlong.h b/linux-headers/asm-s390/bitsperlong.h
index cceaf47b02..7af27a985f 100644
--- a/linux-headers/asm-s390/bitsperlong.h
+++ b/linux-headers/asm-s390/bitsperlong.h
@@ -2,11 +2,7 @@
 #ifndef __ASM_S390_BITSPERLONG_H
 #define __ASM_S390_BITSPERLONG_H
 
-#ifndef __s390x__
-#define __BITS_PER_LONG 32
-#else
 #define __BITS_PER_LONG 64
-#endif
 
 #include <asm-generic/bitsperlong.h>
 
diff --git a/linux-headers/asm-s390/unistd.h b/linux-headers/asm-s390/unistd.h
index 27b8b211c8..1484618877 100644
--- a/linux-headers/asm-s390/unistd.h
+++ b/linux-headers/asm-s390/unistd.h
@@ -8,10 +8,6 @@
 #ifndef _ASM_S390_UNISTD_H_
 #define _ASM_S390_UNISTD_H_
 
-#ifdef __s390x__
 #include <asm/unistd_64.h>
-#else
-#include <asm/unistd_32.h>
-#endif
 
 #endif /* _ASM_S390_UNISTD_H_ */
diff --git a/linux-headers/asm-s390/unistd_32.h b/linux-headers/asm-s390/unistd_32.h
deleted file mode 100644
index 37b8f6f358..0000000000
--- a/linux-headers/asm-s390/unistd_32.h
+++ /dev/null
@@ -1,446 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _ASM_S390_UNISTD_32_H
-#define _ASM_S390_UNISTD_32_H
-
-#define __NR_exit 1
-#define __NR_fork 2
-#define __NR_read 3
-#define __NR_write 4
-#define __NR_open 5
-#define __NR_close 6
-#define __NR_restart_syscall 7
-#define __NR_creat 8
-#define __NR_link 9
-#define __NR_unlink 10
-#define __NR_execve 11
-#define __NR_chdir 12
-#define __NR_time 13
-#define __NR_mknod 14
-#define __NR_chmod 15
-#define __NR_lchown 16
-#define __NR_lseek 19
-#define __NR_getpid 20
-#define __NR_mount 21
-#define __NR_umount 22
-#define __NR_setuid 23
-#define __NR_getuid 24
-#define __NR_stime 25
-#define __NR_ptrace 26
-#define __NR_alarm 27
-#define __NR_pause 29
-#define __NR_utime 30
-#define __NR_access 33
-#define __NR_nice 34
-#define __NR_sync 36
-#define __NR_kill 37
-#define __NR_rename 38
-#define __NR_mkdir 39
-#define __NR_rmdir 40
-#define __NR_dup 41
-#define __NR_pipe 42
-#define __NR_times 43
-#define __NR_brk 45
-#define __NR_setgid 46
-#define __NR_getgid 47
-#define __NR_signal 48
-#define __NR_geteuid 49
-#define __NR_getegid 50
-#define __NR_acct 51
-#define __NR_umount2 52
-#define __NR_ioctl 54
-#define __NR_fcntl 55
-#define __NR_setpgid 57
-#define __NR_umask 60
-#define __NR_chroot 61
-#define __NR_ustat 62
-#define __NR_dup2 63
-#define __NR_getppid 64
-#define __NR_getpgrp 65
-#define __NR_setsid 66
-#define __NR_sigaction 67
-#define __NR_setreuid 70
-#define __NR_setregid 71
-#define __NR_sigsuspend 72
-#define __NR_sigpending 73
-#define __NR_sethostname 74
-#define __NR_setrlimit 75
-#define __NR_getrlimit 76
-#define __NR_getrusage 77
-#define __NR_gettimeofday 78
-#define __NR_settimeofday 79
-#define __NR_getgroups 80
-#define __NR_setgroups 81
-#define __NR_symlink 83
-#define __NR_readlink 85
-#define __NR_uselib 86
-#define __NR_swapon 87
-#define __NR_reboot 88
-#define __NR_readdir 89
-#define __NR_mmap 90
-#define __NR_munmap 91
-#define __NR_truncate 92
-#define __NR_ftruncate 93
-#define __NR_fchmod 94
-#define __NR_fchown 95
-#define __NR_getpriority 96
-#define __NR_setpriority 97
-#define __NR_statfs 99
-#define __NR_fstatfs 100
-#define __NR_ioperm 101
-#define __NR_socketcall 102
-#define __NR_syslog 103
-#define __NR_setitimer 104
-#define __NR_getitimer 105
-#define __NR_stat 106
-#define __NR_lstat 107
-#define __NR_fstat 108
-#define __NR_lookup_dcookie 110
-#define __NR_vhangup 111
-#define __NR_idle 112
-#define __NR_wait4 114
-#define __NR_swapoff 115
-#define __NR_sysinfo 116
-#define __NR_ipc 117
-#define __NR_fsync 118
-#define __NR_sigreturn 119
-#define __NR_clone 120
-#define __NR_setdomainname 121
-#define __NR_uname 122
-#define __NR_adjtimex 124
-#define __NR_mprotect 125
-#define __NR_sigprocmask 126
-#define __NR_create_module 127
-#define __NR_init_module 128
-#define __NR_delete_module 129
-#define __NR_get_kernel_syms 130
-#define __NR_quotactl 131
-#define __NR_getpgid 132
-#define __NR_fchdir 133
-#define __NR_bdflush 134
-#define __NR_sysfs 135
-#define __NR_personality 136
-#define __NR_afs_syscall 137
-#define __NR_setfsuid 138
-#define __NR_setfsgid 139
-#define __NR__llseek 140
-#define __NR_getdents 141
-#define __NR__newselect 142
-#define __NR_flock 143
-#define __NR_msync 144
-#define __NR_readv 145
-#define __NR_writev 146
-#define __NR_getsid 147
-#define __NR_fdatasync 148
-#define __NR__sysctl 149
-#define __NR_mlock 150
-#define __NR_munlock 151
-#define __NR_mlockall 152
-#define __NR_munlockall 153
-#define __NR_sched_setparam 154
-#define __NR_sched_getparam 155
-#define __NR_sched_setscheduler 156
-#define __NR_sched_getscheduler 157
-#define __NR_sched_yield 158
-#define __NR_sched_get_priority_max 159
-#define __NR_sched_get_priority_min 160
-#define __NR_sched_rr_get_interval 161
-#define __NR_nanosleep 162
-#define __NR_mremap 163
-#define __NR_setresuid 164
-#define __NR_getresuid 165
-#define __NR_query_module 167
-#define __NR_poll 168
-#define __NR_nfsservctl 169
-#define __NR_setresgid 170
-#define __NR_getresgid 171
-#define __NR_prctl 172
-#define __NR_rt_sigreturn 173
-#define __NR_rt_sigaction 174
-#define __NR_rt_sigprocmask 175
-#define __NR_rt_sigpending 176
-#define __NR_rt_sigtimedwait 177
-#define __NR_rt_sigqueueinfo 178
-#define __NR_rt_sigsuspend 179
-#define __NR_pread64 180
-#define __NR_pwrite64 181
-#define __NR_chown 182
-#define __NR_getcwd 183
-#define __NR_capget 184
-#define __NR_capset 185
-#define __NR_sigaltstack 186
-#define __NR_sendfile 187
-#define __NR_getpmsg 188
-#define __NR_putpmsg 189
-#define __NR_vfork 190
-#define __NR_ugetrlimit 191
-#define __NR_mmap2 192
-#define __NR_truncate64 193
-#define __NR_ftruncate64 194
-#define __NR_stat64 195
-#define __NR_lstat64 196
-#define __NR_fstat64 197
-#define __NR_lchown32 198
-#define __NR_getuid32 199
-#define __NR_getgid32 200
-#define __NR_geteuid32 201
-#define __NR_getegid32 202
-#define __NR_setreuid32 203
-#define __NR_setregid32 204
-#define __NR_getgroups32 205
-#define __NR_setgroups32 206
-#define __NR_fchown32 207
-#define __NR_setresuid32 208
-#define __NR_getresuid32 209
-#define __NR_setresgid32 210
-#define __NR_getresgid32 211
-#define __NR_chown32 212
-#define __NR_setuid32 213
-#define __NR_setgid32 214
-#define __NR_setfsuid32 215
-#define __NR_setfsgid32 216
-#define __NR_pivot_root 217
-#define __NR_mincore 218
-#define __NR_madvise 219
-#define __NR_getdents64 220
-#define __NR_fcntl64 221
-#define __NR_readahead 222
-#define __NR_sendfile64 223
-#define __NR_setxattr 224
-#define __NR_lsetxattr 225
-#define __NR_fsetxattr 226
-#define __NR_getxattr 227
-#define __NR_lgetxattr 228
-#define __NR_fgetxattr 229
-#define __NR_listxattr 230
-#define __NR_llistxattr 231
-#define __NR_flistxattr 232
-#define __NR_removexattr 233
-#define __NR_lremovexattr 234
-#define __NR_fremovexattr 235
-#define __NR_gettid 236
-#define __NR_tkill 237
-#define __NR_futex 238
-#define __NR_sched_setaffinity 239
-#define __NR_sched_getaffinity 240
-#define __NR_tgkill 241
-#define __NR_io_setup 243
-#define __NR_io_destroy 244
-#define __NR_io_getevents 245
-#define __NR_io_submit 246
-#define __NR_io_cancel 247
-#define __NR_exit_group 248
-#define __NR_epoll_create 249
-#define __NR_epoll_ctl 250
-#define __NR_epoll_wait 251
-#define __NR_set_tid_address 252
-#define __NR_fadvise64 253
-#define __NR_timer_create 254
-#define __NR_timer_settime 255
-#define __NR_timer_gettime 256
-#define __NR_timer_getoverrun 257
-#define __NR_timer_delete 258
-#define __NR_clock_settime 259
-#define __NR_clock_gettime 260
-#define __NR_clock_getres 261
-#define __NR_clock_nanosleep 262
-#define __NR_fadvise64_64 264
-#define __NR_statfs64 265
-#define __NR_fstatfs64 266
-#define __NR_remap_file_pages 267
-#define __NR_mbind 268
-#define __NR_get_mempolicy 269
-#define __NR_set_mempolicy 270
-#define __NR_mq_open 271
-#define __NR_mq_unlink 272
-#define __NR_mq_timedsend 273
-#define __NR_mq_timedreceive 274
-#define __NR_mq_notify 275
-#define __NR_mq_getsetattr 276
-#define __NR_kexec_load 277
-#define __NR_add_key 278
-#define __NR_request_key 279
-#define __NR_keyctl 280
-#define __NR_waitid 281
-#define __NR_ioprio_set 282
-#define __NR_ioprio_get 283
-#define __NR_inotify_init 284
-#define __NR_inotify_add_watch 285
-#define __NR_inotify_rm_watch 286
-#define __NR_migrate_pages 287
-#define __NR_openat 288
-#define __NR_mkdirat 289
-#define __NR_mknodat 290
-#define __NR_fchownat 291
-#define __NR_futimesat 292
-#define __NR_fstatat64 293
-#define __NR_unlinkat 294
-#define __NR_renameat 295
-#define __NR_linkat 296
-#define __NR_symlinkat 297
-#define __NR_readlinkat 298
-#define __NR_fchmodat 299
-#define __NR_faccessat 300
-#define __NR_pselect6 301
-#define __NR_ppoll 302
-#define __NR_unshare 303
-#define __NR_set_robust_list 304
-#define __NR_get_robust_list 305
-#define __NR_splice 306
-#define __NR_sync_file_range 307
-#define __NR_tee 308
-#define __NR_vmsplice 309
-#define __NR_move_pages 310
-#define __NR_getcpu 311
-#define __NR_epoll_pwait 312
-#define __NR_utimes 313
-#define __NR_fallocate 314
-#define __NR_utimensat 315
-#define __NR_signalfd 316
-#define __NR_timerfd 317
-#define __NR_eventfd 318
-#define __NR_timerfd_create 319
-#define __NR_timerfd_settime 320
-#define __NR_timerfd_gettime 321
-#define __NR_signalfd4 322
-#define __NR_eventfd2 323
-#define __NR_inotify_init1 324
-#define __NR_pipe2 325
-#define __NR_dup3 326
-#define __NR_epoll_create1 327
-#define __NR_preadv 328
-#define __NR_pwritev 329
-#define __NR_rt_tgsigqueueinfo 330
-#define __NR_perf_event_open 331
-#define __NR_fanotify_init 332
-#define __NR_fanotify_mark 333
-#define __NR_prlimit64 334
-#define __NR_name_to_handle_at 335
-#define __NR_open_by_handle_at 336
-#define __NR_clock_adjtime 337
-#define __NR_syncfs 338
-#define __NR_setns 339
-#define __NR_process_vm_readv 340
-#define __NR_process_vm_writev 341
-#define __NR_s390_runtime_instr 342
-#define __NR_kcmp 343
-#define __NR_finit_module 344
-#define __NR_sched_setattr 345
-#define __NR_sched_getattr 346
-#define __NR_renameat2 347
-#define __NR_seccomp 348
-#define __NR_getrandom 349
-#define __NR_memfd_create 350
-#define __NR_bpf 351
-#define __NR_s390_pci_mmio_write 352
-#define __NR_s390_pci_mmio_read 353
-#define __NR_execveat 354
-#define __NR_userfaultfd 355
-#define __NR_membarrier 356
-#define __NR_recvmmsg 357
-#define __NR_sendmmsg 358
-#define __NR_socket 359
-#define __NR_socketpair 360
-#define __NR_bind 361
-#define __NR_connect 362
-#define __NR_listen 363
-#define __NR_accept4 364
-#define __NR_getsockopt 365
-#define __NR_setsockopt 366
-#define __NR_getsockname 367
-#define __NR_getpeername 368
-#define __NR_sendto 369
-#define __NR_sendmsg 370
-#define __NR_recvfrom 371
-#define __NR_recvmsg 372
-#define __NR_shutdown 373
-#define __NR_mlock2 374
-#define __NR_copy_file_range 375
-#define __NR_preadv2 376
-#define __NR_pwritev2 377
-#define __NR_s390_guarded_storage 378
-#define __NR_statx 379
-#define __NR_s390_sthyi 380
-#define __NR_kexec_file_load 381
-#define __NR_io_pgetevents 382
-#define __NR_rseq 383
-#define __NR_pkey_mprotect 384
-#define __NR_pkey_alloc 385
-#define __NR_pkey_free 386
-#define __NR_semget 393
-#define __NR_semctl 394
-#define __NR_shmget 395
-#define __NR_shmctl 396
-#define __NR_shmat 397
-#define __NR_shmdt 398
-#define __NR_msgget 399
-#define __NR_msgsnd 400
-#define __NR_msgrcv 401
-#define __NR_msgctl 402
-#define __NR_clock_gettime64 403
-#define __NR_clock_settime64 404
-#define __NR_clock_adjtime64 405
-#define __NR_clock_getres_time64 406
-#define __NR_clock_nanosleep_time64 407
-#define __NR_timer_gettime64 408
-#define __NR_timer_settime64 409
-#define __NR_timerfd_gettime64 410
-#define __NR_timerfd_settime64 411
-#define __NR_utimensat_time64 412
-#define __NR_pselect6_time64 413
-#define __NR_ppoll_time64 414
-#define __NR_io_pgetevents_time64 416
-#define __NR_recvmmsg_time64 417
-#define __NR_mq_timedsend_time64 418
-#define __NR_mq_timedreceive_time64 419
-#define __NR_semtimedop_time64 420
-#define __NR_rt_sigtimedwait_time64 421
-#define __NR_futex_time64 422
-#define __NR_sched_rr_get_interval_time64 423
-#define __NR_pidfd_send_signal 424
-#define __NR_io_uring_setup 425
-#define __NR_io_uring_enter 426
-#define __NR_io_uring_register 427
-#define __NR_open_tree 428
-#define __NR_move_mount 429
-#define __NR_fsopen 430
-#define __NR_fsconfig 431
-#define __NR_fsmount 432
-#define __NR_fspick 433
-#define __NR_pidfd_open 434
-#define __NR_clone3 435
-#define __NR_close_range 436
-#define __NR_openat2 437
-#define __NR_pidfd_getfd 438
-#define __NR_faccessat2 439
-#define __NR_process_madvise 440
-#define __NR_epoll_pwait2 441
-#define __NR_mount_setattr 442
-#define __NR_quotactl_fd 443
-#define __NR_landlock_create_ruleset 444
-#define __NR_landlock_add_rule 445
-#define __NR_landlock_restrict_self 446
-#define __NR_memfd_secret 447
-#define __NR_process_mrelease 448
-#define __NR_futex_waitv 449
-#define __NR_set_mempolicy_home_node 450
-#define __NR_cachestat 451
-#define __NR_fchmodat2 452
-#define __NR_map_shadow_stack 453
-#define __NR_futex_wake 454
-#define __NR_futex_wait 455
-#define __NR_futex_requeue 456
-#define __NR_statmount 457
-#define __NR_listmount 458
-#define __NR_lsm_get_self_attr 459
-#define __NR_lsm_set_self_attr 460
-#define __NR_lsm_list_modules 461
-#define __NR_mseal 462
-#define __NR_setxattrat 463
-#define __NR_getxattrat 464
-#define __NR_listxattrat 465
-#define __NR_removexattrat 466
-#define __NR_open_tree_attr 467
-#define __NR_file_getattr 468
-#define __NR_file_setattr 469
-
-#endif /* _ASM_S390_UNISTD_32_H */
diff --git a/linux-headers/asm-s390/unistd_64.h b/linux-headers/asm-s390/unistd_64.h
index 0652ba6331..8d9e579ef5 100644
--- a/linux-headers/asm-s390/unistd_64.h
+++ b/linux-headers/asm-s390/unistd_64.h
@@ -1,6 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _ASM_S390_UNISTD_64_H
-#define _ASM_S390_UNISTD_64_H
+#ifndef _ASM_UNISTD_64_H
+#define _ASM_UNISTD_64_H
 
 #define __NR_exit 1
 #define __NR_fork 2
@@ -390,5 +389,7 @@
 #define __NR_open_tree_attr 467
 #define __NR_file_getattr 468
 #define __NR_file_setattr 469
+#define __NR_listns 470
 
-#endif /* _ASM_S390_UNISTD_64_H */
+
+#endif /* _ASM_UNISTD_64_H */
diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
index 3bb38f6c3a..b804fd25a2 100644
--- a/linux-headers/asm-x86/kvm.h
+++ b/linux-headers/asm-x86/kvm.h
@@ -500,6 +500,7 @@ struct kvm_sync_regs {
 /* vendor-specific groups and attributes for system fd */
 #define KVM_X86_GRP_SEV			1
 #  define KVM_X86_SEV_VMSA_FEATURES	0
+#  define KVM_X86_SNP_POLICY_BITS	1
 
 struct kvm_vmx_nested_state_data {
 	__u8 vmcs12[KVM_STATE_NESTED_VMX_VMCS_SIZE];
diff --git a/linux-headers/asm-x86/unistd_32.h b/linux-headers/asm-x86/unistd_32.h
index 8f784a5634..34255aac64 100644
--- a/linux-headers/asm-x86/unistd_32.h
+++ b/linux-headers/asm-x86/unistd_32.h
@@ -460,6 +460,7 @@
 #define __NR_open_tree_attr 467
 #define __NR_file_getattr 468
 #define __NR_file_setattr 469
+#define __NR_listns 470
 
 
 #endif /* _ASM_UNISTD_32_H */
diff --git a/linux-headers/asm-x86/unistd_64.h b/linux-headers/asm-x86/unistd_64.h
index 26c258d1a6..07f242a5fa 100644
--- a/linux-headers/asm-x86/unistd_64.h
+++ b/linux-headers/asm-x86/unistd_64.h
@@ -384,6 +384,7 @@
 #define __NR_open_tree_attr 467
 #define __NR_file_getattr 468
 #define __NR_file_setattr 469
+#define __NR_listns 470
 
 
 #endif /* _ASM_UNISTD_64_H */
diff --git a/linux-headers/asm-x86/unistd_x32.h b/linux-headers/asm-x86/unistd_x32.h
index 65c2aed946..08fc9da2fa 100644
--- a/linux-headers/asm-x86/unistd_x32.h
+++ b/linux-headers/asm-x86/unistd_x32.h
@@ -337,6 +337,7 @@
 #define __NR_open_tree_attr (__X32_SYSCALL_BIT + 467)
 #define __NR_file_getattr (__X32_SYSCALL_BIT + 468)
 #define __NR_file_setattr (__X32_SYSCALL_BIT + 469)
+#define __NR_listns (__X32_SYSCALL_BIT + 470)
 #define __NR_rt_sigaction (__X32_SYSCALL_BIT + 512)
 #define __NR_rt_sigreturn (__X32_SYSCALL_BIT + 513)
 #define __NR_ioctl (__X32_SYSCALL_BIT + 514)
diff --git a/linux-headers/linux/iommufd.h b/linux-headers/linux/iommufd.h
index 2105a03955..384183a403 100644
--- a/linux-headers/linux/iommufd.h
+++ b/linux-headers/linux/iommufd.h
@@ -450,6 +450,16 @@ struct iommu_hwpt_vtd_s1 {
  * nested domain will translate the same as the nesting parent. The S1 will
  * install a Context Descriptor Table pointing at userspace memory translated
  * by the nesting parent.
+ *
+ * It's suggested to allocate a vDEVICE object carrying vSID and then re-attach
+ * the nested domain, as soon as the vSID is available in the VMM level:
+ *
+ * - when Cfg=translate, a vDEVICE must be allocated prior to attaching to the
+ *   allocated nested domain, as CD/ATS invalidations and vevents need a vSID.
+ * - when Cfg=bypass/abort, a vDEVICE is not enforced during the nested domain
+ *   attachment, to support a GBPA case where VM sets CR0.SMMUEN=0. However, if
+ *   VM sets CR0.SMMUEN=1 while missing a vDEVICE object, kernel would fail to
+ *   report events to the VM. E.g. F_TRANSLATION when guest STE.Cfg=abort.
  */
 struct iommu_hwpt_arm_smmuv3 {
 	__aligned_le64 ste[2];
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 4ea28ef7ca..a4ab42dcba 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -179,6 +179,7 @@ struct kvm_xen_exit {
 #define KVM_EXIT_LOONGARCH_IOCSR  38
 #define KVM_EXIT_MEMORY_FAULT     39
 #define KVM_EXIT_TDX              40
+#define KVM_EXIT_ARM_SEA          41
 
 /* For KVM_EXIT_INTERNAL_ERROR */
 /* Emulate instruction failed. */
@@ -465,6 +466,14 @@ struct kvm_run {
 				} setup_event_notify;
 			};
 		} tdx;
+		/* KVM_EXIT_ARM_SEA */
+		struct {
+#define KVM_EXIT_ARM_SEA_FLAG_GPA_VALID	(1ULL << 0)
+			__u64 flags;
+			__u64 esr;
+			__u64 gva;
+			__u64 gpa;
+		} arm_sea;
 		/* Fix the size of the union. */
 		char padding[256];
 	};
@@ -955,6 +964,8 @@ struct kvm_enable_cap {
 #define KVM_CAP_RISCV_MP_STATE_RESET 242
 #define KVM_CAP_ARM_CACHEABLE_PFNMAP_SUPPORTED 243
 #define KVM_CAP_GUEST_MEMFD_FLAGS 244
+#define KVM_CAP_ARM_SEA_TO_USER 245
+#define KVM_CAP_S390_USER_OPEREXEC 246
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
diff --git a/linux-headers/linux/mshv.h b/linux-headers/linux/mshv.h
index 5bc83db6a3..acceeddc1c 100644
--- a/linux-headers/linux/mshv.h
+++ b/linux-headers/linux/mshv.h
@@ -26,6 +26,7 @@ enum {
 	MSHV_PT_BIT_LAPIC,
 	MSHV_PT_BIT_X2APIC,
 	MSHV_PT_BIT_GPA_SUPER_PAGES,
+	MSHV_PT_BIT_CPU_AND_XSAVE_FEATURES,
 	MSHV_PT_BIT_COUNT,
 };
 
@@ -41,6 +42,8 @@ enum {
  * @pt_flags: Bitmask of 1 << MSHV_PT_BIT_*
  * @pt_isolation: MSHV_PT_ISOLATION_*
  *
+ * This is the initial/v1 version for backward compatibility.
+ *
  * Returns a file descriptor to act as a handle to a guest partition.
  * At this point the partition is not yet initialized in the hypervisor.
  * Some operations must be done with the partition in this state, e.g. setting
@@ -52,6 +55,37 @@ struct mshv_create_partition {
 	__u64 pt_isolation;
 };
 
+#define MSHV_NUM_CPU_FEATURES_BANKS 2
+
+/**
+ * struct mshv_create_partition_v2
+ *
+ * This is extended version of the above initial MSHV_CREATE_PARTITION
+ * ioctl and allows for following additional parameters:
+ *
+ * @pt_num_cpu_fbanks: Must be set to MSHV_NUM_CPU_FEATURES_BANKS.
+ * @pt_cpu_fbanks: Disabled processor feature banks array.
+ * @pt_disabled_xsave: Disabled xsave feature bits.
+ *
+ * pt_cpu_fbanks and pt_disabled_xsave are passed through as-is to the create
+ * partition hypercall.
+ *
+ * Returns : same as above original mshv_create_partition
+ */
+struct mshv_create_partition_v2 {
+	__u64 pt_flags;
+	__u64 pt_isolation;
+	__u16 pt_num_cpu_fbanks;
+	__u8  pt_rsvd[6];		/* MBZ */
+	__u64 pt_cpu_fbanks[MSHV_NUM_CPU_FEATURES_BANKS];
+	__u64 pt_rsvd1[2];		/* MBZ */
+#if defined(__x86_64__)
+	__u64 pt_disabled_xsave;
+#else
+	__u64 pt_rsvd2;			/* MBZ */
+#endif
+} __attribute__((packed));
+
 /* /dev/mshv */
 #define MSHV_CREATE_PARTITION	_IOW(MSHV_IOCTL, 0x00, struct mshv_create_partition)
 
@@ -89,7 +123,7 @@ enum {
  * @rsvd: MBZ
  *
  * Map or unmap a region of userspace memory to Guest Physical Addresses (GPA).
- * Mappings can't overlap in GPA space or userspace.
+ * Mappings can't overlap in GPA space.
  * To unmap, these fields must match an existing mapping.
  */
 struct mshv_user_mem_region {
@@ -288,4 +322,84 @@ struct mshv_get_set_vp_state {
  * #define MSHV_ROOT_HVCALL			_IOWR(MSHV_IOCTL, 0x07, struct mshv_root_hvcall)
  */
 
+/* Structure definitions, macros and IOCTLs for mshv_vtl */
+
+#define MSHV_CAP_CORE_API_STABLE        0x0
+#define MSHV_CAP_REGISTER_PAGE          0x1
+#define MSHV_CAP_VTL_RETURN_ACTION      0x2
+#define MSHV_CAP_DR6_SHARED             0x3
+#define MSHV_MAX_RUN_MSG_SIZE                256
+
+struct mshv_vp_registers {
+	__u32 count;	/* supports only 1 register at a time */
+	__u32 reserved; /* Reserved for alignment or future use */
+	__u64 regs_ptr;	/* pointer to struct hv_register_assoc */
+};
+
+struct mshv_vtl_set_eventfd {
+	__s32 fd;
+	__u32 flag;
+};
+
+struct mshv_vtl_signal_event {
+	__u32 connection_id;
+	__u32 flag;
+};
+
+struct mshv_vtl_sint_post_msg {
+	__u64 message_type;
+	__u32 connection_id;
+	__u32 payload_size; /* Must not exceed HV_MESSAGE_PAYLOAD_BYTE_COUNT */
+	__u64 payload_ptr; /* pointer to message payload (bytes) */
+};
+
+struct mshv_vtl_ram_disposition {
+	__u64 start_pfn;
+	__u64 last_pfn;
+};
+
+struct mshv_vtl_set_poll_file {
+	__u32 cpu;
+	__u32 fd;
+};
+
+struct mshv_vtl_hvcall_setup {
+	__u64 bitmap_array_size; /* stores number of bytes */
+	__u64 allow_bitmap_ptr;
+};
+
+struct mshv_vtl_hvcall {
+	__u64 control;      /* Hypercall control code */
+	__u64 input_size;   /* Size of the input data */
+	__u64 input_ptr;    /* Pointer to the input struct */
+	__u64 status;       /* Status of the hypercall (output) */
+	__u64 output_size;  /* Size of the output data */
+	__u64 output_ptr;   /* Pointer to the output struct */
+};
+
+struct mshv_sint_mask {
+	__u8 mask;
+	__u8 reserved[7];
+};
+
+/* /dev/mshv device IOCTL */
+#define MSHV_CHECK_EXTENSION    _IOW(MSHV_IOCTL, 0x00, __u32)
+
+/* vtl device */
+#define MSHV_CREATE_VTL			_IOR(MSHV_IOCTL, 0x1D, char)
+#define MSHV_ADD_VTL0_MEMORY	_IOW(MSHV_IOCTL, 0x21, struct mshv_vtl_ram_disposition)
+#define MSHV_SET_POLL_FILE		_IOW(MSHV_IOCTL, 0x25, struct mshv_vtl_set_poll_file)
+#define MSHV_RETURN_TO_LOWER_VTL	_IO(MSHV_IOCTL, 0x27)
+#define MSHV_GET_VP_REGISTERS		_IOWR(MSHV_IOCTL, 0x05, struct mshv_vp_registers)
+#define MSHV_SET_VP_REGISTERS		_IOW(MSHV_IOCTL, 0x06, struct mshv_vp_registers)
+
+/* VMBus device IOCTLs */
+#define MSHV_SINT_SIGNAL_EVENT    _IOW(MSHV_IOCTL, 0x22, struct mshv_vtl_signal_event)
+#define MSHV_SINT_POST_MESSAGE    _IOW(MSHV_IOCTL, 0x23, struct mshv_vtl_sint_post_msg)
+#define MSHV_SINT_SET_EVENTFD     _IOW(MSHV_IOCTL, 0x24, struct mshv_vtl_set_eventfd)
+#define MSHV_SINT_PAUSE_MESSAGE_STREAM     _IOW(MSHV_IOCTL, 0x25, struct mshv_sint_mask)
+
+/* hv_hvcall device */
+#define MSHV_HVCALL_SETUP        _IOW(MSHV_IOCTL, 0x1E, struct mshv_vtl_hvcall_setup)
+#define MSHV_HVCALL              _IOWR(MSHV_IOCTL, 0x1F, struct mshv_vtl_hvcall)
 #endif
diff --git a/linux-headers/linux/psp-sev.h b/linux-headers/linux/psp-sev.h
index c525125ea8..9479928a4a 100644
--- a/linux-headers/linux/psp-sev.h
+++ b/linux-headers/linux/psp-sev.h
@@ -47,32 +47,32 @@ typedef enum {
 	 * with possible values from the specification.
 	 */
 	SEV_RET_NO_FW_CALL = -1,
-	SEV_RET_SUCCESS = 0,
-	SEV_RET_INVALID_PLATFORM_STATE,
-	SEV_RET_INVALID_GUEST_STATE,
-	SEV_RET_INAVLID_CONFIG,
+	SEV_RET_SUCCESS                    = 0,
+	SEV_RET_INVALID_PLATFORM_STATE     = 0x0001,
+	SEV_RET_INVALID_GUEST_STATE        = 0x0002,
+	SEV_RET_INAVLID_CONFIG             = 0x0003,
 	SEV_RET_INVALID_CONFIG = SEV_RET_INAVLID_CONFIG,
-	SEV_RET_INVALID_LEN,
-	SEV_RET_ALREADY_OWNED,
-	SEV_RET_INVALID_CERTIFICATE,
-	SEV_RET_POLICY_FAILURE,
-	SEV_RET_INACTIVE,
-	SEV_RET_INVALID_ADDRESS,
-	SEV_RET_BAD_SIGNATURE,
-	SEV_RET_BAD_MEASUREMENT,
-	SEV_RET_ASID_OWNED,
-	SEV_RET_INVALID_ASID,
-	SEV_RET_WBINVD_REQUIRED,
-	SEV_RET_DFFLUSH_REQUIRED,
-	SEV_RET_INVALID_GUEST,
-	SEV_RET_INVALID_COMMAND,
-	SEV_RET_ACTIVE,
-	SEV_RET_HWSEV_RET_PLATFORM,
-	SEV_RET_HWSEV_RET_UNSAFE,
-	SEV_RET_UNSUPPORTED,
-	SEV_RET_INVALID_PARAM,
-	SEV_RET_RESOURCE_LIMIT,
-	SEV_RET_SECURE_DATA_INVALID,
+	SEV_RET_INVALID_LEN                = 0x0004,
+	SEV_RET_ALREADY_OWNED              = 0x0005,
+	SEV_RET_INVALID_CERTIFICATE        = 0x0006,
+	SEV_RET_POLICY_FAILURE             = 0x0007,
+	SEV_RET_INACTIVE                   = 0x0008,
+	SEV_RET_INVALID_ADDRESS            = 0x0009,
+	SEV_RET_BAD_SIGNATURE              = 0x000A,
+	SEV_RET_BAD_MEASUREMENT            = 0x000B,
+	SEV_RET_ASID_OWNED                 = 0x000C,
+	SEV_RET_INVALID_ASID               = 0x000D,
+	SEV_RET_WBINVD_REQUIRED            = 0x000E,
+	SEV_RET_DFFLUSH_REQUIRED           = 0x000F,
+	SEV_RET_INVALID_GUEST              = 0x0010,
+	SEV_RET_INVALID_COMMAND            = 0x0011,
+	SEV_RET_ACTIVE                     = 0x0012,
+	SEV_RET_HWSEV_RET_PLATFORM         = 0x0013,
+	SEV_RET_HWSEV_RET_UNSAFE           = 0x0014,
+	SEV_RET_UNSUPPORTED                = 0x0015,
+	SEV_RET_INVALID_PARAM              = 0x0016,
+	SEV_RET_RESOURCE_LIMIT             = 0x0017,
+	SEV_RET_SECURE_DATA_INVALID        = 0x0018,
 	SEV_RET_INVALID_PAGE_SIZE          = 0x0019,
 	SEV_RET_INVALID_PAGE_STATE         = 0x001A,
 	SEV_RET_INVALID_MDATA_ENTRY        = 0x001B,
@@ -87,6 +87,22 @@ typedef enum {
 	SEV_RET_RESTORE_REQUIRED           = 0x0025,
 	SEV_RET_RMP_INITIALIZATION_FAILED  = 0x0026,
 	SEV_RET_INVALID_KEY                = 0x0027,
+	SEV_RET_SHUTDOWN_INCOMPLETE        = 0x0028,
+	SEV_RET_INCORRECT_BUFFER_LENGTH	   = 0x0030,
+	SEV_RET_EXPAND_BUFFER_LENGTH_REQUEST = 0x0031,
+	SEV_RET_SPDM_REQUEST               = 0x0032,
+	SEV_RET_SPDM_ERROR                 = 0x0033,
+	SEV_RET_SEV_STATUS_ERR_IN_DEV_CONN = 0x0035,
+	SEV_RET_SEV_STATUS_INVALID_DEV_CTX = 0x0036,
+	SEV_RET_SEV_STATUS_INVALID_TDI_CTX = 0x0037,
+	SEV_RET_SEV_STATUS_INVALID_TDI     = 0x0038,
+	SEV_RET_SEV_STATUS_RECLAIM_REQUIRED = 0x0039,
+	SEV_RET_IN_USE                     = 0x003A,
+	SEV_RET_SEV_STATUS_INVALID_DEV_STATE = 0x003B,
+	SEV_RET_SEV_STATUS_INVALID_TDI_STATE = 0x003C,
+	SEV_RET_SEV_STATUS_DEV_CERT_CHANGED = 0x003D,
+	SEV_RET_SEV_STATUS_RESYNC_REQ      = 0x003E,
+	SEV_RET_SEV_STATUS_RESPONSE_TOO_LARGE = 0x003F,
 	SEV_RET_MAX,
 } sev_ret_code;
 
diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index 4d96d1fc12..720edfee7a 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -14,6 +14,7 @@
 
 #include <linux/types.h>
 #include <linux/ioctl.h>
+#include <linux/stddef.h>
 
 #define VFIO_API_VERSION	0
 
@@ -1478,6 +1479,33 @@ struct vfio_device_feature_bus_master {
 };
 #define VFIO_DEVICE_FEATURE_BUS_MASTER 10
 
+/**
+ * Upon VFIO_DEVICE_FEATURE_GET create a dma_buf fd for the
+ * regions selected.
+ *
+ * open_flags are the typical flags passed to open(2), eg O_RDWR, O_CLOEXEC,
+ * etc. offset/length specify a slice of the region to create the dmabuf from.
+ * nr_ranges is the total number of (P2P DMA) ranges that comprise the dmabuf.
+ *
+ * flags should be 0.
+ *
+ * Return: The fd number on success, -1 and errno is set on failure.
+ */
+#define VFIO_DEVICE_FEATURE_DMA_BUF 11
+
+struct vfio_region_dma_range {
+	__u64 offset;
+	__u64 length;
+};
+
+struct vfio_device_feature_dma_buf {
+	__u32	region_index;
+	__u32	open_flags;
+	__u32   flags;
+	__u32   nr_ranges;
+	struct vfio_region_dma_range dma_ranges[] __counted_by(nr_ranges);
+};
+
 /* -------- API for Type1 VFIO IOMMU -------- */
 
 /**
-- 
2.43.0


