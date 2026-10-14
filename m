Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C26ACCC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 04:57:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGr2h-0006ZP-SU; Wed, 14 Oct 2026 00:56:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGr2c-0006Yz-5l; Wed, 14 Oct 2026 00:56:39 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGr2Z-0008Iu-I2; Wed, 14 Oct 2026 00:56:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uX5lPuKXu8GyWIGiU7/inW82h1elZiya7B+NsW2BpjTuYZiBpxAq1j/3+22NWrCK/PSPq3n20FTbkpXYsKiId3qHYFG7m1DdPCUE146yG/1EYzKqCpDpyh71sOqHWPUo7FPhbOCbHS/uk7lTZG8z1NC7MQr3IvmI4LwFMXnRXgkNjn9UkdOyN2xJj0OaixlHemTvcXevj+jHMlwqvuKgiOo8La12KOrT/6E6X+Wmh09Jvau1UZth0bEBghM8UbaQs7NgNkf46tOzjgNRmhA2UCLx58QSxp1zJpvLNzBzQwPdjHNhqc52NZKSmqGETZYhN71fhPlAM0ZafODFaT9NUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCOUhj7DhMnc5Jkw8VcUx1gCruA874Pbg8hklakLeBc=;
 b=GprERI/kEqtRNm+WhDfMoOI1gg+Mgv6vlv1aWP6zwI2nzdTeNQO31PgIWMygievv2rD44MJdLHbjDsO5+SPh8XR+scZp+gXtC+y6X/2FliVzjmactFtJR6pXqMHK/W2M75sFoLcXRLRiFL7BYFYmgoXdJMBKVxy4djrv/2KzpDFKjMck/h95JCevFkju+V3Ct1lhhYFXxsRK5G2XGOWqReHP0rGzR4CkwXKgVQFJIKHFOWORPN4XKbbPzYenBkJKVlWlHIIKhkxZyIb8UrlmjA8hgMvU/7xQsiHw2vOtJcpxZayZNXbEe+6Bqu1qd9qwSHd7BsZxZoc6Ep/fgfbldw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCOUhj7DhMnc5Jkw8VcUx1gCruA874Pbg8hklakLeBc=;
 b=QrQ1IuZouDD3M0UYGybxh4t6cMp/ZJj/6AxtjsbkLKE73IIQUoq41STgzSkbrWq8mRgmDNnKxr67vOT6JtRvsy0bgSx9FM3fFl5jLnBf8bfWxvTK7sQVWzDmtVL2NRIaRREG7zWPcwSss5UPBlZtOLiiCacTHskUxA6Kce3DSpDLgUGV+IBA6RuxMMDM6c2tyZyC2klyRJRyFjHkHTTKR2AQfgFOMwXo6SnAkjMObFeep8Eqt3ovH1iIB4d3l5pIHXYA3XuATX2OewXMUx7eyLY+Nur4CrJvOOJQGWZI8t6E7kYXJQ+S6QlqwDyAgtMm67/NzofrNwpWzWtzBIqUCw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by JH0PR02MB7213.apcprd02.prod.outlook.com (2603:1096:990:67::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 04:56:26 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 04:56:25 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org,
 qemu-block@nongnu.org
Subject: [PATCH v4 00/10] hw/arm: Enable U-Boot boot on MCIMX6UL-EVK
Date: Wed, 14 Oct 2026 12:55:50 +0800
Message-ID: <20261014045605.399684-1-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYWPR01CA0051.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::7) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|JH0PR02MB7213:EE_
X-MS-Office365-Filtering-Correlation-Id: c03b4f85-92f7-493e-a667-08df29af8000
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|6133799003|10067099003|18002099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: stfi6Goq4+vmUS+H4py1EGya2cFCuV2qWemi3trmtnbuOKeaDTroLDN5B7zhOX8z67Lrv1Z+IEETDQ/pAbdbQWfRwfjsMDozqV6cNEHAdijfxYD7dOKduRAe0pa8ustAYGTbB+j+6l+zA+7LanZccX8Ll33aMzFkKaEtoyOZ67fpBMf8L/Rw5zVpFgvv36k64PqLOksLgHxNL1QXXHoIUhqGJpfzcUwiJ/ad0+/uoqxOnVSvDfxJWAaefMvihNaK0Y9xGLbSffSG9ruBqjdkVeI2N62p+D4+HrKuqyzuRG4s6GEm492/YelAKDcAL0R3T0cSXC9xWWMfFj8/k+5vW+jhbI5YzvRPu0mKu+kn4AgV3pqPwCzyV4N22QCrUknvXfJdTNEmIzLki9YpGskS2wVrDSXOJKAiFMEYzWE6lwZwjpHfc6A2VAEpOOxJQBx+it7CeROrX1k+Cfzf+U/73Y8CPQlocWFnr19B9z2XZ2WfDyad0/IL7OvLIOsi83Vtl8LqAuGzkGq2Y3sOKSnLo9rGLTUxq9WT1Yjwj+zkfsm5npeYSLfhdpVaE/vy1yxlraY4JgD4qJfbix14Mm4/E1OgKMwStn3aT2nPD5TvS/P1gtfX65ONBJbRoA1khToMUXvuM28P1C0VAXBW9ABLtkGzUL2cpzKVeByCNMlHm1k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(6133799003)(10067099003)(18002099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzZ4OW9icStyaG9UdGRyQmJnK0h3Ri9HMHpKUWw5dExEQzZYWW95cExCZWNG?=
 =?utf-8?B?aVZnNmNjY1M0OUFPOUZQNVh4SFVoVkxBM1BPVEE1blpYZzhDLzR4Y2tjc0JT?=
 =?utf-8?B?bURwRi95VlFld1FFUG1Gc0ZSNHNZWjhjQ2NSVFAyV0ozR3IxYUtFVlBmRnpT?=
 =?utf-8?B?QjJvMk5PNUU4UXpxS1ZHcTE5M05PdWh0SUg5TlgwQnQ2RmFDaW13ZkNUbDZm?=
 =?utf-8?B?aGtSK1JreTc4S1c3OEpQRW1oZVRMamN6N1hpb2ZqdE1pa1pqNzRQMTJob3I5?=
 =?utf-8?B?bzdUeEdUSS9uckg3TnhtSEtQTmdXQmVvN2x2bmhCVFZXT2Z1UzVFZEVzR3d2?=
 =?utf-8?B?MmxyYzNHazRwOC9uTkdZSWloV3pTY2dyTkFuc1d0NFlRK0pVclRmVVJUSE9p?=
 =?utf-8?B?bW5qKzFUTG9JUDQwL0NObE0xVXNtVi9hUkZVczlKTE5BQ3ByaklmeTFMRVFw?=
 =?utf-8?B?T1cxc2JMRGo5N3NkK3FIRlA1YlZ6MWVNeVlxc2JUaDBUcTJScXZXKzhIdElF?=
 =?utf-8?B?VzRHYTdUd0tYWGhzeXVCeVRYb1VFV1gwUFFCOFVaRXRVMktYNUlkejZ0VHly?=
 =?utf-8?B?OGhYOXZKRU5sajNXcW92MDFaTEdLajZBL0ZsU3dwUlVySWdSUHRmSTBCRTVB?=
 =?utf-8?B?ZnBpZ21vK2tFN1JjdlJBTFVvTVVkVlJlbDlBY3M0bnJURHhyc2EvcjRjamdZ?=
 =?utf-8?B?c2xiclJLZ1Qzb3Fwb0tzd3JtOTlkZ0dNaU1OMjhGbldYOTIzUkdzb3paSzQ5?=
 =?utf-8?B?TFRIVXo3VVVBMkFIdVdJTytEVkhkNVdxSDUyakgxRk5pbGpVMWJ3ekpNMkI5?=
 =?utf-8?B?VGljQnJ5b3hETmFFY09GL1dpajRySmEzLy9rQVMwRTloUVl6V3FueGJWZVFF?=
 =?utf-8?B?KzFIcW5jYW1aWHM4Y3l0RDNxaXVIVGk1Qkdaa1JyUjAyanNEckhNWVd2YVAx?=
 =?utf-8?B?RExVekRMaittcDAzNytrQ2RXZEJYU3hCUEtBR0ZrelI0RmlpS1krZmdlQ0h3?=
 =?utf-8?B?cGhZY1BjaDFUZ0phZUdRTEIzeVBiVm1INTUrYnFYUzFkNTlVQ2s3S1F6WW9w?=
 =?utf-8?B?NFY0VG94aTVCK1NLcC90M0xBdnJLbHptODRuN2s1YktRbHRhUUJVOVFqenVw?=
 =?utf-8?B?bHB5S2VQWGVPSDY0c2hlRDV3QVo2ZVlXYVhGbkFRMGMvd2c2MzF3QmtWRnhX?=
 =?utf-8?B?Z2dmUmlqMGNIL2hOTE9QRzBvdDQvL05NQzNEZ21LRmtoaklSbTJReWF4ZmRm?=
 =?utf-8?B?UlN0azVUVmJvdUxFQ283c0N5eERPKytQZlFwSVd3cE9RS012UmdZVnFkOGZB?=
 =?utf-8?B?dUQzTXVGQ0NyQTNMQmt2K3pablVsS0NFc0F6Uzkxc0gwbjRnSXRxampSUXFN?=
 =?utf-8?B?b3g5Qnh2ZXdnZXBaUGx0UnR3Y3BuNW9ZallPY00xVEpNbHBMWm5hMm5KRkhO?=
 =?utf-8?B?WVp3Mmk4TWlEbGZRSjBvZEZvRGFZWEJIYU1VSUtiWks0VFNTYlFDeFFwTDM2?=
 =?utf-8?B?b00xTDlmendySjRZNTNwb2hLYStpYW9CeitCWmtXUmVzM1lPS0pFc1FvNHhF?=
 =?utf-8?B?VVFteHZFbDVjZWx6eEhoL0U3cmxDeTE5UFJhMy9XTUFxV0FrSWtHdUVWZFZw?=
 =?utf-8?B?a3Z2b0d4UXdtKzV0Zll1TmhIcU9OM3dTazZxNTIvbDlBVVlzWmxnYlowT256?=
 =?utf-8?B?WlQ4dHoxSWd2bFhLajhmS0NQUjkyNlR0NWE2VENIOWRGQmx2ZDhDTHVyL2VN?=
 =?utf-8?B?Ryt6OExNdDdkZWlKTVc1UjMrRXpzWUFRSjZvS2ZMSXphaGEvUnl5QTQ2ZFpi?=
 =?utf-8?B?aFdsais2dEcvUzlISlhJNzR6YkVHblRreGRhRGU1T2ZkMldQd3cySTJQRDN0?=
 =?utf-8?B?L3FQbkxEamZwcitCTDAxMEd4RHZLb29lZ1RybVY1eDd0QzVJNzNVeUxKS3E3?=
 =?utf-8?B?MG1VMmN3TnVsZENFc2JRVHRTelRFK1NuUGFiTjdMSmNaZ0VpcmZsM3JZRVVl?=
 =?utf-8?B?TXkwOTIxZzc3bDhJNWR4QU1GTDVKd25vcjQ5UmFXc2I4N2VDckhGSVhKanpj?=
 =?utf-8?B?TnByTVdNQjBVL2x4UXZYdXRuUUU2WDVkRU1SbjBtUXNDV2UwcXV1WGROWDJB?=
 =?utf-8?B?WmdYSXVmTTFralFaUWJPbXcyVzBGdVlCeGt6QkpaYWdmbTFYM3Iya0h5SzBE?=
 =?utf-8?B?ZEErL3FkY0VXbTJldGZiNm1XaFZVZ1MyRTQyamZnZ0cweTJLTHNaaFBmT0hW?=
 =?utf-8?B?VFZ2RkZRSlUxbnNpclRsSFFUQXFDVW1uTnpZS3kyYXBabi9zRndWTGduS1dC?=
 =?utf-8?B?YWVJTEpQTDBuWDdJT2RIckdjS29ocjMzcmRzVXF0eTgzTTdXNkQ3cm9CUnZC?=
 =?utf-8?Q?Kzhass5uOODVF1SE=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c03b4f85-92f7-493e-a667-08df29af8000
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 04:56:25.5804 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AsLBbGldjTCbVc59EuV5CIHck1dh1z+4s+GTQHohbaCa3qH9bp+2d2mSQkWPvABNelk6borPawm5fJtFR+CV7bL24jA5nIJ7FVPpZVcx/3g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR02MB7213
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=bin.meng@processmission.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
<20261014012323.322790-1-bin.meng@processmission.com>
as the sdhci changes have conflicts.

Changes in v4:
- Rebase on the v4 PolarFire SoC Icicle Kit series
- Simplify the reserved page to a MemoryRegion
- Log invalid reserved accesses and explain the RAZ/WI behaviour
- Reference the U-Boot fix for the reserved-register access
- Make the functional test executable

Changes in v3:
- hw/cpu: a15mpcore: Model the reserved page as RAZ/WI
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
 include/hw/cpu/a15mpcore.h                |   1 +
 include/hw/sd/sdhci.h                     |  10 +-
 hw/arm/fsl-imx6ul.c                       |  87 ++++++++++++-
 hw/arm/mcimx6ul-evk.c                     |   2 +
 hw/cpu/a15mpcore.c                        |  32 +++++
 hw/misc/imx6ul_ccm.c                      |   2 +-
 hw/sd/sdhci.c                             | 151 +++++++++++++++++-----
 tests/functional/arm/meson.build          |   2 +
 tests/functional/arm/test_mcimx6ul_evk.py |  69 ++++++++++
 12 files changed, 390 insertions(+), 41 deletions(-)
 create mode 100755 tests/functional/arm/test_mcimx6ul_evk.py

---
base-commit: 864e276a646ca77b5fc7eb1ae1966b4c290c3b57
branch: imx6ul-evk

-- 
2.53.0


