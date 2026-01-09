Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84DBBD26D95
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 18:41:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veHPa-0001ma-DU; Fri, 09 Jan 2026 13:40:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1veHNp-0000Fo-6W
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 13:38:52 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1veHNj-0008AR-BZ
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 13:38:47 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-c0c24d0f4ceso1864990a12.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 10:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767983917; x=1768588717; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tHyNRVeq8FF4DJ8XH0JPuTnUZT1+JMSUcA/Eus4ogjY=;
 b=ed4oLMhNxkz80qb+Y8EEDrJWYfrQyGDl2fa6fHd1xrPZrQTaDD62TtYS/iZJj66A18
 bAjOHMr0nCLdoBXt855Fju5RxJ8axm0TFodRVt5NRnJXliVk3KcWopt/8ZjMfQ2MhJsU
 i0HNxqkeDfz4YEdOYPK35uj/27MHyj6KwA2yGuwdHqBgf1PyIn2P+SWHhcxmw0MpXC2q
 +D8VFm8Z/ZPFB+jyjLdJAsTn8lxJZ4B+okxKPjMrS75Bey121iJTStym/Hd01TwePVhR
 6AAOlnpOkvLDm8I9AQW4lBkvvRZ5q/bJgylfdPO0sZ8083aYdNnRXQi9bUx2YsJ07Gxf
 JusQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767983917; x=1768588717;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tHyNRVeq8FF4DJ8XH0JPuTnUZT1+JMSUcA/Eus4ogjY=;
 b=PcK5L7ZMOh3m1sTsHlyiE/FHY77KtS3DnfvkmlD8u0yR4oDtVR7BVFwvPAM2PpPgO5
 1AsePaj7x+9urSeNGgHR42vgy++ImCAZMzJR56qbj0xlL3YqL2pZaiX6qTlFzKvMltWf
 tTei6SJXw9HFaGniyaPLFHxW/hb9uaRSPJO1iirdR5p27+6uicCCzoosp9xKJP/5CzHp
 qFB/+H8h/TPJFvgJLbtbqjJ0k/WPMO1MhVCx7GPwZNE79dvENsaehONoiNMUYvO1mWkV
 73vDsqKlEDEyjYht5PaxaKgNiT0j158Gy4H+LQFNzv0klDH6ASK7b4JZFO3dB7K06gda
 q9sA==
X-Gm-Message-State: AOJu0Yyc9PK78BuJn1bvEWy7ZYtPQGMDmvQE73CTfqMJmLy01oiXIZ2N
 1Eo/CoFDq+ffBgwzJN7tmj/Z3/AAG6MmRfmj67Lb5GhBgJjaa4Ki+ZBowTzEmY+niXs=
X-Gm-Gg: AY/fxX5jgt/rWKcRudzZp08Cx0YITkpaTk0zD0Iz6fFR04NXaj7ZMuMUr4cUOlnv2gQ
 2QwpwnzeFXRjLPEyddduCrUiU51PDGW2ADTxefiz14Nkr482sftDnRPoLPZikdCE9lcaNB2OiSU
 slH26IZAq2p+j0r8g5+um/0R/R3c1pQG180LCXNpIF+dxX1EEitaD2dj/6EIhsgL7gy/wNkKAuJ
 aqXstDrHgAiANzZyQMsd8Vy3UOlKuqGfF3FkbG0eBq0bIzaTDnYOcpJtNKPNwhNghjfuV2CEmTJ
 yBRXutWTTku9iFU2jw/jVUSj4r/hPcqN+Wd4FMqQXdNa6E8lwMfgFv35MNF08TbQHhY7x/EQ0Ur
 s9cFQHaaHvmV1cgWo42BOEYO5ix6qk6MbfUGVCW+95n8Zi4ONQYfVidnAKTGth8c1Vr3y3uZiNE
 AqCVUJ8O+hKTEdmBKsir3vfgsNayuoYknfnYomPbXAfYvbzrgRsJ3rgKbT
X-Google-Smtp-Source: AGHT+IEg1z/i0G0NsnyhobbDJT/mKHWCRhUyZaGZWJhm0RHKCQTRwD8ehb+/IREwqGYHDAF6KJtwmw==
X-Received: by 2002:a17:90b:5287:b0:34a:8c77:d37b with SMTP id
 98e67ed59e1d1-34f68c502a3mr11603272a91.16.1767983917267; 
 Fri, 09 Jan 2026 10:38:37 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f6af4e14asm3800025a91.1.2026.01.09.10.38.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 10:38:36 -0800 (PST)
Message-ID: <a89124ba-3011-46f9-884e-938586c46955@linaro.org>
Date: Fri, 9 Jan 2026 10:38:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/29] accel/tcg/translate-all.c: detect addr_type
 dynamically
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, Anton Johansson <anjo@rev.ng>
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
 <20260109053158.2800705-16-pierrick.bouvier@linaro.org>
 <73ac5b61-ebd1-4451-884f-0b78eaf0ff02@redhat.com>
 <44f59945-0de8-48e7-91da-6322182b4721@linaro.org>
 <CABgObfZ6qCCS89u7i+QW=FU-_aKe9ytFuwqFHNEqNNLm6=tEEQ@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CABgObfZ6qCCS89u7i+QW=FU-_aKe9ytFuwqFHNEqNNLm6=tEEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x536.google.com
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

On 1/9/26 9:45 AM, Paolo Bonzini wrote:
> 
> 
> Il ven 9 gen 2026, 17:26 Pierrick Bouvier <pierrick.bouvier@linaro.org 
> <mailto:pierrick.bouvier@linaro.org>> ha scritto:
> 
>      > I know you're trying to avoid more treewide changes and focus on arm
>      > instead; but it would not be hard to make this TCGType already, or at
>      > least use TCGV_TYPE_TARGET_LONG only for the other four mixed-length
>      > frontends (i386, riscv, sparc, and x86_64).
>      >
> 
>     I'm not opposed to do this change, but I was (and am) not sure which
>     value should apply to which arch.
>     Mips and ppc have 32 and 64 bits also.
>     I would feel safer to start with arm only for now and tag other
>     architecture while we continue progressing on the single-binary.
> 
> 
> The value corresponding to TARGET_LONG_BITS, i.e. TCG_TYPE_TL, is always 
> safe to use (though for single-size target it would be cleaner to use 
> the right one).
>

I'm not sure what was the point you initially mentioned.

TCG_TYPE_TL does not have a constant definition, it's aliases to 
TCG_TYPE_I32 or TCG_TYPE_I64, so we can't use it.

Do you want to see explicitly .addr_type = TCG_ADDR_TYPE_TARGET_LONG 
everywhere (except arm which specialize this), instead of relying on 
default value?
Or do you expect something different?

>      > Also, please call it addr_type since tcgv_type makes less sense
>     in the
>      > long run.
>      >
> 
>     Ok!
> 
> 
> Thanks,
> 
> Paolo


