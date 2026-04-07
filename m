Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B3BEFF5134
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:28:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABRP-0002qI-9e; Tue, 07 Apr 2026 14:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wABQx-0002am-AT
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:45:58 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wAAGB-0001Io-Uf
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 13:30:46 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-8296d553142so2708961b3a.3
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 10:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775583042; x=1776187842; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UDaEVMhyKxFlr4Solen+ATNFmzuejjUtuBWYPm+vwKY=;
 b=uZqTFeHCzOtkjH+ZP13GkdGp6huY/Ekk6WKETggLx8P1Styl3rmBzUJsyGC5RGFWHM
 U237njDkgtjyCKXqwjl31rw9yuWjz4sxlKK7jiezOd+36JeWhziOX23xkpxSlxh4k4nm
 skYy+ATZHCmcleF206tRVbdOrFiMgxMXnpCSaXv9BvMuzNb3SMwzsIH7Ugw25I+8EGMr
 LII30LWUfqq+1xwFvzOAWT6iB1YMi3ZEB5d5ktPb68Ltw2UF2MNrtH3nBueQvf+3Fm+x
 XQsORuPIkxRPcws+PXDUc+1kaaroSF+mJHByUqR0JR8uCddvy5rRu17QjT8t78xSFGFu
 9J+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775583042; x=1776187842;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UDaEVMhyKxFlr4Solen+ATNFmzuejjUtuBWYPm+vwKY=;
 b=Jh/c2NYf7zjDTqc9TW3TWLdaKE0wRHKaLu2K9PwultzZPXQOQIcY2pfBfNYkEmwc1U
 yURBOmH9US8Edn7Mv1wiaL6iXdEsnAHbSU5jtFG6xPw/7E9WFdxJ5XJSE2IzFFcNCImT
 cm+sOu6ZGc783m74R+I5FqAXSkii7Two5253t9YRWmnZy7MpZdfGwd/dYb+dmXaUzlQU
 /R7ZuCsdGrXvxheRBmL75SiaiU9/epS/i3SN5eDHzbJDWYqFTGM5nScbM9p4UoSZB848
 jsGETZ41LSiZ4VKbD//ObZSPVeKmoW89hhn9lA853Dxri/HRKTrTgR2OLu8dtXLKFgxT
 Reaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUatYGFKVvX+U6hthnd5Ud+GWmFtt5ZsQCOH7wtrld/ETj/8ATgpNFV3H0pY9yCaAPbnq6WeEcjwqMN@nongnu.org
X-Gm-Message-State: AOJu0YyfQLKPMxyvYT3SSaIXLakxqQc3HiiunJRF2+Gg+QysqHlRIAfx
 0ygr6WSI7tj4rzbz85lawJ27LNcJymBPCMk4dxDjykKoFDrU8HWGV9u6ludjlz65W2U=
X-Gm-Gg: AeBDietSVxIZOXtjabIs9q6S7CI3tDIE9AJMBXOvX2YtuXTKci7x28QNyod4q99q89R
 WLc0hKffhw1mNBFqqgOJTMPsP7eTrBdoAjyR6T+D6kkD+bY4QypbS8bVwXu0G5zhqdgkbjvaeoQ
 vgruEnX9rdsuNweTFx3I59Mppzuvq8k2sbphH+1QipCAMJFjpL65hrETJG/ZQhSVXSIAE7nV8ky
 3Ez758NlQxVQK2JRRQoWTWtoAMfFk1fZxH0XqBUxGEF+zBeRzN7T4fgMpfkNJiN3JrpBIqVVu5I
 G72fgMJZf/VNvhtFo5qK02QVXjJzAnO5pu8k0ggrN3O2LkLi7ob/nUDzei8OCSLh+LX2wjtJBpS
 th2TrvlR0kOStlJ6yfGylvnptecNXQrBzOAIMzMsH9rTR6+x3zBCtcdj4DFJc3LD1peny1mVXMV
 fB2glHP/7AS0v9kZ0Q5gN9eszJzkDOVj8sBWkWOohRRfMC5/CWcIJ+MAMHq1FPve/1DiJaoQ==
X-Received: by 2002:a05:6a00:4286:b0:824:ad1e:3b6e with SMTP id
 d2e1a72fcca58-82d0dbd91camr17783700b3a.49.1775583041968; 
 Tue, 07 Apr 2026 10:30:41 -0700 (PDT)
Received: from [192.168.1.169] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cfebe5b23sm18340765b3a.59.2026.04.07.10.30.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 10:30:41 -0700 (PDT)
Message-ID: <ca9775b9-5738-477d-9330-55c80aa3b2e2@linaro.org>
Date: Tue, 7 Apr 2026 10:30:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 17/20] target/arm/tcg/translate.c: replace
 translator_ldl_swap with translator_ldl_end
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, jim.macarthur@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org, qemu-arm@nongnu.org
References: <20260406182609.193886-1-pierrick.bouvier@linaro.org>
 <20260406182609.193886-18-pierrick.bouvier@linaro.org>
 <c73bee03-82f8-4529-9db1-7857a049f59d@linaro.org>
 <626fdf02-7114-47ad-997a-a7c64a83f9de@linaro.org>
 <7b15c854-64f7-4996-a831-d03480a40776@linaro.org>
 <46f488c8-1eff-40c0-a72e-231c81576812@linaro.org>
 <ba89301b-de27-436f-9f46-50be2467e13b@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <ba89301b-de27-436f-9f46-50be2467e13b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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

On 4/6/26 11:51 PM, Richard Henderson wrote:
> On 4/7/26 09:00, Pierrick Bouvier wrote:
>> On 4/6/26 3:44 PM, Richard Henderson wrote:
>>> Delete bswap_code.
> ...
>> There is still one usage for bswap_code in linux-user/arm/cpu_loop.c which I'm not sure
>> what to do with.
> 
> Essentially,
> 
>       x = load_little_endian(...);
>       if (arm_sctlr_b(env)) {
>          x = bswap32(x);
>       }
> 
> This is slightly more complicated because there's not currently a get_user macro to force
> an endianness, only __get_user_e.  So it's a question of whether to introduce get_user_e
> or open-code all of the goop in get_user_code_u32.
> 
> Actually, there's currently a FIXME in cpu_loop concerning the failure of get_user, so I'd
> say most of the get_user goop belongs there.  Then using __get_user_e is trivial.
> 
>

That's not clear for me what is expected here, I'll let you send a patch 
for the kind of changes you want to see.
I can then integrate it in the series with bswap_code removal.

> r~

Regards,
Pierrick

