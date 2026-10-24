Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D483F606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 11:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YaQOXfAg;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=d3S5PFFI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKZlI-0000dD-H2; Sat, 24 Oct 2026 07:18:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKZlG-0000cu-Ml
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 07:18:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKZlE-00042h-Ce
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 07:18:06 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69O8ofcE611518
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 11:18:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sDHwzreOrnxp3I8hXsiGwffDw0sSpuPf1laiyzjinFs=; b=YaQOXfAgxDcil9I+
 dbBFV7m7aZA6CR9yaMQ10iKR4ZUvTy3oIRWpHSLsxpdgEnDSrT77ayDHRJkdAgYw
 +18JkawoyqYosm2J4t3wvUaf/Mmni59qpBYRT/alpLuAulDI9EuuDllWLiSsjYlj
 XBGV8Bhyh0bbUPWX+NPp5N1nHrZKq/ucrcdsCYUYJfhH9/8qVkaOqXPbz8ieLUUv
 Q9Qyml3S7X/oTQ5mZlk1nxkjEdihHQ+0a+cNhy1uzpOGH9ZlK3GKb1qktTwuZzIc
 B1ZKYN7HJl5Z2KTu9MrfGsDp8EsKFnxYCqw9mlbggbgLp4IEmMTFhCDNi/IBHZyP
 +vOqHg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgnehgqeg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 11:18:01 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-936aa34873bso336004885a.3
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 04:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792840681; x=1793445481; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sDHwzreOrnxp3I8hXsiGwffDw0sSpuPf1laiyzjinFs=;
 b=d3S5PFFI93xqVutpP3GQCvN0rlL6JQUeO+8vpsS2j+QNzqE83tBPlwNn+72KWF37XT
 ZJnM4+Z/wYvuqzXf9xbf9JCN3sj5rI3UYkr0wRI7nt4zdJONx6IRGxtdRIGte08Ia0wA
 6B/LL0Sgc1L7wEVZakH/smwEiSsf8lVxQd+28wAmXBbouenO3gl44/962liYJC8BeA3I
 Hxcs+rCWJgDQlPNOhQ7G0H5U8nBs7He5xN7wDCCVb4MlK1thpW0DgPmqZtu7VaDy4v+H
 MGrfze0yW9r8z+eBHiurQWsALVsm8YViaAISYz8YEVIkLw5ATzsG0es6S2eNzLVuEeNr
 pKXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792840681; x=1793445481;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sDHwzreOrnxp3I8hXsiGwffDw0sSpuPf1laiyzjinFs=;
 b=sXVVeLgx/tsjWVHqwsTb7MzFRi60NM70GTlHN1g2gtGzWDnuTPnffAbGXH+1oZhIoR
 XLZQU8Uznk5b9dDvY6Ys4e+0T4a9iOFMeaVVZkElih5WlKsKkW4DaWXtsas/BMRJuipl
 DSFUfCY+QdWCdn44JQoTrW/xwFRv4QRhfH1pQZytwEear1MRKz7AFVnQAzIs3I1J1Fj2
 OYvwh/8kIaZWVf1fEg9SXNcOZTDrn2Wql3g7sipMWgoVBZG45tv0h4oIwD2hdRlkUiLs
 sh/0KI5DNE3Jm9SnZ3kpplNfY9/yZEHFFYhtKKgYRyjNqaFjN2A/97qJbKk7Od6mRE15
 LIXQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy32K3OsTwR6CqOFkTSOXGOgKeS8zNZipU6Huu11yar27w9PqUqj6v2y7Se8Djdu6hTPedZVeAjLUHB@nongnu.org
X-Gm-Message-State: AFq9FYJfvfb0YdCMPoqsWUTlTIWJmS+zvX6MEVVt9AlT4e0cBrPQXhKE
 6rsHWoZrCuZu/7083xl9T6EnqH/izifEHx6+z6Gw6ut9hq2HU+Uav38hYIc85obMBO8EIq3Ohu0
 V94WO2+RTUlaErw9QGc4uzCvLLzwPWSy0IKXO3Q/41VtVOVVHVolIB1N0jA==
X-Gm-Gg: AYBFou1iTIsU6hoMJb89nzMSoi/ftJxdgjNuCQWIskyZ/W9Kfxs7hzAhOX77k+YIGzP
 5tY7C2i/2WqNu9OANOrAexuot3/+FruErafw00fVssVPr/vAa98JoyLtrmCLZM7tXkHHG6LfBSc
 VsUdX/AQkUJGZzUGZrCrfBOowQduH04tR4J1ykJHjlMkUpjUvE2svrsAOznEuyUY/xWrStYSXwe
 2ZXVye+dD4Y0M4NwATGLn9vhkB5Oh9F2AQL6bN4TcHLr3kfGu9RUY3x2fYPHNxbP/ZK9j8KtqPv
 f68QAIrmjcfrdYFhwroHnkPCw7n+IAVDwBibVATD+9A1kztqL1h+FlE7i1VmBwOnVGI7JWeQlYA
 9khfs3b5lnWDckYyDZ1CKCD9og7ukIS+sVg==
X-Received: by 2002:a05:620a:4151:b0:93f:31bb:e31 with SMTP id
 af79cd13be357-940ef97b7c3mr210156385a.48.1792840680534; 
 Sat, 24 Oct 2026 04:18:00 -0700 (PDT)
X-Received: by 2002:a05:620a:4151:b0:93f:31bb:e31 with SMTP id
 af79cd13be357-940ef97b7c3mr210153385a.48.1792840680018; 
 Sat, 24 Oct 2026 04:18:00 -0700 (PDT)
Received: from [192.168.69.208] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb958sm3795724f8f.21.2026.10.24.04.17.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2026 04:17:58 -0700 (PDT)
Message-ID: <52174128-738d-470a-91e3-f3182b67bd55@oss.qualcomm.com>
Date: Sat, 24 Oct 2026 13:17:57 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] hw/timer: add TriCore System Timer Module (STM)
Content-Language: en-US
To: Parthiban Nallathambi <parthiban@linumiz.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Saravanan Sekar <saravanan@linumiz.com>,
 Dineshkumar Selvaraj <Dineshkumar.Selvaraj@infineon.com>,
 Christoph Seitz <christoph.seitz@infineon.com>,
 Sivashanmugam Natarajan <Sivashanmugam.Natarajan@infineon.com>
References: <20261024-dev-ifx-tricore-upstream-rebase-minimal-v2-0-c722e4ca5661@linumiz.com>
 <20261024-dev-ifx-tricore-upstream-rebase-minimal-v2-5-c722e4ca5661@linumiz.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261024-dev-ifx-tricore-upstream-rebase-minimal-v2-5-c722e4ca5661@linumiz.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA0NCBTYWx0ZWRfX/2T1sdtFG6sV
 iaA2jA6Pkkx23inMxjgxygReCnjaUK9xoy9dKOz0XJbKUBhamMxDTWicMYOuaFLxX5LlXJwtHZr
 pStRmcwm2bRUvvsyFVfkwQ+FxYpdNrs=
X-Proofpoint-ORIG-GUID: Xcha86a4XI9ZTWE7nq39hBUpPoveDR-J
X-Authority-Analysis: v=2.4 cv=d5tgWhjE c=1 sm=1 tr=0 ts=6adc93e9 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=bUQKSiCPAAAA:8 a=vU9dKmh3AAAA:8 a=DHUwBXDL6zMHFvHmj1EA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=-fHZXUhsFbuwFN3fwQAr:22 a=rsP06fVo5MYu2ilr0aT5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA0NCBTYWx0ZWRfX5zO/VTzA+FpH
 sd5mlqbwDEaxp90worgXj2N9SqxRBb6nMjMB5sr1cM70fB9w1JWHQ3sZnGvVZr0q53shHxvaBuN
 /RLU97IRyx7wIMjFvQGMO0tcntr8ZphvLzmo7RhK/nYQQZTqVzwrtY8zzQUkEb+ZLbkpUVEWDx2
 R92BrGkgAXbVBJnJ+UD9fzBcMeHEpd78AkftMh8np4tBCCiOHdHV5pV3hiVPuVgh0vaVDH53N7k
 LuK9HZM9XhZsPDoO71Yl4L55BRebMe/r3nfVFZi/Or3sjjF5tuV3dbd+/UVH8UDn9TITr8HjEsr
 rGPjLvem15JbVyItQQQa629UuwXd9h8XgcLxUwdPD4zb8cAdTPEFYyPm5mOxHllW0/T9mZQg60W
 yPYG6DxDDawiucw3LhasXEA9rUzcF0NMrl7veCrrOZ6Zcfk8wD2M8pIWMtTITFzkN8AsQ4DpF8s
 EBtnnmabfYFqDKHMN/A==
X-Proofpoint-GUID: Xcha86a4XI9ZTWE7nq39hBUpPoveDR-J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 adultscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240044
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 23/10/26 22:11, Parthiban Nallathambi wrote:
> Free-running 64-bit counter with compare match interrupt.
> TIM0..TIM6 give shifted views of the counter, CMP0 fires
> when the masked counter matches the programmed value.
> 
> Originally-by: Christoph Seitz <christoph.seitz@infineon.com>
> Signed-off-by: Parthiban Nallathambi <parthiban@linumiz.com>
> ---
>   MAINTAINERS                    |   2 +
>   hw/timer/Kconfig               |   3 +
>   hw/timer/meson.build           |   1 +
>   hw/timer/tricore_stm.c         | 365 +++++++++++++++++++++++++++++++++++++++++
>   include/hw/timer/tricore_stm.h |  34 ++++
>   5 files changed, 405 insertions(+)

> +static void tricore_stm_tim_update(TriCoreSTMState *s)
> +{
> +    int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +
> +    s->tim_counter += clock_ns_to_ticks(s->fstm, now - s->tim_base_ns);
> +    s->tim_base_ns = now;
> +}
> +
> +static void tricore_stm_timer_update(TriCoreSTMState *s)
> +{
> +    uint32_t mstart = (s->regs[R_CMCON] & MASK_CMCON_MSTART0) >> 8;
> +    uint32_t msize = s->regs[R_CMCON] & MASK_CMCON_MSIZE0;
> +    uint32_t nbits = msize + 1;
> +    uint64_t tim_target = s->tim_counter;
> +
> +    if (!(s->regs[R_ICR] & MASK_ICR_CMP0EN) &&
> +        (s->regs[R_ICR] & MASK_ICR_CMP0IR)) {
> +        return;

Please add a comment explaining this early return.
Why not return for masked CMP1?

> +    }
> +
> +    /* Calculate the target TIM value */
> +    if (mstart) {
> +        tim_target = deposit64(tim_target, 0, mstart, 0);
> +    }
> +    tim_target = deposit64(tim_target, mstart, nbits,
> +                           (uint64_t)s->regs[R_CMP0]);
> +
> +    /* Wrap around if needed */
> +    if (tim_target <= s->tim_counter) {
> +        tim_target += (1ULL << (mstart + nbits));
> +    }
> +
> +    timer_mod(s->timer,
> +              s->tim_base_ns +
> +              clock_ticks_to_ns(s->fstm, tim_target - s->tim_counter));
> +}
> +
> +static void tricore_stm_clock_update(void *opaque, enum ClockEvent event)
> +{
> +    TriCoreSTMState *s = TRICORE_STM(opaque);
> +
> +    if (event == ClockPreUpdate) {
> +        tricore_stm_tim_update(s);
> +    } else {
> +        tricore_stm_timer_update(s);
> +    }
> +}
> +
> +static void tricore_stm_write(void *opaque, hwaddr offset,
> +                              uint64_t value, unsigned size)
> +{
> +    TriCoreSTMState *s = TRICORE_STM(opaque);
> +    hwaddr reg_addr = offset >> 2;
> +
> +    switch (reg_addr) {
> +    case R_CLC:
> +    case R_ID:
> +    case R_TIM0:
> +    case R_TIM1:
> +    case R_TIM2:
> +    case R_TIM3:
> +    case R_TIM4:
> +    case R_TIM5:
> +    case R_TIM6:
> +    case R_CAP:
> +        s->regs[reg_addr] = value;

Aren't these read-only?

> +        break;
> +    case R_CMP0:
> +        s->regs[reg_addr] = value;
> +        tricore_stm_tim_update(s);
> +        tricore_stm_timer_update(s);
> +        break;
> +    case R_CMP1:
> +    case R_ICR:
> +        s->regs[reg_addr] = value;
> +        tricore_stm_timer_update(s);
> +        break;
> +    case R_CMCON:
> +        s->regs[reg_addr] = value;
> +        tricore_stm_tim_update(s);
> +        tricore_stm_timer_update(s);
> +        break;
> +    case R_ISCR:
> +        if (value & MASK_ISCR_CMP0IRR) {
> +            qatomic_and(&s->regs[R_ICR], ~MASK_ICR_CMP0IR);
> +        }
> +        if (value & MASK_ISCR_CMP1IRR) {
> +            qatomic_and(&s->regs[R_ICR], ~MASK_ICR_CMP1IR);
> +        }
> +        if (value & MASK_ISCR_CMP0IRS) {
> +            qatomic_or(&s->regs[R_ICR], MASK_ICR_CMP0IR);
> +        }
> +        if (value & MASK_ISCR_CMP1IRS) {
> +            qatomic_or(&s->regs[R_ICR], MASK_ICR_CMP1IR);
> +        }
> +        tricore_stm_timer_update(s);
> +        break;
> +    case R_TIM0SV:
> +    case R_CAPSV:
 > +    case R_OCS:> +    case R_KRSTCLR:
> +    case R_KRST1:
> +    case R_KRST0:
> +    case R_ACCEN1:
> +    case R_ACCEN0:
> +        s->regs[reg_addr] = value;
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP,
> +                      "tricore_stm: write to unknown register 0x%"
> +                      HWADDR_PRIx "\n", offset);
> +        break;
> +    }
> +}
> +
> +static uint64_t tricore_stm_read(void *opaque, hwaddr offset,
> +                                 unsigned size)
> +{
> +    TriCoreSTMState *s = TRICORE_STM(opaque);
> +    uint64_t r = 0;
> +    hwaddr reg_addr = offset >> 2;
> +
> +    if ((reg_addr >= R_TIM0 && reg_addr <= R_TIM6) ||
> +        reg_addr == R_TIM0SV) {
> +        tricore_stm_tim_update(s);
> +        s->regs[R_CAP] = (uint32_t)(s->tim_counter >> 32);
> +    }
> +
> +    switch (reg_addr) {
> +    case R_CLC:
> +    case R_ID:
> +        r = s->regs[reg_addr];
> +        break;
> +    case R_TIM0:
> +    case R_TIM1:
> +    case R_TIM2:
> +    case R_TIM3:
> +    case R_TIM4:
> +    case R_TIM5:
> +    case R_TIM6:
> +        r = s->tim_counter << (reg_addr - R_TIM0) * 4;

'>>' I suppose? Meaning this path isn't well tested.

> +        break;
> +    case R_CAP:
> +        r = s->regs[R_CAP];
> +        break;
> +    case R_ISCR:
> +        r = 0;
> +        break;
> +    case R_CMP0:
> +    case R_CMP1:
> +    case R_CMCON:
> +    case R_ICR:
> +        r = s->regs[reg_addr];
> +        break;
> +    case R_TIM0SV:
> +        r = s->tim_counter;
> +        break;
> +    case R_CAPSV:
> +        r = s->regs[R_CAP];
> +        break;
> +    case R_OCS:
> +    case R_KRSTCLR:
> +    case R_KRST1:
> +    case R_KRST0:
> +    case R_ACCEN1:
> +    case R_ACCEN0:
> +        r = s->regs[reg_addr];
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP,
> +                      "tricore_stm: read from unknown register 0x%"
> +                      HWADDR_PRIx "\n", offset);
> +        r = 0;
> +        break;
> +    }
> +
> +    return r;
> +}
> +
> +static void tricore_stm_reset(DeviceState *dev)
> +{
> +    TriCoreSTMState *s = TRICORE_STM(dev);
> +
> +    s->regs[R_CLC] = RESET_TRICORE_STM_CLC;
> +    s->regs[R_ID] = RESET_TRICORE_STM_ID;
> +    s->regs[R_TIM0] = RESET_TRICORE_STM_TIM0;
> +    s->regs[R_TIM1] = RESET_TRICORE_STM_TIM1;
> +    s->regs[R_TIM2] = RESET_TRICORE_STM_TIM2;
> +    s->regs[R_TIM3] = RESET_TRICORE_STM_TIM3;
> +    s->regs[R_TIM4] = RESET_TRICORE_STM_TIM4;
> +    s->regs[R_TIM5] = RESET_TRICORE_STM_TIM5;
> +    s->regs[R_TIM6] = RESET_TRICORE_STM_TIM6;
> +    s->regs[R_CAP] = RESET_TRICORE_STM_CAP;
> +    s->regs[R_CMP0] = RESET_TRICORE_STM_CMP0;
> +    s->regs[R_CMP1] = RESET_TRICORE_STM_CMP1;
> +    s->regs[R_CMCON] = RESET_TRICORE_STM_CMCON;
> +    s->regs[R_ICR] = RESET_TRICORE_STM_ICR;
> +    s->regs[R_ISCR] = RESET_TRICORE_STM_ISCR;
> +    s->regs[R_TIM0SV] = RESET_TRICORE_STM_TIM0SV;
> +    s->regs[R_CAPSV] = RESET_TRICORE_STM_CAPSV;
> +    s->regs[R_OCS] = RESET_TRICORE_STM_OCS;
> +    s->regs[R_KRSTCLR] = RESET_TRICORE_STM_KRSTCLR;
> +    s->regs[R_KRST1] = RESET_TRICORE_STM_KRST1;
> +    s->regs[R_KRST0] = RESET_TRICORE_STM_KRST0;
> +    s->regs[R_ACCEN1] = RESET_TRICORE_STM_ACCEN1;
> +    s->regs[R_ACCEN0] = RESET_TRICORE_STM_ACCEN0;
> +
> +    s->tim_counter = 0;
> +    s->tim_base_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);

        timer_del(s->timer);

> +}
> +
> +static const MemoryRegionOps tricore_stm_ops = {
> +    .read = tricore_stm_read,
> +    .write = tricore_stm_write,
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +    },
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +};
> +
> +static void tricore_stm_timer_hit(void *opaque)
> +{
> +    TriCoreSTMState *s = TRICORE_STM(opaque);
> +
> +    qatomic_or(&s->regs[R_ICR], MASK_ICR_CMP0IR);
> +
> +    if (s->regs[R_ICR] & MASK_ICR_CMP0EN) {
> +        qemu_irq_pulse(s->irq);

I'm confused with the CMP1. If no need to model it, we should
mention it and log the accesses as UNIMPLEMENTED.

> +    }
> +
> +    tricore_stm_tim_update(s);
> +    tricore_stm_timer_update(s);
> +}
> +
> +static void tricore_stm_realize(DeviceState *dev, Error **errp)
> +{
> +    TriCoreSTMState *s = TRICORE_STM(dev);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +
> +    s->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, tricore_stm_timer_hit, s);

(IIUC only CMP0 is modelled, it could be clearer to have 2 compare
  timers, or at least rename this one).
> +    s->tim_base_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +    s->tim_counter = 0;
> +
> +    sysbus_init_mmio(sbd, &s->iomem);
> +    sysbus_init_irq(sbd, &s->irq);

We need to check s->fstm clock is connected (clock_has_source),
otherwise the timer will never run, ticking at 0 Hz.

> +}
> +
> +static void tricore_stm_init(Object *obj)
> +{
> +    TriCoreSTMState *s = TRICORE_STM(obj);
> +
> +    memory_region_init_io(&s->iomem, OBJECT(s), &tricore_stm_ops, s,
> +                          "tricore_stm", 0x100);
> +    s->fstm = qdev_init_clock_in(DEVICE(s), "fstm",
> +                                 tricore_stm_clock_update, s,
> +                                 ClockPreUpdate | ClockUpdate);
> +}
> +
> +static void tricore_stm_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->legacy_reset = tricore_stm_reset;

Again, no more legacy_reset. Please convert to ResettableHold.

> +    dc->realize = tricore_stm_realize;

Better if tim_counter, tim_base_ns, regs and the timer are in VMState.

> +}
> +
> +static const TypeInfo tricore_stm_info = {
> +    .name = TYPE_TRICORE_STM,
> +    .parent = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(TriCoreSTMState),
> +    .instance_init = tricore_stm_init,
> +    .class_init = tricore_stm_class_init,
> +};
> +
> +static void tricore_stm_register_types(void)
> +{
> +    type_register_static(&tricore_stm_info);
> +}


