Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE7ACCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 21:33:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBgSL-0004hu-FU; Wed, 22 Oct 2025 17:33:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1vBgSK-0004hV-3U
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 17:33:16 -0400
Received: from mail-il1-x132.google.com ([2607:f8b0:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1vBgSH-000273-PC
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 17:33:15 -0400
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-430cadec5deso1512435ab.1
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 14:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761168792; x=1761773592; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fG3k6Uq6wWZo4Z/E448XTwRTL6/UCPVtSoj2zJoLxKI=;
 b=FRmCyUFdyAT0zwJtx/1p9TqLJbsD7Qipi82h4+9SOpo77Fe/BgOv1FIvNyUyNlgDni
 iqIqJCebofqn2tvR2PMDCok/NZ9RUiz1exdhHS09AhtwjwrX/LvsCppwA/zcOGJQRFad
 mhLLATJAA/hZWalPv34y2GgaEOXr/pYbivZg41/761OkNttqCAfnC2i4clRoQXyM4FRF
 gQLlV7CG0jRFdsWzK+qVoKWNiByYyic5rmqP/rBJGFuh2Mu7iVapCCeU+VaVmoiy9ar/
 ZyjGIhQsaoIPx6MWk6EdWxkFq2irkIa/icgOI525Ub01tufXh7CdXHSGj5TNIvwxHxKY
 0dUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761168792; x=1761773592;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fG3k6Uq6wWZo4Z/E448XTwRTL6/UCPVtSoj2zJoLxKI=;
 b=XNQANsKSrL8VunmR7bmwfyAXV5TTa5o6mgeACCryHyAc9B5Dgjms0cjxVJh2XpA19s
 lONsrfluyD0pr1/iaFUkg1T4jNrRSV0S+Vt1D+tSPlxRbBrXzzYrpvDnpPVPECZ/Shjh
 w5TcNr3/4SjORbCGsLWG1950aIq9pz3JnhO46uKrSUIXPC2d4gelcsa/oRpAPTVNld2m
 9oP/80IPs5gblPN13TI+hyE2sZMLacNCx4ZfElLZvV9rTX7BJTZVCvqip8XPH438dx0F
 VThXEZJy+gwOM15t9Qj4VaI0QBVK7W0qwJ1AAr+iuA1PUhTAdVRI8DwhxcrOIbdDpw2/
 3ucw==
X-Gm-Message-State: AOJu0YybKLTytwSW5ca1R2y6PVJkLzMBHuBwRgnh3XrGGVp5l7JLshvM
 or2kwW5Eo49Fe2tIdvWY2uvKcwo4sl/i8RL8INgIkjmw8zIfVI0auhTS1+88JaM8i8EjGRZ2F6k
 zM2Bq2AcFcmb7H/7/dOga5T//Nqy+ve0=
X-Gm-Gg: ASbGnctp3Zu5buU+r+pcEwu73ySdRfcNOAmfrvxXxm5+ZSWAhTJCjIXRJHL+X51Se4e
 fxS7w9KK4w271TDaYK9Xi2q5MZqUgjK902KvuemYhv62tNrDUSGzSapPZH1+MxUmw4wDYGZzVz6
 y/TzseAvVRe94V1Y0Tp2J0VifmZxpZZvAtxX9skevh1u8M8Zb69hITDPnG/GFGjfcMeopPFWazl
 AYBUhUpsb3/5SEZ+ToBqNEToXRCMbLmh4ZHUkhnaUcrCitX/zC7Gqf+Rj92F+kb5UzdLoE=
X-Google-Smtp-Source: AGHT+IEvz1XFKh1ZKVfr0BBFaUpoaqJfGeTZCGfj1DwSdy1qg5v8ZeSqXfnEzzuR+FT75bC6v+48k4V8rRgZ5OY/S7o=
X-Received: by 2002:a05:6e02:1a66:b0:430:bfbf:4e4a with SMTP id
 e9e14a558f8ab-430c527a5ddmr316215275ab.16.1761168791866; Wed, 22 Oct 2025
 14:33:11 -0700 (PDT)
MIME-Version: 1.0
References: <20251020054413.2614932-1-dtalexundeer@yandex-team.ru>
 <CAFubqFsiEGHP1Py78VapGvPBi1rpGWZcRbb8Li-QvWhbRGYDiA@mail.gmail.com>
 <453ec8f4-fbda-4411-a02c-5d30429d7083@yandex-team.ru>
In-Reply-To: <453ec8f4-fbda-4411-a02c-5d30429d7083@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Wed, 22 Oct 2025 17:33:00 -0400
X-Gm-Features: AS18NWAT2jASwmf3FVChqat1SYEf43_OdmMkWVPM3MfCkOom6AWmJ_OOYyz-0Q0
Message-ID: <CAFubqFsFPoa5xuP1Pd=hhY1bo5vhLL4chhEpfVn3VxhR_SnZEQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] vhost-user-blk: support inflight migration
To: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Cc: qemu-devel@nongnu.org, Raphael Norwitz <raphael@enfabrica.net>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::132;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-il1-x132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Oct 22, 2025 at 3:59=E2=80=AFAM Alexandr Moshkov
<dtalexundeer@yandex-team.ru> wrote:
>
> Hi!
>
> On 10/21/25 23:54, Raphael Norwitz wrote:
>
> The logic looks ok from the vhost-user-blk side but some comments inline.
>
> On Mon, Oct 20, 2025 at 1:47=E2=80=AFAM Alexandr Moshkov
> <dtalexundeer@yandex-team.ru> wrote:
>
> Hi!
>
> During inter-host migration, waiting for disk requests to be drained
> in the vhost-user backend can incur significant downtime.
>
> This can be avoided if QEMU migrates the inflight region in vhost-user-bl=
k.
> Thus, during the qemu migration, the vhost-user backend can cancel all in=
flight requests and
> then, after migration, they will be executed on another host.
>
> At first, I tried to implement migration for all vhost-user devices that =
support inflight at once,
> but this would require a lot of changes both in vhost-user-blk (to transf=
er it to the base class) and
> in the vhost-user-base base class (inflight implementation and remodeling=
 + a large refactor).
>
> Even if it's a more significant change I'd rather generalize as much
> logic as possible and expose it as a vhost-user protocol feature. IMO
> too much vhost-user device-agnositic code is being pushed into
> vhost-user-blk.
>
> As far as I understand (correct me if I'm wrong), but this feature must b=
e implemented in device itself (along with inflight field location) or in s=
ome base class for vhost-user devices. For now vhost-user-blk doesn't have =
one yet. The closest base class that i could find is vhost-user-base, but f=
or using it, it has to implement all device-agnostic code from vhost-user-b=
lk, and don't break all existing vhost-user-base derived devices. For examp=
le, to support inflight migration in base class, there first need to implem=
ent inflight field in it, along with the reconnect feature. Then, with a bi=
g refactor, somehow inherit vhost-user-blk from it, along with other device=
s such as vhost-user-fs.
>
> So, IMO it looks like a whole separate track that will need to be tackled=
.
>

I get that inflight is inside of struct VhostUserBlk, not in struct
vhost_user. Even if not all device types support inflight I think that
could probably be changed? If we do keep things as you have it here
patch 1 should probably bring the vhost_dev_load_inflight() and
vhost_dev_save_inflight() into vhost_user.c rather than vhost.c since
only vhost_user devices seem to use inflight.

> As Markus noted this also conflicts significantly with Vladimir's
> series so I'd suggest waiting until those are in, or possibly
> attempting to generalize on top of his changes.
>
> Yea, but i think, i just need to perform inflight migration only when som=
e non-local migration flag is set.
>

I'm not sure about that. While it may be completely safe in your case
to avoid GET_VRING_BASE/quiescing the backend, it could introduce
corruption cases on other vhost-user-blk storage backends which work
differently. I think this would require an "opt-in" migration
parameter over and above checking that it's not a local migration.

Ideally there would be some way to have the vhost-user backends expose
support per device with a protocol feature and, if the source and
destination both advertise support, we perform the inflight migration
skipping GET_VRING_BASE. I don't know enough about the migration code
to know how that would be done or if it is practical.

Also (and I think this also applies to Vladimir's series), it should
be possible to add multiple vhost-user-blk devices to the same Qemu
instance but have the devices backed by very different backend
implementations. What happens if some of those backend implementations
support things like lightweight local migration and/or inflight
migration but others don't? Ideally you would want the API to be able
to select target vhost-user-blk devices for accelerated migration
rather than assuming they will all want to use the same features. I
don't know if anyone is doing that or if we care about such cases but
I just want to throw the concern out there.

> And i think, Vladimir's series already have that flag.
>
>
> Thanks for the comments!

