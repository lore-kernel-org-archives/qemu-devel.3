Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15731C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 01:13:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Hiv-0004Wz-3l; Mon, 14 Sep 2026 21:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6Hin-0004WW-LM
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 21:12:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6Hik-0006dB-PL
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 21:12:28 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EN1LZs1277733
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 01:12:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 u33krVk5+FTiPbm5gZpUkG785NjNq01FUsL9zKVcNEk=; b=fv4pvc+icc3MzdDL
 Ha5heYzVxapQ6g697hwDXZgPRHon/XMoNlB5yD8gdrGxovf1/RHYLGTGpngsHlfL
 fB6mTrTLhMUd4npczZX8wsbDDTVdLG8rkaYp/EvP7fY74cAJT9XBaPFyVRKBR52T
 Mcso5XFqU6F/EI6v2RfqfH8MX3wwpnfdKzqe7ajWcqUaFNuFYfSTO4a3QXcI0gUl
 C/7fPda5IYarE7KPXXvpKauwqUIl34A5HzvDCR7fKMXHiDenNHlWBV3GZWmhlHc6
 XVseF/uokwAaA5MG0/sO9Xuv1nMv+XxUNYs+Iu6qR8HGyfMtLJSuIv8v094xCu7T
 L1ai0A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpd1f3rsu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 01:12:24 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-53094ff7090so102721801cf.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 18:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789434743; x=1790039543; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=u33krVk5+FTiPbm5gZpUkG785NjNq01FUsL9zKVcNEk=;
 b=Z1/l1sYFDzW/m+bDaR6XfUBSWoA6uQ8/cL7ngFP6Hfmic5mCEh3KRkqkwLfpgo8Imv
 fyxkxxNfA0XunB1VfWBa15E4z6jjnkuaB9oimgXijwnQSv9Cfw7qXNipJV5CMUUwVy0w
 62abEmtf8FYAMypk/YUlRyqP4tDtHpY5PUjQH+Srcj0LLgN3rRyV6gNybmAnV3zSYFQ2
 86/x1rATenQmE2t2Mz5KFWdTPyfRtzCEs8PBxKndPxK26rcagckccNLVL44yP+oWzwwV
 cjjA2y1aAdkF108vpd2IZ9ARTWDeFadh1eCZ0crCLS3uk06+7dAHWdfbZ4ZenfjUbONu
 bJoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789434743; x=1790039543;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u33krVk5+FTiPbm5gZpUkG785NjNq01FUsL9zKVcNEk=;
 b=A7F5W+t9i4lHWgsM8n47/mPHGwrRvesMhLzF/MZZgIrDf9JY1KWJJu8dEMYybYHHcs
 G0L5GVsfEczmHZtHmj6+Vhycftu34UQHlpDVGyzwlGToROvKs9DK5Xm17WunW0RJ89u2
 TzKYmzaMi3NPoMXNnu3IXgOXS3PEbBe/u9byo2L4hQvFoVzz/nmds7t5dZcSNgW4S5ge
 0wwUyB/qXelvd3V70TbEHU2jnMG9h9XrcFzfrPAt5MT13tTaxL2tO5+wKZMxIH4P8p2E
 pRIM/GGh9BOmxPZrA5ff1UpyL6cQxodCJw/kw9h6R/DCV6CxL06aFJZw1xhFk1JUHDdF
 w5Xg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw8gHKHz98dyPXo6M1Afg5UcxHPPZp9xmHmnb1LFoFFjTzs2Y1ya8xo5aDJTGayy+48NNcbZt5oZCLd@nongnu.org
X-Gm-Message-State: AFuF++kDcUZUP63oeCkIahqPd6rUHyX4jo6d43wexvax4vc9uQrafiQE
 89+Rk4ZxAE8vyRMSL312D6DONWaDIJ7CJMCQYi5ddCqLavjyza2TQNJjYql4K1R8V0GaPqEJoXm
 J0zTpWL+4C43TP0eTIqGYXYnxRJIgQ5Q6gu/JzgCVvZ1D2GJwD5uasnYI8vr6X0UTiw==
X-Gm-Gg: AYBFou2Es39Smi8Ex0RFmcl2C91V5hBA9a/FtFBLc6Ee7WUGUS16c/5q7RfUcA5FmiR
 BFuSRjnu0Li12f5LoljxiI03cXTra3Zjx038j9tgqGU5KjzmFNvkeR+S3vh3ubB8AwlwQigPmsa
 fjAFJflZ/SNPjzqdc1te0C0ZtTq85P2UgQtEy8PnRK3z1VBqxwlbh7jGHFcI0cIIsEJw4viWRMJ
 w3lIQydagXFDSBtLiGkzjQyCi6u/Bq87BzEYtbJoLWUgDx8XUlbu3fWuqb2NBKaGSRg3MF0FNnH
 LRR7hmsSi0ZNarYhDYDqynYZ7jOxzV/ICy1AG1J1L6rH7JbGJab7Wmppe1y3Yds7jMf8dTThOs0
 UFL/Mn7vrONqVy4yJdN5CskQprkdYuOjOaoouE8vH9sMVR6Pxfzii6eMPJrNh
X-Received: by 2002:a05:622a:15d6:b0:52d:f484:eefe with SMTP id
 d75a77b69052e-5310d02f872mr76700821cf.35.1789434743526; 
 Mon, 14 Sep 2026 18:12:23 -0700 (PDT)
X-Received: by 2002:a05:622a:15d6:b0:52d:f484:eefe with SMTP id
 d75a77b69052e-5310d02f872mr76700391cf.35.1789434743150; 
 Mon, 14 Sep 2026 18:12:23 -0700 (PDT)
Received: from [10.248.104.162] (16.sub-174-226-168.myvzw.com.
 [174.226.168.16]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-53116090064sm18665031cf.5.2026.09.14.18.12.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 18:12:21 -0700 (PDT)
Message-ID: <c69c665c-7cd9-4c96-90ff-8d6ac91a7b0a@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 20:12:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/10] Hexagon (target/hexagon) Check for greg
 multiwrite in analyze_packet
To: Taylor Simpson <ltaylorsimpson@gmail.com>, qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com, sid.manning@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng
References: <20260914215037.157879-1-ltaylorsimpson@gmail.com>
 <20260914215037.157879-9-ltaylorsimpson@gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20260914215037.157879-9-ltaylorsimpson@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: OBX61WYaylbE4s15jdW_WZ4wEH1N1hFy
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDAxMyBTYWx0ZWRfX5pOg6IOg9ehU
 dVMFujqMqw7E8VmH++D7PIDbfre47oDvgRaUBNvIFhFOksQ21CHgk+hHYl05q37vf/EU4KS4FY+
 2DasgaFaYgZxq+um5dyQvYIskdM7dCg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDAxMyBTYWx0ZWRfXz7WTEoQPwV98
 96fyj1PqqtPbNnDGUHvnXDY7/QRNi254yTTtuWURG9+aJ6h2sjqeTMA7iJkQNAJii5bPbwpMOEI
 46PLabONu0KW8JQtLI9lw6Wn3Isejh3sNy9PA4i/BifjoduFRDmR5e9+3kstvBLl9xFqAOuMjGa
 gbcC438nYxIfnjZJUyTTRpUFw/HcMbtnoD2EOOjWRtq3dKRKsHsgZlRnRD7Ku45cl5QhxPQ0Iaa
 kIdSKaPj7HFKGoXxl1aZjdOvvPBGk+tf8k8ZM0okDLpQOZmwd7PwxtMFVxaLGGab0GNKvvZ8x5O
 cWtc2y0lrEjGF4C9UavZarv2d+4Pmf68+jID0lTkCG8L63TTbDMuqG3w9Whr1L6B9DdhvAGFmE7
 JDy+km/z+WgK5JhSnoTghdy8Vv4k/eWao2M/jPRHiVBzBGExFeCG9mqUE6Cgz8VT/54ypDtWwfB
 Q4vBgyTk00MxsgIHsJQ==
X-Authority-Analysis: v=2.4 cv=XKel2ghE c=1 sm=1 tr=0 ts=6aa89b78 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=HnZmebILR7CVcA10YZfY7g==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=J2ybx9f5ocyxwA71rbMA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: OBX61WYaylbE4s15jdW_WZ4wEH1N1hFy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_05,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150013
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
>   target/hexagon/translate.c |  8 ++++++++
>   2 files changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
> index b6cdf51c20..eb0d10d686 100644
> --- a/target/hexagon/translate.h
> +++ b/target/hexagon/translate.h
> @@ -47,6 +47,8 @@ typedef struct DisasContext {
>   #ifndef CONFIG_USER_ONLY
>       int greg_log[GREG_WRITES_MAX];
>       int greg_log_idx;
> +    DECLARE_BITMAP(gregs_written, NUM_GREGS);
> +    DECLARE_BITMAP(gregs_multi_write, NUM_GREGS);
>       int sreg_log[SREG_WRITES_MAX];
>       int sreg_log_idx;
>       TCGv_i32 t_sreg_new_value[HEX_SREG_GLB_START];
> @@ -105,8 +107,13 @@ static inline void ctx_log_greg_write(DisasContext *ctx, int rnum)
>       if (rnum > HEX_GREG_G3) {
>           return;
>       }
> -    ctx->greg_log[ctx->greg_log_idx] = rnum;
> -    ctx->greg_log_idx++;
> +    if (!test_bit(rnum, ctx->gregs_written)) {
> +        set_bit(rnum, ctx->gregs_written);
> +        ctx->greg_log[ctx->greg_log_idx] = rnum;
> +        ctx->greg_log_idx++;
> +    } else {
> +        set_bit(rnum, ctx->gregs_multi_write);
> +    }
>   }
>   
>   static inline void ctx_log_greg_write_pair(DisasContext *ctx, int rnum)
> diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
> index 815eecb60a..19585a108c 100644
> --- a/target/hexagon/translate.c
> +++ b/target/hexagon/translate.c
> @@ -575,6 +575,8 @@ static void clear_pkt_ctx(DisasContext *ctx)
>       bitmap_zero(ctx->predicated_regs, TOTAL_PER_THREAD_REGS);
>   #ifndef CONFIG_USER_ONLY
>       ctx->greg_log_idx = 0;
> +    bitmap_zero(ctx->gregs_written, NUM_GREGS);
> +    bitmap_zero(ctx->gregs_multi_write, NUM_GREGS);
>       ctx->sreg_log_idx = 0;
>   #endif
>       bitmap_zero(ctx->gpr_multi_write, TOTAL_PER_THREAD_REGS);
> @@ -629,6 +631,12 @@ static bool pkt_has_write_conflict(DisasContext *ctx)
>           return true;
>       }
>   
> +#ifndef CONFIG_USER_ONLY
> +    if (!bitmap_empty(ctx->gregs_multi_write, NUM_GREGS)) {
> +        return true;
> +    }
> +#endif
> +
>       return false;
>   }
>   

