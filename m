Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A598D66B9D
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 19:08:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVwt4-00046h-Ef; Wed, 17 Dec 2025 14:08:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vVwsz-00045R-BR
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 14:08:34 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vVwsx-0000LS-Nv
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 14:08:33 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2a0d0788adaso37798925ad.3
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 11:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765998510; x=1766603310; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MGsgEJD2SyR+AWVolmZTycppNh/PCxe2EmoUR9JEWAg=;
 b=cPXk/yQisy25KRU3TKhim8UcTSAgsiT7h5mSqgheimPwLXuFjhI2JreVcfm58I6O5w
 d3KTjG8pBoNoQIdTgwqEJwyig5tA2LDhL1cs6WO8RbZlfVqKlz6v0FBO7ueQkMkAOuac
 ARfhP7fnHK7v7dUQ9NR2kPw/kY58Qj8J4ckrxNKoXxPQXhHRgAbbrEsJEjU9ghZ2M3ne
 h+Yp+ZfmXFXjIGGiFE7SmF+EYP18ds4Ty+0f1yiB2/ZJ15ii4J1umj5zf6F7GkoDsOay
 cbGNGT/W+oGZtrl4D33HmJK/WN66jIcaGzo94C/O7oAKcPELjzMaIFyKpPxz5QGY4DSX
 3D5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765998510; x=1766603310;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MGsgEJD2SyR+AWVolmZTycppNh/PCxe2EmoUR9JEWAg=;
 b=FkIHys2bd4tO/WWs1aH+L2YtKdxwhcHTDjQE9mc0hMjs6krBGf7TP1BnBzH+Pt2D1l
 oEeIyjVENzJSqWQznkbXXF2mXathNd3gltXlneEy3P4bmInE7RttEkNLIDE5aRL14XY6
 KgLtRmXkFmCEcy/etdUHk/U/4J6UHWifRsZgo6Xl/hq0ZXC8X8qWeVR0cCk+iDsj52hq
 xVoFzPrmwRJl2whm5ZS6fruBFPvyE7otKC+r+sj+JmXCzbJo6HSJmscrR+D49UsFRj5L
 mqHHcXAwwN0zBZG8gQiNM8cchaiplM+X0DN60+WTM69S1x86cQ1EiPh0lTPVqj6xr6fY
 TEaw==
X-Gm-Message-State: AOJu0Yz369fndURpT0CBoDRzGKlsus/Rn5J/hAJslnhcKwwqnmyryLF6
 /NF20QzrtzvcGaFTb2zyH+oQ6L+TVqpEJengOsMOuN3UR7Q0JfYo1rE6WB46yFodAZfNOWJ3UnF
 YVKy34hk=
X-Gm-Gg: AY/fxX6aZu4R0YyN5V+DzBQpIET/V4QoiOqM8TgJcu8DWM/dDFgy+aQSNx2Rac/uY6c
 pa7iP9OSIbhqQNyKrTIiI7dj633LP5oPofUI5s5SbKKp1is97N0WDYl66vHxoDf1FGD45LbTvds
 ETbJME1nuTZE2h/WebvNKLBnzalfu3omRB//nASvx1m6A11LY4BnZ0qHKzML/xsl1MS0EgfOYmC
 /oSdiniFXi+32SsiRDHuMhBnA7nvUpwSzgSGrC/AZOhWaz8fx1FhuL6sDgERmsJVOyIGqEsxnn9
 Gfii7PYJML3MVJGDk0pyzPTOUNgDGFN2sGaDhp5K8YAh1TiOpnwn5Xpm66AsusUn4eoa9hKCnZY
 NfOmuRbRwLALW8NC5xtNFwfZVRIsAkImwzzDTbFI3bOPeHjoQzCSXrEZ/KP7NHnDuEpxgiGC9ry
 WBNyF53lvSJReRnmnX38FYPZOsoszV8A==
X-Google-Smtp-Source: AGHT+IHvRfe6JNYP3+5MkK/e+/i8d05tKCzmk01z+XBokyb3hsJI+m6d2a05tUUL+aYJp4g/tpRg4g==
X-Received: by 2002:a17:902:f789:b0:29f:2734:6ffb with SMTP id
 d9443c01a7336-29f27347628mr184370565ad.22.1765998509916; 
 Wed, 17 Dec 2025 11:08:29 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.245])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2d193cf46sm620885ad.100.2025.12.17.11.08.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Dec 2025 11:08:29 -0800 (PST)
Message-ID: <d59cb4eb-e69e-4f41-aa52-48c7a65b21cc@linaro.org>
Date: Thu, 18 Dec 2025 06:08:25 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/14] system/memory: Remove address_space_stl_notdirty
 and stl_phys_notdirty
To: qemu-devel@nongnu.org
References: <20251217143150.94463-1-philmd@linaro.org>
 <20251217143150.94463-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251217143150.94463-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 12/18/25 01:31, Philippe Mathieu-Daudé wrote:
> stl_phys_notdirty() was added in commit 8df1cd076cc ("physical memory
> access functions") as a (premature?) optimisation for the CODE path.
> Meanwhile 20 years passed, we might never have understood / used it
> properly; the code evolved and now the recommended way to access the
> CODE path is via the cpu_ld/st_mmu*() API.
> 
> Remove both address_space_stl_notdirty() and stl_phys_notdirty()
> leftovers.
> 
> Suggested-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/system/memory.h        |  6 ------
>   include/exec/memory_ldst.h.inc |  2 --
>   system/memory_ldst.c.inc       | 39 ----------------------------------
>   3 files changed, 47 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

