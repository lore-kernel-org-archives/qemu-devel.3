Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E62ECF3C245
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 12:38:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzZrw-0005NF-HZ; Mon, 09 Mar 2026 08:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzZrv-0005Ko-5F
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 08:37:55 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzZrt-0003Gm-9w
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 08:37:54 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4852e9ca034so18292725e9.2
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 05:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773059871; x=1773664671; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SE+6UstLJtJyb+N6KxFuZm2jwFxo46JYvru2YY+1jrw=;
 b=qY/ViahlyQ2qUV4X1rA9VV3dJ3zXc09vXMAfzLnsJ631M0IcUyAQMCow5KWpuzPfCK
 VpW+RNTadA7/FfJCIkw2IfyXII8wHhAFHrhIn5pys1n9HZrcpZztHKKIehphQVe6mu1M
 JhYxl9UOtKA1zVY5+rlIIzXyTMSfWoAGabw5LbIICR/J0gVapc1fRycZoixwkSi6JV8I
 cM3gGpDFFTkbSXC1hj6t4kaJnTLmXFMy4HRZVAKzCJInjI8PtyZRTDswdcWBD20FhMrk
 qSlsDup5PQ5VsFwIJvJtTGvJ6o8git4pG9gLN/u0jnKbKyKzBPajWA7Rbkk6jMJuowRO
 bHhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773059871; x=1773664671;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SE+6UstLJtJyb+N6KxFuZm2jwFxo46JYvru2YY+1jrw=;
 b=BOmv8KkZWWflgqXE5UQAzE/Py7/wxOuumMKUvRTVX4C8Tq80zYkejsZ+/V0HCMcsDz
 nFx+nunSjDWR8s75m8DIYuI/L5F7a2xQEhSlvSskfEroCbuJgoIyUsqF6m0Dq8Xm8AGE
 2e8/6qiMdxkPjlQVD0YElnB4k9kwIFRb2n1C07kpb7ZWMNdSEMj0c4bC5gepjg4G8Mr9
 xbLFZmk4let7uzTJw9+tVAq+9h23sO9aKvds7wMmWzNTRwWMoq9wFyGVE2q/+8z6DUUK
 AurGl3thtr1AOQ5KFARV0iZnt7CAc0M/xHwi769Hr6oM+vkQajFLBGKcQRLIJy7X80zq
 oMgg==
X-Gm-Message-State: AOJu0YwYtrokknyrP92htUAznM7CNxlg5NFdmVBcqlqw60BVBPQyO385
 MER/Fv8XsKk/ldj25jXVuK4AlEGYBdbSPWJfyd1auSMuUnsfW+6k/XrVuEVBKQvegY7NZYsdliT
 M7Dg79NI=
X-Gm-Gg: ATEYQzxBmfGsnWatDkb1Kz95j6LdUrpLPUgke1gPxLWYmHxVbBFjXrjGFOR7fvANoyx
 0cU95smOWJTpNxb4NeEjNYYZQuq70NLd1KJw5s8F4aC0ig/wM/yNxi1AICcSJlnTE5vi83iQbeI
 6ANNtsqOv+3umGqcanQHQuIwmeFKoSi811KJ4JIyS5Eacft6pJ94hF6qVtbWTKcOF8VMJQB40f5
 8YO/BiteVHwbGHWKHdDHvZvZ9ZYECd1hRIfso0KC5oNQOExAmSqrG4ybx1OaCmakIMSURk3OcHs
 o0QF7ZLmGv3n7aR2JQcTMu3taBp0vLYnW2rjd8nCDo9y2kpE8AUsRd8EUtSltk2gUSlqoHPntsu
 7e9hiEMDmtKUDz04PRcKE7xfKf+VsuEf7T4s8oIEDCly394TDD84QK7g5b9fMcDsL2nzGQzvMaW
 Z29CxwLbyLeWBpswUlog7uH0lmZWkqBWmDC7ToIIqI3Fc4EUwjAU5z7xckV6OQsKINcA==
X-Received: by 2002:a05:600c:4e8e:b0:485:3abe:ab86 with SMTP id
 5b1f17b1804b1-4853abeac80mr57230375e9.4.1773059871442; 
 Mon, 09 Mar 2026 05:37:51 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae2b9ccsm25589879f8f.19.2026.03.09.05.37.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 05:37:50 -0700 (PDT)
Message-ID: <53077d7d-ebb9-486e-9ed9-acf196ffb536@linaro.org>
Date: Mon, 9 Mar 2026 13:37:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ui/cocoa: Do not automatically zoom for HiDPI
Content-Language: en-US
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20260304-zoom-v2-1-2eebf2b51106@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260304-zoom-v2-1-2eebf2b51106@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 4/3/26 07:39, Akihiko Odaki wrote:
> Cocoa automatically zooms for a HiDPI display like Retina and makes
> the display blurry. Revert the automatic zooming.
> 
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
> Changes in v2:
> - Rebased.
> - Link to v1: https://lore.kernel.org/r/20240318-zoom-v1-1-07ad14fcde19@daynix.com
> ---
>   ui/cocoa.m | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)

Merged as a3b23b946c85062ff6fbdcc3d1f10557715516e4, thanks.

