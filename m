Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5280606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 14:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PKoLBMQ6;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OcyDlAcj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQQDy-0001o7-3a; Mon, 09 Nov 2026 09:19:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQQDZ-0001TG-8u
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 09:19:35 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQQDW-0002LT-J7
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 09:19:29 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9DFMIi359447
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 14:19:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Oep3lZ5Z+HiQoInTclSYD+FhmXKAKMUQTFGLIXW+AQQ=; b=PKoLBMQ6WKB2OIy5
 0Cf8ai82PerUxZQB1lrHWfEu56nfCLQA8ZVcrsbfY23giaqJhOXKeVD+pXalPGK9
 R4OtZ0hFSMggs2MxIM4WMracY9QDFQnGMelRMfQ8iEYwcxWYx37XivSK5mGV4VbW
 lkDDoI2HZHBlrGH1FweAUSG/QVLGaGclRoObUOoOS8WjICFYLWc418maoRguRhlw
 fWFFtUwTABVSb7AjiuOXDaotR0tfIJAP875+KzYZPN5zixOR7VfUVkZKscOFhM0Y
 OvNV2+RSKiwoHHx3ZbiFfFAlln1+4Rq5is8FcHfIKHplkszzkB26lpzRbQfJ3t2l
 TXEjfQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hu6x2j11t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 14:19:24 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93cb93c874bso206720485a.0
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 06:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794233964; x=1794838764; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Oep3lZ5Z+HiQoInTclSYD+FhmXKAKMUQTFGLIXW+AQQ=;
 b=OcyDlAcjhpUugdi+olJ2M5RYtdAiPnp3DnbXbxpkL0skSiiLIuTCMwaW5ErT/HqlCW
 9kTcof6YOPqmzh02cIwI6mfqTy+oVDpG4PBGkZX2QiVW7oeLndJpXpxYBS6Yv3JI6NK/
 o62zVJ+PKaOOScv08VsMfAkl7Z3bbN1U+imP+x9PR7+uJoOCetK6J766eiNzYbOGORRC
 Wz+ZoJkp0BWmXckhywu2sqJvHSkMsrY/LZp8cYNzkRvByyFJnQwBlRqedtXgKiiRUbi9
 J5vRJGJTJsZydXOC1fLmylZQoi0S2/M4Ale6kLbbSW5cAl7VQk1M1IpdDqZUmuOvmCAI
 V3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794233964; x=1794838764;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Oep3lZ5Z+HiQoInTclSYD+FhmXKAKMUQTFGLIXW+AQQ=;
 b=N1THDfF3NwZ1MTGM9FcPZzdgg7GdupobIGohZl+VQXlpIIm92L5yCiEbJdNSR9odzj
 tM1wg41l8uP06GOJEwbAYDuzBug9tBUMrUK+CqVMVNvOcYw258CzvBsL2LOy5kbmdOtc
 mMwCRLXdlCVAdMHQ2e6DdkMLF0mpoXCh/RRmXuipHZGyiwYadvQIjrblhWLI9SehO+KZ
 vvxZ17Ai5O9M1B0OI1Ru4yMNCZu0Fn4l78XDIACK6CgFeHrO1bwSd07Q7E+vGA1vvUUl
 eRT+gIu1QKhkgTcO17Na88VGwsMqbv5lMAuA5w8cl/6DffdyzJLu8M+rxKCf4Hx+n7/K
 gmOQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEOnzp9AjtYKVaSYJPFKqLzKazVhz/e8lwk9NvMgXWdrSIc9VhE3oPCIQivXopaCoTOHIWp6YNuc2eX@nongnu.org
X-Gm-Message-State: APuU4Z+73pZbvowKECxtYIRGOrLBDElrgLDF8FLrkehoQeFIgcEhBMDk
 TekhlT3N7R2fYv5I+B1xxsx+Y6gKs9rK5KLTZ/NTvW1jRyBB3MN/BD5MBQc0ap17JElOZMiR7lF
 v/7hH17FsziULQh80q+qR98GMr8yToIEvTJ2exzD6oXvyxl12cdnceC9p+w==
X-Gm-Gg: AYBFou0ybumYMD9r+r8CKMzYfLbJm1PEyjOmuHYWCKrWz0iC4kD+CxZCQa3rNN8r+0J
 puAQrmPlwHhGHTdT9JMwjm2YoEHuhdehctRA10GNgKTH+V1vPvYKb12kbpWzOyCjSmKbYcLfclw
 pgqj4qCNx50eOD2ly8+5B/VdONBdPNHtzk3mIeDkfYrQpJHynp/anCvWidZ7UD1/k0LhrqtyRyJ
 BwHjKYW6XQrhMWTcuySwqa3Wf0920E2ALhJLaP2dgsgbCJ1Aw3+/qj0gKMm6f7SJYjYHq5tKIh7
 tutF0y4xUu8fMVY8knwUd6iLuqhQLWtONOMEvlovYDeQisV+XF/0P/h3ReRdQxnIeQj6oxEVUq9
 kpMXwPzz79DhK8fskMhHH9PjBmZJcCPibuP8T28ia1f1AE4kO6d6+P00D+apstfoTCciwHxZvoN
 bD3ewjYjFB
X-Received: by 2002:a05:620a:1a1a:b0:944:1e9b:e674 with SMTP id
 af79cd13be357-94604d56beemr1191356285a.17.1794233964018; 
 Mon, 09 Nov 2026 06:19:24 -0800 (PST)
X-Received: by 2002:a05:620a:1a1a:b0:944:1e9b:e674 with SMTP id
 af79cd13be357-94604d56beemr1191348285a.17.1794233963384; 
 Mon, 09 Nov 2026 06:19:23 -0800 (PST)
Received: from [192.168.68.100] ([152.234.124.231])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-94782ccaea3sm484662285a.4.2026.11.09.06.19.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 06:19:22 -0800 (PST)
Message-ID: <b6ce619a-7968-4edd-991d-0a27a374e857@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 11:19:19 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tests/tcg/riscv64: test faults on implicit VS-stage
 page-table accesses
To: tewaro <tewaro@theorem.dev>, qemu-devel@nongnu.org
Cc: disclosures@theorem.dev, tewaro <tewaro@tewaro.org>, imaginos32@gmail.com, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
References: <20260705140508.17692-1-imaginos32@gmail.com>
 <cover.1793677944.git.tewaro@theorem.dev>
 <32390ac8968372d34e299974d20db5fe25bbe2f1.1793677944.git.tewaro@theorem.dev>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <32390ac8968372d34e299974d20db5fe25bbe2f1.1793677944.git.tewaro@theorem.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TMjQ2Fla c=1 sm=1 tr=0 ts=6af1d66c cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=8elE1k/PHQNyZ14TNTodlQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=5jPfotcHxaXWx8lUfTYA:9 a=OodHsDdFA-Wr_Rxq:21
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA1NiBTYWx0ZWRfX40po/lyV0urq
 Pvu906OKsnruBskSuOSvxFJh5/RvN52axL/UWLTS5OVBonNrg8xt1POdGCA6rQKi1Z32Hcb70rc
 N80FaGcniYIX02WAcIwfuN/WaiZGdtR/tvwm71rCyHFW7RRK+A+X8f9w24xX4PRcJRgrtcW72HB
 8DgsS1uuNwgNOHPF3MFS2D+VCM804K073hysBaVuK1Hjpve4Nn7jDKB+SB0CCLqx7CxP9mAzI2d
 0Wlv+cNa/5jr4ZSflAp88Wto8k5Mu/fzBYpXO5aaMqqQjS3G2qAYTZoU5Zqw2somJuzHkHPST8H
 alP/NXZszbuoz+oamVFNWsF3KOsvEWV4FV7FstPIH9uUUnksLsNs+5BXj49JMZLMqV5q+9ozS5g
 BLa+M2eAZcJiGQSwfmiBMDSq4qWaSPbhdj/PDR3Vs431K05PyvtGAp6pChgHM9uzasBM06f9vYy
 q0tGY+MiFO3k6VFDnyA==
X-Proofpoint-GUID: 0x_pUi9gU0cdG10xPMy7Ri_UCYFp8Dxl
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA1NiBTYWx0ZWRfXxARKmGAZeHP8
 nUrIfv+Vz6nonlTg4UBVLfCdP24N4Ef/mgqtSoru2+0ZVGITKVEjRY65kBtNn0VMUCvFvwJg3K6
 PodT5TszxomtYUtqYK4ym3BqqUamRWM=
X-Proofpoint-ORIG-GUID: 0x_pUi9gU0cdG10xPMy7Ri_UCYFp8Dxl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090056
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/3/2026 4:29 AM, tewaro wrote:
> When a guest accesses memory, the hardware walks the guest's page tables.
> The guest reads the entries and, with Svadu, writes the A/D bits. The
> G-stage checks these reads and writes like any other guest access. If it
> refuses one, the guest-page fault reports:
> 
> - cause: the type of the guest's original access
> - mtval2/htval: the guest-physical address of the entry, >> 2
> - mtinst/htinst: 0x3000 if the walk was reading, 0x3020 if writing
> 
> test-gstage-tinst checks 19 cases:
> 
>    case          access  from  G-stage refuses  reports
>    ------------  ------  ----  ---------------  -----------------
>    load          ld      VS    A write          load GPF, 0x3020
>    fetch         jr      VS    A write          fetch GPF, 0x3020
>    store         sd      VS    D write          store GPF, 0x3020
>    store-ad      sd      VS    A/D write        store GPF, 0x3020
>    amo           amoadd  VS    D write          store GPF, 0x3020
>    load-4k       ld      VS    A write          load GPF, 0x3020
>    load-1g       ld      VS    A write          load GPF, 0x3020
>    load-vu       ld      VU    A write          load GPF, 0x3020
>    hlv           hlv.d   HS    A write          load GPF, 0x3020
>    hsv           hsv.d   HS    D write          store GPF, 0x3020
>    load-hs       ld      VS    A write          load GPF, 0x3020
>    store-hs      sd      VS    D write          store GPF, 0x3020
>    hlv-noread    hlv.d   HS    root PTE read    load GPF, 0x3000
>    hsv-noread    hsv.d   HS    root PTE read    store GPF, 0x3000
>    fetch-noread  fetch   VS    root PTE read    fetch GPF, 0x3000
>    noadue-h      ld      VS    -                load PF
>    noadue-m      ld      VS    -                load PF
>    noadue-store  sd      VS    -                store PF
>    control       sd      VS    the store        store GPF
> 
> - Leaves are 2 MiB, except in load-4k and load-1g.
> - Faults trap to M-mode, except in load-hs and store-hs.
> - The noadue cases turn ADUE off, so nothing is written and the fault
>    is an ordinary page fault.
> - In control the guest itself stores into its read-only tables. That
>    is not a walk, so tinst must be neither 0x3000 nor 0x3020.

A good test coverage is always appreciated.

> 
> Booting, the page tables and entering the guest are in hyp-guest.h and
> hyp-guest.S, for reuse by other hypervisor tests. The trap handlers,
> which make the checks, are in the test.
> 
> Each case is its own test, built with the -D flags listed in
> meson.build, and exits with 0 or the number of the first check that
> failed. Happy to test in a different way if that is desired.
> 
> Signed-off-by: tewaro <tewaro@theorem.dev>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   tests/tcg/riscv64/hyp-guest.S         | 110 +++++++++++++++++++++
>   tests/tcg/riscv64/hyp-guest.h         |  71 ++++++++++++++
>   tests/tcg/riscv64/system/meson.build  |  77 +++++++++++++++
>   tests/tcg/riscv64/test-gstage-tinst.S | 135 ++++++++++++++++++++++++++
>   4 files changed, 393 insertions(+)
>   create mode 100644 tests/tcg/riscv64/hyp-guest.S
>   create mode 100644 tests/tcg/riscv64/hyp-guest.h
>   create mode 100644 tests/tcg/riscv64/test-gstage-tinst.S
> 
> diff --git a/tests/tcg/riscv64/hyp-guest.S b/tests/tcg/riscv64/hyp-guest.S
> new file mode 100644
> index 0000000000..31dc37810c
> --- /dev/null
> +++ b/tests/tcg/riscv64/hyp-guest.S
> @@ -0,0 +1,110 @@
> +/*
> + * Routines for the riscv64 hypervisor-extension system tests targeting
> + * page-table translations between the host and guest.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#include "hyp-guest.h"
> +
> +#define FLUSH fence rw, rw; sfence.vma; hfence.vvma; hfence.gvma; fence.i
> +
> +        .option norvc
> +        .text
> +        .global _start, set_tables_perm, run_guest, exit
> +_start:
> +        lla     sp, stack_top
> +        lla     t0, trap
> +        csrw    mtvec, t0
> +        lla     t0, hs_trap
> +        csrw    stvec, t0
> +        li      t0, -1                  /* no PMP restrictions */
> +        csrw    pmpaddr0, t0
> +        li      t0, 0x1f
> +        csrw    pmpcfg0, t0
> +        li      t0, ADUE                /* hardware A/D updating */
> +        csrw    menvcfg, t0
> +        csrw    henvcfg, t0
> +        li      t0, 0x100               /* hstatus.SPVP: hlv/hsv act as VS */
> +        csrs    hstatus, t0
> +
> +        /* G-stage: regions 0-24, 1:1, all accessible */
> +        li      t0, G_ROOT + 2 * 8
> +        li      t1, table(G_L1)
> +        sd      t1, 0(t0)
> +        li      t0, G_L1
> +        li      t1, leaf(REGION(0), G_RW)
> +        li      t2, 0x200000 >> 2
> +        li      t3, 25
> +1:      sd      t1, 0(t0)
> +        add     t1, t1, t2
> +        addi    t0, t0, 8
> +        addi    t3, t3, -1
> +        bnez    t3, 1b
> +
> +        /* guest: the code, the code again for VU, the 4 KiB table */
> +        li      t0, VS_ROOT + 2 * 8
> +        li      t1, table(VS_L1)
> +        sd      t1, 0(t0)
> +        li      t0, VS_L1
> +        li      t1, leaf(REGION(0), G_RW & ~PTE_U)
> +        sd      t1, 0(t0)
> +        li      t1, leaf(REGION(0), G_RO & ~PTE_W)
> +        sd      t1, 24 * 8(t0)
> +        li      t1, table(VS_L0)
> +        sd      t1, 8 * 8(t0)
> +
> +        li      t0, (8 << 60) | (G_ROOT >> 12)
> +        csrw    hgatp, t0
> +        li      t0, (8 << 60) | (VS_ROOT >> 12)
> +        csrw    vsatp, t0
> +        FLUSH
> +
> +        call    test
> +        li      a0, 1                   /* test returned: no trap */
> +
> +/* exit through semihosting with status a0 */
> +exit:
> +        lla     a1, semiargs
> +        li      t0, 0x20026             /* ADP_Stopped_ApplicationExit */
> +        sd      t0, 0(a1)
> +        sd      a0, 8(a1)
> +        li      a0, 0x20                /* SYS_EXIT_EXTENDED */
> +        .balign 16
> +        slli    zero, zero, 0x1f
> +        ebreak
> +        srai    zero, zero, 0x7
> +1:      j       1b
> +
> +set_tables_perm:
> +        li      t0, leaf(REGION(2), 0)
> +        or      t1, a0, t0
> +        li      t0, G_L1 + 2 * 8
> +        sd      t1, 0(t0)
> +        FLUSH
> +        ret
> +
> +/* mret into the mode: mstatus.MPV = 1 for a guest, MPP = S or U */
> +run_guest:
> +        li      t0, (3 << 11) | (1 << 39)
> +        csrc    mstatus, t0
> +        li      t0, HS
> +        beq     a2, t0, 2f
> +        li      t0, 1 << 39             /* MPV: a guest mode */
> +        csrs    mstatus, t0
> +        li      t0, VU
> +        bne     a2, t0, 2f
> +        li      t0, REGION(24) - REGION(0)      /* VU: the user copy */
> +        add     a1, a1, t0
> +        j       3f
> +2:      li      t0, 1 << 11             /* MPP = S */
> +        csrs    mstatus, t0
> +3:      csrw    mepc, a1
> +        mret
> +
> +        .data
> +        .balign 8
> +semiargs:       .dword 0, 0
> +        .bss
> +        .balign 16
> +        .space  4096
> +stack_top:
> diff --git a/tests/tcg/riscv64/hyp-guest.h b/tests/tcg/riscv64/hyp-guest.h
> new file mode 100644
> index 0000000000..20ecef70a5
> --- /dev/null
> +++ b/tests/tcg/riscv64/hyp-guest.h
> @@ -0,0 +1,71 @@
> +/*
> + * Shared definitions for the riscv64 hypervisor-extension system tests,
> + * whose routines are in hyp-guest.S. hyp-guest.S:
> + *
> + * 1. Boots the machine in M-mode, sets up the stack and tells the CPU
> + *    which trap handlers to use.
> + * 2. Builds the guest's page tables and the G-stage (host) page tables.
> + * 3. Calls `test`, which starts the test.
> + *
> + * The test file provides:
> + * - test: where the test starts, called by _start after setup
> + * - trap: the M-mode trap handler
> + * - hs_trap: the HS-mode trap handler
> + *
> + * Helpers a test can call:
> + * - set_tables_perm(a0): set what the G-stage lets the guest do to its
> + *   own page tables. a0 is G_RW, G_RO or G_NOREAD.
> + * - run_guest(a0, a1, a2): run the code at address a1 in mode a2 (VS, VU
> + *   or HS), with a0 passed on to it in a0. It does not return: the
> + *   code's trap goes to the test's handler.
> + * - exit(a0): end the test with status a0, 0 for a pass, otherwise the
> + *   number of the check that failed.
> + *
> + * Memory is split into 2 MiB regions; region n starts at
> + * REGION(n) = 0x80000000 + n * 2 MiB. Both stages map each region to
> + * itself.
> + *
> + *   0     code and the G-stage page tables
> + *   1     data and the stack
> + *   2     the guest's page tables
> + *   3-23  free for the test
> + *   24    region 0's code again, user-accessible, for VU-mode
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#define PTE_V 0x01
> +#define PTE_R 0x02
> +#define PTE_W 0x04
> +#define PTE_X 0x08
> +#define PTE_U 0x10
> +#define PTE_A 0x40
> +#define PTE_D 0x80
> +#define leaf(pa, flags) (((pa) >> 2) | PTE_V | (flags))
> +#define table(pa) (((pa) >> 2) | PTE_V)
> +
> +#define REGION(n) (0x80000000 + (n) * 0x200000)
> +#define G_ROOT  0x80104000
> +#define G_L1    0x80108000
> +#define VS_ROOT 0x80400000
> +#define VS_L1   0x80401000
> +#define VS_L0   0x80402000      /* 4 KiB table for region 8 */
> +
> +/* G-stage permission of the guest's tables */
> +#define G_RW    (PTE_R | PTE_W | PTE_X | PTE_U | PTE_A | PTE_D)
> +#define G_RO    (G_RW & ~PTE_W)
> +#define G_NOREAD (G_RO & ~PTE_R)
> +
> +/* run_guest modes */
> +#define VU 0
> +#define HS 1
> +#define VS 2
> +
> +#define LOAD_PF 13
> +#define STORE_PF 15
> +#define FETCH_GPF 20
> +#define LOAD_GPF 21
> +#define STORE_GPF 23
> +#define TINST_READ 0x3000       /* walk was reading a page-table entry */
> +#define TINST_WRITE 0x3020      /* walk was writing A/D */
> +#define ADUE (1 << 61)
> diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
> index 3c8b018d9e..05ed8b4c8f 100644
> --- a/tests/tcg/riscv64/system/meson.build
> +++ b/tests/tcg/riscv64/system/meson.build
> @@ -53,6 +53,83 @@ tests += {
>     }
>   }
>   
> +hyp_guest = files('../hyp-guest.S')[0]
> +
> +# test-gstage-tinst.S: one build per case; the flags are documented there
> +gstage_tinst = {
> +  # the guest's tables are read-only, so the walk's A/D write is refused
> +  'load':      ['-DMODE=VS', '-DACCESS=ld t0, 0(a0)', '-DREG=3',
> +                '-DFLAGS=PTE_R', '-DCAUSE=LOAD_GPF'],
> +  'fetch':     ['-DMODE=VS', '-DACCESS=jr a0', '-DREG=4',
> +                '-DFLAGS=(PTE_R|PTE_X)', '-DCAUSE=FETCH_GPF'],
> +  'store':     ['-DMODE=VS', '-DACCESS=sd zero, 0(a0)', '-DREG=5',
> +                '-DFLAGS=(PTE_R|PTE_W|PTE_A)',
> +                '-DCAUSE=STORE_GPF'],
> +  'store-ad':  ['-DMODE=VS', '-DACCESS=sd zero, 0(a0)', '-DREG=6',
> +                '-DFLAGS=(PTE_R|PTE_W)',
> +                '-DCAUSE=STORE_GPF'],
> +  'amo':       ['-DMODE=VS', '-DACCESS=amoadd.d t0, zero, (a0)', '-DREG=7',
> +                '-DFLAGS=(PTE_R|PTE_W|PTE_A)',
> +                '-DCAUSE=STORE_GPF'],
> +  'load-4k':   ['-DMODE=VS', '-DACCESS=ld t0, 0(a0)', '-DREG=8',
> +                '-DPTE_ADDR=VS_L0', '-DFLAGS=PTE_R',
> +                '-DCAUSE=LOAD_GPF'],
> +  'load-1g':   ['-DMODE=VS', '-DACCESS=ld t0, 0(a0)',
> +                '-DADDR=(0xC0000000+9*0x200000)', '-DPTE_ADDR=(VS_ROOT+3*8)',
> +                '-DPTE_PA=REGION(0)', '-DFLAGS=PTE_R',
> +                '-DCAUSE=LOAD_GPF'],
> +  'load-vu':   ['-DMODE=VU', '-DACCESS=ld t0, 0(a0)', '-DREG=10',
> +                '-DFLAGS=(PTE_R|PTE_U)', '-DCAUSE=LOAD_GPF'],
> +  'hlv':       ['-DMODE=HS', '-DACCESS=hlv.d t0, (a0)', '-DREG=11',
> +                '-DFLAGS=PTE_R', '-DCAUSE=LOAD_GPF'],
> +  'hsv':       ['-DMODE=HS', '-DACCESS=hsv.d zero, (a0)', '-DREG=12',
> +                '-DFLAGS=(PTE_R|PTE_W|PTE_A)',
> +                '-DCAUSE=STORE_GPF'],
> +  'load-hs':   ['-DMODE=VS', '-DACCESS=ld t0, 0(a0)', '-DREG=13',
> +                '-DFLAGS=PTE_R', '-DCAUSE=LOAD_GPF',
> +                '-DTO_HS'],
> +  'store-hs':  ['-DMODE=VS', '-DACCESS=sd zero, 0(a0)', '-DREG=14',
> +                '-DFLAGS=(PTE_R|PTE_W|PTE_A)',
> +                '-DCAUSE=STORE_GPF', '-DTO_HS'],
> +  # the tables are unreadable, so the walk fails reading root entry 2
> +  'hsv-noread': ['-DMODE=HS', '-DACCESS=hsv.d zero, (a0)', '-DREG=15',
> +                 '-DFLAGS=(PTE_R|PTE_W|PTE_A)', '-DPERM=G_NOREAD',
> +                 '-DENTRY=(VS_ROOT+2*8)', '-DCAUSE=STORE_GPF',
> +                 '-DTINST=TINST_READ'],
> +  'hlv-noread': ['-DMODE=HS', '-DACCESS=hlv.d t0, (a0)', '-DREG=16',
> +                 '-DFLAGS=(PTE_R|PTE_A)', '-DPERM=G_NOREAD',
> +                 '-DENTRY=(VS_ROOT+2*8)', '-DCAUSE=LOAD_GPF',
> +                 '-DTINST=TINST_READ'],
> +  'fetch-noread': ['-DMODE=VS', '-DREG=17', '-DADDR=probe',
> +                   '-DFLAGS=(PTE_R|PTE_X|PTE_A)', '-DPERM=G_NOREAD',
> +                   '-DENTRY=(VS_ROOT+2*8)', '-DCAUSE=FETCH_GPF',
> +                   '-DTINST=TINST_READ'],
> +  # A/D updating off: an ordinary page fault, nothing written
> +  'noadue-h':  ['-DMODE=VS', '-DACCESS=ld t0, 0(a0)', '-DREG=21',
> +                '-DFLAGS=PTE_R', '-DHENVCFG=0', '-DCAUSE=LOAD_PF',
> +                '-DENTRY=0', '-DTINST_NOT_WALK'],
> +  'noadue-m':  ['-DMODE=VS', '-DACCESS=ld t0, 0(a0)', '-DREG=22',
> +                '-DFLAGS=PTE_R', '-DMENVCFG=0', '-DCAUSE=LOAD_PF',
> +                '-DENTRY=0', '-DTINST_NOT_WALK'],
> +  'noadue-store': ['-DMODE=VS', '-DACCESS=sd zero, 0(a0)', '-DREG=23',
> +                   '-DFLAGS=(PTE_R|PTE_W|PTE_A)', '-DHENVCFG=0',
> +                   '-DCAUSE=STORE_PF', '-DENTRY=0', '-DTINST_NOT_WALK'],
> +  # control: the guest itself stores into its read-only tables
> +  'control':   ['-DMODE=VS', '-DACCESS=sd zero, 0(a0)', '-DREG=2',
> +                '-DFLAGS=(PTE_R|PTE_W|PTE_A|PTE_D)', '-DADDR=(VS_ROOT+0x800)',
> +                '-DENTRY=(VS_ROOT+0x800)', '-DCAUSE=STORE_GPF',
> +                '-DTINST_NOT_WALK'],
> +}
> +foreach name, flags : gstage_tinst
> +  tests += {
> +    'test-gstage-tinst.S': {
> +      'exe_name': 'test-gstage-tinst-' + name,
> +      'cflags': cflags + ['-march=rv64gch', hyp_guest] + flags,
> +      'qemu_args': ['-cpu', 'rv64,h=true,svadu=true', qemu_args],
> +    }
> +  }
> +endforeach
> +
>   tests += {
>     'test-vle32ff.S': {
>       'cflags': cflags + ['-march=rv64gcv'],
> diff --git a/tests/tcg/riscv64/test-gstage-tinst.S b/tests/tcg/riscv64/test-gstage-tinst.S
> new file mode 100644
> index 0000000000..8c9c7b831f
> --- /dev/null
> +++ b/tests/tcg/riscv64/test-gstage-tinst.S
> @@ -0,0 +1,135 @@
> +/*
> + * Test what a fault reports when the G-stage refuses the guest's
> + * page-table walk: its read of a page-table entry, or its write of the
> + * A/D bits.
> + *
> + * Each build is one case, set by -D flags in meson.build:
> + * - MODE: VS, VU or HS (HS runs hlv/hsv on the guest's behalf)
> + * - ACCESS: the instruction run on ADDR
> + * - REG: the region accessed; ADDR defaults to its start
> + * - FLAGS: the guest's page-table entry for ADDR
> + * - PERM: the G-stage permission of the guest's tables (default G_RO)
> + * - TO_HS: take the fault in HS-mode instead of M-mode
> + * - MENVCFG, HENVCFG: turn ADUE off
> + * - PTE_ADDR, PTE_PA: where the entry is and where it points, for the
> + *   4 KiB and 1 GiB cases
> + * - CAUSE, ENTRY, TINST, TINST_NOT_WALK: what the fault must report
> + *
> + * The trap handler checks, and the exit status is the first that fails:
> + *   1  cause  CAUSE
> + *   2  tval   ADDR
> + *   3  tval2  ENTRY >> 2, the entry the walk failed on (default: the
> + *             guest's entry for ADDR)
> + *   4  tinst  TINST: 0x3020 if the walk was writing A/D (default),
> + *             0x3000 if reading; with TINST_NOT_WALK, neither
> + *   5  the entry is unchanged, so the refused A/D write did not happen
> + *
> + * `trap` checks a fault taken in M-mode. `hs_trap` checks one taken in
> + * HS-mode, using scause, stval, htval and htinst.
> + *
> + * Privileged ISA v1.12: 8.5.1, 8.6.3 Table 8.12.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#include "hyp-guest.h"
> +
> +/* exit with status n unless reg == want */
> +#define CHECK(n, reg, want) li t6, want; li a0, n; bne reg, t6, exit
> +
> +#ifdef REG
> +#ifndef ADDR
> +#define ADDR REGION(REG)
> +#endif
> +#ifndef PTE_ADDR
> +#define PTE_ADDR (VS_L1 + (REG) * 8)
> +#endif
> +#ifndef PTE_PA
> +#define PTE_PA REGION(REG)
> +#endif
> +#endif
> +#ifndef ENTRY
> +#define ENTRY PTE_ADDR
> +#endif
> +#ifndef PERM
> +#define PERM G_RO
> +#endif
> +#ifndef TINST
> +#define TINST TINST_WRITE
> +#endif
> +
> +        .option norvc
> +        .text
> +        .global test, trap, hs_trap
> +test:
> +#ifdef MENVCFG
> +        li      t0, MENVCFG             /* A/D updating off */
> +        csrw    menvcfg, t0
> +#endif
> +#ifdef HENVCFG
> +        li      t0, HENVCFG
> +        csrw    henvcfg, t0
> +#endif
> +#ifdef TO_HS
> +        li      t0, 1 << CAUSE
> +        csrw    medeleg, t0
> +#endif
> +        li      t0, PTE_ADDR            /* the guest's entry for ADDR */
> +        li      t1, leaf(PTE_PA, FLAGS)
> +        sd      t1, 0(t0)
> +#if REG >= 3
> +        li      t0, REGION(REG)         /* an ecall for a jump to land on */
> +        li      t1, 0x00000073
> +        sw      t1, 0(t0)
> +#endif
> +        li      a0, PERM
> +        call    set_tables_perm
> +
> +        ld      a0, addr
> +        lla     a1, probe
> +        li      a2, MODE
> +        call    run_guest
> +
> +probe:
> +#ifdef ACCESS
> +        ACCESS
> +#endif
> +        ecall
> +
> +/* the fault, as reported by CSRs cause, tval, tval2 and tinst */
> +.macro check_fault cause, tval, tval2, tinst
> +        csrr    t5, \cause
> +        CHECK(1, t5, CAUSE)
> +        csrr    t5, \tval
> +        ld      t6, addr
> +        li      a0, 2
> +        bne     t5, t6, exit
> +        csrr    t5, \tval2
> +        CHECK(3, t5, (ENTRY) >> 2)
> +        csrr    t5, \tinst
> +#ifdef TINST_NOT_WALK
> +        li      a0, 4
> +        li      t6, TINST_READ
> +        beq     t5, t6, exit
> +        li      t6, TINST_WRITE
> +        beq     t5, t6, exit
> +#else
> +        CHECK(4, t5, TINST)
> +#endif
> +        li      t0, PTE_ADDR
> +        ld      t5, 0(t0)
> +        CHECK(5, t5, leaf(PTE_PA, FLAGS))
> +        li      a0, 0
> +        j       exit
> +.endm
> +
> +        .balign 4
> +trap:
> +        check_fault mcause, mtval, mtval2, mtinst
> +
> +        .balign 4
> +hs_trap:
> +        check_fault scause, stval, htval, htinst
> +
> +        .data
> +        .balign 8
> +addr:   .dword ADDR


