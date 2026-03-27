Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D40D510AB83D
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 14:55:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w68aW-0008Sy-Vr; Fri, 27 Mar 2026 10:55:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1w68aV-0008P6-2b
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 10:55:03 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1w68aT-00067p-I9
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 10:55:02 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-486fd27754bso20726745e9.3
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 07:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774623299; x=1775228099; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8522jydhDi0SeQCOFlDhnr1k4SiYzp75PbmWcbVL7VM=;
 b=qWXOmMUVaXMbfy0pcxt9CRQTZ0KHiGPZ/3/ETR6DhvKrnDwIkFgABolq1G3o2K6Ze+
 RBhp+mP9nEHPgAYs4cBt6uTOZKbQc6wkQKkISOEALp3JYQqX30ZjScjYRulSgEs0BuQM
 hfcdXYh7Z1WamrwAjB+bSg8WBwDFRGycmeFKWPmh4ANYFYKSOc0xwKzEjNEnAwWjN1NX
 btcZdhJjaPUH5LmWA6kaalu4KIfqZGM3mnq3upVqkpn9YE92pCqimiQYITdbr3LwZga/
 ry/s3OyBZiPw1VEnTeEsKoMeLmYlMk7GYYbL2QwlZq3T8myMHS0YJP0/vvvN4HHziA/j
 lZ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774623299; x=1775228099;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8522jydhDi0SeQCOFlDhnr1k4SiYzp75PbmWcbVL7VM=;
 b=h15QSjhW1YLhUvnjboyXK58IImuHOHbcXpHVRSRnpmbPDVDvZNen5N8SyhE/FHbkFF
 3H754B8AIbZ9nOtHbhJQUjMQByZVhBcrPLNr9oiEEKg9UWWqrSp2US2mG7mxNu13v0ph
 FxCcUXSrGzn37k6eI5Ho9FUdBFbpMrGP6Och1gwNrBizsj2prERWz34zrYdddRqLmw0R
 j0flkynGIj2kzzjBahzABQfF+asws5gG/12n308oHo37/bE5bMICKJeHTgnbem89tfUg
 0kykB+deU6Mv+Y+FGgtriUateZD/tGqEW/XZiHLud/u1SKHJkQ7iR8yeu7g7afvgimev
 zrkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXk060xDfbiu020qXvQoRH7HEiJJSpxDRWbS0NBMYPe+JS0zQq/6eXJ+K+UUfeQRg0vUrN7ucCbipD5@nongnu.org
X-Gm-Message-State: AOJu0YyXbAw075FLkBY7BfiMuw4yEgu3rhirrkH4Iblo6n5P/nA7BVLC
 tMGY94a3z18mKwfHCvl2vZMaRL4MFhDVYttR1Jn4R1gomAWWL/aJ5eImETE37H0CY/CuCAeyc6Y
 fAeUv
X-Gm-Gg: ATEYQzxbV9kYWSm0hqUd61nkc4+NbAuyJ9K8rAbBydqu67iYChj4fEbbrxEusS78kVZ
 KrCO6/uChUlL0/DS9SGpJdSdPK+DL2epwQqmM/qshc9xNs1u5aa1mM5DRjJ3kwxRgewrkMAu/E6
 4RcX3qg4ThwiIj3gRXzrNO8BTCWTh6DUVocKQCStm5mOR0c2rhv1apYakNeK6WitP42gHcD8nnB
 5sSLfcrH4DvKJoerE1uvlMSxPmbTnDNtW+iopm9K1pJd6zwF6LwCjqlSz2xC6vowMEyGO1nizRJ
 LUnN9QzKI+qhtffZo3BaVPAKt3OecczHCUZKU8Mb4m9xH4/5B7vPoHhLsg1zg9FHPlPTL5h9YBQ
 q9svwM1GgBu/T0fbCrZGw5ohnxqIn0A4Ap11jeYMuYCyM28LE8wATsq/bk/k7mcSHWul9DD33BK
 m3bvBZQ+7Cxz5ewSq5lKDq2VPpVKm6FYo9Olg=
X-Received: by 2002:a05:600c:6211:b0:487:2439:b7be with SMTP id
 5b1f17b1804b1-48727d59badmr50079905e9.6.1774623298924; 
 Fri, 27 Mar 2026 07:54:58 -0700 (PDT)
Received: from linaro.org ([2a10:d582:31e:0:66fe:5836:46c7:fd55])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919432f0sm16550151f8f.13.2026.03.27.07.54.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 07:54:58 -0700 (PDT)
Date: Fri, 27 Mar 2026 14:54:57 +0000
From: Jim MacArthur <jim.macarthur@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH RFC 2/2] tcg/aarch64/tcg-target.c.inc: Manual replace of
 I3310, I3313
Message-ID: <acaaQT2sH178SkZ7@linaro.org>
References: <20260319-aarch64-tcg-instruction-format-rename-v1-0-8a13bf98f8ff@linaro.org>
 <20260319-aarch64-tcg-instruction-format-rename-v1-2-8a13bf98f8ff@linaro.org>
 <7be1406f-11ca-4422-bb3f-bc344d736ad7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7be1406f-11ca-4422-bb3f-bc344d736ad7@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x332.google.com
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

On Fri, Mar 27, 2026 at 12:50:13PM +1000, Richard Henderson wrote:
> On 3/19/26 22:12, Jim MacArthur wrote:
> > These are not formats in themselves, but extra constants to OR in with
> > the existing ldst_imm format.
> > 
> > Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
> > ---
> >   tcg/aarch64/tcg-target.c.inc | 64 +++++++++++++++++++++++++-------------------
> >   1 file changed, 36 insertions(+), 28 deletions(-)
> > 
> > diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
> > index e9f86176d2..1f59d40a77 100644
> > --- a/tcg/aarch64/tcg-target.c.inc
> > +++ b/tcg/aarch64/tcg-target.c.inc
> > @@ -458,8 +458,9 @@ typedef enum {
> >       Ildst_imm_LDRVQ  = 0x3c000000 | 3 << 22 | 0 << 30,
> >       Ildst_imm_STRVQ  = 0x3c000000 | 2 << 22 | 0 << 30,
> > -    Ildst_imm_TO_I3310 = 0x00200800,
> > -    Ildst_imm_TO_I3313 = 0x01000000,
> > +    /* Additions to the ldst_imm format */
> > +    ldst_imm_to_sign_extend = 0x00200800,
> 
> "to sign extend" is wrong.
> 
> C3.3.10 Load/store register (register offset)
> 
> Perhaps ldst_imm_to_reg?
> 

Quite right, ldst_imm_to_reg does make more sense. Thanks for checking.

Jim

