Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 087AFC79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 20:31:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4OwS-00024C-Rv; Wed, 09 Sep 2026 16:30:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x4OwK-00023Y-5T
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 16:30:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x4OwH-00016S-Lq
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 16:30:39 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 689JIXN43219854
 for <qemu-devel@nongnu.org>; Wed, 9 Sep 2026 20:30:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QumS6jdBW4R0AWOIcFDUH/MHyOdEsS86cIRJOGePrbo=; b=JSJWHxYiDnOMEmmr
 GYi8QklXVP7cS+oVoZobmZTdcuK57Z/QtVPuxItsBREOyAyRRtll/UCJYbllc2/L
 3qWEbtxtvym2+7o7EpWpvjmh7Kt8AEdDf3+5MYe+9x6igXzNADnTeC2vjheSL7pp
 +eVP7ncP0KRjDOnfSIZ7B33NYX3vhYEX6dt3OOm2ONsOpskRRg6vUGZrfV+/6whK
 8cX7384NW0hgN0U4G6r9QykAZcWw7f7kqCwww//Or0CjY29lmvVk4KDz89IN5u5+
 mZWT17Q3WcSqMVkZkpXYhNrD72rD1q0AlH4Xe52m600PR7rdUPkoP+Ell4YxRTzV
 jjij0Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkcyg0ecu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 20:30:35 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e5fc4c7e9so653662485a.3
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 13:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788985835; x=1789590635; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QumS6jdBW4R0AWOIcFDUH/MHyOdEsS86cIRJOGePrbo=;
 b=dKD41kfsDKHKGml5q5HZ//g5wytA9NTgfaBltzfZQg6R8UQMWmfu161W7LB7XDCraZ
 EBgY++xA7FPU7YTJGei3qRg+YlnLEcFfyPIH2rMoRrN/OmTNsto/y7kQecoMlDF7HSiq
 wmvAbBjt2g4Y7Dh27PVkvbxvqI1WcvmLcGI+zS53d71mt+xb3ErLkIT8QwJdlz94z3eV
 TvEKzS7BC186gWrH57AuuN3B0+Aa+M13G5aDawxtZfJ7HyZIKBW0uRvJsdok1Do/6owk
 F6I5Dnfl7S794u/QzuAKwC+6+51yhKALVFoN6eudEDbX9Cktshy7VZj1dKJK8yVS8o+t
 E8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788985835; x=1789590635;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QumS6jdBW4R0AWOIcFDUH/MHyOdEsS86cIRJOGePrbo=;
 b=tXktCOU3RQPZ31TLAYUtCGju2VdLwZOzTacOYmPneWN2LL2GS/P4J2Zd/JfBSJ5Au4
 UkZvCfX6vXonx3fWWwWUN+zzLdJyeXvwB1EGSVy5q+D5Do711OCUhhPgJF2Ih6yWORjU
 r6j0T2e5bFpxX6TxXmu8TA55Gvp6ChLX8wXpdTr4VeXCrAIUp0x7NwZvF1DCLO/1tJKy
 OcTscVXCGJAnwC+AwsJPRWZSSat8nDP4tQuRXdt/5cMZhsht+7pXf1HWZbNVn3bzi2Uv
 BgmGmIZ6/xvIT4fiSA6yfy+v/ZEzWtRlcdO22Xga4jU7onL6teBRSQgzCP+Hl48qUCGG
 DUOg==
X-Forwarded-Encrypted: i=1;
 AKwUvByR8DWRzc5x8x15uX4ypMKfjc8GmevSNN3Ow/aennRlFKTkgUHVyDH4psqrZqpZLo4ONzLp0YF+tRpS@nongnu.org
X-Gm-Message-State: AFuF++k+pbBuhmR5RfMH1cvDsr/zd2v37bYaIUCsCYWdZVbfY3RVzLHA
 IsNTl0IBx80rXTwuMEOMx9TNoXiCqPavaXtz+0LSCdILKsODuh9oGAV5zSWG8I+3Fl+8hjmYIj5
 7GQwUUL/Poio/GjWaVCrasIkaxogCIkUL0k69SlBZ0w3zXmLmJPBjqPHaUg==
X-Gm-Gg: AYBFou3c/t8X7iFjP3t2ONwPzpQiwUD5nKHhOzpOriBP57Uuj4bftpgyZpuupElTfHS
 2nnxvbuO736K7drIh3bLNlFVvu42SqFZQE8KN0PfmSa13+hbnTJOHlU+7m8P6AofPjtIvN5R9tD
 7fLiryXWGbeT1hfPwqsPUfONtn/pihsJRBw2EEjhpGaNhfX3poV9rSrYMbYJZeiyk/rzBkGRcBi
 zTtPIuwCJGHO6YBi11vcDq6boleiTLhC6esx7elPyLVR/ntjrGklD4O/fYVBoCc+uuA3zWLTSNp
 kktc8lvirOS4caM6H/r1g73yCkdAd8G7agh0v+LWlSLmd197Se0bGmdPzzT9BazFzPllA4+kAKX
 3X4dAyS/pfP54kQ+8uw1YZS1ScdzL5O+Z6/M=
X-Received: by 2002:a05:620a:6d5c:b0:937:6900:a7ae with SMTP id
 af79cd13be357-93980402d92mr46598385a.15.1788985832900; 
 Wed, 09 Sep 2026 13:30:32 -0700 (PDT)
X-Received: by 2002:a05:620a:6d5c:b0:937:6900:a7ae with SMTP id
 af79cd13be357-93980402d92mr46552585a.15.1788985829303; 
 Wed, 09 Sep 2026 13:30:29 -0700 (PDT)
Received: from [192.168.68.102] ([177.18.66.131])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9397fb6e95csm1487813285a.31.2026.09.09.13.30.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Sep 2026 13:30:28 -0700 (PDT)
Message-ID: <ee67fe57-7098-4905-8eda-24175bb889fa@oss.qualcomm.com>
Date: Wed, 9 Sep 2026 17:30:25 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv/tcg: svinval instructions raise virtual
 instruction
To: "Christian S. Lima" <christianslima@proton.me>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
References: <20260908222825.84642-1-christianslima@proton.me>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260908222825.84642-1-christianslima@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=YZYodARf c=1 sm=1 tr=0 ts=6aa1c1eb cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=CQQxcbsX5Byh3TlVSSGwig==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=p0WdMEafAAAA:8 a=mgf4wIIqgWUfDR3fEIMA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDIyOSBTYWx0ZWRfX97K58fxg+4ov
 Ci92myip8E1WNSxD9hAO90mheyPxhrEvjHFiuESE0BOaP0xC0J+VB1nsXh4nkQIPlNJa8zHJUrZ
 JVNfvMAbp68wK7EG64a9nRy0k/F0/bc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDIyOSBTYWx0ZWRfX/er+63m+A823
 AKunbELGQquMRRrdGoALrWA5Jb8jwHfJRkzycElMuCbESt7Qvs91NyxZ+YYCbL//QJVv0uh0kqv
 sDrcm7gqDM0oTMQf4+k5K1RCh8hK0uUmHxQGryE6HfrFz0BuE2PLl7BpO8Ub+zNDCR9pRdSpQvN
 aUjk/XGnx0KqJ27sB5f30s6swwDRi97iHnMKvOpdrGsLKdjTDaaRK6F7y7W5jnlXPuEn5OnJsUr
 yVEcM6fCCOIRGfhoprdDwwol+2SQFb/8PpnuMjsAoIh5Gu/T9B/t6hv8NjyihWemS0WovuICzlw
 KXzwagHMMyg96eQhwsmYLVqJeEZkZi8D+CaOIBBxD3ZlPfFw1ap8Z62w0u/mF7oRVfIltY4OaCr
 y8MpvNQFzCUkaa6iyBvJG1qfrNjfa9C70s0gP+biUmGPFmMAe95QxXPKfAJWPrldZfd8RWj6WJw
 A0qdAyLh9lBee0lsTBA==
X-Proofpoint-GUID: Txh6WXzaSGIUoDXNyW-b8wUS2sLg_p5p
X-Proofpoint-ORIG-GUID: Txh6WXzaSGIUoDXNyW-b8wUS2sLg_p5p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-09_01,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609090229
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

Hi,

On 9/8/2026 7:28 PM, Christian S. Lima wrote:
> The risc v privileged specification requires hinval.vvma, hinval.gvma,
> sfence.w.inval and sfence.inval.ir should raise a virtual instruction
> exception when executed in the vu-mode. This patch add the check to
> raise the virtual instruction exception when is in the vu-mode.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3621
> 
> Signed-off-by: Christian S. Lima <christianslima@proton.me>
> ---
>   target/riscv/tcg/insn_trans/trans_svinval.c.inc |  4 ++++
>   target/riscv/tcg/insn_trans/trans_xthead.c.inc  | 13 ++++++++-----
>   2 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/target/riscv/tcg/insn_trans/trans_svinval.c.inc b/target/riscv/tcg/insn_trans/trans_svinval.c.inc
> index 4614c1489c..251d9c5815 100644
> --- a/target/riscv/tcg/insn_trans/trans_svinval.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_svinval.c.inc
> @@ -25,8 +25,12 @@
>   /* Test if priv level is M or S. */
>   #define REQUIRE_PRIV_MS(ctx) do {          \
>       if (ctx->priv == PRV_U) {              \
> +        if (ctx->virt_enabled) {           \
> +            ctx->virt_inst_excp = true;    \
> +        }                                  \
>           return false;                      \
>       }                                      \
> +    return true;                           \

We can't 'return true' in this macro.  This is a "return false if wrong, otherwise
do nothing" macro that this file uses.  It works like REQUIRE_SVINVAL():

#define REQUIRE_SVINVAL(ctx) do {          \
     if (!ctx->cfg_ptr->ext_svinval) {      \
         return false;                      \
     }                                      \
} while (0)


If you look at trans_sinval_vma(), adding a 'return true' in REQUIRE_PRIV_MS() will
cause an early exit right after the macro, short-circuiting everything after it:

static bool trans_sinval_vma(DisasContext *ctx, arg_sinval_vma *a)
{
     REQUIRE_SVINVAL(ctx);
     /* Do the same as sfence.vma currently */
     REQUIRE_EXT(ctx, RVS);
     REQUIRE_PRIV_MS(ctx);  <===========
#ifndef CONFIG_USER_ONLY
     decode_save_opc(ctx, 0);
     gen_helper_tlb_flush(tcg_env);
     return true;
#endif
     return false;


Same thing with REQUIRE_PRIV_MS(ctx) in trans_xthead.c.inc down below: we can't add a
'return true' in it too.



Cheers,
Daniel

>   } while (0)
>   
>   static bool trans_sinval_vma(DisasContext *ctx, arg_sinval_vma *a)
> diff --git a/target/riscv/tcg/insn_trans/trans_xthead.c.inc b/target/riscv/tcg/insn_trans/trans_xthead.c.inc
> index f4e3051000..c00b007895 100644
> --- a/target/riscv/tcg/insn_trans/trans_xthead.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_xthead.c.inc
> @@ -267,11 +267,14 @@ static bool trans_th_tst(DisasContext *ctx, arg_th_tst *a)
>   #define REQUIRE_PRIV_MSU(ctx)
>   
>   /* Test if priv level is M or S. */
> -#define REQUIRE_PRIV_MS(ctx)                                    \
> -do {                                                            \
> -    if (ctx->priv == PRV_U) {                                   \
> -        return false;                                           \
> -    }                                                           \
> +#define REQUIRE_PRIV_MS(ctx) do {          \
> +    if (ctx->priv == PRV_U) {              \
> +        if (ctx->virt_enabled) {           \
> +            ctx->virt_inst_excp = true;    \
> +        }                                  \
> +        return false;                      \
> +    }                                      \
> +    return true;                           \
>   } while (0)
>   
>   #define NOP_PRIVCHECK(insn, extcheck, privcheck)                \


