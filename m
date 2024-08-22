Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F31C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 15:14:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh9WQ-0005gb-53; Thu, 22 Aug 2024 11:14:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1sh9WO-0005bF-Q9
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 11:14:44 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1sh9WG-0005vJ-2R
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 11:14:44 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7094641d4e6so430948a34.3
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 08:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724339675; x=1724944475; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iueKEjXC5Bp4smvKO7YnoKOVUPr0nu7vvInic9j2cnQ=;
 b=BrHne6I5wAkkX4+vy1jFv1qJf1JRZKT40x7fGYM/7aCMXS/uVajsfaWPJeMvEJ8tDd
 vji4PSWp7vpx6npVoMowfyo0nGOpJ/lxcomqwMsX4hodX37irh7dMAf2/sTugXo8pWtq
 2FT2XyHXLyiMvRebiFtRC5pVLlegiLghlGR1qx5Z/Jke1GzLqWGt4kdfZ3ULg81x38xT
 WhadZPykjfUGLZap3W+RLjy9J6SM2am1RaZeQRJbNT7pLO5b85aKUcTGGbGaY9xL9eMJ
 fDzOcL3pH1Bw0LYXgky520lAXGP1SN8QIGm+DZYmrGicIarrmybniRqjtNdVxlbwxEFw
 omCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724339675; x=1724944475;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iueKEjXC5Bp4smvKO7YnoKOVUPr0nu7vvInic9j2cnQ=;
 b=rMLK+ayQp8W/UJ/Vix4X30PJ5p7sbrDyEwmII6V49UEeksynJADEmfKJq71/4vpQ0Z
 RyzgpBa4yCGAwrBtLwTkJOcMGMFOcsn9r68XPgay0qkKI3Q0AO4T4k5E9hpk9JIB18uC
 8CzA2FPk1/6Y+8ytZZjRWTbKb/f1S7TItHQfdwDh/PvTGZumRX0NQJf7jeXStL9OprJ+
 VqAbpW7SGZh5P6AFZcBsHzOaFhQ3n96NRuFMXdhtx49+K4Ao951w7r6Fwb0U4xvqpDTc
 ymqqVrKTWwJ8P2qJjf569b0rLvGWa5OVj9K3vETtXF7J2o7ZDHqY0Sp7n3N9ioOCgAgr
 ZQqA==
X-Gm-Message-State: AOJu0YySJnD03qhvQVJurR9TIh+bMGpwVid5o2QkT5KKdm+831RBhWp1
 ZHgAvXqhzkl/IdSh260D5yljz4eLv43R36DsJCCo6/LbhkKo9iIGDzDYPTgPsA2ldz0DID+x4WD
 zYImBq3HGWBuUxzM6jH1gsaBpS1o=
X-Google-Smtp-Source: AGHT+IH5L50SxSe7x3u7OhwW1QbX2J0aE6Rxts21MmrANXPat/olhMSJptg+J3Kzn9ZbrVIPyoemMIwP4D6rCALyErM=
X-Received: by 2002:a05:6808:2218:b0:3dc:39b7:fa with SMTP id
 5614622812f47-3de2334ea3fmr1980204b6e.50.1724339674664; Thu, 22 Aug 2024
 08:14:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240818114257.21456-1-dorjoychy111@gmail.com>
 <20240818114257.21456-5-dorjoychy111@gmail.com> <ZsMgcUtCvXqbYigI@redhat.com>
In-Reply-To: <ZsMgcUtCvXqbYigI@redhat.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Thu, 22 Aug 2024 21:14:28 +0600
Message-ID: <CAFfO_h6KZ65e3AVE7+giTVhxOWcOnAgLMgp54LsJjjvSnutpew@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] machine/nitro-enclave: Add built-in Nitro Secure
 Module device
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, graf@amazon.com, agraf@csgraf.de, 
 stefanha@redhat.com, pbonzini@redhat.com, slp@redhat.com, 
 richard.henderson@linaro.org, eduardo@habkost.net, mst@redhat.com, 
 marcel.apfelbaum@gmail.com, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=dorjoychy111@gmail.com; helo=mail-ot1-x32f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Daniel,

On Mon, Aug 19, 2024 at 4:37=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Sun, Aug 18, 2024 at 05:42:55PM +0600, Dorjoy Chowdhury wrote:
> > AWS Nitro Enclaves have built-in Nitro Secure Module (NSM) device which
> > is used for stripped down TPM functionality like attestation. This comm=
it
> > adds the built-in NSM device in the nitro-enclave machine type.
> >
> > In Nitro Enclaves, all the PCRs start in a known zero state and the fir=
st
> > 16 PCRs are locked from boot and reserved. The PCR0, PCR1, PCR2 and PCR=
8
> > contain the SHA384 hashes related to the EIF file used to boot the
> > VM for validation.
> >
> > Some optional nitro-enclave machine options have been added:
> >     - 'id': Enclave identifier, reflected in the module-id of the NSM
> > device. If not provided, a default id will be set.
> >     - 'parent-role': Parent instance IAM role ARN, reflected in PCR3
> > of the NSM device.
> >     - 'parent-id': Parent instance identifier, reflected in PCR4 of the
> > NSM device.
> >
> > Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> > ---
> >  crypto/meson.build              |   2 +-
> >  crypto/x509-utils.c             |  73 +++++++++++
> >  include/crypto/x509-utils.h     |  22 ++++
>
> Preferrably add these 3 in a standlone commit, since its is good practice
> to separate commits adding infra, from commits adding usage of infra.
>
> >  hw/core/eif.c                   | 225 +++++++++++++++++++++++++++++---
> >  hw/core/eif.h                   |   5 +-
> >  hw/core/meson.build             |   4 +-
> >  hw/i386/Kconfig                 |   1 +
> >  hw/i386/nitro_enclave.c         | 141 +++++++++++++++++++-
> >  include/hw/i386/nitro_enclave.h |  26 ++++
> >  9 files changed, 479 insertions(+), 20 deletions(-)
> >  create mode 100644 crypto/x509-utils.c
> >  create mode 100644 include/crypto/x509-utils.h
> >

[...]

> > +
> > +    /* First 16 PCRs are locked from boot and reserved for nitro encla=
ve */
> > +    for (int i =3D 0; i < 16; ++i) {
> > +        ne_state->vnsm->lock_pcr(ne_state->vnsm, i);
> > +    }
>
> Worth  NITRO_PCR_MAX constant ?
>

I kept the 16 for now.

> >  static void nitro_enclave_machine_initfn(Object *obj)
> >  {
> >      MicrovmMachineState *mms =3D MICROVM_MACHINE(obj);
> >      X86MachineState *x86ms =3D X86_MACHINE(obj);
> > +    NitroEnclaveMachineState *nems =3D NITRO_ENCLAVE_MACHINE(obj);
> > +
> > +    nems->id =3D g_strdup("i-234-enc5678");
>
> Is this some magic string that the Nitro spec requires ? If so, probably
> worth a #define constant for it with a comment about rationale.
>

It's just some default we provide, not related to Nitro spec. So kept
it as is for now.

Regards,
Dorjoy

