Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 869D5ECD999
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 20:32:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo61J-0002YM-W7; Thu, 05 Feb 2026 15:32:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vo61H-0002Y7-Sa
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 15:32:07 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vo61G-0001Nd-Ab
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 15:32:07 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4806cc07ce7so13103975e9.1
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 12:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770323524; x=1770928324; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NRlOgARc68YgEQy92s/UJv4/TgC6vu+iZ7Sy0UquqE4=;
 b=kENZIOO1TH9O1SFjChQqz1pW61PNlGOn97EjCvyq9UUOTiQBvFAEPfUIEB+qEQ0jOz
 3zzkJC3ngOzVmTqdaGhT6QRQBBLQUZojv5M2/Gj73JJLdL1GOTGK/yrAHoNnibFx1yEP
 OF/+k4OAB/MJj0KSKEbFPtO/Vd1m7d6YRRhXApPa3BNiHeTmMKfJ+RxxaLeQMieBCdCo
 KNZJXX0tVNN5gxE9GMl05C6ekTAEAvcDNDkiNk+Sz7JRgVME1cvrjjqJfujFUMjy3QXq
 3f/aeSWWZ0eix1Ig9jEKmw/DsKmshxV0dm/UzJGOQHzqY9R3zQ1PyfO8mhSorVeWwjUe
 ddUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770323524; x=1770928324;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NRlOgARc68YgEQy92s/UJv4/TgC6vu+iZ7Sy0UquqE4=;
 b=fJuxtt/xQfTmqhcxHISl3/KLbc1jF1kiRvsZTMmiDzXVbOtlSOTesjUPlMhlSOeiQ2
 vnVKJLGFlNYRqF0Ib1tQsEJH2JQGTe2BAAWHNSuZmPha4jUjFcIHPylf6RfNxOa2WLWo
 TqzN8sHnwoMprlPXB1Mx3PZjmJAemVbEbYOoWJ/Gs0JhNxUM/GCrRVah0rTmc1rHM94D
 J6xf5yvy4L10JZbQ3KzlgJIMyjdRQF5XVoXzi53QYcRzsxZNuQ8HlCg1MmJkXBmnTPqD
 YJBHh6gqueCEZY0mqgQJMvbdEe18FZfUwsxzzjpMoxK71cZHO7Z6qG/XboAJKJBbKnCF
 3wag==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUVIn9hpA+P/rhbyCArQrDbxY6C1HgTRH5cLjdkHjjCWKtATFuzUHwMMEx7drixVRhn1UItrHV2+9i@nongnu.org
X-Gm-Message-State: AOJu0YybF0OcPpQ3WRYYIad5yJnhQP4+ISFBmKA+80EuroMCJcamJnr4
 P9I6tMNyCzlJgCiwR14t/qpVScOnWKLYaW9zN4fZuxIHq618raTLS2xyCdM0Q715Uqw=
X-Gm-Gg: AZuq6aICUhttLnNQa7sBxh7rMHgEJV86i0uATMhSlGlEt/rcN5u4b11i+J34EMYEWKb
 XELOt+t5cuEGsqifg/r4szsi9wT1e4TbRMlDrfQnzlR4OaQeGNtPUedfBS5ONPz46RWdAi+60vj
 0TuT2nj7n0jNgU03hA+24zjzl/+Sn4ckdGMw579Fho8brAn3xfjqCKlgyg5EQkLv/u1PxBHchez
 SttAf5qUM5BUcRsxA2QPKl9RWVhoPS5HHmpmV5ZVzin4iyfaKoRtgo2N7rw+QGAXrwUsH7JfU+R
 /zFSkIbJ7XTZVddcLO30k8xru9+Im7dNpmSq0lkIyKUqbMAaFGF9zUb8XWlMf0s425ZBBvgSf2V
 bFKUpuCmnymMdKsxeC+/g51y+Ug1diIYVNOviUmqDwEXWSd4zBzGOrdWwzH0hkcvNSTE8YbgytX
 yLq+Ge9qlxdusC0LXN+lVndyFMnw4yNnvOTcefRthR4FDvSPRzB4OVaw==
X-Received: by 2002:a05:600c:4f8a:b0:480:3230:6c9b with SMTP id
 5b1f17b1804b1-483201dd004mr9123145e9.7.1770323524349; 
 Thu, 05 Feb 2026 12:32:04 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48320736953sm3706755e9.15.2026.02.05.12.32.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Feb 2026 12:32:03 -0800 (PST)
Message-ID: <14d9bde9-938c-4eda-aeab-5e3c863b17a1@linaro.org>
Date: Thu, 5 Feb 2026 21:32:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/24] bsd-user: FreeBSD needs this too, so drop linux
 ifdef
Content-Language: en-US
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>
References: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
 <20260205-bsd-user-claude-v1-2-8d8ff0035372@bsdimp.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260205-bsd-user-claude-v1-2-8d8ff0035372@bsdimp.com>
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

On 5/2/26 18:26, Warner Losh wrote:
> This is more of a toolchain than an OS issue, and all the toolchains are
> headed to requiring this. There's nothing Linux specific about it.
> 
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>   common-user/safe-syscall.S | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

