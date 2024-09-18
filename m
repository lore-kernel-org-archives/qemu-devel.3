Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8155BCAC5BC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 05:24:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqnAa-00069P-Er; Wed, 18 Sep 2024 01:24:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1sqnAX-00068n-8a
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 01:24:01 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1sqnAV-0004Iz-Pi
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 01:24:01 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7178df70f28so4835718b3a.2
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 22:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726637038; x=1727241838; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sNpJBT2wjD4yr5ye8NZYUEZ4vRNM1K8fWAHoAywY3SY=;
 b=QxSq/a3cFyAaHRgWZcsCY59SS6ohJ3zwRs6vWG8y8lYqlClQ2SHIFUAwW6cQSpAl0I
 sbBjtGTdEU/nREsFiGwUhIJhOcPM5fxRpEWOcIVaI2keMDwPfV+rSMZUAssMctr15yYW
 wn7CphHupb8BE94d5vyQydUJCYkbKQpzt+VSu2UBVKDxtIFR6BiNx6wckaKT4Ne0PFtj
 W4O+Gdads+hg/92btj8mY6wcRH6p9pJ8aWsQJ/Oo+mYLxb9QX8vnYTQJYDMsxPe4U6AA
 r5tgLkspqL0mFuhfuEXpDaRrVe2vCs7UBectdY2BiPNl+1xbtlVqPBYcyn+h2IIao6q9
 Gr5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726637038; x=1727241838;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sNpJBT2wjD4yr5ye8NZYUEZ4vRNM1K8fWAHoAywY3SY=;
 b=SEgV1QckA8hBc9/QYFbMXhjaN4pvf9Vvd7ukB6Q2x/Ou8KkqbFW1o/Ftu9WNcj44Ho
 tb00kaOtsc35KkfaOq7ArPYnVxBMnhgXd6HHBoYiawTfGqrmCd6Mxre1QQybkNF3S0Nz
 VwBf/ynFKnGIt7oCSElqVixST/MGZFy4QUH9anl7kLDYqmZYKtrf5sONUzcivNyHefpx
 xo+TkwvYtIJ1q7IkE0rR5Ja9CWfweDdmhb5D+eorOK9DyQ3TuzFI3rovoN8MzqVMoMBf
 1wmsqV21r1vUkxYqk3l56ZU8H3UUruPL4CbXFDvMnIcNafiZzCG6LTfPE4eSvoQJqR1A
 OpIQ==
X-Gm-Message-State: AOJu0Yw8MypiSIqxgDJkk65o16RN3BOUAImUuN7lioOIzjAZd/Cje1rT
 W4gmV0dejI0UKVOmzJ2ivna1WxHnw9okjiDjv+GyX2kfh4pi8Lzr
X-Google-Smtp-Source: AGHT+IGJasv4mhUFOfX4o7EWMYHfubD1tmO223rZtzoa0qf3rE/EHk3BzAJ/Q4ITdz496n5ND4oP1g==
X-Received: by 2002:a05:6a00:2381:b0:706:700c:7864 with SMTP id
 d2e1a72fcca58-7192605a15emr36823940b3a.4.1726637037948; 
 Tue, 17 Sep 2024 22:23:57 -0700 (PDT)
Received: from [192.168.1.211] ([50.46.173.74])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71944bc8b25sm5967539b3a.208.2024.09.17.22.23.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Sep 2024 22:23:57 -0700 (PDT)
Message-ID: <8f669064-6359-42ed-94be-8903f430ffd3@gmail.com>
Date: Tue, 17 Sep 2024 22:23:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] plugins: add API to read guest CPU memory from hwaddr
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20240828063224.291503-1-rowanbhart@gmail.com>
 <87y146ruje.fsf@draig.linaro.org>
Content-Language: en-US
From: Rowan Hart <rowanbhart@gmail.com>
In-Reply-To: <87y146ruje.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=rowanbhart@gmail.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

> 
> See:
> 
>   tests/tcg/i386/system/boot.S
>   tests/tcg/alpha/system/boot.S
>   tests/tcg/loongarch64/system/boot.S
>   tests/tcg/aarch64/system/boot.S
>   tests/tcg/x86_64/system/boot.S
>   tests/tcg/arm/system/boot.S
> 
> for what is needed (basically a MMU-enabled flat memory map and some
> sort of emit char helper, probably using semihosting in this case)

Sounds good! Sorry for the long pause, had some stuff going on :)

Investigating this now! I've never messed with semihosting, should be fun.

