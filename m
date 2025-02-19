Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43762C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 13:43:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkkM6-0005KG-2A; Wed, 19 Feb 2025 08:43:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkkLh-0005Ig-JX
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 08:42:50 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkkLf-00046I-PK
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 08:42:49 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4398c8c8b2cso31902605e9.2
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 05:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739972566; x=1740577366; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Yn5JxOvVuxWCvPs91MBi63impH7jVLwkgwEDOqQZBco=;
 b=jy0ZzDaSftJ8TvWyGVM1Gv7EnoS3BVXc9Q6A1CU6cvVKyIKnk2t3FNOP2g04kQK+Z7
 QcQ4tN2NIDMUTgpJSNWVn0uLpZVWOXeEWZQIW8JiUNm0Ndxvyw9goyIFW1yEYu8zJpUx
 v3Ax+nRG/5Ou6RjWnb6uggItCUGvSgwOtFstIQG8OyEFnN7G+FqS+N7EfQ1kuBg3yKk9
 4uvMPZUBV9jHsKMuaeRfluQIUUcFElrDlBALk+1A6RNHRNiZFWaqIIeoramIACqEfdQo
 ljrV7wKE41/CT2/1mFB2T9G/c7heSkIj7wCHvbctfIPf2Uu9CsbZkmJ+YBskmFVAmTk1
 4hag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739972566; x=1740577366;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Yn5JxOvVuxWCvPs91MBi63impH7jVLwkgwEDOqQZBco=;
 b=XpME8qUotApHWT7DWKywFCu3XoIY16eXfieGTVcLMXesbnAsTIV7yxfA3I+HSOMcqh
 aGjAH4unxdHt/cuLY3jTNG9QVwJlf8SyQVLRW2s8wp4nC4UG+ee7eHUluxXA3psUpnO+
 c/Kyp+ySExJQraFoKXW5NBjJBDJmIPRbKMaxL86T/ZtYKgERALYfhETes7hiiB+L6Z8o
 /5wiHcakxc9uK9lP4Bgd2dOSnjBe1e7cAc9n1FtB370AvqC6cljTfOdtbsAV1zVVYF8p
 fNJ7dKTC//DdTHJVw3CU9jTUvbuImei4eI9ZwUepc5/npWlwQAnqIJofVfMzhJ1Yzm3d
 lpbg==
X-Gm-Message-State: AOJu0YzSew/X3T0SZuDJYvTwG9FI8xT0ciDykVDWT4pSIieE8xUp4Mu0
 L6AcuSqytWVF4th5gNLNkJUN5fdu5C+qMsGoewers3hrMQgcqMzh+6Oaz0DtPjYb04cfIDb0050
 zHcw=
X-Gm-Gg: ASbGncubZnVz/H++Y/zBQRH/HnTYOj94/3DcNEJ3ZgljWVxr3GzCGDlViLsyuVUc6FB
 YkBikp9n3ry4nf9tswZ+C2ubjP+Df2IeRTtkdU51S5jJnzH+1+iP7dvIZ0QSx9RzS+CnQM0HNBo
 SdsOqOiOMY3hHZtJyA5H/qaHiu+UtR1ef8RxWl+ynSJlTmubdw4LS5Fi3cKGc3jBP9a6oimVEJk
 NL7RrT+Dib8xbey4goRIR9KMPSi5htEJwW/tA5zRPpuJIgV1Hg2KU+WdRIjJVoLGlr+KukpVfp8
 Mo+Njaa8JcK/3Cx/yrrEbxv6MX+MsU+BQVN4r1WQgOw0hMHC+TOAU/yOeAk=
X-Google-Smtp-Source: AGHT+IH7GF4WcIIO21sC8SYTBYxp+DeRDGjHt0znsHo41EKs2B8cze0cqBu+optlI0hNkxMVH11Fqg==
X-Received: by 2002:a05:600c:474d:b0:439:9eba:93bb with SMTP id
 5b1f17b1804b1-4399eba95f4mr19117345e9.18.1739972566177; 
 Wed, 19 Feb 2025 05:42:46 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a1aa7d2sm215547745e9.25.2025.02.19.05.42.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Feb 2025 05:42:45 -0800 (PST)
Message-ID: <27970761-5032-4bff-8c15-6125ff341499@linaro.org>
Date: Wed, 19 Feb 2025 14:42:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/intc: Have ARM_GIC select ARM_GICV3 when KVM is
 not available
To: Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org
References: <20241227202435.48055-1-philmd@linaro.org>
 <20241227202435.48055-3-philmd@linaro.org>
 <CAAibmn0zhrZjZ+SL7n7eg041a5APx-o4sCAp0YGDiwUk8gpgDA@mail.gmail.com>
 <CAAibmn1g6+btdRX99ZUvbaBm7hP_AnAGNfDHz4Wgi3fPn=waOw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAAibmn1g6+btdRX99ZUvbaBm7hP_AnAGNfDHz4Wgi3fPn=waOw@mail.gmail.com>
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

On 7/1/25 17:05, Phil Dennis-Jordan wrote:
> 
> 
> On Sat, 28 Dec 2024 at 11:48, Phil Dennis-Jordan <phil@philjordan.eu 
> <mailto:phil@philjordan.eu>> wrote:
> 
> 
> 
>     On Fri, 27 Dec 2024 at 21:24, Philippe Mathieu-Daudé
>     <philmd@linaro.org <mailto:philmd@linaro.org>> wrote:
> 
>         When the KVM accelerator is selected, the Kconfig ARM_GIC key
>         selects the KVM GIC implementation (ARM_GIC_KVM).
>         For other accelerators (TCG, HVF, ...), select the generic
>         implementation.
> 
>         Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org
>         <mailto:philmd@linaro.org>>
>         ---
>           hw/intc/Kconfig | 2 +-
>           1 file changed, 1 insertion(+), 1 deletion(-)
> 
>         diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
>         index 7547528f2c2..762139d8df3 100644
>         --- a/hw/intc/Kconfig
>         +++ b/hw/intc/Kconfig
>         @@ -23,7 +23,7 @@ config APIC
> 
>           config ARM_GIC
>               bool
>         -    select ARM_GICV3 if TCG
>         +    select ARM_GICV3 if !KVM
> 
> 
>     Wouldn't this disable the ARM_GICV3 by default when building with --
>     enable-tcg --enable-kvm? And then there would be no GIC available
>     when running the built QEMU in TCG mode. (Bear with me, I'm a
>     relative Meson newbie.)
> 
> 
> 
> OK, I've managed to answer my own question now by setting up a RPi5 with 
> aarch64 RPOS and building QEMU on that with --enable-kvm --enable-tcg. 
> With patch 1/2 applied on current upstream master, I get:
> 
> $ build/qemu-system-aarch64 -accel tcg -M virt,gic-version=3 -smp 4 -m 4G
> /[runs successfully]/
> 
> with 2/2 applied as well:
> 
> $ build/qemu-system-aarch64 -accel tcg -M virt,gic-version=3 -smp 4 -m 4G
> qemu-system-aarch64: tcg does not support GICv3 emulation
> $
> 
> In other words, with the proposed change, ARM_GICV3 is indeed deselected 
> if KVM is selected even if TCG is also selected.
> 
> 
> Possibly very basic question: is there any support for kernel- 
> irqchip=off on aarch64/KVM?
> If yes, don't we need ARM_GICV3 in that case anyway, so we should drop 
> any accel dependency on it in the first place?

Cc'ing Alex & Gustavo who are more familiar with GIC devices.

> If we definitely don't need the software GIC in KVM-only builds, I guess 
> we're down to listing each accel that needs it individually. Is that:
> 
> select ARM_GICV3 if TCG || HVF || NVMM || WHPX || XEN_EMU || XEN
> 
> or can we drop any of those? Have I missed anything? What about QTest?
> 


