Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67A7EC83F34
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 20:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucVbW-0002yz-Vl; Thu, 17 Jul 2025 16:53:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ucTkG-0002oa-Qr
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 14:54:27 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ucTk8-0002gq-95
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 14:54:15 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-60c6fea6742so2592691a12.1
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 11:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752778445; x=1753383245; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zJPGKevktiFzl9pwO//A3O7CzvPGoHI1viXJHFRCMTY=;
 b=TeQLDKonOXfdytdoh1tWPNk9gg/sYtxdgYFQstRTeEhFNFS7yLWZujdMZpMv717tQ0
 POJZ/YYaE3uAY15jDS9MHWuRCIifStGvfQQ1CzDS7oyLOdE4owP9YnYR5h5NjT+ucxcE
 cKGgxdHN8EKKjTZ1Gh4fderi/wwT0/WAp6S+7kSjNWLacgDi7CUx2Xr568I/xheYauVC
 75Evthhihm7JKg/Dpl+kxZwT5c08noKFd0GrWNmF2fxL/rQlP+s5snA3ilEQQB8qiFEi
 0CrOf7m5iwF/gVRGQA3R2y46UYGeubXLjnUNUTtgY5Ln28G2ePI+F3+Nx+jcsVzJdPO8
 49Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752778445; x=1753383245;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zJPGKevktiFzl9pwO//A3O7CzvPGoHI1viXJHFRCMTY=;
 b=LwX+bFTHPpVtoPxYekQvW8TbDt8RYMtkgKKjyKFUlRZON93TVrGs+SSHcColR0r18P
 mHCWdTArQbNEzeelGiVQSix9pbZzg4uAVCnHFqAT0FP8tz0woBXe8TJR3JwN03PllAPV
 bhZ6Ch8lvBx03uWoeyhbln62em4bTDlUEDec62Fy1td78/KfNScng6j7Fuwn40oiFptp
 ccIr+LyNmKYqhqV+Thp+AO1q1oUKXUTyVz9qEu/+WiYtG8KsHV/9M4WFhp67a0acVLJo
 0lDevxlVtVce02lMC4gkXSq5lRStdE5NdB24n4wCJI6HDXnattYzbYzcf+f91gWzdcsS
 Ygbw==
X-Gm-Message-State: AOJu0YyQxX6J2zALFadg6pZjHvvrINXWslLZRxvjtopdMPD6WxJdGsvk
 hzCFZM5w510WrHIo6AjIIQbA9Q0ye/GsPmVJsqf8uVs9wqvUsMiy/+s9K9X/DfPattPyffL/Hav
 aa5j1dtzU+lPK33hS3Mtt5S0OD/EFdr83OCNY3XoxDw==
X-Gm-Gg: ASbGncuijL24rRj1Uky+SD6n/yDyHpJTgPhYCihol4ZFK5yEdxavF9tlJBSmChS/74G
 z9ORLyNFFTAE2/P+IKpGBQ40mzW7NaFStrFSY7bumVeyCFb+fKpQoOakWlosgYuLKdQDko1vwaL
 0IkGUae5CV3T3rGbXUPYs22suvKEeVONEyOtKWfFzyyor0InzllsL4n4NkFx3ClYNSe9xeOOpHw
 pitRw==
X-Google-Smtp-Source: AGHT+IEXZgJNhuqDp7ZUQ8z7ICclFgv60mb/cMAYRXITYwgjsHrL//1unlD3vEMEoZXOprtEOyik/rVItkO3UBzTPUo=
X-Received: by 2002:a05:6402:1d48:b0:60c:6a48:8047 with SMTP id
 4fb4d7f45d1cf-61281ecab4emr7189442a12.11.1752778444779; Thu, 17 Jul 2025
 11:54:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250717-docs_add_b4_section-v1-1-2dfb4ad2fe07@linaro.org>
 <a1aee315-0595-4167-be34-5cfff6d7615a@linaro.org>
In-Reply-To: <a1aee315-0595-4167-be34-5cfff6d7615a@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 17 Jul 2025 21:53:38 +0300
X-Gm-Features: Ac12FXwJjEerA5EsrgczD9Zj2ZotmjaJHzSObW4fPqtxL1qUuaO60Lfza2elR3Q
Message-ID: <CAAjaMXZKaTwJMeBmqV57j7K5TCBkRXQ+kO_rfkQ59VAHh7Zv+w@mail.gmail.com>
Subject: Re: [PATCH] docs/devel/submitting-a-patch.rst: add b4 section
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x536.google.com
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

On Thu, Jul 17, 2025 at 9:48=E2=80=AFPM Gustavo Romero
<gustavo.romero@linaro.org> wrote:
>
> Hi Manos,
>
> Nice, I use a lot b4 and I think many QEMU devs use it as well :)
>
> On 7/17/25 10:53, Manos Pitsidianakis wrote:
> > Add a section about b4, an actively maintained and widely packaged CLI
> > tool for contributing to patch-based development projects.
> >
> > Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> > ---
> >   docs/devel/submitting-a-patch.rst | 40 ++++++++++++++++++++++++++++++=
+++++++--
> >   1 file changed, 38 insertions(+), 2 deletions(-)
> >
> > diff --git a/docs/devel/submitting-a-patch.rst b/docs/devel/submitting-=
a-patch.rst
> > index f7917b899f6892ef74908fe8f1399b6ae5a30324..5160813ca8cf12c0547b885=
86059487d1e90fe18 100644
> > --- a/docs/devel/submitting-a-patch.rst
> > +++ b/docs/devel/submitting-a-patch.rst
> > @@ -235,6 +235,38 @@ to another list.) ``git send-email`` (`step-by-ste=
p setup guide
> >   works best for delivering the patch without mangling it, but
> >   attachments can be used as a last resort on a first-time submission.
> >
> > +.. _use_b4:
> > +
> > +Use B4
> > +~~~~~~
> > +
> > +The `b4`_ tool, used for Linux kernel development, can also be used fo=
r QEMU
> > +development. It is packaged in most distros and PyPi. The QEMU source =
tree
> > +includes a ``b4`` project configuration file at the root: ``.b4-config=
``.
> > +
> > +Example workflow to prepare a patch series:
> > +
> > +1. Start with a clean checkout of the ``master`` branch.
> > +2. Create a new series with a topical branch name using ``b4 prep -n d=
escriptive-name``.
> > +   ``b4`` will create a ``b4/descriptive-name`` branch and switch to i=
t.
> > +3. Commit your changes, following this page's guidelines about proper =
commit messages etc.
> > +4. Write a descriptive cover later with ``b4 prep --edit-cover``.
>
> Nit: You meant "cover letter" here maybe?
>
> Otherwise:
>
> Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>

Oops, that's what I get for not using "smart" spell checkers :)

Thanks! Will resend a v2 with the typo fixed.


>
> Cheers,
> Gustavo
>
> > +5. Add maintainer and reviewer CCs with ``b4 prep --auto-to-cc``. You =
can make
> > +   changes to Cc: and To: recipients by editing the cover letter.
> > +6. Run patch checks with ``b4 prep --check``.
> > +7. Optionally review the patches with ``b4 send --dry-run`` which will=
 print the
> > +   raw patches in standard output.
> > +
> > +To send the patches, you can:
> > +
> > +- Setup ``git-send-email`` and use ``b4 send``, or
> > +- Export the patches to files using ``b4 send -o OUTPUT_DIR`` and send=
 them manually.
> > +
> > +For more details, consult the `b4 documentation`_.
> > +
> > +.. _b4 documentation: https://b4.docs.kernel.org/
> > +.. _b4: https://github.com/mricon/b4/
> > +
> >   .. _use_git_publish:
> >
> >   Use git-publish
> > @@ -418,7 +450,7 @@ Retrieve an existing series
> >   ---------------------------
> >
> >   If you want to apply an existing series on top of your tree, you can =
simply use
> > -`b4 <https://github.com/mricon/b4>`__.
> > +`b4`_.
> >
> >   ::
> >
> > @@ -533,7 +565,11 @@ summary belongs. The `git-publish
> >   <https://github.com/stefanha/git-publish>`__ script can help with
> >   tracking a good summary across versions. Also, the `git-backport-diff
> >   <https://github.com/codyprime/git-scripts>`__ script can help focus
> > -reviewers on what changed between revisions.
> > +reviewers on what changed between revisions. The ``b4`` tool automatic=
ally
> > +generates a version history section in the cover letter, including lin=
ks to the
> > +previous versions on `Lore`_.
> > +
> > +.. _Lore: https://lore.kernel.org/
> >
> >   .. _tips_and_tricks:
> >
> >
> > ---
> > base-commit: f96b157ebb93f94cd56ebbc99bc20982b8fd86ef
> > change-id: 20250717-docs_add_b4_section-fc37e538b20b
> >
> > --
> > =CE=B3=CE=B1=E1=BF=96=CE=B1 =CF=80=CF=85=CF=81=CE=AF =CE=BC=CE=B9=CF=87=
=CE=B8=CE=AE=CF=84=CF=89
> >
> >
>

