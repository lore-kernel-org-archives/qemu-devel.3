Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED3F8C25B7A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 13:40:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9mBk-0007nJ-NQ; Wed, 22 May 2024 09:39:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s9mBi-0007mo-2N
 for qemu-devel@nongnu.org; Wed, 22 May 2024 09:39:26 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s9mBg-0002dX-9f
 for qemu-devel@nongnu.org; Wed, 22 May 2024 09:39:25 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1f082d92864so113220485ad.1
 for <qemu-devel@nongnu.org>; Wed, 22 May 2024 06:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716385161; x=1716989961; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Tt+zOyWpKke0+wj+3SF72SBbYajWxY9O2XpGPa+4qOA=;
 b=JeqY0KZyYdI/hLmdmTWPmQffPZVZKkRyhs6HtOgyBUtOSbfM4VwRXhaqE0003M6XdI
 IgHwPiIhPEgdfef4HxH+jRnhY9Npb6P2o9AUaW/TUro9KosRfZqa7tN5/kEPtUwEqq2D
 Cjxe5RhUt4Ci2Q22rtBQmq5UkrcXRohfcNOiAr67jBLSbIb8ZSPIoTmYMJBdj2kKNckh
 nSAX0WpXTyXhkiqPt6bUjtlj02CxLja0uLByOdKqCiWkVhq9r5z0D3i0tWtPNIoIVC9i
 xJHzRQfu8DuJqpA3kqKAg88wxVGOG9V3CxAA7MQGsGrZNwAh8G1edc7dWmN3H4REYWLg
 7DbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716385161; x=1716989961;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Tt+zOyWpKke0+wj+3SF72SBbYajWxY9O2XpGPa+4qOA=;
 b=mKxOu3hWSfukQ3Ra/2adxnTyYUpDHDeR+YGetSWUBhCrZnc3mN9+8Qsl4ytKboNJa0
 zAU+0zEtPFHAVfinHdr8KQCA8mP3VK5grNvPT5XzF7gut6Ta7Nt0Ds++0iW+u8zrs2CR
 ECIc6G70JWM5setfstgBECwpzRvnj+rR3Ink+Tng/QMr8e/32v8SbDaOvz+mYsdsiv7n
 k4z7MsOEDyl3eEFOsgWe2rJikSBFWH6WIm0QRxb7pLnMHasfNuIWUpsdYeWCtu8qHEqz
 Mv9oBA1IYn8s0h4o4ZiFo57LN5vYkvQf56db/bwI/7dDffDpCF/b1A22tpqQkbyCp1PA
 N9hA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVtFd3F6f88fdD3osjsh/1nK3SZwsU0S/83rD5HmcZubuuUl6aEulUH24iBligTItCT0aJE+4ON+8TbMXhL5nC/lQ3nAY=
X-Gm-Message-State: AOJu0YyO8gaqYUOUNfHeVydHbcFcQ7z0yPUsC2P4iNNqVHOMt10lKEhS
 eIMmaC0fzLbOdz/R3cPclq6truXu/36QVum6vIzCZ/FzfFGOe8GLeHTyMuxKeTI=
X-Google-Smtp-Source: AGHT+IHCpDDPjDckOsH59RM0UYNawwvsZtOzjITMgaRoemIU/Yj5eomiLWhevkaKmTMC5EYbVIx2TQ==
X-Received: by 2002:a17:902:f786:b0:1ec:2517:3a06 with SMTP id
 d9443c01a7336-1f31c96a71bmr22989025ad.27.1716385161352; 
 Wed, 22 May 2024 06:39:21 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ef0bada410sm239286295ad.69.2024.05.22.06.39.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 May 2024 06:39:20 -0700 (PDT)
Message-ID: <400ce3c8-df33-40a2-9484-06e4e44796ce@linaro.org>
Date: Wed, 22 May 2024 06:39:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: clean up AAM/AAD
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240522123912.608497-1-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240522123912.608497-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 5/22/24 05:39, Paolo Bonzini wrote:
> The 32-bit AAM/AAD opcodes are using helpers that read and write flags and
> env->regs[R_EAX].  Clean them up so that the table correctly includes AX
> as a 16-bit input and output.
> 
> No real reason to do it to be honest, but they are nice one-output helpers
> and it removes the masking of env->regs[R_EAX] that generic load/writeback
> code already does.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/helper.h             |  4 ++--
>   target/i386/tcg/int_helper.c     | 19 ++++++++-----------
>   target/i386/tcg/decode-new.c.inc |  4 ++--
>   target/i386/tcg/emit.c.inc       |  8 ++++----
>   4 files changed, 16 insertions(+), 19 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

