Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E94D41D64
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 16:04:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTj92-0008Kh-Ei; Thu, 11 Dec 2025 11:03:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vTj8z-0008KA-Pt
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 11:03:54 -0500
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vTj8x-00050E-Cl
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 11:03:52 -0500
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6597a87048bso140632eaf.1
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 08:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765469029; x=1766073829; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VOEw0SPuMX7u+ebJdVidvZKd2M1VwatiKiU5rs5tHBQ=;
 b=Sr/hGYF8IyL8O3koVGGlhPLJcyMSizOA6wQER/NZ8qfdcf9RkYkP7/ETzZaSXUtckf
 UWyjzyawXLEBy8N1DSPzHEY75qPuhHb5blFrvRYMbj6ihMge6zOXKfUSUesPWOgnOKfB
 WbJG81vwLYW4kosVZNF//nZhzpeEgSUNmFJFBDqeWJ9WoNJdc9JQx8TbpZt02Ay+jwrR
 M0hjZBCr53sWR2lGdqXH7LvqF1BnD9/lc48zmO+uyLxAIM0TXm5Tzs0TDgioO+IZ+hEP
 JoEUNJH71lXacLjRbiLhsqZw0vOdKzYCyaWlEG1HCv2JJaMvcsefRrvUCAQrBw/T7KBP
 m6Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765469029; x=1766073829;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VOEw0SPuMX7u+ebJdVidvZKd2M1VwatiKiU5rs5tHBQ=;
 b=opw7ejlYeGC5gINyi5BZFKFll7Dy9j4U8rd6koXwLfd6YISzdwIIQFASjXu/MHM+CD
 PA0BvR8ccTKWSYa3SzfwWCHlwT4Ls69XEL27zcy4Ca5oEDaLpGZAwmoYVj7kbWusv1W2
 TIPQDSZjU+wQCBwfaZ60bP2zMGYB4fiPzpKObgGY83Co+dXpYwQ7SieYvrkhFAovNFE6
 /VXm598pYxJw95VRXVFIJUGzAWMaTg8TC+n5agnuBiqXDFWW5kjtNoOL0Oz41T/tjD3k
 iATy2mJ71KXOqgCUIOD+82ScfJ0UvnkF334NsV+lRHZfrmUliC7a8MolFr/Lnwdhf495
 VARA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWR1I8jTEsC3OUaa8yv7XvoacQxv0YWVl32HE1Yj33or3mPeRhjecxDYb9SqIDakyviYvjlOhhfh4jq@nongnu.org
X-Gm-Message-State: AOJu0YwFZ4kflmrxAa4Ubf4kWcQ0DFwviWOR8p0rU2nUetBnFX6fW4AO
 FJkJxfkSV9k+y31KjFBHdYimUedz0XJaQzpcn5lquwjxTj7R8lQ7evL0UcY8lS0EY99BXsmEArr
 pIFWJOBI=
X-Gm-Gg: AY/fxX7vWToNWDpkH44rO1MdYZ3PTnymdZYgUG+K/jTza5+dejfx2jPfO0C0xEzt/aR
 xt9U9Na/xKu/LAdSxockhRLvJxbZYI1GO4gvxtOPvqdSx7uTF7rlN/2jTckegpx9V6cPeSo31ER
 mW7Zkw+/i/Eyh3Zh4GfE4/WMOqz3uzGga2PaOoTcKr67egSr1NId15OKIpwm0dlxbcnLBwOKCKr
 YpBHJxnoPoTCB9n+tk1by9Kl5HLQgFGiy5rPALU7ldzG6Pb7OCBdjy9414oUU7stjLQAc2RoTkn
 NiLtGIC0MRLOF/P8w9ZZjsvcH6ZsvjxvCQhaF5SSHklfAH4a5WVq0WrYyg66wuyH0dwfhZgxuRY
 pFWI6OSewOWCJRNx5LMfI9IIgsUbM53WByQ8YQ5kqC5VL3l+32xxHh01VmQ4SBAavNRSZeVQpjU
 zW594Myt+sbuyjYd6Lo3D6GMr2AZ0VTwrJ3OYxkJMERnWBoH0i2BhYznljQz+5EWsa
X-Google-Smtp-Source: AGHT+IEpTE7HFJ0SvLmwIptDl+7Iqc0Z/qFtvCXMN4FD0fGvgsmgo/7oqWADNyynfKsue5TLQ3ALjA==
X-Received: by 2002:a05:6820:a01:b0:659:9a49:8ed4 with SMTP id
 006d021491bc7-65b381e275dmr1039902eaf.8.1765469028897; 
 Thu, 11 Dec 2025 08:03:48 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65b35f2b589sm1316356eaf.1.2025.12.11.08.03.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Dec 2025 08:03:48 -0800 (PST)
Message-ID: <3cad0d59-91b3-4276-a544-7d34737ce88e@linaro.org>
Date: Thu, 11 Dec 2025 10:03:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/18] target/i386/tcg: remove do_decode_0F
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20251210131653.852163-1-pbonzini@redhat.com>
 <20251210131653.852163-7-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251210131653.852163-7-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc35.google.com
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

On 12/10/25 07:16, Paolo Bonzini wrote:
> It is not needed anymore since all prefixes are handled by the
> new decoder.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/decode-new.c.inc | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
> index 213dbb9637c..ea8e26f7f98 100644
> --- a/target/i386/tcg/decode-new.c.inc
> +++ b/target/i386/tcg/decode-new.c.inc
> @@ -1430,15 +1430,10 @@ static const X86OpEntry opcodes_0F[256] = {
>       [0xff] = X86_OP_ENTRYr(UD,     nop,v),                        /* UD0 */
>   };
>   
> -static void do_decode_0F(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
> -{
> -    *entry = opcodes_0F[*b];
> -}
> -
>   static void decode_0F(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
>   {
>       *b = x86_ldub_code(env, s);
> -    do_decode_0F(s, env, entry, b);
> +    *entry = opcodes_0F[*b];
>   }
>   
>   static void decode_63(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

