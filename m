Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A131210F6FB3
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 15:01:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7x4C-0002Nr-EP; Wed, 01 Apr 2026 11:01:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w7x49-0002Mo-Lc
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:01:09 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w7x48-0003qj-36
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:01:09 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-3567e2b4159so5116886a91.0
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 08:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775055666; x=1775660466; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GgBP1Lcqhiw4QPdrpjEPj+KcNR1W6AjeVi7pbyXZOY8=;
 b=B0jbLguzO7trBDAEOKSFNp01Lz23GYfNvdMPQlsTrjyXSFXDUbkhgG1z3i36MiPeCO
 lVBaFzVj9ddZoknRyjEE2BWbFC/XQzVH6D2l6kW9CXhvv3EPFAPTVJK/GV2i704NDEEm
 JicYw5duXVQH5HgA7srUjFgDa81ETlYfzCZeZWYOmPVkrlE0XzCqxBoSol7fGGkVJR4l
 NX6YvHfb0BY9ArOOXEAFOtAjPEMdb52C8JsUZMK6FqJq8q3QT/Xz6pYzDBezJctJTu69
 PeTt8WQ1JUvL1/s5Yo/+uMBZaecmiaEIWI6AYiWNaHSgh96ABloTPIHQIbyyXrWs5WDS
 5s1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775055666; x=1775660466;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GgBP1Lcqhiw4QPdrpjEPj+KcNR1W6AjeVi7pbyXZOY8=;
 b=KzWviHBh5LVRINusA6ZBTe9nx1OER6mOj2SCEOrw9wapTYDxk3bKiMLtu4/VCfCV8h
 d0l8mFA9jjYSQDjV7qz0dpAA62hZ0ON7lkPo8uhruUv2sZnjXUvK5EhwuwypwJyV83GG
 +x6Y28rkZOzZ0L4wZeHMveYvxDRRyIUrj33VNIMG9X2D1bmwRC2qejriIAp2pZh3awew
 g8QCXH41CjqK1kuxECgEX+ruAN/lfJqejVu/9u7WaG2/5flSrQ3QnDLsxZlLS8aPZvkx
 r1K430IXfJj98unVDrI67GhTGe4Vyf1nzY3ebuMh/er+r0ISuDrb7d5U1BZPli0r9SSZ
 RBOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZINO2TaP9s1t0/f9LPZITiiAUfi39xeN/tutojmK270Y+zUePdwwd/d5ZYkUoouEkPd8t0inPaQ77@nongnu.org
X-Gm-Message-State: AOJu0Yys+6Bqv4o8PvScKrYvEsixyRAsCR2S1+rg8IPYO6D+VBSdvfno
 6qAGytqPL8RyPEicYGbg80jGfwKxxTMCsNQ4rRiX6XvQ0TL6NcwGFvPnUIGkGHHohGs=
X-Gm-Gg: ATEYQzxBZ0h79QDirfRfhGktXK8HR2FDZRSKz3tRutYeDW6NIxikBdA55LYbdTFiGl8
 FokvK5/8e9iJlaNr6xi4O2n3Y3gPc+0IR3v4IY1nsjkMNpLYVkvTjjo8Tn9Kmx5hRZPbkRNHKay
 BaLlQcreYVa1eBoWEoxTNeZVMWIpnp5+C4yWRSLRDG+TMeZopOuYqAVMj2YRso1LZ/N2B3kpJXV
 UWF/ecYcR/qwpBLtOMlMQXXiv8+28QFeFjDIwvAXxJIKWQ04xa93ohXsvzdyv6eXIkwcUN4W16M
 S9UJZwMlJ+HJ9UWcHfUTKguRlrlylkjnNTho2qWYDSS5gx5CpDcttqxGx+0cX/7Srs/VLqU0/4C
 qTkXeiWNOoFy07JN3aYj/u8Z5uEMUEHfK3Ojky99MqEK80H0ZIPHOkI9Xs0JCHrBkkBwDjKlYTd
 jID3VnssZwI0tP7D9eHcRdkLoJxyffeISrxoENffNpfLjcDPHdulbEuqWJHumZmIFui+kO
X-Received: by 2002:a17:90b:5104:b0:35b:cd3e:c4ab with SMTP id
 98e67ed59e1d1-35dc6ef9ff8mr3897654a91.14.1775055666258; 
 Wed, 01 Apr 2026 08:01:06 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35dbba1415csm1938014a91.13.2026.04.01.08.01.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 08:01:05 -0700 (PDT)
Message-ID: <10255173-ecaa-4e49-8b1f-817ac3508e6c@linaro.org>
Date: Wed, 1 Apr 2026 08:01:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.1 2/2] target/mips: Expand TCGv type for 64-bit
 extensions
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Rikalo
 <arikalo@gmail.com>, Anton Johansson <anjo@rev.ng>
References: <20260401144503.80510-1-philmd@linaro.org>
 <20260401144503.80510-3-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260401144503.80510-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/1/26 7:45 AM, Philippe Mathieu-Daudé wrote:
> These TX79, Octeon and Loongarch extensions are only built
> as 64-bit, so TCGv expands to TCGv_i64. Use the latter which
> is more explicit. Mechanical changes.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/tcg/lcsr_translate.c   | 16 +++---
>   target/mips/tcg/loong_translate.c  | 92 +++++++++++++++---------------
>   target/mips/tcg/octeon_translate.c | 60 +++++++++----------
>   target/mips/tcg/tx79_translate.c   | 14 ++---
>   4 files changed, 91 insertions(+), 91 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

