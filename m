Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6078FCB602
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 15:49:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyttr-0001FK-9z; Sat, 07 Mar 2026 10:49:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vyttm-0001Eg-RA
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:49:05 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vyttl-0003I3-91
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:49:02 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-439b8a3f2bcso5077159f8f.3
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 07:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772898540; x=1773503340; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7WLioosD1RjShB0PXaIfA0EBD3SfzvwrSkU3+hGUsVg=;
 b=B5jXnnHTUI3fXxGVrLkhL9jxlZF4hLXkXsZN7HcThle6KNvVzgbxkx5jmogtk9TJiK
 7pCx+Eb/9D/G+13eBc9tF7MwK4H2jVT+E2cEcmthMSgSfPKkCUWp2ct9XxwEZoMP06UG
 F9eINkfE+rhPDBDlpt7BvYygSM9attK/Zcl5X5VwPWYNBbtWDhIZVO/0pyI92MQT7oIc
 jDgVhpVYjjimAyPgLUu9wKlwdU4W/n5p8NHd7LPIZBVnJdMJ1cYQtHOR3sMjGYdyoPCI
 uPpdxj5kto89uvSEw6ODeGJfVJaXGP4dFd94e7rDhOK5MIwDnbUFZ/8QQqA865bsdyav
 BwBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772898540; x=1773503340;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7WLioosD1RjShB0PXaIfA0EBD3SfzvwrSkU3+hGUsVg=;
 b=HLgTcAh50uxINsofzSLth/ExdZbqfndWYgJ0vTkJcQg3ott2+nJMcIdB4yLG7oh/U3
 4TtCcN6RBeivLvtxBcsxhC13TIQCwl/BXl5xL6iqzCAsmZp01X772CjMtL/369YVxO3G
 i6spuL/+FZLBCGyYvbJw6lRPgVg3u59FUNzi/9ef9JMe20eXdn9Ryp46tJxU2Qi1Bwtv
 iXx8Shvftxiak7pQcJDwc6WYbgxM2K1gqLWfIQ62voG6MaGrhu/9kfM5uzvApN4T4jR3
 j9CEI7P55KktIja+MXveyFCVGUYqvKTksiArtJC6lo0mnTK3rt1j4NWrbUpbtKXhFTfO
 yyTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgMq/28QN34/PHA6BOKpA3SuhDASz4g1kQ1ZnJsUNdaUptEG4JYgoP/fqQqn9TI0iHRPXQHgspLaep@nongnu.org
X-Gm-Message-State: AOJu0YzIuX2MLtj/kRFZ+hKqCkn00Mb9dWyQIienY0kf8z/wfhtxEFBg
 nUMaskeR8OE4qtBWf8vFQabGgykf+KDcz8m3O0KpYkaA7b2gfWAUoIdBL7OhBEHz3ng=
X-Gm-Gg: ATEYQzwBhdAUx6BFxu/sKNhC92i/WTH0btQPVu7buRIFc5g+ArPgafnjoSThouBXt4f
 dBQEw0+8+MqV+xUYNcqRcn0Y9I2vAO9EuTFxcL8Czz906zLyj51njIy3Xcy4VQAbVfVntF+weqV
 zLvg/WR7NLfsdcXD20EZvctUZdrm9YTwQvhS6vbmpnWoWNgJ1Eck8rm671DRK/UJj9OGN5E/MJ+
 dNm6CaxPvgKhb6G8opygVzm7DuB4iXbGEkQmMJPoND9BaQ8z2HkBYpyjUo3/LOFC+wsdndZdpXg
 DNhNb1+KT91q2QNmdzRTNnSBI3cQ6KA7LEma3HGdapO8yuuho4TyELg/SQxmD5WXxf2d5T6eFoo
 hPvuLEl0tnyJXJBXhSQUIaWWSJtCmSv9lP+8wlJhOKoPXFj2RUqQ7cXhSdbMdAFj5V1n6EJkzEQ
 yk57eIAfAj9JHtQ+cDq2zS7eYe1aaUiqkLj9qal8SJcFl4uq8a43Pseq9otgsekWQ4bg==
X-Received: by 2002:a05:6000:2891:b0:439:d935:87c0 with SMTP id
 ffacd0b85a97d-439da65d71emr10291937f8f.17.1772898539621; 
 Sat, 07 Mar 2026 07:48:59 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae56300sm11473760f8f.37.2026.03.07.07.48.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Mar 2026 07:48:58 -0800 (PST)
Message-ID: <d2bd5f90-a0f7-490e-b735-43442f41c679@linaro.org>
Date: Sat, 7 Mar 2026 16:48:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 05/13] hw/arm, target/arm: nested virtualisation on HVF
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>
References: <20260307153143.76893-1-mohamed@unpredictable.fr>
 <20260307153143.76893-6-mohamed@unpredictable.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260307153143.76893-6-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 7/3/26 16:31, Mohamed Mediouni wrote:
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   accel/hvf/hvf-all.c    |  1 +
>   accel/stubs/hvf-stub.c |  1 +
>   hw/arm/virt.c          |  5 +++++
>   include/system/hvf.h   |  5 +++++
>   target/arm/hvf/hvf.c   | 42 ++++++++++++++++++++++++++++++++++++++++--
>   5 files changed, 52 insertions(+), 2 deletions(-)


> diff --git a/include/system/hvf.h b/include/system/hvf.h
> index dc8da85979..0f0632f7ae 100644
> --- a/include/system/hvf.h
> +++ b/include/system/hvf.h
> @@ -28,9 +28,14 @@ extern bool hvf_allowed;
>   #define hvf_enabled() (hvf_allowed)
>   extern bool hvf_kernel_irqchip;
>   #define hvf_irqchip_in_kernel()  (hvf_kernel_irqchip)
> +extern bool hvf_nested_virt;
> +#define hvf_nested_virt_enabled()  (hvf_nested_virt)
> +#define hvf_nested_virt_enable(enable) hvf_nested_virt = enable

Unsafe macro. Better expose the method and add a stub.

>   #else /* !CONFIG_HVF_IS_POSSIBLE */
>   #define hvf_enabled() 0
>   #define hvf_irqchip_in_kernel() 0
> +#define hvf_nested_virt_enabled() 0
> +#define hvf_nested_virt_enable(enable) 0
>   #endif /* !CONFIG_HVF_IS_POSSIBLE */


