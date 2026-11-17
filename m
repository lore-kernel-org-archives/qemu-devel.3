Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE87C606A32C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 18:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IF26q7PO;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=tSy5NeQj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTNTB-0007Vz-0w; Tue, 17 Nov 2026 12:59:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xTNT7-0007Vg-1g
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 12:59:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xTNT4-0004Rz-Sd
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 12:59:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794938381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vl1CxJaY+02I5u3HjSWg7CDXN1GxJ7x1NMxc1BTQwm0=;
 b=IF26q7POpYKm5uiHrwb5bfX7pW/PqftymPpJ4gEJJlnqnMC4ZEmhneXMjIkigcrBwZFYdZ
 17heg/ywjqnh2nQGSbfGg1W0cohM9yOQ+siD7J30HQkc1tHnyMAvIKIEleq3j74aECQau9
 o3TgBCxUqIYxBgTT5OLUlWpTbuuYtDg=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-ma9TrIkbN7e7kYvGzdsKpQ-1; Tue, 17 Nov 2026 12:59:37 -0500
X-MC-Unique: ma9TrIkbN7e7kYvGzdsKpQ-1
X-Mimecast-MFC-AGG-ID: ma9TrIkbN7e7kYvGzdsKpQ_1794938376
Received: by mail-yx1-f72.google.com with SMTP id
 956f58d0204a3-67dbb53a803so4158178d50.0
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 09:59:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794938376; cv=none;
 d=google.com; s=arc-20260327;
 b=d7AIKDJPlMx+T0mPnpqcbz4IVX3bYWLgDshYJZMzZQBz6y3iEvt6gqEoKVCgOiLGG7
 Bv0RQYjPMT8TumxAlItAFOwD/np/GMKVlckaXhrzfbzUJInd0BFKtYxwUp79Qg9jL00C
 SEqQ7hDjFTk+nAX0YsVeqICy92ZDa85Y8Z/U5JrGziB/YA/A545HGXnqGi5+G7nHv7RY
 q4zYDkQgPGJ+jwccFoJJSGrONfn8Bw7b/8CGFb0ClOnUU1Gsfs52w8hm1M8Rrf/1yHj2
 MDC5JkM74T/3jlwhEdrBsgLgJHixSfiomQ2HVbTNm9wgp0pjOk4BbR4d2zagJIkObem4
 KZ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vl1CxJaY+02I5u3HjSWg7CDXN1GxJ7x1NMxc1BTQwm0=;
 fh=aM8heEw08rewKoAzVI8T3Lmgm/CRSAFyugkfKMMnfg8=;
 b=W3dd+5qgof7qBG0Dg5SkFhE4vtwG6e4cE2tIQk8qo7hULaaKDa/95LNz4wdZD6OQgq
 8ISfAXHy8pkGhJnWamRFMq98Sqtu1cJm7mKwWKMbE3oCuc4iWSIS9vT5mKo3XcOpG+AK
 kLB5vALUVc6t4mW2nXvhxeUBPxFjD4I1OB3TKZ8a28XPk9poGVDjo+YPpPPJwc+o21qP
 xYlr0Xz0OXHLN2HzQDTEOk3jZi1Tm17iX9kvm66GCeh5buNy9b8MD8rIxmRzkPI8PcDL
 UoLBl/StLNL5mF+1PD44UTphhixZ1+gS2xgCVFXfeuswZxEexrHYJe3RthbOFjlkdPV5
 fSSA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794938376; x=1795543176; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vl1CxJaY+02I5u3HjSWg7CDXN1GxJ7x1NMxc1BTQwm0=;
 b=tSy5NeQjKOAH0/9y0pU5aIuhyDvrQyGvouELOKNNpLId2xzawi3T5++29YMqeueRhV
 zg0jXXyGQI3RJ5RjOAh2JDMLuI7EQ7DvtEQKAy7hfWJmwv3jujWCOC4sCLY0S52jsNWi
 6E4OkQSmKwJtv1mP4sYsBLyZ7XE5u1RNnptyYPxhE49piM2gSfQm7Wqk+la81f3v09K0
 TTLHNRKWvkX5Bax0JWBczU+oVnvqQrDmt8qo+EW4hEYaP4qOKJ/gn25QnACo3/Yn4lV5
 0NZef6uXvA+nrc0sq73fpTLXA90QSh/Q3SA2HFzV3diRHrDJZn48U45OXB3lTi+zYLLO
 GZ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794938376; x=1795543176;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vl1CxJaY+02I5u3HjSWg7CDXN1GxJ7x1NMxc1BTQwm0=;
 b=Jir1pEzlJrzPF7iFwi5XROfn7GivgX6xcajjHpZqrfC5CyEFZG3oLytoQnRcwZQvR5
 ej+NNMJa2j/4xBwkmJjsSrz0m9KPayFN+5Er7hYewUh0N5YFniwYNuQPnquNMdz3rKcL
 xl/e2WpNOd2iwe+WjPmySYyVwTc/1rNxgIBAYJWsmmWKFWoR8LaReubvPOiBVBY36rA1
 EsntAehBWSMV8W+ngz73bAecOMmFViKu7XBtFpCbrmEezvU+JOxdxJBLG6rG9jGpOoZj
 m2GUERKGSgZApjg7KrbkLbHQh4/rSRyDim/HJzoBKo/ZC4SxNCkKyyVzxlbcWz2la5Tg
 aJ9g==
X-Gm-Message-State: APuU4Z8Zj1PKCBdkq/thsVPlEJM6GGnif0Rz5B7vEevzxKHuVfRzkuB1
 fN3mcFQOfYJYyiN4z1Fwn8irM+a+IsAsYQCKXypmy8sigXhcl9ez1xaLEdolTjl1B0vRigSbAxE
 IutmntOFcpVVvOYr/HSuk9zdVy3BeEnThPx8VOoCapPD3H+L1O91PW8aVQRM5QMpjDJLWg4xTJ3
 JBJOLCkt5Z6o01yo7YvzquTWzQTX1pKvA=
X-Gm-Gg: AZFdTZcYFltG188Xxl7JEga5RRN6WPeFGycUKvpZqncXWhIAPkA0mdo24izMO7C9QKA
 DphpqJetqSU8CmOSgxqIuWF/ClQrvHkfZjPYBb5Dnv/fpXQq59QBEibhoDsN3DAi/5Ah1WIBgUN
 pWsEjXpCEWKlrf4n3qmY8q9Bp557AD/4pNRt5G6XDtQ5USn6jhuZCqxDbW+iIMeBK0KooBVB1XN
 btk9tX/AQ0fdWMi
X-Received: by 2002:a05:690e:4182:b0:67c:1ebe:3844 with SMTP id
 956f58d0204a3-67dd3cf9c28mr212005d50.2.1794938376429; 
 Tue, 17 Nov 2026 09:59:36 -0800 (PST)
X-Received: by 2002:a05:690e:4182:b0:67c:1ebe:3844 with SMTP id
 956f58d0204a3-67dd3cf9c28mr211982d50.2.1794938375902; Tue, 17 Nov 2026
 09:59:35 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261116165002.30939-1-jsnow@redhat.com>
 <20261116165002.30939-2-jsnow@redhat.com>
 <avxZFbMNjEmnY2yK@redhat.com>
In-Reply-To: <avxZFbMNjEmnY2yK@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 17 Nov 2026 12:59:23 -0500
X-Gm-Features: AclHuK_DtNwb7PXUej_MF5pzE6TrIDPiVJKRVs4ZeA6ganrEwOTaTfhsBtGAuDk
Message-ID: <CAFn=p-Z+LoTqzLAirksuHjt8fghkjWOyvMZ=YJdUFQftHdiA3A@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] debug/mem: add utility to name anonymous memory
 mappings
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 kvm@vger.kernel.org, Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Fabiano Rosas <farosas@suse.de>, Alistair Francis <alistair.francis@wdc.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Stefan Weil <sw@weilnetz.de>, 
 Peter Xu <peterx@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Marcelo Tosatti <mtosatti@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17, 2026 at 8:39=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Mon, Nov 16, 2026 at 11:49:56AM -0500, John Snow wrote:
> > Add support to name mmap'd memory regions using
> > PR_SET_VMA_ANON_NAME. On unsupported platforms, these QEMU utility
> > functions are no-ops.
> >
> > This is useful primarily for debugging and profiling QEMU; being able
> > to see and correlate each VMA segment with a specific use within QEMU.
> >
> > Support for PR_SET_VMA_ANON_NAME was added in Linux 5.17, and requires
> > CONFIG_ANON_VMA_NAME=3Dy to be set in the kernel configuration. Fedora
> > (and RHEL) do not enable this feature by default. See also
> > https://man7.org/linux/man-pages/man2/pr_set_vma.2const.html
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  include/qemu/mmap-vma.h | 18 +++++++++++
> >  util/mmap-vma.c         | 71 +++++++++++++++++++++++++++++++++++++++++
> >  util/meson.build        |  1 +
> >  3 files changed, 90 insertions(+)
> >  create mode 100644 include/qemu/mmap-vma.h
> >  create mode 100644 util/mmap-vma.c
> >
> > diff --git a/include/qemu/mmap-vma.h b/include/qemu/mmap-vma.h
> > new file mode 100644
> > index 00000000000..763ea5a5cab
> > --- /dev/null
> > +++ b/include/qemu/mmap-vma.h
> > @@ -0,0 +1,18 @@
> > +/*
> > + * Utility for naming VMA allocations in linux
> > + *
> > + * Copyright (c) Red Hat, Inc 2026
> > + *
> > + * SPDX-License-Identifier: LGPL-2.1-or-later
> > + */
> > +
> > +#ifndef __QEMU_MMAP_VMA_H
> > +#define __QEMU_MMAP_VMA_H
> > +
> > +#include <stddef.h>
> > +#include "osdep.h"
> > +
> > +int qemu_name_vma(void *ptr, size_t sz, const char *fmt, ...)
> > +    G_GNUC_PRINTF(3, 4);
> > +
> > +#endif
> > diff --git a/util/mmap-vma.c b/util/mmap-vma.c
> > new file mode 100644
> > index 00000000000..7a50965d496
> > --- /dev/null
> > +++ b/util/mmap-vma.c
> > @@ -0,0 +1,71 @@
> > +/*
> > + * Utility for naming VMA allocations in linux
> > + *
> > + * Copyright (c) Red Hat, Inc 2026
> > + *
> > + * SPDX-License-Identifier: LGPL-2.1-or-later
> > + */
> > +#include "qemu/mmap-vma.h"
> > +#include "qemu/osdep.h"
> > +
> > +#include <errno.h>
> > +#include <stddef.h>
> > +#include <stdio.h>
> > +
> > +#if defined(__linux__)
> > +#include <sys/prctl.h>
> > +#endif
> > +
> > +#define VMA_PREFIX " qemu: "
> > +#define VMA_MAXLEN 80
> > +
> > +/*
> > + * Give a human-readable name to a previously mmap'd memory segment.
> > + * This feature is only available on Linux >=3D 5.17, and only when th=
e
> > + * kernel was configured with CONFIG_ANON_VMA_NAME=3Dy.
> > + *
> > + * For systems without this option, prctl() will return -1 and set
> > + * errno to EINVAL, and can be safely ignored.
> > + *
> > + * For systems with this option, these human-readable names will be
> > + * visible in /proc/$pid/[s]maps, pmap output, etc.
> > + */
> > +G_GNUC_PRINTF(3, 0)
> > +static int qemu_vname_vma(void *ptr, size_t sz, const char *fmt, va_li=
st args)
>
> As the comment says above, we can't assume the kernel will have
> the feature enabled.
>
> It is harmless if we try to set the VMA name and it fails
> though. We merely loose a bit of debug info. Thus I'd
> suggest we make the function return type 'void', so that
> it is clear that we do NOT expect callers to check for
> errors.

You're probably right, I think I was holding out for the possibility
of callers being able to check if they got the memory region
boundaries correct (in the case of naming ptmalloc buffers), but....
with the amount of extra work it'd take to make a robust system for
identifying actual mmap regions possible, it'd be just as easy to add
a simple int retcode back in, so... void for now it is, sure.

--js

>
> > +{
> > +    int rc =3D 0;
> > +
> > +#if defined(PR_SET_VMA_ANON_NAME)
> > +    char strbuf[VMA_MAXLEN];
> > +
> > +    assert(sizeof(VMA_PREFIX) < sizeof(strbuf));
> > +    strncpy(strbuf, VMA_PREFIX, sizeof(strbuf));
> > +    rc =3D vsnprintf(strbuf + sizeof(VMA_PREFIX),
> > +                   sizeof(strbuf) - sizeof(VMA_PREFIX), fmt, args);
> > +    if (rc < 0) {
> > +        return -errno;
> > +    } else if (rc >=3D (sizeof(strbuf) - sizeof(VMA_PREFIX))) {
> > +        sprintf(strbuf + sizeof(strbuf) - 4, "...");
> > +    }
> > +
> > +    rc =3D prctl(PR_SET_VMA, PR_SET_VMA_ANON_NAME, ptr, sz, strbuf);
> > +    if (rc) {
> > +        return -errno;
> > +    }
> > +#endif
> > +
> > +    return rc;
> > +}
> > +
> > +G_GNUC_PRINTF(3, 4)
> > +int qemu_name_vma(void *ptr, size_t sz, const char *fmt, ...)
> > +{
> > +    int rc;
> > +    va_list args;
> > +
> > +    va_start(args, fmt);
> > +    rc =3D qemu_vname_vma(ptr, sz, fmt, args);
> > +    va_end(args);
> > +
> > +    return rc;
> > +}
> > diff --git a/util/meson.build b/util/meson.build
> > index fa174c07a57..861ee228d5b 100644
> > --- a/util/meson.build
> > +++ b/util/meson.build
> > @@ -1,5 +1,6 @@
> >  util_ss.add(files('osdep.c', 'cutils.c', 'unicode.c', 'qemu-timer-comm=
on.c'))
> >  util_ss.add(files('thread-context.c'), numa)
> > +util_ss.add(files('mmap-vma.c'))
> >  if host_os !=3D 'windows'
> >    util_ss.add(files('aio-posix.c'))
> >    util_ss.add(files('fdmon-poll.c'))
> > --
> > 2.56.1
> >
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>


