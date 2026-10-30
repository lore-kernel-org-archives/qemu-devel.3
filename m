Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB893606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=D3lD/ryM;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZaMDK2ze
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMoBw-0006OV-Aw; Fri, 30 Oct 2026 11:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMoBd-0005ti-H2
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:06:33 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMoBa-0007Zi-Aa
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:06:33 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UER3GJ3515284
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:06:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 r8ca12Aw2UnLvMm0+mSYfBKBbI/qlVJsPAiVwYFMoMQ=; b=D3lD/ryMrr17BnXb
 4JDZEHzHXNd1/s9yhSPwUzhZ20qIuWybNlF3YlDJV97zycFhnlhj6LRIXrvElLgH
 5up7k/tl6S23AI6siFV2pjC7Su+rb6SWIT+kr59HQqIbispsWsyLSl2/Bo8j2Uik
 3lYyylTgTC6v49Aj1gTuIUUgq7Sgy073ZhOxGczpI3ld18jLPM1UkONxQjTxzsrp
 oCmeoG8BW1vfDLL5P/sCWjKy2bSGluq7/TZSJMAQeBjsdWGdNLrAI74rf6/RRs5A
 0UmkiUPO8yQZS+XQR/X/wLdlAHl8l3hUbp4z0p6WAXIF0vIf1uBcE3riiVXY/Abk
 3c2eQA==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qkpqx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:06:28 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-7c15deb3794so205173137.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 08:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793372788; x=1793977588; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=r8ca12Aw2UnLvMm0+mSYfBKBbI/qlVJsPAiVwYFMoMQ=;
 b=ZaMDK2zeZLUQHlfB70lsN2AfudR1GoBD6n+fKtzJXwsSLeE+m+O9Wb7GXWXBd2cBZH
 WiiKpEM3cuO/8RFnBbuz+tA3wRDabVqMrO0DSRz69kZESMnXUwZXuDfUfI1p99ieNP98
 WFWcuVcGqP6fovNi39wXAzk61JP15f/lE2D78Psv/MQQBj7KfHHYt8p5Frcub57BHJzZ
 IqgKGUMuG7iwSxeD6AH6JHSTwqrLPz6MfvbcxvOH+AGusogFvhtUXy5eQ6OJtl90JFpD
 elIEWTpOVGPcYB8Dd3B94GemEL1ntczOx6Qk4ZaCI6+x9iGf61DMDmnq8OlhIpz9n2jf
 tlfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793372788; x=1793977588;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=r8ca12Aw2UnLvMm0+mSYfBKBbI/qlVJsPAiVwYFMoMQ=;
 b=pHYR2aPLRWUwZKxCgJBYOkxwECSTaypsNJVzCiWekcq1yzwwqCcX5RlwrWj6NFL1yb
 oDFkYc8CNex9HB8OJHuItXSFsVAeoqajHiUm2uvAN2x24O8CVwmw0G2kP4zQSFiM+mvU
 72Xa76wfee/n1GhyOxcVEYaAtGXEXTG2zsouAVxyCDGEq8Qk56ZBPy/7hYrqAZQ8mvPH
 adq2jR5EBkg101gwjbIghV+K37sOtB0xtReRv0ghTzHZg7qVfI6Gb3rvrNFabeIR8Ns6
 cuu0pfjaBEYElctpXfE2cxK3oxZHQYbNWKijyLfYa9Ahaxoj2lwQKkwm76m+2fBVEw6Y
 mxYg==
X-Gm-Message-State: AFq9FYIaf8AkHdyIaH0e9hpAjCQC8ehdOPU11PN4wlMLxKlDdrl8+5LH
 mRLv1Ec6MA+s1J8YYqXMq0iV1elV70h0OCQ5L6OhwhEUc9UwSaup94CKBV7ZPMPoRSMmDCPKVQg
 brORz+WtJPyRj5ffOTQ8H7AYf1it1pviq9KdN4QgZ3y2MaDxDksOPE1itwM13QGEbsTVW
X-Gm-Gg: AYBFou1LQa/P3E2kgOBqC282L+gv8JatsY58CF3LChjOfsJLUQQQ/oW9txUl76BfWWj
 ytRiggsDjCZos3oT+tN1VMn3HeqQ85Y0U6atsT0kGttXvqjfv7jk3I3kaFZIe7k+RCGNxhRF86u
 ZKa26IB42QJRocSLBo2p7ka/87mAYydiAxdgb9vcCD+xp2k2aNdNYn0PDSS6Ik9Ghc4vl8Qk4ne
 741tRX6cFTO8IR+6gGe+81ebrPswXSDFYpITRReLecwjAfWRd+0j7AcC0GIMZvXsm/rB6dkR8X2
 Mgf8uqCATXQUeoVwOweSkaJ+WNf3YMxRPRfLf3HMtC6696/HRSDaOq7fy1dF0YICVfP3iLc+EzW
 Ak+CGsTDqO+wh1qvlbjXd08cBc494qx195C/HND92Ia+RHuL32pjus9BMhMRtqXq7fsV9PmY5c6
 YfYjJgT9422Yr6V1SFJ5Wnj4AeaWJcEw==
X-Received: by 2002:a05:6102:5811:b0:7cc:2c29:54f0 with SMTP id
 ada2fe7eead31-7d072238fbamr1209242137.4.1793372787469; 
 Fri, 30 Oct 2026 08:06:27 -0700 (PDT)
X-Received: by 2002:a05:6102:5811:b0:7cc:2c29:54f0 with SMTP id
 ada2fe7eead31-7d072238fbamr1209180137.4.1793372786770; 
 Fri, 30 Oct 2026 08:06:26 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac09ad35fdsm42480525e9.2.2026.10.30.08.06.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 08:06:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 31/31] tests/tcg/mips: Add MSA load/store tests
Date: Fri, 30 Oct 2026 16:02:01 +0100
Message-ID: <20261030150202.61556-32-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030150202.61556-1-philmd@oss.qualcomm.com>
References: <20261030150202.61556-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: kROKj0ChmHJWk5DWD6JLmPf0xa1YHT5w
X-Authority-Analysis: v=2.4 cv=KLzPn1Fo c=1 sm=1 tr=0 ts=6ae4b274 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=31ySfBESk6nFzokIpWYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA2MCBTYWx0ZWRfX0uSrrBpbIjNM
 V1CICsJMurjCvLJoh2N3a3+7uDL07K+3F3jnHzO81hRBmzzkt7Iol1L/vukWUd7VW1osOhXf0lR
 V3OM4QhJlXXNh7dsPf4L5JttLw30b66eJ7h9FmLgUUq38KJ2F/N6MKl21gmmtBqL2ZNyviOJhsG
 QBu9heB/Ju+W/Bi8tN1K1avhpMR4OqiIfT9cYURr75AdDxESHI8IeXcaxoN/t3qDsTgnNdHoaTk
 2ZUw3X178BG6vpbgRIvdTbF6dWEISgQI1D61NE0/+ZNBxpOkqsUSgScM4bzy/tmATHbOLXlPQS9
 yGGYVgZOxAqIDf5Dehtu7+Rjg5Mfmjm6lk8pkkVL06cnlIOcxSWuRgah6Vu0mJ2CQSeeqAqFbG5
 6RRPc4ANgsQxa09xi+RDaCh24KqCU6VLFL3FOPTR70aWyDVVXKXPH7sqSgM5ZGkd7ArJbOddAlj
 McvkE+63erYOIeUlWFg==
X-Proofpoint-ORIG-GUID: kROKj0ChmHJWk5DWD6JLmPf0xa1YHT5w
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA2MCBTYWx0ZWRfX9jBuJm/0JkvQ
 mwlJveLGmOb+x/njxW/nodu7yLsSzV7uuB/t190rR+zPoe5jz/Tw8n1gnKTi+38c7qfPu+u09IA
 fD8c1lCmpwhR+1BePuhLJ6S/+eICcmE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300060
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add coverage for the MSA LD/ST.B/H/W/D instructions at every source
and destination byte offset within a vector-sized block, including
accesses that cross a page boundary. Verify per-element endian
ordering, destination contents, and source register preservation.

Test both little-endian (P5600, MIPS32R5) and big-endian
(I6400, MIPS64R6).

AI-used-for: tests
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
Since this is a TCG test ran under linux-user, ignore checkpatch:

  ERROR: use qemu_real_host_page_size() instead of sysconf(_SC_PAGESIZE)
  #138: FILE: tests/tcg/mips/test_msa_load_store.c:110:
  +    long page_size = sysconf(_SC_PAGESIZE);
---
 tests/tcg/mips/test_msa_load_store.c | 163 +++++++++++++++++++++++++++
 tests/tcg/mips/meson.build           |   1 +
 2 files changed, 164 insertions(+)
 create mode 100644 tests/tcg/mips/test_msa_load_store.c

diff --git a/tests/tcg/mips/test_msa_load_store.c b/tests/tcg/mips/test_msa_load_store.c
new file mode 100644
index 000000000000..a3c8f4a8aa89
--- /dev/null
+++ b/tests/tcg/mips/test_msa_load_store.c
@@ -0,0 +1,163 @@
+/*
+ * MIPS MSA tests: Load / Store instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <unistd.h>
+
+#include "../include/tap.h"
+
+enum {
+    VECTOR_BYTES = 16,
+    BUFFER_BYTES = 64,
+};
+
+#define DEFINE_MSA_COPY(format)                                          \
+static void copy_##format(const uint8_t *source, uint8_t *destination,    \
+                          uint8_t *loaded, uint8_t *after_store)         \
+{                                                                       \
+    __asm__ volatile(                                                   \
+        "ld." #format " $w0, 0(%[source])\n\t"                          \
+        "st.b $w0, 0(%[loaded])\n\t"                                    \
+        "st." #format " $w0, 0(%[destination])\n\t"                     \
+        "st.b $w0, 0(%[after_store])\n\t"                               \
+        :                                                               \
+        : [source] "r" (source), [destination] "r" (destination),         \
+          [loaded] "r" (loaded), [after_store] "r" (after_store)          \
+        : "f0", "memory");                                             \
+}
+
+DEFINE_MSA_COPY(b)
+DEFINE_MSA_COPY(h)
+DEFINE_MSA_COPY(w)
+DEFINE_MSA_COPY(d)
+
+typedef void (*MsaCopy)(const uint8_t *source, uint8_t *destination,
+                        uint8_t *loaded, uint8_t *after_store);
+
+static const struct {
+    const char *name;
+    unsigned element_bytes;
+    MsaCopy copy;
+} formats[] = {
+    { "b", 1, copy_b },
+    { "h", 2, copy_h },
+    { "w", 4, copy_w },
+    { "d", 8, copy_d },
+};
+
+static bool check_format(size_t format_index, const uint8_t *source,
+                         uint8_t *destination, size_t first_offset,
+                         const char *region)
+{
+    _Alignas(VECTOR_BYTES) uint8_t loaded[VECTOR_BYTES];
+    _Alignas(VECTOR_BYTES) uint8_t after_store[VECTOR_BYTES];
+    uint8_t expected_vector[VECTOR_BYTES];
+    uint8_t expected_memory[BUFFER_BYTES];
+    const uint16_t endian_probe = 1;
+    unsigned endian_mask = *(const uint8_t *)&endian_probe ? 0 :
+                           formats[format_index].element_bytes - 1;
+
+    for (size_t source_offset = first_offset;
+         source_offset < first_offset + VECTOR_BYTES; source_offset++) {
+        for (size_t destination_offset = first_offset;
+             destination_offset < first_offset + VECTOR_BYTES;
+             destination_offset++) {
+            memset(destination, 0xa5, BUFFER_BYTES);
+            memset(expected_memory, 0xa5, BUFFER_BYTES);
+            memcpy(expected_memory + destination_offset,
+                   source + source_offset, VECTOR_BYTES);
+
+            for (size_t byte = 0; byte < VECTOR_BYTES; byte++) {
+                expected_vector[byte] =
+                    source[source_offset + (byte ^ endian_mask)];
+            }
+
+            formats[format_index].copy(source + source_offset,
+                                      destination + destination_offset,
+                                      loaded, after_store);
+
+            if (memcmp(loaded, expected_vector, VECTOR_BYTES)) {
+                fprintf(stderr, "ld.%s endian mismatch (%s, offset %zu)\n",
+                        formats[format_index].name, region, source_offset);
+                return false;
+            }
+            if (memcmp(destination, expected_memory, BUFFER_BYTES)) {
+                fprintf(stderr, "st.%s memory mismatch (%s, offset %zu)\n",
+                        formats[format_index].name, region,
+                        destination_offset);
+                return false;
+            }
+            if (memcmp(after_store, loaded, VECTOR_BYTES)) {
+                fprintf(stderr, "st.%s changed its source register (%s)\n",
+                        formats[format_index].name, region);
+                return false;
+            }
+        }
+    }
+
+    return true;
+}
+
+int main(void)
+{
+    _Alignas(VECTOR_BYTES) uint8_t source[BUFFER_BYTES];
+    _Alignas(VECTOR_BYTES) uint8_t destination[BUFFER_BYTES];
+    long page_size = sysconf(_SC_PAGESIZE);
+    size_t mapping_bytes;
+    uint8_t *source_mapping;
+    uint8_t *destination_mapping;
+    uint8_t *page_source;
+    uint8_t *page_destination;
+
+    if (page_size < BUFFER_BYTES) {
+        fprintf(stderr, "Invalid guest page size: %ld\n", page_size);
+        return 1;
+    }
+    mapping_bytes = 4 * (size_t)page_size;
+    source_mapping = mmap(NULL, mapping_bytes, PROT_NONE,
+                          MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+    destination_mapping = mmap(NULL, mapping_bytes, PROT_NONE,
+                               MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+    if (source_mapping == MAP_FAILED || destination_mapping == MAP_FAILED) {
+        perror("mmap");
+        return 1;
+    }
+    if (mprotect(source_mapping + page_size, 2 * page_size,
+                 PROT_READ | PROT_WRITE) != 0 ||
+        mprotect(destination_mapping + page_size, 2 * page_size,
+                 PROT_READ | PROT_WRITE) != 0) {
+        perror("mprotect");
+        return 1;
+    }
+
+    page_source = source_mapping + 2 * page_size - BUFFER_BYTES / 2;
+    page_destination = destination_mapping + 2 * page_size - BUFFER_BYTES / 2;
+    for (size_t byte = 0; byte < BUFFER_BYTES; byte++) {
+        source[byte] = page_source[byte] = byte * 13 + 7;
+    }
+
+    TAP_START();
+    for (size_t format_index = 0;
+         format_index < sizeof(formats) / sizeof(formats[0]); format_index++) {
+        bool passed = check_format(format_index, source, destination, 0,
+                                   "buffer") &&
+                      check_format(format_index, page_source, page_destination,
+                                   VECTOR_BYTES, "page boundary");
+
+        tap_report(passed, "MSA ld/st.%s", formats[format_index].name);
+    }
+
+    if (munmap(source_mapping, mapping_bytes) != 0 ||
+        munmap(destination_mapping, mapping_bytes) != 0) {
+        perror("munmap");
+        return 1;
+    }
+    return tap_done();
+}
diff --git a/tests/tcg/mips/meson.build b/tests/tcg/mips/meson.build
index 560d07ad6357..179502504582 100644
--- a/tests/tcg/mips/meson.build
+++ b/tests/tcg/mips/meson.build
@@ -16,6 +16,7 @@ tests_mips_msa_groups = [
   '../mips/test_msa_int_multiply.c',
   '../mips/test_msa_int_subtract.c',
   '../mips/test_msa_interleave.c',
+  '../mips/test_msa_load_store.c',
   '../mips/test_msa_logic.c',
   '../mips/test_msa_pack.c',
   '../mips/test_msa_shift.c',
-- 
2.55.0


