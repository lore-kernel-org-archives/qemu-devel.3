Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 597FEE8783F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:31:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnIN1-0005jS-7p; Tue, 03 Feb 2026 10:31:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnIMs-0005a9-AH
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:31:07 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnIMd-0004VA-39
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:31:04 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-42fb2314eb0so4695444f8f.2
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 07:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770132645; x=1770737445; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TBdV1wUbm8IUKNQagaDhb1Obn7Ei8Y8jeWJHjuzY1/c=;
 b=ACcCmdAA47ZW/8ZanHL/h0+9W6WMG2rjNve8sijnvfaVI7j05D9+GLb31yb8u3PZ7H
 Y1mTBotmnl7bKf0HwxeOAC6y5CytQVn5SkW71IoirQLEUQ83rV2z+PsSZTMXtbe2RkIX
 bcsBi77RZHUrlmuSklA4T+ByXMm/O8EzDz8Ej8tvQcTD7WxfZsHVtuPzy1s09Ik0iLKh
 VFdgquc3qRP9vNBrQOtd9l7zjLA6vRGj9N/nEtJRjGUVCXpluu0110pIC26FChaxBPTE
 v8OzIuMavkd33U4VA+crOFnAMLJ8rf9rZRv9yr+1U1KlD9d7mau4l006mCI9bMSZmaVm
 /FWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770132645; x=1770737445;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TBdV1wUbm8IUKNQagaDhb1Obn7Ei8Y8jeWJHjuzY1/c=;
 b=a5QaLAH2GG9Y+uDjRFkGZdhTI2gZXvKkRnqd58EZq+I6o9BPbDkCpNy/uIJxWR2kI3
 o9n2A0H1DYdSNXzPf1ISclE89N+fLTq3oNz55VXDi0pKKdKMAF+336LfvM5a7OYcI9O7
 rrvmVGC5nggrwdDTTQ49zMsgHuZ+BZOaOSJuSaG+uD74m6QYLIU06+ANVEK8tgajWN8F
 ocf7W9RE3aMhjchVxnJgcFmOxkW/9fcDGtjnZgRt0cHtCIAq2DnqkumswqJTJ+CODdbO
 ri6/wSM7Vc7gI/Y4hNy7TCQMkHHGdGZUM2aL2xNHB1N8EpqASeT2adQpvI5f4gXrlel8
 YtuA==
X-Gm-Message-State: AOJu0YyOwtoQdITzTIMLPvXa9QDwGQ1pD97xaiNLMgJkm6ppelsRRT0D
 LSxMmexjMxIyaZYS8NG8Xwe0C/W4hddZpMKXvwSFBiMg+U3EBIVHreywiDQvWIiMMzlZN5+Abvr
 Hn4/+5M0=
X-Gm-Gg: AZuq6aKTIdc34xdDCxelu1sGOi+9xt2JcQdP0JlWxBrHaa9ykX0BBvxTzAnRuIygByI
 jBVFgDnU6/11mMjdr7auOorPWI0T9pVKVBRxvA9uQvjG9kilK5WOAT79+XkrvsCUEcZv46WSTlJ
 aeJvBa2My7nw34RDknKNTlUQCNvfLwqNtg8hol2OYVtjEYoZnnLIsCcNY6kBL0VpWEWTR7x9eY6
 VFfBE+FsVi7NiVoOe3FPaUvmdZEEco4z86f6U8zAZu9lqvyBz7Bng13yNkMbiFjdrEvlyIwENpl
 Xr5aV701D9yW0+t2/VacJGEDH+eTuEWPYn7dLKbVR8PA0lp9rAadP20Hv3Mg3q2J/iJhd8ARmse
 W5PZBE+gnivuvlGyj7bcbi86OmEUCkdhEQxyMATormfUxF05vFxUhNxyUIFiW3+7dHevvPQWYiQ
 kcfpoW9Y1j4n/0zpo4w9vS4nuiYZCXb/VQ5uVqGUl6ajApmHLdVuixg2ZPP9BiCQVX
X-Received: by 2002:a05:6000:24c1:b0:42b:38b1:e32e with SMTP id
 ffacd0b85a97d-435f3aac886mr26901186f8f.46.1770132645132; 
 Tue, 03 Feb 2026 07:30:45 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10ed952sm54670150f8f.10.2026.02.03.07.30.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Feb 2026 07:30:44 -0800 (PST)
Message-ID: <a3602928-18f4-425e-b5d9-049563d5531d@linaro.org>
Date: Tue, 3 Feb 2026 16:30:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/m68k: Inline translator_ld[uw,l,q]() calls
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
References: <20260202214050.98935-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260202214050.98935-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 2/2/26 22:40, Philippe Mathieu-Daudé wrote:
> In preparation of removing the translator_ld[uw,l,q]() methods,
> inline them for the m68k target, expanding MO_TE -> MO_BE since
> this architecture is only available in big endianness.
> 
> Mechanical change using the following Coccinelle 'spatch' script:
> 
>      @@
>      expression env, db, pc, do_swap;
>      @@
>      (
>      - translator_lduw(env, db, pc)
>      + translator_lduw_end(env, db, pc, MO_BE)
>      |
>      - translator_ldl(env, db, pc)
>      + translator_ldl_end(env, db, pc, MO_BE)
>      |
>      - translator_ldq(env, db, pc)
>      + translator_ldq_end(env, db, pc, MO_BE)
>      )
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/m68k/translate.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Patch queued, thanks.

