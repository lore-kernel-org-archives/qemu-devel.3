Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 423C9CCF9EB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 07:52:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDI1E-0006J9-RY; Mon, 27 Oct 2025 03:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_haixcui@quicinc.com>)
 id 1vDI1C-0006Il-Rm
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 03:51:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_haixcui@quicinc.com>)
 id 1vDI19-0002f5-R1
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 03:51:54 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59R3GlTl1502830; Mon, 27 Oct 2025 07:51:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KNrYoTJ3e7An8ocTgahae7uimZjCy8pm6rCNsmaInYk=; b=dx+wJ32yzoF2zN9d
 V9nSe5SMsQTwwTLV46C5sgtB3enSeK67EgNpjW65DSJagSh13TIq2ddq/QsUw6rY
 WyHFRDUjXuCQnunGQMIuyjGZh593ADPavAMPBJ3kDRZS+qsWt+LeAkIUfH1RRrl5
 f0vJsx2fTEaEBbdkgB66W9mSO5JL2XHhjwQIMU1gY30P+Cv1Kn4ctHTLKkLu8NeK
 wwld1g8fpROPXHx026k3oryYa79jFluE8NE7zH9Pk41FBtxdu/VAxtsZQAuX5IQ5
 hAIOqyqtYu/1FoQ8YHOFaW3bzHX3RVsla2PouG8cuW9yg5qS8rUfPQHv54Ed1fXA
 c82G1w==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a20pnrp37-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Oct 2025 07:51:49 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com
 [10.47.209.197])
 by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 59R7pmR2002040
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Oct 2025 07:51:48 GMT
Received: from haixcui1-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Mon, 27 Oct 2025 00:51:45 -0700
From: Haixu Cui <quic_haixcui@quicinc.com>
To: <alex.bennee@linaro.org>, <viresh.kumar@linaro.org>,
 <quic_tsoni@quicinc.com>, <qemu-devel@nongnu.org>, <mst@redhat.com>,
 <zhiqiang.tu@oss.qualcomm.com>
CC: Haixu Cui <quic_haixcui@quicinc.com>
Subject: [PATCH v1 2/3] standard-headers: Update virtio_spi.h from Linux
 v6.18-rc3
Date: Mon, 27 Oct 2025 15:51:22 +0800
Message-ID: <20251027075123.2237914-3-quic_haixcui@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251027075123.2237914-1-quic_haixcui@quicinc.com>
References: <20251027075123.2237914-1-quic_haixcui@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: 3ImXn1NZxURdWvgvoA9ryMcnWkLfyWMI
X-Proofpoint-ORIG-GUID: 3ImXn1NZxURdWvgvoA9ryMcnWkLfyWMI
X-Authority-Analysis: v=2.4 cv=A+xh/qWG c=1 sm=1 tr=0 ts=68ff2495 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z4Rwk6OoAAAA:8 a=COk6AnOGAAAA:8 a=rqJjEXyH_1KH1bkhQPcA:9
 a=HkZW87K1Qel5hWWM3VKY:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDA3MiBTYWx0ZWRfX7P59EfOAPn0e
 RZoNoeOBhYVgc5lNLmjeNDB8tIGNwwOCQU1lW7GHJmDus9VwXmiZUKDJEqWMFmUrpsG8OTBJkQ2
 knFpqOcuLgGNnROrWCn4k/wTulnzcVV9jJZiZynGRmmW6tjNIXOIhfw+VCNGApQdfBwSPl5ikD8
 hLceOXfK5uGS/ItOd5bMufG7GkRXmBwmwc04tTcoisR3cAwWJv46HiPygKN2NE5Rp4Ka8QMmP/7
 ZAt8QdE2lmOfVYse7rZvSuBWyonjl+Uc7gLRf6WWOI8Xc0HLJTn1+4IzF7dt0kQSi8qdk2q++Fv
 obuk8lvI4B4d5UFbiWvGcIdo5iWiGdTfbG6XgUi2bGuTWYDsKzQ82/LI+KyqqnfCKIRtZrVJds4
 t2dvFMyegoum+AcZLrmLqDt+PqXfLQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 suspectscore=0
 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510020000
 definitions=main-2510270072
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=quic_haixcui@quicinc.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Synced virtio_spi.h from upstream Linux kernelusing
scripts/update-linux-headers.sh.

Source:
- Linux commit dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa (v6.18-rc3)
- Author: Linus Torvalds <torvalds@linux-foundation.org>
- Date:   Sun Oct 26 15:59:49 2025 -0700

This update ensures QEMU's standard headers are consistent with the latest
virtio SPI definitions from Linux v6.18-rc3.

Signed-off-by: Haixu Cui <quic_haixcui@quicinc.com>
---
 include/standard-headers/linux/virtio_spi.h | 181 ++++++++++++++++++++
 1 file changed, 181 insertions(+)
 create mode 100644 include/standard-headers/linux/virtio_spi.h

diff --git a/include/standard-headers/linux/virtio_spi.h b/include/standard-headers/linux/virtio_spi.h
new file mode 100644
index 0000000000..54e570fb4a
--- /dev/null
+++ b/include/standard-headers/linux/virtio_spi.h
@@ -0,0 +1,181 @@
+/* SPDX-License-Identifier: BSD-3-Clause */
+/*
+ * Copyright (C) 2023 OpenSynergy GmbH
+ * Copyright (C) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+#ifndef _LINUX_VIRTIO_VIRTIO_SPI_H
+#define _LINUX_VIRTIO_VIRTIO_SPI_H
+
+#include "standard-headers/linux/types.h"
+#include "standard-headers/linux/virtio_config.h"
+#include "standard-headers/linux/virtio_ids.h"
+#include "standard-headers/linux/virtio_types.h"
+
+/* Sample data on trailing clock edge */
+#define VIRTIO_SPI_CPHA			_BITUL(0)
+/* Clock is high when IDLE */
+#define VIRTIO_SPI_CPOL			_BITUL(1)
+/* Chip Select is active high */
+#define VIRTIO_SPI_CS_HIGH			_BITUL(2)
+/* Transmit LSB first */
+#define VIRTIO_SPI_MODE_LSB_FIRST		_BITUL(3)
+/* Loopback mode */
+#define VIRTIO_SPI_MODE_LOOP			_BITUL(4)
+
+/**
+ * struct virtio_spi_config - All config fields are read-only for the
+ * Virtio SPI driver
+ * @cs_max_number: maximum number of chipselect the host SPI controller
+ *   supports.
+ * @cs_change_supported: indicates if the host SPI controller supports to toggle
+ *   chipselect after each transfer in one message:
+ *   0: unsupported, chipselect will be kept in active state throughout the
+ *      message transaction;
+ *   1: supported.
+ *   Note: Message here contains a sequence of SPI transfers.
+ * @tx_nbits_supported: indicates the supported number of bit for writing:
+ *   bit 0: DUAL (2-bit transfer), 1 for supported
+ *   bit 1: QUAD (4-bit transfer), 1 for supported
+ *   bit 2: OCTAL (8-bit transfer), 1 for supported
+ *   other bits are reserved as 0, 1-bit transfer is always supported.
+ * @rx_nbits_supported: indicates the supported number of bit for reading:
+ *   bit 0: DUAL (2-bit transfer), 1 for supported
+ *   bit 1: QUAD (4-bit transfer), 1 for supported
+ *   bit 2: OCTAL (8-bit transfer), 1 for supported
+ *   other bits are reserved as 0, 1-bit transfer is always supported.
+ * @bits_per_word_mask: mask indicating which values of bits_per_word are
+ *   supported. If not set, no limitation for bits_per_word.
+ * @mode_func_supported: indicates the following features are supported or not:
+ *   bit 0-1: CPHA feature
+ *     0b00: invalid, should support as least one CPHA setting
+ *     0b01: supports CPHA=0 only
+ *     0b10: supports CPHA=1 only
+ *     0b11: supports CPHA=0 and CPHA=1.
+ *   bit 2-3: CPOL feature
+ *     0b00: invalid, should support as least one CPOL setting
+ *     0b01: supports CPOL=0 only
+ *     0b10: supports CPOL=1 only
+ *     0b11: supports CPOL=0 and CPOL=1.
+ *   bit 4: chipselect active high feature, 0 for unsupported and 1 for
+ *     supported, chipselect active low is supported by default.
+ *   bit 5: LSB first feature, 0 for unsupported and 1 for supported,
+ *     MSB first is supported by default.
+ *   bit 6: loopback mode feature, 0 for unsupported and 1 for supported,
+ *     normal mode is supported by default.
+ * @max_freq_hz: the maximum clock rate supported in Hz unit, 0 means no
+ *   limitation for transfer speed.
+ * @max_word_delay_ns: the maximum word delay supported, in nanoseconds.
+ *   A value of 0 indicates that word delay is unsupported.
+ *   Each transfer may consist of a sequence of words.
+ * @max_cs_setup_ns: the maximum delay supported after chipselect is asserted,
+ *   in ns unit, 0 means delay is not supported to introduce after chipselect is
+ *   asserted.
+ * @max_cs_hold_ns: the maximum delay supported before chipselect is deasserted,
+ *   in ns unit, 0 means delay is not supported to introduce before chipselect
+ *   is deasserted.
+ * @max_cs_incative_ns: maximum delay supported after chipselect is deasserted,
+ *   in ns unit, 0 means delay is not supported to introduce after chipselect is
+ *   deasserted.
+ */
+struct virtio_spi_config {
+	uint8_t cs_max_number;
+	uint8_t cs_change_supported;
+#define VIRTIO_SPI_RX_TX_SUPPORT_DUAL		_BITUL(0)
+#define VIRTIO_SPI_RX_TX_SUPPORT_QUAD		_BITUL(1)
+#define VIRTIO_SPI_RX_TX_SUPPORT_OCTAL		_BITUL(2)
+	uint8_t tx_nbits_supported;
+	uint8_t rx_nbits_supported;
+	uint32_t bits_per_word_mask;
+#define VIRTIO_SPI_MF_SUPPORT_CPHA_0		_BITUL(0)
+#define VIRTIO_SPI_MF_SUPPORT_CPHA_1		_BITUL(1)
+#define VIRTIO_SPI_MF_SUPPORT_CPOL_0		_BITUL(2)
+#define VIRTIO_SPI_MF_SUPPORT_CPOL_1		_BITUL(3)
+#define VIRTIO_SPI_MF_SUPPORT_CS_HIGH		_BITUL(4)
+#define VIRTIO_SPI_MF_SUPPORT_LSB_FIRST		_BITUL(5)
+#define VIRTIO_SPI_MF_SUPPORT_LOOPBACK		_BITUL(6)
+	uint32_t mode_func_supported;
+	uint32_t max_freq_hz;
+	uint32_t max_word_delay_ns;
+	uint32_t max_cs_setup_ns;
+	uint32_t max_cs_hold_ns;
+	uint32_t max_cs_inactive_ns;
+};
+
+/**
+ * struct spi_transfer_head - virtio SPI transfer descriptor
+ * @chip_select_id: chipselect index the SPI transfer used.
+ * @bits_per_word: the number of bits in each SPI transfer word.
+ * @cs_change: whether to deselect device after finishing this transfer
+ *     before starting the next transfer, 0 means cs keep asserted and
+ *     1 means cs deasserted then asserted again.
+ * @tx_nbits: bus width for write transfer.
+ *     0,1: bus width is 1, also known as SINGLE
+ *     2  : bus width is 2, also known as DUAL
+ *     4  : bus width is 4, also known as QUAD
+ *     8  : bus width is 8, also known as OCTAL
+ *     other values are invalid.
+ * @rx_nbits: bus width for read transfer.
+ *     0,1: bus width is 1, also known as SINGLE
+ *     2  : bus width is 2, also known as DUAL
+ *     4  : bus width is 4, also known as QUAD
+ *     8  : bus width is 8, also known as OCTAL
+ *     other values are invalid.
+ * @reserved: for future use.
+ * @mode: SPI transfer mode.
+ *     bit 0: CPHA, determines the timing (i.e. phase) of the data
+ *         bits relative to the clock pulses.For CPHA=0, the
+ *         "out" side changes the data on the trailing edge of the
+ *         preceding clock cycle, while the "in" side captures the data
+ *         on (or shortly after) the leading edge of the clock cycle.
+ *         For CPHA=1, the "out" side changes the data on the leading
+ *         edge of the current clock cycle, while the "in" side
+ *         captures the data on (or shortly after) the trailing edge of
+ *         the clock cycle.
+ *     bit 1: CPOL, determines the polarity of the clock. CPOL=0 is a
+ *         clock which idles at 0, and each cycle consists of a pulse
+ *         of 1. CPOL=1 is a clock which idles at 1, and each cycle
+ *         consists of a pulse of 0.
+ *     bit 2: CS_HIGH, if 1, chip select active high, else active low.
+ *     bit 3: LSB_FIRST, determines per-word bits-on-wire, if 0, MSB
+ *         first, else LSB first.
+ *     bit 4: LOOP, loopback mode.
+ * @freq: the transfer speed in Hz.
+ * @word_delay_ns: delay to be inserted between consecutive words of a
+ *     transfer, in ns unit.
+ * @cs_setup_ns: delay to be introduced after CS is asserted, in ns
+ *     unit.
+ * @cs_delay_hold_ns: delay to be introduced before CS is deasserted
+ *     for each transfer, in ns unit.
+ * @cs_change_delay_inactive_ns: delay to be introduced after CS is
+ *     deasserted and before next asserted, in ns unit.
+ */
+struct spi_transfer_head {
+	uint8_t chip_select_id;
+	uint8_t bits_per_word;
+	uint8_t cs_change;
+	uint8_t tx_nbits;
+	uint8_t rx_nbits;
+	uint8_t reserved[3];
+	uint32_t mode;
+	uint32_t freq;
+	uint32_t word_delay_ns;
+	uint32_t cs_setup_ns;
+	uint32_t cs_delay_hold_ns;
+	uint32_t cs_change_delay_inactive_ns;
+};
+
+/**
+ * struct spi_transfer_result - virtio SPI transfer result
+ * @result: Transfer result code.
+ *          VIRTIO_SPI_TRANS_OK: Transfer successful.
+ *          VIRTIO_SPI_PARAM_ERR: Parameter error.
+ *          VIRTIO_SPI_TRANS_ERR: Transfer error.
+ */
+struct spi_transfer_result {
+#define VIRTIO_SPI_TRANS_OK	0
+#define VIRTIO_SPI_PARAM_ERR	1
+#define VIRTIO_SPI_TRANS_ERR	2
+	uint8_t result;
+};
+
+#endif /* #ifndef _LINUX_VIRTIO_VIRTIO_SPI_H */
-- 
2.34.1


