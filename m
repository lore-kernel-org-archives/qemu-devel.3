Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1513DC27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 11:27:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJAWH-0001UC-MM; Mon, 17 Jun 2024 07:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1sJAWE-0001Rn-EU
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 07:27:26 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1sJAWC-0003Ky-Ne
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 07:27:26 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2ebe785b234so41772841fa.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 04:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718623643; x=1719228443; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=JuweiNJFENCvFRlLMFOOuEoczdw5ZlaYJTV+EhmlyPU=;
 b=Jr32cep0JRNKUSHeHNm3CV+KHlH4NWEQzotLTC2xXQhOYp74/WJ602DHUTtGvOzE0p
 iN8UhXFx3f+shH6lWSWKuHDaGghs5VRMHI5ijWaLHrvV4hXkr12FKblfR7wrbFO9IgXJ
 oLdq1jP7Az5Hixw2QQcpR3+dyVAjwYlHLFC+ufTEuSXw+KE2NaV0RwImtBqC8RCHGF3B
 A+FXwB0LvkkM4Fy+f8K6YOAz4JVjO5N5/PeJ2Jd6I/7HV5uEDOPLFI0iU8kSmcWOgNzQ
 lP1c/PDnQ236kbcj/uEn3VnyKl+lQYKbPkGGkPxejSEFsFm/tyoO5r+V0+4829QpgWLz
 C80Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718623643; x=1719228443;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JuweiNJFENCvFRlLMFOOuEoczdw5ZlaYJTV+EhmlyPU=;
 b=Oo7b7E76rpoUCf7K5WAk0/1esmrGGbbEOW4LK0RCVx/b979wmcgemh9k6G8HfiAfQn
 BgfJjRHvY7eGL48zWVx5DktPu6vypAPS4zJ0kkQhqYr1kcSrf6tSrC8FDn9VjSVa9mRf
 mK+hn/06xW9RUHTKznqI5TP8EjUsgzxsY5p+XaqUnUitJBcjHPmeBJaAcJR+V4Qdykxv
 agyQ9mXADAAmjwoc/nCQu0s3Pqx75gPzbSA6j8/0F/rnr7VIcg1Mzgv2ykFXy63GEpdO
 02K237OB6rzbBD/RtRoqyZyldRTxHY+tsIz65MAgFqPK9c+2UbE/RLCgK5WKRG2exGn4
 ym4w==
X-Gm-Message-State: AOJu0YzyHR9u0Vb7E53VNFiaQ9pJASrmGm1KrYdalMy4EbFYhvTbCz8A
 VUAvBPDwRm5xwBR7A9KZGB7AqgTyTM55IOiGXjTshLSxnV7hyogEkaJU8bOU9aM=
X-Google-Smtp-Source: AGHT+IEkJVQpfc3fCqW38Grx+ajwaGUV8zh4iraL0e0nBOTcQBQIXeGRrBF7OvO3HhV8MlhOyakOAw==
X-Received: by 2002:a05:651c:10d2:b0:2ec:17c6:bbf with SMTP id
 38308e7fff4ca-2ec17c60f14mr53025161fa.2.1718623642732; 
 Mon, 17 Jun 2024 04:27:22 -0700 (PDT)
Received: from [192.168.200.106] (83.11.22.244.ipv4.supernova.orange.pl.
 [83.11.22.244]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57cb7439606sm6283809a12.90.2024.06.17.04.27.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jun 2024 04:27:22 -0700 (PDT)
Message-ID: <a896b9ab-8d49-4ce0-82f0-c40704fe0e1d@linaro.org>
Date: Mon, 17 Jun 2024 13:27:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] BootLogoLib: align logo coords to be even
To: Ard Biesheuvel <ardb@kernel.org>
Cc: qemu-devel@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>,
 Ard Biesheuvel <ardb+tianocore@kernel.org>, qemu-arm@nongnu.org,
 Taylor Beebe <taylor.d.beebe@gmail.com>,
 Pedro Falcato <pedro.falcato@gmail.com>, Theo Jehl <theojehl76@gmail.com>,
 Rebecca Cran <rebecca@bsdio.com>
References: <fcdc0626-a0f7-4796-a05d-2462c896f5ba@bsdio.com>
 <20240617083639.379608-1-marcin.juszkiewicz@linaro.org>
 <CAMj1kXEukirF7UZTRbdHCx-ppyX=7Msrwpw-b-OJpV33R8d0=g@mail.gmail.com>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Language: pl-PL, en-GB, en-HK
Organization: Linaro
In-Reply-To: <CAMj1kXEukirF7UZTRbdHCx-ppyX=7Msrwpw-b-OJpV33R8d0=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-lj1-x233.google.com
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

W dniu 17.06.2024 o 10:39, Ard Biesheuvel pisze:
>> If we draw logo at odd coords then BootLogoLib goes into exception and
>> boot process ends:
>>
>> Synchronous Exception at 0x00000101FB943E48
>> PC 0x0101FB943E48 (0x0101FB93F000+0x00004E48) [ 0] QemuVideoDxe.dll
>> PC 0x0101FB943314 (0x0101FB93F000+0x00004314) [ 0] QemuVideoDxe.dll
>> PC 0x0101FB92F798 (0x0101FB92D000+0x00002798) [ 1] ConSplitterDxe.dll
>> PC 0x0101FBA96BC4 (0x0101FBA8E000+0x00008BC4) [ 2] BdsDxe.dll
>> PC 0x0101FF7FDF50 (0x0101FF7F3000+0x0000AF50) [ 3] DxeCore.dll
>>
>> This change resizes logo from 193x58 to 194x58px to make it's sizes
>> even. And if coords are odd then they are bumped a bit to make things
>> work.
>>
>> Signed-off-by: Marcin Juszkiewicz<marcin.juszkiewicz@linaro.org>

> This should be fixed in the SBSA firmware

One coffee was not enough so I sent it to QEMU devel instead of EDK2 
devel mailing list...

> unaligned accesses are fine on arm64 as long as they don't target
> device memory. So this likely implies that the framebuffer is
> mapped with device attributes while it should be mapped  > normal-non-cacheable.

OK, so need to go through QEMU source now.

