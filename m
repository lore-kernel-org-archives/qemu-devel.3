Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C062C5DF97
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 00:46:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzOFh-0000XX-KX; Wed, 26 Aug 2026 20:45:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>) id 1wzOFg-0000XL-6G
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 20:45:56 -0400
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>) id 1wzOFe-00059H-LC
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 20:45:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E22o2vE2tFugfkmNY+R2GUhdUC+Atulj3hT6F/IResv4N0j1tz9B7zxR35jNRCBINK3IB3O/akbT/i41TWoEUIEk3UO3R0MdXnDgN3+e3u6ED0N4LNZu4fP0WrNee/ROJbzf0YZQSzgFnY/hhx8TYQhb7pfrgzNCn58w1h+Jho9hFTZ50+TkZRbDWg1tXNdY1G1BILNGbNeDzH4RSxP6XQ0sH1OARwvos4suNFZVUx0S4Xc0MqLbqYyTUYc47yX4VAnUhVBTvSN3l1Bdn1x2vVUBQ/Wijtdjz2rEwpBSajJhW8PhiLwiLbnTngWv2AyLKLgojjSg7weB1+ZiMQ7r/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=okEJK16vA2CLxr3Uc6yO8gJ3bmE2HDEO36dT39ljCtQ=;
 b=hotTrEIsBVJtSWrNQMpwxvM4qnFh6oIMjIVRw9w2HBd1rsFrDCFWj2aZCPoGj5SydukZzoI6VHMf2Dcp5wet5phuZ2IEAhSBsno/NrGd6xSEtXvo8ptd67w1uoSOAK/slr/XOzFBCUBkDMyOCDWV4IGsPHQZzf/fZRUZtpBbBs8N7eSEbC//cqLa4a9rpD7DqYeKlG0f52wsMFdmxwVJWARfu2dy/ozfME76XdyS5pV70ckiXtnOOQ0hB4ajWV8lEnZ6k+Hs7m7eCDK7pbuKxbwfdW2+XhFWkwhiT1lorfqmcoVfMRauD4ZDyaIW4baTBtDVsp4ryxglv8CfxOGS4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okEJK16vA2CLxr3Uc6yO8gJ3bmE2HDEO36dT39ljCtQ=;
 b=NKoRsU7VbV2ihZnOVWrh2CLNwygeuAjR1pt36ZQlWRHsY0bb6l1yAf1IQCsYQCvcLruCeT3tytCCcknT98yJMA+DtHPronX7lyx9XByFAps0Nbe72/CFCIIb3cBC+YFWpXS4Ohpcbvj6rICA6vrpxWmG33fuzgwBl2JWrljwDnu6WvriqLqou0Q9PgtbxYoD+iIthOqrUxT/1GhCn471CRw6C2CeSXF9fmBtJU03ZeyuxIk3oGkWMxWnasZE3tJCc9Yq/6NvZ0TuxjIG4FoatMdZn4V5uKXekcasUvS7j/RpPm2qJ1aNNYLhQ2xTGJ44TudU9Sqly400J0XS8y5TeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB9736.namprd12.prod.outlook.com (2603:10b6:8:225::9) by
 MN2PR12MB4221.namprd12.prod.outlook.com (2603:10b6:208:1d2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 00:45:49 +0000
Received: from DM4PR12MB9736.namprd12.prod.outlook.com
 ([fe80::ed33:f342:886b:dc8e]) by DM4PR12MB9736.namprd12.prod.outlook.com
 ([fe80::ed33:f342:886b:dc8e%6]) with mapi id 15.21.0360.006; Thu, 27 Aug 2026
 00:45:49 +0000
From: Tushar Dave <tdave@nvidia.com>
To: devel@edk2.groups.io
Cc: gaoliming@byosoft.com.cn, ardb+tianocore@kernel.org, sami.mujawar@arm.com,
 jiewen.yao@intel.com, kraxel@redhat.com, qemu-devel@nongnu.org,
 alwilliamson@nvidia.com, jgg@nvidia.com, skolothumtho@nvidia.com
Subject: [RFC PATCH v2 0/2] MdeModulePkg, OvmfPkg: fixed PCI BAR placement
Date: Wed, 26 Aug 2026 19:45:28 -0500
Message-Id: <20260827004530.600410-1-tdave@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0042.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59e::17) To DM4PR12MB9736.namprd12.prod.outlook.com
 (2603:10b6:8:225::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB9736:EE_|MN2PR12MB4221:EE_
X-MS-Office365-Filtering-Correlation-Id: f9cc2796-ad18-4d2d-3af5-08df03d489cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|56012099006|10067099003|3023799007|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 7k+7N3UtjvzpNMIJwS+Xq49Y5ykPY7IhPyOQvTFNFa8l9dO8f1eibSESEDEI2FcE2lNYE/aWjceVCPqN8iLAJKyy/ikT/8KQCi9Cfs4Qtt43t9O657nAkiGXOJssFTAEMbqQFwvbJAJAO68fgZC2LCva8sa1HzLIcZmupItDGGEfA0FDXirkrLOjQA+tqqQpi6D4zPZ0gNEfmAAzM5X6gqAop7NnN6XiJzuGyb1tf+UAxzENG9p2ZV10zuancMY7iJIUyocyrHySF4/8qShbhRruIdTywnTfrte8pyHY96svJvwZP+KsZZWAG+oLV0dukTXECXjHcjwuaMzFNj8wp6mb66BQ32OiNxlgo5M+qoBKbjgvyeHbW5S0jzd6dHO+79pF01YlJB/rl/STNOnAaGgHs4gOTHcKz4SX3P52uZZaoRSnfoQCruhtOsFS5vftDxiRsW4Xz9Vb2zoQIjbnPzK7z3f3VIp8vMKiXGma8GwdJ6DOZUFDUen/UlgjJRpepRzD3KiPhtmeMNJsXdOUFxm4L8pA4VQ7Vpn+cw2xSZ0Qjr1V0f2KdArztfHdEImLKV/H962mqnIUzT4NJpTetwhYAVhzOio4xGg3wiDBO7i5Sy1tRUR1GXLODmYVdaxBHMqhDMKhvy4ATjtG1csO6W/1J9G5D5zLpqkiEK8h07Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB9736.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(56012099006)(10067099003)(3023799007)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cOStaTG/Bk1kzZOecJroHfJGo7RSAspqIG0G2/1oSa3KgqV5homa4HQuEraK?=
 =?us-ascii?Q?6GocS7ZOJV4NcodF6+M3QoMDRbjuVS9dRbCguCzx51/1ba9GctFrSAEGXIrJ?=
 =?us-ascii?Q?XWnQ17omiZYN0hb76i1ORmvSQLO6VZxbjnOaVSmYAZls5qQeSohtTm3yR9jV?=
 =?us-ascii?Q?+vOhfUk6PN5H0NcrhqvzWDPxGBqSlxYA4RCaKezsLAdQTgDd7hFxJ3v6602o?=
 =?us-ascii?Q?jTZSEG94U7ennFuntDKpcO3lWAGhDquoklaZqe+ajiJbp92ZmH59Vh0JzdDq?=
 =?us-ascii?Q?zzEbmnWfVDuheODFCPuCPbzhk5PVo3LCnyU1e3mSTbDjemq+M1CMvM3PgXMT?=
 =?us-ascii?Q?EDEoPlqmTnejnr4t2AW7OYrqawAQ3bkRpkeNb+nOh1Cpe1KiSPyvYEN5oaX2?=
 =?us-ascii?Q?OcbQm8v86XpQ6y3+hAJXexlVKlwuOhv12MCXo3PCmkmoeD0hFfy++8Vy7J9e?=
 =?us-ascii?Q?hyogenT8DZvV26YnJsWhN7ow+SsRAsZUhkw0RRhbKR2tU2ZJu+4hVf/aaka0?=
 =?us-ascii?Q?c0dEmGOpn91NlkRdfDhK3AOMyFkmwTIMJIbtnmKW+ri0tueDI5Rll2eaejST?=
 =?us-ascii?Q?NggQdZf2hEB1T/LV/RsC4Kj4SfEyRCPHakXrIALw+7hZQmMh5hacrcmMpjkn?=
 =?us-ascii?Q?zFvJfsLLYsDRlCIJcl/gNtVlqvNh9JuVuQ5YQuV5MQE6MBpMvlnQKQYsFY07?=
 =?us-ascii?Q?rbHf+ObsGE+3MHcsc1jOlsgtxqjHjWn+BPhEiUne8185qSlSuxcyk7CS3rcT?=
 =?us-ascii?Q?YZnxr5poFj4L4cZ02KctSH+pg4e/8BvM8pT8hx9SGZOJ732JcOog6TyoeqLG?=
 =?us-ascii?Q?XF3or5mEWwbCdl9vEWspC2R4tXTlks7lAVUAqNvWUx3otpfApnaFg8QvkJrt?=
 =?us-ascii?Q?ct3wGO/TC9QAZ8zE1lJiAItbvK7w5Z4Qgdm9jzx1jKRd2DHYgTf9oDGQMWQ0?=
 =?us-ascii?Q?YbplpMIH94JE/vH1O1RwyhME4datL5+hFznVJPtdpJObB6y8maRn/0uvocdh?=
 =?us-ascii?Q?L6C+xZ3B+QRw7fx3BAbsirJUFYHBLzyC/DBZgaxuSsgpFQ/pdq9kWNSVUbsj?=
 =?us-ascii?Q?nNPVyg0GqTHsYXISpN4VQSvRxVcbH17VHnRIFLbIK+rD+/7dif0YyH9AJ/4y?=
 =?us-ascii?Q?AC7cMs6RoKAzEbiCay5LbKDIoy1wbaIv4MOiMWtu5TNO8dbME7osWCaEXPNZ?=
 =?us-ascii?Q?fFz0TUU5VDR03O0DirG4132DJxtJpQzE8auqCDQewRRXwhoeClhJ9zcRsuxl?=
 =?us-ascii?Q?7X2fUoG3lg7euJDm/QQzXuXxm9D7MyfIMXod/6L+6hD39uPtpecqqoopk+By?=
 =?us-ascii?Q?wPXwom28SGD9EDUaWJxo4hcV5qU29Y5I7ecjZ4EEYd5AXXk/BKfhrQIOVZHx?=
 =?us-ascii?Q?X3TeTmZNChOWbvDiVmk/avBnObOF9bB2aDbT2yzkziGRRP43wwftwTB0wRkQ?=
 =?us-ascii?Q?5+ROhLR57qRQ4Y7DYvXixKFujGZnuctdduwvUk36o4K4zSDGwvgEQwU7Gy2n?=
 =?us-ascii?Q?y1bShWt/Y4Uaqj/XLyrRfwmIleHKbFIKetceGs/0CEWVLXS0PKIpNoC1r5nq?=
 =?us-ascii?Q?Ul9DXVjjzADt4/gYQ59yZYpxX8pshIARZ4YLwvhW2MZjNhXIslBAvi03zOss?=
 =?us-ascii?Q?lBD4qljV049Ymn9tF5z0kykzz3MKE1DI5tUd6uFwk8GOhYg7elF6o4uuY/4k?=
 =?us-ascii?Q?ae7HhIHxSsrbaPZGXxqjuUaVQQKFZejXPnzwulZwVt1rF5z5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9cc2796-ad18-4d2d-3af5-08df03d489cf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB9736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 00:45:49.0972 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nKrns981uOicx4yjuvzrP9rzwuiLHdknY/3BM9Dn0bAaf5wssfbljlwYNKUFlupMooKmRZgic3RErrHQaCExkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4221
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=tdave@nvidia.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
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

This is the EDK2 companion to the QEMU RFC v2 series [1].

This series implements the firmware side of fixed PCI BAR placement.
QEMU exports validated fixed BAR addresses through the
`etc/fixed-bars` fw_cfg file. This series consumes that information
in two steps.

Patch 1 adds minimal changes to `PciBusDxe` to honor fixed BAR
addresses supplied through `EFI_INCOMPATIBLE_PCI_DEVICE_SUPPORT_PROTOCOL`.
When both `_MIF` and `_MAF` flags are set in an ACPI address
descriptor returned by `CheckDevice()`, the described address is
treated as a fixed requirement. `UpdatePciInfo()` records the fixed
address on the BAR and `ProgramBar()` uses it in place of the
GCD-allocated address.

Patch 2 introduces `QemuFixedBarsDxe`, a new OvmfPkg driver that
installs `EFI_INCOMPATIBLE_PCI_DEVICE_SUPPORT_PROTOCOL` before
`PciBusDxe` starts. It reads the `etc/fixed-bars` fw_cfg blob,
reserves the required address ranges in the GCD, and returns fixed
BAR addresses through `CheckDevice()`. After `PciEnumerationComplete`,
it reprograms bridge memory windows along each fixed root-port
hierarchy to cover the fixed BAR placements.

Testing:

The series was tested together with the QEMU companion patches on
the AArch64 `virt` machine using multiple PCI topologies, including
emulated devices, VFIO passthrough devices, PCIe switches, and PCIe
root ports configured for fixed BAR placement.

A git branch with this series applied is available at:
https://github.com/tdavenvidia/edk2/tree/RFC-v2-fixed-bar-upstream

[1] companion QEMU RFC v2
https://github.com/tdavenvidia/upstream-qemu/tree/RFC-v2-fixed-bar-upstream

Tushar Dave (2):
  MdeModulePkg/PciBusDxe: honor fixed BAR addresses from IncompatiblePci
  ArmVirtPkg,OvmfPkg: add QemuFixedBarsDxe for fixed PCI BAR placement

 ArmVirtPkg/ArmVirtQemu.dsc                    |   1 +
 ArmVirtPkg/ArmVirtQemuFvMain.fdf.inc          |   1 +
 MdeModulePkg/Bus/Pci/PciBusDxe/PciBus.h       |   1 +
 .../Bus/Pci/PciBusDxe/PciEnumeratorSupport.c  |  12 +
 .../Bus/Pci/PciBusDxe/PciResourceSupport.c    |  13 +
 OvmfPkg/QemuFixedBarsDxe/QemuFixedBarsDxe.c   | 772 ++++++++++++++++++
 OvmfPkg/QemuFixedBarsDxe/QemuFixedBarsDxe.inf |  43 +
 7 files changed, 843 insertions(+)
 create mode 100644 OvmfPkg/QemuFixedBarsDxe/QemuFixedBarsDxe.c
 create mode 100644 OvmfPkg/QemuFixedBarsDxe/QemuFixedBarsDxe.inf

-- 
2.34.1


