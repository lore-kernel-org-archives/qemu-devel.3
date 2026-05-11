Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 069CFCD484A
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 14:06:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMRFY-0007bl-Ux; Mon, 11 May 2026 10:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wMRFO-0007Db-Sv
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:04:40 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wMRFM-0006yL-Kf
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:04:37 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-479d68a9063so1564995b6e.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 07:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778508275; x=1779113075; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5QdluYs+36/VctNKbAJiHtOEZHBaFIsFBOTFMomuWlI=;
 b=UCUB99FmZkHnTdfmmfRAHoaqGMgWfjG3KGtteNj+2Nl7vSpUxzrcRhZELqhaSLsP9b
 nJrhHOQ8pts+9fBSe6paxRvOL7IZI5edcqp6t5fRgHNTYuxgNmwGhQBDJNdxa1DIO/6K
 453q2ibOdoVTsnHb1jKo3T1X0hv+JWAoL3cB+aaCN1fJhKfr5KeHmSTFFysxrwMy/FDb
 JgFCLQ/ow5TDVM9ZlMT/1gM9GgSBU2jrEf5gZ0n2Xc8FUP94bLG9SnAtvJLaYdSFcbty
 1SqHD1/YVSVbDlZbHlBCfxse5hIss8VDRGxR00GINndEGC1PC5xS2OIddMxqa1TPW1j3
 k0Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778508275; x=1779113075;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5QdluYs+36/VctNKbAJiHtOEZHBaFIsFBOTFMomuWlI=;
 b=n6ugKXzdrgWx9xWn6ujNgyJRpzFGHzIkmLfS0Y2eFY/ijb0t7QnxdjptLqcCwkP+Ax
 SIPhejSiR+8g2EnkcQPqNa8WCRtAELiFYK0ErKPCC+dt3APo0e/E7XPWyuUAOymEvsol
 X5k0TRtblSKSybQBxvOAzXicM/s7vZ3V6qz9nnUnwUEd3+UWq8DTZZB3E/UlY0dKXX7+
 5BLkVanQAaLWQXPmVHgVnEYhN26eFyVfOolErYKhWFVGAhOPEPVDmQmNPFSO5mkLFpJg
 +Dnld/gZ2w8PDoL2G79KV8GjB9eSNQQ2Okk8+IQGd5+cDjxzU0ZSSUdllCFzw/tjEm3g
 DTcw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9lq9zdPAVBQ6tGiZvVk0AgGMm9J3x/rQOHGDs9vkF5nPQ4SiBhwXS1CjDDC+iFjByEj04+gerlk427@nongnu.org
X-Gm-Message-State: AOJu0YznmHgS1DkNHtYa1J0A7IspWKX3bZkearhhyZQOa1N8Z/YCAsGO
 Oh5405c5F9qondjJr5zYCRKlZpkVNz2aYvpzdENoa/ESNkusD3+PmLjxMI/vL1WjjOQ=
X-Gm-Gg: Acq92OHntceEV1kEAv1BQF0lXiFCSxPyV8h94+Gf5M9q+uMOXeEe/g4Jc+o4qWMlbFN
 HiZx9OmYHuPG+0oQRVUoSenH+aWdPttc3Zi2UlYMtImPOLvEzYM+Be3FiZQbxjkIP+uXjfttCpT
 GHIZjPhDKiTGX6EqN7Y9rOQFD5+UKue0EbHASyFPrAZQbPss7gZc5jjFin+5QLUB1wEybOtvqDF
 KdwU1lq6wPZ16KidqbvbK7sq+/UOCUnP+qJoOLtasi7IdhVceYoS1QAk3+zgvbsNuotrX0W1imb
 XEFcdrEJJJwQ9luqDCSY8Bc2gcsx7FU9bektGL0KWQyXnHMo4rRrLv8krjUIUKE5E38Zw83GoxR
 /89W8zzVdgqirP4i6UHDXN57QO5k0WD+CZVVH1V+Z2Bd2FlMHVH8SAEqyiUQCoFqWu/lvV1Lojo
 5/XfaOxJIO0REzcZiNzxyAN6EebEA3qTpWVkfpp0IrU6guTR9cnjv77g5AphDuMXD20rVKfsvIv
 xjx9LLi+g==
X-Received: by 2002:a05:6820:160d:b0:694:9bdb:596b with SMTP id
 006d021491bc7-69b36b3f19fmr5500535eaf.17.1778508274809; 
 Mon, 11 May 2026 07:04:34 -0700 (PDT)
Received: from ?IPV6:2600:381:c938:6375:e3e5:757d:3cef:3491?
 ([2600:381:c938:6375:e3e5:757d:3cef:3491])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b25c9a23fsm5767475eaf.7.2026.05.11.07.04.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 07:04:34 -0700 (PDT)
Message-ID: <81b1a0a9-ada8-4030-be3f-13f288d3d294@linaro.org>
Date: Mon, 11 May 2026 09:04:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] buildsys: Remove support for MIPS host
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, devel@lists.libvirt.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <arikalo@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Aurelien Jarno <aurelien@aurel32.net>
References: <20260511135312.38705-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260511135312.38705-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22a.google.com
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

On 5/11/26 08:53, Philippe Mathieu-Daudé wrote:
> During the v10.2 development cycle we deprecated MIPS host
> support (mostly because Debian which we use to test in our
> CI dropped the architecture when releasing Debian 13).
> 
> This series removes host support for MIPS.
> 
> Philippe Mathieu-Daudé (5):
>    buildsys: Remove MIPS cross containers
>    buildsys: Remove support for MIPS hosts
>    hw/mips: Include missing 'cpu.h' header
>    buildsys: Remove MIPS KVM
>    buildsys: Remove MIPS TCG backend

Modulo the note on patch 5,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

