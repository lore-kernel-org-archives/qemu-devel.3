Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09C5CC021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 17:13:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlA6M-0006sI-WE; Thu, 20 Feb 2025 12:12:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tlA6L-0006s2-Q3
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 12:12:41 -0500
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tlA6J-00008y-UK
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 12:12:41 -0500
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e4419a47887so1013979276.0
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 09:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740071558; x=1740676358; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Dck2tyh5wCRGMQqeayqCI382a6jcegyTmEK0hYlz8+c=;
 b=OHYwJcQeabK6KFGK9FT/oAZSaz2kfuPQQyG56YMPva3YPRjOjxDkbTo4pn1gSqjhdF
 AmUNoX/DZ8sjWkqCRYI67CWi5aohAcSaU/egj1COue4S38eE29JHmytgTuZhD5Agu/+r
 Q/XJVFQoykqoWXWxu+22vHqz4ZSyMqB93ea6aHjUxe2orT8mp1l+uZzRWET9wpNi9Ugi
 B5uhvTE4g979bSyu2vi+fGj0noTv7rU9NwPTJSn7EDskp8ac6VxKzBZlSMTRdo9REEgh
 Gl5ITGYICjh/E545B6K/ut6t58qS/Ob8uVns4LROIY0raAcxVOuH3K8AV2CK/0lKBp8Y
 ZZtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740071558; x=1740676358;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Dck2tyh5wCRGMQqeayqCI382a6jcegyTmEK0hYlz8+c=;
 b=Ql6Ze/CHGpU/pW11NELCLe8XmLUwHPwa7eFZE6ltKoqAey450V64eLRVOeCC2Ji9+j
 GBYOAUg2ShNfspN7hZYOVFtRHcj879IQiwOfGWEYfKc3BNog1OgWjGGsOIdF6RSdnNEb
 G4rxajr/LtHftRfpdUVgzmljQTozH0/Zi6iciTWVdfWLr4xOLr61CqisxfbHbDmgDzSb
 WSxcnJ7GeRwKdVexGwRxzicvPNhM8WjO46akXNRi3yEpriifkS2Ge4dVc3Nkj24ptVau
 ZzUYcTLFAYLtYkeJIQG0Hj7OxHB/n3nh1/uYW1gAbzpzsf6vV7X7ttJMOAMPheqB5KAd
 adSA==
X-Gm-Message-State: AOJu0YzLv/GWI12CBiyrlxzc7fsOlmmRPCERYfcFNKkoLn97KoI8RvJn
 kbkZrvXWuUMSgO+99+7tx3ROieDOwR88fRhtFo1a0tyozC26F/XzVwVx/agAvRRHLXbI1Xuh0k0
 AVMjaPEXrUfm46cW1/sxYXs27oBtkdd7sf7nzgQ==
X-Gm-Gg: ASbGncvEDRtyHnDy5UMxE66okIsseJcOtwZt7tGa6CHiJ/HKgRUPI0PPJR4v3YsIyDg
 OQQy0VD9qfAqzztb5CiXf69nK0VgBNispCV39RmJz5JeLUnlpSrnkYkF+xe9jPHy4zr2wAl6RFA
 ==
X-Google-Smtp-Source: AGHT+IFsT4mmN0jm/PZ3rE1HS6Kg0O4gSDhkEF3Fou7Qxa1dDGMmhQ4G58n7gZWu199grdGyW/MLs9+if6DqBWmg24o=
X-Received: by 2002:a05:6902:2488:b0:e5d:de0e:57eb with SMTP id
 3f1490d57ef6-e5e24602516mr11852276.23.1740071558183; Thu, 20 Feb 2025
 09:12:38 -0800 (PST)
MIME-Version: 1.0
References: <20250217125055.160887-1-peter.maydell@linaro.org>
 <20250217125055.160887-7-peter.maydell@linaro.org>
 <64deaf4f-b999-41aa-ae44-876a1860a10c@linaro.org>
In-Reply-To: <64deaf4f-b999-41aa-ae44-876a1860a10c@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Feb 2025 17:12:26 +0000
X-Gm-Features: AWEUYZmJRdahKROKFk8cPdVoFNagKi_Jxw3tUKNq6AXvEeUHPN5oy6caJDU2hws
Message-ID: <CAFEAcA_upC=ty1PWXOSsHHgk67EoPi6rB2DhK2M5_q2mzUCW=Q@mail.gmail.com>
Subject: Re: [PATCH 06/10] fpu: Move m68k_denormal fmt flag into
 floatx80_behaviour
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b30;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb30.google.com
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

On Mon, 17 Feb 2025 at 19:14, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 2/17/25 04:50, Peter Maydell wrote:
> > Currently we compile-time set an 'm68k_denormal' flag in the FloatFmt
> > for floatx80 for m68k.  This controls our handling of what the Intel
> > documentation calls a "pseudo-denormal": a value where the exponent
> > field is zero and the explicit integer bit is set.
> >
> > For x86, the x87 FPU is supposed to accept a pseudo-denormal as
> > input, but never generate one on output.  For m68k, these values are
> > permitted on input and may be produced on output.
> >
> > Replace the flag in the FloatFmt with a flag indicating whether the
> > float format has an explicit bit (which will be true for floatx80 for
> > all targets, and false for every other float type).  Then we can gate
> > the handling of these pseudo-denormals on the setting of a
> > floatx80_behaviour flag.
> >
> > As far as I can see from the code we don't actually handle the
> > x86-mandated "accept on input but don't generate" behaviour, because
> > the handling in partsN(canonicalize) looked at fmt->m68k_denormal.
> > So I have added TODO comments to that effect.
> >
> > This commit doesn't change any behaviour for any target.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > I'm confident this commit preserves existing behaviour, but
> > somewhat less confident that I've correctly analysed what our
> > current code does, in particular that it doesn't do the x86
> > mandated "handle pseudo-denormals on input" part.
>
> Test case:
>
> #include <stdio.h>
>
> int main()
> {
>      union {
>          struct {
>              unsigned long long m;
>              unsigned short e;
>          } i;
>          long double f;
>      } u[2] = { };
>      unsigned short sw;
>
>      asm volatile("fnclex" : : : "memory");
>
>      u[0].i.m = 0xc000000000000000ull;
>      u[0].f += u[1].f;  /* denormal + zero -> renormalize */
>
>      asm volatile("fstsw %w0" : "=a"(sw) : : "memory");
>
>      printf("%04x %016llx  %04x\n", u[0].i.e, u[0].i.m, sw);
>      return 0;
> }
>
> Expected behaviour is setting DE for consuming a denormal.

So, on real hardware I see
0001 c000000000000000  0002

and on QEMU, with the patchset that fixes the DE bit handling
https://patchew.org/QEMU/20250213142613.151308-1-peter.maydell@linaro.org/
I also see the same thing.

That suggests that we are correctly implementing the x87
required behaviour in QEMU, and so that the TODO comment
I add in this patch isn't right. But then I'm a bit confused
about what the code is actually doing. Why do we need to look
at fmt->m68k_denormal in the input (canonicalize) code (i.e.
to have different behaviour here for x86 and m68k), if
both x86 and m68k accept these pseudodenormals as input?

Is the difference that for x86 we accept but canonicalize
into the equivalent normal number immediately on input,
whereas for m68k we accept and leave the pseudodenormal
as a pseudodenormal (well, m68k calls these a kind of
normal number) ?

thanks
-- PMM

