Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F214606A325
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 13:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cEhMyd+B
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUOT1-0002yo-NA; Fri, 20 Nov 2026 08:15:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andy0x48@linux.ibm.com>)
 id 1xUOSq-0002va-U4; Fri, 20 Nov 2026 08:15:41 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andy0x48@linux.ibm.com>)
 id 1xUOSl-00047a-Ko; Fri, 20 Nov 2026 08:15:40 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKAuGFI2878276; Fri, 20 Nov 2026 13:15:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=JMg30bX72SDfW+mv5
 VP87Mwncv9cuW75m9cCZyrMOCI=; b=cEhMyd+BebGkJ95IbXM9jMl4wMxw+SS64
 A/08L1eoT/EYn307zlBQP3oTaE0lE/DmD9iIyTqWixV97TeHg/qtDUcrl5kAcPbr
 9GEG5o0Daoz/5B11g3PWZv2Pq7z6yTGnRlR1AqLrmfhcrVLqxVvNsT3Rix4F9HO4
 Aem/UNYnwzerloNzx2SG+ty6u6OMSXf2EYCbDCl634snSEqfZGKexC5GUB2fFbMp
 EtsFK+s/4UcZ+eLbWMBw0Q3XqG0oBD2wFPlusnDnDyplooVi0cw5E7D8pyZAuUgh
 L1143UARJ+4+NraM5TCglLFmEe0rTA8hPcMfwlF0O/MduJ023Hzgw==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105tgmdy-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 20 Nov 2026 13:15:13 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKAo6ZC4130930; Fri, 20 Nov 2026 13:15:12 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j1v9xg6c3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Nov 2026 13:15:12 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6AKDF84x16187778
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Nov 2026 13:15:08 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 81BE92004B;
 Fri, 20 Nov 2026 13:15:08 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 06E7A20043;
 Fri, 20 Nov 2026 13:15:08 +0000 (GMT)
Received: from work.ibm.com (unknown [9.111.34.217])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 20 Nov 2026 13:15:07 +0000 (GMT)
From: Andrew Holden <andy0x48@linux.ibm.com>
To: qemu-devel@nongnu.org, iii@linux.ibm.com, freude@linux.ibm.com
Cc: qemu-s390x@nongnu.org, richard.henderson@linaro.org, david@kernel.org,
 cohuck@redhat.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 Andrew Holden <andy0x48@linux.ibm.com>
Subject: [PATCH v2 3/3] tests/s390x/tcg: Add cpacf clear key register update
 tests
Date: Fri, 20 Nov 2026 13:14:43 +0000
Message-ID: <20261120131443.61606-4-andy0x48@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261120131443.61606-1-andy0x48@linux.ibm.com>
References: <20261120131443.61606-1-andy0x48@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=IouL47/g c=1 sm=1 tr=0 ts=6b0047e1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=6nJg3aJDTxPY9Y2ND_MA:9
 a=4SvdModAI-hMThJV:21
X-Proofpoint-ORIG-GUID: 4G55qLmTMX5x0JHnJpMzrdC__2A1KTUI
X-Proofpoint-GUID: 4G55qLmTMX5x0JHnJpMzrdC__2A1KTUI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA1MSBTYWx0ZWRfX3VI+srWw/ZII
 Kk7vZDi2kT62Su+3KvR+xGOisl2tuV+3XCDZVPSucoM2aXWu/YbKiXku3hM4rRlvOlFVKZxPz0S
 UFlipsxaAF2axvpFMo4EsLIftrNHZAG05q8m75zrd7qmuLKSx128tGUzd43wWAPRnmZFm3ef8Aj
 4nIrR2t3cznE4c/3zjQzDQwlwVTV81LEhDV7L2/H19MbZdAUl4T2u/fPaWD/zhvHlHWgPFsFAaU
 ZjZCRAX7EVL0uTWmGRz73D4SvFe5FCxF3AHI0OnqLyNC6WNCqhPxnY1rWbSvhg/RQj/91Jlddal
 1GIeFEhVJPDL4siEvg/4r3RvYrnruTHcVYWPL9SDEVE4BWNBlcWnpXIFUAMahObQGNA+UAb1pAh
 4Icwtekftf7bCQunRWQFK5ErBAgkzqSkGJjh2usoJca1zztZmizXwMOOjhrW0di637RkAdSaj4B
 CiikaxM4Gi8u7/cMEWg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA1MSBTYWx0ZWRfXw//a6yUxMDpn
 gTkLCbTknmMbU5x8/DV0K+STYSGrq9BXMgeV7801S3aAndWEoubwg23+CKxn6LB/96Ch5WlJCSF
 DTixnZng1jZ/I4e6kB3bKMvyalmEo/E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200051
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=andy0x48@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Harald Freudenberger <freude@linux.ibm.com>

Add simple test cases for the 4 clear key cpacf implementation
functions cpacf_aes_ecb(), cpacf_aes_cbc(), cpacf_aes_ctr() and
cpacf_aes_xts() which shall test if the register update and memory
update during processing of data within the cpacf instruction (km,
kmc, kmctr) emulation is correct. See details about how the test cases
are designed and actually work testcase code. Note that as there is a
signal handler evaluating the registers on the enforced address
violation the cpacf.h inline function needs to use pinned registers.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Signed-off-by: Andrew Holden <andy0x48@linux.ibm.com>
---
 tests/tcg/s390x/cpacf-km-ecb-fault.c    | 368 +++++++++++++++++
 tests/tcg/s390x/cpacf-km-xts-fault.c    | 511 ++++++++++++++++++++++++
 tests/tcg/s390x/cpacf-kmc-cbc-fault.c   | 472 ++++++++++++++++++++++
 tests/tcg/s390x/cpacf-kmctr-ctr-fault.c | 414 +++++++++++++++++++
 tests/tcg/s390x/cpacf.h                 | 103 +++--
 tests/tcg/s390x/meson.build             |   4 +
 6 files changed, 1846 insertions(+), 26 deletions(-)
 create mode 100644 tests/tcg/s390x/cpacf-km-ecb-fault.c
 create mode 100644 tests/tcg/s390x/cpacf-km-xts-fault.c
 create mode 100644 tests/tcg/s390x/cpacf-kmc-cbc-fault.c
 create mode 100644 tests/tcg/s390x/cpacf-kmctr-ctr-fault.c

diff --git a/tests/tcg/s390x/cpacf-km-ecb-fault.c b/tests/tcg/s390x/cpacf-km-ecb-fault.c
new file mode 100644
index 0000000000..3fe7df1f04
--- /dev/null
+++ b/tests/tcg/s390x/cpacf-km-ecb-fault.c
@@ -0,0 +1,368 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Test for register update correctness in cpacf_aes_ecb (KM AES-128 ECB).
+ *
+ * All the CPACF instructions are designed in a way that on exit
+ * the registers are updated so that on incomplete processing (partial
+ * completion) the instruction can just be re-invoked. The QEMU emulation
+ * of the CPACF instructions needs to obey that rule as well.
+ * This testcase checks the correct update of the register values by
+ * triggering a page protection fault in the middle of the data. The
+ * signal handler then checks for the expected register values. After
+ * that the page is enabled for reading, causing the OS to restart the
+ * instruction which continues to process the remaining data. Finally
+ * the encryption result is checked to match the expectations.
+ *
+ * Test sequence:
+ *  1. Allocate two contiguous, page-aligned source pages filled with
+ *     pseudo-random data and two matching destination pages.
+ *  2. Reference run: encrypt both source pages with cpacf_km AES-128 ECB
+ *     into the reference destination buffer (no faults).
+ *  3. Fault run:
+ *     a. Protect the second source page (PROT_NONE).
+ *     b. Install a SIGSEGV handler.
+ *     c. Call cpacf_km over both pages (2 * PAGE_SIZE bytes).
+ *     d. On the SIGSEGV verify:
+ *          - si_addr lies within the second source page.
+ *          - R4 (src address) equals exactly the start of the second source
+ *            page (all blocks of page 1 were already consumed).
+ *          - R5 (remaining src length) equals exactly PAGE_SIZE.
+ *          - R2 (dst address) equals exactly dst_fault + PAGE_SIZE.
+ *     e. Restore PROT_READ on the second source page and return from the
+ *        handler so KM re-executes from the updated registers and finishes.
+ *  4. Compare the fault-run output to the reference output; they must match.
+ *
+ * cpacf_km() in cpacf.h uses pinned registers R2/R4/R5 for its operands,
+ * so the signal handler can read them reliably via ucontext_t.
+ *
+ * Usage: cpacf-km-ecb-fault [-v]
+ *   -v  verbose: print details about each step and every register check.
+ */
+
+#include <signal.h>
+#include <stdio.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <ucontext.h>
+#include <unistd.h>
+#include "cpacf.h"
+
+/* AES-128 key used for all encryptions in this test */
+static const uint8_t aes128key[16] = {
+    0xed, 0xfd, 0xb2, 0x57, 0xcb, 0x37, 0xcd, 0xf1,
+    0x82, 0xc5, 0x45, 0x5b, 0x0c, 0x0e, 0xfe, 0xbb
+};
+
+/* Page size, determined at runtime */
+static long page_size;
+
+/* Verbose flag: set by -v on the command line */
+static int verbose;
+
+/*
+ * State shared between main() and the SIGSEGV handler.
+ * volatile prevents the compiler from optimising away accesses.
+ */
+static volatile int           sigsegv_count; /* how many times handler fired */
+static volatile int           sigsegv_pass;  /* 1 = all register checks fine */
+static volatile unsigned long expected_src;  /* exact expected R4 value */
+static volatile unsigned long expected_dst;  /* exact expected R2 value */
+
+/*
+ * SIGSEGV handler.
+ *
+ * At fault time the KM instruction has already advanced its operand registers
+ * past all fully processed blocks. For the second-page fault:
+ *   R2 = dst_fault + PAGE_SIZE  (destination pointer into second output page)
+ *   R4 = src_pages + PAGE_SIZE  (source pointer at start of second source page)
+ *   R5 = PAGE_SIZE              (exactly one page of source data remaining)
+ * Note that this requires using the inline function cpacf_km() from cpacf.h
+ * which uses pinned registers for the parameters and this has to be in
+ * alignment with the code here.
+ *
+ * After verifying these values the handler restores read permission on the
+ * second source page and returns. The signal return mechanism re-executes
+ * the KM instruction from the updated register state, completing the run.
+ */
+static void sigsegv_handler(int sig, siginfo_t *si, void *uctx_arg)
+{
+    /*
+     * No printf within signal handler, but write() can be used. So this
+     * little sig_printf() macro is a replacement to fprintf(stderr, ...)
+     */
+#define sig_printf(...) do { \
+        char printfbuf[256]; \
+        int len = snprintf(printfbuf, sizeof(printfbuf), __VA_ARGS__); \
+        write(STDERR_FILENO, printfbuf, len); \
+    } while (0)
+
+    ucontext_t *uc = (ucontext_t *)uctx_arg;
+    unsigned long r2, r4, r5;
+    int pass = 1;
+
+    sigsegv_count++;
+
+    /*
+     * On s390x, glibc's mcontext_t exposes the GPRs as gregs[].
+     */
+    r2 = uc->uc_mcontext.gregs[2];  /* KM destination address register */
+    r4 = uc->uc_mcontext.gregs[4];  /* KM source address register      */
+    r5 = uc->uc_mcontext.gregs[5];  /* KM source length register       */
+
+    if (verbose) {
+        sig_printf("  SIGSEGV #%d: si_addr=0x%lx\n",
+                   sigsegv_count, (unsigned long)si->si_addr);
+        sig_printf("    R2 (dst addr):  0x%lx  (expected 0x%lx)\n",
+                   r2, expected_dst);
+        sig_printf("    R4 (src addr):  0x%lx  (expected 0x%lx)\n",
+                   r4, expected_src);
+        sig_printf("    R5 (src len):   0x%lx  (expected 0x%lx = PAGE_SIZE)\n",
+                   r5, (unsigned long)page_size);
+    }
+
+    /* R4 must point exactly to the start of the second source page */
+    if (r4 != expected_src) {
+        sig_printf("FAIL: R4 (src addr) = 0x%lx, expected 0x%lx\n",
+                   r4, expected_src);
+        pass = 0;
+    } else if (verbose) {
+        sig_printf("    R4 check: PASS\n");
+    }
+
+    /* R5 must equal exactly PAGE_SIZE (one full page remaining) */
+    if (r5 != (unsigned long)page_size) {
+        sig_printf("FAIL: R5 (src len) = 0x%lx, expected PAGE_SIZE = 0x%lx\n",
+                   r5, (unsigned long)page_size);
+        pass = 0;
+    } else if (verbose) {
+        sig_printf("    R5 check: PASS\n");
+    }
+
+    /* R2 must point exactly to dst_fault + PAGE_SIZE */
+    if (r2 != expected_dst) {
+        sig_printf("FAIL: R2 (dst addr) = 0x%lx, expected 0x%lx\n",
+                   r2, expected_dst);
+        pass = 0;
+    } else if (verbose) {
+        sig_printf("    R2 check: PASS\n");
+    }
+
+    sigsegv_pass = pass;
+
+    if (verbose) {
+        sig_printf("  restoring PROT_READ on page at 0x%lx, resuming KM\n",
+                   expected_src);
+    }
+
+    /* Restore read access so the restarted KM can read the second page */
+    mprotect((void *)expected_src, page_size, PROT_READ);
+
+#undef sig_printf
+}
+
+int main(int argc, char *argv[])
+{
+    struct sigaction sa, old_sa;
+    uint8_t *src_pages, *dst_ref, *dst_fault;
+    uint8_t param[16];       /* AES-128 parameter block (key only for ECB) */
+    unsigned long cc;
+    int rc = 0;
+
+    if (argc == 2 && strcmp(argv[1], "-v") == 0) {
+        verbose = 1;
+    } else if (argc > 1) {
+        fprintf(stderr, "usage: %s [-v]\n", argv[0]);
+        return EXIT_FAILURE;
+    }
+
+    page_size = getpagesize();
+
+    if (verbose) {
+        printf("page_size = %ld (0x%lx)\n", page_size, page_size);
+    }
+
+    /*
+     * Allocate two contiguous page-aligned source pages and fill them with
+     * a deterministic pseudo-random pattern so the test is reproducible.
+     */
+    src_pages = mmap(NULL, 2 * page_size, PROT_READ | PROT_WRITE,
+                     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+    if (src_pages == MAP_FAILED) {
+        perror("mmap src_pages");
+        return EXIT_FAILURE;
+    }
+    for (long i = 0; i < 2 * page_size; i++) {
+        src_pages[i] = (uint8_t)(i * 37 + 13);
+    }
+
+    /* Reference destination: two contiguous pages, initially zeroed */
+    dst_ref = mmap(NULL, 2 * page_size, PROT_READ | PROT_WRITE,
+                   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+    if (dst_ref == MAP_FAILED) {
+        perror("mmap dst_ref");
+        munmap(src_pages, 2 * page_size);
+        return EXIT_FAILURE;
+    }
+
+    /* Fault-run destination: two contiguous pages, initially zeroed */
+    dst_fault = mmap(NULL, 2 * page_size, PROT_READ | PROT_WRITE,
+                     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+    if (dst_fault == MAP_FAILED) {
+        perror("mmap dst_fault");
+        munmap(src_pages, 2 * page_size);
+        munmap(dst_ref,   2 * page_size);
+        return EXIT_FAILURE;
+    }
+
+    if (verbose) {
+        printf("src_pages: [0x%lx, 0x%lx)  page1=[0x%lx, 0x%lx)  page2=[0x%lx, 0x%lx)\n",
+               (unsigned long)src_pages,
+               (unsigned long)(src_pages + 2 * page_size),
+               (unsigned long)src_pages,
+               (unsigned long)(src_pages + page_size),
+               (unsigned long)(src_pages + page_size),
+               (unsigned long)(src_pages + 2 * page_size));
+        printf("dst_ref:   [0x%lx, 0x%lx)\n",
+               (unsigned long)dst_ref,
+               (unsigned long)(dst_ref + 2 * page_size));
+        printf("dst_fault: [0x%lx, 0x%lx)\n",
+               (unsigned long)dst_fault,
+               (unsigned long)(dst_fault + 2 * page_size));
+    }
+
+    /* ------------------------------------------------------------------ */
+    /* Reference run: encrypt both pages with no fault injection.         */
+    /* ------------------------------------------------------------------ */
+
+    if (verbose) {
+        printf("reference run: cpacf_km AES-128 ECB over 2 pages (no faults)\n");
+    }
+
+    memcpy(param, aes128key, sizeof(aes128key));
+    cpacf_km(CPACF_KM_AES_128, param, dst_ref, src_pages, 2 * page_size, &cc);
+    if (cc != 0) {
+        fprintf(stderr, "FAIL: reference run unexpected cc=%lu\n", cc);
+        rc = 1;
+        goto out;
+    }
+
+    if (verbose) {
+        printf("reference run: done, cc=0\n");
+    }
+
+    /* ------------------------------------------------------------------ */
+    /* Fault run: protect second source page, run KM over both pages.     */
+    /* ------------------------------------------------------------------ */
+
+    /* Record the exact register values we expect at fault time */
+    expected_src = (unsigned long)(src_pages + page_size);
+    expected_dst = (unsigned long)(dst_fault + page_size);
+    sigsegv_count = 0;
+    sigsegv_pass  = 1;   /* handler sets to 0 on any check failure */
+
+    if (verbose) {
+        printf("fault run: expecting SIGSEGV when KM reaches src page2 at 0x%lx\n",
+               expected_src);
+        printf("fault run: expected register state at fault:\n");
+        printf("  R2 (dst addr) = 0x%lx\n", expected_dst);
+        printf("  R4 (src addr) = 0x%lx\n", expected_src);
+        printf("  R5 (src len)  = 0x%lx\n", (unsigned long)page_size);
+    }
+
+    /* Install SIGSEGV handler */
+    memset(&sa, 0, sizeof(sa));
+    sa.sa_sigaction = sigsegv_handler;
+    sa.sa_flags     = SA_SIGINFO;
+    sigemptyset(&sa.sa_mask);
+    if (sigaction(SIGSEGV, &sa, &old_sa) != 0) {
+        perror("sigaction");
+        rc = 1;
+        goto out;
+    }
+
+    /* Protect the second source page to provoke a fault during KM */
+    if (mprotect(src_pages + page_size, page_size, PROT_NONE) != 0) {
+        perror("mprotect PROT_NONE");
+        sigaction(SIGSEGV, &old_sa, NULL);
+        rc = 1;
+        goto out;
+    }
+
+    if (verbose) {
+        printf("fault run: second src page protected, starting cpacf_km\n");
+    }
+
+    /*
+     * Encrypt both pages with a single cpacf_km call.
+     *
+     * The first PAGE_SIZE bytes (page 1) are processed normally; the
+     * registers are advanced block-by-block inside cpacf_aes_ecb. On the
+     * first read of the second source page the CPU takes a protection fault.
+     * The signal handler verifies R2/R4/R5 and restores PROT_READ. On
+     * return from the handler the KM instruction is restarted with the
+     * already-advanced registers so it processes only the second page and
+     * completes with CC=0.
+     *
+     * The brc 1,0b loop inside cpacf_km handles the unrelated CC=3
+     * (partial-completion) case and is not triggered by the page fault.
+     */
+    memcpy(param, aes128key, sizeof(aes128key));
+    cpacf_km(CPACF_KM_AES_128, param, dst_fault, src_pages, 2 * page_size, &cc);
+
+    /* Restore the original SIGSEGV disposition */
+    sigaction(SIGSEGV, &old_sa, NULL);
+
+    if (verbose) {
+        printf("fault run: cpacf_km returned, cc=%lu, SIGSEGV count=%d\n",
+               cc, sigsegv_count);
+    }
+
+    if (cc != 0) {
+        fprintf(stderr, "FAIL: fault run unexpected cc=%lu\n", cc);
+        rc = 1;
+    }
+
+    /* ------------------------------------------------------------------ */
+    /* Verify: signal handler must have fired exactly once.               */
+    /* ------------------------------------------------------------------ */
+    if (sigsegv_count != 1) {
+        fprintf(stderr, "FAIL: expected 1 SIGSEGV, got %d\n", sigsegv_count);
+        rc = 1;
+    } else if (verbose) {
+        printf("check: SIGSEGV count = %d (expected 1): PASS\n", sigsegv_count);
+    }
+
+    /* ------------------------------------------------------------------ */
+    /* Verify: register values inside the handler were correct.           */
+    /* ------------------------------------------------------------------ */
+    if (!sigsegv_pass) {
+        fprintf(stderr, "FAIL: register value check in SIGSEGV handler failed\n");
+        rc = 1;
+    } else if (verbose) {
+        printf("check: register values in SIGSEGV handler: PASS\n");
+    }
+
+    /* ------------------------------------------------------------------ */
+    /* Verify: fault-run ciphertext matches the reference ciphertext.     */
+    /* ------------------------------------------------------------------ */
+    if (memcmp(dst_ref, dst_fault, 2 * page_size) != 0) {
+        fprintf(stderr, "FAIL: fault-run ciphertext does not match reference\n");
+        rc = 1;
+    } else if (verbose) {
+        printf("check: fault-run ciphertext matches reference ciphertext: PASS\n");
+    }
+
+    if (rc == 0) {
+        printf("cpacf-km-ecb-fault: all checks passed\n");
+    }
+
+out:
+    munmap(src_pages, 2 * page_size);
+    munmap(dst_ref,   2 * page_size);
+    munmap(dst_fault, 2 * page_size);
+
+    return rc ? EXIT_FAILURE : EXIT_SUCCESS;
+}
diff --git a/tests/tcg/s390x/cpacf-km-xts-fault.c b/tests/tcg/s390x/cpacf-km-xts-fault.c
new file mode 100644
index 0000000000..1d0e70f910
--- /dev/null
+++ b/tests/tcg/s390x/cpacf-km-xts-fault.c
@@ -0,0 +1,511 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Test for register and tweak update correctness in cpacf_aes_xts
+ * (KM AES-128 XTS).
+ *
+ * All the CPACF instructions are designed in a way that on exit
+ * the registers and associated memory (like a running XTS tweak) are
+ * updated so that on incomplete processing (partial completion) the
+ * instruction can just be re-invoked. The QEMU emulation of the CPACF
+ * instructions needs to obey that rule as well.
+ * This testcase checks the correct update of the register values and
+ * tweak in memory by triggering a page protection fault in the middle
+ * of the data. The signal handler then checks for the expected register
+ * and memory values. After that the page is enabled for reading,
+ * causing the OS to restart the instruction which continues to process
+ * the remaining data. Finally the encryption result is checked to
+ * match the expectations.
+ *
+ * Test sequence:
+ *  1. Allocate two contiguous, page-aligned source pages filled with
+ *     pseudo-random data and two matching destination pages.
+ *  2. Compute the initial XTS tweak value by encrypting a sector number
+ *     block with key2 using plain AES-128 ECB (as specified by XTS-AES).
+ *  3. Reference run - two steps to capture the intermediate tweak:
+ *     a. Encrypt page 1 only with cpacf_km KM_XTS_128 into dst_ref.
+ *        After this call param_ref[16..31] contains the running tweak for
+ *        the first block of page 2. Save this as expected_tweak[].
+ *     b. Encrypt page 2 with the same parameter block (tweak already
+ *        advanced) into dst_ref + PAGE_SIZE.
+ *  4. Fault run:
+ *     a. Protect the second source page (PROT_NONE).
+ *     b. Install a SIGSEGV handler.
+ *     c. Call cpacf_km with KM_XTS_128 over both pages in one shot.
+ *     d. On the SIGSEGV verify:
+ *          - R4 (src address) equals exactly the start of the second source
+ *            page (all blocks of page 1 were already consumed).
+ *          - R5 (remaining src length) equals exactly PAGE_SIZE.
+ *          - R2 (dst address) equals exactly dst_fault + PAGE_SIZE.
+ *          - param_fault[16..31] equals expected_tweak[], proving that
+ *            cpacf_aes_xts wrote the correct advanced tweak back into the
+ *            parameter block before the fault.
+ *     e. Restore PROT_READ on the second source page and return from the
+ *        handler so KM re-executes from the updated registers and tweak,
+ *        finishing the second page.
+ *  5. Compare the fault-run output to the reference output; they must match.
+ *
+ * cpacf_km() in cpacf.h uses pinned registers R2/R4/R5 for its operands,
+ * so the signal handler can read them reliably via ucontext_t.
+ *
+ * Usage: cpacf-km-xts-fault [-v]
+ *   -v  verbose: print details about each step and every check.
+ */
+
+#include <signal.h>
+#include <stdio.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <ucontext.h>
+#include <unistd.h>
+#include "cpacf.h"
+
+#define AES_BLOCK_SIZE  16
+
+/*
+ * XTS-128 uses two AES-128 keys.
+ *   key1 is used to encrypt/decrypt the data blocks.
+ *   key2 is used once to derive the initial tweak from the sector number.
+ */
+static const uint8_t xts128key1[16] = {
+    0xa1, 0xb9, 0x0c, 0xba, 0x3f, 0x06, 0xac, 0x35,
+    0x3b, 0x2c, 0x34, 0x38, 0x76, 0x08, 0x17, 0x62
+};
+static const uint8_t xts128key2[16] = {
+    0x09, 0x09, 0x23, 0x02, 0x6e, 0x91, 0x77, 0x18,
+    0x15, 0xf2, 0x9d, 0xab, 0x01, 0x93, 0x2f, 0x2f
+};
+/* Sector number block used to derive the initial tweak */
+static const uint8_t xts128sect[16] = {
+    0x4f, 0xae, 0xf7, 0x11, 0x7c, 0xda, 0x59, 0xc6,
+    0x6e, 0x4b, 0x92, 0x01, 0x3e, 0x76, 0x8a, 0xd5
+};
+
+/* Page size, determined at runtime */
+static long page_size;
+
+/* Verbose flag: set by -v on the command line */
+static int verbose;
+
+/*
+ * State shared between main() and the SIGSEGV handler.
+ * volatile prevents the compiler from optimising away accesses.
+ */
+static volatile int           sigsegv_count; /* how many times handler fired */
+static volatile int           sigsegv_pass;  /* 1 = all checks passed */
+static volatile unsigned long expected_src;  /* exact expected R4 value */
+static volatile unsigned long expected_dst;  /* exact expected R2 value */
+static volatile uint8_t *fault_param;        /* param block used in fault run */
+static uint8_t           expected_tweak[AES_BLOCK_SIZE]; /* tweak after pg 1 */
+
+/*
+ * SIGSEGV handler.
+ *
+ * At fault time the KM instruction has already processed all blocks of the
+ * first source page and updated registers and parameter block accordingly.
+ * For the second-page fault:
+ *   R2 = dst_fault + PAGE_SIZE   (destination pointer into second output page)
+ *   R4 = src_pages + PAGE_SIZE   (src pointer at start of second source page)
+ *   R5 = PAGE_SIZE               (exactly one page of source data remaining)
+ *   fault_param[keysize..keysize+15] = tweak for first block of page 2
+ *
+ * After verifying these values the handler restores read permission on the
+ * second source page and returns. The signal return mechanism re-executes
+ * the KM instruction from the updated register state and tweak, completing
+ * the second page.
+ */
+static void sigsegv_handler(int sig, siginfo_t *si, void *uctx_arg)
+{
+    /*
+     * No printf within signal handler, but write() can be used. So this
+     * little sig_printf() macro is a replacement to fprintf(stderr, ...)
+     */
+#define sig_printf(...) do { \
+        char printfbuf[256]; \
+        int len = snprintf(printfbuf, sizeof(printfbuf), __VA_ARGS__); \
+        write(STDERR_FILENO, printfbuf, len); \
+    } while (0)
+
+    ucontext_t *uc = (ucontext_t *)uctx_arg;
+    unsigned long r2, r4, r5;
+    int pass = 1;
+
+    sigsegv_count++;
+
+    /*
+     * On s390x, glibc's mcontext_t exposes the GPRs as gregs[].
+     */
+    r2 = uc->uc_mcontext.gregs[2];  /* KM destination address register */
+    r4 = uc->uc_mcontext.gregs[4];  /* KM source address register      */
+    r5 = uc->uc_mcontext.gregs[5];  /* KM source length register       */
+
+    if (verbose) {
+        sig_printf("  SIGSEGV #%d: si_addr=0x%lx\n",
+                   sigsegv_count, (unsigned long)si->si_addr);
+        sig_printf("    R2 (dst addr):  0x%lx  (expected 0x%lx)\n",
+                   r2, expected_dst);
+        sig_printf("    R4 (src addr):  0x%lx  (expected 0x%lx)\n",
+                   r4, expected_src);
+        sig_printf("    R5 (src len):   0x%lx  (expected 0x%lx = PAGE_SIZE)\n",
+                   r5, (unsigned long)page_size);
+        /* tweak is at param[keysize..keysize+15]; keysize=16 for XTS-128 */
+        sig_printf("    tweak in param block: ");
+        for (int i = 0; i < AES_BLOCK_SIZE; i++) {
+            sig_printf("%02x", ((uint8_t *)fault_param)[AES_BLOCK_SIZE + i]);
+        }
+        sig_printf("\n");
+        sig_printf("    expected tweak:       ");
+        for (int i = 0; i < AES_BLOCK_SIZE; i++) {
+            sig_printf("%02x", expected_tweak[i]);
+        }
+        sig_printf("\n");
+    }
+
+    /* R4 must point exactly to the start of the second source page */
+    if (r4 != expected_src) {
+        sig_printf("FAIL: R4 (src addr) = 0x%lx, expected 0x%lx\n",
+                   r4, expected_src);
+        pass = 0;
+    } else if (verbose) {
+        sig_printf("    R4 check: PASS\n");
+    }
+
+    /* R5 must equal exactly PAGE_SIZE (one full page remaining) */
+    if (r5 != (unsigned long)page_size) {
+        sig_printf("FAIL: R5 (src len) = 0x%lx, expected PAGE_SIZE = 0x%lx\n",
+                   r5, (unsigned long)page_size);
+        pass = 0;
+    } else if (verbose) {
+        sig_printf("    R5 check: PASS\n");
+    }
+
+    /* R2 must point exactly to dst_fault + PAGE_SIZE */
+    if (r2 != expected_dst) {
+        sig_printf("FAIL: R2 (dst addr) = 0x%lx, expected 0x%lx\n",
+                   r2, expected_dst);
+        pass = 0;
+    } else if (verbose) {
+        sig_printf("    R2 check: PASS\n");
+    }
+
+    /*
+     * The tweak at fault_param[AES_BLOCK_SIZE..2*AES_BLOCK_SIZE-1] must
+     * equal expected_tweak[], i.e. the tweak that cpacf_aes_xts wrote back
+     * after processing the last block of page 1 (= tweak for first block of
+     * page 2).
+     */
+    if (memcmp((void *)(fault_param + AES_BLOCK_SIZE),
+               expected_tweak, AES_BLOCK_SIZE) != 0) {
+        sig_printf("FAIL: tweak in param block at fault does not match expected tweak\n");
+        sig_printf("  got:      ");
+        for (int i = 0; i < AES_BLOCK_SIZE; i++) {
+            sig_printf("%02x", ((uint8_t *)fault_param)[AES_BLOCK_SIZE + i]);
+        }
+        sig_printf("\n  expected: ");
+        for (int i = 0; i < AES_BLOCK_SIZE; i++) {
+            sig_printf("%02x", expected_tweak[i]);
+        }
+        sig_printf("\n");
+        pass = 0;
+    } else if (verbose) {
+        sig_printf("    tweak check: PASS\n");
+    }
+
+    sigsegv_pass = pass;
+
+    if (verbose) {
+        sig_printf("  restoring PROT_READ on page at 0x%lx, resuming KM\n",
+                   expected_src);
+    }
+
+    /* Restore read access so the restarted KM can read the second page */
+    mprotect((void *)expected_src, page_size, PROT_READ);
+
+#undef sig_printf
+}
+
+/*
+ * Build a KM XTS-128 parameter block at buf[]:
+ *   buf[0..15]  = key1
+ *   buf[16..31] = initial tweak (computed from sector number)
+ *
+ * The initial tweak is derived by encrypting the sector number block with
+ * key2 using plain AES-128 ECB, as specified by the XTS-AES standard.
+ */
+static int build_xts128_param(uint8_t *buf)
+{
+    uint8_t key2_param[16];
+    unsigned long cc = 0;
+
+    memcpy(key2_param, xts128key2, sizeof(xts128key2));
+    cpacf_km(CPACF_KM_AES_128, key2_param, buf + AES_BLOCK_SIZE,
+             xts128sect, AES_BLOCK_SIZE, &cc);
+    if (cc != 0) {
+        return -1;
+    }
+    memcpy(buf, xts128key1, sizeof(xts128key1));
+    return 0;
+}
+
+int main(int argc, char *argv[])
+{
+    struct sigaction sa, old_sa;
+    uint8_t *src_pages, *dst_ref, *dst_fault;
+    /* KM XTS-128 parameter block: [key1(16)][tweak(16)] = 32 bytes */
+    uint8_t param_ref[32];
+    uint8_t param_fault[32];
+    unsigned long cc;
+    int rc = 0;
+
+    if (argc == 2 && strcmp(argv[1], "-v") == 0) {
+        verbose = 1;
+    } else if (argc > 1) {
+        fprintf(stderr, "usage: %s [-v]\n", argv[0]);
+        return EXIT_FAILURE;
+    }
+
+    page_size = getpagesize();
+
+    if (verbose) {
+        printf("page_size = %ld (0x%lx)\n", page_size, page_size);
+    }
+
+    /*
+     * Allocate two contiguous page-aligned source pages and fill them with
+     * a deterministic pseudo-random pattern so the test is reproducible.
+     */
+    src_pages = mmap(NULL, 2 * page_size, PROT_READ | PROT_WRITE,
+                     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+    if (src_pages == MAP_FAILED) {
+        perror("mmap src_pages");
+        return EXIT_FAILURE;
+    }
+    for (long i = 0; i < 2 * page_size; i++) {
+        src_pages[i] = (uint8_t)(i * 37 + 13);
+    }
+
+    /* Reference destination: two contiguous pages, initially zeroed */
+    dst_ref = mmap(NULL, 2 * page_size, PROT_READ | PROT_WRITE,
+                   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+    if (dst_ref == MAP_FAILED) {
+        perror("mmap dst_ref");
+        munmap(src_pages, 2 * page_size);
+        return EXIT_FAILURE;
+    }
+
+    /* Fault-run destination: two contiguous pages, initially zeroed */
+    dst_fault = mmap(NULL, 2 * page_size, PROT_READ | PROT_WRITE,
+                     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+    if (dst_fault == MAP_FAILED) {
+        perror("mmap dst_fault");
+        munmap(src_pages, 2 * page_size);
+        munmap(dst_ref,   2 * page_size);
+        return EXIT_FAILURE;
+    }
+
+    if (verbose) {
+        printf("src_pages: [0x%lx, 0x%lx)  page1=[0x%lx, 0x%lx)  page2=[0x%lx, 0x%lx)\n",
+               (unsigned long)src_pages,
+               (unsigned long)(src_pages + 2 * page_size),
+               (unsigned long)src_pages,
+               (unsigned long)(src_pages + page_size),
+               (unsigned long)(src_pages + page_size),
+               (unsigned long)(src_pages + 2 * page_size));
+        printf("dst_ref:   [0x%lx, 0x%lx)\n",
+               (unsigned long)dst_ref,
+               (unsigned long)(dst_ref + 2 * page_size));
+        printf("dst_fault: [0x%lx, 0x%lx)\n",
+               (unsigned long)dst_fault,
+               (unsigned long)(dst_fault + 2 * page_size));
+    }
+
+    /* ------------------------------------------------------------------ */
+    /* Reference run - step 1: encrypt page 1 only.                       */
+    /*                                                                     */
+    /* After this call param_ref[16..31] contains the running tweak for   */
+    /* the first block of page 2. Save it as expected_tweak[] so the      */
+    /* signal handler can verify the fault-run param block matches.       */
+    /* ------------------------------------------------------------------ */
+
+    if (build_xts128_param(param_ref) != 0) {
+        fprintf(stderr, "FAIL: initial tweak derivation failed\n");
+        rc = 1;
+        goto out;
+    }
+
+    if (verbose) {
+        printf("reference run step 1: cpacf_km KM_XTS_128, page 1 only\n");
+        printf("  initial tweak: ");
+        for (int i = 0; i < AES_BLOCK_SIZE; i++) {
+            printf("%02x", param_ref[AES_BLOCK_SIZE + i]);
+        }
+        printf("\n");
+    }
+
+    cpacf_km(CPACF_KM_XTS_128, param_ref, dst_ref, src_pages, page_size, &cc);
+    if (cc != 0) {
+        fprintf(stderr, "FAIL: reference run step 1 unexpected cc=%lu\n", cc);
+        rc = 1;
+        goto out;
+    }
+
+    /* Capture the running tweak after page 1 - this is in param_ref[16..31] */
+    memcpy(expected_tweak, param_ref + AES_BLOCK_SIZE, AES_BLOCK_SIZE);
+
+    if (verbose) {
+        printf("reference run step 1: done, cc=0\n");
+        printf("  running tweak after page 1 (= expected_tweak): ");
+        for (int i = 0; i < AES_BLOCK_SIZE; i++) {
+            printf("%02x", expected_tweak[i]);
+        }
+        printf("\n");
+    }
+
+    /* ------------------------------------------------------------------ */
+    /* Reference run - step 2: encrypt page 2 with the advanced tweak.   */
+    /* param_ref already holds the updated tweak from step 1.             */
+    /* ------------------------------------------------------------------ */
+
+    if (verbose) {
+        printf("reference run step 2: cpacf_km KM_XTS_128, page 2 only\n");
+    }
+
+    cpacf_km(CPACF_KM_XTS_128, param_ref, dst_ref + page_size,
+             src_pages + page_size, page_size, &cc);
+    if (cc != 0) {
+        fprintf(stderr, "FAIL: reference run step 2 unexpected cc=%lu\n", cc);
+        rc = 1;
+        goto out;
+    }
+
+    if (verbose) {
+        printf("reference run step 2: done, cc=0\n");
+    }
+
+    /* ------------------------------------------------------------------ */
+    /* Fault run: protect second source page, run KM over both pages.     */
+    /* ------------------------------------------------------------------ */
+
+    if (build_xts128_param(param_fault) != 0) {
+        fprintf(stderr, "FAIL: fault param derivation failed\n");
+        rc = 1;
+        goto out;
+    }
+
+    /* Record the exact values we expect at fault time */
+    expected_src  = (unsigned long)(src_pages + page_size);
+    expected_dst  = (unsigned long)(dst_fault + page_size);
+    fault_param   = param_fault;
+    sigsegv_count = 0;
+    sigsegv_pass  = 1;   /* handler sets to 0 on any check failure */
+
+    if (verbose) {
+        printf("fault run: expecting SIGSEGV when KM reaches src page2 at 0x%lx\n",
+               expected_src);
+        printf("fault run: expected register state at fault:\n");
+        printf("  R2 (dst addr) = 0x%lx\n", expected_dst);
+        printf("  R4 (src addr) = 0x%lx\n", expected_src);
+        printf("  R5 (src len)  = 0x%lx\n", (unsigned long)page_size);
+        printf("fault run: expected tweak in param block at fault: ");
+        for (int i = 0; i < AES_BLOCK_SIZE; i++) {
+            printf("%02x", expected_tweak[i]);
+        }
+        printf("\n");
+    }
+
+    /* Install SIGSEGV handler */
+    memset(&sa, 0, sizeof(sa));
+    sa.sa_sigaction = sigsegv_handler;
+    sa.sa_flags     = SA_SIGINFO;
+    sigemptyset(&sa.sa_mask);
+    if (sigaction(SIGSEGV, &sa, &old_sa) != 0) {
+        perror("sigaction");
+        rc = 1;
+        goto out;
+    }
+
+    /* Protect the second source page to provoke a fault during KM */
+    if (mprotect(src_pages + page_size, page_size, PROT_NONE) != 0) {
+        perror("mprotect PROT_NONE");
+        sigaction(SIGSEGV, &old_sa, NULL);
+        rc = 1;
+        goto out;
+    }
+
+    if (verbose) {
+        printf("fault run: second src page protected, starting cpacf_km\n");
+    }
+
+    /*
+     * Encrypt both pages with a single cpacf_km XTS call.
+     *
+     * Page 1 is processed normally; registers and the tweak in param_fault
+     * are advanced block-by-block inside cpacf_aes_xts. On the first read
+     * of the second source page the CPU takes a protection fault.
+     * The signal handler verifies R2/R4/R5 and the tweak, then restores
+     * PROT_READ. On return from the handler the KM instruction is restarted
+     * with the already-advanced registers and correct tweak, so it processes
+     * only the second page and completes with CC=0.
+     *
+     * The brc 1,0b loop inside cpacf_km handles the unrelated CC=3
+     * (partial-completion) case and is not triggered by the page fault.
+     */
+    cpacf_km(CPACF_KM_XTS_128, param_fault, dst_fault,
+             src_pages, 2 * page_size, &cc);
+
+    /* Restore the original SIGSEGV disposition */
+    sigaction(SIGSEGV, &old_sa, NULL);
+
+    if (verbose) {
+        printf("fault run: cpacf_km returned, cc=%lu, SIGSEGV count=%d\n",
+               cc, sigsegv_count);
+    }
+
+    if (cc != 0) {
+        fprintf(stderr, "FAIL: fault run unexpected cc=%lu\n", cc);
+        rc = 1;
+    }
+
+    /* ------------------------------------------------------------------ */
+    /* Verify: signal handler must have fired exactly once.               */
+    /* ------------------------------------------------------------------ */
+    if (sigsegv_count != 1) {
+        fprintf(stderr, "FAIL: expected 1 SIGSEGV, got %d\n", sigsegv_count);
+        rc = 1;
+    } else if (verbose) {
+        printf("check: SIGSEGV count = %d (expected 1): PASS\n", sigsegv_count);
+    }
+
+    /* ------------------------------------------------------------------ */
+    /* Verify: register and tweak checks inside the handler were correct. */
+    /* ------------------------------------------------------------------ */
+    if (!sigsegv_pass) {
+        fprintf(stderr, "FAIL: register/tweak check in SIGSEGV handler failed\n");
+        rc = 1;
+    } else if (verbose) {
+        printf("check: register and tweak values in SIGSEGV handler: PASS\n");
+    }
+
+    /* ------------------------------------------------------------------ */
+    /* Verify: fault-run ciphertext matches the reference ciphertext.     */
+    /* ------------------------------------------------------------------ */
+    if (memcmp(dst_ref, dst_fault, 2 * page_size) != 0) {
+        fprintf(stderr, "FAIL: fault-run ciphertext does not match reference\n");
+        rc = 1;
+    } else if (verbose) {
+        printf("check: fault-run ciphertext matches reference ciphertext: PASS\n");
+    }
+
+    if (rc == 0) {
+        printf("cpacf-km-xts-fault: all checks passed\n");
+    }
+
+out:
+    munmap(src_pages, 2 * page_size);
+    munmap(dst_ref,   2 * page_size);
+    munmap(dst_fault, 2 * page_size);
+
+    return rc ? EXIT_FAILURE : EXIT_SUCCESS;
+}
diff --git a/tests/tcg/s390x/cpacf-kmc-cbc-fault.c b/tests/tcg/s390x/cpacf-kmc-cbc-fault.c
new file mode 100644
index 0000000000..27e15c80ed
--- /dev/null
+++ b/tests/tcg/s390x/cpacf-kmc-cbc-fault.c
@@ -0,0 +1,472 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Test for register and IV update correctness in cpacf_aes_cbc
+ * (KMC AES-128 CBC).
+ *
+ * All the CPACF instructions are designed in a way that on exit
+ * the registers and associated memory (like an IV) are updated so
+ * that on incomplete processing (partial completion) the instruction
+ * can just be re-invoked. The QEMU emulation of the CPACF instructions
+ * needs to obey that rule as well.
+ * This testcase checks the correct update of the register values and
+ * IV in memory by triggering a page protection fault in the middle of
+ * the data. The signal handler then checks for the expected register
+ * and memory values. After that the page is enabled for reading,
+ * causing the OS to restart the instruction which continues to process
+ * the remaining data. Finally the encryption result is checked to
+ * match the expectations.
+ *
+ * Test sequence:
+ *  1. Allocate two contiguous, page-aligned source pages filled with
+ *     pseudo-random data and two matching destination pages.
+ *  2. Reference run - two steps to capture the intermediate IV:
+ *     a. Encrypt page 1 only with cpacf_kmc AES-128 CBC into dst_ref.
+ *        After this call the IV in the parameter block has been updated
+ *        to the running IV after the last block of page 1. Save this IV
+ *        as expected_iv[].
+ *     b. Encrypt page 2 with the same parameter block (IV already advanced)
+ *        into dst_ref + PAGE_SIZE.
+ *  3. Fault run:
+ *     a. Protect the second source page (PROT_NONE).
+ *     b. Install a SIGSEGV handler.
+ *     c. Call cpacf_kmc over both pages in one shot (2 * PAGE_SIZE bytes).
+ *     d. On the SIGSEGV verify:
+ *          - R4 (src address) equals exactly the start of the second source
+ *            page (all blocks of page 1 were already consumed).
+ *          - R5 (remaining src length) equals exactly PAGE_SIZE.
+ *          - R2 (dst address) equals exactly dst_fault + PAGE_SIZE.
+ *          - The IV at param_fault[0..15] equals expected_iv[], proving
+ *            that cpacf_aes_cbc wrote the correct running IV back into the
+ *            parameter block before the fault.
+ *     e. Restore PROT_READ on the second source page and return from the
+ *        handler so KMC re-executes from the updated registers and IV,
+ *        finishing the second page.
+ *  4. Compare the fault-run output to the reference output; they must match.
+ *
+ * cpacf_kmc() in cpacf.h uses pinned registers R2/R4/R5 for its operands,
+ * so the signal handler can read them reliably via ucontext_t.
+ *
+ * Usage: cpacf-kmc-cbc-fault [-v]
+ *   -v  verbose: print details about each step and every check.
+ */
+
+#include <signal.h>
+#include <stdio.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <ucontext.h>
+#include <unistd.h>
+#include "cpacf.h"
+
+#define AES_BLOCK_SIZE  16
+
+/* AES-128 key and initial IV used for all encryptions in this test */
+static const uint8_t aes128key[16] = {
+    0x1f, 0x8e, 0x49, 0x73, 0x95, 0x3f, 0x3f, 0xb0,
+    0xbd, 0x6b, 0x16, 0x66, 0x2e, 0x9a, 0x3c, 0x17
+};
+static const uint8_t initial_iv[16] = {
+    0x2f, 0xe2, 0xb3, 0x33, 0xce, 0xda, 0x8f, 0x98,
+    0xf4, 0xa9, 0x9b, 0x40, 0xd2, 0xcd, 0x34, 0xa8
+};
+
+/* Page size, determined at runtime */
+static long page_size;
+
+/* Verbose flag: set by -v on the command line */
+static int verbose;
+
+/*
+ * State shared between main() and the SIGSEGV handler.
+ * volatile prevents the compiler from optimising away accesses.
+ */
+static volatile int           sigsegv_count; /* how many times handler fired */
+static volatile int           sigsegv_pass;  /* 1 = all checks passed */
+static volatile unsigned long expected_src;  /* exact expected R4 value */
+static volatile unsigned long expected_dst;  /* exact expected R2 value */
+static volatile uint8_t      *fault_param;   /* param block used in fault run */
+static uint8_t                expected_iv[AES_BLOCK_SIZE]; /* IV after page 1 */
+
+/*
+ * SIGSEGV handler.
+ *
+ * At fault time the KMC instruction has already processed all blocks of the
+ * first source page and updated registers and parameter block accordingly.
+ * For the second-page fault:
+ *   R2 = dst_fault + PAGE_SIZE  (destination pointer into second output page)
+ *   R4 = src_pages + PAGE_SIZE  (source pointer at start of second source page)
+ *   R5 = PAGE_SIZE              (exactly one page of source data remaining)
+ *   fault_param[0..15]          (IV in param block = running IV after page 1)
+ *
+ * After verifying these values the handler restores read permission on the
+ * second source page and returns. The signal return mechanism re-executes
+ * the KMC instruction from the updated register state and IV, completing
+ * the second page.
+ */
+static void sigsegv_handler(int sig, siginfo_t *si, void *uctx_arg)
+{
+    /*
+     * No printf within signal handler, but write() can be used. So this
+     * little sig_printf() macro is a replacement to fprintf(stderr, ...)
+     */
+#define sig_printf(...) do { \
+        char printfbuf[256]; \
+        int len = snprintf(printfbuf, sizeof(printfbuf), __VA_ARGS__); \
+        write(STDERR_FILENO, printfbuf, len); \
+    } while (0)
+
+    ucontext_t *uc = (ucontext_t *)uctx_arg;
+    unsigned long r2, r4, r5;
+    int pass = 1;
+
+    sigsegv_count++;
+
+    /*
+     * On s390x, glibc's mcontext_t exposes the GPRs as gregs[].
+     */
+    r2 = uc->uc_mcontext.gregs[2];  /* KMC destination address register */
+    r4 = uc->uc_mcontext.gregs[4];  /* KMC source address register      */
+    r5 = uc->uc_mcontext.gregs[5];  /* KMC source length register       */
+
+    if (verbose) {
+        sig_printf("  SIGSEGV #%d: si_addr=0x%lx\n",
+                   sigsegv_count, (unsigned long)si->si_addr);
+        sig_printf("    R2 (dst addr):  0x%lx  (expected 0x%lx)\n",
+                   r2, expected_dst);
+        sig_printf("    R4 (src addr):  0x%lx  (expected 0x%lx)\n",
+                   r4, expected_src);
+        sig_printf("    R5 (src len):   0x%lx  (expected 0x%lx = PAGE_SIZE)\n",
+                   r5, (unsigned long)page_size);
+        sig_printf("    IV in param block: ");
+        for (int i = 0; i < AES_BLOCK_SIZE; i++) {
+            sig_printf("%02x", ((uint8_t *)fault_param)[i]);
+        }
+        sig_printf("\n");
+        sig_printf("    expected IV:       ");
+        for (int i = 0; i < AES_BLOCK_SIZE; i++) {
+            sig_printf("%02x", expected_iv[i]);
+        }
+        sig_printf("\n");
+    }
+
+    /* R4 must point exactly to the start of the second source page */
+    if (r4 != expected_src) {
+        sig_printf("FAIL: R4 (src addr) = 0x%lx, expected 0x%lx\n",
+                   r4, expected_src);
+        pass = 0;
+    } else if (verbose) {
+        sig_printf("    R4 check: PASS\n");
+    }
+
+    /* R5 must equal exactly PAGE_SIZE (one full page remaining) */
+    if (r5 != (unsigned long)page_size) {
+        sig_printf("FAIL: R5 (src len) = 0x%lx, expected PAGE_SIZE = 0x%lx\n",
+                   r5, (unsigned long)page_size);
+        pass = 0;
+    } else if (verbose) {
+        sig_printf("    R5 check: PASS\n");
+    }
+
+    /* R2 must point exactly to dst_fault + PAGE_SIZE */
+    if (r2 != expected_dst) {
+        sig_printf("FAIL: R2 (dst addr) = 0x%lx, expected 0x%lx\n",
+                   r2, expected_dst);
+        pass = 0;
+    } else if (verbose) {
+        sig_printf("    R2 check: PASS\n");
+    }
+
+    /*
+     * The IV at param_fault[0..15] must equal expected_iv[], i.e. the
+     * running IV that cpacf_aes_cbc wrote back after consuming page 1.
+     */
+    if (memcmp((void *)fault_param, expected_iv, AES_BLOCK_SIZE) != 0) {
+        sig_printf("FAIL: IV in param block at fault does not match expected IV\n");
+        sig_printf("  got:      ");
+        for (int i = 0; i < AES_BLOCK_SIZE; i++) {
+            sig_printf("%02x", ((uint8_t *)fault_param)[i]);
+        }
+        sig_printf("\n  expected: ");
+        for (int i = 0; i < AES_BLOCK_SIZE; i++) {
+            sig_printf("%02x", expected_iv[i]);
+        }
+        sig_printf("\n");
+        pass = 0;
+    } else if (verbose) {
+        sig_printf("    IV check: PASS\n");
+    }
+
+    sigsegv_pass = pass;
+
+    if (verbose) {
+        sig_printf("  restoring PROT_READ on page at 0x%lx, resuming KMC\n",
+                   expected_src);
+    }
+
+    /* Restore read access so the restarted KMC can read the second page */
+    mprotect((void *)expected_src, page_size, PROT_READ);
+
+#undef sig_printf
+}
+
+/*
+ * Build a KMC AES-128 parameter block at buf[]:
+ *   buf[0..15]  = iv
+ *   buf[16..31] = key
+ */
+static void build_param(uint8_t *buf, const uint8_t *iv, const uint8_t *key)
+{
+    memcpy(buf,      iv,  AES_BLOCK_SIZE);
+    memcpy(buf + AES_BLOCK_SIZE, key, 16);
+}
+
+int main(int argc, char *argv[])
+{
+    struct sigaction sa, old_sa;
+    uint8_t *src_pages, *dst_ref, *dst_fault;
+    /* parameter blocks: [IV(16)][key(16)] = 32 bytes */
+    uint8_t param_ref[32];
+    uint8_t param_fault[32];
+    unsigned long cc;
+    int rc = 0;
+
+    if (argc == 2 && strcmp(argv[1], "-v") == 0) {
+        verbose = 1;
+    } else if (argc > 1) {
+        fprintf(stderr, "usage: %s [-v]\n", argv[0]);
+        return EXIT_FAILURE;
+    }
+
+    page_size = getpagesize();
+
+    if (verbose) {
+        printf("page_size = %ld (0x%lx)\n", page_size, page_size);
+    }
+
+    /*
+     * Allocate two contiguous page-aligned source pages and fill them with
+     * a deterministic pseudo-random pattern so the test is reproducible.
+     */
+    src_pages = mmap(NULL, 2 * page_size, PROT_READ | PROT_WRITE,
+                     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+    if (src_pages == MAP_FAILED) {
+        perror("mmap src_pages");
+        return EXIT_FAILURE;
+    }
+    for (long i = 0; i < 2 * page_size; i++) {
+        src_pages[i] = (uint8_t)(i * 37 + 13);
+    }
+
+    /* Reference destination: two contiguous pages, initially zeroed */
+    dst_ref = mmap(NULL, 2 * page_size, PROT_READ | PROT_WRITE,
+                   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+    if (dst_ref == MAP_FAILED) {
+        perror("mmap dst_ref");
+        munmap(src_pages, 2 * page_size);
+        return EXIT_FAILURE;
+    }
+
+    /* Fault-run destination: two contiguous pages, initially zeroed */
+    dst_fault = mmap(NULL, 2 * page_size, PROT_READ | PROT_WRITE,
+                     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+    if (dst_fault == MAP_FAILED) {
+        perror("mmap dst_fault");
+        munmap(src_pages, 2 * page_size);
+        munmap(dst_ref,   2 * page_size);
+        return EXIT_FAILURE;
+    }
+
+    if (verbose) {
+        printf("src_pages: [0x%lx, 0x%lx)  page1=[0x%lx, 0x%lx)  page2=[0x%lx, 0x%lx)\n",
+               (unsigned long)src_pages,
+               (unsigned long)(src_pages + 2 * page_size),
+               (unsigned long)src_pages,
+               (unsigned long)(src_pages + page_size),
+               (unsigned long)(src_pages + page_size),
+               (unsigned long)(src_pages + 2 * page_size));
+        printf("dst_ref:   [0x%lx, 0x%lx)\n",
+               (unsigned long)dst_ref,
+               (unsigned long)(dst_ref + 2 * page_size));
+        printf("dst_fault: [0x%lx, 0x%lx)\n",
+               (unsigned long)dst_fault,
+               (unsigned long)(dst_fault + 2 * page_size));
+    }
+
+    /* ------------------------------------------------------------------ */
+    /* Reference run - step 1: encrypt page 1 only.                       */
+    /*                                                                     */
+    /* After this call param_ref[0..15] contains the running IV after the  */
+    /* last block of page 1. Save it as expected_iv[] so the signal handler*/
+    /* can verify the fault-run param block contains the same value.       */
+    /* ------------------------------------------------------------------ */
+
+    build_param(param_ref, initial_iv, aes128key);
+
+    if (verbose) {
+        printf("reference run step 1: cpacf_kmc AES-128 CBC, page 1 only\n");
+    }
+
+    cpacf_kmc(CPACF_KMC_AES_128, param_ref, dst_ref, src_pages, page_size, &cc);
+    if (cc != 0) {
+        fprintf(stderr, "FAIL: reference run step 1 unexpected cc=%lu\n", cc);
+        rc = 1;
+        goto out;
+    }
+
+    /* Capture the running IV after page 1 - this is in param_ref[0..15] */
+    memcpy(expected_iv, param_ref, AES_BLOCK_SIZE);
+
+    if (verbose) {
+        printf("reference run step 1: done, cc=0\n");
+        printf("  running IV after page 1 (= expected_iv): ");
+        for (int i = 0; i < AES_BLOCK_SIZE; i++) {
+            printf("%02x", expected_iv[i]);
+        }
+        printf("\n");
+    }
+
+    /* ------------------------------------------------------------------ */
+    /* Reference run - step 2: encrypt page 2 with the advanced IV.       */
+    /* param_ref already holds the updated IV from step 1.                */
+    /* ------------------------------------------------------------------ */
+
+    if (verbose) {
+        printf("reference run step 2: cpacf_kmc AES-128 CBC, page 2 only\n");
+    }
+
+    cpacf_kmc(CPACF_KMC_AES_128, param_ref, dst_ref + page_size,
+              src_pages + page_size, page_size, &cc);
+    if (cc != 0) {
+        fprintf(stderr, "FAIL: reference run step 2 unexpected cc=%lu\n", cc);
+        rc = 1;
+        goto out;
+    }
+
+    if (verbose) {
+        printf("reference run step 2: done, cc=0\n");
+    }
+
+    /* ------------------------------------------------------------------ */
+    /* Fault run: protect second source page, run KMC over both pages.    */
+    /* ------------------------------------------------------------------ */
+
+    build_param(param_fault, initial_iv, aes128key);
+
+    /* Record the exact values we expect at fault time */
+    expected_src  = (unsigned long)(src_pages + page_size);
+    expected_dst  = (unsigned long)(dst_fault + page_size);
+    fault_param   = param_fault;
+    sigsegv_count = 0;
+    sigsegv_pass  = 1;   /* handler sets to 0 on any check failure */
+
+    if (verbose) {
+        printf("fault run: expecting SIGSEGV when KMC reaches src page2 at 0x%lx\n",
+               expected_src);
+        printf("fault run: expected register state at fault:\n");
+        printf("  R2 (dst addr) = 0x%lx\n", expected_dst);
+        printf("  R4 (src addr) = 0x%lx\n", expected_src);
+        printf("  R5 (src len)  = 0x%lx\n", (unsigned long)page_size);
+        printf("fault run: expected IV in param block at fault: ");
+        for (int i = 0; i < AES_BLOCK_SIZE; i++) {
+            printf("%02x", expected_iv[i]);
+        }
+        printf("\n");
+    }
+
+    /* Install SIGSEGV handler */
+    memset(&sa, 0, sizeof(sa));
+    sa.sa_sigaction = sigsegv_handler;
+    sa.sa_flags     = SA_SIGINFO;
+    sigemptyset(&sa.sa_mask);
+    if (sigaction(SIGSEGV, &sa, &old_sa) != 0) {
+        perror("sigaction");
+        rc = 1;
+        goto out;
+    }
+
+    /* Protect the second source page to provoke a fault during KMC */
+    if (mprotect(src_pages + page_size, page_size, PROT_NONE) != 0) {
+        perror("mprotect PROT_NONE");
+        sigaction(SIGSEGV, &old_sa, NULL);
+        rc = 1;
+        goto out;
+    }
+
+    if (verbose) {
+        printf("fault run: second src page protected, starting cpacf_kmc\n");
+    }
+
+    /*
+     * Encrypt both pages with a single cpacf_kmc call.
+     *
+     * Page 1 is processed normally; registers and the IV in param_fault
+     * are advanced block-by-block inside cpacf_aes_cbc. On the first read
+     * of the second source page the CPU takes a protection fault.
+     * The signal handler verifies R2/R4/R5 and the IV, then restores
+     * PROT_READ. On return from the handler the KMC instruction is
+     * restarted with the already-advanced registers and correct IV, so it
+     * processes only the second page and completes with CC=0.
+     *
+     * The brc 1,0b loop inside cpacf_kmc handles the unrelated CC=3
+     * (partial-completion) case and is not triggered by the page fault.
+     */
+    cpacf_kmc(CPACF_KMC_AES_128, param_fault, dst_fault,
+              src_pages, 2 * page_size, &cc);
+
+    /* Restore the original SIGSEGV disposition */
+    sigaction(SIGSEGV, &old_sa, NULL);
+
+    if (verbose) {
+        printf("fault run: cpacf_kmc returned, cc=%lu, SIGSEGV count=%d\n",
+               cc, sigsegv_count);
+    }
+
+    if (cc != 0) {
+        fprintf(stderr, "FAIL: fault run unexpected cc=%lu\n", cc);
+        rc = 1;
+    }
+
+    /* ------------------------------------------------------------------ */
+    /* Verify: signal handler must have fired exactly once.               */
+    /* ------------------------------------------------------------------ */
+    if (sigsegv_count != 1) {
+        fprintf(stderr, "FAIL: expected 1 SIGSEGV, got %d\n", sigsegv_count);
+        rc = 1;
+    } else if (verbose) {
+        printf("check: SIGSEGV count = %d (expected 1): PASS\n", sigsegv_count);
+    }
+
+    /* ------------------------------------------------------------------ */
+    /* Verify: register and IV checks inside the handler were correct.    */
+    /* ------------------------------------------------------------------ */
+    if (!sigsegv_pass) {
+        fprintf(stderr, "FAIL: register/IV check in SIGSEGV handler failed\n");
+        rc = 1;
+    } else if (verbose) {
+        printf("check: register and IV values in SIGSEGV handler: PASS\n");
+    }
+
+    /* ------------------------------------------------------------------ */
+    /* Verify: fault-run ciphertext matches the reference ciphertext.     */
+    /* ------------------------------------------------------------------ */
+    if (memcmp(dst_ref, dst_fault, 2 * page_size) != 0) {
+        fprintf(stderr, "FAIL: fault-run ciphertext does not match reference\n");
+        rc = 1;
+    } else if (verbose) {
+        printf("check: fault-run ciphertext matches reference ciphertext: PASS\n");
+    }
+
+    if (rc == 0) {
+        printf("cpacf-kmc-cbc-fault: all checks passed\n");
+    }
+
+out:
+    munmap(src_pages, 2 * page_size);
+    munmap(dst_ref,   2 * page_size);
+    munmap(dst_fault, 2 * page_size);
+
+    return rc ? EXIT_FAILURE : EXIT_SUCCESS;
+}
diff --git a/tests/tcg/s390x/cpacf-kmctr-ctr-fault.c b/tests/tcg/s390x/cpacf-kmctr-ctr-fault.c
new file mode 100644
index 0000000000..70e7fcf7c7
--- /dev/null
+++ b/tests/tcg/s390x/cpacf-kmctr-ctr-fault.c
@@ -0,0 +1,414 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Test for register update correctness in cpacf_aes_ctr (KMCTR AES-128 CTR).
+ *
+ * All the CPACF instructions are designed in a way that on exit
+ * the registers are updated so that on incomplete processing (partial
+ * completion) the instruction can just be re-invoked. The QEMU emulation
+ * of the CPACF instructions needs to obey that rule as well.
+ * This testcase checks the correct update of the register values by
+ * triggering a page protection fault in the middle of the data. The
+ * signal handler then checks for the expected register values. After
+ * that the page is enabled for reading, causing the OS to restart the
+ * instruction which continues to process the remaining data. Finally
+ * the encryption result is checked to match the expectations.
+ *
+ * Test sequence:
+ *  1. Allocate two contiguous, page-aligned source pages filled with
+ *     pseudo-random data, two matching destination pages, and two
+ *     counter pages filled with sequential counter blocks.
+ *  2. Reference run: encrypt both source pages with cpacf_kmctr AES-128 CTR
+ *     into dst_ref (no faults).
+ *  3. Fault run:
+ *     a. Protect the second source page (PROT_NONE).
+ *     b. Install a SIGSEGV handler.
+ *     c. Call cpacf_kmctr over both pages in one shot (2 * PAGE_SIZE bytes).
+ *     d. On the SIGSEGV verify:
+ *          - R4 (src address) equals exactly the start of the second source
+ *            page (all blocks of page 1 were already consumed).
+ *          - R5 (remaining src length) equals exactly PAGE_SIZE.
+ *          - R2 (dst address) equals exactly dst_fault + PAGE_SIZE.
+ *          - R6 (counter address) equals exactly ctr_pages + PAGE_SIZE,
+ *            proving that cpacf_aes_ctr advanced the counter pointer
+ *            block-by-block through page 1.
+ *     e. Restore PROT_READ on the second source page and return from the
+ *        handler so KMCTR re-executes from the updated registers,
+ *        finishing the second page.
+ *  4. Compare the fault-run output to the reference output; they must match.
+ *
+ * cpacf_km() in cpacf.h uses pinned registers R2/R4/R5 for its operands,
+ * so the signal handler can read them reliably via ucontext_t.
+ *
+ * Usage: cpacf-kmctr-ctr-fault [-v]
+ *   -v  verbose: print details about each step and every check.
+ */
+
+#include <signal.h>
+#include <stdio.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <ucontext.h>
+#include <unistd.h>
+#include "cpacf.h"
+
+#define AES_BLOCK_SIZE  16
+
+/* AES-128 key used for all encryptions in this test */
+static const uint8_t aes128key[16] = {
+    0xcc, 0x22, 0xda, 0x78, 0x7f, 0x37, 0x57, 0x11,
+    0xc7, 0x63, 0x02, 0xbe, 0xf0, 0x97, 0x9d, 0x8e
+};
+
+/* Page size, determined at runtime */
+static long page_size;
+
+/* Verbose flag: set by -v on the command line */
+static int verbose;
+
+/*
+ * State shared between main() and the SIGSEGV handler.
+ * volatile prevents the compiler from optimising away accesses.
+ */
+static volatile int           sigsegv_count;  /* how many times handler fired */
+static volatile int           sigsegv_pass;   /* 1 = all checks passed */
+static volatile unsigned long expected_src;   /* exact expected R4 value */
+static volatile unsigned long expected_dst;   /* exact expected R2 value */
+static volatile unsigned long expected_ctr;   /* exact expected R6 value */
+
+/*
+ * SIGSEGV handler.
+ *
+ * At fault time the KMCTR instruction has already processed all blocks of the
+ * first source page and advanced all four operand registers accordingly.
+ * For the second-page fault:
+ *   R2 = dst_fault + PAGE_SIZE   (destination pointer into second output page)
+ *   R4 = src_pages + PAGE_SIZE   (source ptr at start of second source page)
+ *   R5 = PAGE_SIZE               (exactly one page of source data remaining)
+ *   R6 = ctr_pages + PAGE_SIZE   (counter ptr at start of second counter page)
+ *
+ * After verifying these values the handler restores read permission on the
+ * second source page and returns. The signal return mechanism re-executes
+ * the KMCTR instruction from the updated register state, completing the run.
+ */
+static void sigsegv_handler(int sig, siginfo_t *si, void *uctx_arg)
+{
+    /*
+     * No printf within signal handler, but write() can be used. So this
+     * little sig_printf() macro is a replacement to fprintf(stderr, ...)
+     */
+#define sig_printf(...) do { \
+        char printfbuf[256]; \
+        int len = snprintf(printfbuf, sizeof(printfbuf), __VA_ARGS__); \
+        write(STDERR_FILENO, printfbuf, len); \
+    } while (0)
+
+    ucontext_t *uc = (ucontext_t *)uctx_arg;
+    unsigned long r2, r4, r5, r6;
+    int pass = 1;
+
+    sigsegv_count++;
+
+    /*
+     * On s390x, glibc's mcontext_t exposes the GPRs as gregs[].
+     */
+    r2 = uc->uc_mcontext.gregs[2];  /* KMCTR destination address register */
+    r4 = uc->uc_mcontext.gregs[4];  /* KMCTR source address register      */
+    r5 = uc->uc_mcontext.gregs[5];  /* KMCTR source length register       */
+    r6 = uc->uc_mcontext.gregs[6];  /* KMCTR counter address register     */
+
+    if (verbose) {
+        sig_printf("  SIGSEGV #%d: si_addr=0x%lx\n",
+                   sigsegv_count, (unsigned long)si->si_addr);
+        sig_printf("    R2 (dst addr):  0x%lx  (expected 0x%lx)\n",
+                   r2, expected_dst);
+        sig_printf("    R4 (src addr):  0x%lx  (expected 0x%lx)\n",
+                   r4, expected_src);
+        sig_printf("    R5 (src len):   0x%lx  (expected 0x%lx = PAGE_SIZE)\n",
+                   r5, (unsigned long)page_size);
+        sig_printf("    R6 (ctr addr):  0x%lx  (expected 0x%lx)\n",
+                   r6, expected_ctr);
+    }
+
+    /* R4 must point exactly to the start of the second source page */
+    if (r4 != expected_src) {
+        sig_printf("FAIL: R4 (src addr) = 0x%lx, expected 0x%lx\n",
+                   r4, expected_src);
+        pass = 0;
+    } else if (verbose) {
+        sig_printf("    R4 check: PASS\n");
+    }
+
+    /* R5 must equal exactly PAGE_SIZE (one full page remaining) */
+    if (r5 != (unsigned long)page_size) {
+        sig_printf("FAIL: R5 (src len) = 0x%lx, expected PAGE_SIZE = 0x%lx\n",
+                   r5, (unsigned long)page_size);
+        pass = 0;
+    } else if (verbose) {
+        sig_printf("    R5 check: PASS\n");
+    }
+
+    /* R2 must point exactly to dst_fault + PAGE_SIZE */
+    if (r2 != expected_dst) {
+        sig_printf("FAIL: R2 (dst addr) = 0x%lx, expected 0x%lx\n",
+                   r2, expected_dst);
+        pass = 0;
+    } else if (verbose) {
+        sig_printf("    R2 check: PASS\n");
+    }
+
+    /* R6 must point exactly to ctr_pages + PAGE_SIZE */
+    if (r6 != expected_ctr) {
+        sig_printf("FAIL: R6 (ctr addr) = 0x%lx, expected 0x%lx\n",
+                   r6, expected_ctr);
+        pass = 0;
+    } else if (verbose) {
+        sig_printf("    R6 check: PASS\n");
+    }
+
+    sigsegv_pass = pass;
+
+    if (verbose) {
+        sig_printf("  restoring PROT_READ on page at 0x%lx, resuming KMCTR\n",
+                   expected_src);
+    }
+
+    /* Restore read access so the restarted KMCTR can read the second page */
+    mprotect((void *)expected_src, page_size, PROT_READ);
+
+#undef sig_printf
+}
+
+int main(int argc, char *argv[])
+{
+    struct sigaction sa, old_sa;
+    uint8_t *src_pages, *dst_ref, *dst_fault, *ctr_pages;
+    /* KMCTR AES-128 parameter block: key only (16 bytes) */
+    uint8_t param[16];
+    unsigned long cc;
+    int rc = 0;
+
+    if (argc == 2 && strcmp(argv[1], "-v") == 0) {
+        verbose = 1;
+    } else if (argc > 1) {
+        fprintf(stderr, "usage: %s [-v]\n", argv[0]);
+        return EXIT_FAILURE;
+    }
+
+    page_size = getpagesize();
+
+    if (verbose) {
+        printf("page_size = %ld (0x%lx)\n", page_size, page_size);
+    }
+
+    /*
+     * Allocate two contiguous page-aligned source pages and fill them with
+     * a deterministic pseudo-random pattern so the test is reproducible.
+     */
+    src_pages = mmap(NULL, 2 * page_size, PROT_READ | PROT_WRITE,
+                     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+    if (src_pages == MAP_FAILED) {
+        perror("mmap src_pages");
+        return EXIT_FAILURE;
+    }
+    for (long i = 0; i < 2 * page_size; i++) {
+        src_pages[i] = (uint8_t)(i * 37 + 13);
+    }
+
+    /*
+     * Allocate two contiguous counter pages. Each AES_BLOCK_SIZE-aligned
+     * slot holds one counter block. Fill with a deterministic pattern that
+     * serves as distinct counter values for each block position.
+     */
+    ctr_pages = mmap(NULL, 2 * page_size, PROT_READ | PROT_WRITE,
+                     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+    if (ctr_pages == MAP_FAILED) {
+        perror("mmap ctr_pages");
+        munmap(src_pages, 2 * page_size);
+        return EXIT_FAILURE;
+    }
+    for (long i = 0; i < 2 * page_size; i++) {
+        ctr_pages[i] = (uint8_t)(i * 7 + 5);
+    }
+
+    /* Reference destination: two contiguous pages, initially zeroed */
+    dst_ref = mmap(NULL, 2 * page_size, PROT_READ | PROT_WRITE,
+                   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+    if (dst_ref == MAP_FAILED) {
+        perror("mmap dst_ref");
+        munmap(src_pages, 2 * page_size);
+        munmap(ctr_pages, 2 * page_size);
+        return EXIT_FAILURE;
+    }
+
+    /* Fault-run destination: two contiguous pages, initially zeroed */
+    dst_fault = mmap(NULL, 2 * page_size, PROT_READ | PROT_WRITE,
+                     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+    if (dst_fault == MAP_FAILED) {
+        perror("mmap dst_fault");
+        munmap(src_pages, 2 * page_size);
+        munmap(ctr_pages, 2 * page_size);
+        munmap(dst_ref,   2 * page_size);
+        return EXIT_FAILURE;
+    }
+
+    if (verbose) {
+        printf("src_pages: [0x%lx, 0x%lx)  page1=[0x%lx, 0x%lx)  page2=[0x%lx, 0x%lx)\n",
+               (unsigned long)src_pages,
+               (unsigned long)(src_pages + 2 * page_size),
+               (unsigned long)src_pages,
+               (unsigned long)(src_pages + page_size),
+               (unsigned long)(src_pages + page_size),
+               (unsigned long)(src_pages + 2 * page_size));
+        printf("ctr_pages: [0x%lx, 0x%lx)\n",
+               (unsigned long)ctr_pages,
+               (unsigned long)(ctr_pages + 2 * page_size));
+        printf("dst_ref:   [0x%lx, 0x%lx)\n",
+               (unsigned long)dst_ref,
+               (unsigned long)(dst_ref + 2 * page_size));
+        printf("dst_fault: [0x%lx, 0x%lx)\n",
+               (unsigned long)dst_fault,
+               (unsigned long)(dst_fault + 2 * page_size));
+    }
+
+    /* Build parameter block: key only for KMCTR AES-128 */
+    memcpy(param, aes128key, sizeof(aes128key));
+
+    /* ------------------------------------------------------------------ */
+    /* Reference run: encrypt both pages with no fault injection.         */
+    /* ------------------------------------------------------------------ */
+
+    if (verbose) {
+        printf("reference run: cpacf_kmctr AES-128 CTR over 2 pages (no faults)\n");
+    }
+
+    cpacf_kmctr(CPACF_KMCTR_AES_128, param, dst_ref,
+                src_pages, 2 * page_size, ctr_pages, &cc);
+    if (cc != 0) {
+        fprintf(stderr, "FAIL: reference run unexpected cc=%lu\n", cc);
+        rc = 1;
+        goto out;
+    }
+
+    if (verbose) {
+        printf("reference run: done, cc=0\n");
+    }
+
+    /* ------------------------------------------------------------------ */
+    /* Fault run: protect second source page, run KMCTR over both pages.  */
+    /* ------------------------------------------------------------------ */
+
+    /* Record the exact register values we expect at fault time */
+    expected_src  = (unsigned long)(src_pages + page_size);
+    expected_dst  = (unsigned long)(dst_fault + page_size);
+    expected_ctr  = (unsigned long)(ctr_pages + page_size);
+    sigsegv_count = 0;
+    sigsegv_pass  = 1;   /* handler sets to 0 on any check failure */
+
+    if (verbose) {
+        printf("fault run: expecting SIGSEGV when KMCTR reaches src page2 at 0x%lx\n",
+               expected_src);
+        printf("fault run: expected register state at fault:\n");
+        printf("  R2 (dst addr) = 0x%lx\n", expected_dst);
+        printf("  R4 (src addr) = 0x%lx\n", expected_src);
+        printf("  R5 (src len)  = 0x%lx\n", (unsigned long)page_size);
+        printf("  R6 (ctr addr) = 0x%lx\n", expected_ctr);
+    }
+
+    /* Install SIGSEGV handler */
+    memset(&sa, 0, sizeof(sa));
+    sa.sa_sigaction = sigsegv_handler;
+    sa.sa_flags     = SA_SIGINFO;
+    sigemptyset(&sa.sa_mask);
+    if (sigaction(SIGSEGV, &sa, &old_sa) != 0) {
+        perror("sigaction");
+        rc = 1;
+        goto out;
+    }
+
+    /* Protect the second source page to provoke a fault during KMCTR */
+    if (mprotect(src_pages + page_size, page_size, PROT_NONE) != 0) {
+        perror("mprotect PROT_NONE");
+        sigaction(SIGSEGV, &old_sa, NULL);
+        rc = 1;
+        goto out;
+    }
+
+    if (verbose) {
+        printf("fault run: second src page protected, starting cpacf_kmctr\n");
+    }
+
+    /*
+     * Encrypt both pages with a single cpacf_kmctr call.
+     *
+     * Page 1 is processed normally; registers are advanced block-by-block
+     * inside cpacf_aes_ctr. On the first read of the second source page the
+     * CPU takes a protection fault. The signal handler verifies R2/R4/R5/R6
+     * and restores PROT_READ. On return from the handler the KMCTR instruction
+     * is restarted with the already-advanced registers so it processes only
+     * the second page and completes with CC=0.
+     *
+     * The brc 1,0b loop inside cpacf_kmctr handles the unrelated CC=3
+     * (partial-completion) case and is not triggered by the page fault.
+     */
+    memcpy(param, aes128key, sizeof(aes128key));
+    cpacf_kmctr(CPACF_KMCTR_AES_128, param, dst_fault,
+                src_pages, 2 * page_size, ctr_pages, &cc);
+
+    /* Restore the original SIGSEGV disposition */
+    sigaction(SIGSEGV, &old_sa, NULL);
+
+    if (verbose) {
+        printf("fault run: cpacf_kmctr returned, cc=%lu, SIGSEGV count=%d\n",
+               cc, sigsegv_count);
+    }
+
+    if (cc != 0) {
+        fprintf(stderr, "FAIL: fault run unexpected cc=%lu\n", cc);
+        rc = 1;
+    }
+
+    /* ------------------------------------------------------------------ */
+    /* Verify: signal handler must have fired exactly once.               */
+    /* ------------------------------------------------------------------ */
+    if (sigsegv_count != 1) {
+        fprintf(stderr, "FAIL: expected 1 SIGSEGV, got %d\n", sigsegv_count);
+        rc = 1;
+    } else if (verbose) {
+        printf("check: SIGSEGV count = %d (expected 1): PASS\n", sigsegv_count);
+    }
+
+    /* ------------------------------------------------------------------ */
+    /* Verify: register checks inside the handler were correct.           */
+    /* ------------------------------------------------------------------ */
+    if (!sigsegv_pass) {
+        fprintf(stderr, "FAIL: register check in SIGSEGV handler failed\n");
+        rc = 1;
+    } else if (verbose) {
+        printf("check: register values in SIGSEGV handler: PASS\n");
+    }
+
+    /* ------------------------------------------------------------------ */
+    /* Verify: fault-run ciphertext matches the reference ciphertext.     */
+    /* ------------------------------------------------------------------ */
+    if (memcmp(dst_ref, dst_fault, 2 * page_size) != 0) {
+        fprintf(stderr, "FAIL: fault-run ciphertext does not match reference\n");
+        rc = 1;
+    } else if (verbose) {
+        printf("check: fault-run ciphertext matches reference ciphertext: PASS\n");
+    }
+
+    if (rc == 0) {
+        printf("cpacf-kmctr-ctr-fault: all checks passed\n");
+    }
+
+out:
+    munmap(src_pages, 2 * page_size);
+    munmap(ctr_pages, 2 * page_size);
+    munmap(dst_ref,   2 * page_size);
+    munmap(dst_fault, 2 * page_size);
+
+    return rc ? EXIT_FAILURE : EXIT_SUCCESS;
+}
diff --git a/tests/tcg/s390x/cpacf.h b/tests/tcg/s390x/cpacf.h
index c0578abd09..e89641b31d 100644
--- a/tests/tcg/s390x/cpacf.h
+++ b/tests/tcg/s390x/cpacf.h
@@ -60,15 +60,30 @@ static inline void encrypt_clrkey(uint8_t *key, int keysize)
  * encryption/decryption funcs
  */
 static inline int cpacf_km(unsigned long func, void *param,
-                           uint8_t *dest, const uint8_t *src, long src_len,
-                           unsigned long *cc)
+                            uint8_t *dest, const uint8_t *src, long src_len,
+                            unsigned long *cc)
 {
-    union register_pair d, s;
+    /*
+     * Pin the operand registers to known hardware numbers so that
+     * testcases have a clear understanding what's stored in each
+     * register:
+     *   R2  - destination address       (even of dst pair, gregs[2])
+     *   R3  - odd half of dst pair      (gregs[3], not used by KM but must be
+     *          reserved so the compiler does not place another variable there)
+     *   R4  - source address            (even of src pair, gregs[4])
+     *   R5  - source length             (odd  of src pair, gregs[5])
+     *
+     * KM R2, R4: R2 is updated (dst addr advances), R4/R5 are updated
+     * (src addr / remaining length).  R3 is not modified by KM but we
+     * list it as an output operand to prevent the compiler from allocating
+     * it to another variable that would be clobbered by the instruction.
+     */
+    register unsigned long r2 asm("r2") = (unsigned long)dest;
+    register unsigned long r3 asm("r3");   /* odd half of dst pair; reserved  */
+    register unsigned long r4 asm("r4") = (unsigned long)src;
+    register unsigned long r5 asm("r5") = (unsigned long)src_len;
 
     *cc = 0;
-    d.even = (unsigned long)dest;
-    s.even = (unsigned long)src;
-    s.odd  = (unsigned long)src_len;
     asm volatile(
                  "      lgr     0,%[fc]\n"
                  "      lgr     1,%[pba]\n"
@@ -79,12 +94,13 @@ static inline int cpacf_km(unsigned long func, void *param,
                  "      agsi    %[__cc],1\n"
                  "1:    agsi    %[__cc],1\n"
                  "2:\n"
-                 : [src] "+&d" (s.pair), [dst] "+&d" (d.pair), [__cc] "+Q" (*cc)
+                 : [dst] "+r" (r2), "=r" (r3), [src] "+r" (r4), "+r" (r5),
+                   [__cc] "+Q" (*cc)
                  : [fc] "d" (func), [pba] "d" ((unsigned long)param),
                    [opc] "i" (CPACF_KM)
                  : "cc", "memory", "0", "1");
 
-    return src_len - s.odd;
+    return src_len - (long)r5;
 }
 
 /**
@@ -99,15 +115,30 @@ static inline int cpacf_km(unsigned long func, void *param,
  * encryption/decryption funcs
  */
 static inline int cpacf_kmc(unsigned long func, void *param,
-                            uint8_t *dest, const uint8_t *src, long src_len,
-                            unsigned long *cc)
+                             uint8_t *dest, const uint8_t *src, long src_len,
+                             unsigned long *cc)
 {
-    union register_pair d, s;
+    /*
+     * Pin the operand registers to known hardware numbers so that
+     * testcases have a clear understanding what's stored in each
+     * register:
+     *   R2  - destination address       (even of dst pair, gregs[2])
+     *   R3  - odd half of dst pair      (gregs[3], not used by KMC but must be
+     *          reserved so the compiler does not place another variable there)
+     *   R4  - source address            (even of src pair, gregs[4])
+     *   R5  - source length             (odd  of src pair, gregs[5])
+     *
+     * KMC R2, R4: R2 is updated (dst addr advances), R4/R5 are updated
+     * (src addr / remaining length). R3 is not modified by KMC but we
+     * list it as an output operand to prevent the compiler from allocating
+     * it to another variable that would be clobbered by the instruction.
+     */
+    register unsigned long r2 asm("r2") = (unsigned long)dest;
+    register unsigned long r3 asm("r3");   /* odd half of dst pair; reserved */
+    register unsigned long r4 asm("r4") = (unsigned long)src;
+    register unsigned long r5 asm("r5") = (unsigned long)src_len;
 
     *cc = 0;
-    d.even = (unsigned long)dest;
-    s.even = (unsigned long)src;
-    s.odd  = (unsigned long)src_len;
     asm volatile(
                  "      lgr     0,%[fc]\n"
                  "      lgr     1,%[pba]\n"
@@ -118,12 +149,13 @@ static inline int cpacf_kmc(unsigned long func, void *param,
                  "      agsi    %[__cc],1\n"
                  "1:    agsi    %[__cc],1\n"
                  "2:\n"
-                 : [src] "+&d" (s.pair), [dst] "+&d" (d.pair), [__cc] "+Q" (*cc)
+                 : [dst] "+r" (r2), "=r" (r3), [src] "+r" (r4), "+r" (r5),
+                   [__cc] "+Q" (*cc)
                  : [fc] "d" (func), [pba] "d" ((unsigned long)param),
                    [opc] "i" (CPACF_KMC)
                  : "cc", "memory", "0", "1");
 
-    return src_len - s.odd;
+    return src_len - (long)r5;
 }
 
 /**
@@ -272,16 +304,33 @@ static inline int cpacf_kmac_x(unsigned long *func, void *param,
  * encryption/decryption funcs
  */
 static inline int cpacf_kmctr(unsigned long func, void *param, uint8_t *dest,
-                              const uint8_t *src, long src_len,
-                              uint8_t *counter, unsigned long *cc)
+                               const uint8_t *src, long src_len,
+                               uint8_t *counter, unsigned long *cc)
 {
-    union register_pair d, s, c;
+    /*
+     * Pin the operand registers to known hardware numbers so that
+     * testcases have a clear understanding what's stored in each
+     * register:
+     *   R2  - destination address       (even of dst pair, gregs[2])
+     *   R3  - odd half of dst pair      (gregs[3], not used by KMCTR)
+     *   R4  - source address            (even of src pair, gregs[4])
+     *   R5  - source length             (odd  of src pair, gregs[5])
+     *   R6  - counter address           (even of ctr pair, gregs[6])
+     *   R7  - odd half of ctr pair      (gregs[7], not used by KMCTR)
+     *
+     * KMCTR R2, R4, R6: R2 is updated (dst addr advances), R4/R5 are updated
+     * (src addr / remaining length), R6 is updated (ctr addr advances).
+     * R3 and R7 are not modified by KMCTR but are listed as output operands
+     * to prevent the compiler from allocating them to other variables.
+     */
+    register unsigned long r2 asm("r2") = (unsigned long)dest;
+    register unsigned long r3 asm("r3");   /* odd half of dst pair; reserved  */
+    register unsigned long r4 asm("r4") = (unsigned long)src;
+    register unsigned long r5 asm("r5") = (unsigned long)src_len;
+    register unsigned long r6 asm("r6") = (unsigned long)counter;
+    register unsigned long r7 asm("r7");   /* odd half of ctr pair; reserved  */
 
     *cc = 0;
-    d.even = (unsigned long)dest;
-    s.even = (unsigned long)src;
-    s.odd  = (unsigned long)src_len;
-    c.even = (unsigned long)counter;
     asm volatile(
                  "      lgr     0,%[fc]\n"
                  "      lgr     1,%[pba]\n"
@@ -292,13 +341,15 @@ static inline int cpacf_kmctr(unsigned long func, void *param, uint8_t *dest,
                  "      agsi    %[__cc],1\n"
                  "1:    agsi    %[__cc],1\n"
                  "2:\n"
-                 : [src] "+&d" (s.pair), [dst] "+&d" (d.pair),
-                   [ctr] "+&d" (c.pair), [__cc] "+Q" (*cc)
+                 : [dst] "+r" (r2), "=r" (r3),
+                   [src] "+r" (r4), "+r" (r5),
+                   [ctr] "+r" (r6), "=r" (r7),
+                   [__cc] "+Q" (*cc)
                  : [fc] "d" (func), [pba] "d" ((unsigned long)param),
                    [opc] "i" (CPACF_KMCTR)
                  : "cc", "memory", "0", "1");
 
-    return src_len - s.odd;
+    return src_len - (long)r5;
 }
 
 /**
diff --git a/tests/tcg/s390x/meson.build b/tests/tcg/s390x/meson.build
index f2328d9e5c..693c7d2a64 100644
--- a/tests/tcg/s390x/meson.build
+++ b/tests/tcg/s390x/meson.build
@@ -78,9 +78,13 @@ tests += {
   'cpacf-kimd.c': {},
   'cpacf-klmd.c': {},
   'cpacf-km.c': {},
+  'cpacf-km-ecb-fault.c': {},
+  'cpacf-km-xts-fault.c': {},
   'cpacf-kmac.c': {},
   'cpacf-kmc.c': {},
+  'cpacf-kmc-cbc-fault.c': {},
   'cpacf-kmctr.c': {},
+  'cpacf-kmctr-ctr-fault.c': {},
   'cpacf-pcc.c': {},
   'cpacf-pckmo.c': {},
   'cpacf-prno.c': {},
-- 
2.56.0


