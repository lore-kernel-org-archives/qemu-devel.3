Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A5EC46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 23:04:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSmHR-0002bI-Rf; Wed, 24 Jan 2024 18:03:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSmHP-0002at-Ty
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 18:03:35 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSmHO-0006bA-Aw
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 18:03:35 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-29051f5d5e8so3077579a91.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 15:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706137413; x=1706742213; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rCVgKgjHp2mamhS/jaTblzZW2bHrSXb8aQKBT3lN800=;
 b=IZQhFMQdZ2eNqHaSxovHoTC4oVTLYdvyCksRoyjBBM5TYPVqBzXP41rLQHJI4Z5W37
 BZw14rbWqdf1KaND+8FJZauC3z/sB0z4F3Ee+UP3C1CJa6cdGDovt7KGIYhhLOLirMtV
 Hk2SIaNwN8V2ny3diUd1WWiSAu7t9OeicKKAdai9XLrJ6v6+ScC5i3rv3nDBsytHN3uM
 6TL+Xbdn9UR15kyAPFLRbT19oxmnzlcfuWZZjjZLjUBI9u8JfFD/n771MR668e70Cn//
 I9sbx2wU+0VvM/nz4LUeAqv3iBZ4gD2f7sGBO80+DkQSJ9vG08St5bUFQPmhWbiajy2W
 muNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706137413; x=1706742213;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rCVgKgjHp2mamhS/jaTblzZW2bHrSXb8aQKBT3lN800=;
 b=TNRc92EnjHNWctGVoRV7aw2Gk1VwhLAUhIh5SMMPiBujPURFBEVbQb7BuRLchS5isH
 EWKXmCkskpHWB6pz4iDhjnZfrNbZ8eJ2UDayWVnwLn56JOg0WTnutPx/BSdZJJzXjhNF
 mIVLXgeTeh55eIO1qrycyWHgNSAYmtwru5OEnj99Kg8iv7QPmEiIT9vyyiGgUGjigwhK
 +Z9uXV7mUKhU1HXnlKFJ4eZNwuf4PNoSz3qL0OiqksBqqkozUks0zMX7IlGpq5bMvhBD
 Ky9ILxtTccRgSzT3W1M9PijCuqtsx5Aqr6ttlapg9kTNJEIDLiG2i4RIq9UT6luCqQVp
 fPxg==
X-Gm-Message-State: AOJu0YwvBIk3FiQlNsgQ+p/ezG7c9vP4VVylZxJUE5094mEBNEmNud/i
 e2vW0v6XBROdB28nNbPhZ0uVV/VpvZlM4YcOUsB7NdpXRru+6FwfABpw8hiWWmk=
X-Google-Smtp-Source: AGHT+IHIM4eFY7UEakWP320uwhl+0+OW4XNlXGx9MjKFOA9+NnbMTtIe+NEiiojre3ccyKuOhegLTg==
X-Received: by 2002:a17:90a:ee88:b0:28e:2e27:6def with SMTP id
 i8-20020a17090aee8800b0028e2e276defmr61534pjz.91.1706137412974; 
 Wed, 24 Jan 2024 15:03:32 -0800 (PST)
Received: from ?IPV6:2001:44b8:2176:c800:5fcf:9e3:2e58:9c7?
 (2001-44b8-2176-c800-5fcf-09e3-2e58-09c7.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:5fcf:9e3:2e58:9c7])
 by smtp.gmail.com with ESMTPSA id
 r5-20020a17090ad40500b00290cfffee0asm176910pju.1.2024.01.24.15.03.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jan 2024 15:03:32 -0800 (PST)
Message-ID: <9708cfeb-7148-4a4c-8438-f250fd0c42e0@linaro.org>
Date: Thu, 25 Jan 2024 09:03:28 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] target/i386: Extract x86_cpu_exec_halt() from
 accel/tcg/
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 Claudio Fontana <cfontana@suse.de>, Eduardo Habkost <eduardo@habkost.net>
References: <20240124101639.30056-1-philmd@linaro.org>
 <20240124101639.30056-10-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240124101639.30056-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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
> Reported-by: Anton Johansson<anjo@rev.ng>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/i386/tcg/helper-tcg.h        |  1 +
>   accel/tcg/cpu-exec.c                | 12 ------------
>   target/i386/tcg/sysemu/seg_helper.c | 13 +++++++++++++
>   target/i386/tcg/tcg-cpu.c           |  1 +
>   4 files changed, 15 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

