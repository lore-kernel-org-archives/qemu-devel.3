Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B41CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 15:07:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHO3b-0002Hj-50; Fri, 07 Nov 2025 10:07:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1vHO3W-0002H6-Vq
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 10:07:14 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1vHO3U-0004Ul-RV
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 10:07:14 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-64124874e6dso142076a12.3
 for <qemu-devel@nongnu.org>; Fri, 07 Nov 2025 07:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ionos.com; s=google; t=1762528029; x=1763132829; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0JJwupwRF+cr+b1FUuaStgPmA3yH9/l/xxsmiHeQjLk=;
 b=AFfUfGnQP/z8COCIl7PHSJ8/Rfzkn0Sjhc1PxKOpqK3EUFlW4oe9xuRU1a/pHer0GH
 J29clMF5SMU9DX/54fbEMFAVRq3UGOKcXt8WuOHhm9Tm4v5VoxevKQVOUoOErpExiZ6l
 J1PkJ8SWTeKIOwgXTVllgSMZJjBHr+ibHvPhXPbjCQcKujthn4d4XbiLBmB/2QPsaujO
 ZASNnklcgu9W9PaPNhTNjUkGLUDSjqDcNBXeYWLvG6tf063bQRmhfQ6RbU3uAzJZjNWu
 Sy/Dy3lblMpRrfcYG8RW5XNvQMkTzd5yi3k4ZAQyZzJ4JoWdqIEtYRGwjyb37Ypml893
 U+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762528029; x=1763132829;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0JJwupwRF+cr+b1FUuaStgPmA3yH9/l/xxsmiHeQjLk=;
 b=Q9CeqH+2chwi6xKxsahwo+HVYIAqsHb1IUnut7hj81P0loDK0iSc9kaewVyNHpz5yo
 5ZdVk0Hv8pm9qtWeceCZiH81tSurudzxI9rVQfV8DFJH9/UXvjw5x+XdcZzGG2gmlkDG
 PjBcutRgdz/Vc5qPpRt3xCx8GMvuXYu47XpFmMk0dg2YGYIuBGShYp4BFM+fYyU1NioE
 TOh3OU8uP/14OQwNcD8os/saoxIiHghDkEMeK8/TsEAagVz54OSca3jnVwpq29izyIWz
 Zp6nTHX2Ro8aHeXD305hu0xx9OsoAyPpKOuH+pjDDLzQLsz1ww22FXFT9soZd/Fu7swS
 LY4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQYAE73XyPf6bjdC7HS1s9gGAWKLICD6HbLAtpXgvSGdqzZbSyYiHUmNUhG1c8YgfKZbbBSLFWWQRU@nongnu.org
X-Gm-Message-State: AOJu0YyPvclyM7f3IOVUtgrw9rM2Qm6qh5XW6PwSN2+smx+Qlrh5eTSl
 DLNLuenmXm0lyjbvDwk4gjb1gbUffzDGZJuleLZfKMqDnuJKhLba6Zs69m9F1q4onfAJTtrWNjc
 U/37wtLC//IXKyJuzRxvDnWQ9ZzTzFGPWMaqyGa0bFA==
X-Gm-Gg: ASbGncv550NZyTA+KUbqDtMatqTldJgsBeomvwaJXfEXu7Z3FZ5KPD21QogcrR1DjDy
 NFNY9P2CQOSTsBhSlIWuYa06Px67a5DldDl6CPTQAv5O8gWO7O41K4Q2EeAxojdmpO9FsnF8do9
 Q9rbruMStfqvuLg+M6Y9+eH4P4z7k5c1tGwMx4TXKOCzj5YiB2AHQwyARlRcvgoYN4wdinThlqo
 1VNipki+tSeSvsOuoHsOpjPc2H/8WKn4wYoD6+/Bj7aXsKRnyDVrbmSBrWsrjzKK7OIGqX9s/Jd
 2KdalECmmmXDAIN2e5dBpdqLtlxF
X-Google-Smtp-Source: AGHT+IEkggfSE0etbYGoP9N5n6fxV6MlEap3K5scHnznJQJ+6rZ6wrMIBTCcylnYfnORJe5uDJTUFqzyNwD1bNEOMCA=
X-Received: by 2002:a05:6402:50cb:b0:641:103:e632 with SMTP id
 4fb4d7f45d1cf-6413f1f39fcmr1855953a12.4.1762528029429; Fri, 07 Nov 2025
 07:07:09 -0800 (PST)
MIME-Version: 1.0
References: <CAMGffE=cZ_TgG=Ae+oVE+emWwuDNssozKNDsidS1+yTrh=cZXQ@mail.gmail.com>
 <CACGkMEtUx0PigJrJSWY8n2N7+znc02aqotNq+Y5w3aOMOvUvjQ@mail.gmail.com>
 <CAMGffE=cqr1awRmhAMg3V82_g1-2aM36oV+hWPuczs6VUCQkgw@mail.gmail.com>
 <aQvM6l04VeZwbUOf@x1.local>
 <CAMGffE=VdsQSTOOpBvaDc=RQ98cMDHYemF7nS5pnqJ7Rsvafug@mail.gmail.com>
 <CACGkMEtMK1_QJM7x33sLO-QOtdttV=8hBfH8YbYSB_-GDE6CTg@mail.gmail.com>
In-Reply-To: <CACGkMEtMK1_QJM7x33sLO-QOtdttV=8hBfH8YbYSB_-GDE6CTg@mail.gmail.com>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Fri, 7 Nov 2025 16:06:57 +0100
X-Gm-Features: AWmQ_bkPOwz4D9aHbFY_YTK6zHcwKA8xQw4bh9Mh1ahWOoV3lR5jT_mcP_onOQs
Message-ID: <CAMGffE=Z=tRJG9knPURmPDHtANQa5szysXvpmpes57f2C228Og@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BBUG=5D_Migration_failure_between_QEMU_9=2E2=2E4_=E2=86=92_8?=
 =?UTF-8?Q?=2E2=2E10_due_to_virtio=2Dnet_feature_mismatch_=28VIRTIO=5FF=5FRING=5FRESE?=
 =?UTF-8?Q?T_=2F_USO_features=29?=
To: Jason Wang <jasowang@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 qemu-stable@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Yu Zhang <yu.zhang@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=2a00:1450:4864:20::534;
 envelope-from=jinpu.wang@ionos.com; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

Hi Jason,

On Fri, Nov 7, 2025 at 2:02=E2=80=AFAM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Thu, Nov 6, 2025 at 10:28=E2=80=AFPM Jinpu Wang <jinpu.wang@ionos.com>=
 wrote:
> >
> > Hi Peter,
> > On Wed, Nov 5, 2025 at 11:17=E2=80=AFPM Peter Xu <peterx@redhat.com> wr=
ote:
> > >
> > > On Wed, Nov 05, 2025 at 10:27:59AM +0100, Jinpu Wang wrote:
> > > > > > These are not present (or not supported) on QEMU 8.2.10, which =
causes
> > > > > > the migration state load to fail.
> > > > >
> > > > > Interesting, we've already done the compat work:
> > > > >
> > > > > GlobalProperty hw_compat_8_1[] =3D {
> > > > >     { TYPE_PCI_BRIDGE, "x-pci-express-writeable-slt-bug", "true" =
},
> > > > >     { "ramfb", "x-migrate", "off" },
> > > > >     { "vfio-pci-nohotplug", "x-ramfb-migrate", "off" },
> > > > >     { "igb", "x-pcie-flr-init", "off" },
> > > > >     { TYPE_VIRTIO_NET, "host_uso", "off"},
> > > > >     { TYPE_VIRTIO_NET, "guest_uso4", "off"},
> > > > >     { TYPE_VIRTIO_NET, "guest_uso6", "off"},
> > > > > };
> > > > > const size_t hw_compat_8_1_len =3D G_N_ELEMENTS(hw_compat_8_1);
> > > > Yeah, I noticed the same.
> > >
> > > AFAICT, this is a known issue..
> > >
> > > Thomas and I used to suggest we should not turn on USO* by default by
> > > probing kernel, but only allow user choosing it explicitly in a VM
> > > setup. IOW, dest qemu should stop booting at all when kernel is too o=
ld
> > > (when user chose the feature).
> > I feel this is the approach we should have picked.
> > >
> > > See:
> > >
> > > https://lore.kernel.org/all/ZqQNKZ9_OPhDq2AK@x1n/
> > Is there any effort to allow migration from new OS support the USO
> > features to old OS doesn't support it?
>
> You can teach your management to disable USO via the qemu command line.

I added "host_uso=3Dfalse,guest_uso4=3Dfalse,guest_uso6=3Dfalse" for -devic=
e
virtio-net-pci
But migration still fails with slightly different error:
char device redirected to /dev/pts/1 (label charserial0)
2025-11-07T15:00:45.528098Z qemu-8.2: Features 0x10130afffa7
unsupported. Allowed features: 0x179bfffe7
2025-11-07T15:00:45.528245Z qemu-8.2: Failed to load virtio-net:virtio
2025-11-07T15:00:45.528253Z qemu-8.2: error while loading state for
instance 0x0 of device '0000:00:02.0:06.0/virtio-net'

I suppose it is VIRTIO_F_RING_RESET?
Any idea? I didn't find option to disable it
>
> > Any hint to make it work?
>
> Thanks

Thx!
>
> > >
> > > Thanks,
> > >
> > > --
> > > Peter Xu
> > >
> > Thx for the help.
> >
>

