Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A31606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 16:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ie8d6iGI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWG4m-00061S-8g; Wed, 25 Nov 2026 11:42:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1xWG4e-00060P-Pt; Wed, 25 Nov 2026 11:42:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1xWG4U-00077i-Ud; Wed, 25 Nov 2026 11:42:22 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6APGYaBg1799222; Wed, 25 Nov 2026 16:41:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=8J2arm
 fnbA2xcBzCfCPE08Be2J5Qg78h80MFw8lLC90=; b=ie8d6iGIWAWw0YPrqEmChA
 +oMP2NmPZNbSdH1z3p8YynCIaNLHnMXQ6ZGL5IrKdXiZpphYZqkx5AXFO6fexg11
 iY7enffQcwGRWLqAQvb6KWe5Le1xLrQP9uSR5Hafvpk4f4dTD0mFUoclT1JOcm/r
 aOGs0UYH9oYCheuFLO9n3dAQH98Cj6oJSVEIdclt3odTQm+bDy/DrKg0m/eXCCs4
 trQk49yOxVDNYD7YNAgHDtUDLV4NNbfOVpzUbo11bBCOJ9WvRSQsX955xTlea4XI
 bi3PdgAVj8GGkVXpe4UENyeB3SS6sy9HrmP+Hps9DA0s9sC8m8t68YR/5sXbuo0A
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34gvd07q-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 25 Nov 2026 16:41:59 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6APGYLqb1063132; Wed, 25 Nov 2026 16:41:58 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j5dcuv334-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Nov 2026 16:41:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6APGfra244564798
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Nov 2026 16:41:54 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D0F8E2004E;
 Wed, 25 Nov 2026 16:41:53 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8230620049;
 Wed, 25 Nov 2026 16:41:53 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.11.72])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 25 Nov 2026 16:41:53 +0000 (GMT)
Message-ID: <829af07e-9d11-4ad5-9818-94a12a4a1407@linux.ibm.com>
Date: Wed, 25 Nov 2026 17:41:53 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] tests/s390x/tcg: Add cpacf clear key register
 update tests
To: Andrew Holden <andy0x48@linux.ibm.com>, qemu-devel@nongnu.org,
 freude@linux.ibm.com
Cc: qemu-s390x@nongnu.org, richard.henderson@linaro.org, david@kernel.org,
 cohuck@redhat.com, farman@linux.ibm.com, mjrosato@linux.ibm.com
References: <20261120131443.61606-1-andy0x48@linux.ibm.com>
 <20261120131443.61606-4-andy0x48@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261120131443.61606-4-andy0x48@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=CYCdd7rl c=1 sm=1 tr=0 ts=6b070fd7 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=6sI_RnkXhvEJrAPJccEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA2NiBTYWx0ZWRfX5QBOf9ZljpOU
 GGUfILwY3X/SaPJ5bgjR/fPSXy6aUP7EN5/lFlUSolG+5JU9lfyIJeajKhMJNdBdLWE1YWWkW6+
 9XkEvNz9r9coK9Uwbzyn03+y52+niCw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA2NiBTYWx0ZWRfX1BUC3a1lXxiH
 ZoFRZ9hQ0dUGwOiyRL/W56bwqtDbgI8jRqA3WLwAK3gbL4m2DSLemgH/0/07wV2KlhrInoSl8oB
 Nz7LjCRIC3bjgm6Y84Ig5fdglLBL4yFMzzANsQO0o/Jd1mwscaFRZ6bFqkAYuCS8S95hQXCpqeb
 7pdtIlpC3oWddgQq9GaeE899Lx/j61z2e1y8svyJ3TKeHm2xFb7iKCFp2wT0zqVxOBCT+3EYSCs
 IE9EiulRaVFlfjeUezcmVN6emSCKmQNvg1rtUlj6fswA41gbuqI5s2ItXh1He6b3u427oqJQgq9
 zz9djLFyqqucg/r/Bn1VBubvst8HKbqLWZM9Xtt5U58FAfRA+D5naR8SChxe2S3i2D8ANfce3eH
 ioC4k7pp18lZofsxhDOC0Uj/hsLqn0mDobgsYMM21snorHGmKMu3MqNM9PYt3V+aMAWiD1UQJa7
 sj4w1dgXm7dKi1IB4uw==
X-Proofpoint-ORIG-GUID: 5_ViljGsPuBcCmVt02NSh2McQcDGj0V5
X-Proofpoint-GUID: 5_ViljGsPuBcCmVt02NSh2McQcDGj0V5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_04,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611250066
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/20/26 14:14, Andrew Holden wrote:
> From: Harald Freudenberger <freude@linux.ibm.com>
> 
> Add simple test cases for the 4 clear key cpacf implementation
> functions cpacf_aes_ecb(), cpacf_aes_cbc(), cpacf_aes_ctr() and
> cpacf_aes_xts() which shall test if the register update and memory
> update during processing of data within the cpacf instruction (km,
> kmc, kmctr) emulation is correct. See details about how the test cases
> are designed and actually work testcase code. Note that as there is a
> signal handler evaluating the registers on the enforced address
> violation the cpacf.h inline function needs to use pinned registers.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Signed-off-by: Andrew Holden <andy0x48@linux.ibm.com>
> ---
>   tests/tcg/s390x/cpacf-km-ecb-fault.c    | 368 +++++++++++++++++
>   tests/tcg/s390x/cpacf-km-xts-fault.c    | 511 ++++++++++++++++++++++++
>   tests/tcg/s390x/cpacf-kmc-cbc-fault.c   | 472 ++++++++++++++++++++++
>   tests/tcg/s390x/cpacf-kmctr-ctr-fault.c | 414 +++++++++++++++++++
>   tests/tcg/s390x/cpacf.h                 | 103 +++--
>   tests/tcg/s390x/meson.build             |   4 +
>   6 files changed, 1846 insertions(+), 26 deletions(-)
>   create mode 100644 tests/tcg/s390x/cpacf-km-ecb-fault.c
>   create mode 100644 tests/tcg/s390x/cpacf-km-xts-fault.c
>   create mode 100644 tests/tcg/s390x/cpacf-kmc-cbc-fault.c
>   create mode 100644 tests/tcg/s390x/cpacf-kmctr-ctr-fault.c
> 
> diff --git a/tests/tcg/s390x/cpacf-km-ecb-fault.c b/tests/tcg/s390x/cpacf-km-ecb-fault.c
> new file mode 100644
> index 0000000000..3fe7df1f04
> --- /dev/null
> +++ b/tests/tcg/s390x/cpacf-km-ecb-fault.c
> @@ -0,0 +1,368 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Test for register update correctness in cpacf_aes_ecb (KM AES-128 ECB).
> + *
> + * All the CPACF instructions are designed in a way that on exit
> + * the registers are updated so that on incomplete processing (partial
> + * completion) the instruction can just be re-invoked. The QEMU emulation
> + * of the CPACF instructions needs to obey that rule as well.
> + * This testcase checks the correct update of the register values by
> + * triggering a page protection fault in the middle of the data. The
> + * signal handler then checks for the expected register values. After
> + * that the page is enabled for reading, causing the OS to restart the
> + * instruction which continues to process the remaining data. Finally
> + * the encryption result is checked to match the expectations.
> + *
> + * Test sequence:
> + *  1. Allocate two contiguous, page-aligned source pages filled with
> + *     pseudo-random data and two matching destination pages.
> + *  2. Reference run: encrypt both source pages with cpacf_km AES-128 ECB
> + *     into the reference destination buffer (no faults).
> + *  3. Fault run:
> + *     a. Protect the second source page (PROT_NONE).
> + *     b. Install a SIGSEGV handler.
> + *     c. Call cpacf_km over both pages (2 * PAGE_SIZE bytes).
> + *     d. On the SIGSEGV verify:
> + *          - si_addr lies within the second source page.
> + *          - R4 (src address) equals exactly the start of the second source
> + *            page (all blocks of page 1 were already consumed).
> + *          - R5 (remaining src length) equals exactly PAGE_SIZE.
> + *          - R2 (dst address) equals exactly dst_fault + PAGE_SIZE.
> + *     e. Restore PROT_READ on the second source page and return from the
> + *        handler so KM re-executes from the updated registers and finishes.
> + *  4. Compare the fault-run output to the reference output; they must match.
> + *
> + * cpacf_km() in cpacf.h uses pinned registers R2/R4/R5 for its operands,
> + * so the signal handler can read them reliably via ucontext_t.
> + *
> + * Usage: cpacf-km-ecb-fault [-v]
> + *   -v  verbose: print details about each step and every register check.
> + */
> +
> +#include <signal.h>
> +#include <stdio.h>
> +#include <stdint.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/mman.h>
> +#include <ucontext.h>
> +#include <unistd.h>
> +#include "cpacf.h"
> +
> +/* AES-128 key used for all encryptions in this test */
> +static const uint8_t aes128key[16] = {
> +    0xed, 0xfd, 0xb2, 0x57, 0xcb, 0x37, 0xcd, 0xf1,
> +    0x82, 0xc5, 0x45, 0x5b, 0x0c, 0x0e, 0xfe, 0xbb
> +};
> +
> +/* Page size, determined at runtime */
> +static long page_size;
> +
> +/* Verbose flag: set by -v on the command line */
> +static int verbose;
> +
> +/*
> + * State shared between main() and the SIGSEGV handler.
> + * volatile prevents the compiler from optimising away accesses.
> + */
> +static volatile int           sigsegv_count; /* how many times handler fired */
> +static volatile int           sigsegv_pass;  /* 1 = all register checks fine */
> +static volatile unsigned long expected_src;  /* exact expected R4 value */
> +static volatile unsigned long expected_dst;  /* exact expected R2 value */
> +
> +/*
> + * SIGSEGV handler.
> + *
> + * At fault time the KM instruction has already advanced its operand registers
> + * past all fully processed blocks. For the second-page fault:
> + *   R2 = dst_fault + PAGE_SIZE  (destination pointer into second output page)
> + *   R4 = src_pages + PAGE_SIZE  (source pointer at start of second source page)
> + *   R5 = PAGE_SIZE              (exactly one page of source data remaining)
> + * Note that this requires using the inline function cpacf_km() from cpacf.h
> + * which uses pinned registers for the parameters and this has to be in
> + * alignment with the code here.
> + *
> + * After verifying these values the handler restores read permission on the
> + * second source page and returns. The signal return mechanism re-executes
> + * the KM instruction from the updated register state, completing the run.
> + */
> +static void sigsegv_handler(int sig, siginfo_t *si, void *uctx_arg)
> +{
> +    /*
> +     * No printf within signal handler, but write() can be used. So this
> +     * little sig_printf() macro is a replacement to fprintf(stderr, ...)
> +     */
> +#define sig_printf(...) do { \
> +        char printfbuf[256]; \
> +        int len = snprintf(printfbuf, sizeof(printfbuf), __VA_ARGS__); \

I think this also allocates memory and thus is also not in the
"man signal-safety" list.

> +        write(STDERR_FILENO, printfbuf, len); \
> +    } while (0)
> +
> +    ucontext_t *uc = (ucontext_t *)uctx_arg;
> +    unsigned long r2, r4, r5;
> +    int pass = 1;
> +
> +    sigsegv_count++;
> +
> +    /*
> +     * On s390x, glibc's mcontext_t exposes the GPRs as gregs[].
> +     */
> +    r2 = uc->uc_mcontext.gregs[2];  /* KM destination address register */
> +    r4 = uc->uc_mcontext.gregs[4];  /* KM source address register      */
> +    r5 = uc->uc_mcontext.gregs[5];  /* KM source length register       */
> +
> +    if (verbose) {
> +        sig_printf("  SIGSEGV #%d: si_addr=0x%lx\n",
> +                   sigsegv_count, (unsigned long)si->si_addr);
> +        sig_printf("    R2 (dst addr):  0x%lx  (expected 0x%lx)\n",
> +                   r2, expected_dst);
> +        sig_printf("    R4 (src addr):  0x%lx  (expected 0x%lx)\n",
> +                   r4, expected_src);
> +        sig_printf("    R5 (src len):   0x%lx  (expected 0x%lx = PAGE_SIZE)\n",
> +                   r5, (unsigned long)page_size);
> +    }
> +
> +    /* R4 must point exactly to the start of the second source page */
> +    if (r4 != expected_src) {
> +        sig_printf("FAIL: R4 (src addr) = 0x%lx, expected 0x%lx\n",
> +                   r4, expected_src);
> +        pass = 0;
> +    } else if (verbose) {
> +        sig_printf("    R4 check: PASS\n");
> +    }
> +
> +    /* R5 must equal exactly PAGE_SIZE (one full page remaining) */
> +    if (r5 != (unsigned long)page_size) {
> +        sig_printf("FAIL: R5 (src len) = 0x%lx, expected PAGE_SIZE = 0x%lx\n",
> +                   r5, (unsigned long)page_size);
> +        pass = 0;
> +    } else if (verbose) {
> +        sig_printf("    R5 check: PASS\n");
> +    }
> +
> +    /* R2 must point exactly to dst_fault + PAGE_SIZE */
> +    if (r2 != expected_dst) {
> +        sig_printf("FAIL: R2 (dst addr) = 0x%lx, expected 0x%lx\n",
> +                   r2, expected_dst);
> +        pass = 0;
> +    } else if (verbose) {
> +        sig_printf("    R2 check: PASS\n");
> +    }
> +
> +    sigsegv_pass = pass;
> +
> +    if (verbose) {
> +        sig_printf("  restoring PROT_READ on page at 0x%lx, resuming KM\n",
> +                   expected_src);
> +    }
> +
> +    /* Restore read access so the restarted KM can read the second page */
> +    mprotect((void *)expected_src, page_size, PROT_READ);
> +
> +#undef sig_printf
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +    struct sigaction sa, old_sa;
> +    uint8_t *src_pages, *dst_ref, *dst_fault;
> +    uint8_t param[16];       /* AES-128 parameter block (key only for ECB) */
> +    unsigned long cc;
> +    int rc = 0;
> +
> +    if (argc == 2 && strcmp(argv[1], "-v") == 0) {
> +        verbose = 1;
> +    } else if (argc > 1) {
> +        fprintf(stderr, "usage: %s [-v]\n", argv[0]);
> +        return EXIT_FAILURE;
> +    }

I would make it always verbose and drop parameterization.
Suppose it fails it GitLab CI; we want to have as much data as possible.

> +
> +    page_size = getpagesize();
> +
> +    if (verbose) {
> +        printf("page_size = %ld (0x%lx)\n", page_size, page_size);
> +    }
> +
> +    /*
> +     * Allocate two contiguous page-aligned source pages and fill them with
> +     * a deterministic pseudo-random pattern so the test is reproducible.
> +     */
> +    src_pages = mmap(NULL, 2 * page_size, PROT_READ | PROT_WRITE,
> +                     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +    if (src_pages == MAP_FAILED) {
> +        perror("mmap src_pages");
> +        return EXIT_FAILURE;
> +    }
> +    for (long i = 0; i < 2 * page_size; i++) {
> +        src_pages[i] = (uint8_t)(i * 37 + 13);
> +    }
> +
> +    /* Reference destination: two contiguous pages, initially zeroed */
> +    dst_ref = mmap(NULL, 2 * page_size, PROT_READ | PROT_WRITE,
> +                   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +    if (dst_ref == MAP_FAILED) {
> +        perror("mmap dst_ref");
> +        munmap(src_pages, 2 * page_size);
> +        return EXIT_FAILURE;
> +    }
> +
> +    /* Fault-run destination: two contiguous pages, initially zeroed */
> +    dst_fault = mmap(NULL, 2 * page_size, PROT_READ | PROT_WRITE,
> +                     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +    if (dst_fault == MAP_FAILED) {
> +        perror("mmap dst_fault");
> +        munmap(src_pages, 2 * page_size);
> +        munmap(dst_ref,   2 * page_size);
> +        return EXIT_FAILURE;
> +    }
> +
> +    if (verbose) {
> +        printf("src_pages: [0x%lx, 0x%lx)  page1=[0x%lx, 0x%lx)  page2=[0x%lx, 0x%lx)\n",
> +               (unsigned long)src_pages,
> +               (unsigned long)(src_pages + 2 * page_size),
> +               (unsigned long)src_pages,
> +               (unsigned long)(src_pages + page_size),
> +               (unsigned long)(src_pages + page_size),
> +               (unsigned long)(src_pages + 2 * page_size));
> +        printf("dst_ref:   [0x%lx, 0x%lx)\n",
> +               (unsigned long)dst_ref,
> +               (unsigned long)(dst_ref + 2 * page_size));
> +        printf("dst_fault: [0x%lx, 0x%lx)\n",
> +               (unsigned long)dst_fault,
> +               (unsigned long)(dst_fault + 2 * page_size));
> +    }

The tests have quite a lot of duplication; I understand that sometimes
things are subtly different, e.g., tweak vs no-tweak versions, but maybe
there is still some chance to share at least some code between them?


The cover letter mentions this already, so - can we have similar tests
for cpacf_paes_xts() and friends?

[...]

