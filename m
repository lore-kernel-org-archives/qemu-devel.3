Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22F4B103A9A1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 02:45:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5EFa-00055R-2o; Tue, 24 Mar 2026 22:45:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5EFT-00054Y-HA
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 22:45:36 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5EFR-00031t-Qf
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 22:45:35 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2ad9516a653so9873215ad.0
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 19:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774406732; x=1775011532; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XqIvIZi4dTFGZrQraGPzSnGfZCXwsc2pu5eZhvNuruM=;
 b=EVvZUPJ7G6rsc/4yt0BKxlJepsdTbsEarggABTshwr2/Z9ARhwm83DibZH3eDbKR/7
 SeJA47MRuxRybrvPvRyraoP9754Zuyg7gFPNOOnAu3yxogus1EzS/DCXvxBp+XfC4U/F
 FHvWjUZkxT9+OAUCRQvt2SPc4q9P9DKG0BDxSbdOSER944NVP4XG4a2ioALvqHK4HwSs
 0dVtC3tZIwGNq6RojZ30ZVd0AD5N5No7ZQkWgpd8hqWaJXIC6HqumXB/8dy6qBwfZUlj
 bUS8yvCBuTtE/dWCZENwdDOQ8+AlYqRQUFj5HLnafjQu8tAn//+9vS1VecJyKQLbgmKs
 kwNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774406732; x=1775011532;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XqIvIZi4dTFGZrQraGPzSnGfZCXwsc2pu5eZhvNuruM=;
 b=bc4hswp7LpurG5H5XbWZ6YTMputGjv/IRJsz9KswTe8rYvt3MzCq6nUe041ovX6SWN
 pO6GrefsC7pEr/CMt5q6aNTgSEmN8dRrNHIUzqSF5fsGvYjf0hDbqd6pc6zO34ICUNtP
 o5Ggss7SRi+tF7Z5uhAVGzx3zPmEK9n9hNEMpQNRfgEGzfOFUc/nh4vnsuO88wkxw1pY
 Yngk7BvpjxKD+dTTIOoWD9635f2sFyL5OBBIYpJWvcXECrpbHotejS0SlJBfAC8mODeL
 Z8XPfDThMleD4mYL4e2CnGRCGFdd28Bb4Zzu0p9GlRv3LhK962G9Mrxw6gUQxpxuYvma
 XfCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU37o+vTIVE1/Rxb94qeoNr/2USwys+Y2Er63kUjQ12VwDzO01U2XkAY23Mw3F5dIWufiSgvWkcpWZZ@nongnu.org
X-Gm-Message-State: AOJu0Yzzh3qdo91XEPo2xA6S5iQhqZ+25VPOwmKyrYyVq194h2QgV6uk
 XN2JZVmg78kkG/cTvnxnxBW/09ZiWsIentdBBaHW5Gkzd5chagef38AfGWbVLADfuNw=
X-Gm-Gg: ATEYQzw8alqhCR0Wi9kBX2BnSrfDJafgYOmaPbDABPgr27BI83RP1Uvjecj3YSVLTyb
 VRNTUTs5Kgwaomq7YzONnKHl0Nh8YqqRRltBNzjIF15rS1prmXvePG7EQuN7JsTck90SU4C9r9V
 /++5D6DeU74kB2Nv6qUv2M/KoYz++tFgNWW05Vh9eibG2sYJpc3FETjWqSAuhvAd+MKVxmMqQpq
 wdDJj4CMyazDd8Ut8rqBcLwpd/zytYvFxE4IKZ7zmRvbBvcHRTgcmTENiGEljAD3cdoc+arcXme
 6gI+1XptbVFJ0rQ1Ap2uFZf6VaI6yZqybo1iHyqmP8zX+tbMAzMFQVeynjIlX1oZMtkrnqi11Xw
 Hxlvz0vT/A2+6M6d+Fpp2025YZUJ3OAci5elGExNxh3OPbuncBzysQ5s1UvkrpzhADeSVutCzql
 jhz9UevoWA6QlR2wZf9qnv74F8JWhpFnio4zfWbCcRsuwDombIyJU+oLNlthzvMRAv/7GV
X-Received: by 2002:a17:902:f681:b0:2ae:b807:da61 with SMTP id
 d9443c01a7336-2b0b0a99b7amr19770205ad.35.1774406731727; 
 Tue, 24 Mar 2026 19:45:31 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b0836b6dc8sm169349945ad.82.2026.03.24.19.45.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2026 19:45:31 -0700 (PDT)
Message-ID: <54ea5215-67dc-4ca4-a3f4-ed9ed3d625d7@linaro.org>
Date: Tue, 24 Mar 2026 19:45:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.0] tcg: Pass host-endian values to
 plugin_gen_mem_callbacks_*
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260325004052.1026892-1-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260325004052.1026892-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

On 3/24/26 5:40 PM, Richard Henderson wrote:
> If the host does not support swapped-endian loads and stores,
> then we emulate those within the tcg expanders with explicit
> bswap operations.
> 
> However, we were passing values to the plugin interface in
> the middle of those bswap operations, which meant that we
> would pass values of the wrong endianness to plugins when
> running on hosts without swapped-endian loads and stores.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3351
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> 
> Hi Pierrick,
> 
> On IRC I expressed the opinion that there was an additional
> big-endian bug with how we treat neg.plugin_mem_value_low,
> but I now see that isn't true, because of how we adjust the
> store address in plugin_gen_mem_callbacks_i32.
> 
> 
> r~
> ---
>   tcg/tcg-op-ldst.c | 52 ++++++++++++++++++++++++-----------------------
>   1 file changed, 27 insertions(+), 25 deletions(-)
> 

I integrated this commit in a broader series on the same topic:
https://lore.kernel.org/qemu-devel/20260325024252.3369186-1-pierrick.bouvier@linaro.org/T/#t

Regards,
Pierrick


