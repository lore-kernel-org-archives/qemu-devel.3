Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56BFEF8A16B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 12:24:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDLlI-0007KZ-2a; Thu, 16 Apr 2026 08:24:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDLlE-0007Iw-Fl
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 08:23:57 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDLlC-0006Yt-N0
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 08:23:56 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-651c366f7efso4739401d50.1
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 05:23:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776342233; cv=none;
 d=google.com; s=arc-20240605;
 b=GcDU8Ix6ThTz1g3U6n7ynYOm809ddv4sEZHKI/YY2mKVW7XSfRGDYLPUQ3mHy0Ctx+
 C3wkD81017qTlqHD0d0l+AauczcVsbWYCtcwNbtoH7w1ZR3ubtuOWj5cF0bDLjIRCm/5
 F6fPTGT4I16hlhH2O5qCLjiYxVyPoln7CBZsNgisT31iZJi87SfMhiA4M1yc+21lx9FD
 ago6cWtLvQijJdUr0s+Cmd2ghJoKorzNSsrrNx+4zHQdcujHdn2c7qgiNeFZQXy4MRyZ
 /m09+f8cXzP51DSFdfh/rL9nb9ZG/jdqVvsG4RrZiI0FGCZRv8BMwm0AKvIFKCxQmdXv
 rY2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TFGc0YBpWo+JvdU5X0cwWYOsCSVIzXFF/QJK3d+i/Fs=;
 fh=SkZIdOPdZGrTzofo7LuvVRVZ9veA1Va7UgxeeU+t4Cc=;
 b=gUVCrXDDdOZsGEpV02Oxj6AVduhNAOguBF4MoNTdAIxcOpjcWEaLCeLx/WhAfw0LzY
 A4ACOkb26aqIWTZDYNlTDGcak41QUxnfuNF/bXnLqB6u/yWSZU5YKry84JkQS/S1Sabi
 hj+YROJRihrry8bxE87kQg2Gnkfaz+s5uw8f8NSPx5ZgWYBdLs4RaYwqqdmco5jBBKmN
 vFS/1/6fgiC4C93YYS1iGb2TBOJzaq0S8Uk9SeYrW0QOBmvLTGozVvLFsr4FakCNUvld
 oBxxAAL85JveBzg8ADFq0Kw/Y/nOmIYxgigb7WobZ07LDGwSC3AeeL+uOQV3j0/tVVAm
 g8+Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776342233; x=1776947033; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TFGc0YBpWo+JvdU5X0cwWYOsCSVIzXFF/QJK3d+i/Fs=;
 b=j5ijTcrpeQeQEQhCf5kPA//HEINQRRl3eVuWQDwR7wtE31xdPX+ib2LGnOETLOcmSh
 kQHUHTpYjrDVG48DLyItJyqeU9HlZANTsilc33t+urw8RIxemJSKzRwua6w86kDTlkHS
 LOQsrfagWNmZ/BhGSMZS5RPMrQxgPKYfYIYqT2oW7ZbqsDP8gEyoNv7nz39Iu/pwDEol
 GcFltEvbwccoAOpDFoDgcVo/Zd5VR7E/Z8a+m7Ajxu7btxLAWHMPUOl995G8olKZDJBD
 oulHUerPjifpLJRGx3HjWcVEGqKek7WhOL0VowfSHU+5k41ukCSyIJTBKW8ZXtUgHbAO
 do6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776342233; x=1776947033;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TFGc0YBpWo+JvdU5X0cwWYOsCSVIzXFF/QJK3d+i/Fs=;
 b=bqspUHWmBE0teBmmZI9uKGBbyDixp/WlS8cHhZlhxE47M/27tzHPqlXSz9QmT9TDsC
 x1diRmvkuwmwRSsXSxkQPRj38/W7LehfZbEUKCGIBJ8BgipxDaGOsT5MaKbHlyl6gwI3
 MXeNXQ0wn0XfKxQo/pjTxnVdSzBjDdXhDTw4KTtFkMp+0h6JcoEJ8fTeoTLCXosH7wsx
 73cQis67ZFK77Pu3ryHg93Gefqn1V8ADmWYQRp8YyK9FGcZPvrdkP6kVfNTSUZD5dCUl
 GsewnzLW0EW3sPmCRZaXGSFlppIEH3CWWJ85MfGLUdrGfzFl3MaciLMNh+xgG7zU436o
 ISgg==
X-Gm-Message-State: AOJu0YwozVa9mfh/vuujva1xoBMkb+7OQXeWwgPjfaivT8/cBHTdTSsI
 +2I10+BmprPMfg81q8MrZtdzS/NEcX+cPqCPaMklcZrYJdTKMB3W0SfUwuE3sCmbku8NAncfYbc
 eWwIjHi6AnKHnA98UjWLlrUEsINTiuh59CAtmzpoZEA==
X-Gm-Gg: AeBDievrtgFY3gagFgmWXo326/3vgxLh9w7bTvjsacwXK3PndS4MelEVeMqkwG7RVlQ
 tLRkeXKdWm4gzCbX2/Y3V8Ctsvs/Tq87n1PPw+yHB544tPlArLfTgFYQsg6SSY9k0UmWog0l/bZ
 5p/1/qlBpFZUsO9MnXZnUaGnXzRwzyZ8dupYzmcWd1r46PRZvJZSsdtStCa8uOsVd07xntdlwXq
 +quXLHeGzC43ULVIB9misYy3bmM++URSWdyP8U2NgTuooXyTLhQo/O5ASKQ9Q3FxfiHL2Bo38wA
 mnibN2FwtrCtwxq0APH1WD86TZpqo4G9pB2b6C2nNzPv1LzKHci9lUsNJVtwvID3An9xDPpOtVD
 OVDVB4EsPSVc7
X-Received: by 2002:a05:690e:1287:b0:651:daf6:3d85 with SMTP id
 956f58d0204a3-651daf65a34mr11428670d50.30.1776342233368; Thu, 16 Apr 2026
 05:23:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260416091654.316158-1-peter.maydell@linaro.org>
 <20260416091654.316158-10-peter.maydell@linaro.org>
 <e41baa82-d096-41e3-bd27-5a4be359f842@linaro.org>
In-Reply-To: <e41baa82-d096-41e3-bd27-5a4be359f842@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Apr 2026 13:23:41 +0100
X-Gm-Features: AQROBzBcZHBkJ8rDx83GfcACcsaq-vHniJz9Vx_YF2pnk5UhgDTr6bLOOGJ9WFQ
Message-ID: <CAFEAcA_6SCOorXp5i2dyeBZXNtq6Cvm2gkvk8EC1sOf2CHMo9w@mail.gmail.com>
Subject: Re: [PATCH 09/28] MAINTAINERS: Remove WANG Xuerui
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu@xen0n.name, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Thu, 16 Apr 2026 at 12:25, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 16/4/26 11:16, Peter Maydell wrote:
> > WANG Xuerui has not posted to qemu-devel in some years and did not
> > respond to a query about whether they still wished to be listed in
> > our MAINTAINERS file.  Remove them, on the assumption that they are
> > no longer active in QEMU.
> >
> > This makes "LoongArch64 TCG target" orphan.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   MAINTAINERS | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index a7fb4e4770..0b2adbc247 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4115,8 +4115,7 @@ S: Maintained
> >   F: tcg/x86_64/
> >
> >   LoongArch64 TCG target
> > -M: WANG Xuerui <git@xen0n.name>
> > -S: Maintained
> > +S: Orphan
> >   F: tcg/loongarch64/
>
> FWIW Xu=C4=9Bru=C3=AC posted a patch 4 months ago that we ignored:
> https://patchwork.kernel.org/project/qemu-devel/patch/20251207055626.3685=
415-1-i.qemu@xen0n.name/

Oops. Unfortunately the scripting I did to find people who haven't
been active will miss cases where people post to the mailing list
with a different email from the one listed in MAINTAINERS. That's
a perfectly reasonable thing to do, it just trips up my attempt
at scripting.

I'll drop this patch.

-- PMM

