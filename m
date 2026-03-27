Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F8D610F287B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 23:18:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6GQU-0003yh-53; Fri, 27 Mar 2026 19:17:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w6GQR-0003y1-Rq
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 19:17:11 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w6GQQ-0004YE-9s
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 19:17:11 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-486507134e4so29682385e9.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 16:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774653426; x=1775258226; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g3o9B5rS2v+zuJDkRNb2jiOp5U6oRogxyU3DR52E1PE=;
 b=c2v0qyxvhQ7e8gLgcOme8CwsW9a5DuQFhUxQMBth/Vow5KPsazVqARkhqRnuEk/fxR
 2HFPsdZtqbQ3lXQCDd5dCF20rxqHmCgHPSuCf++GJxXlMHgiSHQmNX06y3Rqk5Yu2Jpp
 13C8ctAk888jZn7I9z8+rvaX43CbOfsfd/VxNwXZclwM+PT7LTHAcXMGyhHDu62G4TwK
 5QpLt+mgY+IoeLxazz0qAqzCTr5JKOd5ojMhae6FSlq3J4ftBPhJl/Srb/smRyY2eNiy
 NOIgOlNI2EtVekot28OS2VCj6r+YNEmRw/VuN3PoxKosJ32etg7NiUhrN69uUnkmi8Iv
 I6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774653426; x=1775258226;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g3o9B5rS2v+zuJDkRNb2jiOp5U6oRogxyU3DR52E1PE=;
 b=jgl/jg4vKon5CWqTOEG2ROdfE2d3brGZYhOuQ/ggsTXhVTHq2g/vplKvdlETWnW1Sl
 j48kqkc8T8R499EP7aPE9POQjOV55EUrNEOCWkRipPIeEiGnIH7n4YwCDyoWV5NzFoYv
 YiXUUCmz1Bu8u2hD7IqgixYFhDU7rkzFNdUipBe9eHNxxS97dKgofp6azJNx7B49NX5r
 zF0hDPs9NF0VW0DrwNnEFw8iUvUvIyj0epCwge2Trw6YkPofXPwVzQ7XXbb4vzSUnhzC
 A+2cM/b918/HjHfF93EOgL6YqfbkuPW5n0rMoYhcFrge/byf0qLsSJSQKHTuBhbQA3cp
 ObrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrPWA0f7H3dWXXpmPVp5IAkP9od21gFtuw+6nBWdUrD1CaTbezH979s5RpdCHhF3deFWP0tLVLzr0v@nongnu.org
X-Gm-Message-State: AOJu0YzFuhNaFn8KWhYauwqQ0nkkGDJUIHxkOzmSBFLlfxPJgJf0Te/x
 6pukRKhxDtvmJN9I5b++QnuzJFFLs1xy2juq4OLRjdec4eqQjlGxQTA//5O8e8cTU4k=
X-Gm-Gg: ATEYQzx32OScjUiFRH+XDe2bQADvFXkYUn7GpepLJp10kD6YUpECS56nIXc+k9q7s/P
 XkiBk1KE5ZMOuAgQzkYfZRp7lHTo4UedIiUoJQj6I8UCxHCmfocc9a/Arl03TNK9sl3JVLPjm0O
 il8pbJ30mgxBprn8pBHxOXM+PWoTc7mlzw0KbroXJOz/kKOHMXiaaVqy2UOcb7x1UmQGRf7XJV/
 C4X6T4d2LgDrBj0QJnAPjBbKoMnji1TUwbcnpHfB/mODy58OUyZWbIF8PYx0scRTMCRLWJ2cSkX
 EKu4ANZaq8GivKvELrl+HCCVldHo9L0mX64BycPA4QpY5PPBHo2QYyKdLKkhzN22lEOf89jfhI9
 JIDU4td8SRUrcFjOISQx8/4nsWRJokDbHUMeAivcJNWSct8uiBWkDqQHFPULLjA1pLB4x7B5Qp+
 oiqByV7ZdpD+Nkt1C06kOxVhyWuU74O9HqdvPpOKf8qoHAzITRvtkDHc7vqH+5mg==
X-Received: by 2002:a05:600c:a108:b0:485:4388:348b with SMTP id
 5b1f17b1804b1-48727c81d77mr60701165e9.0.1774653426512; 
 Fri, 27 Mar 2026 16:17:06 -0700 (PDT)
Received: from [10.202.147.66] (147.149.216.82.rev.sfr.net. [82.216.149.147])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48722d2366dsm114298845e9.10.2026.03.27.16.17.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2026 16:17:05 -0700 (PDT)
Message-ID: <96574787-aa87-44be-8209-3fcc7880f2f3@linaro.org>
Date: Sat, 28 Mar 2026 00:16:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hpet: fix bounds check for s->timer[]
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
 "Yuma Kurogome, Ricerca Security, Inc." <yumak@ricsec.co.jp>
References: <20260327174701.364328-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260327174701.364328-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 27/3/26 18:47, Paolo Bonzini wrote:
> Fix an off-by-one issue in QEMU's HPET read and write MMIO handlers.
> Both handlers check timer_id > s->num_timers instead of timer_id >=
> s->num_timers, allowing a guest to access one timer beyond the valid
> range.
> 
> The affected slot is initialized properly in hpet_realize, which goes
> through all HPET_MAX_TIMERS elements of the array, so even though
> it is not reset in hpet_reset() the bug does not cause any use of
> uninitialized host memory.  Because of this, and also because (even
> though HPET_MAX_TIMERS is 32) the HPET only has room for 24 timers in
> its MMIO region, the bug has no security implications.
> 
> Commit 869b0afa4fa ("rust/hpet: Drop BqlCell wrapper for num_timers",
> 2025-06-06) silently fixed the same bug in rust/hw/timer/hpet/src/device.rs.
> 
> Reported-by: Yuma Kurogome, Ricerca Security, Inc. <yumak@ricsec.co.jp>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/timer/hpet.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

