Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 695D5C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 23:01:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSmFV-0000zL-D2; Wed, 24 Jan 2024 18:01:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSmFO-0000u6-Kk
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 18:01:32 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSmFN-00062B-16
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 18:01:30 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2903498ae21so3509900a91.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 15:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706137287; x=1706742087; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WyxN23f0qcRa8FFRo4eZekpo0qcMzLxxaCRuYdrp3k4=;
 b=CPiAuVsPB5T0amv57RcNjOXnjLrwJV5Wi/pUhiNSJqS2QneUbYvcaTLGz3oRnaaaGm
 e0RF5tlTaJpm//EYy3jHV8xlVwzZfyDbZgwr6I1QxvGJKYtKvorbJW8MQsiAndC7VgDd
 SN9nKU4UWqTh/xpCKs/aCF0k4ofZUvbh/48HRzxAzYfQ6bd69bchErQLzJEz6oP0G6Ch
 mkKHaY5jdKXdLAPlxhpebXOOCa6NKBMbOHFDAKx3iisIgwqj/P3efDmIIx1zKu53cbVp
 6ojiytGXYZ+pjp3HNbUs8+WldYz0tNX+RdancpC2X8+yKQwkUmjLLa9ptmV87Bw57Ofl
 0ljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706137287; x=1706742087;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WyxN23f0qcRa8FFRo4eZekpo0qcMzLxxaCRuYdrp3k4=;
 b=A7NUzAXcZieEZXH4jA3437TwxUGrR/VW2Ynusi7txzc9mg4R1fCmqnbXvpPyhOj85n
 tl+FgYojGKbqQqsS+kHANuIWAL3ILnZoeJdojaVmOuZJdgfjkNYQghV4lsxEyVEu+CUi
 DiA2nqT9U+cE51IQniHlksXuVfRxh3DT2XYiVw0+X7RYtcVMhNkEJEBc7lm6+bWiIuyf
 3LwTJvw+t7GCgaHzilfEFHirhk2MJCcT4J0IB/Lxkfun3qLhNgTg1VNKsJKibuoOvrmS
 I/GBrMrnz3ygnj+n9y1SnuAgzf9kDM4NSpC5sBrpEjB+ISgtGKetKwOuCpT8kC7OW87X
 QLuw==
X-Gm-Message-State: AOJu0YzYFY3BmgjtDbNGHkyNuz/JzN9erQludozeqko/gpKCPbtUqoym
 NfJ3OURZKcRwhThc8yH2mnJQ34p0WUUtwP68X0UCcLGcytQM16adQQeybQC1L7w=
X-Google-Smtp-Source: AGHT+IH8A8GehCj7Ay4JCJCEIb0aPqu1IMFSyLNJuqLcfqHfVnHwG+yp6+zBVZcFGS9wF7VnwreMyQ==
X-Received: by 2002:a17:90a:b297:b0:28b:2640:c5f4 with SMTP id
 c23-20020a17090ab29700b0028b2640c5f4mr54044pjr.28.1706137287277; 
 Wed, 24 Jan 2024 15:01:27 -0800 (PST)
Received: from ?IPV6:2001:44b8:2176:c800:5fcf:9e3:2e58:9c7?
 (2001-44b8-2176-c800-5fcf-09e3-2e58-09c7.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:5fcf:9e3:2e58:9c7])
 by smtp.gmail.com with ESMTPSA id
 r5-20020a17090ad40500b00290cfffee0asm176910pju.1.2024.01.24.15.01.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jan 2024 15:01:26 -0800 (PST)
Message-ID: <72548f37-ca87-41c4-aa8b-bb48cbb9b6c9@linaro.org>
Date: Thu, 25 Jan 2024 09:01:22 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] target/i386: Extract x86_need_replay_interrupt() from
 accel/tcg/
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 Claudio Fontana <cfontana@suse.de>, Eduardo Habkost <eduardo@habkost.net>
References: <20240124101639.30056-1-philmd@linaro.org>
 <20240124101639.30056-8-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240124101639.30056-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

On 1/24/24 20:16, Philippe Mathieu-Daudé wrote:
> Move this x86-specific code out of the generic accel/tcg/.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/i386/tcg/helper-tcg.h        |  1 +
>   accel/tcg/cpu-exec.c                |  9 ---------
>   target/i386/tcg/sysemu/seg_helper.c | 10 ++++++++++
>   target/i386/tcg/tcg-cpu.c           |  1 +
>   4 files changed, 12 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

