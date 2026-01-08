Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9100FD1D48A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 20:13:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdwNl-0003w1-3Z; Thu, 08 Jan 2026 15:13:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdwNj-0003tu-Sw
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 15:13:19 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdwNh-0000nC-Tm
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 15:13:19 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7bb710d1d1dso3782846b3a.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 12:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767903196; x=1768507996; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vrm2mV3IiS5qG7ZLmnCuOyy//Qd/VeBtpKd/WeSU5qM=;
 b=alWOjdbDCUkY0BcgOKGYeRnvkkCVKZM2Aj+RgtS9KYmb5AUHYb2TuSLfqH31tAqGDl
 ZBELTjSdjFVVVNt3k/ptrycmQVareTm4cjfx6qZI1fyR3qEoCJ5H1O6rfxP9X+t/z1/Q
 7XMHhIFwXXgl9exs1bvB6DARLFbdSY5Hy5asJZjPWa1k1R95mAcgbJmV3sIbIezVbTEG
 EWSk7L0cdJQtfUCI0AEexZEkqmVnmaZVvBp6ucDRHmqYAQWc2NI9z3Eyu8aYQoihoGgO
 bRxqQ8wzKizXJ836IFUM/9KY6FavDE3urVeiJjwwIzNVKxruZA3zsVyzAWaYZ1kwLKgF
 I2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767903196; x=1768507996;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vrm2mV3IiS5qG7ZLmnCuOyy//Qd/VeBtpKd/WeSU5qM=;
 b=IHTRZXjWBnsoP7LIBTrkHyx8xFcMXSw0SklGsxN2BDngsioyKzoC3hZ2bHfMQBAjF6
 Kx7sxkNBuOriWPAIV06X2Pm7GYRGX3J8tUEvTAhvErBBiMPUL3RZdaoKndnWut27CIOh
 Hwca9ejFHmZHy/pExhQM6phXxTSwozwwanNHzkDOfKDInK6ZcGF9rlYDCJlrBCPmVbwJ
 0GSRZtJsHyMq6zR0Ut1ddN++UutdjMkcGVHrl3rT8dPCy05oNBBLmXLwT1GQ6YAqd/JF
 wv16+EWmqcWUzOTSiDnBJlFOD6nyN5eyospORQogdTAFzY916aj4D9D5cnBImJVEkHyr
 lDQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCViPNJmad2HIm0x0hyiwhGbaUuYPoprdl6pgMrz5v6F9JlXfC1zM1PyM1UjENNfprDj52fcXRug9TXr@nongnu.org
X-Gm-Message-State: AOJu0YzwrEqe18uaObr3/HTe4Ago4YIbmdJgJ5M0FVetq8Z4vrp32ZVK
 AM/pLjBQiZCetcZs3npCumvR9qlIJKudKcKozNJcl2/c3eS4OsSq4XvpZVDAt6rHag8=
X-Gm-Gg: AY/fxX7d0xINXdvbTxmIVIH0uYstv77uIwsTPaW+qK0ZfkTZ0/j7Ly1Am/yEaxgiWdS
 1TFRLblRlD+Qq22KWSTg/xDfS4C3YkCbgOUs11kLn0yp3NkoVU3jZhSUaflHONqzhPJeGHSZ3cd
 dhBnwCMnYrOlqJ6z6HY8ipTWDD4CfSRtXvXwgtyMyJ5SPq/ODuNNTKxNfFW6Y3j1ztCxnPcqCX6
 35B2K8XhZQmtO8w1ZB/CBFkMQB9KmVrQ/DkBpeo6I30yKL3rGfPfSywGdogUwJl0ym8sJneEsdg
 LhOBT7RHqmb7Mm2YGWeQ+1+EDviNq73yCKqHpWF6UydhaXcgMeTaFRHyqhWA5FRJADV6ei9qH/8
 Yi4cRE9Ze+A5sjiRKu6juxNb6kbpfAywr6Sx2QZPRn0XabXCmILQqLxEUqXSS6+ThM5QXK4Rh0j
 PKAEE48ko92o/A31pWJgIaukL8hYCg/pImo3RVsgLME2ACN07OAJG5EDu4
X-Google-Smtp-Source: AGHT+IFtAlFBlpQnnYQE3jtAbhG4zEd7uNEZ/hZ9KPpnD0n/BfJrka3zn+nfce4G0g9jSE8riuT/lg==
X-Received: by 2002:a05:6a00:a883:b0:7ad:386e:3b6d with SMTP id
 d2e1a72fcca58-81b7de5aaadmr6536502b3a.21.1767903196295; 
 Thu, 08 Jan 2026 12:13:16 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-819c59e0531sm8389380b3a.49.2026.01.08.12.13.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 12:13:15 -0800 (PST)
Message-ID: <b174a3e8-6c87-4a0d-a879-66a148052446@linaro.org>
Date: Thu, 8 Jan 2026 12:13:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/50] *: Remove ppc host support
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-10-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260108053018.626690-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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
> Move the files from host/include/ppc to host/include/ppc64,
> replacing the stub headers that redirected to ppc.
> 
> Remove linux-user/include/host/ppc.
> Remove common-user/host/ppc.
> Remove cpu == ppc tests from meson.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   host/include/ppc/host/cpuinfo.h            |  30 ----
>   host/include/ppc/host/crypto/aes-round.h   | 182 --------------------
>   host/include/ppc64/host/cpuinfo.h          |  31 +++-
>   host/include/ppc64/host/crypto/aes-round.h | 183 ++++++++++++++++++++-
>   linux-user/include/host/ppc/host-signal.h  |  39 -----
>   common-user/host/ppc/safe-syscall.inc.S    | 107 ------------
>   meson.build                                |   4 +-
>   7 files changed, 213 insertions(+), 363 deletions(-)
>   delete mode 100644 host/include/ppc/host/cpuinfo.h
>   delete mode 100644 host/include/ppc/host/crypto/aes-round.h
>   delete mode 100644 linux-user/include/host/ppc/host-signal.h
>   delete mode 100644 common-user/host/ppc/safe-syscall.inc.S
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

