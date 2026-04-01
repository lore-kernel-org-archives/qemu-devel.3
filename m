Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71064D35160
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 09:12:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7rbc-0006gd-QY; Wed, 01 Apr 2026 05:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7rbb-0006bN-DD
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:11:19 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7rbZ-0003tI-Qt
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:11:19 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so55439775e9.0
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 02:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775034676; x=1775639476; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zYMDYxT1WbqRRVn7+pSbF1qxatyIZFu8lu1SaHzlQt0=;
 b=I5MINFwHuOzVL1DOVI911MJDrKBpapVbQdwdPjfrrWji9ZLnPEjEhJYrrQVq0gnRZ+
 Q5CnN2wQDj36xb+rY6S+2xmGePbIQYGo/tRx4i88Bhzb3Y/NKpOHd5SXJYUmD+HTX0JT
 ipNnZ5fnK1/dFqn7u6KziU8RPK93aV1i+uPeTgdT7BUHSn9ErxLGabcIzbyP4OwDO2y3
 /28t1+9CxcTlkO1cRt+TD6oFR/qM4BXtR7EKUQhlQwcVtFwntCnTrvdkUIhSc2EEPNwO
 Nc5zzShyPnffsJLQ0z7ib+7MXz0EH3/40z02124AHUlqJz/erG6d1uZ1dLq13GuHA7Ix
 RcYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775034676; x=1775639476;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zYMDYxT1WbqRRVn7+pSbF1qxatyIZFu8lu1SaHzlQt0=;
 b=R+u/aTNBZ5wtv+Wxr0Qy2EHDr6f4cpupoQBWYs930W73MffBQJs7E8ZsUfRwp9+cnF
 jtDM6v9oNwahjXyNByfW+Y+jNjLzBEKzPpRK6xyj1TwA9zDvzWCR9b2mGDmD/cZW28F+
 jO5sHt1MKt2BhiBD/Gq0KfqMFroN68YLC3/J6DFSNPRpEMp1fA4uR0vcRSpZ76TTdRRj
 ZteQJ6MuR+2KCmPgO7gOqX3nbA5AydjmsK54NaRlgm5+Ld2RfvjiMKqDSi6YzLDU6cN2
 d56y8YyLOGn8PJJeKewHh8JXzfZbaHZ37dKA+7P3a9+Zc260eDxiMzsyRa/FXYhk9/Fo
 FydA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkYm+2ZgaocGBru5QvL2aLl/gjlGFRwNCkOvDU4Z7qSyFKhKul5+KRkLGiiCtQL49jsquBF3BrcmSu@nongnu.org
X-Gm-Message-State: AOJu0YzDInidHABIrop7fFcm0Xwld9gWWfJ6tC4fHdLcfeFUpDad/X4k
 ElGiNBxIGqsGrShpAy4SG8isUegFMbdMw+KhQIfY+a9SbID4AfJW0XOesb/XvKrjZe2OEjWl2ZH
 n4sK781o=
X-Gm-Gg: ATEYQzwO3w/yzSXC0SCLm6LIKMLZdRfl0xK1VhXsEzDFuuBg/UI8MK/WHsQDF4TcmOh
 nNRA+DX5QLceqTbACSTu3OmQconJ8qv8yA9Yo/gnGJkTBW4+sySdqIguZ1c303tTqFMPqX4IkW0
 Jf2RXCz1GtGiOtG9uBJGptDsFHHMXrIRcr+FfLh76vVvZZgB9vOR7Mlh9KQtKVLMbrTESlTAiKM
 nwnc3KXMcOBpi5tLISX3gkwt8yVcJFylIr80XGLnANrETHdwXK1PlEQ60Y/+vEQVXTvxbuqEDKN
 i8VKpDUUiTMtJyT3Kp6RE9SApx0HM2AchoIQGLkUdSmCtfqCwrSDJNzHdkIL4Qel+GtsNYzgb2l
 VjzlSZJ2qDoHxlyS4xp88DqhZDfhoaxNXj1DAmb2Lemi0uFJMBaTBpmvLSwg9Hg/cvhKSIZTa2b
 v3bPvAwhOei2h/Hz98KdMP07j+p/zMEUjVoWk5Lyx9cMeRAupVJhN+pL3Gxxpx4MxwvQ==
X-Received: by 2002:a05:600c:19d0:b0:485:45fb:3472 with SMTP id
 5b1f17b1804b1-48883562172mr42034465e9.7.1775034675778; 
 Wed, 01 Apr 2026 02:11:15 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e82e669sm93879915e9.11.2026.04.01.02.11.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 02:11:15 -0700 (PDT)
Message-ID: <baa87019-7049-4dad-9000-b84e8c93fcbb@linaro.org>
Date: Wed, 1 Apr 2026 11:11:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/60] ui/console-vc: make show_cursor() take vt100
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
 <20260317-qemu-vnc-v1-19-48eb1dcf7b76@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260317-qemu-vnc-v1-19-48eb1dcf7b76@redhat.com>
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

On 17/3/26 09:50, Marc-André Lureau wrote:
> Decouples glyph rendering from the console object,
> continuing the QemuVT100 abstraction introduced in the previous commits.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/console-vc.c | 32 ++++++++++++++++----------------
>   1 file changed, 16 insertions(+), 16 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

