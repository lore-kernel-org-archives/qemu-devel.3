Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D120C4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 20:12:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXoGt-00006N-73; Wed, 07 Feb 2024 15:11:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXoGr-000060-Nk
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 15:11:49 -0500
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXoGo-0005ZS-7I
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 15:11:49 -0500
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-511234430a4so2131425e87.3
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 12:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707336702; x=1707941502; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YciELt/36VJ2YseRW23ifnCM7IdWnwGUfVdyvtXTsLU=;
 b=Z2CeDpU8poZvC8j6WwFYV1OBi7tmR8Lt8g6TECOm0V/vpGi3+NDwIHEPEAmnqpGPCF
 BNk0nUj5dB3AYxuBikUTqI3JhyJYdLfV/mNpqOEsPnkse4LGOLeMCBmOGOwHn67Wp6OW
 oNkqsFgfABzapu9SP1fmtv9XwmUZ8l+Uh7gzV6Sl9mrHsnAEKF0IE2/fFWB7POEyVPiU
 mYbfZp9fV5cL0usqErll58KyZHoplaDTcgRGYcJVhQuxOnnwIgXPtgl43n42+qgSPIrR
 +9fZLJEb2sFvmsjG3odwHNnc2mXvsKQ+r8sWEO3XOz1U1YKRJXTAFVZyXa/x9OEFJXE3
 os2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707336702; x=1707941502;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YciELt/36VJ2YseRW23ifnCM7IdWnwGUfVdyvtXTsLU=;
 b=h+BiZvZI+MieMpFkYN6pwMJWDAqldkkTeqz2XizflaPZXNsNABBwQa8pWp7OOl6gUE
 A10tYUWmIPT6F8vdBc9AA6Cc8C5DiQkaberm1u5mKbv2fMJo8R4kjOh3rHM8H744kY6H
 MEZC/Q4bIfr27mJ2Ra8vagyxP0Wwe/Jyaj8yS0+VcMlr/lTfq+kLjMJ+I7FcjGHkyk9U
 9XJOds7/1jKP2KjpouIxt1XlXFCKxC32X4lTaUAszBBVHzWDlmgeUXjVaqiYVat00CfZ
 hMu75NOyInkVliCdROixh4lPp9MBa/cGUrAU/3ls1q3+CewjMK7sCL9GYs83u/rnSPe5
 QOyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcMgE/bPTVSl3Ud/lsd1/l9j2Di4356+PnD/vTbThmIH0f8EUnthUav/5ysOI8OoD3MdjcsJnDWum4dJAhEP42NkXYNcM=
X-Gm-Message-State: AOJu0YxaBZV0RjX/5avu0N1GYwrQ1z0U84Br0CKdpF/JYkrlIfHhNGuq
 qvceEPiuIQn+kIBQPIQ6Jp+IupgN9JesegG6aJMBfx7ZQfXPZmqbdI3ENDDxBBw=
X-Google-Smtp-Source: AGHT+IHqQ04NtnG0BSnuoVpykaYs6chrwrAem3os+hM0TC5KfbU0a5aiuTh2WtNicoY55ZfYPluU2g==
X-Received: by 2002:a05:6512:370f:b0:511:6263:408d with SMTP id
 z15-20020a056512370f00b005116263408dmr2748721lfr.8.1707336702232; 
 Wed, 07 Feb 2024 12:11:42 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUUi4EQfzwW4KTwXxGaraLlQ5EPh1aNxSjn0D9Y29cKFg0v/JoLyLHhsKMYrA0kuNpkLY56SqUtRpOOu1fUU3HE18qPwqAlg015EyF3R7XNyASpjagp6crPNfxbyaQL//f19wG9OZ+SnrPFzq5uUiCNgWs=
Received: from [192.168.69.100] ([176.187.214.82])
 by smtp.gmail.com with ESMTPSA id
 l37-20020a05600c1d2500b0040ee8765901sm3083435wms.43.2024.02.07.12.11.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Feb 2024 12:11:41 -0800 (PST)
Message-ID: <6b71edf4-26cd-4a13-8696-51c18ad1b207@linaro.org>
Date: Wed, 7 Feb 2024 21:11:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] migration: Add Error** argument to .save_setup()
 handler
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20240207133347.1115903-1-clg@redhat.com>
 <20240207133347.1115903-2-clg@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240207133347.1115903-2-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12a.google.com
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

On 7/2/24 14:33, Cédric Le Goater wrote:
> The purpose is to record a potential error in the migration stream if
> qemu_savevm_state_setup() fails. Most of the current .save_setup()
> handlers can be modified to use the Error argument instead of managing
> their own and calling locally error_report(). The following patches
> will introduce such changes for VFIO first.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   include/migration/register.h   | 2 +-
>   hw/ppc/spapr.c                 | 2 +-
>   hw/s390x/s390-stattrib.c       | 2 +-
>   hw/vfio/migration.c            | 2 +-
>   migration/block-dirty-bitmap.c | 2 +-
>   migration/block.c              | 2 +-
>   migration/ram.c                | 2 +-
>   migration/savevm.c             | 4 ++--
>   8 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/include/migration/register.h b/include/migration/register.h
> index 9ab1f79512c605f0c88a45b560c57486fa054441..831600a00eae4efd0464b60925d65de4d9dbcff8 100644
> --- a/include/migration/register.h
> +++ b/include/migration/register.h
> @@ -25,7 +25,7 @@ typedef struct SaveVMHandlers {
>        * used to perform early checks.
>        */
>       int (*save_prepare)(void *opaque, Error **errp);
> -    int (*save_setup)(QEMUFile *f, void *opaque);
> +    int (*save_setup)(QEMUFile *f, void *opaque, Error **errp);

Since you change this, do you mind adding a docstring
describing this prototype?

Otherwise,
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


