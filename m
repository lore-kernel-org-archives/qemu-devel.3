Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C15C5AC82
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 16:05:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsN4u-0003ff-8I; Fri, 07 Aug 2026 12:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wsN4q-0003f7-5I
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 12:05:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wsN4n-0005pk-7j
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 12:05:43 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 677FRQb91095530
 for <qemu-devel@nongnu.org>; Fri, 7 Aug 2026 16:05:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JwqB1OQKRDTpbu9VyKee9S6iACZPzIqQrWFG3/hkZxo=; b=e3zMV9VnQ6wQ/fhQ
 ttlx+8k6PyTodn/QiJRIub05Vri3t5ZfwFTxlxfP57KdNMnc4EImahKjN7EeJk+o
 UALOvZHqIB7rftSuVPIItcw5XOwwfOQUbBkMBt9xh96fvaB/vm3G1XhHlY8v8/j+
 TP/thzdlm9KpXuRPYo/DsrIgUkF+XTED3TGoXvxUb8/dDAYQISOT9Huos86iyC3N
 ppkYasMe0fNGYcgN1Sw7JurW9pgE4fYvMqs5oD0ex0wB9tld09+oKdNJ9fDliL9N
 AIT9cKr1TP8B1cq6UJjKLS74KDGCWdh97nJ8KDdR78+yhqp+2zyVPpl2n6a6TxEf
 l8mQ8w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwgem8m1x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 16:05:39 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-930a098ea19so397063485a.1
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 09:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786118738; x=1786723538; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JwqB1OQKRDTpbu9VyKee9S6iACZPzIqQrWFG3/hkZxo=;
 b=RwMcj5heGvWw/WAXhUkunhqNMA6FatMC/LqvGzQ95fn/j3paNpUXYSu05HNkwuBg0B
 lKMl3cjhjYC1kFCrM8fHYPxUunGxXl50OlsGetfjlZLPwwooeyffq7dymM9KEBoAPSSF
 f9fmvKX6XITeSoReFqHEfmjVngv0L7+Qtti0DrqeaXyQm5lr/nCHJoQIqzJ3bHDr0qo2
 qNjBg5jOQ84xlLdPC1aB9uhxGKo/jGn5aTV0rer5E4J3sgl7Jhn6u8w+pyQasZGep+M3
 kWBp3Z31DgnYG85MgfbXjvPZntC+nm47csetVR8W4jtuI/SX0N4Oy0TOdFPHsneqhbWL
 ew6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786118738; x=1786723538;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JwqB1OQKRDTpbu9VyKee9S6iACZPzIqQrWFG3/hkZxo=;
 b=qfb4QDFp0g3B/tNDGaPXm9Mpl+DxwgrygGcs16NWS9hqQ2h+GdkDEQomFOF8zPcAUG
 cG5ceipdMQeImavKvES+NfBZKTqerMm3/qf8lYsv3TH/zbsfbXDZi1rwhBsGzIfSRaU1
 UKSWk4+AW7Z7oY4GEpATrG8pRNba6wo1a/hQRo77OCd16dvwMX4XEDjDipyob8My6mUV
 ghMuLODi2Z86zhYjSGLrg5XNtz2b+QI4Hgf2q4M0kWCWepKQjGTPWtN/RShc2uSdhTlz
 m80y+TwgH9Ag0LnfEUMN/axFslQvMBXyHjpBV2nsZPcQufqUBfZAa75xyjDNitIILoBQ
 turA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrVyuPYSljn+yvhjUzOWg6jHQx36KfQwslT5QQ97ed1UUKTY8h/UDnNIIGvVJ7yKtB3KaXHVqcHY1GB@nongnu.org
X-Gm-Message-State: AOJu0YwiSJNnwmJswPGJzjiQoiJQhwoZay+eOYLuY2E1ejT0/Y9yv3hL
 8HH23wgVklYx2ChPRi4rWKufzL6v+AxlXuiHHURMGdoN33R9/69IMt885LbNaM+nmnHKlB9cQeC
 FBh5KirH9yhGtKv4axLleK7bP1YXTZeSF/Duxfktm7WqqOoKJoZQe/eyGoA==
X-Gm-Gg: AR+sD12eHOtkEVX5lBqCy8I5Uioo9KYBu9XrDQ6CJGCVs8LLx4FVQrsQv1r/Pyn3wsd
 bqyFUJjXgB0w+L3Yg2+oixUDM+PEv5eh51Sl5yPHUbIoKjh/vTITY3fiq4fL7nKiFbTdfXb0XBf
 +E9EamwSI3xGiEx2bRJWl88b1WqNR3RvtuuRAMCxrgdexMeQgTu/y9N19stGrKMu8LyG5FP+wUj
 ZLg4pr9AA6aqL0pd6jqrs/8SRBrVPkMOcVoEvzAHZVjkPgziNmOqCrnaY/1TItiW+bmLxbmTanT
 99zluvNwcTz8VI6mypo4FsNamMRk4cf2hJk3by+oTiS1rOStXo0B38V5K+U0tQnGNNi2ajJ30wz
 5d0h3oJ4mP2WQfCi+F3qGG2jCkirYXesw6WxX
X-Received: by 2002:a05:620a:4544:b0:923:45bb:a95c with SMTP id
 af79cd13be357-93671b4b9efmr459518785a.10.1786118738284; 
 Fri, 07 Aug 2026 09:05:38 -0700 (PDT)
X-Received: by 2002:a05:620a:4544:b0:923:45bb:a95c with SMTP id
 af79cd13be357-93671b4b9efmr459495585a.10.1786118737302; 
 Fri, 07 Aug 2026 09:05:37 -0700 (PDT)
Received: from [192.168.68.104] ([187.11.154.152])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9366e274b3asm177806985a.37.2026.08.07.09.05.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2026 09:05:35 -0700 (PDT)
Message-ID: <a42ba62f-a154-4204-8331-5795b092f323@oss.qualcomm.com>
Date: Fri, 7 Aug 2026 13:05:31 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 8/8] tests/tcg/riscv64: Add test for Zicclsm
To: frank.chang@sifive.com, qemu-devel@nongnu.org
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 "open list:SiFive Machines" <qemu-riscv@nongnu.org>
References: <20260805164345.698208-1-frank.chang@sifive.com>
 <20260805164345.698208-9-frank.chang@sifive.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260805164345.698208-9-frank.chang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: HM-3OT0bWuK1lnC9mFRp5WN_DDy8BtMi
X-Proofpoint-GUID: HM-3OT0bWuK1lnC9mFRp5WN_DDy8BtMi
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDEyNSBTYWx0ZWRfXzal3a8KZZE0Z
 KWgmSLh6qV5u2nRJRklUjM167s4Ch2s40P8dRgvUOFSFdI5zulSjIdBu04hQLdEE51ZwbHXrSSc
 fSEsXIWjaazdY9VKCvR+OSsfZYLYjPs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDEyNSBTYWx0ZWRfX4Qq0wm6PG9MI
 BRzEQ2sX/2ZBEyK4+nepR/m5LdEmQqYx/fD/Ocicbc0XN/HYBTO0GFAXHleYzWOvHw242gCHGqW
 2VD1bhk/QyaDf2GRQAU2CRXVkz+Or9ljcYvxyFYl+eIM51y2XiIbfyHUu0f+2i9eZIBFYCYoH4O
 jY8vK1zLDMcqajdf0S77oM9HqdRSDFzQJ3ajfRkPlzh5ovWWLsCWmsIUgp2yPdpNWc4LQF9hhQD
 kv9Ul3OIM6bAz4bwr72DQJ4HVq9ynT4Em5bVVH+nXigL5Zx/2Bj5Yu2j6ECMGBlgAHfzky2KHyj
 FQdbYmxwTN+W4ygw+0J2pBMzn6O1mML4o+nY+EhZDtNKbbK7gC6IeyDs+CCy13YsLBVS1/5O9iE
 rtCdAkrlpCSVIpWz3jHVZj27zPwVNNwYouBQWY7CwJnfMswimuB6pn/Sl9MxS14SRRd/oygUncf
 ummVuF8fETGYuCzSyjw==
X-Authority-Analysis: v=2.4 cv=X9Ni7mTe c=1 sm=1 tr=0 ts=6a760253 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=iMfxv9gflPUPBcmW7/Gq5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=pFyQfRViAAAA:8 a=EUspDBNiAAAA:8 a=wphcKlZXvOT3FjGOpQoA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=oJz5jJLG1JtSoe7EL652:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070125
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



On 8/5/2026 1:43 PM, frank.chang@sifive.com wrote:
> From: Frank Chang <frank.chang@sifive.com>
> 
> Cover scalar, floating-point, vector, and segmented misaligned accesses
> with Zicclsm enabled and disabled. Clean up both generated test
> binaries.
> 
> To build and run the tests:
> 
>      make -C build/tests/tcg/riscv64-softmmu \
>          CC=riscv64-unknown-elf-gcc LD=riscv64-unknown-elf-ld \
>          test-zicclsm test-zicclsm-off
> 
>      make -C build/tests/tcg/riscv64-softmmu \
>          run-test-zicclsm run-test-zicclsm-off
> 
> To clean the generated binaries and objects:
> 
>      make -C build/tests/tcg/riscv64-softmmu clean
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   tests/tcg/riscv64/Makefile.softmmu-target |  22 ++
>   tests/tcg/riscv64/test-zicclsm.S          | 368 ++++++++++++++++++++++
>   2 files changed, 390 insertions(+)
>   create mode 100644 tests/tcg/riscv64/test-zicclsm.S
> 
> diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
> index 82be8a2c915..908fd008e4c 100644
> --- a/tests/tcg/riscv64/Makefile.softmmu-target
> +++ b/tests/tcg/riscv64/Makefile.softmmu-target
> @@ -41,5 +41,27 @@ comma:= ,
>   run-test-crc32: test-crc32
>   	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)xlrbr=true $(QEMU_OPTS)$<)
>   
> +# Zicclsm: misaligned load/store support. Assemble one source twice: the
> +# default build expects every misaligned access to succeed (zicclsm=true),
> +# the -DZICCLSM_DISABLED build expects every one to trap (zicclsm=false).
> +ZICCLSM_MARCH = -march=rv64gcv_zfh
> +CLEANFILES += test-zicclsm test-zicclsm-off
> +
> +test-zicclsm: test-zicclsm.S $(LINK_SCRIPT)
> +	$(CC) $(CFLAGS) $(ZICCLSM_MARCH) $< -Wa,--noexecstack -c -o test-zicclsm.o
> +	$(LD) $(LDFLAGS) test-zicclsm.o -o $@
> +
> +test-zicclsm-off: test-zicclsm.S $(LINK_SCRIPT)
> +	$(CC) $(CFLAGS) $(ZICCLSM_MARCH) -DZICCLSM_DISABLED $< -Wa,--noexecstack -c -o test-zicclsm-off.o
> +	$(LD) $(LDFLAGS) test-zicclsm-off.o -o $@
> +
> +EXTRA_RUNS += run-test-zicclsm
> +run-test-zicclsm: test-zicclsm
> +	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)v=true$(comma)zfh=true$(comma)zicclsm=true $(QEMU_OPTS)$<)
> +
> +EXTRA_RUNS += run-test-zicclsm-off
> +run-test-zicclsm-off: test-zicclsm-off
> +	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)v=true$(comma)zfh=true$(comma)zicclsm=false $(QEMU_OPTS)$<)
> +
>   # We don't currently support the multiarch system tests
>   undefine MULTIARCH_TESTS
> diff --git a/tests/tcg/riscv64/test-zicclsm.S b/tests/tcg/riscv64/test-zicclsm.S
> new file mode 100644
> index 00000000000..a2f217c0d1e
> --- /dev/null
> +++ b/tests/tcg/riscv64/test-zicclsm.S
> @@ -0,0 +1,368 @@
> +/*
> + * Test the Zicclsm extension (misaligned load/store support).
> + *
> + * This single source is assembled twice:
> + *   - test-zicclsm      : run on a CPU with zicclsm=true. Every misaligned
> + *                         scalar integer, floating-point and vector
> + *                         load/store must complete WITHOUT raising a trap.
> + *   - test-zicclsm-off  : built with -DZICCLSM_DISABLED and run on a CPU with
> + *                         zicclsm=false. Every misaligned access must raise a
> + *                         misaligned load/store exception, with the correct
> + *                         mcause and mtval.
> + *
> + * Zicclsm governs all regular scalar loads/stores (integer and F/D/Zfh
> + * floating-point) as well as vector element loads/stores.  Floating-point
> + * loads/stores (flh/flw/fld, fsh/fsw/fsd) are therefore exercised here.
> + *
> + * Atomic (A/Zacas/...) accesses are intentionally excluded: they always
> + * require natural alignment regardless of Zicclsm.  Likewise cm.push/cm.pop
> + * (Zcmp) are excluded, as they are not regular loads/stores.
> + *
> + * Register conventions (persist across the whole test; the trap handler only
> + * clobbers t0-t4):
> + *   s1 = expected mcause for the pending misaligned access
> + *   s2 = expected mtval (the misaligned address)
> + *   s3 = trap counter (incremented by the handler)
> + *   s4 = base address of the aligned data buffer
> + *   s5 = snapshot of s3 taken before an access, used to check the delta
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +	.option	norelax
> +	.option	norvc
> +
> +/* RISC-V exception causes (see target/riscv/cpu_bits.h). */
> +#define CAUSE_LOAD_MISALIGNED	0x4
> +#define CAUSE_STORE_MISALIGNED	0x6
> +
> +/*
> + * EXPECT sets up the expectation for the access that immediately follows and
> + * snapshots the trap counter.
> + *   \cause = expected mcause if the access traps
> + *   \off   = byte offset from the buffer base; also the expected mtval
> + */
> +	.macro	EXPECT cause, off
> +	li	s1, \cause
> +	addi	s2, s4, \off
> +	mv	s5, s3
> +	.endm
> +
> +/*
> + * CHECK validates the outcome of the preceding access.
> + *   - When Zicclsm is disabled, exactly one trap must have fired.
> + *   - When Zicclsm is enabled, no trap must have fired.
> + */
> +	.macro	CHECK
> +#ifdef ZICCLSM_DISABLED
> +	addi	s5, s5, 1
> +	bne	s3, s5, fail
> +#else
> +	bne	s3, s5, fail
> +#endif
> +	.endm
> +
> +/* In the enabled case, also verify the value returned by scalar loads. */
> +	.macro	CHECK_VALUE value
> +#ifndef ZICCLSM_DISABLED
> +	li	t0, \value
> +	bne	a2, t0, fail
> +#endif
> +	.endm
> +
> +/* Verify bytes written by an enabled scalar store. */
> +	.macro	CHECK_BYTE off, value
> +#ifndef ZICCLSM_DISABLED
> +	lbu	t0, \off(s4)
> +	li	t1, \value
> +	bne	t0, t1, fail
> +#endif
> +	.endm
> +
> +	.text
> +	.global	_start
> +_start:
> +	/* Install the trap handler. */
> +	lla	t0, trap
> +	csrw	mtvec, t0
> +
> +	/* Enable the FP (FS) and Vector (VS) unit state so F/D/V instructions
> +	 * do not trap as illegal. 0x6600 = FS[14:13]=11 | VS[10:9]=11. */
> +	li	t0, 0x6600
> +	csrs	mstatus, t0
> +
> +	/* Initialise persistent state. */
> +	li	s3, 0			/* trap counter */
> +	lla	s4, buf			/* aligned buffer base */
> +
> +	/*
> +	 * ---- Scalar integer loads ----
> +	 * lh/lhu need 2-byte alignment; lw/lwu 4-byte; ld 8-byte.
> +	 */
> +	EXPECT	CAUSE_LOAD_MISALIGNED, 1
> +	lh	a2, 1(s4)
> +	CHECK
> +	CHECK_VALUE 0x2211
> +	EXPECT	CAUSE_LOAD_MISALIGNED, 1
> +	lhu	a2, 1(s4)
> +	CHECK
> +	CHECK_VALUE 0x2211
> +
> +	EXPECT	CAUSE_LOAD_MISALIGNED, 1
> +	lw	a2, 1(s4)
> +	CHECK
> +	CHECK_VALUE 0x44332211
> +	EXPECT	CAUSE_LOAD_MISALIGNED, 3
> +	lw	a2, 3(s4)
> +	CHECK
> +	CHECK_VALUE 0x66554433
> +	EXPECT	CAUSE_LOAD_MISALIGNED, 1
> +	lwu	a2, 1(s4)
> +	CHECK
> +	CHECK_VALUE 0x44332211
> +
> +	EXPECT	CAUSE_LOAD_MISALIGNED, 1
> +	ld	a2, 1(s4)
> +	CHECK
> +	CHECK_VALUE 0x8877665544332211
> +	EXPECT	CAUSE_LOAD_MISALIGNED, 3
> +	ld	a2, 3(s4)
> +	CHECK
> +	CHECK_VALUE 0xaa99887766554433
> +	EXPECT	CAUSE_LOAD_MISALIGNED, 7
> +	ld	a2, 7(s4)
> +	CHECK
> +	CHECK_VALUE 0xeeddccbbaa998877
> +
> +	/*
> +	 * ---- Scalar integer stores ----
> +	 */
> +	li	t6, 0x1122334455667788
> +	EXPECT	CAUSE_STORE_MISALIGNED, 1
> +	sh	t6, 1(s4)
> +	CHECK
> +	CHECK_BYTE 1, 0x88
> +	CHECK_BYTE 2, 0x77
> +
> +	EXPECT	CAUSE_STORE_MISALIGNED, 1
> +	sw	t6, 1(s4)
> +	CHECK
> +	CHECK_BYTE 1, 0x88
> +	CHECK_BYTE 2, 0x77
> +	CHECK_BYTE 3, 0x66
> +	CHECK_BYTE 4, 0x55
> +	EXPECT	CAUSE_STORE_MISALIGNED, 3
> +	sw	t6, 3(s4)
> +	CHECK
> +	CHECK_BYTE 3, 0x88
> +	CHECK_BYTE 4, 0x77
> +	CHECK_BYTE 5, 0x66
> +	CHECK_BYTE 6, 0x55
> +
> +	EXPECT	CAUSE_STORE_MISALIGNED, 1
> +	sd	t6, 1(s4)
> +	CHECK
> +	CHECK_BYTE 1, 0x88
> +	CHECK_BYTE 2, 0x77
> +	CHECK_BYTE 3, 0x66
> +	CHECK_BYTE 4, 0x55
> +	CHECK_BYTE 5, 0x44
> +	CHECK_BYTE 6, 0x33
> +	CHECK_BYTE 7, 0x22
> +	CHECK_BYTE 8, 0x11
> +	EXPECT	CAUSE_STORE_MISALIGNED, 7
> +	sd	t6, 7(s4)
> +	CHECK
> +	CHECK_BYTE 7, 0x88
> +	CHECK_BYTE 8, 0x77
> +	CHECK_BYTE 9, 0x66
> +	CHECK_BYTE 10, 0x55
> +	CHECK_BYTE 11, 0x44
> +	CHECK_BYTE 12, 0x33
> +	CHECK_BYTE 13, 0x22
> +	CHECK_BYTE 14, 0x11
> +
> +	/*
> +	 * ---- Floating-point loads ----
> +	 * flh needs 2-byte alignment; flw 4-byte; fld 8-byte.  Their alignment
> +	 * is governed by Zicclsm just like the scalar integer forms.
> +	 */
> +	EXPECT	CAUSE_LOAD_MISALIGNED, 1
> +	flh	fa0, 1(s4)
> +	CHECK
> +
> +	EXPECT	CAUSE_LOAD_MISALIGNED, 1
> +	flw	fa0, 1(s4)
> +	CHECK
> +	EXPECT	CAUSE_LOAD_MISALIGNED, 3
> +	flw	fa0, 3(s4)
> +	CHECK
> +
> +	EXPECT	CAUSE_LOAD_MISALIGNED, 1
> +	fld	fa0, 1(s4)
> +	CHECK
> +	EXPECT	CAUSE_LOAD_MISALIGNED, 7
> +	fld	fa0, 7(s4)
> +	CHECK
> +
> +	/*
> +	 * ---- Floating-point stores ----
> +	 */
> +	EXPECT	CAUSE_STORE_MISALIGNED, 1
> +	fsh	fa0, 1(s4)
> +	CHECK
> +
> +	EXPECT	CAUSE_STORE_MISALIGNED, 1
> +	fsw	fa0, 1(s4)
> +	CHECK
> +	EXPECT	CAUSE_STORE_MISALIGNED, 3
> +	fsw	fa0, 3(s4)
> +	CHECK
> +
> +	EXPECT	CAUSE_STORE_MISALIGNED, 1
> +	fsd	fa0, 1(s4)
> +	CHECK
> +	EXPECT	CAUSE_STORE_MISALIGNED, 7
> +	fsd	fa0, 7(s4)
> +	CHECK
> +
> +	/*
> +	 * ---- Vector unit-stride loads / stores ----
> +	 * A base address that is not aligned to the element size (SEW) is
> +	 * misaligned for the first element access.
> +	 */
> +	vsetvli	t1, x0, e16, m1, ta, ma
> +	EXPECT	CAUSE_LOAD_MISALIGNED, 1
> +	addi	a0, s4, 1
> +	vle16.v	v0, (a0)
> +	CHECK
> +	EXPECT	CAUSE_STORE_MISALIGNED, 1
> +	addi	a0, s4, 1
> +	vse16.v	v0, (a0)
> +	CHECK
> +
> +	vsetvli	t1, x0, e32, m1, ta, ma
> +	EXPECT	CAUSE_LOAD_MISALIGNED, 1
> +	addi	a0, s4, 1
> +	vle32.v	v0, (a0)
> +	CHECK
> +	EXPECT	CAUSE_STORE_MISALIGNED, 3
> +	addi	a0, s4, 3
> +	vse32.v	v0, (a0)
> +	CHECK
> +
> +	vsetvli	t1, x0, e64, m1, ta, ma
> +	EXPECT	CAUSE_LOAD_MISALIGNED, 1
> +	addi	a0, s4, 1
> +	vle64.v	v0, (a0)
> +	CHECK
> +	EXPECT	CAUSE_STORE_MISALIGNED, 7
> +	addi	a0, s4, 7
> +	vse64.v	v0, (a0)
> +	CHECK
> +
> +	/*
> +	 * ---- Vector strided loads / stores ----
> +	 */
> +	vsetvli	t1, x0, e32, m1, ta, ma
> +	li	a1, 8			/* stride in bytes */
> +	EXPECT	CAUSE_LOAD_MISALIGNED, 1
> +	addi	a0, s4, 1
> +	vlse32.v	v0, (a0), a1
> +	CHECK
> +	EXPECT	CAUSE_STORE_MISALIGNED, 1
> +	addi	a0, s4, 1
> +	vsse32.v	v0, (a0), a1
> +	CHECK
> +
> +	/* ---- Vector indexed loads / stores ---- */
> +	/*
> +	 * Zero indices keep the first element at the deliberately misaligned base.
> +	 */
> +	vmv.v.i	v1, 0
> +	EXPECT	CAUSE_LOAD_MISALIGNED, 1
> +	addi	a0, s4, 1
> +	vluxei32.v	v0, (a0), v1
> +	CHECK
> +	EXPECT	CAUSE_STORE_MISALIGNED, 1
> +	addi	a0, s4, 1
> +	vsuxei32.v	v0, (a0), v1
> +	CHECK
> +
> +	/* ---- Vector segmented loads / stores ---- */
> +	EXPECT	CAUSE_LOAD_MISALIGNED, 1
> +	addi	a0, s4, 1
> +	vlseg2e32.v	v0, (a0)
> +	CHECK
> +	EXPECT	CAUSE_STORE_MISALIGNED, 1
> +	addi	a0, s4, 1
> +	vsseg2e32.v	v0, (a0)
> +	CHECK
> +
> +	/*
> +	 * ---- Vector whole-register load ----
> +	 * Only the whole-register *load* forms carry an element width
> +	 * (vl1re32.v => EEW=32), so only they enforce alignment when Zicclsm is
> +	 * off.  The whole-register store form (vs1r.v) is defined as EEW=8
> +	 * (byte granular) and therefore never faults on misalignment, so it is
> +	 * not exercised here.
> +	 */
> +	EXPECT	CAUSE_LOAD_MISALIGNED, 1
> +	addi	a0, s4, 1
> +	vl1re32.v	v1, (a0)
> +	CHECK
> +
> +	/* Success. */
> +	li	a0, 0
> +	j	_exit
> +
> +	/*
> +	 * Trap handler: validate mcause and mtval against the expectation, bump
> +	 * the trap counter, then skip past the faulting instruction.  The
> +	 * instruction length is decoded from its low two bits (0b11 => 4 bytes,
> +	 * otherwise a 2-byte compressed instruction).
> +	 */
> +	.balign	4
> +trap:
> +	csrr	t0, mcause
> +	bne	t0, s1, fail
> +	csrr	t1, mtval
> +	bne	t1, s2, fail
> +	addi	s3, s3, 1
> +
> +	csrr	t0, mepc
> +	lhu	t2, 0(t0)
> +	andi	t3, t2, 3
> +	li	t4, 3
> +	bne	t3, t4, 1f
> +	addi	t0, t0, 4		/* 32-bit instruction */
> +	j	2f
> +1:
> +	addi	t0, t0, 2		/* 16-bit compressed instruction */
> +2:
> +	csrw	mepc, t0
> +	mret
> +
> +fail:
> +	li	a0, 1
> +_exit:
> +	lla	a1, semiargs
> +	li	t0, 0x20026		/* ADP_Stopped_ApplicationExit */
> +	sd	t0, 0(a1)
> +	sd	a0, 8(a1)
> +	li	a0, 0x20		/* TARGET_SYS_EXIT_EXTENDED */
> +	.balign	16
> +	slli	zero, zero, 0x1f
> +	ebreak
> +	srai	zero, zero, 0x7
> +	j	.
> +
> +	.data
> +	.balign	16
> +semiargs:
> +	.space	16
> +	.balign	64
> +buf:
> +	.byte	0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77
> +	.byte	0x88, 0x99, 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff
> +	.space	240


