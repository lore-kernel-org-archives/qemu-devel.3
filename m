Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A3C9C624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 16:15:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2WZN-0003lU-LU; Fri, 04 Sep 2026 12:15:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WZM-0003jo-18; Fri, 04 Sep 2026 12:15:12 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WZJ-0008SI-Rs; Fri, 04 Sep 2026 12:15:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HzUlXu0CodydtJJi/5xtuTOD1vDdx+a9iJvoz4izD4pWaBW9Jcz/tL2NTtqk4DnyIlGIy9DqtI/p4lx5fPJk6z5nOOwFiXxsBMKQSTcyRcBRhvdB8w/XXNbnfis2jj8/k5v2a1wEyn2Zzmc4A+OAT/Z8lQjR0YfOLjUKNlLL+l88/4KZY6IHf7hUJibvHjOMEk3r8k3Zhk7lg9zym+s8ClgTf9vCy5NP6AXhuH9j7QgswZ39qUtv5rYe9pgoJKfZuMlYkwJpqXIeDbhfKa8C4tv0RI5kENBdEn9M4N0+Wiqu7LfE+/7ThKV3ng+QbbZSg63DxKXBTjTK+VALpZt71A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9CE0PMLRKf1PJRBXo5bs+ztknODexlNBGLz/Z2oAIKw=;
 b=xnXlrm2KsN0fTgvO8nxfrLTtamTtKe0oIINf4mHUIc8Ly/iN8Kv0a9imWNCv0sH2Ro1/Dwz6laYgL9BauVMYzNYO6TP2QM/6mjy8WiBtqivbh9mptH0tsCB93QKIPfRn4IhPv99CEpvprcIi9o/+j3E2wYUhR0lEls6HnGNcBUr4Erkjms29utLKn4qTlJTa2EYoKDf5sFici8Z0I5lKzf9Ax5HcPVP/oq77NChAquHJe7k1YQo1m8fdoWuM/Yj6j3rMMfGiPyFM5qv6QYqx6bOYWyS8r78uPno9ag5l9fD3qzoujqJU9wdKgnA60NZTV7Ui0tAQj44LXj/Z77gaEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9CE0PMLRKf1PJRBXo5bs+ztknODexlNBGLz/Z2oAIKw=;
 b=Cm8LwIuVSg3TznkBzXmFIzUpxUQnXH1HP06lt7lx5SO6ywZMOR7mQEM7G60xqUwgU0wZF5gKz04RxYDrqDeDv5lTmFZpgD+RoNXHnbwzcMpDucPlVpxdUC67CW3x3R2oHnV1I1wrpcEsRDJbp4x9hyXiLa5ucDisS3luChQtBYQXVzebYXI6FhBhMapPn9Zp9PMy/YPqXXMVGBqRcOqa8mG33BcvfyGdFmVfJIChre1MqfCL4uV2MZwYd52wF91Pf5zW/T7t/h86Gd5Z4ytNbwZYFEleTdgWDf/ppMh6DHxJ5oqAzKSHpa8NQ/z433P3dNus09+ZNu5yyGw/l/M9UA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by KU2PPFE04A6CE19.apcprd02.prod.outlook.com (2603:1096:d18::46b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 16:15:01 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Fri, 4 Sep 2026
 16:15:01 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org,
 qemu-block@nongnu.org
Subject: [PATCH v2 00/10] hw/arm: Enable U-Boot boot on MCIMX6UL-EVK
Date: Sat,  5 Sep 2026 00:14:23 +0800
Message-ID: <20260904161438.3838261-1-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PAZP264CA0120.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1ef::19) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|KU2PPFE04A6CE19:EE_
X-MS-Office365-Filtering-Correlation-Id: 031aad0a-e44a-40f9-0d9b-08df0a9fac24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|18002099003|56012099006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: 9fJ1Qh8Q26Apy4J4MmH/dtMcYrNHvYNykLVF4U7UtUTzoMi6Sbf9mDeWg0gGoeuNixfMJLJFLtB4Wz+Kydkc5NBBRJdM8vKhdGLEyDTwWIlXgrhDDLjl6jWLJGAg9p/D7J0Hrg/aXnD6/t8CnLHoxjgKS57iK1BPw11BHjRk0OStm2I9EM1AkR3Jsqrile9pavEsnZR6X2afwM9774dqSq1lpExWdXBx9QnBx/pSKG/rNf8ARbeDq4TeRoTjMQUDM7lmcyns54nM/Mtxxbez+XwSXImZ6XPB4MAJzzGGwUKBUhSiHmBL8zeQQY4WZCmDFZS9meh9R+6tEDk5hNIhWj9TPxd2eAC523skipc95IVJ08EWeL5K8t11VhD4UebYbDn5CTeZ2zRbjU+tOQAQIP93apa9h7sBvyt7yZ/KT6ruzC6KLwdCx2gHQ9xTFMuq944dqCbH6v0WU9sxXyay/3UA1eQzgTg2I+QSllAzEMeCchFs1gV3w77VAaSdmmeQwiUJhdiTgdGbMuawILyU072iMqJ8/KfvLYFhpOVxhPa/gjFO1wI+uP8yey5MrQhHpxtQB9RuY0pG+M4nIBNO0x9lenDv2XqloKGpsK8/zYmRlENSQK2zKIMu/K5uP1A2Z5xzZ6/v29pdInlz3iMsNGq9ueH2zanong2utYzy3b4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(18002099003)(56012099006)(10067099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXdKMXNyMHVpRTlDRVYrT0pVazlJL1B3RUwxMHk2eHFCWGpkdnlEY3lBN2Rv?=
 =?utf-8?B?eFhFNWVwaDhxVXB0alFNa0xsS0lZV1FUR3VjUitMQ29PQmgxaWs2Zm1VZTg5?=
 =?utf-8?B?ODl0SVBSNU9uem0rZmRlYUxTYzZMQ1cwRjZSKzMxZTVJZ2RTRHVxVjVUYk1G?=
 =?utf-8?B?bHVHV0Q3S3lJa3ord21PNUhFYWluSWZQQmM3RnZkeDJmR1kvVGdHWW4zSEYr?=
 =?utf-8?B?ZDNZUUlwZHorQmhTcWxmNWNlNTd4VFJPRHpLVkVKQUJYOFlNQmxKU3JUekNC?=
 =?utf-8?B?RHFYaEJsNzNYbkh4b2czRnl2cy9IQjZGUmQ5ZkhnK2x2TXF2K2tUNUNCaFVx?=
 =?utf-8?B?Z01obEcvcnVxUFcwWmlOQm5JaVhKQXpvcTBWRkVnT2FhVXg4eHh4L05vZ0lS?=
 =?utf-8?B?cUY0bml4czlyVU96UE1YMUttdUFTcnZxMmxjMStGSm0zam4xMWw0TGgyVkhR?=
 =?utf-8?B?UG1CVVRUNGZxNUhtcHZhVFdhb2pGTGVGZnFrSmxXNXdRaXNpZEZWZEhNbXBj?=
 =?utf-8?B?RkVZY1NxMXFTbkxDaGxsbmJvKytnU29zbzQ4UlB4T0lCTE12RE0ySUdqOHZm?=
 =?utf-8?B?K3pHc294WjZXOGF4bExrQSsxMUp4QmtLTDVPR3dvalN2QUdZVUtEb1hWMi9V?=
 =?utf-8?B?bkRKNUVGZzZGQWhLYW5majkySnl0czFTMHZibC9lZDZ5cFRWMlo3WGlYQkhR?=
 =?utf-8?B?MTh6bFVpWm9QMmxCeVU4VVZOTlhDVVlsaXFRZmJZWmhqRzNoSFBEK3k0SHlo?=
 =?utf-8?B?RVl2LzdhNFRlclNpRktSK0ZqenJNOERITFZ3S2U1SGRpYTRQdmptemd4WWpH?=
 =?utf-8?B?UnFDWVVzVzEvdENuZmsyZ01ZdnpHUUlpc1A0eEZJUjg3QmMrWWN3U3J5RFQ5?=
 =?utf-8?B?czMxWDhHdnRQblFQSW9BazBjemdrNjFnWFhMZ3gwblJQRkFFME5PV2N3VVRJ?=
 =?utf-8?B?c2NhTXhvb3V1cVYwR05mdHFIU2V6eTlMUGRReWtKWGcvWVBBOEJ1ZE41Z3lm?=
 =?utf-8?B?S205dmRocHVOSnJaZk1QOERrbEZnTGFZVzVaNUd4QmExdnpWRE5nVVkreHpQ?=
 =?utf-8?B?bXdnTnMrZ1Z1Mk5HbVZOaWV0dmI1bnVwMkZqUmcvdnF6VERXYXdiV3N1R0xQ?=
 =?utf-8?B?WjczcThYcU43RmlYeVl6S1JNNjlUZE5EUWxOREFxbGd0amlRMEQxclp4YnAw?=
 =?utf-8?B?SGhrR1QwS2NSc0c0Y0NEL1hWY054YlgzQU1RVWFjSEIveXBKSXI0c1c1U2Vq?=
 =?utf-8?B?TFJ1eVRsanZER2pPMW1OWkhNRjFKZTBucUFQNFk3TzJKTWEvcE81ZEhuZUVu?=
 =?utf-8?B?MnVqL0s5Zzd3MFhKUmErNE52RjFVYWhWM0tvcEovK0dEK0JKRzVyNGt4YnZZ?=
 =?utf-8?B?bFVxNUJ0ck9lM3h6dmllcEVpNGQrZXI3SHM4cWhMOENjMXEyU01ZS0J4RHgx?=
 =?utf-8?B?RzlzeVMwZjYrY09wQ3UySDhTSXNQNGRvaFByZEs3TlgzZC9VaFJHNWc4bDBV?=
 =?utf-8?B?MllCejErSjVXSmhLVzJqK1FKRWc2a0szMHFQWVd2YlVFQ2UxdjFWUFdrdy9H?=
 =?utf-8?B?QWZWZ0graXlKRmFGQ21TTy9WTnJnN1d5RjFNNjhIVkdBZWZMZDVmWk1tQVBH?=
 =?utf-8?B?WE9PaklpZklrSDQrVHVIblFodnlSUUJyT1BYQnRnSkVmTHpIR2NLQm9lakJj?=
 =?utf-8?B?M1pnWE5jWVJmYklmdWI5R0JFNW1lZjdHdy9sZUYycXBjTkVDczdXTHp6c0xt?=
 =?utf-8?B?Z3cxSjQzakViSTNzY2VST0tOYzRSdVRyS0Mwd3V0NEVrSHVOdTJ3MXF4Z1Zj?=
 =?utf-8?B?RGNrMlhWeXVjSjVnZUFUZFFQdFhTNnlKZG5nNXQwN2xTTkVZWitHZUg2RmxG?=
 =?utf-8?B?dUxWNmpucEEvQm5VaDljSUtxT2MvK3JtTUp4cmUzUU5JVXN2WFNaSkZnc2pn?=
 =?utf-8?B?M0hpM284eUZMR2w1UmZDTkdjbjhwd3N0M0lVeThkU2VEMmI2WUQrY2h6RVBY?=
 =?utf-8?B?ZG01Y1NzVXNBVXIwNklrdDZITGJSaTZQRTZPZGd2Zjl4TXcwN2RSSmJYa0c3?=
 =?utf-8?B?L0NqK0JqeTgyaUd2bkh5bHZHQXpMTVpIMGJtR2VxNk4veXdlVzBtYm54M1dp?=
 =?utf-8?B?cnQ1aFB3eXcrTUxla01nSGRYUS9lTEZ1WUtvbTllaWhoa3RNV1hqQVA2ODFp?=
 =?utf-8?B?OWQ0cXRvR0JNZ2xtU3FwbkhQN21BYlplb290Q25vZE0yNVY3eHBySFRNbzlP?=
 =?utf-8?B?Q1IxV0NXb0V0cmZlS0pOMGJlbHV5dlFEQzRtY3FtdXpJb3czeGZ3S2lIMkJV?=
 =?utf-8?B?Q3ZXR0ppL0FWNEtOTDFXR2QrY0lidWJhZnZ5SWIxYWU1UVBWTy9ZNFBtcDJR?=
 =?utf-8?Q?m8aFp4dkeuS385oE=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 031aad0a-e44a-40f9-0d9b-08df0a9fac24
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 16:15:01.4877 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zu36tDpCBTQzeTxR/HKdQo0qJw2DLzRMTaRkKd70787cFVwjRbiEXX3CjHSeiF7Fo22CaIoQzSx8Iufy4crTB+lSrmvv7d1ss2mpN2XdG2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPFE04A6CE19
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
<20260904155758.3833179-1-bin.meng@processmission.com>
as the sdhci changes have conflicts.

Changes in v2:
- rebase on top of the microchip polarfire soc series

Bin Meng (10):
  hw/arm: fsl-imx6ul: Add SCU compatibility window
  hw/misc: imx6ul_ccm: Update PMU_MISC0 reset value
  hw/arm: fsl-imx6ul: Map early firmware register placeholders
  hw/arm: fsl-imx6ul: Add a minimal MMDC geometry model
  hw/sd: sdhci: Use a QEMU-local no-busy IRQ quirk bit
  hw/sd: sdhci: Honor i.MX uSDHC vendor clock gates
  hw/sd: sdhci: Preserve uSDHC status enables for U-Boot
  hw/sd: sdhci: Skip SDMA boundary stops for i.MX uSDHC
  docs/system/arm: Document MCIMX6UL-EVK Buildroot boot
  tests/functional/arm: Add MCIMX6UL-EVK boot tests

 MAINTAINERS                               |  1 +
 docs/system/arm/mcimx6ul-evk.rst          | 67 +++++++++++++++++
 include/hw/arm/fsl-imx6ul.h               |  2 +
 include/hw/sd/sdhci.h                     | 15 +++-
 hw/arm/fsl-imx6ul.c                       | 87 +++++++++++++++++++++-
 hw/arm/mcimx6ul-evk.c                     |  2 +
 hw/misc/imx6ul_ccm.c                      |  2 +-
 hw/sd/sdhci.c                             | 89 +++++++++++++++++++----
 tests/functional/arm/meson.build          |  2 +
 tests/functional/arm/test_mcimx6ul_evk.py | 69 ++++++++++++++++++
 10 files changed, 314 insertions(+), 22 deletions(-)
 create mode 100644 tests/functional/arm/test_mcimx6ul_evk.py

---
base-commit: ae88a4d09c609651004dab309cd375d9f90323d3
branch: imx6ul-evk

-- 
2.53.0


