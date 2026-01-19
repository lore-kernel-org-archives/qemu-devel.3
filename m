Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75901CCF2E0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 12:22:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhoGQ-0005dU-0n; Mon, 19 Jan 2026 07:21:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhoGK-0005bY-84
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 07:21:40 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhoGH-00038v-Ok
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 07:21:39 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47eddddcdcfso19582555e9.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 04:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768825296; x=1769430096; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kV71xEhQHf/cZb4fuDtl4xSNy/zYzrpI8vgqn6T1PzE=;
 b=kJF9onYLIOzJ3lxqqkRGtL//XmkAfxHycVR2IjsVTasnCRGEVipcb5NU4sDpA1FEzn
 Czjd17QlUr0JsXiL/dGKuhM2im5yv8ORRPgODpX2zL4UAwiy2XNA53YJ3NWMiKw2EaM+
 ZgcFuPi1ZU61dbNY53NX/qXJpSagPqoG4O8PGzJP6IdyUwYytnQTzSZ8i4pTfp04pDrd
 jfmpz84137PTXmMfvjZRepY13uL6fbCvrrTHsuRAyBXWNnkGZhT9w/6IIKP9PovbtvFy
 S1JqUEkX0Q8YdsVNMj0s5SnSUlSFmyYSUi57fAbkVr2i1Nzfsg6tAdjkg2NEyZLy/aHw
 Kgaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768825296; x=1769430096;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kV71xEhQHf/cZb4fuDtl4xSNy/zYzrpI8vgqn6T1PzE=;
 b=g+irKKji5sGJu1fyeSSiZwjulNlMX6tAUJIdpJkuEmZ6ZDouUCOox5541F35STiyGa
 zjgyCu4ag/VE0sxWX4th/TJwH31UnPySZVLymDoUUPzTib7f9u6r8Klz4Lo7rcG/jdlf
 bp9EidjVkSr3lm8aL0ZAocUc7IbYp6DS1/cfpo1FEZT/7w1CAOgxaOAoB7hwalFa3YDH
 1uMbG8u0unV3m5I3mFr4rpOWpW8rbbGRqVYcLFtRiTVlHI/LL1+PNPgWdLUXZPi3Kgn3
 ETOqSLwLIXVQmqUHCxQRNehruhsm8hmxbeWZBzJDumngvCXgzO30eSKspOBx/zXZEhiy
 spKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/sWhKkMkBMZPIVpjTgS5KYEptwxewFwYh5LP2B/Weg9rkOS4qxHD4tljXwqf26PH7+XunZE2gFz3O@nongnu.org
X-Gm-Message-State: AOJu0Yw3uwOwneJ1IQ7u8YGevw1o5odn2ZfByXDYyEFQNVNjaueAEc56
 0hE0QsAoPjennNyw0932EKakTKCNuLgjJ+39yeYw2SY5c69TQ8P5apHv1toPrKvonEc=
X-Gm-Gg: AY/fxX61cwbBezSpWN9Y+BeJbZUjx2djuBpGvMW3dIGqR4Meprgki34rEQ6IBNXTHNv
 61Y9I9VhDrIwcf/rYaUSjt4qcwS6Qzx29z7wYKKQ1SLtvUxwa7PXQB4+hStSDAHkbY6f0hfyK7n
 BqVhAVl49on48o0vUbWYVxnsF41Kquv5lhlQQ+Ube23M/Mq85z/sGLh4OhjkMzmZnSHW5ImIYm7
 ZlFBPT5TwxhT+dvxpGM/BpaBCO0V8ee1C9VDsP1T6exfgdW9y/3fbyPfraJBOte7n6e2j/IKWPE
 k51t/YfpYkkZOrLtAxFpei6V6ElvmKT0HVnEPsZ92bwkSvWe3YGqfLmPZSmCNK9iHlQeek6u0m8
 LzK1N4QG7vWF+1aysWqc6tWxiKgu1mMcQdLpuM4FmsyERf0PD7uZPldacA/pWpvWiBHZycenLEr
 Qy4vsPaeQR3uY+DmzUnsFNz61Qz+Fu3GXclUEQCIfNgUNBhG+4fzOIww==
X-Received: by 2002:a05:600c:6206:b0:47a:9560:5944 with SMTP id
 5b1f17b1804b1-4801eb14c40mr133063625e9.34.1768825295896; 
 Mon, 19 Jan 2026 04:21:35 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801e8c0499sm195008685e9.9.2026.01.19.04.21.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jan 2026 04:21:35 -0800 (PST)
Message-ID: <2d379a95-d3ec-4f6b-8b21-188540656019@linaro.org>
Date: Mon, 19 Jan 2026 13:21:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] hw/intc: avoid byte swap fiddling in gicv3 its path
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:ARM cores" <qemu-arm@nongnu.org>
References: <20260119120030.2593993-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260119120030.2593993-1-alex.bennee@linaro.org>
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

On 19/1/26 13:00, Alex Bennée wrote:
> The GIC should always be a little-endian device as big-endian
> behaviour is a function of the current CPU configuration not the
> system as a whole. This allows us to keep the MSI data in plain host
> order rather then potentially truncating with multiple byte swaps of
> different sizes.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   hw/intc/arm_gicv3_its_common.c | 4 ++--
>   hw/intc/arm_gicv3_its_kvm.c    | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/intc/arm_gicv3_its_common.c b/hw/intc/arm_gicv3_its_common.c
> index e946e3fb87b..60a5abd8d3e 100644
> --- a/hw/intc/arm_gicv3_its_common.c
> +++ b/hw/intc/arm_gicv3_its_common.c
> @@ -81,7 +81,7 @@ static MemTxResult gicv3_its_trans_write(void *opaque, hwaddr offset,
>       if (offset == 0x0040 && ((size == 2) || (size == 4))) {
>           GICv3ITSState *s = ARM_GICV3_ITS_COMMON(opaque);
>           GICv3ITSCommonClass *c = ARM_GICV3_ITS_COMMON_GET_CLASS(s);
> -        int ret = c->send_msi(s, le64_to_cpu(value), attrs.requester_id);
> +        int ret = c->send_msi(s, value, attrs.requester_id);
>   
>           if (ret <= 0) {
>               qemu_log_mask(LOG_GUEST_ERROR,
> @@ -97,7 +97,7 @@ static MemTxResult gicv3_its_trans_write(void *opaque, hwaddr offset,
>   static const MemoryRegionOps gicv3_its_trans_ops = {
>       .read_with_attrs = gicv3_its_trans_read,
>       .write_with_attrs = gicv3_its_trans_write,
> -    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
>   };
>   
>   void gicv3_its_init_mmio(GICv3ITSState *s, const MemoryRegionOps *ops,
> diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
> index ae12d41eee1..a8d6d4fb540 100644
> --- a/hw/intc/arm_gicv3_its_kvm.c
> +++ b/hw/intc/arm_gicv3_its_kvm.c
> @@ -58,7 +58,7 @@ static int kvm_its_send_msi(GICv3ITSState *s, uint32_t value, uint16_t devid)
>   
>       msi.address_lo = extract64(s->gits_translater_gpa, 0, 32);
>       msi.address_hi = extract64(s->gits_translater_gpa, 32, 32);
> -    msi.data = le32_to_cpu(value);
> +    msi.data = value;
>       msi.flags = KVM_MSI_VALID_DEVID;
>       msi.devid = devid;
>       memset(msi.pad, 0, sizeof(msi.pad));

Could we also clean the other GIC uses in the same patch?

$ git grep DEVICE_NATIVE_ENDIAN hw/intc/arm_gic*
hw/intc/arm_gic.c:2065:        .endianness = DEVICE_NATIVE_ENDIAN,
hw/intc/arm_gic.c:2070:        .endianness = DEVICE_NATIVE_ENDIAN,
hw/intc/arm_gic.c:2077:    .endianness = DEVICE_NATIVE_ENDIAN,
hw/intc/arm_gic.c:2084:        .endianness = DEVICE_NATIVE_ENDIAN,
hw/intc/arm_gic.c:2089:        .endianness = DEVICE_NATIVE_ENDIAN,
hw/intc/arm_gic.c:2096:    .endianness = DEVICE_NATIVE_ENDIAN,
hw/intc/arm_gicv3.c:420:        .endianness = DEVICE_NATIVE_ENDIAN,
hw/intc/arm_gicv3.c:429:        .endianness = DEVICE_NATIVE_ENDIAN,
hw/intc/arm_gicv3_its.c:1909:    .endianness = DEVICE_NATIVE_ENDIAN,
hw/intc/arm_gicv3_its.c:1919:    .endianness = DEVICE_NATIVE_ENDIAN,
hw/intc/arm_gicv3_its_common.c:100:    .endianness = DEVICE_NATIVE_ENDIAN,


