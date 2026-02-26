Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 343D2FD8FDA
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 17:04:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvekf-0001uK-GB; Thu, 26 Feb 2026 12:02:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvekW-0001ph-TH
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 12:02:05 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvekV-0006m1-9I
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 12:02:04 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4833115090dso11420175e9.3
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 09:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772125321; x=1772730121; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Psl5miEuGELH0aI58KUW77MWnyztiLM1W5R8DySdthE=;
 b=eBGWeoJ4N8f2/NCWBLuzEGsKmtaDV+nIaTOdMUcbqJy+J6WNdnEa34nKxbdHhLgTYX
 /WOS1gHgHFP47Jjrd2mw9G97YemGD+anF0Tm0rgfwmDn4COKV/TeuwG1hT7t7njsWY1+
 obDTxyo/c6X5C3KVRWaG7+Wi6JyIQd4d7R8Q8L1ZjyJF0MjryUXkpIxqzfd/geZ6Uc7K
 CtleMXLgTZsTq+xp2DfdSXNPDMUoKqrgJvWd2qNCLk84iqn1XrhCOvLNjUZTVg4tjmeS
 /Nq96mh1Isc9qHyP9Mg+dhhnj4CBKL+24fWjCsPfbqmzWog584AgVzMEptecMjXOIsVY
 /Q+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772125321; x=1772730121;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Psl5miEuGELH0aI58KUW77MWnyztiLM1W5R8DySdthE=;
 b=YX9HfokU+b2W2oU89WsKl+EdjAoTOfynQ7pw5Nzes039pE5cYXZ+xGYUcj9uzLt/4q
 ZYOXltLqsrgMOPgn9GWESBs7cAYSWKAuW5zKijGUSQf7xN9S7ASXo6E75tBnNCRvL+Gg
 44PziMHM6HBMknyRF4zaVoYlX6PqzD+ThTmy3BKDJao1JW2ASVq2OMLEqxsQy63mqhFR
 DYFXtY6HTUu7rJmHGHBsRI5U7cFmehuL3C3Pm46c3Fd+XdTw7emMssneSWpzSomCA/0w
 HuHnbeHRMCuGETU0FSgENJIjyK2nq4ASOi/sOoTVRKp7vj4iA2W+nVDOmAKJwrmSwbhr
 MDPw==
X-Gm-Message-State: AOJu0YxPPfC7bdtVldvPiPPiVZLabHtXmrer2guP4Td8tZoSbt5RSjkL
 FwJFqE3xgiYYPaWK2NCk+5XTIZJyKhMJOVnTEGc37FCGceMpvhubVyw8+2Wp200t7ozTt+GOgAe
 DcHF5X+A=
X-Gm-Gg: ATEYQzw44HcLkFKQ+HuYPxk4Rx7OWHseuYUGShjHV7o/y4FgU/5bAhQNVS7TjsbdTKq
 uHjIr+JE6TLMe1S44KngpkuEOXVNBrxYeY4796siy+60mMlHvsOpKamSDkf+kul4YoDZukfeuNi
 HdlcpR9OuG7KChKnhKmQ8yRb2NoOxrxG4h61jg0bG8ucZ66wFbqikUV6gXWGGJYwRMS4jVj7I1i
 YhpCjfL2P9tYvOoCj+g9/Kfb1Gs9GeML+mUlbTgGP2TPDYjF1g69f6lb0whMAJOZEys0jPjejII
 KAkeHtZMN0gjgwxLqdiZdeRr6AGQHaPxqzGipcW7N9cMMDFL1TUxyr+AjKTwPoYEi5A1ZFXSiAe
 mnYicJMlt+ArSUYlVy7TyL/cyu+7lBbqfGhHK6SI2TlDiweDv8SGqkPVLAP/NYAmBo9vvJC6INS
 DGgVlfhoXXkIBh3HEP+8NkGexZJawjROg/0dHdW6/EOeQ0ZzvBzkP2UXqzxEcukUhOVA==
X-Received: by 2002:a05:600c:3516:b0:482:eec4:76d with SMTP id
 5b1f17b1804b1-483c3de3b6fmr49517285e9.17.1772125320838; 
 Thu, 26 Feb 2026 09:02:00 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c75b5b6sm714513f8f.18.2026.02.26.09.01.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Feb 2026 09:02:00 -0800 (PST)
Message-ID: <66138da8-a096-4558-8b2f-dd4e937ce2ff@linaro.org>
Date: Thu, 26 Feb 2026 18:01:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/hppa: Expand tcg_global_mem_new() ->
 tcg_global_mem_new_i64()
Content-Language: en-US
To: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
References: <20260205212914.10382-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260205212914.10382-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

ping?

On 5/2/26 22:29, Philippe Mathieu-Daudé wrote:
> The HPPA target is a 64-bit one, so tcg_global_mem_new()
> expands to tcg_global_mem_new_i64(). Use the latter which
> is more explicit.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/hppa/translate.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index 0f8a66f7732..70c20c00377 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -307,9 +307,9 @@ void hppa_translate_init(void)
>   
>       cpu_gr[0] = NULL;
>       for (i = 1; i < 32; i++) {
> -        cpu_gr[i] = tcg_global_mem_new(tcg_env,
> -                                       offsetof(CPUHPPAState, gr[i]),
> -                                       gr_names[i]);
> +        cpu_gr[i] = tcg_global_mem_new_i64(tcg_env,
> +                                           offsetof(CPUHPPAState, gr[i]),
> +                                           gr_names[i]);
>       }
>       for (i = 0; i < 4; i++) {
>           cpu_sr[i] = tcg_global_mem_new_i64(tcg_env,
> @@ -322,7 +322,7 @@ void hppa_translate_init(void)
>   
>       for (i = 0; i < ARRAY_SIZE(vars); ++i) {
>           const GlobalVar *v = &vars[i];
> -        *v->var = tcg_global_mem_new(tcg_env, v->ofs, v->name);
> +        *v->var = tcg_global_mem_new_i64(tcg_env, v->ofs, v->name);
>       }
>   
>       cpu_psw_xb = tcg_global_mem_new_i32(tcg_env,


