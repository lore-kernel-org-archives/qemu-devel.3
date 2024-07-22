Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6083C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 09:36:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVpSX-0002lD-Rp; Mon, 22 Jul 2024 05:35:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sVpSV-0002jz-5X
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 05:35:55 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sVpST-0002As-8j
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 05:35:54 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5a2a90243c9so3038575a12.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 02:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721640951; x=1722245751; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eM4bYlLIsa6qOQFNtj/1SgGY18SzVeAM45woCRGVDOQ=;
 b=YlMHKOsHUbYBJd1BX0ioCFjuIz54N9hA+GiyVcZ1oWijZUB/8f80FmV2R4yuWJbsu8
 gGOXybhnNiuyacqlQk9WNxlFP9DEDzOA0ZXYh+nitFOSmZlxN5xxcTbSC5LBRwPfMHMI
 88cCdHSJLXCrqPL56gZGBh5OLitq0RUgT/zwpScQyPn1Bx0Oi9NnJcHkZDjkxBvgNvjp
 V22+mxkIYqoUCNvFI89S64ekL86jHmGnd7zXF2CXrZzRA/tVMhYR5M+VxqLl9oplEedw
 ugKl6YTelRVyFHXRCto+sQ55jDsqymmiA7jgDoAEH4K3ugvbEMfwsBx1zWJQZfvbklkw
 bvdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721640951; x=1722245751;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eM4bYlLIsa6qOQFNtj/1SgGY18SzVeAM45woCRGVDOQ=;
 b=BQSZ4FT1fHn+ZxmDiGw1QD+9jPOSHY/PQ7YpGtLXYrrj7UJA121QAiJDAnlY5qyG9O
 9Qe5rqwEGVC0A0t5Wxy4ICQCQd4L5ssLenGRXQJ1ig+0R+NXK2BC5gLqIlLeLGiZt9Zk
 v8wEyeKZwfufto1exX95WKpCMYZcfuuQ0igo/6uB7vcPHzdRUhUyRwcd5Bb9y+kEiC5J
 MELf6dLc4Kd3+Vpol17zRpcKVR9hoLt91nnww6rPQ8fPcjV8mF8BRHrCPewi2IvN7u/i
 EGGu/PlJ6ObVxLEttzVTTaq9hZUhBQcvghxWD5Y+5mNICcWdV5B4jmXtaYbocCnL65Is
 OS9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZuAhwH8KmBcE2YWqJMpnBv07RqUDMPSG75ti8jnGZxwKIEXRcDutBpH4YQYUpN7GwF0/HwDO6X8gCW1A1sS9nW8p/TQc=
X-Gm-Message-State: AOJu0YxK+Fn3sCwVjcm38sPmL6zktNuqOFaG2tSpmU5rgnckHwQRRSMK
 ntnCZyz+Lpkm/wMVYdDeFcB0fpUED7lvEmDzG8pxjnfoO7zHFr1c1tHMr1WUICJF3Tj6D8amATv
 nwv6guh39ZVHTEwBwk3aFQIyMeN7NXWnGkzd+Cg==
X-Google-Smtp-Source: AGHT+IFDB52tm7aud7zWQ0LoLaQEqIhpcVNFlt3QMtZYb+eqULUWqIjkbpfZbZSoET5rMrjFXqT/uCMWnBQayDZWkXo=
X-Received: by 2002:a05:6402:358d:b0:57c:c3aa:6c68 with SMTP id
 4fb4d7f45d1cf-5a479a6a16bmr4605978a12.20.1721640950753; Mon, 22 Jul 2024
 02:35:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240715084519.1189624-1-smostafa@google.com>
 <20240717150931.GA3988597@myrica>
 <1e7e750b-61bd-4822-8742-124bdf66a7c4@redhat.com>
 <5684927d-d890-42be-841c-ece681502503@xen.org>
 <a0ee8ba3-174f-4d00-807f-31584cba42d4@xen.org>
 <CAFEAcA8T3Yrj_R-B2oUW_Uu3u5HZs4RY1P+A7zF+8xWJnmtpQA@mail.gmail.com>
 <Zpw2I2ATUqDt19qv@google.com>
In-Reply-To: <Zpw2I2ATUqDt19qv@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jul 2024 10:35:39 +0100
Message-ID: <CAFEAcA9zBE6qk5fgRrck_i34NETMU44frQhFJ74iv81+BEvOpw@mail.gmail.com>
Subject: Re: [PATCH v5 00/18] SMMUv3 nested translation support
To: Mostafa Saleh <smostafa@google.com>
Cc: Julien Grall <julien@xen.org>, eric.auger@redhat.com, 
 Jean-Philippe Brucker <jean-philippe@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, 
 alex.bennee@linaro.org, maz@kernel.org, nicolinc@nvidia.com, 
 richard.henderson@linaro.org, marcin.juszkiewicz@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Sat, 20 Jul 2024 at 23:11, Mostafa Saleh <smostafa@google.com> wrote:
>
> Hi Peter,
>
> On Fri, Jul 19, 2024 at 04:57:18PM +0100, Peter Maydell wrote:
> > On Fri, 19 Jul 2024 at 16:36, Julien Grall <julien@xen.org> wrote:
> > >
> > > Hi,
> > >
> > > On 18/07/2024 10:43, Julien Grall wrote:
> > > > Hi Eric,
> > > >
> > > > On 17/07/2024 18:43, Eric Auger wrote:
> > > >> Hi Peter, Richard,
> > > >>
> > > >> On 7/17/24 17:09, Jean-Philippe Brucker wrote:
> > > >>> On Mon, Jul 15, 2024 at 08:45:00AM +0000, Mostafa Saleh wrote:
> > > >>>> Currently, QEMU supports emulating either stage-1 or stage-2 SMM=
Us
> > > >>>> but not nested instances.
> > > >>>> This patch series adds support for nested translation in SMMUv3,
> > > >>>> this is controlled by property =E2=80=9Carm-smmuv3.stage=3Dneste=
d=E2=80=9D, and
> > > >>>> advertised to guests as (IDR0.S1P =3D=3D 1 && IDR0.S2P =3D=3D 2)
> > > >>> For the whole series (3-9, 11, 12, 15, 16, 18):
> > > >>>
> > > >>> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > >>>
> > > >>> (and I think patch 16 is missing Eric's R-b)
> > > >>
> > > >> Jean-Philippe and I have followed up the progress of this series,
> > > >> Mostafa took into account all our comments and all the patches wer=
e
> > > >> reviewed. It seems to be in a pretty decent state so if you don't =
have
> > > >> any objection, please consider pulling it for 9.1.
> > > >>
> > > >> On my end I did some testing in non nesting mode with virtio-net/v=
host
> > > >> and I have not noticed any regression.
> > > >> Would be nice if someone could send his T-b for the nested part th=
ough
> > > >> (Julien?).
> > > >
> > > > I haven't yet tried the latest version. I will do that in the next
> > > > couple of days.
> > > I see this is already merged. If this still matters:
> > >
> > > Tested-by: Julien Grall <jgrall@amazon.com>
> >
> > We can't retrospectively add the tag, but the testing itself
> > is still important -- thanks for doing it.
> >
> > Q: is there any reason not to:
> >  (a) change the default to "nested" rather than "1"
> >  (b) make the virt board (for new virt machine versions) use
> >      "nested"?
> >
> > AIUI "nested" should be a superset of "stage-1 only", the guest
> > can just ignore stage-2 if it doesn't care about it. Or is
> > there a performance hit from having stage-2 around even if the
> > guest doesn't enable it?
>
> I didn=E2=80=99t do benchmarks, but from the code, I don=E2=80=99t think =
there
> would be a difference from using stage-1 only or nested stages
> with stage-1 config.
> I didn=E2=80=99t make =E2=80=9Cnested=E2=80=9D the default stage or used =
it for the virt
> board, as I was worried about compatibility issues (I think that
> breaks backward migration), but otherwise I don=E2=80=99t see issues.
>
> But if I understand correctly, setting that for virt board 9.1
> (virt_machine_9_1_options) would be fine?

Yes, we would need to retain the old stage-1-only config on
the older machine version types, but we could switch to
nested by default on the newer ones. It's a little late
I think to make that change for the virt board at this
point in the 9.1 release cycle, but we could do it for 9.2.

thanks
-- PMM

