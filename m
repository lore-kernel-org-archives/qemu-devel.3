Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57F59C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 10:44:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7C7O-0007oO-Gd; Wed, 15 May 2024 06:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1s7C7K-0007o9-48; Wed, 15 May 2024 06:44:14 -0400
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1s7C7G-0001Cc-HQ; Wed, 15 May 2024 06:44:13 -0400
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-43df23e034cso55007841cf.0; 
 Wed, 15 May 2024 03:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715769848; x=1716374648; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qbrxhbBrSudiuTQwegR9n0jfhv38yvygIH870EOJMUI=;
 b=JDLJBT9tUa11HID71XDegxDuQs3jNZ9DUPJ6O56hPJe+jYe1Z/Cd2oMx0MvdrPRRKS
 Jpf7dJ7Zoc24l33Br7NMdO9IpM/q8JyryjoHsipiP5p5qsbkKfmlBcyXxA+StIKrJsHp
 TnBhAioDniNJgFUEWHNi/9bAtCS8Qo5/gNGKDDzTxx3fC1cJygb+ZSlKfwoRGcy8/aoX
 +nmHzXkoexIYRXnGTumxSAR+C4KoHbgflQbeiZ5PyK99XxTL1KOusszXbJ7oBIW+IsvK
 hZwJtLv9aIvqRR6z2mcNPUAnOVsL2w8DdP4AmzEe0MKiOJ2KCxDK3MJtZyiMvVbFVYEh
 3Vsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715769848; x=1716374648;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qbrxhbBrSudiuTQwegR9n0jfhv38yvygIH870EOJMUI=;
 b=OTjS1Cx28nF6gLIQDzKNAqp1V6vaGt9oibQUgM8nMI9yDxyawtz1ajd1o80D/r+6Zj
 8aLhyLNs0Kw6Q3iPaXbTgY8zdFCGs7+UjWgCv4vqz9m6VPpcAImA9DMh1dbDCLX6x0D6
 HUx9APfgczq1oT3s3K/fGIYSMIo9omHZVOvsSnKenzbUXliAG4todjifCVBDbaQkPR4D
 CuEVN3F/fGv7eKm0NO0lFZpdySQkG9kcFBkM60KghP3oosloX4b+V5/xmBNXOGAPOAsl
 EOSTV9PAIyFZo3bOs+AOZjQiLCcY+4udKytGKIPngkwrJPtZQM5EVVMD4waN+iXscL+M
 dd7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUV4UkEtd/TLMmo45pZVBFtWzDOwh9K0xXBzrSMFYfBYfhzFnPb2cdBUBlQFZjJR1NlkQBwleKpxNpBHQqXJUKGnRMKBUn6
X-Gm-Message-State: AOJu0YxGLcCpsRTRbmiNf7orIB9htcGDK4nIThTzLROt+byqiCm4RU1i
 C/zP9oLLrEG9nXTgtbkZFr4Q0+1pyrHgZbDTgJ88rCbHnc1KLKHRdiX3tdg2nip7HR4wZATQVF/
 PzXVPuF2gvGedTSGORZATDR+gqdA=
X-Google-Smtp-Source: AGHT+IHcV9m1c6NlmkkbqK8LtXM9mTQ8fbQSvFSyujnDMYIr70EAgKvTD6KT3uTGiYxkrJKQh9FfjYs6ErPcWiojO18=
X-Received: by 2002:ac8:7d86:0:b0:43a:3fce:32c2 with SMTP id
 d75a77b69052e-43debf55b93mr286900671cf.3.1715769848062; Wed, 15 May 2024
 03:44:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240514131725.931234-1-marcandre.lureau@redhat.com>
 <5d004901-f1f4-43bb-81ee-d78ec0a83fbb@tls.msk.ru>
In-Reply-To: <5d004901-f1f4-43bb-81ee-d78ec0a83fbb@tls.msk.ru>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 15 May 2024 14:43:56 +0400
Message-ID: <CAJ+F1C+MFkbTGmzLujc7=Q74uGz3fUxkZtp3Yi5eUOLQYco6ow@mail.gmail.com>
Subject: Re: [PULL 00/11] Ui patches
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-stable <qemu-stable@nongnu.org>, 
 hikalium <hikalium@hikalium.com>, Dongwon Kim <dongwon.kim@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82f.google.com
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

Hi

On Wed, May 15, 2024 at 2:29=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:
>
> 14.05.2024 16:17, marcandre.lureau@redhat.com wrote:
> > ----------------------------------------------------------------
> > UI: small fixes and improvements
> >
> > ----------------------------------------------------------------
> >
> > Bernhard Beschow (1):
> >    ui/sdl2: Allow host to power down screen
> >
> > Dongwon Kim (7):
> >    ui/gtk: Draw guest frame at refresh cycle
> >    ui/gtk: Check if fence_fd is equal to or greater than 0
> >    ui/console: new dmabuf.h and dmabuf.c for QemuDmaBuf struct and
> >      helpers
> >    ui/console: Use qemu_dmabuf_get_..() helpers instead
> >    ui/console: Use qemu_dmabuf_set_..() helpers instead
> >    ui/console: Use qemu_dmabuf_new() and free() helpers instead
> >    ui/console: move QemuDmaBuf struct def to dmabuf.c
> >
> > Sergii Zasenko (1):
> >    Allow UNIX socket option for VNC websocket
> >
> > hikalium (2):
> >    ui/gtk: Add gd_motion_event trace event
> >    ui/gtk: Fix mouse/motion event scaling issue with GTK display backen=
d
>
>  From this list, it looks like
>
>    ui/gtk: Draw guest frame at refresh cycle

I would allow a bit more time for this to be actually more widely tested.

Dongwon, wdyt?

>    ui/gtk: Check if fence_fd is equal to or greater than 0  (questionable=
, minor issue)

minor, but fine in stable too.

>    ui/gtk: Fix mouse/motion event scaling issue with GTK display backend

ok for stable imho (even though I don't like that we don't support
hidpi correctly, as I described in the patch review)

