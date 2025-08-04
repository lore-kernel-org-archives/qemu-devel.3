Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 185ACC87FD3
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 07:00:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uipAv-0004fw-IS; Mon, 04 Aug 2025 03:00:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uipAq-0004cW-IS
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 02:59:56 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uipAn-0003YM-Ih
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 02:59:55 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-604bff84741so6857223a12.2
 for <qemu-devel@nongnu.org>; Sun, 03 Aug 2025 23:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754290790; x=1754895590; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9IuR43o60xKHz3OX0HREvy6TGc1CWZ/1El9hffC1AW8=;
 b=ib2YJfSg6nRfohgy1+n0q/vN9Q8vcvgShzxmvuU1Wfmp+lsFFAScyMyHntZ9ldZ7Tr
 jBGE8i5cekbvHfV0SK+ME8obE+1O76jI8kYARMLtr9d2JD064NjbkWo6qRvS4bqTNXcS
 RVUkjNrAvlDGl335ZKPtj/zdLZigrgdyjAy5d39UB+cHGr+c8bxdBtNnhB/FQJpTku/T
 dL/td91OWZknEundKih0J6GqmdSKdE4Xddw7Ky+VtK5X//olzR5jvA1cgMBPmRQxP22y
 IWeQfX6IxjmIc+Y+e5R8TmUfuxhjsBbwVL9Eo3+4VnGYeKH0bMFDRLkqwm3Jj9mhi6SA
 zoXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754290790; x=1754895590;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9IuR43o60xKHz3OX0HREvy6TGc1CWZ/1El9hffC1AW8=;
 b=vWl2t79uz+nICmZGzz9Jb/BHnWA7KiKAYqKSGJ/gXB61QO3WoSqmN34lk6wdt6Df5v
 LWatORsP3kcJlED8PcBxCG1UXOCR7gBcqBqLMLOGYpHRG4TumGriODexbMASjQVjtdg3
 SYv46yANIp35D97HWtKuHSypDQ6wBxH1fw31/Nxdh1m/VxCc9tchftTa8HNd+uveipt3
 rhKlxHRUcc1AXzeP6GioGB0ZfcbqC3GaMl8xT4+p3saPxxctUfCKwGCW2mvvEc6jgIdM
 7tdI+xGOBCH2emcrGNSduTolcKVezL5HoIB97IJzHZwa0fnJ/ZoPhr6J0Q/I9mOyB4gD
 tLmg==
X-Gm-Message-State: AOJu0Yw72dLBFvkAh7M8vuQHMMd1A/AwYmEllKANMQZckQ0tlnoJNr4f
 uYGLAUxoVNK0Rg5yiTrtirUs7lUPlMJ/u+90VFVwewxSplatuF3jAPxptO7mFY3++CJlfZWirsm
 YiZPYbRvttJ6WsjafR92SH+BBHFMVMTOfNxx8L1gF/gnf6BGzyWMveJ4=
X-Gm-Gg: ASbGncurUED1/uAXS1jd6HGvjQonCtg5E0sbthPGG1KD+AlWV+o/DLQi7qC4xkeniOm
 kimwTjQ2c0EDiALmNMwWQd734AbX7WFzV7uYNbjLDKTG/SOR+EwK2bBgSbuDf8dxFIE6Hlg+u9f
 PZlGIpovg9CnsNryw3hn5ewNXmUPRpHCmTEUmXIhb9UJlZWmrCq3185q+XOCzUpLsrXvQqScRFD
 I86x9rhJrNBlR78dA==
X-Google-Smtp-Source: AGHT+IFTLOwZf2UVK4KCI80LYkVua1yQKweJYmQXHmnrpw7v0oV2k9w1pDVfTkDJhIPP1VzUpJ35aN3WRR1r/rpjDQ8=
X-Received: by 2002:a05:6402:13c7:b0:615:9940:8541 with SMTP id
 4fb4d7f45d1cf-615e716dd9fmr7090805a12.29.1754290789978; Sun, 03 Aug 2025
 23:59:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250717-docs_add_b4_section-v2-1-69212ed39299@linaro.org>
 <CAAjaMXaCNM95LFZ8aeDHHQEHAtQM7iu1du5poSwF7cEqWK6fwQ@mail.gmail.com>
In-Reply-To: <CAAjaMXaCNM95LFZ8aeDHHQEHAtQM7iu1du5poSwF7cEqWK6fwQ@mail.gmail.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 4 Aug 2025 09:59:23 +0300
X-Gm-Features: Ac12FXz5sezblf72APYn-hPh0MALKNCTf2-WxNoy1kzexASGHK3NSMVnAfHvhX8
Message-ID: <CAAjaMXZC6rgFBcmy9tSHojEm7J+t1fXfX7ay1bFSP7oW8P9N4A@mail.gmail.com>
Subject: Re: [PATCH v2] docs/devel/submitting-a-patch.rst: add b4 section
To: qemu-devel@nongnu.org
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x533.google.com
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

On Thu, Jul 24, 2025 at 10:56=E2=80=AFAM Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> On Thu, Jul 17, 2025 at 9:59=E2=80=AFPM Manos Pitsidianakis
> <manos.pitsidianakis@linaro.org> wrote:
> >
> > Add a section about b4, an actively maintained and widely packaged CLI
> > tool for contributing to patch-based development projects.
> >
> > Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
> > Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> > ---
> > Changes in v2:
> > - s/later/letter and add review trailers (thanks Gustavo)
> > - Link to v1: https://lore.kernel.org/qemu-devel/20250717-docs_add_b4_s=
ection-v1-1-2dfb4ad2fe07@linaro.org
> > ---
>
> (Ping)
>
> Alex, does this look OK to you? If yes could you pick it up?
>
> >  docs/devel/submitting-a-patch.rst | 40 +++++++++++++++++++++++++++++++=
++++++--
> >  1 file changed, 38 insertions(+), 2 deletions(-)
> >
> > diff --git a/docs/devel/submitting-a-patch.rst b/docs/devel/submitting-=
a-patch.rst
> > index f7917b899f6892ef74908fe8f1399b6ae5a30324..dd1cf32ad35a98528f43918=
eceb2cc8a4847c5b6 100644
> > --- a/docs/devel/submitting-a-patch.rst
> > +++ b/docs/devel/submitting-a-patch.rst
> > @@ -235,6 +235,38 @@ to another list.) ``git send-email`` (`step-by-ste=
p setup guide
> >  works best for delivering the patch without mangling it, but
> >  attachments can be used as a last resort on a first-time submission.
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
> > +4. Write a descriptive cover letter with ``b4 prep --edit-cover``.
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
> >  .. _use_git_publish:
> >
> >  Use git-publish
> > @@ -418,7 +450,7 @@ Retrieve an existing series
> >  ---------------------------
> >
> >  If you want to apply an existing series on top of your tree, you can s=
imply use
> > -`b4 <https://github.com/mricon/b4>`__.
> > +`b4`_.
> >
> >  ::
> >
> > @@ -533,7 +565,11 @@ summary belongs. The `git-publish
> >  <https://github.com/stefanha/git-publish>`__ script can help with
> >  tracking a good summary across versions. Also, the `git-backport-diff
> >  <https://github.com/codyprime/git-scripts>`__ script can help focus
> > -reviewers on what changed between revisions.
> > +reviewers on what changed between revisions. The ``b4`` tool automatic=
ally
> > +generates a version history section in the cover letter, including lin=
ks to the
> > +previous versions on `Lore`_.
> > +
> > +.. _Lore: https://lore.kernel.org/
> >
> >  .. _tips_and_tricks:
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

Ping

