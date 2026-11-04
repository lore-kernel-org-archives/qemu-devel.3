Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638AD606D828
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 15:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=GcbOO03O
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOd9Z-0002Si-Kp; Wed, 04 Nov 2026 10:43:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOd9J-0002DG-3K; Wed, 04 Nov 2026 10:43:42 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOd9G-0001Gk-JZ; Wed, 04 Nov 2026 10:43:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iOtFIUunt/NxUGn5LQ/DxjAatsBPBUUPBXJ07svmffwhiylWFcbpJVncNNPZ5wK7sxM+n4ERKVJoTKTh54OKWUCRjVhNUHcfViOXNSYvhg3DDv6lZDG0dt/iPhAoNP0sKhod3dKxO9ljRvEwW+fPNsP1pWPgLP72cG2aPjlskskph3+VAy6IXpQMCN3K9nd1XHc+7HiZFe6dVfRibodr3OEjMIplcXXz/YnJgid7HI8/EvIkeoKZcCmX8Srva+J2LMA3M8Kt7uI0OR8sHXQHUeVGJGGxQBuhlvidV70RZS3rzi9lrpLbKAsOGPZe0b398QfDVequ7k3F+dS8HPnwdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RPxVDcLBU77YDXTZ3oHHEkjo6TzABPUNMdrX6ttBQhc=;
 b=cpq/ZQud/E1YkLPsT2iDvxoS45DGn1SDjnHLzgX09JgKls6OG8ff2w80WxNFDReimfll01hwr86M+uA/BcsfoizzIPlPBJ1RsOGA6iLpAPmInxvNQPp8Z5QX4qvSVu+TcAdK+lu8Gd2/yaWb9FlInVR8QxYTppMViMNw98ZpNNUhVUamTuRNccGQDcjhr/KzlNKGJhG5mM7xz/HBu+pRD2ft8cHJ2fZ56f8nMvKuqaMzl0hbRFZnQUgVkAyeYHUDUp/n63U+HJFf/5ddP4QHgng7AGE10uF2+8Dd0scSUCeDxZC+5+hE2BznJJYjn3178PiHBhnMJIu0nadONPjGLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPxVDcLBU77YDXTZ3oHHEkjo6TzABPUNMdrX6ttBQhc=;
 b=GcbOO03O5XiYon7+Ar1CTjYekFsr89xUKQkIe5JMr74PQrldkl+pbcg/YcEH4AjWoCiLNWQW+n80wlKdJnhB4ObDzOESfhxxqnfIidEl2kgynUFbY89/Tzamd5QItJOa6nRSDRQFIyiu5ewe2DXEB5OM3FjYogs7MiVhln631UdBkLkwEQn+c9UZ96LPtjmPWatSCAxg9txEpabDdK2WMO4i8e2UEBcmrQlE7fSBOSwBxy8B6OAza+WTwLxvEBEc09pQ6V8kUGUi9NIb3GsvyBUUS2LouotlP6CgMLLsO6HqW1W8M8M8bk2MYyhMUiMJUZqxiS2vV/namPqYm/BQFw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by SEZPR02MB7162.apcprd02.prod.outlook.com (2603:1096:101:190::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 15:43:07 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 15:43:07 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor@kernel.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>, qemu-riscv@nongnu.org
Subject: [PATCH v5 22/26] docs/system/riscv: Document Icicle Kit HSS boot
Date: Wed,  4 Nov 2026 23:41:49 +0800
Message-ID: <20261104154207.641511-23-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104154207.641511-1-bin.meng@processmission.com>
References: <20261104154207.641511-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0056.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36b::16) To TYZPR02MB7121.apcprd02.prod.outlook.com
 (2603:1096:405:2c::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR02MB7121:EE_|SEZPR02MB7162:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c8cd7eb-aeb6-4263-da4b-08df3a8a523c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|5023799004|56012099006|261022105027099003|261021121427099003|261009223027099003|261021130227099003|261021123027099003|261022075727099003|261021135927099003|261022115727099003|261102123227099003|261026130827099003|261021133027099003|261022113327099003|261026121527099003|261026140227099003|261026135527099003|261028144727099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: RFKPJqxjpP6PxOVaykHw3/8uD5NpLIcN9AxjYeHGtlGhPPQv8ge96MkgKCG6xQAV6wLDy15RHUkHCMSyV80IJJDapkbY7FJ7fl5W8viL7KYPAgj/WBI0Opx8se4Arso35ynH32sDWE50exlUgbjGUK1Comnnlu//0EQqKu0eFs+HYmN2VoIRoA79CeOPv7Btvd41CSTNiVGLMoJy+5je+tOdC7CGPpIiBnpwcvW4+GftVyeEp0xiA64uURPwjOAag3K/ZlkvKO9EcAJXu0kh0YcCjvWlffNP7aYRTiq0TWDM9ddc/Gp+WJRWey/DWNANBGWqsdxnVGc8/TOHMhOdhIQHT6VuLkqq4O804RXhyRk1B80Ene+renb7GlsE1/v3g2FibYM/509B4f4l/qkdulxF+hilpTbVHc3u62gdVLb5NC/eLUDglLDSa7vGL3fSUHGPIFyNT2JFJGsy8tCfo/6UN2fRTy7EjsudeMkYSIv9c+Z1B1HxsS0jika+73TAJGFTMyFbbFjijWTyO3Jdgvm4U3ZdR1qHtZK6GZUxX/XozSVEoihERMJrBWWhUzrC3Eo8wtxeiGn3+ggU7w+n/z6z5gPuBlXQ0VHhJsRaoALcHCAfZK8dLRUugy6Ao7J4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(5023799004)(56012099006)(261022105027099003)(261021121427099003)(261009223027099003)(261021130227099003)(261021123027099003)(261022075727099003)(261021135927099003)(261022115727099003)(261102123227099003)(261026130827099003)(261021133027099003)(261022113327099003)(261026121527099003)(261026140227099003)(261026135527099003)(261028144727099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6O62mpIxFaEcIfP9+EmmRZF1XM/zNd4bqfNtv88xoGBzcSdF56pCOtgWUKU3?=
 =?us-ascii?Q?MnzcvdTkEMYxmQ4UFNl3KbK6nMIjG8YBxJYDSY9N/VWSsMQXx4k3jky6LHY1?=
 =?us-ascii?Q?2p7mv0x467Ztc+m4kSU+BUNliYV3oDgYIxclnkbdPFdfM2rnkx+/VtcNAqlI?=
 =?us-ascii?Q?IQTYosxm6nQpCFX6l3oScxWoKNR6DJUEkNe7ejfYSTD9tdZgC4Kkx6ZQ6tRI?=
 =?us-ascii?Q?GPJcWeAsNrP2cEPlX7fxztYxy8pV2qZSqx4z4m4uFKiL6pulnWqRAqmyfZhO?=
 =?us-ascii?Q?TThkb+baeC235WcppLp314V8e05GLdTPh2GG0AsFybk6QXGUZi2PLJgoO5BU?=
 =?us-ascii?Q?XXEL/dx9R+yfCU2333sNSoP1+6bEnd3fCPy2MThRla3Vlclnt84ix0+Z6QgQ?=
 =?us-ascii?Q?8peqYaDBiTqVkMX1ueuVGyM1ypY3gXd8hg8BoDO+drEtam55mR60ZZlvPKSg?=
 =?us-ascii?Q?TZSJD9OUXpMptLEQHZpie3wmmIPiUp7W+hBCX70TjPt3x6x2gHLlU0NSuoj/?=
 =?us-ascii?Q?qMJgtMVTiegJC7+yeuguAdkSuUrwjKlGfP9VscMKNFqEspvZwbPi6agU4y7q?=
 =?us-ascii?Q?7eSFZf/KP/4LGh10XZq3kHcpoYpnPwQ+3CF9cxhfkVjaF86LLYUpw3eENGe3?=
 =?us-ascii?Q?8KkfVdzh0cjv7/FJ9mk9ydA+l6wXpNzlJO9+mOgIalIKxtM6CcCEPqSqBP8x?=
 =?us-ascii?Q?1nlKX+3QPKWtcRuR4fva3dTqDcNjM1lUcyTIiqXN5tXXRPSZ3WKrQTrZruDa?=
 =?us-ascii?Q?2Acyv55zbuirdYMV0zjs/0/X6c0pyxiRqp5rishgtWNLkXxQZOUf0oNUyMut?=
 =?us-ascii?Q?eoBaAti9gyX/PswlhcoUK2f3I+KO/cYQyu9ob5jDcChMwX4YXWzoi6kqcgTp?=
 =?us-ascii?Q?cNwtkMCh5ni1KXLrZ0AEI4bDsCx58OeexCV/+b+90cs257Ms5JzdWNkA2Wdk?=
 =?us-ascii?Q?ku9h247QE0aPQbRrvIXU0UgRhYcxighSvmlb7jolFIElMX/KR68+d/QD0tcd?=
 =?us-ascii?Q?zug+7JMR4ZuVDQJLcz45YIN+rgcw8hJDIGDFEGztZw6NbwauzbD6WBfFXAwt?=
 =?us-ascii?Q?hvc41UVE0QYatrVI0ka1RXnf13X9rmRBCtbTlRmZDgit+R/XftZ9hS9ZWRSO?=
 =?us-ascii?Q?Y1rlI7iqWr6Z9zSIkdIQEKh0E3o2KDyl9Clj3S2reJUAwxIMeHOcx2fKaUC0?=
 =?us-ascii?Q?qebdndZgeb9UQkbA+RD7PCFiYycpfV7sgx9sT6gtB1GHj0YxQDoT9fvNcM6c?=
 =?us-ascii?Q?wkQeJbr8VClN1zwfjiI3Ul5XOsTZSvQn65EzaZqPmgOLoZXxeaSBYXly4hOG?=
 =?us-ascii?Q?jLbJM0C5t/CeUY7uvypkgFBWDfry7TSlNWEvRX7gP2VFf7jjxkCoV97i5bpd?=
 =?us-ascii?Q?jPWAyh4M7SiOiBQLSl0Ua6d6WVwoWm2kGH94+VKHL/nbXfiWGVZ/G+3ovQgp?=
 =?us-ascii?Q?eTHmgcPGTYM6uRb3qFTlZWdK/1TYc6mBE5iHRoboGzF+npLDZwyfl+c4OmsK?=
 =?us-ascii?Q?w/HwEwCqw4p42H5OXQb6gZeo6Y8jlkfopJrBKr0LbtsvQ1VW0fmXOcfqIt17?=
 =?us-ascii?Q?VqsDiiMT9S7QecA7tqr8mnw+KA7W8+TQRbXA4wJhMjV2Hc+ZGagUSxKvwCri?=
 =?us-ascii?Q?ufOPLvkC8D/SrpC1fkA8ZMLEoymDeQfJkFele91+p86mEq5BUoPEGCNxiLDz?=
 =?us-ascii?Q?xcfFsX5kgFkBJmP9Qof2XOv9Urk0xFhITMHMvkTnQq4yDcFIuNqPY0Dstakz?=
 =?us-ascii?Q?2zo2rVLsxJJ+3zmeNr9XDjDdT/sw8Qg=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c8cd7eb-aeb6-4263-da4b-08df3a8a523c
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 15:43:07.0494 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lZPFKaUuVO/vEwr6RD+AedMIqysffhEAzwDRE6yw43ewoVIF5obptJUqJUoB+8ofUWI52Gacnzh5O1onDlVZLRA4REH1U6G4ygPiABIAhAc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB7162
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=bin.meng@processmission.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With all previous changes, the Icicle Kit model is now able to boot
HSS v2026.04.1 through a Buildroot 2026.05 SD image to U-Boot and Linux.

Document the tested source versions and exact commands to build HSS
and Buildroot. Include the sparse resize and GPT relocation steps
needed to make the generated SD image usable by QEMU.

Explain the pinned firmware baseline and include the DDR pattern-test
patch used by the versioned test image. Document the tool check needed
for image-only builds and distinguish the DDR training failure from
the two investigated multi-hart startup races. Describe their visible
symptoms, affected source versions, and all three DTB supply paths.

Also describe the RAM and serial setup, boot stages, and remaining
model limitations.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

(no changes since v4)

Changes in v4:
- Use HSS v2026.04.1 and the v1.1.1 test-image recipe
- Select the SoftConsole toolchain explicitly
- Use the generated complete boot-mode-1 eNVM binary

Changes in v3:
- Include the DDR pattern-test patch used by the functional-test image
- Document the image-only FPGA programming tool check
- Describe startup-race symptoms and link the firmware investigations

 docs/system/riscv/microchip-icicle-kit.rst | 129 ++++++++++++++++++++-
 1 file changed, 123 insertions(+), 6 deletions(-)

diff --git a/docs/system/riscv/microchip-icicle-kit.rst b/docs/system/riscv/microchip-icicle-kit.rst
index 138289a913..2159e8e461 100644
--- a/docs/system/riscv/microchip-icicle-kit.rst
+++ b/docs/system/riscv/microchip-icicle-kit.rst
@@ -19,12 +19,14 @@ The ``microchip-icicle-kit`` machine supports the following devices:
 * 4 U54 cores
 * Core Level Interruptor (CLINT)
 * Platform-Level Interrupt Controller (PLIC)
-* L2 Loosely Integrated Memory (L2-LIM)
+* L2 cache controller, including L2-LIM and L2-Zero windows
 * DDR memory controller
+* System controller and system services mailbox
 * 5 MMUARTs
 * 1 DMA controller
 * 2 GEM Ethernet controllers
 * 1 SDHC storage controller
+* 1 Real-Time Clock
 
 The machine has a fixed 2 GiB of RAM. Other memory sizes are rejected.
 The machine defaults to all five harts. ``-smp`` may select two to five harts,
@@ -103,10 +105,125 @@ CAVEATS:
 Running HSS
 -----------
 
-The machine ``microchip-icicle-kit`` used to run the Hart Software Services
-(HSS_), however, the HSS development progressed and the QEMU machine
-implementation lacks behind.  Currently, running the HSS no longer works.
-There is missing support in the clock and memory controller devices.  In
-particular, reading from the SD card does not work.
+The ``microchip-icicle-kit`` machine can boot the Hart Software Services
+(HSS_), which then loads an HSS payload containing U-Boot from an SD card.
+The following flow was tested with HSS v2026.04.1 and Buildroot 2026.05.
+These versions reproduce the firmware and SD card images used by the
+functional test.
+
+Configure HSS for the ``mpfs-icicle-kit-es`` board using its default
+configuration. QEMU provides the software-visible registers and deterministic
+status consumed by the HSS v2026.04.1 DDR initialization and training flow;
+it does not model the electrical properties of DDR training. HSS requires
+the RISC-V bare-metal toolchain supplied by Microchip SoftConsole to be
+available in ``PATH``.
+
+The versioned test image applies the `DDR pattern-test fix`_ before building
+HSS. Without this fix, the DDR state machine can reuse uninitialized
+pattern-test parameters across calls, particularly with the SoftConsole
+GCC 8.3.0 toolchain. Apply the same patch when reproducing the test image:
+
+.. code-block:: bash
+
+  $ git clone https://github.com/polarfire-soc/hart-software-services.git
+  $ cd hart-software-services
+  $ git checkout v2026.04.1
+  $ curl -L -o ddr-pattern-test.patch \
+      https://raw.githubusercontent.com/processmission/qemu-machine-images/v1.1.1/machine/riscv64/microchip-icicle-kit/0001-mpfs_hal-preserve-DDR-pattern-test-parameters.patch
+  $ git apply ddr-pattern-test.patch
+  $ cp boards/mpfs-icicle-kit-es/def_config .config
+  $ echo CONFIG_CC_USE_SOFTCONSOLE=y >> .config
+  $ FPGENPROG=/bin/true make -j$(nproc) BOARD=mpfs-icicle-kit-es
+
+``FPGENPROG=/bin/true`` satisfies the boot-mode programmer's FPGA programming
+tool check when generating an image for QEMU; no physical device is programmed.
+
+The HSS build creates the complete eNVM image, including the 256-byte
+boot header with the image size and per-hart reset vectors. Copy it to
+``build/hss.bin`` for the QEMU command below:
+
+.. code-block:: bash
+
+  $ cp build/bootmode1/hss-envm-wrapper-bm1-p0.bin build/hss.bin
+
+Do not pass ``build/hss-envm-wrapper.bin`` directly to QEMU. That file starts
+at eNVM offset 0x100 and does not contain the boot header with the image size
+and per-hart reset vectors.
+
+Build the SD card image with the tested Buildroot version:
+
+.. code-block:: bash
+
+  $ git clone https://gitlab.com/buildroot.org/buildroot.git
+  $ cd buildroot
+  $ git checkout 2026.05
+  $ make microchip_mpfs_icicle_defconfig
+  $ make
+
+This produces ``output/images/sdcard.img`` with three GPT partitions:
+
+* An HSS ``payload.bin`` containing U-Boot.
+* A FAT partition containing ``boot.scr`` and the kernel FIT image.
+* An ext4 Linux root filesystem.
+
+The QEMU SD card model requires a power-of-two image size. Make a sparse
+4 GiB working copy and relocate its backup GPT to the new end of the image:
+
+.. code-block:: bash
+
+  $ cp --reflink=auto output/images/sdcard.img sdcard.img
+  $ truncate -s 4G sdcard.img
+  $ sgdisk -e sdcard.img
+  $ sgdisk -v sdcard.img
+
+The Icicle Kit firmware device tree in the FIT image describes 2 GiB of RAM,
+matching the machine's fixed RAM size. The command below keeps ``-m 2G``
+explicit.  Attach the image as an SD card and route both board serial ports:
+
+.. code-block:: bash
+
+  $ qemu-system-riscv64 \
+      -M microchip-icicle-kit -smp 5 -m 2G \
+      -bios path/to/hss/build/hss.bin \
+      -drive if=sd,file=path/to/sdcard.img,format=raw \
+      -display none \
+      -serial file:hss.log \
+      -serial stdio \
+      -no-reboot
+
+HSS writes to MMUART0, which the command records in ``hss.log``. U-Boot and
+Linux use MMUART1, which remains connected to the terminal. A successful
+boot proceeds through HSS payload loading, U-Boot, the Linux kernel, and the
+login prompt from the root filesystem on the third partition.
+
+Known limitations
+-----------------
+
+* Two potential multi-hart startup races were reproduced with HSS v2024.06
+  under QEMU. The affected code paths are also present in the inspected
+  HSS v2026.04.1 sources; they have not been reproduced on physical hardware.
+  See `HSS startup races`_ for the investigation and affected source versions.
+
+  * In the eNVM wrapper, a late U54 can clear the decompression completion
+    flag after E51 has set it. A boot can stop before all harts enter HSS,
+    with the affected U54s waiting in ``wait_for_decompress_done``.
+  * After DDR training and payload loading, a U54 other than the configured
+    payload owner can win the OpenSBI coldboot lottery. With the minimal DTB
+    describing only ``cpu@1``, U-Boot on another hart can repeatedly print
+    ``Could not initialize timer (err -19)`` and ``resetting ...``.
+
+* Without the DDR pattern-test fix above, some GCC 8.3.0 builds remain at
+  60% DDR training progress while QEMU keeps running. This is a separate
+  firmware parameter-lifetime issue; see `DDR pattern-test issue`_.
+* The SD card model requires the raw image size to be a power of two. Keep
+  the backup GPT header at the end when resizing the image.
+* The machine does not generate an Icicle Kit device tree. Firmware boot can
+  obtain a DTB built into HSS, included in an HSS payload, or supplied by
+  subsequent software, such as U-Boot or a kernel FIT image. The DTB must
+  describe the selected hart topology and the modeled reference-design DDR
+  windows. Direct kernel boot must use ``-dtb`` as described above.
 
 .. _HSS: https://github.com/polarfire-soc/hart-software-services
+.. _DDR pattern-test fix: https://github.com/processmission/qemu-machine-images/blob/v1.1.1/machine/riscv64/microchip-icicle-kit/0001-mpfs_hal-preserve-DDR-pattern-test-parameters.patch
+.. _DDR pattern-test issue: https://github.com/polarfire-soc/platform/issues/36
+.. _HSS startup races: https://github.com/polarfire-soc/hart-software-services/issues/106
-- 
2.53.0


