Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008C3606A327
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 05:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=q+fK8MMD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRNNU-0006Bf-Er; Thu, 12 Nov 2026 00:29:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xRNNO-0006BJ-Jl
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 00:29:34 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xRNNL-0005wF-Mf
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 00:29:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gAYE8BBpxl8DL26jnie8CnrWeWTNl87C+AqdYSsJ4AqL5JIsFfT+X/pFRNw2xZX8SO8O9PW0x3FnORgmAQox81PsM0Tygpbv5LjMNPUw4LQ16sQMgLUqMLrAgGm/yCQ5EgOPn+lZaPJ7xEUfqrH1ktYuCzySW99UW8/THPGIv+a+aOmHJxKmjqC2Pv7IhBifevCJAm4LDrJNH6VcGg5PGhuP/raLAcCxautOW7EcvTwvzdRMykyEdrRUHoshCnkRSlo26hS9Qraty2R28ZocOLkKywoOTmvwazh3Y9kZbkoAbL3yKphiLxWZQ/YJ4fdjUaXbNBgq34Srjs+BOEQuSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50Jip+PMP1cnvgwVoqMzXgurCA8vGj2fwRIuaXz9hIQ=;
 b=CqLCwky7xp4Ysb4pcfsHMJRu7OKvFztODnTgLxrugJpKlR6OWN/o/7xd++x2QrTqg+zuxS/2B23MMvHWWovSu9NSrmgZHjDF/jWG1PIaN2pio5e5wV+2KdCO3+2Z+BupTmy8I/D6PAU6k+Cl46A31BLAeTpO9aUGdLFwrIoO8o60g69J8tHq8AFQibi+iperF7JjHOt5344/bOkCce0yrylZmf/e+cgYaN9pkzH+YupdtyMupczq8I3+PrrPz//+ONIOuRuhv20r/dDVVtamv1jKBgdt6XaauIJlDlQVGA5PdZX1vKB+21robBGTB/marIZJ9Gol5qo9z+XcHDSqaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50Jip+PMP1cnvgwVoqMzXgurCA8vGj2fwRIuaXz9hIQ=;
 b=q+fK8MMD6pbMY9mP9PWecLboJe+yQs9K5rEoyM4Z6ZGpRT1pEMWp/1psl+bLp+gTAleAr3BAdsjbrlyU04gDLKMIMIXns7CUJRL1UmcIEyj+RDWfAq3dMZBazE9k5TNp3KEg+dJ9PYrQc1YrygG8dKeVFJJozZ9CYbdA3Hbm/6gbxDVyno702W0z9zyww2BhJivgstmQqa0CQSZ+q8JoGuFMRqeMpeyz1qeAYowcEF7a/eNQ1ECCF79nEe21nHZQd77VqLuVe/yqjIUdHO06vcXlKwP85gk20Mue4p4uwyEu1WBVOBmJSZl7TC51p+usRIS+kLDV6z7ikLPK8iGNbw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by OSNPR02MB8964.apcprd02.prod.outlook.com (2603:1096:604:45e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 05:28:51 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.012; Thu, 12 Nov 2026
 05:28:50 +0000
From: Bin Meng <bin.meng@processmission.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Marek Vasut <marex@nabladev.com>,
 Michal Simek <michal.simek@amd.com>, QEMU <qemu-devel@nongnu.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Yao Zi <me@ziyao.cc>
Subject: [PATCH v4 1/2] qemu: arm: Rename QEMU arm* defconfig files
Date: Thu, 12 Nov 2026 13:28:32 +0800
Message-ID: <20261112052835.1883576-1-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0362.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::16) To TYZPR02MB7121.apcprd02.prod.outlook.com
 (2603:1096:405:2c::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR02MB7121:EE_|OSNPR02MB8964:EE_
X-MS-Office365-Filtering-Correlation-Id: 42452412-cebb-44a1-651d-08df407dd511
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|7416014|18002099003|6133799003|261009223027099003|3023799007|13003099007|56012099006|261028144727099003|261102123227099003|261021121427099003|261022105027099003|261026140227099003|261026121527099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info: hYAwpFQxbo5q+qQnHpy7M0masi6yTum5x7QaKECXz8LI03oIULr5kvQlyj5qjJtU8hCmU7Q6rmVk1ex9NT+dVGDFiR4KccvxarVDJ6rpDo1enqTiFXxCsvdcuMH0XA/Dq0o+erL7yErFnAR+y6KNBuOR5aaq1mDwRDGSZUfBiJO34H6tSlUXABhT2T/FgvEMDTaDPhGvsZ3G15yQf7Fo7TrrAG54QuGMcEV3gx1f+qPcFnLSBJP479/AzfSG/QBlmdrHD+5EhZkjUhJv0QQoZ0mdFi7uDzeXy0jXvQhcVu/BmJt5DF0eeqgkenuAMiz8OUiOMqzkn2I0D3IGwRrl0U0Q2sBygQapeqLmrHHphg74BfOfW7vDI13UEActNylnLmApqgS4w9HoxNegj2VwM8c5b+XYTRiarvFkH8f1z7pdy6xnXezaVoggbo2kqYXg1bUGeybYOgHEw//DJT3oCrDYzhj6Jd7lPDP7MfEROh+f0kNywqDn8da+6fW0M+524AA5YVw30GbsUQ8lxcYE/H/JVy9gQIfQrov16c9vcgHV8jFg20y3MgAMy4VIItMcoZ+GMLTzHPNkD7Sgassz8gfP4SQa0DTi2Ko7f317mAbfizZFm5dDcxGgp+r4Ldl0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(7416014)(18002099003)(6133799003)(261009223027099003)(3023799007)(13003099007)(56012099006)(261028144727099003)(261102123227099003)(261021121427099003)(261022105027099003)(261026140227099003)(261026121527099003)(261021123027099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZzEGfGGDjMV+8SRmwfSRO48zn0CWTqtj7DPu2H4zptbij7Nd2wYx+1KN4X1Q?=
 =?us-ascii?Q?hoeMGnaoOASwK5M1bxAX7z+K2lOje5NVeYdNIExRgp7UDydsZ+enEDd94RX8?=
 =?us-ascii?Q?urt87uGZTUxd04VU0f8FO0nBe6RIjD0RKADXU/Kl98cbi6lGFEbi3AGpPD5y?=
 =?us-ascii?Q?/yuf4HsEVr51hi1ITNjkSFblk0WXRMvW7xR3VHh/Bt6evEakC55mwjOMzlHK?=
 =?us-ascii?Q?4ZrFRIsI+qA7C2JzuSBi+yIRF6klpMjp3nGWnsd2FohzK/xLJz/dZjvSaZ08?=
 =?us-ascii?Q?gKauyz2w7+1hVX4PCbDoeH8i1n78pCW4/wtJJyOLfOrqoAvWFKREawbKvBKe?=
 =?us-ascii?Q?vstQ3UO2tcRBl6M375Q5bXkgzD5d/of31MHYMf2nUJzDwSYI1ECA8h+WEPMo?=
 =?us-ascii?Q?p98JdotqDwJMsLeP4ucB9LcM8OE3Y3WInHDA5INh37U11bWo0nraA8Ln9ytf?=
 =?us-ascii?Q?mDzZox3iAYzPrxtdTjj5nmcIcpIW6rz0/CtJMcwYgcMCRQxpGueiwsUV4S61?=
 =?us-ascii?Q?PoOa5XPGKd/UUoxW6iV2mjqPfK9u5H+RhI9dfZPHo4PVaou8WDzdvORyRMTM?=
 =?us-ascii?Q?MtdYhA4cX3Hpns/KEtbepEdklQb7c7mQume+Qqf4L628pwMprZOuY9AvTHnk?=
 =?us-ascii?Q?5QB8xOuZgPPb5XycN5qQAbunQ2RzRmTKxx7VXAzdtv/eYqS7eRtTSAEYT8TL?=
 =?us-ascii?Q?Mf/kXiELMW9RJorqGyEJ3HZ559MolLMcZCMvetbHRmcQSRy3BJaFgZbsDpou?=
 =?us-ascii?Q?IVm1fWCq2swFjMXLymFurK0aK9v1z8No/Z/ANvZLds0bZL4cPj6ADDaVA0MU?=
 =?us-ascii?Q?9ulTLpyJUjISBDbkW1g3kIwGnAVnHCYDylpeRIf66rd3/eKXouFa3tHuHchA?=
 =?us-ascii?Q?5mni0DY9a42b50dGe2nGFs6MKu+9me8Q4t1Wz08z5nc+G5pX0q/sURzWOyba?=
 =?us-ascii?Q?XiMK5l/O/77qWMSMINxWQPsUzUX2iqKeTaZsDnDpS1ImPFVfLIU740ITnTHs?=
 =?us-ascii?Q?ih1oILqE2HGjJNsAS+p4fKl9PJHGESkUSJzaCIE7a+/K/2ZVWs9jwUapLsMb?=
 =?us-ascii?Q?xAZ0/CIiDMDItef7cs+BATrc3t3EizQitq+wZe/HI44rlTtXjSrkfgU0a4IB?=
 =?us-ascii?Q?Y/heFq3i+2Q7RMiEnxYK0zB1s/IV/svhLWCJujw0unROqa0wuoBG6aTQ6vz+?=
 =?us-ascii?Q?5llDrLFEYRfQQPCpWb2OukxjOXc16vdDIaR+XSkNWLwH0lwnRDXGmdSdhGzj?=
 =?us-ascii?Q?bste0YXS3R6Ir0isQe6r6vCkkaro/wui/5hW0deX3iWz8rEOzA2MoIezma2x?=
 =?us-ascii?Q?s8Sle7mEdvmAyiyOlBkj0u7qCXLjVRqKUInaBkdd4I5EViWwcafeP0wUzo9f?=
 =?us-ascii?Q?VRWaouwezC+tKVzvZbj1jnPmkCYwcZ58HksElzr8gl4hOWxjbxN9OPNmWDU2?=
 =?us-ascii?Q?4lQLzBHqhMyhEx1ecgC9lZS7X4V74MjIW5YTZPfTCOJnvtn9N0rs3D0zngI3?=
 =?us-ascii?Q?KnOa2rv/WsY76vuSzbwGCDe2x3ZdBVO8wFUlUOBier0hsy73BrDDEvxvxa5a?=
 =?us-ascii?Q?jyBipkuLX0oJrfNlYPJ2VKnlOVLAJ/kOr5XHHe9mYP934dcOTx8KjR+7qKfZ?=
 =?us-ascii?Q?YAbXsKAoRGxRvC4zv/vMjt0jOo43o6QCrTt/xp0eQwRc/bHRhCUb2WxPOv7k?=
 =?us-ascii?Q?dfA+x2O/dP+6j0INMguKsYmvnTFXIhdHD8JcnMyU4041JLYub+zQO1XohS5k?=
 =?us-ascii?Q?SsBWnG1wt3rkPEPHdNsf25BCNL4UcZ0=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42452412-cebb-44a1-651d-08df407dd511
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 05:28:50.2335 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /mMgZlsPkHboNoo724+NRBsQGTokz3gB1AqJzyUrtpFy7ZwvOfFa1hZYuqF6wmrOFv5Ks/ROWFHcArFaAcLc2Mg4mRTcocZywexmfxZQscE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR02MB8964
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Bin Meng <bmeng.cn@gmail.com>

Other QEMU defconfig files use a hyphen between "qemu" and the
architecture name, but ARM uses an underscore. Rename the ARM
defconfigs for consistency.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

(no changes since v3)

Changes in v3:
- Rebase on current mainline and keep the removed ARM devicetree deleted

Changes in v2:
- Add missing Azure and GitLab CI changes

 .azure-pipelines.yml                          | 24 +++++++++----------
 .gitlab-ci.yml                                | 24 +++++++++----------
 MAINTAINERS                                   |  2 +-
 arch/arm/dts/qemu-arm64.dts                   |  2 +-
 board/emulation/qemu-arm/MAINTAINERS          |  2 +-
 ...pi_defconfig => qemu-arm64_acpi_defconfig} |  2 +-
 ...u_arm64_defconfig => qemu-arm64_defconfig} |  0
 ...ip_defconfig => qemu-arm64_lwip_defconfig} |  2 +-
 ...{qemu_arm_defconfig => qemu-arm_defconfig} |  0
 doc/board/emulation/qemu-arm.rst              |  8 +++----
 doc/develop/driver-model/virtio.rst           |  6 ++---
 doc/develop/uefi/uefi.rst                     |  2 +-
 tools/docker/Dockerfile                       |  8 +++----
 13 files changed, 41 insertions(+), 41 deletions(-)
 rename configs/{qemu_arm64_acpi_defconfig => qemu-arm64_acpi_defconfig} (54%)
 rename configs/{qemu_arm64_defconfig => qemu-arm64_defconfig} (100%)
 rename configs/{qemu_arm64_lwip_defconfig => qemu-arm64_lwip_defconfig} (83%)
 rename configs/{qemu_arm_defconfig => qemu-arm_defconfig} (100%)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index fcf7aafade6..ccd30efa2d9 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -253,9 +253,9 @@ stages:
           cd \${WORK_DIR}
           git config --global --add safe.directory \${WORK_DIR}
           git clone --depth=1 https://git.u-boot-project.org/u-boot/u-boot-test-hooks /tmp/uboot-test-hooks
-          # qemu_arm64_lwip_defconfig is the same as qemu_arm64 but with NET_LWIP enabled.
-          # The test config and the boardenv file from qemu_arm64 can be re-used so create symlinks
-          ln -s conf.qemu_arm64 /tmp/uboot-test-hooks/bin/travis-ci/conf.qemu_arm64_lwip_na
+          # qemu-arm64_lwip_defconfig is the same as qemu-arm64 but with NET_LWIP enabled
+          # The test config and the boardenv file from qemu-arm64 can be re-used so create symlinks
+          ln -s conf.qemu-arm64 /tmp/uboot-test-hooks/bin/travis-ci/conf.qemu-arm64_lwip_na
           ln -s u_boot_boardenv_qemu_arm64_na.py /tmp/uboot-test-hooks/py/travis-ci/u_boot_boardenv_qemu_arm64_lwip_na.py
           ln -s travis-ci /tmp/uboot-test-hooks/bin/\`hostname\`
           ln -s travis-ci /tmp/uboot-test-hooks/py/\`hostname\`
@@ -474,21 +474,21 @@ stages:
           TEST_PY_BD: "integratorcp_cm926ejs"
           TEST_PY_ID: "--id qemu"
           TEST_PY_TEST_SPEC: "not sleep"
-        qemu_arm:
-          TEST_PY_BD: "qemu_arm"
+        qemu-arm:
+          TEST_PY_BD: "qemu-arm"
           TEST_PY_TEST_SPEC: "not sleep"
-        qemu_arm64:
-          TEST_PY_BD: "qemu_arm64"
+        qemu-arm64:
+          TEST_PY_BD: "qemu-arm64"
           TEST_PY_TEST_SPEC: "not sleep"
           OVERRIDE: "-a CONFIG_SEMIHOSTING=y"
-        qemu_arm64_lwip:
-          TEST_PY_BD: "qemu_arm64_lwip"
+        qemu-arm64_lwip:
+          TEST_PY_BD: "qemu-arm64_lwip"
           TEST_PY_TEST_SPEC: "test_net_dhcp or test_net_ping or test_net_tftpboot"
-        qemu_arm64_tfa_fw_handoff:
-          TEST_PY_BD: "qemu_arm64"
+        qemu-arm64_tfa_fw_handoff:
+          TEST_PY_BD: "qemu-arm64"
           TEST_PY_ID: "--id fw_handoff_tfa_optee"
           TEST_PY_TEST_SPEC: "test_fw_handoff"
-        qemu_arm_sbsa_ref:
+        qemu-arm_sbsa_ref:
           TEST_PY_BD: "qemu-arm-sbsa"
           TEST_PY_TEST_SPEC: "not sleep"
         qemu_m68k:
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 0338f20b8a2..905523e3e27 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -37,9 +37,9 @@ stages:
     # Clone uboot-test-hooks
     - git config --global --add safe.directory "${CI_PROJECT_DIR}"
     - git clone --depth=1 https://git.u-boot-project.org/u-boot/u-boot-test-hooks /tmp/uboot-test-hooks
-    # qemu_arm64_lwip_defconfig is the same as qemu_arm64 but with NET_LWIP enabled.
-    # The test config and the boardenv file from qemu_arm64 can be re-used so create symlinks
-    - ln -s conf.qemu_arm64 /tmp/uboot-test-hooks/bin/travis-ci/conf.qemu_arm64_lwip_na
+    # qemu-arm64_lwip_defconfig is the same as qemu-arm64 but with NET_LWIP enabled
+    # The test config and the boardenv file from qemu-arm64 can be re-used so create symlinks
+    - ln -s conf.qemu-arm64 /tmp/uboot-test-hooks/bin/travis-ci/conf.qemu-arm64_lwip_na
     - ln -s u_boot_boardenv_qemu_arm64_na.py /tmp/uboot-test-hooks/py/travis-ci/u_boot_boardenv_qemu_arm64_lwip_na.py
     - ln -s travis-ci /tmp/uboot-test-hooks/bin/`hostname`
     - ln -s travis-ci /tmp/uboot-test-hooks/py/`hostname`
@@ -386,33 +386,33 @@ integratorcp_cm926ejs test.py:
     TEST_PY_ID: "--id qemu"
   <<: *buildman_and_testpy_dfn
 
-qemu_arm test.py:
+qemu-arm test.py:
   variables:
-    TEST_PY_BD: "qemu_arm"
+    TEST_PY_BD: "qemu-arm"
     TEST_PY_TEST_SPEC: "not sleep"
   <<: *buildman_and_testpy_dfn
 
-qemu_arm64 test.py:
+qemu-arm64 test.py:
   variables:
-    TEST_PY_BD: "qemu_arm64"
+    TEST_PY_BD: "qemu-arm64"
     TEST_PY_TEST_SPEC: "not sleep"
     OVERRIDE: "-a CONFIG_SEMIHOSTING=y"
   <<: *buildman_and_testpy_dfn
 
-qemu_arm64_lwip test.py:
+qemu-arm64_lwip test.py:
   variables:
-    TEST_PY_BD: "qemu_arm64_lwip"
+    TEST_PY_BD: "qemu-arm64_lwip"
     TEST_PY_TEST_SPEC: "test_net_dhcp or test_net_ping or test_net_tftpboot"
   <<: *buildman_and_testpy_dfn
 
-qemu_arm64_tfa_fw_handoff test.py:
+qemu-arm64_tfa_fw_handoff test.py:
   variables:
-    TEST_PY_BD: "qemu_arm64"
+    TEST_PY_BD: "qemu-arm64"
     TEST_PY_ID: "--id fw_handoff_tfa_optee"
     TEST_PY_TEST_SPEC: "test_fw_handoff"
   <<: *buildman_and_testpy_dfn
 
-qemu_arm_sbsa test.py:
+qemu-arm_sbsa test.py:
   variables:
     TEST_PY_BD: "qemu-arm-sbsa"
     TEST_PY_TEST_SPEC: "not sleep"
diff --git a/MAINTAINERS b/MAINTAINERS
index 9fc6614e519..01450e760c5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1337,7 +1337,7 @@ M:	Jerome Forissier <jerome.forissier@arm.com>
 S:	Maintained
 T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-net.git
 F:	cmd/lwip/
-F:	configs/qemu_arm64_lwip_defconfig
+F:	configs/qemu-arm64_lwip_defconfig
 F:	include/net-lwip.h
 F:	lib/lwip/Makefile
 F:	lib/lwip/u-boot/
diff --git a/arch/arm/dts/qemu-arm64.dts b/arch/arm/dts/qemu-arm64.dts
index 95fcf53ed74..382d131f47f 100644
--- a/arch/arm/dts/qemu-arm64.dts
+++ b/arch/arm/dts/qemu-arm64.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+ OR MIT
 /*
- * Empty device tree for qemu_arm64
+ * Empty device tree for qemu-arm64
 
  * Copyright 2021 Google LLC
  */
diff --git a/board/emulation/qemu-arm/MAINTAINERS b/board/emulation/qemu-arm/MAINTAINERS
index 538769f8040..b2b1fce75cf 100644
--- a/board/emulation/qemu-arm/MAINTAINERS
+++ b/board/emulation/qemu-arm/MAINTAINERS
@@ -5,5 +5,5 @@ F:	board/emulation/qemu-arm/
 F:	board/emulation/common/
 F:	include/configs/qemu-arm.h
 F:	include/configs/qemu-sbsa.h
-F:	configs/qemu_arm*
+F:	configs/qemu-arm*
 F:	configs/qemu-arm-sbsa_defconfig
diff --git a/configs/qemu_arm64_acpi_defconfig b/configs/qemu-arm64_acpi_defconfig
similarity index 54%
rename from configs/qemu_arm64_acpi_defconfig
rename to configs/qemu-arm64_acpi_defconfig
index f85f2913530..ef4c9f156c5 100644
--- a/configs/qemu_arm64_acpi_defconfig
+++ b/configs/qemu-arm64_acpi_defconfig
@@ -1,2 +1,2 @@
-#include <configs/qemu_arm64_defconfig>
+#include <configs/qemu-arm64_defconfig>
 #include <board/emulation/configs/acpi.config>
diff --git a/configs/qemu_arm64_defconfig b/configs/qemu-arm64_defconfig
similarity index 100%
rename from configs/qemu_arm64_defconfig
rename to configs/qemu-arm64_defconfig
diff --git a/configs/qemu_arm64_lwip_defconfig b/configs/qemu-arm64_lwip_defconfig
similarity index 83%
rename from configs/qemu_arm64_lwip_defconfig
rename to configs/qemu-arm64_lwip_defconfig
index 06ed5a131db..5b1ddb2af03 100644
--- a/configs/qemu_arm64_lwip_defconfig
+++ b/configs/qemu-arm64_lwip_defconfig
@@ -1,4 +1,4 @@
-#include <configs/qemu_arm64_defconfig>
+#include <configs/qemu-arm64_defconfig>
 
 CONFIG_ARM=y
 CONFIG_ARCH_QEMU=y
diff --git a/configs/qemu_arm_defconfig b/configs/qemu-arm_defconfig
similarity index 100%
rename from configs/qemu_arm_defconfig
rename to configs/qemu-arm_defconfig
diff --git a/doc/board/emulation/qemu-arm.rst b/doc/board/emulation/qemu-arm.rst
index 9e993ca9783..d575bc64ff6 100644
--- a/doc/board/emulation/qemu-arm.rst
+++ b/doc/board/emulation/qemu-arm.rst
@@ -32,7 +32,7 @@ U-Boot
 
 - For AArch64::
 
-    make qemu_arm64_defconfig
+    make qemu-arm64_defconfig
     make
 
 On successful build 'u-boot.bin' should be created. It's necessary in the following
@@ -100,12 +100,12 @@ Set the CROSS_COMPILE environment variable as usual, and run:
 
 - For ARM::
 
-    make qemu_arm_defconfig
+    make qemu-arm_defconfig
     make
 
 - For AArch64::
 
-    make qemu_arm64_defconfig
+    make qemu-arm64_defconfig
     make
 
 Running U-Boot (secure)
@@ -182,7 +182,7 @@ Booting distros
 ---------------
 
 It is possible to install and boot a standard Linux distribution using
-qemu_arm64 by setting up a root disk::
+qemu-arm64 by setting up a root disk::
 
     qemu-img create root.img 20G
 
diff --git a/doc/develop/driver-model/virtio.rst b/doc/develop/driver-model/virtio.rst
index e5da9f4301c..90a12fb3003 100644
--- a/doc/develop/driver-model/virtio.rst
+++ b/doc/develop/driver-model/virtio.rst
@@ -32,8 +32,8 @@ network and block device, the most two commonly used devices, are supported.
 
 The following QEMU targets are supported.
 
-  - qemu_arm_defconfig
-  - qemu_arm64_defconfig
+  - qemu-arm_defconfig
+  - qemu-arm64_defconfig
   - qemu-arm-sbsa_defconfig
   - qemu-riscv32_defconfig
   - qemu-riscv64_defconfig
@@ -51,7 +51,7 @@ variable being properly set to a working toolchain for ARM:
 
 .. code-block:: bash
 
-  $ make qemu_arm_defconfig
+  $ make qemu-arm_defconfig
   $ make
 
 You can even create a QEMU ARM target with VirtIO devices showing up on both
diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
index 94ddf690440..c2bad4cdd5f 100644
--- a/doc/develop/uefi/uefi.rst
+++ b/doc/develop/uefi/uefi.rst
@@ -713,7 +713,7 @@ HTTP(s) Boot can be activated by specifying::
 
 For QEMU targets there's a Kconfig that supports this by default::
 
-    make qemu_arm64_lwip_defconfig
+    make qemu-arm64_lwip_defconfig
 
 The commands and functionality are similar to the legacy stack, with the notable
 exception of not having to define an "httpserverip" if you are trying to resolve
diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 187320c26d5..8680ea257e5 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -251,7 +251,7 @@ RUN git clone https://gitlab.com/qemu-project/qemu.git /tmp/qemu && \
 	make -j$(nproc) all install && \
 	rm -rf /tmp/qemu
 
-# Build OP-TEE for qemu_arm64
+# Build OP-TEE for qemu-arm64
 RUN git clone --depth=1 https://github.com/OP-TEE/optee_os.git /tmp/optee_os \
 	-b 4.7.0 && \
 	cd /tmp/optee_os/ && \
@@ -264,7 +264,7 @@ RUN git clone --depth=1 https://github.com/OP-TEE/optee_os.git /tmp/optee_os \
 		CFG_REE_FS=n CFG_CORE_ARM64_PA_BITS=48  \
 		CFG_TEE_CORE_LOG_LEVEL=2
 
-# Build fiptool, bl1 and fip for fvp and qemu_arm64
+# Build fiptool, bl1 and fip for fvp and qemu-arm64
 RUN git clone --depth=1 -b mbedtls-3.6 https://github.com/ARMmbed/mbedtls.git /tmp/mbedtls
 RUN git clone --depth=1 https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git /tmp/tf-a \
 	-b v2.13.0 && \
@@ -294,9 +294,9 @@ RUN git clone --depth=1 https://git.trustedfirmware.org/TF-A/trusted-firmware-a.
 		MBOOT_EL_HASH_ALG=sha256 \
 		MBEDTLS_DIR=/tmp/mbedtls \
 		-j$(nproc) all fip && \
-	mkdir -p /opt/tf-a/qemu_arm64_fw_handoff_tfa_optee && \
+	mkdir -p /opt/tf-a/qemu-arm64_fw_handoff_tfa_optee && \
 	cp build/qemu/release/fip.bin build/qemu/release/bl1.bin \
-		/opt/tf-a/qemu_arm64_fw_handoff_tfa_optee/ && \
+		/opt/tf-a/qemu-arm64_fw_handoff_tfa_optee/ && \
 	make CROSS_COMPILE=/opt/gcc-${TCVER}-nolibc/aarch64-linux/bin/aarch64-linux- \
 		PLAT=sun50i_a64 -j$(nproc) all && \
 	mkdir -p /opt/tf-a/pine64_plus && \
---
base-commit: 3cb2cbbc75aa7fe2391f662607d6b2f46c1292a7
branch: qemu-arm

-- 
2.53.0


