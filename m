Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A4A7CD98E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:49:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZEFH-0003Vi-0M; Mon, 15 Jun 2026 16:49:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wZEF9-0003V0-Tj
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:49:16 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wZEF8-00053r-2w
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:49:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=erAW6NKL/IJYHRLsKfV/5gqltd6hWWG8lLsCiAnX3kk1RTVC2NRu4y/Dac9NJsTPP9WSSC5tN6NsZkFZYzKBFg3n8Awam/xpZGitHHpcsS/KPEytS93nWtM2+QhMjRCsVvRjIc579UXjy1y89MeEILMa/5BvQevy/B5BJH8AcHuIIUOdz275TXGcMOfXE9RDGHwwFltB4i/iq+QUQZWesaX+IQ2YNsrRzLZ4wuWYFGV9ElH5jRSXRfPWnEENa2rv3eKkYde4rKbzIcZoTTj3XpUe8MyOWozaagPjs97Tb6TlalFkDtwEImTJJMmWNVMYP2ZzTcw0v6nvmF7d4fB8mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dzh4wBWo3NUqJpCccSSKoNR90uG/Cc0eUrVkFtLy2aU=;
 b=wp7a/isjl2k7DXLu3XPceDcPpocg79mAEofczZjbn0U4bd+ehFszJtBZz/BU4HLRYjUqm1BLP3X8SSavCzEHwAxRSca7p0MPunDl9FegQ7w44k5BqAfJa3+BlPwELzfV8vohgyQVMlHSm4CV9kW+64CVRMiUxADGbNe3A2rOW3+tHrqL5Dn4kxmf5d9sD/31iZ4WvXavgMO2uJhV5BWoT3GKr9s8VuRSPrrF8fg+FD7BDOw80RWpT9KSeS1a+zOcMx7Nyqnq5BQ1/YhD86uuOvGtNIfjt1nb7gmu1nOGE1J58/UJO4jpocq0iptcKJZnvWdUXIvR4GCqVipGdv7lZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzh4wBWo3NUqJpCccSSKoNR90uG/Cc0eUrVkFtLy2aU=;
 b=m5wxyuJ2Pe87rZv9DRtWw4X4gqwJ4KzH1TMT5V0+yMoNN977as/UUF8f87n1iBSy6l+5UkYLjmx1ETwTFEbpIhpf3UvBNNNcFyPqzVmcI/iZH7PPATbux7oYnpkbS13mCrQ/k3dCsRRpgzpJtGPqiEWt2ysvmZAz7QRpbKwl/PalNIGB23lyITbZ9YTQtyzzxgLD9EiZxmWn9HXrk+8jvG+D2T43Jh6CdwyVU1K6NQ1CygaBXU0T4JXo+aX4kmrWH7uFYNFbOpFpuBnTRGsxJ9a+31FLXV2/ypyUyh/S0q4XWfMTslcL7u1mNy9ezBS5qIvNY8jOu+OymWvfs+xDjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5390.namprd12.prod.outlook.com (2603:10b6:5:389::15)
 by SJ2PR12MB9006.namprd12.prod.outlook.com (2603:10b6:a03:540::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 20:49:03 +0000
Received: from DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720]) by DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 20:49:03 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Matt Ochs <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Nathan Chen <nathanc@nvidia.com>
Subject: [PATCH v2 3/3] vfio/pci: Warn when ats=on but host device lacks ATS
 cap
Date: Mon, 15 Jun 2026 13:48:49 -0700
Message-ID: <20260615204849.3659647-4-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615204849.3659647-1-nathanc@nvidia.com>
References: <20260615204849.3659647-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0104.namprd03.prod.outlook.com
 (2603:10b6:a03:333::19) To DM4PR12MB5390.namprd12.prod.outlook.com
 (2603:10b6:5:389::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5390:EE_|SJ2PR12MB9006:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bfaeebf-e4b4-4322-5c37-08decb1f8903
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: UOozweNcXtTlIeI6OtOUEM3GPwOsnFkznXg8UZKK6NKqNO2z79BpKkUFK/6wdI51cGDKz3vdjIVlrF8R7U7cjQBEkRx5rLIfj7N7hRPki0D/eUHlUuVbPP3CjS0tP7SNO/xCPQHo5T9FqWbjs3yScM8WVSBW8qXU42p8H8wk3wXndymzU/d1yOZT0jGMvrEpTNuFxJgpqjhZxEkLRsIxCG4NHq4q9VVuGvLurBCDt5YEIUgwnIybLAIddIafkCGQqvFjWdCv06iuTbzg1L7JGuGZrGrmHg0D2guPnZqTXziKa9zdNwmRJ+yB3AUe2fuK4yQ3/jxOwajoBPntFbPvceKQY17byjeNZ3FHX5SQe+wQ9yMUjSUvwt9bUFPwYkHgj392ibhFDkFoxL68oCXq9RR1Kwxjq/uSy09MsluAgQJELaqu1JpiStaDAMBJw+zSWEdjUob/lcCHfKKSqQjMR/kWJlnfAvH3MjsuxpaFW3F2+MeIZ1MW6Ne8ZVnEtQApNpLrlQCuC/96fmE3jDgXCTU63lfySRTyme7c3uRDngh2tA1CL4SoS/DxSEQG5ssqs+QB2rIQN8mFUUZRAfMbFBqtdfRkSi0KysSHnjQ8+L5vbJ+pOV0hUVZDd/MKI0utFYToyAokbwV7te9hPkSYazzH+D/hX4nixz5FgIx2+DpZqpdYEGA7Cs26Q6pgcjMj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5390.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X+E2p5ncCHJVOKAT8PC0JAIlCuXaORwEj7g5JQKFQofpr08ENnIzBzfg4orQ?=
 =?us-ascii?Q?gWV8BCrLRwsop5nalrXhEjjvSjzI27ifzLZvKgNpqIz0YRwIRmBiVnAebSJg?=
 =?us-ascii?Q?fEMXCqNeew1CUmOGCSwYsfAPOkotEfT0hAIFq1t3pRMLR4/OKHt07FJnn274?=
 =?us-ascii?Q?/z6DscqLANvJUX84XKogJ1xP0Z1xD9TDUcpWMUrNTmkVnGqt1WNAhDo7INZM?=
 =?us-ascii?Q?MfjXeE0TQpsCRUlxfHzdiqZAkRILHB5VflquQs9Z2T5dDzr1aQLB5JweNvVd?=
 =?us-ascii?Q?rxyMFQ07TbBZAHGPj/v1BDTb3ObXiyIFXMQBR7s5+BC4jqsyuvU2EzI5aPvL?=
 =?us-ascii?Q?5HKjx3sMWMLltjAs9hc8Baj2MexjDYUdUylizPGgkFtxmWd6uedFKaZIWitm?=
 =?us-ascii?Q?KIpEt/Pb9T0F048iUZ/oTO1L50WGBBX/N6Lbl94crHWAKCJNyjo6dpAY/jJw?=
 =?us-ascii?Q?383eJDq2m0/f5/oYoLc0uvsXb6txAyKVhUf89MXW6+9Im8KJyVXG6ARsY/TT?=
 =?us-ascii?Q?OdRi4NivGYlWrffIhTqQUY8f1EGIkVqEmF6r4dj2iziRhqA4d21yfANU+hwH?=
 =?us-ascii?Q?TpeCIXOolMTuzxQyAoj2pwxNfLH1C7yGK69xPb1JpdA9IuRzGwumcRgUo9+K?=
 =?us-ascii?Q?gQQ2CozRO6lh7gocp9u/IlYGSZtsj0Q+Ek2xNyfnORDKVQiou8oI3Ciuu349?=
 =?us-ascii?Q?QByn7FhouIYCDsAEfOp3Zk9n7UzaeDnvsEJLEIV3gKr0xiwgBouVQvin7NaP?=
 =?us-ascii?Q?uq2HPdf9XUGnMvfoJU7teiNHIjooZ/Oo4kPuegL/nZ90GITyyHvS/zN7CnpO?=
 =?us-ascii?Q?O/o7B3rIWQuhwt5lVON54rlGees9DrhE9RBONdALi8KfLTGwpphXHdIJf9oY?=
 =?us-ascii?Q?QUhUTBEUanu4zLSFfFVb3XghflBAbyUL0CJlqYVqhDFgpe0aHq90EYjRSKJf?=
 =?us-ascii?Q?kBlkwGJxgFiTvwHJQgrGC5f6Ey5DNagjjJtHMZnXtbhS1EUmPFpxlVq3mEBJ?=
 =?us-ascii?Q?pUoKf80hqyLIS4xjWElHcOjgCIQ7/dXouAB981YQ5rWhUHCOXtLpuwlO8+GA?=
 =?us-ascii?Q?DQwA4P0FeSt7XktyaAx+bWEupTtK16OShGgSsLDesw2zOwGqRsjM/Z/fIEcA?=
 =?us-ascii?Q?cYOAD4PrZ3faJpRP8xZVy+GWJ6krNEZtr3/2YdSbLtjj8B0pdkRpbpxom2K2?=
 =?us-ascii?Q?0xEZA/SOx5NsZq2SLDgaej4qjVOU0rERv6xlNf+K5Qmc0vjdwaqP02zvNaC8?=
 =?us-ascii?Q?fewcJa4EZaxtDVmBgH7b4e76I3/BVE0P2fkEpOX+5IM45GpeyJGGjy+p67G2?=
 =?us-ascii?Q?4LjNPw8WYPhUFGw+8oGkPirYaVkl7JzywNDNO7R5pfB9rAFH//xyAC2GANbu?=
 =?us-ascii?Q?P/PUjxt7w6FlkCD5pddVjX9mpJv/Hh4WJGgtOoh7gT1jxNf/UB9VOwGwQBMv?=
 =?us-ascii?Q?uSodw8ltW7WwgMiF773e7OYIpJQC+MhQOoHvz+fvWHfFfd9QLgQdWYY/OuTS?=
 =?us-ascii?Q?NeHfFaaw9iAe0F5C5dicFao4uzMxiE9MrIs9rzvJrdwXtzaz2X+NDOZLjY8t?=
 =?us-ascii?Q?fuNUHVgJs2a6PqlaAQ/CUsALiL9e5Og5d2a0ULidtZbBj2l9OVXUPbBqXkzN?=
 =?us-ascii?Q?dqcctToH2D+1Fz60vE+vmGBF+stB3rp53JNOKBYctOdcUW1K5iLMdm/cxfQP?=
 =?us-ascii?Q?/h7hOUOFHoK2OrjXZaEvN89In6x8qgOnIYuHfEaKgXqkMC+iygu7CUHVLOE7?=
 =?us-ascii?Q?cbiLWg9W4Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bfaeebf-e4b4-4322-5c37-08decb1f8903
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 20:49:03.7499 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e4ZY2X6lg13o8umeV5FfEi/R6be24yHk3IXLl911uMZTUzF6ysCTbgAuVeujU5kaES0TTatmtPxSkrL7A2HDfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9006
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=nathanc@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

From: Nathan Chen <nathanc@nvidia.com>

Emit a warning when ats=on is requested but the physical device does not
advertise ATS, since ATS cannot be exposed to the guest in this case.

Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/vfio/pci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 0f592ada89..49ba6813ee 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2592,6 +2592,7 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev, bool ats_needed)
 {
     PCIDevice *pdev = PCI_DEVICE(vdev);
     bool pasid_cap_added = false;
+    bool ats_cap_present = false;
     Error *err = NULL;
     uint32_t header;
     uint16_t cap_id, next, size;
@@ -2680,6 +2681,7 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev, bool ats_needed)
             pcie_add_capability(pdev, cap_id, cap_ver, next, size);
             break;
         case PCI_EXT_CAP_ID_ATS:
+            ats_cap_present = true;
             /*
              * If ATS is requested and supported according to the kernel, add
              * the ATS capability. If not supported according to the kernel or
@@ -2699,6 +2701,11 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev, bool ats_needed)
         error_report_err(err);
     }
 
+    if (vdev->ats == ON_OFF_AUTO_ON && !ats_cap_present) {
+        warn_report("vfio-pci: ats=on requested, but host device has no "
+                    "ATS extended capability");
+    }
+
     /* Cleanup chain head ID if necessary */
     if (pci_get_word(pdev->config + PCI_CONFIG_SPACE_SIZE) == 0xFFFF) {
         pci_set_word(pdev->config + PCI_CONFIG_SPACE_SIZE, 0);
-- 
2.43.0


