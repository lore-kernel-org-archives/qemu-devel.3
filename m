Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD340606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 18:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Z2v5yjRH;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jCk7KZKb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMquZ-0004E6-B7; Fri, 30 Oct 2026 14:01:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqs9-00019u-UR
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:58:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqs7-0008Pd-Ry
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:58:37 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UHu2tF2414394
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:58:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +MyDPkZFnkC2V63+SpPR9axBurtzML6X5sZJvQlbQV8=; b=Z2v5yjRHVWbSWIt/
 2O90u70a+xIp+1O2RBxTBRJxJTbkZTdfAdd+jhIlURWCdWyeLJlXkISNvAz+8vR5
 Md0w4+tsXJJSRXisPJRPIZreS2y+fi6dZQN9viGTEWvtSKrkSZPTh0Hv4hRX3ViZ
 Xr2tL2Sb6kOOi0sx2Hnjj955ZQy8skNH+oaPSy2eLB6WWK+SX2m2rUovAiBWZT6w
 Id57dHabS2Dj+85iO/GCpBcdqYNXiyK9UfOqwp7rtIyR/uLkE4iBGMvggogbrYkR
 3f8Fw7ln5/A56KLgE3RGWstEFpDa+w6+wTFP83BzbdRGSX9nUfuS0gXbsMoLiWBL
 6TlRVg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6pmbn9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:58:33 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93e49a1d3b1so227626185a.2
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 10:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793383112; x=1793987912; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+MyDPkZFnkC2V63+SpPR9axBurtzML6X5sZJvQlbQV8=;
 b=jCk7KZKbT41J0cmkxiyrv0SpDuRgqNg9apQKtOd7kywAS2sofjyTNclaCh9b74x4dh
 TIBVOZZDJsPO222t6Qc9RsLIVyIq67UvZcjcJ1q1EA+OvmXizMrZse8Xtv7jV1pc+sni
 M5iYiNgQElnLqGED/mUFNUEKEwZnzeKopk9IgqT22RRVmDevP4tWAHBIWfTg8dXYetjg
 lwsv3KpHYF6ob1r86hnZZc5atl8pdoot+FuQ4b1snnBr8MBtGJkb6w6l8f+80Xj0BPqm
 sXmGhVG4pKq6KS1A8K5RXUVsqo1bpM615UgG3pmI6GH4b+MefujXHlUGfndMkb+ZxWJY
 sYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793383112; x=1793987912;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+MyDPkZFnkC2V63+SpPR9axBurtzML6X5sZJvQlbQV8=;
 b=FUEeTWfn6m2F6HhOCA8MPYWAB40Fog8RjF8c/2Y+w4SSA2abq+13gnC+ZGOT1BNHN+
 0RVIt+nZRfhaEFRVNIARIVlya18lhz09Lf32+Qs6a+cjIcB2jdjJ+42CRnsAFj0T2cQW
 apT1BhB6S5SUvCf1gMFTDnMhkSapaZuFtvwo7n9EF+HySe2pHlKsmlP4oiiRg9T34RRW
 9Gt5eGOahfIU8nTOQ+MW3/CV5tA4/5AD13tNY6zGuiHR6vtBBTJz02jDMIfmzHgOX0fr
 Gf/kVOvJPsBtT2DcyRFQ8XPoGMqYhlx2U6Tok0nfBSz2axfJSpY2O2VDVMkhLljL6IZR
 qmXQ==
X-Gm-Message-State: AFq9FYLQ8g6TVDY/QjCeflPyYarOK3OOMRL4jsCCFDBrHsu4aJ7Ulmad
 g/rAKe6y2MtIkkwdtZbrPEzMv6RMZo/FbSGVbjKKXBwNfdVnb7NLS8R43kRgII7j5kIlmyViE4Z
 gTGvNE+Uyok3h2KnwkTFjFyjIZmbg/Fv0/feXfAyHxQ7iB4Lw+HSo6l0+PPGSJa5cVWkU
X-Gm-Gg: AYBFou37F8qi6n3qsF8sj5BswPXs3CPOLBAxj0MVyF00Taqlh8XBCEQ3aiqwGmN7ID7
 z6t+f6PuaKEuN7MuQulnlojOHJ7tck243gH3skKps7tIHplRbnXDPNOthxRz+RbRl+R4LC+bMsN
 vNLrqPNRlRugqyhk56S4ycfY/B3xTBwsdgn1i1dR+sq1WI1sp0YupyeJdYqs5yc90OM5ieWQjGz
 cet+w8xSGKotV0GKYpBqnUdMHfDIc7qhsjOioC5PpqCFC2ZRgmvU+wwYSbV59HN1mkL2jNvO7W8
 +MRV03Ml5Cko5f+GMoWUtt1SepTozO5tDoV1V9e8kLSKWogJKAz/HCLP9eCV7pWliPW6pQ9pUS8
 dgMpfAGXITAtQ6NGOD86Iy/JGKYRIRbkrpMp65lihNvJq4YzFgZ14RHFoLKijbMtMqa/2m4mmon
 vbc3ulpY7MseRyzJdrfZC0osohvO3+Ug==
X-Received: by 2002:a05:620a:461e:b0:93f:707f:28d2 with SMTP id
 af79cd13be357-94421712d14mr521113785a.26.1793383112193; 
 Fri, 30 Oct 2026 10:58:32 -0700 (PDT)
X-Received: by 2002:a05:620a:461e:b0:93f:707f:28d2 with SMTP id
 af79cd13be357-94421712d14mr521110285a.26.1793383111701; 
 Fri, 30 Oct 2026 10:58:31 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa8213ead6sm149754045e9.14.2026.10.30.10.58.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 10:58:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v4 32/32] tests/tcg/mips: Add MSA load/store tests
Date: Fri, 30 Oct 2026 18:53:54 +0100
Message-ID: <20261030175357.99684-33-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030175357.99684-1-philmd@oss.qualcomm.com>
References: <20261030175357.99684-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfX5/VA0GiOTMyR
 Xp7YnnJTUdFbpuslI7L3eGulxGyvpmRTcKHZmaoxhJXNro2WQ23SkeQkiP6UQJBkGmXvOKKVUIk
 WV7vSnpr7xN6Max7VQcrj6iFUpEnGIEE7EFVUwpjd8kD1y3WJ0cV0DWWrMdf5mbVlMNqPENOVfx
 uQFgl1eRNvUQQi133niMt0i1+1PaDHUuI3+yrbaCHJTGzvHPb55jnMTVUm5//4ifYixoAYQZi94
 91RraxBXD/wz9axXBRRpmjoiBlbesKEHqrN3prXZEoZyYLkyr2tL8+rSKDqGGwU2wMT7Mw4A0fS
 IWtbGbGTUmIFHH1gSULB0sQYXukb2pLye2e1nN07UFiMMqzHVzjnHbpapsZhSDHY+uQfAJPvYXt
 bTZm7aBlddkGnFBdAJ82QQiqnDIVyXrG3vHlIJUEjqgVopOcGcG0AE3nx2nIn1TV7tuyda7CRop
 +vtijnwyCPhYdq1FRCA==
X-Proofpoint-ORIG-GUID: hvilZawSWm9ae7riHKqyxri4A6kLuo8B
X-Proofpoint-GUID: hvilZawSWm9ae7riHKqyxri4A6kLuo8B
X-Authority-Analysis: v=2.4 cv=AJ83otAg c=1 sm=1 tr=0 ts=6ae4dac9 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=kUBLggdYPbBL_tJofOAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfX6pxbu8dbyHbL
 5GxzvbWN2t+K3KDkt5Bc5nSlRWFQPJZ/T+A7tvcerHXX3seOb9ExYGnkYnMMHMpmN54vjqfhYkw
 i7kZFW5wbqRZkkRCVhwb191eA9YqRj0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300071
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
 tests/tcg/mips/test_msa_load_store.c | 168 +++++++++++++++++++++++++++
 tests/tcg/mips/meson.build           |   1 +
 2 files changed, 169 insertions(+)
 create mode 100644 tests/tcg/mips/test_msa_load_store.c

diff --git a/tests/tcg/mips/test_msa_load_store.c b/tests/tcg/mips/test_msa_load_store.c
new file mode 100644
index 000000000000..b0c9404f122d
--- /dev/null
+++ b/tests/tcg/mips/test_msa_load_store.c
@@ -0,0 +1,168 @@
+/*
+ * MIPS MSA tests: Load / Store instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <errno.h>
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
+                TAP_INFO("ld.%s endian mismatch (%s, offset %zu)",
+                         formats[format_index].name, region, source_offset);
+                return false;
+            }
+            if (memcmp(destination, expected_memory, BUFFER_BYTES)) {
+                TAP_INFO("st.%s memory mismatch (%s, offset %zu)",
+                         formats[format_index].name, region,
+                         destination_offset);
+                return false;
+            }
+            if (memcmp(after_store, loaded, VECTOR_BYTES)) {
+                TAP_INFO("st.%s changed its source register (%s)",
+                         formats[format_index].name, region);
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
+    TAP_START();
+    if (page_size < BUFFER_BYTES) {
+        TAP_INFO("Invalid guest page size: %ld", page_size);
+        tap_report(0, "MSA ld/st guest page size");
+        return tap_done();
+    }
+    mapping_bytes = 4 * (size_t)page_size;
+    source_mapping = mmap(NULL, mapping_bytes, PROT_NONE,
+                          MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+    destination_mapping = mmap(NULL, mapping_bytes, PROT_NONE,
+                               MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+    if (source_mapping == MAP_FAILED || destination_mapping == MAP_FAILED) {
+        TAP_INFO("mmap: %s", strerror(errno));
+        tap_report(0, "MSA ld/st mmap");
+        return tap_done();
+    }
+    if (mprotect(source_mapping + page_size, 2 * page_size,
+                 PROT_READ | PROT_WRITE) != 0 ||
+        mprotect(destination_mapping + page_size, 2 * page_size,
+                 PROT_READ | PROT_WRITE) != 0) {
+        TAP_INFO("mprotect: %s", strerror(errno));
+        tap_report(0, "MSA ld/st mprotect");
+        return tap_done();
+    }
+
+    page_source = source_mapping + 2 * page_size - BUFFER_BYTES / 2;
+    page_destination = destination_mapping + 2 * page_size - BUFFER_BYTES / 2;
+    for (size_t byte = 0; byte < BUFFER_BYTES; byte++) {
+        source[byte] = page_source[byte] = byte * 13 + 7;
+    }
+
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
+        TAP_INFO("munmap: %s", strerror(errno));
+        tap_report(0, "MSA ld/st munmap");
+        return tap_done();
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


