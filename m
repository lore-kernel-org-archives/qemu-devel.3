Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B976D637AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 19:45:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBJHj-0005F8-MK; Wed, 13 Nov 2024 14:44:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBJHi-0005Ef-27
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 14:44:14 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBJHg-0002oB-1a
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 14:44:13 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43152b79d25so61266115e9.1
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 11:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731527050; x=1732131850; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5FnGOJlzM4v16n7fAGoTZA1iNCMi3ElcQ/5A/j+cRAs=;
 b=phfZEI7gIsmrQyDJGKoZEumS3Vl6K873wQR+9edLB+yfkb/eDpNVjcX8jKkmLZLWvT
 74LMjIRoA/pl2PR7cYElG6YFuiqhqrbkwaUBl9jTV9kD6tBiJ8VLJa0IfEwUS1A6rsuM
 zqEyV0XEeeF60vk3Be3KYAOjB88/gXKuzqwVow1MsQpZQ8axdo+ROPZUpmH1bhC1c6Nz
 UWWwHN/3src69bsoBipDFx+IOS0OWd6FY+1+9dGG1f/hqeeGldzPKnZbzQ3HoiLNC2Db
 E5r43X5WfAXCZloMfDuym4o0QNCKT6/LkCoX+pfnLksrJpSyxy7LjUjw1oo2Sqwi941I
 2X6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731527050; x=1732131850;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5FnGOJlzM4v16n7fAGoTZA1iNCMi3ElcQ/5A/j+cRAs=;
 b=whZ7kaX2id+LAUvLabr3IsmO3sCxwU2XHIOL44YyDlksZZX3X7Fb8UIpYpgTfiXWCB
 0AvmjGO+3flUZ64/+g8Kj89/FTBEaOHyhetlk2I1xavTqg+14Nt1erJatYpslb2ey6vl
 Kx+M2ZxcivDW7m53S45TJ6umAcYu7Od1biO13ARSu987f3+yke2nRrkoxBg/uR5MHDpk
 SiMhHM6T8j8y971n9CiNQrrlsdzM4nHHdGoCi7tg0x5N43/Xs/86OcGtp3r+ZR8HY3PQ
 MNGQKLy6IDtZ97kXBerlv4Hp08YDYvS219KmwkW7BTDIMOANw8k5+WiVkQFdfC0euhi7
 8Jew==
X-Forwarded-Encrypted: i=1;
 AJvYcCXluQgnWAo+88tr2qx1jNM2RyOtMn/VJ/9+h4GEZcNYXATQWrfytR6vmXyIAda0rKWe54LZklEwDkuh@nongnu.org
X-Gm-Message-State: AOJu0Yy1ao+cTCxsitrDHy7tfiKTbwJQy4jQT5d7+PwXa/T59OSaMipn
 RKFD9K/aI4BQxaEeazw+QBEN/uIG6XFVwwVR3HJh/0Nv+h5cz3Yvq4jwk5+nJb4=
X-Google-Smtp-Source: AGHT+IHtVOq4sfAsZ/b8xc7equb+7QaatiM0y7ohVHCydBX6gf6IJOmg2D8SuzBN9RISrq0NwmXINA==
X-Received: by 2002:a5d:59a5:0:b0:37c:cee0:96e6 with SMTP id
 ffacd0b85a97d-3820df6714bmr3740679f8f.27.1731527033260; 
 Wed, 13 Nov 2024 11:43:53 -0800 (PST)
Received: from [192.168.69.126] ([176.187.209.238])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed9ea4ebsm19209651f8f.69.2024.11.13.11.43.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Nov 2024 11:43:52 -0800 (PST)
Message-ID: <14068cfb-4f38-48bb-b0bc-78c56dff5ebd@linaro.org>
Date: Wed, 13 Nov 2024 20:43:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2] linux-user/arm: Select vdso for be8 and be32 modes
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20241113170124.1944984-1-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241113170124.1944984-1-richard.henderson@linaro.org>
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

On 13/11/24 17:01, Richard Henderson wrote:
> In be8 mode, instructions are little-endian.
> In be32 mode, instructions are big-endian.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2333
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> Based-on: 20241112203757.804320-1-richard.henderson@linaro.org
> ("linux-user: Fix elf load and vdso alignment")
> ---
>   linux-user/elfload.c                       |  31 +++++++++++++++++----
>   linux-user/arm/Makefile.vdso               |   9 ++++--
>   linux-user/arm/meson.build                 |  13 +++++++--
>   linux-user/arm/vdso-be32.so                | Bin 0 -> 2648 bytes
>   linux-user/arm/{vdso-be.so => vdso-be8.so} | Bin 2648 -> 2648 bytes
>   5 files changed, 41 insertions(+), 12 deletions(-)
>   create mode 100755 linux-user/arm/vdso-be32.so
>   rename linux-user/arm/{vdso-be.so => vdso-be8.so} (95%)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


