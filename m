Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AAD3C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 13:54:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKIEL-00045r-2e; Thu, 20 Jun 2024 09:53:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sKIEJ-00045Q-IA
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 09:53:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sKIEH-0008GC-Km
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 09:53:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718891612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ELadgWAZEaqWW9tZAl/glDSzS0OKSd1Zx7ZGWRCWr3Q=;
 b=NQfupwR0t1zMN23U5v0vWn9nvmJOvEmI3Y1mYebvVWeQYZguHlXnKJ1Pe7o7OmtP1GUdPQ
 bhLXZb9Xm9FZ3h4n7La6vdzRHGDficctikd/Wf1nNckHtWYFBCEThiV1kBcIG/QsGgt4G7
 v4XKGDrVx+kAlCIwk4Kojm27yca233c=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-PR1jxBbxPteeT6OajhxgLg-1; Thu, 20 Jun 2024 09:53:31 -0400
X-MC-Unique: PR1jxBbxPteeT6OajhxgLg-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-62fa71fbfc4so17386367b3.2
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 06:53:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718891610; x=1719496410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ELadgWAZEaqWW9tZAl/glDSzS0OKSd1Zx7ZGWRCWr3Q=;
 b=g0Tre1GlRg5ncm2gdqmAPloglVym+efsRyG66T56DMueBnV/X6GecLFU7164cM/0Y+
 wof+Fw4JrnOdcM0/r36wuqNDMiXOl2wJ3m1kD3SP1HxUK5/I3yc7I91ocWmZAs1urvIk
 wU4kkuVzMJBpT0IcF7enAQKL7fPnwObvyUo5f8kYy9LVXkGtLgnMbIdje0Nxu7Dplem0
 SaIIB238Fk7WcPgkiNMhBYn3YOSw9ZRfFdAz3Fr6kXCOs6dptw/4k19DInSYMXQZSgG7
 Une7KhQrujVipN5Vi/GjLJXc+KfyfyFr+p0r9D3YiVsGaqQc0wRwteuKR6bEJ1n996E9
 NI7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU05T7KaBEnAQbhmF9JIQ6vkCNkTTWaq3aGLShRSzBFRpL5tKNA/Ch1mhE6lQT23i7LZyPX63nnkcvEcahxdQ3O0AUKlYU=
X-Gm-Message-State: AOJu0Yzjg7CgK88OYfoITTvlZ3W1snL+QImLNfYoIXuqzR2l1QfhIALS
 95IYmoTpvLnnES8N25CbhhlV8bDQH5zkyJg/0CJcI6qZ+vKsJhb0GG2+AxtG0GmXQWz2UC3OkXn
 oGG/irBocqJapxUPTswy3maqkjVCDTjcyAE36L3zjpOYm24fJqUvL
X-Received: by 2002:a0d:ead5:0:b0:62d:1139:779 with SMTP id
 00721157ae682-63a8d924c86mr49521147b3.19.1718891610542; 
 Thu, 20 Jun 2024 06:53:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtfQ5DqanAfpJBPJxkUnLssdQahDnVihRwBBiKXH6lf5Bj7oiF0e5+r7UYjKjoLVLMg/8www==
X-Received: by 2002:a0d:ead5:0:b0:62d:1139:779 with SMTP id
 00721157ae682-63a8d924c86mr49520827b3.19.1718891610167; 
 Thu, 20 Jun 2024 06:53:30 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b4ff61db92sm23720096d6.30.2024.06.20.06.53.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 06:53:29 -0700 (PDT)
Date: Thu, 20 Jun 2024 15:53:24 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1E?=
 =?UTF-8?B?YXVkw6k=?= <philmd@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau
 <marcandre.lureau@redhat.com>, "Daniel P . =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann
 <kraxel@redhat.com>, Alistair Francis <alistair23@gmail.com>, Sia Jee Heng
 <jeeheng.sia@starfivetech.com>, Haibo1 Xu <haibo1.xu@intel.com>, Anup Patel
 <apatel@ventanamicro.com>, Andrew Jones <ajones@ventanamicro.com>, Daniel
 Henrique Barboza <dbarboza@ventanamicro.com>, Peter Maydell
 <peter.maydell@linaro.org>, Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng
 <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v2 06/12] tests/data/acpi/virt: Move ACPI tables under
 aarch64
Message-ID: <20240620155324.1d7157f9@imammedo.users.ipa.redhat.com>
In-Reply-To: <ZnMcw2E83Voo1HBT@sunil-laptop>
References: <20240524061411.341599-1-sunilvl@ventanamicro.com>
 <20240524061411.341599-7-sunilvl@ventanamicro.com>
 <27cef750-262a-402a-97fe-c4a55700a376@linaro.org>
 <ZlSjzfSj8MwDcJk6@sunil-laptop>
 <20240619111743.58930119@imammedo.users.ipa.redhat.com>
 <20240619052043-mutt-send-email-mst@kernel.org>
 <ZnMcw2E83Voo1HBT@sunil-laptop>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, 19 Jun 2024 23:30:35 +0530
Sunil V L <sunilvl@ventanamicro.com> wrote:

> On Wed, Jun 19, 2024 at 05:20:50AM -0400, Michael S. Tsirkin wrote:
> > On Wed, Jun 19, 2024 at 11:17:43AM +0200, Igor Mammedov wrote: =20
> > > On Mon, 27 May 2024 20:46:29 +0530
> > > Sunil V L <sunilvl@ventanamicro.com> wrote:
> > >  =20
> > > > On Mon, May 27, 2024 at 12:12:10PM +0200, Philippe Mathieu-Daud=C3=
=A9 wrote: =20
> > > > > Hi Sunil,
> > > > >=20
> > > > > On 24/5/24 08:14, Sunil V L wrote:   =20
> > > > > > Since virt is a common machine name across architectures like A=
RM64 and
> > > > > > RISC-V, move existing ARM64 ACPI tables under aarch64 folder so=
 that
> > > > > > RISC-V tables can be added under riscv64 folder in future.
> > > > > >=20
> > > > > > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > > > > > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> > > > > > ---
> > > > > >   tests/data/acpi/virt/{ =3D> aarch64}/APIC             | Bin  =
 =20
> > > > >=20
> > > > > The usual pattern is {target}/{machine}, so instead of:
> > > > >=20
> > > > >   microvm/
> > > > >   pc/
> > > > >   q35/
> > > > >   virt/aarch64/
> > > > >   virt/riscv64/
> > > > >=20
> > > > > (which is odd because q35 is the x86 'virt'), I'd rather see:
> > > > >=20
> > > > >   x86/microvm/
> > > > >   x86/pc/
> > > > >   x86/q35/
> > > > >   aarch64/virt/
> > > > >   riscv64/virt/
> > > > >=20
> > > > > Anyhow just my 2 cents, up to the ACPI maintainers :)
> > > > >    =20
> > > > Hi Phil,
> > > >=20
> > > > Your suggestion does make sense to me. Let me wait for feedback from
> > > > ARM/ACPI maintainers. =20
> > >=20
> > > I'd prefer  {target}/{machine} hierarchy like Philippe suggests =20
> >=20
> > Agreed.
> >  =20
> Thanks for the confirmation!. Let me send the updated version soon.
>=20
> Moving pc/q35/microvm also under new x86 would need many changes in
> bios-table-test.c. So, the question is, are you ok to combine x86
> changes as well in this series or prefer to it later in separate series?

it should be fine ok to include x86 changes here as well.

I'd basically split previous patch on path altering part and a 2nd adding
 .arch =3D "aarch64"

then 3rd doing the same for x86

as for this patch, I'd include all blobs movement here.

>=20
> Thanks,
> Sunil
>=20


