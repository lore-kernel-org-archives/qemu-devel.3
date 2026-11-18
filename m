Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963F2606A330
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 18:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=RS078SMc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTkC5-0006QL-6z; Wed, 18 Nov 2026 13:15:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTkC3-0006Q0-5q
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 13:15:39 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTkC1-0001JW-D2
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 13:15:38 -0500
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-cdb15cd8558so859458a12.2
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 10:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795025734; x=1795630534; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ANi8myBpXLjtMRUfRk3xGAHfiPPJCa/Rk1WmJCqe/Og=;
 b=RS078SMcdqGIO2qyBzcfO2HAqwbq6+0reXIGSWFupAALB5HlmpmDCB9RpvD8IZdoHV
 Epc2KYI8udXbLqSf8yCHbAXa3/3xpamgvR9k1SYiZ2r0Gn8FbPxCpTiFPtZAgZStJbes
 EH5lVclwiYxSE85P1gertgCuxbC6nYE5572yUy4U7t0u54zPlddo4dS/ImIwWJ348TxZ
 ehwaQ2jsRe68HM6BJdejVCW5Ifpx4DgsKR39A0dzg6EtpO0VOZ5hXKBtrJU4OxOm0gjY
 tOelCWRwga7uVhFdXFLQIYZLKVgSM/9KEjRyeMWMEPJWL4xeOlR4d0ZG8vjUtGcSgXyK
 IZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795025734; x=1795630534;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ANi8myBpXLjtMRUfRk3xGAHfiPPJCa/Rk1WmJCqe/Og=;
 b=Z/9Ia92trUnyXEEcBxH3P4Uu7kpvM+x5jhYVFR8d4OsSVnw5tZL1R39zrk6pgsGywr
 g2HjRjXg6PuwnsRc7CkUb2d+x+KuEUzRU8NqyZEMW95sk2Z3c9udVW0CRbuebkkIRAvx
 MSjoxobiAFpNJDhE5FZCeM5/JJrlA4ITPOxnZekSAQ8lC+6PRZv/O2n+02jpeoQveugv
 LTX9mBBagLnpnY4Ibg663MWVGl7vZsq9z4JXqLKarSDbRuo/bqHUJWttTioE+Eu5CNmP
 mYvOdYPDZZDtQBq1qF04SkhHQcJ+v3NVNWrsorKsQWFAhz0HyaJajLiT+Mrx2mdbQk0J
 lV8Q==
X-Forwarded-Encrypted: i=1;
 AL+hErG8HHrE/mtcYOatHUIsq+FUPX9aaeXNSdbkrrxOiwhZSEekQWTec80mEfuFor/riXq1b1eT1RudYPle@nongnu.org
X-Gm-Message-State: APuU4Z8YnK8LQ0VL2wGpnjMy4J+FVVDTTdftQS6Ph7APDL90l3k3ofor
 zOcFKeZSPg+6Y0Gw1aVPbQwzsR1exaBdBTWSH715dR7ztpuOqwEM2PLU2s63ZCFvRck=
X-Gm-Gg: AZFdTZcIe67AYeWjIuhz9tV0niYonKqiQYGXriW7RT/24rle5s7PwIjcpwSn9DX+iD7
 yvr7818yEZ7ixg0qf9kslarimbs7x02f8B7/oG4Sl1YiuztTPuVZlMQ5r12xfXoyyR5AbUadMBE
 PCFZd3D92KguMwbodFe5Un+jE2XFdQnHx3zy9ny4Fw5xsMsb4dCWOWAcE791ZYckxRCfQYeUUxl
 8elayEsGGGie17jGBV6Z+qKBPg2dNGhZHd7ArgIEgEM0UwDemBz/5OMQ+DwiB49/cZPZxQ+4j7h
 5mFLRxzq05AIexqHv2Y2caqy+aBtvWvoV71RNRKWU7U77IQHvsFFB9UjB354c/ESIkBmyiknKJZ
 gps/KkELfOViKXF/z2Ghb3Oxp9xG3av/o7JQrA8E359iEsCrIfIWMHbLiaumZRqKRv5azqet06h
 8qkQvhkoHglMKUoSfnIqnTsKVYGIAcxYZT1EykLMrQM1STaPoq+rXJer35bV9TmfZpIcWgv/7cF
 sKeFOafiiPhnh2NI1toYodBht5esHcN4fSj1YQtRnYQC+kJQUraK9cRku2tckOfyWI8HaFK/qcB
 VMRyPHnQkwIqZCSxziO2z7sj60Ls0qjCkI2vsenAdHWg/ndtJsfN0FmXzLGWzH2aO5fswllry6e
 mWuJI4dj2fTQmS0GkWA==
X-Received: by 2002:a17:90b:384a:b0:3ac:17c:6e89 with SMTP id
 98e67ed59e1d1-3b3d079ffd2mr2821801a91.19.1795025734216; 
 Wed, 18 Nov 2026 10:15:34 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3f6be2493sm338486a91.14.2026.11.18.10.15.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Nov 2026 10:15:33 -0800 (PST)
Message-ID: <350da23a-4efa-480b-8663-c60f5d1f4d6c@linaro.org>
Date: Wed, 18 Nov 2026 10:15:31 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: copy nanosleep's remaining time on EINTR
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier
 <laurent@vivier.eu>, qemu-stable@nongnu.org
References: <20261118174933.3814952-1-brian.cain@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261118174933.3814952-1-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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

On 11/18/26 09:49, Brian Cain wrote:
> do_syscall1() copies the host's "rem" timespec back to the guest
> whenever safe_nanosleep() fails.  But the kernel only fills in rem when
> the sleep was interrupted (-EINTR).  When a signal arrives just before
> the host call, safe_syscall returns -QEMU_ERESTARTSYS without running
> the syscall at all, so rem is uninitialized stack.
> 
> That is harmless for a guest that passes distinct request and remainder
> buffers, but musl's usleep() calls nanosleep(&ts, &ts).  The garbage
> then overwrites the guest's request before the syscall is restarted, so
> the restarted sleep can last arbitrarily long.
> 
> Match clock_nanosleep(), which already only copies the remainder back
> on -TARGET_EINTR.
> 
> Cc:qemu-stable@nongnu.org
> Fixes: 9e518226f431 ("linux-user: Use safe_syscall wrapper for sleep syscalls")
> Signed-off-by: Brian Cain<brian.cain@oss.qualcomm.com>
> ---
>   linux-user/syscall.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

