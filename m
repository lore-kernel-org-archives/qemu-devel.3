Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9931C88E72
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 00:50:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6HN3-0006Sm-HG; Mon, 14 Sep 2026 20:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6HMw-0006FM-TH
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:49:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6HMu-0004Jc-LB
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:49:54 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EN02Rj1440513
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 00:49:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /nCue9h3Zgiy7S8auA8nybq7jHAZHZm00h26jImXccY=; b=Vy5qMxVEpiUOhZE9
 xzcvW4fwiwzpNNjTcErMZPIXlQAInVe0oFw8N72JKEaLaQCkFcc5nCb61haczd7T
 s0VZ4I/WbF3KgEkZRCrbRUunqPIKZlcdjime2if2s9GU+L4oWvm21yvMgSWK6OCQ
 SL8DaXRviDMMvCQCVguXhsl/4ezZ4A67VVsOCpS+nMOLcEDLlF9/ku9LUzKAgHsn
 gGDUVXqBd5zl7vYrDHNc7qhRNtgLmOMpMqrPfArRtOn6aCHFjcPkb4I14hBAnVq8
 1rYG/jyVt0SuQEorSYi2gnIoImtbt/T68Nnkqa6lQPYZtkwRJ28ngvSVVwXCayXB
 Hayq5Q==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpeuqb7t6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 00:49:51 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-90e8dd8be81so51125836d6.0
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 17:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789433390; x=1790038190; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/nCue9h3Zgiy7S8auA8nybq7jHAZHZm00h26jImXccY=;
 b=W0kqVGBff7efqaFV/C0LkTH6xvmewiYJGYIGpRp58ZcWZ1DIymhlRpeyN8pe26E9hT
 i7sjDTi8L6/hmkEyTkCRfXdojJgtvfYyNnnffWK8Nz/sugoSG1Mfpf2Vdh+pUCuE0CV2
 okgF/udQs8RyXsA/6l63WVZpUVzh0v3wFTROYhlBS6V1lqhJV0GEkFkWSLQ0R3m442yT
 ShARIMrqeiu9OaweqNVswCfTydaF+PnEcYyiSRuSRFzWFEPwjkNDUZIgpWi0lgS0wIhk
 kzntV4bN4GzxqHNwAK+mHNHiqesia7ncWmFgogU7AISYVaHN/yXlKK+PHN2LY+ujoRG/
 TZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789433390; x=1790038190;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/nCue9h3Zgiy7S8auA8nybq7jHAZHZm00h26jImXccY=;
 b=U8Gm8zI6PQezD7zNZhItTOZRh9zVEdz+hPnzhujSXAd1/5E4Zgud54ba+qOHuI+Wcv
 iF5lMvVa4BRKUGTTkix5CeGKHdUmMBQqfZE1m+d4NrLYdv3a97scpR0CegDD9HdiVnwL
 zmY2gp9ugvT8wvgoEuFMdeR0x6z3HGl5aNXK0GcOFiACTPlbtQiVac7WI9kkTIdP1MlS
 Jo2tgez1L4zUpcj8nAk0qT0VC2DdNwTiH3kBcfFS8eytXvHM8XvnqhBot5yQf7COJIcb
 GFBN2YCARkZiQYhXkhsvgp3CN0BFyl95v6XZSjJqEa7MSZ+Zvylh8JLR0F8+wqkQZdtz
 n/VA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz34sM87QkHtSJSzr8pNs1TLWw5/R8OUoG4PERoJuuRRohblQJFjgJxJaX2F4qfEeqBkJabiTwCDsqc@nongnu.org
X-Gm-Message-State: AFuF++luFWwYZK2vdVCWIqoTU7bOT9wXctrCjzHzprXurTShxaw++oB5
 5rUzH3Ko9G3Zc4PJpRd9PEM3ZUCLUlf+H15tb4NFSPTstcOGXCaipzmGZdijkX23TufAEl2sfS8
 MZcnLK1ATXjkOy34QJU3OxFvBcyrbgBtFgNfNy+1y4c2FUwvEBALYcl8T7g==
X-Gm-Gg: AYBFou1Jro9vhxz0OjrlbhPc7egABqF70aD6uSVawee2N9e7SXoZAJ+Fec6G1dMgJP0
 SmAirrSe/dUqKWe3sskFynCREFowR4YqtG4AwBccwWTkIrWV3enuaP3LQ7ECofx84UtCBcOvNAm
 LMD2q6nUhWbpN2sXHPj1cvbugXve3AbLimWV26vW37I+G7+L+U2n/zODegLWT+yhLCTmQe+hq6P
 lkzTQMWpQw/WOU9EVirkwfnsVwI94ThHqb74RwblJHIzun4eN9MkP+/Gbl11mc20hwtyRtfbWvw
 4ZhfsfxzLh+oNFf93Rwyio5Nm6OJQ/G7GeYV+ds9t0bevOOThWN74K+DLGrvurseF00kQnQ4Dk3
 hcYe5ozZQVo2XTzQSQsFvkQR3BA3gYfmoPxQOqcHN+RrvZXUkJFXjXzUr92cq
X-Received: by 2002:a05:6214:5f0a:b0:90e:8422:d154 with SMTP id
 6a1803df08f44-9122e4f6467mr87910196d6.13.1789433390103; 
 Mon, 14 Sep 2026 17:49:50 -0700 (PDT)
X-Received: by 2002:a05:6214:5f0a:b0:90e:8422:d154 with SMTP id
 6a1803df08f44-9122e4f6467mr87909866d6.13.1789433389593; 
 Mon, 14 Sep 2026 17:49:49 -0700 (PDT)
Received: from [10.248.104.162] (16.sub-174-226-168.myvzw.com.
 [174.226.168.16]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9120f49444bsm108080326d6.29.2026.09.14.17.49.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 17:49:48 -0700 (PDT)
Message-ID: <95c21214-af37-4a9a-b711-c790663b969a@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 19:49:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/10] Hexagon (target/hexagon) Check for GPR
 multiwrite in analyze_packet
To: Taylor Simpson <ltaylorsimpson@gmail.com>, qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com, sid.manning@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng
References: <20260914215037.157879-1-ltaylorsimpson@gmail.com>
 <20260914215037.157879-3-ltaylorsimpson@gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20260914215037.157879-3-ltaylorsimpson@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDAwOCBTYWx0ZWRfX1mf3KWo1QzAz
 9812VCxOBf7rpu/wVm0F5VyJGgH6X8YuvO4xh03m8yv4aBVeItGij8HO/UKShyNfxF/j7rZELRx
 MJrqtDSxlefzvKSQZHN+rGlLKlF+hqC78mSqMrDdy++jjDkohB1KX2GwLS153P9ZLFT97b/lxFy
 wzCbqI97mrYcklPX0Zce231yT6pcTWUDo5Uo+M0lEipRVcAxsMWHW9kkluN6oSGnhT9uJnh6pBn
 DSaI2mxkKg5teLbdfVsN7CnE/8RGg2jvtXNU2PXU00rE6m4pHqGLhqxqvZgczszLSWFDpzZxCoB
 c0OqZi6wPEPTEo8lkMiCnmR7iky2IpXnbsE1b44B5E92SIAO3s2ui051/S00zuGJU0ghKMYskXT
 dwHIrSl8o4MkNTUaun47wnO0PiHDnIXsNFEoZU+442X4hnijCprSR2NsELWC55oQktS8+A3mIP/
 juxHamK4xbQM7FQEWBw==
X-Authority-Analysis: v=2.4 cv=TrFzFzXh c=1 sm=1 tr=0 ts=6aa8962f cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=HnZmebILR7CVcA10YZfY7g==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=7doQLLFEGwBOEaR92BsA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: 4kXQgX4LVRPrhjaQLi_KnTaWc_2lXqqV
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDAwOCBTYWx0ZWRfXztduMInEdqUW
 4uD2iYTCS/7aj23N0Qn9FTQGRz4kVRHgMbreycLDJTNqsP7Y9t3RNd04T239ushvr8XStPyazO1
 sCgHjUBJ6LpUkJZ8Cu/CTuvFKgnCEsQ=
X-Proofpoint-GUID: 4kXQgX4LVRPrhjaQLi_KnTaWc_2lXqqV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_05,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150008
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


On 9/14/2026 4:50 PM, Taylor Simpson wrote:
> For now, assert the new method is a superset of the old method
> We'll remove the old method in a subsequent patch
>
> Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
> Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> ---

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


>   target/hexagon/translate.h |  6 ++++++
>   target/hexagon/translate.c | 23 ++++++++++++++++++++++-
>   2 files changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
> index d8628383f1..964e6ce0b7 100644
> --- a/target/hexagon/translate.h
> +++ b/target/hexagon/translate.h
> @@ -41,6 +41,8 @@ typedef struct DisasContext {
>       DECLARE_BITMAP(regs_written, TOTAL_PER_THREAD_REGS);
>       DECLARE_BITMAP(predicated_regs, TOTAL_PER_THREAD_REGS);
>       bool pkt_ends_tb;
> +    DECLARE_BITMAP(gpr_multi_write, TOTAL_PER_THREAD_REGS);
> +    DECLARE_BITMAP(gpr_uncond, TOTAL_PER_THREAD_REGS);
>       bool implicit_usr_write;
>   #ifndef CONFIG_USER_ONLY
>       int greg_log[GREG_WRITES_MAX];
> @@ -157,9 +159,13 @@ static inline void ctx_log_reg_write(DisasContext *ctx, int rnum,
>               ctx->reg_log[ctx->reg_log_idx] = rnum;
>               ctx->reg_log_idx++;
>               set_bit(rnum, ctx->regs_written);
> +        } else {
> +            set_bit(rnum, ctx->gpr_multi_write);
>           }
>           if (is_predicated) {
>               set_bit(rnum, ctx->predicated_regs);
> +        } else {
> +            set_bit(rnum, ctx->gpr_uncond);
>           }
>       }
>   }
> diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
> index 52dd1f0266..60441dc309 100644
> --- a/target/hexagon/translate.c
> +++ b/target/hexagon/translate.c
> @@ -577,6 +577,8 @@ static void clear_pkt_ctx(DisasContext *ctx)
>       ctx->greg_log_idx = 0;
>       ctx->sreg_log_idx = 0;
>   #endif
> +    bitmap_zero(ctx->gpr_multi_write, TOTAL_PER_THREAD_REGS);
> +    bitmap_zero(ctx->gpr_uncond, TOTAL_PER_THREAD_REGS);
>       ctx->preg_log_idx = 0;
>       bitmap_zero(ctx->pregs_written, NUM_PREGS);
>       ctx->future_vregs_idx = 0;
> @@ -603,6 +605,19 @@ static void clear_pkt_ctx(DisasContext *ctx)
>       }
>   }
>   
> +static bool pkt_has_write_conflict(DisasContext *ctx)
> +{
> +    DECLARE_BITMAP(gpr_conflict, TOTAL_PER_THREAD_REGS);
> +
> +    bitmap_and(gpr_conflict, ctx->gpr_multi_write, ctx->gpr_uncond,
> +               TOTAL_PER_THREAD_REGS);
> +    if (!bitmap_empty(gpr_conflict, TOTAL_PER_THREAD_REGS)) {
> +        return true;
> +    }
> +
> +    return false;
> +}
> +
>   static void analyze_packet(DisasContext *ctx)
>   {
>       ctx->read_after_write = false;
> @@ -1206,7 +1221,13 @@ static void decode_and_translate_packet(CPUHexagonState *env, DisasContext *ctx)
>           clear_pkt_ctx(ctx);
>           analyze_packet(ctx);
>   
> -        if (ctx->pkt.pkt_has_write_conflict) {
> +        /*
> +         * Check that the new method is a superset of the old methond
> +         * Remove in a later patch
> +         */
> +        g_assert(!ctx->pkt.pkt_has_write_conflict ||
> +                 pkt_has_write_conflict(ctx));
> +        if (pkt_has_write_conflict(ctx)) {
>               gen_exception_decode_fail(ctx, words_read,
>                                         HEX_CAUSE_REG_WRITE_CONFLICT);
>               return;

