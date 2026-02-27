Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C831039895
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 21:46:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw5f9-0003ig-8Q; Fri, 27 Feb 2026 16:46:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vw5f1-0003dc-AQ
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 16:46:11 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vw5ez-0002Fe-On
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 16:46:11 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2adc1d9ec56so17641585ad.0
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 13:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772228768; x=1772833568; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wZPrmtGnDWxCTaUXHbiCyDk4+v8vq7JNN/k3wEhUglw=;
 b=QN11r2FmNUMdK8iUdBpm5JPYe/LB8VLKBTf5HWfByQoLD2lndCZTSpP9X17eRgF6s/
 EIKtt6GvxFDTfVWJJ+MVDkOgzVv1GI3DcrbjPDnH5lbSp04S7uDxNutahO8NhxgUMpzM
 mCjsanWDpn2AyZr5Eya2R4pDWY7WVqgQCvRiZloe8rb+YeFQWfwlLpKF8HQsEtWrlIv4
 67uwsTadQH7Jcjd8x8jUJ173oKR/4mWYC8FlzdIphtn/BtpFcCYSma1i44uRwttPHw9T
 CrhaCTIt4kFMljDgaLT4oyLoJyRGbKBrNb3ep+6XyDB9t41kEzI2H1Si29hiURjpA4iw
 fmyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772228768; x=1772833568;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wZPrmtGnDWxCTaUXHbiCyDk4+v8vq7JNN/k3wEhUglw=;
 b=YgCPmc41OHn8ZyANUQJbLQusapfiaxXLJwCYnNCjiOkGjw9c5Wpa+etB3QUKPV9HCk
 NypMFTC6cRg7LLWN+yCHxntALAUy/oxGXKIkoz0L8k+1myiYJwc2Gngewvr7I8M6Id0a
 Pe8CarahAknbHVsn8MePQpkq/dO60whh1tJ35VJIBeJxpZgoPkZQv/qpTZyC7dSiN4Gx
 L7ikU7+HDxmmhq0tgHmkFQKB4pKxJnEa+Zdgipadyv/KFGVXO2S020/Q/LNI26D4ZcwY
 OfIxOFlRzYeAdma33Uwa5YON5gYE6HV7YYglRaSangZza/dW82b3s2wnFeeOYsZasW8l
 UjyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGOV5sDNm1p4tXSIgxPdLEgzppQazPLpo4pI2jhdNs9vScIEJbqylcv9Fh5OHVvr/UUeIk6gsIUBtu@nongnu.org
X-Gm-Message-State: AOJu0Yx+cTFNRtlxyVX2w8BI2l1hjmTWgl9cW+7dKHFMS9NjopXGfEfm
 2JRnyOrDMXst1D8yNmfLLojTROv5o7BwgDnbuvTVkQFpy0K+X0zOru/nWQgE+A7oRM8=
X-Gm-Gg: ATEYQzz8L6ve7c2wXrlV8pUi1EwgBrRkxsrF+H56CDoG7lm7NLt7dDbMjFtsKwy4IYC
 JRrUu3U9S8qEK/anFyVTc+PaMrGsWl+xm30ZeeSa1X1nCohumZTL7jr2xq6Pqe63iB6n3nnC5li
 O0VYNUNTUzGN5h6RBGCLXr5PabAQuGUQV8TBuB0Qd9AqnhHY2PgfAUWRECo5KSOH/deCMus/31T
 oV7Oq6aNwm9w4UMoHPcOWjf45KofjMybU2cEVGzCqkwFXcU0mkcBkzstXpEp/pAAuxARDWe081K
 NweftK5RUn7zw7pKkmlFvX0FuWYA8PoJ4wnRIlhFXWS74ZjcKc6wuWXhlz8UlaX7n3a8MQmgW7z
 tearEwexi1Kq7Ip026tm5GMLoAItZXmXmFpYQGYuVK/f265qkejFuoEFVbMheasEOYG0XC4RosB
 auUeUPxe6KKjBSgTAw3f13bvH9XJfcgNRsooF1++XzzVl2YG640NtchXI+33vVIiLpoJZj
X-Received: by 2002:a17:903:1a06:b0:2a7:561e:690d with SMTP id
 d9443c01a7336-2ae2e4c1de5mr40554045ad.46.1772228768238; 
 Fri, 27 Feb 2026 13:46:08 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2adfb5c9f79sm70023175ad.33.2026.02.27.13.46.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Feb 2026 13:46:07 -0800 (PST)
Message-ID: <f5342529-402c-471e-98f5-c8f6f776f1d3@linaro.org>
Date: Fri, 27 Feb 2026 13:46:07 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] gdbstub: Remove @g_pos argument in
 gdb_register_coprocessor()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Florian Hofhammer <florian.hofhammer@fhofhammer.de>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-ppc@nongnu.org
References: <20260227213958.21170-1-philmd@linaro.org>
 <20260227213958.21170-5-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260227213958.21170-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

On 2/27/26 1:39 PM, Philippe Mathieu-Daudé wrote:
> gdb_register_coprocessor()'s @g_pos argument is always '0',
> meaning it is inferred from cpu->gdb_num_regs. Use instead
> feature->base_reg, but check we don't overwrite other indexed
> registers.
> 
> This fixes a bug with the "power-fpu.xml" file [*] which was
> loaded at index 70 while the base register is 71. This latent
> bug was exposed by commit 1ec0fbe2dda ("target/ppc: Fix
> CPUClass::gdb_num_core_regs value").
> 
> [*] https://lore.kernel.org/qemu-devel/e44df309-d40d-46f0-88a8-7ac55f9a3634@fhofhammer.de/
> 
> Reported-by: Florian Hofhammer <florian.hofhammer@fhofhammer.de>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/exec/gdbstub.h     |  3 +--
>   gdbstub/gdbstub.c          | 16 +++++-----------
>   target/arm/gdbstub.c       | 21 ++++++++-------------
>   target/arm/gdbstub64.c     | 19 +++++++------------
>   target/hexagon/cpu.c       |  2 +-
>   target/i386/gdbstub.c      |  8 +++-----
>   target/loongarch/gdbstub.c |  6 +++---
>   target/m68k/helper.c       |  4 ++--
>   target/microblaze/cpu.c    |  3 +--
>   target/ppc/gdbstub.c       | 11 +++++------
>   target/riscv/gdbstub.c     | 18 ++++++------------
>   target/s390x/gdbstub.c     | 15 +++++++--------
>   target/sparc/gdbstub.c     | 12 ++++--------
>   13 files changed, 53 insertions(+), 85 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

