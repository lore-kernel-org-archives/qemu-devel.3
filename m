Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47616C0218F
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 09:55:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcLpX-0000x7-8W; Mon, 27 Jan 2025 04:54:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcLpO-0000vQ-8f
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 04:54:46 -0500
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcLpL-0006mv-Ux
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 04:54:46 -0500
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e398484b60bso6162536276.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 01:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737971681; x=1738576481; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SaFx5AsSluXaTySUd0lAk0jzO07EJ6XLZxNTSbwUjHY=;
 b=sU84f0ri3vCCLJ1hTGH7CbZPtHmWDaVvho/jU+Q88kiw4sGNOHq+YlfrXHcD9KIgXQ
 IBCAsLGrkdiW8T7JwfBKtenCgOpzEAsleHgog17G1qgVhOJUzs7DpLcorBGonnxbO81/
 zL5ArK3sPE9uiqxU735ZHzLCTyetmpMQVsp1yw/2aYz7qs8GS81HzSd0nHmWz+ERaNB7
 JXbPGTK0bsqBhVMLNtW/ZDBOHjUTOU1bbH6xzkm91ha2KKLbXtKzfkY6VlcDqPX/xN33
 z76ct6vHhGkLdGKenqPpnvQ0t4dEQ8MO/J4yERKtAmvevJ+cLiWmdEWYmVe4EVMY30W6
 fLzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737971681; x=1738576481;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SaFx5AsSluXaTySUd0lAk0jzO07EJ6XLZxNTSbwUjHY=;
 b=vhIZ+rTx+zKpOR2ZlswPP8sTJLGB6sf7dBzm5t1wrcQazdVM5fX1cKbFZuLFv2h0T0
 sP0YXIEI9lS3Aqw/fr2LofLPmUEJynGRgsh4u9tNwarzBxmqLdBYpKicYItDUDNkLid9
 HiHsFTio28hb77oK/ppQ5or9XVBR3P+48ElDprSJVEzwVSnNYATw1Ddnne0W0nikfmGD
 N0zYVGRf4qumvismTiLLvASDrEiqSBe/OhL18qCSGmYFOsIuFbftujMT48BcjRP1Y08y
 HUkyXunO1CykeIK0mckExs1PoWlb934pyS+Hyph5W2NU0AAH7/mbs20JLI4fQ0Nx6/sU
 bc8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXffXYCsraeLMamCwiZ07+ND/adne0tH9mVPZuwaI1SNN6uqpHmLFN/okh3AUTi2B/Ccz0aGhRjMI15@nongnu.org
X-Gm-Message-State: AOJu0YxED+B+O8Daujs/3QTtkESWetqyR62z/hfC3mVejQEsrgjILNSE
 bXh+/HfI0M38iNg330EwrM/jr+z4juA8p9EX0ivr+XsHQnPDy4KRge3lEI1eAugJTOyht7QEGEo
 zHk5eChQm4prcTSu0depf/JKJzhu2KiTbCTeJqg==
X-Gm-Gg: ASbGncubrGPyYhKhIOWfeFqjEUCa2oCxAk2lXw86vmV6Z0f+l3CpDumvC8rFRDwy1bn
 hCsH7o+u/nhrSqIRTzrv+G2n319FXK1FJWEHzpyMuZZrdK7N5gtcoeA2IAWJ2Pfg=
X-Google-Smtp-Source: AGHT+IFdfq8MVmjFTGY6IdNHjHFJGE/2PTlrrVXChNXrIH2RY6s0n6Uz2li8ZSo01vnWiwhkYGbo/9MPHO5uCTKuHWY=
X-Received: by 2002:a05:6902:10c8:b0:e58:30dc:615b with SMTP id
 3f1490d57ef6-e5830dc66edmr9480156276.22.1737971681470; Mon, 27 Jan 2025
 01:54:41 -0800 (PST)
MIME-Version: 1.0
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-3-peter.maydell@linaro.org>
 <87r04si15d.fsf@draig.linaro.org>
In-Reply-To: <87r04si15d.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Jan 2025 09:54:30 +0000
X-Gm-Features: AWEUYZnFn4dk-Uh-xNZQkU1dCUCT8VIaBX6KZlRlUoBeC841rKowp6mjgEaUTww
Message-ID: <CAFEAcA-LrHsiazeVa1Zx9QrjJsaDvOe0vGtk9RQYUOpiEyDqFA@mail.gmail.com>
Subject: Re: [PATCH 02/76] tests/tcg/x86_64/fma: Test some x86
 fused-multiply-add cases
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b35;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb35.google.com
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

On Fri, 24 Jan 2025 at 17:15, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > Add a test case which tests some corner case behaviour of
> > fused-multiply-add on x86:
> >  * 0 * Inf + SNaN should raise Invalid
> >  * 0 * Inf + QNaN shouldh not raise Invalid
> >  * tininess should be detected after rounding

> > +static testdata tests[] =3D {
> > +    { 0, 0x7ff0000000000000, 0x7ff000000000aaaa, false, /* 0 * Inf + S=
NaN */
> > +      0x7ff800000000aaaa, 1 }, /* Should be QNaN and does raise Invali=
d */
> > +    { 0, 0x7ff0000000000000, 0x7ff800000000aaaa, false, /* 0 * Inf + Q=
NaN */
> > +      0x7ff800000000aaaa, 0 }, /* Should be QNaN and does *not* raise =
Invalid */
> > +    /*
> > +     * These inputs give a result which is tiny before rounding but wh=
ich
> > +     * becomes non-tiny after rounding. x86 is a "detect tininess afte=
r
> > +     * rounding" architecture, so it should give a non-denormal result=
 and
> > +     * not set the Underflow flag (only the Precision flag for an inex=
act
> > +     * result).
> > +     */
> > +    { 0x3fdfffffffffffff, 0x001fffffffffffff, 0x801fffffffffffff, fals=
e,
> > +      0x8010000000000000, 0x20 },
> > +    /*
> > +     * Flushing of denormal outputs to zero should also happen after
> > +     * rounding, so setting FTZ should not affect the result or the fl=
ags.
> > +     * QEMU currently does not emulate this correctly because we do th=
e
> > +     * flush-to-zero check before rounding, so we incorrectly produce =
a
> > +     * zero result and set Underflow as well as Precision.
> > +     */
> > +#ifdef ENABLE_FAILING_TESTS
> > +    { 0x3fdfffffffffffff, 0x001fffffffffffff, 0x801fffffffffffff, true=
,
> > +      0x8010000000000000, 0x20 }, /* Enabling FTZ shouldn't change fla=
gs */
> > +#endif
>
> We could extend the multiarch/float_madds test to handle doubles as well
> (or create a new multiarch test).

This test case is specifically testing a corner case of x86
semantics -- on Arm, for instance, you would not get the same
result/flags, because Arm does tininess and flushing-of-denormal
before rounding, and Arm does raise Invalid for 0 * Inf + QNaN.
So I'm not sure that a multiarch test would be possible.

-- PMM

