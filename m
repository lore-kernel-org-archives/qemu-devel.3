Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00714C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 18:50:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuyTq-0007Ew-C9; Wed, 19 Mar 2025 14:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tuyTo-0007Ed-Tk
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 14:49:28 -0400
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tuyTm-0007na-Nh
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 14:49:28 -0400
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-46fcbb96ba9so403911cf.0
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 11:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742410166; x=1743014966; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=8vjIRVfqJ2k7Fi207AjW2JPxOJvBgu46Cytq1enZvR4=;
 b=AvTC5S97YxRoKWfHq6Z5JuOWpoir+8j9GS5KUHOr4PrY9esLvwyzNtnTO5IUO08tOn
 wLkls+e+qa3m8bD2IyBkbJyVNS+pOmTokMcfOGl/KeMYYwhAw4pTpCrzph6uIRvpZ7/a
 /Rf1l+gU7eScuX0SCq29XpNZvH47pPhW/NkDblkP4W4uQBXCDCioHjQO/Q4blap7maRB
 kVXzTBPsE5qWOPOtrRfQ2kxqiQbbn1YwOqbSTOyPI2AnW0tDE7yu8to1fSzKyrk3LSnw
 QeKr4h4skWPIMdAfl1LIAy5Qs8CaSca1ZUPDIh+4tfv2Uvyk9vX2Lk8D9tQ2wLqFeoyb
 IvoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742410166; x=1743014966;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8vjIRVfqJ2k7Fi207AjW2JPxOJvBgu46Cytq1enZvR4=;
 b=QqqJgcZrfRX5haxQ9pm5isIbV9/Kff6J6uW/ns457voxfmSVDqZ2JQVQbI3R9MIkUp
 hkcg8E4DjzFsoCv3C8Z/EHZ/VLh1WGaqZR+VXRfQ8Aq/p+YOvSPENvyjiPTf8tE7NA4z
 LbIvrLUXG7IhOiu7vb6OnDANmPD88E/TGdM5LpCvYfqX8avzuyleYaswPupECmjAwhgl
 SsyOQWEBROVg8gOgtDF3sjLhEXVh59owcnv0BvLi1T1UGeFxAlLEZvBzzbo2cL+aUG28
 9K3VPkTjObX6QZaYeX/91QahK1IsjuJCVLy+9L0B8XPKU2VWj/DgTAYasgGNHiwLPkLU
 837g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaww+iYSaJvVDfDr6Abbj0H341SUZRx4oV7ef5b3JrebyAKIjlfnliXUck7BIgBPdFZIr2qw6igRE8@nongnu.org
X-Gm-Message-State: AOJu0Yz3sTEezNRkr+GoqypiPKt5++wrorNHeyzhUp+OtG7Yc/hQkUvc
 O7Wgpa1LM+3kiGlLMbLvkw3NiuNymOW50xq0N9Khy3QRelA6UEVU
X-Gm-Gg: ASbGncuIaKpaNPBm6/Iw/KAi0z5papwq0glWGUbElUACQIvc5PfMQb09Jpyb8IOO7Vs
 EKgjeCa55N1DO+8e/t67YeMo10JWpFGFLY7SjBIwI6YTGGnK9W5BHMSb9ayoAjP7N6vqIedB5F/
 aV7HxbFUcJVI335lmL4xr/S6stqwDNpu/KifERS0lB0A3YMhvhT4GDHe0Sw0RAs2H/AOQOJBoE9
 mLZT13+NiMH8Gu5w4oqxeAL3feKbD43pRB/HjVi7n2AF0NYZ9qr0OAjdiXT7F5/K9N7rt9dlApR
 TVvu0ZSnjf7/9egEzi+DX1PbEfGVrIuuuOFNsvj1xogWCuN8L/8faUMCN7F2yMvWQWzigs9m
X-Google-Smtp-Source: AGHT+IE4vNguIcCuWp+n2rQpgUXEczE0EvuPlS/ypMuzntZ0+PDCTebAZdJCY2/MGcoPNdWuo2zsUw==
X-Received: by 2002:a05:6214:c6a:b0:6d8:850a:4d6a with SMTP id
 6a1803df08f44-6eb29284aadmr49104926d6.1.1742410165696; 
 Wed, 19 Mar 2025 11:49:25 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:992d:4509:eca7:6f8])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6eade254502sm83477696d6.59.2025.03.19.11.49.24
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 19 Mar 2025 11:49:25 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-40-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052845.1012069-40-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 39/39] target/hexagon: Add pcycle setting functionality
Date: Wed, 19 Mar 2025 13:49:23 -0500
Message-ID: <02cd01db98ff$a295cb90$e7c162b0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIWUu77rEigiK0ljjjo9ZdCZqs5mQKFqcs0svEo52A=
Content-Language: en-us
X-Antivirus: Norton (VPS 250319-0, 3/18/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::82d;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qt1-x82d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



> -----Original Message-----
> From: Brian Cain <brian.cain@oss.qualcomm.com>
> Sent: Friday, February 28, 2025 11:29 PM
> To: qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sidneym@quicinc.com
> Subject: [PATCH 39/39] target/hexagon: Add pcycle setting functionality
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> ---
>  target/hexagon/cpu.c        | 10 +++++++---
>  target/hexagon/cpu_helper.c | 17 ++++++++++++++---
>  2 files changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c index
> 80f5e23794..4ca6add834 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -440,19 +440,23 @@ static void hexagon_cpu_realize(DeviceState *dev,
> Error **errp)  #endif
> 
>      qemu_init_vcpu(cs);
> -#ifndef CONFIG_USER_ONLY
>      CPUHexagonState *env = cpu_env(cs);
> +#ifndef CONFIG_USER_ONLY
>      hex_mmu_realize(env);
>      if (cs->cpu_index == 0) {
>          env->g_sreg = g_new0(target_ulong, NUM_SREGS);
> -        env->g_pcycle_base = g_malloc0(sizeof(*env->g_pcycle_base));
>      } else {
>          CPUState *cpu0 = qemu_get_cpu(0);
>          CPUHexagonState *env0 = cpu_env(cpu0);
>          env->g_sreg = env0->g_sreg;
> -        env->g_pcycle_base = env0->g_pcycle_base;
>      }
>  #endif
> +    if (cs->cpu_index == 0) {
> +        env->g_pcycle_base = g_malloc0(sizeof(*env->g_pcycle_base));

Another shared resource ...

> +    } else {
> +        CPUState *cpu0 = qemu_get_cpu(0);
> +        env->g_pcycle_base = cpu_env(cpu0)->g_pcycle_base;
> +    }
> 
>      mcc->parent_realize(dev, errp);
>  }
> diff --git a/target/hexagon/cpu_helper.c b/target/hexagon/cpu_helper.c
> index 9c44cb7950..08c749e9fa 100644
> --- a/target/hexagon/cpu_helper.c
> +++ b/target/hexagon/cpu_helper.c
> @@ -70,18 +70,29 @@ uint32_t
> hexagon_get_sys_pcycle_count_low(CPUHexagonState *env)  void
> hexagon_set_sys_pcycle_count_high(CPUHexagonState *env,
>          uint32_t cycles_hi)
>  {
> -    g_assert_not_reached();
> +    uint64_t cur_cycles = hexagon_get_sys_pcycle_count(env);
> +    uint64_t cycles =
> +        ((uint64_t)cycles_hi << 32) | extract64(cur_cycles, 0, 32);
> +    hexagon_set_sys_pcycle_count(env, cycles);
>  }
> 
>  void hexagon_set_sys_pcycle_count_low(CPUHexagonState *env,
>          uint32_t cycles_lo)
>  {
> -    g_assert_not_reached();
> +    uint64_t cur_cycles = hexagon_get_sys_pcycle_count(env);
> +    uint64_t cycles = extract64(cur_cycles, 32, 32) | cycles_lo;
> +    hexagon_set_sys_pcycle_count(env, cycles);
>  }
> 
>  void hexagon_set_sys_pcycle_count(CPUHexagonState *env, uint64_t
> cycles)  {
> -    g_assert_not_reached();

Do we need a lock here?

> +    *(env->g_pcycle_base) = cycles;
> +
> +    CPUState *cs;
> +    CPU_FOREACH(cs) {
> +        CPUHexagonState *env_ = cpu_env(cs);

This underscore is easy to miss.  Just
    cpu_env(cs)->t_cycle_count = 0;




