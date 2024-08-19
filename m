Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA60EC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 16:14:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sg51c-0006vS-Pi; Mon, 19 Aug 2024 12:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1sg51b-0006r5-NB
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 12:14:31 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1sg51Y-0007kE-MX
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 12:14:30 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5d5ed6f51cfso3029065eaf.0
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 09:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724084067; x=1724688867; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7qIIccd2X7yh54M4OHB2ZE8XggdP3bMhB3Ikjm1oj5A=;
 b=M5iMtuSqZ9KZ9h0TWNO+AqiXmJNsPoyvC1wA5TW9mCSxFVbBGlELBttltybNKcCZG5
 D0Rf3ahH4dnDyXCrzMgl0+7Zh0uon2Uyg6ceqlxEb9xQcEKwEd54Dwa8hhpVDkNF7m2M
 rLcr5zO0vCT4DLx5rCs8ok5np7NSQM6OE7zssvp0Nz74I+/VTLRDGvs1c16xGyjDDqmS
 FJPpXOiPixtquKCvypMRiHHp7rDMrNiTXC4Ff2wWcHOa+bSFgBPzE0TdAQxZnNaTRDa0
 mjBvAWgRxnB3a6T18luQ5Szk2IrMVIufavlB1MPWzbGWHHvWu4u9n7SlFeITdV8wgjKo
 ojhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724084067; x=1724688867;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7qIIccd2X7yh54M4OHB2ZE8XggdP3bMhB3Ikjm1oj5A=;
 b=o8mps/XUDwTco1FegZPDV4BD+lIlbE6se1GugXSvryXtbL55mYFH4BgPk7cS1aawdV
 x5MtDmXBBQEydIS82/iFdl3ikYt84VWlHAh/ekl6F9Atm7XL9nLkBPxjma7UfYfJLakb
 6z9FSYe0yZwpa7dXuKs52oT9LzEkX1lKlsPiJeqYDVLE3bPLXKKRLRs+guDFMB8utG05
 SkgAfHEs4zwO1vfGfCbCs69YgEuee3sKfB8dmxjxMkUnP9tYBxVS504mzuBCU8MppNVz
 qVGL+L3PcPzgIde25i/Y+EgqZNj/3VifbZE4IXS+dX5BtlpRqQE2sSUA7ed0SDCie7Ia
 CX+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2fqfsXXrJPWlK6BJhH/0SSUjSIbazVPmLhc/qGa9Mpz+PulUHcP0CEH3HXPhjLuJ1u4M8WMvEf7v+aCb2lxZIKB57RW4=
X-Gm-Message-State: AOJu0Yyx4zDgBEcxizLTk/IHPt2wN297zJePY1OkNVckx46ljbxsIHW6
 GDunaEOumFE8grI3MlkExGJnDQRXVGO1Vtmn8ybufNXF4P+YEa5Z3w3E4u3LDEuxUI2FfARzE9l
 HfJCG8WZv1J+x1B/jQnmuhNu90wYFlthP
X-Google-Smtp-Source: AGHT+IGmNNMvpU6LD9c/jG0ADCf4LBaaVUR+mY3lome7HIxTtXZ1vR7A0W338/NYzHxYIuDSGh3PgNga2AmSBMbg5c4=
X-Received: by 2002:a05:6358:5488:b0:1a1:fdee:fb68 with SMTP id
 e5c5f4694b2df-1b39328523fmr1588665355d.23.1724084067113; Mon, 19 Aug 2024
 09:14:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240818114257.21456-1-dorjoychy111@gmail.com>
 <20240818114257.21456-5-dorjoychy111@gmail.com>
 <bffedf65-6046-4264-a2fe-011ff8c58860@amazon.com>
 <CAFfO_h7+FEzp-FrYM68A104CyNKgUfEReB+o9gYg5i-f=5DsVg@mail.gmail.com>
 <ZsNqerjjLCJ2OICd@redhat.com>
 <CAFfO_h5uQWrEKVK+E_QW7x64kdPms4uFeP8TjDVq7JEWANKXPw@mail.gmail.com>
 <ZsNuf4jSSF4F37Pp@redhat.com>
In-Reply-To: <ZsNuf4jSSF4F37Pp@redhat.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Mon, 19 Aug 2024 22:14:20 +0600
Message-ID: <CAFfO_h6V1o3jx4sJ55+Wn7FiXpCcLNrZQtMboR4t6FMQuzg80w@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] machine/nitro-enclave: Add built-in Nitro Secure
 Module device
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Alexander Graf <graf@amazon.com>, qemu-devel@nongnu.org, agraf@csgraf.de, 
 stefanha@redhat.com, pbonzini@redhat.com, slp@redhat.com, 
 richard.henderson@linaro.org, eduardo@habkost.net, mst@redhat.com, 
 marcel.apfelbaum@gmail.com, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=dorjoychy111@gmail.com; helo=mail-oo1-xc2c.google.com
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

On Mon, Aug 19, 2024 at 10:10=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
>
> On Mon, Aug 19, 2024 at 10:07:02PM +0600, Dorjoy Chowdhury wrote:
> > On Mon, Aug 19, 2024 at 9:53=E2=80=AFPM Daniel P. Berrang=C3=A9 <berran=
ge@redhat.com> wrote:
> > >
> > > On Mon, Aug 19, 2024 at 09:32:55PM +0600, Dorjoy Chowdhury wrote:
> > > > On Mon, Aug 19, 2024 at 4:13=E2=80=AFPM Alexander Graf <graf@amazon=
.com> wrote:
> > > > >
> > > > > Hey Dorjoy,
> > > > >
> > > > > On 18.08.24 13:42, Dorjoy Chowdhury wrote:
> > > > > > AWS Nitro Enclaves have built-in Nitro Secure Module (NSM) devi=
ce which
> > > > > > is used for stripped down TPM functionality like attestation. T=
his commit
> > > > > > adds the built-in NSM device in the nitro-enclave machine type.
> > > > > >
> > > > > > In Nitro Enclaves, all the PCRs start in a known zero state and=
 the first
> > > > > > 16 PCRs are locked from boot and reserved. The PCR0, PCR1, PCR2=
 and PCR8
> > > > > > contain the SHA384 hashes related to the EIF file used to boot =
the
> > > > > > VM for validation.
> > > > > >
> > > > > > Some optional nitro-enclave machine options have been added:
> > > > > >      - 'id': Enclave identifier, reflected in the module-id of =
the NSM
> > > > > > device. If not provided, a default id will be set.
> > > > > >      - 'parent-role': Parent instance IAM role ARN, reflected i=
n PCR3
> > > > > > of the NSM device.
> > > > > >      - 'parent-id': Parent instance identifier, reflected in PC=
R4 of the
> > > > > > NSM device.
> > > > > >
> > > > > > Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> > > > > > ---
> > > > > >   crypto/meson.build              |   2 +-
> > > > > >   crypto/x509-utils.c             |  73 +++++++++++
> > > > >
> > > > >
> > > > > Can you please put this new API into its own patch file?
> > > > >
> > > > >
> > > > > >   hw/core/eif.c                   | 225 +++++++++++++++++++++++=
++++++---
> > > > > >   hw/core/eif.h                   |   5 +-
> > > > >
> > > > >
> > > > > These changes to eif.c should ideally already be part of the patc=
h that
> > > > > introduces eif.c (patch 1), no? In fact, do you think you can mak=
e the
> > > > > whole eif logic its own patch file?
> > > > >
> > > > >
> > > > > >   hw/core/meson.build             |   4 +-
> > > > > >   hw/i386/Kconfig                 |   1 +
> > > > > >   hw/i386/nitro_enclave.c         | 141 +++++++++++++++++++-
> > > > > >   include/crypto/x509-utils.h     |  22 ++++
> > > > > >   include/hw/i386/nitro_enclave.h |  26 ++++
> > > > > >   9 files changed, 479 insertions(+), 20 deletions(-)
> > > > > >   create mode 100644 crypto/x509-utils.c
> > > > > >   create mode 100644 include/crypto/x509-utils.h
> > > > > >
> > > > > > diff --git a/crypto/meson.build b/crypto/meson.build
> > > > > > index c46f9c22a7..09633194ed 100644
> > > > > > --- a/crypto/meson.build
> > > > > > +++ b/crypto/meson.build
> > > > > > @@ -62,7 +62,7 @@ endif
> > > > > >   if gcrypt.found()
> > > > > >     util_ss.add(gcrypt, files('random-gcrypt.c'))
> > > > > >   elif gnutls.found()
> > > > > > -  util_ss.add(gnutls, files('random-gnutls.c'))
> > > > > > +  util_ss.add(gnutls, files('random-gnutls.c', 'x509-utils.c')=
)
> > > > >
> > > > >
> > > > > What if we don't have gnutls. Will everything still compile or do=
 we
> > > > > need to add any dependencies?
> > > > >
> > > > >
> > > >
> > > > [...]
> > > >
> > > > > >
> > > > > > diff --git a/hw/core/meson.build b/hw/core/meson.build
> > > > > > index f32d1ad943..8dc4552e35 100644
> > > > > > --- a/hw/core/meson.build
> > > > > > +++ b/hw/core/meson.build
> > > > > > @@ -12,6 +12,8 @@ hwcore_ss.add(files(
> > > > > >     'qdev-clock.c',
> > > > > >   ))
> > > > > >
> > > > > > +libcbor =3D dependency('libcbor', version: '>=3D0.7.0')
> > > > > > +
> > > > > >   common_ss.add(files('cpu-common.c'))
> > > > > >   common_ss.add(files('machine-smp.c'))
> > > > > >   system_ss.add(when: 'CONFIG_FITLOADER', if_true: files('loade=
r-fit.c'))
> > > > > > @@ -24,7 +26,7 @@ system_ss.add(when: 'CONFIG_REGISTER', if_tru=
e: files('register.c'))
> > > > > >   system_ss.add(when: 'CONFIG_SPLIT_IRQ', if_true: files('split=
-irq.c'))
> > > > > >   system_ss.add(when: 'CONFIG_XILINX_AXI', if_true: files('stre=
am.c'))
> > > > > >   system_ss.add(when: 'CONFIG_PLATFORM_BUS', if_true: files('sy=
sbus-fdt.c'))
> > > > > > -system_ss.add(when: 'CONFIG_NITRO_ENCLAVE', if_true: [files('e=
if.c'), zlib])
> > > > > > +system_ss.add(when: 'CONFIG_NITRO_ENCLAVE', if_true: [files('e=
if.c'), zlib, libcbor, gnutls])
> > > > >
> > > > >
> > > > > Ah, you add the gnutls dependency here. Great! However, this mean=
s we
> > > > > now make gnutls (and libcbor) a mandatory dependency for the defa=
ult
> > > > > configuration. Does configure know about that? I believe before g=
nutls
> > > > > was optional, right?
> > > > >
> > > >
> > > > I see gnutls is not a required dependency in the root meson.build. =
I
> > > > am not sure what we should do here.
> > > >
> > > > Hey Daniel, do you have any suggestions about how this dependency
> > > > should be included?
> > >
> > > Unconditionally build the crypto/x509-utils.c file, but in that put
> > > file #ifdef CONFIG_GNUTLS, and in the #else put a stub impl of the
> > > method that just calls error_setg().
> > >
> > > That way you can compile everything without any hard dep on gnutls,
> > > but if someone tries to use it they'll get a runtime error when
> > > gnutls is not built
> > >
> >
> > Understood. Thanks! What should I do about libcbor? That one is
> > required for building nitro-enclave and virtio-nsm. Should I make that
> > required in the root meson.build file?
>
> No, we can't introduce new mandatory dependancies for a such a niche
> use case.
>
> In retrospect, I think you'll need to conditionalize meson.build to
> avoid building any of the nitro-enclave & virtio-nsm code, when
> either gnutls or cbor are missing.
>

Got it. I will look into making the build conditional. Thank you!

Regards,
Dorjoy

