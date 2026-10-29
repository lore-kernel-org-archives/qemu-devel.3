Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD21606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ph372eMO;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZxthFZaH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMTuG-0001jj-VY; Thu, 29 Oct 2026 13:27:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTuD-0001aJ-4v
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:27:13 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTuA-0001br-GL
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:27:12 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGDJp71654959
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:27:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 i5uE0eFki2i6qSrdLfpOixMmCN+bNctm+O5ds23TV1M=; b=ph372eMOlI3RIvJm
 ZFxSGLmRihjEzjBTfBAFyMyEn5Si/Yg08aiO6fhlfZSyxifRQuLqeuLb6XlXCSxW
 rjownaO2epy2lmXGUMnHaNZWB65xSO4zpKkK92p2q9TpQD382o82OHjP9Y3gnWx/
 y7mTQRxpYzttzL0GiyrS6BM3QNg2Hv1xzpvNrfrhG9+mVW4LydoPcGGHduKGJUc2
 vNXOYVqPGGL4h5rdiJluyDpwgeTzPpJLb7AMppFt1zWbcbwd8KozUPGPDmhVnBeD
 ZDkYuWw7jjVimxdGlUwCrJTAhqHrGB++7qnb+ZkOxyHqZRWkbjZjd0I/gt7ovCSN
 5HhXMw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm4a21sv6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:27:09 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93ecdc701a2so282184385a.3
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 10:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793294828; x=1793899628; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=i5uE0eFki2i6qSrdLfpOixMmCN+bNctm+O5ds23TV1M=;
 b=ZxthFZaHdbeiWymBspxN+yjFonbQULEsk9t5kjME9ArqXslqHw014bV0MR1mMsE+Ww
 /O8mPLq7KNLlJfPyqjIUz0xw7jVC9tdeEZ+ZFV1s0/GHxIIFh1/qTaKucPmjS+WJM7qE
 +pS3SAT6VBUhUyoDHjWIem6DfZS1BIgFz3bA4z39wIJZzqr/24xgRDn/r2QpROMXXjTt
 8ZTDk/0JMrfD84zLdArOSdUcE7/p53AFkxD4oJ/tPM71ViunFIWXmfZHWxGDcm4calNg
 WFkSM6ycmUND/YBMPBk+nCwE5jhoABwIJfLzp0/N8MH0GuFwF9llk9/8eNx1cJYopZan
 ppfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793294828; x=1793899628;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=i5uE0eFki2i6qSrdLfpOixMmCN+bNctm+O5ds23TV1M=;
 b=fhYRJ5iUZ+vRPhux7EwZoD46Xuw9fW1Nzd45FTGs8Kstmlq1MnZIzbpqgGJZ7Bgw6I
 XqFB6R74/6ZtKSNO3Th/Tqxdh1A3/H74rmG2/RUQRpQXNI7QoP7k6IJmdi7WpJgn8l/j
 Xf3U2tDkvzu8NlHTjSa26wzDMW01z1gCj/oGlZopWvsqCtkG0XpqzAO0r3o7ei7jl/UD
 Wuu71kdh46IjnAu4wSVTZ6mclEdR4Qt6leIQXrsbVrxQ6wSjR91p9RseNAizINOZMGFL
 mjO7sA35WP62TuSWdwG6OcaRB5P/ROEAPk7/qxcD4K28bcWr/ZbIBvHPevvvjxeBeTvQ
 shJA==
X-Gm-Message-State: AFq9FYLSBQItvJpUogPQdNZco9PLW70R4JKTDXIvrNirdkdbUJoof/Cl
 wF8wjiJrkJizQxZ6VLigwZKNSp9TJgdqBe9QJ5hwiySz0qss0zWj++567VvQ49d4VPH/h0shR6+
 k6e4LBDSo9k6YEQFtaEaCgOK9MowKiZHQP+K4tNiKhTd9Kot2szqVJpGpU24nWaRNYBFu
X-Gm-Gg: AYBFou2fBWWDw9PGqsmIR4MOR11HIX3FXmtFPRps2OgvJXGNQHde/jcgY532EXp9Mg7
 8ZXUH42+dcBFq5fVBWFCjiDfSWQsvhynT9DaOQPWjsgD9CiwI9B3Puj//CU87JFKqIY2zmpLxZE
 udOrOb/RdEePWipyLRQvJEJmJwqBA1BfZiSN++vg0NjEPXk1Xq7BCs2QXRGNwBZ5WAzg1CzmsRM
 3XGSC66irwzbmugZa8zOOj7hexnmRunoopD3KxrQcvRRfyKzndy6a99Oarqn5nDTpXOqZRiTQ9Y
 wNUqPXt18orF+0c34ZHM5XMOYrrrH8/gYc+ATKt5PfpCXelmYakE+nEar9Smo60sos52yMr5pAf
 ZWQ3680rzY3GmU7L2mxI8bSryPncvZ7+7ytrdF8zbF7Brasof8M/qGDKA9BPIK0+BpR8TOuhCK1
 vT70uZ6dOnyscYZdM=
X-Received: by 2002:a05:620a:4106:b0:93f:211b:a7a with SMTP id
 af79cd13be357-94408a72577mr963926185a.29.1793294827950; 
 Thu, 29 Oct 2026 10:27:07 -0700 (PDT)
X-Received: by 2002:a05:620a:4106:b0:93f:211b:a7a with SMTP id
 af79cd13be357-94408a72577mr963919685a.29.1793294827339; 
 Thu, 29 Oct 2026 10:27:07 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abebe33e79sm1694665e9.2.2026.10.29.10.27.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Oct 2026 10:27:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 31/31] tests/tcg/mips: Add MSA load/store tests
Date: Thu, 29 Oct 2026 18:23:15 +0100
Message-ID: <20261029172319.25766-32-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029172319.25766-1-philmd@oss.qualcomm.com>
References: <20261029172319.25766-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfX9nAvduCFyC09
 bRCq1UM1znbaYqOZJ2j1uzPS9HbL+hRQMRwjduOgSCTIoi276siN/IC0OlEjHYdQOcmnLR23uQJ
 JsucFEiQkSI8b9WsQ/rdfpSc6ZMgWzzmdEdtonZBjfq41xbASm1n6TYRDHhwiBr5VrWI1+ub5gk
 MdWkEAkxhbMMA0eUtb+4Bef7WRbMpnhiFmUclM11Hf5TMqM40vjiD30hM9Z8uMbFL7q+lzopkyQ
 SIj+RYIlmczzb7XsxtCN7+baoMMIJeW3iJ/dfyJtpVYAAV3xBL69pBggoLgLLzktGA5JD7HkkTq
 cZR13XQ3aUevRG7k50PwDaxw3+gdPWcf1Xh7VOdLCUkjM6HbjyvW/IY11g2GjfJa5iwywJ4KgfL
 SFrCikVNRM3FqUKGiERUUw2qXdDlZbz7hvvm8E7S6sp8FyUr9b8vV7rIGN1P9UVBnPTdfWuxK7p
 8zdzJSeXxzcPAPyHQag==
X-Authority-Analysis: v=2.4 cv=E8tYNqdl c=1 sm=1 tr=0 ts=6ae381ed cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=sM_VlAZ975ao-oRoPoUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfXzZMJp3p6J3jW
 UWawhE21sP8jGp/CwaMhdBbHC7PJJ1dBy5bBWEybG1CL2NxtN5POKrzi3iu45GSrvXgnyHYsTUN
 XdN8NrHQo4WQVAiIAPOe+tXdTrapgck=
X-Proofpoint-ORIG-GUID: 2pt5aAmtivH72_jSvUkrE4jemnZZJG3b
X-Proofpoint-GUID: 2pt5aAmtivH72_jSvUkrE4jemnZZJG3b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290068
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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
---
Since this is a TCG test ran under linux-user, ignore checkpatch:

  ERROR: use qemu_real_host_page_size() instead of sysconf(_SC_PAGESIZE)
  #138: FILE: tests/tcg/mips/test_msa_load_store.c:110:
  +    long page_size = sysconf(_SC_PAGESIZE);
---
 tests/tcg/mips/test_msa_load_store.c | 166 +++++++++++++++++++++++++++
 tests/tcg/mips64/meson.build         |   1 +
 tests/tcg/mipsel/meson.build         |   1 +
 3 files changed, 168 insertions(+)
 create mode 100644 tests/tcg/mips/test_msa_load_store.c

diff --git a/tests/tcg/mips/test_msa_load_store.c b/tests/tcg/mips/test_msa_load_store.c
new file mode 100644
index 000000000000..50e60bb44ff5
--- /dev/null
+++ b/tests/tcg/mips/test_msa_load_store.c
@@ -0,0 +1,166 @@
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
+    bool success = true;
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
+    printf("TAP version 14\n"
+           "1..%zu\n",
+           sizeof(formats) / sizeof(formats[0]));
+    for (size_t format_index = 0;
+         format_index < sizeof(formats) / sizeof(formats[0]); format_index++) {
+        bool passed = check_format(format_index, source, destination, 0,
+                                   "buffer") &&
+                      check_format(format_index, page_source, page_destination,
+                                   VECTOR_BYTES, "page boundary");
+
+        printf("%s %zu - MSA ld/st.%s\n", passed ? "ok" : "not ok",
+               format_index + 1, formats[format_index].name);
+        success &= passed;
+    }
+
+    if (munmap(source_mapping, mapping_bytes) != 0 ||
+        munmap(destination_mapping, mapping_bytes) != 0) {
+        perror("munmap");
+        return 1;
+    }
+    return success ? 0 : 1;
+}
diff --git a/tests/tcg/mips64/meson.build b/tests/tcg/mips64/meson.build
index d1d4bf6b5a24..f2e507a47d88 100644
--- a/tests/tcg/mips64/meson.build
+++ b/tests/tcg/mips64/meson.build
@@ -54,6 +54,7 @@ tests_mips_msa_groups = [
   '../mips/test_msa_int_multiply.c',
   '../mips/test_msa_int_subtract.c',
   '../mips/test_msa_interleave.c',
+  '../mips/test_msa_load_store.c',
   '../mips/test_msa_logic.c',
   '../mips/test_msa_pack.c',
   '../mips/test_msa_shift.c',
diff --git a/tests/tcg/mipsel/meson.build b/tests/tcg/mipsel/meson.build
index fcf764ea8df6..f2642e1b20f8 100644
--- a/tests/tcg/mipsel/meson.build
+++ b/tests/tcg/mipsel/meson.build
@@ -55,6 +55,7 @@ tests_mips_msa_groups = [
   '../mips/test_msa_int_multiply.c',
   '../mips/test_msa_int_subtract.c',
   '../mips/test_msa_interleave.c',
+  '../mips/test_msa_load_store.c',
   '../mips/test_msa_logic.c',
   '../mips/test_msa_pack.c',
   '../mips/test_msa_shift.c',
-- 
2.55.0


