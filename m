Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E36DFC4829B
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 14:04:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZWuJ-0005uq-Dt; Mon, 12 Feb 2024 09:03:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1rZWuD-0005ow-FF; Mon, 12 Feb 2024 09:03:33 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1rZWuA-0000Yv-C9; Mon, 12 Feb 2024 09:03:33 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6e0a37751cbso1124846b3a.2; 
 Mon, 12 Feb 2024 06:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707746608; x=1708351408; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :sender:from:to:cc:subject:date:message-id:reply-to;
 bh=0fDwCuMc1thS1g21GHEWZZso75s6fwtaIeUP5pf+VOo=;
 b=VdFz8lzWzP1WciEAcxJD1a+2RFjDUtKXXul5ZZ30X8ePH1aWIzba+l5TQBlP67TsUS
 46QN4CXow/YJQbcIYNAimXNuKJYlYNlg/Ey3CR5BxMJn7op7yCZdSCUsXYV4hEZ7Sydv
 3TgRbL81KCWN10yrCcanXRAmon6dM4C+vXpuQ0ViBqLz2pP9RBl7FTz1EloABjej1PLy
 n9OTtvKoYPIS/6J7WHBPy+YFlct5IBwSw6A8FbH010o2SpgLImJxqX2j84OqnaoW/UTa
 vlRgFlRLIOUr06C2L/f+nqGNiIwtRafWrSpWfQZdq0w3OMHRW5EX81JYuxflFYJQjjFQ
 zF2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707746608; x=1708351408;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :sender:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0fDwCuMc1thS1g21GHEWZZso75s6fwtaIeUP5pf+VOo=;
 b=W6LCRH55nWEW9x8I5XMmXeiuHQ+aw1FJitUebFybNVtZauBCmjKXT1gHNJZgk+iazb
 6XZpEcFVBmn5B8n1OIipMTBGDKS53yNE04AdviUvSykmIChR5VJ7yUEJlmd/LuWg//YT
 edfOIN+2G3yYqRCh4Lq/g94UUZ1+nl0cTt1ooN75IYy60uI3dFKD7ICkGS+8imZg0V6a
 9AHvmuJcsLVUmU69Z8tXaZrksAqc2Oj2IjNTjp3uTle/fMCNcXqmlh632EaUceZnG2KE
 GwfDzZyRU4gpBT43Rc/f6QVdIGw4RWtIJ2vr7cRjH0UYbLpHR2fgIJAYogNdKLFJ2Onn
 iD8Q==
X-Gm-Message-State: AOJu0Yx2Y5+5DDLFpjHjpESvLHRt+pvIqzOFeCtOAYCXc4qcE8ajjLhj
 tXMCYcAyA1nLrst0MrnlvMpLer87XbBz9mgMc6FurUyZdsFq7A2w
X-Google-Smtp-Source: AGHT+IFH5yijfCYPP5BqvLXP6k5b15kG6LIlrFxBHYNesKn0gmNfcS0GWYwP1kVZVaWeXsp6X2T+3Q==
X-Received: by 2002:a05:6a00:390e:b0:6db:d2f5:9e28 with SMTP id
 fh14-20020a056a00390e00b006dbd2f59e28mr6382544pfb.10.1707746608011; 
 Mon, 12 Feb 2024 06:03:28 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCX2uuTymWBL/rmRsLA+QT7HSE1ByqAajPhKyHxL+XFLnlmXaJzSv5XNc3H9thkm7YzljQ88jKK4vbyU+9pWmrPWSCSp3ECIrTcrOeBgw9I4CddiOWBT1IaY9iYRT8n5+tFd19Nl
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c?
 ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 w12-20020a056a0014cc00b006e03c68ae9asm5739807pfu.16.2024.02.12.06.03.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Feb 2024 06:03:27 -0800 (PST)
Message-ID: <f5a561bf-31b0-4fb9-acaf-efc83d232a9c@roeck-us.net>
Date: Mon, 12 Feb 2024 06:03:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: possible deprecation and removal of some old QEMU Arm machine
 types (pxa2xx, omap, sa1110)
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Cc: qemu-arm <qemu-arm@nongnu.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
References: <CAFEAcA88UGhjh8-iBvhxx6GdWg74dinYouiguTcz=qEe51L7Ag@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAFEAcA88UGhjh8-iBvhxx6GdWg74dinYouiguTcz=qEe51L7Ag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=groeck7@gmail.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 2/12/24 04:32, Peter Maydell wrote:
> QEMU includes some models of old Arm machine types which are
> a bit problematic for us because:
>   * they're written in a very old way that uses numerous APIs that we
>     would like to get away from (eg they don't use qdev, they use
>     qemu_system_reset_request(), they use vmstate_register(), etc)
>   * they've been that way for a decade plus and nobody particularly has
>     stepped up to try to modernise the code (beyond some occasional
>     work here and there)
>   * we often don't have test cases for them, which means that if we
>     do try to do the necessary refactoring work on them we have no
>     idea if they even still work at all afterwards
> 
> All these machine types are also of hardware that has largely passed
> away into history and where I would not be surprised to find that
> e.g. the Linux kernel support was never tested on real hardware
> any more.
> 
> So I would like to explore whether we can deprecate-and-drop
> some or all of them. This would let us delete the code entirely
> rather than spending a long time trying to bring it up to scratch
> for a probably very small to nonexistent userbase. The aim of this
> email is to see if anybody is still using any of these and would be
> upset if they went away. Reports of "I tried to use this machine
> type and it's just broken" are also interesting as they would
> strongly suggest that the machine has no real users and can be
> removed.
> 
> The machines I have in mind are:
> 
> PXA2xx machines:
> 
> akita                Sharp SL-C1000 (Akita) PDA (PXA270)
> borzoi               Sharp SL-C3100 (Borzoi) PDA (PXA270)
> connex               Gumstix Connex (PXA255)
> mainstone            Mainstone II (PXA27x)
> spitz                Sharp SL-C3000 (Spitz) PDA (PXA270)
> terrier              Sharp SL-C3200 (Terrier) PDA (PXA270)
> tosa                 Sharp SL-6000 (Tosa) PDA (PXA255)
> verdex               Gumstix Verdex Pro XL6P COMs (PXA270)
> z2                   Zipit Z2 (PXA27x)
> 
> OMAP1 machines:
> 
> cheetah              Palm Tungsten|E aka. Cheetah PDA (OMAP310)
> sx1                  Siemens SX1 (OMAP310) V2
> sx1-v1               Siemens SX1 (OMAP310) V1
> 
> OMAP2 machines:
> 
> n800                 Nokia N800 tablet aka. RX-34 (OMAP2420)
> n810                 Nokia N810 tablet aka. RX-44 (OMAP2420)
> 
> The one SA1110 machine:
> 
> collie               Sharp SL-5500 (Collie) PDA (SA-1110)
> 
> Obviously if we can remove all the machines that used a given
> SoC, that's much more effective than if we just delete one or two.
> 
> I don't have any test images for the SA1110 or OMAP1 machines,
> so those are the ones I am most keen to be able to drop.
> I do have test images for a few of the pxa2xx and the OMAP2 machines.
> 
> thanks
> -- PMM


