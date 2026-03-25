Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3791D1093168
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 21:40:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5Vws-0001n5-Uf; Wed, 25 Mar 2026 17:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5Vwp-0001mf-IN
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 17:39:31 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5Vwl-0000lU-VZ
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 17:39:30 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-82a07738118so191579b3a.0
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 14:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774474766; x=1775079566; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gP87olMgCAUwpdcJ3gNSS/yeaeHR7ftMwLDDT+2nrC0=;
 b=GBsE9lhEA0J+XE6TWBFxLEUkL52UmrkwY+RRQDE+NcS3oSfvINHtmfjBEJjqjQ6HAV
 h3M+x+V5b2dwEYCBMRYWcJ4qy87Om3UkhTsWQCoYvwZqWq6UjWawhEhMtRHuNPT5eZag
 yZuoKSmT/sl/gKpLdJpP4tOE0L4pGoIxj2eu5DYPkfUpHTyZ2x/Con37WwEDx3nl2YiN
 2G02M+JWRzTxS6gKMbw3GjWl3QP8nnpVskdsp3L+gPt7irgRNmwujerNZBDrrJHJzuX3
 a2jggcSgdAtk4RlGZEUK2CL0IOeIE8mZ3cC3KKljdbXdyUAeHsJVqzCvWUpltcxnkF9G
 eDdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774474766; x=1775079566;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gP87olMgCAUwpdcJ3gNSS/yeaeHR7ftMwLDDT+2nrC0=;
 b=SOW9zMs6aznySeh4Md2JH0+iT18LfVMVqZ057NzsD4QBnLHtpPRxxfsaCNggYT5oPh
 YUGHch9dGskYpRwtK3OLi+voemr68hUSWAzzKSNAd5hn+JheG/ie387z3PsARjf4kX+p
 qkqLe5oAG0vDIwBXTXgGN4x9/JDcNCrKL7uCGnkU4fDmEMB8QOIoPeQWQBY1Elfq4nz0
 2oRyXaNllrGP6NaG4rptxkuEpA2NQ1FCtkG+NaIu5mGMSqNZtSU5s7aQpOCZOfX2n7H0
 laNhNl8039rApClNzs2ZQNl6tTFENyT9tVo5YzQzImUFTtCe5RMsOawzzncEoZ7KGCYU
 K08g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJklR3WHFDuY+ocK5z9nMMNYzZRnlw9W3ymmnqXyGNQXO2/2nwA8Gvt7VKmt3Ej1uDVt7Os85EoAf3@nongnu.org
X-Gm-Message-State: AOJu0YxJcX1GmRDKteGs9GyE8z7lwkdJcQlMoGj9m1DWtms5wmW7c7od
 B8tJaQ1dMob9dBK0iKu8O34BMBN8OoVEkwJOmYAzOjqpxobzRISiEIlS/Ce6UYxd8oA=
X-Gm-Gg: ATEYQzzangzF38bjeI+72xNaiXgQuESVavE4bfgzhl7cpW3fHQ+E9xs9IoGGEOU1enm
 b89S+R6NI/NVX8YLQcDQKYGEGYOep1er53k76zjtRnGeEB1fbn2BJAKOI6Qy/B7kCxkpRzEuIz0
 zQbUqmwZ+7bdYgzuayTHOcuY4nY5QU6pmXJi/1Uonz+DIjXuyC4B2VC8oLtUmfBljAOSaARpyAc
 oe8/qlu3bz4oF2QrnYHGCctsp7/p3Ey6CKCljJW4vMRBM7apfNR/4Mv2CXyP7hvPtjXqI4PuHbH
 XfZZ6fur4wNDcKq9TAOf7B6uNdudM+jcgwP//nsRBUbABeZ2x7cBqKXy6C8j3atoUfkPi1o/xZ4
 FGAKwloDASJS2Sz/4b9DJv55JE/Fp+6/bEuIbrYodR5dsv5udPOpXs9kQvaoPWfPYBiwu3Gbtaq
 fDInoz/osX7cJyoSh1Giwp+B4+cVyv3NSRoGhtzIt/k1qQxKcT0WLb7ZGVbnRTAXSTvLEq
X-Received: by 2002:a05:6a00:1c81:b0:81f:5238:5560 with SMTP id
 d2e1a72fcca58-82c6ded3a6bmr5149072b3a.13.1774474766169; 
 Wed, 25 Mar 2026 14:39:26 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82c7d1e63b6sm693650b3a.12.2026.03.25.14.39.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 14:39:25 -0700 (PDT)
Message-ID: <47968191-30ac-4c0b-beee-c22f94a32c26@linaro.org>
Date: Wed, 25 Mar 2026 14:39:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.1 01/10] target/avr: Avoid target-specific
 migration headers in machine.c
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Alistair Francis
 <alistair.francis@wdc.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Anton Johansson <anjo@rev.ng>, Peter Xu <peterx@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>
References: <20260325211728.89204-1-philmd@linaro.org>
 <20260325211728.89204-2-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260325211728.89204-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
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

On 3/25/26 2:17 PM, Philippe Mathieu-Daudé wrote:
> machine.c doesn't use any target-specific macro defined by
> the "migration/cpu.h" header. Use the minimum headers required:
> "migration/qemu-file-types.h" and "migration/vmstate.h", which
> are not target-specific. This allows to build this file as
> common object.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/avr/machine.c   | 3 ++-
>   target/avr/meson.build | 3 +--
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

