Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11658606B369
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 18:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=YI2eL4rE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRvaM-0006XI-GR; Fri, 13 Nov 2026 13:01:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xRvaJ-0006TA-3V
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 13:01:11 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xRvaC-0000Yk-9t
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 13:01:10 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-3ae1da332bcso485010a91.2
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 10:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794592862; x=1795197662; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AQHvebgzMW/ni29VhiNkbsDXm/p9TP5h0Cst9Jir+ws=;
 b=YI2eL4rE7fjZ4WHu0IVyBRIiqRZfMXVxy7Gf6JRvuknkHaVxQXQ24V+d4q5QQm/A9y
 VnCJJuDl/GJgoyHtJp2fqjvIYn+DqvldGodMEwQLe8bmbAfTQ3vod36kvH1Js+jCqMX4
 3VInyrtZSq2eeMFxdLm4Kr5/YadLlr9hZaUtjZ4tInZhPUgfR2aODQonnklM3JsbKC1d
 6o+OKt0t11Ata5L/PtI1df/k6iYUAqTGLDH3EI41X7zYK9bdz8lUTmoNq5qJSdm16GV8
 eTjgJASlnI0XNhKyFwMgua/sazTPH7yqveL11ttxU7INlQ2ZuTB/BBUKNWLByKABS870
 oyfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794592862; x=1795197662;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AQHvebgzMW/ni29VhiNkbsDXm/p9TP5h0Cst9Jir+ws=;
 b=uSUdZQsL64AGDssT/2h/n7WpmrxyJiXwsJ8uuFBa7WxHseBT3GQqs8nl6ddp5CwxLT
 542NKH9PviP8z+5ppXahtQoaRaZKAJ24qIuyXf1YhjlquPP/lW5B8IolETuo/p4LXtTe
 KX5jLrWoaAz4qLuw8o4RHDhFqTMASeAgbVRthbWhA/Oav+OLTZ2CQrn8feK5cAUViKZo
 pzop1ofX9S/5pIUpPOvVFgZEHy4Y/Ok4Jz/4AMrII3vTwOo0LkrjAI0ea6HzAbcTJGQx
 VSBrubisk3/SrptNvwxB6eDl8IZnJUzI3Jv2gS+/vza2+vkBbY1GBsOcKO829mE3/RZf
 36OA==
X-Gm-Message-State: APuU4Z/3hQfa3nnSMZAds8GCJVGwwvnY08FXe4Q3XeUb2lMVPylmW+Jz
 exN1fZVOqVlL5tLeKwaX2BwtWiBC7I/NBrCaV9a6eTOjkKBL1K1/+2j6AEcPbvbVk4GMO8H0Z3/
 8CHNb3Wg=
X-Gm-Gg: AYBFou2nsUhtT3aSx6uB1OgBLWFFvUTWQfgaMf3g5Gzw07Ak3r6hIMf5e1qrdswBQiH
 /lPyAY+VYETx0By6bzAyoJnDPl112uXzHwsl13EZty2BB+0fT9Y3W9Gvlaqd22XTTEVbUnHIe78
 kQgH16jYT6dwOKrJuBIcapUSgHsODaSqrYc3xSMTXPYX3QHsoynkSFxxC8fl1ASfk+O0F2WcX1H
 2NTmQInXHjc+WBQRxtvh19chA0bxtAsx2QBJeTEmrxcENGcZrokFqWVBJ/P+1ZjxnDjwjapcOTv
 A/eRV7sfg4Pg4C6iSQnIEXuPyjlEbrD/uZa8TaHMUVLeV51m1HEdF0ny/eazI1xjjKWFQO1MPh3
 e5T1+7/dSOK4yt/6tf9c72wyATswi84KmyTOhaJcIzUEUjWO4V7c9qF514obvntqyCDzbrCCrMo
 TYhe+5ZYvc827+JDqwukzrMH+ArpHc892xQqCOlSJmN+sweFgpW8H++8U+OWY7r36AeSp0tNtJZ
 o66h9hIW4ponSWLNZBoau6tobI31QMADrGlu8+L3Pz8Kwxll+66C7JGVqJeKXWjdgSnxzJH9V79
 EyGPyYxUei+ln8b2MvJfc674DwZaeTieeiyDg9hgpyo=
X-Received: by 2002:a17:90b:48c3:b0:3b0:b36b:66fc with SMTP id
 98e67ed59e1d1-3b1b0cac932mr3025474a91.63.1794592862269; 
 Fri, 13 Nov 2026 10:01:02 -0800 (PST)
Received: from [172.31.6.230] ([69.196.88.181])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cddc189adedsm1631695a12.20.2026.11.13.10.01.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Nov 2026 10:01:01 -0800 (PST)
Message-ID: <f09ce5f2-eaf6-4c72-b489-518cf322db13@linaro.org>
Date: Fri, 13 Nov 2026 11:00:59 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386/tcg: reject VEX encodings of PBLENDVB,
 BLENDVPS and BLENDVPD
To: qemu-devel@nongnu.org
References: <20261109185656.1068651-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261109185656.1068651-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/9/26 11:56, Paolo Bonzini wrote:
> The opcodes 66 0F 38 10, 14 and 15 (PBLENDVB, BLENDVPS and BLENDVPD) have
> vex_class 4, which allows both the legacy and the VEX encoding, so
> VEX.66.0F38 10, 14 and 15 were decoded as the same instructions.  The VEX
> forms of these instructions are VPBLENDVB, VBLENDVPS and VBLENDVPD, which
> have four operands and are in map 0F 3A, so the VEX opcodes in map 0F 38
> should raise #UD.
> 
> Keep vex_class 4, which provides the legacy SSE checks, and add a new
> vex_special that raises #UD if the VEX or EVEX prefix is present.  This
> is borderline disgusting, but an effective solution to x86's opcode sprawl
> will have to wait for a new AI policy...
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/decode-new.h      |  3 ++
>   tests/tcg/i386/test-i386-blendv.c | 51 +++++++++++++++++++++++++++++++
>   target/i386/tcg/decode-new.c.inc  | 16 +++++++---
>   tests/tcg/i386/meson.build        |  1 +
>   tests/tcg/x86_64/meson.build      |  1 +
>   5 files changed, 68 insertions(+), 4 deletions(-)
>   create mode 100644 tests/tcg/i386/test-i386-blendv.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

