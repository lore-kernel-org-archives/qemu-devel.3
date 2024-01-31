Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A186C47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 16:49:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVDlG-0000zW-Ec; Wed, 31 Jan 2024 11:48:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rVDlF-0000xZ-2Q
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 11:48:29 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rVDlD-00061V-EQ
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 11:48:28 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-33aea66a31cso2183674f8f.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 08:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706719705; x=1707324505; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2nskXqNEhHmqlavcpzvsqzEMsIbp8GhJhLyco9Hf2mw=;
 b=LV6dEifbJ3kpILt0lAniQBr8OlCYPRzK9qSnczlmPtjIWqJw5WyTJ8DXj+SDFSpKYm
 m0NsGaL+MGo3enBt1SLZb7dm8eKvifW5F9yA7P6eVU/SynvltOSSDf06uMFmC9uyjaS5
 a119PdMKUL3N9VlL3Ysg6nv5uXDlMkN0eGUKQkLxES3Ug87gjmtxQbCLI/ktLiaach2I
 xPfBgBVZ7FVyVrDWjWncDGGeDulYFwHYFR7mhoFR1xE80ZvDdK2bC5m5XFFMX4+2aau8
 SVwqW1Wz+1PfbT/t9k0z9okOSkObWTqFu0zSVppt+QNKA7v0Ef0gL2Uo6gQwNMi/FnKL
 muEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706719705; x=1707324505;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2nskXqNEhHmqlavcpzvsqzEMsIbp8GhJhLyco9Hf2mw=;
 b=BJzKSWOJ0X0043xtwlEEMTWUt5KRwHSXrixQyUJFu/LJ/dTxE/IOXv4H3K13y/Bj9/
 y+C+rjQCooh5b0VyQkTgx4NRZp7/vSzlPKOlCa9vviWrFu07Xdr/3BQlH47fxQk9aZd8
 azuxmC1tKhBnCahNLL3TdrJkH0ALZlMmkL0P4jFBprmFufabcTlIbvmllMplNK2ha68n
 2OnasnWgrcQcrBqRpWfYsAiAioyIMxl2LBMeN6pHFjD49O2yYXgsiQQIHmgMW3U35k7V
 +KDybS8gxDTG9wyPYd/nxU80wn5EBQKOFVvV3WQpvRIgjx3RSXYobnGZNvNzXc+ondl0
 rUdQ==
X-Gm-Message-State: AOJu0YxXUtDeuzws53vHsYPNt3tX2FablILvVnX3pib9M/f2Kg8g2+4k
 ym6BuBeFfDuKh+Vsa4Ep29zA5wlRV6FKgTQPpX7x1tJg2q+mpud60nmanGL6poI=
X-Google-Smtp-Source: AGHT+IF1rDD1wo5oBXNMDXWo6HAk5B7W2cSITYBdYTiO1F1oUhyLqqma2YnftaCXwomnEu/YgvMgCQ==
X-Received: by 2002:adf:ef44:0:b0:33a:e4de:9afd with SMTP id
 c4-20020adfef44000000b0033ae4de9afdmr1384917wrp.29.1706719705520; 
 Wed, 31 Jan 2024 08:48:25 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUUiyzCIXjjnggOZJBxU7e7STV2QPgwJW4NkJ+OE4QlQrvR5aviG+/boZELmd2pTFtpFOMK9rHiYgj3VaKCjMQWhIaQF51w9njwtHCmflM/HpXJS8OWi/9E8RrCqtK2ecqTOPhjeK3XXhmmHcOMfqq8L1wRtg1Z4MJ3wrwjC6PRO7cURpnM1ByVEhf1UyqGlq8Rlsl4
Received: from [10.228.24.192] ([84.55.155.224])
 by smtp.gmail.com with ESMTPSA id
 w6-20020a5d4046000000b0033b0d049c71sm664013wrp.54.2024.01.31.08.48.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jan 2024 08:48:24 -0800 (PST)
Message-ID: <cdb1c6cd-0095-4787-a740-17b42e061548@linaro.org>
Date: Wed, 31 Jan 2024 17:48:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/intc: Handle the error of IOAPICCommonClass.realize()
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Markus Armbruster <armbru@redhat.com>
References: <20240131142902.115964-1-zhao1.liu@linux.intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240131142902.115964-1-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Hi Zhao,

On 31/1/24 15:29, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> IOAPICCommonClass implements its own private realize(), and this private
> realize() allows error.
> 
> Therefore, return directly if IOAPICCommonClass.realize() meets error.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   hw/intc/ioapic_common.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/hw/intc/ioapic_common.c b/hw/intc/ioapic_common.c
> index cb9bf6214608..3772863377c2 100644
> --- a/hw/intc/ioapic_common.c
> +++ b/hw/intc/ioapic_common.c
> @@ -162,6 +162,9 @@ static void ioapic_common_realize(DeviceState *dev, Error **errp)
>   
>       info = IOAPIC_COMMON_GET_CLASS(s);
>       info->realize(dev, errp);
> +    if (*errp) {
> +        return;
> +    }

Could be clearer to deviate from DeviceRealize and let the
handler return a boolean:

-- >8 --
diff --git a/hw/intc/ioapic_internal.h b/hw/intc/ioapic_internal.h
index 37b8565539..9664bb3e00 100644
--- a/hw/intc/ioapic_internal.h
+++ b/hw/intc/ioapic_internal.h
@@ -92,3 +92,3 @@ struct IOAPICCommonClass {

-    DeviceRealize realize;
+    bool (*realize)(DeviceState *dev, Error **errp);
      DeviceUnrealize unrealize;
diff --git a/hw/i386/kvm/ioapic.c b/hw/i386/kvm/ioapic.c
index 409d0c8c76..96747ef2b8 100644
--- a/hw/i386/kvm/ioapic.c
+++ b/hw/i386/kvm/ioapic.c
@@ -121,3 +121,3 @@ static void kvm_ioapic_set_irq(void *opaque, int 
irq, int level)

-static void kvm_ioapic_realize(DeviceState *dev, Error **errp)
+static bool kvm_ioapic_realize(DeviceState *dev, Error **errp)
  {
@@ -133,2 +133,4 @@ static void kvm_ioapic_realize(DeviceState *dev, 
Error **errp)
      qdev_init_gpio_in(dev, kvm_ioapic_set_irq, IOAPIC_NUM_PINS);
+
+    return true;
  }
diff --git a/hw/intc/ioapic_common.c b/hw/intc/ioapic_common.c
index cb9bf62146..beab65be04 100644
--- a/hw/intc/ioapic_common.c
+++ b/hw/intc/ioapic_common.c
@@ -163,3 +163,5 @@ static void ioapic_common_realize(DeviceState *dev, 
Error **errp)
      info = IOAPIC_COMMON_GET_CLASS(s);
-    info->realize(dev, errp);
+    if (!info->realize(dev, errp)) {
+        return;
+    }

---

What do you think?

