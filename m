Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BDA8C982EB
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 18:34:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgodv-00076N-3L; Fri, 16 Jan 2026 13:33:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vgodt-00075s-Un
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 13:33:53 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vgods-0004LV-Dj
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 13:33:53 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2a0d6f647e2so23494725ad.1
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 10:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768588431; x=1769193231; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=swm6l2jdhnHMZZ0BFZgZRvYdCCRPFwlkbi70vd77uV4=;
 b=Rnae8atAnXRyDI+IiB+N5bl2OyOYMhVP5drsmY0AbTOcjyF4FtUSqCJprsyucDy0Yz
 3X1BPmBhXXWmTdhZ7Ey3GVGzsxtQqHa/4a8wsEnCbbKbLu0BHlsyz/jdB8/Ddq5AXa4p
 RbScms/8neezVKcBdZ8twiDq9DAbvUnd0f/XlseAZ+GDObTsliNB1XURczzi8MGLB5Bc
 Qan+PqCpEKgrbbCPq/5MYp5U5FFU6j90Kfh1Grj/8ISBzKxL1+Lite+gCLXFhr6W1yBk
 pgkIkDfOGjRF/l4uye1G2uR8/7NmHi4FhNUSebiAvL5CuBesG3MpDUgfw8KWkUwd3QzT
 wleg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768588431; x=1769193231;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=swm6l2jdhnHMZZ0BFZgZRvYdCCRPFwlkbi70vd77uV4=;
 b=XTIg2RD3+Zm2TD1F1x+7+1iP98VzOtJJfrxvE+XBd1vJHt1LK1ICzSUBArJoobLJAL
 zDG3rRRFoZCXmHUKkwBmaWtE4mb+GI+GKdCretnyhZSb+PAJxjxqRIkaom0Sw1cpFLyE
 0EsxwwGB5h37iB1JsOXi+YrAqimhsF2LoeZnTIzlY4XPWnQrsdqwQNO+3TrlaExLA3T/
 QuLHNyMSSBnQweATS+M4djAwoYRyuy5LdBFu+WqtZIT0L8fJD9Ssf3HvcxsBm9RJ/sSd
 lKp1d7ylobP0+0z1AUuVUsqq8WB5B24Uc2GMJ2Mu+LUlfy2FXUZOWknlTWalZJc+dXW1
 e3KQ==
X-Gm-Message-State: AOJu0YwJ5H/8YpSGc0xZfCIfVqXQXbpzauKLsvAmTi5lbEIt976lCoMY
 tD6UPppeXKR4+oOX2Ksea6+6HRqz35VbSg/gc/Mocdj7eaRuXemzrF2lkLpup3wy5hVadF9HoTD
 3g4E1
X-Gm-Gg: AY/fxX4vXOoad22O1qNY4cdXlTcZr9q79uZcS4Ssbg8yt/rvK/6zuJ2Anr02Ap2Y+OD
 7B8g+Oku+Qk9VnR9LbOiM/i/TcRA1EcYoITJrRxoBa2iHLFXhox76+kYHVA0N04oUDECHezl+zx
 H7qTWC6wGixWjLeuexnpLcHncu6ZzYkxCtG4uE10EEEC9340hWy9ZbLfAeEWFSwQiXZpH8FlqUQ
 f+0nPc8lgO7lDRs5JYnj9zMkmLMgBU9P/spzqPB8Wok8kl9QwS3gAnS0IW5PYjUb+Aac5/G5gyd
 7vlEyplj8rN8aJDusJLrb2KJvKeqpkg6HWnjYdRGk3hjkEFtceYV4uLMXUz+pn3JQuv99NZ16vp
 P8Ptf7qy9BnMnQFEv02M/tLv9cJfMxMJo2Nm3BkcG2YYTY8W2CCLH23Camyur7Ytwtb53TFwj4b
 wvU26NaIPRlRUR8l2tN7b81PdW1HAlfjYB049Q8uF5gKzfmebwiZqtz2bC
X-Received: by 2002:a17:902:e84a:b0:2a3:bf5f:926c with SMTP id
 d9443c01a7336-2a7175cbc87mr43339675ad.39.1768588430513; 
 Fri, 16 Jan 2026 10:33:50 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a71941c088sm27068125ad.91.2026.01.16.10.33.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jan 2026 10:33:50 -0800 (PST)
Message-ID: <67f0b0d8-0e49-4691-90e5-88ce7899d5ab@linaro.org>
Date: Fri, 16 Jan 2026 10:33:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: add maintainer for docs/
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Phil_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260115203529.2713193-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260115203529.2713193-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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

On 1/15/26 12:35 PM, Pierrick Bouvier wrote:
> I would like to help maintaining qemu documentation and I've been
> invited by Alex to apply as maintainer.
> 
> Files in docs/ that are already maintained will continue to be under
> their respective maintainer. The goal here is to have someone that can
> help on all other files that don't have an official maintainer.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   MAINTAINERS | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4ddbfba9f01..786f3b3a456 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4505,6 +4505,11 @@ Incompatible changes
>   R: devel@lists.libvirt.org
>   F: docs/about/deprecated.rst
>   
> +General Documentation
> +M: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> +S: Maintained
> +F: docs/
> +
>   Build System
>   ------------
>   Meson

By the way, who maintains the MAINTAINERS file in cases like this?

I see mostly Acked-by in answer, so not sure who is going to have a 
final word, give a reviewed-by, and pull the change.

