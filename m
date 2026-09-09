Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65EE4C79FB7
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 20:00:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4OT6-0007iQ-Gu; Wed, 09 Sep 2026 16:00:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x4OT4-0007iB-M3
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 16:00:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x4OT2-0004yo-KG
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 16:00:26 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 689JIJNY2363889
 for <qemu-devel@nongnu.org>; Wed, 9 Sep 2026 20:00:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 acmG/ACODRrT1f+10QfSibKNLeqn1nMWupKUbr9cIH4=; b=YlJUdnIEmoqACLoo
 byKq5BN9ocfLGAXe7fGINCMej3pTaIyqcKGk19a3UmPhd/ARPj4IMfqtRv12Gu76
 fzd+cxakpJK8H+j3m21WWT/ws/Kit0yTKyW7lK8GcGz2ESNmm6Ww5jp+RqV6NmFq
 nP3OmgKoAo0L+Wo2CNWenMGzLXDD172KeYKy4FJI/wQpnXD4k7etFVlcRe+P2icE
 2vuLiUAJrABmjENqYIXuvE2VA872hVA1X+GNFCXwCqYmDZpqeRAfC8ymL1/Dwx/U
 i73bZfC4PLh0sPzNeS+Hq3izbiPjgtevzjINLO2mHbORAFmWTneLUNJcTiZOSw88
 AoAqow==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkcydrc6u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 20:00:15 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-934956beec8so898135985a.0
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 13:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788984008; x=1789588808; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=acmG/ACODRrT1f+10QfSibKNLeqn1nMWupKUbr9cIH4=;
 b=SYs7o55Hba1jNuitczCtQo3TcoZ/14cZDnNt+w835yjENqotfz/zcYSj6wU6rDLS6c
 E0lbpAsbIU8Eoh4/OD671ru0OXBKmcNGbzTS2/hnZkYOiYOfNcU816XTlyRszQ6gy+Ou
 Y+yk81S+C2NYMv/Crf9nT1DrBI5qCNA9FNTju8aCGcKhtH2aDAxCM1T7shLZhq4X4Oe0
 uLLG7jXQPfgkQrKFz1AuB5jO2/afcdNOHQbRXCCqzdjIZNLXPKLQUPdirTK+Q8Z5zsuD
 9j6UM2BzngyHecTva+33JPwJY5GLfQ0UFn4DDzB1aCBXST8BDucvybKjp6Gb41S62qb0
 0tHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788984008; x=1789588808;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=acmG/ACODRrT1f+10QfSibKNLeqn1nMWupKUbr9cIH4=;
 b=Rsj0J+CqQ9bgRx0aQlWdzED+BzuWM3czRBUUtXBEtlaP7qiivv6xtDKepLuTczq7Bj
 H5wKtBUO+7zPzZpP9cT1jA43MPEZFr/6KzteKVA/M+DG/MRiVM3q5FhXH9Cx3vlpesWd
 ngfnsZFKOo6oiJCamEAU0iLcjFDbA6b0HMkJOMU9Jd5tw1+6fMb3QkfO4RlSMPwvLBlF
 xJ80aryL2iftY+Did6VcYOUx+EOnUHYyKcnMFQ89MqFuSzv5r0sPchBn1w4jWZC87upT
 +QIwSNpBBfGGRVzFauRkgQ8SGhzk0I1Kr7DqQwwMLU79lQtmIxKkFSvwXglqHKLtFr8N
 CvQw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxNuffW0LX1tbnqNx2HezSbnb8h/YMep4AyM9svV9C7ygP0HYnY211eBFyBfeLHGqIQDNiuGakQs+T3@nongnu.org
X-Gm-Message-State: AFuF++kodgZ/BPZbPBpy2thjMN7IuHjNqWguWbQ2zDPyae1OmliJXeCP
 ppIrOdaUQ7LUJBm6vDu4tFia+1Iz45s2zBKlk6/EcbLuuJg5afmG9nflyn2PQnWKxIcJobH4J3U
 wRnk8CBQTBuJv4IhZLoFlsoHIdMuJ63WMxieZdZ/IBl7uBVjj662HHt/ZZqFMenCZGg==
X-Gm-Gg: AYBFou1726jhFuQ12cO1ompJQqjHnWIqYM0rAoQiI6VLyhg1tMGSKyQ0Sh2Dm+IkwQB
 bKpGAFnzI8OZCQyJF9x8qkoSVjR0cz27vT1rknMYLMJpSGuDHJR/ZQD2HMrNhYbXTPJFDlKdv6j
 JPEl7TeJ57o7VUAX1Q5BIqW7j7fDqVLfPwOBl4NP2kkD/5PhF8ZiZgQdqxeFqrataZE5lGoRfFw
 BRkzSUtvc7I+/0GCFIwJ9PSRYKF2GTpoveO+5fQj+xAzOhecC5SkU0a3UkoYymMhcbwXg7Bhux7
 yRNBh4Matm2u5fzNavo8Ila2vnfjHppsxoq/Nb/0Spc5qOG/7/Xk4DXNFiSzmx/X3CujBCvkf7H
 80kQP4LiOtwFdgEpHop10jJttOm/gMFuYwHM=
X-Received: by 2002:a05:620a:460c:b0:930:a26a:fb2a with SMTP id
 af79cd13be357-9398031b58fmr3843498385a.2.1788984007528; 
 Wed, 09 Sep 2026 13:00:07 -0700 (PDT)
X-Received: by 2002:a05:620a:460c:b0:930:a26a:fb2a with SMTP id
 af79cd13be357-9398031b58fmr3843489685a.2.1788984006943; 
 Wed, 09 Sep 2026 13:00:06 -0700 (PDT)
Received: from [192.168.68.102] ([177.18.66.131])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93982db6a95sm1421068585a.9.2026.09.09.13.00.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Sep 2026 13:00:06 -0700 (PDT)
Message-ID: <71246cae-21b4-4725-aa83-e1afcf338bbd@oss.qualcomm.com>
Date: Wed, 9 Sep 2026 17:00:03 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: stop translating after WFI
To: Zephyr Li <fritchleybohrer@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
References: <20260908022744.20333-1-fritchleybohrer@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260908022744.20333-1-fritchleybohrer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=IfsSymqa c=1 sm=1 tr=0 ts=6aa1bacf cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=CQQxcbsX5Byh3TlVSSGwig==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=p0WdMEafAAAA:8 a=pGLkceISAAAA:8 a=voxrwLIUQBIEJ0OO-V8A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: iEVeZDHvjvHF0TezuxG0DXiZp4MP331T
X-Proofpoint-ORIG-GUID: iEVeZDHvjvHF0TezuxG0DXiZp4MP331T
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDIyMiBTYWx0ZWRfXyR1A/YMNURCB
 TFg89FL4aLyHMv8JL1slNMPVbBtFS9h5dqrOMI59FynTH8zcbw/rx8lI+kQO2tmXM00TGH8V5tW
 EkPWRDlxyH1dULtwZxANMSEelM2Z8Dk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDIyMiBTYWx0ZWRfX57aqPparM1v3
 /LZ3L9PMXJQOMNaNe72HvjaWxBQcAIja/apjb5Nxx/JVfK6xOqS4pDwHBnV6Y1Tf48rXoI9ey7o
 YKsa8uNApUNAK/kZIXwzuQn7Et+ywZc5/bs9p6022Rqop6FEf6s+O5g1W00YKG4g8OREHRzUBFc
 t4TE/fPjsRFFbbu+7xYpo6zoxIrfJ2pG4E5/dEwspsZpntKdrx7wwP9f02Q7Cu9z87tM1jdzBFN
 1xs34qzxcyO50FYRkyW0Xv3/yPbxtp955JSJSHSZasuBM7Yn2SDpoCy65bHfJnvQZSaRm+DGSlP
 epVp2FqRVa+XbUSbuSwuGjwYsXBiuFqU1CMo1e3QRIXCUEB2aR26PYDvaJMevI0OiurG5MqsroB
 LIDWOiMuLvPSOnlofzztIQ1CYxDvc+5kIqqmIvLDE9X15/ihMevYVqVdbgOt4sjKedYaZrTRScq
 k6NLgdFFwCtJAyCEH2A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-09_01,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609090222
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 9/7/2026 11:27 PM, Zephyr Li wrote:
> helper_wfi() never returns to translated code: it either raises an
> exception or exits the CPU loop after marking the CPU as halted. However,
> trans_wfi() leaves the translation state as DISAS_NEXT, so instructions
> following WFI can be included in the same TB.
> 
> With icount enabled, this makes the following instruction part of the TB's
> instruction count when WFI exits, causing minstret to be incremented once
> too many. Set DISAS_NORETURN after emitting the helper.
> 
> Add a TCG test for both reported cases: WFI waking for a locally enabled
> pending interrupt with mstatus.MIE clear, and WFI taking a timer interrupt.
> 
> Fixes: 55c2a12cbcd3 ("RISC-V TCG Code Generation")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4230
> Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
> ---

Code LGTM.  We just need to use the meson stuff for the new test-minstret-wfi.S
test.  Otherwise 'check-tcg' won't execute it.


Thanks,
Daniel

>   .../tcg/insn_trans/trans_privileged.c.inc     |   1 +
>   tests/tcg/riscv64/Makefile.softmmu-target     |   4 +
>   tests/tcg/riscv64/test-minstret-wfi.S         | 100 ++++++++++++++++++
>   3 files changed, 105 insertions(+)
>   create mode 100644 tests/tcg/riscv64/test-minstret-wfi.S
> 
> diff --git a/target/riscv/tcg/insn_trans/trans_privileged.c.inc b/target/riscv/tcg/insn_trans/trans_privileged.c.inc
> index a8eaccef67..ebbbb01179 100644
> --- a/target/riscv/tcg/insn_trans/trans_privileged.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_privileged.c.inc
> @@ -145,6 +145,7 @@ static bool trans_wfi(DisasContext *ctx, arg_wfi *a)
>       decode_save_opc(ctx, 0);
>       gen_update_pc(ctx, ctx->cur_insn_len);
>       gen_helper_wfi(tcg_env);
> +    ctx->base.is_jmp = DISAS_NORETURN;
>       return true;
>   #else
>       return false;
> diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
> index 6a219c306c..96a3ab32c9 100644
> --- a/tests/tcg/riscv64/Makefile.softmmu-target
> +++ b/tests/tcg/riscv64/Makefile.softmmu-target
> @@ -28,6 +28,10 @@ EXTRA_RUNS += run-test-minstret-ecall
>   run-test-minstret-ecall: test-minstret-ecall
>   	$(call run-test, $<, $(QEMU) -icount shift=1 $(QEMU_OPTS)$<)
>   
> +EXTRA_RUNS += run-test-minstret-wfi
> +run-test-minstret-wfi: test-minstret-wfi
> +	$(call run-test, $<, $(QEMU) -icount shift=1 $(QEMU_OPTS)$<)
> +
>   EXTRA_RUNS += run-plugin-doubletrap
>   run-plugin-doubletrap: doubletrap
>   	$(call run-test, $<, \
> diff --git a/tests/tcg/riscv64/test-minstret-wfi.S b/tests/tcg/riscv64/test-minstret-wfi.S
> new file mode 100644
> index 0000000000..0fd0158d5b
> --- /dev/null
> +++ b/tests/tcg/riscv64/test-minstret-wfi.S
> @@ -0,0 +1,100 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +	.option	norvc
> +
> +	.text
> +	.global	_start
> +_start:
> +	lla	t0, trap
> +	csrw	mtvec, t0
> +	li	s3, 0
> +
> +	/*
> +	 * A pending, locally enabled interrupt wakes WFI even with MIE
> +	 * clear.
> +	 */
> +	li	t0, 0x8		/* MIE_MSIE */
> +	csrw	mie, t0
> +	csrci	mstatus, 0x8	/* MSTATUS_MIE */
> +	li	t0, 0x2000000	/* MSIP0 */
> +	li	t1, 1
> +	sw	t1, 0(t0)
> +
> +	/*
> +	 * The first CSR read and WFI retire before the second read obtains s1,
> +	 * so the expected difference is two.
> +	 */
> +	csrr	s0, minstret
> +	wfi
> +	csrr	s1, minstret
> +	sub	s1, s1, s0
> +	li	t1, 2
> +	beq	s1, t1, 1f
> +	ori	s3, s3, 1
> +1:
> +
> +	/* Clear the software interrupt before testing the trap path. */
> +	sw	zero, 0(t0)
> +	csrw	mie, zero
> +
> +	/* Schedule a timer interrupt far enough ahead to reach WFI first. */
> +	li	t0, 0x200bff8	/* MTIME */
> +	ld	t1, 0(t0)
> +	addi	t1, t1, 100
> +	li	t0, 0x2004000	/* MTIMECMP0 */
> +	sd	t1, 0(t0)
> +	li	t0, 0x80		/* MIE_MTIE */
> +	csrw	mie, t0
> +	csrsi	mstatus, 0x8	/* MSTATUS_MIE */
> +
> +	/*
> +	 * The first CSR read and WFI retire before the trap handler obtains s1,
> +	 * so the expected difference is again two.
> +	 */
> +	li	s2, 1
> +	csrr	s0, minstret
> +	wfi
> +	beqz	s2, 1f
> +	ori	s3, s3, 2
> +1:
> +	bnez	s3, fail
> +	li	a0, 0
> +	j	_exit
> +
> +fail:
> +	mv	a0, s3
> +
> +_exit:
> +	lla	a1, semiargs
> +	li	t0, 0x20026	/* ADP_Stopped_ApplicationExit */
> +	sd	t0, 0(a1)
> +	sd	a0, 8(a1)
> +	li	a0, 0x20	/* TARGET_SYS_EXIT_EXTENDED */
> +
> +	/* Semihosting call sequence */
> +	.balign	16
> +	slli	zero, zero, 0x1f
> +	ebreak
> +	srai	zero, zero, 0x7
> +	j	.
> +
> +	.balign	4
> +trap:
> +	/* Read minstret before retiring an instruction in the handler. */
> +	csrr	s1, minstret
> +	sub	s1, s1, s0
> +	addi	s1, s1, -2
> +	snez	s2, s1
> +
> +	/* Disable the timer interrupt before returning past WFI. */
> +	li	t0, 0x2004000	/* MTIMECMP0 */
> +	li	t1, -1
> +	sd	t1, 0(t0)
> +	li	t0, 0x80		/* MIE_MTIE */
> +	csrc	mie, t0
> +	mret
> +
> +	.data
> +	.balign	16
> +semiargs:
> +	.space	16


