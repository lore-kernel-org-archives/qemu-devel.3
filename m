Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85CF9CDB471
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 20:50:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc84D-000571-4l; Tue, 23 Jun 2026 16:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wc84B-00056l-Ij
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 16:49:55 -0400
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wc849-0006UH-Ox
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 16:49:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mNY0T/PdHtlbVDhQ+Dza6FRT7qgTBUmfAysnUDn5sc2M6l8B3WFgw81xwKzamwoARyF7AGMhIxBwQq27WyPahwzqCs0r9TaSia4KH8GX0HBX1fMM4jtjQLq6bepGbNK5qiXVPJ/xAktlpTX73QDb8M+nfttw68esZ+Zt2DNp15+SXNt8CRonxnuDvvDKn1pzDfyQynOSH0KxilwikAgOPq+chBCujBD6ko+mJ0mx3ZBg9yaW5m8yFKyLkdEbiae3OpiTptQq0EcCwvEPAWuqNzxRU7gAmli1XCMHX3Rsvay3hekcIjkOrsub2Cv7sfP1ZOQPHZX44ExW8Uxg3wShtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4wywJaKrhK582yRn+5qcVYNgPWGQhNUSGE+NhxQQU30=;
 b=JfqcHOoVZALbLwvP9WJqfzcxTIL6WomzN/ucuPUxhuW8m5fHPgz1NO5/lIB3Vx9sMKzjuKm1ITRk/7kutT3TAZ/V91Ldqx+YQLIsed2uRnj/7k7p9zBDBduNYQlNh6nbCybBDdKNlLSGrMjKuPXDrZkuKYUQe9WTcE2UvPoVYEftcacA6hQDE4hizvjcxiNwYiTgx8OQ33FY3FwhEIBOLxV/LuAHgNbol6Kof4gSyE6iOSU6/AdxfIXakpFhxd89OrGR+Ll9T9AmW1gjx87mbRKARDGCn8flAQ2A7Nx9SiCaPi0MZ3y2LJQyuzuU+o7GWkNA/8gpsWXVeik/id9qqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wywJaKrhK582yRn+5qcVYNgPWGQhNUSGE+NhxQQU30=;
 b=t5qAcfeh61vbVn1EKJuojY6u4LYFlxr8h0DRTa28gW+xjxv7DHNipbsbn7j1vzjm77TbZLQHyS9iJOG+kdhndzvvQUrfqJtKHeAAC8NDR4T496k+GusZJADj1bv2zLc1fZvDCwBIMtZ4SEqrmDVAy3sRTg1C6oMcgTXaliLH2p/LOxK2f/dlIjkU0UaN8Y/RUKuAapp77p6gniwHF+lAvbM6sVmEOvd0rUb8lkW3ftJBsQmU1e01hbbLgUUhYADn3YS67huzJh8MvCHGaSHGyb/4qMf/Y9RaooDvdLrUGo5tj6r/3aIq3JGY8X54oaLRgIq9vp2G1DCvsGnukA/nlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5390.namprd12.prod.outlook.com (2603:10b6:5:389::15)
 by DS4PR12MB9611.namprd12.prod.outlook.com (2603:10b6:8:277::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Tue, 23 Jun
 2026 20:49:45 +0000
Received: from DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720]) by DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720%6]) with mapi id 15.21.0159.012; Tue, 23 Jun 2026
 20:49:45 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Matt Ochs <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Nathan Chen <nathanc@nvidia.com>
Subject: [PATCH v4 0/2] vfio/pci: add vfio-pci ATS control property
Date: Tue, 23 Jun 2026 13:49:40 -0700
Message-ID: <20260623204943.989903-1-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0197.namprd05.prod.outlook.com
 (2603:10b6:a03:330::22) To DM4PR12MB5390.namprd12.prod.outlook.com
 (2603:10b6:5:389::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5390:EE_|DS4PR12MB9611:EE_
X-MS-Office365-Filtering-Correlation-Id: eb7d6d77-cff1-4eee-ca15-08ded168f54d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|56012099006|3023799007|11063799006|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 3a7tfc4anlxdhiZtfTKAyDz6JioR58GzH6wT31/pQJF9f/d0imv0dQTiq5CTpCNii5lhF5b8ezkHUl3j6IZ/DHGK8ozW65vRGcsIsZnifP5DU8bgg18qJZj6umWtdhN/rakOiU+gfweoEJIED2kVbMCysOXWxIgYuuir2og8xOjzHD+KnUkwPmV6kgdxijVjhtlefk99KbjXkQAViwIPdTBm9Tjsiux2/wdzjYoTeO6Mpsvos9/kEtHLtvSzt+brA+DqO9Gq9X9IS2b0RMQLRmQgzrpI2930cdbrX1a+sU9i0Ia27M7RJdmj3PsVWMTHxKynQJzSvrmsh178MQyC5hF76JrPGwT6IN5xVZKZU3mniZIhnh+wt5XNUSTkaxFdG26J5kzWbP/77SK61LHi/p2QpV3bOJkMddyyMrZXCvO4/thgFwipp+5sN0DrYoYtxK0vs7611e/UkRgtwpuWgJ7bjidcMRyRZRN03Z8O5nFikQo2YUIezRR6/2et87BkGoMT8e534sj9HLCeBQ1i3X1nUsNFALz7tIpMwoWDGZTdC48p/4mSCR37YuQ7pp6kinkt6wE+lXVDKnaaK5qTb0K7riBG44hemntfFBz33GLKltfVd65IkhSlcUNH1dellxu4MlZblRIXgjdXtq3kJb3u4r30CIfU926DTm4JsYI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5390.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(56012099006)(3023799007)(11063799006)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlpuMHRSTDQrdGtUcmFaM3JtREZ0WENKek5sNDdqVm96OU1vbFd5TnRBZmtM?=
 =?utf-8?B?MWlSbFMzaEVzd05qbVJUOU1lYjV0dG9zNGZjSDAxSjlRNXl3TS93ZmlTN3Zt?=
 =?utf-8?B?T01qK2k0WFVPQzZiMzF0QUVIc0wwL3RuS3YxdElqc0RmekhZNXpnazdYTHlh?=
 =?utf-8?B?bEpUbWxWSldnUk15cStLWm9nK1krYmNZQlg5V2ZqQ3RsOFJBTTA0THZiQXJC?=
 =?utf-8?B?aTFydTdrNnBKdWpMUDRLY2Q5NlFuZ0tuOHJCWVlMY2JERkYrS0FoUlYvVC9s?=
 =?utf-8?B?TlRTdmNWMHVISWZqbVBwV1pCTVNCTWJIV0hYRjIxaXpJdVY2VVhjYi95enBq?=
 =?utf-8?B?TVhHZzFLaU9BQS9oQVJjY0pxZUdCM1dtMzZxZ0Z6TVNxTlhTaHFZaG5rdlox?=
 =?utf-8?B?WnI4Zk5SZVdLNG9ubURhcHFzd0xZSnBiUmtOQjdYcldseEptczVOV3I4TlNB?=
 =?utf-8?B?a1o5ZTc0bU5iOVh1QXZhc3plVGNVV3Q3Q0ZSTUNrUFowYXhLRGFqVjBPY00w?=
 =?utf-8?B?RDhNQWlDUkhDakludTJMdE9IUWdYQ05BK0k1Q1dtbTI3UlFKK3VjdWxGUVg3?=
 =?utf-8?B?OEVyQXAwUlBmOUZFRjI2cENZeTJlWUFUa2FWZ0dRWGdIVzZPVENRbGtpaEdo?=
 =?utf-8?B?ZHh6bUFaZEpxUHdMN2pUMzBWK2RUV2gydlF3aGtqNU9wTkgzTTk4YTN0UUJv?=
 =?utf-8?B?RGxzN1BtTklpNUxkT2kvMHRJb2k4U2VZRFZId3BnRUxZcmZ0MGpHUHNEUTM0?=
 =?utf-8?B?OW5sNVpqQndLMWJnY3VCZVNEYVplYTZLdE50R2xlQ2ZGSjlrWDlFZjZkc3Bz?=
 =?utf-8?B?Y0FuTFFkcTliS3NJWmtEZ2p0YldOWkFDWmFYU3B6VzI4MjltNnFtVmZqZHF1?=
 =?utf-8?B?VFcydVFZTU1wT0hqVEVTVFpkd21pMXFmOXp5aHJxdDNuTHpaNzF6UFBYOWVT?=
 =?utf-8?B?QmFWWFMzRnZWN3d1elVwSmhYdzBtSlhKelNpMjJsUzdEV3ZLWjd6SXdIRCtr?=
 =?utf-8?B?QzREQXcyTmpRdGhmNnBESnYvV1pVQXNnYVZPcWd2NXN0aW1XbmZtZnJ5NEha?=
 =?utf-8?B?N3R3anhScm82QVYzUEFjeXYvTGxmd3ltMlhmaGtiMmR6Rk0zSXk1eWJzT1FT?=
 =?utf-8?B?eVZPUklLdEtrTGd5UjN6d1pGTWVHRTRDYzRTUlJYOVdaVFZiUXk1T1oyT2FV?=
 =?utf-8?B?S3NPYldnYUdUd1JFb2piY1FSb21pL0pIV3JNSllEckNYVHdxcWJBMEVmM0Fo?=
 =?utf-8?B?Rnd4bTFza2VBQWNmbTZ3WHhidGVvcGQ4MzdxQkxTdzBtc0FPcnRmTXBwWGNa?=
 =?utf-8?B?VldMNzlMZ1crMk1SNTNDdUpaNi9YRWM4ckl6elpkcERoaGd4cUZDT0xWQ2Vm?=
 =?utf-8?B?TzVsWHhPQ2NxT1Z2bG4vNTc0UFc5amRCRU4ySDdTRnlreE9jdmJDelcrMmUx?=
 =?utf-8?B?OXpwQnNzQ0NVNDZiK1l6VjYwOVNZQnZxWUFkSFZPbUVyaWlXSXByYkFuWHI3?=
 =?utf-8?B?d2hIejFENFNiSk5kbFdZYlNVb3VFdEYrOStHZHUxU0FrWXU5TStSc1lHVDlr?=
 =?utf-8?B?MjB4K2krcWhFNXE2bWxGSW5OR3BvV0FKTE9WR0l6R1c0dlE4MWFjNy9uTVZo?=
 =?utf-8?B?TjI5WTRvZnlhaEU0Y1BMK3JGQTFaR0YzZ3NVWmtqcEFHNkYzQ0YvZkwzVmRN?=
 =?utf-8?B?dGM3dm5WT2RRTDlaSFg3c3RZak5IR1dPK2VaUzgrUmo3SG9Td1RpV20yRDFs?=
 =?utf-8?B?VU5OOHZOZmZwQ2pRNGN0YkhvbHBrUXYvTkhFdHJCZ28vN2lFM0lKbjU4Tmpj?=
 =?utf-8?B?SUhTRDJZaUI5QXErSE42dWxEVFhhZW56Q1Y5QjhVTFYwSThZNVNxSW5vL3JY?=
 =?utf-8?B?cjdQR3NjS2JCczVtYnY5aFFob09NUlpPOTZMYUMrVHZFVElTWVhPR28vRHgx?=
 =?utf-8?B?cHBEcW5mNjJ1Zk5rbVZqMFVqazRBblJ2NzNlMXBNeTBDNXJoZTdLZ2QrSG5r?=
 =?utf-8?B?ODZvajVoTERTWWFMaXNzblVNZGszYnZtUXUxZkNMRnpqTUZqWThrRFhKTk9J?=
 =?utf-8?B?VzQrSGMyclZQVEVsRFB6RVpWS3ZQVmlKUVJSQnJwTGJpbzRTNFp2bGFvMXEz?=
 =?utf-8?B?Ykltd0dzSW1obHhpNWRMZnprOXlCYzIvazUzajFLZHdBRkxUK2FieE0vM2ZG?=
 =?utf-8?B?VDNSRytwOXZKU0R0KytLNEU1cUdIcW5KcDdiUFdLNzdQSVhDZmRrMU8xWDZQ?=
 =?utf-8?B?Tmg5WTdhekM5bDgrQ0lKSjVBeUJxNVgySkFmUlM2NGEzZWtJZU1vcjZLMjFE?=
 =?utf-8?B?Smk5QzVMTnNyOFRuSVdyUWxCc3VpUDB1YmdVV2Mxb0ZTa0pHOTR6dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb7d6d77-cff1-4eee-ca15-08ded168f54d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 20:49:45.6920 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XeWDhP/UZUWiJM/QIjOhZgxtHDvWKzg9apfE8PcgbjYm1X/0GvTNm5JbUn4iUGf0grMz68yHXg7goUa3VpE1lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9611
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=nathanc@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

This is a follow-up to the series [0] that adds an ATS control property
to vfio-pci and wires iommufd support reporting so vfio-pci can decide
whether to expose the ATS PCIe extended capability to the guest.

The new vfio-pci property is:
  ats=on|off|auto (default: auto)

Behavior:
- off: always masks ATS from guest view
- on: requires ATS support; fails realize if kernel reports no ATS
  support via IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED
- auto: masks ATS only when kernel reports no ATS support via
        IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED

If the physical device does not have ATS, the ATS cap will not be
present for the device in the guest, and a warning will be emitted when
ats is set to on.

We intentionally omit a legacy ats=on compat override because forcing
the value to "on" on old machine types can turn a host-kernel capability
update (IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED) into a new realize-time boot
failure. So we keep the uniform default ats=auto to preserve bootability
and follow effective kernel ATS support rather than preserving the old
behavior of always advertising ATS when available.

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
- ats=on + no ATS support in physical device => warning + no ATS ext cap

Changes from v3:
- Move warning for missing kernel ATS support when ats=auto to after
  checking the presence of host device ATS cap. Only emit the warning
  about masking ATS cap when ATS cap is present on the host device.
- Emit warning about no ATS support in physical device only when ats=on
  instead of both ats=auto and ats=on cases (via ats_needed).

Changes from v2:
- Added R-by tags, thanks all!
- Fixed alignment of two
  object_class_property_set_description() blocks in vfio_pci_properties[]
- Removed compat override setting ats=on and added a warning to the case
  where ats=auto and kernel reports ATS is not supported.
- Squash patch for warning when ats=on and there is no ATS support in
  physical device into patch #2
- Emit warning when ats=auto and no ATS support in physical device

Changes from v1:
- Set ats_needed to false by default in
  vfio_pci_ats_requested_and_supported()
- Revise log prefix from "vfio" to "vfio-pci" in
  vfio_pci_ats_requested_and_supported()
- Squash compat update patch into patch for introducing ats property for
  bisectibility
- Revise comments and descriptions for support_ats(),
  vfio_pci_ats_requested_and_supported(), and vfio_pci_class_init() to
  be more generic, removing references to
  IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED
- Emit a warning when ats=on and no ATS support in physical device

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

[0] https://lore.kernel.org/qemu-devel/20260623023540.836825-1-nathanc@nvidia.com/

Nathan Chen (2):
  iommufd: Introduce handler for device ATS support
  vfio/pci: Add ats property

 hw/vfio/pci.h                      |  1 +
 include/system/host_iommu_device.h |  9 +++
 backends/iommufd.c                 |  8 +++
 hw/vfio/pci.c                      | 88 ++++++++++++++++++++++++++++--
 4 files changed, 102 insertions(+), 4 deletions(-)

-- 
2.43.0


