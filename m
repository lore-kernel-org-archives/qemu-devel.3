Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE6B4E81BD2
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 09:40:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq6h6-0002NF-CF; Wed, 11 Feb 2026 04:39:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vq6h4-0002N4-Jy
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 04:39:34 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vq6h2-0006j9-LL
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 04:39:34 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4805ef35864so55838785e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 01:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770802770; x=1771407570; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gdOC9k4KLjszsSPdQZE10FO+nuDq3jGpm6A17I3VNEc=;
 b=Ny/TZ/DTYmMgp1dQXCYhTssBUqAXn9qYCIaA44wGBt+of6CHfBCHnemsJEaiuu0efx
 q5v0qkGT1kzv3Skf/KTP54r4El7KRWa0NZgRmnjeGJUjPoa7C1wDghORzyZ9soxIDsdA
 hNlMTKRVV1UqSeMr0V8ndziiIVsxHO7yceBR+jmmjssOnHTwHNaobT14iFigmdc7smoJ
 jHhrNc4x6fOickQfa4FRk0WJEhHe5gQdU4z5xwB1l86a+7MGeZQxI0J/gjQM+gEiWax2
 nZyQX6diV9AOnLKgaJhtcrLiyVCsUKpktdgHYwJxVHBpiwnoXdA0pSAJ8Ne64SoOvriv
 26tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770802770; x=1771407570;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gdOC9k4KLjszsSPdQZE10FO+nuDq3jGpm6A17I3VNEc=;
 b=LbeTtoC7IM+u89ahIRA/MnL6oYpklRaBWgX5FFeruqLNbwNmQxvC8hDifgZ+vCyyal
 cXBZdYuxr6bp5UydgJ5XTV1fChUxmMfNfIQNFIS/CtSsh9GEbo+Jq0thS26VwwhDAVEE
 fX3vyj8shJqubr31zJFHtcesPchqvD7kWOU8WoaLkxCuZ43sg6I3RGRC9I4QWWIMA6w+
 n1KOv6WDG4GsTlKqHAXTOuV+MPPskqEt+WhkZ91Nfcdyk3ptq63yK3Bmpp40VcfsioDT
 54sbwD+zyo20NslCWqbRITvr5tOSKJiVcQHhLSqn+kxWzpmObIuB94JOF9R6emZlAbve
 trtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQb12H0F/S4ZxzIfsiF+xpiXtScy5K+jfKSDOmsTjlRcfvO6sf7wsiXKY90dDAqOmEyNDBiE+bc9xN@nongnu.org
X-Gm-Message-State: AOJu0YwJtqgbJP+l6FySHgpQgXwml921pq2ACrZm+jONie0TOk0IDzka
 2IaSTxY+YIG92YIpRDEu9LlanEi8UbFaNUDhaTLce6KC69hUp3ayI7mQW9DKhNU7scs=
X-Gm-Gg: AZuq6aI9jmxpbrbjaSwF2p23sQZ16gGmmbIPOiUplEV/+hDFqcrkg+1/wcJ2MZdXv//
 nz4z9Emov0f1JaXmzLg3YXv/sYvWTlTBuiFiwsnrLXco7PRy1svIE6TCb5z/NT56+XDydm2/rOw
 UrxMt+PYaIAgAO21Mw36EkBlGli5SgmjxF9LDqbBqr8XrzA+xbwe6s/u6fTUlt5drzvd4XGrI+j
 Bh0h9hyQqpHYq8at903wPMBM/Cb0de6i7MmzcD3Bfbbr5OHPpSIj17Zl9GENUXG4DLXOwQfOBZn
 DshxJQCkMsd4NssqWooTkSHl4EkShqUpi8F01xnTBLs1FSP90USRtzAEiBVpTfpxFcqHbflMQmy
 e7BA8T8CaDcWvtLXe2fsb4CQGkGLUhG4r30GLCh/w56YEskEkUw/s4KpAsLJOY3HAC4V+DE77Uf
 etiP0yf2iMyxcRh7OQ6CtmN80Daq2zyJAyxayb79/QTGcPu8lsKx426MrZK6Qxaokb1A==
X-Received: by 2002:a05:600c:34c4:b0:477:9cdb:e337 with SMTP id
 5b1f17b1804b1-4835dd88274mr18129015e9.7.1770802770169; 
 Wed, 11 Feb 2026 01:39:30 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835ba506cesm19173595e9.6.2026.02.11.01.39.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Feb 2026 01:39:29 -0800 (PST)
Message-ID: <200b3a26-530b-4a6e-91ab-18636e2194a5@linaro.org>
Date: Wed, 11 Feb 2026 10:39:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] bsd-user: Remove netbsd and open support
Content-Language: en-US
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Brad Smith <brad@comstyle.com>,
 Reinoud Zandijk <reinoud@netbsd.org>, Ryo ONODERA <ryoon@netbsd.org>
References: <20260210-bsd-user-rm-openbsd-netbsd-v2-0-3dd10091d359@bsdimp.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260210-bsd-user-rm-openbsd-netbsd-v2-0-3dd10091d359@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 10/2/26 16:46, Warner Losh wrote:

> ---
> Changes in v2:
> - Drop build changes from this series
> - Link to v1: https://lore.kernel.org/qemu-devel/20260210-bsd-user-rm-openbsd-netbsd-v1-0-8b8b0f50c29d@bsdimp.com
> 
> ---
> Warner Losh (2):
>        bsd-user: Remove the openbsd-specific code
>        bsd-user: Remove NetBSD supprot

(Typo "support")

Per v1:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


