Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A1BCD98CC
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 01:48:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXr0g-0003dT-DY; Thu, 11 Jun 2026 21:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wXr0f-0003dK-5x
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 21:48:37 -0400
Received: from mail-westusazon11010012.outbound.protection.outlook.com
 ([52.101.85.12] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wXr0d-0005WT-CS
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 21:48:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zWY1gCiGzYf1+DJx3WxU/rgLPndpWzljBgMLBohkVUDpiCFI1Q8r7o0vqG3fnKllYoqDIGtan/j5Vg7XeBeByjtkZCtxnbMgH1RCS7ry1d1/ESCZvo2x55NdtG1A+ImtXQr/4VqmuckNomkD2R3SL9flGjbIyto18kryyRrnxmOvrJ4Gm7Q5C+QiasCjY+6uEaXaKXRthbb40cS9yalBQ9a5t8GIaT03Tk5LmbWc6d850NiU/Tt4vk90HV8LgsD9BeDsUqe089AQ2tNhldflltgqijqt7mo4ZFYiI2m1D+3om2Lu1hVRX1ujtbJG+Ru9mGInex2RcLCGo1+/U5kZdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+wNbuwjhJtquyysbg/y7WxnFWBEAduw+QygbmRQuZk=;
 b=T6Aedx7eOI8nAbM5Yqob+eglVvtEdv2eZLR6PUQnLOwYlFJ344s/AE7QG31YPrIu/4ej6Xo3SFXjbdLJi3FLI/1cqrSq7Qzx9Hd+RKwsMi7t0/TmO5miK1Vp3ipPMe/rSTBet/a1wSyDdfm2HVvqAH2HcE1xuuQA9fPT4Q4VfFMoc38KUEGnwXpA9ZJjlNYjaKpz80jf+hA+7bF4MoGWINymMLdYivqh/+kwXKe+WgBu+1tft8gmvT4OthX/MJBrDPxBFwZ5s/trQWAf4Z3cneks2fhIaOJqqppKojkdkF4HAKrz+Ei+J6ruY3hHd98BdT7yboOYbqqeZjXboBjlOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+wNbuwjhJtquyysbg/y7WxnFWBEAduw+QygbmRQuZk=;
 b=MIaYLnzK+w5yxZtB1ytYqJQb2QSx2H3L/Np6jRthdqea12nO3Hl6ALz3oagWCUoBZjagLYAnNtGOx84g3dyAcuJjao58dusHwk9Z72K5wumh/KOoeLUdn5ytCSF19gxTUq7ukdhfr8hdyhPPQ29ZdXzXMGauqVfX1I4RyXgN1BjQ6hFVqlFXSvE44l+ocW0D72haLuCOh4ignnu4Y1h8aokaIUm+oVAluxwwjiY9/iN1HG7Y4JmKeKB03IHp73tTACfBs5SnRCsc4H/NS6LPOKlzoiQFBI3QVPkS7tU3co9olz+nJ2ftj34LVuW+Vf2840Nmgbn9mm6Qkuy0+7s28A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5377.namprd12.prod.outlook.com (2603:10b6:208:31f::21)
 by DS4PR12MB9746.namprd12.prod.outlook.com (2603:10b6:8:2a4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 01:43:26 +0000
Received: from BL1PR12MB5377.namprd12.prod.outlook.com
 ([fe80::6432:69b9:5b85:d190]) by BL1PR12MB5377.namprd12.prod.outlook.com
 ([fe80::6432:69b9:5b85:d190%6]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 01:43:26 +0000
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
Subject: [PATCH 0/3] vfio/pci: add vfio-pci ATS control property
Date: Thu, 11 Jun 2026 18:43:19 -0700
Message-ID: <20260612014322.2918836-1-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0295.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::30) To BL1PR12MB5377.namprd12.prod.outlook.com
 (2603:10b6:208:31f::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5377:EE_|DS4PR12MB9746:EE_
X-MS-Office365-Filtering-Correlation-Id: b36c2019-d669-4f10-cf0b-08dec823ff53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: YoTGHV176v/7vobNBkQavgZZ4WcXM2TQhNW0UWtz0s+ZyZhu/EXqoIVCIEyxNCGu17kZuR3NWpPnVVaIftFxM4BS4u3xcO5JsxLpLbINaQPM3k6JvrgQCgTue6yUPxdzZYCo5JjucblDneEEs/eLxILCGnffUYOVHu7/IrJEDDE0FrpN6wcHhd+5wMyQsz5E8BmlvHEBr9OQOcfK99OAcyxF1z08AlG38rNZr8pJTbLCgDv8fUUhn3k8M+hp3BITBeGXKFNKqX173cvJWUtn1CVFNQPaFiRVmVhrqEJveHqrTpWEyMRFhYuX4KuNj4kpgL3CPmEkIeahs+k9asbh7GXmPm/J9fYlWgRL2G+981M8/Su0Gj54Al1X7h37ZiALM1V3K9o02LWJ0py8kj5A0ZB6289DkvMlioRQp2AAm9FuDqa7/moVDzFqsYTvYiFNb2cxiZntdoKtYVhmuidG0R5jc5Ya4S1m0HzNgv4IJHFnHYZo7pXjtaHPDkeCcXCsVzLKzPKFeZ/Wz2CArLCmQ9q52AcUgiflR/x2uaLlegMOwBkjn1GfpXKGQA7TN0wEhVDRjzUlr7BlIaau0Vjx9pqmIXcw57Gsq+gDt0f/+CIMuvboFLULEMBXhJzqwBasy9wD9GUgXvj148GxNRI76n/JEooFffFjmUfFyk/8hIVH4va2T0lVrAeZjNzsgudP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5377.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(18002099003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KDgWhyK0t9N+KXQTAgCEHWnDdraIc63fH+RWraTZDMNUoZzS2ULZhGC3sANe?=
 =?us-ascii?Q?Fd7ZIl+Kv75217wtBaPixOiyM3KEYfxEYpyYm9LGkkOPvg+sMznFpFalPtxL?=
 =?us-ascii?Q?wu2H3Vs+JBjqogSzSls34vHdvO9oK1eThXp++333n3YVK/NF+OKXGz3ihq31?=
 =?us-ascii?Q?BtwNNmlr9kj/QMb4r4hx9j8cqQ0C+kGhLW3CcMlMx8s8GZSggC+MrJL+gHaL?=
 =?us-ascii?Q?dVYDqniWS+C3ajRwdlIP5+qws8qXuZP+JbIKbOlmNSH5JirpX6guzfPu2v8O?=
 =?us-ascii?Q?oajN08ezTI/8T/tLR6Lz3eA4iXuUa+s+2IYIj3sci/3PNik7ndhb7vOM5QO+?=
 =?us-ascii?Q?czftL/IlkOBEPuqJhOVM5VkG3oiQgC4fkKILt8Up2PKRd55fiz7fGHEamCwO?=
 =?us-ascii?Q?iVXfREXDs751DKSxKKVvaNOnECpe+cUHJJlPutrrcC7SfDy0vo/L+CvqgDUE?=
 =?us-ascii?Q?tlJ8UUnguUpzAVV3Cd0i7BKdi7D/DFAHFqLGsebNQuJVN71yEGwcBumR96CO?=
 =?us-ascii?Q?Z4tEkgvdbzqk3TUKRsRJGlsclzj8bQ7dfpFnVeyv/2NzrzJ0DcZJP/UffGIx?=
 =?us-ascii?Q?6jD44yHmdnqWOJKV713d+ftcz659Ht4K3fMjWLI9yzSdtBMcoA7w8FJBC1CR?=
 =?us-ascii?Q?0l1QNMmiABlUPvcXv5xopAfhXXPZHQbiTz56Etq0WBlDBBngZcBmpdHUxYBH?=
 =?us-ascii?Q?WJyQ6uh/S4ikwT/tUajV8/hYPJELwHxoThc//Jj0oVpoN//nExxYa4QqWt3Y?=
 =?us-ascii?Q?Ohd1UbaXQztWvyc9mWirw9NgJx3gABbI2KOcg68eOFMgAEARrSSsS+qjq+kv?=
 =?us-ascii?Q?GeLwUbZrZK2gwlR7+ZanApB0sJLyIRd8E6KygyId0/xshhRzI8QaHgtai15H?=
 =?us-ascii?Q?N6z8E8aeghGvGUs1LoisJRQ6DPSG8oPBqPgqDO6V+bKfbAAxmlLrrWKJoBcR?=
 =?us-ascii?Q?tAIUJYnvQMC0sagPLGcKDlOYiexvc1h12cTzPabhRLE2Rq0uRa/ByKSkp6gW?=
 =?us-ascii?Q?HkJmHwBd9wgVSV+FxMpcWq4YpkLktqYTTiaNj0xdVVryxbfKTpiA5rypkPa6?=
 =?us-ascii?Q?JbkPdobrRR2Fsl0VE14xiFvjrFCDgbRZ72COZYkM7DWGvssWtssRO9QDZx3e?=
 =?us-ascii?Q?Xkx6T5lkoAKFMM1sVK5qllfUGD+BX3DSsYfWDcsbLv4h8IgcFLTK6vrsW4J8?=
 =?us-ascii?Q?iLZtg0DzX7W1AI9F9YndebFvWlKaTwLrKHXw5jk5J8WBOQackAjh32E+oXZJ?=
 =?us-ascii?Q?1zY+Cwj4MBKgLevm8p+t+yLd1qdvyWTHCBYMXHr5OqYqJs4SO6mA1h3vixjx?=
 =?us-ascii?Q?pcichDaRrZct2Cw2yWPK65rDjHr7d6Qfn4h1/RYIa0JBRXaUeJEBT0mgOCsk?=
 =?us-ascii?Q?rGZRJHbRGswd/8Wd7NL3JRUEZnQ4zGM9vCsC9CRd7GTXaUayIN48FcirkFJg?=
 =?us-ascii?Q?g/eNETUz0P//xLUBar6gMWzCWpzkSSufXIzVuXMM51p/r737ZfvDOUaLV6Tk?=
 =?us-ascii?Q?daVHqseFLupny+gLWLgKUZ2WyCB7vpW4Dq8O3m4Xh9RBUqw1rcKW5wC1h+go?=
 =?us-ascii?Q?+/+HaBLnJdvyUGh9BAL1JxWC6Lq9UtnVxmxKGf0iDWb579yf2gY/hOlrbjRs?=
 =?us-ascii?Q?GWujAo93hUlk/mJ7hb/N9kdfltOkUVqj7UrVfbTmQLxtwB5Qy+nc2sxq6aRD?=
 =?us-ascii?Q?8au9X8x5nGlPmQymAMxrac7EAJVE45CJv10GsbAkpQuiAAPkniiOYMb2B949?=
 =?us-ascii?Q?Iby01IigrQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b36c2019-d669-4f10-cf0b-08dec823ff53
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5377.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 01:43:26.7201 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HHzOq06xTJuGw7IlVIASGycxR/+aWKyk3zx1/M7X1d3iHBh52pHl2Sa0fpxcAYPvFBUJKlVwJRtfSfpfXT89aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9746
Received-SPF: permerror client-ip=52.101.85.12;
 envelope-from=nathanc@nvidia.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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

Hi,

This series adds an ATS control property to vfio-pci and wires iommufd
support reporting so vfio-pci can decide whether to expose the ATS PCIe
extended capability to the guest. This series is a follow-up to the
previous patch included in the "hw/arm/smmuv3-accel: Resolve AUTO
properties" series [0].

The new vfio-pci property is:
  ats=on|off|auto (default: auto)

Behavior:
- off: always masks ATS from guest view
- on: requires ATS support; fails realize if kernel reports
      IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED
- auto: masks ATS only when kernel reports
        IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED

To preserve machine compatibility for older machine types, this series adds:
  { "vfio-pci", "ats", "on" } to hw_compat_11_0.

Please note that no linux-headers sync patch is included in this series
because IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED is already present in
linux-headers/linux/iommufd.h in the current base.

Testing:
Verified ATS capability visibility changes with vfio-pci ats=off/on/auto
on an NVIDIA Grace system:
- ats=on + ATS supported by kernel => propagate ATS extended cap to
  guest view
- ats=auto + ATS supported by kernel => propagate ATS extended cap to
  guest view
- ats=on + hiod_iommufd_support_ats modified to return false (mimic 
  kernel-reported unsupported ATS) => realize failure
- ats=auto + hiod_iommufd_support_ats modified to return false (mimic
  kernel-reported unsupported ATS) => ATS masked
- ats=off => ATS masked

Changes from "Resolve AUTO properties" series:
- Split into separate patches for support_ats() handler introduction and
  iommufd implementation, "ats" property addition, and compat property fix
- Rebase on vfio-next
- Remove unnecessary includes for hw/vfio/pci.c
- Rename ats_need to ats_needed for vfio_pci_ats_requested_and_supported()
- Move the vfio_pci_ats_requested_and_supported() call to
  vfio_pci_add_capabilities() so we can propagate the Error **, and then pass
  ats_needed as a new input arg to vfio_add_ext_cap
- Fix indent error in vfio_add_ext_cap()
- Break and add a pcie_add_capability() call for the PASID case in
  vfio_add_ext_cap()
- Update comment about return value for support_ats()

Thanks,
Nathan

[0] https://lore.kernel.org/qemu-devel/20260401010231.4166776-5-nathanc@nvidia.com/

Nathan Chen (3):
  iommufd: Introduce handler for device ATS support
  vfio/pci: Add ats property
  hw/core/machine: Add new compat for vfio-pci ats property

 hw/vfio/pci.h                      |  1 +
 include/system/host_iommu_device.h | 10 ++++
 backends/iommufd.c                 |  8 ++++
 hw/core/machine.c                  |  1 +
 hw/vfio/pci.c                      | 74 ++++++++++++++++++++++++++++--
 5 files changed, 91 insertions(+), 3 deletions(-)

-- 
2.43.0


