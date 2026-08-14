Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 103F0C5CFC1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 17:30:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuvjI-0001AN-F4; Fri, 14 Aug 2026 13:30:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuvjC-00019K-92
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 13:30:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuviy-0001IJ-Mt
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 13:29:57 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67EGi4XV1892636
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 17:29:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pjGyNMPNoHeTAcDpRhLiiiGUx+95h0bBh0bFd+6MOAQ=; b=UXrKYsAfpp8lefxV
 +Ne4Yk7VAmKu5lOBc7vRGlbzNvtr0cgGsSRTpMhkvEBgZMpG/BIQpOXJksQmaq7V
 aE+n4qvsL1NzQAqFCtqItYDSj+AbDtm8NnrTrTInc0lzWxmhB8X3T5MLytD0RRAo
 PdN/4UBfcjJn8FFcGv7QLNQeSP3Vaniatkr9JGgMRW+U3S4iOgFWtuG2tYTd1dIM
 yTf4g1dwfNAwhKjhxmOfu+eta2VCLeMAaKqKYE4UH1jBXt5ILLVZb6fkONd3kfc4
 BU/EmSTR107H35bIgHBR/HWde6bf8VmRZ7qSfqV0Pp479qqNyHwcSpl0WMsSGJIn
 subTGw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g20tr1tpu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 17:29:38 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5174a23afcbso19080661cf.3
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 10:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786728578; x=1787333378; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pjGyNMPNoHeTAcDpRhLiiiGUx+95h0bBh0bFd+6MOAQ=;
 b=dhWPLo0/JtsdmvG2e1EfDTWZ/npa8EKQ3rKWiNTBI+KwE0Jdxr6yqh+ojOLLzeVN2y
 Pxe7Wr6+amaGsDwChJ/tY/pj/b/3grIU2ZVWr9vqZ6T15UwcmWkMWE63IFAmyoGQTBPk
 iCQ+DskzCo0oNQvvDo9HqAmisoVBpYU9hhVqqro/n7mQX21rnKJq2z4H31MdtweNQMrb
 ty6lNTuDsV2tVQsICTte00i8HloDOiJWXFIaczJJWgUkexqdjFCvOJcyq65SxRh5Hnep
 SOLb1uM0Q6NOekQxk+WX8kn4lFQ9zFcDjnkC/jCQS7gQbsOe874OVtBv4jDMnDrGsGdx
 NrAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786728578; x=1787333378;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pjGyNMPNoHeTAcDpRhLiiiGUx+95h0bBh0bFd+6MOAQ=;
 b=JiVsYw39wvcmlB2pZ48AzHA/4kVNRlFovddA9LDWDUK59NiE9qsHAZc032Tkz0Dfgx
 XoEKrxZjtPojqTbjdZp/4d5rW5h4zbKdzAx2/Xp4hFQ99sTThuKrnsixu3op84DLN0Tw
 uwtSf0tq4GcO3YN/9F3lR/AIcVSXbgnQDH85Ix2v8VodDWHif2WrYdDAI9btagWa4MbH
 zHSph2wO9XuDmaquyXsG1QI9aDy87inr4a9382o2Rw4OsH5RzVkYfbHQekVwv5KqpJQs
 /GHivYBslbt/JiiT4/ySOw3xQP4KuCMLWfkJCUEo+yuo+7m2Ip8H7pp12i3G7LPBx0z2
 8xkg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqJAkig1/EInmK6t8im020bDtvxKB0XsLu13/1mIfJenCpBtGWQtxXMwTi/xvXqRa4lnvAdl+2Jxg0s@nongnu.org
X-Gm-Message-State: AOJu0YwYOTMenWwOHzMVDV+cuYJ8BGopa+aMuzfCnxW43AvbSEqLaPwY
 bi7x6+DfMlyskrgbvrQ/K9w+iD4qsakByonRgPseAEphs+DA87RCPreQdcr3z7+GCYExW2/mNuc
 zUcaZVwwGsBlW4H9nR6ksaG8J52sOrNMwv0A0HWM8ZLV9EUjTRndWK4SyrQ==
X-Gm-Gg: AR+sD13yRFTT902TV77spdqnXn4glZb3lADj/nPpxBucy03v+G+pgWl8zQ2NFsyENGh
 HfkmJvxYjr6wC14AYIBRszdLAG7c2e7t8dmhBNiQ5hIODG7OTMve0ejyB5wDeNqJCOmhDYKN5fx
 j2ysVOpJKt7Qt6WxnB8SUWWdMq2UDU/g2IFD+yJvri046w4Iwj0x6TrJGZ2/4SNkqqVYzdUvd5J
 Gxw8hsplFCxF3JIDc3N/IXG25pF3jY4WGxllIHnAY+8M0MrxjP+Dlmagpl9s4hSQfx7+yntgYlE
 5ax8Dpx0SDpumaVtDTLiGM0f+bF9NYPN0uhagWsS1z6Qt99WyEpYzVkybVnVKOS2yVJ0Xqm+9Eu
 ibiLDA2nacpboAlE6GDfMB6fU7d1y0drQK4U=
X-Received: by 2002:a05:622a:258c:b0:528:3157:7a8e with SMTP id
 d75a77b69052e-52d85306756mr93485101cf.9.1786728577501; 
 Fri, 14 Aug 2026 10:29:37 -0700 (PDT)
X-Received: by 2002:a05:622a:258c:b0:528:3157:7a8e with SMTP id
 d75a77b69052e-52d85306756mr93484551cf.9.1786728577004; 
 Fri, 14 Aug 2026 10:29:37 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499877d20fdsm69815545e9.1.2026.08.14.10.29.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2026 10:29:36 -0700 (PDT)
Message-ID: <f9ac74f3-46d9-4958-8635-8c61bff60921@oss.qualcomm.com>
Date: Fri, 14 Aug 2026 19:29:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/28] target/hexagon: Implement wait helper
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 ltaylorsimpson@gmail.com, philmd@linaro.org, Brian Cain <bcain@quicinc.com>
References: <20260529215806.608770-1-brian.cain@oss.qualcomm.com>
 <20260529215806.608770-6-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260529215806.608770-6-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: iCf05XvFsyYKlTOn6CBw37EDAfgR0upe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDEzNCBTYWx0ZWRfX6Yx+kx3c6yFg
 JmKK6gVVdtIIvLdE+E4RGHQSqGOtFkHwMr/5HsKeU4tzFjc5Dmd5tRhanjYVOguFP3hbmry0l65
 +x+rfqTy0mkq2wOSJ/N5SRvWYNed0LN73Ebs13Ttu6JJYu3gtOGGBLKmQQaXtDewpTkXjJjeHSH
 cI6pyzk3yxJBO44yNx/xOmk9eUucRo6uSzwRurv9R058xVe/GPcuXyHP7kJHXz/zl4k8dBJ7PrT
 DyhcNUBjhMLEHiJ5mjXYu//Iom+jeBmVXcUToIdiHOKB4Ct06r5mjrgSppYi38IpXaIvXGSAPA3
 logBmt1Ur0bPnFqeQ7mdLKYsRrRKRNgFOS6Q48aeZX3VaWgTh+1b65q7cRkd6wVqtI3sTxNSjm1
 c2KWo8XOg5D7NP3Rn6pj9+hruwzfDqjVxAlZSWzWHvHZhEEABo5Nz+rdcCjjYV/K0Iq+opIVCBe
 vuizTTHokpYhKfrBAug==
X-Authority-Analysis: v=2.4 cv=UrdT8ewB c=1 sm=1 tr=0 ts=6a7f5082 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=cx-pe_VNRN6YLnWPiOkA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: iCf05XvFsyYKlTOn6CBw37EDAfgR0upe
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDEzNCBTYWx0ZWRfX5FkOZ7V7j+Fg
 Sc+L1ge/eHnGcoRSp11fZ8WimcZbysAbrZHs84Uyuyr4CrMHu+6pjUtwUt/tVH16P0OqE2m8kpj
 dMhb3z1q4bwLL2qjZfnBDJGe3T55zu4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608140134
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

Hi Brian, Taylor,

(now committed as acd2b7a2f19ac04bd313e816e5f9e7f87adc9858)

On 29/5/26 23:57, Brian Cain wrote:
> From: Brian Cain <bcain@quicinc.com>
> 
> Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/gen_tcg_sys.h |  2 +-
>   target/hexagon/op_helper.c   | 60 ++++++++++++++++++++++++++++++++++--
>   2 files changed, 59 insertions(+), 3 deletions(-)
> 
> diff --git a/target/hexagon/gen_tcg_sys.h b/target/hexagon/gen_tcg_sys.h
> index 000fc415c74..98cf6216780 100644
> --- a/target/hexagon/gen_tcg_sys.h
> +++ b/target/hexagon/gen_tcg_sys.h
> @@ -80,7 +80,7 @@
>   #define fGEN_TCG_Y2_wait(SHORTCODE) \
>       do { \
>           RsV = RsV; \
> -        gen_helper_wait(tcg_env, tcg_constant_tl(ctx->pkt->pc)); \
> +        gen_helper_wait(tcg_env, tcg_constant_tl(ctx->pkt.pc)); \
>       } while (0)
>   
>   #define fGEN_TCG_Y2_resume(SHORTCODE) \
> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
> index 235c70f7370..d40061de06e 100644
> --- a/target/hexagon/op_helper.c
> +++ b/target/hexagon/op_helper.c
> @@ -1486,9 +1486,65 @@ void HELPER(stop)(CPUHexagonState *env)
>       hexagon_stop_thread(env);
>   }
>   
> -void HELPER(wait)(CPUHexagonState *env, target_ulong PC)
> +static void set_wait_mode(CPUHexagonState *env)
>   {
> -    g_assert_not_reached();
> +    HexagonCPU *cpu;
> +    uint32_t modectl;
> +    uint32_t thread_wait_mask;
> +
> +    g_assert(bql_locked());
> +
> +    cpu = env_archcpu(env);
> +    if (!cpu->globalregs) {
> +        return;
> +    }
> +    modectl =
> +        hexagon_globalreg_read(cpu->globalregs, HEX_SREG_MODECTL,
> +                               env->threadId);
> +    thread_wait_mask = GET_FIELD(MODECTL_W, modectl);
> +    thread_wait_mask |= 0x1 << env->threadId;
> +    SET_SYSTEM_FIELD(env, HEX_SREG_MODECTL, MODECTL_W, thread_wait_mask);
> +}
> +
> +static void hexagon_wait_thread(CPUHexagonState *env, uint32_t PC)
> +{
> +    CPUState *cs;
> +
> +    g_assert(bql_locked());
> +
> +    if (qemu_loglevel_mask(LOG_GUEST_ERROR) &&
> +        (env->k0_lock_state != HEX_LOCK_UNLOCKED ||
> +         env->tlb_lock_state != HEX_LOCK_UNLOCKED)) {
> +        qemu_log("WARNING: executing wait() with acquired lock"
> +                 "may lead to deadlock\n");
> +    }
> +    g_assert(get_exe_mode(env) != HEX_EXE_MODE_WAIT);
> +
> +    cs = env_cpu(env);
> +    /*
> +     * The addtion of cpu_has_work is borrowed from arm's wfi helper
> +     * and is critical for our stability

Could you explain this comment?

> +     */
> +    if ((cs->exception_index != HEX_EVENT_NONE) ||
> +        (cpu_has_work(cs))) {
> +        qemu_log_mask(CPU_LOG_INT,
> +            "%s: thread %" PRIu32 " skipping WAIT mode, have some work\n",
> +            __func__, env->threadId);
> +        return;
> +    }
> +    set_wait_mode(env);
> +    env->wait_next_pc = PC + 4;
> +
> +    cpu_interrupt(cs, CPU_INTERRUPT_HALT);
> +}
> +
> +void HELPER(wait)(CPUHexagonState *env, uint32_t PC)
> +{
> +    BQL_LOCK_GUARD();
> +
> +    if (!fIN_DEBUG_MODE(env->threadId)) {
> +        hexagon_wait_thread(env, PC);
> +    }
>   }
>   
>   void HELPER(resume)(CPUHexagonState *env, uint32_t mask)


