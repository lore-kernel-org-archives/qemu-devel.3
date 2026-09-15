Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57663C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 00:53:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6HPq-0001FV-1E; Mon, 14 Sep 2026 20:52:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6HPg-0001Em-1m
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:52:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6HPe-0004ii-DX
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:52:43 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EN00fE688506
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 00:52:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 25l4p3vynp6bYXH8Ev8z+MeUqxS7nc21tKTSuoelBCw=; b=Jdykk+JY87KPJxwp
 tWguNTVACBA48EhzqMMosvt2rZGuloMRoJg9tCzmkdNLuswGiUhVjd9LD25kCK5F
 lWercHOZZJjxT5ypUiVJti64kJKwdUtAckafQXJ5cxHBXYpSAS5RYljc+ThXoFQS
 YTnh8LhRVoTBlnTiAisSryvZPxfKAqLU5Mzc5WzWS3DX8qWQMyt5rrL3VucSvkYB
 TfJc5FmMBF9MdoPTWgi5AxzMX94v3NWtfnX5LhC/SCZzfHCbzCAXmmbz68HXk/WO
 DTfGGS3xS0aU/HbtN4Jm5ClD2CDmXtUVXirccDpIoMX0DeF02IZ5FF7+I+Rsnu1V
 wj/DZg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpergb7jk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 00:52:40 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-90e7de22fddso88535606d6.3
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 17:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789433560; x=1790038360; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=25l4p3vynp6bYXH8Ev8z+MeUqxS7nc21tKTSuoelBCw=;
 b=R5/sFJsSvgvWVgaCNBaj1b92l400nwrzemCG4QPo9sN/7K02ZBZuSBTfrsoB64AVcT
 K9RmblPgiQAfAzYLI9+dLZ8oK3udpoeAMDQMaVaNkI33zBXDYlL0fOUIr/Am19HgI5n8
 YsgRa4gwke1ePFIYfUtWR55ihZnf6AopVjVxioVpfoKnd69Z0JQX9ge7tytzSugzKYg2
 CFWws16ESXjLbl/oDAYs6DpeunL5FaszBX0wUzUumVxxDwOS4Zfp3UjQACjqGvEb49Lq
 fhPRo+tei2gSNEHN7vDViDCFKiDc3QZ3XR6uBuUBs9+5gdy/h2Qk2urfWeVX5kraWVe8
 9Kuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789433560; x=1790038360;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=25l4p3vynp6bYXH8Ev8z+MeUqxS7nc21tKTSuoelBCw=;
 b=1+cPMGYbd5hY5me5A+gCqf64xBjyYofHuQZ+ECwxvHhANoFnD5jFyJMVvgx4YoH1/b
 MUmspfhMoCQca/MlNcd4JEDcHp4va5Bq99wXeMZV4mA2WGKDksxh5jEQeBxSP05nQWkW
 pte85+Belig79QkT4n0IhjPZnWKOTS2Y2/9T/MOBtEeJupyTzol0l6nueEcpXEtGnr+m
 aZKo/kzKE37FGdM7qGYEXBcGNWVxGJRjUeZ78MMfFfzeuIvTFLLy7cz//dEf9uPRfGgA
 O4w9t3PvsAHGQtzVDNIHR7IqgVh4sGj1f/hAESnzwRZtytb7JUHwTa7l2T7JrW1v0EbV
 10oQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwSlEdXq0oX0g5hAW8D3zdEPzziYgJkLjMoaXC0EVit88g9IwXxTBFxAB65o+rO2tiq3uQBXVEXtu+x@nongnu.org
X-Gm-Message-State: AFuF++m4QQc/5gLV3vkO3bsEGg/kX8dOeRT/W9m5VXqwcBCwrlVrqLj5
 3nSoZyrKKaJt+8XS1gxULD4UaknpUYy7TRrHQ5CclTIQH6PCVA+Y2hWHc5IGrWRr/ND5+PlfUHi
 Alsc6Ja+3BOsW/q0+Ww7Y/irNB7084yi/KTQ8SJpAzicu5yFLWNp8IagK4A==
X-Gm-Gg: AYBFou0BxAeR7NZ2z5KWgVRKNw20EKYQZWKJFePzZyzsK3x7cSlokgcCmlTigbDT8Xc
 +FNU+iB2Hne/HoydfC6uc2sSa7XzgbR0KLG69mBjYJyQQ7Z27khvZ0o7Vn+ZDuAaSyp9LGf+33a
 mx+RRdWkr9w+5PqkFHXbywtj4jevnTBERSEnvbtmK4xdmd8fjBhPXtDx9oy/5/7IpCv2DL1mGzi
 G0ulZ8EZqGMODj2JcnAt3Vvs3XvPvRzIdxbJMflAJdkrCUFntzaupdP0s8N8uDiVpmii356ZfyU
 stZj5HK/L6J9qml+HVFJemtQgtbfkhQ8KNMFmZG4HaF6toA9Rm7a15t3/LvEJL4pNRkW8trYCJ5
 564A11JUyUpzCXg8OR9oShFTxnQbwmZkb7BBsQvh0zlSSSC63jyoDAiiSMuMw
X-Received: by 2002:ad4:5f4a:0:b0:910:3453:7d8f with SMTP id
 6a1803df08f44-9122e697383mr85184506d6.36.1789433559832; 
 Mon, 14 Sep 2026 17:52:39 -0700 (PDT)
X-Received: by 2002:ad4:5f4a:0:b0:910:3453:7d8f with SMTP id
 6a1803df08f44-9122e697383mr85182436d6.36.1789433557460; 
 Mon, 14 Sep 2026 17:52:37 -0700 (PDT)
Received: from [10.248.104.162] (16.sub-174-226-168.myvzw.com.
 [174.226.168.16]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9120f4d35a9sm108610576d6.41.2026.09.14.17.52.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 17:52:36 -0700 (PDT)
Message-ID: <ccf1762b-73c7-4860-89c7-f0df42306e61@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 19:52:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/10] Hexagon (target/hexagon) Check for sreg
 multiwrite in analyze_packet
To: Taylor Simpson <ltaylorsimpson@gmail.com>, qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com, sid.manning@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng
References: <20260914215037.157879-1-ltaylorsimpson@gmail.com>
 <20260914215037.157879-10-ltaylorsimpson@gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20260914215037.157879-10-ltaylorsimpson@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=QK/91QLL c=1 sm=1 tr=0 ts=6aa896d8 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=HnZmebILR7CVcA10YZfY7g==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=Z8rAi0h3HmB41kMz0-gA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: 8Glw2XrEnu2LlWwk56vSpdeAoP5kRX_B
X-Proofpoint-ORIG-GUID: 8Glw2XrEnu2LlWwk56vSpdeAoP5kRX_B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDAwOCBTYWx0ZWRfXwi8Cn+JCxvOX
 uzNirPtibKuRyXqJTQi8shCXcZAr4EEz9iStccZOvdYTg56Wk1o10XDEfipzUPcl39hS4hQlqeb
 AqrSmu7oW7Y93wkwnnDHWOnsNTShVsm50WJKXaYRzdyysO+Pj0z01RWX01dKqxJ31HlUkfBwwFZ
 vqzu3EbyJDshYtBkCGB9r0L6B2P7HO5enEJ3rlroB0jzx7UbD9tkvPDKmxCu29iEJ+P5CESVYgT
 Up8UDJYIC4kqlSdyjxUcUqyGGK1paX0kZb+LoypiRba4QWRNmT7mLS3qGAy+/IG/afcGja6Ed6Z
 ONRmPXSuupz+b1n9hXlJOBCOs5w1L+5ugEeE5VPkIBL+6soUAGsSb2jXm5Gm3uNRogrI6TygPKz
 8wt2OG3rNAaISkf5o+c40g6fKwtSMdtcyK+yXGecwJ0Fh0kher4WCDo7MrN6yNk0RXUImthgVH+
 kyO0vt6+socBy1MeK8w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDAwOCBTYWx0ZWRfX0FJBz85AM1qh
 r5JYTeQf1jwlNYRapQAMwCfBY7Fa04FOi34rSHAwh4FX5VvGBusn70mkxjk2PXyAlXJRLrUPMQL
 hwcPxGQrZSrtEkNeOpFLWEtQ7HYtnIo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_05,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 adultscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150008
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
> Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> ---

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>

>   target/hexagon/translate.h | 11 +++++++++--
>   target/hexagon/translate.c |  6 ++++++
>   2 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
> index eb0d10d686..b90f7fff1c 100644
> --- a/target/hexagon/translate.h
> +++ b/target/hexagon/translate.h
> @@ -51,6 +51,8 @@ typedef struct DisasContext {
>       DECLARE_BITMAP(gregs_multi_write, NUM_GREGS);
>       int sreg_log[SREG_WRITES_MAX];
>       int sreg_log_idx;
> +    DECLARE_BITMAP(sregs_written, NUM_SREGS);
> +    DECLARE_BITMAP(sregs_multi_write, NUM_SREGS);
>       TCGv_i32 t_sreg_new_value[HEX_SREG_GLB_START];
>       TCGv_i32 greg_new_value[NUM_GREGS];
>   #endif
> @@ -125,8 +127,13 @@ static inline void ctx_log_greg_write_pair(DisasContext *ctx, int rnum)
>   
>   static inline void ctx_log_sreg_write(DisasContext *ctx, int rnum)
>   {
> -    ctx->sreg_log[ctx->sreg_log_idx] = rnum;
> -    ctx->sreg_log_idx++;
> +    if (!test_bit(rnum, ctx->sregs_written)) {
> +        set_bit(rnum, ctx->sregs_written);
> +        ctx->sreg_log[ctx->sreg_log_idx] = rnum;
> +        ctx->sreg_log_idx++;
> +    } else {
> +        set_bit(rnum, ctx->sregs_multi_write);
> +    }
>   }
>   
>   static inline void ctx_log_sreg_write_pair(DisasContext *ctx, int rnum)
> diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
> index 19585a108c..a35c6c6835 100644
> --- a/target/hexagon/translate.c
> +++ b/target/hexagon/translate.c
> @@ -578,6 +578,8 @@ static void clear_pkt_ctx(DisasContext *ctx)
>       bitmap_zero(ctx->gregs_written, NUM_GREGS);
>       bitmap_zero(ctx->gregs_multi_write, NUM_GREGS);
>       ctx->sreg_log_idx = 0;
> +    bitmap_zero(ctx->sregs_written, NUM_SREGS);
> +    bitmap_zero(ctx->sregs_multi_write, NUM_SREGS);
>   #endif
>       bitmap_zero(ctx->gpr_multi_write, TOTAL_PER_THREAD_REGS);
>       bitmap_zero(ctx->gpr_uncond, TOTAL_PER_THREAD_REGS);
> @@ -635,6 +637,10 @@ static bool pkt_has_write_conflict(DisasContext *ctx)
>       if (!bitmap_empty(ctx->gregs_multi_write, NUM_GREGS)) {
>           return true;
>       }
> +
> +    if (!bitmap_empty(ctx->sregs_multi_write, NUM_SREGS)) {
> +        return true;
> +    }
>   #endif
>   
>       return false;

