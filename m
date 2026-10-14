Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1472CC6B1D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 01:29:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGnjI-0005ZB-NM; Tue, 13 Oct 2026 21:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGnjG-0005Yp-PK; Tue, 13 Oct 2026 21:24:26 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGnjE-0006ql-DZ; Tue, 13 Oct 2026 21:24:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m/rSe5CSvBmjcpvFsYgjK+mvoAmDXWsSAh1m2MJMoEQ1VI0/ElOhdK9jI0p5jIV7LYi5Z77hpNEpJ8rmPg5egYdPfzNJpv477ViUE379oQm7mVQFuUjTQRJvdyoixuhU93CrpUiZ7Pz/1rAvVbPd5msmQ6hhF32RkVJUEdccfkdNOMgKkHXvYtIrACipGg6BptiduNeLQFpA6vxa0fW8GCOHKqx7QXZQWAdCPNf5JMLl+2P8GwbCt5LfOW6Uy/vhA7J9zDUhFO1QEmOnLf1jxCAx0gsgXzP8wfXPQCsdYhUUBdbutS3wtwm2fGdCO5D9zwpzF4ZNgB6BS0weHoLrcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wA3BA7OutnYyHWGaWmJ/FtcXwKzQ8aDAvG9adRJtIHo=;
 b=cwm12ZHv5T6/Ma3ECIVBcMrZyZvuDQo5ppFiLaXKhHsrmcMi9BPWh19FUVLIH6SJfYAtX5254bZxm/0FJdgcg+8Mrf5QfNQF7W3P/qaspAJBlsgg8oTdn1r2Q3xC1RFOBS/HUWwnOAcFIJZW1al8JCwwq4iFZaFbQ/AeAXaS4ip+OE4dLspKZJu2YEcSYb0iI6kZCIVc6NKBzHUIeVjpAR+zfAVvInmRUlx+admcWJYRBInXQmgaIxY59p0NKvX84DtRCuFsZxGSBkBCJQVP2RNwRq4kS2hEuxQFjKxRPt6ZxFMRe8q3TFfTk41CLE/LzVCcwRqNusPGOJplwQxodA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wA3BA7OutnYyHWGaWmJ/FtcXwKzQ8aDAvG9adRJtIHo=;
 b=wDMMaJBI4XN69CmvGSVhhhYmRGyPxNSl79y+yRFJU/HeHJQ4cwnb+xGYaLD2R08QNN4i2zk7NKbe+REgXJ5nAvY4zP4Eai5A6Umhic8LDOn78KL5IWYEfqhDizxq58lX631ge19QcJxvIbGl1xh+BinMuOccdctGp5G4oKjVBQuHu97IPxKffceT5aC4lINsD8ncGWMMI9zfK0XgzDoEXlP8YVCwsfOYEFy+/mIUvAQF4s4okotvN6NYFp4+AJF5Ann/C4WFFo8SXGw5BzzuaUeoiQC+8nn0Cfn2bHHdUIklVoQrp5T9Gh8tx1Qhn93uIcFdpm7AaO5786v2+Q9cvg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by KL1PR02MB6214.apcprd02.prod.outlook.com (2603:1096:820:9e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 01:24:13 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 01:24:13 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Wadim Mueller <wafgo01@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-block@nongnu.org
Subject: [PATCH v4 10/27] tests/qtest: add Cadence SDHCI ADMA pacing/MMIO
 reproducer
Date: Wed, 14 Oct 2026 09:22:50 +0800
Message-ID: <20261014012323.322790-11-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014012323.322790-1-bin.meng@processmission.com>
References: <20261014012323.322790-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6PR01CA0005.jpnprd01.prod.outlook.com
 (2603:1096:405:3bc::12) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|KL1PR02MB6214:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fabd3cd-1579-41b8-9902-08df2991daee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|6133799003|18002099003|22082099003|260925022911599003|10067099003|260925021311599003|260925021911599003|261009223027099003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: Y4gGamKE8xMdFeChEhwfRx2UAMGX9gS79c3DKL8zmPXbccPmtrezzoH+J6eooL2iEy6m4zCECJDvY6VrkpFhDD0iN4SNEj51lXoBWXAZoylS5nFzxWy3QGQFpEZR4SRIXaJ4GBrT54Sc6RXHlEs5SNGftBl2ejrwnU19cJPoWcoHHyc7YMQ9m9ncwVWGWg/h5Zqqhih+vBnugCB1+d7dFqpvAzszntM8xytmaxZmN6sH1Zb+l2pemlf/BsdEBbXkdyr04w01F0rMGsHCrEzmq9wCO6hCPYO8ijoLopj8r9brNCudbpI+V+e5/zdf0jrOL7j1RrdsZbv2W5LlqS6o2mpwNYkg00XHpriKS2vaodU5Ujf3A55VjJd8j4crDAp0KTj1Gr49PvdBIP31hSZa+H5b7TVgUi0BuqtpYFSdn8JjX/T4KAo0uDGJtaybXtl9+DaR+lBqR8aa5xwWtayyeFNeQcWBu+Legmbc9KlI1fnylmpqP3dSOSa3ZeIn0hZEkcNqfsoMZ+l6q51p1PTM/7Hr46CVK20jbBx3xv5XxSCRmF7ieKi02IE7Pwl2TrEPETKyQ3AdRZMi/5jiw4AH3RhLIS+Ab5QsXhmLvN0X0p7ld8exoWuANoqzp5u/+PjBg5UxTpM494U0L1TfIHlNNUNWT2oSu/3aGt9d3FaiRTw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(18002099003)(22082099003)(260925022911599003)(10067099003)(260925021311599003)(260925021911599003)(261009223027099003)(5023799004)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q7HPzq5z6LKy49nlROLOnHI00cZ3PXbvSC7Et3SsurMiEREFG47Bk61J9j58?=
 =?us-ascii?Q?hT5cAYZAb6qUTT9zhnpLScJ9vE7pNBPNv+jhQ/ky56NFn6Gangb0P38o6BFc?=
 =?us-ascii?Q?9XbpefCPF8k1wUL8m99evUAmVbsdxnGzWJa9L6x9FlRq2LGrc0fwabWyzhre?=
 =?us-ascii?Q?iaZ65yj88RWMJZos92F1vu8FVwzT0yup6lcCXkdtVKYQGDEDJlmQvrq7/z6W?=
 =?us-ascii?Q?TY9E7Nys9NWf8CQiRFlH0Rvk/OBHfj/KMmxONv5FvbPhRU944PKqtaKMmCqs?=
 =?us-ascii?Q?eRDrD0RV/VOVRPURO5WI8Qd6Xu4jZefQ1eJ2A5EBzFhI9cEmYq2e6XPzbqsQ?=
 =?us-ascii?Q?Qj2m/pN2rVym68oHsTKHxBcE+lAluDqMGil0QZAE/ESsoqYKUUIsLI3rUn4V?=
 =?us-ascii?Q?4y/sNekb2QTGpodrGEfYS97frf3nF7L3UGMadcJdRYFz183epVO/ha2O6ar3?=
 =?us-ascii?Q?WDz8bDVGhhLPflW2qHZQKkpzB7qbRU8m35VO1SZFaO4BNURjuvi0aEwNLoUI?=
 =?us-ascii?Q?ViTpvi3Bbx/HRKFo7z3zQJcc7mVRzFvD8in90xBDs52Gbmme6WnnPR1bdqek?=
 =?us-ascii?Q?1gCiwc++QuOgXMdskM5zV5QA5GpFmxYL3988nrUbugQ8EqRLp8JHsNy1aPDF?=
 =?us-ascii?Q?8iD6yJSsaOA0Jj81/etMwQF24w7nzLQ29l51QRh/coo43x5NfndylInT1A/J?=
 =?us-ascii?Q?tSdp0C6VU1pH4Iz3mrDJC2MVFgdP3dZ4/yVB9Fgz594RMmAJDET0fcRxmhMD?=
 =?us-ascii?Q?TV1m5QkJ85Myu7UXE+XTaWA9DL9Az2OSofpC5rhuzDzLRIdclUe4Y+YJYJmb?=
 =?us-ascii?Q?+0TroIb57ZJG89H4gt/ZcS4PbjLRLqa8jdZ7MEOEyakGrjUOf/t0dtbcxPnC?=
 =?us-ascii?Q?qNU/1Funx336Rpt8Gi//+a5qDb1mJHPiB1x08WAkV50VyfJ8iDtkl0aoXOpa?=
 =?us-ascii?Q?/s2tG9h16ZF09RtVG3OLqLNRHDsYVB0yPDeyXkjfPPVoNKVJm+LAVc4x/hi/?=
 =?us-ascii?Q?duOYYidObBEqe5gO8ykgonsUC9soZqaxeCWiFvRItxgkZuJmVuiKFWYvKkZG?=
 =?us-ascii?Q?2aZn/mMxBpLdtQb9QoNjHVaCOyeVvXMcI+7jSAQBgnVxi+MW73Boo4DtPg76?=
 =?us-ascii?Q?5d+HJz14Sk2WNIbu823k0aKEnzoW+VsCphmVLXRfd/uwN3Xa+mHW+AY9Jo43?=
 =?us-ascii?Q?4K12ckomH0ov6a4MaA2934X+b54tEfNvM0xT+67j/uf+399JZ17b6zJ30yrZ?=
 =?us-ascii?Q?26zZGKgc70l7br5k6wv8xAlrPqKpMiSEsn7/U1ST2g+UiyE2rnTi8Vkok/l8?=
 =?us-ascii?Q?oAFkCaLLxg1+Me8zdFCUG2rY8Tuio7JL2/b+dUmR/lA8jxiZxmqlGwUyHDvf?=
 =?us-ascii?Q?XqMTiudncuF9rMnSFijlK3ZCfW08HE1Go816h8B+ArPkuiDpvlH3ofEkbycZ?=
 =?us-ascii?Q?9bWtKmpIXg8l/AMVHi2zuyMjzMjZlGBm85Ry009DCeMtTr2KzhNDqzGK/pNe?=
 =?us-ascii?Q?PYVRwszGlZ3e8yG6KDX8FACui/kxj71WvqmBq2ff4WTw7cQfTVH7+TJhwikQ?=
 =?us-ascii?Q?0FKPXWpB+pQvqVkwFKOMlCfDymTvNH2HqeFgCXjtEmn14gi4xYPNvA96v9fH?=
 =?us-ascii?Q?ed5rVOfrs/QQTktxwqQiQ2c/IzJgC9KTfoAKB7izKuma/7tPPGFWNF3d/jDP?=
 =?us-ascii?Q?2P2Mw8f4BOCKpR7DBMhBQCQt3TNOdToeCey4ZrFm0qYIu5laXlo59ouEGoFT?=
 =?us-ascii?Q?FA+ZfV4YH2VTnFaY4xrAxUCJDKE54Lk=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fabd3cd-1579-41b8-9902-08df2991daee
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 01:24:13.2590 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ndzLQ104E02WyEHPOS30C5e90GAMCW4YLRaByuckKGIjbtgKOXA/2tYt8pWMRtZ/hJhlcxw+FXqY/rJgfo3/n3ACdZnVQCzHkr87JVR1f1s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6214
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

From: Wadim Mueller <wafgo01@gmail.com>

Add an image-free qtest for the microchip-icicle-kit machine that drives
the generic SDHCI model (hw/sd/sdhci.c) through the Cadence wrapper
(hw/sd/cadence_sdhci.c, SRS window at 0x20008200) directly over MMIO
under "-accel qtest", where QEMU_CLOCK_VIRTUAL only advances when the
test steps it.

It reproduces two aspects of the ADMA2 engine objectively, without any
guest firmware:

  1. Pacing: a 12-descriptor (> SDHC_ADMA_DESCS_PER_DELAY) non-interrupt
     ADMA2 CMD18 read completes after a model-dependent number of
     SDHC_TRANSFER_DELAY virtual-clock steps, which the test reports.

  2. MMIO coupling: a chain carrying a DMA-boundary interrupt descriptor
     yields mid-chain and reschedules on the virtual clock. With the
     clock frozen, an interrupt-status read must not itself resume or
     complete the transfer. This asserts the behaviour intended by "Run
     ADMA independently of MMIO": it passes on the fixed model and fails
     on a model that resumes ADMA from an MMIO read.

The SD bring-up (CMD0/CMD8/ACMD41/CMD2/CMD3/CMD7/CMD16) and the ADMA2
descriptor-table layout mirror the pattern already used by the SDHCI
device model; SDHCI register offsets and ADMA attribute bits are
reproduced locally because sdhci-internal.h is not standalone-includable
from a qtest.

Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
[bmeng: strengthen checks, reuse SDHCI helpers, verify data]
Signed-off-by: Bin Meng <bin.meng@processmission.com>


---

(no changes since v2)

Changes in v2:
- Assert bounded ADMA pacing and MMIO-independent progress
- Reuse existing SDHCI definitions and command helpers
- Verify transferred data against a known image pattern
- New

 MAINTAINERS                      |   1 +
 tests/qtest/cadence-sdhci-test.c | 282 +++++++++++++++++++++++++++++++
 tests/qtest/meson.build          |   2 +
 3 files changed, 285 insertions(+)
 create mode 100644 tests/qtest/cadence-sdhci-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index acb79a7d61..65325450e0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2425,6 +2425,7 @@ F: include/hw/sd/sd*
 F: hw/sd/core.c
 F: hw/sd/sd*
 F: hw/sd/ssi-sd.c
+F: tests/qtest/cadence-sdhci-test.c
 F: tests/qtest/fuzz-sdcard-test.c
 F: tests/qtest/sdhci-test.c
 F: tests/qtest/xilinx-zynq-sdhci-test.c
diff --git a/tests/qtest/cadence-sdhci-test.c b/tests/qtest/cadence-sdhci-test.c
new file mode 100644
index 0000000000..71c1e53333
--- /dev/null
+++ b/tests/qtest/cadence-sdhci-test.c
@@ -0,0 +1,282 @@
+/*
+ * QTest for Cadence SDHCI ADMA2 pacing / MMIO coupling on the Microchip
+ * PolarFire SoC Icicle Kit (microchip-icicle-kit).
+ *
+ * Drives the generic SDHCI model (hw/sd/sdhci.c) through the Cadence wrapper
+ * directly over MMIO under "-accel qtest", where QEMU_CLOCK_VIRTUAL only
+ * advances when the test steps it; no guest firmware runs.
+ *
+ * Copyright (c) 2026 Wadim Mueller <wafgo01@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/sd/sdhci.h"
+#include "hw/sd/sdhci-internal.h"
+
+#include "libqtest.h"
+#include "libqos/sdhci-cmd.h"
+
+/*
+ * Use the controller definitions and command helper shared with the existing
+ * SDHCI qtests so this reproducer stays in sync with the device model.
+ */
+
+/* Cadence maps the generic SDHCI (SRS) register window at base + 0x200 */
+#define SDHCI_BASE        (0x20008000ULL + 0x200)
+
+/* Scratch in PolarFire DRAM (base 0x80000000): descriptor table + target */
+#define ADMA_TABLE_ADDR   0x82000000ULL
+#define ADMA_BUF_ADDR     0x82100000ULL
+
+#define BLK_LEN           512
+#define NDESC             12      /* > SDHC_ADMA_DESCS_PER_DELAY (5) */
+#define INT_DESC          5       /* ADMA interrupt descriptor */
+#define TRANSFER_SIZE     (NDESC * BLK_LEN)
+
+/* CMDREG response-type encodings (bits [1:0]) */
+#define RESP_NONE         0x0000
+#define RESP_R2           0x0001  /* 136-bit */
+#define RESP_R48          0x0002  /* 48-bit */
+#define RESP_R1B          0x0003  /* 48-bit with busy */
+
+#define ACMD41_ARG        0x40FF8000u   /* HCS + 3.3-3.6V window */
+#define CMD8_ARG          0x000001AAu   /* VHS 2.7-3.6V + check pattern */
+
+static void fill_pattern(uint8_t *buf, size_t len)
+{
+    for (size_t i = 0; i < len; i++) {
+        buf[i] = (i * 13 + 7) & 0xff;
+    }
+}
+
+static void write_pattern(int fd)
+{
+    g_autofree uint8_t *buf = g_malloc(TRANSFER_SIZE);
+    ssize_t written;
+
+    fill_pattern(buf, TRANSFER_SIZE);
+    written = pwrite(fd, buf, TRANSFER_SIZE, 0);
+    g_assert_cmpint(written, ==, TRANSFER_SIZE);
+}
+
+static void check_adma_data(QTestState *qts)
+{
+    g_autofree uint8_t *actual = g_malloc(TRANSFER_SIZE);
+    g_autofree uint8_t *expected = g_malloc(TRANSFER_SIZE);
+
+    fill_pattern(expected, TRANSFER_SIZE);
+    qtest_memread(qts, ADMA_BUF_ADDR, actual, TRANSFER_SIZE);
+    g_assert_cmpmem(actual, TRANSFER_SIZE, expected, TRANSFER_SIZE);
+}
+
+/* Issue an SD command and wait (bounded) for Command Complete */
+static uint16_t sd_cmd(QTestState *qts, uint8_t cmd, uint32_t arg,
+                       uint16_t flags)
+{
+    uint16_t sts = 0;
+    int i;
+
+    sdhci_cmd_regs(qts, SDHCI_BASE, 0, 0, arg, 0,
+                   ((uint16_t)cmd << 8) | flags);
+
+    for (i = 0; i < 1000; i++) {
+        sts = qtest_readw(qts, SDHCI_BASE + SDHC_NORINTSTS);
+        if (sts & SDHC_NIS_CMDCMP) {
+            break;
+        }
+    }
+    g_assert_cmphex(sts & SDHC_NIS_CMDCMP, ==, SDHC_NIS_CMDCMP);
+
+    qtest_writew(qts, SDHCI_BASE + SDHC_NORINTSTS, 0xffff);  /* w1c */
+    return sts;
+}
+
+/* Bring the SD card from idle to transfer state */
+static void sd_bring_up_card(QTestState *qts)
+{
+    uint32_t rca;
+
+    g_assert_cmphex(qtest_readl(qts, SDHCI_BASE + SDHC_PRNSTS) &
+                    SDHC_CARD_PRESENT, ==, SDHC_CARD_PRESENT);
+
+    qtest_writeb(qts, SDHCI_BASE + SDHC_SWRST, SDHC_RESET_ALL);
+    qtest_writew(qts, SDHCI_BASE + SDHC_CLKCON,
+                 SDHC_CLOCK_INT_EN | SDHC_CLOCK_SDCLK_EN);
+    qtest_writew(qts, SDHCI_BASE + SDHC_NORINTSTSEN, 0xffff);
+    qtest_writew(qts, SDHCI_BASE + SDHC_ERRINTSTSEN, 0xffff);
+    qtest_writew(qts, SDHCI_BASE + SDHC_NORINTSIGEN, 0xffff);
+
+    sd_cmd(qts, 0,  0x00000000, RESP_NONE);  /* GO_IDLE_STATE */
+    sd_cmd(qts, 8,  CMD8_ARG,   RESP_R48);   /* SEND_IF_COND */
+    sd_cmd(qts, 55, 0x00000000, RESP_R48);   /* APP_CMD */
+    sd_cmd(qts, 41, ACMD41_ARG, RESP_R48);   /* SD_SEND_OP_COND */
+    sd_cmd(qts, 2,  0x00000000, RESP_R2);    /* ALL_SEND_CID */
+    sd_cmd(qts, 3,  0x00000000, RESP_R48);   /* SEND_RELATIVE_ADDR */
+
+    rca = qtest_readl(qts, SDHCI_BASE + SDHC_RSPREG0) >> 16;  /* R6 */
+
+    sd_cmd(qts, 7,  rca << 16,  RESP_R1B);   /* SELECT_CARD */
+    sd_cmd(qts, 16, BLK_LEN,    RESP_R48);   /* SET_BLOCKLEN */
+}
+
+/*
+ * Build a 32-bit ADMA2 table: per 8-byte entry word0 = (len << 16) | attr,
+ * word1 = target address.  When int_desc >= 0 that descriptor also carries
+ * the ADMA descriptor interrupt attribute, so the model yields mid-chain
+ * (rescheduling on QEMU_CLOCK_VIRTUAL) instead of running to completion.
+ */
+static void build_adma_table(QTestState *qts, int int_desc)
+{
+    for (int i = 0; i < NDESC; i++) {
+        uint8_t attr = SDHC_ADMA_ATTR_VALID | SDHC_ADMA_ATTR_ACT_TRAN;
+        uint32_t addr = (uint32_t)(ADMA_BUF_ADDR + (uint64_t)i * BLK_LEN);
+
+        if (i == int_desc) {
+            attr |= SDHC_ADMA_ATTR_INT;
+        }
+        if (i == NDESC - 1) {
+            attr |= SDHC_ADMA_ATTR_END;
+        }
+        qtest_writel(qts, ADMA_TABLE_ADDR + (uint64_t)i * 8,
+                     ((uint32_t)BLK_LEN << 16) | attr);
+        qtest_writel(qts, ADMA_TABLE_ADDR + (uint64_t)i * 8 + 4, addr);
+    }
+}
+
+/* Program the ADMA2 engine, descriptor pointer and transfer geometry */
+static void program_adma_read(QTestState *qts)
+{
+    qtest_writeb(qts, SDHCI_BASE + SDHC_HOSTCTL, SDHC_CTRL_ADMA2_32);
+    qtest_writel(qts, SDHCI_BASE + SDHC_ADMASYSADDR, (uint32_t)ADMA_TABLE_ADDR);
+    qtest_writel(qts, SDHCI_BASE + SDHC_ADMASYSADDR + 4,
+                 (uint32_t)(ADMA_TABLE_ADDR >> 32));
+    qtest_writel(qts, SDHCI_BASE + SDHC_BLKSIZE, BLK_LEN | (NDESC << 16));
+    qtest_writew(qts, SDHCI_BASE + SDHC_TRNMOD,
+                 SDHC_TRNS_DMA | SDHC_TRNS_BLK_CNT_EN |
+                 SDHC_TRNS_READ | SDHC_TRNS_MULTI);
+    qtest_writel(qts, SDHCI_BASE + SDHC_ARGUMENT, 0);  /* start block 0 */
+    qtest_writew(qts, SDHCI_BASE + SDHC_NORINTSTS, 0xffff);
+    qtest_memset(qts, ADMA_BUF_ADDR, 0xa5, TRANSFER_SIZE);
+}
+
+/* CMD18 READ_MULTIPLE_BLOCK with data present -> kicks off ADMA */
+static void kick_cmd18(QTestState *qts)
+{
+    qtest_writew(qts, SDHCI_BASE + SDHC_CMDREG,
+                 (18 << 8) | SDHC_CMD_DATA_PRESENT | RESP_R48);
+}
+
+/* Start a card-carrying icicle machine and bring the card to "tran" */
+static QTestState *icicle_start(char **tmp)
+{
+    int fd;
+    GError *err = NULL;
+    QTestState *qts;
+
+    fd = g_file_open_tmp("icicle-sdhci-XXXXXX.raw", tmp, &err);
+    g_assert_no_error(err);
+    g_assert_cmpint(fd, >=, 0);
+    g_assert_cmpint(ftruncate(fd, 1 * 1024 * 1024), ==, 0);
+    write_pattern(fd);
+    close(fd);
+
+    qts = qtest_initf("-machine microchip-icicle-kit -accel qtest "
+                      "-display none -drive if=sd,file=%s,format=raw", *tmp);
+    sd_bring_up_card(qts);
+    return qts;
+}
+
+/*
+ * Facet 1 -- pacing.  A non-interrupt chain completes after a bounded number
+ * of SDHC_TRANSFER_DELAY steps.  With 12 descriptors and a quota of five per
+ * batch, completion requires exactly three virtual-clock steps.
+ */
+static void test_adma_pacing(void)
+{
+    char *tmp = NULL;
+    QTestState *qts = icicle_start(&tmp);
+    const int expected_steps = DIV_ROUND_UP(NDESC,
+                                            SDHC_ADMA_DESCS_PER_DELAY);
+    uint16_t sts;
+    int steps = 0;
+
+    build_adma_table(qts, -1);
+    program_adma_read(qts);
+    kick_cmd18(qts);
+
+    while (!((sts = qtest_readw(qts, SDHCI_BASE + SDHC_NORINTSTS)) &
+             SDHC_NIS_TRSCMP)) {
+        qtest_clock_step(qts, SDHC_TRANSFER_DELAY);
+        steps++;
+        g_assert_cmpint(steps, <=, expected_steps);
+    }
+
+    g_assert_cmpint(steps, ==, expected_steps);
+    g_assert_cmphex(sts & SDHC_NIS_TRSCMP, ==, SDHC_NIS_TRSCMP);
+    g_assert_cmphex(sts & SDHC_NIS_ERR, ==, 0);
+    check_adma_data(qts);
+
+    g_test_message("ADMA %d descriptors: %d clock steps to Transfer Complete",
+                   NDESC, steps);
+
+    qtest_quit(qts);
+    unlink(tmp);
+    g_free(tmp);
+}
+
+/*
+ * Facet 2 -- MMIO coupling (regression for "Run ADMA independently of MMIO").
+ * With the clock frozen, a bare interrupt-status read must not resume the
+ * transfer left pending by the mid-chain interrupt descriptor: Transfer
+ * Complete must still be clear.  A model that resumes ADMA from an MMIO read
+ * completes it on that bare read and fails the assertion.
+ */
+static void test_adma_mmio_coupling(void)
+{
+    char *tmp = NULL;
+    QTestState *qts = icicle_start(&tmp);
+    uint16_t sts;
+    int steps = 0;
+
+    build_adma_table(qts, INT_DESC);
+    program_adma_read(qts);
+    kick_cmd18(qts);
+
+    qtest_clock_step(qts, SDHC_TRANSFER_DELAY);
+    qtest_clock_step(qts, SDHC_TRANSFER_DELAY);
+
+    sts = qtest_readw(qts, SDHCI_BASE + SDHC_NORINTSTS);
+    g_assert_cmphex(sts & (SDHC_NIS_DMA | SDHC_NIS_TRSCMP), ==,
+                    SDHC_NIS_DMA);
+
+    sts = qtest_readw(qts, SDHCI_BASE + SDHC_NORINTSTS);
+    g_assert_cmphex(sts & (SDHC_NIS_DMA | SDHC_NIS_TRSCMP), ==,
+                    SDHC_NIS_DMA);
+
+    while (!((sts = qtest_readw(qts, SDHCI_BASE + SDHC_NORINTSTS)) &
+             SDHC_NIS_TRSCMP)) {
+        qtest_clock_step(qts, SDHC_TRANSFER_DELAY);
+        steps++;
+        g_assert_cmpint(steps, <, 1000);
+    }
+    g_assert_cmphex(sts & SDHC_NIS_ERR, ==, 0);
+    check_adma_data(qts);
+
+    g_test_message("ADMA coupling: %d clock steps to complete after bare read",
+                   steps);
+
+    qtest_quit(qts);
+    unlink(tmp);
+    g_free(tmp);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    qtest_add_func("/microchip/icicle/sdhci/adma-pacing", test_adma_pacing);
+    qtest_add_func("/microchip/icicle/sdhci/adma-mmio-coupling",
+                   test_adma_mmio_coupling);
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 1fe008c9ed..29457193ed 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -311,6 +311,8 @@ qtests_riscv32 = \
 
 qtests_riscv64 = ['riscv-csr-test'] + \
   (unpack_edk2_blobs ? ['bios-tables-test'] : []) + \
+  (config_all_devices.has_key('CONFIG_MICROCHIP_PFSOC') ?
+   ['cadence-sdhci-test'] : []) + \
   (config_all_devices.has_key('CONFIG_SIFIVE_L2CC') ? ['sifive_l2cc_test'] : []) + \
   (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
    config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
-- 
2.53.0


