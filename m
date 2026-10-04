Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC10CA5FCE
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 09:06:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDI9z-0005rP-FR; Sun, 04 Oct 2026 05:05:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xDI9y-0005r9-1B; Sun, 04 Oct 2026 05:05:30 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xDI9v-0005jQ-Nj; Sun, 04 Oct 2026 05:05:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yIe8XZsR22jSCkxshM6+uuuHlIhEQHItdlkUpx4xa5SdEYlwRSzf7oZNlXHkN90rV66m9fjCE80UNHUBpx7svvyS5F7TFqIh4HKvJwAj/Sg7wzFcO4TMXO1dDKSj2rX4tGJQuU2qjXu6tvMz9ATHc5G36W6niBDzjYBciloUaiZYohf3HQHDhGNllD851b2TISxSWgHyl0uR8pWCPxQKzyx9XoVogbuJdBA3is/wCblDhvaFuekquVLLQ24dO8ebSqgRBDQZlXgOFPMUhdNPmxTCS/jWhOlu96QRwF0SsapoF0q9lVfVddPDmQ5ierWAmxHHzk7jd4AqGnQCrBNSQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QETrCyQ4g9RKkFdgr4lOVRdQZ6cTu3xb15rjLVq478w=;
 b=Fik/EN3aGBAZgumIWNsRBMdWlfcVN/B2Z5GYkbwX2RyB3doEdOQSNEx1wnX2TlGWf2wdMvlKgxGw5VM4AePoc02mU3yNk50SIc13lklFDNIyrTX3B68PKFHPBqGZLQw5I6Xwpk63D5jWM0vRivRxVbqcAAEJavXqzlZyMUm8zpgtSLU4acduV28My16VH9eg/o9oZFfR/uMECKROJZsHOdql7+kcX7EKGKaEiDsO1d4zmSHHYJnJdTOBNuzcCFRJuC2aSXoTobYmHi60Jhi7eMkrgQeLlC4uRNOBJPe3Hszf5FCfbWO62juFsV/TbmgjCPAX+d9pgfNMGfQSBhz3Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QETrCyQ4g9RKkFdgr4lOVRdQZ6cTu3xb15rjLVq478w=;
 b=nh1SlcI1E56ydOgW9gN8+T/7NVIL4edGcpeIB34fD/eussE/Qcj7jS+gDdGTDFmcVqDCGuk3Vs9Ve2A3tiA3dJ0rCLxYFDX8Yw4k832gnHwZRRAe0fTCEN7/R8pGirjoxtCk4icR0jxno64LfMh9ldKM4QYrWLdCd7s59KVoy0ne3tZjYNEHQlqgD9KQDYeB1ilr4p/KExySlNh9URHzJY1Q5qeAOsiqSpi+Nvwpidp5VeX4XnVQZ9PoxQahMFK3n+QTyMlOs1VhDtGamGGJXHQ4ILHjxU3OsBinMazPAB+XeAHSEkjWlAgP3bm0dzpWxTXBWuqF4o2n+Zn2PeTniQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by TYPPR02MB8958.apcprd02.prod.outlook.com (2603:1096:405:382::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 09:05:18 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0472.016; Sun, 4 Oct 2026
 09:05:17 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org,
 qemu-block@nongnu.org
Subject: [PATCH v3 00/10] hw/arm: Enable U-Boot boot on MCIMX6UL-EVK
Date: Sun,  4 Oct 2026 17:04:45 +0800
Message-ID: <20261004090500.3082641-1-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP301CA0002.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::20) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|TYPPR02MB8958:EE_
X-MS-Office365-Filtering-Correlation-Id: 9627f391-bb4f-42c6-1c3d-08df21f69c23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|56012099006|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: wE2HR8hvrJ1hFV1t+umJtUS1zUoQBLiD0glNPFM4z030M9o5Nbnz7fBpdRfHxony9zzRre1O4u0LjYuewlhslBXRsosJZ9+GFVwDIoSF352ysTw20OHSSFoMArBY/CKPO2ERMwNVSXp3pxADccwR6qdoqVmmavKBVbExZkqnKTMLQ0vV7OsSlIP3+w1vzRV0dbnjMWtyxAn9Rqgxl7j7kastq7ZdYig5uINOfgIwgaBeuY0nIMs+GK+vr0sS5QWvdzuqZio364hgsKN8qGYNyKrNgJVleIQ/tTC9IIL1oDto4se6dEXf76L1OY/FTCkDWnu+tmNuK1AArz8mhkIUWQUiG1SRe5alHi9ITujSpuYaku97avp3Rgso4rx87QnVX2b06cSnNk5E0dZaU2o1FfICtuy/X9h9z+YFno1Njo9oxqRYsiOkDErtH+W9ygE8wpncX21BJTf+hMFdwzqYh6B5hhBbWdhT1v/vQJUBdR5pYWh0Fo8EGYFpHjkmC0w0DdOpNRdWMnaTy6kbdCmUw1jsVfOCbVhKF1go7F7CAnt1dPlNp5dQbuVLQK5oZe6JJq7vaxQB9GJMre8bVw4MkQbtGYOJZr3lmlT1p2LP7ng3fcBi2XTBRdg/cAUPb/0x03+R5znui+LFIMmuxOWEmmPekCTOp1CBQlNuvG3Jcss=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(10067099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEU2MGpFWE40dXNNaXF4WmtEVmszM1IvN08wSmpvZDdvQ3pYZ2w1eTlGZzlr?=
 =?utf-8?B?SkJ0NFp1QzNHRTJPZkg2blQ2dEdtbis5ankzMDZnMEo4aC9rQUZCTkFmMThs?=
 =?utf-8?B?M2N4Z3dMcmlkdkpTaGNPKzROVm1IMFlYRTFaR2xzeE5QdU1oeG5DeTk5VVMr?=
 =?utf-8?B?c1Z0cWpMbWZoTm1yZG5vdCs3ZitlUWZtdGFObjNCR3g1VFlFZ0d5bnNjWEl6?=
 =?utf-8?B?c3lPS1Q1Vkk5SkFyM0RwN1FNNTFRNnNVZE84R01EZkVKa29mQ0RXWXo3ci9u?=
 =?utf-8?B?RVFKa1Q5Z2hIdHoxbTZqQ2JSRGNHN1JJRUg4OUthV2taV01ncEttbm02L2g4?=
 =?utf-8?B?ZDdEL3hhU2tyMjVyYWZBSTJmTzcySWNNalpqb1JjeTlSeDdDcjZvQVJ2NEF2?=
 =?utf-8?B?VDFNN3BPTVBxaW8rL0dXNTZxY05wWW9ORlhkUDhFNW9SU21ZYXM5Z1doN1dK?=
 =?utf-8?B?N0UzUTVObjBKMUVjS1ZzVkxyVjNZczdGcWI5WEEwcUNQQ2NtVVUvZDVpUEVZ?=
 =?utf-8?B?ZmtlV1F3cks1SHg5a0YxeFJFZXB6ekprb2VDMXNSNEJZSWhmZFpiUUZrd3NO?=
 =?utf-8?B?QVBwb0FLVUNtWEp3alRIY0RzMDU0V0xlbVNQd09iN2tkQlA3c0JUK2ZXNXY4?=
 =?utf-8?B?TmRlKzFZbEZWOGtDNzdBdlFTaitFY01oSUdSSWZJWHRFcnNibHJrLzB2azkw?=
 =?utf-8?B?MEYxRDFtM29XWHozUm4xanAwb2hkMDBwUzBKWktvbUhmaWdpN1JGTkRtZ2N2?=
 =?utf-8?B?NzJZU0IvU2NoU2Fna05oNXZGS0kxbThScUN2Ni9QVFZCNUpEZlBORW1xblY0?=
 =?utf-8?B?ekNwK01qK0lxcEtNcUxKWU42VldpZTZSNUkwc0NGSEhlR0RUVW12dmpoeWtl?=
 =?utf-8?B?cUt0QUllSzdUSFJHSVV0dCtOYUgxN1M2b3pld2d4eW4vUG0zWkRVMEJ6WkhY?=
 =?utf-8?B?TnFpTFJpWElsb2F5V3lqeGR3dUg4MCt6UkpCUkJqdUduUjR3WE4vNnlOYkdF?=
 =?utf-8?B?QUl2MjB0MEt5bHhrNUdkbVBhODZSOXJUVjRYbU9RNVRINHJpRzlMZi8xNWxo?=
 =?utf-8?B?MmVVQVc4VnNXNUJTQnVzb3F4UjE3ajJXRFlRMTJKSkMyT1lKOFMzaFp4RnNx?=
 =?utf-8?B?SGJPTXhzdm9XbE9UQzNhMTM4L1ZjY3ROZ1MzMGI1Yno1cS9LSEt0Vks1Nlp5?=
 =?utf-8?B?WThuQ1drK2FqOEtpaHpYVXNjL21USXhvUFdqdFIwcGgzSVorMjFOR08rbzJz?=
 =?utf-8?B?SFpGTmlOK0E3ckZjZUw0RDZBcnhNSHhEVDVMNTlONnZkQUtheEdwdUJESEs4?=
 =?utf-8?B?ZTZqcUFBeE1jazlCaGRqUlVoSEJQYjFYZmwrMkthTy85V3M0bGQxM2pZZ1hQ?=
 =?utf-8?B?d2tPbW1va05TYlloaExtcVdLZDNxVE83SlNXdUNMbVJtTFp4NWhIcFpJTFlD?=
 =?utf-8?B?dGpUZy9YMnFKZjVIRU9KeGZtQjVNYk5hcFA1MEE3Qmt4TWNTbVBhazFCVHhV?=
 =?utf-8?B?dkNYLzRoMU1jaGJvNHZwV1p6ZzhudWhpb3dGVEhaUU90cXRuS2hnR0hCaXR5?=
 =?utf-8?B?MHJHUTJ4bHRUcVZSbXhVL2VsaUxmTU9jeUZnRGVGSGlLQXk2RFh1a2VNZzdE?=
 =?utf-8?B?MDIzUUNYdFhQWkhmaFdjT1VJcFdwN0dRcDJWY0Z3UUV1eWorVklzdFJ2T1Bz?=
 =?utf-8?B?VnUybk9abjVDWHBFdzl3KzBydEtxQlRwaW5XTk56MFVLdC9zWldMZzdObWpp?=
 =?utf-8?B?dHBEOXBOOGxPNHR2QzBvVXFpUkIvWlFlSys3SW56K0VJcVJlQ245b3dTZG5U?=
 =?utf-8?B?ZjVBZndVYTI5bXNlSUduQmFZSzUvdExxZHNmcXo1VkJwa2lLY210bDNzdXNZ?=
 =?utf-8?B?enRZNnZwUi83UmFMN1dqeUtqakpEblRycitCRzF2cWNRaUZ2MXlLL29kUU9m?=
 =?utf-8?B?RUwxaHI1SlBlS0ZjeHI4ZHhrT2N4R1NEdWloeVpFL2MzemI3TFNNOXVaZThG?=
 =?utf-8?B?Y1NkRi9Qb2o3aHUzSGtETGNJSXRwUGI3Ni85NmhrNGd6UWg5Nlc2NDhpckpi?=
 =?utf-8?B?eWdjckJoVXd2d1VNOXBOTCtGdzF2Z0wwb1FwMUVLeUUzVmkvclZnNzVXa1pj?=
 =?utf-8?B?Z3ZvcEZQa2RMeStYbS93dkM5QXZFeVQ4bTVmT3IzSlozSUJwS1ExYXIwcUFj?=
 =?utf-8?B?a2R1ZC9QZnZsTXVqWTllY1VCQjVzOTRUK3Jtc2gyUUIyVlhKQzVmRlhHWWJy?=
 =?utf-8?B?b3N3cUF5bFBSZi9JRXdqWTN3Q3hody9pQVoxbzhRWmlTeTVuT2FXWEo1M3VP?=
 =?utf-8?B?Z0lyNzgrdEdUMWc5K214Mko5bkNoeXN1ZHQzcVA0UTZpbmlDdGhDZndzQUdP?=
 =?utf-8?Q?fhIGcVYHaqmeuqw8=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9627f391-bb4f-42c6-1c3d-08df21f69c23
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 09:05:17.7936 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x9UMzIufzf1u+muo2hGTLWDnsiGdi1t88C7A5dDKpmjOIgVkLksw7dWDPyAvGdJi+YuEEAapC4O/BfB10376Lm1QtaGxpyphZAh4nfJ+Wx0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR02MB8958
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=bin.meng@processmission.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


The mcimx6ul-evk machine can boot Linux directly, but it cannot run the
U-Boot proper produced by Buildroot far enough to load a kernel from its
SD card. Early U-Boot boot test accesses currently abort or observe
placeholder values, and the i.MX uSDHC model exposes several issues.

This series lets an unmodified Buildroot 2026.05 U-Boot 2024.07 image
run on mcimx6ul-evk, load zImage and imx6ul-14x14-evk.dtb from USDHC2,
start Linux, mount the SD card root file system, and reach the Buildroot
login prompt. It also documents and tests the existing direct Linux boot
path.

Patches 1 through 4 provide the minimum early-firmware-visible state.
Patches 5 through 8 address i.MX uSDHC behavior needed by U-Boot. The
last two patches document both boot paths and add functional tests for
U-Boot and direct Linux boot.

This series is based on:
<20261003170232.2450916-1-bin.meng@processmission.com>
as the sdhci changes have conflicts.

Changes in v3:
- Rebase on the v3 PolarFire SoC Icicle Kit series
- Model the full reserved page as a child of a15mpcore_priv
- Validate MMDC RAM geometry and document supported capacities
- Translate uSDHC vendor clock gates in its MMIO handlers
- Cover partial reset accesses and migrate vendor clock state
- Extend contiguous SDMA completion to both eSDHC byte orders

Bin Meng (10):
  hw/cpu: a15mpcore: Model the reserved page as RAZ/WI
  hw/misc: imx6ul_ccm: Update PMU_MISC0 reset value
  hw/arm: fsl-imx6ul: Map early firmware register placeholders
  hw/arm: fsl-imx6ul: Add a minimal MMDC geometry model
  hw/sd: sdhci: Use a QEMU-local no-busy IRQ quirk bit
  hw/sd: sdhci: Honor i.MX uSDHC vendor clock gates
  hw/sd: sdhci: Preserve uSDHC status enables for U-Boot
  hw/sd: sdhci: Skip SDMA boundary stops for eSDHC and uSDHC
  docs/system/arm: Document MCIMX6UL-EVK Buildroot boot
  tests/functional/arm: Add MCIMX6UL-EVK boot tests

 MAINTAINERS                               |   1 +
 docs/system/arm/mcimx6ul-evk.rst          |  72 +++++++++++
 include/hw/arm/fsl-imx6ul.h               |   2 +
 include/hw/cpu/a15mpcore.h                |   6 +
 include/hw/sd/sdhci.h                     |  10 +-
 hw/arm/fsl-imx6ul.c                       |  87 ++++++++++++-
 hw/arm/mcimx6ul-evk.c                     |   2 +
 hw/cpu/a15mpcore.c                        |  53 ++++++++
 hw/misc/imx6ul_ccm.c                      |   2 +-
 hw/sd/sdhci.c                             | 151 +++++++++++++++++-----
 tests/functional/arm/meson.build          |   2 +
 tests/functional/arm/test_mcimx6ul_evk.py |  69 ++++++++++
 12 files changed, 416 insertions(+), 41 deletions(-)
 create mode 100644 tests/functional/arm/test_mcimx6ul_evk.py

---
base-commit: 3ee3bacb1edd0896cb26f0f66493b4ab006fbffa
branch: imx6ul-evk

-- 
2.53.0


