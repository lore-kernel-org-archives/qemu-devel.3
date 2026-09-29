Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87BF4CA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 12:47:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBXEr-0005Pt-K3; Tue, 29 Sep 2026 08:47:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBXEl-0005Pf-Ky
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:47:11 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBXEj-0007Dw-Tr
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:47:11 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TCEdvh1392355
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:47:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +BWv7JgGgDlQHf/530RAw0J57RA+dKNVYNqW864z4uI=; b=So+1vlu/OqSLxPav
 ewE+0ChPIqDKKht38vPhs9VnmOg7sGhFF4MrKgdVvakinZKzecZkdQ62VyztJq2u
 HQacd5I+62G1WAKVozwKjqYH+MT4nKZmDIZqupb22SyLG9BZ5/8+d6mTuq+Wy0dI
 oj491/jYBu7HgDg80PRyBKHSMRYJ7Az+zysfr3n3+i74szx4hfqZtaq8QRfvfhJZ
 yXZaJiEUbuLh+CjW91mtnqxIXP7aePQmzzUn9KRFZZgU6eDQVp4IJA7ED5w9XeoK
 6Ox2jXvWSYiPMMI+6/J4gJ92Tu+5Z0h+UQRQ71pjf0vV+8dLl16mk7iS7aCWNU7f
 2jY1ww==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyw03m2e5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:47:06 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-9829a8b46a7so296484241.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 05:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790686025; x=1791290825; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+BWv7JgGgDlQHf/530RAw0J57RA+dKNVYNqW864z4uI=;
 b=jnFc05t866dkAJsQ78JyOdotXDDUmFHJnH/RONuhBtbTg9X/lANojk8UEIQ8cV+hol
 kUIuuD5Mpuu0IwK1AJ8CD9XyDb412MFaQOQtaenPxVbGw9vC/l/mN/NY5Uz4rCQTubSA
 umsv6P1G6tLnTTpcjEsvfsIaFtWJBJqy45+U2bgOOoH4Za5U6nS2QXvkP+gj2w04BZV3
 vpxgcAf4FPWxFFLLlXrGy/cvuRR38/O+KuslhAJc0g6C2X1KflorOKiw4lJ9DNxHnCuC
 ngfo2i9GL5R10kEu7zLWC4LRBUKavdZB9Txxjgwb2yB+cw6hXNzPgztI3JZy+EZHxLvo
 2t2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790686025; x=1791290825;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+BWv7JgGgDlQHf/530RAw0J57RA+dKNVYNqW864z4uI=;
 b=PshfEYE+u+7CxKelQpfY06Y3nkIyvH1DjcIiOzU+ImHCVNM1fmwA0gIXJhXa/PE1Z9
 YHrYHIduehzqyhbV19hd4ehy+V4R20FkNE/9S5wmdqfwkfVhB8R+sY5TAufFeg+hWRY1
 jZjJ1jyU604jC0vLXHQbqZOcHWoR6GgHMFl9QxhOtxT6LJi9HwsOQRbk5NTdXIMY6zu2
 QodJzwmfx0lTPR6mnnNPHsh7ewXeCf6SDO8PuHAh8Mc2DuDpxwHY9sDzbeFwMXvxWzhA
 cyiL3xBd5RPJQXrvREBMTeRcZVz4NwUw/BYS+l962qn7vbkHi4MM8tvrpEk9QNII1EkC
 EXNg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxYN2pmcKcKA7z2Idj7tC1/xCdYJLNmnBfiDU7yH+Mm3Hwqn6/fTqgzDdGyWiULytAJF3jaItKobFcP@nongnu.org
X-Gm-Message-State: AFq9FYLEDUr4QK6qAqnBhzyWitPMiKffhRt+Pz2XJRourqk6fpb/bRI1
 M2Y8ulP82EX+kmb7tCEMkbxooLqIqQxCFPxXnj0k1ZfIMw1cLmjM/w9Dy7AB/em5hpKLkKJ/v4/
 JAMnBt8dozYIE4k/ot3CcD+wZvLm1mkRybblmruDqcGDc570S5MakJkJVpA==
X-Gm-Gg: AYBFou2MQwMmSIKVJ4eGXrhHp1CZsxuXWrqsTQri5eeWKXyOrgLHELPwjp2Zh+AqWyf
 VMzjvGAclaH6O0fvu62GXwRri6frGu/GV1J1RRlA2dLYojgCy2MvjJWzJRe3511MoBJiAQVlnDY
 3nrPLRsBJKzmhEb10TGfrVTrWIFq3PfSz23vcGWgLsC1SLUSx8S3kpO8zF6ymgxM49ssFKG3N2W
 0KNRUxpQ5HdbR/a+J15wf1yNLpLT5JO2/zBK9app3fkLa5I8qmbzHhBHPDVc9UiwC8jPYRNisK7
 tqs/DZ54klglr6EAh6iJi1BKyeRNcEnCH6Wa2c1Uo9T/Bnxyu8DYpcP+Mft1oAbj0in1XgvobIl
 LCLyfQ4ktcShsMhPJi7cHekhkLkl77/g+nw==
X-Received: by 2002:a05:6102:524c:b0:7a8:6ffc:1c25 with SMTP id
 ada2fe7eead31-7af1e9f308fmr4107825137.18.1790686025411; 
 Tue, 29 Sep 2026 05:47:05 -0700 (PDT)
X-Received: by 2002:a05:6102:524c:b0:7a8:6ffc:1c25 with SMTP id
 ada2fe7eead31-7af1e9f308fmr4107814137.18.1790686024892; 
 Tue, 29 Sep 2026 05:47:04 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a013c6f295sm1182175e9.0.2026.09.29.05.47.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 05:47:03 -0700 (PDT)
Message-ID: <3e5512b6-98be-4196-8088-f321e21287d7@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 14:47:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 044/101] tcg: Generic expansion of tcg_gen_brcondi_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-45-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-45-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA1MCBTYWx0ZWRfX04+npyMJdp/A
 9bB9Noy/EWJkh4EsjGUFIMuuq7gBlaCi3l9VWDlsXfmsrl/lCbaY5eJ8fjyyTg6M/DeA++F8hoU
 kpsMy3ZF2cbKN8qn3aBGZx/FDpKOZb0=
X-Authority-Analysis: v=2.4 cv=SIbXx+vH c=1 sm=1 tr=0 ts=6abbb34a cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=eoSmNitb6G_O6NDibNAA:9 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA1MCBTYWx0ZWRfXyWkANRQQooZz
 TmQeb0/ctzHtJe6UNwbGstSUWPBr6unzOOPD2m/w2KOucvgSDswSI5exN2o1DboYl0beNTm7k0S
 mk2oZohabf3AQZ0jTPI1T8EN5yB3ApctasQASxIG3v+7tr/uNwrhEmsqRmRNpWl2QLwEL8tMH3f
 dkyXjJigX5hXOAptNGGbDlHwdcjAF0JevGXVc9pez5kmpFJRM4fm9P0ZJS/rJmLEKBSpGXhsLPq
 BJo2OupJTn2WxJZqt/hLrkAIXydszUWu8F0nEGMIopP7tHWQ2yV7DNI4TpI+Tl43h+BLJ1w0ws8
 BNtorJbxsz6fck0FPfiYdc9DYAaPMfZbvAaktptBSOxaLZ9plEejXpZWGP1TNhEhEXzOKD7xYqE
 01a/SJd8X1Av5d2qC4ouIWyvcSCUNpM0+1dpmBpat8VTfkv694uGW1kRMx7hE0JP+fY5Q4lBQ97
 5BUwFRsK6+wdcSi7Q1Q==
X-Proofpoint-GUID: ADqUjtE6G3UwrB4Grq4GLmYsCjTmT2rM
X-Proofpoint-ORIG-GUID: ADqUjtE6G3UwrB4Grq4GLmYsCjTmT2rM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290050
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

On 27/9/26 10:59, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h  |  2 --
>   include/tcg/tcg-op-def.h.inc |  1 +
>   tcg/tcg-op.c                 | 20 ++++++--------------
>   3 files changed, 7 insertions(+), 16 deletions(-)


> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index 9a22791be0d..75d965d40ab 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -426,6 +426,12 @@ void tcg_gen_brcond(TCGType type, TCGCond cond, TCGTemp *src1,
>       }
>   }
>   
> +void tcg_gen_brcondi(TCGType type, TCGCond cond, TCGTemp *src1,
> +                     int64_t src2, TCGLabel *l)
> +{
> +    tcg_gen_brcond(type, cond, src1, tcg_constant_internal(type, src2), l);
> +}
> +
>   void tcg_gen_discard(TCGType type, TCGTemp *src)
>   {
>       tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
> @@ -685,15 +691,6 @@ void tcg_gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
>   
>   /* 32 bit ops */
>   
> -void tcg_gen_brcondi_i32(TCGCond cond, TCGv_i32 arg1, int32_t arg2, TCGLabel *l)
> -{
> -    if (cond == TCG_COND_ALWAYS) {
> -        tcg_gen_br(l);
> -    } else if (cond != TCG_COND_NEVER) {

Should we mention "Remove premature optimization" in the commit
description?

> -        tcg_gen_brcond_i32(cond, arg1, tcg_constant_i32(arg2), l);
> -    }
> -}

