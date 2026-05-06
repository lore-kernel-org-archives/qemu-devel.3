Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6E5ACD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 10:40:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKZg5-0002ph-KC; Wed, 06 May 2026 06:40:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKZg4-0002pT-5j
 for qemu-devel@nongnu.org; Wed, 06 May 2026 06:40:28 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKZg2-0004x0-BS
 for qemu-devel@nongnu.org; Wed, 06 May 2026 06:40:27 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4852b81c73aso48031415e9.3
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 03:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778064024; x=1778668824; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XwnbU1XrvbTkLWWCdQ77T+igmAlaNPY7vJV61myV5Js=;
 b=kfeWx6t7GV9ge7TalcK6r6Er/ucUwuAcoy4P7vBPyGjRXi2me19Vf8OlY3E/PvnyAa
 7YNn9oSG8XCnlcpHl5EwgKofo+wYGqNjzG63QJVtJ1KP5ekVlEJFyfIBcq01oePp6e6s
 VXzWDVNhyFdxa+FLRS0PFbK1yCKviDjiM61kGgVvJF/8D1LXWvPp+UAomqEXmw9CHwuZ
 68P/vhXcQvOdpDINXwSzAslCXaV2vTKEZmqNg8hRQw6HuNK/nIoyxle1yTvVXRKpBIJP
 DwwrIb+UsmhTwMKhc1wodOonhSeQzpPCGtaIOwuGBS+l7YaiDLkQNWXBK0NAKsNQ8bbi
 zJnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778064024; x=1778668824;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XwnbU1XrvbTkLWWCdQ77T+igmAlaNPY7vJV61myV5Js=;
 b=AvyTAABa6YG4ZfsVALYT7rskxDGATcfjk0Xecrezfxe4lEnpb1sq9gFp1uZSbUY3m8
 Enltt3nLYVhlcTUD+u97ZQ+Xva0GFqLsHpYoBLKncMryK/IJUZn1u0IhyAeYNWfok3VN
 DdCAqO0Pc35aAfrddmJmXymaa+Xhh2gzQ5ud2uwP4jzbL3Jy7aDWCo91jfl6qDSbY5Mw
 xl2OxgOWBVZj5leOH0p5G5ItWpKD+CwgHjFFM6zyOSj4gy2vAZmoPbhLJwcsVx3uLbkq
 jubEmn+oGr9v0CbWAvlU5JVSswK4OFB/e4s7NPtxhXItHmmMPZS4JWhhAOSsKTYs1JTt
 wLRg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+RuZu98D3lPm1K6THkK1vsIBpTF5W43AG/JLfFYeWEYl7lBHEj/HFgsWcYJsStV//V7oO63lEtUZYR@nongnu.org
X-Gm-Message-State: AOJu0YwiEJv1htjErHqstqlidksCQYmDvfN6sA+R2ci7wuG+4gCwyknQ
 ciNZ9DjyYGNCFBtNemsj3sDoAs/mhM8VK8RLfl4VrCv9UaN7k3ogfTR1Q5WFwu9DkCo=
X-Gm-Gg: AeBDiet2CmBDYVuBXnsN3HRyqkU592kpyPvXKYPQ+pUhJ8ozVeF8xXgq0rKtQfbc0TK
 X+HsDtTSVAsIwpKo8uGN7GQAKvlUB7+LWLBNnml1T0vJAVZq9X/0YL213+yflnfe0uLFI0I6BU6
 swtdHCFjURYBrLClMFlraOD0/KIk6D2GuBTL3fhJXLkHrDWr8DDu9XzyU8usXCvMEFW8s3jPj3H
 WGHmnMoKzN2IXlCPvEHdXJs0Y5qKUEKAAqVkgPrj7ZcAf/uruKgpcqP7A5ILxRtswl82qVgwhxB
 Y7Jd7PR1GAw+tTbsS2e+u9Be0Y/sbpN4u3hTtnj2MGypxcPmUOmQYL4AYn47u6A07Knsgx/f75p
 9c5vxblR9+H0KMySemIE0Ya25AtNSrugYcICsTXb229TGSHsbtSfGyhEbtYx75sl0QzkPGmhZd3
 +Il90DROeSrJQzRENoHGnJui4FdPP9fLknhN9hHf7oeOq9Q4KFwmJd++klGw+rYTZpnwrFlojDz
 Tvt
X-Received: by 2002:a05:600c:4e0c:b0:48a:54a6:b29f with SMTP id
 5b1f17b1804b1-48e51f2f793mr51542305e9.17.1778064024337; 
 Wed, 06 May 2026 03:40:24 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5314bb21sm14400585e9.29.2026.05.06.03.40.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2026 03:40:23 -0700 (PDT)
Message-ID: <e8c8b0f9-dc74-45f6-b75c-bd17e85e0107@linaro.org>
Date: Wed, 6 May 2026 12:40:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts/checkpatch: Reject another license boilerplate
 pattern
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?B?TWF0ecOhxaEgQm9iZWs=?= <matyas.bobek@gmail.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260414135018.13585-1-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260414135018.13585-1-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 14/4/26 15:50, Bernhard Beschow wrote:
> The pattern us used 56 times in QEMU.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   scripts/checkpatch.pl | 1 +
>   1 file changed, 1 insertion(+)

Patch queued, thanks.

