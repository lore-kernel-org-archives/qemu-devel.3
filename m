Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF279C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 05:17:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXvmZ-0004sf-Sf; Wed, 15 Jan 2025 00:17:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tXvmX-0004s4-Se
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 00:17:33 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tXvmV-0006oJ-QV
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 00:17:33 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-21631789fcdso5812515ad.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 21:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736918250; x=1737523050; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k0OB4DGPEA6i63DaI/pKn6f4GasbhrXIuHcu/vhDjeM=;
 b=AorhNwrfKadz0AKGr188i6VMKPC/BLVoyftbVfHD6oy0orm1SXhYFSyhKtooV2jqfM
 KXwJwV7XUItYLpJvLBwUdGzpKZyJTJdizcD64mGB3pExPWRAK80JUo15Vz9SMsjyNDtv
 TP9brI6c4N51XrR1F7lWKm2Uu845POO4/XUjM4E2p+Iu2I6vtBu3q1P1tMrYLPQ74w1n
 /eQVZTjEFrMWReji1raqBEWmlZ8IHrIiu3j3uhP4dbV7U5pCdFtnOZui3z8FC//IYzXd
 lwkvYPnCIfxj1MXuwB08/vBlchxXt1szmBO1gSSp3pf4JLXn+hm8ZE3oYW7Jmqus6l4t
 /DBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736918250; x=1737523050;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k0OB4DGPEA6i63DaI/pKn6f4GasbhrXIuHcu/vhDjeM=;
 b=RX7NC083vOk9iknelYu3KViZrL9u4ghRy91FrlEkpiquGPZslc15GukAyRmfG9uy1f
 YZTs3/cBGdC73pGSHFXRJxu+5YE1MGoYn1BLHu8Ugn858kJ23i7S5vHc2u+9914RQDDX
 ANiQC/KYiyd5N/eNm+do7xEHLaDTZ/90S+bFgzCy6aL+G/bxnXkrb+/Oz0/UUSIc0cNt
 Acg3ZsQzHIdgsmmJU6jMdcJLD4e9sjAkPUChBT42zjd7fMmeii351qGgaf0pI4B0uCOh
 Bu28T/JGmM7uTVJBH51SL0Ngs8Zy9jrqew97RS8vBOr2MUoz6uBwXo2jR5+Dgs3w0LRW
 +CVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKLj+eddxq/pMlJl7mdhIp0kNuupH1aQRD8pg13j6S/BbJr7pFTxjHE5BQ6qUXfAxsB/ZgfgK9FnuA@nongnu.org
X-Gm-Message-State: AOJu0Ywu53YWT0a7Id3F0GLSrbBaBoyQi9SZOmOw/phE6DDMemCk/pT0
 a7S6A+WdiZVsAslJH5TUo+EDg1NHr8A/i3bvSZt6RxKpm1TopoiBUQecuEaMLUwt8Ca0en76cNY
 g
X-Gm-Gg: ASbGncskJrJdfjL1iQn7TDnB5cAioyQ0rOXJ8ycFkoZs1fuyb3bGxWTvGjjtCpHJb4Y
 GSPn22oP86F5vglkkpvN72z6vq17sRNOWOQw8wvm3l+REqv0iiMvhq7oJ+IeMta7mpeK1ZssbIE
 V/hlrYowNwRCmv/cTMddIIKHk5oidh87EGSjK0YEOzelMFdkKpPOQEv9WKTCxabdv4X6Iac0QTl
 O1c3p1etwvTPZqbnELoEbZWP/38jNQIB518oHkNTmnwkZeq1rtydzHt4qDMcZhw1GtsrWTKCyw7
 aZ3O7Lg6QPkmyBH8YHKOn1M=
X-Google-Smtp-Source: AGHT+IHCrtKGprhB+y+H3UeTn//BNCBZ/9JW2zO9CUsq26vsdPXR+nrCXTRA5QBhWX6s7rL054u+xA==
X-Received: by 2002:a05:6a00:4482:b0:725:f359:4641 with SMTP id
 d2e1a72fcca58-72d8c4a3766mr2511438b3a.1.1736918249880; 
 Tue, 14 Jan 2025 21:17:29 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72d406817absm8609216b3a.147.2025.01.14.21.17.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 21:17:29 -0800 (PST)
Message-ID: <f12ef383-0b71-4d9f-9bf3-80a4b1374e63@linaro.org>
Date: Tue, 14 Jan 2025 21:17:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] hw/mips/loongson3_virt: Propagate %processor_id to
 init_boot_param()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20250112215835.29320-1-philmd@linaro.org>
 <20250112215835.29320-11-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250112215835.29320-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 1/12/25 13:58, Philippe Mathieu-Daudé wrote:
> Propagate %processor_id from mips_loongson3_virt_init() where
> we have a reference to the first vCPU, so use it instead of
> the &first_cpu global.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/mips/loongson3_virt.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

