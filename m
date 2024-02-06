Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81DCAC48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 22:35:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXU1i-00058h-Bm; Tue, 06 Feb 2024 17:34:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXU1g-00058L-W6
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 17:34:49 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXU1f-0006ev-8e
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 17:34:48 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-296cca91667so864992a91.3
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 14:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707258884; x=1707863684; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PvPovBO1lGVkLcxmP2NfUSg1hGrUrFGQGoxOVG59smc=;
 b=V0qlRcbFws9je4vfKfEEFxE09TzWhf0RyZAMfXhTGY/2RL0OWJAqvZlTfBzZs96To7
 eKFyxAxPl3jh12Osox67OmkdLCBefFuj1sAuhzrfracpNUfLFsiONYvOZDklD8MeynAK
 /ieMWOJFI+98quE6j3+nJLNBB7avH+ZkypFthP7uSwFcN/NS5/ez49BnaSRBhE32VPX4
 TQHfSJ8pLKa3gWsufi9Cyb7vJBSk0+Ni1E4lQHIYkKRBn3C7gFtdCXQobGR7U3H9mLB6
 3U+ENBlq4P7jIzlX232/ld9zFoMwEAYripNgXzvrd7IdZonBZu4OuWuAfC0DEe24m0CS
 AbJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707258884; x=1707863684;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PvPovBO1lGVkLcxmP2NfUSg1hGrUrFGQGoxOVG59smc=;
 b=YySGJwN4dL53q/g5mh1rhw1SR6CadViA31PT7L07wQugLcNGdZwPhAR1roFqoSMOXX
 DlIeYuZYI7ZP6F2hZ7R4x6hgGiVCpIx4gW5FyT9cnbR+jqzn8hFCdr0/Qj7lwVaB0/P1
 ooP0dCsRRwGBAR9IQUWZNUPYF9DpFARLqnNYLic07uO0sAueVRFjK3geII0NDzGglGR7
 J6m0ek/pHsqPvwKxzObAwTBMXdcU/G84jV4/qDmacmlhMne3xSI5jaoJA3Ik7pVgda4J
 Kb1dSCeMH+wxxFdSzYgpl9TPFqubG8q8UPIw1gtU9riR7TPT35jW0/38w51iJuiKePJU
 NogA==
X-Gm-Message-State: AOJu0Ywz3wpQ0THEOhFW1LkU0sUtRYV0OxWcGmOw1LRqIOs3yGjZnyfk
 j+AE3xYzhyuc6zrxysE65CtMMd5BzTsbvBEXw0upERpL6vGIaC+FrEAEqRK0yZU=
X-Google-Smtp-Source: AGHT+IFFrwCfr0XGBFthEYXin2xI7XObJ18+8UJZo+cQhDnT5cQ+UQZXAUqk/e4OpZ3tYuOObrpbOg==
X-Received: by 2002:a17:90b:4b8f:b0:296:545f:8544 with SMTP id
 lr15-20020a17090b4b8f00b00296545f8544mr1025810pjb.28.1707258883992; 
 Tue, 06 Feb 2024 14:34:43 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUtzZedR7Dd80J/pC6Cl9PryyTrvX9YbFcyi73tXEkvyzRVfPwkioePxOz1ERmuFzoVgU06zUJdbQuZznkWKdMU1JVarAb9KeURptGZLsJw2yNZc2MfCTrhG5I=
Received: from [192.168.0.100] ([43.252.112.200])
 by smtp.gmail.com with ESMTPSA id
 je15-20020a170903264f00b001d8f3c7fb96sm27904plb.166.2024.02.06.14.34.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Feb 2024 14:34:43 -0800 (PST)
Message-ID: <0b532b64-296a-43a6-bec9-6450eb411a65@linaro.org>
Date: Wed, 7 Feb 2024 08:34:38 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] util/bufferiszero: improve scalar variant
Content-Language: en-US
To: Alexander Monakov <amonakov@ispras.ru>, qemu-devel@nongnu.org
Cc: Mikhail Romanov <mmromanov@ispras.ru>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240206204809.9859-1-amonakov@ispras.ru>
 <20240206204809.9859-7-amonakov@ispras.ru>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240206204809.9859-7-amonakov@ispras.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

On 2/7/24 06:48, Alexander Monakov wrote:
> -        /* Otherwise, use the unaligned memory access functions to
> -           handle the beginning and end of the buffer, with a couple
> +        /* Use unaligned memory access functions to handle
> +           the beginning and end of the buffer, with a couple
>              of loops handling the middle aligned section.  */
> -        uint64_t t = ldq_he_p(buf);
> -        const uint64_t *p = (uint64_t *)(((uintptr_t)buf + 8) & -8);
> -        const uint64_t *e = (uint64_t *)(((uintptr_t)buf + len) & -8);
> +        uint64_t t = ldq_he_p(buf) | ldq_he_p(buf + len - 8);
> +        typedef uint64_t uint64_a __attribute__((may_alias));
> +        const uint64_a *p = (void *)(((uintptr_t)buf + 8) & -8);
> +        const uint64_a *e = (void *)(((uintptr_t)buf + len - 1) & -8);

You appear to be optimizing this routine for x86, which is not the primary consumer.

This is going to perform very poorly on hosts that do not support unaligned accesses (e.g. 
Sparc and some RISC-V).


r~

