Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 519A8C001CC
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 19:32:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxB0x-0003bO-8q; Wed, 17 Apr 2024 15:32:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rxB0v-0003ai-KP
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 15:32:13 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rxB0r-0002dk-6l
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 15:32:13 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6ead4093f85so147713b3a.3
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 12:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713382327; x=1713987127; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OSqiHvEe5ZPohGxlOd3XaV4BAUAjpp1scQa4/76ALso=;
 b=ALsQagRD4tRwmaXsvHANIvR5dzjesa9PNwhiMmdeGZkWgQLeH/QJB8RspWgD+uw6oJ
 K1Upy5dD722J1cfDAk6luFg2rQ9ppyYb9j0unq9AuG6nXDzyJjPnXWopPFFgOpUHekPU
 Ds4ikVYcoEhwFIlMBImbjPTMQVD9PTuYSeQBUYFcrhIdxE/iacnBwRhN/+baWVK1omHD
 WOz/EhWCNrnMwWLHNFrHAfZbwMt/wEUN1ITkPndr/w8VosJvO7g+Hh7W6wUCggutE7RQ
 d/9a1sKURzC4DQnt9wINR53VYpGKOQFvFIiYjX5IDnY4v36k8JYUhsq8nLidqE7BEK07
 BLeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713382327; x=1713987127;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OSqiHvEe5ZPohGxlOd3XaV4BAUAjpp1scQa4/76ALso=;
 b=CXYDNzVa0hPg/8fAMVnsB5RjgTMry7C8rs5XigZ2fN/brSEtYquVY6UhMqzM0vrxTR
 p1L7YtS52Bfk6jsdD66xHoBMllyfrVOkA+5SnTEJ6jNtMoATIAFITzalGcKq0MgVuoYp
 b6mFRfwCq3mu4+p4xDT4MntJoebyDhg5yq6R2/CdC9Ph/+vBDqFAycnUakhkXKxZZqwO
 QgC0v/Cdybt/GSpcR/ycBZYSfKgY1T7EgeU1STc3+NtwBb92atAayd9d28Sb53ybG6SX
 uf/W42y0MtxVhbk5Z2+oaa/cFFn1T7h8v7AOlop3JliiYjPQ+K6mwnRHddPlEyccJNgp
 qJHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSOq3nw3dTtd5pryi2n1FovJC+NdwvgJDf/KK0CyW/m3B6U9MBg0DKiIpb3XXI2nK99b1Ef/u3JFOUIfruZHVdLqd7UXc=
X-Gm-Message-State: AOJu0YwNH6lpecm7K1VgisfAOoqWw7yxinms+8ID/ZqZ/9PE2tXiVHR2
 PNA+w5uUq9aVAlA8u2s2IfXf/Hx1EM3w06egIsEPj207OzdTZ2rJuuoBUYdulz4GlU43+c261KJ
 n
X-Google-Smtp-Source: AGHT+IF2TeMrbj+VRkQL/riZ8XM3v+lKUOYMeBAgtJjjMCBhMNYIRFEino0zYp6G+Etn5oWgy07ysQ==
X-Received: by 2002:a05:6a00:a8e:b0:6ed:caf6:6e54 with SMTP id
 b14-20020a056a000a8e00b006edcaf66e54mr571849pfl.28.1713382327544; 
 Wed, 17 Apr 2024 12:32:07 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 q23-20020a631f57000000b005eb4d24e809sm11001953pgm.34.2024.04.17.12.32.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Apr 2024 12:32:07 -0700 (PDT)
Message-ID: <ed134c9d-6e6f-465b-900f-e39ca4e09876@linaro.org>
Date: Wed, 17 Apr 2024 12:32:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/21] exec: Declare target_words_bigendian() in
 'exec/tswap.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
References: <20240417182806.69446-1-philmd@linaro.org>
 <20240417182806.69446-19-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240417182806.69446-19-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 4/17/24 11:28, Philippe Mathieu-Daudé wrote:
> We usually check target endianess before swapping values,
> so target_words_bigendian() declaration makes sense in
> "exec/tswap.h" with the target swapping helpers.
> 
> Remove "hw/core/cpu.h" when it was only included to get
> the target_words_bigendian() declaration.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Anton Johansson <anjo@rev.ng>
> Message-Id: <20231212123401.37493-16-philmd@linaro.org>
> ---
>   include/exec/tswap.h     | 12 +++++++++++-
>   include/hw/core/cpu.h    | 11 -----------
>   cpu-target.c             |  1 +
>   disas/disas.c            |  1 +
>   hw/audio/virtio-snd.c    |  2 +-
>   hw/core/cpu-sysemu.c     |  2 +-
>   hw/core/generic-loader.c |  2 +-
>   hw/display/vga.c         |  2 +-
>   hw/virtio/virtio.c       |  1 +
>   9 files changed, 18 insertions(+), 16 deletions(-)

As an intermediate step, this is ok, I guess, so

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

But most of these files that include this header should be using a CPUClass hook, or a 
device property, or something else.


r~

