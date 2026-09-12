Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72864C88E45
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 04:41:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5FYF-0006Me-Dk; Sat, 12 Sep 2026 00:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x5FYC-0006MK-Tl
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 00:41:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x5FYB-0007DQ-3x
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 00:41:16 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68C4dsMG855900
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 04:41:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HBnpvkH5aawJy0s7v051QBPh4G/1pVKM3wsSig4oSZU=; b=HOSWNF6v30rQVfmA
 O92XIr9CMsC7dx4NfEIoOUUycY5/jDN+Ln0Ftk7xcBwBG3BCH5+4hFh2yBqVwLjf
 PQCdcH1XV6+B3S4xMfYgkAYZgfCahDVUPgmKY/r1DzbeJ3HhRjMr8qFOiRrdvUrc
 bV2jxi7AlOjrAmrHp45neGjUAdoidUDVppMIeWFq+2H0qR9FHopUE5jMX+A3u89A
 vCvTF3R04q3IhsHb9g3pL7w1NrTnXPaPGgA6zklCacHFM7KtNZ/CsPGg+oYzgAON
 UH+n32C9H19+RKxsAFazQqewvkSUqupA5p87iqOncIDGq+69Bp7htizSSaZNS74y
 rBnTsg==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmywh002u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 04:41:12 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-836c9f68dcbso26722717b3.0
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 21:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789188072; x=1789792872; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HBnpvkH5aawJy0s7v051QBPh4G/1pVKM3wsSig4oSZU=;
 b=O2wq5F6ABFmNVUMalHNqZJC707vDMbHdkhjdTf2ICQ2j0SH1EnZjJZzRJeOrv+HyLX
 GoYKHy473HxR2Clj5XKFST6Keo/ryESRn4K4UuC9uPkYvH4U87Fmw5l9w+YLe1ubMZxf
 gklz8StXcpttzN+JiCMhEKo0zAD2a14YmWGKki6wgUmKLvXms1P2BdeQcvdvtnkNyF8v
 nd9vGHh1s8Ac9nitYvi/xksgoaI8tMW8DTUmyt6x1smaimEBnfwXQFIeMQxx1TCucmGu
 lIPpb9hGnyntSY6wD+HCkYQBNHyfXfc8Kw0kDSOMjjRgKjV6gQrYw5/SRKJr8Eb/qxQk
 T6wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789188072; x=1789792872;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HBnpvkH5aawJy0s7v051QBPh4G/1pVKM3wsSig4oSZU=;
 b=ijjRdbNAIaKhSdbzEW6I8lPFekdLkKt3CGxe8qT8Cn0iC6uCGTtfgYzBYBY9CnNWwS
 AOUHfS2I69MV+CKxeLFUhmQlOf09iLsCVNYspnpSu8relRRJDn7v1TVxxnDG7bobZStc
 QCS965Xv2n5xMFA91DAZxahqDTv0Qa9yx1aEu4MlMzI11mnw6EFcHoRWxANhxblbHxf5
 Jb9UHOXw76dPCmynSp9bpftG7HD38FfyXPLZm2O4/5nxbZHvLFl04+gqn2piLLEtgqvT
 Pw5KoyBXHcZ1FwjpfCyj0WKS4A1P3uexinncOdCP/jNxPO8CgDPYKbGWXBMoYs9UDe1k
 6a1A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxnGZQg525ETmWTg4+kkWK36NykTdOyAZyJsvl25tkDa1/GC5O+iMqUVV5HtKRDKqssC81If0aHwKJJ@nongnu.org
X-Gm-Message-State: AFuF++k4hJbwMgwmeP1W7iOfxjduO4QeBFVzl5/cUHNvapi5wNtE0aFb
 E0+F49w7FW6ambsL0MKG0rvKlK19e7kcLGoQIbywnVicooUcXW6ipMYFW12Wnuek9Rf+CJFWp/v
 zXeuvEoPPWyIzRUZ2vSzXJ6mNU9+P879kxjMs90wcxWZfKqenZhjEEUM9Ww==
X-Gm-Gg: AYBFou16jmKx9diqrLPmAHIP5odHqU/lwUmHUpbvnm1t8BYOka65QVd0h6yYTCXC/er
 QIpKm//229MoHRCWnAOA40APcChmkR7fjtxz2NG+h7sKMT94/a+H+9AfkaL4g+HSR5N0TQyt8/8
 2lBoMbG9ajbNqGYZlC6YT390/PcIrtJ2Bdp94AQSqZV+bKSikxbxAd+jDBdZ/jKK3o1GGig9FY6
 AlmTpq4WQAX6S34YSeDwBu0aYWFGGvVBBRjDP5Om138jP97AMc9qTVzSEzYSLZ2bFLNs5oz/el1
 nJMlrnkT50sdCkxb2k9yg+igacy9h6Y9dhwzQnXVM0KA4NfDmFMg4sf+z8bpCo90vdhlw3At38R
 1Jj7ac0jO0FfPd11zTL1xayen617mKfz2YwyALK/yHH5CgWhrFnOE+Ir0dPGQ
X-Received: by 2002:a05:690c:39a:b0:882:1d1e:d73a with SMTP id
 00721157ae682-884adc0a1b0mr27225517b3.4.1789188071842; 
 Fri, 11 Sep 2026 21:41:11 -0700 (PDT)
X-Received: by 2002:a05:690c:39a:b0:882:1d1e:d73a with SMTP id
 00721157ae682-884adc0a1b0mr27225507b3.4.1789188071471; 
 Fri, 11 Sep 2026 21:41:11 -0700 (PDT)
Received: from ?IPV6:2600:1700:1d0:c210:bc8f:aa56:8c4:fb36?
 ([2600:1700:1d0:c210:bc8f:aa56:8c4:fb36])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-88486e2ecb6sm18439177b3.21.2026.09.11.21.41.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2026 21:41:09 -0700 (PDT)
Message-ID: <2b1ac378-da03-492c-8886-282ecaa88404@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 23:41:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/10] Hexagon (target/hexagon) Move code out of
 gen_start_packet
To: Taylor Simpson <ltaylorsimpson@gmail.com>, qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com, sid.manning@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng
References: <20260911220825.143115-1-ltaylorsimpson@gmail.com>
 <20260911220825.143115-2-ltaylorsimpson@gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20260911220825.143115-2-ltaylorsimpson@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: UuvjGhmMFgCyIM0p4I0Q2bsSvCFOypQx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEyMDA2MyBTYWx0ZWRfX3wxYbCFNjOVg
 uUjbSvA5jJosyZy+lBK/6THS9qZ63XS2dlQTsn8krn8ggYosf+LDnCuvvE/spUF2gBdJFHy1Z02
 j7tE1QIwyHzzYGPnI1jCnfqT1rg8QIRqEOBe0SksFtxxmWHNOyPUHVz8LsiNm7Tnw8z8ni6cY+s
 9PlumZu/JKXoMU3eguxd1qtrSpRYlrb+y+ICOQuJ9LUtpUgo5H42+qyX6DnSjrpazQxedV2FQbz
 2x3HZYqQOIigPUwGgPp/a0x1vGE3FgSUZqYcadJWXUEPqQLkdPEE77Pn8WXyyzW4zY/vnFUS1fT
 nsUCrwSVDcOgcZBp4C2M9JnOU+3k9l6nfH5v1E7eFvO2rGb2IQ1ihp0XrxY27hz7dbGrAcg5Amn
 DlmalDXCTUFAMsBBdEQghISWyBaLTgnNjcW+UOC5Od2Hxf/LMaHyQEQD5vgc7eyYtOEqsbsP9b7
 GZVxmwsU/pHwROLdowg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEyMDA2MyBTYWx0ZWRfX2ldQQ6NZTR5x
 gMCeIUs43HPGG5mwLnIWTzrUCVaqY+ghafI5ouYrE+/8nW+H0+gL1QOtYaXnws6B7amO9wRopUE
 gr5AzMe4Hmzb5872WIO7e7s15C9SDMQ=
X-Proofpoint-ORIG-GUID: UuvjGhmMFgCyIM0p4I0Q2bsSvCFOypQx
X-Authority-Analysis: v=2.4 cv=PsUG/AM3 c=1 sm=1 tr=0 ts=6aa4d7e8 cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=v7uYKNS43xFFzLW3Mz8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kLokIza1BN8a-hAJ3hfR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-12_02,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609120063
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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


On 9/11/2026 5:08 PM, Taylor Simpson wrote:
> Move clear_pkt_ctx and analyze_packet out of gen_start_packet
> Precursor to adding packet validity checks to analyze_packet
>
> Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> ---

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


Aside: I notice that you are touching "next_PC" here and it occurs to me 
that I have local follow-up patches from your previous suggestion on how 
to remove it.  I'm prioritizing closing functionality gaps over 
translation performance/codegen improvements for the time being, so it's 
somewhat deep in the queue.  I suppose I should bump it up a notch.


>   target/hexagon/translate.c | 45 ++++++++++++++++++++++----------------
>   1 file changed, 26 insertions(+), 19 deletions(-)
>
> diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
> index 5d3d67e5d3..52dd1f0266 100644
> --- a/target/hexagon/translate.c
> +++ b/target/hexagon/translate.c
> @@ -562,28 +562,13 @@ static void mark_implicit_writes(DisasContext *ctx)
>       mark_implicit_pred_writes(ctx);
>   }
>   
> -static void analyze_packet(DisasContext *ctx)
> -{
> -    ctx->read_after_write = false;
> -    ctx->has_hvx_overlap = false;
> -    for (int i = 0; i < ctx->pkt.num_insns; i++) {
> -        Insn *insn = &ctx->pkt.insn[i];
> -        ctx->insn = insn;
> -        if (opcode_analyze[insn->opcode]) {
> -            opcode_analyze[insn->opcode](ctx);
> -        }
> -    }
> -
> -    ctx->need_commit = need_commit(ctx);
> -}
> -
> -static void gen_start_packet(DisasContext *ctx)
> +/* Clear out the disassembly context */
> +static void clear_pkt_ctx(DisasContext *ctx)
>   {
>       Packet *pkt = &ctx->pkt;
>       target_ulong next_PC = ctx->base.pc_next + pkt->encod_pkt_size_in_bytes;
>       int i;
>   
> -    /* Clear out the disassembly context */
>       ctx->next_PC = next_PC;
>       ctx->reg_log_idx = 0;
>       bitmap_zero(ctx->regs_written, TOTAL_PER_THREAD_REGS);
> @@ -616,8 +601,26 @@ static void gen_start_packet(DisasContext *ctx)
>       for (i = 0; i < NUM_PREGS; i++) {
>           ctx->new_pred_value[i] = NULL;
>       }
> +}
>   
> -    analyze_packet(ctx);
> +static void analyze_packet(DisasContext *ctx)
> +{
> +    ctx->read_after_write = false;
> +    ctx->has_hvx_overlap = false;
> +    for (int i = 0; i < ctx->pkt.num_insns; i++) {
> +        Insn *insn = &ctx->pkt.insn[i];
> +        ctx->insn = insn;
> +        if (opcode_analyze[insn->opcode]) {
> +            opcode_analyze[insn->opcode](ctx);
> +        }
> +    }
> +
> +    ctx->need_commit = need_commit(ctx);
> +}
> +
> +static void gen_start_packet(DisasContext *ctx)
> +{
> +    int i;
>   
>       /*
>        * pregs_written is used both in the analyze phase as well as the code
> @@ -659,7 +662,7 @@ static void gen_start_packet(DisasContext *ctx)
>       ctx->pkt_ends_tb = pkt_ends_tb(&ctx->pkt);
>       ctx->need_next_pc = need_next_PC(ctx);
>       if (ctx->need_next_pc) {
> -        tcg_gen_movi_tl(hex_next_PC, next_PC);
> +        tcg_gen_movi_tl(hex_next_PC, ctx->next_PC);
>       }
>   
>       /* Preload the predicated registers into get_result_gpr(ctx, i) */
> @@ -1199,6 +1202,10 @@ static void decode_and_translate_packet(CPUHexagonState *env, DisasContext *ctx)
>       words_read = decode_packet(ctx, nwords, words, &ctx->pkt, false);
>       if (words_read > 0) {
>           ctx->pkt.pc = ctx->base.pc_next;
> +
> +        clear_pkt_ctx(ctx);
> +        analyze_packet(ctx);
> +
>           if (ctx->pkt.pkt_has_write_conflict) {
>               gen_exception_decode_fail(ctx, words_read,
>                                         HEX_CAUSE_REG_WRITE_CONFLICT);

