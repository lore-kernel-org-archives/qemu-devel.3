Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63190C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 10:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbeKk-0000eX-3C; Wed, 07 Aug 2024 06:55:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbeKi-0000cA-1l
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 06:55:56 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbeKg-0004KT-Iz
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 06:55:55 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-5d5cbe88f70so872338eaf.0
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 03:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723028151; x=1723632951; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S9e1uw6HNYmGtxlCu9za5sQMQ3Vzo2cv3tzngMHJqes=;
 b=xBrtY7rbZRtv6And08eEUSd440EP4G0PSuwcM6pOq+/lTzWEQ31CpK2h9lfHD4umCz
 FBJ5LwA0UdwyknWZp0XEO/WTEj2CpFViy4ik9AwJvvkGFAAlxNAXx5+KkVMPoTvvuC5T
 vrM4nM9d5z1N/00RZFAsxLQTMxN/ukh12bGRnaQfH2HzATuzoQDF90PR05Cb27yd6ltc
 jYEy9FQ9ivB3Xo76cX7CiZRw3A0frNCk94fuND0KZYtuXiwKd593SJzhqOaxArtakBLm
 gjmPK34K9cwlhsCSc7fm0eaGkcCS4twoW6uwdkRrB6zaBfayKUBTbw8e0AP/qDHcNE1h
 pILQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723028151; x=1723632951;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S9e1uw6HNYmGtxlCu9za5sQMQ3Vzo2cv3tzngMHJqes=;
 b=dultTjMStUognWGEjS1FVOJh7ws9NqwioCwtveJK4JdbPVYjHIsWXjOJmpCv1dgtp7
 h0wRcVjFYjg35NURaw26bzzkvDxYHclgKAqxDyYiF9kFxRlAzC7oPnGHyKtn9WHML3lt
 SEggXYLKJGea6Ydf5sufif9dJlJ3qT0j8pYiD2RgZ2XXiiNlSxCDfp3NafdXqX6OrblO
 WSB7rKZvA6t7bMtmhP4LWR6jSInX8nH/kqqhfNvskTf838iSjBWc4RqGr8VhvuqwmA7O
 2ZUG3EFxIQ+KBc8Xv/3R5CKTFVCZqNGUH/aGlTil3tIQs7GtICdwOdeZDBT2X3Uzg4w/
 Te0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsi1pzzC27sHfUwrHxXyx0x5GVtylInf2G+NwY9ikvbWZgigT/Puzo+kiKW3xIsKh3YgfXPB+/UWzE2uX1m2pUIKQG7d4=
X-Gm-Message-State: AOJu0YzC6rUv568Xnt9XhOoONnbDrEH5jnkwttsNkF5MrGbRop0/z1m7
 p4Rh5AKyive3PC8849Y7ikiRLRkpWPgIFAGkrkI9gpTeQkiDAk8LSHReRC+FWGI=
X-Google-Smtp-Source: AGHT+IEEAu7esLtkXPd8xWUn6TRN9AvoM26PJOe9HUoTr0sD0nX4K9Tc4fhzBNrH01ZFsKe1UhHR8A==
X-Received: by 2002:a05:6870:15d5:b0:260:fcca:cf90 with SMTP id
 586e51a60fabf-26891a943c1mr22051968fac.2.1723028151147; 
 Wed, 07 Aug 2024 03:55:51 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:eb61:b5f7:86fb:b626?
 (2403-580a-f89b-0-eb61-b5f7-86fb-b626.ip6.aussiebb.net.
 [2403:580a:f89b:0:eb61:b5f7:86fb:b626])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ec73f00sm8424929b3a.93.2024.08.07.03.55.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Aug 2024 03:55:50 -0700 (PDT)
Message-ID: <340a7a2b-dfd3-4c7a-99a9-2f7034f0d20a@linaro.org>
Date: Wed, 7 Aug 2024 20:55:46 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] linux-user: Add strace for recvfrom()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Zach van Rijn <me@zv.io>
References: <20240807083508.28134-1-philmd@linaro.org>
 <20240807083508.28134-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240807083508.28134-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2f.google.com
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

On 8/7/24 18:35, Philippe Mathieu-Daudé wrote:
> +#ifdef TARGET_NR_recvfrom
> +static void
> +print_recvfrom(CPUArchState *cpu_env, const struct syscallname *name,
> +               abi_long arg0, abi_long arg1, abi_long arg2,
> +               abi_long arg3, abi_long arg4, abi_long arg5)
> +{
> +    abi_ulong addrlen;
> +
> +    get_user_ualx(addrlen, arg5, 0);
> +
> +    print_syscall_prologue(name);
> +    print_sockfd(arg0, 0);
> +    print_buf(arg1, arg2, 0);
> +    print_flags(msg_flags, arg3, 0);

Log arg2.

r~

