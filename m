Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 837D6C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 16:49:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZvxr-0003Vb-D9; Tue, 13 Feb 2024 11:48:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rZvxq-0003TM-3j
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 11:48:58 -0500
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rZvxo-00005N-P9
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 11:48:57 -0500
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-599fc25071bso3041061eaf.3
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 08:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707842935; x=1708447735; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6ohvMHU/Sl5pqIXnzoEO+FU1rG/Hw4PAlMO/4r6M8/g=;
 b=lGsQ9kpvl18lwu+qiJS/3Immr2zFyms+ik4jhAcJnKqjlbz7hBvcReLCm977kXQj28
 anMdMn5p6t2yraVKbNErhpuRifwIP/64YFA+9gr3+rbMnR+QvymmJTXpQNOTR562cW81
 JqoFm5haCBW1oiRfNs8wLm2HK+U/HkA5D1rX3lFDPFTO+9wZW/B48MxG+9lSbZwJhW1J
 VcxNUrhEZG0JvpTkjWxpjFXrTfbKVsrYpXEL4jKkxKKCC8AZ4cgVmEyVEFE5VAqUej/y
 rpghByby/jlG++XzGATv1RmOBr4whYPsqMT/yqfgIkC/EJtml2qCFTOz8fg16g3jZOyY
 Ul5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707842935; x=1708447735;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6ohvMHU/Sl5pqIXnzoEO+FU1rG/Hw4PAlMO/4r6M8/g=;
 b=M+idtbWVBSRhORH5+0GuQEEu+0jmNbyyvsoptfsIwX/k3Lc93s7a8ut5fwG/xLFulC
 8PSUCs04fUNrzURPz2I/GupBsVlb/ZIefRf1PBnbW+/zK7UyYhR/GohUFWL8QYERMxFr
 5PRD6RVa7ZQ9KmDPZzd4QKukqibwb3aNXRCDUFo/hMazlQR++CoQfcIE4NndqvMjqKYZ
 zs8Z61uXxHcuwnGP1kUQy/i1hidNv4KvWxg5nr32XxJyhx9pT6/R6hmLD1N5TsPswfJp
 OPM+2vg8Z8vJfVPOAxz3Cqb4mHY5b7O45wXAHvIDRlnZO5SQVkFE0mfkC9mqovct9Jr0
 cv5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2HxyCFeZ2cR3jRIqkYiohGBp1g8/+Cj8KAriKsveQwA5ovtrpa01ulL1GaBUaEc3Xb+FoMi9KYx53hXAAaN/fareJjHA=
X-Gm-Message-State: AOJu0Yz1rfApISlrbTXq/oBAE/nJSFGtT2Y9KZFzlhZSs7trJdSO40z7
 X39rH6jupOExKarcqN7P8kuuz5dxx8geJjazMEUVHWyjYwEQy50P3xrGhbmOzP0=
X-Google-Smtp-Source: AGHT+IHjpSY9+gMtEyHj/RpBBHdbyJHGNFI4Ng6Lwy+VcPpTyWYuau13e5sAipklyWev9ie4+6R8Yg==
X-Received: by 2002:a05:6358:724f:b0:178:a555:c312 with SMTP id
 i15-20020a056358724f00b00178a555c312mr11082112rwa.32.1707842935230; 
 Tue, 13 Feb 2024 08:48:55 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCV2lCnVWpz0EeA8vuJ6RD86bpJmW4vn+lceL7sHKZrMvylBi2WwHiM9dk6gvEtf8i+2g1r+quwgAhzNtEvZBTGAuxd43Fs=
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 k1-20020a628401000000b006dfff453f8esm8010823pfd.75.2024.02.13.08.48.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 08:48:54 -0800 (PST)
Message-ID: <5fb4676a-88b2-4beb-8fc7-704901194543@linaro.org>
Date: Tue, 13 Feb 2024 06:48:52 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] hw/ide/ahci: Do not pass 'ports' argument to
 ahci_realize()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240213081201.78951-1-philmd@linaro.org>
 <20240213081201.78951-8-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240213081201.78951-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2e.google.com
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

On 2/12/24 22:11, Philippe Mathieu-Daudé wrote:
> Explicitly set AHCIState::ports before calling ahci_realize().
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/ide/ahci_internal.h | 2 +-
>   hw/ide/ahci.c          | 9 +++++----
>   hw/ide/ich.c           | 3 ++-
>   3 files changed, 8 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

