Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B9AC48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 12:25:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc2gx-0004ZT-9r; Mon, 19 Feb 2024 07:24:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1rc2gu-0004Yh-Tt; Mon, 19 Feb 2024 07:24:12 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1rc2gs-00033T-Pv; Mon, 19 Feb 2024 07:24:12 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-29026523507so3211127a91.0; 
 Mon, 19 Feb 2024 04:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708345448; x=1708950248; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2q5Z1jq8rG73i4tjPxf7cBrWvFSBK6AAzkXM8H4DsBY=;
 b=ZWSJlDy4wrdVZLxGHm2Ibwx8RD+oS7hO56KgJgx4haz2Vmfk5I4lNVvklEFIuL2KFj
 Izvtg05GmCwmC5hz32x0DnzHr5zZkixA7mhP3SMvYHFdD+jI4wKrmFE7VY6BwqEbN9ff
 SP4TgbLJkp+gyYhNqawtvGnqNbczJ10y6oMfwvpgdsqhZKc/s2i8FYPKJMFrFZTSK7Ui
 OwmukrQqnRLLCAmnJ0RvgFCPQNYMwaJ6dDtrleyBb1y6ahNeiqbrb9dS9WFJRpVcI+BB
 wZn3ghAZYIQgIO9sFW2do8Fz5iXWbr73GvE6g6TcWyjSn+IavNUIekXBrMHtmSe5zXs4
 Pqvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708345448; x=1708950248;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2q5Z1jq8rG73i4tjPxf7cBrWvFSBK6AAzkXM8H4DsBY=;
 b=wMd3R+50k8iJQ612hoQtOxgDGnZIVYtbRJ12IEUQK+rusWn33ok+v/vinqpaEbCsZb
 J70qCSqUwPqKTnbOHm6X0H5U8WLOS+rAfOSB4mcsyRlwp5JfKDuUMnF/hgqjpVzk/Z6r
 KLd009vJYVIIKUuRRYqRi9WBof4xIpPteqTINipvp+1c68FMF+tsMHJiK8yVDkdilp1Z
 e9SFJ+TMnOdEuZAyINXU0lMFYzUb3gVcFnxThHBw3qawMlym1dXLiBG6F1BSHCmJOiuf
 K40ZaktE6DLKOBWOgaE09Qa/ZZiEmc2Gxj1jKwMm/p8w8ViSaSkJmjiY2c2NsWPT00hJ
 /jhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPYnmCQWAchuQ9ghU609qJbsfmY5aaPwP3SZqJSU9738fYpo6m67QoDryHAkxzoBTru6lD1A8TNOS0BHkW5xuS81Nyvz0=
X-Gm-Message-State: AOJu0YwJm0BXZ2aH2iY9a9aqNLLkVlmjLhJUNXevLSkjc+feKA47n8pA
 BqYCnxnzD+3ucmT6Ek+4GbPwyIwuipSWvUy6ggdiBlQU3Gk9FsH6CqL4fPirmiiF32J8iR64SQf
 qfDb+bWzpjXzZUI2pDFw8mZWMQbg=
X-Google-Smtp-Source: AGHT+IEPIWTlSZ+CgBjC96Dmrfs+1UwH/etFGQkpdR8hw5vEI+dbZldesl3n2FofamW18nFA8T8v0zIykkV/G2h4630=
X-Received: by 2002:a17:90a:f28e:b0:299:4a63:9e50 with SMTP id
 fs14-20020a17090af28e00b002994a639e50mr5181429pjb.14.1708345448031; Mon, 19
 Feb 2024 04:24:08 -0800 (PST)
MIME-Version: 1.0
References: <20240122184830.40094-1-faithilikerun@gmail.com>
 <20240122184830.40094-3-faithilikerun@gmail.com> <87plwsfyyv.fsf@pond.sub.org>
 <87edd8fyme.fsf@pond.sub.org>
In-Reply-To: <87edd8fyme.fsf@pond.sub.org>
From: Sam Li <faithilikerun@gmail.com>
Date: Mon, 19 Feb 2024 13:23:42 +0100
Message-ID: <CAAAx-8KAD1bygZsnCtkCYO=oNf7W2xnqGU+RD5Afsz8jcBUYhg@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] qcow2: add configurations for zoned format
 extension
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, dlemoal@kernel.org, Hanna Reitz <hreitz@redhat.com>,
 dmitry.fomichev@wdc.com, qemu-block@nongnu.org, 
 Eric Blake <eblake@redhat.com>, hare@suse.de, Kevin Wolf <kwolf@redhat.com>,
 stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=faithilikerun@gmail.com; helo=mail-pj1-x102c.google.com
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
=97=A5=E5=91=A8=E4=B8=80 13:05=E5=86=99=E9=81=93=EF=BC=9A
>
> One more thing...
>
> Markus Armbruster <armbru@redhat.com> writes:
>
> > I apologize for the delayed review.

No problems. Thanks for reviewing!

> >
> > Sam Li <faithilikerun@gmail.com> writes:
> >
> >> To configure the zoned format feature on the qcow2 driver, it
> >> requires settings as: the device size, zone model, zone size,
> >> zone capacity, number of conventional zones, limits on zone
> >> resources (max append bytes, max open zones, and max_active_zones).
> >>
> >> To create a qcow2 image with zoned format feature, use command like
> >> this:
> >> qemu-img create -f qcow2 zbc.qcow2 -o size=3D768M \
> >> -o zone.size=3D64M -o zone.capacity=3D64M -o zone.conventional_zones=
=3D0 \
> >> -o zone.max_append_bytes=3D4096 -o zone.max_open_zones=3D6 \
> >> -o zone.max_active_zones=3D8 -o zone.mode=3Dhost-managed
> >>
> >> Signed-off-by: Sam Li <faithilikerun@gmail.com>
> >
> > [...]
> >
> >> diff --git a/qapi/block-core.json b/qapi/block-core.json
> >> index ca390c5700..e2e0ec21a5 100644
> >> --- a/qapi/block-core.json
> >> +++ b/qapi/block-core.json
> >> @@ -5038,6 +5038,67 @@
> >>  { 'enum': 'Qcow2CompressionType',
> >>    'data': [ 'zlib', { 'name': 'zstd', 'if': 'CONFIG_ZSTD' } ] }
> >>
> >> +##
> >> +# @Qcow2ZoneModel:
> >> +#
> >> +# Zoned device model used in qcow2 image file
> >> +#
> >> +# @host-managed: The host-managed model only allows sequential write =
over the
> >> +#     device zones.
> >> +#
> >> +# Since 8.2
> >> +##
> >> +{ 'enum': 'Qcow2ZoneModel',
> >> +  'data': [ 'host-managed'] }
> >> +
> >> +##
> >> +# @Qcow2ZoneHostManaged:
> >> +#
> >> +# The host-managed zone model.  It only allows sequential writes.
> >> +#
> >> +# @size: Total number of bytes within zones.
> >
> > Default?

It should be set by users. No default value provided. If it's unset
then it is zero and an error will be returned.

> >
> >> +#
> >> +# @capacity: The number of usable logical blocks within zones
> >> +#     in bytes.  A zone capacity is always smaller or equal to the
> >> +#     zone size.
> >
> > Default?

Same.

> >
> >> +# @max-append-bytes: The maximal number of bytes of a zone
> >> +#     append request that can be issued to the device.  It must be
> >> +#     512-byte aligned and less than the zone capacity.
> >
> > Default?

Same.

For those values, I guess it could be set when users provide no
information and still want a workable emulated zoned block device.

> >
> >> +#
> >> +# Since 8.2
> >> +##
> >> +{ 'struct': 'Qcow2ZoneHostManaged',
> >> +  'data': { '*size':          'size',
> >> +            '*capacity':      'size',
> >> +            '*conventional-zones': 'uint32',
> >> +            '*max-open-zones':     'uint32',
> >> +            '*max-active-zones':   'uint32',
> >> +            '*max-append-bytes':   'size' } }
> >> +
> >> +##
> >> +# @Qcow2ZoneCreateOptions:
> >> +#
> >> +# The zone device model for the qcow2 image.
>
> Please document member @mode.
>
> Fails to build since merge commit 61e7a0d27c1:
>
>     qapi/block-core.json: In union 'Qcow2ZoneCreateOptions':
>     qapi/block-core.json:5135: member 'mode' lacks documentation
>

I see. Will update to the latest commit.

> >> +#
> >> +# Since 8.2
> >> +##
> >> +{ 'union': 'Qcow2ZoneCreateOptions',
> >> +  'base': { 'mode': 'Qcow2ZoneModel' },
> >> +  'discriminator': 'mode',
> >> +  'data': { 'host-managed': 'Qcow2ZoneHostManaged' } }
> >> +
> >>  ##
> >>  # @BlockdevCreateOptionsQcow2:
> >>  #
> >> @@ -5080,6 +5141,9 @@
> >>  # @compression-type: The image cluster compression method
> >>  #     (default: zlib, since 5.1)
> >>  #
> >> +# @zone: The zone device model modes.  The default is that the device=
 is
> >> +# not zoned.  (since 8.2)
> >> +#
> >>  # Since: 2.12
> >>  ##
> >>  { 'struct': 'BlockdevCreateOptionsQcow2',
> >> @@ -5096,7 +5160,8 @@
> >>              '*preallocation':   'PreallocMode',
> >>              '*lazy-refcounts':  'bool',
> >>              '*refcount-bits':   'int',
> >> -            '*compression-type':'Qcow2CompressionType' } }
> >> +            '*compression-type':'Qcow2CompressionType',
> >> +            '*zone':            'Qcow2ZoneCreateOptions' } }
> >>
> >>  ##
> >>  # @BlockdevCreateOptionsQed:
>

