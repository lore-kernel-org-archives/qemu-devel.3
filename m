Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE640C44501
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 10:33:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whPaJ-0007mp-Kn; Wed, 08 Jul 2026 06:32:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1whPaG-0007lx-I6
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 06:32:53 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1whPaE-0001PK-MF
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 06:32:52 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6983f20a8bfso948699a12.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 03:32:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783506769; cv=none;
 d=google.com; s=arc-20260327;
 b=at2st/NjqohbZne00NSDmQ4UHF6KfmXoFEaJpuS/Prt+mu2xOiOIya39anuj1cEPLu
 VDJSlKSl0ebkLEeN6cFVYE7IJqXxvw4RbT6fIvpxNC2rUMTLZHYc9PgncqZi2Y+JeXt0
 AtO4Hbu+WF8IHXRgQieHtySynvYfcHA/l+ow8naFEFtGHh0BqTvu0K/b2PVq64YJLhZH
 wTQS7/2vBbkLpMwqqM9W+/Fiuak1zvbHzTwCDlKGXIvgzZXgvQOgkNnTG85ruKznatja
 QRZ7Ht4aOKFNnSVZTYnIl0IiCzSA2FD2FqRZlPPGnu1ANU4CfkV7jrt6TuqAAgZW36QQ
 DKEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=eNVXL+JaRknDc0HvImFDwNcfU8artJh+cfFv4vMrtFQ=;
 fh=xA0dvkNCzq3wUh+50cH3n3rkqIUyItuZu48hg9SmUR0=;
 b=P0FJ8Y+Io3bcth3K4hgvQaBw2oiYHh1ScgknorwAige7/w/Q89osntj2K5dWzOVPew
 /Iazo1CKZKt+rAlDO7WIMhW+/NM/Z0gCuqJGzjTLlYKg8FYZNryhcVIrXeDoivIIwj/d
 hR3lKeaKNDfVxu4j2VPu2oDWHfunnQpDJ9QZ4dRmIMBtYLne7tmAVAR24dxJX4pohgFL
 MnbYr27EYfw10RSOpUGYE+rm/XsHTKq7ehVnU7pZXyEy1mdss/verqGHa7bU3yOiMi5+
 NhWmPhT7DwkxZYu1p5sn20BfdzS0Ft2FUSPp++GLDMymAjI6WbIsOKOUplkhCB05J2Ma
 uuCA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1783506769; x=1784111569; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eNVXL+JaRknDc0HvImFDwNcfU8artJh+cfFv4vMrtFQ=;
 b=LBJKKhoCHaa1AMP/6HPqJsEBTChFsp0YwEfHwYmOfMm/2r1jP7GQoAGapIKGgG6TfT
 VoVRIV73kdTtuzTSuQvhlRPP3YgxMDDE3T/tGR8wu2e5b+Q0r6/QfNf6D1FasCX2A5hT
 I9VgrBmSi5jB4mhi5NgiFpRHst94DbSC6JQgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783506769; x=1784111569;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eNVXL+JaRknDc0HvImFDwNcfU8artJh+cfFv4vMrtFQ=;
 b=TqahjSLOFizhi6e6WZTIH944AoWfaCfT62+JiOPXw/3oTZNrJHjTAwi5bGGr0msTRW
 ERMEBISXZ0bYG8AepCkQbOgjNkBG6E+jgErJTRD+jApkx3+n5ad/4xOWXZykC7PZvHli
 ZXUvfTRx3w/UZltLILAxePAsBbXPkSdtc598Dh4zFtG1A3ffscyAd5BVeOdooTFdYka6
 O0LJslWtr5pVGvv6euS3e3nzFSWCDNupFARsHPvI7ml4QINbkIX83S+iR5j1xKDBefMK
 4NiWbjvq38wZh0MuyHLZfuuTqidb267X5e94Y4pkr3jTvPgKtDsLxi81X5x51zacePjh
 +P8A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrxa0xkcJY/ivOEFsAEAQq55VUo+GfcZ3v28IsiW1Pqm9cKvx7oJEhm2t+CVmUfdjodpqVitt4ATjDT@nongnu.org
X-Gm-Message-State: AOJu0Ywky8UT3DRHBlgcvIo5If9hUI600fZVSEJDCBI2fo0aCw6VASJr
 iQR8jF6cbA2OXssDGvPomGANObsEB3TajgJ5kHTEG/rwnDPquHDVF9lFlPRxJiwNrIC70+Cmxwl
 /UVf37XELRGGbV84db5rY/ZNuD+WHEc0wahm0+NielQ==
X-Gm-Gg: AfdE7ckZ038J8Uli11O12mpNEtGFPe9PdGh0KyCHyeVqdA3jJNgh+YXrINvQ0utpIWc
 xu5bWbKV1I//jIVr6mZhU7Mcbg9pcpXdBS6EL1zDMx9QVKnD0w10Lt+JfeCJ6y+rgfO0JHSV4Af
 92CW/T9WkflSiKFqtTgyrdG1G+66xKz/kvFbcmod5GVvGquFcxi6EkxepR9as2t3RO3qJ2dzMvg
 56ySdw5OZG+odwr1AvRTxRMGOFI1QwkPUaYqXuEp9fvRdUr7EvHC7gGwU9QtylAqpcEDFcvrti2
 uBYUZERMG0bC6vCr7zYgRDr7EA3eHJx1YTioYAI=
X-Received: by 2002:a17:906:2099:b0:c12:8bda:8d2e with SMTP id
 a640c23a62f3a-c15cdfe9b99mr57961166b.8.1783506768891; Wed, 08 Jul 2026
 03:32:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260706224426.14156-1-its@irrelevant.dk>
 <20260706224426.14156-5-its@irrelevant.dk>
 <CAFEAcA8ZQX01i9u0dUziRP0rAC1fSF=zbWcmQdLs=82D8ECg4Q@mail.gmail.com>
 <868d7628da027aff31851b82944c5d13f9448349.camel@mihalicyn.com>
 <dcd72ac6-aeeb-4309-a8cf-09656795cd0d@app.fastmail.com>
In-Reply-To: <dcd72ac6-aeeb-4309-a8cf-09656795cd0d@app.fastmail.com>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Wed, 8 Jul 2026 12:32:34 +0200
X-Gm-Features: AVVi8Cd4B9OIV1ye1c-gHAhsG0x3GpfCDlY1Zy4MfYQ5pn00JOp0NeljKnp5ihk
Message-ID: <CAJqdLrrBXyg-L0hA5LBouQ5zb5-beFj1H3T42O8b9Tognhf1JA@mail.gmail.com>
Subject: Re: [PULL 04/11] hw/nvme: add migration blockers for non-supported
 cases
To: Klaus Jensen <its@irrelevant.dk>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 aleksandr.mikhalitsyn@futurfusion.io, 
 Jonathan Cameron via <qemu-devel@nongnu.org>,
 Klaus Jensen <k.jensen@samsung.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Jesper Devantier <foss@defmacro.it>, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9_via?= <qemu-block@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alexander@mihalicyn.com; helo=mail-ed1-x52c.google.com
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

Am Mi., 8. Juli 2026 um 12:28 Uhr schrieb Klaus Jensen <its@irrelevant.dk>:
>
>
>
> On Wed, Jul 8, 2026, at 12:23, Alexander Mikhalitsyn wrote:
> > On Wed, 2026-07-08 at 11:11 +0100, Peter Maydell wrote:
> >> On Mon, 6 Jul 2026 at 23:44, Klaus Jensen <its@irrelevant.dk> wrote:
> >> >
> >> > From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> >> >
> >> > Let's block migration for cases we don't support:
> >> > - SR-IOV
> >> > - CMB
> >> > - PMR
> >> > - SPDM
> >> >
> >> > No functional changes here, because NVMe migration is
> >> > not supported at all as of this commit.
> >>
> >> Hi; Coverity has a complaint about this commit (CID 1663673):
> >
> > Dear Peter,
> >
> >>
> >> > +#define BLOCKER_FEATURES_MAX_LEN 256
> >> > +
> >> > +static inline void nvme_add_blocker_feature(char *blocker_features,
> >> > +                                            const char *feature)
> >> > +{
> >> > +    if (strlen(blocker_features) > 0) {
> >> > +        g_strlcat(blocker_features, ", ", BLOCKER_FEATURES_MAX_LEN);
> >> > +    }
> >> > +    g_strlcat(blocker_features, feature, BLOCKER_FEATURES_MAX_LEN);
> >>
> >> g_strlcat has a return value to tell us whether it managed to fit
> >> all the text in, but we aren't checking it.
> >>
> >> In this case it looks like that's not a big deal (it does always NUL
> >> terminate even if it truncates, and we're only using the string
> >> to report migration blockers), but I think it would be nicer to
> >> avoid using a fixed-size char array: they're usually a bit more
> >> bug-prone.
> >>
> >> How about we use glib's GPtrArray and g_strjoinv() instead of
> >> manually building the string? Something like:
> >>
> >>
> >>     g_autoptr(GPtrArray) blocker_features = g_ptr_array_new();
> >>
> >>     if (...) {
> >>         g_ptr_array_add(blocker_features, "SR-IOV");
> >>     }
> >>     [etc...]
> >>
> >>
> >>     if (blocker_features->len > 0) {
> >>         g_autofree blocker_list = NULL;
> >>
> >>         g_ptr_array_add(blocker_features, NULL);
> >>         blocker_list = g_strjoinv(", ", (void *)blocker_features->pdata);
> >>         error_setg(&n->migration_blocker,
> >>                    "Migration is not supported for %s", blocker_list);
> >>         if (migrate_add_blocker(&n->migration_blocker, errp) < 0) {
> >>             return false;
> >>         }
> >>     }
> >
> > oh, thanks. My bad. :-( Would you like to submit your fix as a patch, or
> > should I take your suggestions and send a fixup patch (or update my series)?
> >
>
> Alex,

Hi Klaus,

>
> Please send as a patch for master, you can add Suggested-by for Peter :)

will do, thanks! ;-)

Kind regards,
Alex

>
> Cheers,
> Klaus

