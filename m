Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0473EC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 15:33:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sg4NX-0000mT-3h; Mon, 19 Aug 2024 11:33:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1sg4NV-0000ko-Kw
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 11:33:05 -0400
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1sg4NU-0002Qa-0I
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 11:33:05 -0400
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5da6865312eso3056116eaf.3
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 08:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724081582; x=1724686382; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J6vJFmQF93SsLF/G3lx3rTzWRy3T6+zAGHPX0bVIurE=;
 b=UAEhZSGtFiJMHlwLF6J76cOjzM3Hjoiux/nmM5f3hYKM+HWcdI4kgQmPKJZZTapc2Z
 sJ7kwgDWowuEYcmrYjHcmrdqa+qMUwd945oV/sKOrCa3b4P1ktN746fIw6Idlg2qo8iT
 MnPHDyy3pVyCqNhe95T0ejOlLbak2drcrE2cAu+dY16huObioHMelLmte78HV2B29Ht/
 nsZ13HbJ1wuRkcJajkC/ulpJCjfanuodHeek8T9Wjab+HvZnjioKmAVNJnSa0lgl4Yl/
 E0mRLUXOu3i+NNz2S/bBAnnEdnuW6XjXre4KFz0He9Y6kH5kw0EfEVTho1IbK8n8K8+Z
 TQbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724081582; x=1724686382;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J6vJFmQF93SsLF/G3lx3rTzWRy3T6+zAGHPX0bVIurE=;
 b=KBQ/ylkB0KhR42wKeIvyFeDdimig2mAAl+kh+xrsmfvjPq+xC/gMGOSAVAwQBsBscr
 XlBj849TpTrUapbonRBL340iV66e62YwL7I1aeSWtdmMxxBD4EWowO9Ay/7Vhy1uv76i
 dZI2I9eyLXpSfkJ/3UChR+uA7HZbHJzAmuud567f4yGJvY/eSXkB6rui6R62o6i0zwQZ
 C1hngUoSCQ4KYXGMOMaXZt/IzG5UMd7bZV+l+5YIc6wkBy/w4ZkNwlqmJY2ULt0pGR2s
 FQw17OYO6cXBXS5h3jJp/xLtin16AKBCurRaYj9YUko0txyi6Qc8slHoIsWxvigQUAeI
 iItQ==
X-Gm-Message-State: AOJu0YxTFvvCohUj2Fb/tpkRkQDR3Ag1fYSaK3lU9LVIOM3hJI2g01Cs
 Qik3ajPYU/3grSm2nTZVpUKEv+aYxAA6oo9PxlgJdJAAqgIPXT7goP4p6mJnBoP1mwWAIO7iizJ
 +6zRGXjZpWJdCZ38bbjCsHrFLZlk=
X-Google-Smtp-Source: AGHT+IF2bZzTLdoPaGyrPF/haNWpEnJuIGfh7V1uQwXk0p2jV3zdcyxjTmsLCCOulrIs9mOVkV1v9lrJyNoOzFygo/Y=
X-Received: by 2002:a05:6358:7e9b:b0:1ac:660a:8a69 with SMTP id
 e5c5f4694b2df-1b3931c3412mr1594170055d.18.1724081582333; Mon, 19 Aug 2024
 08:33:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240818114257.21456-1-dorjoychy111@gmail.com>
 <20240818114257.21456-5-dorjoychy111@gmail.com>
 <bffedf65-6046-4264-a2fe-011ff8c58860@amazon.com>
In-Reply-To: <bffedf65-6046-4264-a2fe-011ff8c58860@amazon.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Mon, 19 Aug 2024 21:32:55 +0600
Message-ID: <CAFfO_h7+FEzp-FrYM68A104CyNKgUfEReB+o9gYg5i-f=5DsVg@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] machine/nitro-enclave: Add built-in Nitro Secure
 Module device
To: Alexander Graf <graf@amazon.com>, berrange@redhat.com
Cc: qemu-devel@nongnu.org, agraf@csgraf.de, stefanha@redhat.com, 
 pbonzini@redhat.com, slp@redhat.com, richard.henderson@linaro.org, 
 eduardo@habkost.net, mst@redhat.com, marcel.apfelbaum@gmail.com, 
 philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=dorjoychy111@gmail.com; helo=mail-oo1-xc34.google.com
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

On Mon, Aug 19, 2024 at 4:13=E2=80=AFPM Alexander Graf <graf@amazon.com> wr=
ote:
>
> Hey Dorjoy,
>
> On 18.08.24 13:42, Dorjoy Chowdhury wrote:
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
> >      - 'id': Enclave identifier, reflected in the module-id of the NSM
> > device. If not provided, a default id will be set.
> >      - 'parent-role': Parent instance IAM role ARN, reflected in PCR3
> > of the NSM device.
> >      - 'parent-id': Parent instance identifier, reflected in PCR4 of th=
e
> > NSM device.
> >
> > Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> > ---
> >   crypto/meson.build              |   2 +-
> >   crypto/x509-utils.c             |  73 +++++++++++
>
>
> Can you please put this new API into its own patch file?
>
>
> >   hw/core/eif.c                   | 225 +++++++++++++++++++++++++++++--=
-
> >   hw/core/eif.h                   |   5 +-
>
>
> These changes to eif.c should ideally already be part of the patch that
> introduces eif.c (patch 1), no? In fact, do you think you can make the
> whole eif logic its own patch file?
>
>
> >   hw/core/meson.build             |   4 +-
> >   hw/i386/Kconfig                 |   1 +
> >   hw/i386/nitro_enclave.c         | 141 +++++++++++++++++++-
> >   include/crypto/x509-utils.h     |  22 ++++
> >   include/hw/i386/nitro_enclave.h |  26 ++++
> >   9 files changed, 479 insertions(+), 20 deletions(-)
> >   create mode 100644 crypto/x509-utils.c
> >   create mode 100644 include/crypto/x509-utils.h
> >
> > diff --git a/crypto/meson.build b/crypto/meson.build
> > index c46f9c22a7..09633194ed 100644
> > --- a/crypto/meson.build
> > +++ b/crypto/meson.build
> > @@ -62,7 +62,7 @@ endif
> >   if gcrypt.found()
> >     util_ss.add(gcrypt, files('random-gcrypt.c'))
> >   elif gnutls.found()
> > -  util_ss.add(gnutls, files('random-gnutls.c'))
> > +  util_ss.add(gnutls, files('random-gnutls.c', 'x509-utils.c'))
>
>
> What if we don't have gnutls. Will everything still compile or do we
> need to add any dependencies?
>
>

[...]

> >
> > diff --git a/hw/core/meson.build b/hw/core/meson.build
> > index f32d1ad943..8dc4552e35 100644
> > --- a/hw/core/meson.build
> > +++ b/hw/core/meson.build
> > @@ -12,6 +12,8 @@ hwcore_ss.add(files(
> >     'qdev-clock.c',
> >   ))
> >
> > +libcbor =3D dependency('libcbor', version: '>=3D0.7.0')
> > +
> >   common_ss.add(files('cpu-common.c'))
> >   common_ss.add(files('machine-smp.c'))
> >   system_ss.add(when: 'CONFIG_FITLOADER', if_true: files('loader-fit.c'=
))
> > @@ -24,7 +26,7 @@ system_ss.add(when: 'CONFIG_REGISTER', if_true: files=
('register.c'))
> >   system_ss.add(when: 'CONFIG_SPLIT_IRQ', if_true: files('split-irq.c')=
)
> >   system_ss.add(when: 'CONFIG_XILINX_AXI', if_true: files('stream.c'))
> >   system_ss.add(when: 'CONFIG_PLATFORM_BUS', if_true: files('sysbus-fdt=
.c'))
> > -system_ss.add(when: 'CONFIG_NITRO_ENCLAVE', if_true: [files('eif.c'), =
zlib])
> > +system_ss.add(when: 'CONFIG_NITRO_ENCLAVE', if_true: [files('eif.c'), =
zlib, libcbor, gnutls])
>
>
> Ah, you add the gnutls dependency here. Great! However, this means we
> now make gnutls (and libcbor) a mandatory dependency for the default
> configuration. Does configure know about that? I believe before gnutls
> was optional, right?
>

I see gnutls is not a required dependency in the root meson.build. I
am not sure what we should do here.

Hey Daniel, do you have any suggestions about how this dependency
should be included?

Regards,
Dorjoy

