Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A392F4BB7F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 19:26:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuy30-0007KW-E6; Tue, 24 Feb 2026 14:26:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vuy2Q-0006xt-8M
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 14:25:42 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vuy2O-0007si-3i
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 14:25:41 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-8231061d234so4638403b3a.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 11:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771961138; x=1772565938; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FocgUHifAMHkPkIsUH6B5ZDW1eP0itObBTNdWnGm8Os=;
 b=u2BjfJz6Vj64iuQAmBac6ugz3W0WqIizHritntxk4CsbavtrQI6nbY6+qHXvNd83qn
 6aaF83P9Hjv5JJDjegUfpDiWILAHINcDXz+qtKNpuvnyX2Px7RzCOiUW9jWHY9gBp7NT
 DC5m3jVycvLxZR8tm9BWfePGp4wHIhwnMhL8D4qE4LmCFsnhfJCY0hTLZ1mAsMphU4pb
 OFCP/9y6Oeyed8uOBT9s7T2DWuGCY7/VnbEVxWhKxVWuo/G+6Zv6spnEwGTXobwKJb/4
 WmC19R8c0FhyQ8MQywuCOSmtLyUDu+CfNUojD2mJmJh3MI2B8UE3GGxaRc4NCYqn7TCS
 WlgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771961138; x=1772565938;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FocgUHifAMHkPkIsUH6B5ZDW1eP0itObBTNdWnGm8Os=;
 b=jq5v4rtXQtqXw1X6TaWjFgoZVfMKcjdV1yFqB+CXFi3B4RGC4UnBrXIV/Loy04f/Bh
 rTR8m5imcUoAv1MYanH8cn6pE3R1XLQpmYv56f10h9mwUYM2v5eX+kQI4dIq4aYx4dGJ
 56rp1CttxQQU9q72s5nTbzUDDABZB/brR5UfeBv6YIwUj2/coYoz+IVtLFW4Q73YZVl+
 RkW8Ltd/atfyDpFcEyETP45lc95oS82yb5zfbxS9BfvTMtJqlJ1uhtkbb2XT7qlGFSSd
 faUr5qAhrNCDNp3G+G7qv0LYaDQs+GhkxkYx6q0S+d50OUmD7n+tw3H1Hvb01TT5cWqa
 rhlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWVliLeNcA59MUNjjWKLL+Hm7g1nWx09WOQ44PR2/fxCcMwNNuAIjfJONbBjICGN4uqAD4hBmSP6AL@nongnu.org
X-Gm-Message-State: AOJu0Yy3e+1AO2a/qWdnNOSYs7nKt/lmcARbD2m+L3dcYERh8Z7xbr84
 bIBB3qnjFry9aTYq8rJPcO/H2Rn8dUHPe5S6reeRuUpbW0Cw96BE4d3vgXUSFvH1rP4=
X-Gm-Gg: ATEYQzz52VCSEF6vPJmU2iLIRMMJmolX8T+/OqNiDZl3Uwd9DLtBoG6XB1yglFDsKTG
 L0LodFJN47bpIw+KcMc4KDYdkQjZA+75CC7pndmTP+nYaSYoSpoqe9Qsh6katL1HBKXmuE1pli4
 I5lcVirt5xWb9BTR6rgkfdC4ovTa2vBQdMiDUX219K35uFA1b7/V3deV76UQVqN+etOqfYEOhMN
 QFC3JJlEhvTqFlT8Tjt+UqX8V02FxZfgqAzIW0MlWoKBRHUQtLpv6GV6iNv+IXGorVKYhxUq+QK
 L2x2EhH/gdhVmbbbjKWG1S7lrMeYK2z3eGfLiayZS3F+Fc/9gg3zWIVT2ZBRn9feUcqBwfPjvK1
 bdMbZe7XSM0v/RFHk9T6jG1Hc6oQJrvL3JdVccfZNTzkFBcOBCuDG+tQS5vU+ZutKu1QFSmX1ba
 BC779dxrERlopDONsiYP303SWzpqGy/M8zmZLmKbj3fw/C5lcYN7rhDYX9HeNx4NnVhn0X
X-Received: by 2002:a05:6a00:2451:b0:824:b024:93dc with SMTP id
 d2e1a72fcca58-826da9ee7aemr13748210b3a.35.1771961137797; 
 Tue, 24 Feb 2026 11:25:37 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82719e7ed8asm1713812b3a.5.2026.02.24.11.25.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 11:25:37 -0800 (PST)
Message-ID: <16b5ff27-7c36-4f62-a147-b8c95e428857@linaro.org>
Date: Tue, 24 Feb 2026 11:25:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] fsdev: Build stubs once
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>
References: <20260224182017.99865-1-philmd@linaro.org>
 <20260224182017.99865-10-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260224182017.99865-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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

On 2/24/26 10:20 AM, Philippe Mathieu-Daudé wrote:
> Move stubs to the global stub_ss[] source set. These files
> are now built once for all binaries, instead of one time
> per system binary.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   fsdev/meson.build | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

