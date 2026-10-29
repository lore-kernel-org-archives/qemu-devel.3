Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2454606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YJyNsdqy;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XxGLQ4QE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMUKO-0003gx-2T; Thu, 29 Oct 2026 13:54:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xMUK9-0003Yz-Ku
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:54:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xMUK6-0004ns-Ja
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:54:00 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGDSWq594568
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:53:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sxKM1bnFMS1Y1Yh1AMKlscwNT5r22PVIVXZaHwsxQnA=; b=YJyNsdqyxHeIN5sZ
 mp7t/cNsTgpi5kB5aRTaKAfZqL9pkpiC0gHgW2MssrFuTiUZ2+9Ssb32I2u6tX5c
 pNVqKvjEdO28xeypVMYFrcItdGJ+aGIaV2E2pFlFnMXmAKnwXvw8hle5mgMNOBGd
 fprAe7MtlsKRiVLyHSjEehpEPIXS1MjqBoVjNDHYxS2OX2viHixj0VjjX0C84qJe
 Sc27ksZqGLJtbgp4V4lxmNzKIamRsW4bHwtJQltHVeiq7C/aE5rIvQxDY/FDQGrd
 8Sji62yHKMs2DjxP5c7bXX69EOzm3gDkHUtQsW7QNdrzqXEdJd7p8LQUzgq7XBhF
 IUJQmw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkut3kv3k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:53:56 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f1e62510cso578355785a.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 10:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793296436; x=1793901236; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sxKM1bnFMS1Y1Yh1AMKlscwNT5r22PVIVXZaHwsxQnA=;
 b=XxGLQ4QEube+GVQBk7GDPQEh82d1uUU7kIAuvKTViaF55+kn9W9SwDf+L+dfWogNLV
 jO61WGvMRgp7Pj8qFmBucBa0wTogokF13+eErrZ0mtBoqDKtjsbT8mt0477qu46eeOug
 rjA0sIKFR0d6+D0bmHYxE4BX6G3DowsSRiFk4oxI8clGLFJp7gBPKjOZiJ9auPd9fPRz
 2YAuU+yaJb5+ZAJtpUHmulKX1tK+ztOTAre7xCI6DS4vEG1exPCZuGX/GAEysRuYOfq5
 SGHRve7L1LxAsiMeJDLf7JHQIea1sKGKNJanRGag8zM0t+J1mPLFV5Bf4Vc/qra+fW3J
 JUCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793296436; x=1793901236;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sxKM1bnFMS1Y1Yh1AMKlscwNT5r22PVIVXZaHwsxQnA=;
 b=pP5bcmA0cz5lsOSRVerMasaeYO8dGmPLoOJnT9pXuYMPHgWTjEpWOspGOh7l79d/UN
 mS8Wyoluxd5EV6sSW8cHajT/jG4LUQKsOqEf59h3rPoo5rQEh/9vWsfYWeIsACYZMIML
 BaX5y/UUHIF6D5Dem3y4iISPwLrTvBwfZH4CaukC2xQ629kRUozevnhsjYjhzYYr69oU
 4fUEgoHZVmrLwcXHEUf5FkPIZ0c6Ez7m7J4iR3CZTMNmKVVGzON5VlVZZQ7Snlwllu1h
 xZEiNsxvr9i6hqusVGCLXVXKL35XKALiZNP974HGpqtGyrs60JwjBscZjX0bF6mA0BJZ
 9Prw==
X-Forwarded-Encrypted: i=1;
 AKwUvByv2K9Zda/uWjVUYoFW3m+4CMu7WDe8yr1V9ryg9uzZkC8MqBHVfge59t9jStjbNZCoWgeG38INjroD@nongnu.org
X-Gm-Message-State: AFq9FYLmisgBWQX9jZjgIiy6xj+6xzNtViAEOdwCIL8GUy1Fdycnf7Qg
 UgBlWneErNIih4kVZUApFJ06nSmbQ1wXKe6R6uSd6hubNyzkPtcm1C0i3+nq/47oZalj3+ePZvh
 asDdmt+qNd0D5VuyW5qLaXhljF3a13Up0lL3+zIPFVvQkPBuCfIIoYa+JuA==
X-Gm-Gg: AYBFou2XOmRuRsOuhxGesqa7jSFhqvrBv0YOF5d2wDGqNlYlIdow7UeEzBHRSu/weVk
 dJ1saEAGQtXxNe+FixTpmb0Sv6k3+oSURovPMspT7tsV6emZ4ha8EBt6q2bkZQfjaI72fK6KrC5
 VEiwLmhZEHIjHlMLdYtlypFdMgJ3Jw3JkEP9DQG0/TDDWWwxCwnrqUQvVhZni7PX3G7kKCCHDnw
 k0WtFPU4wvXnR9b5JMnBdc8hZq8ppMI5/s7MRAGKnw0IDSUdqddiseC4synbYi3DfXZT7deJ3Q7
 JTGiuCASiy9Qq3fe6+NSeYoJkUCOf7OJPTG9KhODULZfDK2OOuxNKGcN3gWS/siBcjni1VXdzWL
 j5vUnGw7/Q/3kjvB+bgPKzI8qHaOuH8MBe9Z7Eog5aT0W3nxrdSSRobCXtJZLAhi7d/2qgNt88P
 pgOgp+RxWg5A==
X-Received: by 2002:a05:620a:4543:b0:93e:c12c:9b6c with SMTP id
 af79cd13be357-94408d39b42mr996975185a.71.1793296435839; 
 Thu, 29 Oct 2026 10:53:55 -0700 (PDT)
X-Received: by 2002:a05:620a:4543:b0:93e:c12c:9b6c with SMTP id
 af79cd13be357-94408d39b42mr996971685a.71.1793296435236; 
 Thu, 29 Oct 2026 10:53:55 -0700 (PDT)
Received: from [192.168.68.103] ([152.234.122.251])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-944210e47d1sm6044885a.2.2026.10.29.10.53.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 10:53:54 -0700 (PDT)
Message-ID: <d2aeebbc-7582-4b3b-bf38-bbfebedb1a85@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 14:53:52 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target/riscv: Honor Zama16b for AMOCAS accesses
To: GavinQin <qinzhengxiang@foxmail.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com
References: <20261024120211.236223-1-qinzhengxiang@foxmail.com>
 <tencent_B260044F72C6F341E58608255B64FCE0AF08@qq.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <tencent_B260044F72C6F341E58608255B64FCE0AF08@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA3MCBTYWx0ZWRfXxPGBOUKLxIY9
 qyL41ElZwYjOjdAPC1naBSKK3uSRMCr28pW0y7BG1SWR70yMsgGus1zL7fCqrIWwJz6myaybD4p
 S7cQ0bWyOc+bTdwtUQOMkLIsQVt/xm8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA3MCBTYWx0ZWRfX5JlXNNOMmIqK
 tN7YsYNb3iFqyXL+nr9rR+RdgQvZ7C1MLEaHZUbpOJqUUrtEe59mnXWqVVYpKoHUX/pdre27gOq
 Qwu7Q+gRqjfWKfxZ7ND4FfwzPiJX5ct2o/SONbddb8+FqpbF4xYSzbNhk14uu+sj9aayXgR3k3t
 lL15k1N4Lm/lX0QCf5SaqKNDPNIJkkYkLYsZTcIuGQQ1fMt+pREHkYCMNTw+7REqrOY0vGkgbdo
 kuWNUY9EcWFIV31deXO3qbMk20Yvi/0I5e5UB+FXywo+1kJ/4Y3JnR3tRsLmBRi68qVnotu3brR
 XL9kX+3rXeUpu0p7MYD08ZEosQHsdsgJaGYfcgBh+SSKBP4ndpnU22XjdWcGRFhkpKwVcUkvib7
 oZJb3br51bYa+be5sGt+cmT9AZLckmJpm3F0MDWzO3JXSB7wA6xnQBdD8jb7j0OQreGdUd48I5i
 4om8lUBgAJ+CdGr6caw==
X-Proofpoint-ORIG-GUID: kFxXKcYIpdy-TL61sELMd1GiV0p6ZXZe
X-Proofpoint-GUID: kFxXKcYIpdy-TL61sELMd1GiV0p6ZXZe
X-Authority-Analysis: v=2.4 cv=HYSB3SE8 c=1 sm=1 tr=0 ts=6ae38834 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=QOY8BskYDu05dfarAz2gNQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=bDN84i_9AAAA:8 a=EUspDBNiAAAA:8 a=z-gEND9NoGb_JxIAb4QA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=J2PsDwZO0S0EpbpLmD-j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290070
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/24/2026 9:02 AM, GavinQin wrote:
> AMOCAS accesses retain their natural alignment requirement when
> Zama16b is enabled, causing misaligned accesses within a naturally
> aligned 16-byte granule to trap.
> 
> Clear the alignment requirement and request MO_ATOM_WITHIN16 in
> gen_cmpxchg() and in gen_cmpxchg64(), which handles AMOCAS.D using
> register pairs on RV32.
> 
> Preserve the existing alignment requirement when Zama16b is disabled.
> 
> Signed-off-by: GavinQin <qinzhengxiang@foxmail.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/tcg/insn_trans/trans_rvzacas.c.inc | 4 ++++
>   target/riscv/tcg/translate.c                    | 4 ++++
>   2 files changed, 8 insertions(+)
> 
> diff --git a/target/riscv/tcg/insn_trans/trans_rvzacas.c.inc b/target/riscv/tcg/insn_trans/trans_rvzacas.c.inc
> index 79bca1e957..7b87f3e640 100644
> --- a/target/riscv/tcg/insn_trans/trans_rvzacas.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_rvzacas.c.inc
> @@ -77,6 +77,10 @@ static bool gen_cmpxchg64(DisasContext *ctx, arg_atomic *a, MemOp mop)
>       TCGv_i64 src2 = get_gpr_pair(ctx, a->rs2);
>   
>       mop |= ctx->mo_endianness;
> +    if (ctx->cfg_ptr->ext_zama16b) {
> +        mop &= ~MO_AMASK;
> +        mop |= MO_ATOM_WITHIN16;
> +    }
>       decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
>       tcg_gen_atomic_cmpxchg_i64(dest, src1, dest, src2, ctx->mem_idx, mop);
>   
> diff --git a/target/riscv/tcg/translate.c b/target/riscv/tcg/translate.c
> index 70c1088338..3d1bd7371d 100644
> --- a/target/riscv/tcg/translate.c
> +++ b/target/riscv/tcg/translate.c
> @@ -1180,6 +1180,10 @@ static bool gen_cmpxchg(DisasContext *ctx, arg_atomic *a, MemOp mop)
>       TCGv src2 = get_gpr(ctx, a->rs2, EXT_NONE);
>   
>       mop |= ctx->mo_endianness;
> +    if (ctx->cfg_ptr->ext_zama16b && (mop & MO_SIZE) >= MO_16) {
> +        mop &= ~MO_ALIGN;
> +        mop |= MO_ATOM_WITHIN16;
> +    }
>       decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
>       tcg_gen_atomic_cmpxchg_tl(dest, src1, dest, src2, ctx->mem_idx, mop);
>   


