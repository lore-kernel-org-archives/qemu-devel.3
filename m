Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31555CD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 13:24:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ3Ni-0004iz-9E; Thu, 21 May 2026 09:24:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wQ3Ng-0004i7-Rm
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:24:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wQ3Nd-0002MW-As
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:24:08 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64L99uRd2491817
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 13:24:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tZCO5yGDelcPY5dWMfFho53leLJGgDwI2KXlzUHP4A4=; b=fa2cwjo4IJ7H35iO
 HM5qIDlWDegxI8Q9cvR8s0uStMUhC4PU5BdwhkHC0kXmhTvCpS6zhKcuZmIxKCBh
 /4X5i0WWNpHTk5N5y8hjQFn2HJmpqtpCGDIUZsdUIptj7NEflVH/FYBuOqHbJCL/
 ZXoYmCUjyPRkXkkY6FoCUVF699FNybQt8lhyaxsYyG6Cl3v6bNSUzzJQRjecnR3a
 YwiSsNHussQTpzqyKn5ZWvsOhGu+BobHb0scCIY0TJJDePp/Jphh7NHzMrCwpmuo
 B+TP78284QYtu6jU5mIdNtBMw/JzpiJdb/y1TjRarHhjt+MTykLeGjG7ISxiGv7Q
 OD1y3A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9e9j559a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 13:24:03 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-516cadacf92so7741591cf.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 06:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779369842; x=1779974642; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tZCO5yGDelcPY5dWMfFho53leLJGgDwI2KXlzUHP4A4=;
 b=SZyKO+Kf5BuYUjzNjwWRvub1bIEzpHoLzKyjSPNJdpgM79jt79+PCyAa8S4IMK2QXL
 FH7mARJ+nwML2P9PBBREPMLzDcbKqJy9/Jta34SPvfPMenicuw5I2Cq35y83tQBFWctZ
 rh/yowB1ZYj/AtXXOq4VoIYyJVvif17daoRLeSSbcmPuGppwThQWNiK8YOK282/53pPY
 zqfLaZpZZblcDjP/hz8/gFcn2z4Sg4j8lPO9sFc+A2U+KSJnOXP/gHIEARBO73iNt3c5
 6A9aJKhwUel2XOLENkKUP6BpgkXNwzrpXv/TxwdtaqLCFW/k8K2yn+WGAcT02SGsmjSt
 lSMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779369842; x=1779974642;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tZCO5yGDelcPY5dWMfFho53leLJGgDwI2KXlzUHP4A4=;
 b=K7Bmbke0SBMK8Pe5ZAqni6ucmcJdiU9m4eDGK1PHRmuJQwGtgXIxOfmQDgBqB/xEcU
 JwSoNWSu+2RNLkcVNOMNZHeoiyGfsl0SIMKTcODNPL1L9WbKCFeJvV08OYV6rnvzhV+/
 pY6BwfnKhwf4VBJZwpFpE/i8Fez+Czb4lRgx1esWBNYDp6Yzd4RHq4VU1sxlfjbGqXVg
 Esv7LiIENmCDWE+WtiPniHGAWSeDOB4wvw3B/sN9adxjpGu6RI8RyHZtSuBuWzyln5/6
 dQvC5Ed30qrvGLhGLwCPAbFX1aEEGoPoYJipPV3lZv5Z8MjU4N2Q2XLSFH8IG1/Tw4Oq
 PpsA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+a1Xi+08fYlPxVo1XSF80pei0TmZSIELZ2QCc6KBB7WM8CcJCyOmUpEdTZPjipgZDZClBNdWinILLz@nongnu.org
X-Gm-Message-State: AOJu0Yx0Zat29Z8x0oUBCMFoJ6gaZmLnKzTZ/WR+z3HqtL13nJFOyvmX
 w+r+fhdfZfeqWjtbB1U400wh8ob/z1FPNt8qQ4KIVmE3gHylPTf3Hi8aNCzLRXKRnXtMBQ6QCEz
 7aL/zSGIoDHroOWmB4DhzYojHKb5iSWi3IXI9ZGL7g01y7snKImp4FzWnnQ==
X-Gm-Gg: Acq92OF1Cfi5xpUnYFi6P4/r9P4NbSkP3EMkcatIxCxJOhbx/iXTXZQBeD4ZEwzxLoG
 brB6Ow1syfBIdoFT38smQ/qE5mhd3b6vqfKsxM2oH3OsNYUBlgTVVmfdV4LMazZYYN1RfKIi7L5
 wQWo8pz5hbdn9uWMPi2fkSDr6t0pa6Q8tvDy540/4ss7RM709xtoz5crvd2Z+lT+prC1rOiOIv+
 ins3SvIPjxROhum0DSt7x/vmTmNem8nQmVnfX6JYFVg7lacoKlZTPinXkctXi5U/ziouVrGhjbS
 msE6ebjvRfrDrNDH/rRdCI5X0zGrfe3xeHZ0lZgmPYkb1qztayJVAU7yKgTSllQoSROzTWkWvRY
 zlIdUshoLv+LTOnLY2rMji2EUj+cUN3yr9whBgIxiR4COYUl+Sja+RtTr+g==
X-Received: by 2002:ac8:5ad5:0:b0:50b:5056:fcc4 with SMTP id
 d75a77b69052e-516c5461c0dmr39323091cf.4.1779369841786; 
 Thu, 21 May 2026 06:24:01 -0700 (PDT)
X-Received: by 2002:ac8:5ad5:0:b0:50b:5056:fcc4 with SMTP id
 d75a77b69052e-516c5461c0dmr39322521cf.4.1779369841160; 
 Thu, 21 May 2026 06:24:01 -0700 (PDT)
Received: from [192.168.15.43] ([177.196.135.199])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cc768ecb51sm4928446d6.21.2026.05.21.06.23.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2026 06:24:00 -0700 (PDT)
Message-ID: <7d5cca61-4f9b-4b32-a045-017002ec31b7@oss.qualcomm.com>
Date: Thu, 21 May 2026 10:23:57 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Raise illegal instruction for Svinval in
 U-mode
To: Zephyr Li <fritchleybohrer@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com
References: <20260521115749.28774-1-fritchleybohrer@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260521115749.28774-1-fritchleybohrer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=bfhbluPB c=1 sm=1 tr=0 ts=6a0f0773 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=IOOwV0Eez6LtLsIbZioZZQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=p0WdMEafAAAA:8 a=pGLkceISAAAA:8 a=ra8Du2d4nFHyhCTLL4IA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: u4QcJnAi7wvLhIfpVpzepjUhm_Q5NK8c
X-Proofpoint-ORIG-GUID: u4QcJnAi7wvLhIfpVpzepjUhm_Q5NK8c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDEzMyBTYWx0ZWRfX2JTlwc8AE8UX
 yJSWvLT8cq73W/+N+q+6rR0uIZipogaH6w9Kcj8nH6KDJztmHd9XDsd6M+yhgvmKcJdMjXVFuk4
 kvIr72y9o23EiPh3VgsoZ/ckydWLZ/Ewxv56iqa4VDBnbdN0ZOMSCo9uMd2yJt160gCnz0oIN3L
 kQR+FmXumk1BRy7uw6nr9uBLkTxp3ceNCd4QX4P6i9xa+zdT171jgGy14UV9/QTKy3HtoEFSS87
 8nislXZllD30JF2wLGhNcq7QGhxa9SmyyRs6MZRm23ildWsmatlfaFSdcOcYAAFP12mP6PkmPDJ
 18pdN/HwjDwglz2iC4F8n4qfmvBPhXF4/He46khUEZhLbD3F1d5uN8CJK+kIaATNHPvvvwT3tOv
 /HSxKqBhu+vC4XHlh+eeLZbqrkw2aMZ9akisWvrJm8hU+zVeg+BtaOQ4rdgDR23JwKWvN+wS7lV
 /TBw77pQb4B+37nIonQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210133
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

(note - my email was wrong in the CC)

On 5/21/2026 8:57 AM, Zephyr Li wrote:
> The RISC-V privileged specification requires SFENCE.W.INVAL and
> SFENCE.INVAL.IR to raise an illegal instruction exception when executed
> in U-mode. Check the current privilege mode during translation and reject these
> instructions in U-mode, so they are reported as illegal instructions.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3493
> 
> Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
> ---

Reading the priv spec, right before the part that mentions sfence.w.inval and
sfence.inval.ir:

"SINVAL.VMA, HINVAL.VVMA, and HINVAL.GVMA require the same permissions
and raise the same exceptions as SFENCE.VMA, HFENCE.VVMA, and HFENCE.GVMA,
respectively. In particular, an attempt to execute any of these instructions
in U-mode always raises an illegal-instruction exception."

So it seems to me that all insns from trans_svinval.c.inc needs this same
U-mode check.

To avoid copy/pasting that if check, the file trans_xthread.c.inc has the
following macro:


/* Test if priv level is M or S. */
#define REQUIRE_PRIV_MS(ctx)                                    \
do {                                                            \
     if (ctx->priv == PRV_U) {                                   \
         return false;                                           \
     }                                                           \
} while (0)


I suggest doing the same here - adding the macro then doing a
"REQUIRE_PRIV_MS(ctx)" in the relevant insns.


Thanks,
Daniel





>   target/riscv/insn_trans/trans_svinval.c.inc | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/target/riscv/insn_trans/trans_svinval.c.inc b/target/riscv/insn_trans/trans_svinval.c.inc
> index a06c3b214f..a9bf75c7e9 100644
> --- a/target/riscv/insn_trans/trans_svinval.c.inc
> +++ b/target/riscv/insn_trans/trans_svinval.c.inc
> @@ -39,6 +39,10 @@ static bool trans_sfence_w_inval(DisasContext *ctx, arg_sfence_w_inval *a)
>   {
>       REQUIRE_SVINVAL(ctx);
>       REQUIRE_EXT(ctx, RVS);
> +
> +    if (ctx->priv == PRV_U) {
> +        return false;
> +    }
>       /* Do nothing currently */
>       return true;
>   }
> @@ -47,6 +51,10 @@ static bool trans_sfence_inval_ir(DisasContext *ctx, arg_sfence_inval_ir *a)
>   {
>       REQUIRE_SVINVAL(ctx);
>       REQUIRE_EXT(ctx, RVS);
> +
> +    if (ctx->priv == PRV_U) {
> +        return false;
> +    }
>       /* Do nothing currently */
>       return true;
>   }


