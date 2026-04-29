Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 216D8CCFA13
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 18:56:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIA4m-0006Pc-3y; Wed, 29 Apr 2026 14:56:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIA4f-0006MW-Hd
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 14:55:54 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIA4b-0005sF-Bc
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 14:55:51 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso629995e9.2
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 11:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777488946; x=1778093746; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BqPQKxxi/wwNTmXhStM1kPDyQtFRQ1mtzszwSk0pXzw=;
 b=euhp5P8znlI+liEYpbL1Cqx/2WP2TBCRitNO6Lm8mG/Hrvir+wwq3/g0o/yMzBvCzY
 L1zjqMc+LwdHIm4Ygdp7kYHbYrV4Iq1KsM81c2Zmj5JG9P/p7YntRzFBBElpRfNNKpKF
 0hz+8RaqNEOd1HkrzUXB7Mh9gSVqZ7eJDZE51wpEWSj8XZeu8MwpwDF9SiTD2w96JRCv
 dGBpoc07Rf3PT8TXH5iCK4qC2WNHdEpnfVA8uKAv2HRbXuYPY06mdUD6FZArHIUYX2+x
 OKAKNmZOa7QnyEyyfTrvKPyBcGksaE5cqmhP5d4lGl+6xXp4hx0fURVtaRALpbW1rWdi
 KlAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777488946; x=1778093746;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BqPQKxxi/wwNTmXhStM1kPDyQtFRQ1mtzszwSk0pXzw=;
 b=sStebtfjEC7ykcGycO//M+iBXBMPdJ23JShnH5spx0IE1pHE56/tr/gC0eml0hTNio
 DmlREt5cRYN4UORbwOWtrKw/t/TEWM3kEWBjOosKM0FPvN60pj+b++DXFptq2N7TuiL5
 aCjjQh/uwITN1pn3k4KpE/QOMsP4if8ukj2bmQk4RMO5Zd4WOz4Mdw2tg1nTYFNelLKb
 DFPNOrHE5Nw9RBSRp+ycmLb/SCtbRIVxJ1wDFsZxpj3tT32k+aosM8xP9ZUPGayMaz+X
 ssWjZsaWB/JNGWTchR7ELK8HYeW+gKXpc76yBXMMTAf2gU9bRZBlpJKpSWwAf/qVfZ9t
 Ntyw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8pH2WtQRU/p0sSHHKPYKtLFIEHVND7U3dPUVOIloOkvEngVdCtHkJvmE6AYi9bKZR+ztv+Llht/iey@nongnu.org
X-Gm-Message-State: AOJu0Yyr01cG+cFtTIsHjsqX6d6E/jQqt1BZcw4fabYOyQn4jPnRy0l3
 cpBA5ghdOHobbdvoaobTjiEBHtO3FHSquSaE82ESC8UXXG5tga5lVOiGABXpPaOlkgE=
X-Gm-Gg: AeBDiesSuwE3c1rhSOA9KwwRoaxivw/A5Dn5NrGI23j6lNEy5KbYlNKAYW2tYkcZtzT
 +SFHr8g/qfOKzxnCg2oxMiv4fa1UwqtcMAyXoz45C9OK0MEjbe/kSq3J207bFwxg68DgvZUlac1
 GW6IxzbhZ1Rwe7xI0TG7h/afZltzDmqYfhN6xeBZSZPnSfaN7XdFqzDCIRPmOaw5b2p/eYlrBYr
 z1bRm0YlpjtMcKTTryHe6Ujl0oqgnmfPBtoSQWC80iywEbaVywMw0rl5wC/mCHXdHoRbmWIiY2W
 n49NjYCi5LkpgLdJuLoC7WOmdvCf9Y2l1cjbEKGyrZ95RusaTROdXCu08np8wclmAay9a+A3NiI
 7JcSgfkUNSzwE8+W89bN5FAqjW8gjbyLa8Du1Xg3VVEdQgVi4K7oO1cjINm3YnP6+1nvaSDCW9M
 qxi7GLh5q3873S/XSDve9J5lu6EUco6zUCdRHgl/Ks03E/DS2LtZ+YwF/ssC3IK9ydW8VSUF3iU
 Bl1
X-Received: by 2002:a05:600c:34c9:b0:48a:53ea:1405 with SMTP id
 5b1f17b1804b1-48a7bfa1be7mr73608215e9.12.1777488946343; 
 Wed, 29 Apr 2026 11:55:46 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a820c865esm8980435e9.5.2026.04.29.11.55.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 11:55:45 -0700 (PDT)
Message-ID: <f17bb0b4-4287-41be-91e2-720dc6447f89@linaro.org>
Date: Wed, 29 Apr 2026 20:55:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 43/84] fpu: Return struct from
 float{32,64}_unpack_canonical
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20260426134002.865628-1-richard.henderson@linaro.org>
 <20260426134002.865628-44-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260426134002.865628-44-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 26/4/26 15:39, Richard Henderson wrote:
> We must change float32 and float64 at once because
> of the DEFINE_S390_DIVIDE_TO_INTEGER macro.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c | 300 +++++++++++++++++-------------------------------
>   1 file changed, 107 insertions(+), 193 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

