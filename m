Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E017BC3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 14:43:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZAXq-0001Ga-PJ; Wed, 31 Jul 2024 10:43:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1sZAXo-00019F-Mw
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 10:43:12 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1sZAXm-0004Qa-KI
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 10:43:12 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5d5af7ae388so525338eaf.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 07:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722436988; x=1723041788; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AcbSoOBB4zsBd7C3R6ZBHOIVYaklvGZLq5eMHix/yHY=;
 b=mykR8GRUdcp8CdoeI2jjzHs5i6CwP5BngHtT6xc3PZhSQrVXjatkleR9IZZde2UcGm
 hZf5EIoP5AIIJOVx0tfG2B+gJFtvxhy0YpkPt+bgl7unzThu1rG8Hen/Dkcxy79Q/lke
 gPj5Q2wPy7JsP9uaRqtAH/b/UYA73HQ0Wl3aEPhpZAGWFTBuF0YTryQl9grRQQt8X7qY
 jjfEyjWE4bnkD5ye2LPb0BX7lhbWeIVBBsncXK1/EwZGJ3pbvQ8xeVd7B8+eJsnR6A4h
 P3gZG+W5NrodrkUsbLqG9yKtZTQ9kcoDK8bYj9zigUAqcNSJtjCG9CCyULD+rIcSck4g
 /BBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722436988; x=1723041788;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AcbSoOBB4zsBd7C3R6ZBHOIVYaklvGZLq5eMHix/yHY=;
 b=Tc1Ap34NHE3xRlJqi2hG9WmTSMVDpIO5OX6pZfwnDxfpvaujjdufOCBMJhA3OzsqcO
 O1BusQcrjX8nme2QXdDzgpEYrSlDAZQLVRGSO9pOY4y6+CszsiRfhEH4kdVqxWpa0GzD
 JjHbCakBZi3NnkeBWXRvKZ75Mx1vcmIKGQs3VY6DNRlpHvN0nSNO/zNwDOiurMewJMCw
 SDd1T5IU51b0HoehMxTm8cEG2E2gPxdaEKoIJgih/xv+nCxV3chAH6PCaTfJwgX9sEYO
 1WewKjCtr9fhUY7Tw8C6sfNZY0fBBlXl4Td7SNbkCf9541v2jg3I/u6xjYZAEQs7ZIJE
 eTIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXP7Lv44Jxiz4DEFn42pv6ZnNU29A7mX/hi+fPg7eSWhfoC8VDSWAW8bktOQR5ABpvc3sPeEU8yL3UUA1+gzjI6pS1NgTc=
X-Gm-Message-State: AOJu0YyqUQPoYTYXumj+bSW2EZROQsWCcp6wR+SGdKwx8k87BzzkStf7
 Nwa5vGE+YftlNSMuYMJIro4Is60k0QfrDfLccvyqO/Ixl1aSS4BlmuzkLNKsxNqBSc+T8HFooFP
 s98T4IiRTvUPbeczbFAkOuG5zQig=
X-Google-Smtp-Source: AGHT+IFt5A3lOWQZ07oGEGRPecfQfj8+TmHwFw6brqATQtmHjGipKXeAc2hleBcGh4kx5RLzYZscBnnUF2NYYME5Bps=
X-Received: by 2002:a05:6870:8a0e:b0:258:3455:4b2f with SMTP id
 586e51a60fabf-26822e30336mr2684384fac.17.1722436988499; Wed, 31 Jul 2024
 07:43:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240708143027.480821-1-stefanha@redhat.com>
 <87ttgyd4j9.fsf@pond.sub.org> <ZqpCinmDOyKuzJnO@angien.pipo.sk>
In-Reply-To: <ZqpCinmDOyKuzJnO@angien.pipo.sk>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 31 Jul 2024 10:42:55 -0400
Message-ID: <CAJSP0QXFMawAu7u+gEzp+j7RHQHqDrztgwj_xDFKLd2j7gF6Jw@mail.gmail.com>
Subject: Re: [PATCH] qdev-monitor: QAPIfy QMP device_add
To: Peter Krempa <pkrempa@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc2b.google.com
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

On Wed, 31 Jul 2024 at 09:59, Peter Krempa <pkrempa@redhat.com> wrote:
>
> On Tue, Jul 09, 2024 at 16:27:22 +0200, Markus Armbruster wrote:
> > Stefan Hajnoczi <stefanha@redhat.com> writes:
> >
> > > The QMP device_add monitor command converts the QDict arguments to
> > > QemuOpts and then back again to QDict. This process only supports sca=
lar
> > > types. Device properties like virtio-blk-pci's iothread-vq-mapping (a=
n
> > > array of objects) are silently dropped by qemu_opts_from_qdict() duri=
ng
> > > the QemuOpts conversion even though QAPI is capable of validating the=
m.
> > > As a result, hotplugging virtio-blk-pci devices with the
> > > iothread-vq-mapping property does not work as expected (the property =
is
> > > ignored). It's time to QAPIfy QMP device_add!
> >
> > This patch doesn't fully QAPIfy device_add: we still lack a schema
> > and use 'gen': false.  It gets us closer, though.
> >
> > > Get rid of the QemuOpts conversion in qmp_device_add() and call
> > > qdev_device_add_from_qdict() with from_json=3Dtrue. Using the QMP
> > > command's QDict arguments directly allows non-scalar properties.
> > >
> > > The HMP is also adjusted since qmp_device_add()'s now expects properl=
y
> > > typed JSON arguments and cannot be used from HMP anymore. Move the co=
de
> > > that was previously in qmp_device_add() (with QemuOpts conversion and
> > > from_json=3Dfalse) into hmp_device_add() so that its behavior is
> > > unchanged.
> > >
> > > This patch changes the behavior of QMP device_add but not HMP
> > > device_add. QMP clients that sent incorrectly typed device_add QMP
> > > commands no longer work. This is a breaking change but clients should=
 be
> > > using the correct types already. See the netdev_add QAPIfication in
> > > commit db2a380c8457 for similar reasoning.
> >
> > Another one is 9151e59a8b6e: it QAPIfied object-add.
> >
> > Both commits eliminated the roundtrip through QemuOpts, and weaned the
> > command off 'gen': false.
> >
> > This commit eliminates the roundtrip, but keeps 'gen': false.  Best we
> > can do now, but I'd like the commit message to make this clear.
> >
> > > Markus helped me figure this out and even provided a draft patch. The
> > > code ended up very close to what he suggested.
> > >
> > > Suggested-by: Markus Armbruster <armbru@redhat.com>
> > > Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > ---
> > >  system/qdev-monitor.c | 41 ++++++++++++++++++++++++++++-------------
> > >  1 file changed, 28 insertions(+), 13 deletions(-)
>
> [...]
>
> > Have a look at this TODO in vl.c:
> >
> >     QTAILQ_FOREACH(opt, &device_opts, next) {
> >         DeviceState *dev;
> >         loc_push_restore(&opt->loc);
> >         /*
> >          * TODO Eventually we should call qmp_device_add() here to make=
 sure it
> >          * behaves the same, but QMP still has to accept incorrectly ty=
ped
> >          * options until libvirt is fixed and we want to be strict on t=
he CLI
> >          * from the start, so call qdev_device_add_from_qdict() directl=
y for
> >          * now.
> >          */
>
> So at least this TODO should already be handled on libvirt's side.
>
> With modern qemu libvirt is using JSON for -device and exactly the same
> JSON for device_add. From what I remember from the time when I've
> converted -device to use JSON, -device already required the correct
> types, which would mean that also libvirt uses the correct types now.

Great, thank you. I will update the code.

Stefan

