Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3CE4D0EE3D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 21:31:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vO0c4-0006NF-N4; Tue, 25 Nov 2025 16:30:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vO0c2-0006JL-A7
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 16:30:14 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vO0c0-0001nP-Bt
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 16:30:14 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6418b55f86dso10184460a12.1
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 13:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764106209; x=1764711009; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4bkoJOtlp2uXy7BPljTNErPmZ2OxaD0w4WD8La9ZV9k=;
 b=YrHHJMGQ5K9kzCDxOSJ8M6cZfwaZzCZxT+vfSzejdNnHLP8Sn2MuH1Kcq5rgLKI4yN
 vLHzwkfy5lqDEr+rk4lj7Wvq6eHZad2REyRCBy6iGUC83qxeWvS3ycVV3vlf+EZUbBnt
 b0n4tgp0xrfQVhdlaxZNwKrDl1OQOZ+yr+2Zy+1Th3y9WqoMTz/J/iJzD494DpYrI6Z5
 i9tnUgRZq7095b6tUVQUuOJD1ijCgDhc+QhstbdnfrOAcq3vbCKU2fiaYLgk1OGCvFz9
 73swRU+TbU6h/4c7v3bvCTacmzaPbAihabcaau2D5iJWVOT04XhQ/q472AEpnHkGMYK9
 /JyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764106209; x=1764711009;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4bkoJOtlp2uXy7BPljTNErPmZ2OxaD0w4WD8La9ZV9k=;
 b=FmGZoUjFPPSeNbPZQeeKkw0h11EeTKdiLaSDHCS5arYHjdOnQUKUSrEqOLogk233Ei
 0677nCbh/Q4UEXJiUIlWo42OS7F6cZepPGokhyp9vGm3lrvIu+NMVwo8lfaLrBk6a4Th
 3MJunUwyJslhR1IiggvIRsGRLMtJNQZKpNAtb6sji6i3P4PgPByAKZ1T3O3Ni17HD8c9
 2LwRca6qUmmAuVwA/fDf6r2BCm/epoC4JK0t9/5RtrOGJ+XHPP96xAKVH9baAzUjylxo
 XzP+9N44kahuZ5Iy4D3U1KZtU1Df0iC/Aau2eUnwDC7x8RQuKLZ7ZhB4xipDpMCxiUhh
 42NQ==
X-Gm-Message-State: AOJu0YycaKWF2iRF4k7JShEpYPau3aDlz6H5KNse0kGEL360NmRepSRN
 Oco7xhL1u3y4vv/3YjnKYQou3eaaBOp8PTyTLFNC1sDL+HPF6pk3rqrngKfyt9S2kL0er+Wmlcr
 y6h5hHugnybEbRWAdECnrqg5+8f5yowQCfNUY1DJ+lA==
X-Gm-Gg: ASbGncsjUF2IRsTcsOE+EA8iYFbtE8/OnNJhbyprFhRltROwG2zH563zAQA8EQYUl6p
 koClO9DQNrHNPhWCSt18u9BwUEIzH5BQNoRO8jSwz6kKRzr63YIlftpcE5CQX3mYkrgGo0HZ9Eo
 QwX/3qj2dMw4x5VZaKZhP9rMAlQ8TxzaUBD65aQQjPF4H+8oXzqUVp3yvlAnt7HAfAr25BzcMzR
 KnD/yRR/CTQ7hPyUU/J4Qxza+vP+8vsbBKktOHzv5/n97k5v+6JxnZDKYmYCaG4GamC0mM2GZVW
 /mwVY3MW1gbTsODYKOr6ou7IxitCWXBZFiY=
X-Google-Smtp-Source: AGHT+IHb0+oS3wC1aHKHTdrXlyZ5RSbOHa9+jIcaGgUt91D5a1pgg2y5f7jZeTSWJkgoz65ShSE90dAc13JrFovRCSo=
X-Received: by 2002:a17:907:9289:b0:b73:76c5:8f7c with SMTP id
 a640c23a62f3a-b767184bc4cmr2008980766b.43.1764106209389; Tue, 25 Nov 2025
 13:30:09 -0800 (PST)
MIME-Version: 1.0
References: <20251120125833.123813-1-jim.macarthur@linaro.org>
 <20251120125833.123813-4-jim.macarthur@linaro.org>
 <87fra38ogg.fsf@draig.linaro.org>
In-Reply-To: <87fra38ogg.fsf@draig.linaro.org>
From: Jim MacArthur <jim.macarthur@linaro.org>
Date: Tue, 25 Nov 2025 21:29:58 +0000
X-Gm-Features: AWmQ_bnY3_WLus7EP799GVl_wVy48ugxfQz-GtjqCeKkiyJVmR1zty2cwV5cbW8
Message-ID: <CAJfKr9W7DuFGkARhSYfT=aumHcZvFbp3pzV0VLxnqaDUn2JQAg@mail.gmail.com>
Subject: Re: [PATCH 3/3] tests: Add test for ASID2 and write/read of feature
 bits
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=jim.macarthur@linaro.org; helo=mail-ed1-x536.google.com
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

On Mon, 24 Nov 2025 at 15:01, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> If we instead use this to test for the presence of the feature and then..=
.
>
> > +
> > +    asm("msr " TCR2_EL1 ", %[x0]\n\t"
> > +        "mrs %[x1], " TCR2_EL1 "\n\t"
> > +        : [x1] "=3Dr" (out)
> > +        : [x0] "r" (in));
> > +
> > +    if ((out & feature_mask) =3D=3D in) {
> > +        ml_printf("OK\n");
> > +        return 0;
> > +    } else {
> > +        ml_printf("FAIL: read value %lx !=3D written value %lx\n",
> > +                  out & feature_mask, in);
> > +        return 1;
> > +    }
>
> extend this part to check the bits are behaving as the feature dictates
> then we can add a second test like this (Makefile.softmmu-target):
>
>   run-asid2-oldcpu: asid2
>           $(call run-test, $<, \
>             $(QEMU) -monitor none -display none \
>                     -chardev file$(COMMA)path=3D$<.out$(COMMA)id=3Doutput=
 \
>                     $(QEMU_OPTS) $<)
>
>   run-asid2-oldcpu: QEMU_OPTS=3D-M virt -cpu cortex-a72 -display none $(Q=
EMU_BASE_ARGS) -kernel
>
>   EXTRA_RUNS +=3D run-asid2-oldcpu
>
> Although its a bit clunky - one day I'll get around to converting this
> lot to meson.

Good idea, but as far as I can see cortex-a72 doesn't implement
FEAT_TCR2, and nor does anything other than cpu-max, so the write and
read to TCR2_EL1 will be undefined behaviour (and causes an error in
the test). I could (and probably should) add a test for FEAT_TCR2 as
well, but it won't test anything more than my original test covers.

Jim

