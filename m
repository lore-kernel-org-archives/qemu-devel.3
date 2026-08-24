Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2FE3C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 12:51:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyU9G-0006KZ-TF; Mon, 24 Aug 2026 08:51:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wyU9F-0006Jy-4y
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 08:51:33 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wyU9C-0004QT-NM
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 08:51:32 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OBMgOV2864704
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 12:51:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cIiqxN+Ksp2VsvrVmiVjpLDf+cnxM5YSqCGjz84ZF/o=; b=Yc6yeg1YbmcFMAXt
 9vCBrG7ztVP3Vzea4Gj5zljq9zjcKUwR18s/hXb7AVOCozsWdXpJAmdSqvVHu5T2
 Cz61FoNmEqdNK7JyZJesTTiZtnwQDNmGaV8np4SI/M1vaAMJmUMc7IM5J9/sHpku
 VDl/HgCUoWFSnYhzKaHs5vMSN3ySwVzNMvEzOUJ4zWuNZYbBWW2n628ZzYV29W1p
 xEUctEf469AlEfrtsUGgDKlkW64OzGG8Y5XfQVUi7/EGkoAJW/ICU/y7y/nHwtBk
 7SoYcxyrHB+CfqM0B51dtBEcxuwmwegm0Ve2Y4pQcxKXfm8XKW+LL1kLlSxvHJyI
 jKl/AQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8bdr2gfn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 12:51:28 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9308eafb465so635007285a.2
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 05:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787575888; x=1788180688; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cIiqxN+Ksp2VsvrVmiVjpLDf+cnxM5YSqCGjz84ZF/o=;
 b=asXpd34LsNP61p5AHPb8xeYFFDtfm23Z9Z6oL+nBCfDSzecvpxVFnomwsXvaZVF3Z7
 8gfD+yBITN58L2fCV04McQN5XloGvP2QnGmRSqOEwV0L6Nl0Edjcy3DqPfXPgwdM6Xux
 lXmJd/kTjBqaOzbJ2dXuOzpEDnL8f6W3/Smnhus8PhJqPew1h3uu06iU1DSmkJml4uEq
 f+J5ON/jpaklg1ZjmIYVLDGZPspFW8NtCcwXrsKAsrOaHDiKR0fe+4gnTL9zEhOFXkqS
 QZznhBuPBYjwnVxPePXKWQBXm3YSC+Li273pmfBRvbpBsZEJu0KqPKNETST/6ppNZMGV
 fcKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787575888; x=1788180688;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cIiqxN+Ksp2VsvrVmiVjpLDf+cnxM5YSqCGjz84ZF/o=;
 b=UBLPKRcH4LpfHvt8OPoFRaamgIr4IYIOGgiS5/y4m5O1asqH3q1lJc94ZZRg7wq7En
 pEqxOePfcPA61KtwLqTXuA6QTAYrF1UEo8qIBs7n7NQmlR8OoWSupUM8myk/TdWFXCaj
 qYhWUIiaRWEj8xktX0lKk5b70YBwJyj7jVf1ovgctieMd1Q8SZvedKfp0lgz5Voff8Rv
 Hwx5Tq4ZVfhkpV0IFsfyll1mQWhJwF93YQqy5g6jf5V3txo0Psv0V7KzUDqJsfJdlSdX
 dTNqSJ4/vYvxFoWZWx9AO6EzrgJqwz2omiVHQyC9fJ/YEJ0EfOQeWcoQkUalHqsiCVjE
 FdVw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqUksT0MakF3rYX0eEMiIb3iZB+n56pBS/NXzGtHuA8xB+F9oTGjfC2cF7WdF5RCVFzz5FlvaQJ5fhg@nongnu.org
X-Gm-Message-State: AFuF++kY981MjfimJYzKLxVAN1aTbTDbbukOUd+ZwnYAl2g3Se3hMpMi
 y45w8ghU05YPIuBwJAx++jQykMOncnp96ZfpQg03eAtQnKvprpaJjo7ocJDSqZGrD5qUHyZ4hRm
 qi1tSRAugWdtUzJKGngy5IjFj8ylDPnJ6cg+ImmjNlWvUPnQTxRhMRGv+WQ==
X-Gm-Gg: AR+sD12N3uOdThwHpUG46SsAbk11RvJypQdjW+1UWw59D37UNMO8Stjg92K/hpl4KJ5
 GWRkcKEAVc1S2/Pn6bp74t6VFsU7SosZyaKRvBJcrdVdk+m0y/Qzq0XPB0CZP9Kq9unhPoWT3Pg
 u3EVnc4VbHKG1FVda9FTCde1k5jNpNMjDZLfy7qwCwAMxnCkINRUdergxmuquXBhThoH8cmlQXW
 mY9E4JCXRikc61Ep8NUdEsIQApfwS5wYDomoCQStKRJrm8g4sM9y8j6flsvu7ixIROqe9dEuh2t
 TQBeBgv5vC1WqvU8cQZMKMN9vuqpuOhNaUkqv90hSwcg4TX5xFuZ3RetWjpvtsevUs0vbOoYAlh
 2S3so3B1pOcRg6t6nKO9fzJzea6Dn67Y7Zn70
X-Received: by 2002:a05:620a:4084:b0:936:6911:38ed with SMTP id
 af79cd13be357-937466c97bbmr1671597185a.0.1787575887275; 
 Mon, 24 Aug 2026 05:51:27 -0700 (PDT)
X-Received: by 2002:a05:620a:4084:b0:936:6911:38ed with SMTP id
 af79cd13be357-937466c97bbmr1671589185a.0.1787575886674; 
 Mon, 24 Aug 2026 05:51:26 -0700 (PDT)
Received: from [192.168.68.100] ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c935e2838sm61013576d6.9.2026.08.24.05.51.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Aug 2026 05:51:26 -0700 (PDT)
Message-ID: <e769b897-affb-4ee4-9040-122c3fbb2d12@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 09:51:22 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/tcg/riscv64: Add tests for rv128 [ms]status
To: frederic.petrot@univ-grenoble-alpes.fr, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20260821102729.997150-1-frederic.petrot@univ-grenoble-alpes.fr>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260821102729.997150-1-frederic.petrot@univ-grenoble-alpes.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEwOCBTYWx0ZWRfX4NFYAZfzhUe1
 mMKY8ltVGi8yeEZbu+aDbiMKKEBUjk83nDAj6g2UkllBHV4umz31viNbNHjSTWHYmCf3IZ3GgNE
 Hjnj+gIKDKIpjgctPF/vYZ032XOR0/KTMLC3otSq2CQm57u3ampxIXjj28ZOdFtGo/OzSqtQaZ0
 M3IxhmQluIrCr//G6m4gHDpHApluTEjXQTj5IeOR9jW9a0lsGr/h5E/DuO4MURfTvS/3KIjJKw/
 AAvhU1Mb+hkTToo/sU6gq3DgB3v8euu4ShSnjQeg+ptt7MSuUrvE1E/4yU8GoQPwdb4LDJlSFog
 in6+xDb1YaGNcYGVFFCqLTbU1CusWwkNbuXaAjKrYX0gnwq94JcVw4WjiFTMcrjywCtFNbpCeic
 7bj+/Di3PgZPsEDSrJNKY7TR0zVmTB9p4197Kf74nI3AYLg14lyBNeNxCKxwlS7Do0MygcLsASB
 i+JwdgaHD4VOT9tIojA==
X-Proofpoint-GUID: 0B9CHE2TUnoRW49U_Tq_OdYYFzBtEWx2
X-Proofpoint-ORIG-GUID: 0B9CHE2TUnoRW49U_Tq_OdYYFzBtEWx2
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEwOCBTYWx0ZWRfX+NYOQ1VyI3r8
 Tg5SAxIIKDX9SmdykiBWqZorSoAH9HyaIz+lyWgGprp5tSlQW/MI+Wj68lpaUowuHQZy29knpUI
 sMzMjq13XmI0YKTpzwc7pEJlu4mD/Ws=
X-Authority-Analysis: v=2.4 cv=W8cIkxWk c=1 sm=1 tr=0 ts=6a8c3e50 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=tQs82KXDRzWe1D061gQA:9 a=-5Hix484dz2RV_fg:21
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240108
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hello,

On 8/21/2026 7:27 AM, frederic.petrot@univ-grenoble-alpes.fr wrote:
> From: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
> 
> Adding asm tests to check that mstatus and sstatus are updated as
> expected in an rv128 cpu.
> 
> Signed-off-by: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
> ---

A couple of trivial stuff to handle like these trailing errors:

$ git am \[PATCH\]\ tests_tcg_riscv64\ \ Add\ tests\ for\ rv128\ \[ms\]status\ -\ frederic.petrot@univ-grenoble-alpes.fr\ -\ 2026-08-21\ 0727.eml --reject
Applying: tests/tcg/riscv64: Add tests for rv128 [ms]status
.git/rebase-apply/patch:81: trailing whitespace.
fail:
.git/rebase-apply/patch:83: trailing whitespace.
_exit:
.git/rebase-apply/patch:195: trailing whitespace.
fail:
.git/rebase-apply/patch:197: trailing whitespace.
_exit:


I believe they're originating from the .S files.  Everything else LGTM.

With the whitespaces fixed:


Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>




>   tests/tcg/riscv64/Makefile.softmmu-target |   9 ++
>   tests/tcg/riscv64/test-rv128-mstatus.S    |  67 ++++++++++++++
>   tests/tcg/riscv64/test-rv128-sstatus.S    | 108 ++++++++++++++++++++++
>   3 files changed, 184 insertions(+)
>   create mode 100644 tests/tcg/riscv64/test-rv128-mstatus.S
>   create mode 100644 tests/tcg/riscv64/test-rv128-sstatus.S
> 
> diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
> index fac0474746..83d621c5d0 100644
> --- a/tests/tcg/riscv64/Makefile.softmmu-target
> +++ b/tests/tcg/riscv64/Makefile.softmmu-target
> @@ -67,5 +67,14 @@ EXTRA_RUNS += run-test-zicclsm-off
>   run-test-zicclsm-off: test-zicclsm-off
>   	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)v=true$(comma)zfh=true$(comma)zicclsm=false $(QEMU_OPTS)$<)
>   
> +# Test for rv128
> +EXTRA_RUNS += run-test-rv128-mstatus
> +run-test-rv128-mstatus: test-rv128-mstatus
> +	$(call run-test, $<, $(QEMU) -cpu x-rv128 $(QEMU_OPTS)$<)
> +
> +EXTRA_RUNS += run-test-rv128-sstatus
> +run-test-rv128-sstatus: test-rv128-sstatus
> +	$(call run-test, $<, $(QEMU) -cpu x-rv128 $(QEMU_OPTS)$<)
> +
>   # We don't currently support the multiarch system tests
>   undefine MULTIARCH_TESTS
> diff --git a/tests/tcg/riscv64/test-rv128-mstatus.S b/tests/tcg/riscv64/test-rv128-mstatus.S
> new file mode 100644
> index 0000000000..e8b5101e26
> --- /dev/null
> +++ b/tests/tcg/riscv64/test-rv128-mstatus.S
> @@ -0,0 +1,67 @@
> +/*
> + * Test rv128 mstatus update and access
> + * Author: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#define srli(rd, rs1, imm)                .insn i  0b0010011, 0b101, rd, rs1, imm & 0b1111111
> +
> +    .option norvc
> +
> +    .text
> +    .globl _start
> +_start:
> +    csrr    s0, misa
> +    srli    (s1, s0, 126)
> +    li      s0, 3
> +    bne     s1, s0, fail
> +
> +    # Check UXL and SXL are set to RV128 too
> +    csrr    s0, mstatus
> +    srli    (s1, s0, 32)
> +    andi    s1, s1, 0xf
> +    li      s0, 0xf
> +    bne     s1, s0, fail
> +
> +    # Mark FPU dirty to check for SD
> +    .equiv  MSTATUS_FS, 0x00006000
> +    li      s0, MSTATUS_FS
> +    csrs    mstatus, s0
> +    # Do some useless computation
> +    fmadd.s f3, f2, f1, f0
> +    fmax.s  f0, f1, f2
> +    # Check SD has changed where expected
> +    csrr    s0, mstatus
> +    srli    (s1, s0, 127)
> +    li      s0, 1
> +    bne     s1, s0, fail
> +    # Mark FPU clean (2 in FS place)
> +    li      s0, ~0x00004000
> +    csrc    mstatus, s0
> +    csrr    s0, mstatus
> +    srli    (s1, s0, 13)
> +    andi    s1, s1, 3
> +    li      s0, 2
> +    bne     s1, s0, fail
> +    li      a0, 0
> +    j       _exit
> +fail:
> +    li      a0, 1
> +_exit:
> +    lla     a1, semiargs
> +    li      t0, 0x20026 # ADP_Stopped_ApplicationExit
> +    sd      t0, 0(a1)
> +    sd      a0, 8(a1)
> +    li      a0, 0x20    # TARGET_SYS_EXIT_EXTENDED
> +
> +    # Semihosting call sequence
> +    .balign 16
> +    slli   zero, zero, 0x1f
> +    ebreak
> +    srai   zero, zero, 0x7
> +    j      .
> +
> +    .data
> +    .balign 16
> +semiargs:
> +    .space  16
> diff --git a/tests/tcg/riscv64/test-rv128-sstatus.S b/tests/tcg/riscv64/test-rv128-sstatus.S
> new file mode 100644
> index 0000000000..32f792a6aa
> --- /dev/null
> +++ b/tests/tcg/riscv64/test-rv128-sstatus.S
> @@ -0,0 +1,108 @@
> +/*
> + * Test rv128 sstatus update and access
> + * Author: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#define srli(rd, rs1, imm)                .insn i  0b0010011, 0b101, rd, rs1, imm & 0b1111111
> +
> +    .option norvc
> +
> +    .text
> +    .globl _start
> +_start:
> +    // Check RV128 is running
> +    csrr     s0, misa
> +    srli     (s1, s0, 126)
> +    li       s0, 3
> +    bne      s1, s0, fail
> +
> +    // Minimal pmp settings
> +#define PMP_NAPOT 0x18
> +#define PMP_R     0x01
> +#define PMP_W     0x02
> +#define PMP_X     0x04
> +
> +    li       s0, -1
> +    csrw     pmpaddr0, s0
> +    li       s0, PMP_NAPOT | PMP_R | PMP_W | PMP_X
> +    csrw     pmpcfg0, s0
> +
> +    la       s0, backm
> +    csrw     mtvec, s0
> +
> +    // Set MPP to supervisor
> +    csrr     s0, mstatus
> +    li       s1, ~0x1800 // mask
> +    and      s1, s1, s0
> +    li       s0, 0x0800  // supervisor
> +    or       s1, s1, s0
> +    csrw     mstatus, s1
> +    // Change to supervisor mode
> +    la       s0, 1f
> +    csrw     mepc, s0
> +    mret
> +1:
> +    // Check UXL is set to RV128
> +    csrr     s0, sstatus
> +    srli     (s1, s0, 32)
> +    andi     s1, s1, 0x3
> +    li       s0, 3
> +    bne      s1, s0, fail
> +    // Check SPP if is set to 1, since we
> +    // come from machine mode
> +    srli     (s1, s0, 8)
> +    andi     s1, s1, 0x1
> +    // Actually this check fails, so test 0
> +    li       s0, 0
> +    bne      s1, s0, fail
> +
> +    // Mark FPU dirty to check for SD
> +    .equiv   MSTATUS_FS, 0x00006000
> +    li       s0,  MSTATUS_FS
> +    csrs     sstatus, s0
> +    // Do some fun useless computation
> +    fmadd.s  f3, f2, f1, f0
> +    fmax.s   f0, f1, f2
> +    // Check SD has changed where expected
> +    csrr     s0, sstatus
> +    srli     (s1, s0, 127)
> +    li       s0, 1
> +    bne      s1, s0, fail
> +    // Mark FPU clean (2 in FS place)
> +    li       s0, ~0x00004000
> +    csrc     sstatus, s0
> +    csrr     s0, sstatus
> +    srli     (s1, s0, 127)
> +    li       s0, 0
> +    bne      s1, s0, fail
> +
> +    // Let's go back to machine mode to exit
> +    ecall
> +
> +    // mtvec bit 1:0 indicate mode, 00 is Direct, what
> +    // we want in this simple test
> +    .align 4
> +backm:
> +    li      a0, 0
> +    j       _exit
> +fail:
> +    li      a0, 1
> +_exit:
> +    lla     a1, semiargs
> +    li      t0, 0x20026 # ADP_Stopped_ApplicationExit
> +    sd      t0, 0(a1)
> +    sd      a0, 8(a1)
> +    li      a0, 0x20    # TARGET_SYS_EXIT_EXTENDED
> +
> +    # Semihosting call sequence
> +    .balign 16
> +    slli   zero, zero, 0x1f
> +    ebreak
> +    srai   zero, zero, 0x7
> +    j      .
> +
> +    .data
> +    .balign 16
> +semiargs:
> +    .space  16


