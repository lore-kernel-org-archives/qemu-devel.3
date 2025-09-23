Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B19CAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 12:48:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v12QC-0006SY-Jz; Tue, 23 Sep 2025 08:47:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v12Q6-0006Rb-To
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 08:47:00 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v12Pv-0002I0-40
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 08:46:56 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-46cbdf513d7so24314675e9.2
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 05:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758631598; x=1759236398; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QuLwtG9uBnlrIrDVYmpmsi6ngL+ysvkV/EN0EXx68WE=;
 b=s0AEPTUrGBl4aRwdKAUqmbmZnxKYwnjUzkLUQdJVYD1fzUvvLTGDWggY/aPVHROHaH
 NrDLptxInz4rexSOerJuvSgJN5yM+jstDaWZgiBU3HTomsLMTpjdiNeVY7Sao9FIIvVO
 lUgn1jFuiCYfDIPn4hhwopDqwzsB3tZw5+qQR+ATHny2UFzHdekR6yprxszjAdLGvnKN
 CgwcjFcYRj9OrPEw5fk+7rknB6cut1haXbQ8Pyrw//khF96pfK6mYpt3LKMFwwzPqdwl
 5R1sE6GBylysbK5/hYsAGrvJ7fmf1zP9W8q20IsvmmNH6IpJKArcLjTWZLhdsHTooHBH
 WnwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758631598; x=1759236398;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QuLwtG9uBnlrIrDVYmpmsi6ngL+ysvkV/EN0EXx68WE=;
 b=ipCGyHEQ/sX5igASLk81oHDPb57hNQ2G3BRXBwfDLvkV38rSia2IF/MTVx5OYdeaaC
 kAA381cMYcDWVjwFEKogvOjHtUC+6O4nHIbP1NxYs5R0eCOpqgPsxJ5n1U8I2Rpa4SOH
 bEj1S7zzrcNA+U65YKktLGK7GX0dWU4ke7ooOB8ebzHdUiijMxrD5c/Yl/959KP/rwlK
 F55X/VPgXDGe3McjuRwaJmHb+lZ5LY4SLLwfUFAefrb95Un879+XFtPY0iUSAoE5MqfR
 cciSH1XYX37T9TMnnMkx+RDZaIMOljUREJ6gxv0uoB9b5Xj59AlrsCBPyPcAA133iOHu
 kXgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXp0rQ+rU31B27qXP1wE6yds9iX9zxzJJ72djtJbSdx1ssOhwELkdqvCKmIfiSLo9Q5jneDFJ1HllGD@nongnu.org
X-Gm-Message-State: AOJu0YyNYAb15tSAJp0MMRobBKF9uNPpdY2DhW1tUt1/VmaTSZM3anxz
 VO16cq6TtbZZkXPaxlTDUWnfmmlH25WT4jlLD0x6vHlCQjnZq/2LCHt3k3hTD4os4eY=
X-Gm-Gg: ASbGncu0fZnxUlBUkejfvtoM5c3XA8nCQU0U+O4vdomq67Pt//X/axv2JIyj373duPH
 LT2cFvDofy3DdnneWTVaUbs+rMzdLw3+g6EvRZDwbgyOSHY7CANpMBL/Sjei0cHviW2/rUrEiDC
 3OoKv4lQAuOY7jqIpmtgcAKNDs57EhxGboZRn40thfkAR+p+hkHQ/kpdj2ILpeV412D89CRqARm
 hsAhH+tkVYLKCqoZK+pxff15nXiFwI/9Bt7tK1j2Eh0GghVGDg8BGWdQvWF97y6vC5ygPymG1jX
 tzc9AcYIw34TFdDPV0l+BvcmxnVxv7qX+xbZGLQakuE6DWG3gr0p1tj8FM1hllpQs3KeiL+/HGd
 up6pajTQsX+G17oVvOl1CbRFZxuEQZp8JRBbQz8vyZbPiPp1rSeta/PlHJ8CaFGjmJQ==
X-Google-Smtp-Source: AGHT+IE9DzUBWPOAyZSyUf96M940fnHyXJR+R6ZzZT3rYMs4X8e3lq0rssHkcfb8yuKi/REIiKnTMQ==
X-Received: by 2002:a05:600c:4513:b0:45f:2cb5:ecff with SMTP id
 5b1f17b1804b1-46e1dac8d4cmr28095575e9.31.1758631598351; 
 Tue, 23 Sep 2025 05:46:38 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee1095489asm23035106f8f.24.2025.09.23.05.46.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 05:46:37 -0700 (PDT)
Message-ID: <a157e0f4-4921-4698-885b-ffd89f40be02@linaro.org>
Date: Tue, 23 Sep 2025 14:46:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/20] log: avoid repeated prefix on incremental
 qemu_log calls
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
References: <20250910180357.320297-1-berrange@redhat.com>
 <20250910180357.320297-9-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250910180357.320297-9-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 10/9/25 20:03, Daniel P. Berrangé wrote:
> Some code makes multiple qemu_log calls to incrementally emit
> a single message. Currently timestamps get prepended to all
> qemu_log calls, even those continuing a previous incomplete
> message.
> 
> This changes the qemu_log so it skips adding a new line prefix,
> if the previous qemu_log call did NOT end with a newline.
> 
> Reported-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   util/log.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


