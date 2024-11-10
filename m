Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2183BD5E38D
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Nov 2024 14:00:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tA8Tl-0001H0-Mq; Sun, 10 Nov 2024 08:59:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tA8Tj-0001FT-Vu
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 08:59:48 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tA8Ti-0000qW-5p
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 08:59:47 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43163667f0eso31341275e9.0
 for <qemu-devel@nongnu.org>; Sun, 10 Nov 2024 05:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731247184; x=1731851984; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SBGdfqtnrHgLYzhkKDBqT3rjfZkSqsl63eHNj3sgu28=;
 b=bv0jkI0xYR1mX6YccGndeUCrNyF2Ip+DzI6IZbMIlyVqthJgAr+vl96fc+gAx0bFQM
 jLVnYjdWc4ZN65vxFs+STueW05MgBWmdFrTuo5JLi4J48Ss9lDNXemhs8UKZQDmUftLm
 fi3SqBp4jBHpmpR5Trg5MZ95vX4yFZySYaFMD3OGipxYXodoz+aBrFrcDwyxQ3F2OWQf
 QB4uMXWQOolhCwEnn8E75/YH3ftu6epp2upEoHOwzrFjfLR0nT++CdfIeianTa5gIZ4d
 4heCOk9UEWiRCQdNLWUdemJ02qsUk1AMlrsOD26uRgICfcQ4WdbQpF7xxGsbxVFO/arF
 eydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731247184; x=1731851984;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SBGdfqtnrHgLYzhkKDBqT3rjfZkSqsl63eHNj3sgu28=;
 b=aAtxQlVN1eG+yCGj7G/mcqJWLArLE6jzeWbHOuL9qQGikGCgbL1rhdSahtni3cALQx
 1Ir5MFiRuemi5W0p1Y1HN4xPuVK4kYGTYJCtA3AEgDIFd6suNsv0zHlDevodZxoxLmBv
 LLwLPdgshi5tkxRiCM6zazqnxfF2pRfrS0ikXKOsmNH3Q0CrRkhRKB8ZH4nXECXR/eI6
 BVNUqHO5wcl9JxrH/gKVKOGIg9vTu1rvHbdf+dwBLu5/amFxjDEgsbMXR826hBYhbTti
 Hw8W9emKMsAlGTiXtVcCvDupbQ7V0i5G8mXTCXb02thgCO3SAE3RmYNsIS3W7fe8Eyjq
 E6zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1HtS00dv95FFclZlS0lZGB0MMwuxo6uFSkrdQGslQjnfmOVaVJnP2JWh00oxCWpn2IR9m7G9vxd7H@nongnu.org
X-Gm-Message-State: AOJu0Yw8vjigb2IXMkjI1Y5qM9HbbQ3UvC1AdPzQV3HnMq2LK4pthQKB
 Bba6FSRGbaKtOBfoVcOfUiHjPFVBkuD58p0hqjq91v8cKz+mYVL6OALPmQSQEpY=
X-Google-Smtp-Source: AGHT+IEWTmVMbxzBnQnsPT1q2+ZcNupA05Gq5meX0dzmzj/Y+LrFKTJnOjIYcPGQ/2mk3JtUFLVMCg==
X-Received: by 2002:a05:600c:4508:b0:431:50cb:2398 with SMTP id
 5b1f17b1804b1-432b74fecacmr75924135e9.2.1731247184488; 
 Sun, 10 Nov 2024 05:59:44 -0800 (PST)
Received: from [192.168.69.126] (cnf78-h01-176-184-27-70.dsl.sta.abo.bbox.fr.
 [176.184.27.70]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed9f8dfbsm10591953f8f.73.2024.11.10.05.59.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 Nov 2024 05:59:43 -0800 (PST)
Message-ID: <aa360d5f-b4f2-4a61-a5b8-decc87a97a7b@linaro.org>
Date: Sun, 10 Nov 2024 14:59:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: CC rust/ patches to qemu-rust list
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20241109-update-maintainers-file-rust-v1-1-f4daba6f782f@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241109-update-maintainers-file-rust-v1-1-f4daba6f782f@linaro.org>
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

On 9/11/24 19:29, Manos Pitsidianakis wrote:
> As of CAFEAcA-ZQuyGTtG-vhRTEwpz0L4cpimNxkKix45Yw6gVHXozRQ@mail.gmail.com

"As of [*] ..." but I'm not sure about the usefulness of "like
qemu-block, qemu-arm, qemu-ppc etc but", maybe scratch it?


> we have a new topical mailing list like qemu-block, qemu-arm, qemu-ppc
> etc but for Rust related patches. Add a new MAINTAINERS entry to touch
> all files under rust/ subdirectory and additionally add it to previous
> rust related entries.
> 
> See also:
> https://lore.kernel.org/qemu-devel/CAFEAcA-ZQuyGTtG-vhRTEwpz0L4cpimNxkKix45Yw6gVHXozRQ@mail.gmail.com/

[*] 
https://lore.kernel.org/qemu-devel/CAFEAcA-ZQuyGTtG-vhRTEwpz0L4cpimNxkKix45Yw6gVHXozRQ@mail.gmail.com/

> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>   MAINTAINERS | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 095420f8b0..373176e445 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3338,6 +3338,10 @@ F: rust/qemu-api
>   F: rust/qemu-api-macros
>   F: rust/rustfmt.toml
>   
> +Rust-related patches CC here
> +L: qemu-rust@nongnu.org
> +F: rust/
> +
>   SLIRP
>   M: Samuel Thibault <samuel.thibault@ens-lyon.org>
>   S: Maintained
> @@ -4241,6 +4245,7 @@ F: docs/devel/docs.rst
>   
>   Rust build system integration
>   M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> +L: qemu-rust@nongnu.org
>   S: Maintained
>   F: scripts/rust/
>   F: rust/.gitignore
> 
> ---
> base-commit: 134b443512825bed401b6e141447b8cdc22d2efe
> change-id: 20241109-update-maintainers-file-rust-5cbd97b7b11a
> 
> --
> γαῖα πυρί μιχθήτω
> 
> 


