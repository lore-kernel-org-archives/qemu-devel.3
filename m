Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A05D10F58
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 15:11:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOHB4-0007Gi-Dj; Wed, 26 Nov 2025 10:11:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOHAj-00075B-Ls
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 10:11:19 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOHAh-0002wj-7A
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 10:11:09 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-477a219db05so41002155e9.2
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 07:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764169865; x=1764774665; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bKQ6b6wUzQjlLRFo1U2Jl/zlgT9OPWVyRWjRdqTPaFM=;
 b=ruMz4giz1jQj/m0hJNENDm/m+3lypdtIW/EsIo12LTnsJuqnr7CJuGQnqW0RvvktO0
 TH+srkON6kMur2IuLv7al3Ly2CzbQRoPvSvaANSzyRnwlXMiq1h+mqK72ZUTFbVDCTaZ
 ZxHQjH7C7qmk2sPEo2bC8vTSaVwmIFWRQlSVMX9c66T48ceFCPl11HWX8d5DsKucbn75
 Xl6dkQqbP15gghXRT5F9OZ/SVl3F0Xco21sH2XYsWY94cdCnYSTzJu3+UgXcBlcVDT0o
 RI5/AKEq943EZt6nxlxGFH95sfvi9w3wugZ9YChBGbczshLx/n4evMEHdByhKYQPF0v8
 J3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764169865; x=1764774665;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bKQ6b6wUzQjlLRFo1U2Jl/zlgT9OPWVyRWjRdqTPaFM=;
 b=H76XzugzA33YFFdvIWDEVQDRkCPJcOcMbxtooxeWHGRnaW1Sfjt+MvpdoPqiykoa6a
 cGiGfqPwuBJO6JnAJ8PdNRW86yPJMuuwXqOF5bRDJxPLAay6XfjvQHzOQR0Xjhh6Yqa8
 ava5w6sjcVsLFvCYdYJnlF2zvlpqlp037bMRRouW+KHIRUqZZiMzfgzTP4MfI4+JcWFW
 ZYOSzUL/M0JLd0K2FSj12Nh0qYsSK9gOdiHzO+JtVoo/Q2jokacGeFRP+dIlcTwfRsiG
 I01DWnR9nQAYfUIuJCYlajONjH8JadK3KuAnUsEVJXJc/zgmj4iqUsQ50GE3SxQj/C6c
 Qd1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW99MQ7uvSTAV5GB59XPsnuctK2sz8gfJttsjHU4o1vbIivYhQy3/H9edz3sMvzs8G4c6XeI1ZGoUCs@nongnu.org
X-Gm-Message-State: AOJu0YwCqsWKhjkWGWByHJmKg0434sQZBXeXwR2hDcFWpodlExDlpy9j
 TzD6FnJQjSh47QUGZQ5zbI5/xsL6ku50+PmgldPxTmXmmR0JZ89AyGiaeA+rIay5jzGOLnW36le
 C3/1OlmUGW8bU
X-Gm-Gg: ASbGncu6G2ea+Sjv8I3zcCoM1EoN6Rh4DwOcXRjdlZpPc4KtrMOTqCQ+BE44nfjLsMv
 G1ac7HIbZgHjJhnbv/t7Y8UUFA90HfSghqakAaKxYq/cUF1V1m2u8tCwE96Um7cJB9Txz0YqOWQ
 oCvVAGKsdppc7UUCd6DBP52XrQPKsEyw9asRC1/2N4pS7WCq4LJLrCLTSCZiQlAWMFxv7gOTpvV
 mkESGmH5apcodO3y65KuZIbPa/abv9fOzuesn+1pw3OxM02LYpG/unKLY80pYbIgVNEbsNa9zcp
 4iOp9iPl2bzHlUT4SaeQ/kSFLbZ5Gs9Gmuosxn4V71Gy5RGzSzZ5BzmjpvgNeghQXgcZeHD+vbR
 OOi5+ZQt8kI4SWCXDMv2d6FaTllhcQaf2S8XM/lK1ZrA0yzi15N6tGot8wqOpaBlCyD6+Vfwy8W
 r+1vDIRS+SenzflqUkBPyhlIkxHUI8pV9SHHPdZpIBokeGJV7YlJSwhx/mFZ3sgW8T
X-Google-Smtp-Source: AGHT+IG9bEVhmzArhcNM3hKHyVNhyq1wMzqEBkhmyG6hSilgkkOzPjn5AXFgzuIO3zbUYqzD3BgFoA==
X-Received: by 2002:a05:600c:3b86:b0:477:7ae0:cd6e with SMTP id
 5b1f17b1804b1-477c10c8038mr194315925e9.5.1764169865313; 
 Wed, 26 Nov 2025 07:11:05 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-479052def4bsm42645975e9.13.2025.11.26.07.11.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Nov 2025 07:11:04 -0800 (PST)
Message-ID: <3dcc24da-e905-4a48-853a-46c6b17d849f@linaro.org>
Date: Wed, 26 Nov 2025 16:11:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] edk2: update to edk2-stable202511
Content-Language: en-US
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov
 <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-riscv <qemu-riscv@nongnu.org>
References: <20251126142116.4077056-1-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251126142116.4077056-1-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 26/11/25 15:21, Gerd Hoffmann wrote:
> Update edk2 firmware images to latest upstream release.
> 
> Noteworthy edk2 upstream change is that 32-bit architectures (ia32 and
> arm) are not supported any more, so the qemu builds of these are removed
> too.

Thanks for doing this work.

>   roms/edk2-build.py                            |  21 +++++++--
>   tests/qtest/bios-tables-test.c                |  28 +++++------
>   pc-bios/descriptors/50-edk2-i386-secure.json  |  34 --------------
>   pc-bios/descriptors/60-edk2-aarch64.json      |   2 +-
>   pc-bios/descriptors/60-edk2-arm.json          |  31 ------------
>   pc-bios/descriptors/60-edk2-i386.json         |  33 -------------
>   pc-bios/descriptors/meson.build               |   3 --
>   pc-bios/edk2-aarch64-code.fd.bz2              | Bin 1565763 -> 1662423 bytes
>   ...m-vars.fd.bz2 => edk2-aarch64-vars.fd.bz2} | Bin
>   pc-bios/edk2-arm-code.fd.bz2                  | Bin 1570311 -> 0 bytes
>   pc-bios/edk2-i386-code.fd.bz2                 | Bin 1780004 -> 0 bytes
>   pc-bios/edk2-i386-secure-code.fd.bz2          | Bin 1858666 -> 0 bytes
>   pc-bios/edk2-i386-vars.fd.bz2                 | Bin 190 -> 0 bytes
>   pc-bios/edk2-loongarch64-code.fd.bz2          | Bin 1148383 -> 1178146 bytes
>   pc-bios/edk2-riscv-code.fd.bz2                | Bin 1296526 -> 1252448 bytes

Since here, could we rename this one as edk2-riscv64-code.fd.bz2 for
coherency and clarity?

>   pc-bios/edk2-x86_64-code.fd.bz2               | Bin 1907255 -> 2138026 bytes
>   pc-bios/edk2-x86_64-microvm.fd.bz2            | Bin 1787244 -> 1996414 bytes
>   pc-bios/edk2-x86_64-secure-code.fd.bz2        | Bin 1962992 -> 2293816 bytes

