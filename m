Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AB1BC5AC67
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 21:16:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ws5Rn-0001Yf-4e; Thu, 06 Aug 2026 17:16:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1ws5RK-0001W0-W7
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 17:15:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1ws5RG-0004GK-Nt
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 17:15:45 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 676L8Aro2400671
 for <qemu-devel@nongnu.org>; Thu, 6 Aug 2026 21:15:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fWUy2aYmybJw0iGJqm+vyBejVVd7F4onqtt/BZDkLtE=; b=N+p5mj1FspY8mNze
 bqVBofOmpVsqqjxWwLWUrKokFFDf8CHyFHEgnUYcSb+XIfYRVqWVj0Zhlp/LyGDv
 WZtSeSEIJ+j4ECf9QY5DmP/Risnr5YcPGqV2cvrg7P0fGH08zfm8fx1ezsl2Lc12
 X1Gmwt3/G1RW20lYyaLf/HyCftgxcxJ3DatlLhAI4oOPWba9WEugYMVsha+ZtVjN
 /1hhXk7RpxA8MHRX4NbAS/7eolBx6eKj7ie0TalYMGgVEqrAnBzn5bEPK4CYlC1H
 r97tz64ZT3B19Uia44eFFyNBifgBbGWyjtAN7mjj22SVEPd9m4/yxBs63IBQTg3E
 Fa+9Yw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6hrsba-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 21:15:40 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e5e38fbc5so310248685a.2
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 14:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786050939; x=1786655739; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fWUy2aYmybJw0iGJqm+vyBejVVd7F4onqtt/BZDkLtE=;
 b=OcBs/0rmxBDwIXhaWv83k9dJxX5YVxPs2T+BFnXOPpqLTnWL1v3y1/X+vBcQUbsrI9
 eXvFj5HprD5T2KNJMoZ1uPsl/+uA5/+5eQIXNocr0Gnccj2qUIsll+W5vmZ4Yf80TA4z
 EjWfJy9jep53xwKtgDwgscaj6RTIGrlNe2Cdf9A7QAmv0EUOBwv8zG/RkdLDOShq54H8
 E6PH9sK6R6woP2gwVkBtbIZxH9hn8icB201npi1jYlEKMl9Z77d24o5fCY2cHmt3ZmsP
 doksVbY53jxc5+YTr1OJ1KEx6Rkig0a9GpqGzKsK5Jrc/RT+6UUNCtO8fpWVMgV6mU5q
 6nvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786050939; x=1786655739;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fWUy2aYmybJw0iGJqm+vyBejVVd7F4onqtt/BZDkLtE=;
 b=ekXKRjkTaHCkBx3BJZrRDMXDKsCjyC6co6c2WJZbfjKq7aBxqzWq4Cpad9h6FilRJo
 vCCBkBBIemNnp/sywZfREeTjNaxoTV6G/p8CpgXhS5FvFYb+79B3PrhYuGynOefAy37a
 MwwJPRSF02lQPkdiACpRrvBbAPWs48pxs8gfsBAmoU/PR/uD9xdXvAW8jxoLiXiw1zdc
 86CTjrknqI9RcBMahaU+XdeUVWH0O9e8AsSuBGXnoKbDYOAeA0WM9eb+3nv+NWoOrQgh
 9ndeLICdO1vBYe+LUqnmvK8Fyza3b36mxJIePUVUDFu1s09OdjCmeHPKnd1WijY9GFcq
 CrCQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoNYr/Tqa41jer4FMdkxAB7wS+od4iKyoAnBkXk90ucia7bjqdbCSWA/SmTYHFhCrorutPLzvmpMsye@nongnu.org
X-Gm-Message-State: AOJu0Yx9TKR3xij0jUxXXEqbMlbjXdTQUDDqRMk/fCjy1T9XgVufKNnz
 JPHBW9tKCHHVRBfuMFA+q2tyLCfhka9OSzvL1buZPYYGp6P1NKtKdMa6DK7tPh3My6mUUif5PLI
 fl3G+mXgN9ZesCV5TuzLnQuVrnT9OFcCpCw255pDYnaJxGKh7qu8ixsUkGA==
X-Gm-Gg: AR+sD12242QhZaliMDPmTVyzTxOwzRHDU7GeQJ0v3ELw5AQpfHDt9pTPU7PEQ9/K2bA
 r767o+7eEOWN9dd2rd5yda6VRR0BGzWM3SGJZSyvBjJWKMTmEgD6NyLuJQX2BP74nOVGWYxBdiT
 PotXL66mdXmATanCDeBqgyPAJORfb80Ico0OsaY0njCjNfBUh7V6mYd7YeFGsh3r/5/Kav2O57k
 HCEsXFKEb1k6gtPaZt3F6dpOY0Zq40jf7VTvIc16Fk7IBCyZqnIzVvxDq7w30W/sU7JAvGDIE7l
 uBNkRsxNIatt7O6fVEPgnUewWrgt75wqe7tJsB90wasw6shNye/zuqlrcFcdnOF/n6jyjH3OpQ5
 wcHLQLjMcSoPsFaEFeQefBAhnVN5T4gK25fpR
X-Received: by 2002:a05:620a:628b:b0:92e:f0a5:ac3e with SMTP id
 af79cd13be357-936490ebca7mr1972156185a.28.1786050939233; 
 Thu, 06 Aug 2026 14:15:39 -0700 (PDT)
X-Received: by 2002:a05:620a:628b:b0:92e:f0a5:ac3e with SMTP id
 af79cd13be357-936490ebca7mr1972145585a.28.1786050938445; 
 Thu, 06 Aug 2026 14:15:38 -0700 (PDT)
Received: from [192.168.68.103] ([187.11.154.152])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9366e09dc07sm751485a.15.2026.08.06.14.15.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2026 14:15:37 -0700 (PDT)
Message-ID: <14401787-24f3-482a-843a-54445a639a6e@oss.qualcomm.com>
Date: Thu, 6 Aug 2026 18:15:35 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] tests/tcg/riscv64: Add tests for SiFive int8 matmul
 extensions
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
References: <20260721122034.1567146-1-max.chou@sifive.com>
 <20260721122034.1567146-6-max.chou@sifive.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260721122034.1567146-6-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: VVATKtHrr2mu0vve6JmvmeMdpj4l65el
X-Proofpoint-ORIG-GUID: VVATKtHrr2mu0vve6JmvmeMdpj4l65el
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDE2NiBTYWx0ZWRfX6dJWgszdBAW6
 kVnXmZRuT9KdIpoP/uKtbLbRtu2ZZJx5jNYQAmZJNshCRuSQ7Yw7jZZZbK6ICkdvY7ySNNEU1qs
 ETTwDPTmhgIWAun779DudKOqsvwbTE4pVsnGfiKTw6Cx6DYjYS9ercVMfV9k9snBOY8keos3RDi
 cQitnaa50b0e7klDaGas8QVHI9yUOQP7z4cP99xxd2lWzNCZMKEbqIc9cYBmwzeD+gBLATD0jHR
 TWw2i6versRznvooRpiOQIYE73nfyr15asz8JIAkUTm2EO/IffyPIbKSoW/TYO/WCaVc11DmPaE
 1oRlCF8hCOCxuykjyB0xTe5suJ9Umy4pIGQrRVaqob8p45rsLemZlvNdpDhOQ+pkI/XGaEC+8HK
 l6BNGOeSrMXbwhFDuQKNgYIuYD8NWmA87X/Uh9syRc0Ijf3ifdmiMEF5/78iF6FoceNJsFkwGiX
 FGi6nGbCLDMX5PSWp8w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDE2NiBTYWx0ZWRfX1BOWNXyO5mQE
 NzIRHZN8WLkaH6o4pIqEw9D2ql4tlPVsTk8wG91kGJpv/DV0p6rqn5EIzF5k8KRFtuin/YLpiMf
 fKPnw0OnrMoAj6HVwpUnMvAhPr5/BAE=
X-Authority-Analysis: v=2.4 cv=bot8wkai c=1 sm=1 tr=0 ts=6a74f97c cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=iMfxv9gflPUPBcmW7/Gq5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=pFyQfRViAAAA:8 a=EUspDBNiAAAA:8 a=YEB5RgzmAAAA:8 a=ahcp0SknNaDeMIOZQ3YA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=oJz5jJLG1JtSoe7EL652:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_03,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060166
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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



On 7/21/2026 9:20 AM, Max Chou wrote:
> Add a test that exercises all SiFive int8 matrix-multiply instructions
> from the Xsfvqmaccqoq and Xsfvqmaccdod extensions.
> 
> For each tile shape the test covers the four signedness variants
> (sf.vqmaccu / sf.vqmacc / sf.vqmaccus / sf.vqmaccsu) and the
> reserved-encoding path: with vl set to a value that is not a multiple
> of the tile size the helper raises an illegal-instruction exception.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---


Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   MAINTAINERS                               |   1 +
>   tests/tcg/riscv64/Makefile.softmmu-target |   7 +
>   tests/tcg/riscv64/test-xsfvqmacc.S        | 260 ++++++++++++++++++++++
>   3 files changed, 268 insertions(+)
>   create mode 100644 tests/tcg/riscv64/test-xsfvqmacc.S
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1a40d86685..d7bfe19b1d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -396,6 +396,7 @@ S: Supported
>   F: target/riscv/xsf.decode
>   F: target/riscv/tcg/insn_trans/trans_xsf.c.inc
>   F: disas/riscv-xsf*
> +F: tests/tcg/riscv64/test-xsfvqmacc.S
>   
>   RENESAS RX CPUs
>   R: Yoshinori Sato <yoshinori.sato@nifty.com>
> diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
> index 82be8a2c91..0615dc83e8 100644
> --- a/tests/tcg/riscv64/Makefile.softmmu-target
> +++ b/tests/tcg/riscv64/Makefile.softmmu-target
> @@ -41,5 +41,12 @@ comma:= ,
>   run-test-crc32: test-crc32
>   	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)xlrbr=true $(QEMU_OPTS)$<)
>   
> +# The SiFive int8 matmul instructions are reserved unless VLEN >= 256, so the
> +# runner selects vlen=256 along with both extensions.
> +EXTRA_RUNS += run-test-xsfvqmacc
> +XSFVQMACC_CPU = rv64$(comma)v=true$(comma)vlen=256$(comma)xsfvqmaccdod=true$(comma)xsfvqmaccqoq=true
> +run-test-xsfvqmacc: test-xsfvqmacc
> +	$(call run-test, $<, $(QEMU) -cpu $(XSFVQMACC_CPU) $(QEMU_OPTS)$<)
> +
>   # We don't currently support the multiarch system tests
>   undefine MULTIARCH_TESTS
> diff --git a/tests/tcg/riscv64/test-xsfvqmacc.S b/tests/tcg/riscv64/test-xsfvqmacc.S
> new file mode 100644
> index 0000000000..a116712e50
> --- /dev/null
> +++ b/tests/tcg/riscv64/test-xsfvqmacc.S
> @@ -0,0 +1,260 @@
> +/*
> + * Test the SiFive Xsfvqmaccqoq/Xsfvqmaccdod custom int8 matrix-multiply
> + * extensions.
> + *
> + * The eight instructions widen 8-bit integer inputs to 32 bits and perform
> + * a matrix-multiply-accumulate into a vector of int32 accumulators:
> + *
> + *   C[j] += A * B[j]
> + *
> + * Xsfvqmaccqoq (4x8x4): A is 4x8, B[j] is 8x4, C[j] is 4x4 int32. One matrix
> + * operation is performed per 32 elements of vl (TILE_SIZE = 32).
> + * Xsfvqmaccdod (2x8x2): A is 2x8, B[j] is 8x2, C[j] is 2x2 int32. One matrix
> + * operation is performed per 16 elements of vl (TILE_SIZE = 16).
> + *
> + * The input tiles below contain bytes >= 0x80 so that each signedness
> + * variant produces a distinct result; the expected int32 tiles were computed
> + * with an independent reference model of the specification. The accumulators
> + * are cleared before every operation, so the expected value is the pure
> + * matrix product.
> + *
> + * Test exits via semihosting with status 0 on success, or the 1-based index
> + * of the first failing operation.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +	.option arch, +v
> +	.option norvc
> +
> +	.text
> +
> +/*
> + * Run one 4x8x4 operation: load the 32-byte A and B tiles, clear the 4x4
> + * int32 accumulator (vd = v4:v5, EMUL = 2), execute the op, then compare the
> + * 16 int32 results against the expected tile.
> + */
> +.macro RUN_QOQ id, word, exp
> +	li	a2, 32
> +	vsetvli	t0, a2, e8, m1, ta, ma
> +	la	t1, a_qoq
> +	vle8.v	v1, (t1)
> +	la	t1, b_qoq
> +	vle8.v	v2, (t1)
> +	vsetvli	t0, x0, e32, m2, ta, ma
> +	vmv.v.i	v4, 0
> +	li	a2, 32
> +	vsetvli	t0, a2, e8, m1, ta, ma
> +	.word	\word
> +	vsetvli	t0, x0, e32, m2, ta, ma
> +	la	t1, result
> +	vse32.v	v4, (t1)
> +	la	a0, result
> +	la	a1, \exp
> +	li	a2, 16
> +	li	t6, \id
> +	call	check_words
> +.endm
> +
> +/*
> + * Run one 2x8x2 operation: load the 16-byte A and B tiles, clear the 2x2
> + * int32 accumulator (vd = v4, EMUL = 1), execute the op, then compare the
> + * 4 int32 results against the expected tile.
> + */
> +.macro RUN_DOD id, word, exp
> +	li	a2, 16
> +	vsetvli	t0, a2, e8, m1, ta, ma
> +	la	t1, a_dod
> +	vle8.v	v1, (t1)
> +	la	t1, b_dod
> +	vle8.v	v2, (t1)
> +	vsetvli	t0, x0, e32, m1, ta, ma
> +	vmv.v.i	v4, 0
> +	li	a2, 16
> +	vsetvli	t0, a2, e8, m1, ta, ma
> +	.word	\word
> +	vsetvli	t0, x0, e32, m1, ta, ma
> +	la	t1, result
> +	vse32.v	v4, (t1)
> +	la	a0, result
> +	la	a1, \exp
> +	li	a2, 4
> +	li	t6, \id
> +	call	check_words
> +.endm
> +
> +	.global _start
> +_start:
> +	/* Enable the vector unit (mstatus.VS = Initial). */
> +	li	t0, 1 << 9
> +	csrs	mstatus, t0
> +
> +	/* Route synchronous traps to trap_handler (mtvec direct mode). */
> +	la	t0, trap_handler
> +	csrw	mtvec, t0
> +
> +	RUN_QOQ	1, 0xF220A25B, exp_qoq_u	/* sf.vqmaccu.4x8x4  */
> +	RUN_QOQ	2, 0xF620A25B, exp_qoq_s	/* sf.vqmacc.4x8x4   */
> +	RUN_QOQ	3, 0xFA20A25B, exp_qoq_us	/* sf.vqmaccus.4x8x4 */
> +	RUN_QOQ	4, 0xFE20A25B, exp_qoq_su	/* sf.vqmaccsu.4x8x4 */
> +	RUN_DOD	5, 0xB220A25B, exp_dod_u	/* sf.vqmaccu.2x8x2  */
> +	RUN_DOD	6, 0xB620A25B, exp_dod_s	/* sf.vqmacc.2x8x2   */
> +	RUN_DOD	7, 0xBA20A25B, exp_dod_us	/* sf.vqmaccus.2x8x2 */
> +	RUN_DOD	8, 0xBE20A25B, exp_dod_su	/* sf.vqmaccsu.2x8x2 */
> +
> +	/*
> +	 * Illegal-instruction reporting test (op 9).
> +	 *
> +	 * When vl is not a multiple of the tile size the instruction is
> +	 * reserved and the helper raises an illegal-instruction exception at
> +	 * runtime.
> +	 */
> +	la	t1, trap_mtval
> +	sd	zero, 0(t1)
> +	la	t1, trap_mcause
> +	sd	zero, 0(t1)
> +	/* vl = 16 is not a multiple of the 4x8x4 tile size (32 elements). */
> +	li	a2, 16
> +	vsetvli	t0, a2, e8, m1, ta, ma
> +	.word	0xF220A25B		/* sf.vqmaccu.4x8x4, traps */
> +	/* The handler skips the faulting insn, so control resumes here. */
> +	li	a0, 9			/* fail code for this check */
> +	la	t1, trap_mcause
> +	ld	t2, 0(t1)
> +	li	t3, 2			/* RISCV_EXCP_ILLEGAL_INST */
> +	bne	t2, t3, _exit
> +	la	t1, trap_mtval
> +	ld	t2, 0(t1)
> +	li	t3, 0xF220A25B
> +	bne	t2, t3, _exit
> +
> +	li	a0, 0
> +	j	_exit
> +
> +/*
> + * Machine-mode trap handler: record mcause and mtval, then advance mepc
> + * past the 4-byte faulting instruction and return.
> + */
> +	.balign	4
> +trap_handler:
> +	csrr	t4, mcause
> +	la	t5, trap_mcause
> +	sd	t4, 0(t5)
> +	csrr	t4, mtval
> +	la	t5, trap_mtval
> +	sd	t4, 0(t5)
> +	csrr	t4, mepc
> +	addi	t4, t4, 4
> +	csrw	mepc, t4
> +	mret
> +
> +/*
> + * check_words(a0 = result, a1 = expected, a2 = word count).
> + * Returns to the caller if every word matches; otherwise exits with the
> + * operation index held in t6.
> + */
> +check_words:
> +1:	beqz	a2, 2f
> +	lw	t2, 0(a0)
> +	lw	t3, 0(a1)
> +	bne	t2, t3, 3f
> +	addi	a0, a0, 4
> +	addi	a1, a1, 4
> +	addi	a2, a2, -1
> +	j	1b
> +2:	ret
> +3:	mv	a0, t6
> +	j	_exit
> +
> +/* Exit through the semihosting SYS_EXIT_EXTENDED call with a0 as the code. */
> +_exit:
> +	la	a1, semiargs
> +	li	t0, 0x20026	/* ADP_Stopped_ApplicationExit */
> +	sd	t0, 0(a1)
> +	sd	a0, 8(a1)
> +	li	a0, 0x20	/* TARGET_SYS_EXIT_EXTENDED */
> +	.balign	16
> +	slli	zero, zero, 0x1f
> +	ebreak
> +	srai	zero, zero, 0x7
> +	j	.
> +
> +	.data
> +	.balign	8
> +semiargs:
> +	.space	16
> +result:
> +	.space	64
> +trap_mcause:
> +	.space	8
> +trap_mtval:
> +	.space	8
> +
> +/*
> + * A (4x8, row-major) in bytes [0, 32) of vs1.
> + */
> +a_qoq:
> +	.byte	0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x80
> +	.byte	0xFF, 0x01, 0x00, 0x02, 0x7F, 0x03, 0x04, 0x05
> +	.byte	0x10, 0x20, 0x30, 0x40, 0x50, 0x60, 0x70, 0x08
> +	.byte	0x00, 0x00, 0x81, 0x00, 0x00, 0x02, 0x00, 0x03
> +/*
> + * B (8x4, row-major) in bytes [0, 32) of vs2.
> + */
> +b_qoq:
> +	.byte	0x01, 0x02, 0x03, 0x04
> +	.byte	0x05, 0x06, 0x07, 0x08
> +	.byte	0x80, 0x7F, 0xFF, 0x01
> +	.byte	0x00, 0x10, 0x20, 0x30
> +	.byte	0x02, 0x02, 0x02, 0x02
> +	.byte	0xFE, 0x01, 0x00, 0x7F
> +	.byte	0x03, 0x00, 0x81, 0x04
> +	.byte	0x40, 0x50, 0x60, 0x70
> +/*
> + * A (2x8, row-major) in bytes [0, 16) of vs1.
> + */
> +a_dod:
> +	.byte	0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x80
> +	.byte	0xFF, 0x7F, 0x00, 0x02, 0x81, 0x03, 0x04, 0x05
> +/*
> + * B (8x2, row-major) in bytes [0, 16) of vs2.
> + */
> +b_dod:
> +	.byte	0x01, 0x02
> +	.byte	0x80, 0x7F
> +	.byte	0x03, 0xFF
> +	.byte	0x00, 0x10
> +	.byte	0x02, 0xFE
> +	.byte	0x7F, 0x01
> +	.byte	0x81, 0x04
> +	.byte	0x40, 0x50
> +
> +	.balign	4
> +exp_qoq_u:
> +	.word	0x0000279e, 0x000029db, 0x0000371f, 0x00003bf7
> +	.word	0x00000648, 0x000004b5, 0x00000826, 0x0000091f
> +	.word	0x00007be0, 0x00002030, 0x000074f0, 0x000042f0
> +	.word	0x0000433c, 0x000040f1, 0x0000819f, 0x000002cf
> +exp_qoq_s:
> +	.word	0xffffde9e, 0xffffd9db, 0xffffcd1f, 0xffffcbf7
> +	.word	0x00000248, 0x000002b5, 0x00000126, 0x0000051f
> +	.word	0xffffebe0, 0x00002030, 0xffffd4f0, 0x000042f0
> +	.word	0x0000403c, 0xffffc1f1, 0x0000019f, 0x000001cf
> +exp_qoq_us:
> +	.word	0x00001e9e, 0x000029db, 0x00002d1f, 0x00003bf7
> +	.word	0x00000348, 0x000004b5, 0x00000426, 0x0000091f
> +	.word	0xffffebe0, 0x00002030, 0xffffd4f0, 0x000042f0
> +	.word	0xffffc03c, 0x000040f1, 0x0000009f, 0x000002cf
> +exp_qoq_su:
> +	.word	0xffffe79e, 0xffffd9db, 0xffffd71f, 0xffffcbf7
> +	.word	0x00000548, 0x000002b5, 0x00000526, 0x0000051f
> +	.word	0x00007be0, 0x00002030, 0x000074f0, 0x000042f0
> +	.word	0xffffc33c, 0xffffc1f1, 0xffff829f, 0x000001cf
> +exp_dod_u:
> +	.word	0x00002795, 0x00003155, 0x00004642, 0x0000c2c0
> +exp_dod_s:
> +	.word	0xffffde95, 0xffffd955, 0xffffc042, 0x000041c0
> +exp_dod_us:
> +	.word	0x00001e95, 0x00002955, 0xffffc342, 0x000041c0
> +exp_dod_su:
> +	.word	0xffffe795, 0xffffe155, 0x00004342, 0xffffc2c0


