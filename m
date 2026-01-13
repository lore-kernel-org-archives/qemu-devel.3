Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11955D0C858
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 11:26:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfcWw-0002B5-Bz; Tue, 13 Jan 2026 06:25:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vfcWq-00028L-9X
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 06:25:40 -0500
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vfcWo-0002D5-AH
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 06:25:40 -0500
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-4f1ab2ea5c1so109505381cf.3
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 03:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768303537; x=1768908337; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TVJG7sEA2lMPAZUrUyABe8aQn/DMbGyOfhTO3YkvPWw=;
 b=jLW80mkQ/Ib57bBsu404tK7scmEnopz7ubQOJk9d1sefiRp8wpe6iFYwIL85GZXynX
 btrsY6Imc2FvUzhl/bxQyV2vprucMPHG/1bRzO+BExXKjNqY9ah+DLiaMScgaDy/m3uf
 0GvFq9GDQyAIEjBFM7wt/yavDHurlOAO1EEF4aPdpwswm3Cf88XquNJAqEjC6rOsvGd6
 S+peLZ+mRThoiLi/7JyH1/8EDxChPpUNcVHHGPqIz39kX6a0eVOOInhUrCV1fLenC3GD
 iNwAdVUn8iWxT1ZFedxMn4OSo2D2K3BWfsA8nH0SGclg/Bu8RQlZZrFMQQQneLUoNkpw
 JfPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768303537; x=1768908337;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TVJG7sEA2lMPAZUrUyABe8aQn/DMbGyOfhTO3YkvPWw=;
 b=wD5U2DM0+IaUAozoGAX7d+X+AdBiesuZIvciUSaNYwwsMV9S5AdTZatZOcgjEHYlOw
 KIqJMPD838ZQKrlBC70Teaq+9P0EcZduV9WPlUnKqIbOIDeARpAXul2bb9PAa1pj3xRX
 SOnaoYBqqzZzJFCsYygyEJN2lo/ryRPt4058XweGKmz3yk1dt92E3/gmivLwpu98pQtb
 f3jtf/6GNRjUYhBu/9Oya7pFdwOSXxn7r0BRw8roc3VcWniYD/7RakFKckwG3Eb9kLWi
 wzm5s8h2xhq0/Mt6rG1WD/vtZ4MuiaWh9pP/mCazPcycZF9xGKhzGHz6GSXsqvDHcavw
 8afA==
X-Gm-Message-State: AOJu0YwExF4jfqJjYp47qlrU6LiNMTvE2qjY42Oy2oz6tDJY+mb+7F1V
 rVPXON1Fh7fo0qBb6w5ioDTTCZvcDjZG+uBXMHosz0K/ieZ6ppYcJhtqXc270jYLnrIhkbJKXNn
 dGjou+FBPvGc8/yys+FYWdHb2Jek6mWQ=
X-Gm-Gg: AY/fxX6HyjXGbY7dMQsJ50wHXFhNJ5WkcKWvWCdy8p5jTlmWclr/grD1apuFbZ0WEr6
 UzKyaUAGO3b3erKxTEsWLJuoQ6fB4zGa/gppJ91iMv+ylkqG86RUWYG0ze9PVcMGP+fP2fbpw8P
 o81SgO42nxteidO6joxUgEoo5C0ZUeQQUppdh2h66LTQ4fxRiJj+BjtYY0T3k3+IkdRrW5S/PZq
 Q20iDt3YcD3Kpn8ymnnGLxbmVLa1mTjfWBnbHc4ogPHDjeUJbIiYQQ+yQQbuLPEN0/IpOf9MOUf
 IVRBF1KPN8M/eOXOuQdgs0dBDq4=
X-Google-Smtp-Source: AGHT+IEFsAvQxfeQGvBm1bbmabKu97NhBoADA6vHgW+NBDo3AAVMEp5nMmwNAwCR0/8beuerCe77cI+BFeswEvei3s0=
X-Received: by 2002:a05:622a:2489:b0:4ed:dec2:301a with SMTP id
 d75a77b69052e-4ffb484a72emr310703771cf.16.1768303536768; Tue, 13 Jan 2026
 03:25:36 -0800 (PST)
MIME-Version: 1.0
References: <20260112104454.54225-1-f.ebner@proxmox.com>
 <CAMxuvaz0AKCcO=nWUc_U39wcdHn0w_3N8WDncT0Fbc7aWM=nAQ@mail.gmail.com>
 <bf18287e-0f32-4138-95cd-5a7517ec7854@proxmox.com>
In-Reply-To: <bf18287e-0f32-4138-95cd-5a7517ec7854@proxmox.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 13 Jan 2026 15:25:25 +0400
X-Gm-Features: AZwV_Qin-N6sGPK8KBpAJzr17xddQgQcdNb8C433ltpzAQFv03vW8WEkZNPG6iM
Message-ID: <CAJ+F1CLB6wV2qd+ad5Cw2wG+fFFdKYSYGHcDi0SJXkVJxEaowA@mail.gmail.com>
Subject: Re: [PATCH] ui/vdagent: add migration blocker when machine version <
 10.1
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, eduardo@habkost.net, 
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com, 
 zhao1.liu@intel.com, peterx@redhat.com, farosas@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::834;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x834.google.com
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

Hi

On Tue, Jan 13, 2026 at 3:21=E2=80=AFPM Fiona Ebner <f.ebner@proxmox.com> w=
rote:
>
> Hi Marc-Andr=C3=A9,
>
> Am 13.01.26 um 8:39 AM schrieb Marc-Andr=C3=A9 Lureau:
> > Hi Fiona
> >
> > On Mon, Jan 12, 2026 at 2:51=E2=80=AFPM Fiona Ebner <f.ebner@proxmox.co=
m
> > <mailto:f.ebner@proxmox.com>> wrote:
> >
> >     In QEMU 10.1, commit 5d56bff11e ("ui/vdagent: add migration support=
")
> >     added migration support for the vdagent chardev and commit 42000e00=
13
> >     ("ui/vdagent: remove migration blocker") removed the migration
> >     blocker. No compat for older machine versions was added, so migrati=
on
> >     with pre-10.1 machine version, from a 10.1 binary to a pre-10.1 bin=
ary
> >     will result in a failure when loading the VM state in the target
> >     instance:
> >
> >
> > But you can migrate a pre-10.1 machine with the new binary.
>
> True, but I think it violates what a machine version is supposed to
> encapsulate. If a QEMU binary supports a given machine version, it
> should be able to load migration streams originating from other, newer
> QEMU binaries when the same machine version and commandline is used, or?
>
> >
> >
> >     > Unknown savevm section or instance 'vdagent' 0. Make sure that yo=
ur
> >     > current VM setup matches your saved VM setup, including any
> >     > hotplugged devices
> >
> >     Add a compat flag to block migration when the machine version is le=
ss
> >     than 10.1 to avoid this.
> >
> >
> > I am not sure this is the right way to handle this. There is already
> > this error when migrating to an older qemu, I am not sure we have to
> > block earlier and prevent the above case.
>
> I would consider this an internal/unexpected error. I feel like it
> should not occur if the VM was started with the exact same commandline
> on source and target, but currently, it can. It happens at the very end
> of migration when the source is already in post-migrate state, which is
> not nice for users/management layer.
>
> >
> >
> >
> >     Cc: qemu-stable@nongnu.org <mailto:qemu-stable@nongnu.org>
> >     Fixes: 42000e0013 ("ui/vdagent: remove migration blocker")
> >     Signed-off-by: Fiona Ebner <f.ebner@proxmox.com
> >     <mailto:f.ebner@proxmox.com>>
> >     ---
> >      hw/core/machine.c |  1 +
> >      ui/vdagent.c      | 46 +++++++++++++++++++++++++++++++++++++++++++=
+++
> >      2 files changed, 47 insertions(+)
> >
> >     diff --git a/hw/core/machine.c b/hw/core/machine.c
> >     index 6411e68856..9a5241ce17 100644
> >     --- a/hw/core/machine.c
> >     +++ b/hw/core/machine.c
> >     @@ -55,6 +55,7 @@ GlobalProperty hw_compat_10_0[] =3D {
> >          { "vfio-pci", "x-migration-load-config-after-iter", "off" },
> >          { "ramfb", "use-legacy-x86-rom", "true"},
> >          { "vfio-pci-nohotplug", "use-legacy-x86-rom", "true" },
> >     +    { "chardev-qemu-vdagent", "x-migration-blocked", "true" },
> >
> >
> > Is there a precedent where such compat property was added to block
> > migration?
>
> There are several ones where migration is turned off for a device or
> certain properties, e.g.
> { "ramfb", "x-migrate", "off" } for 8.1
> { "pl011", "migrate-clk", "off" } for 5.1
> which is not quite the same, but I'd still argue:
>
> I guess those properties were not migrated, so compatibility means still
> not migrating those for older machine version. For the vdagent chardev,
> the previous behavior was blocking migration, so compatibility means
> still blocking migration for older machine versions. Or does that not
> make sense?


Makes sense, I actually wrote that ramfb x-migrate and nobody
complained about that behaviour:

commit a1e88d2d2b89ad6371036aa07f7e96947786c873
Author: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Date:   Mon Oct 9 10:32:46 2023 +0400

    ramfb-standalone: add migration support

    Add a "ramfb-dev" section whenever "x-migrate" is turned on. Turn it of=
f
    by default on machines <=3D 8.1 for compatibility reasons.

    Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
    Reviewed-by: Laszlo Ersek <lersek@redhat.com>
    Acked-by: Gerd Hoffmann <kraxel@redhat.com>
    Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>

So let's take the same approach for qemu-vdagent

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

--=20
Marc-Andr=C3=A9 Lureau

