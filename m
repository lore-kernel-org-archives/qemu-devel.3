Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B46EEA4FD8
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 15:29:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuXrn-000794-9I; Mon, 23 Feb 2026 10:29:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vuXrh-00078O-QB
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 10:28:54 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vuXra-0004bL-7y
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 10:28:50 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-82311f4070cso2669877b3a.0
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 07:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771860521; x=1772465321; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BflUOGO2dcVEM4Ee0/3WGOpxCbXUI0uGZ+hQkkW8b5E=;
 b=N3gZojaUudm01tAk03cNdA8FTbmyOBAT8yMOwEWfGe/LP9QhpN77kQHzGrJnVJk+11
 L6fdrybcyL7gMetqsA76y8U+spCot4hyagVl16/6mUjLCnX0sy2zz2J5F/wn+x/B9VHV
 jixK6RH3sxyYiGTO1N1iuHSWRIxwRihpcGf8qjA7C5d5jeLiiZVXJ54ISH/1ng+QNyPj
 ht1XdSsEDBpiZ3CLf9Fxpb3weTmlFRbD1+hKycoelAIrwintzxcQDxCOggt7QVP/qoYK
 caGjCTj3BNmKevLYhNX92ffh9q3Z5qVFGBAi41TyNSH9qaEeMhP0VC5DLb8w6fqPTFQV
 ds7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771860521; x=1772465321;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BflUOGO2dcVEM4Ee0/3WGOpxCbXUI0uGZ+hQkkW8b5E=;
 b=lD4z0R3N5rPEdoKULFpsH3G7nx59lLlyDNv6L/T8Q4bFE/ac/XoJKQxtqkPtowfVBU
 qzHEroTQhIiEfftamMo6jRmYQcrKHf0l9VYdO0DHKiRnjgYelYszbMTozkYlimifBsR4
 pieUdGSuy2IK5h4ChojbJNXKagMlwoE9XGkbmsk3h90lBcvEJL6iL7Cfnvg5F5q2oJo+
 DeMWz46iaiX/p+mQpFBhX2orMdq0YBGNMqBZU4fTxaxPy6danYNb7gGoY1FG35OMJBZG
 2aWeCEtqweSG6Bj2Gv5IvT/efJS6FvNDfZugcJ3028KITv/IdWZOvHmymc3MObR1RKS3
 YXYA==
X-Gm-Message-State: AOJu0YybGG4XCh3xGOa8TafgpGA/ua0elkfHXWVD3EAxQbOHKut6zOpd
 /S9tWWj4rRBvwl+PaAa1cv7RSGDAaby3ZYe4dmH+AmIJSJ80IMwAcFXkGm+reX1lz2hHyiovl6l
 0u6Mz
X-Gm-Gg: AZuq6aK/G6W8salQGLS/EDzhVUd+HUy4MECXP2Uwjz7LXIXTnLYKrq9uNdFSl5M8dne
 /y1kBX1DZ0AyBfX3SIDjxs+txJYex0HDZfEZozKylVhfK+2OxDMPUD7Ba1RBfdnj+7hMbv0aVgM
 MH5VS+S0wrWKDF1CVyGOY2SQi96nE21zUidVAOkipt+NivlmUKT05D+sjzVZwb4D/bWXLk9T4BR
 YFZq+fuTUGzlL+HSLbD7HhH9FwH+Heo2C+W8NwrO1ycb4oF7wb1zNyYOzqfvKb7IhJoa7/s5fWH
 jI1RUtW/h7LdFvp7ujG2K+AJuoYrsgDN7JTDnL3OrzLvQvhDR0oyaynjeDbgsjhgz8vMuEUY7TR
 Gefu2MPqmGz0dx8CXtHid6bQQzFonKOt34F+adELJJm7QYAF21nzR+2BsMbhrln9EpA5JFOvXXH
 FPnbi1mzbbDIuCpY50VaaKQ8e45AxIa25nsJW2fZZMuM/UmL1X/2yhMgCmuz16VVc6dij+
X-Received: by 2002:a05:6a00:6c90:b0:7e8:3fcb:9b09 with SMTP id
 d2e1a72fcca58-826badeec68mr10788289b3a.31.1771860520973; 
 Mon, 23 Feb 2026 07:28:40 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-826dd68d450sm7944053b3a.18.2026.02.23.07.28.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Feb 2026 07:28:40 -0800 (PST)
Message-ID: <d8778ce4-6850-44c0-be82-b62c046b471b@linaro.org>
Date: Mon, 23 Feb 2026 07:28:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] contrib/plugins/cpp: use __has_include
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, philmd@linaro.org,
 Alexandre Iooss <erdnaxe@crans.org>, jsnow@redhat.com
References: <20260214061025.1239457-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260214061025.1239457-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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

On 2/13/26 10:10 PM, Pierrick Bouvier wrote:
> This make sure we can include all possible headers without breaking
> build for environments missing them. It fixes compilation on openbsd.
> 
> We don't want to pollute configure script, as it's really a special case
> here to make sure we don't have a compilation regression with
> qemu-plugins header.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   contrib/plugins/cpp.cpp | 261 +++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 259 insertions(+), 2 deletions(-)
> 

This was merged into master (a6ec632dca8c7d10743aff29345e5e9e5324228b).

Regards,
Pierrick

