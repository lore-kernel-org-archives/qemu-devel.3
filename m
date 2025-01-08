Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD3DE77199
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 11:55:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVUdH-0006QI-J4; Wed, 08 Jan 2025 06:53:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1tVUd4-0006P5-3x
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 06:53:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1tVUcz-0002Co-9T
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 06:53:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736337215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F+bRpI0Nnd7m9f+43X09eoGNgD74tibaLdM9mSkRRow=;
 b=iKJStP5BSwRlPMOaf6Ey0xnMhOAdZyWxW9xR5i+DuwtOu/iWT/hfXpUmF8/pi6LmQDxKiw
 5juUlGBkmQNONlC2tkcvT1JqdUp6aIwIE+PYiD4qS84eebbc814w6G0Zp1nGPzEgjN5b7m
 z6OR/uL1C3+9FVk5NGbn3v/NaN/59Wc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-IJ8gKq08OVSSJbQ9e_ADtQ-1; Wed, 08 Jan 2025 06:53:33 -0500
X-MC-Unique: IJ8gKq08OVSSJbQ9e_ADtQ-1
X-Mimecast-MFC-AGG-ID: IJ8gKq08OVSSJbQ9e_ADtQ
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6d88c987fc7so280082486d6.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 03:53:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736337213; x=1736942013;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F+bRpI0Nnd7m9f+43X09eoGNgD74tibaLdM9mSkRRow=;
 b=reQkk9EmMpUhbMADED+Etso6D9cmp5dT8yc+RAvT9jWNQHPqGhHIcqvyAg8B22f2za
 J0g4IzUccouolE6X0/20D7URGpRAVuQgOvevtq+EwadTOIDyD0ex2NQ7O0BWMwS84yHF
 TutgVU8b6SWCWe44EuJB4S2mflMhZmYJKXtl1IBQ63OujvQEKowOlqkJuSSEIGz5md/C
 O9yhCsU7Dix2MWKczOclcFwykHgh1lIi3tYyAoX+vwXEN2wf/aH9Je1auviMb6hTJfBq
 LUkFAe1e/rkZ3RI3zrtCnErhfF18LuPaTMiwT5zTLEYkbuSHe5nFIsn015lRcbr3VrE1
 GBGQ==
X-Gm-Message-State: AOJu0YwdOcML0zGF3pK9cAy/6l9cbIlF2Rcq2Coj9Js5NY87eQweUmIH
 RF07MruLRaskd/PLh2CiFqxQO+YQfCiMMlXY3STiaVIOOGG1NOF/yifi2V1yBoA3Bp0nX1TH/cR
 CsPvPIbr+Bt+QDoLWu2CR6jTRbIGQDIZAP7wxO8wSrOp9TEZ/7MnmUijsdorsd1IwEiWbYxx1vz
 yUcLY1uzpqkC2fv+JzQ+d/KjU+vF4=
X-Gm-Gg: ASbGncvzzj/hJdnndudc4o2GkRHsHeX+LJC/zlBzVeVqPvb09DFFrSg66hPXeihSKKZ
 C4XqclEpWpFOEk0uP4+akfZG6gMux0FYQgsYe
X-Received: by 2002:a05:6214:4303:b0:6d8:88cf:e690 with SMTP id
 6a1803df08f44-6df9b1b4ea6mr41342146d6.3.1736337213253; 
 Wed, 08 Jan 2025 03:53:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGANfu7AaG9GNtlwOsDjtfzyxKcVi1tRNYxiEOMTzn9vGRaOElyBR9m/8WfrlP6bz/bObeZSSnW/GSi4Gw7SL0=
X-Received: by 2002:a05:6214:4303:b0:6d8:88cf:e690 with SMTP id
 6a1803df08f44-6df9b1b4ea6mr41341946d6.3.1736337212947; Wed, 08 Jan 2025
 03:53:32 -0800 (PST)
MIME-Version: 1.0
References: <20250107153353.1144978-1-kraxel@redhat.com>
In-Reply-To: <20250107153353.1144978-1-kraxel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 8 Jan 2025 15:53:21 +0400
X-Gm-Features: AbW1kva58vlI7scgAdLr0660Co8G94i65sjLhDKV0nllJ1pqeH1_4cvGORHyH8c
Message-ID: <CAMxuvazrd+3v2qqO-5o3qpky-ULRTwvU48jkwdxMPZG5c1RA1A@mail.gmail.com>
Subject: Re: [PATCH v2 00/21] hw/uefi: add uefi variable service
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, graf@amazon.com, 
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Eric Blake <eblake@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Jan 7, 2025 at 7:34=E2=80=AFPM Gerd Hoffmann <kraxel@redhat.com> wr=
ote:
>
> This patch adds a virtual device to qemu which the uefi firmware can use
> to store variables.  This moves the UEFI variable management from
> privileged guest code (managing vars in pflash) to the host.  Main
> advantage is that the need to have privilege separation in the guest
> goes away.
>
> On x86 privileged guest code runs in SMM.  It's supported by kvm, but
> not liked much by various stakeholders in cloud space due to the
> complexity SMM emulation brings.
>
> On arm privileged guest code runs in el3 (aka secure world).  This is
> not supported by kvm, which is unlikely to change anytime soon given
> that even el2 support (nested virt) is being worked on for years and is
> not yet in mainline.
>
> The design idea is to reuse the request serialization protocol edk2 uses

I suppose this is a stable protocol. (some parts are set by the UEFI
spec probably)

There doesn't seem to be a defined way to query either side version or
capability, I suppose this could be added later assuming an initial
behaviour/magic etc.

> for communication between SMM and non-SMM code, so large chunks of the
> edk2 variable driver stack can be used unmodified.  Only the driver
> which traps into SMM mode must be replaced by a driver which talks to
> qemu instead.
>
> A edk2 test branch can be found here (build with "-D QEMU_VARS=3DTRUE").
> https://github.com/kraxel/edk2/commits/devel/secure-boot-external-vars
>

ok, perhaps it would be nice to have some basic unit tests in qemu
too. Almost none of this new code is exercised by the qemu tests yet.

> The uefi-vars device re-implements the privileged edk2 protocols
> (i.e. the code running in SMM mode).

Typically the kind of new code that I wish would be in Rust. But I
suppose it is too early yet, and you came to the same conclusion.
Probably a good candidate for rewrite though!

>
> v2 changes:
>  - fully implement authenticated variables.
>  - various cleanups and fixes.
>
> enjoy & take care,
>   Gerd
>
> Gerd Hoffmann (21):
>   hw/uefi: add include/hw/uefi/var-service-api.h
>   hw/uefi: add include/hw/uefi/var-service-edk2.h
>   hw/uefi: add include/hw/uefi/var-service.h
>   hw/uefi: add var-service-guid.c
>   hw/uefi: add var-service-utils.c
>   hw/uefi: add var-service-vars.c
>   hw/uefi: add var-service-auth.c
>   hw/uefi: add var-service-policy.c
>   hw/uefi: add var-service-core.c
>   hw/uefi: add var-service-pkcs7.c
>   hw/uefi: add var-service-pkcs7-stub.c
>   hw/uefi: add var-service-siglist.c
>   hw/uefi: add var-service-json.c + qapi for NV vars.
>   hw/uefi: add trace-events
>   hw/uefi: add UEFI_VARS to Kconfig
>   hw/uefi: add to meson
>   hw/uefi: add uefi-vars-sysbus device
>   hw/uefi: add uefi-vars-isa device
>   hw/arm: add uefi variable support to virt machine type
>   docs: add uefi variable service documentation
>   hw/uefi: add MAINTAINERS entry
>
>  include/hw/arm/virt.h              |   2 +
>  include/hw/uefi/var-service-api.h  |  40 ++
>  include/hw/uefi/var-service-edk2.h | 227 +++++++++
>  include/hw/uefi/var-service.h      | 186 ++++++++
>  hw/arm/virt.c                      |  41 ++
>  hw/uefi/var-service-auth.c         | 361 ++++++++++++++
>  hw/uefi/var-service-core.c         | 237 ++++++++++
>  hw/uefi/var-service-guid.c         |  99 ++++
>  hw/uefi/var-service-isa.c          |  91 ++++
>  hw/uefi/var-service-json.c         | 242 ++++++++++
>  hw/uefi/var-service-pkcs7-stub.c   |  16 +
>  hw/uefi/var-service-pkcs7.c        | 436 +++++++++++++++++
>  hw/uefi/var-service-policy.c       | 370 +++++++++++++++
>  hw/uefi/var-service-siglist.c      | 212 +++++++++
>  hw/uefi/var-service-sysbus.c       |  90 ++++
>  hw/uefi/var-service-utils.c        | 241 ++++++++++
>  hw/uefi/var-service-vars.c         | 725 +++++++++++++++++++++++++++++
>  MAINTAINERS                        |   6 +
>  docs/devel/index-internals.rst     |   1 +
>  docs/devel/uefi-vars.rst           |  66 +++
>  hw/Kconfig                         |   1 +
>  hw/meson.build                     |   1 +
>  hw/uefi/Kconfig                    |   9 +
>  hw/uefi/LIMITATIONS.md             |   7 +
>  hw/uefi/meson.build                |  24 +
>  hw/uefi/trace-events               |  17 +
>  meson.build                        |   1 +
>  qapi/meson.build                   |   1 +
>  qapi/qapi-schema.json              |   1 +
>  qapi/uefi.json                     |  45 ++
>  30 files changed, 3796 insertions(+)
>  create mode 100644 include/hw/uefi/var-service-api.h
>  create mode 100644 include/hw/uefi/var-service-edk2.h
>  create mode 100644 include/hw/uefi/var-service.h
>  create mode 100644 hw/uefi/var-service-auth.c
>  create mode 100644 hw/uefi/var-service-core.c
>  create mode 100644 hw/uefi/var-service-guid.c
>  create mode 100644 hw/uefi/var-service-isa.c
>  create mode 100644 hw/uefi/var-service-json.c
>  create mode 100644 hw/uefi/var-service-pkcs7-stub.c
>  create mode 100644 hw/uefi/var-service-pkcs7.c
>  create mode 100644 hw/uefi/var-service-policy.c
>  create mode 100644 hw/uefi/var-service-siglist.c
>  create mode 100644 hw/uefi/var-service-sysbus.c
>  create mode 100644 hw/uefi/var-service-utils.c
>  create mode 100644 hw/uefi/var-service-vars.c
>  create mode 100644 docs/devel/uefi-vars.rst
>  create mode 100644 hw/uefi/Kconfig
>  create mode 100644 hw/uefi/LIMITATIONS.md
>  create mode 100644 hw/uefi/meson.build
>  create mode 100644 hw/uefi/trace-events
>  create mode 100644 qapi/uefi.json
>
> --
> 2.47.1
>


