Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB10C48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 07:04:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raVmK-0000Mj-EZ; Thu, 15 Feb 2024 02:03:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raVmH-0000Ig-1L
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 02:03:25 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raVmF-0002AS-1x
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 02:03:24 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a3d484a58f6so59211866b.3
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 23:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707980601; x=1708585401; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BycY6fTgaNsKgOe9GijKFSG+ms7J8v9gSMc77Psb3OM=;
 b=tmj2Iq58ZT0JQKjOccoGbtyf67vQhjgxc0NXukICklfwETRn9MnRn3KRzG4Mp8jgu7
 JTNRZJL1h8TsNnYAJhcMNeXQhZN9tvDYyM6wtXieh74YWXLjwTo7/9w9r4bCsmejIVdg
 0nrRr6Yiw/oqLeMwoCF32uKkSuma3/Spvdr+gxH59fG9dcWptE47w5fxYaIvVoJx9a7m
 F7G5IdS9r9bS7dp6gPVUsMPGov7NO6eujuuFpUtlt2UBIl/ga4XrQU28LKBstgx7MQUR
 E207KuY9zHXyeAmJlziVOTQUKE/VtqmhbkMiIInjU10eZFiPrvsBOIQLFG/JUiHhNwNu
 mxcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707980601; x=1708585401;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BycY6fTgaNsKgOe9GijKFSG+ms7J8v9gSMc77Psb3OM=;
 b=A7HTe/VmTsCaDRGPtOYrgtLEfJ9wLRR/oynNIX4fe3JjOuGNeihDAtWp8Lp8hLH/0c
 UCDE5zF/Hi5DyX7ngJcud8eACi/G2ll7wQnMIeTitbTqbzLfy5R5dDXDni4sOtifvdcL
 jE+TITCu2zjm1M6T2jmOrhA7bZarf5iZx4aiDcOqPb4HZsBL47ZU8vz4CU5WVM9c5Emi
 pFaJl7/eneOMwhPRJlGRSOWmRAYdcL5DUWg24aCVxVHb5Q63wZNgPcryKNERdJsskS1m
 lmEc/zZ1utIDWs9S1F43FsyKhcg88JQCM3mFQ1/MLpn9ynbblcYuC3JbGTpZkAkRu20A
 Z/pA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlp+KWrPFMO1ghKY+vtfnCK16rGo9eloB8QMR9EL5aiGYMcvMvtICRSx43DVY5LStLBtfsdVXVSLD/Kjw+qF6BjiLTVKo=
X-Gm-Message-State: AOJu0YzHF6uA3InlqVa4iBk7UUjtDphznYHvwxgq7WjoBmkQQBAzBPaO
 XvKsqH29s+3pNpesDLUee/ngor3bMz+6glOCzC5u14FaQhxfFkJV5bsqLchE6gFxv7JJ6O/Xfye
 b
X-Google-Smtp-Source: AGHT+IEJVjOxUnxYs8g79+rdw1wIaWLp3t7CTsz1I8ZIdeRsQpXy39lGc/Xe7ZrGYt/mZe6/75bXGQ==
X-Received: by 2002:a17:906:3592:b0:a3d:95c5:4aaf with SMTP id
 o18-20020a170906359200b00a3d95c54aafmr333468ejb.50.1707980601131; 
 Wed, 14 Feb 2024 23:03:21 -0800 (PST)
Received: from [192.168.69.100] ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 vk5-20020a170907cbc500b00a3d60daaa72sm253766ejc.41.2024.02.14.23.03.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Feb 2024 23:03:20 -0800 (PST)
Message-ID: <1bbd0968-e3be-4d8f-a64d-8565ca795fee@linaro.org>
Date: Thu, 15 Feb 2024 08:03:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Remove pgb_dynamic alignment assertion
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, Alexey Sheplyakov <asheplyakov@yandex.ru>
References: <20240214045413.541677-1-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240214045413.541677-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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

On 14/2/24 05:54, Richard Henderson wrote:
> The assertion was never correct, because the alignment is a composite
> of the image alignment and SHMLBA.  Even if the alignment didn't match
> the image an assertion would not be correct -- more appropriate would
> be an error message about an ill formed image.  But the image cannot
> be held to SHMLBA under any circumstances.

Reported-by: Alexey Sheplyakov <asheplyakov@yandex.ru>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Fixes: ee94743034b ("linux-user: completely re-write init_guest_space")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2157
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/elfload.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index f3f1ab4f69..d92d66ca1e 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -3022,8 +3022,6 @@ static void pgb_dynamic(const char *image_name, uintptr_t guest_loaddr,
>       uintptr_t brk, ret;
>       PGBAddrs ga;
>   
> -    assert(QEMU_IS_ALIGNED(guest_loaddr, align));
> -
>       /* Try the identity map first. */
>       if (pgb_addr_set(&ga, guest_loaddr, guest_hiaddr, true)) {
>           brk = (uintptr_t)sbrk(0);


