Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 221A0C3DA49
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 02:06:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYyjT-0001T9-5L; Tue, 30 Jul 2024 22:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYyjQ-0001KH-NV
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 22:06:25 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYyjP-0003m6-6P
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 22:06:24 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3db1e4219f8so2472935b6e.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 19:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722391582; x=1722996382; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/oZnIoWS8Boc6hr1jldAe1Z/o0jK9T0TOr7Ac5iafUg=;
 b=W3dy0qNOVEGiAxJvPCIjjRWYiI14YlBIFlpxI+mhFdu9ifiztfv0ZnQ1ggACSLkDim
 kdzU6tpE7kUmaB5xfFR/W7ju0NxexKmtI8BzVIvvp+5IJpvwvaWQR9iuN6Jgad2VtEE0
 /SynVZoQOmW4xsKHlv7YwZpnkE/yMk/EAQvOIh93665C9acsLvi77AC3WQfLAg8ZMZCg
 hb5mFmIituESB1BckiD/vW+crJFcn8cTy7Ibcu4iCHBZCmuckbQYSgSqA92wRhmu0vBg
 94qe2AVVD3X2VZTqsiGCCnBJ67C2+YyK75fV+5aIyUkhrJgEmulOE1tlGec6mN45YOVv
 pjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722391582; x=1722996382;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/oZnIoWS8Boc6hr1jldAe1Z/o0jK9T0TOr7Ac5iafUg=;
 b=bMqIKQY3X+bdOclSalZXS1H0+GmiprG4yJnoxY8HqKl+7A6G07BW5L9PJBDylzGXG2
 A6Vxt+Ek3LbfofTET37DBZyjbvP+bOXG+1iI4O5Ssl8X2+1ViaHQKdWxmAgbuxGC9dUh
 SQoco7ty/qGfCfCpXeTAlpQ+P/kbQZAJK6zG3qpKzIV7uEdEvAkCZ71Ehr4Y+kslGn/B
 Ckgbgsk0eGGcQ+joNri6zbhQNPnPHTX8sXFUl18TbiMaYeAuKwnQVw1fX75CMdm8N4v5
 U2W4ulfkomy/S/rSVq6L38Zsi28kMAxvr758+t0Vme2tYODjRX76//Y2oU9+g475KeXM
 UrDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBLyWghrEdM3YYIlk9IYRvylkdZdxjINeTEmw0s593anmh/8dRN7WkQKNq2CW65bPBJcTDOsu53RuaEj9+joHejzP+yic=
X-Gm-Message-State: AOJu0YydXjEq3c8w9Jit+vrt5QPINfPAZUh3kbsQgxR5nzV8veZr+R+y
 DTw56gzwovx993cPJRQQzLWoAqhgwMfKgUpzpDh/Crq7GBssTvRrS6G73mjLem0=
X-Google-Smtp-Source: AGHT+IFEd/srs85hX95ZpkllaAvoD2x4oqxKoUJekiUgac6ozuEMMzcynCqr3KoCumNNQTtS62dF+A==
X-Received: by 2002:a05:6808:d4d:b0:3db:3102:adc6 with SMTP id
 5614622812f47-3db3102ba15mr9566839b6e.41.1722391581728; 
 Tue, 30 Jul 2024 19:06:21 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:7406:659b:9ac8:69bb?
 (2403-580a-f89b-0-7406-659b-9ac8-69bb.ip6.aussiebb.net.
 [2403:580a:f89b:0:7406:659b:9ac8:69bb])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7a9f8655dffsm8183847a12.39.2024.07.30.19.06.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jul 2024 19:06:21 -0700 (PDT)
Message-ID: <96a752c9-0517-4f77-9370-cbdb171cda38@linaro.org>
Date: Wed, 31 Jul 2024 12:06:15 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/5] net/tap: Use qemu_close_all_open_fd()
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240730122437.1749603-1-cleger@rivosinc.com>
 <20240730122437.1749603-6-cleger@rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240730122437.1749603-6-cleger@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22a.google.com
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

On 7/30/24 22:24, Clément Léger wrote:
> Instead of using a slow implementation to close all open fd after
> forking, use qemu_close_all_open_fd().
> 
> Signed-off-by: Clément Léger<cleger@rivosinc.com>
> ---
>   net/tap.c | 17 ++++++++++++-----
>   1 file changed, 12 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

