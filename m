Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 716B0F327A3
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 05:49:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF3zV-00019l-U9; Tue, 21 Apr 2026 01:49:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wF3zS-00018d-Rw
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:49:42 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wF3zQ-0001T4-Fr
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:49:42 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so60064695e9.2
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 22:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776750578; x=1777355378; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yJuLMsFT+Kl+s7MFBGeDCQ1FylhG03azWGmzT9SsJjQ=;
 b=v6NWnAOu2EEhzLviQVy0j58+yE+g+bl+6eiO5YkQutTr44hGyunrCZFE1n717ropia
 6gc59uG+CKoVF2e5GtU5PVlsSXOWKhlJFXQ690lD8QIXDlpv+AR2a3A0Ds/jM+4SU3Za
 tVE8ATDpnmtckbms+EBiunt4nS25K+m1umQTvOTLTV3uYTtnMDWx8mYlHU4rq30dSSDm
 zPm6EDFbw/yo/wPaijbraUrvcK1XTPToMjmRTep9bkUw0a9lKIOQJ2UFzDsFIHunDPUj
 j6U/T3/CPS12hgLFVXEK+iOG7RdsTQk6wPjP5LtyvJxJ0G7gXhLskOJwAvVeclTaRuku
 3Y4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776750578; x=1777355378;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yJuLMsFT+Kl+s7MFBGeDCQ1FylhG03azWGmzT9SsJjQ=;
 b=EdDjVsk6suX9q7qsGBacxcCNMfGHbIbxPg21qKUt85r26d/Mos31MnH76YTzFRp3ch
 KQFolnxULAqz3TPe93NNEd51k4S64ITn64hDj0cgE6mJYC5thmJNALowNIbMp6ykK1Tv
 9JoPT+O4/cTD/6/5P6ghgYh/iJh7xx+V0jqmRIfUN8o1KEyEfVUEgNziWXaNmY0hNcun
 otB8tbfVI8hrxc6y+3ghzvdwcYHI9tJf12U6AqK6fggaAKU2spql0mqlI8rmdx8om7j4
 oULXiJK57+9m8FRx/OLuYU3p/9X7wmAMGRCgUFaEv3kQ02lVlRdw3Lhnb/+sORTJEyLj
 GFRw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+qibXvWpdKdlo1u17r24scI5eOEFVJTvdIYXYB4keU0HK6yUE25RDYy1s884PEXZue6UERCzSAA1Mf@nongnu.org
X-Gm-Message-State: AOJu0YyGT2i9TGLta/E/N5qq5dr6HUgi7atUv+yddUgi6w7NBSIvpIjr
 lhhs+R4s/H9x4HT1weDq0/eCSfxZmh7rE3U4vD6bV/cFiy31N6/YL7Oe3WddmLz7OBk=
X-Gm-Gg: AeBDiesfuOM28SAqoxYcdSTgGZb1F4hV4wdhSnyz6U+VKRdMpwIA1Uzh3e0kY0Q0SBk
 SlWKC1N/vdeaHSFJopZ/DTkVSpkaDpGDEx/EgMFVaSICtXwBofNvJQ1aBUpiwe3WiQ+nEAjya4M
 7+CpLnRtJCHQ6Y9/AdcF0pvOYH9zz2zabVgKrky3GIPfwg9QT1gZhe/iOWhGSxz9XFaTkYJxIQL
 eJyGnNWrCknOxaCpCLidtUsqY/eLu5t1iuEb5qYqmHc+tvA+RC4naFISG20EeWsm+IJXubXgNeZ
 bMB0MIBzXNJG6/6pKYXrVzXX7/5ksnwQA98EN2OPfmIShO4ANln3IMQvFZspLRf2O0G5LrXt5KO
 tt0gdRUj1ERHI7SWCbt1FSmIKBh/pZUArrYKzCANl6bDOt8imCP+x8EhHWwnuKd/mbgE7E/Q1YY
 BL8XsNBSBlyZ/OUU0ERL1sIzArLxE53qv0kOTJU0n0FSwwtBx1qe8htKiiwGDPV3qp/SxhPeAo6
 7ts
X-Received: by 2002:a05:600c:8b38:b0:488:b14f:b8ed with SMTP id
 5b1f17b1804b1-488fb6e815amr243110875e9.0.1776750578397; 
 Mon, 20 Apr 2026 22:49:38 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a5499b0edsm39751565e9.14.2026.04.20.22.49.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2026 22:49:37 -0700 (PDT)
Message-ID: <2160f597-53c2-4ad3-a0d9-4498a747f291@linaro.org>
Date: Tue, 21 Apr 2026 07:49:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/13] hw/riscv/aia: Provide number of irq sources
Content-Language: en-US
To: Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Michael Ellerman <mpe@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Nutty Liu <nutty.liu@hotmail.com>
References: <20260421053140.752059-1-joel@jms.id.au>
 <20260421053140.752059-7-joel@jms.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260421053140.752059-7-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 21/4/26 07:31, Joel Stanley wrote:
> Instead of hard coding the number of IRQ sources used by the APLIC pass
> it in as a parameter. This allows other machines to configure this as
> required.
> 
> The maximum number of sources is 1023.
> 
> Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> v3: Add r-b
> ---
>   hw/riscv/aia.h             |  3 +--
>   include/hw/riscv/virt.h    |  1 +
>   hw/riscv/aia.c             |  8 ++++++--
>   hw/riscv/virt-acpi-build.c | 25 ++++++++++++++++---------
>   hw/riscv/virt.c            |  2 ++
>   5 files changed, 26 insertions(+), 13 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

