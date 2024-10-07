Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56C1FCFB45D
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 20:17:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxuAN-0000MQ-Sy; Mon, 07 Oct 2024 16:17:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sxuAJ-0000LL-Lg
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 16:17:13 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sxuAH-0002SI-VU
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 16:17:11 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2e077a4b8c0so3445105a91.1
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 13:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728332227; x=1728937027; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=St786buQsO75dMADLdmc+95fzicFJd8O1OHqR7TJ1M4=;
 b=RgzxqgPgbtkaspbKO58+WvayonEeS6T/s4nsyyOuQvJU+uJkeXeskwYHBYAAJMCQnF
 Ziw/MwC+xKhKr8Y3YsGXRUhKY7IMTwpTOMBDxr/1tobTFn8y0rireNMRzdgDEbWrkHQF
 oMM2tz+jQUY3vGyVoxxrhbIeVh8tCC8o5Vdgib6od+RobJPChP1SncJmY8w4sIP1mMXl
 qUtaLhoZvIlzpxhtkRwmzLJbtP7CWFgdUGNujQmhnpDewUYDW7bMW7L5zptt4ieJhkdH
 waSkxBeAwdInVSsyr7AY3tWiCJ21s4s4VdUBkDNZ6WXLakj+1MEnM5hMfkTsQdpPMzqk
 mdzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728332227; x=1728937027;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=St786buQsO75dMADLdmc+95fzicFJd8O1OHqR7TJ1M4=;
 b=rZGTOFEBeFfJ9xRqtnOmj4YolusmOWkeuQaRhrVA9kTnX5T0GzPgw4KxI/aI/VU7CG
 o8FVf6IuPJhe4By6xMWgPiMRUrkszIKveSYurn5/IVMVlSPvQ4IKP0bIL3wOJjAflK1e
 I+tIhRrKiikgISbRh4RYxeptve/XryAybtTOPA1CTyNDzvtzsegmOfD66XpslLaCjIZ7
 J0OI1WIf28MKLkitimLBi7t8nz0PVsugUzw/ryf8GMAaJfqzGodGyvbr15ct2LIZLNSE
 vRbkAhtdXwhM/CFihNtZLUe3RSYCKSLaUv7UOgmbZ4PLl8bE5UwmDX49rSFTjqXlIjd+
 c4Pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXsyy1IeUcgjS6PU15wF+WacBZMV1A4/7FnEu7WxkOO86aRbYf1bqzRoXNPTmvhuoT2WBGS0tjFj6X@nongnu.org
X-Gm-Message-State: AOJu0YxofQ7tXRj+nHuGuDU6N1Iy91tlEHA4G0glF6Bmd1RvckxkTwEZ
 493xWgcjePEIZVYaz+1sslJ6Qa/RKG4XQOT7PvtALWvAmy/KuZtAkrb0BmHQy14=
X-Google-Smtp-Source: AGHT+IGXVg0JMgSIbybRaJhXzlzU6e/z2qyY4OQ+E+3HHJkVD4G/Q6Z62cbBpXMxR2w3QRDtXmhTSg==
X-Received: by 2002:a17:90b:1204:b0:2d8:719d:98a2 with SMTP id
 98e67ed59e1d1-2e27dddfd58mr1252627a91.7.1728332227152; 
 Mon, 07 Oct 2024 13:17:07 -0700 (PDT)
Received: from [192.168.100.35] ([45.176.88.163])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e24deb58ffsm3264131a91.21.2024.10.07.13.17.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2024 13:17:06 -0700 (PDT)
Message-ID: <34a985bf-1105-40a2-9a4e-0367015adcb9@linaro.org>
Date: Mon, 7 Oct 2024 17:17:04 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] scripts: forbid use of arbitrary SPDX tags besides
 license identifiers
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20241007154548.1144961-1-berrange@redhat.com>
 <20241007154548.1144961-4-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241007154548.1144961-4-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=philmd@linaro.org; helo=mail-pj1-x102c.google.com
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

On 7/10/24 12:45, Daniel P. Berrangé wrote:
> While SPDX-License-Identifier is a well known SPDX tag, there are a
> great many more besides that[1]. This are around making machine readable
> metadata available to the 'reuse' tool and similar for things like
> author names, copyright owners, and much more. It is even possible to
> define source file line groups and apply different SPDX tags to just
> that region of code.
> 
> At this time we're only interested in adopting SPDX for recording the
> licensing info, so detect & reject any other SPDX metadata. If we want
> to explicitly collect extra data in SPDX format, we can evaluate each
> case on its merits.

50 uses, a third of them are mine, 10 different contributors.
Can be cleaned.

> 
> [1] https://spdx.github.io/spdx-spec/v2.2.2/file-tags/
>      https://spdx.github.io/spdx-spec/v2.2.2/file-information/
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   scripts/checkpatch.pl | 12 ++++++++++++
>   1 file changed, 12 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


