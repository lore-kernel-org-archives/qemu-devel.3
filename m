Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE21606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 05:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=q2ZS2TUH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLwVJ-0000U8-3G; Wed, 28 Oct 2026 01:47:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xLwVH-0000Ts-Pa
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 01:47:15 -0400
Received: from mail-japanwestazon11022142.outbound.protection.outlook.com
 ([40.107.75.142] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xLwVF-0008AB-JJ
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 01:47:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jLHRX2leewTMhXRz1UMZmLptyuybKpB5YKwoNvk3HU9CDUcMlUqLry/k3f7lYmZ7YXf+yhFtP0H8NQBHxLCtfOCTSdkTQDRlhhSqkOGyhqLsvfPg5hjWsek8nlOkWfE5YAYzcLnrgHGEknRpUjijSQgonczHiW56k/W7BeDJ6uY4AOSat00koglF+54OCQwdTZ1aazVl/BVkW8YikNHh6w4NgcJPOesU20TuMoukGpwSZ1uNpc1dcvpAG2HgLIOncLbIvPQNtHxpEB6r6yOHzmaVF3u5gnkmmOYWKN7mdsOSB1HoGITu3ewLhcj021ggpraRAIC0qRgDe8NPlKqs7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+2RwOL+HRZ0hMpcloOnnnJAKN2kxcJMULPMuvdUuCto=;
 b=Z/RofeOrdNhaVmle/0FbZ3oAPxyoIrpsFehA2/I64GLvPGFYMcyTouqSkXTUQoXti/IXcUT33G1jf5LKNg1ePpaI9e03ndF0eYteUjiOY8rIRdWAwMTjgJz403UO3kI9i5pvsV3nZH18Dhf4y0WcnhBSTygpSjVPmFlaFjbHiZEyioG+rV5BkpUXhT2jiX8jiu/gAvBKtWfu2VcqtxA51lLylAnDUze+Gsvaq1zc8sTGRL4q5p4shqpBGQBjcIb6wouGH+oIeFzFzOHZbLq6MedoYJRbVsMeYeOiGEhimLSmIQ+2vpomLJCeDPrYevO2Ik9+6fNdBtqAEHgY5l8+2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2RwOL+HRZ0hMpcloOnnnJAKN2kxcJMULPMuvdUuCto=;
 b=q2ZS2TUHmW0oq0+/9Ebmk5uV0CePzEjmL0oWK38+0KRCljageWn1Bkw/LaAFBZXaOX3rexnkocnBJRdiBqg/b0U4rEKstf54+4CsGVVrFnOemWOpkm1fHe8wZs8HE2iA1Szl9DQrwBY8E81n5OmZ0Be7xk7Wi2sL/mH1hDzy40/BwcoLFfemjCt+cKdB1jnTorlUUl6yMdbdEwrqq5dSEKAwwIgW+yZvbMCpFgmsXkPTi2coMORDU7hEriff++R5Wyg3tcy4jlZVbEHQEy2+liY4+WoQj6jtMX0dquceizandNYvdVyKakCEEE6Q651xCO4LyQpNHGgqiIJDzfzhNQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by TYZPR02MB7950.apcprd02.prod.outlook.com (2603:1096:405:b4::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 05:42:04 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 05:42:02 +0000
From: Bin Meng <bin.meng@processmission.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 QEMU <qemu-devel@nongnu.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: [PATCH v3 2/2] qemu: arm: sbsa: Rename sbsa defconfig to arm64
Date: Wed, 28 Oct 2026 13:41:39 +0800
Message-ID: <20261028054141.2933271-2-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028054141.2933271-1-bin.meng@processmission.com>
References: <20261028054141.2933271-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0136.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::6) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|TYZPR02MB7950:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cc7732a-58e0-4fc0-5477-08df34b63167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|56012099006|261022075727099003|261009223027099003|261022105027099003|261022115727099003|261026140227099003|261026121527099003|261021121427099003|10067099003|261021123027099003|22082099003|18002099003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info: GiX3YXbx1VHHWHr7soZlhCiiiyP/jsbNx4ZaWbR3t4sajm8PSON7Lpxw1QPaAbHNgmLlcWz8OjbIUTquXWDw230/6EXljHQYhVW5hNZZ4b1NXqhpAXv25CkwgAIofNAYcIQQUxrFlXTwgneY0rYZE8wGKl8hBva9ulfe6rpqBhz5z9zq4hf5c8iGZbYYcvvs/vBY54w6Kv01OO2mlkokiqkwLJSV5nj0ibL7lJ+ErRhXujSWMji0mV5qIvDoGm3FWvbcYhGnAXz6rCt9BKSZq0X7iindFTbwfZW3MJKs9ccWvoDkeZyIGIydn1C7f6RdBgKCyxfPsrPf5mT/nU9uF35OuU3QIXYJ6Qmux03ninyShcGOUfaAL1jnHzLmvnTon6jxusYHgVL1kGkarjoalakw0/u2T3lj72YC0HJywtf4tjdE9MvPmL3xxQP3CdwkZjBElwhvk58K9AsjdjeppASmDWKI2+ROB/fzEPWJYmKA4NDgAGbSrw3eEKXyZWQ8+lw7xW8wJPKY+zO4Q0n1GVGU5CehIlc9wcQpESRR/kfz2es4suMj5JEyDJo/VNq1nMSxX2ktMdHEUZsm0g1PmIOa+IU1ZKMzAqoKXGB9D5w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(56012099006)(261022075727099003)(261009223027099003)(261022105027099003)(261022115727099003)(261026140227099003)(261026121527099003)(261021121427099003)(10067099003)(261021123027099003)(22082099003)(18002099003)(13003099007)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EokDJajVRZt0vQEbR6LGcgr+il7bX7Fdi/hGKxZDVcI6yqq0h9X5KOBkrfVb?=
 =?us-ascii?Q?Ba1uS5YFw2pk8DxYp54PsQYVkYRmtKxxQCh2vcKFewLL6ElZQ8eoJdsd2PlF?=
 =?us-ascii?Q?tAu0H/pS4+uEuldapC8xtHK7W1nmPSJaxHiR8xGJLugum/MrUjH4BgyZXyFP?=
 =?us-ascii?Q?BEQOvRzVhZoD2xZoJ5OaJp7T5YXfoDYdxquNvePrudcCZipEbrMowLQHqO5Q?=
 =?us-ascii?Q?HuT4Iobb/2HD2BTGRLs+Zz6GBm69Rvhs6M25p222YyHPB3e2e902btzLtXwv?=
 =?us-ascii?Q?yT1lQM8GD9wvnwPbMkCIZoQE+t7CI0eAT0JwDZLtdD20UUe1ioZT96UF+qzh?=
 =?us-ascii?Q?pmqm01E7sE3b54qFqcafKfAb1wc2zVveXsOZgXg28JuGB4zx6MzGczojitSG?=
 =?us-ascii?Q?JB0DPExVzYChzuxfXqQH4fFcLsPSN4Pqd52oTxM+tD+NvEc0LjDkN8dB2lJ0?=
 =?us-ascii?Q?PYLdfZsyuDov3iYikqvWrN349ZXvbOdeEVkoqNkZ1OH6DuyyE7ZPZadfVjQ9?=
 =?us-ascii?Q?2TkgZZYQpuztevpyVrZAyIp0yTnMm8nG4pq1y0Falib1+GARXS/nvhYTheXx?=
 =?us-ascii?Q?bDEhGYTF3pFeXFLlgL1ElPFqEBHnqSpic6ecOQ0/nV0KSNlO9r1YPuz79RIv?=
 =?us-ascii?Q?BElX9o2nOF1+gFVLOutBDXV+f16Otfp7KYtcNGJiI91cmkpr1kGLx+gx1rYk?=
 =?us-ascii?Q?IN+ayZzgrbSnA1a24eNpRGx35tN92c5SXnFL+vNkqJvMLoF/gBx54tnhAadm?=
 =?us-ascii?Q?xmzNFNuF/Hwa3cjyAlyibiO4IalMrK0ceoNV/1BZ5Ok2Spc2lmMLbEPPmEAw?=
 =?us-ascii?Q?GnOYWgVMPmgO5AQs1Ai0gRxgBJa1tqVgDS0EbIinNuiqN2mL8J8TZoSRVIZ+?=
 =?us-ascii?Q?ND5wmiqxtQIpo4//Ou4SB8kNtMg4Gmw5iMxDkk6UwmlnGRSeM5f7Z2M2d2UZ?=
 =?us-ascii?Q?5n1kt5lKWkkyChTlJrfCdaAvKLaPE6qWWCQ6WP/V/+pbDd15WMku95dxJH2t?=
 =?us-ascii?Q?HGUlJqubB1K/qOOIzIwReO7iKN0/bVZJ3Va9RMcgmpmx/0xAOOZhWIUDqslH?=
 =?us-ascii?Q?pR0CjCuxoI/KqWbt++MyQt9oC4kci6yl1txCS3xuf3aF9WR3KPkiE4BzI1Bj?=
 =?us-ascii?Q?59JxwSt3jezSAT9J58JwLLzhJkqbbedtti0mNuOUjARsihS7X9kx1/jjX1Pz?=
 =?us-ascii?Q?uivSly14kwbIAzO5yvB8Ldz2VdBNAPeFdVeETn2O9n8bn19yQs2JFZa+Z8MG?=
 =?us-ascii?Q?oY4w2UJ1kkw7be68fZ94pdGZmkjOBQWeY9NDR2Gx0/xZidWWN81LJuYGfltV?=
 =?us-ascii?Q?BhNwo/e52wphbK3F+yHVbuRNLh/dQZ4qxpSKWhsFGWPWjkgdOkMZSMGzVhpW?=
 =?us-ascii?Q?8u3W6SPzc6ml23amsofN3oqozaa9XML0unHS50MAvPEnwPSs/oXqZt2VJIdv?=
 =?us-ascii?Q?nYtdVgypx5XGfi8K0GFCaC7e6kWPX+1ccHhHlLIXiP6C9PqEHOv2ERQyOaVr?=
 =?us-ascii?Q?sjG0cGMd69dqBt5vp35j9q0v61cr+4UFoDrvVDb0NIXF7n9CjoKwwnCj5D4r?=
 =?us-ascii?Q?woC7awlryfL8fuFg4A0YPOEa0irceP2OlLug1e9XlsBLWspy0LotsgG3+Jjw?=
 =?us-ascii?Q?rxYPYNyKgY+VZLVfg35jh24S83dv6fAdgl3KuVHajkHWNynAIBxpIY6Utoc4?=
 =?us-ascii?Q?XG/nSwmdprpInXMQTsG9UIzR1/lFaOwdczWjBa8PmKh/1m8JoUvUyI2JQ2k+?=
 =?us-ascii?Q?tiHS7pcaE8LEFgYPR0YOrsdyF4iONDU=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cc7732a-58e0-4fc0-5477-08df34b63167
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 05:42:02.9017 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D10HUnyFjX1l+9gFD35Kdr7YnRT47pjBAE46Fn5Vcq/8JtvCHPL7BcpehtYtKavHwe2xQQymUkgbwSnz0RSKq6B1UQBbG5rbP9Vt4x/Ihv0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB7950
Received-SPF: pass client-ip=40.107.75.142;
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

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Bin Meng <bin.meng@processmission.com>
---
CI requires the matching u-boot-test-hooks renames from series 530221:
https://patchwork.ozlabs.org/project/uboot/list/?series=530221

The CI runner image must also be rebuilt from this series so that TF-A
is available in /opt/tf-a/qemu-arm64_fw_handoff_tfa_optee.

Changes in v3:
- Rebase on current mainline
- Update the SBSA build instructions

Changes in v2:
- Add missing Azure and GitLab CI changes

 .azure-pipelines.yml                                        | 6 +++---
 .gitlab-ci.yml                                              | 6 +++---
 board/emulation/qemu-arm/MAINTAINERS                        | 2 +-
 .../{qemu-arm-sbsa_defconfig => qemu-arm64-sbsa_defconfig}  | 0
 doc/board/emulation/qemu-sbsa.rst                           | 2 +-
 doc/develop/driver-model/virtio.rst                         | 2 +-
 6 files changed, 9 insertions(+), 9 deletions(-)
 rename configs/{qemu-arm-sbsa_defconfig => qemu-arm64-sbsa_defconfig} (100%)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 071fcae104f..9a8743e9ae7 100644
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
index b2b1fce75cf..fea9e97f868 100644
--- a/board/emulation/qemu-arm/MAINTAINERS
+++ b/board/emulation/qemu-arm/MAINTAINERS
@@ -6,4 +6,4 @@ F:	board/emulation/common/
 F:	include/configs/qemu-arm.h
 F:	include/configs/qemu-sbsa.h
 F:	configs/qemu-arm*
-F:	configs/qemu-arm-sbsa_defconfig
+F:	configs/qemu-arm64-sbsa_defconfig
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
base-commit: c267fa81d42b5a5bd1055d3858f74496faa6082f
branch: qemu-arm

-- 
2.53.0


