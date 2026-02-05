Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA6BECD9A6
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 21:29:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo6v4-0004lk-0z; Thu, 05 Feb 2026 16:29:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vo6uy-0004iG-6u
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 16:29:40 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vo6uw-0002Ko-Mn
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 16:29:39 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4806ce0f97bso12725025e9.0
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 13:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770326977; x=1770931777; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DwVKA0Ff2zvqu16aWuaKSC0qeehjqx1yLT9+9XMAu3Y=;
 b=fATeoYWdsObgbRszwU/ROZxAk6yy1toaVtByMEcHKqZmAQbFNWjjAbO+0WckiWdYqE
 LBB9WsrtHUh9mNHu5uxwcALpyVGOWF1E102dqHHpn+s25aNmfZra11IlrQFgGrPmQnmK
 nTxT+mpL18pdom1wemWOjKNTAUphcGMQfiRh6eyYuGxM5QBJaVH2LEcX1+u8zA/x4wJ4
 moKJkIHrjCaVb5DprLc6nkO6Wv8R8HX55ut4XHRBCn9xeBzfGI58IpHWkZr+9JDIfy2O
 YgS90cSWEplVgdc2u70AKUtHpUMho4b+LkU0XIkHaUBdTEC9BhzKMjDNJn8eKb08E59R
 RoRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770326977; x=1770931777;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DwVKA0Ff2zvqu16aWuaKSC0qeehjqx1yLT9+9XMAu3Y=;
 b=LV5C8KpfgKGIY+ENcDva/OfUd81G1zqi3kgvKWyn3CJmwHFAfq5dakXQwiDr9wxFHS
 d/6ZJks8EYS34VzDiihxaNKAFbNQZqeap/XMGkSnFRp6Naf7MCLIspPYvjyJHlN3e3Yz
 XM0KE/a73ZPbEJwCq3rFKUv2+xN6YWVNQGd+D2nfVdXG1SSQWDWB+tkIqpg3q+YPksuR
 AMW6bEHFnSWkZEY6gXljYh5pWufXsGx/MGzyYoAKE5zbORoZB7eC0uKquDEpmVISUxya
 KGmhOE2IhWCLmFiq8ec9+g6WIlnf3rd2QZ73ws/bKpbP5krm3VWVqLLutRakhs82UdEK
 J8qA==
X-Gm-Message-State: AOJu0YyXmQRi0c9SLWeIaBnCsoAWXBffFapmO7LRdyxvYbHehoZI9VKc
 Qsc4O20oJReEv1ueq8FnwcQk6lmyIpM1kdFCOdDlHUAy/x2hWNzXvbDaka7JsMnheFNriOmych6
 Y2cgHVZI=
X-Gm-Gg: AZuq6aIofTely8OR48c+pnbrC+USgKz/WDbckhUvYOnUvduHoGkPF3BPy2FvwZXaXpR
 K+jEwuH8+qAsvE+YDzSgXhq5NRyXDSgIRKIEAx8909zT5eWZbRMtxioF2SLRrnSSz60udQdQL46
 w3eUlsRctUyWf+d2NU/3P256PFcqhwtX24TGI9h13oV6bGHrtYqVui9DuOc9jKlYUGIb+fuwQAD
 D7Yteks5pyKTeM2Ql6hEg54biPttttdKZEE9jU/QVKAI2+N9nbTrjg/TrdiGPSJgN8RTJTS88zO
 LWD4A9bFXTBF4hqeuteON/ETBSIbCokCm5reJeSGNrDPp0Ew0QRHIg+E4OeVyjdqgvBI4mJw6wg
 RKeyt3WAFYFNU1tjTfdFTmY5ldVTuKfZaYz5Pq8z76LsTGE2gGAROqYEALZF2mIGoWAS04Xjej7
 9LtTRZOZXsqpnIq3NJ5iGkb6lRA8wB+h52BjugI7Thz3k20BwpnDXwkod/sDcNz8Ix
X-Received: by 2002:a05:600c:3509:b0:471:700:f281 with SMTP id
 5b1f17b1804b1-4832021e93cmr10460955e9.25.1770326976713; 
 Thu, 05 Feb 2026 13:29:36 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4830fc1744dsm112226655e9.2.2026.02.05.13.29.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Feb 2026 13:29:36 -0800 (PST)
Message-ID: <8d956448-905d-4e8c-aec2-bd9b18006f68@linaro.org>
Date: Thu, 5 Feb 2026 22:29:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/tcg: Expand tcg_global_mem_new() ->
 tcg_global_mem_new_i64()
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 David Hildenbrand <david@kernel.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>
References: <20260205212714.10035-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260205212714.10035-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

"target/s390x: ..." in subject :/

On 5/2/26 22:27, Philippe Mathieu-Daudé wrote:
> The s390x target is a 64-bit one, so tcg_global_mem_new()
> expands to tcg_global_mem_new_i64(). Use the latter which
> is more explicit.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/s390x/tcg/translate.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
> index 4dabd49840f..203afe265bc 100644
> --- a/target/s390x/tcg/translate.c
> +++ b/target/s390x/tcg/translate.c
> @@ -217,9 +217,9 @@ void s390x_translate_init(void)
>   
>       for (i = 0; i < 16; i++) {
>           snprintf(cpu_reg_names[i], sizeof(cpu_reg_names[0]), "r%d", i);
> -        regs[i] = tcg_global_mem_new(tcg_env,
> -                                     offsetof(CPUS390XState, regs[i]),
> -                                     cpu_reg_names[i]);
> +        regs[i] = tcg_global_mem_new_i64(tcg_env,
> +                                         offsetof(CPUS390XState, regs[i]),
> +                                         cpu_reg_names[i]);
>       }
>   }
>   


