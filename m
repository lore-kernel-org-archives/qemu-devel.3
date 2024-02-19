Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3C2BC48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 20:48:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcAY1-0002CM-9o; Mon, 19 Feb 2024 15:47:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1rcAXi-00029I-Uf; Mon, 19 Feb 2024 15:47:21 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1rcAXe-00064a-Qp; Mon, 19 Feb 2024 15:47:12 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6e47a104c2eso35521b3a.2; 
 Mon, 19 Feb 2024 12:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708375629; x=1708980429; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CSxtuVMInPoPYmHXGFwwww1eN+MaiAcfHPxhJShYD/U=;
 b=GWSQ1lJpBrw0O6A4jjN/LboU9sJ7dFlGeFjCTHibzzhz8+tLltToQghH7hHw6l0uN7
 ZBRCuYGWyyDlgQFKzV0GOBxoUzi0SRtQQQLh1y/5eKudh5FgsBNE27Ld1VfFwdTJbfUx
 uyrb76S1FXnYNAiwH0eX/7FWIhLcMA+wKAE/Vcu2C1CVe/QvL/s1HXXiHEegkRK0kM5T
 4hX0IxgiQG37M0RPSIS8Gmt/ci/09op7639yTJCgI5M84V8FebuMe15GunpzNzjFHE+O
 7ZJHAI92Nq/UbYQWXfG5qqJUVRutn3Qmud54TDNAQ0pOU1nsOQhddL+TxQO447n0Jbsm
 np7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708375629; x=1708980429;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CSxtuVMInPoPYmHXGFwwww1eN+MaiAcfHPxhJShYD/U=;
 b=SxJyaIz0CG52z56mbUk1FgzbGPDZa9nma8R2H5OTDCKrL7RuiO2d5tIH2HOy+TXUxp
 fHpnU9w7hpIGI6+o95XTdYllNiEWHAFpOHm6X63rz/zJMugAGIzI6QGShBRep1GY7XR/
 zcAtIs/9Lqly6zJ+CjTS5izWj1mHo+XOe5z8+mxkOhXgjnSFrdH6wpswnx/gUF5hCyKn
 /ebX7Xp3buge8ivQ62jnYX/VzplhBuJdZh/xnvDXr6OrrM8s14hpXt+OgH9U1tO9Fk8e
 TTTFIhfwlA8z+oF/xc4DNJNO1eYwdpO70UvaRitAo0y+mnLrYUFHbpdebAZH6DRKvK8u
 evnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMvrVPnwS+0dgvlZxiMPNvKHna8Na2rP15/ZUJBIErKZt/oY3RpJJJeJdTnmd291Xk76jbFSDeHZesCx6Ie/WSTnKJO7g=
X-Gm-Message-State: AOJu0YyiOWyb77mrbgFHQ9L3cpsZc7kAPP9gzbnetPkVcuLIZAYlvdAd
 Kpc93ISBJET/7ZLsmUgVjOg9zhizmHQQmbO4TUPbaCRdeLALTISnHzt0mDNHi0KhZrKXsXQ0QjO
 8EJs6vFDuWDNTtyHPNWRmmvFSFh0=
X-Google-Smtp-Source: AGHT+IHSMOFv2Dj9jJkaYkEa38a5t8b8s8gJZZwI8oFAoJl/E6VyHl9Xljh8NjfEXtolFWylwqAI7G6q6CTgLXbujTo=
X-Received: by 2002:a05:6a21:6315:b0:19e:5517:c345 with SMTP id
 wu21-20020a056a21631500b0019e5517c345mr11493591pzb.44.1708375628923; Mon, 19
 Feb 2024 12:47:08 -0800 (PST)
MIME-Version: 1.0
References: <20240122184830.40094-1-faithilikerun@gmail.com>
 <20240122184830.40094-3-faithilikerun@gmail.com> <87plwsfyyv.fsf@pond.sub.org>
 <87edd8fyme.fsf@pond.sub.org>
 <CAAAx-8KAD1bygZsnCtkCYO=oNf7W2xnqGU+RD5Afsz8jcBUYhg@mail.gmail.com>
 <877cj0jz5u.fsf@pond.sub.org>
 <CAAAx-8JYR2r7BzWWVtcY9h8ZgNq1an4=eTCwBnDNe+HwbkgHeg@mail.gmail.com>
 <87a5nwh2h6.fsf@pond.sub.org>
 <CAAAx-8+Am5ehs6tyA64Vms713+34iq44yR6SvWr7CpHX_dq-MA@mail.gmail.com>
 <87o7ccfaok.fsf@pond.sub.org>
In-Reply-To: <87o7ccfaok.fsf@pond.sub.org>
From: Sam Li <faithilikerun@gmail.com>
Date: Mon, 19 Feb 2024 21:46:42 +0100
Message-ID: <CAAAx-8KvZv=vfGB8+h73Nh=8DwsyD-nD_FjgGrgW2O+h66FdeA@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] qcow2: add configurations for zoned format
 extension
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, dlemoal@kernel.org, Hanna Reitz <hreitz@redhat.com>,
 dmitry.fomichev@wdc.com, qemu-block@nongnu.org, 
 Eric Blake <eblake@redhat.com>, hare@suse.de, Kevin Wolf <kwolf@redhat.com>,
 stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=faithilikerun@gmail.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Markus Armbruster <armbru@redhat.com> =E4=BA=8E2024=E5=B9=B42=E6=9C=8819=E6=
=97=A5=E5=91=A8=E4=B8=80 21:42=E5=86=99=E9=81=93=EF=BC=9A
>
> Sam Li <faithilikerun@gmail.com> writes:
>
> > Markus Armbruster <armbru@redhat.com> =E4=BA=8E2024=E5=B9=B42=E6=9C=881=
9=E6=97=A5=E5=91=A8=E4=B8=80 16:56=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> Sam Li <faithilikerun@gmail.com> writes:
> >>
> >> > Markus Armbruster <armbru@redhat.com> =E4=BA=8E2024=E5=B9=B42=E6=9C=
=8819=E6=97=A5=E5=91=A8=E4=B8=80 15:40=E5=86=99=E9=81=93=EF=BC=9A
> >> >>
> >> >> Sam Li <faithilikerun@gmail.com> writes:
> >> >>
> >> >> > Markus Armbruster <armbru@redhat.com> =E4=BA=8E2024=E5=B9=B42=E6=
=9C=8819=E6=97=A5=E5=91=A8=E4=B8=80 13:05=E5=86=99=E9=81=93=EF=BC=9A
> >> >> >>
> >> >> >> One more thing...
> >> >> >>
> >> >> >> Markus Armbruster <armbru@redhat.com> writes:
> >> >> >>
> >> >> >> > I apologize for the delayed review.
> >> >> >
> >> >> > No problems. Thanks for reviewing!
> >> >> >
> >> >> >> >
> >> >> >> > Sam Li <faithilikerun@gmail.com> writes:
> >> >> >> >
> >> >> >> >> To configure the zoned format feature on the qcow2 driver, it
> >> >> >> >> requires settings as: the device size, zone model, zone size,
> >> >> >> >> zone capacity, number of conventional zones, limits on zone
> >> >> >> >> resources (max append bytes, max open zones, and max_active_z=
ones).
> >> >> >> >>
> >> >> >> >> To create a qcow2 image with zoned format feature, use comman=
d like
> >> >> >> >> this:
> >> >> >> >> qemu-img create -f qcow2 zbc.qcow2 -o size=3D768M \
> >> >> >> >> -o zone.size=3D64M -o zone.capacity=3D64M -o zone.conventiona=
l_zones=3D0 \
> >> >> >> >> -o zone.max_append_bytes=3D4096 -o zone.max_open_zones=3D6 \
> >> >> >> >> -o zone.max_active_zones=3D8 -o zone.mode=3Dhost-managed
> >> >> >> >>
> >> >> >> >> Signed-off-by: Sam Li <faithilikerun@gmail.com>
> >> >> >> >
> >> >> >> > [...]
> >> >> >> >
> >> >> >> >> diff --git a/qapi/block-core.json b/qapi/block-core.json
> >> >> >> >> index ca390c5700..e2e0ec21a5 100644
> >> >> >> >> --- a/qapi/block-core.json
> >> >> >> >> +++ b/qapi/block-core.json
> >> >> >> >> @@ -5038,6 +5038,67 @@
> >> >> >> >>  { 'enum': 'Qcow2CompressionType',
> >> >> >> >>    'data': [ 'zlib', { 'name': 'zstd', 'if': 'CONFIG_ZSTD' } =
] }
> >> >> >> >>
> >> >> >> >> +##
> >> >> >> >> +# @Qcow2ZoneModel:
> >> >> >> >> +#
> >> >> >> >> +# Zoned device model used in qcow2 image file
> >> >> >> >> +#
> >> >> >> >> +# @host-managed: The host-managed model only allows sequenti=
al write over the
> >> >> >> >> +#     device zones.
> >> >> >> >> +#
> >> >> >> >> +# Since 8.2
> >> >> >> >> +##
> >> >> >> >> +{ 'enum': 'Qcow2ZoneModel',
> >> >> >> >> +  'data': [ 'host-managed'] }
> >> >> >> >> +
> >> >> >> >> +##
> >> >> >> >> +# @Qcow2ZoneHostManaged:
> >> >> >> >> +#
> >> >> >> >> +# The host-managed zone model.  It only allows sequential wr=
ites.
> >> >> >> >> +#
> >> >> >> >> +# @size: Total number of bytes within zones.
> >> >> >> >
> >> >> >> > Default?
> >> >> >
> >> >> > It should be set by users. No default value provided. If it's uns=
et
> >> >> > then it is zero and an error will be returned.
> >> >>
> >> >> If the user must provide @size, why is it optional then?
> >> >
> >> > It is not optional when the zone model is host-managed. If it's
> >> > non-zoned, then we don't care about zone info. I am not sure how to
> >> > make it unoptional.
> >>
> >> We have:
> >>
> >>    blockdev-create argument @options of type BlockdevCreateOptions
> >>
> >>    BlockdevCreateOptions union branch @qcow2 of type
> >>    BlockdevCreateOptionsQcow2, union tag member is @driver
> >>
> >>    BlockdevCreateOptionsQcow2 optional member @zone of type
> >>    Qcow2ZoneCreateOptions, default not zoned
> >>
> >>    Qcow2ZoneCreateOptions union branch @host-managed of type
> >>    Qcow2ZoneHostManaged, union tag member is @mode
> >>
> >>    Qcow2ZoneHostManaged optional member @size of type size.
> >>
> >> Making this member @size mandatory means we must specify it when
> >> BlockdevCreateOptionsQcow2 member @zone is present and @zone's member
> >> @mode is "host-managed".  Feels right to me.  Am I missing anything?
> >
> > That's right. And the checks when creating such an img can help do
> > that. It's not specified in the .json file directly.
>
> What would break if we did specify it in the QAPI schema directly?

Nothing I think. We can keep the current schema and add a default zone
size like 131072.

>
> [...]
>

