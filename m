Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78186E88D60
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 21:13:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8loo-0002rP-Gq; Fri, 03 Apr 2026 17:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w8lol-0002r3-Bs
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 17:12:39 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w8loj-0002yF-Rr
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 17:12:39 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2b0c8362d93so14227525ad.3
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2026 14:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775250756; x=1775855556; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/hwD1mqTpIM4pnkK1/K/02IeJ+MdYeHBb1wdXmoF2Yg=;
 b=bXH0gi8ELsfSbzT5LrO6iMWS/8QcYfX0tC2mL+hDzdvpquxXT7bo/t4oHfhNyJtCGC
 vWoe46ciSeDtJhQXjAKMr1lW9/2rUXpH2WOqFn5+FAIY3hQtioOmWXMYsZIUyqG2apVp
 Ijkjjlps8Gdc5gS6tb7xRpkpdvu5zUIrHcYbirDOiI6syknLEZwyOSsgObu2wH/TCxxH
 Bqg19M4Ay8tHvYmqzrGRrKiozHiImJd83fh1UL+L79w96x5Yt7alfZPkSaPh77Oe+vz4
 TvQv9Ly94b40XSFtP0VKg9OOKStP9BhlL6Cc0eKy7sEtIv/vahaorjpxFnTCiwhLxgFA
 KrEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775250756; x=1775855556;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/hwD1mqTpIM4pnkK1/K/02IeJ+MdYeHBb1wdXmoF2Yg=;
 b=Q+1u1XpFOzXTq9r3hu6ebLZHtKdNxgNtwhr1PdN/XK06gQOoanKoP5HIkKjq4nCLnO
 RV0ZLrTLGBx7H+D03U8WQuCGCk+cHlqDhf5DMFrFL35Q/PyXYylZlXHEI39SQV3WsIby
 nylhbYM/+YQ7JIGaNKkoulBYeTZP6EAREza0wMeAPtIgHMv19AcSHl6fbx3OHeiF5qyx
 kY2Tkww0q9jkvz/kLn6hjzPSYOQRVm56tWS7QrIIlpVXP894VcMTUYhh+YeML/GYvprM
 3zWkWEQVsNJL8rON/YXD1wqNR5ptzEjhw/0M4audGtcN8n4KODLovHOUfDq/oDK6Guh7
 alcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7LXFyxsv1wE/Ug8AEVJG+wq6CJT1ljCnys5X9qO0sxf8seHcYmRchD/Sr/0iS+5HRYyXnTs57ZgKw@nongnu.org
X-Gm-Message-State: AOJu0YwqSF3TwA5vUiX5TNcUmTaEdnmS591+OHnkFhDtvnWZpx8yvKOs
 mbjk4sVbHjafqf6Fv6L0H4Vul6RrDRUscIJ5NnVFFqOGyFa/t5+zvEqX8yrL9dQyYDM=
X-Gm-Gg: AeBDietcgEDsEpEiDO/Rj3QqvodoVV7HV+yWj/XxHmZZrivVqeZthi3cbheSETJW4wY
 ly8mJQqcLR8bTNNZx5AiZ6A1ir51otSXtbIc4EYkvK4dUYJGaIqHD0gn9tV5upUq5cguSRPCmBq
 90ypBGO3A3KTp82HrFNdWwBWaf9/0dkjKIZqHOUh//TFDWl9QCsx5fnUnKjjFRKFaWyuDwT02uh
 fOY42PI5qq2FiRFNnExAiRKNg2pD1+8K248XwG3E79TlWouoWRjZx8fE/LXmiJtBuDbI8leoR7H
 aM4OKQKIGEHiUr/a3Fcr6p1/aKtfh1ArsYqgnDzZ8JmBVph5CyEbkPKOqjNxQCOhnxm/q1HYfOV
 zgNB9Er/6QXGNVqV4qB7OdWwO/ZNssptCXVl4Nl3ZDx1ROB8FfLoOTWrNq5qLbbR8+nhp0mkK9x
 nLXYBU2K/3sxKJ4Vf+Lz9Y0FlBNlQ+VYWlyz3HSPZHrAmhYEBOIiBa3Hvhz3GzPMKbys4=
X-Received: by 2002:a17:903:286:b0:2b0:5320:23e2 with SMTP id
 d9443c01a7336-2b281855cd2mr46401085ad.34.1775250756007; 
 Fri, 03 Apr 2026 14:12:36 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b274f8867csm67394485ad.54.2026.04.03.14.12.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Apr 2026 14:12:35 -0700 (PDT)
Message-ID: <03208dd5-c815-4c3e-b1e9-3213ab7bd6e9@linaro.org>
Date: Sat, 4 Apr 2026 07:12:28 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/12] target/arm/tcg/translate-mve.c: make compilation
 unit common
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 jim.macarthur@linaro.org, philmd@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260401192057.1182724-1-pierrick.bouvier@linaro.org>
 <20260401192057.1182724-8-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260401192057.1182724-8-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 4/2/26 05:20, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/meson.build | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


> 
> diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
> index 8d9112f6da2..89c3b476822 100644
> --- a/target/arm/tcg/meson.build
> +++ b/target/arm/tcg/meson.build
> @@ -16,9 +16,10 @@ neon_d = [
>     decodetree.process('neon-ls.decode', extra_args: '--decode=disas_neon_ls'),
>   ]
>   
> +mve_d = decodetree.process('mve.decode', extra_args: '--decode=disas_mve')
> +
>   gen_a32 = [
>     decodetree.process('m-nocp.decode', extra_args: '--decode=disas_m_nocp'),
> -  decodetree.process('mve.decode', extra_args: '--decode=disas_mve'),
>     decodetree.process('a32.decode', extra_args: '--static-decode=disas_a32'),
>     decodetree.process('a32-uncond.decode', extra_args: '--static-decode=disas_a32_uncond'),
>     decodetree.process('t32.decode', extra_args: '--static-decode=disas_t32'),
> @@ -34,7 +35,6 @@ arm_ss.add(files(
>     'gengvec.c',
>     'translate.c',
>     'translate-m-nocp.c',
> -  'translate-mve.c',
>     'm_helper.c',
>     'mve_helper.c',
>     'op_helper.c',
> @@ -65,6 +65,7 @@ arm_common_ss.add(files(
>   ))
>   
>   arm_common_system_ss.add(
> +  mve_d,
>     neon_d,
>     vfp_d,
>     files(
> @@ -75,12 +76,14 @@ arm_common_system_ss.add(
>     'psci.c',
>     'tlb_helper.c',
>     'tlb-insns.c',
> +  'translate-mve.c',
>     'translate-neon.c',
>     'translate-vfp.c',
>     'vec_helper.c',
>     'vfp_helper.c',
>   ))
>   arm_user_ss.add(
> +  mve_d,
>     neon_d,
>     vfp_d,
>     files(
> @@ -88,6 +91,7 @@ arm_user_ss.add(
>     'hflags.c',
>     'neon_helper.c',
>     'tlb_helper.c',
> +  'translate-mve.c',
>     'translate-neon.c',
>     'translate-vfp.c',
>     'vec_helper.c',


