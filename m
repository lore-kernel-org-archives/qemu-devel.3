Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63FF2C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 21:30:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rv1zZ-0000ai-U7; Thu, 11 Apr 2024 17:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rv1zW-0000ZV-Q6
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 17:29:55 -0400
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rv1zU-00034u-3z
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 17:29:54 -0400
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-229bd1776dcso146527fac.0
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 14:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712870990; x=1713475790; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mxeb9Qi5ilEzWYWacyUKXpeH6yDELX9V1W2dQgietGQ=;
 b=pdaRJ9qWEokG91ZhM/ACKVOlW102ZW4IZXS8l5OlJNcTkdZJPPiU13Mzpu1QPeY7je
 TJYz1eIsL4gOX1aQhsk8hFJ9amqtjXGeJo74k8WuZThAaePxLWA3Nhsb0KtCUQfT+FsU
 JlRgPvDmKidpVKJ4MUpkA1qLhUX2/9+P+SKAHSXxkCDa82WN8kJg+nmF7SG+u7nMUiyk
 DdimXbNc1iGgIh7kXxEHNCkVMSiyFxZ4fbIbmo+REeXTK/fPhhvWv18ysrQtDdjcmTU7
 ux03dBH66RDhFg7j/KKqd4CWVtR7xN9u4uYn7Mo78KW9WV4iia/cbfNCv4Milq55kwWH
 eB7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712870990; x=1713475790;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mxeb9Qi5ilEzWYWacyUKXpeH6yDELX9V1W2dQgietGQ=;
 b=CDByDkoBPnOrlGecFpvFE8h7s5yWWll8+0rsgm1QivJiOfUSjTPuwU2ZubIitRpch6
 Caftmuin/ttVyo28eUvj6dErA+arGxNst7L20BtHan3Kahb/HJoCjK3GRkvi5wFAq9EK
 PbGXty4P56wjHcRiBumClqAxRh2r7cme+K70QsqLJFZhbfNrOSARzcH+GGPZEtLBRDy4
 uaJgqRx5ctWZ1SCXW9SJ1S550HX7OPXLbL06vrUYl56yR9pD+OYlltUV7hOP15lmVM13
 ZsCHSnx63aQU75pGca8LR7fGqcl7JQncN2hoBj+B2eh1Lo+hYfr04kXjpjvJ9gCek5+W
 QmAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWIrY06hzfFcYP+CGeW6S4PHwm+C/ESL9I3xaRu0E/DzefIPPwvRgAEZHc2/9nTTv4qSUAiz5XMle8rDdYAQz4gvoyEKk=
X-Gm-Message-State: AOJu0YzWubIHhnanUQb0G0XIwQeJyXvhspWma3O7qllvdzov7V/FFqM5
 fi8n1KgLRVrs+MnMw7Ci0LVGgfuSizbg5z2+V8VZtiUpLrk6Zlomv9XIPiZStMU=
X-Google-Smtp-Source: AGHT+IHeDw79VNjh4f99OQcxlOJEkb0U2VzKrV5YzeuFSU+t+VOd+sjjZbLjVpNj8WKWl4KVGQGWoA==
X-Received: by 2002:a05:6870:8c19:b0:229:8169:ae49 with SMTP id
 ec25-20020a0568708c1900b002298169ae49mr554932oab.46.1712870989851; 
 Thu, 11 Apr 2024 14:29:49 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 k187-20020a636fc4000000b005d6a0b2efb3sm1504986pgc.21.2024.04.11.14.29.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Apr 2024 14:29:49 -0700 (PDT)
Message-ID: <e43c2c7d-e12c-43ba-b3d2-7a5bdce2b364@linaro.org>
Date: Thu, 11 Apr 2024 14:29:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] target/arm: Replace sprintf() by snprintf()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240411104340.6617-1-philmd@linaro.org>
 <20240411104340.6617-9-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240411104340.6617-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/11/24 03:43, Philippe Mathieu-Daudé wrote:
> sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1,
> resulting in painful developper experience. Use snprintf() instead.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/cpu64.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

