Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E700107BCCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 16:40:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w15YB-0002sL-0g; Fri, 13 Mar 2026 12:39:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w15Xr-0002I0-2A
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:39:30 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w15Xp-0001tL-L9
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:39:26 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-358ed696623so1122115a91.0
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 09:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773419964; x=1774024764; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FLJR9yvhrYR3UyyoKf7AstWCZi5TzIXigtf6EGGqhss=;
 b=dh9iRrtUwG1Ts4v78DoUJbYmsrJHWr27Tqwycbqu+f1gYdZrsJC1QJvoFSceQvWG2+
 3ItuYgekd7MdGiLe3rjCRomfwx7LiiU90xrH6TKWYkGSZLOThCpxlK+exA5lHAIZMFmQ
 m17QGKmvhV3YHnWkz7xn78h1rmwlDqd9Ep9GD/BLl7CgzbjMuikStthbyamtmWKSRIr3
 wtk/VoWrSTyFn28miVEnmS0VPzrtYaIOS5gVkvSud4yJHfXJeIYmI4texgu1FF4yKTot
 wi3v90QomsGkHBnMIvR4CHXIjW699HAoSCLcBu4dLUuOhTXP3yBv6bdCmYtO5uzD4c/r
 05Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773419964; x=1774024764;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FLJR9yvhrYR3UyyoKf7AstWCZi5TzIXigtf6EGGqhss=;
 b=NYJcat8MVY+DvOgoWHlqW/zV37q+UdJN5CIiHTCtt13S2Q6zqzam3EahJqGh8eDGgi
 I/GefNu8ks1j5eJhnFXsOyF2ubJb1KWyUUfa/Szwvj/LX4KSoUOa/OYRs2Mp4Bv9SS+6
 7fNV3NlSagUp/X52Myem1desMJz2e+r6HkrHT26/NzzoBSyj6n2wtjy23squxGA/vPFj
 rRuZGOPadsEQdsSkU7QRsdIHQwEqgT40tOyUsqrvnN5mMrA8iZ755FHebsBrGRrtUNdu
 RKa0gF6SYnQTda9JDhRq1n5HAV8j8puG8IE/RMxab8ka3HTlEUFsmFprGDWUtDnpI9KW
 mBpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwxQ9K5mMJoKiBtouWiAqyyXTCQclW8xMZQsM/9qi1MraS82A7CpaFFyWrNL59BV9rp4RBvy6Meez8@nongnu.org
X-Gm-Message-State: AOJu0YxsLMgayIuu33Lv9W4mis/WlnjESQTIm7l9b0w8BiNauyBBwTOg
 4zRU0Ip7eR54bwOK3d/GkgAMd/kpp3v03zh4zTAWHk/daxJIqc3Od2cHGEJEWH6o0vo=
X-Gm-Gg: ATEYQzy+G+FdKmVW92IdiM9zIpaFihDva2NSbE+8WzhMuDmJaJwAVOu39ny7tfQbl5W
 yDas2F2ym/9HuVlTZvq5UzDbXYAAKSXKUVD76Yj3yKJWAJx7J6qQcYTdTperbKw3LVrH+0ZErn+
 FG+8MeC/6q7ff5HJZMj6q4bzGeLCYTfZhe50f40Oub0WN46YkjmtY/0813k6g6jJejmdPepiG+H
 vPeJ+608GO50Zm/wJt+ESMvy7dOZf+MwGv6DQ9ZEiw12o5/rZGM3bSTKAD5B4F8Z8229byIcIyW
 52kc5vXwg5zzWwGbeWAhcca2etZr3XTM4PmMGfnk5jyykIS64/ql/woesAtAXYfER2+8xNu3NXB
 1i71Moz7yDtnlZYDcKVLjhxN7va1X2lCtnnO4QMAAWMvR/bpjpEFbcW7w2w6kDLX95juj0QZn63
 xn1LSokz+3jgdkebjBjJ299mUpdTQRpeu68r6lNgM7NInxLDOMDE2fRkXzUJJiC0Ny1ih9
X-Received: by 2002:a17:90b:1641:b0:356:268e:ff97 with SMTP id
 98e67ed59e1d1-35a21feccbemr3323494a91.20.1773419963724; 
 Fri, 13 Mar 2026 09:39:23 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35a02e9861csm9294691a91.8.2026.03.13.09.39.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 09:39:23 -0700 (PDT)
Message-ID: <3a354bb1-60c6-4233-a31b-0fc5060fa23e@linaro.org>
Date: Fri, 13 Mar 2026 09:39:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 24/38] hw/i386: Include full path to target 'cpu.h'
 header
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
References: <20260313062055.2188-1-philmd@linaro.org>
 <20260313062055.2188-25-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260313062055.2188-25-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1030.google.com
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
>   include/hw/i386/apic_internal.h | 2 +-
>   hw/i386/multiboot.c             | 2 +-
>   hw/i386/pc_sysfw_ovmf.c         | 2 +-
>   hw/i386/vmmouse.c               | 2 +-
>   hw/isa/lpc_ich9.c               | 2 +-
>   5 files changed, 5 insertions(+), 5 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

