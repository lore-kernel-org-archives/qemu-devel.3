Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54EC9C71136
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 19:10:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPQpP-00021c-CS; Wed, 11 Jun 2025 15:09:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uPQpL-00021A-Vs
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 15:09:36 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uPQpJ-000759-Tv
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 15:09:35 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-605b9488c28so405448a12.2
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 12:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749668970; x=1750273770; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L2jcq4JR31ZncXo7GCs+Vs2TyWS4MOEzTFNBBWpcIPI=;
 b=ZoKbVKKPopCaZ6n3DbIJx6nqrSAyotyOTe9Ic3vsPxsn3K+oH4Blb3mmNJQkyTI3V4
 1VxWXj+mmllcy3fmNn0z7amDpowe+SzjJYDOVgf8SbuxnGTagKI41uST91ANTd9+YNRo
 65EnZorschkSTsTMfery/zPQn6WGSXprtcZf2fPOhbadUd9ha+k74SNnO1733ADe+kZY
 7SINbnuSh48fqY2sveRJe7PQMpWRBddvWOYAFwmC81KAYdu/dv63WMpVKEfTy2pssfpo
 393Jf6hv/HUGg0cdfrof/BWqLgWPrXglH9sFIrAWuwP7kAZ+986dTedquJiWZ5zXOyEj
 uFig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749668970; x=1750273770;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L2jcq4JR31ZncXo7GCs+Vs2TyWS4MOEzTFNBBWpcIPI=;
 b=JKxT/1Bps07VK9+tNPhTEnD6RFP/moSURp11Z5xVmp/LC3AFgIp58GXkhdMoonyTkl
 JFke05B42s5N5tsA3A0nSM1So9kLU1/RC7A6TIUZ9XXYz9/BP989qOCJvZy4QAT/laj9
 BvWSOLx5o5HuJSdMIhrcoOoEPE5oXIMaGWuQ+SnAItgT2gAI/EQQcHf+1o8HfqOM0Nbt
 iMAacLSOYZid+KTboX1x9m+nyZVFkotqf43jyHH0TaiJdacGFfQFrF3x0PdWGN3MJt04
 xBTLCf0buU/n5t8QR8XlJQgSm4pN9gLwi3J7KtmNkkRJvapwFkqLRcSLAisZ1B7emPdk
 LoCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4l42x9ZE1VOdKPqZmzYXSqVf0KWguK1zFzlDVm4DJHSsMMmYxPfjpdIg2/LbWCyModKz4lDP1LTsv@nongnu.org
X-Gm-Message-State: AOJu0YwnkGMn9283waqfAePl6bbU8jZZuSsGNtRxyHhNmFuuDBx68wZt
 XF/niUi8aKmeX/mnF8XnFJD8/InDZlMhPpeBs7+n4cBzjhKH1krBDAJol4wAJ7/4m8syy8xXiBT
 Z58wUDawCqt5JMKqLq9i0SMbLOUzmp3s=
X-Gm-Gg: ASbGncvDZcrd+SUYawwdui0bTBTmW9bMsl3HLxiybLfaZGguilqAd5CgXm03755rlC6
 V//mqtalbVq78kVNeH8jgpFHqfA7eZyGsups2XzIFf5mUIfJZ9cC/t32JyQ2o+C++HXtu/7Wy6m
 vJmuP7uLMdQDexC3sjeRk3Y7KHZnRf51+V/N9AwqKAqg==
X-Google-Smtp-Source: AGHT+IGaID/PpihC/S0A7DaDOv/gziZPBfkw28zGbWEu3rzgXxVVNVFVE49tH1VJnUgMdHxeBOai4uEumDy8e7F4JGc=
X-Received: by 2002:a05:6402:13d5:b0:608:47ef:46e4 with SMTP id
 4fb4d7f45d1cf-60863aca018mr984283a12.17.1749668970001; Wed, 11 Jun 2025
 12:09:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250611075037.659610-1-kraxel@redhat.com>
 <3bc239aa-a2ab-400c-84b5-d7de3e5193ea@redhat.com>
In-Reply-To: <3bc239aa-a2ab-400c-84b5-d7de3e5193ea@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 11 Jun 2025 15:09:18 -0400
X-Gm-Features: AX0GCFvjHxzjSDXWD0llLG_SWNT90cCZjPbrzhvbUqU-MzjN0qdYWP7ZaelBp-I
Message-ID: <CAJSP0QU++wDCXvYe2sUyHCZHrHVVY2ehdeAswjDE_5V2J-qE9w@mail.gmail.com>
Subject: Re: [PULL 0/2] Seabios 1.17.0 20250611 patches
To: Thomas Huth <thuth@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, 
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, Jun 11, 2025 at 2:36=E2=80=AFPM Thomas Huth <thuth@redhat.com> wrot=
e:
>
> On 11/06/2025 09.50, Gerd Hoffmann wrote:
> > The following changes since commit bc98ffdc7577e55ab8373c579c28fe24d600=
c40f:
> >
> >    Merge tag 'pull-10.1-maintainer-may-2025-070625-1' of https://gitlab=
.com/stsquad/qemu into staging (2025-06-07 15:08:55 -0400)
> >
> > are available in the Git repository at:
> >
> >    https://gitlab.com/kraxel/qemu.git tags/seabios-1.17.0-20250611-pull=
-request
> >
> > for you to fetch changes up to cba36cf3881e907553ba2de38abd5edf7f952de1=
:
> >
> >    seabios: update binaries to 1.17.0 (2025-06-11 09:45:00 +0200)
> >
> > ----------------------------------------------------------------
> > seabios: update to 1.17.0 release
> >
> > ----------------------------------------------------------------
> >
> > Gerd Hoffmann (2):
> >    seabios: update submodule to 1.17.0
> >    seabios: update binaries to 1.17.0
>
>   Hi Gerd, hi Stefan,
>
> I'm now getting this when doing a git pull:
>
> Fetching submodule roms/seabios
> fatal: remote error: upload-pack: not our ref
> b52ca86e094d19b58e2304417787e96b940e39c6
> Errors during submodule fetch:
>         roms/seabios

GitLab CI didn't detect this, probably because the tests don't build
SeaBIOS from source and use the binaries instead. Given infinite CI
resources we should rebuild all ROMs from source to catch problems
like this one.

I wanted to mention this in case anyone wants to tighten up the CI to
catch these issues for SeaBIOS and other ROMs.

> Looking at
> https://gitlab.com/qemu-project/seabios/-/commits/master?ref_type=3DHEADS
> there is a problem with the mirroring:
>
> "This project is mirrored from https://review.coreboot.org/seabios. Pull
> mirroring failed 4 months ago.
> Repository mirroring has been paused due to too many failed attempts. It =
can
> be resumed by a project maintainer or owner.
> Last successful update 4 months ago. This branch has diverged from upstre=
am. "
>
> Could you please fix this?

`git clone https://review.coreboot.org/seabios` works on my machine,
but I manually clicked the "update" button and GitLab failed again.

In the GitLab UI there is a button to add a new mirror repo. I thought
maybe we can delete the old repo and add a new one, but the push/pull
direction dropdown list is disabled. Maybe that's because only 1 repo
can be a mirror source for pull, I'm worried that deleting the
existing failed repo will leave us with no way to add a new repo that
supports pull.

Does anyone know how to go about fixing this failed mirror?

Stefan

