Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 854C2C25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 22:15:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9uEE-0002V8-VU; Wed, 22 May 2024 18:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1s9uEC-0002Ul-UE
 for qemu-devel@nongnu.org; Wed, 22 May 2024 18:14:32 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1s9uDy-0002aQ-Rd
 for qemu-devel@nongnu.org; Wed, 22 May 2024 18:14:32 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2e428242a38so102476801fa.2
 for <qemu-devel@nongnu.org>; Wed, 22 May 2024 15:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716416055; x=1717020855; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xbuJJfPfkTRs7CGDQKwHKalBzntdU/4JsaQpMQKjOHU=;
 b=JiyJvAp/Ld/7em+MeEq508FA7rDr9EIsbUqlLKtgQGlLCrVTOUveuSPnjNpnF447CN
 iVmmL2ogEBMZnzEk4CGlbMIfw44dPY5nSra9EhZcvL1wkAeMl3QOxDeCuKID8HPms5oR
 TX/+H8Rt8OJlsBbLRslyvUdwXey9feNCxdFMAP5LItHDj5L/8hCEcVMVB7QWEeAw4zmu
 YOv3VXDhzeSELWOdlsw1filmXjvl8/yYwtHz65vit7xDSkR0V70LZwMx9ZIJq6dPg3b9
 Q7itR+nwnXjEAJEowO8TWCsg6RSZNM7zIyU5ywINx2cEeDmH3ixpZ5yZGUdZI5P/AXTK
 niqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716416055; x=1717020855;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xbuJJfPfkTRs7CGDQKwHKalBzntdU/4JsaQpMQKjOHU=;
 b=OXTbY3BmOwKfbyUjriJg21iGCazAdCN28D2SNtpHXJxWX/d4HvDsoLVYDImbnObk1E
 DZi3q4Alu87qCeh2HFvL3WP9NbEYfSZLXeQ1hb8h/qneQbbAuyvRVrdm/JBT/knIEDmD
 FR/V8163fwgURPEV4Jl4abG9pyFWsWhSEaRfX5dGtQTgdAUEVu71HeMx75YIF/PqDtwO
 rt1VqrynLqw28ddBPxjg5skcsVHjclWm9IMvhjTwBqHJqxmB9NgHuQRasF1tdF71s/Hi
 ItovUrTelRBOShquzDNk7xdrX4I/INhMdswv2Bh+KFvbFXADZzI9rmm2TQqmrGfUCXWG
 7mlw==
X-Gm-Message-State: AOJu0YzF2H5dPh+yBLkXgVZnAvQY4GPTwR0NHnv3o4Yo68AQ7ilZYJ8p
 iTEFLZaEwfWvS2rbs2XwPff79mEQNX3E0soazs+xF7AK69GCPBwR7cgOnJzNvQIbOVDETIlgs2l
 oZO9aVGVp4lG05GzCypkzSj36VSUFVYb4dFBPF9sxjy5cIBs/
X-Google-Smtp-Source: AGHT+IH3d0VlZfDtgDZOgp3GYtVcwXRUio91d6JHDYQaCunFhQTT0eCiUfi8nm9ASFD7K9d7dG91/oijw1QCeoQNs9U=
X-Received: by 2002:a2e:3618:0:b0:2e1:a747:532d with SMTP id
 38308e7fff4ca-2e949430476mr25688611fa.8.1716416054977; Wed, 22 May 2024
 15:14:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240516120344.531521-1-kraxel@redhat.com>
 <20240516120344.531521-2-kraxel@redhat.com>
 <6c9a0d95-edc9-445f-8063-23a30dd74443@redhat.com>
In-Reply-To: <6c9a0d95-edc9-445f-8063-23a30dd74443@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 23 May 2024 01:13:58 +0300
Message-ID: <CAAjaMXYpzbLh58y0z=FBeOxa5k2D8o1r6dsD9wuai+6iBawCQQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] MAINTAINERS: drop audio maintainership
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Alexandre Ratchov <alex@caoua.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x235.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Wed, 22 May 2024 at 15:54, Thomas Huth <thuth@redhat.com> wrote:
>
> On 16/05/2024 14.03, Gerd Hoffmann wrote:
> > Remove myself from audio (both devices and backend) entries.
> > Flip status to "Orphan" for entries which have nobody else listed.
> >
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >   MAINTAINERS | 19 ++++---------------
> >   1 file changed, 4 insertions(+), 15 deletions(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 1b79767d6196..7f52e2912fc3 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> ...
> > @@ -2388,7 +2387,6 @@ F: hw/virtio/virtio-mem-pci.c
> >   F: include/hw/virtio/virtio-mem.h
> >
> >   virtio-snd
> > -M: Gerd Hoffmann <kraxel@redhat.com>
> >   R: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> >   S: Supported
>
> I think the status should be downgraded to Orphan or at least Odd-fixes,
> unless Manos wants to upgrade from "R:" to "M:" ?

That's fine with me.

> >   ALSA Audio backend
> > -M: Gerd Hoffmann <kraxel@redhat.com>
> >   R: Christian Schoenebeck <qemu_oss@crudebyte.com>
> >   S: Odd Fixes
> >   F: audio/alsaaudio.c
>
> I'd also suggest that Christian either upgrade from R: to M: or that we
> change the status to Orphan

If Christian is not available I volunteer to be a Reviewer (but not
M:) since I have some familiarity with alsaaudio.c
This way even if Orphan it will have more reviewers available.

>
> >   JACK Audio Connection Kit backend
> > -M: Gerd Hoffmann <kraxel@redhat.com>
> >   R: Christian Schoenebeck <qemu_oss@crudebyte.com>
> >   S: Odd Fixes
> >   F: audio/jackaudio.c
>
> dito
>
> >   SDL Audio backend
> > -M: Gerd Hoffmann <kraxel@redhat.com>
> >   R: Thomas Huth <huth@tuxfamily.org>
>
> I'm fine if you update my entry from R: to M: here.
>
> >   S: Odd Fixes
> >   F: audio/sdlaudio.c
> >
> >   Sndio Audio backend
> > -M: Gerd Hoffmann <kraxel@redhat.com>
> >   R: Alexandre Ratchov <alex@caoua.org>
> >   S: Odd Fixes
> >   F: audio/sndioaudio.c
>
> Same again, I'd suggest to either set to Orphan or upgrade the R: entry?
>
>   Thomas
>

