Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F595606A327
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 17:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=WokY2i+p
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRvYf-0004kt-BA; Fri, 13 Nov 2026 12:59:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xRvYd-0004kT-V7
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 12:59:27 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xRvYc-0000Ga-GG
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 12:59:27 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-cdb75699c7cso497486a12.2
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 09:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794592765; x=1795197565; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gyH5HoCUO/wC0vlj2WM2VUInv839nUuhYu69gFMHB80=;
 b=WokY2i+pzTcV5ZzNQp0puTjKMEEX2IaWXwanOWIfIC6XIe+P/aGr+OZLtgdV+DSVu0
 tRsHMvyyCq3z8N0OoyGZ8mW6kCg1E2fPnT9uHyo7KR5/DZl4MgglYvhmMexLHcqWBRo5
 JfhVEhL20APNwRdJ54SsAqzSL5KLxUpxvZ5T7uOC50mKoPkP6vmxPxP2nCViT++GgWcm
 I//Amxs6ZVWFN8l6tf669Tn1RvrLjkaDfgn9DX8OZmM9sDOibJNvLvSfsrlEOMgkso8i
 B9G0zIqSmUNwV1mguSXNIXvFvgQkj27fykY0pxpMvFAyMLb5afuXrnq/xLpWUQ1dHwe0
 APaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794592765; x=1795197565;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gyH5HoCUO/wC0vlj2WM2VUInv839nUuhYu69gFMHB80=;
 b=WLjgN8GfJIoHmZNROtSCNq8bzvsUY3qmxWOc4vjP9HS5jaXWns4uXMJqYoUzIn3DZR
 8wWUlAIjufySamf2pgR1Q+UKUW7W38o+KgnH8bdBqfk7rYquTouK9kP8jMtNWJ8Nthl8
 QcIzmiQWDHfaNkq1edgy1cwY4zkA/EosvIHL6Hu0sqVZDVOYvWCkSsLAzNN8d3jCtPsO
 93N+DLfDJ1ahtP+YekFle/jIlCzbsO7Vbuuzu33CNbyY34A9vLDmyoE4tH+WFJgXWZ6G
 kdfUh6PfP9UJmZnpIQgc8lmRawmX0baK65+tJDrhqmyqmhtztaRFyl538XK//fuJETDO
 yeOw==
X-Gm-Message-State: APuU4Z/wMNRSi46UrlGB04pBUq17crgZPQXZZ8buecQxvBfhJHoW3zZ1
 Z2qTGCF+jJSvOL2HHM31VuJHAcWasAJs76p+ozlVJDcalYwUrLXYmpg8hVFb82t7XobTAwmHB1h
 Qj0zYFEk=
X-Gm-Gg: AYBFou2+v8Wgu+eW103cPU4gH9IOaFZGnsVMW3UrTj/D5unwcHVMnqa5hZhOY3cAZfd
 N0rwSAAJfM5i5w+uyViF8Zsm9iWnhpRmX67zR39dY3QXeD5as1pwHXatmbcrE7Sny3xFQWikNQf
 WA0yBN0kJLE5Tf46y8BYSmxgJWa8z+zQ7bLnU4qJTGLPUCWYktFVM5Y/s0xZ4hwJxNECuUmQyP9
 31/AqQNcMrlbC+NFXH4Y89z/6dN+mWY81ohrL3od+FWZTQkR9dXeRncZyQAbySUZAfF+BlaPO5s
 s3BfwpamDrlaxkgGlUuY7iQp1QLnGpxCUGuxvRKGzZHySEVdmL+7+Nn3E3Klfnwx1jL/4efTSxZ
 VGNi6StNmdNpPWvjKzdA+8Y1RrYmQx/0jh+alEAE90EQjEGWZhcJrJf2j9/tLIFHPjiB7VVN73i
 JmwQWYOdWulcyklzMvLxZYBvfNm37uZBllyi/UmprblIhLAFz/PdhFLyi1kP8RUepJrNcBaTaxu
 GMxd6MrbTBEXJTa7jVf9iDsjSgMnKZG7tDmBPoEHR00+/rcoQgx5czjfQHvUutxXi8Mz09bh+Km
 Go7hMNa66zUjkH5Yzlxax7IiNX6VLBIVLxEZxhDj2ZE=
X-Received: by 2002:a05:6a20:30d4:b0:3f8:63f6:c8cf with SMTP id
 adf61e73a8af0-3f863f6d38cmr1052647637.55.1794592764387; 
 Fri, 13 Nov 2026 09:59:24 -0800 (PST)
Received: from [172.31.6.230] ([69.196.88.181])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8bed1d5eff3sm1476935b3a.30.2026.11.13.09.59.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Nov 2026 09:59:24 -0800 (PST)
Message-ID: <31198174-09ad-4697-8647-b107420efa1e@linaro.org>
Date: Fri, 13 Nov 2026 10:59:22 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386/tcg: fix SETCC(zu) optimization
To: qemu-devel@nongnu.org
References: <20261109185654.1068614-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261109185654.1068614-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/9/26 11:56, Paolo Bonzini wrote:
> With EVEX.ND=1, SETcc zero extends its result to the whole register, which
> validate_evex_apx() requests with EXT_Unsigned.  QEMU is trying to
> avoid the extension by changing the size of the operand, but it sets
> a field of the row that is unused, because op1 is None.
> 
> Do it in gen_SETcc() instead.  The result of setcc is 0 or 1, so writing
> the whole register has the same effect as the zero extension, and
> gen_writeback() skips the extension.
> as bytes.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/decode-new.c.inc | 3 ---
>   target/i386/tcg/emit.c.inc       | 8 ++++++++
>   2 files changed, 8 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

