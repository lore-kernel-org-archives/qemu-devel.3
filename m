Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E8E2C3DA7F
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2024 11:39:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1saZZn-0003eT-HT; Sun, 04 Aug 2024 07:39:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1saZZk-0003du-Dw
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 07:39:00 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1saZZi-00044K-S4
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 07:39:00 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-70eae5896bcso8217771b3a.2
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2024 04:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722771536; x=1723376336; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k10QrI9uz+NsHkHp2qDHbSR2Lse9i1jIO2kUQdtgKU0=;
 b=w+AgiAIbLo5CzoFk7QuduD3PKpJzRlwpxfnN0a8t6d0iYrZ1Wxa8hPVgdMRrKhCeEr
 6UQUvfj+MPjXqu+vh8G01lJCknmiqfPWkKalzzYgoB9FitbclsFWL0+AYuQsRf6o4LFo
 nx3tafyI5FnUWYdnX3sL2aBmN93Xp/YJcz8/Ea6zEsDKvnbi/c9iXjdLW31/bItkt4F5
 45Uyss42Cjfhu4yacoO4YORheP5GVxEjRLZjBIhzaIQtvXfGM6XDNbNzncy5y8c0wxU/
 OCwUX8j2bqg7RmStvOfwij5u5pDF77EU9sGFmKg16W6uWx8eN6+VX0H9IV23LkUOL+VO
 UiWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722771536; x=1723376336;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k10QrI9uz+NsHkHp2qDHbSR2Lse9i1jIO2kUQdtgKU0=;
 b=PY8xWUmyOssOEFci5uw99i6xdQfayqs/cBruQPzOERUDouzom6wvflT6Qj11EbwZTY
 XO4GfO22fOMmya7SGsJ/j4+orcmgAKJXITpoZD2p1xA3shKf7fzSV0pjMvPhBiOz+Kck
 TLXpwfz56+9x1JE+bWzvya8zfQ63MbezX8VOmKgAoCgrhUCJ9OUasfaiCFnKRxrHNtCb
 F/Kbq2nh5FzgVcRsWEF9kvx8nZYxXuhk438g3+yef370n/r9n5+7EOjZgCLhffKiJFZI
 5KNNy30DDndhBuV+cc7ainX5v4P2NovTGv4WaP+kL4+yRV7DytaIDuFNT8j5c1r2fGEx
 59ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSFCuSfmUPcgowkOecAHF3TfVXMj6s8lxVaxH8wx3ZwajtHa9ymHrzk4pmhOJxMz/etAEEyvJqGOhU1d5JCttf4ubhiPk=
X-Gm-Message-State: AOJu0Yz9EoTr+6ZBSICq0eb1yLRXcIOi6Ua6dhxlNGxAC6P6dscNHqE4
 bY3urh8iFUuEWcKj7gO/BB9alhHrEUydMsZk6YqW/PDc84kehea7v21JJswfl0E=
X-Google-Smtp-Source: AGHT+IGRNZStelsxmJLqCaf340ARbuMfyVL1sckcivJLivQqTP4pmeLdTkYVmE4vPi+viT8J1xVfaw==
X-Received: by 2002:a05:6a20:3942:b0:1be:c4bb:6f31 with SMTP id
 adf61e73a8af0-1c6995815a0mr12846770637.18.1722771536347; 
 Sun, 04 Aug 2024 04:38:56 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ecdfec9sm3957558b3a.97.2024.08.04.04.38.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Aug 2024 04:38:55 -0700 (PDT)
Message-ID: <7db89270-05e3-483f-80aa-fc044ea6b9b0@linaro.org>
Date: Sun, 4 Aug 2024 21:38:47 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/17] bsd-user: Replace set_brk and padzero with zerobss
 from linux-user
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Jessica Clarke <jrtc27@jrtc27.com>
References: <20240802235617.7971-1-imp@bsdimp.com>
 <20240802235617.7971-12-imp@bsdimp.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240802235617.7971-12-imp@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 8/3/24 09:56, Warner Losh wrote:
> The zero_bss interface from linux-user is much better at doing this. Use
> it in preference to set_brk (badly named) and padzero. These both have
> issues with the new variable page size code, so it's best to just retire
> them and reuse the code from linux-user. Also start to use the error
> reporting code that linux-user uses to give better error messages on
> failure.
> 
> Signed-off-by: Warner Losh<imp@bsdimp.com>
> ---
>   bsd-user/elfload.c | 110 +++++++++++++++++++++++----------------------
>   1 file changed, 57 insertions(+), 53 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

