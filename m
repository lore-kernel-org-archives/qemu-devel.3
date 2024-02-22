Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35DD5C48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 10:23:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd6EB-0007K4-8w; Thu, 22 Feb 2024 05:22:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rd6EA-0007In-HL
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 05:22:54 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rd6E3-0003Sb-UC
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 05:22:54 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4125e435b38so42361945e9.0
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 02:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708597366; x=1709202166; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GIJgw6JawTFcB6/RW+pFCZ02B/g75qD9enf63xzlI68=;
 b=Qf5k6CW5MclCmRTMJHEN/GydOD7/TBi/OZu8HhjkKsns3/quqjHaO4h6Cj4Ia8cAbD
 +2L39gdahYWoiiY1hZBDFx2EKyXJdrw4CPltdgFnKoIYtaxfvu/z14E2SmQsKhVWvvdF
 +YyUS7ehYuN5DxDjzXCDT8DN+fWhBMzEeBLNM/4irw7Cuza02DGqfDZfCMvG9NX7ljHh
 HD1XGeGJMAbKu9cyILK80Q9oSNM/Er8+gtT04P0tw+RKrX8gTcAkx2rF0PeCZzJg4gRm
 ds5z+x2NhwnyKatALI3oFQ3y0saSvy+T/0TK8YSrkOF1ha+RtfHCsUtnqcrPWZ4wdoul
 pUvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708597366; x=1709202166;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GIJgw6JawTFcB6/RW+pFCZ02B/g75qD9enf63xzlI68=;
 b=AsFHsXEotWWrdvYtRlV79FvzyrN1V7AsD7t/CqrQnm5iaGorh2Mm1j8iAFrY2ExhHV
 fFdIMl62+xfyDqEE4tHqs9NVOsysJ5PGXr4A5dgZDHmBgHtcVkbOOAhms5kRweyrcq7/
 8cvNBeqTH+jFePQB3k7nyjZG1Gk/55w/eTnhgEUdtMCv0iVHN2umx9a11BxfMzd048Y2
 CUXa1/wJoA2A914eMhV2+4zB6JIa+OxNECuPHtF3opByXQ/nT85GplEIBerB+TNOqgHy
 J9Me2kg50J3KfArPPuQcxb4VpuWSMnJNANHUcIlqKfTnl8eWpPQHaPlJvWIzQ7qgLZ9O
 kCbg==
X-Gm-Message-State: AOJu0YxotWQKFTQPWgVL1s210ORPZ4Ve4YuhQBRVyHNssML3q+x13MS/
 9DgcG3Ms6oTVIpAGVx4GNVDbxenD/SpyC66RAbiQl91G5zNvKwK+1CnAIVyyGlhPS1Xge3Kfk1l
 BhBk=
X-Google-Smtp-Source: AGHT+IHntMYfNBDqvx6T+pZ2pIWQZ0fYCKAevc+281+3WLk7M0A3P/WEN4oHjCT3lFoMfUhRGSKnLg==
X-Received: by 2002:adf:edcd:0:b0:33d:2746:2f50 with SMTP id
 v13-20020adfedcd000000b0033d27462f50mr9757619wro.33.1708597366120; 
 Thu, 22 Feb 2024 02:22:46 -0800 (PST)
Received: from [192.168.247.175] (41.red-95-127-32.staticip.rima-tde.net.
 [95.127.32.41]) by smtp.gmail.com with ESMTPSA id
 f2-20020adfe902000000b0033cf24700e5sm19730037wrm.39.2024.02.22.02.22.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Feb 2024 02:22:45 -0800 (PST)
Message-ID: <74b605bb-c52f-43e5-af82-d6a38c5bd2cd@linaro.org>
Date: Thu, 22 Feb 2024 11:22:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/25] Misc HW patches for 2024-02-21
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org
References: <20240221211626.48190-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240221211626.48190-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hi,

On 21/2/24 22:16, Philippe Mathieu-Daudé wrote:
> The following changes since commit 760b4dcdddba4a40b9fa0eb78fdfc7eda7cb83d0:
> 
>    Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-02-20 10:11:08 +0000)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git tags/hw-misc-20240221
> 
> for you to fetch changes up to df07f6bb563f25f39f4f5887adab557e42bdee59:
> 
>    hw/sparc/leon3: Fix wrong usage of DO_UPCAST macro (2024-02-21 22:13:03 +0100)
> 
> Following checkpatch.pl error ignored:
> 
>    ERROR: Macros with complex values should be enclosed in parenthesis
>    #62: FILE: include/hw/ide/ide-dev.h:31:
>    +#define DEFINE_IDE_DEV_PROPERTIES()                     \
>    +    DEFINE_BLOCK_PROPERTIES(IDEDrive, dev.conf),        \
>    +    DEFINE_BLOCK_ERROR_PROPERTIES(IDEDrive, dev.conf),  \
>    +    DEFINE_PROP_STRING("ver",  IDEDrive, dev.version),  \
>    +    DEFINE_PROP_UINT64("wwn",  IDEDrive, dev.wwn, 0),   \
>    +    DEFINE_PROP_STRING("serial",  IDEDrive, dev.serial),\
>    +    DEFINE_PROP_STRING("model", IDEDrive, dev.model)
> 
> ----------------------------------------------------------------
> Misc HW patch queue
> 
> - Remove sysbus_add_io (Phil)
> - Build PPC 4xx PCI host bridges once (Phil)
> - Display QOM path while debugging SMBus targets (Joe)
> - Simplify x86 PC code (Bernhard)
> - Remove qemu_[un]register_reset() calls in x86 PC CMOS (Peter)
> - Fix wiring of ICH9 LPC interrupts (Bernhard)
> - Split core IDE as device / bus / dma (Thomas)
> - Fix invalid use of DO_UPCAST() in Leon3 (Thomas)
> 
> ----------------------------------------------------------------

I did the mistake to rebase on master after testing,
and not test again, and missed a new header must be
added in "hw/i386/kvmvapic.c". I apologize for that
and will respin a v2 once fully tested again.

Regards,

Phil.

