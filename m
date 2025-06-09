Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 606CFC61CE8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 16:18:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOfCf-00086p-5s; Mon, 09 Jun 2025 12:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uOfCd-00086Z-Fp
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 12:18:27 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uOfCb-0004P1-O4
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 12:18:27 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-710fe491842so18504777b3.0
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 09:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749485904; x=1750090704; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3mm5+Hv4PJ/2ax2Q59tytVi3aZSjSz9V46wWFNPrrzA=;
 b=ZDFwyxPLR0oNbZb1aekifkjJ8f9gMSHRmeHvrPhqrOpoiRw2KYSKP9i3b0EfFbLtd7
 JbGe8oU5/heMlWHBDClEkJny6mZzP1roIGQfEuljgsjEDW99Cit+pMqdP8WGE4mV5BGY
 wc/uQ4++u2hkdxqBWgXD79VmNzWAVGryA9epivELB2idUhJrCSlapSza0l91HFj13DU1
 +r3BB+W+Q8qxZBx3CHSQtGBvSeiRk+wpWi6DcaNTlWB7GFln79hh0TOhwoNwOIb+Yt+M
 1iiggAL5ikqe13FL1rqOQkI/MnO1O8Z1VAnVwH704v53U1rzLez6ZxEL+t8hVGM20CKz
 4CBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749485904; x=1750090704;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3mm5+Hv4PJ/2ax2Q59tytVi3aZSjSz9V46wWFNPrrzA=;
 b=bgAT9mJRGVgwj8QyK/3qcmUX8+75qDtinyjuk/eXULZZUNS1K/twX4TGFxr3z8Nb2I
 UpRDFipgAwPC7kIkC8DlG6YYnOCL74QKIo+x503AqZ6/FvtpzUnoAbrpxNISTelXJl8w
 2m0h/8HiXM/AdTnWGa5BXlXKtuToMKmlgcVVnk+RzNVsdAEkVCEEhZ13pA2n4oM69tMa
 EFxIMDs+qK2xVsgf1+5pWeMF/MsiG5UVFv1EBhZKnFpwPefqONAxPksMgIBwhlR7IDoM
 3B0fun8pKW0X5QpiRln+tidsc9ZBYvPI7DL1RhBG/rV+/QM4zrgFbAIh5eVmglLWL127
 amSA==
X-Gm-Message-State: AOJu0YwVxwnMffH9QYDO4JWx4GbK77CO9XVlRED+t936COt4F3ouKWlS
 QZSbixMl+UXNRS30wTkkFp83ak/Jph58V7HomvFPIopgDzr8SW1RYRfmQIiEMIO8M8OsHWghC+T
 FvsX82ZmvjXnEfQAL5BBu3u/to+8ddvEG6GMwEulfi1eUwHi9njwP
X-Gm-Gg: ASbGncu/rx6MAw24/wi2uN5L282QQqNE5TM9mgQMQ+wA2tv8LGFsgvdPtPwQZaCpjEA
 cZbQdFybModomkIl2Ye4geB32WeR5XIMWp7Umqdhb+4czAzPv/0P27/UeOyQK8SthsJiA/opeLm
 HIqYca9XjHxg8TpR1OQFRjhVkYNs038DazU92ZoXPXU+e9
X-Google-Smtp-Source: AGHT+IHeIogcoc6PWeikAkiN1+z6Mhu66/kmmlEDXmlSG0nJSsG2QyBbFexvK3Ct8FJK7Emwy5R/dbC8MNSsd6voSwQ=
X-Received: by 2002:a05:690c:6801:b0:710:e9b1:485f with SMTP id
 00721157ae682-710f7701044mr190802997b3.20.1749485904209; Mon, 09 Jun 2025
 09:18:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250429163212.618953-1-peter.maydell@linaro.org>
 <CAFEAcA_hV=962gFfKc-7D91X-MXxVs=VrKQVzOKaLS2gJDt5Lw@mail.gmail.com>
In-Reply-To: <CAFEAcA_hV=962gFfKc-7D91X-MXxVs=VrKQVzOKaLS2gJDt5Lw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Jun 2025 17:18:13 +0100
X-Gm-Features: AX0GCFtmIcEJ2SgcH-ufEb6azb1SNvl50i_KaJUuglerQEv2-IIh92Kz9iYRGnQ
Message-ID: <CAFEAcA98gbjUX08NccePxGB2k0S+fjFArgz4WjFc5CZdDQ0ezg@mail.gmail.com>
Subject: Re: [PATCH 0/2] docs: Avoid duplicate labels with a sphinx extn
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

Ping^2 on this one?

-- PMM

On Mon, 19 May 2025 at 15:32, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Ping? Any opinions on this?
>
> In the interim we've applied commit 82707dd4f0 to drop
> the specific duplicate-label that is causing problems
> right now, so patch 2 here will need the obvious trivial
> update. But I do think this is a better approach than
> forever avoiding defining labels in .rst.inc files...
>
> thanks
> -- PMM
>
> On Tue, 29 Apr 2025 at 17:32, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > Sphinx requires that labels within documents are unique across the
> > whole manual.  This is because the "create a hyperlink" directive
> > specifies only the name of the label, not a filename+label.  Some
> > Sphinx versions will warn about duplicate labels, but even if there
> > is no warning there is still an ambiguity and no guarantee that the
> > hyperlink will be created to the intended target.
> >
> > For QEMU this is awkward, because we have various .rst.inc fragments
> > which we include into multiple .rst files.  If you define a label in
> > the .rst.inc file then it will be a duplicate label.  We have mostly
> > worked around this by not putting labels into those .rst.inc files,
> > or by adding "insert a label" functionality into the hxtool extension
> > (see commit 1eeb432a953b0 "doc/sphinx/hxtool.py: add optional label
> > argument to SRST directive"). However, we let one into the codebase
> > without initially noticing, in commit 7f6314427e ("docs/devel: add a
> > codebase section"), because not all versions of Sphinx warn about
> > the duplicate labels.
> >
> > This patchset resolves the problem by implementing a small Sphinx
> > extension. The extension lets you write in a .rst.inc:
> >
> >   .. uniquelabel:: mylabel
> >
> > and it will be as if you had written:
> >
> >   .. _foo/bar-mylabel
> >
> > where foo/bar.rst is the top level document that includes the
> > .rst.inc file.
> >
> > Patch 1 is the extension; patch 2 is the use of it to fix the
> > problem in qemu-block-drivers.rst.inc. (Concretely, the result is
> > that instead of an ambiguous "nbd" label, we now have separate
> > "system/images-nbd" and "system/qemu-block-drivers-nbd" labels.
> > We want to link to the former, because the latter is in the
> > manpage, not the proper HTML manual.)
> >
> > This patchset is a bit RFC quality -- I have not tested it
> > super thoroughly, and the extension itself is written based on
> > our existing ones, because I'm neither a Python nor a Sphinx
> > expert. I figured I'd send it out to see if people agreed that
> > it was the right way to solve this problem.
> >
> > (In theory we could remove the SRST(label) functionality from
> > the hxtool extension and have the .hx files use uniquelabel.
> > Not sure that's worthwhile at this point.)
> >
> > PS: I find that our extensions are confused about whether they
> > should set "required_arguments = 1" or "required_argument = 1";
> > probably the latter are all bugs that happen to have no bad
> > side effects...
> >
> > thanks
> > -- PMM
> >
> > Peter Maydell (2):
> >   docs: Create a uniquelabel Sphinx extension
> >   docs: Use uniquelabel in qemu-block-drivers.rst.inc
> >
> >  docs/conf.py                           |  1 +
> >  docs/devel/codebase.rst                |  2 +-
> >  docs/sphinx/uniquelabel.py             | 74 ++++++++++++++++++++++++++
> >  docs/system/qemu-block-drivers.rst.inc |  2 +-
> >  4 files changed, 77 insertions(+), 2 deletions(-)
> >  create mode 100644 docs/sphinx/uniquelabel.py
> >
> > --

