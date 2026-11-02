Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF403606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 18:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=hwMgXQRb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNwXL-0004vR-5O; Mon, 02 Nov 2026 13:13:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1xNwX2-0004t3-SD; Mon, 02 Nov 2026 13:13:22 -0500
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1xNwX0-0003Yr-72; Mon, 02 Nov 2026 13:13:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b/2iRBULsLUvQwSFPRPFMPl0nO/n2s6rxy9TUo9/+vG5/NwuTDoL9AcMd+njSKfZoqZI+2j4pLQDcXWZqzrzk6MDWJcNUGMsKxw/IXNbtB+4Zhm8Ub/lh/3KGLaWPX0Evp7767MTDKDqdH3ANt9QvIEKJnZGNciQqzwHnUEdKDjh8SrSesxPOzXPCXny5tBtJpAvcja9bl+23Ek5jRJqm6v9WjAGM5cft90QxRN4yLnBizkxu4ivuexAyQwDCf1BzgAbeFu1fNObH15PBmtwPeGSLQFrSGmbRNoHXqwxItNJAh6yN4ogCfG3e1f3aZh3E6y9UrSDP7GnXwEqQFD6Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aubpBettuI0SALPn0lzCAzDsbe0oC3dChyHdfmHl4z8=;
 b=arOkO/MftbB0vwcj8TB9/mtKpFc+V1F3Kt3EPmV7R1VwM3ka+5fk7jAOSbNtfxWyex7/cTmHBYuI2Rf0Y8kljpEGlcGs4g9PDsmsogiPAcPfQ4M5N35DUIRFmtZW1G6GwtbMO670tfBs3JSraS+Us31o2Cl1HH5sF0ocpaQ/zggKfViQbcOucspshoq6FvgdhUWa8kyFzqKE2Ww+H+nobiobOT/KoeO4nksvOlcEHPS6bU80s6BlarJGPsnfTPvxBQx9DI9KTQiUwYZzIrFcsoQPJpU18rdQJlMaVgly9pYYAFQkD8SzyzxJnJ3G+iRLfHSDSxYfg1cTm/GzvlBCkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aubpBettuI0SALPn0lzCAzDsbe0oC3dChyHdfmHl4z8=;
 b=hwMgXQRbXb/x8/W0K9VTQ+lq58TOewYTo/ifUeOkbG5xvBrucDgj7IoAn6KxMvh77T2jcIwEeVmePqpgHKmtOWNzLHcAf8H6gS90uiESwguV/6AJf7dcvL/POnd5NKIGeRK2O7Zz9cX+MAHbltjkilaS4rRZnii98NQ5sb5ltNh4ecHdd84c12+dOHSqQRwJqaOZzyNfreHNe8sP5RNKHNg1iolSFfdBrEdchYqtwRel/F9s7CBOL93PkjhjUsNjIRj5SGjxv/GC6x80yY5aLyL2SD5WmJNJfkUnQKb9cVsYjlKk8iWwdMryvxyG9h+lAeOhbljOJ7fEu4EdSS25qQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17) by BL1PR12MB5993.namprd12.prod.outlook.com
 (2603:10b6:208:399::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 18:13:05 +0000
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1]) by IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 18:13:05 +0000
From: Tushar Dave <tdave@nvidia.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 marcel@redhat.com, devel@edk2.groups.io, alwilliamson@nvidia.com,
 jgg@nvidia.com, skolothumtho@nvidia.com, ardb@kernel.org,
 kraxel@redhat.com, tdave@nvidia.com
Subject: [PATCH v2 2/5] hw/pci: add validation for fixed BAR configuration
Date: Mon,  2 Nov 2026 12:12:38 -0600
Message-Id: <20261102181241.3077981-3-tdave@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261102181241.3077981-1-tdave@nvidia.com>
References: <20261102181241.3077981-1-tdave@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR04CA0039.namprd04.prod.outlook.com
 (2603:10b6:610:77::14) To IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR12MB923065:EE_|BL1PR12MB5993:EE_
X-MS-Office365-Filtering-Correlation-Id: a7308672-ab2a-45ca-f0b0-08df390cee04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|260925021311599003|260925021911599003|260925022911599003|5023799004|11063799006|56012099006|261009223027099003|261028144727099003|261021121427099003|261026140227099003|261022075727099003|261026121527099003|261022113327099003|261022105027099003|10067099003|22082099003|18002099003|261102123227099003|6133799003;
X-Microsoft-Antispam-Message-Info: q5db6S6nRWXPf6bPjMZ8lzECA7Pcw3kGmIGk9I4JHINktZi2kvkGa1O/w+7Ey40aA41mpSzLg8qOIVLLETQt79x3NWXIQxjdgvHBNNWGYqKqTWIRo5ffslg5PWsUqao/FSIJRCUyuGn7WcAGfZM1vzuUKIgoIj8qAXdtss+fMIy1ZuifADAcvgd1dsdCwng/kpucI1nYzABmExAzgPaNHRLuyiV4/qIckOzverBu7YdH3se6v1fJdmXieV0jrEd3TBl/jVCTbjo/UwDeBzyGWRdv6GJY0z4iB4AggB1K/clD3hCQQ+0K6dVobtb4kuU9iNV6DsfgBgM+Sdq5zd6515dK9sQrzReRJo9N1VcE+hUwG91O6zBFRuPVlQ/AaPSzJ5B+Kr0GATbvR5b7sV4GZTbcYG8nICBl+8XKSpsx/JWPwjQ3VU3M5DazfVgbwz0iAA+a6b6HPOtDNAEae7ZKgkHwUEYJ/4D+N8k7Lv7oAG6yr5AIIg1tTX4lKaC2sYMpRBuX0bTb7IspSlMIJICDdbpxt1zmGq5n0MkC9GbrWEyopRBBqbyKcLqxoLkxz2kNKRLbt7mv1SrA5BFSbvTwqkYZzLau41AmpBlkxP8w/JfInfx9LOio5tR69VAwPpZ8ybtpoFBYO5dZiml+Dpvp4xHjgWuyF/yPvld1bNZgO9Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR12MB923065.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(260925021311599003)(260925021911599003)(260925022911599003)(5023799004)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261021121427099003)(261026140227099003)(261022075727099003)(261026121527099003)(261022113327099003)(261022105027099003)(10067099003)(22082099003)(18002099003)(261102123227099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sm9wa294cHovVTBZVDlObmYrWk5hZGpEdS90UmYxTGJubUZ3bzl5TDNSWG5O?=
 =?utf-8?B?QXh6ZDFDbXpZS0wvZlRDby9vMFh5ejJCMVN2VFY2eHpLRjIwVHQ0ZEZsUjVK?=
 =?utf-8?B?M2VOMUVRZlZYMGpaem9BTHNHaXk2bVBvSG5FSENzYlUzYzBsK0VkSGduQnBP?=
 =?utf-8?B?dk1TZ0dsc0hiRVhUUVB0OWRYRTJJREV2a1NaWnNIc0pQSDFiK0dCYnZncVJE?=
 =?utf-8?B?THJrYU9RZzlldDNJZFlEd01nM0xJbjNEVStmTlNyUDR0amVlbjVtQm1YU1kr?=
 =?utf-8?B?YThqOG1GUVpVbC9teTJURExPS0VpYWpoSit6ZEtEQ05HSVJ3dWZzWFprNVRV?=
 =?utf-8?B?NUNQcWVoeXdEY1JyRmRUNlhkUnNXNVd5NlhoOEQ3eXNMWFF3L0xlWkdnODN4?=
 =?utf-8?B?cFAwdWxkMWQ2alhDNFBpVlJzNGQybG5EenhqTUNnUDZaazBIczd1b2FBUVRo?=
 =?utf-8?B?RGVSaFdXdVZLRmRPR2MvbGMxWFNQcVJHdDc5eWIyYjk1S1FvZlZrNStVZ0pB?=
 =?utf-8?B?a2VCNmxpWHdOcFkzTEVhS1ZmcDhETVVMV0M2R2NGU2VtbVlCSm5QUXhUeWF1?=
 =?utf-8?B?OXYzU095VjNWamIwNkhmYmExTGllaGhsVjVOWWl5bjJhL1hwVjNIRnBrWmNM?=
 =?utf-8?B?QUlBelk5clNxUnFJWThVK0ZoUWhNZzJnY0pSSzlRR0FnakNDbmpkYllkMFpk?=
 =?utf-8?B?aFcvb2dUZ2dHZWxwSnREa1Q3MEk4WmVwdnFhSTFGWEx5R0Zrb0pLRTM5TFBL?=
 =?utf-8?B?bExacUVOU3JTT0F4K3YwRVNKakFkaFdnMFBpa2NvV2NrblN0Y3paMXVjWWU1?=
 =?utf-8?B?VlhtL3FLc0RUL3Q4S3JLSUxtbjRrbDlkS3JBcjg0SlpheGV0KzRqNW5IaWpO?=
 =?utf-8?B?UFFKN2FuZUdsSTJ4NDRsY2tSWEVqRHB6Q29kVDRSbk02a2FhZUtkeGw1MnRB?=
 =?utf-8?B?ZDF3YnZKMEg4ZU1YZTJoclNKS1N4dVlDbmlhZFpOSkpsSHMzYXc5VWhaazhC?=
 =?utf-8?B?Mk5ZNTYwQURaQWhpWXg3bGxUa0dhZmNOQUJ2L2ZESW1wbzRCaTNzcmlOc3Q4?=
 =?utf-8?B?S29PSEgrZmpQVzJrK1dIaDRQSGR2T2d1QVNGZWw2MkZpSi81TmVsVlZTK1N5?=
 =?utf-8?B?L0E2aDZKUkh3dUJLRDM2S0QvS2YydEFydWwxSExRNHpQaGtZei92SnFkdHBj?=
 =?utf-8?B?bWxPRTJidGZucUo5T3ljRVNFL2o3VlZld1NJZ0drUG1TRkhTY21KL2tQRnZM?=
 =?utf-8?B?bUIwTmpIMFhZM0dKSnBNcHBVaTczdHhxYW9FTEhhMnlEWjd3K0VhZjdlazVV?=
 =?utf-8?B?aEhwcG1zclRiR1ZTd0RIV09EWlp4ZzcxZ1hDUEtud09LQXRlR1k1TUt0SERv?=
 =?utf-8?B?UFRndkJLUWxoVG1sRUFXbDR4UE83RW1ib1RTOVNrSjNOL2RGRERYMzAvdEV1?=
 =?utf-8?B?VnVib0twdlRDQ3BmNFRocXE5NWo5NVVtSzRwYmtDdXI0VkRoUXM1VkdYRDRI?=
 =?utf-8?B?K3g1eUMvUzJBQjlkSkVaNFBNUlBDVjloWmpDaE5sWGVvTzZLQ09yZ2dMNjFn?=
 =?utf-8?B?cC81Y1krYXJkS3p0WG0wcGNjZ3V2T2I1ZDFJdnVVbHVJSk9aZkJkd1hSTkI5?=
 =?utf-8?B?Sm0zcHpZQWRFOHlRVkFjaUtMdUQ3QytaV2RPWHF5UUl6Mjg3OVNvVDEyN1Q4?=
 =?utf-8?B?enBoMldqcmFvSm9EdnI3a0FwMUhjRnlOelRTSmJaVE85ejY5SkJRTVE5ZlNx?=
 =?utf-8?B?cDVOVHMxTG1IS3Z4aXdOT2ordG9VSHVVZmdUR1FMWmpJMlQ5YlhwMFN6clJN?=
 =?utf-8?B?aXdIcXd6L2xCT2U1Zktqc3BtNEdXYTFJbSthcmRqNkxTT29YbnhkeGtLWWRa?=
 =?utf-8?B?VzRtMm9MWnJGM3lzMGZjT1hWV0VKa3duSjR0U1VwR2pBUGFUTFFzS3g1dlZM?=
 =?utf-8?B?UzVPUCtNNGM1OGR4T29RMmpVMmRzUjdBMm5UUlRoSUZsVWJoa0Q5cW1xdXda?=
 =?utf-8?B?d1oxZ1hmanNLa2l6VVJoajVSc0FybUxsQ3Y1YXNBY09FY3oyQ1lkaU9KeXZG?=
 =?utf-8?B?a1FOdEl1R1dqcWo2S0tPZ0NHeTBRT3lRMDZEazZ0RFZ3cUdPNDcraWUvakFo?=
 =?utf-8?B?SHBLdXZJc2lRL3lXeTRDSGFmcHlHbmhPbkxFZG1HUVFUcHdjWWRvenVvejJT?=
 =?utf-8?B?VnNoTjE1V3UzUEwrR0F0Z2VsTitZYlpqOWN4bU5LQWREcDZHbnBCZ3NId3Q0?=
 =?utf-8?B?c3NBWVo2Y2FvUWVGNjN0RzMxczFLeFJNbERvVHlnZXBUUGc1WkxsM0hRMUZB?=
 =?utf-8?Q?kr0G2tJWLgsT3b6evl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7308672-ab2a-45ca-f0b0-08df390cee04
X-MS-Exchange-CrossTenant-AuthSource: IA3PR12MB923065.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 18:13:00.6254 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dZZFkBBmVnGnslR4ZKgXVICnIn7WpumgSTmd+J14MvaN0d5OpOJeMRYzDLAU5REvv6kIbY+gPn+Mu4knY2e3gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5993
Received-SPF: pass client-ip=2a01:111:f403:c10d::1;
 envelope-from=tdave@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Validate the fixed BAR configuration specified through the
fixed-bar-N properties on PCI endpoint devices.

Configuring any fixed-bar-N property on an endpoint device requires
every memory BAR on that device to have a fixed address. Validate
that each assigned address:

- is aligned to its BAR size;
- is within the appropriate PCIe MMIO aperture; and
- does not overlap any other fixed BAR.

A 32-bit BAR must lie in the 32-bit aperture. A prefetchable 64-bit BAR
must lie in the 64-bit aperture so that all prefetchable BARs can be
accommodated in a single 64-bit prefetchable bridge window. A
non-prefetchable 64-bit BAR may lie in either aperture when attached
directly to the host bridge, but must lie below 4GiB when placed behind
a PCI bridge.

Under a PCIe topology with a root port, fixed BAR placement is
all-or-nothing within that root port's subtree. If any one endpoint
device below the root port has a fixed BAR, every other endpoint
device below that same root port with a memory BAR must have all of
its memory BARs fixed too.

Endpoint devices with no root port in their ancestry, such as those
attached directly to the host bridge, are not required to match
their sibling devices. One such device may use fixed-bar-N for all
of its memory BARs while another sibling device on the same host
bridge uses none at all. Per-device completeness still applies
regardless of ancestry. Once any fixed-bar-N property is set on a
device, every memory BAR on that device must be fixed.

Report a validation failure through the Error ** argument and leave
it to the caller to decide how to handle it.

Signed-off-by: Tushar Dave <tdave@nvidia.com>
---
 hw/pci/meson.build              |   1 +
 hw/pci/pci-fixed-bar-validate.c | 365 ++++++++++++++++++++++++++++++++
 hw/pci/pci-fixed-bar-validate.h |  22 ++
 3 files changed, 388 insertions(+)
 create mode 100644 hw/pci/pci-fixed-bar-validate.c
 create mode 100644 hw/pci/pci-fixed-bar-validate.h

diff --git a/hw/pci/meson.build b/hw/pci/meson.build
index 984c7327e5..150085c997 100644
--- a/hw/pci/meson.build
+++ b/hw/pci/meson.build
@@ -19,6 +19,7 @@ endif
 pci_ss.add(files('pcie.c', 'pcie_aer.c'))
 pci_ss.add(files('pcie_doe.c'))
 system_ss.add(when: 'CONFIG_PCI_EXPRESS', if_true: files('pcie_port.c', 'pcie_host.c'))
+system_ss.add(when: 'CONFIG_PCI_EXPRESS', if_true: files('pci-fixed-bar-validate.c'))
 system_ss.add_all(when: 'CONFIG_PCI', if_true: pci_ss)
 
 stub_ss.add(files('pci-stub.c'))
diff --git a/hw/pci/pci-fixed-bar-validate.c b/hw/pci/pci-fixed-bar-validate.c
new file mode 100644
index 0000000000..522d879113
--- /dev/null
+++ b/hw/pci/pci-fixed-bar-validate.c
@@ -0,0 +1,365 @@
+/*
+ * Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved
+ * BAR address validation for fixed-BAR placement.
+ *
+ * Written by Tushar Dave
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/pci/pci.h"
+#include "hw/pci/pci_bridge.h"
+#include "hw/pci/pci_host.h"
+#include "hw/pci/pcie_port.h"
+#include "qapi/error.h"
+#include "qemu/range.h"
+#include "qemu/units.h"
+#include "pci-internal.h"
+#include "pci-fixed-bar-validate.h"
+
+/*
+ * Claimed BAR ranges — detect inter-device and inter-hierarchy overlaps
+ * across all fixed BARs system-wide.
+ */
+
+typedef struct {
+    uint64_t    start;
+    uint64_t    end;
+    const char *owner;  /* device name, for error messages */
+    int         bar;
+} FixedClaim;
+
+static void fixed_claims_init(FixedBarsInfo *info)
+{
+    info->claims = g_array_new(false, true, sizeof(FixedClaim));
+}
+
+static void fixed_claims_free(FixedBarsInfo *info)
+{
+    g_array_free(info->claims, true);
+    info->claims = NULL;
+}
+
+static bool fixed_claims_overlap(FixedBarsInfo *info,
+                                 uint64_t start, uint64_t end,
+                                 const char **owner_out, int *bar_out,
+                                 uint64_t *start_out, uint64_t *end_out)
+{
+    FixedClaim *c;
+    guint i;
+
+    for (i = 0; i < info->claims->len; i++) {
+        c = &g_array_index(info->claims, FixedClaim, i);
+        if (ranges_overlap(start, end - start + 1,
+                           c->start, c->end - c->start + 1)) {
+            *owner_out = c->owner;
+            *bar_out   = c->bar;
+            *start_out = c->start;
+            *end_out   = c->end;
+            return true;
+        }
+    }
+    return false;
+}
+
+static void fixed_claims_add(FixedBarsInfo *info,
+                             uint64_t start, uint64_t end,
+                             const char *owner, int bar)
+{
+    FixedClaim cl;
+
+    cl.start = start;
+    cl.end   = end;
+    cl.owner = owner;
+    cl.bar   = bar;
+    g_array_append_val(info->claims, cl);
+}
+
+/*
+ * Check that the BAR [start..end] fits in the window [base..limit].
+ * Both ranges are inclusive.
+ */
+static bool bar_in_window(uint64_t start, uint64_t end,
+                          uint64_t base, uint64_t limit)
+{
+    return start >= base && end <= limit;
+}
+
+static bool validate_bars(PCIDevice *pdev, FixedBarsInfo *info,
+                          bool is_fixed_subtree, Error **errp)
+{
+    const char  *devname = DEVICE(pdev)->id ? DEVICE(pdev)->id : pdev->name;
+    const char  *overlap_owner;
+    bool         has_fixed_bars = false;
+    bool         is_64bit;
+    uint64_t     addr, end, overlap_start, overlap_end;
+    PCIIORegion *r;
+    int          overlap_bar;
+    int          i;
+
+    for (i = 0; i < PCI_NUM_REGIONS - 1; i++) {
+        if (pdev->fixed_bar_addr[i] != PCI_BAR_UNMAPPED) {
+            has_fixed_bars = true;
+            break;
+        }
+    }
+
+    if (is_fixed_subtree && !has_fixed_bars) {
+        error_setg(errp, "fixed-bar: %s [%02x:%02x.%x] under fixed-bar root "
+                   "port has memory BARs but no fixed-bar-N= specified",
+                   devname, pci_dev_bus_num(pdev),
+                   PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
+        return false;
+    }
+
+    if (!has_fixed_bars) {
+        return true;
+    }
+
+    /* Completeness: every memory BAR must have an address. */
+    for (i = 0; i < PCI_NUM_REGIONS - 1; i++) {
+        r = &pdev->io_regions[i];
+        if (!r->size || (r->type & PCI_BASE_ADDRESS_SPACE_IO)) {
+            continue;
+        }
+        if (pdev->fixed_bar_addr[i] == PCI_BAR_UNMAPPED) {
+            error_setg(errp, "fixed-bar: %s [%02x:%02x.%x] BAR%d "
+                       "missing a fixed-bar-N= value",
+                       devname, pci_dev_bus_num(pdev),
+                       PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn), i);
+            return false;
+        }
+    }
+
+    /* Per-BAR checks: alignment, MMIO window, overlap. */
+    for (i = 0; i < PCI_NUM_REGIONS - 1; i++) {
+        r = &pdev->io_regions[i];
+        if (!r->size || (r->type & PCI_BASE_ADDRESS_SPACE_IO)) {
+            continue;
+        }
+
+        is_64bit = !!(r->type & PCI_BASE_ADDRESS_MEM_TYPE_64);
+        addr     = (uint64_t)pdev->fixed_bar_addr[i];
+
+        if (r->size - 1 > UINT64_MAX - addr) {
+            error_setg(errp, "fixed-bar: %s [%02x:%02x.%x] BAR%d "
+                       "addr=0x%"PRIx64" + size=0x%"PRIx64" overflows",
+                       devname, pci_dev_bus_num(pdev),
+                       PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn),
+                       i, addr, r->size);
+            return false;
+        }
+        end = addr + r->size - 1;
+
+        if (is_64bit && !(r->type & PCI_BASE_ADDRESS_MEM_PREFETCH) &&
+            !pci_bus_is_root(pci_get_bus(pdev)) && end >= 4 * GiB) {
+            error_setg(errp, "fixed-bar: %s [%02x:%02x.%x] BAR%d is a "
+                       "non-prefetchable 64-bit BAR behind a PCI bridge "
+                       "and cannot be placed above 4GB",
+                       devname, pci_dev_bus_num(pdev),
+                       PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn), i);
+            return false;
+        }
+
+        if (addr & (r->size - 1)) {
+            error_setg(errp, "fixed-bar: %s [%02x:%02x.%x] BAR%d "
+                       "addr=0x%"PRIx64" not aligned to size=0x%"PRIx64,
+                       devname, pci_dev_bus_num(pdev),
+                       PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn),
+                       i, addr, r->size);
+            return false;
+        }
+
+        /*
+         * A 32-bit BAR must fit in the 32-bit window; a 64-bit BAR in either,
+         * except a prefetchable one, which must be above 4GiB.
+         */
+        if (is_64bit && (r->type & PCI_BASE_ADDRESS_MEM_PREFETCH)) {
+            if (!bar_in_window(addr, end,
+                               info->mmio64_base, info->mmio64_limit)) {
+                error_setg(errp, "fixed-bar: %s [%02x:%02x.%x] BAR%d "
+                           "[0x%"PRIx64"..0x%"PRIx64"] outside the 64-bit "
+                           "window [0x%"PRIx64"..0x%"PRIx64"]",
+                           devname, pci_dev_bus_num(pdev),
+                           PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn),
+                           i, addr, end,
+                           info->mmio64_base, info->mmio64_limit);
+                return false;
+            }
+        } else if (is_64bit) {
+            if (!bar_in_window(addr, end,
+                               info->mmio32_base, info->mmio32_limit) &&
+                !bar_in_window(addr, end,
+                               info->mmio64_base, info->mmio64_limit)) {
+                error_setg(errp, "fixed-bar: %s [%02x:%02x.%x] BAR%d "
+                           "[0x%"PRIx64"..0x%"PRIx64"] outside both the "
+                           "32-bit window [0x%"PRIx64"..0x%"PRIx64"] and "
+                           "the 64-bit window [0x%"PRIx64"..0x%"PRIx64"]",
+                           devname, pci_dev_bus_num(pdev),
+                           PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn),
+                           i, addr, end,
+                           info->mmio32_base, info->mmio32_limit,
+                           info->mmio64_base, info->mmio64_limit);
+                return false;
+            }
+        } else if (!bar_in_window(addr, end,
+                                  info->mmio32_base, info->mmio32_limit)) {
+            error_setg(errp, "fixed-bar: %s [%02x:%02x.%x] BAR%d "
+                       "[0x%"PRIx64"..0x%"PRIx64"] outside the 32-bit "
+                       "window [0x%"PRIx64"..0x%"PRIx64"]",
+                       devname, pci_dev_bus_num(pdev),
+                       PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn),
+                       i, addr, end,
+                       info->mmio32_base, info->mmio32_limit);
+            return false;
+        }
+
+        if (fixed_claims_overlap(info, addr, end, &overlap_owner,
+                                 &overlap_bar, &overlap_start, &overlap_end)) {
+            error_setg(errp, "fixed-bar: %s [%02x:%02x.%x] BAR%d "
+                       "[0x%"PRIx64"..0x%"PRIx64"] overlaps %s BAR%d "
+                       "[0x%"PRIx64"..0x%"PRIx64"]",
+                       devname, pci_dev_bus_num(pdev),
+                       PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn),
+                       i, addr, end, overlap_owner, overlap_bar,
+                       overlap_start, overlap_end);
+            return false;
+        }
+
+        fixed_claims_add(info, addr, end, devname, i);
+    }
+
+    info->any_fixed = true;
+    return true;
+}
+
+typedef struct {
+    FixedBarsInfo *info;
+    bool           is_fixed_subtree;
+    Error         **errp;
+} ScanState;
+
+static void scan_bus(PCIBus *bus, ScanState *state);
+
+static void mark_if_fixed(PCIBus *bus, PCIDevice *pdev, void *opaque)
+{
+    bool *found = opaque;
+    PCIBus *sec;
+    int i;
+
+    if (*found) {
+        return;
+    }
+    for (i = 0; i < PCI_NUM_REGIONS - 1; i++) {
+        if (pdev->fixed_bar_addr[i] != PCI_BAR_UNMAPPED) {
+            *found = true;
+            return;
+        }
+    }
+    if (object_dynamic_cast(OBJECT(pdev), TYPE_PCI_BRIDGE)) {
+        sec = pci_bridge_get_sec_bus(PCI_BRIDGE(pdev));
+        if (sec) {
+            pci_for_each_device_under_bus(sec, mark_if_fixed, found);
+        }
+    }
+}
+
+/*
+ * True if any device in rp_bus's subtree (the bus behind a root port)
+ * has a fixed BAR.
+ */
+static bool root_port_subtree_has_fixed_bar(PCIBus *rp_bus)
+{
+    bool found = false;
+
+    pci_for_each_device_under_bus(rp_bus, mark_if_fixed, &found);
+    return found;
+}
+
+static void scan_bus_device(PCIBus *bus, PCIDevice *pdev, void *opaque)
+{
+    ScanState   *state = opaque;
+    bool         has_mem_bar = false;
+    PCIIORegion *r;
+    PCIBus      *sec;
+    int          i;
+
+    if (*state->errp) {
+        return;
+    }
+
+    for (i = 0; i < PCI_NUM_REGIONS - 1; i++) {
+        r = &pdev->io_regions[i];
+        if (r->size && !(r->type & PCI_BASE_ADDRESS_SPACE_IO)) {
+            has_mem_bar = true;
+            break;
+        }
+    }
+
+    if (has_mem_bar &&
+        !validate_bars(pdev, state->info, state->is_fixed_subtree,
+                       state->errp)) {
+        return;
+    }
+
+    if (!object_dynamic_cast(OBJECT(pdev), TYPE_PCI_BRIDGE)) {
+        return;
+    }
+    sec = pci_bridge_get_sec_bus(PCI_BRIDGE(pdev));
+    if (!sec) {
+        return;
+    }
+
+    if (object_dynamic_cast(OBJECT(pdev), TYPE_PCIE_ROOT_PORT)) {
+        ScanState child = {
+            .info = state->info,
+            .is_fixed_subtree = root_port_subtree_has_fixed_bar(sec),
+            .errp = state->errp,
+        };
+        scan_bus(sec, &child);
+    } else {
+        scan_bus(sec, state);
+    }
+}
+
+static void scan_bus(PCIBus *bus, ScanState *state)
+{
+    pci_for_each_device_under_bus(bus, scan_bus_device, state);
+}
+
+static void scan_all_host_bridges(FixedBarsInfo *info, Error **errp)
+{
+    PCIHostState *hb;
+    ScanState state = {
+        .info = info,
+        .is_fixed_subtree = false,
+        .errp = errp,
+    };
+
+    fixed_claims_init(info);
+    QLIST_FOREACH(hb, &pci_host_bridges, next) {
+        if (hb->bus) {
+            scan_bus(hb->bus, &state);
+        }
+    }
+    fixed_claims_free(info);
+}
+
+/*
+ * fixed_bars_validate - scan all PCI devices, validate fixed BAR addresses.
+ *
+ * @info: carries MMIO window bounds for validation.
+ * @errp: set on a validation error.
+ *
+ * Returns true if every BAR validated, false with @errp set otherwise.
+ * Whether any fixed BAR device was found is left in info->any_fixed.
+ */
+bool fixed_bars_validate(FixedBarsInfo *info, Error **errp)
+{
+    ERRP_GUARD();
+
+    info->any_fixed = false;
+    scan_all_host_bridges(info, errp);
+    return !*errp;
+}
diff --git a/hw/pci/pci-fixed-bar-validate.h b/hw/pci/pci-fixed-bar-validate.h
new file mode 100644
index 0000000000..f4996f27d9
--- /dev/null
+++ b/hw/pci/pci-fixed-bar-validate.h
@@ -0,0 +1,22 @@
+/*
+ * Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved
+ *
+ * Written by Tushar Dave
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef HW_PCI_FIXED_BAR_VALIDATE_H
+#define HW_PCI_FIXED_BAR_VALIDATE_H
+
+typedef struct {
+    bool      any_fixed;
+    uint64_t  mmio32_base;
+    uint64_t  mmio32_limit;
+    uint64_t  mmio64_base;
+    uint64_t  mmio64_limit;
+    GArray    *claims;
+} FixedBarsInfo;
+
+bool fixed_bars_validate(FixedBarsInfo *info, Error **errp);
+
+#endif /* HW_PCI_FIXED_BAR_VALIDATE_H */
-- 
2.34.1


