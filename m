Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E8A606A33C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 17:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=EifaiZ2s
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOeMZ-0001vG-L1; Wed, 04 Nov 2026 12:01:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOeLF-0001C2-4O; Wed, 04 Nov 2026 12:00:12 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOeLC-0002Vr-Mu; Wed, 04 Nov 2026 12:00:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EldwkEXB1Iz58irWbqXyxr+vlAdKkJWZxTz0lFJguQ+uK34LBlOVNC/QOVv4TIMdOTpl7AuitBxzxrLrN/407j4flGG7wdiJozMGuZ3rkOgT2/z8IT1JBNjyNqIilzFNCLbDFO/QEzjwkz8z+cLFSiihhB3jT71E54t9rSbPVZfT1DgH72ixL5k8H7SRfxSpq0LtyONt26/cpr1/rZWh0mmH9rU1oPyEnkemGCQ9kNHPWS3zWEQqqD1Yfj7g2xYMflzeLGjIpAsJg9B4uwMWDUsTV4hUhsywNrippl4nL6aImv0hpc4n/AKS8JQ+Lo5UzlKOl9GEB3df2cUA10vD7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fv5ICGNsT3tfdypQgwAmnXhGzWw3NARUbcSMTUWdn5I=;
 b=PzCoyYJSXlGjyR7yk9d++00o8FaU0j7dLfN/NbOkIzJ8qqvn//ndrOm191vc7c1pdOQ2zFKH3wYE+i05aUK7mV7HlBDrMIdvMOAu40fvMd5Gk6FqsklX69/2rr0i3oPHLlg9ZU7gOaPOd4nsW96hFqZE5mEZm3ohlAU7Dw6SKoZtf3EIOECgSxdbRhjRLKfT2/kPKvJjmOahO6QeutAg0qLS1nuf4wi3u9INgUFguxnX0HVwowlb5yUzzGLmd2q3addjEbrUB3FtCU37XB3ff2KNqWy0oqYxzyfTuN9sEKYrVQO6VSq1lJ04/Pkkkb1G/peRIQV3Hw37jbCFl/80Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fv5ICGNsT3tfdypQgwAmnXhGzWw3NARUbcSMTUWdn5I=;
 b=EifaiZ2sv9385hvgJRhVDqagc1fruYNHqCHDuBn9uwbioSLdOLJdvjCKcM4BZmjI0IzYGISr6OxX7bE/+no4KImCL+Fsv+f+DcWtfju2sQ5+VLTAtDx/do2roAeiZf3Qrlxculq8XydgUwkZ9zTTBqpv6uSKnOIR/Xv//RRMEasc66S9earoqZkid1LKrXoKIIXJxoeRcopwUc1McyYGy/XuCRHUD9xuLvWSscWH+wLMjBay5tBWHjwUMrMdYPHEmty4rsFVxZCE9aQdp5GphlC1EeeGHvB4fVTFclNFfVXNppbC21nLwJidki7MpV92Vxhxq8wVEzdcVgN28InY5w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by TYPPR02MB8901.apcprd02.prod.outlook.com (2603:1096:405:318::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 16:59:57 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 16:59:57 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org
Subject: [PATCH v5 09/10] docs/system/arm: Document MCIMX6UL-EVK Buildroot boot
Date: Thu,  5 Nov 2026 00:59:21 +0800
Message-ID: <20261104165927.678833-10-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104165927.678833-1-bin.meng@processmission.com>
References: <20261104165927.678833-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0051.jpnprd01.prod.outlook.com
 (2603:1096:405:372::19) To TYZPR02MB7121.apcprd02.prod.outlook.com
 (2603:1096:405:2c::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR02MB7121:EE_|TYPPR02MB8901:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fd15753-318d-48b1-5cda-08df3a950e11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|5023799004|261021121427099003|261009223027099003|261022105027099003|56012099006|261022115727099003|261021123027099003|261022075727099003|261026121527099003|261028144727099003|261026140227099003|261102123227099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: +MAgb+SOVGNHRiJEfrPqOfzd1rNRdoQbmPk50H2zYwnQPtFNTTiYxtEJM79JmHZGBGEWW+Yt0Q8GpKMGQ7ikbjuSXQowYjTJel+14eMsDHr6QopNJin79MBpxQSM7fQuXofoWL10j7mXFkizeb5J7E3cJ7/UdZRqq2KdKAoEmJL0+FLTEdJhL1ouwjG+ihrZrGPmebtxVsIpt67zVgIl+ttisF5s5XDqGDhKp196zgghqDYpTa7RILiuWC63O9NZs7QFVkfsSMomSsLWV4NpCgDPdXoVrftW0xRt+yhpD/ZhUo5OBxT3RssOyHVmyhcGJnpT0Ey2Q3cYIteIVInqoGJaOB3Q836BQ+KJKQMwuUJ/14iE2Ax3ntzKtiTCmzxEIc1dPIjRreeEB4c8Qo9jm5d5IjVK/tPETitlZGRb1VS9Yf8R8t5UBifdl74dZ6/HM4IH7c1lgkzGHQonthrrAADfMWM2q/O3L3KFjCkPYvRsa2VAdWsbpmGj5BdYrP69PGJr7hWyHGjqV2NH/5/b1oWFg/xnmrqpTqGP3xPl+ZIqj9QS8esdhhzBtq6d+7ec2Y2QvARhxOkAqGMbQdsPE8Y9bhgILV3NFgP+rpQ6DgbW9TKjVIwWt4kSL2VIxPiUu/LSS6+39z1aAq7cZ5zb9alA67iNjwcLna/2XqciXnw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(5023799004)(261021121427099003)(261009223027099003)(261022105027099003)(56012099006)(261022115727099003)(261021123027099003)(261022075727099003)(261026121527099003)(261028144727099003)(261026140227099003)(261102123227099003)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MX1c5YAHrxJhbSszTJoEmDhSkEKipSvZXcBEjb0nQQvRvkaRFm2dpj6CvQ3N?=
 =?us-ascii?Q?dhEdCMh3jPiPD+2BUmoOFZMRRi2Du5VEZmwD/eQ3z1g+rqQ+64M3lWqRhVRc?=
 =?us-ascii?Q?JiVrCjEADQPZx8EyQBwyejewo8wzBh2KLin416svlWrddDEyqD7/FarHFQV4?=
 =?us-ascii?Q?FjFWJ9wzH6p44y4rBPWP5iX6SRT7OH9SVN8pA0iOvu/2DKTPPJFa7YUeC0Nr?=
 =?us-ascii?Q?XJ+wE1nVMrCu7t2XcO5d9QSbFhg1i70Ts4HsHJ+53ggw+8NTrMcaLThb13Yz?=
 =?us-ascii?Q?dLP7mlQVCrKuu+LBmYI93uMVzScmQlarSSDYmuWzNTcNbWH5FgjJG+G4PmeZ?=
 =?us-ascii?Q?q+IInSLLd+oUAG7HzSrwnuDjIk1z7CgWJf1hxlmSSksZqOCSfeHNob+1PeYd?=
 =?us-ascii?Q?NClK3AqBVvtE6rabgRK38/KhPDexkO5duqvkCq51ElMzsovPYlamA233dWt7?=
 =?us-ascii?Q?ABq7wqRbCkhAqluVqxLFLZSXxuk4IU7jVFQo2C4AlSIq1UmnAB3TQy9ifZvx?=
 =?us-ascii?Q?An9duxq9JSMmZlkczYd55uEP7g+vcebzlR+S5eYhSCtNbx3u5/p4dhOKnPiA?=
 =?us-ascii?Q?Khsfyw1ZUXddRNupYvuqjrBQpXykX086oKUYUWPzzZ5sEe+jd9oRfMDB35bT?=
 =?us-ascii?Q?kCh3sfLgVFvj0OTFbgp48GnAQyuPJByy+X0KOYz0GbVnXTOA5uv6PuUBuFUf?=
 =?us-ascii?Q?T2CoE1kogHeSSslNyh4szETNdfg56/jggmtWwhxiNFxtqCkXkLLIALLGx12/?=
 =?us-ascii?Q?igx8kSq1W7/HujRFfduajiVMOvqSdvOB30nZVFq1faqxrV5FU2Zkg9+D/C9k?=
 =?us-ascii?Q?RxX1egDPBJY2sB2cjkQiYPUPe3NIId5YDgqXgZyTooZIlaOg2csP9uE1HLFx?=
 =?us-ascii?Q?4qIHwqmsSEBD0pKoPOacpybyiBQj7bkWE3HmMZ33x4eMJ4WclFG0UYdsxDwq?=
 =?us-ascii?Q?OT8hXjodWumskiN/FVl5N6KD63fBXIZ8g7gJ9Youq428WAhXLpFhHwIV5w9O?=
 =?us-ascii?Q?LqqopHHgivx+d4zRWzKTEFzASeqITVEN2Uk0DXKQoWyzo8TFK5NURI626PvX?=
 =?us-ascii?Q?uI+noR37YLlQkuz0l1ZNu1+tOY68JzRKRFAsx8RPRtF9izL/0JigGkUfMv3z?=
 =?us-ascii?Q?zaIViXsTpHrqfbEedBAd2uhMXLDjllEy8C0T16ElrvUINtG6jHGrXaC8EJ+P?=
 =?us-ascii?Q?Y2TjeXHK9TzG2BdcW07joq1NfzvX/rMOiQ60G18TGft1ZRquDZRf6M9pYHQI?=
 =?us-ascii?Q?SKwVRfpR8iDPRpIWGBLf5yhff+Zt+71RJ3mzB49NIgS5WrPtXz30f0z4Ibs7?=
 =?us-ascii?Q?imxtOlbfpvruu8Brd4Tge4K82gj/QWBqPecuiNmfgujv0wu4VHIrknowJgUP?=
 =?us-ascii?Q?s0gBvM9h0ATY6cNIqxWYwks5InaZIbRKJxGiH2+eejcB34Ncg0N5muJN4ayW?=
 =?us-ascii?Q?mpd5brzHg3FTjofHlbLVsUDkgK+G+orKgM9/wcBf7Gj6thCwVArAEcn25/Ku?=
 =?us-ascii?Q?wVthhPDf96qdOL2WiplqKWG4ZIUCxoSSVS1npyhm7eZ8eqqXy9e9r/0laQC8?=
 =?us-ascii?Q?04M7ZQwr2XQF45Do6P/fRW/yQOnFR9th281vrRSscwAsJ7R+mW/J0mjwF3Qh?=
 =?us-ascii?Q?hxH/yNtpxL0Y/6khMSgvCC9mQDXvvOUAdKUmfv+VD45giiCrIqOnr7Q+9l+A?=
 =?us-ascii?Q?4t0G37TA43NWqpMoYI/atBe2cniDo8k5MA4eBzJ3/i5UV+PlFo81YFQE6jv7?=
 =?us-ascii?Q?gdC5v+HN2yF0R16102M9LuOS0L07xlg=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fd15753-318d-48b1-5cda-08df3a950e11
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 16:59:57.1343 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LOhtCdsVnzw0SbyWIG0AvzUkNJjo4MRBkcSEyLBn7a2VrM+qv6bp9hcznfwGV2/t/+aXW8fGdbpzpQIouVYWVkBbtE/8WnTCv3a8xizO//U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR02MB8901
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

Provide verified instructions for U-Boot and direct Linux boot using
Buildroot images.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>

---

Changes in v5:
- Remove redundant 512 MiB RAM options from boot examples
- Fix punctuation before explicit code-block directives

Changes in v3:
- Document the RAM limits and firmware geometry rounding

 docs/system/arm/mcimx6ul-evk.rst | 72 ++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/docs/system/arm/mcimx6ul-evk.rst b/docs/system/arm/mcimx6ul-evk.rst
index 8871138ab3..3704d533d5 100644
--- a/docs/system/arm/mcimx6ul-evk.rst
+++ b/docs/system/arm/mcimx6ul-evk.rst
@@ -3,3 +3,75 @@ NXP MCIMX6UL-EVK (``mcimx6ul-evk``)
 
 The ``mcimx6ul-evk`` machine models the NXP i.MX6UltraLite Evaluation Kit
 MCIMX6UL-EVK development board. It has a single Cortex-A7 CPU.
+
+The minimum RAM size is 16 MiB and the maximum is 2 GiB.
+The MMDC geometry reports the largest power-of-two capacity
+not exceeding the configured RAM size to firmware. Direct Linux
+boot uses the full configured RAM size.
+
+Booting Buildroot images
+------------------------
+
+Build the SD card image with the tested Buildroot version:
+
+.. code-block:: bash
+
+  $ git clone https://gitlab.com/buildroot.org/buildroot.git
+  $ cd buildroot
+  $ git checkout 2026.05
+  $ make imx6ulevk_defconfig
+  $ make
+
+The following examples use images generated by Buildroot::
+
+  IMAGES=/path/to/buildroot/output/images
+  QEMU_BUILD=/path/to/qemu/build
+
+The generated raw ``sdcard.img`` is about 84 MiB, which is not a capacity
+supported by QEMU's SD card model. Resize the image in place to 128 MiB::
+
+  "$QEMU_BUILD/qemu-img" resize -f raw "$IMAGES/sdcard.img" 128M
+
+This modifies the Buildroot output image; rebuilding the image restores its
+original size.
+
+The SD card must be attached to USDHC2 with ``index=1``. It is consequently
+named ``mmc1`` by U-Boot and ``mmcblk1`` by Linux. The first partition contains
+the kernel and device tree, while the second partition contains the root file
+system.
+
+U-Boot boot
+~~~~~~~~~~~
+
+The machine does not model the i.MX6UL Boot ROM or its SPL loading sequence.
+Load U-Boot proper at its linked address:
+
+.. code-block:: bash
+
+  "$QEMU_BUILD/qemu-system-arm" \
+      -M mcimx6ul-evk \
+      -device loader,file="$IMAGES/u-boot.bin",addr=0x87800000,cpu-num=0 \
+      -drive file="$IMAGES/sdcard.img",if=sd,index=1,format=raw \
+      -nographic
+
+The default Buildroot U-Boot environment selects ``mmc1``, loads ``zImage``
+and ``imx6ul-14x14-evk.dtb`` from the first partition, and starts Linux with
+``/dev/mmcblk1p2`` as the root file system. A ``bad CRC`` warning while loading
+an uninitialized persistent U-Boot environment is expected; U-Boot continues
+with its compiled-in defaults.
+
+Direct Linux boot
+~~~~~~~~~~~~~~~~~
+
+QEMU can load the Buildroot kernel and device tree directly. The kernel then
+mounts the second SD card partition as its root file system:
+
+.. code-block:: bash
+
+  "$QEMU_BUILD/qemu-system-arm" \
+      -M mcimx6ul-evk \
+      -kernel "$IMAGES/zImage" \
+      -dtb "$IMAGES/imx6ul-14x14-evk.dtb" \
+      -append "console=ttymxc0,115200 root=/dev/mmcblk1p2 rootwait rw" \
+      -drive file="$IMAGES/sdcard.img",if=sd,index=1,format=raw \
+      -nographic
-- 
2.53.0


