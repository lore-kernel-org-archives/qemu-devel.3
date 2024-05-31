Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B616C27C44
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 17:43:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD6Hu-0000oH-ID; Fri, 31 May 2024 13:43:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sD6Hs-0000ns-44
 for qemu-devel@nongnu.org; Fri, 31 May 2024 13:43:32 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sD6Hn-0007Ai-Ug
 for qemu-devel@nongnu.org; Fri, 31 May 2024 13:43:31 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1f44b4404dfso20553845ad.0
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 10:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717177404; x=1717782204; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oNAheale54PPUTGUW/lyMKAZuGL/kpAgevOQ2nmQkDE=;
 b=GrTF790LFJDjilFoLR4W7ksKfb0WZZXHfnPF0zNLb3CvjCv7xZtvb3f670V+N98wcv
 yOTxdWQei//pJR0WrcZoL/vamx0O+wnEkpTWF44c4tVi/vv+IOefb+l8QCVYR/E2zzEZ
 l8zXLQmipda1y34vN/wxhWB+j/ZriFMEL6C83uJdu4mrUH5KiarPqoaZxwnDs5AfXNtP
 SV02WXvAEXB656TnUpvhcUu34slrirewngr0AZfJulYgWS9cJQdB7vLh32Un0mHSbvZ8
 wDgd/3Wjo60qR9XsiAZT4eWvvlXd1A+N9M5cAbTUudnpVi1xA6BZMzbC2qdnkCXPYD7H
 Vf+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717177404; x=1717782204;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oNAheale54PPUTGUW/lyMKAZuGL/kpAgevOQ2nmQkDE=;
 b=aUjGiNLViYw+swRCLcNUjyGBi/G7h42RV5CLTMbLZHUP7PhqE4t/vwkFE0MXcOEimJ
 Ix2pg1XfIR8PD9orgEvJnuImqt79/YWh4BC4BkJ9tulwxCguZYSUMR92BY7STFM91o1O
 KiD2eclHSmQzwNET2V0eK5RpGQh05CoIWL0hKAP6mS8ZKFGIOPmId09tAbo03h9CB1CD
 LrgH0yPIYlLHY48URvt21L34drGQrrdaWZNSmonTOsMOAn6SpGV5zk93zg43SI5C80SU
 W+Jh/XA5urqMmwjkDxuFeNcS7bCSBO5cKPYcoM8zMGP/EUjk38fHNskWvah8euUQGJ12
 edWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGRp9zMfvXzazdiOUmrYS6HWwhBP6a4bsRbBoHT8v7njZh62KpOO9sgxaV9LV+2pQyKjlEPS4WoEqItrv+IUGXr1AW4PQ=
X-Gm-Message-State: AOJu0Yz4gDKeux50XIPFdNH+kMglo1Aasjh+oA/Hkjk5dM9+qdRVvi/y
 eVwHIQZjcvQIBOQT3C1X4P0hHAx6uRQtMBaydnMmUFBzO9v0PNCzkxeHwyWcfNuUFPaSl2/kk6t
 /
X-Google-Smtp-Source: AGHT+IHIgldufv92DrhfKGL/11nqqhzvcgm0t7FuAe0SMN4cPwF+8SnODtdwP83XujC7z+JtsXOnwg==
X-Received: by 2002:a17:902:e54a:b0:1f4:b43f:9c18 with SMTP id
 d9443c01a7336-1f63704143cmr27609235ad.33.1717177404400; 
 Fri, 31 May 2024 10:43:24 -0700 (PDT)
Received: from ?IPV6:2607:fb90:8f63:c378:2227:4860:1a85:f40c?
 ([2607:fb90:8f63:c378:2227:4860:1a85:f40c])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f63232dce6sm19416425ad.56.2024.05.31.10.43.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 May 2024 10:43:23 -0700 (PDT)
Message-ID: <cdd641aa-92b4-40ab-80c6-fd7d9b913ca3@linaro.org>
Date: Fri, 31 May 2024 10:43:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] host/i386: require x86-64-v2 ISA
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240531091457.42200-1-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240531091457.42200-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/31/24 02:14, Paolo Bonzini wrote:
> Paolo Bonzini (6):
>    host/i386: nothing looks at CPUINFO_SSE4
>    meson: assume x86-64-v2 baseline ISA
>    host/i386: assume presence of CMOV
>    host/i386: assume presence of SSE2
>    host/i386: assume presence of SSSE3
>    host/i386: assume presence of POPCNT

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

