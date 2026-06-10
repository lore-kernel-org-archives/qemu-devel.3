Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD205CD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:23:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLf9-0008Ol-N9; Wed, 10 Jun 2026 12:20:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1wXLf7-0008L6-BW
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:20:18 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1wXLf5-0002vX-Ol
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:20:17 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2c0c2a68d01so47084295ad.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:20:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781108414; cv=none;
 d=google.com; s=arc-20240605;
 b=alf3PuiJ0oAXeP2/8Xpfh71HZ6UFR8lPs+j+FbPXmn5JE9NeM8QXy+Ia1w7NK3FUW8
 apEP9VRnLQSUXiTKJVBXsqASa7kDjdbS/3+TYZMx/8YiConvFVUfTlFOjBMy5n8dL06U
 kEG6T6djR7ROlPd8bwk1Z+PKsKm8NezD1cBNJdqiH07P33ghbWjawrpWDpGHXI5/BT7T
 tB+784A23n0ZsLmEUqAVOgo43m65f5Xz17pDN/xAueqwNkOF1k+E8YH7xwbWWxghhtfr
 QEF3oCXmc1wgV4rex2C+HApyL1Qo44swz97Yz5kKDAeCfUrqk0ZVq0cNZKheCIvDMqDJ
 1oPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+xO/2NRLzNcs6sdLxEWN6LoFasKv0n2MeVQbqgQY9FU=;
 fh=r6UoY7UuKJ04V6juxpFT9n9+09wmYwpKZede0we4tNc=;
 b=QR6tBHmuQjZFSOcwxHitJdIiS0RKmSp2n+J9Ir/muMcYlU5YL1otU46fwo1O2xvGlk
 09SvejVv2Wx34Jnt8siffer1l/oRDu37SHQM7y9ZBzJ0wlhoOKCe0TDcBUa+OIfLgTUG
 jIXQrE20En79CvMOo6oOjWLFxs0knul/AayuVBWIjcdLQJneuMLGEpjEKsBiVW3YhNe2
 WaZJFqkQINQ++vb2GshT54sevgr1K52/CUJd3rImwzVgmfxBwbbOnVgeYYRj8C4w5ph5
 JE5vkcb7UHnL5HVrcttcYHYyI3Mpi969ug9bfx0m88XtpKyiw9i+H8LQHG48SWfHdKLv
 vE9A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781108414; x=1781713214; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+xO/2NRLzNcs6sdLxEWN6LoFasKv0n2MeVQbqgQY9FU=;
 b=hR3f1wPAdnFHwFPjUPADXo2RMUJgv85xxUtu7ojth1WcmjJgOkgncu1oCLifT55cBX
 y9FcLHY7sMU6oOxBuT7U6zjJxc05OE0LlaWGn6MGG119d1DCksA1r4uIwByyfI4qXVW0
 lvpalXlYn/uxzRnHt/Za1gfKHjqbg2KFvigSW42UC2t8GomnnYNZS6CY61Yu0zGVLYZR
 AUA/y0RYpXwHXc+tW55VI2qWkscTmSTAJat0dwadbkb+nfWuJpTbxoLLr41A3I/dcliv
 Yw4RxjvqULTHvnpEX5ZTY5VxEX2p69S7bdUKAMBetjC4Xl761GkRxwon9OMXkx00FH7K
 PDCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781108414; x=1781713214;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+xO/2NRLzNcs6sdLxEWN6LoFasKv0n2MeVQbqgQY9FU=;
 b=VAOR7cPClVojKPPR+fVGN//AtgOzwQMlmeA30PDMEKni8eZsj1+gXCaFIO96vpZwtZ
 2NQxdNpf3vgaSoTB+MHHItCdDGbt4tgu68YfOR44Y+oTK4UrvZAbT3l5RT/QejfeSGwx
 HP6HnhZOAVpDzs4WIh0HC9+RXBhOfHJxSM+8XDzAZoWHKh9Bw9nZeK4IgYNZS329SBg5
 bA6+JYhqs2+9yamIxqFAp2x4RMATK6z57XRf1zuKkBKHUnLBE9cTHmFKee5T6PU8zR8K
 AdUksGFxThuw/epMpzQ3IjWIwKtyTepdm/HXyv8m/ePC+QkGarkOs3cA1su161GgyvXK
 gfmw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8axnCIV6lYdHjnuNBjJLB/2S4eskSTyFCmIK3hOLwarB4LvNjPHX4PeimGYq6WXUZmt6UqM/8Z4dO/@nongnu.org
X-Gm-Message-State: AOJu0YztWTxt4Fso5uZdH2Ywemz4Vb2SjLKkqswGMMcJRBxuUDDeP44M
 VNqAxf3ZQqOjHhglStXdSs30MFb2JspuuEJ7QfktVyvyec8R1avP8QLMP/fD2ga1uUHTcsJUrRb
 Gl+ZZfamLKpD/cHDDUC3rnipNjddyV8U=
X-Gm-Gg: Acq92OFVnaMVlMTFP9+FbEVg/70Rm8iD95A7CGHz6WdgdhQ3XYoKH85jfoPwcaQDm6P
 hJQxHCdJMbtbulp6TvgTL3haBtWlOLecEKSf+5uRcVLthye5I17pyT/KspTb0+NlHxTCfTK+AZy
 dUkbO5r8v057LEW0lDVOveV1C1TTZ2KGENMnbl+nplhtHhXnx0ksc3y2Fgx930q0LMhjfbcZOUe
 HS+V+UTyNFYNPL6A87XRMbQ7kVAzvd8lPBTowJVAyoEHz8aUa9U3P0phtvt/2AlB334qR9rs6LC
 U/EOHw1/uG+pIJ2Tn+AgGU1BGFix7ihC93if4IL6rRa8GH/orHE7s6R9f4F4mS9EJFN35Ot9Lf2
 1b8cnT1JD
X-Received: by 2002:a17:902:f24d:b0:2c0:d9b7:b7b0 with SMTP id
 d9443c01a7336-2c1e8220afbmr195760645ad.31.1781108413706; Wed, 10 Jun 2026
 09:20:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260601214405.252818-1-faithilikerun@gmail.com>
 <20260601214405.252818-4-faithilikerun@gmail.com>
 <20260603204150.GD78072@fedora>
 <aiauw3nKDRHXJESV@ryzen> <20260609160112.GD57581@fedora>
In-Reply-To: <20260609160112.GD57581@fedora>
From: Sam Li <faithilikerun@gmail.com>
Date: Wed, 10 Jun 2026 18:19:47 +0200
X-Gm-Features: AVVi8CeuXQEb2jf9oOS8CC8ma3qoAKunZSdvO5EWuYC_J32BJ1WX40IeK2F-jPI
Message-ID: <CAAAx-8JMZxMbxa0_ACJLW8kiqEZizJcjiKbgskHuXXyS0tixMg@mail.gmail.com>
Subject: Re: [PATCH v11 3/5] virtio-blk: do not merge writes across a zone
 boundary
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Niklas Cassel <cassel@kernel.org>, qemu-devel@nongnu.org, 
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 Eric Blake <eblake@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, dmitry.fomichev@wdc.com, 
 Hanna Reitz <hreitz@redhat.com>, hare@suse.de,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, dlemoal@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=faithilikerun@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Jun 9, 2026 at 6:01=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.com=
> wrote:
>
> On Mon, Jun 08, 2026 at 02:00:03PM +0200, Niklas Cassel wrote:
> > Hello Stefan,
> >
> > On Wed, Jun 03, 2026 at 04:41:50PM -0400, Stefan Hajnoczi wrote:
> > > On Mon, Jun 01, 2026 at 11:44:03PM +0200, Sam Li wrote:
> > > > diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> > > > index 9cb9f1fb2b..285db19ac7 100644
> > > > --- a/hw/block/virtio-blk.c
> > > > +++ b/hw/block/virtio-blk.c
> > > > @@ -303,17 +306,34 @@ static void virtio_blk_submit_multireq(VirtIO=
Block *s, MultiReqBuffer *mrb)
> > > >      for (i =3D 0; i < mrb->num_reqs; i++) {
> > > >          VirtIOBlockReq *req =3D mrb->reqs[i];
> > > >          if (num_reqs > 0) {
> > > > +            zone_cross =3D false;
> > > > +
> > > > +            /*
> > > > +             * On zoned backends, a single backend write must not =
span a zone
> > >
> > > This code handles both reads and writes but the comment only mentions
> > > writes. I think reads are allowed to span zones, so should there be a
> > > check that mrb->is_write?
> >
> > From the Virtual I/O Device (VIRTIO) Version 1.4 specification:
> >
> > "If a VIRTIO_BLK_T_ZONE_APPEND request, a VIRTIO_BLK_T_IN request or a
> > VIRTIO_BLK_T_OUT request issued to a SWR zone has the range that has
> > sectors in more than one zone, then the request SHALL be completed with
> > VIRTIO_BLK_S_ZONE_INVALID_CMD value in the field status."
> >
> >
> > Thus, while this is allowed to read past the zone boundary in many zone=
d
> > specifications, e.g. in both ZAC and ZBC, when the "Read Across Zone
> > Boundaries bit" is set, is seems like it is never allowed to do so in
> > VIRTIO.
>
> Hi Niklas,
> Thanks for pointing this out. So no change is needed here.
>
> I noticed that NVMe has a Read Across Zone Boundaries bit to indicate
> whether or not this is allowed. virtio-blk could add a feature bit to
> offer the same functionality in the future. This would come in handy if
> existing applications depend on reading across zones.

Sounds like a good addition to the persistent metadata for ZNS emulation se=
ries?

Sam

