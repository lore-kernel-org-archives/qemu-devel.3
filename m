Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B176EC5DF67
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 06:06:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwCxD-0002OX-4Z; Tue, 18 Aug 2026 02:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwCxB-0002OM-US
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 02:05:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwCx9-0008QY-Ng
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 02:05:41 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67I12JYk297628
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 06:05:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oIu2Xw0vTh6i5EKOC3/GXR3Ckc4snbnc0GuNmjitzrM=; b=UeT1q5nF+jdsIGsL
 zL9JwNm3MItUQHHeTWOuOFvddti1afnJBA32fW7115M7qED7EOiu0oZ4QhjF0exx
 HiEulqAvcpB3cp+TRC+SnWtigiKfo9R2t01GBN9QgCbHO5LwpNua0y+u8XARKCUY
 HP5lXgq61urCr46kAgE5/gNbUFkxBUN8sxsqFwcb1blR+ngHdzC9Y9m09S2N43Ql
 x4ivvMFE1q19YLDZ1R4R+TxkdGx2wv4XVu7rpFB/mYLy30Kgef9Ft3MJg+abBN5E
 r7VCpgsCK0xHpjf1/6IqE3NFJnoZOm+r/0OIARKHUG7ipF3CdWKQYIKi4Q4GNFwl
 pdjxAg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4dcn1457-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 06:05:37 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-52d91cc174aso66890421cf.2
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 23:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787033137; x=1787637937; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=oIu2Xw0vTh6i5EKOC3/GXR3Ckc4snbnc0GuNmjitzrM=;
 b=RZ8tfQGXwbqjnZkrac244O6N4D4TcIqjUjDET5b+hIusDsx5jUi9T+yMpQ+Wrtl8Gd
 5NQ4Kx0WHb/1vib+F25vVY1wsUH1m3IZrAL7fSDt7vLM6nAyAso7ZOlCUO1xXUaOZdCi
 cxWmPLwMuMiU2WuRyb7oUW8MbUxwzQXqQIGiquNzqBfsKJwSVQtXpCes0LUVdVEbfQo2
 qFn/Z8QWS9gfIMkbW1Hs3zGAXNG4wC57F/Yr8KGDKDJeqbNuXQnowHsrRN8vcQcYmnMe
 G6KafMjO8tQYq1IFfr0AaUenXwHJZb9rOUo/vwF/hGzkWqwwwf7KeAyNqSQqON+5JXZo
 yGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787033137; x=1787637937;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oIu2Xw0vTh6i5EKOC3/GXR3Ckc4snbnc0GuNmjitzrM=;
 b=li73Q/pUndil+fWVg8/P/FSaJOwtDQlD/1iH7XG3cBC+8Mh5FYMsNw2fmHdXXpzpCy
 EvO/lX2PLBt0e+LLEz/bo9R23SGdjvbH79ngZXmIvBqrXlZ858LYZyFMBucjYXyBQo+Q
 Ipa9XJr7KJg56xehelWvLEnk6u8Efg2We9KfwSJGn7trGkjXOYIHuh7wgxXwAs5O3RD5
 2cjWGLDRRYoVvTvbLLbUvXFA+PWhFXjGnyBfmRdvpEwamITKvqbcMHkJ7tprsdTEgjiM
 dB2uZ/aP4ZvG2vRaRnZNNrujbpZp3F+Sblz/Qgvh7Z2ftShGwby/PKbWyIrwX9ufJbss
 t5YQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpUon4hKqnvbSAtrM8U/tdxHT28C1YBQ2GZD7Rle7qWhpwzAcPvOKjyzTDmhMcZm6ISlfJqPjeJyQbt@nongnu.org
X-Gm-Message-State: AOJu0Yy+1LqSQsPtlkoVADILJF1FxqIMEyU+TWJqAbBNNwOFAbfZQdGg
 ir/4zJAmK5cb4ZwdmclZ9k2H7DT8T3Xy+b7qMMCfncgRds1fUoLQInxCD3/dSgX4nL9Wx1wmYlg
 lH37o9BUvX0Nqaa1syzMD4gBZ8fde/0TavBcnvsqMNatEYkMTOGHQRIp70Q==
X-Gm-Gg: AR+sD12692yXRGW9occmE4kHQNlaijNGd6I8PJjZJr/au//xwXb/1q9H2qPkyK0i8Ir
 ifc1yudg/rjoSXw1VN27u41RyU6JxiIct3GBOUhTm7Uo9mxfrg6eU8h10a12D2FyDnTBtL5CFcI
 oMBHBz5/RdYbTyOPTtzbD8VVq8LMqEXiCIyBY1/OkGEVZWdBxGMVzJhJxT9EKPNa7w3kQ0zVMz+
 +i4HU9Kq95sAoEtNdDH66qf7pyoVjrbDhfTu1+cplkzqxg1HTDo3BiHivmbYGjul8CLYprCnIt3
 NKTdqT8dx9Os+mSozUWJY6/NK0gx8CaJtPm8Sz+ESdmCBRD4rL1IfftUJj/8NFHyvsdJp5s4fw8
 6BcVfbQVaCkkbeONROcW+wCg20PnVwYGMk1U=
X-Received: by 2002:a05:622a:588e:b0:52d:6cf5:1c01 with SMTP id
 d75a77b69052e-52d854bd891mr324216241cf.36.1787033136606; 
 Mon, 17 Aug 2026 23:05:36 -0700 (PDT)
X-Received: by 2002:a05:622a:588e:b0:52d:6cf5:1c01 with SMTP id
 d75a77b69052e-52d854bd891mr324215861cf.36.1787033136051; 
 Mon, 17 Aug 2026 23:05:36 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996188217sm485646195e9.13.2026.08.17.23.05.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2026 23:05:35 -0700 (PDT)
Message-ID: <0aac0ca5-2508-46d0-ba3f-fc9d0ff32100@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 08:05:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/8] RFC: tcg: probe the TB jump cache inline instead
 of calling a helper
Content-Language: en-US
To: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, philmd@mailo.com,
 zhao1.liu@intel.com, laurent@vivier.eu, deller@gmx.de,
 pierrick.bouvier@oss.qualcomm.com
References: <20260817190038.580257-1-mattst88@gmail.com>
 <20260817190038.580257-5-mattst88@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260817190038.580257-5-mattst88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: -zwtxujX8sDx1tUhhX1NzsbpqQzP213X
X-Authority-Analysis: v=2.4 cv=Gs5yPE1C c=1 sm=1 tr=0 ts=6a83f631 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=pGLkceISAAAA:8 a=6KYHkuE4E4tEOf1rhe8A:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: -zwtxujX8sDx1tUhhX1NzsbpqQzP213X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA0MyBTYWx0ZWRfX1BcpXsGP7K1j
 9CJnNEC1wQQQza61LUCc5D+LW+3+SRdq7nKThqss88OrVfmk8AI5d/FCaT2S3PZQy99U4ZhIvkO
 2YEvs2KiCFeG0gFQqtdz2p9Jax2ZEgnWmZFrnkU/puq/tpo/pmLxTx9idLB6d627fXwCurZ3/L3
 oqn5A78cD+JEN6KwVbqUfIIFgSbUtXXQ4bDc4l5uuNFFJUzZRNnbxR0qcc1RVDyNV27MGALP8rQ
 RDPuXI+BQt/0LUQWdzcvCST9ydoeospOk37qkHQjiH3d7zucu388iu8iYIdDekcFY1MejD0efqz
 irr1Yz4G8FSAOYylPYOmJvVLeCLtB3FTUIZulHwhY5oGQTm3ogXZbiPTC1j+MPzuG2YXs60Vods
 7t1OFJ97p564glkWXRb/vnDbkwIojNoPj9JJz2pKKKxawuKUCT4IxcPILCVfUWGPlP7fXFjhSKB
 AlVaoNjIOAAslT6fI6g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA0MyBTYWx0ZWRfX1KvfzfRexnXO
 w3+MjJADKKEN61m/B/nvN06EjJ9u/TXa2IgDJQXKXlU9kIx73MuoAB/4NSHXaTCPAHZIB3OGDmE
 aWKHOWai1YGrPW48BNQLcglInh31j8Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 phishscore=0 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180043
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 17/8/26 21:00, Matt Turner wrote:
> Every indirect branch that cannot use goto_tb ends in
> tcg_gen_lookup_and_goto_ptr(), which calls helper_lookup_tb_ptr(). For an
> emulated compiler that is 8.4 billion helper calls in a single translation
> unit: 24.6% of all TB exits take this path, because jsr/ret/jmp have a
> register destination and because goto_tb is restricted to same-page
> targets.
> 
> The helper itself is already tight, but each call pays for a call frame,
> the can_do_io store, the get_tb_cpu_state() indirect call through
> TCGCPUOps, curr_cflags(), and a breakpoint check, before it gets to the
> jump cache probe that almost always hits (95.8% for this workload).
> 
> Emit the probe inline instead. The destination PC is already in a TCG
> temp, and the flags and cflags the destination must match are constants at
> translation time, so the fast path is a hash, three guarded loads and a
> goto_ptr. Only a miss calls the helper, which still owns filling the cache.
> 
> Two details matter for the generated code. The flags and cflags guards are
> folded into a single aligned 64-bit load and compare, since the fields are
> adjacent. And each path emits its own goto_ptr rather than branching to a
> shared one: a temp live across the label is spilled and reloaded on every
> dispatch, which cost 6.3% on its own.
> 
> Measured with qemu-alpha running an emulated alpha gcc 16.2.0 compiling
> the SQLite 3.45.1 amalgamation (255k lines, -O2) on an x86-64 host, LTO
> build, on top of the preceding three patches:
> 
>      before: 1,402,816,253,499 instructions
>      after:    890,713,633,237 instructions   -36.51%
> 
>      before: 115.75s wall clock
>      after:   84.44s wall clock               -27.05%
> 
> The gap between the two is the point at which this stops being a
> straight-line win: the helper call was highly predictable work that the
> host pipelined well, so removing it retires far fewer instructions than it
> saves time. IPC falls from 2.48 to 2.15 across this patch for that reason.
> 
> Despite emitting more code, this also reduces instruction cache pressure,
> because a dispatch no longer jumps into qemu's .text and evicts translated
> code:
> 
>      before: 11,476,318,964 L1-icache-load-misses
>      after:   6,990,186,701 L1-icache-load-misses   -39.1%
> 
> The mechanism is visible directly in a profile: helper_lookup_tb_ptr()
> falls from 30.97% of samples to 0.42%, and qemu's own .text falls from
> 38.9% to 5.4%, with the balance moving into generated code.
> 
> Combined with the three preceding patches, against an unmodified LTO
> build, 1,647,901,588,726 instructions fall to 890,713,633,237, or -45.95%.
> The emulated compiler produces byte-identical output throughout.
> 
> Open issues, hence RFC:
> 
> - The flags/cflags guards use the *current* TB's values as constants. That
>    assumes the CPU flags feeding get_tb_cpu_state() cannot change within a
>    TB, and that curr_cflags() cannot change under a running TB (gdb
>    attaching to enable single-step would). Both need to be established or
>    the values need to be loaded at runtime.
> - tcg/tcg-op.c has no business including accel/tcg/tb-jmp-cache.h or
>    knowing the CPUJumpCache layout. The probe likely belongs in accel/tcg
>    with a small emit helper exported from tcg/.
> - The jump cache entry is read without qatomic_read(); entries are
>    invalidated concurrently by setting tb to NULL.
> - Only wired up for alpha so far, and only for 64-bit guest PCs.
> 
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>   include/tcg/tcg-op-common.h |  2 +
>   target/alpha/translate.c    |  6 ++-
>   tcg/tcg-op.c                | 77 +++++++++++++++++++++++++++++++++++++
>   3 files changed, 83 insertions(+), 2 deletions(-)
> 
> diff --git ./include/tcg/tcg-op-common.h ./include/tcg/tcg-op-common.h
> index 1fe342db0d..52cd0d3eab 100644
> --- ./include/tcg/tcg-op-common.h
> +++ ./include/tcg/tcg-op-common.h
> @@ -84,6 +84,8 @@ void tcg_gen_goto_tb(unsigned idx);
>    * this op is equivalent to calling tcg_gen_exit_tb() with 0 as the argument.
>    */
>   void tcg_gen_lookup_and_goto_ptr(void);
> +void tcg_gen_lookup_and_goto_ptr_inline(TCGv_i64 pc, uint32_t flags,
> +                                        uint32_t cflags);

> +/*
> + * As tcg_gen_lookup_and_goto_ptr(), but probe the TB jump cache inline
> + * instead of calling helper_lookup_tb_ptr() unconditionally.  @pc must
> + * hold the destination guest PC; @flags and @cflags are the values the
> + * destination TB must have been translated with.

Without looking at the body, this reads as these method arguments
better fit:

   void tcg_gen_lookup_and_goto_ptr_inline(TCGv_i64 pc,
                                           const TranslationBlock *tb);

> + */
> +void tcg_gen_lookup_and_goto_ptr_inline(TCGv_i64 pc, uint32_t flags,
> +                                        uint32_t cflags)



