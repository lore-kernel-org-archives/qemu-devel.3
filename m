Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27CE7CA9ED2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 11:59:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGb8t-0001lP-FP; Tue, 13 Oct 2026 07:58:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xGb8q-0001kG-IH
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 07:58:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xGb8o-0000qc-G3
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 07:58:00 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D8V0IA922844
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 11:57:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gt9pMQ951xcHakzUl04jJspjcuBCInvTcDlD7Xx53mA=; b=F8wI4ENNcqvnoW6z
 4sN0Ib7I9BFMa+hslvgu3UIOJtXJODNmYoCqwOyYxuYM+nblsImUUWCoyjuu1klC
 Zc2hb1ZgQY4DNNnJ8bdmYhcFd3xSQWVjNwGrlodzUWCqXHJv9rKMaXPif36eNHxh
 mIJuBIEPGANF0nrE+Puc7ZW3SdwdN2jry897O0uBJnEgcS0PDXy6tUIlmFKtU4yM
 PrsNyIPJvhYTXtv+XgGfUPVFZGzkRzW491nYNH04cacwRLjqqyQAlYbuhZFh/XZy
 oy4/IfegDs/sgq5w34ilfkyLPIGOLTFr438bhAAalpL4x8zvd4FMjw7qJqqtaIvH
 X7zPcA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h98h1tsvw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 11:57:56 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93be1861d2dso438805085a.3
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 04:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791892675; x=1792497475; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gt9pMQ951xcHakzUl04jJspjcuBCInvTcDlD7Xx53mA=;
 b=fSWYjim2LDz8DKcyBbVbnQHSkLSNNHmXFt8v0mtRAuw11IVmTH2k30DjmYOXv7fNC2
 EMl483aCU0JeLlqz0jUfVPAqDtpMUdXUUHPo/dmIsbSFdH+KUDnzF1J6UGToMlrtHIrx
 LhPNYRwiRejkJ4GOro5L1fpDg7H/UxjaLN+0sLaOrE7SR+9lcnEjeKFwjt5+5iclA0+G
 vRSCAq0IL5IbqPQVs5bh909erf9nIJ6oFKkthaSzUyOc/F6E10MCv1cDC9XCWpNErcSM
 BGYjUrLYXPKDe+wXUZRMNl9fOcgCStjt5Sf3IevX8p+TIHS8ppL+F3mDLmlGhVMupM2S
 FKLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791892675; x=1792497475;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gt9pMQ951xcHakzUl04jJspjcuBCInvTcDlD7Xx53mA=;
 b=W8KOXgrwMCJZ26VN8ext+xnR8KWROCDrtzKe+zbMBaAd6GoGprPokZPWMPjQKznVGd
 4MLHAex+PGyX2Ln6c00rw2enNDib5BNEqOpzV8F6b0WiKXhh8YV7gVcw4catQHLQcaDO
 6CMkwAuRx/OgDMZ5anG1zvf9lMJH4JP5G/mbSOuzEshYcXlqKxr+eB2VUXKsEqN2Tlb2
 j+Vwm63vLOsHh1AmjF5ncduYl2cJHLzFR8RCN9+HGJLxqN6CUjzPxMlN/2rBOFbxbuVf
 YFM85O37gXl1gJH08Xhv/GuNyO9kpui97GFqqcbuxDmsn9ZrA1qZxm3HzS4qS4HrbKQ8
 VGOQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy7qg6UFxmuPrqhH12OIo4KJuobtUwmjz0STMG3jXjD2NHRoyA23442imxJnHBmJDRvQkXbS0iwG5yh@nongnu.org
X-Gm-Message-State: AFq9FYKJKW5pXQtbYh+yn598n9H527qvD2COyt9x03VEXcU7NdpVOAbA
 JgKg6827PKfmWfWG5HTQfEHtJ1ZseEpYigfs2CmOZlTltP0/dX5urP/WeIYlkJIpaglf+koursT
 epR3/5n94A3iB/dBVMwwWx3baRk2fe+CfsDU+UlXdaypp8rBH7KBk8121o5AaYKLHNcWz
X-Gm-Gg: AYBFou0/M5XaHDgiPr/4tQ5fe/c4bzHefvB01v+JJZ7/gde5jK8LZxVYjDRqmnjBlxs
 Q8YDHtge+MA+Fe+9fw7wDKx4WfsGzfQiGvW6gjYu6a/EBPLBFQS23dzLDC9T2WkRlVIfHTO2RnB
 YUVRR/P2jOYY0hBTDStNzWxPXHHXRaoJVUTD6sPvkTpunjvBerhFqmohhsLQm5HD4IjhSjA4yYZ
 Kxd9O+os55BGFK1wA45hVlAhLEwwHtsCTMlWhh9BbdcEYqU8rjKMJiUfifwqmBEhyvkNBV9ZFfR
 i/tH243MOlIGJ1xjNWhtuzvCjuYNMGx/QONyFmrn5BqnQLbI/KDI1c4px08S9kG3AeecZVglQD+
 Sxr6N2HzqGSe8XHK26Yt4UlQzj1fKVVVWLQ==
X-Received: by 2002:a05:620a:a0c1:10b0:93e:c12c:4415 with SMTP id
 af79cd13be357-93ec12c4ac9mr1397387785a.81.1791892675353; 
 Tue, 13 Oct 2026 04:57:55 -0700 (PDT)
X-Received: by 2002:a05:620a:a0c1:10b0:93e:c12c:4415 with SMTP id
 af79cd13be357-93ec12c4ac9mr1397385585a.81.1791892674878; 
 Tue, 13 Oct 2026 04:57:54 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0967acasm3900781f8f.2.2026.10.13.04.57.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 04:57:54 -0700 (PDT)
Message-ID: <eba0b754-7505-49ea-939f-39a3ac1fca4f@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 13:57:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/86] target/arm: GICv5 cpuif: Use arm_cpu_set_irq() to
 set IRQ/FIQ status
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
 <20261013083933.1024405-8-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261013083933.1024405-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=VqC2kO2n c=1 sm=1 tr=0 ts=6ace1cc4 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=Q6hkMQemhGR6TwSjUcEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: neuWOdWkK_kiiE1GKWxZEiRSZvsE_Gqd
X-Proofpoint-ORIG-GUID: neuWOdWkK_kiiE1GKWxZEiRSZvsE_Gqd
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA0NyBTYWx0ZWRfX7hX8BQHPlN37
 bFTugWTdVLYDnyOoHDXXbYeEYFvRVjBSxiZrYrZ07TfcOntHo+OseMfeydDzHBnzBZxY+ETcBJm
 AesCaXYFluZtYfLBE6WwrU3+UfT0lRo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA0NyBTYWx0ZWRfXzNmRIY5nXqE8
 4SvX0KyNVFhR2K0RjB36ClH18HcYu7wxiLVYeymT809yZNcgunBK8NVjCiDDf8bm70f0XuOFabK
 pUpmpkZClikRHhS4NhSevGb1vaSkPO9jVj5dteH+TeTU/mr/7LNZuTXxpOaVB7rMrkP7LZv976n
 HlQo4iJNuYvBP5FJopAy99ycXUwg13D3Yeu2J+2yE0QoTTxg66AOEMjF72ErUdP/TuXdE6jaP65
 P1DDmxQ4GL03wgSYQ2UpSGqX19BQ8LdUO+KcWcVPrfquTgxnJYnXeqcxAAWmAXuOcOKtCEOzDVK
 tjnw9G3Z5zM7KVo1+biN0G4BZ0tdSDdhJDTb4xy628aowytSiMHX7gedM7KBrW3qDyajiuqPtIK
 rXelxNQHgMo9znuWL+ckLeQJHvrOBnGiGM3riJqLLC9DBAVIVHfwMWxC+Cc4XXMKnchv7gzuB/1
 8dZYBcoMURMuaEeRlLQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 phishscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130047
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 13/10/26 10:38, Peter Maydell wrote:
> Currently the GICv5 cpu interface directly calls cpu_interrupt() and
> cpu_reset_interrupt() to raise and lower IRQ and FIQ.  This is almost
> but not exactly what we do for GICv2/GICv3 external GPIO IRQ/FIQ line
> changes.  Those are handled by arm_cpu_set_irq(), and as well as
> calling cpu_interrupt() or cpu_reset_interrupt() they also update
> env->irq_line_state.
> 
> For IRQ and FIQ it doesn't matter whether we set and clear the bits
> in irq_line_state, because nothing looks at them.  But for VIRQ and
> VFIQ it will matter, because VIRQ and VFIQ are the logical OR of the
> line state and some bits in HCR_EL2.  We're going to need to call
> arm_cpu_set_irq() for VIRQ and VFIQ; for consistency, handle IRQ and
> FIQ that way too.
> 
> Since arm_cpu_set_irq() is now a function called from other parts of
> the CPU code, we make its first argument a properly typed one, with a
> wrapper taking void* for when we need to use it as a
> qemu_irq_handler.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/cpu.c             | 14 +++++++++++---
>   target/arm/internals.h       | 14 ++++++++++++++
>   target/arm/tcg/gicv5-cpuif.c | 35 ++++-------------------------------
>   3 files changed, 29 insertions(+), 34 deletions(-)


> diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
> index a6e6c440849..517c780d1f7 100644
> --- a/target/arm/tcg/gicv5-cpuif.c
> +++ b/target/arm/tcg/gicv5-cpuif.c
> @@ -173,33 +173,6 @@ static GICv5PendingIrq gic_hppi(CPUARMState *env, GICv5Domain domain)
>       return best;
>   }
>   
> -static void cpu_interrupt_update(CPUARMState *env, int irqtype, bool new_state)
> -{
> -    CPUState *cs = env_cpu(env);
> -
> -    /*
> -     * OPT: calling cpu_interrupt() and cpu_reset_interrupt() has the
> -     * correct behaviour, but is not optimal for the case where we're
> -     * setting the interrupt line to the same level it already has.
> -     *
> -     * Clearing an already clear interrupt is free (it's just doing an
> -     * atomic AND operation). Signalling an already set interrupt is a
> -     * bit less ideal (it might unnecessarily kick the CPU).
> -     *
> -     * We could potentially use cpu_test_interrupt(), like
> -     * arm_cpu_update_{virq,vfiq,vinmi,vserr}, since we always hold
> -     * the BQL here; or perhaps there is an abstraction we could
> -     * provide in the core code that all these places could call.
> -     *
> -     * For now, this is simple and definitely correct.
> -     */
> -    if (new_state) {
> -        cpu_interrupt(cs, irqtype);
> -    } else {
> -        cpu_reset_interrupt(cs, irqtype);
> -    }
> -}
> -
>   static void gicv5_update_irq_fiq(CPUARMState *env)
>   {
>       /*

Revisiting this comment:

   * For the moment, we do not consider preemptive interrupts,
   * because these only occur when there is a HPPI of sufficient
   * priority for another interrupt domain, and we only support EL1
   * and the NonSecure interrupt domain currently.

Is there a way to assert preemptive interrupts are not accessed
by the guest?

> @@ -243,12 +216,12 @@ static void gicv5_update_irq_fiq(CPUARMState *env)
>       /*
>        * Unlike a GICv3 or GICv2, there is no external IRQ or FIQ line
>        * to the CPU. Instead we directly signal the interrupt via
> -     * cpu_interrupt()/cpu_reset_interrupt().
> +     * arm_cpu_set_irq().
>        */
>       trace_gicv5_update_irq_fiq(irq, fiq, superpriority);
> -    cpu_interrupt_update(env, CPU_INTERRUPT_HARD, irq);
> -    cpu_interrupt_update(env, CPU_INTERRUPT_FIQ, fiq);
> -    cpu_interrupt_update(env, CPU_INTERRUPT_NMI, superpriority);
> +    arm_cpu_set_irq(env_archcpu(env), ARM_CPU_IRQ, irq);
> +    arm_cpu_set_irq(env_archcpu(env), ARM_CPU_FIQ, fiq);
> +    arm_cpu_set_irq(env_archcpu(env), ARM_CPU_NMI, superpriority);
>   }
>   
>   static void gic_recalc_ppi_hppi(CPUARMState *env)


