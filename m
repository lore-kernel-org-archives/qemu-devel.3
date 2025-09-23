Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30AA4CAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 09:44:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0zYM-0002nZ-7c; Tue, 23 Sep 2025 05:43:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net>)
 id 1v0zYH-0002m8-PW
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 05:43:14 -0400
Received: from m204-227.eu.mailgun.net ([161.38.204.227])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net>)
 id 1v0zY6-0006EO-V9
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 05:43:13 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=0x65c.net; q=dns/txt;
 s=email; t=1758620576; x=1758627776; 
 h=Content-Transfer-Encoding: Content-Type: Cc: To: To: Subject: Subject:
 Message-ID: Date: From: From: In-Reply-To: References: MIME-Version: Sender:
 Sender; bh=juO6PgdhUpkSD85ak2KJtgBCDDKFCBiwovdiZcdZfT0=;
 b=C/DU/3eMij0k2Djlo87fZyQ3sG2ArHgpO0m77NjMK1vpFxcy9rx8SZtubtjLawhHOAKvjPKeOvfSj+1QrNtE0Asq1pVA2kpqa2bhfnSS3Fir/YrDOaRIQJOS1fR6Zq6UcW68J6rKR+GjrI5dYKiHhrKdQNXK6Qsnyc6XnUapFiw14YPbtxCSdSULO7zSsukjWVjaaTJ/Tship89MIhUK4M0kYwDWBTxiaqHQWMZfg42/5gYm1kq+8tl3Zz+TUhC6Cfhj3VTrPzqq/BCqaCjM5Tc2rM7gTto0yFnQttfIUr75mDaJfwHJ6VScbbjbCMVvwXECroFivqqv4inzSq4yTg==
X-Mailgun-Sid: WyJiNjdhNCIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjU0ZWY0Il0=
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com
 [74.125.224.50]) by
 f956498d761e37a502969325b327bf1c178b753e880ddeae2c7348fee5072e27 with SMTP id
 68d26ba0a6079c31f549fce9 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Tue, 23 Sep 2025 09:42:56 GMT
X-Mailgun-Sending-Ip: 161.38.204.227
Received: by mail-yx1-f50.google.com with SMTP id
 956f58d0204a3-63497c2a27dso2671368d50.1
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 02:42:56 -0700 (PDT)
X-Gm-Message-State: AOJu0YymfY7czlHs7Hbptwf6B2Vy54Sk6z5FQHJ/3OXxegUEQoa70zb7
 vC9SZ09jzKuYwpLUf9GvxF1nCsBLluH8ImlU60CtznO9FpnMAd4QKV5u3BrQ2vIYg1UIlpZ5W1/
 seyWJ2B69ZOxcxEwf1PUy5tmXBc4Q0iM=
X-Google-Smtp-Source: AGHT+IEl9oJdFqqFnqSXeXW77DHdoTFEScATsWRcrF0dT++YLlcwVU9GiA53dUiTtakN/ZpE3W4VT0Ey2j3ADlaLK88=
X-Received: by 2002:a05:690e:1544:10b0:632:ebca:988b with SMTP id
 956f58d0204a3-636046ee2e4mr1334512d50.3.1758620575897; Tue, 23 Sep 2025
 02:42:55 -0700 (PDT)
MIME-Version: 1.0
References: <87a52wqa03.fsf@draig.linaro.org>
 <20250915162643.44716-1-alessandro@0x65c.net>
 <20250915162643.44716-2-alessandro@0x65c.net> <87h5wulqm2.fsf@pond.sub.org>
 <aNEpVhkZ2r5e2Z9X@redhat.com> <87wm5qoig7.fsf@draig.linaro.org>
 <877bxqk6vp.fsf@pond.sub.org>
 <CAKiXHKe07RKxBUCqfTFYkaGRj6T-avnS4C5=WcUqevD9eBQ4_g@mail.gmail.com>
 <87a52mh8hl.fsf@pond.sub.org>
In-Reply-To: <87a52mh8hl.fsf@pond.sub.org>
From: Alessandro Ratti <alessandro@0x65c.net>
Date: Tue, 23 Sep 2025 11:42:44 +0200
X-Gmail-Original-Message-ID: <CAKiXHKfQYKRu6MDCJdgiAhv2rxj8hnvQE+GXQsxtnK5R7F5d5g@mail.gmail.com>
X-Gm-Features: AS18NWC9KBW3ZJW4jtNezVrU7bAPvn4jUfIUNR3OpXnekaonXly3ZPN6EujlDcQ
Message-ID: <CAKiXHKfQYKRu6MDCJdgiAhv2rxj8hnvQE+GXQsxtnK5R7F5d5g@mail.gmail.com>
Subject: Re: [PATCH v2] virtio: Add function name to error messages
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Alessandro Ratti <alessandro@0x65c.net>, philmd@linaro.org
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, 22 Sept 2025 at 16:23, Markus Armbruster <armbru@redhat.com> wrote:
>
> Alessandro Ratti <alessandro.ratti@gmail.com> writes:
>
> > On Mon, 22 Sept 2025 at 14:29, Markus Armbruster <armbru@redhat.com> wr=
ote:
> >>
> >> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
> >>
> >> > Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
> >> >
> >> >> On Mon, Sep 22, 2025 at 12:37:57PM +0200, Markus Armbruster wrote:
> >> >>> Alessandro Ratti <alessandro@0x65c.net> writes:
> >> >>>
> >> >>> > Replace virtio_error() with a macro that automatically prepends =
the
> >> >>> > calling function name to error messages. This provides better co=
ntext
> >> >>> > for debugging virtio issues by showing exactly which function
> >> >>> > encountered the error.
> >> >>> >
> >> >>> > Before: "Invalid queue size: 1024"
> >> >>> > After:  "virtio_queue_set_num: Invalid queue size: 1024"
> >> >>> >
> >> >>> > The implementation uses a macro to insert __func__ at compile ti=
me,
> >> >>> > avoiding any runtime overhead while providing more specific erro=
r
> >> >>> > context than a generic "virtio:" prefix.
> >> >>>
> >> >>> A need for function names and such in error messages suggests the =
error
> >> >>> messages are crap.
> >> >>
> >> >> I pretty much agree. If we take that view forwards, then I think ou=
r
> >> >> coding guidelines should explicitly state something like
> >> >>
> >> >>  "Function names must never be included in error messages.
> >> >>
> >> >>   The messages need to be sufficiently descriptive in their
> >> >>   text, such that including function names is redundant"
> >>
> >> I'm in favor.
> >>
> >> > Ahh I missed the fact this ends up as an error_report. I think havin=
g
> >> > function names in debug output is fine.
> >>
> >> No argument!
> >>
> >> > It does however miss important information like which VirtIO device =
is
> >> > actually failing, despite having vdev passed down to the function.
> >>
> >> Yes, which device failed should definitely be reported.
> >>
> >> [...]
> >
> > Hi Markus, Alex, Daniel,
> >
> > Thanks again for the thoughtful feedback and for helping me see the big=
ger
> > picture. I now fully agree that adding function names to error messages=
 (via
> > __func__) doesn't really address the core issue, and I appreciate the
> > push to rethink how error reporting can better serve both users and dev=
elopers.
> >
> > I've taken a first stab at improving one of the messages in
> > virtio_init_region_cache(), following your suggestions.
> >
> > Here's the updated call:
> >
> > ---8<--- Example diff --8<---
> > --- a/hw/virtio/virtio.c
> > +++ b/hw/virtio/virtio.c
> > @@ -240,6 +240,7 @@ void virtio_init_region_cache(VirtIODevice *vdev, i=
nt n)
> >      VirtQueue *vq =3D &vdev->vq[n];
> >      VRingMemoryRegionCaches *old =3D vq->vring.caches;
> >      VRingMemoryRegionCaches *new =3D NULL;
> > +    DeviceState *dev =3D DEVICE(vdev);
> >      hwaddr addr, size;
> >      int64_t len;
> >      bool packed;
> > @@ -264,7 +265,10 @@ void virtio_init_region_cache(VirtIODevice *vdev, =
int n)
> >      len =3D address_space_cache_init(&new->used, vdev->dma_as,
> >                                     vq->vring.used, size, true);
> >      if (len < size) {
> > -        virtio_error(vdev, "Cannot map used");
> > +        virtio_error(vdev,
> > +                    "Failed to map used ring for device %s - "
> > +                    "possible guest misconfiguration or insufficient m=
emory",
> > +                    qdev_get_dev_path(dev));
> >          goto err_used;
> >      }
> >
> > With this change, the error output now reads:
> >
> >     qemu-system-x86_64: Failed to map used ring for device
> > 0000:00:04.0 - possible guest misconfiguration or insufficient memory
> >
> > This feels like a clear improvement =E2=80=94 it gives context (what fa=
iled),
> > identifies the device, and hints at likely causes.
>
> It's *much* better!
>
> Developers will appreciate "Failed to map used ring for device".  By
> itself it would still be gobbledygook for users, but together with the
> "possible guest misconfiguration or insufficient memory" clue it's fine.
>
> Perhaps we can still improve on "device 0000:00:04.0".  The device's ID
> is a good way to identify it to the user, because it's chosen by the
> user, and unique (among devices).  Sadly, devices without ID exist.  We
> fall back to canonical QOM path in places.  Have a look at
> qdev_get_human_name() to see whether it works here.

I experimented with qdev_get_human_name(), but it usually returns paths lik=
e:

  /machine/peripheral-anon/device[0]/virtio-backend

=E2=80=A6which seems less user-friendly than the PCI address provided by
qdev_get_dev_path().
For now, I'm sticking to using the device ID when set (e.g. via -device=E2=
=80=A6,id=3Dfoo)
and falling back to qdev_get_dev_path() otherwise =E2=80=94 which provides =
predictable
output for both PCI and non-PCI devices.

> Should we spell out that the device is now broken (whatever vdev->broken
> means)?

That's a good point =E2=80=94 I'll leave that for a possible follow-up so w=
e can keep
this patch focused on improving error clarity and device identification fir=
st.

I'll submit a new patch shortly based on this discussion, with the
debug scaffolding removed. I'll include a link to this thread in the cover
letter for continuity.

> > If this is more in line with what you'd expect, I'd be happy to submit =
a new
> > patch focused solely on improving a few key virtio error messages in th=
is
> > direction, starting with the worst offenders in virtio_init_region_cach=
e().
> >
> > Thanks again for your time and guidance =E2=80=94 I'm learning a lot fr=
om this process.
>
> You're welcome!  And thank you for accepting my little rant as
> constructive criticism :)

:)
Thanks again for your time and guidance =E2=80=94 it's really helping me le=
arn the ropes
here.

Best regards,
Alessandro

