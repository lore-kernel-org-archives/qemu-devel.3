Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84861C48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 16:10:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc6Du-0008LC-SH; Mon, 19 Feb 2024 11:10:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1rc6Dt-0008K0-KP; Mon, 19 Feb 2024 11:10:29 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1rc6Dr-0005Lo-Ex; Mon, 19 Feb 2024 11:10:29 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1d746ce7d13so28696275ad.0; 
 Mon, 19 Feb 2024 08:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708359025; x=1708963825; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5QatrVCruw0tP8DALRTGT/x+F3mSAJzaHluuyqHlSS0=;
 b=a8WFajkxD6lAZ9JIwU9dUWdRLtvSwEN/ukWQQR9FwJCydMwc6TEZmmAVRAJf2Rf8sN
 6WQVaNl3aalyArwzmI1DM18oVNQyN7Ov1VkV4ArF+RHiFae02g02iySkvasVFr/5qYnN
 homFhwwo8XyRP/Ws5adZ/xbW05y4gMPMSfcbOV4sjy4+Oznp3jpXg6DDRey5XCvRNpKk
 W6P7/OuFEYz8KyDXFuXauckhsbltMBwHXbi14uVWMHs284qasjt2L6WRWrVX19PXqfln
 5SluSUPLhDeX71IoS1bFF4A4QkcSRYQNPxM0VcrB/eR/yNUyJUKtoPA5NA1hFf/h/HtH
 AWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708359025; x=1708963825;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5QatrVCruw0tP8DALRTGT/x+F3mSAJzaHluuyqHlSS0=;
 b=WVQ3flqS8ZDxx0p+2BrN4men26KMt1ePwBcKV+TcUoF/QydKYp1ySAcczVrJvYJEfJ
 Bw6U456XXiElzFQQX71X4ohRaBLsDYDe8RQpsSpStzJdFqfj8DlP5zwb4z/utWSoEfjK
 TnfAFD2KBqgcso9sMyvcnkK/0NOVsL+zbX+lWPLXQ7tGQT3IYSzqqLWnaDDW3lkXvGQ7
 8B47q8dWII/dwZwmf+Sa1QXQrai1Y7Br4B6de3JzF+PT0xbTVw0EQf62cKS1XITpF9mH
 o+JTcp4zAjrZI8B3ddyTZm594RbS1JtFMDKk+dHJP16nJ43TZjDbQw+QH/rvMIjSEr/h
 Uvjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQpKPhgYhWOd1V2c9kAAC0v1lLcdjxUHkdXkDF5uX4QOZUMpr/F8bqAd0eU/l2aG3gy0x7ZYZggcCbOEw4Ynt6+9RwvJQ=
X-Gm-Message-State: AOJu0YymNQLMKRAngzjwSCsyfXZxYPAoix8tONsrWwSrvM4njXrOVuFC
 eDSamhmKDsPoAggRYA2MuSz+JiRa/CUicVvp3OH+k/SIG/iAr4tYOABHCg/to/jRS2mSJxr89sD
 LkSS54RvgFmqUqY/hNrrAtvR2ts0=
X-Google-Smtp-Source: AGHT+IG+Qyj7wQb+rZizE3aAhbDSm/D1bSN+D4FPU4sXTGUXHr+xd8IC14ZBcfskQbi7N9PdmDy2BxOaJTAWa8eJm4o=
X-Received: by 2002:a17:90a:34c8:b0:299:8e70:e9a5 with SMTP id
 m8-20020a17090a34c800b002998e70e9a5mr2964821pjf.20.1708359024869; Mon, 19 Feb
 2024 08:10:24 -0800 (PST)
MIME-Version: 1.0
References: <20240122184830.40094-1-faithilikerun@gmail.com>
 <20240122184830.40094-3-faithilikerun@gmail.com> <87plwsfyyv.fsf@pond.sub.org>
 <87edd8fyme.fsf@pond.sub.org>
 <CAAAx-8KAD1bygZsnCtkCYO=oNf7W2xnqGU+RD5Afsz8jcBUYhg@mail.gmail.com>
 <877cj0jz5u.fsf@pond.sub.org>
 <CAAAx-8JYR2r7BzWWVtcY9h8ZgNq1an4=eTCwBnDNe+HwbkgHeg@mail.gmail.com>
 <87a5nwh2h6.fsf@pond.sub.org>
In-Reply-To: <87a5nwh2h6.fsf@pond.sub.org>
From: Sam Li <faithilikerun@gmail.com>
Date: Mon, 19 Feb 2024 17:09:58 +0100
Message-ID: <CAAAx-8+Am5ehs6tyA64Vms713+34iq44yR6SvWr7CpHX_dq-MA@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] qcow2: add configurations for zoned format
 extension
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, dlemoal@kernel.org, Hanna Reitz <hreitz@redhat.com>,
 dmitry.fomichev@wdc.com, qemu-block@nongnu.org, 
 Eric Blake <eblake@redhat.com>, hare@suse.de, Kevin Wolf <kwolf@redhat.com>,
 stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=faithilikerun@gmail.com; helo=mail-pl1-x630.google.com
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
=97=A5=E5=91=A8=E4=B8=80 16:56=E5=86=99=E9=81=93=EF=BC=9A
>
> Sam Li <faithilikerun@gmail.com> writes:
>
> > Markus Armbruster <armbru@redhat.com> =E4=BA=8E2024=E5=B9=B42=E6=9C=881=
9=E6=97=A5=E5=91=A8=E4=B8=80 15:40=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> Sam Li <faithilikerun@gmail.com> writes:
> >>
> >> > Markus Armbruster <armbru@redhat.com> =E4=BA=8E2024=E5=B9=B42=E6=9C=
=8819=E6=97=A5=E5=91=A8=E4=B8=80 13:05=E5=86=99=E9=81=93=EF=BC=9A
> >> >>
> >> >> One more thing...
> >> >>
> >> >> Markus Armbruster <armbru@redhat.com> writes:
> >> >>
> >> >> > I apologize for the delayed review.
> >> >
> >> > No problems. Thanks for reviewing!
> >> >
> >> >> >
> >> >> > Sam Li <faithilikerun@gmail.com> writes:
> >> >> >
> >> >> >> To configure the zoned format feature on the qcow2 driver, it
> >> >> >> requires settings as: the device size, zone model, zone size,
> >> >> >> zone capacity, number of conventional zones, limits on zone
> >> >> >> resources (max append bytes, max open zones, and max_active_zone=
s).
> >> >> >>
> >> >> >> To create a qcow2 image with zoned format feature, use command l=
ike
> >> >> >> this:
> >> >> >> qemu-img create -f qcow2 zbc.qcow2 -o size=3D768M \
> >> >> >> -o zone.size=3D64M -o zone.capacity=3D64M -o zone.conventional_z=
ones=3D0 \
> >> >> >> -o zone.max_append_bytes=3D4096 -o zone.max_open_zones=3D6 \
> >> >> >> -o zone.max_active_zones=3D8 -o zone.mode=3Dhost-managed
> >> >> >>
> >> >> >> Signed-off-by: Sam Li <faithilikerun@gmail.com>
> >> >> >
> >> >> > [...]
> >> >> >
> >> >> >> diff --git a/qapi/block-core.json b/qapi/block-core.json
> >> >> >> index ca390c5700..e2e0ec21a5 100644
> >> >> >> --- a/qapi/block-core.json
> >> >> >> +++ b/qapi/block-core.json
> >> >> >> @@ -5038,6 +5038,67 @@
> >> >> >>  { 'enum': 'Qcow2CompressionType',
> >> >> >>    'data': [ 'zlib', { 'name': 'zstd', 'if': 'CONFIG_ZSTD' } ] }
> >> >> >>
> >> >> >> +##
> >> >> >> +# @Qcow2ZoneModel:
> >> >> >> +#
> >> >> >> +# Zoned device model used in qcow2 image file
> >> >> >> +#
> >> >> >> +# @host-managed: The host-managed model only allows sequential =
write over the
> >> >> >> +#     device zones.
> >> >> >> +#
> >> >> >> +# Since 8.2
> >> >> >> +##
> >> >> >> +{ 'enum': 'Qcow2ZoneModel',
> >> >> >> +  'data': [ 'host-managed'] }
> >> >> >> +
> >> >> >> +##
> >> >> >> +# @Qcow2ZoneHostManaged:
> >> >> >> +#
> >> >> >> +# The host-managed zone model.  It only allows sequential write=
s.
> >> >> >> +#
> >> >> >> +# @size: Total number of bytes within zones.
> >> >> >
> >> >> > Default?
> >> >
> >> > It should be set by users. No default value provided. If it's unset
> >> > then it is zero and an error will be returned.
> >>
> >> If the user must provide @size, why is it optional then?
> >
> > It is not optional when the zone model is host-managed. If it's
> > non-zoned, then we don't care about zone info. I am not sure how to
> > make it unoptional.
>
> We have:
>
>    blockdev-create argument @options of type BlockdevCreateOptions
>
>    BlockdevCreateOptions union branch @qcow2 of type
>    BlockdevCreateOptionsQcow2, union tag member is @driver
>
>    BlockdevCreateOptionsQcow2 optional member @zone of type
>    Qcow2ZoneCreateOptions, default not zoned
>
>    Qcow2ZoneCreateOptions union branch @host-managed of type
>    Qcow2ZoneHostManaged, union tag member is @mode
>
>    Qcow2ZoneHostManaged optional member @size of type size.
>
> Making this member @size mandatory means we must specify it when
> BlockdevCreateOptionsQcow2 member @zone is present and @zone's member
> @mode is "host-managed".  Feels right to me.  Am I missing anything?

That's right. And the checks when creating such an img can help do
that. It's not specified in the .json file directly.

>
> >>
> >> >> >
> >> >> >> +#
> >> >> >> +# @capacity: The number of usable logical blocks within zones
> >> >> >> +#     in bytes.  A zone capacity is always smaller or equal to =
the
> >> >> >> +#     zone size.
> >> >> >
> >> >> > Default?
> >> >
> >> > Same.
> >> >
> >> >> >
> >> >> >> +# @max-append-bytes: The maximal number of bytes of a zone
> >> >> >> +#     append request that can be issued to the device.  It must=
 be
> >> >> >> +#     512-byte aligned and less than the zone capacity.
> >> >> >
> >> >> > Default?
> >> >
> >> > Same.
> >> >
> >> > For those values, I guess it could be set when users provide no
> >> > information and still want a workable emulated zoned block device.
> >> >
> >> >> >
> >> >> >> +#
> >> >> >> +# Since 8.2
> >> >> >> +##
> >> >> >> +{ 'struct': 'Qcow2ZoneHostManaged',
> >> >> >> +  'data': { '*size':          'size',
> >> >> >> +            '*capacity':      'size',
> >> >> >> +            '*conventional-zones': 'uint32',
> >> >> >> +            '*max-open-zones':     'uint32',
> >> >> >> +            '*max-active-zones':   'uint32',
> >> >> >> +            '*max-append-bytes':   'size' } }
> >>
> >> [...]
> >>
>

