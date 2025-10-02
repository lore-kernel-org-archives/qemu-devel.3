Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB878CAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 08:34:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Ejt-0001PW-Np; Thu, 02 Oct 2025 04:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4Eja-0001Go-Gz
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 04:32:22 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4EjJ-0004NS-Tx
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 04:32:16 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-41174604d88so318902f8f.2
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 01:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759393915; x=1759998715; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pWLEfRH3b3O8URgyjcC95QK66qPzt3xBHnErdKNpXuc=;
 b=J8xIAJ+K/p/2RLxZg8404k60+pYW55usZhBRMwRF83LmDw5yxZ5ptdPpQWiiCvTsYN
 nchMBIXUKuvgJyevUgzxt1h7v9vKLvN4cuy6WLgRVe306OrALyt/RfD7FgDt8nwPf75P
 PnTbKBUhE1HIDpXbnQI9DkGhXi00lDFW7kdOCMAm95NIYen6PhZbCLs0OJPwjiWcKnT3
 Ipd7o+7QLD8Bzgk41+5MJN6bs3hfroDd7XhU7WoTQen6IeEqK0rKfsRE9x3akygKcOvE
 D3jNYSusWJkXHyLENYdqY9bFVy2F94IHCB5Bmw7Ntg4MFv0rXJh4G13qZgu05PVg/F8+
 7Mkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759393915; x=1759998715;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pWLEfRH3b3O8URgyjcC95QK66qPzt3xBHnErdKNpXuc=;
 b=BDtcnjLfpFl/g4RZ8TwliocIOGPBMXwlcfZj1tZGUc2kfILg6/w0AhxY/FofJuAeLC
 1hXQEHSiV6jX/LefiNl4g0pF8BNoW9lz/dARcHawPH5xcIz0aHbz3WKieD/9paMu3kEH
 UbsVtixHCStQ8ZS3TOSC8OuGneawtZWs0RvEb6CBofSB4h46EPtDqeVxsic/8glak9LG
 nGEnWi12pyzCN57xYcyTAhEMQEMBLjcg4Ca4SHfx+l6wRJ9m+Oiov4eK7vh6hav4rnZr
 xWc0B8RfV6F15gV9aEMh2Ns/fcd0LXmUmrQF0zHJqkDWBeuvtAYlR+hCT23NoZDbBWE3
 SojQ==
X-Gm-Message-State: AOJu0YxCA5naCKLtqG1KLy2Vmw1ygJUnrhfo+vHGRk6zrA9253fgzqfp
 acmbbRKvXUsbsUZepTVpyJJGo3pYLBrnlAHNFqNwDbDSQjqaWTfNvqUX18DxOlT1fN8=
X-Gm-Gg: ASbGncvnsoyCdUBoOPRxwxNu902ZIzpT/Nl1q8aS4bnzBV4ei1wCc/9YNsh9gtv2R5m
 vg6GlRezPWH65dN8qoX6dpDm0Tc1kY8U5Yb8UtGa8SV+z1NCh9a40Ek3dxL++/fLz1XJSj4wp2H
 PW/WgjybbhCEifI2YbvBFBWaQuBe5l2NQ3QEDl25CCeWaE9RN2omTaPGwS9qTkW4OV/PYPcj9C9
 hWEK/4jS/SzxmMM3bidX0d4lxvCpvBHOpRi3nAYNBZQCV9UXdEwgm34IdKn9XJy0aUq8tWItQGx
 PoJ+3+uJ4yWgjNyV633C26HzcrRAw+/Fa3Ardy5n0iACFjoZDX15L4u51vBL+ipuONL1IpqwZvP
 EoO+mcBc+LtPv2LLuW7Q8nRzZ44wdvg64bKwKr0AeLK2bE2KK9Oxamt4tBgMgN6habRVTV5XTLf
 Hh58W9iPWYb1yXUHItFscbRL8=
X-Google-Smtp-Source: AGHT+IGqD9mdTouFR8H+PynvxqLs05gtiQ1ngy/J9XckXXDrlr6CoAtdltbRsK71ZkoTsTKGj+vn/g==
X-Received: by 2002:a05:6000:1787:b0:3ee:14db:701c with SMTP id
 ffacd0b85a97d-4255780be93mr4038130f8f.41.1759393915154; 
 Thu, 02 Oct 2025 01:31:55 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8abe49sm2618600f8f.21.2025.10.02.01.31.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Oct 2025 01:31:51 -0700 (PDT)
Message-ID: <4ac13fce-76fe-4035-9b29-3b53f4b894b1@linaro.org>
Date: Thu, 2 Oct 2025 10:31:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: microblazeel-linux-user regression
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 Gustavo Romero <gustavo.romero@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <aKtzmNHYSFwf2TQI@zapote>
 <2ab5bea9-7ae4-48bb-a2e0-6a986bc06f81@linaro.org>
In-Reply-To: <2ab5bea9-7ae4-48bb-a2e0-6a986bc06f81@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

(Cc'ing to Edgar work's address)

On 30/9/25 12:24, Philippe Mathieu-Daudé wrote:
> Hi Edgar,
> 
> (sorry for the delay)
> 
> On 24/8/25 22:18, Edgar E. Iglesias wrote:
>> Hi Phil,
>>
>> While trying microblazeel-linux-user on the master branch I hit this:
>>
>> $ qemu-microblazeel ctest
>> qemu: uncaught target signal 11 (Segmentation fault) - core dumped
>> Segmentation fault (core dumped)
>>
>> Bisect found this commit:
>> 415aae543edad19eda8f66955dde386c7fd7c680 is the first bad commit
>> commit 415aae543edad19eda8f66955dde386c7fd7c680
>> Author: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Date:   Tue Sep 24 23:45:54 2024 +0200
>>
>>      target/microblaze: Consider endianness while translating code
>>      Consider the CPU ENDI bit, swap instructions when the CPU
>>      endianness doesn't match the binary one.
>>      Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>      Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>      Message-Id: <20241105130431.22564-17-philmd@linaro.org>
>>
>>   target/microblaze/cpu.h       | 7 +++++++
>>   target/microblaze/translate.c | 5 +++--
>>   2 files changed, 10 insertions(+), 2 deletions(-)
>> bisect found first bad commit
>>
>>
>> It looks like we're getting the endianness wrong in this case.
>>
>> This works:
>> qemu-microblazeel -cpu microblaze,little-endian=on ctest
>>
>> Was this intended while moving towards single binary?
> 
> Yes!
> 
>> If yes, I wonder if we also should change the default to little-endian.
>> Big-endian MB is discontinued from newer Microblaze versions.
>> I'd rather have to type -cpu microblaze,little-endian=off for big-endian.
> 
> I suspect it is just a matter of updating get_elf_cpu_model() in
> linux-user/microblaze/elfload.c to not use 'any' CPU by default.
> 
> I wonder why our CI didn't bark, since we run:
> 
>   $ make run-tcg-tests-microblaze-linux-user
> 
> Oh, now I see, the log is filled with:
> 
>    SKIPPED gdbstub test $FOO on microblaze because need working gdb with 
> microblaze support
>    ...
> 
> So we aren't testing microblaze user-mode...
> 
> $ ./qemu-microblaze tests/tcg/microblaze-linux-user/sha1
> SHA1=70f1d4d65eb47309ffacc5a28ff285ad826006da
> $ ./qemu-microblazeel tests/tcg/microblaze-linux-user/sha1
> qemu-microblazeel: tests/tcg/microblaze-linux-user/sha1: Invalid ELF 
> image for this architecture
> 
> Do you mind sharing your ctest binary? (Also consider adding it
> to tests/tcg/microblaze/).
> 
> Regards,
> 
> Phil.


