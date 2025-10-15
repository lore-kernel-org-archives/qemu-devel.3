Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CCE9CCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 23:30:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Ax1-0008Un-Jo; Wed, 15 Oct 2025 19:30:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v9Awz-0008Uc-H1
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 19:30:33 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v9Awx-0001n9-Fa
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 19:30:33 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b6a0a7f3a47so73425a12.1
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 16:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760571029; x=1761175829; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PebC4szHKqlev3/Mp2zb+nesOCEjB/5SOba7/2Fyo0Q=;
 b=DXStmIoNnLfXu/KHESddf1shOXbm12LKTKxF6p3HbL5LIHPBnD1V2MnAYfY21avKLr
 reb6IQ6rqNigjYAcbznnd9/3tw2AsbeM6aVmBiv2zjyPLC58KKd/thBNgHa7CUJ+R56S
 3nPJr1Q063JwqX+g2u2Nngm/B0sKzTIXXG6lU6tuixoyItOkZnQx8Pi0ezHTe0oXO1cA
 bQd02rYaE1nyDkU712uXg7oFWKCToXM1M5LyU7/ouFLL7tpwx+t6I9F5ukCyh/3xfBDI
 BE+4/eq5ysxTc1xCebZfwvdxyhOGyeWUsr3MJ/RGu+3bXVxLd073W0na+8j11YY1qsI2
 iCwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760571029; x=1761175829;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PebC4szHKqlev3/Mp2zb+nesOCEjB/5SOba7/2Fyo0Q=;
 b=M/vQ/NFF+L7+A6vAXhz4fj2/A1QpscbJ+XSsvB2Bd9lNvgC3IHCyT8JVGxwKfnMoB8
 HxQETCEKwiQjkHWR+sLDS6sx5D5st8dXfH7SxMUct4Km0uwDNCV9miY97cmTRX09sGY5
 lBXxZa1D1AwltA76eFLZLlUYIdDOvHx54fUoE3vW9NPMEM0Rm/HMMX1LgDLq5w7/NJuC
 +rr8q6X63+xcuEZgD5lTxqJvxa9yW2ZB/ks1xp0p8GoTU0ZsHDnZQkiZ0weKC40JdQxg
 AQO/1DZg2n1DtXmLjDmfdT9DXQAiPTe8QhNDyl01xA6BXNyOayBYM0OFcUAwyWt00kRa
 r99Q==
X-Gm-Message-State: AOJu0Yz5aAP2rmn5MaPDuKjxkPqUfSXrtH174hGUjlUnlFr4VWouInGC
 TU6rRePNi3KMO46sS+ijiruka8gbvXyEkOQsYjMS5um53G7yPtOojDmACz4mPj6JLqsXsEOGttz
 66PQh
X-Gm-Gg: ASbGnctsFRaPjhxUnpnLPgZaF440BQUCfjl5FB/5RlsFiAuGpC97OJXWTHtb4a9CBaQ
 omQX2CEJlU7kNsbmjUk+UdMHeomx5sUC+Ogs4SBJhG5kr4t4w6Uz+e1P+h0Z2i5JzA/pnrtqvoB
 pmQziki70zpKTG15hRfWlsrDHgZtKaCGpk3D/y613VqKM4FWg6JAk1YOuNLKM7y2xczd8mXs0FT
 X0P3po3A/50E+qeGmzjlI4OmvAgR0gF086ob8/rP6aRIzFKFDtJwgI0C2dYgzaocOt0VpYBWQn5
 OGEf99bDN+490A9MEuQ9kXiuVZi2/U5sgIi1th75zQZtmkhLTIROzJaHUehqNnvmthqLD/GsGXh
 QfNhpdiVN//zDcHV3+ggGd0rgKJZ0A3gwdrFWp37dXX3orCcU9b65yrcJ58Cc3f/OKWtP85RiZi
 wLL6k27CCY68eSiDty4UDRyozjEi8=
X-Google-Smtp-Source: AGHT+IGAphnQh4wC0hdn+r2AZRGcPtknb1bliiCJ+gmRsqVw/siGk/M4RBK3t+gFu5jLYt0i62Tfvw==
X-Received: by 2002:a17:903:1448:b0:24b:24dc:91a7 with SMTP id
 d9443c01a7336-29027402b4bmr403780545ad.45.1760571029498; 
 Wed, 15 Oct 2025 16:30:29 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29099a7b032sm7904675ad.63.2025.10.15.16.30.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 16:30:29 -0700 (PDT)
Message-ID: <43cca2d1-0db3-40d3-9187-1b06dcffe036@linaro.org>
Date: Wed, 15 Oct 2025 16:30:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] contrib/plugins/uftrace_symbols.py: generate debug
 files to map symbols to source
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, =?UTF-8?Q?Phil_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20251015232809.628043-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251015232809.628043-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x535.google.com
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

On 10/15/25 4:28 PM, Pierrick Bouvier wrote:
> Enhance uftrace_symbols.py to generate .dbg files, containing
> source location for every symbol present in .sym file.
> It allows to use `uftrace {replay,dump} --srcline` and show origin of
> functions, connecting trace to original source code.
> 
> It was first implemented with pyelftools DWARF parser, which was way
> too slow (~minutes) to get locations for every symbol in the linux
> kernel. Thus, we use `addr2line` instead, which runs in seconds.
> 
> As well, there were some bugs with latest pyelftools release,
> requiring to run master version, which is not installable with pip.
> Thus, since we now require binutils (addr2line), we can ditch pyelftools
> based implementation and simply rely on `nm` to get symbols information,
> which is faster and better.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   contrib/plugins/uftrace_symbols.py | 116 +++++++++++++++++++----------
>   1 file changed, 76 insertions(+), 40 deletions(-)
v2
--

- Cosmetic changes in commit description
- use os.path.join to build paths

Forgot to apply the:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


