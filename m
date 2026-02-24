Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC14AF4BB80
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 19:25:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuy1p-0006I6-Lg; Tue, 24 Feb 2026 14:25:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vuy1d-00067x-Qp
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 14:24:55 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vuy1a-0007PC-DI
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 14:24:52 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-823075fed75so107446b3a.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 11:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771961088; x=1772565888; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0ZySTsRJjhd9Y8WGywxsGm7DZloi04Z+cUlCJ5yIpsk=;
 b=PRi7OpoEBP3GAsWRrOJxSvP2MaHUhGCCkPYoCIUCArn0aqP2RWi6ZbUvECKuAUOv6u
 kuT4QqVKYMY4xMn2rTkOt+Y/GE82l26xE55oR0fvfVVOFSGW+0Pqn7KG0lvcoTUQeac1
 3BkMv0cIxo8ql0wmab++lgDERgvn/9HFPLcHX4N9gnIY3oW1AAxPECuYP7B7hAr3YCDW
 5SA+lXK4g0+7Qikcl51kXAN7YkzZ06Q2/CM7M3PWWebL7nNaQRGy9j051TFGAWop071d
 Lj0VOqJE4EAQGCmquR7nf8K1KmhtipEd0HJpgjPgcsJrcXrADPUQnln8V3F4BygSpwu4
 nNHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771961088; x=1772565888;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0ZySTsRJjhd9Y8WGywxsGm7DZloi04Z+cUlCJ5yIpsk=;
 b=ZykHTZIoS0adDWclVdtRLynWaBEwItY/X+CIrsDkjN0IhaSTneFkbYH0eUV6ZyRKPP
 IV5ciuyJ5vVF6LwvKTdUzc7a2bkcnPJJsNiJQOqc6y5JYmUGskZUSZ6Koy7tOcTmoiQD
 griDrP4qc5OQTgMt16VXaR3ADvvkLeOnrUmYMHjwihCSHzHZU5hA9+CMojWHc1ySwKfr
 vYBrqanTpxLsuLrxd4qQu5K056VYE3XODOfQ0RXByE00ukBr3trLvKFm9nWAhAPKVVAY
 hk+BMG7APe30PvpMXHNEsVsp4/LrDVPuTPJFZq2Yr+bsCgtdkOTJvD9Rmp5sKukDXpfq
 800Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNC9/KyLYjyJkfn9O2jcaLRSZUg9LxDU2lW2u3TJ7vqIpvoi3wqudCr1/IQCpAH1BKcHrglnENi5ov@nongnu.org
X-Gm-Message-State: AOJu0YxGXFZPNSN3mzxep3FrvJx+JnSeDb2iZsMSYBkO9YHDkv27SD42
 S8fiCGBz3kTb8/YWEsBAtL7N+W3KAiAU9L5xUI5rmjOXfh2ukMDE3V+u6DkwW78rBtk=
X-Gm-Gg: ATEYQzwGQEwKYDxNZLEubrnfPXodip/jvW12yfUg4A/u3e25nXRzBbWBX3Sc7i/HPLq
 /DWeyfhqk4C/Urnx0wcthfEJot2eHvBOj81oPnPZmAYDcH+vROFL86b5+gFGNS4aYMnNqODxr8w
 YBkXEC79BscismCiMHNp1/FVAC74irIHWQRT6N6qyNfIeqfayq6SGcQJAbUQDt2W508UuOTBMIb
 L6D7JhmW1+aHZNFWivGQO/ZhJgLWoN3IsJGviKZg56jjlpfvXCzZD65Dq3GfvJb0C1pTt69dJ1X
 j+BWVf9gMM7oEf7uqSiIdGrC8T1GNDh3KAU1Z62mXzRq6BLWtrnamvG8T1706oqh0tpjzWG30Pp
 fk6oWftDk3SfQ/FHnVPikcNxdRXh55SDEJFYfu0fYASJt7GP7uquHe7Kil9RRvz7vxcwk4LQ1a0
 iOkfl0DY2ISq8eaQCL+6qwopSXQp4AgRsF02eKb9kxBuCR3E0mRDutpy6ssfUYXirB3Qzz
X-Received: by 2002:a05:6a00:2e90:b0:81f:5acb:55fc with SMTP id
 d2e1a72fcca58-82720fd6241mr799415b3a.10.1771961087557; 
 Tue, 24 Feb 2026 11:24:47 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-826dd688aa7sm11903975b3a.14.2026.02.24.11.24.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 11:24:47 -0800 (PST)
Message-ID: <7412fbe3-8d68-4060-934e-2d42c7ae18c5@linaro.org>
Date: Tue, 24 Feb 2026 11:24:46 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] hw/acpi: Build stubs once
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
References: <20260224182017.99865-1-philmd@linaro.org>
 <20260224182017.99865-6-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260224182017.99865-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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
>   hw/acpi/meson.build | 25 ++++++++++++++-----------
>   1 file changed, 14 insertions(+), 11 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

