Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A43D1D48A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 20:04:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdwEj-0005Wo-Rc; Thu, 08 Jan 2026 15:04:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdwEe-0005WN-PN
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 15:03:56 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdwEd-0007F8-40
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 15:03:56 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2a09d981507so17998625ad.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 12:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767902633; x=1768507433; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZsML9o1KVU5Ixosvlqx1nPbMxFCZKYm1S6FdLQlKDFg=;
 b=e8hM64VS4hSQwjzkEB+YMiU1ULdDwWLBF7TpEAWCdRKX69RouohEYf3gPvqDnuunQt
 8cNO8lUJfwtl34AOUmWOYnh6C9Ok331PSLRrCQnEU3gpec0D/r8W8+Yx6VOhq21dHuIl
 VA3pLIp1pxs+8SK+CB1coUtI3czoyOyiWdmAC2QT27JvDaiGrmD63RrnzQTiZgZmvlz8
 9AQS4AuLuyQqYvKKAqMw+0w0KpkaCoy9EsHWlP+fk96xfPQkoh2YrnF/YT4ySmH+tMJW
 stLEW5QSDgRq/oQ0LT3PHklNUlJQUSpIl2h95tOmxufMIYVBquTQSRtsaY+wGL5GeFrh
 WiPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767902633; x=1768507433;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZsML9o1KVU5Ixosvlqx1nPbMxFCZKYm1S6FdLQlKDFg=;
 b=CsSu/4IXkT4ktHBLBbgUDLhxxg9x0uR3/gqbAeQA73+r0EULlWfGgQRj4jXv6v4qzz
 MQU48qd+dWBPUyaR8gJJYqBtBZ/in9F98+EiLw6T9agxf/HJq2UftwxOD+gfFLf4h+B0
 7gYV57dylxhWw57nAXOnrOPuhPYo3F9S/pyA4x0zlNfJZ32DXi9O84i6QvzdVVTIXE9Y
 hCgQbFEhqV4IiicjfVTdLD7Py9MjUB4cAA6W1C54oe7f0TXJfgEkoYrI2tav4KJkhfPC
 Dr36qEm1ihX9CsmjLdkFWY7m0xNMRiyXrLZI4THIFF9RGiMwo7IFr4J0Ld8rSPNJjTII
 C0KA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3M6BmkaFy+GD3F43lQV+7y8rfDtndC6m24e/3/71+1U7QzCStyqCOL7Kx/4ZlHxQIuwhVzVhXz41a@nongnu.org
X-Gm-Message-State: AOJu0YyI3pnqe7LVAMoQWiHgrZyHnm5MVpjjxufaYvIF8HUrDt/70DHn
 NV2f1sGbHL0ljbVYX9rhP8/PZ++t/BFEoWXuV2qdR0+8MDkvTHx62+w6Wz7IY87HAd0=
X-Gm-Gg: AY/fxX5I5pg3WJbIJ32QwKIIxqsB3QmELx4QyE/2xLv56+SpeDndV8DJoAqtEowSuyM
 uyQNrHHxn2UrEDNIaopV6kQimw87uolQsl6Bm++GsCxQgm9V/Mc/M1/vL0W94NQRJqcSYtiljR7
 Htsc0IakrbT853FsVd2+Lx3u/AsekVB2p9/EAMxXgHREqgLy1qRpfzJTMfzTZzCSHw5I9xHgmS2
 f+VS0GJhsC7KJm2pce/vEZtxaCGQKQnx93hhPY9+eaQDGZfNbZJmn+HIwTWtqvsJ4JFPEXXaBy5
 Qg6edMhoPH0nV5Cq4LtUxjPFFDtb89ueSLoSxYgJf8LQD1OiqARxwveBXCtwJuIfQz+VTem3BqS
 wQtdLTvmT0LsoNsWanp1fmZL7KEINo/iDWQp1MvbXN5s3plZoNTPB5C3cHUT7RaBUT05QCxQj6Q
 p3ggJZbi1ZfqSUQ6kTpgWNnmBrAWPTZbvWLFF41poWFfvKcqrKeAX8DaHL
X-Google-Smtp-Source: AGHT+IH8QJVGuhN2PHdds5LqVK4JaB9DhwJD10V+uX46zC0iqYWQvMcmCq6FcE1GO2i5w0w5QqqUsg==
X-Received: by 2002:a17:903:2346:b0:24b:1585:6350 with SMTP id
 d9443c01a7336-2a3edb26007mr80090515ad.11.1767902633059; 
 Thu, 08 Jan 2026 12:03:53 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c3abb0sm87410215ad.11.2026.01.08.12.03.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 12:03:52 -0800 (PST)
Message-ID: <aed0102c-3e42-4286-99ce-a86ca967f21a@linaro.org>
Date: Thu, 8 Jan 2026 12:03:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/50] *: Remove arm host support
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-4-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260108053018.626690-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

On 1/7/26 9:29 PM, Richard Henderson wrote:
> Remove tcg/arm.
> Remove instances of __arm__, except from tests and imported headers.
> Remove arm from supported_cpus.
> Remove linux-user/include/host/arm.
> Remove common-user/host/arm.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/qemu/osdep.h                      |    2 +-
>   linux-user/include/host/arm/host-signal.h |   43 -
>   tcg/arm/tcg-target-con-set.h              |   47 -
>   tcg/arm/tcg-target-con-str.h              |   26 -
>   tcg/arm/tcg-target-has.h                  |   73 -
>   tcg/arm/tcg-target-mo.h                   |   13 -
>   tcg/arm/tcg-target-reg-bits.h             |   12 -
>   tcg/arm/tcg-target.h                      |   73 -
>   disas/disas-host.c                        |    3 -
>   hw/virtio/virtio-mem.c                    |    2 +-
>   linux-user/mmap.c                         |    2 +-
>   MAINTAINERS                               |    6 -
>   common-user/host/arm/safe-syscall.inc.S   |  108 -
>   configure                                 |    7 -
>   meson.build                               |    7 +-
>   tcg/arm/tcg-target-opc.h.inc              |   16 -
>   tcg/arm/tcg-target.c.inc                  | 3489 ---------------------
>   17 files changed, 5 insertions(+), 3924 deletions(-)
>   delete mode 100644 linux-user/include/host/arm/host-signal.h
>   delete mode 100644 tcg/arm/tcg-target-con-set.h
>   delete mode 100644 tcg/arm/tcg-target-con-str.h
>   delete mode 100644 tcg/arm/tcg-target-has.h
>   delete mode 100644 tcg/arm/tcg-target-mo.h
>   delete mode 100644 tcg/arm/tcg-target-reg-bits.h
>   delete mode 100644 tcg/arm/tcg-target.h
>   delete mode 100644 common-user/host/arm/safe-syscall.inc.S
>   delete mode 100644 tcg/arm/tcg-target-opc.h.inc
>   delete mode 100644 tcg/arm/tcg-target.c.inc
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

