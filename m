Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D2C5C982FA
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 09:23:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9JC9-000671-R0; Wed, 23 Sep 2026 05:23:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9JC7-00066T-Us
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 05:23:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9JC6-0002aN-3p
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 05:23:15 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68N8JZBG2028398
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 09:23:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2540SF8tWVDx2BrPCkbi7tmJ/h2zUNYFLWdDlK3W6jU=; b=WSnejKFGuJHW7p9m
 KoAmU78/bG8oTuMhAVpP+ghRHy7kx28/cGi5GGoPRQSSa+7yljL3nyqWOdf+OD5K
 o0v2/3eWPA9jMzp2IMxiXeQcoOHp6W78xeyoO3crOpoNSnFhbJr8EhA+uC9wewxZ
 NFc0h4MAGKHqly87uTkXfO7vwHRBqQrEDgnMDSmKoEkcqnYTaMiZW2nkfb4KEzad
 z+67SD8W2jNReLs9G9MKvv9ocPONeTOSszFMRQfltQJvD68bg92IOzgFyw/SycMn
 kMNT/c09biB7wxolbBWpcDXUGtq34pcwMR5g7Lx9TJ3KRldURr6FAq4Y/EM6QTSy
 3wAfsQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4guy2c38jx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 09:23:12 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93909014c85so145929985a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 02:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790155392; x=1790760192; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2540SF8tWVDx2BrPCkbi7tmJ/h2zUNYFLWdDlK3W6jU=;
 b=fV881QqJyNZ88iC0XneY1a+YEuAqAkh5Bd78Wc9Ah2Q6zApSH7e2B7yXAAv38WAaZb
 /d/IF6kNZ1C8KKNeuOK0abm4wFKqkXUK8NF0O7DeTceSnjRQBJ83pRPXx+Vb598f630x
 m2SSgPYg+1PKgpLWX5SVG82L4E/6Sxad/APCLDiiWAWtoXlTnnnBuDkSsChnSpdcw3Jh
 GoTxiIwU5on6/09BZawBYzh5gxsVY7GNOo1R5lkDOE/gd/dFUZe6O71Y7bVGrMu8myrv
 9rU4Yvkb8RcFPiaMvq8a9ibU6xIym/xNmCPCGU/ZIBl9e6hr+iKkwytwuR/ZWwLHl/6L
 VX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790155392; x=1790760192;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2540SF8tWVDx2BrPCkbi7tmJ/h2zUNYFLWdDlK3W6jU=;
 b=qF1sZrGegbMnx2kNAB3YIyvonvh+4ZmmK/SiG0BbTVs0XbrsDJeUktNusfMTXSC0z2
 PVuXTww0WpMSQHsH9E/LiBrixr+v2V0s+fEHDM7S8oKRbKxpgkc8bk0ihw00s5cYawyD
 r+VQWc2lzOlMM95Lfb/IS8A3AD6/FsMUcdOXb+rZuch5Ebrs0scLziSDUyBWE6DsKmOU
 Vf3KU2gBnglvEEXJYFX+Tqtt1t9bU58n8+EvxNIIkwnEgiyo1P63OW2UWf5j4QgCFcuF
 aBzgvSrLQnhW8Qhi/ozfptcxDKJcqSKsoMS6ZFWv/Kh0ybA1WAEtylfBdcLJvsMcNUok
 85hQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzynUuEZFBD9+OVC/keyhAXNUegVrQUB1khfbNsSE7B6Acc0fPx3YiPsgGQdcbKxHuaOBz+IATCnluV@nongnu.org
X-Gm-Message-State: AFuF++kXDHmIzG2Ix531HGlzwMUAQQf1enyKEOGgd36s23XMkB6IJer9
 OEnO3/4yFp1r2o3uOgaeoOfuQ+Cwq6uCT12nM5KWZBJhOubPUmuL9xpKcl8Oj+YiPuGptkF5FcO
 S9m5ibBfSrFvwUEtfS1oVXO4kPn7UAN8VQfvAGW+8YPXKlcI9zOXdbvQ9Dg==
X-Gm-Gg: AYBFou1C1hBLhelGmuaWLqa1YyKePNtHDV+xDZuKIfjOQwcmXRLHD1ZBmYlK/+M1jal
 B1/EvvIQucboJZYcmQ6r3Oc2qIpgTQMuYDXLWcb5YjgkZNGVC+lnURWGFTVUj0+fZ0z6nCtO9/K
 4/FWtlya8gkxhuS56cAfGXLMPhl7Ok3V8bDDC8T9Ibuv75AccfAhd7zqa2VNXS45eWQBmFf9aVS
 eFM5Zm/uorD2RQAySljXaxRbhVdUG83GE3FGJT/FgEFTyThka9L5iH2nSNuuvBHcj1X2Vp7V2MF
 XmwzKOvYS0I2CYeHILmCqEnjB86TfBK7EGG1F7RlBL9oaC6K4mPXd3FslKM24ld0QCJZ4JDduC1
 EHa0S7+PEuPkJrKg7pUQQZ5m/waGaw8wKlvnRTB8lJ8xcaeGlml3hw5wUaQ==
X-Received: by 2002:a05:620a:2607:b0:936:883d:89c6 with SMTP id
 af79cd13be357-93c250f73bfmr345796885a.28.1790155391782; 
 Wed, 23 Sep 2026 02:23:11 -0700 (PDT)
X-Received: by 2002:a05:620a:2607:b0:936:883d:89c6 with SMTP id
 af79cd13be357-93c250f73bfmr345793485a.28.1790155391360; 
 Wed, 23 Sep 2026 02:23:11 -0700 (PDT)
Received: from [10.21.17.122] (156.170.88.92.rev.sfr.net. [92.88.170.156])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe0c446e1sm37827435e9.2.2026.09.23.02.23.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 02:23:10 -0700 (PDT)
Message-ID: <3ae1ecd6-e4ee-4e4a-a341-925fd14dc2b8@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 11:23:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/6] target/riscv: Split interrupt logic from
 riscv_cpu_update_mip.
Content-Language: en-US
To: Rajnesh Kanwal <rkanwal@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liweiwei@iscas.ac.cn,
 zhiwei_liu@linux.alibaba.com, atishp@rivosinc.com, apatel@ventanamicro.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bin Meng <bin.meng@processmission.com>
References: <20231016111736.28721-1-rkanwal@rivosinc.com>
 <20231016111736.28721-5-rkanwal@rivosinc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20231016111736.28721-5-rkanwal@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 5mN0C9R7xUeUd3-b65gn2AhQ2b_wOGBV
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAzNyBTYWx0ZWRfX4GPLDE8ZdSp3
 Wj3F9rnzjYGinCkoZfhhQaEVFSn/L/umz7zGNG5LJ0rFOE8ivVVEpac6249KZxn3CNuoDHSUh8K
 FO5Hw9gr2l17Mt8cKKcXkzf9uTTioNw=
X-Authority-Analysis: v=2.4 cv=Zsh4uN7G c=1 sm=1 tr=0 ts=6ab39a80 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=eaAV3UWiRlsByXHwY8kiSA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=h0uksLzaAAAA:8 a=JF9118EUAAAA:8 a=oUDMsZ99umo5Pg4j8kYA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=MSi_79tMYmZZG2gvAgS0:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-ORIG-GUID: 5mN0C9R7xUeUd3-b65gn2AhQ2b_wOGBV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAzNyBTYWx0ZWRfXzg3oBP6UlGS6
 dKSEuYXYNBk+23l3LljNTpy2K4rGHxUadRREVXPwWSbDX0waCbD1Un/VfHyQXh30ftdCmO6qZg8
 8QKjYW6vcdchpM90+FvjPwN02IQkriW/yHQWwyIueqwJDda1eaSsk1rMqpPd/p0LHh10G9ibLrH
 cBskTDZuuFwMoOD7m1i7ZjKQbLOEBSz7KjyUVJ11Q7YGXuHL6RV0H2jjM1O9ztYUb5Tkjw+9iW9
 6ew7lVHevnWZfyjOHLC/YA/TslXrVURZiOnNF6kMFD6isyt+1X150tWQCTXPw+ycdkwCKuBGT12
 GD/r3UCWwjiyUPV35olADUVmJ3nd8OVo5XuwkqEYz/dLcU0sBJK6wBxXyxNssPkk39zWb+xkZCG
 11OT5MRsnODlbeK4paCiHxs1Q2SaJyxGe48lrrF1/zNjl/+NqM97W22RW+z9vKQeY3e33MXRzPp
 0V/FnfvAxfeQcl/hwZg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230037
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

(now committed as 1ebad505f3d5108513bf150b901344caceb3a7c1)

On 16/10/23 13:17, Rajnesh Kanwal wrote:
> This is to allow virtual interrupts to be inserted into S and VS
> modes. Given virtual interrupts will be maintained in separate
> mvip and hvip CSRs, riscv_cpu_update_mip will no longer be in the
> path and interrupts need to be triggered for these cases from
> rmw_hvip64 and rmw_mvip64 functions.
> 
> Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   target/riscv/cpu.h        |  1 +
>   target/riscv/cpu_helper.c | 25 ++++++++++++++++++-------
>   2 files changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index f8ffa5ee38..6fe32e6b38 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -463,6 +463,7 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env);
>   int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint64_t interrupts);
>   uint64_t riscv_cpu_update_mip(CPURISCVState *env, uint64_t mask,
>                                 uint64_t value);
> +void riscv_cpu_interrupt(CPURISCVState *env);
>   #define BOOL_TO_MASK(x) (-!!(x)) /* helper for riscv_cpu_update_mip value */
>   void riscv_cpu_set_rdtime_fn(CPURISCVState *env, uint64_t (*fn)(void *),
>                                void *arg);
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index aaeb1d0d5c..581b8c6380 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -620,11 +620,12 @@ int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint64_t interrupts)
>       }
>   }
>   
> -uint64_t riscv_cpu_update_mip(CPURISCVState *env, uint64_t mask,
> -                              uint64_t value)
> +void riscv_cpu_interrupt(CPURISCVState *env)
>   {
> +    uint64_t gein, vsgein = 0, vstip = 0;
>       CPUState *cs = env_cpu(env);
> -    uint64_t gein, vsgein = 0, vstip = 0, old = env->mip;
> +
> +    QEMU_IOTHREAD_LOCK_GUARD();
>   
>       if (env->virt_enabled) {
>           gein = get_field(env->hstatus, HSTATUS_VGEIN);
> @@ -633,15 +634,25 @@ uint64_t riscv_cpu_update_mip(CPURISCVState *env, uint64_t mask,
>   
>       vstip = env->vstime_irq ? MIP_VSTIP : 0;
>   
> -    QEMU_IOTHREAD_LOCK_GUARD();
> -
> -    env->mip = (env->mip & ~mask) | (value & mask);
> -
>       if (env->mip | vsgein | vstip) {
>           cpu_interrupt(cs, CPU_INTERRUPT_HARD);
>       } else {
>           cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
>       }
> +}
> +
> +uint64_t riscv_cpu_update_mip(CPURISCVState *env, uint64_t mask, uint64_t value)
> +{
> +    uint64_t old = env->mip;
> +
> +    /* No need to update mip for VSTIP */
> +    mask = ((mask == MIP_VSTIP) && env->vstime_irq) ? 0 : mask;

If mask == 0 do we still want to call the riscv_cpu_interrupt() logic?

IIUC this is the point of masking, if no change no need to update MIP
and evaluate other fields.

> +
> +    QEMU_IOTHREAD_LOCK_GUARD();
> +
> +    env->mip = (env->mip & ~mask) | (value & mask);
> +
> +    riscv_cpu_interrupt(env);
>   
>       return old;
>   }

IOW as of commit 7074591d795:

-- >8 --
@@ -580,6 +581,9 @@ uint64_t riscv_cpu_update_mip(CPURISCVState *env, 
uint64_t mask, uint64_t value)

      /* No need to update mip for VSTIP */
      mask = ((mask == MIP_VSTIP) && env->vstime_irq) ? 0 : mask;
+    if (!mask) {
+        return old;
+    }

      BQL_LOCK_GUARD();

---

