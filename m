Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F32D172A6
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Feb 2026 23:26:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmgpY-0002fy-Cn; Sun, 01 Feb 2026 18:26:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmgpW-0002eE-6s
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 18:26:10 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmgpU-0001hd-4k
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 18:26:09 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4806fbc6bf3so41199885e9.2
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 15:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769988366; x=1770593166; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KQprS2H4Q1wQvhhsPhaxMricfFtGhaA1irr5Zr3RBAg=;
 b=Qpa/Fw1KUREZs3o+iKXB8rvW/ku41TbqItyk3gp3/wlpZe4VxGWb1moBQjPTjm6vPf
 K4mcN7npZ3dFqhNcZFYXtXLgPdrKWyhG5Pe3Ezw28CrjMxGiCKpMs+HM8eHsHWCfAR4r
 cIaelYPrC4MMc+3gfe5AFOVSuVnptpvUstlRiIbJwtHAPcrq6ttpnRTPiU0Rumqxoclp
 J5lKBKkCioRJbd/YqFnGAlh2lPI5Qm6F0HOIiEW/Nszvp/jvbxoBXhEVsT3h7SiN6Qv1
 XRODnCaA2vRXDcoUu3r/Rh2HxaFO1yOhAoqid3EnVU3VDUv9XTdRb6h8OCBWlgb0SfAR
 dRxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769988366; x=1770593166;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KQprS2H4Q1wQvhhsPhaxMricfFtGhaA1irr5Zr3RBAg=;
 b=hEDMwtJwDKX0gsr3QFG26AHQiOZuryfkTwO8GdQbphAqS+OGb8iDuh/uE1cPkw8+DW
 inrWL5ir6Lt0XWErtpQQw54VuSiZ2uvOyxj9FFhzEp9toxDsnrXQZPzUG4QU2dEQwZVh
 RrLi5i/m7hxwR0MTYe3yhneOvBS7MpKf3NpEXKEni2v13FcfCJbLeN38VDTQI+1glqk3
 MxkddyId4qygTFYew1pLVsqkUp/uWRzprovosmerBXierylO6UyFrQXbMF/B/RAcpnU2
 OxOxpdtB1ZJ4dfjFQ+vaB3CXb36bQtfmXmXPG0F1aa8L+NNk35DDr2bfVD+170FwWoWt
 ZusA==
X-Gm-Message-State: AOJu0YyNfZ5nXAzvRrPnfa9ijmMe2KEKDyFxWM6sz6PCQANJulUFA9xh
 UPSxZZcnYwcZ7bwH8+6qyRFfUVj7Oi5gABvfZ4vxxCIgdJ3+3SVueWqHSAgLRgOLfIop1PQoaRr
 7JIO4yLk=
X-Gm-Gg: AZuq6aKvQo5bdnWWr5C6/MTMpdBIeTo9gR/JmfLA+hRh1n4gAX3ggjhNOq9lVb5ZQoQ
 ZRWkgSvDHE3iafWRtxNDKmKnH3WeQRFW9O7KJv0cDK2BUeiioPh3GCaoirGB/hQDizh+zOb/CBI
 TGQajppy9YC1kGGD0iTNqdSOLQ4V7t9HNhmIm4jPV0vbbiaP3Q2BailjCX3OE8A8EyS3KkOY/Ku
 h0s/jVMlorapB2a+ZSkgZF0cQPlIANHFnXIBxSDyKztgechiGPGETfTP8/TtKW5NhiJYD+KGcF/
 /Y8t8Jl/RAb4g/1WGQrazjZ3G3qBzYEdzznyV8caWjpQ+12X0uVcgiTiydOHRuyI1z3MQOWqZH8
 HhD7QbKlsKUoB/oLxkNZjmzQKeK7TLD7vQutjjxibUCSCRQ6mb5Jte1wzdBZA6qhH3D9j0/BqWs
 DL6uGLDCuI6BHU2a5cLar8AkNZNTOdURaOijAbi40205syXSXS7dj4/A==
X-Received: by 2002:a05:600c:8b31:b0:47e:e78a:c832 with SMTP id
 5b1f17b1804b1-482db4b692dmr113877965e9.37.1769988365955; 
 Sun, 01 Feb 2026 15:26:05 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806ce564f9sm372574115e9.14.2026.02.01.15.26.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Feb 2026 15:26:05 -0800 (PST)
Message-ID: <34912376-c728-40c2-beae-1cabf28f19bb@linaro.org>
Date: Mon, 2 Feb 2026 00:26:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/10] hw/virtio/vhost-user: make compilation unit
 common
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>
References: <20260201231959.88559-1-philmd@linaro.org>
 <20260201231959.88559-9-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260201231959.88559-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 2/2/26 00:19, Philippe Mathieu-Daudé wrote:
> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> PPC architectures use a custom value for VHOST_USER_MAX_RAM_SLOTS (32
> instead of 512).
> 
> vhost_user struct and several functions use VHOST_USER_MAX_RAM_SLOTS to
> define stack allocated buffers. To avoid changing all functions to use
> heap allocated buffers, we keep this max, and simply add a
> target_base_ppc() conditional for the single place where size really
> matters.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/virtio/vhost-user.c | 11 ++++-------
>   hw/virtio/meson.build  |  3 +--
>   2 files changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 63fa9a1b4b1..c8a004c6d2d 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -44,13 +44,8 @@
>   #define VHOST_USER_F_PROTOCOL_FEATURES 30
>   #define VHOST_USER_BACKEND_MAX_FDS     8
>   
> -#if defined(TARGET_PPC) || defined(TARGET_PPC64)
> -#include "hw/ppc/spapr.h"
> -#define VHOST_USER_MAX_RAM_SLOTS SPAPR_MAX_RAM_SLOTS
> -
> -#else
> +#include "hw/ppc/spapr_common.h"
>   #define VHOST_USER_MAX_RAM_SLOTS 512
> -#endif

Since I didn't picked the correct branch base when posting with
git-publish, I neglected to include this patch:
https://lore.kernel.org/qemu-devel/20260131020100.1115203-4-pierrick.bouvier@linaro.org/

