Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A2B1CFD313
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 12:31:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNVTi-0005PK-Ek; Mon, 24 Nov 2025 07:15:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNVSA-0004BK-Et
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 07:14:07 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNVS7-00023Q-I7
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 07:13:58 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-42b3720e58eso3242509f8f.3
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 04:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763986418; x=1764591218; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3ZRVkQe6ilkOsEr1CXYcqPV7oTc8hFPfQ5cblOBGK/c=;
 b=OHr3T1E1OM7rXOrHx7ct1I/9LKWMF0t6aCMq5x4grIiI2/luvEU8bG04pUJuv588xO
 DFXzlygOTfxbfIjezjee6mz3u5gi2TGJh2CkVqL7F4YWSloKf7Na67CEYVLWMkfECZun
 8qKYii5tei5kPoE2DrnPb4cIILDUHiyvkb5tuukllTuRaW/i8lAFqLGK3UqfDtNb1rVM
 A43uBTWC9Ngt7g9U2hQI6ronUHYcsOmcX3kIasuUXtTizPIGM1MGaJ1GnKutRZhlniPk
 pFLKCSF/Mm0sl7J1ND6/FPmIR2UnV5dUFv028OABTTrD5cWr8GalKZRl3H9zfBo+xHI3
 x/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763986418; x=1764591218;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3ZRVkQe6ilkOsEr1CXYcqPV7oTc8hFPfQ5cblOBGK/c=;
 b=aMQlMhSFsjCPN8p7NzOEmNy6OydQ3QZ/B3qjRnwcaf+7lJSbhtIpI6ouwJD2qfz1ZN
 BGtHtYPkQUW4MZL/4f6X3S50WzHJkN72/ijbPfuLIiB6mEED6ZcxZ3u3SJ7ozVQhkt2b
 Z7pJ8wdz1tNF4skjej4BAPhVwxPWg2G8z4oy4fbr5jY5lNStNOUfqqiC97a/rPzmjpvq
 WlHiKB4isgYCe47ck7q+FbPxk8eJzrY2CiyvrIchukZkFW/zElRynylFZcrbOmdzY759
 g67muoCD01dvOwm6lHUuWEzsVvuI4Z0LYuyeDYMmecl32JT7kIH/pWdhVZFpnd8cNUgk
 4yAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSi7XURvM/vAlXHa19tfRdfVXKeqKeFiN/kmSGSaNnh6skzrcE4KconTaYp+SbEfD0EaLl4gfI21uh@nongnu.org
X-Gm-Message-State: AOJu0YxzjMs3iXwX90uwmkDN4UxzC1x6PKFOm44+LXuj6i0jNio5qY/S
 cXp2upHHZS6dUuMuhCCi91dixmAcgX4bXrDHOostw1+AXbrWvbMF3jCRbi6lWTQJeNM=
X-Gm-Gg: ASbGncvWPIFRpVCtL4bPzzU/LE6PMkt+Ob3Ce+rSfufEJYlIoAaCalNaxaaxr2woOk4
 6R9YyHHWs5qyN9fSNG3WwBfdBPF5+QXIIiJg+jNn50P2uZj0k2hSfoO9PWSFH27e7oZB/ROVtOb
 i4NiOxOZTJ2FxCizquOJvGvFFQdtYEpHBr2JqzCvg2TMxyjPkci/qkIcg79OaAalZ+AparIaqUt
 os9ZMy8oR2ZtWdkVIvZ8UmxzNQ2B+GMk1fIiIWobsUxyEnvqccnwCUJC8Cq4xt5v7lQ+ZwFfduH
 BSKqSQxBquKflOqlByAgOhNQhcxChDC94Bzy+mgsVnpgZVctQ4qSGTatTH8SXXNiokh6S+arCOr
 GZFkmhchBehi00JVSRxKVTzC6OysHKI9zvwhHMbnpudlByVI6QYY68KHpm6yM2rkPikvyyv20mt
 tQ4nApdA5ce4L9PfXivlhkVCCuZX8bPHfPjjMahQwaryZOPS9ve6FupA==
X-Google-Smtp-Source: AGHT+IGgAjoYiegnohNMZGEuTlFRGqrx0uu3B5zuzQmKFlPK5MfZDxiLUXpOi/PkzY68TA1eHQD0ug==
X-Received: by 2002:a05:6000:26cc:b0:42b:3c8d:1936 with SMTP id
 ffacd0b85a97d-42cc1cf4f69mr10368528f8f.26.1763986418219; 
 Mon, 24 Nov 2025 04:13:38 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f34ffesm28846052f8f.10.2025.11.24.04.13.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Nov 2025 04:13:37 -0800 (PST)
Message-ID: <ab955a8e-e96f-4071-a956-3eb7389c151c@linaro.org>
Date: Mon, 24 Nov 2025 13:13:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] Add support for zboot images compressed with zstd
Content-Language: en-US
To: Daan De Meyer <daan.j.demeyer@gmail.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20251011081553.4065883-1-daan.j.demeyer@gmail.com>
 <20251011081553.4065883-4-daan.j.demeyer@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251011081553.4065883-4-daan.j.demeyer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
> Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
> ---
>   hw/core/loader.c | 30 +++++++++++++++++++++---------
>   1 file changed, 21 insertions(+), 9 deletions(-)


> @@ -899,7 +896,22 @@ ssize_t unpack_efi_zboot_image(uint8_t **buffer, ssize_t *size)
>       }
>   
>       data = g_malloc(LOAD_IMAGE_MAX_DECOMPRESSED_BYTES);
> -    bytes = gunzip(data, LOAD_IMAGE_MAX_DECOMPRESSED_BYTES, *buffer + ploff, plsize);
> +
> +    if (strcmp(header->compression_type, "gzip") == 0) {
> +        bytes = gunzip(data, LOAD_IMAGE_MAX_DECOMPRESSED_BYTES, *buffer + ploff, plsize);
> +#ifdef CONFIG_ZSTD
> +    } else if (strcmp(header->compression_type, "zstd") == 0) {
> +        size_t ret = ZSTD_decompress(data, LOAD_IMAGE_MAX_DECOMPRESSED_BYTES, *buffer + ploff, plsize);

(here I'd re-use a shorter local variable instead of this def)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


