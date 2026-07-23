Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD969C531F7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 17:39:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmxNj-0005oZ-Kv; Thu, 23 Jul 2026 13:38:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wmxNc-0005mL-In
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 13:38:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wmxNZ-000569-LP
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 13:38:43 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66NHX9oV528713
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 17:38:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ibk5HMSkBUrJkeQntdQVXOLFdNw2Xb3EfqWYU2N4qlA=; b=E0jTOhwIu8ufmp87
 7qOiSZ287YhnAaxcm6ny2YzKVuMuhBovVIegks4HmfSZzrLmtrPBlNYHwLWOCdxg
 g42Sx9X2DZiadW7Xxs6bcFy7evIAKF54xFaP8mPNQ8Lc/+q/AUjOth7bOMyGedP5
 sm/9fAdUMs1gyAH1A/If81is4e3/5ZJWUshw/oJwGDgg5TgV0Ce/eKv2oQTxVccZ
 KfruPsFm2T3YETe4OUBiKRz4T0cciEUOBSwcpN4GdId1DTgdnMtZtbOEAaJpGtz/
 zXBBvO8WMpHvz+uapo51ZUAoF6f9YVRxI2IbWAAV1msMBoEhs9lkX+QUwbzLJCQA
 jcLEIg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkg5227g4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 17:38:40 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1c7f135bso15650231cf.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 10:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784828320; x=1785433120; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ibk5HMSkBUrJkeQntdQVXOLFdNw2Xb3EfqWYU2N4qlA=;
 b=j1gFqAXezMAlF1jwpXygwG1tWWkPkq5PayE9/Bb2Sllxlh4L7BPs2ZzKHT5zts1Feo
 5ME3yHcYjEdy6QfinR13UHb87IX3mMyjNDt42yoooeUO0pyOMQGujz8dKNKjT7GcIEIg
 +erAyhxc+rwcDMfI3dK3LFTK2ZcNYyDxBuIavpPQmZhe8WGF5OuaKe2HodD8pjGisI+0
 zPyjmNkrt3cCoccuo6QCPt4P9tR9+Rq2WvE9OQBm/AUszh9Z6GGZ3zXhNiDJyh2kjITA
 /uEf0e0jGtXDp2uv4mExi0C99B1Q3EYRL/m3rbB0jG8ZtlTfr8RGfNmsEbrdro2XritR
 MVjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784828320; x=1785433120;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ibk5HMSkBUrJkeQntdQVXOLFdNw2Xb3EfqWYU2N4qlA=;
 b=ocMAbSEXLvDUzB+Tq5iDpEcT7qGVrsCvNiMaU1AE4ZuPwn/kpbzsNbrMH8N90fWfb5
 VExsITbAOsjtHIPGhKro5Ioxr7zT+zXPS+nDibqxLNidwtl7asZ9HtZSOH4RfMT1yqox
 QG+1bNZP7qgO1eToQnKUALd1ue9W92WDRYxDG2shvtWzQzLQcS/ewp9ngI6L1X9fLy5T
 BdygHj9VdPzfzgN7HuGeJI0sg5j6l82G5hkJ81cILY9TaTDYrtdHOqepqtMfgvAKBCIt
 LIY7WF30Sy+6xQPS7581+I9gEHreX7vCSXifOMm7g8vtV1HfrXy/UMM2pIcAAqfCqEwL
 QNSQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoQCyH+ZqBPEtUaplqJEdL6zECztpW7v9wyk5k72vchLRtdiPLZf3QrtUIL3NQwiKEjQUN2CjLJFKZw@nongnu.org
X-Gm-Message-State: AOJu0YyeyW2q0gDv8R2u4k05pWXQjYIsKl+f9UhiLe+5sC6TNJBxgKky
 UiIRba0OYjs+l/WOY8K97lFCr4hwMvYT8x2dl1gvD0O20Cot4ljIjPF7bIjxX7dzepofv13USmJ
 bOzMPCkFBsWwn0DjKeJjKAvuvZECq6pHUSKKZ3GMGFe0yczKaMJcUhnWHyg==
X-Gm-Gg: AR+sD12frLsewFRtr5WFVyaSVfAAJ35vrvvlrXMLPLGHOy64paMNrJ2pOn5QtAuM/I6
 KbSOaipxf0e+jBYV193lfzn2i8l2Cyg0APZNR5ZeBHOKn1pVl+Z3yn5kOLh29mJ+IHM4/1Ur1sa
 X2ldzoRrKy3UGeFnb5uvNB3i3uoRJJ46dWfZpltiZJAAW+pUPqlrE1fU7cYPlfydL/sh4vjxhd9
 32Lj+mnPWrdM7sHg01MwKPQpbpNkImuJqp/o4pnjEXP1RPtDR0HBpWR2tMhhkShBGregbkXnBCc
 XWdq4NIt6TFvSeLi8ACJH/G7As9U767S3S2O7fU4150mh5zWoVr7H1oJXhLb1SjqSRzooZeIH15
 lf2RyDSwAXzpYWb5s5fwsoCZyHHbAgD1WeUXehQ==
X-Received: by 2002:a05:622a:142:b0:51c:1fd1:e755 with SMTP id
 d75a77b69052e-5283de98bffmr35530961cf.36.1784828319607; 
 Thu, 23 Jul 2026 10:38:39 -0700 (PDT)
X-Received: by 2002:a05:622a:142:b0:51c:1fd1:e755 with SMTP id
 d75a77b69052e-5283de98bffmr35530791cf.36.1784828319196; 
 Thu, 23 Jul 2026 10:38:39 -0700 (PDT)
Received: from [192.168.68.107] ([152.234.122.204])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-907ba8d585bsm51019666d6.15.2026.07.23.10.38.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2026 10:38:38 -0700 (PDT)
Message-ID: <8e12d0b0-f7dc-411f-a750-f638c5158cee@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 14:38:35 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/riscv: use SXL instead of MXL for read_sstatus
To: Abhigyan Kumar <314abh@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>
References: <20260723142254.1683113-1-314abh@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260723142254.1683113-1-314abh@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=DtZmPm/+ c=1 sm=1 tr=0 ts=6a6251a0 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=J0RmenBMOwS19r/fhzI3tQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=LOtmT-1FezyT_fMOqjwA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE3MCBTYWx0ZWRfX5xhlNt38TwcY
 6Scf7VdaxxB9Q8bggjsgxeW7axnuJvSGQ0ttaLIhEUrbb/CauaYZI5ZpnCQ+TvdMiLagvfKcW6d
 xA5oGjzZrANNMcEdacAB4WK8yOPr7fM=
X-Proofpoint-GUID: zMoYPHxInW0k3J2ucswHnlihdR2I56Ze
X-Proofpoint-ORIG-GUID: zMoYPHxInW0k3J2ucswHnlihdR2I56Ze
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE3MCBTYWx0ZWRfX+weY2qlJ86wE
 Q+jKMXLNGdo/ZtQ5/AE4MrCoAh5ySwJwR1Kuq5uRv9TllzLkrQp20ho91kw+yGNP1xUEZf/4MAa
 7m5OSUePEGFSF+1Q0kAifroltXvRt5aUQgZLekYMIfeRVDfp07ZsaDPw49mtt7Be+IyU+HeVbop
 zejtQS4qsyWa/yWBrygZ1l7aM4o+p1jBVwOiPnIDLHvxZVVCoKrjaRT1ftPcWa7VpZZJ5JJjZYH
 WOUD0KG1DwqD0EgVnHoPJuyZxnNZR4VuJKooFDL97fKHyiEFUCMs0Gu4GNTEr4sf8IZgqHWdwsY
 UtHusyLkGoMdnbjlJfL+BzV/DpuOESLJvzB0h2HRwb1EVTjfTzhaIAg1JiJ8LtXYF7S4CfJU6jm
 CFJTloT20ellopJR82Br5Ok1w/4IFhOp5SZ8P/+PpQjVZAKcl3jtt7+x3TUlBwCf9k7QBdHaVSB
 euCFdrALXhy8sNqaiJg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_05,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230170
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



On 7/23/2026 11:22 AM, Abhigyan Kumar wrote:
> According to the RISC-V spec, a 64-bit system can have M-mode in 64-bit
> with S-mode being 32-bit (SXL bits or mstatus[35:34] being 1). In this
> case, read_sstatus should use SXL.
> 
> QEMU doesn't allow changing the SXL bits in mstatus in M-mode. This was
> because of the missing MSTATUS64_SXL mask in write_mstatus. Now, both
> the SXL field in mstatus can be safely modified in M-mode and
> read_sstatus correctly uses SXL not MXL.
> 
> Fixes: b550f89457 ("target/riscv: Compute mstatus.sd on demand")
> Signed-off-by: Abhigyan Kumar <314abh@gmail.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/tcg/csr.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
> index 36f2004bc..a90449b87 100644
> --- a/target/riscv/tcg/csr.c
> +++ b/target/riscv/tcg/csr.c
> @@ -2067,6 +2067,11 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
>       }
>   
>       if (xl != MXL_RV32 || env->debugger) {
> +        if ((val & MSTATUS64_SXL) != 0) {
> +            mask |= MSTATUS64_SXL;
> +            val = riscv_write_uxl(env, val, MSTATUS64_SXL);
> +        }
> +
>           if ((val & MSTATUS64_UXL) != 0) {
>               mask |= MSTATUS64_UXL;
>               val = riscv_write_uxl(env, val, MSTATUS64_UXL);
> @@ -4014,8 +4019,8 @@ static RISCVException read_sstatus(CPURISCVState *env, int csrno,
>       if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
>           mask |= SSTATUS_SDT;
>       }
> -    /* TODO: Use SXL not MXL. */
> -    *val = add_status_sd(riscv_cpu_mxl(env), env->mstatus & mask);
> +
> +    *val = add_status_sd(riscv_cpu_sxl(env), env->mstatus & mask);
>       return RISCV_EXCP_NONE;
>   }
>   


