Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA11C87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 20:31:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufP49-0005KZ-Bq; Fri, 25 Jul 2025 16:30:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufP0z-0002Bw-IC
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 16:27:37 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufP0x-0002GO-Lq
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 16:27:37 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-23f8d27eeeaso24634185ad.2
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 13:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753475253; x=1754080053; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j1vdr03GyT9WQeKg0Zi5t6bSALM9+R7BdJYPHac4Smg=;
 b=mNcaa9PVC2BLsdOVwY21H19TbaRJ1Wokolf1Tt6/oLhSC39Pnjt2S4Zz+SneRtsLgc
 jPvqLtcN+ONNLOD9qn6rjxI87zzy5QlRwa+1Enenl0v1gV0TDzwqYZqR+tDC3f/C3Qgt
 JFwedc3kN4cTJTHXda1H9B6e0GA/Lm8VGXTB+9/2nkwyMqcyPfIefFpWzS9oZVh0I5eU
 yPmuzWAiDVRgi4ZBfKdlwixzblnFPDkiAiXj0lSVKQZbpiUGhHpRN9Ksjq/6t1rPHYYL
 +vL6P6Ursq01p5FLpu9R4k97UAnxWvxZGDnQhpbdPgGWh3fODoC08tvdKXesS91mkQpG
 Dycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753475253; x=1754080053;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j1vdr03GyT9WQeKg0Zi5t6bSALM9+R7BdJYPHac4Smg=;
 b=b1ddAdzrxft3YkbkfjTY6rTEwqnCjwoaqgf87Jys12ks1xl9jnH4qM4j3X1ykuwNtu
 rKQ/6FlVi5rVUXZqDFlcZ1BHOHfXEAtVG12Q8PiS879LJFX6ahO3RM7WVoegN4HvJB83
 dAq/zntjfx5jQ02cysObQC1QMbJgVrnF5t3UTZ+wgIwrg5jWZNKCh+TRT1h5PppYidsk
 Fp66N7HBzre5bAUho/WCFNAGibgA4qcoSXccq8YRVTra+FKSf7hO+XeGh7FE9FQpHsvD
 YvEg1kkhKwwIBQP2jFzNy1GCJmlOfPM0jHYe6StPgBKDDLmNdcAsQh5HPNCrKqeBLLgI
 mRFw==
X-Gm-Message-State: AOJu0YwVboSvdlcm6CUT5c8szVplnOhtmw74N2dxI3aGlA2sDigtlr4c
 rSimWv6fGioBj0OofvvejOdx4w4Gkmkob686G0rW8bF2M0i+5gdZeRCJi/rzj+Y/8zpkZoujU2I
 InROM
X-Gm-Gg: ASbGncsFtDTCF6OprwnP5T4gQ+4o2Mlri1wg35/SmbawUD9x1/A6m0P2c02aSFqZN/P
 4KaJKaXq9VVw4yu4B8O7F84BkFAIc1cmSRphHy+HaedfDIuJHf5fI4rbcmH6EPh72gdYKhnJRDJ
 +QvlATqzPPJnLOaUdqbZpQjVT2fft+pz8hN8Qv8QE5CclnaDMSMz81kxkgMp54Ryec1zjCpuWrS
 6Ed2VLy8J5C9BgX7xFkM+NDSu8Bi0a6SC+Ozj+fOZc5s5Lz0WR0RwZQ66X8iaeV6dIvXHY00VUz
 +SASCbtxsNJ1ofluJ0GojWNwiw10v7EnOofQznRT4TOWbys6TFha2WOcHBp4XtOLXuHcYcXMkhO
 ACJw1DOKbrVRs6Sk+rWeunaoyyy31ZutyeNx7/I/coFAx/2W0uI2kJxbVCi5mBx/HXcZCHm4hXq
 wWsQ==
X-Google-Smtp-Source: AGHT+IFGvGxv6cDLTxCPJGmZvb/E1rq62mpYNJR8b8owbzZoDqkqkSKJ94XPKyFp+gbKrPrI5E/Tjg==
X-Received: by 2002:a17:902:cf03:b0:235:e942:cb9d with SMTP id
 d9443c01a7336-23fb30cb4bdmr56427955ad.17.1753475252690; 
 Fri, 25 Jul 2025 13:27:32 -0700 (PDT)
Received: from [192.168.4.112] (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fbe4fc7cfsm3625595ad.112.2025.07.25.13.27.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Jul 2025 13:27:32 -0700 (PDT)
Message-ID: <de2c0b52-9037-45d6-9006-61cf53063ebc@linaro.org>
Date: Fri, 25 Jul 2025 10:27:30 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] migration: rename target.c to vfio.c
To: qemu-devel@nongnu.org
References: <20250725201729.17100-1-pierrick.bouvier@linaro.org>
 <20250725201729.17100-3-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250725201729.17100-3-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 7/25/25 10:17, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   migration/{target.c => vfio.c} | 2 +-
>   migration/meson.build          | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>   rename migration/{target.c => vfio.c} (90%)
> 
> diff --git a/migration/target.c b/migration/vfio.c
> similarity index 90%
> rename from migration/target.c
> rename to migration/vfio.c
> index 12fd399f0c5..0b64e49ef06 100644
> --- a/migration/target.c
> +++ b/migration/vfio.c
> @@ -1,5 +1,5 @@
>   /*
> - * QEMU live migration - functions that need to be compiled target-specific
> + * QEMU live migration - VFIO
>    *
>    * This work is licensed under the terms of the GNU GPL, version 2
>    * or (at your option) any later version.
> diff --git a/migration/meson.build b/migration/meson.build
> index 36fb950b3b1..45e9445f97d 100644
> --- a/migration/meson.build
> +++ b/migration/meson.build
> @@ -51,4 +51,4 @@ system_ss.add(when: uadk, if_true: files('multifd-uadk.c'))
>   system_ss.add(when: qatzip, if_true: files('multifd-qatzip.c'))
>   
>   specific_ss.add(when: 'CONFIG_SYSTEM_ONLY',
> -                if_true: files('target.c'))
> +                if_true: files('vfio.c'))

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

