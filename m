Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F6BEE6B60
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 21:37:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voTVK-0002y7-Bp; Fri, 06 Feb 2026 16:36:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTVI-0002xe-Lt
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:36:40 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTVH-0008SQ-5E
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:36:40 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4806dffc64cso22897755e9.1
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 13:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770413797; x=1771018597; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l2tA/Jkv7q61+7xUj5cRlo5yHKyHSToaeCN+19cFD9Y=;
 b=pXVe6r8AHi6zLJbJV3JY9O8Ci1S31NJjSf42NmsF+mCojkPivaSU6RnVT/egr/WTCk
 G+T3OkQio76XG8sqemejeT2IzZKKRtFxltDRmw9SPV1QcNdmRGQaVjfdYokHC40dy4Vu
 aUw9V+TcMPHjcZpVe4hwAwOp3VJQTVyXXC7NhD9f3s034Mck52npRzub2cL1be6kFyfH
 Dsm0LczKzcLgA4//ufS+pujSRPWGpMll7IBnAbpTF4c1r6wcfC6HjlTDqfG4dLczXDNR
 7Sb5HaLH8RFMZSIY2Pzm0A7hdJVMSqMyNf0Y8CIGzxBCyeJOd2PBwVgUH069NueLLbgA
 3eaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770413797; x=1771018597;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l2tA/Jkv7q61+7xUj5cRlo5yHKyHSToaeCN+19cFD9Y=;
 b=ECdsJXHU+k3Imveo5dSjpS9VfMOD0It2EeEGvszB/Rd2Q7eRJLisVubCy/XUAmrr2H
 7LHfRZAsEwePbGtpYT6loGa4/tgZ931ou541PhXrDZyE+GERmdCkYCsudjKqFHSUMK+j
 0RyUAOZWumTarCtYdlaW4s80OaxJerK9IqbwEVmBtxPZowmiiY/puxutSH5WUizdC8zY
 uGKQDvE7Rw3sEyxOUta/B7T7nSeFMumUnuhNkKmr4IWR44Xyn3Z3vh5uRpA/7aSmjXi1
 j8WrAjzx1iM2uu2i74+61i5X+DNke/F7i4qKdnOcKxZVFbGo+782/6jqz4GUFVY9kh2q
 N0lA==
X-Gm-Message-State: AOJu0Yxk1kj1Uh/jD67NpSlsLcjvPE5SkFqjZR4HIznU9AogZ2KphLsZ
 EaUytS1WKOZttzNottysRm0JVg/TTx8MNyWOS+rufA0HwskcVZ0Qtwn8o8muJPlxzOIz3T2uNlW
 DPqM57jg=
X-Gm-Gg: AZuq6aJXJqPqZXFv4abMDc0+yRf4M/k98Q60X8LgmvvW9+ndchQpBrKfArGzBpM3wSZ
 wxb3Ihp2MaiSVnG/3bAq0qJd5KnxETwAzdK4FtFjWNouU1VPXOWw2G22qonQdnG2PVSREi94gd1
 ELhnsAxG48cBVN9ksZIc9U11F1resOuRC/yGYYKkfF2AyxSynfseJZKMqdKWOq8BJmqNal/zznP
 VaI1y93QOrHkz0Hnj1p+c7XLcdiDJtsrBtZT5WIyp36FdqrfqIlybfNTOSw6ZWWwgRbTPrb0FQT
 zPe/UOKg1kL04m4XGxlD9uiT6UuWUOQgHUSDoE29206SeHFscK4fW3xouWQ9D+WV3e584ec1oJ5
 83LoU3W+7g90iQRPXf+XodPh0lwkU+DsQkms+ANuY6VT/wKfwYi2hML2P4lgA+uVqI06KmTothk
 FZrQ4llvxcQ2Aihp+Jzb6GQ3HXUCwFlYGZhtLcE1zKgt5wmOyKi1gVqw==
X-Received: by 2002:a05:600c:5307:b0:47d:264e:b435 with SMTP id
 5b1f17b1804b1-483209669f6mr45973245e9.22.1770413797200; 
 Fri, 06 Feb 2026 13:36:37 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436296bd1c9sm7980340f8f.15.2026.02.06.13.36.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Feb 2026 13:36:36 -0800 (PST)
Message-ID: <c14894e5-1d88-4fc3-9804-75f04506f93f@linaro.org>
Date: Fri, 6 Feb 2026 22:36:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] target/sparc: Stop using the legacy ldst_phys() API
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
References: <20260204215304.52757-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260204215304.52757-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 4/2/26 22:53, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (2):
>    target/sparc: Replace legacy st_phys() -> address_space_st()
>    configs/targets: Restrict legacy ldst_phys() API on 32-bit SPARC
>      target

Series queued, thanks.

