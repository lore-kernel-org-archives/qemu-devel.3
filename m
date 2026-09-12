Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58BEAC79FB6
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 11:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5Liq-0006X8-VK; Sat, 12 Sep 2026 07:16:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x5Lip-0006Wr-P2
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 07:16:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x5Lin-0002s7-Dx
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 07:16:39 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68C85CxI3319599
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 11:16:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xwlGIFErmmcGU5iDtIZM+oMM/6jWWqAx4HNBRJmLg6c=; b=Thc5+5ZSDEsD4Fmm
 hXlw6f3Cs84m+dlXuf+Xv+pN5Vd63NZ4/I8VP7VuSrZZ9btGi7C8UUHc5KdJeE+D
 kqto9xxX1ShBJes8SbtMMrxWhoxvoZSWA93rCZ5urMk34woi0d4FdCJ2kbWtlWVK
 Ik1ilm8JAvFcMSPafMTueo3hb5yAk4u2etiMYq0vHQRioupAdVcFH2wwngVc9n70
 acQ8l5q2ecYX60Qoa/r2fJDOKR9iTs5updeGoicw9d3/w9RLf6u9cyTsqIANQlKH
 9wd7Cl7nXmtgSBpC/gsN3IAl2BWYYxd9p+nst6Vr6wrAT8rv739FezNX9wcHh8yJ
 L7fdyg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9c8t3r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 11:16:34 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-939a6937513so255171985a.3
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 04:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789211793; x=1789816593; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xwlGIFErmmcGU5iDtIZM+oMM/6jWWqAx4HNBRJmLg6c=;
 b=gNJfDTXejeLhpWqYabkF393hkTMYDp+kvl60wwGKRagpg9T76rHOmlJFuBYSAkN2Wi
 0rAKWNXLDwYOkC+67OYNvg7X/2pSCSYtQR1YcVJki48OR49dRrsQ2TS2CuSWsgfKE6y/
 utduq9Pmnp8yIW1DoZGMguTxCzRCfwTiNrq+hSaq0QO5mYVDztbiAXP7lRj7JRkTBNeC
 X6sQJFQL2fOj1zf/T89G+FQ+qFbuVET4JKzTOmkyXCJLceNW+SjisdfN0EmiiO9OJRDZ
 p9mmPuZ2Mh2GIZzmK2FmZjSTFDMic1o9pqiYwHf9KqOJududOl79naOula3B4TEZC5ZH
 C9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789211793; x=1789816593;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xwlGIFErmmcGU5iDtIZM+oMM/6jWWqAx4HNBRJmLg6c=;
 b=JbSDv5ZHs7j4WE0fE3OpfBGi+1aXQ4zgRCOH1rhvaBx45Xtxe5MusP8m9ONTKMTPIv
 o+nFtz5MWyGjByuYZH16tAamahh06yvaBA/tsNEUiXDeYEO5n/nDsb1lW+8qQxza/7a1
 7m9ujxt/jV4NgdgpeNmkMKUg1LOB8Ft9RYWyCMzlthhyAlpwtll7/v8jmfl263qeDk6u
 im3O7dZKX4eQKQtknRNQUdGJj3eKHRBZiEfqmwT2FE3CAalTpxFTsrYK2TTMyDVpgHwz
 B+cDXW12YX5wf3HjxHb+SEk84KXB3cj4w5CRzdDgmSQPqj/YiG5dUGk/iynUsKIXAMKv
 EXQg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx7L4LLFEZjDKSwFwer5BgUGgZ5fPHLiMsuuI+EArnKpPRgYyHnBgVcP3KsYwMT/rhdl+AzssvcyZUs@nongnu.org
X-Gm-Message-State: AFuF++l6HJZirVrG4+f4x4W2AgAb/TyrMMC9ToTJRTKh5A9VNH0PLTb4
 TvrbaHWooCQ2e43BLwhS6/Z2u60m8Or9Nfwyf0T5Y5qeXUmYJ+bZ1TPVmbsbLendOesSReRjDck
 uz9yyFMKox3vMYIt+wD8r8U5AM49bLqHPAV6C7YMWOCt9NfcV66DglZv4PA==
X-Gm-Gg: AYBFou2IQ+Mn6LiMnSHRMRxso6Hctqlkw4eCf+M9IcceC/RLYPZoFsFK4dvCWrY+N+d
 YuiDHjJLXcWkNhFc8iflN2eRqWreqX4riT1ABKAPlPA5UJlcM4VXPxWIK0L6P2zKfb1AF+uXqzo
 VLBcDZK+FNAH+BG1KvXmWlsFcjdZ0ClcZtaQvXx8jsrUCzQ9udL4bOxtwHxW/bBM0qK9FhUgQcZ
 jkGJNMIHOKJhld+Zf4mhv435BzhB0j6ft/UWEhjE15BOVFm4TIQqhZA6dpTT+KXPQ4+2JE0FjFq
 rV7cD+G5vmp3ghyxx8B1xTchHzpveC4WJY20bYkLlBw4/qMNQTJlhm0Gmn5hMZurfDUkmVGf1aw
 xa55wEmLWHxCsYiURR+s8f8dAEHQF6aShsRrOdQ==
X-Received: by 2002:a05:620a:2803:b0:936:bc78:791b with SMTP id
 af79cd13be357-93a0363e273mr281254385a.15.1789211793216; 
 Sat, 12 Sep 2026 04:16:33 -0700 (PDT)
X-Received: by 2002:a05:620a:2803:b0:936:bc78:791b with SMTP id
 af79cd13be357-93a0363e273mr281249285a.15.1789211792708; 
 Sat, 12 Sep 2026 04:16:32 -0700 (PDT)
Received: from [192.168.68.102] ([189.110.107.170])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-939ecc38105sm408460885a.4.2026.09.12.04.16.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Sep 2026 04:16:32 -0700 (PDT)
Message-ID: <0faa8fed-17ae-4125-bdac-036ecd9b1b8d@oss.qualcomm.com>
Date: Sat, 12 Sep 2026 08:16:29 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] target/riscv/tcg: svinval instructions raise virtual
 instruction
To: "Christian S. Lima" <christianslima@proton.me>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
References: <20260911201323.37757-1-christianslima@proton.me>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260911201323.37757-1-christianslima@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEyMDE2MSBTYWx0ZWRfXw6B5qK3NPbAP
 e45vTxoIo3igo6qiTBRHBzdMYQ3Zb/avSwiCAlyca2NbGWtymHvnB8ulbtwAPoijBEXwh3NOqs6
 5EhyU4V8l5ASXL4expnMOiwpeBY7LkM=
X-Proofpoint-GUID: HaCxFLhb_ri1Cjwt0e8H2qJUy5LttbTB
X-Authority-Analysis: v=2.4 cv=BdZNQbt2 c=1 sm=1 tr=0 ts=6aa53492 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=arNgJ3JLhM/z8Vk/iMOFgQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=JNtrDLsQAncQUdM-fBgA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: HaCxFLhb_ri1Cjwt0e8H2qJUy5LttbTB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEyMDE2MSBTYWx0ZWRfX3nZVuvGF97Zr
 TPxtVbvvgXwN9iH2hQcs7wd81TaEbtZfBbwiteHmJAZLrLt5uv7YsHxnKBh65OQoUopsogVtg3/
 EAO0JPER2QP5sotyTKumYQIwiqo0xbhs25GASXVjZNcmjEjjUNplaXCkm4eCV0xJIjGX+jIdVsH
 XsUaN9nvrIebNqATgomvsfvWV/+UxrNcfaI3aFokQICn0qjMavtCfVFDrKhnhT8743dw+RT/Ux6
 Q4wh62EpNRhEDS8lsTLjyW4Ujabe0WABZ9suK5MdmS9cMnvBJmHTNJRGTzT04jxZEpMvn+Bb3Xr
 bDpKWBWtzBeqi9PIOT+LAE+DDl9WGgHfmuZHc6NC4EsfxsmlbP+tTXV8TAM7k1lk2wGO8EEL4lE
 pxFICp7MST1pk3fw2twIKqTsy7dt77l76XuZbhW4ADHlN5PPgRj2IUg2gNrxIoXllsc5FuNAHT5
 pLSlQ6SX9tnEUxduz8g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-12_03,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0 clxscore=1015
 spamscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609120161
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



On 9/11/2026 5:13 PM, Christian S. Lima wrote:
> The risc v privileged specification requires hinval.vvma, hinval.gvma,
> sfence.w.inval and sfence.inval.ir should raise a virtual instruction
> exception when executed in the vu-mode. This patch add the check to
> raise the virtual instruction exception when is in the vu-mode.
> 
> changes in v3:
> - Add missing semicolon
> 
> changes in v2:
> - Remove the wrong `return true;` from macro
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3621
> 
> Signed-off-by: Christian S. Lima <christianslima@proton.me>

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

> ---
>   target/riscv/tcg/insn_trans/trans_svinval.c.inc |  3 +++
>   target/riscv/tcg/insn_trans/trans_xthead.c.inc  | 12 +++++++-----
>   2 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/target/riscv/tcg/insn_trans/trans_svinval.c.inc b/target/riscv/tcg/insn_trans/trans_svinval.c.inc
> index 4614c1489c..1341beba2f 100644
> --- a/target/riscv/tcg/insn_trans/trans_svinval.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_svinval.c.inc
> @@ -25,6 +25,9 @@
>   /* Test if priv level is M or S. */
>   #define REQUIRE_PRIV_MS(ctx) do {          \
>       if (ctx->priv == PRV_U) {              \
> +        if (ctx->virt_enabled) {           \
> +            ctx->virt_inst_excp = true;    \
> +        }                                  \
>           return false;                      \
>       }                                      \
>   } while (0)
> diff --git a/target/riscv/tcg/insn_trans/trans_xthead.c.inc b/target/riscv/tcg/insn_trans/trans_xthead.c.inc
> index f4e3051000..ea4b169422 100644
> --- a/target/riscv/tcg/insn_trans/trans_xthead.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_xthead.c.inc
> @@ -267,11 +267,13 @@ static bool trans_th_tst(DisasContext *ctx, arg_th_tst *a)
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
>   } while (0)
>   
>   #define NOP_PRIVCHECK(insn, extcheck, privcheck)                \


