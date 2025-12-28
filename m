Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0830E784BE
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 16:01:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZtCQ-0006Vj-Th; Sun, 28 Dec 2025 11:00:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZtCN-0006TL-Hl
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 11:00:52 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZtCM-0002fZ-08
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 11:00:51 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-432755545fcso1337892f8f.1
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 08:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766937648; x=1767542448; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zXVlFMi9E6aa6AcpQe5CchOtXyLbvgvmBGWaNZw5jtA=;
 b=zHDMId0W0DN+wxd9BLYl4L9Zbh/AfElI9oaAvHBV7CIfCi8YRu1xTzPNBJ/snA1N2E
 xIIQPeU1gtfAyR/r360OAJlGNvQyB4vWveTeM5NXWx5S69cfw7nRhJfVhLDfJsKHGXoU
 eeG4tbEJEyrWY1w26ZlJiA49uhWqkwcMpyvgkrr8qD71t2gZ2iyaiFVlT3Bj5I0RyK7f
 /m+HK0BP37NFQeA2poRxg7zcWpOrB2In816lbJpsApD7HhX7IigsVPfdoEzjerT75YLV
 2XY4wWvgai3vKpTI8KpYMGA+vvO+c9zHRg7VinWfPsUEzxC7pi+TCbPIf7MCaYfFT3W5
 /4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766937648; x=1767542448;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zXVlFMi9E6aa6AcpQe5CchOtXyLbvgvmBGWaNZw5jtA=;
 b=dj+X9b8qmhKlBSr7ouDb01YYFNf3aGxPGqb9wLXEwgPS+9PB9h5OsNf9UCfNL3tzds
 wnXLZ9Tk7mTLTIOCJQEx906ZykbM9Qq8INicPPnb2HKuMJZsFliUOmSTbDuheBk3R0Y5
 J+FCysTVlZQG7e+CeSABEffnpRZZ3Q1pen1frzhcJvS/EXzTwe7oEUqHK4lDQbomo7Xv
 lsoVSWF7JWiqZwFLCgeEQnSElHGTSr9x6DO3sJsD0bX24wt3oLoo8vYQrM5hSZAMw7A3
 BIlgjv+PW+D7tf3HW7+ltLc/8IG5W5lKWeIrwLCVDyB8gA4EpexT7oP9iVPLRybhTYUA
 csNA==
X-Gm-Message-State: AOJu0YycwSE8zZcQi+D3BEHVfdxp+GeibLtJH+2BLLjHyzO8WWnWqPBo
 rA8wi8Rwr5patFcHaMvsdmz2+Pvi3nqBHuQ8I3fo0Sl5CGrNW4kLujTntM5ow95iB5g=
X-Gm-Gg: AY/fxX6mKI+RtyFeF4bJLwmCcLnBUqnjG5WYxeCmcbTD9GQL6OdRAFn+iI2JTVsaYmm
 WnN7gjJZjnUg84Verr06gwhrjFXBFs6bClFwyUuax128eLpwrbxWvI7gb2AhRDcfh9/otWJ3VdC
 OUDFLjr3T2cxIUexx79K1TH3aUyJAm1lD9tEDlAxOGPpvZH7Clc/+ScApyXwBOeFvAmJqxiFXdX
 vvtxR9oQAtKwdsePK9WYtYfxFrFt62gSqMNZ3exChZRKggkzn79JZwFTlkAngSwCchZ3jscy2o5
 m0T6XfO3JVorxi5mjQDDCIAxZ195RaUB0TfvaLrUc0oLI637kfxBHvEPIDyoJz34Btn9/kYuG/5
 3aB6Rt3Ul7kVXwYp1fwXu7B8NtNPgiIl5WQ9TFICJBhwbbs5fl4nIuJCMANZW2ld9KXRuLumvCu
 SxVTQTELEB8x8YUkqrmgSlkWV7XuRzcVF3JStxGU/6bDvX1CEbTTD95wtcDmqbNQ==
X-Google-Smtp-Source: AGHT+IHP1MWZGWY/JamR6bRXXVq7WIj8TxIKrswtZmWzJiUJ4TVx7qCig/S6yDRq7jv9hJVscfCNNw==
X-Received: by 2002:a05:6000:2089:b0:430:f449:5f0e with SMTP id
 ffacd0b85a97d-4324e4c8efemr29623209f8f.16.1766937648460; 
 Sun, 28 Dec 2025 08:00:48 -0800 (PST)
Received: from [192.168.1.15] (alyon-655-1-564-32.w80-9.abo.wanadoo.fr.
 [80.9.105.32]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea226d1sm58553731f8f.13.2025.12.28.08.00.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Dec 2025 08:00:47 -0800 (PST)
Message-ID: <378a7154-e3e4-40c0-b3e0-915ba80409cf@linaro.org>
Date: Sun, 28 Dec 2025 17:00:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/25] system/physmem: Use explicit endianness in
 subpage_ops::read/write()
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Peter Xu
 <peterx@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Anton Johansson <anjo@rev.ng>, David Hildenbrand <david@kernel.org>
References: <20251224152210.87880-1-philmd@linaro.org>
 <20251224152210.87880-4-philmd@linaro.org>
 <CABgObfYbU70d=02Sw=KCV-9fmZpFKoighKjxKfLW-p5Oi4iwxw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CABgObfYbU70d=02Sw=KCV-9fmZpFKoighKjxKfLW-p5Oi4iwxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 28/12/25 11:54, Paolo Bonzini wrote:
> 
> 
> Il mer 24 dic 2025, 16:22 Philippe Mathieu-Daudé <philmd@linaro.org 
> <mailto:philmd@linaro.org>> ha scritto:
> 
>     Replace the ldn_p/stn_p() calls by their explicit endianness
>     variants. Duplicate the MemoryRegionOps, replacing the single
>     DEVICE_NATIVE_ENDIAN entry by a pair of LITTLE and BIG ones.
>     Select the proper MemoryRegionOps in subpage_init().
> 
> 
> This would need further adjustment when the target endianness is not 
> fixed, but luckily the extra complexity you're introducing is not 
> needed. The two ops add either 0 or 2 swaps to the underlying 
> flatview_read/flatview_write so you only need one copy. As long as the 
> ldn_*_p is consistent with the endianness of the MemoryRegionOps the 
> result is the same.

Ack, patch dropped.

