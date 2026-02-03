Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A2DE8B37E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 23:04:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnPRC-0008OG-Gy; Tue, 03 Feb 2026 18:04:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnPRA-0008N6-Tb
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 18:04:00 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnPQz-00070j-Nw
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 18:04:00 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-81f47610542so89505b3a.0
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 15:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770159827; x=1770764627; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YmmvDD14OGTYibtsepjMmXRDnJuCfS7e5YZw3oG0HWE=;
 b=EI4WlxT+fGEjzjjbHyJpR4fAFg4dFbLqzVjBbtxnPxw51Qw2Xh/ik6iE18ajtyhB8h
 YAh1urJXmWv4Nz1d1D8YD8zwvUriRADzfaJ48DhN+aFw8FbarU104yJZua+aEQrwws1P
 lnCSaU9qgKs0MAKUfcnXwSdeHClOS+V3VkAU5jWgTMGmhSnsfqodtIQNldvmVmb0ZqQ6
 9gcjbYurhPI6pW/dQUDv0PElVEF7jGAcZLtw85eh9zEm0PirysjK9PYsgUSr4ETQuiKK
 Rk9lq2NHlbD/llCWTcvVrGFr6bQEzU/eCgzvXJVZWqfFkiY4XENyGLUiTNbzbRpCeGDN
 JlHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770159827; x=1770764627;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YmmvDD14OGTYibtsepjMmXRDnJuCfS7e5YZw3oG0HWE=;
 b=dQCiuHYqmOKWKmPKPh/E44+LYxVFcV7jveE+27uH53PrKBMRo60bBD+96dCg2cpH3M
 8q6Mnr/mRgNketbvH7Hl777gqsCiLq3C9cTzn9SclPPwgTld1zPm1I+QSXk6JvhbIz4w
 yUXR2VExCjv7Q6OQFY85a3cNkDfm1JT6fwDJoKCpWcgzSDauGYT5PEGcAAyjAZH038HC
 RZcrbYR9ROR+0AK2VKvsjc0kvHG/ZQzOLZ4ehy2TtNEGKsq6IWM1reps4hst9efUClyS
 B5c/rGAZ/SdixXTLRYqrlgcG2u9+/NCza7Jw+bT9/q5FRqykhWLgAaNmkChfK0ZaPRfk
 DIEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqQFDYdZx2v9qMb5az4XphB/IXBkI68Ji+LLJp9aQr3RipSwQrlUBwxJPmD40iavlD62M0CNe5vaqe@nongnu.org
X-Gm-Message-State: AOJu0Yzjz8YpJ8eBDWwDAvjietnXB0RjljuADRpsfGyEsTKpjucL0bbk
 gNug2mZbGCC2dFhxOHcFlGJ/C/ErqxnmpQn1fFRk/HNswJ/VGcMOpRNumXYK2j/BvC8=
X-Gm-Gg: AZuq6aKLhmAzxQzvj7AtUahKrds7OZ5Qcwq5H5uWmvoYuYmNUnupwtjFjEAso1cDgTe
 sVwngmuiUDHq3Yzc6Uo6EEuTn3Ndqmtt+bfAE6ISV5iow0BfZPBWkRy5qQHWw2h4ZrvABpWYkQf
 vtLmnsJNHbRtRiBOq9zvWsSWUfLpFmNpv0n4/TQnjduAd6YsNRSvYf6w3JqOZQ5QucnjefEheU7
 3Z1RckGhtmhmLytVifF4UywaqSdjIMfCLdNT5xdKv3YM6tcYK9dSGKsG30XtaG0l2HByLq8RgSf
 714rD/1gAbCIkMHE+QK4FDcrbMD4ODn1SaloF50lCVLJAvaW2ia5SGH7g1+NRyaqAedtMTh1aqx
 Gf2X38ADVtfK1ewFuoQUwhpXIZn2tQLYg7aeUt8nqJ8rvGizITgi4NB9p+DH7FPbCZKaNTFYcDO
 UiKajEV2npqrFOBow/e13125eNwaFi4wT4Rpdbi/xRXJ31Q5YzioBRs60Xm10AKIVf0aJ8u0dz4
 jRr3w==
X-Received: by 2002:a05:6a00:94e8:b0:821:8569:7f19 with SMTP id
 d2e1a72fcca58-8241c637b09mr953409b3a.59.1770159826839; 
 Tue, 03 Feb 2026 15:03:46 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1bc:fe1e:491:928e?
 ([2401:d002:dc0f:2100:1bc:fe1e:491:928e])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8241d1c08e8sm400344b3a.22.2026.02.03.15.03.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Feb 2026 15:03:46 -0800 (PST)
Message-ID: <97728809-6b99-4ad7-8acb-88db9fcabfd2@linaro.org>
Date: Wed, 4 Feb 2026 09:03:40 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/tcg: Remove a redundant argument attrs in
 io_prepare()
To: Jim Shu <jim.shu@sifive.com>, qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260203142737.2164763-1-jim.shu@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260203142737.2164763-1-jim.shu@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/4/26 00:27, Jim Shu wrote:
> attrs is already in CPUTLBEntryFull, so this argument is redundant.
> Just remove it.
> 
> Clean up commit 94c6e9cf04409e38563080348d6136879f91ffee
> 
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> ---
>   accel/tcg/cputlb.c | 18 +++++-------------
>   1 file changed, 5 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

and queued, thanks.

r~

