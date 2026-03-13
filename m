Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C233107BCCA
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 16:40:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w15Y6-0002eB-Lw; Fri, 13 Mar 2026 12:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w15Xp-0002Hn-RU
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:39:30 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w15Xj-0001sy-S5
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:39:22 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-35a08ce49dcso2211866a91.2
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 09:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773419958; x=1774024758; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nAxjwmT1lJ/MF6dtxJQEUlQQOT8AMnDEIZOFhX3M070=;
 b=i0FZlNYT6mWKyj6wfIQKKYEHh+WIsnfPAwIsLhBMNBJcqyjobMOxsyIPiOuqAg6sNa
 Ckg34a+CnIxOEQmE4b1KAnFzwjAErWftM/hDXyoEPO3zwcSN2PA8GLK+ld23//BTaJ0F
 gtPMOW5IXkTeIikhURKHhO79Bc6Fk3Pp18YXPfnTbn+9iTi2VEFcoeUAlDHpv2om38In
 9ACQfuSWlC8vczt5lYShqbmAd0itbhiMptx4ighOXaXyiONJpTf6Yi6e3RBHtCHidYIq
 /sGon6cWmC4xg/aSVSwrj1KHVc+jGPCEzjoN07jlVgfngP86YkfOPxS+w6l5vyL93aP9
 yt1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773419958; x=1774024758;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nAxjwmT1lJ/MF6dtxJQEUlQQOT8AMnDEIZOFhX3M070=;
 b=l3spPCeopgRndkdZI/JruCXbXxjTxJR/+sNpk/2RtkXdbjg82soB/3L2wc+JoCf4AL
 eYZqA1LDMc96/XzOOegBYYbip8D7hVNZ1GFiDzRb4QVJdrr58AgIindQGgYmPGoqW4is
 1vc/P57RaTEQPaD0UDTGSQNBAXuE65gXsUhghX9Y68zB+wo/frnYysmKJuhOQXRb7GL5
 2gH1DgWKo/SI3UU7uhHCHnhyNwBj5a96jjQkNSMrz00Y7VcmLS+gROiNFmiQLFhhwR/J
 pWc1VAYQUjkz4NjZRTlBW5Gu1SkRQIDhW6yWEvnyN4yFLDHCDpZwz8gUV8wOekbWgf/B
 Lhkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnk4O0w8qcwJj1ciPh7fu9MGeHkGslfHR+1k0q9NqSlIDVWdzry15MS6wzRs3yLE2Ylzp6tb0bcsch@nongnu.org
X-Gm-Message-State: AOJu0YxQbwczImmCHKVhZwyJXg/9qfnd03Ef0Vo9FUh/W9q61AyI+qFE
 JS/RB2SB/JAks1a+jAf/CHuM0taKY8QzAAWeAgUn7WVF06Z9yf6tdHApL+4NcnatiTU=
X-Gm-Gg: ATEYQzxciEZMZdAJOV9y3co3ADZZI74EhysOfL1luzHLIYar8DS5mUzglQKF+qBncSf
 GVVFhtaEReio0/W1D3e9WkNnrewcfMfGdNQCF48b39uk2qXPH6z8bBvqBv2ax6/X9u++D56b9py
 y8QN9Ec4YniWU/DLtlVj00czLgjSMzOkau5CrTg5v3ph0s3ST8//SulrI10h6d0j94YU7xK7x2b
 dUuVjH5Xz4hx4tXYDWpmgX1NLMhy/C3p25goZVl23QHBj6qhePgJnpswA7bENModpts22UUnPcJ
 urajw30JrsAahHLm5m2n6NHQM2aCcGwNOeambFEWw2tvtzR4qQQIj9bhY0Pq0rWKCAf+ItpPu8W
 FXt6X+DLHOLt8iVkpqq51LvelZDwejrAJD4NNsp1ADw/OFEXIKGVgozMoxe86VAUsnilCr4/dHx
 A1+8MnvLZHSQizN5290NN8FnE+/iz6SDw9p9NPvo0MS7lxegwG2nqdVhblhg6YEwozrwXm
X-Received: by 2002:a17:90b:3909:b0:35a:329:73db with SMTP id
 98e67ed59e1d1-35a21ea7df8mr3731197a91.5.1773419957803; 
 Fri, 13 Mar 2026 09:39:17 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35a02e9861csm9294691a91.8.2026.03.13.09.39.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 09:39:17 -0700 (PDT)
Message-ID: <811be700-e5d9-43f6-ad53-3f73205f9ee8@linaro.org>
Date: Fri, 13 Mar 2026 09:39:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 23/38] hw/hppa: Include full path to target 'cpu.h'
 header
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
References: <20260313062055.2188-1-philmd@linaro.org>
 <20260313062055.2188-24-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260313062055.2188-24-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102b.google.com
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
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/hppa/machine.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

