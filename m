Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46251C25B75
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2024 13:26:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8K50-0005TE-Ka; Sat, 18 May 2024 09:26:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s8K4y-0005Pl-VC
 for qemu-devel@nongnu.org; Sat, 18 May 2024 09:26:28 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s8K4x-0006ja-0K
 for qemu-devel@nongnu.org; Sat, 18 May 2024 09:26:28 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4202ca70318so8682215e9.1
 for <qemu-devel@nongnu.org>; Sat, 18 May 2024 06:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716038785; x=1716643585; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EYPOZ5rEzr5gQlcZaXFl2hCJQGP8KNjnXFLeDsFChAw=;
 b=kLx8iHKfq/DnqP/0AtRFltdsSTlWncS5fZgbgVxsvlrco5lCt2sFYB7wXxKD47Qxl4
 V+i3maZBbFhb0sbirsyqDWDA9jlL00e0x7oQn3kdZJSXHhlp0cwsSpwu7SwU4QgH4YO+
 R6+tT8OdiJHsoq458HCu5VLkTKgeSm9m0pnWMSbPN0XM+XX3ZM8UxeCGSLugC3jthOx0
 SkVoHZLdTfkG/msIZt+Ie2wT1aeQMnvnbCr+ahasd6DbJv8VKSkvxOuvfNZJXKuFRMdN
 2j/GF6VrUOBxKf1dVlLMkTptpvHTZN+3YOlOxAKEtQJeK0PmeWEb0uTnbfWpz4+OMWWw
 ZjUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716038785; x=1716643585;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EYPOZ5rEzr5gQlcZaXFl2hCJQGP8KNjnXFLeDsFChAw=;
 b=tHdA5+IyEbWtTpHiUYqY4E02TAa7dqXBcK365wp47npXO9lxaHnHoCYTCWNgZeehrz
 O/giZJwZy2yHqrNu02SM/sgO0nI0AAaRhs9p59pA5PPMrxkvEiOMib5fUemA69brEiF4
 bQpZtmFYeghqIhoyYNEsYaxahiiwNCCyHQWJO5tZ3Y4k3hkpMo4qYwjIxv4idAjMyVnL
 /mSgIsBB7+qpmV1cV9h5j0VjJvkricASXM9NQ2GRfe1DhY5QSewv7OQOW2MGgEMX5vHV
 /BzGT//BP6VbsvdyGYVD+mQLxyJYmOFZ+quu3tTCls9E/Ozk5m0goHkkEOw2R5l8bD22
 CWpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3FMRB1zXCPKJ8Q7xfltYwIy4hxQXIq2tOSw3JIb0SY3faZ9Zwq/K7/1xgc9TuOrQXC7wdmR20X7lt8ywjT5yIKILNyos=
X-Gm-Message-State: AOJu0YySt+N5mO/fhnyfWVi8SEEDQADMg0smMj/MBY+mv5uQ7XaDCiPz
 llVLzPwTcAz/o1OpZdfIeWWqQvrBVXmh0EuCRJHsGJFhp13y2KDYFZdddF1HVxg=
X-Google-Smtp-Source: AGHT+IF5QGY6IhTrInkXSGzP+ZbIuE1SFBF2nX8PDaK+nZ3CANhQPXFRG4mfwhxv7n4wd39rP1YSJw==
X-Received: by 2002:a05:600c:190c:b0:41a:821b:37f7 with SMTP id
 5b1f17b1804b1-41feac5525amr201216495e9.27.1716038785214; 
 Sat, 18 May 2024 06:26:25 -0700 (PDT)
Received: from [10.1.1.126] ([149.14.240.163])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42010940845sm266136075e9.35.2024.05.18.06.26.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 May 2024 06:26:24 -0700 (PDT)
Message-ID: <d5823730-44cb-42aa-a9a1-8e73772dc6f2@linaro.org>
Date: Sat, 18 May 2024 15:26:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/5] Misc HW patches & fixes for 2024-05-17
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240517150227.32205-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240517150227.32205-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x333.google.com
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

On 5/17/24 17:02, Philippe Mathieu-Daudé wrote:
> WARNING & ERROR from checkpatch.pl in tests/unit/test-smp-parse.c
> deliberately ignored.
> 
> The following changes since commit 85ef20f1673feaa083f4acab8cf054df77b0dbed:
> 
>    Merge tag 'pull-maintainer-may24-160524-2' ofhttps://gitlab.com/stsquad/qemu  into staging (2024-05-16 10:02:56 +0200)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git  tags/hw-misc-20240517
> 
> for you to fetch changes up to 93a3048dcf4565c73f2aa1d751f7197e296f1f1f:
> 
>    tests: Gently exit from GDB when tests complete (2024-05-17 16:49:04 +0200)
> 
> ----------------------------------------------------------------
> Misc HW patches queue
> 
> - Fix build when GBM buffer management library is detected (Cédric)
> - Fix PFlash block write (Gerd)
> - Allow 'parameter=1' for SMP topology on any machine (Daniel)
> - Allow guest-debug tests to run with recent GDB (Gustavo)

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


