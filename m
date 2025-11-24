Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D68CFA466
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 12:33:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNVUK-0006fR-M6; Mon, 24 Nov 2025 07:16:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNVT2-0005Dy-BV
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 07:14:56 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNVT0-0002Da-BJ
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 07:14:51 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-42b379cd896so2294467f8f.3
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 04:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763986489; x=1764591289; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Of121HS8SSCgYw4Agc/yloPFf6MMSVd2IAJBagVwBXE=;
 b=xwqPzrSyvR7SRe2TJ6cUw+Zie1rGtnxLaAZESx58Xkpdk3tLC4auKmKqhzpnUIrJE4
 u1vc/hh5TB7l/7rmR2zyNqvJi8sRzWXOGD7avGGNkcDR/Pp9ePT/qt0nOK0pTE91/hNb
 /YxAfQw9JC1FSnTGPlMivpK/PbNC96AJITKNs2ask83aLBOES79UxePGk1CkX/6py5JD
 GIIdZxceLfXwzjQkQ5qlpnrewaVnjDjuMSEMo7mXfrl65ag1hB9AEZqJFGRdxhYDIFEe
 C/MByn1dQvhzvOZ4qNInTcOZidnLIJ8aZZCcVIXu/HMz3Ixu/XGEnS20tClW0aa+WBp8
 WEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763986489; x=1764591289;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Of121HS8SSCgYw4Agc/yloPFf6MMSVd2IAJBagVwBXE=;
 b=bUVEm1RfAjJiKc+jy2PJGFhpAabrTgC/SDQlGhIQNYLuzOzED8VJwZ2A/7rBEQPwWZ
 ZJq8/KyNJ/BGESJ7rJIBE5edhvajsXzITISBol+630VydQVPFNqxIAGqmABo0ei1lmMU
 MXa7E8ZsYg3PMxv7aCbw47hKWcR+a45trXA3gTUk8U9AZbuwoQ17icquBcLOlUfatwCW
 fbCAap9j8zAgofw3lgaj3zJJGK4w2NqP+tDnZ2zxEjWnWWE7Vr/SMIDLaflTtdzzchtT
 Z1kPtjsEHMTs5fL5cwTMR3Q7RCL1rTf6nAeySL/+5vRIHpMZNSpzUtUnSIpaSntaR7FY
 Ovow==
X-Forwarded-Encrypted: i=1;
 AJvYcCWK+1F2ot12lrqh1s6/TFi1mI1Qv1eRAZAU01+Osk3McYAh9zmgJPug96YxUo+2uM7jm3bqwbXIv9BQ@nongnu.org
X-Gm-Message-State: AOJu0YwcxFcucgTqOWmb6vmJ0PN4QovvUvz01Tq8awCjwAHWGCaTVtz/
 sMNYzLE6j6QzmpDl5d5hChRSuAd5gtGe+S09nyuDCxTTsTSpXkpIJX1ba01XEPaiIbc=
X-Gm-Gg: ASbGncvoO77swpQA5/B4uy85MOrvfkUfG8CYVfd3vYV8KWXH5jMjFbjkPoZ6LjeoNGU
 j7pslv0wz1P5GEXDsXdwSa2jmmQhfMvGlM+3bJQB0rqsnmx92gwGn99SImAMIMRrsg9MSEVHMxf
 aIiqtVeT2IpD46nOGp2gct//SwbwYk3sAxEwg2ZiuXV9zmXIN06c9k5ik5IAnDd0PmyvsoUU2Ab
 1LlqZ69nBcTecfli/kZS8U9Meofc7yNttvjkCZwpXnrE3Ag74sEawHjiszV0nP3eLDHX1uYRJMX
 fz3uI7R+0SFYfIpuQe2cSW5SpB7YgTP3BRbO/o3v/ydZTzumEE34IfzWH+HKg1WP4rfEOSbfPPy
 fxLYnkQWQBxzllXv3QF2zgN0gJw7cVI1Z5C9dCB1TDrJNbxenomWbOwMhs8ePwYRM+fyNPFFJyV
 Mnr7q8V3vqrq0o6t4X6ExhRJ/gxNh9HK6vASZ6mQmbnx7dVhFQs7RYpg==
X-Google-Smtp-Source: AGHT+IHRFmD/liqQCFowP60BnbhJcbHp9kJ8YgR4SgjXdQGLlTpBvnjjzkHPZ5SPAoYd8A4EhRMlDA==
X-Received: by 2002:a5d:5d12:0:b0:42b:2e39:6d45 with SMTP id
 ffacd0b85a97d-42cc1cbd047mr11715155f8f.15.1763986488883; 
 Mon, 24 Nov 2025 04:14:48 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cc231dc6esm19814249f8f.7.2025.11.24.04.14.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Nov 2025 04:14:48 -0800 (PST)
Message-ID: <96b3e13b-3145-4acc-aee4-5d953c1b5107@linaro.org>
Date: Mon, 24 Nov 2025 13:14:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] Rename LOAD_IMAGE_MAX_GUNZIP_BYTES to
 LOAD_IMAGE_MAX_DECOMPRESSED_BYTES
Content-Language: en-US
To: Daan De Meyer <daan.j.demeyer@gmail.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20251011081553.4065883-1-daan.j.demeyer@gmail.com>
 <20251011081553.4065883-2-daan.j.demeyer@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251011081553.4065883-2-daan.j.demeyer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 11/10/25 10:15, Daan De Meyer wrote:
> Preparation for adding support for zstd compressed efi zboot kernel
> images.
> 
> Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
> ---
>   hw/arm/boot.c       | 2 +-
>   hw/core/loader.c    | 8 ++++----
>   hw/nvram/fw_cfg.c   | 2 +-
>   include/hw/loader.h | 2 +-
>   4 files changed, 7 insertions(+), 7 deletions(-)


> diff --git a/include/hw/loader.h b/include/hw/loader.h
> index c96b5e141c..24b91ba02b 100644
> --- a/include/hw/loader.h
> +++ b/include/hw/loader.h
> @@ -80,7 +80,7 @@ ssize_t load_image_mr(const char *filename, MemoryRegion *mr);
>    * load_image_gzipped_buffer() will read. It prevents
>    * g_malloc() in those functions from allocating a huge amount of memory.
>    */
> -#define LOAD_IMAGE_MAX_GUNZIP_BYTES (256 << 20)
> +#define LOAD_IMAGE_MAX_DECOMPRESSED_BYTES (256 << 20)

Maybe also rename UBOOT_MAX_GUNZIP_BYTES for coherency.

