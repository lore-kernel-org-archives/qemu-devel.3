Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF76107BCCC
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 16:28:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w15NU-0004bd-5t; Fri, 13 Mar 2026 12:28:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w15NL-0004b0-Qg
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:28:38 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w15NK-0008Uy-9Y
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:28:35 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-82748257f5fso2003990b3a.1
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 09:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773419312; x=1774024112; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gfzv7y2YD6B6YYRqCKy5u2Nm+PabUkwIpLH+sQ7lQcE=;
 b=KwdGw7agZcxzUrgWjKMUOvuBs5OPTHfrl2dcdtXEgyh0q3fyDwO7cQlt4yW4C9IdM5
 /6Lj5KT2RkqIl0zpjWY/2j86pdKv+/dINGjLw4FZS3qG4Mc0FOZ44tHMKHH4EC2MpAVe
 kg/Gq9IZ3SHdNODggo/4FCG2EBKei5D+G2SPTHT1+fbAkjbk6hQca1cktcllpDHcV27H
 AaGgDuooQrP5JX3cLnJokYiLHbhOz6kY5ZnYQBqzJpx7NHii4QqLOdvuc1aJNELv6Ds4
 QsE0nyFjsDzQG4Fr8jUcvD6Gs+3zkkB+bC9aaOard8Hx6j5MSsUt0xCGMUgGAZQDEpZr
 bFdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773419312; x=1774024112;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gfzv7y2YD6B6YYRqCKy5u2Nm+PabUkwIpLH+sQ7lQcE=;
 b=m0mnE894jyBn5uxoHM28YONMXxtnr8lrXEKB4H4Fs2TYobvhcxPuzjydRSXNNicAE5
 pP624zWoQACXtmUPQBsJTDdGD0NmYWPSmXX0bkS+Z7/F9Fxg7QCeHXevR2Su2aMUGsp8
 vyddiPw5loQ9f8dprZE2xHsRkAS4VnexywM//2WuI4vdcdYFpdSM16e8tZHcxBGwMEMj
 4bTZYr77f/kiikkSr34CBw1FVhDE9ogJ+pyUT+g1AeJXSe4pFC0jw/TSs5Eg4kZkUUW7
 luBNIKqUx0+6GlZnqjqNqxCbIEsEyuCFhKPLZlDJG3ejaZVv94ZjSODMyJGQHg82HVXJ
 EUwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXY/8owhkHabCWJsIJUJJw+u8S6jDnEzdbeZPCKb8/DCrIUumuTmxu3ORAjM4rcxJSVMTjeRdqX8utA@nongnu.org
X-Gm-Message-State: AOJu0YyHuyxa9gh0c2BKd+2mSI8NcyQcbLM8QMK0B20VYU85tmNWC7ml
 z9zRMUkZqVMIjGoAFtA3HpRkcwrlD/Zy7O9uLM8DNKW+9RqRVGxTldKMA5WoqQnOH/Q=
X-Gm-Gg: ATEYQzzXt3wQlUjqxo+YOIaRGQQooj6a0L8WLDPS+jq6MmBvEqCcekvJM5WvLQrSWvG
 Q1Ub5HMQKzmXS6/GKI1LJQ0NbvjNWmHNUccZVkkI5Swvt2k/lluF+E6fwh59jBQfpw8xhQKzlmX
 31h0wGfREejatMDKBqS0nNYPD/DrNccwYZlfr4hUNaMxSjPt3oH1vUFwGQCwpad0l51kkGZ/nz9
 lEsAZm1q5Mt5xQ8WAdhB0TGEXQGTo8zNjnOQdLoLCWGhu7GuhdD6OlKM7XPJa0in4pJ62HaTeyr
 ny4Sya66MjrAo5dW2SHceMiHPMQpcd1/26lZxAwAYGQuNlVJjVUzEfWVY/UMXiDh3HZLh9zKF+c
 OyDn5DXBQyUzKpqi+CKjqVa+ujdA6SjN+MF6+9mW4JTiSZtwqkAbeMvStH7/iZ7UMQphCaTREMY
 D6WPfWLhidPpdPjZ2FFkx24SWUV4m6gRZjNTOnNnZr8oFF86NpKR489KcipJt7sBm+nZYW
X-Received: by 2002:a05:6a00:7594:b0:7a9:d8a8:992a with SMTP id
 d2e1a72fcca58-82a071dff21mr4835601b3a.13.1773419312365; 
 Fri, 13 Mar 2026 09:28:32 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82a0725ca0asm7934860b3a.17.2026.03.13.09.28.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 09:28:31 -0700 (PDT)
Message-ID: <50b59f2d-b3c9-4c81-b505-62d0c08c814f@linaro.org>
Date: Fri, 13 Mar 2026 09:28:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/38] hw/s390x/vfio: Replace TARGET_PAGE_BITS ->
 qemu_target_page_bits()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
References: <20260313062055.2188-1-philmd@linaro.org>
 <20260313062055.2188-4-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260313062055.2188-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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

On 3/12/26 11:20 PM, Philippe Mathieu-Daudé wrote:
> Get the target page bits at runtime.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/s390x/s390-pci-vfio.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

