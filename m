Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA51C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:40:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24rf-0004no-Fm; Thu, 03 Sep 2026 06:40:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24rU-0004VH-VX
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:40:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24rS-0006CE-VH
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:40:04 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AHAH8440122
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 10:40:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qlErpaH7JSpV+B6q0S/Zw9ryoIsN9bGE2gC3f1JdMlg=; b=OxwoNPutolMRqk19
 KwR1sR4u7ES2oZ9LF9zkZcbcdZrf2xe342Wz6P/jrSTaCPYklAM5hqsAGdTita6U
 aNovlCpL++b+d+FFCnL1GYelz4SvkHD3g6w0Hf4mbtqg6IC6T/JnMLqRyVetbP/g
 +f7Dk15rLIeknnhRzBdvlJKwWbjj54KXcoYTQo4QIEC+WswwqQsvfyni1y05omwH
 FcAk6PGUa83yQOR6lLGL/fpUEIOzD2AHSNcTebidyn4Lbu+zyHy0UdE9l7eziClU
 L1evkVowJvl5nO3TAhfl/SbVA6dEO/NCyAW9c810mMLnZ5n/FZYtiYHeXekXz3gY
 Wp2ukw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf6p705sx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:40:01 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93917f4ccb4so306008785a.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788432001; x=1789036801; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qlErpaH7JSpV+B6q0S/Zw9ryoIsN9bGE2gC3f1JdMlg=;
 b=OVZHG3sMPd+Eh6LPXLvu8CKz7K8MkOIbDq765vYCYfE1s45CxjV3pHQe/M3wnb3sI0
 nY3ttCjcZnMPmwvC5Xe8tCQY1pkfd6eKFjQUVGxZoUAHxaEz9AGgLMKOus/PVuFHtknx
 iKWHbu9fXbnnjA0Ligpz7ziO5pfaNikNJwdpUEHE+pdzfEr3YRYaP8te45OWE2LVoduW
 JRCcSyzCFKXHkK/m/hFIBnjG2xWdH5dYI6nMI4AC8fj+yJczd427FCtuIepa1kgX5CGy
 4bzZqn2NifJX4eq6nawB1dq746vIpALJCoR5wruRkQ2tYbIeQM2PpOOQs0jACfWSrXKH
 XGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788432001; x=1789036801;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qlErpaH7JSpV+B6q0S/Zw9ryoIsN9bGE2gC3f1JdMlg=;
 b=OwIUjyeGV5jn85OyXVCvFBwyYAPLOXpB9KP4HgiQ0d4XY9LbyZSN9Kb2SGNMsE1d4h
 VpocAmXEWBFtb9Uq22Ak4SWjF+ZARABvYBCiR5IAkaIWKCtJKZYBnYiGsOL0sru0MiDj
 hqdLPbOSG6WStaBOUjP9Lp9A7Q34SlPmwezPpuTTSinx7nZrrNqmGnc3BYtm4pyiEPhX
 Hjkt8Icnti6SLtABCPITKAJNi07DzbvUyNE28KiQ+lBl8FVLrFYQU9NWr21G+je9K9So
 PWBETom/6FIz2hcI4rEJExKSmL06FB4Irk9b1klOTd5u3dd6z8GSbDMc2XhwFjlZLvUl
 NERA==
X-Gm-Message-State: AFuF++nsyRo4X5CwiHOdQm+xfVITBgeQQ5E5wHxJqPwEvt3WUtnK8l1Y
 FYYy+viI0EpW92k6eB3Fz/xLHZG6E54kL12rcSjR6M5hOGO2Q/SocLfwkzjoHuB5/krzEKBWk1K
 yU4/YP1o+VQ2yXqOKSUHjSE6eRZYiIz9+E0O+Pk8Ei2ZI8aUTKnSoV7OPohSxHmCy3g==
X-Gm-Gg: AYBFou1Vm3BugJ/Ru6KFQKSorspod9p7rSwYLMBLLOAcHJ6sWfNWC6KFgau8namW7vR
 psigqpy9kMPTkTXuyo5DkzXCx0q0fuMBSlYq0lyBFD9tH17iPdNZlZRhOJCQrjM/BhvGRN9e2vg
 gZaJs2YFkVEMdAwhORSrZKu1wuevrbcsBoqhM3Yvxpk+C+GX8czHY16KwgVXMBHQ2WctG/A3WUY
 FEGQaRRO3N+M61KVgW2RMJhRGCV8WO+sjaKn1K2j26nPCqcImVAzbXJPk0dB0ijKdi6DxczIrjT
 b8D+z185IqVEvztqXpzsEbjZBWx/EyQYMYwG8ycwNm9cAraipmA9kCY0vIzgknkmmd/Lw5DLtAR
 SNlhjMUB9zn3ByHzVDO/oon1IJiHumArdeCViNCAu
X-Received: by 2002:a05:620a:7f4:b0:936:b923:4828 with SMTP id
 af79cd13be357-9396e07ccb9mr454182785a.31.1788432000886; 
 Thu, 03 Sep 2026 03:40:00 -0700 (PDT)
X-Received: by 2002:a05:620a:7f4:b0:936:b923:4828 with SMTP id
 af79cd13be357-9396e07ccb9mr454176885a.31.1788432000256; 
 Thu, 03 Sep 2026 03:40:00 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448ed2edfsm12602786f8f.23.2026.09.03.03.39.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Sep 2026 03:39:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/51] qtest: add xilinx-zynq SDHCI sdma test
Date: Thu,  3 Sep 2026 12:38:47 +0200
Message-ID: <20260903103936.62355-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903103936.62355-1-philmd@oss.qualcomm.com>
References: <20260903103936.62355-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: UsDV48G1S-zZVk4pBvCCxRqMAyarQyZG
X-Proofpoint-ORIG-GUID: UsDV48G1S-zZVk4pBvCCxRqMAyarQyZG
X-Authority-Analysis: v=2.4 cv=OZyoyBTY c=1 sm=1 tr=0 ts=6a994e81 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=Byx-y9mGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=Pn4tuoQj9NfIQUoY1QkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX4fMk7g7vfAIt
 Kv4dWMCzHGUEkw6wxnKnfRxK6u8YFJOeqGND/XFisoTK/tvv6NS0uZnaJdM36B7VRdMN87BqhTl
 cOhMNeBtZjM4aqzO9QvZ7i/xWqw7jZ8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfXwo870PXSTpjD
 1GeY1IeZqdJdVrFbpATowWfzdyCNaoXKcABvN0QLCdVwGTs++1Uuv+YWEo75RZEqoXhCUwbtr4Z
 scjxSlonXngBrM8Qgs/Gx/n0/y9BPdTdXtNsyaikSCTb1JxKCZ8sgCPyOrE4CIbB5g3hbyuAxVO
 MqCLi2Kb0pY02KpX/JgPJ0B3ql4QbBp840ErwqYfFMuU63R9Qse6fUu+/y2Xg1GS8r31TNgDPgL
 T2D4Djl0XpbdvYvcwFx/YgJHV5uC21+20EO10SmY1G0siFvBKDkBiL25mo0blINoQIsSP0hKYrf
 ck9RYz3S3TPCmu8QILTT+d3OZFKvfPoT/cHDTneqYv3kdfiFSd2O2EbsvOtU260y/lWbuICPy+T
 wIRoPmY4dld3qyk9LnNbzVI2x482QulmypqLw2hO6tUdDcqflFJPFZkkPpk6XR87KnLyYodYFmT
 /mqZtuDljv+3gIx4pLA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030092
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

From: Tao Ding <dingtao0430@163.com>

Add a standalone qtest for the SDHCI controller on the
xilinx-zynq-a9 machine.

The test covers the SDMA boundary continuation case for a
multi-block read. After the controller stops at a boundary,
software updates SYSAD to continue the transfer. This verifies
the generic SDHCI behavior that previously failed when the
continuation SYSAD write was ignored and the transfer stalled.

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Signed-off-by: Tao Ding <dingtao0430@163.com>
Message-ID: <20260715160731.29969-3-dingtao0430@163.com>
[PMD: Write file using GLib API, cover file in MAINTAINERS]
Co-developed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <048bfef9-53dd-489c-be73-85e2c9f759a9@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 MAINTAINERS                          |   1 +
 tests/qtest/xilinx-zynq-sdhci-test.c | 185 +++++++++++++++++++++++++++
 tests/qtest/meson.build              |   1 +
 3 files changed, 187 insertions(+)
 create mode 100644 tests/qtest/xilinx-zynq-sdhci-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a1830cdad15..a898162cea5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2417,6 +2417,7 @@ F: hw/sd/sd*
 F: hw/sd/ssi-sd.c
 F: tests/qtest/fuzz-sdcard-test.c
 F: tests/qtest/sdhci-test.c
+F: tests/qtest/xilinx-zynq-sdhci-test.c
 
 USB
 S: Orphan
diff --git a/tests/qtest/xilinx-zynq-sdhci-test.c b/tests/qtest/xilinx-zynq-sdhci-test.c
new file mode 100644
index 00000000000..7957358cf5d
--- /dev/null
+++ b/tests/qtest/xilinx-zynq-sdhci-test.c
@@ -0,0 +1,185 @@
+/*
+ * QTests for the Xilinx Zynq SDHCI controller.
+ *
+ * Copyright (c) 2026 Tao Ding <dingtao0430@163.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/sd/sdhci.h"
+#include "hw/sd/sdhci-internal.h"
+
+#include "libqtest.h"
+#include "libqtest-single.h"
+#include "libqos/sdhci-cmd.h"
+
+#define XILINX_ZYNQ_MMC_BA             0xE0100000
+#define XILINX_ZYNQ_BLK_SIZE           512
+#define XILINX_ZYNQ_TEST_IMAGE_SIZE    (1 << 20)
+#define XILINX_ZYNQ_SDMA_BOUNDARY_ARG  7
+#define XILINX_ZYNQ_SDMA_BOUNDARY_SIZE (512 * 1024)
+#define XILINX_ZYNQ_SDMA_BLOCK_COUNT \
+    ((XILINX_ZYNQ_SDMA_BOUNDARY_SIZE / XILINX_ZYNQ_BLK_SIZE) + 1)
+#define XILINX_ZYNQ_SDMA_TRANSFER_SIZE \
+    (XILINX_ZYNQ_SDMA_BLOCK_COUNT * XILINX_ZYNQ_BLK_SIZE)
+#define XILINX_ZYNQ_DMA_ADDR           0x00100000
+
+#define SDHC_MAKE_BLKSZ(boundary, size) (((boundary) << 12) | (size))
+
+static char *sd_path;
+
+static QTestState *setup_sd_card(void)
+{
+    QTestState *qts;
+    uint16_t rca;
+
+    qts = qtest_initf(
+        "-machine xilinx-zynq-a9 "
+        "-drive if=sd,index=0,file=%s,format=raw,auto-read-only=off",
+        sd_path);
+
+    qtest_writew(qts, XILINX_ZYNQ_MMC_BA + SDHC_SWRST, SDHC_RESET_ALL);
+    qtest_writew(qts, XILINX_ZYNQ_MMC_BA + SDHC_CLKCON,
+                 SDHC_CLOCK_SDCLK_EN | SDHC_CLOCK_INT_STABLE |
+                 SDHC_CLOCK_INT_EN);
+    sdhci_cmd_regs(qts, XILINX_ZYNQ_MMC_BA, 0, 0, 0, 0, SDHC_APP_CMD);
+    sdhci_cmd_regs(qts, XILINX_ZYNQ_MMC_BA, 0, 0, 0x41200000, 0,
+                   (41 << 8));
+    sdhci_cmd_regs(qts, XILINX_ZYNQ_MMC_BA, 0, 0, 0, 0, SDHC_ALL_SEND_CID);
+    sdhci_cmd_regs(qts, XILINX_ZYNQ_MMC_BA, 0, 0, 0, 0,
+                   SDHC_SEND_RELATIVE_ADDR | SDHC_CMD_RESPONSE);
+    rca = qtest_readl(qts, XILINX_ZYNQ_MMC_BA + SDHC_RSPREG0) >> 16;
+    sdhci_cmd_regs(qts, XILINX_ZYNQ_MMC_BA, 0, 0, rca << 16, 0,
+                   SDHC_SELECT_DESELECT_CARD);
+
+    return qts;
+}
+
+static void write_pattern_to_image(size_t offset, size_t len)
+{
+    gchar *buf = g_malloc(len);
+    GError *err = NULL;
+    gsize bytes_written;
+    GIOChannel *chan;
+
+    for (size_t i = 0; i < len; i++) {
+        buf[i] = (i * 13 + 7) & 0xff;
+    }
+
+    chan = g_io_channel_new_file(sd_path, "w", &err);
+    g_assert_no_error(err);
+    g_io_channel_set_encoding(chan, NULL, &err);
+    g_assert_no_error(err);
+    g_io_channel_seek_position(chan, offset, G_SEEK_SET, &err);
+    g_assert_no_error(err);
+    g_io_channel_write_chars(chan, buf, len, &bytes_written, &err);
+    g_assert_no_error(err);
+    g_assert_cmpint(bytes_written, ==, len);
+    g_io_channel_shutdown(chan, TRUE, &err);
+    g_assert_no_error(err);
+
+    g_free(buf);
+}
+
+static void wait_for_block_count(QTestState *qts, uint16_t expected)
+{
+    int i;
+
+    for (i = 0; i < 1000; i++) {
+        if (qtest_readw(qts, XILINX_ZYNQ_MMC_BA + SDHC_BLKCNT) == expected) {
+            return;
+        }
+        g_usleep(100);
+    }
+
+    g_assert_cmpuint(qtest_readw(qts, XILINX_ZYNQ_MMC_BA + SDHC_BLKCNT),
+                     ==, expected);
+}
+
+/*
+ * SDMA stops at each boundary and requires software to update SYSAD
+ * to continue. The bug this test covers leaves DOING_READ/WRITE asserted,
+ * so the continuation SYSAD write is ignored and the transfer stalls.
+ */
+static void test_read_sdma_boundary_continue(void)
+{
+    QTestState *qts = setup_sd_card();
+    uint8_t *actual = g_malloc0(XILINX_ZYNQ_SDMA_TRANSFER_SIZE);
+    uint8_t *expected = g_malloc(XILINX_ZYNQ_SDMA_TRANSFER_SIZE);
+
+    write_pattern_to_image(0, XILINX_ZYNQ_SDMA_TRANSFER_SIZE);
+
+    for (size_t i = 0; i < XILINX_ZYNQ_SDMA_TRANSFER_SIZE; i++) {
+        expected[i] = (i * 13 + 7) & 0xff;
+    }
+
+    qtest_writel(qts, XILINX_ZYNQ_DMA_ADDR, 0xdeadbeef);
+    qtest_writel(qts, XILINX_ZYNQ_DMA_ADDR + XILINX_ZYNQ_SDMA_BOUNDARY_SIZE,
+                 0xcafef00d);
+
+    qtest_writel(qts, XILINX_ZYNQ_MMC_BA + SDHC_SYSAD, XILINX_ZYNQ_DMA_ADDR);
+    sdhci_cmd_regs(qts, XILINX_ZYNQ_MMC_BA,
+                   SDHC_MAKE_BLKSZ(XILINX_ZYNQ_SDMA_BOUNDARY_ARG,
+                                   XILINX_ZYNQ_BLK_SIZE),
+                   XILINX_ZYNQ_SDMA_BLOCK_COUNT, 0,
+                   SDHC_TRNS_DMA | SDHC_TRNS_MULTI | SDHC_TRNS_READ |
+                   SDHC_TRNS_BLK_CNT_EN,
+                   SDHC_READ_MULTIPLE_BLOCK | SDHC_CMD_DATA_PRESENT);
+
+    wait_for_block_count(qts, 1);
+
+    qtest_writew(qts, XILINX_ZYNQ_MMC_BA + SDHC_NORINTSTS, 0xffff);
+    qtest_writel(qts, XILINX_ZYNQ_MMC_BA + SDHC_SYSAD,
+                 XILINX_ZYNQ_DMA_ADDR + XILINX_ZYNQ_SDMA_BOUNDARY_SIZE);
+
+    wait_for_block_count(qts, 0);
+
+    qtest_memread(qts, XILINX_ZYNQ_DMA_ADDR, actual,
+                  XILINX_ZYNQ_SDMA_TRANSFER_SIZE);
+    g_assert_cmpmem(actual, XILINX_ZYNQ_SDMA_TRANSFER_SIZE,
+                    expected, XILINX_ZYNQ_SDMA_TRANSFER_SIZE);
+
+    g_free(expected);
+    g_free(actual);
+    qtest_quit(qts);
+}
+
+static void drive_destroy(void)
+{
+    unlink(sd_path);
+    g_free(sd_path);
+}
+
+static void drive_create(void)
+{
+    int fd;
+    int ret;
+    GError *error = NULL;
+
+    fd = g_file_open_tmp("xilinx-zynq-sdhci.XXXXXX", &sd_path, &error);
+    if (fd == -1) {
+        fprintf(stderr, "unable to create sdhci file: %s\n", error->message);
+        g_error_free(error);
+    }
+    g_assert_nonnull(sd_path);
+
+    ret = ftruncate(fd, XILINX_ZYNQ_TEST_IMAGE_SIZE);
+    g_assert_cmpint(ret, ==, 0);
+    close(fd);
+}
+
+int main(int argc, char **argv)
+{
+    int ret;
+
+    drive_create();
+
+    g_test_init(&argc, &argv, NULL);
+    qtest_add_func("xilinx-zynq-sdhci/sdma/read-boundary-continue",
+                   test_read_sdma_boundary_continue);
+
+    ret = g_test_run();
+    drive_destroy();
+    return ret;
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 50a1a5272fa..17870e339b4 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -255,6 +255,7 @@ qtests_arm = \
    config_all_devices.has_key('CONFIG_MPS2') ? ['cmsdk-apb-watchdog-test'] : []) + \
   (config_all_devices.has_key('CONFIG_ASPEED_SOC') ? qtests_aspeed : []) + \
   (config_all_devices.has_key('CONFIG_NPCM7XX') ? qtests_npcm7xx : []) + \
+  (config_all_devices.has_key('CONFIG_ZYNQ') ? ['xilinx-zynq-sdhci-test'] : []) + \
   (config_all_devices.has_key('CONFIG_GENERIC_LOADER') ? ['hexloader-test'] : []) + \
   (config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test', 'tpm-tis-i2c-swtpm-test'] : []) + \
   (config_all_devices.has_key('CONFIG_VEXPRESS') ? ['test-arm-mptimer'] : []) + \
-- 
2.53.0


