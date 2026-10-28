Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6BF606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 08:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CtnJHbPs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLysK-00085e-Qw; Wed, 28 Oct 2026 04:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xLysI-00085G-4x
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 04:19:10 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xLysD-0007PI-JB
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 04:19:07 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6b429f71dbeso825860a12.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 01:19:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793175543; cv=none;
 d=google.com; s=arc-20260327;
 b=p6FmNdlYLoEg+K6kUmn1sz6xU9qiTjN4NhYFnodyTm32PQPJ5vx0WwFmFwXQ7Sm89c
 68KsUCTt5IVQzYal/KcwBMnfqB+O/ct+IEpvywQX7NhIs3jRRYD8ldN2IJZ676knaJWR
 tDgFT/n0wCchL5e+9OiA6yPlMsNj0pbYchmKyufa9snX0GDnT2V+2L6HAiNSnCd+jhGl
 e7GJbISUUPcAt6fb28HQJsiBF8gy/5nXVtN/4X6hswTc9dYOM+4RDOU+tH+ZuaxJ7N1+
 WKKN8zTRi/P6roG5dMzsrVkD9GdQUpRelq8NyxOX+4ZnvGl73zWCRDAs5zma7RG3vpsw
 WhZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QCr/iXoDvZAn99rubZ24G/k/iatBjPXdHor+2sybg2c=;
 fh=oR6KT4T9R4DzEe393lAnUFWLAI2XD1MXqDS3E+1BJZc=;
 b=cSJV4exDmXo2LOZQCvg40R5Fk5tpSn+nWa1JI0C8PzV3yOkZeFMmYm31ON+ScP0Zsv
 xK0PtyOFB5+fhJkBsLRhAdgadktWpqG3sKTYSGhEtZpSv/GLyeVSGSJHzUQ1JQZuw3tv
 aMXJkRyrBpg0hXW0bEtWpjrnNfJRpbhxW882jNehy/X0cS6o6S8cgNG2IgHcl2Ajhz3b
 Y1hefl6mFfwSVt50aePI1Puh+hEvTsm5OBbbdOUooiRkfB641Ok5bjx8WUMYflrzE8qT
 E5LAut7F+EYqTvXGDTdWNyqQRvxpkMSEjcM7WEQ6c4srRzHWA8vCefcBBNDZFrWFi0Yf
 Mn4w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793175543; x=1793780343; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QCr/iXoDvZAn99rubZ24G/k/iatBjPXdHor+2sybg2c=;
 b=CtnJHbPsyhbGAFggldCXdHI3PIYNPyKj5Eq/0/TYgj4K+TPX7iXVguFdMJtxQnl0p1
 fHCUCLadNrF+Or+XyuQLa9Yz9rbn1F/+RRj2q+OJI0fMVuTTVhDDEIyzFr32tAWAhA1s
 Zpa8MolEzt+3l44NmMBwF0dr233D8tEOIFcmN2RLXyAV040P2vHUI7uYtTuXCbsVFYD2
 aFyFhWTu40DqZYzcouxcHwZFaWuqTQu8NDtCvqjNpdRtLPoVaxSBr3gelheLW520Aqwo
 DNw/UyKwxHczqEowpfTAeegyfCnpfaXPEX9OfzgDgKW5aIXMuNt3wLhGkEqWpveEBLl5
 nYoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793175543; x=1793780343;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QCr/iXoDvZAn99rubZ24G/k/iatBjPXdHor+2sybg2c=;
 b=YBhFH1blpTEWnqi9Ae6qKjEgD3jtVA4zJ/Dzq40U+4cP1zdW5LuQMl/aiSYgf3QgEp
 AG9WJ4lSd3oCAcPxKoepn7NwNzx7g63g6EQ50OCwZ43yimJ4MarLuOfIbi2IcjZRbrlN
 ssulBO5dkp9FOUIHWAX4YEsMMr4PHf4Mtl1rIVlfANEqLNGi9N6O65C4bz5e4uKBo8W+
 x8dpcoJau16u/sJ/MSKVLLyWQbvuDAsUV6E3BFUVwh7z8oRnFu2UnEimY9lYh18J9bFK
 Tl6YpvlbP6h+SuNWHdrgiG+4d//TJ+bBumqIc56umaxp2/C66IG5I1WQ7ZsIgqxW9bP1
 geRA==
X-Gm-Message-State: AFq9FYINNGBvU2nwFq/sOwaOevAcRkoQUcVAxhUKE0YFTn9DLSlQMtej
 /2sxtQ+AQZNYSkr4PNryUkBlstmOfNIUVQRpkPBBWnX3sMfxyFxKWFciH9oHMxEgkAlyFp0BsWq
 WB+nHFmCI84YJkqPlkXMyED4hzGjh3ZM=
X-Gm-Gg: AYBFou0pRpVJCmijKFwyBOHWCi8+XxxMaU14TKkRpG0FnRppxM4Gfnh1SLaoeB5JSBR
 UiMyj4s5XTWUoo37fMnjErZCUkzpB6UtAu7v+QNp54PijAQA54fCRqQtM4muzdzDP4RvPDyE4xC
 XqneKNKQH/2Solv0WKNPvI4mOo4ad3X8EAYmXV7TUaEJFr62ptgXZyw5OqzRfMaN63naBOtALDj
 Yj9f2MzpLXYusEN5povvVklyuvDMZIhw/vc5Nh5C57H18u5SRnhpdFNPcmxw3jvcRMEnLa9j3Ie
 Q0yV5Di7lE4j08HKS9Bd7ZCCyh2Ityuu3sGN32Y0ZNZG8mdaxwPUeNXnjP8PS4KTjnRkttWSuAN
 BUj71Y7GCcOMGXbwX1JuOMbwJSSo/egDNWR4Yiw==
X-Received: by 2002:aa7:c2c6:0:b0:6a9:aabb:5364 with SMTP id
 4fb4d7f45d1cf-6b49cbcfcf5mr677662a12.11.1793175542455; Wed, 28 Oct 2026
 01:19:02 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260929084416.1600199-1-zhangckid@gmail.com>
 <20261022201643.GG20810@shajnocz.csb>
 <CAK3tnvJRKw8XSG9aWusCouo=Z=wBs8w+4DT4a774eej9tkNQBw@mail.gmail.com>
 <20261027201154.GE933537@shajnocz.csb>
In-Reply-To: <20261027201154.GE933537@shajnocz.csb>
From: Zhang Chen <zhangckid@gmail.com>
Date: Wed, 28 Oct 2026 16:18:25 +0800
X-Gm-Features: AclHuK-hQHIzxTZVCRZx5WWAIst4BNhWzG7RnIFLl-F-5gc9-ZipPjojWD2LYK8
Message-ID: <CAK3tnvLuh112GGnORDfJfL_eks32Vr6EC4AZ+D-GpuBJy90i4w@mail.gmail.com>
Subject: Re: [PATCH V18 00/13] iothread: Support tracking and querying
 IOThread holder
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=zhangckid@gmail.com; helo=mail-ed1-x536.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 4:11=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> On Fri, Oct 23, 2026 at 05:42:48PM +0800, Zhang Chen wrote:
> > On Fri, Oct 23, 2026 at 4:16=E2=80=AFAM Stefan Hajnoczi <stefanha@redha=
t.com> wrote:
> > >
> > > Please update docs/devel/multiple-iothreads.rst. It still refers to
> > > iothread_get_aio_context() instead of the new API.
> > >
> >
> > Hi Stefan,
> >
> > Thanks for pointing this out. Would it be okay to include the documenta=
tion
> > update as a separate patch in the next revision like this?
> >
> > diff --git a/docs/devel/multiple-iothreads.rst
> > b/docs/devel/multiple-iothreads.rst
> > index a6eb046267..c184222d71 100644
> > --- a/docs/devel/multiple-iothreads.rst
> > +++ b/docs/devel/multiple-iothreads.rst
> > @@ -88,11 +88,20 @@ argument, which is used to check for and prevent
> > re-entrancy problems. For
> >  BHs associated with devices, the reentrancy-guard is contained in the
> >  corresponding ``DeviceState`` and named ``mem_reentrancy_guard``.
> >
> > -The ``AioContext`` can be obtained from the ``IOThread`` using
> > -``iothread_get_aio_context()`` or for the main loop using
> > -``qemu_get_aio_context()``. Code that takes an ``AioContext`` argument
> > -works both in ``IOThread``\ s or the main loop, depending on which
> > ``AioContext``
> > -instance the caller passes in.
> > +The ``AioContext`` can be obtained from an ``IOThread`` using
> > +``iothread_ref_and_get_aio_context(iothread, holder)``, or from the ma=
in loop
> > +using ``qemu_get_aio_context()``. Code accepting an ``AioContext`` wor=
ks with
> > +either event loop.
> > +
> > +The holder-aware get registers a holder and takes an IOThread referenc=
e.
>
> I suggest ``iothread_ref_and_get_aio_context()`` instead of "The
> holder-aware get" so it's clear which API you are referring to.

OK, I will update to V19.

Thanks
Chen

>
> > +After the caller has finished using the context, release the reference=
 with
> > +``iothread_unref_and_put_aio_context()``, passing the same IOThread an=
d an
> > +equivalent holder. Both calls require the BQL. No matching IOThread pu=
t is
> > +needed for the main loop's context.
> > +
> > +``iothread_unsafe_get_aio_context()`` neither registers a holder nor t=
akes a
> > +reference. It is for legacy callers that ensure the IOThread's lifetim=
e
> > +themselves; new code must use the holder-aware API.
>
> Yes, this looks good. Thanks!
>
> >
> >  How to synchronize with an ``IOThread``
> >  ---------------------------------------
> >
> >
> > When you have a chance, I'd also appreciate your review of the remainin=
g
> > patches that don't yet have Reviewed-by tags.
>
> I will take a look!
>
> Stefan
>

