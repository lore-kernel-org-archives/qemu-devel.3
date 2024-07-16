Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FBC7C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 14:34:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTjFk-0005CE-13; Tue, 16 Jul 2024 10:34:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sTjFi-00055e-Cf
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 10:34:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sTjFg-0000t6-EG
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 10:34:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721140438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z2VPQtBS+xun1o1WdBSq+3OeKZ9z8HE5BK0kVY5+MDw=;
 b=IhCSwzBkBywvWaaJIdV71FONbuHximLFPqDheQkz+R5lXRSWMamoCZm+P/6MzlLbP7b+bP
 Vf86WzIYPeHcvGDJNLr72o3FmaP9SGqdYor/KIzv0c/o7qPbx3EotwIoMt5OBjlMhmIIBl
 sBfe2BDLXQS2qBW+zG5wNfs3JuPZlSQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-06RSblLaPFSv11swA41ZiA-1; Tue, 16 Jul 2024 10:33:57 -0400
X-MC-Unique: 06RSblLaPFSv11swA41ZiA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-426679bc120so41406695e9.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 07:33:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721140431; x=1721745231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z2VPQtBS+xun1o1WdBSq+3OeKZ9z8HE5BK0kVY5+MDw=;
 b=OoCrbrZoI/OiVIKpvm/7ugQWOdZoHmy2DuWykEx3Qgj2Ba7p41G89Jg+rOQymZt+Eq
 UOimULbU+PCDHETwscSP0VXk4mPLfNLxTifAhCrGd5gysu8Ua1aHfwM3JCGM2/M8zXN5
 7yqx7Tw9Eh2cP8DvnaptpYgF86O0Cki6SHjBGaJ3ytF3QFiSRse/b4chqvjJQnK/YF3n
 s4nJ4a5PvLjT5fNs3cGEUY9Xv6Y/O+4y8k3utqI6yf07bxR3MhS2roecvHpQCPvF1Y2t
 a+ARINW2fBn8b5qVHzicFukOsXqQyDGnMtqM/OAyuM5Do17+FQ2uQJ+KexOYNCbLkEIX
 7Lfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXy48U6SopgDhKCndbiws8AUJGpEEVan3x4RZEzDMHItg1KjMBkmLdl4zs/eSOWyNk9YY1BhteQRmc5zSx0D+5zfyvalzA=
X-Gm-Message-State: AOJu0YzkEE00z36kz8t+x7S5pcBqPGNStzNkyicl4fxpNOgWv/YEHaAb
 X5ivw8wtnlVRyMLX3x51CRmnqAjDRKDWForEJSpSOxk4q02wIW6mNcqe+AaUshBrmFcjJ5tXENe
 Gtp18nNMnPIOI/emaTiYdKX2d33OcDEIrUhjJ5bM3C2PTY1JTfRTC
X-Received: by 2002:a05:600c:12c9:b0:427:9dad:181d with SMTP id
 5b1f17b1804b1-427ba684f2amr14261075e9.11.1721140431353; 
 Tue, 16 Jul 2024 07:33:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGn9UgaDarL/emNSFJ+ykKIIsSTbnd1yLdbTvYchpv8267RqZcjgaGCks56CBA/JFFTRtbrlA==
X-Received: by 2002:a05:600c:12c9:b0:427:9dad:181d with SMTP id
 5b1f17b1804b1-427ba684f2amr14260875e9.11.1721140430935; 
 Tue, 16 Jul 2024 07:33:50 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f2d6ef8sm162676905e9.39.2024.07.16.07.33.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 07:33:49 -0700 (PDT)
Date: Tue, 16 Jul 2024 16:33:48 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Daniel P. =?UTF-8?B?QmVycmFu?=
 =?UTF-8?B?Z8Op?=" <berrange@redhat.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, Alistair
 Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>, Weiwei
 Li <liwei1518@gmail.com>, Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Ani
 Sinha <anisinha@redhat.com>, atar4qemu@gmail.com, atar4qemu@gmail.com,
 thuth@redhat.com
Subject: Re: [PATCH v2 0/9] RISC-V: ACPI: Namespace updates
Message-ID: <20240716163348.3d179c93@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240716162807.3aa78399@imammedo.users.ipa.redhat.com>
References: <20240708114741.3499585-1-sunilvl@ventanamicro.com>
 <20240712144319.233c19a7@imammedo.users.ipa.redhat.com>
 <ZpEmuB6xyh2K77Ic@redhat.com>
 <20240712155010.3756bb82@imammedo.users.ipa.redhat.com>
 <20240714034105-mutt-send-email-mst@kernel.org>
 <20240715144352.22d36779@imammedo.users.ipa.redhat.com>
 <ZpZm48s9zt/glU/H@sunil-laptop>
 <20240716162807.3aa78399@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 16 Jul 2024 16:28:07 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> On Tue, 16 Jul 2024 17:56:11 +0530
> Sunil V L <sunilvl@ventanamicro.com> wrote:
>=20
> > On Mon, Jul 15, 2024 at 02:43:52PM +0200, Igor Mammedov wrote: =20
> > > On Sun, 14 Jul 2024 03:46:36 -0400
> > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > >    =20
> > > > On Fri, Jul 12, 2024 at 03:50:10PM +0200, Igor Mammedov wrote:   =20
> > > > > On Fri, 12 Jul 2024 13:51:04 +0100
> > > > > Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> > > > >      =20
> > > > > > On Fri, Jul 12, 2024 at 02:43:19PM +0200, Igor Mammedov wrote: =
    =20
> > > > > > > On Mon,  8 Jul 2024 17:17:32 +0530
> > > > > > > Sunil V L <sunilvl@ventanamicro.com> wrote:
> > > > > > >        =20
> > > > > > > > This series adds few updates to RISC-V ACPI namespace for v=
irt platform.
> > > > > > > > Additionally, it has patches to enable ACPI table testing f=
or RISC-V.
> > > > > > > >=20
> > > > > > > > 1) PCI Link devices need to be created outside the scope of=
 the PCI root
> > > > > > > > complex to ensure correct probe ordering by the OS. This ma=
tches the
> > > > > > > > example given in ACPI spec as well.
> > > > > > > >=20
> > > > > > > > 2) Add PLIC and APLIC as platform devices as well to ensure=
 probing
> > > > > > > > order as per BRS spec [1] requirement.
> > > > > > > >=20
> > > > > > > > 3) BRS spec requires RISC-V to use new ACPI ID for the gene=
ric UART. So,
> > > > > > > > update the HID of the UART.
> > > > > > > >=20
> > > > > > > > 4) Enabled ACPI tables tests for RISC-V which were original=
ly part of
> > > > > > > > [2] but couldn't get merged due to updates required in the =
expected AML
> > > > > > > > files. I think combining those patches with this series mak=
es it easier
> > > > > > > > to merge since expected AML files are updated.
> > > > > > > >=20
> > > > > > > > [1] - https://github.com/riscv-non-isa/riscv-brs
> > > > > > > > [2] - https://lists.gnu.org/archive/html/qemu-devel/2024-06=
/msg04734.html       =20
> > > > > > >=20
> > > > > > > btw: CI is not happy about series, see:
> > > > > > >  https://gitlab.com/imammedo/qemu/-/pipelines/1371119552
> > > > > > > also 'cross-i686-tci' job routinely timeouts on bios-tables-t=
est
> > > > > > > but we still keep adding more tests to it.
> > > > > > > We should either bump timeout to account for slowness or
> > > > > > > disable bios-tables-test for that job.       =20
> > > > > >=20
> > > > > > Asumming the test is functionally correct, and not hanging, the=
n bumping
> > > > > > the timeout is the right answer. You can do this in the meson.b=
uild
> > > > > > file     =20
> > > > >=20
> > > > > I think test is fine, since once in a while it passes (I guess it=
 depends on runner host/load)
> > > > >=20
> > > > > Overal job timeout is 1h, but that's not what fails.
> > > > > What I see is, the test aborts after 10min timeout.
> > > > > it's likely we hit boot_sector_test()/acpi_find_rsdp_address_uefi=
() timeout.
> > > > > That's what we should try to bump.
> > > > >=20
> > > > > PS:
> > > > > I've just started the job with 5min bump, lets see if it is enoug=
h.     =20
> > > >=20
> > > > Because we should wait for 5min CPU time, not wall time.
> > > > Why don't we do that?
> > > > Something like getrusage should work I think.
> > > >    =20
> > >=20
> > > It turned out to be a meson timeout that's set individually per test =
file.
> > > I'll send a patch later on.
> > >    =20
> > Hi Igor,
> >=20
> > I am unable to get msys2-64bit test in CI to pass. I tried including
> > your change in meson as well but no luck. I can't guess how enabling
> > bios-tables-test for RISC-V is affecting this particular test. Does this
> > pass for you?=20
> >=20
> > https://gitlab.com/vlsunil/qemu/-/jobs/7343701148 =20
>=20
> it doesn't pass for me either,
> but bios-tables-test is not among those that timed out,
> so I'd ignore failure in this case

as in your case it was sparc target tests that timed out:
https://gitlab.com/imammedo/qemu/-/jobs/7352989984

CCIng sparc folks as well

>=20
> >=20
> > Thanks!
> > Sunil
> >  =20
>=20


