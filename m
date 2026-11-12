Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CF5606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 05:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=p3DIdyE3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRNRn-0007J4-Uf; Thu, 12 Nov 2026 00:34:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xRNRi-0007IL-Up
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 00:34:04 -0500
Received: from mail-japanwestazon11022081.outbound.protection.outlook.com
 ([40.107.75.81] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xRNRg-0008Mf-Nu
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 00:34:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uz3HhY5ANKd+ciE9QXwqYzqh7MDUCMjTFjjXd+yXB4xlkGRvNbWPHkn4GHe6O2M8unw4j16HQh1bUI8xeka64shjIDvroazvs5o0SiPo95u+YpMznjKeNAAQm7AX6tcQWgHVZIdlp/0MO8SrXu0bibLHsK0faBFxak9ktnjL6X8JI/nXYS1XS88RyGi7NwYwkn+BcWQUoQJaHUQDlllGzvL8dIpUFjYJGmPvvSgntrO0Te8URipXYIo9j+3EzWeocZ7BxynlBvilFM3b9GRDKF0N7FyPFoOsDIooYAnhCBWufZ2JYoxoBaSX8TSlSpAHDVqaC7Hh55oHfdc5JRlhAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9btmt1Gem5IwftXQ/n/Ww9WIhwL4tfcK1kxNezV1Xx4=;
 b=YeoMjVQHjrkxb64oLIDbGdSo/FDOp7uzmWUzNJyyXewpBKLJMAfTIQEC9P55YTLiduLyuWpUECcsCvc9eXotsRNODNvnrgeSK3OQWdY+8azi9qUOCEAA2Eooi4v8pHn4ZKBaRtELtJ2qYShp3fGCmEfhYWJ8BqtZxtz41J/fZT6NRky3tQwlwNHkAXjCwkFzPGNj2U5D1zoUbOwYtIbxL09Is3Woft9Q3cPnB0vpS8eD4B52hyG/l1YO99wfXmLa5ds/dPN/s65MIF0mqjO+p4N4Uj0KtpFNm3Heh6jCKRH27yj9udOCYPF2UQb0+DCXWrsFyKbwxskJDGypLWCSUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9btmt1Gem5IwftXQ/n/Ww9WIhwL4tfcK1kxNezV1Xx4=;
 b=p3DIdyE3gD+1FMQzTAJz8+DzmJt4Cn4/jKzM/KxpCsP0cWoZSRoDyU1iCUsSsoGWXWK5MP87ilRZnCDARQ+eMHQ/M1KfzhdP3AvSWAE1TJYt9uQdD0n5YA3j/vpwSZ8cRpaxfQTjSsjFldBwwXppRRhPOSMie7cPDSk5/PWnXVXdPeDYTnI2SGpETV9pj/8jrmwYWhWgOdHfjEEAwLnWGCyyxMa3YHhb/FywAiZUJ8GGfeyygGhzY+cP7KjG8SETbMBvTpf2MFAQ298PjU9v9D0PI6OFcIMdZ+lGba4mDtSVqpKFgUxUaC2y9Knec6UQdEWjsDJ5TU+hZJAMhWysDA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by OSNPR02MB8964.apcprd02.prod.outlook.com (2603:1096:604:45e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 05:28:52 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.012; Thu, 12 Nov 2026
 05:28:52 +0000
From: Bin Meng <bin.meng@processmission.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, QEMU <qemu-devel@nongnu.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: [PATCH v4 2/2] qemu: arm: sbsa: Rename sbsa defconfig to arm64
Date: Thu, 12 Nov 2026 13:28:33 +0800
Message-ID: <20261112052835.1883576-2-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112052835.1883576-1-bin.meng@processmission.com>
References: <20261112052835.1883576-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0362.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::16) To TYZPR02MB7121.apcprd02.prod.outlook.com
 (2603:1096:405:2c::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR02MB7121:EE_|OSNPR02MB8964:EE_
X-MS-Office365-Filtering-Correlation-Id: f5bafe9f-8e5f-4dae-ed21-08df407dd646
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|18002099003|22082099003|261009223027099003|3023799007|13003099007|56012099006|261022115727099003|261028144727099003|261102123227099003|261102130727099003|261021121427099003|261022105027099003|261026140227099003|261026121527099003|261022075727099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info: Gv0bBJprTxHIlJqWQPs9hdbbWA4HJDC93UEcFZoog9XhgSP9CmNcNGcXhN+HuYLdCbwoF+hGok5qJ8VfSaUVbW/YV+lWpDudODCM4htbg0+08UfqtkHuNWwuQwitZr2JREjn3Wp6lfW0YNp/zRaahQg+ADoQ9Bapms136f9CJ8HKyeuShUBtLn22gGX8pwp6IRUE2QRpokmwvTrvYiOQpKxToLzlE7YvW8EnBAC5epI6Gwq5rAhIegeBz8FQSwJ7ACrmRV91uPWbRvaoWDSX32itI1nKK0W0Y7KxeIeufPIPWuLKXbDhvj+jOlsWgGbtx8N/HZcxluhQrLRuYmK3isTacGD2UyMAqiiEj8vcYT2xy5HtBh9obUa60HgLDQ0CtF35HzykMEVFj3HCzJqIVUBQuBA6yQWTEXvs/E1lOHgK8RIz7+kom5CC+dum4Oa31gNzKLKlS+33Tb9gYYf1F5GlzYIix0gQsHJ1F+qRQPyUKseF/eh1Wv0yBsT/1BCDitnuSCpxcXn8ZhO0cS63iGdtqHGrCJo0as+grB21EzG7H/hninuLEJrG8X0GI+XQ4A/sgwSp17YTD8U5gZ7Hueh4AE9tG64NdiqIWYLgHoA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(18002099003)(22082099003)(261009223027099003)(3023799007)(13003099007)(56012099006)(261022115727099003)(261028144727099003)(261102123227099003)(261102130727099003)(261021121427099003)(261022105027099003)(261026140227099003)(261026121527099003)(261022075727099003)(261021123027099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tz+1r2pMEhrVTVLaLxi2p4dYKJhK1+ObZBhxBHLrWFjFWR4RWwjPkhBXuJ+f?=
 =?us-ascii?Q?yDSNQH1SmiVX3ZkFpOPucuBkvxI9iIiVPE0wQejV3LaTUBSUtV+6Hn2R6H5s?=
 =?us-ascii?Q?SDZfIIxTFmI5LabC+DBnYe/siI2vdFvZ1bRY6qgt/k5MyjywKmyeUBM4LNCi?=
 =?us-ascii?Q?HeG0zbITlHyoPO5xL1jLLA0kIJBx/ypzAYeESsToWnISA2UHfUwP34n90nwV?=
 =?us-ascii?Q?nntJef5lgYEL0S8wkqXto+Lz4QaLxaoWFiQ3mhpx/oSTuIyn9MeLdbnd63Ma?=
 =?us-ascii?Q?RkabI7fD0sKbnfTebSX8gBrSZ3dc2FanWRLX8XNO/ed7b97kBzeQuUOk1+C/?=
 =?us-ascii?Q?0bPUTPczFHqh6LT6kTQXgwGqPn4WSP9ki69To30pzFG/zpmXyu2Yf2zcq9TB?=
 =?us-ascii?Q?RGpO5DxcNW05Pk4L5KgKWEunuHQrjax2roODlmAdUinFSCWAtATjAQzLc05v?=
 =?us-ascii?Q?80E+T/Q4Wke8mCm2Gh0FrQfw25Y8OI15Tl18AeVJ45sTT+LL4LMGLcFjOe9k?=
 =?us-ascii?Q?/gB2T+tlHex1y4NomR6hhgGLBBzJz8JVm8Ropox5frIpclr1BIF39zCk7LqD?=
 =?us-ascii?Q?hne7nyOD46ph1vCr82viM0LG5P6yPRaGsDYGZle9TXEInIvwjQnpN2vVycRs?=
 =?us-ascii?Q?TlXchneYTW10N2lmxYLu4qpSdks4raQadB4P4i4sJRJZF3E9cwBvKlCvlzKs?=
 =?us-ascii?Q?DdmEqpeYfmecKk65lE8ppLbE7LYWYQadrVUFogtXNnExyKCzZgiJ/tQPkZ+O?=
 =?us-ascii?Q?7/4BAEn0crkGl7PVxE1HpiQaj4Qgu4ZbXV2U2QozVny/i1QhrHH3oBQtlaNF?=
 =?us-ascii?Q?d5mCYCO5r4k8SBzvbykO+VRKW1xo4me9Sn6yoD/T3dIJzYuZfT99JG8TJfgr?=
 =?us-ascii?Q?6zNDqLMTPXgS/8moR/4WZelBrAD8Iru5xuVUEBvvp/jWYCwvKmjlfrLel+R+?=
 =?us-ascii?Q?Sia7z+GuzZ3B6RO6GRzVrLw3zr31XW1JJE+ug6jsjzc1skKaAco1hk9+TiLs?=
 =?us-ascii?Q?9VvyqT682z8DgB66+AJ9jaDfbFgQzmiUrKAARaoKsPtOD/t8CUNlTJ8ERRWr?=
 =?us-ascii?Q?c1ZwlQN6xSYuSMl+7txY9xfZAstvAPUkYm0+MCG3OIk7I8mw63WxRyMPevhZ?=
 =?us-ascii?Q?cNJsZ4wh2LIzNdpI1AsA6n12w0th1QFAqyzWGmQg2/dFFhP5cBRiimoZDAWi?=
 =?us-ascii?Q?ZbQ3F4NsXnd7fX5vzFjqqlsBTsDuWAqStRxfAnfhFAs5wJ32Du4kpuYczbi2?=
 =?us-ascii?Q?7or+JSXajOmlhCJMXJ/0dDdXaFGg3IXcJQV7Jusspke/L16+qICdMXAA7LH3?=
 =?us-ascii?Q?0/sLeOqdcl7firSa9FNfNPCk5zO9PH1NcbYKHDm4W3ks73p8IBo6VHO/ioef?=
 =?us-ascii?Q?0f+zWZ4nFvcDcuz4S8X3Kg1eouXxwstnxOwtgqIG/PYYj1p31KZVf1MFbACl?=
 =?us-ascii?Q?E6YHaZ+9tOs3XTzdIVMrZPCdp2BlddtB84MnMj7/HXAWtcuPjEUPGQfaAria?=
 =?us-ascii?Q?iNaZFSWMibGcRQWcUy/w1YWtg0hTc52D/BPj+eT1UpzN/kZa6UVAub4vM5ae?=
 =?us-ascii?Q?qIQ8gArBQIEtMA6s/sxQq893upmbxcauCycI1qJHmswlf2iWycBjFb78BAMv?=
 =?us-ascii?Q?K2wQNQ3KbuibModDEbFQWDM16bLUHE1xZxk++ThoetzEDIc6TK/joM8jpJip?=
 =?us-ascii?Q?uH7g8vli2bwd3RDI/1/JNykjCr4XFAuTkO7H8ETPydDfxtw70W7d5VfQR+Tu?=
 =?us-ascii?Q?aBfZK4v+JPddlNOLGxrCEYMV1IwyFo4=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5bafe9f-8e5f-4dae-ed21-08df407dd646
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 05:28:52.1093 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CUByr23+ohWPKphjV8f0n7qPjSruijD9xaJMQV0DmCwtRZQuuie2x5DJVj24ifEEWe4Y1/dIS9FcWqPxbtljNwL5qIzTXMvClFQD4FrpOuA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR02MB8964
Received-SPF: pass client-ip=40.107.75.81;
 envelope-from=bin.meng@processmission.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

The QEMU ARM SBSA virtual platform is 64-bit, so rename its defconfig
to include 'arm64' for clarity.

The configs/qemu-arm* MAINTAINERS entry already covers this file, so
drop the redundant SBSA entry.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
CI requires the matching u-boot-test-hooks renames from series 533244:
https://patchwork.ozlabs.org/project/uboot/list/?series=533244

The CI runner image must also be rebuilt from this series so that TF-A
is available in /opt/tf-a/qemu-arm64_fw_handoff_tfa_optee.

Changes in v4:
- Drop the redundant SBSA defconfig entry from MAINTAINERS

Changes in v3:
- Rebase on current mainline
- Update the SBSA build instructions

Changes in v2:
- Add missing Azure and GitLab CI changes

 .azure-pipelines.yml                                        | 6 +++---
 .gitlab-ci.yml                                              | 6 +++---
 board/emulation/qemu-arm/MAINTAINERS                        | 1 -
 .../{qemu-arm-sbsa_defconfig => qemu-arm64-sbsa_defconfig}  | 0
 doc/board/emulation/qemu-sbsa.rst                           | 2 +-
 doc/develop/driver-model/virtio.rst                         | 2 +-
 6 files changed, 8 insertions(+), 9 deletions(-)
 rename configs/{qemu-arm-sbsa_defconfig => qemu-arm64-sbsa_defconfig} (100%)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index ccd30efa2d9..ebab729776d 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -267,7 +267,7 @@ stages:
               wget -O - https://github.com/riscv-software-src/opensbi/releases/download/v1.3.1/opensbi-1.3.1-rv-bin.tar.xz | tar -C /tmp -xJ;
               export OPENSBI=/tmp/opensbi-1.3.1-rv-bin/share/opensbi/lp64/generic/firmware/fw_dynamic.bin;
           fi
-          if [[ "\${TEST_PY_BD}" == "qemu-arm-sbsa" ]]; then
+          if [[ "\${TEST_PY_BD}" == "qemu-arm64-sbsa" ]]; then
               wget -O /tmp/bl1.bin https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/latest/tf-a/bl1.bin;
               wget -O /tmp/fip.bin https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/latest/tf-a/fip.bin;
               export BINMAN_INDIRS=/tmp
@@ -488,8 +488,8 @@ stages:
           TEST_PY_BD: "qemu-arm64"
           TEST_PY_ID: "--id fw_handoff_tfa_optee"
           TEST_PY_TEST_SPEC: "test_fw_handoff"
-        qemu-arm_sbsa_ref:
-          TEST_PY_BD: "qemu-arm-sbsa"
+        qemu-arm64-sbsa_ref:
+          TEST_PY_BD: "qemu-arm64-sbsa"
           TEST_PY_TEST_SPEC: "not sleep"
         qemu_m68k:
           TEST_PY_BD: "M5208EVBE"
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 905523e3e27..683f92fc9f5 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -51,7 +51,7 @@ stages:
         wget -O - https://github.com/riscv-software-src/opensbi/releases/download/v1.3.1/opensbi-1.3.1-rv-bin.tar.xz | tar -C /tmp -xJ;
         export OPENSBI=/tmp/opensbi-1.3.1-rv-bin/share/opensbi/lp64/generic/firmware/fw_dynamic.bin;
       fi
-    - if [[ "${TEST_PY_BD}" == "qemu-arm-sbsa" ]]; then
+    - if [[ "${TEST_PY_BD}" == "qemu-arm64-sbsa" ]]; then
         wget -O /tmp/bl1.bin https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/latest/tf-a/bl1.bin;
         wget -O /tmp/fip.bin https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/latest/tf-a/fip.bin;
         export BINMAN_INDIRS=/tmp;
@@ -412,9 +412,9 @@ qemu-arm64_tfa_fw_handoff test.py:
     TEST_PY_TEST_SPEC: "test_fw_handoff"
   <<: *buildman_and_testpy_dfn
 
-qemu-arm_sbsa test.py:
+qemu-arm64-sbsa test.py:
   variables:
-    TEST_PY_BD: "qemu-arm-sbsa"
+    TEST_PY_BD: "qemu-arm64-sbsa"
     TEST_PY_TEST_SPEC: "not sleep"
   <<: *buildman_and_testpy_dfn
 
diff --git a/board/emulation/qemu-arm/MAINTAINERS b/board/emulation/qemu-arm/MAINTAINERS
index b2b1fce75cf..5b585bab6a2 100644
--- a/board/emulation/qemu-arm/MAINTAINERS
+++ b/board/emulation/qemu-arm/MAINTAINERS
@@ -6,4 +6,3 @@ F:	board/emulation/common/
 F:	include/configs/qemu-arm.h
 F:	include/configs/qemu-sbsa.h
 F:	configs/qemu-arm*
-F:	configs/qemu-arm-sbsa_defconfig
diff --git a/configs/qemu-arm-sbsa_defconfig b/configs/qemu-arm64-sbsa_defconfig
similarity index 100%
rename from configs/qemu-arm-sbsa_defconfig
rename to configs/qemu-arm64-sbsa_defconfig
diff --git a/doc/board/emulation/qemu-sbsa.rst b/doc/board/emulation/qemu-sbsa.rst
index fe1dc3249e4..ab98dcfb1b0 100644
--- a/doc/board/emulation/qemu-sbsa.rst
+++ b/doc/board/emulation/qemu-sbsa.rst
@@ -50,7 +50,7 @@ Set the CROSS_COMPILE environment variable as usual, and run:
 
 .. code-block:: bash
 
-    make qemu-arm-sbsa_defconfig
+    make qemu-arm64-sbsa_defconfig
     make
 
 Running U-Boot
diff --git a/doc/develop/driver-model/virtio.rst b/doc/develop/driver-model/virtio.rst
index 90a12fb3003..22544f0ecc1 100644
--- a/doc/develop/driver-model/virtio.rst
+++ b/doc/develop/driver-model/virtio.rst
@@ -34,7 +34,7 @@ The following QEMU targets are supported.
 
   - qemu-arm_defconfig
   - qemu-arm64_defconfig
-  - qemu-arm-sbsa_defconfig
+  - qemu-arm64-sbsa_defconfig
   - qemu-riscv32_defconfig
   - qemu-riscv64_defconfig
   - qemu-x86_defconfig
---
base-commit: 3cb2cbbc75aa7fe2391f662607d6b2f46c1292a7
branch: qemu-arm

-- 
2.53.0


