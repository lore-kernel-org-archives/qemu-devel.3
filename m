Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A41107BCCA
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 16:37:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w15Vg-0007Cx-RP; Fri, 13 Mar 2026 12:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w15Vc-0007CV-RM
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:37:08 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w15Vb-0001gG-6t
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:37:08 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-35a07ed3ebdso1159871a91.1
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 09:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773419826; x=1774024626; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D9e7n3+eOHAhSltaMH8lQlOQWH2afwxBbZwtBbEcr8c=;
 b=mQTKY+d5Cokzg8ZTYTvNXJ+CCcca5gCamUydGTzYHmokw+Q9TB8Mg/Ky+tCtbJAtN3
 mrO/vc5s8FpPqlsYR+2xFEWxfkutg7nJkHVQHBOx7g/H5awZQR7ay8CTXPHrpnAgJSQX
 gj1d+7umaPhFFI7ouYwJoQymqipQY+THZtc5toy/WvvbfL4qaBrwPc8Cwu+yPAVZxEbo
 DwCPPTx7WdW2rAooDtexvEZOEZ1r0MJEsnubPmJCHrUJsQ6CcRVEnVGWzp6Z5NlIkzLP
 xbKwqLuAftp6O7zOWnCej97kFxbahhFCMDRYwdOJ9ngKJBKhCXB9Jv8QI9Nnrds3kPrb
 8BWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773419826; x=1774024626;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D9e7n3+eOHAhSltaMH8lQlOQWH2afwxBbZwtBbEcr8c=;
 b=lGkmo1Zk60Reou1vBmtwXTKcYw+i/3AcZ33C1dXiLnqSEk7cMVej3/6QJbUZSZb7/E
 cN3JaIpn2VROawcyMBFczVc8/MUkFsyrmJiY+BhUMVPfs0rj24BXMu1J1CHED/8Khq+X
 SHnW9aH4CNOOmwVW6kymcH/VHkuN4vvsVLaqh0N9nhgLVwJEZp3GVavO2yV4968gQi8+
 hE8phCIBNurPjiSRAXU8LZgqXmAwq+c8ViTm0sEULCH24jZPtj8/rT5lrwkfPGXUPBf3
 31OSqPdw/WwVsEKFC+nk5GXW5jdgYfjYm24aHYIQd8whljYU7a+jtQesZ2U6GhuTVbAg
 E1iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRE/bh9yScEiIZQ+L5N7Db5qg94c+WjsZthUvSA/B+1gG6C9Gch6m4Z2rPbOhpxNcyWxeXp2mHxmMc@nongnu.org
X-Gm-Message-State: AOJu0YyImswGr2yEneU3AFwheN3SMiQR6MqVtRxsby2Fgg5FJ2p4h7Ge
 6CNN8OYysBAPnLbAYGV302GolyAVlp2OMiON0Zlm51g7G6F1CYCr0dbcP7ucmHZskII=
X-Gm-Gg: ATEYQzwOHCNtV92fnXxfGIdNtIEcNKBL8McgqzN+BcvfaKKHsjP1YdJ7Hg02duU3hPQ
 TOhcLTXRuGljta7iFeH1cwBjsvWmTaztYUJD/jMqD/x/QRARMvA2mrdsQBlQ8lU0IfcrJgZK6LK
 DErusAzpYnz2l9+2ahMkNlREq68i10xHqcH88W/7y6mKeKBojBw2UMui5PV4ZAB9yH61Tob0c0U
 S5R//hK3eT0mbwkxhuFMUR5x7f48ELKPKtHHEOgPxupLAkbiA0eL9xWV2c3vfngQw6CG7dWorkt
 nghZSf/Sl3mhSC5IZnnKTqcfOloeHXsty7pwE/1BFpf3oX4wh2mymeDUiiUgauHoafFjL39ULpL
 d8IAybSreL5FdYubOpQh+6LJ03gqCbYzTm0ATNAcV5fm3BHIMNIfnSrDMr1nmZ28c27Ypj0iDjW
 XeVLIYnpOCmpRQdxWNTRKLsQy7ybkslLO2964ojUm7S0GVpwp957C/yHekvcXrJ+x5eDvN
X-Received: by 2002:a17:90b:4e86:b0:359:7b9a:2cec with SMTP id
 98e67ed59e1d1-35a21c808f9mr3625906a91.0.1773419825616; 
 Fri, 13 Mar 2026 09:37:05 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c73eb998e42sm2259267a12.12.2026.03.13.09.37.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 09:37:05 -0700 (PDT)
Message-ID: <f1b2421e-2046-4140-848b-c0c42f65ece7@linaro.org>
Date: Fri, 13 Mar 2026 09:37:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/38] target/hexagon: Include missing
 'exec/target_long.h' header
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
References: <20260313062055.2188-1-philmd@linaro.org>
 <20260313062055.2188-8-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260313062055.2188-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1034.google.com
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
> The "exec/target_long.h" header is indirectly included, pulled
> via "exec/cpu-defs.h". Include it explicitly otherwise we'd get
> when removing the latter:
> 
>    ../target/hexagon/cpu.h:76:5: error: unknown type name ‘target_ulong’
>       76 |     target_ulong gpr[TOTAL_PER_THREAD_REGS];
>          |     ^~~~~~~~~~~~
>    ../target/hexagon/mmvec/mmvec.h:69:5: error: unknown type name ‘target_ulong’
>       69 |     target_ulong va[MAX_VEC_SIZE_BYTES];
>          |     ^~~~~~~~~~~~
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/hexagon/cpu.h         | 2 ++
>   target/hexagon/mmvec/mmvec.h | 3 +++
>   2 files changed, 5 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

