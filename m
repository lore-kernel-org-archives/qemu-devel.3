Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7926CA5FB5
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 17:00:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viF4g-0000FB-Au; Tue, 20 Jan 2026 11:59:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viF4Y-0000C0-O0
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 11:59:19 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viF4W-00075i-Ry
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 11:59:18 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-47ee4539adfso46748675e9.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 08:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768928355; x=1769533155; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zp+q34HkkBxQesRvvW/sWiVhgHE9FOXw00x0+TsACCw=;
 b=jch1TFytFxnczIEd41gOAL3LzwC/j3hU1UdCUgfzcKI0zcr9ojW6q8Qp4f4XcZx/5j
 aWyTy9QVzfiQ9UqnCKWo8UexxRWAVUmgoAdMzW5+KRDuL5uOqeOcBjztUr80AtlYqTnK
 ZZFKmBGELbemrWbGKBVFhKXp3lrJlUY8U2i19YHdCR5G+Quiiy0Q9VfBpIhP+6YY+bVF
 jnpqyDzP879jwUh1EKFODu7ZHGB3XiXDQwV7bdVszICtBp4FYEx116kC/HgYhHDQrphA
 pTL2jFkl8Ut02DVzuMayOctyG8NhW8ht68LQsFv9EEhVhHwkWf7/yjbVzi+LEqT/uaK4
 VwYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768928355; x=1769533155;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zp+q34HkkBxQesRvvW/sWiVhgHE9FOXw00x0+TsACCw=;
 b=pDkSheYbZYM8qK+7VTX5JwnJYrm78kMCzK66aXrlyUTxOAi2ZFl/FXISo7OK+kmeWT
 RQ3S8DUw+1AHP+3M8Wbrx5mS6Ak5gCE5dZua5gKhZrnfHaSPAfKg2+znFub6w+ZYO1qy
 NDz/1EJLIxOUj3wF5DvlExomIOgmxReBGV9dgbExXyOI0KOlaB0+AXCmGgsaVB2JTZwP
 wUzb7m1QuaM6r1rmeVjMjmwc5Uiq6OX98ft7GfGuCH6ihXZbLCyDeyxkchGopKyxyJlR
 iEgz7oc1ndyDZNvweyI06GwD9U/zUCgFrAJYKBcEsTTVhWUw7q/Jioe9TaallR1XRKlp
 1t4w==
X-Gm-Message-State: AOJu0YzOPg33HZIVwcGvdZ1MXjDhEBoWDYpY73i3/9tDmSx7N8veSRYR
 SF/EuL80Q7vVVZMIz/9X1fGXchCra/0ous77HyCRXG/aLww7xDJ14EHpA7dh4gmKLuKOmiUOmO0
 7nbO6auY=
X-Gm-Gg: AY/fxX70siOT2kRaPEo9OavvWHONCmF5blhc4Vk9Oi1r90BOUF+Q4D2jQovVACwypTd
 rANZPNP89kIJE3L44mjNDCzqcl1mh3+4dfJqOy4oW5H2/Ri4v4VW+PBeaYU8xspKttGes8qbuet
 FI4iLcR7btQ0aVbn2ZlNLgAnMk8l8dzR5fePYM5VvbEr927E+/sBpPKfMRSp1HV88wP9+H2reCG
 nKmn91e8ONkOvik1edB3UPq0dXu5dYZV+b3V38UywU2ADn0WpwU0ATqb1g+tXYYPPAnmo7idPMp
 WWc0o5UBEj223DoM82jtlhFWcQgOUSUlldSTGIw8Q5XlncpFye2nO/ypHfAlPpsxjWVohVqAso+
 vnClzfUHZAAs9jZHcZrhDIDeUcfI+kDDohipFzB2mlw9ZYN9Bttr4Li/c3g6T8drHoY1bbYNHtt
 skydsr97KHCiq9YiBInw8VJjEg/p5YNUjZbx3C2Tjt5S6nkhAzqQwAnb92NKGtwxuN
X-Received: by 2002:a05:600c:3e12:b0:477:76c2:49c9 with SMTP id
 5b1f17b1804b1-4803e78ff26mr31595705e9.2.1768928354010; 
 Tue, 20 Jan 2026 08:59:14 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801fe6e703sm108669305e9.18.2026.01.20.08.59.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jan 2026 08:59:13 -0800 (PST)
Message-ID: <a0f9687a-48d8-4a8b-ba89-6eb882ebd3b2@linaro.org>
Date: Tue, 20 Jan 2026 17:59:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson: Do not try to build module for empty per-target
 hw/ directory
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Frederic Bezies <fredbezies@gmail.com>
References: <20260116131817.38009-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260116131817.38009-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 16/1/26 14:18, Philippe Mathieu-Daudé wrote:
> In commit 83d5db95d38 ("meson: Allow system binaries to not
> have target-specific units") we allowed targets with empty
> target_system_arch[] source set, but missed hw_arch[] could
> also be empty when building modules.
> 
> Skip such case, otherwise due to commit a1ced487549
> ("hw/microblaze: Build files once"), building with
> --enable-modules triggers:
> 
>    ../meson.build:4034:14: ERROR: Key microblaze is not in the dictionary.
> 
> Fixes: a1ced487549 ("hw/microblaze: Build files once")
> Reported-by: Frederic Bezies <fredbezies@gmail.com>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3272
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   meson.build | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)

Queued.

