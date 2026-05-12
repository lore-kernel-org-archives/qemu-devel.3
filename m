Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E9CCD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 18:08:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMrVu-00052G-9D; Tue, 12 May 2026 14:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMrVs-000524-1w
 for qemu-devel@nongnu.org; Tue, 12 May 2026 14:07:24 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMrVp-0007Ef-9Z
 for qemu-devel@nongnu.org; Tue, 12 May 2026 14:07:23 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4891c0620bcso41505965e9.1
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 11:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778609239; x=1779214039; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rbOFuFxP8WbhsSvwRRvkcHK0EP3UCaNJINhXLrzrhtA=;
 b=lvlCxLJfUPLlhvyu6Z4Reml3jWHbu4TrAX9o88bckNXiGyguvv3F7rTMLUkkxs5kAK
 TAazyMMTjLlFyLHbBgdKbTceYygBNjt+6JlRHujq40Nn26Y4uD9L9fGaSObo4+ITFKdi
 2UZAcidP0RFCFpuGxXvlYW6/zHtGiA+T7kOfaCvZmdcObM4PgnPzzrOAAo6l0ZA6v4sN
 po5NlVdVbIICsAzmGedIVRsHBLyKvxR3pUM258+GaVnj6FvoA5in3Mkgghgwp9Qp/TQj
 rm9vHCHO8hQoFlxinlTVz4YE6OjjxB7aHROGAuXMVOrGe4o9kXrOTsXYoBHX3mm2ugp6
 oMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778609239; x=1779214039;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rbOFuFxP8WbhsSvwRRvkcHK0EP3UCaNJINhXLrzrhtA=;
 b=pe2zyBFn3cVdkPOI8QBpq7VBX3Xt4L4pQRRIHEWvzPjzh9Dj6OIJCFMVtr6Bvsuxni
 wh9sZhuk91Y9D6mDbbzJ4wNpoAE7AMK9G513SHa+yddFKE/84CfZNuMRqkpjWfr+9m6T
 9nf16/3JiQLWOi3G9ROUNvl6V7lvZdTeEAwqtii+6Kj29vuvVAaE8KJajbldBeaCLC/n
 +OaP5OWnEKiep7WmH5o+kcr1ToJ3GlV3vs6np+xTsG0VXG+DpLb3Gr44eGieJE2HKqkA
 4iDKs0QoMALYO+JpvafhiscgK7mD0u3OVg/UnHFBp1/dqnk3f2tLEGTb40UzlrKxBV3X
 RDig==
X-Forwarded-Encrypted: i=1;
 AFNElJ+vrQwcGz+E7Cu3Ugtl6Iyvr6/9moPI/qyfc8fFFfWwQJQZ7PlPvD0Uro+NeFwUUG/p6E4TaBR4dSXV@nongnu.org
X-Gm-Message-State: AOJu0Yw9NByO4qTxoMO9YH92fcssqy7pOTmflbDajvb2u1r+Mump+46l
 hC5CmKq89WVZKAfPEeR2+61zIBYHI2RO5qCzxqwityn46Co1KJe2mVx97Yu+WP5LV84=
X-Gm-Gg: Acq92OE0rN+6Qe+1OYCCxneQG/GUR0WRagtZXaM5sqqXvYnbn06l7N+JqACSpl6LyyC
 4yeBgeUYfWQApyFNm9CAdBTLkA9urXhp4AN+rNAtElZixgLfYDBBrNvvqBbzoR/W+Ec51texBrn
 u2PgMMPjcM7DoJLIBIvCA66T5QXnIuL1+N272rgyAz8TJYs4sfP+100or/5RkddVyWfdbQ8WcAl
 olUkezjPZcqsT3K7EC7j+W4UQJLGV+JAX1ggYuNWKlbBlYpnVXxmFx38d1HrqNSK9wJ5fhY7S+n
 +V90ZhZBvTKFUPty8Z02RNushqafE5GcOsU54Ylzgcn5XInAzwDv1W9xe8zTh1uUhRU3YzcX03A
 y+rDK+FoLUjchH/QDmfNC/ItdsDLu3nMlx68fH0wsj4KvFMwTAPYhFwYUbDC3wSaLuF2nxJNG7C
 0h5csCWIBmHj1K8jtFjawBVw9XCO4a5NlQcNfnqqtdk5O/YCZyBCOX0FagKx22zIkG+g==
X-Received: by 2002:a05:600c:350a:b0:48a:5565:ec3d with SMTP id
 5b1f17b1804b1-48e676ac38fmr311321095e9.22.1778609238555; 
 Tue, 12 May 2026 11:07:18 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fc8d15e09sm14389185e9.3.2026.05.12.11.07.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 11:07:17 -0700 (PDT)
Message-ID: <3d039c50-88f6-4599-967f-cdf9c0e944c2@linaro.org>
Date: Tue, 12 May 2026 20:07:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/5] target-info: introduce TargetInfo in QOM
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 marcandre.lureau@redhat.com, Markus Armbruster <armbru@redhat.com>,
 Anton Johansson <anjo@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260512150208.1167711-1-pierrick.bouvier@oss.qualcomm.com>
 <20260512150208.1167711-4-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260512150208.1167711-4-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 12/5/26 17:02, Pierrick Bouvier wrote:
> For the single-binary, we want to be able to retrieve at runtime the
> current target among the different ones available.
> A consequence is that we can't rely on existing target_info() definition
> since it will create a conflict once more than one target is available.
> 
> To solve this, we add TargetInfo in QOM, with this hierarchy.
> We define one class "target-info-X" per target, that inherits from
> abstract class "target-info". Using concrete vs abstract class ensure we
> can easily filter "target-info-X" from all QOM types.
> Associated TargetInfo is directly set through class initialization,
> without relying on any instance.
> 
> For user mode, we simply define target_info() like it was done
> previously. In this patch, we keep the same definition for system-mode
> also, and it will be replaced in next commits.
> 
> We will introduce detection of target from QOM, so we need to make sure
> those types are registered early.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   configs/targets/aarch64-softmmu.c |  6 ++--
>   configs/targets/arm-softmmu.c     |  6 ++--
>   include/qemu/module.h             |  1 +
>   include/qemu/target-info-init.h   | 58 +++++++++++++++++++++++++++++++
>   include/qemu/target-info-qom.h    | 28 +++++++++++++++
>   system/vl.c                       |  2 ++
>   target-info-qom.c                 | 24 +++++++++++++
>   target-info-stub.c                |  6 ++--
>   8 files changed, 119 insertions(+), 12 deletions(-)
>   create mode 100644 include/qemu/target-info-init.h
>   create mode 100644 include/qemu/target-info-qom.h

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

