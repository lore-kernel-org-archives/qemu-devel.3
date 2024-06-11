Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA954C25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 09:50:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGy8I-0002uR-TB; Tue, 11 Jun 2024 05:49:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGy8H-0002sF-J3
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 05:49:37 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGy8F-0002nU-QO
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 05:49:37 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a6f1cf00b3aso355349166b.0
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 02:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718099374; x=1718704174; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bkcLmgYjDVWjMZumxqVKMMvdKBARKZngVYrElYP/WJQ=;
 b=LZEEtfHZ90UklUzjpMrtI9WffUhxeU5CexvU9P6I3BOb07rCsx1l40GcZzHLhhHEWD
 aogjSzrmNdDN0uqLnRXLmkZgiPy+iPoUJGVyup9cFCwZ1mzpL30hAbB/FhzKMdfA2+bJ
 eNJWyhJh705sk1x5lN8I9eMfzvH9GHNPW5prwcbDix1n+dIXrIyEaFCsZ+IZhbVRNl6O
 8pfqXLX4z6MQ4U+GGREozxSmjeWwq/Ugw7kI7OUq5YlogwGjxsgiujsakX1VHof4HyTD
 kM3Mh48B9a7JKM/MKVd5hGs1WMHk0nX2X096Kxwt0fFxtyj71TKW3I2OGXxdj7YE3Vwn
 VDCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718099374; x=1718704174;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bkcLmgYjDVWjMZumxqVKMMvdKBARKZngVYrElYP/WJQ=;
 b=PFlvzdRwvRYfxJVvF2fWLS7kofF+xHeYihuP0LpJJd31JxE/37TCPhshiSuMjQY+F8
 pVoSUFPHCnqcfhrs31FxmduUGFiySqUSXr00D0UJX2F9JWzJoHqfPIJGcqLuTvjZlCJE
 qfkH/7uj61uFDSWcE2Vzx1fH6ercvG106SpZ9NdwAnSa4rGbpMHrPKZod0EZpnGRWmBg
 fzU1/If8E0DCQyhMvWWfU5svUjSo5lW0j3+fVX1sENvITA6ctrCC7dAI2Bu9pNULTggl
 byFPFWtD0UasIwZ0fs6uvYmGhMHFMf3v8yrtxTkhZ6GA5LALtY0BLPltsKFR1JytCQBf
 XJkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2adhyMiwEkgZYM1XTRTUI1v1gj+O4U2+MruzT1EwCZpSQ2nw5+wddNXRnESjML+ITfMQy7P7EoUYwjaFCioXdXchcsSY=
X-Gm-Message-State: AOJu0YyNiQz9HxLQr/0QPQ0laAwJlVEw0G2bkJ6ZKSvryBS73AWUTzkw
 3ej1Z4v8CBaSVvErYHEJrd5ullunAah1GZymudtBGyv2RGBTydD2J4qIt8EZqjM=
X-Google-Smtp-Source: AGHT+IEl4xpqvc8N2nBZR2IxO7bFXDSZOElDkp/fsSBT85Jw60k+SucU/bn4P+P9PR2KbLRvr2uHeQ==
X-Received: by 2002:a17:906:3688:b0:a6f:1a4d:5c5c with SMTP id
 a640c23a62f3a-a6f34c7dde9mr140073666b.2.1718099373612; 
 Tue, 11 Jun 2024 02:49:33 -0700 (PDT)
Received: from [192.168.69.100] (rsa59-h02-176-184-32-6.dsl.sta.abo.bbox.fr.
 [176.184.32.6]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f1c0fe610sm277382266b.91.2024.06.11.02.49.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Jun 2024 02:49:32 -0700 (PDT)
Message-ID: <100d2b67-18ef-44a0-abe3-c9cd0fa0d392@linaro.org>
Date: Tue, 11 Jun 2024 11:49:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] meson: Remove libibumad dependence
To: zhenwei pi <pizhenwei@bytedance.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com
References: <20240611092743.59255-1-pizhenwei@bytedance.com>
 <20240611092743.59255-2-pizhenwei@bytedance.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240611092743.59255-2-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

On 11/6/24 11:27, zhenwei pi wrote:
> RDMA based migration has no dependence on libumad. libibverbs and
> librdmacm are enough.
> libumad was used by rdmacm-mux which has been already removed. It's
> remained mistakenly.
> 
> Fixes: 1dfd42c4264b ("hw/rdma: Remove deprecated pvrdma device and rdmacm-mux helper")
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>   meson.build                     | 4 +---
>   tests/lcitool/projects/qemu.yml | 1 -
>   2 files changed, 1 insertion(+), 4 deletions(-)


> diff --git a/tests/lcitool/projects/qemu.yml b/tests/lcitool/projects/qemu.yml
> index 070d7f4706..0c85784259 100644
> --- a/tests/lcitool/projects/qemu.yml
> +++ b/tests/lcitool/projects/qemu.yml
> @@ -47,7 +47,6 @@ packages:
>    - libfdt
>    - libffi
>    - libgcrypt
> - - libibumad
>    - libibverbs
>    - libiscsi
>    - libjemalloc

You didn't run "make lcitool-refresh", see:
https://www.qemu.org/docs/master/devel/testing#adding-new-build-pre-requisites

