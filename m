Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52AA4C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 21:33:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukUiG-00080O-Jy; Fri, 08 Aug 2025 17:33:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ukUi1-0007yZ-NP
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 17:33:07 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ukUhz-0001dy-Qn
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 17:33:05 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3b782cca9a0so1520674f8f.1
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 14:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754688782; x=1755293582; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P6vtIbjJugbMa6cc8YbLP0liYghcGoehc4SNjXxzWts=;
 b=b61nhhAcHI8z59EswrE4eVPBUhG8xUzx+NcFxVjo45r0IrAB+es5hCt0Gj7p/mbRNx
 vaLH2Iq0myx9hmCuxIUOW5XLSGSb7ZBAW32SVVCM49wn1g6+voJwvTzOnKfiZj9ti+vg
 TWXl6aBZyDYPM5Ym9E64nX5cfknN/bt+xy9+j2/g6E9hsOlW0vqMgv2b3Uxj2lvQdMUm
 w8I0Vfw4tMGtlfcHuMuLgt7qlUCSxKiOvrf6v82qiKOuw0DPP9VN5uQlebNVLrxtRsTi
 glzdbGR/ckadIRzH2nqS5jxoMzYs5FuvN/l+4/EQ98LeL3E/2tk8ENvTqNAtWJYRPa6v
 BcYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754688782; x=1755293582;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P6vtIbjJugbMa6cc8YbLP0liYghcGoehc4SNjXxzWts=;
 b=E0IinHyKlCxkPPNuyXx8QkaVm6rZMnNmlC1CE4vMnsctGtbcHZYxIya0T3k2BHsd42
 dJdU/Z5xEBtZH+ef3yuhcbTNYHYczRnTujb1uEXzfSp515zrtgUjbPUn8IbzLfXN+bT3
 Bp48l9L2RaA4zKyb3LxVAvLgq4E4eg1dznfy6/PtdeBaU4+HGg1+2L34FHxXf86nfUuf
 ri80hlh/tG5m9odWnIR5SvCYssg6BaNGYG6PKIBcd5KJ6RKQzKUV6uXzM1am3pj98SOV
 RsaphxOfAbyZ7UsHk7hafajVVWo96zYZk1eqxqGe885lpgASDzUwIgRm7m48phjK+59U
 OiWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhVtQIiNmMokfV/sXVGrHqyRjBZyH+vQc6OUwwKDHoRi/ZkCj2aRB9yoWB2lY124mYtjWpTD3q4d8j@nongnu.org
X-Gm-Message-State: AOJu0YyrVB5A81rBj8IZlJcDEVWQst4mNnc7dUw1TXyMalwzghRWyA5Z
 89Nh7WTssFngnlpMXzDElmnJYxiz1lHd/uYZiGo+lqFmaHu/XWZCiS1iucCkxs4DCL8=
X-Gm-Gg: ASbGncuYmzHwzxcivDwjMro/Y3yVsdecHFhhWo7nA6VUB5Y/cPvFkdmkRXzbdHE0Isf
 9KzIl1zIu8UF5n6MBiI+dPEHHiKDx6b6cenXgPMrGN/BTeYI8wRmxcesh5t485UuyCChcl1CNMg
 sBjGPK+g/6siA0nBEWCTNr/Iqss8yRy0/LF2mPyMsS79T00tQvfQq1KzL9bv7CIfeLUO5nNTR8g
 MzWQ/UfB8erHtGuwDBQBgSmzvofMsDDC42sA/yvxQmGLFrZ8ucIF7VWov6oqJZ3647L+lnaHQ6f
 +i8i1b/o7hiun7wLxMm8rycBmyILlYmYuF8a0YE3ng+VzbIL1cZkJ7QneoBFh4E79PBK6UemMCh
 9Eowzk4zMmE9AxN8AE3qzv+XD71BNsNbuT2hQGg4nmczbQ+/hneofmY9SYmbjNwgjcg==
X-Google-Smtp-Source: AGHT+IFj2ih2wa4/xR19BdtuyBoyFFX5V9cm3oacPDtMreDNeE3w69wiLUoBPc8ye6UbiaVa98sXvQ==
X-Received: by 2002:a05:6000:2c01:b0:3b7:9ae0:2e5e with SMTP id
 ffacd0b85a97d-3b90092f881mr3961871f8f.9.1754688782026; 
 Fri, 08 Aug 2025 14:33:02 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3ac115sm31646990f8f.12.2025.08.08.14.33.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Aug 2025 14:33:01 -0700 (PDT)
Message-ID: <3355c38d-8a8d-4ca1-95a9-bb6409c450c9@linaro.org>
Date: Fri, 8 Aug 2025 23:33:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 8/9] contrib/plugins/uftrace_symbols.py
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, rowan Hart <rowanbhart@gmail.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Richard Henderson <richard.henderson@linaro.org>
References: <20250808204156.659715-1-pierrick.bouvier@linaro.org>
 <20250808204156.659715-9-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250808204156.659715-9-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 8/8/25 22:41, Pierrick Bouvier wrote:
> usage:  contrib/plugins/uftrace_symbols.py \
>          --prefix-symbols \
>          arm-trusted-firmware/build/qemu/debug/bl1/bl1.elf \
>          arm-trusted-firmware/build/qemu/debug/bl2/bl2.elf \
>          arm-trusted-firmware/build/qemu/debug/bl31/bl31.elf \
>          u-boot/u-boot:0x60000000 \
>          u-boot/u-boot.relocated:0x000000023f6b6000 \
>          linux/vmlinux
> 
> Will generate symbols and memory mapping files for uftrace, allowing to
> have an enhanced trace, instead of raw addresses.
> 
> It takes a collection of elf files, and automatically find all their
> symbols, and generate an ordered memory map based on that.
> 
> This script uses the python (native) pyelftools module.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   contrib/plugins/uftrace_symbols.py | 152 +++++++++++++++++++++++++++++
>   1 file changed, 152 insertions(+)
>   create mode 100755 contrib/plugins/uftrace_symbols.py

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


