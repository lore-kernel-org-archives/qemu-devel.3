Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DFEF106FD6B
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 03:25:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0t8l-0005g6-Fe; Thu, 12 Mar 2026 23:24:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0t8j-0005eX-SM
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 23:24:41 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0t8i-0004By-Br
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 23:24:41 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-48538c5956bso16244615e9.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 20:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773372279; x=1773977079; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vH//3b5LVkL4IGqvtzeIt7I0mqIUO1WdDJZeIc1AC9Y=;
 b=k+yqfnW9DoYvsbkmgwxFxF9j1OC5c4m4LI5k9XhSo5ZHxWwznCkKOomgSbjLkThHwc
 CBS57mwBFjUcjbzfZoOmHK1HpXZtduZ47Gav70yylSEphdqyB3/sbQjwl8ZbjHV4bCpU
 L1yFOXJ5FUFWjPNvuzcLr2FTFHc7UI25WFyO4uFTlZwGff6vzqgwsHzg7Y82uaiSlO+V
 Z2hgj7KD7Qv2jVKfgTJRCwyEta7st4TnJUT3uU7hm2479FVFfuT/qLaA4xmrJBLswYOs
 AhW/SNqY5qgN10ao1pn2fh1J0Fsnvua56EkuDWCfTjvDZxalaT+NU3+GEVxUxKKKSYbU
 GSdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773372279; x=1773977079;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vH//3b5LVkL4IGqvtzeIt7I0mqIUO1WdDJZeIc1AC9Y=;
 b=qhaF8vrEJT2RF1swgHqiOi8vsP5OYiKU43FpXI46i/+s0f402R8sroQ6uKGZ268XRz
 j3FQzigVwnjrGjpdKwoaXfoft7CdsyUCxGG7bYTp2SXJ8zA56ciNEwOJiMPNmwdndHmb
 BM3DyIGpCLiA1prOtYGtgS+tx62jnz7e5fhHLtNO4DqlJ4r0TqAyYfT040hs8t3VCzTs
 oH8q3M5l/Xn73mqX05/83jxogUfGxx6Ap3+M9IhVJ7nhjVqlWPk/izQBNt8JnTVAW51P
 HQdNm0zns0/rqtxvk/zvmQQMzAU4CnX72QqT/iq79R04or4zb3vC99KwDbeAStovWvDV
 FcKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiQjYIhYaznCC8bG1fNXoikRvSJG8Fpm2whmIsW2ouDdMo/ggTA7MufoSlNdn27MOpJeUCK7aNdKeF@nongnu.org
X-Gm-Message-State: AOJu0YzzFEsKN1tmPLDyfA0kjgKzpiqBfRm5iNCzXk9fq5rB2SM5G0aw
 MeCthKF2LFrWOKJ5VkFOBgZsbqKS++xPSnVXynzyx7PURCEB6i0R56NdTFmsM1q+lXs=
X-Gm-Gg: ATEYQzyWnGURieEk7DRxchBued8LDhBs+aWbqoDS3mU/2/FRqsYjqOfw4F5WiDu2e61
 rcb0Ra2WuwEu3oyU9QtF4y5zEiyreyFFoIcKEqe1nXavKiA/W2jHbPTV6HrnUfJTn8M3ulsLCZp
 dvmVjsJOix+r8UpLd/E1y1urOMkoT/s2lZ56qEuX75f53mTxZfAmxP98pOfa6p5WkyAw+s1hhiA
 HCi7qRADOoc5P5m5ukOq/8PID2B1HeOY9IgLr/PTI4rE6MBtS/N3mg/OwgUvjI5pVJ+kFdmFdm0
 WzVBePrfopk4Rcbp2pzbXcm2h6kgGr1k6qYKXqnHbTFV/5YbcAzz/JxX3Mn7AT543JTPLcd2tZw
 H4V6ujeKZ/NTy0wUNcKOf8L2S4GMXzI2khNTVPY/AGRC5ui5Xt9rs+1zqjjBeN+2WW6sSMJUW9D
 td0uwiB5c8akbSg5GxNPC6FLAbSIJlm3SgrPFVIca5NsjRlr/LrClV8MoKa3y9iu9y0A==
X-Received: by 2002:a05:600c:8488:b0:485:3b4a:f707 with SMTP id
 5b1f17b1804b1-48555b2c89fmr26793325e9.10.1773372278655; 
 Thu, 12 Mar 2026 20:24:38 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b5e92d5sm171107525e9.1.2026.03.12.20.24.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Mar 2026 20:24:38 -0700 (PDT)
Message-ID: <19aa7756-f142-48aa-bb12-15bf6893c58b@linaro.org>
Date: Fri, 13 Mar 2026 04:24:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] hw/vfio/pci.c: eradicate CONFIG_KVM
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com
References: <20260312224449.1605071-1-pierrick.bouvier@linaro.org>
 <20260312224449.1605071-6-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260312224449.1605071-6-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 12/3/26 23:44, Pierrick Bouvier wrote:
> We just need to add kvm_enabled() guard on concerned functions, but no
> need to extract those kvm functions since they are not using any kvm
> specific types that would not be visible at compilation time.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/vfio/pci.c | 26 +++++++++++++-------------
>   1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index df617f1fe46..62c52407cf9 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -152,7 +152,10 @@ void vfio_pci_intx_eoi(VFIODevice *vbasedev)
>   
>   static bool vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
>   {
> -#ifdef CONFIG_KVM
> +    if (!kvm_enabled()) {

I'd rather this check done in callers, and here assert on entry:

        assert(kvm_enabled());

(Applies to other changes in this patch).

But this "call KVM-specific helper even if KVM isn't used" pattern
is pre-existing, so can be done later:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +        return true;
> +    }


