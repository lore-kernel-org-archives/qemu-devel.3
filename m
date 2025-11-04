Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 731CDCCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 15:16:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGIlD-0007fJ-1S; Tue, 04 Nov 2025 10:15:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGIl7-0007RV-Hz
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 10:15:47 -0500
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGIkv-0001mg-Kc
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 10:15:45 -0500
Received: by mail-ed1-x543.google.com with SMTP id
 4fb4d7f45d1cf-640b0639dabso4780459a12.3
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 07:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762269329; x=1762874129; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lcLRho4Jy9jWJqCmKOsiBuKq0wlwyalQWCJotReN/iU=;
 b=f2d+gaWtCC51L9+cw3CGFQ9CLo0k6QWe8kDbgcStErZTw795aI1Nx0eiYZ2ujEv59c
 qj7HXJ6H+7B8lahPGW+K17K+ZNTXswfVyMFUMSCJgfcdddMxND91iqkjcI7b7E3UhSOA
 t+jccMMmNKSe500vLYppxVAVvZ8jnj2icJyRvJlNbvwnSKCVKMWQc0jtZ0MZUe2m0gIr
 0A0X2tAjeJ2wZ8y1h0Lh9WR6/tdGPsMvqY1ZDq8IR+QHOJ2OTjk5Cf3L2vZnuzqIB7eR
 oBpdY/LagGEqbPSNpGe75QG60z4zPap0Z8m6oJXTrzwbUxAY6TB7umOWMC41SLwJeqR3
 xRrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762269329; x=1762874129;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lcLRho4Jy9jWJqCmKOsiBuKq0wlwyalQWCJotReN/iU=;
 b=pfyVMsjhH1IexnmI1n/Cw16GZuW82KCRO+Laeq8i71TLCNBdHkqD6d9oW4XOmH2Mce
 aZNMi9aA3FVFn61UMfbhFfofVUy5TVAFaIJ+GZl0cLcJrT5cyurCEdOSPLj4anhckE6L
 hAEfKVZKIwi0Z87HDLWANb2h8e07n7tTRBTTX7Hn7BHtME/E8QwOh9gDzPDvTcLHneYa
 Hc33lgpeC4W+thHDxkGiDWv1SL22ty+iwbY/9mhDfjvwVsl+BPaF4s60wZ9cag5tIlQT
 24NNySucza1ZjWA8yBYtSU+oXcZ4S8GjgDb4DgEb99frmnZh1hhrVbyQz5fNw01neOaE
 vEEQ==
X-Gm-Message-State: AOJu0Yy2gzEogASltckqI+IIMEiLRfNZMZS27NCsvrld3ZGxx2Pu3Zy/
 faBCe0BsSQO1apTmz7KuIjEQY8xnUTC9DbHY3Yx6FUwxddNRh9J+99LTMn5JqT1hqYE=
X-Gm-Gg: ASbGnctkwMm0ce33oRIKFMcZwU+yd9PB197ZUcc7a2X+6uNuslzJfpOsiyjgb+3go4/
 sLpdTKtxX2Nc2iSXkElwdYPxRRkCfMYrDoo0Vmcie4m//wxQQs9REuIygri7c+tt/fbLjEFIw4j
 XlQc/4jxZSwah6mMemVvQvtpA8pIOhD4Vwzg9JxZD0n+NFCXpIs0xqwxf2AGwBwUdytC8JUZI7w
 WeUVBCsI2zlvIr8Ew1QqAeAeS79lPHyzurs1ez8452xYsY0ENKs0sN/CI49Vmog+6jSiMICyy5k
 gLFaJ9AdwFpQkQE7w7SlnAGR3VkeJ+X4Cksg1IROVrW/p9zABGzxK28bJalMoo0hVuEA2QTAny2
 JW6SuhHjQ9Uqhx3U+m/bQmYQBLNZYvgoxu5DgHz7kjHNQw5wZ+KqoRb2slXSifS57fVzd16lgW0
 NgCZs4lYv2x4sXcFzgvsw=
X-Google-Smtp-Source: AGHT+IHM0az4ceL5cz3NNDUwWoyf9XJDzpsoOACn9OXUn+k0PRqudumWca7NXGGMaCgwfWi8se9Jgw==
X-Received: by 2002:a05:6402:2788:b0:640:fa38:7e4a with SMTP id
 4fb4d7f45d1cf-640fa387fa1mr1119522a12.8.1762269329121; 
 Tue, 04 Nov 2025 07:15:29 -0800 (PST)
Received: from [172.20.148.75] ([87.213.113.147])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-640e68057e8sm2603632a12.13.2025.11.04.07.15.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Nov 2025 07:15:28 -0800 (PST)
Message-ID: <5854374d-11f4-48fc-878a-cb9b78aafe0d@linaro.org>
Date: Tue, 4 Nov 2025 16:15:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/sd/sdcard: Allow user creation of eMMCs
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, Jan Luebbe <jlu@pengutronix.de>
Cc: qemu-devel@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 qemu-block@nongnu.org, Jan Kiszka <jan.kiszka@siemens.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>
References: <20241015135649.4189256-1-jlu@pengutronix.de>
 <CAFEAcA9sjszCj=Fu-A-=qQV_jawnomJ-Nqnd=Vx2vLKmYZ1-nQ@mail.gmail.com>
 <CAFEAcA_a4bYU=KQbKQmWtqvPF3fmtttbhgi0BB0hS1wcCV_U4w@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA_a4bYU=KQbKQmWtqvPF3fmtttbhgi0BB0hS1wcCV_U4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x543.google.com
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

On 29/10/24 16:06, Peter Maydell wrote:
> On Fri, 18 Oct 2024 at 16:42, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On Tue, 15 Oct 2024 at 14:57, Jan Luebbe <jlu@pengutronix.de> wrote:
>>>
>>> For testing eMMC-specific functionality (such as handling boot
>>> partitions), it would be very useful to attach them to generic VMs such
>>> as x86_64 via the sdhci-pci device:
>>>   ...
>>>   -drive if=none,id=emmc-drive,file=emmc.img,format=raw \
>>>   -device sdhci-pci \
>>>   -device emmc,id=emmc0,drive=emmc-drive,boot-partition-size=1048576 \
>>>   ...
>>>
>>> While most eMMCs are soldered to boards, they can also be connected to
>>> SD controllers with just a passive adapter, such as:
>>>   https://docs.radxa.com/en/accessories/emmc-to-usd
>>>   https://github.com/voltlog/emmc-wfbga153-microsd
>>>
>>> The only change necessary to make the options above work is to avoid
>>> disabling user_creatable, so do that. The SDHCI-PCI driver in the Linux
>>> kernel already supports this just fine.
>>>
>>> Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
>>
>> Applied to target-arm.next, thanks (unless anybody would
>> prefer it to go via some other route).
> 
> I'm dropping this from target-arm.next since it seems like
> we have a problem with the handling of boot partitions
> and how the user should provide an image for an emmc card
> that has boot partitions). Since that's an emmc specific
> thing, sorting that out with a minimum of breaking
> compatibility with previously working setups is going to
> be easier if we stay temporarily in the state of "emmc
> only happens for the specific board that creates them
> and the user can't arbitrarily create them on the
> command line".
> 
> I expect this to just be a temporary delay while we sort
> out in the other thread how emmc boot partitions should work.

Queued again, thanks!


