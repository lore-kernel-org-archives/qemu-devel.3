Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E710109E521
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 21:53:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5WAW-0002NG-PQ; Wed, 25 Mar 2026 17:53:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5WAU-0002Mz-Hk
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 17:53:38 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5WAT-0003Dt-3R
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 17:53:38 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-c736261ee8dso149204a12.1
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 14:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774475611; x=1775080411; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MTN9PrhZXAmneH3kUogHslVgeiHYm/md/wZ3ro5/hqE=;
 b=yMvb/egNXqU/eezTrpKpaeLSqXRs69LuTUXRbI8umrspzPsxn9maT6SjqKXqNAoOHI
 2mLjcSlPFltVyytuxN+8O8v60EsSf02kc7+a8jS1663aNFj2oKfEdnzFSodlBOo6ZMNs
 iHTZ9eNi3s/w6jMwelJKpfQypAyBVgAIOjuAgy6zNrXMVEF2+PtVX/0fQLnmyTi08r0j
 VWAvDZHXrkFP+pRrEHe/G8h4h05Hhv1PEXGJo4rcuEOQ2SIZzWI9o467m1aHHhxN43i4
 GpB4Lc67HSRDepvv/T/bkyYUuN2ghXxSGDiNFw1KWdGYuCitpbqaCPGCpUoEtkEy1lEY
 mZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774475611; x=1775080411;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MTN9PrhZXAmneH3kUogHslVgeiHYm/md/wZ3ro5/hqE=;
 b=NBhYj/qMDu17k5mvzFo4vBcgAsTwRvgeeup4I288WDT2hzm0frmUI/sM4zGGz45DhS
 cg7fN4vBYlkvUiPm0LInuaCx+y7nw2d4SIV6ReA3DphZNhiu0YvW9fXm92pj4m/Zghg9
 1dpe9t/ppavYxwpj2bBJeskFgjtb3VeZUCYjsXuFrr6El4U9uQi6+0CrpZ5sHaxfMFh7
 eGZoFvuV2q/YuCAoMwHxGRFsaiw8kKWO+CGxPpv8kCtiENQ9paDwCx51Y7NkPgzNQsSW
 CyfqS4WkL6yebcfd/7kxSW5RMtVUL0XvbUq3XvX0kKIRM8bHswttYJLcwJ7pzQj+aagp
 qALQ==
X-Gm-Message-State: AOJu0YytZdxo83lZNlVJbPRhF7V5AI3YXP/bHYdcU7xb5kI2H7WgGXjm
 9nW86GyfsLgZ+WW8t01GgPPGEX9qfgNlGaXT2JSlnvY5oW7rU4xVkl/tSk5+qXcgu6YohfkRAcG
 kP2JWDHY=
X-Gm-Gg: ATEYQzwU7LzkXtDB7AIKe+TCgWqjMfti1N+N4qMZxlmLXvaf52XN17YbVCneUklnIY7
 HVjALVyeyhInMyv1RbhFwMCMgR7TiTf4PeszmvjmD9GS1YUxpw7YodOLozLJMxIicwvYOyYw2lS
 N9lfutdTay0YJh3c1m3ku9weperTLd2pwDbv+3XEiTJgdhsdCj4rAtI7WxtSLRTx7oKSS1040f6
 BtqUQhOANgHek75cLHz12kmYndyexvKpekmeoPG2a0d8qg3Y6ex3Vf8jbtYJmycy0I4VC2rvFms
 ZB/psBkpdXYrM83dv4peWOBz5xxDBo6zxjPQ6mEAX+Ck2B6cB8IaUHFBuVSHlm4C2oBX9ItfoAb
 +f60NiMQZv2Oa9yxpeo8lTM2aoYo+/KOGtDqzvgp+MHXvcsnP6KH14/lyE706ZT+3wjTdhW1J7T
 gMRjcHQ//iuN+cfnfjRiAenvpGLVzICTb/eLoMisIyGii9ZMd8Pv9R85T/K6v1M0RNV0QX
X-Received: by 2002:a05:6a20:94c7:b0:39b:98e3:6a30 with SMTP id
 adf61e73a8af0-39c4ade3ae9mr5129190637.51.1774475611029; 
 Wed, 25 Mar 2026 14:53:31 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7673812132sm368545a12.9.2026.03.25.14.53.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 14:53:30 -0700 (PDT)
Message-ID: <62ab929c-2a59-4de0-a368-9f71510cc3ca@linaro.org>
Date: Wed, 25 Mar 2026 14:53:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] plugins: fix endianness for
 qemu_plugin_mem_get_value()
Content-Language: en-US
To: qemu-devel@nongnu.org, qemu-stable <qemu-stable@nongnu.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>
References: <20260325024252.3369186-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260325024252.3369186-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x535.google.com
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

On 3/24/26 7:42 PM, Pierrick Bouvier wrote:
> This series fixes qemu_plugin_mem_get_value() endianness on non x64 hosts.
> As well, it updates documentation to make clear that value returned is in
> host-endian order. Finally, it fixes tests/tcg/plugins/mem.c.
> 
> Pierrick Bouvier (2):
>    include/plugins/qemu-plugin.h: add note about endianness of value
>      returned by qemu_plugin_mem_get_value
>    tests/tcg/plugins/mem.c: fix endian swap in update_region_info
> 
> Richard Henderson (1):
>    tcg: Pass host-endian values to plugin_gen_mem_callbacks_*
> 
>   include/plugins/qemu-plugin.h |  5 ++--
>   tcg/tcg-op-ldst.c             | 52 ++++++++++++++++++-----------------
>   tests/tcg/plugins/mem.c       | 12 ++++----
>   3 files changed, 36 insertions(+), 33 deletions(-)
> 

This series is a good candidate for stable also.

Thanks,
Pierrick

