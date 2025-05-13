Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AC43C3ABCC
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 11:09:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEnVR-0002OP-DO; Tue, 13 May 2025 07:09:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEnVK-0002Jw-CK
 for qemu-devel@nongnu.org; Tue, 13 May 2025 07:09:00 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEnVI-0005ug-Ji
 for qemu-devel@nongnu.org; Tue, 13 May 2025 07:08:58 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43cf257158fso37630965e9.2
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 04:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747134534; x=1747739334; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LnRcTybKUxrr5z6fnxUHVuT2vUkU76VYAdVQcjOfg/Y=;
 b=pZfw+SRJSupU4gPZeu6GaXe2Aje16fqIcMK57ldRSO29v61sv29UYqX93qY9GAM0Ck
 /JcCuXHyEl1tjRHj3JzugYG/PNaj2dMhXFTDO6UY3C3DQV49wOc5q3DjTFHWLgpQ2mW8
 kRSW4AdG8cQIYI+Tw4A9uv+Vko0rlAL0qhBp7NH9Z/WC99Pf4Q1TkGtrTdzOeHm7O6Pn
 l5dI6J8BF89/JzJ3RTVx+LnMJqxgHAcBRg3vdJYnqWTxYwgKeGC3dIS3Nh4weYeeeSfb
 6L0q8Uw0mPfMBvzB+Qpql95OQitIjUWcZmNE/inUYls1yhMadzVpuK5lnZzWp1tFQ+uh
 sDOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747134534; x=1747739334;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LnRcTybKUxrr5z6fnxUHVuT2vUkU76VYAdVQcjOfg/Y=;
 b=pNHuuHYxHXJqkMKp5et4Fp3wvny1a83R7ZYOTg1GSKqbMNa0ObvPXsfx1/v/zN5cdg
 w2xVfL9HSKZ2pqWKQV7DOkwR/IOU2NSzED2ZKRwaiQYlODd43SAg2SeeTC0JmKb4Q4fq
 Yk8wkvIrLCNvOLFdxryrfAjsLGlbZPaKz68BxydcevVXksHFwpoO0XAQsvJ9xrJ9+Q4g
 xtAvD8aB3vCxWn8822wl4XOjOvs/bSOt+fZXrOCZ3L3OJNvXGFD5raF1bse3PRZeD1IQ
 1MZNUghM6+Vqfgzke7Q1rf7zuXq5DZ78DoedHoStf8xTeNK1REIkpHzmZImFE8qI+4rn
 HRuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTwiKfZgyBpY5Dw8VUKOTrPnxUfjt8ESehXQoYuDlRchAKqY8hOtK1L0bc5FIrbs9mDtceqhLFssGw@nongnu.org
X-Gm-Message-State: AOJu0Yx9qAFbC4mx/3DjAMg4NU73b0js7ZFJhYaDolM8e833OlcKe2ze
 4JM5h8ug+bFLd3rujn51svLn+U801EfNIoLJWJBv2pALbOCXLouGIcBA7zI+zq8AK3AWUux8s+8
 Ij1mPq4Ds
X-Gm-Gg: ASbGncu601apwhSUHSUaAd5ohsIOxXnt5WC29e5UvPxqpG2aA+Y2WuERysKw7OSpLPa
 +CjwmbqdHPYkynK3y4t4QLux0A4QE+SRPReusmU9OjZn1VyRwfSFTKR4W/gNT2GadoRluJZkD24
 8GGs5k1C2XsSeY6Bn67c2rrqZA2SC09wSuoKPdpPisJ9vPdfZiT62YVDm1aWsKHTIW51nD0iGU1
 WaHP+wIxxDK8rYVzOGU2QYro+DNsUugbWCSSHG9gigoXh/D+E1gGUqu4E6ECrIKhX0ofdjFfTxc
 sdL7cb2FmDbokdoK5HIYtIQ2Tx5iD6JKI4a1/I1LJOyadlcR0S6JSaEaiD+pYGfzoLByBIdggzj
 /1CWDzJB8FFCY
X-Google-Smtp-Source: AGHT+IEgVsUV9W3vN1/TtxB0dB94rAygZzaISbXyiUTVzP15Bw4G4/SvDORoiIsD/wwcmA0nf4946A==
X-Received: by 2002:a05:600c:4686:b0:43d:a90:9f1 with SMTP id
 5b1f17b1804b1-442d6d19170mr132258325e9.6.1747134534551; 
 Tue, 13 May 2025 04:08:54 -0700 (PDT)
Received: from [10.61.1.197] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442cd32f238sm202984135e9.11.2025.05.13.04.08.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 04:08:53 -0700 (PDT)
Message-ID: <6c9f7141-8b2e-4b58-9ade-134a7289cff6@linaro.org>
Date: Tue, 13 May 2025 12:08:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ui/vnc.c: replace big endian flag with byte order
 value
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250513100819.1179249-1-berrange@redhat.com>
 <20250513100819.1179249-2-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250513100819.1179249-2-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 13/5/25 12:08, Daniel P. Berrangé wrote:
> From: Daniel P. Berrangé <berrange@redhat.com>
> 
> It will make it easier to do certain comparisons in future if we
> store G_BIG_ENDIAN/G_LITTLE_ENDIAN directly, instead of a boolean
> flag.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   ui/vnc-enc-tight.c | 2 +-
>   ui/vnc-enc-zrle.c  | 2 +-
>   ui/vnc-jobs.c      | 2 +-
>   ui/vnc.c           | 6 +++---
>   ui/vnc.h           | 2 +-
>   5 files changed, 7 insertions(+), 7 deletions(-)


> diff --git a/ui/vnc.h b/ui/vnc.h
> index acc53a2cc1..f2a627dcdf 100644
> --- a/ui/vnc.h
> +++ b/ui/vnc.h
> @@ -323,7 +323,7 @@ struct VncState
>       VncWritePixels *write_pixels;
>       PixelFormat client_pf;
>       pixman_format_code_t client_format;
> -    bool client_be;
> +    int client_bo; /* G_LITTLE_ENDIAN or G_BIG_ENDIAN */

At least we don't care about G_PDP_ENDIAN ;)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


