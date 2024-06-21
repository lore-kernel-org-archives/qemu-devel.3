Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08C82C41513
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 15:22:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKg4c-0005oY-Gd; Fri, 21 Jun 2024 11:21:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKg4b-0005oL-3f
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 11:21:09 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKg4Z-0008TU-5t
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 11:21:08 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-57d0eca877cso2554515a12.2
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 08:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718983265; x=1719588065; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5/3SiSrDximBKw7nor80831wBkMaga9RuNI5ujZukjM=;
 b=SkvG8O2PQVMv8PTNlkTWIxFcbd2Aa55fiBWV3mnH+6K1KHZ8JTPskWsu7eD6XdysiU
 07GzIXhDVkhD8SzVXfTQV710TLKMj8Dyk6eKCLn6pa2CT3ulgzpvaLCbP6F4DBzI/kkA
 k27WenzHhg930oN/YGf6YXsZTr486BefsD6dXRQZzkCmjC5eNN419Q9omym4vzhEUQgM
 mqeQO7x/DFHXVkok9x7+c/bvfi8m4Yt79JjiUpSMaaVKVMEX2thiI0/kxV2F33BWSdYr
 R6PUbGvxCW7jrg1fguMWu6zURtVxmAQ8jGI1vIIyz4fqDU69df0WZ4tUaIQ3Rolq/Y+C
 RQ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718983265; x=1719588065;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5/3SiSrDximBKw7nor80831wBkMaga9RuNI5ujZukjM=;
 b=fI5hian2J26fZYPDox3drtVewMwnlCa8JVxse5c/XuxBda955ceOrn4uuypddtleMF
 mUXxfOVnRT1W+MmB52hn5Q76RH31LBovaCxeeV4zscM4dEtsHZsuDueXOPuyHk7gVhsh
 2QZXfYVS3Y2aL6sVC5cKE/jUQzAARUTzZbedyuomVo3rPHk/OFUmL6FCZ3CdlOCqI8od
 0G0X1ea/a+aPFfUtZzZytBd/bRMKFZAunYVfIyZ6WYQgE64JpPvvyWPvySzZGTcmrpf3
 P/OIBJxYYcJyV2b4rDt0LDb21QWSxEECLvCXDCndrp2FCIMGwF2re4831uHF3ukrsX/2
 cmUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV89oDmYmWcrgZU6579ueLq2qStQ33fiQKuhfqREPp5ItJERmA65INBA0B0k7UxTeSTj23i2JeSULhlZWkmSkD2ZDSQfn8=
X-Gm-Message-State: AOJu0YxgNYEwQmlNOlVbWaoAZKIvgNzl6r1/iMJMNbjmuJgu63lu31lg
 lIzO9wqoF0bjvxnZpwpv9ea1b/Yt+EXlXMPZgUqol1P/oHwmNzYteA25WhD59ZMow1dRLX6qdZe
 rybyj22f7oaiJ46MhQM6O+ZBHsp2bufxU5r27oDg1Na2+W4uZBaQ=
X-Google-Smtp-Source: AGHT+IEDPxDXzPSJsCrSzxSVvw7HCbw+YFloWdLi1HDK2VkCzi8gAYqZkLx/JwnxfTTaUpRzNH112s2Fxzk1FrY/7C4=
X-Received: by 2002:a50:a6da:0:b0:57c:758d:86f8 with SMTP id
 4fb4d7f45d1cf-57d07e882c4mr6079700a12.23.1718983264883; Fri, 21 Jun 2024
 08:21:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240520232634.317988-1-dmamfmgm@gmail.com>
 <87cyomxmvc.fsf@draig.linaro.org>
 <CACBuX0SMvD6+vWGBv_m0rBnwgp8fbv6rHKUmbr-MWDLknz8LyA@mail.gmail.com>
 <87msnqvtpv.fsf@draig.linaro.org>
In-Reply-To: <87msnqvtpv.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Jun 2024 16:20:53 +0100
Message-ID: <CAFEAcA8-gnh3sF6yPuPOfHg=C4H2=f-VYobKcXNUdMCWpdYNNw@mail.gmail.com>
Subject: Re: [PATCH] hw/usb/hcd-ohci: Fix ohci_service_td: accept valid TDs
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Cord Amfmgm <dmamfmgm@gmail.com>, qemu-devel@nongnu.org, 
 Philippe Mathieu-Daude <philmd@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>,
 Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Wed, 12 Jun 2024 at 20:36, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Cord Amfmgm <dmamfmgm@gmail.com> writes:
>
> > On Wed, Jun 12, 2024 at 9:21=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@l=
inaro.org> wrote:
> >
> >  David Hubbard <dmamfmgm@gmail.com> writes:
> >
> >  > From: Cord Amfmgm <dmamfmgm@gmail.com>
> >  >
> >  > This changes the way the ohci emulation handles a Transfer Descripto=
r with
> >  > "Current Buffer Pointer" set to "Buffer End" + 1.
> >  >
> >  > The OHCI spec 4.3.1.2 Table 4-2 allows td.cbp to be one byte more th=
an td.be
> >  > to signal the buffer has zero length. Currently qemu only accepts ze=
ro-length
> >  > Transfer Descriptors if the td.cbp is equal to 0, while actual OHCI =
hardware
> >  > accepts both cases.
> >  >
> >  > The qemu ohci emulation has a regression in ohci_service_td. Version=
 4.2
> >  > and earlier matched the spec. (I haven't taken the time to bisect ex=
actly
> >  > where the logic was changed.)
> >
> >  I find it hard to characterise this as a regression because we've
> >  basically gone from no checks to actually doing bounds checks:
> >
> >    1328fe0c32 (hw: usb: hcd-ohci: check len and frame_number variables)
> >
> >  The argument here seems to be that real hardware is laxer than the spe=
cs
> >  in what it accepts.
> >
> <snip>
> >
> >  With the updated commit message:
> >
> >  Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >
> > Please forgive my lack of experience on this mailing list. I don't see =
a suggested commit message from Alex but in case that
> > was what is being considered, here is one. Feedback welcome, also if th=
is is not what is wanted, please just say it.
> >
>
> Something along the lines of what you suggest here

Thanks; I've picked up this patch for target-arm.next (as with
your previous one for hcd-ohci, adjusting the Author and
Signed-off-by lines to both read David Hubbard).

I tweaked the commit message a little bit, so the middle part reads:

    What this patch does is loosen the qemu ohci implementation to allow a
    zero-length packet if td.be (Buffer End) is set to td.cbp - 1, and with=
 a
    non-zero td.cbp value.

    The spec is unclear whether this is valid or not -- it is not the
    clearly documented way to send a zero length TD (which is CBP=3DBE=3D0)=
,
    but it isn't specifically forbidden. Actual hw seems to be ok with it.

thanks
-- PMM

