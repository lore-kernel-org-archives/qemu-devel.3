Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40414C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 15:46:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD4SI-00053U-Uw; Fri, 31 May 2024 11:46:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sD4SG-00052b-Sw
 for qemu-devel@nongnu.org; Fri, 31 May 2024 11:46:08 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sD4SF-0002eT-3Z
 for qemu-devel@nongnu.org; Fri, 31 May 2024 11:46:08 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-35507e3a5deso1513758f8f.1
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 08:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717170365; x=1717775165; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:cc:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bxlpUkILV1gjv8yhJgSUwa1ubBT+uvlQ6UKqmo0ocnY=;
 b=Q8vTIx/hCk34JwMjayiXKXqca0MUMiqvVjAFD8zZC7a8uoUFlsNNF7mNIDSYVGVWWx
 wCMKbE8zQ/h2K8k7FiJ9OkvFXetl5AQGJhe33Jkg0X4J4UuH9Z13JdiFe990MiikXiQG
 xigJf9fVFMG7ONG9VkKPIupVIc8K1YaJDirZVv+p1Sd/BGGN6OCmO/KdI5ebH+Bmkh7/
 Ykmwjr98J6b3XPXOPGrxYjuSpCEET72FjYOczxTaMg/1FA5cegTaDTP3+b6Yn2PFCRCa
 rRmn3990KVizLHzR5PzKXf87j1wQOdmTkSxlt8pBJYgn7HNPYpdDmLacOfVAMiDLsq12
 fUxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717170365; x=1717775165;
 h=content-transfer-encoding:in-reply-to:cc:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bxlpUkILV1gjv8yhJgSUwa1ubBT+uvlQ6UKqmo0ocnY=;
 b=YvXBgoXCuWwQm89CWHuaH2adMDdxgZTRDZSdkOJRCr1Pl1gl21Kee7CN1U4VFcTXBM
 K4YfgVmQj0s7WyiL8qUlpZs0i4Ye+KQ4sT6PM+67b0FEWnINq0qrhTSCtN0/pd8Dqard
 28mES5OQQbyU5SDcvZ4kBNKh62de8nAiydUDNHEMruvTk5LVEA2RWc6hzZmaG5ssMsyq
 VVnyGeEDTZtkCZJyfZQt2sdDgIyFE8bxPJ22r6WyMyXWGIT+4DWixQaMNtlvRpM6Uj62
 4vHni+f3/WkfCmpfrT1hzCNotISBd6ZLvNE0FuIL+WxqmSmRSS/jfYnkmnjkKBRJKCCO
 Uafg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWujjNdYXTg9rp8v7Qk7dfmEiahshcU+dDyThDhbTeuoJxSs2EaqKP2JEm1pA3UBndevOZAqh2ICsjxG4ISKM1r8OeQNDI=
X-Gm-Message-State: AOJu0Yx2PgTFFGRBzXm6IpV+Dp8hXPo2eSd5X6n68T/M0sY0uifM9l+A
 VJfodNpYFEaWQ8Y+uyzg9ZY4fdvSTFKs0F7PBYlOPWtBoCYBA51IE3sUGiDCjFk=
X-Google-Smtp-Source: AGHT+IGPwc0vCzgLgoNaIR6OBpwvW+/wH99WRS0l0sU1Ay0Osd9EmdRE4+EbKooDxMmNIOPnZdZvZg==
X-Received: by 2002:a5d:4745:0:b0:354:f4a9:b88a with SMTP id
 ffacd0b85a97d-35dc7e5fa9emr4742542f8f.21.1717170364796; 
 Fri, 31 May 2024 08:46:04 -0700 (PDT)
Received: from [192.168.137.175] (140.red-88-28-21.dynamicip.rima-tde.net.
 [88.28.21.140]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4212b2bc975sm30873205e9.29.2024.05.31.08.46.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 May 2024 08:46:04 -0700 (PDT)
Message-ID: <4b146ec6-bec2-4191-8c95-fc30d8307ef6@linaro.org>
Date: Fri, 31 May 2024 17:46:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] osdep: Make qemu_madvise() to set errno in all
 cases
To: Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org
References: <cover.1717168113.git.mprivozn@redhat.com>
 <393c7b26302cb445f1a086a2c80b1d718c31a071.1717168113.git.mprivozn@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Cameron Esfahani <dirty@apple.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <393c7b26302cb445f1a086a2c80b1d718c31a071.1717168113.git.mprivozn@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 31/5/24 17:10, Michal Privoznik wrote:
> The unspoken premise of qemu_madvise() is that errno is set on
> error. And it is mostly the case except for posix_madvise() which
> is documented to return either zero (on success) or a positive
> error number. This means, we must set errno ourselves. And while
> at it, make the function return a negative value on error, just
> like other error paths do.
> 
> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
> ---
>   util/osdep.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/util/osdep.c b/util/osdep.c
> index e996c4744a..1345238a5c 100644
> --- a/util/osdep.c
> +++ b/util/osdep.c
> @@ -57,7 +57,19 @@ int qemu_madvise(void *addr, size_t len, int advice)
>   #if defined(CONFIG_MADVISE)
>       return madvise(addr, len, advice);
>   #elif defined(CONFIG_POSIX_MADVISE)
> -    return posix_madvise(addr, len, advice);
> +    /*
> +     * On Darwin posix_madvise() has the same return semantics as
> +     * plain madvise, i.e. errno is set and -1 is returned. Otherwise,
> +     * a positive error number is returned.
> +     */

Alternative is to guard with #ifdef CONFIG_DARWIN ... #else ... #endif
which might be clearer.

Although this approach seems reasonable, so:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +    int rc = posix_madvise(addr, len, advice);
> +    if (rc) {
> +        if (rc > 0) {
> +            errno = rc;
> +        }
> +        return -1;
> +    }
> +    return 0;
>   #else
>       errno = EINVAL;
>       return -1;


