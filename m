Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A391C531D2
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 21:37:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtBgA-0006gv-9T; Thu, 19 Feb 2026 16:35:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vtBg8-0006aj-Ei
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 16:35:20 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vtBg2-0002Pa-Ub
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 16:35:20 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2a77c1d5c3bso5988595ad.0
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 13:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771536913; x=1772141713; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V8Zg5S8J8UgUt9Zc9yOnvOqks2G2Wv1jG0NTZVWq6cs=;
 b=gx6qPyCTgHV6wVfBzTocdnnfz9MI2WDtBIVrJcv6s63+ELuHF+7g+THQz8TBryOXDL
 jjoWQbbNn69nv27mQKBqKsquL2NFmDPi/XvmGah4dcd3X3wvPDxPORLl5qdR3gdv6Ymd
 TdfizFO/D4WpJCyODPGTVjMOBKUmzbqpIFMjaFnIaVpUwLu5aTC7RPywM+t7oxB9erKJ
 kPKfRzf3zTF13X8daHwpqaKJA5ejuRqYdwC+IzdZFGLoQsVlc74UpiEG6+kFXS15+48a
 MlExn5fzQ+GZju+2GxRC9+R03Om62Dc1ZNkgNV4Mn/9udmClu2CziVIfVvRTcVxOG39U
 BfNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771536913; x=1772141713;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V8Zg5S8J8UgUt9Zc9yOnvOqks2G2Wv1jG0NTZVWq6cs=;
 b=eaDWRvHXtjai3nBj+P0VonkqidUGHA7ZjFJB7WY49vU7q5pZ3uZiLptEyU/B1L3EyT
 vkIG/VvuAc1xujEUcVGR1vJRBdYn50Y3vDY7sZmN0wXwOXBVaUHR6yAYN9ReIUErMD0k
 n+8mvKsGixEQS55BaLb1JCgzqWPIOn2lrMh+g3SduEt3UDJnG/t0q226sSNvDmyP0yrN
 BY2I52EWvgnmPBI6lEpK8+TbE04NOt4hChiUFgvM3Gg2oCRamczoR3e887vxPNE2EuGd
 t8+tzAl+dYNiwNcuwvFyZTz2IxFTWiSNuAYuF2adnvdr+LLKkuHs4WxMg/Ij6/cGDH0G
 RGKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/8G76Lq9lbTwost95VcJzlh6JjFQUMJuD9LOJIrX/KNp7V9iKf7DTCe5pyXWSDd4uPmwrdJOFgJh3@nongnu.org
X-Gm-Message-State: AOJu0YxR0Nu+INYCfXWf0C8wDfF6uc3vEqjl7YKAAGgI2GFk6zaeILo5
 xPpcHSxAdno2oKTMhzbEFa8BvnwgmpjGLpndDfGRybCrgdNp+zRUxBi9NvKfa5HCowI=
X-Gm-Gg: AZuq6aJYKov6uvNDIDP0gaOAnGIF4mzMF4B8OA/Js8b3995kvBPDUpVdeIaEAn3mlHJ
 uxWd4mAkfEIrv2geLF8HVV5QpqUhrexsgeMSdq4pEIyYcYGa6Mr8Vl2ypbWldquAw9RiofnlDj8
 Wx5AiJiNH7g1nFQirwQEmNMDDGGSzSuT0QbzKbgHHS7HyFDJQc9c6Z1WHuvsWm5OvKHKOEKnRH1
 1zBRyJvq5UsR3BWM5OX9/t5uGKoRwPGsHoXGs/3z01aSjpo/P7xB1jIBnuOW+mg3FUxJQtNeHBo
 XiIRqIXKemdc6PqD5LBBwXSTG+R7k0Q+GfF909uMujirdL2Fq5dkpmcv0+nc5eSBxG9pBcQ0EwH
 j7t0Pr7r205umYGvQLyv4TYHxM3R8WEBLRc7Zk3Z1g1p3GuNErNFs0lUGZtT8bSUWfhlcq9At26
 qKbj8AajQI+XcFTtlLMSo2FKtl9/uBmEsU0g/TZXJomflYNVNc7+AG/Oz/4uO9i/Z5IvVe
X-Received: by 2002:a17:903:b0b:b0:2a9:47d0:12cb with SMTP id
 d9443c01a7336-2ad50ecfb68mr71087325ad.22.1771536913262; 
 Thu, 19 Feb 2026 13:35:13 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1a9d58e7sm182774265ad.45.2026.02.19.13.35.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Feb 2026 13:35:12 -0800 (PST)
Message-ID: <0f386971-a257-4f0a-91bf-22ab3b60de3d@linaro.org>
Date: Thu, 19 Feb 2026 13:31:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 32/50] target/alpha: Expand gdb_get_regl() ->
 gdb_get_reg64()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org
References: <20260219191955.83815-1-philmd@linaro.org>
 <20260219191955.83815-33-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260219191955.83815-33-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

On 2/19/26 11:19 AM, Philippe Mathieu-Daudé wrote:
> The Alpha targets are only built as 64-bit:
> 
>    $ git grep TARGET_LONG_BITS configs/targets/alpha-*
>    configs/targets/alpha-linux-user.mak:4:TARGET_LONG_BITS=64
>    configs/targets/alpha-softmmu.mak:2:TARGET_LONG_BITS=64
> 
> Mechanically replace:
> 
>    gdb_get_regl() -> gdb_get_reg64()
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/alpha/gdbstub.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

