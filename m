Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61FB2CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 16:55:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6XQ9-0005NA-Rb; Wed, 08 Oct 2025 12:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net>)
 id 1v6XQ3-0005MF-5p
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 12:53:39 -0400
Received: from m204-227.eu.mailgun.net ([161.38.204.227])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net>)
 id 1v6XPq-0003u4-Nu
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 12:53:37 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=0x65c.net; q=dns/txt;
 s=email; t=1759942399; x=1759949599; 
 h=Content-Transfer-Encoding: Content-Type: Cc: To: To: Subject: Subject:
 Message-ID: Date: From: From: In-Reply-To: References: MIME-Version: Sender:
 Sender; bh=BEHYicyPhriC0f0hnSPa+QhHaFC/HLkcVxFNVjaV6AI=;
 b=R4AEkwAQoPFBxKSrcrbmJ6uCuVyik2lW+tXEY//lqoLFgZNIslaFmHIpfpT2E1RMbIJJQJbKXO/8QU1gmdCLOTLYOK+ZlMsPhnzE7EfwqirWOOp+0KVrg1fkEujkSvLtuMYhI5ABQQuZuekrrvY2ypCzXZ7WyXdnGvNUEroezqqmJPaqUwzUkCom92Wnylb9nBEWp01dUZYdDmov/nJeK3VjBdEkxlA4ndypubN0nrxpH/a3Tx25r+TCyNeOaBmuMSfSPQuyt81P+Zuplenezf+lTI6gI5bky8aCurhQHteefSHl4FyGIAYexEWWouX1X6mua40g/gavInzp6bz3rw==
X-Mailgun-Sid: WyJiNjdhNCIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjU0ZWY0Il0=
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com
 [74.125.224.42]) by
 bc7c4d7a9363dd6e3ce8627432bd44021ad5cdf1a1a0d7c27552e15136ad7f53 with SMTP id
 68e696ff4554cfce2027d03a (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Wed, 08 Oct 2025 16:53:19 GMT
X-Mailgun-Sending-Ip: 161.38.204.227
Received: by mail-yx1-f42.google.com with SMTP id
 956f58d0204a3-635283199a9so106643d50.1
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 09:53:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWHeqCl+FPBOAmHIfZopXYNSxI+uuZEjQHrvC72EtTKgq/nGXbCLJJPYtrEcvWiE+SCFht9M8IRE8BW@nongnu.org
X-Gm-Message-State: AOJu0YyndJPnkv2n0TeRA7G+m2dJxtjnMRXa7mudt1ecvw1F/LQvss/b
 qERsDnyV8h2S/7XeDQ+ocMdnkg0WL/pU5a3SI0XYPcxjZ6B7QVwTd7d7pbPU/DFuupxiCgcOiAG
 DZ9w7uuj52NET4cSBVvQo1Nwd6JMv3U8=
X-Google-Smtp-Source: AGHT+IFKITZ1a1jnUorjvXG9Wr2JKmHqUjSpK7w8V+AnWv5lIvI+8Rz3yem4bxjtOCGeMnm643oStIu35yK3wqlCl2Q=
X-Received: by 2002:a53:acd4:0:20b0:5f4:55cb:80d4 with SMTP id
 956f58d0204a3-63ccb85ff8cmr3904527d50.17.1759942398661; Wed, 08 Oct 2025
 09:53:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1759691708.git.mst@redhat.com>
 <a9324cdecb0d9f7ae7db7f4120251b50cc768d7c.1759691708.git.mst@redhat.com>
 <CAKiXHKeXZBS3Zhn+snXi3sxG0r0cmoUW-ekeXHrQS64T10FJPQ@mail.gmail.com>
 <20251008060047-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251008060047-mutt-send-email-mst@kernel.org>
From: Alessandro Ratti <alessandro@0x65c.net>
Date: Wed, 8 Oct 2025 18:53:07 +0200
X-Gmail-Original-Message-ID: <CAKiXHKex4SNKaPX8FmTT+dQiCAKH+twzmumrYGkCUz4t-UH-Mg@mail.gmail.com>
X-Gm-Features: AS18NWBaQuhRwm1C9O4bmwL76qLNCxFcri1aVBI2SUirLNzQZrTBpclMZebQPAI
Message-ID: <CAKiXHKex4SNKaPX8FmTT+dQiCAKH+twzmumrYGkCUz4t-UH-Mg@mail.gmail.com>
Subject: Re: [PULL 49/75] virtio: Add function name to error messages
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, 
 Alessandro Ratti <alessandro.ratti@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=161.38.204.227;
 envelope-from=bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net;
 helo=m204-227.eu.mailgun.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 8 Oct 2025 at 12:01, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Sun, Oct 05, 2025 at 10:13:57PM +0200, Alessandro Ratti wrote:
> > On Sun, 5 Oct 2025 at 21:17, Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > From: Alessandro Ratti <alessandro@0x65c.net>
> > >
> > > Replace virtio_error() with a macro that automatically prepends the
> > > calling function name to error messages. This provides better context
> > > for debugging virtio issues by showing exactly which function
> > > encountered the error.
> > >
> > > Before: "Invalid queue size: 1024"
> > > After:  "virtio_queue_set_num: Invalid queue size: 1024"
> > >
> > > The implementation uses a macro to insert __func__ at compile time,
> > > avoiding any runtime overhead while providing more specific error
> > > context than a generic "virtio:" prefix.
> > >
> > > Also remove manual __func__ usage in virtio-balloon to avoid duplicat=
e
> > > function names in error messages.
> > >
> > > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/230
> > > Buglink: https://bugs.launchpad.net/qemu/+bug/1919021
> > > Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > > Signed-off-by: Alessandro Ratti <alessandro@0x65c.net>
> > > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > > Message-ID: <20250915162643.44716-2-alessandro@0x65c.net>
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > ---
> > >  include/hw/virtio/virtio.h | 4 +++-
> > >  hw/virtio/virtio-balloon.c | 2 +-
> > >  hw/virtio/virtio.c         | 3 ++-
> > >  3 files changed, 6 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> > > index d97529c3f1..695bb56186 100644
> > > --- a/include/hw/virtio/virtio.h
> > > +++ b/include/hw/virtio/virtio.h
> > > @@ -253,7 +253,9 @@ void virtio_init(VirtIODevice *vdev, uint16_t dev=
ice_id, size_t config_size);
> > >
> > >  void virtio_cleanup(VirtIODevice *vdev);
> > >
> > > -void virtio_error(VirtIODevice *vdev, const char *fmt, ...) G_GNUC_P=
RINTF(2, 3);
> > > +#define virtio_error(vdev, fmt, ...) \
> > > +    virtio_error_impl(vdev, "%s: " fmt, __func__, ##__VA_ARGS__)
> > > +void virtio_error_impl(VirtIODevice *, const char *fmt, ...) G_GNUC_=
PRINTF(2, 3);
> > >
> > >  /* Set the child bus name. */
> > >  void virtio_device_set_child_bus_name(VirtIODevice *vdev, char *bus_=
name);
> > > diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> > > index db787d00b3..e443f71c01 100644
> > > --- a/hw/virtio/virtio-balloon.c
> > > +++ b/hw/virtio/virtio-balloon.c
> > > @@ -697,7 +697,7 @@ virtio_balloon_free_page_hint_notify(NotifierWith=
Return *n, void *data,
> > >      case PRECOPY_NOTIFY_COMPLETE:
> > >          break;
> > >      default:
> > > -        virtio_error(vdev, "%s: %d reason unknown", __func__, pnd->r=
eason);
> > > +        virtio_error(vdev, "%d reason unknown", pnd->reason);
> > >      }
> > >
> > >      return 0;
> > > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > > index de89e8104a..0f33ca5d90 100644
> > > --- a/hw/virtio/virtio.c
> > > +++ b/hw/virtio/virtio.c
> > > @@ -3968,7 +3968,8 @@ void virtio_device_set_child_bus_name(VirtIODev=
ice *vdev, char *bus_name)
> > >      vdev->bus_name =3D g_strdup(bus_name);
> > >  }
> > >
> > > -void G_GNUC_PRINTF(2, 3) virtio_error(VirtIODevice *vdev, const char=
 *fmt, ...)
> > > +void G_GNUC_PRINTF(2, 3)
> > > +virtio_error_impl(VirtIODevice *vdev, const char *fmt, ...)
> > >  {
> > >      va_list ap;
> > >
> > > --
> > > MST
> > >
> > >
> >
> > Hi Michael,
> >
> > Thanks for picking this up.
> >
> > It seems that the version currently queued is actually the initial
> > submission, which had previously been rejected following feedback from
> > Markus Armbruster.
> > I later submitted a corrected version ([v3]) which:
> >
> > * Addresses all the feedback (including from Markus Armbruster and
> > Daniel P. Berrang=C3=A9).
> > * Has Daniel=E2=80=99s formal Reviewed-by:
> >
> > Patch: https://lore.kernel.org/qemu-devel/20250924093138.559872-2-aless=
andro@0x65c.net/
> > Reviewed-by: https://lore.kernel.org/qemu-devel/aNO7J7Y6wsk1-wyw@redhat=
.com/
> >
> > Would you mind updating the queue to reflect this version instead?
> >
> > Thanks again for your time and all the work you do maintaining virtio!
> >
> > Best regards,
> > Alessandro
>
>
> So as you likely already noticed
> I replaced just this patch and updated the tag in the pull.

Thanks Michael, I saw the update =E2=80=94 everything looks good on my end.
I really appreciate you taking the time to sort that out!

Best regards,
Alessandro

