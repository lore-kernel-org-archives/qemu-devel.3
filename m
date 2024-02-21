Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CBABC5478A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 18:48:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcrdC-00063b-Gj; Wed, 21 Feb 2024 13:47:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcrd3-0005zk-MK
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 13:47:37 -0500
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcrd1-0007Pr-Vm
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 13:47:37 -0500
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-512be9194b7so3833454e87.1
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 10:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708541254; x=1709146054; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a7EUJ49i0oMNBSEC/248NvWPwBMUdnSI7kxW/bxOLNI=;
 b=T9WoduGjy6DLsSdKjSsFqBWLbJHP0XCYX9CayaPBZ8TAc5AGxMdluzs6j+vPmfhQWW
 NfMzTr28g+W9xxsYHsHYafFfGP4rs8GYQXWZP/A1Ze+7Bu2nizxoJ7IStAUYbib+dhLJ
 YKhVHL+LV8mcvebCN8i9u9p5AiOKmi88XuNM7Jw3Zsiuwv7JczDs2gueFitH6arm6aMy
 FvRsPfPf1pZ/DrZYLoSCUp4JQVMN9kS98CzdyRW6CzTVksMK5SqHbbY/G7C62HrYTAlR
 G2AhL5zLM3b4c13Rh4MQuBvKeWj4XYmt38Gx9c3EHNY5DU6Yh4lt0QSI+8Ckg/WfGdCG
 pBqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708541254; x=1709146054;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a7EUJ49i0oMNBSEC/248NvWPwBMUdnSI7kxW/bxOLNI=;
 b=nlSsBWgdFLU/XnYSFJyEfb0svtY0sTu1x1fvZTGyJuvyf8tDesLIn9qiArxR7FD4kg
 Al2PlnrtiF3WxM7uQtfoKkH/exrJctb3XY3Z9d8HpSXwG8poOx1RrfEtmwXnvH1Jb1s4
 RulE3jaY/3AqZURJvqhHCfxwRbGvE1s6EN0fkMn77UlR/zCXDDw0+zcwTx2EbQzYBJhV
 hZZPyvceGG3BylG4AQsyMmK0t8XUaYWW98kVG6I8q8rf6u3CCWWv/KwbCrTRb94quzuF
 LVvjehrEaNDAzpgchL52OQoDs2XiVYlhuS/Bco9kDp2NsjYbLYimGIcmF0IIxBLVEk2g
 dVhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4DRp/pjhA2V6z10n2koAZUrzu43od+Y5qWY8gGImvQjPxHXu6XbfWKm4yEEh43Y32y4jgSMrYHSeOn5340iG5+ljEql0=
X-Gm-Message-State: AOJu0YxfYFfAlqXV+UqvCF+szKW0z2kHMIYhb9RbEGuPA7733jrVFF5v
 TuewPoZSp73fwkivPPBaC1YRSfx53u2XI0j0I9SC4YOckaV9Xng8yQY7QvbL7pU=
X-Google-Smtp-Source: AGHT+IEU6VGx9sa3VUw2ZJ6Pd6ybqBQgwHFtyhrWOXORndtzKZEYrck/VgUY4tuJ3mi8WZdMQcl7aA==
X-Received: by 2002:ac2:5191:0:b0:512:ab73:d2d4 with SMTP id
 u17-20020ac25191000000b00512ab73d2d4mr6303410lfi.16.1708541253931; 
 Wed, 21 Feb 2024 10:47:33 -0800 (PST)
Received: from [192.168.221.175] ([93.23.14.172])
 by smtp.gmail.com with ESMTPSA id
 s6-20020a1709067b8600b00a3e53eb1dcasm4188372ejo.107.2024.02.21.10.47.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 10:47:33 -0800 (PST)
Message-ID: <99813a8e-45ec-460e-a944-c696eb853b75@linaro.org>
Date: Wed, 21 Feb 2024 19:47:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/sparc/leon3: Fix wrong usage of DO_UPCAST macro
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Cl=C3=A9ment_Chigot?=
 <chigot@adacore.com>, Frederic Konrad <konrad.frederic@yahoo.fr>,
 qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240221180751.190489-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240221180751.190489-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 21/2/24 19:07, Thomas Huth wrote:
> leon3.c currently fails to compile with some compilers when the -Wvla
> option has been enabled:
> 
>   ../hw/sparc/leon3.c: In function ‘leon3_cpu_reset’:
>   ../hw/sparc/leon3.c:153:5: error: ISO C90 forbids variable length array
>    ‘offset_must_be_zero’ [-Werror=vla]
>     153 |     ResetData *s = (ResetData *)DO_UPCAST(ResetData, info[id], info);
>         |     ^~~~~~~~~
>   cc1: all warnings being treated as errors
> 
> Looking at this code, the DO_UPCAST macro is indeed used in a wrong way
> here: DO_UPCAST is supposed to check that the second parameter is the
> first entry of the struct that the first parameter indicates, but since
> we use and index into the info[] array, this of course cannot work.
> 
> The intention here was likely rather to use the container_of() macro
> instead, so switch the code accordingly.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/sparc/leon3.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


