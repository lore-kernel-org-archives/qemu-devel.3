Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F8FAC61DBE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 00:46:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzOFx-0000fU-GS; Wed, 26 Aug 2026 20:46:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>) id 1wzOFu-0000cz-Eh
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 20:46:10 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>) id 1wzOFr-00059u-64
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 20:46:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZyFFIVXiz2qn9ySrynqnZGtGUhHGkCbOjHAaOI/N3dmBGOBfkpdLFxK371xSpikebidPDANrwyS+Eyo+jopbn3oxzWujUNGbOnUO7TU136MGZsOb87+E248lsIeVqGpYK61ZEbh0X34RucHAaqmuAVzN8t5Ku1fZMOGpAsqZ7HsMx933/YDjx2I35C3nfNQwJEIOk25ZIRAfaSpN5FjRdGCbEmjWu3pmroFu9RcTMJB3n1lvdQuOPVMpecxcaA8HEDHeAnSzNzJKyXsg2wRgX0IY+YoTHAV4x7xd5ZkC2+YQvQYTyItmR38/kUSR7t3bYBKY9O+kLXN0yf9Lwrnt6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YNBAH47CcRQP3R1g9Ifrp5TwuWceeu57MvAWKpRWqjA=;
 b=pC/CEHfyz8w204pS7nNjPDFIWGFMcbFR8WIXLX/atk0mWeUr+dt/k5tVTZX4mMzo6t9w1uUa2UpGTS8tGY+nBPvMEnvfciIRyVFmOZDXw2a6R0MLN2BGiHoKWwBecQ7NfYGO49kvXPzoe501pIPFRWNSfbyNqsNkFbWiEqqSPOYMY1EEDdl4rPmLOpdU5MPpGWBvhm0TtVuZtp+xyT+G1IySdLGFYjDBUu3hXjicdikvfbE+obt30v4smAvCJiFlkPKCptQSblHrDdrQpIZB5r9669j+kaC75/UGbbdGTnPRqO/HYiJKMyMBwN+w2mcgMm9c68hYssOGhHaVewXTng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YNBAH47CcRQP3R1g9Ifrp5TwuWceeu57MvAWKpRWqjA=;
 b=X8u4ggZihQASeLEzKTKduCerTEpN8IPIF93sCNdpeIUxhruBOyl9ZF+4OXfQvur//4IxAkGHhDd4HkT9YkQdl/snL/xbhVzCdLEtexIPBc7W0N1XGDuqviO5UGL8ltaq84eAnB5WfifEagMVeZ/GOy2/vWGbZWZ60HyFAokFIqTTcV+l2czjWZAe5Ga2E7Zy6sZTzQV3IjVVMD/y71Gpz4LMbKx0jyQK6x3voxz3VkCRh3/Sj9lqhFJ/xC1MqMuJxphoHJk3FCv+OIKrzVc9GSn3v6AKaX9R0XR2Zq3Z64mMbr8FqMELY5HSenBOP9sPIZanVtWyo3BJTfkox15XMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB9736.namprd12.prod.outlook.com (2603:10b6:8:225::9) by
 MN2PR12MB4221.namprd12.prod.outlook.com (2603:10b6:208:1d2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 00:45:52 +0000
Received: from DM4PR12MB9736.namprd12.prod.outlook.com
 ([fe80::ed33:f342:886b:dc8e]) by DM4PR12MB9736.namprd12.prod.outlook.com
 ([fe80::ed33:f342:886b:dc8e%6]) with mapi id 15.21.0360.006; Thu, 27 Aug 2026
 00:45:52 +0000
To: devel@edk2.groups.io
Cc: gaoliming@byosoft.com.cn, ardb+tianocore@kernel.org, sami.mujawar@arm.com,
 jiewen.yao@intel.com, kraxel@redhat.com, qemu-devel@nongnu.org,
 alwilliamson@nvidia.com, jgg@nvidia.com, skolothumtho@nvidia.com
Subject: [RFC PATCH v2 2/2] ArmVirtPkg,
 OvmfPkg: add QemuFixedBarsDxe for fixed PCI BAR placement
Date: Wed, 26 Aug 2026 19:45:30 -0500
Message-Id: <20260827004530.600410-3-tdave@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260827004530.600410-1-tdave@nvidia.com>
References: <20260827004530.600410-1-tdave@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR21CA0002.namprd21.prod.outlook.com
 (2603:10b6:a03:114::12) To DM4PR12MB9736.namprd12.prod.outlook.com
 (2603:10b6:8:225::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB9736:EE_|MN2PR12MB4221:EE_
X-MS-Office365-Filtering-Correlation-Id: 0590a517-2467-40a7-642c-08df03d48bf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|56012099006|10067099003|6133799003|5023799004|3023799007|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 5+qfjG2kpO1itHhB1f9+55aH3HxABuswckDrPMet5pUaLRrwQwDne/JKYEZg5QPwqSbF6HdQD6u1+TzhExLteE658jgkyORjUxglOPWbPvHsp9unQMHYM9fNxiojIR645ZJTNyewDbWU1w/At3VEgCNMS7ACf6eu/ikH/Wg01g8EXZkQ4dlbxU2CrWOzK4avbNPHyEu+BtbhLXgyp5FrAnRftZr8rikLhhyCcnRt79yhS8fgsF57Nc/XIHi0gvnOM9MtARfovs+eaRYiRfiOhOhfFust4miNH1uKsYxHCtcr2HJFLOYuwzp2Ip/8dYjhJlL7zoV3msEoLRyeV3Rgrpi8P/OtDrgj//EkHjW4j0A4XkwAjRuezKEl674ZOlspS0NzG+kvswBJZpjPxwQiiao39mLrQIW1d+uPw6/jGb5TEBNtRUJ8AE6LRmP5NFLMuEOW67cv2CYlZIXXT59O3YIWX/LNC4WS+beUy2868MBhK/wE6mjC7Xz74BEckP2B/3fNBAq6Ucc3imSjGaNNNZOZtD2kqz2rxvpbn1HAd9O+b0L1BrZNIVvnhD+TB2E8hyFYshi5p4VSUFACdhWQUZwLapO6+LVVA7GsZZ+jQ3A2FdZR2a5kx5DTfqwEvrdrMfU3jXuatgj9s1pKc2QC8OYdORgCZshUtAKW3N9ggEc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB9736.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(56012099006)(10067099003)(6133799003)(5023799004)(3023799007)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1BQMDRUQXNNTEtOQkMrQWs1eHhYV0p0OU9HczdEdTA3TkpxREZQTk1GT0o2?=
 =?utf-8?B?ZFdwKzBaUkI1dXJGZUVIaFNYZFBTRnBFRHNwZDJNT2c0aHl2bm5ENGJwVnNm?=
 =?utf-8?B?Z3dMYjNhVHFNUnpORmFxcWYxWCtlNS9BbGxUQ210Mlc4aWJZL3d3cTBEREdP?=
 =?utf-8?B?czM1ZDZsN3ByVDQvZVh0V0krZ0VvaFluZlN0QkVoZkhmczFSRW9pV1BsTVhi?=
 =?utf-8?B?ZHpoTDc0cklqbHZSekJCYnR1Z3NKNHVlc0UwVUROeXgycEtUNnZTWDBJK01G?=
 =?utf-8?B?bGZWR1FnNU1LUWZKOXpuQk9idTNkdG9qcVovUEZWcm40Tyt4YnZEVm03WXlX?=
 =?utf-8?B?cUEzOTRkYW4rMnpuK00rMUZ3NGZxVGEwdm9TcitsQjlkUlltQzJKcEtQZSt1?=
 =?utf-8?B?Qk5kSHE1M2UxQmtDTDE5R1RZQ2drL21kNDVVbzNFYTdqSjk1UXJHdlBsK3BJ?=
 =?utf-8?B?WDIwdkNXczdyUmhpVE80b2ZHNlcrZHpwTWFJMU9wTGpvRThFalA5a3VTTDRl?=
 =?utf-8?B?Rk16SnlXZVVZbm4yNzJncVE4WVZ5d0NoYlB6UFovSkhwQTRia09uRFhFR0JU?=
 =?utf-8?B?OWs0MkNrOGZZb0Zsb2gvQzA1a1d2UFBPbjdHVFJGQkxUWjdheWlZZW8rT0Za?=
 =?utf-8?B?MWVWdGduVUw0dmdScnpDTnVLNnBhMXlVYkpQTlI3QTJ3UnlEaFpuckVmWFZu?=
 =?utf-8?B?bTh3ek02VTNOQUZpNHdJMmoreDYyZW5BY3psUEllSm8wSnhTNFNjMG91Mlow?=
 =?utf-8?B?RTdwUG1QTjZWR2c1MUgrK2ttcXEreG53Vm42TkhOWUU0VzFRU3V0WFpnd3Q0?=
 =?utf-8?B?ck9BbVpvMm5KWEpyMFE4L0c1M016L1lYOWZyNE9DbXRmKzFIRmczTTRyd0pa?=
 =?utf-8?B?RWpMZldXeHVJT3VSSWw4b1hCZlVMNlA0U0ZEQlI4QWVvZFBXMlRCQi9HaWtq?=
 =?utf-8?B?WVVuK0pBUitJK0pOOFltZVcyU1V2b1B4QnVOQjVaTVRMdGNIUjdqeVlaZVpt?=
 =?utf-8?B?OVF3b29MQ0Rtc1YyeklzcVd4MWZFL0p1Qnk3aXVRQnFiTm04K3cxQ3YwbHFq?=
 =?utf-8?B?U3pzZXBWYzY2Vy9vRmhDc2hmZnNvUFFaU2ZpQnduMS9JcnROeSs3QTlxMUZ1?=
 =?utf-8?B?NWUrRWxPMUJxeGZJZHFJd2wrc2RqL0J1VngrQTBNdzIwM3BHaDdzYWpSMlB2?=
 =?utf-8?B?bjNZTWdJWGhSU0cxcHZ4ZlV5ZjlYdldKdDVBbERYVjhIYzhBeEJsRVIrRXdr?=
 =?utf-8?B?TTYvSktodjBQejBkcjA5Sm9SVHM5Tk5MYjAvUXdQZDM4T3gycEVzc3hnMDkz?=
 =?utf-8?B?bGh6UFJmbXZoMjg1WGJQNGZrNm5xNllTeXduVzRtWlNzM3NZMHFHOTRLTlRL?=
 =?utf-8?B?RjNSaEdOMk44bE9MYzZTcFEyRVVmRHVmeEZ0N1JVZWI0cnU0UjNaOC9mdXdX?=
 =?utf-8?B?Yk0rVFFHWk9TdVZkdzdkZFBELzFKOGdCT0dxS0ZWendkcVNmMmFsRWNrMG5r?=
 =?utf-8?B?eDlSUlpHU3VxVC9iR1VWUmxtK2ltSU5hSkQvMU5qdmFqc3VUSjFzaENCcmtw?=
 =?utf-8?B?RkJ5dXBFRzAvVGlvcDhIYk84WVVXeU9NRFl5cUpPOWhhaGN1d2hYQW5DZGlw?=
 =?utf-8?B?bncydThrUmxaWUc2SVhRNTl6UEIrMXN6cUFRSXdLTTM0eTZIc3ExaHlUMEU0?=
 =?utf-8?B?ajNVZEgzK1Rkb1c1cGNMT2FjVTlpMXNyV2NrdDdkQ1ZFOWcxTTR1Zyt2S3gv?=
 =?utf-8?B?Ti9nTXNPTGxyZkRURWllTElOMUx5Q053Rm5lbC81cXhyQnJuaUo2VDZqQ3JP?=
 =?utf-8?B?b1RsWGkwQTJaRURjUEQ5TnJvUkY4M3dqaXRHekpDcXZYQ0tJY1lWSVVUaEhu?=
 =?utf-8?B?UytSQTVmTVlkOTNFTEtzODRCZTRuZHI5VUlFRERGWmVGVWQrTjJFbi9XbTBa?=
 =?utf-8?B?NHVUTGFpblArU0ZqaENkNE1sNGVxbC95N2RJOEVNN3I5NGxYSHZ0SzVqbDBn?=
 =?utf-8?B?NDlqTU9MVk92Z0RQNEVVZ29VWDNHOHp4Nnk1NUh5aVJMR1hhTkIwSWxGZDlt?=
 =?utf-8?B?eXNFTHQ4WHVOU2M1dmJHdUloamVlR0xldXpSa0hQRm1vZDJpOGtvZDY0YU85?=
 =?utf-8?B?TFliSllLcllDWHJHdnhjQVdtRHhoNEVhc0VNOGNmY2xEdjQ2YW8rcWgyRjBV?=
 =?utf-8?B?NTR2RHdYcGhsSTZsS05kemJPTHFuM0V2WkxJaXRDc0tSbzdNTWxyaWkyMHNa?=
 =?utf-8?B?NW92VEZ3Qld3VnJ5U3hKc3lxbWZOZmFMamwxR1czNFg3VU5PV2Q4Vkx4VFNr?=
 =?utf-8?Q?/rIaLQKxlJEci2ObS+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0590a517-2467-40a7-642c-08df03d48bf6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB9736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 00:45:52.8143 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ZXfyEbK73gaaolWeTaKncWHGF5ttlvvP6elxxLXG8zt77t+/VCCUljH+1z4PEweD1V//nqxK7RTDWgkg89pkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4221
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=tdave@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Tushar Dave <tdave@nvidia.com>
From:  Tushar Dave via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add QemuFixedBarsDxe, a DXE driver that enables fixed PCI BAR placement
using metadata provided by QEMU through the "etc/fixed-bars" fw_cfg
file.

The driver installs EFI_INCOMPATIBLE_PCI_DEVICE_SUPPORT_PROTOCOL before
PciBusDxe starts so fixed BAR addresses can be returned during
CheckDevice(). PciBusDxe then programs those addresses directly when
assigning BAR resources.

The driver also reserves the fixed BAR address ranges in GCD before PCI
enumeration and, after enumeration completes, updates PCI bridge memory
windows to cover the programmed BAR ranges.

Signed-off-by: Tushar Dave <tdave@nvidia.com>
---
 ArmVirtPkg/ArmVirtQemu.dsc                    |   1 +
 ArmVirtPkg/ArmVirtQemuFvMain.fdf.inc          |   1 +
 OvmfPkg/QemuFixedBarsDxe/QemuFixedBarsDxe.c   | 772 ++++++++++++++++++
 OvmfPkg/QemuFixedBarsDxe/QemuFixedBarsDxe.inf |  43 +
 4 files changed, 817 insertions(+)
 create mode 100644 OvmfPkg/QemuFixedBarsDxe/QemuFixedBarsDxe.c
 create mode 100644 OvmfPkg/QemuFixedBarsDxe/QemuFixedBarsDxe.inf

diff --git a/ArmVirtPkg/ArmVirtQemu.dsc b/ArmVirtPkg/ArmVirtQemu.dsc
index 0212be4a33..58164d5418 100644
--- a/ArmVirtPkg/ArmVirtQemu.dsc
+++ b/ArmVirtPkg/ArmVirtQemu.dsc
@@ -469,6 +469,7 @@
   #=0D
   # PCI support=0D
   #=0D
+  OvmfPkg/QemuFixedBarsDxe/QemuFixedBarsDxe.inf=0D
   MdeModulePkg/Bus/Pci/PciHostBridgeDxe/PciHostBridgeDxe.inf=0D
 =0D
   #=0D
diff --git a/ArmVirtPkg/ArmVirtQemuFvMain.fdf.inc b/ArmVirtPkg/ArmVirtQemuF=
vMain.fdf.inc
index ad158f57f1..879165de3f 100644
--- a/ArmVirtPkg/ArmVirtQemuFvMain.fdf.inc
+++ b/ArmVirtPkg/ArmVirtQemuFvMain.fdf.inc
@@ -157,6 +157,7 @@ READ_LOCK_STATUS   =3D TRUE
   # PCI support=0D
   #=0D
   INF UefiCpuPkg/CpuMmio2Dxe/CpuMmio2Dxe.inf=0D
+  INF OvmfPkg/QemuFixedBarsDxe/QemuFixedBarsDxe.inf=0D
   INF MdeModulePkg/Bus/Pci/PciHostBridgeDxe/PciHostBridgeDxe.inf=0D
   INF MdeModulePkg/Bus/Pci/PciBusDxe/PciBusDxe.inf=0D
   INF OvmfPkg/PciHotPlugInitDxe/PciHotPlugInit.inf=0D
diff --git a/OvmfPkg/QemuFixedBarsDxe/QemuFixedBarsDxe.c b/OvmfPkg/QemuFixe=
dBarsDxe/QemuFixedBarsDxe.c
new file mode 100644
index 0000000000..1ae45e1079
--- /dev/null
+++ b/OvmfPkg/QemuFixedBarsDxe/QemuFixedBarsDxe.c
@@ -0,0 +1,772 @@
+/** @file=0D
+  QemuFixedBarsDxe implements EFI_INCOMPATIBLE_PCI_DEVICE_SUPPORT_PROTOCOL=
=0D
+  to place PCI BAR addresses at fixed addresses using the=0D
+  etc/fixed-bars fw_cfg blob provided by QEMU.=0D
+=0D
+  Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES. All rights reserved=
.<BR>=0D
+=0D
+  SPDX-License-Identifier: BSD-2-Clause-Patent=0D
+**/=0D
+=0D
+#include <PiDxe.h>=0D
+#include <IndustryStandard/Acpi.h>=0D
+#include <IndustryStandard/Pci.h>=0D
+#include <Library/BaseMemoryLib.h>=0D
+#include <Library/DebugLib.h>=0D
+#include <Library/DxeServicesTableLib.h>=0D
+#include <Library/MemoryAllocationLib.h>=0D
+#include <Library/QemuFwCfgLib.h>=0D
+#include <Library/UefiBootServicesTableLib.h>=0D
+#include <Library/UefiDriverEntryPoint.h>=0D
+#include <Protocol/IncompatiblePciDeviceSupport.h>=0D
+#include <Protocol/PciEnumerationComplete.h>=0D
+#include <Protocol/PciIo.h>=0D
+=0D
+/* byte-for-byte identical to QEMU's structs in hw/pci/pci-fixed-bar.h */=
=0D
+#pragma pack (1)=0D
+=0D
+typedef struct {=0D
+  UINT32    Version;=0D
+  UINT32    NumDevices;=0D
+} QEMU_FIXED_BARS_HDR;                       /* 8 bytes */=0D
+=0D
+typedef struct {=0D
+  UINT16    VendorId;=0D
+  UINT16    DeviceId;=0D
+  UINT8     DevFlags;=0D
+  UINT8     RpBus;=0D
+  UINT8     NumBars;=0D
+  UINT8     Reserved;=0D
+} QEMU_FIXED_BARS_DEVICE;                    /* 8 bytes */=0D
+=0D
+typedef struct {=0D
+  UINT8     Bar;=0D
+  UINT8     Reserved[3];=0D
+  UINT32    Flags;=0D
+  UINT64    Address;=0D
+  UINT64    Size;=0D
+} QEMU_FIXED_BARS_BAR;                       /* 24 bytes */=0D
+=0D
+#pragma pack ()=0D
+=0D
+#define QEMU_FIXED_BARS_VERSION      1=0D
+#define QEMU_FIXED_BAR_F_MEM64       BIT0=0D
+#define QEMU_FIXED_BAR_F_PREF        BIT1=0D
+#define QEMU_FIXED_BARS_DEV_F_FIXED  BIT0=0D
+=0D
+/*=0D
+ * ACPI general-flag bits (ACPI 6.x 6.4.3.5.1):=0D
+ *   BIT2 =3D _MIF (minimum address fixed)=0D
+ *   BIT3 =3D _MAF (maximum address fixed)=0D
+ * Both set means AddrRangeMin carries the exact required base address.=0D
+ */=0D
+#define ACPI_ADDR_FLAG_FIXED  (BIT2 | BIT3)=0D
+=0D
+/*=0D
+ * P2P bridge memory window register offsets.=0D
+ * PCI Local Bus Specification 2.2, Section 3.2.5.6.=0D
+ */=0D
+#define PPB_MEM32_BASE_OFFSET       OFFSET_OF (PCI_TYPE01, Bridge.MemoryBa=
se)=0D
+#define PPB_MEM32_LIMIT_OFFSET      OFFSET_OF (PCI_TYPE01, Bridge.MemoryLi=
mit)=0D
+#define PPB_PREF_MEM_BASE_OFFSET    OFFSET_OF (PCI_TYPE01, Bridge.Prefetch=
ableMemoryBase)=0D
+#define PPB_PREF_MEM_LIMIT_OFFSET   OFFSET_OF (PCI_TYPE01, Bridge.Prefetch=
ableMemoryLimit)=0D
+#define PPB_PREF_BASE_HI32_OFFSET   OFFSET_OF (PCI_TYPE01, Bridge.Prefetch=
ableBaseUpper32)=0D
+#define PPB_PREF_LIMIT_HI32_OFFSET  OFFSET_OF (PCI_TYPE01, Bridge.Prefetch=
ableLimitUpper32)=0D
+=0D
+/* QFBD =3D Qemu Fixed Bars Dxe; used as the tag in this file's DEBUG() me=
ssages. */=0D
+/* Raw blob kept in memory; device entries point into it. */=0D
+STATIC UINT8              *mBlobData;=0D
+STATIC QEMU_FIXED_BARS_HDR mHdr;=0D
+=0D
+/* Pre-parsed per-device index built from the blob at startup. */=0D
+typedef struct {=0D
+  UINT16                VendorId;=0D
+  UINT16                DeviceId;=0D
+  UINT8                 DevFlags;=0D
+  UINT8                 RpBus;    /* primary bus of the root port */=0D
+  UINT8                 NumBars;=0D
+  QEMU_FIXED_BARS_BAR  *Bars;    /* pointer into mBlobData */=0D
+} QFBD_DEVICE;=0D
+=0D
+/*=0D
+ * Per-(VendorId, DeviceId) class. CheckDevice() is called once per PCI=0D
+ * function and once per scan pass. Different VID:DID classes must advance=
=0D
+ * their counters independently so that one class cannot disturb the=0D
+ * position of another across scan passes.=0D
+ *=0D
+ * Assumptions:=0D
+ *   - QEMU emits blob entries in the same order PciBusDxe discovers devic=
es.=0D
+ *   - For identical VID:DID devices, discovery order is stable across pas=
ses.=0D
+ *   - The counter is maintained per VID:DID class, not globally.=0D
+ */=0D
+typedef struct {=0D
+  UINT16    VendorId;=0D
+  UINT16    DeviceId;=0D
+  UINTN     Count;       /* number of devices with this VID:DID in the blo=
b */=0D
+  UINTN     CurrentIdx;  /* next entry to serve; wraps at Count */=0D
+} QFBD_DEVICE_CLASS;=0D
+=0D
+STATIC QFBD_DEVICE        *mDevices;=0D
+STATIC UINTN               mNumDevices;=0D
+STATIC QFBD_DEVICE_CLASS  *mClasses;   /* heap-allocated; mNumDevices entr=
ies max */=0D
+STATIC UINTN               mNumClasses;=0D
+=0D
+STATIC VOID=0D
+ReserveHpaRanges (VOID)=0D
+{=0D
+  UINTN       DevIdx;=0D
+  UINTN       BarIdx;=0D
+  UINT64      Min64;=0D
+  UINT64      Max64;=0D
+  UINT64      Min32;=0D
+  UINT64      Max32;=0D
+  UINT64      Gran;=0D
+  UINT64      Base;=0D
+  UINT64      Size;=0D
+  EFI_STATUS  Status;=0D
+=0D
+  Min64 =3D MAX_UINT64;=0D
+  Max64 =3D 0;=0D
+  Min32 =3D MAX_UINT64;=0D
+  Max32 =3D 0;=0D
+  Gran  =3D SIZE_1MB;=0D
+=0D
+  for (DevIdx =3D 0; DevIdx < mNumDevices; DevIdx++) {=0D
+    QFBD_DEVICE  *Dev =3D &mDevices[DevIdx];=0D
+=0D
+    if (!(Dev->DevFlags & QEMU_FIXED_BARS_DEV_F_FIXED)) {=0D
+      continue;=0D
+    }=0D
+    for (BarIdx =3D 0; BarIdx < Dev->NumBars; BarIdx++) {=0D
+      QEMU_FIXED_BARS_BAR  *Bar =3D &Dev->Bars[BarIdx];=0D
+=0D
+      if (Bar->Flags & QEMU_FIXED_BAR_F_MEM64) {=0D
+        if (Bar->Address < Min64) {=0D
+          Min64 =3D Bar->Address;=0D
+        }=0D
+        if (Bar->Address + Bar->Size > Max64) {=0D
+          Max64 =3D Bar->Address + Bar->Size;=0D
+        }=0D
+      } else {=0D
+        if (Bar->Address < Min32) {=0D
+          Min32 =3D Bar->Address;=0D
+        }=0D
+        if (Bar->Address + Bar->Size > Max32) {=0D
+          Max32 =3D Bar->Address + Bar->Size;=0D
+        }=0D
+      }=0D
+    }=0D
+  }=0D
+=0D
+  if (Min64 < Max64) {=0D
+    Base   =3D Min64 & ~(Gran - 1);=0D
+    Size   =3D ALIGN_VALUE (Max64 - Base, Gran);=0D
+    Status =3D gDS->AllocateMemorySpace (=0D
+                    EfiGcdAllocateAddress,=0D
+                    EfiGcdMemoryTypeMemoryMappedIo,=0D
+                    0, Size, &Base, gImageHandle, NULL=0D
+                    );=0D
+    DEBUG ((EFI_ERROR (Status) ? DEBUG_ERROR : DEBUG_INFO,=0D
+            "QFBD: reserve 64-bit 0x%016Lx+0x%016Lx: %r\n",=0D
+            Base, Size, Status));=0D
+  }=0D
+=0D
+  if (Min32 < Max32) {=0D
+    Base   =3D Min32 & ~(Gran - 1);=0D
+    Size   =3D ALIGN_VALUE (Max32 - Base, Gran);=0D
+    Status =3D gDS->AllocateMemorySpace (=0D
+                    EfiGcdAllocateAddress,=0D
+                    EfiGcdMemoryTypeMemoryMappedIo,=0D
+                    0, Size, &Base, gImageHandle, NULL=0D
+                    );=0D
+    DEBUG ((EFI_ERROR (Status) ? DEBUG_ERROR : DEBUG_INFO,=0D
+            "QFBD: reserve 32-bit 0x%016Lx+0x%016Lx: %r\n",=0D
+            Base, Size, Status));=0D
+  }=0D
+}=0D
+=0D
+/* Walk the blob once, build the mDevices[] index and the mClasses[] table=
. */=0D
+STATIC VOID=0D
+InitDevices (=0D
+  IN UINTN  BlobSize=0D
+  )=0D
+{=0D
+  UINT8  *Ptr =3D mBlobData + sizeof (QEMU_FIXED_BARS_HDR);=0D
+  UINT8  *End =3D mBlobData + BlobSize;=0D
+  UINTN   DevIdx, ClassIdx;=0D
+=0D
+  for (DevIdx =3D 0; DevIdx < mHdr.NumDevices; DevIdx++) {=0D
+    QEMU_FIXED_BARS_DEVICE  *Dev;=0D
+    UINT8                   *Next;=0D
+=0D
+    if (Ptr + sizeof (QEMU_FIXED_BARS_DEVICE) > End) {=0D
+      DEBUG ((DEBUG_ERROR, "QFBD: blob truncated at device %u\n", (UINT32)=
DevIdx));=0D
+      break;=0D
+    }=0D
+=0D
+    Dev  =3D (QEMU_FIXED_BARS_DEVICE *)Ptr;=0D
+    Next =3D Ptr=0D
+         + sizeof (QEMU_FIXED_BARS_DEVICE)=0D
+         + Dev->NumBars * sizeof (QEMU_FIXED_BARS_BAR);=0D
+=0D
+    if (Next > End) {=0D
+      DEBUG ((DEBUG_ERROR, "QFBD: blob truncated at device %u\n", (UINT32)=
DevIdx));=0D
+      break;=0D
+    }=0D
+=0D
+    mDevices[mNumDevices].VendorId  =3D Dev->VendorId;=0D
+    mDevices[mNumDevices].DeviceId  =3D Dev->DeviceId;=0D
+    mDevices[mNumDevices].DevFlags  =3D Dev->DevFlags;=0D
+    mDevices[mNumDevices].RpBus     =3D Dev->RpBus;=0D
+    mDevices[mNumDevices].NumBars   =3D Dev->NumBars;=0D
+    mDevices[mNumDevices].Bars      =3D (QEMU_FIXED_BARS_BAR *)(=0D
+      Ptr + sizeof (QEMU_FIXED_BARS_DEVICE)=0D
+      );=0D
+    mNumDevices++;=0D
+=0D
+    /* Find or create the class entry for this VID:DID. */=0D
+    for (ClassIdx =3D 0; ClassIdx < mNumClasses; ClassIdx++) {=0D
+      if (mClasses[ClassIdx].VendorId =3D=3D Dev->VendorId &&=0D
+          mClasses[ClassIdx].DeviceId =3D=3D Dev->DeviceId)=0D
+      {=0D
+        mClasses[ClassIdx].Count++;=0D
+        break;=0D
+      }=0D
+    }=0D
+    if (ClassIdx =3D=3D mNumClasses) {=0D
+      mClasses[mNumClasses].VendorId   =3D Dev->VendorId;=0D
+      mClasses[mNumClasses].DeviceId   =3D Dev->DeviceId;=0D
+      mClasses[mNumClasses].Count      =3D 1;=0D
+      mClasses[mNumClasses].CurrentIdx =3D 0;=0D
+      mNumClasses++;=0D
+    }=0D
+=0D
+    DEBUG ((DEBUG_INFO,=0D
+            "QFBD: device %04x:%04x num_bars=3D%u\n",=0D
+            Dev->VendorId, Dev->DeviceId, Dev->NumBars));=0D
+=0D
+    Ptr =3D Next;=0D
+  }=0D
+=0D
+  for (ClassIdx =3D 0; ClassIdx < mNumClasses; ClassIdx++) {=0D
+    DEBUG ((DEBUG_INFO,=0D
+            "QFBD: class %04x:%04x count=3D%u\n",=0D
+            mClasses[ClassIdx].VendorId, mClasses[ClassIdx].DeviceId,=0D
+            (UINT32)mClasses[ClassIdx].Count));=0D
+  }=0D
+}=0D
+=0D
+STATIC=0D
+EFI_STATUS=0D
+EFIAPI=0D
+FixedBarCheckDevice (=0D
+  IN  EFI_INCOMPATIBLE_PCI_DEVICE_SUPPORT_PROTOCOL  *This,=0D
+  IN  UINTN                                          VendorId,=0D
+  IN  UINTN                                          DeviceId,=0D
+  IN  UINTN                                          RevisionId,=0D
+  IN  UINTN                                          SubsystemVendorId,=0D
+  IN  UINTN                                          SubsystemDeviceId,=0D
+  OUT VOID                                           **Configuration=0D
+  )=0D
+{=0D
+  QFBD_DEVICE_CLASS                  *Class;=0D
+  QFBD_DEVICE                        *Dev;=0D
+  UINTN                               BarIdx, DevIdx, MatchCount, ClassIdx=
;=0D
+  UINT8                              *Buffer;=0D
+  EFI_ACPI_ADDRESS_SPACE_DESCRIPTOR  *Desc;=0D
+  EFI_ACPI_END_TAG_DESCRIPTOR        *End;=0D
+=0D
+  (VOID)RevisionId;=0D
+  (VOID)SubsystemVendorId;=0D
+  (VOID)SubsystemDeviceId;=0D
+=0D
+  if (Configuration =3D=3D NULL) {=0D
+    return EFI_INVALID_PARAMETER;=0D
+  }=0D
+=0D
+  *Configuration =3D NULL;=0D
+=0D
+  if (mNumClasses =3D=3D 0) {=0D
+    return EFI_SUCCESS;=0D
+  }=0D
+=0D
+  /* Look up the per-VID:DID class. */=0D
+  Class =3D NULL;=0D
+  for (ClassIdx =3D 0; ClassIdx < mNumClasses; ClassIdx++) {=0D
+    if (mClasses[ClassIdx].VendorId =3D=3D (UINT16)VendorId &&=0D
+        mClasses[ClassIdx].DeviceId =3D=3D (UINT16)DeviceId)=0D
+    {=0D
+      Class =3D &mClasses[ClassIdx];=0D
+      break;=0D
+    }=0D
+  }=0D
+  if (Class =3D=3D NULL) {=0D
+    return EFI_SUCCESS;  /* not a fixed-bar device */=0D
+  }=0D
+=0D
+  /* Find the CurrentIdx-th device in mDevices[] matching this VID:DID. */=
=0D
+  Dev        =3D NULL;=0D
+  MatchCount =3D 0;=0D
+  for (DevIdx =3D 0; DevIdx < mNumDevices; DevIdx++) {=0D
+    if (mDevices[DevIdx].VendorId =3D=3D (UINT16)VendorId &&=0D
+        mDevices[DevIdx].DeviceId =3D=3D (UINT16)DeviceId)=0D
+    {=0D
+      if (MatchCount =3D=3D Class->CurrentIdx) {=0D
+        Dev =3D &mDevices[DevIdx];=0D
+        break;=0D
+      }=0D
+      MatchCount++;=0D
+    }=0D
+  }=0D
+  if (Dev =3D=3D NULL) {=0D
+    return EFI_SUCCESS;=0D
+  }=0D
+=0D
+  /* Always advance the counter so ordering stays in sync with the blob. *=
/=0D
+  Class->CurrentIdx++;=0D
+  if (Class->CurrentIdx >=3D Class->Count) {=0D
+    Class->CurrentIdx =3D 0;=0D
+  }=0D
+=0D
+  if (!(Dev->DevFlags & QEMU_FIXED_BARS_DEV_F_FIXED)) {=0D
+    return EFI_SUCCESS;=0D
+  }=0D
+=0D
+  Buffer =3D AllocateZeroPool (Dev->NumBars * sizeof (*Desc) + sizeof (*En=
d));=0D
+  if (Buffer =3D=3D NULL) {=0D
+    return EFI_OUT_OF_RESOURCES;=0D
+  }=0D
+=0D
+  Desc =3D (EFI_ACPI_ADDRESS_SPACE_DESCRIPTOR *)Buffer;=0D
+=0D
+  for (BarIdx =3D 0; BarIdx < Dev->NumBars; BarIdx++) {=0D
+    QEMU_FIXED_BARS_BAR  *Bar =3D &Dev->Bars[BarIdx];=0D
+=0D
+    Desc->Desc                  =3D ACPI_ADDRESS_SPACE_DESCRIPTOR;=0D
+    Desc->Len                   =3D (UINT16)(sizeof (*Desc) - 3);=0D
+    Desc->ResType               =3D ACPI_ADDRESS_SPACE_TYPE_MEM;=0D
+    Desc->GenFlag               =3D ACPI_ADDR_FLAG_FIXED;=0D
+    Desc->SpecificFlag          =3D 0;=0D
+    Desc->AddrSpaceGranularity  =3D (Bar->Flags & QEMU_FIXED_BAR_F_MEM64) =
? 64 : 32;=0D
+    Desc->AddrRangeMin          =3D Bar->Address;=0D
+    Desc->AddrRangeMax          =3D Bar->Size - 1;=0D
+    Desc->AddrTranslationOffset =3D BarIdx;=0D
+    Desc->AddrLen               =3D Bar->Size;=0D
+=0D
+    DEBUG ((DEBUG_INFO,=0D
+            "QFBD: %04x:%04x BAR%u -> 0x%016Lx size 0x%016Lx\n",=0D
+            Dev->VendorId, Dev->DeviceId,=0D
+            (UINT32)Bar->Bar, Bar->Address, Bar->Size));=0D
+=0D
+    Desc++;=0D
+  }=0D
+=0D
+  End           =3D (EFI_ACPI_END_TAG_DESCRIPTOR *)Desc;=0D
+  End->Desc     =3D ACPI_END_TAG_DESCRIPTOR;=0D
+  End->Checksum =3D 0;=0D
+=0D
+  *Configuration =3D Buffer;=0D
+=0D
+  return EFI_SUCCESS;=0D
+}=0D
+=0D
+STATIC EFI_INCOMPATIBLE_PCI_DEVICE_SUPPORT_PROTOCOL  mFixedBarSupport =3D =
{=0D
+  FixedBarCheckDevice=0D
+};=0D
+=0D
+/*=0D
+ * Range type: Min inclusive, Max exclusive (base + size).=0D
+ */=0D
+typedef struct {=0D
+  UINT64   Min;=0D
+  UINT64   Max;=0D
+  BOOLEAN  Valid;=0D
+} QFBD_RANGE;=0D
+=0D
+typedef struct {=0D
+  QFBD_RANGE  Pref;=0D
+  QFBD_RANGE  NonPref;=0D
+} QFBD_BRIDGE_RANGES;=0D
+=0D
+STATIC VOID=0D
+RangeUnion (=0D
+  QFBD_RANGE  *R,=0D
+  UINT64       Addr,=0D
+  UINT64       Size=0D
+  )=0D
+{=0D
+  if (Addr     < R->Min) R->Min =3D Addr;=0D
+  if (Addr + Size > R->Max) R->Max =3D Addr + Size;=0D
+  R->Valid =3D TRUE;=0D
+}=0D
+=0D
+/*=0D
+ * Write PMem and Mem32 window registers on one bridge.=0D
+ */=0D
+STATIC VOID=0D
+SetBridgeWindow (=0D
+  IN EFI_PCI_IO_PROTOCOL  *PciIo,=0D
+  IN UINTN                 B,=0D
+  IN UINTN                 D,=0D
+  IN UINTN                 F,=0D
+  IN QFBD_BRIDGE_RANGES    R=0D
+  )=0D
+{=0D
+  UINT16  Cmd;=0D
+=0D
+  if (R.Pref.Valid) {=0D
+    UINT64  Base  =3D R.Pref.Min;=0D
+    UINT64  End   =3D R.Pref.Max - 1;=0D
+    UINT16  B16   =3D (UINT16)(((UINT32)Base) >> 16);=0D
+    UINT16  L16   =3D (UINT16)(((UINT32)End)  >> 16);=0D
+    UINT32  BHi   =3D (UINT32)RShiftU64 (Base, 32);=0D
+    UINT32  LHi   =3D (UINT32)RShiftU64 (End,  32);=0D
+=0D
+    PciIo->Pci.Write (PciIo, EfiPciIoWidthUint16, PPB_PREF_MEM_BASE_OFFSET=
,  1, &B16);=0D
+    PciIo->Pci.Write (PciIo, EfiPciIoWidthUint16, PPB_PREF_MEM_LIMIT_OFFSE=
T, 1, &L16);=0D
+    PciIo->Pci.Write (PciIo, EfiPciIoWidthUint32, PPB_PREF_BASE_HI32_OFFSE=
T, 1, &BHi);=0D
+    PciIo->Pci.Write (PciIo, EfiPciIoWidthUint32, PPB_PREF_LIMIT_HI32_OFFS=
ET, 1, &LHi);=0D
+=0D
+    DEBUG ((DEBUG_INFO, "QFBD: bridge %02Lx:%02Lx.%Lx PMem [0x%Lx, 0x%Lx]\=
n",=0D
+            (UINT64)B, (UINT64)D, (UINT64)F, Base, End));=0D
+  }=0D
+=0D
+  if (R.NonPref.Valid) {=0D
+    UINT64  Base =3D R.NonPref.Min;=0D
+    UINT64  End  =3D R.NonPref.Max - 1;=0D
+    UINT16  B16  =3D (UINT16)(Base >> 16);=0D
+    UINT16  L16  =3D (UINT16)(End  >> 16);=0D
+=0D
+    PciIo->Pci.Write (PciIo, EfiPciIoWidthUint16, PPB_MEM32_BASE_OFFSET,  =
1, &B16);=0D
+    PciIo->Pci.Write (PciIo, EfiPciIoWidthUint16, PPB_MEM32_LIMIT_OFFSET, =
1, &L16);=0D
+=0D
+    DEBUG ((DEBUG_INFO, "QFBD: bridge %02Lx:%02Lx.%Lx Mem32 [0x%Lx, 0x%Lx]=
\n",=0D
+            (UINT64)B, (UINT64)D, (UINT64)F, Base, End));=0D
+  }=0D
+=0D
+  if (R.Pref.Valid || R.NonPref.Valid) {=0D
+    PciIo->Pci.Read  (PciIo, EfiPciIoWidthUint16, PCI_COMMAND_OFFSET, 1, &=
Cmd);=0D
+    Cmd |=3D EFI_PCI_COMMAND_MEMORY_SPACE | EFI_PCI_COMMAND_BUS_MASTER;=0D
+    PciIo->Pci.Write (PciIo, EfiPciIoWidthUint16, PCI_COMMAND_OFFSET, 1, &=
Cmd);=0D
+  }=0D
+}=0D
+=0D
+/*=0D
+ * Read the BAR ranges (prefetchable and non-prefetchable) from an endpoin=
t=0D
+ * by looking up its programmed BAR addresses in the blob.  Every device=
=0D
+ * with the FIXED devflag bit set is guaranteed to have blob-provided BAR=
=0D
+ * entries covering all its BARs, so a match is always found.=0D
+ */=0D
+STATIC VOID=0D
+ClassifyBar (=0D
+  IN OUT QFBD_BRIDGE_RANGES  *R,=0D
+  IN     UINT64              Addr=0D
+  )=0D
+{=0D
+  UINTN  DevIdx, BarIdx;=0D
+=0D
+  for (DevIdx =3D 0; DevIdx < mNumDevices; DevIdx++) {=0D
+    for (BarIdx =3D 0; BarIdx < mDevices[DevIdx].NumBars; BarIdx++) {=0D
+      QEMU_FIXED_BARS_BAR  *Bar =3D &mDevices[DevIdx].Bars[BarIdx];=0D
+=0D
+      if (Bar->Address =3D=3D Addr && Addr !=3D 0) {=0D
+        if (Bar->Flags & QEMU_FIXED_BAR_F_PREF) {=0D
+          RangeUnion (&R->Pref, Addr, Bar->Size);=0D
+        } else {=0D
+          RangeUnion (&R->NonPref, Addr, Bar->Size);=0D
+        }=0D
+      }=0D
+    }=0D
+  }=0D
+}=0D
+=0D
+STATIC QFBD_BRIDGE_RANGES=0D
+EndpointRanges (=0D
+  IN EFI_PCI_IO_PROTOCOL  *PciIo=0D
+  )=0D
+{=0D
+  QFBD_BRIDGE_RANGES  R =3D { { MAX_UINT64, 0, FALSE }, { MAX_UINT64, 0, F=
ALSE } };=0D
+  UINTN               Off;=0D
+=0D
+  for (Off =3D PCI_BASE_ADDRESSREG_OFFSET; Off <=3D 0x24; ) {=0D
+    UINT32  Lo;=0D
+=0D
+    PciIo->Pci.Read (PciIo, EfiPciIoWidthUint32, Off, 1, &Lo);=0D
+=0D
+    if ((Lo & 0x1) =3D=3D 1) {          /* IO BAR */=0D
+      Off +=3D 4;=0D
+      continue;=0D
+    }=0D
+    if ((Lo & 0x6) =3D=3D 0x4) {        /* 64-bit memory BAR */=0D
+      UINT32  Hi;=0D
+      UINT64  Addr;=0D
+=0D
+      PciIo->Pci.Read (PciIo, EfiPciIoWidthUint32, Off + 4, 1, &Hi);=0D
+      Addr =3D ((UINT64)Hi << 32) | (Lo & ~(UINT32)0xF);=0D
+      ClassifyBar (&R, Addr);=0D
+      Off +=3D 8;=0D
+    } else {                         /* 32-bit memory BAR */=0D
+      ClassifyBar (&R, (UINT64)(Lo & ~(UINT32)0xF));=0D
+      Off +=3D 4;=0D
+    }=0D
+  }=0D
+  return R;=0D
+}=0D
+=0D
+/*=0D
+ * Recursively walk bridges starting at SecBus.  For each bridge, collect=
=0D
+ * ranges (prefetchable and non-prefetchable) from all endpoints below it=
=0D
+ * (bottom-up), program the bridge window, and return the union to the=0D
+ * caller.=0D
+ *=0D
+ * Because every device with the FIXED devflag bit set is guaranteed to ha=
ve=0D
+ * blob-provided BAR entries, EndpointRanges() only returns non-empty=0D
+ * results for fixed devices.  Branches leading to endpoints with no fixed=
=0D
+ * BARs naturally produce empty ranges and are not programmed.=0D
+ */=0D
+STATIC QFBD_BRIDGE_RANGES=0D
+WalkAndProgram (=0D
+  IN UINTN    Seg,=0D
+  IN UINT8    Bus,=0D
+  IN UINTN    HandleCount,=0D
+  IN EFI_HANDLE  *Handles=0D
+  )=0D
+{=0D
+  QFBD_BRIDGE_RANGES  Total =3D { { MAX_UINT64, 0, FALSE }, { MAX_UINT64, =
0, FALSE } };=0D
+  UINTN               Idx;=0D
+=0D
+  for (Idx =3D 0; Idx < HandleCount; Idx++) {=0D
+    EFI_PCI_IO_PROTOCOL  *PciIo;=0D
+    UINTN                 S, B, D, F;=0D
+    UINT8                 HeaderType, SecBus;=0D
+    QFBD_BRIDGE_RANGES    Sub;=0D
+=0D
+    if (EFI_ERROR (gBS->HandleProtocol (=0D
+                          Handles[Idx], &gEfiPciIoProtocolGuid,=0D
+                          (VOID **)&PciIo)))=0D
+    {=0D
+      continue;=0D
+    }=0D
+=0D
+    PciIo->GetLocation (PciIo, &S, &B, &D, &F);=0D
+    if (S !=3D Seg || (UINT8)B !=3D Bus) {=0D
+      continue;=0D
+    }=0D
+=0D
+    PciIo->Pci.Read (PciIo, EfiPciIoWidthUint8, PCI_HEADER_TYPE_OFFSET, 1,=
 &HeaderType);=0D
+=0D
+    if ((HeaderType & 0x7F) =3D=3D HEADER_TYPE_PCI_TO_PCI_BRIDGE) {=0D
+      /* Bridge: recurse first, then program with the subtree's range. */=
=0D
+      PciIo->Pci.Read (PciIo, EfiPciIoWidthUint8,=0D
+                       PCI_BRIDGE_SECONDARY_BUS_REGISTER_OFFSET, 1, &SecBu=
s);=0D
+      Sub =3D WalkAndProgram (Seg, SecBus, HandleCount, Handles);=0D
+      if (Sub.Pref.Valid || Sub.NonPref.Valid) {=0D
+        SetBridgeWindow (PciIo, B, D, F, Sub);=0D
+      }=0D
+    } else {=0D
+      /* Endpoint: collect its fixed BAR ranges. */=0D
+      Sub =3D EndpointRanges (PciIo);=0D
+    }=0D
+=0D
+    if (Sub.Pref.Valid) {=0D
+      RangeUnion (&Total.Pref, Sub.Pref.Min, Sub.Pref.Max - Sub.Pref.Min);=
=0D
+    }=0D
+    if (Sub.NonPref.Valid) {=0D
+      RangeUnion (&Total.NonPref, Sub.NonPref.Min, Sub.NonPref.Max - Sub.N=
onPref.Min);=0D
+    }=0D
+  }=0D
+=0D
+  return Total;=0D
+}=0D
+=0D
+STATIC VOID=0D
+EFIAPI=0D
+FixBridgeWindows (=0D
+  IN EFI_EVENT  Event,=0D
+  IN VOID       *Context=0D
+  )=0D
+{=0D
+  EFI_STATUS  Status;=0D
+  UINTN       HandleCount;=0D
+  EFI_HANDLE  *Handles;=0D
+  UINTN       DevIdx, Idx;=0D
+=0D
+  (VOID)Context;=0D
+=0D
+  gBS->CloseEvent (Event);=0D
+=0D
+  Status =3D gBS->LocateHandleBuffer (=0D
+                  ByProtocol, &gEfiPciIoProtocolGuid,=0D
+                  NULL, &HandleCount, &Handles=0D
+                  );=0D
+  if (EFI_ERROR (Status)) {=0D
+    return;=0D
+  }=0D
+=0D
+  /*=0D
+   * For each unique rp_bus that has at least one FIXED device, find the=
=0D
+   * bridge on that bus and walk its subtree bottom-up to set windows.=0D
+   */=0D
+  for (DevIdx =3D 0; DevIdx < mNumDevices; DevIdx++) {=0D
+    UINT8  RpBus;=0D
+=0D
+    if (!(mDevices[DevIdx].DevFlags & QEMU_FIXED_BARS_DEV_F_FIXED)) {=0D
+      continue;=0D
+    }=0D
+    RpBus =3D mDevices[DevIdx].RpBus;=0D
+=0D
+    /* Skip if we already processed this rp_bus. */=0D
+    {=0D
+      UINTN  Di;=0D
+      BOOLEAN Already =3D FALSE;=0D
+      for (Di =3D 0; Di < DevIdx; Di++) {=0D
+        if ((mDevices[Di].DevFlags & QEMU_FIXED_BARS_DEV_F_FIXED) &&=0D
+            mDevices[Di].RpBus =3D=3D RpBus)=0D
+        {=0D
+          Already =3D TRUE;=0D
+          break;=0D
+        }=0D
+      }=0D
+      if (Already) continue;=0D
+    }=0D
+=0D
+    /* Find the RP bridge handle: bridge on Bus =3D=3D RpBus. */=0D
+    for (Idx =3D 0; Idx < HandleCount; Idx++) {=0D
+      EFI_PCI_IO_PROTOCOL  *PciIo;=0D
+      UINTN                 S, B, D, F;=0D
+      UINT8                 HeaderType, SecBus;=0D
+      QFBD_BRIDGE_RANGES    Sub;=0D
+=0D
+      if (EFI_ERROR (gBS->HandleProtocol (=0D
+                            Handles[Idx], &gEfiPciIoProtocolGuid,=0D
+                            (VOID **)&PciIo)))=0D
+      {=0D
+        continue;=0D
+      }=0D
+=0D
+      PciIo->GetLocation (PciIo, &S, &B, &D, &F);=0D
+      if ((UINT8)B !=3D RpBus) {=0D
+        continue;=0D
+      }=0D
+=0D
+      PciIo->Pci.Read (PciIo, EfiPciIoWidthUint8,=0D
+                       PCI_HEADER_TYPE_OFFSET, 1, &HeaderType);=0D
+      if ((HeaderType & 0x7F) !=3D HEADER_TYPE_PCI_TO_PCI_BRIDGE) {=0D
+        continue;=0D
+      }=0D
+=0D
+      PciIo->Pci.Read (PciIo, EfiPciIoWidthUint8,=0D
+                       PCI_BRIDGE_SECONDARY_BUS_REGISTER_OFFSET, 1, &SecBu=
s);=0D
+=0D
+      Sub =3D WalkAndProgram (S, SecBus, HandleCount, Handles);=0D
+      if (Sub.Pref.Valid || Sub.NonPref.Valid) {=0D
+        SetBridgeWindow (PciIo, B, D, F, Sub);=0D
+        DEBUG ((DEBUG_INFO, "QFBD: RP %02Lx:%02Lx.%Lx programmed\n",=0D
+                (UINT64)B, (UINT64)D, (UINT64)F));=0D
+      }=0D
+    }=0D
+  }=0D
+=0D
+  FreePool (Handles);=0D
+}=0D
+=0D
+EFI_STATUS=0D
+EFIAPI=0D
+QemuFixedBarsDxeEntryPoint (=0D
+  IN EFI_HANDLE        ImageHandle,=0D
+  IN EFI_SYSTEM_TABLE  *SystemTable=0D
+  )=0D
+{=0D
+  FIRMWARE_CONFIG_ITEM  FwCfgItem;=0D
+  UINTN                 FwCfgSize;=0D
+  EFI_STATUS            Status;=0D
+  EFI_HANDLE            Handle;=0D
+  EFI_EVENT             Event;=0D
+  VOID                  *Registration;=0D
+=0D
+  Status =3D QemuFwCfgFindFile ("etc/fixed-bars", &FwCfgItem, &FwCfgSize);=
=0D
+  if (EFI_ERROR (Status)) {=0D
+    DEBUG ((DEBUG_INFO, "QFBD: etc/fixed-bars absent, nothing to do\n"));=
=0D
+    return EFI_SUCCESS;=0D
+  }=0D
+=0D
+  if (FwCfgSize < sizeof (mHdr)) {=0D
+    DEBUG ((DEBUG_ERROR, "QFBD: blob too small (%Lu bytes)\n",=0D
+            (UINT64)FwCfgSize));=0D
+    return EFI_UNSUPPORTED;=0D
+  }=0D
+=0D
+  QemuFwCfgSelectItem (FwCfgItem);=0D
+  QemuFwCfgReadBytes (sizeof (mHdr), &mHdr);=0D
+=0D
+  if (mHdr.Version !=3D QEMU_FIXED_BARS_VERSION) {=0D
+    DEBUG ((DEBUG_ERROR,=0D
+            "QFBD: unsupported blob version %u (expected %u)\n",=0D
+            mHdr.Version, QEMU_FIXED_BARS_VERSION));=0D
+    return EFI_UNSUPPORTED;=0D
+  }=0D
+=0D
+  if (mHdr.NumDevices =3D=3D 0) {=0D
+    DEBUG ((DEBUG_INFO, "QFBD: zero devices, nothing to do\n"));=0D
+    return EFI_SUCCESS;=0D
+  }=0D
+=0D
+  /* Read the full blob into a persistent buffer; device entries point int=
o it. */=0D
+  mBlobData =3D AllocatePool (FwCfgSize);=0D
+  if (mBlobData =3D=3D NULL) {=0D
+    return EFI_OUT_OF_RESOURCES;=0D
+  }=0D
+=0D
+  QemuFwCfgSelectItem (FwCfgItem);=0D
+  QemuFwCfgReadBytes (FwCfgSize, mBlobData);=0D
+  CopyMem (&mHdr, mBlobData, sizeof (mHdr));=0D
+=0D
+  mDevices =3D AllocateZeroPool (mHdr.NumDevices * sizeof (QFBD_DEVICE));=
=0D
+  if (mDevices =3D=3D NULL) {=0D
+    FreePool (mBlobData);=0D
+    return EFI_OUT_OF_RESOURCES;=0D
+  }=0D
+=0D
+  /* Worst case: every device has a unique VID:DID =E2=80=94 allocate mNum=
Devices slots. */=0D
+  mClasses =3D AllocateZeroPool (mHdr.NumDevices * sizeof (QFBD_DEVICE_CLA=
SS));=0D
+  if (mClasses =3D=3D NULL) {=0D
+    FreePool (mDevices);=0D
+    FreePool (mBlobData);=0D
+    return EFI_OUT_OF_RESOURCES;=0D
+  }=0D
+=0D
+  DEBUG ((DEBUG_INFO, "QFBD: %u device(s)\n", mHdr.NumDevices));=0D
+=0D
+  mNumDevices =3D 0;=0D
+  mNumClasses =3D 0;=0D
+  InitDevices (FwCfgSize);=0D
+  ReserveHpaRanges ();=0D
+=0D
+  Handle =3D NULL;=0D
+  Status =3D gBS->InstallProtocolInterface (=0D
+                  &Handle,=0D
+                  &gEfiIncompatiblePciDeviceSupportProtocolGuid,=0D
+                  EFI_NATIVE_INTERFACE,=0D
+                  &mFixedBarSupport=0D
+                  );=0D
+  if (EFI_ERROR (Status)) {=0D
+    DEBUG ((DEBUG_ERROR, "QFBD: install protocol failed: %r\n", Status));=
=0D
+    FreePool (mDevices);=0D
+    FreePool (mBlobData);=0D
+    return Status;=0D
+  }=0D
+=0D
+  /* Register bridge window fixup for after PCI enumeration completes. */=
=0D
+  Status =3D gBS->CreateEvent (=0D
+                  EVT_NOTIFY_SIGNAL, TPL_CALLBACK,=0D
+                  FixBridgeWindows, NULL, &Event=0D
+                  );=0D
+  if (!EFI_ERROR (Status)) {=0D
+    gBS->RegisterProtocolNotify (=0D
+           &gEfiPciEnumerationCompleteProtocolGuid,=0D
+           Event, &Registration=0D
+           );=0D
+  }=0D
+=0D
+  return EFI_SUCCESS;=0D
+}=0D
diff --git a/OvmfPkg/QemuFixedBarsDxe/QemuFixedBarsDxe.inf b/OvmfPkg/QemuFi=
xedBarsDxe/QemuFixedBarsDxe.inf
new file mode 100644
index 0000000000..8c08a332b3
--- /dev/null
+++ b/OvmfPkg/QemuFixedBarsDxe/QemuFixedBarsDxe.inf
@@ -0,0 +1,43 @@
+## @file=0D
+#  Fixed-BAR support for QEMU passthrough devices.=0D
+#=0D
+#  Reads QEMU's etc/fixed-bars fw_cfg blob and publishes=0D
+#  EFI_INCOMPATIBLE_PCI_DEVICE_SUPPORT_PROTOCOL so that PciBusDxe places=
=0D
+#  each matching device's BARs at given addresses.=0D
+#=0D
+#  SPDX-License-Identifier: BSD-2-Clause-Patent=0D
+##=0D
+=0D
+[Defines]=0D
+  INF_VERSION    =3D 0x00010005=0D
+  BASE_NAME      =3D QemuFixedBarsDxe=0D
+  FILE_GUID      =3D a1b2c3d4-e5f6-7890-abcd-ef1234567890=0D
+  MODULE_TYPE    =3D DXE_DRIVER=0D
+  VERSION_STRING =3D 1.0=0D
+  ENTRY_POINT    =3D QemuFixedBarsDxeEntryPoint=0D
+=0D
+[Sources]=0D
+  QemuFixedBarsDxe.c=0D
+=0D
+[Packages]=0D
+  MdePkg/MdePkg.dec=0D
+  MdeModulePkg/MdeModulePkg.dec=0D
+  OvmfPkg/OvmfPkg.dec=0D
+=0D
+[LibraryClasses]=0D
+  BaseMemoryLib=0D
+  DebugLib=0D
+  DxeServicesTableLib=0D
+  MemoryAllocationLib=0D
+  QemuFwCfgLib=0D
+  UefiBootServicesTableLib=0D
+  UefiDriverEntryPoint=0D
+=0D
+[Protocols]=0D
+  gEfiIncompatiblePciDeviceSupportProtocolGuid       ## PRODUCES=0D
+  gEfiPciHostBridgeResourceAllocationProtocolGuid    ## CONSUMES=0D
+  gEfiPciEnumerationCompleteProtocolGuid             ## CONSUMES=0D
+  gEfiPciIoProtocolGuid                              ## CONSUMES=0D
+=0D
+[Depex]=0D
+  gEfiPciHostBridgeResourceAllocationProtocolGuid=0D
--=20
2.34.1


