Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 515691098797
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 15:53:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3c8K-0007fn-PM; Fri, 20 Mar 2026 11:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3c8J-0007eH-5h
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 11:51:31 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3c8G-0005Zi-Jr
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 11:51:30 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-4327790c4e9so1388042f8f.2
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 08:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774021887; x=1774626687; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dxAE80npSlmsob1slWiUxqWs13+sUZxls1OfOL833ZQ=;
 b=oqcR65hT7teBGVjiYpiO+4f6GsBdr/tp0kVYj2siDyKUtGjQtpjpIYjcQa9ZP6d9+B
 j0CwQDRft3FOa/vXhXXupE0/7/gJRUKQuY30wZMkQBTyHKBAyCQjSeNHEivV2Blfx9++
 qbkteoVx4DtrvjKu1VqRdXZF1KqCMpF3TX9FYbL3QXfmeBcAN3g/Wh3tphtOookemTPS
 mf7G/jsnD6JRErE87hrAH13tBX9b0g+yOhaaqbH0ZKpomnMOuG/2zzFDGYC0cFWqkJTu
 D0/UXoEiK2dXt7Z99933d8euW/pWiFDKlhNORRlaz/d40do86lMZp36d4mp+yA5e4b+l
 aKuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774021887; x=1774626687;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dxAE80npSlmsob1slWiUxqWs13+sUZxls1OfOL833ZQ=;
 b=rR3qvXgUjXpMajPpMvWEW94+dcz0QeScl1urE1E3z6OWC1Ab6iSNg5pd5zs6OU85bt
 Cw+H+A57s1Ay4jr4CHHxIBWbQp6XSwWkEl0TWGKnzlZzzAEplSmuTC4UeiNw4KsCxCnz
 uWmV/ka2gxKgSKWmHgy00I+87pVemFeHnqAa6f8USAbNx6zIg42nD+msX2+VjiJj1U2O
 wKY9DDPYlpVkzVYI5Zt4fVIL6zei79EUvhUZPvXKXt+RmWWdpxDFs9dELk+8fBI+/ZFw
 6W2ytxY4sEinu/dcjxQR0Q/iP5o8m+W7KOFrBFTH4T+PI9eR9Kc/UfaS0hSWCReYVogO
 qVkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+a/izWxe2zaQXu+Ox1AhqDzAwHGmY3b+4f1jhivtzQJc9tmby+Ner6TGRR6YYYQKzmNeGjYX57/JS@nongnu.org
X-Gm-Message-State: AOJu0YxtH+qIz6bvBqBScagb/y5qQdMrUkj0cyZ8LAMb80ply78lDVDb
 Gk6ooaOYzDD/uTUzvieB959jZ2512maofjOThuryWls9s8vXL7hlXOkUuIDnF+9u4N8=
X-Gm-Gg: ATEYQzz19hFF2d+Nc4D2wTikMAVP/0t8s5Q9KlPTrIDNMxaH4pgY+n0BUHyspPkowUV
 mkPUb+4WH2jSQdInfv3GHRNVsc2K4t5eKRVaBL4wWzzTxNCBw+MNfY/7qTK2UP/lfwaNifrGl/2
 mDynpQgzufSRE1BwP3PyL/yUGjJ0IcMINOefcB4Brn5cjidJTz1r71l+akLT4D3OUizN/rgM28n
 wFt14PxdUAi8xzam9Jp5kp71Dm+CV9Y/qjxWVwzpicI+WY+UUX4nBiE9B+84xb+xRGnHQVGd3L+
 WTeJHeVAvOq+YyjY0smLSOmqlF1mE6MYNSHULP05PtrwB9Y9+YURsLcLMG7EAgOE5/d50SdR5H0
 lzBUmgkv4IoAuAJF4FuzuJf9IuYtiNNMGp6zDTIMxT99LH8z3vfZO2yy1Og11hWsoJlI9rPQfQ6
 51cWTVlw2jxQKczcBjz0ki4bykR0bvSwSkE0aIQNGP4X4AQjq0ltEuloAgmGPOhEVeS1MDWTpVS
 Smp
X-Received: by 2002:a05:6000:2489:b0:43b:43ae:8c2e with SMTP id
 ffacd0b85a97d-43b64289994mr6210997f8f.51.1774021887031; 
 Fri, 20 Mar 2026 08:51:27 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b644bd0dcsm6569891f8f.11.2026.03.20.08.51.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Mar 2026 08:51:26 -0700 (PDT)
Message-ID: <4a402425-8c01-4247-a533-c43a797a25d4@linaro.org>
Date: Fri, 20 Mar 2026 16:51:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] Add RISC-V big-endian target support
Content-Language: en-US
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>
References: <20260320150552.169480-1-djordje.todorovic@htecgroup.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260320150552.169480-1-djordje.todorovic@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Hi,

On 20/3/26 16:05, Djordje Todorovic wrote:
> - Addressed comments from v3
> - Rebased on top of master
> - Then rebased on top of patch set by Philippe
>    "target/riscv: Forbid to use legacy native endianness API"
> 
> Djordje Todorovic (7):
>    target/riscv: Define MSTATUS_SBE and MSTATUS_MBE bit masks
>    target/riscv: Add big-endian CPU property
>    target/riscv: Set endianness MSTATUS bits at CPU reset
>    target/riscv: Implement runtime data endianness via MSTATUS bits
>    hw/riscv: Make boot code endianness-aware at runtime
>    target/riscv: Fix page table walk endianness for big-endian harts
>    target/riscv: Support runtime endianness in virtio via sysemu callback

Thanks for this v4. What guest do you use to test it? Would it be
possible to add a functional test, so we can check for regressions?

