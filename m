Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BBEFFF5136
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:29:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABp7-000542-DT; Tue, 07 Apr 2026 15:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wABp5-00053Z-E5
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 15:10:51 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wABp3-0002pu-Tk
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 15:10:51 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-43d43e09de5so1026956f8f.1
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 12:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775589048; x=1776193848; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jFPy6WVYaU7Z55p4pD10cXcGpS15QLl7ZSOmbLKuJzs=;
 b=Y8PawVYWYsQIPvGY85KNDjHUW9G1eF0XIxwkYVaRKmYNo0z4ZDEWW/uPTGSZyrpB71
 AuVtebxh7XYbGOTnNYOyJMNy2hpns21DnKQf2FZWOLweAt7epDpqgt8utA2bMGpc8mIy
 4IMw6/idWvAozGj5CSsm/t9dhSIuTRCrf9Y8NNYgA7Uz+NE0jXq0j+6pGUPamaAlKNN5
 9rOz8UTvoEmQHu2HckJXP6c4K8aZx3jcA2ZwRdUKwg8AvnFZxhDQhqxHFIT2YGkGM+3C
 MLgjT8ilo3YC1OBM9CFKz0Y/7/NxP2rsYldzceb7KN+Mn+XKaxWQ0TvaQLfAuvi9u5pJ
 iUWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775589048; x=1776193848;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jFPy6WVYaU7Z55p4pD10cXcGpS15QLl7ZSOmbLKuJzs=;
 b=cXPqzKJZdAPtDGyyvKgO9LYrlWKE6/VOHjvmaSvMNooX2zgW9iE3hJTZEaT+NnMNVm
 BD0Jgfh4Kxi076pNCZ+q+yW31xiXUVyhC1Ale4oneptrDAn5EOpk+0jbZsu59zolJexY
 Txj4yZ6cZKQCO933AV7ecRgYdd6WHkHP9/Erl+rBsBVOxV/XbkBwsaYSv46l7Ut1clTi
 IH7xgMmifmeKQ4hdsPcB7rDwXMWHrTMRRY+m5bpowV6KByTkMO5drquCRwPwJQu3LkXy
 +yBL4CRknNgxgWqbRLMW1Ef+HsfomkoDzXpPr/dEwKJ7irsV9EExtuNGedhWNsUMZ2Vd
 RKVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3CSXg7gz93RYF5Xq+A/c/m2rGUI6pSgzUS9oPtdnhJcHjIN/vV8Q30FmgO4vVuzANTVo5U0rB27Ml@nongnu.org
X-Gm-Message-State: AOJu0YwfQ0S68WerMYXo1JVgTiR3wUjrECFSP1umiXmtbbXLTKCEjG7J
 chKZsdoCBREFxC/49GiJJaoEwG80raOhBvP+SXFQLMb5sIdsFggmMp6DLZUq6RxgVZ0=
X-Gm-Gg: AeBDiesFdLye1cp1jMnKYVEvOJ8d3XEpYzrgG6sX9BsBcxaFyWFYpkRS1wM1z/jNxlF
 qqjLzXXhk0bj5KmFLdW9mRf/Q0cErFvNnI4UEmGdXDuMtKjYiyrnNzjFY57Yk7iRPRrwda6pKou
 0qu6rNPdLq6/YCfwTuNbrLfyiCkSn5GdcBZcF9K7SwU0ct7IKcsEWDvNqyQoY2Uje4DAtIW/UPz
 bzxJIMsax5Clhwubb8pfAnk1YI25g1HucFozPSZ76pbgdZrUC5Yvkv1XRGcIxscLjH8R1t3zZrT
 hHjsjxlDc27k/sIDShOe/TD4x/f20yngpPTkdGTm3iEhbiXzZopy2n05qUGhTQ2qO0naVlveHsE
 QJ3QNUk2u1mkvc/T44uVdpBJ+G3yjTp/bbWiiLDeCS6dxLiRsga080i3B3uudksSeCx8icSpLHn
 wz7JZNUkb7WQXDsvHpCwYHsfRsOEFp/zwJr3WMyrlqfgBJKk0837ydP3nV7IBcKcjQbQ==
X-Received: by 2002:a05:6000:40dd:b0:43b:8858:1146 with SMTP id
 ffacd0b85a97d-43d292e7fd9mr28910677f8f.41.1775589048282; 
 Tue, 07 Apr 2026 12:10:48 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e2c60a2sm50512253f8f.10.2026.04.07.12.10.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 12:10:47 -0700 (PDT)
Message-ID: <cefb8e7a-4fc3-4f04-8cc8-85ccae7c6de5@linaro.org>
Date: Tue, 7 Apr 2026 21:10:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 10/20] target/arm/tcg/gengvec.c: make compilation unit
 common
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, jim.macarthur@linaro.org,
 qemu-arm@nongnu.org
References: <20260407022748.57629-1-pierrick.bouvier@linaro.org>
 <20260407022748.57629-11-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260407022748.57629-11-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/4/26 04:27, Pierrick Bouvier wrote:
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/meson.build | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
> index 1fa26670587..0740de92c1a 100644
> --- a/target/arm/tcg/meson.build
> +++ b/target/arm/tcg/meson.build
> @@ -33,7 +33,6 @@ arm_ss.add(when: 'TARGET_AARCH64', if_false: files('stubs32.c'))
>   
>   arm_ss.add(files(
>     'cpu32.c',
> -  'gengvec.c',
>     'translate.c',
>     'm_helper.c',
>     'mve_helper.c',
> @@ -72,6 +71,7 @@ arm_common_system_ss.add(
>     'cpregs-at.c',
>     'debug.c',
>     'hflags.c',
> +  'gengvec.c',
>     'neon_helper.c',
>     'op_helper.c',
>     'psci.c',
> @@ -91,6 +91,7 @@ arm_user_ss.add(
>     vfp_d,
>     files(
>     'debug.c',
> +  'gengvec.c',
>     'hflags.c',
>     'neon_helper.c',
>     'op_helper.c',


