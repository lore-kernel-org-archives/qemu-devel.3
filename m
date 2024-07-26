Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5483C3DA63
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 05:33:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXDZr-0004nd-TL; Fri, 26 Jul 2024 01:33:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sXDZq-0004m0-DD
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 01:33:14 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sXDZc-0007V4-1U
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 01:33:14 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1fc587361b6so2407675ad.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 22:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721971978; x=1722576778; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rTDQH37Ci1bWxSokmKwx6+i64qavG3O8C1lYGoVCHpY=;
 b=c1N8OsPzipDkiLhYeM9RYwMHJREbW7sOrNOk5HHO3DGZU5hrGzQB+SX7VZ5T/KMX9t
 Q/oWYc5gt1iSrOhR4SYA8rtrlBXyCeZ8PwTMC/b/29hf/05k1Mtb/BZDzzi4H1sGaURz
 cJryYo22yEDAXClQoLJ3O6+3Z8sV1g+H707LKAcQzYmjpsC/BQMksJTKDeh8HoSBQhwS
 olFGf4ttWt32Li46lmPpX/95S/SgOzHaWj9rjVGK7sFfe+J6hDwiAiDcsRtySFS4dVkE
 xez8BfqoeCYspVsm3Ud+VZsH7L8lNcviOZR1/BvPCZje84EVWYuOGGwsSp6iQQElR6E0
 Td2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721971978; x=1722576778;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rTDQH37Ci1bWxSokmKwx6+i64qavG3O8C1lYGoVCHpY=;
 b=E7VCB8HzNsuIXM7zRtc4kBKzEf4LqOTs+7NJC6z7gxD1/GwCyHLEMR9HL9ZCQul2Xg
 kbyNkizaU1x8Gb09i8ODlZv+IkY2WiNBD8zndToEeoEojFsMjqqWq2KFOhNACuuTe7YN
 u8n8VrdbsX9aXOfgJ90rIFotq3Ru/gtW4UFfHpefWz9zlyL6p/FCkY8gAlEeRK2Qk70J
 M7K5hA9r3WQEwcRIGJIYAdpUXBnvrDaWKgOAmf7+u7EBTnofIsnnlZO255haLsbMzus0
 1y3g+UhlaMo4H0QYBW5c76DJfJBtuMh8O4kKaV34RaUgaQLOozPiXNhaujtcb/9TD+BP
 KC2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzzJaauhdnm6uzoPlKurGwTlCYhNJLCKYy22OPwtBNTl8bVizX483Zv8cYeDlK5qEEUIj5ZrfnTYIizc3ygaKxbmCUXJY=
X-Gm-Message-State: AOJu0YxlnohuHHcxa57NKp9vrIKtpkxkSlCe9tgZvRMzFQ6f8+/4hf9H
 3+HyQqLec/CW/PMw6rZeGMEeHN69MixZGyvl/ZoJO1J7Fo67RswkiJWrKmpxhbo=
X-Google-Smtp-Source: AGHT+IFi2L3qsdHek8EBCmHr6FdiodpBh8NMernWtJ7z1wQQC/E5QwpxMgE9E5kf/QM8dyWID4h2Og==
X-Received: by 2002:a17:902:cec7:b0:1fd:67c2:f97f with SMTP id
 d9443c01a7336-1fed92579d1mr41451655ad.28.1721971978113; 
 Thu, 25 Jul 2024 22:32:58 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7c85c70sm23351375ad.23.2024.07.25.22.32.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jul 2024 22:32:57 -0700 (PDT)
Message-ID: <8b952492-36f5-4d7f-b2f9-93f17f95c02c@linaro.org>
Date: Fri, 26 Jul 2024 15:32:53 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] linux-user: Add QEMU include path to vdso
To: Jim Shu <jim.shu@sifive.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
References: <20240726043246.10999-1-jim.shu@sifive.com>
 <20240726043246.10999-3-jim.shu@sifive.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240726043246.10999-3-jim.shu@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 7/26/24 14:32, Jim Shu wrote:
> Add include path to 'gen-vdso.c' to get ELF header in QEMU source.
> 
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> ---
>   linux-user/meson.build | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/meson.build b/linux-user/meson.build
> index bc41e8c3bc..ccce4f7e70 100644
> --- a/linux-user/meson.build
> +++ b/linux-user/meson.build
> @@ -30,8 +30,11 @@ linux_user_ss.add(when: 'CONFIG_ARM_COMPATIBLE_SEMIHOSTING', if_true: files('sem
>   
>   syscall_nr_generators = {}
>   
> +# It requires "include/elf.h"
> +gen_vdso_inc = include_directories('..' / 'include')
>   gen_vdso_exe = executable('gen-vdso', 'gen-vdso.c',
> -                          native: true, build_by_default: false)
> +                          native: true, build_by_default: false,
> +                          include_directories: gen_vdso_inc)
>   gen_vdso = generator(gen_vdso_exe, output: '@BASENAME@.c.inc',
>                        arguments: ['-o', '@OUTPUT@', '@EXTRA_ARGS@', '@INPUT@'])
>   

Ok, I guess.  I'm not convinced we need this.  I tend to think our elf.h is way out of 
date, and perhaps should be removed.  I suspect we only carry it around now for windows 
hosts, compiling the system loaders.


r~

