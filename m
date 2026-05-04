Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B850CD3423
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 07:37:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJnr5-00050c-IV; Mon, 04 May 2026 03:36:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wJnr1-00050D-Jg
 for qemu-devel@nongnu.org; Mon, 04 May 2026 03:36:37 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wJnqz-000763-MC
 for qemu-devel@nongnu.org; Mon, 04 May 2026 03:36:35 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-44985f4ab0fso1542713f8f.0
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 00:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777880189; x=1778484989; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CRckL+sEPFBJZu+9AFfrXSqIP9GjmsTWxjyZ8SWU/s4=;
 b=bKKRFr00LGAVRbPGwek2ItKuznJs5RjyYCI6eZ8HasD4W0HaLh1rlhD6560ZhFVS7J
 HLDeF7Is76GkKv0AOQIFuhMxRbUld6Rj/ISD7y8ZfiQC2S8dLUFkX1sZkW30Kk9shzlx
 dJTF9Of02RMm4Y+cIyOD5XsNVZBhTI9cTlWGS55u6Tpnv5rv40puBARq/n/fK3cUkrQd
 pMSEuaxrsHw5jyZFgJ+dY5BQ+DI6AYBPPi4bdF19LNAjf5bO/Hu9ybKegW7jukrLGxYG
 oOoFGyNoZvHELGaSKGUfA3B/r4S71WXVWsKwPzlLSEd4blRpICvogarxvZ/cg58O8fum
 36SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777880189; x=1778484989;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CRckL+sEPFBJZu+9AFfrXSqIP9GjmsTWxjyZ8SWU/s4=;
 b=HuDZqMZCBVEhTMEEHil2QS6sclPPn0WtSCvSAtPuEH6jGNuooutiDF7zAHHMszuLVo
 i/ujk59Tu6s9HH+uUvrITlcYm4Z7P8hghOqodgMe4ZGsm9ZOqdMrutmbdCgVY9V6yNgX
 uyM8Gl6hs0mxsyUhRDzDeIb8xTfjnBNLAVqIxvwla/jKi3fKQ+9qQ8zfAKCULVMxYWtA
 Et+ohhtj2hNF2SY+OprHUn+RSY4ck6LjZblcmArv6ruhnSHQKITzQrU9Hbkg7T9Jnpor
 Fa59EvaEPOS8Zx3v6pgSnQOX4GJgJ80gjZIDd9DTw8BgssXctEUqHZCy5ugKHvCWZI7d
 hpuQ==
X-Gm-Message-State: AOJu0Yzuol1YjuUPEwBuHKkL6hB9WZrrfyfOAsGAra7f3wsQxDPEKZC4
 eQHoOFzxGc7KJmrfJFapDKcb6x9+VWI5YwuabLteHVoDvT4iqVPcd3wPDLdaQ5ZOmMI=
X-Gm-Gg: AeBDietP/jmhFYo8uyR5dY7IGp2dvWLz2sekk4L5GP/EGYWR96TqEHvHwNUxRMh6+YX
 qLQC11gNWttwRO46zt07yDggkqy6BGJ1K39tu8T3shaf7+7/ZTDoNl7zurBFSSCDw4fqdNa3R4l
 KPuFjWrFDhU7Z8BWKVOYuj7/CISQfsvw06L94VrlyLaqVlQ8v1hiclr2MS0NlEpWpsaDxHVItwD
 2JbJNSCuyAD/u3fjNU+PXx4Y5jY+mCh/nLUctIxRXfG4H7X8wfdcqyD1Zqc8F6T8SQUDMG2sdmt
 tjJ0EeWFkGzn9B7dvYYRh4NvaHir74b9zdncTkbWu+L2xGTRFEf/ZIxfxTmh/AgRKcD9fCKG72r
 j7wqSICN1r4Kbmc7l+U6Y2eDxWzbTMghBkQdoTxBeRvLJK9gTRvQccHVsskkhTdylyqkJBHheMF
 96TE0YEKId69kmndFKPgjMADOEcaXSDYvMtEITlmA9Po3nREfm1LvJlhwi+WRJZpyFDXt0V8Ptl
 Q49
X-Received: by 2002:a05:6000:184e:b0:43d:762e:76c6 with SMTP id
 ffacd0b85a97d-44bb3207ae6mr14347277f8f.7.1777880189298; 
 Mon, 04 May 2026 00:36:29 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-44a981ded99sm24281599f8f.18.2026.05.04.00.36.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2026 00:36:28 -0700 (PDT)
Message-ID: <41b7b58e-3d58-4e48-9656-2b0cfc4659a4@linaro.org>
Date: Mon, 4 May 2026 09:36:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 06/58] kconfig: remove duplicate declaration of
 CONFIG_MIPS_BOSTON_AIA
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20260430172204.1006673-1-pbonzini@redhat.com>
 <20260430172204.1006673-7-pbonzini@redhat.com>
 <09b2ec62-4b67-41da-893d-aaccf011537c@linaro.org>
 <CABgObfZU_r-xF_iUR+DVA_GkcvzFv878CRAcBh5go864aD_Jqg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CABgObfZU_r-xF_iUR+DVA_GkcvzFv878CRAcBh5go864aD_Jqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 4/5/26 09:08, Paolo Bonzini wrote:
> 
> 
> Il lun 4 mag 2026, 08:28 Philippe Mathieu-Daudé <philmd@linaro.org 
> <mailto:philmd@linaro.org>> ha scritto:
> 
>     On 30/4/26 19:21, Paolo Bonzini wrote:
>      > Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com
>     <mailto:marcandre.lureau@redhat.com>>
> 
>     This was not reviewed by Marc-André (at least not publically on
>     the list) but by Alistair and myself:
>     https://lore.kernel.org/qemu-devel/20260430090534.841894-3-
>     pbonzini@redhat.com/ <https://lore.kernel.org/qemu-
>     devel/20260430090534.841894-3-pbonzini@redhat.com/>
> 
> 
> He did for the whole series, and then I sent out the pull request 
> (having had reviews) before receiving the messages from you and Alistair.

Indeed you are right, I missed whole-series review sent to the cover
letter. I suppose the other my other hiccup is due to emails delivery
delay, not seeing your PR was sent later the same day. Apologies.

> 
> Paolo
> 
> 
>     Not a big deal, it just shows this email workflow limits, as
>     reviewers might wonder what the point of doing public review if
>     being ignored.
> 
>      > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com
>     <mailto:pbonzini@redhat.com>>
>      > ---
>      >   hw/misc/Kconfig  | 8 --------
>      >   hw/riscv/Kconfig | 4 ++++
>      >   2 files changed, 4 insertions(+), 8 deletions(-)
> 


