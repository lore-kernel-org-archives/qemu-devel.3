Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C947DC25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 13:50:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEUYZ-0007Wp-KO; Tue, 04 Jun 2024 09:50:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEUYY-0007JK-1T
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:50:30 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEUYV-0003Cl-R3
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:50:29 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-62a145e0bb2so54764187b3.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 06:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717509026; x=1718113826; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dB59hXZL7t0H82RGgEdW7zN+NbFcCSWihF1p0urT8gA=;
 b=ln2vUumgTIg5Zu/EtJjcFHPsvwMoBPwYKwThoCDkGrlTuknilBgwzgBDNBT8zLOK5B
 1ZL8JPaH6zxgS/sGIiQ9FexVHON9B3AuuYTxXy26jdj5lGFiryRr++ntQ8YYJPDDBPJs
 1VafBMWnve0ybG5IJx45k8nOMB4pwfEHC/P96lethaf595ctgx0ytENAMC8SOyVRvJOF
 AW9htbcG+TOJsQEK+aiBhDw93+4ghm85JtVy3U46S6BKe6nlEXAdMmVmc3O2rEgoiR2a
 5jI79u6lyEhlXGiVh7fBvzpKvbdg5LnzbLNqz55ZNUx+b4TFMrm96PmJYapWIANEmYxJ
 vZvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717509026; x=1718113826;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dB59hXZL7t0H82RGgEdW7zN+NbFcCSWihF1p0urT8gA=;
 b=uoiFZQo8Z0A3K5TJdBpm03QwMdNM78o4onsYy0sjplUp/AOGWFQTeAcoRqdz8AbO3l
 Aga9QR9IoHZzS9wN6Zzb80pFw/b3f6+6eN3E0k2cg/HQIBox/MlDXhMsZBkMLgmae71H
 I0c8baF5w93/sEXbwc4juLRlSqEVWnHVbYLqaovXuNskgEn8hfObLyEjvwMLLaYXOEFv
 RIQugLOm2KdTMEU8utQWPwsam+kZZYQoLD/GroRuqK4PfoRY6bdrd4fIp7fnUWMVGYGD
 n+STBf7FL42fxJadNLPvh0ZOBHp20cDX0huMxe27Ja0E7F8qSr1+f+nhlbzhwF+JRgQQ
 xBWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6F/0tl6VwKR0t8rhA/TngWOO8OlMjxYOBELiiJuEhR2vFTZsfcs6Lo3lFGo3cwJg1BAPRRkSGCk9QIWXorbXXQ0KY9Ig=
X-Gm-Message-State: AOJu0YzDAWut8jV66n4ROYK5EIugspejKv1ERPiVkIuK0PN3kIGLiZ7Z
 EJGFeQPvRhpc+YbihkWWCpp46fBr4aSHB8C2B53dPW2RXlutST7KIrPcKNDn3pUDUdJNAHzYdV2
 t
X-Google-Smtp-Source: AGHT+IHtQA9cPWQuVm+T2ME76qUDkzxVOCncYTaXXayFnSMwWMNS3OjflcbQqwu5ayb+UATqN/8cCQ==
X-Received: by 2002:a81:7143:0:b0:615:c96:1a8d with SMTP id
 00721157ae682-62c7967cce1mr122405647b3.8.1717509026344; 
 Tue, 04 Jun 2024 06:50:26 -0700 (PDT)
Received: from ?IPV6:2607:fb91:1aca:c697:b7cb:e0ad:8679:2c14?
 ([2607:fb91:1aca:c697:b7cb:e0ad:8679:2c14])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-62c766857d2sm18178297b3.83.2024.06.04.06.50.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 06:50:26 -0700 (PDT)
Message-ID: <491c8af0-dc2c-4ae3-8624-f594e3a372b8@linaro.org>
Date: Tue, 4 Jun 2024 08:50:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] target/i386: fix implementation of ICEBP
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240604071833.962574-1-pbonzini@redhat.com>
 <20240604071833.962574-3-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240604071833.962574-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x112a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/4/24 02:18, Paolo Bonzini wrote:
> ICEBP generates a trap-like exception, while gen_exception() produces
> a fault.  Resurrect gen_update_eip_next() to implement the desired
> semantics.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/helper.h          |  1 +
>   target/i386/tcg/helper-tcg.h  |  3 +++
>   target/i386/tcg/bpt_helper.c  |  6 ++++++
>   target/i386/tcg/excp_helper.c | 20 ++++++++++++++++++++
>   target/i386/tcg/translate.c   | 13 +++++++++++++
>   target/i386/tcg/emit.c.inc    |  5 ++++-
>   6 files changed, 47 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/helper.h b/target/i386/helper.h
> index a52a1bf0f21..8f291a5f66f 100644
> --- a/target/i386/helper.h
> +++ b/target/i386/helper.h
> @@ -56,6 +56,7 @@ DEF_HELPER_2(sysret, void, env, int)
>   DEF_HELPER_FLAGS_2(pause, TCG_CALL_NO_WG, noreturn, env, int)
>   DEF_HELPER_FLAGS_3(raise_interrupt, TCG_CALL_NO_WG, noreturn, env, int, int)
>   DEF_HELPER_FLAGS_2(raise_exception, TCG_CALL_NO_WG, noreturn, env, int)
> +DEF_HELPER_FLAGS_1(icebp, TCG_CALL_NO_WG, noreturn, env)
>   DEF_HELPER_3(boundw, void, env, tl, int)
>   DEF_HELPER_3(boundl, void, env, tl, int)
>   
> diff --git a/target/i386/tcg/helper-tcg.h b/target/i386/tcg/helper-tcg.h
> index effc2c1c984..6a5505e7b4c 100644
> --- a/target/i386/tcg/helper-tcg.h
> +++ b/target/i386/tcg/helper-tcg.h
> @@ -112,6 +112,9 @@ int exception_has_error_code(int intno);
>   void do_smm_enter(X86CPU *cpu);
>   
>   /* bpt_helper.c */
> +void do_end_instruction(CPUX86State *env);
> +
> +/* sysemu/bpt_helper.c */
>   bool check_hw_breakpoints(CPUX86State *env, bool force_dr6_update);
>   
>   #endif /* I386_HELPER_TCG_H */
> diff --git a/target/i386/tcg/bpt_helper.c b/target/i386/tcg/bpt_helper.c
> index bc34ac27fea..9695b9dd041 100644
> --- a/target/i386/tcg/bpt_helper.c
> +++ b/target/i386/tcg/bpt_helper.c
> @@ -37,3 +37,9 @@ void helper_rechecking_single_step(CPUX86State *env)
>           helper_single_step(env);
>       }
>   }
> +
> +void do_end_instruction(CPUX86State *env)
> +{
> +    env->hflags &= ~HF_INHIBIT_IRQ_MASK; /* needed if sti is just before */
> +    env->eflags &= ~HF_RF_MASK;
> +}

Two and insns.  Perhaps place as static inline in helper-tcg.h?

Either way,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

