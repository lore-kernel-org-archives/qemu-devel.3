Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE89DD14882
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 00:56:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdeJw-0002XH-4b; Wed, 07 Jan 2026 19:56:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdeJZ-0002AH-2P
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 19:55:50 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdeJW-0002Fn-IR
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 19:55:48 -0500
Received: by mail-pf1-x441.google.com with SMTP id
 d2e1a72fcca58-7b8bbf16b71so1848812b3a.2
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 16:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767833743; x=1768438543; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q5mWpV+nMrFaSU7KOv04C5BaT8Y0Row3HFqjRukRKxk=;
 b=BBb4x4/2d8kcorDKsLn9VaZzFc7ZWsvJjCo9t1nKk5lzOjP/8U8KR55BHAYYQVTomr
 ms9C3M1SJjfRH91MQax7n8Kb3whiFXZy0gU0wtwkPsna3ygdcPs/xkBYWS1ANaUL15cG
 lBvVm7KZPX0z0c/QFonoX6vi+mhNu56v28m8YZi7hJb5JE8wBUzfXppZ78aOlNUfMOh2
 vBkL0pbwSyPmqv4shbSptIO7tC238T8b17mnQLOy+riMn3W5E7iQDBqXBq4AAp5QyqQa
 czlYdXT+ePmRBYiI1V+u2A2reByJWb/DHQymBFTONo+Ogil9ATQtZIJXg9z7hfM9K8QM
 UCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767833743; x=1768438543;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q5mWpV+nMrFaSU7KOv04C5BaT8Y0Row3HFqjRukRKxk=;
 b=b2RUYQArqSjun7oaqGHBno7NlL1yWwtYRWmcYVwl4oNnxZH/+9f0mXKaq9zYcDoHZU
 Mg/Nk06WDe3UaNVwlKdZrCztNNVJpzrID2Oulo3EPzmcDsEWpv0rEzf5PpUWC3uwztgR
 tiwyriywOnf36yHS21v4k19StoMLExTjK3UWkUJ6kPG1jYxxIQJYLkJrs6MxdtvdfQkh
 Md0d+p1ZuQfCGJegGee7++FR1quu22KN5qL+WQLCxE5IWzZ71hSXyuryR++jXZC8yoxf
 Z7mEsy2VXcG9iRBC7Hj2OGvJTIR0Jo9thrylKqcHNUcMj4OSmRiFnKWamlHidg/tedzL
 skNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrPyVTqApkS8AejJLqAdwrCi4wSqXSoJTqneR+4AYj9IcbMQ/uuxNfNAimT42gHU0PnRVlezxsbNO6@nongnu.org
X-Gm-Message-State: AOJu0YzDhRmrMdAnEgJGy4mPb8KoOvt2xRKPVYJXnzcTiCSOwnyJT161
 4hqMgOCVOKH0G7WlThJy67zNxLdPDgXQDMPCbzWlI84vv8L+Na5jT97RHFkUJDXy0bs=
X-Gm-Gg: AY/fxX6ceH8nLMGhaG+lH8zly9DxtgUeLs/MX7bt9mObDymlqCgKTvg8GNVji7yZwmm
 bQuiyz/lZHn9iq4PKZZMjxg1Q2kKsiNDm2P1lIn9x+1/g9lMfPisYJPK0y7L2S7x1DoSJg9gAo7
 UADFfnZfQxU7Yn8kHvDkrl+ysAwoyhayOLydz9E9eFrlJPMPdDOmWm3EBOwvDGZaMqTQsF9QxMO
 hp0rWSVVxl/nLR6AEJTGc4w63PkgBCMzTYjkcYKs2zNA2f/g4TghZuruGFQnd0pXTZDzMsrIwDK
 MAGJRwz9GvVoRHGrkq7JuJH4lfDlOkwMEByWCcE+nAbQr4KhkzValnZuD8vnFC8JTq7XSE13vsg
 JASbAl9xoZs+2Xi71v19W/GMchQOJIc8WLrQHJHp9Rk+CE/4VkB/SWEijkzJfYMNe2fIY/CyqAl
 NXo6z/3l7Xz7wDTjB8Buias8USIq8Ua6T6RSUDNDUE3x1KMmomAEZgFgCdBArhEZcRknw=
X-Google-Smtp-Source: AGHT+IEAiZLTcykHkEiL3899LlkRRNtRX4UmgV9mwPEoc1JqkiRFieSn7ZeNnaFjKKbQSKLYoFD+Ow==
X-Received: by 2002:a05:6a20:19a9:b0:389:93e3:ca96 with SMTP id
 adf61e73a8af0-38993e3cae9mr2294803637.21.1767833742759; 
 Wed, 07 Jan 2026 16:55:42 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cbf28f678sm6236384a12.3.2026.01.07.16.55.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jan 2026 16:55:42 -0800 (PST)
Message-ID: <d3038eeb-0d28-4f07-8034-4ffe944decc2@linaro.org>
Date: Wed, 7 Jan 2026 16:55:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] target/ppc: Restrict WatchPoint API to TCG
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>
References: <20260106231908.16756-1-philmd@linaro.org>
 <20260106231908.16756-3-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260106231908.16756-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x441.google.com
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

On 1/6/26 3:19 PM, Philippe Mathieu-Daudé wrote:
> Watchpoints are specific to the TCG accelerator. Since the
> Data Address Watchpoint helpers are only called from
> translated code, move them to a new 'watchpoint.c' file,
> specific to TCG. Thus restricting the WatchPoint API to TCG.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/ppc/cpu.c        | 81 +----------------------------------
>   target/ppc/watchpoint.c | 93 +++++++++++++++++++++++++++++++++++++++++
>   target/ppc/meson.build  |  1 +
>   3 files changed, 96 insertions(+), 79 deletions(-)
>   create mode 100644 target/ppc/watchpoint.c
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

