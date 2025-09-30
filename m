Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8667ACCA470
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 10:26:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3XXQ-0004in-8b; Tue, 30 Sep 2025 06:24:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3XXN-0004iZ-D0
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 06:24:49 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3XXC-00018Z-1M
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 06:24:49 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b40f11a1027so288980366b.2
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 03:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759227870; x=1759832670; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LCMNYUHa/peagYkFABm29rwZlc3WjfBvBAy0aJURE2Q=;
 b=U7u/XL3FyxoLc2hUWjDzQgMNjnQRKxo4ztGExm1vEpnHYFzGv4uE2XQLy+YaK5p7Om
 /1mscl2JWcW7g1Fm6c46xolu4Hws2sZodhhZlXhNpqMZLratPgqmMgAoP37TeSsyRCJC
 LzRhhgEFEEykZeqLatnmGokqJiR4YPqM2E2QGSj9CTRFCJ+j8xhVWeBxQKVaTqIJjll+
 bUOYPcpYS801dRW2Hvd2Mt3EJL0jHBzuagwX0votC+FNXhg+uXHz1IAfTPdS8Wg5uQzC
 z+LWhV46u7GXfMhEeNZ0zvMf2/64GulLgMLNWKqQTgJ/koPyeMkW9RE0wVufC8U5v58M
 ++NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759227870; x=1759832670;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LCMNYUHa/peagYkFABm29rwZlc3WjfBvBAy0aJURE2Q=;
 b=cEZeJi75LS9C/JkJWQG74AnzueTd/sBPh5/RR1a9v2OEEcO30t1qXEyuhtK+fYWecZ
 JEZNJb6MymYPZl/S1kfHZfOe5ED/OoY6euvvy3TdwDydX8bkjqwV2pRdA/TGpkmmn39M
 II5K1NwRIntrtHNZ7lN+zQLDpCpE9IzIprkwWlkLNWhH5bh+vC8geXv9AmPFx1CauuMG
 Sfp/qE9recg8gIAYyGXgBEPQ0ZPUFmOHw130fZiYlizLzVASMRc1nFwx7+kw+B0VBnP2
 7g5+rBOr/2XfutvhdxcBTogo60HaNkF0Hua6FIB9/7s0cCGfwUEt9m7Ouu7AjxvFOtnY
 z49w==
X-Gm-Message-State: AOJu0YyJ/xoGe17vrr/pIZTbhoaYFygpzIquzrZntVBRG8SPOdZv5xFf
 2vi9cIw1opIBTtj/8QM01XXnA3DmYq+j1oq2rFnNV0U0IfxtGUcDPuI4XVgql02wsmw=
X-Gm-Gg: ASbGncv1xTYKCZjjUb/yPfs1Zy7FWDkk06ZRNBGpc49iHwEPEea1qRWM7oFbxQDdgZP
 qg2YVrCjDjzZOvdbk3YVlb1pbrnNqRFYyw12YOO6FwqDfxhWmvarw/MouoJPsBgwjliJyH634/E
 il5I3PWcPH8izrbZTUxV5fdWLikNIZUCI01Q45Ch05qNLOXQJH0Soxx/ax8oYCTLl3mVq0niZIW
 Cp6lZ0eZKXmvHuNT3qPhM1+mdd3PCBMEj1dMlg2FrYeF+lQGA2/w5omsFfOhgGxdcVyVz1EYau/
 gd2Of7Hrlklhck4tBAfyXshW2hMII79gOLUP+WH099e/bp401WTw43hmPRaGZjiwQPvEsbumsqI
 QuyBooDqkkKI4StsXahfapzilFF7fDIJrVn70Ciw/E2T83Hi6Ln7ZXHi/KNCbCj9layTZJXlE5c
 OpAPa8OCEpdYfPt5rR/J/IINNU
X-Google-Smtp-Source: AGHT+IFP9NP3DNTJfE2NXrRXjynSEywOCwjluSRvlaKsYxZ/K77mnx1pnzmp4qEUH0pWvtj4BXEnNg==
X-Received: by 2002:a17:907:7fa9:b0:b30:b2e4:af3f with SMTP id
 a640c23a62f3a-b34b7fbb4cdmr2222260666b.14.1759227869513; 
 Tue, 30 Sep 2025 03:24:29 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b4054f0cae4sm296617466b.39.2025.09.30.03.24.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 03:24:28 -0700 (PDT)
Message-ID: <2ab5bea9-7ae4-48bb-a2e0-6a986bc06f81@linaro.org>
Date: Tue, 30 Sep 2025 12:24:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: microblazeel-linux-user regression
Content-Language: en-US
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 Gustavo Romero <gustavo.romero@linaro.org>
References: <aKtzmNHYSFwf2TQI@zapote>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aKtzmNHYSFwf2TQI@zapote>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

Hi Edgar,

(sorry for the delay)

On 24/8/25 22:18, Edgar E. Iglesias wrote:
> Hi Phil,
> 
> While trying microblazeel-linux-user on the master branch I hit this:
> 
> $ qemu-microblazeel ctest
> qemu: uncaught target signal 11 (Segmentation fault) - core dumped
> Segmentation fault (core dumped)
> 
> Bisect found this commit:
> 415aae543edad19eda8f66955dde386c7fd7c680 is the first bad commit
> commit 415aae543edad19eda8f66955dde386c7fd7c680
> Author: Philippe Mathieu-Daudé <philmd@linaro.org>
> Date:   Tue Sep 24 23:45:54 2024 +0200
> 
>      target/microblaze: Consider endianness while translating code
>      
>      Consider the CPU ENDI bit, swap instructions when the CPU
>      endianness doesn't match the binary one.
>      
>      Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>      Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>      Message-Id: <20241105130431.22564-17-philmd@linaro.org>
> 
>   target/microblaze/cpu.h       | 7 +++++++
>   target/microblaze/translate.c | 5 +++--
>   2 files changed, 10 insertions(+), 2 deletions(-)
> bisect found first bad commit
> 
> 
> It looks like we're getting the endianness wrong in this case.
> 
> This works:
> qemu-microblazeel -cpu microblaze,little-endian=on ctest
> 
> Was this intended while moving towards single binary?

Yes!

> If yes, I wonder if we also should change the default to little-endian.
> Big-endian MB is discontinued from newer Microblaze versions.
> I'd rather have to type -cpu microblaze,little-endian=off for big-endian.

I suspect it is just a matter of updating get_elf_cpu_model() in
linux-user/microblaze/elfload.c to not use 'any' CPU by default.

I wonder why our CI didn't bark, since we run:

  $ make run-tcg-tests-microblaze-linux-user

Oh, now I see, the log is filled with:

   SKIPPED gdbstub test $FOO on microblaze because need working gdb with 
microblaze support
   ...

So we aren't testing microblaze user-mode...

$ ./qemu-microblaze tests/tcg/microblaze-linux-user/sha1
SHA1=70f1d4d65eb47309ffacc5a28ff285ad826006da
$ ./qemu-microblazeel tests/tcg/microblaze-linux-user/sha1
qemu-microblazeel: tests/tcg/microblaze-linux-user/sha1: Invalid ELF 
image for this architecture

Do you mind sharing your ctest binary? (Also consider adding it
to tests/tcg/microblaze/).

Regards,

Phil.

