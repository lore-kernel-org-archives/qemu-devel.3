Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB4BCEE34B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 19:04:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLR04-0006kN-6T; Tue, 18 Nov 2025 14:04:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLQzn-0006bf-JW
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 14:04:08 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLQzk-0006Dq-Lq
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 14:04:05 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4779ce2a624so28805465e9.2
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 11:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763492643; x=1764097443; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l5PQpR9+fCb5QTlpH7pH/lcBhhjMeu8QLHVZx3g7dOQ=;
 b=o+VPClwSFkLbm8KmYeEa2HjQdtmjNDTYfjN3uqlsRp4zdtZz5SnWV/5qKL+RjDlNm0
 Iz43Pr+MZeYlds/QDKq9DnPrqtw3Bwig4S1An65lKTgHL51O0B2JoURVIiy4mMh8NMGx
 hJ+PE6os9MEJV4e5ErhJ/dqJa/MjTUtuQwxtBw5wEJc/DSwPhkvFY7B+Cr0kmrv0DOs7
 JizRfCUpWy59liR3ZNU3nkTOuaM7ybSWzcDR4r/OVGEv7XOph5GjOpJ+tdie9ESvw4Cc
 AbIrB9QjRiB76/4dbn26Gx3BNbFhgs3CNWU9lMqeRibxRHY19UwpblTHRijm4BxJiDEr
 iD1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763492643; x=1764097443;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l5PQpR9+fCb5QTlpH7pH/lcBhhjMeu8QLHVZx3g7dOQ=;
 b=V/QzdZCOiLpl8SbicPf5AlAsk9L+CcDI+/CdOCBHzPFjXOYyrFFjjIWXUg/BAci/k8
 Xf9COgGt1FuUnfJ4QIW2QcfTLR4tfXEOgumhhwI6oNlUowZCMvXcS1nCqtceGL+4qEnR
 01sILgm6gqRu7Tcd6XkNO4gMVU7Gc7bOLzLctII0bA/Yf17gXW1t64T3IDkbGjeb98LT
 SEQUTX2PUTdpXPMCYH8gdX7GBjlxj/W96GI1hWzwEe9CwV2iGrdSEO+QzSbcnu41kwSq
 AmaEqvm8H4ggmKo6uG1p2CEGIYeVuYH/M7STAcHDWRz2Z3LK/bLmrLEl20Ks6cbRj/oe
 itYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3Vaa9XO6N37WlF9v0lQVfriIAmeBf8nviZAoW8EpCGI9p1cn1rcOph1SPM8FKOIDKGAXGR7RzwAre@nongnu.org
X-Gm-Message-State: AOJu0YwoCwp8YfjFviiDAbExrT7mm0GILMJHaY8ELQrN6voph8UDJGlN
 ZFEjgoY+s8TIrAtJwxNwl2UzmoJt1he+YmYK7ulCEbqX8Vvh+Ki0K0mLxrGPsYCTSEo=
X-Gm-Gg: ASbGncsSs0v+U/TEIrw8f0xdBiXVMXy+rwkR4leQ7IRSbm3BE2m4GkY0YXuw8z32v0P
 /bo98ECO1VKitl+8zz/k+CUdNFWWyfufcyUdKrVky7lOh0TQzFpyA/2oUpYXJbsPbsr9fuCcucg
 WbyEIwbo5CDizAzzCL/L/7GZ2vZT9xwJn/7X6z8JryGASAZemwPhvqAMGyUSApOalFlvoZ6XDiW
 5YjUSzRDATnWnM4stH74HK8pPb/wg2C2NSfym0qPeEwDf8MSerUxnoV+A7gDJ3pEZTYpITrU37/
 CZabkOlluEuL6JqZu/fET3dURpZ/cz4nOUzxWHMezsH7pihaPB7lr/qwRgZMX++VaAjxFZe4U2e
 lrEWuAPdyVlIPKQapph2a8Xr82D4VxkC+V3QIuSeojtGX5FRgp8rXAlQOiUK8cVnY4P5NqA1/9D
 lnEcLgP5hQNfTOUhBpajghOiWwlWLA4yZH19Cixf4GtR+9i7l5MZXBN2WjLgEbSII3
X-Google-Smtp-Source: AGHT+IEHa5Doq4n3GSWAFiqTGRJFEu0hmI3Bw45P873LOTiGF3HnAwfCgANCpFoBSbUxLceUnSHtkw==
X-Received: by 2002:a05:600c:4f93:b0:477:5c58:3d42 with SMTP id
 5b1f17b1804b1-4778fe588a9mr166115765e9.10.1763492643035; 
 Tue, 18 Nov 2025 11:04:03 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477b0ffe377sm5552285e9.1.2025.11.18.11.04.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Nov 2025 11:04:02 -0800 (PST)
Message-ID: <e6742abd-b4f7-42de-ae39-c3e8e8be7047@linaro.org>
Date: Tue, 18 Nov 2025 20:04:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/sd: Remove unused header includes in ssi-sd.c
Content-Language: en-US
To: Bin Meng <bmeng.cn@gmail.com>, QEMU <qemu-devel@nongnu.org>
References: <20251110104311.1640772-1-bmeng.cn@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251110104311.1640772-1-bmeng.cn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 10/11/25 11:43, Bin Meng wrote:
> Remove these header files which are not used by ssi-sd.c
> 
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> 
> ---
> 
>   hw/sd/ssi-sd.c | 4 ----
>   1 file changed, 4 deletions(-)

Queued, thanks.

