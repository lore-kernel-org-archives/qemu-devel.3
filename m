Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81748D6CFA2
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 19:50:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vj0gC-0007Hf-Nr; Thu, 22 Jan 2026 14:49:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vj0gA-0006yR-H8
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 14:49:18 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vj0g9-0005GW-0V
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 14:49:18 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47ee76e8656so18941475e9.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 11:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769111354; x=1769716154; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F2vNUwkEprWfk4ctU32pIZ3YEqWC6WP80tYmhsHPdBo=;
 b=tjw7kJDQNMaxAAh1LPKw3LFtFw3RAMjsMr44JGQE9UmS+CZM3AbUKJlKRjZZwyMrPz
 7dirX3aLeeDKxY5YIXUf4hcSiP1Ge+FXtBAvsuh3g20Gh4q81msysegctVhBj9gvCjOx
 C6Rp4XDBoeDajaPcKWEy4+C77S6YFl197QLeCqVjFuUUngu926NGFoKnPbJr4R0Twp83
 eaE0PuqrO9ua90PBNn3CUFTTh3VOGj94E6r03pd8JmKT7jtvV/cZLR2pn8kUdL7CxPWx
 qEzFGyXUPUfWU0UwoO67zsHuix633KhMk18djSiaUeIw+3LoT9ZKP0efGxjWMrDpM/Ml
 ekrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769111354; x=1769716154;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F2vNUwkEprWfk4ctU32pIZ3YEqWC6WP80tYmhsHPdBo=;
 b=UYuTFXxw1WXyA+A1RZczEqWhECVq8q2RvTemMd7/pe/hYJmbJuZd9ISthAVLzR2XAp
 kcLqA2BUXuAWzQDRd6mztsAAWlYNccPXTrK8kAZuHt5WYkVn4rVC8Sg38jRWFoFjd8i3
 HzE8Ei3Bdnli6dd6AB9zcEG7scqqujUwVrDQ6l4vO75vYskBr3GuC/4vKuSayuCiIiPD
 ED2vjZ1A1ATrQNV4vuGBOX/WUwLd4RQJ4rashdNvgLL3IMjycdc/b5v8XOVaEMcN/z5i
 sL8pYmCAGDVZ8JEv5kp42ABzBk8EMXE6RL5wKGlWZz2/8tJJhJenm1nPPoqiQrRyB63Y
 ziVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUal8y6G0eep6u5jl383SLqwz80BBfj6oDLyIKQ5zI5jq8Y9ycHRVn5nlnFUbk4FvItpGNdx5ULNkfo@nongnu.org
X-Gm-Message-State: AOJu0YyX+OYLCd6+D1JbYADNiAcM6bgmdOojupzYGfzjd2mjwTxk443K
 gSthFWc5VGw0QQZXXt4+7FQoqlQvzz1BvyYaMB/khOiJQbq0wD+LO7P45PKXcQ7NfmI=
X-Gm-Gg: AZuq6aJntpCDNc7g4XvnXb16QLSzHpMwqUdZDCwzsA3JPQchGBgYs3ijgdgqvuaJBDQ
 WWBsa2YfGGuy9vq0KVtVxpdzCW9lS6COvQoIUlbcoiiKgTcrUoVGgs4tInSdr0PxHyHRtxia78R
 31YqSk51VkI9TTAfU608jeJGVVYcsZ7uoDe5DQeP9iNVER5fwGMIhEOMVbZDkvpdDYk1WSfVoWy
 PbEeiD6uecfY/RoSMYHQzfNXPI984QvhCXqwpRPw9xhdBepsskquvpGFpOgonWqO9toORE5x8Ny
 Ps1WEWOxHhqBpgKP+gcSh3cZL++HKaVQMqdjojou5YE1co+Vk7coBz3yfbKgGq0qZyFOvo0YTVe
 hwH6hUlJopxhSV/+rzydsCv/vIfB8/dssArT9Uy/SUcFcuTjAlY7gbgNTHDsKfWN26lqhBW8+Qn
 G2V65e7lQ1cXJ12Y0UKOKKD4ZE4QXT57Xv++YkBbYqUoVgDV/ykzZykg==
X-Received: by 2002:a05:600c:8b04:b0:480:4a90:1af2 with SMTP id
 5b1f17b1804b1-4804c9d0102mr14624075e9.35.1769111354273; 
 Thu, 22 Jan 2026 11:49:14 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804703b59esm90736125e9.4.2026.01.22.11.49.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jan 2026 11:49:13 -0800 (PST)
Message-ID: <af2bfed2-de7f-41aa-a8b0-5c20b4d9f826@linaro.org>
Date: Thu, 22 Jan 2026 20:49:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/4] hw/arm/virt: new "msi" property
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260120180339.1416328-1-peter.maydell@linaro.org>
 <20260120180339.1416328-5-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260120180339.1416328-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 20/1/26 19:03, Peter Maydell wrote:
> The virt board currently only supports either a GICv2 with a possible
> GICv2m for handling MSI interrupts, or else a GICv3 with a possible
> ITS for handling MSI interrupts.  There is one board property, which
> lets you say "its=(off|on)" and controls only whether there is an ITS
> or not.
> 
> This is awkward for macOS HVF, where you get a GICv3
> without ITS and MSI handling needs a GICv2m.
> 
> Create a new board property "msi" which gives the user clearer
> control over how MSI interrupts are handled:
> 
>   - msi=its : create an ITS
>   - msi=gicv2m : create a GICv2m
>   - msi=off : do not create any MSI handling device
>   - msi=auto : create the best MSI handling device available
>                for the GIC version and accelerator
> 
> The default is 'auto'.
> 
> The existing 'its' property becomes a deprecated property
> kept for compatibility. Existing users of "its=on" should
> prefer "msi=auto"; users of "its=off" should use "msi=off".
> 
> The backwards compatibility cases we need to support are:
>   (1) TCG, virt-6.1 and earlier: no_tcg_its is set
>     -- you can have a gicv2 (always with a gicv2m)
>     -- if you specify gic-version=3 you get a GICv3 without ITS
>   (2) TCG, virt-6.2 and later:
>     -- gic-version=2 still has gicv2m
>     -- gic-version=3 by default gives you an ITS; if you also
>        say its=off you get GICv3 with no ITS
>     -- there is no case where we provide a GICv3 and are
>        unable to provide an ITS for it
>   (3) KVM (any version):
>     -- gic-version=2 has a gicv2m
>     -- gic-version=3 gives you an ITS by default; its=off
>        will remove it
>     -- there is no case where we provide a GICv3 and are
>        unable to provide an ITS for it
>   (4) HVF:
>     -- only gic-version=2 works, you get a gicv2m

Thanks for this verbose enumeration. I suppose you started writting
that down before your first line of code :)

> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   docs/system/arm/virt.rst | 21 ++++++++++++-
>   hw/arm/virt.c            | 64 +++++++++++++++++++++++++++++++++++++++-
>   include/hw/arm/virt.h    |  1 +
>   3 files changed, 84 insertions(+), 2 deletions(-)


> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index b65f571532..471852e4b1 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c


> @@ -3454,7 +3507,13 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
>                                      virt_set_its);
>       object_class_property_set_description(oc, "its",
>                                             "Set on/off to enable/disable "
> -                                          "ITS instantiation");
> +                                          "ITS instantiation. Deprecated; "
> +                                          "use the msi option instead");

"use the msi= option instead"

> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 577b4b3362..53f1dc2199 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -103,6 +103,7 @@ typedef enum VirtMSIControllerType {
>       VIRT_MSI_CTRL_NONE,
>       VIRT_MSI_CTRL_GICV2M,
>       VIRT_MSI_CTRL_ITS,
> +    VIRT_MSI_CTRL_NOSEL,
>   } VirtMSIControllerType;

Pre-existing, no need to expose these, we should restrict to virt.c.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


