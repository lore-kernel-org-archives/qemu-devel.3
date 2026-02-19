Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C25BEC531D4
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 21:36:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtBgT-0007AQ-TY; Thu, 19 Feb 2026 16:35:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vtBgG-0006ux-5c
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 16:35:28 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vtBg9-0002UC-Ll
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 16:35:27 -0500
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-c6e23cb81f4so546312a12.2
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 13:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771536920; x=1772141720; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DtIGIEhqHDyBt2iudraN5ym8jfmJkwxyMgzdUvrJwNg=;
 b=WoNbohSzT3jZfNM8csXngAThHIncVxbuxyY/vyp6ZqFzd4bRB5ErfGGNS+0DN5vthK
 1lP8SeyKJ5zA0d7n5WaJzGSl1rJSL/ALUX1bhaEh/3uPuRF6UxuI0g0GXndtOK1J6oXC
 vUzewpT3q4DhFo+xAYMppWyQ9HQCJhc4zrzoEjlgnH9SxBuzveZTCr391pWNo/7WfxOX
 pORn6ppoNdqj6q3+IRvuXebOj3sdgbZDWoHkrrQOYXTPIoiqnSkhJ5vfK5DfgEH65nyD
 E7O5v8fXjRtShe3wgxz6vNWGDREoMy3yJ1AY6PFpTAyQUbpLTICR4JWts+PU4/UQxFMZ
 twuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771536920; x=1772141720;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DtIGIEhqHDyBt2iudraN5ym8jfmJkwxyMgzdUvrJwNg=;
 b=tgU0OQBwVfCCf4VK4Ln92d9kmPH4P0XEYsvQJPScOlyLIEnn1lUGD9EUucXPhN4Ywj
 40BCPPWxq/N56BfH0cMNrOa9AxAM1mMC9l+yxg/9sWKK5wlH4mKvwMlpdNxLok9y4fLn
 qr79DjZiqDAOhLagv1xxMXgZPTD65FCnWDjIZ4iSSoM/qkdjx2RCTYlyXJNW8yL95prx
 lIJRjIqPzWtPwgjkj0sp4XJY75ahEZ2gDLWMQEYyg61BHIvWjR35OvzPYNv9+dcpHzGq
 9+Y9DgG9L6yF+YOTkAYnhxaTSinw1YG7hx7TiuVBQ7ykePA75bQQnYPx72YUvNiHSiME
 D9WQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgj7/Wef6h2+smi7zSG83/yCsXJlctta9q+MIYMx9pvkmRbnz3snmR2oeMR+NfjCHXMHxZhoM8UcTm@nongnu.org
X-Gm-Message-State: AOJu0YwENVXqrSfH+KAR86nBk8mfhG29MsA7vroVOLGvZGiisLpCF0Rv
 hOQWb6AvvHdO/ZthzqgoQY5XSZd0YfaCyRYZ+6/aYHuYl3H8d5WD4UTKtI26k1sYPLM=
X-Gm-Gg: AZuq6aKx4Gg34eaCeSKYH2ETmDAm5HQW0GdDJ8kRTq2hxUHpo5yKLXJXapv3TMJ/iJW
 XxilRy3qdnA34oKWtLhBYi94ilVD8D1k8/vK4gLCkoFkXAM8L0QZIkPGxI12j9+mHFOaNZ068tF
 0zyJi/1vl37grHv7qHB8K0aM/GnfMB6Bd8bPmjWOaV75N/RGM3wUGUEuNan6y4sAld80F5NsUit
 RxD0TkDdgz+DjzuNM7UOnFDcGngo0KfoHzcvm76oDPnuzQCQpTXJ/lARmeHTW9n/QMGmXfhA+2X
 yHhiKUQA6EwI5mMeZe998YEVMEijDAjEJnfyORpITUo2Fj068Zy/mHbOFM0gnlBssYZCjYHXowv
 6ndEcsJ/it0Hkr3hONRHdP7sBG8mUzBBANPvPg05IACqDo/ycZgc0HYa0tpx7f1tHc5UfI/nBLg
 vQaMz5RxPHXuXVGypVFPJOeIDaNbnw1p1mHS9PUQiLnaX5RjOmkzcF+miHPtn6a26VTKd3
X-Received: by 2002:a17:90b:4cce:b0:354:c593:b1a8 with SMTP id
 98e67ed59e1d1-356aabe5b7fmr16702867a91.13.1771536919996; 
 Thu, 19 Feb 2026 13:35:19 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-358a19b242csm157049a91.0.2026.02.19.13.35.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Feb 2026 13:35:19 -0800 (PST)
Message-ID: <f7456987-2e76-435e-ba82-5070ebc4ca60@linaro.org>
Date: Thu, 19 Feb 2026 13:34:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 40/50] target/sh4: Build 'gdbstub.c' once for system
 binaries
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 Yoshinori Sato <yoshinori.sato@nifty.com>
References: <20260219191955.83815-1-philmd@linaro.org>
 <20260219191955.83815-41-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260219191955.83815-41-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52c.google.com
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

On 2/19/26 11:19 AM, Philippe Mathieu-Daudé wrote:
> 'gdbstub.c' can now be built once for all qemu-system-sh4*
> binaries.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/sh4/meson.build | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

