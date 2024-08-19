Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D12FC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 16:08:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sg4ub-0004Dr-QX; Mon, 19 Aug 2024 12:07:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1sg4uZ-0004Ch-Is
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 12:07:15 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1sg4uX-0006tv-G9
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 12:07:15 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3db1e4219f8so2490935b6e.3
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 09:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724083631; x=1724688431; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7cPhvpuIKVsVF4/fRvKXeyayuZaEA8iRK9Tg9wP7gYQ=;
 b=eDsXOKXS2eEO4LjUCDdU8xUjHY6I8annWGHxZyvZEFQGrVW88olPya7zboTLpYZUgx
 vveyQDeENqeFDCnEaH+DjhMInkyksSSDpPUYq0ZImwY82eRwmoa6/Ztqoho2SnE5NVCO
 sIxKygiRw+HChUHyuCeXAjWstJguUxhB9Bex0q8yFDPydgvwgg+e0fxjufxUG9dfkovj
 dyses9QoAXLNGA/UPf1wpK1/D39Yuy4dPtnLeBYKHV8ZAuasVEe46/lerPJ2Z9FAZAHt
 JWOENDGesQwO8Bmvx6f8U0IkqCO2e8B2fLeHn0V9fa+NkQj4IFpEoZtxYpJhg9DEy4Di
 KzNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724083631; x=1724688431;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7cPhvpuIKVsVF4/fRvKXeyayuZaEA8iRK9Tg9wP7gYQ=;
 b=Q1C1xkYCn7s0JsvkgNKSBiK6TkPVA3+MKu8TC3mM4yCM8Le+SeSfhSOr1/6tpD7xLs
 ZevGxtDyAiaIshYHueJ84QHKZilvUEB4XelGk7egmQ9/Z1b+1KF2IEVggOksTCglFyLr
 k6t8bKRQFXR0Gu6HQvItD96pp4GoS9hEOCaXrGGWuztnbCzTvGsYZBK6GHV8wKG5V2Cq
 KdL6RTD1v0SuaqMBOCfT5lNYq5fG4GcxSRKz0w/6lDaAOnuSNZWGGIffZ+JOJod7irdM
 3mEMZvMwkS8T7pZqxypepmW2opEtnTHFtOG5y7iEq7manIaOpI0T2NAXbjbu9UbxpM9f
 X8vA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfpf2Um8KJrZB1RSYhitD77bO+RS+yze2Fa49ul0mJcWByaXe5K/p+NMYVNn5CAtOyJ0t/O2aekfBORo6G4Uwr6jDPK30=
X-Gm-Message-State: AOJu0Yxtg6lSAHXbJYS/5gusRVny2CywtdR94ZE8LuqcSWZmmA9eW5ur
 wfhg2Wr6H0bvwjT3hSRA5I9wllsbPiCCdo8wLAHjIDbIrGRPA5quwve0l52mB12R0oVTg1pVLVf
 PTWr2g7sgxaPKk683qjFuf4t3WhE=
X-Google-Smtp-Source: AGHT+IGLg8Bmt2GgNBgald9bns5TpA2v7WxlBVs12v9rH/hquJN8aOz+B4Qgl31CQTft1BRH54weTMoeP58XbXCLvA4=
X-Received: by 2002:a05:6358:99a0:b0:1ac:f35c:1587 with SMTP id
 e5c5f4694b2df-1b3932c9929mr897006455d.25.1724083630451; Mon, 19 Aug 2024
 09:07:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240818114257.21456-1-dorjoychy111@gmail.com>
 <20240818114257.21456-5-dorjoychy111@gmail.com>
 <bffedf65-6046-4264-a2fe-011ff8c58860@amazon.com>
 <CAFfO_h7+FEzp-FrYM68A104CyNKgUfEReB+o9gYg5i-f=5DsVg@mail.gmail.com>
 <ZsNqerjjLCJ2OICd@redhat.com>
In-Reply-To: <ZsNqerjjLCJ2OICd@redhat.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Mon, 19 Aug 2024 22:07:02 +0600
Message-ID: <CAFfO_h5uQWrEKVK+E_QW7x64kdPms4uFeP8TjDVq7JEWANKXPw@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] machine/nitro-enclave: Add built-in Nitro Secure
 Module device
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Alexander Graf <graf@amazon.com>, qemu-devel@nongnu.org, agraf@csgraf.de, 
 stefanha@redhat.com, pbonzini@redhat.com, slp@redhat.com, 
 richard.henderson@linaro.org, eduardo@habkost.net, mst@redhat.com, 
 marcel.apfelbaum@gmail.com, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=dorjoychy111@gmail.com; helo=mail-oi1-x236.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Aug 19, 2024 at 9:53=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Mon, Aug 19, 2024 at 09:32:55PM +0600, Dorjoy Chowdhury wrote:
> > On Mon, Aug 19, 2024 at 4:13=E2=80=AFPM Alexander Graf <graf@amazon.com=
> wrote:
> > >
> > > Hey Dorjoy,
> > >
> > > On 18.08.24 13:42, Dorjoy Chowdhury wrote:
> > > > AWS Nitro Enclaves have built-in Nitro Secure Module (NSM) device w=
hich
> > > > is used for stripped down TPM functionality like attestation. This =
commit
> > > > adds the built-in NSM device in the nitro-enclave machine type.
> > > >
> > > > In Nitro Enclaves, all the PCRs start in a known zero state and the=
 first
> > > > 16 PCRs are locked from boot and reserved. The PCR0, PCR1, PCR2 and=
 PCR8
> > > > contain the SHA384 hashes related to the EIF file used to boot the
> > > > VM for validation.
> > > >
> > > > Some optional nitro-enclave machine options have been added:
> > > >      - 'id': Enclave identifier, reflected in the module-id of the =
NSM
> > > > device. If not provided, a default id will be set.
> > > >      - 'parent-role': Parent instance IAM role ARN, reflected in PC=
R3
> > > > of the NSM device.
> > > >      - 'parent-id': Parent instance identifier, reflected in PCR4 o=
f the
> > > > NSM device.
> > > >
> > > > Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> > > > ---
> > > >   crypto/meson.build              |   2 +-
> > > >   crypto/x509-utils.c             |  73 +++++++++++
> > >
> > >
> > > Can you please put this new API into its own patch file?
> > >
> > >
> > > >   hw/core/eif.c                   | 225 +++++++++++++++++++++++++++=
++---
> > > >   hw/core/eif.h                   |   5 +-
> > >
> > >
> > > These changes to eif.c should ideally already be part of the patch th=
at
> > > introduces eif.c (patch 1), no? In fact, do you think you can make th=
e
> > > whole eif logic its own patch file?
> > >
> > >
> > > >   hw/core/meson.build             |   4 +-
> > > >   hw/i386/Kconfig                 |   1 +
> > > >   hw/i386/nitro_enclave.c         | 141 +++++++++++++++++++-
> > > >   include/crypto/x509-utils.h     |  22 ++++
> > > >   include/hw/i386/nitro_enclave.h |  26 ++++
> > > >   9 files changed, 479 insertions(+), 20 deletions(-)
> > > >   create mode 100644 crypto/x509-utils.c
> > > >   create mode 100644 include/crypto/x509-utils.h
> > > >
> > > > diff --git a/crypto/meson.build b/crypto/meson.build
> > > > index c46f9c22a7..09633194ed 100644
> > > > --- a/crypto/meson.build
> > > > +++ b/crypto/meson.build
> > > > @@ -62,7 +62,7 @@ endif
> > > >   if gcrypt.found()
> > > >     util_ss.add(gcrypt, files('random-gcrypt.c'))
> > > >   elif gnutls.found()
> > > > -  util_ss.add(gnutls, files('random-gnutls.c'))
> > > > +  util_ss.add(gnutls, files('random-gnutls.c', 'x509-utils.c'))
> > >
> > >
> > > What if we don't have gnutls. Will everything still compile or do we
> > > need to add any dependencies?
> > >
> > >
> >
> > [...]
> >
> > > >
> > > > diff --git a/hw/core/meson.build b/hw/core/meson.build
> > > > index f32d1ad943..8dc4552e35 100644
> > > > --- a/hw/core/meson.build
> > > > +++ b/hw/core/meson.build
> > > > @@ -12,6 +12,8 @@ hwcore_ss.add(files(
> > > >     'qdev-clock.c',
> > > >   ))
> > > >
> > > > +libcbor =3D dependency('libcbor', version: '>=3D0.7.0')
> > > > +
> > > >   common_ss.add(files('cpu-common.c'))
> > > >   common_ss.add(files('machine-smp.c'))
> > > >   system_ss.add(when: 'CONFIG_FITLOADER', if_true: files('loader-fi=
t.c'))
> > > > @@ -24,7 +26,7 @@ system_ss.add(when: 'CONFIG_REGISTER', if_true: f=
iles('register.c'))
> > > >   system_ss.add(when: 'CONFIG_SPLIT_IRQ', if_true: files('split-irq=
.c'))
> > > >   system_ss.add(when: 'CONFIG_XILINX_AXI', if_true: files('stream.c=
'))
> > > >   system_ss.add(when: 'CONFIG_PLATFORM_BUS', if_true: files('sysbus=
-fdt.c'))
> > > > -system_ss.add(when: 'CONFIG_NITRO_ENCLAVE', if_true: [files('eif.c=
'), zlib])
> > > > +system_ss.add(when: 'CONFIG_NITRO_ENCLAVE', if_true: [files('eif.c=
'), zlib, libcbor, gnutls])
> > >
> > >
> > > Ah, you add the gnutls dependency here. Great! However, this means we
> > > now make gnutls (and libcbor) a mandatory dependency for the default
> > > configuration. Does configure know about that? I believe before gnutl=
s
> > > was optional, right?
> > >
> >
> > I see gnutls is not a required dependency in the root meson.build. I
> > am not sure what we should do here.
> >
> > Hey Daniel, do you have any suggestions about how this dependency
> > should be included?
>
> Unconditionally build the crypto/x509-utils.c file, but in that put
> file #ifdef CONFIG_GNUTLS, and in the #else put a stub impl of the
> method that just calls error_setg().
>
> That way you can compile everything without any hard dep on gnutls,
> but if someone tries to use it they'll get a runtime error when
> gnutls is not built
>

Understood. Thanks! What should I do about libcbor? That one is
required for building nitro-enclave and virtio-nsm. Should I make that
required in the root meson.build file?

Regards,
Dorjoy

