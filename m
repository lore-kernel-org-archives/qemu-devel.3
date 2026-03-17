Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31113FF6E84
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 21:20:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2bp3-0007Z9-8Z; Tue, 17 Mar 2026 17:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net>)
 id 1w2bp1-0007Yz-3F
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 17:19:27 -0400
Received: from v54.v54282eed.euw1.send.eu.mailgun.net ([185.250.239.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net>)
 id 1w2boy-0003BR-E6
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 17:19:26 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=0x65c.net; q=dns/txt;
 s=email; t=1773782360; x=1773789560; 
 h=Content-Type: Cc: To: To: Subject: Subject: Message-ID: Date: From: From:
 In-Reply-To: References: MIME-Version: Sender: Sender; 
 bh=+wlItRaBzFwaqduHr3e/LtL3BP/T69zXHiKo/eVUi5A=;
 b=DqVN5A4QrODv6tDlrMl3fvchsXcceLrIWVi9N4JXj4SROvMPUeEwNV8nDWflhhHwZ+XPWw/C/NiOf6+wk6HWcDOoCSowrnbdJaxe6f80z7XcSET8IpliwHujaUY0cywX/gTuT5SVPLQdVrcvXAbN0hLbvdQh2NlHsLfYKBElVTkGMqRSGeX/Nagl2Oa0cxxI+tvA4Hxc5+ADUDYcYHLdP2Wur9Ei1qc5FfCUG81R11HSLJG/8sO4MIe+lbjzXom7Of7hJ+rloWJvZBI0n9TeGyqe0MeclwC6mh+iO6Mb/lts3P3dez2RxAbNXuscdpATwVYmab2qSxDiVLXJp3DDyQ==
X-Mailgun-Sid: WyJiNjdhNCIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjU0ZWY0Il0=
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com
 [74.125.224.45]) by
 e20bfc090bb31ff7852fd4f81817cc63ffbe02e140b4de1e9bc3a74ec7a08363 with SMTP id
 69b9c558ad2ee93738797e34 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Tue, 17 Mar 2026 21:19:20 GMT
X-Mailgun-Sending-Ip: 185.250.239.4
Received: by mail-yx1-f45.google.com with SMTP id
 956f58d0204a3-64e8cdafeffso532060d50.1
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 14:19:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCXjFJ8N8cd7qOwgmGnA7v8Nt8grvE1bBjb95dxdJh1rDuwjsyONbbD5N3KIEKbXoEzMmE9XHqVXj3aV@nongnu.org
X-Gm-Message-State: AOJu0YzhK1xlg+A1LNXlOeGrhcSjJew77b7oFRN29z50eh8i+cJ+I7g3
 mhW1W7e+q8GRHyUeqbzJ8XNpwrGM2rQW+LXjtsEbPLjmdyr3jsfpCKyrRrlG/w9BGbmRTLX+5+k
 bGA1cmUnb+4lGqHyqYoWJR17y914cQQ8=
X-Received: by 2002:a05:690e:419c:b0:64c:dd50:5138 with SMTP id
 956f58d0204a3-64e91358c6fmr1149666d50.18.1773782359837; Tue, 17 Mar 2026
 14:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260311215003.664815-1-alessandro@0x65c.net>
 <20260311215003.664815-2-alessandro@0x65c.net>
 <87ldfrlzqy.fsf@pond.sub.org>
In-Reply-To: <87ldfrlzqy.fsf@pond.sub.org>
From: Alessandro Ratti <alessandro@0x65c.net>
Date: Tue, 17 Mar 2026 22:19:08 +0100
X-Gmail-Original-Message-ID: <CAKiXHKc8HBOi+8R2N+B7OGNA8JSBxrgGF5WSNV_ybko2pcej5A@mail.gmail.com>
X-Gm-Features: AaiRm50FH8aSiQM2Pe53kLpJrqaGAjj4L-sV8YqQXefyr5h73hpWFvPt-3sZs1c
Message-ID: <CAKiXHKc8HBOi+8R2N+B7OGNA8JSBxrgGF5WSNV_ybko2pcej5A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] hw/qdev: Clarify fallback order in
 qdev_get_printable_name()
To: Markus Armbruster <armbru@redhat.com>
Cc: Alessandro Ratti <alessandro@0x65c.net>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, 
 berrange@redhat.com, mst@redhat.com, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=185.250.239.4;
 envelope-from=bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net;
 helo=v54.v54282eed.euw1.send.eu.mailgun.net
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_BL_SPAMCOP_NET=1.347,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 17 Mar 2026 at 07:46, Markus Armbruster <armbru@redhat.com> wrote:
>
> Alessandro Ratti <alessandro@0x65c.net> writes:
>
> > Replace the uninformative "<unknown device>" final fallback with the
> > canonical QOM path (e.g. /machine/peripheral-anon/device[0]).
> >
> > Also clean up comments to accurately describe qdev_get_dev_path()
> > behavior, drop an unnecessary comment on the dev->id check, rename
> > the @vdev parameter to @dev for consistency with surrounding code,
> > and add g_assert(dev) to match qdev_get_human_name()'s precondition.
> >
> > Update the doc comment in qdev.h to reflect the new fallback chain.
> >
> > Signed-off-by: Alessandro Ratti <alessandro@0x65c.net>
> > ---
> >  hw/core/qdev.c         | 29 ++++++++++++-----------------
> >  include/hw/core/qdev.h | 11 +++++------
> >  2 files changed, 17 insertions(+), 23 deletions(-)
> >
> > diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> > index e48616b2c6..f9fb7966dd 100644
> > --- a/hw/core/qdev.c
> > +++ b/hw/core/qdev.c
> > @@ -411,33 +411,28 @@ char *qdev_get_dev_path(DeviceState *dev)
> >      return NULL;
> >  }
> >
> > -const char *qdev_get_printable_name(DeviceState *vdev)
> > +const char *qdev_get_printable_name(DeviceState *dev)
> >  {
> > -    /*
> > -     * Return device ID if explicity set
> > -     * (e.g. -device virtio-blk-pci,id=foo)
> > -     * This allows users to correlate errors with their custom device
> > -     * names.
> > -     */
> > -    if (vdev->id) {
> > -        return g_strdup(vdev->id);
> > +    g_assert(dev != NULL);
>
> This replaces crash on dev->id below by an assertion failure.  I
> wouldn't bother.

I'll drop it.

>
> > +
> > +    if (dev->id) {
> > +        return g_strdup(dev->id);
> >      }
> > +
> >      /*
> > -     * Fall back to the canonical QOM device path (eg. ID for PCI
> > -     * devices).
> > -     * This ensures the device is still uniquely and meaningfully
> > -     * identified.
> > +     * Fall back to a bus-specific device path, if the bus
> > +     * provides one (e.g. PCI address "0000:00:04.0").
> >       */
> > -    const char *path = qdev_get_dev_path(vdev);
> > +    const char *path = qdev_get_dev_path(dev);
> >      if (path) {
> >          return path;
> >      }
> >
> >      /*
> > -     * Final fallback: if all else fails, return a placeholder string.
> > -     * This ensures the error message always contains a valid string.
> > +     * Final fallback: return the canonical QOM path
> > +     * (e.g. /machine/peripheral-anon/device[0]).
> >       */
>
> Is the comment useful?

Fair enough. I'll drop it.

> > -    return g_strdup("<unknown device>");
> > +    return object_get_canonical_path(OBJECT(dev));
> >  }
> >
> >  void qdev_add_unplug_blocker(DeviceState *dev, Error *reason)
> > diff --git a/include/hw/core/qdev.h b/include/hw/core/qdev.h
> > index f99a8979cc..2da7327144 100644
> > --- a/include/hw/core/qdev.h
> > +++ b/include/hw/core/qdev.h
> > @@ -1087,18 +1087,17 @@ char *qdev_get_dev_path(DeviceState *dev);
> >
> >  /**
> >   * qdev_get_printable_name: Return human readable name for device
> > - * @dev: Device to get name of
> > + * @dev: Device to get name of. Must not be NULL.
> >   *
> >   * Returns: A newly allocated string containing some human
> >   * readable name for the device, suitable for printing in
> > - * user-facing error messages. The function will never return NULL,
> > - * so the name can be used without further checking or fallbacks.
> > + * user-facing error messages.
> >   *
> >   * If the device has an explicitly set ID (e.g. by the user on the
> >   * command line via "-device thisdev,id=myid") this is preferred.
> > - * Otherwise we try the canonical QOM device path (which will be
> > - * the PCI ID for PCI devices, for example). If all else fails
> > - * we will return the placeholder "<unknown device">.
> > + * Otherwise we try the bus-specific device path (which will be
> > + * the PCI address for PCI devices, for example). If all else fails
> > + * we return the canonical QOM path.
>
> I prefer imperative mood for describing function behavior:
>
>       Return the device's ID if it has one.  Else, return the path of a
>       device on its bus if it has one.  Else return its canonical QOM
>       path.

I'll adopt as-is.

> Bonus: obviously not the longwinded, flowery prose LLMs barf out[*].
>
> >   */
> >  const char *qdev_get_printable_name(DeviceState *dev);
>
>
> [*] Would not be welcome in QEMU at this time; see section "Use of
> AI-generated content" in docs/devel/code-provenance.rst.

Noted, thanks.

