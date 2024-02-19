Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A27C48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 14:49:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc4wz-0000eu-7b; Mon, 19 Feb 2024 09:48:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1rc4wv-0000d9-TP; Mon, 19 Feb 2024 09:48:53 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1rc4wu-00076g-9M; Mon, 19 Feb 2024 09:48:53 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-29938dcb711so1512469a91.0; 
 Mon, 19 Feb 2024 06:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708354129; x=1708958929; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9kai/bGwjVWKVeTAGOqOfn1sayVxYQ1bqbiZ2Hhyhak=;
 b=NVexGkHxe413MKmK7b5NDSFUzkCG1ZXa0+32BafGQ0FTRBS6VBIPcTYoA6LIWYP6Nt
 AIaag7DUu2eWElkFvmrWrhxAMuai1mVgUKnGfhnOImTKKfaJh9AOEhyUgdKgI7P+nZTs
 NlVjMkQk/7mWgxJxjRHqLXaix3Gr6bNeZaEIjkPGP2aqElEoA+t15R0nSgJHKuN4z1iF
 Eo13IDT0Tr7Fr/mqqV0Pr5xoIczlf6CcH9OtgGAnZuqyR20eKBBSfzwaK1TYOBTLiOec
 ZkoXFpNNOdh66iHkyi/H6VS3TR5oYmFACu9LEttC8w1b1LXOqBpPEYgGOkkhIOIUDHFc
 77Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708354129; x=1708958929;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9kai/bGwjVWKVeTAGOqOfn1sayVxYQ1bqbiZ2Hhyhak=;
 b=NjbH0bnY6Px97b1JSgsKhhJyjErF9MOuxFvzJoFshG9Q95qyz0paUWJsmeVkiAACxI
 fcNHphfWGVj+Unn0Y0+yvx9rNUc12sxdWxj1u3aMeTJy2ZtNZaI8rRiOTEIMr7R3nHtP
 pzMeAoNxo9D7W+Ol3VPrJ4bSN/eEsnh2SsxUFjwmHhTB7M8tIohUfe4n6KswLlhMEwSx
 c/eT+ydAjugTYkFi5wzN57J1LpivPqSsU/HJ6vzke8vPmV6uib9J2BlE/oTr6IRBRPZ7
 90URlwMLs3Pe+vjaHHxXyqBy0yEqrTFlfCB8Vrw3Cyp3DYyME1P0FMQEC3y4MR3M4b4s
 SFKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZDwkrJYHqHfQYah1kalNqGRMQ/YpYrSn/9xCcR1f5wUmZGIOOHlW9LCF7571H1GyYNUrQwSJLgxJAa5RKC4oQZwWcftU=
X-Gm-Message-State: AOJu0YxP+6IAkPnhAtLiH6JTYB7v3P8mPS1gsfc+J/4aFooCJGLk9jrH
 /8mUMvz1naUQWCjR+uuUCnJGAv75pU6kN+9c+pDn5supdGF2ZMtnLRmXWG+cSOCVVxXZAPsMFIN
 Ig40ksOC8aIgJ6dY/7W97nXOf+cY=
X-Google-Smtp-Source: AGHT+IERT8m8se7K3z4kQlCp3P8zCIynS03VYreGuX48WB9MS3D30QpGK+olh3JyHnGMGPDkPlPlhwiZKs0M+VJS2p8=
X-Received: by 2002:a17:90a:8593:b0:299:879a:7da7 with SMTP id
 m19-20020a17090a859300b00299879a7da7mr2563117pjn.34.1708354128963; Mon, 19
 Feb 2024 06:48:48 -0800 (PST)
MIME-Version: 1.0
References: <20240122184830.40094-1-faithilikerun@gmail.com>
 <20240122184830.40094-3-faithilikerun@gmail.com> <87plwsfyyv.fsf@pond.sub.org>
 <87edd8fyme.fsf@pond.sub.org>
 <CAAAx-8KAD1bygZsnCtkCYO=oNf7W2xnqGU+RD5Afsz8jcBUYhg@mail.gmail.com>
 <877cj0jz5u.fsf@pond.sub.org>
In-Reply-To: <877cj0jz5u.fsf@pond.sub.org>
From: Sam Li <faithilikerun@gmail.com>
Date: Mon, 19 Feb 2024 15:48:22 +0100
Message-ID: <CAAAx-8JYR2r7BzWWVtcY9h8ZgNq1an4=eTCwBnDNe+HwbkgHeg@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] qcow2: add configurations for zoned format
 extension
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, dlemoal@kernel.org, Hanna Reitz <hreitz@redhat.com>,
 dmitry.fomichev@wdc.com, qemu-block@nongnu.org, 
 Eric Blake <eblake@redhat.com>, hare@suse.de, Kevin Wolf <kwolf@redhat.com>,
 stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=faithilikerun@gmail.com; helo=mail-pj1-x1036.google.com
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
=97=A5=E5=91=A8=E4=B8=80 15:40=E5=86=99=E9=81=93=EF=BC=9A
>
> Sam Li <faithilikerun@gmail.com> writes:
>
> > Markus Armbruster <armbru@redhat.com> =E4=BA=8E2024=E5=B9=B42=E6=9C=881=
9=E6=97=A5=E5=91=A8=E4=B8=80 13:05=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> One more thing...
> >>
> >> Markus Armbruster <armbru@redhat.com> writes:
> >>
> >> > I apologize for the delayed review.
> >
> > No problems. Thanks for reviewing!
> >
> >> >
> >> > Sam Li <faithilikerun@gmail.com> writes:
> >> >
> >> >> To configure the zoned format feature on the qcow2 driver, it
> >> >> requires settings as: the device size, zone model, zone size,
> >> >> zone capacity, number of conventional zones, limits on zone
> >> >> resources (max append bytes, max open zones, and max_active_zones).
> >> >>
> >> >> To create a qcow2 image with zoned format feature, use command like
> >> >> this:
> >> >> qemu-img create -f qcow2 zbc.qcow2 -o size=3D768M \
> >> >> -o zone.size=3D64M -o zone.capacity=3D64M -o zone.conventional_zone=
s=3D0 \
> >> >> -o zone.max_append_bytes=3D4096 -o zone.max_open_zones=3D6 \
> >> >> -o zone.max_active_zones=3D8 -o zone.mode=3Dhost-managed
> >> >>
> >> >> Signed-off-by: Sam Li <faithilikerun@gmail.com>
> >> >
> >> > [...]
> >> >
> >> >> diff --git a/qapi/block-core.json b/qapi/block-core.json
> >> >> index ca390c5700..e2e0ec21a5 100644
> >> >> --- a/qapi/block-core.json
> >> >> +++ b/qapi/block-core.json
> >> >> @@ -5038,6 +5038,67 @@
> >> >>  { 'enum': 'Qcow2CompressionType',
> >> >>    'data': [ 'zlib', { 'name': 'zstd', 'if': 'CONFIG_ZSTD' } ] }
> >> >>
> >> >> +##
> >> >> +# @Qcow2ZoneModel:
> >> >> +#
> >> >> +# Zoned device model used in qcow2 image file
> >> >> +#
> >> >> +# @host-managed: The host-managed model only allows sequential wri=
te over the
> >> >> +#     device zones.
> >> >> +#
> >> >> +# Since 8.2
> >> >> +##
> >> >> +{ 'enum': 'Qcow2ZoneModel',
> >> >> +  'data': [ 'host-managed'] }
> >> >> +
> >> >> +##
> >> >> +# @Qcow2ZoneHostManaged:
> >> >> +#
> >> >> +# The host-managed zone model.  It only allows sequential writes.
> >> >> +#
> >> >> +# @size: Total number of bytes within zones.
> >> >
> >> > Default?
> >
> > It should be set by users. No default value provided. If it's unset
> > then it is zero and an error will be returned.
>
> If the user must provide @size, why is it optional then?

It is not optional when the zone model is host-managed. If it's
non-zoned, then we don't care about zone info. I am not sure how to
make it unoptional.

>
> >> >
> >> >> +#
> >> >> +# @capacity: The number of usable logical blocks within zones
> >> >> +#     in bytes.  A zone capacity is always smaller or equal to the
> >> >> +#     zone size.
> >> >
> >> > Default?
> >
> > Same.
> >
> >> >
> >> >> +# @max-append-bytes: The maximal number of bytes of a zone
> >> >> +#     append request that can be issued to the device.  It must be
> >> >> +#     512-byte aligned and less than the zone capacity.
> >> >
> >> > Default?
> >
> > Same.
> >
> > For those values, I guess it could be set when users provide no
> > information and still want a workable emulated zoned block device.
> >
> >> >
> >> >> +#
> >> >> +# Since 8.2
> >> >> +##
> >> >> +{ 'struct': 'Qcow2ZoneHostManaged',
> >> >> +  'data': { '*size':          'size',
> >> >> +            '*capacity':      'size',
> >> >> +            '*conventional-zones': 'uint32',
> >> >> +            '*max-open-zones':     'uint32',
> >> >> +            '*max-active-zones':   'uint32',
> >> >> +            '*max-append-bytes':   'size' } }
>
> [...]
>

